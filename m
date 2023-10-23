Return-Path: <netdev+bounces-43599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E397D3FD2
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 21:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54F81C209B2
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 19:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9E721A09;
	Mon, 23 Oct 2023 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dLwlR4AQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77498125B0
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 19:07:06 +0000 (UTC)
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AB7103
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 12:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1698088026; x=1729624026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dm2CL6maQg54hAEMXEXaXItAC5ul3/8L7BbUGDrvDqk=;
  b=dLwlR4AQS7FZYnRufbrigqCGBQS18gZiCsJW/Y9HGr77sHO+ZnPZTG8+
   0KxklhLCfYy38ruQSLK9ouNdP0jBsy8bcQ0wOW4CbvaDTQ/q27zlMwlLQ
   snxulfB9ylFfzyk8olL0BlyedrU/LPp3YiFjrWXvwwHKbH7ZDfQD8EGPw
   c=;
X-IronPort-AV: E=Sophos;i="6.03,246,1694736000"; 
   d="scan'208";a="611676402"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 19:07:05 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com (Postfix) with ESMTPS id 1159A48880;
	Mon, 23 Oct 2023 19:07:01 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:43231]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.136:2525] with esmtp (Farcaster)
 id b9398b82-c7f7-4103-95e6-4112af856960; Mon, 23 Oct 2023 19:07:01 +0000 (UTC)
X-Farcaster-Flow-ID: b9398b82-c7f7-4103-95e6-4112af856960
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 23 Oct 2023 19:06:49 +0000
Received: from 88665a182662.ant.amazon.com (10.119.77.134) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.39;
 Mon, 23 Oct 2023 19:06:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Coco Li <lixiaoyan@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 09/12] tcp: Check hlist_empty(&tb->bhash2) instead of hlist_empty(&tb->owners).
Date: Mon, 23 Oct 2023 12:02:52 -0700
Message-ID: <20231023190255.39190-10-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231023190255.39190-1-kuniyu@amazon.com>
References: <20231023190255.39190-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.119.77.134]
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

We use hlist_empty(&tb->owners) to check if the bhash bucket has a socket.
We can check the child bhash2 buckets instead.

For this to work, the bhash2 bucket must be freed before the bhash bucket.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/inet_connection_sock.c | 9 ++++-----
 net/ipv4/inet_hashtables.c      | 6 +++---
 net/ipv4/inet_timewait_sock.c   | 2 +-
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index c23968477725..4d4c3a0d8c20 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -472,7 +472,7 @@ void inet_csk_update_fastreuse(struct inet_bind_bucket *tb,
 	kuid_t uid = sock_i_uid(sk);
 	bool reuse = sk->sk_reuse && sk->sk_state != TCP_LISTEN;
 
-	if (hlist_empty(&tb->owners)) {
+	if (hlist_empty(&tb->bhash2)) {
 		tb->fastreuse = reuse;
 		if (sk->sk_reuseport) {
 			tb->fastreuseport = FASTREUSEPORT_ANY;
@@ -564,7 +564,7 @@ int inet_csk_get_port(struct sock *sk, unsigned short snum)
 	}
 
 	if (!found_port) {
-		if (!hlist_empty(&tb->owners)) {
+		if (!hlist_empty(&tb->bhash2)) {
 			if (sk->sk_reuse == SK_FORCE_REUSE ||
 			    (tb->fastreuse > 0 && reuse) ||
 			    sk_reuseport_match(tb, sk))
@@ -606,11 +606,10 @@ int inet_csk_get_port(struct sock *sk, unsigned short snum)
 
 fail_unlock:
 	if (ret) {
+		if (bhash2_created)
+			inet_bind2_bucket_destroy(hinfo->bind2_bucket_cachep, tb2);
 		if (bhash_created)
 			inet_bind_bucket_destroy(hinfo->bind_bucket_cachep, tb);
-		if (bhash2_created)
-			inet_bind2_bucket_destroy(hinfo->bind2_bucket_cachep,
-						  tb2);
 	}
 	if (head2_lock_acquired)
 		spin_unlock(&head2->lock);
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 7a2e5f4bd8e3..72a0767e95d3 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -88,7 +88,7 @@ struct inet_bind_bucket *inet_bind_bucket_create(struct kmem_cache *cachep,
  */
 void inet_bind_bucket_destroy(struct kmem_cache *cachep, struct inet_bind_bucket *tb)
 {
-	if (hlist_empty(&tb->owners)) {
+	if (hlist_empty(&tb->bhash2)) {
 		__hlist_del(&tb->node);
 		kmem_cache_free(cachep, tb);
 	}
@@ -195,7 +195,6 @@ static void __inet_put_port(struct sock *sk)
 	__sk_del_bind_node(sk);
 	inet_csk(sk)->icsk_bind_hash = NULL;
 	inet_sk(sk)->inet_num = 0;
-	inet_bind_bucket_destroy(hashinfo->bind_bucket_cachep, tb);
 
 	spin_lock(&head2->lock);
 	if (inet_csk(sk)->icsk_bind2_hash) {
@@ -207,6 +206,7 @@ static void __inet_put_port(struct sock *sk)
 	}
 	spin_unlock(&head2->lock);
 
+	inet_bind_bucket_destroy(hashinfo->bind_bucket_cachep, tb);
 	spin_unlock(&head->lock);
 }
 
@@ -1058,7 +1058,7 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 				if (tb->fastreuse >= 0 ||
 				    tb->fastreuseport >= 0)
 					goto next_port;
-				WARN_ON(hlist_empty(&tb->owners));
+				WARN_ON(hlist_empty(&tb->bhash2));
 				if (!check_established(death_row, sk,
 						       port, &tw))
 					goto ok;
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index dd37a5bf6881..466d4faa9272 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -37,11 +37,11 @@ void inet_twsk_bind_unhash(struct inet_timewait_sock *tw,
 
 	__hlist_del(&tw->tw_bind_node);
 	tw->tw_tb = NULL;
-	inet_bind_bucket_destroy(hashinfo->bind_bucket_cachep, tb);
 
 	__hlist_del(&tw->tw_bind2_node);
 	tw->tw_tb2 = NULL;
 	inet_bind2_bucket_destroy(hashinfo->bind2_bucket_cachep, tb2);
+	inet_bind_bucket_destroy(hashinfo->bind_bucket_cachep, tb);
 
 	__sock_put((struct sock *)tw);
 }
-- 
2.30.2


