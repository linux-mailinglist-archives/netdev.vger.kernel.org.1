Return-Path: <netdev+bounces-154607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6479F9FEC47
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 03:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A27833A2832
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 02:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D4D14A4FF;
	Tue, 31 Dec 2024 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOTjf8WT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C5213C809;
	Tue, 31 Dec 2024 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735610408; cv=none; b=dlJWneB4BRykaasywFmZOnGT1Sls9uHJiJh5lTjYOjqh3d6dlBfNvtkbZ7rwsdCgUFuqszTv5oqy+SKUW4kFrrJdf2sZ+WPiBsTAHQWEjxVUv1v3/NkFmRWVNAPrShyW0DPAU9bX/GsA6RzVQZ0JJvOymNddGnBfAUBbMLjDdlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735610408; c=relaxed/simple;
	bh=A4Q/CE5/UTdB0SZ046JdZSHt6y5sFwv15kml4pSIDAc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lmf5wPgbt/AIS9CXeLaQCCjNHom27zRX67H1B1pkuFsncKfIZljReaeE53vU4gXT5uIPmn0MnUWEc+TrfVGRlTbgdgNnV+JD2RkcBm9RCwgFXqLVzrY0nfJkCN3PkItFAm7zAJ+RgZEEpNriM1+HNSKgQ5eNHwzUwBfiGQ31MFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOTjf8WT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0CBC4CED0;
	Tue, 31 Dec 2024 02:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735610408;
	bh=A4Q/CE5/UTdB0SZ046JdZSHt6y5sFwv15kml4pSIDAc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WOTjf8WTEBhZoCUE/20/U2+hlbqCG0MX5zHZTRSmUhP9JZKrOkiHS7z1vA4xLEmmv
	 wyl88ym8t5rfE9iE0pTBEtYMSph1uN5hmWygcWD5iNj/r2LsS4aVkabxa7h+vWDntt
	 8KB3DMDmPBXOujrQEHpyqMK+UzywiIteuX2muUymV+PreCAwxRV8ppaxMe6VEfqF3S
	 +8Fopz0yJbXtAxy38rEfDC4TM/i8YVGbK1IeKhdv8o2EaYC+lYMzgeoL1NJ+zsAHaQ
	 wnzME0CP+SEvC1hKOMAvzMkdxKoCo4MDn26NTimWuh9ttS3UTbz3RMlvQ5+1zTNhJj
	 ni06hpvHmCr7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEB3380A964;
	Tue, 31 Dec 2024 02:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mptcp: fix TCP options overflow.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173561042778.1486033.12049153922688425515.git-patchwork-notify@kernel.org>
Date: Tue, 31 Dec 2024 02:00:27 +0000
References: <025d9df8cde3c9a557befc47e9bc08fbbe3476e5.1734771049.git.pabeni@redhat.com>
In-Reply-To: <025d9df8cde3c9a557befc47e9bc08fbbe3476e5.1734771049.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, mptcp@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 21 Dec 2024 09:51:46 +0100 you wrote:
> Syzbot reported the following splat:
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> CPU: 1 UID: 0 PID: 5836 Comm: sshd Not tainted 6.13.0-rc3-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
> RIP: 0010:_compound_head include/linux/page-flags.h:242 [inline]
> RIP: 0010:put_page+0x23/0x260 include/linux/mm.h:1552
> Code: 90 90 90 90 90 90 90 55 41 57 41 56 53 49 89 fe 48 bd 00 00 00 00 00 fc ff df e8 f8 5e 12 f8 49 8d 5e 08 48 89 d8 48 c1 e8 03 <80> 3c 28 00 74 08 48 89 df e8 8f c7 78 f8 48 8b 1b 48 89 de 48 83
> RSP: 0000:ffffc90003916c90 EFLAGS: 00010202
> RAX: 0000000000000001 RBX: 0000000000000008 RCX: ffff888030458000
> RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: dffffc0000000000 R08: ffffffff898ca81d R09: 1ffff110054414ac
> R10: dffffc0000000000 R11: ffffed10054414ad R12: 0000000000000007
> R13: ffff88802a20a542 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007f34f496e800(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f9d6ec9ec28 CR3: 000000004d260000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  skb_page_unref include/linux/skbuff_ref.h:43 [inline]
>  __skb_frag_unref include/linux/skbuff_ref.h:56 [inline]
>  skb_release_data+0x483/0x8a0 net/core/skbuff.c:1119
>  skb_release_all net/core/skbuff.c:1190 [inline]
>  __kfree_skb+0x55/0x70 net/core/skbuff.c:1204
>  tcp_clean_rtx_queue net/ipv4/tcp_input.c:3436 [inline]
>  tcp_ack+0x2442/0x6bc0 net/ipv4/tcp_input.c:4032
>  tcp_rcv_state_process+0x8eb/0x44e0 net/ipv4/tcp_input.c:6805
>  tcp_v4_do_rcv+0x77d/0xc70 net/ipv4/tcp_ipv4.c:1939
>  tcp_v4_rcv+0x2dc0/0x37f0 net/ipv4/tcp_ipv4.c:2351
>  ip_protocol_deliver_rcu+0x22e/0x440 net/ipv4/ip_input.c:205
>  ip_local_deliver_finish+0x341/0x5f0 net/ipv4/ip_input.c:233
>  NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
>  NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
>  __netif_receive_skb_one_core net/core/dev.c:5672 [inline]
>  __netif_receive_skb+0x2bf/0x650 net/core/dev.c:5785
>  process_backlog+0x662/0x15b0 net/core/dev.c:6117
>  __napi_poll+0xcb/0x490 net/core/dev.c:6883
>  napi_poll net/core/dev.c:6952 [inline]
>  net_rx_action+0x89b/0x1240 net/core/dev.c:7074
>  handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
>  __do_softirq kernel/softirq.c:595 [inline]
>  invoke_softirq kernel/softirq.c:435 [inline]
>  __irq_exit_rcu+0xf7/0x220 kernel/softirq.c:662
>  irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
>  sysvec_apic_timer_interrupt+0x57/0xc0 arch/x86/kernel/apic/apic.c:1049
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
> RIP: 0033:0x7f34f4519ad5
> Code: 85 d2 74 0d 0f 10 02 48 8d 54 24 20 0f 11 44 24 20 64 8b 04 25 18 00 00 00 85 c0 75 27 41 b8 08 00 00 00 b8 0f 01 00 00 0f 05 <48> 3d 00 f0 ff ff 76 75 48 8b 15 24 73 0d 00 f7 d8 64 89 02 48 83
> RSP: 002b:00007ffec5b32ce0 EFLAGS: 00000246
> RAX: 0000000000000001 RBX: 00000000000668a0 RCX: 00007f34f4519ad5
> RDX: 00007ffec5b32d00 RSI: 0000000000000004 RDI: 0000564f4bc6cae0
> RBP: 0000564f4bc6b5a0 R08: 0000000000000008 R09: 0000000000000000
> R10: 00007ffec5b32de8 R11: 0000000000000246 R12: 0000564f48ea8aa4
> R13: 0000000000000001 R14: 0000564f48ea93e8 R15: 00007ffec5b32d68
>  </TASK>
> 
> [...]

Here is the summary with links:
  - [net] mptcp: fix TCP options overflow.
    https://git.kernel.org/netdev/net/c/cbb26f7d8451

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



