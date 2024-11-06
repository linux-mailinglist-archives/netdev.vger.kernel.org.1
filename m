Return-Path: <netdev+bounces-142333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 408859BE4F5
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 11:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65E31F23F40
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E507C1DE3D0;
	Wed,  6 Nov 2024 10:56:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B37A1DA622;
	Wed,  6 Nov 2024 10:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890599; cv=none; b=RdYIdGcGJFiH5Igr/nBzmjyVBAWw7+7f8XqdUNPY2XKWswCxXD9AT2KWF+wzT2X2tiy5brpoG8tt8ci9xCoXfsKLTeEEUQwHlXgGiEL/0uYNZ+V2g7iphO7VIUL+RDlYDUQHSRvQzX7Y/SZxrilx6LMibF2PBStK1ULO0WHMnqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890599; c=relaxed/simple;
	bh=LQG9eqDPNmwxwvZfvSWSmROcayIPhbmGXD5bEneyqGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gBwsE1XPBkXljawSjmQY2e7QsjJp17bh3Jyi8ajSWISJVuyZL66B6RAN6UmEL8mCLc/RADxuokNOTY7ieYhofdu1auLsIPzdXOgAezhf80gbE/uQmxfbpwLTo1mKGOUvCBka+cNwNwh3RnWbkNiKT4IQbD6C/tU3Lmmpk+vMDks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Xk2BZ0KDMzNpR6;
	Wed,  6 Nov 2024 18:53:58 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id E382C140361;
	Wed,  6 Nov 2024 18:56:34 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 Nov 2024 18:56:34 +0800
Message-ID: <2f256bce-0c37-4940-9218-9545daa46169@huawei.com>
Date: Wed, 6 Nov 2024 18:56:34 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] page_pool: fix IOMMU crash when driver
 has already unbound
To: Jesper Dangaard Brouer <hawk@kernel.org>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <zhangkun09@huawei.com>, <fanghaiqing@huawei.com>,
	<liuyonglong@huawei.com>, Robin Murphy <robin.murphy@arm.com>, Alexander
 Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, Andrew
 Morton <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, kernel-team
	<kernel-team@cloudflare.com>, Christoph Hellwig <hch@lst.de>,
	<m.szyprowski@samsung.com>
References: <20241022032214.3915232-1-linyunsheng@huawei.com>
 <20241022032214.3915232-4-linyunsheng@huawei.com>
 <dbd7dca7-d144-4a0f-9261-e8373be6f8a1@kernel.org>
 <113c9835-f170-46cf-92ba-df4ca5dfab3d@huawei.com> <878qudftsn.fsf@toke.dk>
 <d8e0895b-dd37-44bf-ba19-75c93605fc5e@huawei.com> <87r084e8lc.fsf@toke.dk>
 <cf1911c5-622f-484c-9ee5-11e1ac83da24@huawei.com> <878qu7c8om.fsf@toke.dk>
 <1eac33ae-e8e1-4437-9403-57291ba4ced6@huawei.com> <87o731by64.fsf@toke.dk>
 <023fdee7-dbd4-4e78-b911-a7136ff81343@huawei.com> <874j4sb60w.fsf@toke.dk>
 <a50250bf-fe76-4324-96d7-b3acf087a18c@huawei.com>
 <a6cfba96-9164-4497-b075-9359c18a5eef@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <a6cfba96-9164-4497-b075-9359c18a5eef@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

+cc Christoph & Marek

On 2024/11/6 4:11, Jesper Dangaard Brouer wrote:

...

>>>
>>>> I am not sure if I understand the reasoning behind the above suggestion to 'wait
>>>> and see if this actually turns out to be a problem' when we already know that there
>>>> are some cases which need cache kicking/flushing for the waiting to work and those
>>>> kicking/flushing may not be easy and may take indefinite time too, not to mention
>>>> there might be other cases that need kicking/flushing that we don't know yet.
>>>>
>>>> Is there any reason not to consider recording the inflight pages so that unmapping
>>>> can be done for inflight pages before driver unbound supposing dynamic number of
>>>> inflight pages can be supported?
>>>>
>>>> IOW, Is there any reason you and jesper taking it as axiomatic that recording the
>>>> inflight pages is bad supposing the inflight pages can be unlimited and recording
>>>> can be done with least performance overhead?
>>>
>>> Well, page pool is a memory allocator, and it already has a mechanism to
>>> handle returning of memory to it. You're proposing to add a second,
>>> orthogonal, mechanism to do this, one that adds both overhead and
>>
>> I would call it as a replacement/improvement for the old one instead of
>> 'a second, orthogonal' as the old one doesn't really exist after this patch.
>>
> 
> Yes, are proposing doing a very radical change to the page_pool design.
> And this is getting proposed as a fix patch for IOMMU.
> 
> It is a very radical change that page_pool needs to keep track of *ALL* in-flight pages.

