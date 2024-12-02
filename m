Return-Path: <netdev+bounces-148086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E639E0538
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075DE2847D6
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB74620D4FD;
	Mon,  2 Dec 2024 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G0Tv8G68"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7743B20CCC4
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149946; cv=none; b=Qwcdv4Gy/VQfPGgK31qQKr1ER3x2bud2ksa/N64agjMmPqTt7hC3orJzNhkW+HzGAA/o5aYjxmCY5WSzPYUkTHjZ/ECXRc1quf/4nBd+C8UP0v+MWukXcsjgeXGb6E+EYAxceNpT0Fi/tJlvSZfhmhbsnWMwTlAmCxvirjtIK1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149946; c=relaxed/simple;
	bh=VbdNxlpCnPnkj9VPJhgDgq6ZFVHj2vGM1ejfpEYymxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDOeImuislwlgAUOJf8r+zJ2gxYpr6S5zE+sFxxGRaRTKpPhP0DSGZykG4j7Mb2aLAJYqoRLUZuuRm7co6DpWgs6LA2R34gVgtX/f4nTwxAMXouyPmidDiKBO+8MSGPmVhJ4vY8y/CFQZcGsNcXhXCeko+p6oIj/S0LuOl4+0NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G0Tv8G68; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733149943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzCUz4OX5T3vnwZTvB/0MVkEiOmOsd0oQGIIhh+9j+E=;
	b=G0Tv8G68YzD42lqJcG4bbYIwm2l9qVTq0zpMcFTNhGRt75UFFfbpFjwq2SwjzZmKg+Zfnf
	Fb8oKnyNozhX+8Rwdmg9ca+xWAkb7jSoE+UlUDuLUkmDrmZmLQCipRlGfEK9SBAXljSoGu
	Lr7THwPI1gyeVL7/AsAb60vpvC7J7gs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-_lI4XW5sObGbhtn4I13RSg-1; Mon,
 02 Dec 2024 09:32:20 -0500
X-MC-Unique: _lI4XW5sObGbhtn4I13RSg-1
X-Mimecast-MFC-AGG-ID: _lI4XW5sObGbhtn4I13RSg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 667661944D28;
	Mon,  2 Dec 2024 14:32:18 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C77C51956052;
	Mon,  2 Dec 2024 14:32:15 +0000 (UTC)
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
Subject: [PATCH net-next 18/37] rxrpc: Replace call->acks_first_seq with tracking of the hard ACK point
Date: Mon,  2 Dec 2024 14:30:36 +0000
Message-ID: <20241202143057.378147-19-dhowells@redhat.com>
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

Replace the call->acks_first_seq variable (which holds ack.firstPacket from
the latest ACK packet and indicates the sequence number of the first ack
slot in the SACK table) with call->acks_hard_ack which will hold the
highest sequence hard ACK'd.  This is 1 less than call->acks_first_seq, but
it fits in the same schema as the other tracking variables which hold the
sequence of a packet, not one past it.

