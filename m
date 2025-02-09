Return-Path: <netdev+bounces-164514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588ADA2E058
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 21:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA23C163E5F
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 20:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA9F1E283C;
	Sun,  9 Feb 2025 20:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YN6tYGkq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D76250F8
	for <netdev@vger.kernel.org>; Sun,  9 Feb 2025 20:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739131690; cv=none; b=epiMnIQom4GkH0UM8gJwIAHZRC59ztxLlQK/KhfHWjIp4YIVgJClv0f79c6ScX8PZD8N8HYqKw9Kipk/vh4IC7BWfgDjhal+F7CtVwl7MLGGepW1sMis0lzEjo7zFAtJvFA3DfNDCbi39Uss3K+jaymxn/ixurd43ISaOy2aCaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739131690; c=relaxed/simple;
	bh=fjpVmTq5OpCw0HnP3ObqFklrc4Hkt++BlYiH/vU+HoM=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=g/l25tsP/ENK3xAZsCwdcbOF/xrfMx7ujGQLXfmiyofVFCUFxDknto/uR5pwhqJ5LzMRNexfTM86MY36H+tRfLEwZ8XNJzxG7c3OQoGCiGP3Q9Pthsqhx/4hTRYVB33QmgMhRvzDiq/neeQEtALqI107CxcqcyUR9pKevo5pIAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YN6tYGkq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739131686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lAMsaBjYO4j3Phwj4i/5A+wjsAwl8Hd6oinJTFtnBFk=;
	b=YN6tYGkqTcLYAG/3o4mzq8GnN0J8gh/tEznvVlNFz9TveP1+RvdCW5wibzfvEhcjsMZHlY
	/zlXOiX3M0+1yuBFejfOiZu4x910KiHaKKJlixjLm+dXrr7c+eppqoHBBeQZSXYDPlj7pu
	Qn5Eu61MdkG5qaISKeLdoPowIEWxKiA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-6jQIgEIyNRaDiOOJIuR4hg-1; Sun,
 09 Feb 2025 15:08:03 -0500
X-MC-Unique: 6jQIgEIyNRaDiOOJIuR4hg-1
X-Mimecast-MFC-AGG-ID: 6jQIgEIyNRaDiOOJIuR4hg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7D401956089;
	Sun,  9 Feb 2025 20:08:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.92])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BD1811800570;
	Sun,  9 Feb 2025 20:07:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Chuck Lever <chuck.lever@oracle.com>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH net v2] rxrpc: Fix alteration of headers whilst zerocopy pending
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2181711.1739131675.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Feb 2025 20:07:55 +0000
Message-ID: <2181712.1739131675@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

rxrpc: Fix alteration of headers whilst zerocopy pending

AF_RXRPC now uses MSG_SPLICE_PAGES to do zerocopy of the DATA packets when
it transmits them, but to reduce the number of descriptors required in the
DMA ring, it allocates a space for the protocol header in the memory
immediately before the data content so that it can include both in a singl=
e
descriptor.  This is used for either the main RX header or the smaller
jumbo subpacket header as appropriate:

  +----+------+
  | RX |      |
  +-+--+DATA  |
    |JH|      |
    +--+------+

Now, when it stitches a large jumbo packet together from a number of
individual DATA packets (each of which is 1412 bytes of data), it uses the
full RX header from the first and then the jumbo subpacket header for the
rest of the components:

  +---+--+------+--+------+--+------+--+------+--+------+--+------+
  |UDP|RX|DATA  |JH|DATA  |JH|DATA  |JH|DATA  |JH|DATA  |JH|DATA  |
  +---+--+------+--+------+--+------+--+------+--+------+--+------+

As mentioned, the main RX header and the jumbo header overlay one another
in memory and the formats don't match, so switching from one to the other
means rearranging the fields and adjusting the flags.

However, now that TLP has been included, it wants to retransmit the last
subpacket as a new data packet on its own, which means switching between
the header formats... and if the transmission is still pending, because of
the MSG_SPLICE_PAGES, we end up corrupting the jumbo subheader.

This has a variety of effects, with the RX service number overwriting the
jumbo checksum/key number field and the RX checksum overwriting the jumbo
flags - resulting in, at the very least, a confused connection-level abort
from the peer.

Fix this by leaving the jumbo header in the allocation with the data, but
allocating the RX header from the page frag allocator and concocting it on
the fly at the point of transmission as it does for ACK packets.

