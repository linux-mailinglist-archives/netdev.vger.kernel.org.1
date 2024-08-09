Return-Path: <netdev+bounces-117253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68AD94D565
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 19:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55963282A0E
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 17:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72315A0FE;
	Fri,  9 Aug 2024 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9s6zwuZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E6B49630
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 17:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723224386; cv=none; b=mPVfCrWfeu0PHxJGHz2XYJPksKk1/JBTyIAzvm1yJ8/DvIvYScp+WLJrwBhci9KjdLhthKgPVTyJNBmvGQ9O2dcS9tTlgoUxJ/6+m2LrEjOgbP1H185Zfu08mC2BRVytMNHe9apvz/LNSNYCVdCRAs/pVyNlIsL7IU37nOsJYvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723224386; c=relaxed/simple;
	bh=X7jQrtYU4p6jWU1OATu5ycSVJmSWsSVr7l4f1kIbgEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvehW2YVZIv94yGVzQRDJP5fGOnSQhaGlFmf4fUHikT8JmHa1uauYumtlkCmYD8Om8kSFlGRp9jlECDKMojYK2bz/a1By7ANp3IjwKSI5E6+MKgjD1GMk6MOi3QWwDM71vtmpcx2y2UxUeMpuszUonCwrPWkROO+jvSdVdpotlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9s6zwuZ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f032cb782dso25251931fa.3
        for <netdev@vger.kernel.org>; Fri, 09 Aug 2024 10:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723224383; x=1723829183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M+DWHbJc3q3xN7YpLx3AV/TFq9hhXUNIjl+KMRzCUxM=;
        b=b9s6zwuZVn+nn9Fxen9PXsl23y/pCyS1XrnYULmL2M5tGeJrPYi52Ejm0zsE39R8O6
         UUsOtQliqJeS/F2UE0PaANdsRYY/j2y5ADadiBLeGHVUVlg/M+nVG7+dJMOl1KSIeCAN
         BHRkGM9JmLEbY0Z0RInf8/n2qfYW9qqfXA3cfBb2gMbaijiXVUe0jgwiEf47WCdf1F90
         MjJypRlgiUR747TwWPrwlA5JYCp73zIHUDtkJZVeam8aKy20zSs1Dz9P3QwreOqDJJEu
         csJ9ukFaNEGyxmMQempfdUxVG95dy8hcRVl+zIapk6U42aMcY3Dre/xKhUITlXw84WSA
         5rVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723224383; x=1723829183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+DWHbJc3q3xN7YpLx3AV/TFq9hhXUNIjl+KMRzCUxM=;
        b=pLh5peVww03viR6ytC3uAf5rpwLlF1C6lAoic4CUBRCki1QV1d+SZvRwhNGSHn6Og9
         KQfrUkm3NzRMaW5Vssl/hbp312JJqno1QwaSruh8kCKkeNdesv0sxpcX1E0B6RiSkMSc
         pywXB4XHLYk2QADwTFw3XyLDM6Hi4WxQpd96FRD9b+qkzc4JMF93sMOUZyAaplajwa4I
         ntXq55pQyD8MO7vKsffgstLsyS9yCICDMni9PYwb5KXg01+cTwP1r4xk0mAtE8p+jHS6
         rY6AtLnFlQVgRAFd6fszO/KK1wsrN4sTnWzVHmXyuNmC+S7CAM3DiNHhah6DJ5S0ZCEU
         fGCA==
X-Forwarded-Encrypted: i=1; AJvYcCXsA+J+SXZ8vDqVV4j5tinWgVkV6Z4KHUDKwomptNwE53e3nfYRdc7qQcXmO7Nzj2RPjn6b77ih/eQ0h1OVwOI340UUgYVB
X-Gm-Message-State: AOJu0YwQwFLLx5cHkiqLVqIU8v/+UZowlp3682wnU8IT/k5emsS7rGjV
	SZJPSmj1uObyQ/EYlcm4u5TtK5RbevcLM1XC+UR6E1AIGOe/VdFe
