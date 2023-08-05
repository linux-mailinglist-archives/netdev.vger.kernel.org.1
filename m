Return-Path: <netdev+bounces-24608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B83770CE5
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 03:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21DC282703
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 01:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5417E2;
	Sat,  5 Aug 2023 01:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D1C136D
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 01:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03BFBC433C9;
	Sat,  5 Aug 2023 01:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691197823;
	bh=OTkkp8r6SvlFfPgB4yze/LcrXI3lcFCS3yZQC1/p9Ok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=no9mEe3XfJnvPvAWggcWhXKHzneVJu9DRC7mKdcRzmZEgbriULKF5BHvKh2/QRtqO
	 5e4O1yv2eIrnDsVYG27Tf+Uk3zQp0wKln411k2ySJPiMUzuveYe3O38uddkkWbR/n6
	 06zbAfYelzDJkuGPlnWxGPiuZr6w+bXEvnOmJQx3999GH2bg5rIEMEiXYwcXyc/xKC
	 icdgvCqpoCsN0fvX+fsgD0vAaiR/y8PfU+r/XBl2tB7n1+9G+nNkJM56Ix0OWzpnS5
	 lhiJMtqe8xcthxEy2eHdgEdpXlzFY4jfWv19aEc7YEqnpGCkUE3tzJeornE4t7+i1n
	 9DsyvJXVM5Qqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DCA74C595C3;
	Sat,  5 Aug 2023 01:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/packet: annotate data-races around tp->status
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169119782290.10230.2962947310236641592.git-patchwork-notify@kernel.org>
Date: Sat, 05 Aug 2023 01:10:22 +0000
References: <20230803145600.2937518-1-edumazet@google.com>
In-Reply-To: <20230803145600.2937518-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 willemdebruijn.kernel@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Aug 2023 14:56:00 +0000 you wrote:
> Another syzbot report [1] is about tp->status lockless reads
> from __packet_get_status()
> 
> [1]
> BUG: KCSAN: data-race in __packet_rcv_has_room / __packet_set_status
> 
> write to 0xffff888117d7c080 of 8 bytes by interrupt on cpu 0:
> __packet_set_status+0x78/0xa0 net/packet/af_packet.c:407
> tpacket_rcv+0x18bb/0x1a60 net/packet/af_packet.c:2483
> deliver_skb net/core/dev.c:2173 [inline]
> __netif_receive_skb_core+0x408/0x1e80 net/core/dev.c:5337
> __netif_receive_skb_one_core net/core/dev.c:5491 [inline]
> __netif_receive_skb+0x57/0x1b0 net/core/dev.c:5607
> process_backlog+0x21f/0x380 net/core/dev.c:5935
> __napi_poll+0x60/0x3b0 net/core/dev.c:6498
> napi_poll net/core/dev.c:6565 [inline]
> net_rx_action+0x32b/0x750 net/core/dev.c:6698
> __do_softirq+0xc1/0x265 kernel/softirq.c:571
> invoke_softirq kernel/softirq.c:445 [inline]
> __irq_exit_rcu+0x57/0xa0 kernel/softirq.c:650
> sysvec_apic_timer_interrupt+0x6d/0x80 arch/x86/kernel/apic/apic.c:1106
> asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
> smpboot_thread_fn+0x33c/0x4a0 kernel/smpboot.c:112
> kthread+0x1d7/0x210 kernel/kthread.c:379
> ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
> 
> [...]

Here is the summary with links:
  - [net] net/packet: annotate data-races around tp->status
    https://git.kernel.org/netdev/net/c/8a9896177784

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



