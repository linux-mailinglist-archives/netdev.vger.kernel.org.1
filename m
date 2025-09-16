Return-Path: <netdev+bounces-223274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C340BB588DC
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 02:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B3E8189D751
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 00:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BE04207A;
	Tue, 16 Sep 2025 00:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n06LULOH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06B73597C
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 00:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981169; cv=none; b=DzDyuLxw2HeYV5ncHxNVx0otKZsvmnBe9+GhBBjx2I6CmuPdMc8bsLxEJdtGguU2fsliiuV6Nv+1sjqSeBFgNvgRjAlBFKRQnsXYt1/ZblcNPKgRd/brnd76n6v2ZWdx8z4f8zBp13Q2P5LLwo05v+5D5uxWboNsCgA9kag6ZdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981169; c=relaxed/simple;
	bh=qKdL+151o7qytBQbGA6THtSTc6/o5zCP4cs2iJCtuzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhUor+DA++8/6Y87NcMSHzIhzSD+Aodd0LYZWqAuiBIo0V0sO7TZXAT9MKMtlmgYusTT7WAvyHLnxSAGBZ+gU3wjrVsJclesPeo+5FoZTZf+SsOGP/xRqZH0AgLvo3QgWPPvQVhL/wxIN/mB49rxjbYvHEf5H43fgqh3KazNJr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n06LULOH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B04C4CEF5;
	Tue, 16 Sep 2025 00:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757981169;
	bh=qKdL+151o7qytBQbGA6THtSTc6/o5zCP4cs2iJCtuzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n06LULOHzpS2bPg2qxtaGZIeHvJLXjjRSc05GBWUqGo/ny+xoQFDRqEk5ROhkB/23
	 anIMhpdC3d1+m2ChbiHVblYTbzyiTFPCwWKmrC8Vo/PYn7CtrYpBl/ZqJNBKfeJOak
	 LHZicZLWOLaiP/m3bGmaEH6g6BH5nM9Lbp9zXQWWDe11Ea0ccNKUaIDii7Fx41n//3
	 Dj5ND+PCk6Js15D3v+kdUlKVEX6GCwsfV5USQFWe7I8cEFM0GGd9yj8HJ8Xp8wFB+p
	 vqylmxcw0DkpJ0nEu398lwnpfJAxJ1l4UdU/HIOsQTzmvYJ6kSk0rFDWfR3uSkDWxM
	 /D+I4I03KoeEw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>
Subject: [PATCH net-next v12 04/19] tcp: add datapath logic for PSP with inline key exchange
Date: Mon, 15 Sep 2025 17:05:44 -0700
Message-ID: <20250916000559.1320151-5-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916000559.1320151-1-kuba@kernel.org>
References: <20250916000559.1320151-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add validation points and state propagation to support PSP key
exchange inline, on TCP connections. The expectation is that
application will use some well established mechanism like TLS
handshake to establish a secure channel over the connection and
if both endpoints are PSP-capable - exchange and install PSP keys.
Because the connection can existing in PSP-unsecured and PSP-secured
state we need to make sure that there are no race conditions or
retransmission leaks.

On Tx - mark packets with the skb->decrypted bit when PSP key
is at the enqueue time. Drivers should only encrypt packets with
this bit set. This prevents retransmissions getting encrypted when
original transmission was not. Similarly to TLS, we'll use
sk->sk_validate_xmit_skb to make sure PSP skbs can't "escape"
via a PSP-unaware device without being encrypted.

On Rx - validation is done under socket lock. This moves the validation
point later than xfrm, for example. Please see the documentation patch
for more details on the flow of securing a connection, but for
the purpose of this patch what's important is that we want to
enforce the invariant that once connection is secured any skb
in the receive queue has been encrypted with PSP.

Add GRO and coalescing checks to prevent PSP authenticated data from
being combined with cleartext data, or data with non-matching PSP
state. On Rx, check skb's with psp_skb_coalesce_diff() at points
before psp_sk_rx_policy_check(). After skb's are policy checked and on
the socket receive queue, skb_cmp_decrypted() is sufficient for
checking for coalescable PSP state. On Tx, tcp_write_collapse_fence()
should be called when transitioning a socket into PSP Tx state to
prevent data sent as cleartext from being coalesced with PSP
encapsulated data.

