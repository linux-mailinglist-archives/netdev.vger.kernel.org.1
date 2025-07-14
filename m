Return-Path: <netdev+bounces-206758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF665B044F3
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5953C1A6196C
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AB825B1F4;
	Mon, 14 Jul 2025 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Gtb1v+Xo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B615725DD0B
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509012; cv=none; b=i6ACbLomMdU+D4SPfqpl7QGzvyv6vLEc6wHOcl2i6aZamfPpCZ+T10KhkSM7wVCa8CZQZqEfCBZTEx+SrMHnsEFz3GJkCjW4QnSclrgKNu3xBczd7fYE9WZivvnnU/PGnisSDtDkEpgD4f2xDgC/hpOTWpEMqPFB/GnZdcdaThg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509012; c=relaxed/simple;
	bh=PeoBQc7xNAn3HpGC8G88cf5x27FsEP+R1j1+J2zuN9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ix2TQhrpnYG7rYUugyZzu8goFsq84Eg7ZAdGXaS0SVzXqNa906cDsQZyHg4EIz5SIPXnSuQkUV4xFF6ADra7njLaL2Y40s8g1PMiyqkAIzdKjVc3cQWrx/EkyTgR9xlbZuaj3syYZgD1c3v8FVA50ZQqiEMoPi1VOf2eHRe/vjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Gtb1v+Xo; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-553d2eb03a0so6029190e87.1
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 09:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752509008; x=1753113808; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BxMO7ayDZ37VoeC5NRuu9zH154DiD9Kk1GFtfXrbV4E=;
        b=Gtb1v+XowKfe3E/bOWCKzxcpcnKQILJL+HknEUtsM6uqta4LeTeBUusOWFNcUEMNNx
         IDLX+0hLEPEaldt45ABaFa3W27/bddyhsm8H9xn6zoqj9eV/ppxG6I6w3ZBQoFGNzawt
         A5Ss8994aoT94SUQX8tO4V5FPwY8L8ngAIOs0F3+PrmN/z9YK4pQ+2ExvnobKc74wqmh
         jQGQ0/+cuZqASMiPS0Vgv5jbkVaawzT70TOh4dloKwBbZ0qmxKVtqtRv3hkm3+IA8wn5
         kmJC/LPUcQ5l3Sb+nYoM/uzJ8aKYYL847htflfvV2PxtVWJVGSf2RGAD1BTU9YpPfqJx
         NXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752509008; x=1753113808;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxMO7ayDZ37VoeC5NRuu9zH154DiD9Kk1GFtfXrbV4E=;
        b=Z/xJ1ui5RcaJulvBHan+HlzOEC5/asQ9JVrXehax03JIr6a887cCFuxG6pt7GSQOfR
         qbJdwBSwgLREAz1V2kI+jRviKWypop9TGzRjPoQjPBaLA3kJCVGMdc45JPztE4T6iKR9
         JSXyz7qeoFFi+0D8FKGN6d/s0rc3rtVu6EjlEXNtE9/yMpYpRF8VSRsYRv9wOPuSLUfL
         AwId8XbIEH/iGSGDXB9LvgDxJvg/HYwCDBv0ch8p6U3KXSvKABjH/wnHa5I65V1QTSLj
         2564torTytKostqjNqPiy3DF1acDuOnnux/CIB+OaapuFFtGUzOKys8tSvLhsBQwNDqW
         8wmQ==
X-Gm-Message-State: AOJu0Yz/AgyHfzHeN1LDHkFWr+jQUIu7I6/jzJNwm7HiFjrPPcppsv39
	k0sAuc7RhwgsvZjLAplZtoYWCaVE/Fyl3YyjQv2f9m0m6nO83uhJgvHm/Cq1e9wgDu0hz8lSs0w
	zLIC8
X-Gm-Gg: ASbGncvaY8mHEqyXvG/4mcBH0D/oNSwBeFbi5hSu+YbDi1w03hjugh2y1xLdWjftuhZ
	wb0dVjuEsW9qEshXusEkCmMWJ9quRoHt2YrwZ75DTHyYFisJcETv8JRQj1Re1u2t1z8a8OhV8B2
	a66+K3dqSbPEh/KFwvY3KmxaEmsYUsKSFtubsyVRSiWWKgxYk6Q8HQ3GLvsy580rISv/Hbv+1U3
	s3/66V0F54neB/fAPrbmCQSoA5Tli2U4hlwzyBv+ObHzWXYsbIQ4l4Cs3iTiHk/sEyb6PtpUSn5
	SDSg3e+EAGSSz06uH4TAknzhldqRi/Jv0LqOoBEEe7J6HJBqIpkLPBhn90DCAu4/6fZbnBTOc0u
	4cadJkeCQFGNPbUeSv22dXAQpFQZlU4ZV4Bjt7gqWj5JldJxFWehrVC24Rlxsfrb18Nt4
