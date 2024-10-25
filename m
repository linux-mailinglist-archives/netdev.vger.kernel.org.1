Return-Path: <netdev+bounces-138946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C5C9AF818
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 05:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60AB1F2203D
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 03:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256F016F908;
	Fri, 25 Oct 2024 03:20:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482DA42A81;
	Fri, 25 Oct 2024 03:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729826421; cv=none; b=CgCS4aHZwYdUlFnfHwU+uAiKiwuK2k25V1psWH8HEJ9oIc+36Wsv94M34vhDgnwljicobUc37fnQc9m1CaT9JPgmf3YF4OqDN/UBMNBTl7h1/OYj1y7vd7PmO4sRBBVYD6+BzAoRwH462B+h1xW6+nJqbH6IIeyw5hVLNMF9bXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729826421; c=relaxed/simple;
	bh=Zi0X0Y3k2PcqIKxZcExoaxbw7PTvDyAeGsZFckvnnwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Km67kE/oY+TFNoqsR31m7oGR2JUHvtao039OTpPHpwXM8cflP3VWOztMozJdeLRwVWoj7o4UKJ2gPMp5D1mlsEHV7UCaCHqD85qciYk/9KUhcbE6/WD7clht1cP8uXmlFKFFTdJ2WjAYaSS4SJl+S42bW2UeIY6ZFTw9DqG/9UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XZSfx1F14z1jvqs;
	Fri, 25 Oct 2024 11:18:49 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 530D81A016C;
	Fri, 25 Oct 2024 11:20:14 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 25 Oct 2024 11:20:13 +0800
Message-ID: <d8e0895b-dd37-44bf-ba19-75c93605fc5e@huawei.com>
Date: Fri, 25 Oct 2024 11:20:13 +0800
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
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <878qudftsn.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/24 22:40, Toke Høiland-Jørgensen wrote:

...

>>>
>>> I really really dislike this approach!
>>>
>>> Nacked-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>>
>>> Having to keep an array to record all the pages including the ones
>>> which are handed over to network stack, goes against the very principle
>>> behind page_pool. We added members to struct page, such that pages could
>>> be "outstanding".
>>
>> Before and after this patch both support "outstanding", the difference is
>> how many "outstanding" pages do they support.
>>
>> The question seems to be do we really need unlimited inflight page for
>> page_pool to work as mentioned in [1]?
>>
>> 1. https://lore.kernel.org/all/5d9ea7bd-67bb-4a9d-a120-c8f290c31a47@huawei.com/
> 
> Well, yes? Imposing an arbitrary limit on the number of in-flight
> packets (especially such a low one as in this series) is a complete
> non-starter. Servers have hundreds of gigs of memory these days, and if
> someone wants to use that for storing in-flight packets, the kernel
> definitely shouldn't impose some (hard-coded!) limit on that.

You and Jesper seems to be mentioning a possible fact that there might
be 'hundreds of gigs of memory' needed for inflight pages, it would be nice
to provide more info or reasoning above why 'hundreds of gigs of memory' is
needed here so that we don't do a over-designed thing to support recording
unlimited in-flight pages if the driver unbound stalling turns out impossible
and the inflight pages do need to be recorded.

I guess it is common sense to start with easy one until someone complains
with some testcase and detailed reasoning if we need to go the hard way as
you and Jesper are also prefering waiting over having to record the inflight
pages.

More detailed about why we might need to go the hard way of having to record
the inflight pages as below.

> 
>>>
>>> The page_pool already have a system for waiting for these outstanding /
>>> inflight packets to get returned.  As I suggested before, the page_pool
>>> should simply take over the responsability (from net_device) to free the
>>> struct device (after inflight reach zero), where AFAIK the DMA device is
>>> connected via.
>>
>> It seems you mentioned some similar suggestion in previous version,
>> it would be good to show some code about the idea in your mind, I am sure
>> that Yonglong Liu Cc'ed will be happy to test it if there some code like
>> POC/RFC is provided.
> 
> I believe Jesper is basically referring to Jakub's RFC that you
> mentioned below.
> 
>> I should mention that it seems that DMA device is not longer vaild when
>> remove() function of the device driver returns, as mentioned in [2], which
>> means dma API is not allowed to called after remove() function of the device
>> driver returns.
>>
>> 2. https://www.spinics.net/lists/netdev/msg1030641.html
>>
>>>
>>> The alternative is what Kuba suggested (and proposed an RFC for),  that
>>> the net_device teardown waits for the page_pool inflight packets.
>>
>> As above, the question is how long does the waiting take here?
>> Yonglong tested Kuba's RFC, see [3], the waiting took forever due to
>> reason as mentioned in commit log:
>> "skb_defer_free_flush(): this may cause infinite delay if there is no
>> triggering for net_rx_action()."
> 
> Honestly, this just seems like a bug (the "no triggering of
> net_rx_action()") that should be root caused and fixed; not a reason
> that waiting can't work.

I would prefer the waiting too if simple waiting fixed the test cases that
Youglong and Haiqing were reporting and I did not look into the rabbit hole
of possible caching in networking.

As mentioned in commit log and [1]:
1. ipv4 packet defragmentation timeout: this seems to cause delay up to 30
   secs, which was reported by Haiqing.
2. skb_defer_free_flush(): this may cause infinite delay if there is no
   triggering for net_rx_action(), which was reported by Yonglong.

For case 1, is it really ok to stall the driver unbound up to 30 secs for the
default setting of defragmentation timeout?

For case 2, it is possible to add timeout for those kind of caching like the
defragmentation timeout too, but as mentioned in [2], it seems to be a normal
thing for this kind of caching in networking:
"Eric pointed out/predicted there's no guarantee that applications will
read / close their sockets so a page pool page may be stuck in a socket
(but not leaked) forever."

1. https://lore.kernel.org/all/2c5ccfff-6ab4-4aea-bff6-3679ff72cc9a@huawei.com/
2. https://www.spinics.net/lists/netdev/msg952604.html

> 
> -Toke
> 
> 

