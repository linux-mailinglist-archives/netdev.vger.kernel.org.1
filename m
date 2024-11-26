Return-Path: <netdev+bounces-147384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D5A9D9561
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 11:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6CD165CA3
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1AF1BFE0C;
	Tue, 26 Nov 2024 10:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaAVXfs+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95548195FEF;
	Tue, 26 Nov 2024 10:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732616565; cv=none; b=myzR6X5hSoYbjbUQqbEUHrbzIPCWyRcC0rCFoZd/dt6S6vsyP4sO4azQPaLtnblQDJnagInsvmwTBsfa42BUQ6NhG3vI1k1tNmUUfau5i+wJ+LrT9+hPpQ6vhzdB5y/yeSoGxUPxLsBfDfMrFT5gg8vjQbxkM7sqrAkN36gmtbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732616565; c=relaxed/simple;
	bh=Fk/PTflTbAr/9jycZ02Vdv38Z0hd7Vu1hxIPifBY4gM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cR3mwQYQVLUeicJaQnaT6VFGcHpaoDtE5TozxCics6QxKN/AsLvFINyi4eNIddQvv7qeBGDgAiqydSSP/uiappPooQXnwO+JRApdZt1id5KSPHeVa+uloZlnPw2wYZHSPYsZUbw9X/XSLPcOIryVB9DB+G3gNOqNB2CYpdX6r9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaAVXfs+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31267C4CED0;
	Tue, 26 Nov 2024 10:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732616565;
	bh=Fk/PTflTbAr/9jycZ02Vdv38Z0hd7Vu1hxIPifBY4gM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DaAVXfs+Iqh4zfXvT8lyskUt0jbaig1eQU+y41vxLnpS5Z533x5RHK896FfnH908J
	 bRAMMpZn5xuxb9nV7ImC+60mU15o6sT1bq7C7HrvONmeSjZlws2J0VNGoHwROW4+E3
	 plvUycQ7ws5ZrVLmkqIkCMA8hJNm1gIqySmT/6OlAEKjUSTqTVW3P0oQP3sPm7JRzJ
	 4WbssJKAwvcAMa2r47cf5zDkfU7raW83+3XwM+pvpoTOvsfcG0gleRqpwh51FToUMr
	 WTK/FBPZtf6WkOwwhduXUEs2xn0kdz2Qbmn0sTfb6M4GHel8uzJw+3gskohTFOe7ps
	 VrN3glT5Pcz8w==
Message-ID: <554e768b-e990-49ff-bad4-805ee931597f@kernel.org>
Date: Tue, 26 Nov 2024 11:22:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 2/3] page_pool: fix IOMMU crash when driver has
 already unbound
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
Cc: liuyonglong@huawei.com, fanghaiqing@huawei.com, zhangkun09@huawei.com,
 Robin Murphy <robin.murphy@arm.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241120103456.396577-1-linyunsheng@huawei.com>
 <20241120103456.396577-3-linyunsheng@huawei.com>
 <3366bf89-4544-4b82-83ec-fd89dd009228@kernel.org>
 <27475b57-eda1-4d67-93f2-5ca443632f6b@huawei.com>
 <ac728cc1-2ccb-4207-ae11-527a3ed8fbb6@kernel.org>
 <6233e2c3-3fea-4ed0-bdcc-9a625270da37@huawei.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <6233e2c3-3fea-4ed0-bdcc-9a625270da37@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26/11/2024 09.22, Yunsheng Lin wrote:
> On 2024/11/25 23:25, Jesper Dangaard Brouer wrote:
> 
> ...
> 
>>>>> +
>>>>>     void page_pool_destroy(struct page_pool *pool)
>>>>>     {
>>>>>         if (!pool)
>>>>> @@ -1139,6 +1206,8 @@ void page_pool_destroy(struct page_pool *pool)
>>>>>          */
>>>>>         synchronize_rcu();
>>>>>     +    page_pool_inflight_unmap(pool);
>>>>> +
>>>>
>>>> Reaching here means we have detected in-flight packets/pages.
>>>>
>>>> In "page_pool_inflight_unmap" we scan and find those in-flight pages to
>>>> DMA unmap them. Then below we wait for these in-flight pages again.
>>>> Why don't we just "release" (page_pool_release_page) those in-flight
>>>> pages from belonging to the page_pool, when we found them during scanning?
>>>>
>>>> If doing so, we can hopefully remove the periodic checking code below.
>>>
>>> I thought about that too, but it means more complicated work than just
>>> calling the page_pool_release_page() as page->pp_ref_count need to be
>>> converted into page->_refcount for the above to work, it seems hard to
>>> do that with least performance degradation as the racing against
>>> page_pool_put_page() being called concurrently.
>>>
>>
>> Maybe we can have a design that avoid/reduce concurrency.  Can we
>> convert the suggested pool->destroy_lock into an atomic?
>> (Doing an *atomic* READ in page_pool_return_page, should be fast if we
>> keep this cache in in (cache coherence) Shared state).
>>
>> In your new/proposed page_pool_return_page() when we see the
>> "destroy_cnt" (now atomic READ) bigger than zero, then we can do nothing
>> (or maybe we need decrement page-refcnt?), as we know the destroy code
> 
> Is it valid to have a page->_refcount of zero when page_pool still own
> the page if we only decrement page->_refcount and not clear page->pp_magic?

No, page_pool keeps page->_refcount equal 1 (for "release") and also 
clears page->pp_magic.

> What happens if put_page() is called from other subsystem for a page_pool
> owned page, isn't that mean the page might be returned to buddy page
> allocator, causing use-after-free problem?
> 

Notice that page_pool_release_page() didn't decrement page refcnt.
It disconnects a page (from a page_pool). To allow it to be used as
a regular page (that will eventually be returned to the normal
page-allocator via put_page).


>> will be taking care of "releasing" the pages from the page pool.
> 
> If page->_refcount is not decremented in page_pool_return_page(), how
> does page_pool_destroy() know if a specific page have been called with
> page_pool_return_page()? Does an extra state is needed to indicate that?
> 

Good point. In page_pool_return_page(), we will need to handle the two 
cases. (1) page still belongs to a page_pool, (2) page have been 
released to look like a normal page. For (2) we do need to call 
put_page().  For (1) yes we would either need some extra state, such 
that page_pool_destroy() knows, or a lock like this patchset.


> And there might still be concurrency between checking/handling of the extra
> state in page_pool_destroy() and the setting of extra state in
> page_pool_return_page(), something like lock might still be needed to avoid
> the above concurrency.
> 

I agree, we (likely) cannot avoid this lock.

>>
>> Once the a page is release from a page pool it becomes a normal page,
>> that adhere to normal page refcnt'ing. That is how it worked before with
>> page_pool_release_page().
>> The later extensions with page fragment support and devmem might have
>> complicated this code path.
> 
> As page_pool_return_page() and page_pool_destroy() both try to "release"
> the page concurrently for a specific page, I am not sure how using some
> simple *atomic* can avoid this kind of concurrency even before page
> fragment and devmem are supported, it would be good to be more specific
> about that by using some pseudocode.
> 

Okay, some my simple atomic idea will not work.

NEW IDEA:

So, the my concern in this patchset is that BH-disabling spin_lock 
pool->destroy_lock is held in the outer loop of 
page_pool_inflight_unmap() that scans all pages.  Disabling BH for this 
long have nasty side-effects.

Will it be enough to grab the pool->destroy_lock only when we detect a 
page that belongs to our page pool?  Of-cause after obtaining the lock. 
the code need to recheck if the page still belongs to the pool.


> I looked at it more closely, previously page_pool_put_page() seemed to
> not be allowed to be called after page_pool_release_page() had been
> called for a specific page mainly because of concurrently checking/handlig
> and clearing of page->pp_magic if I understand it correctly:
> https://elixir.bootlin.com/linux/v5.16.20/source/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c#L5316

As I said above
The page_pool_release_page() didn't decrement page refcnt.
It disconnects a page (from a page_pool). To allow it to be used as
a regular page (that will eventually be returned to the normal
page-allocator via put_page).

--Jesper


