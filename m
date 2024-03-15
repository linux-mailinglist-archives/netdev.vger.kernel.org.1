Return-Path: <netdev+bounces-80194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2F487D6CB
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 23:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE751C20C36
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 22:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357A254BF7;
	Fri, 15 Mar 2024 22:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EE3/izzK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F3C59B6C
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 22:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710542853; cv=none; b=TwVeS9zCH0GQdTkTJBbj1Oq3tsOs/SfdgRwGSr2sIDePxRe3oV0y4bAkV8hSKWRfg/MhFY6k3B1m77boe7Ua+3ESfzdw+GoK9hsJniKrZfbS6lnQZ7YQhKENfQ+UIAA06gZn1ta+DSBupevW0Kr7LSxotAghhs1Yl5Op7iPWhbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710542853; c=relaxed/simple;
	bh=BkpBpZKZ4XLq6xkQiWDqPy8xlwmT5tNiRuArx6IQ96U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lp68RJWMNosI3nASby/NSwMZc+OBGMknmpmwUPg7k0aRpHHQjK2vjfUKXZE7S3AWDj/PW/duX3zcN11NP4L+1N5Yfy5qGfIBbt4qnv1zR9QKDUto8dvs64tZtnvxvmPYBROhKdP+TWmgo0xiYQi5lzXRz4NjDJHeNLo5oQP6fBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=EE3/izzK; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1710542851; x=1742078851;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tkL7CUTbLWm0JSaddACT5uKoKT8qqbrV4Q60eGB3b/s=;
  b=EE3/izzKuu0jg8hSdfZuA+5Yi/eHJDvYTIi0vm1oroDrcGyM2X4rpjI+
   /nktC+608Xs5DNEc6+qC72jY0u3131dHO48LdkdSdSLbMC/r0cD+3Vb3x
   25BwaXf5y+aeEPuXNmqGCtozdzZ5pEim/bG5b3aVDmWANNfDJkRjMKo0x
   8=;
X-IronPort-AV: E=Sophos;i="6.07,129,1708387200"; 
   d="scan'208";a="388165584"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 22:47:28 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:36846]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.84:2525] with esmtp (Farcaster)
 id 9a70249c-6d30-4eab-b9f5-46c31c0a2f81; Fri, 15 Mar 2024 22:47:26 +0000 (UTC)
X-Farcaster-Flow-ID: 9a70249c-6d30-4eab-b9f5-46c31c0a2f81
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 15 Mar 2024 22:47:25 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 15 Mar 2024 22:47:22 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Martin KaFai Lau <martin.lau@kernel.org>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>
Subject: [PATCH v1 net] tcp: Clear req->syncookie in reqsk_alloc().
Date: Fri, 15 Mar 2024 15:47:10 -0700
Message-ID: <20240315224710.55209-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzkaller reported a read of uninit req->syncookie. [0]

Originally, req->syncookie was used only in tcp_conn_request()
to indicate if we need to encode SYN cookie in SYN+ACK, so the
field remains uninitialised in other places.

