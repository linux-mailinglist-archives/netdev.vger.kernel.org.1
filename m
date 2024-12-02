Return-Path: <netdev+bounces-148106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6919E073D
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 16:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88A00B8414A
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C317720967A;
	Mon,  2 Dec 2024 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCytGNTe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1950D21C19E
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150026; cv=none; b=UCtZm6NbW1jwz0sA7vcVDUfoydLj9GcDpQGAG2MJ5fsE1exQ9g+iT2cS2XojoKFje2yw2m/Gi7qy7Z2roeolIf9/cbe7aKY/HJyfjrdU5zD7p/YqSRGEyiXLcbIDNAHqJlnbNKod/FyfUe8FtG6P8cJx/f2ieud+6KsSqSwpF44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150026; c=relaxed/simple;
	bh=321i159bBpYCfTtXfZq83u2dax8iJwq4+m+p3dBOOqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ci7dzTrdaeAbVRD6rNyZfqXjQQG7VQjg14cp+qwqzaL5OytA3Nh3HcoSHHkD7HztQhY2QCPYSxZ3p0iMa83BDvImn1HY0qUAkADz9zfRMRpt3LREwIL9Eywxhsrpsovk3IFBeOsLcaYxqBpyA9gvVHQbyEuweBtQ9Q7J0k559QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YCytGNTe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733150022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TtVXvtiUmyAYfysuzd4j7InC4q/BJsqrbCvxlX6Cm38=;
	b=YCytGNTeAdpUMekOUilMME6lLZO8/P/aErFSq+dprgK7gBaYoNLJnx9btxkqcRUohxnGVX
	xE/Ox+YNHEeuSfCoG4SK/KhpvjzIADxvyYN52A7X+bWPiN481/8h/z5bxy2cmGeygGJw1m
	Olek9tqJfnapuW+BcUz7sW7cAhD2REA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-9chdy83EMS-N0tOjpWOxvQ-1; Mon,
 02 Dec 2024 09:33:38 -0500
X-MC-Unique: 9chdy83EMS-N0tOjpWOxvQ-1
X-Mimecast-MFC-AGG-ID: 9chdy83EMS-N0tOjpWOxvQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC856191007C;
	Mon,  2 Dec 2024 14:33:36 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CE3411955D45;
	Mon,  2 Dec 2024 14:33:33 +0000 (UTC)
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
Subject: [PATCH net-next 37/37] rxrpc: Implement RACK/TLP to deal with transmission stalls [RFC8985]
Date: Mon,  2 Dec 2024 14:30:55 +0000
Message-ID: <20241202143057.378147-38-dhowells@redhat.com>
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

When an rxrpc call is in its transmission phase and is sending a lot of
packets, stalls occasionally occur that cause severe performance
degradation (eg. increasing the transmission time for a 256MiB payload from
0.7s to 2.5s over a 10G link).

rxrpc already implements TCP-style congestion control [RFC5681] and this
helps mitigate the effects, but occasionally we're missing a time event
that deals with a missing ACK, leading to a stall until the RTO expires.

Fix this by implementing RACK/TLP in rxrpc.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h | 342 ++++++++++++++++++++++++++--
 net/rxrpc/Makefile           |   1 +
 net/rxrpc/ar-internal.h      | 106 ++++++++-
 net/rxrpc/call_event.c       | 246 +++++++-------------
 net/rxrpc/call_object.c      |   3 +-
 net/rxrpc/input.c            | 117 ++++++----
 net/rxrpc/input_rack.c       | 422 +++++++++++++++++++++++++++++++++++
 net/rxrpc/io_thread.c        |   1 +
 net/rxrpc/output.c           |  41 +++-
 9 files changed, 1044 insertions(+), 235 deletions(-)
 create mode 100644 net/rxrpc/input_rack.c

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 71df5c48a413..2f119d18a061 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -305,7 +305,9 @@
 #define rxrpc_txdata_traces \
 	EM(rxrpc_txdata_inject_loss,		" *INJ-LOSS*") \
 	EM(rxrpc_txdata_new_data,		" ") \
-	E_(rxrpc_txdata_retransmit,		" *RETRANS*")
+	EM(rxrpc_txdata_retransmit,		" *RETRANS*") \
+	EM(rxrpc_txdata_tlp_new_data,		" *TLP-NEW*") \
+	E_(rxrpc_txdata_tlp_retransmit,		" *TLP-RETRANS*")
 
 #define rxrpc_receive_traces \
 	EM(rxrpc_receive_end,			"END") \
@@ -353,11 +355,12 @@
 	EM(rxrpc_timer_trace_hard,		"HardLimit") \
 	EM(rxrpc_timer_trace_idle,		"IdleLimit") \
 	EM(rxrpc_timer_trace_keepalive,		"KeepAlive") \
-	EM(rxrpc_timer_trace_lost_ack,		"LostAck  ") \
 	EM(rxrpc_timer_trace_ping,		"DelayPing") \
-	EM(rxrpc_timer_trace_resend,		"Resend   ") \
-	EM(rxrpc_timer_trace_resend_reset,	"ResendRst") \
-	E_(rxrpc_timer_trace_resend_tx,		"ResendTx ")
+	EM(rxrpc_timer_trace_rack_off,		"RACK-OFF ") \
+	EM(rxrpc_timer_trace_rack_zwp,		"RACK-ZWP ") \
+	EM(rxrpc_timer_trace_rack_reo,		"RACK-Reo ") \
+	EM(rxrpc_timer_trace_rack_tlp_pto,	"TLP-PTO  ") \
+	E_(rxrpc_timer_trace_rack_rto,		"RTO      ")
 
 #define rxrpc_propose_ack_traces \
 	EM(rxrpc_propose_ack_client_tx_end,	"ClTxEnd") \
@@ -478,9 +481,9 @@
 	EM(rxrpc_txbuf_put_rotated,		"PUT ROTATED")	\
 	EM(rxrpc_txbuf_put_send_aborted,	"PUT SEND-X ")	\
 	EM(rxrpc_txbuf_put_trans,		"PUT TRANS  ")	\
+	EM(rxrpc_txbuf_see_lost,		"SEE LOST   ")	\
 	EM(rxrpc_txbuf_see_out_of_step,		"OUT-OF-STEP")	\
-	EM(rxrpc_txbuf_see_send_more,		"SEE SEND+  ")	\
-	E_(rxrpc_txbuf_see_unacked,		"SEE UNACKED")
+	E_(rxrpc_txbuf_see_send_more,		"SEE SEND+  ")
 
 #define rxrpc_tq_traces \
 	EM(rxrpc_tq_alloc,			"ALLOC") \
@@ -505,6 +508,24 @@
 	EM(rxrpc_rotate_trace_sack,		"soft-ack")	\
 	E_(rxrpc_rotate_trace_snak,		"soft-nack")
 
+#define rxrpc_rack_timer_modes \
+	EM(RXRPC_CALL_RACKTIMER_OFF,		"---") \
+	EM(RXRPC_CALL_RACKTIMER_RACK_REORDER,	"REO") \
+	EM(RXRPC_CALL_RACKTIMER_TLP_PTO,	"TLP") \
+	E_(RXRPC_CALL_RACKTIMER_RTO,		"RTO")
+
+#define rxrpc_tlp_probe_traces \
+	EM(rxrpc_tlp_probe_trace_busy,		"busy")		\
+	EM(rxrpc_tlp_probe_trace_transmit_new,	"transmit-new")	\
+	E_(rxrpc_tlp_probe_trace_retransmit,	"retransmit")
+
+#define rxrpc_tlp_ack_traces \
+	EM(rxrpc_tlp_ack_trace_acked,		"acked")	\
+	EM(rxrpc_tlp_ack_trace_dup_acked,	"dup-acked")	\
+	EM(rxrpc_tlp_ack_trace_hard_beyond,	"hard-beyond")	\
+	EM(rxrpc_tlp_ack_trace_incomplete,	"incomplete")	\
+	E_(rxrpc_tlp_ack_trace_new_data,	"new-data")
+
 /*
  * Generate enums for tracing information.
  */
@@ -537,6 +558,8 @@ enum rxrpc_rtt_tx_trace		{ rxrpc_rtt_tx_traces } __mode(byte);
 enum rxrpc_sack_trace		{ rxrpc_sack_traces } __mode(byte);
 enum rxrpc_skb_trace		{ rxrpc_skb_traces } __mode(byte);
 enum rxrpc_timer_trace		{ rxrpc_timer_traces } __mode(byte);
+enum rxrpc_tlp_ack_trace	{ rxrpc_tlp_ack_traces } __mode(byte);
+enum rxrpc_tlp_probe_trace	{ rxrpc_tlp_probe_traces } __mode(byte);
 enum rxrpc_tq_trace		{ rxrpc_tq_traces } __mode(byte);
 enum rxrpc_tx_point		{ rxrpc_tx_points } __mode(byte);
 enum rxrpc_txbuf_trace		{ rxrpc_txbuf_traces } __mode(byte);
@@ -567,6 +590,7 @@ rxrpc_conn_traces;
 rxrpc_local_traces;
 rxrpc_pmtud_reduce_traces;
 rxrpc_propose_ack_traces;
+rxrpc_rack_timer_modes;
 rxrpc_receive_traces;
 rxrpc_recvmsg_traces;
 rxrpc_req_ack_traces;
@@ -576,6 +600,8 @@ rxrpc_rtt_tx_traces;
 rxrpc_sack_traces;
 rxrpc_skb_traces;
 rxrpc_timer_traces;
+rxrpc_tlp_ack_traces;
+rxrpc_tlp_probe_traces;
 rxrpc_tq_traces;
 rxrpc_tx_points;
 rxrpc_txbuf_traces;
@@ -618,6 +644,20 @@ TRACE_EVENT(rxrpc_local,
 		      __entry->usage)
 	    );
 
