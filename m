Return-Path: <netdev+bounces-181570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16324A85882
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 11:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A863A171328
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 09:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB2529DB62;
	Fri, 11 Apr 2025 09:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKcBQPUF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F4829CB57
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 09:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365255; cv=none; b=PaVYacLuvnjTio7PqpSO26+xxUmmEpUotqZAQg+t/g7iIkXsPw72wMi9jYB3qjLEMPHLVRuYeaDhVm+u87zHKbr19svVyHwjDa4Z1QoqUZUoSEcqO5OLS391Txh70S/5mLaOWOeW2cOKM6aII7AcJmf9CN41O3QCs+3BjwEqiIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365255; c=relaxed/simple;
	bh=VbHlyrodeh9rkBQkgj5e5Y/i2l4UeZm/KVcmOu8WjoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnqI/Ei2MocsjzHDRxwhhfFp3kFzp00xnveb0Wyoha5b1dvsBcRhUkmnBFnmMM8HrfzkKx2HtuSl7gtScHrxfJhd878zYLh/cb7IokDJr3YYI9h5HwHevsh0xnm0HJ6vLZTHRnTPgZWPxPuRCDvtZvdVcyWkPqps5cWhYwMcxG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MKcBQPUF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744365253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JmaYtOticYN7j3yre1hB8WIypazLSmL5bWqmGmX0yrY=;
	b=MKcBQPUFi1DurXWr7QxF20xWSy80FJ6ajp0qgLBBehIXvGlQ6+2dYXela7SZr6MlGWpeqY
	3K9d1nQwLKxL+VHwA1qYNbSgV5AFtmA4AMxVadbRn+w12y9dwEwu/c8vcmMrKHdGdbHIDQ
	qiKj0/gtUyo/PlD+16xT3pMAk3DLCLg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-Bdcku-1pMsuE4SO0-VfQng-1; Fri,
 11 Apr 2025 05:54:09 -0400
X-MC-Unique: Bdcku-1pMsuE4SO0-VfQng-1
X-Mimecast-MFC-AGG-ID: Bdcku-1pMsuE4SO0-VfQng_1744365248
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 325F11956053;
	Fri, 11 Apr 2025 09:54:08 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.40])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 25FDC1955DCE;
	Fri, 11 Apr 2025 09:54:04 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 11/14] rxrpc: Display security params in the afs_cb_call tracepoint
Date: Fri, 11 Apr 2025 10:52:56 +0100
Message-ID: <20250411095303.2316168-12-dhowells@redhat.com>
In-Reply-To: <20250411095303.2316168-1-dhowells@redhat.com>
References: <20250411095303.2316168-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Make the afs_cb_call tracepoint display some security parameters to make
debugging easier.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 Documentation/networking/rxrpc.rst |  1 +
 fs/afs/internal.h                  |  2 ++
 fs/afs/rxrpc.c                     |  4 ++++
 include/net/af_rxrpc.h             |  2 ++
 include/trace/events/afs.h         | 11 +++++++++--
 net/rxrpc/ar-internal.h            |  1 +
 net/rxrpc/call_object.c            | 20 ++++++++++++++++++++
 net/rxrpc/rxgk.c                   |  2 ++
 8 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/rxrpc.rst b/Documentation/networking/rxrpc.rst
index a01f0c81ca4b..fe2ea73be441 100644
--- a/Documentation/networking/rxrpc.rst
+++ b/Documentation/networking/rxrpc.rst
@@ -1178,6 +1178,7 @@ API Function Reference
 ======================
 
 .. kernel-doc:: net/rxrpc/af_rxrpc.c
