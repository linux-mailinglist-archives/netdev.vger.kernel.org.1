Return-Path: <netdev+bounces-210290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC374B12A7B
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 14:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847DAAA4788
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 12:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09789244668;
	Sat, 26 Jul 2025 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="J6Cb4Ht2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167DC1519BC
	for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753532969; cv=none; b=CLVTVovVAD+wmw6j5J8yk2Lyt7S+/++c2AkKRiB0dXpLAKrn6REq20cxgD2+D+zQEEKwCkmypySkujALssDDW88rurlw7xw4jnwZuiTijMu30XeSRhUGehO7bP1ycFYvgWIjVGqR0tlehMZKfErurv0ZFIlA8be6zGHlCBlAG3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753532969; c=relaxed/simple;
	bh=acS3TcRp0IFBla5GzmXaAZ3vduHqjQS3zora3KH25cE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/QwwsnAjbXCSnPHO9DVVqB3SFGE+rfpQYVIDNrpfcVHZetnbmpXc5CQ5xsxHGB3KuFzUEdm2GK0+UKB9WZN7YIkovp0C0gwBSSf7Qrsg6MVy66qXj46joTuhOf+kw4O2iEK8FZkgdqd/jZyh8QvC5NnYwybGmW2tt/C6/pV9ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=J6Cb4Ht2; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b7746135acso1092604f8f.2
        for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 05:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1753532966; x=1754137766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tq7o8SSXRPeCQp7FcYkHKHQttGEL/6wn8IjaNQBmSkk=;
        b=J6Cb4Ht2zt7ki2j6mV3eQemV8y8yMJIFTiohsiOMUs7fR9maVEqwhk9kWljzTDk5uk
         rAqJvowtITbckMBkkwIUDEEI/GBsr3MbkAu9pbjydtPR8+qYgIu8UvtUrzrwGzU0YiQW
         3fbO/oJV95goJwGpG1Tt3k2/Z1stKQIowpfCQwW+n37/DccGJzF8fiabQs5NHcQxgLhc
         xLtoqbjq7qA9EqpLeHAvkl4YKRH7oN7nt1Sr4FTQfz32MRDnbYmL2rdDafePmN4bjv5F
         BmZxLRoHH5cQ4Gr3hT0eYLeofIZalp3Edw21KFwG6lsRnc8LzsQt8LFZDNnRSJJXqUFY
         2ysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753532966; x=1754137766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tq7o8SSXRPeCQp7FcYkHKHQttGEL/6wn8IjaNQBmSkk=;
        b=bxn9Arc/jqQINfNfsTvSLMZuRUvpKiDSAeX8x5quzY5duk5w59XwpjQTMW0DgW9+Ea
         E89ipZnxE6efIC5O02uYl6qYsKMkJOJVUMZRwTSAAA/W/86DhEweJXqxlyL6xXshDJKk
         3StXmJITk0giEiBtXm0XMGXKP/oTlrs1PhvN5RSeX3DjkhUgJbEJEh+/p+KAwfp0lNnE
         v5FlwnEqEcNZDe+UOuadFN0Lbh0W30b3bw1O7t93bWlDx1DNOxpht7vpl0dYRPiB0Ytw
         ZS0aZLe2zzVntQp3A8UBWc8FXNIJGiWzRb94Xgh2SF59EsGMO5GHiLvHMSevAR88EwrQ
         Lu5A==
X-Forwarded-Encrypted: i=1; AJvYcCWg/L0tEEYSxrL2jy3nav3P9nQzEo4MI16ztVAcZM0WwKcaTrabne8KjAXu8lpfqM10LVefxF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH+FkfZVHGhqbaz5Oi9G5qN9DEp65WsUFjEcA+6WHC/wE9W4rn
	jCAOdidv6+JPwdTZi1SbsRojMXPcLOUXelYZWPWc2If1EBDxRc9ZgJLIqZiK9jQawHg=
