Return-Path: <netdev+bounces-140994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1709B9002
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 12:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CBE31C20F41
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C555418953D;
	Fri,  1 Nov 2024 11:11:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8084175D2D;
	Fri,  1 Nov 2024 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730459509; cv=none; b=LdKCNhpcMHBasiBTR9FjXNDKqPVpURPGfBR3vvTuXqkL6EAcCi+NmuPDlsjFoP/sJni0n3qE7Fd9soymD7fzZeBzyuD5XSRUEwKuVJFNA6j4NlfFP+b6Kt+403P8EOj/9s1hfWmckVki81KNrSqm1uvPb/9+4SayVV/qqYP5g3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730459509; c=relaxed/simple;
	bh=jzzj7rC//JLmXktNJ9n2mbVqfz461nEmBaKK0rjPMls=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ObSMAJPK0wZB+WqQUOIMTp4g6xMC3kqRTZ6X/y75Hh27mx8gVGKM65oA2sJ2nxoT12EaCgKvLr6FNTGdBAcfO70B4+XsIZbipSFozJFO3pTf8zmuBn5t0LTRY34tQ+5kCCXEFG6wA0CidLDrdvkI4Ch6Th59JGUkUohRxtwepZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XfypB0z8QzQsQH;
	Fri,  1 Nov 2024 19:10:42 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id DC89E140337;
	Fri,  1 Nov 2024 19:11:43 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 1 Nov 2024 19:11:43 +0800
Message-ID: <a50250bf-fe76-4324-96d7-b3acf087a18c@huawei.com>
Date: Fri, 1 Nov 2024 19:11:43 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] page_pool: fix IOMMU crash when driver
 has already unbound
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <zhangkun09@huawei.com>, <fanghaiqing@huawei.com>,
	<liuyonglong@huawei.com>, Robin Murphy <robin.murphy@arm.com>, Alexander
 Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, Andrew
 Morton <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, kernel-team
	<kernel-team@cloudflare.com>
References: <20241022032214.3915232-1-linyunsheng@huawei.com>
 <20241022032214.3915232-4-linyunsheng@huawei.com>
 <dbd7dca7-d144-4a0f-9261-e8373be6f8a1@kernel.org>
 <113c9835-f170-46cf-92ba-df4ca5dfab3d@huawei.com> <878qudftsn.fsf@toke.dk>
 <d8e0895b-dd37-44bf-ba19-75c93605fc5e@huawei.com> <87r084e8lc.fsf@toke.dk>
 <cf1911c5-622f-484c-9ee5-11e1ac83da24@huawei.com> <878qu7c8om.fsf@toke.dk>
 <1eac33ae-e8e1-4437-9403-57291ba4ced6@huawei.com> <87o731by64.fsf@toke.dk>
 <023fdee7-dbd4-4e78-b911-a7136ff81343@huawei.com> <874j4sb60w.fsf@toke.dk>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <874j4sb60w.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/11/1 0:18, Toke Høiland-Jørgensen wrote:

...

>>>
>>> Eliding the details above, but yeah, you're right, there are probably
>>> some pernicious details to get right if we want to flush all caches. S
>>> I wouldn't do that to start with. Instead, just add the waiting to start
>>> with, then wait and see if this actually turns out to be a problem in
>>> practice. And if it is, identify the source of that problem, deal with
>>> it, rinse and repeat :)
>>
>> I am not sure if I have mentioned to you that jakub had a RFC for the waiting,
>> see [1]. And Yonglong Cc'ed had tested it, the waiting caused the driver unload
>> stalling forever and some task hung, see [2].
>>
>> The root cause for the above case is skb_defer_free_flush() not being called
>> as mentioned before.
> 
> Well, let's fix that, then! We already logic to flush backlogs when a
> netdevice is going away, so AFAICT all that's needed is to add the

Is there a possiblity that the page_pool owned page might be still handled/cached
in somewhere of networking if netif_rx_internal() is already called for the
corresponding skb and skb_attempt_defer_free() is called after skb_defer_free_flush()
added in below patch is called?

Maybe add a timeout thing like timer to call kick_defer_list_purge() if you treat
'outstanding forever' as leaked? I actually thought about this, but had not found
out an elegant way to add the timeout.

> skb_defer_free_flush() to that logic. Totally untested patch below, that
> we should maybe consider applying in any case.

I am not sure about that as the above mentioned timing window, but it does seem we
might need to do something similar in dev_cpu_dead().

> 
>> I am not sure if I understand the reasoning behind the above suggestion to 'wait
>> and see if this actually turns out to be a problem' when we already know that there
>> are some cases which need cache kicking/flushing for the waiting to work and those
>> kicking/flushing may not be easy and may take indefinite time too, not to mention
>> there might be other cases that need kicking/flushing that we don't know yet.
>>
>> Is there any reason not to consider recording the inflight pages so that unmapping
>> can be done for inflight pages before driver unbound supposing dynamic number of
>> inflight pages can be supported?
>>
>> IOW, Is there any reason you and jesper taking it as axiomatic that recording the
>> inflight pages is bad supposing the inflight pages can be unlimited and recording
>> can be done with least performance overhead?
> 
> Well, page pool is a memory allocator, and it already has a mechanism to
> handle returning of memory to it. You're proposing to add a second,
> orthogonal, mechanism to do this, one that adds both overhead and

I would call it as a replacement/improvement for the old one instead of
'a second, orthogonal' as the old one doesn't really exist after this patch.

> complexity, yet doesn't handle all cases (cf your comment about devmem).

I am not sure if unmapping only need to be done using its own version DMA API
for devmem yet, but it seems waiting might also need to use its own version
of kicking/flushing for devmem as devmem might be held from the user space?

> 
> And even if it did handle all cases, force-releasing pages in this way
> really feels like it's just papering over the issue. If there are pages
> being leaked (or that are outstanding forever, which basically amounts
> to the same thing), that is something we should be fixing the root cause
> of, not just working around it like this series does.

If there is a definite time for waiting, I am probably agreed with the above.
From the previous discussion, it seems the time to do the kicking/flushing
would be indefinite depending how much cache to be scaned/flushed.

For the 'papering over' part, it seems it is about if we want to paper over
different kicking/flushing or paper over unmapping using different DMA API.

Also page_pool is not really a allocator, instead it is more like a pool
based on different allocator, such as buddy allocator or devmem allocator.
I am not sure it makes much to do the flushing when page_pool_destroy() is
called if the buddy allocator behind the page_pool is not under memory
pressure yet.

For the 'leaked' part mentioned above, I am agreed that it should be fixed
if we have a clear and unified definition of 'leaked'， for example, is it
allowed to keep the cache outstanding forever if the allocator is not under
memory pressure and not ask for the releasing of its memory?

Doesn't it make more sense to use something like shrinker_register() mechanism
to decide whether to do the flushing?

IOW, maybe it makes more sense that the allocator behind the page_pool should
be deciding whether to do the kicking/flushing, and maybe page_pool should also
use the shrinker_register() mechanism to empty its cache when necessary instead
of deciding whether to do the kicking/flushing.

So I am not even sure if it is appropriate to do the cache kicking/flushing
during waiting, not to mention the indefinite time to do the kicking/flushing.

> 
> -Toke
> 
> 
> Patch to flush the deferred free list when taking down a netdevice;
> compile-tested only:

As mentioned above, doesn't it have the time window below?

            CPU 0                           CPU1
      unregister_netdev()                    .
             .                               .
     flush_all_backlogs()                    .
             .                               .
             .                     skb_attempt_defer_free()
             .                               .
             .                               .
             .                               .
             .                               .