+TRACE_EVENT(rxrpc_iothread_rx,
+	    TP_PROTO(struct rxrpc_local *local, unsigned int nr_rx),
+	    TP_ARGS(local, nr_rx),
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	local)
+		    __field(unsigned int,	nr_rx)
+			     ),
+	    TP_fast_assign(
+		    __entry->local = local->debug_id;
+		    __entry->nr_rx = nr_rx;
+			   ),
+	    TP_printk("L=%08x nrx=%u", __entry->local, __entry->nr_rx)
+	    );
+
 TRACE_EVENT(rxrpc_peer,
 	    TP_PROTO(unsigned int peer_debug_id, int ref, enum rxrpc_peer_trace why),
 
@@ -1684,16 +1724,15 @@ TRACE_EVENT(rxrpc_drop_ack,
 TRACE_EVENT(rxrpc_retransmit,
 	    TP_PROTO(struct rxrpc_call *call,
 		     struct rxrpc_send_data_req *req,
-		     struct rxrpc_txbuf *txb, ktime_t expiry),
+		     struct rxrpc_txbuf *txb),
 
-	    TP_ARGS(call, req, txb, expiry),
+	    TP_ARGS(call, req, txb),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,	call)
 		    __field(unsigned int,	qbase)
 		    __field(rxrpc_seq_t,	seq)
 		    __field(rxrpc_serial_t,	serial)
-		    __field(ktime_t,		expiry)
 			     ),
 
 	    TP_fast_assign(
@@ -1701,15 +1740,13 @@ TRACE_EVENT(rxrpc_retransmit,
 		    __entry->qbase = req->tq->qbase;
 		    __entry->seq = req->seq;
 		    __entry->serial = txb->serial;
-		    __entry->expiry = expiry;
 			   ),
 
-	    TP_printk("c=%08x tq=%x q=%x r=%x xp=%lld",
+	    TP_printk("c=%08x tq=%x q=%x r=%x",
 		      __entry->call,
 		      __entry->qbase,
 		      __entry->seq,
-		      __entry->serial,
-		      ktime_to_us(__entry->expiry))
+		      __entry->serial)
 	    );
 
 TRACE_EVENT(rxrpc_congest,
@@ -1767,9 +1804,9 @@ TRACE_EVENT(rxrpc_congest,
 	    );
 
 TRACE_EVENT(rxrpc_reset_cwnd,
-	    TP_PROTO(struct rxrpc_call *call, ktime_t now),
+	    TP_PROTO(struct rxrpc_call *call, ktime_t since_last_tx, ktime_t rtt),
 
-	    TP_ARGS(call, now),
+	    TP_ARGS(call, since_last_tx, rtt),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		call)
@@ -1779,6 +1816,7 @@ TRACE_EVENT(rxrpc_reset_cwnd,
 		    __field(rxrpc_seq_t,		hard_ack)
 		    __field(rxrpc_seq_t,		prepared)
 		    __field(ktime_t,			since_last_tx)
+		    __field(ktime_t,			rtt)
 		    __field(bool,			has_data)
 			     ),
 
@@ -1789,18 +1827,20 @@ TRACE_EVENT(rxrpc_reset_cwnd,
 		    __entry->extra	= call->cong_extra;
 		    __entry->hard_ack	= call->acks_hard_ack;
 		    __entry->prepared	= call->send_top - call->tx_bottom;
-		    __entry->since_last_tx = ktime_sub(now, call->tx_last_sent);
+		    __entry->since_last_tx = since_last_tx;
+		    __entry->rtt	= rtt;
 		    __entry->has_data	= call->tx_bottom != call->tx_top;
 			   ),
 
-	    TP_printk("c=%08x q=%08x %s cw=%u+%u pr=%u tm=%llu d=%u",
+	    TP_printk("c=%08x q=%08x %s cw=%u+%u pr=%u tm=%llu/%llu d=%u",
 		      __entry->call,
 		      __entry->hard_ack,
 		      __print_symbolic(__entry->ca_state, rxrpc_ca_states),
 		      __entry->cwnd,
 		      __entry->extra,
 		      __entry->prepared,
-		      ktime_to_ns(__entry->since_last_tx),
+		      ktime_to_us(__entry->since_last_tx),
+		      ktime_to_us(__entry->rtt),
 		      __entry->has_data)
 	    );
 
@@ -1925,6 +1965,32 @@ TRACE_EVENT(rxrpc_resend,
 		      __entry->transmitted)
 	    );
 
+TRACE_EVENT(rxrpc_resend_lost,
+	    TP_PROTO(struct rxrpc_call *call, struct rxrpc_txqueue *tq, unsigned long lost),
+
+	    TP_ARGS(call, tq, lost),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	call)
+		    __field(rxrpc_seq_t,	qbase)
+		    __field(u8,			nr_rep)
+		    __field(unsigned long,	lost)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->call = call->debug_id;
+		    __entry->qbase = tq->qbase;
+		    __entry->nr_rep = tq->nr_reported_acks;
+		    __entry->lost = lost;
+			   ),
+
+	    TP_printk("c=%08x tq=%x lost=%016lx nr=%u",
+		      __entry->call,
+		      __entry->qbase,
+		      __entry->lost,
+		      __entry->nr_rep)
+	    );
+
 TRACE_EVENT(rxrpc_rotate,
 	    TP_PROTO(struct rxrpc_call *call, struct rxrpc_txqueue *tq,
 		     struct rxrpc_ack_summary *summary, rxrpc_seq_t seq,
@@ -2363,6 +2429,244 @@ TRACE_EVENT(rxrpc_pmtud_reduce,
 		      __entry->serial, __entry->max_data)
 	    );
 
+TRACE_EVENT(rxrpc_rack,
+	    TP_PROTO(struct rxrpc_call *call, ktime_t timo),
+
+	    TP_ARGS(call, timo),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	call)
+		    __field(rxrpc_serial_t,	ack_serial)
+		    __field(rxrpc_seq_t,	seq)
+		    __field(enum rxrpc_rack_timer_mode, mode)
+		    __field(unsigned short,	nr_sent)
+		    __field(unsigned short,	nr_lost)
+		    __field(unsigned short,	nr_resent)
+		    __field(unsigned short,	nr_sacked)
+		    __field(ktime_t,		timo)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->call	= call->debug_id;
+		    __entry->ack_serial	= call->rx_serial;
+		    __entry->seq	= call->rack_end_seq;
+		    __entry->mode	= call->rack_timer_mode;
+		    __entry->nr_sent	= call->tx_nr_sent;
+		    __entry->nr_lost	= call->tx_nr_lost;
+		    __entry->nr_resent	= call->tx_nr_resent;
+		    __entry->nr_sacked	= call->acks_nr_sacks;
+		    __entry->timo	= timo;
+			   ),
+
+	    TP_printk("c=%08x r=%08x q=%08x %s slrs=%u,%u,%u,%u t=%lld",
+		      __entry->call, __entry->ack_serial, __entry->seq,
+		      __print_symbolic(__entry->mode, rxrpc_rack_timer_modes),
+		      __entry->nr_sent, __entry->nr_lost,
+		      __entry->nr_resent, __entry->nr_sacked,
+		      ktime_to_us(__entry->timo))
+	    );
+
+TRACE_EVENT(rxrpc_rack_update,
+	    TP_PROTO(struct rxrpc_call *call, struct rxrpc_ack_summary *summary),
+
+	    TP_ARGS(call, summary),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	call)
+		    __field(rxrpc_serial_t,	ack_serial)
+		    __field(rxrpc_seq_t,	seq)
+		    __field(int,		xmit_ts)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->call	= call->debug_id;
+		    __entry->ack_serial	= call->rx_serial;
+		    __entry->seq	= call->rack_end_seq;
+		    __entry->xmit_ts	= ktime_sub(call->acks_latest_ts, call->rack_xmit_ts);
+			   ),
+
+	    TP_printk("c=%08x r=%08x q=%08x xt=%lld",
+		      __entry->call, __entry->ack_serial, __entry->seq,
+		      ktime_to_us(__entry->xmit_ts))
+	    );
+
+TRACE_EVENT(rxrpc_rack_scan_loss,
+	    TP_PROTO(struct rxrpc_call *call),
+
+	    TP_ARGS(call),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	call)
+		    __field(ktime_t,		rack_rtt)
+		    __field(ktime_t,		rack_reo_wnd)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->call		= call->debug_id;
+		    __entry->rack_rtt		= call->rack_rtt;
+		    __entry->rack_reo_wnd	= call->rack_reo_wnd;
+			   ),
+
+	    TP_printk("c=%08x rtt=%lld reow=%lld",
+		      __entry->call, ktime_to_us(__entry->rack_rtt),
+		      ktime_to_us(__entry->rack_reo_wnd))
+	    );
+
+TRACE_EVENT(rxrpc_rack_scan_loss_tq,
+	    TP_PROTO(struct rxrpc_call *call, const struct rxrpc_txqueue *tq,
+		     unsigned long nacks),
+
+	    TP_ARGS(call, tq, nacks),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	call)
+		    __field(rxrpc_seq_t,	qbase)
+		    __field(unsigned long,	nacks)
+		    __field(unsigned long,	lost)
+		    __field(unsigned long,	retrans)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->call	= call->debug_id;
+		    __entry->qbase	= tq->qbase;
+		    __entry->nacks	= nacks;
+		    __entry->lost	= tq->segment_lost;
+		    __entry->retrans	= tq->segment_retransmitted;
+			   ),
+
+	    TP_printk("c=%08x q=%08x n=%lx l=%lx r=%lx",
+		      __entry->call, __entry->qbase,
+		      __entry->nacks, __entry->lost, __entry->retrans)
+	    );
+
+TRACE_EVENT(rxrpc_rack_detect_loss,
+	    TP_PROTO(struct rxrpc_call *call, struct rxrpc_ack_summary *summary,
+		     rxrpc_seq_t seq),
+
+	    TP_ARGS(call, summary, seq),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	call)
+		    __field(rxrpc_serial_t,	ack_serial)
+		    __field(rxrpc_seq_t,	seq)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->call	= call->debug_id;
+		    __entry->ack_serial	= call->rx_serial;
+		    __entry->seq	= seq;
+			   ),
+
+	    TP_printk("c=%08x r=%08x q=%08x",
+		      __entry->call, __entry->ack_serial, __entry->seq)
+	    );
+
+TRACE_EVENT(rxrpc_rack_mark_loss_tq,
+	    TP_PROTO(struct rxrpc_call *call, const struct rxrpc_txqueue *tq),
+
+	    TP_ARGS(call, tq),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	call)
+		    __field(rxrpc_seq_t,	qbase)
+		    __field(rxrpc_seq_t,	trans)
+		    __field(unsigned long,	acked)
+		    __field(unsigned long,	lost)
+		    __field(unsigned long,	retrans)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->call	= call->debug_id;
+		    __entry->qbase	= tq->qbase;
+		    __entry->trans	= call->tx_transmitted;
+		    __entry->acked	= tq->segment_acked;
+		    __entry->lost	= tq->segment_lost;
+		    __entry->retrans	= tq->segment_retransmitted;
+			   ),
+
+	    TP_printk("c=%08x tq=%08x txq=%08x a=%lx l=%lx r=%lx",
+		      __entry->call, __entry->qbase, __entry->trans,
+		      __entry->acked, __entry->lost, __entry->retrans)
+	    );
+
+TRACE_EVENT(rxrpc_tlp_probe,
+	    TP_PROTO(struct rxrpc_call *call, enum rxrpc_tlp_probe_trace trace),
+
+	    TP_ARGS(call, trace),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		call)
+		    __field(rxrpc_serial_t,		serial)
+		    __field(rxrpc_seq_t,		seq)
+		    __field(enum rxrpc_tlp_probe_trace,	trace)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->call	= call->debug_id;
+		    __entry->serial	= call->tlp_serial;
+		    __entry->seq	= call->tlp_seq;
+		    __entry->trace	= trace;
+			   ),
+
+	    TP_printk("c=%08x r=%08x pq=%08x %s",
+		      __entry->call, __entry->serial, __entry->seq,
+		      __print_symbolic(__entry->trace, rxrpc_tlp_probe_traces))
+	    );
+
+TRACE_EVENT(rxrpc_tlp_ack,
+	    TP_PROTO(struct rxrpc_call *call, struct rxrpc_ack_summary *summary,
+		     enum rxrpc_tlp_ack_trace trace),
+
+	    TP_ARGS(call, summary, trace),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		call)
+		    __field(rxrpc_serial_t,		serial)
+		    __field(rxrpc_seq_t,		tlp_seq)
+		    __field(rxrpc_seq_t,		hard_ack)
+		    __field(enum rxrpc_tlp_ack_trace,	trace)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->call	= call->debug_id;
+		    __entry->serial	= call->tlp_serial;
+		    __entry->tlp_seq	= call->tlp_seq;
+		    __entry->hard_ack	= call->acks_hard_ack;
+		    __entry->trace	= trace;
+			   ),
+
+	    TP_printk("c=%08x r=%08x pq=%08x hq=%08x %s",
+		      __entry->call, __entry->serial,
+		      __entry->tlp_seq, __entry->hard_ack,
+		      __print_symbolic(__entry->trace, rxrpc_tlp_ack_traces))
+	    );
+
+TRACE_EVENT(rxrpc_rack_timer,
+	    TP_PROTO(struct rxrpc_call *call, ktime_t delay, bool exp),
+
+	    TP_ARGS(call, delay, exp),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		call)
+		    __field(bool,			exp)
+		    __field(enum rxrpc_rack_timer_mode,	mode)
+		    __field(ktime_t,			delay)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->call		= call->debug_id;
+		    __entry->exp		= exp;
+		    __entry->mode		= call->rack_timer_mode;
+		    __entry->delay		= delay;
+			   ),
+
+	    TP_printk("c=%08x %s %s to=%lld",
+		      __entry->call,
+		      __entry->exp ? "Exp" : "Set",
+		      __print_symbolic(__entry->mode, rxrpc_rack_timer_modes),
+		      ktime_to_us(__entry->delay))
+	    );
+
 #undef EM
 #undef E_
 
