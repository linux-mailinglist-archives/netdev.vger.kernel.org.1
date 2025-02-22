Return-Path: <netdev+bounces-168733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD134A4063A
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 09:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1785423DC1
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 08:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE932063E0;
	Sat, 22 Feb 2025 08:11:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EF51DE4E5;
	Sat, 22 Feb 2025 08:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740211918; cv=none; b=LGuov/9cu1PEZyfegep/GNw+4lEe+spp19qi03ezUcKwOohtQPrrSaUN7lOUsgfiiS7r/XIlQoRBM21+PQSzmFWR13/KFW8dV13axu1JFuJ2hhDEpUz7Ydp0tMRroRhGBO+b0Ks49MAMozJ1GnvCVom/VJO1HQ0mL5cAxbwIzME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740211918; c=relaxed/simple;
	bh=4m8KhPfmPys8alzz58S3fE6vnQq0+jk5CAly0Nr2FN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jspAeJYZvpx8JkgiQKOQRb8tUkHsOLV2sfIHiRPpr3xKSVlo9wlCnQhGuzdmOfSjk8AmODLVo7Twb5aMSUac3T4H4ilOJypk+5Gm5NbNqpgaeWVhdkzs4GBICAY54JJNHXDnw03gzckUo+DNpLd3qRna5E10VET7NgEWxVeun14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Z0KNH6gM6zdb8k;
	Sat, 22 Feb 2025 16:07:11 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0428B1400CF;
	Sat, 22 Feb 2025 16:11:52 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 22 Feb 2025 16:11:51 +0800
Message-ID: <24321916-549d-4b76-8ca5-a268432f54e7@huawei.com>
Date: Sat, 22 Feb 2025 16:11:51 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 3/4] page_pool: support unlimited number of
 inflight pages
To: Jesper Dangaard Brouer <hawk@kernel.org>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <zhangkun09@huawei.com>, <liuyonglong@huawei.com>,
	<fanghaiqing@huawei.com>, Robin Murphy <robin.murphy@arm.com>, Alexander
 Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250212092552.1779679-1-linyunsheng@huawei.com>
 <20250212092552.1779679-4-linyunsheng@huawei.com>
 <640946c8-237d-40de-b64e-0f8fd8f1a600@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <640946c8-237d-40de-b64e-0f8fd8f1a600@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/2/21 18:12, Jesper Dangaard Brouer wrote:

...

>> @@ -513,10 +517,43 @@ static struct page_pool_item *page_pool_fast_item_alloc(struct page_pool *pool)
>>       return llist_entry(first, struct page_pool_item, lentry);
>>   }
>>   +#define PAGE_POOL_SLOW_ITEM_BLOCK_BIT            BIT(0)
>> +static struct page_pool_item *page_pool_slow_item_alloc(struct page_pool *pool)
>> +{
>> +    if (unlikely(!pool->slow_items.block ||
>> +             pool->slow_items.next_to_use >= ITEMS_PER_PAGE)) {
>> +        struct page_pool_item_block *block;
>> +        struct page *page;
>> +
>> +        page = alloc_pages_node(pool->p.nid, GFP_ATOMIC | __GFP_NOWARN |
>> +                    __GFP_ZERO, 0);
>> +        if (!page) {
>> +            alloc_stat_inc(pool, item_slow_failed);
>> +            return NULL;
>> +        }
> 
> We also need stats on how many pages we allocate for these item_blocks
> (and later free). This new scheme of keeping track of all pages
> allocated via page_pool, is obviously going to consume more memory.
> 
> I want to be able to find out how much memory a page_pool is consuming.
> (E.g. Kuba added a nice interface for querying inflight packets, even
> though this is kept as two different counters).

Does additional stats is needed? as I was thinking list_for_each_entry()
for pool->item_blocks might be used to tell how much memory it is used
for slow item, and how much each item_block is fragmented by looking at
the block->ref with the protection of pool->item_lock if needed.

> 
> What I worry about, is that fragmentation happens inside these
> item_blocks. (I hope you understand what I mean by fragmentation, else
> let me know).
> 
> Could you explain how code handles or avoids fragmentation?

Currently fragmentation is not handled or avoided yet.
For inflight pages which are using slow item, it seems there is hardly
anything we can do about that.

For pages which sit in the page_pool, it seems possible to change
the pages using slow item to use fast item when they are allocated
from or recycled back into page_pool if fast item is available, or
those pages are simply disconnected from page_pool by calling
page_pool_return_page() when page_pool_put_unrefed_netmem() is
called?

I am not sure how severe the fragmentation problem might become and
which way to handle it is better, maybe add interface to query the
fragmentation info as mentioned above first, and deal with it when
it does become a severe problem?

> 
> 
>> +
>> +        block = page_address(page);
>> +        block->pp = pool;
>> +        block->flags |= PAGE_POOL_SLOW_ITEM_BLOCK_BIT;
>> +        refcount_set(&block->ref, ITEMS_PER_PAGE);
>> +        pool->slow_items.block = block;
>> +        pool->slow_items.next_to_use = 0;
>> +
>> +        spin_lock_bh(&pool->item_lock);
>> +        list_add(&block->list, &pool->item_blocks);
>> +        spin_unlock_bh(&pool->item_lock);
>> +    }
>> +
>> +    return &pool->slow_items.block->items[pool->slow_items.next_to_use++];
>> +}
>> +

