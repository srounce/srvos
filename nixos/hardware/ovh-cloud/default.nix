{ modulesPath, ... }:
{
  imports = [
    (modulesPath + "/profiles/base.nix")
    ../../mixins/cloud-init.nix
  ];

  boot.initrd.availableKernelModules = [
    "nvme"

    "virtio_net"
    "virtio_pci"
    "virtio_mmio"
    "virtio_blk"
    "virtio_scsi"
    "virtio_balloon"
    "virtio_console"

    "vmw_balloon"
    "vmw_vmci"
    "vmwgfx"
    "vmw_vsock_vmci_transport"

    "hv_storvsc"
  ];

  systemd.network.enable = true;
  systemd.network.networks."10-uplink" = {
    enable = true;
    matchConfig.Name = "ens*";
    networkConfig = {
      DHCP = "ipv4";
      IPv6AcceptRA = true;
    };
    linkConfig.RequiredForOnline = "routable";
  };

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
}
