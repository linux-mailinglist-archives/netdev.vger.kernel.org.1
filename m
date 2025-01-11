Return-Path: <netdev+bounces-157361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C579A0A0FA
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 06:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9904A16A494
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 05:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5340154456;
	Sat, 11 Jan 2025 05:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bw2jX81r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A2B14A4F9;
	Sat, 11 Jan 2025 05:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736573088; cv=none; b=pd0kiWGF5raKxhoLZx3ir/zeCcxk4xCNUhrSU+t27yZJuA/Py/lgCqL8lN7xLD7emwLbAcV/2nmPFW+92O11uxRXk62XpL1TJA2qAwQGg4Qw2EMCUdAhRcuFw6+5Isevr4Eab9RRlYmfILfh4rebQBtVwLhaK37bZU1zO8gST6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736573088; c=relaxed/simple;
	bh=e2qml34ZRUyQuSCOyxdKyZ4W0KBXCUlFDZvJ92MDmrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CoEDzl1E2vAcw5gmx5NJ5sODCye4fY4Q/BxXxJJDKjUFaEFsJxkI2uu4n8HbHGQT8Qoy3zKn7PUhk6Ti2qVOakt1jXj9KYsqww2B4aRuLDZMA19J8+Qsvo5QWM5yIXF7fRrnbpdmfXEHLhPS8ttuGpyjcIlmHxFJsJFoIar5DD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bw2jX81r; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2163dc5155fso49595015ad.0;
        Fri, 10 Jan 2025 21:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736573086; x=1737177886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CrOkUPKltKPJNogJ44d0cx+chEbjLM41vI6YQen+kMU=;
        b=Bw2jX81rGthE8VJbU7cDsBneZ/OO/sKu9nY5OGtcPJK0wHovnY2DZ5nzU097AJ7VeF
         qJz2h2NlnUaRU9ESFqIwxqDbjl+3hG58E0fg4XC5d+IFroKrK4/avwYaDvLF9DqZnWRu
         Z5SBT7HpoegFrvMEVRxzS0Koa7UE0o6cWnO6ODfu1jAqJ9hdkA85X6mXFxAogOOB9JOq
         ZWeLWqFuo+fHN4/DsHtcj0P5rREgvSMdsHl/yF19X0xEcCyOSDUElNdbjCEfLtD5Vq4+
         Qh2PMF17CkxR4AQ6KD1CeZdbH1Eu/YTDIEDy2j2P16PO0BcLDuI8RylIyFchovbPOBAT
         Z02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736573086; x=1737177886;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CrOkUPKltKPJNogJ44d0cx+chEbjLM41vI6YQen+kMU=;
        b=u+t/B7vP6c4u3nuvbyFrH0LAdnJMLzoqoQD6LSWsBqAxC3XoGEowjclreBCFadwAVG
         K5cm7LVhshOfhorNRCtn+zvNZqlIuHzhBGG3ig/cE0k2mNpidFO0ssBv+z0YxqX/KNnh
         LR1gpv371OkzCWCbI5zMsEtfklFgGNMW9A7wjuDHG/fqNKWAM2d5oq3CrL6cXxkjGhKN
         rZtq+iFdITLKy9d99IinwHur4U8No8w4jZGLmoR515u/DgoemLwyXGwn/y1er+xj1sYv
         IOdg0ptfnP39kpNoJ2jtyWCIwDmv/Uyh7pmn8WiYYrEcq13PLrJGv194Jed2mCl+JM7R
         scvg==
X-Forwarded-Encrypted: i=1; AJvYcCWuQNFMl2qGeF4ZXuq/ac+i8U8j1IUS3vJApUQ0VYCM5iRWlo+U8dtsYrSuia8F8JLiZJPjJE6i@vger.kernel.org, AJvYcCXaGtSZtRtNuDOpxNGyzrP00IZaGIZpK8als/qgcbeu11I8S/9RmAauIJUtRs/7LUKw0P/BOSIKPiI9wko=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQFSJPqHwCZU87X3iwRs5hSvZrTp1jhkSKWxnZjpxTBrdGLIDf
	9sZgVexxwt89pGfDrqhvXrKw5YM4k4hVJTCpohC4kjkndQST8Smc
