Return-Path: <netdev+bounces-108380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECC9923A39
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 11:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71371C20A69
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 09:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5971514DA;
	Tue,  2 Jul 2024 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1LtAlAV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604C713D8BA
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719912921; cv=none; b=LAb2sEatWU2PFMQL62gkmQkN8o32tPybRLGS69/Lsj6raUFqCJ8vogmxiwC5sqQ2a+PKBQIUsRKYnym+cCQGqt2myBfORKcfGF9lF/3qTvI0mp/CY5Ocr+N5g2+NekEG/KKhi2Iv1ig+U2vY0HbN4MG8SkU64CbWqurG1r4w4q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719912921; c=relaxed/simple;
	bh=d1da/dRta5x9CdlVhWHu9jyM3DUUQf7XORIjxdllyXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RE8C+H/PjoYvDkdXRbgVu/FCpthV4/tCSLj5/sGNhG7Me863s4vapNffZ1qQPGybu6EeIPq+uAmZD2seYkZBUbdXGwWBBRDEQZjJ1QftJByJqrE44IpKasyI3R+qJltCVCw0agA6lNzxHCNOE9hcs5IIsRzrk8Xk/hVVSZ4sKjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1LtAlAV; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ee7885aa5fso3128601fa.1
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 02:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719912917; x=1720517717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qDX2qJcycl2/B6SEtIrwhTXx84w88y3B2VAOr46L+vY=;
        b=R1LtAlAVmIx5iuW4o9vNZxkjAi9r7czU78pPCA88FHJh3/4HQfVDd28ZvQfO3JmwIL
         J78/bDLDKUcKko7qT5Id70UY3o4B6yy4oz7kP6AJPzTRZ45CysNwz8mKP1SvTXve3E15
         y4guxsZsylabV/h9XuUdXonfw2QwBqPpvE/hf8wCmC2w92n+1IbIgksGX7j3xSR1s+cq
         JU74jsGabqvk0UhKqdMQ0VRSo3scAP2XZ443TDBGqynucwRMwO1+L5vOfRYViw6OJUyV
         VEIbgtMJJ1v80rrMTZ8+a4RjP6b25DkA4KPPs1lnoIImN/TxFcTDO3CNk0IJnIrEpan4
         1wIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719912917; x=1720517717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDX2qJcycl2/B6SEtIrwhTXx84w88y3B2VAOr46L+vY=;
        b=jtnJTnwSiyao0VrtCgKBn+6LMCNpLsF2JFjWS+BqZTmbkdOaEPWJe3tQZLTx8LdxLE
         pLIK4okVahbEYvbESR7vqwgilVwBUV30m7exLUwCDBMiODwyEIcwlT/SobFltNI9lgaV
         Y2b9YXHPPtrlN2TzzwWNthp98pX/lZtiuo33iIZ5FRk71OlCa8YfRiInF865aH3b5dky
         bowYlE/2/fF8rh8Ru4m6p/CLWPC5NRk2GXmyUdzbedQEhwSRaj0KfvPh1NkzQLEzpPRY
         2tUe2XSggeC2+N6+9IjusbewbUrgdu2G60whS0Qz0iE65KMeqpWR8sX78pV4lijMQM2b
         KpSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxnpxvfV9OpsQILHZ+/ni33+HZ9eWtM3VDxoA/ntjvZa8lHk696yeKiU+7cYVNFT5NxngZ7Vat4hsdgDVG31y9HQSgcbIA
X-Gm-Message-State: AOJu0YzFS8heRARnYRc+xK2aOfIjTXbnAwYg4s0IiCI61wFOXat18z9x
	mWaPmUDJmFENNSIBk4ddoEVsS12e8+SHoHlDyKpFE53pLiCCqShJ
X-Google-Smtp-Source: AGHT+IF4mi8tg8mFHmlGl/vqYGbWQm3uo11z0Cp4RhK02iZR7ii7O6j+SuF0pT+pTfeB/zD09FowMQ==
X-Received: by 2002:a05:651c:889:b0:2ec:4acf:97dc with SMTP id 38308e7fff4ca-2ee5e337975mr64774581fa.11.1719912916716;
        Tue, 02 Jul 2024 02:35:16 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee5160e72csm15919551fa.23.2024.07.02.02.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 02:35:16 -0700 (PDT)
Date: Tue, 2 Jul 2024 12:35:13 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Subject: Re: [PATCH net-next v13 10/15] net: stmmac: dwmac-loongson: Add
 DT-less GMAC PCI-device support
Message-ID: <glm3jfqf36t5vnkmk4gsdqfx53ga7ohs3pxnsizqlogkbim7gg@a3dxav5siczn>
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <fa22df795219256b093659195c4609445a175a1d.1716973237.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa22df795219256b093659195c4609445a175a1d.1716973237.git.siyanteng@loongson.cn>

