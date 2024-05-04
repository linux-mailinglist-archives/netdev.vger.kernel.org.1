Return-Path: <netdev+bounces-93458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911478BBE2C
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 23:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38461C20B9E
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 21:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533106BB5D;
	Sat,  4 May 2024 21:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kE7pewnV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A2D57C9A
	for <netdev@vger.kernel.org>; Sat,  4 May 2024 21:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714858133; cv=none; b=P3bK/z4VYZkRxq8BrZ5qPrpPc7OSlSxa5qx39FaXQ26HsFDtXsdmNPdfNeQUjtOS+ooOCPRMknsdwaZtOPYYgyVGePFW6fA2hDl6LUvshFPL8GYGInvBMIgE+iG8WsK4uq+eu56vfqgAu0vFUmcjDqemx+BeAq9J7SfNk6IDLnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714858133; c=relaxed/simple;
	bh=uPmBNJaEUo34qnyN7Bz78Xoienfa7h9PbVH0N8XPxw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wmk/hv3fQhwBReR6np4hUifOTWnKk4TdSjJZSgsR5bhRhysyNsIguccsNQug/5knX5ZUpg0/xyzUbrpmVh8nqdInXD+GOXM+nmNE/eWRBiVpBh5uJM58uJAI52M3irOGdL29/JwAwH+C9k51/9gZvc0gWnyCVo7bL3lXzc7vnh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kE7pewnV; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51f17ac14daso863235e87.1
        for <netdev@vger.kernel.org>; Sat, 04 May 2024 14:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714858130; x=1715462930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TjW2AeY1HyiaQs3Ad7wMNLuoPWz4h8TyrN8hcsFJkAk=;
        b=kE7pewnVINgOmBSOtLSxLkSgLqZ4k4UhJaU7XwJ7F745MmR5Y0ixokQVCrtkq2bK8+
         7SG/2ey/9g6S782YYCiucRChJ8EGziJ8WSWBKnvp6y09k1pXUfQE4SkOuNs2R9dJb3Hq
         Zxa6j39dOz8+56C3bTT3dxtE0RT3CsNpH+/0aEqpQMuDWSXp2SPhuaAI2mKpGM+xxrXD
         xoX/u9AZw2QpXJxvYh9IfcxWcWOZrQ1jMHMIcDcaGM3+SZCVg56a7JVu2BT3Qw167VUW
         kshUV4qmlNeaG+fIrJtZiTr9LOLYOpQsSZNMeFr02fgeW7aTs5IqVcYp2ylgrwblyHNH
         idXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714858130; x=1715462930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjW2AeY1HyiaQs3Ad7wMNLuoPWz4h8TyrN8hcsFJkAk=;
        b=v67qR+UPaCl6+Ex4b/gIQnSII9L6myUj22fV7M0kKzwNM+U/O5da2m896N14yxoVLA
         3Igh3AhQDJEimryariwWqtrd29QioO/greRiBj/zrPDGPAzoEJKcbnpdnZVjEvoXpmQG
         5dLUflQHl434IzS/E/H6NQAe84m1Qgk5gVZ7Uo1gY9hh+CTTi/b+JIad8SJjz/eEoQlY
         DajTgbI69XruRdMdCV0ZQrPU30ttb8cTJ2jQUgA0WMSurJj3WYkCuSnTOumIRucT0CGD
         cGoWds42aRA57aRZH6tuMBlybuVWfApffZDQ2dE9gc/DRO9CAF1wwDEaxgE1yW9Yzhb5
         Djwg==
X-Forwarded-Encrypted: i=1; AJvYcCXifXdSjpWuvjg0DXcIWCEv8b1/4F07t4OI5KKgxFHMia1glQ+0a/kyXZ6gkL454kskp0GXEkmjviRo1sYnjXn0zm4onIBy
X-Gm-Message-State: AOJu0Yxcbp+n8pXPKtirTlrujqiG/o7uLmzpPM5xdWgU1kyvOOdfVuVq
	xv76TFj+dkFjnH7eDU/1dOT2igHyCKnyj85Hki76oeEJCoH9JBhd
X-Google-Smtp-Source: AGHT+IGvaHCo/AF00RwXE29GJloofaHBA0V3TyYXHVV3/688pWEFzAiQbbY7u2x7zjxuaPU+nmE4QQ==
X-Received: by 2002:a05:6512:481d:b0:51c:ee04:3732 with SMTP id eo29-20020a056512481d00b0051cee043732mr3991031lfb.7.1714858129449;
        Sat, 04 May 2024 14:28:49 -0700 (PDT)
Received: from mobilestation ([95.79.182.53])
        by smtp.gmail.com with ESMTPSA id a21-20020ac25e75000000b0051e2073eae9sm1009472lfr.75.2024.05.04.14.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 14:28:48 -0700 (PDT)
Date: Sun, 5 May 2024 00:28:46 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 11/15] net: stmmac: dwmac-loongson: Add
 loongson_dwmac_config_legacy
Message-ID: <cao2zykgxyxee2f3rsrtod22qiyovyuywnck4xlheajrzfke3f@k6nfpf5bz46y>
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <b26258cae28b19c8d204beca691fea877b3bf537.1714046812.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b26258cae28b19c8d204beca691fea877b3bf537.1714046812.git.siyanteng@loongson.cn>

On Thu, Apr 25, 2024 at 09:10:36PM +0800, Yanteng Si wrote:
> Move res._irq to loongson_dwmac_config_legacy().
> No function changes.

Since the code affected by this patch has just been touched by the
previous patch
[PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add full PCI support
just merge this patch content into there. But add a note to the
commit message of that patch like this:

"While at it move the IRQ initialization procedure into a dedicated
method. It will be useful in one of the subsequent commit adding the
Loongson GNET device support."

> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 56 +++++++++++--------
>  1 file changed, 34 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 1022bceaa680..df5899bec91a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -68,6 +68,38 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
>  	.setup = loongson_gmac_data,
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

Once again - drop this, unless you can justify it's required.

> +	}
> +
> +	return 0;
> +}
> +
>  static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct plat_stmmacenet_data *plat;
> @@ -136,28 +168,6 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  			goto err_disable_device;
>  		}
>  		plat->phy_interface = phy_mode;
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
> -	} else {
> -		res.irq = pdev->irq;
>  	}
>  
>  	pci_enable_msi(pdev);
> @@ -167,6 +177,8 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	plat->tx_queues_to_use = 1;
>  	plat->rx_queues_to_use = 1;
>  

> +	ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
> +

By not checking the return value the patch turns to in fact containing
the functional change, which contradicts to what you say in the commit
log. Besides it's just wrong in this case. So please add the return
value check.

-Serge(y)

>  	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>  	if (ret)
>  		goto err_disable_msi;
> -- 
> 2.31.4
> 
> 

