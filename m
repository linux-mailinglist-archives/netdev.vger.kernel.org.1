Return-Path: <netdev+bounces-162054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6F1A257C0
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 12:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93F42166CCD
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 11:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A53E202F8E;
	Mon,  3 Feb 2025 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kvvbfg69"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB6520125F
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 11:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738580628; cv=none; b=GgDJ3+lQcMlnwteQBoJryvjzkY5K4w5bx3VW61Chmezh2PTWEoyGjAoHQeRtHK0+Lm5RG+WYdmALy1Ytq7MzYkM+yDYUU5f3ujOibuEu4QO3Qi5ZXg7ubMTGHjguu+kOILMSpdGBeGCl8/KeUBKT5s9mNIvvLmeMpHtMLJH9u0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738580628; c=relaxed/simple;
	bh=3pxWZFne/qbgvUqEBMm2XO/O0uoTztX+XknAwDRObrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9oGHXqf73HOt8mHmprNoMtChiW22hwB0R9dxJ6jh01VL8i9Do/fX9q7iu3dK8kyjj/JweHOBhCn6sBwmmXX6nkZaWQN1+UyD2uTIceXaaH41+/TYSZJZeAVtQ1PZJWtKbb7cMUvXtljhBnogoeK2abHoGZljpqkuIKgFwp+B3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kvvbfg69; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738580625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vQgoewskazO2en03STRprTa1lLjeCB4xHN38VWeAptw=;
	b=Kvvbfg69Mz9zrV1ID6csijBAHAFFQs3SPuMtmHDriX3BgPQVlth6y1RuIEOKu1wWR1FXgV
	QFO3tYgdDiEQ9bOpUGAS0g10y+tQjRT7BXUeHKT2nMu2DmIe4MU1O7UiWsOgo9tJAlPyZK
	iMcUTQXImCvi/p+tG3uGhHc0M0CAsoc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-j_PZvd1aOnWQOgHMTAytXA-1; Mon,
 03 Feb 2025 06:03:44 -0500
X-MC-Unique: j_PZvd1aOnWQOgHMTAytXA-1
X-Mimecast-MFC-AGG-ID: j_PZvd1aOnWQOgHMTAytXA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0ED91850DF7;
	Mon,  3 Feb 2025 11:03:29 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.92])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BED1A1800980;
	Mon,  3 Feb 2025 11:03:16 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 1/2] rxrpc: Fix call state set to not include the SERVER_SECURING state
Date: Mon,  3 Feb 2025 11:03:03 +0000
Message-ID: <20250203110307.7265-2-dhowells@redhat.com>
In-Reply-To: <20250203110307.7265-1-dhowells@redhat.com>
References: <20250203110307.7265-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The RXRPC_CALL_SERVER_SECURING state doesn't really belong with the other
states in the call's state set as the other states govern the call's Rx/Tx
phase transition and govern when packets can and can't be received or
transmitted.  The "Securing" state doesn't actually govern the reception of
packets and would need to be split depending on whether or not we've
received the last packet yet (to mirror RECV_REQUEST/ACK_REQUEST).

The "Securing" state is more about whether or not we can start forwarding
packets to the application as recvmsg will need to decode them and the
decoding can't take place until the challenge/response exchange has
completed.

Fix this by removing the RXRPC_CALL_SERVER_SECURING state from the state
set and, instead, using a flag, RXRPC_CALL_CONN_CHALLENGING, to track
whether or not we can queue the call for reception by recvmsg() or notify
the kernel app that data is ready.  In the event that we've already
received all the packets, the connection event handler will poke the app
layer in the appropriate manner.

Also there's a race whereby the app layer sees the last packet before rxrpc
has managed to end the rx phase and change the state to one amenable to
allowing a reply.  Fix this by queuing the packet after calling
rxrpc_end_rx_phase().

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/ar-internal.h | 2 +-
 net/rxrpc/call_object.c | 6 ++----
 net/rxrpc/conn_event.c  | 4 +---
 net/rxrpc/input.c       | 4 ++--
 net/rxrpc/sendmsg.c     | 2 +-
 5 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 718193df9d2e..f251845fe532 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -582,6 +582,7 @@ enum rxrpc_call_flag {
 	RXRPC_CALL_EXCLUSIVE,		/* The call uses a once-only connection */
 	RXRPC_CALL_RX_IS_IDLE,		/* recvmsg() is idle - send an ACK */
 	RXRPC_CALL_RECVMSG_READ_ALL,	/* recvmsg() read all of the received data */
+	RXRPC_CALL_CONN_CHALLENGING,	/* The connection is being challenged */
 };
 
 /*
@@ -602,7 +603,6 @@ enum rxrpc_call_state {
 	RXRPC_CALL_CLIENT_AWAIT_REPLY,	/* - client awaiting reply */
 	RXRPC_CALL_CLIENT_RECV_REPLY,	/* - client receiving reply phase */
 	RXRPC_CALL_SERVER_PREALLOC,	/* - service preallocation */
