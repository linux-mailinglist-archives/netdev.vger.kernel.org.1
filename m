Return-Path: <netdev+bounces-120270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0252F958BF0
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 18:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853881F2356B
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 16:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDBF197512;
	Tue, 20 Aug 2024 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pqHa9hmD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CB773176
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724170144; cv=none; b=rbacPfj2b8DPrJ2QvTzsZzX9Zz+tYfwp5senk2Tg0tQ0DykLV0MwlWnL7UXVn4qTTcEuttT89YokgEAej10A9G9isF6t88Ad20z98rTuhFhp/jrke5dDw0ioiV08Jivwri9aVWw/EwJo0XbflkLdfh1hX2nTfbOTTvGFzNSHViw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724170144; c=relaxed/simple;
	bh=yS1UHtxKu2vJvZldY7H0NQ3WDbNnEubzUtpgcSV5t28=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LBZa++JP2EgYwrpoAoEzSozDokkGQ8nhbTlFbspyXWiOUxF4JJtVP+LlTehWmX2yTIeOYE56NhHnRGI5QZZGKFZ+MUve23O6MPoOXa76/0oajreXGafvmiJN8VyXKCw3Wdb685zDOq/v9cRf5nxU4LASD9dUnRdPuqJR99+4nqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pqHa9hmD; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e164e64efb6so1717583276.3
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 09:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724170142; x=1724774942; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SnUUgkJ/RsB+uQyEP8JntMqtRgYYJBc8/3pB/5cqAv4=;
        b=pqHa9hmDsNshQulofO2nr/d77xS11w8KY5CLH+zMjxsai1hOVGox6Z16Z5JO945L8b
         x1RUnu4IcilDF2fCe645KHpfvkF9vw8D7eagWFDz0/jlmNeygvHXs7QLeTUtV/lRX0DC
         KJKFOyzLhEn9E0Y3rWhdNomKRDGuEnBOVAD6/mlfyihHepLySEI0aFsKLISwpJvTbhqH
         cDWoDdhZrVAd3QrFDlCsjrEvKesEoBl3+/WSi1RL4RnnTrDoOhxzvLysemmMm2QRYxnc
         NZ6RCDPlUrnxP5Qk16y93QKvoc7KEfhc+MaUU+UiLq1Z63pEBFwC9VQ7ASB9P/0ViJsd
         BW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724170142; x=1724774942;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SnUUgkJ/RsB+uQyEP8JntMqtRgYYJBc8/3pB/5cqAv4=;
        b=mI8i4+r8f7I4FjRD/95l0TcVwGclQU2nbsdeaqbkrOLT/N+avVo1K2KKPkvRqHoC37
         3sUl/qMImEApZ+tTBFXYjrHupnN9qLrkivb+KHjIM6wsVO0XPQ6qmIVWPRuXog5UoKO5
         ebevEHdtI42UhVAnyPotUFPZEjxR8dAtFQnxNAGKV45xeSXzOWkmeGz5svHz55HOo490
         81JTPIbmQtRaVUpOMm/c07GWRih/R+yFsQnchTvMpjWXR63/jxzjY82Q0SaRaPd8Zg5u
         LsHU2U7Npk5ZyaRy+aAOSGjZuiQ7KHNOKDzX3K2e78btaPIpAuYBucM6zWg41PxOW4r2
         m1qA==
X-Forwarded-Encrypted: i=1; AJvYcCU1qwOk9SSL6x3Bo71bZEKDM6+UEW3J6dhlkh7TurkA5+o9DxspMQ5xU6Zt1BD7kMnGN+E2YqduRQSQhNW+Qqjug4V5vubI
X-Gm-Message-State: AOJu0YzelcWwRxJnWEGvAOD9Qoy0F4Hu56rh7LDXyd2WZ7ffYa/aE1Oe
	HpFF1yuPJG0KrJsgwkY3FeJfS6E6fNGOMrDG6JgwptSPmmVytPqkR37hMx0539WuH5oweNAzhrM
	rm1fWVVcUNA==
X-Google-Smtp-Source: AGHT+IGbmtG7uoiV8kQRBcgvgVk7quhRDx0eaLkiSVBZ7hbTTbCuPeM6VeV+avGjla6i2RfhLXE0/sKOUHXoZg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:bccd:0:b0:e0b:f1fd:1375 with SMTP id
 3f1490d57ef6-e1180f732a0mr29064276.10.1724170141865; Tue, 20 Aug 2024
 09:09:01 -0700 (PDT)
Date: Tue, 20 Aug 2024 16:08:57 +0000
In-Reply-To: <20240820160859.3786976-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240820160859.3786976-1-edumazet@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240820160859.3786976-2-edumazet@google.com>
Subject: [PATCH v2 net 1/3] ipv6: prevent UAF in ip6_send_skb()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

syzbot reported an UAF in ip6_send_skb() [1]

After ip6_local_out() has returned, we no longer can safely
dereference rt, unless we hold rcu_read_lock().

A similar issue has been fixed in commit
a688caa34beb ("ipv6: take rcu lock in rawv6_send_hdrinc()")

Another potential issue in ip6_finish_output2() is handled in a
separate patch.

[1]
 BUG: KASAN: slab-use-after-free in ip6_send_skb+0x18d/0x230 net/ipv6/ip6_output.c:1964
Read of size 8 at addr ffff88806dde4858 by task syz.1.380/6530

