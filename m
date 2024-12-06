Return-Path: <netdev+bounces-149578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2E39E6494
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 04:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32C816A214
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 03:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F240617BEA2;
	Fri,  6 Dec 2024 03:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICYwE5NN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB55734CDE
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 03:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733454542; cv=none; b=URu1YkqLDZi8t+Xx4dWCWxGzRLaDNs4WtI1Dt0ApUaywlkHspCFsY6fyHyZNhpVVfe5OJAKG4uxhVm2V5pNRUD0XxFWvNntMiXNPR7Zk7I89ok2JSGP1kOD1JVzpjVRe+cXO/qEAx7K0pT4NK+05oum8zrwhfh8DmAqYi1ZuUho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733454542; c=relaxed/simple;
	bh=Xuag279yAzWIfyPXV4n9MZFDJEgCdZZ6gAQr/zEsT/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/TMFzNtXN0Dz1Xypl04CyrMwarWyizgxBdx+mh6/JOiaW1h5sseVF4vvoFIvSDgJRRspO0CNStKXhKqEmMCqh1IH37/nz646z2J0xtKeQfDvBZRCfBf/uSIWd4nS61iYY9VbL7MF9eSqA4T5yzv4E+gHB/sTqedvbwDNS1a5sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICYwE5NN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E8FC4CED1;
	Fri,  6 Dec 2024 03:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733454542;
	bh=Xuag279yAzWIfyPXV4n9MZFDJEgCdZZ6gAQr/zEsT/0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ICYwE5NN/4yjpZBqo235gyuj3fTyxPaSIPpyMP+Ijn8OCGWlBs1Rbl8ln8di1qB+r
	 uq5UGA1iJVM+LF+gq4vWBNVwMvv7m+G4+ZC2pssS6aMFD2YUsQmLkU1i5ay/unquOF
	 31GUuPTs1SYbQVznQrRNPXtzRVUp5f4PzNqoK3P9vKlXM8Fvnn3trEsdFwW2YKjF3p
	 GSWkTIIyb984K6QGJuqCTtdRp//Pnnzk6xauCwUNB9zCj1FCvX5y4K4C70IWbF/vkS
	 nb+ZPwEUX4hw7QFA/frK9lwahD/35C07eyOq9et+nCQmksyYn6d1VEbRiT8yCt07Up
	 RsqJWWwFXmB8Q==
Message-ID: <9ba9c9c5-7f55-403a-a0b1-6db869be90c9@kernel.org>
Date: Thu, 5 Dec 2024 20:09:00 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net] ip: Return drop reason if in_dev is NULL in
 ip_route_input_rcu().
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 syzkaller <syzkaller@googlegroups.com>
References: <20241206020715.80207-1-kuniyu@amazon.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241206020715.80207-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/24 7:07 PM, Kuniyuki Iwashima wrote:
> syzkaller reported a warning in __sk_skb_reason_drop().
> 
> Commit 61b95c70f344 ("net: ip: make ip_route_input_rcu() return
> drop reasons") missed a path where -EINVAL is returned.
> 
> Then, the cited commit started to trigger the warning with the
> invalid error.
> 
> Let's fix it by returning SKB_DROP_REASON_NOT_SPECIFIED.
> 
> [0]:
> WARNING: CPU: 0 PID: 10 at net/core/skbuff.c:1216 __sk_skb_reason_drop net/core/skbuff.c:1216 [inline]
> WARNING: CPU: 0 PID: 10 at net/core/skbuff.c:1216 sk_skb_reason_drop+0x97/0x1b0 net/core/skbuff.c:1241
> Modules linked in:
> CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Not tainted 6.12.0-10686-gbb18265c3aba #10 1c308307628619808b5a4a0495c4aab5637b0551
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> Workqueue: wg-crypt-wg2 wg_packet_decrypt_worker
> RIP: 0010:__sk_skb_reason_drop net/core/skbuff.c:1216 [inline]
> RIP: 0010:sk_skb_reason_drop+0x97/0x1b0 net/core/skbuff.c:1241
> Code: 5d 41 5c 41 5d 41 5e e9 e7 9e 95 fd e8 e2 9e 95 fd 31 ff 44 89 e6 e8 58 a1 95 fd 45 85 e4 0f 85 a2 00 00 00 e8 ca 9e 95 fd 90 <0f> 0b 90 e8 c1 9e 95 fd 44 89 e6 bf 01 00 00 00 e8 34 a1 95 fd 41
> RSP: 0018:ffa0000000007650 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 000000000000ffff RCX: ffffffff83bc3592
> RDX: ff110001002a0000 RSI: ffffffff83bc34d6 RDI: 0000000000000007
> RBP: ff11000109ee85f0 R08: 0000000000000001 R09: ffe21c00213dd0da
> R10: 000000000000ffff R11: 0000000000000000 R12: 00000000ffffffea
> R13: 0000000000000000 R14: ff11000109ee86d4 R15: ff11000109ee8648
> FS:  0000000000000000(0000) GS:ff1100011a000000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020177000 CR3: 0000000108a3d006 CR4: 0000000000771ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000600
> PKRU: 55555554
> Call Trace:
>  <IRQ>
>  kfree_skb_reason include/linux/skbuff.h:1263 [inline]
>  ip_rcv_finish_core.constprop.0+0x896/0x2320 net/ipv4/ip_input.c:424
>  ip_list_rcv_finish.constprop.0+0x1b2/0x710 net/ipv4/ip_input.c:610
>  ip_sublist_rcv net/ipv4/ip_input.c:636 [inline]
>  ip_list_rcv+0x34a/0x460 net/ipv4/ip_input.c:670
>  __netif_receive_skb_list_ptype net/core/dev.c:5715 [inline]
>  __netif_receive_skb_list_core+0x536/0x900 net/core/dev.c:5762
>  __netif_receive_skb_list net/core/dev.c:5814 [inline]
>  netif_receive_skb_list_internal+0x77c/0xdc0 net/core/dev.c:5905
>  gro_normal_list include/net/gro.h:515 [inline]
>  gro_normal_list include/net/gro.h:511 [inline]
>  napi_complete_done+0x219/0x8c0 net/core/dev.c:6256
>  wg_packet_rx_poll+0xbff/0x1e40 drivers/net/wireguard/receive.c:488
>  __napi_poll.constprop.0+0xb3/0x530 net/core/dev.c:6877
>  napi_poll net/core/dev.c:6946 [inline]
>  net_rx_action+0x9eb/0xe30 net/core/dev.c:7068
>  handle_softirqs+0x1ac/0x740 kernel/softirq.c:554
>  do_softirq kernel/softirq.c:455 [inline]
>  do_softirq+0x48/0x80 kernel/softirq.c:442
>  </IRQ>
>  <TASK>
>  __local_bh_enable_ip+0xed/0x110 kernel/softirq.c:382
>  spin_unlock_bh include/linux/spinlock.h:396 [inline]
>  ptr_ring_consume_bh include/linux/ptr_ring.h:367 [inline]
>  wg_packet_decrypt_worker+0x3ba/0x580 drivers/net/wireguard/receive.c:499
>  process_one_work+0x940/0x1a70 kernel/workqueue.c:3229
>  process_scheduled_works kernel/workqueue.c:3310 [inline]
>  worker_thread+0x639/0xe30 kernel/workqueue.c:3391
>  kthread+0x283/0x350 kernel/kthread.c:389
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
>  </TASK>
> 
> Fixes: 82d9983ebeb8 ("net: ip: make ip_route_input_noref() return drop reasons")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/ipv4/route.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



