Return-Path: <netdev+bounces-93457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B23378BBE17
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 22:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99F7F1C20A85
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 20:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C55F7E76F;
	Sat,  4 May 2024 20:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSnXBNcM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BD717578
	for <netdev@vger.kernel.org>; Sat,  4 May 2024 20:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714855590; cv=none; b=sK+mbizjTauqOB9Rh3FgrtQpJya+9tULWTlNjVOsCF2hR5tuJeRlzOvGg0RARkoEmaBfP+bEGKjk9gCEMEtJ2lXeFPSvm8Ok2tlKan3ESNYykNjg+kWexrnhijuPLA0yYeh1ERyfzsXrI2z5tRqb+hzwRJG7To/GPD0bDy+84VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714855590; c=relaxed/simple;
	bh=uF71X1wjJuVzTAH+kPs/6m/DpSdqTPuCf+6nz8NSl/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcvijVcXtJR/Ea0ahlCJQ3rwdlY0bGnavZqyAibB3BgN+L2cR31o8SsjWJzn1q04PFFM7sB8KIRZG9swA8hwdCk07FPL4GT2RC5WbR8XpSFC/N6/IyttgPCz4AvpKDPSPetSIjmZ9muQBLyQaoDpJ2p+ArHcEcmjRK4J+vs13Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSnXBNcM; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51ae2e37a87so947475e87.2
        for <netdev@vger.kernel.org>; Sat, 04 May 2024 13:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714855586; x=1715460386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqR/rUJNKebh5duVavSsPr6nrDjc1sQCzOdHJfya9QM=;
        b=nSnXBNcManKJm2dKbLsi19JvvOa2hA1DN9LENPWwQkb3+88aP6BouD3LQnIMzS4rcb
         ji399uskDd6WKM4Vd4MFpdWdok5l2qEwap6AXqIC3bsWV+nF19mF4yVzZfNcU6fsuJ2w
         nHts5vy6LEwpR6IVz7pLUrSWTE5RYiP+3M24JEJ6liYAImWy1j/WfEdp5vsv5sK1r1+Q
         ynatp76p8WKGGudiF6TEEljRXc8pxoB6kcJYS5yCHq7/VgPEtlWwCqzcRzVePM+MzKdy
         4cwdjGqs96KljFYmaw2n3GFiVAjK3t8dbKrBd0R7sTjtCNoGatpFikPkdoNNjnLKrbFY
         htKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714855586; x=1715460386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqR/rUJNKebh5duVavSsPr6nrDjc1sQCzOdHJfya9QM=;
        b=WUo9zOdgw66Rt0E+BMh2IcT0Yq90L4RyP5HBxubex/3k6DC9V5dv9qgCpYG5YRnmIF
         Q0V12VdbAFW8ENbSHt2EX/GV6g8cxhIDgCtKJu9eRosbkj50x8mqw/ALj6BhV0lDhOV4
         QDLnP8HbrtVMgqMBTOGteGs+U7Yji032RJ0QkUh4AoPTvimnKzR69J34QnhqnSNbr2/y
         L5dugwer++FX1sBujkrvp12miltPX0VkaxqzbWXbh4ZbEIgLtzxVmOr5bT35kPpdRHWO
         OeiGNcorDEbm8VgvYHR7Nm6ffHDtTTXj2/tS3up+zvA+5RG+mh+W33Iab6ePERldN/P+
         pagQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOu3/Pw08SnMip7ehVOMZtZAolh8ra2M5dZZ5xSksi+Acio55x9pSHhwpEgx5UL6mOAylVt7XaWJWNaGWsY8F93BOPT2pM
X-Gm-Message-State: AOJu0YzN5mMONWgbN71yQJWsJs7SiC1v5oaKeTp1Qu8wDs+PjE927s75
	B6OsivQAMt0mplpPa1962stpdg30JLHx+bndAuLxFzgZwKuNGxnS
X-Google-Smtp-Source: AGHT+IGljUDP3B88m/qV1vhbUVldLi9b+I2rnAwNj9+qzVTUMDpWWggb34o9YM/pr01XCRnIH8bcsQ==
X-Received: by 2002:a05:6512:20c6:b0:518:a89f:bfa5 with SMTP id u6-20020a05651220c600b00518a89fbfa5mr4374103lfr.30.1714855586125;
        Sat, 04 May 2024 13:46:26 -0700 (PDT)
Received: from mobilestation ([95.79.182.53])
        by smtp.gmail.com with ESMTPSA id c3-20020ac244a3000000b0051d913a3695sm996785lfm.182.2024.05.04.13.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 13:46:25 -0700 (PDT)
