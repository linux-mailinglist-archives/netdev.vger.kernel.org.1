Return-Path: <netdev+bounces-179733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1820BA7E622
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 448AF42226C
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0704A20CCF2;
	Mon,  7 Apr 2025 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pj2dHoVV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEF220C03C
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042349; cv=none; b=tfx5AhUS3Cr6TTrb1c4eEtLmNReW07KNEzTYB75QtVM40lASf/scmn5DHD1QYti0b74ef4OuCiJ0baVEUsSz/sDTR9SShjLB+LUHUeOe06gfvJy+QVYzWBtGX4HiGTUSkfu25a8VlNYB6pp39h57RcqgWcsetXJOparaOQqpHEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042349; c=relaxed/simple;
	bh=aeXoYDUiqYVh8riiO+qrRPkNrhwg7wWaEps1LPUw6iI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcH0HFLWstWScB4PG0AOmwT92bKwAfHn+sd+1REjiSrRut60vpzfc0zOvOz+R9y3tkCQDvN1UG/5dat9KAB+aAEUkiG1W7YMSWqoarMdDWuVvKcIawiBZGvo2iC1XIJjr3nsXAk5Dlt+q8r1bsFNGzimPZkHNKpAk4N2f8MIbj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pj2dHoVV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744042347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vPw9iIKKVoxSBOjo4kon0A1v1BpjuVHehJXapeZHSJ4=;
	b=Pj2dHoVVWmdJINmp0zmJt5/hQCRruiAYtrGFumRWc1usLL4TDZl7RnwIxR+uPgedDf5Hao
	0I0C+sUmecUWI03n3flcRFRKYWeSlDKgR8eZqHwfCK2g6PjAGdsQ7+WH8ouHdP8ClEcF1w
	o3rIN28iPDDy8QFsaTiGUDIAXTUWU2w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-q7NAXPOcNfWWPZBVqJJoKw-1; Mon,
 07 Apr 2025 12:12:26 -0400
X-MC-Unique: q7NAXPOcNfWWPZBVqJJoKw-1
X-Mimecast-MFC-AGG-ID: q7NAXPOcNfWWPZBVqJJoKw_1744042344
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 232E01955DC6;
	Mon,  7 Apr 2025 16:12:24 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.40])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8ECA7180A803;
	Mon,  7 Apr 2025 16:12:20 +0000 (UTC)
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
Subject: [PATCH net-next v2 09/13] rxrpc: Allow the app to store private data on peer structs
Date: Mon,  7 Apr 2025 17:11:22 +0100
Message-ID: <20250407161130.1349147-10-dhowells@redhat.com>
In-Reply-To: <20250407161130.1349147-1-dhowells@redhat.com>
References: <20250407161130.1349147-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
 net/rxrpc/oob.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/oob.c b/net/rxrpc/oob.c
index b2330d642d8d..66c05c68e2e9 100644
--- a/net/rxrpc/oob.c
+++ b/net/rxrpc/oob.c
@@ -274,7 +274,7 @@ enum rxrpc_oob_type rxrpc_kernel_query_oob(struct sk_buff *oob,
 	switch (type) {
 	case RXRPC_OOB_CHALLENGE:
 		*_peer		= sp->chall.conn->peer;
-		*_peer_appdata	= 0; /* TODO: retrieve appdata */
+		*_peer_appdata	= sp->chall.conn->peer->app_data;
 		break;
 	default:
 		WARN_ON_ONCE(1);
@@ -349,7 +349,7 @@ void rxrpc_kernel_query_challenge(struct sk_buff *challenge,
 	struct rxrpc_skb_priv *sp = rxrpc_skb(challenge);
 
 	*_peer		= sp->chall.conn->peer;
-	*_peer_appdata	= 0; /* TODO: retrieve appdata */
+	*_peer_appdata	= sp->chall.conn->peer->app_data;
 	*_service_id	= sp->hdr.serviceId;
 	*_security_index = sp->hdr.securityIndex;
 }


