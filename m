Return-Path: <netdev+bounces-212138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC776B1E559
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 11:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF6616DE85
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 09:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A95D26A0EB;
	Fri,  8 Aug 2025 09:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="F5txJMXN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1804266584
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754644217; cv=none; b=m7sZL3kT+V9WCyoWWNzaw8O6vGwavbWzt6c+1376wgVQY9xTId4oJ9bfEDEHh6kMIwB2suiqGOCYMZLrBtEvXkLJbVL5Gkjf+LzFLaePdg6BLAXkKWlh+2WyNsGfcsqgE4mf+iWetYmfXwm5GOdDar4B4f08AE2ei9JtyMeK9jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754644217; c=relaxed/simple;
	bh=ro2OAWYfywq6Ksd+NXBI853XGADysaQqp6tx+nxKiqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iMZRcJdOVrpBNZWBYqL6r/d2Ku1faFd+TzasBAw+B7oNteU0LryBO7D06S5V42DQG1unNhspKNqktpje93dKlVHy3nzu7+uOTeUoVn9F6HkpY4LGh70IlnudH3lVVTUUtG0TrRVaDOF6t8OC6MsIftb2fTUW/NPI7xAi6slSXOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=F5txJMXN; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61576e33ce9so3219652a12.1
        for <netdev@vger.kernel.org>; Fri, 08 Aug 2025 02:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1754644214; x=1755249014; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HIA2OUP2lw60QkfK9H+6gRye9QnNQbLKAcdUPhGBT7k=;
        b=F5txJMXN7DarlJWYRKd4JqXGdTS3WbKvD/BkT9yUf2JIFOsJUvS4U0UWqTk8HN/5xU
         /UusVeIl9vY230Nq6gDECplJmiJwe8ttIdg9StIKCocGze6YTrgoXFLTaZZFselHZ9Qc
         K/HqjbkOW/X4agV9FeD9AvNtl6Zb0j/EhBJtmrP3AXrweDr3OxTV3MHGV1FVm6e7cNUg
         fbSYWGPVgI31v8rXi0hUtCF8Ga+Klin7+MFzd6eXdz44TBofk4eWOoGhK7hNk4g3t77Z
         ijROk6DfI4XiIZNgIdprhtKx3KU9AdbjMFUoh9FNiPvTIh0WshP5l1Sn2yrZvUlYP2zk
         neug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754644214; x=1755249014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HIA2OUP2lw60QkfK9H+6gRye9QnNQbLKAcdUPhGBT7k=;
        b=qUUATkIzKXb28cVemADIN6MsX86kYuja0BGqGKWc8AjHIuYxaFGAkeqsf22n0jHbGs
         8k/qZ0sem7MPgexTAbJAppt27vDixXiwsX5r+b4y6QoXaj3RMk/1RNa3yT/SEEGxtT8h
         jkhDERtMuiCM+tcQd5wDNcnjyIA4pICQEv7FGXOXbRc/tKuaMXBUQpnbfJLx7rzB9lKQ
         ZWWefLNvMgwR1oSPZbcsnd8tDwc/OxyeaYp0WYWioVLnJS8RU0UJeVpgsCj1nh1JV8Yh
         VcJW9MCph47/EwBG9pQ+jNlUnWHyDy9Sf2OST5JP9Y5ua2k1UuKEpGW6vE8O+SYqDQnM
         QnkA==
X-Gm-Message-State: AOJu0Yy5ebn5e5n9NmRzakVz5FTAhkFj8c/bVXn07ftbJcR9UVYJ++ko
	j+PqnJd9rbCFnOg9Myl1boz+ILclwA+KFpEzx3INVloDNtOhT2+2vq0waRmxDXispXc=
X-Gm-Gg: ASbGnctXHfOM/goAOC5qgixpA5wVs5ZxU7JNRr9fUiGt5dJu22BVCKmvcSruSKncSGm
	1r1bp/xhb4v3u9FaU+x6mk/Y1aDLmWNU+GGisKCDgvd4AZ+TdktX89GblLmqY46W2C8FsmFK3rX
	uWvgHwJydwmeJFQTEan727PPGPq5uxsmbLDMPwJc6OmgZqyJs5MoczW7YRvublZp25rjNratsUj
	gq9lNiklu88Bs9cpuZ67Iq2+48Iho0etiyFJFeZBdLBXkWVHT0pWKNpb3lydwerVlXbBOrzy6sU
	PDemUYjd2+c/nkUCfUVvGUTCajpfnU5UFk4z41HaL8TGgG1vba+zvAmJyLN9sfEh6WzpXney6sr
	/n4f35WDOaQom36ZMHV3PcbmGeInYJ0abNkwRWpcAmpdrWsRm/fIvv0MlzncW0/LMp4g2DcI=
X-Google-Smtp-Source: AGHT+IGnjErQNO8Bxwh38Qijwpvj7Y67GNXqdPFFRXw9oLhOuDtzMXipnsMbw7pCa70kWRL3fzH1KA==
X-Received: by 2002:a05:6402:254e:b0:613:5257:6cad with SMTP id 4fb4d7f45d1cf-617e302b838mr1504674a12.11.1754644213814;
        Fri, 08 Aug 2025 02:10:13 -0700 (PDT)
