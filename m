Return-Path: <netdev+bounces-164041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60395A2C6CD
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2869188D82B
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62551EB184;
	Fri,  7 Feb 2025 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsS1lfdk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EED1EB19A
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738941607; cv=none; b=BELVVAGBovLrBFvtALaimdZSLCn0v2DMInguFAUc4bzFowxmiSEAsuT6lexoTsCm9wVbLRhoFaK61TgWRKptNzBHuwsMpwoJ5yCBKLJmfvrAFWIvyKAeK+VuoHIaSj2ZmgTOeEx5FXXRdA3CyCuIAnZZuYkijmVV7coWfzHffog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738941607; c=relaxed/simple;
	bh=SBQ4MyZoDsmflVQ146EzX/jzu5z0ACXQWfg4e2eQLKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BP/smuGoyvSPk18xZtGmosugmQAhZ/asXdVYAAAcHBS5slqDzTj8BefBSoIklh+hBPITJNRSAFwkPX08AjQNuWg5hh4DDgq0yh9xgRVtF2PIPw7jhDIqAN94goPwoUCJTj5VyTQzV9WDz9hYpfIUbZ6xtgxeLXWK7tVs1KaVwz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FsS1lfdk; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5de459b79ddso199399a12.0
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 07:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738941604; x=1739546404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lh728/h5T9UnM+HASA8Jq2heTWOphh/67rcOx7NkUt0=;
        b=FsS1lfdk4iwnCvB6KmyStoUWttFD9pag+3a+8WKo0RkhyGOiyYZpeFUNLjEMHv38eJ
         PTuiFSwkNGatFcclLay0G4xtZHFQc/J9D84NzIxnQJ3hVoMFRtElyhDCOS1gdmP+x1w3
         Wew4+aoQBurdBF32ZPyM/2hqaQ6kYjwIh9lWNNxdq6MlDQlayUFS2RU0/xCW2mG361Ci
         z7RpSce5ZNEuGlXZ2TWwr02d3PgnYvNi1Dv6uWSUjM0b9u+JRsbDlWcesa61evSOJzTN
         /Okd0NBofygRBywdmkLqrGqQz+KQm10p0JKkcdMTZ6sYz+DYE863vn1uGG0HXt7DrSx1
         clkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738941604; x=1739546404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lh728/h5T9UnM+HASA8Jq2heTWOphh/67rcOx7NkUt0=;
        b=e0jEzj17bjfYcqlFYond0tt/PQNOsiplKbKu8RNe4GmkBGxe9VSmEZVKSn3VZEjfEy
         5iPFiIqKEHy48kEdUKoJ9kU9uEWv56UiXKLteFL7LKNaflb9h+8dJvyaW3rPFMfDFJBv
         9twV+8QsV5KEVKP2+aMpC8qNjIljbvbjtSO3ukd9M0gd6+QCajiHOwdk2oJgNut9dijU
         aoJ7qmoqXwGiJUzXv4A8Jic9dpwTQrx05vyDK4HxOrx6P66d3FFkbLcDMHBg4MtRuUmx
         xcYYxrHVW2YZSLw353/vuF7tApfFgPO3WXQsHqSoCcgVWsnqNdSxFFCEuGkXdBy0ftow
         HmRw==
X-Forwarded-Encrypted: i=1; AJvYcCUQnKdXbZXtcxQf34qZhMEd+XqvUFALq1JAvdjYuZI1b8th557p839Jl4KgyaxrsBA440ttydw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPKlPkPqOFdEAp58HmAsTAifYWhTWZXWLm6jof3OEAaZ09XtLd
	w0M9mOSW3fjREfN9mxg41Ec5UugBWWiPZ4vkVdkSblDJiMzRVJmk
X-Gm-Gg: ASbGncsKJNXlB8yZUoir8ZVrlRwLJkdF7SWeWCq1jO4k2gY4cY+ueX3Jqiv68uhe6oz
	0jXLAvL5e4v4y86ZAjLcWqUlxveoXeLoHxMi3BAmuhh0q213yQB7E8a+08Z5X8tlPE1ce3+vYr7
	/gJw+UnKvNObWjRIBOi8QQExb35NfzWrsFCz7rostvwElGTX/YXZPMrOHj8fEBi3qt4+yigVTPN
	YAl/3Z8hsponhuQWe/BFP7M9JpeTOXVG0fgzS7e+a5vK4be+jp731LF74/35a6mQcu1gqHvVDU3
	R5A=
X-Google-Smtp-Source: AGHT+IFUjfhOH0beogOCy9/ovimvABwSwvmh22ByKVKZ5A30iXNQpGJX9oTjv2FUtPbwL+S7YBZBEQ==
X-Received: by 2002:a05:6402:1e91:b0:5de:39fd:b310 with SMTP id 4fb4d7f45d1cf-5de44e5dafamr1699198a12.0.1738941603629;
        Fri, 07 Feb 2025 07:20:03 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcf6c9f9a6sm2677109a12.55.2025.02.07.07.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 07:20:02 -0800 (PST)
Date: Fri, 7 Feb 2025 17:19:59 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v2 2/3] net: dsa: allow use of phylink managed
 EEE support
Message-ID: <20250207151959.jab2c36oejmdhf3k@skbuf>
References: <Z6YF4o0ED0KLqYS9@shell.armlinux.org.uk>
 <E1tgO70-003ilF-1x@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tgO70-003ilF-1x@rmk-PC.armlinux.org.uk>

On Fri, Feb 07, 2025 at 01:09:38PM +0000, Russell King (Oracle) wrote:
> In order to allow DSA drivers to use phylink managed EEE, changes are
> necessary to the DSA .set_eee() and .get_eee() methods. Where drivers
> make use of phylink managed EEE, these should just pass the method on
> to their phylink implementation without calling the DSA specific
> operations.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  net/dsa/user.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/net/dsa/user.c b/net/dsa/user.c
> index 291ab1b4acc4..2e0a51c1b750 100644
> --- a/net/dsa/user.c
> +++ b/net/dsa/user.c
> @@ -1243,16 +1243,21 @@ static int dsa_user_set_eee(struct net_device *dev, struct ethtool_keee *e)
>  	if (!ds->ops->support_eee || !ds->ops->support_eee(ds, dp->index))
>  		return -EOPNOTSUPP;
>  
> -	/* Port's PHY and MAC both need to be EEE capable */
> -	if (!dev->phydev)
> -		return -ENODEV;
> +	/* If the port is using phylink managed EEE, then get_mac_eee is
> +	 * unnecessary.

You thanked me for spotting that this should have been set_mac_eee() in
the comment, but you didn't update it.
https://lore.kernel.org/netdev/Z4bC77mwoeypDAdH@shell.armlinux.org.uk/

> +	 */
> +	if (!phylink_mac_implements_lpi(ds->phylink_mac_ops)) {
> +		/* Port's PHY and MAC both need to be EEE capable */
> +		if (!dev->phydev)
> +			return -ENODEV;
>  
> -	if (!ds->ops->set_mac_eee)
> -		return -EOPNOTSUPP;
> +		if (!ds->ops->set_mac_eee)
> +			return -EOPNOTSUPP;
>  
> -	ret = ds->ops->set_mac_eee(ds, dp->index, e);
> -	if (ret)
> -		return ret;
> +		ret = ds->ops->set_mac_eee(ds, dp->index, e);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	return phylink_ethtool_set_eee(dp->pl, e);
>  }
> -- 
> 2.30.2
> 

