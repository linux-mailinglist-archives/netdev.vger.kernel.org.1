Return-Path: <netdev+bounces-90721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC7F8AFD5E
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 02:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2A11F232F8
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 00:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395051C36;
	Wed, 24 Apr 2024 00:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XU00AYRO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159E6A31
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 00:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713918761; cv=none; b=XWDLhN0sawKJj8OpybuP1rWaoB7QVUrc1gQc9dpAMEpZp6p0gXMzekZyR2C1LqluOtXJyrcKinZINqLn60WI/qZ1wOdI/bEE9/U+WBnwyPLrFkTwryFhoBXbuZ9YWRF5ZIyKbre3isJWiLd/ycs25EL540VHL0Jj76o8S4tl7r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713918761; c=relaxed/simple;
	bh=wq2SxIoy5JIaxCg69zzONRzvFFcY2Ne7feQiedRztmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ipru0t1OBDJ+Ed9M2R9c6GQFTk5VTk1M4HAhYe+Nvn2BceJKN0HKJcP1Ao+i3u7UU15xzilyJmkTx6b4LCGVNkQtgNgpK1NaThSTQVR+MvCnNsLvlVNfvZR323wFTRaRkX9DCiGTiyP14fE0vuMpUzhGz9cqBk8StOsjCcW6Au4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XU00AYRO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C19AC116B1;
	Wed, 24 Apr 2024 00:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713918760;
	bh=wq2SxIoy5JIaxCg69zzONRzvFFcY2Ne7feQiedRztmo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XU00AYRO1IKdnKcViOgDL/Ote+HXyGJ+1LzcWmPJcrYgBWiutL90UZfiHM9eGiwn/
	 jyN8hjzRbdHnNiLDGgdwDWM4uhj7PT2kAzuo0RENYO307YKcBInOaFRepEjYL64YQj
	 jPXj44iYlQRq4aGBZomEhRvrjyo0DLf+WTkdk4h+H5uQdMEiyazMDJaZOiXx0Hcb3K
	 JzJ6SIwJveyWrsYP01YjBxyLKKcasJwlLRNpB2y2dnBpejJYk+RmIxPseygyIHcoim
	 v+mX0huLCZjrwZVtNbGkBH0V52wUkg0hkutYZxqi5PcP8WROZBA8wU8TEelX8HpU73
	 ZtvoNx49Td1oA==
Message-ID: <28bbf698-befb-42f6-b561-851c67f464aa@kernel.org>
Date: Tue, 23 Apr 2024 18:32:39 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: add two more call_rcu_hurry()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Joel Fernandes <joel@joelfernandes.org>,
 "Paul E . McKenney" <paulmck@kernel.org>
