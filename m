Return-Path: <netdev+bounces-148862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4FC9E3481
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A819216601D
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 07:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549771AF0CB;
	Wed,  4 Dec 2024 07:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XksW5WUS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E821AF0A8
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 07:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298516; cv=none; b=Vzqd8WBxqgjE+VxgZjzo8xJ1k050mKRWXLM8AcO/v0r7viseRijbalFF+6UPXqH7i6T1ZiZc9IOgkt8VsbqCbRTmhRj6AYWVLbyXOUwWDa2CCfduk0Hg0eqY4WD4wmstI7BqmEOG/fDi/zv/cVucx6cLwHST5EueE9Zz3qYsERM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298516; c=relaxed/simple;
	bh=f30XQa1QEyityt8HipswQs6kqEiOwtAgODah71b/6u8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VPtz5OU3zkh5Ka6cpyqB1ejzLcrFilR8rJ63dWYchWLtofMSnPYM/cmN+B9sujD2VmShHI9+D3R5vaoBrRTCcPWfOUo/hj2HZGFeZi/A7h4sp7Tp0VbMdKkoYTkYadbjmuAICXquTB67XjL+lacelotNUR8VDbJW+9qgnzM1+Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XksW5WUS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733298513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iQ3WM5YS0zZWwh+zogGfyQBRH0biCe98INfc7iaAitE=;
	b=XksW5WUSgeS8lCpOEFCfjM1rpCOdDoAHrNdLll/efTreND2/0IIiRSITl4c08oxty9JKvp
	cQhtgz9pRAhDBmQy1NJIaXJ6U4Ktvw7sNY1bLnxS3nZJr0WnHVkkxVMI/vE4dU2wATXZuD
	87swF+PNYHT9UOWfpS9Ogq0ysbnBTRE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-C0clBQFaPuCqt3J-afexbQ-1; Wed,
 04 Dec 2024 02:48:30 -0500
X-MC-Unique: C0clBQFaPuCqt3J-afexbQ-1
X-Mimecast-MFC-AGG-ID: C0clBQFaPuCqt3J-afexbQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 316431954AE2;
	Wed,  4 Dec 2024 07:48:29 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A5F1A19560A3;
	Wed,  4 Dec 2024 07:48:26 +0000 (UTC)
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
Subject: [PATCH net-next v2 17/39] rxrpc: Don't need barrier for ->tx_bottom and ->acks_hard_ack
Date: Wed,  4 Dec 2024 07:46:45 +0000
Message-ID: <20241204074710.990092-18-dhowells@redhat.com>
In-Reply-To: <20241204074710.990092-1-dhowells@redhat.com>
References: <20241204074710.990092-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

We don't need a barrier for the ->tx_bottom value (which indicates the
lowest sequence still in the transmission queue) and the ->acks_hard_ack
value (which tracks the DATA packets hard-ack'd by the latest ACK packet
received and thus indicates which DATA packets can now be discarded) as the
app thread doesn't use either value as a reference to memory to access.
Rather, the app thread merely uses these as a guide to how much space is
available in the transmission queue

Change the code to use READ/WRITE_ONCE() instead.

Also, change rxrpc_check_tx_space() to use the same value for tx_bottom
throughout.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/sendmsg.c | 8 +++++---
 net/rxrpc/txbuf.c   | 4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 786c1fb1369a..467c9402882e 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -94,9 +94,11 @@ static int rxrpc_wait_to_be_connected(struct rxrpc_call *call, long *timeo)
  */
 static bool rxrpc_check_tx_space(struct rxrpc_call *call, rxrpc_seq_t *_tx_win)
 {
+	rxrpc_seq_t tx_bottom = READ_ONCE(call->tx_bottom);
+
 	if (_tx_win)
-		*_tx_win = call->tx_bottom;
-	return call->tx_prepared - call->tx_bottom < 256;
+		*_tx_win = tx_bottom;
+	return call->tx_prepared - tx_bottom < 256;
 }
 
 /*
@@ -138,7 +140,7 @@ static int rxrpc_wait_for_tx_window_waitall(struct rxrpc_sock *rx,
 		rtt = 2;
 
 	timeout = rtt;
-	tx_start = smp_load_acquire(&call->acks_hard_ack);
+	tx_start = READ_ONCE(call->acks_hard_ack);
 
 	for (;;) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
diff --git a/net/rxrpc/txbuf.c b/net/rxrpc/txbuf.c
index 8b7c854ed3d7..0cc8f49d69a9 100644
--- a/net/rxrpc/txbuf.c
+++ b/net/rxrpc/txbuf.c
@@ -214,14 +214,14 @@ void rxrpc_shrink_call_tx_buffer(struct rxrpc_call *call)
 
 	while ((txb = list_first_entry_or_null(&call->tx_buffer,
 					       struct rxrpc_txbuf, call_link))) {
-		hard_ack = smp_load_acquire(&call->acks_hard_ack);
+		hard_ack = call->acks_hard_ack;
 		if (before(hard_ack, txb->seq))
 			break;
 
 		if (txb->seq != call->tx_bottom + 1)
 			rxrpc_see_txbuf(txb, rxrpc_txbuf_see_out_of_step);
 		ASSERTCMP(txb->seq, ==, call->tx_bottom + 1);
-		smp_store_release(&call->tx_bottom, call->tx_bottom + 1);
+		WRITE_ONCE(call->tx_bottom, call->tx_bottom + 1);
 		list_del_rcu(&txb->call_link);
 
 		trace_rxrpc_txqueue(call, rxrpc_txqueue_dequeue);


