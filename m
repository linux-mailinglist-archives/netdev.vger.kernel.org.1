Return-Path: <netdev+bounces-147192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CBF9D8243
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 10:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0919D1635C5
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 09:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D7E19007F;
	Mon, 25 Nov 2024 09:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2wiZF0Tn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51CB1632DF
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 09:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732527054; cv=none; b=DoLUKIFLxP2Dh6Em5TCbz/WMoyZJC/QMUszxfYXsqHC37m9bXZJMsOpMwnuGUIWX8ZX+/Ide2JbLjlHM4G1rnAVm8+6922Qh9jO6TR3AbkxQwoxy6E5nzGeFw3vYWPzG2Vhnmt5pZT9xS3FaI/TjAK22vLrnnfI3rr58QMs7f20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732527054; c=relaxed/simple;
	bh=ZtPt/UBZ3b3Nbp++xWu2QVjOgBChbNfguNY55juEKU0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uATKOdg4oGGRa218qKxloKiS7NDDOLz806QfXbO3rhtRelv0jeiXV8Rg64qk0+zY1YPtLDuK33DVOHyKuhawyCCRaaJ8XGGvggT+4s24Eb3DGAV9C78MwOB2t7JhBoa58mdYHxyoAdzolWsmVaEHb9R8nN+bSmPgC+fmk6+eOuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2wiZF0Tn; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e38f6630bbbso4542421276.3
        for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 01:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732527051; x=1733131851; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ApPaAaGFSQyE0Se/uKc7zLiWZe8QY3BPqqAd3tdeyUA=;
        b=2wiZF0TncU40P3kTYWnTkamLxz72/FcBoiK6YgzUUi/cAIwRmIFyvM3lQ7nWkV51/5
         sNXFtI7fo6DOKWQzS7mIs4F28qDg7CYciEG+IawZNJYQCYifROOB/QnISDXG2hH0U1DS
         7H17nVBB2MlpzXPT44Cyxr6cO+hIaNxONfDVJ0OiD3c1bXr4lXv4WWEeKfapuFG7nKTb
         jDI39A7gGMB8UrvB8FacC7BBTQC57S8D6LaoNcZhDQNpHRSpRR+thPgVBJPioAZmxd53
         C+bFRTrmME5E9/M2GTZu58BXuEIKRo5Mh7hAk+BEBvL6qB72+9knt+oy9vrsNJTugqdM
         sOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732527051; x=1733131851;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ApPaAaGFSQyE0Se/uKc7zLiWZe8QY3BPqqAd3tdeyUA=;
        b=qeMxUC9WKCc9SaXu6tDe1qwDs4cBd8jSV68vDq9o5FDtFgEAeV4Pccy8wBeDeScGaf
         wBJkZcpe9miS2m5o8q0yQksUIhlCqdvPkPs3kH5wimjNkw8Ayvy0BBRseHjqoLyHH1kB
         LurNWhmzi1cqQ/5a6DXw60SZTgnyEtpMZ6Hyv7DRo7BRbIP9b7ErdWtluOVRRtH3B6EK
         0PC1C8JCZqUT++u/RC/P77nbhRjwVyApN+wAQmu2u+vI9Cj34hx54hevDM7Wnm3JA//b
         ZTDSD7bi4zYa5ZSZKWYuqaGTLDEexYfz43ckXiTrHMVKUXjVbAKRet9JRX1ibLWtasxW
         W+kw==
X-Gm-Message-State: AOJu0YyRX6tb51SgNvSANto/s8Lg2FKjwVi2c3m8xgrl20JTbL2gnqza
	AhsykcHzFBvsi8c/nrKM1mawY+QuR83Vng+TnCYukfJQsHSjnaf8ymY6Vgyl/RULhOX5gaS/d4w
	htuJKR7SlFA==
