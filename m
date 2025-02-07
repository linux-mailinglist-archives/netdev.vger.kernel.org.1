Return-Path: <netdev+bounces-164118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A18A2CA68
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 18:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F2E188D1F6
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 17:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD0619597F;
	Fri,  7 Feb 2025 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="srAac+z9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F336A18E050
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738950000; cv=none; b=fGz1SlCgASChIGHBVq4NZmQot8MV8WRoMQv96ZJD8/1W8D+T2FeF6+ABzOmSKRZXJ4XvLrHm36cL++MwxIMBHDOPHVUJ1dpTCz9TssbUzgbn9RfY+prViICVULFLMGh+b3upT+qyghwBcoZWtBvWKLqi3mZKttn6lXJB9XiTnkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738950000; c=relaxed/simple;
	bh=riq/CY74pjqc7hoeUCw3A5jSjpnEdW/Eu2wmTlSk7Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/LKGfjQRtYsMuIaQTs4KlSS4ANFPlBZoKGv6m5FRmEkbryh1K3NQmbdIfrzMyZqKuqGZFm0nxuKVwvJJ7CWDDC4C9UDHJ8DkSei+/R0lpDG0P0MEwBe+GPAtg0HtX0o9pGllj9LtcPS4cTlQE8SJ3l0h1jqr9HIZHDP9hVu0FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=srAac+z9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2166360285dso43111495ad.1
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 09:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738949998; x=1739554798; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dmmypO5lGpZElJBOwBx5Lqq47jvwTZgB8nZohxAsWnU=;
        b=srAac+z9eQCg/vz0BGPMgOn2FqLYq5HCMTx2lX/2Bj/c4MsCcyZpcrrp5NNo8zxG4j
         7bRgNDvSORVBlpAt3fYDwY/R2zxGD3szhstjA21DCNalvnPUVUHJ3CU3J8j0lIFZ0R9h
         hViXzWa44dnJYqy0Kb6exs5Ewu2dqOT+zB7bMOoe+PDI4adPTCKO2+xvuIwl2+6f3TEX
         14OcLA4h9PxwIKFHppPN7JqDGSLU9T7YgpMP04LdW7KZxpXVO3gAIFiehITE/Naw2cof
         vfNT7tLwoUUHrQL0lSdygoamXE5ZhpHUl4mmNvYoPlbXGCU9EpA55DVrvqKVJV8ke0QU
         4WSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738949998; x=1739554798;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dmmypO5lGpZElJBOwBx5Lqq47jvwTZgB8nZohxAsWnU=;
        b=Jj2bPiBASyYNvd9mDL7ZzQDJ8IoSZGvzVSURWHIPyHJmbC3C7xiUVqfWdw0XuKlIrJ
         zp/lOExQylCHZgs81fn0px2FnXwx98WgQHU4H1e7miy9oUJ1SfkYWQOge0z5epw/n5J1
         kdf974WzpFrcyi2mHYWHpuOVRxFUJFgnCYJgpleKORbspd+ziLiVxmrPofj/7uHPnMIk
         kjOUxJrQ/8tOL3sRc600EAuK5/dHXP/EvnXio/Xaf/fk2Yy9soR0TUAlXYxuqnHstCwk
         GfT7c1I9O4dn+yIakhEsJicfIFs09Xs1nJ7AFJEMmkMSlIma/gZT4xqcLJI/kuFjH63L
         ikLg==
X-Forwarded-Encrypted: i=1; AJvYcCXwEc+iAjmXJbFF4Exa780z+aw29w0Lph0BchC8Owsx41hbtiqLawo42486AfDj9PQLbQsBCJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYWRApgDTbUqDYItQ54MsQKjz7gwLH3h9stuyEIV1NPwvBnQt2
	PW2/UrNlRi+2BkLhC4DGRAcrj5A3JtY+I+mkcEbgtIzbI89fohkOD5lfdImBhg==