X-Google-Smtp-Source: AGHT+IH5kSkhfpLbw2vBoaqLLoiQ6H10T7dmX2IwXRU8M8bLMzOapqffl7/apLwGkfa+0wv0xGv20g==
X-Received: by 2002:a05:6512:23f0:b0:553:2411:b4fc with SMTP id 2adb3069b0e04-55a1c45621amr39688e87.10.1752509008067;
        Mon, 14 Jul 2025 09:03:28 -0700 (PDT)
Received: from cloudflare.com (79.184.150.73.ipv4.supernova.orange.pl. [79.184.150.73])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c9d0f56sm1991928e87.102.2025.07.14.09.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 09:03:27 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 14 Jul 2025 18:03:04 +0200
Subject: [PATCH net-next v3 1/3] tcp: Add RCU management to
 inet_bind2_bucket
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-connect-port-search-harder-v3-1-b1a41f249865@cloudflare.com>
References: <20250714-connect-port-search-harder-v3-0-b1a41f249865@cloudflare.com>
In-Reply-To: <20250714-connect-port-search-harder-v3-0-b1a41f249865@cloudflare.com>
To: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Add RCU protection to inet_bind2_bucket structure akin to commit
d186f405fdf4 ("tcp: add RCU management to inet_bind_bucket").

This prepares us for walking (struct inet_bind_bucket *)->bhash2 list
without holding inet_bind_hashbucket spinlock.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/net/inet_hashtables.h    |  4 ++--
 include/net/inet_timewait_sock.h |  3 +--
 net/ipv4/inet_connection_sock.c  |  2 +-
 net/ipv4/inet_hashtables.c       | 16 ++++++++--------
 net/ipv4/inet_timewait_sock.c    |  8 +++-----
 5 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 19dbd9081d5a..a2ff18eea990 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -108,6 +108,7 @@ struct inet_bind2_bucket {
 	struct hlist_node	bhash_node;
 	/* List of sockets hashed to this bucket */
 	struct hlist_head	owners;
+	struct rcu_head         rcu;
 };
 
 static inline struct net *ib_net(const struct inet_bind_bucket *ib)
@@ -228,8 +229,7 @@ inet_bind2_bucket_create(struct kmem_cache *cachep, struct net *net,
 			 struct inet_bind_bucket *tb,
 			 const struct sock *sk);
 
