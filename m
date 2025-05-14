Return-Path: <netdev+bounces-190295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F12AB611D
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 05:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F291719E5B9D
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 03:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B2C1E835C;
	Wed, 14 May 2025 03:11:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7075027454;
	Wed, 14 May 2025 03:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747192270; cv=none; b=W0GHEfQiVegxIGaaeBhYg8ekLt0K76x9uEYOT7r6+GZOdJa7tX3ylJGK3XcvnYqFjZKVvGjndw1hQ4jOyv8oModLk1WZ774gUB34/usyB37oK3HJAhkRqR2Ei4/fqX9IEffhNca1Fec43YvwXWQSEIBuHsse/+EOeErLU4CoJDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747192270; c=relaxed/simple;
	bh=98Dec1eGU4eecv5MJYIex9QSD6mA9QJgp2N4HJjRvTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b/DIa0be9GcVTfsSnkh1rOGH5YDnC9Eai52ToIQdpdYwELaVqJXLFfibb7DEtmO5NNbcZ/eXrYRLqfjXLICmM6PedZqmGNXPsp+mlA1pzrCkfsXiCIYJOoctMQQepQWWJxaw58/3r0k8oQ+s+jHJdPQgFQQ71NMHKS3FprzHz1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZxyxZ4kh4zxWqG;
	Wed, 14 May 2025 11:09:38 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 8044A1402EB;
	Wed, 14 May 2025 11:11:04 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 14 May 2025 11:11:01 +0800
Received: from [10.174.177.223] (10.174.177.223) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 14 May 2025 11:11:00 +0800
Message-ID: <34f06847-f0d8-4ff3-b8a1-0b1484e27ba8@huawei.com>
Date: Wed, 14 May 2025 11:10:59 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG Report] KASAN: slab-use-after-free in
 page_pool_recycle_in_ring
To: Mina Almasry <almasrymina@google.com>
CC: <hawk@kernel.org>, <ilias.apalodimas@linaro.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhangchangzhong@huawei.com>
References: <20250513083123.3514193-1-dongchenchen2@huawei.com>
 <CAHS8izOio0bnLp3+Vzt44NVgoJpmPTJTACGjWvOXvxVqFKPSwQ@mail.gmail.com>
From: "dongchenchen (A)" <dongchenchen2@huawei.com>
In-Reply-To: <CAHS8izOio0bnLp3+Vzt44NVgoJpmPTJTACGjWvOXvxVqFKPSwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemq200002.china.huawei.com (7.202.195.90)


> On Tue, May 13, 2025 at 1:28 AM Dong Chenchen <dongchenchen2@huawei.com> wrote:
>> Hello,
>>
>> syzkaller found the UAF issue in page_pool_recycle_in_ring[1], which is
>> similar to syzbot+204a4382fcb3311f3858@syzkaller.appspotmail.com.
>>
>> root cause is as follow:
>>
>> page_pool_recycle_in_ring
>>    ptr_ring_produce
>>      spin_lock(&r->producer_lock);
>>      WRITE_ONCE(r->queue[r->producer++], ptr)
>>        //recycle last page to pool
>>                                  page_pool_release
>>                                    page_pool_scrub
>>                                      page_pool_empty_ring
>>                                        ptr_ring_consume
>>                                        page_pool_return_page //release all page
>>                                    __page_pool_destroy
>>                                       free_percpu(pool->recycle_stats);
>>                                       kfree(pool) //free
>>
>>       spin_unlock(&r->producer_lock); //pool->ring uaf read
>>    recycle_stat_inc(pool, ring);
>>
>> page_pool can be free while page pool recycle the last page in ring.
>> After adding a delay to the page_pool_recycle_in_ring(), syzlog[2] can
>> reproduce this issue with a high probability. Maybe we can fix it by
>> holding the user_cnt of the page pool during the page recycle process.
>>
>> Does anyone have a good idea to solve this problem?
>>
> Ugh. page_pool_release is not supposed to free the page_pool until all
> inflight pages have been returned. It detects that there are pending
> inflight pages by checking the atomic stats, but in this case it looks
> like we've raced checking the atomic stats with another cpu returning
> a netmem to the ptr ring (and it updates the stats _after_ it already
> returned to the ptr_ring).
>
> My guess here is that page_pool_scrub needs to acquire the
> r->producer_lock to make sure there are no other producers returning
> netmems to the ptr_ring while it's scrubbing them (and checking after
> to make sure there are no inflight netmems).
>
> Can you test this fix? It may need some massaging. I only checked it
> builds. I haven't thought through all the possible races yet:
>
> ```
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 2b76848659418..8654608734773 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -1146,10 +1146,17 @@ static void page_pool_scrub(struct page_pool *pool)
>
>   static int page_pool_release(struct page_pool *pool)
>   {
> +       bool in_softirq;
>          int inflight;
>
> +
> +       /* Acquire producer lock to make sure we don't race with another thread
> +        * returning a netmem to the ptr_ring.
> +        */
> +       in_softirq = page_pool_producer_lock(pool);
>          page_pool_scrub(pool);
>          inflight = page_pool_inflight(pool, true);
> +       page_pool_producer_unlock(pool, in_softirq);
>          if (!inflight)
>                  __page_pool_destroy(pool);
> ```
Hi, Mina!

I tested this patch and the problem still exists.
Although this patch ensures that lock access is safe, the page recycle 
process
can access the page pool after unlock.

page_pool_recycle_in_ring
   ptr_ring_produce
     spin_lock(&r->producer_lock);
     WRITE_ONCE(r->queue[r->producer++], ptr)
     spin_unlock(&r->producer_lock);
       //recycle last page to pool
                                 page_pool_release
                                   page_pool_scrub
                                     page_pool_empty_ring
                                       ptr_ring_consume
                                       page_pool_return_page //release 
all page
                                   __page_pool_destroy
free_percpu(pool->recycle_stats);
                                      kfree(pool) //free
   recycle_stat_inc(pool, ring); //uaf read

Regards,
Dong Chenchen

