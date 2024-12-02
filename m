Return-Path: <netdev+bounces-148090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BE79E0546
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A4F28453C
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B79820FAAB;
	Mon,  2 Dec 2024 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6jfkCUS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4E820FA88
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149962; cv=none; b=Z/Q7n6HzMX6nkO18dD8hOCHgFTny/1OuroDoeb72ave/xPfjqxkrzvo0HGTDGjyQAFUQobwESBDbnq+fdBE1+cTUuS8znqkoXN3enH1KY2s0SnmNpRJrv20zJvso0qYBsRSIlzuwMPiAG9nSdJIl7qlR1ztjw0dojBOU9HyrL9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149962; c=relaxed/simple;
	bh=f+o1xKM7tqWbcIewfQ8e5e8Jgx6gA+aSF/HJ6AGkiA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5I+2APcXTp2Jtpv0f76oZS1ASWEUekbFomDfL5NLxXzOrH1H7eEMDlKU935BmB+CmcQCvUToemMqkBfobZIdeQyB79PPRx2MyoSYRhc4LZP3hh/u3hCJmwIvhoHWME3Jzkr4mSpocoytDrZf9IQ50i9qFudgbpN6GciOpi0ySI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B6jfkCUS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733149959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mm9rCZqaXJppWoVaS65DznNJZiOFIwQ63QiK4lvW6XQ=;
	b=B6jfkCUSJff/xLL/iDhynZFkgOV5e9hR5daOWRZqIvrAVdKFE6A8Nw4QkQy+vLMFj1FdeN
	HxoNcPg51hdJpF+/NYrQ6wCUyrFry74x+5cduQjmH0XG/28leo1YNV7rn7CqTvMWDSTPxk
	ADoX6yRvWoNVeCQaPf3jis1dFyRagiU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-p4FhbsVkN4OhtJ4VI43ctA-1; Mon,
 02 Dec 2024 09:32:36 -0500
X-MC-Unique: p4FhbsVkN4OhtJ4VI43ctA-1
X-Mimecast-MFC-AGG-ID: p4FhbsVkN4OhtJ4VI43ctA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 840B01910062;
	Mon,  2 Dec 2024 14:32:34 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 046031955D45;
	Mon,  2 Dec 2024 14:32:31 +0000 (UTC)
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
Subject: [PATCH net-next 22/37] rxrpc: Store the DATA serial in the txqueue and use this in RTT calc
Date: Mon,  2 Dec 2024 14:30:40 +0000
Message-ID: <20241202143057.378147-23-dhowells@redhat.com>
In-Reply-To: <20241202143057.378147-1-dhowells@redhat.com>
References: <20241202143057.378147-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Store the serial number set on a DATA packet at the point of transmission
in the rxrpc_txqueue struct and when an ACK is received, match the
reference number in the ACK by trawling the txqueue rather than sharing an
RTT table with ACK RTT.  This can be done as part of Tx queue rotation.

This means we have a lot more RTT samples available and is faster to search
with all the serial numbers packed together into a few cachelines rather
than being hung off different txbufs.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h | 14 ++----
 net/rxrpc/ar-internal.h      |  4 ++
 net/rxrpc/call_event.c       |  8 +--
 net/rxrpc/input.c            | 94 +++++++++++++++++++++++-------------
 net/rxrpc/output.c           |  6 ++-
 5 files changed, 79 insertions(+), 47 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 609522a5bd0f..798bea0853c4 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -337,11 +337,10 @@
 	E_(rxrpc_rtt_tx_ping,			"PING")
 
 #define rxrpc_rtt_rx_traces \
-	EM(rxrpc_rtt_rx_other_ack,		"OACK") \
+	EM(rxrpc_rtt_rx_data_ack,		"DACK") \
 	EM(rxrpc_rtt_rx_obsolete,		"OBSL") \
 	EM(rxrpc_rtt_rx_lost,			"LOST") \
-	EM(rxrpc_rtt_rx_ping_response,		"PONG") \
-	E_(rxrpc_rtt_rx_requested_ack,		"RACK")
+	E_(rxrpc_rtt_rx_ping_response,		"PONG")
 
 #define rxrpc_timer_traces \
 	EM(rxrpc_timer_trace_delayed_ack,	"DelayAck ") \
