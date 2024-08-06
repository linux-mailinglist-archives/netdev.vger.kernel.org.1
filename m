Return-Path: <netdev+bounces-116214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2160C949806
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 21:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB9E3280290
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 19:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F39C7BB17;
	Tue,  6 Aug 2024 19:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIjQjuuI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8CD80025
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 19:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722971465; cv=none; b=H9pf0bbeKKlRT2YzYmS+eHHPdh4rK8+Q5I6LWoF5MuMKBoW1McSK5T/Wfdx/TVPYwfHk76VEbowq8OKrG9n6E1GMHyFwkNOZofxwlePovGTxp4knbWr8Ue4kxGWVOL4daRrLDSkc/Txgsdw1MeaGHMt6YAYi9WJdCfk88VWI7zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722971465; c=relaxed/simple;
	bh=4lNwg6Ykasr7W+WY/nBKREVB+UcL3onIBQd54ke115A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxiDr62dR9FoYmMnMAV698nA0djDkJ3hHzOK+z7grShAKSCIj/CE0TZJ8PUsz5LefLFa8y6FAdamPILhZZWscMfm5sXUx0ey9UR5TC1IXUVHD/iycX1638HDnVMyPtD5joh3Xk3ulEzdsGwYWlVxmn8bNCIg9bSQBTQTbCu0PkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIjQjuuI; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52fc4388a64so1326209e87.1
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 12:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722971462; x=1723576262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AVDo7sHEMCD1yVu6RfAMQvkjTaMdHCFhGgiPCf+w7C4=;
        b=jIjQjuuI05jtkAAlM9maGjGmB9Kw9lloWXRa0WtGwWPGIcwNMo51LbVk1JDX8PjSab
         W8ilxDcv/8E6BqZMOJBetwGqDSX/M/uacsnmFqtjBQpt5ku0c1VDG3ZuwK7P3XeB+Jkj
         yMFZ6pkLgo1OQfpYRV5w7DnlwLsqISiilr2dYr2n4mkijxa0FBYcy1xiq4t9xwbv47jv
         S8tcXAkWnVHAeHQ/1XkaG/fxIq+lkSLwI+sR5dXCvnlwWRqOHgcVd98rZLnMjl1m4LKa
         rFGbB1VDPl81or9d7RRmED83mLtbO7u1iWfjdAcStlMuDdPn84Wyl1T3o9woRRGpgDiY
         l5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722971462; x=1723576262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVDo7sHEMCD1yVu6RfAMQvkjTaMdHCFhGgiPCf+w7C4=;
        b=pU2F09mgPE1ayHZ0I12u5okhu7V+FJbhL0dVG0+J0svbmiNYAT0BDNYxFU285J+nYm
         wUT7q7LkuoOaumUlSE0RzFvIq3Pe+5pZ+VmBp2dms37Q/qDL7GobB+OhpaLEMhnMrdXp
         gkckV8xjDyxO1Y9J7OGWuZ9e4Lz/g0t5EkXSRvedlwbHzNoSyMtQRnFhp/p7oHndkl45
         HghsIfvoZzKDowCER87ewfzKdipdWaiaksxM2lKwnIOVwKq/pBUmAwOF66buSEX4ti9P
         XchqIG0o2G/XOl6dDr9we7RTNz0nhbvtTqPOVAVExXe5CKjysRriqL26KgWlOOvOJKkZ
         Vhtw==
X-Forwarded-Encrypted: i=1; AJvYcCVOOQ4Qjxj/yNjJRtZov+rBJnr5EBjCuj5zQdmEgbeF4p009pB7v2lWsDje7II/IniZMF0ERdODsCEVhkE2C6GJ2HQa+s1Z
X-Gm-Message-State: AOJu0YyQXH8jP8xmcQko5MHMn8fs0aw27cmaFPrHXQkxSdt9y4x8Ownf
	RKStQsXxGEz5N7r8BbTSZdhOguLIsvD0D5j46xGvLYu41GdSSEQ9
X-Google-Smtp-Source: AGHT+IEjvpKFuWRrQMecXzKOfJhXagoehtnS1F8ig6o76AsQ3jgmuHmKYqFpSAELLfIterPUWnacjw==
X-Received: by 2002:a05:6512:104b:b0:52e:fd75:f060 with SMTP id 2adb3069b0e04-530bb3b5274mr9212819e87.61.1722971461055;
        Tue, 06 Aug 2024 12:11:01 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba07ddesm1548453e87.4.2024.08.06.12.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 12:11:00 -0700 (PDT)
Date: Tue, 6 Aug 2024 22:10:57 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, diasyzhang@tencent.com, 
	Jose.Abreu@synopsys.com, chenhuacai@kernel.org, linux@armlinux.org.uk, 
	guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, 
	si.yanteng@linux.dev, Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH net-next v16 11/14] net: stmmac: dwmac-loongson: Add
 DT-less GMAC PCI-device support
Message-ID: <6tr4gaybcurhdgoyhbm5xbq46l6gbci2ytbzogu37aln4kivmq@kwm6m6b4bvzs>
References: <cover.1722924540.git.siyanteng@loongson.cn>
 <5f5875eb510e03acd25aa5adbc4f55b370a9762e.1722924540.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f5875eb510e03acd25aa5adbc4f55b370a9762e.1722924540.git.siyanteng@loongson.cn>

On Tue, Aug 06, 2024 at 06:59:44PM +0800, Yanteng Si wrote:
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
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 163 +++++++++++-------
>  1 file changed, 100 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 10b49bea8e3c..6ba4674bc076 100644
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

+
+	return 0;

Arggg. Alas I missed this part in v15.(

The rest of changes looks good. Thanks!

-Serge(y)

> +
> +err_put_node:
> +	of_node_put(plat->mdio_node);
> +
> +	return ret;
> +}
> +
>
> ...

