Return-Path: <netdev+bounces-125501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B9F96D673
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 12:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E335281169
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 10:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AF4194A61;
	Thu,  5 Sep 2024 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KK3Xieqs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9280C189B8A
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533703; cv=none; b=IFnSL9RYzxnfv6FRZNlZUP4ymILftSYSaCe9R63dHmcYgSDOWoCdC/0mCzup9t8WJP4EbpYkaRk6TvvuPQOrv5Ef+omZ9sR06Eb6CMEqyaJ+RX8skUl3WFNwJn37ZCuWvoPN8tAEVdt727RHjDiSOXBRKo4nJULlo7UqvPTun7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533703; c=relaxed/simple;
	bh=u8OBVvhrubQyOESBrAVoy3a/lLtCO1YWC6LP6BvHf7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQD31Id+hdkGJ/KB9GUHfj1/WqOpVftHlPVAfvOOq6qR0jrg/TL9wRcO37SKT6HayQBgKjcFrRseu3gegistFHFcQ+2ub3WgYNDhkG/ygLPiCMuTaNYqpotEuL8jsNQfmv6tL4yrwdJ6xONMxSr5fBtSctn+yQu3rMCbQJIRYMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KK3Xieqs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6304CC4CEC3;
	Thu,  5 Sep 2024 10:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725533703;
	bh=u8OBVvhrubQyOESBrAVoy3a/lLtCO1YWC6LP6BvHf7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KK3XieqsbaW4OSHYwHPjpyMK/fU9gR+jsPCMABKdmkaFyU/hC2eyy4fg4tlpa7G0O
	 N9FdKsZDVOCPCNHBU6IjqX27OyxQTzx2MtmJKlEcSacyVXnOW5hM5XBQZa5uj4MOar
	 8p+dIF/EAKOi2tuZ/HI8ja1suxnoshQh8cMIFKka4UqTvEyzOtYMhKlTWd6ZX9PRnA
	 aYxIWCo42G8F+u3hdhpBsn42JEYFW+UdbiL8TSFBp6Rx7zFl0pXjGXNDMhUjC3HxQO
	 jV6hN6rRKQQy3uknmBYhT6ibs5Ei4yh/VHct6TAjVWag7ewcjtgC4UltZbL9IP52qU
	 fLCZBvR+Thq/A==
Date: Thu, 5 Sep 2024 11:54:59 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH net] net: hsr: remove seqnr_lock
Message-ID: <20240905105459.GG1722938@kernel.org>
References: <20240904133725.1073963-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904133725.1073963-1-edumazet@google.com>

On Wed, Sep 04, 2024 at 01:37:25PM +0000, Eric Dumazet wrote:
> syzbot found a new splat [1].
> 
> Instead of adding yet another spin_lock_bh(&hsr->seqnr_lock) /
> spin_unlock_bh(&hsr->seqnr_lock) pair, remove seqnr_lock
> and use atomic_t for hsr->sequence_nr and hsr->sup_sequence_nr.
> 
> This also avoid a race in hsr_fill_info().
> 
> Also remove interlink_sequence_nr which is unused.
> 
> [1]
>  WARNING: CPU: 1 PID: 9723 at net/hsr/hsr_forward.c:602 handle_std_frame+0x247/0x2c0 net/hsr/hsr_forward.c:602
> Modules linked in:
> CPU: 1 UID: 0 PID: 9723 Comm: syz.0.1657 Not tainted 6.11.0-rc6-syzkaller-00026-g88fac17500f4 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
>  RIP: 0010:handle_std_frame+0x247/0x2c0 net/hsr/hsr_forward.c:602
> Code: 49 8d bd b0 01 00 00 be ff ff ff ff e8 e2 58 25 00 31 ff 89 c5 89 c6 e8 47 53 a8 f6 85 ed 0f 85 5a ff ff ff e8 fa 50 a8 f6 90 <0f> 0b 90 e9 4c ff ff ff e8 cc e7 06 f7 e9 8f fe ff ff e8 52 e8 06
> RSP: 0018:ffffc90000598598 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffffc90000598670 RCX: ffffffff8ae2c919
> RDX: ffff888024e94880 RSI: ffffffff8ae2c926 RDI: 0000000000000005
> RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
> R13: ffff8880627a8cc0 R14: 0000000000000000 R15: ffff888012b03c3a
> FS:  0000000000000000(0000) GS:ffff88802b700000(0063) knlGS:00000000f5696b40
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: 0000000020010000 CR3: 00000000768b4000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <IRQ>
>   hsr_fill_frame_info+0x2c8/0x360 net/hsr/hsr_forward.c:630
>   fill_frame_info net/hsr/hsr_forward.c:700 [inline]
>   hsr_forward_skb+0x7df/0x25c0 net/hsr/hsr_forward.c:715
>   hsr_handle_frame+0x603/0x850 net/hsr/hsr_slave.c:70
>   __netif_receive_skb_core.constprop.0+0xa3d/0x4330 net/core/dev.c:5555
>   __netif_receive_skb_list_core+0x357/0x950 net/core/dev.c:5737
>   __netif_receive_skb_list net/core/dev.c:5804 [inline]
>   netif_receive_skb_list_internal+0x753/0xda0 net/core/dev.c:5896
>   gro_normal_list include/net/gro.h:515 [inline]
>   gro_normal_list include/net/gro.h:511 [inline]
>   napi_complete_done+0x23f/0x9a0 net/core/dev.c:6247
>   gro_cell_poll+0x162/0x210 net/core/gro_cells.c:66
>   __napi_poll.constprop.0+0xb7/0x550 net/core/dev.c:6772
>   napi_poll net/core/dev.c:6841 [inline]
>   net_rx_action+0xa92/0x1010 net/core/dev.c:6963
>   handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
>   do_softirq kernel/softirq.c:455 [inline]
>   do_softirq+0xb2/0xf0 kernel/softirq.c:442
>  </IRQ>
>  <TASK>
> 
> Fixes: 06afd2c31d33 ("hsr: Synchronize sending frames to have always incremented outgoing seq nr.")
> Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks Eric,

I see that;

1) The stack trace above is for a call path where
   hsr_forward_skb(), and in turn handle_std_frame(),
   is called without hsr->seqnr_lock held, which explains the splat.

2) Access to hsr->sequence_nr in hsr_fill_info() is not synchronised
   with other accesses to it.

3) hsr->interlink_sequence_nr is set but otherwise unknown

And that this patch addresses all of the above.

Reviewed-by: Simon Horman <horms@kernel.org>


