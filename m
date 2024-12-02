Return-Path: <netdev+bounces-148079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F2C9E051C
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93965287E45
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59822209F5D;
	Mon,  2 Dec 2024 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lsn38HLm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F3020A5C9
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149924; cv=none; b=fi4fNF9bZd3u7bV92F2Sq7yV4bJnoxCS3EAPVB+Gvb6pcmmOiq3VxRnG2H25TyPZm8UJdA+bonKlebNWQRbXHhXes1khxV+qNotnZRCv+hgoBSQZPLRernHvjQVF3YoQ9mxMszJZFrifqA7VJxiicuKed8y8n2MzGNOqXqtPt8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149924; c=relaxed/simple;
	bh=pxIU7cQG5XoxOfqZ9qLb+alAab4oEKgtoh/fxdcISFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXIPHqZAJekrcOIVfsAA08c91IZrYroQZkBM+vntyYlzwRVcSMxsZpEpjn4N10/0wCBPbywSpCfVzOKL4K8VXIY7lofBc22YbtlNICUF+B9K5uruhF4rzHV0D19CJkkes8sk8Gfs6iew2mSoQWQD9j2n8sWChp+Zt60E/vfjDjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lsn38HLm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733149921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=46xuPOZgDaGiI0wVSOT/7BpjlvHzoeBiZ/qjsurlLGc=;
	b=Lsn38HLmccQrokKlIFT07LnqTWB4ZKyyDzE4IDYUYJwfSXhL0oadcPvnS42IoY4noCfA13
	8iEgxQmcg96VDnufdCerUfV6yirKgyCzBauRPkSWXWhJtNawK1hSnNZmSOJKIvsIqxrf94
	ENxLso8o4Ovr/hK28/nkdhl3QW8/dM8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-xg7tsPRRPsC7UysCm18dDg-1; Mon,
 02 Dec 2024 09:31:58 -0500
X-MC-Unique: xg7tsPRRPsC7UysCm18dDg-1
X-Mimecast-MFC-AGG-ID: xg7tsPRRPsC7UysCm18dDg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B5CA18DA849;
	Mon,  2 Dec 2024 14:31:45 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC33D195605A;
	Mon,  2 Dec 2024 14:31:42 +0000 (UTC)
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
Subject: [PATCH net-next 10/37] rxrpc: Prepare to be able to send jumbo DATA packets
Date: Mon,  2 Dec 2024 14:30:28 +0000
Message-ID: <20241202143057.378147-11-dhowells@redhat.com>
In-Reply-To: <20241202143057.378147-1-dhowells@redhat.com>
References: <20241202143057.378147-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Prepare to be able to send jumbo DATA packets if the we decide to, but
don't enable that yet.  This will allow larger chunks of data to be sent
without reducing the retryability as the subpackets in a jumbo packet can
also be retransmitted individually.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/ar-internal.h | 18 +++++++++-
 net/rxrpc/call_event.c  | 48 ++++++++++++++-----------
 net/rxrpc/input.c       | 36 +++++++++++--------
 net/rxrpc/insecure.c    |  2 ++
 net/rxrpc/output.c      | 80 ++++++++++++++++++++++++++++-------------
 net/rxrpc/rxkad.c       | 13 +++++++
 6 files changed, 137 insertions(+), 60 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index a5c0bc917641..4386b2e6cca5 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -832,6 +832,7 @@ struct rxrpc_txbuf {
 	__be16			cksum;		/* Checksum to go in header */
 	unsigned short		ack_rwind;	/* ACK receive window */
 	u8 /*enum rxrpc_propose_ack_trace*/ ack_why;	/* If ack, why */
+	bool			jumboable;	/* Can be non-terminal jumbo subpacket */
 	u8			nr_kvec;	/* Amount of kvec[] used */
 	struct kvec		kvec[3];
 };
@@ -862,6 +863,21 @@ static inline rxrpc_serial_t rxrpc_get_next_serial(struct rxrpc_connection *conn
 	return serial;
 }
 
+/*
+ * Allocate the next serial n numbers on a connection.  0 must be skipped.
+ */
+static inline rxrpc_serial_t rxrpc_get_next_serials(struct rxrpc_connection *conn,
+						    unsigned int n)
+{
+	rxrpc_serial_t serial;
+
+	serial = conn->tx_serial;
+	if (serial + n <= n)
+		serial = 1;
+	conn->tx_serial = serial + n;
+	return serial;
+}
+
 /*
  * af_rxrpc.c
  */
