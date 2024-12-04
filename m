Return-Path: <netdev+bounces-148883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 555BE9E34B7
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 09:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2322D167614
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E182120C022;
	Wed,  4 Dec 2024 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPZ2z757"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C53C20B81B
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298597; cv=none; b=GO6w5vRHf3gsx7eDdqrr8oKAvKIL50KLIkhQQgfTCg/JvYZlCbyucUvhR+ifBmDXNN4LsWT1eoTJ3UOxdElDgb+VMWswSIKc6sQXz4QjYo1484sTez0CZxd231WVtsNthblUWZ+OcogSmxy4ANpZD3sWFbgkxcQbFJ2rh2ZKHjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298597; c=relaxed/simple;
	bh=K4SYdP3LJIDYZIiRmFeZjsAxURrZTABv1ABbyZY7Hak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H355y9SU9kVn0pOx6GA+A1qR7imd19baJxS2JW5UrB5X/qgxmpD63yP739FzUU8qx0dvGU6kU/cDi/7agzp/ICTWHvvMZXQCZJh4Hfy3WsP3gjiQx0ZxFz00swU8uHqn5vmqJoy7uvagKFtljezhNX/e6QfSIGZXqARrEk6Jgd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CPZ2z757; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733298594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbmR+n4o0/faOJbfXuFJ63vogRZ4lJGjrINxeNubyCk=;
	b=CPZ2z757PjKlD/cWIXWd34JUBeAUP5WN5Q5x1SrKb6gYDwcFdT2WwWIw5tV2WL0Hcjn5If
	9hVK2phZDhRbvo/f81wPD3r7OLTb+XaI8axf1JqUW1nf8SNnvkbP4iXildndnTMCu/loHU
	yKd+wm1RcvZrxdMu5LVDC3xKcbUAf9g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-0AuaFTmQM2yT1ns9b36YNw-1; Wed,
 04 Dec 2024 02:49:51 -0500
X-MC-Unique: 0AuaFTmQM2yT1ns9b36YNw-1
X-Mimecast-MFC-AGG-ID: 0AuaFTmQM2yT1ns9b36YNw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 31E961955D4E;
	Wed,  4 Dec 2024 07:49:50 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 891CC1956048;
	Wed,  4 Dec 2024 07:49:47 +0000 (UTC)
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
Subject: [PATCH net-next v2 37/39] rxrpc: Manage RTT per-call rather than per-peer
Date: Wed,  4 Dec 2024 07:47:05 +0000
Message-ID: <20241204074710.990092-38-dhowells@redhat.com>
In-Reply-To: <20241204074710.990092-1-dhowells@redhat.com>
References: <20241204074710.990092-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Manage the determination of RTT on a per-call (ie. per-RPC op) basis rather
than on a per-peer basis, averaging across all calls going to that peer.
The problem is that the RTT measurements from the initial packets on a call
may be off because the server may do some setting up (such as getting a
lock on a file) before accepting the rest of the data in the RPC and,
further, the RTT may be affected by server-side file operations, for
instance if a large amount of data is being written or read.

