Return-Path: <netdev+bounces-128279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E5F978D18
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 05:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9F6285BC6
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 03:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DB538C;
	Sat, 14 Sep 2024 03:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8kl8yc4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF68F18027
	for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 03:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726284026; cv=none; b=gaMabrSqpn7plE+LhTbhafFEZgJwyqdlAbUCBrqI+l6b+k0dZrC2syt84V75CG0j/h/Okf1osCSl3Y9TF6Ow1gGtynqYD2No/y3fnVmslC9OGd1MIibUwAafi27XKtZWY3yWJBGTqUeiq7yILcFDa7U3ZmnX7/jQbnDZK5WnDsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726284026; c=relaxed/simple;
	bh=z+O7sNBAvvi/n5HlXhm3/8Qgqp35MyrUVjtUnrpdLGk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bjXfUfZQ70Zo2ABybWBCTQf0k35jPAFg+knVpHV05Ymc7H0nZtro0iccR8FHNkvaFxHkva1PHCBDZiT7as7Ud6ydtPCTZ1caZBJJDOhlLGlsPBhKlMMoOu6Rs12UIGcyoGqRRNp4vptccAYsWXuZRuwf3m1kHhmKXM6IS1hynWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8kl8yc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3065EC4CEC0;
	Sat, 14 Sep 2024 03:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726284026;
	bh=z+O7sNBAvvi/n5HlXhm3/8Qgqp35MyrUVjtUnrpdLGk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m8kl8yc4Bik4N7YlXFnzyXjv94GMsA06LkFOUauEPvqVyZC0L+WKud0NJ5MpUOeP/
	 7D97xVJebkFEN4IxyjT0kBbaJJs4KRRJMhbGMho6F1U+rnK2299QhdwyEgv2S5j7Hk
	 ZFCKTTduTl+m2LBcdU7C6Bl4NAMnmrBduRi6DHBAwmViDBATQ3ZPO9d/bIbeqy7J+9
	 WFZ2cT/PEqX3HLWkXC8h9EP9N5NQBRU6MisXvZi3f6i1sPzY0DCzkt7q5Mcv/Wp7T9
	 THDPYljNU+V3H/xVnfy2I8XQjymQDjXLwlwkK+5EsthGvkVXLMrR7OzmPlGhAg/wz9
	 8oI0BxkWUHZBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD973806655;
	Sat, 14 Sep 2024 03:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: avoid possible NULL deref in
 rt6_uncached_list_flush_dev()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172628402752.2440307.8488441153072989141.git-patchwork-notify@kernel.org>
Date: Sat, 14 Sep 2024 03:20:27 +0000
References: <20240913083147.3095442-1-edumazet@google.com>
In-Reply-To: <20240913083147.3095442-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 ebiederm@xmission.com, kafai@fb.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Sep 2024 08:31:47 +0000 you wrote:
> Blamed commit accidentally removed a check for rt->rt6i_idev being NULL,
> as spotted by syzbot:
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 1 UID: 0 PID: 10998 Comm: syz-executor Not tainted 6.11.0-rc6-syzkaller-00208-g625403177711 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
>  RIP: 0010:rt6_uncached_list_flush_dev net/ipv6/route.c:177 [inline]
>  RIP: 0010:rt6_disable_ip+0x33e/0x7e0 net/ipv6/route.c:4914
> Code: 41 80 3c 04 00 74 0a e8 90 d0 9b f7 48 8b 7c 24 08 48 8b 07 48 89 44 24 10 4c 89 f0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 4c 89 f7 e8 64 d0 9b f7 48 8b 44 24 18 49 39 06
> RSP: 0018:ffffc900047374e0 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 1ffff1100fdf8f33 RCX: dffffc0000000000
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88807efc78c0
> RBP: ffffc900047375d0 R08: 0000000000000003 R09: fffff520008e6e8c
> R10: dffffc0000000000 R11: fffff520008e6e8c R12: 1ffff1100fdf8f18
> R13: ffff88807efc7998 R14: 0000000000000000 R15: ffff88807efc7930
> FS:  0000000000000000(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020002a80 CR3: 0000000022f62000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>   addrconf_ifdown+0x15d/0x1bd0 net/ipv6/addrconf.c:3856
>  addrconf_notify+0x3cb/0x1020
>   notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
>   call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
>   call_netdevice_notifiers net/core/dev.c:2046 [inline]
>   unregister_netdevice_many_notify+0xd81/0x1c40 net/core/dev.c:11352
>   unregister_netdevice_many net/core/dev.c:11414 [inline]
>   unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11289
>   unregister_netdevice include/linux/netdevice.h:3129 [inline]
>   __tun_detach+0x6b9/0x1600 drivers/net/tun.c:685
>   tun_detach drivers/net/tun.c:701 [inline]
>   tun_chr_close+0x108/0x1b0 drivers/net/tun.c:3510
>   __fput+0x24a/0x8a0 fs/file_table.c:422
>   task_work_run+0x24f/0x310 kernel/task_work.c:228
>   exit_task_work include/linux/task_work.h:40 [inline]
>   do_exit+0xa2f/0x27f0 kernel/exit.c:882
>   do_group_exit+0x207/0x2c0 kernel/exit.c:1031
>   __do_sys_exit_group kernel/exit.c:1042 [inline]
>   __se_sys_exit_group kernel/exit.c:1040 [inline]
>   __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1040
>   x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f1acc77def9
> Code: Unable to access opcode bytes at 0x7f1acc77decf.
> RSP: 002b:00007ffeb26fa738 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1acc77def9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000043
> RBP: 00007f1acc7dd508 R08: 00007ffeb26f84d7 R09: 0000000000000003
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 0000000000000003 R14: 00000000ffffffff R15: 00007ffeb26fa8e0
>  </TASK>
> Modules linked in:
> 
> [...]

Here is the summary with links:
  - [net] ipv6: avoid possible NULL deref in rt6_uncached_list_flush_dev()
    https://git.kernel.org/netdev/net/c/04ccecfa959d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