This change only adds the validation points, for ease of review.
Subsequent change will add the ability to install keys, and flesh
the enforcement logic out

Reviewed-by: Willem de Bruijn <willemb@google.com>
Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Notes:
    v7:
    - add comments about GRO and TCP coalescing to the commit message.
    v4:
    - add comment to tcp_timewait_state_process() explaining TCP_TW_SYN
      case.
    - psp_twsk_init() accepts const pointer, so caller does not need to
      cast const away.
    - add missing psp_twsk_rx_policy_check() to TCP_TW_SYN case of
      do_timewait in tcp_v4_rcv().
    v3:
    - psp_reply_set_decrypted() does not use stuct sock* arg. Drop it.
    v2:
    - Add psp_reply_set_decrypted() to encapsulate ACKs, FINs, and RSTs
      sent from control socks on behalf of full or timewait socks with PSP
      state.
    v1:
    - https://lore.kernel.org/netdev/20240510030435.120935-5-kuba@kernel.org/
---
 net/psp/Kconfig               |  1 +
 include/net/dropreason-core.h |  6 +++
 include/net/psp/functions.h   | 77 +++++++++++++++++++++++++++++++++++
 net/core/gro.c                |  2 +
 net/ipv4/inet_timewait_sock.c |  2 +
 net/ipv4/ip_output.c          |  5 ++-
 net/ipv4/tcp.c                |  2 +
 net/ipv4/tcp_ipv4.c           | 14 ++++++-
 net/ipv4/tcp_minisocks.c      | 18 ++++++++
 net/ipv4/tcp_output.c         | 17 +++++---
 net/ipv6/tcp_ipv6.c           | 11 +++++
 11 files changed, 147 insertions(+), 8 deletions(-)

diff --git a/net/psp/Kconfig b/net/psp/Kconfig
index 55f9dd87446b..5e3908a40945 100644
--- a/net/psp/Kconfig
+++ b/net/psp/Kconfig
@@ -5,6 +5,7 @@
 config INET_PSP
 	bool "PSP Security Protocol support"
 	depends on INET
+	select SKB_DECRYPTED
 	help
 	Enable kernel support for the PSP protocol.
 	For more information see:
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index d8ff24a33459..58d91ccc56e0 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -127,6 +127,8 @@
 	FN(CANXL_RX_INVALID_FRAME)	\
 	FN(PFMEMALLOC)	\
 	FN(DUALPI2_STEP_DROP)		\
+	FN(PSP_INPUT)			\
+	FN(PSP_OUTPUT)			\
 	FNe(MAX)
 
 /**
@@ -610,6 +612,10 @@ enum skb_drop_reason {
 	 * threshold of DualPI2 qdisc.
 	 */
 	SKB_DROP_REASON_DUALPI2_STEP_DROP,
+	/** @SKB_DROP_REASON_PSP_INPUT: PSP input checks failed */
+	SKB_DROP_REASON_PSP_INPUT,
+	/** @SKB_DROP_REASON_PSP_OUTPUT: PSP output checks failed */
+	SKB_DROP_REASON_PSP_OUTPUT,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/include/net/psp/functions.h b/include/net/psp/functions.h
index d0043bd14299..1ccc5fc238b8 100644
--- a/include/net/psp/functions.h
+++ b/include/net/psp/functions.h
@@ -3,6 +3,8 @@
 #ifndef __NET_PSP_HELPERS_H
 #define __NET_PSP_HELPERS_H
 
+#include <linux/skbuff.h>
+#include <net/sock.h>
 #include <net/psp/types.h>
 
 struct inet_timewait_sock;
