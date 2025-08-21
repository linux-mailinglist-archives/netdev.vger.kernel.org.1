Return-Path: <netdev+bounces-215590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE85CB2F5F7
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 13:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07F8725A2D
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 11:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B0630DD34;
	Thu, 21 Aug 2025 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZxWNQkFU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620BE30C35C
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 11:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774568; cv=none; b=Tg3uAx+yg+mpi4HqkEvW/fUhvKT0I/3XJ+QvRAkNYcx6cVqLoeocEXX5MdfZ1oYp8DLmduj8UcWyedsrCLMSMvjmsFf1wXGQ6ivilGUT5B6B8+AvQagmceTajujq9BaTNMBsAaaGragVlxk3HKZLoa4u6MFt8vMUJmdcJJSAvCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774568; c=relaxed/simple;
	bh=Q/DyA1ItHshEg8mIVqeQm+V40Slxa2R/6ZAOuLTOEzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X/t5cTv7ChmH+lBdYidd78RnJsz6mtJwN3NcjwKc7ZJRgNWjOjt4vEwAuf7kSzc9/TSIippOAHWs07Izv0BBurCBtSMXTCgQWdX4ZHKrNfF8pzmGeFdJ0hcok3zRjS+RhBSngcaf1+NVsJQvtt03BALr/p2ZScsr3/lepAqg+68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ZxWNQkFU; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-618aea78f23so1364027a12.3
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 04:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755774565; x=1756379365; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5E6/j74OpTDmjMorcrVobBG6dni1S1ddoW74xpmNFxY=;
        b=ZxWNQkFUhOLdHM4UTRLetpdJvm6C5Lxv1mIECyccAojtk+ldPP2BAWsp1xJlinvNe+
         A6WGBZCT8x8e+JhvuzdWcYqySJVA4g4cbFGocNR3lO/c9x/8WTvuS3M2dgh8TogPD+BE
         0/qMfGLSaQ/c3+Eu3njHEM8H/wPXyITSP6uNUpSqR+EUlVhvJ6npAsamjcpPfbQR4OkM
         qA7dEfnqO4FP0JG3HEqQ6Eee47vJiItzrIyl8+ffAT/5NYOvc6F4y1KlMXzrEneLmG2X
         sU1IB3skchO0xhaQMT3wHQgrb8UPsU51uTLmCEt+wCsXGYcn6q4VN72n0BL86CZKRdSH
         sWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755774565; x=1756379365;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5E6/j74OpTDmjMorcrVobBG6dni1S1ddoW74xpmNFxY=;
        b=D3NaIFKQASbmZurzs0fB5qrfsUPPC2y16zZBBc70O60focpjui4kwgJ8LDNKyiQFLi
         GTDNbIjLfgD+dXRH69ImpoQNfglilu6uud6c9zNy7vVnDtuNQ3IG99QwwX+Kjoynqq9Y
         gldXIHIzGXKK9erpG67QL2wEzOCC0i4YbE3r/hzp6Mi+9hHZzTXR5OJAgFc6b1cpZbuO
         UWL1F1nCHB/i/c7PhrEW9XDKkzF45ITJFQnM2sBa81phIPlg5UfrPuO+L1B9oUcHTBtP
         KrQM6UENHtXjBoPG7x0VBis0BRQEdU72EAY97Ak6fc17jxHA8fJWL0z53rY5g0vkxDc/
         tR8g==
X-Gm-Message-State: AOJu0YwWR+F921gyx/YSCV4S+vPx9mkl/bDMaIHT2BR+KybMEUQ08+/U
	XJOSYzlUrAzIERm4A/Ty6bUZLaNHIvpXyNzT6LWXzFHH9hkCF839EcmcI6NCwVn/2eA=
X-Gm-Gg: ASbGncv+SjBgA9FSIBD1WNEQvcVIrKJXjD7xvgBtQ/3LWiptP9q/3+2mEoagCuHPGTn
	FepHsutnOYJa6/RoIGq1hRhqc+t66EJYgFphhhJd1Ewa7rEsBLgCcvtrdlB6wUa5FK1PboOqcXF
	G0thVW6bWgRZtYTSl7+wosVEdcIvKAX0GhqRbZYWxtlThefSEM13qXrYl9pRo2/4KC7NyJYzvuG
	kscRPVHwDt1dygOsbA8oR/ppdC8YHk3tgOcICbBc8tdXJnKJ/dDqVUNy9aKBE07BCT2SJdeu9h3
	2DVoopLjewkpQRg3gCxsLTIYmK+C0GgwYs0RWItwkzSiC4qm4RYscuCj/RP5CD3g0ybBPBAnP6K
	xXcv+EIrtB0bxwhSvr0Ad9w9bVeQVaecsrXaMvlFFSitebyUGjvhl2SfeQXMf3Rg+sB+y