CPU: 1 UID: 0 PID: 6530 Comm: syz.1.380 Not tainted 6.11.0-rc3-syzkaller-00306-gdf6cbc62cc9b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
  __dump_stack lib/dump_stack.c:93 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
  print_address_description mm/kasan/report.c:377 [inline]
  print_report+0x169/0x550 mm/kasan/report.c:488
  kasan_report+0x143/0x180 mm/kasan/report.c:601
  ip6_send_skb+0x18d/0x230 net/ipv6/ip6_output.c:1964
  rawv6_push_pending_frames+0x75c/0x9e0 net/ipv6/raw.c:588
  rawv6_sendmsg+0x19c7/0x23c0 net/ipv6/raw.c:926
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg+0x1a6/0x270 net/socket.c:745
  sock_write_iter+0x2dd/0x400 net/socket.c:1160
 do_iter_readv_writev+0x60a/0x890
  vfs_writev+0x37c/0xbb0 fs/read_write.c:971
  do_writev+0x1b1/0x350 fs/read_write.c:1018
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f936bf79e79
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f936cd7f038 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007f936c115f80 RCX: 00007f936bf79e79
RDX: 0000000000000001 RSI: 0000000020000040 RDI: 0000000000000004
RBP: 00007f936bfe7916 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f936c115f80 R15: 00007fff2860a7a8
 </TASK>

Allocated by task 6530:
  kasan_save_stack mm/kasan/common.c:47 [inline]
  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
  unpoison_slab_object mm/kasan/common.c:312 [inline]
  __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
  kasan_slab_alloc include/linux/kasan.h:201 [inline]
  slab_post_alloc_hook mm/slub.c:3988 [inline]
  slab_alloc_node mm/slub.c:4037 [inline]
  kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4044
  dst_alloc+0x12b/0x190 net/core/dst.c:89
  ip6_blackhole_route+0x59/0x340 net/ipv6/route.c:2670
  make_blackhole net/xfrm/xfrm_policy.c:3120 [inline]
  xfrm_lookup_route+0xd1/0x1c0 net/xfrm/xfrm_policy.c:3313
  ip6_dst_lookup_flow+0x13e/0x180 net/ipv6/ip6_output.c:1257
  rawv6_sendmsg+0x1283/0x23c0 net/ipv6/raw.c:898
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg+0x1a6/0x270 net/socket.c:745
  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
  ___sys_sendmsg net/socket.c:2651 [inline]
  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 45:
  kasan_save_stack mm/kasan/common.c:47 [inline]
  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
  poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
  __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
  kasan_slab_free include/linux/kasan.h:184 [inline]
  slab_free_hook mm/slub.c:2252 [inline]
  slab_free mm/slub.c:4473 [inline]
  kmem_cache_free+0x145/0x350 mm/slub.c:4548
  dst_destroy+0x2ac/0x460 net/core/dst.c:124
  rcu_do_batch kernel/rcu/tree.c:2569 [inline]
  rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2843
  handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
  __do_softirq kernel/softirq.c:588 [inline]
  invoke_softirq kernel/softirq.c:428 [inline]
  __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
  irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Last potentially related work creation:
  kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
  __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
  __call_rcu_common kernel/rcu/tree.c:3106 [inline]
  call_rcu+0x167/0xa70 kernel/rcu/tree.c:3210
  refdst_drop include/net/dst.h:263 [inline]
  skb_dst_drop include/net/dst.h:275 [inline]
  nf_ct_frag6_queue net/ipv6/netfilter/nf_conntrack_reasm.c:306 [inline]
  nf_ct_frag6_gather+0xb9a/0x2080 net/ipv6/netfilter/nf_conntrack_reasm.c:485
  ipv6_defrag+0x2c8/0x3c0 net/ipv6/netfilter/nf_defrag_ipv6_hooks.c:67
  nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
  nf_hook_slow+0xc3/0x220 net/netfilter/core.c:626
  nf_hook include/linux/netfilter.h:269 [inline]
  __ip6_local_out+0x6fa/0x800 net/ipv6/output_core.c:143
  ip6_local_out+0x26/0x70 net/ipv6/output_core.c:153
  ip6_send_skb+0x112/0x230 net/ipv6/ip6_output.c:1959
  rawv6_push_pending_frames+0x75c/0x9e0 net/ipv6/raw.c:588
  rawv6_sendmsg+0x19c7/0x23c0 net/ipv6/raw.c:926
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg+0x1a6/0x270 net/socket.c:745
  sock_write_iter+0x2dd/0x400 net/socket.c:1160
 do_iter_readv_writev+0x60a/0x890

Fixes: 0625491493d9 ("ipv6: ip6_push_pending_frames() should increment IPSTATS_MIB_OUTDISCARDS")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
---
 net/ipv6/ip6_output.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index ab504d31f0cdd8dec9ab01bf9d6e6517307609cd..f7b53effc80f8b3b7a839f58097d021a11f9eb37 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1956,6 +1956,7 @@ int ip6_send_skb(struct sk_buff *skb)
 	struct rt6_info *rt = dst_rt6_info(skb_dst(skb));
 	int err;
 
+	rcu_read_lock();
 	err = ip6_local_out(net, skb->sk, skb);
 	if (err) {
 		if (err > 0)
@@ -1965,6 +1966,7 @@ int ip6_send_skb(struct sk_buff *skb)
 				      IPSTATS_MIB_OUTDISCARDS);
 	}
 
+	rcu_read_unlock();
 	return err;
 }
 
-- 
2.46.0.184.g6999bdac58-goog


