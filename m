Return-Path: <netdev+bounces-13640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A13673C64E
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 04:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E84281E8E
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 02:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5EB38F;
	Sat, 24 Jun 2023 02:10:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60938378
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 02:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D36FCC433C9;
	Sat, 24 Jun 2023 02:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687572619;
	bh=Qp2xEgcB+/FdgHW0lpwG66zaWL7D/dpsjdMs8nxx7Ls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NXhnSxV293VFXqxfTlYPoD19kIhYKvXTu1brDRI2lytIg2KShe2r0fPOQMZOYCjvt
	 kEBZuI+dp5lGGdR5/ZG4/JPPDeuJpX+ZtH5JtyZoFmmWgNPeHW+bXNl1iMjtdTJxLm
	 14reaqQzTVcwiIKlKIw7NwbsZASVQjNOAoZ6a9KT4sYG1UEjIdxAD/w7vdNWQE9bw0
	 KXoTu6R546HEmA0bDv8ICSM/MwRkAFzTGjehUR2C2L+7i6GhCk6Rc5KmO68qjwyzW9
	 I6GxuJqRoYV2sKe+8XC2UiqzXydDL887N8GH0hRwgzGFsN1RHfJx2FEKJwvDtu0TTD
	 7GF56TeX87z9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B1774C43157;
	Sat, 24 Jun 2023 02:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bonding: do not assume skb mac_header is set
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168757261972.25434.9941583477826524158.git-patchwork-notify@kernel.org>
Date: Sat, 24 Jun 2023 02:10:19 +0000
References: <20230622152304.2137482-1-edumazet@google.com>
In-Reply-To: <20230622152304.2137482-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 jarod@redhat.com, moshet@nvidia.com, joamaki@gmail.com, j.vosburgh@gmail.com,
 andy@greyhouse.net, vladimir.oltean@nxp.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jun 2023 15:23:04 +0000 you wrote:
> Drivers must not assume in their ndo_start_xmit() that
> skbs have their mac_header set. skb->data is all what is needed.
> 
> bonding seems to be one of the last offender as caught by syzbot:
> 
> WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 skb_mac_offset include/linux/skbuff.h:2913 [inline]
> WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 bond_xmit_hash drivers/net/bonding/bond_main.c:4170 [inline]
> WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 bond_xmit_3ad_xor_slave_get drivers/net/bonding/bond_main.c:5149 [inline]
> WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 bond_3ad_xor_xmit drivers/net/bonding/bond_main.c:5186 [inline]
> WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 __bond_start_xmit drivers/net/bonding/bond_main.c:5442 [inline]
> WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 bond_start_xmit+0x14ab/0x19d0 drivers/net/bonding/bond_main.c:5470
> Modules linked in:
> CPU: 1 PID: 12155 Comm: syz-executor.3 Not tainted 6.1.30-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
> RIP: 0010:skb_mac_header include/linux/skbuff.h:2907 [inline]
> RIP: 0010:skb_mac_offset include/linux/skbuff.h:2913 [inline]
> RIP: 0010:bond_xmit_hash drivers/net/bonding/bond_main.c:4170 [inline]
> RIP: 0010:bond_xmit_3ad_xor_slave_get drivers/net/bonding/bond_main.c:5149 [inline]
> RIP: 0010:bond_3ad_xor_xmit drivers/net/bonding/bond_main.c:5186 [inline]
> RIP: 0010:__bond_start_xmit drivers/net/bonding/bond_main.c:5442 [inline]
> RIP: 0010:bond_start_xmit+0x14ab/0x19d0 drivers/net/bonding/bond_main.c:5470
> Code: 8b 7c 24 30 e8 76 dd 1a 01 48 85 c0 74 0d 48 89 c3 e8 29 67 2e fe e9 15 ef ff ff e8 1f 67 2e fe e9 10 ef ff ff e8 15 67 2e fe <0f> 0b e9 45 f8 ff ff e8 09 67 2e fe e9 dc fa ff ff e8 ff 66 2e fe
> RSP: 0018:ffffc90002fff6e0 EFLAGS: 00010283
> RAX: ffffffff835874db RBX: 000000000000ffff RCX: 0000000000040000
> RDX: ffffc90004dcf000 RSI: 00000000000000b5 RDI: 00000000000000b6
> RBP: ffffc90002fff8b8 R08: ffffffff83586d16 R09: ffffffff83586584
> R10: 0000000000000007 R11: ffff8881599fc780 R12: ffff88811b6a7b7e
> R13: 1ffff110236d4f6f R14: ffff88811b6a7ac0 R15: 1ffff110236d4f76
> FS: 00007f2e9eb47700(0000) GS:ffff8881f6b00000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2e421000 CR3: 000000010e6d4000 CR4: 00000000003526e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> <TASK>
> [<ffffffff8471a49f>] netdev_start_xmit include/linux/netdevice.h:4925 [inline]
> [<ffffffff8471a49f>] __dev_direct_xmit+0x4ef/0x850 net/core/dev.c:4380
> [<ffffffff851d845b>] dev_direct_xmit include/linux/netdevice.h:3043 [inline]
> [<ffffffff851d845b>] packet_direct_xmit+0x18b/0x300 net/packet/af_packet.c:284
> [<ffffffff851c7472>] packet_snd net/packet/af_packet.c:3112 [inline]
> [<ffffffff851c7472>] packet_sendmsg+0x4a22/0x64d0 net/packet/af_packet.c:3143
> [<ffffffff8467a4b2>] sock_sendmsg_nosec net/socket.c:716 [inline]
> [<ffffffff8467a4b2>] sock_sendmsg net/socket.c:736 [inline]
> [<ffffffff8467a4b2>] __sys_sendto+0x472/0x5f0 net/socket.c:2139
> [<ffffffff8467a715>] __do_sys_sendto net/socket.c:2151 [inline]
> [<ffffffff8467a715>] __se_sys_sendto net/socket.c:2147 [inline]
> [<ffffffff8467a715>] __x64_sys_sendto+0xe5/0x100 net/socket.c:2147
> [<ffffffff8553071f>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> [<ffffffff8553071f>] do_syscall_64+0x2f/0x50 arch/x86/entry/common.c:80
> [<ffffffff85600087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> [...]

Here is the summary with links:
  - [net] bonding: do not assume skb mac_header is set
    https://git.kernel.org/netdev/net/c/6a940abdef31

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



