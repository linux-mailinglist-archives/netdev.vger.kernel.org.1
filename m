Return-Path: <netdev+bounces-306671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qarTF01HUWoQBwMAu9opvQ
	(envelope-from <netdev+bounces-306671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:26:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E82673DBD7
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:26:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="Np3r/wGN";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306671-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306671-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 967E930239C5
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3AF38B14C;
	Fri, 10 Jul 2026 19:23:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30806385D61
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 19:23:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711396; cv=none; b=nnuuVypa718owH4cGLCOlNBAp8UiYYcFC/KhhIved9mgxAaNuLlExYs1fyayG72vILZrIbJ+TJUbsz6Kipor5zZHv8ALlSqAhro5eSYDbrZRjsDB0S7ZTAWUrrC4P/8wq4LxxXk8/oBZSYk2/T/sD8/Gyw1KiVN11UD7ET1Qm8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711396; c=relaxed/simple;
	bh=LLqegErpiwnNJz+6QEiPVr0B0jHHttmhiT2gIzb7tbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNy6zSUF6XLSBt5gDRSGz0a8a9lLjjyvSum0nmtv6gUqSTWfxGsk4FysGxXvKezEBPVupphqWWS5Q/ZGNxHjFx5KLZD6glBhnkFfy01po3zar9t/y0XiGcAHYzTV+GRRH/gSp/0gY25eRzZJGBTrIEOeuuLLFSi4cnWp8jo5PGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Np3r/wGN; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783711392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0U90slAaEmIBgfeuUR2Wm/d5X06U5sN8cTBSeFBj2M=;
	b=Np3r/wGNevA0xUzuE/+SZ9HFEMcj1ejZPdMjCWteKZbhwyYq9kzWiO00gkMn8xSEEe3UZU
	HrdyR7aGaYwN0ltBP5Qiu6Oyy7XxzYyTGShLrl3+QMWVqcXRO1467upOaWW4eb8idtPU/0
	PyRLJHkFk94J11GI4ilXiaynxXDGb1E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-phVqJ_nvNE6ZtVwKWSiRJQ-1; Fri,
 10 Jul 2026 15:23:08 -0400
X-MC-Unique: phVqJ_nvNE6ZtVwKWSiRJQ-1
X-Mimecast-MFC-AGG-ID: phVqJ_nvNE6ZtVwKWSiRJQ_1783711387
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44ADF180058D;
	Fri, 10 Jul 2026 19:23:07 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 387E030A8;
	Fri, 10 Jul 2026 19:23:03 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@kernel.org
Subject: [PATCH net v2 08/16] rxrpc: Fix generation of notifications after call completion
Date: Fri, 10 Jul 2026 20:22:10 +0100
Message-ID: <20260710192220.1922433-9-dhowells@redhat.com>
In-Reply-To: <20260710192220.1922433-1-dhowells@redhat.com>
References: <20260710192220.1922433-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306671-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dhowells@redhat.com,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,auristor.com:email,davemloft.net:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E82673DBD7

AF_RXRPC may generate a notification to the application after a call has
completed because it generates one notification when
rxrpc_input_split_jumbo() queues the final packet and completes the call
and then generates another when rxrpc_input_split_jumbo() does the
aggregated data receive notification at the end of the function.

This might cause the AFS filesystem to malfunction because it tries to
queue the afs_call for processing an extra time.  Most of the time this
happens quickly enough that the second queue_work skips, but sometimes this
means that the call work may happen a second time with implications for
afs_call lifetime management.

Fix this by:

 (1) Create a lighter version of rxrpc_notify_socket() that's just used to
     requeue a call for rxrpc_recvmsg() without creating another
     notification.

 (2) Move rxrpc_notify_socket() to call_state.c and rename it to
     __rxrpc_notify_socket().

 (3) Create a wrapper called rxrpc_notify_socket() that skips the
     notification if a call is completed.

 (4) Make rxrpc_set_call_completion() call __rxrpc_notify_socket() to avoid
     the skip-if-completed check.

Fixes: 2d1faf7a0ca3 ("rxrpc: Simplify skbuff accounting in receive path")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
---
 include/trace/events/rxrpc.h |  1 +
 net/rxrpc/call_state.c       | 57 +++++++++++++++++++++++++++++++++++-
 net/rxrpc/recvmsg.c          | 42 +++++++++-----------------
 3 files changed, 71 insertions(+), 29 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 8f3e3967885a..d7c7b04d69fc 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -343,6 +343,7 @@
 	EM(rxrpc_call_see_distribute_error,	"SEE dist-err") \
 	EM(rxrpc_call_see_input,		"SEE input   ") \
 	EM(rxrpc_call_see_notify_released,	"SEE nfy-rlsd") \
+	EM(rxrpc_call_see_notify_skipped,	"SEE nfy-skip") \
 	EM(rxrpc_call_see_recvmsg,		"SEE recvmsg ") \
 	EM(rxrpc_call_see_recvmsg_requeue,	"SEE recv-rqu") \
 	EM(rxrpc_call_see_recvmsg_requeue_first, "SEE recv-rqF") \
diff --git a/net/rxrpc/call_state.c b/net/rxrpc/call_state.c
index 6afb54373ebb..6e402312e145 100644
--- a/net/rxrpc/call_state.c
+++ b/net/rxrpc/call_state.c
@@ -7,6 +7,61 @@
 
 #include "ar-internal.h"
 
+/*
+ * Post a call for attention by the socket or kernel service.  Further
+ * notifications are suppressed by putting recvmsg_link on a dummy queue.
+ */
+static void __rxrpc_notify_socket(struct rxrpc_call *call)
+{
+	struct rxrpc_sock *rx;
+	struct sock *sk;
+
+	if (test_bit(RXRPC_CALL_RELEASED, &call->flags)) {
+		rxrpc_see_call(call, rxrpc_call_see_notify_released);
+		return;
+	}
+
+	rcu_read_lock();
+
+	rx = rcu_dereference(call->socket);
+	sk = &rx->sk;
+	if (rx && sk->sk_state < RXRPC_CLOSE) {
+		if (call->notify_rx) {
+			spin_lock_irq(&call->notify_lock);
+			call->notify_rx(sk, call, call->user_call_ID);
+			spin_unlock_irq(&call->notify_lock);
+		} else {
+			spin_lock_irq(&rx->recvmsg_lock);
+			if (list_empty(&call->recvmsg_link)) {
+				rxrpc_get_call(call, rxrpc_call_get_notify_socket);
+				list_add_tail(&call->recvmsg_link, &rx->recvmsg_q);
+			}
+			spin_unlock_irq(&rx->recvmsg_lock);
+
+			if (!sock_flag(sk, SOCK_DEAD)) {
+				_debug("call %ps", sk->sk_data_ready);
+				sk->sk_data_ready(sk);
+			}
+		}
+	}
+
+	rcu_read_unlock();
+}
+
+/*
+ * Post a call for attention by the socket or kernel service.  Further
+ * notifications are suppressed by putting recvmsg_link on a dummy queue.
+ */
+void rxrpc_notify_socket(struct rxrpc_call *call)
+{
+	if (rxrpc_call_is_complete(call)) {
+		rxrpc_see_call(call, rxrpc_call_see_notify_skipped);
+		return;
+	}
+
+	__rxrpc_notify_socket(call);
+}
+
 /*
  * Transition a call to the complete state.
  */
@@ -25,7 +80,7 @@ bool rxrpc_set_call_completion(struct rxrpc_call *call,
 	rxrpc_set_call_state(call, RXRPC_CALL_COMPLETE);
 	trace_rxrpc_call_complete(call);
 	wake_up(&call->waitq);
-	rxrpc_notify_socket(call);
+	__rxrpc_notify_socket(call);
 	return true;
 }
 
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index efcba4b2e74f..28b2148b5693 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -17,13 +17,12 @@
 #include "ar-internal.h"
 
 /*
- * Post a call for attention by the socket or kernel service.  Further
- * notifications are suppressed by putting recvmsg_link on a dummy queue.
+ * Requeue a call for recvmsg() to pick up.
  */
-void rxrpc_notify_socket(struct rxrpc_call *call)
+static void rxrpc_requeue_call(struct socket *sock, struct rxrpc_call *call)
 {
-	struct rxrpc_sock *rx;
-	struct sock *sk;
+	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
+	struct sock *sk = &rx->sk;
 
 	_enter("%d", call->debug_id);
 
@@ -32,31 +31,18 @@ void rxrpc_notify_socket(struct rxrpc_call *call)
 		return;
 	}
 
-	rcu_read_lock();
-
-	rx = rcu_dereference(call->socket);
-	sk = &rx->sk;
-	if (rx && sk->sk_state < RXRPC_CLOSE) {
-		if (call->notify_rx) {
-			spin_lock_irq(&call->notify_lock);
-			call->notify_rx(sk, call, call->user_call_ID);
-			spin_unlock_irq(&call->notify_lock);
-		} else {
-			spin_lock_irq(&rx->recvmsg_lock);
-			if (list_empty(&call->recvmsg_link)) {
-				rxrpc_get_call(call, rxrpc_call_get_notify_socket);
-				list_add_tail(&call->recvmsg_link, &rx->recvmsg_q);
-			}
-			spin_unlock_irq(&rx->recvmsg_lock);
+	spin_lock_irq(&rx->recvmsg_lock);
+	if (list_empty(&call->recvmsg_link)) {
+		rxrpc_get_call(call, rxrpc_call_get_notify_socket);
+		list_add_tail(&call->recvmsg_link, &rx->recvmsg_q);
+	}
+	spin_unlock_irq(&rx->recvmsg_lock);
 
-			if (!sock_flag(sk, SOCK_DEAD)) {
-				_debug("call %ps", sk->sk_data_ready);
-				sk->sk_data_ready(sk);
-			}
-		}
+	if (!sock_flag(sk, SOCK_DEAD)) {
+		_debug("call %ps", sk->sk_data_ready);
+		sk->sk_data_ready(sk);
 	}
 
-	rcu_read_unlock();
 	_leave("");
 }
 
@@ -561,7 +547,7 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	if (!(flags & MSG_PEEK) &&
 	    !skb_queue_empty(&call->recvmsg_queue))
-		rxrpc_notify_socket(call);
+		rxrpc_requeue_call(sock, call);
 	goto not_yet_complete;
 
 call_failed:


