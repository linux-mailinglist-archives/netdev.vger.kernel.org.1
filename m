Return-Path: <netdev+bounces-94761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8158C8C097F
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 04:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2C001C208F4
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 02:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC42D13C830;
	Thu,  9 May 2024 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZKfLCoh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987D018AF9
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715220029; cv=none; b=UUPX7/gyx8cKXo/uQT2WO6oYbnonE+vs1dFogiEZY8SBs9KmcZLvmNQHDCxUkYdigOwe+mU0WrLg/qfs3gD7Iv/r0DXcHfnsqlw6ycfeTbytM69KiYVsLB+dbtZ47iCQhFILLVEuLvwf4+J27wuZ0ZMtetMIcYt4CE91o9dkbj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715220029; c=relaxed/simple;
	bh=2ZENESsI9jN8bUXeInu5Y75a2Mb7RoBQIPmqH9BMIco=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OvD7nglbzEtWMTx8YZAi1cLNNIl+9QGjYdPp2bqnsryzVFzf6RzHrX7nuFcidnM0uNnH6Bso9HpmKlIQbJ185+qEoMF9Jw0Ak0kExdgrzJU4oJxV6TKGusFiPQgTFRIfUyi4AvbRCy8/M4H3fPxE/xuWMcdqi511W2ItfmngcyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZKfLCoh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26F84C2BD11;
	Thu,  9 May 2024 02:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715220029;
	bh=2ZENESsI9jN8bUXeInu5Y75a2Mb7RoBQIPmqH9BMIco=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uZKfLCohP+ovcaPpyGq6zFJiEPPJgzvYlw3mG952lDdqos8keVYxvuF4eRiLycqZN
	 NinXKv6JE+sjUboUTAbpydn3T7tlFsBVNaF8hP2i8ObANZHfI2mS+ul5TKybRLYndX
	 VP0kjAQj+W8C14of3YfPTn1vIt2IUyd+dLWoTYLJl0TQUcaCSaWq2NnEE7YyEOrfv2
	 Bw84G/zMK1PNUSi6HNiaA42cYgz/aWnLh6AwGRiwbhYE1sliUG0c7TxDxExQtY31oX
	 Jjww3NbAsyDMdyD5SugywDD3EBinD0r2NM12ybebr3aR9o4DYy7BJSPR8AcwGpGUXC
	 kQnx5sJY83CKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0DCA1C43332;
	Thu,  9 May 2024 02:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: prevent NULL dereference in ip6_output()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171522002905.32544.6489121154288744069.git-patchwork-notify@kernel.org>
Date: Thu, 09 May 2024 02:00:29 +0000
References: <20240507161842.773961-1-edumazet@google.com>
In-Reply-To: <20240507161842.773961-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 May 2024 16:18:42 +0000 you wrote:
> According to syzbot, there is a chance that ip6_dst_idev()
> returns NULL in ip6_output(). Most places in IPv6 stack
> deal with a NULL idev just fine, but not here.
> 
> syzbot reported:
> 
> general protection fault, probably for non-canonical address 0xdffffc00000000bc: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x00000000000005e0-0x00000000000005e7]
> CPU: 0 PID: 9775 Comm: syz-executor.4 Not tainted 6.9.0-rc5-syzkaller-00157-g6a30653b604a #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
>  RIP: 0010:ip6_output+0x231/0x3f0 net/ipv6/ip6_output.c:237
> Code: 3c 1e 00 49 89 df 74 08 4c 89 ef e8 19 58 db f7 48 8b 44 24 20 49 89 45 00 49 89 c5 48 8d 9d e0 05 00 00 48 89 d8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 4c 8b 74 24 28 0f 85 61 01 00 00 8b 1b 31 ff
> RSP: 0018:ffffc9000927f0d8 EFLAGS: 00010202
> RAX: 00000000000000bc RBX: 00000000000005e0 RCX: 0000000000040000
> RDX: ffffc900131f9000 RSI: 0000000000004f47 RDI: 0000000000004f48
> RBP: 0000000000000000 R08: ffffffff8a1f0b9a R09: 1ffffffff1f51fad
> R10: dffffc0000000000 R11: fffffbfff1f51fae R12: ffff8880293ec8c0
> R13: ffff88805d7fc000 R14: 1ffff1100527d91a R15: dffffc0000000000
> FS:  00007f135c6856c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000080 CR3: 0000000064096000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>   NF_HOOK include/linux/netfilter.h:314 [inline]
>   ip6_xmit+0xefe/0x17f0 net/ipv6/ip6_output.c:358
>   sctp_v6_xmit+0x9f2/0x13f0 net/sctp/ipv6.c:248
>   sctp_packet_transmit+0x26ad/0x2ca0 net/sctp/output.c:653
>   sctp_packet_singleton+0x22c/0x320 net/sctp/outqueue.c:783
>   sctp_outq_flush_ctrl net/sctp/outqueue.c:914 [inline]
>   sctp_outq_flush+0x6d5/0x3e20 net/sctp/outqueue.c:1212
>   sctp_side_effects net/sctp/sm_sideeffect.c:1198 [inline]
>   sctp_do_sm+0x59cc/0x60c0 net/sctp/sm_sideeffect.c:1169
>   sctp_primitive_ASSOCIATE+0x95/0xc0 net/sctp/primitive.c:73
>   __sctp_connect+0x9cd/0xe30 net/sctp/socket.c:1234
>   sctp_connect net/sctp/socket.c:4819 [inline]
>   sctp_inet_connect+0x149/0x1f0 net/sctp/socket.c:4834
>   __sys_connect_file net/socket.c:2048 [inline]
>   __sys_connect+0x2df/0x310 net/socket.c:2065
>   __do_sys_connect net/socket.c:2075 [inline]
>   __se_sys_connect net/socket.c:2072 [inline]
>   __x64_sys_connect+0x7a/0x90 net/socket.c:2072
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [net] ipv6: prevent NULL dereference in ip6_output()
    https://git.kernel.org/netdev/net/c/4db783d68b9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



