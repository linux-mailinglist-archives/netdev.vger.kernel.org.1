Return-Path: <netdev+bounces-95265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 535948C1CB2
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCC1B1F222D7
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4441149C4A;
	Fri, 10 May 2024 03:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blDHSvuY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15181494DB
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 03:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310287; cv=none; b=LWHFqUx9xAXqSQBWCQWv08n5DwsTItZ9yo7CnnFXHCQNNdi5bcgLyD1nYcckUWO2R8p1a9ChMP//RmDDAdk19WmGxyeRw9d5pOTa8wupYCSOWw4Im5rcvDzrZyJembV6AD7rQT+w4vmEHN+MPYtXW98znDPAoM4Ds0D0kUxDO2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310287; c=relaxed/simple;
	bh=Ym6ILrcUtQ1GojIxH94PPU61ka8pqvHFVJYm017G8y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdImzhOtRdLBvghs240nJhJh4WWU1w70nybV/+/jq1BFbu7JXQ6ojl5ogF6B1Rl+EUF2/3FMElkSnG22x8/UsiR+TjAkzHhBPhlfvRKGPjnJwZCkDgffkju/hIvj+4HdpvGPcDna6PKcF2nmp3EkuNl9QE/xc+tplOfV93UbieA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blDHSvuY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3282C32786;
	Fri, 10 May 2024 03:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715310287;
	bh=Ym6ILrcUtQ1GojIxH94PPU61ka8pqvHFVJYm017G8y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=blDHSvuYncQZCjHUZJFS+wT6wpBSksL38qUKzZGEO5P3oNizSUfMUIm2lIQTpWmQd
	 WltPvEX1y0rum+dVk5dmkMb/thz19gKKHbGy4rnC5WZaVhJvGjeGxTs109qeEMIJHZ
	 R1kgPk3Lqz8e/spNQQOYmh8pm8K8wH4N6Aq/u7dUypq7LKHlPqk899GYSTJE9H4zGX
	 pcM/vg361aB4nkrQ4WD3NmP7YiZyAqo02kfHuMEQXoSpcJxe0Ztc8aweHtrc+7mfZS
	 TOf6qt3F5wxSh/EDMonbLzcX2VWrk53vZZ6HMgCSJ9yAjizZnwnJizksQgKEi2TZeg
	 NljDb0EBjY3uQ==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	borisp@nvidia.com,
	gal@nvidia.com,
	cratiu@nvidia.com,
	rrameshbabu@nvidia.com,
	steffen.klassert@secunet.com,
	tariqt@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 04/15] tcp: add datapath logic for PSP with inline key exchange
Date: Thu,  9 May 2024 20:04:24 -0700
Message-ID: <20240510030435.120935-5-kuba@kernel.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510030435.120935-1-kuba@kernel.org>
References: <20240510030435.120935-1-kuba@kernel.org>
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

Add trivialities like GRO and coalescing checks.

This change only adds the validation points, for ease of review.
Subsequent change will add the ability to install keys, and flesh
the enforcement logic out

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/dropreason-core.h |  6 +++
 include/net/psp/functions.h   | 74 +++++++++++++++++++++++++++++++++++
 net/core/gro.c                |  2 +
 net/ipv4/tcp.c                |  2 +
 net/ipv4/tcp_ipv4.c           |  9 ++++-
 net/ipv4/tcp_minisocks.c      | 15 +++++++
 net/ipv4/tcp_output.c         | 16 +++++---
 net/ipv6/tcp_ipv6.c           | 10 +++++
 net/psp/Kconfig               |  1 +
 9 files changed, 128 insertions(+), 7 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 9707ab54fdd5..29f1de9f5148 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -92,6 +92,8 @@
 	FN(PACKET_SOCK_ERROR)		\
 	FN(TC_CHAIN_NOTFOUND)		\
 	FN(TC_RECLASSIFY_LOOP)		\
+	FN(PSP_INPUT)			\
+	FN(PSP_OUTPUT)			\
 	FNe(MAX)
 
 /**
@@ -418,6 +420,10 @@ enum skb_drop_reason {
 	 * iterations.
 	 */
 	SKB_DROP_REASON_TC_RECLASSIFY_LOOP,