This will fix the rxrpc_congest tracepoint's calculation of SACK window
size which shows one fewer than it should - and will occasionally go to -1.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h | 68 +++++++++++++++++-------------------
 net/rxrpc/ar-internal.h      |  2 +-
 net/rxrpc/input.c            | 56 ++++++++++++++---------------
 3 files changed, 59 insertions(+), 67 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 0f253287de00..91108e0de3af 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -893,7 +893,7 @@ TRACE_EVENT(rxrpc_txqueue,
 		    __field(unsigned int,		call)
 		    __field(enum rxrpc_txqueue_trace,	why)
 		    __field(rxrpc_seq_t,		tx_bottom)
-		    __field(rxrpc_seq_t,		acks_first_seq)
+		    __field(rxrpc_seq_t,		acks_hard_ack)
 		    __field(rxrpc_seq_t,		tx_top)
 		    __field(rxrpc_seq_t,		send_top)
 		    __field(int,			tx_winsize)
@@ -903,19 +903,19 @@ TRACE_EVENT(rxrpc_txqueue,
 		    __entry->call = call->debug_id;
 		    __entry->why = why;
 		    __entry->tx_bottom = call->tx_bottom;
-		    __entry->acks_first_seq = call->acks_first_seq;
+		    __entry->acks_hard_ack = call->acks_hard_ack;
 		    __entry->tx_top = call->tx_top;
 		    __entry->send_top = call->send_top;
 		    __entry->tx_winsize = call->tx_winsize;
 			   ),
 
-	    TP_printk("c=%08x %s f=%08x h=%08x n=%u/%u/%u/%u",
+	    TP_printk("c=%08x %s b=%08x h=%08x n=%u/%u/%u/%u",
 		      __entry->call,
 		      __print_symbolic(__entry->why, rxrpc_txqueue_traces),
 		      __entry->tx_bottom,
-		      __entry->acks_first_seq,
-		      __entry->acks_first_seq - __entry->tx_bottom,
-		      __entry->tx_top - __entry->acks_first_seq,
+		      __entry->acks_hard_ack,
+		      __entry->acks_hard_ack - __entry->tx_bottom,
+		      __entry->tx_top - __entry->acks_hard_ack,
 		      __entry->send_top - __entry->tx_top,
 		      __entry->tx_winsize)
 	    );
@@ -1015,11 +1015,9 @@ TRACE_EVENT(rxrpc_rx_data,
 	    );
 
 TRACE_EVENT(rxrpc_rx_ack,
-	    TP_PROTO(struct rxrpc_call *call,
-		     rxrpc_serial_t serial, rxrpc_serial_t ack_serial,
-		     rxrpc_seq_t first, rxrpc_seq_t prev, u8 reason, u8 n_acks),
+	    TP_PROTO(struct rxrpc_call *call, struct rxrpc_skb_priv *sp),
 
-	    TP_ARGS(call, serial, ack_serial, first, prev, reason, n_acks),
+	    TP_ARGS(call, sp),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,	call)
@@ -1032,13 +1030,13 @@ TRACE_EVENT(rxrpc_rx_ack,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call->debug_id;
-		    __entry->serial = serial;
-		    __entry->ack_serial = ack_serial;
-		    __entry->first = first;
-		    __entry->prev = prev;
-		    __entry->reason = reason;
-		    __entry->n_acks = n_acks;
+		    __entry->call	= call->debug_id;
+		    __entry->serial	= sp->hdr.serial;
+		    __entry->ack_serial = sp->ack.acked_serial;
+		    __entry->first	= sp->ack.first_ack;
+		    __entry->prev	= sp->ack.prev_ack;
+		    __entry->reason	= sp->ack.reason;
+		    __entry->n_acks	= sp->ack.nr_acks;
 			   ),
 
 	    TP_printk("c=%08x %08x %s r=%08x f=%08x p=%08x n=%u",
@@ -1707,7 +1705,7 @@ TRACE_EVENT(rxrpc_congest,
 	    TP_fast_assign(
 		    __entry->call	= call->debug_id;
 		    __entry->change	= change;
-		    __entry->hard_ack	= call->acks_first_seq;
+		    __entry->hard_ack	= call->acks_hard_ack;
 		    __entry->top	= call->tx_top;
 		    __entry->lowest_nak	= call->acks_lowest_nak;
 		    __entry->ack_serial	= ack_serial;
@@ -1754,7 +1752,7 @@ TRACE_EVENT(rxrpc_reset_cwnd,
 		    __entry->mode	= call->cong_mode;
 		    __entry->cwnd	= call->cong_cwnd;
 		    __entry->extra	= call->cong_extra;
-		    __entry->hard_ack	= call->acks_first_seq;
+		    __entry->hard_ack	= call->acks_hard_ack;
 		    __entry->prepared	= call->send_top - call->tx_bottom;
 		    __entry->since_last_tx = ktime_sub(now, call->tx_last_sent);
 		    __entry->has_data	= call->tx_bottom != call->tx_top;
@@ -1855,7 +1853,7 @@ TRACE_EVENT(rxrpc_resend,
 	    TP_fast_assign(
 		    struct rxrpc_skb_priv *sp = ack ? rxrpc_skb(ack) : NULL;
 		    __entry->call = call->debug_id;
-		    __entry->seq = call->acks_first_seq;
+		    __entry->seq = call->acks_hard_ack;
 		    __entry->transmitted = call->tx_transmitted;
 		    __entry->ack_serial = sp ? sp->hdr.serial : 0;
 			   ),
@@ -1944,7 +1942,7 @@ TRACE_EVENT(rxrpc_call_reset,
 		    __entry->call_id = call->call_id;
 		    __entry->call_serial = call->rx_serial;
 		    __entry->conn_serial = call->conn->hi_serial;
-		    __entry->tx_seq = call->acks_first_seq;
+		    __entry->tx_seq = call->acks_hard_ack;
 		    __entry->rx_seq = call->rx_highest_seq;
 			   ),
 
@@ -1976,38 +1974,36 @@ TRACE_EVENT(rxrpc_notify_socket,
 	    );
 
 TRACE_EVENT(rxrpc_rx_discard_ack,
-	    TP_PROTO(unsigned int debug_id, rxrpc_serial_t serial,
-		     rxrpc_seq_t first_soft_ack, rxrpc_seq_t call_ackr_first,
-		     rxrpc_seq_t prev_pkt, rxrpc_seq_t call_ackr_prev),
+	    TP_PROTO(struct rxrpc_call *call, rxrpc_serial_t serial,
+		     rxrpc_seq_t hard_ack, rxrpc_seq_t prev_pkt),
 
-	    TP_ARGS(debug_id, serial, first_soft_ack, call_ackr_first,
-		    prev_pkt, call_ackr_prev),
+	    TP_ARGS(call, serial, hard_ack, prev_pkt),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,	debug_id)
 		    __field(rxrpc_serial_t,	serial)
-		    __field(rxrpc_seq_t,	first_soft_ack)
-		    __field(rxrpc_seq_t,	call_ackr_first)
+		    __field(rxrpc_seq_t,	hard_ack)
 		    __field(rxrpc_seq_t,	prev_pkt)
-		    __field(rxrpc_seq_t,	call_ackr_prev)
+		    __field(rxrpc_seq_t,	acks_hard_ack)
+		    __field(rxrpc_seq_t,	acks_prev_seq)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->debug_id		= debug_id;
+		    __entry->debug_id		= call->debug_id;
 		    __entry->serial		= serial;
-		    __entry->first_soft_ack	= first_soft_ack;
-		    __entry->call_ackr_first	= call_ackr_first;
+		    __entry->hard_ack		= hard_ack;
 		    __entry->prev_pkt		= prev_pkt;
-		    __entry->call_ackr_prev	= call_ackr_prev;
+		    __entry->acks_hard_ack	= call->acks_hard_ack;
+		    __entry->acks_prev_seq	= call->acks_prev_seq;
 			   ),
 
 	    TP_printk("c=%08x r=%08x %08x<%08x %08x<%08x",
 		      __entry->debug_id,
 		      __entry->serial,
-		      __entry->first_soft_ack,
-		      __entry->call_ackr_first,
+		      __entry->hard_ack,
+		      __entry->acks_hard_ack,
 		      __entry->prev_pkt,
-		      __entry->call_ackr_prev)
+		      __entry->acks_prev_seq)
 	    );
 
 TRACE_EVENT(rxrpc_req_ack,
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 6683043cee3f..3e57cef7385f 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -757,7 +757,7 @@ struct rxrpc_call {
 
 	/* Transmission-phase ACK management (ACKs we've received). */
 	ktime_t			acks_latest_ts;	/* Timestamp of latest ACK received */
-	rxrpc_seq_t		acks_first_seq;	/* first sequence number received */
+	rxrpc_seq_t		acks_hard_ack;	/* Highest sequence hard acked */
 	rxrpc_seq_t		acks_prev_seq;	/* Highest previousPacket received */
 	rxrpc_seq_t		acks_lowest_nak; /* Lowest NACK in the buffer (or ==tx_hard_ack) */
 	rxrpc_serial_t		acks_highest_serial; /* Highest serial number ACK'd */
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index b9fec74626eb..4684c2c127b5 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -782,12 +782,12 @@ static void rxrpc_input_ack_trailer(struct rxrpc_call *call, struct sk_buff *skb
  */
 static rxrpc_seq_t rxrpc_input_check_prev_ack(struct rxrpc_call *call,
 					      struct rxrpc_ack_summary *summary,
-					      rxrpc_seq_t seq)
+					      rxrpc_seq_t hard_ack)
 {
 	struct sk_buff *skb = call->cong_last_nack;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	unsigned int i, new_acks = 0, retained_nacks = 0;
-	rxrpc_seq_t old_seq = sp->ack.first_ack;
+	rxrpc_seq_t seq = hard_ack + 1, old_seq = sp->ack.first_ack;
 	u8 *acks = skb->data + sizeof(struct rxrpc_wire_header) + sizeof(struct rxrpc_ackpacket);
 
 	if (after_eq(seq, old_seq + sp->ack.nr_acks)) {
@@ -810,7 +810,7 @@ static rxrpc_seq_t rxrpc_input_check_prev_ack(struct rxrpc_call *call,
 		summary->nr_retained_nacks = retained_nacks;
 	}
 
-	return old_seq + sp->ack.nr_acks;
+	return old_seq + sp->ack.nr_acks - 1;
 }
 
 /*
@@ -825,22 +825,23 @@ static rxrpc_seq_t rxrpc_input_check_prev_ack(struct rxrpc_call *call,
 static void rxrpc_input_soft_acks(struct rxrpc_call *call,
 				  struct rxrpc_ack_summary *summary,
 				  struct sk_buff *skb,
-				  rxrpc_seq_t seq,
 				  rxrpc_seq_t since)
 {
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	unsigned int i, old_nacks = 0;
-	rxrpc_seq_t lowest_nak = seq + sp->ack.nr_acks;
+	rxrpc_seq_t lowest_nak = call->acks_hard_ack + sp->ack.nr_acks + 1;
+	rxrpc_seq_t seq = call->acks_hard_ack;
 	u8 *acks = skb->data + sizeof(struct rxrpc_wire_header) + sizeof(struct rxrpc_ackpacket);
 
 	for (i = 0; i < sp->ack.nr_acks; i++) {
+		seq++;
 		if (acks[i] == RXRPC_ACK_TYPE_ACK) {
 			summary->nr_acks++;
-			if (after_eq(seq, since))
+			if (after(seq, since))
 				summary->nr_new_acks++;
 		} else {
 			summary->saw_nacks = true;
-			if (before(seq, since)) {
+			if (before_eq(seq, since)) {
 				/* Overlap with previous ACK */
 				old_nacks++;
 			} else {
@@ -851,7 +852,6 @@ static void rxrpc_input_soft_acks(struct rxrpc_call *call,
 			if (before(seq, lowest_nak))
 				lowest_nak = seq;
 		}
-		seq++;
 	}
 
 	if (lowest_nak != call->acks_lowest_nak) {
@@ -874,21 +874,21 @@ static void rxrpc_input_soft_acks(struct rxrpc_call *call,
  * with respect to the ack state conveyed by preceding ACKs.
  */
 static bool rxrpc_is_ack_valid(struct rxrpc_call *call,
-			       rxrpc_seq_t first_pkt, rxrpc_seq_t prev_pkt)
+			       rxrpc_seq_t hard_ack, rxrpc_seq_t prev_pkt)
 {
-	rxrpc_seq_t base = READ_ONCE(call->acks_first_seq);
+	rxrpc_seq_t base = READ_ONCE(call->acks_hard_ack);
 
-	if (after(first_pkt, base))
+	if (after(hard_ack, base))
 		return true; /* The window advanced */
 
-	if (before(first_pkt, base))
+	if (before(hard_ack, base))
 		return false; /* firstPacket regressed */
 
 	if (after_eq(prev_pkt, call->acks_prev_seq))
 		return true; /* previousPacket hasn't regressed. */
 
 	/* Some rx implementations put a serial number in previousPacket. */
-	if (after_eq(prev_pkt, base + call->tx_winsize))
+	if (after(prev_pkt, base + call->tx_winsize))
 		return false;
 	return true;
 }
@@ -906,8 +906,8 @@ static bool rxrpc_is_ack_valid(struct rxrpc_call *call,
 static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 {
 	struct rxrpc_ack_summary summary = { 0 };
-	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	struct rxrpc_acktrailer trailer;
+	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	rxrpc_serial_t ack_serial, acked_serial;
 	rxrpc_seq_t first_soft_ack, hard_ack, prev_pkt, since;
 	int nr_acks, offset, ioffset;
@@ -925,9 +925,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	summary.ack_reason = (sp->ack.reason < RXRPC_ACK__INVALID ?
 			      sp->ack.reason : RXRPC_ACK__INVALID);
 
-	trace_rxrpc_rx_ack(call, ack_serial, acked_serial,
-			   first_soft_ack, prev_pkt,
-			   summary.ack_reason, nr_acks);
+	trace_rxrpc_rx_ack(call, sp);
 	rxrpc_inc_stat(call->rxnet, stat_rx_acks[summary.ack_reason]);
 
 	if (acked_serial != 0) {
@@ -952,7 +950,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	 * lost the call because it switched to a different peer.
 	 */
 	if (unlikely(summary.ack_reason == RXRPC_ACK_EXCEEDS_WINDOW) &&
-	    first_soft_ack == 1 &&
+	    hard_ack == 0 &&
 	    prev_pkt == 0 &&
 	    rxrpc_is_client_call(call)) {
 		rxrpc_set_call_completion(call, RXRPC_CALL_REMOTELY_ABORTED,
@@ -965,7 +963,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	 * if we still have it buffered to the beginning.
 	 */
 	if (unlikely(summary.ack_reason == RXRPC_ACK_OUT_OF_SEQUENCE) &&
-	    first_soft_ack == 1 &&
+	    hard_ack == 0 &&
 	    prev_pkt == 0 &&
 	    call->tx_bottom == 0 &&
 	    rxrpc_is_client_call(call)) {
@@ -975,10 +973,8 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	}
 
 	/* Discard any out-of-order or duplicate ACKs (outside lock). */
-	if (!rxrpc_is_ack_valid(call, first_soft_ack, prev_pkt)) {
-		trace_rxrpc_rx_discard_ack(call->debug_id, ack_serial,
-					   first_soft_ack, call->acks_first_seq,
-					   prev_pkt, call->acks_prev_seq);
+	if (!rxrpc_is_ack_valid(call, hard_ack, prev_pkt)) {
+		trace_rxrpc_rx_discard_ack(call, ack_serial, hard_ack, prev_pkt);
 		goto send_response;
 	}
 
@@ -992,17 +988,17 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 		skb_condense(skb);
 
 	if (call->cong_last_nack) {
-		since = rxrpc_input_check_prev_ack(call, &summary, first_soft_ack);
+		since = rxrpc_input_check_prev_ack(call, &summary, hard_ack);
 		rxrpc_free_skb(call->cong_last_nack, rxrpc_skb_put_last_nack);
 		call->cong_last_nack = NULL;
 	} else {
-		summary.nr_new_acks = first_soft_ack - call->acks_first_seq;
-		call->acks_lowest_nak = first_soft_ack + nr_acks;
-		since = first_soft_ack;
+		summary.nr_new_acks = hard_ack - call->acks_hard_ack;
+		call->acks_lowest_nak = hard_ack + nr_acks;
+		since = hard_ack;
 	}
 
 	call->acks_latest_ts = skb->tstamp;
-	call->acks_first_seq = first_soft_ack;
+	call->acks_hard_ack = hard_ack;
 	call->acks_prev_seq = prev_pkt;
 
 	switch (summary.ack_reason) {
@@ -1018,7 +1014,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	if (trailer.maxMTU)
 		rxrpc_input_ack_trailer(call, skb, &trailer);
 
-	if (first_soft_ack == 0)
+	if (hard_ack + 1 == 0)
 		return rxrpc_proto_abort(call, 0, rxrpc_eproto_ackr_zero);
 
 	/* Ignore ACKs unless we are or have just been transmitting. */
@@ -1048,7 +1044,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	if (nr_acks > 0) {
 		if (offset > (int)skb->len - nr_acks)
 			return rxrpc_proto_abort(call, 0, rxrpc_eproto_ackr_short_sack);
-		rxrpc_input_soft_acks(call, &summary, skb, first_soft_ack, since);
+		rxrpc_input_soft_acks(call, &summary, skb, since);
 		rxrpc_get_skb(skb, rxrpc_skb_get_last_nack);
 		call->cong_last_nack = skb;
 	}


