Return-Path: <netdev+bounces-148071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C78CF9E0756
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 16:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33D38B38BB2
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FD6207A0D;
	Mon,  2 Dec 2024 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e58GcrO6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F89205E37
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149886; cv=none; b=NagutaeLwP4YkuolQgs5wcUXIdfTF3az9K48cMkFJ+dj0oCEql7VeIQBvWbeApXJZ5uEFEQwxBzhynbX2z7hrnu/RFchzOTyh9MnuK18AapQvcDX0FoIMG9677cHWhAuR17ZLDQy4yR20AkNGMTO82Z7i4l6Vj3YHYzctz6yEIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149886; c=relaxed/simple;
	bh=bg28pajEEjGjeO4pOGZmHHUzSUhOzQVpV2W5Uqp0eCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1dR6ONnfcFQFcY64wTipuRbe271up3feOPMoiiUxICpHMc2wGXGIzasUMTQ1DVOTYU6Ouz5NzK63zw68ZoeiYjZW5ZYJMkyzB/FgCFVdfsyHzmwg1TxGPh/XzDi79GRvhAae/rbxTMgUQ0hn43GcIx1NQoaHpQzjvp553tpoFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e58GcrO6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733149883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nQxHiYMs7bpD+fxOYblKM9SE945ZS3Tm4oRrQv3yLdM=;
	b=e58GcrO68XTx0soDAuKYygPY/my+Caxb6NKFkLmjKa5UPSOGxsUpnFvqvbHOOua+b6bop3
	b504rUOEbmPLNnrwwisuvKNxAfX+sXroZs1Cajrva5BXv8BR3nHyXRLVar7LcnPDfU/u4P
	Lr17Qvh5vF+C3Vktgel8Bgbm/TVOdm8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-6IsI-hoxNfCBI5bEAUkzWw-1; Mon,
 02 Dec 2024 09:31:19 -0500
X-MC-Unique: 6IsI-hoxNfCBI5bEAUkzWw-1
X-Mimecast-MFC-AGG-ID: 6IsI-hoxNfCBI5bEAUkzWw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 681921953954;
	Mon,  2 Dec 2024 14:31:16 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA5CA30000DF;
	Mon,  2 Dec 2024 14:31:13 +0000 (UTC)
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
Subject: [PATCH net-next 03/37] rxrpc: Clean up Tx header flags generation handling
Date: Mon,  2 Dec 2024 14:30:21 +0000
Message-ID: <20241202143057.378147-4-dhowells@redhat.com>
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

Clean up the generation of the header flags when building packet headers
for transmission:

 (1) Assemble the flags in a local variable rather than in the txb->flags.

 (2) Do the flags masking and JUMBO-PACKET setting in one bit of code for
     both the main header and the jumbo headers.

 (3) Generate the REQUEST-ACK flag afresh each time.  There's a possibility
     we might want to do jumbo retransmission packets in future.

 (4) Pass the local flags variable to the rxrpc_tx_data tracepoint rather
     than the combination of the txb flags and the wire header flags (the
     latter belong only to the first subpacket).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h |  1 -
 net/rxrpc/ar-internal.h      |  2 +-
 net/rxrpc/output.c           | 18 ++++++++++++------
 net/rxrpc/proc.c             |  3 +--
 4 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 27c23873c881..62064f63d6eb 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -452,7 +452,6 @@
 
 #define rxrpc_req_ack_traces \
 	EM(rxrpc_reqack_ack_lost,		"ACK-LOST  ")	\
-	EM(rxrpc_reqack_already_on,		"ALREADY-ON")	\
 	EM(rxrpc_reqack_more_rtt,		"MORE-RTT  ")	\
 	EM(rxrpc_reqack_no_srv_last,		"NO-SRVLAST")	\
 	EM(rxrpc_reqack_old_rtt,		"OLD-RTT   ")	\
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index d0fd37bdcfe9..fcdfbc1d5aaf 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -110,7 +110,7 @@ struct rxrpc_net {
 	atomic_t		stat_tx_acks[256];
 	atomic_t		stat_rx_acks[256];
 
-	atomic_t		stat_why_req_ack[8];
+	atomic_t		stat_why_req_ack[7];
 
 	atomic_t		stat_io_loop;
 };
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 85112ea31a39..50d5f2a02458 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -330,6 +330,8 @@ static void rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc_t
 	struct rxrpc_wire_header *whdr = txb->kvec[0].iov_base;
 	enum rxrpc_req_ack_trace why;
 	struct rxrpc_connection *conn = call->conn;
+	bool last;
+	u8 flags;
 
 	_enter("%x,{%d}", txb->seq, txb->len);
 
@@ -339,6 +341,10 @@ static void rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc_t
 	    txb->seq == 1)
 		whdr->userStatus = RXRPC_USERSTATUS_SERVICE_UPGRADE;
 
+	txb->flags &= ~RXRPC_REQUEST_ACK;
+	flags = txb->flags & RXRPC_TXBUF_WIRE_FLAGS;
+	last = txb->flags & RXRPC_LAST_PACKET;
+
 	/* If our RTT cache needs working on, request an ACK.  Also request
 	 * ACKs if a DATA packet appears to have been lost.
 	 *
@@ -346,9 +352,7 @@ static void rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc_t
 	 * service call, lest OpenAFS incorrectly send us an ACK with some
 	 * soft-ACKs in it and then never follow up with a proper hard ACK.
 	 */
-	if (txb->flags & RXRPC_REQUEST_ACK)
-		why = rxrpc_reqack_already_on;
-	else if ((txb->flags & RXRPC_LAST_PACKET) && rxrpc_sending_to_client(txb))
+	if (last && rxrpc_sending_to_client(txb))
 		why = rxrpc_reqack_no_srv_last;
 	else if (test_and_clear_bit(RXRPC_CALL_EV_ACK_LOST, &call->events))
 		why = rxrpc_reqack_ack_lost;
@@ -367,15 +371,17 @@ static void rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc_t
 
 	rxrpc_inc_stat(call->rxnet, stat_why_req_ack[why]);
 	trace_rxrpc_req_ack(call->debug_id, txb->seq, why);
-	if (why != rxrpc_reqack_no_srv_last)
+	if (why != rxrpc_reqack_no_srv_last) {
 		txb->flags |= RXRPC_REQUEST_ACK;
+		flags |= RXRPC_REQUEST_ACK;
+	}
 dont_set_request_ack:
 
-	whdr->flags = txb->flags & RXRPC_TXBUF_WIRE_FLAGS;
+	whdr->flags	= flags;
 	whdr->serial	= htonl(txb->serial);
 	whdr->cksum	= txb->cksum;
 
-	trace_rxrpc_tx_data(call, txb->seq, txb->serial, txb->flags, false);
+	trace_rxrpc_tx_data(call, txb->seq, txb->serial, flags, false);
 }
 
 /*
diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index 263a2251e3d2..3b7e34dd4385 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -519,9 +519,8 @@ int rxrpc_stats_show(struct seq_file *seq, void *v)
 		   atomic_read(&rxnet->stat_rx_acks[RXRPC_ACK_DELAY]),
 		   atomic_read(&rxnet->stat_rx_acks[RXRPC_ACK_IDLE]));
 	seq_printf(seq,
-		   "Why-Req-A: acklost=%u already=%u mrtt=%u ortt=%u\n",
+		   "Why-Req-A: acklost=%u mrtt=%u ortt=%u\n",
 		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_ack_lost]),
-		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_already_on]),
 		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_more_rtt]),
 		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_old_rtt]));
 	seq_printf(seq,


