Return-Path: <netdev+bounces-148100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7139E0660
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 16:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E182B83116
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4548A217F57;
	Mon,  2 Dec 2024 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aL6jCTi0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D6D204F9B
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150000; cv=none; b=WrgGMyY1LNh4BDqgrmbujHKFTZNKdD6YQ2+6EK1B+BbNm3F4UtctuOwObK300Ka0/TvthsqT7uwr22gH+OxRvdQA/3axJkXGkM0WH53tL1gQzTWY9LBcoz6ymol/mxmWw24U0jgF+KI71ZdKgwLtf4pzoG17k3S/AKz3yNW8Mgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150000; c=relaxed/simple;
	bh=1mIIH8Iw/IciX3wLnDBvdQLFJ7FmzU6Dq8hsWpIBHLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tM6NLKCslSlZp1+tarrEtZj78BhWeAKFmhXBuASD7culS2B/w0Mi1Pi5cvvYuOoaK4hpbxGuwjo4NDMDbUcYRCh1DpTQVAtebONROTofn63oeLOTZEvETqAXKCoEf9WBqcklKFcjwMoafEXSdfh++L7IX9sS7XO76esResfHEnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aL6jCTi0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733149997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Luup5UvTlH+HlomZ0XkF5GjW7awTivjnptA5PcBZ5bQ=;
	b=aL6jCTi0nkMLiFP3gcLNsbHqHvX8//5u7gE2z9QFfvWNBHVozgll20yM6g0GYEGTTFBYuE
	xzZ+U+RCO1ziftmn3vGaGbQKJQlZRAK3UP+O/vBQksdbhqebxPbQu2KlrAWwYdq9V8We8Q
	vI08FsRCtYCeXaELWPm6bG87nz77Fu0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-gCT8aPOhPAeg6wieBhOlUA-1; Mon,
 02 Dec 2024 09:33:14 -0500
X-MC-Unique: gCT8aPOhPAeg6wieBhOlUA-1
X-Mimecast-MFC-AGG-ID: gCT8aPOhPAeg6wieBhOlUA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76B38195D005;
	Mon,  2 Dec 2024 14:33:12 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 99C8830001A7;
	Mon,  2 Dec 2024 14:33:09 +0000 (UTC)
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
Subject: [PATCH net-next 31/37] rxrpc: Use irq-disabling spinlocks between app and I/O thread
Date: Mon,  2 Dec 2024 14:30:49 +0000
Message-ID: <20241202143057.378147-32-dhowells@redhat.com>
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

Where a spinlock is used by both the application thread and the I/O thread,
use irq-disabling locking so that an interrupt taken on the app thread
doesn't also slow down the I/O thread.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/af_rxrpc.c    |  4 ++--
 net/rxrpc/ar-internal.h |  1 -
 net/rxrpc/call_accept.c | 20 ++++++++++----------
 net/rxrpc/call_object.c | 15 +++++++--------
 net/rxrpc/conn_client.c | 12 ++++++------
 net/rxrpc/conn_event.c  |  8 ++++----
 net/rxrpc/conn_object.c |  8 ++++----
 net/rxrpc/input.c       |  5 +----
 net/rxrpc/io_thread.c   |  8 ++++----
 net/rxrpc/peer_event.c  |  8 ++++----
 net/rxrpc/peer_object.c |  1 +
 net/rxrpc/recvmsg.c     | 18 +++++++++---------
 net/rxrpc/security.c    |  4 ++--
 net/rxrpc/sendmsg.c     |  2 --
 14 files changed, 54 insertions(+), 60 deletions(-)

diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 9d8bd0b37e41..86873399f7d5 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -408,9 +408,9 @@ void rxrpc_kernel_shutdown_call(struct socket *sock, struct rxrpc_call *call)
 
 		/* Make sure we're not going to call back into a kernel service */
 		if (call->notify_rx) {
-			spin_lock(&call->notify_lock);
+			spin_lock_irq(&call->notify_lock);
 			call->notify_rx = rxrpc_dummy_notify_rx;
-			spin_unlock(&call->notify_lock);
+			spin_unlock_irq(&call->notify_lock);
 		}
 	}
 	mutex_unlock(&call->user_mutex);
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 0a9fad23c9ac..4621247012f6 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -700,7 +700,6 @@ struct rxrpc_call {
 	struct rxrpc_txqueue	*send_queue;	/* Queue that sendmsg is writing into */
 
 	/* Transmitted data tracking. */
-	spinlock_t		tx_lock;	/* Transmit queue lock */
 	struct rxrpc_txqueue	*tx_queue;	/* Start of transmission buffers */
 	struct rxrpc_txqueue	*tx_qtail;	/* End of transmission buffers */
 	rxrpc_seq_t		tx_qbase;	/* First slot in tx_queue */
diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index a6776b1604ba..e685034ce4f7 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -188,8 +188,8 @@ void rxrpc_discard_prealloc(struct rxrpc_sock *rx)
 	/* Make sure that there aren't any incoming calls in progress before we
 	 * clear the preallocation buffers.
 	 */
-	spin_lock(&rx->incoming_lock);
-	spin_unlock(&rx->incoming_lock);
+	spin_lock_irq(&rx->incoming_lock);
+	spin_unlock_irq(&rx->incoming_lock);
 
 	head = b->peer_backlog_head;
 	tail = b->peer_backlog_tail;
@@ -343,7 +343,7 @@ bool rxrpc_new_incoming_call(struct rxrpc_local *local,
 	if (sp->hdr.type != RXRPC_PACKET_TYPE_DATA)
 		return rxrpc_protocol_error(skb, rxrpc_eproto_no_service_call);
 
-	read_lock(&local->services_lock);
+	read_lock_irq(&local->services_lock);
 
 	/* Weed out packets to services we're not offering.  Packets that would
 	 * begin a call are explicitly rejected and the rest are just
@@ -399,12 +399,12 @@ bool rxrpc_new_incoming_call(struct rxrpc_local *local,
 	spin_unlock(&conn->state_lock);
 
 	spin_unlock(&rx->incoming_lock);
-	read_unlock(&local->services_lock);
+	read_unlock_irq(&local->services_lock);
 
 	if (hlist_unhashed(&call->error_link)) {
-		spin_lock(&call->peer->lock);
+		spin_lock_irq(&call->peer->lock);
 		hlist_add_head(&call->error_link, &call->peer->error_targets);
-		spin_unlock(&call->peer->lock);
+		spin_unlock_irq(&call->peer->lock);
 	}
 
 	_leave(" = %p{%d}", call, call->debug_id);
@@ -413,20 +413,20 @@ bool rxrpc_new_incoming_call(struct rxrpc_local *local,
 	return true;
 
 unsupported_service:
-	read_unlock(&local->services_lock);
+	read_unlock_irq(&local->services_lock);
 	return rxrpc_direct_abort(skb, rxrpc_abort_service_not_offered,
 				  RX_INVALID_OPERATION, -EOPNOTSUPP);
 unsupported_security:
-	read_unlock(&local->services_lock);
+	read_unlock_irq(&local->services_lock);
 	return rxrpc_direct_abort(skb, rxrpc_abort_service_not_offered,
 				  RX_INVALID_OPERATION, -EKEYREJECTED);
 no_call:
 	spin_unlock(&rx->incoming_lock);
-	read_unlock(&local->services_lock);
+	read_unlock_irq(&local->services_lock);
 	_leave(" = f [%u]", skb->mark);
 	return false;
 discard:
-	read_unlock(&local->services_lock);
+	read_unlock_irq(&local->services_lock);
 	return true;
 }
 
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 91e9b331047f..015349445a79 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -49,7 +49,7 @@ void rxrpc_poke_call(struct rxrpc_call *call, enum rxrpc_call_poke_trace what)
 	bool busy;
 
 	if (!test_bit(RXRPC_CALL_DISCONNECTED, &call->flags)) {
-		spin_lock_bh(&local->lock);
+		spin_lock_irq(&local->lock);
 		busy = !list_empty(&call->attend_link);
 		trace_rxrpc_poke_call(call, busy, what);
 		if (!busy && !rxrpc_try_get_call(call, rxrpc_call_get_poke))
@@ -57,7 +57,7 @@ void rxrpc_poke_call(struct rxrpc_call *call, enum rxrpc_call_poke_trace what)
 		if (!busy) {
 			list_add_tail(&call->attend_link, &local->call_attend_q);
 		}
-		spin_unlock_bh(&local->lock);
+		spin_unlock_irq(&local->lock);
 		if (!busy)
 			rxrpc_wake_up_io_thread(local);
 	}
@@ -151,7 +151,6 @@ struct rxrpc_call *rxrpc_alloc_call(struct rxrpc_sock *rx, gfp_t gfp,
 	skb_queue_head_init(&call->rx_oos_queue);
 	init_waitqueue_head(&call->waitq);
 	spin_lock_init(&call->notify_lock);
-	spin_lock_init(&call->tx_lock);
 	refcount_set(&call->ref, 1);
 	call->debug_id		= debug_id;
 	call->tx_total_len	= -1;
@@ -303,9 +302,9 @@ static int rxrpc_connect_call(struct rxrpc_call *call, gfp_t gfp)
 
 	trace_rxrpc_client(NULL, -1, rxrpc_client_queue_new_call);
 	rxrpc_get_call(call, rxrpc_call_get_io_thread);
-	spin_lock(&local->client_call_lock);
+	spin_lock_irq(&local->client_call_lock);
 	list_add_tail(&call->wait_link, &local->new_client_calls);
-	spin_unlock(&local->client_call_lock);
+	spin_unlock_irq(&local->client_call_lock);
 	rxrpc_wake_up_io_thread(local);
 	return 0;
 
@@ -435,7 +434,7 @@ struct rxrpc_call *rxrpc_new_client_call(struct rxrpc_sock *rx,
 
 /*
  * Set up an incoming call.  call->conn points to the connection.
- * This is called in BH context and isn't allowed to fail.
+ * This is called with interrupts disabled and isn't allowed to fail.
  */
 void rxrpc_incoming_call(struct rxrpc_sock *rx,
 			 struct rxrpc_call *call,
@@ -577,7 +576,7 @@ void rxrpc_release_call(struct rxrpc_sock *rx, struct rxrpc_call *call)
 	rxrpc_put_call_slot(call);
 
 	/* Make sure we don't get any more notifications */
-	spin_lock(&rx->recvmsg_lock);
+	spin_lock_irq(&rx->recvmsg_lock);
 
 	if (!list_empty(&call->recvmsg_link)) {
 		_debug("unlinking once-pending call %p { e=%lx f=%lx }",
@@ -590,7 +589,7 @@ void rxrpc_release_call(struct rxrpc_sock *rx, struct rxrpc_call *call)
 	call->recvmsg_link.next = NULL;
 	call->recvmsg_link.prev = NULL;
 
-	spin_unlock(&rx->recvmsg_lock);
+	spin_unlock_irq(&rx->recvmsg_lock);
 	if (put)
 		rxrpc_put_call(call, rxrpc_call_put_unnotify);
 
diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index 5f76bd90567c..db0099197890 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -510,9 +510,9 @@ void rxrpc_connect_client_calls(struct rxrpc_local *local)
 	struct rxrpc_call *call;
 	LIST_HEAD(new_client_calls);
 
-	spin_lock(&local->client_call_lock);
+	spin_lock_irq(&local->client_call_lock);
 	list_splice_tail_init(&local->new_client_calls, &new_client_calls);
-	spin_unlock(&local->client_call_lock);
+	spin_unlock_irq(&local->client_call_lock);
 
 	while ((call = list_first_entry_or_null(&new_client_calls,
 						struct rxrpc_call, wait_link))) {
@@ -547,9 +547,9 @@ void rxrpc_expose_client_call(struct rxrpc_call *call)
 			set_bit(RXRPC_CONN_DONT_REUSE, &conn->flags);
 		trace_rxrpc_client(conn, channel, rxrpc_client_exposed);
 
-		spin_lock(&call->peer->lock);
+		spin_lock_irq(&call->peer->lock);
 		hlist_add_head(&call->error_link, &call->peer->error_targets);
-		spin_unlock(&call->peer->lock);
+		spin_unlock_irq(&call->peer->lock);
 	}
 }
 
@@ -590,9 +590,9 @@ void rxrpc_disconnect_client_call(struct rxrpc_bundle *bundle, struct rxrpc_call
 		ASSERTCMP(call->call_id, ==, 0);
 		ASSERT(!test_bit(RXRPC_CALL_EXPOSED, &call->flags));
 		/* May still be on ->new_client_calls. */
-		spin_lock(&local->client_call_lock);
+		spin_lock_irq(&local->client_call_lock);
 		list_del_init(&call->wait_link);
-		spin_unlock(&local->client_call_lock);
+		spin_unlock_irq(&local->client_call_lock);
 		return;
 	}
 
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 511e1208a748..b6f15d15ecac 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -26,7 +26,7 @@ static bool rxrpc_set_conn_aborted(struct rxrpc_connection *conn, struct sk_buff
 	bool aborted = false;
 
 	if (conn->state != RXRPC_CONN_ABORTED) {
-		spin_lock(&conn->state_lock);
+		spin_lock_irq(&conn->state_lock);
 		if (conn->state != RXRPC_CONN_ABORTED) {
 			conn->abort_code = abort_code;
 			conn->error	 = err;
@@ -37,7 +37,7 @@ static bool rxrpc_set_conn_aborted(struct rxrpc_connection *conn, struct sk_buff
 			set_bit(RXRPC_CONN_EV_ABORT_CALLS, &conn->events);
 			aborted = true;
 		}
-		spin_unlock(&conn->state_lock);
+		spin_unlock_irq(&conn->state_lock);
 	}
 
 	return aborted;
@@ -259,10 +259,10 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 		if (ret < 0)
 			return ret;
 
-		spin_lock(&conn->state_lock);
+		spin_lock_irq(&conn->state_lock);
 		if (conn->state == RXRPC_CONN_SERVICE_CHALLENGING)
 			conn->state = RXRPC_CONN_SERVICE;
-		spin_unlock(&conn->state_lock);
+		spin_unlock_irq(&conn->state_lock);
 
 		if (conn->state == RXRPC_CONN_SERVICE) {
 			/* Offload call state flipping to the I/O thread.  As
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index b0627398311b..7eba4d7d9a38 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -31,13 +31,13 @@ void rxrpc_poke_conn(struct rxrpc_connection *conn, enum rxrpc_conn_trace why)
 	if (WARN_ON_ONCE(!local))
 		return;
 
-	spin_lock_bh(&local->lock);
+	spin_lock_irq(&local->lock);
 	busy = !list_empty(&conn->attend_link);
 	if (!busy) {
 		rxrpc_get_connection(conn, why);
 		list_add_tail(&conn->attend_link, &local->conn_attend_q);
 	}
-	spin_unlock_bh(&local->lock);
+	spin_unlock_irq(&local->lock);
 	rxrpc_wake_up_io_thread(local);
 }
 
@@ -196,9 +196,9 @@ void rxrpc_disconnect_call(struct rxrpc_call *call)
 	call->peer->cong_ssthresh = call->cong_ssthresh;
 
 	if (!hlist_unhashed(&call->error_link)) {
-		spin_lock(&call->peer->lock);
+		spin_lock_irq(&call->peer->lock);
 		hlist_del_init(&call->error_link);
-		spin_unlock(&call->peer->lock);
+		spin_unlock_irq(&call->peer->lock);
 	}
 
 	if (rxrpc_is_client_call(call)) {
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 88693080ef96..70831020372e 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -424,7 +424,7 @@ static void rxrpc_input_queue_data(struct rxrpc_call *call, struct sk_buff *skb,
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	bool last = sp->hdr.flags & RXRPC_LAST_PACKET;
 
-	__skb_queue_tail(&call->recvmsg_queue, skb);
+	skb_queue_tail(&call->recvmsg_queue, skb);
 	rxrpc_input_update_ack_window(call, window, wtop);
 	trace_rxrpc_receive(call, last ? why + 1 : why, sp->hdr.serial, sp->hdr.seq);
 	if (last)
@@ -501,7 +501,6 @@ static void rxrpc_input_data_one(struct rxrpc_call *call, struct sk_buff *skb,
 
 		rxrpc_get_skb(skb, rxrpc_skb_get_to_recvmsg);
 
-		spin_lock(&call->recvmsg_queue.lock);
 		rxrpc_input_queue_data(call, skb, window, wtop, rxrpc_receive_queue);
 		*_notify = true;
 
@@ -523,8 +522,6 @@ static void rxrpc_input_data_one(struct rxrpc_call *call, struct sk_buff *skb,
 					       rxrpc_receive_queue_oos);
 		}
 
-		spin_unlock(&call->recvmsg_queue.lock);
-
 		call->ackr_sack_base = sack;
 	} else {
 		unsigned int slot;
diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
index e47979b06a8a..86a746f54851 100644
--- a/net/rxrpc/io_thread.c
+++ b/net/rxrpc/io_thread.c
@@ -500,9 +500,9 @@ int rxrpc_io_thread(void *data)
 		}
 
 		/* Deal with connections that want immediate attention. */
-		spin_lock_bh(&local->lock);
+		spin_lock_irq(&local->lock);
 		list_splice_tail_init(&local->conn_attend_q, &conn_attend_q);
-		spin_unlock_bh(&local->lock);
+		spin_unlock_irq(&local->lock);
 
 		while ((conn = list_first_entry_or_null(&conn_attend_q,
 							struct rxrpc_connection,
@@ -517,9 +517,9 @@ int rxrpc_io_thread(void *data)
 			rxrpc_discard_expired_client_conns(local);
 
 		/* Deal with calls that want immediate attention. */
-		spin_lock_bh(&local->lock);
+		spin_lock_irq(&local->lock);
 		list_splice_tail_init(&local->call_attend_q, &call_attend_q);
-		spin_unlock_bh(&local->lock);
+		spin_unlock_irq(&local->lock);
 
 		while ((call = list_first_entry_or_null(&call_attend_q,
 							struct rxrpc_call,
diff --git a/net/rxrpc/peer_event.c b/net/rxrpc/peer_event.c
index 20b2f28400b7..19c1892c88d6 100644
--- a/net/rxrpc/peer_event.c
+++ b/net/rxrpc/peer_event.c
@@ -213,23 +213,23 @@ static void rxrpc_distribute_error(struct rxrpc_peer *peer, struct sk_buff *skb,
 	struct rxrpc_call *call;
 	HLIST_HEAD(error_targets);
 
-	spin_lock(&peer->lock);
+	spin_lock_irq(&peer->lock);
 	hlist_move_list(&peer->error_targets, &error_targets);
 
 	while (!hlist_empty(&error_targets)) {
 		call = hlist_entry(error_targets.first,
 				   struct rxrpc_call, error_link);
 		hlist_del_init(&call->error_link);
-		spin_unlock(&peer->lock);
+		spin_unlock_irq(&peer->lock);
 
 		rxrpc_see_call(call, rxrpc_call_see_distribute_error);
 		rxrpc_set_call_completion(call, compl, 0, -err);
 		rxrpc_input_call_event(call);
 
-		spin_lock(&peer->lock);
+		spin_lock_irq(&peer->lock);
 	}
 
-	spin_unlock(&peer->lock);
+	spin_unlock_irq(&peer->lock);
 }
 
 /*
diff --git a/net/rxrpc/peer_object.c b/net/rxrpc/peer_object.c
index 80ef6f06d512..27b34ed4d76a 100644
--- a/net/rxrpc/peer_object.c
+++ b/net/rxrpc/peer_object.c
@@ -320,6 +320,7 @@ static void rxrpc_free_peer(struct rxrpc_peer *peer)
  * Set up a new incoming peer.  There shouldn't be any other matching peers
  * since we've already done a search in the list from the non-reentrant context
  * (the data_ready handler) that is the only place we can add new peers.
+ * Called with interrupts disabled.
  */
 void rxrpc_new_incoming_peer(struct rxrpc_local *local, struct rxrpc_peer *peer)
 {
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index a482f88c5fc5..32cd5f1d541d 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -36,16 +36,16 @@ void rxrpc_notify_socket(struct rxrpc_call *call)
 	sk = &rx->sk;
 	if (rx && sk->sk_state < RXRPC_CLOSE) {
 		if (call->notify_rx) {
-			spin_lock(&call->notify_lock);
+			spin_lock_irq(&call->notify_lock);
 			call->notify_rx(sk, call, call->user_call_ID);
-			spin_unlock(&call->notify_lock);
+			spin_unlock_irq(&call->notify_lock);
 		} else {
-			spin_lock(&rx->recvmsg_lock);
+			spin_lock_irq(&rx->recvmsg_lock);
 			if (list_empty(&call->recvmsg_link)) {
 				rxrpc_get_call(call, rxrpc_call_get_notify_socket);
 				list_add_tail(&call->recvmsg_link, &rx->recvmsg_q);
 			}
-			spin_unlock(&rx->recvmsg_lock);
+			spin_unlock_irq(&rx->recvmsg_lock);
 
 			if (!sock_flag(sk, SOCK_DEAD)) {
 				_debug("call %ps", sk->sk_data_ready);
@@ -337,14 +337,14 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	 * We also want to weed out calls that got requeued whilst we were
 	 * shovelling data out.
 	 */
-	spin_lock(&rx->recvmsg_lock);
+	spin_lock_irq(&rx->recvmsg_lock);
 	l = rx->recvmsg_q.next;
 	call = list_entry(l, struct rxrpc_call, recvmsg_link);
 
 	if (!rxrpc_call_is_complete(call) &&
 	    skb_queue_empty(&call->recvmsg_queue)) {
 		list_del_init(&call->recvmsg_link);
-		spin_unlock(&rx->recvmsg_lock);
+		spin_unlock_irq(&rx->recvmsg_lock);
 		release_sock(&rx->sk);
 		trace_rxrpc_recvmsg(call->debug_id, rxrpc_recvmsg_unqueue, 0);
 		rxrpc_put_call(call, rxrpc_call_put_recvmsg);
@@ -355,7 +355,7 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		list_del_init(&call->recvmsg_link);
 	else
 		rxrpc_get_call(call, rxrpc_call_get_recvmsg);
-	spin_unlock(&rx->recvmsg_lock);
+	spin_unlock_irq(&rx->recvmsg_lock);
 
 	call_debug_id = call->debug_id;
 	trace_rxrpc_recvmsg(call_debug_id, rxrpc_recvmsg_dequeue, 0);
@@ -445,9 +445,9 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 error_requeue_call:
 	if (!(flags & MSG_PEEK)) {
-		spin_lock(&rx->recvmsg_lock);
+		spin_lock_irq(&rx->recvmsg_lock);
 		list_add(&call->recvmsg_link, &rx->recvmsg_q);
-		spin_unlock(&rx->recvmsg_lock);
+		spin_unlock_irq(&rx->recvmsg_lock);
 		trace_rxrpc_recvmsg(call_debug_id, rxrpc_recvmsg_requeue, 0);
 	} else {
 		rxrpc_put_call(call, rxrpc_call_put_recvmsg);
diff --git a/net/rxrpc/security.c b/net/rxrpc/security.c
index cb8dd1d3b1d4..9784adc8f275 100644
--- a/net/rxrpc/security.c
+++ b/net/rxrpc/security.c
@@ -114,10 +114,10 @@ int rxrpc_init_client_conn_security(struct rxrpc_connection *conn)
 	if (conn->state == RXRPC_CONN_CLIENT_UNSECURED) {
 		ret = conn->security->init_connection_security(conn, token);
 		if (ret == 0) {
-			spin_lock(&conn->state_lock);
+			spin_lock_irq(&conn->state_lock);
 			if (conn->state == RXRPC_CONN_CLIENT_UNSECURED)
 				conn->state = RXRPC_CONN_CLIENT;
-			spin_unlock(&conn->state_lock);
+			spin_unlock_irq(&conn->state_lock);
 		}
 	}
 	mutex_unlock(&conn->security_lock);
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index e602dde0189c..018053b71084 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -259,7 +259,6 @@ static void rxrpc_queue_packet(struct rxrpc_sock *rx, struct rxrpc_call *call,
 		trace_rxrpc_tq(call, sq, seq, rxrpc_tq_queue);
 
 	/* Add the packet to the call's output buffer */
-	spin_lock(&call->tx_lock);
 	poke = (call->tx_bottom == call->send_top);
 	sq->bufs[ix] = txb;
 	/* Order send_top after the queue->next pointer and txb content. */
@@ -268,7 +267,6 @@ static void rxrpc_queue_packet(struct rxrpc_sock *rx, struct rxrpc_call *call,
 		rxrpc_notify_end_tx(rx, call, notify_end_tx);
 		call->send_queue = NULL;
 	}
-	spin_unlock(&call->tx_lock);
 
 	if (poke)
 		rxrpc_poke_call(call, rxrpc_call_poke_start);


