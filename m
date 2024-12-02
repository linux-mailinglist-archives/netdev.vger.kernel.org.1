Return-Path: <netdev+bounces-148069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5519E0524
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4ECF162284
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07749205AB6;
	Mon,  2 Dec 2024 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TsvQXZkq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B149204F6B
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149877; cv=none; b=E61kkBwPHeIIbGKsHC6lXSdCEPJU12JR2n32FSjF1dQLcZShxdl839WNz99EbcSdgP+Jtk+TGU9tJSo85H2nDI3XKWp25UoEIiuc3oFpmYVRO0ncet24xHoqgNVLlp2sYc3q8u1o2+t49Xt0m5oSplmcrj9WhpOvEBuyxzL0/5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149877; c=relaxed/simple;
	bh=LiembOcurmOw4+40ybsntquCMb6mhOp2FYXN7pIggRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoEIbor3PmSjU+Fa4XiN9aR5VBhNxIoh6vJ+8lomKbwdmxM96QrYG7PxfLHUwU5S9WyPnCqWs4V15mNALC8nEIYHmMLkgUdz/Uyu1Nq7R+m5mURM9RFPWT2VqUxtaEiyflVMwgm47g3A7mPFhI758DlrFlfZvrixMf1bZkp/vM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TsvQXZkq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733149874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SgDcxHvMPuaNGZPmBKKvBNkHii79DsY2D29vW13rUKI=;
	b=TsvQXZkqK11mHD7Xwro2MRIiecKAsz2NepbooL4AxXCC8G4h+z5/4tmJ6qJmQ44v4yRN8U
	7SdTWqYWEpjgK4gBJ66I3tdBy+ZvWWTFB4gs0+zAXXo5j2+8S23JnHPwkcudTql5R3c6KG
	pOTCHL8AoymzXhXI3kGb9A47bGcOUkE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-5STL2LY6OqKKOrBVvSbyDQ-1; Mon,
 02 Dec 2024 09:31:11 -0500
X-MC-Unique: 5STL2LY6OqKKOrBVvSbyDQ-1
X-Mimecast-MFC-AGG-ID: 5STL2LY6OqKKOrBVvSbyDQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D88E1945117;
	Mon,  2 Dec 2024 14:31:08 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 168CF1955D47;
	Mon,  2 Dec 2024 14:31:04 +0000 (UTC)
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
Subject: [PATCH net-next 01/37] rxrpc: Fix handling of received connection abort
Date: Mon,  2 Dec 2024 14:30:19 +0000
Message-ID: <20241202143057.378147-2-dhowells@redhat.com>
In-Reply-To: <20241202143057.378147-1-dhowells@redhat.com>
References: <20241202143057.378147-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Fix the handling of a connection abort that we've received.  Though the
abort is at the connection level, it needs propagating to the calls on that
connection.  Whilst the propagation bit is performed, the calls aren't then
woken up to go and process their termination, and as no further input is
forthcoming, they just hang.

Also add some tracing for the logging of connection aborts.

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
 include/trace/events/rxrpc.h | 25 +++++++++++++++++++++++++
 net/rxrpc/conn_event.c       | 12 ++++++++----
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index d03e0bd8c028..27c23873c881 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -117,6 +117,7 @@
 #define rxrpc_call_poke_traces \
 	EM(rxrpc_call_poke_abort,		"Abort")	\
 	EM(rxrpc_call_poke_complete,		"Compl")	\
+	EM(rxrpc_call_poke_conn_abort,		"Conn-abort")	\
 	EM(rxrpc_call_poke_error,		"Error")	\
 	EM(rxrpc_call_poke_idle,		"Idle")		\
 	EM(rxrpc_call_poke_set_timeout,		"Set-timo")	\
@@ -282,6 +283,7 @@
 	EM(rxrpc_call_see_activate_client,	"SEE act-clnt") \
 	EM(rxrpc_call_see_connect_failed,	"SEE con-fail") \
 	EM(rxrpc_call_see_connected,		"SEE connect ") \
+	EM(rxrpc_call_see_conn_abort,		"SEE conn-abt") \
 	EM(rxrpc_call_see_disconnected,		"SEE disconn ") \
 	EM(rxrpc_call_see_distribute_error,	"SEE dist-err") \
 	EM(rxrpc_call_see_input,		"SEE input   ") \
@@ -981,6 +983,29 @@ TRACE_EVENT(rxrpc_rx_abort,
 		      __entry->abort_code)
 	    );
 
+TRACE_EVENT(rxrpc_rx_conn_abort,
+	    TP_PROTO(const struct rxrpc_connection *conn, const struct sk_buff *skb),
+
+	    TP_ARGS(conn, skb),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	conn)
+		    __field(rxrpc_serial_t,	serial)
+		    __field(u32,		abort_code)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->conn = conn->debug_id;
+		    __entry->serial = rxrpc_skb(skb)->hdr.serial;
+		    __entry->abort_code = skb->priority;
+			   ),
+
+	    TP_printk("C=%08x ABORT %08x ac=%d",
+		      __entry->conn,
+		      __entry->serial,
+		      __entry->abort_code)
+	    );
+
 TRACE_EVENT(rxrpc_rx_challenge,
 	    TP_PROTO(struct rxrpc_connection *conn, rxrpc_serial_t serial,
 		     u32 version, u32 nonce, u32 min_level),
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 598b4ee389fc..2a1396cd892f 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -63,11 +63,12 @@ int rxrpc_abort_conn(struct rxrpc_connection *conn, struct sk_buff *skb,
 /*
  * Mark a connection as being remotely aborted.
  */
-static bool rxrpc_input_conn_abort(struct rxrpc_connection *conn,
+static void rxrpc_input_conn_abort(struct rxrpc_connection *conn,
 				   struct sk_buff *skb)
 {
-	return rxrpc_set_conn_aborted(conn, skb, skb->priority, -ECONNABORTED,
-				      RXRPC_CALL_REMOTELY_ABORTED);
+	trace_rxrpc_rx_conn_abort(conn, skb);
+	rxrpc_set_conn_aborted(conn, skb, skb->priority, -ECONNABORTED,
+			       RXRPC_CALL_REMOTELY_ABORTED);
 }
 
 /*
@@ -202,11 +203,14 @@ static void rxrpc_abort_calls(struct rxrpc_connection *conn)
 
 	for (i = 0; i < RXRPC_MAXCALLS; i++) {
 		call = conn->channels[i].call;
-		if (call)
+		if (call) {
+			rxrpc_see_call(call, rxrpc_call_see_conn_abort);
 			rxrpc_set_call_completion(call,
 						  conn->completion,
 						  conn->abort_code,
 						  conn->error);
+			rxrpc_poke_call(call, rxrpc_call_poke_conn_abort);
+		}
 	}
 
 	_leave("");


