Return-Path: <netdev+bounces-238798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF472C5F84F
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 23:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B813B36A3
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 22:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4673F19D8A8;
	Fri, 14 Nov 2025 22:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a0A3gFCD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7028C35898
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 22:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763159500; cv=none; b=a/JIv9Ny23zphccdYkUqVpUp6s9yz0PqsrTEVTOF5XZX07+SlZaI8igbdkj9pjHcCI1agcojPBw/r86IF4aeOPzK3lUNFSOjEaxNC6P/0sd+Oelu9VwoJCU+AgWVmtPZG1sBPjnlaTGRgt5pN+ojRtYTVpouBdddLYmM9IhQ/ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763159500; c=relaxed/simple;
	bh=Ie+Cg2zzS6zLcsdlKDTQx0Jn3xbqxSYosjb+yuWDV/8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=j6Lpgc0CY5utiCLvKeXFqtzwB92YJvGH8ReSth3nWbUCK0ftnapVaUy504Grq9vZwcAS3xi1fuN4EZBwUzvw8EE9aORTs8V1+d8NGfwB5BiMLaXmzrXNPQ0hPY8ki5wUzGtsoONUwkFd+590Now6FOqNbWqMvuSZP32u1UrjZ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a0A3gFCD; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4ed5f5a2948so63354891cf.2
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 14:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763159497; x=1763764297; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZSYE5tglUSkbQNwjjzhpSr8SR6hBVLgOxzTFe+maUVc=;
        b=a0A3gFCDWUAKesfG8fc6O2K5gUCMSK5MO9OvuD9lFnHZ886sXew/P7PUVXH7W2pdAM
         puaWPuhPwKig2qc/0p7ESo5JIfthfK8hhvYu7YHB9I/2nK4MaMVhU0Q525J1EO9sOSzv
         4oED7CgP7I/JEyjK7E1TUvayPqTBI/5mxXFbcoGLfzxj/dF75xJG7zMBikppcMnvsWDq
         KpVHowjViAt/aESBp5ldv3AGUt+QHe93vLPhk3Z0R/SRLsvhqSK3IhUlaHpgQsQ+9Xm0
         qFJjDCXfLlZzX3+lkK7rV5idlizrK5Zqr95Qtq10qrUuHn+TriLUxDoyn6s60x9UdEvn
         GV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763159497; x=1763764297;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZSYE5tglUSkbQNwjjzhpSr8SR6hBVLgOxzTFe+maUVc=;
        b=HpYJQd3WtEJ6jXev0vfdL/YCfY0SXY1ms9LxVMknYDVQmdqKU41sE1XhFjT0yGVsMI
         dc+D1q/VUwwKISCDgM8+grw9J2j89tC0XEVOtSUi2I+bvuFX3LYPvYQdsriFFqGr6wGy
         YqI5pxuCRasg10LTT1/4u6GE5jpx3rF1kk3U4vi4He83Kb7RYVeWLm40FUw9XR5Fhgeh
         2iatclRR875mI5ud7f6l9xzdd2DXM+zqnVLPIn8CVubJHpomPXWpDSZZeGixvxh+Fo3/
         wvvx1F8CN2y6IoxJu+s3wcTrEQUXTg0oOjQsM08Yi0lXbbDIVa4XZZWZptbdS0FSMyYM
         zm6g==
X-Forwarded-Encrypted: i=1; AJvYcCUpLR1eXMzDcPJ1HOjn0fNH8XSAYdGfJwNDfHcMDUFA+EbSjbP/9+CLcnEwZfL2Yp+DidqVv+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0c87ed3oN+v5/GK3US7fCYfCv0BrJ9QN7NOYHcpjRkWHKHORM
	/Ta/qkuRvYHfXjcP3A+sAkByC1GEi9aUB4PQAmTOYKjR5v10yon5h3uYXZV4tDvE/tsKdvAds6R
	Hqm3MhU5hVUsh9g==
X-Google-Smtp-Source: AGHT+IE9GCC1DPwscGZBpKGI4Az8DX0Qpi316pXEgfFeE2NdP7ujHmZl1/HTCpr0smPSYHgC8JmBZ9gaQypqcA==
X-Received: from qvbrb8.prod.google.com ([2002:a05:6214:4e08:b0:882:4d92:8045])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:49:b0:4e2:ea31:1a with SMTP id d75a77b69052e-4edf212edd7mr77159231cf.68.1763159497220;
 Fri, 14 Nov 2025 14:31:37 -0800 (PST)
