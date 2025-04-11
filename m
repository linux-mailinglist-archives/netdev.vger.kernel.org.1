Return-Path: <netdev+bounces-181568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD555A85886
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 11:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568A49A06C9
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 09:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C669629C34E;
	Fri, 11 Apr 2025 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZm9zsKI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D981929899C
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 09:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365246; cv=none; b=avgy41/D9sskeImFhF2nKMzxzES61qhhLvKRE4tBk8gV1EsSLcCfaD329gk7vGTL69gdLTTO+ca24gsfOuoEtiCCmrKM2ssmulIlPzsU0MndvlYUELykD+r3qHO2JcNuIRccGNwUaaMUxSYH52S4QYeAMXZHX7kWWFO6WCJZbf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365246; c=relaxed/simple;
	bh=oFgMqBi8nJI9AAKtxTSW3VMAHFL1PQ7/JVH1c52rKAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACtmH2qHIgYlhFUQB2lxUd1we8rUJSVUGPSjTHOklTpJaArV9XaKjUvQF1nzFRJsVn1Q330RM3dIMjjonPhN6XGDwgXPkV2omUr9kTvjmtPmlfHnlJHPPayPi4LV+0V/kloS7yRR8J6GjN42s31i5TKK8E7mYdOMzGOYdl8XW8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NZm9zsKI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744365243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xy//vbL2RJzl/mnC3iI6bAePa2lOTUG584jHS7nv3YU=;
	b=NZm9zsKIwooO6Z4HH8lVpvNFD2DKc/5YuiMDk0xPhj7FvFpC/DijZY/4do3HAkd4xub8D9
	c+XBfVgEt8gEpu0b0HWoYkit8L+HmpxUxPccDjZbDG0nQ0+CobjcnMTHIUrUtphJGi3xU0
	P2pnbjeF+FoKglM06yZKkg/PaFk89zY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-nhHbY6e1Pmyex6BO4tnDAw-1; Fri,
 11 Apr 2025 05:54:02 -0400
X-MC-Unique: nhHbY6e1Pmyex6BO4tnDAw-1
X-Mimecast-MFC-AGG-ID: nhHbY6e1Pmyex6BO4tnDAw_1744365240
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2582D1955F10;
	Fri, 11 Apr 2025 09:53:59 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.40])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0461A19560AD;
	Fri, 11 Apr 2025 09:53:54 +0000 (UTC)
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
	linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org
Subject: [PATCH net-next v3 09/14] rxrpc: rxgk: Implement connection rekeying
Date: Fri, 11 Apr 2025 10:52:54 +0100
Message-ID: <20250411095303.2316168-10-dhowells@redhat.com>
In-Reply-To: <20250411095303.2316168-1-dhowells@redhat.com>
References: <20250411095303.2316168-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Implement rekeying of connections with the RxGK security class.  This
involves regenerating the keys with a different key number as part of the
input data after a certain amount of time or a certain amount of bytes
encrypted.  Rekeying may be triggered by either end.

The LSW of the key number is inserted into the security-specific field in
the RX header, and we try and expand it to 32-bits to make it last longer.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: "David S. Miller" <davem@davemloft.net>
cc: Chuck Lever <chuck.lever@oracle.com>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: linux-crypto@vger.kernel.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h |  24 ++++++
 net/rxrpc/ar-internal.h      |   5 +-
 net/rxrpc/conn_object.c      |   1 +
 net/rxrpc/rxgk.c             | 158 +++++++++++++++++++++++++++++++++--
 4 files changed, 181 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index aab81e8196ae..920439df1f6f 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -2725,6 +2725,30 @@ TRACE_EVENT(rxrpc_rack_timer,
 		      ktime_to_us(__entry->delay))
 	    );
 