X-Gm-Gg: ASbGncs8YDFwqbUCNPfizdr7/4bjwGZlijFgMkQN7F8SCGLNE4iTpBs2j8uGG6YZsZ2
	V/kfZ/mVjptd/GAWGmIm1xJvNFEahv2OgxI5eHlO9Qj5s2PHQ93Fd+6GE4r4NfzjDWDoOZg1bfA
	bmjYwKhcbURJ+O7pDnqQ4A9ufGLydANE7KJ1TDyWGzbSdvJF9Ilc0GTeJ5giaTZZGsOduywA5NB
	Y9QC9raWnf4ecg5EvtFVp+PMOgfu3cPm5cn/38Z8gBCe0gPc1SJlRU4j3z427C+TwoFG4cGB0Ss
	gmsDS4YDpMHsYIyrxeenZ487muPF3oTJ7bo7PNg+ZA2mWof4np+rUEHwMZsaAYPVT+Xg3CtdnwA
	Bzlj/2DIKnQ8MJMxyPnOP0usVWR0AuIbH
X-Google-Smtp-Source: AGHT+IFwFr+YbmIgW8FNAod6BBfgOyG1bPNKLa0RMe2ETv+F9JCPjm3hnxYgcB5QBEVag+bmapiFSQ==
X-Received: by 2002:a05:6000:144d:b0:3a6:d93e:5282 with SMTP id ffacd0b85a97d-3b776693becmr3681515f8f.59.1753532966311;
        Sat, 26 Jul 2025 05:29:26 -0700 (PDT)
Received: from [10.181.147.246] ([213.233.88.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778f16819sm2730804f8f.67.2025.07.26.05.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 05:29:25 -0700 (PDT)
Message-ID: <8c34af6e-9cd0-4a2a-b49a-823be099df55@tuxon.dev>
Date: Sat, 26 Jul 2025 15:29:23 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/6] net: macb: Implement TAPRIO TC offload
 command interface
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
 nicolas.ferre@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: git@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250722154111.1871292-1-vineeth.karumanchi@amd.com>
 <20250722154111.1871292-6-vineeth.karumanchi@amd.com>
Content-Language: en-US
From: "claudiu beznea (tuxon)" <claudiu.beznea@tuxon.dev>
In-Reply-To: <20250722154111.1871292-6-vineeth.karumanchi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/22/25 18:41, Vineeth Karumanchi wrote:
> Add Traffic Control offload infrastructure with command routing for
> TAPRIO qdisc operations:
> 
> - macb_setup_taprio(): TAPRIO command dispatcher
> - macb_setup_tc(): TC_SETUP_QDISC_TAPRIO entry point
> - Support for REPLACE/DESTROY command mapping
> 
> Provides standardized TC interface for time-gated scheduling control.
> 
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> ---
>   drivers/net/ethernet/cadence/macb_main.c | 33 ++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 6b3eff28a842..cc33491930e3 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4267,6 +4267,38 @@ static void macb_taprio_destroy(struct net_device *ndev)
>   	spin_unlock_irqrestore(&bp->lock, flags);
>   }
>   
> +static int macb_setup_taprio(struct net_device *ndev,
> +			     struct tc_taprio_qopt_offload *taprio)
> +{
> +	int err = 0;
> +
> +	switch (taprio->cmd) {
> +	case TAPRIO_CMD_REPLACE:
> +		err = macb_taprio_setup_replace(ndev, taprio);
> +		break;
> +	case TAPRIO_CMD_DESTROY:
> +		macb_taprio_destroy(ndev);

macb_taprio_setup_replace() along with macb_taprio_destroy() touch HW registers. 
Could macb_setup_taprio() be called when the interface is runtime suspended?


> +		break;
> +	default:
> +		err = -EOPNOTSUPP;
> +	}
> +
> +	return err;
> +}
> +
> +static int macb_setup_tc(struct net_device *dev, enum tc_setup_type type, void *type_data)
> +{
> +	if (!dev || !type_data)
> +		return -EINVAL;
> +
> +	switch (type) {
> +	case TC_SETUP_QDISC_TAPRIO:
> +		return macb_setup_taprio(dev, type_data);

Same here.

> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
>   static const struct net_device_ops macb_netdev_ops = {
>   	.ndo_open		= macb_open,
>   	.ndo_stop		= macb_close,
> @@ -4284,6 +4316,7 @@ static const struct net_device_ops macb_netdev_ops = {
>   	.ndo_features_check	= macb_features_check,
>   	.ndo_hwtstamp_set	= macb_hwtstamp_set,
>   	.ndo_hwtstamp_get	= macb_hwtstamp_get,
> +	.ndo_setup_tc		= macb_setup_tc,

This patch (or parts of it) should be merged with the previous ones. Otherwise 
you introduce patches with code that is unused.

Thank you,
Claudiu

>   };
>   
>   /* Configure peripheral capabilities according to device tree