@@ -14,7 +16,82 @@ psp_dev_create(struct net_device *netdev, struct psp_dev_ops *psd_ops,
 void psp_dev_unregister(struct psp_dev *psd);
 
 /* Kernel-facing API */
+#if IS_ENABLED(CONFIG_INET_PSP)
 static inline void psp_sk_assoc_free(struct sock *sk) { }
+static inline void
+psp_twsk_init(struct inet_timewait_sock *tw, const struct sock *sk) { }
 static inline void psp_twsk_assoc_free(struct inet_timewait_sock *tw) { }
+static inline void
+psp_reply_set_decrypted(struct sk_buff *skb) { }
+
+static inline void
+psp_enqueue_set_decrypted(struct sock *sk, struct sk_buff *skb)
+{
+}
+
+static inline unsigned long
+__psp_skb_coalesce_diff(const struct sk_buff *one, const struct sk_buff *two,
+			unsigned long diffs)
+{
+	return diffs;
+}
+
+static inline enum skb_drop_reason
+psp_sk_rx_policy_check(struct sock *sk, struct sk_buff *skb)
+{
+	return 0;
+}
+
+static inline enum skb_drop_reason
+psp_twsk_rx_policy_check(struct inet_timewait_sock *tw, struct sk_buff *skb)
+{
+	return 0;
+}
+
+static inline struct psp_assoc *psp_skb_get_assoc_rcu(struct sk_buff *skb)
+{
+	return NULL;
+}
+#else
+static inline void psp_sk_assoc_free(struct sock *sk) { }
+static inline void
+psp_twsk_init(struct inet_timewait_sock *tw, const struct sock *sk) { }
+static inline void psp_twsk_assoc_free(struct inet_timewait_sock *tw) { }
+static inline void
+psp_reply_set_decrypted(struct sk_buff *skb) { }
+
+static inline void
+psp_enqueue_set_decrypted(struct sock *sk, struct sk_buff *skb) { }
+
+static inline unsigned long
+__psp_skb_coalesce_diff(const struct sk_buff *one, const struct sk_buff *two,
+			unsigned long diffs)
+{
+	return diffs;
+}
+
+static inline enum skb_drop_reason
+psp_sk_rx_policy_check(struct sock *sk, struct sk_buff *skb)
+{
+	return 0;
+}
+
+static inline enum skb_drop_reason
+psp_twsk_rx_policy_check(struct inet_timewait_sock *tw, struct sk_buff *skb)
+{
+	return 0;
+}
+
+static inline struct psp_assoc *psp_skb_get_assoc_rcu(struct sk_buff *skb)
+{
+	return NULL;
+}
+#endif
+
+static inline unsigned long
+psp_skb_coalesce_diff(const struct sk_buff *one, const struct sk_buff *two)
+{
+	return __psp_skb_coalesce_diff(one, two, 0);
+}
 
 #endif /* __NET_PSP_HELPERS_H */
diff --git a/net/core/gro.c b/net/core/gro.c
index b350e5b69549..5ba4504cfd28 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
+#include <net/psp.h>
 #include <net/gro.h>
 #include <net/dst_metadata.h>
 #include <net/busy_poll.h>
@@ -376,6 +377,7 @@ static void gro_list_prepare(const struct list_head *head,
 			diffs |= skb_get_nfct(p) ^ skb_get_nfct(skb);
 
 			diffs |= gro_list_prepare_tc_ext(skb, p, diffs);
+			diffs |= __psp_skb_coalesce_diff(skb, p, diffs);
 		}
 
 		NAPI_GRO_CB(p)->same_flow = !diffs;
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 5b5426b8ee92..1f83f333b8ac 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -16,6 +16,7 @@
 #include <net/inet_timewait_sock.h>
 #include <net/ip.h>
 #include <net/tcp.h>
+#include <net/psp.h>
 
 /**
  *	inet_twsk_bind_unhash - unhash a timewait socket from bind hash
@@ -219,6 +220,7 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
 		refcount_set(&tw->tw_refcnt, 0);
 
 		__module_get(tw->tw_prot->owner);
+		psp_twsk_init(tw, sk);
 	}
 
 	return tw;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 2b96651d719b..5ca97ede979c 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -84,6 +84,7 @@
 #include <linux/netfilter_bridge.h>
 #include <linux/netlink.h>
 #include <linux/tcp.h>
+#include <net/psp.h>
 
 static int
 ip_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
@@ -1665,8 +1666,10 @@ void ip_send_unicast_reply(struct sock *sk, const struct sock *orig_sk,
 			  arg->csumoffset) = csum_fold(csum_add(nskb->csum,
 								arg->csum));
 		nskb->ip_summed = CHECKSUM_NONE;
-		if (orig_sk)
+		if (orig_sk) {
 			skb_set_owner_edemux(nskb, (struct sock *)orig_sk);
+			psp_reply_set_decrypted(nskb);
+		}
 		if (transmit_time)
 			nskb->tstamp_type = SKB_CLOCK_MONOTONIC;
 		if (txhash)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 1f643faa8b93..9d7d26adf265 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -275,6 +275,7 @@
 #include <net/proto_memory.h>
 #include <net/xfrm.h>
 #include <net/ip.h>
+#include <net/psp.h>
 #include <net/sock.h>
 #include <net/rstreason.h>
 
@@ -703,6 +704,7 @@ void tcp_skb_entail(struct sock *sk, struct sk_buff *skb)
 	tcb->seq     = tcb->end_seq = tp->write_seq;
 	tcb->tcp_flags = TCPHDR_ACK;
 	__skb_header_release(skb);
+	psp_enqueue_set_decrypted(sk, skb);
 	tcp_add_write_queue_tail(sk, skb);
 	sk_wmem_queued_add(sk, skb->truesize);
 	sk_mem_charge(sk, skb->truesize);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 2a0602035729..a448eb62efb1 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -74,6 +74,7 @@
 #include <net/secure_seq.h>
 #include <net/busy_poll.h>
 #include <net/rstreason.h>
+#include <net/psp.h>
 
 #include <linux/inet.h>
 #include <linux/ipv6.h>
@@ -1905,6 +1906,10 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 	enum skb_drop_reason reason;
 	struct sock *rsk;
 
+	reason = psp_sk_rx_policy_check(sk, skb);
+	if (reason)
+		goto err_discard;
+
 	if (sk->sk_state == TCP_ESTABLISHED) { /* Fast path */
 		struct dst_entry *dst;
 
@@ -1966,6 +1971,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 	reason = SKB_DROP_REASON_TCP_CSUM;
 	trace_tcp_bad_csum(skb);
 	TCP_INC_STATS(sock_net(sk), TCP_MIB_CSUMERRORS);
+err_discard:
 	TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
 	goto discard;
 }
