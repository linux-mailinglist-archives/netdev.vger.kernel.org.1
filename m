Return-Path: <netdev+bounces-139303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313C99B15EF
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 09:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B6E283203
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 07:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53F117E00E;
	Sat, 26 Oct 2024 07:32:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF3B1369B6;
	Sat, 26 Oct 2024 07:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729927966; cv=none; b=J15cmHNaUblQxkchBkANk8V0nOQetWgOsGilNixJ8ItmfON3w0Yc8pMUM4NDrV5vOhETHJtGvWhy+bayTO2CeLb2MrExcr7HvzdDh1RtVb/HDSiq6cQpLEF7EbFfrUXguFHl5xEeVkTdHu5Zw6frlIoIAkbMpFXz6T6EUHAAWrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729927966; c=relaxed/simple;
	bh=0fImj/1xNzVI2mu3nRBq1x9gHCbv+R2NBwz8+OMc16g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lIA4eYXbC3IKMclfu3nrS+a4zkHI7x8yfrRL+oMA2QklA9SJl2IGF9B4a5GaIuKFsTCY8ADTOI5Zy9FpS5rq7h+t0N1TWMCHQGZgLILz878fT/EENncBJY7se0g+DxZ2twQesKnvI29o3NKbS09Ca0EFgV978T8+poBeRQjNohg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XbBC01CYpz1T8gN;
	Sat, 26 Oct 2024 15:30:36 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F20A140118;
	Sat, 26 Oct 2024 15:32:41 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 26 Oct 2024 15:32:41 +0800
Message-ID: <cf1911c5-622f-484c-9ee5-11e1ac83da24@huawei.com>
Date: Sat, 26 Oct 2024 15:32:35 +0800
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
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <87r084e8lc.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/25 19:16, Toke Høiland-Jørgensen wrote:

...

>>
>> You and Jesper seems to be mentioning a possible fact that there might
>> be 'hundreds of gigs of memory' needed for inflight pages, it would be nice
>> to provide more info or reasoning above why 'hundreds of gigs of memory' is
>> needed here so that we don't do a over-designed thing to support recording
>> unlimited in-flight pages if the driver unbound stalling turns out impossible
>> and the inflight pages do need to be recorded.
> 
> I don't have a concrete example of a use that will blow the limit you
> are setting (but maybe Jesper does), I am simply objecting to the
> arbitrary imposing of any limit at all. It smells a lot of "640k ought
> to be enough for anyone".

From Jesper's link, it seems there is still some limit for those memory and
the limit seems to be configured dynamically.

Currently the number of supporting in-flight pages is depending on the rx
queue number and their queue depth in this patch, as mentioned before, it
always can be dynamic at some cost of complexity and maybe some overhead.

> 
>> I guess it is common sense to start with easy one until someone complains
>> with some testcase and detailed reasoning if we need to go the hard way as
>> you and Jesper are also prefering waiting over having to record the inflight
>> pages.
> 
> AFAIU Jakub's comment on his RFC patch for waiting, he was suggesting
> exactly this: Add the wait, and see if the cases where it can stall turn
> out to be problems in practice.

I should mention that jakub seemed to prefer to only check some condition
to decide if the waiting is needed in [1].

If the below 'kick' need to be done during the waiting, it might be
going the hard way instead of going the easy here comparing to recording
the inflight pages IHMO.

1. https://lore.kernel.org/all/20241014171406.43e730c9@kernel.org/

> 
>> More detailed about why we might need to go the hard way of having to record
>> the inflight pages as below.
>>
>>>
>>>>>
>>>>> The page_pool already have a system for waiting for these outstanding /
>>>>> inflight packets to get returned.  As I suggested before, the page_pool
>>>>> should simply take over the responsability (from net_device) to free the
>>>>> struct device (after inflight reach zero), where AFAIK the DMA device is
>>>>> connected via.
>>>>
>>>> It seems you mentioned some similar suggestion in previous version,
>>>> it would be good to show some code about the idea in your mind, I am sure
>>>> that Yonglong Liu Cc'ed will be happy to test it if there some code like
>>>> POC/RFC is provided.
>>>
>>> I believe Jesper is basically referring to Jakub's RFC that you
>>> mentioned below.
>>>
>>>> I should mention that it seems that DMA device is not longer vaild when
>>>> remove() function of the device driver returns, as mentioned in [2], which
>>>> means dma API is not allowed to called after remove() function of the device
>>>> driver returns.
>>>>
>>>> 2. https://www.spinics.net/lists/netdev/msg1030641.html
>>>>
>>>>>
>>>>> The alternative is what Kuba suggested (and proposed an RFC for),  that
>>>>> the net_device teardown waits for the page_pool inflight packets.
>>>>
>>>> As above, the question is how long does the waiting take here?
>>>> Yonglong tested Kuba's RFC, see [3], the waiting took forever due to
>>>> reason as mentioned in commit log:
>>>> "skb_defer_free_flush(): this may cause infinite delay if there is no
>>>> triggering for net_rx_action()."
>>>
>>> Honestly, this just seems like a bug (the "no triggering of
>>> net_rx_action()") that should be root caused and fixed; not a reason
>>> that waiting can't work.
>>
>> I would prefer the waiting too if simple waiting fixed the test cases that
>> Youglong and Haiqing were reporting and I did not look into the rabbit hole
>> of possible caching in networking.
>>
>> As mentioned in commit log and [1]:
>> 1. ipv4 packet defragmentation timeout: this seems to cause delay up to 30
>>    secs, which was reported by Haiqing.
>> 2. skb_defer_free_flush(): this may cause infinite delay if there is no
>>    triggering for net_rx_action(), which was reported by Yonglong.
>>
>> For case 1, is it really ok to stall the driver unbound up to 30 secs for the
>> default setting of defragmentation timeout?
>>
>> For case 2, it is possible to add timeout for those kind of caching like the
>> defragmentation timeout too, but as mentioned in [2], it seems to be a normal
>> thing for this kind of caching in networking:
> 
> Both 1 and 2 seem to be cases where the netdev teardown code can just
> make sure to kick the respective queues and make sure there's nothing
> outstanding (for (1), walk the defrag cache and clear out anything
> related to the netdev going away, for (2) make sure to kick
> net_rx_action() as part of the teardown).

It would be good to be more specific about the 'kick' here, does it mean
taking the lock and doing one of below action for each cache instance?
1. flush all the cache of each cache instance.
2. scan for the page_pool owned page and do the finegrained flushing.

> 
>> "Eric pointed out/predicted there's no guarantee that applications will
>> read / close their sockets so a page pool page may be stuck in a socket
>> (but not leaked) forever."
> 
> As for this one, I would put that in the "well, let's see if this
> becomes a problem in practice" bucket.

As the commit log in [2], it seems it is already happening.

Those cache are mostly per-cpu and per-socket, and there may be hundreds of
CPUs and thousands of sockets in one system, are you really sure we need
to take the lock of each cache instance, which may be thousands of them,
and do the flushing/scaning of memory used in networking, which may be as
large as '24 GiB' mentioned by Jesper?

2. https://lore.kernel.org/all/20231126230740.2148636-13-kuba@kernel.org/

> 
> -Toke
> 
> 

