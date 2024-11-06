Return-Path: <netdev+bounces-142402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D57439BED2B
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 14:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1EC286133
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 13:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B231F81A6;
	Wed,  6 Nov 2024 13:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/hbWg1U"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAA81F429C
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 13:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898213; cv=none; b=sGXxIRPk6+MztSl0kbhZ3qmhIU69HFTMCqOCYdEff1HO4KE/FKXCs1yd8acgbm9Yl65SMvV/YkfbdxNuUyIb6heKZfTShjd/MtkDbBlrr4c0OqPq6CXeufPDzEzJ4SF0PDWouLt2icGW2Oy+lt9qLWt7vsmnZYfnxdVdx0xl3ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898213; c=relaxed/simple;
	bh=GyHaXBpas0Jk5Yxydrz5kNdf95Ahw0pvB2pioizFJF8=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=M40fh4ymETzi+EB3nfoxAgAxIQIu2eZv4TDzICCsSMdR55GFPBXxQgoqQ48GtkW5iLaTkxgx5kwx4kApG/cv5sPNwmkkuDg6jm5YnqRnZ49FTAIgc5MOXwijAjsAvSGPeCJNm/eN+NZnFohQ5YR5VG5aHR0dWFutOG408gsEX68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/hbWg1U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730898210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fxGSqNGg1Goa58e13x+V5i9uNNuZ+24Z3hxIk+gVXhQ=;
	b=d/hbWg1UWd2KGHHnfH0BTTEAYDJcuO+v3L5ZK+GBg7cDdHRPkj+ngpgIK/bLr1nM4ZNgcB
	XuXjTFsgUg+3NJy3OycJSqnPhsbP67uyHgwrlGVaqFwXeVEHDiw6wtUzYnY5qAdWGpbJSU
	TgUHBFjNWNYv7dEmcVe4VsBhh0SYwQc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-OQPL5yXXMMuRWECWD_vg7g-1; Wed,
 06 Nov 2024 08:03:27 -0500
X-MC-Unique: OQPL5yXXMMuRWECWD_vg7g-1
X-Mimecast-MFC-AGG-ID: OQPL5yXXMMuRWECWD_vg7g
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D7B681955EAC;
	Wed,  6 Nov 2024 13:03:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.231])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 54E5F195605A;
	Wed,  6 Nov 2024 13:03:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] rxrpc: Fix missing locking causing hanging calls
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <726659.1730898202.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Nov 2024 13:03:22 +0000
Message-ID: <726660.1730898202@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

If a call gets aborted (e.g. because kafs saw a signal) between it being
queued for connection and the I/O thread picking up the call, the abort
will be prioritised over the connection and it will be removed from
local->new_client_calls by rxrpc_disconnect_client_call() without a lock
being held.  This may cause other calls on the list to disappear if a race
occurs.

Fix this by taking the client_call_lock when removing a call from whatever
list its ->wait_link happens to be on.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h |    1 +
 net/rxrpc/conn_client.c      |    4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index c2f087e90fbe..d03e0bd8c028 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -287,6 +287,7 @@
 	EM(rxrpc_call_see_input,		"SEE input   ") \
 	EM(rxrpc_call_see_release,		"SEE release ") \
 	EM(rxrpc_call_see_userid_exists,	"SEE u-exists") \
+	EM(rxrpc_call_see_waiting_call,		"SEE q-conn  ") \
 	E_(rxrpc_call_see_zap,			"SEE zap     ")
 =

 #define rxrpc_txqueue_traces \
diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index d25bf1cf3670..bb11e8289d6d 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -516,6 +516,7 @@ void rxrpc_connect_client_calls(struct rxrpc_local *lo=
cal)
 =

 		spin_lock(&local->client_call_lock);
 		list_move_tail(&call->wait_link, &bundle->waiting_calls);
+		rxrpc_see_call(call, rxrpc_call_see_waiting_call);
 		spin_unlock(&local->client_call_lock);
 =

 		if (rxrpc_bundle_has_space(bundle))
@@ -586,7 +587,10 @@ void rxrpc_disconnect_client_call(struct rxrpc_bundle=
 *bundle, struct rxrpc_call
 		_debug("call is waiting");
 		ASSERTCMP(call->call_id, =3D=3D, 0);
 		ASSERT(!test_bit(RXRPC_CALL_EXPOSED, &call->flags));
+		/* May still be on ->new_client_calls. */
+		spin_lock(&local->client_call_lock);
 		list_del_init(&call->wait_link);
+		spin_unlock(&local->client_call_lock);
 		return;
 	}
 =


