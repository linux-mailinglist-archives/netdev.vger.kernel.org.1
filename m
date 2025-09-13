Return-Path: <netdev+bounces-222775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A20D2B55FFD
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 12:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5010E583432
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 10:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7632EB854;
	Sat, 13 Sep 2025 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bE394QEZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D6A2EA480
	for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757758181; cv=none; b=Z6eOgc7ZNtrLoMJGG4j3VRWaCxVbEhz+0qdX8b+QuiBOZCyZRKNyRyXXxTSgZqps3WHc2dZozlgQCxYtmwQJM6HI6inao6K3ozTYvTiyelklZN+elusadZkDmkTdV1kLOWiMaaarq/I3oT1MvUOesxL5McZi1vGjyui1TR5qPUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757758181; c=relaxed/simple;
	bh=tDdjxRfgXwjksEeByBYSrsGAJuOPopxNUZN4i7OzOj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QXCvlSN2Rjv/qg3ZSW8fbLgx15XCI6Y11C2/nIU5+c1jKaodWRVI2hPCanKD+qpRrYhUSCMqnPjS70sdbjMaBghMnyhgR3RTJEMXTB15fV+hBixkskc7bGPlaDzFzd79pqPSKXs8yTpqzISdTOkMW1AHtyDQJ00PF8yvbt767Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=bE394QEZ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b07d4d24d09so177508066b.2
        for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 03:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1757758178; x=1758362978; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HeRMTlI6rMVrbJ/ccMJs9Nq54RjuO/FIb179bmSY7YM=;
        b=bE394QEZ7gk9zRKaaWHT5WOu/42SF+r1enmBCipSQ/gp+aNwBbUhii/3CVT/QwyNKc
         JNgDnGJX42eG5tVcozs2y4B6gsbE1gVyxxk5E5ejB3gn5BxrOs+6bwW6JahOYCKxt8Ra
         kh3BYTM8ApbslXnGyYg2lZE5eJVFuPad+dJnLe4TA5/fWPuX3En2nflo57ySKwWT3a0f
         hNCRpBpFpTCVDz6oi4T/JzTCxQCEN0XMceffHcT/nZcsU9W/VkOA+aewyywLgd61fX0s
         7FcGu65Fz4qabPjGpBVFexOtGtGNKXlxLuB0SW8DR56CDpyHuMNwDcT1h8UKfBmJQh8k
         Ko3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757758178; x=1758362978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HeRMTlI6rMVrbJ/ccMJs9Nq54RjuO/FIb179bmSY7YM=;
        b=Xs6soq01MxLrJGP20rtCxidUyKcZv/w9nXO9Dfezxze+QYqN/Oq36Nlt+tK4fPBhST
         Hm5Oqzdu1BLumRF38rQSoyr/tYLPSv7yHqhY190f0E2i0iOgV1Bgtzvmqry9UilCmxXl
         sDXbjIoGwCdLvsXD1lcIZHs4L8HC9UCwDia4FOAjZat2P3ID/ROdQOflfx1w2G45ML48
         TLx2rTw60D63OSU9wK+W3Mmk/KBdhmKm2HNqF2DC0jCyqwJqs1q9GEn/BYh+Xuf7G1ns
         2zDTch8Wr7NXMcixEJGBwsl5aWf8Vqgy2L+m9blKmV9LsldNSm2G2gbBBXMPQqe1u+TR
         DSmA==
X-Gm-Message-State: AOJu0Yy3cjFBHc6wtAVaZ0BG3i5XFznPa7fIH8UJWPS5PP1BJzzHcJP8
	a21MKR1/n//+DY/e2uJkc8dHqHiGcKKYLd4sQf7uUyTCVA00nXVo/RNi1JJx8ZLspg8=
