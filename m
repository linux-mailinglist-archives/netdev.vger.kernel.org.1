Return-Path: <netdev+bounces-179552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF82A7D961
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 11:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAEEE177773
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 09:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170E823A996;
	Mon,  7 Apr 2025 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="de1W0SJc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76561239588
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744017353; cv=none; b=H4WYlYbDVITsaixVEdyPt9Rgb/PUArof+5k7ssUJ7LYxuO8byyE0pOohEI2G1dGRU4rs2ERz2fLJmRNhrfyAnTICam2Z0hCJrw2SVmbDS/qR5IfX02iWDyNFdplTeBkCCS8iZr5Fh/9asDsRRE26k5gS5LNR2yNosOAPnE30H0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744017353; c=relaxed/simple;
	bh=K7Ad3KdpqDkhQC6ojaPJHHOyYZDY+nsnQje7SLgBPXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ByumUlMmdvkCIUahkdVXkIalhXRX1kykGr32nQFeuGgKH4+xgjHslhkgfO2lOGNGcf6D/+bNKNvtIF/CqIppEIdUeHISgIktpa4l+NVA50w7sY+oHvhz5dgRvhLbA2CVgguTmhjj9KgIwWHpIHkxEmrWps3BswAEpIKKSNx+U8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=de1W0SJc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744017350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SCZRJRYgK9GzE/XqScI5Q5rs4mQlTh2sx8JhAMmoLCk=;
	b=de1W0SJcd6yCnfTK3mIRdNs7/ga4C+wZAjrrA2ud8xg1wT/Rp2jZy7v6YqwXsEGGC29r3a
	wxMgWuZoYJzDdnqs1W9Fq2WnwLii8MAYO/eIW9JLhlShPfM6r0t5X4jQdOrJtBM6Ne5gDI
	BdfGMYAQVPo39G8GrKgzBUjBJ7/j+wM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-jN2kVIUUMAS45MmZAhxMDw-1; Mon,
 07 Apr 2025 05:15:46 -0400
X-MC-Unique: jN2kVIUUMAS45MmZAhxMDw-1
X-Mimecast-MFC-AGG-ID: jN2kVIUUMAS45MmZAhxMDw_1744017344
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F32B719560B7;
	Mon,  7 Apr 2025 09:15:43 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.40])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A8160180094A;
	Mon,  7 Apr 2025 09:15:40 +0000 (UTC)
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
	openafs-devel@openafs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 08/12] rxrpc: Allow the app to store private data on peer structs
Date: Mon,  7 Apr 2025 10:14:39 +0100
Message-ID: <20250407091451.1174056-9-dhowells@redhat.com>
In-Reply-To: <20250407091451.1174056-1-dhowells@redhat.com>
References: <20250407091451.1174056-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
index 8a8893463d95..f860148a8ca4 100644
--- a/net/rxrpc/oob.c
+++ b/net/rxrpc/oob.c
@@ -271,7 +271,7 @@ enum rxrpc_oob_type rxrpc_kernel_query_oob(struct sk_buff *oob,
 	switch (type) {
 	case RXRPC_OOB_CHALLENGE:
 		*_peer		= sp->chall.conn->peer;
-		*_peer_appdata	= 0; /* TODO: retrieve appdata */
+		*_peer_appdata	= sp->chall.conn->peer->app_data;
 		break;
 	default:
 		WARN_ON_ONCE(1);
@@ -342,7 +342,7 @@ void rxrpc_kernel_query_challenge(struct sk_buff *challenge,
 	struct rxrpc_skb_priv *sp = rxrpc_skb(challenge);
 
 	*_peer		= sp->chall.conn->peer;
-	*_peer_appdata	= 0; /* TODO: retrieve appdata */
+	*_peer_appdata	= sp->chall.conn->peer->app_data;
 	*_service_id	= sp->hdr.serviceId;
 	*_security_index = sp->hdr.securityIndex;
 }


