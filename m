Return-Path: <netdev+bounces-148868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0228A9E34FB
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 09:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22DB1B2EF20
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 07:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388C31B4F17;
	Wed,  4 Dec 2024 07:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NN5qWC1t"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB351B4F15
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 07:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298538; cv=none; b=QCZcNEulPTgJk+Sj3016LPYxtOxuleC/x4R968BhGHZPg9t4VGgCiA6S3CR2IPhVyOaOxMV43579zzwLgedLpoKllGm4bh9pQUboc2uIRYND7tebMIXbgBvqDrt9zhbL6+LclxdHS2LxDEV7GVw2cIIQkXkW8VfXl+Dlg1VK81Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298538; c=relaxed/simple;
	bh=FtBrczHaMc/+Xmt21XTkz8bRF4EgyLsJeB8rLGFY09o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipJ/ScGK3qFjQzVvsPXJCE6yZAkQpecL5Ah2094La/9Egv6hSHHy9BvccGmRcFC/dcO4O0CbJODC7vY+3KGCW8T53TyT8h56zA51x7cjOljT2ANPF1o8gt5Np/KE0l1iQLZzLQn/vXWWa/BKEmLTxXqAFzPN4jrG7T6lxBzSFg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NN5qWC1t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733298534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCZ9DduAzK5mqGHBqk31bfec/XJncLntfqLDlK4Wvig=;
	b=NN5qWC1tk/xzfAaeMgwOiv+JWwHtbIdv/hHZQ3oW+gSbwReU/ad245zAobjkz86FWo/8AY
	APXbnEcapxg6C+Bn7TFTl5+tSr7c3MRXSDI/aTIUaZndhER/CoIuMhTrcVqjEAOgw+uUa2
	yda6W4jKdRFTRpcYAIPiJBy9uDtOQYk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-FzbW-mTAN3mjxA1Z1oTOrw-1; Wed,
 04 Dec 2024 02:48:50 -0500
X-MC-Unique: FzbW-mTAN3mjxA1Z1oTOrw-1
X-Mimecast-MFC-AGG-ID: FzbW-mTAN3mjxA1Z1oTOrw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2EDFD1956060;
	Wed,  4 Dec 2024 07:48:49 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A15C41956054;
	Wed,  4 Dec 2024 07:48:46 +0000 (UTC)
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
Subject: [PATCH net-next v2 22/39] rxrpc: Adjust names and types of congestion-related fields
Date: Wed,  4 Dec 2024 07:46:50 +0000
Message-ID: <20241204074710.990092-23-dhowells@redhat.com>
In-Reply-To: <20241204074710.990092-1-dhowells@redhat.com>
References: <20241204074710.990092-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Adjust some of the names of fields and constants to make them look a bit
more like the TCP congestion symbol names, such as flight_size -> in_flight
and congest_mode to ca_state.

Move the persistent congestion-related fields from the rxrpc_ack_summary
struct into the rxrpc_call struct rather than copying them out and back in
again.  The rxrpc_congest tracepoint can fetch them from the call struct.

Rename the counters for soft acks and nacks to have an 's' on the front to
reflect the softness, e.g. nr_acks -> nr_sacks.

Make fields counting numbers of packets or numbers of acks u16 rather than
u8 to allow for windows of up to 8192 DATA packets in flight in future.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h |  58 ++++++++------
 net/rxrpc/ar-internal.h      |  51 ++++++------
 net/rxrpc/conn_client.c      |   4 +-
 net/rxrpc/input.c            | 151 ++++++++++++++++-------------------
 net/rxrpc/output.c           |   2 +-
 5 files changed, 132 insertions(+), 134 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 91108e0de3af..d47b8235fad3 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -378,11 +378,11 @@
 	EM(rxrpc_propose_ack_rx_idle,		"RxIdle ") \
 	E_(rxrpc_propose_ack_terminal_ack,	"ClTerm ")
 
