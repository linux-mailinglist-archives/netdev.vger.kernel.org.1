Return-Path: <netdev+bounces-69187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C33849FF7
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 17:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154ED1C22545
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 16:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BBD3FB34;
	Mon,  5 Feb 2024 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkjXUOhg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D71376E0
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707151794; cv=none; b=QoQwFqNpKBVt5DK1UiRERoEbRnxuWD7aaA01KnCOaJ/KVqpKNBY5aPa4+BHjHbhDXvXfspZTOeZwM1UIc+lAgWp8vO6Ss10kHyge3fSKeVn4AIDieDOm15XtmU6F84fT7dHNpkxblBRl9yqaS7N6C+3kQ2rtxqMjGegtdGOefz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707151794; c=relaxed/simple;
	bh=sArGIn7yRFiLF+O+tz6tyOWEL7g+xskhKjIglFYgCPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3q5SwmerKa+oAsQ7my3kNp3wSC7FNv0VG0CkHK3LI9RAZ7MUXNeVT+SccC5sNV/dBaVbWAsaSdJ2nn+N+iM5qaTLXssvVh9PJ5INI+9FOSIOprhdaM1m2FgAXMjOHOo/PD3656Lymnhua9aEPPaYX7zDvxRgHsBwVB5S8xY+O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkjXUOhg; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51121637524so6950332e87.1
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 08:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707151790; x=1707756590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R9BJ9qdeJI7RZlc4JgIxdIIC02Zp3wCXlQUMLoCiCFE=;
        b=JkjXUOhg1/KckbfNyeOJ48pIgUhH1LxN8k3/PjsnYRBrzL2Ytdi4VIhjPq/YZu6YOH
         1K9yvX3hz8Vjd0jM4U+Vo5SteeRp0k+LQev7hXNs7S8Qra/wYLAvm0s3auouVxGapfLj
         kCAfBgJcIavTWorULlPW6lSoEE66xDBJWQpChcgtFtejiYKnGbonSHkOUlPMctLx+7Bg
         lWduXis0JUz5TU7aPpamcwPgQ7RCH1C1orkVZhsSAWnxMUvu9s9XXYnOCygx39xOKS3I
         u3ALkXL+BOH7nqG1/Y/p1ZniJp2ngGEPsJxuWVz3QexKj7Qmw1AqrOqWp//0Pz3IsYCS
         2nbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707151790; x=1707756590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9BJ9qdeJI7RZlc4JgIxdIIC02Zp3wCXlQUMLoCiCFE=;
        b=NMMvAitDUoehhxw32JK+DHKBo9QvYUKpejKJC6XNuhtIAVuEghBFgipy+BcpsNbJet
         29cQUVwPzgbBYBpiKbSLrebtb+v6sGDsNrNBXFAf8SyFyD5R3qvjGaNBWMHYgO6iEnA1
         v6wCeEqC6vDKzCuu9FRxED7gT9sySSamQxN0U5CGYHYO6us73j5YyafIsCKNXyE280pH
         2qa0M0h+7ahF1SDkrlWgtZyqDAr50Jv+qwfcmCfTCJIhCjaZq3MxjEUWVJwQaURYeMwq
         AA3Nn7poov3bhnpjFxNIc/xBGVDS7yeM80nOR3C7Yr/YX6IZroyudxlbn5uIx0Et+kQh
         sRSg==
X-Gm-Message-State: AOJu0YwTZVOzItkuNeglJoiJAZmIPIE1UFRBCoCfHENXzYWp31RxPfJv
	zlFnOfYZ6L91sOItBn2m2WJEYKzDshY7yAOmHhbR3aRkqa96CiSl0BvYvqbU4Lw=
X-Google-Smtp-Source: AGHT+IEpvT8lu/d3QDvtvV5nHmwSdwce/Ht6OKDxe+6AvsrosSGOhuWPZC1hwU98JcXs2HM40x9tVg==
X-Received: by 2002:ac2:55b4:0:b0:511:51ec:8684 with SMTP id y20-20020ac255b4000000b0051151ec8684mr108252lfg.50.1707151789832;
        Mon, 05 Feb 2024 08:49:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXoDPAoQgP8bm0QC71OjGQS5Z4cgo01fraRbmbFqTHnl/F00jx9UtxNf0J7V+g2+iLqDqeQk1DCX0BhBHAe1vzdHzrDERAKqWskkxRX7MGzXMTwgZArdsOMX/aM0V93uKVSeLcpC0ql5DtJ1VgAX7qjuYwvFvdsJTDe2HBuHzkp/eyI6IbVkf8QziXe1n1bH/Ep1ZTO27NLPgpLZ3PSdZJYTA2bHd/fbJPCZOchUn1NUizizdDNOJ9KvamnodJTEUmg6FMFBA5kfVFY+pTsuKT0NiQ6oDKF3Kwr2wkDfarXp0AUZnZEs46ygkLFO73yhEpdRFrahil9HBau5EI0Zgyyb+oe53rzVCBgK//zJRfpjCCnSdQZJFHN931UVU7HcXdeuaxlkw==
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id z10-20020a19f70a000000b005114cb60177sm7005lfe.142.2024.02.05.08.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:49:49 -0800 (PST)
Date: Mon, 5 Feb 2024 19:49:46 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 03/11] net: stmmac: dwmac-loongson: Add full
 PCI support
