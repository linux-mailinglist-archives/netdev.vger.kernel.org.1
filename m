Return-Path: <netdev+bounces-25601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A67774E2C
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 00:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15D828195F
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 22:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6F218043;
	Tue,  8 Aug 2023 22:21:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223F414F91
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 22:21:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F09EC433C8;
	Tue,  8 Aug 2023 22:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691533269;
	bh=NDFN2pgEa49j+rEEd6Sj9w7Rnzy7oKqpbyl2h0n3jb8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=e7A4xs/FHRVNaDB8lOLK7TNhy6TkwegCHEJULMQBFdAnuLMiJI2m3Ch6h4C+m55WN
	 eA3W8DC66qXvKFDlEAbHSJ2fgRHYNaDl8NKuIzBl9DNXH33x91vWh220gjRmNzhfiE
	 oABdnITC5XBNl6OvmE5YIoGsInhzXhPDkGuY4RcbxIuTMEg38BISP48wyajdQz+807
	 aRU022/Y6ZdXmsuVOdx7LDLXzaRRbwYCtol0XgRu3dfz26whtJRVg6OOtARyY/J2S1
	 AcKZkohLikkGbe1yrHOdLUUAoLPtjtkjsXleST1hOfYETA2NnaaNdtRvVpuoVNVd03
	 jN+ODYhfYp46g==
Date: Tue, 8 Aug 2023 17:21:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-pci@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Liu Peibao <liupeibao@loongson.cn>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v2 pci/net 1/3] PCI: move OF status = "disabled"
 detection to dev->match_driver
Message-ID: <20230808222107.GA331664@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803135858.2724342-2-vladimir.oltean@nxp.com>

On Thu, Aug 03, 2023 at 04:58:56PM +0300, Vladimir Oltean wrote:
> The blamed commit has broken probing on
> arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi when &enetc_port0
> (PCI function 0) has status = "disabled".
> 
> Background: pci_scan_slot() has logic to say that if the function 0 of a
> device is absent, the entire device is absent and we can skip the other
> functions entirely. Traditionally, this has meant that
> pci_bus_read_dev_vendor_id() returns an error code for that function.
> 
> However, since the blamed commit, there is an extra confounding
> condition: function 0 of the device exists and has a valid vendor id,
> but it is disabled in the device tree. In that case, pci_scan_slot()
> would incorrectly skip the entire device instead of just that function.
> 
> In the case of NXP LS1028A, status = "disabled" does not mean that the
> PCI function's config space is not available for reading. It is, but the
> Ethernet port is just not functionally useful with a particular SerDes
> protocol configuration (0x9999) due to pinmuxing constraints of the Soc.
> So, pci_scan_slot() skips all other functions on the ENETC ECAM
> (enetc_port1, enetc_port2, enetc_mdio_pf3 etc) when just enetc_port0 had
> to not be probed.
> 
> There is an additional regression introduced by the change, caused by
> its fundamental premise. The enetc driver needs to run code for all PCI
> functions, regardless of whether they're enabled or not in the device
> tree. That is no longer possible if the driver's probe function is no
> longer called. But Rob recommends that we move the of_device_is_available()
> detection to dev->match_driver, and this makes the PCI fixups still run
> on all functions, while just probing drivers for those functions that
> are enabled. So, a separate change in the enetc driver will have to move
> the workarounds to a PCI fixup.

I think this makes good sense, but let me make sure I understand how
this works.

I *think* what's happening is that this Function 0 responds to config
reads, so PCI enumeration starts by discovering it normally.  But
after 6fffbc7ae137 ("PCI: Honor firmware's device disabled status"),
we abort in pci_setup_device() if the DT or ACPI status is "disabled,"
which means there's no struct pci_dev for it, no quirks can run on it,
and no driver can bind to it.  And, since PCI multi-function devices
must have a Function 0, we don't enumerate the other functions of this
device.

That's a problem because (1) you need to do some initialization on
Function 0 even though you don't want a driver to claim it, and (2)
this is a multi-function device and you need to enumerate the other
functions.

What this patch does is make it so the PCI core enumerates Function 0
normally so there will be a struct pci_dev for it, the normal config
space access to it will work, and it will appear in the dmesg log and
lspci output, all as usual.  But if the DT or ACPI status is
"disabled", we will not bind a PCI driver to it.

If that's true, I'd like to highlight the PCI details here and move
some of the device-specific things to the driver patches, e.g.,
something like this:

  PCI: Enumerate device but don't bind driver if firmware status is 'disabled'

  In some configurations, the NXP LS1028A has a multi-function NIC
  where Function 0 is not usable as a NIC, but it's accessible via
  config space and it's needed for device-specific initialization.
  Function 0 also indicates that the NIC is a multi-function device
  and the kernel should look for more functions.

  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi marks Function 0 as
  "disabled," and after 6fffbc7ae137 ("PCI: Honor firmware's device
  disabled status"), Linux doesn't enumerate Function 0, which means
  the entire NIC is unusable because Linux doesn't enumerate the other
  functions either.

  Instead of completely ignoring a function with DT/ACPI "disabled"
  status, enumerate it as usual but prevent drivers from claiming it.
  The disabled function will still be accessible via config space,
  fixups will work, and it will be visible via lspci.

So feel free to merge this along with the other patches via the net
tree with:

  Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> Fixes: 6fffbc7ae137 ("PCI: Honor firmware's device disabled status")
> Link: https://lore.kernel.org/netdev/CAL_JsqLsVYiPLx2kcHkDQ4t=hQVCR7NHziDwi9cCFUFhx48Qow@mail.gmail.com/
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/pci/bus.c | 4 +++-
>  drivers/pci/of.c  | 5 -----
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 5bc81cc0a2de..46b252bbe500 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -11,6 +11,7 @@
>  #include <linux/pci.h>
>  #include <linux/errno.h>
>  #include <linux/ioport.h>
> +#include <linux/of.h>
>  #include <linux/proc_fs.h>
>  #include <linux/slab.h>
>  
> @@ -332,6 +333,7 @@ void __weak pcibios_bus_add_device(struct pci_dev *pdev) { }
>   */
>  void pci_bus_add_device(struct pci_dev *dev)
>  {
> +	struct device_node *dn = dev->dev.of_node;
>  	int retval;
>  
>  	/*
> @@ -344,7 +346,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>  	pci_proc_attach_device(dev);
>  	pci_bridge_d3_update(dev);
>  
> -	dev->match_driver = true;
> +	dev->match_driver = !dn || of_device_is_available(dn);
>  	retval = device_attach(&dev->dev);
>  	if (retval < 0 && retval != -EPROBE_DEFER)
>  		pci_warn(dev, "device attach failed (%d)\n", retval);
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index e51219f9f523..3c158b17dcb5 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -34,11 +34,6 @@ int pci_set_of_node(struct pci_dev *dev)
>  	if (!node)
>  		return 0;
>  
> -	if (!of_device_is_available(node)) {
> -		of_node_put(node);
> -		return -ENODEV;
> -	}
> -
>  	device_set_node(&dev->dev, of_fwnode_handle(node));
>  	return 0;
>  }
> -- 
> 2.34.1
> 

