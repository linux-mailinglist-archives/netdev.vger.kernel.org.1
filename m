Return-Path: <netdev+bounces-193539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8D7AC460B
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 03:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0741671CE
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 01:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E875045009;
	Tue, 27 May 2025 01:53:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EC01CD0C;
	Tue, 27 May 2025 01:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748310782; cv=none; b=Me2nT/ZiOEilJYDZM7tQMwQH+6ALoYy30WJ9Zw5AjwxxZuPVtDLuEQjE6vNprRL8CRHY1cEsigt2sLgN3Wx4k+ICEayhp8MCWcFRfI/r+RlKoI1KTZ0Vt9DhBxZu8XFV1I/AsD4AjuwnfXr60Q3G+zq8ZjrZ/2PFZ4mJLgUHJH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748310782; c=relaxed/simple;
	bh=vyZZsb+iefQ+UHYLykp29i1wpxxoFJBr0hEtn5FjHu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N/P2yM5nBEh6xrECLNUmulFgp3gqFbdyVJA3vmQkss8ikPMXwMCI/05fQQ6TbgFWqhKyuCfU77pcCrReXddGTxb4WVVGXwFhVjnvcnBhLfm7qpBzyNfRUEqDeaGkQSv7u6J8NceOhhkoYLXZwBO3ncXUGbyb5CtZtFDuDdOatz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4b5wX04dLNzvX0g;
	Tue, 27 May 2025 09:48:32 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id D1CC2180495;
	Tue, 27 May 2025 09:52:56 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 27 May 2025 09:52:56 +0800
Received: from [10.174.177.223] (10.174.177.223) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 27 May 2025 09:52:55 +0800
Message-ID: <72efaa08-807f-4f6b-87c9-6ce07988797a@huawei.com>
Date: Tue, 27 May 2025 09:52:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] page_pool: Fix use-after-free in
 page_pool_recycle_in_ring
To: Mina Almasry <almasrymina@google.com>
CC: Yunsheng Lin <linyunsheng@huawei.com>, <hawk@kernel.org>,
	<ilias.apalodimas@linaro.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhangchangzhong@huawei.com>,
	<syzbot+204a4382fcb3311f3858@syzkaller.appspotmail.com>
References: <20250523064524.3035067-1-dongchenchen2@huawei.com>
 <a5cc7765-0de2-47ca-99c4-a48aaf6384d2@huawei.com>
 <CAHS8izP=AuPbV6N=c05J2kJLJ16-AmRzu983khXaR91Pti=cNw@mail.gmail.com>
 <5305c0d1-c7eb-4c79-96ae-67375f6248f1@huawei.com>
 <CAHS8izPY9BYWzAVR9LNdSP4+-0TsgOoMXvD658i22VFWHZfvfA@mail.gmail.com>
From: "dongchenchen (A)" <dongchenchen2@huawei.com>
In-Reply-To: <CAHS8izPY9BYWzAVR9LNdSP4+-0TsgOoMXvD658i22VFWHZfvfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq200002.china.huawei.com (7.202.195.90)