X-Google-Smtp-Source: AGHT+IGa5VwBBQWVDfwFs33uNLqJ5lb9ZFyttFeOFxykfPOCNn3t6rJS64KruF5MQDrFHDbv3PdwqKg8AnKdcA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:adc6:0:b0:e38:c40b:a0a9 with SMTP id
 3f1490d57ef6-e38f8bde03bmr5467276.5.1732527051420; Mon, 25 Nov 2024 01:30:51
 -0800 (PST)
Date: Mon, 25 Nov 2024 09:30:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241125093039.3095790-1-edumazet@google.com>
Subject: [PATCH net] tcp: populate XPS related fields of timewait sockets
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+8b0959fc16551d55896b@syzkaller.appspotmail.com, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"

syzbot reported that netdev_core_pick_tx() was reading an unitialized
field [1].

This is indeed hapening for timewait sockets after recent commits.

We can copy the original established socket sk_tx_queue_mapping
and sk_rx_queue_mapping fields, instead of adding more checks
in fast paths.

As a bonus, packets will use the same transmit queue than
prior ones, this potentially can avoid reordering.

[1]
BUG: KMSAN: uninit-value in netdev_pick_tx+0x5c7/0x1550
 netdev_pick_tx+0x5c7/0x1550
  netdev_core_pick_tx+0x1d2/0x4a0 net/core/dev.c:4312
  __dev_queue_xmit+0x128a/0x57d0 net/core/dev.c:4394
  dev_queue_xmit include/linux/netdevice.h:3168 [inline]
  neigh_hh_output include/net/neighbour.h:523 [inline]
  neigh_output include/net/neighbour.h:537 [inline]
  ip_finish_output2+0x187c/0x1b70 net/ipv4/ip_output.c:236
 __ip_finish_output+0x287/0x810
  ip_finish_output+0x4b/0x600 net/ipv4/ip_output.c:324
  NF_HOOK_COND include/linux/netfilter.h:303 [inline]
  ip_output+0x15f/0x3f0 net/ipv4/ip_output.c:434
  dst_output include/net/dst.h:450 [inline]
  ip_local_out net/ipv4/ip_output.c:130 [inline]
  ip_send_skb net/ipv4/ip_output.c:1505 [inline]
  ip_push_pending_frames+0x444/0x570 net/ipv4/ip_output.c:1525
  ip_send_unicast_reply+0x18c1/0x1b30 net/ipv4/ip_output.c:1672
  tcp_v4_send_reset+0x238d/0x2a40 net/ipv4/tcp_ipv4.c:910
  tcp_v4_rcv+0x48f8/0x5750 net/ipv4/tcp_ipv4.c:2431
  ip_protocol_deliver_rcu+0x2a3/0x13d0 net/ipv4/ip_input.c:205
  ip_local_deliver_finish+0x336/0x500 net/ipv4/ip_input.c:233
  NF_HOOK include/linux/netfilter.h:314 [inline]
  ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
  dst_input include/net/dst.h:460 [inline]
  ip_sublist_rcv_finish net/ipv4/ip_input.c:578 [inline]
  ip_list_rcv_finish net/ipv4/ip_input.c:628 [inline]
  ip_sublist_rcv+0x15f3/0x17f0 net/ipv4/ip_input.c:636
  ip_list_rcv+0x9ef/0xa40 net/ipv4/ip_input.c:670
  __netif_receive_skb_list_ptype net/core/dev.c:5715 [inline]
  __netif_receive_skb_list_core+0x15c5/0x1670 net/core/dev.c:5762
  __netif_receive_skb_list net/core/dev.c:5814 [inline]
  netif_receive_skb_list_internal+0x1085/0x1700 net/core/dev.c:5905
  gro_normal_list include/net/gro.h:515 [inline]
  napi_complete_done+0x3d4/0x810 net/core/dev.c:6256
  virtqueue_napi_complete drivers/net/virtio_net.c:758 [inline]
  virtnet_poll+0x5d80/0x6bf0 drivers/net/virtio_net.c:3013
  __napi_poll+0xe7/0x980 net/core/dev.c:6877
  napi_poll net/core/dev.c:6946 [inline]
  net_rx_action+0xa5a/0x19b0 net/core/dev.c:7068
  handle_softirqs+0x1a0/0x7c0 kernel/softirq.c:554
  __do_softirq kernel/softirq.c:588 [inline]
  invoke_softirq kernel/softirq.c:428 [inline]
  __irq_exit_rcu+0x68/0x180 kernel/softirq.c:655
  irq_exit_rcu+0x12/0x20 kernel/softirq.c:671
  common_interrupt+0x97/0xb0 arch/x86/kernel/irq.c:278
  asm_common_interrupt+0x2b/0x40 arch/x86/include/asm/idtentry.h:693
  __preempt_count_sub arch/x86/include/asm/preempt.h:84 [inline]
  kmsan_virt_addr_valid arch/x86/include/asm/kmsan.h:95 [inline]
  virt_to_page_or_null+0xfb/0x150 mm/kmsan/shadow.c:75
  kmsan_get_metadata+0x13e/0x1c0 mm/kmsan/shadow.c:141
  kmsan_get_shadow_origin_ptr+0x4d/0xb0 mm/kmsan/shadow.c:102
  get_shadow_origin_ptr mm/kmsan/instrumentation.c:38 [inline]
  __msan_metadata_ptr_for_store_4+0x27/0x40 mm/kmsan/instrumentation.c:93
  rcu_preempt_read_enter kernel/rcu/tree_plugin.h:390 [inline]
  __rcu_read_lock+0x46/0x70 kernel/rcu/tree_plugin.h:413
  rcu_read_lock include/linux/rcupdate.h:847 [inline]
  batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:408 [inline]
  batadv_nc_worker+0x114/0x19e0 net/batman-adv/network-coding.c:719
  process_one_work kernel/workqueue.c:3229 [inline]
  process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310
  worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391
  kthread+0x3e2/0x540 kernel/kthread.c:389
  ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
  __alloc_pages_noprof+0x9a7/0xe00 mm/page_alloc.c:4774
  alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2265
  alloc_pages_noprof+0x1bf/0x1e0 mm/mempolicy.c:2344
  alloc_slab_page mm/slub.c:2412 [inline]
  allocate_slab+0x320/0x12e0 mm/slub.c:2578
  new_slab mm/slub.c:2631 [inline]
  ___slab_alloc+0x12ef/0x35e0 mm/slub.c:3818
  __slab_alloc mm/slub.c:3908 [inline]
  __slab_alloc_node mm/slub.c:3961 [inline]
  slab_alloc_node mm/slub.c:4122 [inline]
  kmem_cache_alloc_noprof+0x57a/0xb20 mm/slub.c:4141
  inet_twsk_alloc+0x11f/0x9d0 net/ipv4/inet_timewait_sock.c:188
  tcp_time_wait+0x83/0xf50 net/ipv4/tcp_minisocks.c:309
 tcp_rcv_state_process+0x145a/0x49d0
  tcp_v4_do_rcv+0xbf9/0x11a0 net/ipv4/tcp_ipv4.c:1939
  tcp_v4_rcv+0x51df/0x5750 net/ipv4/tcp_ipv4.c:2351
  ip_protocol_deliver_rcu+0x2a3/0x13d0 net/ipv4/ip_input.c:205
  ip_local_deliver_finish+0x336/0x500 net/ipv4/ip_input.c:233
  NF_HOOK include/linux/netfilter.h:314 [inline]
  ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
  dst_input include/net/dst.h:460 [inline]
  ip_sublist_rcv_finish net/ipv4/ip_input.c:578 [inline]
  ip_list_rcv_finish net/ipv4/ip_input.c:628 [inline]
  ip_sublist_rcv+0x15f3/0x17f0 net/ipv4/ip_input.c:636
  ip_list_rcv+0x9ef/0xa40 net/ipv4/ip_input.c:670
  __netif_receive_skb_list_ptype net/core/dev.c:5715 [inline]
  __netif_receive_skb_list_core+0x15c5/0x1670 net/core/dev.c:5762
  __netif_receive_skb_list net/core/dev.c:5814 [inline]
  netif_receive_skb_list_internal+0x1085/0x1700 net/core/dev.c:5905
  gro_normal_list include/net/gro.h:515 [inline]
  napi_complete_done+0x3d4/0x810 net/core/dev.c:6256
  virtqueue_napi_complete drivers/net/virtio_net.c:758 [inline]
  virtnet_poll+0x5d80/0x6bf0 drivers/net/virtio_net.c:3013
  __napi_poll+0xe7/0x980 net/core/dev.c:6877
  napi_poll net/core/dev.c:6946 [inline]
  net_rx_action+0xa5a/0x19b0 net/core/dev.c:7068
  handle_softirqs+0x1a0/0x7c0 kernel/softirq.c:554
  __do_softirq kernel/softirq.c:588 [inline]
  invoke_softirq kernel/softirq.c:428 [inline]
  __irq_exit_rcu+0x68/0x180 kernel/softirq.c:655
  irq_exit_rcu+0x12/0x20 kernel/softirq.c:671
  common_interrupt+0x97/0xb0 arch/x86/kernel/irq.c:278
  asm_common_interrupt+0x2b/0x40 arch/x86/include/asm/idtentry.h:693

