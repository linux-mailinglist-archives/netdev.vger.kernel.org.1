Return-Path: <netdev+bounces-143616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB9F9C35C7
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 02:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17BC01C21C52
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 01:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4671F931;
	Mon, 11 Nov 2024 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BS53ovdm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB6DE545;
	Mon, 11 Nov 2024 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731286808; cv=none; b=spxOoD/Bn/XJC3YrvnriO/2kZYHZ4DP+RyUKBOGgYOIszjkcLw8X/e+o8okrfBn6mpPkOPCnCmL5t6vqIhh3DoJMB0WVvyhA8YkIj8am+Kizr7qixai5oiMRBr8ZUjy+11BqQDKGbseeHuto2migIERA4FoLnWgmPM0OkZ42pjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731286808; c=relaxed/simple;
	bh=no3mHB2twsXlA34Fy00xchLZk1X7cfEzBJRPPAJUjRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQXhn87Kf0VNkaLkF+Bx94Zh6rSPxx1lj8XYRRbbaXUkK18MC9XW/+dAS8kQeVBz5EntXViG9pQhMT++k4osZfxing8fyb4EOoP6uWBYqAp1CmsvFF1Rkk53BdpNKMVkwGsSREpKfE8/fJIMTIuKyVHbqFxGxXiNttDC76Uko/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BS53ovdm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8328C4CECD;
	Mon, 11 Nov 2024 01:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731286808;
	bh=no3mHB2twsXlA34Fy00xchLZk1X7cfEzBJRPPAJUjRw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BS53ovdmcARC2LJNIkTDqC5iweZIkJSpWY4cJD3qR2rbB/lMcuucooHXfrvSbtwPI
	 FoB869q1PbtN92TbO3Bc3I7n2ZZYb9j6W4ZxiEOKub8ohCm8ABRL8eLh+HY6eoAxwU
	 EfBCwANOKbGcJKGtnYFbd2ZlPoPG8XBrYWsM9g1goDuweWV3BrIjLypvPrin4gsW73
	 HVPDbFgtOa3wdbGJx7v863aNeGdhalhsCB5QkcKjtp2z7tuko9Df/iC+8qNnlbqgMr
	 LJswad35BErfFCTnwaQztTtpNS4v0r0AKkM/slKFwyrl+jMbJ2ubK70WH0mo7BwQ8C
	 xNt2so64ggnhw==
Message-ID: <ccd59d15-c831-4f9e-9626-7c813301b090@kernel.org>
Date: Sun, 10 Nov 2024 18:00:06 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ipmr: Fix access to mfc_cache_list without lock
 held
To: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20241108-ipmr_rcu-v2-1-c718998e209b@debian.org>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241108-ipmr_rcu-v2-1-c718998e209b@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/24 7:08 AM, Breno Leitao wrote:
> Accessing `mr_table->mfc_cache_list` is protected by an RCU lock. In the
> following code flow, the RCU read lock is not held, causing the
> following error when `RCU_PROVE` is not held. The same problem might
> show up in the IPv6 code path.
> 
> 	6.12.0-rc5-kbuilder-01145-gbac17284bdcb #33 Tainted: G            E    N
> 	-----------------------------
> 	net/ipv4/ipmr_base.c:313 RCU-list traversed in non-reader section!!
> 
> 	rcu_scheduler_active = 2, debug_locks = 1
> 		   2 locks held by RetransmitAggre/3519:
> 		    #0: ffff88816188c6c0 (nlk_cb_mutex-ROUTE){+.+.}-{3:3}, at: __netlink_dump_start+0x8a/0x290
> 		    #1: ffffffff83fcf7a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_dumpit+0x6b/0x90
> 
> 	stack backtrace:
> 		    lockdep_rcu_suspicious
> 		    mr_table_dump
> 		    ipmr_rtm_dumproute
> 		    rtnl_dump_all
> 		    rtnl_dumpit
> 		    netlink_dump
> 		    __netlink_dump_start
> 		    rtnetlink_rcv_msg
> 		    netlink_rcv_skb
> 		    netlink_unicast
> 		    netlink_sendmsg
> 
> This is not a problem per see, since the RTNL lock is held here, so, it
> is safe to iterate in the list without the RCU read lock, as suggested
> by Eric.
> 
> To alleviate the concern, modify the code to use
> list_for_each_entry_rcu() with the RTNL-held argument.
> 
> The annotation will raise an error only if RTNL or RCU read lock are
> missing during iteration, signaling a legitimate problem, otherwise it
> will avoid this false positive.
> 
> This will solve the IPv6 case as well, since ip6mr_rtm_dumproute() calls
> this function as well.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changes in v2:
> - Instead of getting an RCU read lock, rely on rtnl mutex (Eric)
> - Link to v1: https://lore.kernel.org/r/20241107-ipmr_rcu-v1-1-ad0cba8dffed@debian.org
> - Still sending it against `net`, so, since this warning is annoying
> ---
>  net/ipv4/ipmr_base.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



