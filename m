Return-Path: <netdev+bounces-148083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D29109E0525
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A4A2841B2
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E490205E12;
	Mon,  2 Dec 2024 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QyGzS4JU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8106120ADF9
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 14:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149933; cv=none; b=dbzEPHueaTr55rw4wSy+GVILoO4vV8ZMMu493CFqudpaL7NBU4STDXOZvBvCAkwHFrI3SXZMtVrssy1XB5Xv8cKGTWPUC7EglkzkD1/ol+ryp2ZCeZ+IA6XkaEHYLLGfb0mxg+Jl3UZmDzwAj21rOutQ4nT12hFVjt5UKAt2RnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149933; c=relaxed/simple;
	bh=WUchw3APlK4xenHQ9zUUrSG+WmZsP1z8NKu9adpGO4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMxCzqt33NJNJxgBacdSHRidlkdd3PVsrLwLD82QKnzC2Vmeo28LFV5fuyH0RP9iesWzVL3f8QFy9fTPEb4DlqjEp7A6kNGbGHV/Zgz/RAvBkDkmeYbv3ETmOpo083HSlkFvgyXn4H2rbY1p8zJgod5h/sJ97WC0tryg9vNlMp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QyGzS4JU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733149930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yYrcIzROb0Ghl43qdefQjpkSE8C1A8Z1KxBFgwFQKxo=;
	b=QyGzS4JUS+dtpnE87IT40gyfXnIduGLAtviVvPcLG+v6IdUMYyCJvsjmjqNPf3QUIfsXHN
	Nhizy7Jt9TtTAc8SuDKAAzT89xjjFQFx0EhOWhwkkCnwQvI+n4X/tw9NOJKryeUrHXNX6B
	i+e5kT3Jic4gLH9rQ1t8XdhD985j/rg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-nWdiCAQ-M76V6p3X2EVMTQ-1; Mon,
 02 Dec 2024 09:32:07 -0500
X-MC-Unique: nWdiCAQ-M76V6p3X2EVMTQ-1
X-Mimecast-MFC-AGG-ID: nWdiCAQ-M76V6p3X2EVMTQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E09351944B23;
	Mon,  2 Dec 2024 14:32:05 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 60A541955D48;
	Mon,  2 Dec 2024 14:32:03 +0000 (UTC)
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
Subject: [PATCH net-next 15/37] rxrpc: Timestamp DATA packets before transmitting them
Date: Mon,  2 Dec 2024 14:30:33 +0000
Message-ID: <20241202143057.378147-16-dhowells@redhat.com>
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

Move to setting the timestamp on DATA packets before transmitting them as
part of the preparation.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/output.c | 56 ++++++++++++++--------------------------------
 1 file changed, 17 insertions(+), 39 deletions(-)

diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 95a3819dd85d..7b068a33eb21 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -376,7 +376,8 @@ int rxrpc_send_abort_packet(struct rxrpc_call *call)
  */
 static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc_txbuf *txb,
 					   rxrpc_serial_t serial,
-					   int subpkt, int nr_subpkts)
+					   int subpkt, int nr_subpkts,
+					   ktime_t now)
 {
 	struct rxrpc_wire_header *whdr = txb->kvec[0].iov_base;
 	struct rxrpc_jumbo_header *jumbo = (void *)(whdr + 1) - sizeof(*jumbo);
@@ -436,8 +437,9 @@ static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc
 	rxrpc_inc_stat(call->rxnet, stat_why_req_ack[why]);
 	trace_rxrpc_req_ack(call->debug_id, txb->seq, why);
 	if (why != rxrpc_reqack_no_srv_last) {
-		txb->flags |= RXRPC_REQUEST_ACK;
 		flags |= RXRPC_REQUEST_ACK;
+		rxrpc_begin_rtt_probe(call, serial, now, rxrpc_rtt_tx_data);
+		call->peer->rtt_last_req = now;
 	}
 dont_set_request_ack:
 
@@ -473,49 +475,25 @@ static size_t rxrpc_prepare_data_packet(struct rxrpc_call *call, struct rxrpc_tx
 {
 	struct rxrpc_txbuf *txb = head;
 	rxrpc_serial_t serial;
+	ktime_t now = ktime_get_real();
 	size_t len = 0;
 
 	/* Each transmission of a Tx packet needs a new serial number */
 	serial = rxrpc_get_next_serials(call->conn, n);
 
 	for (int i = 0; i < n; i++) {
-		len += rxrpc_prepare_data_subpacket(call, txb, serial, i, n);
-		serial++;
-		txb = list_next_entry(txb, call_link);
-	}
-
-	return len;
-}
-
-/*
- * Set timeouts after transmitting a packet.
- */
-static void rxrpc_tstamp_data_packets(struct rxrpc_call *call, struct rxrpc_txbuf *txb, int n)
-{
-	rxrpc_serial_t serial;
-	ktime_t now = ktime_get_real();
-	bool ack_requested = txb->flags & RXRPC_REQUEST_ACK;
-	int i;
-
-	call->tx_last_sent = now;
-
-	for (i = 0; i < n; i++) {
 		txb->last_sent = now;
-		ack_requested |= txb->flags & RXRPC_REQUEST_ACK;
-		serial = txb->serial;
+		len += rxrpc_prepare_data_subpacket(call, txb, serial, i, n, now);
+		serial++;
 		txb = list_next_entry(txb, call_link);
 	}
 
-	if (ack_requested) {
-		rxrpc_begin_rtt_probe(call, serial, now, rxrpc_rtt_tx_data);
-
-		call->peer->rtt_last_req = now;
-		if (call->peer->rtt_count > 1) {
-			ktime_t delay = rxrpc_get_rto_backoff(call->peer, false);
+	/* Set timeouts */
+	if (call->peer->rtt_count > 1) {
+		ktime_t delay = rxrpc_get_rto_backoff(call->peer, false);
 
-			call->ack_lost_at = ktime_add(now, delay);
-			trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_lost_ack);
-		}
+		call->ack_lost_at = ktime_add(now, delay);
+		trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_lost_ack);
 	}
 
 	if (!test_and_set_bit(RXRPC_CALL_BEGAN_RX_TIMER, &call->flags)) {
@@ -526,6 +504,7 @@ static void rxrpc_tstamp_data_packets(struct rxrpc_call *call, struct rxrpc_txbu
 	}
 
 	rxrpc_set_keepalive(call, now);
+	return len;
 }
 
 /*
@@ -537,6 +516,7 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 	enum rxrpc_tx_point frag;
 	struct msghdr msg;
 	size_t len;
+	bool new_call = test_bit(RXRPC_CALL_BEGAN_RX_TIMER, &call->flags);
 	int ret;
 
 	_enter("%x,{%d}", txb->seq, txb->pkt_len);
@@ -603,20 +583,18 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 
 	rxrpc_tx_backoff(call, ret);
 
-done:
-	if (ret >= 0) {
-		rxrpc_tstamp_data_packets(call, txb, n);
-	} else {
+	if (ret < 0) {
 		/* Cancel the call if the initial transmission fails,
 		 * particularly if that's due to network routing issues that
 		 * aren't going away anytime soon.  The layer above can arrange
 		 * the retransmission.
 		 */
-		if (!test_and_set_bit(RXRPC_CALL_BEGAN_RX_TIMER, &call->flags))
+		if (new_call)
 			rxrpc_set_call_completion(call, RXRPC_CALL_LOCAL_ERROR,
 						  RX_USER_ABORT, ret);
 	}
 
+done:
 	_leave(" = %d [%u]", ret, call->peer->max_data);
 	return ret;
 }


