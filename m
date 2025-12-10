Return-Path: <netdev+bounces-244203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 761FCCB25E9
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 09:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D59B30ADC59
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 08:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59763019A5;
	Wed, 10 Dec 2025 08:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PiN2gT8/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047F3301715
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 08:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765354337; cv=none; b=G9bVJ7esfowpxCaKXV4yytz/lcj1fYcmLNnl9bWj0sYZDFgs4JmSxjevynQWk7Kexkk/eGM8LyGYKNiueXbCT0D+RHSzUnsSkJcNxwMpbZXfbjAh9AQqgQQJiGXxW2BKMEIRcNrcOPpJ9lv0PkK6nAi08VlD2jkK7bdAtY5wI8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765354337; c=relaxed/simple;
	bh=KE6vKyJykXgqERU9oUSSm2PL2KTpPjQb3VNOfOkDyJ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eCDeArme6fSru2N+EXeagACRukXfMcM+VYlmrrDNo9LOw3EkVAZCRDvjoC/Z2VSdi4/izHo5F25g9b4YtqOZ1hRu1B7LNkB2puLl5tQXCsnXYu697LtltdEB/9PZwQylWemWpdOukEf0CZfKVxQldJseqrYMDsUsWIpICeP1sc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PiN2gT8/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-343e262230eso7381817a91.2
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 00:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765354334; x=1765959134; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8vHCHE3IGhbl2ADeua07wLDum4z/q/khwp1o+EHA+As=;
        b=PiN2gT8/OeEVp+d9W9Vg5FNGZm4CIoVuMs6bYqJk36T4TonMK2tZ+5VT+vvTsqw1f2
         wN3OxfieNVQqvy4AXy45eSGWJlQU6W+vK4hb9ww/S1EB70ZXx2l0JCyfwxu7nnRDm0vd
         IU/AcjrSZ5IDULe94WDCPS3UI+s1lJP5ZJZHHtrWHXQFTU6dERa1Jk0A6bSP9afz20Ii
         TxKGwdxLo+LjkIyv3XXDamarU8GwgW9gSjRJptsd8q7PYzf+tCZTJrU01rnt5tW16OVB
         gHy9sI4SffBRGFCwJTktjvtwpGh97T1VOOU8jD9bomz4Jt92xqofhQ2yqvn0uMzkPI/Y
         tZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765354334; x=1765959134;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8vHCHE3IGhbl2ADeua07wLDum4z/q/khwp1o+EHA+As=;
        b=acscYI4wQ/KHpYau/IfD4+1bb+ZG310TshneJJCV7Bre5n4TvZ0W5TmDCJEbi8qu87
         4nj0NU3kk/ncnReCxS2gyRBLPrGXLjTQaK4zyNOVjqe4J2Wi32+31uputVFJ6HYBfMFZ
         L2YWlSZ5bwNv4OIXSyBnzMl9Y5Ryudp/8nL4TZanDfDd3Hp4COUFvx8Xg0LMMkeQUa0j
         +M2roay6iYS0q4Ec+FrFq6TaLnGViDLylPI/y4XtpvQ6egr24RPPn9GQpJ85mkCNK9Yo
         +KmC8rFW7DK/Gi6vc1/OSyZTpmYPfI316WD2yFVyCDmE7lzFZ//PcTWi9kZTp3zVRMoJ
         Q5og==
X-Forwarded-Encrypted: i=1; AJvYcCUVuUJruQFw8TSN9/KHVZhhAZLfxj4XpZd4rqcD23g383Z3k7jmv8Usd9Xi1nogtz4FmePeooc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDfN02qiY8Zx/Y64ghYHACcrltN7HbQMUi/0xkHvXUFinE5+cW
	caw1AGSjmxNmbtKCj+hQKr1xjI9O5XryMaUccGG8gJhQB48Ay+5egX6sDiaTKtYLHvmA1BoLDDX
	+qltSlA==
X-Google-Smtp-Source: AGHT+IHjNLzWvC7USJUynwHR6Cv8OmsA/wNvOK0grRXb8vahy68BwO/kmoJi49jNXqgeaNmqwhqmCVGagCQ=
X-Received: from pgct3.prod.google.com ([2002:a05:6a02:5283:b0:bc7:14b7:890])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a127:b0:35d:2172:5ffb
 with SMTP id adf61e73a8af0-366e24507b7mr1639621637.47.1765354333699; Wed, 10
 Dec 2025 00:12:13 -0800 (PST)
