Return-Path: <netdev+bounces-68861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 709A78488E1
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 22:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370EB283B9D
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 21:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351DB11714;
	Sat,  3 Feb 2024 21:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUn6R/3V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48E911CB7
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 21:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706994472; cv=none; b=YUIRYsnHRYL0yI3GRqHgHprymdqWuuEVgRw0F8r+L8Tx9dbmTk35WxvpAIgkPF88PD87IPggYO1yoeQGTtkVmMhetkvi8yaiTeCdZQHdQwwW7XLUvTnzCDSja8p6udZnHBGnsg0ccvKtLFxYLsOv95XREPeR8BXrxtG9XjhNlUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706994472; c=relaxed/simple;
	bh=CJvcjLxEMC97Ikcf8mI+1kspVRG/yeMcYRqgKuCfhx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dlv5QbRYQ9bJlcUWGz2uNlh3QcdFIeXw9gUQBat9DrJMG3RxmxZTGASlShOIVFp0AKy3ILTInUBjFGcQe1k/1an4m4k/5BSxvMNGBkO2D4P2pWuJUPMl9JF/NEOyEQxMOiulCZ+75e+Wy3pd6HsBaToImgaTY9+B365+iQtT01M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUn6R/3V; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so2105168b6e.3
        for <netdev@vger.kernel.org>; Sat, 03 Feb 2024 13:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706994469; x=1707599269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W6JBhOdNBv0C3Z2m/8gn8AYW6yadHTmz3ySCW2bS8N4=;
        b=BUn6R/3VOAzQQyQmJP9nQrBTVfOg8qphkyp7sG8z6/HoKnyWDsMCEjGlkGm+wwI7ZF
         oKnvtaDFmrrUnNDTC7bldgrskfvQ/5KLWrQHWEXj4PJrvVYF7olTOMy3W9qk2DoiC0f0
         TNSm9zMuTExcVuf9HNOBC1HZ4ItwIun+7I/EJJNvJZ2dC5mxfy304cL7U5nDdoeO1s3f
         7e+B4SIJdchU+6sAX9aTH5Dv4EWOMHeBqvrQrcHmsjFPEjcXWeqOqKhyfNSObUhlILoE
         aBbIqooScCiFAG+x05zFPnERuG47lcneR+jaw6qETJU93+CCRmjmaOup0/Gv37wllgXJ
         v0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706994469; x=1707599269;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6JBhOdNBv0C3Z2m/8gn8AYW6yadHTmz3ySCW2bS8N4=;
        b=MKnJrbPSBU/bTtjO3Dc6u58ZyfimTTVCeoFiDIGWA7CzzB8FehFGgE7oezHqFIP+sP
         ShJSae+8gxk9n6O7QMZoFntXVUNO1t6mh5ZB/aNFtTdoWXjB6FtjMydMp437ZNGhvPlS
         arCjlDatvpyS0tt96yOGTIqvVOhXSnZ+DXo1aE76EnIklCr+TKuZbtBCnbisO6sju7bP
         9LVbifmyIewvielq9qT+Fyxf5t6S0eVsWuOxE2UHdomxodQTroR2dBEQXHl5OzMs+2zt
         UXL0UsMLxQPq+gZcOZjaV1Dc6kQkYSFfVbS9rEv7zd5l4O7PejSgCYm0vBaIWeB1A1Vu
         PMhQ==
X-Gm-Message-State: AOJu0YwEoxQVtctL9vgncUaezQXcAh/4C1UbbB4yV7FtdrP+WdoLtnuO
	s8jNGTVH9qAbGEWAtHvmKhukwI5fxVLsvKNYDgo8b2Yv8dkL9w2k
X-Google-Smtp-Source: AGHT+IFxIvoDNhNuDw0P3tyvQU6q8aPxi0e06/PNuTEzZt2qbJ9VHrE5NnIWRC56wmcygr2y7OuO0g==
X-Received: by 2002:a05:6808:10d2:b0:3be:b609:4de0 with SMTP id s18-20020a05680810d200b003beb6094de0mr15357001ois.2.1706994469632;
        Sat, 03 Feb 2024 13:07:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWbEiPEiTy8iZBiPOz8O23eMbhnv6vpnw79gOr/TkM53asAisDqUtNsEs0bAoF33qbJqGgV6FxW18TEPqVC+esOgitl1s5qD34HrjTb/c7WbUNnFYghHvD9ZaXhIGE6+N2sAbbyE0arMOII4zBuHi3e0/yxoPZXIL8Gzx7+OqIv6MS7V4Dm8wa2RMJu6k/ytzznJZmuJsfPFLHZlEe/4jrM7mWywIlKxsCjqalGzqv2IpT31cHgMQs+eCdSTbzaBe9OQ3dCxNJBsT84IYgp9EoOGx4bSH9QocE=
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id gc7-20020a05622a59c700b0042be1092915sm2135641qtb.10.2024.02.03.13.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 13:07:48 -0800 (PST)
Message-ID: <9098cfde-ab40-494e-bda2-11a498ff36a4@gmail.com>
Date: Sat, 3 Feb 2024 13:07:46 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: Return -ENODEV when
 C22/C45 not supported
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, Tim Menninger <tmenninger@purestorage.com>
References: <20240203-unify-c22-c45-scan-error-handling-v1-0-8aa9fa3c4fca@lunn.ch>
 <20240203-unify-c22-c45-scan-error-handling-v1-2-8aa9fa3c4fca@lunn.ch>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240203-unify-c22-c45-scan-error-handling-v1-2-8aa9fa3c4fca@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/3/2024 12:52 PM, Andrew Lunn wrote:
> MDIO bus drivers can return -ENODEV when they know the bus does not
> have a device at the given address, e.g. because of hardware
> limitation. One such limitation is that the bus does not support C22
> or C45 at all. This is more efficient than returning 0xffff, since it
> immediately stops the probing on the given address, where as further
> reads can be made when 0xffff is returned.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>   drivers/net/dsa/mv88e6xxx/chip.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index 6eec2e4aa031..ce4e4bdf475d 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -3633,7 +3633,7 @@ static int mv88e6xxx_mdio_read(struct mii_bus *bus, int phy, int reg)
>   	int err;
>   
>   	if (!chip->info->ops->phy_read)
> -		return -EOPNOTSUPP;
> +		return -ENODEV;

Still not sure this is the right way to do do it here.

>   
>   	mv88e6xxx_reg_lock(chip);
>   	err = chip->info->ops->phy_read(chip, bus, phy, reg, &val);
> @@ -3659,7 +3659,7 @@ static int mv88e6xxx_mdio_read_c45(struct mii_bus *bus, int phy, int devad,
>   	int err;
>   
>   	if (!chip->info->ops->phy_read_c45)
> -		return 0xffff;
> +		return -ENODEV;

Whereas here it makes sense to me to switch to -ENODEV.
-- 
Florian

