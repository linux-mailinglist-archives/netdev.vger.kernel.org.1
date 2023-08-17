Return-Path: <netdev+bounces-28582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A0077FE4A
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C358F282030
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 19:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DF41B7C5;
	Thu, 17 Aug 2023 19:00:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD01B17FF3
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 19:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6993CC4339A;
	Thu, 17 Aug 2023 19:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692298825;
	bh=qUguG3iwlUBtNjdn6/C7dwFyMBjidblLdFms/E1PAA0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jHovKltcV75ek97+oO3p3IeZ0S4KWMEChmtCOyQFJms5S/DhleE5n9HgmDDFzjTcA
	 JWRmN+pgbaB6SznUHweI4LtXImrZDIvHZCqze3yUittttZPnsmsCyR6r6GuuHQm2e1
	 nQM8lB7K5o3BLVE3NWCH3S8xKk0jrl9cVYCrMZNPwkZJ1cf1TEwfeWFw74GMy5GV2m
	 Aonj+CsgwJ1mOogJvVymdgkEehH49/kXpOofzFFKzEhIgJRQ9IW5yihojh8Ns1tgDb
	 DTWMVWB5N/J6GEwAcou3Fw5QwRW3PEp09kjGzTxjaWBQ7Uim906y9iNwgXAVNhdYHk
	 kx/c2Bl5rCmPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A502C59A4C;
	Thu, 17 Aug 2023 19:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: do not allow gso_size to be set to GSO_BY_FRAGS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169229882529.13479.9609079014024877862.git-patchwork-notify@kernel.org>
Date: Thu, 17 Aug 2023 19:00:25 +0000
References: <20230816142158.1779798-1-edumazet@google.com>
In-Reply-To: <20230816142158.1779798-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 lucien.xin@gmail.com, marcelo.leitner@gmail.com, willemb@google.com,
 mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Aug 2023 14:21:58 +0000 you wrote:
> One missing check in virtio_net_hdr_to_skb() allowed
> syzbot to crash kernels again [1]
> 
> Do not allow gso_size to be set to GSO_BY_FRAGS (0xffff),
> because this magic value is used by the kernel.
> 
> [1]
> general protection fault, probably for non-canonical address 0xdffffc000000000e: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
> CPU: 0 PID: 5039 Comm: syz-executor401 Not tainted 6.5.0-rc5-next-20230809-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
> RIP: 0010:skb_segment+0x1a52/0x3ef0 net/core/skbuff.c:4500
> Code: 00 00 00 e9 ab eb ff ff e8 6b 96 5d f9 48 8b 84 24 00 01 00 00 48 8d 78 70 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e ea 21 00 00 48 8b 84 24 00 01
> RSP: 0018:ffffc90003d3f1c8 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: 000000000001fffe RCX: 0000000000000000
> RDX: 000000000000000e RSI: ffffffff882a3115 RDI: 0000000000000070
> RBP: ffffc90003d3f378 R08: 0000000000000005 R09: 000000000000ffff
> R10: 000000000000ffff R11: 5ee4a93e456187d6 R12: 000000000001ffc6
> R13: dffffc0000000000 R14: 0000000000000008 R15: 000000000000ffff
> FS: 00005555563f2380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020020000 CR3: 000000001626d000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> <TASK>
> udp6_ufo_fragment+0x9d2/0xd50 net/ipv6/udp_offload.c:109
> ipv6_gso_segment+0x5c4/0x17b0 net/ipv6/ip6_offload.c:120
> skb_mac_gso_segment+0x292/0x610 net/core/gso.c:53
> __skb_gso_segment+0x339/0x710 net/core/gso.c:124
> skb_gso_segment include/net/gso.h:83 [inline]
> validate_xmit_skb+0x3a5/0xf10 net/core/dev.c:3625
> __dev_queue_xmit+0x8f0/0x3d60 net/core/dev.c:4329
> dev_queue_xmit include/linux/netdevice.h:3082 [inline]
> packet_xmit+0x257/0x380 net/packet/af_packet.c:276
> packet_snd net/packet/af_packet.c:3087 [inline]
> packet_sendmsg+0x24c7/0x5570 net/packet/af_packet.c:3119
> sock_sendmsg_nosec net/socket.c:727 [inline]
> sock_sendmsg+0xd9/0x180 net/socket.c:750
> ____sys_sendmsg+0x6ac/0x940 net/socket.c:2496
> ___sys_sendmsg+0x135/0x1d0 net/socket.c:2550
> __sys_sendmsg+0x117/0x1e0 net/socket.c:2579
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7ff27cdb34d9
> 
> [...]

Here is the summary with links:
  - [net] net: do not allow gso_size to be set to GSO_BY_FRAGS
    https://git.kernel.org/netdev/net/c/b616be6b9768

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



