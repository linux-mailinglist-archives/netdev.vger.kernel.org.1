Return-Path: <netdev+bounces-148878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 083AB9E34C5
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 09:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35A99B32C6B
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 07:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7811FA252;
	Wed,  4 Dec 2024 07:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+YreIzL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9901E0496
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298578; cv=none; b=GgHBT8LsrDFmgNrVHXXreuhcl/x0TykO2MkTKx/AfnA11BELNm7gbXwIIJnJdIk5EeBkBfIvdL02/2xGZR0aqTLgSPahKCdHPxAY0qKQp8f997ZqtRuE1Yq79Tj4gkmxGOy0Yk2lMmHuY78yiAhhsA09hVTTgdxPGF6JbSFYwZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298578; c=relaxed/simple;
	bh=r6XxiMorSB7iCxcRmjAn6I0MmLgfybiYXyywp/2AbvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGXkmfe8J+1PB8h7Y1lKZGCy29eNgPtSqrhLMtvYfCBKl6faKnFvKtSzSvRs+Qnm/CT6JYVCMB1E9HypVTdxmr+Qeh2Yt9mKEKYMKsr9x/pTfSUkZzSWyRt09YdHttjo0gz2mJndcoP2t38XdftkhDv8cpquPFdq4z0+/MOohGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+YreIzL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733298575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1fNoQdyhV9AAcRe00YDnSdUYOhhnLt52W/9/eqOE1q8=;
	b=V+YreIzLYYde9XKEYNgRAfRxPoC6eQXK/6+/1LwerfCxEZ/HGkaOnUhbYooYuwarv7SWPm
	uElOY5xINAMyS3g37H/dbYxFc6i5KD7i60p5IOFbG7iUsC++5AYv+Uu8BxXViYvDiwwSb5
	FcrMLT81OPyJKvxGalbqOGZl5+D2SWI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-JPgeBJCgMCeNmsFB1B_1iQ-1; Wed,
 04 Dec 2024 02:49:31 -0500
X-MC-Unique: JPgeBJCgMCeNmsFB1B_1iQ-1
X-Mimecast-MFC-AGG-ID: JPgeBJCgMCeNmsFB1B_1iQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55D6E1956055;
	Wed,  4 Dec 2024 07:49:30 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C76083000197;
	Wed,  4 Dec 2024 07:49:27 +0000 (UTC)
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
Subject: [PATCH net-next v2 32/39] rxrpc: Don't allocate a txbuf for an ACK transmission
Date: Wed,  4 Dec 2024 07:47:00 +0000
Message-ID: <20241204074710.990092-33-dhowells@redhat.com>
In-Reply-To: <20241204074710.990092-1-dhowells@redhat.com>
References: <20241204074710.990092-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Don't allocate an rxrpc_txbuf struct for an ACK transmission.  There's now
no need as the memory to hold the ACK content is allocated with a page frag
allocator.  The allocation and freeing of a txbuf is just unnecessary
overhead.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h |   2 -
 net/rxrpc/ar-internal.h      |   5 +-
 net/rxrpc/output.c           | 210 ++++++++++++++++++++++-------------
 net/rxrpc/txbuf.c            |  76 -------------
 4 files changed, 131 insertions(+), 162 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 7681c67f7d65..326a4c257aea 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -462,13 +462,11 @@
 /* ---- Must update size of stat_why_req_ack[] if more are added! */
 
 #define rxrpc_txbuf_traces \
-	EM(rxrpc_txbuf_alloc_ack,		"ALLOC ACK  ")	\
 	EM(rxrpc_txbuf_alloc_data,		"ALLOC DATA ")	\
 	EM(rxrpc_txbuf_free,			"FREE       ")	\
 	EM(rxrpc_txbuf_get_buffer,		"GET BUFFER ")	\
 	EM(rxrpc_txbuf_get_trans,		"GET TRANS  ")	\
 	EM(rxrpc_txbuf_get_retrans,		"GET RETRANS")	\
