Return-Path: <netdev+bounces-31539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF4E78EA38
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 12:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95DF2280CA4
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 10:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD9479E2;
	Thu, 31 Aug 2023 10:30:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFC38F58
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 10:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C14B0C433C9;
	Thu, 31 Aug 2023 10:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693477823;
	bh=T7qxtStTNRjvHruvMkNd/lvSX7GM15JuxytOQELUc8k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eSbe65hbkoNIWuR5GBnymoyPEYviojvqf/RHiMtozHHOeJ1+sh4lHBKyPpOX7z8N3
	 Tb87Xt2NH5RdXSZff5ubiQYuu9xDZjPdri5WjJB0usdd1vQusECkMhhiEk7CL11VU1
	 252c9HSwkXLO4J6Xba0QH5TwUYfBQbGo8MPk87DTorWkYr9xSpg7pQsY1TkWXryOuS
	 ieDoH6DBMG2ncfIoVANqR+206icIyvWREBaKPPqYVKBmGFCGKAaBkuFutD/SSPRNNN
	 ec7ob6ZhEbFNYUXDPKDIClmvXJiNUIJNvd1aWj2nNJ3Tnto3rtInSFFGkGs7riRGkc
	 m944NmU7FXnTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5CCAC595D2;
	Thu, 31 Aug 2023 10:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: read sk->sk_family once in sk_mc_loop()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169347782367.15498.7858009369964639708.git-patchwork-notify@kernel.org>
Date: Thu, 31 Aug 2023 10:30:23 +0000
References: <20230830101244.1146934-1-edumazet@google.com>
In-Reply-To: <20230830101244.1146934-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 kuniyu@amazon.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 30 Aug 2023 10:12:44 +0000 you wrote:
> syzbot is playing with IPV6_ADDRFORM quite a lot these days,
> and managed to hit the WARN_ON_ONCE(1) in sk_mc_loop()
> 
> We have many more similar issues to fix.
> 
> WARNING: CPU: 1 PID: 1593 at net/core/sock.c:782 sk_mc_loop+0x165/0x260
> Modules linked in:
> CPU: 1 PID: 1593 Comm: kworker/1:3 Not tainted 6.1.40-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
> Workqueue: events_power_efficient gc_worker
> RIP: 0010:sk_mc_loop+0x165/0x260 net/core/sock.c:782
> Code: 34 1b fd 49 81 c7 18 05 00 00 4c 89 f8 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 ff e8 25 36 6d fd 4d 8b 37 eb 13 e8 db 33 1b fd <0f> 0b b3 01 eb 34 e8 d0 33 1b fd 45 31 f6 49 83 c6 38 4c 89 f0 48
> RSP: 0018:ffffc90000388530 EFLAGS: 00010246
> RAX: ffffffff846d9b55 RBX: 0000000000000011 RCX: ffff88814f884980
> RDX: 0000000000000102 RSI: ffffffff87ae5160 RDI: 0000000000000011
> RBP: ffffc90000388550 R08: 0000000000000003 R09: ffffffff846d9a65
> R10: 0000000000000002 R11: ffff88814f884980 R12: dffffc0000000000
> R13: ffff88810dbee000 R14: 0000000000000010 R15: ffff888150084000
> FS: 0000000000000000(0000) GS:ffff8881f6b00000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000180 CR3: 000000014ee5b000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> <IRQ>
> [<ffffffff8507734f>] ip6_finish_output2+0x33f/0x1ae0 net/ipv6/ip6_output.c:83
> [<ffffffff85062766>] __ip6_finish_output net/ipv6/ip6_output.c:200 [inline]
> [<ffffffff85062766>] ip6_finish_output+0x6c6/0xb10 net/ipv6/ip6_output.c:211
> [<ffffffff85061f8c>] NF_HOOK_COND include/linux/netfilter.h:298 [inline]
> [<ffffffff85061f8c>] ip6_output+0x2bc/0x3d0 net/ipv6/ip6_output.c:232
> [<ffffffff852071cf>] dst_output include/net/dst.h:444 [inline]
> [<ffffffff852071cf>] ip6_local_out+0x10f/0x140 net/ipv6/output_core.c:161
> [<ffffffff83618fb4>] ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:483 [inline]
> [<ffffffff83618fb4>] ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:529 [inline]
> [<ffffffff83618fb4>] ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:602 [inline]
> [<ffffffff83618fb4>] ipvlan_queue_xmit+0x1174/0x1be0 drivers/net/ipvlan/ipvlan_core.c:677
> [<ffffffff8361ddd9>] ipvlan_start_xmit+0x49/0x100 drivers/net/ipvlan/ipvlan_main.c:229
> [<ffffffff84763fc0>] netdev_start_xmit include/linux/netdevice.h:4925 [inline]
> [<ffffffff84763fc0>] xmit_one net/core/dev.c:3644 [inline]
> [<ffffffff84763fc0>] dev_hard_start_xmit+0x320/0x980 net/core/dev.c:3660
> [<ffffffff8494c650>] sch_direct_xmit+0x2a0/0x9c0 net/sched/sch_generic.c:342
> [<ffffffff8494d883>] qdisc_restart net/sched/sch_generic.c:407 [inline]
> [<ffffffff8494d883>] __qdisc_run+0xb13/0x1e70 net/sched/sch_generic.c:415
> [<ffffffff8478c426>] qdisc_run+0xd6/0x260 include/net/pkt_sched.h:125
> [<ffffffff84796eac>] net_tx_action+0x7ac/0x940 net/core/dev.c:5247
> [<ffffffff858002bd>] __do_softirq+0x2bd/0x9bd kernel/softirq.c:599
> [<ffffffff814c3fe8>] invoke_softirq kernel/softirq.c:430 [inline]
> [<ffffffff814c3fe8>] __irq_exit_rcu+0xc8/0x170 kernel/softirq.c:683
> [<ffffffff814c3f09>] irq_exit_rcu+0x9/0x20 kernel/softirq.c:695
> 
> [...]

Here is the summary with links:
  - [v2,net] net: read sk->sk_family once in sk_mc_loop()
    https://git.kernel.org/netdev/net/c/a3e0fdf71bbe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



