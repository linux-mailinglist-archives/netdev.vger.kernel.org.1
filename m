Return-Path: <netdev+bounces-100920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7D28FC884
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 12:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6AA1F22F8F
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 10:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A87190045;
	Wed,  5 Jun 2024 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfVL5y13"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C523D4963F
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717581630; cv=none; b=M7Y6kjULMBYOcYIz122JYyQNv9LQCVZxclMvfa7yg8r1mDA3pIuHMVUAOfT/VTdCH+wNR5tpDxdN3w1xC+EpnHmiSdZfAn4Vbd/BDqlcmVbKYW5pQdd8qbr6Ei0dq1kw0jhNPQFCUdpvkeyJV2VJOgZu1At3kis6zjplbfUCsW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717581630; c=relaxed/simple;
	bh=GgO9iMPO2sRUDLrksz7N4xKRqCyGQKPvaob4sW7yZe8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gH4Yw5RzzVKlYlaI+k3yklZWjs0emSSLTupgtr4l+Jp+/sPHVTA7MYfZotb/bMpiq22yKeVVwec0mXKk1YcyrAKOhyxbaAeyaQNoUcgR79cKw03pDnO2CJVDwyQg5cDMDCMVw7IIcaxeEX50i7iSpouO9L16bkcTgWKest0gs3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfVL5y13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D834C3277B;
	Wed,  5 Jun 2024 10:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717581630;
	bh=GgO9iMPO2sRUDLrksz7N4xKRqCyGQKPvaob4sW7yZe8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KfVL5y13jlkWJJYny+rQ6HKHLGMq9eVI3/TNFdorv80rlreg4zoRm17aeFfCA0t8u
	 IH+W7fylNYGYkM4xZA6903eg274mcwqbLvizPuFJXl0FyEUBTBxKaWWo85AME5pHis
	 SwaCY4cMAjvX65F56J04wBcs3GzuhYIIuGs5oVO3CoywbbVZevZ0SOTEVZGMNuiaur
	 Bdvy/g4h7wUjNnvfk0bVBS9EbMftWm1nkakjA56yyajQpK7uhdxbQ+pc5uSwp3EdlH
	 skiZYMxouGrLDtJu1NDDC3vNGYjmuNq7jsr7/m40KZgOmm5ZMADgVlOwD2+3busAhu
	 kPQZZwqlL8h9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54994C4332C;
	Wed,  5 Jun 2024 10:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ionic: fix kernel panic in XDP_TX action
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171758163034.24633.17280787984011172321.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 10:00:30 +0000
References: <20240603045755.501895-1-ap420073@gmail.com>
In-Reply-To: <20240603045755.501895-1-ap420073@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, shannon.nelson@amd.com, brett.creeley@amd.com,
 drivers@pensando.io, netdev@vger.kernel.org, jacob.e.keller@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  3 Jun 2024 04:57:55 +0000 you wrote:
> In the XDP_TX path, ionic driver sends a packet to the TX path with rx
> page and corresponding dma address.
> After tx is done, ionic_tx_clean() frees that page.
> But RX ring buffer isn't reset to NULL.
> So, it uses a freed page, which causes kernel panic.
> 
> BUG: unable to handle page fault for address: ffff8881576c110c
> PGD 773801067 P4D 773801067 PUD 87f086067 PMD 87efca067 PTE 800ffffea893e060
> Oops: Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN NOPTI
> CPU: 1 PID: 25 Comm: ksoftirqd/1 Not tainted 6.9.0+ #11
> Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/2021
> RIP: 0010:bpf_prog_f0b8caeac1068a55_balancer_ingress+0x3b/0x44f
> Code: 00 53 41 55 41 56 41 57 b8 01 00 00 00 48 8b 5f 08 4c 8b 77 00 4c 89 f7 48 83 c7 0e 48 39 d8
> RSP: 0018:ffff888104e6fa28 EFLAGS: 00010283
> RAX: 0000000000000002 RBX: ffff8881576c1140 RCX: 0000000000000002
> RDX: ffffffffc0051f64 RSI: ffffc90002d33048 RDI: ffff8881576c110e
> RBP: ffff888104e6fa88 R08: 0000000000000000 R09: ffffed1027a04a23
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881b03a21a8
> R13: ffff8881589f800f R14: ffff8881576c1100 R15: 00000001576c1100
> FS: 0000000000000000(0000) GS:ffff88881ae00000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff8881576c110c CR3: 0000000767a90000 CR4: 00000000007506f0
> PKRU: 55555554
> Call Trace:
> <TASK>
> ? __die+0x20/0x70
> ? page_fault_oops+0x254/0x790
> ? __pfx_page_fault_oops+0x10/0x10
> ? __pfx_is_prefetch.constprop.0+0x10/0x10
> ? search_bpf_extables+0x165/0x260
> ? fixup_exception+0x4a/0x970
> ? exc_page_fault+0xcb/0xe0
> ? asm_exc_page_fault+0x22/0x30
> ? 0xffffffffc0051f64
> ? bpf_prog_f0b8caeac1068a55_balancer_ingress+0x3b/0x44f
> ? do_raw_spin_unlock+0x54/0x220
> ionic_rx_service+0x11ab/0x3010 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
> ? ionic_tx_clean+0x29b/0xc60 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
> ? __pfx_ionic_tx_clean+0x10/0x10 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
> ? __pfx_ionic_rx_service+0x10/0x10 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
> ? ionic_tx_cq_service+0x25d/0xa00 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
> ? __pfx_ionic_rx_service+0x10/0x10 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
> ionic_cq_service+0x69/0x150 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
> ionic_txrx_napi+0x11a/0x540 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
> __napi_poll.constprop.0+0xa0/0x440
> net_rx_action+0x7e7/0xc30
> ? __pfx_net_rx_action+0x10/0x10
> 
> [...]

Here is the summary with links:
  - [net] ionic: fix kernel panic in XDP_TX action
    https://git.kernel.org/netdev/net/c/491aee894a08

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



