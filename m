Return-Path: <netdev+bounces-148852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2E69E3470
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3AD2811E9
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 07:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C02E18FDDA;
	Wed,  4 Dec 2024 07:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZvWpmJYJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822DB192D9D
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 07:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298479; cv=none; b=CZDqgl8ISZEaASHj3TB1R8Py9chXn3fZjecLCxSJsNvP9HJ4aGHZmjzhH+uI5bSGWCzkKZxLfYcjGLDgsHxe86HtZOay/2U8YjwSFqYpwGVBcF9og2QvV+iT/cxzm7W5MhA86KZZu00CLp93xxU9yUkYCRhYi29nwGswQReeUSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298479; c=relaxed/simple;
	bh=yZpcH3jfOZhaIMhDc90aLeHm+zbrPem84Ky8S2xB72U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+AzkSILlml5WBUk6LPR4FBawrkJo1DBoCq2iWQhpzKVMyYpFk2IauxskoBoypIRvx0lmBwXgqvR3gkhM3zJYNaczlV+MxQMq4K/k1YwJb3XA3YMr0XS/z1D9LN8EmslNlaEl9SNDuwl5KfpMHNo065nexN4bJn1xWCDALX1C/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZvWpmJYJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733298476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7YbPQ3cKw3bKxL4TM3+ZS8qJ4Li9YNqJTqyKnz0s0FM=;
	b=ZvWpmJYJ6qElYSH8T7Wvp/J9M52e/GoVhalCJ7YJH9w2yECDG6ujfw/WOvOqUBFtIDUBUC
	XsyR6P207hbygoYTmAPQ3EpjsgWcvGjv8D5x7A+L/N9jpiYMpUwaqbxkbicPfE1STLOOIE
	RYCeI7g4K4Tay/3K5mq69NZ14NxUQDY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-Him0VSniOuG3SqQfmI2MLw-1; Wed,
 04 Dec 2024 02:47:53 -0500
X-MC-Unique: Him0VSniOuG3SqQfmI2MLw-1
X-Mimecast-MFC-AGG-ID: Him0VSniOuG3SqQfmI2MLw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 526CA1956058;
	Wed,  4 Dec 2024 07:47:52 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ABE351956048;
	Wed,  4 Dec 2024 07:47:49 +0000 (UTC)
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
Subject: [PATCH net-next v2 08/39] rxrpc: Use a large kvec[] in rxrpc_local rather than every rxrpc_txbuf
Date: Wed,  4 Dec 2024 07:46:36 +0000
Message-ID: <20241204074710.990092-9-dhowells@redhat.com>
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

Use a single large kvec[] in the rxrpc_local struct rather than one in
every rxrpc_txbuf struct to build large packets to save on memory.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/ar-internal.h |  6 ++++++
 net/rxrpc/output.c      | 45 ++++++++++++++++++++++++++++++-----------
 2 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index d0fd37bdcfe9..ab8e565cb20b 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -320,6 +320,12 @@ struct rxrpc_local {
 	struct list_head	new_client_calls; /* Newly created client calls need connection */
 	spinlock_t		client_call_lock; /* Lock for ->new_client_calls */
 	struct sockaddr_rxrpc	srx;		/* local address */
+	/* Provide a kvec table sufficiently large to manage either a DATA
+	 * packet with a maximum set of jumbo subpackets or a PING ACK padded
+	 * out to 64K with zeropages for PMTUD.
+	 */
+	struct kvec		kvec[RXRPC_MAX_NR_JUMBO > 3 + 16 ?
+				     RXRPC_MAX_NR_JUMBO : 3 + 16];
 };
 
 /*
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index b93a5d50be3e..f8bb5250e849 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -175,9 +175,11 @@ static void rxrpc_begin_rtt_probe(struct rxrpc_call *call, rxrpc_serial_t serial
 /*
  * Transmit an ACK packet.
  */
