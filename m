Return-Path: <netdev+bounces-306679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IXugLrpHUWowBwMAu9opvQ
	(envelope-from <netdev+bounces-306679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:27:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A0773DC1E
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:27:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=ga0wSEjC;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306679-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306679-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F319A3003611
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5828337F73C;
	Fri, 10 Jul 2026 19:24:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6532337B409
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 19:24:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711492; cv=none; b=UAoBrAkyzyJy40LNbGcjAMI6m2Z0zX+B5e+40Z0fC5b3A5jAAR80FNKTMBvFA4Gory5L2JmWceDChjtN+2Zak5xF5ApHWLBbo8mXEvj+NBF9tUjg8023f36O+XxTZ0TXpb1iE4zVcvyrfU7MZ2LmCVYro1hNgT8QVux+aeEF1LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711492; c=relaxed/simple;
	bh=IhBWH75vXntx/ZkKPo+HOmWb/gIuko7Fh9fzuNFfVJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjbgteNtdu9lsTSwQIDOMEdee3e9r4m2lXyS1khBLhznaQEOjD+CW56vzTixAKd1g5rvco+NaY5e8MlBhxZfuPPkI3jizxpuyb5ZfYCbeukFBBbiKtegwI6q4PpLCb/moyBXLGikGbyHgiUWaHvPG0rs4dpcchKqQoxDf2tQtM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ga0wSEjC; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783711489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xgJ5MeF8m/MnV7sJ9zze4soezhzCc1rKO72g0pxKlsw=;
	b=ga0wSEjC6pWkZ2NV9jPlVqiTvsXvNlgRXKyWDUTfFbY7mBBAuWt3mUcawXnW987Dz6aMh7
	ajE7FH4O4ZK5Gy+MKOetxZn8q23BYEv6haJnf/kEFLfzKdR8uQUOuyCRd/97evcbEVnEt9
	eZqqzEOfLYPvj9jr9FfE2WxgC60iZkA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-AhplN7BpM-SALNmI8x3czw-1; Fri,
 10 Jul 2026 15:23:39 -0400
X-MC-Unique: AhplN7BpM-SALNmI8x3czw-1
X-Mimecast-MFC-AGG-ID: AhplN7BpM-SALNmI8x3czw_1783711417
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BE15180025F;
	Fri, 10 Jul 2026 19:23:37 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D77231800594;
	Fri, 10 Jul 2026 19:23:33 +0000 (UTC)
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
	Jeffrey Altman <jaltman@auristor.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	stable@kernel.org
Subject: [PATCH net v2 14/16] rxrpc: Pass appdata key to rxrpc_call and thence to rxrpc_bundle
Date: Fri, 10 Jul 2026 20:22:16 +0100
Message-ID: <20260710192220.1922433-15-dhowells@redhat.com>
In-Reply-To: <20260710192220.1922433-1-dhowells@redhat.com>
References: <20260710192220.1922433-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306679-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dhowells@redhat.com,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:jaltman@auristor.com,m:jarkko@kernel.org,m:keyrings@vger.kernel.org,m:stable@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 41A0773DC1E

Currently, when a CHALLENGE packet comes in, it's queued in an OOB queue on
the AF_RXRPC socket that generated one of the calls on that connection for
the application (which might be in userspace) to service.  The application
then picks up the CHALLENGE and requests a RESPONSE packet be generated,
allowing the app to include app-specific data in it if appropriate.  There
is, however, no actual limit on the capacity of the CHALLENGE queue, and
this could be abused remotely - and also getting the OOB mechanism right
has proven tricky.

Further, by analogy with other AFS codebases, it's not actually necessary
to generate the application data in response to the CHALLENGE.  The reason
I did this was to set the encryption on the app-data to be the same as that
specified in the CHALLENGE as the server must be able to handle that.
However, it's sufficient to use the encoding type set in the token that is
going to be sent to the server; presumably the kerberos server knows that
the fileserver can handle that type - otherwise why tell the client to use
it?

This is a part of the fix.  With this, the appdata key created by the AFS
filesystem or passed in via sendmsg CMSG to a user AF_RXRPC socket is added
to an rxrpc_call struct and will then be added to an rxrpc_bundle struct.

Note that afs_make_op_call() has to be moved so that it can call
afs_use_server().  afs_operation-based calls did not heretofore 'use' the
server and server will be 'un-used' by afs_free_call().

Fixes: 5800b1cf3fd8 ("rxrpc: Allow CHALLENGEs to the passed to the app for a RESPONSE")
Link: https://sashiko.dev/#/patchset/20260624163819.3017002-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: Jarkko Sakkinen <jarkko@kernel.org>
cc: linux-afs@lists.infradead.org
cc: keyrings@vger.kernel.org
cc: stable@kernel.org
---
 fs/afs/internal.h          | 33 +++++++++++++++++----------------
 fs/afs/rxrpc.c             | 21 ++++++++++++++++++++-
 include/net/af_rxrpc.h     |  1 +
 include/trace/events/afs.h |  1 +
 include/uapi/linux/rxrpc.h |  1 +
 net/rxrpc/af_rxrpc.c       |  3 +++
 net/rxrpc/ar-internal.h    |  3 +++
 net/rxrpc/call_object.c    |  2 ++
 net/rxrpc/conn_client.c    |  2 ++
 net/rxrpc/sendmsg.c        | 25 ++++++++++++++++++++++++-
 10 files changed, 74 insertions(+), 18 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 738d529ec97b..228c7012013d 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1415,22 +1415,6 @@ static inline void afs_see_call(struct afs_call *call, enum afs_call_trace why)
 		       atomic_read(&call->net->nr_outstanding_calls));
 }
 
