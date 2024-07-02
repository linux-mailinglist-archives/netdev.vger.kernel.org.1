Return-Path: <netdev+bounces-108385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD10923A6A
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 11:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457231F21985
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 09:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366B314F9F2;
	Tue,  2 Jul 2024 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HA0ekD2r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E767146D43
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 09:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913574; cv=none; b=OEJ3eyEIs6WViUOoMAgRoJ8Z1aImLwjHTDgMn+83T5mQuWXdhrohVkoANPqgfFuZrsHgIQmzBl5Dw3kqokSaujWHF2W4dATbpjV26MUdhn1YuuM7Gyb7LPeDENAy2hKo406aT7YKt1jUN+y6e0mc0GO5JTeH4e8yzJBBEYlIfjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913574; c=relaxed/simple;
	bh=1mvdKrrbYsJfO3hhekq6K80XF0l/OXG93d1kWEykvMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mr1tO3HLyMl8T1vrqfCDcLuK62TO64gH5cpct/APEqDLhp2DQsKf1kr2H87sO8RHE7T8jBkYhhZW9XsHtIZhHcwDE4k9l07DtCkTKAaaq8KiMneO/QUiIeVAyupuFqp0zvhQRVPUk1ZKtm/k1z83XOlu4V/Hdg0YxIJaAWzB9oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HA0ekD2r; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e72224c395so44656771fa.3
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 02:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719913570; x=1720518370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XGA7UoOKFJLx7zPYaBGsmvGdhRIJXLX9S+5azdo7q7U=;
        b=HA0ekD2rXrFgpiVpXgYTTJnPo+/sqfOfoTDZ+CAzRr/LDQkSpSIs9FxQnpW1yAUoSm
         yO4cp9ThJRTQHkzh1ywRLBTppZK6C9Eth5eVtVoQaQ+g71kjUpLCQDLrKuK+c9JQnbfa
         8hzaVsDlX8so2UDWVs6i40pR7w6J0Fl/g/gs0Bt9PRT+aYf8hd8Be8vFmq73KDSDe0uB
         91hI3jQ+XJTcW8gCp6A8gUL0hrQ50QkPz7pQqDhXn3Vb7BNAOamNnEUuRHhKtoNhzMby
         IB1hPT/HQlPv3QCmTtOhvnH9Y1l9eu5cSW91QYehpy6R6bvZD2pzbl12dI0NEZIlBWUK
         URSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719913570; x=1720518370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGA7UoOKFJLx7zPYaBGsmvGdhRIJXLX9S+5azdo7q7U=;
        b=lpZZYEf7JTcNIU4tTJoIzRxck5SfRmiHrLLPjM2tuXbjM3r4Z/WKWpskFi/hs+HV0+
         McSNBpigY4z0B8W4wg2/yfga0QBQ600Tdvhm1aGW8dwt/bryViTVvjaxn4KOq44Z1ieu
         /1cQliIWKMeeMVygVgskpNdVS1J8Jb7kvtEQwNFyctvmmcrnW3cuCURGhPeZKVcNiehs
         6MWYA3wViUqNfXDCvL9LtIwLV68GDucIut+GipSerE4lsZPGjyyCUGM0UwJf6+STeXLi
         mUtChOyyF083Q6lIZEEJxeYPyqHfdhkv5Tqyc2A4bTgmevZglwP6KlcqFbtmAlAGXwWQ
         T8dA==
X-Forwarded-Encrypted: i=1; AJvYcCVgqg/3QGqbzhRo5l5QjYEoXVILYv2ZyKBQnDVfXgLDu/BnBM3q99/lyzo3frDTwu4YZ/dlechFSpAHf0CWz9qfyowhz1Pb
X-Gm-Message-State: AOJu0Yz5XBhqjfRH3nIaa/BWSx7CznLMFpzMuSi3h2tkgBb8d5A8YKHh
	mdRmuxi+q8DivJkKB/3dWMa4wutALtUTdQT7/O4NGMElytuoBohr
