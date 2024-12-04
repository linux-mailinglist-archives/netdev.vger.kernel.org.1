Return-Path: <netdev+bounces-148846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8906B9E3464
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E61168617
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 07:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC2218FDC8;
	Wed,  4 Dec 2024 07:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EHFsZQDO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755C418FC8C
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298453; cv=none; b=m7MpvM+Z7UjQ6NkA/o2rt2LGtl/H47qV6DEZPVJXK1yYTGS1tA/V//E/bwpKHS6HP8eYvP7DLK4jxdPUiRdVZt/FyAQsUWJNL35bmahHj77kUB9kEbBLOO4GGOjMDrctFechxGACr4D60OpwM4bIXDltV62v0BmVhyQ+LwJ2HpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298453; c=relaxed/simple;
	bh=LiembOcurmOw4+40ybsntquCMb6mhOp2FYXN7pIggRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTaLvyscT0nDMqKArMUMlok95QedrN1/7GHY/w0HOJyKWZjTo2UlCT7AFzRih78GkMYKkbtyk0YyxkU2vSdliY3U5GMzZBSG3iuMLsxg18D93+todY64vIdjbD0A8e09Io2h0vemqsF5YJb3F4q1nCPyCmYTX8kISpZJUgjdTz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EHFsZQDO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733298450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SgDcxHvMPuaNGZPmBKKvBNkHii79DsY2D29vW13rUKI=;
	b=EHFsZQDOV4JQ7ffXhk9FZuq/cj0emjkqhYZ9CAsm7BpkCXRvls10nO8I510r92efUwGwV/
	gis89vVFnL27ohBpDoS95/1dia+NQ4IXyjkgtl6kVRrtvoqCk1sr9OSC2BcHPQiZrfWYOZ
	zStm0njG0xco+lOOvE8mo0NF/mAON90=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-lMc423foOGCfWEJEdVllBw-1; Wed,
 04 Dec 2024 02:47:27 -0500
X-MC-Unique: lMc423foOGCfWEJEdVllBw-1
X-Mimecast-MFC-AGG-ID: lMc423foOGCfWEJEdVllBw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB24C1955DD3;
	Wed,  4 Dec 2024 07:47:25 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0CCA11956048;
	Wed,  4 Dec 2024 07:47:22 +0000 (UTC)
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
Subject: [PATCH net-next v2 02/39] rxrpc: Fix handling of received connection abort
Date: Wed,  4 Dec 2024 07:46:30 +0000
Message-ID: <20241204074710.990092-3-dhowells@redhat.com>
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


