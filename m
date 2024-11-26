Return-Path: <netdev+bounces-147340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 537C49D9336
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE884161FC4
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 08:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EA5199924;
	Tue, 26 Nov 2024 08:22:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837F61A00F4;
	Tue, 26 Nov 2024 08:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732609370; cv=none; b=fdIyKvu8A5l4r14PYMqCBEIChRFs0EEk89spZX+OGnaA1COpD4R9MuKrE3BnGHtVvqqStkcb79f0kVChLdzLh8eflIk1Xvn6xGlFGz6odpZS6zWVRYVhMld4NUmci3o9QUHEjyZrEz6yqHBeGtDSSnHrkgzBBzIVkYLxjo8m6mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732609370; c=relaxed/simple;
	bh=NZzFxGiqYDUqL29nURG2k2e9QAvCV2Jo0ezb0nUvxqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nCZ24PuaSpoMF+NkD0MEW1KOVypAHbGNPgShg6Q6XvZ8S2uDCp6/lNPHrDTTqBo8mx70yJLOdWxMenLsliEnvvavRcPRRfGJQEuu2DUrLvIu0AosXbBnsMsbuJzDRQ6EwWZvRpndUsYvE5Q9SxEBfocOtg4QypgsJovoKNUD0Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XyFrH24FZz10WNr;
	Tue, 26 Nov 2024 16:20:31 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 94B9718009B;
	Tue, 26 Nov 2024 16:22:39 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 26 Nov 2024 16:22:39 +0800
Message-ID: <6233e2c3-3fea-4ed0-bdcc-9a625270da37@huawei.com>
Date: Tue, 26 Nov 2024 16:22:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 2/3] page_pool: fix IOMMU crash when driver has
 already unbound
To: Jesper Dangaard Brouer <hawk@kernel.org>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <liuyonglong@huawei.com>, <fanghaiqing@huawei.com>,
	<zhangkun09@huawei.com>, Robin Murphy <robin.murphy@arm.com>, Alexander Duyck
	<alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241120103456.396577-1-linyunsheng@huawei.com>
 <20241120103456.396577-3-linyunsheng@huawei.com>
 <3366bf89-4544-4b82-83ec-fd89dd009228@kernel.org>
 <27475b57-eda1-4d67-93f2-5ca443632f6b@huawei.com>
 <ac728cc1-2ccb-4207-ae11-527a3ed8fbb6@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <ac728cc1-2ccb-4207-ae11-527a3ed8fbb6@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/11/25 23:25, Jesper Dangaard Brouer wrote:

...

>>>> +
>>>>    void page_pool_destroy(struct page_pool *pool)
>>>>    {
>>>>        if (!pool)
>>>> @@ -1139,6 +1206,8 @@ void page_pool_destroy(struct page_pool *pool)
>>>>         */
>>>>        synchronize_rcu();
>>>>    +    page_pool_inflight_unmap(pool);
>>>> +
>>>
>>> Reaching here means we have detected in-flight packets/pages.
>>>
>>> In "page_pool_inflight_unmap" we scan and find those in-flight pages to
>>> DMA unmap them. Then below we wait for these in-flight pages again.
>>> Why don't we just "release" (page_pool_release_page) those in-flight
>>> pages from belonging to the page_pool, when we found them during scanning?
>>>
>>> If doing so, we can hopefully remove the periodic checking code below.
>>
>> I thought about that too, but it means more complicated work than just
>> calling the page_pool_release_page() as page->pp_ref_count need to be
>> converted into page->_refcount for the above to work, it seems hard to
>> do that with least performance degradation as the racing against
>> page_pool_put_page() being called concurrently.
>>
> 
> Maybe we can have a design that avoid/reduce concurrency.  Can we
> convert the suggested pool->destroy_lock into an atomic?
> (Doing an *atomic* READ in page_pool_return_page, should be fast if we
> keep this cache in in (cache coherence) Shared state).
> 
> In your new/proposed page_pool_return_page() when we see the
> "destroy_cnt" (now atomic READ) bigger than zero, then we can do nothing
> (or maybe we need decrement page-refcnt?), as we know the destroy code

Is it valid to have a page->_refcount of zero when page_pool still own
the page if we only decrement page->_refcount and not clear page->pp_magic?
What happens if put_page() is called from other subsystem for a page_pool
owned page, isn't that mean the page might be returned to buddy page
allocator, causing use-after-free problem?

> will be taking care of "releasing" the pages from the page pool.

If page->_refcount is not decremented in page_pool_return_page(), how
does page_pool_destroy() know if a specific page have been called with
page_pool_return_page()? Does an extra state is needed to indicate that?

And there might still be concurrency between checking/handling of the extra
state in page_pool_destroy() and the setting of extra state in
page_pool_return_page(), something like lock might still be needed to avoid
the above concurrency.

> 
> Once the a page is release from a page pool it becomes a normal page,
> that adhere to normal page refcnt'ing. That is how it worked before with
> page_pool_release_page().
> The later extensions with page fragment support and devmem might have
> complicated this code path.

As page_pool_return_page() and page_pool_destroy() both try to "release"
the page concurrently for a specific page, I am not sure how using some
simple *atomic* can avoid this kind of concurrency even before page
fragment and devmem are supported, it would be good to be more specific
about that by using some pseudocode.

I looked at it more closely, previously page_pool_put_page() seemed to
not be allowed to be called after page_pool_release_page() had been
called for a specific page mainly because of concurrently checking/handlig
and clearing of page->pp_magic if I understand it correctly:
https://elixir.bootlin.com/linux/v5.16.20/source/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c#L5316