CPU: 0 UID: 0 PID: 3962 Comm: kworker/u8:18 Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: bat_events batadv_nc_worker

Fixes: 79636038d37e ("ipv4: tcp: give socket pointer to control skbs")
Fixes: 507a96737d99 ("ipv6: tcp: give socket pointer to control skbs")
Reported-by: syzbot+8b0959fc16551d55896b@syzkaller.appspotmail.com
Link: https://lore.kernel.org/netdev/674442bd.050a0220.1cc393.0072.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Brian Vazquez <brianvv@google.com>
---
 include/net/inet_timewait_sock.h | 2 ++
 net/ipv4/tcp_minisocks.c         | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
index beb533a0e88098a95a1365b51bdc2d9e9dfd1d07..62c0a7e65d6bdf4c71a8ea90586b985f9fd30229 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -45,6 +45,8 @@ struct inet_timewait_sock {
 #define tw_node			__tw_common.skc_nulls_node
 #define tw_bind_node		__tw_common.skc_bind_node
 #define tw_refcnt		__tw_common.skc_refcnt
+#define tw_tx_queue_mapping	__tw_common.skc_tx_queue_mapping
+#define tw_rx_queue_mapping	__tw_common.skc_rx_queue_mapping
 #define tw_hash			__tw_common.skc_hash
 #define tw_prot			__tw_common.skc_prot
 #define tw_net			__tw_common.skc_net
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index bb1fe1ba867ac3ed8610ceb9fef7e74cd465b3ea..7121d8573928cbf6840b3361b62f4812d365a30b 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -326,6 +326,10 @@ void tcp_time_wait(struct sock *sk, int state, int timeo)
 		tcptw->tw_last_oow_ack_time = 0;
 		tcptw->tw_tx_delay	= tp->tcp_tx_delay;
 		tw->tw_txhash		= sk->sk_txhash;
+		tw->tw_tx_queue_mapping = sk->sk_tx_queue_mapping;
+#ifdef CONFIG_SOCK_RX_QUEUE_MAPPING
+		tw->tw_rx_queue_mapping = sk->sk_rx_queue_mapping;
+#endif
 #if IS_ENABLED(CONFIG_IPV6)
 		if (tw->tw_family == PF_INET6) {
 			struct ipv6_pinfo *np = inet6_sk(sk);
-- 
2.47.0.371.ga323438b13-goog