X-Gm-Gg: ASbGncsUK0LtHJgeqliAqcopZLyJhD8JKj37QiqilXhezoROf8/Lhq+FWWR1wzq6Oe+
	fJxetrdyWHGLrADroMzCowoGvuN6zfrF0Yl7a2O1jwWwlIyK+EwZ/K//SEZ8c6fu4RtNbJF7D7z
	D+430JtpuD+F395OLjrejdhAQmv4eARRRy0Qh8pQ7kfTIKfhic055oSiNYT3AxiWqlulQ8HpVPT
	Uts5sSFBXn3ZATixqfvs+EjGxqOWEme0EqGz8ga0EdB+bIhHxjDkS1jPf5GsgG/wattwaGc9sDl
	UC08eY9YlpWokksKYvQoXcrNEvrObxtwKToE3Z3oP5sWZiA2tov+3wrS+/28y++3kJBUCl2bp7p
	AxQncIxcFerrm2R67jreKfOENTp+bScLXyDaMKunVPNFQIzZdvooVL4hI8buPElf6DQjO
X-Google-Smtp-Source: AGHT+IFcGWDWQRljNK9F2RLHpHqrSTRNbIErfLSLVcWLymiAWCE+6rWedI+fUrGZh6C6rOKs0/aaxg==
X-Received: by 2002:a17:907:d8f:b0:b0b:6fe0:ed5e with SMTP id a640c23a62f3a-b0b6fe0f177mr62679866b.25.1757758177528;
        Sat, 13 Sep 2025 03:09:37 -0700 (PDT)