Fixes: 7c482665931b ("rxrpc: Implement RACK/TLP to deal with transmission =
stalls [RFC8985]")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>
cc: Chuck Lever <chuck.lever@oracle.com>
cc: Eric Dumazet <edumazet@google.com>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
Changes
=3D=3D=3D=3D=3D=3D=3D
ver #2)
 - Fixed the Fixes tag
 - Removed no-longer-used variable.

 net/rxrpc/ar-internal.h |    7 ++----
 net/rxrpc/output.c      |   50 +++++++++++++++++++++++++++++++++---------=
------
 net/rxrpc/rxkad.c       |   13 ++++--------
 net/rxrpc/sendmsg.c     |    4 ---
 net/rxrpc/txbuf.c       |   37 +++++++++--------------------------
 5 files changed, 54 insertions(+), 57 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index f251845fe532..5e740c486203 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -327,8 +327,8 @@ struct rxrpc_local {
 	 * packet with a maximum set of jumbo subpackets or a PING ACK padded
 	 * out to 64K with zeropages for PMTUD.
 	 */
-	struct kvec		kvec[RXRPC_MAX_NR_JUMBO > 3 + 16 ?
-				     RXRPC_MAX_NR_JUMBO : 3 + 16];
+	struct kvec		kvec[1 + RXRPC_MAX_NR_JUMBO > 3 + 16 ?
+				     1 + RXRPC_MAX_NR_JUMBO : 3 + 16];
 };
 =

 /*
@@ -874,8 +874,7 @@ struct rxrpc_txbuf {
 #define RXRPC_TXBUF_RESENT	0x100		/* Set if has been resent */
 	__be16			cksum;		/* Checksum to go in header */
 	bool			jumboable;	/* Can be non-terminal jumbo subpacket */
-	u8			nr_kvec;	/* Amount of kvec[] used */
-	struct kvec		kvec[1];
+	void			*data;		/* Data with preceding jumbo header */
 };
 =

 static inline bool rxrpc_sending_to_server(const struct rxrpc_txbuf *txb)
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 6f7a125d6e90..95905b85a8d7 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -428,13 +428,13 @@ int rxrpc_send_abort_packet(struct rxrpc_call *call)
 static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call,
 					   struct rxrpc_send_data_req *req,
 					   struct rxrpc_txbuf *txb,