-	EM(rxrpc_txbuf_put_ack_tx,		"PUT ACK TX ")	\
 	EM(rxrpc_txbuf_put_cleaned,		"PUT CLEANED")	\
 	EM(rxrpc_txbuf_put_nomem,		"PUT NOMEM  ")	\
 	EM(rxrpc_txbuf_put_rotated,		"PUT ROTATED")	\
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 1307749a1a74..db93d7f78902 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -834,11 +834,9 @@ struct rxrpc_txbuf {
 #define RXRPC_TXBUF_WIRE_FLAGS	0xff		/* The wire protocol flags */
 #define RXRPC_TXBUF_RESENT	0x100		/* Set if has been resent */
 	__be16			cksum;		/* Checksum to go in header */
-	unsigned short		ack_rwind;	/* ACK receive window */
-	u8 /*enum rxrpc_propose_ack_trace*/ ack_why;	/* If ack, why */
 	bool			jumboable;	/* Can be non-terminal jumbo subpacket */
 	u8			nr_kvec;	/* Amount of kvec[] used */
-	struct kvec		kvec[3];
+	struct kvec		kvec[1];
 };
 
 static inline bool rxrpc_sending_to_server(const struct rxrpc_txbuf *txb)
@@ -1364,7 +1362,6 @@ static inline void rxrpc_sysctl_exit(void) {}
 extern atomic_t rxrpc_nr_txbuf;
 struct rxrpc_txbuf *rxrpc_alloc_data_txbuf(struct rxrpc_call *call, size_t data_size,
 					   size_t data_align, gfp_t gfp);
-struct rxrpc_txbuf *rxrpc_alloc_ack_txbuf(struct rxrpc_call *call, size_t sack_size);
 void rxrpc_get_txbuf(struct rxrpc_txbuf *txb, enum rxrpc_txbuf_trace what);
 void rxrpc_see_txbuf(struct rxrpc_txbuf *txb, enum rxrpc_txbuf_trace what);
 void rxrpc_put_txbuf(struct rxrpc_txbuf *txb, enum rxrpc_txbuf_trace what);
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 20bf45317264..a7de8a02f419 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -71,22 +71,97 @@ static void rxrpc_set_keepalive(struct rxrpc_call *call, ktime_t now)
 	trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_keepalive);
 }
 
+/*
+ * Allocate transmission buffers for an ACK and attach them to local->kv[].
+ */
+static int rxrpc_alloc_ack(struct rxrpc_call *call, size_t sack_size)
+{
+	struct rxrpc_wire_header *whdr;
+	struct rxrpc_acktrailer *trailer;
+	struct rxrpc_ackpacket *ack;
+	struct kvec *kv = call->local->kvec;
+	gfp_t gfp = rcu_read_lock_held() ? GFP_ATOMIC | __GFP_NOWARN : GFP_NOFS;
+	void *buf, *buf2 = NULL;
+	u8 *filler;
+
+	buf = page_frag_alloc(&call->local->tx_alloc,
+			      sizeof(*whdr) + sizeof(*ack) + 1 + 3 + sizeof(*trailer), gfp);
+	if (!buf)
+		return -ENOMEM;
+
+	if (sack_size) {
+		buf2 = page_frag_alloc(&call->local->tx_alloc, sack_size, gfp);
+		if (!buf2) {
+			page_frag_free(buf);
+			return -ENOMEM;
+		}
+	}
+
+	whdr	= buf;
+	ack	= buf + sizeof(*whdr);
+	filler	= buf + sizeof(*whdr) + sizeof(*ack) + 1;
+	trailer	= buf + sizeof(*whdr) + sizeof(*ack) + 1 + 3;
+
+	kv[0].iov_base	= whdr;
+	kv[0].iov_len	= sizeof(*whdr) + sizeof(*ack);
+	kv[1].iov_base	= buf2;
+	kv[1].iov_len	= sack_size;
+	kv[2].iov_base	= filler;
+	kv[2].iov_len	= 3 + sizeof(*trailer);
+	return 3; /* Number of kvec[] used. */
+}
+
+static void rxrpc_free_ack(struct rxrpc_call *call)
+{
+	page_frag_free(call->local->kvec[0].iov_base);
+	if (call->local->kvec[1].iov_base)
+		page_frag_free(call->local->kvec[1].iov_base);
+}
+
+/*
+ * Record the beginning of an RTT probe.
+ */
+static void rxrpc_begin_rtt_probe(struct rxrpc_call *call, rxrpc_serial_t serial,
+				  ktime_t now, enum rxrpc_rtt_tx_trace why)
+{
+	unsigned long avail = call->rtt_avail;
+	int rtt_slot = 9;
+
+	if (!(avail & RXRPC_CALL_RTT_AVAIL_MASK))
+		goto no_slot;
+
+	rtt_slot = __ffs(avail & RXRPC_CALL_RTT_AVAIL_MASK);
+	if (!test_and_clear_bit(rtt_slot, &call->rtt_avail))
+		goto no_slot;
+
+	call->rtt_serial[rtt_slot] = serial;
+	call->rtt_sent_at[rtt_slot] = now;
+	smp_wmb(); /* Write data before avail bit */
+	set_bit(rtt_slot + RXRPC_CALL_RTT_PEND_SHIFT, &call->rtt_avail);
+
+	trace_rxrpc_rtt_tx(call, why, rtt_slot, serial);
+	return;
+
+no_slot:
+	trace_rxrpc_rtt_tx(call, rxrpc_rtt_tx_no_slot, rtt_slot, serial);
+}
+
 /*
  * Fill out an ACK packet.
  */
