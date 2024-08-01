Return-Path: <netdev+bounces-115089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4132B945150
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 19:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E955B284B5C
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 17:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241B21B29AF;
	Thu,  1 Aug 2024 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjEA6Eus"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CE316F8EB
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722532191; cv=none; b=lipl1x97i6KCX0leNcUw5d3uWTmVm4I6gbxcOel/lURjNMWFp7FmNBnIwn97lAh5+cfoZNwH+duLL9SVS1VSAw8BGDsFWYHtfIUO4azxJkBicYNNaF0JtM+nPzOFC1YHB23sQ2+BG/dWS0v9pDvqxLUqX5rk1dv8iL+4agNpWJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722532191; c=relaxed/simple;
	bh=vDei6PmeAtpSD6fv8D2F9dsMgE1b2Ezk7/Zvi84oRAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JC6ZoSTb0qdVUKixulNf63HJ8M18a3Tj+8sPYe6KI3rgcgz6e/hBrHUKNl49VM9+p8oRtLuS53vmHx28Uh0RYxDzdWuAu6eYop2cx3GZSqsHOIeh6kxnkCN+iiPaDiogYecwrb6km1WnMvdhKtZ1nSRsws3X+Do/OcbnF9jB/xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjEA6Eus; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52efe4c7c16so10546837e87.0
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 10:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722532187; x=1723136987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gOn8Fn2TjjFV6z4G0Jzu50Hz1Zu8zfXDWsxL4wUa05Y=;
        b=hjEA6Eus3kTLMqImoJro4+bE92gZbenBT65fkudvcs3lvH1f4opSqIRn6Z+pUuPZFT
         V2LhbKOqpgEOLSSNwvT6Z+Tch3Qk6z35LsY5gayFnbMRX+ZLJdJd6CvEcUdHAt0bPW1h
         PyMn/tYB4QR0F7ADzM9DCNYUOnA6N8Gyv2CSGcNMo1WAP3fQeELwK6l8GNBTh0eEuWJK
         VWwB7X1N5qC/+t8ZTy9DLPgA0JYAUY4zsH9WuybyRUZoWt4o0jTZiZpdW3aMxdd2LAxN
         7XljklHlFvyv0TQiCKeRtURDRW8hkI1UHJ2e/4dKmFR9CiMJ+f34JiQBQsIdAEcER02V
         +Z8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722532187; x=1723136987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOn8Fn2TjjFV6z4G0Jzu50Hz1Zu8zfXDWsxL4wUa05Y=;
        b=Z4SidltaOMMqZvrjDfJA8DTmvoPR34l1EcoBQt86yOeccqfl/fLJyktMbZkLTEs+5R
         x2DoTrfIFv1ZrojtibcXrHxOnezej/SdIQB0q7hMx4wwYrERW1n4GxwDtOIxkoW6iDW7
         4AlMbcfHKaFjPyA18dX5mgzm8q5I5FmbXIVb4/eFWQK08JH4lzjPUkTgVhAsXkPIiBYP
         1AOhLPvAFbN74C+IZg8yrzmQ1LhBOBGPPRg91cobE0olf9IGTU6JIkY/XsY5h4d4oujh
         TJxeQYs+5vI6oHhGLQQy69Hhoi96WlAAmMCfdCcvOG+Ni/n77vVuETD8bu4xrp8uHb+M
         8HCg==
X-Forwarded-Encrypted: i=1; AJvYcCV0D6iWpVlcbGeHMow8LpDfheIZxU2AdZfEaalhIas2EVknm1Qs+WM6P5v7ULC+9P8COYAoARM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKCF4iVzuVFNF5EBghCttaJhMfYVPSC9fHaul3YZGHxNwjMQH1
	RvxZsbUUfVmQv0L7jhw55NpL7Gs0foIisfgIJvoqspSjlfPSeuAS
X-Google-Smtp-Source: AGHT+IF2xBtXOyezzRypDzIWUQXUxg4IW4aOrOBW0EKUM1bK+87bT04FkDGBjsRE4wQRX9Amyn+qew==
X-Received: by 2002:a05:6512:ac9:b0:52f:c27b:d572 with SMTP id 2adb3069b0e04-530bb3d6ef9mr405462e87.59.1722532187110;
        Thu, 01 Aug 2024 10:09:47 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba0736bsm11726e87.26.2024.08.01.10.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 10:09:46 -0700 (PDT)
Date: Thu, 1 Aug 2024 20:09:43 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: Paolo Abeni <pabeni@redhat.com>, andrew@lunn.ch, hkallweit1@gmail.com, 
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	diasyzhang@tencent.com, Jose.Abreu@synopsys.com, chenhuacai@kernel.org, 
	linux@armlinux.org.uk, guyinggang@loongson.cn, netdev@vger.kernel.org, 
	chris.chenfeiyang@gmail.com, si.yanteng@linux.dev, Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH net-next v15 12/14] net: stmmac: dwmac-loongson: Add
 Loongson Multi-channels GMAC support
Message-ID: <fnimgluzwjonv6h3n3g3a6un7hajwmiwti6akhoetsxj6sfwh7@2glcs5e2nwxo>
References: <cover.1722253726.git.siyanteng@loongson.cn>
 <9ff53ca4064774e389dd3d5f334fc82ed2443cf0.1722253726.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ff53ca4064774e389dd3d5f334fc82ed2443cf0.1722253726.git.siyanteng@loongson.cn>