-#define rxrpc_congest_modes \
-	EM(RXRPC_CALL_CONGEST_AVOIDANCE,	"CongAvoid") \
-	EM(RXRPC_CALL_FAST_RETRANSMIT,		"FastReTx ") \
-	EM(RXRPC_CALL_PACKET_LOSS,		"PktLoss  ") \
-	E_(RXRPC_CALL_SLOW_START,		"SlowStart")
+#define rxrpc_ca_states \
+	EM(RXRPC_CA_CONGEST_AVOIDANCE,		"CongAvoid") \
+	EM(RXRPC_CA_FAST_RETRANSMIT,		"FastReTx ") \
+	EM(RXRPC_CA_PACKET_LOSS,		"PktLoss  ") \
+	E_(RXRPC_CA_SLOW_START,			"SlowStart")
 
 #define rxrpc_congest_changes \
 	EM(rxrpc_cong_begin_retransmission,	" Retrans") \
@@ -550,11 +550,11 @@ enum rxrpc_txqueue_trace	{ rxrpc_txqueue_traces } __mode(byte);
 
 rxrpc_abort_reasons;
 rxrpc_bundle_traces;
+rxrpc_ca_states;
 rxrpc_call_poke_traces;
 rxrpc_call_traces;
 rxrpc_client_traces;
 rxrpc_congest_changes;
-rxrpc_congest_modes;
 rxrpc_conn_traces;
 rxrpc_local_traces;
 rxrpc_pmtud_reduce_traces;
@@ -1688,27 +1688,39 @@ TRACE_EVENT(rxrpc_retransmit,
 
 TRACE_EVENT(rxrpc_congest,
 	    TP_PROTO(struct rxrpc_call *call, struct rxrpc_ack_summary *summary,
-		     rxrpc_serial_t ack_serial, enum rxrpc_congest_change change),
+		     rxrpc_serial_t ack_serial),
 
-	    TP_ARGS(call, summary, ack_serial, change),
+	    TP_ARGS(call, summary, ack_serial),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,			call)
-		    __field(enum rxrpc_congest_change,		change)
+		    __field(enum rxrpc_ca_state,		ca_state)
 		    __field(rxrpc_seq_t,			hard_ack)
 		    __field(rxrpc_seq_t,			top)
 		    __field(rxrpc_seq_t,			lowest_nak)
 		    __field(rxrpc_serial_t,			ack_serial)
+		    __field(u16,				nr_sacks)
+		    __field(u16,				nr_snacks)
+		    __field(u16,				cwnd)
+		    __field(u16,				ssthresh)
+		    __field(u16,				cumul_acks)
+		    __field(u16,				dup_acks)
 		    __field_struct(struct rxrpc_ack_summary,	sum)
 			     ),
 
 	    TP_fast_assign(
 		    __entry->call	= call->debug_id;
-		    __entry->change	= change;
+		    __entry->ca_state	= call->cong_ca_state;
 		    __entry->hard_ack	= call->acks_hard_ack;
 		    __entry->top	= call->tx_top;
 		    __entry->lowest_nak	= call->acks_lowest_nak;
 		    __entry->ack_serial	= ack_serial;
+		    __entry->nr_sacks	= call->acks_nr_sacks;
+		    __entry->nr_snacks	= call->acks_nr_snacks;
+		    __entry->cwnd	= call->cong_cwnd;
+		    __entry->ssthresh	= call->cong_ssthresh;
+		    __entry->cumul_acks	= call->cong_cumul_acks;
+		    __entry->dup_acks	= call->cong_dup_acks;
 		    memcpy(&__entry->sum, summary, sizeof(__entry->sum));
 			   ),
 
