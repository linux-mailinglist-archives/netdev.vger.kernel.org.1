Return-Path: <netdev+bounces-307063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e/34NLieVGpDoQMAu9opvQ
	(envelope-from <netdev+bounces-307063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:15:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 546367488D3
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:15:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=CyobyZc3;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307063-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307063-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93E5930465FF
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DC136897C;
	Mon, 13 Jul 2026 08:10:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257793A544B
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 08:10:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930251; cv=none; b=tM6ZP3EmFHsF7GciSm0fyst5+dFk4crzc8ysr4rLlkNabaFiAbyj4ZYpg8jPIC78WGZGCtpAboKze2rfQDM1hPisJEhpMIn7DYfRiq2877SFn8+CHxzJaXYgSnhNbGWB8R6oRckpndgMzexOkWyYYsmkfT0l7VnLJjowcb3M6ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930251; c=relaxed/simple;
	bh=E5WS46j5a8G17EdBUcF4rWwBW8nW3IbIBrOVF96DvQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8I+tNgt16bCiW6pZhzto2xIEDkXLqOBlzoTFS2pgInySWZRwvzlnf5RGOAHGSdwR3CN4HBORezF9HAYiry97JDFqG6jDEeyNkS9jLQFcqdb1UA0owFLsFx5hUCY4zMOQqDehdXYQu/5Oi9U1dqVj1O4tg1zwUYhS1qLDvIJqeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CyobyZc3; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783930243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SgpV4kjwvH55LZvzMLmX7XWaBZ5UY8VXhuMtFgykJ6U=;
	b=CyobyZc3VEdkokRhNVgvZsfVcEivh+cxzPCY+rIgdXC3HEx8rcLMfX1Xp4YTSNCFD2eSXc
	3eoaYz4zelKwdiZIGSv+NOURoID/n1d8vG2I4MiwSfZmY8/8qrSIV9tuk9v1WWTsQU13q/
	8YPEC065TG81qfRWcpXGksmHY2yIDic=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-dp_kmYWCOqKMYhXkwz-ECg-1; Mon,
 13 Jul 2026 04:10:41 -0400
X-MC-Unique: dp_kmYWCOqKMYhXkwz-ECg-1
X-Mimecast-MFC-AGG-ID: dp_kmYWCOqKMYhXkwz-ECg_1783930240
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 114BA1805A0E;
	Mon, 13 Jul 2026 08:10:40 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9B8EF1800348;
	Mon, 13 Jul 2026 08:10:36 +0000 (UTC)
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
Subject: [PATCH net v3 02/14] afs: Fix UAF when sending a message
Date: Mon, 13 Jul 2026 09:10:08 +0100
Message-ID: <20260713081022.2186481-3-dhowells@redhat.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307063-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,davemloft.net:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 546367488D3

In afs_make_call(), there's a race with async call reception and
destruction.  If a call is dispatched that doesn't have call->write_iter
set (used to specify the data content for FS.StoreData), then the first
rxrpc_kernel_send_data() will not set MSG_MORE in the msghdr.

Once rxrpc_send_data() queues the last request packet, the response could
come in at any time and cause the call to be completed and put.  However,
afs_make_call() will look at the call again to see it ->write_iter should
be handled - something it's only allowed to do if it has its own ref on the
call.  Whilst this is the case for synchronous calls, it isn't true for
async calls such as FS.FetchData.

generic/650 plays games with randomly taking CPUs offline, and can
interject a significant delay such that the call is deallocated before
afs_make_call() gets to check call->write_iter - and a UAF ensues (caught
by KASAN).

   BUG: KASAN: slab-use-after-free in afs_make_call+0x1c90/0x2210 [kafs]
   Read of size 8 at addr ffff888035e050e8 by task fsstress/1409

Fix this by caching the call->write_iter and call->debug_id so that neither
variable needs to be accessed after the first send.

Fixes: eddf51f2bb2c ("afs: Make {Y,}FS.FetchData an asynchronous operation")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
---
 fs/afs/rxrpc.c             | 12 ++++++++----
 include/trace/events/afs.h |  6 +++---
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index d82916657a3d..06c711c75f55 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -347,7 +347,9 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 	struct rxrpc_call *rxcall;
 	struct msghdr msg;
 	struct kvec iov[1];
+	unsigned int debug_id = call->debug_id;
 	size_t len;
+	bool write_iter = call->write_iter;
 	s64 tx_total_len;
 	int ret;
 
@@ -410,7 +412,7 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, iov, 1, call->request_size);
 	msg.msg_control		= NULL;
 	msg.msg_controllen	= 0;
-	msg.msg_flags		= MSG_WAITALL | (call->write_iter ? MSG_MORE : 0);
+	msg.msg_flags		= MSG_WAITALL | (write_iter ? MSG_MORE : 0);
 
 	ret = rxrpc_kernel_send_data(call->net->socket, rxcall,
 				     &msg, call->request_size,
@@ -418,7 +420,9 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 	if (ret < 0)
 		goto error_do_abort;
 
-	if (call->write_iter) {
+	/* We lost our ref on call if MSG_MORE was not set and ret >= 0. */
+
+	if (write_iter) {
 		msg.msg_iter = *call->write_iter;
 		msg.msg_flags &= ~MSG_MORE;
 		trace_afs_send_data(call, &msg);
@@ -427,9 +431,9 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 					     call->rxcall, &msg,
 					     iov_iter_count(&msg.msg_iter),
 					     afs_notify_end_request_tx);
-		*call->write_iter = msg.msg_iter;
+		/* We lost our ref on call if ret >= 0. */
 
-		trace_afs_sent_data(call, &msg, ret);
+		trace_afs_sent_data(debug_id, &msg, ret);
 		if (ret < 0)
 			goto error_do_abort;
 	}
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 1b3c48b5591d..cf7218efb861 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -937,9 +937,9 @@ TRACE_EVENT(afs_send_data,
 	    );
 
 TRACE_EVENT(afs_sent_data,
-	    TP_PROTO(struct afs_call *call, struct msghdr *msg, int ret),
+	    TP_PROTO(unsigned int call_debug_id, struct msghdr *msg, int ret),
 
-	    TP_ARGS(call, msg, ret),
+	    TP_ARGS(call_debug_id, msg, ret),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		call)
@@ -949,7 +949,7 @@ TRACE_EVENT(afs_sent_data,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call->debug_id;
+		    __entry->call = call_debug_id;
 		    __entry->ret = ret;
 		    __entry->offset = msg->msg_iter.xarray_start + msg->msg_iter.iov_offset;
 		    __entry->count = iov_iter_count(&msg->msg_iter);


