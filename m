Return-Path: <netdev+bounces-182515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCD6A88FD4
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 00:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A38D77A63DE
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 22:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611351F4CB3;
	Mon, 14 Apr 2025 22:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYnJ83Zm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFD81F4CAA
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 22:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744671415; cv=none; b=isdiMeTWJd5NydY3eFdoQzIPFanGz6+wsMesgtYUme5gDAGr7dfCVdsFP0VZLJIsgaWRJIE0vJp4EoFHzQ5dH0wqRcCldXtBzZqKpSqtd+fJh2NyVCHKafAm4m4G3varaTFlRRLRbwp+EvpEUfUB7Ufq7tgYn5veMUWKZA4eMjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744671415; c=relaxed/simple;
	bh=d1YU5YOeQYhmD8iQGbncmfhHm3QiozhY/Evkgsl//Ks=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eN+VKE0s4WtRg+NBG0uuMdcjHlAt6LEgT4vbzjZGMBcKrXzym2KPcKKaqswg7FX//Dos1EKIyrZ/6amxGBOgjVJ8n/2KxJb0MZiqA1zBvOaPADbpwRZj1aA1/bfb8Odxgmi2gY3lWGMfATtp1eyiCSi0/aDXVrBp70ACycAMy1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYnJ83Zm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F413C4CEEC;
	Mon, 14 Apr 2025 22:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744671414;
	bh=d1YU5YOeQYhmD8iQGbncmfhHm3QiozhY/Evkgsl//Ks=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PYnJ83ZmryPm6TV6IdyHJly5aljpau1NLDs8xJ4Xis67sxTq+dXorg9cq9nd9oSq8
	 G0BYVN6nISHAi0aHaHM3z1137dawovgBypZgzZJp8sOG899is+n2+fREY+c5WjUzCp
	 wAMNkSz9czXjw8YpnWtGDQklObeOV37113EvKBVKQbtXSDK1p89TlofKuMsWMBm+Rj
	 AZi0KNIF4E18ZYma9LNx6zm9VgvUZJ3ZAFtbeThcoTbsIXsN73+8NBo+enSa2jgFJi
	 fiH41rsG8bAK3i2Bj6vVaqGlp6RFrInqzM3BhSa2RRTe54i3OySHIOocDBmGlyN3dp
	 Sxx7tgOPZ2LVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC403822D1A;
	Mon, 14 Apr 2025 22:57:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] udp: properly deal with xfrm encap and ADDRFORM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174467145250.2060374.6049073566725838823.git-patchwork-notify@kernel.org>
Date: Mon, 14 Apr 2025 22:57:32 +0000
References: <92bcdb6899145a9a387c8fa9e3ca656642a43634.1744228733.git.pabeni@redhat.com>
In-Reply-To: <92bcdb6899145a9a387c8fa9e3ca656642a43634.1744228733.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, willemdebruijn.kernel@gmail.com,
 dsahern@kernel.org, eyal.birger@gmail.com, steffen.klassert@secunet.com,
 antony.antony@secunet.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Apr 2025 22:00:56 +0200 you wrote:
> UDP GRO accounting assumes that the GRO receive callback is always
> set when the UDP tunnel is enabled, but syzkaller proved otherwise,
> leading tot the following splat:
> 
> WARNING: CPU: 0 PID: 5837 at net/ipv4/udp_offload.c:123 udp_tunnel_update_gro_rcv+0x28d/0x4c0 net/ipv4/udp_offload.c:123
> Modules linked in:
> CPU: 0 UID: 0 PID: 5837 Comm: syz-executor850 Not tainted 6.14.0-syzkaller-13320-g420aabef3ab5 #0 PREEMPT(full)
> Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> RIP: 0010:udp_tunnel_update_gro_rcv+0x28d/0x4c0 net/ipv4/udp_offload.c:123
> Code: 00 00 e8 c6 5a 2f f7 48 c1 e5 04 48 8d b5 20 53 c7 9a ba 10
>       00 00 00 4c 89 ff e8 ce 87 99 f7 e9 ce 00 00 00 e8 a4 5a 2f
>       f7 90 <0f> 0b 90 e9 de fd ff ff bf 01 00 00 00 89 ee e8 cf
>       5e 2f f7 85 ed
> RSP: 0018:ffffc90003effa88 EFLAGS: 00010293
> RAX: ffffffff8a93fc9c RBX: 0000000000000000 RCX: ffff8880306f9e00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffffffff8a93fabe R09: 1ffffffff20bfb2e
> R10: dffffc0000000000 R11: fffffbfff20bfb2f R12: ffff88814ef21738
> R13: dffffc0000000000 R14: ffff88814ef21778 R15: 1ffff11029de42ef
> FS:  0000000000000000(0000) GS:ffff888124f96000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f04eec760d0 CR3: 000000000eb38000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  udp_tunnel_cleanup_gro include/net/udp_tunnel.h:205 [inline]
>  udpv6_destroy_sock+0x212/0x270 net/ipv6/udp.c:1829
>  sk_common_release+0x71/0x2e0 net/core/sock.c:3896
>  inet_release+0x17d/0x200 net/ipv4/af_inet.c:435
>  __sock_release net/socket.c:647 [inline]
>  sock_close+0xbc/0x240 net/socket.c:1391
>  __fput+0x3e9/0x9f0 fs/file_table.c:465
>  task_work_run+0x251/0x310 kernel/task_work.c:227
>  exit_task_work include/linux/task_work.h:40 [inline]
>  do_exit+0xa11/0x27f0 kernel/exit.c:953
>  do_group_exit+0x207/0x2c0 kernel/exit.c:1102
>  __do_sys_exit_group kernel/exit.c:1113 [inline]
>  __se_sys_exit_group kernel/exit.c:1111 [inline]
>  __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1111
>  x64_sys_call+0x26c3/0x26d0 arch/x86/include/generated/asm/syscalls_64.h:232
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f04eebfac79
> Code: Unable to access opcode bytes at 0x7f04eebfac4f.
> RSP: 002b:00007fffdcaa34a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f04eebfac79
> RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
> RBP: 00007f04eec75270 R08: ffffffffffffffb8 R09: 00007fffdcaa36c8
> R10: 0000200000000000 R11: 0000000000000246 R12: 00007f04eec75270
> R13: 0000000000000000 R14: 00007f04eec75cc0 R15: 00007f04eebcca70
> 
> [...]

Here is the summary with links:
  - [net-next] udp: properly deal with xfrm encap and ADDRFORM
    https://git.kernel.org/netdev/net-next/c/c26c192c3d48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



