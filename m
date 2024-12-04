Return-Path: <netdev+bounces-148869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BF59E348C
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08DCF166638
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 07:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16A81B4F15;
	Wed,  4 Dec 2024 07:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iT4TYs2z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB51E1B4F2B
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 07:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298539; cv=none; b=iiR4nR+JtURdksHwx+sEGXuOo0KGIrbmSeg+BCkLvQyvp+CjRJ4ki1UdAK0E+qExVpDsq/n6qoYMLjx3mcl3U6Iu3AWsgavEu5PjyVPXQJWR03Dudr7Zn/6ZfKHTUXOp2Vo7DgMHIFAcOIVohYb+YzUKf5FL8ttrslGsTnVQ+dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298539; c=relaxed/simple;
	bh=VAliRorX+ta7PgvEOLO2MH9IkUeE/arKRtXPlzVv8II=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMFJIPV0gL1irEM0COCrknZ7ymGXCAyfyjFNIGBLHp6q9O0DvhERE2d0KEbqjdE3zy2gKdkj/lKQmZM2ILp6NOXjrJBybS+qqj6DbrGBpnMad31KTx/Fcq3fsu8dh2DxSz5z03JpclxnUHFC9wcnNNs3Wt4NJhZDN7tcFRyJErQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iT4TYs2z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733298536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h2FDDaF9XMrWQ8p6p5PDq2e3W8Wy7Hq7/tRJ0aFTjno=;
	b=iT4TYs2zKBdbAdXJ/pkUE524WNNNxR0C/k21Sqn0sEodDIrMbs1CthNMAgwPOR3pCLFrDN
	oVB6fcJEDD8XVd8xz/T/ccTD7icmvUvSJTemuYI7EPW2PAwZ8O2kGXdiF/tdv+L4g6svwb
	5j/cZtJhrEBVfbnMEk4zK8KCCBqSkBk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-LS3GYMKXPqC8A6iwMy9Y_w-1; Wed,
 04 Dec 2024 02:48:54 -0500
X-MC-Unique: LS3GYMKXPqC8A6iwMy9Y_w-1
X-Mimecast-MFC-AGG-ID: LS3GYMKXPqC8A6iwMy9Y_w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 746E81954ADC;
	Wed,  4 Dec 2024 07:48:53 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9984F3000197;
	Wed,  4 Dec 2024 07:48:50 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 23/39] rxrpc: Use the new rxrpc_tx_queue struct to more efficiently process ACKs
Date: Wed,  4 Dec 2024 07:46:51 +0000
Message-ID: <20241204074710.990092-24-dhowells@redhat.com>
In-Reply-To: <20241204074710.990092-1-dhowells@redhat.com>
References: <20241204074710.990092-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

With the change in the structure of the transmission buffer to store
buffers in bunches of 32 or 64 (BITS_PER_LONG) we can place sets of
per-buffer flags into the rxrpc_tx_queue struct rather than storing them in
rxrpc_tx_buf, thereby vastly increasing efficiency when assessing the SACK
table in an ACK packet.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h |  86 ++++++++++--
 net/rxrpc/ar-internal.h      |  23 +++-
 net/rxrpc/call_event.c       | 181 ++++++++++++-------------
 net/rxrpc/call_object.c      |   1 -
 net/rxrpc/input.c            | 252 ++++++++++++++++++++++-------------
 net/rxrpc/output.c           |  10 +-
 net/rxrpc/sendmsg.c          |   3 +
 7 files changed, 352 insertions(+), 204 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index d47b8235fad3..609522a5bd0f 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -132,7 +132,6 @@
 	EM(rxrpc_skb_get_call_rx,		"GET call-rx  ") \
 	EM(rxrpc_skb_get_conn_secured,		"GET conn-secd") \
 	EM(rxrpc_skb_get_conn_work,		"GET conn-work") \
-	EM(rxrpc_skb_get_last_nack,		"GET last-nack") \
 	EM(rxrpc_skb_get_local_work,		"GET locl-work") \
 	EM(rxrpc_skb_get_reject_work,		"GET rej-work ") \
 	EM(rxrpc_skb_get_to_recvmsg,		"GET to-recv  ") \
@@ -147,7 +146,6 @@
 	EM(rxrpc_skb_put_error_report,		"PUT error-rep") \
 	EM(rxrpc_skb_put_input,			"PUT input    ") \
 	EM(rxrpc_skb_put_jumbo_subpacket,	"PUT jumbo-sub") \
-	EM(rxrpc_skb_put_last_nack,		"PUT last-nack") \
 	EM(rxrpc_skb_put_purge,			"PUT purge    ") \
 	EM(rxrpc_skb_put_rotate,		"PUT rotate   ") \
 	EM(rxrpc_skb_put_unknown,		"PUT unknown  ") \
@@ -499,6 +497,11 @@
 	EM(rxrpc_pmtud_reduce_icmp,		"Icmp ")	\
 	E_(rxrpc_pmtud_reduce_route,		"Route")
 
+#define rxrpc_rotate_traces \
+	EM(rxrpc_rotate_trace_hack,		"hard-ack")	\
+	EM(rxrpc_rotate_trace_sack,		"soft-ack")	\
+	E_(rxrpc_rotate_trace_snak,		"soft-nack")
+
 /*
  * Generate enums for tracing information.
  */
@@ -525,6 +528,7 @@ enum rxrpc_propose_ack_trace	{ rxrpc_propose_ack_traces } __mode(byte);
 enum rxrpc_receive_trace	{ rxrpc_receive_traces } __mode(byte);
 enum rxrpc_recvmsg_trace	{ rxrpc_recvmsg_traces } __mode(byte);
 enum rxrpc_req_ack_trace	{ rxrpc_req_ack_traces } __mode(byte);
+enum rxrpc_rotate_trace		{ rxrpc_rotate_traces } __mode(byte);
 enum rxrpc_rtt_rx_trace		{ rxrpc_rtt_rx_traces } __mode(byte);
 enum rxrpc_rtt_tx_trace		{ rxrpc_rtt_tx_traces } __mode(byte);
 enum rxrpc_sack_trace		{ rxrpc_sack_traces } __mode(byte);
