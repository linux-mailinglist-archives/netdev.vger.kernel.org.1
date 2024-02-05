Return-Path: <netdev+bounces-69273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EABDD84A8DE
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 23:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702D41F3014D
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4D85D90B;
	Mon,  5 Feb 2024 21:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfHr2fjD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523575D905
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 21:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707170301; cv=none; b=Ll/P5bqaVWjA0vZvP3YZAU6Yp+u19U2fXQgBs4g4y4P3s/8MNSNLBuIFl2UPTIoOtOZLeSL6hRAkFP9M3DQAzQKbmbDjjc4GT5PBeCzTBiqkKCoL8fai6t+l1mNZY66uZU1OCSHk+aU9CHLROOJiDMMNi0HggK3nfsa5wbrM3mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707170301; c=relaxed/simple;
	bh=CSWBAOwXBkZGR5lHQG/3I14m1tFQ63lh2TJo9PH8elo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHAaDZEArfagoLaSj3Kmdl1UNJRgEkYCFRwUB1eahAsZvrEhTl3Iw6BM9SwyKIH790+ENViT8/6bW84lSKLgdqOVFdniQIUb8lPgVjxdr4KaikzBa7CYJmsAVGH/Nd9+q/zWYe/QL7dIMnJ2xAlLEtB6CfwmIdGqLZVrbCOkMc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfHr2fjD; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cf4d2175b2so56908631fa.0
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 13:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707170297; x=1707775097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VBoXN78EY4oRTewYgmTqB+4bSBM5W1ge6MAF23HGQ1Q=;
        b=FfHr2fjDp7dZxotzUOoW5Bn20ZcQcvkfPVhvCDKSpJZDsgK1iMSexHYMDQT6HQdASY
         w1YqUWrZrarLyH3q+LiCWklOr+KThgmr6c5USQLZwQuubsl7oMv5HDn1txCBkO0k8ZCf
         JolEYeZmaY98m9ksqZYprupEuHodOlce5WLm9h4oX4qzguU1YMweiyIrPNExMvlbwaRM
         IC7r66fbj4+h1u+xdvm0sxRQMXpEdJJAB5AAaAhBQi/hILuvjlWiyZtJ6bilZT6ofDHz
         anosPQB3gCfjH3W06dnYaS6xzrVmJpwZCzo5tvA3uCaCaSQZ21nfn/TtaBMh3V6S4hmY
         WoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707170297; x=1707775097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBoXN78EY4oRTewYgmTqB+4bSBM5W1ge6MAF23HGQ1Q=;
        b=JI2zWxcShDeXWDF+NYfx52gbVkbdfP8IyPVkqyJoD8WEWDIvt0RCGQd392YTraUuLo
         DxosHAxdaJU9pFXqa/VzWgS1Atv/JrnM1Xyoaje8/tCKsRpS7bVL3jYGX8aRs8irK8wg
         QJJlZ/AvJGu3V8jLijG6n3/6zEAFsbOseAlf+F3oyPS7wAOxGFEaf0DQMK/jBhaPzRhj
         i81d3cKVbb48Yc+yu1cXtO3uHBcmRnAUUFDQ3+PiKfMFJqbNpcI0cid1W5fSlFh+twfR
         rSU8l/rgDfI7LGnjOAWAjbxLrbwriXwEy7+bgOXA3ap20vmohiyhsAAJKW+bsupcnODy
         ygag==
X-Gm-Message-State: AOJu0YwurxnxXka301Ry2XshS2D1VAL/ece/Mn9NjUx/5VuDw1kvobxF
	8guIo4a6ZJMNAgZFBiQn4KTEE66LYSg96q0fuL7kPIJm4X1ANzg9lSVvoDD/5XQ=
