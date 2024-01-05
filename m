Return-Path: <netdev+bounces-61997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3085C8258D5
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 18:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4BA1F21844
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 17:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376B42E82F;
	Fri,  5 Jan 2024 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALrcXsoo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A31F31A79
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 17:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704474348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JrHpstWMweqHmwv0W0gV2LfaiN8+NJubK8GIKuda4w4=;
	b=ALrcXsoon97QPNMiLf0AsTEEx831ffWLXbWnfWbSC9W0oDQ62peRrW3FkoZbM48HK0VaJN
	m1Jv9A+f5Gd7rkvW26d3fbluK6uvENmw7QTQBszeGjXUj0czSoJj8dTEHCyL6XQXhx7VIR
	2B3QUPLsZpJbFPJv2wM25rVs4kN3gjg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-qnNTMjryOLCldvCVxbsb-g-1; Fri,
 05 Jan 2024 12:05:43 -0500
X-MC-Unique: qnNTMjryOLCldvCVxbsb-g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 401B81C05148;
	Fri,  5 Jan 2024 17:05:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1A5253C25;
	Fri,  5 Jan 2024 17:05:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
cc: dhowells@redhat.com, "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rxrpc: Fix skbuff cleanup of call's recvmsg_queue and rx_oos_queue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1366724.1704474341.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jan 2024 17:05:41 +0000
Message-ID: <1366725.1704474341@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

    =

Fix rxrpc_cleanup_ring() to use rxrpc_purge_queue() rather than
skb_queue_purge() so that the count of outstanding skbuffs is correctly
updated when a failed call is cleaned up.

Without this rmmod may hang waiting for rxrpc_n_rx_skbs to become zero.

Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/call_object.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 773eecd1e979..f10b37c14772 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -545,8 +545,8 @@ void rxrpc_get_call(struct rxrpc_call *call, enum rxrp=
c_call_trace why)
  */
 static void rxrpc_cleanup_ring(struct rxrpc_call *call)
 {
-	skb_queue_purge(&call->recvmsg_queue);
-	skb_queue_purge(&call->rx_oos_queue);
+	rxrpc_purge_queue(&call->recvmsg_queue);
+	rxrpc_purge_queue(&call->rx_oos_queue);
 }
 =

 /*