@@ -562,6 +566,7 @@ rxrpc_propose_ack_traces;
 rxrpc_receive_traces;
 rxrpc_recvmsg_traces;
 rxrpc_req_ack_traces;
+rxrpc_rotate_traces;
 rxrpc_rtt_rx_traces;
 rxrpc_rtt_tx_traces;
 rxrpc_sack_traces;
@@ -1667,6 +1672,7 @@ TRACE_EVENT(rxrpc_retransmit,
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,	call)
+		    __field(unsigned int,	qbase)
 		    __field(rxrpc_seq_t,	seq)
 		    __field(rxrpc_serial_t,	serial)
 		    __field(ktime_t,		expiry)
@@ -1674,13 +1680,15 @@ TRACE_EVENT(rxrpc_retransmit,
 
 	    TP_fast_assign(
 		    __entry->call = call->debug_id;
+		    __entry->qbase = req->tq->qbase;
 		    __entry->seq = req->seq;
 		    __entry->serial = txb->serial;
 		    __entry->expiry = expiry;
 			   ),
 
-	    TP_printk("c=%08x q=%x r=%x xp=%lld",
+	    TP_printk("c=%08x tq=%x q=%x r=%x xp=%lld",
 		      __entry->call,
+		      __entry->qbase,
 		      __entry->seq,
 		      __entry->serial,
 		      ktime_to_us(__entry->expiry))
@@ -1724,7 +1732,7 @@ TRACE_EVENT(rxrpc_congest,
 		    memcpy(&__entry->sum, summary, sizeof(__entry->sum));
 			   ),
 
-	    TP_printk("c=%08x r=%08x %s q=%08x %s cw=%u ss=%u nA=%u,%u+%u,%u b=%u u=%u d=%u l=%x%s%s%s",
+	    TP_printk("c=%08x r=%08x %s q=%08x %s cw=%u ss=%u A=%u+%u/%u+%u r=%u b=%u u=%u d=%u l=%x%s%s%s",
 		      __entry->call,
 		      __entry->ack_serial,
 		      __print_symbolic(__entry->sum.ack_reason, rxrpc_ack_names),
@@ -1732,9 +1740,9 @@ TRACE_EVENT(rxrpc_congest,
 		      __print_symbolic(__entry->ca_state, rxrpc_ca_states),
 		      __entry->cwnd,
 		      __entry->ssthresh,
-		      __entry->nr_sacks, __entry->sum.nr_retained_snacks,
-		      __entry->sum.nr_new_sacks,
-		      __entry->sum.nr_new_snacks,
+		      __entry->nr_sacks, __entry->sum.nr_new_sacks,
+		      __entry->nr_snacks, __entry->sum.nr_new_snacks,
+		      __entry->sum.nr_new_hacks,
 		      __entry->top - __entry->hard_ack,
 		      __entry->cumul_acks,
 		      __entry->dup_acks,
@@ -1850,10 +1858,36 @@ TRACE_EVENT(rxrpc_connect_call,
 		      &__entry->srx.transport)
 	    );
 
+TRACE_EVENT(rxrpc_apply_acks,
+	    TP_PROTO(struct rxrpc_call *call, struct rxrpc_txqueue *tq),
+
+	    TP_ARGS(call, tq),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	call)
+		    __field(unsigned int,	nr_rep)
+		    __field(rxrpc_seq_t,	qbase)
+		    __field(unsigned long,	acks)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->call = call->debug_id;
+		    __entry->qbase = tq->qbase;
+		    __entry->acks = tq->segment_acked;
+		    __entry->nr_rep = tq->nr_reported_acks;
+			   ),
+
+	    TP_printk("c=%08x tq=%x acks=%016lx rep=%u",
+		      __entry->call,
+		      __entry->qbase,
+		      __entry->acks,
+		      __entry->nr_rep)
+	    );
+
 TRACE_EVENT(rxrpc_resend,
-	    TP_PROTO(struct rxrpc_call *call, struct sk_buff *ack),
+	    TP_PROTO(struct rxrpc_call *call, rxrpc_serial_t ack_serial),
 
-	    TP_ARGS(call, ack),
+	    TP_ARGS(call, ack_serial),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,	call)
@@ -1863,11 +1897,10 @@ TRACE_EVENT(rxrpc_resend,
 			     ),
 
 	    TP_fast_assign(
-		    struct rxrpc_skb_priv *sp = ack ? rxrpc_skb(ack) : NULL;
 		    __entry->call = call->debug_id;
 		    __entry->seq = call->acks_hard_ack;
 		    __entry->transmitted = call->tx_transmitted;
-		    __entry->ack_serial = sp ? sp->hdr.serial : 0;
+		    __entry->ack_serial = ack_serial;
 			   ),
 
 	    TP_printk("c=%08x r=%x q=%x tq=%x",
@@ -1877,6 +1910,37 @@ TRACE_EVENT(rxrpc_resend,
 		      __entry->transmitted)
 	    );
 
+TRACE_EVENT(rxrpc_rotate,
+	    TP_PROTO(struct rxrpc_call *call, struct rxrpc_txqueue *tq,
+		     struct rxrpc_ack_summary *summary, rxrpc_seq_t seq,
+		     enum rxrpc_rotate_trace trace),
+
+	    TP_ARGS(call, tq, summary, seq, trace),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	call)
+		    __field(rxrpc_seq_t,	qbase)
+		    __field(rxrpc_seq_t,	seq)
+		    __field(unsigned int,	nr_rep)
+		    __field(enum rxrpc_rotate_trace, trace)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->call = call->debug_id;
+		    __entry->qbase = tq->qbase;
+		    __entry->seq = seq;
+		    __entry->nr_rep = tq->nr_reported_acks;
+		    __entry->trace = trace;
+			   ),
+
+	    TP_printk("c=%08x tq=%x q=%x nr=%x %s",
+		      __entry->call,
+		      __entry->qbase,
+		      __entry->seq,
+		      __entry->nr_rep,
+		      __print_symbolic(__entry->trace, rxrpc_rotate_traces))
+	    );
+
 TRACE_EVENT(rxrpc_rx_icmp,
 	    TP_PROTO(struct rxrpc_peer *peer, struct sock_extended_err *ee,
 		     struct sockaddr_rxrpc *srx),
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index f6e6b2ab6c2a..9a70f0b86570 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -214,9 +214,8 @@ struct rxrpc_skb_priv {
 			rxrpc_seq_t	first_ack;	/* First packet in acks table */
 			rxrpc_seq_t	prev_ack;	/* Highest seq seen */
 			rxrpc_serial_t	acked_serial;	/* Packet in response to (or 0) */
+			u16		nr_acks;	/* Number of acks+nacks */
 			u8		reason;		/* Reason for ack */
-			u8		nr_acks;	/* Number of acks+nacks */
-			u8		nr_nacks;	/* Number of nacks */
 		} ack;
 	};
 	struct rxrpc_host_header hdr;	/* RxRPC packet header from this packet */
@@ -734,7 +733,6 @@ struct rxrpc_call {
 	u16			cong_dup_acks;	/* Count of ACKs showing missing packets */
 	u16			cong_cumul_acks; /* Cumulative ACK count */
 	ktime_t			cong_tstamp;	/* Last time cwnd was changed */
-	struct sk_buff		*cong_last_nack; /* Last ACK with nacks received */
 
 	/* Receive-phase ACK management (ACKs we send). */
 	u8			ackr_reason;	/* reason to ACK */
@@ -775,11 +773,10 @@ struct rxrpc_ack_summary {
 	u16		nr_new_hacks;		/* Number of rotated new ACKs */
 	u16		nr_new_sacks;		/* Number of new soft ACKs in packet */
 	u16		nr_new_snacks;		/* Number of new soft nacks in packet */
-	u16		nr_retained_snacks;	/* Number of nacks retained between ACKs */
 	u8		ack_reason;
-	bool		saw_snacks:1;		/* T if we saw a soft NACK */
 	bool		new_low_snack:1;	/* T if new low soft NACK found */
 	bool		retrans_timeo:1;	/* T if reTx due to timeout happened */
+	bool		need_retransmit:1;	/* T if we need transmission */
 	u8 /*enum rxrpc_congest_change*/ change;
 };
 
@@ -858,6 +855,10 @@ struct rxrpc_txqueue {
 	struct rxrpc_txqueue	*next;
 	ktime_t			xmit_ts_base;
 	rxrpc_seq_t		qbase;
+	u8			nr_reported_acks; /* Number of segments explicitly acked/nacked */
+	unsigned long		segment_acked;	/* Bit-per-buf: Set if ACK'd */
+	unsigned long		segment_lost;	/* Bit-per-buf: Set if declared lost */
+	unsigned long		segment_retransmitted; /* Bit-per-buf: Set if retransmitted */
 
 	/* The arrays we want to pack into as few cache lines as possible. */
 	struct {
@@ -935,7 +936,7 @@ void rxrpc_propose_ping(struct rxrpc_call *call, u32 serial,
 			enum rxrpc_propose_ack_trace why);
 void rxrpc_propose_delay_ACK(struct rxrpc_call *, rxrpc_serial_t,
 			     enum rxrpc_propose_ack_trace);
-void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb);
+void rxrpc_resend(struct rxrpc_call *call, rxrpc_serial_t ack_serial, bool ping_response);
 
 bool rxrpc_input_call_event(struct rxrpc_call *call);
 
@@ -1383,6 +1384,16 @@ static inline bool after_eq(u32 seq1, u32 seq2)
         return (s32)(seq1 - seq2) >= 0;
 }
 
+static inline u32 earliest(u32 seq1, u32 seq2)
+{
+	return before(seq1, seq2) ? seq1 : seq2;
+}
+
+static inline u32 latest(u32 seq1, u32 seq2)
+{
+	return after(seq1, seq2) ? seq1 : seq2;
+}
+
 static inline void rxrpc_queue_rx_call_packet(struct rxrpc_call *call, struct sk_buff *skb)
 {
 	rxrpc_get_skb(skb, rxrpc_skb_get_call_rx);
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 2311e5c737e8..e25921d39d4d 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -65,9 +65,9 @@ static void rxrpc_congestion_timeout(struct rxrpc_call *call)
 /*
  * Retransmit one or more packets.
  */
-static void rxrpc_retransmit_data(struct rxrpc_call *call,
+static bool rxrpc_retransmit_data(struct rxrpc_call *call,
 				  struct rxrpc_send_data_req *req,
-				  ktime_t rto)
+				  ktime_t rto, bool skip_too_young)
 {
 	struct rxrpc_txqueue *tq = req->tq;
 	unsigned int ix = req->seq & RXRPC_TXQ_MASK;
@@ -78,9 +78,11 @@ static void rxrpc_retransmit_data(struct rxrpc_call *call,
 
 	xmit_ts = ktime_add_us(tq->xmit_ts_base, tq->segment_xmit_ts[ix]);
 	resend_at = ktime_add(xmit_ts, rto);
-	trace_rxrpc_retransmit(call, req, txb,
-			       ktime_sub(resend_at, req->now));
+	trace_rxrpc_retransmit(call, req, txb, ktime_sub(resend_at, req->now));
+	if (skip_too_young && ktime_after(resend_at, req->now))
+		return false;
 
+	__set_bit(ix, &tq->segment_retransmitted);
 	txb->flags |= RXRPC_TXBUF_RESENT;
 	rxrpc_send_data_packet(call, req);
 	rxrpc_inc_stat(call->rxnet, stat_tx_data_retrans);
@@ -89,128 +91,119 @@ static void rxrpc_retransmit_data(struct rxrpc_call *call,
 	req->n		= 0;
 	req->did_send	= true;
 	req->now	= ktime_get_real();
+	return true;
 }
 
 /*
  * Perform retransmission of NAK'd and unack'd packets.
  */
-void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
+void rxrpc_resend(struct rxrpc_call *call, rxrpc_serial_t ack_serial, bool ping_response)
 {
 	struct rxrpc_send_data_req req = {
 		.now	= ktime_get_real(),
 	};
-	struct rxrpc_ackpacket *ack = NULL;
-	struct rxrpc_skb_priv *sp;
-	struct rxrpc_txqueue *tq;
-	struct rxrpc_txbuf *txb;
-	rxrpc_seq_t transmitted = call->tx_transmitted, seq;
-	ktime_t next_resend = KTIME_MAX, rto = ns_to_ktime(call->peer->rto_us * NSEC_PER_USEC);
-	ktime_t resend_at = KTIME_MAX, delay;
-	bool unacked = false, did_send = false;
-	unsigned int qix;
+	struct rxrpc_txqueue *tq = call->tx_queue;
+	ktime_t lowest_xmit_ts = KTIME_MAX, rto	= ns_to_ktime(call->peer->rto_us * NSEC_PER_USEC);
+	bool unacked = false;
 
 	_enter("{%d,%d}", call->tx_bottom, call->tx_top);
 
-	if (call->tx_bottom == call->tx_top)
-		goto no_resend;
+	if (call->tx_bottom == call->tx_top) {
+		call->resend_at = KTIME_MAX;
+		trace_rxrpc_timer_can(call, rxrpc_timer_trace_resend);
+		return;
+	}
 
-	trace_rxrpc_resend(call, ack_skb);
-	tq = call->tx_queue;
-	seq = call->tx_bottom;
+	trace_rxrpc_resend(call, ack_serial);
 
-	/* Scan the soft ACK table and resend any explicitly NAK'd packets. */
-	if (ack_skb) {
-		sp = rxrpc_skb(ack_skb);
-		ack = (void *)ack_skb->data + sizeof(struct rxrpc_wire_header);
+	/* Scan the transmission queue, looking for explicitly NAK'd packets. */
+	do {
+		unsigned long naks = ~tq->segment_acked;
+		rxrpc_seq_t tq_top = tq->qbase + RXRPC_NR_TXQUEUE - 1;
 
-		for (int i = 0; i < sp->ack.nr_acks; i++) {
-			rxrpc_seq_t aseq;
+		if (after(tq->qbase, call->tx_transmitted))
+			break;
 
-			if (ack->acks[i] & 1)
-				continue;
-			aseq = sp->ack.first_ack + i;
-			while (after_eq(aseq, tq->qbase + RXRPC_NR_TXQUEUE))
-				tq = tq->next;
-			seq = aseq;
-			qix = seq - tq->qbase;
-			txb = tq->bufs[qix];
-			if (after(seq, transmitted))
-				goto no_further_resend;
-
-			resend_at = ktime_add_us(tq->xmit_ts_base, tq->segment_xmit_ts[qix]);
-			resend_at = ktime_add(resend_at, rto);
-			if (after(txb->serial, call->acks_highest_serial)) {
-				if (ktime_after(resend_at, req.now) &&
-				    ktime_before(resend_at, next_resend))
-					next_resend = resend_at;
+		if (tq->nr_reported_acks < RXRPC_NR_TXQUEUE)
+			naks &= (1UL << tq->nr_reported_acks) - 1;
+
+		_debug("retr %16lx %u c=%08x [%x]",
+		       tq->segment_acked, tq->nr_reported_acks, call->debug_id, tq->qbase);
+		_debug("nack %16lx", naks);
+
+		while (naks) {
+			unsigned int ix = __ffs(naks);
+			struct rxrpc_txbuf *txb = tq->bufs[ix];
+
+			__clear_bit(ix, &naks);
+			if (after(txb->serial, call->acks_highest_serial))
 				continue; /* Ack point not yet reached */
-			}
 
 			rxrpc_see_txbuf(txb, rxrpc_txbuf_see_unacked);
 
 			req.tq  = tq;
-			req.seq = seq;
+			req.seq = tq->qbase + ix;
 			req.n   = 1;
-			rxrpc_retransmit_data(call, &req, rto);
-
-			if (after_eq(seq, call->tx_top))
-				goto no_further_resend;
+			rxrpc_retransmit_data(call, &req, rto, false);
 		}
-	}
 
-	/* Fast-forward through the Tx queue to the point the peer says it has
-	 * seen.  Anything between the soft-ACK table and that point will get
-	 * ACK'd or NACK'd in due course, so don't worry about it here; here we
-	 * need to consider retransmitting anything beyond that point.
-	 */
-	seq = call->acks_prev_seq;
-	if (after_eq(seq, call->tx_transmitted))
-		goto no_further_resend;
-	seq++;
-
-	while (after_eq(seq, tq->qbase + RXRPC_NR_TXQUEUE))
-		tq = tq->next;
-
-	while (before_eq(seq, call->tx_transmitted)) {
-		qix = seq - tq->qbase;
-		if (qix >= RXRPC_NR_TXQUEUE) {
-			tq = tq->next;
-			continue;
+		/* Anything after the soft-ACK table up to and including
+		 * ack.previousPacket will get ACK'd or NACK'd in due course,
+		 * so don't worry about those here.  We do, however, need to
+		 * consider retransmitting anything beyond that point.
+		 */
+		if (tq->nr_reported_acks < RXRPC_NR_TXQUEUE &&
+		    after(tq_top, call->acks_prev_seq)) {
+			rxrpc_seq_t start = latest(call->acks_prev_seq,
+						   tq->qbase + tq->nr_reported_acks);
+			rxrpc_seq_t stop = earliest(tq_top, call->tx_transmitted);
+
+			_debug("unrep %x-%x", start, stop);
+			for (rxrpc_seq_t seq = start; before(seq, stop); seq++) {
+				struct rxrpc_txbuf *txb = tq->bufs[seq & RXRPC_TXQ_MASK];
+
+				if (ping_response &&
+				    before(txb->serial, call->acks_highest_serial))
+					break; /* Wasn't accounted for by a more recent ping. */
+				req.tq  = tq;
+				req.seq = seq;
+				req.n   = 1;
+				if (rxrpc_retransmit_data(call, &req, rto, true))
+					unacked = true;
+			}
 		}
-		txb = tq->bufs[qix];
-		resend_at = ktime_add_us(tq->xmit_ts_base, tq->segment_xmit_ts[qix]);
-		resend_at = ktime_add(resend_at, rto);
 
-		if (ack && ack->reason == RXRPC_ACK_PING_RESPONSE &&
-		    before(txb->serial, ntohl(ack->serial)))
-			goto do_resend; /* Wasn't accounted for by a more recent ping. */
+		/* Work out the next retransmission timeout. */
+		if (ktime_before(tq->xmit_ts_base, lowest_xmit_ts)) {
+			unsigned int lowest_us = UINT_MAX;
 
-		if (ktime_after(resend_at, req.now)) {
-			if (ktime_before(resend_at, next_resend))
-				next_resend = resend_at;
-			seq++;
-			continue;
-		}
+			for (int i = 0; i < RXRPC_NR_TXQUEUE; i++)
+				if (!test_bit(i, &tq->segment_acked) &&
+				    tq->segment_xmit_ts[i] < lowest_us)
+					lowest_us = tq->segment_xmit_ts[i];
+			_debug("lowest[%x] %llx %u", tq->qbase, tq->xmit_ts_base, lowest_us);
 
-	do_resend:
-		unacked = true;
+			if (lowest_us != UINT_MAX) {
+				ktime_t lowest_ns = ktime_add_us(tq->xmit_ts_base, lowest_us);
 
-		req.tq  = tq;
-		req.seq = seq;
-		req.n   = 1;
-		rxrpc_retransmit_data(call, &req, rto);
-		seq++;
-	}
+				if (ktime_before(lowest_ns, lowest_xmit_ts))
+					lowest_xmit_ts = lowest_ns;
+			}
+		}
+	} while ((tq = tq->next));
+
+	if (lowest_xmit_ts < KTIME_MAX) {
+		ktime_t delay = rxrpc_get_rto_backoff(call->peer, req.did_send);
+		ktime_t resend_at = ktime_add(lowest_xmit_ts, delay);
 
-no_further_resend:
-no_resend:
-	if (resend_at < KTIME_MAX) {
-		delay = rxrpc_get_rto_backoff(call->peer, did_send);
-		resend_at = ktime_add(resend_at, delay);
+		_debug("delay %llu %lld", delay, ktime_sub(resend_at, req.now));
+		call->resend_at = resend_at;
 		trace_rxrpc_timer_set(call, resend_at - req.now,
 				      rxrpc_timer_trace_resend_reset);
+	} else {
+		call->resend_at = KTIME_MAX;
+		trace_rxrpc_timer_can(call, rxrpc_timer_trace_resend);
 	}
-	call->resend_at = resend_at;
 
 	if (unacked)
 		rxrpc_congestion_timeout(call);
@@ -494,7 +487,7 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
 	if (resend &&
 	    __rxrpc_call_state(call) != RXRPC_CALL_CLIENT_RECV_REPLY &&
 	    !test_bit(RXRPC_CALL_TX_ALL_ACKED, &call->flags))
-		rxrpc_resend(call, NULL);
+		rxrpc_resend(call, 0, false);
 
 	if (test_and_clear_bit(RXRPC_CALL_RX_IS_IDLE, &call->flags))
 		rxrpc_send_ACK(call, RXRPC_ACK_IDLE, 0,
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index a9682b31a4f9..bba058055c97 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -691,7 +691,6 @@ static void rxrpc_destroy_call(struct work_struct *work)
 
 	del_timer_sync(&call->timer);
 
-	rxrpc_free_skb(call->cong_last_nack, rxrpc_skb_put_last_nack);
 	rxrpc_cleanup_tx_buffers(call);
 	rxrpc_cleanup_rx_buffers(call);
 	rxrpc_put_txbuf(call->tx_pending, rxrpc_txbuf_put_cleaned);
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index c25d816aafee..6e7ff133b5aa 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -34,8 +34,6 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 					struct rxrpc_ack_summary *summary,
 					rxrpc_serial_t acked_serial)
 {
-	bool resend = false;
-
 	summary->change = rxrpc_cong_no_change;
 	summary->in_flight = (call->tx_top - call->tx_bottom) - call->acks_nr_sacks;
 
@@ -52,12 +50,13 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 	}
 
 	call->cong_cumul_acks += summary->nr_new_sacks;
+	call->cong_cumul_acks += summary->nr_new_hacks;
 	if (call->cong_cumul_acks > 255)
 		call->cong_cumul_acks = 255;
 
 	switch (call->cong_ca_state) {
 	case RXRPC_CA_SLOW_START:
-		if (summary->saw_snacks)
+		if (call->acks_nr_snacks > 0)
 			goto packet_loss_detected;
 		if (call->cong_cumul_acks > 0)
 			call->cong_cwnd += 1;
@@ -68,7 +67,7 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 		goto out;
 
 	case RXRPC_CA_CONGEST_AVOIDANCE:
-		if (summary->saw_snacks)
+		if (call->acks_nr_snacks > 0)
 			goto packet_loss_detected;
 
 		/* We analyse the number of packets that get ACK'd per RTT
@@ -87,7 +86,7 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 		goto out;
 
 	case RXRPC_CA_PACKET_LOSS:
-		if (!summary->saw_snacks)
+		if (call->acks_nr_snacks == 0)
 			goto resume_normality;
 
 		if (summary->new_low_snack) {
@@ -108,7 +107,7 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 		call->cong_cwnd = call->cong_ssthresh + 3;
 		call->cong_extra = 0;
 		call->cong_dup_acks = 0;
-		resend = true;
+		summary->need_retransmit = true;
 		goto out;
 
 	case RXRPC_CA_FAST_RETRANSMIT:
@@ -119,12 +118,12 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 			if (call->cong_dup_acks == 2) {
 				summary->change = rxrpc_cong_retransmit_again;
 				call->cong_dup_acks = 0;
-				resend = true;
+				summary->need_retransmit = true;
 			}
 		} else {
 			summary->change = rxrpc_cong_progress;
 			call->cong_cwnd = call->cong_ssthresh;
-			if (!summary->saw_snacks)
+			if (call->acks_nr_snacks == 0)
 				goto resume_normality;
 		}
 		goto out;
@@ -149,8 +148,6 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 	if (call->cong_cwnd >= RXRPC_TX_MAX_WINDOW)
 		call->cong_cwnd = RXRPC_TX_MAX_WINDOW;
 	trace_rxrpc_congest(call, summary, acked_serial);
-	if (resend)
-		rxrpc_resend(call, skb);
 	return;
 
 packet_loss_detected:
@@ -212,6 +209,13 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 	trace_rxrpc_tx_rotate(call, seq, to);
 	trace_rxrpc_tq(call, tq, seq, rxrpc_tq_rotate);
 
+	if (call->acks_lowest_nak == call->tx_bottom) {
+		call->acks_lowest_nak = to;
+	} else if (after(to, call->acks_lowest_nak)) {
+		summary->new_low_snack = true;
+		call->acks_lowest_nak = to;
+	}
+
 	/* We may have a left over fully-consumed buffer at the front that we
 	 * couldn't drop before (rotate_and_keep below).
 	 */
@@ -231,6 +235,25 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 			set_bit(RXRPC_CALL_TX_LAST, &call->flags);
 			rot_last = true;
 		}
+
+		if (ix == tq->nr_reported_acks) {
+			/* Packet directly hard ACK'd. */
+			tq->nr_reported_acks++;
+			summary->nr_new_hacks++;
+			__set_bit(ix, &tq->segment_acked);
+			trace_rxrpc_rotate(call, tq, summary, seq, rxrpc_rotate_trace_hack);
+		} else if (test_bit(ix, &tq->segment_acked)) {
+			/* Soft ACK -> hard ACK. */
+			call->acks_nr_sacks--;
+			trace_rxrpc_rotate(call, tq, summary, seq, rxrpc_rotate_trace_sack);
+		} else {
+			/* Soft NAK -> hard ACK. */
+			call->acks_nr_snacks--;
+			summary->nr_new_hacks++;
+			__set_bit(ix, &tq->segment_acked);
+			trace_rxrpc_rotate(call, tq, summary, seq, rxrpc_rotate_trace_snak);
+		}
+
 		rxrpc_put_txbuf(tq->bufs[ix], rxrpc_txbuf_put_rotated);
 		tq->bufs[ix] = NULL;
 
@@ -268,13 +291,6 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 
 	_debug("%x,%x,%x,%d", to, call->tx_bottom, call->tx_top, rot_last);
 
-	if (call->acks_lowest_nak == call->tx_bottom) {
-		call->acks_lowest_nak = to;
-	} else if (after(to, call->acks_lowest_nak)) {
-		summary->new_low_snack = true;
-		call->acks_lowest_nak = to;
-	}
-
 	wake_up(&call->waitq);
 	return rot_last;
 }
@@ -293,11 +309,6 @@ static void rxrpc_end_tx_phase(struct rxrpc_call *call, bool reply_begun,
 	call->resend_at = KTIME_MAX;
 	trace_rxrpc_timer_can(call, rxrpc_timer_trace_resend);
 
-	if (unlikely(call->cong_last_nack)) {
-		rxrpc_free_skb(call->cong_last_nack, rxrpc_skb_put_last_nack);
-		call->cong_last_nack = NULL;
-	}
-
 	switch (__rxrpc_call_state(call)) {
 	case RXRPC_CALL_CLIENT_SEND_REQUEST:
 	case RXRPC_CALL_CLIENT_AWAIT_REPLY:
@@ -770,40 +781,92 @@ static void rxrpc_input_ack_trailer(struct rxrpc_call *call, struct sk_buff *skb
 		wake_up(&call->waitq);
 }
 
+#if defined(CONFIG_X86) && __GNUC__ && !defined(__clang__)
+/* Clang doesn't support the %z constraint modifier */
+#define shiftr_adv_rotr(shift_from, rotate_into) ({			\
+			asm(" shr%z1 %1\n"				\
+			    " inc %0\n"					\
+			    " rcr%z2 %2\n"				\
+			    : "+d"(shift_from), "+m"(*(shift_from)), "+rm"(rotate_into) \
+			    );						\
+		})
+#else
+#define shiftr_adv_rotr(shift_from, rotate_into) ({	\
+			typeof(rotate_into) __bit0 = *(shift_from) & 1;	\
+			*(shift_from) >>= 1;				\
+			shift_from++;					\
+			rotate_into >>= 1;				\
+			rotate_into |= __bit0 << (sizeof(rotate_into) * 8 - 1); \
+		})
+#endif
+
 /*
- * Determine how many nacks from the previous ACK have now been satisfied.
+ * Process a batch of soft ACKs specific to a transmission queue segment.
  */
-static rxrpc_seq_t rxrpc_input_check_prev_ack(struct rxrpc_call *call,
-					      struct rxrpc_ack_summary *summary,
-					      rxrpc_seq_t hard_ack)
+static void rxrpc_input_soft_ack_tq(struct rxrpc_call *call,
+				    struct rxrpc_ack_summary *summary,
+				    struct rxrpc_txqueue *tq,
+				    unsigned long extracted_acks,
+				    int nr_reported,
+				    rxrpc_seq_t seq,
+				    rxrpc_seq_t *lowest_nak)
 {
-	struct sk_buff *skb = call->cong_last_nack;
-	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
-	unsigned int i, new_acks = 0, retained_nacks = 0;
-	rxrpc_seq_t seq = hard_ack + 1, old_seq = sp->ack.first_ack;
-	u8 *acks = skb->data + sizeof(struct rxrpc_wire_header) + sizeof(struct rxrpc_ackpacket);
+	unsigned long old_reported, flipped, new_acks, a_to_n, n_to_a;
+	int new, a, n;
+
+	old_reported = ~0UL >> (RXRPC_NR_TXQUEUE - tq->nr_reported_acks);
+	_enter("{%x,%lx,%d},%lx,%d,%x",
+	       tq->qbase, tq->segment_acked, tq->nr_reported_acks,
+	       extracted_acks, nr_reported, seq);
+
+	_debug("[%x]", tq->qbase);
+	_debug("tq    %16lx %u", tq->segment_acked, tq->nr_reported_acks);
+	_debug("sack  %16lx %u", extracted_acks, nr_reported);
+
+	/* See how many previously logged ACKs/NAKs have flipped. */
+	flipped = (tq->segment_acked ^ extracted_acks) & old_reported;
+	if (flipped) {
+		n_to_a = ~tq->segment_acked & flipped; /* Old NAK -> ACK */
+		a_to_n =  tq->segment_acked & flipped; /* Old ACK -> NAK */
+		a = hweight_long(n_to_a);
+		n = hweight_long(a_to_n);
+		_debug("flip  %16lx", flipped);
+		_debug("ntoa  %16lx %d", n_to_a, a);
+		_debug("aton  %16lx %d", a_to_n, n);
+		call->acks_nr_sacks	+= a - n;
+		call->acks_nr_snacks	+= n - a;
+		summary->nr_new_sacks	+= a;
+		summary->nr_new_snacks	+= n;
+	}
 
-	if (after_eq(seq, old_seq + sp->ack.nr_acks)) {
-		summary->nr_new_sacks += sp->ack.nr_nacks;
-		summary->nr_new_sacks += seq - (old_seq + sp->ack.nr_acks);
-		summary->nr_retained_snacks = 0;
-	} else if (seq == old_seq) {
-		summary->nr_retained_snacks = sp->ack.nr_nacks;
-	} else {
-		for (i = 0; i < sp->ack.nr_acks; i++) {
-			if (acks[i] == RXRPC_ACK_TYPE_NACK) {
-				if (before(old_seq + i, seq))
-					new_acks++;
-				else
-					retained_nacks++;
-			}
+	/* See how many new ACKs/NAKs have been acquired. */
+	new = nr_reported - tq->nr_reported_acks;
+	if (new > 0) {
+		new_acks = extracted_acks & ~old_reported;
+		if (new_acks) {
+			a = hweight_long(new_acks);
+			n = new - a;
+			_debug("new_a %16lx new=%d a=%d n=%d", new_acks, new, a, n);
+			call->acks_nr_sacks	+= a;
+			call->acks_nr_snacks	+= n;
+			summary->nr_new_sacks	+= a;
+			summary->nr_new_snacks	+= n;
+		} else {
+			call->acks_nr_snacks	+= new;
+			summary->nr_new_snacks	+= new;
 		}
-
-		summary->nr_new_sacks += new_acks;
-		summary->nr_retained_snacks = retained_nacks;
 	}
 
-	return old_seq + sp->ack.nr_acks - 1;
+	tq->nr_reported_acks = nr_reported;
+	tq->segment_acked = extracted_acks;
+	trace_rxrpc_apply_acks(call, tq);
+
+	if (extracted_acks != ~0UL) {
+		rxrpc_seq_t lowest = seq + ffz(extracted_acks);
+
+		if (before(lowest, *lowest_nak))
+			*lowest_nak = lowest;
+	}
 }
 
 /*
@@ -817,39 +880,50 @@ static rxrpc_seq_t rxrpc_input_check_prev_ack(struct rxrpc_call *call,
  */
 static void rxrpc_input_soft_acks(struct rxrpc_call *call,
 				  struct rxrpc_ack_summary *summary,
-				  struct sk_buff *skb,
-				  rxrpc_seq_t since)
+				  struct sk_buff *skb)
 {
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
-	unsigned int i, old_nacks = 0;
-	rxrpc_seq_t lowest_nak = call->acks_hard_ack + sp->ack.nr_acks + 1;
-	rxrpc_seq_t seq = call->acks_hard_ack;
+	struct rxrpc_txqueue *tq = call->tx_queue;
+	unsigned long extracted = ~0UL;
+	unsigned int nr = 0;
+	rxrpc_seq_t seq = call->acks_hard_ack + 1;
+	rxrpc_seq_t lowest_nak = seq + sp->ack.nr_acks;
 	u8 *acks = skb->data + sizeof(struct rxrpc_wire_header) + sizeof(struct rxrpc_ackpacket);
 
-	for (i = 0; i < sp->ack.nr_acks; i++) {
-		seq++;
-		if (acks[i] == RXRPC_ACK_TYPE_ACK) {
-			call->acks_nr_sacks++;
-			if (after(seq, since))
-				summary->nr_new_sacks++;
-		} else {
-			summary->saw_snacks = true;
-			if (before_eq(seq, since)) {
-				/* Overlap with previous ACK */
-				old_nacks++;
-			} else {
-				summary->nr_new_snacks++;
-				sp->ack.nr_nacks++;
-			}
+	_enter("%x,%x,%u", tq->qbase, seq, sp->ack.nr_acks);
+
+	while (after(seq, tq->qbase + RXRPC_NR_TXQUEUE - 1))
+		tq = tq->next;
 
-			if (before(seq, lowest_nak))
-				lowest_nak = seq;
+	for (unsigned int i = 0; i < sp->ack.nr_acks; i++) {
+		/* Decant ACKs until we hit a txqueue boundary. */
+		shiftr_adv_rotr(acks, extracted);
+		if (i == 256) {
+			acks -= i;
+			i = 0;
 		}
+		seq++;
+		nr++;
+		if ((seq & RXRPC_TXQ_MASK) != 0)
+			continue;
+
+		_debug("bound %16lx %u", extracted, nr);
+
+		rxrpc_input_soft_ack_tq(call, summary, tq, extracted, RXRPC_NR_TXQUEUE,
+					seq - RXRPC_NR_TXQUEUE, &lowest_nak);
+		extracted = ~0UL;
+		nr = 0;
+		tq = tq->next;
+		prefetch(tq);
 	}
 
-	if (lowest_nak != call->acks_lowest_nak) {
-		call->acks_lowest_nak = lowest_nak;
-		summary->new_low_snack = true;
+	if (nr) {
+		unsigned int nr_reported = seq & RXRPC_TXQ_MASK;
+
+		extracted >>= RXRPC_NR_TXQUEUE - nr_reported;
+		_debug("tail  %16lx %u", extracted, nr_reported);
+		rxrpc_input_soft_ack_tq(call, summary, tq, extracted, nr_reported,
+					seq & ~RXRPC_TXQ_MASK, &lowest_nak);
 	}
 
 	/* We *can* have more nacks than we did - the peer is permitted to drop
@@ -857,9 +931,14 @@ static void rxrpc_input_soft_acks(struct rxrpc_call *call,
 	 * possible for the nack distribution to change whilst the number of
 	 * nacks stays the same or goes down.
 	 */
-	if (old_nacks < summary->nr_retained_snacks)
-		summary->nr_new_sacks += summary->nr_retained_snacks - old_nacks;
-	summary->nr_retained_snacks = old_nacks;
+	if (lowest_nak != call->acks_lowest_nak) {
+		call->acks_lowest_nak = lowest_nak;
+		summary->new_low_snack = true;
+	}
+
+	_debug("summary A=%d+%d N=%d+%d",
+	       call->acks_nr_sacks,  summary->nr_new_sacks,
+	       call->acks_nr_snacks, summary->nr_new_snacks);
 }
 
 /*
@@ -902,7 +981,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	struct rxrpc_acktrailer trailer;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	rxrpc_serial_t ack_serial, acked_serial;
-	rxrpc_seq_t first_soft_ack, hard_ack, prev_pkt, since;
+	rxrpc_seq_t first_soft_ack, hard_ack, prev_pkt;
 	int nr_acks, offset, ioffset;
 
 	_enter("");
@@ -920,6 +999,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 
 	trace_rxrpc_rx_ack(call, sp);
 	rxrpc_inc_stat(call->rxnet, stat_rx_acks[summary.ack_reason]);
+	prefetch(call->tx_queue);
 
 	if (acked_serial != 0) {
 		switch (summary.ack_reason) {
@@ -980,16 +1060,6 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	if (nr_acks > 0)
 		skb_condense(skb);
 
-	if (call->cong_last_nack) {
-		since = rxrpc_input_check_prev_ack(call, &summary, hard_ack);
-		rxrpc_free_skb(call->cong_last_nack, rxrpc_skb_put_last_nack);
-		call->cong_last_nack = NULL;
-	} else {
-		summary.nr_new_sacks = hard_ack - call->acks_hard_ack;
-		call->acks_lowest_nak = hard_ack + nr_acks;
-		since = hard_ack;
-	}
-
 	call->acks_latest_ts = skb->tstamp;
 	call->acks_hard_ack = hard_ack;
 	call->acks_prev_seq = prev_pkt;
@@ -1037,9 +1107,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	if (nr_acks > 0) {
 		if (offset > (int)skb->len - nr_acks)
 			return rxrpc_proto_abort(call, 0, rxrpc_eproto_ackr_short_sack);
-		rxrpc_input_soft_acks(call, &summary, skb, since);
-		rxrpc_get_skb(skb, rxrpc_skb_get_last_nack);
-		call->cong_last_nack = skb;
+		rxrpc_input_soft_acks(call, &summary, skb);
 	}
 
 	if (test_bit(RXRPC_CALL_TX_LAST, &call->flags) &&
@@ -1049,6 +1117,8 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 				   rxrpc_propose_ack_ping_for_lost_reply);
 
 	rxrpc_congestion_management(call, skb, &summary, acked_serial);
+	if (summary.need_retransmit)
+		rxrpc_resend(call, ack_serial, summary.ack_reason == RXRPC_ACK_PING_RESPONSE);
 
 send_response:
 	if (summary.ack_reason == RXRPC_ACK_PING)
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 7ed928b6f0e1..978c2dc6a7d4 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -461,7 +461,7 @@ static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call,
 		len += sizeof(*jumbo);
 	}
 
-	trace_rxrpc_tx_data(call, txb->seq, txb->serial, flags, false);
+	trace_rxrpc_tx_data(call, txb->seq, txb->serial, txb->flags | flags, false);
 	kv->iov_len = len;
 	return len;
 }
@@ -522,6 +522,13 @@ static size_t rxrpc_prepare_data_packet(struct rxrpc_call *call, struct rxrpc_se
 	}
 
 	/* Set timeouts */
+	if (call->peer->rtt_count > 1) {
+		ktime_t delay = rxrpc_get_rto_backoff(call->peer, false);
+
+		call->ack_lost_at = ktime_add(req->now, delay);
+		trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_lost_ack);
+	}
+
 	if (!test_and_set_bit(RXRPC_CALL_BEGAN_RX_TIMER, &call->flags)) {
 		ktime_t delay = ms_to_ktime(READ_ONCE(call->next_rx_timo));
 
@@ -596,6 +603,7 @@ void rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_send_data_req
 			ret = 0;
 			trace_rxrpc_tx_data(call, txb->seq, txb->serial,
 					    txb->flags, true);
+			conn->peer->last_tx_at = ktime_get_seconds();
 			goto done;
 		}
 	}
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index dfbf9f4b24b6..381b25597f4e 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -299,6 +299,9 @@ static int rxrpc_alloc_txqueue(struct sock *sk, struct rxrpc_call *call)
 		kfree(tq);
 		return -ENOMEM;
 	} else {
+		/* We start at seq 1, so pretend seq 0 is hard-acked. */
+		tq->nr_reported_acks = 1;
+		tq->segment_acked = 1UL;
 		tq->qbase = 0;
 		call->tx_qbase = 0;
 		call->send_queue = tq;


