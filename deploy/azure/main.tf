# This configuration has been generated by the Azure deployments handler which utilizes Generative AI which may result in unintended or inaccurate configuration code. A human must validate that this configuration accomplishes the desired goal before applying the configuration.

provider "azurerm" {
  features {}
}

variable "az_webapp_name" {
  type    = string
  default = ""
}

variable "az_rg_name" {
  type    = string
  default = "webapp-itk-rg"
}

variable "location" {
  type    = string
  default = "East US"
}

variable "az_asp_name" {
  type    = string
  default = "webapp-itk-appserviceplan"
}

variable "ghcr_image" {
  type    = string
  default = "microsoft/intelligence-toolkit:latest"
}

resource "azurerm_resource_group" "az_rg" {
  name     = var.az_rg_name
  location = var.location
}

resource "azurerm_service_plan" "az_asp" {
  os_type="Linux"
  name                = var.az_asp_name
  location            = azurerm_resource_group.az_rg.location
  resource_group_name = azurerm_resource_group.az_rg.name

  sku_name = "B3"
}

resource "azurerm_linux_web_app" "az_webapp" {
  name                = var.az_webapp_name
  location            = azurerm_resource_group.az_rg.location
  resource_group_name = azurerm_resource_group.az_rg.name
  service_plan_id     = azurerm_service_plan.az_asp.id
  https_only          = true

  site_config {
    application_stack {
      docker_image_name = "${var.ghcr_image}"
      docker_registry_url = "https://ghcr.io"

    }
  }

}