> )
>
> On Mon, May 26, 2025 at 7:47 AM dongchenchen (A)
> <dongchenchen2@huawei.com> wrote:
>>
>>> On Fri, May 23, 2025 at 1:31 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>>> On 2025/5/23 14:45, Dong Chenchen wrote:
>>>>
>>>>>    static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem)
>>>>>    {
>>>>> +     bool in_softirq;
>>>>>         int ret;
>>>> int -> bool?
>>>>
>>>>>         /* BH protection not needed if current is softirq */
>>>>> -     if (in_softirq())
>>>>> -             ret = ptr_ring_produce(&pool->ring, (__force void *)netmem);
>>>>> -     else
>>>>> -             ret = ptr_ring_produce_bh(&pool->ring, (__force void *)netmem);
>>>>> -
>>>>> -     if (!ret) {
>>>>> +     in_softirq = page_pool_producer_lock(pool);
>>>>> +     ret = !__ptr_ring_produce(&pool->ring, (__force void *)netmem);
>>>>> +     if (ret)
>>>>>                 recycle_stat_inc(pool, ring);
>>>>> -             return true;
>>>>> -     }
>>>>> +     page_pool_producer_unlock(pool, in_softirq);
>>>>>
>>>>> -     return false;
>>>>> +     return ret;
>>>>>    }
>>>>>
>>>>>    /* Only allow direct recycling in special circumstances, into the
>>>>> @@ -1091,10 +1088,14 @@ static void page_pool_scrub(struct page_pool *pool)
>>>>>
>>>>>    static int page_pool_release(struct page_pool *pool)
>>>>>    {
>>>>> +     bool in_softirq;
>>>>>         int inflight;
>>>>>
>>>>>         page_pool_scrub(pool);
>>>>>         inflight = page_pool_inflight(pool, true);
>>>>> +     /* Acquire producer lock to make sure producers have exited. */
>>>>> +     in_softirq = page_pool_producer_lock(pool);
>>>>> +     page_pool_producer_unlock(pool, in_softirq);
>>>> Is a compiler barrier needed to ensure compiler doesn't optimize away
>>>> the above code?
>>>>
>>> I don't want to derail this conversation too much, and I suggested a
>>> similar fix to this initially, but now I'm not sure I understand why
>>> it works.
>>>
>>> Why is the existing barrier not working and acquiring/releasing the
>>> producer lock fixes this issue instead? The existing barrier is the
>>> producer thread incrementing pool->pages_state_release_cnt, and
>>> page_pool_release() is supposed to block the freeing of the page_pool
>>> until it sees the
>>> `atomic_inc_return_relaxed(&pool->pages_state_release_cnt);` from the
>>> producer thread. Any idea why this barrier is not working? AFAIU it
>>> should do the exact same thing as acquiring/dropping the producer
>>> lock.
>> Hi, Mina
>> As previously mentioned:
>> page_pool_recycle_in_ring
>>     ptr_ring_produce
>>       spin_lock(&r->producer_lock);
>>       WRITE_ONCE(r->queue[r->producer++], ptr)
>>         //recycle last page to pool, producer + release_cnt = hold_cnt
> This is not right. release_cnt != hold_cnt at this point.

Hi,Mina!
Thanks for your review!
release_cnt != hold_cnt at this point. producer inc r->producer
and release_cnt will be incremented by page_pool_empty_ring() in
page_pool_release().

> Release_cnt is only incremented by the producer _after_ the
> spin_unlock and the recycle_stat_inc have been done. The full call
> stack on the producer thread:
>
> page_pool_put_unrefed_netmem
>      page_pool_recycle_in_ring
>          ptr_ring_produce(&pool->ring, (__force void *)netmem);
>               spin_lock(&r->producer_lock);
>               __ptr_ring_produce(r, ptr);
>               spin_unlock(&r->producer_lock);
>          recycle_stat_inc(pool, ring);

If page_ring is not full, page_pool_recycle_in_ring will return true.
The release cnt will be incremented by page_pool_empty_ring() in
page_pool_release(), and the code as below will not be executed.

page_pool_put_unrefed_netmem
   if (!page_pool_recycle_in_ring(pool, netmem)) //return true
       page_pool_return_page(pool, netmem);

Best Regards,
Dong Chenchen

>      recycle_stat_inc(pool, ring_full);
>      page_pool_return_page
>          atomic_inc_return_relaxed(&pool->pages_state_release_cnt);
>
> The atomic_inc_return_relaxed happens after all the lines that could
> cause UAF are already executed. Is it because we're using the _relaxed
> version of the atomic operation, that the compiler can reorder it to
> happen before the spin_unlock(&r->producer_lock) and before the
> recycle_stat_inc...?
>