+	/** @SKB_DROP_REASON_PSP_INPUT: PSP input checks failed */
+	SKB_DROP_REASON_PSP_INPUT,
+	/** @SKB_DROP_REASON_PSP_OUTPUT: PSP output checks failed */
+	SKB_DROP_REASON_PSP_OUTPUT,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/include/net/psp/functions.h b/include/net/psp/functions.h
index 9ff0f2b5744f..7a3b897ecc69 100644
--- a/include/net/psp/functions.h
+++ b/include/net/psp/functions.h
@@ -3,6 +3,8 @@
 #ifndef __NET_PSP_HELPERS_H
 #define __NET_PSP_HELPERS_H
 
+#include <linux/skbuff.h>
+#include <net/sock.h>
 #include <net/psp/types.h>
 
 struct tcp_timewait_sock;
@@ -13,7 +15,79 @@ psp_dev_create(struct net_device *netdev, struct psp_dev_ops *psd_ops,
 	       struct psp_dev_caps *psd_caps, void *priv_ptr);
 void psp_dev_unregister(struct psp_dev *psd);
 
+/* Kernel-facing API */
+#if IS_ENABLED(CONFIG_INET_PSP)
 static inline void psp_sk_assoc_free(struct sock *sk) { }
+static inline void
+psp_twsk_init(struct tcp_timewait_sock *tw, struct sock *sk) { }
 static inline void psp_twsk_assoc_free(struct tcp_timewait_sock *tw) { }
 
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
+psp_twsk_rx_policy_check(struct tcp_timewait_sock *tw, struct sk_buff *skb)
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
+psp_twsk_init(struct tcp_timewait_sock *tw, struct sock *sk) { }
+static inline void psp_twsk_assoc_free(struct tcp_timewait_sock *tw) { }
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
+psp_twsk_rx_policy_check(struct tcp_timewait_sock *tw, struct sk_buff *skb)
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
+
 #endif /* __NET_PSP_HELPERS_H */
diff --git a/net/core/gro.c b/net/core/gro.c
index e2f84947fb74..56c6c0e43a11 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
+#include <net/psp.h>
 #include <net/gro.h>
 #include <net/dst_metadata.h>
 #include <net/busy_poll.h>
@@ -387,6 +388,7 @@ static void gro_list_prepare(const struct list_head *head,
 			diffs |= skb_get_nfct(p) ^ skb_get_nfct(skb);
 
 			diffs |= gro_list_prepare_tc_ext(skb, p, diffs);
+			diffs |= __psp_skb_coalesce_diff(skb, p, diffs);
 		}
 
 		NAPI_GRO_CB(p)->same_flow = !diffs;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 06aab937d60a..b81447bcb884 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -275,6 +275,7 @@
 #include <net/proto_memory.h>
 #include <net/xfrm.h>
 #include <net/ip.h>
+#include <net/psp.h>
 #include <net/sock.h>
 #include <net/rstreason.h>
 
@@ -674,6 +675,7 @@ void tcp_skb_entail(struct sock *sk, struct sk_buff *skb)
 	tcb->seq     = tcb->end_seq = tp->write_seq;
 	tcb->tcp_flags = TCPHDR_ACK;
 	__skb_header_release(skb);
+	psp_enqueue_set_decrypted(sk, skb);
 	tcp_add_write_queue_tail(sk, skb);
 	sk_wmem_queued_add(sk, skb->truesize);
 	sk_mem_charge(sk, skb->truesize);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 95e3d28b83b8..9539c4a7b55d 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -71,6 +71,7 @@
 #include <net/secure_seq.h>
 #include <net/busy_poll.h>
 #include <net/rstreason.h>
+#include <net/psp.h>
 
 #include <linux/inet.h>
 #include <linux/ipv6.h>
@@ -1895,6 +1896,10 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 	enum skb_drop_reason reason;
 	struct sock *rsk;
 
+	reason = psp_sk_rx_policy_check(sk, skb);
+	if (reason)
+		goto err_discard;
+
 	if (sk->sk_state == TCP_ESTABLISHED) { /* Fast path */
 		struct dst_entry *dst;
 
@@ -1956,6 +1961,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 	reason = SKB_DROP_REASON_TCP_CSUM;
 	trace_tcp_bad_csum(skb);
 	TCP_INC_STATS(sock_net(sk), TCP_MIB_CSUMERRORS);
+err_discard:
 	TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
 	goto discard;
 }