The commit 695751e31a63 ("bpf: tcp: Handle BPF SYN Cookie in
cookie_v[46]_check().") added another meaning in ACK path;
req->syncookie is set true if SYN cookie is validated by BPF
kfunc.

After the change, cookie_v[46]_check() always read req->syncookie,
but it is not initialised in the normal SYN cookie case as reported
by KMSAN.

Let's make sure we always initialise req->syncookie in reqsk_alloc().

[0]:
BUG: KMSAN: uninit-value in cookie_v4_check+0x22b7/0x29e0
 net/ipv4/syncookies.c:477
 cookie_v4_check+0x22b7/0x29e0 net/ipv4/syncookies.c:477
 tcp_v4_cookie_check net/ipv4/tcp_ipv4.c:1855 [inline]
 tcp_v4_do_rcv+0xb17/0x10b0 net/ipv4/tcp_ipv4.c:1914
 tcp_v4_rcv+0x4ce4/0x5420 net/ipv4/tcp_ipv4.c:2322
 ip_protocol_deliver_rcu+0x2a3/0x13d0 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x332/0x500 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:460 [inline]
 ip_rcv_finish+0x4a2/0x520 net/ipv4/ip_input.c:449
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_rcv+0xcd/0x380 net/ipv4/ip_input.c:569
 __netif_receive_skb_one_core net/core/dev.c:5538 [inline]
 __netif_receive_skb+0x319/0x9e0 net/core/dev.c:5652
 process_backlog+0x480/0x8b0 net/core/dev.c:5981
 __napi_poll+0xe7/0x980 net/core/dev.c:6632
 napi_poll net/core/dev.c:6701 [inline]
 net_rx_action+0x89d/0x1820 net/core/dev.c:6813
 __do_softirq+0x1c0/0x7d7 kernel/softirq.c:554
 do_softirq+0x9a/0x100 kernel/softirq.c:455
 __local_bh_enable_ip+0x9f/0xb0 kernel/softirq.c:382
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:820 [inline]
 __dev_queue_xmit+0x2776/0x52c0 net/core/dev.c:4362
 dev_queue_xmit include/linux/netdevice.h:3091 [inline]
 neigh_hh_output include/net/neighbour.h:526 [inline]
 neigh_output include/net/neighbour.h:540 [inline]
 ip_finish_output2+0x187a/0x1b70 net/ipv4/ip_output.c:235
 __ip_finish_output+0x287/0x810
 ip_finish_output+0x4b/0x550 net/ipv4/ip_output.c:323
 NF_HOOK_COND include/linux/netfilter.h:303 [inline]
 ip_output+0x15f/0x3f0 net/ipv4/ip_output.c:433
 dst_output include/net/dst.h:450 [inline]
 ip_local_out net/ipv4/ip_output.c:129 [inline]
 __ip_queue_xmit+0x1e93/0x2030 net/ipv4/ip_output.c:535
 ip_queue_xmit+0x60/0x80 net/ipv4/ip_output.c:549
 __tcp_transmit_skb+0x3c70/0x4890 net/ipv4/tcp_output.c:1462
 tcp_transmit_skb net/ipv4/tcp_output.c:1480 [inline]
 tcp_write_xmit+0x3ee1/0x8900 net/ipv4/tcp_output.c:2792
 __tcp_push_pending_frames net/ipv4/tcp_output.c:2977 [inline]
 tcp_send_fin+0xa90/0x12e0 net/ipv4/tcp_output.c:3578
 tcp_shutdown+0x198/0x1f0 net/ipv4/tcp.c:2716
 inet_shutdown+0x33f/0x5b0 net/ipv4/af_inet.c:923
 __sys_shutdown_sock net/socket.c:2425 [inline]
 __sys_shutdown net/socket.c:2437 [inline]
 __do_sys_shutdown net/socket.c:2445 [inline]
 __se_sys_shutdown+0x2a4/0x440 net/socket.c:2443
 __x64_sys_shutdown+0x6c/0xa0 net/socket.c:2443
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was stored to memory at:
 reqsk_alloc include/net/request_sock.h:148 [inline]
 inet_reqsk_alloc+0x651/0x7a0 net/ipv4/tcp_input.c:6978
 cookie_tcp_reqsk_alloc+0xd4/0x900 net/ipv4/syncookies.c:328
 cookie_tcp_check net/ipv4/syncookies.c:388 [inline]
 cookie_v4_check+0x289f/0x29e0 net/ipv4/syncookies.c:420
 tcp_v4_cookie_check net/ipv4/tcp_ipv4.c:1855 [inline]
 tcp_v4_do_rcv+0xb17/0x10b0 net/ipv4/tcp_ipv4.c:1914
 tcp_v4_rcv+0x4ce4/0x5420 net/ipv4/tcp_ipv4.c:2322
 ip_protocol_deliver_rcu+0x2a3/0x13d0 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x332/0x500 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:460 [inline]
 ip_rcv_finish+0x4a2/0x520 net/ipv4/ip_input.c:449
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_rcv+0xcd/0x380 net/ipv4/ip_input.c:569
 __netif_receive_skb_one_core net/core/dev.c:5538 [inline]
 __netif_receive_skb+0x319/0x9e0 net/core/dev.c:5652
 process_backlog+0x480/0x8b0 net/core/dev.c:5981
 __napi_poll+0xe7/0x980 net/core/dev.c:6632
 napi_poll net/core/dev.c:6701 [inline]
 net_rx_action+0x89d/0x1820 net/core/dev.c:6813
 __do_softirq+0x1c0/0x7d7 kernel/softirq.c:554

Uninit was created at:
 __alloc_pages+0x9a7/0xe00 mm/page_alloc.c:4592
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2175 [inline]
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x2de/0x1400 mm/slub.c:2391
 ___slab_alloc+0x1184/0x33d0 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmem_cache_alloc+0x6d3/0xbe0 mm/slub.c:3852
 reqsk_alloc include/net/request_sock.h:131 [inline]
 inet_reqsk_alloc+0x66/0x7a0 net/ipv4/tcp_input.c:6978
 tcp_conn_request+0x484/0x44e0 net/ipv4/tcp_input.c:7135
 tcp_v4_conn_request+0x16f/0x1d0 net/ipv4/tcp_ipv4.c:1716
 tcp_rcv_state_process+0x2e5/0x4bb0 net/ipv4/tcp_input.c:6655
 tcp_v4_do_rcv+0xbfd/0x10b0 net/ipv4/tcp_ipv4.c:1929
 tcp_v4_rcv+0x4ce4/0x5420 net/ipv4/tcp_ipv4.c:2322
 ip_protocol_deliver_rcu+0x2a3/0x13d0 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x332/0x500 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:460 [inline]
 ip_sublist_rcv_finish net/ipv4/ip_input.c:580 [inline]
 ip_list_rcv_finish net/ipv4/ip_input.c:631 [inline]
 ip_sublist_rcv+0x15f3/0x17f0 net/ipv4/ip_input.c:639
 ip_list_rcv+0x9ef/0xa40 net/ipv4/ip_input.c:674
 __netif_receive_skb_list_ptype net/core/dev.c:5581 [inline]
 __netif_receive_skb_list_core+0x15c5/0x1670 net/core/dev.c:5629
 __netif_receive_skb_list net/core/dev.c:5681 [inline]
 netif_receive_skb_list_internal+0x106c/0x16f0 net/core/dev.c:5773
 gro_normal_list include/net/gro.h:438 [inline]
 napi_complete_done+0x425/0x880 net/core/dev.c:6113
 virtqueue_napi_complete drivers/net/virtio_net.c:465 [inline]
 virtnet_poll+0x149d/0x2240 drivers/net/virtio_net.c:2211
 __napi_poll+0xe7/0x980 net/core/dev.c:6632
 napi_poll net/core/dev.c:6701 [inline]
 net_rx_action+0x89d/0x1820 net/core/dev.c:6813
 __do_softirq+0x1c0/0x7d7 kernel/softirq.c:554

CPU: 0 PID: 16792 Comm: syz-executor.2 Not tainted 6.8.0-syzkaller-05562-g61387b8dcf1d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024

Fixes: 695751e31a63 ("bpf: tcp: Handle BPF SYN Cookie in cookie_v[46]_check().")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Reported-by: Eric Dumazet <edumazet@google.com>
Closes: https://lore.kernel.org/bpf/CANn89iKdN9c+C_2JAUbc+VY3DDQjAQukMtiBbormAmAk9CdvQA@mail.gmail.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/request_sock.h | 7 ++++++-
 net/ipv4/syncookies.c      | 3 +++
 net/ipv6/syncookies.c      | 3 +++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index 8839133d6f6b..004e651e6067 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -61,7 +61,11 @@ struct request_sock {
 	struct request_sock		*dl_next;
 	u16				mss;
 	u8				num_retrans; /* number of retransmits */
-	u8				syncookie:1; /* syncookie: encode tcpopts in timestamp */
+	u8				syncookie:1; /* True if
+						      * 1) tcpopts needs to be encoded in
+						      *    TS of SYN+ACK
+						      * 2) ACK is validated by BPF kfunc.
+						      */
 	u8				num_timeout:7; /* number of timeouts */
 	u32				ts_recent;
 	struct timer_list		rsk_timer;
@@ -144,6 +148,7 @@ reqsk_alloc(const struct request_sock_ops *ops, struct sock *sk_listener,
 	sk_node_init(&req_to_sk(req)->sk_node);
 	sk_tx_queue_clear(req_to_sk(req));
 	req->saved_syn = NULL;
+	req->syncookie = 0;
 	req->timeout = 0;
 	req->num_timeout = 0;
 	req->num_retrans = 0;
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 7972ad3d7c73..500f665f98cb 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -474,6 +474,9 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 				  ireq->wscale_ok, &rcv_wscale,
 				  dst_metric(&rt->dst, RTAX_INITRWND));
 
+	/* req->syncookie is set true only if ACK is validated
+	 * by BPF kfunc, then, rcv_wscale is already configured.
+	 */
 	if (!req->syncookie)
 		ireq->rcv_wscale = rcv_wscale;
 	ireq->ecn_ok &= cookie_ecn_ok(net, &rt->dst);
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 8bad0a44a0a6..6d8286c299c9 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -258,6 +258,9 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 				  ireq->wscale_ok, &rcv_wscale,
 				  dst_metric(dst, RTAX_INITRWND));
 
+	/* req->syncookie is set true only if ACK is validated
+	 * by BPF kfunc, then, rcv_wscale is already configured.
+	 */
 	if (!req->syncookie)
 		ireq->rcv_wscale = rcv_wscale;
 	ireq->ecn_ok &= cookie_ecn_ok(net, dst);
-- 
2.30.2


