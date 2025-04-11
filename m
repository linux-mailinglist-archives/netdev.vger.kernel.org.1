Return-Path: <netdev+bounces-181572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14782A8588F
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 11:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1759A570C
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 09:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0187829AB1E;
	Fri, 11 Apr 2025 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKMYGQuH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA7E29DB8E
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365265; cv=none; b=MKLmoM58GObVqg03QJSAasvaSqE/ZILSSCFD+3gWhoCp2jfFTjTgyLcjLCQYKMYrRcZRu33a4RE3uBn35NiRcmxMApuVK51ucu/vY/xqShi2MsH4QKdpizmhN7vmz603mJbBsrmX5lmZkqUgCHt1oXf2YOEAPrYkYFFmsVrsayg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365265; c=relaxed/simple;
	bh=ch48UdhWuT8SWvifvpBoUUbhqUrHmXOVmdglYfhBvvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coh/edtA88zohqOg07a91IBRSdCVqVQQ2fzDWhQZdvomG1LilmekFz/I9v81SjBvMw46L2X609+KsfuFM4CgX4yK83byPQpzDVPi80ewNetgE4+LsYOI+uup4RXAdPX4vi0WZ3xSvLB+zPgXrDIqAhPsBftMentslKPHPeabKak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eKMYGQuH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744365263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jzEigqIOHJRMdb46rL45wiYoxEm7HU5gJAjWBTHplLQ=;
	b=eKMYGQuHXd5mWAF1rZowq1k/gFB/EkIReadVOrReT7opaVigMBmyHgzcL1uZGY/fi9t62s
	c6r1TTVKwQwmES/Oo3dxIM1rD35+AhRi4ASS6CfINH7BzQpqhnAZgqGXBRi3VNKBZsrJ+C
	QfYIKAi1MDL7Sw42poZfpGggpZJD4Nw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-rUSEopSfOVi9EbBCGIbAUQ-1; Fri,
 11 Apr 2025 05:54:20 -0400
X-MC-Unique: rUSEopSfOVi9EbBCGIbAUQ-1
X-Mimecast-MFC-AGG-ID: rUSEopSfOVi9EbBCGIbAUQ_1744365258
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B663188EA6F;
	Fri, 11 Apr 2025 09:54:03 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.40])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 824341956094;
	Fri, 11 Apr 2025 09:54:00 +0000 (UTC)
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
Subject: [PATCH net-next v3 10/14] rxrpc: Allow the app to store private data on peer structs
Date: Fri, 11 Apr 2025 10:52:55 +0100
Message-ID: <20250411095303.2316168-11-dhowells@redhat.com>
In-Reply-To: <20250411095303.2316168-1-dhowells@redhat.com>
References: <20250411095303.2316168-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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
index 3601022b9190..05ca9c1faa57 100644
--- a/net/rxrpc/oob.c
+++ b/net/rxrpc/oob.c
@@ -272,7 +272,7 @@ enum rxrpc_oob_type rxrpc_kernel_query_oob(struct sk_buff *oob,
 	switch (type) {
 	case RXRPC_OOB_CHALLENGE:
 		*_peer		= sp->chall.conn->peer;
-		*_peer_appdata	= 0; /* TODO: retrieve appdata */
+		*_peer_appdata	= sp->chall.conn->peer->app_data;
 		break;
 	default:
 		WARN_ON_ONCE(1);
@@ -347,7 +347,7 @@ void rxrpc_kernel_query_challenge(struct sk_buff *challenge,
 	struct rxrpc_skb_priv *sp = rxrpc_skb(challenge);
 
 	*_peer		= sp->chall.conn->peer;
-	*_peer_appdata	= 0; /* TODO: retrieve appdata */
+	*_peer_appdata	= sp->chall.conn->peer->app_data;
 	*_service_id	= sp->hdr.serviceId;
 	*_security_index = sp->hdr.securityIndex;
 }


