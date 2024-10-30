Return-Path: <netdev+bounces-140345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B289B61D5
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 12:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49CC1C214E9
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 11:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940531E3DD8;
	Wed, 30 Oct 2024 11:31:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5881DC06B;
	Wed, 30 Oct 2024 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287866; cv=none; b=LTI1YkOIQ8tm+kzIGBzomOtJh6GUv/8lFezYh+UOJewDEQOxJDWJ//ed+cit442xvJ4MPq82Z5mFZGnRziYzEpc025nmVrsQWN94OfxQxqpfhcWXt9O1vLZaxqykTMdO3z+yS/ZcXGeYjQEz3S4j/l8xPlVF6MXGtyHfyMkCGks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287866; c=relaxed/simple;
	bh=/V4I5KK9EnbYCxoSwhRFeioalYUVCW0qgVUR5YoNqC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ujACaw/ZVeJiCxgD60wUrLYZEnqb73fwwmn/lVosf5kPmO1GiSc5jMMwcUPB+spMXPi1ye2rey5soBowDKoWKps6GMT227f00QKV2llVObEQK4yoXNpA0jZME6qDmv7FRsf84OGsGMaToMe/sWid5+j1IGPVqpa8c0bPDEPUbLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XdlJm37Sjz1jvlv;
	Wed, 30 Oct 2024 19:29:28 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 64B021A0188;
	Wed, 30 Oct 2024 19:31:00 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 30 Oct 2024 19:31:00 +0800
Message-ID: <1eac33ae-e8e1-4437-9403-57291ba4ced6@huawei.com>
Date: Wed, 30 Oct 2024 19:30:59 +0800
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
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <878qu7c8om.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/29 21:58, Toke Høiland-Jørgensen wrote:
> Yunsheng Lin <linyunsheng@huawei.com> writes:
> 
>>>> I would prefer the waiting too if simple waiting fixed the test cases that
>>>> Youglong and Haiqing were reporting and I did not look into the rabbit hole
>>>> of possible caching in networking.
>>>>
>>>> As mentioned in commit log and [1]:
>>>> 1. ipv4 packet defragmentation timeout: this seems to cause delay up to 30
>>>>    secs, which was reported by Haiqing.
>>>> 2. skb_defer_free_flush(): this may cause infinite delay if there is no
>>>>    triggering for net_rx_action(), which was reported by Yonglong.
>>>>
>>>> For case 1, is it really ok to stall the driver unbound up to 30 secs for the
>>>> default setting of defragmentation timeout?
>>>>
>>>> For case 2, it is possible to add timeout for those kind of caching like the
>>>> defragmentation timeout too, but as mentioned in [2], it seems to be a normal
>>>> thing for this kind of caching in networking:
>>>
>>> Both 1 and 2 seem to be cases where the netdev teardown code can just
>>> make sure to kick the respective queues and make sure there's nothing
>>> outstanding (for (1), walk the defrag cache and clear out anything
>>> related to the netdev going away, for (2) make sure to kick
>>> net_rx_action() as part of the teardown).
>>
>> It would be good to be more specific about the 'kick' here, does it mean
>> taking the lock and doing one of below action for each cache instance?
>> 1. flush all the cache of each cache instance.
>> 2. scan for the page_pool owned page and do the finegrained flushing.
> 
> Depends on the context. The page pool is attached to a device, so it
> should be possible to walk the skb frags queue and just remove any skbs
> that refer to that netdevice, or something like that.

I am not sure if netdevice is still the same when passing through all sorts
of software netdevice, checking if it is the page_pool owned page seems safer?

The scaning/flushing seems complicated and hard to get it right if it is
depending on internal detail of other subsystem's cache implementation.

> 
> As for the lack of net_rx_action(), this is related to the deferred
> freeing of skbs, so it seems like just calling skb_defer_free_flush() on
> teardown could be an option.

That was my initial thinking about the above case too if we know which percpu
sd to be passed to skb_defer_free_flush() or which cpu to trigger its
net_rx_action().
But it seems hard to tell which cpu napi is running in before napi is disabled,
which means skb_defer_free_flush() might need to be called for every cpu with
softirq disabled, as skb_defer_free_flush() calls napi_consume_skb() with
budget being 1 or call kick_defer_list_purge() for each CPU.

> 
>>>> "Eric pointed out/predicted there's no guarantee that applications will
>>>> read / close their sockets so a page pool page may be stuck in a socket
>>>> (but not leaked) forever."
>>>
>>> As for this one, I would put that in the "well, let's see if this
>>> becomes a problem in practice" bucket.
>>
>> As the commit log in [2], it seems it is already happening.
>>
>> Those cache are mostly per-cpu and per-socket, and there may be hundreds of
>> CPUs and thousands of sockets in one system, are you really sure we need
>> to take the lock of each cache instance, which may be thousands of them,
>> and do the flushing/scaning of memory used in networking, which may be as
>> large as '24 GiB' mentioned by Jesper?
> 
> Well, as above, the two issues you mentioned are per-netns (or possibly
> per-CPU), so those seem to be manageable to do on device teardown if the
> wait is really a problem.

As above, I am not sure if it is still the same netns if the skb is passing
through all sorts of software netdevice?

> 
> But, well, I'm not sure it is? You seem to be taking it as axiomatic
> that the wait in itself is bad. Why? It's just a bit memory being held
> on to while it is still in use, and so what?

Actually, I thought about adding some sort of timeout or kicking based on
jakub's waiting patch too.

But after looking at more caching in the networking, waiting and kicking/flushing
seems harder than recording the inflight pages, mainly because kicking/flushing
need very subsystem using page_pool owned page to provide a kicking/flushing
mechanism for it to work, not to mention how much time does it take to do all
the kicking/flushing.

It seems rdma subsystem uses a similar mechanism:
https://lwn.net/Articles/989087/

> 
> -Toke
> 
> 
> 