X-Google-Smtp-Source: AGHT+IFwFHUFWNFsCH/4uvzJh3C0RYK9z+QIw+BYPG4UuzuH7n/5jPo9Odtz1x4UI4TlBwndO9gIqw==
X-Received: by 2002:a2e:9e57:0:b0:2ec:5ff1:2274 with SMTP id 38308e7fff4ca-2ee5e36f20dmr49425621fa.25.1719913570117;
        Tue, 02 Jul 2024 02:46:10 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee6efaa857sm5024251fa.89.2024.07.02.02.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 02:46:09 -0700 (PDT)
Date: Tue, 2 Jul 2024 12:46:07 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Subject: Re: [PATCH net-next v13 11/15] net: stmmac: dwmac-loongson: Add
 loongson_dwmac_dt_config
Message-ID: <izezculld3evoafk2eot5xx3fwnfughgu37silhq3qv5orwi4w@iy75t6wl2tsr>
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <b7dbb5c3cc6beef74a5d8df193394a8a8a2b46a1.1716973237.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7dbb5c3cc6beef74a5d8df193394a8a8a2b46a1.1716973237.git.siyanteng@loongson.cn>

On Wed, May 29, 2024 at 06:20:27PM +0800, Yanteng Si wrote:
> While at it move the np initialization procedure into a dedicated
> method. It will be useful in one of the subsequent commit adding the
> Loongson GNET device support.

As I just mentioned please merge in this patch content into the
previous patch:
[PATCH net-next v13 10/15] net: stmmac: dwmac-loongson: Add DT-less GMAC PCI-device support

-Serge(y)

> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 90 ++++++++++---------
>  1 file changed, 50 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 8bcf9d522781..fdd25ff33d02 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -67,16 +67,60 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
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
> +		return -ENODEV;
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
> +		return -ENODEV;
> +	}
> +
> +	ret = device_get_phy_mode(&pdev->dev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "phy_mode not found\n");
> +		return -ENODEV;
> +	}
> +
> +	plat->phy_interface = ret;
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
>  	int ret, i;
>  
> -	np = dev_of_node(&pdev->dev);
> -
>  	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
>  	if (!plat)
>  		return -ENOMEM;
> @@ -115,44 +159,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  
>  	pci_set_master(pdev);
>  
> -	if (np) {
> -		plat->mdio_node = of_get_child_by_name(np, "mdio");
> -		if (plat->mdio_node) {
> -			dev_info(&pdev->dev, "Found MDIO subnode\n");
> -			plat->mdio_bus_data->needs_reset = true;
> -		}
> -
> -		ret = of_alias_get_id(np, "ethernet");
> -		if (ret >= 0)
> -			plat->bus_id = ret;
> -
> -		ret = device_get_phy_mode(&pdev->dev);
> -		if (ret < 0) {
> -			dev_err(&pdev->dev, "phy_mode not found\n");
> +	if (dev_of_node(&pdev->dev)) {
> +		ret = loongson_dwmac_dt_config(pdev, plat, &res);
> +		if (ret)
>  			goto err_disable_device;
> -		}
> -
> -		plat->phy_interface = ret;
> -
> -		res.irq = of_irq_get_byname(np, "macirq");
> -		if (res.irq < 0) {
> -			dev_err(&pdev->dev, "IRQ macirq not found\n");
> -			ret = -ENODEV;
> -			goto err_disable_msi;
> -		}
> -
> -		res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
> -		if (res.wol_irq < 0) {
> -			dev_info(&pdev->dev, "IRQ eth_wake_irq not found, using macirq\n");
> -			res.wol_irq = res.irq;
> -		}
> -
> -		res.lpi_irq = of_irq_get_byname(np, "eth_lpi");
> -		if (res.lpi_irq < 0) {
> -			dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
> -			ret = -ENODEV;
> -			goto err_disable_msi;
> -		}
>  	} else {
>  		res.irq = pdev->irq;
>  	}
> -- 
> 2.31.4
> 

