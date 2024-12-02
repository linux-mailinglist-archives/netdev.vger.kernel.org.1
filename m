Return-Path: <netdev+bounces-148085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834499E0564
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3CC816815F
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780C520CCC5;
	Mon,  2 Dec 2024 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYhz+uIo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E653F20C02A
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149944; cv=none; b=pBwH6zPGgfctdXl6yxRf8FYRwqwcJV07y018MB1515luU2f7NfJcUW1iKzLcWS5kFWZ1qkE1WytyTcfp0PHhVj3nSQvu/u8Ox1/qNtgCXL43WV6hwys+PCCWC15Yh7qpvanFStI5hGNAVMfnFzkoBHD4/aZ2qJA7OzmrXxT9Sx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149944; c=relaxed/simple;
	bh=rUzMMJPzPZIIGgL8z6dbdv17oHDc9trx6RlpBDJ6kFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfEs5/XzwaRgfCJBtvihNU36z0bvLevu1/mgBTRuQbTYpU7TcYPZCA1gADKwfY3UizkxSF7gWYkAgbyLE+tCSAKd1uvGq1hWO18FNoxk6C4xodnU/4XFxrKZ1x7adFSb8EUYN6c/H1kRWLlSYBADj2L9bzb9Dbdqa7U1WJihHPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cYhz+uIo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733149940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aTLx3un4v/BXGVp78WirV769FO+OD2W0LOlqUzS7mYY=;
	b=cYhz+uIompidmFzqjeZ4Nar0jCvCfGFW+9n8NWcyC95v5K0+91zO34Q1YvRJL/iXMPdbys
	7Cm+M3bjcnnPGHz7dGQuuDgHRRbv97tRKZ5SP6vsOksgRNb2nF+rGdtFLvliovjEU6BYL9
	kuv6uZgzX0rjQOvgiYT18V4Bdv1ypTk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-SxtGrQ-PPtipOcLwP49n4Q-1; Mon,
 02 Dec 2024 09:32:17 -0500
X-MC-Unique: SxtGrQ-PPtipOcLwP49n4Q-1
X-Mimecast-MFC-AGG-ID: SxtGrQ-PPtipOcLwP49n4Q
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5525C193722E;
	Mon,  2 Dec 2024 14:32:14 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CA43830000DF;
	Mon,  2 Dec 2024 14:32:11 +0000 (UTC)
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
Subject: [PATCH net-next 17/37] rxrpc: call->acks_hard_ack is now the same call->tx_bottom, so remove it
Date: Mon,  2 Dec 2024 14:30:35 +0000
Message-ID: <20241202143057.378147-18-dhowells@redhat.com>
In-Reply-To: <20241202143057.378147-1-dhowells@redhat.com>
References: <20241202143057.378147-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Now that packets are removed from the Tx queue in the rotation function
rather than being cleaned up later, call->acks_hard_ack now advances in
step with call->tx_bottom, so remove it.

Some of the places call->acks_hard_ack is used in the rxrpc tracepoints are
replaced by call->acks_first_seq instead as that's the peer's reported idea
of the hard-ACK point.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h | 20 ++++++++++----------
 net/rxrpc/ar-internal.h      |  1 -
 net/rxrpc/call_event.c       |  4 ++--
 net/rxrpc/input.c            | 17 ++++++++---------
 net/rxrpc/proc.c             |  6 +++---
 net/rxrpc/sendmsg.c          |  6 +++---
 6 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index e6cf9ec940aa..0f253287de00 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -892,8 +892,8 @@ TRACE_EVENT(rxrpc_txqueue,
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		call)
 		    __field(enum rxrpc_txqueue_trace,	why)
-		    __field(rxrpc_seq_t,		acks_hard_ack)
 		    __field(rxrpc_seq_t,		tx_bottom)
+		    __field(rxrpc_seq_t,		acks_first_seq)
 		    __field(rxrpc_seq_t,		tx_top)
 		    __field(rxrpc_seq_t,		send_top)
 		    __field(int,			tx_winsize)
