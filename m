Return-Path: <netdev+bounces-142084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 812659BD6CE
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 21:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DD3D1F218DB
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 20:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFBE214402;
	Tue,  5 Nov 2024 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBe0hJcO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A21042077;
	Tue,  5 Nov 2024 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837524; cv=none; b=fT/jDEvc+Ts7SjB3OutL9g6wuTCIWsteRgdRExTlphiqqD7G334I6/pYc8BZN6N9BYODNklp/Jet0J6JB5wq2C1WjCVVziprGNe+H8oL66icNbVHzse3QBuPZ32DduRyN68pRR8/qwZyWQAc4aUZbe3YhJRnib1LJLZ8IX2FnHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837524; c=relaxed/simple;
	bh=6LwYiAB6meT+zkZegA4NYsStaK6/T8Pagdvmw42EAWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGiDOHStLDSB5IOWUDw5W5NYTWC3f1P5H2hcxhUS1WMAayzsQC/yRet+XAdTckhpFt3yaDrIDDrrmlw3FyRBHDKUHGjHjgZEPj3bGa/oPA8tjwlc2BTrPb8PEBxSicliFkxV7IGDd66vcBuEmhduiT8NtjUfNy81Vi7jLbO0PJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBe0hJcO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B170FC4CECF;
	Tue,  5 Nov 2024 20:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730837524;
	bh=6LwYiAB6meT+zkZegA4NYsStaK6/T8Pagdvmw42EAWk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VBe0hJcOMVNXSHfz3dnWDwKUWfk/hwHQWlXOXQer9zhCeMaGY5LqdEC/d4ROryBWb
	 GXZ1Fq7+MmLwv6Gd6t4Sq/yMVn1JcgaHTwl9AVJqJY0qCyhlsDt0msoiWtc0oa+B3t
	 A1GS3Vy1qXthtzRMdLEl5jL1QXD2FhGx0O3kMBn40f6nAWDTfMde0HPzimcUalw4lz
	 dRTJz4JSoGw02X2aAXJHp+GaVhPhC4BvbjsPTzfsKyOhTzNVQvPIQyU7w3qJWOWCuy
	 p1AjmJQ/tW04yHHB6cFnjKmUfklBFHk38ppHWSFewpFGquNRlPQ+OjOuKTLqSAGUxB
	 VVN+RFaYBxbSQ==
Message-ID: <a6cfba96-9164-4497-b075-9359c18a5eef@kernel.org>
Date: Tue, 5 Nov 2024 21:11:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] page_pool: fix IOMMU crash when driver
 has already unbound
To: Yunsheng Lin <linyunsheng@huawei.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc: zhangkun09@huawei.com, fanghaiqing@huawei.com, liuyonglong@huawei.com,
 Robin Murphy <robin.murphy@arm.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet
 <edumazet@google.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 kernel-team <kernel-team@cloudflare.com>
References: <20241022032214.3915232-1-linyunsheng@huawei.com>
 <20241022032214.3915232-4-linyunsheng@huawei.com>
 <dbd7dca7-d144-4a0f-9261-e8373be6f8a1@kernel.org>
 <113c9835-f170-46cf-92ba-df4ca5dfab3d@huawei.com> <878qudftsn.fsf@toke.dk>
 <d8e0895b-dd37-44bf-ba19-75c93605fc5e@huawei.com> <87r084e8lc.fsf@toke.dk>
 <cf1911c5-622f-484c-9ee5-11e1ac83da24@huawei.com> <878qu7c8om.fsf@toke.dk>
 <1eac33ae-e8e1-4437-9403-57291ba4ced6@huawei.com> <87o731by64.fsf@toke.dk>
 <023fdee7-dbd4-4e78-b911-a7136ff81343@huawei.com> <874j4sb60w.fsf@toke.dk>
 <a50250bf-fe76-4324-96d7-b3acf087a18c@huawei.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <a50250bf-fe76-4324-96d7-b3acf087a18c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 01/11/2024 12.11, Yunsheng Lin wrote:
