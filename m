Return-Path: <netdev+bounces-205622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A642EAFF6D0
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 04:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83AB75843BB
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 02:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CCB27FD60;
	Thu, 10 Jul 2025 02:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fu43janj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA9A27FD5A;
	Thu, 10 Jul 2025 02:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752114593; cv=none; b=SSweqDEnkgPmH1kW82uPSowc0aHfIHUOOWcvnwbRkmx4yLs+xcJMVHPozAT70U/obprqR7EbEH2AoLYSWgqjGDa/Bqfr4CpXtfyrY+RnSTij2qP4kEXZ8pKyXKKIEem441Y6kyAmZJ4TvC7EUyvHery2n52sPEH1xjDJBb0uDqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752114593; c=relaxed/simple;
	bh=W+jNyvbBpkLSHr7+KejosbO0puWnwiOgglOKmIE9e90=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T3DQiCh17sMplrBQG/BbDVKnnnIEsRvDmRwFcf4vNZ7BdsAXKILQnGAHtYDxT8U7oSpzL/5FG3Pus5LpRfvmVjEmnB2d/dS1C4KP96LdZCfSZUrEATACX/n7lTT8DvhbvLpzgEN/4zFIghepxrwf+8+FAUJyPM3l/s4q01wQnv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fu43janj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5938C4CEF5;
	Thu, 10 Jul 2025 02:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752114592;
	bh=W+jNyvbBpkLSHr7+KejosbO0puWnwiOgglOKmIE9e90=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fu43janjlwVpP/NVEj3WjaAO/NMdouW+YKIZzSg1v3MQC0yP6uMmTo7ZL4EX5y6qU
	 Bf4xyWOxF5o/JJ5DD9vjCJfxQ45cPaQeDllv/y+9o0eneW7T/OX4gBWkq+9S7H5LD6
	 EHIXISkQeXyEGLcWunVI3OzqGjzx/xh9PWed5V8kkWqPTPFOM270lH6t19YpiS/+uI
	 HfhJxzrmUmZxMcP0M4edOm1N1YLAYLSOStZGdG1lKX6sfFYYCxX7g0I5LRPtk2AxrC
	 8IZj6QWIY9Yp+iPzXuYfaL3vL1ZOSFRPwdN9HfteGXtKz3rMBQ737QHXiucVeCdrhW
	 FJ99DwusdYW+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F75383B261;
	Thu, 10 Jul 2025 02:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] atm: clip: Fix NULL pointer dereference in
 vcc_sendmsg()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175211461500.963219.1846450385340315182.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 02:30:15 +0000
References: <20250705085228.329202-1-yuehaibing@huawei.com>
In-Reply-To: <20250705085228.329202-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 5 Jul 2025 16:52:28 +0800 you wrote:
> atmarpd_dev_ops does not implement the send method, which may cause crash
> as bellow.
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> PGD 0 P4D 0
> Oops: Oops: 0010 [#1] SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 5324 Comm: syz.0.0 Not tainted 6.15.0-rc6-syzkaller-00346-g5723cc3450bc #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:0x0
> Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> RSP: 0018:ffffc9000d3cf778 EFLAGS: 00010246
> RAX: 1ffffffff1910dd1 RBX: 00000000000000c0 RCX: dffffc0000000000
> RDX: ffffc9000dc82000 RSI: ffff88803e4c4640 RDI: ffff888052cd0000
> RBP: ffffc9000d3cf8d0 R08: ffff888052c9143f R09: 1ffff1100a592287
> R10: dffffc0000000000 R11: 0000000000000000 R12: 1ffff92001a79f00
> R13: ffff888052cd0000 R14: ffff88803e4c4640 R15: ffffffff8c886e88
> FS:  00007fbc762566c0(0000) GS:ffff88808d6c2000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffd6 CR3: 0000000041f1b000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  vcc_sendmsg+0xa10/0xc50 net/atm/common.c:644
>  sock_sendmsg_nosec net/socket.c:712 [inline]
>  __sock_sendmsg+0x219/0x270 net/socket.c:727
>  ____sys_sendmsg+0x52d/0x830 net/socket.c:2566
>  ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
>  __sys_sendmmsg+0x227/0x430 net/socket.c:2709
>  __do_sys_sendmmsg net/socket.c:2736 [inline]
>  __se_sys_sendmmsg net/socket.c:2733 [inline]
>  __x64_sys_sendmmsg+0xa0/0xc0 net/socket.c:2733
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [v2,net] atm: clip: Fix NULL pointer dereference in vcc_sendmsg()
    https://git.kernel.org/netdev/net/c/22fc46cea91d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