@@ -1717,17 +1729,17 @@ TRACE_EVENT(rxrpc_congest,
 		      __entry->ack_serial,
 		      __print_symbolic(__entry->sum.ack_reason, rxrpc_ack_names),
 		      __entry->hard_ack,
-		      __print_symbolic(__entry->sum.mode, rxrpc_congest_modes),
-		      __entry->sum.cwnd,
-		      __entry->sum.ssthresh,
-		      __entry->sum.nr_acks, __entry->sum.nr_retained_nacks,
-		      __entry->sum.nr_new_acks,
-		      __entry->sum.nr_new_nacks,
+		      __print_symbolic(__entry->ca_state, rxrpc_ca_states),
+		      __entry->cwnd,
+		      __entry->ssthresh,
+		      __entry->nr_sacks, __entry->sum.nr_retained_snacks,
+		      __entry->sum.nr_new_sacks,
+		      __entry->sum.nr_new_snacks,
 		      __entry->top - __entry->hard_ack,
-		      __entry->sum.cumulative_acks,
-		      __entry->sum.dup_acks,
-		      __entry->lowest_nak, __entry->sum.new_low_nack ? "!" : "",
-		      __print_symbolic(__entry->change, rxrpc_congest_changes),
+		      __entry->cumul_acks,
+		      __entry->dup_acks,
+		      __entry->lowest_nak, __entry->sum.new_low_snack ? "!" : "",
+		      __print_symbolic(__entry->sum.change, rxrpc_congest_changes),
 		      __entry->sum.retrans_timeo ? " rTxTo" : "")
 	    );
 
@@ -1738,7 +1750,7 @@ TRACE_EVENT(rxrpc_reset_cwnd,
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		call)
-		    __field(enum rxrpc_congest_mode,	mode)
+		    __field(enum rxrpc_ca_state,	ca_state)
 		    __field(unsigned short,		cwnd)
 		    __field(unsigned short,		extra)
 		    __field(rxrpc_seq_t,		hard_ack)
