Return-Path: <netdev+bounces-170452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D11D2A48D01
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 00:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 735FD189082D
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 23:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C213022E410;
	Thu, 27 Feb 2025 23:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j94+kD5T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9453B1AA1E4
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 23:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740700687; cv=none; b=KyZxytnl979PcbU0PXsQCVEti/fXMuvfV2FVErLPp8iZoeHMNVeOQBitY6+0X94n5MDLX/IAzdQc4be3j0LP5oSlPSsMGnoZyDMBAgUlnQYJZNW1tVIUJ35QvB+DzLQiE5tgqsdorJ05d3NQfcYsJOg+LThCf/73soFSw+Coxic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740700687; c=relaxed/simple;
	bh=Qj0y4mbDUKgs2sc/FkENTHVQpyHUnr9xcm+obDHBSI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ltMVRoYeePwiRpTTSCXOpQEn16WLXwyG3r8V/5sn4SIqQtbKnd2nIUh+2x+TycJmcnqo0ZSxgbiOFWXd0pEIjAnYhJcE/+bg64FPGGAZhNT38dDYZ3wSrf4Qsotf4CLQ2CCl7o+kmwK9aXslcuBDyRdSzcabMZZFUoE7N5+7QcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j94+kD5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B724BC4CEDD;
	Thu, 27 Feb 2025 23:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740700687;
	bh=Qj0y4mbDUKgs2sc/FkENTHVQpyHUnr9xcm+obDHBSI0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j94+kD5T1ksdTslATvOz1wxUSDP3U5fIhvOcn0o9odWjxfzPTrF0dCx13j9nddesv
	 K4cRyOxXNAGSWG3IjgFP9heUHuvbjA/vVWbP7FL2i8iga7yndF5zli6qEiNBGua592
	 SWaWwQUGxpnS0MlfztanskT1/poaDBovT9iKJ0HRV7B1OSYzPA3zCoskTWDf/xG++E
	 S3oUT6+kzJRmOzjVq7tYaPTzXeptRwPoqTf9Mb6lCC86du5hj6yGYzvRrQeFJ1lNoR
	 HzXvATA/mT2B5kPjKNkMj1gpAd3ekvShV+7vOeFICCUonPZ9D8X7Eh/HevA8D9r6xm
	 oq9hccQ235Arg==
Message-ID: <6f7da7c8-e3da-4dfc-bc43-3cd525e333a8@kernel.org>
Date: Thu, 27 Feb 2025 16:58:06 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 00/12] ipv4: fib: Convert RTM_NEWROUTE and
 RTM_DELROUTE to per-netns RTNL.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20250226192556.21633-1-kuniyu@amazon.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250226192556.21633-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/25 12:25 PM, Kuniyuki Iwashima wrote:
> Patch 1 is misc cleanup.
> Patch 2 ~ 8 converts two fib_info hash tables to per-netns.
> Patch 9 ~ 12 converts rtnl_lock() to rtnl_net_lcok().
> 
> 
> Changes:
>   v2:
>     * Add Eric's tags except for patch 3 (due to a minor change for exit_batch())
>     * Patch 3
>       * Fix memleak by calling fib4_semantics_exit() properly
>       * Move fib4_semantics_exit() to fib_net_exit_batch()
> 
>   v1: https://lore.kernel.org/netdev/20250225182250.74650-1-kuniyu@amazon.com/
> 
> 
> Kuniyuki Iwashima (12):
>   ipv4: fib: Use cached net in fib_inetaddr_event().
>   ipv4: fib: Allocate fib_info_hash[] and fib_info_laddrhash[] by
>     kvmalloc_array().
>   ipv4: fib: Allocate fib_info_hash[] during netns initialisation.
>   ipv4: fib: Make fib_info_hashfn() return struct hlist_head.
>   ipv4: fib: Remove fib_info_laddrhash pointer.
>   ipv4: fib: Remove fib_info_hash_size.
>   ipv4: fib: Add fib_info_hash_grow().
>   ipv4: fib: Namespacify fib_info hash tables.
>   ipv4: fib: Hold rtnl_net_lock() for ip_fib_net_exit().
>   ipv4: fib: Hold rtnl_net_lock() in ip_rt_ioctl().
>   ipv4: fib: Move fib_valid_key_len() to rtm_to_fib_config().
>   ipv4: fib: Convert RTM_NEWROUTE and RTM_DELROUTE to per-netns RTNL.
> 
>  include/net/ip_fib.h     |   2 +
>  include/net/netns/ipv4.h |   3 +
>  net/ipv4/fib_frontend.c  |  74 ++++++++++----
>  net/ipv4/fib_semantics.c | 207 +++++++++++++++++++--------------------
>  net/ipv4/fib_trie.c      |  22 -----
>  5 files changed, 160 insertions(+), 148 deletions(-)
> 

For the set:
Reviewed-by: David Ahern <dsahern@kernel.org>