@@ -2057,7 +2063,8 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	    !mptcp_skb_can_collapse(tail, skb) ||
 	    skb_cmp_decrypted(tail, skb) ||
 	    thtail->doff != th->doff ||
-	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
+	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)) ||
+	    psp_skb_coalesce_diff(tail, skb))
 		goto no_coalesce;
 
 	__skb_pull(skb, hdrlen);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 660e890f3c74..501b8bc8573e 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -101,8 +101,11 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 {
 	struct tcp_options_received tmp_opt;
 	struct tcp_timewait_sock *tcptw = tcp_twsk((struct sock *)tw);
+	enum skb_drop_reason psp_drop;
 	bool paws_reject = false;
 
+	psp_drop = psp_twsk_rx_policy_check(tcptw, skb);
+
 	tmp_opt.saw_tstamp = 0;
 	if (th->doff > (sizeof(*th) >> 2) && tcptw->tw_ts_recent_stamp) {
 		tcp_parse_options(twsk_net(tw), skb, &tmp_opt, 0, NULL);
@@ -119,6 +122,9 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 	if (tw->tw_substate == TCP_FIN_WAIT2) {
 		/* Just repeat all the checks of tcp_rcv_state_process() */
 
+		if (psp_drop)
+			goto out_put;
+
 		/* Out of window, send ACK */
 		if (paws_reject ||
 		    !tcp_in_window(TCP_SKB_CB(skb)->seq, TCP_SKB_CB(skb)->end_seq,
@@ -183,6 +189,9 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 	     (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq || th->rst))) {
 		/* In window segment, it may be only reset or bare ack. */
 
+		if (psp_drop)
+			goto out_put;
+
 		if (th->rst) {
 			/* This is TIME_WAIT assassination, in two flavors.
 			 * Oh well... nobody has a sufficient solution to this
@@ -234,6 +243,9 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 		return TCP_TW_SYN;
 	}
 
+	if (psp_drop)
+		goto out_put;
+
 	if (paws_reject)
 		__NET_INC_STATS(twsk_net(tw), LINUX_MIB_PAWSESTABREJECTED);
 
@@ -250,6 +262,8 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 		return tcp_timewait_check_oow_rate_limit(
 			tw, skb, LINUX_MIB_TCPACKSKIPPEDTIMEWAIT);
 	}
+
+out_put:
 	inet_twsk_put(tw);
 	return TCP_TW_SUCCESS;
 }
@@ -332,6 +346,7 @@ void tcp_time_wait(struct sock *sk, int state, int timeo)
 
 		tcp_time_wait_init(sk, tcptw);
 		tcp_ao_time_wait(tcptw, tp);
+		psp_twsk_init(tcptw, sk);
 
 		/* Get the TIME_WAIT timeout firing. */
 		if (timeo < rto)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 95caf8aaa8be..90d0a1d759ae 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -40,6 +40,7 @@
 #include <net/tcp.h>
 #include <net/mptcp.h>
 #include <net/proto_memory.h>
+#include <net/psp.h>
 
 #include <linux/compiler.h>
 #include <linux/gfp.h>
@@ -400,13 +401,15 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 /* Constructs common control bits of non-data skb. If SYN/FIN is present,
  * auto increment end seqno.
  */
-static void tcp_init_nondata_skb(struct sk_buff *skb, u32 seq, u8 flags)
+static void tcp_init_nondata_skb(struct sk_buff *skb, struct sock *sk,
+				 u32 seq, u8 flags)
 {
 	skb->ip_summed = CHECKSUM_PARTIAL;
 
 	TCP_SKB_CB(skb)->tcp_flags = flags;
 
 	tcp_skb_pcount_set(skb, 1);
+	psp_enqueue_set_decrypted(sk, skb);
 
 	TCP_SKB_CB(skb)->seq = seq;
 	if (flags & (TCPHDR_SYN | TCPHDR_FIN))
@@ -1497,6 +1500,7 @@ static void tcp_queue_skb(struct sock *sk, struct sk_buff *skb)
 	/* Advance write_seq and place onto the write_queue. */
 	WRITE_ONCE(tp->write_seq, TCP_SKB_CB(skb)->end_seq);
 	__skb_header_release(skb);
+	psp_enqueue_set_decrypted(sk, skb);
 	tcp_add_write_queue_tail(sk, skb);
 	sk_wmem_queued_add(sk, skb->truesize);
 	sk_mem_charge(sk, skb->truesize);
@@ -3611,7 +3615,7 @@ void tcp_send_fin(struct sock *sk)
 		skb_reserve(skb, MAX_TCP_HEADER);
 		sk_forced_mem_schedule(sk, skb->truesize);
 		/* FIN eats a sequence byte, write_seq advanced by tcp_queue_skb(). */
-		tcp_init_nondata_skb(skb, tp->write_seq,
+		tcp_init_nondata_skb(skb, sk, tp->write_seq,
 				     TCPHDR_ACK | TCPHDR_FIN);
 		tcp_queue_skb(sk, skb);
 	}
@@ -3639,7 +3643,7 @@ void tcp_send_active_reset(struct sock *sk, gfp_t priority,
 
 	/* Reserve space for headers and prepare control bits. */
 	skb_reserve(skb, MAX_TCP_HEADER);
-	tcp_init_nondata_skb(skb, tcp_acceptable_seq(sk),
+	tcp_init_nondata_skb(skb, sk, tcp_acceptable_seq(sk),
 			     TCPHDR_ACK | TCPHDR_RST);
 	tcp_mstamp_refresh(tcp_sk(sk));
 	/* Send it off. */
@@ -4129,7 +4133,7 @@ int tcp_connect(struct sock *sk)
 	if (unlikely(!buff))
 		return -ENOBUFS;
 
-	tcp_init_nondata_skb(buff, tp->write_seq++, TCPHDR_SYN);
+	tcp_init_nondata_skb(buff, sk, tp->write_seq++, TCPHDR_SYN);
 	tcp_mstamp_refresh(tp);
 	tp->retrans_stamp = tcp_time_stamp_ts(tp);
 	tcp_connect_queue_skb(sk, buff);
@@ -4261,7 +4265,7 @@ void __tcp_send_ack(struct sock *sk, u32 rcv_nxt)
 
 	/* Reserve space for headers and prepare control bits. */
 	skb_reserve(buff, MAX_TCP_HEADER);
-	tcp_init_nondata_skb(buff, tcp_acceptable_seq(sk), TCPHDR_ACK);
+	tcp_init_nondata_skb(buff, sk, tcp_acceptable_seq(sk), TCPHDR_ACK);
 
 	/* We do not want pure acks influencing TCP Small Queues or fq/pacing
 	 * too much.
@@ -4307,7 +4311,7 @@ static int tcp_xmit_probe_skb(struct sock *sk, int urgent, int mib)
 	 * end to send an ack.  Don't queue or clone SKB, just
 	 * send it.
 	 */
-	tcp_init_nondata_skb(skb, tp->snd_una - !urgent, TCPHDR_ACK);
+	tcp_init_nondata_skb(skb, sk, tp->snd_una - !urgent, TCPHDR_ACK);
 	NET_INC_STATS(sock_net(sk), mib);
 	return tcp_transmit_skb(sk, skb, 0, (__force gfp_t)0);
 }
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 37201c4fb393..6991464511c3 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -61,6 +61,7 @@
 #include <net/hotdata.h>
 #include <net/busy_poll.h>
 #include <net/rstreason.h>
+#include <net/psp.h>
 
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
@@ -1607,6 +1608,10 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	if (skb->protocol == htons(ETH_P_IP))
 		return tcp_v4_do_rcv(sk, skb);
 
+	reason = psp_sk_rx_policy_check(sk, skb);
+	if (reason)
+		goto err_discard;
+
 	/*
 	 *	socket locking is here for SMP purposes as backlog rcv
 	 *	is currently called with bh processing disabled.
@@ -1688,6 +1693,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	reason = SKB_DROP_REASON_TCP_CSUM;
 	trace_tcp_bad_csum(skb);
 	TCP_INC_STATS(sock_net(sk), TCP_MIB_CSUMERRORS);
+err_discard:
 	TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
 	goto discard;
 
@@ -1992,6 +1998,10 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 			__this_cpu_write(tcp_tw_isn, isn);
 			goto process;
 		}
+
+		drop_reason = psp_twsk_rx_policy_check(tcp_twsk(sk), skb);
+		if (drop_reason)
+			break;
 	}
 		/* to ACK */
 		fallthrough;
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
-- 
2.45.0