+TRACE_EVENT(rxrpc_rxgk_rekey,
+	    TP_PROTO(struct rxrpc_connection *conn,
+		     unsigned int current_key, unsigned int requested_key),
+
+	    TP_ARGS(conn, current_key, requested_key),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	conn)
+		    __field(unsigned int,	current_key)
+		    __field(unsigned int,	requested_key)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->conn		= conn->debug_id;
+		    __entry->current_key	= current_key;
+		    __entry->requested_key	= requested_key;
+			   ),
+
+	    TP_printk("C=%08x cur=%x req=%x",
+		      __entry->conn,
+		      __entry->current_key,
+		      __entry->requested_key)
+	    );
+
 #undef EM
 #undef E_
 
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 57ea6d61b7a2..fd235bfa226d 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -565,13 +565,16 @@ struct rxrpc_connection {
 			u32	nonce;		/* response re-use preventer */
 		} rxkad;
 		struct {
-			struct rxgk_context *keys[1];
+			struct rxgk_context *keys[4]; /* (Re-)keying buffer */
 			u64	start_time;	/* The start time for TK derivation */
 			u8	nonce[20];	/* Response re-use preventer */
 			u32	enctype;	/* Kerberos 5 encoding type */
+			u32	key_number;	/* Current key number */
 		} rxgk;
 	};
+	rwlock_t		security_use_lock; /* Security use/modification lock */
 	struct sk_buff		*tx_response;	/* Response packet to be transmitted */
+
 	unsigned long		flags;
 	unsigned long		events;
 	unsigned long		idle_timestamp;	/* Time at which last became idle */
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index f1e36cba9f4c..6733a7692443 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -73,6 +73,7 @@ struct rxrpc_connection *rxrpc_alloc_connection(struct rxrpc_net *rxnet,
 		skb_queue_head_init(&conn->rx_queue);
 		conn->rxnet = rxnet;
 		conn->security = &rxrpc_no_security;
+		rwlock_init(&conn->security_use_lock);
 		spin_lock_init(&conn->state_lock);
 		conn->debug_id = atomic_inc_return(&rxrpc_debug_id);
 		conn->idle_timestamp = jiffies;
diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
index 02752eeb2395..8b1ccdf8bc58 100644
--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -76,11 +76,155 @@ static void rxgk_describe_server_key(const struct key *key, struct seq_file *m)
 		seq_printf(m, ": %s", krb5->name);
 }
 
