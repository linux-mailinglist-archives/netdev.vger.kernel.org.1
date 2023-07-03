Return-Path: <netdev+bounces-15056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A332745736
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 10:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970B41C204F0
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 08:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD8317FD;
	Mon,  3 Jul 2023 08:20:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B49D186E
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 08:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82DD5C433C8;
	Mon,  3 Jul 2023 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688372422;
	bh=WVASPr/c/WvhQF9aGfgtqnWRP8p63g/ZLTPv85BNKCY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t0sAFDSzaZOX8t9EVpkJBtcQuoEu7bMflw6k28KsGvmB+ElmUmTusgq11VXdSOKuY
	 L0UhGsVEAiArGle60wvFcrT8MbwgO5DekZC6m6N2kHiwLp97hcMtzolAhLTpWRSEbA
	 8zCUY7uSQ0ZF4rjyt+Hc9kHAe3raKvwF2oII1C2LAqhWlj18Bl6RXlOs6MY3L3djqP
	 hqOHeIYzL+WRZwZ19By30O5d0T4aPagQadzfiBPCaS3BIJb7NKIFrBm+Hs4DEQEIc1
	 FaGqjYC5NerxeYtVygkHcYqTT42cMZ7bZeAVG9JpSodDBQygd7e041u5Mw6yHgvef4
	 16F6EDylA0amw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6972CC64459;
	Mon,  3 Jul 2023 08:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fix net_dev_start_xmit trace event vs
 skb_transport_offset()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168837242242.9798.5178996071297316513.git-patchwork-notify@kernel.org>
Date: Mon, 03 Jul 2023 08:20:22 +0000
References: <20230701024825.2689655-1-edumazet@google.com>
In-Reply-To: <20230701024825.2689655-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat,  1 Jul 2023 02:48:24 +0000 you wrote:
> After blamed commit, we must be more careful about using
> skb_transport_offset(), as reminded us by syzbot:
> 
> WARNING: CPU: 0 PID: 10 at include/linux/skbuff.h:2868 skb_transport_offset include/linux/skbuff.h:2977 [inline]
> WARNING: CPU: 0 PID: 10 at include/linux/skbuff.h:2868 perf_trace_net_dev_start_xmit+0x89a/0xce0 include/trace/events/net.h:14
> Modules linked in:
> CPU: 0 PID: 10 Comm: kworker/u4:1 Not tainted 6.1.30-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
> Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet
> RIP: 0010:skb_transport_header include/linux/skbuff.h:2868 [inline]
> RIP: 0010:skb_transport_offset include/linux/skbuff.h:2977 [inline]
> RIP: 0010:perf_trace_net_dev_start_xmit+0x89a/0xce0 include/trace/events/net.h:14
> Code: 8b 04 25 28 00 00 00 48 3b 84 24 c0 00 00 00 0f 85 4e 04 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc e8 56 22 01 fd <0f> 0b e9 f6 fc ff ff 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 86 f9 ff
> RSP: 0018:ffffc900002bf700 EFLAGS: 00010293
> RAX: ffffffff8485d8ca RBX: 000000000000ffff RCX: ffff888100914280
> RDX: 0000000000000000 RSI: 000000000000ffff RDI: 000000000000ffff
> RBP: ffffc900002bf818 R08: ffffffff8485d5b6 R09: fffffbfff0f8fb5e
> R10: 0000000000000000 R11: dffffc0000000001 R12: 1ffff110217d8f67
> R13: ffff88810bec7b3a R14: dffffc0000000000 R15: dffffc0000000000
> FS: 0000000000000000(0000) GS:ffff8881f6a00000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f96cf6d52f0 CR3: 000000012224c000 CR4: 0000000000350ef0
> Call Trace:
> <TASK>
> [<ffffffff84715e35>] trace_net_dev_start_xmit include/trace/events/net.h:14 [inline]
> [<ffffffff84715e35>] xmit_one net/core/dev.c:3643 [inline]
> [<ffffffff84715e35>] dev_hard_start_xmit+0x705/0x980 net/core/dev.c:3660
> [<ffffffff8471a232>] __dev_queue_xmit+0x16b2/0x3370 net/core/dev.c:4324
> [<ffffffff85416493>] dev_queue_xmit include/linux/netdevice.h:3030 [inline]
> [<ffffffff85416493>] batadv_send_skb_packet+0x3f3/0x680 net/batman-adv/send.c:108
> [<ffffffff85416744>] batadv_send_broadcast_skb+0x24/0x30 net/batman-adv/send.c:127
> [<ffffffff853bc52a>] batadv_iv_ogm_send_to_if net/batman-adv/bat_iv_ogm.c:393 [inline]
> [<ffffffff853bc52a>] batadv_iv_ogm_emit net/batman-adv/bat_iv_ogm.c:421 [inline]
> [<ffffffff853bc52a>] batadv_iv_send_outstanding_bat_ogm_packet+0x69a/0x840 net/batman-adv/bat_iv_ogm.c:1701
> [<ffffffff8151023c>] process_one_work+0x8ac/0x1170 kernel/workqueue.c:2289
> [<ffffffff81511938>] worker_thread+0xaa8/0x12d0 kernel/workqueue.c:2436
> 
> [...]

Here is the summary with links:
  - [net] net: fix net_dev_start_xmit trace event vs skb_transport_offset()
    https://git.kernel.org/netdev/net/c/f88fcb1d7d96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



