Return-Path: <netdev+bounces-148102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0095E9E0A3C
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 18:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F82BB835AD
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A2A2185A9;
	Mon,  2 Dec 2024 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="is6fAdzT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF6F2185AE
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150008; cv=none; b=dvRyPZQrMgaYTQE2dq47IYULiUw40IcM1jPMmOdb7JG3Qlajk7odsz50FV1uhO6xaDQoBYsWGB5VLKOnGUGFd8o5/QuFuUOMZvcgmIcDYOFB/EL0SYuJOSxdqjWaeW5PgHK4dTWeVNCegnQ4B4D9HOzow95WZBtbF2RyOroqq/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150008; c=relaxed/simple;
	bh=m6YUVTsBLcpo45MRcOweKAEys5a2QPtY9fqDs2S94W8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WsVZxcnCMMkLhUSfIzq0vgEoF/ORyw4pAqZsLvKYRPqk8uBQWl5AN16CCIePF51NIfwNpje/uCG7PGTtYOQ5FIWOJ9/CALXafGlq2YDOEOmjO2Zfhy4L0YByzgzb7IdioVWU/IiYX+xgar3c6wF+gOGEjmOnkVMMQhhQvqU5SvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=is6fAdzT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733150006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nvXJNz/iPxbk5jM9Oy/Wvdskj6d8ybknFGLLtiwLe0Y=;
	b=is6fAdzT5mMop5n1OjpIixwYXcvHRuTzHUnZ8SF/Sm8g3Fk+SdhYV1+8/zyQjpoAYPVUCG
	AD7d4V9Q9YsLpLuRLV/9IlvH2Gr9AdshX3JNSjg5lW5JaHw8oZXIOmG1XC1QJAVmjlzkwU
	GxCqct638KOvt/jsykuRRLS58PIo5Fg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-Eyx6IqV6PCCH4e8uPqwvpg-1; Mon,
 02 Dec 2024 09:33:21 -0500
X-MC-Unique: Eyx6IqV6PCCH4e8uPqwvpg-1
X-Mimecast-MFC-AGG-ID: Eyx6IqV6PCCH4e8uPqwvpg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F0CE18EBB53;
	Mon,  2 Dec 2024 14:33:20 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D3C331955F41;
	Mon,  2 Dec 2024 14:33:17 +0000 (UTC)
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
Subject: [PATCH net-next 33/37] rxrpc: Add a reason indicator to the tx_data tracepoint
Date: Mon,  2 Dec 2024 14:30:51 +0000
Message-ID: <20241202143057.378147-34-dhowells@redhat.com>
In-Reply-To: <20241202143057.378147-1-dhowells@redhat.com>
References: <20241202143057.378147-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add an indicator to the rxrpc_tx_data tracepoint to indicate what triggered
the transmission of a particular packet.  At this point, it's only normal
transmission and retransmission, plus the tracepoint is also used to record
loss injection, but in a future patch, TLP-induced (re-)transmission will
also be a thing.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h | 21 ++++++++++++++-------
 net/rxrpc/ar-internal.h      |  1 +
 net/rxrpc/call_event.c       | 12 ++++++++----
 net/rxrpc/output.c           |  6 +++---
 4 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 326a4c257aea..d79623fff746 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -302,6 +302,11 @@
 	EM(rxrpc_txqueue_rotate_last,		"RLS") \
 	E_(rxrpc_txqueue_wait,			"WAI")
 
+#define rxrpc_txdata_traces \
+	EM(rxrpc_txdata_inject_loss,		" *INJ-LOSS*") \
+	EM(rxrpc_txdata_new_data,		" ") \
+	E_(rxrpc_txdata_retransmit,		" *RETRANS*")
+
 #define rxrpc_receive_traces \
 	EM(rxrpc_receive_end,			"END") \
 	EM(rxrpc_receive_front,			"FRN") \
@@ -534,6 +539,7 @@ enum rxrpc_timer_trace		{ rxrpc_timer_traces } __mode(byte);
 enum rxrpc_tq_trace		{ rxrpc_tq_traces } __mode(byte);
 enum rxrpc_tx_point		{ rxrpc_tx_points } __mode(byte);
 enum rxrpc_txbuf_trace		{ rxrpc_txbuf_traces } __mode(byte);
+enum rxrpc_txdata_trace		{ rxrpc_txdata_traces } __mode(byte);
 enum rxrpc_txqueue_trace	{ rxrpc_txqueue_traces } __mode(byte);
 
 #endif /* end __RXRPC_DECLARE_TRACE_ENUMS_ONCE_ONLY */
@@ -572,6 +578,7 @@ rxrpc_timer_traces;
 rxrpc_tq_traces;
 rxrpc_tx_points;
 rxrpc_txbuf_traces;