Note: When handling the FS.StoreData-type RPCs, for example, the server
uses the userStatus field in the header of ACK packets as supplementary
flow control to aid in managing this.  AF_RXRPC does not yet support this,
but it should be added.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h |  2 +-
 net/rxrpc/ar-internal.h      | 39 +++++++++-------
 net/rxrpc/call_event.c       | 18 +++----
 net/rxrpc/call_object.c      |  2 +
 net/rxrpc/input.c            | 10 ++--
 net/rxrpc/output.c           | 14 +++---
 net/rxrpc/peer_object.c      |  9 +---
 net/rxrpc/proc.c             |  6 +--
 net/rxrpc/rtt.c              | 91 ++++++++++++++++++------------------
 net/rxrpc/sendmsg.c          |  2 +-
 10 files changed, 97 insertions(+), 96 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 0cfc8e1baf1f..71df5c48a413 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -1453,7 +1453,7 @@ TRACE_EVENT(rxrpc_rtt_rx,
 		    __entry->rtt = rtt;
 		    __entry->srtt = srtt;
 		    __entry->rto = rto;
-		    __entry->min_rtt = minmax_get(&call->peer->min_rtt)
+		    __entry->min_rtt = minmax_get(&call->min_rtt)
 			   ),
 
 	    TP_printk("c=%08x [%d] %s sr=%08x rr=%08x rtt=%u srtt=%u rto=%u min=%u",
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 139575032ae2..a9d732ba6df0 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -366,20 +366,9 @@ struct rxrpc_peer {
 	unsigned short		hdrsize;	/* header size (IP + UDP + RxRPC) */
 	unsigned short		tx_seg_max;	/* Maximum number of transmissable segments */
 
-	/* calculated RTT cache */
-#define RXRPC_RTT_CACHE_SIZE 32
-	spinlock_t		rtt_input_lock;	/* RTT lock for input routine */
-	ktime_t			rtt_last_req;	/* Time of last RTT request */
-	unsigned int		rtt_count;	/* Number of samples we've got */
-	unsigned int		rtt_taken;	/* Number of samples taken (wrapping) */
-	struct minmax		min_rtt;	/* Estimated minimum RTT */
-
-	u32			srtt_us;	/* smoothed round trip time << 3 in usecs */
-	u32			mdev_us;	/* medium deviation			*/
-	u32			mdev_max_us;	/* maximal mdev for the last rtt period	*/
-	u32			rttvar_us;	/* smoothed mdev_max			*/
-	u32			rto_us;		/* Retransmission timeout in usec */
-	u8			backoff;	/* Backoff timeout (as shift) */
+	/* Calculated RTT cache */
+	unsigned int		recent_srtt_us;
+	unsigned int		recent_rto_us;
 
 	u8			cong_ssthresh;	/* Congestion slow-start threshold */
 };
@@ -765,6 +754,18 @@ struct rxrpc_call {
 	rxrpc_serial_t		acks_highest_serial; /* Highest serial number ACK'd */
 	unsigned short		acks_nr_sacks;	/* Number of soft acks recorded */
 	unsigned short		acks_nr_snacks;	/* Number of soft nacks recorded */
+
+	/* Calculated RTT cache */
+	ktime_t			rtt_last_req;	/* Time of last RTT request */
+	unsigned int		rtt_count;	/* Number of samples we've got */
+	unsigned int		rtt_taken;	/* Number of samples taken (wrapping) */
+	struct minmax		min_rtt;	/* Estimated minimum RTT */
+	u32			srtt_us;	/* smoothed round trip time << 3 in usecs */
+	u32			mdev_us;	/* medium deviation			*/
+	u32			mdev_max_us;	/* maximal mdev for the last rtt period	*/
+	u32			rttvar_us;	/* smoothed mdev_max			*/
+	u32			rto_us;		/* Retransmission timeout in usec */
+	u8			backoff;	/* Backoff timeout (as shift) */
 };
 
 /*
@@ -1287,10 +1288,12 @@ static inline int rxrpc_abort_eproto(struct rxrpc_call *call,
 /*
  * rtt.c
  */
-void rxrpc_peer_add_rtt(struct rxrpc_call *, enum rxrpc_rtt_rx_trace, int,
-			rxrpc_serial_t, rxrpc_serial_t, ktime_t, ktime_t);
-ktime_t rxrpc_get_rto_backoff(struct rxrpc_peer *peer, bool retrans);
-void rxrpc_peer_init_rtt(struct rxrpc_peer *);
+void rxrpc_call_add_rtt(struct rxrpc_call *call, enum rxrpc_rtt_rx_trace why,
+			int rtt_slot,
+			rxrpc_serial_t send_serial, rxrpc_serial_t resp_serial,
+			ktime_t send_time, ktime_t resp_time);
+ktime_t rxrpc_get_rto_backoff(struct rxrpc_call *call, bool retrans);
+void rxrpc_call_init_rtt(struct rxrpc_call *call);
 
 /*
  * rxkad.c
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 99d9502564cc..7af275544251 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -44,8 +44,8 @@ void rxrpc_propose_delay_ACK(struct rxrpc_call *call, rxrpc_serial_t serial,
 
 	trace_rxrpc_propose_ack(call, why, RXRPC_ACK_DELAY, serial);
 
-	if (call->peer->srtt_us)
-		delay = (call->peer->srtt_us >> 3) * NSEC_PER_USEC;
+	if (call->srtt_us)
+		delay = (call->srtt_us >> 3) * NSEC_PER_USEC;
 	else
 		delay = ms_to_ktime(READ_ONCE(rxrpc_soft_ack_delay));
 	ktime_add_ms(delay, call->tx_backoff);
@@ -105,7 +105,7 @@ void rxrpc_resend(struct rxrpc_call *call, rxrpc_serial_t ack_serial, bool ping_
 	};
 	struct rxrpc_txqueue *tq = call->tx_queue;
 	ktime_t lowest_xmit_ts = KTIME_MAX;
-	ktime_t rto = rxrpc_get_rto_backoff(call->peer, false);
+	ktime_t rto = rxrpc_get_rto_backoff(call, false);
 	bool unacked = false;
 
 	_enter("{%d,%d}", call->tx_bottom, call->tx_top);
@@ -195,7 +195,7 @@ void rxrpc_resend(struct rxrpc_call *call, rxrpc_serial_t ack_serial, bool ping_
 	} while ((tq = tq->next));
 
 	if (lowest_xmit_ts < KTIME_MAX) {
-		ktime_t delay = rxrpc_get_rto_backoff(call->peer, req.did_send);
+		ktime_t delay = rxrpc_get_rto_backoff(call, req.did_send);
 		ktime_t resend_at = ktime_add(lowest_xmit_ts, delay);
 
 		_debug("delay %llu %lld", delay, ktime_sub(resend_at, req.now));
@@ -216,7 +216,7 @@ void rxrpc_resend(struct rxrpc_call *call, rxrpc_serial_t ack_serial, bool ping_
 	 */
 	if (!req.did_send) {
 		ktime_t next_ping = ktime_add_us(call->acks_latest_ts,
-						 call->peer->srtt_us >> 3);
+						 call->srtt_us >> 3);
 
 		if (ktime_sub(next_ping, req.now) <= 0)
 			rxrpc_send_ACK(call, RXRPC_ACK_PING, 0,
@@ -366,8 +366,8 @@ static void rxrpc_transmit_some_data(struct rxrpc_call *call,
  */
 static void rxrpc_send_initial_ping(struct rxrpc_call *call)
 {
-	if (call->peer->rtt_count < 3 ||
-	    ktime_before(ktime_add_ms(call->peer->rtt_last_req, 1000),
+	if (call->rtt_count < 3 ||
+	    ktime_before(ktime_add_ms(call->rtt_last_req, 1000),
 			 ktime_get_real()))
 		rxrpc_send_ACK(call, RXRPC_ACK_PING, 0,
 			       rxrpc_propose_ack_ping_for_params);
@@ -499,10 +499,10 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
 			       rxrpc_propose_ack_rx_idle);
 
 	if (call->ackr_nr_unacked > 2) {
-		if (call->peer->rtt_count < 3)
+		if (call->rtt_count < 3)
 			rxrpc_send_ACK(call, RXRPC_ACK_PING, 0,
 				       rxrpc_propose_ack_ping_for_rtt);
-		else if (ktime_before(ktime_add_ms(call->peer->rtt_last_req, 1000),
+		else if (ktime_before(ktime_add_ms(call->rtt_last_req, 1000),
 				      ktime_get_real()))
 			rxrpc_send_ACK(call, RXRPC_ACK_PING, 0,
 				       rxrpc_propose_ack_ping_for_old_rtt);
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 75cd0b06e14c..fb4ee0d2e9e1 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -176,6 +176,8 @@ struct rxrpc_call *rxrpc_alloc_call(struct rxrpc_sock *rx, gfp_t gfp,
 	call->cong_cwnd = RXRPC_MIN_CWND;
 	call->cong_ssthresh = RXRPC_TX_MAX_WINDOW;
 
+	rxrpc_call_init_rtt(call);
+
 	call->rxnet = rxnet;
 	call->rtt_avail = RXRPC_CALL_RTT_AVAIL_MASK;
 	atomic_inc(&rxnet->nr_calls);
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 036cf440b63b..9f308bd512e9 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -71,11 +71,11 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 		/* We analyse the number of packets that get ACK'd per RTT
 		 * period and increase the window if we managed to fill it.
 		 */
-		if (call->peer->rtt_count == 0)
+		if (call->rtt_count == 0)
 			goto out;
 		if (ktime_before(call->acks_latest_ts,
 				 ktime_add_us(call->cong_tstamp,
-					      call->peer->srtt_us >> 3)))
+					      call->srtt_us >> 3)))
 			goto out_no_clear_ca;
 		summary->change = rxrpc_cong_rtt_window_end;
 		call->cong_tstamp = call->acks_latest_ts;
@@ -179,7 +179,7 @@ void rxrpc_congestion_degrade(struct rxrpc_call *call)
 	if (__rxrpc_call_state(call) == RXRPC_CALL_CLIENT_AWAIT_REPLY)
 		return;
 
-	rtt = ns_to_ktime(call->peer->srtt_us * (1000 / 8));
+	rtt = ns_to_ktime(call->srtt_us * (NSEC_PER_USEC / 8));
 	now = ktime_get_real();
 	if (!ktime_before(ktime_add(call->tx_last_sent, rtt), now))
 		return;
@@ -200,7 +200,7 @@ static void rxrpc_add_data_rtt_sample(struct rxrpc_call *call,
 				      struct rxrpc_txqueue *tq,
 				      int ix)
 {
-	rxrpc_peer_add_rtt(call, rxrpc_rtt_rx_data_ack, -1,
+	rxrpc_call_add_rtt(call, rxrpc_rtt_rx_data_ack, -1,
 			   summary->acked_serial, summary->ack_serial,
 			   ktime_add_us(tq->xmit_ts_base, tq->segment_xmit_ts[ix]),
 			   call->acks_latest_ts);
@@ -725,7 +725,7 @@ static void rxrpc_complete_rtt_probe(struct rxrpc_call *call,
 			clear_bit(i + RXRPC_CALL_RTT_PEND_SHIFT, &call->rtt_avail);
 			smp_mb(); /* Read data before setting avail bit */
 			set_bit(i, &call->rtt_avail);
-			rxrpc_peer_add_rtt(call, type, i, acked_serial, ack_serial,
+			rxrpc_call_add_rtt(call, type, i, acked_serial, ack_serial,
 					   sent_at, resp_time);
 			matched = true;
 		}
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 74c3ff55b482..ecaf3becee40 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -234,7 +234,7 @@ static int rxrpc_fill_out_ack(struct rxrpc_call *call, int nr_kv, u8 ack_reason,
 	if (ack_reason == RXRPC_ACK_PING)
 		rxrpc_begin_rtt_probe(call, *_ack_serial, now, rxrpc_rtt_tx_ping);
 	if (whdr->flags & RXRPC_REQUEST_ACK)
-		call->peer->rtt_last_req = now;
+		call->rtt_last_req = now;
 	rxrpc_set_keepalive(call, now);
 	return nr_kv;
 }
@@ -473,9 +473,9 @@ static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call,
 		why = rxrpc_reqack_slow_start;
 	else if (call->tx_winsize <= 2)
 		why = rxrpc_reqack_small_txwin;
-	else if (call->peer->rtt_count < 3 && txb->seq & 1)
+	else if (call->rtt_count < 3)
 		why = rxrpc_reqack_more_rtt;
-	else if (ktime_before(ktime_add_ms(call->peer->rtt_last_req, 1000), ktime_get_real()))
+	else if (ktime_before(ktime_add_ms(call->rtt_last_req, 1000), ktime_get_real()))
 		why = rxrpc_reqack_old_rtt;
 	else if (!last && !after(READ_ONCE(call->send_top), txb->seq))
 		why = rxrpc_reqack_app_stall;
@@ -487,7 +487,7 @@ static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call,
 	if (why != rxrpc_reqack_no_srv_last) {
 		flags |= RXRPC_REQUEST_ACK;
 		trace_rxrpc_rtt_tx(call, rxrpc_rtt_tx_data, -1, serial);
-		call->peer->rtt_last_req = req->now;
+		call->rtt_last_req = req->now;
 	}
 dont_set_request_ack:
 
@@ -576,8 +576,8 @@ static size_t rxrpc_prepare_data_packet(struct rxrpc_call *call, struct rxrpc_se
 	}
 
 	/* Set timeouts */
-	if (call->peer->rtt_count > 1) {
-		ktime_t delay = rxrpc_get_rto_backoff(call->peer, false);
+	if (call->rtt_count > 1) {
+		ktime_t delay = rxrpc_get_rto_backoff(call, false);
 
 		call->ack_lost_at = ktime_add(req->now, delay);
 		trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_lost_ack);
@@ -590,7 +590,7 @@ static size_t rxrpc_prepare_data_packet(struct rxrpc_call *call, struct rxrpc_se
 		trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_expect_rx);
 	}
 	if (call->resend_at == KTIME_MAX) {
-		ktime_t delay = rxrpc_get_rto_backoff(call->peer, false);
+		ktime_t delay = rxrpc_get_rto_backoff(call, false);
 
 		call->resend_at = ktime_add(req->now, delay);
 		trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_resend);
diff --git a/net/rxrpc/peer_object.c b/net/rxrpc/peer_object.c
index 27b34ed4d76a..e1c63129586b 100644
--- a/net/rxrpc/peer_object.c
+++ b/net/rxrpc/peer_object.c
@@ -235,12 +235,9 @@ struct rxrpc_peer *rxrpc_alloc_peer(struct rxrpc_local *local, gfp_t gfp,
 		peer->service_conns = RB_ROOT;
 		seqlock_init(&peer->service_conn_lock);
 		spin_lock_init(&peer->lock);
-		spin_lock_init(&peer->rtt_input_lock);
 		seqcount_init(&peer->mtu_lock);
 		peer->debug_id = atomic_inc_return(&rxrpc_debug_id);
-
-		rxrpc_peer_init_rtt(peer);
-
+		peer->recent_srtt_us = UINT_MAX;
 		peer->cong_ssthresh = RXRPC_TX_MAX_WINDOW;
 		trace_rxrpc_peer(peer->debug_id, 1, why);
 	}
@@ -283,8 +280,6 @@ static void rxrpc_init_peer(struct rxrpc_local *local, struct rxrpc_peer *peer,
 	peer->max_data = peer->if_mtu - peer->hdrsize;
 
 	rxrpc_assess_MTU_size(local, peer);
-
-	peer->rtt_last_req = ktime_get_real();
 }
 
 /*
@@ -496,7 +491,7 @@ EXPORT_SYMBOL(rxrpc_kernel_get_call_peer);
  */
 unsigned int rxrpc_kernel_get_srtt(const struct rxrpc_peer *peer)
 {
-	return peer->rtt_count > 0 ? peer->srtt_us >> 3 : UINT_MAX;
+	return READ_ONCE(peer->recent_srtt_us);
 }
 EXPORT_SYMBOL(rxrpc_kernel_get_srtt);
 
diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index 5f974ec13d69..d803562ca0ac 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -296,15 +296,15 @@ static int rxrpc_peer_seq_show(struct seq_file *seq, void *v)
 
 	now = ktime_get_seconds();
 	seq_printf(seq,
-		   "UDP   %-47.47s %-47.47s %3u %4u %5u %6llus %8u %8u\n",
+		   "UDP   %-47.47s %-47.47s %3u %4u %5u %6llus %8d %8d\n",
 		   lbuff,
 		   rbuff,
 		   refcount_read(&peer->ref),
 		   peer->cong_ssthresh,
 		   peer->max_data,
 		   now - peer->last_tx_at,
-		   peer->srtt_us >> 3,
-		   peer->rto_us);
+		   READ_ONCE(peer->recent_srtt_us),
+		   READ_ONCE(peer->recent_rto_us));
 
 	return 0;
 }
diff --git a/net/rxrpc/rtt.c b/net/rxrpc/rtt.c
index aff75e168de8..7474f88d7b18 100644
--- a/net/rxrpc/rtt.c
+++ b/net/rxrpc/rtt.c
@@ -15,14 +15,14 @@
 #define RXRPC_TIMEOUT_INIT ((unsigned int)(1 * USEC_PER_SEC)) /* RFC6298 2.1 initial RTO value */
 #define rxrpc_jiffies32 ((u32)jiffies)		/* As rxrpc_jiffies32 */
 
-static u32 rxrpc_rto_min_us(struct rxrpc_peer *peer)
+static u32 rxrpc_rto_min_us(struct rxrpc_call *call)
 {
 	return 200;
 }
 
-static u32 __rxrpc_set_rto(const struct rxrpc_peer *peer)
+static u32 __rxrpc_set_rto(const struct rxrpc_call *call)
 {
-	return (peer->srtt_us >> 3) + peer->rttvar_us;
+	return (call->srtt_us >> 3) + call->rttvar_us;
 }
 
 static u32 rxrpc_bound_rto(u32 rto)
@@ -40,10 +40,10 @@ static u32 rxrpc_bound_rto(u32 rto)
  * To save cycles in the RFC 1323 implementation it was better to break
  * it up into three procedures. -- erics
  */
-static void rxrpc_rtt_estimator(struct rxrpc_peer *peer, long sample_rtt_us)
+static void rxrpc_rtt_estimator(struct rxrpc_call *call, long sample_rtt_us)
 {
 	long m = sample_rtt_us; /* RTT */
-	u32 srtt = peer->srtt_us;
+	u32 srtt = call->srtt_us;
 
 	/*	The following amusing code comes from Jacobson's
 	 *	article in SIGCOMM '88.  Note that rtt and mdev
@@ -66,7 +66,7 @@ static void rxrpc_rtt_estimator(struct rxrpc_peer *peer, long sample_rtt_us)
 		srtt += m;		/* rtt = 7/8 rtt + 1/8 new */
 		if (m < 0) {
 			m = -m;		/* m is now abs(error) */
-			m -= (peer->mdev_us >> 2);   /* similar update on mdev */
+			m -= (call->mdev_us >> 2);   /* similar update on mdev */
 			/* This is similar to one of Eifel findings.
 			 * Eifel blocks mdev updates when rtt decreases.
 			 * This solution is a bit different: we use finer gain
@@ -78,31 +78,31 @@ static void rxrpc_rtt_estimator(struct rxrpc_peer *peer, long sample_rtt_us)
 			if (m > 0)
 				m >>= 3;
 		} else {
-			m -= (peer->mdev_us >> 2);   /* similar update on mdev */
+			m -= (call->mdev_us >> 2);   /* similar update on mdev */
 		}
 
-		peer->mdev_us += m;		/* mdev = 3/4 mdev + 1/4 new */
-		if (peer->mdev_us > peer->mdev_max_us) {
-			peer->mdev_max_us = peer->mdev_us;
-			if (peer->mdev_max_us > peer->rttvar_us)
-				peer->rttvar_us = peer->mdev_max_us;
+		call->mdev_us += m;		/* mdev = 3/4 mdev + 1/4 new */
+		if (call->mdev_us > call->mdev_max_us) {
+			call->mdev_max_us = call->mdev_us;
+			if (call->mdev_max_us > call->rttvar_us)
+				call->rttvar_us = call->mdev_max_us;
 		}
 	} else {
 		/* no previous measure. */
 		srtt = m << 3;		/* take the measured time to be rtt */
-		peer->mdev_us = m << 1;	/* make sure rto = 3*rtt */
-		peer->rttvar_us = umax(peer->mdev_us, rxrpc_rto_min_us(peer));
-		peer->mdev_max_us = peer->rttvar_us;
+		call->mdev_us = m << 1;	/* make sure rto = 3*rtt */
+		call->rttvar_us = umax(call->mdev_us, rxrpc_rto_min_us(call));
+		call->mdev_max_us = call->rttvar_us;
 	}
 
-	peer->srtt_us = umax(srtt, 1);
+	call->srtt_us = umax(srtt, 1);
 }
 
 /*
  * Calculate rto without backoff.  This is the second half of Van Jacobson's
  * routine referred to above.
  */
-static void rxrpc_set_rto(struct rxrpc_peer *peer)
+static void rxrpc_set_rto(struct rxrpc_call *call)
 {
 	u32 rto;
 
@@ -113,7 +113,7 @@ static void rxrpc_set_rto(struct rxrpc_peer *peer)
 	 *    is invisible. Actually, Linux-2.4 also generates erratic
 	 *    ACKs in some circumstances.
 	 */
-	rto = __rxrpc_set_rto(peer);
+	rto = __rxrpc_set_rto(call);
 
 	/* 2. Fixups made earlier cannot be right.
 	 *    If we do not estimate RTO correctly without them,
@@ -124,73 +124,73 @@ static void rxrpc_set_rto(struct rxrpc_peer *peer)
 	/* NOTE: clamping at RXRPC_RTO_MIN is not required, current algo
 	 * guarantees that rto is higher.
 	 */
-	peer->rto_us = rxrpc_bound_rto(rto);
+	call->rto_us = rxrpc_bound_rto(rto);
 }
 
-static void rxrpc_update_rtt_min(struct rxrpc_peer *peer, ktime_t resp_time, long rtt_us)
+static void rxrpc_update_rtt_min(struct rxrpc_call *call, ktime_t resp_time, long rtt_us)
 {
 	/* Window size 5mins in approx usec (ipv4.sysctl_tcp_min_rtt_wlen) */
 	u32 wlen_us = 5ULL * NSEC_PER_SEC / 1024;
 
-	minmax_running_min(&peer->min_rtt, wlen_us, resp_time / 1024,
+	minmax_running_min(&call->min_rtt, wlen_us, resp_time / 1024,
 			   (u32)rtt_us ? : jiffies_to_usecs(1));
 }
 
-static void rxrpc_ack_update_rtt(struct rxrpc_peer *peer, ktime_t resp_time, long rtt_us)
+static void rxrpc_ack_update_rtt(struct rxrpc_call *call, ktime_t resp_time, long rtt_us)
 {
 	if (rtt_us < 0)
 		return;
 
 	/* Update RACK min RTT [RFC8985 6.1 Step 1]. */
-	rxrpc_update_rtt_min(peer, resp_time, rtt_us);
+	rxrpc_update_rtt_min(call, resp_time, rtt_us);
 
-	rxrpc_rtt_estimator(peer, rtt_us);
-	rxrpc_set_rto(peer);
+	rxrpc_rtt_estimator(call, rtt_us);
+	rxrpc_set_rto(call);
 
 	/* Only reset backoff on valid RTT measurement [RFC6298]. */
-	peer->backoff = 0;
+	call->backoff = 0;
 }
 
 /*
  * Add RTT information to cache.  This is called in softirq mode and has
- * exclusive access to the peer RTT data.
+ * exclusive access to the call RTT data.
  */
-void rxrpc_peer_add_rtt(struct rxrpc_call *call, enum rxrpc_rtt_rx_trace why,
+void rxrpc_call_add_rtt(struct rxrpc_call *call, enum rxrpc_rtt_rx_trace why,
 			int rtt_slot,
 			rxrpc_serial_t send_serial, rxrpc_serial_t resp_serial,
 			ktime_t send_time, ktime_t resp_time)
 {
-	struct rxrpc_peer *peer = call->peer;
 	s64 rtt_us;
 
 	rtt_us = ktime_to_us(ktime_sub(resp_time, send_time));
 	if (rtt_us < 0)
 		return;
 
-	spin_lock(&peer->rtt_input_lock);
-	rxrpc_ack_update_rtt(peer, resp_time, rtt_us);
-	if (peer->rtt_count < 3)
-		peer->rtt_count++;
-	peer->rtt_taken++;
-	spin_unlock(&peer->rtt_input_lock);
+	rxrpc_ack_update_rtt(call, resp_time, rtt_us);
+	if (call->rtt_count < 3)
+		call->rtt_count++;
+	call->rtt_taken++;
+
+	WRITE_ONCE(call->peer->recent_srtt_us, call->srtt_us / 8);
+	WRITE_ONCE(call->peer->recent_rto_us, call->rto_us);
 
 	trace_rxrpc_rtt_rx(call, why, rtt_slot, send_serial, resp_serial,
-			   rtt_us, peer->srtt_us, peer->rto_us);
+			   rtt_us, call->srtt_us, call->rto_us);
 }
 
 /*
  * Get the retransmission timeout to set in nanoseconds, backing it off each
  * time we retransmit.
  */
-ktime_t rxrpc_get_rto_backoff(struct rxrpc_peer *peer, bool retrans)
+ktime_t rxrpc_get_rto_backoff(struct rxrpc_call *call, bool retrans)
 {
 	u64 timo_us;
-	u32 backoff = READ_ONCE(peer->backoff);
+	u32 backoff = READ_ONCE(call->backoff);
 
-	timo_us = peer->rto_us;
+	timo_us = call->rto_us;
 	timo_us <<= backoff;
 	if (retrans && timo_us * 2 <= RXRPC_RTO_MAX)
-		WRITE_ONCE(peer->backoff, backoff + 1);
+		WRITE_ONCE(call->backoff, backoff + 1);
 
 	if (timo_us < 1)
 		timo_us = 1;
@@ -198,10 +198,11 @@ ktime_t rxrpc_get_rto_backoff(struct rxrpc_peer *peer, bool retrans)
 	return ns_to_ktime(timo_us * NSEC_PER_USEC);
 }
 
-void rxrpc_peer_init_rtt(struct rxrpc_peer *peer)
+void rxrpc_call_init_rtt(struct rxrpc_call *call)
 {
-	peer->rto_us	= RXRPC_TIMEOUT_INIT;
-	peer->mdev_us	= RXRPC_TIMEOUT_INIT;
-	peer->backoff	= 0;
-	//minmax_reset(&peer->rtt_min, rxrpc_jiffies32, ~0U);
+	call->rtt_last_req = KTIME_MIN;
+	call->rto_us	= RXRPC_TIMEOUT_INIT;
+	call->mdev_us	= RXRPC_TIMEOUT_INIT;
+	call->backoff	= 0;
+	//minmax_reset(&call->rtt_min, rxrpc_jiffies32, ~0U);
 }
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index df501a7c92fa..c4c8b718cafa 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -134,7 +134,7 @@ static int rxrpc_wait_for_tx_window_waitall(struct rxrpc_sock *rx,
 	rxrpc_seq_t tx_start, tx_win;
 	signed long rtt, timeout;
 
-	rtt = READ_ONCE(call->peer->srtt_us) >> 3;
+	rtt = READ_ONCE(call->srtt_us) >> 3;
 	rtt = usecs_to_jiffies(rtt) * 2;
 	if (rtt < 2)
 		rtt = 2;


