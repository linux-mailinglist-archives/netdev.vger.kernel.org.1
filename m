Return-Path: <netdev+bounces-211435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EFCB189EC
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 02:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F026C1C84BAE
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 00:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D7C5A79B;
	Sat,  2 Aug 2025 00:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JG2hkGU4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61722AD31;
	Sat,  2 Aug 2025 00:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754094597; cv=none; b=tp5qcWHsz5UVagsTEZ3n+wFmtpuqYEfBAzLhXwMo9FS0jx5O93iKY87gTf3knUjZVEcmeRxmBBRWUg3vU9e7n6E7bqVCurDyER/yvKBEKiYUmPGmuVgfvZuPGlCkKytIf2ushiI2A9OnzJ/osQ7AYJlcXld4JqVDv74G2t9Mvs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754094597; c=relaxed/simple;
	bh=roQYvsCVrYNtMkmVS0fcLUl3ijMdYuW0bC5rF1czNWE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CCRGwmZTY/c09Z+YtHNc66WWVKC8nLBUvOX1/Ilob2liok5JVgK7xWYllSMAGkkGfi5Iu4puAo4f8clm5Kc1g1lmJVTmFZyxEHgSuIrN4QIIFhfOJx1EQjDtScX9MwU1KnRqHYrMDe4ZfiKy2rEEXGfGup9+4eswDfvO5PR/Bxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JG2hkGU4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7A4C4CEF6;
	Sat,  2 Aug 2025 00:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754094596;
	bh=roQYvsCVrYNtMkmVS0fcLUl3ijMdYuW0bC5rF1czNWE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JG2hkGU4blThjlox6+ghm/m3jjWaIYdZC27a8oJczfnFp8oL7Ba329fyRrlJLsZLm
	 LSUrS0eZ3SbSp+ggwlEdFTqRiRzenLfTYrKL/aOAIJFNjqmB6vKkQ22h/fbC+3ya20
	 EM2GLEEECacot2hDR7722Y+HjR9ZYbj4vpA8EUNBmmzRyd4Tpt3RY8EWGRBPcu/Ehn
	 lG6bEg1kmJbca9RhcnZob/y3wTUMnrcFotuG82CBA7LkZlq8oTNuE4XUjr4bVeklz3
	 IKlfLrcXFiKnFarqIE4UhHSImuLDwsFqZy+nFdegdT3HmO7RLvnvpeN+D35GukOgWC
	 IU1YB+NO26rFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEC0383BF56;
	Sat,  2 Aug 2025 00:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: drop UFO packets in udp_rcv_segment()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175409461150.4171186.3408701110750793287.git-patchwork-notify@kernel.org>
Date: Sat, 02 Aug 2025 00:30:11 +0000
References: <20250730101458.3470788-1-wangliang74@huawei.com>
In-Reply-To: <20250730101458.3470788-1-wangliang74@huawei.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Jul 2025 18:14:58 +0800 you wrote:
> When sending a packet with virtio_net_hdr to tun device, if the gso_type
> in virtio_net_hdr is SKB_GSO_UDP and the gso_size is less than udphdr
> size, below crash may happen.
> 
>   ------------[ cut here ]------------
>   kernel BUG at net/core/skbuff.c:4572!
>   Oops: invalid opcode: 0000 [#1] SMP NOPTI
>   CPU: 0 UID: 0 PID: 62 Comm: mytest Not tainted 6.16.0-rc7 #203 PREEMPT(voluntary)
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>   RIP: 0010:skb_pull_rcsum+0x8e/0xa0
>   Code: 00 00 5b c3 cc cc cc cc 8b 93 88 00 00 00 f7 da e8 37 44 38 00 f7 d8 89 83 88 00 00 00 48 8b 83 c8 00 00 00 5b c3 cc cc cc cc <0f> 0b 0f 0b 66 66 2e 0f 1f 84 00 000
>   RSP: 0018:ffffc900001fba38 EFLAGS: 00000297
>   RAX: 0000000000000004 RBX: ffff8880040c1000 RCX: ffffc900001fb948
>   RDX: ffff888003e6d700 RSI: 0000000000000008 RDI: ffff88800411a062
>   RBP: ffff8880040c1000 R08: 0000000000000000 R09: 0000000000000001
>   R10: ffff888003606c00 R11: 0000000000000001 R12: 0000000000000000
>   R13: ffff888004060900 R14: ffff888004050000 R15: ffff888004060900
>   FS:  000000002406d3c0(0000) GS:ffff888084a19000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000020000040 CR3: 0000000004007000 CR4: 00000000000006f0
>   Call Trace:
>    <TASK>
>    udp_queue_rcv_one_skb+0x176/0x4b0 net/ipv4/udp.c:2445
>    udp_queue_rcv_skb+0x155/0x1f0 net/ipv4/udp.c:2475
>    udp_unicast_rcv_skb+0x71/0x90 net/ipv4/udp.c:2626
>    __udp4_lib_rcv+0x433/0xb00 net/ipv4/udp.c:2690
>    ip_protocol_deliver_rcu+0xa6/0x160 net/ipv4/ip_input.c:205
>    ip_local_deliver_finish+0x72/0x90 net/ipv4/ip_input.c:233
>    ip_sublist_rcv_finish+0x5f/0x70 net/ipv4/ip_input.c:579
>    ip_sublist_rcv+0x122/0x1b0 net/ipv4/ip_input.c:636
>    ip_list_rcv+0xf7/0x130 net/ipv4/ip_input.c:670
>    __netif_receive_skb_list_core+0x21d/0x240 net/core/dev.c:6067
>    netif_receive_skb_list_internal+0x186/0x2b0 net/core/dev.c:6210
>    napi_complete_done+0x78/0x180 net/core/dev.c:6580
>    tun_get_user+0xa63/0x1120 drivers/net/tun.c:1909
>    tun_chr_write_iter+0x65/0xb0 drivers/net/tun.c:1984
>    vfs_write+0x300/0x420 fs/read_write.c:593
>    ksys_write+0x60/0xd0 fs/read_write.c:686
>    do_syscall_64+0x50/0x1c0 arch/x86/entry/syscall_64.c:63
>    </TASK>
> 
> [...]

Here is the summary with links:
  - [net,v3] net: drop UFO packets in udp_rcv_segment()
    https://git.kernel.org/netdev/net/c/d46e51f1c78b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



