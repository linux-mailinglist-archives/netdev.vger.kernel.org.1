Return-Path: <netdev+bounces-244012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8296FCAD49D
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 14:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB24D3004C86
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 13:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A752D7DFF;
	Mon,  8 Dec 2025 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YGUE3Yjp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062262D238F
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765201056; cv=none; b=BVIgbJ9W74TnYV4af5RWnmSU+lzs/Ssj5E91U/hiLEZuKT4RLSPm/bahqrrrfMg6MbXhs71UJFBaSJxohS2i/P5g8OHzHehDSy11+uPeY/QH5fWaxHh9fWJtkXM3C8UYwE7+gql/2DS1jY0tSbAx5/lxIzZgFhtqL5YTaa1F2Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765201056; c=relaxed/simple;
	bh=lsmPXrbd9+W/SP01sUs9w5FHwoZy6/iftvWgrBj00rI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T7/P9vJ2w9qs6a2NmRSOEYrhpZr+JIb2wLk65mpWBrXSyyWeafwXWwrHQQmO90D/udyWwbC03RO5nF1gcZHHiiBLeo9G6MX20XhqwjTIXgg6JLdvbYp3dJdFG0NGgNQdAEDTa0hv5BDivhiQV7IeTDagyPr+LT7w2cko1Q54how=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YGUE3Yjp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297e5a18652so52872065ad.1
        for <netdev@vger.kernel.org>; Mon, 08 Dec 2025 05:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765201054; x=1765805854; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nDVqQ5FBgbhpbi6FDWMgirH+scpjVk4YfaeF8G5tWcs=;
        b=YGUE3YjpHBNWZ9Hoj9tXTqgSRq5LuaRY225Ktw299eSADZra7BbKuE9mVnev5CM4Dt
         w31CND/GvlB5FwY6YKPAzugMjLeN6GO5ZjYsl3hGVJl9O4LViqr7eDb4BdMrhJ/DR3ad
         g+gKzuys0rUTvsWyogkUDjJHT5xF49ZzvQWpoYtGpzYJOGzKLdzvACBwPLN95KSm5KKe
         zYu3ek4Cl2HqoKJfbV8J6DtIei6M3RhyBFlCq2E29Fbit+sciZdSgnbgOE3Q9wfJjX5u
         w6bJ8p1eqlXDG21kMbeiYZNhdnzW2B/mUqTZwyD1sWrj6LX4uOx9lN3xiSFt1eTCttu4
         VksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765201054; x=1765805854;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nDVqQ5FBgbhpbi6FDWMgirH+scpjVk4YfaeF8G5tWcs=;
        b=wUQ8bZm4oFrja4x35nkJ0rTfRowcZDh4k19vqfxHjLBm0s/AqUpj64G/MxRnjlz+j5
         eo57i1st+MW8Y2h3KjZuITsGSI5tRXQpibfK90t69gh1UQMMGPYCS2TrfBU63hwL1r45
         o41gX/9TgjQkzpQMcHPjxUEDrTPZYjzYPfLJhv/jMEF29Tev3xsPrpTKUsjPjcGPAjfi
         fwVdXBiG7/5FajP1V17N5//MfzwTogATGnLdfX/c5oKGM9nNVDdvnU4RoLkb+SV/Dg4i
         VXWUXFP6qJu5H7nLWoSkHJMuN4n5VctxVy8z6MhunIcbUsGRi3zXMPf7XYXqpT72xDF2
         S0MA==
X-Forwarded-Encrypted: i=1; AJvYcCVCXzI+a45+xCpGdNYtKsTx8RLXbMB9+WcwlVn3kuqF2PeVZCLBcFqlA8rjAR2i2hNFmWsBokQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Mcje4SV9CL4NMAvcSFOPzlGR3wDpjaITh+ltheCyXOAa2iXP
	Sw1zLYMtj6y6clfGtd1olzq/xfGH9tm/zARDgil6aISC06yz5trgnINjwhAN0uMCeJ4xcoO5iTg
	bmDxAhQ==
X-Google-Smtp-Source: AGHT+IHZAvV2vaA17LxNQzZq8bd6pn3hmyB4c4YwwFKbanFHxDMj00ilwU88+DCRaUc9Q9RpEQTygIVclz4=
X-Received: from plbkj11.prod.google.com ([2002:a17:903:6cb:b0:297:d802:955d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:914c:b0:366:14b0:4b04
 with SMTP id adf61e73a8af0-3661802f2c2mr7568293637.64.1765201054143; Mon, 08
 Dec 2025 05:37:34 -0800 (PST)
Date: Mon,  8 Dec 2025 13:36:57 +0000
In-Reply-To: <20251208133728.157648-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251208133728.157648-1-kuniyu@google.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251208133728.157648-3-kuniyu@google.com>
Subject: [PATCH v1 net 2/2] sctp: Clear pktoptions and rxpmtu in sctp_v6_copy_ip_options().
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

sctp_v6_copy_ip_options() only clones np->opt.

So, leaving pktoptions and rxpmtu results in double-free.

Let's clear the two fields in sctp_v6_copy_ip_options().

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
index 069b7e45d8bda..32f877ccd1380 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -493,6 +493,8 @@ static void sctp_v6_copy_ip_options(struct sock *sk, struct sock *newsk)
 	struct ipv6_txoptions *opt;
 
 	newnp = inet6_sk(newsk);
+	newnp->pktoptions = NULL;
+	newnp->rxpmtu = NULL;
 
 	rcu_read_lock();
 	opt = rcu_dereference(np->opt);
-- 
2.52.0.223.gf5cc29aaa4-goog


