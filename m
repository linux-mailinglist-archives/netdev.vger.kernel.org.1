Return-Path: <netdev+bounces-148859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC839E34F5
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 09:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADED0B2C80B
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 07:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A834F1ABEC6;
	Wed,  4 Dec 2024 07:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wvl0KumB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015AF1AAE39
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 07:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298505; cv=none; b=PeIl3WGrJ9ENMs4V4zqjI0Ykt6pohcXZQuEgodXhLvwjzpm1Y+xvs1jqGnFz1G0V8a0eo1GLdYZrVsqdH6rJ2oCE04WVoOtIAjjyTUSN5OFZDupaqJgIkpy3orRYdrkM7efEQJ/jscrjLMkzcyRqzuMpQSk6KjvNHnfB/OMzHVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298505; c=relaxed/simple;
	bh=VMD9mWtrBmV7Zm/dSnkNbPv+VhBSXBtb83ceLg8MVpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nlq9xScRu2mMJTQBZh6PGmo9Z+d6+sthoiMsmifIUTuN140yOQNVDZTWUk6j3FncKrQfvYgIDVxXWKIkSAgpTQyeVRn+tBEBtEPAURiGlx5NdmoE1cITU2UloLwdh6shK6Vc/IQNzTpmvmtZe+anVAAJk+micpJFGuPsD6VxNDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wvl0KumB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733298502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QtepLyz9mX56IHlh2IlnxSf+nKmI3dlpCTIXv5ukb04=;
	b=Wvl0KumBqLtblD6i03SwMtJCoRN06inEntl5R8jCnc86gzM+Rh/EqZl+0R86R+sp5UVEtx
	SQyl5YdJmfx6syjSAskWlEz6ki9QdIMFSbqJs5MC5dJ5pqGhK5sWzu9bera0bDu/Jf/voR
	X0xj/kEFX2/6Qlgp4wdy29OqxNPodPw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-FuEtMJZUPviFoMg6bDAKRg-1; Wed,
 04 Dec 2024 02:48:19 -0500
X-MC-Unique: FuEtMJZUPviFoMg6bDAKRg-1
X-Mimecast-MFC-AGG-ID: FuEtMJZUPviFoMg6bDAKRg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F13D1955F65;
	Wed,  4 Dec 2024 07:48:17 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F6DC1956096;
	Wed,  4 Dec 2024 07:48:14 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 14/39] rxrpc: Fix injection of packet loss
Date: Wed,  4 Dec 2024 07:46:42 +0000
Message-ID: <20241204074710.990092-15-dhowells@redhat.com>
In-Reply-To: <20241204074710.990092-1-dhowells@redhat.com>
References: <20241204074710.990092-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Fix the code that injects packet loss for testing to make sure
call->tx_transmitted is updated.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/output.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index aededdd474d7..ca0da5e5d278 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -544,16 +544,6 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 
 	len = rxrpc_prepare_data_packet(call, txb, n);
 
-	if (IS_ENABLED(CONFIG_AF_RXRPC_INJECT_LOSS)) {
-		static int lose;
-		if ((lose++ & 7) == 7) {
-			ret = 0;
-			trace_rxrpc_tx_data(call, txb->seq, txb->serial,
-					    txb->flags, true);
-			goto done;
-		}
-	}
-
 	iov_iter_kvec(&msg.msg_iter, WRITE, call->local->kvec, n, len);
 
 	msg.msg_name	= &call->peer->srx.transport;
@@ -579,6 +569,17 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 		frag = rxrpc_tx_point_call_data_nofrag;
 	}
 
+	if (IS_ENABLED(CONFIG_AF_RXRPC_INJECT_LOSS)) {
+		static int lose;
+
+		if ((lose++ & 7) == 7) {
+			ret = 0;
+			trace_rxrpc_tx_data(call, txb->seq, txb->serial,
+					    txb->flags, true);
+			goto done;
+		}
+	}
+
 retry:
 	/* send the packet by UDP
 	 * - returns -EMSGSIZE if UDP would have to fragment the packet