> On 2024/11/1 0:18, Toke Høiland-Jørgensen wrote:
> 
> ...
> 
>>>>
>>>> Eliding the details above, but yeah, you're right, there are probably
>>>> some pernicious details to get right if we want to flush all caches. S
>>>> I wouldn't do that to start with. Instead, just add the waiting to start
>>>> with, then wait and see if this actually turns out to be a problem in
>>>> practice. And if it is, identify the source of that problem, deal with
>>>> it, rinse and repeat :)
>>>
>>> I am not sure if I have mentioned to you that jakub had a RFC for the waiting,
>>> see [1]. And Yonglong Cc'ed had tested it, the waiting caused the driver unload
>>> stalling forever and some task hung, see [2].
>>>
>>> The root cause for the above case is skb_defer_free_flush() not being called
>>> as mentioned before.
>>
>> Well, let's fix that, then! We already logic to flush backlogs when a
>> netdevice is going away, so AFAICT all that's needed is to add the
> 
> Is there a possiblity that the page_pool owned page might be still handled/cached
> in somewhere of networking if netif_rx_internal() is already called for the
> corresponding skb and skb_attempt_defer_free() is called after skb_defer_free_flush()
> added in below patch is called?
> 
> Maybe add a timeout thing like timer to call kick_defer_list_purge() if you treat
> 'outstanding forever' as leaked? I actually thought about this, but had not found
> out an elegant way to add the timeout.
> 
>> skb_defer_free_flush() to that logic. Totally untested patch below, that
>> we should maybe consider applying in any case.
> 
> I am not sure about that as the above mentioned timing window, but it does seem we
> might need to do something similar in dev_cpu_dead().
> 
>>
>>> I am not sure if I understand the reasoning behind the above suggestion to 'wait
>>> and see if this actually turns out to be a problem' when we already know that there
>>> are some cases which need cache kicking/flushing for the waiting to work and those
>>> kicking/flushing may not be easy and may take indefinite time too, not to mention
>>> there might be other cases that need kicking/flushing that we don't know yet.
>>>
>>> Is there any reason not to consider recording the inflight pages so that unmapping
>>> can be done for inflight pages before driver unbound supposing dynamic number of
>>> inflight pages can be supported?
>>>
>>> IOW, Is there any reason you and jesper taking it as axiomatic that recording the
>>> inflight pages is bad supposing the inflight pages can be unlimited and recording
>>> can be done with least performance overhead?
>>
>> Well, page pool is a memory allocator, and it already has a mechanism to
>> handle returning of memory to it. You're proposing to add a second,
>> orthogonal, mechanism to do this, one that adds both overhead and
> 
> I would call it as a replacement/improvement for the old one instead of
> 'a second, orthogonal' as the old one doesn't really exist after this patch.
> 

Yes, are proposing doing a very radical change to the page_pool design.
And this is getting proposed as a fix patch for IOMMU.

It is a very radical change that page_pool needs to keep track of *ALL* 
in-flight pages.

The DMA issue is a life-time issue of DMA object associated with the
struct device.  Then, why are you not looking at extending the life-time
of the DMA object, or at least detect when DMA object goes away, such
that we can change a setting in page_pool to stop calling DMA unmap for
the pages in-flight once they get returned (which we have en existing
mechanism for).


>> complexity, yet doesn't handle all cases (cf your comment about devmem).
> 
> I am not sure if unmapping only need to be done using its own version DMA API
> for devmem yet, but it seems waiting might also need to use its own version
> of kicking/flushing for devmem as devmem might be held from the user space?
> 
>>
>> And even if it did handle all cases, force-releasing pages in this way
>> really feels like it's just papering over the issue. If there are pages
>> being leaked (or that are outstanding forever, which basically amounts
>> to the same thing), that is something we should be fixing the root cause
>> of, not just working around it like this series does.
> 
> If there is a definite time for waiting, I am probably agreed with the above.
>  From the previous discussion, it seems the time to do the kicking/flushing
> would be indefinite depending how much cache to be scaned/flushed.
> 
> For the 'papering over' part, it seems it is about if we want to paper over
> different kicking/flushing or paper over unmapping using different DMA API.
> 
> Also page_pool is not really a allocator, instead it is more like a pool
> based on different allocator, such as buddy allocator or devmem allocator.
> I am not sure it makes much to do the flushing when page_pool_destroy() is
> called if the buddy allocator behind the page_pool is not under memory
> pressure yet.
> 

I still see page_pool as an allocator like the SLUB/SLAB allocators,
where slab allocators are created (and can be destroyed again), which we
can allocate slab objects from.  SLAB allocators also use buddy
allocator as their backing allocator.

The page_pool is of-cause evolving with the addition of the devmem
allocator as a different "backing" allocator type.


> For the 'leaked' part mentioned above, I am agreed that it should be fixed
> if we have a clear and unified definition of 'leaked'， for example, is it
> allowed to keep the cache outstanding forever if the allocator is not under
> memory pressure and not ask for the releasing of its memory?
> 

It seems wrong to me if page_pool need to dictate how long the API users
is allowed to hold the page.

> Doesn't it make more sense to use something like shrinker_register() mechanism
> to decide whether to do the flushing?
> 
> IOW, maybe it makes more sense that the allocator behind the page_pool should
> be deciding whether to do the kicking/flushing, and maybe page_pool should also
> use the shrinker_register() mechanism to empty its cache when necessary instead
> of deciding whether to do the kicking/flushing.
> 

Sure, I've argued before that page_pool should use shrinker_register()
but only when used with the normal buddy allocator.
BUT you need to realize that bad things can happen when network stack
fails to allocate memory for packets, because it can block connections
from making forward progress and those connections can be holding on to
memory (that is part of the memory pressure problem).


> So I am not even sure if it is appropriate to do the cache kicking/flushing
> during waiting, not to mention the indefinite time to do the kicking/flushing.

--Jesper

