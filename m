Return-Path: <netdev+bounces-178569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7A9A779A7
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 13:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A784188FE09
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 11:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCACA1FAC33;
	Tue,  1 Apr 2025 11:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKXlPgfQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086A61F91CD
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 11:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743507381; cv=none; b=Kq78EwYF3jJAxXoxWCsVy/8bP07duEcAwqFtZP+UWIaPTYFaWZv5mTkVW+3Vd0qksJjUq/n7n1ijTfWMdsx5hL6eF+sQ6eOEUI/UA2JmBLgGCZCuG3yep1bQDfNkrHI/aLocP06d7QeE3jUwCqbbDih2HDH4xUdTdYo1/rkjWD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743507381; c=relaxed/simple;
	bh=uL7TvS0jxMjjrKYeadjaTz4r0PxHMC116KdpVCXfges=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oks4lcJoA8+1c+3bkYMqrf6h5JGo+AAXvpIIG8SbUmPQAQddm9jvGR36XNrAGHUq5mwPlF+gL68swChNrrgTKc0NIHk5ebSlaqFmCDMVcVTo/ixoxgPE4ooPk9VWKGGdpOrQJN5zzm6Gir2gfc6H55Moroc9pstPdgZwZ/w1zkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKXlPgfQ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso1106658566b.3
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 04:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743507375; x=1744112175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CIarTnop7r79FG0iKaDMlMH6a2WjIZFcRgHpoMoYXr0=;
        b=kKXlPgfQVgEy/iMVOsksmp9X5CbyxgH24DrOGGaurBls2SOSilYxxAz9ZWCxdAl6Ag
         qRkWvw42lZ6u8t1KGSGAtkj5wDIKoklA0OpYD04a0r6D9E7XbvCwVOOWPoyiSWr3ZcLx
         ifoMHDjp+lqE462F2JPmYcKwmQW7t1/OWaIbo7nbpPRkDKcjb1o7giymFMZK+OFPsMGq
         ep/pr09Yisf+wd3Ro+yVYon6FECyeonc7GamYvV7kzimMI9B5h7Qg1DjmzaACron4ODz
         1d4yk6QazYCjB1d2HuiTJEuZttWW6kiBe7BbSAt70gz+l8TUOzMWTnDhtyi+0MNXY4du
         d7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743507375; x=1744112175;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIarTnop7r79FG0iKaDMlMH6a2WjIZFcRgHpoMoYXr0=;
        b=LDYiqNWtkvJZ65crC+TU4o9dJ3Z3Os3LwZWu2Je0RCQlAikmb+GtUvA+xKwENDYGaM
         Gkl8fXVkjKxiYP3zoMqOfqd4sOHYZk12JxzpmRV0VekNGbdAWPfGdvW+gLXptU98Bx4z
         31BBahj1iayKdOInJ0QvNWKLrgXTUppMtP6Q9fZPvsLa8p/yzHRug1Ml2IC92hgzqEQq
         YYM9juDFWCH6WpnsQZR/TCU49x0VMNjM8YZKqDMToIBmj8VmrwxpZ3nVGgVhLJ6yKMb8
         kjSoMen3f/2WjSrc6KujzBN1m2s+Aw+en2MN2li5eFlKshWLKY9uRYnXUUQGpa+R18p3
         jhQg==
X-Gm-Message-State: AOJu0Yx0CncuE/su6BgPwK9c8Pdr937ctWiTuzkR4pnX5QrYDvTgfvAX
	/+IuzoDbb1wWGkLmxOWP/e6G2ZB9wrt5eBQvQcPidSyaMf+nkCcp
X-Gm-Gg: ASbGnctbS80364HW2DmZVJFob+yUg9200U8E+PxzEyE9XBcQkLWvxyUX8lFtbthf9/Q
	hYgBrg1K3laPoO5tX2fxOlnmpWaBRUAvm3Aynx7plrpZc0kD0GJf1bsMZvoA0YbvVsKq7WtXEDG
	mTirmwld4siT0dJFRqs8fyeyWDlz6XuBirvAYDqZFIj8OfcDt9FqOl4OWiGspGCaLMxYHcbHdzS
	f9DyamSqpS2GHLpfjXyIVGkDnwNtHokakhE8dBgJWOrKnMUd3yrGmubtWaSpiJK6ndxbbQ/m1KV
	NLvxuLor5yySx/CIqio5MRDqvrK/e0dXjHxRWAfqwmKW/tix+ODFNJ9k
X-Google-Smtp-Source: AGHT+IFcdlFCOdEOw90getE7Ym8/TIApcfHpWBBOaxPWhaw1FeQTgr1w4jdVpK0Ezczp7DjTBCf50Q==
X-Received: by 2002:a17:907:9411:b0:ac3:3fe4:3378 with SMTP id a640c23a62f3a-ac782af4c9bmr238618466b.12.1743507374874;
        Tue, 01 Apr 2025 04:36:14 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::83? ([2620:10d:c092:600::1:8c87])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7192ea10bsm750309966b.83.2025.04.01.04.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 04:36:14 -0700 (PDT)
Message-ID: <32917bbb-c27a-4a65-8ba6-1df5c4729c12@gmail.com>
Date: Tue, 1 Apr 2025 12:37:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: move mp dev config validation to
 __net_mp_open_rxq()
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, ap420073@gmail.com,
 almasrymina@google.com, dw@davidwei.uk, sdf@fomichev.me
References: <20250331194201.2026422-1-kuba@kernel.org>
 <20250331194303.2026903-1-kuba@kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250331194303.2026903-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/31/25 20:43, Jakub Kicinski wrote:
> devmem code performs a number of safety checks to avoid having
> to reimplement all of them in the drivers. Move those to
> __net_mp_open_rxq() and reuse that function for binding to make
> sure that io_uring ZC also benefits from them.
> 
> While at it rename the queue ID variable to rxq_idx in
> __net_mp_open_rxq(), we touch most of the relevant lines.

Looks good, one question below

...
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index ee145a2aa41c..f2ce3c2ebc97 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -8,7 +8,6 @@
...
> -
> -	err = xa_alloc(&binding->bound_rxqs, &xa_idx, rxq, xa_limit_32b,
> -		       GFP_KERNEL);
> +	err = __net_mp_open_rxq(dev, rxq_idx, &mp_params, extack);
>   	if (err)
>   		return err;

Was reversing the order b/w open and xa_alloc intentional?
It didn't need __net_mp_close_rxq() before, which is a good thing
considering the error handling in __net_mp_close_rxq is a bit
flaky (i.e. the WARN_ON at the end).

>   
> -	rxq->mp_params.mp_priv = binding;
> -	rxq->mp_params.mp_ops = &dmabuf_devmem_ops;
> -
> -	err = netdev_rx_queue_restart(dev, rxq_idx);
> +	rxq = __netif_get_rx_queue(dev, rxq_idx);
> +	err = xa_alloc(&binding->bound_rxqs, &xa_idx, rxq, xa_limit_32b,
> +		       GFP_KERNEL);
>   	if (err)
> -		goto err_xa_erase;
> +		goto err_close_rxq;
>   
>   	return 0;
>   
> -err_xa_erase:
> -	rxq->mp_params.mp_priv = NULL;
> -	rxq->mp_params.mp_ops = NULL;
> -	xa_erase(&binding->bound_rxqs, xa_idx);
> -
> +err_close_rxq:
> +	__net_mp_close_rxq(dev, rxq_idx, &mp_params);
>   	return err;
>   }

-- 
Pavel Begunkov