@@ -1176,7 +1192,7 @@ int rxrpc_send_abort_packet(struct rxrpc_call *);
 void rxrpc_send_conn_abort(struct rxrpc_connection *conn);
 void rxrpc_reject_packet(struct rxrpc_local *local, struct sk_buff *skb);
 void rxrpc_send_keepalive(struct rxrpc_peer *);
-void rxrpc_transmit_one(struct rxrpc_call *call, struct rxrpc_txbuf *txb);
+void rxrpc_transmit_data(struct rxrpc_call *call, struct rxrpc_txbuf *txb, int n);
 
 /*
  * peer_event.c
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 1d889b6f0366..3379adfaaf65 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -124,7 +124,7 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 					       ktime_sub(resend_at, now));
 
 			txb->flags |= RXRPC_TXBUF_RESENT;
-			rxrpc_transmit_one(call, txb);
+			rxrpc_transmit_data(call, txb, 1);
 			did_send = true;
 			now = ktime_get_real();
 
@@ -164,7 +164,7 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 		unacked = true;
 
 		txb->flags |= RXRPC_TXBUF_RESENT;
-		rxrpc_transmit_one(call, txb);
+		rxrpc_transmit_data(call, txb, 1);
 		did_send = true;
 		rxrpc_inc_stat(call->rxnet, stat_tx_data_retrans);
 		now = ktime_get_real();
@@ -231,15 +231,12 @@ static void rxrpc_close_tx_phase(struct rxrpc_call *call)
 	}
 }
 
-static bool rxrpc_tx_window_has_space(struct rxrpc_call *call)
+static unsigned int rxrpc_tx_window_space(struct rxrpc_call *call)
 {
-	unsigned int winsize = umin(call->tx_winsize, call->cong_cwnd + call->cong_extra);
-	rxrpc_seq_t window = call->acks_hard_ack, wtop = window + winsize;
-	rxrpc_seq_t tx_top = call->tx_top;
-	int space;
+	int winsize = umin(call->tx_winsize, call->cong_cwnd + call->cong_extra);
+	int in_flight = call->tx_top - call->acks_hard_ack;
 
-	space = wtop - tx_top;
-	return space > 0;
+	return max(winsize - in_flight, 0);
 }
 
 /*
@@ -247,7 +244,7 @@ static bool rxrpc_tx_window_has_space(struct rxrpc_call *call)
  */
 static void rxrpc_decant_prepared_tx(struct rxrpc_call *call)
 {
-	struct rxrpc_txbuf *txb;
+	int space = rxrpc_tx_window_space(call);
 
 	if (!test_bit(RXRPC_CALL_EXPOSED, &call->flags)) {
 		if (list_empty(&call->tx_sendmsg))
@@ -255,22 +252,33 @@ static void rxrpc_decant_prepared_tx(struct rxrpc_call *call)
 		rxrpc_expose_client_call(call);
 	}
 
-	while ((txb = list_first_entry_or_null(&call->tx_sendmsg,
-					       struct rxrpc_txbuf, call_link))) {
+	while (space > 0) {
+		struct rxrpc_txbuf *head = NULL, *txb;
+		int count = 0, limit = min(space, 1);
+
+		if (list_empty(&call->tx_sendmsg))
+			break;
+
 		spin_lock(&call->tx_lock);
-		list_del(&txb->call_link);
+		do {
+			txb = list_first_entry(&call->tx_sendmsg,
+					       struct rxrpc_txbuf, call_link);
+			if (!head)
+				head = txb;
+			list_move_tail(&txb->call_link, &call->tx_buffer);
+			count++;
+			if (!txb->jumboable)
+				break;
+		} while (count < limit && !list_empty(&call->tx_sendmsg));
+
 		spin_unlock(&call->tx_lock);
 
 		call->tx_top = txb->seq;
-		list_add_tail(&txb->call_link, &call->tx_buffer);
-
 		if (txb->flags & RXRPC_LAST_PACKET)
 			rxrpc_close_tx_phase(call);
 
-		rxrpc_transmit_one(call, txb);
-
-		if (!rxrpc_tx_window_has_space(call))
-			break;
+		space -= count;
+		rxrpc_transmit_data(call, head, count);
 	}
 }
 
@@ -285,7 +293,7 @@ static void rxrpc_transmit_some_data(struct rxrpc_call *call)
 
 	case RXRPC_CALL_SERVER_SEND_REPLY:
 	case RXRPC_CALL_CLIENT_SEND_REQUEST:
-		if (!rxrpc_tx_window_has_space(call))
+		if (!rxrpc_tx_window_space(call))
 			return;
 		if (list_empty(&call->tx_sendmsg)) {
 			rxrpc_inc_stat(call->rxnet, stat_tx_data_underflow);
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index fd08d813ef29..8398fa10ee8d 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -693,9 +693,12 @@ static void rxrpc_input_ack_trailer(struct rxrpc_call *call, struct sk_buff *skb
 {
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	struct rxrpc_peer *peer = call->peer;
-	unsigned int max_data;
+	unsigned int max_data, capacity;
 	bool wake = false;
-	u32 rwind = ntohl(trailer->rwind);
+	u32 max_mtu	= ntohl(trailer->maxMTU);
+	//u32 if_mtu	= ntohl(trailer->ifMTU);
+	u32 rwind	= ntohl(trailer->rwind);
+	u32 jumbo_max	= ntohl(trailer->jumbo_max);
 
 	if (rwind > RXRPC_TX_MAX_WINDOW)
 		rwind = RXRPC_TX_MAX_WINDOW;
@@ -706,24 +709,29 @@ static void rxrpc_input_ack_trailer(struct rxrpc_call *call, struct sk_buff *skb
 		call->tx_winsize = rwind;
 	}
 
-	if (trailer->jumbo_max == 0) {
-		/* The peer says it supports pmtu discovery */
-		peer->ackr_adv_pmtud = true;
-	} else {
-		peer->ackr_adv_pmtud = false;
-	}
-
-	max_data = ntohl(trailer->maxMTU);
-	peer->ackr_max_data = max_data;
+	max_mtu = clamp(max_mtu, 500, 65535);
+	peer->ackr_max_data = max_mtu;
 
-	if (max_data < peer->max_data) {
-		trace_rxrpc_pmtud_reduce(peer, sp->hdr.serial, max_data,
+	if (max_mtu < peer->max_data) {
+		trace_rxrpc_pmtud_reduce(peer, sp->hdr.serial, max_mtu,
 					 rxrpc_pmtud_reduce_ack);
 		write_seqcount_begin(&peer->mtu_lock);
-		peer->max_data = max_data;
+		peer->max_data = max_mtu;
 		write_seqcount_end(&peer->mtu_lock);
 	}
 
+	max_data = umin(max_mtu, peer->max_data);
+	capacity = max_data;
+	capacity += sizeof(struct rxrpc_jumbo_header); /* First subpacket has main hdr, not jumbo */
+	capacity /= sizeof(struct rxrpc_jumbo_header) + RXRPC_JUMBO_DATALEN;
+
+	if (jumbo_max == 0) {
+		/* The peer says it supports pmtu discovery */
+		peer->ackr_adv_pmtud = true;
+	} else {
+		peer->ackr_adv_pmtud = false;
+	}
+
 	if (wake)
 		wake_up(&call->waitq);
 }
diff --git a/net/rxrpc/insecure.c b/net/rxrpc/insecure.c
index d665f486be5f..e068f9b79d02 100644
--- a/net/rxrpc/insecure.c
+++ b/net/rxrpc/insecure.c
@@ -25,6 +25,8 @@ static struct rxrpc_txbuf *none_alloc_txbuf(struct rxrpc_call *call, size_t rema
 static int none_secure_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 {
 	txb->pkt_len = txb->len;
+	if (txb->len == RXRPC_JUMBO_DATALEN)
+		txb->jumboable = true;
 	return 0;
 }
 
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 5f33e6c50854..4fc6e48e0e3e 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -376,9 +376,10 @@ int rxrpc_send_abort_packet(struct rxrpc_call *call)
  */
 static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc_txbuf *txb,
 					   rxrpc_serial_t serial,
-					   int subpkt)
+					   int subpkt, int nr_subpkts)
 {
 	struct rxrpc_wire_header *whdr = txb->kvec[0].iov_base;
+	struct rxrpc_jumbo_header *jumbo = (void *)(whdr + 1) - sizeof(*jumbo);
 	enum rxrpc_req_ack_trace why;
 	struct rxrpc_connection *conn = call->conn;
 	struct kvec *kv = &call->local->kvec[subpkt];
@@ -398,6 +399,11 @@ static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc
 	flags = txb->flags & RXRPC_TXBUF_WIRE_FLAGS;
 	last = txb->flags & RXRPC_LAST_PACKET;
 
+	if (subpkt < nr_subpkts - 1) {
+		len = RXRPC_JUMBO_DATALEN;
+		goto dont_set_request_ack;
+	}
+
 	more = (!list_is_last(&txb->call_link, &call->tx_buffer) ||
 		!list_empty(&call->tx_sendmsg));
 
@@ -435,13 +441,25 @@ static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc
 	}
 dont_set_request_ack:
 
-	whdr->flags	= flags;
-	whdr->serial	= htonl(txb->serial);
-	whdr->cksum	= txb->cksum;
-	whdr->serviceId	= htons(conn->service_id);
-	kv->iov_base	= whdr;
-	len += sizeof(*whdr);
-	// TODO: Convert into a jumbo header for tail subpackets
+	/* The jumbo header overlays the wire header in the txbuf. */
+	if (subpkt < nr_subpkts - 1)
+		flags |= RXRPC_JUMBO_PACKET;
+	else
+		flags &= ~RXRPC_JUMBO_PACKET;
+	if (subpkt == 0) {
+		whdr->flags	= flags;
+		whdr->serial	= htonl(txb->serial);
+		whdr->cksum	= txb->cksum;
+		whdr->serviceId	= htons(conn->service_id);
+		kv->iov_base	= whdr;
+		len += sizeof(*whdr);
+	} else {
+		jumbo->flags	= flags;
+		jumbo->pad	= 0;
+		jumbo->cksum	= txb->cksum;
+		kv->iov_base	= jumbo;
+		len += sizeof(*jumbo);
+	}
 
 	trace_rxrpc_tx_data(call, txb->seq, txb->serial, flags, false);
 	kv->iov_len = len;
@@ -449,18 +467,22 @@ static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc
 }
 
 /*
- * Prepare a packet for transmission.
+ * Prepare a (jumbo) packet for transmission.
  */
-static size_t rxrpc_prepare_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
+static size_t rxrpc_prepare_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *head, int n)
 {
+	struct rxrpc_txbuf *txb = head;
 	rxrpc_serial_t serial;
 	size_t len = 0;
 
 	/* Each transmission of a Tx packet needs a new serial number */
-	serial = rxrpc_get_next_serial(call->conn);
+	serial = rxrpc_get_next_serials(call->conn, n);
 
-	len += rxrpc_prepare_data_subpacket(call, txb, serial, 0);
-	// TODO: Loop around adding tail subpackets
+	for (int i = 0; i < n; i++) {
+		len += rxrpc_prepare_data_subpacket(call, txb, serial, i, n);
+		serial++;
+		txb = list_next_entry(txb, call_link);
+	}
 
 	return len;
 }
@@ -468,16 +490,24 @@ static size_t rxrpc_prepare_data_packet(struct rxrpc_call *call, struct rxrpc_tx
 /*
  * Set timeouts after transmitting a packet.
  */
-static void rxrpc_tstamp_data_packets(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
+static void rxrpc_tstamp_data_packets(struct rxrpc_call *call, struct rxrpc_txbuf *txb, int n)
 {
+	rxrpc_serial_t serial;
 	ktime_t now = ktime_get_real();
 	bool ack_requested = txb->flags & RXRPC_REQUEST_ACK;
+	int i;
 
 	call->tx_last_sent = now;
-	txb->last_sent = now;
+
+	for (i = 0; i < n; i++) {
+		txb->last_sent = now;
+		ack_requested |= txb->flags & RXRPC_REQUEST_ACK;
+		serial = txb->serial;
+		txb = list_next_entry(txb, call_link);
+	}
 
 	if (ack_requested) {
-		rxrpc_begin_rtt_probe(call, txb->serial, now, rxrpc_rtt_tx_data);
+		rxrpc_begin_rtt_probe(call, serial, now, rxrpc_rtt_tx_data);
 
 		call->peer->rtt_last_req = now;
 		if (call->peer->rtt_count > 1) {
@@ -501,7 +531,7 @@ static void rxrpc_tstamp_data_packets(struct rxrpc_call *call, struct rxrpc_txbu
 /*
  * send a packet through the transport endpoint
  */
-static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
+static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb, int n)
 {
 	struct rxrpc_connection *conn = call->conn;
 	enum rxrpc_tx_point frag;
@@ -511,7 +541,7 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 
 	_enter("%x,{%d}", txb->seq, txb->pkt_len);
 
-	len = rxrpc_prepare_data_packet(call, txb);
+	len = rxrpc_prepare_data_packet(call, txb, n);
 
 	if (IS_ENABLED(CONFIG_AF_RXRPC_INJECT_LOSS)) {
 		static int lose;
@@ -523,7 +553,7 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 		}
 	}
 
-	iov_iter_kvec(&msg.msg_iter, WRITE, call->local->kvec, 1, len);
+	iov_iter_kvec(&msg.msg_iter, WRITE, call->local->kvec, n, len);
 
 	msg.msg_name	= &call->peer->srx.transport;
 	msg.msg_namelen	= call->peer->srx.transport_len;
@@ -536,7 +566,7 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 	 * yet.
 	 */
 	if (txb->seq == call->tx_transmitted + 1)
-		call->tx_transmitted = txb->seq;
+		call->tx_transmitted = txb->seq + n - 1;
 
 	/* send the packet with the don't fragment bit set if we currently
 	 * think it's small enough */
@@ -567,7 +597,7 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 	}
 
 	rxrpc_tx_backoff(call, ret);
-	if (ret == -EMSGSIZE && frag == rxrpc_tx_point_call_data_frag) {
+	if (ret == -EMSGSIZE && frag == rxrpc_tx_point_call_data_nofrag) {
 		rxrpc_local_dont_fragment(conn->local, false);
 		frag = rxrpc_tx_point_call_data_frag;
 		goto retry;
@@ -575,7 +605,7 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 
 done:
 	if (ret >= 0) {
-		rxrpc_tstamp_data_packets(call, txb);
+		rxrpc_tstamp_data_packets(call, txb, n);
 	} else {
 		/* Cancel the call if the initial transmission fails,
 		 * particularly if that's due to network routing issues that
@@ -775,13 +805,13 @@ static inline void rxrpc_instant_resend(struct rxrpc_call *call,
 }
 
 /*
- * Transmit one packet.
+ * Transmit a packet, possibly gluing several subpackets together.
  */
-void rxrpc_transmit_one(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
+void rxrpc_transmit_data(struct rxrpc_call *call, struct rxrpc_txbuf *txb, int n)
 {
 	int ret;
 
-	ret = rxrpc_send_data_packet(call, txb);
+	ret = rxrpc_send_data_packet(call, txb, n);
 	if (ret < 0) {
 		switch (ret) {
 		case -ENETUNREACH:
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 755897fab626..62b09d23ec08 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -392,15 +392,28 @@ static int rxkad_secure_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 		break;
 	case RXRPC_SECURITY_AUTH:
 		ret = rxkad_secure_packet_auth(call, txb, req);
+		if (txb->alloc_size == RXRPC_JUMBO_DATALEN)
+			txb->jumboable = true;
 		break;
 	case RXRPC_SECURITY_ENCRYPT:
 		ret = rxkad_secure_packet_encrypt(call, txb, req);
+		if (txb->alloc_size == RXRPC_JUMBO_DATALEN)
+			txb->jumboable = true;
 		break;
 	default:
 		ret = -EPERM;
 		break;
 	}
 
+	/* Clear excess space in the packet */
+	if (txb->pkt_len < txb->alloc_size) {
+		struct rxrpc_wire_header *whdr = txb->kvec[0].iov_base;
+		size_t gap = txb->alloc_size - txb->pkt_len;
+		void *p = whdr + 1;
+
+		memset(p + txb->pkt_len, 0, gap);
+	}
+
 	skcipher_request_free(req);
 	_leave(" = %d [set %x]", ret, y);
 	return ret;


