Return-Path: <netdev+bounces-94332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAA28BF333
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9E61F21822
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 00:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A149E137753;
	Tue,  7 May 2024 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9M2eSQY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0CA137741
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 23:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715125832; cv=none; b=WAeol29hfHikaUeGAhtnxFea3yrzsNDEmx8sizOmJLIZ4jb1fBwzNPqcDPaPj0otqSsDpx46rEtXc+h/TfVJsQ5UkDPDntSkdBhmSiQ5sh3AXlK2Aa6jyy3YeivFQSd+Cta36NID3CUuhtcbj3+TtYQo2JVNCgCziZvelDHjpFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715125832; c=relaxed/simple;
	bh=BJJYziuhAn/J82DXvQBzETW9HfCLH31Odna+yGvXLqc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j6FyfvmJ7ahZYZk1/3AhP4PYomwl9Zx1aV0+YjM4Uq7CRaWLp+AVBx5SXssH8/HsoyZgzbhtm3ndp0ukgcnVCYnfSszh1sKeqDQVg7s3HFH0yJNwoqGrVD4s4h15IC02k/+WuCXcA1O+kIokXwh5fGAX2AGPxoFvYisP+MgNfdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9M2eSQY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03292C4AF63;
	Tue,  7 May 2024 23:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715125831;
	bh=BJJYziuhAn/J82DXvQBzETW9HfCLH31Odna+yGvXLqc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H9M2eSQY/uc6e7IdOs2x/lpN2MQV0Pt6yyi/cZT7TMAGX/QEtWTuc2V2NmUTk4AlF
	 4AC6T5aZ910s3XJjJPpqUa0aI8CutSZLnJhqIu3Dw6BDW1KGIXkUssEsDxO5h9nGly
	 A4Rbqi0gTcHQ4uOrIlXZoklJwWQcAaBL4XzDXT6TvykUHA4ODsISTosN/qca8hCLp9
	 WbwwVze4P29txecADEQJ5V3/SCc1qBuhOu9pBkUvyTU5jdzGvVEsBEL1xCbOOJhwoW
	 ZTPolij4ACahCYWTAAKdw8ao44WYw/MMuyqeF/anFR7asjPTV9VWvKaZG6EEFXQ8tJ
	 tmRyp1DKd9GCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5CD8C43617;
	Tue,  7 May 2024 23:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mptcp: fix possible NULL dereferences
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171512583093.28510.18027099275001414372.git-patchwork-notify@kernel.org>
Date: Tue, 07 May 2024 23:50:30 +0000
References: <20240506123032.3351895-1-edumazet@google.com>
In-Reply-To: <20240506123032.3351895-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 kernelxing@tencent.com, matttbe@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  6 May 2024 12:30:32 +0000 you wrote:
> subflow_add_reset_reason(skb, ...) can fail.
> 
> We can not assume mptcp_get_ext(skb) always return a non NULL pointer.
> 
> syzbot reported:
> 
> general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
> CPU: 0 PID: 5098 Comm: syz-executor132 Not tainted 6.9.0-rc6-syzkaller-01478-gcdc74c9d06e7 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
>  RIP: 0010:subflow_v6_route_req+0x2c7/0x490 net/mptcp/subflow.c:388
> Code: 8d 7b 07 48 89 f8 48 c1 e8 03 42 0f b6 04 20 84 c0 0f 85 c0 01 00 00 0f b6 43 07 48 8d 1c c3 48 83 c3 18 48 89 d8 48 c1 e8 03 <42> 0f b6 04 20 84 c0 0f 85 84 01 00 00 0f b6 5b 01 83 e3 0f 48 89
> RSP: 0018:ffffc9000362eb68 EFLAGS: 00010206
> RAX: 0000000000000003 RBX: 0000000000000018 RCX: ffff888022039e00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffff88807d961140 R08: ffffffff8b6cb76b R09: 1ffff1100fb2c230
> R10: dffffc0000000000 R11: ffffed100fb2c231 R12: dffffc0000000000
> R13: ffff888022bfe273 R14: ffff88802cf9cc80 R15: ffff88802ad5a700
> FS:  0000555587ad2380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f420c3f9720 CR3: 0000000022bfc000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>   tcp_conn_request+0xf07/0x32c0 net/ipv4/tcp_input.c:7180
>   tcp_rcv_state_process+0x183c/0x4500 net/ipv4/tcp_input.c:6663
>   tcp_v6_do_rcv+0x8b2/0x1310 net/ipv6/tcp_ipv6.c:1673
>   tcp_v6_rcv+0x22b4/0x30b0 net/ipv6/tcp_ipv6.c:1910
>   ip6_protocol_deliver_rcu+0xc76/0x1570 net/ipv6/ip6_input.c:438
>   ip6_input_finish+0x186/0x2d0 net/ipv6/ip6_input.c:483
>   NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
>   NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
>   __netif_receive_skb_one_core net/core/dev.c:5625 [inline]
>   __netif_receive_skb+0x1ea/0x650 net/core/dev.c:5739
>   netif_receive_skb_internal net/core/dev.c:5825 [inline]
>   netif_receive_skb+0x1e8/0x890 net/core/dev.c:5885
>   tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1549
>   tun_get_user+0x2f35/0x4560 drivers/net/tun.c:2002
>   tun_chr_write_iter+0x113/0x1f0 drivers/net/tun.c:2048
>   call_write_iter include/linux/fs.h:2110 [inline]
>   new_sync_write fs/read_write.c:497 [inline]
>   vfs_write+0xa84/0xcb0 fs/read_write.c:590
>   ksys_write+0x1a0/0x2c0 fs/read_write.c:643
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [net-next] mptcp: fix possible NULL dereferences
    https://git.kernel.org/netdev/net-next/c/445c0b69c729

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



