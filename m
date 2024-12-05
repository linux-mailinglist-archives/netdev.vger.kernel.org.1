Return-Path: <netdev+bounces-149214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDAA9E4C7D
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 03:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B1818804DD
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 02:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58143176AC8;
	Thu,  5 Dec 2024 02:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfvGjZGT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317D279DC
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 02:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733367018; cv=none; b=BBs576Zzkod54ZvpTuw3RNHD0QR/e3Gw8A30FbqTUpGFFn3qk8LJLmPS629KmMqQhWSIuk4hHxE9NsmUz6IeWapyWio0gdqjqDeatiIuzBP9gOfAhrs/S/1muBHKQrYOkzr/mxn2EHOcs7dgnWK2i6T1fZKOLORZ/vJnYOXt9XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733367018; c=relaxed/simple;
	bh=ZiFybWOm3qa3oVmkde8BspG+RRXOJzF88IwwkTACHVM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FTWHZLw6KlKXYj1znG6euONGUwbQX4DrvYUvEREtpg18zoKUyJl3DzfZjMQDQBhzBVIX/uOPybneUWJwtA38p58kiksctpto7uDqx3AtBnshujNq4QuSyz+zLwyjk8gqrUD7iZc19hOMZfyOgsviP+Ah8VxkGk3K7Q3FUKcP234=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfvGjZGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1C1C4CECD;
	Thu,  5 Dec 2024 02:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733367016;
	bh=ZiFybWOm3qa3oVmkde8BspG+RRXOJzF88IwwkTACHVM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cfvGjZGTQD44ZCJW6bRwI5g6ewWR/u0iPCah52+PpiiysH6H5YtoFI7QLr3Ht9gi0
	 LBuKDlsX0VT7rqT68L49qMESj/JNt95jobrGxfe+V+OmJmqNEhcnHYEl+9gyS2q+rC
	 DWav0xsNuGyvefX1OMijCZjDGNXfacL0JLnkWXrrgsJYOxNB3esaU0Wm7o4EoFtRF5
	 Tgb8GwoARkBOQGNGNj3HpLJbrMcD/1WbLW32KLXQxxd4AIY0jiFcQeAwTYSCqLR5VI
	 2gwoIZitiuKh+Sxw6nuD6ePzPBnhvw3R77D5T60tgskhPhLgda8oHyz/OcNNxQvszC
	 c9NMgLN0YEw/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FD1380A94C;
	Thu,  5 Dec 2024 02:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] ipmr: tune the ipmr_can_free_table() checks.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173336703125.1421182.2149125058772409086.git-patchwork-notify@kernel.org>
Date: Thu, 05 Dec 2024 02:50:31 +0000
References: <8bde975e21bbca9d9c27e36209b2dd4f1d7a3f00.1733212078.git.pabeni@redhat.com>
In-Reply-To: <8bde975e21bbca9d9c27e36209b2dd4f1d7a3f00.1733212078.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, dsahern@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Dec 2024 10:48:15 +0100 you wrote:
> Eric reported a syzkaller-triggered splat caused by recent ipmr changes:
> 
> WARNING: CPU: 2 PID: 6041 at net/ipv6/ip6mr.c:419
> ip6mr_free_table+0xbd/0x120 net/ipv6/ip6mr.c:419
> Modules linked in:
> CPU: 2 UID: 0 PID: 6041 Comm: syz-executor183 Not tainted
> 6.12.0-syzkaller-10681-g65ae975e97d5 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:ip6mr_free_table+0xbd/0x120 net/ipv6/ip6mr.c:419
> Code: 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c
> 02 00 75 58 49 83 bc 24 c0 0e 00 00 00 74 09 e8 44 ef a9 f7 90 <0f> 0b
> 90 e8 3b ef a9 f7 48 8d 7b 38 e8 12 a3 96 f7 48 89 df be 0f
> RSP: 0018:ffffc90004267bd8 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff88803c710000 RCX: ffffffff89e4d844
> RDX: ffff88803c52c880 RSI: ffffffff89e4d87c RDI: ffff88803c578ec0
> RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000001 R12: ffff88803c578000
> R13: ffff88803c710000 R14: ffff88803c710008 R15: dead000000000100
> FS: 00007f7a855ee6c0(0000) GS:ffff88806a800000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f7a85689938 CR3: 000000003c492000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> <TASK>
> ip6mr_rules_exit+0x176/0x2d0 net/ipv6/ip6mr.c:283
> ip6mr_net_exit_batch+0x53/0xa0 net/ipv6/ip6mr.c:1388
> ops_exit_list+0x128/0x180 net/core/net_namespace.c:177
> setup_net+0x4fe/0x860 net/core/net_namespace.c:394
> copy_net_ns+0x2b4/0x6b0 net/core/net_namespace.c:500
> create_new_namespaces+0x3ea/0xad0 kernel/nsproxy.c:110
> unshare_nsproxy_namespaces+0xc0/0x1f0 kernel/nsproxy.c:228
> ksys_unshare+0x45d/0xa40 kernel/fork.c:3334
> __do_sys_unshare kernel/fork.c:3405 [inline]
> __se_sys_unshare kernel/fork.c:3403 [inline]
> __x64_sys_unshare+0x31/0x40 kernel/fork.c:3403
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f7a856332d9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f7a855ee238 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
> RAX: ffffffffffffffda RBX: 00007f7a856bd308 RCX: 00007f7a856332d9
> RDX: 00007f7a8560f8c6 RSI: 0000000000000000 RDI: 0000000062040200
> RBP: 00007f7a856bd300 R08: 00007fff932160a7 R09: 00007f7a855ee6c0
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7a856bd30c
> R13: 0000000000000000 R14: 00007fff93215fc0 R15: 00007fff932160a8
> </TASK>
> 
> [...]

Here is the summary with links:
  - [v3,net] ipmr: tune the ipmr_can_free_table() checks.
    https://git.kernel.org/netdev/net/c/50b94204446e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