-static void rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
+static void rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb,
+				  int nr_kv)
 {
-	struct rxrpc_wire_header *whdr = txb->kvec[0].iov_base;
+	struct kvec *kv = call->local->kvec;
+	struct rxrpc_wire_header *whdr = kv[0].iov_base;
 	struct rxrpc_connection *conn;
 	struct rxrpc_ackpacket *ack = (struct rxrpc_ackpacket *)(whdr + 1);
 	struct msghdr msg;
@@ -206,8 +208,9 @@ static void rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 
 	rxrpc_inc_stat(call->rxnet, stat_tx_ack_send);
 
-	iov_iter_kvec(&msg.msg_iter, WRITE, txb->kvec, txb->nr_kvec, txb->len);
+	iov_iter_kvec(&msg.msg_iter, WRITE, kv, nr_kv, txb->len);
 	rxrpc_local_dont_fragment(conn->local, false);
+
 	ret = do_udp_sendmsg(conn->local->socket, &msg, txb->len);
 	call->peer->last_tx_at = ktime_get_seconds();
 	if (ret < 0) {
@@ -233,6 +236,8 @@ void rxrpc_send_ACK(struct rxrpc_call *call, u8 ack_reason,
 		    rxrpc_serial_t serial, enum rxrpc_propose_ack_trace why)
 {
 	struct rxrpc_txbuf *txb;
+	struct kvec *kv = call->local->kvec;
+	int nr_kv;
 
 	if (test_bit(RXRPC_CALL_DISCONNECTED, &call->flags))
 		return;
@@ -248,12 +253,19 @@ void rxrpc_send_ACK(struct rxrpc_call *call, u8 ack_reason,
 	txb->ack_why = why;
 
 	rxrpc_fill_out_ack(call, txb, ack_reason, serial);
+
+	nr_kv = txb->nr_kvec;
+	kv[0] = txb->kvec[0];
+	kv[1] = txb->kvec[1];
+	kv[2] = txb->kvec[2];
+	// TODO: Extend a path MTU probe ACK
+
 	call->ackr_nr_unacked = 0;
 	atomic_set(&call->ackr_nr_consumed, 0);
 	clear_bit(RXRPC_CALL_RX_IS_IDLE, &call->flags);
 
 	trace_rxrpc_send_ack(call, why, ack_reason, serial);
-	rxrpc_send_ack_packet(call, txb);
+	rxrpc_send_ack_packet(call, txb, nr_kv);
 	rxrpc_put_txbuf(txb, rxrpc_txbuf_put_ack_tx);
 }
 
@@ -324,12 +336,15 @@ int rxrpc_send_abort_packet(struct rxrpc_call *call)
 /*
  * Prepare a (sub)packet for transmission.
  */
-static void rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc_txbuf *txb,
-					 rxrpc_serial_t serial)
+static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc_txbuf *txb,
+					   rxrpc_serial_t serial,
+					   int subpkt)
 {
 	struct rxrpc_wire_header *whdr = txb->kvec[0].iov_base;
 	enum rxrpc_req_ack_trace why;
 	struct rxrpc_connection *conn = call->conn;
+	struct kvec *kv = &call->local->kvec[subpkt];
+	size_t len = txb->len;
 	bool last, more;
 	u8 flags;
 
@@ -385,8 +400,13 @@ static void rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc_t
 	whdr->flags	= flags;
 	whdr->serial	= htonl(txb->serial);
 	whdr->cksum	= txb->cksum;
+	whdr->serviceId	= htons(conn->service_id);
+	kv->iov_base	= whdr;
+	// TODO: Convert into a jumbo header for tail subpackets
 
 	trace_rxrpc_tx_data(call, txb->seq, txb->serial, flags, false);
+	kv->iov_len = len;
+	return len;
 }
 
 /*
@@ -395,13 +415,15 @@ static void rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc_t
 static size_t rxrpc_prepare_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 {
 	rxrpc_serial_t serial;
+	size_t len = 0;
 
 	/* Each transmission of a Tx packet needs a new serial number */
 	serial = rxrpc_get_next_serial(call->conn);
 
-	rxrpc_prepare_data_subpacket(call, txb, serial);
+	len += rxrpc_prepare_data_subpacket(call, txb, serial, 0);
+	// TODO: Loop around adding tail subpackets
 
-	return txb->len;
+	return len;
 }
 
 /*
@@ -442,7 +464,6 @@ static void rxrpc_tstamp_data_packets(struct rxrpc_call *call, struct rxrpc_txbu
  */
 static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 {
-	struct rxrpc_wire_header *whdr = txb->kvec[0].iov_base;
 	struct rxrpc_connection *conn = call->conn;
 	enum rxrpc_tx_point frag;
 	struct msghdr msg;
@@ -463,7 +484,7 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 		}
 	}
 
-	iov_iter_kvec(&msg.msg_iter, WRITE, txb->kvec, txb->nr_kvec, len);
+	iov_iter_kvec(&msg.msg_iter, WRITE, call->local->kvec, 1, len);
 
 	msg.msg_name	= &call->peer->srx.transport;
 	msg.msg_namelen	= call->peer->srx.transport_len;
@@ -480,7 +501,7 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 
 	/* send the packet with the don't fragment bit set if we currently
 	 * think it's small enough */
-	if (txb->len >= call->peer->maxdata) {
+	if (len >= sizeof(struct rxrpc_wire_header) + call->peer->maxdata) {
 		rxrpc_local_dont_fragment(conn->local, false);
 		frag = rxrpc_tx_point_call_data_frag;
 	} else {
@@ -503,7 +524,7 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 		rxrpc_inc_stat(call->rxnet, stat_tx_data_send_fail);
 		trace_rxrpc_tx_fail(call->debug_id, txb->serial, ret, frag);
 	} else {
-		trace_rxrpc_tx_packet(call->debug_id, whdr, frag);
+		trace_rxrpc_tx_packet(call->debug_id, call->local->kvec[0].iov_base, frag);
 	}
 
 	rxrpc_tx_backoff(call, ret);