diff --git a/net/rxrpc/Makefile b/net/rxrpc/Makefile
index ac5caf5a48e1..210b75e3179e 100644
--- a/net/rxrpc/Makefile
+++ b/net/rxrpc/Makefile
@@ -16,6 +16,7 @@ rxrpc-y := \
 	conn_object.o \
 	conn_service.o \
 	input.o \
+	input_rack.o \
 	insecure.o \
 	io_thread.o \
 	key.o \
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index a48df82ef4c5..cfa063285d89 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -621,6 +621,18 @@ enum rxrpc_ca_state {
 	NR__RXRPC_CA_STATES
 } __mode(byte);
 
+/*
+ * Current purpose of call RACK timer.  According to the RACK-TLP protocol
+ * [RFC8985], the transmission timer (call->rack_timo_at) may only be used for
+ * one of these at once.
+ */
+enum rxrpc_rack_timer_mode {
+	RXRPC_CALL_RACKTIMER_OFF,		/* Timer not running */
+	RXRPC_CALL_RACKTIMER_RACK_REORDER,	/* RACK reordering timer */
+	RXRPC_CALL_RACKTIMER_TLP_PTO,		/* TLP timeout */
+	RXRPC_CALL_RACKTIMER_RTO,		/* Retransmission timeout */
+} __mode(byte);
+
 /*
  * RxRPC call definition
  * - matched by { connection, call_id }
@@ -638,8 +650,7 @@ struct rxrpc_call {
 	struct mutex		user_mutex;	/* User access mutex */
 	struct sockaddr_rxrpc	dest_srx;	/* Destination address */
 	ktime_t			delay_ack_at;	/* When DELAY ACK needs to happen */
-	ktime_t			ack_lost_at;	/* When ACK is figured as lost */
-	ktime_t			resend_at;	/* When next resend needs to happen */
+	ktime_t			rack_timo_at;	/* When ACK is figured as lost */
 	ktime_t			ping_at;	/* When next to send a ping */
 	ktime_t			keepalive_at;	/* When next to send a keepalive ping */
 	ktime_t			expect_rx_by;	/* When we expect to get a packet by */