References: <20240423205408.39632-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240423205408.39632-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/23/24 2:54 PM, Eric Dumazet wrote:
> I had failures with pmtu.sh selftests lately,
> with netns dismantles firing ref_tracking alerts [1].
> 
> After much debugging, I found that some queued
> rcu callbacks were delayed by minutes, because
> of CONFIG_RCU_LAZY=y option.
> 
> Joel Fernandes had a similar issue in the past,
> fixed with commit 483c26ff63f4 ("net: Use call_rcu_hurry()
> for dst_release()")
> 
> In this commit, I make sure nexthop_free_rcu()
> and free_fib_info_rcu() are not delayed too much
> because they both can release device references.
> 
> tools/testing/selftests/net/pmtu.sh no longer fails.
> 
> Traces were:
> 
> [  968.179860] ref_tracker: veth_A-R1@00000000d0ff3fe2 has 3/5 users at
>                     dst_alloc+0x76/0x160
>                     ip6_dst_alloc+0x25/0x80
>                     ip6_pol_route+0x2a8/0x450
>                     ip6_pol_route_output+0x1f/0x30
>                     fib6_rule_lookup+0x163/0x270
>                     ip6_route_output_flags+0xda/0x190
>                     ip6_dst_lookup_tail.constprop.0+0x1d0/0x260
>                     ip6_dst_lookup_flow+0x47/0xa0
>                     udp_tunnel6_dst_lookup+0x158/0x210
>                     vxlan_xmit_one+0x4c2/0x1550 [vxlan]
>                     vxlan_xmit+0x52d/0x14f0 [vxlan]
>                     dev_hard_start_xmit+0x7b/0x1e0
>                     __dev_queue_xmit+0x20b/0xe40
>                     ip6_finish_output2+0x2ea/0x6e0
>                     ip6_finish_output+0x143/0x320
>                     ip6_output+0x74/0x140
> 
> [  968.179860] ref_tracker: veth_A-R1@00000000d0ff3fe2 has 1/5 users at
>                     netdev_get_by_index+0xc0/0xe0
>                     fib6_nh_init+0x1a9/0xa90
>                     rtm_new_nexthop+0x6fa/0x1580
>                     rtnetlink_rcv_msg+0x155/0x3e0
>                     netlink_rcv_skb+0x61/0x110
>                     rtnetlink_rcv+0x19/0x20
>                     netlink_unicast+0x23f/0x380
>                     netlink_sendmsg+0x1fc/0x430
>                     ____sys_sendmsg+0x2ef/0x320
>                     ___sys_sendmsg+0x86/0xd0
>                     __sys_sendmsg+0x67/0xc0
>                     __x64_sys_sendmsg+0x21/0x30
>                     x64_sys_call+0x252/0x2030
>                     do_syscall_64+0x6c/0x190
>                     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> [  968.179860] ref_tracker: veth_A-R1@00000000d0ff3fe2 has 1/5 users at
>                     ipv6_add_dev+0x136/0x530
>                     addrconf_notify+0x19d/0x770
>                     notifier_call_chain+0x65/0xd0
>                     raw_notifier_call_chain+0x1a/0x20
>                     call_netdevice_notifiers_info+0x54/0x90
>                     register_netdevice+0x61e/0x790
>                     veth_newlink+0x230/0x440
>                     __rtnl_newlink+0x7d2/0xaa0
>                     rtnl_newlink+0x4c/0x70
>                     rtnetlink_rcv_msg+0x155/0x3e0
>                     netlink_rcv_skb+0x61/0x110
>                     rtnetlink_rcv+0x19/0x20
>                     netlink_unicast+0x23f/0x380
>                     netlink_sendmsg+0x1fc/0x430
>                     ____sys_sendmsg+0x2ef/0x320
>                     ___sys_sendmsg+0x86/0xd0
> ....
> [ 1079.316024]  ? show_regs+0x68/0x80
> [ 1079.316087]  ? __warn+0x8c/0x140
> [ 1079.316103]  ? ref_tracker_free+0x1a0/0x270
> [ 1079.316117]  ? report_bug+0x196/0x1c0
> [ 1079.316135]  ? handle_bug+0x42/0x80
> [ 1079.316149]  ? exc_invalid_op+0x1c/0x70
> [ 1079.316162]  ? asm_exc_invalid_op+0x1f/0x30
> [ 1079.316193]  ? ref_tracker_free+0x1a0/0x270
> [ 1079.316208]  ? _raw_spin_unlock+0x1a/0x40
> [ 1079.316222]  ? free_unref_page+0x126/0x1a0
> [ 1079.316239]  ? destroy_large_folio+0x69/0x90
> [ 1079.316251]  ? __folio_put+0x99/0xd0
> [ 1079.316276]  dst_dev_put+0x69/0xd0
> [ 1079.316308]  fib6_nh_release_dsts.part.0+0x3d/0x80
> [ 1079.316327]  fib6_nh_release+0x45/0x70
> [ 1079.316340]  nexthop_free_rcu+0x131/0x170
> [ 1079.316356]  rcu_do_batch+0x1ee/0x820
> [ 1079.316370]  ? rcu_do_batch+0x179/0x820
> [ 1079.316388]  rcu_core+0x1aa/0x4d0
> [ 1079.316405]  rcu_core_si+0x12/0x20
> [ 1079.316417]  __do_softirq+0x13a/0x3dc
> [ 1079.316435]  __irq_exit_rcu+0xa3/0x110
> [ 1079.316449]  irq_exit_rcu+0x12/0x30
> [ 1079.316462]  sysvec_apic_timer_interrupt+0x5b/0xe0
> [ 1079.316474]  asm_sysvec_apic_timer_interrupt+0x1f/0x30
> [ 1079.316569] RIP: 0033:0x7f06b65c63f0
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> ---
>  include/net/nexthop.h    | 2 +-
>  net/ipv4/fib_semantics.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