X-Gm-Gg: ASbGncuvuNsHhQYwf7rN5yyuiFI4I2WmNQlolYSfMHj6aSTW7lUfbGUVmBOZhpFyevj
	c2pi1ptvti0Z4t6ABw7KM0dqR/UyrXhh3F1r6QWoAIUGiiaPKjSyc3xfHdUHxSMWtlARY4upMCK
	CQW2HzgxskgqzLq1Oc52UAb8dl81LR8twYa21xnwu/idI5zpQnIHgqYE0/RzV//q9eISMK+l4Eo
	+FcHnkJz/voKLfIASiSwRrI6MLPQc4poq310Yu0lCTnaV6/wegV1wgcwMhwEkQ5RlJM5l7Oh8lx
	uyS9+/pkfWdXzjr9gQdWxcmqUw==
X-Google-Smtp-Source: AGHT+IEHqbioMS1WS0fxuFiPxBnBQRht7nJ0wdLWWq8J6BK7IgFAuo6kNnHsIYM7adDcTJZyHqhf+w==
X-Received: by 2002:a05:6a21:99a6:b0:1ed:a4cd:acfc with SMTP id adf61e73a8af0-1ee03a3cf11mr6657350637.10.1738949998229;
        Fri, 07 Feb 2025 09:39:58 -0800 (PST)
Received: from thinkpad ([120.60.76.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048e20b2esm3324297b3a.179.2025.02.07.09.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:39:57 -0800 (PST)
Date: Fri, 7 Feb 2025 23:09:52 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH] net: ethernet: actions: Use
 of_get_available_child_by_name()
Message-ID: <20250207173952.lpeazjyxnhfuhwb3@thinkpad>
References: <20250201171530.54612-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250201171530.54612-1-biju.das.jz@bp.renesas.com>

On Sat, Feb 01, 2025 at 05:15:18PM +0000, Biju Das wrote:
> Use the helper of_get_available_child_by_name() to simplify
> owl_emac_mdio_init().
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> This patch is only compile tested and depend upon[1]
> [1] https://lore.kernel.org/all/20250201093126.7322-1-biju.das.jz@bp.renesas.com/
> ---
>  drivers/net/ethernet/actions/owl-emac.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/actions/owl-emac.c b/drivers/net/ethernet/actions/owl-emac.c
> index 115f48b3342c..3457ce041335 100644
> --- a/drivers/net/ethernet/actions/owl-emac.c
> +++ b/drivers/net/ethernet/actions/owl-emac.c
> @@ -1323,22 +1323,15 @@ static int owl_emac_mdio_init(struct net_device *netdev)
>  	struct owl_emac_priv *priv = netdev_priv(netdev);
>  	struct device *dev = owl_emac_get_dev(priv);
>  	struct device_node *mdio_node;
> -	int ret;
> +	struct device_node *mdio_node _free(device_node) =
> +		of_get_available_child_by_name(dev->of_node, "mdio");
>  
> -	mdio_node = of_get_child_by_name(dev->of_node, "mdio");
>  	if (!mdio_node)
>  		return -ENODEV;
>  
> -	if (!of_device_is_available(mdio_node)) {
> -		ret = -ENODEV;
> -		goto err_put_node;
> -	}
> -
>  	priv->mii = devm_mdiobus_alloc(dev);
> -	if (!priv->mii) {
> -		ret = -ENOMEM;
> -		goto err_put_node;
> -	}
> +	if (!priv->mii)
> +		return -ENOMEM;
>  
>  	snprintf(priv->mii->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
>  	priv->mii->name = "owl-emac-mdio";
> @@ -1348,11 +1341,7 @@ static int owl_emac_mdio_init(struct net_device *netdev)
>  	priv->mii->phy_mask = ~0; /* Mask out all PHYs from auto probing. */
>  	priv->mii->priv = priv;
>  
> -	ret = devm_of_mdiobus_register(dev, priv->mii, mdio_node);
> -
> -err_put_node:
> -	of_node_put(mdio_node);
> -	return ret;
> +	return devm_of_mdiobus_register(dev, priv->mii, mdio_node);
>  }
>  
>  static int owl_emac_phy_init(struct net_device *netdev)
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

