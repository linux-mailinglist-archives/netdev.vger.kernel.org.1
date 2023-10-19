Return-Path: <netdev+bounces-42581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EC77CF689
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 13:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C367F1C20967
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 11:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8483919442;
	Thu, 19 Oct 2023 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvV08DUq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BA9D26D
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 11:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2E3BC433C9;
	Thu, 19 Oct 2023 11:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697714422;
	bh=KGVXQpptsORSzt2J+GhNqfgHIABmGoJXx15SY3a94Fg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mvV08DUqfmIXfLhAkqe2+CuvUGXLknf/5zXhn2C1aD7nxhqaGeMXOrYAAI1vnBeTo
	 fj1sLmOvA/C/lHzT1dljjIsy21S6B8xgBxTKrcFTR8YNeGzn/htmjwSPqM92cmamBX
	 fEhMwnFe3b/R2pzkUUXcQRQXgOv02TKRPgG65Q/OfDQ/gmIl4aXlZi/lrJjZS012iB
	 j+uka79k3q4KDrOTclr3S5hw1ylfHQsNquryaDbBq8cPiYsa2EJSO4YsdXVZUYtjDI
	 zk0Z+K2gNoT3eMgAMV/B71vVh/fmhB8dT9vHpLU40EXPmKFbJ0p2WpUTOMSLyC2/iQ
	 gmLz3pxJ+w9SQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A35EC595CE;
	Thu, 19 Oct 2023 11:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] inet: lock the socket in ip_sock_set_tos()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169771442262.1235.10665199696620481402.git-patchwork-notify@kernel.org>
Date: Thu, 19 Oct 2023 11:20:22 +0000
References: <20231018090014.345158-1-edumazet@google.com>
In-Reply-To: <20231018090014.345158-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 cpaasch@apple.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 18 Oct 2023 09:00:13 +0000 you wrote:
> Christoph Paasch reported a panic in TCP stack [1]
> 
> Indeed, we should not call sk_dst_reset() without holding
> the socket lock, as __sk_dst_get() callers do not all rely
> on bare RCU.
> 
> [1]
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> PGD 12bad6067 P4D 12bad6067 PUD 12bad5067 PMD 0
> Oops: 0000 [#1] PREEMPT SMP
> CPU: 1 PID: 2750 Comm: syz-executor.5 Not tainted 6.6.0-rc4-g7a5720a344e7 #49
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
> RIP: 0010:tcp_get_metrics+0x118/0x8f0 net/ipv4/tcp_metrics.c:321
> Code: c7 44 24 70 02 00 8b 03 89 44 24 48 c7 44 24 4c 00 00 00 00 66 c7 44 24 58 02 00 66 ba 02 00 b1 01 89 4c 24 04 4c 89 7c 24 10 <49> 8b 0f 48 8b 89 50 05 00 00 48 89 4c 24 30 33 81 00 02 00 00 69
> RSP: 0018:ffffc90000af79b8 EFLAGS: 00010293
> RAX: 000000000100007f RBX: ffff88812ae8f500 RCX: ffff88812b5f8f01
> RDX: 0000000000000002 RSI: ffffffff8300f080 RDI: 0000000000000002
> RBP: 0000000000000002 R08: 0000000000000003 R09: ffffffff8205eca0
> R10: 0000000000000002 R11: ffff88812b5f8f00 R12: ffff88812a9e0580
> R13: 0000000000000000 R14: ffff88812ae8fbd2 R15: 0000000000000000
> FS: 00007f70a006b640(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 000000012bad7003 CR4: 0000000000170ee0
> Call Trace:
> <TASK>
> tcp_fastopen_cache_get+0x32/0x140 net/ipv4/tcp_metrics.c:567
> tcp_fastopen_cookie_check+0x28/0x180 net/ipv4/tcp_fastopen.c:419
> tcp_connect+0x9c8/0x12a0 net/ipv4/tcp_output.c:3839
> tcp_v4_connect+0x645/0x6e0 net/ipv4/tcp_ipv4.c:323
> __inet_stream_connect+0x120/0x590 net/ipv4/af_inet.c:676
> tcp_sendmsg_fastopen+0x2d6/0x3a0 net/ipv4/tcp.c:1021
> tcp_sendmsg_locked+0x1957/0x1b00 net/ipv4/tcp.c:1073
> tcp_sendmsg+0x30/0x50 net/ipv4/tcp.c:1336
> __sock_sendmsg+0x83/0xd0 net/socket.c:730
> __sys_sendto+0x20a/0x2a0 net/socket.c:2194
> __do_sys_sendto net/socket.c:2206 [inline]
> 
> [...]

Here is the summary with links:
  - [net-next] inet: lock the socket in ip_sock_set_tos()
    https://git.kernel.org/netdev/net-next/c/878d951c6712

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