Message-ID: <7dbvco63tgz65p7xx5tufwjlwgkpujjbqet52atrbj7s4zyrbx@qjxxtumcbbga>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <bfaed8692d6e03bbb53100d4e3695aa4a9f92633.1706601050.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfaed8692d6e03bbb53100d4e3695aa4a9f92633.1706601050.git.siyanteng@loongson.cn>

On Tue, Jan 30, 2024 at 04:43:23PM +0800, Yanteng Si wrote:
> Current dwmac-loongson only support LS2K in the "probed with PCI and
> configured with DT" manner. Add LS7A support on which the devices are
> fully PCI (non-DT).

Please add to the commit log more details of what LS7A is like and
bind that description to the changes below like the interface
settings, ref and PTP clock settings, etc. What is the difference
between LS2K and LS7A?

> 
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 79 +++++++++++--------
>  1 file changed, 44 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index e2dcb339b8b0..979c9b6dab3f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -16,6 +16,10 @@ struct stmmac_pci_info {
>  static void loongson_default_data(struct pci_dev *pdev,
>  				  struct plat_stmmacenet_data *plat)
>  {
> +	/* Get bus_id, this can be overloaded later */
> +	plat->bus_id = (pci_domain_nr(pdev->bus) << 16) |
> +		       PCI_DEVID(pdev->bus->number, pdev->devfn);
> +
>  	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
>  	plat->has_gmac = 1;
>  	plat->force_sf_dma_mode = 1;
> @@ -51,10 +55,14 @@ static int loongson_gmac_data(struct pci_dev *pdev,
>  	plat->mdio_bus_data->phy_mask = 0;
>  
>  	plat->phy_addr = -1;
> +	plat->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
>  
>  	plat->dma_cfg->pbl = 32;
>  	plat->dma_cfg->pblx8 = true;
>  

> +	plat->clk_ref_rate = 125000000;
> +	plat->clk_ptp_rate = 125000000;
> +

Is this compatible with the LS2K GMAC?

>  	return 0;
>  }
>  
> @@ -71,13 +79,6 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
>  	struct stmmac_resources res;
>  	struct device_node *np;
>  
> -	np = dev_of_node(&pdev->dev);
> -
> -	if (!np) {
> -		pr_info("dwmac_loongson_pci: No OF node\n");
> -		return -ENODEV;
> -	}
> -
>  	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
>  	if (!plat)
>  		return -ENOMEM;
> @@ -93,6 +94,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
>  	if (!plat->dma_cfg)
>  		return -ENOMEM;
>  
> +	np = dev_of_node(&pdev->dev);

>  	plat->mdio_node = of_get_child_by_name(np, "mdio");
>  	if (plat->mdio_node) {
>  		dev_info(&pdev->dev, "Found MDIO subnode\n");

Shouldn't mdio_node setup being done under the "if (np)" clause?

> @@ -123,41 +125,48 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
>  	if (ret)
>  		goto err_disable_device;
>  
> -	bus_id = of_alias_get_id(np, "ethernet");
> -	if (bus_id >= 0)
> -		plat->bus_id = bus_id;

> +	if (np) {
> +		bus_id = of_alias_get_id(np, "ethernet");
> +		if (bus_id >= 0)
> +			plat->bus_id = bus_id;
>  
> -	phy_mode = device_get_phy_mode(&pdev->dev);
> -	if (phy_mode < 0) {
> -		dev_err(&pdev->dev, "phy_mode not found\n");
> -		ret = phy_mode;
> -		goto err_disable_device;
> +		phy_mode = device_get_phy_mode(&pdev->dev);
> +		if (phy_mode < 0) {
> +			dev_err(&pdev->dev, "phy_mode not found\n");
> +			ret = phy_mode;
> +			goto err_disable_device;
> +		}
> +		plat->phy_interface = phy_mode;
>  	}

Please collect all OF-specific code in the same "if (np)" clause if
possible.

>  
> -	plat->phy_interface = phy_mode;
> -
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
> +	if (np) {
> +		res.irq = of_irq_get_byname(np, "macirq");
> +		if (res.irq < 0) {
> +			dev_err(&pdev->dev, "IRQ macirq not found\n");
> +			ret = -ENODEV;
> +			goto err_disable_msi;
> +		}
> +
> +		res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
> +		if (res.wol_irq < 0) {
> +			dev_info(&pdev->dev,
> +				 "IRQ eth_wake_irq not found, using macirq\n");
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

> +		res.wol_irq = pdev->irq;

This seems redundant. If res.wol_irq matches res_irq it won't be used
(see stmmac_request_irq_multi_msi() and stmmac_request_irq_single()).
What about dropping it?

-Serge(y)

>  	}
>  
>  	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
> -- 
> 2.31.4
> 

