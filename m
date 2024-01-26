Return-Path: <netdev+bounces-66293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DB883E528
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 23:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695311C2092F
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 22:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D7524A02;
	Fri, 26 Jan 2024 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lifMjnbn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FD611702
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307626; cv=none; b=HWvwlpNp/CRsJVtM5w6OnkrTI0IaueyfZd8sV2eFCH7HBlB/Y8fQROMq4Si5yxzPPnk08GMEzfnIQHhzW4NQxK7wu3K+KL7yEHhWampJzekkeMMlyej+psVkpmvAXQHxg/iaXaPgigBBILCocHX7/PAhLGvro00gWDPtRckHrc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307626; c=relaxed/simple;
	bh=Z2ac/aD9OQfVb/F7ynrvnK5YvJoBspdfYYkd6Eo08/E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cZQefka/b/D74Esi3ByB/hRp7iiByH6A0hhAbmjKyVT0pnCBzO8sC6HVc5PtqpncuubYGrkvbIoQ1jgsKRDxQ/MunFUdOWNUID/bvbTMypI9dZrlm08AGsbBuOxfh8mCyeBoLFroQqM9i45fCzz0P5xWsL1vngqgcKpV/H5FeKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lifMjnbn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 348B2C43390;
	Fri, 26 Jan 2024 22:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706307626;
	bh=Z2ac/aD9OQfVb/F7ynrvnK5YvJoBspdfYYkd6Eo08/E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lifMjnbnEuWA1BJAeuL24p7jaJ6t+oXGko12b6Z91ldelyKV7JUzvCIZs4gNLH/Cl
	 7Ci48qUZeMV6PzMPG5btIF/xH3dyGTyO8KYd6Xn1GLWzMZNSXRoUZk05OJBOcx/rq7
	 niZWYu7Dw9TNoW+YbO7Bz4DPW+LwEwQw36s4P7rJlDwfC1IVC/+mIkapLcp+dgMAtU
	 FVBSwE5aKL7pB5l/hAmMU1uZ+tbgxF9pYkasb0Fwr8PKReizC5v0q/q8EoNJqNRLnG
	 CiimvzkdFyV4WGfD6/61G97BPiIou+zOo8rZ316xUk+VzYl76EZMGkguRLlVrDqi0k
	 L8c0mp5RmpzTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C0BEDFF765;
	Fri, 26 Jan 2024 22:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ip6_tunnel: make sure to pull inner header in
 __ip6_tnl_rcv()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170630762611.31948.444264827561958290.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jan 2024 22:20:26 +0000
References: <20240125170557.2663942-1-edumazet@google.com>
In-Reply-To: <20240125170557.2663942-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Jan 2024 17:05:57 +0000 you wrote:
> syzbot found __ip6_tnl_rcv() could access unitiliazed data [1].
> 
> Call pskb_inet_may_pull() to fix this, and initialize ipv6h
> variable after this call as it can change skb->head.
> 
> [1]
>  BUG: KMSAN: uninit-value in __INET_ECN_decapsulate include/net/inet_ecn.h:253 [inline]
>  BUG: KMSAN: uninit-value in INET_ECN_decapsulate include/net/inet_ecn.h:275 [inline]
>  BUG: KMSAN: uninit-value in IP6_ECN_decapsulate+0x7df/0x1e50 include/net/inet_ecn.h:321
>   __INET_ECN_decapsulate include/net/inet_ecn.h:253 [inline]
>   INET_ECN_decapsulate include/net/inet_ecn.h:275 [inline]
>   IP6_ECN_decapsulate+0x7df/0x1e50 include/net/inet_ecn.h:321
>   ip6ip6_dscp_ecn_decapsulate+0x178/0x1b0 net/ipv6/ip6_tunnel.c:727
>   __ip6_tnl_rcv+0xd4e/0x1590 net/ipv6/ip6_tunnel.c:845
>   ip6_tnl_rcv+0xce/0x100 net/ipv6/ip6_tunnel.c:888
>  gre_rcv+0x143f/0x1870
>   ip6_protocol_deliver_rcu+0xda6/0x2a60 net/ipv6/ip6_input.c:438
>   ip6_input_finish net/ipv6/ip6_input.c:483 [inline]
>   NF_HOOK include/linux/netfilter.h:314 [inline]
>   ip6_input+0x15d/0x430 net/ipv6/ip6_input.c:492
>   ip6_mc_input+0xa7e/0xc80 net/ipv6/ip6_input.c:586
>   dst_input include/net/dst.h:461 [inline]
>   ip6_rcv_finish+0x5db/0x870 net/ipv6/ip6_input.c:79
>   NF_HOOK include/linux/netfilter.h:314 [inline]
>   ipv6_rcv+0xda/0x390 net/ipv6/ip6_input.c:310
>   __netif_receive_skb_one_core net/core/dev.c:5532 [inline]
>   __netif_receive_skb+0x1a6/0x5a0 net/core/dev.c:5646
>   netif_receive_skb_internal net/core/dev.c:5732 [inline]
>   netif_receive_skb+0x58/0x660 net/core/dev.c:5791
>   tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1555
>   tun_get_user+0x53af/0x66d0 drivers/net/tun.c:2002
>   tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
>   call_write_iter include/linux/fs.h:2084 [inline]
>   new_sync_write fs/read_write.c:497 [inline]
>   vfs_write+0x786/0x1200 fs/read_write.c:590
>   ksys_write+0x20f/0x4c0 fs/read_write.c:643
>   __do_sys_write fs/read_write.c:655 [inline]
>   __se_sys_write fs/read_write.c:652 [inline]
>   __x64_sys_write+0x93/0xd0 fs/read_write.c:652
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> [...]

Here is the summary with links:
  - [net] ip6_tunnel: make sure to pull inner header in __ip6_tnl_rcv()
    https://git.kernel.org/netdev/net/c/8d975c15c0cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



