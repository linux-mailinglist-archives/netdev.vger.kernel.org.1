Return-Path: <netdev+bounces-148854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B609E3478
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E49EB26603
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 07:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F2A196D90;
	Wed,  4 Dec 2024 07:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7qAy+MG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E69F190462
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 07:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298489; cv=none; b=m5HhIhs961zbq5foCN3k77Go9WeNmmxApqhzLFi/cni4zXe/MDkJQGXGdg8eri/r5GxMl6+7YutonWuk7CUJc18tIi3290EpaEFaRPQUgQxyNxVjmti9sfcKlQSuWXKH0DCUdh5zfyBdB/3cNgbYsdz65cjnPUMO1UROmGYT36E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298489; c=relaxed/simple;
	bh=zTMR4ciaXX8z8BIXCn8qa/xEjaRm9tVcN1NCX2QeVl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpDbqCGHCqqY5pOrpAXxyv8bDif/eoSrBItMhqb9W4RXmYEAztjFaa3pWXBPF7DqHzVl+bYRaFpLXQQK7InasmAj1fyehkWV73El/Hg5X/8gcivLHd7xoU5gSIXF11ZiuDHA1u4o5VL2gOtaYo8MElteIf+hKvrUdk89Rksvg/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R7qAy+MG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733298485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hgT0KaAv7Mulncn7BWSw8qo4G9KhUray8DDjrIXNIWU=;
	b=R7qAy+MG669lp6AjYrtQIubNetia0VpwBBy7lWRieq1s0UuE4h3diULarXaNhk0AOOaGJt
	Zxs2DudZ5IDULH3Ctm4QbV9AkYl6WjRaaUNYHYW5Bxv7VYYZQu8QAqy6F7zYQoGNC2avVT
	f5owqRL+a5qaDfI0HI6FmlmetcPwcIs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-8acrGF5jNoW0SGWfDxNbIA-1; Wed,
 04 Dec 2024 02:48:02 -0500
X-MC-Unique: 8acrGF5jNoW0SGWfDxNbIA-1
X-Mimecast-MFC-AGG-ID: 8acrGF5jNoW0SGWfDxNbIA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7AEF91955E7A;
	Wed,  4 Dec 2024 07:48:00 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B3AB41956089;
	Wed,  4 Dec 2024 07:47:57 +0000 (UTC)
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
Subject: [PATCH net-next v2 10/39] rxrpc: Separate the packet length from the data length in rxrpc_txbuf
Date: Wed,  4 Dec 2024 07:46:38 +0000
Message-ID: <20241204074710.990092-11-dhowells@redhat.com>
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

Separate the packet length from the data length (txb->len) stored in the
rxrpc_txbuf to make security calculations easier.  Also store the
allocation size as that's an upper bound on the size of the security
wrapper and change a number of fields to unsigned short as the amount of
data can't exceed the capacity of a UDP packet.

