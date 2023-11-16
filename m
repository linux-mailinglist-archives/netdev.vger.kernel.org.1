Return-Path: <netdev+bounces-48330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC6A7EE124
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A00B280354
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 13:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE1D30671;
	Thu, 16 Nov 2023 13:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2Gxs2ra"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20521D4B
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 05:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700140391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pni06L1Erygx16Uv1x1PI2n1eAvBA/ceTvUPGaZmGjw=;
	b=H2Gxs2rat7tFZd3BCrEnO8axVaorRTZRs8rNbmLFTPtpeGJBBNpY/2qbSwMIGHD2akct8A
	LaHwMT6I7O53a3kpvydJJpw1cEpX9QQKzv5odP1bj36G2eyfnf+R74NI2Cot/zED+v5gKw
	hNtAabEdNqsBICKkwotYo9ls/3nSS7Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-5lcP13W_Nei-aSb7UBKm-Q-1; Thu,
 16 Nov 2023 08:13:07 -0500
X-MC-Unique: 5lcP13W_Nei-aSb7UBKm-Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 541263C14903;
	Thu, 16 Nov 2023 13:13:07 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1B5EF2026D66;
	Thu, 16 Nov 2023 13:13:06 +0000 (UTC)
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
Subject: [PATCH net 2/2] rxrpc: Defer the response to a PING ACK until we've parsed it
Date: Thu, 16 Nov 2023 13:12:59 +0000
Message-ID: <20231116131259.103513-3-dhowells@redhat.com>
In-Reply-To: <20231116131259.103513-1-dhowells@redhat.com>
References: <20231116131259.103513-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Defer the generation of a PING RESPONSE ACK in response to a PING ACK until
we've parsed the PING ACK so that we pick up any changes to the packet
queue so that we can update ackinfo.

This is also applied to an ACK generated in response to an ACK with the
REQUEST_ACK flag set.

Note that whilst the problem was added in commit 248f219cb8bc, it didn't
really matter at that point because the ACK was proposed in softirq mode
and generated asynchronously later in process context, taking the latest
values at the time.  But this fix is only needed since the move to parse
incoming packets in an I/O thread rather than in softirq and generate the
ACK at point of proposal (b0346843b1076b34a0278ff601f8f287535cb064).

Fixes: 248f219cb8bc ("rxrpc: Rewrite the data and ack handling code")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/input.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 3f9594d12519..92495e73b869 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -814,14 +814,6 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 		}
 	}
 
-	if (ack.reason == RXRPC_ACK_PING) {
-		rxrpc_send_ACK(call, RXRPC_ACK_PING_RESPONSE, ack_serial,
-			       rxrpc_propose_ack_respond_to_ping);
-	} else if (sp->hdr.flags & RXRPC_REQUEST_ACK) {
-		rxrpc_send_ACK(call, RXRPC_ACK_REQUESTED, ack_serial,
-			       rxrpc_propose_ack_respond_to_ack);
-	}
-
 	/* If we get an EXCEEDS_WINDOW ACK from the server, it probably
 	 * indicates that the client address changed due to NAT.  The server
 	 * lost the call because it switched to a different peer.
@@ -832,7 +824,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	    rxrpc_is_client_call(call)) {
 		rxrpc_set_call_completion(call, RXRPC_CALL_REMOTELY_ABORTED,
 					  0, -ENETRESET);
-		return;
+		goto send_response;
 	}
 
 	/* If we get an OUT_OF_SEQUENCE ACK from the server, that can also
@@ -846,7 +838,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	    rxrpc_is_client_call(call)) {
 		rxrpc_set_call_completion(call, RXRPC_CALL_REMOTELY_ABORTED,
 					  0, -ENETRESET);
-		return;
+		goto send_response;
 	}
 
 	/* Discard any out-of-order or duplicate ACKs (outside lock). */
@@ -854,7 +846,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 		trace_rxrpc_rx_discard_ack(call->debug_id, ack_serial,
 					   first_soft_ack, call->acks_first_seq,
 					   prev_pkt, call->acks_prev_seq);
-		return;
+		goto send_response;
 	}
 
 	info.rxMTU = 0;
@@ -894,7 +886,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	case RXRPC_CALL_SERVER_AWAIT_ACK:
 		break;
 	default:
-		return;
+		goto send_response;
 	}
 
 	if (before(hard_ack, call->acks_hard_ack) ||
@@ -906,7 +898,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	if (after(hard_ack, call->acks_hard_ack)) {
 		if (rxrpc_rotate_tx_window(call, hard_ack, &summary)) {
 			rxrpc_end_tx_phase(call, false, rxrpc_eproto_unexpected_ack);
-			return;
+			goto send_response;
 		}
 	}
 
@@ -924,6 +916,14 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 				   rxrpc_propose_ack_ping_for_lost_reply);
 
 	rxrpc_congestion_management(call, skb, &summary, acked_serial);
+
+send_response:
+	if (ack.reason == RXRPC_ACK_PING)
+		rxrpc_send_ACK(call, RXRPC_ACK_PING_RESPONSE, ack_serial,
+			       rxrpc_propose_ack_respond_to_ping);
+	else if (sp->hdr.flags & RXRPC_REQUEST_ACK)
+		rxrpc_send_ACK(call, RXRPC_ACK_REQUESTED, ack_serial,
+			       rxrpc_propose_ack_respond_to_ack);
 }
 
 /*


