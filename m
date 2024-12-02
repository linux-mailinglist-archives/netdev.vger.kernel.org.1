Return-Path: <netdev+bounces-148077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E80DD9E051B
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7FAE287E78
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C10A1FDE2E;
	Mon,  2 Dec 2024 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JekDC2ib"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2577B205AD7
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149912; cv=none; b=WPL75mPkqH7nzbhiUHQA0LmBXROdqfo5OEH+7NPu1GUefX3N2h0sLNh2I8Fqnu6fLYFbqEV59Rqo1Pu7mlrizHBCAoxPK+lBUrMRpLZJTSGxOTB2OzlIEVU5x7zNKVTMV+x6jETa8tGeXMmAYy3M4MP6QHx3k0x02fjzv3aU3qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149912; c=relaxed/simple;
	bh=QbzVWZrUyAClKLmvJ2IoQkdtS7KE4dzfqRF+f6XjOyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWzVcJCARZuIGaT8qS6sA9ZUYBxRINUL8sCgY34xctPPSBe0W/hzrcdKXDhgdv5osk2ihL9qXzfb1pD3aGAU3pohbcn7uCxxZmXGxaVxFXw6dlQ8ASvok/x1kjF6TbIUQ+MBDTR6sqbPQpbE0yx999cQ/OQJ4xBiIqZvQSwY0+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JekDC2ib; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733149909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=apnWQV160/AjP0jQpOnh2pqqsTUNtzFeRqI4zAgI+Kk=;
	b=JekDC2ibPy5KZ5Gj0V9X6dg4vdRiO+All7qLZPZVQtffE+xDuuj6ni5eKYROkO0CCXlkKk
	QAQNePK6PD1jnVG2psLp9y2a76CLAZX9ihPeFFJzhv9bnWbNtELZlNQDL0SMhq5rj3RHnt
	ZUDXJBF7y754z2//pP0gvWycYkFd28I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-Kr9n45umPbWYeqmHg0sK6w-1; Mon,
 02 Dec 2024 09:31:47 -0500
X-MC-Unique: Kr9n45umPbWYeqmHg0sK6w-1
X-Mimecast-MFC-AGG-ID: Kr9n45umPbWYeqmHg0sK6w
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94B8818DA846;
	Mon,  2 Dec 2024 14:31:41 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EBB951956052;
	Mon,  2 Dec 2024 14:31:38 +0000 (UTC)
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
Subject: [PATCH net-next 09/37] rxrpc: Separate the packet length from the data length in rxrpc_txbuf
Date: Mon,  2 Dec 2024 14:30:27 +0000
Message-ID: <20241202143057.378147-10-dhowells@redhat.com>
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
index 9168c149444c..5f33e6c50854 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -382,11 +382,11 @@ static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc
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
 
@@ -440,6 +440,7 @@ static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc
 	whdr->cksum	= txb->cksum;
 	whdr->serviceId	= htons(conn->service_id);
 	kv->iov_base	= whdr;
+	len += sizeof(*whdr);
 	// TODO: Convert into a jumbo header for tail subpackets
 
 	trace_rxrpc_tx_data(call, txb->seq, txb->serial, flags, false);
@@ -508,7 +509,7 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
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