Also, whilst we're at it, use kzalloc() for txbufs.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/ar-internal.h |  8 +++++---
 net/rxrpc/insecure.c    |  1 +
 net/rxrpc/output.c      |  7 ++++---
 net/rxrpc/rxkad.c       | 44 ++++++++++++++++++++++-------------------
 net/rxrpc/sendmsg.c     |  1 -
 net/rxrpc/txbuf.c       |  7 ++-----
 6 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 69e6f4b20bad..a5c0bc917641 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -821,9 +821,11 @@ struct rxrpc_txbuf {
 	rxrpc_serial_t		serial;		/* Last serial number transmitted with */
 	unsigned int		call_debug_id;
 	unsigned int		debug_id;
-	unsigned int		len;		/* Amount of data in buffer */
-	unsigned int		space;		/* Remaining data space */
-	unsigned int		offset;		/* Offset of fill point */
+	unsigned short		len;		/* Amount of data in buffer */
+	unsigned short		space;		/* Remaining data space */
+	unsigned short		offset;		/* Offset of fill point */
+	unsigned short		pkt_len;	/* Size of packet content */
+	unsigned short		alloc_size;	/* Amount of bufferage allocated */
 	unsigned int		flags;
 #define RXRPC_TXBUF_WIRE_FLAGS	0xff		/* The wire protocol flags */
 #define RXRPC_TXBUF_RESENT	0x100		/* Set if has been resent */
diff --git a/net/rxrpc/insecure.c b/net/rxrpc/insecure.c
index 751eb621021d..d665f486be5f 100644
--- a/net/rxrpc/insecure.c
+++ b/net/rxrpc/insecure.c
@@ -24,6 +24,7 @@ static struct rxrpc_txbuf *none_alloc_txbuf(struct rxrpc_call *call, size_t rema
 
 static int none_secure_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 {
+	txb->pkt_len = txb->len;
 	return 0;
 }
 
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index a91be871ad96..df9af4ad4260 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -383,11 +383,11 @@ static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc
 	enum rxrpc_req_ack_trace why;
 	struct rxrpc_connection *conn = call->conn;
 	struct kvec *kv = &call->local->kvec[subpkt];
-	size_t len = txb->len;
+	size_t len = txb->pkt_len;
 	bool last, more;
 	u8 flags;
 
-	_enter("%x,{%d}", txb->seq, txb->len);
+	_enter("%x,%zd", txb->seq, len);
 
 	txb->serial = serial;
 
@@ -441,6 +441,7 @@ static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc
 	whdr->cksum	= txb->cksum;
 	whdr->serviceId	= htons(conn->service_id);
 	kv->iov_base	= whdr;
+	len += sizeof(*whdr);
 	// TODO: Convert into a jumbo header for tail subpackets
 
 	trace_rxrpc_tx_data(call, txb->seq, txb->serial, flags, false);
@@ -509,7 +510,7 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 	size_t len;
 	int ret;
 
-	_enter("%x,{%d}", txb->seq, txb->len);
+	_enter("%x,{%d}", txb->seq, txb->pkt_len);
 
 	len = rxrpc_prepare_data_packet(call, txb);
 
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index e3194d73dd84..755897fab626 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -148,14 +148,14 @@ static int rxkad_init_connection_security(struct rxrpc_connection *conn,
 static struct rxrpc_txbuf *rxkad_alloc_txbuf(struct rxrpc_call *call, size_t remain, gfp_t gfp)
 {
 	struct rxrpc_txbuf *txb;
-	size_t shdr, space;
+	size_t shdr, alloc, limit, part;
 
 	remain = umin(remain, 65535 - sizeof(struct rxrpc_wire_header));
 
 	switch (call->conn->security_level) {
 	default:
-		space = umin(remain, RXRPC_JUMBO_DATALEN);
-		return rxrpc_alloc_data_txbuf(call, space, 1, gfp);
+		alloc = umin(remain, RXRPC_JUMBO_DATALEN);
+		return rxrpc_alloc_data_txbuf(call, alloc, 1, gfp);
 	case RXRPC_SECURITY_AUTH:
 		shdr = sizeof(struct rxkad_level1_hdr);
 		break;
@@ -164,15 +164,21 @@ static struct rxrpc_txbuf *rxkad_alloc_txbuf(struct rxrpc_call *call, size_t rem
 		break;
 	}
 
-	space = umin(round_down(RXRPC_JUMBO_DATALEN, RXKAD_ALIGN), remain + shdr);
-	space = round_up(space, RXKAD_ALIGN);
+	limit = round_down(RXRPC_JUMBO_DATALEN, RXKAD_ALIGN) - shdr;
+	if (remain < limit) {
+		part = remain;
+		alloc = round_up(shdr + part, RXKAD_ALIGN);
+	} else {
+		part = limit;
+		alloc = RXRPC_JUMBO_DATALEN;
+	}
 
-	txb = rxrpc_alloc_data_txbuf(call, space, RXKAD_ALIGN, gfp);
+	txb = rxrpc_alloc_data_txbuf(call, alloc, RXKAD_ALIGN, gfp);
 	if (!txb)
 		return NULL;
 
 	txb->offset += shdr;
-	txb->space -= shdr;
+	txb->space = part;
 	return txb;
 }
 
@@ -263,13 +269,13 @@ static int rxkad_secure_packet_auth(const struct rxrpc_call *call,
 	check = txb->seq ^ call->call_id;
 	hdr->data_size = htonl((u32)check << 16 | txb->len);
 
-	txb->len += sizeof(struct rxkad_level1_hdr);
-	pad = txb->len;
+	txb->pkt_len = sizeof(struct rxkad_level1_hdr) + txb->len;
+	pad = txb->pkt_len;
 	pad = RXKAD_ALIGN - pad;
 	pad &= RXKAD_ALIGN - 1;
 	if (pad) {
 		memset(txb->kvec[0].iov_base + txb->offset, 0, pad);
-		txb->len += pad;
+		txb->pkt_len += pad;
 	}
 
 	/* start the encryption afresh */
@@ -298,7 +304,7 @@ static int rxkad_secure_packet_encrypt(const struct rxrpc_call *call,
 	struct rxkad_level2_hdr *rxkhdr = (void *)(whdr + 1);
 	struct rxrpc_crypt iv;
 	struct scatterlist sg;
-	size_t pad;
+	size_t content, pad;
 	u16 check;
 	int ret;
 
@@ -309,23 +315,20 @@ static int rxkad_secure_packet_encrypt(const struct rxrpc_call *call,
 	rxkhdr->data_size = htonl(txb->len | (u32)check << 16);
 	rxkhdr->checksum = 0;
 
-	txb->len += sizeof(struct rxkad_level2_hdr);
-	pad = txb->len;
-	pad = RXKAD_ALIGN - pad;
-	pad &= RXKAD_ALIGN - 1;
-	if (pad) {
+	content = sizeof(struct rxkad_level2_hdr) + txb->len;
+	txb->pkt_len = round_up(content, RXKAD_ALIGN);
+	pad = txb->pkt_len - content;
+	if (pad)
 		memset(txb->kvec[0].iov_base + txb->offset, 0, pad);
-		txb->len += pad;
-	}
 
 	/* encrypt from the session key */
 	token = call->conn->key->payload.data[0];
 	memcpy(&iv, token->kad->session_key, sizeof(iv));
 
-	sg_init_one(&sg, rxkhdr, txb->len);
+	sg_init_one(&sg, rxkhdr, txb->pkt_len);
 	skcipher_request_set_sync_tfm(req, call->conn->rxkad.cipher);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
-	skcipher_request_set_crypt(req, &sg, &sg, txb->len, iv.x);
+	skcipher_request_set_crypt(req, &sg, &sg, txb->pkt_len, iv.x);
 	ret = crypto_skcipher_encrypt(req);
 	skcipher_request_zero(req);
 	return ret;
@@ -384,6 +387,7 @@ static int rxkad_secure_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 
 	switch (call->conn->security_level) {
 	case RXRPC_SECURITY_PLAIN:
+		txb->pkt_len = txb->len;
 		ret = 0;
 		break;
 	case RXRPC_SECURITY_AUTH:
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 546abb463c3f..786c1fb1369a 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -391,7 +391,6 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 				goto out;
 
 			txb->kvec[0].iov_len += txb->len;
-			txb->len = txb->kvec[0].iov_len;
 			rxrpc_queue_packet(rx, call, txb, notify_end_tx);
 			txb = NULL;
 		}
diff --git a/net/rxrpc/txbuf.c b/net/rxrpc/txbuf.c
index 2a4291617d40..8b7c854ed3d7 100644
--- a/net/rxrpc/txbuf.c
+++ b/net/rxrpc/txbuf.c
@@ -24,7 +24,7 @@ struct rxrpc_txbuf *rxrpc_alloc_data_txbuf(struct rxrpc_call *call, size_t data_
 	size_t total, hoff;
 	void *buf;
 
-	txb = kmalloc(sizeof(*txb), gfp);
+	txb = kzalloc(sizeof(*txb), gfp);
 	if (!txb)
 		return NULL;
 
@@ -49,14 +49,11 @@ struct rxrpc_txbuf *rxrpc_alloc_data_txbuf(struct rxrpc_call *call, size_t data_
 	txb->last_sent		= KTIME_MIN;
 	txb->call_debug_id	= call->debug_id;
 	txb->debug_id		= atomic_inc_return(&rxrpc_txbuf_debug_ids);
+	txb->alloc_size		= data_size;
 	txb->space		= data_size;
-	txb->len		= 0;
 	txb->offset		= sizeof(*whdr);
 	txb->flags		= call->conn->out_clientflag;
-	txb->ack_why		= 0;
 	txb->seq		= call->tx_prepared + 1;
-	txb->serial		= 0;
-	txb->cksum		= 0;
 	txb->nr_kvec		= 1;
 	txb->kvec[0].iov_base	= whdr;
 	txb->kvec[0].iov_len	= sizeof(*whdr);