Date: Sat, 4 May 2024 23:46:23 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add full
 PCI support
Message-ID: <rvz3ebfbxuz4fq34epujowab5tyf4o2uhvrcc2bqzla6odxfnl@aqypyjpr6awj>
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <d3bad82c41964925f9284ccdd8ec07160cac5519.1714046812.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3bad82c41964925f9284ccdd8ec07160cac5519.1714046812.git.siyanteng@loongson.cn>

> [PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add full PCI support

I would have changed the subject to:

net: stmmac: dwmac-loongson: Add DT-less GMAC PCI-device support

On Thu, Apr 25, 2024 at 09:10:35PM +0800, Yanteng Si wrote:
> Current dwmac-loongson only support LS2K in the "probed with PCI and
> configured with DT" manner. Add LS7A support on which the devices are
> fully PCI (non-DT).
> 
> Others:
> LS2K is a SoC and LS7A is a bridge chip.

The text seems like misleading or just wrong. I see both of these
platforms having the GMAC defined in the DT source:

arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
arch/mips/boot/dts/loongson/ls7a-pch.dtsi

What do I miss in your description?

If nothing has been missed and it's just wrong I suggest to convert
the commit log to something like this:

"The Loongson GMAC driver currently supports the network controllers
installed on the LS2K1000 SoC and LS7A1000 chipset, for which the GMAC
devices are required to be defined in the platform device tree source.
Let's extend the driver functionality with the case of having the
Loongson GMAC probed on the PCI bus with no device tree node defined
for it. That requires to make the device DT-node optional, to rely on
the IRQ line detected by the PCI core and to have the MDIO bus ID
calculated using the PCIe Domain+BDF numbers."


> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 113 ++++++++++--------
>  1 file changed, 65 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index e989cb835340..1022bceaa680 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -11,8 +11,17 @@
>  
>  #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
>  
> -static void loongson_default_data(struct plat_stmmacenet_data *plat)

> +struct stmmac_pci_info {
> +	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
> +};

Please move this and the rest of the setup-callback introduction
change into a separate patch. It' subject could be something like
this:
net: stmmac: dwmac-loongson: Introduce PCI device info data

> +
> +static void loongson_default_data(struct pci_dev *pdev,
> +				  struct plat_stmmacenet_data *plat)
>  {

> +	/* Get bus_id, this can be overloaded later */

s/overloaded/overwritten

> +	plat->bus_id = (pci_domain_nr(pdev->bus) << 16) |

> +			PCI_DEVID(pdev->bus->number, pdev->devfn);

Em, so you removed the code from the probe() function:
-     plat->bus_id = of_alias_get_id(np, "ethernet");
-     if (plat->bus_id < 0)
-             plat->bus_id = pci_dev_id(pdev);
and instead of using the pci_dev_id() method here just opencoded it'
content. Nice. Why not to use pci_dev_id() instead of PCI_DEVID()?

> +
>  	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
>  	plat->has_gmac = 1;
>  	plat->force_sf_dma_mode = 1;
> @@ -44,9 +53,10 @@ static void loongson_default_data(struct plat_stmmacenet_data *plat)
>  	plat->multicast_filter_bins = 256;
>  }
>  
> -static int loongson_gmac_data(struct plat_stmmacenet_data *plat)
> +static int loongson_gmac_data(struct pci_dev *pdev,
> +			      struct plat_stmmacenet_data *plat)
>  {
> -	loongson_default_data(plat);
> +	loongson_default_data(pdev, plat);
>  
>  	plat->mdio_bus_data->phy_mask = 0;
>  	plat->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
> @@ -54,20 +64,20 @@ static int loongson_gmac_data(struct plat_stmmacenet_data *plat)
>  	return 0;
>  }
>  

> +static struct stmmac_pci_info loongson_gmac_pci_info = {
> +	.setup = loongson_gmac_data,
> +};
> +

To the separate patch please.

>  static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct plat_stmmacenet_data *plat;

> +	int ret, i, bus_id, phy_mode;
> +	struct stmmac_pci_info *info;
>  	struct stmmac_resources res;
>  	struct device_node *np;
> -	int ret, i, phy_mode;

You can drop the bus_id and phy_mode variables, and use ret in the
respective statements instead.

>  
>  	np = dev_of_node(&pdev->dev);
>  
> -	if (!np) {
> -		pr_info("dwmac_loongson_pci: No OF node\n");
> -		return -ENODEV;
> -	}
> -
>  	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
>  	if (!plat)
>  		return -ENOMEM;
> @@ -78,12 +88,6 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	if (!plat->mdio_bus_data)
>  		return -ENOMEM;
>  
> -	plat->mdio_node = of_get_child_by_name(np, "mdio");
> -	if (plat->mdio_node) {
> -		dev_info(&pdev->dev, "Found MDIO subnode\n");
> -		plat->mdio_bus_data->needs_reset = true;
> -	}
> -
>  	plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg), GFP_KERNEL);
>  	if (!plat->dma_cfg) {
>  		ret = -ENOMEM;
> @@ -107,46 +111,59 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  		break;
>  	}
>  
> -	plat->bus_id = of_alias_get_id(np, "ethernet");
> -	if (plat->bus_id < 0)
> -		plat->bus_id = pci_dev_id(pdev);
> +	pci_set_master(pdev);
>  
> -	phy_mode = device_get_phy_mode(&pdev->dev);
> -	if (phy_mode < 0) {
> -		dev_err(&pdev->dev, "phy_mode not found\n");
> -		ret = phy_mode;

> +	info = (struct stmmac_pci_info *)id->driver_data;
> +	ret = info->setup(pdev, plat);
> +	if (ret)
>  		goto err_disable_device;

To the separate patch please.

> -	}
>  
> -	plat->phy_interface = phy_mode;
> -
> -	pci_set_master(pdev);
> +	if (np) {
> +		plat->mdio_node = of_get_child_by_name(np, "mdio");
> +		if (plat->mdio_node) {
> +			dev_info(&pdev->dev, "Found MDIO subnode\n");
> +			plat->mdio_bus_data->needs_reset = true;
> +		}
> +

> +		bus_id = of_alias_get_id(np, "ethernet");
> +		if (bus_id >= 0)
> +			plat->bus_id = bus_id;

		ret = of_alias_get_id(np, "ethernet");
		if (ret >= 0)
			plat->bus_id = ret;

> +

> +		phy_mode = device_get_phy_mode(&pdev->dev);
> +		if (phy_mode < 0) {
> +			dev_err(&pdev->dev, "phy_mode not found\n");
> +			ret = phy_mode;
> +			goto err_disable_device;
> +		}
> +		plat->phy_interface = phy_mode;

		ret = device_get_phy_mode(&pdev->dev);
		if (ret < 0) {
			dev_err(&pdev->dev, "phy_mode not found\n");
			goto err_disable_device;
		}
		
		plat->phy_interface = ret;

* note empty line between the if-clause and the last statement.

> +
> +		res.irq = of_irq_get_byname(np, "macirq");
> +		if (res.irq < 0) {
> +			dev_err(&pdev->dev, "IRQ macirq not found\n");
> +			ret = -ENODEV;
> +			goto err_disable_msi;
> +		}
> +
> +		res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
> +		if (res.wol_irq < 0) {
> +			dev_info(&pdev->dev, "IRQ eth_wake_irq not found, using macirq\n");
> +			res.wol_irq = res.irq;
> +		}
> +
> +		res.lpi_irq = of_irq_get_byname(np, "eth_lpi");
> +		if (res.lpi_irq < 0) {
> +			dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
> +			ret = -ENODEV;
> +			goto err_disable_msi;
> +		}
> +	} else {
> +		res.irq = pdev->irq;
> +	}
>  