+					   struct rxrpc_wire_header *whdr,
 					   rxrpc_serial_t serial, int subpkt)
 {
-	struct rxrpc_wire_header *whdr =3D txb->kvec[0].iov_base;
-	struct rxrpc_jumbo_header *jumbo =3D (void *)(whdr + 1) - sizeof(*jumbo)=
;
+	struct rxrpc_jumbo_header *jumbo =3D txb->data - sizeof(*jumbo);
 	enum rxrpc_req_ack_trace why;
 	struct rxrpc_connection *conn =3D call->conn;
-	struct kvec *kv =3D &call->local->kvec[subpkt];
+	struct kvec *kv =3D &call->local->kvec[1 + subpkt];
 	size_t len =3D txb->pkt_len;
 	bool last;
 	u8 flags;
@@ -491,18 +491,15 @@ static size_t rxrpc_prepare_data_subpacket(struct rx=
rpc_call *call,
 	}
 dont_set_request_ack:
 =

-	/* The jumbo header overlays the wire header in the txbuf. */
+	/* There's a jumbo header prepended to the data if we need it. */
 	if (subpkt < req->n - 1)
 		flags |=3D RXRPC_JUMBO_PACKET;
 	else
 		flags &=3D ~RXRPC_JUMBO_PACKET;
 	if (subpkt =3D=3D 0) {
 		whdr->flags	=3D flags;
-		whdr->serial	=3D htonl(txb->serial);
 		whdr->cksum	=3D txb->cksum;
-		whdr->serviceId	=3D htons(conn->service_id);
-		kv->iov_base	=3D whdr;
-		len +=3D sizeof(*whdr);
+		kv->iov_base	=3D txb->data;
 	} else {
 		jumbo->flags	=3D flags;
 		jumbo->pad	=3D 0;
@@ -535,7 +532,9 @@ static unsigned int rxrpc_prepare_txqueue(struct rxrpc=
_txqueue *tq,
 /*
  * Prepare a (jumbo) packet for transmission.
  */
-static size_t rxrpc_prepare_data_packet(struct rxrpc_call *call, struct r=
xrpc_send_data_req *req)
+static size_t rxrpc_prepare_data_packet(struct rxrpc_call *call,
+					struct rxrpc_send_data_req *req,
+					struct rxrpc_wire_header *whdr)
 {
 	struct rxrpc_txqueue *tq =3D req->tq;
 	rxrpc_serial_t serial;
@@ -549,6 +548,18 @@ static size_t rxrpc_prepare_data_packet(struct rxrpc_=
call *call, struct rxrpc_se
 	/* Each transmission of a Tx packet needs a new serial number */
 	serial =3D rxrpc_get_next_serials(call->conn, req->n);
 =

+	whdr->epoch		=3D htonl(call->conn->proto.epoch);
+	whdr->cid		=3D htonl(call->cid);
+	whdr->callNumber	=3D htonl(call->call_id);
+	whdr->seq		=3D htonl(seq);
+	whdr->serial		=3D htonl(serial);
+	whdr->type		=3D RXRPC_PACKET_TYPE_DATA;
+	whdr->flags		=3D 0;
+	whdr->userStatus	=3D 0;
+	whdr->securityIndex	=3D call->security_ix;
+	whdr->_rsvd		=3D 0;
+	whdr->serviceId		=3D htons(call->conn->service_id);
+
 	call->tx_last_serial =3D serial + req->n - 1;
 	call->tx_last_sent =3D req->now;
 	xmit_ts =3D rxrpc_prepare_txqueue(tq, req);
@@ -576,7 +587,7 @@ static size_t rxrpc_prepare_data_packet(struct rxrpc_c=
all *call, struct rxrpc_se
 		if (i + 1 =3D=3D req->n)
 			/* Only sample the last subpacket in a jumbo. */
 			__set_bit(ix, &tq->rtt_samples);
-		len +=3D rxrpc_prepare_data_subpacket(call, req, txb, serial, i);
+		len +=3D rxrpc_prepare_data_subpacket(call, req, txb, whdr, serial, i);
 		serial++;
 		seq++;
 		i++;
@@ -618,6 +629,7 @@ static size_t rxrpc_prepare_data_packet(struct rxrpc_c=
all *call, struct rxrpc_se
 	}
 =

 	rxrpc_set_keepalive(call, req->now);
+	page_frag_free(whdr);
 	return len;
 }
 =

@@ -626,25 +638,33 @@ static size_t rxrpc_prepare_data_packet(struct rxrpc=
_call *call, struct rxrpc_se
  */
 void rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_send_da=
ta_req *req)
 {
+	struct rxrpc_wire_header *whdr;
 	struct rxrpc_connection *conn =3D call->conn;
 	enum rxrpc_tx_point frag;
 	struct rxrpc_txqueue *tq =3D req->tq;
 	struct rxrpc_txbuf *txb;
 	struct msghdr msg;
 	rxrpc_seq_t seq =3D req->seq;
-	size_t len;
+	size_t len =3D sizeof(*whdr);
 	bool new_call =3D test_bit(RXRPC_CALL_BEGAN_RX_TIMER, &call->flags);
 	int ret, stat_ix;
 =

 	_enter("%x,%x-%x", tq->qbase, seq, seq + req->n - 1);
 =

+	whdr =3D page_frag_alloc(&call->local->tx_alloc, sizeof(*whdr), GFP_NOFS=
);
+	if (!whdr)
+		return; /* Drop the packet if no memory. */
+
+	call->local->kvec[0].iov_base =3D whdr;
+	call->local->kvec[0].iov_len =3D sizeof(*whdr);
+
 	stat_ix =3D umin(req->n, ARRAY_SIZE(call->rxnet->stat_tx_jumbo)) - 1;
 	atomic_inc(&call->rxnet->stat_tx_jumbo[stat_ix]);
 =

-	len =3D rxrpc_prepare_data_packet(call, req);
+	len +=3D rxrpc_prepare_data_packet(call, req, whdr);
 	txb =3D tq->bufs[seq & RXRPC_TXQ_MASK];
 =

-	iov_iter_kvec(&msg.msg_iter, WRITE, call->local->kvec, req->n, len);
+	iov_iter_kvec(&msg.msg_iter, WRITE, call->local->kvec, 1 + req->n, len);
 =

 	msg.msg_name	=3D &call->peer->srx.transport;
 	msg.msg_namelen	=3D call->peer->srx.transport_len;
@@ -695,13 +715,13 @@ void rxrpc_send_data_packet(struct rxrpc_call *call,=
 struct rxrpc_send_data_req
 =

 	if (ret =3D=3D -EMSGSIZE) {
 		rxrpc_inc_stat(call->rxnet, stat_tx_data_send_msgsize);
-		trace_rxrpc_tx_packet(call->debug_id, call->local->kvec[0].iov_base, fr=
ag);
+		trace_rxrpc_tx_packet(call->debug_id, whdr, frag);
 		ret =3D 0;
 	} else if (ret < 0) {
 		rxrpc_inc_stat(call->rxnet, stat_tx_data_send_fail);
 		trace_rxrpc_tx_fail(call->debug_id, txb->serial, ret, frag);
 	} else {
-		trace_rxrpc_tx_packet(call->debug_id, call->local->kvec[0].iov_base, fr=
ag);
+		trace_rxrpc_tx_packet(call->debug_id, whdr, frag);
 	}
 =

 	rxrpc_tx_backoff(call, ret);
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 62b09d23ec08..6cb37b0eb77f 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -257,8 +257,7 @@ static int rxkad_secure_packet_auth(const struct rxrpc=
_call *call,
 				    struct rxrpc_txbuf *txb,
 				    struct skcipher_request *req)
 {
-	struct rxrpc_wire_header *whdr =3D txb->kvec[0].iov_base;
-	struct rxkad_level1_hdr *hdr =3D (void *)(whdr + 1);
+	struct rxkad_level1_hdr *hdr =3D txb->data;
 	struct rxrpc_crypt iv;
 	struct scatterlist sg;
 	size_t pad;
@@ -274,7 +273,7 @@ static int rxkad_secure_packet_auth(const struct rxrpc=
_call *call,
 	pad =3D RXKAD_ALIGN - pad;
 	pad &=3D RXKAD_ALIGN - 1;
 	if (pad) {
-		memset(txb->kvec[0].iov_base + txb->offset, 0, pad);
+		memset(txb->data + txb->offset, 0, pad);
 		txb->pkt_len +=3D pad;
 	}
 =

@@ -300,8 +299,7 @@ static int rxkad_secure_packet_encrypt(const struct rx=
rpc_call *call,
 				       struct skcipher_request *req)
 {
 	const struct rxrpc_key_token *token;
-	struct rxrpc_wire_header *whdr =3D txb->kvec[0].iov_base;
-	struct rxkad_level2_hdr *rxkhdr =3D (void *)(whdr + 1);
+	struct rxkad_level2_hdr *rxkhdr =3D txb->data;
 	struct rxrpc_crypt iv;
 	struct scatterlist sg;
 	size_t content, pad;
@@ -319,7 +317,7 @@ static int rxkad_secure_packet_encrypt(const struct rx=
rpc_call *call,
 	txb->pkt_len =3D round_up(content, RXKAD_ALIGN);
 	pad =3D txb->pkt_len - content;
 	if (pad)
-		memset(txb->kvec[0].iov_base + txb->offset, 0, pad);
+		memset(txb->data + txb->offset, 0, pad);
 =

 	/* encrypt from the session key */
 	token =3D call->conn->key->payload.data[0];
@@ -407,9 +405,8 @@ static int rxkad_secure_packet(struct rxrpc_call *call=
, struct rxrpc_txbuf *txb)
 =

 	/* Clear excess space in the packet */
 	if (txb->pkt_len < txb->alloc_size) {
-		struct rxrpc_wire_header *whdr =3D txb->kvec[0].iov_base;
 		size_t gap =3D txb->alloc_size - txb->pkt_len;
-		void *p =3D whdr + 1;
+		void *p =3D txb->data;
 =

 		memset(p + txb->pkt_len, 0, gap);
 	}
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 584397aba4a0..84dc6c94f23b 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -419,7 +419,7 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 			size_t copy =3D umin(txb->space, msg_data_left(msg));
 =

 			_debug("add %zu", copy);
-			if (!copy_from_iter_full(txb->kvec[0].iov_base + txb->offset,
+			if (!copy_from_iter_full(txb->data + txb->offset,
 						 copy, &msg->msg_iter))
 				goto efault;
 			_debug("added");
@@ -445,8 +445,6 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 			ret =3D call->security->secure_packet(call, txb);
 			if (ret < 0)
 				goto out;
-
-			txb->kvec[0].iov_len +=3D txb->len;
 			rxrpc_queue_packet(rx, call, txb, notify_end_tx);
 			txb =3D NULL;
 		}
diff --git a/net/rxrpc/txbuf.c b/net/rxrpc/txbuf.c
index 131d9e55c8e9..c550991d48fa 100644
--- a/net/rxrpc/txbuf.c
+++ b/net/rxrpc/txbuf.c
@@ -19,17 +19,19 @@ atomic_t rxrpc_nr_txbuf;
 struct rxrpc_txbuf *rxrpc_alloc_data_txbuf(struct rxrpc_call *call, size_=
t data_size,
 					   size_t data_align, gfp_t gfp)
 {
-	struct rxrpc_wire_header *whdr;
 	struct rxrpc_txbuf *txb;
-	size_t total, hoff;
+	size_t total, doff, jsize =3D sizeof(struct rxrpc_jumbo_header);
 	void *buf;
 =

 	txb =3D kzalloc(sizeof(*txb), gfp);
 	if (!txb)
 		return NULL;
 =

-	hoff =3D round_up(sizeof(*whdr), data_align) - sizeof(*whdr);
-	total =3D hoff + sizeof(*whdr) + data_size;
+	/* We put a jumbo header in the buffer, but not a full wire header to
+	 * avoid delayed-corruption problems with zerocopy.
+	 */
+	doff =3D round_up(jsize, data_align);
+	total =3D doff + data_size;
 =

 	data_align =3D umax(data_align, L1_CACHE_BYTES);
 	mutex_lock(&call->conn->tx_data_alloc_lock);
@@ -41,30 +43,15 @@ struct rxrpc_txbuf *rxrpc_alloc_data_txbuf(struct rxrp=
c_call *call, size_t data_
 		return NULL;
 	}
 =

-	whdr =3D buf + hoff;
-
 	refcount_set(&txb->ref, 1);
 	txb->call_debug_id	=3D call->debug_id;
 	txb->debug_id		=3D atomic_inc_return(&rxrpc_txbuf_debug_ids);
 	txb->alloc_size		=3D data_size;
 	txb->space		=3D data_size;
-	txb->offset		=3D sizeof(*whdr);
+	txb->offset		=3D 0;
 	txb->flags		=3D call->conn->out_clientflag;
 	txb->seq		=3D call->send_top + 1;
-	txb->nr_kvec		=3D 1;
-	txb->kvec[0].iov_base	=3D whdr;
-	txb->kvec[0].iov_len	=3D sizeof(*whdr);
-
-	whdr->epoch		=3D htonl(call->conn->proto.epoch);
-	whdr->cid		=3D htonl(call->cid);
-	whdr->callNumber	=3D htonl(call->call_id);
-	whdr->seq		=3D htonl(txb->seq);
-	whdr->type		=3D RXRPC_PACKET_TYPE_DATA;
-	whdr->flags		=3D 0;
-	whdr->userStatus	=3D 0;
-	whdr->securityIndex	=3D call->security_ix;
-	whdr->_rsvd		=3D 0;
-	whdr->serviceId		=3D htons(call->dest_srx.srx_service);
+	txb->data		=3D buf + doff;
 =

 	trace_rxrpc_txbuf(txb->debug_id, txb->call_debug_id, txb->seq, 1,
 			  rxrpc_txbuf_alloc_data);
@@ -90,14 +77,10 @@ void rxrpc_see_txbuf(struct rxrpc_txbuf *txb, enum rxr=
pc_txbuf_trace what)
 =

 static void rxrpc_free_txbuf(struct rxrpc_txbuf *txb)
 {
-	int i;
-
 	trace_rxrpc_txbuf(txb->debug_id, txb->call_debug_id, txb->seq, 0,
 			  rxrpc_txbuf_free);
-	for (i =3D 0; i < txb->nr_kvec; i++)
-		if (txb->kvec[i].iov_base &&
-		    !is_zero_pfn(page_to_pfn(virt_to_page(txb->kvec[i].iov_base))))
-			page_frag_free(txb->kvec[i].iov_base);
+	if (txb->data)
+		page_frag_free(txb->data);
 	kfree(txb);
 	atomic_dec(&rxrpc_nr_txbuf);
 }