Received: from cloudflare.com (79.184.123.100.ipv4.supernova.orange.pl. [79.184.123.100])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a911451csm12946462a12.60.2025.08.08.02.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 02:10:12 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 08 Aug 2025 11:10:01 +0200
Subject: [PATCH RFC net-next 1/2] tcp: Update bind bucket state on port
 release
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-update-bind-bucket-state-on-unhash-v1-1-faf85099d61b@cloudflare.com>
References: <20250808-update-bind-bucket-state-on-unhash-v1-0-faf85099d61b@cloudflare.com>
In-Reply-To: <20250808-update-bind-bucket-state-on-unhash-v1-0-faf85099d61b@cloudflare.com>
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
 include/net/tcp.h                  | 12 ++++++++++++
 net/ipv4/inet_connection_sock.c    | 12 ++++++++----
 net/ipv4/inet_hashtables.c         | 31 ++++++++++++++++++++++++++++++-
 net/ipv4/inet_timewait_sock.c      |  1 +
 8 files changed, 60 insertions(+), 8 deletions(-)

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
index 1086256549fa..73f1dbc1a04b 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -279,6 +279,8 @@ enum {
 	INET_FLAGS_RTALERT_ISOLATE = 28,
 	INET_FLAGS_SNDFLOW	= 29,
 	INET_FLAGS_RTALERT	= 30,
+	/* socket bound to a port at connect() time */
+	INET_FLAGS_LAZY_BIND	= 31,
 };
 
 /* cmsg flags for inet */
diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
index 67a313575780..9e5f1d08cc12 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -70,7 +70,8 @@ struct inet_timewait_sock {
 	unsigned int		tw_transparent  : 1,
 				tw_flowlabel	: 20,
 				tw_usec_ts	: 1,
-				tw_pad		: 2,	/* 2 bits hole */
+				tw_lazy_bind	: 1,
+				tw_pad		: 1,	/* 1 bit hole */
 				tw_tos		: 8;
 	u32			tw_txhash;
 	u32			tw_priority;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index b3815d104340..a8a7f14769f7 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2225,6 +2225,18 @@ static inline bool inet_sk_transparent(const struct sock *sk)
 	return inet_test_bit(TRANSPARENT, sk);
 }
 
+/* Check if socket was bound to a port at connect() time */
+static inline bool inet_sk_lazy_bind(const struct sock *sk)
+{
+	switch (sk->sk_state) {
+	case TCP_TIME_WAIT:
+		return inet_twsk(sk)->tw_lazy_bind;
+	case TCP_NEW_SYN_RECV:
+		return false; /* n/a to request sock */
+	}
+	return inet_test_bit(LAZY_BIND, sk);
+}
+
 /* Determines whether this is a thin stream (which may suffer from
  * increased latency). Used to trigger latency-reducing mechanisms.
  */
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 1e2df51427fe..0076c67d9bd4 100644
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
index ceeeec9b7290..5e6eaae38105 100644
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
+		if (!inet_sk_lazy_bind(sk))
+			return;
 	}
+	tb->fastreuse = -1;
+	tb->fastreuseport = -1;
 }
 
 static bool inet_bind2_bucket_addr_match(const struct inet_bind2_bucket *tb2,
@@ -277,7 +303,7 @@ int __inet_inherit_port(const struct sock *sk, struct sock *child)
 		}
 	}
 	if (update_fastreuse)
-		inet_csk_update_fastreuse(tb, child);
+		inet_csk_update_fastreuse(child, tb, tb2);
 	inet_bind_hash(child, tb, tb2, port);
 	spin_unlock(&head2->lock);
 	spin_unlock(&head->lock);
@@ -1136,6 +1162,8 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 					       head2, tb, sk);
 		if (!tb2)
 			goto error;
+		tb2->fastreuse = -1;
+		tb2->fastreuseport = -1;
 	}
 
 	/* Here we want to add a little bit of randomness to the next source
@@ -1148,6 +1176,7 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 
 	/* Head lock still held and bh's disabled */
 	inet_bind_hash(sk, tb, tb2, port);
+	inet_set_bit(LAZY_BIND, sk);
 
 	if (sk_unhashed(sk)) {
 		inet_sk(sk)->inet_sport = htons(port);
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 875ff923a8ed..ee668e5c0938 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -206,6 +206,7 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
 		tw->tw_hash	    = sk->sk_hash;
 		tw->tw_ipv6only	    = 0;
 		tw->tw_transparent  = inet_test_bit(TRANSPARENT, sk);
+		tw->tw_lazy_bind    = inet_test_bit(LAZY_BIND, sk);
 		tw->tw_prot	    = sk->sk_prot_creator;
 		atomic64_set(&tw->tw_cookie, atomic64_read(&sk->sk_cookie));
 		twsk_net_set(tw, sock_net(sk));

-- 
2.43.0