> -	loongson_gmac_data(plat);

To the separate patch please.

>  	pci_enable_msi(pdev);
>  	memset(&res, 0, sizeof(res));
>  	res.addr = pcim_iomap_table(pdev)[0];
>  
> -	res.irq = of_irq_get_byname(np, "macirq");
> -	if (res.irq < 0) {
> -		dev_err(&pdev->dev, "IRQ macirq not found\n");
> -		ret = -ENODEV;
> -		goto err_disable_msi;
> -	}
> -
> -	res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
> -	if (res.wol_irq < 0) {
> -		dev_info(&pdev->dev, "IRQ eth_wake_irq not found, using macirq\n");
> -		res.wol_irq = res.irq;
> -	}
> -
> -	res.lpi_irq = of_irq_get_byname(np, "eth_lpi");
> -	if (res.lpi_irq < 0) {
> -		dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
> -		ret = -ENODEV;
> -		goto err_disable_msi;
> -	}
> -
>  	plat->tx_queues_to_use = 1;
>  	plat->rx_queues_to_use = 1;
>  
> @@ -224,7 +241,7 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
>  			 loongson_dwmac_resume);
>  
>  static const struct pci_device_id loongson_dwmac_id_table[] = {
> -	{ PCI_DEVICE_DATA(LOONGSON, GMAC, NULL) },

> +	{ PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },

To the separate patch please.

-Serge(y)

>  	{}
>  };
>  MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
> -- 
> 2.31.4
> 

