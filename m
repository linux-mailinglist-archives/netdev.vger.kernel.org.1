Return-Path: <netdev+bounces-177167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 489D8A6E23C
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 19:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F33188DD59
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 18:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C22E2627FC;
	Mon, 24 Mar 2025 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="mEcLz4qp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09972210FB
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742840693; cv=none; b=JgDqZ2yUdX9NXaM7cRFABx6aGz/SBXvUWQpyHIxeoZh7NcjOXHDXRSxv3FhLJOBsEuZZTF0DLAMk7pQOZA5EiM/skAWracp7BGPF/ps347raqynHEN0pjrCUo7boOl4qJ0RREGNaG6IRzQ6QUpy+Xtizy0UmQw44uwGtg1/k3f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742840693; c=relaxed/simple;
	bh=WiwT0XrvPrC3bVFMA4S/BESuqwYm7MiYZb2Tfa2X5Xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PEkr7lLqv+5kfgXgP2Cefz7lhnzsOUz1RNxRm2iQmYMqKhOsy47HxcB6VG9ISLCbW7gWe5m2M+WqdReIGrzcgXWUmLQJwyM2pY2CmwW37O9pnzdXjmrNxONTtzspU8uyITWhA0nseZNCUaKxgkqe8BaMl20Dhzp4m7TTlwSS644=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=mEcLz4qp; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-227914acd20so44735595ad.1
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 11:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1742840691; x=1743445491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q2XplSBrcws3RmA9Orl7MMJxKS9Jl8eEwEQfJBbWl8w=;
        b=mEcLz4qptwk/Bn2B9GvK43VbxBySmEIjmzDgA6UsNtT72fzKzwtDyr11yNBgxNNF0R
         o3LG1k37hWQ/F8KyxBHuaK3vetkgawuLTGcv82dHVZtLkKYnY+vb888odAwyOlcxKhk2
         95kpp/KdE4FQmTV/gZjXmCzO/vMO+m3moKuMnNMdGDqqw7r8gsaDza4OZNjb6lsCiU9F
         EzjcIy0+SIw0jzYycWYMrGwMs413tBvMIfv/YSvExx0Yob3IEUOt6+ZfXih2UaB1dq4L
         X4qeD1TxWZAgEJswp8y7AsLNWtFU4adS5oCqRaDr0JmwAMo8ZURkbVcJ1b0NVmAkk8xn
         AAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742840691; x=1743445491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q2XplSBrcws3RmA9Orl7MMJxKS9Jl8eEwEQfJBbWl8w=;
        b=Sjdz8AW6qHVJvTACnm9YMvI8WBJD6Y7ibBrAiFgraOTfVbwAfuHDYU7E0D2Q3CU8VC
         iTMhkxPP7BMY4awViUwjtj3sKwwz9mAKHvV/OVPJ1WNMkkZ7w2MHGtsdqZ+O9Ck77/4R
         aZwPPVk3RDyJZAzYKqKNaQ8fIMx/8/RdpGjfY8Sik8oIkCcCltmmdhTMG2CJRyHjPIjF
         JvhxfFdm1s8uaBbnM2rDpV1rLAff+k4w3kTgOFNgybDZIl/4LXOhT8NCqkinHtFc2EOO
         +nep132zg5BcaKnb5/mn0JmLn/Lxp7iJAg/0CQQQ0jgZnnAki3aDQTlUpMf/T7FAkmFB
         06Ig==
X-Gm-Message-State: AOJu0YwuqVL7aSAAjKJoUCgnqFDu+c3aEdSIHJu55oqbopVVUldwJiZ+
	hVkzJanwWueqwDx1785+B0cc7/pZS5k2G8+CSCCmZlcy7vMKJx1Mwnd+cA+icDI=
X-Gm-Gg: ASbGncvoNpe6BRvRqum6uBpdBbYST2N/KoafOHPLfAps+qG8pHZ20X/GygWfoP2zRnt
	2RSXproIqe8e6DNSWN63xejvSodTESOcL5mWXEtSmKxmnY++xiB4cuMTngxdcTSAQlIUZwOp4+O
	VK1iDC53c9MixCTkqsFDEbpOLZQzrvjE9vhpuy34mZ6bY578U/Hs7h7TvBVme+sMm5bJZkJ75VU
	IxRR9ufeb8oW1W7hfrPmkuesiU9R6KSb6aLxgTqaKL2Ak12iNfeioUOlZjNAjcbrkNjNJXs09c8
	jYiI7Ehr9Hg++wJSX4cgC7ZhXG6//vCDSM9HvPgAU+17Jr/ZwTND0idOZRPpdZQmSRC1ySsqvSS
	l/nRuv5qrIlQJmXfyxw==
X-Google-Smtp-Source: AGHT+IFmIDypCwV91aO03KswV2HrXXksnnXqAZQGCdOvLTpHFUUfrBXRGo9E07StEfVzt1BBVy1W7A==
X-Received: by 2002:a05:6a00:a2a:b0:736:5813:8c46 with SMTP id d2e1a72fcca58-7377a1b16a2mr32255940b3a.8.1742840690975;
        Mon, 24 Mar 2025 11:24:50 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1cf1:8569:9916:d71f? ([2620:10d:c090:500::7:f781])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fa97f2sm8339797b3a.34.2025.03.24.11.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 11:24:50 -0700 (PDT)
Message-ID: <86802849-6374-4146-a141-b34740463d26@davidwei.uk>
Date: Mon, 24 Mar 2025 11:24:48 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: page_pool: replace ASSERT_RTNL() in
 page_pool_init()
Content-Language: en-GB
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>
References: <20250324014639.4105332-1-dw@davidwei.uk>
 <Z-DF95BDIYF2h_k0@mini-arch>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <Z-DF95BDIYF2h_k0@mini-arch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-03-23 19:39, Stanislav Fomichev wrote:
> On 03/23, David Wei wrote:
>> Replace a stray ASSERT_RTNL() in page_pool_init() with
>> netdev_assert_locked().
>>
>> Fixes: 1d22d3060b9b ("net: drop rtnl_lock for queue_mgmt operations")
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>>  net/core/page_pool.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>> index f5e908c9e7ad..2f469b02ea31 100644
>> --- a/net/core/page_pool.c
>> +++ b/net/core/page_pool.c
>> @@ -281,7 +281,7 @@ static int page_pool_init(struct page_pool *pool,
>>  		 * configuration doesn't change while we're initializing
>>  		 * the page_pool.
>>  		 */
>> -		ASSERT_RTNL();
>> +		netdev_assert_locked(params->netdev);
>>  		rxq = __netif_get_rx_queue(pool->slow.netdev,
>>  					   pool->slow.queue_idx);
>>  		pool->mp_priv = rxq->mp_params.mp_priv;
> 
> Not sure we can do this unconditionally. Since we still have plenty of
> drivers that might not use netdev instance lock (yet). Probably should
> be something like the following?
> 
> if (netdev_need_ops_lock(params->netdev))
> 	netdev_assert_locked(params->netdev);
> else
> 	ASSERT_RTNL();
> 
> ?
> 
> We should probably wait for https://lore.kernel.org/netdev/20250312223507.805719-11-kuba@kernel.org/T/#m2053ac617759a9005806e56a7df97c378b76ec77
> to land and use netdev_ops_assert_locked instead?

Ah I didn't realise that migration hasn't entirely happened. Yes, I'll
wait for netdev_ops_assert_locked() first.