@@ -1695,10 +1694,9 @@ TRACE_EVENT(rxrpc_retransmit,
 	    );
 
 TRACE_EVENT(rxrpc_congest,
-	    TP_PROTO(struct rxrpc_call *call, struct rxrpc_ack_summary *summary,
-		     rxrpc_serial_t ack_serial),
+	    TP_PROTO(struct rxrpc_call *call, struct rxrpc_ack_summary *summary),
 
-	    TP_ARGS(call, summary, ack_serial),
+	    TP_ARGS(call, summary),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,			call)
@@ -1706,7 +1704,6 @@ TRACE_EVENT(rxrpc_congest,
 		    __field(rxrpc_seq_t,			hard_ack)
 		    __field(rxrpc_seq_t,			top)
 		    __field(rxrpc_seq_t,			lowest_nak)
-		    __field(rxrpc_serial_t,			ack_serial)
 		    __field(u16,				nr_sacks)
 		    __field(u16,				nr_snacks)
 		    __field(u16,				cwnd)
@@ -1722,7 +1719,6 @@ TRACE_EVENT(rxrpc_congest,
 		    __entry->hard_ack	= call->acks_hard_ack;
 		    __entry->top	= call->tx_top;
 		    __entry->lowest_nak	= call->acks_lowest_nak;
-		    __entry->ack_serial	= ack_serial;
 		    __entry->nr_sacks	= call->acks_nr_sacks;
 		    __entry->nr_snacks	= call->acks_nr_snacks;
 		    __entry->cwnd	= call->cong_cwnd;
@@ -1734,7 +1730,7 @@ TRACE_EVENT(rxrpc_congest,
 
 	    TP_printk("c=%08x r=%08x %s q=%08x %s cw=%u ss=%u A=%u+%u/%u+%u r=%u b=%u u=%u d=%u l=%x%s%s%s",
 		      __entry->call,
-		      __entry->ack_serial,
+		      __entry->sum.acked_serial,
 		      __print_symbolic(__entry->sum.ack_reason, rxrpc_ack_names),
 		      __entry->hard_ack,
 		      __print_symbolic(__entry->ca_state, rxrpc_ca_states),
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 9a5eb6fa1dd1..e68d0ecc4866 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -769,6 +769,7 @@ struct rxrpc_call {
  * Summary of a new ACK and the changes it made to the Tx buffer packet states.
  */
 struct rxrpc_ack_summary {
+	rxrpc_serial_t	acked_serial;		/* Serial number ACK'd */
 	u16		in_flight;		/* Number of unreceived transmissions */
 	u16		nr_new_hacks;		/* Number of rotated new ACKs */
 	u16		nr_new_sacks;		/* Number of new soft ACKs in packet */
@@ -777,6 +778,7 @@ struct rxrpc_ack_summary {
 	bool		new_low_snack:1;	/* T if new low soft NACK found */
 	bool		retrans_timeo:1;	/* T if reTx due to timeout happened */
 	bool		need_retransmit:1;	/* T if we need transmission */
+	bool		rtt_sample_avail:1;	/* T if RTT sample available */
 	u8 /*enum rxrpc_congest_change*/ change;
 };
 
@@ -859,12 +861,14 @@ struct rxrpc_txqueue {
 	unsigned long		segment_acked;	/* Bit-per-buf: Set if ACK'd */
 	unsigned long		segment_lost;	/* Bit-per-buf: Set if declared lost */
 	unsigned long		segment_retransmitted; /* Bit-per-buf: Set if retransmitted */
+	unsigned long		rtt_samples;	/* Bit-per-buf: Set if available for RTT */
 
 	/* The arrays we want to pack into as few cache lines as possible. */
 	struct {
 #define RXRPC_NR_TXQUEUE BITS_PER_LONG
 #define RXRPC_TXQ_MASK (RXRPC_NR_TXQUEUE - 1)
 		struct rxrpc_txbuf *bufs[RXRPC_NR_TXQUEUE];
+		unsigned int	segment_serial[RXRPC_NR_TXQUEUE];
 		unsigned int	segment_xmit_ts[RXRPC_NR_TXQUEUE];
 	} ____cacheline_aligned;
 };
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 887470fb28a4..48bc06842f99 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -159,11 +159,11 @@ void rxrpc_resend(struct rxrpc_call *call, rxrpc_serial_t ack_serial, bool ping_
 			rxrpc_seq_t stop = earliest(tq_top, call->tx_transmitted);
 
 			_debug("unrep %x-%x", start, stop);
-			for (rxrpc_seq_t seq = start; before(seq, stop); seq++) {
-				struct rxrpc_txbuf *txb = tq->bufs[seq & RXRPC_TXQ_MASK];
+			for (rxrpc_seq_t seq = start; before_eq(seq, stop); seq++) {
+				rxrpc_serial_t serial = tq->segment_serial[seq & RXRPC_TXQ_MASK];
 
 				if (ping_response &&
-				    before(txb->serial, call->acks_highest_serial))
+				    before(serial, call->acks_highest_serial))
 					break; /* Wasn't accounted for by a more recent ping. */
 				req.tq  = tq;
 				req.seq = seq;
@@ -197,7 +197,7 @@ void rxrpc_resend(struct rxrpc_call *call, rxrpc_serial_t ack_serial, bool ping_
 
 		_debug("delay %llu %lld", delay, ktime_sub(resend_at, req.now));
 		call->resend_at = resend_at;
-		trace_rxrpc_timer_set(call, resend_at - req.now,
+		trace_rxrpc_timer_set(call, ktime_sub(resend_at, req.now),
 				      rxrpc_timer_trace_resend_reset);
 	} else {
 		call->resend_at = KTIME_MAX;
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 5aadc087794e..5226d26294db 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -30,9 +30,7 @@ static void rxrpc_proto_abort(struct rxrpc_call *call, rxrpc_seq_t seq,
  * Do TCP-style congestion management [RFC 5681].
  */
 static void rxrpc_congestion_management(struct rxrpc_call *call,
-					struct sk_buff *skb,
-					struct rxrpc_ack_summary *summary,
-					rxrpc_serial_t acked_serial)
+					struct rxrpc_ack_summary *summary)
 {
 	summary->change = rxrpc_cong_no_change;
 	summary->in_flight = (call->tx_top - call->tx_bottom) - call->acks_nr_sacks;
@@ -44,7 +42,7 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 		if (call->cong_cwnd >= call->cong_ssthresh &&
 		    call->cong_ca_state == RXRPC_CA_SLOW_START) {
 			call->cong_ca_state = RXRPC_CA_CONGEST_AVOIDANCE;
-			call->cong_tstamp = skb->tstamp;
+			call->cong_tstamp = call->acks_latest_ts;
 			call->cong_cumul_acks = 0;
 		}
 	}
@@ -62,7 +60,7 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 			call->cong_cwnd += 1;
 		if (call->cong_cwnd >= call->cong_ssthresh) {
 			call->cong_ca_state = RXRPC_CA_CONGEST_AVOIDANCE;
-			call->cong_tstamp = skb->tstamp;
+			call->cong_tstamp = call->acks_latest_ts;
 		}
 		goto out;
 
@@ -75,12 +73,12 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 		 */
 		if (call->peer->rtt_count == 0)
 			goto out;
-		if (ktime_before(skb->tstamp,
+		if (ktime_before(call->acks_latest_ts,
 				 ktime_add_us(call->cong_tstamp,
 					      call->peer->srtt_us >> 3)))
 			goto out_no_clear_ca;
 		summary->change = rxrpc_cong_rtt_window_end;
-		call->cong_tstamp = skb->tstamp;
+		call->cong_tstamp = call->acks_latest_ts;
 		if (call->cong_cumul_acks >= call->cong_cwnd)
 			call->cong_cwnd++;
 		goto out;
@@ -137,7 +135,7 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 	summary->change = rxrpc_cong_cleared_nacks;
 	call->cong_dup_acks = 0;
 	call->cong_extra = 0;
-	call->cong_tstamp = skb->tstamp;
+	call->cong_tstamp = call->acks_latest_ts;
 	if (call->cong_cwnd < call->cong_ssthresh)
 		call->cong_ca_state = RXRPC_CA_SLOW_START;
 	else
@@ -147,7 +145,7 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 out_no_clear_ca:
 	if (call->cong_cwnd >= RXRPC_TX_MAX_WINDOW)
 		call->cong_cwnd = RXRPC_TX_MAX_WINDOW;
-	trace_rxrpc_congest(call, summary, acked_serial);
+	trace_rxrpc_congest(call, summary);
 	return;
 
 packet_loss_detected:
@@ -194,11 +192,29 @@ void rxrpc_congestion_degrade(struct rxrpc_call *call)
 	call->cong_cwnd = umax(call->cong_cwnd / 2, RXRPC_MIN_CWND);
 }
 
+/*
+ * Add an RTT sample derived from an ACK'd DATA packet.
+ */
+static void rxrpc_add_data_rtt_sample(struct rxrpc_call *call,
+				      struct rxrpc_ack_summary *summary,
+				      struct rxrpc_txqueue *tq,
+				      int ix,
+				      rxrpc_serial_t ack_serial)
+{
+	rxrpc_peer_add_rtt(call, rxrpc_rtt_rx_data_ack, -1,
+			   summary->acked_serial, ack_serial,
+			   ktime_add_us(tq->xmit_ts_base, tq->segment_xmit_ts[ix]),
+			   call->acks_latest_ts);
+	summary->rtt_sample_avail = false;
+	__clear_bit(ix, &tq->rtt_samples); /* Prevent repeat RTT sample */
+}
+
 /*
  * Apply a hard ACK by advancing the Tx window.
  */
 static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
-				   struct rxrpc_ack_summary *summary)
+				   struct rxrpc_ack_summary *summary,
+				   rxrpc_serial_t ack_serial)
 {
 	struct rxrpc_txqueue *tq = call->tx_queue;
 	rxrpc_seq_t seq = call->tx_bottom + 1;
@@ -236,6 +252,11 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 			rot_last = true;
 		}
 
+		if (summary->rtt_sample_avail &&
+		    summary->acked_serial == tq->segment_serial[ix] &&
+		    test_bit(ix, &tq->rtt_samples))
+			rxrpc_add_data_rtt_sample(call, summary, tq, ix, ack_serial);
+
 		if (ix == tq->nr_reported_acks) {
 			/* Packet directly hard ACK'd. */
 			tq->nr_reported_acks++;
@@ -348,7 +369,7 @@ static bool rxrpc_receiving_reply(struct rxrpc_call *call)
 	}
 
 	if (!test_bit(RXRPC_CALL_TX_LAST, &call->flags)) {
-		if (!rxrpc_rotate_tx_window(call, top, &summary)) {
+		if (!rxrpc_rotate_tx_window(call, top, &summary, 0)) {
 			rxrpc_proto_abort(call, top, rxrpc_eproto_early_reply);
 			return false;
 		}
@@ -800,6 +821,19 @@ static void rxrpc_input_ack_trailer(struct rxrpc_call *call, struct sk_buff *skb
 		})
 #endif
 
+/*
+ * Deal with RTT samples from soft ACKs.
+ */
+static void rxrpc_input_soft_rtt(struct rxrpc_call *call,
+				 struct rxrpc_ack_summary *summary,
+				 struct rxrpc_txqueue *tq,
+				 rxrpc_serial_t ack_serial)
+{
+	for (int ix = 0; ix < RXRPC_NR_TXQUEUE; ix++)
+		if (summary->acked_serial == tq->segment_serial[ix])
+			return rxrpc_add_data_rtt_sample(call, summary, tq, ix, ack_serial);
+}
+
 /*
  * Process a batch of soft ACKs specific to a transmission queue segment.
  */
@@ -909,6 +943,8 @@ static void rxrpc_input_soft_acks(struct rxrpc_call *call,
 
 		_debug("bound %16lx %u", extracted, nr);
 
+		if (summary->rtt_sample_avail)
+			rxrpc_input_soft_rtt(call, summary, tq, sp->hdr.serial);
 		rxrpc_input_soft_ack_tq(call, summary, tq, extracted, RXRPC_NR_TXQUEUE,
 					seq - RXRPC_NR_TXQUEUE, &lowest_nak);
 		extracted = ~0UL;
@@ -980,7 +1016,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	struct rxrpc_ack_summary summary = { 0 };
 	struct rxrpc_acktrailer trailer;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
-	rxrpc_serial_t ack_serial, acked_serial;
+	rxrpc_serial_t ack_serial;
 	rxrpc_seq_t first_soft_ack, hard_ack, prev_pkt;
 	int nr_acks, offset, ioffset;
 
@@ -989,11 +1025,11 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	offset = sizeof(struct rxrpc_wire_header) + sizeof(struct rxrpc_ackpacket);
 
 	ack_serial	= sp->hdr.serial;
-	acked_serial	= sp->ack.acked_serial;
 	first_soft_ack	= sp->ack.first_ack;
 	prev_pkt	= sp->ack.prev_ack;
 	nr_acks		= sp->ack.nr_acks;
 	hard_ack	= first_soft_ack - 1;
+	summary.acked_serial = sp->ack.acked_serial;
 	summary.ack_reason = (sp->ack.reason < RXRPC_ACK__INVALID ?
 			      sp->ack.reason : RXRPC_ACK__INVALID);
 
@@ -1001,21 +1037,12 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	rxrpc_inc_stat(call->rxnet, stat_rx_acks[summary.ack_reason]);
 	prefetch(call->tx_queue);
 
-	if (acked_serial != 0) {
-		switch (summary.ack_reason) {
-		case RXRPC_ACK_PING_RESPONSE:
-			rxrpc_complete_rtt_probe(call, skb->tstamp, acked_serial, ack_serial,
-						 rxrpc_rtt_rx_ping_response);
-			break;
-		case RXRPC_ACK_REQUESTED:
-			rxrpc_complete_rtt_probe(call, skb->tstamp, acked_serial, ack_serial,
-						 rxrpc_rtt_rx_requested_ack);
-			break;
-		default:
-			rxrpc_complete_rtt_probe(call, skb->tstamp, acked_serial, ack_serial,
-						 rxrpc_rtt_rx_other_ack);
-			break;
-		}
+	if (summary.acked_serial != 0) {
+		if (summary.ack_reason == RXRPC_ACK_PING_RESPONSE)
+			rxrpc_complete_rtt_probe(call, skb->tstamp, summary.acked_serial,
+						 ack_serial, rxrpc_rtt_rx_ping_response);
+		else
+			summary.rtt_sample_avail = true;
 	}
 
 	/* If we get an EXCEEDS_WINDOW ACK from the server, it probably
@@ -1068,8 +1095,9 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	case RXRPC_ACK_PING:
 		break;
 	default:
-		if (acked_serial && after(acked_serial, call->acks_highest_serial))
-			call->acks_highest_serial = acked_serial;
+		if (summary.acked_serial &&
+		    after(summary.acked_serial, call->acks_highest_serial))
+			call->acks_highest_serial = summary.acked_serial;
 		break;
 	}
 
@@ -1098,7 +1126,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 		return rxrpc_proto_abort(call, 0, rxrpc_eproto_ackr_sack_overflow);
 
 	if (after(hard_ack, call->tx_bottom)) {
-		if (rxrpc_rotate_tx_window(call, hard_ack, &summary)) {
+		if (rxrpc_rotate_tx_window(call, hard_ack, &summary, ack_serial)) {
 			rxrpc_end_tx_phase(call, false, rxrpc_eproto_unexpected_ack);
 			goto send_response;
 		}
@@ -1116,7 +1144,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 		rxrpc_propose_ping(call, ack_serial,
 				   rxrpc_propose_ack_ping_for_lost_reply);
 
-	rxrpc_congestion_management(call, skb, &summary, acked_serial);
+	rxrpc_congestion_management(call, &summary);
 	if (summary.need_retransmit)
 		rxrpc_resend(call, ack_serial, summary.ack_reason == RXRPC_ACK_PING_RESPONSE);
 
@@ -1136,7 +1164,7 @@ static void rxrpc_input_ackall(struct rxrpc_call *call, struct sk_buff *skb)
 {
 	struct rxrpc_ack_summary summary = { 0 };
 
-	if (rxrpc_rotate_tx_window(call, call->tx_top, &summary))
+	if (rxrpc_rotate_tx_window(call, call->tx_top, &summary, 0))
 		rxrpc_end_tx_phase(call, false, rxrpc_eproto_unexpected_ackall);
 }
 
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 5387bf9b0015..50798a641e37 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -435,7 +435,7 @@ static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call,
 	trace_rxrpc_req_ack(call->debug_id, txb->seq, why);
 	if (why != rxrpc_reqack_no_srv_last) {
 		flags |= RXRPC_REQUEST_ACK;
-		rxrpc_begin_rtt_probe(call, serial, req->now, rxrpc_rtt_tx_data);
+		trace_rxrpc_rtt_tx(call, rxrpc_rtt_tx_data, -1, serial);
 		call->peer->rtt_last_req = req->now;
 	}
 dont_set_request_ack:
@@ -507,6 +507,10 @@ static size_t rxrpc_prepare_data_packet(struct rxrpc_call *call, struct rxrpc_se
 
 		_debug("prep[%u] tq=%x q=%x", i, tq->qbase, seq);
 		tq->segment_xmit_ts[ix] = xmit_ts;
+		tq->segment_serial[ix] = serial;
+		if (i + 1 == req->n)
+			/* Only sample the last subpacket in a jumbo. */
+			__set_bit(ix, &tq->rtt_samples);
 		len += rxrpc_prepare_data_subpacket(call, req, txb, serial, i);
 		serial++;
 		seq++;


