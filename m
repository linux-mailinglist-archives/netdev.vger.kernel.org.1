Return-Path: <netdev+bounces-146765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FCE9D59E1
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 08:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8E0AB23138
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 07:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE05170A03;
	Fri, 22 Nov 2024 07:20:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360DA16C854;
	Fri, 22 Nov 2024 07:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732260042; cv=none; b=Nkk9UMDkqp3rhjeYhrFK6im6w1oGW91GkQ3uAAO/mSUVBbQCUWXR2P6iiyeLlj8w3AozMQ5GBwtgbUp29oy9/Rb/20UIqVy8idN4XeCl5acmgTzSIIlHdmw1ldHeNiiUiMK8fT3D9FrkxmgxBvt+kVDmLfFTA91eRwz2sdT824E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732260042; c=relaxed/simple;
	bh=N160SUZkYD6JUX8pEDdwUH8ySm7ncw8qFmjrjOj7EHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h7PaXwfyJZVb+7QjQ3KO8fUoIjnU6mJ0tQdnYlbq+56uLTWj4LDjednlsVUdQFinToLJUpyGzBpp3DGzrjMBVZW/4Lr3mITNUM60KI9pbPQ+BCoA8/tvO/JbrgCXih3g/qTXybmwc+567PSp5+kKdHuRsZ3QNSzp7pwk8Oo1JZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XvmbM1hcMz1JCW6;
	Fri, 22 Nov 2024 15:15:43 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 921CC1A0188;
	Fri, 22 Nov 2024 15:20:36 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 Nov 2024 15:20:36 +0800
Message-ID: <91964676-522f-44b5-87bc-27cfa5193813@huawei.com>
Date: Fri, 22 Nov 2024 15:20:33 +0800
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
 <57dea3ef-6982-4946-bf96-8ebadf6f883c@huawei.com>
 <a02c5976-e288-404e-b725-66bd4c391384@arm.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <a02c5976-e288-404e-b725-66bd4c391384@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/11/21 21:44, Robin Murphy wrote:
> On 21/11/2024 8:04 am, Yunsheng Lin wrote:
>> On 2024/11/21 0:17, Robin Murphy wrote:
>>> On 20/11/2024 10:34 am, Yunsheng Lin wrote:
>>>> Skip dma sync operation for inflight pages before the
>>>> page_pool_destroy() returns to the driver as DMA API
>>>> expects to be called with a valid device bound to a
>>>> driver as mentioned in [1].
>>>>
>>>> After page_pool_destroy() is called, the page is not
>>>> expected to be recycled back to pool->alloc cache and
>>>> dma sync operation is not needed when the page is not
>>>> recyclable or pool->ring is full, so only skip the dma
>>>> sync operation for the infilght pages by clearing the
>>>> pool->dma_sync under protection of rcu lock when page
>>>> is recycled to pool->ring to ensure that there is no
>>>> dma sync operation called after page_pool_destroy() is
>>>> returned.
>>>
>>> Something feels off here - either this is a micro-optimisation which I wouldn't really expect to be meaningful, or it means patch #2 doesn't actually do what it claims. If it really is possible to attempt to dma_sync a page *after* page_pool_inflight_unmap() has already reclaimed and unmapped it, that represents yet another DMA API lifecycle issue, which as well as being even more obviously incorrect usage-wise, could also still lead to the same crash (if the device is non-coherent).
>>
>> For a page_pool owned page, it mostly goes through the below steps:
>> 1. page_pool calls buddy allocator API to allocate a page, call DMA mapping
>>     and sync_for_device API for it if its pool is empty. Or reuse the page in
>>     pool.
>>
>> 2. Driver calls the page_pool API to allocate the page, and pass the page
>>     to network stack after packet is dma'ed into the page and the sync_for_cpu
>>     API is called.
>>
>> 3. Network stack is done with page and called page_pool API to free the page.
>>
>> 4. page_pool releases the page back to buddy allocator if the page is not
>>     recyclable before doing the dma unmaping. Or do the sync_for_device
>>     and put the page in the its pool, the page might go through step 1
>>     again if the driver calls the page_pool allocate API.
>>
>> The calling of dma mapping and dma sync API is controlled by pool->dma_map
>> and pool->dma_sync respectively, the previous patch only clear pool->dma_map
>> after doing the dma unmapping. This patch ensures that there is no dma_sync
>> for recycle case of step 4 by clearing pool->dma_sync.
> 
> But *why* does it want to ensure that? Is there some possible race where one thread can attempt to sync and recycle a page while another thread is attempting to unmap and free it, such that you can't guarantee the correctness of dma_sync calls after page_pool_inflight_unmap() has started, and skipping them is a workaround for that? If so, then frankly I think that would want solving properly, but at the very least this change would need to come before patch #2.

The racing window is something like below. page_pool_destroy() and
page_pool_put_page() can be called concurrently, patch 2 only use
a spinlock to synchronise page_pool_inflight_unmap() with
page_pool_return_page() called by page_pool_put_page() to avoid
concurrent dma unmapping, there is no synchronization between
page_pool_destroy() and page_pool_dma_sync_for_device() called
by page_pool_put_page():
            CPU0                           CPU1
             .                               .
     page_pool_destroy()          page_pool_put_page()
             .                               .
     synchronize_rcu()                       .
             .                               .
   page_pool_inflight_unmap()                .
             .                               .
             .                    __page_pool_put_page()
             .                               .
             .               page_pool_dma_sync_for_device()
             .                               .

After this patch, page_pool_dma_sync_for_device() is protected by
rcu lock and pool->dma_sync is cleared before synchronize_rcu and
page_pool_inflight_unmap() is called after synchronize_rcu to ensure
page_pool_dma_sync_for_device() will not call dma sync API after
synchronize_rcu():

            CPU0                           CPU1
             .                               .
     page_pool_destroy() CPU       page_pool_put_page() CPU
             .                               .
    pool->dma_sync = false                   .
             .                               .
     synchronize_rcu()                       .
             .                               .
   page_pool_inflight_unmap()                .
             .                               .
             .                  page_pool_recycle_in_ring()
             .                               .
             .                        rcu_read_lock()
             .               page_pool_dma_sync_for_device()
             .                        rcu_read_unlock()

Previously patch 2&3 was combined as one patch, this version splits
it out to make it more reviewable.
I am not sure if it matters that much about the patch order as the
fix doesn't seem to be completed unless both patches are included.


