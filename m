Return-Path: <netdev+bounces-169254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7568AA4313B
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 00:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF7743B49CB
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 23:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2A3213235;
	Mon, 24 Feb 2025 23:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ff0diw0K"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBB62135CA
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 23:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440583; cv=none; b=KCGjyLADyvKMb6R4mx0gl22Po71mt48L+jbcD+UnNXGVUUiS8ZGpomEttIPEThC48FrA6m7nZ95PT8D8kwGr0IAB7VmR1tuNhAQjHsoJCHLYnDaw/ggwP/C00tHrA16eQGCEeD2d17EmkOlMZENCo1iC/sJTmPno9iDaz0gob4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440583; c=relaxed/simple;
	bh=7GSX7JKuB/vKM5jaru61sD+LYgBzM0cIZr1NEMjQElc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFOrVnyLsoFNqwA7YpAkRXTDkCjVq/nRZE6H8MQd5g6aV8ELzejkVVLRyquTaIoVq7EBmY52rhLRW4qSKKy4Q99lwzOMCsgVeI1EkJsueRbq8TZ1td9pWcq+6ozIQDxoHkHDGvqVjIUD9aTXWKN7cX5uVx6R6Y4mE8dY6EVQMmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ff0diw0K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740440581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q5ues3zY+9vJROA+24t/iPCUg8VWVFjV9Q9yVGRjWjU=;
	b=Ff0diw0K15yFG179nptsxzZiN3N3G1ig0pCVwN42KG3jT42becMnQqdxZKnPlCmdh8aBpS
	hlmsl2o4KTxrJm4sqNb4IkolcMUe3drFbZ4p5fNk4HHHNWjxUDLQTjJOjO9JmEK4VOObFm
	7ZI/fSCzTz5SiPv3B46SnsgTWL/TVjs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-Q7eUhoPUMHK8NKDGFirnfg-1; Mon,
 24 Feb 2025 18:42:56 -0500
X-MC-Unique: Q7eUhoPUMHK8NKDGFirnfg-1
X-Mimecast-MFC-AGG-ID: Q7eUhoPUMHK8NKDGFirnfg_1740440574
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7703A19039CA;
	Mon, 24 Feb 2025 23:42:54 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.9])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B33C31955BD4;
	Mon, 24 Feb 2025 23:42:51 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 12/15] rxrpc: Allow the app to store private data on peer structs
Date: Mon, 24 Feb 2025 23:41:49 +0000
Message-ID: <20250224234154.2014840-13-dhowells@redhat.com>
In-Reply-To: <20250224234154.2014840-1-dhowells@redhat.com>
References: <20250224234154.2014840-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Provide a way for the application (e.g. the afs filesystem) to store
private data on the rxrpc_peer structs for later retrieval via the call
object.

This will allow afs to store a pointer to the afs_server object on the
rxrpc_peer struct, thereby obviating the need for afs to keep lookup tables
by which it can associate an incoming call with server that transmitted it.

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
 include/net/af_rxrpc.h  |  2 ++
 net/rxrpc/ar-internal.h |  1 +
 net/rxrpc/peer_object.c | 26 ++++++++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/include/net/af_rxrpc.h b/include/net/af_rxrpc.h
index 0754c463224a..cf793d18e5df 100644
--- a/include/net/af_rxrpc.h
+++ b/include/net/af_rxrpc.h
@@ -69,6 +69,8 @@ struct rxrpc_peer *rxrpc_kernel_get_peer(struct rxrpc_peer *peer);
 struct rxrpc_peer *rxrpc_kernel_get_call_peer(struct socket *sock, struct rxrpc_call *call);
 const struct sockaddr_rxrpc *rxrpc_kernel_remote_srx(const struct rxrpc_peer *peer);
 const struct sockaddr *rxrpc_kernel_remote_addr(const struct rxrpc_peer *peer);
+unsigned long rxrpc_kernel_set_peer_data(struct rxrpc_peer *peer, unsigned long app_data);
+unsigned long rxrpc_kernel_get_peer_data(const struct rxrpc_peer *peer);
 unsigned int rxrpc_kernel_get_srtt(const struct rxrpc_peer *);
 int rxrpc_kernel_charge_accept(struct socket *, rxrpc_notify_rx_t,
 			       rxrpc_user_attach_call_t, unsigned long, gfp_t,
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index a64a0cab1bf7..3cc3af15086f 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -344,6 +344,7 @@ struct rxrpc_peer {
 	struct hlist_head	error_targets;	/* targets for net error distribution */
 	struct rb_root		service_conns;	/* Service connections */
 	struct list_head	keepalive_link;	/* Link in net->peer_keepalive[] */
+	unsigned long		app_data;	/* Application data (e.g. afs_server) */
 	time64_t		last_tx_at;	/* Last time packet sent here */
 	seqlock_t		service_conn_lock;
 	spinlock_t		lock;		/* access lock */
diff --git a/net/rxrpc/peer_object.c b/net/rxrpc/peer_object.c
index 56e09d161a97..a0c0e4d590f5 100644
--- a/net/rxrpc/peer_object.c
+++ b/net/rxrpc/peer_object.c
@@ -520,3 +520,29 @@ const struct sockaddr *rxrpc_kernel_remote_addr(const struct rxrpc_peer *peer)
 		(peer ? &peer->srx.transport : &rxrpc_null_addr.transport);
 }
 EXPORT_SYMBOL(rxrpc_kernel_remote_addr);
+
+/**
+ * rxrpc_kernel_set_peer_data - Set app-specific data on a peer.
+ * @peer: The peer to alter
+ * @app_data: The data to set
+ *
+ * Set the app-specific data on a peer.  AF_RXRPC makes no effort to retain
+ * anything the data might refer to.  The previous app_data is returned.
+ */
+unsigned long rxrpc_kernel_set_peer_data(struct rxrpc_peer *peer, unsigned long app_data)
+{
+	return xchg(&peer->app_data, app_data);
+}
+EXPORT_SYMBOL(rxrpc_kernel_set_peer_data);
+
+/**
+ * rxrpc_kernel_get_peer_data - Get app-specific data from a peer.
+ * @peer: The peer to query
+ *
+ * Retrieve the app-specific data from a peer.
+ */
+unsigned long rxrpc_kernel_get_peer_data(const struct rxrpc_peer *peer)
+{
+	return peer->app_data;
+}
+EXPORT_SYMBOL(rxrpc_kernel_get_peer_data);


