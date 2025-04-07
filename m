Return-Path: <netdev+bounces-179545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0647A7D93B
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 11:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEAEE188ABDD
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 09:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E45233136;
	Mon,  7 Apr 2025 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WThenUxz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBEA233149
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 09:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744017314; cv=none; b=a2pgKQ6YyT3hNiJzcWfSD1lRd40Zc6wafM4x+S/RLxc7JZEF0gp4lSNTkjtnFRSIKsajC91UTlBN/NaOIQF4xASkWB7gdXb1M1tF00iFUJFoenyOWQCfapbQJT2Fbjhj23lOw14U+skldOxrWrv0esWzXNbL/NDS/stIwqU/B6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744017314; c=relaxed/simple;
	bh=Y6mnJHQX5+mCs8bvWULdzVl93+S8YVXwsE1eH/NREa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XjSx9ujrVKUdeTTwZaGP7s6a1hSjDEJU5XXz4WuvdEoDjHT7rhXYeYNroCyW7PNTEgLWtfA0IbTe6TAJqJYEShx/4muM3cNCvzTI2tayP/Qf4RyiaB1sN0ipTx74dA7MwrpbMt3NgQ74RbQciZo6Vm7TOjcx+4gjB+2fZtg/QOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WThenUxz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744017310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=19eBrQvP30Di+UhagaWD4Il2qja221/GQaSMJzM9veo=;
	b=WThenUxzkT92pKS6foKc5Opr5+BsD7Rn91zdZPHgQ4Aw9+4pY1Cl9hM77GTzTflWTzkYpB
	4xWz6XsYPYz70LFXn5IrbsLvTIXnJI04/qMLY3cvujWae3AmTrh4izvXrVfkWPIvZTygLk
	SlTVSJEs2leTvFeTWt3elhi5NSCs1hI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-373pH4koNma9PbWRuCdJFQ-1; Mon,
 07 Apr 2025 05:15:07 -0400
X-MC-Unique: 373pH4koNma9PbWRuCdJFQ-1
X-Mimecast-MFC-AGG-ID: 373pH4koNma9PbWRuCdJFQ_1744017305
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE80819560BB;
	Mon,  7 Apr 2025 09:15:04 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.40])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 50FA73001D0E;
	Mon,  7 Apr 2025 09:15:01 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-afs@lists.infradead.org,
	openafs-devel@openafs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 01/12] rxrpc: Pull out certain app callback funcs into an ops table
Date: Mon,  7 Apr 2025 10:14:32 +0100
Message-ID: <20250407091451.1174056-2-dhowells@redhat.com>
In-Reply-To: <20250407091451.1174056-1-dhowells@redhat.com>
References: <20250407091451.1174056-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

A number of functions separately furnish an AF_RXRPC socket with callback
function pointers into a kernel app (such as the AFS filesystem) that is
using it.  Replace most of these with an ops table for the entire socket.
This makes it easier to add more callback functions.

Note that the call incoming data processing callback is retaind as that
gets set to different things, depending on the type of op.

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
 fs/afs/rxrpc.c          | 11 ++++++++---
 include/net/af_rxrpc.h  | 25 +++++++++++++++----------
 net/rxrpc/af_rxrpc.c    | 20 ++++++++------------
 net/rxrpc/ar-internal.h |  3 +--
 net/rxrpc/call_accept.c | 34 ++++++++++++++++------------------
 net/rxrpc/rxperf.c      | 10 +++++++---
 6 files changed, 55 insertions(+), 48 deletions(-)

diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index d5e480a33859..a4734304e542 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -24,8 +24,15 @@ static void afs_wake_up_async_call(struct sock *, struct rxrpc_call *, unsigned
 static void afs_process_async_call(struct work_struct *);
 static void afs_rx_new_call(struct sock *, struct rxrpc_call *, unsigned long);
 static void afs_rx_discard_new_call(struct rxrpc_call *, unsigned long);
+static void afs_rx_attach(struct rxrpc_call *rxcall, unsigned long user_call_ID);
 static int afs_deliver_cm_op_id(struct afs_call *);
 
+static const struct rxrpc_kernel_ops afs_rxrpc_callback_ops = {
+	.notify_new_call	= afs_rx_new_call,
+	.discard_new_call	= afs_rx_discard_new_call,
+	.user_attach_call	= afs_rx_attach,
+};
+
 /* asynchronous incoming call initial processing */
 static const struct afs_call_type afs_RXCMxxxx = {
 	.name		= "CB.xxxx",
@@ -84,8 +91,7 @@ int afs_open_socket(struct afs_net *net)
 	 * it sends back to us.
 	 */
 
-	rxrpc_kernel_new_call_notification(socket, afs_rx_new_call,
-					   afs_rx_discard_new_call);
+	rxrpc_kernel_set_notifications(socket, &afs_rxrpc_callback_ops);
 
 	ret = kernel_listen(socket, INT_MAX);
 	if (ret < 0)
@@ -738,7 +744,6 @@ void afs_charge_preallocation(struct work_struct *work)
 
 		if (rxrpc_kernel_charge_accept(net->socket,
 					       afs_wake_up_async_call,
-					       afs_rx_attach,
 					       (unsigned long)call,
 					       GFP_KERNEL,
 					       call->debug_id) < 0)
diff --git a/include/net/af_rxrpc.h b/include/net/af_rxrpc.h
index cf793d18e5df..ebb6092c488b 100644
--- a/include/net/af_rxrpc.h
+++ b/include/net/af_rxrpc.h
@@ -29,18 +29,23 @@ enum rxrpc_interruptibility {
  */
 extern atomic_t rxrpc_debug_id;
 
+/*
+ * Operations table for rxrpc to call out to a kernel application (e.g. kAFS).
+ */
+struct rxrpc_kernel_ops {
+	void (*notify_new_call)(struct sock *sk, struct rxrpc_call *call,
+				unsigned long user_call_ID);
+	void (*discard_new_call)(struct rxrpc_call *call, unsigned long user_call_ID);
+	void (*user_attach_call)(struct rxrpc_call *call, unsigned long user_call_ID);
+};
+
 typedef void (*rxrpc_notify_rx_t)(struct sock *, struct rxrpc_call *,
 				  unsigned long);
 typedef void (*rxrpc_notify_end_tx_t)(struct sock *, struct rxrpc_call *,
 				      unsigned long);
-typedef void (*rxrpc_notify_new_call_t)(struct sock *, struct rxrpc_call *,
-					unsigned long);
-typedef void (*rxrpc_discard_new_call_t)(struct rxrpc_call *, unsigned long);
-typedef void (*rxrpc_user_attach_call_t)(struct rxrpc_call *, unsigned long);
 
-void rxrpc_kernel_new_call_notification(struct socket *,
-					rxrpc_notify_new_call_t,
-					rxrpc_discard_new_call_t);
+void rxrpc_kernel_set_notifications(struct socket *sock,
+				    const struct rxrpc_kernel_ops *app_ops);
 struct rxrpc_call *rxrpc_kernel_begin_call(struct socket *sock,
 					   struct rxrpc_peer *peer,
 					   struct key *key,
@@ -72,9 +77,9 @@ const struct sockaddr *rxrpc_kernel_remote_addr(const struct rxrpc_peer *peer);
 unsigned long rxrpc_kernel_set_peer_data(struct rxrpc_peer *peer, unsigned long app_data);
 unsigned long rxrpc_kernel_get_peer_data(const struct rxrpc_peer *peer);
 unsigned int rxrpc_kernel_get_srtt(const struct rxrpc_peer *);
-int rxrpc_kernel_charge_accept(struct socket *, rxrpc_notify_rx_t,
-			       rxrpc_user_attach_call_t, unsigned long, gfp_t,
-			       unsigned int);
+int rxrpc_kernel_charge_accept(struct socket *sock, rxrpc_notify_rx_t notify_rx,
+			       unsigned long user_call_ID, gfp_t gfp,
+			       unsigned int debug_id);
 void rxrpc_kernel_set_tx_length(struct socket *, struct rxrpc_call *, s64);
 bool rxrpc_kernel_check_life(const struct socket *, const struct rxrpc_call *);
 u32 rxrpc_kernel_get_epoch(struct socket *, struct rxrpc_call *);
diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 86873399f7d5..70467bbda4af 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -464,24 +464,20 @@ u32 rxrpc_kernel_get_epoch(struct socket *sock, struct rxrpc_call *call)
 EXPORT_SYMBOL(rxrpc_kernel_get_epoch);
 
 /**
- * rxrpc_kernel_new_call_notification - Get notifications of new calls
- * @sock: The socket to intercept received messages on
- * @notify_new_call: Function to be called when new calls appear
- * @discard_new_call: Function to discard preallocated calls
+ * rxrpc_kernel_set_notifications - Set table of callback operations
+ * @sock: The socket to install table upon
+ * @app_ops: Callback operation table to set
  *
- * Allow a kernel service to be given notifications about new calls.
+ * Allow a kernel service to set a table of event notifications on a socket.
  */
-void rxrpc_kernel_new_call_notification(
-	struct socket *sock,
-	rxrpc_notify_new_call_t notify_new_call,
-	rxrpc_discard_new_call_t discard_new_call)
+void rxrpc_kernel_set_notifications(struct socket *sock,
+				    const struct rxrpc_kernel_ops *app_ops)
 {
 	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
 
-	rx->notify_new_call = notify_new_call;
-	rx->discard_new_call = discard_new_call;
+	rx->app_ops = app_ops;
 }
-EXPORT_SYMBOL(rxrpc_kernel_new_call_notification);
+EXPORT_SYMBOL(rxrpc_kernel_set_notifications);
 
 /**
  * rxrpc_kernel_set_max_life - Set maximum lifespan on a call
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 3cc3af15086f..55810c6b4be8 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -146,8 +146,7 @@ struct rxrpc_backlog {
 struct rxrpc_sock {
 	/* WARNING: sk has to be the first member */
 	struct sock		sk;
-	rxrpc_notify_new_call_t	notify_new_call; /* Func to notify of new call */
-	rxrpc_discard_new_call_t discard_new_call; /* Func to discard a new call */
+	const struct rxrpc_kernel_ops *app_ops;	/* Table of kernel app notification funcs */
 	struct rxrpc_local	*local;		/* local endpoint */
 	struct rxrpc_backlog	*backlog;	/* Preallocation for services */
 	spinlock_t		incoming_lock;	/* Incoming call vs service shutdown lock */
diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index e685034ce4f7..a4b363b47cca 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -34,7 +34,6 @@ static void rxrpc_dummy_notify(struct sock *sk, struct rxrpc_call *call,
 static int rxrpc_service_prealloc_one(struct rxrpc_sock *rx,
 				      struct rxrpc_backlog *b,
 				      rxrpc_notify_rx_t notify_rx,
-				      rxrpc_user_attach_call_t user_attach_call,
 				      unsigned long user_call_ID, gfp_t gfp,
 				      unsigned int debug_id)
 {
@@ -123,9 +122,10 @@ static int rxrpc_service_prealloc_one(struct rxrpc_sock *rx,
 
 	call->user_call_ID = user_call_ID;
 	call->notify_rx = notify_rx;
-	if (user_attach_call) {
+	if (rx->app_ops &&
+	    rx->app_ops->user_attach_call) {
 		rxrpc_get_call(call, rxrpc_call_get_kernel_service);
-		user_attach_call(call, user_call_ID);
+		rx->app_ops->user_attach_call(call, user_call_ID);
 	}
 
 	rxrpc_get_call(call, rxrpc_call_get_userid);
@@ -219,9 +219,10 @@ void rxrpc_discard_prealloc(struct rxrpc_sock *rx)
 	while (CIRC_CNT(head, tail, size) > 0) {
 		struct rxrpc_call *call = b->call_backlog[tail];
 		rcu_assign_pointer(call->socket, rx);
-		if (rx->discard_new_call) {
+		if (rx->app_ops &&
+		    rx->app_ops->discard_new_call) {
 			_debug("discard %lx", call->user_call_ID);
-			rx->discard_new_call(call, call->user_call_ID);
+			rx->app_ops->discard_new_call(call, call->user_call_ID);
 			if (call->notify_rx)
 				call->notify_rx = rxrpc_dummy_notify;
 			rxrpc_put_call(call, rxrpc_call_put_kernel);
@@ -387,8 +388,9 @@ bool rxrpc_new_incoming_call(struct rxrpc_local *local,
 	rxrpc_incoming_call(rx, call, skb);
 	conn = call->conn;
 
-	if (rx->notify_new_call)
-		rx->notify_new_call(&rx->sk, call, call->user_call_ID);
+	if (rx->app_ops &&
+	    rx->app_ops->notify_new_call)
+		rx->app_ops->notify_new_call(&rx->sk, call, call->user_call_ID);
 
 	spin_lock(&conn->state_lock);
 	if (conn->state == RXRPC_CONN_SERVICE_UNSECURED) {
@@ -440,8 +442,7 @@ int rxrpc_user_charge_accept(struct rxrpc_sock *rx, unsigned long user_call_ID)
 	if (rx->sk.sk_state == RXRPC_CLOSE)
 		return -ESHUTDOWN;
 
-	return rxrpc_service_prealloc_one(rx, b, NULL, NULL, user_call_ID,
-					  GFP_KERNEL,
+	return rxrpc_service_prealloc_one(rx, b, NULL, user_call_ID, GFP_KERNEL,
 					  atomic_inc_return(&rxrpc_debug_id));
 }
 
@@ -449,20 +450,18 @@ int rxrpc_user_charge_accept(struct rxrpc_sock *rx, unsigned long user_call_ID)
  * rxrpc_kernel_charge_accept - Charge up socket with preallocated calls
  * @sock: The socket on which to preallocate
  * @notify_rx: Event notification function for the call
- * @user_attach_call: Func to attach call to user_call_ID
  * @user_call_ID: The tag to attach to the preallocated call
  * @gfp: The allocation conditions.
  * @debug_id: The tracing debug ID.
  *
- * Charge up the socket with preallocated calls, each with a user ID.  A
- * function should be provided to effect the attachment from the user's side.
- * The user is given a ref to hold on the call.
+ * Charge up the socket with preallocated calls, each with a user ID.  The
+ * ->user_attach_call() callback function should be provided to effect the
+ * attachment from the user's side.  The user is given a ref to hold on the
+ * call.
  *
  * Note that the call may be come connected before this function returns.
  */
-int rxrpc_kernel_charge_accept(struct socket *sock,
-			       rxrpc_notify_rx_t notify_rx,
-			       rxrpc_user_attach_call_t user_attach_call,
+int rxrpc_kernel_charge_accept(struct socket *sock, rxrpc_notify_rx_t notify_rx,
 			       unsigned long user_call_ID, gfp_t gfp,
 			       unsigned int debug_id)
 {
@@ -472,8 +471,7 @@ int rxrpc_kernel_charge_accept(struct socket *sock,
 	if (sock->sk->sk_state == RXRPC_CLOSE)
 		return -ESHUTDOWN;
 
-	return rxrpc_service_prealloc_one(rx, b, notify_rx,
-					  user_attach_call, user_call_ID,
+	return rxrpc_service_prealloc_one(rx, b, notify_rx, user_call_ID,
 					  gfp, debug_id);
 }
 EXPORT_SYMBOL(rxrpc_kernel_charge_accept);
diff --git a/net/rxrpc/rxperf.c b/net/rxrpc/rxperf.c
index e848a4777b8c..c76fbccfbb91 100644
--- a/net/rxrpc/rxperf.c
+++ b/net/rxrpc/rxperf.c
@@ -136,6 +136,12 @@ static void rxperf_notify_end_reply_tx(struct sock *sock,
 			      RXPERF_CALL_SV_AWAIT_ACK);
 }
 
+static const struct rxrpc_kernel_ops rxperf_rxrpc_callback_ops = {
+	.notify_new_call	= rxperf_rx_new_call,
+	.discard_new_call	= rxperf_rx_discard_new_call,
+	.user_attach_call	= rxperf_rx_attach,
+};
+
 /*
  * Charge the incoming call preallocation.
  */
@@ -161,7 +167,6 @@ static void rxperf_charge_preallocation(struct work_struct *work)
 
 		if (rxrpc_kernel_charge_accept(rxperf_socket,
 					       rxperf_notify_rx,
-					       rxperf_rx_attach,
 					       (unsigned long)call,
 					       GFP_KERNEL,
 					       call->debug_id) < 0)
@@ -209,8 +214,7 @@ static int rxperf_open_socket(void)
 	if (ret < 0)
 		goto error_2;
 
-	rxrpc_kernel_new_call_notification(socket, rxperf_rx_new_call,
-					   rxperf_rx_discard_new_call);
+	rxrpc_kernel_set_notifications(socket, &rxperf_rxrpc_callback_ops);
 
 	ret = kernel_listen(socket, INT_MAX);
 	if (ret < 0)


