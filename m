Return-Path: <netdev+bounces-69189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A2484A027
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 18:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20F7280BE7
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 17:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901563CF5F;
	Mon,  5 Feb 2024 17:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUXJATY6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34193C46F
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707152493; cv=none; b=NOqngOIqWbC9M6KLsjYfQhkqYZO2dhsDeKim3lvk91FZoqEpy+J/7gW286/2iTNfE4RshqLYWHM1KeTesIaKZYn/tFmObwxh4tDHTQmX/Vtpbe0k/xjo1oeVN1yI7w3J3nBm5BheHXEm0ByoB5zWkRyjIMeUupvOuxzUtPW6JBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707152493; c=relaxed/simple;
	bh=5rVpubii/P1LiL8TPUoeCpI5Z/gYGJjCG0OfJe4bg5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCU2G0U0fX3bX6wivuo3rUlHho1n9bUgibr9F3Vfedoo7cDTlF/31+tG4NpKSGw0VXsbbwGSko4Pw1TVwBNNkZeBX4FLybd6r562chBk8MWRxLYYGK5Oa+DP3eoZ9WVFKa9b22ktF3rE3MMXcCoakEmmYvENhjbsqDLc4Jn53Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUXJATY6; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50eac018059so5630883e87.0
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 09:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707152490; x=1707757290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SSinUxd+Rn+cLhWqh2MS1lL6w9Y+vyoNhhsvVE6XiHs=;
        b=FUXJATY6PPHy4DNSTBnQZTiuCTEQDBxQqw32ZG3FUONZDoBRSzomYqkcVgPrSw/kXK
         yyZJRWlq79lO9fcYuEZGa9+eksN/up42puXdSQIOKIEM+gMK4eyEeo8zju7cViAkCwsk
         Pkr7UzWjawBADWdblr71bfL3ij29F4DQEAny5YcP72C4HY5BnzAUbz7uRtc6zyqo0duR
         HchpzKEBv71+4ArB9E6s+Wm98FETLQeKwiC79UZOa4rNVZ6zlPHvtO3FqhfoHR63LPXd
         I/0bvUrVYDZh+fMn5Dz8f5bIXBj1DQpsDGTmTOplbUbsLF2srtwE9KV5bbn/K2H0ukGd
         46NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707152490; x=1707757290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSinUxd+Rn+cLhWqh2MS1lL6w9Y+vyoNhhsvVE6XiHs=;
        b=JjH3LVvt+3xBGeu1U01Cx/j3SLYp5U5UJOI+q1VFOIM4pQZHwADZIlnpUE+yXdrQfL
         BTKS9VBEPPK+SvJ43coayHAGnmKS++0oFzbeiOV5Ay1X9SH3sEvAOmtU8+bnvqppJfvj
         4sDIa7OR5rw6vXxNxDu99NmdYoeO+vOiFRgM1iG+XrsYgGl0qaPPEdWcUY/uRbtcI1YS
         9oqDe+PYJp3k1wGakFryUnVlTAizTs+LZE6bjAk+ATHfj9K+HStzLB4BWBhhIzjZIiLk
         8ubGUAWmhYJxLUnURsRJECcJzGXRwIIoEFDHe4uG6j9OobqF5uIbfnugc7kut/LIZCmJ
         MVug==
X-Gm-Message-State: AOJu0YybOWMB2Z7hYDY5byZ4G9brENg05g+9FTJP2vhWC2/hfxEw1Qsj
	EJrHiwFYpBemjIRNOv7y9ozvSPVpwFvcCfCzU0dPa4OJu/hTtgc1
X-Google-Smtp-Source: AGHT+IFGmDruScCvUHUqg7sekpiqsP0W+kOyMl1zFr7ui9GGTPlrk1zFWVC3iuHvZkSvioKwaLTonA==
X-Received: by 2002:a19:c215:0:b0:511:5040:f6e4 with SMTP id l21-20020a19c215000000b005115040f6e4mr113443lfc.56.1707152489412;
        Mon, 05 Feb 2024 09:01:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXQqY8aKuOP//Fz+cUokGGGpz0uz25JXXkuiB8SM/25U6DApPuEUQiZDx7JhvsZV7nvSvRrtDcozWNPX8Vf8JHzD1Y8+9v97U/IQ4UVx1eMg0QJmgNzmJnzG9o9MEoxfq6/Oz/Uo2BTPq00e8ipSMkGQO/3l3HgmGRjTRoEpQGCYW/ICo9Gbx6CJ+sm29AG8k3jxMljZQhAr9zQjgNovDEf9L5fmkCHO8CTpVjEBnAWZRyGPyQsK/oZs9JaDg+Uo6IWqfGtTLyyO3ME0e3FT2+1MnmMfPx5eVEmzCHtDySE+P/vEpsjK06H0apNv50cVVYwjs+SEcel/FecTdWiclSorsCOwTuhOZwPHB0Ne7sVBzWYFGOB9jkD9GFEVJLenr029qO98A==
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id b2-20020a056512060200b005114b8b2aabsm9946lfe.118.2024.02.05.09.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:01:28 -0800 (PST)
Date: Mon, 5 Feb 2024 20:01:26 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 04/11] net: stmmac: dwmac-loongson: Move irq
 config to loongson_gmac_config
