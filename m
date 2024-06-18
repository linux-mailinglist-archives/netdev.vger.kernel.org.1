Return-Path: <netdev+bounces-104295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0C490C115
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 03:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534EB1C211A3
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 01:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD4810A1A;
	Tue, 18 Jun 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqpIbI4E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A764FE556
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718673029; cv=none; b=TKHdjtWaKXqizxd3foMCMXs05hlgmo632mhGR255eviOEUbEBo/SzEY0/yypzMskhkBp698rdkh1FCRwaZBX2HTKdDd9fDwUMDRJYV9L0j8NX/+04BfansNHBlkyvJ/f4jHGQb/Dk0uo5UjOJRRldkmEfoPYSqo9epfGoB6P+yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718673029; c=relaxed/simple;
	bh=HTZ6g9IUGeD0Sp+HQ4VJaE39in25S4GG8W8T3JI1hV4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dGzU97RCBsSJGAKSzDbGdrWLLqqswolpwyBbZ6G9AbjwCmBgnIAHd5om9c+Xu0OvKp/1zxsOfgtQjgn/+dygXMvIB1A3bKoVs0BLbgmyYLjiSySbo/3utcRbC7RsSEAJcggj7i2/bV5K7G9pk4ktuqSRhH/uXD1D/I6BPvfd4SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqpIbI4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E16FC4AF54;
	Tue, 18 Jun 2024 01:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718673029;
	bh=HTZ6g9IUGeD0Sp+HQ4VJaE39in25S4GG8W8T3JI1hV4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fqpIbI4EhgEuNE0WefdYKb/M3sBsHPj8SAftnqkkS4qsOgLrHaIXWc+8i35gKxmSw
	 HejVXh78vHk61iuNQ6ZHlCZprAfp7vD+hXX3f9JKdE7AemSUEFAkbDZBNBn04Kk/Np
	 uxk2uOTafhSbMTnHc7oNGvsPMWzf/v4Vam/ThSl5lEcitS3Y5IEARkOWF2Q7DRAXwb
	 1hur6y85aI+bo0Gt9zF2hXY+61zO+JCMf/2beEz9iO8hneqDOX6+eYHoj8425o8dnN
	 NN2y4rg8Jk6x1N5GjVtIfNwuuR8rTc7pAnoJetKwp5koL3Dzn09h6NtSl+A8RCwXH6
	 CU9BA3LDUviCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D78BD2D102;
	Tue, 18 Jun 2024 01:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: prevent possible NULL dereference in rt6_probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171867302918.10892.6984310345100199393.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jun 2024 01:10:29 +0000
References: <20240615151454.166404-1-edumazet@google.com>
In-Reply-To: <20240615151454.166404-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 15 Jun 2024 15:14:54 +0000 you wrote:
> syzbot caught a NULL dereference in rt6_probe() [1]
> 
> Bail out if  __in6_dev_get() returns NULL.
> 
> [1]
> Oops: general protection fault, probably for non-canonical address 0xdffffc00000000cb: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000658-0x000000000000065f]
> CPU: 1 PID: 22444 Comm: syz-executor.0 Not tainted 6.10.0-rc2-syzkaller-00383-gb8481381d4e2 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
>  RIP: 0010:rt6_probe net/ipv6/route.c:656 [inline]
>  RIP: 0010:find_match+0x8c4/0xf50 net/ipv6/route.c:758
> Code: 14 fd f7 48 8b 85 38 ff ff ff 48 c7 45 b0 00 00 00 00 48 8d b8 5c 06 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 19
> RSP: 0018:ffffc900034af070 EFLAGS: 00010203
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90004521000
> RDX: 00000000000000cb RSI: ffffffff8990d0cd RDI: 000000000000065c
> RBP: ffffc900034af150 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000002 R12: 000000000000000a
> R13: 1ffff92000695e18 R14: ffff8880244a1d20 R15: 0000000000000000
> FS:  00007f4844a5a6c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b31b27000 CR3: 000000002d42c000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>   rt6_nh_find_match+0xfa/0x1a0 net/ipv6/route.c:784
>   nexthop_for_each_fib6_nh+0x26d/0x4a0 net/ipv4/nexthop.c:1496
>   __find_rr_leaf+0x6e7/0xe00 net/ipv6/route.c:825
>   find_rr_leaf net/ipv6/route.c:853 [inline]
>   rt6_select net/ipv6/route.c:897 [inline]
>   fib6_table_lookup+0x57e/0xa30 net/ipv6/route.c:2195
>   ip6_pol_route+0x1cd/0x1150 net/ipv6/route.c:2231
>   pol_lookup_func include/net/ip6_fib.h:616 [inline]
>   fib6_rule_lookup+0x386/0x720 net/ipv6/fib6_rules.c:121
>   ip6_route_output_flags_noref net/ipv6/route.c:2639 [inline]
>   ip6_route_output_flags+0x1d0/0x640 net/ipv6/route.c:2651
>   ip6_dst_lookup_tail.constprop.0+0x961/0x1760 net/ipv6/ip6_output.c:1147
>   ip6_dst_lookup_flow+0x99/0x1d0 net/ipv6/ip6_output.c:1250
>   rawv6_sendmsg+0xdab/0x4340 net/ipv6/raw.c:898
>   inet_sendmsg+0x119/0x140 net/ipv4/af_inet.c:853
>   sock_sendmsg_nosec net/socket.c:730 [inline]
>   __sock_sendmsg net/socket.c:745 [inline]
>   sock_write_iter+0x4b8/0x5c0 net/socket.c:1160
>   new_sync_write fs/read_write.c:497 [inline]
>   vfs_write+0x6b6/0x1140 fs/read_write.c:590
>   ksys_write+0x1f8/0x260 fs/read_write.c:643
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [net] ipv6: prevent possible NULL dereference in rt6_probe()
    https://git.kernel.org/netdev/net/c/b86762dbe19a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