+rxrpc_txdata_traces;
 rxrpc_txqueue_traces;
 
 /*
@@ -1222,9 +1229,10 @@ TRACE_EVENT(rxrpc_tx_packet,
 
 TRACE_EVENT(rxrpc_tx_data,
 	    TP_PROTO(struct rxrpc_call *call, rxrpc_seq_t seq,
-		     rxrpc_serial_t serial, unsigned int flags, bool lose),
+		     rxrpc_serial_t serial, unsigned int flags,
+		     enum rxrpc_txdata_trace trace),
 
-	    TP_ARGS(call, seq, serial, flags, lose),
+	    TP_ARGS(call, seq, serial, flags, trace),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,	call)
@@ -1233,7 +1241,7 @@ TRACE_EVENT(rxrpc_tx_data,
 		    __field(u32,		cid)
 		    __field(u32,		call_id)
 		    __field(u16,		flags)
-		    __field(bool,		lose)
+		    __field(enum rxrpc_txdata_trace, trace)
 			     ),
 
 	    TP_fast_assign(
@@ -1243,18 +1251,17 @@ TRACE_EVENT(rxrpc_tx_data,
 		    __entry->seq = seq;
 		    __entry->serial = serial;
 		    __entry->flags = flags;
-		    __entry->lose = lose;
+		    __entry->trace = trace;
 			   ),
 
-	    TP_printk("c=%08x DATA %08x:%08x %08x q=%08x fl=%02x%s%s",
+	    TP_printk("c=%08x DATA %08x:%08x %08x q=%08x fl=%02x%s",
 		      __entry->call,
 		      __entry->cid,
 		      __entry->call_id,
 		      __entry->serial,
 		      __entry->seq,
 		      __entry->flags & RXRPC_TXBUF_WIRE_FLAGS,
-		      __entry->flags & RXRPC_TXBUF_RESENT ? " *RETRANS*" : "",
-		      __entry->lose ? " *LOSE*" : "")
+		      __print_symbolic(__entry->trace, rxrpc_txdata_traces))
 	    );
 
 TRACE_EVENT(rxrpc_tx_ack,
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index ec87f2e8b78c..cc02a3fcb6b7 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -884,6 +884,7 @@ struct rxrpc_send_data_req {
 	rxrpc_seq_t		seq;		/* Sequence of first data */
 	int			n;		/* Number of DATA packets to glue into jumbo */
 	bool			did_send;	/* T if did actually send */
+	int /* enum rxrpc_txdata_trace */ trace;
 };
 
 #include <trace/events/rxrpc.h>
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 165d7cb134f2..d1e80aeb8ef6 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -101,6 +101,7 @@ void rxrpc_resend(struct rxrpc_call *call, rxrpc_serial_t ack_serial, bool ping_
 {
 	struct rxrpc_send_data_req req = {
 		.now	= ktime_get_real(),
+		.trace	= rxrpc_txdata_retransmit,
 	};
 	struct rxrpc_txqueue *tq = call->tx_queue;
 	ktime_t lowest_xmit_ts = KTIME_MAX;
@@ -268,7 +269,8 @@ static unsigned int rxrpc_tx_window_space(struct rxrpc_call *call)
 /*
  * Transmit some as-yet untransmitted data.
  */
-static void rxrpc_transmit_fresh_data(struct rxrpc_call *call)
+static void rxrpc_transmit_fresh_data(struct rxrpc_call *call,
+				      enum rxrpc_txdata_trace trace)
 {
 	int space = rxrpc_tx_window_space(call);
 
@@ -283,6 +285,7 @@ static void rxrpc_transmit_fresh_data(struct rxrpc_call *call)
 			.now	= ktime_get_real(),
 			.seq	= call->tx_transmitted + 1,
 			.n	= 0,
+			.trace	= trace,
 		};
 		struct rxrpc_txqueue *tq;
 		struct rxrpc_txbuf *txb;
@@ -331,7 +334,8 @@ static void rxrpc_transmit_fresh_data(struct rxrpc_call *call)
 	}
 }
 
-static void rxrpc_transmit_some_data(struct rxrpc_call *call)
+static void rxrpc_transmit_some_data(struct rxrpc_call *call,
+				     enum rxrpc_txdata_trace trace)
 {
 	switch (__rxrpc_call_state(call)) {
 	case RXRPC_CALL_SERVER_ACK_REQUEST:
@@ -348,7 +352,7 @@ static void rxrpc_transmit_some_data(struct rxrpc_call *call)
 			rxrpc_inc_stat(call->rxnet, stat_tx_data_underflow);
 			return;
 		}
-		rxrpc_transmit_fresh_data(call);
+		rxrpc_transmit_fresh_data(call, trace);
 		break;
 	default:
 		return;
@@ -462,7 +466,7 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
 		resend = true;
 	}
 
-	rxrpc_transmit_some_data(call);
+	rxrpc_transmit_some_data(call, rxrpc_txdata_new_data);
 
 	now = ktime_get_real();
 	t = ktime_sub(call->keepalive_at, now);
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 73c37689c54f..47796f451895 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -510,7 +510,7 @@ static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call,
 		len += sizeof(*jumbo);
 	}
 
-	trace_rxrpc_tx_data(call, txb->seq, txb->serial, txb->flags | flags, false);
+	trace_rxrpc_tx_data(call, txb->seq, txb->serial, flags, req->trace);
 	kv->iov_len = len;
 	return len;
 }
@@ -653,8 +653,8 @@ void rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_send_data_req
 		static int lose;
 		if ((lose++ & 7) == 7) {
 			ret = 0;
-			trace_rxrpc_tx_data(call, txb->seq, txb->serial,
-					    txb->flags, true);
+			trace_rxrpc_tx_data(call, txb->seq, txb->serial, txb->flags,
+					    rxrpc_txdata_inject_loss);
 			conn->peer->last_tx_at = ktime_get_seconds();
 			goto done;
 		}


