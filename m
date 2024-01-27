Return-Path: <netdev+bounces-66376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9C383EB43
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 06:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091881C21D81
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 05:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35706134C3;
	Sat, 27 Jan 2024 05:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9YmqWr4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1223FD2F7
	for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 05:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706332825; cv=none; b=AZDmh0ZUcFXa+ZV0wEr8/8dWC+azlAv9O3D0Rr4rX/FugFDlqK/lNjBlNfpwENIS97cu5NvEAHwCpSkgESQkMIT0ffAC1QzVKMWxp5zGfBWpGD22fvynv+OZTFjTyktAEP027dvPXkoQM0KTb19QlrcHd2zKCtfFlCzYG/2VwTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706332825; c=relaxed/simple;
	bh=OTsx7pwBOcZoBTiYDdNUBLrgCYA+Gz59gE20o9GrmtE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sI8HBmdAwjhRFwvg8Pe/C+7H4zwiOOZlYQ+Hp5XnDWCR+LrpJXjKIyk4VQNTbepVK0F7nS92z/rkOUZY1kZ3yJhreGcR62uGM+PFZSOt1rLjmnrlOBWvciRWmkrZ3vUhxCG/swbtHAuR2Cng7g7ZA/7t0ZJEitE/xTyhsrzEQ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9YmqWr4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7294CC43390;
	Sat, 27 Jan 2024 05:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706332824;
	bh=OTsx7pwBOcZoBTiYDdNUBLrgCYA+Gz59gE20o9GrmtE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C9YmqWr4HmYH3n6NUJfqIWT9Hf3B3psyPXH2xpPkVdBrcgQMAgJql0/QrL5R4iyiw
	 33W0Xyuj0X3ukahydEPNT+iwyOLXLZuvgYK8ZzZIiOuVF8E9xvmRQuI6ycigVc1MI7
	 ZtNgbQOMtdhR9bdZukWcQv8vyIfYx3k770/YZO39t7Ad3nDaRW/2RY6CouYXmO53XN
	 ic4K8Fb4Lkt+V5uMVS3MYn2sbdt5AjYJQlNu1vgG920IsE9Kxq+S5bzsd4BgejYvpC
	 6+bGEAjwsc1p/TvdXui7PJ205npEwx8H8Nj0uc+amavv5X0HpYbdIE7VAbBmQIvS45
	 oWq1GY9gLrqtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5AB4FD8C962;
	Sat, 27 Jan 2024 05:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipmr: fix kernel panic when forwarding mcast packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170633282436.26577.2518397723028445430.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jan 2024 05:20:24 +0000