X-Gm-Gg: ASbGnct6VKMbOAkBVdwUPDeNJRd3pkNtb/sMZdcM8sxOK66KJBy+tQNULodg4LuDaIF
	nwxpFpveFWPk6sNjZdhGXtO34HqfV+5qAFfAmkxTPlex1PMD1xWLtfLwEtdnBlvDXMMP0u9sbUT
	9Yipan7NP+6tGOV8zRnuG07kHTnxP6eMAPdoRoL3YB9a29/5ik+YRYKBBfzuNwD/Kcw6akGmD/1
	RGaRdY8YEf+Ti9n7UFQVavlG2OsqoC1S1n6Z46rjm1syaBMHiod3mIfv4rXw5FhuSewRMsv/fWt
	izFrz+uNMKiQSz6ikx+RM8Regt6wN7zgrSr9nZMc/ads
X-Google-Smtp-Source: AGHT+IHcTRl8dSenGPygXjkugm99jkSxeFFPH8/0qyv90uh+a0u4SO050Tx/yJR9MpzYvmpvieEaTQ==
X-Received: by 2002:a17:902:ea03:b0:216:31aa:12eb with SMTP id d9443c01a7336-21a83f72913mr194078155ad.31.1736573086311;
        Fri, 10 Jan 2025 21:24:46 -0800 (PST)
Received: from ?IPV6:2409:8a55:301b:e120:a011:fd25:f5d7:a808? ([2409:8a55:301b:e120:a011:fd25:f5d7:a808])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f253ec0sm21095985ad.236.2025.01.10.21.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 21:24:45 -0800 (PST)
Message-ID: <5059df11-a85b-4404-8c24-a9ccd76924f3@gmail.com>
Date: Sat, 11 Jan 2025 13:24:38 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/8] page_pool: fix timing for checking and
 disabling napi_local
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com
Cc: zhangkun09@huawei.com, liuyonglong@huawei.com, fanghaiqing@huawei.com,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250110130703.3814407-1-linyunsheng@huawei.com>
 <20250110130703.3814407-3-linyunsheng@huawei.com> <87sepqhe3n.fsf@toke.dk>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <87sepqhe3n.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/10/2025 11:40 PM, Toke Høiland-Jørgensen wrote:
> Yunsheng Lin <linyunsheng@huawei.com> writes:
> 
>> page_pool page may be freed from skb_defer_free_flush() in
>> softirq context without binding to any specific napi, it
>> may cause use-after-free problem due to the below time window,
>> as below, CPU1 may still access napi->list_owner after CPU0
>> free the napi memory:
>>
>>              CPU 0                           CPU1
>>        page_pool_destroy()          skb_defer_free_flush()
>>               .                               .
>>               .                napi = READ_ONCE(pool->p.napi);
>>               .                               .
>> page_pool_disable_direct_recycling()         .
>>     driver free napi memory                   .
>>               .                               .
>>               .       napi && READ_ONCE(napi->list_owner) == cpuid
>>               .                               .
> 
> Have you actually observed this happen, or are you just speculating?

I did not actually observe this happen, but I added some delaying and
pr_err() debugging code in page_pool_napi_local()/page_pool_destroy(),
and modified the test module for page_pool in [1] to trigger that it is
indeed possible if the delay between reading napi and checking
napi->list_owner is long enough.

1. 
https://patchwork.kernel.org/project/netdevbpf/patch/20240909091913.987826-1-linyunsheng@huawei.com/