On Mon, Jul 29, 2024 at 08:23:56PM +0800, Yanteng Si wrote:
> The Loongson DWMAC driver currently supports the Loongson GMAC
> devices (based on the DW GMAC v3.50a/v3.73a IP-core) installed to the
> LS2K1000 SoC and LS7A1000 chipset. But recently a new generation
> LS2K2000 SoC was released with the new version of the Loongson GMAC
> synthesized in. The new controller is based on the DW GMAC v3.73a
> IP-core with the AV-feature enabled, which implies the multi
> DMA-channels support. The multi DMA-channels feature has the next
> vendor-specific peculiarities:
> 
> 1. Split up Tx and Rx DMA IRQ status/mask bits:
>        Name              Tx          Rx
>   DMA_INTR_ENA_NIE = 0x00040000 | 0x00020000;
>   DMA_INTR_ENA_AIE = 0x00010000 | 0x00008000;
>   DMA_STATUS_NIS   = 0x00040000 | 0x00020000;
>   DMA_STATUS_AIS   = 0x00010000 | 0x00008000;
>   DMA_STATUS_FBI   = 0x00002000 | 0x00001000;
> 2. Custom Synopsys ID hardwired into the GMAC_VERSION.SNPSVER register
> field. It's 0x10 while it should have been 0x37 in accordance with
> the actual DW GMAC IP-core version.
> 3. There are eight DMA-channels available meanwhile the Synopsys DW
> GMAC IP-core supports up to three DMA-channels.
> 4. It's possible to have each DMA-channel IRQ independently delivered.
> The MSI IRQs must be utilized for that.
> 
> Thus in order to have the multi-channels Loongson GMAC controllers
> supported let's modify the Loongson DWMAC driver in accordance with
> all the peculiarities described above:
> 
> 1. Create the multi-channels Loongson GMAC-specific
>    stmmac_dma_ops::dma_interrupt()
>    stmmac_dma_ops::init_chan()
>    callbacks due to the non-standard DMA IRQ CSR flags layout.
> 2. Create the Loongson DWMAC-specific platform setup() method
> which gets to initialize the DMA-ops with the dwmac1000_dma_ops
> instance and overrides the callbacks described in 1. The method also
> overrides the custom Synopsys ID with the real one in order to have
> the rest of the HW-specific callbacks correctly detected by the driver
> core.
> 3. Make sure the platform setup() method enables the flow control and
> duplex modes supported by the controller.
> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Acked-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>
> [...]
>
> @@ -146,6 +450,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	struct plat_stmmacenet_data *plat;
>  	struct stmmac_pci_info *info;
>  	struct stmmac_resources res;
> +	struct loongson_data *ld;
>  	int ret, i;
>  
>  	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
> @@ -162,6 +467,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	if (!plat->dma_cfg)
>  		return -ENOMEM;
>  
> +	ld = devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
> +	if (!ld)
> +		return -ENOMEM;
> +
>  	/* Enable pci device */
>  	ret = pci_enable_device(pdev);
>  	if (ret) {
> @@ -184,6 +493,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	memset(&res, 0, sizeof(res));
>  	res.addr = pcim_iomap_table(pdev)[0];
>  
> +	plat->bsp_priv = ld;
> +	plat->setup = loongson_dwmac_setup;
> +	ld->loongson_id = readl(res.addr + GMAC_VERSION) & 0xff;
> +
>  	info = (struct stmmac_pci_info *)id->driver_data;
>  	ret = info->setup(pdev, plat);
>  	if (ret)
> @@ -196,6 +509,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	if (ret)
>  		goto err_disable_device;
>  
> +	/* Use the common MAC IRQ if per-channel MSIs allocation failed */
> +	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN)
> +		loongson_dwmac_msi_config(pdev, plat, &res);
> +
>  	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>  	if (ret)
>  		goto err_plat_clear;
> @@ -205,6 +522,8 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  err_plat_clear:
>  	if (dev_of_node(&pdev->dev))
>  		loongson_dwmac_dt_clear(pdev, plat);

> +	else if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN)
> +		loongson_dwmac_msi_clear(pdev);

Why implementing "else if" here if the loongson_dwmac_msi_config() is
called for both DT and ACPI cases? AFAICS it should be just "if".

>  err_disable_device:
>  	pci_disable_device(pdev);
>  	return ret;
> @@ -217,8 +536,10 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
>  {
>  	struct net_device *ndev = dev_get_drvdata(&pdev->dev);
>  	struct stmmac_priv *priv = netdev_priv(ndev);
> +	struct loongson_data *ld;
>  	int i;
>  
> +	ld = priv->plat->bsp_priv;
>  	of_node_put(priv->plat->mdio_node);
>  	stmmac_dvr_remove(&pdev->dev);
>  
> @@ -232,6 +553,9 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
>  		break;
>  	}
>  

> +	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN)
> +		loongson_dwmac_msi_clear(pdev);
> +

Please do this just below the 
        if (dev_of_node(&pdev->dev))
                loongson_dwmac_dt_clear(pdev, priv->plat);
chunk so the remove() method would look similar to the
cleanup-on-error path of the probe() method.

-Serge(y)

>  	pci_disable_device(pdev);
>  }
>  
> -- 
> 2.31.4
> 

