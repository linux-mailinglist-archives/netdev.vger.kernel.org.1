Return-Path: <netdev+bounces-48329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D29837EE123
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878EC1F24711
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 13:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E917930660;
	Thu, 16 Nov 2023 13:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TggRkA7F"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97701D4A
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 05:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700140390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amx7SkdxhyQZBIZGSORR2hEtLgqQ9WgEbAgze3egzOA=;
	b=TggRkA7F6nM/d85eWyRKMvauixFZVb/KjJ08T29Nyv0HmRYRFnspqgAnWXEjM/iRjZEo/I
	pAGgWaZNJv1aZNo8QZ/KIeenK6Kj/r92iZskQFeR1anhJR0Ex9rxQ6CYQqoIdfHlaThEBf
	u6vJb5RlK0IhG9AagSJozEVUVK3BaQs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-ujvchDHtOmae_nRX8S1YUw-1; Thu, 16 Nov 2023 08:13:05 -0500
X-MC-Unique: ujvchDHtOmae_nRX8S1YUw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6704D811E7D;
	Thu, 16 Nov 2023 13:13:05 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2C5431121306;
	Thu, 16 Nov 2023 13:13:04 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] rxrpc: Fix RTT determination to use any ACK as a source
Date: Thu, 16 Nov 2023 13:12:58 +0000
Message-ID: <20231116131259.103513-2-dhowells@redhat.com>
In-Reply-To: <20231116131259.103513-1-dhowells@redhat.com>
References: <20231116131259.103513-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Fix RTT determination to be able to use any type of ACK as the response
from which RTT can be calculated provided its ack.serial is non-zero and
matches the serial number of an outgoing DATA or ACK packet.  This
shouldn't be limited to REQUESTED-type ACKs as these can have other types
substituted for them for things like duplicate or out-of-order packets.

Fixes: 4700c4d80b7b ("rxrpc: Fix loss of RTT samples due to interposed ACK")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h |  2 +-
 net/rxrpc/input.c            | 35 ++++++++++++++++-------------------
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 4c53a5ef6257..f7e537f64db4 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -328,7 +328,7 @@
 	E_(rxrpc_rtt_tx_ping,			"PING")
 
 #define rxrpc_rtt_rx_traces \
-	EM(rxrpc_rtt_rx_cancel,			"CNCL") \
+	EM(rxrpc_rtt_rx_other_ack,		"OACK") \
 	EM(rxrpc_rtt_rx_obsolete,		"OBSL") \
 	EM(rxrpc_rtt_rx_lost,			"LOST") \
 	EM(rxrpc_rtt_rx_ping_response,		"PONG") \
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 030d64f282f3..3f9594d12519 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -643,12 +643,8 @@ static void rxrpc_complete_rtt_probe(struct rxrpc_call *call,
 			clear_bit(i + RXRPC_CALL_RTT_PEND_SHIFT, &call->rtt_avail);
 			smp_mb(); /* Read data before setting avail bit */
 			set_bit(i, &call->rtt_avail);
-			if (type != rxrpc_rtt_rx_cancel)
-				rxrpc_peer_add_rtt(call, type, i, acked_serial, ack_serial,
-						   sent_at, resp_time);
-			else
-				trace_rxrpc_rtt_rx(call, rxrpc_rtt_rx_cancel, i,
-						   orig_serial, acked_serial, 0, 0);
+			rxrpc_peer_add_rtt(call, type, i, acked_serial, ack_serial,
+					   sent_at, resp_time);
 			matched = true;
 		}
 
@@ -801,20 +797,21 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 			   summary.ack_reason, nr_acks);
 	rxrpc_inc_stat(call->rxnet, stat_rx_acks[ack.reason]);
 
-	switch (ack.reason) {
-	case RXRPC_ACK_PING_RESPONSE:
-		rxrpc_complete_rtt_probe(call, skb->tstamp, acked_serial, ack_serial,
-					 rxrpc_rtt_rx_ping_response);
-		break;
-	case RXRPC_ACK_REQUESTED:
-		rxrpc_complete_rtt_probe(call, skb->tstamp, acked_serial, ack_serial,
-					 rxrpc_rtt_rx_requested_ack);
-		break;
-	default:
-		if (acked_serial != 0)
+	if (acked_serial != 0) {
+		switch (ack.reason) {
+		case RXRPC_ACK_PING_RESPONSE:
 			rxrpc_complete_rtt_probe(call, skb->tstamp, acked_serial, ack_serial,
-						 rxrpc_rtt_rx_cancel);
-		break;
+						 rxrpc_rtt_rx_ping_response);
+			break;
+		case RXRPC_ACK_REQUESTED:
+			rxrpc_complete_rtt_probe(call, skb->tstamp, acked_serial, ack_serial,
+						 rxrpc_rtt_rx_requested_ack);
+			break;
+		default:
+			rxrpc_complete_rtt_probe(call, skb->tstamp, acked_serial, ack_serial,
+						 rxrpc_rtt_rx_other_ack);
+			break;
+		}
 	}
 
 	if (ack.reason == RXRPC_ACK_PING) {


