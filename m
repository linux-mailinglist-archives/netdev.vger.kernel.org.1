Return-Path: <netdev+bounces-132722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 581F0992E65
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029A71F23AC9
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97D61D47D9;
	Mon,  7 Oct 2024 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RasZrjhp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939431D47D4
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310134; cv=none; b=sSFC0OjJTjU/4OHJziPLRs0oAqCU1Ukn0ceteSUsKNwZBkCI+Am7dErW5oCmsnbKNyOjLKgCUKuH4VdV2TGKPMiEXZNG5Ny9H7cfJbbIx7sDTbjZBof6jxm/cNQjpRcCOF2nPT4nq8XYS9d7VocI/gFNGnamzFffsiIXqGGv8jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310134; c=relaxed/simple;
	bh=9QvCN6UDCahzHiBNUMVQxw4kqfccsQYR6OZ1AXQzzYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YY/gPNJJxZ5N9xhqjSzYNszj5q/CFp94tQNJm9ogo5p19sPIM3X5eth0ohOFg3N8AfStCiIMktNJCp9fQyBKaFMbW+ztSBNMWAMvgQd2jIcI2kO1xXgin6vCuSL8pV1MoEXs696IcLyn7BG0TbaF493ZiQqAvpmc2Q0F1PHItqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RasZrjhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0D4C4CEC6;
	Mon,  7 Oct 2024 14:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728310134;
	bh=9QvCN6UDCahzHiBNUMVQxw4kqfccsQYR6OZ1AXQzzYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RasZrjhp4O3t0yIa/tBZoJFxOwDH3cDGN9XUmUKoDTdFFOyuj+854ayDElcrjlUpi
	 DF/7Z4eBa7nKF37Xe08ZQETWcGyL66BtJjyCN6FvARSYag9NQ9TqURvEGM+/SwCPQQ
	 v1SzmMiOCEUyFS6nwzdTSJkKPnCR5zLXRphqD8HB7DADfKVkmE2ei6teFyNoq/0Tmv
	 mGseLSAQwortleCy8M2mpq0tB2Y5v9vvC6b8XiHbQLmObUW2Hr2JSh0Pcq23jsVQWn
	 aMGG3yC4wjuWRn6MpJUSezUamp/Ga18XFfpzmTXiAss5s66yvv2JBSGeE03/0SOhW4
	 6e+0L/OZqByFw==
Date: Mon, 7 Oct 2024 15:08:50 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexandre Ferrieux <alexandre.ferrieux@orange.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 4/4] ipv4: remove fib_info_devhash[]
Message-ID: <20241007140850.GC32733@kernel.org>
References: <20241004134720.579244-1-edumazet@google.com>
 <20241004134720.579244-5-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004134720.579244-5-edumazet@google.com>

On Fri, Oct 04, 2024 at 01:47:20PM +0000, Eric Dumazet wrote:
> Upcoming per-netns RTNL conversion needs to get rid
> of shared hash tables.
> 
> fib_info_devhash[] is one of them.
> 
> It is unclear why we used a hash table, because
> a single hlist_head per net device was cheaper and scalable.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  .../networking/net_cachelines/net_device.rst  |  1 +
>  include/linux/netdevice.h                     |  2 ++
>  net/ipv4/fib_semantics.c                      | 35 ++++++++-----------
>  3 files changed, 18 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
> index 22b07c814f4a4575d255fdf472d07c549536e543..a8e2a7ce0383343464800be8db31aeddd791f086 100644
> --- a/Documentation/networking/net_cachelines/net_device.rst
> +++ b/Documentation/networking/net_cachelines/net_device.rst
> @@ -83,6 +83,7 @@ unsigned_int                        allmulti
>  bool                                uc_promisc                                                      
>  unsigned_char                       nested_level                                                    
>  struct_in_device*                   ip_ptr                  read_mostly         read_mostly         __in_dev_get
> +struct hlist_head                   fib_nh_head
>  struct_inet6_dev*                   ip6_ptr                 read_mostly         read_mostly         __in6_dev_get
>  struct_vlan_info*                   vlan_info                                                       
>  struct_dsa_port*                    dsa_ptr                                                         

> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 4d20c776a4ff3d0e881b8d9b99901edb35f66da2..cda20a3fe1adf54c1e6df5b5a8882ef7830e1b46 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2209,6 +2209,8 @@ struct net_device {
>  
>  	/* Protocol-specific pointers */
>  	struct in_device __rcu	*ip_ptr;
> +	struct hlist_head	fib_nh_head;
> +
>  #if IS_ENABLED(CONFIG_VLAN_8021Q)
>  	struct vlan_info __rcu	*vlan_info;
>  #endif

Hi Eric,

A minor nit from my side: Kernel-doc should be updated for this new field.

...

