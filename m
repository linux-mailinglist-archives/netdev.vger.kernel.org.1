Return-Path: <netdev+bounces-307093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CMSJJ8GnVGqdowMAu9opvQ
	(envelope-from <netdev+bounces-307093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:54:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED37748FA8
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:54:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=igLx1xnn;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307093-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307093-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCF54300B752
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F343D16E4;
	Mon, 13 Jul 2026 08:52:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350E63BAD8B
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 08:52:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932770; cv=none; b=bWstrZqHmYrySQPl0Yt0Sv99xkBNGr1UJOWNoq/zunrwhzYuZIUwWm7FaJlsOSVdTWl1B+hEOpHH1no9LeUf+bM8fMa3+Vm9/QdFxDXyMTAnRpY8+vnj/Vf5745hgCFFxWYMfJz/RYITyhUdv+mymG8m3NbAsQdWXy2EaMGJ1aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932770; c=relaxed/simple;
	bh=6rvioedNBTEB3PBxXXS++vKMDR68BNwiCDKtRCum7pI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=huxFxDUyx63hs9sQnH870WTbQ2UDWpbw77aoIrs/zWRGoNiYDn8z5YUkO0JX/0uxYDs5FRfOI7hmSoDblr30zJ0a8QPoBTI2tz/cP7T9MqTI1SVOAy3azpBzs6EdW1Jrz9vCtCLIOdTxBvpxEGV9DiyH60MJYcheBjiZ478wSa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igLx1xnn; arc=none smtp.client-ip=209.85.210.179
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84a2c90e383so668928b3a.0
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 01:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783932768; x=1784537568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x3i+DDM+54YlY3n4/KNzY8tR39ipSHlzZnYMl0EYX68=;
        b=igLx1xnn4CHqHIOfkEOOM1SsmX4Dh4mWn/FtFKkbsMSkBUFMlAeekL6d+qQBW4HQZT
         LzKBCBX+87rFHUejcQtCYgRynlHTn7mKK/jICYCdKzA713oIMep+1m5TZf7k9mFbaPdR
         NDDDNy5lqz6YET7fiIJvEGGQP1RfoSZSRKhfTbQvBGZZo0YGARIbM7GTlaEMA/6YtcQl
         SycgFXxYuQizm3sOOAncc/pRZQnH0saP3+xEQAApX0UdxhLCZeDtV3onDC9doXtAHQTX
         TiFUoSIzzo6prTKqstpn17q2jm8a9p08A/FxKWXBcuF0V60P9vhOZBiqjboSXOsGGqy9
         LSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783932768; x=1784537568;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x3i+DDM+54YlY3n4/KNzY8tR39ipSHlzZnYMl0EYX68=;
        b=ZbcE9bf+sZtEYudua5hdQ5bAortqsk0L4OICBnOWw2SNRPY5ZbO5yQW/Fd1Qn/X4Hm
         OYp6c/TyjXl7gcLoIMuBE50AHMMBLqoLiDYVrr1eaPKm0c4buGQX6p76i1hvzhnDxzBF
         Q6IsYCOkW0XUnKxbyhg9qhJZh877jwSdweV3s55X4BLF+bTZmQtLWGetayBZ+wa8T8gu
         eNdOSNXB/+ecOHrWb4og9VsiroDCCEUU9QJKwDKfIWlghWVdqLeAcGVpFT9WkGzhcKMx
         NMtfDjkJM7+c8QQdJSRwTvpHIl5Ye3UqzesvV4sNKJ9xLLfEUOxDuT8Hr0W1sm0reFcQ
         E1pA==
X-Gm-Message-State: AOJu0YwD04T4KJyaicS4G7FYq9hfbKIEyIlTTwtMbyvt9hf1tDK4cUjd
	BoQQO37CupgmzHptgqcfhheNvOzrvKOGyuQggDEikSY2becCHVRpsX7K
X-Gm-Gg: AfdE7cnrKp016EB+mFfr22U2SqK8lY3q+EQJ2/8bsbLMZCf18YLIMhiiby9YLwLJ5i+
	Pqw9XYaXA/aEkaj0bfDjfGSmbFKqXV5PiIiP4ZkBDUovWXXZle/Ag0nH1Eyl7+HUhsT8WfqpBBq
	sCK/9q7squ1VohDdimBzzxCG7xphG8cc0OaqiXTL3Qn2l5tyffFmlPLRIIQSWuZGZ+mXbxP5Bus
	LwGvKJnmD4jMK7XjWyB1oO9cP1UD49/WfqzNgqoIhH09liD6np/6PG+IN4nFHXVbXX5lUD/5DNm
	1KWKrR5AuKqvTGS7csUhlHjtpr1+rt0hyt+2UN/1HQs/8d7odjPXmzV9dJQyVg6+IdUpExlrVxC
	jek0kdfS4tW/E7ZhKDxXczcm24gm0IDkEOF/r46y772rSrNKdAfyDXnhM/HJHW2YqlyTegbHtii
	5UbCMH7bIuO6iFsRyqB0Tr0A==
X-Received: by 2002:a05:6a20:734f:b0:3bf:6763:f0d0 with SMTP id adf61e73a8af0-3c0f085657fmr14896363637.4.1783932768352;
        Mon, 13 Jul 2026 01:52:48 -0700 (PDT)
Received: from gmail.com ([159.226.43.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5acedb5b3sm8499523a12.0.2026.07.13.01.52.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 01:52:47 -0700 (PDT)
From: Yue Sun <samsun1006219@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com
Subject: [Bug]KASAN: slab-use-after-free Read in tcp_sync_mss
Date: Mon, 13 Jul 2026 16:52:05 +0800
Message-ID: <20260713085238.16780-1-samsun1006219@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307093-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[samsun1006219@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzkaller@googlegroups.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[samsun1006219@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0ED37748FA8

Hello,

We encountered a slab-use-after-free read in tcp_sync_mss() on
7.2.0-rc1-g7558af35077a (upstream parent 7404ce516372).  We checked
the latest mainline commit, a13c140cc289 (Linux 7.2-rc3), and
confirmed that the root cause is still present.

Original KASAN report
=====================
==================================================================
BUG: KASAN: slab-use-after-free in __tcp_mtu_to_mss net/ipv4/tcp_output.c:2005 [inline]
BUG: KASAN: slab-use-after-free in tcp_mtu_to_mss net/ipv4/tcp_output.c:2024 [inline]
BUG: KASAN: slab-use-after-free in tcp_sync_mss+0x560/0x610 net/ipv4/tcp_output.c:2088
Read of size 2 at addr ff11000047600bb8 by task kworker/u8:2/37

CPU: 1 UID: 0 PID: 37 Comm: kworker/u8:2 Tainted: G             L      7.2.0-rc1-g7558af35077a #48 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: krdsd rds_tcp_accept_worker
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xf1/0x5c0 mm/kasan/report.c:482
 kasan_report+0xca/0x100 mm/kasan/report.c:595
 __tcp_mtu_to_mss net/ipv4/tcp_output.c:2005 [inline]
 tcp_mtu_to_mss net/ipv4/tcp_output.c:2024 [inline]
 tcp_sync_mss+0x560/0x610 net/ipv4/tcp_output.c:2088
 tcp_ack_update_window net/ipv4/tcp_input.c:3979 [inline]
 tcp_ack+0x4b35/0x6e80 net/ipv4/tcp_input.c:4336
 tcp_rcv_state_process+0xf30/0x7270 net/ipv4/tcp_input.c:7201
 tcp_v4_do_rcv+0x7ec/0x12b0 net/ipv4/tcp_ipv4.c:1873
 tcp_v4_rcv+0x2d30/0x4800 net/ipv4/tcp_ipv4.c:2245
 ip_protocol_deliver_rcu+0xba/0x4d0 net/ipv4/ip_input.c:207
 ip_local_deliver_finish+0x3ce/0x710 net/ipv4/ip_input.c:241
 NF_HOOK include/linux/netfilter.h:318 [inline]
 NF_HOOK include/linux/netfilter.h:312 [inline]
 ip_local_deliver+0x19a/0x200 net/ipv4/ip_input.c:262
 dst_input include/net/dst.h:480 [inline]
 ip_rcv_finish net/ipv4/ip_input.c:492 [inline]
 NF_HOOK include/linux/netfilter.h:318 [inline]
 NF_HOOK include/linux/netfilter.h:312 [inline]
 ip_rcv+0x327/0x3d0 net/ipv4/ip_input.c:612
 __netif_receive_skb_one_core+0x199/0x1e0 net/core/dev.c:6206
 __netif_receive_skb+0x1d/0x160 net/core/dev.c:6319
 process_backlog+0x382/0x1540 net/core/dev.c:6670
 __napi_poll.constprop.0+0xb3/0x540 net/core/dev.c:7729
 napi_poll net/core/dev.c:7792 [inline]
 net_rx_action+0x9b1/0xea0 net/core/dev.c:7949
 handle_softirqs+0x1d4/0x980 kernel/softirq.c:622
 do_softirq kernel/softirq.c:523 [inline]
 do_softirq+0xac/0xe0 kernel/softirq.c:510
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x100/0x120 kernel/softirq.c:450
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:914 [inline]
 __dev_queue_xmit+0xe25/0x4300 net/core/dev.c:4907
 dev_queue_xmit include/linux/netdevice.h:3446 [inline]
 neigh_hh_output include/net/neighbour.h:544 [inline]
 neigh_output include/net/neighbour.h:558 [inline]
 ip_finish_output2+0xc52/0x1ea0 net/ipv4/ip_output.c:236
 __ip_finish_output.part.0+0x1bb/0x350 net/ipv4/ip_output.c:314
 __ip_finish_output net/ipv4/ip_output.c:302 [inline]
 ip_finish_output net/ipv4/ip_output.c:324 [inline]
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip_output+0x376/0x860 net/ipv4/ip_output.c:437
 dst_output include/net/dst.h:470 [inline]
 ip_local_out+0x1b4/0x200 net/ipv4/ip_output.c:131
 __ip_queue_xmit+0x773/0x1a90 net/ipv4/ip_output.c:533
 __tcp_transmit_skb+0x36b1/0x5080 net/ipv4/tcp_output.c:1716
 tcp_transmit_skb net/ipv4/tcp_output.c:1734 [inline]
 tcp_write_xmit+0x1876/0x7dd0 net/ipv4/tcp_output.c:3062
 __tcp_push_pending_frames+0xb0/0x3c0 net/ipv4/tcp_output.c:3245
 tcp_send_fin+0x11f/0x10d0 net/ipv4/tcp_output.c:3844
 __tcp_close+0xa27/0x10f0 net/ipv4/tcp.c:3220
 tcp_close+0x28/0x110 net/ipv4/tcp.c:3311
 inet_release+0xed/0x200 net/ipv4/af_inet.c:442
 inet6_release+0x50/0x80 net/ipv6/af_inet6.c:472
 __sock_release net/socket.c:710 [inline]
 sock_release+0x91/0x1d0 net/socket.c:738
 rds_tcp_accept_one+0x246/0xf10 net/rds/tcp_listen.c:341
 rds_tcp_accept_worker+0x41/0x60 net/rds/tcp.c:552
 process_one_work+0xce3/0x2210 kernel/workqueue.c:3619
 process_scheduled_works kernel/workqueue.c:3728 [inline]
 worker_thread+0x693/0xeb0 kernel/workqueue.c:3809
 kthread+0x38d/0x4a0 kernel/kthread.c:436
 ret_from_fork+0xb09/0xdb0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 46228:
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x87/0x90 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4612 [inline]
 slab_alloc_node mm/slub.c:4945 [inline]
 kmem_cache_alloc_noprof+0x244/0x690 mm/slub.c:4959
 sk_prot_alloc+0x5f/0x290 net/core/sock.c:2246
 sk_alloc+0x36/0xe10 net/core/sock.c:2308
 smc_sock_alloc net/smc/af_smc.c:428 [inline]
 smc_create+0x125/0x320 net/smc/af_smc.c:3389
 __sock_create+0x382/0x8e0 net/socket.c:1651
 sock_create net/socket.c:1709 [inline]
 __sys_socket_create net/socket.c:1746 [inline]
 __sys_socket_create net/socket.c:1731 [inline]
 __sys_socket+0x145/0x260 net/socket.c:1793
 __do_sys_socket net/socket.c:1807 [inline]
 __se_sys_socket net/socket.c:1805 [inline]
 __x64_sys_socket+0x72/0xb0 net/socket.c:1805
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x11f/0x860 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 15:
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x61/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2705 [inline]
 slab_free_after_rcu_debug+0x105/0x2b0 mm/slub.c:6467
 rcu_do_batch kernel/rcu/tree.c:2645 [inline]
 rcu_core+0x59e/0x1130 kernel/rcu/tree.c:2897
 handle_softirqs+0x1d4/0x980 kernel/softirq.c:622
 run_ksoftirqd kernel/softirq.c:1076 [inline]
 run_ksoftirqd+0x3a/0x60 kernel/softirq.c:1068
 smpboot_thread_fn+0x3d4/0xaa0 kernel/smpboot.c:160
 kthread+0x38d/0x4a0 kernel/kthread.c:436
 ret_from_fork+0xb09/0xdb0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:57
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:556
 slab_free_hook mm/slub.c:2666 [inline]
 slab_free mm/slub.c:6405 [inline]
 kmem_cache_free+0x438/0x720 mm/slub.c:6532
 sk_prot_free net/core/sock.c:2289 [inline]
 __sk_destruct+0x62d/0xab0 net/core/sock.c:2391
 sk_destruct+0xc1/0xe0 net/core/sock.c:2419
 __sk_free+0xf2/0x3e0 net/core/sock.c:2430
 sk_free+0x6a/0x90 net/core/sock.c:2441
 sock_put include/net/sock.h:2020 [inline]
 smc_release+0x41d/0x620 net/smc/af_smc.c:369
 __sock_release+0xb3/0x270 net/socket.c:710
 sock_close+0x1c/0x30 net/socket.c:1501
 __fput+0x402/0xb60 fs/file_table.c:512
 task_work_run+0x16b/0x260 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
 exit_to_user_mode_loop+0x1de/0x5f0 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x737/0x860 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ff11000047600000
 which belongs to the cache SMC of size 3216
The buggy address is located 3000 bytes inside of
 freed 3216-byte region [ff11000047600000, ff11000047600c90)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xff11000047604f80 pfn:0x47600
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ff11000047607741
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ff11000020a6a780 ff11000020a68708 ffd4000001aa4a10
raw: ff11000047604f80 0000000800090006 00000000f5000000 ff11000047607741
head: 00fff00000000240 ff11000020a6a780 ff11000020a68708 ffd4000001aa4a10
head: ff11000047604f80 0000000800090006 00000000f5000000 ff11000047607741
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 13226, tgid 13219 (syz.0.27), ts 78395568066, free_ts 78097920902
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xff/0x130 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0xe82/0x2bf0 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x27b/0x2a00 mm/page_alloc.c:5304
 alloc_slab_page mm/slub.c:3294 [inline]
 allocate_slab mm/slub.c:3408 [inline]
 new_slab+0xad/0x610 mm/slub.c:3454
 refill_objects+0x10e/0x3d0 mm/slub.c:7338
 refill_sheaf mm/slub.c:2832 [inline]
 __pcs_replace_empty_main+0x352/0x670 mm/slub.c:4703
 alloc_from_pcs mm/slub.c:4801 [inline]
 slab_alloc_node mm/slub.c:4933 [inline]
 kmem_cache_alloc_noprof+0x550/0x690 mm/slub.c:4959
 sk_prot_alloc+0x5f/0x290 net/core/sock.c:2246
 sk_alloc+0x36/0xe10 net/core/sock.c:2308
 smc_sock_alloc net/smc/af_smc.c:428 [inline]
 smc_create+0x125/0x320 net/smc/af_smc.c:3389
 __sock_create+0x382/0x8e0 net/socket.c:1651
 sock_create net/socket.c:1709 [inline]
 __sys_socket_create net/socket.c:1746 [inline]
 __sys_socket_create net/socket.c:1731 [inline]
 __sys_socket+0x145/0x260 net/socket.c:1793
 __do_sys_socket net/socket.c:1807 [inline]
 __se_sys_socket net/socket.c:1805 [inline]
 __x64_sys_socket+0x72/0xb0 net/socket.c:1805
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x11f/0x860 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 790 tgid 790 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 free_pages_prepare+0x54b/0xd20 mm/page_alloc.c:1451
 __free_contig_range_common+0x165/0x240 mm/page_alloc.c:6897
 __free_contig_range mm/page_alloc.c:6942 [inline]
 free_pages_bulk+0x125/0x1a0 mm/page_alloc.c:5257
 vm_area_free_pages+0x17c/0x290 mm/vmalloc.c:3439
 vfree+0x125/0x780 mm/vmalloc.c:3488
 delayed_vfree_work+0x57/0x70 mm/vmalloc.c:3392
 process_one_work+0xce3/0x2210 kernel/workqueue.c:3619
 process_scheduled_works kernel/workqueue.c:3728 [inline]
 worker_thread+0x693/0xeb0 kernel/workqueue.c:3809
 kthread+0x38d/0x4a0 kernel/kthread.c:436
 ret_from_fork+0xb09/0xdb0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ff11000047600a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ff11000047600b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ff11000047600b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ff11000047600c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ff11000047600c80: fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

Root cause
==========

The KASAN report places the invalid read 3000 bytes into a freed
3216-byte struct smc_sock.  In the crashing build:

  offsetof(struct smc_sock, af_ops) = 2992
  offsetof(struct inet_connection_sock_af_ops, net_header_len) = 8

Their sum is 3000, so the invalid two-byte read is precisely
smc->af_ops.net_header_len.  This matches __tcp_mtu_to_mss():

  mss_now = pmtu - icsk->icsk_af_ops->net_header_len -
            sizeof(struct tcphdr);

smc_listen() replaces the underlying TCP socket's icsk_af_ops with an
operations structure embedded in the SMC socket before calling
kernel_listen():

  smc->ori_af_ops = inet_csk(smc->clcsock->sk)->icsk_af_ops;
  smc->af_ops = *smc->ori_af_ops;
  smc->af_ops.syn_recv_sock = smc_tcp_syn_recv_sock;
  inet_csk(smc->clcsock->sk)->icsk_af_ops = &smc->af_ops;

  rc = kernel_listen(smc->clcsock, backlog);
  if (rc) {
          smc_clcsock_restore_cb(...);
          rcu_assign_sk_user_data(smc->clcsock->sk, NULL);
          goto out;
  }

When kernel_listen() fails, the error path restores sk_data_ready and
sk_user_data but does not restore icsk_af_ops.  Closing the SMC socket
can therefore free the smc_sock while its TCP clcsock still contains
an icsk_af_ops pointer into that object.  Later TCP receive processing
dereferences the stale pointer in tcp_sync_mss().

The triggering program uses an AF_SMC socket, sends with MSG_FASTOPEN,
then calls listen().  MSG_FASTOPEN switches SMC to TCP fallback and
starts activity on the underlying TCP socket; kernel_listen() then
fails, leaving the stale pointer installed.  The same missing restore
is still present in smc_listen() at a13c140cc289.

The error path should restore the original pointer before returning:

  inet_csk(smc->clcsock->sk)->icsk_af_ops = smc->ori_af_ops;

This may be related to the issue discussed in:
https://lore.kernel.org/netdev/tencent_BD4B709F8D16281265EDBC0DC9EFC8758808@qq.com/

Thanks,
--
Yue Sun

