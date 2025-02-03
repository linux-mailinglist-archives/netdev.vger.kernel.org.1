Return-Path: <netdev+bounces-162053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEEDA257BF
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 12:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD36161CA0
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 11:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1135E202C27;
	Mon,  3 Feb 2025 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RC7u+LC5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FF81D5146
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 11:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738580623; cv=none; b=r0JPTr4v3uNGSWLuVf495em9hBSko+AC8H+PB8yJugmBclKpk4Gm3IFb0IQEH0a2gxdcwOYfXDbBA8DAeywR3R96kiB/CH4YC+so9Bqrc2wSEw80hHOY0WcqzUut3Yxa/gyFBOdEIZtFPnogDCsFVaRXLrQiugH16Lm2YZB8+ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738580623; c=relaxed/simple;
	bh=9ttUZ5MeuwK6L18C0A/46Tx2d9LnOwn9KM4EyWin0n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYjfyyFHxP7hAl1HFEf41KfweBuY5J4ZLp1oPM/aoGNztreNQjB0GnnQbKC6ZwY4UnXPQN5jPmuZGx06KVrHqZTC8Dgm1aUDxqflp8OwVr9qyj4VblFjHiZxmnXVDprBuDRTW1o7x9rDq6A3r5pxhbeVCkXYrpq1QeKc1PaQXLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RC7u+LC5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738580620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QepoMhZxvCaprwxe/kKQUIMTTRdToaS1EIkiLoYlbcE=;
	b=RC7u+LC53f8JsOJfHR5sTpK2Z8kOJ/M59bia19J+Xp1zYIs5ZNUVc4Htu2zUPq8Ulw64lX
	7dI4yKCfBOp0E9IUwkOAThmQnkR9p2kp98FTjEYeDVe9/cpMaqwzY6IYuH+on8bPIjOq2q
	B75CfXfaLek4GJd6Qxr59ib1oIgBCfE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-QFtrjEV2MZqm7YBy8_mTYw-1; Mon,
 03 Feb 2025 06:03:35 -0500
X-MC-Unique: QFtrjEV2MZqm7YBy8_mTYw-1
X-Mimecast-MFC-AGG-ID: QFtrjEV2MZqm7YBy8_mTYw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28FCF1956055;
	Mon,  3 Feb 2025 11:03:33 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.92])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 143A7180A313;
	Mon,  3 Feb 2025 11:03:27 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 2/2] rxrpc: Fix the rxrpc_connection attend queue handling
Date: Mon,  3 Feb 2025 11:03:04 +0000
Message-ID: <20250203110307.7265-3-dhowells@redhat.com>
In-Reply-To: <20250203110307.7265-1-dhowells@redhat.com>
References: <20250203110307.7265-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The rxrpc_connection attend queue is never used because conn::attend_link
is never initialised and so is always NULL'd out and thus always appears to
be busy.  This requires the following fix:

 (1) Fix this the attend queue problem by initialising conn::attend_link.

And, consequently, two further fixes for things masked by the above bug:

 (2) Fix rxrpc_input_conn_event() to handle being invoked with a NULL
     sk_buff pointer - something that can now happen with the above change.

 (3) Fix the RXRPC_SKB_MARK_SERVICE_CONN_SECURED message to carry a pointer
     to the connection and a ref on it.

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
 include/trace/events/rxrpc.h |  1 +
 net/rxrpc/conn_event.c       | 17 ++++++++++-------
 net/rxrpc/conn_object.c      |  1 +
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 2f119d18a061..cad50d91077e 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -219,6 +219,7 @@
 	EM(rxrpc_conn_get_conn_input,		"GET inp-conn") \
 	EM(rxrpc_conn_get_idle,			"GET idle    ") \
 	EM(rxrpc_conn_get_poke_abort,		"GET pk-abort") \
+	EM(rxrpc_conn_get_poke_secured,		"GET secured ") \
 	EM(rxrpc_conn_get_poke_timer,		"GET poke    ") \
 	EM(rxrpc_conn_get_service_conn,		"GET svc-conn") \
 	EM(rxrpc_conn_new_client,		"NEW client  ") \
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index d93b041c4894..4d9c5e21ba78 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -270,6 +270,7 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 			 * we've already received the packet, put it on the
 			 * front of the queue.
 			 */
+			sp->conn = rxrpc_get_connection(conn, rxrpc_conn_get_poke_secured);
 			skb->mark = RXRPC_SKB_MARK_SERVICE_CONN_SECURED;
 			rxrpc_get_skb(skb, rxrpc_skb_get_conn_secured);
 			skb_queue_head(&conn->local->rx_queue, skb);
@@ -435,14 +436,16 @@ void rxrpc_input_conn_event(struct rxrpc_connection *conn, struct sk_buff *skb)
 	if (test_and_clear_bit(RXRPC_CONN_EV_ABORT_CALLS, &conn->events))
 		rxrpc_abort_calls(conn);
 
-	switch (skb->mark) {
-	case RXRPC_SKB_MARK_SERVICE_CONN_SECURED:
-		if (conn->state != RXRPC_CONN_SERVICE)
-			break;
+	if (skb) {
+		switch (skb->mark) {
+		case RXRPC_SKB_MARK_SERVICE_CONN_SECURED:
+			if (conn->state != RXRPC_CONN_SERVICE)
+				break;
 
-		for (loop = 0; loop < RXRPC_MAXCALLS; loop++)
-			rxrpc_call_is_secure(conn->channels[loop].call);
-		break;
+			for (loop = 0; loop < RXRPC_MAXCALLS; loop++)
+				rxrpc_call_is_secure(conn->channels[loop].call);
+			break;
+		}
 	}
 
 	/* Process delayed ACKs whose time has come. */
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index 7eba4d7d9a38..2f1fd1e2e7e4 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -67,6 +67,7 @@ struct rxrpc_connection *rxrpc_alloc_connection(struct rxrpc_net *rxnet,
 		INIT_WORK(&conn->destructor, rxrpc_clean_up_connection);
 		INIT_LIST_HEAD(&conn->proc_link);
 		INIT_LIST_HEAD(&conn->link);
+		INIT_LIST_HEAD(&conn->attend_link);
 		mutex_init(&conn->security_lock);
 		mutex_init(&conn->tx_data_alloc_lock);
 		skb_queue_head_init(&conn->rx_queue);


