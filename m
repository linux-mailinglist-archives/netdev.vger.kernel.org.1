Return-Path: <netdev+bounces-155831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39975A04006
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 13:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99DD63A7BD2
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 12:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB48E1EE7AA;
	Tue,  7 Jan 2025 12:55:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD1C1E008B;
	Tue,  7 Jan 2025 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254546; cv=none; b=pVms3ePRQ4ejVJ61cypykoRHw+s4bcyB+TzsW3gwc+l/xQIVRlpM3G8RTZq/SFwOtquxXkan0rJ3iehiwwS+ak5vo935jwTlZ8Hwr6KlDO3V1tWWo2qYtWk5Gsv33vKTzmszkOlpicmvx9m6MRDZlMM1Z5lNwtHyWhQw3i8mY5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254546; c=relaxed/simple;
	bh=QfnoGZAHhr9YiurUye2Jy9kxRNcuzYh13atr4fhWi50=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p7oeyu2PGdlInHldXFN/O45VzIyB16zSz1MzS0GQP38hadu87GmVwu/eYOQFNmjLS1PiONPoO5sHcnSGU+o+ngEZ0s4nHPTJqlx0228GnbmxUpG12GpZ1TFZ5mmVBAapJmihDF6ArcTbe2G2m+sMQf6LjSj+C/+kK6ODhejtxYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4YS9tv5SkFz1V4N6;
	Tue,  7 Jan 2025 20:52:39 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 96A9F18001B;
	Tue,  7 Jan 2025 20:55:40 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 7 Jan 2025 20:55:40 +0800
Message-ID: <46f525dc-36aa-45c1-9b8b-8374e5cfdcf1@huawei.com>
Date: Tue, 7 Jan 2025 20:55:40 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 8/8] page_pool: use list instead of array for
 alloc cache
To: Simon Horman <horms@kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<liuyonglong@huawei.com>, <fanghaiqing@huawei.com>, <zhangkun09@huawei.com>,
	Robin Murphy <robin.murphy@arm.com>, Alexander Duyck
	<alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Eric Dumazet <edumazet@google.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250106130116.457938-1-linyunsheng@huawei.com>
 <20250106130116.457938-9-linyunsheng@huawei.com>
 <20250107120344.GI33144@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20250107120344.GI33144@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/1/7 20:03, Simon Horman wrote:
> On Mon, Jan 06, 2025 at 09:01:16PM +0800, Yunsheng Lin wrote:
>> As the alloc cache is always protected by NAPI context
>> protection, use encoded_next as a pointer to a next item
>> to avoid the using the array.
>>
>> Testing shows there is about 3ns improvement for the
>> performance of 'time_bench_page_pool01_fast_path' test
>> case.
>>
>> CC: Robin Murphy <robin.murphy@arm.com>
>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>> CC: IOMMU <iommu@lists.linux.dev>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> 
> ...
> 
>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> 
> ...
> 
>> @@ -677,10 +698,12 @@ static void __page_pool_return_page(struct page_pool *pool, netmem_ref netmem,
>>  
>>  static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
>>  {
>> -	struct page_pool_item *refill;
>> +	struct page_pool_item *refill, *alloc, *curr;
>>  	netmem_ref netmem;
>>  	int pref_nid; /* preferred NUMA node */
>>  
>> +	DEBUG_NET_WARN_ON_ONCE(pool->alloc.count || pool->alloc.list);
>> +
>>  	/* Quicker fallback, avoid locks when ring is empty */
>>  	refill = pool->alloc.refill;
>>  	if (unlikely(!refill && !READ_ONCE(pool->ring.list))) {

The checking has ensured that netmem will be initialised below.

>> @@ -698,6 +721,7 @@ static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
>>  	pref_nid = numa_mem_id(); /* will be zero like page_to_nid() */
>>  #endif
>>  
>> +	alloc = NULL;
>>  	/* Refill alloc array, but only if NUMA match */
>>  	do {
>>  		if (unlikely(!refill)) {
>> @@ -706,10 +730,13 @@ static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
>>  				break;
>>  		}
>>  
>> +		curr = refill;
>>  		netmem = refill->pp_netmem;

initialised here.

>>  		refill = page_pool_item_get_next(refill);
>>  		if (likely(netmem_is_pref_nid(netmem, pref_nid))) {
>> -			pool->alloc.cache[pool->alloc.count++] = netmem;
>> +			page_pool_item_set_next(curr, alloc);
>> +			pool->alloc.count++;
>> +			alloc = curr;
>>  		} else {
>>  			/* NUMA mismatch;
>>  			 * (1) release 1 page to page-allocator and

And set to zero here.

>> @@ -729,7 +756,8 @@ static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
>>  	/* Return last page */
>>  	if (likely(pool->alloc.count > 0)) {
>>  		atomic_sub(pool->alloc.count, &pool->ring.count);
>> -		netmem = pool->alloc.cache[--pool->alloc.count];

So we still need to set netmem to something meaningful here if netmem
is set to zero in the above 'else' branch.

>> +		pool->alloc.list = page_pool_item_get_next(alloc);
>> +		pool->alloc.count--;
>>  		alloc_stat_inc(pool, refill);
>>  	}
>>  
> 
> Hi Yunsheng Lin,
> 
> The following line of the code looks like this:
> 
> 	return netmem;
> 
> And, with this patch applied, Smatch warns that netmem may be used
> uninitialised here. I assume this is because it is no longer conditionally
> initialised above.

Thanks for reminding, the tool does seem to catch some bug here.

> 
> ...
> 

