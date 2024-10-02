Return-Path: <netdev+bounces-131105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9120E98CAFE
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 03:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D491C2131F
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 01:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED5079F5;
	Wed,  2 Oct 2024 01:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e44DKcTh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B62523A;
	Wed,  2 Oct 2024 01:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727833981; cv=none; b=hnlMWPEV0GQgkb1Lirue5WyyJyE6o2pK1yJKg5EOZ3n3N8Z+2n+MwtQRswZO2zSA4OaAGDxm9Z7B0342cPvLzUV3TrrNSvh4l/aC/JFpUzT/JjZ1PQqMjLVdqGgts3Q6R2RVukM/LiRoIxMpiYZhi7ZYa89j9z6wqQWn3JcZ0MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727833981; c=relaxed/simple;
	bh=MnfnAQlh6YMooD+uT61O7iO2RW5mU2uOH8MFgp0WnXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mK8h7Tvvugm2TXRACXtFdKzSe5S4sT5xoKMW2/E1UGZrkJTrZiWGaNDRdnE5qC+/s8Y1ppSAYr8FRrKaS/pVUl4gj1lUawwOVNTmHyb5FsvHUWjSyg+LF4RLuABq6IId6/X4xo3RMi6qBZiG6pBFv+S/KJjndyrXLhRX7LsWS6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e44DKcTh; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-718d6ad6050so5170671b3a.0;
        Tue, 01 Oct 2024 18:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727833979; x=1728438779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=34EgOlt4L/U5Kyo+sNtl1YrYc/zileH6M/6pYZpSzag=;
        b=e44DKcThDjrqxNnLIeMfgCk8WTrfo59dW0ZElJTbZxQRy2Rg6C7RyF4azvLVxonBBu
         gmeeIwHC2UA/FlWoxD0/oVPNpkZ90lUx4rV81dG2Xte1GTXyMwBM+Pz/lHeQRDg7rXXH
         VzbUOy+9H7R+9I/Nokf3fZzefoVuhjOGHMshTUQokAJW7KkWhs7WxrIlkCX6UMWgie+i
         FYHo5jYlsUVRgNGp76r2p5ji/sCEWSjfnbhkrRvnG6SgD0ZVNNQa2FV65b5f3hJgVu1L
         lUVnDnUQ7Ves/V4ZHajqZ6+UPwoX2LotupL9/NlZfOvKJ+CF81w10TiCLNtAVUZlzwx+
         qEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727833979; x=1728438779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=34EgOlt4L/U5Kyo+sNtl1YrYc/zileH6M/6pYZpSzag=;
        b=K57fIQ0u8qfp+Vwarf2Xif31k2Gbl+qHyLpcJ5zfU4MNP3fjxRvhJ44c0uLTLKQouI
         h5V663hOMugkdbHFz22hqnDxUUAp0VIInAc9LUGmWCHWp7rJCuB2gfc/7vC+TKR+tNfS
         gMq0dFXFh2gTGUkF5zeqL8iZ648Z8aDh8yhFm5UsbddNBIL+ngK4Zt9vWRK3/PePro6o
         vCYZNTNRfH0TMmbkUYzf/SZ0i4x95gsnL9ZHNkq8NkKIxbZb2FWXZyYS5j3L72MbXxJj
         OYfGPuNwCC4Pi2V6lbfTKSYWKeignqcYNrqOdDMLz57/swLgsVutK0XhegYHhmW1bFm3
         fCPg==
X-Forwarded-Encrypted: i=1; AJvYcCUSs/6PfQyLDtClqc4pS4Ulc6ow9jLHdQSnCWVQxuYY414nI5P5D70RsbIekfgJNhlZ7XBThEP3qMMqV7I=@vger.kernel.org, AJvYcCWyhf4vZVw9pRhas2AyvcMO4ooSnJr6E+KAbMZDmkxXb2Wr7raaOoXDFOHTzeOqeRP5NAG9FSOt@vger.kernel.org
X-Gm-Message-State: AOJu0YzMLfrisydfyaSKic9lv/KNHaLFpDjfltZgx77b/VYgLxU7ZHif
	JHE9HoNjnKTEeRNyS3ONdOpuUpfUPRjWxOaPSOWvobLEtH207V4G