References: <20240125141847.1931933-1-nicolas.dichtel@6wind.com>
In-Reply-To: <20240125141847.1931933-1-nicolas.dichtel@6wind.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, leone4fernando@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Jan 2024 15:18:47 +0100 you wrote:
> The stacktrace was:
> [   86.305548] BUG: kernel NULL pointer dereference, address: 0000000000000092
> [   86.306815] #PF: supervisor read access in kernel mode
> [   86.307717] #PF: error_code(0x0000) - not-present page
> [   86.308624] PGD 0 P4D 0
> [   86.309091] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   86.309883] CPU: 2 PID: 3139 Comm: pimd Tainted: G     U             6.8.0-6wind-knet #1
> [   86.311027] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.1-0-g0551a4be2c-prebuilt.qemu-project.org 04/01/2014
> [   86.312728] RIP: 0010:ip_mr_forward (/build/work/knet/net/ipv4/ipmr.c:1985)
> [ 86.313399] Code: f9 1f 0f 87 85 03 00 00 48 8d 04 5b 48 8d 04 83 49 8d 44 c5 00 48 8b 40 70 48 39 c2 0f 84 d9 00 00 00 49 8b 46 58 48 83 e0 fe <80> b8 92 00 00 00 00 0f 84 55 ff ff ff 49 83 47 38 01 45 85 e4 0f
> [   86.316565] RSP: 0018:ffffad21c0583ae0 EFLAGS: 00010246
> [   86.317497] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [   86.318596] RDX: ffff9559cb46c000 RSI: 0000000000000000 RDI: 0000000000000000
> [   86.319627] RBP: ffffad21c0583b30 R08: 0000000000000000 R09: 0000000000000000
> [   86.320650] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
> [   86.321672] R13: ffff9559c093a000 R14: ffff9559cc00b800 R15: ffff9559c09c1d80
> [   86.322873] FS:  00007f85db661980(0000) GS:ffff955a79d00000(0000) knlGS:0000000000000000
> [   86.324291] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   86.325314] CR2: 0000000000000092 CR3: 000000002f13a000 CR4: 0000000000350ef0
> [   86.326589] Call Trace:
> [   86.327036]  <TASK>
> [   86.327434] ? show_regs (/build/work/knet/arch/x86/kernel/dumpstack.c:479)
> [   86.328049] ? __die (/build/work/knet/arch/x86/kernel/dumpstack.c:421 /build/work/knet/arch/x86/kernel/dumpstack.c:434)
> [   86.328508] ? page_fault_oops (/build/work/knet/arch/x86/mm/fault.c:707)
> [   86.329107] ? do_user_addr_fault (/build/work/knet/arch/x86/mm/fault.c:1264)
> [   86.329756] ? srso_return_thunk (/build/work/knet/arch/x86/lib/retpoline.S:223)
> [   86.330350] ? __irq_work_queue_local (/build/work/knet/kernel/irq_work.c:111 (discriminator 1))
> [   86.331013] ? exc_page_fault (/build/work/knet/./arch/x86/include/asm/paravirt.h:693 /build/work/knet/arch/x86/mm/fault.c:1515 /build/work/knet/arch/x86/mm/fault.c:1563)
> [   86.331702] ? asm_exc_page_fault (/build/work/knet/./arch/x86/include/asm/idtentry.h:570)
> [   86.332468] ? ip_mr_forward (/build/work/knet/net/ipv4/ipmr.c:1985)
> [   86.333183] ? srso_return_thunk (/build/work/knet/arch/x86/lib/retpoline.S:223)
> [   86.333920] ipmr_mfc_add (/build/work/knet/./include/linux/rcupdate.h:782 /build/work/knet/net/ipv4/ipmr.c:1009 /build/work/knet/net/ipv4/ipmr.c:1273)
> [   86.334583] ? __pfx_ipmr_hash_cmp (/build/work/knet/net/ipv4/ipmr.c:363)
> [   86.335357] ip_mroute_setsockopt (/build/work/knet/net/ipv4/ipmr.c:1470)
> [   86.336135] ? srso_return_thunk (/build/work/knet/arch/x86/lib/retpoline.S:223)
> [   86.336854] ? ip_mroute_setsockopt (/build/work/knet/net/ipv4/ipmr.c:1470)
> [   86.337679] do_ip_setsockopt (/build/work/knet/net/ipv4/ip_sockglue.c:944)
> [   86.338408] ? __pfx_unix_stream_read_actor (/build/work/knet/net/unix/af_unix.c:2862)
> [   86.339232] ? srso_return_thunk (/build/work/knet/arch/x86/lib/retpoline.S:223)
> [   86.339809] ? aa_sk_perm (/build/work/knet/security/apparmor/include/cred.h:153 /build/work/knet/security/apparmor/net.c:181)
> [   86.340342] ip_setsockopt (/build/work/knet/net/ipv4/ip_sockglue.c:1415)
> [   86.340859] raw_setsockopt (/build/work/knet/net/ipv4/raw.c:836)
> [   86.341408] ? security_socket_setsockopt (/build/work/knet/security/security.c:4561 (discriminator 13))
> [   86.342116] sock_common_setsockopt (/build/work/knet/net/core/sock.c:3716)
> [   86.342747] do_sock_setsockopt (/build/work/knet/net/socket.c:2313)
> [   86.343363] __sys_setsockopt (/build/work/knet/./include/linux/file.h:32 /build/work/knet/net/socket.c:2336)
> [   86.344020] __x64_sys_setsockopt (/build/work/knet/net/socket.c:2340)
> [   86.344766] do_syscall_64 (/build/work/knet/arch/x86/entry/common.c:52 /build/work/knet/arch/x86/entry/common.c:83)
> [   86.345433] ? srso_return_thunk (/build/work/knet/arch/x86/lib/retpoline.S:223)
> [   86.346161] ? syscall_exit_work (/build/work/knet/./include/linux/audit.h:357 /build/work/knet/kernel/entry/common.c:160)
> [   86.346938] ? srso_return_thunk (/build/work/knet/arch/x86/lib/retpoline.S:223)
> [   86.347657] ? syscall_exit_to_user_mode (/build/work/knet/kernel/entry/common.c:215)
> [   86.348538] ? srso_return_thunk (/build/work/knet/arch/x86/lib/retpoline.S:223)
> [   86.349262] ? do_syscall_64 (/build/work/knet/./arch/x86/include/asm/cpufeature.h:171 /build/work/knet/arch/x86/entry/common.c:98)
> [   86.349971] entry_SYSCALL_64_after_hwframe (/build/work/knet/arch/x86/entry/entry_64.S:129)
> 
> [...]

Here is the summary with links:
  - [net,v2] ipmr: fix kernel panic when forwarding mcast packets
    https://git.kernel.org/netdev/net/c/e622502c310f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



