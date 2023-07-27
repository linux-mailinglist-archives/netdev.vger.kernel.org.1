Return-Path: <netdev+bounces-21922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8641765488
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 15:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D30DD1C21649
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 13:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71CE171A8;
	Thu, 27 Jul 2023 13:08:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B15DFBFA
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 13:08:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7218C433C8;
	Thu, 27 Jul 2023 13:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690463308;
	bh=wsqLWqnFkwqGe6Tz0v84pRJxeVWZqoo6vzHlGjLVu7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bqab1TSrt3mJAwj4DNJfrbn3xSjKpUXIuXBhpNPRwSjaNhlAvTpPdVLOLsA/dVPRN
	 Z4mvs3RrZQrXFZjywzy4caqUl1zW/7BL5g0Pr8Gci0V4cr+AnooFSOgvr9i5H3TWER
	 fTyu+4fRNwWC30PlcvMnVvjllTl08YxBE3y0fbyyX2hsP0Lkyaoq3noHYjYBltPkiq
	 dzb7YBs6Wl1amTj3wyGWDsoBW8Oo+zJklFAoPEc4ziAUgPR+GvC4Leamo8KNCIzePV
	 04qAdrNzoyJ0laIxx/XNMuIJt6Zneymlgjge4VPt1y7Cj0FyUdkimJiJDKFiI3w2G3
	 Y2Xu5dxdUCleA==
Date: Thu, 27 Jul 2023 16:08:24 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, sd@queasysnail.net
Subject: Re: [PATCH net-next v2 1/2] net: store netdevs in an xarray
Message-ID: <20230727130824.GA2652767@unreal>
References: <20230726185530.2247698-1-kuba@kernel.org>
 <20230726185530.2247698-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726185530.2247698-2-kuba@kernel.org>

On Wed, Jul 26, 2023 at 11:55:29AM -0700, Jakub Kicinski wrote:
> Iterating over the netdev hash table for netlink dumps is hard.
> Dumps are done in "chunks" so we need to save the position
> after each chunk, so we know where to restart from. Because
> netdevs are stored in a hash table we remember which bucket
> we were in and how many devices we dumped.
> 
> Since we don't hold any locks across the "chunks" - devices may
> come and go while we're dumping. If that happens we may miss
> a device (if device is deleted from the bucket we were in).
> We indicate to user space that this may have happened by setting
> NLM_F_DUMP_INTR. User space is supposed to dump again (I think)
> if it sees that. Somehow I doubt most user space gets this right..
> 
> To illustrate let's look at an example:
> 
>                System state:
>   start:       # [A, B, C]
>   del:  B      # [A, C]
> 
> with the hash table we may dump [A, B], missing C completely even
> tho it existed both before and after the "del B".
> 
> Add an xarray and use it to allocate ifindexes. This way we
> can iterate ifindexes in order, without the worry that we'll
> skip one. We may still generate a dump of a state which "never
> existed", for example for a set of values and sequence of ops:
> 
>                System state:
>   start:       # [A, B]
>   add:  C      # [A, C, B]
>   del:  B      # [A, C]
> 
> we may generate a dump of [A], if C got an index between A and B.
> System has never been in such state. But I'm 90% sure that's perfectly
> fine, important part is that we can't _miss_ devices which exist before
> and after. User space which wants to mirror kernel's state subscribes
> to notifications and does periodic dumps so it will know that C exists
> from the notification about its creation or from the next dump
> (next dump is _guaranteed_ to include C, if it doesn't get removed).
> 
> To avoid any perf regressions keep the hash table for now. Most
> net namespaces have very few devices and microbenchmarking 1M lookups
> on Skylake I get the following results (not counting loopback
> to number of devs):
> 
>  #devs | hash |  xa  | delta
>     2  | 18.3 | 20.1 | + 9.8%
>    16  | 18.3 | 20.1 | + 9.5%
>    64  | 18.3 | 26.3 | +43.8%
>   128  | 20.4 | 26.3 | +28.6%
>   256  | 20.0 | 26.4 | +32.1%
>  1024  | 26.6 | 26.7 | + 0.2%
>  8192  |541.3 | 33.5 | -93.8%
> 
> No surprises since the hash table has 256 entries.
> The microbenchmark scans indexes in order, if the pattern is more
> random xa starts to win at 512 devices already. But that's a lot
> of devices, in practice.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - fix error checking on xa_alloc_cyclic() (Leon)
> ---
>  include/net/net_namespace.h |  4 +-
>  net/core/dev.c              | 82 ++++++++++++++++++++++++-------------
>  2 files changed, 57 insertions(+), 29 deletions(-)

<...>

>  	unsigned int		dev_base_seq;	/* protected by rtnl_mutex */
> -	int			ifindex;
> +	u32			ifindex;

<...>

> +static int dev_index_reserve(struct net *net, u32 ifindex)
>  {
> -	int ifindex = net->ifindex;
> +	int err;

<...>

> +	if (!ifindex)
> +		err = xa_alloc_cyclic(&net->dev_by_index, &ifindex, NULL,
> +				      xa_limit_31b, &net->ifindex, GFP_KERNEL);
> +	else
> +		err = xa_insert(&net->dev_by_index, ifindex, NULL, GFP_KERNEL);
> +	if (err < 0)
> +		return err;
> +
> +	return ifindex;

ifindex is now u32, but you return it as int. In potential, you can
return valid ifindex which will be treated as error.

You should ensure that ifindex doesn't have signed bit on.

Everything else, LGTM
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