X-Google-Smtp-Source: AGHT+IFOjELm8goV/f6xaEta9Nysjln0XNrger5mZCTmrYC1qfJPCNzxDgGFmW9GFkU9RBdLArbG4A==
X-Received: by 2002:a2e:bd86:0:b0:2ef:1b64:531b with SMTP id 38308e7fff4ca-2f1a6d65e08mr22915941fa.42.1723224382348;
        Fri, 09 Aug 2024 10:26:22 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f292068295sm74621fa.133.2024.08.09.10.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 10:26:21 -0700 (PDT)
Date: Fri, 9 Aug 2024 20:26:19 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, diasyzhang@tencent.com, 
	Jose.Abreu@synopsys.com, chenhuacai@kernel.org, linux@armlinux.org.uk, 
	guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, 
	si.yanteng@linux.dev, Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH net-next v17 11/14] net: stmmac: dwmac-loongson: Add
 DT-less GMAC PCI-device support
Message-ID: <hrnq2ipnep65lx2ao4mfkyi4yy73d2w46jgevf536moqdi4jlo@moxi4zamjxws>
References: <cover.1723014611.git.siyanteng@loongson.cn>
 <b13292f1bb64e335663d5929c81369da88fa2c13.1723014611.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b13292f1bb64e335663d5929c81369da88fa2c13.1723014611.git.siyanteng@loongson.cn>

On Wed, Aug 07, 2024 at 09:48:05PM +0800, Yanteng Si wrote:
> The Loongson GMAC driver currently supports the network controllers
> installed on the LS2K1000 SoC and LS7A1000 chipset, for which the GMAC
> devices are required to be defined in the platform device tree source.
> But Loongson machines may have UEFI (implies ACPI) or PMON/UBOOT
> (implies FDT) as the system bootloaders. In order to have both system
> configurations support let's extend the driver functionality with the
> case of having the Loongson GMAC probed on the PCI bus with no device
> tree node defined for it. That requires to make the device DT-node
> optional, to rely on the IRQ line detected by the PCI core and to
> have the MDIO bus ID calculated using the PCIe Domain+BDF numbers.
> 
> In order to have the device probe() and remove() methods less
> complicated let's move the DT- and ACPI-specific code to the
> respective sub-functions.
> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Acked-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>