-static inline void afs_make_op_call(struct afs_operation *op, struct afs_call *call,
-				    gfp_t gfp)
-{
-	struct afs_addr_list *alist = op->estate->addresses;
-
-	op->call	= afs_get_call(call, afs_call_trace_get_op_call);
-	op->type	= call->type;
-	call->op	= op;
-	call->key	= op->key;
-	call->intr	= !(op->flags & AFS_OPERATION_UNINTR);
-	call->peer	= rxrpc_kernel_get_peer(alist->addrs[op->addr_index].peer);
-	call->service_id = op->server->service_id;
-	afs_make_call(call, gfp);
-	afs_put_call(call, afs_call_trace_put_made_call);
-}
-
 static inline void afs_extract_begin(struct afs_call *call, void *buf, size_t size)
 {
 	call->iov_len = size;
@@ -1750,6 +1734,23 @@ static inline struct inode *AFS_VNODE_TO_I(struct afs_vnode *vnode)
 	return &vnode->netfs.inode;
 }
 
+static inline void afs_make_op_call(struct afs_operation *op, struct afs_call *call,
+				    gfp_t gfp)
+{
+	struct afs_addr_list *alist = op->estate->addresses;
+
+	op->call	= afs_get_call(call, afs_call_trace_get_op_call);
+	op->type	= call->type;
+	call->op	= op;
+	call->server	= afs_use_server(op->server, false, afs_server_trace_use_call);
+	call->key	= op->key;
+	call->intr	= !(op->flags & AFS_OPERATION_UNINTR);
+	call->peer	= rxrpc_kernel_get_peer(alist->addrs[op->addr_index].peer);
+	call->service_id = op->server->service_id;
+	afs_make_call(call, gfp);
+	afs_put_call(call, afs_call_trace_put_made_call);
+}
+
 /*
  * Note that a dentry got changed.  We need to set d_fsdata to the data version
  * number derived from the result of the operation.  It doesn't matter if
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 6dc6fd853832..1a110448dbdb 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -312,6 +312,7 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 	struct msghdr msg;
 	struct kvec iov[1];
 	unsigned int debug_id = call->debug_id;
+	struct key *app_data = NULL;
 	size_t len;
 	bool write_iter = call->write_iter;
 	s64 tx_total_len;
@@ -342,8 +343,26 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 	if (call->async)
 		afs_get_call(call, afs_call_trace_get_make_async_call);
 
+	if (call->key && call->server) {
+		u32 krb5_enctype = 0;
+		u8 security_index = 0;
+
+		rxrpc_kernel_query_key(call->key, &security_index, &krb5_enctype);
+		switch (security_index) {
+#ifdef CONFIG_RXGK
+		case RXRPC_SECURITY_YFS_RXGK:
+			/* Read the key pointer before the appdata */
+			app_data = smp_load_acquire(&call->server->yfs_rxgk_appdata);
+			break;
+#endif
+		default:
+			break;
+		}
+	}
+
 	/* create a call */