+/*
+ * Handle rekeying the connection when we see our limits overrun or when the
+ * far side decided to rekey.
+ *
+ * Returns a ref on the context if successful or -ESTALE if the key is out of
+ * date.
+ */
+static struct rxgk_context *rxgk_rekey(struct rxrpc_connection *conn,
+				       const u16 *specific_key_number)
+{
+	struct rxgk_context *gk, *dead = NULL;
+	unsigned int key_number, current_key, mask = ARRAY_SIZE(conn->rxgk.keys) - 1;
+	bool crank = false;
+
+	_enter("%d", specific_key_number ? *specific_key_number : -1);
+
+	mutex_lock(&conn->security_lock);
+
+	current_key = conn->rxgk.key_number;
+	if (!specific_key_number) {
+		key_number = current_key;
+	} else {
+		if (*specific_key_number == (u16)current_key)
+			key_number = current_key;
+		else if (*specific_key_number == (u16)(current_key - 1))
+			key_number = current_key - 1;
+		else if (*specific_key_number == (u16)(current_key + 1))
+			goto crank_window;
+		else
+			goto bad_key;
+	}
+
+	gk = conn->rxgk.keys[key_number & mask];
+	if (!gk)
+		goto generate_key;
+	if (!specific_key_number &&
+	    test_bit(RXGK_TK_NEEDS_REKEY, &gk->flags))
+		goto crank_window;
+
+grab:
+	refcount_inc(&gk->usage);
+	mutex_unlock(&conn->security_lock);
+	rxgk_put(dead);
+	return gk;
+
+crank_window:
+	trace_rxrpc_rxgk_rekey(conn, current_key,
+			       specific_key_number ? *specific_key_number : -1);
+	if (current_key == UINT_MAX)
+		goto bad_key;
+	if (current_key + 1 == UINT_MAX)
+		set_bit(RXRPC_CONN_DONT_REUSE, &conn->flags);
+
+	key_number = current_key + 1;
+	if (WARN_ON(conn->rxgk.keys[key_number & mask]))
+		goto bad_key;
+	crank = true;
+
+generate_key:
+	gk = conn->rxgk.keys[current_key & mask];
+	gk = rxgk_generate_transport_key(conn, gk->key, key_number, GFP_NOFS);
+	if (IS_ERR(gk)) {
+		mutex_unlock(&conn->security_lock);
+		return gk;
+	}
+
+	write_lock(&conn->security_use_lock);
+	if (crank) {
+		current_key++;
+		conn->rxgk.key_number = current_key;
+		dead = conn->rxgk.keys[(current_key - 2) & mask];
+		conn->rxgk.keys[(current_key - 2) & mask] = NULL;
+	}
+	conn->rxgk.keys[current_key & mask] = gk;
+	write_unlock(&conn->security_use_lock);
+	goto grab;
+
+bad_key:
+	mutex_unlock(&conn->security_lock);
+	return ERR_PTR(-ESTALE);
+}
+
+/*
+ * Get the specified keying context.
+ *
+ * Returns a ref on the context if successful or -ESTALE if the key is out of
+ * date.
+ */
 static struct rxgk_context *rxgk_get_key(struct rxrpc_connection *conn,
-					 u16 *specific_key_number)
+					 const u16 *specific_key_number)
 {
-	refcount_inc(&conn->rxgk.keys[0]->usage);
-	return conn->rxgk.keys[0];
+	struct rxgk_context *gk;
+	unsigned int key_number, current_key, mask = ARRAY_SIZE(conn->rxgk.keys) - 1;
+
+	_enter("{%u},%d",
+	       conn->rxgk.key_number, specific_key_number ? *specific_key_number : -1);
+
+	read_lock(&conn->security_use_lock);
+
+	current_key = conn->rxgk.key_number;
+	if (!specific_key_number) {
+		key_number = current_key;
+	} else {
+		/* Only the bottom 16 bits of the key number are exposed in the
+		 * header, so we try and keep the upper 16 bits in step.  The
+		 * whole 32 bits are used to generate the TK.
+		 */
+		if (*specific_key_number == (u16)current_key)
+			key_number = current_key;
+		else if (*specific_key_number == (u16)(current_key - 1))
+			key_number = current_key - 1;
+		else if (*specific_key_number == (u16)(current_key + 1))
+			goto rekey;
+		else
+			goto bad_key;
+	}
+
+	gk = conn->rxgk.keys[key_number & mask];
+	if (!gk)
+		goto slow_path;
+	if (!specific_key_number &&
+	    key_number < UINT_MAX) {
+		if (time_after(jiffies, gk->expiry) ||
+		    gk->bytes_remaining < 0) {
+			set_bit(RXGK_TK_NEEDS_REKEY, &gk->flags);
+			goto slow_path;
+		}
+
+		if (test_bit(RXGK_TK_NEEDS_REKEY, &gk->flags))
+			goto slow_path;
+	}
+
+	refcount_inc(&gk->usage);
+	read_unlock(&conn->security_use_lock);
+	return gk;
+
+rekey:
+	_debug("rekey");
+	if (current_key == UINT_MAX)
+		goto bad_key;
+	gk = conn->rxgk.keys[current_key & mask];
+	if (gk)
+		set_bit(RXGK_TK_NEEDS_REKEY, &gk->flags);
+slow_path:
+	read_unlock(&conn->security_use_lock);
+	return rxgk_rekey(conn, specific_key_number);
+bad_key:
+	read_unlock(&conn->security_use_lock);
+	return ERR_PTR(-ESTALE);
 }
 
 /*
@@ -92,7 +236,8 @@ static int rxgk_init_connection_security(struct rxrpc_connection *conn,
 	struct rxgk_context *gk;
 	int ret;
 
-	_enter("{%d},{%x}", conn->debug_id, key_serial(conn->key));
+	_enter("{%d,%u},{%x}",
+	       conn->debug_id, conn->rxgk.key_number, key_serial(conn->key));
 
 	conn->security_ix = token->security_index;
 	conn->security_level = token->rxgk->level;
@@ -102,11 +247,12 @@ static int rxgk_init_connection_security(struct rxrpc_connection *conn,
 		do_div(conn->rxgk.start_time, 100);
 	}
 
-	gk = rxgk_generate_transport_key(conn, token->rxgk, 0, GFP_NOFS);
+	gk = rxgk_generate_transport_key(conn, token->rxgk, conn->rxgk.key_number,
+					 GFP_NOFS);
 	if (IS_ERR(gk))
 		return PTR_ERR(gk);
 	conn->rxgk.enctype = gk->krb5->etype;
-	conn->rxgk.keys[0] = gk;
+	conn->rxgk.keys[gk->key_number & 3] = gk;
 
 	switch (conn->security_level) {
 	case RXRPC_SECURITY_PLAIN:


