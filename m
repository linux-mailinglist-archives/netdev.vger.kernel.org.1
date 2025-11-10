Return-Path: <netdev+bounces-237178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9344C46A1B
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 13:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8552E4E237F
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 12:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8D130DD3C;
	Mon, 10 Nov 2025 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUhEo0rk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5753230BF77
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778212; cv=none; b=naOQzLTu42tIW/uKGceyt2vGGVvH2iASyXz5Th8G4BZFxdRoFv4AGnTDkiO7wlbvTh0fHEMjD8Yj8iUkK/jAcdoEO7D64PS9ckKFAZtJsT0lhVCiYg2yZKKZwyEn4wh5rNjbSD2FEGn1aFe9170yAwMTKuzX+HDY+ThpwZxUavQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778212; c=relaxed/simple;
	bh=/F8CU/GYM3kJa4k9M7OB1gti3rW5dpGB1vRfRxNdvqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rUOOomA1D/cOrMPHCsr8LiTTQmaFNhlIWKZG010Ki2UeRKNW6oG3qNRvEOuq+LBdxhqEifSXQSRwzabgRkhhvGNu340UcIMIim7LSod0huu9MIjzIf+ppa4NUNCVoOu4ahvqHFFnDNWxUC85bi/2TuzGU36jurexprYBK8JN8H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUhEo0rk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47774d3536dso12812235e9.0
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 04:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762778209; x=1763383009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BDisWXX1Y3E46k0LejRtyhxBgaWtSH2jsdovoZRUi74=;
        b=RUhEo0rkhRjV++knqGkaySZb1GLgWwjX7bwtxtCfI+o7t8NY6h19pKjXoHMCT/AMDJ
         yi7ZpIJy9xCUm5k+4gpsEd+CmztFQC2oi1QzVFLwYNc/Af1zuW8F3QLd+AhYIu3nwJJn
         Kih8u7RkMNdsyUeG0/Dm+qmiy8FdUhJi5Tkq3ThMiqL5kc32uX9TvXgTKtxEYl41ZMt2
         rQyKMdXCxbrAlvJyboox8C5T4l5kGw2FTP31quOb2Hbt8Xzi3MtNPMb+kB0O5Xx2nUiX
         cFfMNZ/IdFxZr8nsWaZgnA5+Juo1mMbWTLPzidYquR1xFY+csrT+oBNf5bQgcJFeNSxH
         UuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762778209; x=1763383009;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BDisWXX1Y3E46k0LejRtyhxBgaWtSH2jsdovoZRUi74=;
        b=mMz0wfIjFJ9GG6FTkiXczGWdNMJB+QZrpptkbbOt3qmlfcg1j08k8hNGy4tWdHJTid
         UhZ0TmrbHT1VX4EIochbUvgh2si6pbGgMI23rM9WaIfolsGzVxzMIMnQvFe32pKKo+6V
         e/ya5ONa9DmtOKND3E25FENYmu9J+Sg7jq3jZQE2Vdp8HTwn85uk7Z6RGx5Y4vdJdEkE
         D2ZRdpbExnn5B2AN2VAzFcj76vp5I1MmFgGmkj9e8lFjCsmk0ZDsFYD/6QQkIlA7Eo5c
         Tw+B0htbV6tXiEobippKPLPs+xDnK7D89Udml2tKvhx6rNQtRi8txtSJkTiQjUQn7lbx
         YdnA==
X-Forwarded-Encrypted: i=1; AJvYcCVGN9xXLPBLR87L+ymIMMlCnU9RPG9XZk9quEdUViyHd/sgp/UCtlr/pPFz3XNo4iVed4O3H8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ7D464ylnc9uEa4fKTADOfKfiNsLmHqJuBCt9k6ziDC+9vARl
	f77PRuMg9iWdk3L+IphxSLm9Or/n8dBO80zA+1SyCu7hr1V+KrFwpVU2
X-Gm-Gg: ASbGnctCx0MONuiJd6bo3TLurI7IDZBYBNDmN1HWVN6cKpsK0IG10rKsr0Aqa6pEaqW
	9h8DDS6XbrUyAoORaetzED653hgK5spZLbBb7b8sLphHJpeBdJ69+wfF+jnsaiFeTUqTAQ0KG5e
	+4vM7Qdw0t+mjtJ1dDfBtqlO+VKLPKy4xRbaP9Im1klpFdufF+wIbwgW0vsS2lMTASfS6WtmTcO
	s85tHUtgolTabphXVsmWtqUdPF6TmKy8nasTvEgl7bkpdc+nKZyNmbFqO31D4vQgqbQbPP8sIO0
	bkJFRSmDKMgnOeM2a9WBhre7TtlBXL6QSmKMXc4PjcO2JuHcqelr+86kgDAeDw4Sg2xxVCnWrWy
	b7oq2IMaiKj1WjBEJxTOwJqSNSHOo8AD1f9cZFBqGWe2QUnkgqqbdOiZoWNWFlGqjgTCwuXDWcX
	+sQ2nwTLVkBwcprss7mTBW+00N0ZdoxcpaZSK2XPmm/N8tCpbsQGs=
X-Google-Smtp-Source: AGHT+IE8JnaqwYx1qAF2XhA4+KMEvpg0Zw8lsdqb6Uo4fgD6jKgMhNhYdA+4ok4hdFeiyUu/ZLO15g==
X-Received: by 2002:a05:600c:c177:b0:471:665:e688 with SMTP id 5b1f17b1804b1-47772dfcf3emr65298225e9.17.1762778208522;
        Mon, 10 Nov 2025 04:36:48 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b303386f1sm13557436f8f.3.2025.11.10.04.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 04:36:47 -0800 (PST)
Message-ID: <ca3899b0-f9b7-4b38-a6fd-a964a1746873@gmail.com>
Date: Mon, 10 Nov 2025 12:36:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 2/2] gve: use max allowed ring size for ZC
 page_pools
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 ziweixiao@google.com, Vedant Mathur <vedantmathur@google.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <20251105200801.178381-1-almasrymina@google.com>
 <20251105200801.178381-2-almasrymina@google.com>
 <20251105171142.13095017@kernel.org>
 <CAHS8izNg63A9W5GkGVgy0_v1U6_rPgCj1zu2_5QnUKcR9eTGFg@mail.gmail.com>
 <20251105182210.7630c19e@kernel.org>
 <CAHS8izP0y1t4LU3nBj4h=3zw126dMtMNHUiXASuqDNyVuyhFYQ@mail.gmail.com>
 <qhi7uuq52irirmviv3xex6h5tc4w4x6kcjwhqh735un3kpcx5x@2phgy3mnmg4p>
 <20251106171833.72fe18a9@kernel.org>
 <k3h635mirxo3wichhpxosw4hxvfu67khqs2jyna3muhhj5pmvm@4t2gypnckuri>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <k3h635mirxo3wichhpxosw4hxvfu67khqs2jyna3muhhj5pmvm@4t2gypnckuri>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/7/25 13:35, Dragos Tatulea wrote:
> On Thu, Nov 06, 2025 at 05:18:33PM -0800, Jakub Kicinski wrote:
>> On Thu, 6 Nov 2025 17:25:43 +0000 Dragos Tatulea wrote:
>>> On Wed, Nov 05, 2025 at 06:56:46PM -0800, Mina Almasry wrote:
>>>> On Wed, Nov 5, 2025 at 6:22 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>>>> Increasing cache sizes to the max seems very hacky at best.
>>>>> The underlying implementation uses genpool and doesn't even
>>>>> bother to do batching.
>>>>
>>>> OK, my bad. I tried to think through downsides of arbitrarily
>>>> increasing the ring size in a ZC scenario where the underlying memory
>>>> is pre-pinned and allocated anyway, and I couldn't think of any, but I
>>>> won't argue the point any further.
>>>>    
>>> I see a similar issue with io_uring as well: for a 9K MTU with 4K ring
>>> size there are ~1% allocation errors during a simple zcrx test.
>>>
>>> mlx5 calculates 16K pages and the io_uring zcrx buffer matches exactly
>>> that size (16K * 4K). Increasing the buffer doesn't help because the
>>> pool size is still what the driver asked for (+ also the
>>> internal pool limit). Even worse: eventually ENOSPC is returned to the
>>> application. But maybe this error has a different fix.
>>
>> Hm, yes, did you trace it all the way to where it comes from?
>> page pool itself does not have any ENOSPC AFAICT. If the cache
>> is full we free the page back to the provider via .release_netmem
>>
> Yes I did. It happens in io_cqe_cache_refill() when there are no more
> CQEs:
> https://elixir.bootlin.com/linux/v6.17.7/source/io_uring/io_uring.c#L775

-ENOSPC here means io_uring's CQ got full. It's non-fatal, the user
is expected to process completions and reissue the request. And it's
best to avoid that for performance reasons, e.g. by making the CQ
bigger as you already noted.

-- 
Pavel Begunkov


