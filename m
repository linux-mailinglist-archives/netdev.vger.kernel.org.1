Return-Path: <netdev+bounces-30681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A04C178885A
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 15:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A1E52817D5
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 13:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C366D532;
	Fri, 25 Aug 2023 13:22:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5A7DDAA
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 13:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8B8C433C9;
	Fri, 25 Aug 2023 13:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692969731;
	bh=A+K43LzrIzq1XxVvQVmlnM9SsvRJg5o3dYZIeBBQvGg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=MKHZl667A62BBVt3iM7x3mUwvWLQrSF/56EJvOigyboud+3bADLaRhCTFt9O5RmWX
	 StuehgIKxvzqWSR3CP+oRpWvV4EcgcuVPneCWnQTlUlXZ6hGLtZ+qhZD7I9jZxfiDP
	 YYTBWFYqWz+tUfex6eWu77wgzMNv5wamWEqpb2Y3MiQ0PPaKqazfkNXgenM0qzodm+
	 /4SmmZ/7MqT1dq6vEpF5CMmusb/lv42WqoG//J82OuPRIFJk0gxRQ9KlruTF5vRJWK
	 8SBvjPY/saGoLa0/m6sNkouEk33EmwKlo6tDtsBX8KnsTSFhkHMgzuFnVhvyMxsCuY
	 FZ3hsFLe8wgKg==
Message-ID: <044c90b6-4e38-9ae9-a462-def21649183d@kernel.org>
Date: Fri, 25 Aug 2023 15:22:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: hawk@kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, Ratheesh Kannoth <rkannoth@marvell.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Geetha sowjanya <gakula@marvell.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>, Sunil Goutham
 <sgoutham@marvell.com>, Thomas Gleixner <tglx@linutronix.de>,
 hariprasad <hkelam@marvell.com>,
 Qingfang DENG <qingfang.deng@siflower.com.cn>
Subject: Re: [BUG] Possible unsafe page_pool usage in octeontx2
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>
References: <20230823094757.gxvCEOBi@linutronix.de>
 <d34d4c1c-2436-3d4c-268c-b971c9cc473f@kernel.org>
 <923d74d4-3d43-8cac-9732-c55103f6dafb@intel.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <923d74d4-3d43-8cac-9732-c55103f6dafb@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 24/08/2023 17.26, Alexander Lobakin wrote:
> From: Jesper Dangaard Brouer<hawk@kernel.org>
> Date: Wed, 23 Aug 2023 21:45:04 +0200
> 
>> (Cc Olek as he have changes in this code path)
> Thanks! I was reading the thread a bit on LKML, but being in the CC list
> is more convenient :D
> 

:D

>> On 23/08/2023 11.47, Sebastian Andrzej Siewior wrote:
>>> Hi,
>>>
>>> I've been looking at the page_pool locking.
>>>
>>> page_pool_alloc_frag() -> page_pool_alloc_pages() ->
>>> __page_pool_get_cached():
>>>
>>> There core of the allocation is:
>>> |         /* Caller MUST guarantee safe non-concurrent access, e.g.
>>> softirq */
>>> |         if (likely(pool->alloc.count)) {
>>> |                 /* Fast-path */
>>> |                 page = pool->alloc.cache[--pool->alloc.count];
>>>
>>> The access to the `cache' array and the `count' variable is not locked.
>>> This is fine as long as there only one consumer per pool. In my
>>> understanding the intention is to have one page_pool per NAPI callback
>>> to ensure this.
>>>
>> Yes, the intention is a single PP instance is "bound" to one RX-NAPI.
>
> Isn't that also a misuse of page_pool->p.napi? I thought it can be set
> only when page allocation and cache refill happen both inside the same
> NAPI polling function. Otx2 uses workqueues to refill the queues,
> meaning that consumer and producer can happen in different contexts or
> even threads and it shouldn't set p.napi.
> 

As Jakub wrote this otx2 driver doesn't set p.napi (so that part of the
problem cannot happen).

That said using workqueues to refill the queues is not compatible with
using page_pool_alloc APIs.  This need to be fixed in driver!

--Jesper