X-Google-Smtp-Source: AGHT+IHmKMPEIxPK4OS6/alxmIuxOcWAbY/hvlcM2Qc3mWxk7qI2Kums9wz9oOqQ88BgDLN0Fq6Ozw==
X-Received: by 2002:a2e:a375:0:b0:2d0:a1a7:fbeb with SMTP id i21-20020a2ea375000000b002d0a1a7fbebmr318902ljn.2.1707170297054;
        Mon, 05 Feb 2024 13:58:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXKxHATJyJGL2BxC7OB/ZjqkdC4GKQd5F9Ec+lJapwHDqN1YMadANgiUDa9A1XSdOhG1Epv4EsY2/cgeFq+ryotwbiXgaZ2Ubdq8cGluhrA1uechpvHLmaB5Wq3BBGPhBoazzWSlyaYcPpEAhCW35OzbMtYl6NhFwustuZlEn9sU6U1AKsJAzaF9OiBLWENebO/DzvD767L9emKoJjRKWt27W3bfF7o8Ut+F4bQsvKfYPcaxca/wR3xII4ih3CgLxeIhlnXzyZQHgf8sMhKh/gd750uolRVAJ39iBfBxNUpPWwYoMAsdF7Zrf7BlZjveKTkHc8gpyWe5EklkRjttxi6Ee5pn+/ldyOKfAublhzLZp9FygKgctTka3SpkFEsvRcQlBz48g==
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id d9-20020a2eb049000000b002cf55fddca7sm70875ljl.49.2024.02.05.13.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 13:58:16 -0800 (PST)
Date: Tue, 6 Feb 2024 00:58:14 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 09/11] net: stmmac: dwmac-loongson: Fix half
 duplex
Message-ID: <dp4fhkephitylrf6a3rygjeftqf4mwrlgcdasstrq2osans3zd@zyt6lc7nu2e3>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <3382be108772ce56fe3e9bb99c9c53b7e9cd6bad.1706601050.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3382be108772ce56fe3e9bb99c9c53b7e9cd6bad.1706601050.git.siyanteng@loongson.cn>

On Tue, Jan 30, 2024 at 04:49:14PM +0800, Yanteng Si wrote:
> Current GNET does not support half duplex mode.
> 
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 11 ++++++++++-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    |  3 ++-
>  include/linux/stmmac.h                               |  1 +
>  3 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 264c4c198d5a..1753a3c46b77 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -432,8 +432,17 @@ static int loongson_gnet_config(struct pci_dev *pdev,
>  				struct stmmac_resources *res,
>  				struct device_node *np)
>  {

> -	if (pdev->revision == 0x00 || pdev->revision == 0x01)
> +	switch (pdev->revision) {
> +	case 0x00:
> +		plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000 |
> +			       STMMAC_FLAG_DISABLE_HALF_DUPLEX;
> +		break;
> +	case 0x01:
>  		plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000;
> +		break;
> +	default:
> +		break;
> +	}

Move this change into the patch
[PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET support

>  
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 5617b40abbe4..3aa862269eb0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1201,7 +1201,8 @@ static int stmmac_init_phy(struct net_device *dev)
>  static void stmmac_set_half_duplex(struct stmmac_priv *priv)
>  {

>  	/* Half-Duplex can only work with single tx queue */
> -	if (priv->plat->tx_queues_to_use > 1)
> +	if (priv->plat->tx_queues_to_use > 1 ||
> +	    (STMMAC_FLAG_DISABLE_HALF_DUPLEX & priv->plat->flags))
>  		priv->phylink_config.mac_capabilities &=
>  			~(MAC_10HD | MAC_100HD | MAC_1000HD);
>  	else
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 2810361e4048..197f6f914104 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -222,6 +222,7 @@ struct dwmac4_addrs {
>  #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
>  #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(12)
>  #define STMMAC_FLAG_DISABLE_FORCE_1000	BIT(13)
> +#define STMMAC_FLAG_DISABLE_HALF_DUPLEX	BIT(14)
>  

Place the patch with this change before
[PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET support
as a pre-requisite/preparation patch. Don't forget a thorough
description of what is wrong with the GNET Half-Duplex mode.

-Serge(y)

>  struct plat_stmmacenet_data {
>  	int bus_id;
> -- 
> 2.31.4
> 