On Wed, May 29, 2024 at 06:20:26PM +0800, Yanteng Si wrote:
> The Loongson GMAC driver currently supports the network controllers
> installed on the LS2K1000 SoC and LS7A1000 chipset, for which the GMAC
> devices are required to be defined in the platform device tree source.
> Let's extend the driver functionality with the case of having the
> Loongson GMAC probed on the PCI bus with no device tree node defined
> for it. That requires to make the device DT-node optional, to rely on
> the IRQ line detected by the PCI core and to have the MDIO bus ID
> calculated using the PCIe Domain+BDF numbers.

We need to mention the ACPI-part here. Like this:

"The Loongson GMAC driver currently supports the network controllers
installed on the LS2K1000 SoC and LS7A1000 chipset, for which the GMAC
devices are required to be defined in the platform device tree source.
But Loongson machines may have UEFI (implies ACPI) or PMON/UBOOT
(implies FDT) as the system bootloaders. In order to have both system
configurations support let's extend the driver functionality with the
case of having the Loongson GMAC probed on the PCI bus with no device
tree node defined for it. That requires to make the device DT-node
optional, to rely on the IRQ line detected by the PCI core and to
have the MDIO bus ID calculated using the PCIe Domain+BDF numbers."

This shall well justify the change introduced in this patch and in the
patch "net: stmmac: dwmac-loongson: Add loongson_dwmac_dt_config"
which content I suggest to merge in into this one.

> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 105 +++++++++---------
>  1 file changed, 53 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index fec2aa0607d4..8bcf9d522781 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -12,11 +12,15 @@
>  #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
>  
>  struct stmmac_pci_info {
> -	int (*setup)(struct plat_stmmacenet_data *plat);
> +	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
>  };
>  
> -static void loongson_default_data(struct plat_stmmacenet_data *plat)
> +static void loongson_default_data(struct pci_dev *pdev,
> +				  struct plat_stmmacenet_data *plat)
>  {
> +	/* Get bus_id, this can be overwritten later */
> +	plat->bus_id = pci_dev_id(pdev);
> +
>  	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
>  	plat->has_gmac = 1;
>  	plat->force_sf_dma_mode = 1;
> @@ -49,9 +53,10 @@ static void loongson_default_data(struct plat_stmmacenet_data *plat)
>  	plat->dma_cfg->pblx8 = true;
>  }
>  
> -static int loongson_gmac_data(struct plat_stmmacenet_data *plat)
> +static int loongson_gmac_data(struct pci_dev *pdev,
> +			      struct plat_stmmacenet_data *plat)
>  {
> -	loongson_default_data(plat);
> +	loongson_default_data(pdev, plat);
>  
>  	plat->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
>  
> @@ -68,15 +73,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	struct stmmac_pci_info *info;
>  	struct stmmac_resources res;
>  	struct device_node *np;
> -	int ret, i, phy_mode;
> +	int ret, i;
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
> @@ -87,17 +87,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
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
> -	if (!plat->dma_cfg) {
> -		ret = -ENOMEM;
> -		goto err_put_node;
> -	}
> +	if (!plat->dma_cfg)
> +		return -ENOMEM;
>  
>  	/* Enable pci device */
>  	ret = pci_enable_device(pdev);
> @@ -117,49 +109,58 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	}
>  
>  	info = (struct stmmac_pci_info *)id->driver_data;
> -	ret = info->setup(plat);
> +	ret = info->setup(pdev, plat);
>  	if (ret)
>  		goto err_disable_device;
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
> -		goto err_disable_device;
> -	}
> +	if (np) {
> +		plat->mdio_node = of_get_child_by_name(np, "mdio");
> +		if (plat->mdio_node) {
> +			dev_info(&pdev->dev, "Found MDIO subnode\n");
> +			plat->mdio_bus_data->needs_reset = true;
> +		}
>  
> -	plat->phy_interface = phy_mode;
> +		ret = of_alias_get_id(np, "ethernet");
> +		if (ret >= 0)
> +			plat->bus_id = ret;
>  
> -	pci_set_master(pdev);
> +		ret = device_get_phy_mode(&pdev->dev);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "phy_mode not found\n");
> +			goto err_disable_device;
> +		}
> +
> +		plat->phy_interface = ret;
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

Please merge in the patch:
[PATCH net-next v13 11/15] net: stmmac: dwmac-loongson: Add loongson_dwmac_dt_config
content into this one and introduce the method:

static int loongson_dwmac_acpi_config(struct pci_dev *pdev,
				      struct plat_stmmacenet_data *plat,
				      struct stmmac_resources *res)
{
	if (!pdev->irq)
		return -EINVAL;

	res->irq = pdev->irq;

	return 0;
}

just below the loongson_dwmac_dt_config() function. Thus the only code
left in the probe() method would be:

	if (dev_of_node(&pdev->dev))
		ret = loongson_dwmac_dt_config(pdev, plat, &res);
	else
		ret = loongson_dwmac_acpi_config(pdev, plat, &res);

	if (ret)
		goto err_disable_device;

As a result this patch will look simpler and more coherent. So will
the probe() method with no additional change required for that.

-Serge(y)

>  
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
> -- 
> 2.31.4
> 

