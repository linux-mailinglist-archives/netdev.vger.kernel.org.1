Return-Path: <netdev+bounces-181564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8DAA8587A
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 11:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A5A9A2DD4
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 09:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CF129B202;
	Fri, 11 Apr 2025 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMkwLd8B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F1829AAE0
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365227; cv=none; b=sG5wOOi7Le7Zt1lO+pQuj4nEV7YeyNKcJ6qkLv3FlEfoiAuHIE4+XzFZzzu0NVzdLmkjIGEUmPjdHHHBh7upf1/Mg0SKlk9bVxwSJjPY5ip00OacejWGLsiPoYt/dS32S6cYzPstaFYIoc/TRq4FL6lAcsWlO6ZET4NoiwG6enQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365227; c=relaxed/simple;
	bh=3KwKp2aD85mHffTAYEaBVdbMM9dx9pTF+DA2uQOAX9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FY44pzv8+TywH/Qg6zTJZtwM/gb9qjreQ8HsyRUU2l4PoXoExBTiPVvo74JnHM5GJOkAE91jXoSS/HeT+KLaHnJjnnc0ws1nggnargqFfVBXbJMM9SPs83JFgWoCpKhJlkoBX1gP+IpLk6kFTJzqt3+btprygNPlvW93BSFEgiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CMkwLd8B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744365223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RdWuE1dWKOPxlS+GrAPuM5JDKKMOWefIovwm76mdaQ4=;
	b=CMkwLd8BUJXpH0wsggSp/0PDdEIhAP7bYPMXP5EvI2AS9sAYcweXLQ1ckKpZZbRm2yjzE5
	HMfWnnt/LhPptR8RLIwplG7FwCMq/0FZZYMlT1JGjE53+daNkBCavhkxac6U5Iahf2uvbO
	SfqORcgtsXHGTuVuikOnPFR1OWxGpjE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-5bJU3dfSNkKiNWGFpJHhLQ-1; Fri,
 11 Apr 2025 05:53:30 -0400
X-MC-Unique: 5bJU3dfSNkKiNWGFpJHhLQ-1
X-Mimecast-MFC-AGG-ID: 5bJU3dfSNkKiNWGFpJHhLQ_1744365204
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B69781955DE9;
	Fri, 11 Apr 2025 09:53:24 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.40])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F45A1955DCE;
	Fri, 11 Apr 2025 09:53:21 +0000 (UTC)
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
Subject: [PATCH net-next v3 03/14] rxrpc: Remove some socket lock acquire/release annotations
Date: Fri, 11 Apr 2025 10:52:48 +0100
Message-ID: <20250411095303.2316168-4-dhowells@redhat.com>
In-Reply-To: <20250411095303.2316168-1-dhowells@redhat.com>
References: <20250411095303.2316168-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Remove some socket lock acquire/release annotations as lock_sock() and
release_sock() don't have them and so the checker gets confused.  Removing
all of them, however, causes warnings about "context imbalance" and "wrong
count at exit" to occur instead.

Probably lock_sock() and release_sock() should have annotations on
indicating their taking of sk_lock - there is a dep_map in socket_lock_t,
but I don't know if that matters to the static checker.

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
 net/rxrpc/ar-internal.h | 4 +++-
 net/rxrpc/call_object.c | 2 +-
 net/rxrpc/sendmsg.c     | 3 +--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 55810c6b4be8..c267b8ac1bb5 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1000,7 +1000,9 @@ struct rxrpc_call *rxrpc_alloc_call(struct rxrpc_sock *, gfp_t, unsigned int);
 struct rxrpc_call *rxrpc_new_client_call(struct rxrpc_sock *,
 					 struct rxrpc_conn_parameters *,
 					 struct rxrpc_call_params *, gfp_t,
-					 unsigned int);
+					 unsigned int)
+	__releases(&rx->sk.sk_lock)
+	__acquires(&call->user_mutex);
 void rxrpc_start_call_timer(struct rxrpc_call *call);
 void rxrpc_incoming_call(struct rxrpc_sock *, struct rxrpc_call *,
 			 struct sk_buff *);
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index c4c8b46a68c6..d48e9b021d85 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -322,7 +322,7 @@ struct rxrpc_call *rxrpc_new_client_call(struct rxrpc_sock *rx,
 					 struct rxrpc_call_params *p,
 					 gfp_t gfp,
 					 unsigned int debug_id)
-	__releases(&rx->sk.sk_lock.slock)
+	__releases(&rx->sk.sk_lock)
 	__acquires(&call->user_mutex)
 {
 	struct rxrpc_call *call, *xcall;
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 3f62c34ce7de..2342b5f1547c 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -607,7 +607,7 @@ static int rxrpc_sendmsg_cmsg(struct msghdr *msg, struct rxrpc_send_params *p)
 static struct rxrpc_call *
 rxrpc_new_client_call_for_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg,
 				  struct rxrpc_send_params *p)
-	__releases(&rx->sk.sk_lock.slock)
+	__releases(&rx->sk.sk_lock)
 	__acquires(&call->user_mutex)
 {
 	struct rxrpc_conn_parameters cp;
@@ -657,7 +657,6 @@ rxrpc_new_client_call_for_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg,
  * - the socket may be either a client socket or a server socket
  */
 int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
-	__releases(&rx->sk.sk_lock.slock)
 {
 	struct rxrpc_call *call;
 	bool dropped_lock = false;