I am agreed that it is a radical change, that is why it is targetting net-next
tree instead of net tree even when there is a Fixes tag for it.

If there is a proper and non-radical way to fix that, I would prefer the
non-radical way too.

> 
> The DMA issue is a life-time issue of DMA object associated with the
> struct device.  Then, why are you not looking at extending the life-time

It seems it is not really about the life-time of DMA object associated with the
life-time of 'struct device', it seems to be the life-time of DMA API associated
with the life-time of the driver for the 'struct device' from the the opinion of
experts from IOMMU/DMA subsystem in [1] & [2].

I am not sure what is reasoning behind the above, but the implementation seems
to be the case as mentioned in [3]:
__device_release_driver -> device_unbind_cleanup -> arch_teardown_dma_ops

1. https://lkml.org/lkml/2024/8/6/632
2. https://lore.kernel.org/all/20240923175226.GC9634@ziepe.ca/
3. https://lkml.org/lkml/2024/10/15/686

> of the DMA object, or at least detect when DMA object goes away, such
> that we can change a setting in page_pool to stop calling DMA unmap for
> the pages in-flight once they get returned (which we have en existing
> mechanism for).

To be honest, I was mostly depending on the opinion of the experts from
IOMMU/DMA subsystem for the correct DMA API usage as mentioned above.
So I am not sure if skipping DMA unmapping for the inflight pages is the
correct DMA API usage?
If it is the correct DMA API usage, how to detect that if DMA unmapping
can be skipped?

From previous discussion, skipping DMA unmapping may casue some resource
leaking, like the iova resoure behind the IOMMU and bounce buffer memory
behind the swiotlb.

Anyway, I may be wrong, CC'ing more experts to see if we can have some
clarifying from them.

> 
> 
>>> complexity, yet doesn't handle all cases (cf your comment about devmem).
>>
>> I am not sure if unmapping only need to be done using its own version DMA API
>> for devmem yet, but it seems waiting might also need to use its own version
>> of kicking/flushing for devmem as devmem might be held from the user space?
>>
>>>
>>> And even if it did handle all cases, force-releasing pages in this way
>>> really feels like it's just papering over the issue. If there are pages
>>> being leaked (or that are outstanding forever, which basically amounts
>>> to the same thing), that is something we should be fixing the root cause
>>> of, not just working around it like this series does.
>>
>> If there is a definite time for waiting, I am probably agreed with the above.
>>  From the previous discussion, it seems the time to do the kicking/flushing
>> would be indefinite depending how much cache to be scaned/flushed.
>>
>> For the 'papering over' part, it seems it is about if we want to paper over
>> different kicking/flushing or paper over unmapping using different DMA API.
>>
>> Also page_pool is not really a allocator, instead it is more like a pool
>> based on different allocator, such as buddy allocator or devmem allocator.
>> I am not sure it makes much to do the flushing when page_pool_destroy() is
>> called if the buddy allocator behind the page_pool is not under memory
>> pressure yet.
>>
> 
> I still see page_pool as an allocator like the SLUB/SLAB allocators,
> where slab allocators are created (and can be destroyed again), which we
> can allocate slab objects from.  SLAB allocators also use buddy
> allocator as their backing allocator.

I am not sure if SLUB/SLAB is that similar to page_pool for the specific
problem here, at least SLUB/SLAB doesn't seems to support dma mapping in
its core and doesn't seem to allow inflight cache when kmem_cache_destroy()
is called as its alloc API doesn't seems to take reference to s->refcount
and doesn't have the inflight cache calculating as page_pool does?
https://elixir.bootlin.com/linux/v6.12-rc6/source/mm/slab_common.c#L512


> 
> The page_pool is of-cause evolving with the addition of the devmem
> allocator as a different "backing" allocator type.



