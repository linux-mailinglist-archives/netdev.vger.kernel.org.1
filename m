Return-Path: <netdev+bounces-143347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F339C222B
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 17:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB20285071
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 16:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F67192B71;
	Fri,  8 Nov 2024 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJHOtYNy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63D65B1FB;
	Fri,  8 Nov 2024 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731083642; cv=none; b=lG/LETuxY5/zXkdYv+kGeDP5bwSlyjsbCwuLfI6YmnHbGpUBkcS93mJd+JOa0bnNDNAID0FDU4wmufWFL8a75n4+85SqV1fd7DZXkpPAkxXhfLI/OfpAR2oBn+fpefn5aPT/F5yGci5SkKu8cMtiOoef84jqvANp/LeEWd9WAtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731083642; c=relaxed/simple;
	bh=xktWNTuMiZ72MJLOAB7S6Yr5eZVlmtRQhAEwW4mtcyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LCkBL6y3yI3BLYvANU/Y1Wnpf7lIgsPDttIrof1n+s2tSvx9Z923x9df7GBN66J/kn54EhCXRdp6nut5DYBNTbxODWcEtG3DIX0dvfJFebi8+ECs/TpGtm1IPc/T15FpdxKzFBvd0Het4TZM0s5mEWUoe2E5d7LxHFJuf1XBtVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJHOtYNy; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a99eb8b607aso325834666b.2;
        Fri, 08 Nov 2024 08:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731083639; x=1731688439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8gR3NO/JpXIhimimbArPALkBUq1IOEbzqt9/NB49Euo=;
        b=eJHOtYNyzw6BsO9YVpQ+a+sMn9g2ldwnGMp3k5ml+fc55SVMnccMHXKIx6yJ83Qnfe
         n07sweO1Gv4h4ajETfg8lUavglD+SeqFbWdPKI5fdrPh8s/Q9MLzIGA21ePQVY0RCazb
         DQgbaNeTSmr6j+qmNh+XMaLvVln2OoQXEumImUoy9v4Ww0q15agJbTr30lrQvwwu9pLQ
         BZ+FD3m8fOa9aovUjjYtuqyPn8YWaOUjtspPk3bRI1hLF+dU4uAwWyTME2xXcc/KuqO2
         VtOX6ANu/BbUOudzcuc6hgSuwHbzRUl672os3G4bxrUMv6/619PSIf+LV3uVhyQgsoKe
         XKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731083639; x=1731688439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gR3NO/JpXIhimimbArPALkBUq1IOEbzqt9/NB49Euo=;
        b=Qy6fCLhS2g0ycNFDDCZZaKcYVovf5uB2ye5LZhmVyHHr/FlTzknhpAH+Xp40G8RuLy
         g4RNzFIc6X+TLbATTedhOzOFq5zckSRz/Cw0P+JFOaUaq3FPeTdVkmsx2ADScMJsbwyb
         xWE5Wf6Z368PDxH9NnGVFuHNDuOiERogXhmHEWCoKiIKxhWTTcWq5zOpxNto5kFyvlHM
         nI88WmNGMAkbUZQucnYXyLf+8TT725c7SYOXizLvXzx0Y7QT7DeWbBb8/wg8Pd1g5OPn
         oqkt7U3l8ml772tqLPdzk64nC8hyO0ZwWLisxjseunrlPdJCgKqpEUOJt+NRbuVYHsL1
         kwog==
X-Forwarded-Encrypted: i=1; AJvYcCW8TVGTsa2KtFK57ng72GpJDuDdsEzVhkPLHleBLfxUnNpIr3mhvJnezWU+qatLHJWbA+GdRDHpbdVEqqQ=@vger.kernel.org, AJvYcCXxsINt0oOesQ/ozWcff2thUg8n3Ub/So8j1dZ0K3jLPBb2nnm4C9rK6h9Lhiun0TBDbzYmveh9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw26VT/+7WyRq8i/VtUVhoQYdGp05BNq5IQKvnDvVeovCJqNnyA
	TK+Y9VFhA7xrGi/8JL5al7JPWDR6AhkfAVV1kFqjy0FiNw7EXvJG
X-Google-Smtp-Source: AGHT+IH2mPEgdOfZ9O+TmYnbuKhqsqSeeI7zIE7jT3wBaJHO0lxZkOyPqvm4iWri2rH4VTSqZB8BXQ==
X-Received: by 2002:a17:907:26c8:b0:a9e:c4d2:fff0 with SMTP id a640c23a62f3a-a9eefff7ef9mr287539666b.45.1731083638829;
        Fri, 08 Nov 2024 08:33:58 -0800 (PST)
Received: from [192.168.42.14] ([85.255.233.6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0def7ecsm251452966b.158.2024.11.08.08.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 08:33:58 -0800 (PST)
Message-ID: <c0b6d0a3-66d4-49aa-87fe-85a4346d723b@gmail.com>
Date: Fri, 8 Nov 2024 16:34:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/5] page_pool: Set `dma_sync` to false for
 devmem memory provider
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>, Samiullah Khawaja
 <skhawaja@google.com>, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20241107212309.3097362-1-almasrymina@google.com>
 <20241107212309.3097362-4-almasrymina@google.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20241107212309.3097362-4-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/24 21:23, Mina Almasry wrote:
> From: Samiullah Khawaja <skhawaja@google.com>
> 
> Move the `dma_map` and `dma_sync` checks to `page_pool_init` to make
> them generic. Set dma_sync to false for devmem memory provider because
> the dma_sync APIs should not be used for dma_buf backed devmem memory
> provider.
> 
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
>   net/core/devmem.c    | 9 ++++-----
>   net/core/page_pool.c | 3 +++
>   2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 11b91c12ee11..826d0b00159f 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -331,11 +331,10 @@ int mp_dmabuf_devmem_init(struct page_pool *pool)
>   	if (!binding)
>   		return -EINVAL;
>   
> -	if (!pool->dma_map)
> -		return -EOPNOTSUPP;
> -
> -	if (pool->dma_sync)
> -		return -EOPNOTSUPP;
> +	/* dma-buf dma addresses should not be used with
> +	 * dma_sync_for_cpu/device. Force disable dma_sync.
> +	 */
> +	pool->dma_sync = false;
>   
>   	if (pool->p.order != 0)
>   		return -E2BIG;
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 77de79c1933b..528dd4d18eab 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -287,6 +287,9 @@ static int page_pool_init(struct page_pool *pool,
>   	}
>   
>   	if (pool->mp_priv) {
> +		if (!pool->dma_map || !pool->dma_sync)

Is there a reason why ->dma_sync is enforced for all providers?
It sounds like a devmem fix, on the other hand I don't really
care as we don't have drivers yet implementing queue api / etc.
but not passing PP_FLAG_DMA_SYNC_DEV.

Also, putting fixes first in the series or sending them separately
reduces backporting headache.

-- 
Pavel Begunkov

