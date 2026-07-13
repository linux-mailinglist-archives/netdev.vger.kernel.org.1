Return-Path: <netdev+bounces-307068-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id avPuA9meVGpLoQMAu9opvQ
	(envelope-from <netdev+bounces-307068-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:16:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA8D7488D9
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:16:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=HHdZwnP+;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307068-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307068-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A2337304D2F4
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E06F3B1016;
	Mon, 13 Jul 2026 08:11:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7E23A9015
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 08:11:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930276; cv=none; b=o52mLxo+t63nUroBhwIQV0wxK17q7LusFjtwdJfx8chmxjuSU078+laBb4S0JYB1C0T7K2sNawp9JDyRjDiSjZnZuc66E+R9ubLWCdr9eictZC70MpmyKEg6sjDLvsQCuQoSECkgVB7GmvJgd9jjU/YsDS689kwcCHb4NDDdIpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930276; c=relaxed/simple;
	bh=yIdV7gkMrothlRw1nIxJBgNaDFr9FexOqxBLQ13zHlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLsjURI+PLce4XhR1tegCdPnaC54/pgmz0/gbV0eHwNoBqkY8XbSk6R+aoe1xa6nrWW6BQ5aK7oR0KUDKXbKfGIyap4gF9sZAkrq9zzb9C663+3EvuJllxuIdWH/MNL+jPsrokSYPm7I3/J5856oFBDgrcE2J9ar9jNZvzvn10A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHdZwnP+; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783930273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HmaQ+z81XvDwrbaoGbipH/iozNJa7b0A3DkToai5LFE=;
	b=HHdZwnP+N5FRT/Tfy4YQINBFDZStyGGDA0EzWIvnsCUW55LQgHLckDm0+l0j0PQ48NOxxz
	k34thq+EvJfTNo6Wa37voHlQgQT0jEzHNklx/duODS8+tBhh4UuxIzYBkkM+z+VLHvWzSC
	3wFKDF3/siYdMOslrv+PxZk1aJ7GdA4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-_KaV8wsiNVuMIjTTuPGQhA-1; Mon,
 13 Jul 2026 04:11:10 -0400
X-MC-Unique: _KaV8wsiNVuMIjTTuPGQhA-1
X-Mimecast-MFC-AGG-ID: _KaV8wsiNVuMIjTTuPGQhA_1783930269
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EFA081955D91;
	Mon, 13 Jul 2026 08:11:08 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E0A5C18005A0;
	Mon, 13 Jul 2026 08:11:05 +0000 (UTC)
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
	Jeffrey Altman <jaltman@auristor.com>
Subject: [PATCH net v3 08/14] afs: Make afs_put_call() take trace argument
Date: Mon, 13 Jul 2026 09:10:14 +0100
Message-ID: <20260713081022.2186481-9-dhowells@redhat.com>
In-Reply-To: <20260713081022.2186481-1-dhowells@redhat.com>
References: <20260713081022.2186481-1-dhowells@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-307068-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dhowells@redhat.com,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:jaltman@auristor.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:email,davemloft.net:email,vger.kernel.org:from_smtp,auristor.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0EA8D7488D9

Make afs_put_call() take trace argument to display in the afs_call trace
line and stop showing the function return address (which isn't unique due
to inlining and tail-calling).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
---
 fs/afs/file.c              |  4 ++--
 fs/afs/fs_operation.c      |  2 +-
 fs/afs/fsclient.c          |  4 ++--
 fs/afs/internal.h          |  8 +++-----
 fs/afs/rxrpc.c             | 39 ++++++++++++++------------------------
 fs/afs/vl_probe.c          |  2 +-
 fs/afs/vlclient.c          |  8 ++++----
 include/trace/events/afs.h | 38 +++++++++++++++++++++----------------
 8 files changed, 49 insertions(+), 56 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 35d68f7f498d..625dc67f79f3 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -298,7 +298,7 @@ static void afs_read_receive(struct afs_call *call)
 	op->call_responded	= call->responded;
 	op->call		= NULL;
 	call->op		= NULL;
-	afs_put_call(call);
+	afs_put_call(call, afs_call_trace_put_read_op);
 
 	/* If the call failed, then we need to crank the server rotation
 	 * handle and try the next.
@@ -319,7 +319,7 @@ void afs_fetch_data_async_rx(struct work_struct *work)
 
 	if (call->state == AFS_CALL_COMPLETE) {
 		cancel_work(&call->async_work);
-		afs_put_call(call);
+		afs_put_call(call, afs_call_trace_put_read_complete);
 	}
 }
 
diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index 20801b29521d..b887047398b9 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -296,7 +296,7 @@ void afs_wait_for_operation(struct afs_operation *op)
 			op->call_abort_code = op->call->abort_code;
 			op->call_error = op->call->error;
 			op->call_responded = op->call->responded;
-			afs_put_call(op->call);
+			afs_put_call(op->call, afs_call_trace_put_wait_op);
 		}
 	}
 
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 626e1d37b915..9acad5017fba 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -1662,7 +1662,7 @@ int afs_fs_give_up_all_callbacks(struct afs_net *net, struct afs_server *server,
 	ret = call->error;
 	if (call->responded)
 		set_bit(AFS_SERVER_FL_RESPONDING, &server->flags);
-	afs_put_call(call);
+	afs_put_call(call, afs_call_trace_put_giveupcallbacks);
 	return ret;
 }
 
@@ -1778,7 +1778,7 @@ bool afs_fs_get_capabilities(struct afs_net *net, struct afs_server *server,
 
 	trace_afs_make_fs_call(call, NULL);
 	afs_make_call(call, GFP_NOFS);
-	afs_put_call(call);
+	afs_put_call(call, afs_call_trace_put_get_capabilities);
 	return true;
 }
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index e55363f1d5ab..4901d0acbe14 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1379,7 +1379,7 @@ extern struct workqueue_struct *afs_async_calls;
 extern int __net_init afs_open_socket(struct afs_net *);
 extern void __net_exit afs_close_socket(struct afs_net *);
 extern void afs_charge_preallocation(struct work_struct *);
-extern void afs_put_call(struct afs_call *);
+void afs_put_call(struct afs_call *call, enum afs_call_trace trace);
 void afs_make_call(struct afs_call *call, gfp_t gfp);
 void afs_deliver_to_call(struct afs_call *call);
 void afs_wait_for_call_to_complete(struct afs_call *call);
@@ -1400,8 +1400,7 @@ static inline struct afs_call *afs_get_call(struct afs_call *call,
 	__refcount_inc(&call->ref, &r);
 
 	trace_afs_call(call->debug_id, why, r + 1,
-		       atomic_read(&call->net->nr_outstanding_calls),
-		       __builtin_return_address(0));
+		       atomic_read(&call->net->nr_outstanding_calls));
 	return call;
 }
 
@@ -1410,8 +1409,7 @@ static inline void afs_see_call(struct afs_call *call, enum afs_call_trace why)
 	int r = refcount_read(&call->ref);
 
 	trace_afs_call(call->debug_id, why, r,
-		       atomic_read(&call->net->nr_outstanding_calls),
-		       __builtin_return_address(0));
+		       atomic_read(&call->net->nr_outstanding_calls));
 }
 
 static inline void afs_make_op_call(struct afs_operation *op, struct afs_call *call,
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index a404b6f0cc7c..a1b9ced4e0f4 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -138,7 +138,7 @@ void afs_close_socket(struct afs_net *net)
 	cancel_work_sync(&net->charge_preallocation_work);
 
 	if (net->spare_incoming_call) {
-		afs_put_call(net->spare_incoming_call);
+		afs_put_call(net->spare_incoming_call, afs_call_trace_put_spare_svc);
 		net->spare_incoming_call = NULL;
 	}
 
@@ -183,14 +183,14 @@ static struct afs_call *afs_alloc_call(struct afs_net *net,
 	call->iter = &call->def_iter;
 
 	o = atomic_inc_return(&net->nr_outstanding_calls);
-	trace_afs_call(call->debug_id, afs_call_trace_alloc, 1, o,
-		       __builtin_return_address(0));
+	trace_afs_call(call->debug_id, afs_call_trace_alloc, 1, o);
 	return call;
 }
 
 static void afs_free_call(struct afs_call *call)
 {
 	struct afs_net *net = call->net;
+	unsigned int debug_id = call->debug_id;
 	int o;
 
 	ASSERT(!work_pending(&call->async_work));
@@ -207,13 +207,10 @@ static void afs_free_call(struct afs_call *call)
 
 	afs_unuse_server_notime(call->net, call->server, afs_server_trace_unuse_call);
 	kfree(call->request);
-
-	o = atomic_read(&net->nr_outstanding_calls);
-	trace_afs_call(call->debug_id, afs_call_trace_free, 0, o,
-		       __builtin_return_address(0));
 	kfree(call);
 
 	o = atomic_dec_return(&net->nr_outstanding_calls);
+	trace_afs_call(debug_id, afs_call_trace_free, 0, o);
 	if (o == 0)
 		wake_up_var(&net->nr_outstanding_calls);
 }
@@ -221,7 +218,7 @@ static void afs_free_call(struct afs_call *call)
 /*
  * Dispose of a reference on a call.
  */
-void afs_put_call(struct afs_call *call)
+void afs_put_call(struct afs_call *call, enum afs_call_trace trace)
 {
 	struct afs_net *net = call->net;
 	unsigned int debug_id = call->debug_id;
@@ -230,8 +227,7 @@ void afs_put_call(struct afs_call *call)
 
 	zero = __refcount_dec_and_test(&call->ref, &r);
 	o = atomic_read(&net->nr_outstanding_calls);
-	trace_afs_call(debug_id, afs_call_trace_put, r - 1, o,
-		       __builtin_return_address(0));
+	trace_afs_call(debug_id, trace, r - 1, o);
 	if (zero)
 		afs_free_call(call);
 }
@@ -276,7 +272,7 @@ struct afs_call *afs_alloc_flat_call(struct afs_net *net,
 	return call;
 
 nomem_free:
-	afs_put_call(call);
+	afs_put_call(call, afs_call_trace_put_oom);
 nomem_call:
 	return NULL;
 }
@@ -344,7 +340,7 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 	 * the call to hold itself so the caller need not hang on to its ref.
 	 */
 	if (call->async)
-		afs_get_call(call, afs_call_trace_get);
+		afs_get_call(call, afs_call_trace_get_make_async_call);
 
 	/* create a call */
 	rxcall = rxrpc_kernel_begin_call(call->net->socket, call->peer, call->key,
@@ -418,7 +414,7 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 					RX_USER_ABORT, ret,
 					afs_abort_send_data_error);
 	if (call->async) {
-		afs_see_call(call, afs_call_trace_async_abort);
+		afs_see_call(call, afs_call_trace_see_async_abort);
 		return;
 	}
 
@@ -434,7 +430,7 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 	trace_afs_call_done(call);
 error_kill_call:
 	if (call->async)
-		afs_see_call(call, afs_call_trace_async_kill);
+		afs_see_call(call, afs_call_trace_see_async_kill);
 	if (call->type->immediate_cancel)
 		call->type->immediate_cancel(call);
 
@@ -675,11 +671,7 @@ static void afs_wake_up_async_call(struct sock *sk, struct rxrpc_call *rxcall,
 	trace_afs_notify_call(rxcall, call);
 	call->need_attention = true;
 
-	trace_afs_call(call->debug_id, afs_call_trace_wake,
-		       refcount_read(&call->ref),
-		       atomic_read(&call->net->nr_outstanding_calls),
-		       __builtin_return_address(0));
-
+	afs_see_call(call, afs_call_trace_see_async_wake);
 	queue_work(afs_async_calls, &call->async_work);
 }
 
@@ -693,10 +685,7 @@ static void afs_process_async_call(struct work_struct *work)
 
 	_enter("");
 
-	trace_afs_call(call->debug_id, afs_call_trace_async_process,
-		       refcount_read(&call->ref),
-		       atomic_read(&call->net->nr_outstanding_calls),
-		       __builtin_return_address(0));
+	afs_see_call(call, afs_call_trace_see_async_process);
 
 	if (call->state < AFS_CALL_COMPLETE && call->need_attention) {
 		call->need_attention = false;
@@ -705,7 +694,7 @@ static void afs_process_async_call(struct work_struct *work)
 
 	if (call->state == AFS_CALL_COMPLETE) {
 		cancel_work(&call->async_work);
-		afs_put_call(call);
+		afs_put_call(call, afs_call_trace_put_async_complete);
 	}
 	_leave("");
 }
@@ -758,7 +747,7 @@ static void afs_rx_discard_new_call(struct rxrpc_call *rxcall,
 	struct afs_call *call = (struct afs_call *)user_call_ID;
 
 	call->rxcall = NULL;
-	afs_put_call(call);
+	afs_put_call(call, afs_call_trace_put_discard_prealloc);
 }
 
 /*
diff --git a/fs/afs/vl_probe.c b/fs/afs/vl_probe.c
index 3d2e0c925460..1d70887c9f31 100644
--- a/fs/afs/vl_probe.c
+++ b/fs/afs/vl_probe.c
@@ -186,7 +186,7 @@ static bool afs_do_probe_vlserver(struct afs_net *net,
 					       server_index);
 		if (!IS_ERR(call)) {
 			afs_prioritise_error(_e, call->error, call->abort_code);
-			afs_put_call(call);
+			afs_put_call(call, afs_call_trace_put_vl_get_caps);
 			in_progress = true;
 		} else {
 			afs_prioritise_error(_e, PTR_ERR(call), 0);
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index a40b43464cfa..8a4c8c9a1e39 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -153,7 +153,7 @@ struct afs_vldb_entry *afs_vl_get_entry_by_name_u(struct afs_vl_cursor *vc,
 	vc->call_abort_code	= call->abort_code;
 	vc->call_error		= call->error;
 	vc->call_responded	= call->responded;
-	afs_put_call(call);
+	afs_put_call(call, afs_call_trace_put_vl_call);
 	if (vc->call_error) {
 		kfree(entry);
 		return ERR_PTR(vc->call_error);
@@ -303,7 +303,7 @@ struct afs_addr_list *afs_vl_get_addrs_u(struct afs_vl_cursor *vc,
 	vc->call_error		= call->error;
 	vc->call_responded	= call->responded;
 	alist			= call->ret_alist;
-	afs_put_call(call);
+	afs_put_call(call, afs_call_trace_put_vl_call);
 	if (vc->call_error) {
 		afs_put_addrlist(alist, afs_alist_trace_put_getaddru);
 		return ERR_PTR(vc->call_error);
@@ -666,7 +666,7 @@ struct afs_addr_list *afs_yfsvl_get_endpoints(struct afs_vl_cursor *vc,
 	vc->call_error		= call->error;
 	vc->call_responded	= call->responded;
 	alist			= call->ret_alist;
-	afs_put_call(call);
+	afs_put_call(call, afs_call_trace_put_vl_call);
 	if (vc->call_error) {
 		afs_put_addrlist(alist, afs_alist_trace_put_getaddru);
 		return ERR_PTR(vc->call_error);
@@ -784,7 +784,7 @@ char *afs_yfsvl_get_cell_name(struct afs_vl_cursor *vc)
 	vc->call_error		= call->error;
 	vc->call_responded	= call->responded;
 	cellname		= call->ret_str;
-	afs_put_call(call);
+	afs_put_call(call, afs_call_trace_put_vl_call);
 	if (vc->call_error) {
 		kfree(cellname);
 		return ERR_PTR(vc->call_error);
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 4f18a2a5b9f6..df397c11df85 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -120,15 +120,24 @@ enum yfs_cm_operation {
  * Declare tracing information enums and their string mappings for display.
  */
 #define afs_call_traces \
-	EM(afs_call_trace_alloc,		"ALLOC") \
-	EM(afs_call_trace_async_abort,		"ASYAB") \
-	EM(afs_call_trace_async_kill,		"ASYKL") \
-	EM(afs_call_trace_async_process,	"ASYPR") \
-	EM(afs_call_trace_free,			"FREE ") \
-	EM(afs_call_trace_get,			"GET  ") \
-	EM(afs_call_trace_put,			"PUT  ") \
-	EM(afs_call_trace_wake,			"WAKE ") \
-	E_(afs_call_trace_work,			"QUEUE")
+	EM(afs_call_trace_alloc,		"ALLOC      ") \
+	EM(afs_call_trace_free,			"FREE       ") \
+	EM(afs_call_trace_get_make_async_call,	"GET a-make ") \
+	EM(afs_call_trace_put_async_complete,	"PUT a-cmpl ") \
+	EM(afs_call_trace_put_discard_prealloc,	"PUT dis-pre") \
+	EM(afs_call_trace_put_get_capabilities,	"PUT get-cap") \
+	EM(afs_call_trace_put_giveupcallbacks,	"PUT gvup-cb") \
+	EM(afs_call_trace_put_oom,		"PUT oom    ") \
+	EM(afs_call_trace_put_read_complete,	"PUT rd-cpl ") \
+	EM(afs_call_trace_put_read_op,		"PUT rd-op  ") \
+	EM(afs_call_trace_put_spare_svc,	"PUT spare-s") \
+	EM(afs_call_trace_put_vl_call,		"PUT vl-call") \
+	EM(afs_call_trace_put_vl_get_caps,	"PUT vl-gcap") \
+	EM(afs_call_trace_put_wait_op,		"PUT wt-op  ") \
+	EM(afs_call_trace_see_async_abort,	"SEE a-abort") \
+	EM(afs_call_trace_see_async_kill,	"SEE a-kill ") \
+	EM(afs_call_trace_see_async_process,	"SEE a-proc ") \
+	E_(afs_call_trace_see_async_wake,	"SEE a-wake ")
 
 #define afs_server_traces \
 	EM(afs_server_trace_callback,		"CALLBACK ") \
@@ -694,16 +703,15 @@ TRACE_EVENT(afs_cb_call,
 
 TRACE_EVENT(afs_call,
 	    TP_PROTO(unsigned int call_debug_id, enum afs_call_trace op,
-		     int ref, int outstanding, const void *where),
+		     int ref, int outstanding),
 
-	    TP_ARGS(call_debug_id, op, ref, outstanding, where),
+	    TP_ARGS(call_debug_id, op, ref, outstanding),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		call)
 		    __field(int,			op)
 		    __field(int,			ref)
 		    __field(int,			outstanding)
-		    __field(const void *,		where)
 			     ),
 
 	    TP_fast_assign(
@@ -711,15 +719,13 @@ TRACE_EVENT(afs_call,
 		    __entry->op = op;
 		    __entry->ref = ref;
 		    __entry->outstanding = outstanding;
-		    __entry->where = where;
 			   ),
 
-	    TP_printk("c=%08x %s r=%d o=%d sp=%pSR",
+	    TP_printk("c=%08x %s r=%d o=%d",
 		      __entry->call,
 		      __print_symbolic(__entry->op, afs_call_traces),
 		      __entry->ref,
-		      __entry->outstanding,
-		      __entry->where)
+		      __entry->outstanding)
 	    );
 
 TRACE_EVENT(afs_make_fs_call,