-	RXRPC_CALL_SERVER_SECURING,	/* - server securing request connection */
 	RXRPC_CALL_SERVER_RECV_REQUEST,	/* - server receiving request */
 	RXRPC_CALL_SERVER_ACK_REQUEST,	/* - server pending ACK of request */
 	RXRPC_CALL_SERVER_SEND_REPLY,	/* - server sending reply */
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 5a543c3f6fb0..c4c8b46a68c6 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -22,7 +22,6 @@ const char *const rxrpc_call_states[NR__RXRPC_CALL_STATES] = {
 	[RXRPC_CALL_CLIENT_AWAIT_REPLY]		= "ClAwtRpl",
 	[RXRPC_CALL_CLIENT_RECV_REPLY]		= "ClRcvRpl",
 	[RXRPC_CALL_SERVER_PREALLOC]		= "SvPrealc",
-	[RXRPC_CALL_SERVER_SECURING]		= "SvSecure",
 	[RXRPC_CALL_SERVER_RECV_REQUEST]	= "SvRcvReq",
 	[RXRPC_CALL_SERVER_ACK_REQUEST]		= "SvAckReq",
 	[RXRPC_CALL_SERVER_SEND_REPLY]		= "SvSndRpl",
@@ -453,17 +452,16 @@ void rxrpc_incoming_call(struct rxrpc_sock *rx,
 	call->cong_tstamp	= skb->tstamp;
 
 	__set_bit(RXRPC_CALL_EXPOSED, &call->flags);
-	rxrpc_set_call_state(call, RXRPC_CALL_SERVER_SECURING);
+	rxrpc_set_call_state(call, RXRPC_CALL_SERVER_RECV_REQUEST);
 
 	spin_lock(&conn->state_lock);
 
 	switch (conn->state) {
 	case RXRPC_CONN_SERVICE_UNSECURED:
 	case RXRPC_CONN_SERVICE_CHALLENGING:
-		rxrpc_set_call_state(call, RXRPC_CALL_SERVER_SECURING);
+		__set_bit(RXRPC_CALL_CONN_CHALLENGING, &call->flags);
 		break;
 	case RXRPC_CONN_SERVICE:
-		rxrpc_set_call_state(call, RXRPC_CALL_SERVER_RECV_REQUEST);
 		break;
 
 	case RXRPC_CONN_ABORTED:
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 713e04394ceb..d93b041c4894 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -228,10 +228,8 @@ static void rxrpc_abort_calls(struct rxrpc_connection *conn)
  */
 static void rxrpc_call_is_secure(struct rxrpc_call *call)
 {
-	if (call && __rxrpc_call_state(call) == RXRPC_CALL_SERVER_SECURING) {
-		rxrpc_set_call_state(call, RXRPC_CALL_SERVER_RECV_REQUEST);
+	if (call && __test_and_clear_bit(RXRPC_CALL_CONN_CHALLENGING, &call->flags))
 		rxrpc_notify_socket(call);
-	}
 }
 
 /*
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 4974b5accafa..2d3004031832 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -448,11 +448,11 @@ static void rxrpc_input_queue_data(struct rxrpc_call *call, struct sk_buff *skb,
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	bool last = sp->hdr.flags & RXRPC_LAST_PACKET;
 
-	skb_queue_tail(&call->recvmsg_queue, skb);
 	rxrpc_input_update_ack_window(call, window, wtop);
 	trace_rxrpc_receive(call, last ? why + 1 : why, sp->hdr.serial, sp->hdr.seq);
 	if (last)
 		rxrpc_end_rx_phase(call, sp->hdr.serial);
+	skb_queue_tail(&call->recvmsg_queue, skb);
 }
 
 /*
@@ -657,7 +657,7 @@ static bool rxrpc_input_split_jumbo(struct rxrpc_call *call, struct sk_buff *skb
 		rxrpc_propose_delay_ACK(call, sp->hdr.serial,
 					rxrpc_propose_ack_input_data);
 	}
-	if (notify) {
+	if (notify && !test_bit(RXRPC_CALL_CONN_CHALLENGING, &call->flags)) {
 		trace_rxrpc_notify_socket(call->debug_id, sp->hdr.serial);
 		rxrpc_notify_socket(call);
 	}
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 0e8da909d4f2..584397aba4a0 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -707,7 +707,7 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
 	} else {
 		switch (rxrpc_call_state(call)) {
 		case RXRPC_CALL_CLIENT_AWAIT_CONN:
-		case RXRPC_CALL_SERVER_SECURING:
+		case RXRPC_CALL_SERVER_RECV_REQUEST:
 			if (p.command == RXRPC_CMD_SEND_ABORT)
 				break;
 			fallthrough;


