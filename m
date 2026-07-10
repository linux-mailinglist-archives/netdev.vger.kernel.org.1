Return-Path: <netdev+bounces-306673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mBdLNIhHUWolBwMAu9opvQ
	(envelope-from <netdev+bounces-306673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:27:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF0373DC0D
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:27:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=RTA3FtbK;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306673-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306673-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3C1E308C6F8
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7413838F258;
	Fri, 10 Jul 2026 19:23:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D2E2367DF
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 19:23:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711405; cv=none; b=AqWLIg557IFh9a+3cgME5xrJTv3Si3PdSZmET+5eJog463RBUJIfyPiRUl0Y19+Y/FPtsHrGOwDsr+sKlUBxYs9P3glGC7TGgwu2utDlaD/DdP7w4ddZeWRdZVPYckJu9RR/00WSeiiQKJK6bT3vtvS8iVYtK7+H2vFIkW7Cl7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711405; c=relaxed/simple;
	bh=mw5dhSDs18QGjOkAjAiB10G2RLvXP5he96UUoEXOoBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yw/44b2g5x2WlBpNLApuvsllxZA+dXnOm6eKMbABtDc+rDdB7r+kijZLUguyibjV6cfVEMvw2vXiuIXpkwZLF23A+vXDhUYnIfwpsZSrwUttag7xEvLL48qHq8SErX2cReOcB7O7SjLcVFEM7aM7abBU8pZ9l0Imd35bjursXro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RTA3FtbK; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783711397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tNeV1fHwSWF3hztMrEGHuhzcWS4kCbFCzxKWGJ0Okks=;
	b=RTA3FtbKDP4FixiDdW2sUdxQenYcE7pZG9Wrl3Tw4U90PXeVBTU3TzgvE9gQ2rty0ZjSew
	Sttp8snzb2UOS8C/RDZU+Yl6W9/efgaCLKwEMkYTlLWvE6ZjZ+7J0McTa00NsaqTpiJpnr
	ZB6tyoZdV8DO68LhZ4mrpWRKEhlMIZw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-Dnt0Am8tO8eXCyO-gGSCZQ-1; Fri,
 10 Jul 2026 15:23:13 -0400
X-MC-Unique: Dnt0Am8tO8eXCyO-gGSCZQ-1
X-Mimecast-MFC-AGG-ID: Dnt0Am8tO8eXCyO-gGSCZQ_1783711392
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 027491955F15;
	Fri, 10 Jul 2026 19:23:12 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E8631180067C;
	Fri, 10 Jul 2026 19:23:08 +0000 (UTC)
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
Subject: [PATCH net v2 09/16] afs: Simplify call refcounting
Date: Fri, 10 Jul 2026 20:22:11 +0100
Message-ID: <20260710192220.1922433-10-dhowells@redhat.com>
In-Reply-To: <20260710192220.1922433-1-dhowells@redhat.com>
References: <20260710192220.1922433-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306673-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dhowells@redhat.com,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:jaltman@auristor.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email,auristor.com:email,davemloft.net:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8AF0373DC0D

Simplify afs_call refcounting so that a queued work item doesn't hold a ref
on the call.  Rather, for async calls, put the retaining ref when the call
completes.  For synchronous calls, the caller of afs_make_call() holds its
own ref.  This means that queuing a call's async work doesn't require a ref
to be taken first on a call - and then there's no need to try and revert
the ref taken from the context of the rxrpc I/O thread if the call is
already queued.

Further, the AFS cache manager server RPC handler functions (SRXAFSCB_*)
are then called directly from afs_deliver_to_call() rather then being
dispatched to a different workqueue.  With that, call->work is changed to
a function pointer.

Also, there is no longer a need to keep an extra ref on an async call and
call->drop_ref can be removed.

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
 fs/afs/cmservice.c         | 33 ++++++------------
 fs/afs/file.c              | 10 +++---
 fs/afs/internal.h          | 18 ++--------
 fs/afs/rxrpc.c             | 69 +++++++++++---------------------------
 include/trace/events/afs.h |  1 +
 5 files changed, 39 insertions(+), 92 deletions(-)

diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index 3c12a0ecee8e..f92bddd4f1e9 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -23,11 +23,11 @@ static int afs_deliver_cb_callback(struct afs_call *);
 static int afs_deliver_cb_probe_uuid(struct afs_call *);
 static int afs_deliver_cb_tell_me_about_yourself(struct afs_call *);
 static void afs_cm_destructor(struct afs_call *);
-static void SRXAFSCB_CallBack(struct work_struct *);
-static void SRXAFSCB_InitCallBackState(struct work_struct *);
-static void SRXAFSCB_Probe(struct work_struct *);
-static void SRXAFSCB_ProbeUuid(struct work_struct *);
-static void SRXAFSCB_TellMeAboutYourself(struct work_struct *);
+static void SRXAFSCB_CallBack(struct afs_call *call);
+static void SRXAFSCB_InitCallBackState(struct afs_call *call);
+static void SRXAFSCB_Probe(struct afs_call *call);
+static void SRXAFSCB_ProbeUuid(struct afs_call *call);
+static void SRXAFSCB_TellMeAboutYourself(struct afs_call *call);
 
 static int afs_deliver_yfs_cb_callback(struct afs_call *);
 
@@ -161,10 +161,8 @@ static void afs_abort_service_call(struct afs_call *call, u32 abort_code, int er
 /*
  * The server supplied a list of callbacks that it wanted to break.
  */
-static void SRXAFSCB_CallBack(struct work_struct *work)
+static void SRXAFSCB_CallBack(struct afs_call *call)
 {
-	struct afs_call *call = container_of(work, struct afs_call, work);
-
 	_enter("");
 
 	/* We need to break the callbacks before sending the reply as the
@@ -180,7 +178,6 @@ static void SRXAFSCB_CallBack(struct work_struct *work)
 	}
 
 	afs_send_empty_reply(call);
-	afs_put_call(call);
 	_leave("");
 }
 
@@ -284,16 +281,13 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 /*
  * allow the fileserver to request callback state (re-)initialisation
  */
-static void SRXAFSCB_InitCallBackState(struct work_struct *work)
+static void SRXAFSCB_InitCallBackState(struct afs_call *call)
 {
-	struct afs_call *call = container_of(work, struct afs_call, work);
-
 	_enter("{%p}", call->server);
 
 	if (call->server)
 		afs_init_callback_state(call->server);
 	afs_send_empty_reply(call);
-	afs_put_call(call);
 	_leave("");
 }
 
@@ -374,13 +368,10 @@ static int afs_deliver_cb_init_call_back_state3(struct afs_call *call)
 /*
  * allow the fileserver to see if the cache manager is still alive
  */
-static void SRXAFSCB_Probe(struct work_struct *work)
+static void SRXAFSCB_Probe(struct afs_call *call)
 {
-	struct afs_call *call = container_of(work, struct afs_call, work);
-
 	_enter("");
 	afs_send_empty_reply(call);
-	afs_put_call(call);
 	_leave("");
 }
 
@@ -407,9 +398,8 @@ static int afs_deliver_cb_probe(struct afs_call *call)
  * Allow the fileserver to quickly find out if the cache manager has been
  * rebooted.
  */
-static void SRXAFSCB_ProbeUuid(struct work_struct *work)
+static void SRXAFSCB_ProbeUuid(struct afs_call *call)
 {
-	struct afs_call *call = container_of(work, struct afs_call, work);
 	struct afs_uuid *r = call->request;
 
 	_enter("");
@@ -419,7 +409,6 @@ static void SRXAFSCB_ProbeUuid(struct work_struct *work)
 	else
 		afs_abort_service_call(call, 1, 1, afs_abort_probeuuid_negative);
 
-	afs_put_call(call);
 	_leave("");
 }
 
@@ -481,9 +470,8 @@ static int afs_deliver_cb_probe_uuid(struct afs_call *call)
 /*
  * allow the fileserver to ask about the cache manager's capabilities
  */
-static void SRXAFSCB_TellMeAboutYourself(struct work_struct *work)
+static void SRXAFSCB_TellMeAboutYourself(struct afs_call *call)
 {
-	struct afs_call *call = container_of(work, struct afs_call, work);
 	int loop;
 
 	struct {
@@ -515,7 +503,6 @@ static void SRXAFSCB_TellMeAboutYourself(struct work_struct *work)
 	reply.cap.capcount = htonl(1);
 	reply.cap.caps[0] = htonl(AFS_CAP_ERROR_TRANSLATION);
 	afs_send_simple_reply(call, &reply, sizeof(reply));
-	afs_put_call(call);
 	_leave("");
 }
 
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 0467742bfeee..35d68f7f498d 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -316,15 +316,17 @@ void afs_fetch_data_async_rx(struct work_struct *work)
 	struct afs_call *call = container_of(work, struct afs_call, async_work);
 
 	afs_read_receive(call);
-	afs_put_call(call);
+
+	if (call->state == AFS_CALL_COMPLETE) {
+		cancel_work(&call->async_work);
+		afs_put_call(call);
+	}
 }
 
 void afs_fetch_data_immediate_cancel(struct afs_call *call)
 {
 	if (call->async) {
-		afs_get_call(call, afs_call_trace_wake);
-		if (!queue_work(afs_async_calls, &call->async_work))
-			afs_deferred_put_call(call);
+		queue_work(afs_async_calls, &call->async_work);
 		flush_work(&call->async_work);
 	}
 }
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 0b72a8566299..cd00956bc4cf 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -129,7 +129,7 @@ struct afs_call {
 	const struct afs_call_type *type;	/* type of call */
 	wait_queue_head_t	waitq;		/* processes awaiting completion */
 	struct work_struct	async_work;	/* async I/O processor */
-	struct work_struct	work;		/* actual work processor */
+	void (*work)(struct afs_call *call);	/* Worker function */
 	struct work_struct	free_work;	/* Deferred free processor */
 	struct rxrpc_call	*rxcall;	/* RxRPC call handle */
 	struct rxrpc_peer	*peer;		/* Remote endpoint */
@@ -169,7 +169,6 @@ struct afs_call {
 	unsigned		reply_max;	/* maximum size of reply */
 	unsigned		count2;		/* count used in unmarshalling */
 	unsigned char		unmarshall;	/* unmarshalling phase */
-	bool			drop_ref;	/* T if need to drop ref for incoming call */
 	bool			need_attention;	/* T if RxRPC poked us */
 	bool			async;		/* T if asynchronous */
 	bool			upgrade;	/* T to request service upgrade */
@@ -208,7 +207,7 @@ struct afs_call_type {
 	void (*async_rx)(struct work_struct *work);
 
 	/* Work function */
-	void (*work)(struct work_struct *work);
+	void (*work)(struct afs_call *call);
 
 	/* Call done function (gets called immediately on success or failure) */
 	void (*done)(struct afs_call *call);
@@ -1382,7 +1381,6 @@ extern int __net_init afs_open_socket(struct afs_net *);
 extern void __net_exit afs_close_socket(struct afs_net *);
 extern void afs_charge_preallocation(struct work_struct *);
 extern void afs_put_call(struct afs_call *);
-void afs_deferred_put_call(struct afs_call *call);
 void afs_make_call(struct afs_call *call, gfp_t gfp);
 void afs_deliver_to_call(struct afs_call *call);
 void afs_wait_for_call_to_complete(struct afs_call *call);
@@ -1495,7 +1493,6 @@ static inline void afs_set_call_complete(struct afs_call *call,
 					 int error, u32 remote_abort)
 {
 	enum afs_call_state state;
-	bool ok = false;
 
 	spin_lock_bh(&call->state_lock);
 	state = call->state;
@@ -1505,19 +1502,8 @@ static inline void afs_set_call_complete(struct afs_call *call,
 		call->state = AFS_CALL_COMPLETE;
 		trace_afs_call_state(call, state, AFS_CALL_COMPLETE,
 				     error, remote_abort);
-		ok = true;
 	}
 	spin_unlock_bh(&call->state_lock);
-	if (ok) {
-		trace_afs_call_done(call);
-
-		/* Asynchronous calls have two refs to release - one from the alloc and
-		 * one queued with the work item - and we can't just deallocate the
-		 * call because the work item may be queued again.
-		 */
-		if (call->drop_ref)
-			afs_put_call(call);
-	}
 }
 
 /*
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 06c711c75f55..a404b6f0cc7c 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -177,7 +177,6 @@ static struct afs_call *afs_alloc_call(struct afs_net *net,
 	call->debug_id = atomic_inc_return(&rxrpc_debug_id);
 	refcount_set(&call->ref, 1);
 	INIT_WORK(&call->async_work, type->async_rx ?: afs_process_async_call);
-	INIT_WORK(&call->work, call->type->work);
 	INIT_WORK(&call->free_work, afs_deferred_free_worker);
 	init_waitqueue_head(&call->waitq);
 	spin_lock_init(&call->state_lock);
@@ -244,37 +243,6 @@ static void afs_deferred_free_worker(struct work_struct *work)
 	afs_free_call(call);
 }
 
-/*
- * Dispose of a reference on a call, deferring the cleanup to a workqueue
- * to avoid lock recursion.
- */
-void afs_deferred_put_call(struct afs_call *call)
-{
-	struct afs_net *net = call->net;
-	unsigned int debug_id = call->debug_id;
-	bool zero;
-	int r, o;
-
-	zero = __refcount_dec_and_test(&call->ref, &r);
-	o = atomic_read(&net->nr_outstanding_calls);
-	trace_afs_call(debug_id, afs_call_trace_put, r - 1, o,
-		       __builtin_return_address(0));
-	if (zero)
-		schedule_work(&call->free_work);
-}
-
-/*
- * Queue the call for actual work.
- */
-static void afs_queue_call_work(struct afs_call *call)
-{
-	if (call->type->work) {
-		afs_get_call(call, afs_call_trace_work);
-		if (!queue_work(afs_wq, &call->work))
-			afs_put_call(call);
-	}
-}
-
 /*
  * allocate a call with flat request and reply buffers
  */
@@ -375,10 +343,8 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 	/* If the call is going to be asynchronous, we need an extra ref for
 	 * the call to hold itself so the caller need not hang on to its ref.
 	 */
-	if (call->async) {
+	if (call->async)
 		afs_get_call(call, afs_call_trace_get);
-		call->drop_ref = true;
-	}
 
 	/* create a call */
 	rxcall = rxrpc_kernel_begin_call(call->net->socket, call->peer, call->key,
@@ -479,8 +445,7 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 	if (call->rxcall)
 		rxrpc_kernel_shutdown_call(call->net->socket, call->rxcall);
 	if (call->async) {
-		if (cancel_work_sync(&call->async_work))
-			afs_put_call(call);
+		cancel_work_sync(&call->async_work);
 		afs_set_call_complete(call, ret, 0);
 	}
 
@@ -566,7 +531,8 @@ void afs_deliver_to_call(struct afs_call *call)
 		switch (ret) {
 		case 0:
 			call->responded = true;
-			afs_queue_call_work(call);
+			if (call->work)
+				call->work(call);
 			if (state == AFS_CALL_CL_PROC_REPLY) {
 				if (call->op)
 					set_bit(AFS_SERVER_FL_MAY_HAVE_CB,
@@ -616,6 +582,7 @@ void afs_deliver_to_call(struct afs_call *call)
 	}
 
 done:
+	trace_afs_call_done(call);
 	if (call->type->done)
 		call->type->done(call);
 out:
@@ -704,19 +671,16 @@ static void afs_wake_up_async_call(struct sock *sk, struct rxrpc_call *rxcall,
 				   unsigned long call_user_ID)
 {
 	struct afs_call *call = (struct afs_call *)call_user_ID;
-	int r;
 
 	trace_afs_notify_call(rxcall, call);
 	call->need_attention = true;
 
-	if (__refcount_inc_not_zero(&call->ref, &r)) {
-		trace_afs_call(call->debug_id, afs_call_trace_wake, r + 1,
-			       atomic_read(&call->net->nr_outstanding_calls),
-			       __builtin_return_address(0));
+	trace_afs_call(call->debug_id, afs_call_trace_wake,
+		       refcount_read(&call->ref),
+		       atomic_read(&call->net->nr_outstanding_calls),
+		       __builtin_return_address(0));
 
-		if (!queue_work(afs_async_calls, &call->async_work))
-			afs_deferred_put_call(call);
-	}
+	queue_work(afs_async_calls, &call->async_work);
 }
 
 /*
@@ -729,12 +693,20 @@ static void afs_process_async_call(struct work_struct *work)
 
 	_enter("");
 
+	trace_afs_call(call->debug_id, afs_call_trace_async_process,
+		       refcount_read(&call->ref),
+		       atomic_read(&call->net->nr_outstanding_calls),
+		       __builtin_return_address(0));
+
 	if (call->state < AFS_CALL_COMPLETE && call->need_attention) {
 		call->need_attention = false;
 		afs_deliver_to_call(call);
 	}
 
-	afs_put_call(call);
+	if (call->state == AFS_CALL_COMPLETE) {
+		cancel_work(&call->async_work);
+		afs_put_call(call);
+	}
 	_leave("");
 }
 
@@ -760,7 +732,6 @@ void afs_charge_preallocation(struct work_struct *work)
 			if (!call)
 				break;
 
-			call->drop_ref = true;
 			call->async = true;
 			call->state = AFS_CALL_SV_AWAIT_OP_ID;
 			init_waitqueue_head(&call->waitq);
@@ -836,7 +807,7 @@ static int afs_deliver_cm_op_id(struct afs_call *call)
 							     &call->enctype);
 
 	trace_afs_cb_call(call);
-	call->work.func = call->type->work;
+	call->work = call->type->work;
 
 	/* pass responsibility for the remainder of this message off to the
 	 * cache manager op */
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index cf7218efb861..4f18a2a5b9f6 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -123,6 +123,7 @@ enum yfs_cm_operation {
 	EM(afs_call_trace_alloc,		"ALLOC") \
 	EM(afs_call_trace_async_abort,		"ASYAB") \
 	EM(afs_call_trace_async_kill,		"ASYKL") \
+	EM(afs_call_trace_async_process,	"ASYPR") \
 	EM(afs_call_trace_free,			"FREE ") \
 	EM(afs_call_trace_get,			"GET  ") \
 	EM(afs_call_trace_put,			"PUT  ") \


