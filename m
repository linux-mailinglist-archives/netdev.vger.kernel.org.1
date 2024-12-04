Return-Path: <netdev+bounces-148858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D29F9E347C
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD79168542
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 07:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4081A0B07;
	Wed,  4 Dec 2024 07:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6+XAFMH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA320190059
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 07:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298502; cv=none; b=E19wJrnkMXXHJs8QQbPRPqrswdWxn58TcNvhEEreeVibxyrtUxgy/ogauEBWw9a47A8JaZy6GnrgVqdVYL6UJNyJTnGNmm0qFkvPn52rtCb//LKAILn1m7ZNHx6Sy5xe7pWh30SQH4KBx0IkDXwOKpwNjbGXeJZmQlJo4dVgo4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298502; c=relaxed/simple;
	bh=lk4LFmvXGTFWc0cKu6t93nzFMjkJAaLhND8AlKVZHVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djeJn1NgYuz+9LaGlTmV1MZjCJatw0PQYRo/Q4ASmJ41Q3g5QAHJUqhQBPY2eFHeEBkZefHSVFdWqphWhjC7JQwYfNl3h9af9haHe6w0QIPfL/oWG1JTOV0SzUP0diPnRuW/Sb1yEMD23/K60BdS4vjIc6djL9p+wC0ecT7OjgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d6+XAFMH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733298496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rAvog4FllgjWuDxsbCJJipzyT/CYhN8uzeu5Y16K81A=;
	b=d6+XAFMHESsVIT7sjokSS7m0LjwLKfiCwiqWPrdKyd5GeEyhlSXx16ihU17YZNMdyDQ1DT
	OYAwlgOEQWpdOEn/LT575EROhu7dtcPpHrNPnxE6PN9YwqOvPp1RVbiYilD6eUGNby90Zh
	+/LFVxKy9TpZxPNRdDTflNq+Qu5ojpw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-sWhC2PH1OSareb3hAqxZPg-1; Wed,
 04 Dec 2024 02:48:14 -0500
X-MC-Unique: sWhC2PH1OSareb3hAqxZPg-1
X-Mimecast-MFC-AGG-ID: sWhC2PH1OSareb3hAqxZPg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F0241955F3F;
	Wed,  4 Dec 2024 07:48:13 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 848D41956089;
	Wed,  4 Dec 2024 07:48:10 +0000 (UTC)
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
Subject: [PATCH net-next v2 13/39] rxrpc: Fix CPU time starvation in I/O thread
Date: Wed,  4 Dec 2024 07:46:41 +0000
Message-ID: <20241204074710.990092-14-dhowells@redhat.com>
In-Reply-To: <20241204074710.990092-1-dhowells@redhat.com>
References: <20241204074710.990092-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Starvation can happen in the rxrpc I/O thread because it goes back to the
top of the I/O loop after it does any one thing without trying to give any
other connection or call CPU time.  Also, because it processes one call
packet at a time, it tries to do the retransmission loop after each ACK
without checking to see if there are other ACKs already in the queue that
can update the SACK state.

Fix this by:

 (1) Add a received-packet queue on each call.

 (2) Distribute packets from the master Rx queue to the individual call,
     conn and error queues and 'poking' calls to add them to the attend
     queue first thing in the I/O thread.

 (3) Go through all the attention-seeking connections and calls before
     going back to the top of the I/O thread.  Each queue is extracted as a
     whole and then gone through so that new additions to insert themselves
     into the queue.

 (4) Make the call event handler go through all the packets currently on
     the call's rx_queue before transmitting and retransmitting DATA
     packets.

 (5) Drop the skb argument from the call event handler as this is now
     replaced with the rx_queue.  Instead, keep track of whether we
     received a packet or an ACK for the tests that used to rely on that.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h |   3 +
 net/rxrpc/ar-internal.h      |  10 +++-
 net/rxrpc/call_accept.c      |   2 +-
 net/rxrpc/call_event.c       |  34 +++++++-----
 net/rxrpc/call_object.c      |   2 +
 net/rxrpc/conn_client.c      |  12 ++--
 net/rxrpc/input.c            |   2 +-
 net/rxrpc/io_thread.c        | 104 ++++++++++++++++++-----------------
 net/rxrpc/peer_event.c       |   2 +-
 9 files changed, 96 insertions(+), 75 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 71f07e726a90..28fa7be31ff8 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -120,6 +120,7 @@
 	EM(rxrpc_call_poke_conn_abort,		"Conn-abort")	\
 	EM(rxrpc_call_poke_error,		"Error")	\
 	EM(rxrpc_call_poke_idle,		"Idle")		\
+	EM(rxrpc_call_poke_rx_packet,		"Rx-packet")	\
 	EM(rxrpc_call_poke_set_timeout,		"Set-timo")	\
 	EM(rxrpc_call_poke_start,		"Start")	\
 	EM(rxrpc_call_poke_timer,		"Timer")	\
@@ -128,6 +129,7 @@
 #define rxrpc_skb_traces \
 	EM(rxrpc_skb_eaten_by_unshare,		"ETN unshare  ") \
 	EM(rxrpc_skb_eaten_by_unshare_nomem,	"ETN unshar-nm") \
+	EM(rxrpc_skb_get_call_rx,		"GET call-rx  ") \
 	EM(rxrpc_skb_get_conn_secured,		"GET conn-secd") \
 	EM(rxrpc_skb_get_conn_work,		"GET conn-work") \
 	EM(rxrpc_skb_get_last_nack,		"GET last-nack") \
@@ -139,6 +141,7 @@
 	EM(rxrpc_skb_new_error_report,		"NEW error-rpt") \
 	EM(rxrpc_skb_new_jumbo_subpacket,	"NEW jumbo-sub") \
 	EM(rxrpc_skb_new_unshared,		"NEW unshared ") \
+	EM(rxrpc_skb_put_call_rx,		"PUT call-rx  ") \
 	EM(rxrpc_skb_put_conn_secured,		"PUT conn-secd") \
 	EM(rxrpc_skb_put_conn_work,		"PUT conn-work") \
 	EM(rxrpc_skb_put_error_report,		"PUT error-rep") \
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 4386b2e6cca5..55cc68dd1b40 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -705,6 +705,7 @@ struct rxrpc_call {
 
 	/* Received data tracking */
 	struct sk_buff_head	recvmsg_queue;	/* Queue of packets ready for recvmsg() */
+	struct sk_buff_head	rx_queue;	/* Queue of packets for this call to receive */
 	struct sk_buff_head	rx_oos_queue;	/* Queue of out of sequence packets */
 
 	rxrpc_seq_t		rx_highest_seq;	/* Higest sequence number received */
@@ -906,7 +907,7 @@ void rxrpc_propose_delay_ACK(struct rxrpc_call *, rxrpc_serial_t,
 void rxrpc_shrink_call_tx_buffer(struct rxrpc_call *);
 void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb);
 
-bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb);
+bool rxrpc_input_call_event(struct rxrpc_call *call);
 
 /*
  * call_object.c
@@ -1352,6 +1353,13 @@ static inline bool after_eq(u32 seq1, u32 seq2)
         return (s32)(seq1 - seq2) >= 0;
 }
 
+static inline void rxrpc_queue_rx_call_packet(struct rxrpc_call *call, struct sk_buff *skb)
+{
+	rxrpc_get_skb(skb, rxrpc_skb_get_call_rx);
+	__skb_queue_tail(&call->rx_queue, skb);
+	rxrpc_poke_call(call, rxrpc_call_poke_rx_packet);
+}
+
 /*
  * debug tracing
  */
diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index 0f5a1d77b890..a6776b1604ba 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -408,7 +408,7 @@ bool rxrpc_new_incoming_call(struct rxrpc_local *local,
 	}
 
 	_leave(" = %p{%d}", call, call->debug_id);
-	rxrpc_input_call_event(call, skb);
+	rxrpc_queue_rx_call_packet(call, skb);
 	rxrpc_put_call(call, rxrpc_call_put_input);
 	return true;
 
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 1f716f09d441..ef47de3f41c6 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -324,10 +324,11 @@ static void rxrpc_send_initial_ping(struct rxrpc_call *call)
 /*
  * Handle retransmission and deferred ACK/abort generation.
  */
-bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
+bool rxrpc_input_call_event(struct rxrpc_call *call)
 {
+	struct sk_buff *skb;
 	ktime_t now, t;
-	bool resend = false;
+	bool resend = false, did_receive = false, saw_ack = false;
 	s32 abort_code;
 
 	rxrpc_see_call(call, rxrpc_call_see_input);
@@ -337,9 +338,6 @@ bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 	       call->debug_id, rxrpc_call_states[__rxrpc_call_state(call)],
 	       call->events);
 
-	if (__rxrpc_call_is_complete(call))
-		goto out;
-
 	/* Handle abort request locklessly, vs rxrpc_propose_abort(). */
 	abort_code = smp_load_acquire(&call->send_abort);
 	if (abort_code) {
@@ -348,11 +346,21 @@ bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 		goto out;
 	}
 
-	if (skb && skb->mark == RXRPC_SKB_MARK_ERROR)
-		goto out;
+	while ((skb = __skb_dequeue(&call->rx_queue))) {
+		struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+
+		if (__rxrpc_call_is_complete(call) ||
+		    skb->mark == RXRPC_SKB_MARK_ERROR) {
+			rxrpc_free_skb(skb, rxrpc_skb_put_call_rx);
+			goto out;
+		}
+
+		saw_ack |= sp->hdr.type == RXRPC_PACKET_TYPE_ACK;
 
-	if (skb)
 		rxrpc_input_call_packet(call, skb);
+		rxrpc_free_skb(skb, rxrpc_skb_put_call_rx);
+		did_receive = true;
+	}
 
 	/* If we see our async-event poke, check for timeout trippage. */
 	now = ktime_get_real();
@@ -418,12 +426,8 @@ bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 			       rxrpc_propose_ack_ping_for_keepalive);
 	}
 
-	if (skb) {
-		struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
-
-		if (sp->hdr.type == RXRPC_PACKET_TYPE_ACK)
-			rxrpc_congestion_degrade(call);
-	}
+	if (saw_ack)
+		rxrpc_congestion_degrade(call);
 
 	if (test_and_clear_bit(RXRPC_CALL_EV_INITIAL_PING, &call->events))
 		rxrpc_send_initial_ping(call);
