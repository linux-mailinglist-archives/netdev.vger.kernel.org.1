Return-Path: <netdev+bounces-146645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F119D4E00
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CE4BB244C9
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 13:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7391D8E1A;
	Thu, 21 Nov 2024 13:44:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F041D7E57;
	Thu, 21 Nov 2024 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732196656; cv=none; b=YLlNbrn0qVqXlxGSPgAcKj2A7LIcOkFaFoEqtdOKoTp1f59brXXbP57Ks1mp29wiw+IOXhTTj40aaClXP8NGZiwxgT13yGV3znnUuIjBVbwHqqPIzlYEKkE1R3IEgfTGXoGgtG4J/BO9sfO0a2q+kt8SwcsFpNlFY0edW2nxYps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732196656; c=relaxed/simple;
	bh=PhZZoOaS3ryFyeN0JP/HtGmzeZqkb+zHGZhGnpkyDuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3tY7lTCNBQciXUfpwCMDY12tWKsYHhsADRJrwckbJFDSydxFSrUsO2XlDihIv5YagQG8Zx78fHkERNSHCcaRxV7MDtLxUL4FDP9YgEvD/NNPL7uPfYoG7oCRW8AHVMlhYDFG5nxBT01TVHgpJC1eqooFj3CQzDyLWCcpfcIRXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 756261476;
	Thu, 21 Nov 2024 05:44:37 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 302E33F66E;
	Thu, 21 Nov 2024 05:44:05 -0800 (PST)
Message-ID: <a02c5976-e288-404e-b725-66bd4c391384@arm.com>
Date: Thu, 21 Nov 2024 13:44:03 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 3/3] page_pool: skip dma sync operation for
 inflight pages
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
Cc: liuyonglong@huawei.com, fanghaiqing@huawei.com, zhangkun09@huawei.com,
 Alexander Duyck <alexander.duyck@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, IOMMU <iommu@lists.linux.dev>,
 MM <linux-mm@kvack.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241120103456.396577-1-linyunsheng@huawei.com>
 <20241120103456.396577-4-linyunsheng@huawei.com>
 <15f937d7-7ac1-4a7f-abcd-abfede191b51@arm.com>
 <57dea3ef-6982-4946-bf96-8ebadf6f883c@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <57dea3ef-6982-4946-bf96-8ebadf6f883c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/11/2024 8:04 am, Yunsheng Lin wrote:
> On 2024/11/21 0:17, Robin Murphy wrote:
>> On 20/11/2024 10:34 am, Yunsheng Lin wrote:
>>> Skip dma sync operation for inflight pages before the
>>> page_pool_destroy() returns to the driver as DMA API
>>> expects to be called with a valid device bound to a
>>> driver as mentioned in [1].
>>>
>>> After page_pool_destroy() is called, the page is not
>>> expected to be recycled back to pool->alloc cache and
>>> dma sync operation is not needed when the page is not
>>> recyclable or pool->ring is full, so only skip the dma
>>> sync operation for the infilght pages by clearing the
>>> pool->dma_sync under protection of rcu lock when page
>>> is recycled to pool->ring to ensure that there is no
>>> dma sync operation called after page_pool_destroy() is
>>> returned.
>>
>> Something feels off here - either this is a micro-optimisation which I wouldn't really expect to be meaningful, or it means patch #2 doesn't actually do what it claims. If it really is possible to attempt to dma_sync a page *after* page_pool_inflight_unmap() has already reclaimed and unmapped it, that represents yet another DMA API lifecycle issue, which as well as being even more obviously incorrect usage-wise, could also still lead to the same crash (if the device is non-coherent).
> 
> For a page_pool owned page, it mostly goes through the below steps:
> 1. page_pool calls buddy allocator API to allocate a page, call DMA mapping
>     and sync_for_device API for it if its pool is empty. Or reuse the page in
>     pool.
> 
> 2. Driver calls the page_pool API to allocate the page, and pass the page
>     to network stack after packet is dma'ed into the page and the sync_for_cpu
>     API is called.
> 
> 3. Network stack is done with page and called page_pool API to free the page.
> 
> 4. page_pool releases the page back to buddy allocator if the page is not
>     recyclable before doing the dma unmaping. Or do the sync_for_device
>     and put the page in the its pool, the page might go through step 1
>     again if the driver calls the page_pool allocate API.
> 
> The calling of dma mapping and dma sync API is controlled by pool->dma_map
> and pool->dma_sync respectively, the previous patch only clear pool->dma_map
> after doing the dma unmapping. This patch ensures that there is no dma_sync
> for recycle case of step 4 by clearing pool->dma_sync.

But *why* does it want to ensure that? Is there some possible race where 
one thread can attempt to sync and recycle a page while another thread 
is attempting to unmap and free it, such that you can't guarantee the 
correctness of dma_sync calls after page_pool_inflight_unmap() has 
started, and skipping them is a workaround for that? If so, then frankly 
I think that would want solving properly, but at the very least this 
change would need to come before patch #2.

If not, and this is just some attempt at performance micro-optimisation, 
then I'd be keen to see the numbers to justify it, since I struggle to 
imagine it being worth the bother while already in the process of 
spending whole seconds scanning memory...

Thanks,
Robin.

> The dma_sync skipping should also happen before page_pool_inflight_unmap()
> is called too because all the caller will see the clearing of pool->dma_sync
> after synchronize_rcu() and page_pool_inflight_unmap() is called after
> the same synchronize_rcu() in page_pool_destroy().
> 
>>
>> Otherwise, I don't imagine it's really worth worrying about optimising out syncs for any pages which happen to get naturally returned after page_pool_destroy() starts but before they're explicitly reclaimed. Realistically, the kinds of big server systems where reclaim takes an appreciable amount of time are going to be coherent and skipping syncs anyway.
> 
> The skipping is about skipping the dma sync for those inflight pages,
> I should make it clearer that the skipping happens before the calling
> of page_pool_inflight_unmap() instead of page_pool_destroy() in the
> commit log.
> 
>>
> 

