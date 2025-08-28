Return-Path: <netdev+bounces-217720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47755B39A06
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9811C8154A
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A0530AD0B;
	Thu, 28 Aug 2025 10:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSWHKxpo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D03A309DCC
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377111; cv=none; b=qoyTVux8lwTwHyZ6bWIiL6d0gJ5orDpYEs+NnNdhJlQzVbADOcS0pS8tAD+a7kiTVYW1clQHVM6ORMoMXDH5/7iy70UqodRjfkgEv9K+gm9MVqEBdYDRudMHj5qnRgklc0vVQ0Qv9MmR70R66CL5uS47tf3d17WIn8ojVZFgBgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377111; c=relaxed/simple;
	bh=kPYl3YKYil3pSHxfmY1RAgB3q5egJbd0cVvdAezy46Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Elk7bYRN8HM0Er03Nz8sHHHJpOjpLRbxdMLaKbtucOmJeRWvHY7RIxwqIAKll84GlgGH+ldUrH7AVMaxYwUjbrzy0RvqEE7+aqGONZm/lQI9CM6JyALkdiLmVjSUlySu0riOznZD4FTalxU6UuLkGlRdtKOx9uxyIWdPl6hfFw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSWHKxpo; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b0c82eeso6385725e9.3
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 03:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756377108; x=1756981908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i51U0eoaPPpoMYXVHZWxWK3rAEERgXHNJMQ+7ZLZlzg=;
        b=hSWHKxpoVlK6zKg1BLxhJUxk08LoDhn5St9A4aY7x4Kkqi4QmH7BVdKo/kEWSlWZwy
         BpUIxoYx/7pvd2wKQanqFBsXU5Wml1G5RL8qxnke5CF4GxThJ6D7vJJEsdrQwrKu0fE1
         YQXj1IPzaCCG461CNpe8OaUw9v7YovOVejfMNaT5O+F57cJMUzl/YffNRCgPqgLJTXuG
         ZkOjlItr6pOu9UbQwQWDj4QX9sCRyYIW5mzkECJiiYAZlqvNXsm+bv+u4QjU2HbU8d3C
         3g5+r176u4SUG8LwMiDTkxgU9/VBxfqjxKrVcLnAbLu9/LLiYIq2mjP7JPw76HYIPIJh
         7vxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756377108; x=1756981908;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i51U0eoaPPpoMYXVHZWxWK3rAEERgXHNJMQ+7ZLZlzg=;
        b=f9FTEWJP6tBT5o0sVejX0TPgzIuJ99fFvhzUzsSJfjTVdo6LzEZMOEHdv7psiZUWYV
         0uD+g/Z2W8bKOhReW538KpDyEk7D0q9kuReGkc1IReTcYTvu9PKvgxerGZ5xHrr75XNZ
         R1Zgf8HBezvKW4UebTv+qG8sHxN4YBoRkFvyYE8TfBhUghqd6YLgJvktVUokg09JSOL7
         tI16oXpvGXiDE2keIsjWujhd7bm6Je8vetsT3+hR9VkTp/yAoDjn5HLGi32R2dFmgWUA
         to623eDu6XwT5Up/z/JhNpPw3/VnNms3SxZ27iXJbuhMy3UTvVmBQvl2OENalWOk7aEZ
         B4/A==
X-Gm-Message-State: AOJu0YxhywzxP6ihsdbcH5XX9kfPCxMc6rAuQ1br6gK3gB6pCTEOIdFz
	UU4jZcMBIpXtgCNRutgcr9S3are6fZ0vzPbX8ae4zBDFpd3xgT8k6ir4
X-Gm-Gg: ASbGncsAnfmWe9jmI4x6iGYqSw9pIKEO/bt7XuO8pGq0MaCCxz+OOsoO3iexEvos0oU
	nUP+mfw4PuzLr5H855Wj+Np46oMTsZiM3DOjFdwf+ujyn9KuYPyK3LeWN8UuHjJCoomqUvh5RN3
	248KyET1gEqGghIov4Ngg1ljF0aTqkMy+qF0UtsV8O0z40kbM/uliqyVomGxb+5ri//mXWzZvn0
	rUF89mw7Cjhup4LJSI1TIITgDzBYGJGsq1owyHon3ZLrsrheNobZeCdKOTtRBzqbyX2myEgw2z5
	J8iQhXuSp9M+sVjF8JznSsu4xyDAQ2MALo2tmHJnFA4te1mrEjZZmYkVjInvwLKxeS1HSK7xoEo
	QEhQuLnnp1amNw+cRBAGVv1mWezyID9ppdHk+THj28lvhErVIgxn7s74BMIGCxgciiHSSvFN/0G
	8BGz7qYbxl8SzIvFigetX8De512jj0lAxuCDFc1er6w3mDwZJyzYoG0VimZfwI1WiLOfLzWQtd
X-Google-Smtp-Source: AGHT+IEir1DwxU5KLbCsY14L3V9mo6NgJRYx4r0f65h+aA3Ea6sZB5JlWDVQ3e9bVXOh8ze9HiV6Dw==
X-Received: by 2002:a05:600c:35c9:b0:459:d821:a45b with SMTP id 5b1f17b1804b1-45b5179e76dmr197569105e9.9.1756377107987;
        Thu, 28 Aug 2025 03:31:47 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2b:cc00:8cad:6f97:fb05:801e? (p200300ea8f2bcc008cad6f97fb05801e.dip0.t-ipconnect.de. [2003:ea:8f2b:cc00:8cad:6f97:fb05:801e])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3cc4b102889sm7707838f8f.51.2025.08.28.03.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 03:31:47 -0700 (PDT)
Message-ID: <fbdea48d-2bb4-4b84-8ac4-98480fa99143@gmail.com>
Date: Thu, 28 Aug 2025 12:31:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net] net: phy: fixed_phy: fix missing calls to
 gpiod_put in fixed_mdio_bus_exit
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>
References: <b3fae8d9-a595-4eb8-a90e-de2f9caebca0@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <b3fae8d9-a595-4eb8-a90e-de2f9caebca0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/2025 11:02 PM, Heiner Kallweit wrote:
> Cleanup in fixed_mdio_bus_exit() misses to call gpiod_put().
> Easiest fix is to call fixed_phy_del() for each possible phy address.
> This may consume a few cpu cycles more, but is much easier to read.
> 
> Fixes: a5597008dbc2 ("phy: fixed_phy: Add gpio to determine link up/down.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - rebase for net
> v3:
> - add missing blamed author
> ---
>  drivers/net/phy/fixed_phy.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
> index 033656d57..a1db96944 100644
> --- a/drivers/net/phy/fixed_phy.c
> +++ b/drivers/net/phy/fixed_phy.c
> @@ -352,17 +352,13 @@ module_init(fixed_mdio_bus_init);
>  static void __exit fixed_mdio_bus_exit(void)
>  {
>  	struct fixed_mdio_bus *fmb = &platform_fmb;
> -	struct fixed_phy *fp, *tmp;
>  
>  	mdiobus_unregister(fmb->mii_bus);
>  	mdiobus_free(fmb->mii_bus);
>  	faux_device_destroy(fdev);
>  
> -	list_for_each_entry_safe(fp, tmp, &fmb->phys, node) {
> -		list_del(&fp->node);
> -		kfree(fp);
> -	}
> -	ida_destroy(&phy_fixed_ida);
> +	for (int i = 0; i < PHY_MAX_ADDR; i++)
> +		fixed_phy_del(i);
>  }
>  module_exit(fixed_mdio_bus_exit);
>  
--
pw-bot: cr


