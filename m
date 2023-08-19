Return-Path: <netdev+bounces-29042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A7478172B
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 05:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E618281D73
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 03:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C05E1368;
	Sat, 19 Aug 2023 03:30:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE49634
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 03:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB12C433C8;
	Sat, 19 Aug 2023 03:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692415817;
	bh=fW2TAJRU6AOsKnXZEzI9EPQ2FnBuUyg4uFyrPxtyWVc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oXjtPgGNc/d6QDtlLJ1MwKZgpyhHTXKfjxflUfcsvTwrn91j1R9IsrXzeD8N8wynt
	 RDOfuFVSwl3ku/uMoA0hvdt/YVkukRGiQNX4AfylTDubQRt/NlHZ9Gb2nXSWElCwfv
	 uLANrqjdOaYZvu8gZbkSh8Zxul9CAJ1D+ftXXL69k1abxfoo0uY0d0xt96am43vRXf
	 3UXZeyC0nnBuf6dSGTn5OSZJClpkxBQMj6IVkdq8U80VuXvsoqmkHJY+1F6KSht3s1
	 mfjsb7yz7Chb94v7WCOdgVAvbqVB4LHmL789wBpRf8qbnbOJPqt1nne38ix2lQ2kE7
	 ffF1VQ7uy7nRw==
Message-ID: <38a06656-b6bf-e6b7-48a1-c489d2d76db8@kernel.org>
Date: Fri, 18 Aug 2023 21:30:15 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v2 02/11] netdev: implement netlink api to bind
 dma-buf to netdevice
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>, sdf@google.com,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
References: <20230810015751.3297321-1-almasrymina@google.com>
 <20230810015751.3297321-3-almasrymina@google.com>
 <7dd4f5b0-0edf-391b-c8b4-3fa82046ab7c@kernel.org>
 <20230815171638.4c057dcd@kernel.org>
 <64dcf5834c4c8_23f1f8294fa@willemb.c.googlers.com.notmuch>
 <c47219db-abf9-8a5c-9b26-61f65ae4dd26@kernel.org>
 <20230817190957.571ab350@kernel.org>
 <CAHS8izN26snAvM5DsGj+bhCUDjtAxCA7anAkO7Gm6JQf=w-CjA@mail.gmail.com>
 <7cac1a2d-6184-7cd6-116c-e2d80c502db5@kernel.org>
 <20230818190653.78ca6e5a@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230818190653.78ca6e5a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/23 8:06 PM, Jakub Kicinski wrote:
> On Fri, 18 Aug 2023 19:34:32 -0600 David Ahern wrote:
>> On 8/18/23 3:52 PM, Mina Almasry wrote:
>>> The sticking points are:
>>> 1. From David: this proposal doesn't give an application the ability
>>> to flush an rx queue, which means that we have to rely on a driver
>>> reset that affects all queues to refill the rx queue buffers.  
>>
>> Generically, the design needs to be able to flush (or invalidate) all
>> references to the dma-buf once the process no longer "owns" it.
> 
> Are we talking about the ability for the app to flush the queue
> when it wants to (do no idea what)? Or auto-flush when app crashes?

If a buffer reference can be invalidated such that a posted buffer is
ignored by H/W, then no flush is needed per se. Either way the key point
is that posted buffers can no longer be filled by H/W once a process no
longer owns the dma-buf reference. I believe the actual mechanism here
will vary by H/W.

> 
>>> 2. From Jakub: the uAPI and implementation here needs to be in line
>>> with his general direction & extensible to apply to existing use cases
>>> `ethtool -L/-G`, etc.  
>>
>> I think this is a bit more open ended given the openness of the netdev
>> netlink API. i.e., managing a H/W queue (create, delete, stop / flush,
>> associate a page_pool) could be done through this API.
>>
>>>
>>> AFAIU this is what I need to do in the next version:
>>>
>>> 1. The uAPI will be changed such that it will either re-configure an
>>> existing queue to bind it to the dma-buf, or allocate a new queue
>>> bound to the dma-buf (not sure which is better at the moment). Either  
>>
>> 1. API to manage a page-pool (create, delete, update).
> 
> I wasn't anticipating a "create page pool" API.
> 
> I was thinking of a scheme where user space sets page pool parameters,
> but the driver still creates the pool.

There needs to be a process (or process group depending on design)
unique page pool due to the lifetime of what is backing it. The driver
or core netdev code can create it; if it is tied to an rx queue and
created by the driver there are design implications. As separate objects
page pools and rx queues can have their own lifetimes (e.g., multiple rx
queues for a single pp); generically a H/W queue and the basis of
buffers supplied to land packets are independent.

> 
> But I guess it is doable. More work, tho. Are there ibverbs which
> can do it? lol.

Well, generically yes - think intent not necessarily a 1:1 mapping.

> 
>> 2. API to add and remove a dma-buf (or host memory buffer) with a
>> page-pool. Remove may take time to flush references pushed to hardware
>> so this would be asynchronous.
>>
>> 3. Create a queue or use an existing queue id and associate a page-pool
>> with it.
>>
>>> way, the configuration will take place immediately, and not rely on an
>>> entire driver reset to actuate the change.  
>>
>> yes
>>
>>>
>>> 2. The uAPI will be changed such that if the netlink socket is closed,
>>> or the process dies, the rx queue will be unbound from the dma-buf or
>>> the rx queue will be freed entirely (again, not sure which is better  
>>
>> I think those are separate actions. But, if the queue was created by and
>> referenced by a process, then closing an fd means it should be freed.
>>
>>> at the moment). The configuration will take place immediately without
>>> relying on a driver reset.  
>>
>> yes on the reset.
>>
>>>
>>> 3. I will add 4 new net_device_ops that Jakub specified:
>>> queue_mem_alloc/free(), and queue_start/stop().
>>>
>>> 4. The uAPI mentioned in #1 will use the new net_device_ops to
>>> allocate or reconfigure a queue attached to the provided dma-buf.
> 
> I'd leave 2, 3, 4 alone for now. Focus on binding a page pool to 
> an existing queue.
> 
>>> Does this sound roughly reasonable here?
>>>
>>> AFAICT the only technical difficulty is that I'm not sure it's
>>> feasible for a driver to start or stop 1 rx-queue without triggering a
>>> full driver reset. The (2) drivers I looked at both do a full reset to
>>> change any queue configuration. I'll investigate.  
>>
> 