@@ -2067,7 +2073,9 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	     (TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)) ||
 	    !tcp_skb_can_collapse_rx(tail, skb) ||
 	    thtail->doff != th->doff ||
-	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
+	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)) ||
+	    /* prior to PSP Rx policy check, retain exact PSP metadata */
+	    psp_skb_coalesce_diff(tail, skb))
 		goto no_coalesce;
 
 	__skb_pull(skb, hdrlen);
@@ -2435,6 +2443,10 @@ int tcp_v4_rcv(struct sk_buff *skb)
 			__this_cpu_write(tcp_tw_isn, isn);
 			goto process;
 		}
+
+		drop_reason = psp_twsk_rx_policy_check(inet_twsk(sk), skb);
+		if (drop_reason)
+			break;
 	}
 		/* to ACK */
 		fallthrough;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 06d6491239db..dd0a74df129d 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -104,9 +104,16 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 	struct tcp_timewait_sock *tcptw = tcp_twsk((struct sock *)tw);
 	u32 rcv_nxt = READ_ONCE(tcptw->tw_rcv_nxt);
 	struct tcp_options_received tmp_opt;
+	enum skb_drop_reason psp_drop;
 	bool paws_reject = false;
 	int ts_recent_stamp;
 
+	/* Instead of dropping immediately, wait to see what value is
+	 * returned. We will accept a non psp-encapsulated syn in the
+	 * case where TCP_TW_SYN is returned.
+	 */
+	psp_drop = psp_twsk_rx_policy_check(tw, skb);
+
 	tmp_opt.saw_tstamp = 0;
 	ts_recent_stamp = READ_ONCE(tcptw->tw_ts_recent_stamp);
 	if (th->doff > (sizeof(*th) >> 2) && ts_recent_stamp) {
@@ -124,6 +131,9 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 	if (READ_ONCE(tw->tw_substate) == TCP_FIN_WAIT2) {
 		/* Just repeat all the checks of tcp_rcv_state_process() */
 
+		if (psp_drop)
+			goto out_put;
+
 		/* Out of window, send ACK */
 		if (paws_reject ||
 		    !tcp_in_window(TCP_SKB_CB(skb)->seq, TCP_SKB_CB(skb)->end_seq,
@@ -194,6 +204,9 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 	     (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq || th->rst))) {
 		/* In window segment, it may be only reset or bare ack. */
 
+		if (psp_drop)
+			goto out_put;
+
 		if (th->rst) {
 			/* This is TIME_WAIT assassination, in two flavors.
 			 * Oh well... nobody has a sufficient solution to this
@@ -247,6 +260,9 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 		return TCP_TW_SYN;
 	}
 
+	if (psp_drop)
+		goto out_put;
+
 	if (paws_reject) {
 		*drop_reason = SKB_DROP_REASON_TCP_RFC7323_TW_PAWS;
 		__NET_INC_STATS(twsk_net(tw), LINUX_MIB_PAWS_TW_REJECTED);
@@ -265,6 +281,8 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 		return tcp_timewait_check_oow_rate_limit(
 			tw, skb, LINUX_MIB_TCPACKSKIPPEDTIMEWAIT);
 	}
+
+out_put:
 	inet_twsk_put(tw);
 	return TCP_TW_SUCCESS;
 }
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index be8ceefa5332..2836f5bbe1f0 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -41,6 +41,7 @@
 #include <net/tcp_ecn.h>
 #include <net/mptcp.h>
 #include <net/proto_memory.h>
+#include <net/psp.h>
 
 #include <linux/compiler.h>
 #include <linux/gfp.h>
@@ -350,13 +351,15 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 /* Constructs common control bits of non-data skb. If SYN/FIN is present,
  * auto increment end seqno.
  */
-static void tcp_init_nondata_skb(struct sk_buff *skb, u32 seq, u16 flags)
+static void tcp_init_nondata_skb(struct sk_buff *skb, struct sock *sk,
+				 u32 seq, u16 flags)
 {
 	skb->ip_summed = CHECKSUM_PARTIAL;
 
 	TCP_SKB_CB(skb)->tcp_flags = flags;
 
 	tcp_skb_pcount_set(skb, 1);
+	psp_enqueue_set_decrypted(sk, skb);
 
 	TCP_SKB_CB(skb)->seq = seq;
 	if (flags & (TCPHDR_SYN | TCPHDR_FIN))
@@ -1457,6 +1460,7 @@ static void tcp_queue_skb(struct sock *sk, struct sk_buff *skb)
 	/* Advance write_seq and place onto the write_queue. */
 	WRITE_ONCE(tp->write_seq, TCP_SKB_CB(skb)->end_seq);
 	__skb_header_release(skb);
+	psp_enqueue_set_decrypted(sk, skb);
 	tcp_add_write_queue_tail(sk, skb);
 	sk_wmem_queued_add(sk, skb->truesize);
 	sk_mem_charge(sk, skb->truesize);
@@ -3571,7 +3575,7 @@ void tcp_send_fin(struct sock *sk)
 		skb_reserve(skb, MAX_TCP_HEADER);
 		sk_forced_mem_schedule(sk, skb->truesize);
 		/* FIN eats a sequence byte, write_seq advanced by tcp_queue_skb(). */
-		tcp_init_nondata_skb(skb, tp->write_seq,
+		tcp_init_nondata_skb(skb, sk, tp->write_seq,
 				     TCPHDR_ACK | TCPHDR_FIN);
 		tcp_queue_skb(sk, skb);
 	}
@@ -3599,7 +3603,7 @@ void tcp_send_active_reset(struct sock *sk, gfp_t priority,
 
 	/* Reserve space for headers and prepare control bits. */
 	skb_reserve(skb, MAX_TCP_HEADER);
-	tcp_init_nondata_skb(skb, tcp_acceptable_seq(sk),
+	tcp_init_nondata_skb(skb, sk, tcp_acceptable_seq(sk),
 			     TCPHDR_ACK | TCPHDR_RST);
 	tcp_mstamp_refresh(tcp_sk(sk));
 	/* Send it off. */
@@ -4096,7 +4100,7 @@ int tcp_connect(struct sock *sk)
 	/* SYN eats a sequence byte, write_seq updated by
 	 * tcp_connect_queue_skb().
 	 */
-	tcp_init_nondata_skb(buff, tp->write_seq, TCPHDR_SYN);
+	tcp_init_nondata_skb(buff, sk, tp->write_seq, TCPHDR_SYN);
 	tcp_mstamp_refresh(tp);
 	tp->retrans_stamp = tcp_time_stamp_ts(tp);
 	tcp_connect_queue_skb(sk, buff);
@@ -4221,7 +4225,8 @@ void __tcp_send_ack(struct sock *sk, u32 rcv_nxt, u16 flags)
 
 	/* Reserve space for headers and prepare control bits. */
 	skb_reserve(buff, MAX_TCP_HEADER);
-	tcp_init_nondata_skb(buff, tcp_acceptable_seq(sk), TCPHDR_ACK | flags);
+	tcp_init_nondata_skb(buff, sk,
+			     tcp_acceptable_seq(sk), TCPHDR_ACK | flags);
 
 	/* We do not want pure acks influencing TCP Small Queues or fq/pacing
 	 * too much.
@@ -4267,7 +4272,7 @@ static int tcp_xmit_probe_skb(struct sock *sk, int urgent, int mib)
 	 * end to send an ack.  Don't queue or clone SKB, just
 	 * send it.
 	 */
-	tcp_init_nondata_skb(skb, tp->snd_una - !urgent, TCPHDR_ACK);
+	tcp_init_nondata_skb(skb, sk, tp->snd_una - !urgent, TCPHDR_ACK);
 	NET_INC_STATS(sock_net(sk), mib);
 	return tcp_transmit_skb(sk, skb, 0, (__force gfp_t)0);
 }
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 08dabc47a6e7..83490cab2e4a 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -62,6 +62,7 @@
 #include <net/hotdata.h>
 #include <net/busy_poll.h>
 #include <net/rstreason.h>
+#include <net/psp.h>
 
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
@@ -972,6 +973,7 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 	if (sk) {
 		/* unconstify the socket only to attach it to buff with care. */
 		skb_set_owner_edemux(buff, (struct sock *)sk);
+		psp_reply_set_decrypted(buff);
 
 		if (sk->sk_state == TCP_TIME_WAIT)
 			mark = inet_twsk(sk)->tw_mark;
@@ -1604,6 +1606,10 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	if (skb->protocol == htons(ETH_P_IP))
 		return tcp_v4_do_rcv(sk, skb);
 
+	reason = psp_sk_rx_policy_check(sk, skb);
+	if (reason)
+		goto err_discard;
+
 	/*
 	 *	socket locking is here for SMP purposes as backlog rcv
 	 *	is currently called with bh processing disabled.
@@ -1683,6 +1689,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	reason = SKB_DROP_REASON_TCP_CSUM;
 	trace_tcp_bad_csum(skb);
 	TCP_INC_STATS(sock_net(sk), TCP_MIB_CSUMERRORS);
+err_discard:
 	TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
 	goto discard;
 
@@ -1987,6 +1994,10 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 			__this_cpu_write(tcp_tw_isn, isn);
 			goto process;
 		}
+
+		drop_reason = psp_twsk_rx_policy_check(inet_twsk(sk), skb);
+		if (drop_reason)
+			break;
 	}
 		/* to ACK */
 		fallthrough;
-- 
2.51.0