-	rxcall = rxrpc_kernel_begin_call(call->net->socket, call->peer, call->key,
+	rxcall = rxrpc_kernel_begin_call(call->net->socket, call->peer,
+					 call->key, app_data,
 					 (unsigned long)call,
 					 tx_total_len,
 					 call->max_lifespan,
diff --git a/include/net/af_rxrpc.h b/include/net/af_rxrpc.h
index c4b68049c06f..19c61a2f5af3 100644
--- a/include/net/af_rxrpc.h
+++ b/include/net/af_rxrpc.h
@@ -55,6 +55,7 @@ void rxrpc_kernel_set_notifications(struct socket *sock,
 struct rxrpc_call *rxrpc_kernel_begin_call(struct socket *sock,
 					   struct rxrpc_peer *peer,
 					   struct key *key,
+					   struct key *app_data,
 					   unsigned long user_call_ID,
 					   s64 tx_total_len,
 					   u32 hard_timeout,
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index a1963e21f034..a4f57414d527 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -160,6 +160,7 @@ enum yfs_cm_operation {
 	EM(afs_server_trace_unuse_slist_isort,	"UNU isort") \
 	EM(afs_server_trace_update,		"UPDATE   ") \
 	EM(afs_server_trace_use_by_uuid,	"USE uuid ") \
+	EM(afs_server_trace_use_call,		"USE call ") \
 	EM(afs_server_trace_use_cm_call,	"USE cm-cl") \
 	EM(afs_server_trace_use_get_caps,	"USE gcaps") \
 	EM(afs_server_trace_use_give_up_cb,	"USE gvupc") \
diff --git a/include/uapi/linux/rxrpc.h b/include/uapi/linux/rxrpc.h
index d9735abd4c79..bcdfdf9c67a1 100644
--- a/include/uapi/linux/rxrpc.h
+++ b/include/uapi/linux/rxrpc.h
@@ -63,6 +63,7 @@ enum rxrpc_cmsg_type {
 	RXRPC_RESPOND		= 17,	/* Cs-: Respond to a challenge */
 	RXRPC_RESPONDED		= 18,	/* S-r: Data received in RESPONSE */
 	RXRPC_RESP_RXGK_APPDATA	= 19,	/* Cs-: RESPONSE: RxGK app data to include */
+	RXRPC_RESPONSE_APPDATA	= 20,	/* Cs-: User key holding app data for RESPONSE */
 	RXRPC__SUPPORTED
 };
 
diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 9ab0f22c881e..a19c0fd3c51a 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -318,6 +318,7 @@ EXPORT_SYMBOL(rxrpc_kernel_put_peer);
  * @sock: The socket on which to make the call
  * @peer: The peer to contact
  * @key: The security context to use (defaults to socket setting)
+ * @app_data: The security response application data (or NULL)
  * @user_call_ID: The ID to use
  * @tx_total_len: Total length of data to transmit during the call (or -1)
  * @hard_timeout: The maximum lifespan of the call in sec
@@ -340,6 +341,7 @@ EXPORT_SYMBOL(rxrpc_kernel_put_peer);
 struct rxrpc_call *rxrpc_kernel_begin_call(struct socket *sock,
 					   struct rxrpc_peer *peer,
 					   struct key *key,
+					   struct key *app_data,
 					   unsigned long user_call_ID,
 					   s64 tx_total_len,
 					   u32 hard_timeout,
@@ -368,6 +370,7 @@ struct rxrpc_call *rxrpc_kernel_begin_call(struct socket *sock,
 		key = NULL; /* a no-security key */
 
 	memset(&p, 0, sizeof(p));
+	p.app_data		= app_data;
 	p.user_call_ID		= user_call_ID;
 	p.tx_total_len		= tx_total_len;
 	p.interruptibility	= interruptibility;
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index b6e7e8c5e96f..20c10428a50e 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -516,6 +516,7 @@ struct rxrpc_bundle {
 	struct rxrpc_local	*local;		/* Representation of local endpoint */
 	struct rxrpc_peer	*peer;		/* Remote endpoint */
 	struct key		*key;		/* Security details */
+	struct key		*app_data;	/* Security response app data */
 	struct list_head	proc_link;	/* Link in net->bundle_proc_list */
 	const struct rxrpc_security *security;	/* applied security module */
 	refcount_t		ref;
@@ -720,6 +721,7 @@ struct rxrpc_call {
 	struct rxrpc_sock __rcu	*socket;	/* socket responsible */
 	struct rxrpc_net	*rxnet;		/* Network namespace to which call belongs */
 	struct key		*key;		/* Security details */
+	struct key		*app_data;	/* Security response app data */
 	const struct rxrpc_security *security;	/* applied security module */
 	struct mutex		user_mutex;	/* User access mutex */
 	struct sockaddr_rxrpc	dest_srx;	/* Destination address */
@@ -914,6 +916,7 @@ enum rxrpc_command {
 };
 
 struct rxrpc_call_params {
+	struct key		*app_data;	/* Security response app data */
 	s64			tx_total_len;	/* Total Tx data length (if send data) */
 	unsigned long		user_call_ID;	/* User's call ID */
 	struct {
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 817ed9acb91e..9f6130d90c4c 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -211,6 +211,7 @@ static struct rxrpc_call *rxrpc_alloc_client_call(struct rxrpc_sock *rx,
 	call->interruptibility	= p->interruptibility;
 	call->tx_total_len	= p->tx_total_len;
 	call->key		= key_get(cp->key);
+	call->app_data		= key_get(p->app_data);
 	call->peer		= rxrpc_get_peer(cp->peer, rxrpc_peer_get_call);
 	call->local		= rxrpc_get_local(cp->local, rxrpc_local_get_call);
 	call->security_level	= cp->security_level;
@@ -697,6 +698,7 @@ static void rxrpc_destroy_call(struct work_struct *work)
 	rxrpc_put_peer(call->peer, rxrpc_peer_put_call);
 	rxrpc_put_local(call->local, rxrpc_local_put_call);
 	key_put(call->key);
+	key_put(call->app_data);
 	call_rcu(&call->rcu, rxrpc_rcu_free_call);
 }
 
diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index 48519f0de185..5cbfa7b223e0 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -81,6 +81,7 @@ static struct rxrpc_bundle *rxrpc_alloc_bundle(struct rxrpc_call *call,
 		bundle->local		= call->local;
 		bundle->peer		= rxrpc_get_peer(call->peer, rxrpc_peer_get_bundle);
 		bundle->key		= key_get(call->key);
+		bundle->app_data	= key_get(call->app_data);
 		bundle->security	= call->security;
 		bundle->exclusive	= test_bit(RXRPC_CALL_EXCLUSIVE, &call->flags);
 		bundle->upgrade		= test_bit(RXRPC_CALL_UPGRADE, &call->flags);
@@ -118,6 +119,7 @@ static void rxrpc_free_bundle(struct rxrpc_bundle *bundle)
 	write_unlock(&bundle->local->rxnet->conn_lock);
 	rxrpc_put_peer(bundle->peer, rxrpc_peer_put_bundle);
 	key_put(bundle->key);
+	key_put(bundle->app_data);
 	kfree(bundle);
 }
 
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 71343998b87d..cdf35440317d 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -12,6 +12,7 @@
 #include <linux/skbuff.h>
 #include <linux/export.h>
 #include <linux/sched/signal.h>
+#include <keys/user-type.h>
 
 #include <net/sock.h>
 #include <net/af_rxrpc.h>
@@ -530,6 +531,8 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 static int rxrpc_sendmsg_cmsg(struct msghdr *msg, struct rxrpc_send_params *p)
 {
 	struct cmsghdr *cmsg;
+	key_serial_t key_id;
+	key_ref_t key;
 	bool got_user_ID = false;
 	int len;
 
@@ -614,6 +617,22 @@ static int rxrpc_sendmsg_cmsg(struct msghdr *msg, struct rxrpc_send_params *p)
 				return -ERANGE;
 			break;
 
+		case RXRPC_RESPONSE_APPDATA:
+			if (len != sizeof(key_serial_t))
+				return -EINVAL;
+			if (p->call.app_data)
+				return -EINVAL;
+			key_id = *(key_serial_t *)CMSG_DATA(cmsg);
+			key = lookup_user_key(key_id, 0, KEY_NEED_SEARCH);
+			if (IS_ERR(key))
+				return PTR_ERR(key);
+			if (key_ref_to_ptr(key)->type == &key_type_user) {
+				key_ref_put(key);
+				return -EINVAL;
+			}
+			p->call.app_data = key_ref_to_ptr(key);
+			break;
+
 		default:
 			return -EINVAL;
 		}
@@ -722,8 +741,10 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
 			goto error_release_sock;
 		call = rxrpc_new_client_call_for_sendmsg(rx, msg, &p);
 		/* The socket is now unlocked... */
-		if (IS_ERR(call))
+		if (IS_ERR(call)) {
+			key_put(p.call.app_data);
 			return PTR_ERR(call);
+		}
 		/* ... and we have the call lock. */
 		p.call.nr_timeouts = 0;
 		ret = 0;
@@ -808,11 +829,13 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
 		mutex_unlock(&call->user_mutex);
 error_put:
 	rxrpc_put_call(call, rxrpc_call_put_sendmsg);
+	key_put(p.call.app_data);
 	_leave(" = %d", ret);
 	return ret;
 
 error_release_sock:
 	release_sock(&rx->sk);
+	key_put(p.call.app_data);
 	return ret;
 }
 