@@ -494,7 +498,7 @@ bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 		if (call->security)
 			call->security->free_call_crypto(call);
 	} else {
-		if (skb &&
+		if (did_receive &&
 		    call->peer->ackr_adv_pmtud &&
 		    call->peer->pmtud_pending)
 			rxrpc_send_probe_for_pmtud(call);
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 0df647d1d3a2..c026f16f891e 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -148,6 +148,7 @@ struct rxrpc_call *rxrpc_alloc_call(struct rxrpc_sock *rx, gfp_t gfp,
 	INIT_LIST_HEAD(&call->attend_link);
 	INIT_LIST_HEAD(&call->tx_sendmsg);
 	INIT_LIST_HEAD(&call->tx_buffer);
+	skb_queue_head_init(&call->rx_queue);
 	skb_queue_head_init(&call->recvmsg_queue);
 	skb_queue_head_init(&call->rx_oos_queue);
 	init_waitqueue_head(&call->waitq);
@@ -536,6 +537,7 @@ void rxrpc_get_call(struct rxrpc_call *call, enum rxrpc_call_trace why)
 static void rxrpc_cleanup_ring(struct rxrpc_call *call)
 {
 	rxrpc_purge_queue(&call->recvmsg_queue);
+	rxrpc_purge_queue(&call->rx_queue);
 	rxrpc_purge_queue(&call->rx_oos_queue);
 }
 
diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index 86fb18bcd188..706631e6ac2f 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -508,16 +508,18 @@ static void rxrpc_activate_channels(struct rxrpc_bundle *bundle)
 void rxrpc_connect_client_calls(struct rxrpc_local *local)
 {
 	struct rxrpc_call *call;
+	LIST_HEAD(new_client_calls);
 
-	while ((call = list_first_entry_or_null(&local->new_client_calls,
-						struct rxrpc_call, wait_link))
-	       ) {
+	spin_lock(&local->client_call_lock);
+	list_splice_tail_init(&local->new_client_calls, &new_client_calls);
+	spin_unlock(&local->client_call_lock);
+
+	while ((call = list_first_entry_or_null(&new_client_calls,
+						struct rxrpc_call, wait_link))) {
 		struct rxrpc_bundle *bundle = call->bundle;
 
-		spin_lock(&local->client_call_lock);
 		list_move_tail(&call->wait_link, &bundle->waiting_calls);
 		rxrpc_see_call(call, rxrpc_call_see_waiting_call);
-		spin_unlock(&local->client_call_lock);
 
 		if (rxrpc_bundle_has_space(bundle))
 			rxrpc_activate_channels(bundle);
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 8398fa10ee8d..96fe005c5e81 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -1124,5 +1124,5 @@ void rxrpc_implicit_end_call(struct rxrpc_call *call, struct sk_buff *skb)
 		break;
 	}
 
-	rxrpc_input_call_event(call, skb);
+	rxrpc_input_call_event(call);
 }
diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
index bd6d4f5e97b4..bc678a299bd8 100644
--- a/net/rxrpc/io_thread.c
+++ b/net/rxrpc/io_thread.c
@@ -338,7 +338,6 @@ static int rxrpc_input_packet_on_conn(struct rxrpc_connection *conn,
 	struct rxrpc_channel *chan;
 	struct rxrpc_call *call = NULL;
 	unsigned int channel;
-	bool ret;
 
 	if (sp->hdr.securityIndex != conn->security_ix)
 		return rxrpc_direct_abort(skb, rxrpc_eproto_wrong_security,
@@ -425,9 +424,9 @@ static int rxrpc_input_packet_on_conn(struct rxrpc_connection *conn,
 					       peer_srx, skb);
 	}
 
-	ret = rxrpc_input_call_event(call, skb);
+	rxrpc_queue_rx_call_packet(call, skb);
 	rxrpc_put_call(call, rxrpc_call_put_input);
-	return ret;
+	return true;
 }
 
 /*
@@ -444,6 +443,8 @@ int rxrpc_io_thread(void *data)
 	ktime_t now;
 #endif
 	bool should_stop;
+	LIST_HEAD(conn_attend_q);
+	LIST_HEAD(call_attend_q);
 
 	complete(&local->io_thread_ready);
 
@@ -454,43 +455,25 @@ int rxrpc_io_thread(void *data)
 	for (;;) {
 		rxrpc_inc_stat(local->rxnet, stat_io_loop);
 
-		/* Deal with connections that want immediate attention. */
-		conn = list_first_entry_or_null(&local->conn_attend_q,
-						struct rxrpc_connection,
-						attend_link);
-		if (conn) {
-			spin_lock_bh(&local->lock);
-			list_del_init(&conn->attend_link);
-			spin_unlock_bh(&local->lock);
-
-			rxrpc_input_conn_event(conn, NULL);
-			rxrpc_put_connection(conn, rxrpc_conn_put_poke);
-			continue;
+		/* Inject a delay into packets if requested. */
+#ifdef CONFIG_AF_RXRPC_INJECT_RX_DELAY
+		now = ktime_get_real();
+		while ((skb = skb_peek(&local->rx_delay_queue))) {
+			if (ktime_before(now, skb->tstamp))
+				break;
+			skb = skb_dequeue(&local->rx_delay_queue);
+			skb_queue_tail(&local->rx_queue, skb);
 		}
+#endif
 
-		if (test_and_clear_bit(RXRPC_CLIENT_CONN_REAP_TIMER,
-				       &local->client_conn_flags))
-			rxrpc_discard_expired_client_conns(local);
-
-		/* Deal with calls that want immediate attention. */
-		if ((call = list_first_entry_or_null(&local->call_attend_q,
-						     struct rxrpc_call,
-						     attend_link))) {
-			spin_lock_bh(&local->lock);
-			list_del_init(&call->attend_link);
-			spin_unlock_bh(&local->lock);
-
-			trace_rxrpc_call_poked(call);
-			rxrpc_input_call_event(call, NULL);
-			rxrpc_put_call(call, rxrpc_call_put_poke);
-			continue;
+		if (!skb_queue_empty(&local->rx_queue)) {
+			spin_lock_irq(&local->rx_queue.lock);
+			skb_queue_splice_tail_init(&local->rx_queue, &rx_queue);
+			spin_unlock_irq(&local->rx_queue.lock);
 		}
 
-		if (!list_empty(&local->new_client_calls))
-			rxrpc_connect_client_calls(local);
-
-		/* Process received packets and errors. */
-		if ((skb = __skb_dequeue(&rx_queue))) {
+		/* Distribute packets and errors. */
+		while ((skb = __skb_dequeue(&rx_queue))) {
 			struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 			switch (skb->mark) {
 			case RXRPC_SKB_MARK_PACKET:
@@ -514,27 +497,46 @@ int rxrpc_io_thread(void *data)
 				rxrpc_free_skb(skb, rxrpc_skb_put_unknown);
 				break;
 			}
-			continue;
 		}
 
-		/* Inject a delay into packets if requested. */
-#ifdef CONFIG_AF_RXRPC_INJECT_RX_DELAY
-		now = ktime_get_real();
-		while ((skb = skb_peek(&local->rx_delay_queue))) {
-			if (ktime_before(now, skb->tstamp))
-				break;
-			skb = skb_dequeue(&local->rx_delay_queue);
-			skb_queue_tail(&local->rx_queue, skb);
+		/* Deal with connections that want immediate attention. */
+		spin_lock_bh(&local->lock);
+		list_splice_tail_init(&local->conn_attend_q, &conn_attend_q);
+		spin_unlock_bh(&local->lock);
+
+		while ((conn = list_first_entry_or_null(&conn_attend_q,
+							struct rxrpc_connection,
+							attend_link))) {
+			spin_lock_bh(&local->lock);
+			list_del_init(&conn->attend_link);
+			spin_unlock_bh(&local->lock);
+			rxrpc_input_conn_event(conn, NULL);
+			rxrpc_put_connection(conn, rxrpc_conn_put_poke);
 		}
-#endif
 
-		if (!skb_queue_empty(&local->rx_queue)) {
-			spin_lock_irq(&local->rx_queue.lock);
-			skb_queue_splice_tail_init(&local->rx_queue, &rx_queue);
-			spin_unlock_irq(&local->rx_queue.lock);
-			continue;
+		if (test_and_clear_bit(RXRPC_CLIENT_CONN_REAP_TIMER,
+				       &local->client_conn_flags))
+			rxrpc_discard_expired_client_conns(local);
+
+		/* Deal with calls that want immediate attention. */
+		spin_lock_bh(&local->lock);
+		list_splice_tail_init(&local->call_attend_q, &call_attend_q);
+		spin_unlock_bh(&local->lock);
+
+		while ((call = list_first_entry_or_null(&call_attend_q,
+							struct rxrpc_call,
+							attend_link))) {
+			spin_lock_bh(&local->lock);
+			list_del_init(&call->attend_link);
+			spin_unlock_bh(&local->lock);
+			trace_rxrpc_call_poked(call);
+			rxrpc_input_call_event(call);
+			rxrpc_put_call(call, rxrpc_call_put_poke);
 		}
 
+		if (!list_empty(&local->new_client_calls))
+			rxrpc_connect_client_calls(local);
+
 		set_current_state(TASK_INTERRUPTIBLE);
 		should_stop = kthread_should_stop();
 		if (!skb_queue_empty(&local->rx_queue) ||
diff --git a/net/rxrpc/peer_event.c b/net/rxrpc/peer_event.c
index 8fc9464a960c..ff30e0c05507 100644
--- a/net/rxrpc/peer_event.c
+++ b/net/rxrpc/peer_event.c
@@ -224,7 +224,7 @@ static void rxrpc_distribute_error(struct rxrpc_peer *peer, struct sk_buff *skb,
 
 		rxrpc_see_call(call, rxrpc_call_see_distribute_error);
 		rxrpc_set_call_completion(call, compl, 0, -err);
-		rxrpc_input_call_event(call, skb);
+		rxrpc_input_call_event(call);
 
 		spin_lock(&peer->lock);
 	}


