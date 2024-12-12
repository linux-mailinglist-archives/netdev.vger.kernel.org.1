Return-Path: <netdev+bounces-151510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C949EFDBB
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 21:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12D5288D7F
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 20:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5411B6D0A;
	Thu, 12 Dec 2024 20:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MLl+MpRZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170E91ABECA
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 20:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734037108; cv=none; b=p9Hkn+pvzaKAuMjiz91tffTX+Z2qaPs4WdQea6VlUXoJsoPpip5Soo/ce9FlY5sLC7iHldbG4tIxkyjrBxr+BWyBJ0F3R08QrpDJn5hijUTyjgoOnQoHSbgASAHElKWRF2LYQqWIxiDXhU4iFoRmw8EgxVj+EWJa1SSsWDruz2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734037108; c=relaxed/simple;
	bh=AjIx23vonbDByIV/t/bn7Eo6a76RJNPk9XgPYz0Qnls=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=H9K16UqIzIEKRrWBptCJtDrzDPfjkgWqlEsF1CotY92pGAjG/Jhi3D+AA6oDVVbfsRufTez8J1JYJIzzYkP05neTTEE5oEgbD+POwnGEbxZgWLivXDp0RzyJ1+IMWKupzXLe2ZxMVvXEG2IMqgqZ0FenhQewqhEUi1JMngS3PZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MLl+MpRZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734037104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kRj+ZKboWMPdKrxeR9Iv35SSS+uueJYsJPtH1TUGhiA=;
	b=MLl+MpRZopRQjZKUMIPk5hUeyghGu8BFOaoubO5kPimIj/3ML/g+ZLsHGY2OZTXOjeuEIB
	tcbtGjrTVh8ATvj1MfrfF1L5K6bJqhekDJYjAsQzHB+6mwL1UO6q/JZBMc2VG3rH+eVySi
	9KhJj9nAJTwJWGDt8V8BGQniTlrLLPM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-uPzYWwCeM_yTY_Y6-CZWGg-1; Thu,
 12 Dec 2024 15:58:20 -0500
X-MC-Unique: uPzYWwCeM_yTY_Y6-CZWGg-1
X-Mimecast-MFC-AGG-ID: uPzYWwCeM_yTY_Y6-CZWGg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B33531956046;
	Thu, 12 Dec 2024 20:58:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 360411956052;
	Thu, 12 Dec 2024 20:58:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] rxrpc: Disable IRQ, not BH, to take the lock for ->attend_link
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2870145.1734037095.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Dec 2024 20:58:15 +0000
Message-ID: <2870146.1734037095@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

    =

Use spin_lock_irq(), not spin_lock_bh() to take the lock when accessing th=
e
->attend_link() to stop a delay in the I/O thread due to an interrupt bein=
g
taken in the app thread whilst that holds the lock and vice versa.

Fixes: a2ea9a907260 ("rxrpc: Use irq-disabling spinlocks between app and I=
/O thread")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/io_thread.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
index 2925c7fc82cf..64f8d77b8731 100644
--- a/net/rxrpc/io_thread.c
+++ b/net/rxrpc/io_thread.c
@@ -508,9 +508,9 @@ int rxrpc_io_thread(void *data)
 		while ((conn =3D list_first_entry_or_null(&conn_attend_q,
 							struct rxrpc_connection,
 							attend_link))) {
-			spin_lock_bh(&local->lock);
+			spin_lock_irq(&local->lock);
 			list_del_init(&conn->attend_link);
-			spin_unlock_bh(&local->lock);
+			spin_unlock_irq(&local->lock);
 			rxrpc_input_conn_event(conn, NULL);
 			rxrpc_put_connection(conn, rxrpc_conn_put_poke);
 		}
@@ -527,9 +527,9 @@ int rxrpc_io_thread(void *data)
 		while ((call =3D list_first_entry_or_null(&call_attend_q,
 							struct rxrpc_call,
 							attend_link))) {
-			spin_lock_bh(&local->lock);
+			spin_lock_irq(&local->lock);
 			list_del_init(&call->attend_link);
-			spin_unlock_bh(&local->lock);
+			spin_unlock_irq(&local->lock);
 			trace_rxrpc_call_poked(call);
 			rxrpc_input_call_event(call);
 			rxrpc_put_call(call, rxrpc_call_put_poke);