Message-ID: <xjfd4effff6572fohxsgannqjr2w44qm4tru4aan2agojs77dl@tneltus7zqo6>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <776bfe84003b203ebe320dc7bf6b98707a667fa9.1706601050.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <776bfe84003b203ebe320dc7bf6b98707a667fa9.1706601050.git.siyanteng@loongson.cn>

On Tue, Jan 30, 2024 at 04:43:24PM +0800, Yanteng Si wrote:
> Add loongson_dwmac_config and moving irq config related
> code to loongson_dwmac_config.
> 

> Removing MSI to prepare for adding loongson multi-channel
> support later.

Please detach this change into a separate patch and thoroughly explain
why it was necessary.

> 
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 85 ++++++++++++-------
>  1 file changed, 55 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 979c9b6dab3f..e7ce027cc14e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -11,8 +11,46 @@
>  
>  struct stmmac_pci_info {
>  	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
> +	int (*config)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat,
> +		      struct stmmac_resources *res, struct device_node *np);
>  };
>  
> +static int loongson_dwmac_config_legacy(struct pci_dev *pdev,
> +					struct plat_stmmacenet_data *plat,
> +					struct stmmac_resources *res,
> +					struct device_node *np)
> +{
> +	if (np) {
> +		res->irq = of_irq_get_byname(np, "macirq");
> +		if (res->irq < 0) {
> +			dev_err(&pdev->dev, "IRQ macirq not found\n");
> +			return -ENODEV;
> +		}
> +
> +		res->wol_irq = of_irq_get_byname(np, "eth_wake_irq");
> +		if (res->wol_irq < 0) {
> +			dev_info(&pdev->dev,
> +				 "IRQ eth_wake_irq not found, using macirq\n");
> +			res->wol_irq = res->irq;
> +		}
> +
> +		res->lpi_irq = of_irq_get_byname(np, "eth_lpi");
> +		if (res->lpi_irq < 0) {
> +			dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
> +			return -ENODEV;
> +		}
> +	} else {
> +		res->irq = pdev->irq;
> +		res->wol_irq = res->irq;
> +	}
> +

> +	plat->flags &= ~STMMAC_FLAG_MULTI_MSI_EN;
> +	dev_info(&pdev->dev, "%s: Single IRQ enablement successful\n",
> +		 __func__);

Why is this here all of the sudden? I don't see this in the original
code. Please move it to the patch which requires the flag
setup/cleanup or drop if it isn't necessary.

> +
> +	return 0;
> +}
> +
>  static void loongson_default_data(struct pci_dev *pdev,
>  				  struct plat_stmmacenet_data *plat)
>  {
> @@ -66,8 +104,21 @@ static int loongson_gmac_data(struct pci_dev *pdev,
>  	return 0;
>  }
>  

> +static int loongson_gmac_config(struct pci_dev *pdev,
> +				struct plat_stmmacenet_data *plat,
> +				struct stmmac_resources *res,
> +				struct device_node *np)
> +{
> +	int ret;
> +
> +	ret = loongson_dwmac_config_legacy(pdev, plat, res, np);
> +
> +	return ret;
> +}
> +

You introduce the config callback here and convert to a dummy method
in
[PATCH 07/11] net: stmmac: dwmac-loongson: Add multi-channel supports for loongson
It's just pointless. What about introducing the
loongson_dwmac_config_legacy() method and call it directly?

>  static struct stmmac_pci_info loongson_gmac_pci_info = {
>  	.setup = loongson_gmac_data,
> +	.config = loongson_gmac_config,
>  };
>  
>  static int loongson_dwmac_probe(struct pci_dev *pdev,
> @@ -139,44 +190,19 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
>  		plat->phy_interface = phy_mode;
>  	}
>  

> -	pci_enable_msi(pdev);

See my first note in this message.

-Serge(y)

>  	memset(&res, 0, sizeof(res));
>  	res.addr = pcim_iomap_table(pdev)[0];
>  
> -	if (np) {
> -		res.irq = of_irq_get_byname(np, "macirq");
> -		if (res.irq < 0) {
> -			dev_err(&pdev->dev, "IRQ macirq not found\n");
> -			ret = -ENODEV;
> -			goto err_disable_msi;
> -		}
> -
> -		res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
> -		if (res.wol_irq < 0) {
> -			dev_info(&pdev->dev,
> -				 "IRQ eth_wake_irq not found, using macirq\n");
> -			res.wol_irq = res.irq;
> -		}
> -
> -		res.lpi_irq = of_irq_get_byname(np, "eth_lpi");
> -		if (res.lpi_irq < 0) {
> -			dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
> -			ret = -ENODEV;
> -			goto err_disable_msi;
> -		}
> -	} else {
> -		res.irq = pdev->irq;
> -		res.wol_irq = pdev->irq;
> -	}
> +	ret = info->config(pdev, plat, &res, np);
> +	if (ret)
> +		goto err_disable_device;
>  
>  	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>  	if (ret)
> -		goto err_disable_msi;
> +		goto err_disable_device;
>  
>  	return ret;
>  
> -err_disable_msi:
> -	pci_disable_msi(pdev);
>  err_disable_device:
>  	pci_disable_device(pdev);
>  err_put_node:
> @@ -200,7 +226,6 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
>  		break;
>  	}
>  
> -	pci_disable_msi(pdev);
>  	pci_disable_device(pdev);
>  }
>  
> -- 
> 2.31.4
> 