-static void rxrpc_fill_out_ack(struct rxrpc_call *call,
-			       struct rxrpc_txbuf *txb,
-			       u8 ack_reason,
-			       rxrpc_serial_t serial)
+static int rxrpc_fill_out_ack(struct rxrpc_call *call, int nr_kv, u8 ack_reason,
+			      rxrpc_serial_t serial_to_ack, rxrpc_serial_t *_ack_serial)
 {
-	struct rxrpc_wire_header *whdr = txb->kvec[0].iov_base;
-	struct rxrpc_acktrailer *trailer = txb->kvec[2].iov_base + 3;
+	struct kvec *kv = call->local->kvec;
+	struct rxrpc_wire_header *whdr = kv[0].iov_base;
+	struct rxrpc_acktrailer *trailer = kv[2].iov_base + 3;
 	struct rxrpc_ackpacket *ack = (struct rxrpc_ackpacket *)(whdr + 1);
 	unsigned int qsize, sack, wrap, to, max_mtu, if_mtu;
 	rxrpc_seq_t window, wtop;
+	ktime_t now = ktime_get_real();
 	int rsize;
-	u8 *filler = txb->kvec[2].iov_base;
-	u8 *sackp = txb->kvec[1].iov_base;
+	u8 *filler = kv[2].iov_base;
+	u8 *sackp = kv[1].iov_base;
 
 	rxrpc_inc_stat(call->rxnet, stat_tx_ack_fill);
 
@@ -94,14 +169,25 @@ static void rxrpc_fill_out_ack(struct rxrpc_call *call,
 	wtop   = call->ackr_wtop;
 	sack   = call->ackr_sack_base % RXRPC_SACK_SIZE;
 
+	*_ack_serial = rxrpc_get_next_serial(call->conn);
+
+	whdr->epoch		= htonl(call->conn->proto.epoch);
+	whdr->cid		= htonl(call->cid);
+	whdr->callNumber	= htonl(call->call_id);
+	whdr->serial		= htonl(*_ack_serial);
 	whdr->seq		= 0;
 	whdr->type		= RXRPC_PACKET_TYPE_ACK;
-	txb->flags		|= RXRPC_SLOW_START_OK;
+	whdr->flags		= call->conn->out_clientflag | RXRPC_SLOW_START_OK;
+	whdr->userStatus	= 0;
+	whdr->securityIndex	= call->security_ix;
+	whdr->_rsvd		= 0;
+	whdr->serviceId		= htons(call->dest_srx.srx_service);
+
 	ack->bufferSpace	= 0;
 	ack->maxSkew		= 0;
 	ack->firstPacket	= htonl(window);
 	ack->previousPacket	= htonl(call->rx_highest_seq);
-	ack->serial		= htonl(serial);
+	ack->serial		= htonl(serial_to_ack);
 	ack->reason		= ack_reason;
 	ack->nAcks		= wtop - window;
 	filler[0]		= 0;
@@ -109,12 +195,10 @@ static void rxrpc_fill_out_ack(struct rxrpc_call *call,
 	filler[2]		= 0;
 
 	if (ack_reason == RXRPC_ACK_PING)
-		txb->flags |= RXRPC_REQUEST_ACK;
+		whdr->flags |= RXRPC_REQUEST_ACK;
 
 	if (after(wtop, window)) {
-		txb->len += ack->nAcks;
-		txb->kvec[1].iov_base = sackp;
-		txb->kvec[1].iov_len = ack->nAcks;
+		kv[1].iov_len = ack->nAcks;
 
 		wrap = RXRPC_SACK_SIZE - sack;
 		to = umin(ack->nAcks, RXRPC_SACK_SIZE);
@@ -133,7 +217,6 @@ static void rxrpc_fill_out_ack(struct rxrpc_call *call,
 
 	qsize = (window - 1) - call->rx_consumed;
 	rsize = max_t(int, call->rx_winsize - qsize, 0);
-	txb->ack_rwind = rsize;
 
 	if_mtu = call->peer->if_mtu - call->peer->hdrsize;
 	if (call->peer->ackr_adv_pmtud) {
@@ -147,48 +230,27 @@ static void rxrpc_fill_out_ack(struct rxrpc_call *call,
 	trailer->ifMTU		= htonl(if_mtu);
 	trailer->rwind		= htonl(rsize);
 	trailer->jumbo_max	= 0; /* Advertise pmtu discovery */
-}
-
-/*
- * Record the beginning of an RTT probe.
- */
-static void rxrpc_begin_rtt_probe(struct rxrpc_call *call, rxrpc_serial_t serial,
-				  ktime_t now, enum rxrpc_rtt_tx_trace why)
-{
-	unsigned long avail = call->rtt_avail;
-	int rtt_slot = 9;
 
-	if (!(avail & RXRPC_CALL_RTT_AVAIL_MASK))
-		goto no_slot;
-
-	rtt_slot = __ffs(avail & RXRPC_CALL_RTT_AVAIL_MASK);
-	if (!test_and_clear_bit(rtt_slot, &call->rtt_avail))
-		goto no_slot;
-
-	call->rtt_serial[rtt_slot] = serial;
-	call->rtt_sent_at[rtt_slot] = now;
-	smp_wmb(); /* Write data before avail bit */
-	set_bit(rtt_slot + RXRPC_CALL_RTT_PEND_SHIFT, &call->rtt_avail);
-
-	trace_rxrpc_rtt_tx(call, why, rtt_slot, serial);
-	return;
-
-no_slot:
-	trace_rxrpc_rtt_tx(call, rxrpc_rtt_tx_no_slot, rtt_slot, serial);
+	if (ack_reason == RXRPC_ACK_PING)
+		rxrpc_begin_rtt_probe(call, *_ack_serial, now, rxrpc_rtt_tx_ping);
+	if (whdr->flags & RXRPC_REQUEST_ACK)
+		call->peer->rtt_last_req = now;
+	rxrpc_set_keepalive(call, now);
+	return nr_kv;
 }
 
 /*
  * Transmit an ACK packet.
  */
-static void rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb,
-				  int nr_kv, enum rxrpc_propose_ack_trace why)
+static void rxrpc_send_ack_packet(struct rxrpc_call *call, int nr_kv, size_t len,
+				  rxrpc_serial_t serial, enum rxrpc_propose_ack_trace why)
 {
 	struct kvec *kv = call->local->kvec;
 	struct rxrpc_wire_header *whdr = kv[0].iov_base;
+	struct rxrpc_acktrailer *trailer = kv[2].iov_base + 3;
 	struct rxrpc_connection *conn;
 	struct rxrpc_ackpacket *ack = (struct rxrpc_ackpacket *)(whdr + 1);
 	struct msghdr msg;
-	ktime_t now;
 	int ret;
 
 	if (test_bit(RXRPC_CALL_DISCONNECTED, &call->flags))
@@ -202,41 +264,31 @@ static void rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 	msg.msg_controllen = 0;
 	msg.msg_flags	= MSG_SPLICE_PAGES;
 
-	whdr->flags = txb->flags & RXRPC_TXBUF_WIRE_FLAGS;
-
-	txb->serial = rxrpc_get_next_serial(conn);
-	whdr->serial = htonl(txb->serial);
-	trace_rxrpc_tx_ack(call->debug_id, txb->serial,
+	trace_rxrpc_tx_ack(call->debug_id, serial,
 			   ntohl(ack->firstPacket),
 			   ntohl(ack->serial), ack->reason, ack->nAcks,
-			   txb->ack_rwind);
+			   ntohl(trailer->rwind));
 
 	rxrpc_inc_stat(call->rxnet, stat_tx_ack_send);
 
-	iov_iter_kvec(&msg.msg_iter, WRITE, kv, nr_kv, txb->len);
+	iov_iter_kvec(&msg.msg_iter, WRITE, kv, nr_kv, len);
 	rxrpc_local_dont_fragment(conn->local, why == rxrpc_propose_ack_ping_for_mtu_probe);
 
-	ret = do_udp_sendmsg(conn->local->socket, &msg, txb->len);
+	ret = do_udp_sendmsg(conn->local->socket, &msg, len);
 	call->peer->last_tx_at = ktime_get_seconds();
 	if (ret < 0) {
-		trace_rxrpc_tx_fail(call->debug_id, txb->serial, ret,
+		trace_rxrpc_tx_fail(call->debug_id, serial, ret,
 				    rxrpc_tx_point_call_ack);
 		if (why == rxrpc_propose_ack_ping_for_mtu_probe &&
 		    ret == -EMSGSIZE)
-			rxrpc_input_probe_for_pmtud(conn, txb->serial, true);
+			rxrpc_input_probe_for_pmtud(conn, serial, true);
 	} else {
 		trace_rxrpc_tx_packet(call->debug_id, whdr,
 				      rxrpc_tx_point_call_ack);
-		now = ktime_get_real();
-		if (ack->reason == RXRPC_ACK_PING)
-			rxrpc_begin_rtt_probe(call, txb->serial, now, rxrpc_rtt_tx_ping);
-		if (txb->flags & RXRPC_REQUEST_ACK)
-			call->peer->rtt_last_req = now;
-		rxrpc_set_keepalive(call, now);
 		if (why == rxrpc_propose_ack_ping_for_mtu_probe) {
 			call->peer->pmtud_pending = false;
 			call->peer->pmtud_probing = true;
-			call->conn->pmtud_probe = txb->serial;
+			call->conn->pmtud_probe = serial;
 			call->conn->pmtud_call = call->debug_id;
 			trace_rxrpc_pmtud_tx(call);
 		}
@@ -248,10 +300,11 @@ static void rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
  * Queue an ACK for immediate transmission.
  */
 void rxrpc_send_ACK(struct rxrpc_call *call, u8 ack_reason,
-		    rxrpc_serial_t serial, enum rxrpc_propose_ack_trace why)
+		    rxrpc_serial_t serial_to_ack, enum rxrpc_propose_ack_trace why)
 {
-	struct rxrpc_txbuf *txb;
 	struct kvec *kv = call->local->kvec;
+	rxrpc_serial_t ack_serial;
+	size_t len;
 	int nr_kv;
 
 	if (test_bit(RXRPC_CALL_DISCONNECTED, &call->flags))
@@ -259,32 +312,29 @@ void rxrpc_send_ACK(struct rxrpc_call *call, u8 ack_reason,
 
 	rxrpc_inc_stat(call->rxnet, stat_tx_acks[ack_reason]);
 
-	txb = rxrpc_alloc_ack_txbuf(call, call->ackr_wtop - call->ackr_window);
-	if (!txb) {
+	nr_kv = rxrpc_alloc_ack(call, call->ackr_wtop - call->ackr_window);
+	if (nr_kv < 0) {
 		kleave(" = -ENOMEM");
 		return;
 	}
 
-	txb->ack_why = why;
-
-	rxrpc_fill_out_ack(call, txb, ack_reason, serial);
+	nr_kv = rxrpc_fill_out_ack(call, nr_kv, ack_reason, serial_to_ack, &ack_serial);
+	len  = kv[0].iov_len;
+	len += kv[1].iov_len;
+	len += kv[2].iov_len;
 
 	/* Extend a path MTU probe ACK. */
-	nr_kv = txb->nr_kvec;
-	kv[0] = txb->kvec[0];
-	kv[1] = txb->kvec[1];
-	kv[2] = txb->kvec[2];
 	if (why == rxrpc_propose_ack_ping_for_mtu_probe) {
 		size_t probe_mtu = call->peer->pmtud_trial + sizeof(struct rxrpc_wire_header);
 
-		if (txb->len > probe_mtu)
+		if (len > probe_mtu)
 			goto skip;
-		while (txb->len < probe_mtu) {
-			size_t part = umin(probe_mtu - txb->len, PAGE_SIZE);
+		while (len < probe_mtu) {
+			size_t part = umin(probe_mtu - len, PAGE_SIZE);
 
 			kv[nr_kv].iov_base = page_address(ZERO_PAGE(0));
 			kv[nr_kv].iov_len = part;
-			txb->len += part;
+			len += part;
 			nr_kv++;
 		}
 	}
@@ -293,10 +343,10 @@ void rxrpc_send_ACK(struct rxrpc_call *call, u8 ack_reason,
 	atomic_set(&call->ackr_nr_consumed, 0);
 	clear_bit(RXRPC_CALL_RX_IS_IDLE, &call->flags);
 
-	trace_rxrpc_send_ack(call, why, ack_reason, serial);
-	rxrpc_send_ack_packet(call, txb, nr_kv, why);
+	trace_rxrpc_send_ack(call, why, ack_reason, ack_serial);
+	rxrpc_send_ack_packet(call, nr_kv, len, ack_serial, why);
 skip:
-	rxrpc_put_txbuf(txb, rxrpc_txbuf_put_ack_tx);
+	rxrpc_free_ack(call);
 }
 
 /*
diff --git a/net/rxrpc/txbuf.c b/net/rxrpc/txbuf.c
index 067223c8c35f..131d9e55c8e9 100644
--- a/net/rxrpc/txbuf.c
+++ b/net/rxrpc/txbuf.c
@@ -73,82 +73,6 @@ struct rxrpc_txbuf *rxrpc_alloc_data_txbuf(struct rxrpc_call *call, size_t data_
 	return txb;
 }
 
-/*
- * Allocate and partially initialise an ACK packet.
- */
-struct rxrpc_txbuf *rxrpc_alloc_ack_txbuf(struct rxrpc_call *call, size_t sack_size)
-{
-	struct rxrpc_wire_header *whdr;
-	struct rxrpc_acktrailer *trailer;
-	struct rxrpc_ackpacket *ack;
-	struct rxrpc_txbuf *txb;
-	gfp_t gfp = rcu_read_lock_held() ? GFP_ATOMIC | __GFP_NOWARN : GFP_NOFS;
-	void *buf, *buf2 = NULL;
-	u8 *filler;
-
-	txb = kmalloc(sizeof(*txb), gfp);
-	if (!txb)
-		return NULL;
-
-	buf = page_frag_alloc(&call->local->tx_alloc,
-			      sizeof(*whdr) + sizeof(*ack) + 1 + 3 + sizeof(*trailer), gfp);
-	if (!buf) {
-		kfree(txb);
-		return NULL;
-	}
-
-	if (sack_size) {
-		buf2 = page_frag_alloc(&call->local->tx_alloc, sack_size, gfp);
-		if (!buf2) {
-			page_frag_free(buf);
-			kfree(txb);
-			return NULL;
-		}
-	}
-
-	whdr	= buf;
-	ack	= buf + sizeof(*whdr);
-	filler	= buf + sizeof(*whdr) + sizeof(*ack) + 1;
-	trailer	= buf + sizeof(*whdr) + sizeof(*ack) + 1 + 3;
-
-	refcount_set(&txb->ref, 1);
-	txb->call_debug_id	= call->debug_id;
-	txb->debug_id		= atomic_inc_return(&rxrpc_txbuf_debug_ids);
-	txb->space		= 0;
-	txb->len		= sizeof(*whdr) + sizeof(*ack) + 3 + sizeof(*trailer);
-	txb->offset		= 0;
-	txb->flags		= call->conn->out_clientflag;
-	txb->ack_rwind		= 0;
-	txb->seq		= 0;
-	txb->serial		= 0;
-	txb->cksum		= 0;
-	txb->nr_kvec		= 3;
-	txb->kvec[0].iov_base	= whdr;
-	txb->kvec[0].iov_len	= sizeof(*whdr) + sizeof(*ack);
-	txb->kvec[1].iov_base	= buf2;
-	txb->kvec[1].iov_len	= sack_size;
-	txb->kvec[2].iov_base	= filler;
-	txb->kvec[2].iov_len	= 3 + sizeof(*trailer);
-
-	whdr->epoch		= htonl(call->conn->proto.epoch);
-	whdr->cid		= htonl(call->cid);
-	whdr->callNumber	= htonl(call->call_id);
-	whdr->seq		= 0;
-	whdr->type		= RXRPC_PACKET_TYPE_ACK;
-	whdr->flags		= 0;
-	whdr->userStatus	= 0;
-	whdr->securityIndex	= call->security_ix;
-	whdr->_rsvd		= 0;
-	whdr->serviceId		= htons(call->dest_srx.srx_service);
-
-	get_page(virt_to_head_page(trailer));
-
-	trace_rxrpc_txbuf(txb->debug_id, txb->call_debug_id, txb->seq, 1,
-			  rxrpc_txbuf_alloc_ack);
-	atomic_inc(&rxrpc_nr_txbuf);
-	return txb;
-}
-
 void rxrpc_get_txbuf(struct rxrpc_txbuf *txb, enum rxrpc_txbuf_trace what)
 {
 	int r;


