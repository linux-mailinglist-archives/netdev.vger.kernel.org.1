Return-Path: <netdev+bounces-52819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A347C8004BB
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 08:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46539B20D32
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 07:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B063B14F88;
	Fri,  1 Dec 2023 07:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXv5zu/h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F9211CB6
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 07:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7A3EC433CA;
	Fri,  1 Dec 2023 07:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701415825;
	bh=yTcIqr9ehwlJPMVQjBS0sZq8Hz0Ei3b66h2URP98HvQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BXv5zu/hhph7svvvn5g3Vnr0K6B6kiMwN4C1TDivE8OQ8cnCZ7mXlDRpDJrE/+Icy
	 CZHG9koG/egGJ2l5nN0eeKOuQ85DnKSwK3rWEpmeuJETWrm2fQEePDOtOFBJDVgGKd
	 yqR1FrLhpZ1I2qF91kwE9Or+mkovY1uk2sUQHAdqhPfyplWm1dSQQycsnG/K3ut+lq
	 CnMAlh6kuzoP5gF4uHWWE6AUqUKVSXdgrOyGv7bAScH/TRSLSWbKG5lJO+qn9Uuf2K
	 YOwv/OWPS8DpwG/yWjWKsBB0cqatZjhkzFU6f50XJ4u6y+zX1DIp+4lNSUlIdV/98I
	 SrkH+4QDPpgbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CDC12C4166E;
	Fri,  1 Dec 2023 07:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: fix potential NULL deref in fib6_add()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170141582483.8625.5436836417602290432.git-patchwork-notify@kernel.org>
Date: Fri, 01 Dec 2023 07:30:24 +0000
References: <20231129160630.3509216-1-edumazet@google.com>
In-Reply-To: <20231129160630.3509216-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 weiwan@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Nov 2023 16:06:30 +0000 you wrote:
> If fib6_find_prefix() returns NULL, we should silently fallback
> using fib6_null_entry regardless of RT6_DEBUG value.
> 
> syzbot reported:
> 
> WARNING: CPU: 0 PID: 5477 at net/ipv6/ip6_fib.c:1516 fib6_add+0x310d/0x3fa0 net/ipv6/ip6_fib.c:1516
> Modules linked in:
> CPU: 0 PID: 5477 Comm: syz-executor.0 Not tainted 6.7.0-rc2-syzkaller-00029-g9b6de136b5f0 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
> RIP: 0010:fib6_add+0x310d/0x3fa0 net/ipv6/ip6_fib.c:1516
> Code: 00 48 8b 54 24 68 e8 42 22 00 00 48 85 c0 74 14 49 89 c6 e8 d5 d3 c2 f7 eb 5d e8 ce d3 c2 f7 e9 ca 00 00 00 e8 c4 d3 c2 f7 90 <0f> 0b 90 48 b8 00 00 00 00 00 fc ff df 48 8b 4c 24 38 80 3c 01 00
> RSP: 0018:ffffc90005067740 EFLAGS: 00010293
> RAX: ffffffff89cba5bc RBX: ffffc90005067ab0 RCX: ffff88801a2e9dc0
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: ffffc90005067980 R08: ffffffff89cbca85 R09: 1ffff110040d4b85
> R10: dffffc0000000000 R11: ffffed10040d4b86 R12: 00000000ffffffff
> R13: 1ffff110051c3904 R14: ffff8880206a5c00 R15: ffff888028e1c820
> FS: 00007f763783c6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f763783bff8 CR3: 000000007f74d000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> <TASK>
> __ip6_ins_rt net/ipv6/route.c:1303 [inline]
> ip6_route_add+0x88/0x120 net/ipv6/route.c:3847
> ipv6_route_ioctl+0x525/0x7b0 net/ipv6/route.c:4467
> inet6_ioctl+0x21a/0x270 net/ipv6/af_inet6.c:575
> sock_do_ioctl+0x152/0x460 net/socket.c:1220
> sock_ioctl+0x615/0x8c0 net/socket.c:1339
> vfs_ioctl fs/ioctl.c:51 [inline]
> __do_sys_ioctl fs/ioctl.c:871 [inline]
> __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
> do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> do_syscall_64+0x45/0x110 arch/x86/entry/common.c:82
> 
> [...]

Here is the summary with links:
  - [net] ipv6: fix potential NULL deref in fib6_add()
    https://git.kernel.org/netdev/net/c/75475bb51e78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