> Because I don't think it can; deleting a NAPI instance already requires
> observing an RCU grace period, cf netdevice.h:
> 
> /**
>   *  __netif_napi_del - remove a NAPI context
>   *  @napi: NAPI context
>   *
>   * Warning: caller must observe RCU grace period before freeing memory
>   * containing @napi. Drivers might want to call this helper to combine
>   * all the needed RCU grace periods into a single one.
>   */
> void __netif_napi_del(struct napi_struct *napi);
> 
> /**
>   *  netif_napi_del - remove a NAPI context
>   *  @napi: NAPI context
>   *
>   *  netif_napi_del() removes a NAPI context from the network device NAPI list
>   */
> static inline void netif_napi_del(struct napi_struct *napi)
> {
> 	__netif_napi_del(napi);
> 	synchronize_net();
> }

I am not sure we can reliably depend on the implicit synchronize_net()
above if netif_napi_del() might not be called before page_pool_destroy()
as there might not be netif_napi_del() before page_pool_destroy() for
the case of changing rx_desc_num for a queue, which seems to be the case
of hns3_set_ringparam() for hns3 driver.

> 
> 
>> Use rcu mechanism to avoid the above problem.
>>
>> Note, the above was found during code reviewing on how to fix
>> the problem in [1].
>>
>> As the following IOMMU fix patch depends on synchronize_rcu()
>> added in this patch and the time window is so small that it
>> doesn't seem to be an urgent fix, so target the net-next as
>> the IOMMU fix patch does.
>>
>> 1. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/
>>
>> Fixes: dd64b232deb8 ("page_pool: unlink from napi during destroy")
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> ---
>>   net/core/page_pool.c | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>> index 9733206d6406..1aa7b93bdcc8 100644
>> --- a/net/core/page_pool.c
>> +++ b/net/core/page_pool.c
>> @@ -799,6 +799,7 @@ __page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
>>   static bool page_pool_napi_local(const struct page_pool *pool)
>>   {
>>   	const struct napi_struct *napi;
>> +	bool napi_local;
>>   	u32 cpuid;
>>   
>>   	if (unlikely(!in_softirq()))
>> @@ -814,9 +815,15 @@ static bool page_pool_napi_local(const struct page_pool *pool)
>>   	if (READ_ONCE(pool->cpuid) == cpuid)
>>   		return true;
>>   
>> +	/* Synchronizated with page_pool_destory() to avoid use-after-free
>> +	 * for 'napi'.
>> +	 */
>> +	rcu_read_lock();
>>   	napi = READ_ONCE(pool->p.napi);
>> +	napi_local = napi && READ_ONCE(napi->list_owner) == cpuid;
>> +	rcu_read_unlock();
> 
> This rcu_read_lock/unlock() pair is redundant in the context you mention
> above, since skb_defer_free_flush() is only ever called from softirq
> context (within local_bh_disable()), which already function as an RCU
> read lock.

I thought about it, but I am not sure if we need a explicit rcu lock
for different kernel PREEMPT and RCU config.
Perhaps use rcu_read_lock_bh_held() to ensure that we are in the
correct context?

> 
>> -	return napi && READ_ONCE(napi->list_owner) == cpuid;
>> +	return napi_local;
>>   }
>>   
>>   void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
>> @@ -1165,6 +1172,12 @@ void page_pool_destroy(struct page_pool *pool)
>>   	if (!page_pool_release(pool))
>>   		return;
>>   
>> +	/* Paired with rcu lock in page_pool_napi_local() to enable clearing
>> +	 * of pool->p.napi in page_pool_disable_direct_recycling() is seen
>> +	 * before returning to driver to free the napi instance.
>> +	 */
>> +	synchronize_rcu();
> 
> Most drivers call page_pool_destroy() in a loop for each RX queue, so
> now you're introducing a full synchronize_rcu() wait for each queue.
> That can delay tearing down the device significantly, so I don't think
> this is a good idea.

synchronize_rcu() is called after page_pool_release(pool), which means
it is only called when there are some inflight pages, so there is not
necessarily a full synchronize_rcu() wait for each queue.

Anyway, it seems that there are some cases that need explicit
synchronize_rcu() and some cases depending on the other API providing
synchronize_rcu() semantics, maybe we provide two diffferent API for
both cases like the netif_napi_del()/__netif_napi_del() APIs do?