Received: from cloudflare.com (79.184.140.27.ipv4.supernova.orange.pl. [79.184.140.27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07c59a963bsm356034466b.42.2025.09.13.03.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 03:09:36 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sat, 13 Sep 2025 12:09:28 +0200
Subject: [PATCH net-next v4 1/2] tcp: Update bind bucket state on port
 release
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-update-bind-bucket-state-on-unhash-v4-1-33a567594df7@cloudflare.com>
References: <20250913-update-bind-bucket-state-on-unhash-v4-0-33a567594df7@cloudflare.com>
In-Reply-To: <20250913-update-bind-bucket-state-on-unhash-v4-0-33a567594df7@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Neal Cardwell <ncardwell@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, kernel-team@cloudflare.com, 
 Lee Valentine <lvalentine@cloudflare.com>
X-Mailer: b4 0.15-dev-07fe9

Today, once an inet_bind_bucket enters a state where fastreuse >= 0 or
fastreuseport >= 0 after a socket is explicitly bound to a port, it remains
in that state until all sockets are removed and the bucket is destroyed.

In this state, the bucket is skipped during ephemeral port selection in
connect(). For applications using a reduced ephemeral port
range (IP_LOCAL_PORT_RANGE socket option), this can cause faster port
exhaustion since blocked buckets are excluded from reuse.

The reason the bucket state isn't updated on port release is unclear.
Possibly a performance trade-off to avoid scanning bucket owners, or just
an oversight.

Fix it by recalculating the bucket state when a socket releases a port. To
limit overhead, each inet_bind2_bucket stores its own (fastreuse,
fastreuseport) state. On port release, only the relevant port-addr bucket
is scanned, and the overall state is derived from these.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/net/inet_connection_sock.h |  5 +++--
 include/net/inet_hashtables.h      |  2 ++
 include/net/inet_timewait_sock.h   |  3 ++-
 include/net/sock.h                 |  4 ++++
 net/ipv4/inet_connection_sock.c    | 12 ++++++++----
 net/ipv4/inet_hashtables.c         | 40 +++++++++++++++++++++++++++++++++++++-
 net/ipv4/inet_timewait_sock.c      |  1 +
 7 files changed, 59 insertions(+), 8 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 0737d8e178dd..b4b886647607 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -316,8 +316,9 @@ int inet_csk_listen_start(struct sock *sk);
 void inet_csk_listen_stop(struct sock *sk);
 
 /* update the fast reuse flag when adding a socket */
-void inet_csk_update_fastreuse(struct inet_bind_bucket *tb,
-			       struct sock *sk);
+void inet_csk_update_fastreuse(const struct sock *sk,
+			       struct inet_bind_bucket *tb,
+			       struct inet_bind2_bucket *tb2);
 
 struct dst_entry *inet_csk_update_pmtu(struct sock *sk, u32 mtu);
 
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index a3b32241c2f2..1875853e97a4 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -108,6 +108,8 @@ struct inet_bind2_bucket {
 	struct hlist_node	bhash_node;
 	/* List of sockets hashed to this bucket */
 	struct hlist_head	owners;
+	signed char		fastreuse;
+	signed char		fastreuseport;
 };
 
 static inline struct net *ib_net(const struct inet_bind_bucket *ib)
diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
index 67a313575780..baafef24318e 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -70,7 +70,8 @@ struct inet_timewait_sock {
 	unsigned int		tw_transparent  : 1,
 				tw_flowlabel	: 20,
 				tw_usec_ts	: 1,
-				tw_pad		: 2,	/* 2 bits hole */
+				tw_connect_bind	: 1,
+				tw_pad		: 1,	/* 1 bit hole */
 				tw_tos		: 8;
 	u32			tw_txhash;
 	u32			tw_priority;
diff --git a/include/net/sock.h b/include/net/sock.h
index 896bec2d2176..15d9fa438337 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1495,6 +1495,10 @@ static inline int __sk_prot_rehash(struct sock *sk)
 
 #define SOCK_BINDADDR_LOCK	4
 #define SOCK_BINDPORT_LOCK	8
+/**
+ * define SOCK_CONNECT_BIND - &sock->sk_userlocks flag for auto-bind at connect() time
+ */
+#define SOCK_CONNECT_BIND	16
 
 struct socket_alloc {
 	struct socket socket;
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 142ff8d86fc2..cdd1e12aac8c 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -423,7 +423,7 @@ inet_csk_find_open_port(const struct sock *sk, struct inet_bind_bucket **tb_ret,
 }
 
 static inline int sk_reuseport_match(struct inet_bind_bucket *tb,
-				     struct sock *sk)
+				     const struct sock *sk)
 {
 	if (tb->fastreuseport <= 0)
 		return 0;
@@ -453,8 +453,9 @@ static inline int sk_reuseport_match(struct inet_bind_bucket *tb,
 				    ipv6_only_sock(sk), true, false);
 }
 
-void inet_csk_update_fastreuse(struct inet_bind_bucket *tb,
-			       struct sock *sk)
+void inet_csk_update_fastreuse(const struct sock *sk,
+			       struct inet_bind_bucket *tb,
+			       struct inet_bind2_bucket *tb2)
 {
 	bool reuse = sk->sk_reuse && sk->sk_state != TCP_LISTEN;
 
@@ -501,6 +502,9 @@ void inet_csk_update_fastreuse(struct inet_bind_bucket *tb,
 			tb->fastreuseport = 0;
 		}
 	}
+
+	tb2->fastreuse = tb->fastreuse;
+	tb2->fastreuseport = tb->fastreuseport;
 }
 
 /* Obtain a reference to a local port for the given sock,
@@ -582,7 +586,7 @@ int inet_csk_get_port(struct sock *sk, unsigned short snum)
 	}
 
 success:
-	inet_csk_update_fastreuse(tb, sk);
+	inet_csk_update_fastreuse(sk, tb, tb2);
 
 	if (!inet_csk(sk)->icsk_bind_hash)
 		inet_bind_hash(sk, tb, tb2, port);
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index ef4ccfd46ff6..b9979508d5da 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -58,6 +58,14 @@ static u32 sk_ehashfn(const struct sock *sk)
 			    sk->sk_daddr, sk->sk_dport);
 }
 
+static bool sk_is_connect_bind(const struct sock *sk)
+{
+	if (sk->sk_state == TCP_TIME_WAIT)
+		return inet_twsk(sk)->tw_connect_bind;
+	else
+		return sk->sk_userlocks & SOCK_CONNECT_BIND;
+}
+
 /*
  * Allocate and initialize a new local port bind bucket.
  * The bindhash mutex for snum's hash chain must be held here.
@@ -87,10 +95,22 @@ struct inet_bind_bucket *inet_bind_bucket_create(struct kmem_cache *cachep,
  */
 void inet_bind_bucket_destroy(struct inet_bind_bucket *tb)
 {
+	const struct inet_bind2_bucket *tb2;
+
 	if (hlist_empty(&tb->bhash2)) {
 		hlist_del_rcu(&tb->node);
 		kfree_rcu(tb, rcu);
+		return;
 	}
+
+	if (tb->fastreuse == -1 && tb->fastreuseport == -1)
+		return;
+	hlist_for_each_entry(tb2, &tb->bhash2, bhash_node) {
+		if (tb2->fastreuse != -1 || tb2->fastreuseport != -1)
+			return;
+	}
+	tb->fastreuse = -1;
+	tb->fastreuseport = -1;
 }
 
 bool inet_bind_bucket_match(const struct inet_bind_bucket *tb, const struct net *net,
@@ -121,6 +141,8 @@ static void inet_bind2_bucket_init(struct inet_bind2_bucket *tb2,
 #else
 	tb2->rcv_saddr = sk->sk_rcv_saddr;
 #endif
+	tb2->fastreuse = 0;
+	tb2->fastreuseport = 0;
 	INIT_HLIST_HEAD(&tb2->owners);
 	hlist_add_head(&tb2->node, &head->chain);
 	hlist_add_head(&tb2->bhash_node, &tb->bhash2);
@@ -143,11 +165,23 @@ struct inet_bind2_bucket *inet_bind2_bucket_create(struct kmem_cache *cachep,
 /* Caller must hold hashbucket lock for this tb with local BH disabled */
 void inet_bind2_bucket_destroy(struct kmem_cache *cachep, struct inet_bind2_bucket *tb)
 {
+	const struct sock *sk;
+
 	if (hlist_empty(&tb->owners)) {
 		__hlist_del(&tb->node);
 		__hlist_del(&tb->bhash_node);
 		kmem_cache_free(cachep, tb);
+		return;
+	}
+
+	if (tb->fastreuse == -1 && tb->fastreuseport == -1)
+		return;
+	sk_for_each_bound(sk, &tb->owners) {
+		if (!sk_is_connect_bind(sk))
+			return;
 	}
+	tb->fastreuse = -1;
+	tb->fastreuseport = -1;
 }
 
 static bool inet_bind2_bucket_addr_match(const struct inet_bind2_bucket *tb2,
@@ -191,6 +225,7 @@ static void __inet_put_port(struct sock *sk)
 	tb = inet_csk(sk)->icsk_bind_hash;
 	inet_csk(sk)->icsk_bind_hash = NULL;
 	inet_sk(sk)->inet_num = 0;
+	sk->sk_userlocks &= ~SOCK_CONNECT_BIND;
 
 	spin_lock(&head2->lock);
 	if (inet_csk(sk)->icsk_bind2_hash) {
@@ -277,7 +312,7 @@ int __inet_inherit_port(const struct sock *sk, struct sock *child)
 		}
 	}
 	if (update_fastreuse)
-		inet_csk_update_fastreuse(tb, child);
+		inet_csk_update_fastreuse(child, tb, tb2);
 	inet_bind_hash(child, tb, tb2, port);
 	spin_unlock(&head2->lock);
 	spin_unlock(&head->lock);
@@ -1136,6 +1171,8 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 					       head2, tb, sk);
 		if (!tb2)
 			goto error;
+		tb2->fastreuse = -1;
+		tb2->fastreuseport = -1;
 	}
 
 	/* Here we want to add a little bit of randomness to the next source
@@ -1148,6 +1185,7 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 
 	/* Head lock still held and bh's disabled */
 	inet_bind_hash(sk, tb, tb2, port);
+	sk->sk_userlocks |= SOCK_CONNECT_BIND;
 
 	if (sk_unhashed(sk)) {
 		inet_sk(sk)->inet_sport = htons(port);
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 5b5426b8ee92..3d51f751876d 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -207,6 +207,7 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
 		tw->tw_hash	    = sk->sk_hash;
 		tw->tw_ipv6only	    = 0;
 		tw->tw_transparent  = inet_test_bit(TRANSPARENT, sk);
+		tw->tw_connect_bind = !!(sk->sk_userlocks & SOCK_CONNECT_BIND);
 		tw->tw_prot	    = sk->sk_prot_creator;
 		atomic64_set(&tw->tw_cookie, atomic64_read(&sk->sk_cookie));
 		twsk_net_set(tw, sock_net(sk));

-- 
2.43.0


