Return-Path: <netdev+bounces-306674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CajmGR5HUWoLBwMAu9opvQ
	(envelope-from <netdev+bounces-306674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:25:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FE873DBC1
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:25:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=h3hXFgvC;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306674-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306674-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 983CE3037DF2
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F214038A718;
	Fri, 10 Jul 2026 19:23:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AE3389460
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 19:23:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711408; cv=none; b=qO3I2Zu4t3RGJQTVC7fqryvAryvYMSFY7CPnX4OESNCCOOH+NUpcYd0Ie1OAb3beU5UL9n9B9KEOlvl6JPgnv7tQ/Ea86IzhjRjoCtiFiXZe0yQTOBo3gzoKFgL5u2y1c7CvbQ+DJ9mrimzvO8chKJs2N9NIHmGcMYrudH5C93k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711408; c=relaxed/simple;
	bh=gdlc4cTKsfpnApGcWxOr96kyI4LLbh3N8WwfGfmvRXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRROuMOnMyHPEl6icCES7N5l7XxLK2Sp4dWdh9t2DxOYxjnSWEzkx3Hyyk5viQyWJcG3hpqJ85Up6TSXnGayLPPjd1lpBqZsFfKRZa8MAuJUV1jGUxA1swtvaZJbZ8IdigE855zgo9zVRFJUTJw+zVR6sSAGf0YxVZ9b0Sq2rwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h3hXFgvC; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783711406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBi1P2wshz3C9LXnRWdEC0uaWup4TYtpm13t36GvkBw=;
	b=h3hXFgvCyTzYMj4pLIdvGJAyXKQ6yn7fCuXuo7FWwCFlYURIS+T+Xjl9CjDUxD2mStJy8r
	SZ1iDHPBkzjeHnbQpMXycHG1VzOpTZ0sMagfDcr/5RYgEpQS/s8gRR/XfLiLSWCtPHaOZ6
	H07z8xPMPXyGaXmVkBtRp1P2YilKIjA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-5cVm5o4EM6exdw4T45DPww-1; Fri,
 10 Jul 2026 15:23:23 -0400
X-MC-Unique: 5cVm5o4EM6exdw4T45DPww-1
X-Mimecast-MFC-AGG-ID: 5cVm5o4EM6exdw4T45DPww_1783711401
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70DF01800750;
	Fri, 10 Jul 2026 19:23:21 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 29D81180057F;
	Fri, 10 Jul 2026 19:23:17 +0000 (UTC)
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
	stable@kernel.org
Subject: [PATCH net v2 11/16] afs: Fix UAF in afs_make_call()
Date: Fri, 10 Jul 2026 20:22:13 +0100
Message-ID: <20260710192220.1922433-12-dhowells@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306674-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dhowells@redhat.com,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:jaltman@auristor.com,m:stable@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,auristor.com:email,davemloft.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07FE873DBC1

There's a potential UAF in afs_make_call() in the event that an
asynchronous call is being sent, but the call fails in some way (e.g. it
gets aborted from the server).  The problem is that afs_make_call() tries
to abort a call if the rxrpc send fails, but the asynchronous notification
from rxrpc may have caused the afs_call to be torn down.

Fix this making afs_make_op_call() give the op->call its own ref rather
than transferring the caller's ref to it and then dropping the ref when
afs_make_call() returns.

This also means that the afs_make_call() func never loses its ref on the
call now.

Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" concept")
Link: https://sashiko.dev/#/patchset/20260702144919.172295-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
---
 fs/afs/internal.h          | 3 ++-
 fs/afs/rxrpc.c             | 3 ---
 include/trace/events/afs.h | 2 ++
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 7b68cf141bf9..47e2cae979b6 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1418,7 +1418,7 @@ static inline void afs_make_op_call(struct afs_operation *op, struct afs_call *c
 {
 	struct afs_addr_list *alist = op->estate->addresses;
 
-	op->call	= call;
+	op->call	= afs_get_call(call, afs_call_trace_get_op_call);
 	op->type	= call->type;
 	call->op	= op;
 	call->key	= op->key;
@@ -1426,6 +1426,7 @@ static inline void afs_make_op_call(struct afs_operation *op, struct afs_call *c
 	call->peer	= rxrpc_kernel_get_peer(alist->addrs[op->addr_index].peer);
 	call->service_id = op->server->service_id;
 	afs_make_call(call, gfp);
+	afs_put_call(call, afs_call_trace_put_made_call);
 }
 
 static inline void afs_extract_begin(struct afs_call *call, void *buf, size_t size)
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index a1b9ced4e0f4..6dc6fd853832 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -382,8 +382,6 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 	if (ret < 0)
 		goto error_do_abort;
 
-	/* We lost our ref on call if MSG_MORE was not set and ret >= 0. */
-
 	if (write_iter) {
 		msg.msg_iter = *call->write_iter;
 		msg.msg_flags &= ~MSG_MORE;
@@ -393,7 +391,6 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 					     call->rxcall, &msg,
 					     iov_iter_count(&msg.msg_iter),
 					     afs_notify_end_request_tx);
-		/* We lost our ref on call if ret >= 0. */
 
 		trace_afs_sent_data(debug_id, &msg, ret);
 		if (ret < 0)
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index df397c11df85..a1963e21f034 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -122,8 +122,10 @@ enum yfs_cm_operation {
 #define afs_call_traces \
 	EM(afs_call_trace_alloc,		"ALLOC      ") \
 	EM(afs_call_trace_free,			"FREE       ") \
+	EM(afs_call_trace_get_op_call,		"GET op     ") \
 	EM(afs_call_trace_get_make_async_call,	"GET a-make ") \
 	EM(afs_call_trace_put_async_complete,	"PUT a-cmpl ") \
+	EM(afs_call_trace_put_made_call,	"PUT made   ") \
 	EM(afs_call_trace_put_discard_prealloc,	"PUT dis-pre") \
 	EM(afs_call_trace_put_get_capabilities,	"PUT get-cap") \
 	EM(afs_call_trace_put_giveupcallbacks,	"PUT gvup-cb") \


