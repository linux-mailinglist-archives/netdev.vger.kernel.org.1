Return-Path: <netdev+bounces-77707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95564872B7E
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 01:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94E81C21870
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 00:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5B6179B2;
	Wed,  6 Mar 2024 00:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWlHgUMK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DFD12E6A
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 00:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709683635; cv=none; b=ia7+C/wMmgqIFu77YmYTuHD2ZAjuCtirfBSfxxHKTMMIUlXm9o84XWkiQp/fl1o9wB+BuvD/NjFfbct7dI/9qZtjebEfH3mMLKhaYfFHPBvBATpNMmwSgkMI34lWZ9fDfSA0lO4Uws1g15jOiaIraySAhw11BzeIVv+7hz8umXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709683635; c=relaxed/simple;
	bh=MQ2ZFjtue/mlbT3gPUeVjpfqMS/NxZ1JCX8pts1RXQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hm39OQBrXWR7tFa29NKYjhgGHksAUjBGXDvcVBLw9fFVYfdZPYvKDJG91fzKaaC0hKCsLXPqYCu5AsGlzuOWwQZ9agl6n6yxfuymJotpzK6ij3sFuLQ8Q2lkY3pxUAJZBiW7RUTzaLAbyYIjFyLA4keNTIz6P06SbP0Oh9S1V04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eWlHgUMK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709683633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ccm9SVhd+bAluRvWjYsOnhrUMg2QaaHeYK4kvnT54uM=;
	b=eWlHgUMKivbtSpEnlVxXb2RGL0X+frmTjjp75dfCanu/az0RbSCzOpK2kCNAKMXxMknYEi
	7l/9zFpf5Yv3rg9Od25ellqv4aJuQe5xmwt9fKwD5yi8o0ahovvMs0j71jocz0cHTM5Bp+
	K2R9HdmE7kYGObItCazyLvPHbPzq/fk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-ELytR4K7O3CYR-lvPKjhvg-1; Tue, 05 Mar 2024 19:07:11 -0500
X-MC-Unique: ELytR4K7O3CYR-lvPKjhvg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D9798007AD;
	Wed,  6 Mar 2024 00:07:11 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B83A616A9B;
	Wed,  6 Mar 2024 00:07:09 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 05/21] rxrpc: Strip barriers and atomics off of timer tracking
