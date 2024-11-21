Return-Path: <netdev+bounces-146603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6A89D4871
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 09:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BEEDB2089C
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 08:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FF91C7B77;
	Thu, 21 Nov 2024 08:04:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F59D1C7610;
	Thu, 21 Nov 2024 08:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732176254; cv=none; b=KNJkjw3Ab8EVlFjOdZ26gxCoC6gCYGhqUKtZ6/Ka8R2bORZoGOkZBO7Jw9qxOyWUhN/oaPXPEkdNIOHv08UaGVVvH+D/ixuY+MTbua2fna0ScmyRBaiEsUSPwge35KOK0cF+QaLn87N/d9tlkaXy1CUL4utwjdAzlC6VGX+ALqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732176254; c=relaxed/simple;
	bh=96sryfIQmKdCyS3M+IgIJeLvWW/9awhs6kIPWoVnR6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=khH5FNIzylSUUXy5WLtob4Hy6TDttLHZ10oWJh3x3BXE7RWdKUngS2SxIo0snYLwUzmVnatPo7iKoVDsoG+5G1lglJ/pexZqyFUl3qHyFKmvKmzJTY25ZwW0wvHk0+eGUzl/fjZLHkn6Tx+Pyv+x5a240SgyygXwSuHZxHmRaBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Xv9fd0mMvz1T9JH;
	Thu, 21 Nov 2024 16:01:29 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 8530D1800F2;
	Thu, 21 Nov 2024 16:04:08 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 Nov 2024 16:04:07 +0800
Message-ID: <57dea3ef-6982-4946-bf96-8ebadf6f883c@huawei.com>
Date: Thu, 21 Nov 2024 16:04:07 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 3/3] page_pool: skip dma sync operation for
 inflight pages
To: Robin Murphy <robin.murphy@arm.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <liuyonglong@huawei.com>, <fanghaiqing@huawei.com>,
	<zhangkun09@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, IOMMU <iommu@lists.linux.dev>, MM
	<linux-mm@kvack.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241120103456.396577-1-linyunsheng@huawei.com>
 <20241120103456.396577-4-linyunsheng@huawei.com>
 <15f937d7-7ac1-4a7f-abcd-abfede191b51@arm.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <15f937d7-7ac1-4a7f-abcd-abfede191b51@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/11/21 0:17, Robin Murphy wrote:
> On 20/11/2024 10:34 am, Yunsheng Lin wrote:
>> Skip dma sync operation for inflight pages before the
>> page_pool_destroy() returns to the driver as DMA API
>> expects to be called with a valid device bound to a
>> driver as mentioned in [1].
>>
>> After page_pool_destroy() is called, the page is not
>> expected to be recycled back to pool->alloc cache and
>> dma sync operation is not needed when the page is not
>> recyclable or pool->ring is full, so only skip the dma
>> sync operation for the infilght pages by clearing the
>> pool->dma_sync under protection of rcu lock when page
>> is recycled to pool->ring to ensure that there is no
>> dma sync operation called after page_pool_destroy() is
>> returned.
> 
> Something feels off here - either this is a micro-optimisation which I wouldn't really expect to be meaningful, or it means patch #2 doesn't actually do what it claims. If it really is possible to attempt to dma_sync a page *after* page_pool_inflight_unmap() has already reclaimed and unmapped it, that represents yet another DMA API lifecycle issue, which as well as being even more obviously incorrect usage-wise, could also still lead to the same crash (if the device is non-coherent).

For a page_pool owned page, it mostly goes through the below steps:
1. page_pool calls buddy allocator API to allocate a page, call DMA mapping
   and sync_for_device API for it if its pool is empty. Or reuse the page in
   pool.

2. Driver calls the page_pool API to allocate the page, and pass the page
   to network stack after packet is dma'ed into the page and the sync_for_cpu
   API is called.

3. Network stack is done with page and called page_pool API to free the page.

4. page_pool releases the page back to buddy allocator if the page is not
   recyclable before doing the dma unmaping. Or do the sync_for_device
   and put the page in the its pool, the page might go through step 1
   again if the driver calls the page_pool allocate API.

The calling of dma mapping and dma sync API is controlled by pool->dma_map
and pool->dma_sync respectively, the previous patch only clear pool->dma_map
after doing the dma unmapping. This patch ensures that there is no dma_sync
for recycle case of step 4 by clearing pool->dma_sync.

The dma_sync skipping should also happen before page_pool_inflight_unmap()
is called too because all the caller will see the clearing of pool->dma_sync
after synchronize_rcu() and page_pool_inflight_unmap() is called after
the same synchronize_rcu() in page_pool_destroy().

> 
> Otherwise, I don't imagine it's really worth worrying about optimising out syncs for any pages which happen to get naturally returned after page_pool_destroy() starts but before they're explicitly reclaimed. Realistically, the kinds of big server systems where reclaim takes an appreciable amount of time are going to be coherent and skipping syncs anyway.

The skipping is about skipping the dma sync for those inflight pages,
I should make it clearer that the skipping happens before the calling
of page_pool_inflight_unmap() instead of page_pool_destroy() in the
commit log.

> 


