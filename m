Return-Path: <netdev+bounces-58731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2893817EBE
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 01:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84902B210C0
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 00:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166CF179;
	Tue, 19 Dec 2023 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jdjl65W0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A197F
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 00:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702945371; x=1734481371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xRXDoltiQ/+N2mEMzmTdKr1lN0Ak8f8hLmRIZJ6TYKs=;
  b=jdjl65W0ipNw5CxqRsoUw/z2TTZj2WP/49EyF4PDnd0pEQJrLtt352+j
   WLCDlnJhJWCgFGgEYgfDc0ah4i77dCCvDDIUnnmXClTgKtffpF7j4vo6X
   y0N2e1JfvJDog8LgJ1v+kKCZPXRGbdFohuh+h0ysHLuU8GDfPaN/PkWYb
   M=;
X-IronPort-AV: E=Sophos;i="6.04,286,1695686400"; 
   d="scan'208";a="260970622"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-00fceed5.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:22:49 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-00fceed5.us-east-1.amazon.com (Postfix) with ESMTPS id 95EF7A09C9;
	Tue, 19 Dec 2023 00:22:46 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:32080]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.236:2525] with esmtp (Farcaster)
 id 254c7455-5fbb-4dd0-86b9-2aefd3cef45e; Tue, 19 Dec 2023 00:22:45 +0000 (UTC)
X-Farcaster-Flow-ID: 254c7455-5fbb-4dd0-86b9-2aefd3cef45e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 00:22:44 +0000
Received: from 88665a182662.ant.amazon.com (10.118.248.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 00:22:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v2 net-next 09/12] tcp: Check hlist_empty(&tb->bhash2) instead of hlist_empty(&tb->owners).
Date: Tue, 19 Dec 2023 09:18:30 +0900
Message-ID: <20231219001833.10122-10-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231219001833.10122-1-kuniyu@amazon.com>
References: <20231219001833.10122-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
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
index a31f302c4cc0..1bd13dcd45ae 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -474,7 +474,7 @@ void inet_csk_update_fastreuse(struct inet_bind_bucket *tb,
 	kuid_t uid = sock_i_uid(sk);
 	bool reuse = sk->sk_reuse && sk->sk_state != TCP_LISTEN;
 
-	if (hlist_empty(&tb->owners)) {
+	if (hlist_empty(&tb->bhash2)) {
 		tb->fastreuse = reuse;
 		if (sk->sk_reuseport) {
 			tb->fastreuseport = FASTREUSEPORT_ANY;
@@ -566,7 +566,7 @@ int inet_csk_get_port(struct sock *sk, unsigned short snum)
 	}
 
 	if (!found_port) {
-		if (!hlist_empty(&tb->owners)) {
+		if (!hlist_empty(&tb->bhash2)) {
 			if (sk->sk_reuse == SK_FORCE_REUSE ||
 			    (tb->fastreuse > 0 && reuse) ||
 			    sk_reuseport_match(tb, sk))
@@ -608,11 +608,10 @@ int inet_csk_get_port(struct sock *sk, unsigned short snum)
 
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
index 7dc33dd1ba35..355cc6c0eaab 100644
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
 
@@ -1062,7 +1062,7 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
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