-void inet_bind2_bucket_destroy(struct kmem_cache *cachep,
-			       struct inet_bind2_bucket *tb);
+void inet_bind2_bucket_destroy(struct inet_bind2_bucket *tb);
 
 struct inet_bind2_bucket *
 inet_bind2_bucket_find(const struct inet_bind_hashbucket *head,
diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
index 67a313575780..4f4e96b10cf3 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -92,8 +92,7 @@ static inline struct inet_timewait_sock *inet_twsk(const struct sock *sk)
 void inet_twsk_free(struct inet_timewait_sock *tw);
 void inet_twsk_put(struct inet_timewait_sock *tw);
 
-void inet_twsk_bind_unhash(struct inet_timewait_sock *tw,
-			   struct inet_hashinfo *hashinfo);
+void inet_twsk_bind_unhash(struct inet_timewait_sock *tw);
 
 struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
 					   struct inet_timewait_death_row *dr,
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 1e2df51427fe..f58b93d3fa0e 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -593,7 +593,7 @@ int inet_csk_get_port(struct sock *sk, unsigned short snum)
 fail_unlock:
 	if (ret) {
 		if (bhash2_created)
-			inet_bind2_bucket_destroy(hinfo->bind2_bucket_cachep, tb2);
+			inet_bind2_bucket_destroy(tb2);
 		if (bhash_created)
 			inet_bind_bucket_destroy(tb);
 	}
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index ceeeec9b7290..d3ce6d0a514e 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -123,7 +123,7 @@ static void inet_bind2_bucket_init(struct inet_bind2_bucket *tb2,
 #endif
 	INIT_HLIST_HEAD(&tb2->owners);
 	hlist_add_head(&tb2->node, &head->chain);
-	hlist_add_head(&tb2->bhash_node, &tb->bhash2);
+	hlist_add_head_rcu(&tb2->bhash_node, &tb->bhash2);
 }
 
 struct inet_bind2_bucket *inet_bind2_bucket_create(struct kmem_cache *cachep,
@@ -141,12 +141,12 @@ struct inet_bind2_bucket *inet_bind2_bucket_create(struct kmem_cache *cachep,
 }
 
 /* Caller must hold hashbucket lock for this tb with local BH disabled */
-void inet_bind2_bucket_destroy(struct kmem_cache *cachep, struct inet_bind2_bucket *tb)
+void inet_bind2_bucket_destroy(struct inet_bind2_bucket *tb)
 {
 	if (hlist_empty(&tb->owners)) {
 		__hlist_del(&tb->node);
-		__hlist_del(&tb->bhash_node);
-		kmem_cache_free(cachep, tb);
+		hlist_del_rcu(&tb->bhash_node);
+		kfree_rcu(tb, rcu);
 	}
 }
 
@@ -198,7 +198,7 @@ static void __inet_put_port(struct sock *sk)
 
 		__sk_del_bind_node(sk);
 		inet_csk(sk)->icsk_bind2_hash = NULL;
-		inet_bind2_bucket_destroy(hashinfo->bind2_bucket_cachep, tb2);
+		inet_bind2_bucket_destroy(tb2);
 	}
 	spin_unlock(&head2->lock);
 
@@ -951,7 +951,7 @@ static int __inet_bhash2_update_saddr(struct sock *sk, void *saddr, int family,
 
 	spin_lock(&head2->lock);
 	__sk_del_bind_node(sk);
-	inet_bind2_bucket_destroy(hinfo->bind2_bucket_cachep, inet_csk(sk)->icsk_bind2_hash);
+	inet_bind2_bucket_destroy(inet_csk(sk)->icsk_bind2_hash);
 	spin_unlock(&head2->lock);
 
 	if (reset)
@@ -1154,7 +1154,7 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 		inet_ehash_nolisten(sk, (struct sock *)tw, NULL);
 	}
 	if (tw)
-		inet_twsk_bind_unhash(tw, hinfo);
+		inet_twsk_bind_unhash(tw);
 
 	spin_unlock(&head2->lock);
 	spin_unlock(&head->lock);
@@ -1179,7 +1179,7 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 		inet_sk(sk)->inet_num = 0;
 
 		if (tw)
-			inet_twsk_bind_unhash(tw, hinfo);
+			inet_twsk_bind_unhash(tw);
 	}
 
 	spin_unlock(&head2->lock);
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 875ff923a8ed..ff286b179f4a 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -20,14 +20,12 @@
 /**
  *	inet_twsk_bind_unhash - unhash a timewait socket from bind hash
  *	@tw: timewait socket
- *	@hashinfo: hashinfo pointer
  *
  *	unhash a timewait socket from bind hash, if hashed.
  *	bind hash lock must be held by caller.
  *	Returns 1 if caller should call inet_twsk_put() after lock release.
  */
-void inet_twsk_bind_unhash(struct inet_timewait_sock *tw,
-			  struct inet_hashinfo *hashinfo)
+void inet_twsk_bind_unhash(struct inet_timewait_sock *tw)
 {
 	struct inet_bind2_bucket *tb2 = tw->tw_tb2;
 	struct inet_bind_bucket *tb = tw->tw_tb;
@@ -38,7 +36,7 @@ void inet_twsk_bind_unhash(struct inet_timewait_sock *tw,
 	__sk_del_bind_node((struct sock *)tw);
 	tw->tw_tb = NULL;
 	tw->tw_tb2 = NULL;
-	inet_bind2_bucket_destroy(hashinfo->bind2_bucket_cachep, tb2);
+	inet_bind2_bucket_destroy(tb2);
 	inet_bind_bucket_destroy(tb);
 
 	__sock_put((struct sock *)tw);
@@ -63,7 +61,7 @@ static void inet_twsk_kill(struct inet_timewait_sock *tw)
 
 	spin_lock(&bhead->lock);
 	spin_lock(&bhead2->lock);
-	inet_twsk_bind_unhash(tw, hashinfo);
+	inet_twsk_bind_unhash(tw);
 	spin_unlock(&bhead2->lock);
 	spin_unlock(&bhead->lock);
 

-- 
2.43.0