X-Google-Smtp-Source: AGHT+IFyS7V0zd674K3zsAcpD33n2ICo0/AR2KEGbfIDDRINN4lf9DYz6blYQhFzrTfXFswiaLR8BA==
X-Received: by 2002:a05:6402:254e:b0:618:1cd9:4af2 with SMTP id 4fb4d7f45d1cf-61bf8726f96mr1683189a12.22.1755774564577;
        Thu, 21 Aug 2025 04:09:24 -0700 (PDT)
Received: from cloudflare.com (79.191.55.218.ipv4.supernova.orange.pl. [79.191.55.218])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a755d9cbfsm5052992a12.12.2025.08.21.04.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 04:09:22 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 21 Aug 2025 13:09:14 +0200
Subject: [PATCH net-next v2 1/2] tcp: Update bind bucket state on port
 release
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-update-bind-bucket-state-on-unhash-v2-1-0c204543a522@cloudflare.com>
References: <20250821-update-bind-bucket-state-on-unhash-v2-0-0c204543a522@cloudflare.com>
In-Reply-To: <20250821-update-bind-bucket-state-on-unhash-v2-0-0c204543a522@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Neal Cardwell <ncardwell@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, kernel-team@cloudflare.com, 
 Lee Valentine <lvalentine@cloudflare.com>
X-Mailer: b4 0.15-dev-07fe9

Currently, when an inet_bind_bucket enters a state where fastreuse >= 0 or
fastreuseport >= 0, after a socket explicitly binds to a port, it stays in
that state until all associated sockets are removed and the bucket is
destroyed.

In this state, the bucket is skipped during ephemeral port selection in
connect(). For applications using a small ephemeral port range (via
IP_LOCAL_PORT_RANGE option), this can lead to quicker port exhaustion
because "blocked" buckets remain excluded from reuse.

The reason for not updating the bucket state on port release is unclear. It
may have been a performance trade-off to avoid scanning bucket owners, or
simply an oversight.

Address it by recalculating the bind bucket state when a socket releases a
port. To minimize overhead, use a divide-and-conquer strategy: duplicate
the (fastreuse, fastreuseport) state in each inet_bind2_bucket. On port
release, we only need to scan the relevant port-addr bucket, and the
overall port bucket state can be derived from those.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/net/inet_connection_sock.h |  5 +++--
 include/net/inet_hashtables.h      |  2 ++
 include/net/inet_sock.h            |  2 ++
 include/net/inet_timewait_sock.h   |  3 ++-
 include/net/tcp.h                  | 15 +++++++++++++++
 net/ipv4/inet_connection_sock.c    | 12 ++++++++----
 net/ipv4/inet_hashtables.c         | 32 +++++++++++++++++++++++++++++++-
 net/ipv4/inet_timewait_sock.c      |  1 +
 8 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 1735db332aab..072347f16483 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -322,8 +322,9 @@ int inet_csk_listen_start(struct sock *sk);
 void inet_csk_listen_stop(struct sock *sk);
 
 /* update the fast reuse flag when adding a socket */
-void inet_csk_update_fastreuse(struct inet_bind_bucket *tb,
-			       struct sock *sk);
+void inet_csk_update_fastreuse(const struct sock *sk,
+			       struct inet_bind_bucket *tb,
+			       struct inet_bind2_bucket *tb2);
 
 struct dst_entry *inet_csk_update_pmtu(struct sock *sk, u32 mtu);
 
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 19dbd9081d5a..d6676746dabf 100644
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
diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 1086256549fa..9614d0430471 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -279,6 +279,8 @@ enum {
 	INET_FLAGS_RTALERT_ISOLATE = 28,
 	INET_FLAGS_SNDFLOW	= 29,
 	INET_FLAGS_RTALERT	= 30,
+	/* socket bound to a port at connect() time */
+	INET_FLAGS_AUTOBIND	= 31,
 };
 
 /* cmsg flags for inet */
diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
index 67a313575780..ec99176d576f 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -70,7 +70,8 @@ struct inet_timewait_sock {
 	unsigned int		tw_transparent  : 1,
 				tw_flowlabel	: 20,
 				tw_usec_ts	: 1,
-				tw_pad		: 2,	/* 2 bits hole */
+				tw_autobind	: 1,
+				tw_pad		: 1,	/* 1 bit hole */
 				tw_tos		: 8;
 	u32			tw_txhash;
 	u32			tw_priority;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2936b8175950..c4bb6e56a668 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2225,6 +2225,21 @@ static inline bool inet_sk_transparent(const struct sock *sk)
 	return inet_test_bit(TRANSPARENT, sk);
 }
 