Date: Fri, 14 Nov 2025 22:31:36 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251114223136.113011-1-edumazet@google.com>
Subject: [PATCH net] mptcp: fix a race in mptcp_pm_del_add_timer()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang.tang@linux.dev>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot <syzkaller@googlegroups.com>, Geliang Tang <geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"

mptcp_pm_del_add_timer() can call sk_stop_timer_sync(sk, &entry->add_timer)
while another might have free entry already, as reported by syzbot.

Add RCU protection to fix this issue.

Also change confusing add_timer variable with stop_timer boolean.

syzbot report:

BUG: KASAN: slab-use-after-free in __timer_delete_sync+0x372/0x3f0 kernel/time/timer.c:1616
Read of size 4 at addr ffff8880311e4150 by task kworker/1:1/44

CPU: 1 UID: 0 PID: 44 Comm: kworker/1:1 Not tainted syzkaller #0 PREEMPT_{RT,(full)}
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: events mptcp_worker
Call Trace:
 <TASK>
  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
  print_address_description mm/kasan/report.c:378 [inline]
  print_report+0xca/0x240 mm/kasan/report.c:482
  kasan_report+0x118/0x150 mm/kasan/report.c:595
  __timer_delete_sync+0x372/0x3f0 kernel/time/timer.c:1616
  sk_stop_timer_sync+0x1b/0x90 net/core/sock.c:3631
  mptcp_pm_del_add_timer+0x283/0x310 net/mptcp/pm.c:362
  mptcp_incoming_options+0x1357/0x1f60 net/mptcp/options.c:1174
  tcp_data_queue+0xca/0x6450 net/ipv4/tcp_input.c:5361
  tcp_rcv_established+0x1335/0x2670 net/ipv4/tcp_input.c:6441
  tcp_v4_do_rcv+0x98b/0xbf0 net/ipv4/tcp_ipv4.c:1931
  tcp_v4_rcv+0x252a/0x2dc0 net/ipv4/tcp_ipv4.c:2374
  ip_protocol_deliver_rcu+0x221/0x440 net/ipv4/ip_input.c:205
  ip_local_deliver_finish+0x3bb/0x6f0 net/ipv4/ip_input.c:239
  NF_HOOK+0x30c/0x3a0 include/linux/netfilter.h:318
  NF_HOOK+0x30c/0x3a0 include/linux/netfilter.h:318
  __netif_receive_skb_one_core net/core/dev.c:6079 [inline]
  __netif_receive_skb+0x143/0x380 net/core/dev.c:6192
  process_backlog+0x31e/0x900 net/core/dev.c:6544
  __napi_poll+0xb6/0x540 net/core/dev.c:7594
  napi_poll net/core/dev.c:7657 [inline]
  net_rx_action+0x5f7/0xda0 net/core/dev.c:7784
  handle_softirqs+0x22f/0x710 kernel/softirq.c:622
  __do_softirq kernel/softirq.c:656 [inline]
  __local_bh_enable_ip+0x1a0/0x2e0 kernel/softirq.c:302
  mptcp_pm_send_ack net/mptcp/pm.c:210 [inline]
 mptcp_pm_addr_send_ack+0x41f/0x500 net/mptcp/pm.c:-1
  mptcp_pm_worker+0x174/0x320 net/mptcp/pm.c:1002
  mptcp_worker+0xd5/0x1170 net/mptcp/protocol.c:2762
  process_one_work kernel/workqueue.c:3263 [inline]
  process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
  kthread+0x711/0x8a0 kernel/kthread.c:463
  ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 44:
  kasan_save_stack mm/kasan/common.c:56 [inline]
  kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
  poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
  __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:417
  kasan_kmalloc include/linux/kasan.h:262 [inline]
  __kmalloc_cache_noprof+0x1ef/0x6c0 mm/slub.c:5748
  kmalloc_noprof include/linux/slab.h:957 [inline]
  mptcp_pm_alloc_anno_list+0x104/0x460 net/mptcp/pm.c:385
  mptcp_pm_create_subflow_or_signal_addr+0xf9d/0x1360 net/mptcp/pm_kernel.c:355
  mptcp_pm_nl_fully_established net/mptcp/pm_kernel.c:409 [inline]
  __mptcp_pm_kernel_worker+0x417/0x1ef0 net/mptcp/pm_kernel.c:1529
  mptcp_pm_worker+0x1ee/0x320 net/mptcp/pm.c:1008
  mptcp_worker+0xd5/0x1170 net/mptcp/protocol.c:2762
  process_one_work kernel/workqueue.c:3263 [inline]
  process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
  kthread+0x711/0x8a0 kernel/kthread.c:463
  ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 6630:
  kasan_save_stack mm/kasan/common.c:56 [inline]
  kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
  __kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:587
  kasan_save_free_info mm/kasan/kasan.h:406 [inline]
  poison_slab_object mm/kasan/common.c:252 [inline]
  __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:284
  kasan_slab_free include/linux/kasan.h:234 [inline]
  slab_free_hook mm/slub.c:2523 [inline]
  slab_free mm/slub.c:6611 [inline]
  kfree+0x197/0x950 mm/slub.c:6818
  mptcp_remove_anno_list_by_saddr+0x2d/0x40 net/mptcp/pm.c:158
  mptcp_pm_flush_addrs_and_subflows net/mptcp/pm_kernel.c:1209 [inline]
  mptcp_nl_flush_addrs_list net/mptcp/pm_kernel.c:1240 [inline]
  mptcp_pm_nl_flush_addrs_doit+0x593/0xbb0 net/mptcp/pm_kernel.c:1281
  genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
  genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
  genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
  netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
  netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
  netlink_unicast+0x846/0xa10 net/netlink/af_netlink.c:1346
  netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
  sock_sendmsg_nosec net/socket.c:727 [inline]
  __sock_sendmsg+0x21c/0x270 net/socket.c:742
  ____sys_sendmsg+0x508/0x820 net/socket.c:2630
  ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2684
  __sys_sendmsg net/socket.c:2716 [inline]
  __do_sys_sendmsg net/socket.c:2721 [inline]
  __se_sys_sendmsg net/socket.c:2719 [inline]
  __x64_sys_sendmsg+0x1a1/0x260 net/socket.c:2719
  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Geliang Tang <geliang@kernel.org>