@@ -902,8 +902,8 @@ TRACE_EVENT(rxrpc_txqueue,
 	    TP_fast_assign(
 		    __entry->call = call->debug_id;
 		    __entry->why = why;
-		    __entry->acks_hard_ack = call->acks_hard_ack;
 		    __entry->tx_bottom = call->tx_bottom;
+		    __entry->acks_first_seq = call->acks_first_seq;
 		    __entry->tx_top = call->tx_top;
 		    __entry->send_top = call->send_top;
 		    __entry->tx_winsize = call->tx_winsize;
@@ -913,9 +913,9 @@ TRACE_EVENT(rxrpc_txqueue,
 		      __entry->call,
 		      __print_symbolic(__entry->why, rxrpc_txqueue_traces),
 		      __entry->tx_bottom,
-		      __entry->acks_hard_ack,
-		      __entry->tx_top - __entry->tx_bottom,
-		      __entry->tx_top - __entry->acks_hard_ack,
+		      __entry->acks_first_seq,
+		      __entry->acks_first_seq - __entry->tx_bottom,
+		      __entry->tx_top - __entry->acks_first_seq,
 		      __entry->send_top - __entry->tx_top,
 		      __entry->tx_winsize)
 	    );
@@ -945,7 +945,7 @@ TRACE_EVENT(rxrpc_transmit,
 		    __entry->cong_cwnd	= call->cong_cwnd;
 		    __entry->cong_extra	= call->cong_extra;
 		    __entry->prepared	= send_top - call->tx_bottom;
-		    __entry->in_flight	= call->tx_top - call->acks_hard_ack;
+		    __entry->in_flight	= call->tx_top - call->tx_bottom;
 		    __entry->pmtud_jumbo = call->peer->pmtud_jumbo;
 			   ),
 
@@ -1707,7 +1707,7 @@ TRACE_EVENT(rxrpc_congest,
 	    TP_fast_assign(
 		    __entry->call	= call->debug_id;
 		    __entry->change	= change;
-		    __entry->hard_ack	= call->acks_hard_ack;
+		    __entry->hard_ack	= call->acks_first_seq;
 		    __entry->top	= call->tx_top;
 		    __entry->lowest_nak	= call->acks_lowest_nak;
 		    __entry->ack_serial	= ack_serial;
@@ -1754,7 +1754,7 @@ TRACE_EVENT(rxrpc_reset_cwnd,
 		    __entry->mode	= call->cong_mode;
 		    __entry->cwnd	= call->cong_cwnd;
 		    __entry->extra	= call->cong_extra;
-		    __entry->hard_ack	= call->acks_hard_ack;
+		    __entry->hard_ack	= call->acks_first_seq;
 		    __entry->prepared	= call->send_top - call->tx_bottom;
 		    __entry->since_last_tx = ktime_sub(now, call->tx_last_sent);
 		    __entry->has_data	= call->tx_bottom != call->tx_top;
@@ -1855,7 +1855,7 @@ TRACE_EVENT(rxrpc_resend,
 	    TP_fast_assign(
 		    struct rxrpc_skb_priv *sp = ack ? rxrpc_skb(ack) : NULL;
 		    __entry->call = call->debug_id;
-		    __entry->seq = call->acks_hard_ack;
+		    __entry->seq = call->acks_first_seq;
 		    __entry->transmitted = call->tx_transmitted;
 		    __entry->ack_serial = sp ? sp->hdr.serial : 0;
 			   ),
@@ -1944,7 +1944,7 @@ TRACE_EVENT(rxrpc_call_reset,
 		    __entry->call_id = call->call_id;
 		    __entry->call_serial = call->rx_serial;
 		    __entry->conn_serial = call->conn->hi_serial;
-		    __entry->tx_seq = call->acks_hard_ack;
+		    __entry->tx_seq = call->acks_first_seq;
 		    __entry->rx_seq = call->rx_highest_seq;
 			   ),
 
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index bcce4862b0b7..6683043cee3f 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -759,7 +759,6 @@ struct rxrpc_call {
 	ktime_t			acks_latest_ts;	/* Timestamp of latest ACK received */
 	rxrpc_seq_t		acks_first_seq;	/* first sequence number received */
 	rxrpc_seq_t		acks_prev_seq;	/* Highest previousPacket received */
-	rxrpc_seq_t		acks_hard_ack;	/* Latest hard-ack point */
 	rxrpc_seq_t		acks_lowest_nak; /* Lowest NACK in the buffer (or ==tx_hard_ack) */
 	rxrpc_serial_t		acks_highest_serial; /* Highest serial number ACK'd */
 };
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index c97b85f34e4f..866d415801a9 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -109,7 +109,7 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 	bool unacked = false, did_send = false;
 	unsigned int qix;
 
-	_enter("{%d,%d}", call->acks_hard_ack, call->tx_top);
+	_enter("{%d,%d}", call->tx_bottom, call->tx_top);
 
 	if (call->tx_bottom == call->tx_top)
 		goto no_resend;
@@ -267,7 +267,7 @@ static void rxrpc_close_tx_phase(struct rxrpc_call *call)
 static unsigned int rxrpc_tx_window_space(struct rxrpc_call *call)
 {
 	int winsize = umin(call->tx_winsize, call->cong_cwnd + call->cong_extra);
-	int in_flight = call->tx_top - call->acks_hard_ack;
+	int in_flight = call->tx_top - call->tx_bottom;
 
 	return max(winsize - in_flight, 0);
 }
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 03fd11a9bd31..b9fec74626eb 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -40,7 +40,7 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 	bool resend = false;
 
 	summary->flight_size =
-		(call->tx_top - call->acks_hard_ack) - summary->nr_acks;
+		(call->tx_top - call->tx_bottom) - summary->nr_acks;
 
 	if (test_and_clear_bit(RXRPC_CALL_RETRANS_TIMEOUT, &call->flags)) {
 		summary->retrans_timeo = true;
@@ -175,7 +175,7 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 	 * state.
 	 */
 	if (test_bit(RXRPC_CALL_TX_LAST, &call->flags) ||
-	    summary->nr_acks != call->tx_top - call->acks_hard_ack) {
+	    summary->nr_acks != call->tx_top - call->tx_bottom) {
 		call->cong_extra++;
 		wake_up(&call->waitq);
 	}
@@ -218,7 +218,7 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 	rxrpc_seq_t seq = call->tx_bottom + 1;
 	bool rot_last = false;
 
-	_enter("%x,%x,%x", call->tx_bottom, call->acks_hard_ack, to);
+	_enter("%x,%x", call->tx_bottom, to);
 
 	trace_rxrpc_tx_rotate(call, seq, to);
 	trace_rxrpc_tq(call, tq, seq, rxrpc_tq_rotate);
@@ -246,7 +246,6 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 		tq->bufs[ix] = NULL;
 
 		smp_store_release(&call->tx_bottom, seq);
-		smp_store_release(&call->acks_hard_ack, seq);
 		trace_rxrpc_txqueue(call, (rot_last ?
 					   rxrpc_txqueue_rotate_last :
 					   rxrpc_txqueue_rotate));
@@ -278,9 +277,9 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 		}
 	}
 
-	_debug("%x,%x,%x,%d", to, call->acks_hard_ack, call->tx_top, rot_last);
+	_debug("%x,%x,%x,%d", to, call->tx_bottom, call->tx_top, rot_last);
 
-	if (call->acks_lowest_nak == call->acks_hard_ack) {
+	if (call->acks_lowest_nak == call->tx_bottom) {
 		call->acks_lowest_nak = to;
 	} else if (after(to, call->acks_lowest_nak)) {
 		summary->new_low_nack = true;
@@ -968,7 +967,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	if (unlikely(summary.ack_reason == RXRPC_ACK_OUT_OF_SEQUENCE) &&
 	    first_soft_ack == 1 &&
 	    prev_pkt == 0 &&
-	    call->acks_hard_ack == 0 &&
+	    call->tx_bottom == 0 &&
 	    rxrpc_is_client_call(call)) {
 		rxrpc_set_call_completion(call, RXRPC_CALL_REMOTELY_ABORTED,
 					  0, -ENETRESET);
@@ -1033,13 +1032,13 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 		goto send_response;
 	}
 
-	if (before(hard_ack, call->acks_hard_ack) ||
+	if (before(hard_ack, call->tx_bottom) ||
 	    after(hard_ack, call->tx_top))
 		return rxrpc_proto_abort(call, 0, rxrpc_eproto_ackr_outside_window);
 	if (nr_acks > call->tx_top - hard_ack)
 		return rxrpc_proto_abort(call, 0, rxrpc_eproto_ackr_sack_overflow);
 
-	if (after(hard_ack, call->acks_hard_ack)) {
+	if (after(hard_ack, call->tx_bottom)) {
 		if (rxrpc_rotate_tx_window(call, hard_ack, &summary)) {
 			rxrpc_end_tx_phase(call, false, rxrpc_eproto_unexpected_ack);
 			goto send_response;
diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index aab392b4281f..fb16fff102fc 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -52,7 +52,7 @@ static int rxrpc_call_seq_show(struct seq_file *seq, void *v)
 	struct rxrpc_call *call;
 	struct rxrpc_net *rxnet = rxrpc_net(seq_file_net(seq));
 	enum rxrpc_call_state state;
-	rxrpc_seq_t acks_hard_ack;
+	rxrpc_seq_t tx_bottom;
 	char lbuff[50], rbuff[50];
 	long timeout = 0;
 
@@ -79,7 +79,7 @@ static int rxrpc_call_seq_show(struct seq_file *seq, void *v)
 	if (state != RXRPC_CALL_SERVER_PREALLOC)
 		timeout = ktime_ms_delta(READ_ONCE(call->expect_rx_by), ktime_get_real());
 
-	acks_hard_ack = READ_ONCE(call->acks_hard_ack);
+	tx_bottom = READ_ONCE(call->tx_bottom);
 	seq_printf(seq,
 		   "UDP   %-47.47s %-47.47s %4x %08x %08x %s %3u"
 		   " %-8.8s %08x %08x %08x %02x %08x %02x %08x %02x %06lx\n",
@@ -93,7 +93,7 @@ static int rxrpc_call_seq_show(struct seq_file *seq, void *v)
 		   rxrpc_call_states[state],
 		   call->abort_code,
 		   call->debug_id,
-		   acks_hard_ack, READ_ONCE(call->tx_top) - acks_hard_ack,
+		   tx_bottom, READ_ONCE(call->tx_top) - tx_bottom,
 		   call->ackr_window, call->ackr_wtop - call->ackr_window,
 		   call->rx_serial,
 		   call->cong_cwnd,
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index cb9b38fc5cf8..fcd111709b50 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -138,7 +138,7 @@ static int rxrpc_wait_for_tx_window_waitall(struct rxrpc_sock *rx,
 		rtt = 2;
 
 	timeout = rtt;
-	tx_start = smp_load_acquire(&call->acks_hard_ack);
+	tx_start = smp_load_acquire(&call->tx_bottom);
 
 	for (;;) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
@@ -195,8 +195,8 @@ static int rxrpc_wait_for_tx_window(struct rxrpc_sock *rx,
 	DECLARE_WAITQUEUE(myself, current);
 	int ret;
 
-	_enter(",{%u,%u,%u,%u}",
-	       call->tx_bottom, call->acks_hard_ack, call->tx_top, call->tx_winsize);
+	_enter(",{%u,%u,%u}",
+	       call->tx_bottom, call->tx_top, call->tx_winsize);
 
 	add_wait_queue(&call->waitq, &myself);
 