Date: Wed,  6 Mar 2024 00:06:35 +0000
Message-ID: <20240306000655.1100294-6-dhowells@redhat.com>
In-Reply-To: <20240306000655.1100294-1-dhowells@redhat.com>
References: <20240306000655.1100294-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Strip the atomic ops and barriering off of the call timer tracking as this
is handled solely within the I/O thread, except for expect_term_by which is
set by sendmsg().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/call_event.c  | 32 ++++++++++++++++----------------
 net/rxrpc/conn_client.c |  4 ++--
 net/rxrpc/input.c       | 15 ++++++---------
 net/rxrpc/output.c      | 18 ++++++++----------
 4 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 77eacbfc5d45..84eedbb49fcb 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -27,7 +27,7 @@ void rxrpc_propose_ping(struct rxrpc_call *call, u32 serial,
 	unsigned long ping_at = now + rxrpc_idle_ack_delay;
 
 	if (time_before(ping_at, call->ping_at)) {
-		WRITE_ONCE(call->ping_at, ping_at);
+		call->ping_at = ping_at;
 		rxrpc_reduce_call_timer(call, ping_at, now,
 					rxrpc_timer_set_for_ping);
 		trace_rxrpc_propose_ack(call, why, RXRPC_ACK_PING, serial);
@@ -53,7 +53,7 @@ void rxrpc_propose_delay_ACK(struct rxrpc_call *call, rxrpc_serial_t serial,
 	ack_at += READ_ONCE(call->tx_backoff);
 	ack_at += now;
 	if (time_before(ack_at, call->delay_ack_at)) {
-		WRITE_ONCE(call->delay_ack_at, ack_at);
+		call->delay_ack_at = ack_at;
 		rxrpc_reduce_call_timer(call, ack_at, now,
 					rxrpc_timer_set_for_ack);
 	}
@@ -220,7 +220,7 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 	resend_at = nsecs_to_jiffies(ktime_to_ns(ktime_sub(now, oldest)));
 	resend_at += jiffies + rxrpc_get_rto_backoff(call->peer,
 						     !list_empty(&retrans_queue));
-	WRITE_ONCE(call->resend_at, resend_at);
+	call->resend_at = resend_at;
 
 	if (unacked)
 		rxrpc_congestion_timeout(call);
@@ -260,7 +260,7 @@ static void rxrpc_begin_service_reply(struct rxrpc_call *call)
 	unsigned long now = jiffies;
 
 	rxrpc_set_call_state(call, RXRPC_CALL_SERVER_SEND_REPLY);
-	WRITE_ONCE(call->delay_ack_at, now + MAX_JIFFY_OFFSET);
+	call->delay_ack_at = now + MAX_JIFFY_OFFSET;
 	if (call->ackr_reason == RXRPC_ACK_DELAY)
 		call->ackr_reason = 0;
 	trace_rxrpc_timer(call, rxrpc_timer_init_for_send_reply, now);
@@ -399,13 +399,13 @@ bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 
 	/* If we see our async-event poke, check for timeout trippage. */
 	now = jiffies;
-	t = READ_ONCE(call->expect_rx_by);
+	t = call->expect_rx_by;
 	if (time_after_eq(now, t)) {
 		trace_rxrpc_timer(call, rxrpc_timer_exp_normal, now);
 		expired = true;
 	}
 
-	t = READ_ONCE(call->expect_req_by);
+	t = call->expect_req_by;
 	if (__rxrpc_call_state(call) == RXRPC_CALL_SERVER_RECV_REQUEST &&
 	    time_after_eq(now, t)) {
 		trace_rxrpc_timer(call, rxrpc_timer_exp_idle, now);
@@ -418,41 +418,41 @@ bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 		expired = true;
 	}
 
-	t = READ_ONCE(call->delay_ack_at);
+	t = call->delay_ack_at;
 	if (time_after_eq(now, t)) {
 		trace_rxrpc_timer(call, rxrpc_timer_exp_ack, now);
-		cmpxchg(&call->delay_ack_at, t, now + MAX_JIFFY_OFFSET);
+		call->delay_ack_at = now + MAX_JIFFY_OFFSET;
 		rxrpc_send_ACK(call, RXRPC_ACK_DELAY, 0,
 			       rxrpc_propose_ack_ping_for_lost_ack);
 	}
 
-	t = READ_ONCE(call->ack_lost_at);
+	t = call->ack_lost_at;
 	if (time_after_eq(now, t)) {
 		trace_rxrpc_timer(call, rxrpc_timer_exp_lost_ack, now);
-		cmpxchg(&call->ack_lost_at, t, now + MAX_JIFFY_OFFSET);
+		call->ack_lost_at = now + MAX_JIFFY_OFFSET;
 		set_bit(RXRPC_CALL_EV_ACK_LOST, &call->events);
 	}
 
-	t = READ_ONCE(call->keepalive_at);
+	t = call->keepalive_at;
 	if (time_after_eq(now, t)) {
 		trace_rxrpc_timer(call, rxrpc_timer_exp_keepalive, now);
-		cmpxchg(&call->keepalive_at, t, now + MAX_JIFFY_OFFSET);
+		call->keepalive_at = now + MAX_JIFFY_OFFSET;
 		rxrpc_send_ACK(call, RXRPC_ACK_PING, 0,
 			       rxrpc_propose_ack_ping_for_keepalive);
 	}
 
-	t = READ_ONCE(call->ping_at);
+	t = call->ping_at;
 	if (time_after_eq(now, t)) {
 		trace_rxrpc_timer(call, rxrpc_timer_exp_ping, now);
-		cmpxchg(&call->ping_at, t, now + MAX_JIFFY_OFFSET);
+		call->ping_at = now + MAX_JIFFY_OFFSET;
 		rxrpc_send_ACK(call, RXRPC_ACK_PING, 0,
 			       rxrpc_propose_ack_ping_for_keepalive);
 	}
 
-	t = READ_ONCE(call->resend_at);
+	t = call->resend_at;
 	if (time_after_eq(now, t)) {
 		trace_rxrpc_timer(call, rxrpc_timer_exp_resend, now);
-		cmpxchg(&call->resend_at, t, now + MAX_JIFFY_OFFSET);
+		call->resend_at = now + MAX_JIFFY_OFFSET;
 		resend = true;
 	}
 
diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index 3b9b267a4431..d25bf1cf3670 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -636,7 +636,7 @@ void rxrpc_disconnect_client_call(struct rxrpc_bundle *bundle, struct rxrpc_call
 	    test_bit(RXRPC_CALL_EXPOSED, &call->flags)) {
 		unsigned long final_ack_at = jiffies + 2;
 
-		WRITE_ONCE(chan->final_ack_at, final_ack_at);
+		chan->final_ack_at = final_ack_at;
 		smp_wmb(); /* vs rxrpc_process_delayed_final_acks() */
 		set_bit(RXRPC_CONN_FINAL_ACK_0 + channel, &conn->flags);
 		rxrpc_reduce_conn_timer(conn, final_ack_at);
@@ -770,7 +770,7 @@ void rxrpc_discard_expired_client_conns(struct rxrpc_local *local)
 
 		conn_expires_at = conn->idle_timestamp + expiry;
 
-		now = READ_ONCE(jiffies);
+		now = jiffies;
 		if (time_after(conn_expires_at, now))
 			goto not_yet_expired;
 	}
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index ea2df62e05e7..e53a49accc16 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -288,14 +288,12 @@ static void rxrpc_end_tx_phase(struct rxrpc_call *call, bool reply_begun,
 static bool rxrpc_receiving_reply(struct rxrpc_call *call)
 {
 	struct rxrpc_ack_summary summary = { 0 };
-	unsigned long now, timo;
+	unsigned long now;
 	rxrpc_seq_t top = READ_ONCE(call->tx_top);
 
 	if (call->ackr_reason) {
 		now = jiffies;
-		timo = now + MAX_JIFFY_OFFSET;
-
-		WRITE_ONCE(call->delay_ack_at, timo);
+		call->delay_ack_at = now + MAX_JIFFY_OFFSET;
 		trace_rxrpc_timer(call, rxrpc_timer_init_for_reply, now);
 	}
 
@@ -594,7 +592,7 @@ static void rxrpc_input_data(struct rxrpc_call *call, struct sk_buff *skb)
 		if (timo) {
 			now = jiffies;
 			expect_req_by = now + timo;
-			WRITE_ONCE(call->expect_req_by, expect_req_by);
+			call->expect_req_by = now + timo;
 			rxrpc_reduce_call_timer(call, expect_req_by, now,
 						rxrpc_timer_set_for_idle);
 		}
@@ -1048,11 +1046,10 @@ void rxrpc_input_call_packet(struct rxrpc_call *call, struct sk_buff *skb)
 
 	timo = READ_ONCE(call->next_rx_timo);
 	if (timo) {
-		unsigned long now = jiffies, expect_rx_by;
+		unsigned long now = jiffies;
 
-		expect_rx_by = now + timo;
-		WRITE_ONCE(call->expect_rx_by, expect_rx_by);
-		rxrpc_reduce_call_timer(call, expect_rx_by, now,
+		call->expect_rx_by = now + timo;
+		rxrpc_reduce_call_timer(call, call->expect_rx_by, now,
 					rxrpc_timer_set_for_normal);
 	}
 
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 3803bf900a46..2386b01b2231 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -67,11 +67,10 @@ static void rxrpc_tx_backoff(struct rxrpc_call *call, int ret)
  */
 static void rxrpc_set_keepalive(struct rxrpc_call *call)
 {
-	unsigned long now = jiffies, keepalive_at = call->next_rx_timo / 6;
+	unsigned long now = jiffies;
 
-	keepalive_at += now;
-	WRITE_ONCE(call->keepalive_at, keepalive_at);
-	rxrpc_reduce_call_timer(call, keepalive_at, now,
+	call->keepalive_at = now + call->next_rx_timo / 6;
+	rxrpc_reduce_call_timer(call, call->keepalive_at, now,
 				rxrpc_timer_set_for_keepalive);
 }
 
@@ -449,7 +448,7 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 
 				ack_lost_at = rxrpc_get_rto_backoff(call->peer, false);
 				ack_lost_at += nowj;
-				WRITE_ONCE(call->ack_lost_at, ack_lost_at);
+				call->ack_lost_at = ack_lost_at;
 				rxrpc_reduce_call_timer(call, ack_lost_at, nowj,
 							rxrpc_timer_set_for_lost_ack);
 			}
@@ -458,11 +457,10 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 		if (txb->seq == 1 &&
 		    !test_and_set_bit(RXRPC_CALL_BEGAN_RX_TIMER,
 				      &call->flags)) {
-			unsigned long nowj = jiffies, expect_rx_by;
+			unsigned long nowj = jiffies;
 
-			expect_rx_by = nowj + call->next_rx_timo;
-			WRITE_ONCE(call->expect_rx_by, expect_rx_by);
-			rxrpc_reduce_call_timer(call, expect_rx_by, nowj,
+			call->expect_rx_by = nowj + call->next_rx_timo;
+			rxrpc_reduce_call_timer(call, call->expect_rx_by, nowj,
 						rxrpc_timer_set_for_normal);
 		}
 
@@ -724,7 +722,7 @@ void rxrpc_transmit_one(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 		unsigned long now = jiffies;
 		unsigned long resend_at = now + call->peer->rto_j;
 
-		WRITE_ONCE(call->resend_at, resend_at);
+		call->resend_at = resend_at;
 		rxrpc_reduce_call_timer(call, resend_at, now,
 					rxrpc_timer_set_for_send);
 	}