+.. kernel-doc:: net/rxrpc/call_object.c
 .. kernel-doc:: net/rxrpc/key.c
 .. kernel-doc:: net/rxrpc/oob.c
 .. kernel-doc:: net/rxrpc/peer_object.c
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index b3612b700c6a..178804817efb 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -176,8 +176,10 @@ struct afs_call {
 	bool			intr;		/* T if interruptible */
 	bool			unmarshalling_error; /* T if an unmarshalling error occurred */
 	bool			responded;	/* Got a response from the call (may be abort) */
+	u8			security_ix;	/* Security class */
 	u16			service_id;	/* Actual service ID (after upgrade) */
 	unsigned int		debug_id;	/* Trace ID */
+	u32			enctype;	/* Security encoding type */
 	u32			operation_ID;	/* operation ID for an incoming call */
 	u32			count;		/* count for use in unmarshalling */
 	union {					/* place to extract temporary data */
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 212af2aa85bf..00b3bc087f61 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -813,6 +813,10 @@ static int afs_deliver_cm_op_id(struct afs_call *call)
 	if (!afs_cm_incoming_call(call))
 		return -ENOTSUPP;
 
+	call->security_ix = rxrpc_kernel_query_call_security(call->rxcall,
+							     &call->service_id,
+							     &call->enctype);
+
 	trace_afs_cb_call(call);
 	call->work.func = call->type->work;
 
diff --git a/include/net/af_rxrpc.h b/include/net/af_rxrpc.h
index 0b209f703ffc..f15341594cc8 100644
--- a/include/net/af_rxrpc.h
+++ b/include/net/af_rxrpc.h
@@ -112,5 +112,7 @@ int rxkad_kernel_respond_to_challenge(struct sk_buff *challenge);
 u32 rxgk_kernel_query_challenge(struct sk_buff *challenge);
 int rxgk_kernel_respond_to_challenge(struct sk_buff *challenge,
 				     struct krb5_buffer *appdata);
+u8 rxrpc_kernel_query_call_security(struct rxrpc_call *call,
+				    u16 *_service_id, u32 *_enctype);
 
 #endif /* _NET_RXRPC_H */
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 8857f5ea77d4..7f83d242c8e9 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -663,19 +663,26 @@ TRACE_EVENT(afs_cb_call,
 		    __field(unsigned int,		call)
 		    __field(u32,			op)
 		    __field(u16,			service_id)
+		    __field(u8,				security_ix)
+		    __field(u32,			enctype)
 			     ),
 
 	    TP_fast_assign(
 		    __entry->call	= call->debug_id;
 		    __entry->op		= call->operation_ID;
 		    __entry->service_id	= call->service_id;
+		    __entry->security_ix = call->security_ix;
+		    __entry->enctype	= call->enctype;
 			   ),
 
-	    TP_printk("c=%08x %s",
+	    TP_printk("c=%08x %s sv=%u sx=%u en=%u",
 		      __entry->call,
 		      __entry->service_id == 2501 ?
 		      __print_symbolic(__entry->op, yfs_cm_operations) :
-		      __print_symbolic(__entry->op, afs_cm_operations))
+		      __print_symbolic(__entry->op, afs_cm_operations),
+		      __entry->service_id,
+		      __entry->security_ix,
+		      __entry->enctype)
 	    );
 
 TRACE_EVENT(afs_call,
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index fd235bfa226d..ca62a1db3286 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -740,6 +740,7 @@ struct rxrpc_call {
 	u32			call_id;	/* call ID on connection  */
 	u32			cid;		/* connection ID plus channel index */
 	u32			security_level;	/* Security level selected */
+	u32			security_enctype; /* Security-specific encoding type (or 0) */
 	int			debug_id;	/* debug ID for printks */
 	unsigned short		rx_pkt_offset;	/* Current recvmsg packet offset */
 	unsigned short		rx_pkt_len;	/* Current recvmsg packet len */
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index dfa9f3d672c9..244abc1314e5 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -760,3 +760,23 @@ void rxrpc_destroy_all_calls(struct rxrpc_net *rxnet)
 	atomic_dec(&rxnet->nr_calls);
 	wait_var_event(&rxnet->nr_calls, !atomic_read(&rxnet->nr_calls));
 }
+
+/**
+ * rxrpc_kernel_query_call_security - Query call's security parameters
+ * @call: The call to query
+ * @_service_id: Where to return the service ID
+ * @_enctype: Where to return the "encoding type"
+ *
+ * This queries the security parameters of a call, setting *@_service_id and
+ * *@_enctype and returning the security class.
+ *
+ * Return: The security class protocol number.
+ */
+u8 rxrpc_kernel_query_call_security(struct rxrpc_call *call,
+				    u16 *_service_id, u32 *_enctype)
+{
+	*_service_id = call->dest_srx.srx_service;
+	*_enctype = call->security_enctype;
+	return call->security_ix;
+}
+EXPORT_SYMBOL(rxrpc_kernel_query_call_security);
diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
index 8b1ccdf8bc58..6175fc54ba90 100644
--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -443,6 +443,7 @@ static int rxgk_secure_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 	if (ret < 0)
 		return ret;
 
+	call->security_enctype = gk->krb5->etype;
 	txb->cksum = htons(gk->key_number);
 
 	switch (call->conn->security_level) {
@@ -590,6 +591,7 @@ static int rxgk_verify_packet(struct rxrpc_call *call, struct sk_buff *skb)
 		}
 	}
 
+	call->security_enctype = gk->krb5->etype;
 	switch (call->conn->security_level) {
 	case RXRPC_SECURITY_PLAIN:
 		return 0;