X-Google-Smtp-Source: AGHT+IFSmYEzQp2AsN3IXmsjyW2BTnGZUiyvNNzhC7PKYf/ytPs4n7fyYl6ygTRyJJB+URjlQUp2OQ==
X-Received: by 2002:a05:6a00:3910:b0:706:74be:686e with SMTP id d2e1a72fcca58-71dc5d7255cmr2664135b3a.26.1727833979227;
        Tue, 01 Oct 2024 18:52:59 -0700 (PDT)
Received: from ?IPV6:2409:8a55:301b:e120:50d1:daaf:4d8b:70e8? ([2409:8a55:301b:e120:50d1:daaf:4d8b:70e8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2652b50fsm9101870b3a.141.2024.10.01.18.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 18:52:58 -0700 (PDT)
Message-ID: <b071b158-6569-4bda-8886-6058897a7e28@gmail.com>
Date: Wed, 2 Oct 2024 09:52:51 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] page_pool: fix timing for checking and
 disabling napi_local
To: Paolo Abeni <pabeni@redhat.com>, Yunsheng Lin <linyunsheng@huawei.com>,
 davem@davemloft.net, kuba@kernel.org
Cc: liuyonglong@huawei.com, fanghaiqing@huawei.com, zhangkun09@huawei.com,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240925075707.3970187-1-linyunsheng@huawei.com>
 <20240925075707.3970187-2-linyunsheng@huawei.com>
 <d123d288-4215-4a8c-9689-bbfe24c24b08@redhat.com>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <d123d288-4215-4a8c-9689-bbfe24c24b08@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/1/2024 7:30 PM, Paolo Abeni wrote:

...

>> @@ -828,6 +837,9 @@ void page_pool_put_unrefed_netmem(struct page_pool 
>> *pool, netmem_ref netmem,
>>           recycle_stat_inc(pool, ring_full);
>>           page_pool_return_page(pool, netmem);
>>       }
>> +
>> +    if (!allow_direct_orig)
>> +        rcu_read_unlock();
> 
> What about always acquiring the rcu lock? would that impact performances 
> negatively?
> 
> If not, I think it's preferable, as it would make static checker happy.

As mentioned in cover letter, the overhead is about ~2ns
I guess it is the 'if' checking before rcu_read_unlock that static
checker is not happy about, there is also a 'if' checking before
the 'destroy_lock' introduced in patch 2, maybe '__cond_acquires'
can be used to make static checker happy?

> 
>>   }
>>   EXPORT_SYMBOL(page_pool_put_unrefed_netmem);
> 
> [...]
> 
>> @@ -1121,6 +1140,12 @@ void page_pool_destroy(struct page_pool *pool)
>>           return;
>>       page_pool_disable_direct_recycling(pool);
>> +
>> +    /* Wait for the freeing side see the disabling direct recycling 
>> setting
>> +     * to avoid the concurrent access to the pool->alloc cache.
>> +     */
>> +    synchronize_rcu();
> 
> When turning on/off a device with a lot of queues, the above could 
> introduce a lot of long waits under the RTNL lock, right?
> 
> What about moving the trailing of this function in a separate helper and 
> use call_rcu() instead?

For this patch, yes, it can be done.
But patch 2 also rely on the rcu lock in this patch to ensure that free
side is synchronized with the destroy path, and the dma mapping done for
the inflight pages in page_pool_item_uninit() can not be done in 
call_rcu(), as the driver might have unbound when RCU callback is
called, which might defeat the purpose of patch 2.

Maybe an optimization here is to only call synchronize_rcu() when there
are some inflight pages and pool->dma_map is set.


