Return-Path: <netdev+bounces-101977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6E0900E09
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 00:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47061C20D0D
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 22:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12122155354;
	Fri,  7 Jun 2024 22:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6PGMJVo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D30814533D;
	Fri,  7 Jun 2024 22:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717799298; cv=none; b=H6a/tAGMof1fr5sTifMbq8oicmqD3q4DciVvuOfNgwxNvbE9DZ+itqtyEO/v1C/9b6kVPzsyMnLuzFF4MmXgVLoz5owBOPZDbBG+tpCCKB3xa+6zgVk0pkZkiK/r6E+5kPqbd5mIeAAO55QAfHwivsCjyNPmIJfR43q7drp41uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717799298; c=relaxed/simple;
	bh=l/MrSi5lk5PVhPYbVtxedDFG6aG0Vvkjcl8AeXQ8zoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwLxaLTCdFwpi6IeHGrH5z6K9Ls6t6QHeA4+EERZ5KseMpp6vpRUUB38z4BrtCIz6agcjyh9Jbw3CC+htoU5lKCLwXAyw3G67sO16kcTiPzW2q+DksYrYe0GrPytHeuiC+oZBy6gWE1cf9Vs3xu7SsW6PLJ5nez0xcICBXXo1Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6PGMJVo; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52bd48cf36bso878194e87.3;
        Fri, 07 Jun 2024 15:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717799294; x=1718404094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k4BkUg/TA3tRYPVfwl6zlyTMojUBhX6Gv43Vrpcb6ng=;
        b=N6PGMJVoRUG/Z/4lhTKZv5P3bFloxFc0P1kBtYK9rK26wuWA1vTzWW+T4guDmW8zAs
         uZkAw7S+vyDs1WS2YU3ugldvvxpRL2PpNImjTwH+qONltOXycMvpgksyeo/uxbrhckZg
         0thbyWM8QDIJNGHKQPRy2WmzuC/KDMzoXiIE/ZgrqMk9ItrAhv/EjOUKAee4969f5K/6
         7n1BMhyASS7zitBm3tge2PfC89hNhmHr2MdDod2lVKVNWzRh/6aZw0UfuZkrhgQlwuG/
         TFZebLip7l+7M7Zc5CGkDCyatsuM6Wzb2OPP0wh0Xf/kacdXp3C3jNSyYZvnWbJCcmin
         xlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717799294; x=1718404094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4BkUg/TA3tRYPVfwl6zlyTMojUBhX6Gv43Vrpcb6ng=;
        b=hwGh+boWsNdppcmm3WnBfcpWEEhMgq/lactYXCqXi9qVyV2vf6UvcyhVJYxAnE5gTI
         AUzApsYLWazntfuWP1Flphd4WJB99v4R5KeZsFd9iTEvr1BtQbz1qQzv7RQLoLGkiWmD
         QDxqkCHdS97uEHc/ddnlhf9o7+PGp3OzMcYB/OxnQPvPHgVk/9KDJtVVDX5nIYdDzsqM
         YUegFyFgKiI/Ek416Et78yCyLsmBBAYAr0I3wJ/OkNimtqc+YQXFKwReP8ehfxbF0k5X
         Mc4A/cg+eIMimF1wSsGjrZWKbXyMHIEfZxtOW0lr8LIkxIo3NIFiJWNYFequpy5UFm4c
         j9rA==
X-Forwarded-Encrypted: i=1; AJvYcCV7uMDaxxj52Dq0z3QVyz0Z6kT6e+F7ODE0Md18W2cLUyYat+cA2FZT7Ny/S4ktZWy1HlmAjIwoVximjPB8NFLgMAxddWYzSV+hLQZT
X-Gm-Message-State: AOJu0YyQNm3+7E7aGLrPkibr6/FLYXLXBkwrUHTw9QxSpcZ+HfA5SPY+
	iDAd2Zz2v4GlLsocyzpq45ZjxQxREPtu1M5SNv7s6MeUonrsTnbW
X-Google-Smtp-Source: AGHT+IFKhhMBptFKALqKje48pRi2hZGZ0cjPVsMJ6FqppKEsD8Zktc7poDtemXuD1UC1Dzh9PB46+w==
X-Received: by 2002:ac2:4854:0:b0:522:2c9b:63b7 with SMTP id 2adb3069b0e04-52bb9f68965mr2292504e87.14.1717799294139;
        Fri, 07 Jun 2024 15:28:14 -0700 (PDT)
Received: from [192.168.0.5] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421580fe343sm99432215e9.6.2024.06.07.15.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 15:28:13 -0700 (PDT)
Message-ID: <30d71968-d32d-4121-b221-d95a4cdfedb8@gmail.com>
Date: Sat, 8 Jun 2024 01:28:48 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] net: wwan: Fix SDX72 ping failure issue
To: Slark Xiao <slark_xiao@163.com>, loic.poulain@linaro.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 manivannan.sadhasivam@linaro.org
References: <20240607100309.453122-1-slark_xiao@163.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20240607100309.453122-1-slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Slark,

without the first patch it is close to impossible to understand this 
one. Next time please send such tightly connected patches to both 
mailing lists.

On 07.06.2024 13:03, Slark Xiao wrote:
> For SDX72 MBIM device, it starts data mux id from 112 instead of 0.
> This would lead to device can't ping outside successfully.
> Also MBIM side would report "bad packet session (112)".
> So we add a link id default value for these SDX72 products which
> works in MBIM mode.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Since it a but fix, it needs a 'Fixes:' tag.

> ---
>   drivers/net/wwan/mhi_wwan_mbim.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
> index 3f72ae943b29..4ca5c845394b 100644
> --- a/drivers/net/wwan/mhi_wwan_mbim.c
> +++ b/drivers/net/wwan/mhi_wwan_mbim.c
> @@ -618,7 +618,8 @@ static int mhi_mbim_probe(struct mhi_device *mhi_dev, const struct mhi_device_id
>   	mbim->rx_queue_sz = mhi_get_free_desc_count(mhi_dev, DMA_FROM_DEVICE);
>   
>   	/* Register wwan link ops with MHI controller representing WWAN instance */
> -	return wwan_register_ops(&cntrl->mhi_dev->dev, &mhi_mbim_wwan_ops, mbim, 0);
> +	return wwan_register_ops(&cntrl->mhi_dev->dev, &mhi_mbim_wwan_ops, mbim,
> +		mhi_dev->mhi_cntrl->link_id ? mhi_dev->mhi_cntrl->link_id : 0);

Is it possible to drop the ternary operator and pass the link_id directly?

>   }
>   
>   static void mhi_mbim_remove(struct mhi_device *mhi_dev)


