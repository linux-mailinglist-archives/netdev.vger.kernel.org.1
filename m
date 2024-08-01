Return-Path: <netdev+bounces-115086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FFA945116
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 18:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74FF11C258FA
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6A91B4C38;
	Thu,  1 Aug 2024 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bq0s7IXU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9C41B4C3D
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722531024; cv=none; b=UqhIhWWGCB9bid2pnFOtF/oAv1XDHczo7+31hiXsPtOonK6x6mBI8gdB3k2+3zDztNKYaOIFjKid+9KM+9dut/rfC3G9SF548t1gw/hJzr70MvG/A2I/ean0RuvB4fBTJvwesMahBzYNxjzhl+4Esiz6bvOMdeaaGPBfJuJglZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722531024; c=relaxed/simple;
	bh=PTeMKM7W5dwwLPljBO9cq0UIOWnxRzUgbx27uj9FWSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGoLpzagiDrqFAor/IcIOwbLfjhr78fL6PqUS831gotULEfJ/8v0fQm8snR9/ihNIj7APo41jPSEi8iFK3jzqEAI20XzRCxKoUk64+j8sjl5z7aRGV4Eo2TL9+/ntl+DHASoAMSc70Ohgf5vKnOME1/ad1G/SsYcsd/ac110OM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bq0s7IXU; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f15790b472so10040681fa.0
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 09:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722531020; x=1723135820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=grBoejfNHY59T5M1l9jRkoa1ZtDqihdxQD51U3Lj0eM=;
        b=Bq0s7IXUWq+IKNYmqHVDSwxkAT4/TnDP3WI1iGQRN2EUoUaS17Q7s8xwJkIuqaVe7e
         7sH16BzpgtfSS06VfJGH6HGjPC1XEeJOGkHmWzhEaJtKVppzxlFIMmM8rCa/qofa9zrV
         pHaCeGd1OMdcnhGogDnlgNXa9loF45samuS0WYvaRs8MjzKMwRggvdGWbYEnbah0LQZs
         EO1c4Gqt0G8hPXNj6O3lN/apG4dJVIbo3WIS2s7DH//vsO0pcvw4Q55q63Fyy6qR9Mx6
         WXNtRARt4puA9xQxYsPlzbfyA+BeW6gnkLZmSXxTUWCZrZ0yKDlNHLYadBQhS5T/xbIn
         cunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722531020; x=1723135820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grBoejfNHY59T5M1l9jRkoa1ZtDqihdxQD51U3Lj0eM=;
        b=W7dswgFrIvfF1MjYBYvHUcjZd8jl49Z9ejhp0kr0IOf72G6M4uctw/6SslHskuq7f0
         0i1r5OwOOflAgacJNo0ufD34aiMetHlcX7qaSUXoWlEQ1/1A3UpuAeTuupF7Ws/1BCJs
         gC1/Okc3k74mXdR9+pH3tH/MlJOQet3mgtjaUQ9YhyJ+2+NP+e9ZGhLcdy5yRBwtLPZp
         wyhGdqI6ZbNMvuZoCnIhRzmpRus5wdFBV3S5XpH7loy/Wzfgi2u5/OqlyW8whkO9mJ9C
         sc7O52yDAqV9pL9s5SfpHJ+GC20epUkGZKxC4N0sUr1Sany56ystqwiBIRkkPcb1LRZ5
         IQsg==
X-Forwarded-Encrypted: i=1; AJvYcCXN3+XIMM9sPiq/55doK+7J2Mf4P2fAm4dIo+L+I1X10VoqC3osHqMBL2FjJfceyc//9a7nM/dTGUCpc7qhgfwkXRuyPtu1
X-Gm-Message-State: AOJu0YxSsw1MvA2eg9hnZ1NA2jCWaHx4F7SdjHAiqajqjXtQoFrJyEkX
	nYzZZCuNNUtcTFCk+sAJFcVAuLTBSuiAgtwhRJpTq78LxxmdiHWk
X-Google-Smtp-Source: AGHT+IFaiUJoac9X/CGhLDQcJ5DOQ4UEs8ELgW0HUdzU/SlusIP4bFkXxjKAjT/wL+pq9QqQOtxydw==
X-Received: by 2002:a05:651c:104d:b0:2ee:494c:c3d3 with SMTP id 38308e7fff4ca-2f15ab395afmr6060511fa.43.1722531020054;
        Thu, 01 Aug 2024 09:50:20 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15c3d5c57sm40591fa.70.2024.08.01.09.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:50:19 -0700 (PDT)
Date: Thu, 1 Aug 2024 19:50:16 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: Paolo Abeni <pabeni@redhat.com>, andrew@lunn.ch, hkallweit1@gmail.com, 
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	diasyzhang@tencent.com, Jose.Abreu@synopsys.com, chenhuacai@kernel.org, 
	linux@armlinux.org.uk, guyinggang@loongson.cn, netdev@vger.kernel.org, 
	chris.chenfeiyang@gmail.com, si.yanteng@linux.dev, Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH net-next v15 11/14] net: stmmac: dwmac-loongson: Add
 DT-less GMAC PCI-device support
Message-ID: <ow47o3pjvma2g4m5jtjw6e5vnz6rp7qtxcdmgzhlr2wgltqrbk@hyqnko2hzkyu>
References: <cover.1722253726.git.siyanteng@loongson.cn>
 <359b2c226e7b18d4af8bb827ca26a2e7869d5f85.1722253726.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <359b2c226e7b18d4af8bb827ca26a2e7869d5f85.1722253726.git.siyanteng@loongson.cn>

Hi Yanteng,

On Mon, Jul 29, 2024 at 08:23:55PM +0800, Yanteng Si wrote:
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
> ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 159 +++++++++++-------
>  1 file changed, 100 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 10b49bea8e3c..010821fb6474 100644
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
> @@ -65,20 +70,83 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
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
> @@ -90,17 +158,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
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
> @@ -109,6 +169,8 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id

>  		goto err_put_node;

		return ret;

* Once again BTW.

>  	}
>  
> +	pci_set_master(pdev);
> +
>  	/* Get the base address of device */
>  	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>  		if (pci_resource_len(pdev, i) == 0)
> @@ -119,57 +181,33 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
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
> +	return ret;

>  err_put_node:
>  	of_node_put(plat->mdio_node);
>  	return ret;

The main point of my v14 comment was to completely move the
of_node_put(plat->mdio_node) call to the DT-config/clear methods
(since it's OF-related config) and setting the loongson_dwmac_probe()
method free from the direct MDIO-node putting. Don't you see that
calling of_node_put() in the loongson_dwmac_probe() and
loongson_dwmac_remove() is now redundant?

Moreover don't you find the next chunk being weird:

err_disable_device:
  	pci_disable_device(pdev);
+	return ret;

err_put_node:
 	of_node_put(plat->mdio_node);
 	return ret;

? Two return statements in a single cleanup-on-error path. After
dropping the "err_put_node" label and the respective statements, the
cleanup-on-error path will turn to being saner.

> @@ -184,6 +222,9 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)

>  	of_node_put(priv->plat->mdio_node);

This is done in the loongson_dwmac_dt_clear() method. So the direct
of_node_put() call should be dropped.

-Serge(y)

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