+/**
+ * inet_sk_autobind - Check if socket was bound to a port at connect() time.
+ * @sk: &struct inet_connection_sock or &struct inet_timewait_sock
+ */
+static inline bool inet_sk_autobind(const struct sock *sk)
+{
+	switch (sk->sk_state) {
+	case TCP_TIME_WAIT:
+		return inet_twsk(sk)->tw_autobind;
+	case TCP_NEW_SYN_RECV:
+		return false; /* n/a to request sock */
+	}
+	return inet_test_bit(AUTOBIND, sk);
+}
+
 /* Determines whether this is a thin stream (which may suffer from
  * increased latency). Used to trigger latency-reducing mechanisms.
  */
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 0ef1eacd539d..34e4fe0c7b4b 100644
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
index ceeeec9b7290..f644ffe43018 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -87,10 +87,22 @@ struct inet_bind_bucket *inet_bind_bucket_create(struct kmem_cache *cachep,
  */
 void inet_bind_bucket_destroy(struct inet_bind_bucket *tb)
 {
+	const struct inet_bind2_bucket *tb2;
+
 	if (hlist_empty(&tb->bhash2)) {
 		hlist_del_rcu(&tb->node);
 		kfree_rcu(tb, rcu);
+		return;
+	}
+
+	if (tb->fastreuse == -1 && tb->fastreuseport == -1)
+		return;
+	hlist_for_each_entry(tb2, &tb->bhash2, bhash_node) {
+		if (tb2->fastreuse != -1 || tb2->fastreuseport != -1)
+			return;
 	}
+	tb->fastreuse = -1;
+	tb->fastreuseport = -1;
 }
 
 bool inet_bind_bucket_match(const struct inet_bind_bucket *tb, const struct net *net,
@@ -121,6 +133,8 @@ static void inet_bind2_bucket_init(struct inet_bind2_bucket *tb2,
 #else
 	tb2->rcv_saddr = sk->sk_rcv_saddr;
 #endif
+	tb2->fastreuse = 0;
+	tb2->fastreuseport = 0;
 	INIT_HLIST_HEAD(&tb2->owners);
 	hlist_add_head(&tb2->node, &head->chain);
 	hlist_add_head(&tb2->bhash_node, &tb->bhash2);
@@ -143,11 +157,23 @@ struct inet_bind2_bucket *inet_bind2_bucket_create(struct kmem_cache *cachep,
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
+		if (!inet_sk_autobind(sk))
+			return;
 	}
+	tb->fastreuse = -1;
+	tb->fastreuseport = -1;
 }
 
 static bool inet_bind2_bucket_addr_match(const struct inet_bind2_bucket *tb2,
@@ -191,6 +217,7 @@ static void __inet_put_port(struct sock *sk)
 	tb = inet_csk(sk)->icsk_bind_hash;
 	inet_csk(sk)->icsk_bind_hash = NULL;
 	inet_sk(sk)->inet_num = 0;
+	inet_clear_bit(AUTOBIND, sk);
 
 	spin_lock(&head2->lock);
 	if (inet_csk(sk)->icsk_bind2_hash) {
@@ -277,7 +304,7 @@ int __inet_inherit_port(const struct sock *sk, struct sock *child)
 		}
 	}
 	if (update_fastreuse)
-		inet_csk_update_fastreuse(tb, child);
+		inet_csk_update_fastreuse(child, tb, tb2);
 	inet_bind_hash(child, tb, tb2, port);
 	spin_unlock(&head2->lock);
 	spin_unlock(&head->lock);
@@ -1136,6 +1163,8 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 					       head2, tb, sk);
 		if (!tb2)
 			goto error;
+		tb2->fastreuse = -1;
+		tb2->fastreuseport = -1;
 	}
 
 	/* Here we want to add a little bit of randomness to the next source
@@ -1148,6 +1177,7 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 
 	/* Head lock still held and bh's disabled */
 	inet_bind_hash(sk, tb, tb2, port);
+	inet_set_bit(AUTOBIND, sk);
 
 	if (sk_unhashed(sk)) {
 		inet_sk(sk)->inet_sport = htons(port);
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 875ff923a8ed..0150f5697040 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -206,6 +206,7 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
 		tw->tw_hash	    = sk->sk_hash;
 		tw->tw_ipv6only	    = 0;
 		tw->tw_transparent  = inet_test_bit(TRANSPARENT, sk);
+		tw->tw_autobind     = inet_test_bit(AUTOBIND, sk);
 		tw->tw_prot	    = sk->sk_prot_creator;
 		atomic64_set(&tw->tw_cookie, atomic64_read(&sk->sk_cookie));
 		twsk_net_set(tw, sock_net(sk));

-- 
2.43.0