@@ -1749,7 +1761,7 @@ TRACE_EVENT(rxrpc_reset_cwnd,
 
 	    TP_fast_assign(
 		    __entry->call	= call->debug_id;
-		    __entry->mode	= call->cong_mode;
+		    __entry->ca_state	= call->cong_ca_state;
 		    __entry->cwnd	= call->cong_cwnd;
 		    __entry->extra	= call->cong_extra;
 		    __entry->hard_ack	= call->acks_hard_ack;
@@ -1761,7 +1773,7 @@ TRACE_EVENT(rxrpc_reset_cwnd,
 	    TP_printk("c=%08x q=%08x %s cw=%u+%u pr=%u tm=%llu d=%u",
 		      __entry->call,
 		      __entry->hard_ack,
-		      __print_symbolic(__entry->mode, rxrpc_congest_modes),
+		      __print_symbolic(__entry->ca_state, rxrpc_ca_states),
 		      __entry->cwnd,
 		      __entry->extra,
 		      __entry->prepared,
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 840293f913a3..f6e6b2ab6c2a 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -623,13 +623,13 @@ enum rxrpc_call_state {
 /*
  * Call Tx congestion management modes.
  */
-enum rxrpc_congest_mode {
-	RXRPC_CALL_SLOW_START,
-	RXRPC_CALL_CONGEST_AVOIDANCE,
-	RXRPC_CALL_PACKET_LOSS,
-	RXRPC_CALL_FAST_RETRANSMIT,
-	NR__RXRPC_CONGEST_MODES
-};
+enum rxrpc_ca_state {
+	RXRPC_CA_SLOW_START,
+	RXRPC_CA_CONGEST_AVOIDANCE,
+	RXRPC_CA_PACKET_LOSS,
+	RXRPC_CA_FAST_RETRANSMIT,
+	NR__RXRPC_CA_STATES
+} __mode(byte);
 
 /*
  * RxRPC call definition
@@ -727,12 +727,12 @@ struct rxrpc_call {
 	 */
 #define RXRPC_TX_SMSS		RXRPC_JUMBO_DATALEN
 #define RXRPC_MIN_CWND		4
-	u8			cong_cwnd;	/* Congestion window size */
+	enum rxrpc_ca_state	cong_ca_state;	/* Congestion control state */
 	u8			cong_extra;	/* Extra to send for congestion management */
-	u8			cong_ssthresh;	/* Slow-start threshold */
-	enum rxrpc_congest_mode	cong_mode:8;	/* Congestion management mode */
-	u8			cong_dup_acks;	/* Count of ACKs showing missing packets */
-	u8			cong_cumul_acks; /* Cumulative ACK count */
+	u16			cong_cwnd;	/* Congestion window size */
+	u16			cong_ssthresh;	/* Slow-start threshold */
+	u16			cong_dup_acks;	/* Count of ACKs showing missing packets */
+	u16			cong_cumul_acks; /* Cumulative ACK count */
 	ktime_t			cong_tstamp;	/* Last time cwnd was changed */
 	struct sk_buff		*cong_last_nack; /* Last ACK with nacks received */
 
@@ -763,27 +763,24 @@ struct rxrpc_call {
 	rxrpc_seq_t		acks_prev_seq;	/* Highest previousPacket received */
 	rxrpc_seq_t		acks_lowest_nak; /* Lowest NACK in the buffer (or ==tx_hard_ack) */
 	rxrpc_serial_t		acks_highest_serial; /* Highest serial number ACK'd */
+	unsigned short		acks_nr_sacks;	/* Number of soft acks recorded */
+	unsigned short		acks_nr_snacks;	/* Number of soft nacks recorded */
 };
 
 /*
  * Summary of a new ACK and the changes it made to the Tx buffer packet states.
  */
 struct rxrpc_ack_summary {
-	u16			nr_acks;		/* Number of ACKs in packet */
-	u16			nr_new_acks;		/* Number of new ACKs in packet */
-	u16			nr_new_nacks;		/* Number of new nacks in packet */
-	u16			nr_retained_nacks;	/* Number of nacks retained between ACKs */
-	u8			ack_reason;
-	bool			saw_nacks;		/* Saw NACKs in packet */
-	bool			new_low_nack;		/* T if new low NACK found */
-	bool			retrans_timeo;		/* T if reTx due to timeout happened */
-	u8			flight_size;		/* Number of unreceived transmissions */
-	/* Place to stash values for tracing */
-	enum rxrpc_congest_mode	mode:8;
-	u8			cwnd;
-	u8			ssthresh;
-	u8			dup_acks;
-	u8			cumulative_acks;
+	u16		in_flight;		/* Number of unreceived transmissions */
+	u16		nr_new_hacks;		/* Number of rotated new ACKs */
+	u16		nr_new_sacks;		/* Number of new soft ACKs in packet */
+	u16		nr_new_snacks;		/* Number of new soft nacks in packet */
+	u16		nr_retained_snacks;	/* Number of nacks retained between ACKs */
+	u8		ack_reason;
+	bool		saw_snacks:1;		/* T if we saw a soft NACK */
+	bool		new_low_snack:1;	/* T if new low soft NACK found */
+	bool		retrans_timeo:1;	/* T if reTx due to timeout happened */
+	u8 /*enum rxrpc_congest_change*/ change;
 };
 
 /*
diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index 706631e6ac2f..5f76bd90567c 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -437,9 +437,9 @@ static void rxrpc_activate_one_channel(struct rxrpc_connection *conn,
 	call->dest_srx.srx_service = conn->service_id;
 	call->cong_ssthresh = call->peer->cong_ssthresh;
 	if (call->cong_cwnd >= call->cong_ssthresh)
-		call->cong_mode = RXRPC_CALL_CONGEST_AVOIDANCE;
+		call->cong_ca_state = RXRPC_CA_CONGEST_AVOIDANCE;
 	else
-		call->cong_mode = RXRPC_CALL_SLOW_START;
+		call->cong_ca_state = RXRPC_CA_SLOW_START;
 
 	chan->call_id		= call_id;
 	chan->call_debug_id	= call->debug_id;
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 8d7ab4b9d7d0..c25d816aafee 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -34,49 +34,41 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 					struct rxrpc_ack_summary *summary,
 					rxrpc_serial_t acked_serial)
 {
-	enum rxrpc_congest_change change = rxrpc_cong_no_change;
-	unsigned int cumulative_acks = call->cong_cumul_acks;
-	unsigned int cwnd = call->cong_cwnd;
 	bool resend = false;
 
-	summary->flight_size =
-		(call->tx_top - call->tx_bottom) - summary->nr_acks;
+	summary->change = rxrpc_cong_no_change;
+	summary->in_flight = (call->tx_top - call->tx_bottom) - call->acks_nr_sacks;
 
 	if (test_and_clear_bit(RXRPC_CALL_RETRANS_TIMEOUT, &call->flags)) {
 		summary->retrans_timeo = true;
-		call->cong_ssthresh = umax(summary->flight_size / 2, 2);
-		cwnd = 1;
-		if (cwnd >= call->cong_ssthresh &&
-		    call->cong_mode == RXRPC_CALL_SLOW_START) {
-			call->cong_mode = RXRPC_CALL_CONGEST_AVOIDANCE;
+		call->cong_ssthresh = umax(summary->in_flight / 2, 2);
+		call->cong_cwnd = 1;
+		if (call->cong_cwnd >= call->cong_ssthresh &&
+		    call->cong_ca_state == RXRPC_CA_SLOW_START) {
+			call->cong_ca_state = RXRPC_CA_CONGEST_AVOIDANCE;
 			call->cong_tstamp = skb->tstamp;
-			cumulative_acks = 0;
+			call->cong_cumul_acks = 0;
 		}
 	}
 
-	cumulative_acks += summary->nr_new_acks;
-	if (cumulative_acks > 255)
-		cumulative_acks = 255;
+	call->cong_cumul_acks += summary->nr_new_sacks;
+	if (call->cong_cumul_acks > 255)
+		call->cong_cumul_acks = 255;
 
-	summary->cwnd = call->cong_cwnd;
-	summary->ssthresh = call->cong_ssthresh;
-	summary->cumulative_acks = cumulative_acks;
-	summary->dup_acks = call->cong_dup_acks;
-
-	switch (call->cong_mode) {
-	case RXRPC_CALL_SLOW_START:
-		if (summary->saw_nacks)
+	switch (call->cong_ca_state) {
+	case RXRPC_CA_SLOW_START:
+		if (summary->saw_snacks)
 			goto packet_loss_detected;
-		if (summary->cumulative_acks > 0)
-			cwnd += 1;
-		if (cwnd >= call->cong_ssthresh) {
-			call->cong_mode = RXRPC_CALL_CONGEST_AVOIDANCE;
+		if (call->cong_cumul_acks > 0)
+			call->cong_cwnd += 1;
+		if (call->cong_cwnd >= call->cong_ssthresh) {
+			call->cong_ca_state = RXRPC_CA_CONGEST_AVOIDANCE;
 			call->cong_tstamp = skb->tstamp;
 		}
 		goto out;
 
-	case RXRPC_CALL_CONGEST_AVOIDANCE:
-		if (summary->saw_nacks)
+	case RXRPC_CA_CONGEST_AVOIDANCE:
+		if (summary->saw_snacks)
 			goto packet_loss_detected;
 
 		/* We analyse the number of packets that get ACK'd per RTT
@@ -88,18 +80,18 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 				 ktime_add_us(call->cong_tstamp,
 					      call->peer->srtt_us >> 3)))
 			goto out_no_clear_ca;
-		change = rxrpc_cong_rtt_window_end;
+		summary->change = rxrpc_cong_rtt_window_end;
 		call->cong_tstamp = skb->tstamp;
-		if (cumulative_acks >= cwnd)
-			cwnd++;
+		if (call->cong_cumul_acks >= call->cong_cwnd)
+			call->cong_cwnd++;
 		goto out;
 
-	case RXRPC_CALL_PACKET_LOSS:
-		if (!summary->saw_nacks)
+	case RXRPC_CA_PACKET_LOSS:
+		if (!summary->saw_snacks)
 			goto resume_normality;
 
-		if (summary->new_low_nack) {
-			change = rxrpc_cong_new_low_nack;
+		if (summary->new_low_snack) {
+			summary->change = rxrpc_cong_new_low_nack;
 			call->cong_dup_acks = 1;
 			if (call->cong_extra > 1)
 				call->cong_extra = 1;
@@ -110,29 +102,29 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 		if (call->cong_dup_acks < 3)
 			goto send_extra_data;
 
-		change = rxrpc_cong_begin_retransmission;
-		call->cong_mode = RXRPC_CALL_FAST_RETRANSMIT;
-		call->cong_ssthresh = umax(summary->flight_size / 2, 2);
-		cwnd = call->cong_ssthresh + 3;
+		summary->change = rxrpc_cong_begin_retransmission;
+		call->cong_ca_state = RXRPC_CA_FAST_RETRANSMIT;
+		call->cong_ssthresh = umax(summary->in_flight / 2, 2);
+		call->cong_cwnd = call->cong_ssthresh + 3;
 		call->cong_extra = 0;
 		call->cong_dup_acks = 0;
 		resend = true;
 		goto out;
 
-	case RXRPC_CALL_FAST_RETRANSMIT:
-		if (!summary->new_low_nack) {
-			if (summary->nr_new_acks == 0)
-				cwnd += 1;
+	case RXRPC_CA_FAST_RETRANSMIT:
+		if (!summary->new_low_snack) {
+			if (summary->nr_new_sacks == 0)
+				call->cong_cwnd += 1;
 			call->cong_dup_acks++;
 			if (call->cong_dup_acks == 2) {
-				change = rxrpc_cong_retransmit_again;
+				summary->change = rxrpc_cong_retransmit_again;
 				call->cong_dup_acks = 0;
 				resend = true;
 			}
 		} else {
-			change = rxrpc_cong_progress;
-			cwnd = call->cong_ssthresh;
-			if (!summary->saw_nacks)
+			summary->change = rxrpc_cong_progress;
+			call->cong_cwnd = call->cong_ssthresh;
+			if (!summary->saw_snacks)
 				goto resume_normality;
 		}
 		goto out;
@@ -143,30 +135,27 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 	}
 
 resume_normality:
-	change = rxrpc_cong_cleared_nacks;
+	summary->change = rxrpc_cong_cleared_nacks;
 	call->cong_dup_acks = 0;
 	call->cong_extra = 0;
 	call->cong_tstamp = skb->tstamp;
-	if (cwnd < call->cong_ssthresh)
-		call->cong_mode = RXRPC_CALL_SLOW_START;
+	if (call->cong_cwnd < call->cong_ssthresh)
+		call->cong_ca_state = RXRPC_CA_SLOW_START;
 	else
-		call->cong_mode = RXRPC_CALL_CONGEST_AVOIDANCE;
+		call->cong_ca_state = RXRPC_CA_CONGEST_AVOIDANCE;
 out:
-	cumulative_acks = 0;
+	call->cong_cumul_acks = 0;
 out_no_clear_ca:
-	if (cwnd >= RXRPC_TX_MAX_WINDOW)
-		cwnd = RXRPC_TX_MAX_WINDOW;
-	call->cong_cwnd = cwnd;
-	call->cong_cumul_acks = cumulative_acks;
-	summary->mode = call->cong_mode;
-	trace_rxrpc_congest(call, summary, acked_serial, change);
+	if (call->cong_cwnd >= RXRPC_TX_MAX_WINDOW)
+		call->cong_cwnd = RXRPC_TX_MAX_WINDOW;
+	trace_rxrpc_congest(call, summary, acked_serial);
 	if (resend)
 		rxrpc_resend(call, skb);
 	return;
 
 packet_loss_detected:
-	change = rxrpc_cong_saw_nack;
-	call->cong_mode = RXRPC_CALL_PACKET_LOSS;
+	summary->change = rxrpc_cong_saw_nack;
+	call->cong_ca_state = RXRPC_CA_PACKET_LOSS;
 	call->cong_dup_acks = 0;
 	goto send_extra_data;
 
@@ -175,7 +164,7 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 	 * state.
 	 */
 	if (test_bit(RXRPC_CALL_TX_LAST, &call->flags) ||
-	    summary->nr_acks != call->tx_top - call->tx_bottom) {
+	    call->acks_nr_sacks != call->tx_top - call->tx_bottom) {
 		call->cong_extra++;
 		wake_up(&call->waitq);
 	}
@@ -189,8 +178,8 @@ void rxrpc_congestion_degrade(struct rxrpc_call *call)
 {
 	ktime_t rtt, now;
 
-	if (call->cong_mode != RXRPC_CALL_SLOW_START &&
-	    call->cong_mode != RXRPC_CALL_CONGEST_AVOIDANCE)
+	if (call->cong_ca_state != RXRPC_CA_SLOW_START &&
+	    call->cong_ca_state != RXRPC_CA_CONGEST_AVOIDANCE)
 		return;
 	if (__rxrpc_call_state(call) == RXRPC_CALL_CLIENT_AWAIT_REPLY)
 		return;
@@ -203,7 +192,7 @@ void rxrpc_congestion_degrade(struct rxrpc_call *call)
 	trace_rxrpc_reset_cwnd(call, now);
 	rxrpc_inc_stat(call->rxnet, stat_tx_data_cwnd_reset);
 	call->tx_last_sent = now;
-	call->cong_mode = RXRPC_CALL_SLOW_START;
+	call->cong_ca_state = RXRPC_CA_SLOW_START;
 	call->cong_ssthresh = umax(call->cong_ssthresh, call->cong_cwnd * 3 / 4);
 	call->cong_cwnd = umax(call->cong_cwnd / 2, RXRPC_MIN_CWND);
 }
@@ -282,7 +271,7 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 	if (call->acks_lowest_nak == call->tx_bottom) {
 		call->acks_lowest_nak = to;
 	} else if (after(to, call->acks_lowest_nak)) {
-		summary->new_low_nack = true;
+		summary->new_low_snack = true;
 		call->acks_lowest_nak = to;
 	}
 
@@ -795,11 +784,11 @@ static rxrpc_seq_t rxrpc_input_check_prev_ack(struct rxrpc_call *call,
 	u8 *acks = skb->data + sizeof(struct rxrpc_wire_header) + sizeof(struct rxrpc_ackpacket);
 
 	if (after_eq(seq, old_seq + sp->ack.nr_acks)) {
-		summary->nr_new_acks += sp->ack.nr_nacks;
-		summary->nr_new_acks += seq - (old_seq + sp->ack.nr_acks);
-		summary->nr_retained_nacks = 0;
+		summary->nr_new_sacks += sp->ack.nr_nacks;
+		summary->nr_new_sacks += seq - (old_seq + sp->ack.nr_acks);
+		summary->nr_retained_snacks = 0;
 	} else if (seq == old_seq) {
-		summary->nr_retained_nacks = sp->ack.nr_nacks;
+		summary->nr_retained_snacks = sp->ack.nr_nacks;
 	} else {
 		for (i = 0; i < sp->ack.nr_acks; i++) {
 			if (acks[i] == RXRPC_ACK_TYPE_NACK) {
@@ -810,8 +799,8 @@ static rxrpc_seq_t rxrpc_input_check_prev_ack(struct rxrpc_call *call,
 			}
 		}
 
-		summary->nr_new_acks += new_acks;
-		summary->nr_retained_nacks = retained_nacks;
+		summary->nr_new_sacks += new_acks;
+		summary->nr_retained_snacks = retained_nacks;
 	}
 
 	return old_seq + sp->ack.nr_acks - 1;
@@ -840,16 +829,16 @@ static void rxrpc_input_soft_acks(struct rxrpc_call *call,
 	for (i = 0; i < sp->ack.nr_acks; i++) {
 		seq++;
 		if (acks[i] == RXRPC_ACK_TYPE_ACK) {
-			summary->nr_acks++;
+			call->acks_nr_sacks++;
 			if (after(seq, since))
-				summary->nr_new_acks++;
+				summary->nr_new_sacks++;
 		} else {
-			summary->saw_nacks = true;
+			summary->saw_snacks = true;
 			if (before_eq(seq, since)) {
 				/* Overlap with previous ACK */
 				old_nacks++;
 			} else {
-				summary->nr_new_nacks++;
+				summary->nr_new_snacks++;
 				sp->ack.nr_nacks++;
 			}
 
@@ -860,7 +849,7 @@ static void rxrpc_input_soft_acks(struct rxrpc_call *call,
 
 	if (lowest_nak != call->acks_lowest_nak) {
 		call->acks_lowest_nak = lowest_nak;
-		summary->new_low_nack = true;
+		summary->new_low_snack = true;
 	}
 
 	/* We *can* have more nacks than we did - the peer is permitted to drop
@@ -868,9 +857,9 @@ static void rxrpc_input_soft_acks(struct rxrpc_call *call,
 	 * possible for the nack distribution to change whilst the number of
 	 * nacks stays the same or goes down.
 	 */
-	if (old_nacks < summary->nr_retained_nacks)
-		summary->nr_new_acks += summary->nr_retained_nacks - old_nacks;
-	summary->nr_retained_nacks = old_nacks;
+	if (old_nacks < summary->nr_retained_snacks)
+		summary->nr_new_sacks += summary->nr_retained_snacks - old_nacks;
+	summary->nr_retained_snacks = old_nacks;
 }
 
 /*
@@ -996,7 +985,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 		rxrpc_free_skb(call->cong_last_nack, rxrpc_skb_put_last_nack);
 		call->cong_last_nack = NULL;
 	} else {
-		summary.nr_new_acks = hard_ack - call->acks_hard_ack;
+		summary.nr_new_sacks = hard_ack - call->acks_hard_ack;
 		call->acks_lowest_nak = hard_ack + nr_acks;
 		since = hard_ack;
 	}
@@ -1054,7 +1043,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	}
 
 	if (test_bit(RXRPC_CALL_TX_LAST, &call->flags) &&
-	    summary.nr_acks == call->tx_top - hard_ack &&
+	    call->acks_nr_sacks == call->tx_top - hard_ack &&
 	    rxrpc_is_client_call(call))
 		rxrpc_propose_ping(call, ack_serial,
 				   rxrpc_propose_ack_ping_for_lost_reply);
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 3886777d1bb6..7ed928b6f0e1 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -419,7 +419,7 @@ static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call,
 		why = rxrpc_reqack_ack_lost;
 	else if (txb->flags & RXRPC_TXBUF_RESENT)
 		why = rxrpc_reqack_retrans;
-	else if (call->cong_mode == RXRPC_CALL_SLOW_START && call->cong_cwnd <= 2)
+	else if (call->cong_ca_state == RXRPC_CA_SLOW_START && call->cong_cwnd <= 2)
 		why = rxrpc_reqack_slow_start;
 	else if (call->tx_winsize <= 2)
 		why = rxrpc_reqack_small_txwin;


