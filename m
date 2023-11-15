Return-Path: <netdev+bounces-48117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDAF7EC977
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 18:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86AA281136
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 17:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD112836F;
	Wed, 15 Nov 2023 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="abnDLUZH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1698F
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 09:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700068547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l0183wfb6QQa7Dify3mlCQ9wLvW15z5Q/GXKekFiQGQ=;
	b=abnDLUZH7ynwkKRixHDbtJHt688JbygPhV440Rjfz9umpnYoFOWcBl1t7kZ5jwoRc2i9CU
	UaGmHDS6x6aSYjsDDp5xPLjsT/N7JV9L6sZdDZ/GMD3bNeDqgcyLvVKE9btXx89EomDePe
	BkJrZwjwfvHN5mRnSQ09s2z+ym59qzs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-NuvpSifpOSqIylCwNS7D0A-1; Wed,
 15 Nov 2023 12:15:42 -0500
X-MC-Unique: NuvpSifpOSqIylCwNS7D0A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02E2F3C000AA;
	Wed, 15 Nov 2023 17:15:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D4BBA1121306;
	Wed, 15 Nov 2023 17:15:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH net] rxrpc: Fix some minor issues with bundle tracing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3939792.1700068540.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Nov 2023 17:15:40 +0000
Message-ID: <3939793.1700068540@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

    =

Fix some superficial issues with the tracing of rxrpc_bundle structs,
including:

 (1) Set the debug_id when the bundle is allocated rather than when it is
     set up so that the "NEW" trace line displays the correct bundle ID.

 (2) Show the refcount when emitting the "FREE" traceline.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/conn_client.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index 981ca5b98bcb..1d95f8bc769f 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -73,6 +73,7 @@ static void rxrpc_destroy_client_conn_ids(struct rxrpc_l=
ocal *local)
 static struct rxrpc_bundle *rxrpc_alloc_bundle(struct rxrpc_call *call,
 					       gfp_t gfp)
 {
+	static atomic_t rxrpc_bundle_id;
 	struct rxrpc_bundle *bundle;
 =

 	bundle =3D kzalloc(sizeof(*bundle), gfp);
@@ -85,6 +86,7 @@ static struct rxrpc_bundle *rxrpc_alloc_bundle(struct rx=
rpc_call *call,
 		bundle->upgrade		=3D test_bit(RXRPC_CALL_UPGRADE, &call->flags);
 		bundle->service_id	=3D call->dest_srx.srx_service;
 		bundle->security_level	=3D call->security_level;
+		bundle->debug_id	=3D atomic_inc_return(&rxrpc_bundle_id);
 		refcount_set(&bundle->ref, 1);
 		atomic_set(&bundle->active, 1);
 		INIT_LIST_HEAD(&bundle->waiting_calls);
@@ -105,7 +107,8 @@ struct rxrpc_bundle *rxrpc_get_bundle(struct rxrpc_bun=
dle *bundle,
 =

 static void rxrpc_free_bundle(struct rxrpc_bundle *bundle)
 {
-	trace_rxrpc_bundle(bundle->debug_id, 1, rxrpc_bundle_free);
+	trace_rxrpc_bundle(bundle->debug_id, refcount_read(&bundle->ref),
+			   rxrpc_bundle_free);
 	rxrpc_put_peer(bundle->peer, rxrpc_peer_put_bundle);
 	key_put(bundle->key);
 	kfree(bundle);
@@ -239,7 +242,6 @@ static bool rxrpc_may_reuse_conn(struct rxrpc_connecti=
on *conn)
  */
 int rxrpc_look_up_bundle(struct rxrpc_call *call, gfp_t gfp)
 {
-	static atomic_t rxrpc_bundle_id;
 	struct rxrpc_bundle *bundle, *candidate;
 	struct rxrpc_local *local =3D call->local;
 	struct rb_node *p, **pp, *parent;
@@ -306,7 +308,6 @@ int rxrpc_look_up_bundle(struct rxrpc_call *call, gfp_=
t gfp)
 	}
 =

 	_debug("new bundle");
-	candidate->debug_id =3D atomic_inc_return(&rxrpc_bundle_id);
 	rb_link_node(&candidate->local_node, parent, pp);
 	rb_insert_color(&candidate->local_node, &local->client_bundles);
 	call->bundle =3D rxrpc_get_bundle(candidate, rxrpc_bundle_get_client_cal=
l);


