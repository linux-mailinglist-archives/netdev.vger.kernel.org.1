Return-Path: <netdev+bounces-148084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2769E0530
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C902847FA
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884B220C039;
	Mon,  2 Dec 2024 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGUTqBqN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982C320B7F1
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149942; cv=none; b=F8Ch2qcl3jjmY6JBY28wdr4ODJXuzz29pLnwV8hFQFqpq2Cad3I+gkugMZX/OnYGAM6ZS4qqzUmBLrQGfXZfyd06JmkEzneaGoKLuoR3BdgCvbcRR+sfgPTXvUeH7tvnulMMwr9vSZXH8VCCPOWLzHWvjRgSfZ5JWrFIiRy4cnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149942; c=relaxed/simple;
	bh=Dnps7b7rQ4VF2y4U2/JJaWQ7NzYWuiBwVfEYYuyfpyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGd4F1SiJiZ57hvcd0Y2ajn2/Ao8gYg4+iETPbWdlIW2h8FON4fG/btVQ/DHV3SANFCBf2qgNSz83ODwZrScnfc6gNofgZ1+88iw4dca282UOwSGr7CihFqITgoiCRjKXHuqcLO4DTiLKxB11mW/zvQD5eSLx/WKRlYbij+e7A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gGUTqBqN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733149937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29xXgTeqK7qllzfiUuJ0XTRUjQuoe2DgK/eNZe1Qhnw=;
	b=gGUTqBqNchlm/nft3exPHJK00FSeLOdmoGgrc6T8gML+Q/dmXKS5T+xZFjVWxe+pzN9dOi
	4vwKHhbbJHOXu1GY4IDoRj3VWHhJoXSALW8oKcPAnEEggdYZN++kQBcoR3XNoMeQTOdPoE
	GN1BStnPj/dKo19shwxCPGJ1Yy/t4IE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-KJt0g0HSMA28J0axcYgOHA-1; Mon,
 02 Dec 2024 09:32:11 -0500
X-MC-Unique: KJt0g0HSMA28J0axcYgOHA-1
X-Mimecast-MFC-AGG-ID: KJt0g0HSMA28J0axcYgOHA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50847197700F;
	Mon,  2 Dec 2024 14:32:10 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 49FB61956089;
	Mon,  2 Dec 2024 14:32:07 +0000 (UTC)
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
Subject: [PATCH net-next 16/37] rxrpc: Implement progressive transmission queue struct
Date: Mon,  2 Dec 2024 14:30:34 +0000
Message-ID: <20241202143057.378147-17-dhowells@redhat.com>
In-Reply-To: <20241202143057.378147-1-dhowells@redhat.com>
References: <20241202143057.378147-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

We need to scan the buffers in the transmission queue occasionally when
processing ACKs, but the transmission queue is currently a linked list of
transmission buffers which, when we eventually expand the Tx window to 8192
packets will be very slow to walk.

Instead, pull the fields we need to examine a lot (last sent time,
retransmitted flag) into a new struct rxrpc_txqueue and make each one hold
an array of 32 or 64 packets.

The transmission queue is then a list of these structs, each pointing to a
contiguous set of packets.  Scanning is then a lot faster as the flags and
timestamps are concentrated in the CPU dcache.

The transmission timestamps are stored as a number of microseconds from a
base ktime to reduce memory requirements.  This should be fine provided we
manage to transmit an entire buffer within an hour.

This will make implementing RACK-TLP [RFC8985] easier as it will be less
costly to scan the transmission buffers.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h |  98 ++++++++++++++---
 net/rxrpc/ar-internal.h      |  47 ++++++--
 net/rxrpc/call_event.c       | 204 ++++++++++++++++++++++-------------
 net/rxrpc/call_object.c      |  38 ++++---
 net/rxrpc/input.c            |  72 ++++++++++---
 net/rxrpc/output.c           | 156 ++++++++++++++-------------
 net/rxrpc/sendmsg.c          |  69 +++++++++---
 net/rxrpc/txbuf.c            |  41 +------
 8 files changed, 468 insertions(+), 257 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 28fa7be31ff8..e6cf9ec940aa 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -297,7 +297,6 @@
 
 #define rxrpc_txqueue_traces \
 	EM(rxrpc_txqueue_await_reply,		"AWR") \
-	EM(rxrpc_txqueue_dequeue,		"DEQ") \
 	EM(rxrpc_txqueue_end,			"END") \
 	EM(rxrpc_txqueue_queue,			"QUE") \
 	EM(rxrpc_txqueue_queue_last,		"QLS") \
@@ -482,6 +481,19 @@
 	EM(rxrpc_txbuf_see_send_more,		"SEE SEND+  ")	\
 	E_(rxrpc_txbuf_see_unacked,		"SEE UNACKED")
 
+#define rxrpc_tq_traces \
+	EM(rxrpc_tq_alloc,			"ALLOC") \
+	EM(rxrpc_tq_cleaned,			"CLEAN") \
+	EM(rxrpc_tq_decant,			"DCNT ") \
+	EM(rxrpc_tq_decant_advance,		"DCNT>") \
+	EM(rxrpc_tq_queue,			"QUEUE") \
+	EM(rxrpc_tq_queue_dup,			"QUE!!") \
+	EM(rxrpc_tq_rotate,			"ROT  ") \
+	EM(rxrpc_tq_rotate_and_free,		"ROT-F") \
+	EM(rxrpc_tq_rotate_and_keep,		"ROT-K") \
+	EM(rxrpc_tq_transmit,			"XMIT ") \
+	E_(rxrpc_tq_transmit_advance,		"XMIT>")
+
 #define rxrpc_pmtud_reduce_traces \
 	EM(rxrpc_pmtud_reduce_ack,		"Ack  ")	\
 	EM(rxrpc_pmtud_reduce_icmp,		"Icmp ")	\
@@ -518,6 +530,7 @@ enum rxrpc_rtt_tx_trace		{ rxrpc_rtt_tx_traces } __mode(byte);
 enum rxrpc_sack_trace		{ rxrpc_sack_traces } __mode(byte);
 enum rxrpc_skb_trace		{ rxrpc_skb_traces } __mode(byte);
 enum rxrpc_timer_trace		{ rxrpc_timer_traces } __mode(byte);
+enum rxrpc_tq_trace		{ rxrpc_tq_traces } __mode(byte);
 enum rxrpc_tx_point		{ rxrpc_tx_points } __mode(byte);
 enum rxrpc_txbuf_trace		{ rxrpc_txbuf_traces } __mode(byte);
 enum rxrpc_txqueue_trace	{ rxrpc_txqueue_traces } __mode(byte);
@@ -554,6 +567,7 @@ rxrpc_rtt_tx_traces;
 rxrpc_sack_traces;
 rxrpc_skb_traces;
 rxrpc_timer_traces;
+rxrpc_tq_traces;
 rxrpc_tx_points;
 rxrpc_txbuf_traces;
 rxrpc_txqueue_traces;
@@ -881,7 +895,7 @@ TRACE_EVENT(rxrpc_txqueue,
 		    __field(rxrpc_seq_t,		acks_hard_ack)
 		    __field(rxrpc_seq_t,		tx_bottom)
 		    __field(rxrpc_seq_t,		tx_top)
-		    __field(rxrpc_seq_t,		tx_prepared)
+		    __field(rxrpc_seq_t,		send_top)
 		    __field(int,			tx_winsize)
 			     ),
 
@@ -891,7 +905,7 @@ TRACE_EVENT(rxrpc_txqueue,
 		    __entry->acks_hard_ack = call->acks_hard_ack;
 		    __entry->tx_bottom = call->tx_bottom;
 		    __entry->tx_top = call->tx_top;
-		    __entry->tx_prepared = call->tx_prepared;
+		    __entry->send_top = call->send_top;
 		    __entry->tx_winsize = call->tx_winsize;
 			   ),
 
@@ -902,14 +916,14 @@ TRACE_EVENT(rxrpc_txqueue,
 		      __entry->acks_hard_ack,
 		      __entry->tx_top - __entry->tx_bottom,
 		      __entry->tx_top - __entry->acks_hard_ack,
-		      __entry->tx_prepared - __entry->tx_bottom,
+		      __entry->send_top - __entry->tx_top,
 		      __entry->tx_winsize)
 	    );
 
 TRACE_EVENT(rxrpc_transmit,
-	    TP_PROTO(struct rxrpc_call *call, int space),
+	    TP_PROTO(struct rxrpc_call *call, rxrpc_seq_t send_top, int space),
 
-	    TP_ARGS(call, space),
+	    TP_ARGS(call, send_top, space),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,	call)
@@ -925,12 +939,12 @@ TRACE_EVENT(rxrpc_transmit,
 
 	    TP_fast_assign(
 		    __entry->call	= call->debug_id;
-		    __entry->seq	= call->tx_bottom;
+		    __entry->seq	= call->tx_top + 1;
 		    __entry->space	= space;
 		    __entry->tx_winsize	= call->tx_winsize;
 		    __entry->cong_cwnd	= call->cong_cwnd;
 		    __entry->cong_extra	= call->cong_extra;
-		    __entry->prepared	= call->tx_prepared - call->tx_bottom;
+		    __entry->prepared	= send_top - call->tx_bottom;
 		    __entry->in_flight	= call->tx_top - call->acks_hard_ack;
 		    __entry->pmtud_jumbo = call->peer->pmtud_jumbo;
 			   ),
@@ -947,6 +961,32 @@ TRACE_EVENT(rxrpc_transmit,
 		      __entry->pmtud_jumbo)
 	    );
 
+TRACE_EVENT(rxrpc_tx_rotate,
+	    TP_PROTO(struct rxrpc_call *call, rxrpc_seq_t seq, rxrpc_seq_t to),
+
+	    TP_ARGS(call, seq, to),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	call)
+		    __field(rxrpc_seq_t,	seq)
+		    __field(rxrpc_seq_t,	to)
+		    __field(rxrpc_seq_t,	top)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->call	= call->debug_id;
+		    __entry->seq	= seq;
+		    __entry->to		= to;
+		    __entry->top	= call->tx_top;
+			   ),
+
+	    TP_printk("c=%08x q=%08x-%08x-%08x",
+		      __entry->call,
+		      __entry->seq,
+		      __entry->to,
+		      __entry->top)
+	    );
+
 TRACE_EVENT(rxrpc_rx_data,
 	    TP_PROTO(unsigned int call, rxrpc_seq_t seq,
 		     rxrpc_serial_t serial, u8 flags),
@@ -1621,10 +1661,11 @@ TRACE_EVENT(rxrpc_drop_ack,
 	    );
 
 TRACE_EVENT(rxrpc_retransmit,
-	    TP_PROTO(struct rxrpc_call *call, rxrpc_seq_t seq,
-		     rxrpc_serial_t serial, ktime_t expiry),
+	    TP_PROTO(struct rxrpc_call *call,
+		     struct rxrpc_send_data_req *req,
+		     struct rxrpc_txbuf *txb, ktime_t expiry),
 
-	    TP_ARGS(call, seq, serial, expiry),
+	    TP_ARGS(call, req, txb, expiry),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,	call)
@@ -1635,8 +1676,8 @@ TRACE_EVENT(rxrpc_retransmit,
 
 	    TP_fast_assign(
 		    __entry->call = call->debug_id;
-		    __entry->seq = seq;
-		    __entry->serial = serial;
+		    __entry->seq = req->seq;
+		    __entry->serial = txb->serial;
 		    __entry->expiry = expiry;
 			   ),
 
@@ -1714,9 +1755,9 @@ TRACE_EVENT(rxrpc_reset_cwnd,
 		    __entry->cwnd	= call->cong_cwnd;
 		    __entry->extra	= call->cong_extra;
 		    __entry->hard_ack	= call->acks_hard_ack;
-		    __entry->prepared	= call->tx_prepared - call->tx_bottom;
+		    __entry->prepared	= call->send_top - call->tx_bottom;
 		    __entry->since_last_tx = ktime_sub(now, call->tx_last_sent);
-		    __entry->has_data	= !list_empty(&call->tx_sendmsg);
+		    __entry->has_data	= call->tx_bottom != call->tx_top;
 			   ),
 
 	    TP_printk("c=%08x q=%08x %s cw=%u+%u pr=%u tm=%llu d=%u",
@@ -2024,6 +2065,33 @@ TRACE_EVENT(rxrpc_txbuf,
 		      __entry->ref)
 	    );
 
+TRACE_EVENT(rxrpc_tq,
+	    TP_PROTO(struct rxrpc_call *call, struct rxrpc_txqueue *tq,
+		     rxrpc_seq_t seq, enum rxrpc_tq_trace trace),
+
+	    TP_ARGS(call, tq, seq, trace),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		call_debug_id)
+		    __field(rxrpc_seq_t,		qbase)
+		    __field(rxrpc_seq_t,		seq)
+		    __field(enum rxrpc_tq_trace,	trace)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->call_debug_id = call->debug_id;
+		    __entry->qbase = tq ? tq->qbase : call->tx_qbase;
+		    __entry->seq = seq;
+		    __entry->trace = trace;
+			   ),
+
+	    TP_printk("c=%08x bq=%08x q=%08x %s",
+		      __entry->call_debug_id,
+		      __entry->qbase,
+		      __entry->seq,
+		      __print_symbolic(__entry->trace, rxrpc_tq_traces))
+	    );
+
 TRACE_EVENT(rxrpc_poke_call,
 	    TP_PROTO(struct rxrpc_call *call, bool busy,
 		     enum rxrpc_call_poke_trace what),
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 84efa21f176c..bcce4862b0b7 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -30,6 +30,7 @@ struct rxrpc_crypt {
 struct key_preparsed_payload;
 struct rxrpc_connection;
 struct rxrpc_txbuf;
+struct rxrpc_txqueue;
 
 /*
  * Mark applied to socket buffers in skb->mark.  skb->priority is used
@@ -691,13 +692,17 @@ struct rxrpc_call {
 	unsigned short		rx_pkt_offset;	/* Current recvmsg packet offset */
 	unsigned short		rx_pkt_len;	/* Current recvmsg packet len */
 
+	/* Sendmsg data tracking. */
+	rxrpc_seq_t		send_top;	/* Highest Tx slot filled by sendmsg. */
+	struct rxrpc_txqueue	*send_queue;	/* Queue that sendmsg is writing into */
+
 	/* Transmitted data tracking. */
 	spinlock_t		tx_lock;	/* Transmit queue lock */
-	struct list_head	tx_sendmsg;	/* Sendmsg prepared packets */
-	struct list_head	tx_buffer;	/* Buffer of transmissible packets */
+	struct rxrpc_txqueue	*tx_queue;	/* Start of transmission buffers */
+	struct rxrpc_txqueue	*tx_qtail;	/* End of transmission buffers */
+	rxrpc_seq_t		tx_qbase;	/* First slot in tx_queue */
 	rxrpc_seq_t		tx_bottom;	/* First packet in buffer */
 	rxrpc_seq_t		tx_transmitted;	/* Highest packet transmitted */
-	rxrpc_seq_t		tx_prepared;	/* Highest Tx slot prepared. */
 	rxrpc_seq_t		tx_top;		/* Highest Tx slot allocated. */
 	u16			tx_backoff;	/* Delay to insert due to Tx failure (ms) */
 	u8			tx_winsize;	/* Maximum size of Tx window */
@@ -815,9 +820,6 @@ struct rxrpc_send_params {
  * Buffer of data to be output as a packet.
  */
 struct rxrpc_txbuf {
-	struct list_head	call_link;	/* Link in call->tx_sendmsg/tx_buffer */
-	struct list_head	tx_link;	/* Link in live Enc queue or Tx queue */
-	ktime_t			last_sent;	/* Time at which last transmitted */
 	refcount_t		ref;
 	rxrpc_seq_t		seq;		/* Sequence number of this packet */
 	rxrpc_serial_t		serial;		/* Last serial number transmitted with */
@@ -849,6 +851,36 @@ static inline bool rxrpc_sending_to_client(const struct rxrpc_txbuf *txb)
 	return !rxrpc_sending_to_server(txb);
 }
 
+/*
+ * Transmit queue element, including RACK [RFC8985] per-segment metadata.  The
+ * transmission timestamp is in usec from the base.
+ */
+struct rxrpc_txqueue {
+	/* Start with the members we want to prefetch. */
+	struct rxrpc_txqueue	*next;
+	ktime_t			xmit_ts_base;
+	rxrpc_seq_t		qbase;
+
+	/* The arrays we want to pack into as few cache lines as possible. */
+	struct {
+#define RXRPC_NR_TXQUEUE BITS_PER_LONG
+#define RXRPC_TXQ_MASK (RXRPC_NR_TXQUEUE - 1)
+		struct rxrpc_txbuf *bufs[RXRPC_NR_TXQUEUE];
+		unsigned int	segment_xmit_ts[RXRPC_NR_TXQUEUE];
+	} ____cacheline_aligned;
+};
+
+/*
+ * Data transmission request.
+ */
+struct rxrpc_send_data_req {
+	ktime_t			now;		/* Current time */
+	struct rxrpc_txqueue	*tq;		/* Tx queue segment holding first DATA */
+	rxrpc_seq_t		seq;		/* Sequence of first data */
+	int			n;		/* Number of DATA packets to glue into jumbo */
+	bool			did_send;	/* T if did actually send */
+};
+
 #include <trace/events/rxrpc.h>
 
 /*
@@ -905,7 +937,6 @@ void rxrpc_propose_ping(struct rxrpc_call *call, u32 serial,
 			enum rxrpc_propose_ack_trace why);
 void rxrpc_propose_delay_ACK(struct rxrpc_call *, rxrpc_serial_t,
 			     enum rxrpc_propose_ack_trace);
-void rxrpc_shrink_call_tx_buffer(struct rxrpc_call *);
 void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb);
 
 bool rxrpc_input_call_event(struct rxrpc_call *call);
@@ -1191,10 +1222,10 @@ void rxrpc_send_ACK(struct rxrpc_call *call, u8 ack_reason,
 		    rxrpc_serial_t serial, enum rxrpc_propose_ack_trace why);
 void rxrpc_send_probe_for_pmtud(struct rxrpc_call *call);
 int rxrpc_send_abort_packet(struct rxrpc_call *);
+void rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_send_data_req *req);
 void rxrpc_send_conn_abort(struct rxrpc_connection *conn);
 void rxrpc_reject_packet(struct rxrpc_local *local, struct sk_buff *skb);
 void rxrpc_send_keepalive(struct rxrpc_peer *);
-void rxrpc_transmit_data(struct rxrpc_call *call, struct rxrpc_txbuf *txb, int n);
 
 /*
  * peer_event.c
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index ef47de3f41c6..c97b85f34e4f 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -62,57 +62,85 @@ static void rxrpc_congestion_timeout(struct rxrpc_call *call)
 	set_bit(RXRPC_CALL_RETRANS_TIMEOUT, &call->flags);
 }
 
+/*
+ * Retransmit one or more packets.
+ */
+static void rxrpc_retransmit_data(struct rxrpc_call *call,
+				  struct rxrpc_send_data_req *req,
+				  ktime_t rto)
+{
+	struct rxrpc_txqueue *tq = req->tq;
+	unsigned int ix = req->seq & RXRPC_TXQ_MASK;
+	struct rxrpc_txbuf *txb = tq->bufs[ix];
+	ktime_t xmit_ts, resend_at;
+
+	_enter("%x,%x,%x,%px", tq->qbase, req->seq, ix, txb);
+
+	xmit_ts = ktime_add_us(tq->xmit_ts_base, tq->segment_xmit_ts[ix]);
+	resend_at = ktime_add(xmit_ts, rto);
+	trace_rxrpc_retransmit(call, req, txb,
+			       ktime_sub(resend_at, req->now));
+
+	txb->flags |= RXRPC_TXBUF_RESENT;
+	rxrpc_send_data_packet(call, req);
+	rxrpc_inc_stat(call->rxnet, stat_tx_data_retrans);
+
+	req->tq		= NULL;
+	req->n		= 0;
+	req->did_send	= true;
+	req->now	= ktime_get_real();
+}
+
 /*
  * Perform retransmission of NAK'd and unack'd packets.
  */
 void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 {
+	struct rxrpc_send_data_req req = {
+		.now	= ktime_get_real(),
+	};
 	struct rxrpc_ackpacket *ack = NULL;
 	struct rxrpc_skb_priv *sp;
+	struct rxrpc_txqueue *tq;
 	struct rxrpc_txbuf *txb;
-	rxrpc_seq_t transmitted = call->tx_transmitted;
+	rxrpc_seq_t transmitted = call->tx_transmitted, seq;
 	ktime_t next_resend = KTIME_MAX, rto = ns_to_ktime(call->peer->rto_us * NSEC_PER_USEC);
-	ktime_t resend_at = KTIME_MAX, now, delay;
+	ktime_t resend_at = KTIME_MAX, delay;
 	bool unacked = false, did_send = false;
-	unsigned int i;
+	unsigned int qix;
 
 	_enter("{%d,%d}", call->acks_hard_ack, call->tx_top);
 
-	now = ktime_get_real();
-
-	if (list_empty(&call->tx_buffer))
+	if (call->tx_bottom == call->tx_top)
 		goto no_resend;
 
 	trace_rxrpc_resend(call, ack_skb);
-	txb = list_first_entry(&call->tx_buffer, struct rxrpc_txbuf, call_link);
+	tq = call->tx_queue;
+	seq = call->tx_bottom;
 
-	/* Scan the soft ACK table without dropping the lock and resend any
-	 * explicitly NAK'd packets.
-	 */
+	/* Scan the soft ACK table and resend any explicitly NAK'd packets. */
 	if (ack_skb) {
 		sp = rxrpc_skb(ack_skb);
 		ack = (void *)ack_skb->data + sizeof(struct rxrpc_wire_header);
 
-		for (i = 0; i < sp->ack.nr_acks; i++) {
-			rxrpc_seq_t seq;
+		for (int i = 0; i < sp->ack.nr_acks; i++) {
+			rxrpc_seq_t aseq;
 
 			if (ack->acks[i] & 1)
 				continue;
-			seq = sp->ack.first_ack + i;
-			if (after(txb->seq, transmitted))
-				break;
-			if (after(txb->seq, seq))
-				continue; /* A new hard ACK probably came in */
-			list_for_each_entry_from(txb, &call->tx_buffer, call_link) {
-				if (txb->seq == seq)
-					goto found_txb;
-			}
-			goto no_further_resend;
+			aseq = sp->ack.first_ack + i;
+			while (after_eq(aseq, tq->qbase + RXRPC_NR_TXQUEUE))
+				tq = tq->next;
+			seq = aseq;
+			qix = seq - tq->qbase;
+			txb = tq->bufs[qix];
+			if (after(seq, transmitted))
+				goto no_further_resend;
 
-		found_txb:
-			resend_at = ktime_add(txb->last_sent, rto);
+			resend_at = ktime_add_us(tq->xmit_ts_base, tq->segment_xmit_ts[qix]);
+			resend_at = ktime_add(resend_at, rto);
 			if (after(txb->serial, call->acks_highest_serial)) {
-				if (ktime_after(resend_at, now) &&
+				if (ktime_after(resend_at, req.now) &&
 				    ktime_before(resend_at, next_resend))
 					next_resend = resend_at;
 				continue; /* Ack point not yet reached */
@@ -120,17 +148,13 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 
 			rxrpc_see_txbuf(txb, rxrpc_txbuf_see_unacked);
 
-			trace_rxrpc_retransmit(call, txb->seq, txb->serial,
-					       ktime_sub(resend_at, now));
-
-			txb->flags |= RXRPC_TXBUF_RESENT;
-			rxrpc_transmit_data(call, txb, 1);
-			did_send = true;
-			now = ktime_get_real();
+			req.tq  = tq;
+			req.seq = seq;
+			req.n   = 1;
+			rxrpc_retransmit_data(call, &req, rto);
 
-			if (list_is_last(&txb->call_link, &call->tx_buffer))
+			if (after_eq(seq, call->tx_top))
 				goto no_further_resend;
-			txb = list_next_entry(txb, call_link);
 		}
 	}
 
@@ -139,35 +163,43 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 	 * ACK'd or NACK'd in due course, so don't worry about it here; here we
 	 * need to consider retransmitting anything beyond that point.
 	 */
-	if (after_eq(call->acks_prev_seq, call->tx_transmitted))
+	seq = call->acks_prev_seq;
+	if (after_eq(seq, call->tx_transmitted))
 		goto no_further_resend;
+	seq++;
 
-	list_for_each_entry_from(txb, &call->tx_buffer, call_link) {
-		resend_at = ktime_add(txb->last_sent, rto);
+	while (after_eq(seq, tq->qbase + RXRPC_NR_TXQUEUE))
+		tq = tq->next;
 
-		if (before_eq(txb->seq, call->acks_prev_seq))
+	while (before_eq(seq, call->tx_transmitted)) {
+		qix = seq - tq->qbase;
+		if (qix >= RXRPC_NR_TXQUEUE) {
+			tq = tq->next;
 			continue;
-		if (after(txb->seq, call->tx_transmitted))
-			break; /* Not transmitted yet */
+		}
+		txb = tq->bufs[qix];
+		resend_at = ktime_add_us(tq->xmit_ts_base, tq->segment_xmit_ts[qix]);
+		resend_at = ktime_add(resend_at, rto);
 
 		if (ack && ack->reason == RXRPC_ACK_PING_RESPONSE &&
 		    before(txb->serial, ntohl(ack->serial)))
 			goto do_resend; /* Wasn't accounted for by a more recent ping. */
 
-		if (ktime_after(resend_at, now)) {
+		if (ktime_after(resend_at, req.now)) {
 			if (ktime_before(resend_at, next_resend))
 				next_resend = resend_at;
+			seq++;
 			continue;
 		}
 
 	do_resend:
 		unacked = true;
 
-		txb->flags |= RXRPC_TXBUF_RESENT;
-		rxrpc_transmit_data(call, txb, 1);
-		did_send = true;
-		rxrpc_inc_stat(call->rxnet, stat_tx_data_retrans);
-		now = ktime_get_real();
+		req.tq  = tq;
+		req.seq = seq;
+		req.n   = 1;
+		rxrpc_retransmit_data(call, &req, rto);
+		seq++;
 	}
 
 no_further_resend:
@@ -175,7 +207,8 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 	if (resend_at < KTIME_MAX) {
 		delay = rxrpc_get_rto_backoff(call->peer, did_send);
 		resend_at = ktime_add(resend_at, delay);
-		trace_rxrpc_timer_set(call, resend_at - now, rxrpc_timer_trace_resend_reset);
+		trace_rxrpc_timer_set(call, resend_at - req.now,
+				      rxrpc_timer_trace_resend_reset);
 	}
 	call->resend_at = resend_at;
 
@@ -186,11 +219,11 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 	 * that an ACK got lost somewhere.  Send a ping to find out instead of
 	 * retransmitting data.
 	 */
-	if (!did_send) {
+	if (!req.did_send) {
 		ktime_t next_ping = ktime_add_us(call->acks_latest_ts,
 						 call->peer->srtt_us >> 3);
 
-		if (ktime_sub(next_ping, now) <= 0)
+		if (ktime_sub(next_ping, req.now) <= 0)
 			rxrpc_send_ACK(call, RXRPC_ACK_PING, 0,
 				       rxrpc_propose_ack_ping_for_0_retrans);
 	}
@@ -240,47 +273,68 @@ static unsigned int rxrpc_tx_window_space(struct rxrpc_call *call)
 }
 
 /*
- * Decant some if the sendmsg prepared queue into the transmission buffer.
+ * Transmit some as-yet untransmitted data.
  */
-static void rxrpc_decant_prepared_tx(struct rxrpc_call *call)
+static void rxrpc_transmit_fresh_data(struct rxrpc_call *call)
 {
 	int space = rxrpc_tx_window_space(call);
 
 	if (!test_bit(RXRPC_CALL_EXPOSED, &call->flags)) {
-		if (list_empty(&call->tx_sendmsg))
+		if (call->send_top == call->tx_top)
 			return;
 		rxrpc_expose_client_call(call);
 	}
 
 	while (space > 0) {
-		struct rxrpc_txbuf *head = NULL, *txb;
-		int count = 0, limit = min(space, 1);
-
-		if (list_empty(&call->tx_sendmsg))
+		struct rxrpc_send_data_req req = {
+			.now	= ktime_get_real(),
+			.seq	= call->tx_transmitted + 1,
+			.n	= 0,
+		};
+		struct rxrpc_txqueue *tq;
+		struct rxrpc_txbuf *txb;
+		rxrpc_seq_t send_top, seq;
+		int limit = min(space, 1);
+
+		/* Order send_top before the contents of the new txbufs and
+		 * txqueue pointers
+		 */
+		send_top = smp_load_acquire(&call->send_top);
+		if (call->tx_top == send_top)
 			break;
 
-		trace_rxrpc_transmit(call, space);
+		trace_rxrpc_transmit(call, send_top, space);
+
+		tq = call->tx_qtail;
+		seq = call->tx_top;
+		trace_rxrpc_tq(call, tq, seq, rxrpc_tq_decant);
 
-		spin_lock(&call->tx_lock);
 		do {
-			txb = list_first_entry(&call->tx_sendmsg,
-					       struct rxrpc_txbuf, call_link);
-			if (!head)
-				head = txb;
-			list_move_tail(&txb->call_link, &call->tx_buffer);
-			count++;
+			int ix;
+
+			seq++;
+			ix = seq & RXRPC_TXQ_MASK;
+			if (!ix) {
+				tq = tq->next;
+				trace_rxrpc_tq(call, tq, seq, rxrpc_tq_decant_advance);
+			}
+			if (!req.tq)
+				req.tq = tq;
+			txb = tq->bufs[ix];
+			req.n++;
 			if (!txb->jumboable)
 				break;
-		} while (count < limit && !list_empty(&call->tx_sendmsg));
+		} while (req.n < limit && before(seq, send_top));
 
-		spin_unlock(&call->tx_lock);
-
-		call->tx_top = txb->seq;
-		if (txb->flags & RXRPC_LAST_PACKET)
+		if (txb->flags & RXRPC_LAST_PACKET) {
 			rxrpc_close_tx_phase(call);
+			tq = NULL;
+		}
+		call->tx_qtail = tq;
+		call->tx_top = seq;
 
-		space -= count;
-		rxrpc_transmit_data(call, head, count);
+		space -= req.n;
+		rxrpc_send_data_packet(call, &req);
 	}
 }
 
@@ -288,7 +342,7 @@ static void rxrpc_transmit_some_data(struct rxrpc_call *call)
 {
 	switch (__rxrpc_call_state(call)) {
 	case RXRPC_CALL_SERVER_ACK_REQUEST:
-		if (list_empty(&call->tx_sendmsg))
+		if (call->tx_bottom == READ_ONCE(call->send_top))
 			return;
 		rxrpc_begin_service_reply(call);
 		fallthrough;
@@ -297,11 +351,11 @@ static void rxrpc_transmit_some_data(struct rxrpc_call *call)
 	case RXRPC_CALL_CLIENT_SEND_REQUEST:
 		if (!rxrpc_tx_window_space(call))
 			return;
-		if (list_empty(&call->tx_sendmsg)) {
+		if (call->tx_bottom == READ_ONCE(call->send_top)) {
 			rxrpc_inc_stat(call->rxnet, stat_tx_data_underflow);
 			return;
 		}
-		rxrpc_decant_prepared_tx(call);
+		rxrpc_transmit_fresh_data(call);
 		break;
 	default:
 		return;
@@ -503,8 +557,6 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
 		    call->peer->pmtud_pending)
 			rxrpc_send_probe_for_pmtud(call);
 	}
-	if (call->acks_hard_ack != call->tx_bottom)
-		rxrpc_shrink_call_tx_buffer(call);
 	_leave("");
 	return true;
 
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index c026f16f891e..a9682b31a4f9 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -146,8 +146,6 @@ struct rxrpc_call *rxrpc_alloc_call(struct rxrpc_sock *rx, gfp_t gfp,
 	INIT_LIST_HEAD(&call->recvmsg_link);
 	INIT_LIST_HEAD(&call->sock_link);
 	INIT_LIST_HEAD(&call->attend_link);
-	INIT_LIST_HEAD(&call->tx_sendmsg);
-	INIT_LIST_HEAD(&call->tx_buffer);
 	skb_queue_head_init(&call->rx_queue);
 	skb_queue_head_init(&call->recvmsg_queue);
 	skb_queue_head_init(&call->rx_oos_queue);
@@ -532,9 +530,26 @@ void rxrpc_get_call(struct rxrpc_call *call, enum rxrpc_call_trace why)
 }
 
 /*
- * Clean up the Rx skb ring.
+ * Clean up the transmission buffers.
  */
-static void rxrpc_cleanup_ring(struct rxrpc_call *call)
+static void rxrpc_cleanup_tx_buffers(struct rxrpc_call *call)
+{
+	struct rxrpc_txqueue *tq, *next;
+
+	for (tq = call->tx_queue; tq; tq = next) {
+		next = tq->next;
+		for (int i = 0; i < RXRPC_NR_TXQUEUE; i++)
+			if (tq->bufs[i])
+				rxrpc_put_txbuf(tq->bufs[i], rxrpc_txbuf_put_cleaned);
+		trace_rxrpc_tq(call, tq, 0, rxrpc_tq_cleaned);
+		kfree(tq);
+	}
+}
+
+/*
+ * Clean up the receive buffers.
+ */
+static void rxrpc_cleanup_rx_buffers(struct rxrpc_call *call)
 {
 	rxrpc_purge_queue(&call->recvmsg_queue);
 	rxrpc_purge_queue(&call->rx_queue);
@@ -673,23 +688,12 @@ static void rxrpc_rcu_free_call(struct rcu_head *rcu)
 static void rxrpc_destroy_call(struct work_struct *work)
 {
 	struct rxrpc_call *call = container_of(work, struct rxrpc_call, destroyer);
-	struct rxrpc_txbuf *txb;
 
 	del_timer_sync(&call->timer);
 
 	rxrpc_free_skb(call->cong_last_nack, rxrpc_skb_put_last_nack);
-	rxrpc_cleanup_ring(call);
-	while ((txb = list_first_entry_or_null(&call->tx_sendmsg,
-					       struct rxrpc_txbuf, call_link))) {
-		list_del(&txb->call_link);
-		rxrpc_put_txbuf(txb, rxrpc_txbuf_put_cleaned);
-	}
-	while ((txb = list_first_entry_or_null(&call->tx_buffer,
-					       struct rxrpc_txbuf, call_link))) {
-		list_del(&txb->call_link);
-		rxrpc_put_txbuf(txb, rxrpc_txbuf_put_cleaned);
-	}
-
+	rxrpc_cleanup_tx_buffers(call);
+	rxrpc_cleanup_rx_buffers(call);
 	rxrpc_put_txbuf(call->tx_pending, rxrpc_txbuf_put_cleaned);
 	rxrpc_put_connection(call->conn, rxrpc_conn_put_call);
 	rxrpc_deactivate_bundle(call->bundle);
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 96fe005c5e81..03fd11a9bd31 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -214,24 +214,71 @@ void rxrpc_congestion_degrade(struct rxrpc_call *call)
 static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 				   struct rxrpc_ack_summary *summary)
 {
-	struct rxrpc_txbuf *txb;
+	struct rxrpc_txqueue *tq = call->tx_queue;
+	rxrpc_seq_t seq = call->tx_bottom + 1;
 	bool rot_last = false;
 
-	list_for_each_entry_rcu(txb, &call->tx_buffer, call_link, false) {
-		if (before_eq(txb->seq, call->acks_hard_ack))
-			continue;
-		if (txb->flags & RXRPC_LAST_PACKET) {
+	_enter("%x,%x,%x", call->tx_bottom, call->acks_hard_ack, to);
+
+	trace_rxrpc_tx_rotate(call, seq, to);
+	trace_rxrpc_tq(call, tq, seq, rxrpc_tq_rotate);
+
+	/* We may have a left over fully-consumed buffer at the front that we
+	 * couldn't drop before (rotate_and_keep below).
+	 */
+	if (seq == call->tx_qbase + RXRPC_NR_TXQUEUE) {
+		call->tx_qbase += RXRPC_NR_TXQUEUE;
+		call->tx_queue = tq->next;
+		trace_rxrpc_tq(call, tq, seq, rxrpc_tq_rotate_and_free);
+		kfree(tq);
+		tq = call->tx_queue;
+	}
+
+	do {
+		unsigned int ix = seq - call->tx_qbase;
+
+		_debug("tq=%x seq=%x i=%d f=%x", tq->qbase, seq, ix, tq->bufs[ix]->flags);
+		if (tq->bufs[ix]->flags & RXRPC_LAST_PACKET) {
 			set_bit(RXRPC_CALL_TX_LAST, &call->flags);
 			rot_last = true;
 		}
-		if (txb->seq == to)
-			break;
-	}
+		rxrpc_put_txbuf(tq->bufs[ix], rxrpc_txbuf_put_rotated);
+		tq->bufs[ix] = NULL;
+
+		smp_store_release(&call->tx_bottom, seq);
+		smp_store_release(&call->acks_hard_ack, seq);
+		trace_rxrpc_txqueue(call, (rot_last ?
+					   rxrpc_txqueue_rotate_last :
+					   rxrpc_txqueue_rotate));
 
-	if (rot_last)
+		seq++;
+		if (!(seq & RXRPC_TXQ_MASK)) {
+			prefetch(tq->next);
+			if (tq != call->tx_qtail) {
+				call->tx_qbase += RXRPC_NR_TXQUEUE;
+				call->tx_queue = tq->next;
+				trace_rxrpc_tq(call, tq, seq, rxrpc_tq_rotate_and_free);
+				kfree(tq);
+				tq = call->tx_queue;
+			} else {
+				trace_rxrpc_tq(call, tq, seq, rxrpc_tq_rotate_and_keep);
+				tq = NULL;
+				break;
+			}
+		}
+
+	} while (before_eq(seq, to));
+
+	if (rot_last) {
 		set_bit(RXRPC_CALL_TX_ALL_ACKED, &call->flags);
+		if (tq) {
+			trace_rxrpc_tq(call, tq, seq, rxrpc_tq_rotate_and_free);
+			kfree(tq);
+			call->tx_queue = NULL;
+		}
+	}
 
-	_enter("%x,%x,%x,%d", to, call->acks_hard_ack, call->tx_top, rot_last);
+	_debug("%x,%x,%x,%d", to, call->acks_hard_ack, call->tx_top, rot_last);
 
 	if (call->acks_lowest_nak == call->acks_hard_ack) {
 		call->acks_lowest_nak = to;
@@ -240,11 +287,6 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 		call->acks_lowest_nak = to;
 	}
 
-	smp_store_release(&call->acks_hard_ack, to);
-
-	trace_rxrpc_txqueue(call, (rot_last ?
-				   rxrpc_txqueue_rotate_last :
-				   rxrpc_txqueue_rotate));
 	wake_up(&call->waitq);
 	return rot_last;
 }
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 7b068a33eb21..f785ea0ade43 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -374,10 +374,10 @@ int rxrpc_send_abort_packet(struct rxrpc_call *call)
 /*
  * Prepare a (sub)packet for transmission.
  */
-static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc_txbuf *txb,
-					   rxrpc_serial_t serial,
-					   int subpkt, int nr_subpkts,
-					   ktime_t now)
+static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call,
+					   struct rxrpc_send_data_req *req,
+					   struct rxrpc_txbuf *txb,
+					   rxrpc_serial_t serial, int subpkt)
 {
 	struct rxrpc_wire_header *whdr = txb->kvec[0].iov_base;
 	struct rxrpc_jumbo_header *jumbo = (void *)(whdr + 1) - sizeof(*jumbo);
@@ -385,7 +385,7 @@ static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc
 	struct rxrpc_connection *conn = call->conn;
 	struct kvec *kv = &call->local->kvec[subpkt];
 	size_t len = txb->pkt_len;
-	bool last, more;
+	bool last;
 	u8 flags;
 
 	_enter("%x,%zd", txb->seq, len);
@@ -400,14 +400,11 @@ static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc
 	flags = txb->flags & RXRPC_TXBUF_WIRE_FLAGS;
 	last = txb->flags & RXRPC_LAST_PACKET;
 
-	if (subpkt < nr_subpkts - 1) {
+	if (subpkt < req->n - 1) {
 		len = RXRPC_JUMBO_DATALEN;
 		goto dont_set_request_ack;
 	}
 
-	more = (!list_is_last(&txb->call_link, &call->tx_buffer) ||
-		!list_empty(&call->tx_sendmsg));
-
 	/* If our RTT cache needs working on, request an ACK.  Also request
 	 * ACKs if a DATA packet appears to have been lost.
 	 *
@@ -429,7 +426,7 @@ static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc
 		why = rxrpc_reqack_more_rtt;
 	else if (ktime_before(ktime_add_ms(call->peer->rtt_last_req, 1000), ktime_get_real()))
 		why = rxrpc_reqack_old_rtt;
-	else if (!last && !more)
+	else if (!last && !after(READ_ONCE(call->send_top), txb->seq))
 		why = rxrpc_reqack_app_stall;
 	else
 		goto dont_set_request_ack;
@@ -438,13 +435,13 @@ static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc
 	trace_rxrpc_req_ack(call->debug_id, txb->seq, why);
 	if (why != rxrpc_reqack_no_srv_last) {
 		flags |= RXRPC_REQUEST_ACK;
-		rxrpc_begin_rtt_probe(call, serial, now, rxrpc_rtt_tx_data);
-		call->peer->rtt_last_req = now;
+		rxrpc_begin_rtt_probe(call, serial, req->now, rxrpc_rtt_tx_data);
+		call->peer->rtt_last_req = req->now;
 	}
 dont_set_request_ack:
 
 	/* The jumbo header overlays the wire header in the txbuf. */
-	if (subpkt < nr_subpkts - 1)
+	if (subpkt < req->n - 1)
 		flags |= RXRPC_JUMBO_PACKET;
 	else
 		flags &= ~RXRPC_JUMBO_PACKET;
@@ -468,62 +465,100 @@ static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc
 	return len;
 }
 
+/*
+ * Prepare a transmission queue object for initial transmission.  Returns the
+ * number of microseconds since the transmission queue base timestamp.
+ */
+static unsigned int rxrpc_prepare_txqueue(struct rxrpc_txqueue *tq,
+					  struct rxrpc_send_data_req *req)
+{
+	if (!tq)
+		return 0;
+	if (tq->xmit_ts_base == KTIME_MIN) {
+		tq->xmit_ts_base = req->now;
+		return 0;
+	}
+	return ktime_to_us(ktime_sub(req->now, tq->xmit_ts_base));
+}
+
 /*
  * Prepare a (jumbo) packet for transmission.
  */
-static size_t rxrpc_prepare_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *head, int n)
+static size_t rxrpc_prepare_data_packet(struct rxrpc_call *call, struct rxrpc_send_data_req *req)
 {
-	struct rxrpc_txbuf *txb = head;
+	struct rxrpc_txqueue *tq = req->tq;
 	rxrpc_serial_t serial;
-	ktime_t now = ktime_get_real();
+	unsigned int xmit_ts;
+	rxrpc_seq_t seq = req->seq;
 	size_t len = 0;
 
+	trace_rxrpc_tq(call, tq, seq, rxrpc_tq_transmit);
+
 	/* Each transmission of a Tx packet needs a new serial number */
-	serial = rxrpc_get_next_serials(call->conn, n);
+	serial = rxrpc_get_next_serials(call->conn, req->n);
 
-	for (int i = 0; i < n; i++) {
-		txb->last_sent = now;
-		len += rxrpc_prepare_data_subpacket(call, txb, serial, i, n, now);
-		serial++;
-		txb = list_next_entry(txb, call_link);
-	}
+	call->tx_last_sent = req->now;
+	xmit_ts = rxrpc_prepare_txqueue(tq, req);
+	prefetch(tq->next);
 
-	/* Set timeouts */
-	if (call->peer->rtt_count > 1) {
-		ktime_t delay = rxrpc_get_rto_backoff(call->peer, false);
+	for (int i = 0;;) {
+		int ix = seq & RXRPC_TXQ_MASK;
+		struct rxrpc_txbuf *txb = tq->bufs[seq & RXRPC_TXQ_MASK];
 
-		call->ack_lost_at = ktime_add(now, delay);
-		trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_lost_ack);
+		_debug("prep[%u] tq=%x q=%x", i, tq->qbase, seq);
+		tq->segment_xmit_ts[ix] = xmit_ts;
+		len += rxrpc_prepare_data_subpacket(call, req, txb, serial, i);
+		serial++;
+		seq++;
+		i++;
+		if (i >= req->n)
+			break;
+		if (!(seq & RXRPC_TXQ_MASK)) {
+			tq = tq->next;
+			trace_rxrpc_tq(call, tq, seq, rxrpc_tq_transmit_advance);
+			xmit_ts = rxrpc_prepare_txqueue(tq, req);
+		}
 	}
 
+	/* Set timeouts */
 	if (!test_and_set_bit(RXRPC_CALL_BEGAN_RX_TIMER, &call->flags)) {
 		ktime_t delay = ms_to_ktime(READ_ONCE(call->next_rx_timo));
 
-		call->expect_rx_by = ktime_add(now, delay);
+		call->expect_rx_by = ktime_add(req->now, delay);
 		trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_expect_rx);
 	}
+	if (call->resend_at == KTIME_MAX) {
+		ktime_t delay = rxrpc_get_rto_backoff(call->peer, false);
 
-	rxrpc_set_keepalive(call, now);
+		call->resend_at = ktime_add(req->now, delay);
+		trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_resend);
+	}
+
+	rxrpc_set_keepalive(call, req->now);
 	return len;
 }
 
 /*
- * send a packet through the transport endpoint
+ * Send one or more packets through the transport endpoint
  */
-static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb, int n)
+void rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_send_data_req *req)
 {
 	struct rxrpc_connection *conn = call->conn;
 	enum rxrpc_tx_point frag;
+	struct rxrpc_txqueue *tq = req->tq;
+	struct rxrpc_txbuf *txb;
 	struct msghdr msg;
+	rxrpc_seq_t seq = req->seq;
 	size_t len;
 	bool new_call = test_bit(RXRPC_CALL_BEGAN_RX_TIMER, &call->flags);
 	int ret;
 
-	_enter("%x,{%d}", txb->seq, txb->pkt_len);
+	_enter("%x,%x-%x", tq->qbase, seq, seq + req->n - 1);
 
-	len = rxrpc_prepare_data_packet(call, txb, n);
+	len = rxrpc_prepare_data_packet(call, req);
+	txb = tq->bufs[seq & RXRPC_TXQ_MASK];
 
-	iov_iter_kvec(&msg.msg_iter, WRITE, call->local->kvec, n, len);
+	iov_iter_kvec(&msg.msg_iter, WRITE, call->local->kvec, req->n, len);
 
 	msg.msg_name	= &call->peer->srx.transport;
 	msg.msg_namelen	= call->peer->srx.transport_len;
@@ -534,7 +569,7 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 	/* Send the packet with the don't fragment bit set unless we think it's
 	 * too big or if this is a retransmission.
 	 */
-	if (txb->seq == call->tx_transmitted + 1 &&
+	if (seq == call->tx_transmitted + 1 &&
 	    len >= sizeof(struct rxrpc_wire_header) + call->peer->max_data) {
 		rxrpc_local_dont_fragment(conn->local, false);
 		frag = rxrpc_tx_point_call_data_frag;
@@ -547,8 +582,8 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 	 * retransmission algorithm doesn't try to resend what we haven't sent
 	 * yet.
 	 */
-	if (txb->seq == call->tx_transmitted + 1)
-		call->tx_transmitted = txb->seq + n - 1;
+	if (seq == call->tx_transmitted + 1)
+		call->tx_transmitted = seq + req->n - 1;
 
 	if (IS_ENABLED(CONFIG_AF_RXRPC_INJECT_LOSS)) {
 		static int lose;
@@ -584,19 +619,21 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 	rxrpc_tx_backoff(call, ret);
 
 	if (ret < 0) {
-		/* Cancel the call if the initial transmission fails,
-		 * particularly if that's due to network routing issues that
-		 * aren't going away anytime soon.  The layer above can arrange
-		 * the retransmission.
+		/* Cancel the call if the initial transmission fails or if we
+		 * hit due to network routing issues that aren't going away
+		 * anytime soon.  The layer above can arrange the
+		 * retransmission.
 		 */
-		if (new_call)
+		if (new_call ||
+		    ret == -ENETUNREACH ||
+		    ret == -EHOSTUNREACH ||
+		    ret == -ECONNREFUSED)
 			rxrpc_set_call_completion(call, RXRPC_CALL_LOCAL_ERROR,
 						  RX_USER_ABORT, ret);
 	}
 
 done:
 	_leave(" = %d [%u]", ret, call->peer->max_data);
-	return ret;
 }
 
 /*
@@ -775,37 +812,8 @@ void rxrpc_send_keepalive(struct rxrpc_peer *peer)
 /*
  * Schedule an instant Tx resend.
  */
-static inline void rxrpc_instant_resend(struct rxrpc_call *call,
-					struct rxrpc_txbuf *txb)
+static inline void rxrpc_instant_resend(struct rxrpc_call *call)
 {
 	if (!__rxrpc_call_is_complete(call))
 		kdebug("resend");
 }
-
-/*
- * Transmit a packet, possibly gluing several subpackets together.
- */
-void rxrpc_transmit_data(struct rxrpc_call *call, struct rxrpc_txbuf *txb, int n)
-{
-	int ret;
-
-	ret = rxrpc_send_data_packet(call, txb, n);
-	if (ret < 0) {
-		switch (ret) {
-		case -ENETUNREACH:
-		case -EHOSTUNREACH:
-		case -ECONNREFUSED:
-			rxrpc_set_call_completion(call, RXRPC_CALL_LOCAL_ERROR,
-						  0, ret);
-			break;
-		default:
-			_debug("need instant resend %d", ret);
-			rxrpc_instant_resend(call, txb);
-		}
-	} else {
-		ktime_t delay = ns_to_ktime(call->peer->rto_us * NSEC_PER_USEC);
-
-		call->resend_at = ktime_add(ktime_get_real(), delay);
-		trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_resend_tx);
-	}
-}
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 786c1fb1369a..cb9b38fc5cf8 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -96,7 +96,7 @@ static bool rxrpc_check_tx_space(struct rxrpc_call *call, rxrpc_seq_t *_tx_win)
 {
 	if (_tx_win)
 		*_tx_win = call->tx_bottom;
-	return call->tx_prepared - call->tx_bottom < 256;
+	return call->send_top - call->tx_bottom < 256;
 }
 
 /*
@@ -240,36 +240,74 @@ static void rxrpc_queue_packet(struct rxrpc_sock *rx, struct rxrpc_call *call,
 			       struct rxrpc_txbuf *txb,
 			       rxrpc_notify_end_tx_t notify_end_tx)
 {
+	struct rxrpc_txqueue *sq = call->send_queue;
 	rxrpc_seq_t seq = txb->seq;
 	bool poke, last = txb->flags & RXRPC_LAST_PACKET;
-
+	int ix = seq & RXRPC_TXQ_MASK;
 	rxrpc_inc_stat(call->rxnet, stat_tx_data);
 
-	ASSERTCMP(txb->seq, ==, call->tx_prepared + 1);
-
-	/* We have to set the timestamp before queueing as the retransmit
-	 * algorithm can see the packet as soon as we queue it.
-	 */
-	txb->last_sent = ktime_get_real();
+	ASSERTCMP(txb->seq, ==, call->send_top + 1);
 
 	if (last)
 		trace_rxrpc_txqueue(call, rxrpc_txqueue_queue_last);
 	else
 		trace_rxrpc_txqueue(call, rxrpc_txqueue_queue);
 
+	if (WARN_ON_ONCE(sq->bufs[ix]))
+		trace_rxrpc_tq(call, sq, seq, rxrpc_tq_queue_dup);
+	else
+		trace_rxrpc_tq(call, sq, seq, rxrpc_tq_queue);
+
 	/* Add the packet to the call's output buffer */
 	spin_lock(&call->tx_lock);
-	poke = list_empty(&call->tx_sendmsg);
-	list_add_tail(&txb->call_link, &call->tx_sendmsg);
-	call->tx_prepared = seq;
-	if (last)
+	poke = (call->tx_bottom == call->send_top);
+	sq->bufs[ix] = txb;
+	/* Order send_top after the queue->next pointer and txb content. */
+	smp_store_release(&call->send_top, seq);
+	if (last) {
 		rxrpc_notify_end_tx(rx, call, notify_end_tx);
+		call->send_queue = NULL;
+	}
 	spin_unlock(&call->tx_lock);
 
 	if (poke)
 		rxrpc_poke_call(call, rxrpc_call_poke_start);
 }
 
+/*
+ * Allocate a new txqueue unit and add it to the transmission queue.
+ */
+static int rxrpc_alloc_txqueue(struct sock *sk, struct rxrpc_call *call)
+{
+	struct rxrpc_txqueue *tq;
+
+	tq = kzalloc(sizeof(*tq), sk->sk_allocation);
+	if (!tq)
+		return -ENOMEM;
+
+	tq->xmit_ts_base = KTIME_MIN;
+	for (int i = 0; i < RXRPC_NR_TXQUEUE; i++)
+		tq->segment_xmit_ts[i] = UINT_MAX;
+
+	if (call->send_queue) {
+		tq->qbase = call->send_top + 1;
+		call->send_queue->next = tq;
+		call->send_queue = tq;
+	} else if (WARN_ON(call->tx_queue)) {
+		kfree(tq);
+		return -ENOMEM;
+	} else {
+		tq->qbase = 0;
+		call->tx_qbase = 0;
+		call->send_queue = tq;
+		call->tx_qtail = tq;
+		call->tx_queue = tq;
+	}
+
+	trace_rxrpc_tq(call, tq, call->send_top, rxrpc_tq_alloc);
+	return 0;
+}
+
 /*
  * send data through a socket
  * - must be called in process context
@@ -344,6 +382,13 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 			if (!rxrpc_check_tx_space(call, NULL))
 				goto wait_for_space;
 
+			/* See if we need to begin/extend the Tx queue. */
+			if (!call->send_queue || !((call->send_top + 1) & RXRPC_TXQ_MASK)) {
+				ret = rxrpc_alloc_txqueue(sk, call);
+				if (ret < 0)
+					goto maybe_error;
+			}
+
 			/* Work out the maximum size of a packet.  Assume that
 			 * the security header is going to be in the padded
 			 * region (enc blocksize), but the trailer is not.
diff --git a/net/rxrpc/txbuf.c b/net/rxrpc/txbuf.c
index 8b7c854ed3d7..067223c8c35f 100644
--- a/net/rxrpc/txbuf.c
+++ b/net/rxrpc/txbuf.c
@@ -43,17 +43,14 @@ struct rxrpc_txbuf *rxrpc_alloc_data_txbuf(struct rxrpc_call *call, size_t data_
 
 	whdr = buf + hoff;
 
-	INIT_LIST_HEAD(&txb->call_link);
-	INIT_LIST_HEAD(&txb->tx_link);
 	refcount_set(&txb->ref, 1);
-	txb->last_sent		= KTIME_MIN;
 	txb->call_debug_id	= call->debug_id;
 	txb->debug_id		= atomic_inc_return(&rxrpc_txbuf_debug_ids);
 	txb->alloc_size		= data_size;
 	txb->space		= data_size;
 	txb->offset		= sizeof(*whdr);
 	txb->flags		= call->conn->out_clientflag;
-	txb->seq		= call->tx_prepared + 1;
+	txb->seq		= call->send_top + 1;
 	txb->nr_kvec		= 1;
 	txb->kvec[0].iov_base	= whdr;
 	txb->kvec[0].iov_len	= sizeof(*whdr);
@@ -114,8 +111,6 @@ struct rxrpc_txbuf *rxrpc_alloc_ack_txbuf(struct rxrpc_call *call, size_t sack_s
 	filler	= buf + sizeof(*whdr) + sizeof(*ack) + 1;
 	trailer	= buf + sizeof(*whdr) + sizeof(*ack) + 1 + 3;
 
-	INIT_LIST_HEAD(&txb->call_link);
-	INIT_LIST_HEAD(&txb->tx_link);
 	refcount_set(&txb->ref, 1);
 	txb->call_debug_id	= call->debug_id;
 	txb->debug_id		= atomic_inc_return(&rxrpc_txbuf_debug_ids);
@@ -200,37 +195,3 @@ void rxrpc_put_txbuf(struct rxrpc_txbuf *txb, enum rxrpc_txbuf_trace what)
 			rxrpc_free_txbuf(txb);
 	}
 }
-
-/*
- * Shrink the transmit buffer.
- */
-void rxrpc_shrink_call_tx_buffer(struct rxrpc_call *call)
-{
-	struct rxrpc_txbuf *txb;
-	rxrpc_seq_t hard_ack = smp_load_acquire(&call->acks_hard_ack);
-	bool wake = false;
-
-	_enter("%x/%x/%x", call->tx_bottom, call->acks_hard_ack, call->tx_top);
-
-	while ((txb = list_first_entry_or_null(&call->tx_buffer,
-					       struct rxrpc_txbuf, call_link))) {
-		hard_ack = smp_load_acquire(&call->acks_hard_ack);
-		if (before(hard_ack, txb->seq))
-			break;
-
-		if (txb->seq != call->tx_bottom + 1)
-			rxrpc_see_txbuf(txb, rxrpc_txbuf_see_out_of_step);
-		ASSERTCMP(txb->seq, ==, call->tx_bottom + 1);
-		smp_store_release(&call->tx_bottom, call->tx_bottom + 1);
-		list_del_rcu(&txb->call_link);
-
-		trace_rxrpc_txqueue(call, rxrpc_txqueue_dequeue);
-
-		rxrpc_put_txbuf(txb, rxrpc_txbuf_put_rotated);
-		if (after(call->acks_hard_ack, call->tx_bottom + 128))
-			wake = true;
-	}
-
-	if (wake)
-		wake_up(&call->waitq);
-}


