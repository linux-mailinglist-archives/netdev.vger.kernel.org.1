Return-Path: <netdev+bounces-140691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E31B9B7A62
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 13:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A28DB21292
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 12:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C9C19C56C;
	Thu, 31 Oct 2024 12:17:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD9619882B;
	Thu, 31 Oct 2024 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730377055; cv=none; b=Tlqu/2/W9GZN2V6sNDR7NwClORrGDeGq3xJboxHnOnZO3rCizQhgv3M+QSNJahn3iMjFtT95wHDbrZU/JKsvmLiGBNIoUq7d5G//1/+vIw4l/2qqb/H80CurbNmrHkyQ7A9W/0Xfrm1BcB6bMIJ7tWAuQAGC0yHuvvMScZb0OLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730377055; c=relaxed/simple;
	bh=ZJp8CpUWes1dkqbgbG7DbJ43gENXj3SMpJtHKxIrvaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cHBa9rqbXchtaY4Nm2VZ5BvLw/VFBFScjcDUWGMZloSBJ8M8P8nSUhgVkN3cxq7QmI1mFK6j5i97MUJXeM+GNR5TJ/YGFvDA5R42x8WAQRKqeeTynN8p9YcgPY615xEunaOhEss10KGoyg8IOgVMV9yfBo5KtUcoIL/ywtCw5Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XfNGj0FYFzdkYF;
	Thu, 31 Oct 2024 20:14:53 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 267A118009B;
	Thu, 31 Oct 2024 20:17:27 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 31 Oct 2024 20:17:26 +0800
Message-ID: <023fdee7-dbd4-4e78-b911-a7136ff81343@huawei.com>
Date: Thu, 31 Oct 2024 20:17:26 +0800
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
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <87o731by64.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/30 19:57, Toke Høiland-Jørgensen wrote:
> Yunsheng Lin <linyunsheng@huawei.com> writes:
> 
>>> But, well, I'm not sure it is? You seem to be taking it as axiomatic
>>> that the wait in itself is bad. Why? It's just a bit memory being held
>>> on to while it is still in use, and so what?
>>
>> Actually, I thought about adding some sort of timeout or kicking based on
>> jakub's waiting patch too.
>>
>> But after looking at more caching in the networking, waiting and kicking/flushing
>> seems harder than recording the inflight pages, mainly because kicking/flushing
>> need very subsystem using page_pool owned page to provide a kicking/flushing
>> mechanism for it to work, not to mention how much time does it take to do all
>> the kicking/flushing.
> 
> Eliding the details above, but yeah, you're right, there are probably
> some pernicious details to get right if we want to flush all caches. S
> I wouldn't do that to start with. Instead, just add the waiting to start
> with, then wait and see if this actually turns out to be a problem in
> practice. And if it is, identify the source of that problem, deal with
> it, rinse and repeat :)

I am not sure if I have mentioned to you that jakub had a RFC for the waiting,
see [1]. And Yonglong Cc'ed had tested it, the waiting caused the driver unload
stalling forever and some task hung, see [2].

The root cause for the above case is skb_defer_free_flush() not being called
as mentioned before.

I am not sure if I understand the reasoning behind the above suggestion to 'wait
and see if this actually turns out to be a problem' when we already know that there
are some cases which need cache kicking/flushing for the waiting to work and those
kicking/flushing may not be easy and may take indefinite time too, not to mention
there might be other cases that need kicking/flushing that we don't know yet.

Is there any reason not to consider recording the inflight pages so that unmapping
can be done for inflight pages before driver unbound supposing dynamic number of
inflight pages can be supported?

IOW, Is there any reason you and jesper taking it as axiomatic that recording the
inflight pages is bad supposing the inflight pages can be unlimited and recording
can be done with least performance overhead?

Or is there any better idea other than recording the inflight pages and doing the
kicking/flushing during waiting?

1. https://lore.kernel.org/netdev/20240806151618.1373008-1-kuba@kernel.org/
2. https://lore.kernel.org/netdev/758b4d47-c980-4f66-b4a4-949c3fc4b040@huawei.com/

> 
> -Toke
> 
> 

