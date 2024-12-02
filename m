Return-Path: <netdev+bounces-148101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7FC9E0589
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99A3116CD69
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D9021858A;
	Mon,  2 Dec 2024 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b8DQem72"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C21218580
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150002; cv=none; b=YK2xMPfJVViw8OQdvB4GYUL3fXuZyTlJDGOGtpfkjl1hH9SoXr9nxssIjLnzYLjJ6faTiGf3flpafGlXfO92wvRW7wpvJuucqJg2otStobhy6D57Rs5HQLrcMEIFqKLcPqkIKHWnFzFqglkqZOEmGSm7M6bBWG33IYsXklX94G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150002; c=relaxed/simple;
	bh=K0jmgONch/JtvlBRUVTee9cT10rH4ssOPmjZ2uCu99E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEu32V2yQ75n3TZdM+p1vzicxIp/0ETDiYmcVIO3GfpuDhbeS50gh3Jlw815wBrgzEdOVG62+23bNeElrWNqv+LVzMiICwhnH9HTT5FlmivbuARd2M7sSoGzTNtzaSce73TT0FUnlkjWS5SR8hV9sbhrKTzkwS5fCJraQ3m8jqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b8DQem72; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733150000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Jb0NXvnvifBNuU1Wwf53cwNnzrHW9wCxJ3SkWW4bGg=;
	b=b8DQem72hOeu9eYPn80eVkqksfx3exXsuK0v9OHqGyIWKhU8l9rt1Bp+xMT92OKdgoVtq9
	eP8ZMHGRAfXHhvpUenFrJu24rdXtxSr6anRryxh9sAYfT6NmlZ+XyYrq3iOdRSJ49SEnM4
	bvyPneyWd8yxcen0D9AsxfGnw2zJEFQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-vvV0KRKmMCGG5ANo5sb7HQ-1; Mon,
 02 Dec 2024 09:33:18 -0500
X-MC-Unique: vvV0KRKmMCGG5ANo5sb7HQ-1
X-Mimecast-MFC-AGG-ID: vvV0KRKmMCGG5ANo5sb7HQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B153193724E;
	Mon,  2 Dec 2024 14:33:16 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ED6A030000DF;
	Mon,  2 Dec 2024 14:33:13 +0000 (UTC)
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
Subject: [PATCH net-next 32/37] rxrpc: Tidy up the ACK parsing a bit
Date: Mon,  2 Dec 2024 14:30:50 +0000
Message-ID: <20241202143057.378147-33-dhowells@redhat.com>
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