Date: Wed, 10 Dec 2025 08:11:13 +0000
In-Reply-To: <20251210081206.1141086-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251210081206.1141086-1-kuniyu@google.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251210081206.1141086-3-kuniyu@google.com>
Subject: [PATCH v2 net 2/2] sctp: Clear inet_opt in sctp_v6_copy_ip_options().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+ec33a1a006ed5abe7309@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported the splat below. [0]

Since the cited commit, the child socket inherits all fields
of its parent socket unless explicitly cleared.

syzbot set IP_OPTIONS to AF_INET6 socket and created a child
socket inheriting inet_sk(sk)->inet_opt.

sctp_v6_copy_ip_options() only clones np->opt, and leaving
inet_opt results in double-free.

Let's clear inet_opt in sctp_v6_copy_ip_options().

[0]:
BUG: KASAN: double-free in inet_sock_destruct+0x538/0x740 net/ipv4/af_inet.c:159
Free of addr ffff8880304b6d40 by task ksoftirqd/0/15

CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report_invalid_free+0xea/0x110 mm/kasan/report.c:557
 check_slab_allocation+0xe1/0x130 include/linux/page-flags.h:-1
 kasan_slab_pre_free include/linux/kasan.h:198 [inline]
 slab_free_hook mm/slub.c:2484 [inline]
 slab_free mm/slub.c:6630 [inline]
 kfree+0x148/0x6d0 mm/slub.c:6837
 inet_sock_destruct+0x538/0x740 net/ipv4/af_inet.c:159
 __sk_destruct+0x89/0x660 net/core/sock.c:2350
 sock_put include/net/sock.h:1991 [inline]
 sctp_endpoint_destroy_rcu+0xa1/0xf0 net/sctp/endpointola.c:197
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xcab/0x1770 kernel/rcu/tree.c:2861
 handle_softirqs+0x286/0x870 kernel/softirq.c:622
 run_ksoftirqd+0x9b/0x100 kernel/softirq.c:1063
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 6003:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:417
 kasan_kmalloc include/linux/kasan.h:262 [inline]
 __do_kmalloc_node mm/slub.c:5642 [inline]
 __kmalloc_noprof+0x411/0x7f0 mm/slub.c:5654
 kmalloc_noprof include/linux/slab.h:961 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 ip_options_get+0x51/0x4c0 net/ipv4/ip_options.c:517
 do_ip_setsockopt+0x1d9b/0x2d00 net/ipv4/ip_sockglue.c:1087
 ip_setsockopt+0x66/0x110 net/ipv4/ip_sockglue.c:1417
 do_sock_setsockopt+0x17c/0x1b0 net/socket.c:2360
 __sys_setsockopt net/socket.c:2385 [inline]
 __do_sys_setsockopt net/socket.c:2391 [inline]
 __se_sys_setsockopt net/socket.c:2388 [inline]
 __x64_sys_setsockopt+0x13f/0x1b0 net/socket.c:2388
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 15:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 __kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2539 [inline]
 slab_free mm/slub.c:6630 [inline]
 kfree+0x19a/0x6d0 mm/slub.c:6837
 inet_sock_destruct+0x538/0x740 net/ipv4/af_inet.c:159
 __sk_destruct+0x89/0x660 net/core/sock.c:2350
 sock_put include/net/sock.h:1991 [inline]
 sctp_endpoint_destroy_rcu+0xa1/0xf0 net/sctp/endpointola.c:197
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xcab/0x1770 kernel/rcu/tree.c:2861
 handle_softirqs+0x286/0x870 kernel/softirq.c:622
 run_ksoftirqd+0x9b/0x100 kernel/softirq.c:1063
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Fixes: 16942cf4d3e31 ("sctp: Use sk_clone() in sctp_accept().")
Reported-by: syzbot+ec33a1a006ed5abe7309@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6936d112.a70a0220.38f243.00a8.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/sctp/ipv6.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 069b7e45d8bda..531cb0690007a 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -492,6 +492,8 @@ static void sctp_v6_copy_ip_options(struct sock *sk, struct sock *newsk)
 	struct ipv6_pinfo *newnp, *np = inet6_sk(sk);
 	struct ipv6_txoptions *opt;
 
+	inet_sk(newsk)->inet_opt = NULL;
+
 	newnp = inet6_sk(newsk);
 
 	rcu_read_lock();
-- 
2.52.0.223.gf5cc29aaa4-goog


