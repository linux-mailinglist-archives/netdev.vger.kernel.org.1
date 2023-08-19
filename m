Return-Path: <netdev+bounces-29016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE91978168C
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 04:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91CAF1C20C95
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 02:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013D77FF;
	Sat, 19 Aug 2023 02:06:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9C8652
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580ABC433C7;
	Sat, 19 Aug 2023 02:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692410814;
	bh=GGA/T6kS+dD49AIkz596ODLlbwuST1uYGh3f4ch6eKY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K5XgtQJFm9JCbViXtLOcAYyxZ79ZsD5yifHMemwFfEbnvJm5a7HCwAjD4G8EZAYwg
	 A4QeWPQKhH6e7bR3dIPRYb8eCli/+YrYCahbynuWTKkaVPXejELKmR6H/TiQQ6ctiN
	 NM3BI0CS7M/2nZSTx6WPxih56Fldu+7AInIl/BfJqF1HoX1KgjBDhCVytCA8/+4aO9
	 7+kAFPCLC7MvLQosBWEGxYxwI11cV5a5xHOVGxU5QpY+MTU7ukIi+vQt6Mwfm8Xp1h
	 Yj7DcKmnf4Z1yQAkJQvNvMVGPSEdbyTy8yhGgshsrcENnz8xwshW2FU7uakhtsAjbI
	 Ya4pK+vr5Aecg==
Date: Fri, 18 Aug 2023 19:06:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>, sdf@google.com, Willem de
 Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Subject: Re: [RFC PATCH v2 02/11] netdev: implement netlink api to bind
 dma-buf to netdevice
Message-ID: <20230818190653.78ca6e5a@kernel.org>
In-Reply-To: <7cac1a2d-6184-7cd6-116c-e2d80c502db5@kernel.org>
References: <20230810015751.3297321-1-almasrymina@google.com>
	<20230810015751.3297321-3-almasrymina@google.com>
	<7dd4f5b0-0edf-391b-c8b4-3fa82046ab7c@kernel.org>
	<20230815171638.4c057dcd@kernel.org>
	<64dcf5834c4c8_23f1f8294fa@willemb.c.googlers.com.notmuch>
	<c47219db-abf9-8a5c-9b26-61f65ae4dd26@kernel.org>
	<20230817190957.571ab350@kernel.org>
	<CAHS8izN26snAvM5DsGj+bhCUDjtAxCA7anAkO7Gm6JQf=w-CjA@mail.gmail.com>
	<7cac1a2d-6184-7cd6-116c-e2d80c502db5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Aug 2023 19:34:32 -0600 David Ahern wrote:
> On 8/18/23 3:52 PM, Mina Almasry wrote:
> > The sticking points are:
> > 1. From David: this proposal doesn't give an application the ability
> > to flush an rx queue, which means that we have to rely on a driver
> > reset that affects all queues to refill the rx queue buffers.  
> 
> Generically, the design needs to be able to flush (or invalidate) all
> references to the dma-buf once the process no longer "owns" it.

Are we talking about the ability for the app to flush the queue
when it wants to (do no idea what)? Or auto-flush when app crashes?

> > 2. From Jakub: the uAPI and implementation here needs to be in line
> > with his general direction & extensible to apply to existing use cases
> > `ethtool -L/-G`, etc.  
> 
> I think this is a bit more open ended given the openness of the netdev
> netlink API. i.e., managing a H/W queue (create, delete, stop / flush,
> associate a page_pool) could be done through this API.
> 
> > 
> > AFAIU this is what I need to do in the next version:
> > 
> > 1. The uAPI will be changed such that it will either re-configure an
> > existing queue to bind it to the dma-buf, or allocate a new queue
> > bound to the dma-buf (not sure which is better at the moment). Either  
> 
> 1. API to manage a page-pool (create, delete, update).

I wasn't anticipating a "create page pool" API.

I was thinking of a scheme where user space sets page pool parameters,
but the driver still creates the pool.

But I guess it is doable. More work, tho. Are there ibverbs which
can do it? lol.

> 2. API to add and remove a dma-buf (or host memory buffer) with a
> page-pool. Remove may take time to flush references pushed to hardware
> so this would be asynchronous.
> 
> 3. Create a queue or use an existing queue id and associate a page-pool
> with it.
> 
> > way, the configuration will take place immediately, and not rely on an
> > entire driver reset to actuate the change.  
> 
> yes
> 
> > 
> > 2. The uAPI will be changed such that if the netlink socket is closed,
> > or the process dies, the rx queue will be unbound from the dma-buf or
> > the rx queue will be freed entirely (again, not sure which is better  
> 
> I think those are separate actions. But, if the queue was created by and
> referenced by a process, then closing an fd means it should be freed.
> 
> > at the moment). The configuration will take place immediately without
> > relying on a driver reset.  
> 
> yes on the reset.
> 
> > 
> > 3. I will add 4 new net_device_ops that Jakub specified:
> > queue_mem_alloc/free(), and queue_start/stop().
> > 
> > 4. The uAPI mentioned in #1 will use the new net_device_ops to
> > allocate or reconfigure a queue attached to the provided dma-buf.

I'd leave 2, 3, 4 alone for now. Focus on binding a page pool to 
an existing queue.

> > Does this sound roughly reasonable here?
> > 
> > AFAICT the only technical difficulty is that I'm not sure it's
> > feasible for a driver to start or stop 1 rx-queue without triggering a
> > full driver reset. The (2) drivers I looked at both do a full reset to
> > change any queue configuration. I'll investigate.  
> 