Tidy up the ACK parsing in the following ways:

 (1) Put the serial number of the ACK packet into the rxrpc_ack_summary
     struct and access it from there whilst parsing an ACK.

 (2) Be consistent about using "if (summary.acked_serial)" rather than "if
     (summary.acked_serial != 0)".

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/ar-internal.h |  1 +
 net/rxrpc/input.c       | 55 +++++++++++++++++++----------------------
 2 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 4621247012f6..ec87f2e8b78c 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -772,6 +772,7 @@ struct rxrpc_call {
  * Summary of a new ACK and the changes it made to the Tx buffer packet states.
  */
 struct rxrpc_ack_summary {
+	rxrpc_serial_t	ack_serial;		/* Serial number of ACK */
 	rxrpc_serial_t	acked_serial;		/* Serial number ACK'd */
 	u16		in_flight;		/* Number of unreceived transmissions */
 	u16		nr_new_hacks;		/* Number of rotated new ACKs */
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 70831020372e..13d6b8e13ff4 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -198,11 +198,10 @@ void rxrpc_congestion_degrade(struct rxrpc_call *call)
 static void rxrpc_add_data_rtt_sample(struct rxrpc_call *call,
 				      struct rxrpc_ack_summary *summary,
 				      struct rxrpc_txqueue *tq,
-				      int ix,
-				      rxrpc_serial_t ack_serial)
+				      int ix)
 {
 	rxrpc_peer_add_rtt(call, rxrpc_rtt_rx_data_ack, -1,
-			   summary->acked_serial, ack_serial,
+			   summary->acked_serial, summary->ack_serial,
 			   ktime_add_us(tq->xmit_ts_base, tq->segment_xmit_ts[ix]),
 			   call->acks_latest_ts);
 	summary->rtt_sample_avail = false;
@@ -213,8 +212,7 @@ static void rxrpc_add_data_rtt_sample(struct rxrpc_call *call,
  * Apply a hard ACK by advancing the Tx window.
  */
 static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
-				   struct rxrpc_ack_summary *summary,
-				   rxrpc_serial_t ack_serial)
+				   struct rxrpc_ack_summary *summary)
 {
 	struct rxrpc_txqueue *tq = call->tx_queue;
 	rxrpc_seq_t seq = call->tx_bottom + 1;
@@ -255,7 +253,7 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 		if (summary->rtt_sample_avail &&
 		    summary->acked_serial == tq->segment_serial[ix] &&
 		    test_bit(ix, &tq->rtt_samples))
-			rxrpc_add_data_rtt_sample(call, summary, tq, ix, ack_serial);
+			rxrpc_add_data_rtt_sample(call, summary, tq, ix);
 
 		if (ix == tq->nr_reported_acks) {
 			/* Packet directly hard ACK'd. */
@@ -369,7 +367,7 @@ static bool rxrpc_receiving_reply(struct rxrpc_call *call)
 	}
 
 	if (!test_bit(RXRPC_CALL_TX_LAST, &call->flags)) {
-		if (!rxrpc_rotate_tx_window(call, top, &summary, 0)) {
+		if (!rxrpc_rotate_tx_window(call, top, &summary)) {
 			rxrpc_proto_abort(call, top, rxrpc_eproto_early_reply);
 			return false;
 		}
@@ -826,12 +824,11 @@ static void rxrpc_input_ack_trailer(struct rxrpc_call *call, struct sk_buff *skb
  */
 static void rxrpc_input_soft_rtt(struct rxrpc_call *call,
 				 struct rxrpc_ack_summary *summary,
-				 struct rxrpc_txqueue *tq,
-				 rxrpc_serial_t ack_serial)
+				 struct rxrpc_txqueue *tq)
 {
 	for (int ix = 0; ix < RXRPC_NR_TXQUEUE; ix++)
 		if (summary->acked_serial == tq->segment_serial[ix])
-			return rxrpc_add_data_rtt_sample(call, summary, tq, ix, ack_serial);
+			return rxrpc_add_data_rtt_sample(call, summary, tq, ix);
 }
 
 /*
@@ -944,7 +941,7 @@ static void rxrpc_input_soft_acks(struct rxrpc_call *call,
 		_debug("bound %16lx %u", extracted, nr);
 
 		if (summary->rtt_sample_avail)
-			rxrpc_input_soft_rtt(call, summary, tq, sp->hdr.serial);
+			rxrpc_input_soft_rtt(call, summary, tq);
 		rxrpc_input_soft_ack_tq(call, summary, tq, extracted, RXRPC_NR_TXQUEUE,
 					seq - RXRPC_NR_TXQUEUE, &lowest_nak);
 		extracted = ~0UL;
@@ -1016,7 +1013,6 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	struct rxrpc_ack_summary summary = { 0 };
 	struct rxrpc_acktrailer trailer;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
-	rxrpc_serial_t ack_serial;
 	rxrpc_seq_t first_soft_ack, hard_ack, prev_pkt;
 	int nr_acks, offset, ioffset;
 
@@ -1024,14 +1020,14 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 
 	offset = sizeof(struct rxrpc_wire_header) + sizeof(struct rxrpc_ackpacket);
 
-	ack_serial	= sp->hdr.serial;
-	first_soft_ack	= sp->ack.first_ack;
-	prev_pkt	= sp->ack.prev_ack;
-	nr_acks		= sp->ack.nr_acks;
-	hard_ack	= first_soft_ack - 1;
-	summary.acked_serial = sp->ack.acked_serial;
-	summary.ack_reason = (sp->ack.reason < RXRPC_ACK__INVALID ?
-			      sp->ack.reason : RXRPC_ACK__INVALID);
+	summary.ack_serial	= sp->hdr.serial;
+	first_soft_ack		= sp->ack.first_ack;
+	prev_pkt		= sp->ack.prev_ack;
+	nr_acks			= sp->ack.nr_acks;
+	hard_ack		= first_soft_ack - 1;
+	summary.acked_serial	= sp->ack.acked_serial;
+	summary.ack_reason	= (sp->ack.reason < RXRPC_ACK__INVALID ?
+				   sp->ack.reason : RXRPC_ACK__INVALID);
 
 	trace_rxrpc_rx_ack(call, sp);
 	rxrpc_inc_stat(call->rxnet, stat_rx_acks[summary.ack_reason]);
@@ -1066,7 +1062,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 
 	/* Discard any out-of-order or duplicate ACKs (outside lock). */
 	if (!rxrpc_is_ack_valid(call, hard_ack, prev_pkt)) {
-		trace_rxrpc_rx_discard_ack(call, ack_serial, hard_ack, prev_pkt);
+		trace_rxrpc_rx_discard_ack(call, summary.ack_serial, hard_ack, prev_pkt);
 		goto send_response;
 	}
 
@@ -1100,10 +1096,10 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	if (hard_ack + 1 == 0)
 		return rxrpc_proto_abort(call, 0, rxrpc_eproto_ackr_zero);
 
-	if (summary.acked_serial != 0) {
+	if (summary.acked_serial) {
 		if (summary.ack_reason == RXRPC_ACK_PING_RESPONSE)
 			rxrpc_complete_rtt_probe(call, call->acks_latest_ts,
-						 summary.acked_serial, ack_serial,
+						 summary.acked_serial, summary.ack_serial,
 						 rxrpc_rtt_rx_ping_response);
 		else
 			summary.rtt_sample_avail = true;
@@ -1127,7 +1123,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 		return rxrpc_proto_abort(call, 0, rxrpc_eproto_ackr_sack_overflow);
 
 	if (after(hard_ack, call->tx_bottom)) {
-		if (rxrpc_rotate_tx_window(call, hard_ack, &summary, ack_serial)) {
+		if (rxrpc_rotate_tx_window(call, hard_ack, &summary)) {
 			rxrpc_end_tx_phase(call, false, rxrpc_eproto_unexpected_ack);
 			goto send_response;
 		}
@@ -1142,19 +1138,20 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	if (test_bit(RXRPC_CALL_TX_LAST, &call->flags) &&
 	    call->acks_nr_sacks == call->tx_top - hard_ack &&
 	    rxrpc_is_client_call(call))
-		rxrpc_propose_ping(call, ack_serial,
+		rxrpc_propose_ping(call, summary.ack_serial,
 				   rxrpc_propose_ack_ping_for_lost_reply);
 
 	rxrpc_congestion_management(call, &summary);
 	if (summary.need_retransmit)
-		rxrpc_resend(call, ack_serial, summary.ack_reason == RXRPC_ACK_PING_RESPONSE);
+		rxrpc_resend(call, summary.ack_serial,
+			     summary.ack_reason == RXRPC_ACK_PING_RESPONSE);
 
 send_response:
 	if (summary.ack_reason == RXRPC_ACK_PING)
-		rxrpc_send_ACK(call, RXRPC_ACK_PING_RESPONSE, ack_serial,
+		rxrpc_send_ACK(call, RXRPC_ACK_PING_RESPONSE, summary.ack_serial,
 			       rxrpc_propose_ack_respond_to_ping);
 	else if (sp->hdr.flags & RXRPC_REQUEST_ACK)
-		rxrpc_send_ACK(call, RXRPC_ACK_REQUESTED, ack_serial,
+		rxrpc_send_ACK(call, RXRPC_ACK_REQUESTED, summary.ack_serial,
 			       rxrpc_propose_ack_respond_to_ack);
 }
 
@@ -1165,7 +1162,7 @@ static void rxrpc_input_ackall(struct rxrpc_call *call, struct sk_buff *skb)
 {
 	struct rxrpc_ack_summary summary = { 0 };
 
-	if (rxrpc_rotate_tx_window(call, call->tx_top, &summary, 0))
+	if (rxrpc_rotate_tx_window(call, call->tx_top, &summary))
 		rxrpc_end_tx_phase(call, false, rxrpc_eproto_unexpected_ackall);
 }
 