@@ -695,8 +706,12 @@ struct rxrpc_call {
 	rxrpc_seq_t		tx_bottom;	/* First packet in buffer */
 	rxrpc_seq_t		tx_transmitted;	/* Highest packet transmitted */
 	rxrpc_seq_t		tx_top;		/* Highest Tx slot allocated. */
+	rxrpc_serial_t		tx_last_serial;	/* Serial of last DATA transmitted */
 	u16			tx_backoff;	/* Delay to insert due to Tx failure (ms) */
-	u8			tx_winsize;	/* Maximum size of Tx window */
+	u16			tx_nr_sent;	/* Number of packets sent, but unacked */
+	u16			tx_nr_lost;	/* Number of packets marked lost */
+	u16			tx_nr_resent;	/* Number of packets resent, but unacked */
+	u16			tx_winsize;	/* Maximum size of Tx window */
 #define RXRPC_TX_MAX_WINDOW	128
 	u8			tx_jumbo_max;	/* Maximum subpkts peer will accept */
 	u8			tx_jumbo_limit;	/* Maximum subpkts in a jumbo packet */
@@ -726,6 +741,25 @@ struct rxrpc_call {
 	u16			cong_cumul_acks; /* Cumulative ACK count */
 	ktime_t			cong_tstamp;	/* Last time cwnd was changed */
 
+	/* RACK-TLP [RFC8985] state. */
+	ktime_t			rack_xmit_ts;	/* Latest transmission timestamp */
+	ktime_t			rack_rtt;	/* RTT of most recently ACK'd segment */
+	ktime_t			rack_rtt_ts;	/* Timestamp of rack_rtt */
+	ktime_t			rack_reo_wnd;	/* Reordering window */
+	unsigned int		rack_reo_wnd_mult; /* Multiplier applied to rack_reo_wnd */
+	int			rack_reo_wnd_persist; /* Num loss recoveries before reset reo_wnd */
+	rxrpc_seq_t		rack_fack;	/* Highest sequence so far ACK'd */
+	rxrpc_seq_t		rack_end_seq;	/* Highest sequence seen */
+	rxrpc_seq_t		rack_dsack_round; /* DSACK opt recv'd in latest roundtrip */
+	bool			rack_dsack_round_none; /* T if dsack_round is "None" */
+	bool			rack_reordering_seen; /* T if detected reordering event */
+	enum rxrpc_rack_timer_mode rack_timer_mode; /* Current mode of RACK timer */
+	bool			tlp_is_retrans;	/* T if unacked TLP retransmission */
+	rxrpc_serial_t		tlp_serial;	/* Serial of TLP probe (or 0 if none in progress) */
+	rxrpc_seq_t		tlp_seq;	/* Sequence of TLP probe */
+	unsigned int		tlp_rtt_taken;	/* Last time RTT taken */
+	ktime_t			tlp_max_ack_delay; /* Sender budget for max delayed ACK interval */
+
 	/* Receive-phase ACK management (ACKs we send). */
 	u8			ackr_reason;	/* reason to ACK */
 	u16			ackr_sack_base;	/* Starting slot in SACK table ring */
@@ -784,6 +818,9 @@ struct rxrpc_ack_summary {
 	bool		retrans_timeo:1;	/* T if reTx due to timeout happened */
 	bool		need_retransmit:1;	/* T if we need transmission */
 	bool		rtt_sample_avail:1;	/* T if RTT sample available */
+	bool		in_fast_or_rto_recovery:1;
+	bool		exiting_fast_or_rto_recovery:1;
+	bool		tlp_probe_acked:1;	/* T if the TLP probe seq was acked */
 	u8 /*enum rxrpc_congest_change*/ change;
 };
 
@@ -865,6 +902,7 @@ struct rxrpc_txqueue {
 	unsigned long		segment_lost;	/* Bit-per-buf: Set if declared lost */
 	unsigned long		segment_retransmitted; /* Bit-per-buf: Set if retransmitted */
 	unsigned long		rtt_samples;	/* Bit-per-buf: Set if available for RTT */
+	unsigned long		ever_retransmitted; /* Bit-per-buf: Set if ever retransmitted */
 
 	/* The arrays we want to pack into as few cache lines as possible. */
 	struct {
@@ -884,7 +922,9 @@ struct rxrpc_send_data_req {
 	struct rxrpc_txqueue	*tq;		/* Tx queue segment holding first DATA */
 	rxrpc_seq_t		seq;		/* Sequence of first data */
 	int			n;		/* Number of DATA packets to glue into jumbo */
+	bool			retrans;	/* T if this is a retransmission */
 	bool			did_send;	/* T if did actually send */
+	bool			tlp_probe;	/* T if this is a TLP probe */
 	int /* enum rxrpc_txdata_trace */ trace;
 };
 
@@ -944,8 +984,9 @@ void rxrpc_propose_ping(struct rxrpc_call *call, u32 serial,
 			enum rxrpc_propose_ack_trace why);
 void rxrpc_propose_delay_ACK(struct rxrpc_call *, rxrpc_serial_t,
 			     enum rxrpc_propose_ack_trace);
-void rxrpc_resend(struct rxrpc_call *call, rxrpc_serial_t ack_serial, bool ping_response);
-
+void rxrpc_resend_tlp(struct rxrpc_call *call);
+void rxrpc_transmit_some_data(struct rxrpc_call *call, unsigned int limit,
+			      enum rxrpc_txdata_trace trace);
 bool rxrpc_input_call_event(struct rxrpc_call *call);
 
 /*
@@ -1124,6 +1165,32 @@ void rxrpc_congestion_degrade(struct rxrpc_call *);
 void rxrpc_input_call_packet(struct rxrpc_call *, struct sk_buff *);
 void rxrpc_implicit_end_call(struct rxrpc_call *, struct sk_buff *);
 
+/*
+ * input_rack.c
+ */
+void rxrpc_input_rack_one(struct rxrpc_call *call,
+			  struct rxrpc_ack_summary *summary,
+			  struct rxrpc_txqueue *tq,
+			  unsigned int ix);
+void rxrpc_input_rack(struct rxrpc_call *call,
+		      struct rxrpc_ack_summary *summary,
+		      struct rxrpc_txqueue *tq,
+		      unsigned long new_acks);
+void rxrpc_rack_detect_loss_and_arm_timer(struct rxrpc_call *call,
+					  struct rxrpc_ack_summary *summary);
+ktime_t rxrpc_tlp_calc_pto(struct rxrpc_call *call, ktime_t now);
+void rxrpc_tlp_send_probe(struct rxrpc_call *call);
+void rxrpc_tlp_process_ack(struct rxrpc_call *call, struct rxrpc_ack_summary *summary);
+void rxrpc_rack_timer_expired(struct rxrpc_call *call, ktime_t overran_by);
+
+/* Initialise TLP state [RFC8958 7.1]. */
+static inline void rxrpc_tlp_init(struct rxrpc_call *call)
+{
+	call->tlp_serial = 0;
+	call->tlp_seq = call->acks_hard_ack;
+	call->tlp_is_retrans = false;
+}
+
 /*
  * io_thread.c
  */
@@ -1400,6 +1467,10 @@ static inline u32 latest(u32 seq1, u32 seq2)
 {
 	return after(seq1, seq2) ? seq1 : seq2;
 }
+static inline bool rxrpc_seq_in_txq(const struct rxrpc_txqueue *tq, rxrpc_seq_t seq)
+{
+	return (seq & (RXRPC_NR_TXQUEUE - 1)) == tq->qbase;
+}
 
 static inline void rxrpc_queue_rx_call_packet(struct rxrpc_call *call, struct sk_buff *skb)
 {
@@ -1408,6 +1479,31 @@ static inline void rxrpc_queue_rx_call_packet(struct rxrpc_call *call, struct sk
 	rxrpc_poke_call(call, rxrpc_call_poke_rx_packet);
 }
 
+/*
+ * Calculate how much space there is for transmitting more DATA packets.
+ */
+static inline unsigned int rxrpc_tx_window_space(const struct rxrpc_call *call)
+{
+	int winsize = umin(call->tx_winsize, call->cong_cwnd + call->cong_extra);
+	int transmitted = call->tx_top - call->tx_bottom;
+
+	return max(winsize - transmitted, 0);
+}
+
+static inline unsigned int rxrpc_left_out(const struct rxrpc_call *call)
+{
+	return call->acks_nr_sacks + call->tx_nr_lost;
+}
+
+/*
+ * Calculate the number of transmitted DATA packets assumed to be in flight
+ * [approx RFC6675].
+ */
+static inline unsigned int rxrpc_tx_in_flight(const struct rxrpc_call *call)
+{
+	return call->tx_nr_sent - rxrpc_left_out(call) + call->tx_nr_resent;
+}
+
 /*
  * debug tracing
  */
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 82db8bc664ac..95fc27047c3d 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -54,35 +54,21 @@ void rxrpc_propose_delay_ACK(struct rxrpc_call *call, rxrpc_serial_t serial,
 	trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_delayed_ack);
 }
 
-/*
- * Handle congestion being detected by the retransmit timeout.
- */
-static void rxrpc_congestion_timeout(struct rxrpc_call *call)
-{
-	set_bit(RXRPC_CALL_RETRANS_TIMEOUT, &call->flags);
-}
-
 /*
  * Retransmit one or more packets.
  */
 static bool rxrpc_retransmit_data(struct rxrpc_call *call,
-				  struct rxrpc_send_data_req *req,
-				  ktime_t rto, bool skip_too_young)
+				  struct rxrpc_send_data_req *req)
 {
 	struct rxrpc_txqueue *tq = req->tq;
 	unsigned int ix = req->seq & RXRPC_TXQ_MASK;
 	struct rxrpc_txbuf *txb = tq->bufs[ix];
-	ktime_t xmit_ts, resend_at;
 
 	_enter("%x,%x,%x,%px", tq->qbase, req->seq, ix, txb);
 
-	xmit_ts = ktime_add_us(tq->xmit_ts_base, tq->segment_xmit_ts[ix]);
-	resend_at = ktime_add(xmit_ts, rto);
-	trace_rxrpc_retransmit(call, req, txb, ktime_sub(resend_at, req->now));
-	if (skip_too_young && ktime_after(resend_at, req->now))
-		return false;
+	req->retrans = true;
+	trace_rxrpc_retransmit(call, req, txb);
 
-	__set_bit(ix, &tq->segment_retransmitted);
 	txb->flags |= RXRPC_TXBUF_RESENT;
 	rxrpc_send_data_packet(call, req);
 	rxrpc_inc_stat(call->rxnet, stat_tx_data_retrans);
@@ -97,132 +83,76 @@ static bool rxrpc_retransmit_data(struct rxrpc_call *call,
 /*
  * Perform retransmission of NAK'd and unack'd packets.
  */
-void rxrpc_resend(struct rxrpc_call *call, rxrpc_serial_t ack_serial, bool ping_response)
+static void rxrpc_resend(struct rxrpc_call *call)
 {
 	struct rxrpc_send_data_req req = {
 		.now	= ktime_get_real(),
 		.trace	= rxrpc_txdata_retransmit,
 	};
-	struct rxrpc_txqueue *tq = call->tx_queue;
-	ktime_t lowest_xmit_ts = KTIME_MAX;
-	ktime_t rto = rxrpc_get_rto_backoff(call, false);
-	bool unacked = false;
+	struct rxrpc_txqueue *tq;
 
 	_enter("{%d,%d}", call->tx_bottom, call->tx_top);
 
-	if (call->tx_bottom == call->tx_top) {
-		call->resend_at = KTIME_MAX;
-		trace_rxrpc_timer_can(call, rxrpc_timer_trace_resend);
-		return;
-	}
+	trace_rxrpc_resend(call, call->acks_highest_serial);
 
-	trace_rxrpc_resend(call, ack_serial);
-
-	/* Scan the transmission queue, looking for explicitly NAK'd packets. */
-	do {
-		unsigned long naks = ~tq->segment_acked;
-		rxrpc_seq_t tq_top = tq->qbase + RXRPC_NR_TXQUEUE - 1;
+	/* Scan the transmission queue, looking for lost packets. */
+	for (tq = call->tx_queue; tq; tq = tq->next) {
+		unsigned long lost = tq->segment_lost;
 
 		if (after(tq->qbase, call->tx_transmitted))
 			break;
 
-		if (tq->nr_reported_acks < RXRPC_NR_TXQUEUE)
-			naks &= (1UL << tq->nr_reported_acks) - 1;
-
 		_debug("retr %16lx %u c=%08x [%x]",
 		       tq->segment_acked, tq->nr_reported_acks, call->debug_id, tq->qbase);
-		_debug("nack %16lx", naks);
+		_debug("lost %16lx", lost);
 
-		while (naks) {
-			unsigned int ix = __ffs(naks);
+		trace_rxrpc_resend_lost(call, tq, lost);
+		while (lost) {
+			unsigned int ix = __ffs(lost);
 			struct rxrpc_txbuf *txb = tq->bufs[ix];
 
-			__clear_bit(ix, &naks);
-			if (after(txb->serial, call->acks_highest_serial))
-				continue; /* Ack point not yet reached */
-
-			rxrpc_see_txbuf(txb, rxrpc_txbuf_see_unacked);
+			__clear_bit(ix, &lost);
+			rxrpc_see_txbuf(txb, rxrpc_txbuf_see_lost);
 
 			req.tq  = tq;
 			req.seq = tq->qbase + ix;
 			req.n   = 1;
-			rxrpc_retransmit_data(call, &req, rto, false);
-		}
-
-		/* Anything after the soft-ACK table up to and including
-		 * ack.previousPacket will get ACK'd or NACK'd in due course,
-		 * so don't worry about those here.  We do, however, need to
-		 * consider retransmitting anything beyond that point.
-		 */
-		if (tq->nr_reported_acks < RXRPC_NR_TXQUEUE &&
-		    after(tq_top, call->acks_prev_seq)) {
-			rxrpc_seq_t start = latest(call->acks_prev_seq,
-						   tq->qbase + tq->nr_reported_acks);
-			rxrpc_seq_t stop = earliest(tq_top, call->tx_transmitted);
-
-			_debug("unrep %x-%x", start, stop);
-			for (rxrpc_seq_t seq = start; before_eq(seq, stop); seq++) {
-				rxrpc_serial_t serial = tq->segment_serial[seq & RXRPC_TXQ_MASK];
-
-				if (ping_response &&
-				    before(serial, call->acks_highest_serial))
-					break; /* Wasn't accounted for by a more recent ping. */
-				req.tq  = tq;
-				req.seq = seq;
-				req.n   = 1;
-				if (rxrpc_retransmit_data(call, &req, rto, true))
-					unacked = true;
-			}
+			rxrpc_retransmit_data(call, &req);
 		}
-
-		/* Work out the next retransmission timeout. */
-		if (ktime_before(tq->xmit_ts_base, lowest_xmit_ts)) {
-			unsigned int lowest_us = UINT_MAX;
-
-			for (int i = 0; i < RXRPC_NR_TXQUEUE; i++)
-				if (!test_bit(i, &tq->segment_acked) &&
-				    tq->segment_xmit_ts[i] < lowest_us)
-					lowest_us = tq->segment_xmit_ts[i];
-			_debug("lowest[%x] %llx %u", tq->qbase, tq->xmit_ts_base, lowest_us);
-
-			if (lowest_us != UINT_MAX) {
-				ktime_t lowest_ns = ktime_add_us(tq->xmit_ts_base, lowest_us);
-				if (ktime_before(lowest_ns, lowest_xmit_ts))
-					lowest_xmit_ts = lowest_ns;
-			}
-		}
-	} while ((tq = tq->next));
-
-	if (lowest_xmit_ts < KTIME_MAX) {
-		ktime_t delay = rxrpc_get_rto_backoff(call, req.did_send);
-		ktime_t resend_at = ktime_add(lowest_xmit_ts, delay);
-
-		_debug("delay %llu %lld", delay, ktime_sub(resend_at, req.now));
-		call->resend_at = resend_at;
-		trace_rxrpc_timer_set(call, ktime_sub(resend_at, req.now),
-				      rxrpc_timer_trace_resend_reset);
-	} else {
-		call->resend_at = KTIME_MAX;
-		trace_rxrpc_timer_can(call, rxrpc_timer_trace_resend);
 	}
 
-	if (unacked)
-		rxrpc_congestion_timeout(call);
+	rxrpc_get_rto_backoff(call, req.did_send);
+	_leave("");
+}
 
-	/* If there was nothing that needed retransmission then it's likely
-	 * that an ACK got lost somewhere.  Send a ping to find out instead of
-	 * retransmitting data.
-	 */
-	if (!req.did_send) {
-		ktime_t next_ping = ktime_add_us(call->acks_latest_ts,
-						 call->srtt_us >> 3);
+/*
+ * Resend the highest-seq DATA packet so far transmitted for RACK-TLP [RFC8985 7.3].
+ */
+void rxrpc_resend_tlp(struct rxrpc_call *call)
+{
+	struct rxrpc_send_data_req req = {
+		.now		= ktime_get_real(),
+		.seq		= call->tx_transmitted,
+		.n		= 1,
+		.tlp_probe	= true,
+		.trace		= rxrpc_txdata_tlp_retransmit,
+	};
 
-		if (ktime_sub(next_ping, req.now) <= 0)
-			rxrpc_send_ACK(call, RXRPC_ACK_PING, 0,
-				       rxrpc_propose_ack_ping_for_0_retrans);
+	/* There's a chance it'll be on the tail segment of the queue. */
+	req.tq = READ_ONCE(call->tx_qtail);
+	if (req.tq &&
+	    before(call->tx_transmitted, req.tq->qbase + RXRPC_NR_TXQUEUE)) {
+		rxrpc_retransmit_data(call, &req);
+		return;
 	}
 
-	_leave("");
+	for (req.tq = call->tx_queue; req.tq; req.tq = req.tq->next) {
+		if (after_eq(call->tx_transmitted, req.tq->qbase) &&
+		    before(call->tx_transmitted, req.tq->qbase + RXRPC_NR_TXQUEUE)) {
+			rxrpc_retransmit_data(call, &req);
+			return;
+		}
+	}
 }
 
 /*
@@ -258,18 +188,10 @@ static void rxrpc_close_tx_phase(struct rxrpc_call *call)
 	}
 }
 
-static unsigned int rxrpc_tx_window_space(struct rxrpc_call *call)
-{
-	int winsize = umin(call->tx_winsize, call->cong_cwnd + call->cong_extra);
-	int in_flight = call->tx_top - call->tx_bottom;
-
-	return max(winsize - in_flight, 0);
-}
-
 /*
- * Transmit some as-yet untransmitted data.
+ * Transmit some as-yet untransmitted data, to a maximum of the supplied limit.
  */
-static void rxrpc_transmit_fresh_data(struct rxrpc_call *call,
+static void rxrpc_transmit_fresh_data(struct rxrpc_call *call, unsigned int limit,
 				      enum rxrpc_txdata_trace trace)
 {
 	int space = rxrpc_tx_window_space(call);
@@ -334,8 +256,8 @@ static void rxrpc_transmit_fresh_data(struct rxrpc_call *call,
 	}
 }
 
-static void rxrpc_transmit_some_data(struct rxrpc_call *call,
-				     enum rxrpc_txdata_trace trace)
+void rxrpc_transmit_some_data(struct rxrpc_call *call, unsigned int limit,
+			      enum rxrpc_txdata_trace trace)
 {
 	switch (__rxrpc_call_state(call)) {
 	case RXRPC_CALL_SERVER_ACK_REQUEST:
@@ -352,7 +274,7 @@ static void rxrpc_transmit_some_data(struct rxrpc_call *call,
 			rxrpc_inc_stat(call->rxnet, stat_tx_data_underflow);
 			return;
 		}
-		rxrpc_transmit_fresh_data(call, trace);
+		rxrpc_transmit_fresh_data(call, limit, trace);
 		break;
 	default:
 		return;
@@ -379,7 +301,7 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
 {
 	struct sk_buff *skb;
 	ktime_t now, t;
-	bool resend = false, did_receive = false, saw_ack = false;
+	bool did_receive = false, saw_ack = false;
 	s32 abort_code;
 
 	rxrpc_see_call(call, rxrpc_call_see_input);
@@ -397,21 +319,33 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
 		goto out;
 	}
 
-	while ((skb = __skb_dequeue(&call->rx_queue))) {
-		struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+	do {
+		skb = __skb_dequeue(&call->rx_queue);
+		if (skb) {
+			struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+
+			if (__rxrpc_call_is_complete(call) ||
+			    skb->mark == RXRPC_SKB_MARK_ERROR) {
+				rxrpc_free_skb(skb, rxrpc_skb_put_call_rx);
+				goto out;
+			}
 
-		if (__rxrpc_call_is_complete(call) ||
-		    skb->mark == RXRPC_SKB_MARK_ERROR) {
+			saw_ack |= sp->hdr.type == RXRPC_PACKET_TYPE_ACK;
+
+			rxrpc_input_call_packet(call, skb);
 			rxrpc_free_skb(skb, rxrpc_skb_put_call_rx);
-			goto out;
+			did_receive = true;
 		}
 
-		saw_ack |= sp->hdr.type == RXRPC_PACKET_TYPE_ACK;
+		t = ktime_sub(call->rack_timo_at, ktime_get_real());
+		if (t <= 0) {
+			trace_rxrpc_timer_exp(call, t,
+					      rxrpc_timer_trace_rack_off + call->rack_timer_mode);
+			call->rack_timo_at = KTIME_MAX;
+			rxrpc_rack_timer_expired(call, t);
+		}
 
-		rxrpc_input_call_packet(call, skb);
-		rxrpc_free_skb(skb, rxrpc_skb_put_call_rx);
-		did_receive = true;
-	}
+	} while (!skb_queue_empty(&call->rx_queue));
 
 	/* If we see our async-event poke, check for timeout trippage. */
 	now = ktime_get_real();
@@ -444,13 +378,6 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
 			       rxrpc_propose_ack_delayed_ack);
 	}
 
-	t = ktime_sub(call->ack_lost_at, now);
-	if (t <= 0) {
-		trace_rxrpc_timer_exp(call, t, rxrpc_timer_trace_lost_ack);
-		call->ack_lost_at = KTIME_MAX;
-		set_bit(RXRPC_CALL_EV_ACK_LOST, &call->events);
-	}
-
 	t = ktime_sub(call->ping_at, now);
 	if (t <= 0) {
 		trace_rxrpc_timer_exp(call, t, rxrpc_timer_trace_ping);
@@ -459,15 +386,6 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
 			       rxrpc_propose_ack_ping_for_keepalive);
 	}
 
-	t = ktime_sub(call->resend_at, now);
-	if (t <= 0) {
-		trace_rxrpc_timer_exp(call, t, rxrpc_timer_trace_resend);
-		call->resend_at = KTIME_MAX;
-		resend = true;
-	}
-
-	rxrpc_transmit_some_data(call, rxrpc_txdata_new_data);
-
 	now = ktime_get_real();
 	t = ktime_sub(call->keepalive_at, now);
 	if (t <= 0) {
@@ -477,21 +395,30 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
 			       rxrpc_propose_ack_ping_for_keepalive);
 	}
 
+	if (test_and_clear_bit(RXRPC_CALL_EV_INITIAL_PING, &call->events))
+		rxrpc_send_initial_ping(call);
+
+	rxrpc_transmit_some_data(call, UINT_MAX, rxrpc_txdata_new_data);
+
 	if (saw_ack)
 		rxrpc_congestion_degrade(call);
 
-	if (test_and_clear_bit(RXRPC_CALL_EV_INITIAL_PING, &call->events))
-		rxrpc_send_initial_ping(call);
+	if (did_receive &&
+	    (__rxrpc_call_state(call) == RXRPC_CALL_CLIENT_SEND_REQUEST ||
+	     __rxrpc_call_state(call) == RXRPC_CALL_SERVER_SEND_REPLY)) {
+		t = ktime_sub(call->rack_timo_at, ktime_get_real());
+		trace_rxrpc_rack(call, t);
+	}
 
 	/* Process events */
 	if (test_and_clear_bit(RXRPC_CALL_EV_ACK_LOST, &call->events))
 		rxrpc_send_ACK(call, RXRPC_ACK_PING, 0,
 			       rxrpc_propose_ack_ping_for_lost_ack);
 
-	if (resend &&
+	if (call->tx_nr_lost > 0 &&
 	    __rxrpc_call_state(call) != RXRPC_CALL_CLIENT_RECV_REPLY &&
 	    !test_bit(RXRPC_CALL_TX_ALL_ACKED, &call->flags))
-		rxrpc_resend(call, 0, false);
+		rxrpc_resend(call);
 
 	if (test_and_clear_bit(RXRPC_CALL_RX_IS_IDLE, &call->flags))
 		rxrpc_send_ACK(call, RXRPC_ACK_IDLE, 0,
@@ -519,8 +446,7 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
 		set(call->expect_req_by);
 		set(call->expect_rx_by);
 		set(call->delay_ack_at);
-		set(call->ack_lost_at);
-		set(call->resend_at);
+		set(call->rack_timo_at);
 		set(call->keepalive_at);
 		set(call->ping_at);
 
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 2405b8a4d69d..f5104b6e655e 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -161,8 +161,7 @@ struct rxrpc_call *rxrpc_alloc_call(struct rxrpc_sock *rx, gfp_t gfp,
 	call->ackr_window	= 1;
 	call->ackr_wtop		= 1;
 	call->delay_ack_at	= KTIME_MAX;
-	call->ack_lost_at	= KTIME_MAX;
-	call->resend_at		= KTIME_MAX;
+	call->rack_timo_at	= KTIME_MAX;
 	call->ping_at		= KTIME_MAX;
 	call->keepalive_at	= KTIME_MAX;
 	call->expect_rx_by	= KTIME_MAX;
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index cdfabfbc1a38..8fb32e9926a0 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -27,13 +27,13 @@ static void rxrpc_proto_abort(struct rxrpc_call *call, rxrpc_seq_t seq,
 }
 
 /*
- * Do TCP-style congestion management [RFC 5681].
+ * Do TCP-style congestion management [RFC5681].
  */
 static void rxrpc_congestion_management(struct rxrpc_call *call,
 					struct rxrpc_ack_summary *summary)
 {
 	summary->change = rxrpc_cong_no_change;
-	summary->in_flight = (call->tx_top - call->tx_bottom) - call->acks_nr_sacks;
+	summary->in_flight = rxrpc_tx_in_flight(call);
 
 	if (test_and_clear_bit(RXRPC_CALL_RETRANS_TIMEOUT, &call->flags)) {
 		summary->retrans_timeo = true;
@@ -106,9 +106,12 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 		call->cong_extra = 0;
 		call->cong_dup_acks = 0;
 		summary->need_retransmit = true;
+		summary->in_fast_or_rto_recovery = true;
 		goto out;
 
 	case RXRPC_CA_FAST_RETRANSMIT:
+		rxrpc_tlp_init(call);
+		summary->in_fast_or_rto_recovery = true;
 		if (!summary->new_low_snack) {
 			if (summary->nr_new_sacks == 0)
 				call->cong_cwnd += 1;
@@ -121,8 +124,10 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 		} else {
 			summary->change = rxrpc_cong_progress;
 			call->cong_cwnd = call->cong_ssthresh;
-			if (call->acks_nr_snacks == 0)
+			if (call->acks_nr_snacks == 0) {
+				summary->exiting_fast_or_rto_recovery = true;
 				goto resume_normality;
+			}
 		}
 		goto out;
 
@@ -171,7 +176,7 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
  */
 void rxrpc_congestion_degrade(struct rxrpc_call *call)
 {
-	ktime_t rtt, now;
+	ktime_t rtt, now, time_since;
 
 	if (call->cong_ca_state != RXRPC_CA_SLOW_START &&
 	    call->cong_ca_state != RXRPC_CA_CONGEST_AVOIDANCE)
@@ -181,10 +186,11 @@ void rxrpc_congestion_degrade(struct rxrpc_call *call)
 
 	rtt = ns_to_ktime(call->srtt_us * (NSEC_PER_USEC / 8));
 	now = ktime_get_real();
-	if (!ktime_before(ktime_add(call->tx_last_sent, rtt), now))
+	time_since = ktime_sub(now, call->tx_last_sent);
+	if (ktime_before(time_since, rtt))
 		return;
 
-	trace_rxrpc_reset_cwnd(call, now);
+	trace_rxrpc_reset_cwnd(call, time_since, rtt);
 	rxrpc_inc_stat(call->rxnet, stat_tx_data_cwnd_reset);
 	call->tx_last_sent = now;
 	call->cong_ca_state = RXRPC_CA_SLOW_START;
@@ -200,11 +206,11 @@ static void rxrpc_add_data_rtt_sample(struct rxrpc_call *call,
 				      struct rxrpc_txqueue *tq,
 				      int ix)
 {
+	ktime_t xmit_ts = ktime_add_us(tq->xmit_ts_base, tq->segment_xmit_ts[ix]);
+
 	rxrpc_call_add_rtt(call, rxrpc_rtt_rx_data_ack, -1,
 			   summary->acked_serial, summary->ack_serial,
-			   ktime_add_us(tq->xmit_ts_base, tq->segment_xmit_ts[ix]),
-			   call->acks_latest_ts);
-	summary->rtt_sample_avail = false;
+			   xmit_ts, call->acks_latest_ts);
 	__clear_bit(ix, &tq->rtt_samples); /* Prevent repeat RTT sample */
 }
 
@@ -216,7 +222,7 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 {
 	struct rxrpc_txqueue *tq = call->tx_queue;
 	rxrpc_seq_t seq = call->tx_bottom + 1;
-	bool rot_last = false;
+	bool rot_last = false, trace = false;
 
 	_enter("%x,%x", call->tx_bottom, to);
 
@@ -250,14 +256,16 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 			rot_last = true;
 		}
 
-		if (summary->rtt_sample_avail &&
-		    summary->acked_serial == tq->segment_serial[ix] &&
+		if (summary->acked_serial == tq->segment_serial[ix] &&
 		    test_bit(ix, &tq->rtt_samples))
 			rxrpc_add_data_rtt_sample(call, summary, tq, ix);
 
 		if (ix == tq->nr_reported_acks) {
 			/* Packet directly hard ACK'd. */
 			tq->nr_reported_acks++;
+			rxrpc_input_rack_one(call, summary, tq, ix);
+			if (seq == call->tlp_seq)
+				summary->tlp_probe_acked = true;
 			summary->nr_new_hacks++;
 			__set_bit(ix, &tq->segment_acked);
 			trace_rxrpc_rotate(call, tq, summary, seq, rxrpc_rotate_trace_hack);
@@ -268,11 +276,21 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 		} else {
 			/* Soft NAK -> hard ACK. */
 			call->acks_nr_snacks--;
+			rxrpc_input_rack_one(call, summary, tq, ix);
+			if (seq == call->tlp_seq)
+				summary->tlp_probe_acked = true;
 			summary->nr_new_hacks++;
 			__set_bit(ix, &tq->segment_acked);
 			trace_rxrpc_rotate(call, tq, summary, seq, rxrpc_rotate_trace_snak);
 		}
 
+		call->tx_nr_sent--;
+		if (__test_and_clear_bit(ix, &tq->segment_lost))
+			call->tx_nr_lost--;
+		if (__test_and_clear_bit(ix, &tq->segment_retransmitted))
+			call->tx_nr_resent--;
+		__clear_bit(ix, &tq->ever_retransmitted);
+
 		rxrpc_put_txbuf(tq->bufs[ix], rxrpc_txbuf_put_rotated);
 		tq->bufs[ix] = NULL;
 
@@ -282,7 +300,10 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 					   rxrpc_txqueue_rotate));
 
 		seq++;
+		trace = true;
 		if (!(seq & RXRPC_TXQ_MASK)) {
+			trace_rxrpc_rack_update(call, summary);
+			trace = false;
 			prefetch(tq->next);
 			if (tq != call->tx_qtail) {
 				call->tx_qbase += RXRPC_NR_TXQUEUE;
@@ -299,6 +320,9 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 
 	} while (before_eq(seq, to));
 
+	if (trace)
+		trace_rxrpc_rack_update(call, summary);
+
 	if (rot_last) {
 		set_bit(RXRPC_CALL_TX_ALL_ACKED, &call->flags);
 		if (tq) {
@@ -325,8 +349,10 @@ static void rxrpc_end_tx_phase(struct rxrpc_call *call, bool reply_begun,
 {
 	ASSERT(test_bit(RXRPC_CALL_TX_LAST, &call->flags));
 
-	call->resend_at = KTIME_MAX;
-	trace_rxrpc_timer_can(call, rxrpc_timer_trace_resend);
+	call->rack_timer_mode = RXRPC_CALL_RACKTIMER_OFF;
+	call->rack_timo_at = KTIME_MAX;
+	trace_rxrpc_rack_timer(call, 0, false);
+	trace_rxrpc_timer_can(call, rxrpc_timer_trace_rack_off + call->rack_timer_mode);
 
 	switch (__rxrpc_call_state(call)) {
 	case RXRPC_CALL_CLIENT_SEND_REQUEST:
@@ -842,10 +868,13 @@ static void rxrpc_input_soft_ack_tq(struct rxrpc_call *call,
 				    rxrpc_seq_t seq,
 				    rxrpc_seq_t *lowest_nak)
 {
-	unsigned long old_reported, flipped, new_acks, a_to_n, n_to_a;
+	unsigned long old_reported = 0, flipped, new_acks = 0;
+	unsigned long a_to_n, n_to_a = 0;
 	int new, a, n;
 
-	old_reported = ~0UL >> (RXRPC_NR_TXQUEUE - tq->nr_reported_acks);
+	if (tq->nr_reported_acks > 0)
+		old_reported = ~0UL >> (RXRPC_NR_TXQUEUE - tq->nr_reported_acks);
+
 	_enter("{%x,%lx,%d},%lx,%d,%x",
 	       tq->qbase, tq->segment_acked, tq->nr_reported_acks,
 	       extracted_acks, nr_reported, seq);
@@ -898,6 +927,18 @@ static void rxrpc_input_soft_ack_tq(struct rxrpc_call *call,
 		if (before(lowest, *lowest_nak))
 			*lowest_nak = lowest;
 	}
+
+	if (summary->acked_serial)
+		rxrpc_input_soft_rtt(call, summary, tq);
+
+	new_acks |= n_to_a;
+	if (new_acks)
+		rxrpc_input_rack(call, summary, tq, new_acks);
+
+	if (call->tlp_serial &&
+	    rxrpc_seq_in_txq(tq, call->tlp_seq) &&
+	    test_bit(call->tlp_seq - tq->qbase, &new_acks))
+		summary->tlp_probe_acked = true;
 }
 
 /*
@@ -940,8 +981,6 @@ static void rxrpc_input_soft_acks(struct rxrpc_call *call,
 
 		_debug("bound %16lx %u", extracted, nr);
 
-		if (summary->rtt_sample_avail)
-			rxrpc_input_soft_rtt(call, summary, tq);
 		rxrpc_input_soft_ack_tq(call, summary, tq, extracted, RXRPC_NR_TXQUEUE,
 					seq - RXRPC_NR_TXQUEUE, &lowest_nak);
 		extracted = ~0UL;
@@ -1063,7 +1102,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	/* Discard any out-of-order or duplicate ACKs (outside lock). */
 	if (!rxrpc_is_ack_valid(call, hard_ack, prev_pkt)) {
 		trace_rxrpc_rx_discard_ack(call, summary.ack_serial, hard_ack, prev_pkt);
-		goto send_response;
+		goto send_response; /* Still respond if requested. */
 	}
 
 	trailer.maxMTU = 0;
@@ -1079,14 +1118,19 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	call->acks_hard_ack = hard_ack;
 	call->acks_prev_seq = prev_pkt;
 
-	switch (summary.ack_reason) {
-	case RXRPC_ACK_PING:
-		break;
-	default:
-		if (summary.acked_serial &&
-		    after(summary.acked_serial, call->acks_highest_serial))
-			call->acks_highest_serial = summary.acked_serial;
-		break;
+	if (summary.acked_serial) {
+		switch (summary.ack_reason) {
+		case RXRPC_ACK_PING_RESPONSE:
+			rxrpc_complete_rtt_probe(call, call->acks_latest_ts,
+						 summary.acked_serial, summary.ack_serial,
+						 rxrpc_rtt_rx_ping_response);
+			break;
+		default:
+			if (after(summary.acked_serial, call->acks_highest_serial))
+				call->acks_highest_serial = summary.acked_serial;
+			summary.rtt_sample_avail = true;
+			break;
+		}
 	}
 
 	/* Parse rwind and mtu sizes if provided. */
@@ -1096,15 +1140,6 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	if (hard_ack + 1 == 0)
 		return rxrpc_proto_abort(call, 0, rxrpc_eproto_ackr_zero);
 
-	if (summary.acked_serial) {
-		if (summary.ack_reason == RXRPC_ACK_PING_RESPONSE)
-			rxrpc_complete_rtt_probe(call, call->acks_latest_ts,
-						 summary.acked_serial, summary.ack_serial,
-						 rxrpc_rtt_rx_ping_response);
-		else
-			summary.rtt_sample_avail = true;
-	}
-
 	/* Ignore ACKs unless we are or have just been transmitting. */
 	switch (__rxrpc_call_state(call)) {
 	case RXRPC_CALL_CLIENT_SEND_REQUEST:
@@ -1141,10 +1176,14 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 		rxrpc_propose_ping(call, summary.ack_serial,
 				   rxrpc_propose_ack_ping_for_lost_reply);
 
+	/* Drive the congestion management algorithm first and then RACK-TLP as
+	 * the latter depends on the state/change in state in the former.
+	 */
 	rxrpc_congestion_management(call, &summary);
-	if (summary.need_retransmit)
-		rxrpc_resend(call, summary.ack_serial,
-			     summary.ack_reason == RXRPC_ACK_PING_RESPONSE);
+	rxrpc_rack_detect_loss_and_arm_timer(call, &summary);
+	rxrpc_tlp_process_ack(call, &summary);
+	if (call->tlp_serial && after_eq(summary.acked_serial, call->tlp_serial))
+		call->tlp_serial = 0;
 
 send_response:
 	if (summary.ack_reason == RXRPC_ACK_PING)
diff --git a/net/rxrpc/input_rack.c b/net/rxrpc/input_rack.c
new file mode 100644
index 000000000000..b5d7a8d69c76
--- /dev/null
+++ b/net/rxrpc/input_rack.c
@@ -0,0 +1,422 @@
+/* RACK-TLP [RFC8958] Implementation
+ *
+ * Copyright (C) 2024 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include "ar-internal.h"
+
+static inline ktime_t us_to_ktime(u64 us)
+{
+	return us * NSEC_PER_USEC;
+}
+
+static bool rxrpc_rack_sent_after(ktime_t t1, rxrpc_seq_t seq1,
+				  ktime_t t2, rxrpc_seq_t seq2)
+{
+	if (ktime_after(t1, t2))
+		return true;
+	return t1 == t2 && after(seq1, seq2);
+}
+
+/*
+ * Mark a packet lost.
+ */
+static void rxrpc_rack_mark_lost(struct rxrpc_call *call,
+				 struct rxrpc_txqueue *tq, unsigned int ix)
+{
+	if (__test_and_set_bit(ix, &tq->segment_lost)) {
+		if (__test_and_clear_bit(ix, &tq->segment_retransmitted))
+			call->tx_nr_resent--;
+	} else {
+		call->tx_nr_lost++;
+	}
+	tq->segment_xmit_ts[ix] = UINT_MAX;
+}
+
+/*
+ * Get the transmission time of a packet in the Tx queue.
+ */
+static ktime_t rxrpc_get_xmit_ts(const struct rxrpc_txqueue *tq, unsigned int ix)
+{
+	if (tq->segment_xmit_ts[ix] == UINT_MAX)
+		return KTIME_MAX;
+	return ktime_add_us(tq->xmit_ts_base, tq->segment_xmit_ts[ix]);
+}
+
+/*
+ * Get a bitmask of nack bits for a queue segment and mask off any that aren't
+ * yet reported.
+ */
+static unsigned long rxrpc_tq_nacks(const struct rxrpc_txqueue *tq)
+{
+	unsigned long nacks = ~tq->segment_acked;
+
+	if (tq->nr_reported_acks < RXRPC_NR_TXQUEUE)
+		nacks &= (1UL << tq->nr_reported_acks) - 1;
+	return nacks;
+}
+
+/*
+ * Update the RACK state for the most recently sent packet that has been
+ * delivered [RFC8958 6.2 Step 2].
+ */
+static void rxrpc_rack_update(struct rxrpc_call *call,
+			      struct rxrpc_ack_summary *summary,
+			      struct rxrpc_txqueue *tq,
+			      unsigned int ix)
+{
+	rxrpc_seq_t seq = tq->qbase + ix;
+	ktime_t xmit_ts = rxrpc_get_xmit_ts(tq, ix);
+	ktime_t rtt = ktime_sub(call->acks_latest_ts, xmit_ts);
+
+	if (__test_and_clear_bit(ix, &tq->segment_lost))
+		call->tx_nr_lost--;
+
+	if (test_bit(ix, &tq->segment_retransmitted)) {
+		/* Use Rx.serial instead of TCP.ACK.ts_option.echo_reply. */
+		if (before(call->acks_highest_serial, tq->segment_serial[ix]))
+			return;
+		if (rtt < minmax_get(&call->min_rtt))
+			return;
+	}
+
+	/* The RACK algorithm requires the segment ACKs to be traversed in
+	 * order of segment transmission - but the only thing this seems to
+	 * matter for is that RACK.rtt is set to the rtt of the most recently
+	 * transmitted segment.  We should be able to achieve the same by only
+	 * setting RACK.rtt if the xmit time is greater.
+	 */
+	if (ktime_after(xmit_ts, call->rack_rtt_ts)) {
+		call->rack_rtt	  = rtt;
+		call->rack_rtt_ts = xmit_ts;
+	}
+
+	if (rxrpc_rack_sent_after(xmit_ts, seq, call->rack_xmit_ts, call->rack_end_seq)) {
+		call->rack_rtt = rtt;
+		call->rack_xmit_ts = xmit_ts;
+		call->rack_end_seq = seq;
+	}
+}
+
+/*
+ * Detect data segment reordering [RFC8958 6.2 Step 3].
+ */
+static void rxrpc_rack_detect_reordering(struct rxrpc_call *call,
+					 struct rxrpc_ack_summary *summary,
+					 struct rxrpc_txqueue *tq,
+					 unsigned int ix)
+{
+	rxrpc_seq_t seq = tq->qbase + ix;
+
+	/* Track the highest sequence number so far ACK'd.  This is not
+	 * necessarily the same as ack.firstPacket + ack.nAcks - 1 as the peer
+	 * could put a NACK in the last SACK slot.
+	 */
+	if (after(seq, call->rack_fack))
+		call->rack_fack = seq;
+	else if (before(seq, call->rack_fack) &&
+		 test_bit(ix, &tq->segment_retransmitted))
+		call->rack_reordering_seen = true;
+}
+
+void rxrpc_input_rack_one(struct rxrpc_call *call,
+			  struct rxrpc_ack_summary *summary,
+			  struct rxrpc_txqueue *tq,
+			  unsigned int ix)
+{
+	rxrpc_rack_update(call, summary, tq, ix);
+	rxrpc_rack_detect_reordering(call, summary, tq, ix);
+}
+
+void rxrpc_input_rack(struct rxrpc_call *call,
+		      struct rxrpc_ack_summary *summary,
+		      struct rxrpc_txqueue *tq,
+		      unsigned long new_acks)
+{
+	while (new_acks) {
+		unsigned int ix = __ffs(new_acks);
+
+		__clear_bit(ix, &new_acks);
+		rxrpc_input_rack_one(call, summary, tq, ix);
+	}
+
+	trace_rxrpc_rack_update(call, summary);
+}
+
+/*
+ * Update the reordering window [RFC8958 6.2 Step 4].  Returns the updated
+ * duration of the reordering window.
+ *
+ * Note that the Rx protocol doesn't have a 'DSACK option' per se, but ACKs can
+ * be given a 'DUPLICATE' reason with the serial number referring to the
+ * duplicated DATA packet.  Rx does not inform as to whether this was a
+ * reception of the same packet twice or of a retransmission of a packet we
+ * already received (though this could be determined by the transmitter based
+ * on the serial number).
+ */
+static ktime_t rxrpc_rack_update_reo_wnd(struct rxrpc_call *call,
+					 struct rxrpc_ack_summary *summary)
+{
+	rxrpc_seq_t snd_una = call->acks_lowest_nak; /* Lowest unack'd seq */
+	rxrpc_seq_t snd_nxt = call->tx_transmitted + 1; /* Next seq to be sent */
+	bool have_dsack_option = summary->ack_reason == RXRPC_ACK_DUPLICATE;
+	int dup_thresh = 3;
+
+	/* DSACK-based reordering window adaptation */
+	if (!call->rack_dsack_round_none &&
+	    after_eq(snd_una, call->rack_dsack_round))
+		call->rack_dsack_round_none = true;
+
+	/* Grow the reordering window per round that sees DSACK.  Reset the
+	 * window after 16 DSACK-free recoveries.
+	 */
+	if (call->rack_dsack_round_none && have_dsack_option) {
+		call->rack_dsack_round_none = false;
+		call->rack_dsack_round = snd_nxt;
+		call->rack_reo_wnd_mult++;
+		call->rack_reo_wnd_persist = 16;
+	} else if (summary->exiting_fast_or_rto_recovery) {
+		call->rack_reo_wnd_persist--;
+		if (call->rack_reo_wnd_persist <= 0)
+			call->rack_reo_wnd_mult = 1;
+	}
+
+	if (!call->rack_reordering_seen) {
+		if (summary->in_fast_or_rto_recovery)
+			return 0;
+		if (call->acks_nr_sacks >= dup_thresh)
+			return 0;
+	}
+
+	return us_to_ktime(umin(call->rack_reo_wnd_mult * minmax_get(&call->min_rtt) / 4,
+				call->srtt_us >> 3));
+}
+
+/*
+ * Detect losses [RFC8958 6.2 Step 5].
+ */
+static ktime_t rxrpc_rack_detect_loss(struct rxrpc_call *call,
+				      struct rxrpc_ack_summary *summary)
+{
+	struct rxrpc_txqueue *tq;
+	ktime_t timeout = 0, lost_after, now = ktime_get_real();
+
+	call->rack_reo_wnd = rxrpc_rack_update_reo_wnd(call, summary);
+	lost_after = ktime_add(call->rack_rtt, call->rack_reo_wnd);
+	trace_rxrpc_rack_scan_loss(call);
+
+	for (tq = call->tx_queue; tq; tq = tq->next) {
+		unsigned long nacks = rxrpc_tq_nacks(tq);
+
+		if (after(tq->qbase, call->tx_transmitted))
+			break;
+		trace_rxrpc_rack_scan_loss_tq(call, tq, nacks);
+
+		/* Skip ones marked lost but not yet retransmitted */
+		nacks &= ~tq->segment_lost | tq->segment_retransmitted;
+
+		while (nacks) {
+			unsigned int ix = __ffs(nacks);
+			rxrpc_seq_t seq = tq->qbase + ix;
+			ktime_t remaining;
+			ktime_t xmit_ts = rxrpc_get_xmit_ts(tq, ix);
+
+			__clear_bit(ix, &nacks);
+
+			if (rxrpc_rack_sent_after(call->rack_xmit_ts, call->rack_end_seq,
+						  xmit_ts, seq)) {
+				remaining = ktime_sub(ktime_add(xmit_ts, lost_after), now);
+				if (remaining <= 0) {
+					rxrpc_rack_mark_lost(call, tq, ix);
+					trace_rxrpc_rack_detect_loss(call, summary, seq);
+				} else {
+					timeout = max(remaining, timeout);
+				}
+			}
+		}
+	}
+
+	return timeout;
+}
+
+/*
+ * Detect losses and set a timer to retry the detection [RFC8958 6.2 Step 5].
+ */
+void rxrpc_rack_detect_loss_and_arm_timer(struct rxrpc_call *call,
+					  struct rxrpc_ack_summary *summary)
+{
+	ktime_t timeout = rxrpc_rack_detect_loss(call, summary);
+
+	if (timeout) {
+		call->rack_timer_mode = RXRPC_CALL_RACKTIMER_RACK_REORDER;
+		call->rack_timo_at = ktime_add(ktime_get_real(), timeout);
+		trace_rxrpc_rack_timer(call, timeout, false);
+		trace_rxrpc_timer_set(call, timeout, rxrpc_timer_trace_rack_reo);
+	}
+}
+
+/*
+ * Handle RACK-TLP RTO expiration [RFC8958 6.3].
+ */
+static void rxrpc_rack_mark_losses_on_rto(struct rxrpc_call *call)
+{
+	struct rxrpc_txqueue *tq;
+	rxrpc_seq_t snd_una = call->acks_lowest_nak; /* Lowest unack'd seq */
+	ktime_t lost_after = ktime_add(call->rack_rtt, call->rack_reo_wnd);
+	ktime_t deadline = ktime_sub(ktime_get_real(), lost_after);
+
+	for (tq = call->tx_queue; tq; tq = tq->next) {
+		unsigned long unacked = ~tq->segment_acked;
+
+		trace_rxrpc_rack_mark_loss_tq(call, tq);
+		while (unacked) {
+			unsigned int ix = __ffs(unacked);
+			rxrpc_seq_t seq = tq->qbase + ix;
+			ktime_t xmit_ts = rxrpc_get_xmit_ts(tq, ix);
+
+			if (after(seq, call->tx_transmitted))
+				return;
+			__clear_bit(ix, &unacked);
+
+			if (seq == snd_una ||
+			    ktime_before(xmit_ts, deadline))
+				rxrpc_rack_mark_lost(call, tq, ix);
+		}
+	}
+}
+
+/*
+ * Calculate the TLP loss probe timeout (PTO) [RFC8958 7.2].
+ */
+ktime_t rxrpc_tlp_calc_pto(struct rxrpc_call *call, ktime_t now)
+{
+	unsigned int flight_size = rxrpc_tx_in_flight(call);
+	ktime_t rto_at = ktime_add(call->tx_last_sent,
+				   rxrpc_get_rto_backoff(call, false));
+	ktime_t pto;
+
+	if (call->rtt_count > 0) {
+		/* Use 2*SRTT as the timeout. */
+		pto = ns_to_ktime(call->srtt_us * NSEC_PER_USEC / 4);
+		if (flight_size)
+			pto = ktime_add(pto, call->tlp_max_ack_delay);
+	} else {
+		pto = NSEC_PER_SEC;
+	}
+
+	if (ktime_after(ktime_add(now, pto), rto_at))
+		pto = ktime_sub(rto_at, now);
+	return pto;
+}
+
+/*
+ * Send a TLP loss probe on PTO expiration [RFC8958 7.3].
+ */
+void rxrpc_tlp_send_probe(struct rxrpc_call *call)
+{
+	unsigned int in_flight = rxrpc_tx_in_flight(call);
+
+	if (after_eq(call->acks_hard_ack, call->tx_transmitted))
+		return; /* Everything we transmitted has been acked. */
+
+	/* There must be no other loss probe still in flight and we need to
+	 * have taken a new RTT sample since last probe or the start of
+	 * connection.
+	 */
+	if (!call->tlp_serial &&
+	    call->tlp_rtt_taken != call->rtt_taken) {
+		call->tlp_is_retrans = false;
+		if (after(call->send_top, call->tx_transmitted) &&
+		    rxrpc_tx_window_space(call) > 0) {
+			/* Transmit the lowest-sequence unsent DATA */
+			call->tx_last_serial = 0;
+			rxrpc_transmit_some_data(call, 1, rxrpc_txdata_tlp_new_data);
+			call->tlp_serial = call->tx_last_serial;
+			call->tlp_seq = call->tx_transmitted;
+			trace_rxrpc_tlp_probe(call, rxrpc_tlp_probe_trace_transmit_new);
+			in_flight = rxrpc_tx_in_flight(call);
+		} else {
+			/* Retransmit the highest-sequence DATA sent */
+			call->tx_last_serial = 0;
+			rxrpc_resend_tlp(call);
+			call->tlp_is_retrans = true;
+			trace_rxrpc_tlp_probe(call, rxrpc_tlp_probe_trace_retransmit);
+		}
+	} else {
+		trace_rxrpc_tlp_probe(call, rxrpc_tlp_probe_trace_busy);
+	}
+
+	if (in_flight != 0) {
+		ktime_t rto = rxrpc_get_rto_backoff(call, false);
+
+		call->rack_timer_mode = RXRPC_CALL_RACKTIMER_RTO;
+		call->rack_timo_at = ktime_add(ktime_get_real(), rto);
+		trace_rxrpc_rack_timer(call, rto, false);
+		trace_rxrpc_timer_set(call, rto, rxrpc_timer_trace_rack_rto);
+	}
+}
+
+/*
+ * Detect losses using the ACK of a TLP loss probe [RFC8958 7.4].
+ */
+void rxrpc_tlp_process_ack(struct rxrpc_call *call, struct rxrpc_ack_summary *summary)
+{
+	if (!call->tlp_serial || after(call->tlp_seq, call->acks_hard_ack))
+		return;
+
+	if (!call->tlp_is_retrans) {
+		/* TLP of new data delivered */
+		trace_rxrpc_tlp_ack(call, summary, rxrpc_tlp_ack_trace_new_data);
+		call->tlp_serial = 0;
+	} else if (summary->ack_reason == RXRPC_ACK_DUPLICATE &&
+		   summary->acked_serial == call->tlp_serial) {
+		/* General Case: Detected packet losses using RACK [7.4.1] */
+		trace_rxrpc_tlp_ack(call, summary, rxrpc_tlp_ack_trace_dup_acked);
+		call->tlp_serial = 0;
+	} else if (after(call->acks_hard_ack, call->tlp_seq)) {
+		/* Repaired the single loss */
+		trace_rxrpc_tlp_ack(call, summary, rxrpc_tlp_ack_trace_hard_beyond);
+		call->tlp_serial = 0;
+		// TODO: Invoke congestion control to react to the loss
+		// event the probe has repaired
+	} else if (summary->tlp_probe_acked) {
+		trace_rxrpc_tlp_ack(call, summary, rxrpc_tlp_ack_trace_acked);
+		/* Special Case: Detected a single loss repaired by the loss
+		 * probe [7.4.2]
+		 */
+		call->tlp_serial = 0;
+	} else {
+		trace_rxrpc_tlp_ack(call, summary, rxrpc_tlp_ack_trace_incomplete);
+	}
+}
+
+/*
+ * Handle RACK timer expiration; returns true to request a resend.
+ */
+void rxrpc_rack_timer_expired(struct rxrpc_call *call, ktime_t overran_by)
+{
+	struct rxrpc_ack_summary summary = {};
+	enum rxrpc_rack_timer_mode mode = call->rack_timer_mode;
+
+	trace_rxrpc_rack_timer(call, overran_by, true);
+	call->rack_timer_mode = RXRPC_CALL_RACKTIMER_OFF;
+
+	switch (mode) {
+	case RXRPC_CALL_RACKTIMER_RACK_REORDER:
+		rxrpc_rack_detect_loss_and_arm_timer(call, &summary);
+		break;
+	case RXRPC_CALL_RACKTIMER_TLP_PTO:
+		rxrpc_tlp_send_probe(call);
+		break;
+	case RXRPC_CALL_RACKTIMER_RTO:
+		// Might need to poke the congestion algo in some way
+		rxrpc_rack_mark_losses_on_rto(call);
+		break;
+	//case RXRPC_CALL_RACKTIMER_ZEROWIN:
+	default:
+		pr_warn("Unexpected rack timer %u", call->rack_timer_mode);
+	}
+}
diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
index 86a746f54851..44612980b60a 100644
--- a/net/rxrpc/io_thread.c
+++ b/net/rxrpc/io_thread.c
@@ -470,6 +470,7 @@ int rxrpc_io_thread(void *data)
 			spin_lock_irq(&local->rx_queue.lock);
 			skb_queue_splice_tail_init(&local->rx_queue, &rx_queue);
 			spin_unlock_irq(&local->rx_queue.lock);
+			trace_rxrpc_iothread_rx(local, skb_queue_len(&rx_queue));
 		}
 
 		/* Distribute packets and errors. */
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index c8ae59103c21..56ae207e4f3a 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -541,12 +541,14 @@ static size_t rxrpc_prepare_data_packet(struct rxrpc_call *call, struct rxrpc_se
 	unsigned int xmit_ts;
 	rxrpc_seq_t seq = req->seq;
 	size_t len = 0;
+	bool start_tlp = false;
 
 	trace_rxrpc_tq(call, tq, seq, rxrpc_tq_transmit);
 
 	/* Each transmission of a Tx packet needs a new serial number */
 	serial = rxrpc_get_next_serials(call->conn, req->n);
 
+	call->tx_last_serial = serial + req->n - 1;
 	call->tx_last_sent = req->now;
 	xmit_ts = rxrpc_prepare_txqueue(tq, req);
 	prefetch(tq->next);
@@ -556,6 +558,18 @@ static size_t rxrpc_prepare_data_packet(struct rxrpc_call *call, struct rxrpc_se
 		struct rxrpc_txbuf *txb = tq->bufs[seq & RXRPC_TXQ_MASK];
 
 		_debug("prep[%u] tq=%x q=%x", i, tq->qbase, seq);
+
+		/* Record (re-)transmission for RACK [RFC8985 6.1]. */
+		if (__test_and_clear_bit(ix, &tq->segment_lost))
+			call->tx_nr_lost--;
+		if (req->retrans) {
+			__set_bit(ix, &tq->ever_retransmitted);
+			__set_bit(ix, &tq->segment_retransmitted);
+			call->tx_nr_resent++;
+		} else {
+			call->tx_nr_sent++;
+			start_tlp = true;
+		}
 		tq->segment_xmit_ts[ix] = xmit_ts;
 		tq->segment_serial[ix] = serial;
 		if (i + 1 == req->n)
@@ -575,11 +589,24 @@ static size_t rxrpc_prepare_data_packet(struct rxrpc_call *call, struct rxrpc_se
 	}
 
 	/* Set timeouts */
-	if (call->rtt_count > 1) {
-		ktime_t delay = rxrpc_get_rto_backoff(call, false);
+	if (req->tlp_probe) {
+		/* Sending TLP loss probe [RFC8985 7.3]. */
+		call->tlp_serial = serial - 1;
+		call->tlp_seq = seq - 1;
+	} else if (start_tlp) {
+		/* Schedule TLP loss probe [RFC8985 7.2]. */
+		ktime_t pto;
+
+		if (!test_bit(RXRPC_CALL_BEGAN_RX_TIMER, &call->flags))
+			pto = NSEC_PER_SEC; /* The first packet may take longer
+					     * to elicit a response. */
+		else
+			pto = rxrpc_tlp_calc_pto(call, req->now);
 
-		call->ack_lost_at = ktime_add(req->now, delay);
-		trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_lost_ack);
+		call->rack_timer_mode = RXRPC_CALL_RACKTIMER_TLP_PTO;
+		call->rack_timo_at = ktime_add(req->now, pto);
+		trace_rxrpc_rack_timer(call, pto, false);
+		trace_rxrpc_timer_set(call, pto, rxrpc_timer_trace_rack_tlp_pto);
 	}
 
 	if (!test_and_set_bit(RXRPC_CALL_BEGAN_RX_TIMER, &call->flags)) {
@@ -588,12 +615,6 @@ static size_t rxrpc_prepare_data_packet(struct rxrpc_call *call, struct rxrpc_se
 		call->expect_rx_by = ktime_add(req->now, delay);
 		trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_expect_rx);
 	}
-	if (call->resend_at == KTIME_MAX) {
-		ktime_t delay = rxrpc_get_rto_backoff(call, false);
-
-		call->resend_at = ktime_add(req->now, delay);
-		trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_resend);
-	}
 
 	rxrpc_set_keepalive(call, req->now);
 	return len;