---
 net/mptcp/pm.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 2ff1b949956834aa5c78a1fcb40087aed43225ef..9604b91902b8bc3b831547cd693c28a4890aea31 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -18,6 +18,7 @@ struct mptcp_pm_add_entry {
 	u8			retrans_times;
 	struct timer_list	add_timer;
 	struct mptcp_sock	*sock;
+	struct rcu_head		rcu;
 };
 
 static DEFINE_SPINLOCK(mptcp_pm_list_lock);
@@ -155,7 +156,7 @@ bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
 
 	entry = mptcp_pm_del_add_timer(msk, addr, false);
 	ret = entry;
-	kfree(entry);
+	kfree_rcu(entry, rcu);
 
 	return ret;
 }
@@ -345,22 +346,27 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 {
 	struct mptcp_pm_add_entry *entry;
 	struct sock *sk = (struct sock *)msk;
-	struct timer_list *add_timer = NULL;
+	bool stop_timer = false;
+
+	rcu_read_lock();
 
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 	if (entry && (!check_id || entry->addr.id == addr->id)) {
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
-		add_timer = &entry->add_timer;
+		stop_timer = true;
 	}
 	if (!check_id && entry)
 		list_del(&entry->list);
 	spin_unlock_bh(&msk->pm.lock);
 
-	/* no lock, because sk_stop_timer_sync() is calling timer_delete_sync() */
-	if (add_timer)
-		sk_stop_timer_sync(sk, add_timer);
+	/* Note: entry might have been removed by another thread.
+	 * We hold rcu_read_lock() to ensure it is not freed under us.
+	 */
+	if (stop_timer)
+		sk_stop_timer_sync(sk, &entry->add_timer);
 
+	rcu_read_unlock();
 	return entry;
 }
 
@@ -415,7 +421,7 @@ static void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 
 	list_for_each_entry_safe(entry, tmp, &free_list, list) {
 		sk_stop_timer_sync(sk, &entry->add_timer);
-		kfree(entry);
+		kfree_rcu(entry, rcu);
 	}
 }
 
-- 
2.52.0.rc1.455.g30608eb744-goog