No more comments from my side. Thanks.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 165 +++++++++++-------
>  1 file changed, 102 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 10b49bea8e3c..c0740a41025b 100644
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
>  	plat->tx_queues_to_use = 1;
>  	plat->rx_queues_to_use = 1;
> @@ -65,20 +70,85 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
>  	.setup = loongson_gmac_data,
>  };
>  
> +static int loongson_dwmac_dt_config(struct pci_dev *pdev,
> +				    struct plat_stmmacenet_data *plat,
> +				    struct stmmac_resources *res)
> +{
> +	struct device_node *np = dev_of_node(&pdev->dev);
> +	int ret;
> +
> +	plat->mdio_node = of_get_child_by_name(np, "mdio");
> +	if (plat->mdio_node) {
> +		dev_info(&pdev->dev, "Found MDIO subnode\n");
> +		plat->mdio_bus_data->needs_reset = true;
> +	}
> +
> +	ret = of_alias_get_id(np, "ethernet");
> +	if (ret >= 0)
> +		plat->bus_id = ret;
> +
> +	res->irq = of_irq_get_byname(np, "macirq");
> +	if (res->irq < 0) {
> +		dev_err(&pdev->dev, "IRQ macirq not found\n");
> +		ret = -ENODEV;
> +		goto err_put_node;
> +	}
> +
> +	res->wol_irq = of_irq_get_byname(np, "eth_wake_irq");
> +	if (res->wol_irq < 0) {
> +		dev_info(&pdev->dev,
> +			 "IRQ eth_wake_irq not found, using macirq\n");
> +		res->wol_irq = res->irq;
> +	}
> +
> +	res->lpi_irq = of_irq_get_byname(np, "eth_lpi");
> +	if (res->lpi_irq < 0) {
> +		dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
> +		ret = -ENODEV;
> +		goto err_put_node;
> +	}
> +
> +	ret = device_get_phy_mode(&pdev->dev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "phy_mode not found\n");
> +		ret = -ENODEV;
> +		goto err_put_node;
> +	}
> +
> +	plat->phy_interface = ret;
> +
> +	return 0;
> +
> +err_put_node:
> +	of_node_put(plat->mdio_node);
> +
> +	return ret;
> +}
> +
> +static void loongson_dwmac_dt_clear(struct pci_dev *pdev,
> +				    struct plat_stmmacenet_data *plat)
> +{
> +	of_node_put(plat->mdio_node);
> +}
> +
> +static int loongson_dwmac_acpi_config(struct pci_dev *pdev,
> +				      struct plat_stmmacenet_data *plat,
> +				      struct stmmac_resources *res)
> +{
> +	if (!pdev->irq)
> +		return -EINVAL;
> +
> +	res->irq = pdev->irq;
> +
> +	return 0;
> +}
> +
>  static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct plat_stmmacenet_data *plat;
>  	struct stmmac_pci_info *info;
>  	struct stmmac_resources res;
> -	struct device_node *np;
> -	int ret, i, phy_mode;
> -
> -	np = dev_of_node(&pdev->dev);
> -
> -	if (!np) {
> -		pr_info("dwmac_loongson_pci: No OF node\n");
> -		return -ENODEV;
> -	}
> +	int ret, i;
>  
>  	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
>  	if (!plat)
> @@ -90,25 +160,19 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
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
>  	if (ret) {
>  		dev_err(&pdev->dev, "%s: ERROR: failed to enable device\n", __func__);
> -		goto err_put_node;
> +		return ret;
>  	}
>  
> +	pci_set_master(pdev);
> +
>  	/* Get the base address of device */
>  	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>  		if (pci_resource_len(pdev, i) == 0)
> @@ -119,59 +183,32 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  		break;
>  	}
>  
> -	plat->bus_id = of_alias_get_id(np, "ethernet");
> -	if (plat->bus_id < 0)
> -		plat->bus_id = pci_dev_id(pdev);
> -
> -	phy_mode = device_get_phy_mode(&pdev->dev);
> -	if (phy_mode < 0) {
> -		dev_err(&pdev->dev, "phy_mode not found\n");
> -		ret = phy_mode;
> -		goto err_disable_device;
> -	}
> -
> -	plat->phy_interface = phy_mode;
> -
> -	pci_set_master(pdev);
> -
>  	memset(&res, 0, sizeof(res));
>  	res.addr = pcim_iomap_table(pdev)[0];
>  
>  	info = (struct stmmac_pci_info *)id->driver_data;
> -	ret = info->setup(plat);
> +	ret = info->setup(pdev, plat);
>  	if (ret)
>  		goto err_disable_device;
>  
> -	res.irq = of_irq_get_byname(np, "macirq");
> -	if (res.irq < 0) {
> -		dev_err(&pdev->dev, "IRQ macirq not found\n");
> -		ret = -ENODEV;
> -		goto err_disable_device;
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
> +	if (dev_of_node(&pdev->dev))
> +		ret = loongson_dwmac_dt_config(pdev, plat, &res);
> +	else
> +		ret = loongson_dwmac_acpi_config(pdev, plat, &res);
> +	if (ret)
>  		goto err_disable_device;
> -	}
>  
>  	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>  	if (ret)
> -		goto err_disable_device;
> +		goto err_plat_clear;
>  
> -	return ret;
> +	return 0;
>  
> +err_plat_clear:
> +	if (dev_of_node(&pdev->dev))
> +		loongson_dwmac_dt_clear(pdev, plat);
>  err_disable_device:
>  	pci_disable_device(pdev);
> -err_put_node:
> -	of_node_put(plat->mdio_node);
>  	return ret;
>  }
>  
> @@ -181,9 +218,11 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
>  	struct stmmac_priv *priv = netdev_priv(ndev);
>  	int i;
>  
> -	of_node_put(priv->plat->mdio_node);
>  	stmmac_dvr_remove(&pdev->dev);
>  
> +	if (dev_of_node(&pdev->dev))
> +		loongson_dwmac_dt_clear(pdev, priv->plat);
> +
>  	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>  		if (pci_resource_len(pdev, i) == 0)
>  			continue;
> -- 
> 2.31.4
> 

