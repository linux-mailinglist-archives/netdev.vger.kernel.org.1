Return-Path: <netdev+bounces-98047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA558CEC49
	for <lists+netdev@lfdr.de>; Sat, 25 May 2024 00:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B17E1C21050
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 22:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1C280603;
	Fri, 24 May 2024 22:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlOi1fHi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233DD3C2F;
	Fri, 24 May 2024 22:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716588354; cv=none; b=LxV6ZDyv8wFlRBM1tAR1q7k2pfj8kiyCiiGOeODnno4pV5LGgj5I0EX0fE9CKn+PzeSDguHoGmlnzf/XSu0GJNpYrUGGAGSJcItmPVz9mSo+ndV/c/LmfbXliTn23Fr5kRzn8tKZa/351INApLtdpK9HDRjOaiMtxi7JWrQaDjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716588354; c=relaxed/simple;
	bh=IU+Cm98Qx7XtdyHvTjcm673l8WTlTvYwT6HIrJvEhQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nneg2edJALNf9r3ATJEmlnNwjFI7BrSGQpzVl4JKi3BfsQVlhI5yfgepodm5SekBMaGEdiZzW6/LzX2+kmyE82YLC3oTiTvNcewIolWrEcSZkaSMxhtKYMATCNVJFsaxGm6YGs4i05325Yx5IkADSW4Uy6GhFIvHwBxxtuSwShE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlOi1fHi; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-43fb155fc69so6640421cf.2;
        Fri, 24 May 2024 15:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716588352; x=1717193152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IAYxZszWXfq4NbDhTEbpXy+KJA6nuz0wbn+BTig+3kw=;
        b=RlOi1fHi3MIJpJdMEruhjBK2TciifDd0jlA0LTjAR30TZjbKNzcLZEoeku/dhG9nf5
         LpNSQVzSZb0sJo490XvrbDRgbqRYZQn9cP/qTfR5qFOsZPgIa1v1dIa3X9CQ0zMC4fCU
         4D4qXnfncvSWsoGSvK6uKWUn/otmq5WNaXs6IQllRWvo4+H9OBJYFK8ruOFZgkuPOLab
         0QNnNWhZgZZOC9jO33dRhSQCVPrGK8PVpHszYPKT8mdJ+fx6besctsK9/4CQjTekIbzK
         fGBqXfWZTeO3NKwoGhztN1iKIKfrUHszBaGC2rSm/nyUpineiLG9eDIWgK8cSH0oTXJP
         q+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716588352; x=1717193152;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IAYxZszWXfq4NbDhTEbpXy+KJA6nuz0wbn+BTig+3kw=;
        b=ufGTKCyS+RcvcVABfNelTXeIA8pjRQNDtFIPqi4oK+3nXIqIhUG9I0XkyojMOcE8At
         XuJcy2AdcgrjsMH9nqRmp/sp9+0JMdOgWOsfVHSZKZWeVSS6S2aiSdCK+9bettLjckfc
         8X24xB65OD3cyN75bEWSZ0OfY2Hdk0SkemsNVymNdzGvAPqzMVf8fp4YDwZ9pbTttoZT
         pQLIkqmm1NHMkZqMwAhUZLZrA4MZkyBhfhUf7McLuGDDGd0aPquQFR7d1ZTtCKa7oJwN
         ByxO8oTcLBaDBqezFgk4fhhso2XPiVxmDaiP5qfTNvpohz/MjnjVXN6Vh4ZR1Z9wPYuR
         vmIA==
X-Forwarded-Encrypted: i=1; AJvYcCVkFCPqjXYRdBf0nIj9CbMIwCtCfQrMNyn2WFW6qWoBfI9ioDW5hPnv+Wix/sNKgM5YVahVvp2RUn2lvUxIiPVETlR/5T9Z
X-Gm-Message-State: AOJu0YwfUu2hj9Z3D9dJy8/MDPU2xpwloJkVV/tFan9m33w57SiQlP5m
	TuF93FUveiFE35k5W2RAAlU6oVTpxLLpWoKONoQzzSah75VdEJIl
X-Google-Smtp-Source: AGHT+IHNwfc8ckj1uYGJ1lgzjeovsJV+OEtRwme4FaeKLQXaKC6ePocu6wxTZUQNaDM5vziKicHBKQ==
X-Received: by 2002:ac8:7c4d:0:b0:43a:1377:60f2 with SMTP id d75a77b69052e-43fb0e98e21mr35610701cf.36.1716588352016;
        Fri, 24 May 2024 15:05:52 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-43fb18b027fsm11892321cf.76.2024.05.24.15.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 15:05:51 -0700 (PDT)
Message-ID: <bf1f7e35-45f9-4129-a41e-d255ad00c917@gmail.com>
Date: Fri, 24 May 2024 15:05:47 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix start counter for ft1
 filter
To: MD Danish Anwar <danishanwar@ti.com>, Andrew Lunn <andrew@lunn.ch>,
 Diogo Ivo <diogo.ivo@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>
References: <20240524093719.68353-1-danishanwar@ti.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240524093719.68353-1-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/24/24 02:37, MD Danish Anwar wrote:
> The start counter for FT1 filter is wrongly set to 0 in the driver.
> FT1 is used for source address violation (SAV) check and source address
> starts at Byte 6 not Byte 0. Fix this by changing start counter to 6 in
> icssg_ft1_set_mac_addr().
> 
> Fixes: e9b4ece7d74b ("net: ti: icssg-prueth: Add Firmware config and classification APIs.")
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Would using ETH_ALEN not be a bit clearer here?

> ---
>   drivers/net/ethernet/ti/icssg/icssg_classifier.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_classifier.c b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
> index 79ba47bb3602..8dee737639b6 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_classifier.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
> @@ -455,7 +455,7 @@ void icssg_ft1_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac_addr)
>   {
>   	const u8 mask_addr[] = { 0, 0, 0, 0, 0, 0, };
>   
> -	rx_class_ft1_set_start_len(miig_rt, slice, 0, 6);
> +	rx_class_ft1_set_start_len(miig_rt, slice, 6, 6);
>   	rx_class_ft1_set_da(miig_rt, slice, 0, mac_addr);
>   	rx_class_ft1_set_da_mask(miig_rt, slice, 0, mask_addr);
>   	rx_class_ft1_cfg_set_type(miig_rt, slice, 0, FT1_CFG_TYPE_EQ);
> 
> base-commit: 66ad4829ddd0b5540dc0b076ef2818e89c8f720e

-- 
Florian


