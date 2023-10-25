Return-Path: <netdev+bounces-44252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 477F87D755C
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 22:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 081AA281CA9
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 20:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3897C328CB;
	Wed, 25 Oct 2023 20:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPJD76/8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D5329422
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 20:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7D3C433C7;
	Wed, 25 Oct 2023 20:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698265061;
	bh=qoQvaVL7qMUrF2iRg4Jlx46CHSMfHeFxu+YI87JqNtQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZPJD76/8LhJHYlPB3WQd/qtrALb0eQaWkvDP5DGoSKzX8no5DOF4brps+vbvg40rA
	 wYFL/atGHorMI5NPmrMXQ5qRRwwbIoXi4sf//Nv67rptHyrzwNUhxNwSCmYMMUT86t
	 KPvSEIp0EcIvDarVoRWVOSsbW3N6dCkIdSzGOm3TnPOHcPs7wpAgo5HWlCS3Y6K/JS
	 59yreOLhEw6RDpU4IvkzgtqNn07ITU6RF06lguWm4AR8zoG8yxR3EyNiYkFGSSjmiq
	 2hQormd/ODU/P+iXQlEBqAXED+SlHEqHJJn2Lde51VVnY3S3kGao7Z52AGsPkob66H
	 Rtt0pBZQWeZDA==
Date: Wed, 25 Oct 2023 13:17:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org
Subject: Re: [PATCH net-next 05/15] net: page_pool: record pools per netdev
Message-ID: <20231025131740.489fdfcf@kernel.org>
In-Reply-To: <CAHS8izOTzLVxQ_rYt1vyhb=tgs2GAtuSZUWkZ183=7J3wEEzjQ@mail.gmail.com>
References: <20231024160220.3973311-1-kuba@kernel.org>
	<20231024160220.3973311-6-kuba@kernel.org>
	<CAHS8izOTzLVxQ_rYt1vyhb=tgs2GAtuSZUWkZ183=7J3wEEzjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Oct 2023 12:56:44 -0700 Mina Almasry wrote:
> > +#if IS_ENABLED(CONFIG_PAGE_POOL)
> > +       /** @page_pools: page pools created for this netdevice */
> > +       struct hlist_head       page_pools;
> > +#endif  
> 
> I wonder if this per netdev field is really necessary. Is it not
> possible to do the same simply looping over the  (global) page_pools
> xarray? Or is that too silly of an idea. I guess on some systems you
> may end up with 100s or 1000s of active or orphaned page pools and
> then globally iterating over the whole page_pools xarray can be really
> slow..

I think we want the per-netdev hlist either way, on netdev
unregistration we need to find its pools to clear the pointers.
At which point we can as well use that to dump the pools.

I don't see a strong reason to use one approach over the other.
Note that other objects like napi and queues (WIP patches) also walk
netdevs and dump sub-objects from them.

> > @@ -48,6 +49,7 @@ struct pp_alloc_cache {
> >   * @pool_size: size of the ptr_ring
> >   * @nid:       NUMA node id to allocate from pages from
> >   * @dev:       device, for DMA pre-mapping purposes
> > + * @netdev:    netdev this pool will serve (leave as NULL if none or multiple)  
> 
> Is this an existing use case (page_pools that serve null or multiple
> netdevs), or a future use case? My understanding is that currently
> page_pools serve at most 1 rx-queue. Spot checking a few drivers that
> seems to be true.

I think I saw one embedded driver for a switch-like device which has
queues servicing all ports, and therefore netdevs.
We'd need some help from people using such devices to figure out what
the right way to represent them is, and what extra bits of
functionality they need.

> I'm guessing 1 is _always_ loopback?

AFAIK, yes. I should probably use LOOPBACK_IFINDEX, to make it clearer.

