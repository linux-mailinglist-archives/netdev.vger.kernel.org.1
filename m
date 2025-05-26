Return-Path: <netdev+bounces-193455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE75AC41B1
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 16:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76A517A5A0C
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 14:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A39F86348;
	Mon, 26 May 2025 14:47:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB182AD04;
	Mon, 26 May 2025 14:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748270864; cv=none; b=ZRUWAIHn45/MaY829oVZEQEYeGzc24NOYhaYx7Ydm7+TTViMpSa80j8A6juAu+qHgYF6KENolhxIBdzxrxY/MGyMvoNctjHH1vwbcab9/7mnj7uEtqul6cHLRswwUwBMkU6soYVmPXBUHmKi+HkZUCut1zbzOFU8ojXKYiHdgEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748270864; c=relaxed/simple;
	bh=VfPyiSH6R8wPZaaRRvxI/9uXCAhqSccbloq57hWez/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m0A8YFXLFpLAD8Op9xroeYfyoVrSyxYlr0eF8bPHs5g8qy9eMDuqQrLDc6yTamjAVC2qP0CW1valk3Jf/ypslKJHOXS4hlkAGt0Zre3C4xDvMlM0f0U2zhc/aR/hD1SFafcUanNN1sXxX4gVtuMVC3kfmWeaMO3U2zhoNXzGJKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4b5dmK6gfWzvX07;
	Mon, 26 May 2025 22:43:13 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id E7B8F1401E9;
	Mon, 26 May 2025 22:47:37 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 May 2025 22:47:37 +0800
Received: from [10.174.177.223] (10.174.177.223) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 May 2025 22:47:36 +0800
Message-ID: <5305c0d1-c7eb-4c79-96ae-67375f6248f1@huawei.com>
Date: Mon, 26 May 2025 22:47:36 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] page_pool: Fix use-after-free in
 page_pool_recycle_in_ring
To: Mina Almasry <almasrymina@google.com>, Yunsheng Lin
	<linyunsheng@huawei.com>
CC: <hawk@kernel.org>, <ilias.apalodimas@linaro.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhangchangzhong@huawei.com>,
	<syzbot+204a4382fcb3311f3858@syzkaller.appspotmail.com>
References: <20250523064524.3035067-1-dongchenchen2@huawei.com>
 <a5cc7765-0de2-47ca-99c4-a48aaf6384d2@huawei.com>
 <CAHS8izP=AuPbV6N=c05J2kJLJ16-AmRzu983khXaR91Pti=cNw@mail.gmail.com>
From: "dongchenchen (A)" <dongchenchen2@huawei.com>
In-Reply-To: <CAHS8izP=AuPbV6N=c05J2kJLJ16-AmRzu983khXaR91Pti=cNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq200002.china.huawei.com (7.202.195.90)


> On Fri, May 23, 2025 at 1:31 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>> On 2025/5/23 14:45, Dong Chenchen wrote:
>>
>>>   static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem)
>>>   {
>>> +     bool in_softirq;
>>>        int ret;
>> int -> bool?
>>
>>>        /* BH protection not needed if current is softirq */
>>> -     if (in_softirq())
>>> -             ret = ptr_ring_produce(&pool->ring, (__force void *)netmem);
>>> -     else
>>> -             ret = ptr_ring_produce_bh(&pool->ring, (__force void *)netmem);
>>> -
>>> -     if (!ret) {
>>> +     in_softirq = page_pool_producer_lock(pool);
>>> +     ret = !__ptr_ring_produce(&pool->ring, (__force void *)netmem);
>>> +     if (ret)
>>>                recycle_stat_inc(pool, ring);
>>> -             return true;
>>> -     }
>>> +     page_pool_producer_unlock(pool, in_softirq);
>>>
>>> -     return false;
>>> +     return ret;
>>>   }
>>>
>>>   /* Only allow direct recycling in special circumstances, into the
>>> @@ -1091,10 +1088,14 @@ static void page_pool_scrub(struct page_pool *pool)
>>>
>>>   static int page_pool_release(struct page_pool *pool)
>>>   {
>>> +     bool in_softirq;
>>>        int inflight;
>>>
>>>        page_pool_scrub(pool);
>>>        inflight = page_pool_inflight(pool, true);
>>> +     /* Acquire producer lock to make sure producers have exited. */
>>> +     in_softirq = page_pool_producer_lock(pool);
>>> +     page_pool_producer_unlock(pool, in_softirq);
>> Is a compiler barrier needed to ensure compiler doesn't optimize away
>> the above code?
>>
> I don't want to derail this conversation too much, and I suggested a
> similar fix to this initially, but now I'm not sure I understand why
> it works.
>
> Why is the existing barrier not working and acquiring/releasing the
> producer lock fixes this issue instead? The existing barrier is the
> producer thread incrementing pool->pages_state_release_cnt, and
> page_pool_release() is supposed to block the freeing of the page_pool
> until it sees the
> `atomic_inc_return_relaxed(&pool->pages_state_release_cnt);` from the
> producer thread. Any idea why this barrier is not working? AFAIU it
> should do the exact same thing as acquiring/dropping the producer
> lock.

Hi, Mina
As previously mentioned:
page_pool_recycle_in_ring
   ptr_ring_produce
     spin_lock(&r->producer_lock);
     WRITE_ONCE(r->queue[r->producer++], ptr)
       //recycle last page to pool, producer + release_cnt = hold_cnt
				page_pool_release
				  page_pool_scrub
				    page_pool_empty_ring
				      ptr_ring_consume
				        page_pool_return_page
				       //release_cnt=hold_cnt
				  __page_pool_destroy //inflight=0
				     free_percpu(pool->recycle_stats);
				     free(pool) //free
      spin_unlock(&r->producer_lock); //pool->ring uaf read
   recycle_stat_inc(pool, ring);

release_cnt can block the freeing of the page_pool until it sees the
(release_cnt = hold_cnt) from the producer thread.
However, page_pool_release() can be executed simultaneously when a page
is recycle (e.g. kfree_skb). page_pool release_cnt will increase after
the producer is written, then pool can be free and pool read in producer
will trigger UAF.
So adding a producer lock barrier to wait for recycle process to
complete can fix it.

Best Regards,
Dong Chenchen

>

