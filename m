Return-Path: <netdev+bounces-221666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BFCB5179C
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 15:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5972F1C84767
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 13:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD82315765;
	Wed, 10 Sep 2025 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CWAe+kJQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A476328C5D9
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 13:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509738; cv=none; b=QdlAOkJ53fOUpEGPh/hZE8njKH0XtSnUwHyxVu1pzmWNtd5S8bNIJIsM7MG5X1CPnk7ernyrJVc4pvhEeSISw4xeBsQKxHL1RMYQtYYi7ROWZ0auW4ACzqoJecjfuaSF3ytpIsuznG8a7EBTRKFhdK+YFOunBJc7uwNb17evvVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509738; c=relaxed/simple;
	bh=GeRgTgJUmoQArYLyVGgZd4P+TLMOulh+f6heMfMexig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dGKOBfs5pFx6f4uxzlQPWGQojEHghHai9uVZsYj/KZLT1Nfe0XsZxULE0EJmQS1yUzRtclbqkoObRsdC+oHMJGwuhUsqBhPnGVPx4lS7rLsxlq3o0Gd1Fh6Kv5CDjOyfFtpjnkxt34LmujWXDM24SaYz8tiOBJ9SMJo6JqKmb+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CWAe+kJQ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6188b5ae1e8so8014028a12.0
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 06:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1757509735; x=1758114535; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FkwK3XaWUcRFgICEwDcH5Nixg8BKD124Dx7PHu00/a4=;
        b=CWAe+kJQz1LkyPzf+4XcYEXAx/vhlghzsRKkN8vzLmext5da7UyjUkVwsE/zz7NCvJ
         zIzkI/WbHAaXdkhikEdyTmK+bLL20vbmPL9BcWOCw/3sksWpaKq71ASq/Cu46TNnGCrL
         y6fYOJLho2G6Cr8CeCXbyFU9czWZpUcIBYR0wDO+XcK5+ZJATsfR4l9Ts6pR1fqUbI6k
         DK6L60LfS5IzmQLxOlpgz68cuMyiNoHjMcuM0ekyAgMC2i/O/bhOK4uGc/+YLNAeeSvP
         jngY+wT3OYn5P9pKGNVrCNdggyZU0NXgepNbW4zeMrU23ygod2uaqg/BS907T64k9a+Q
         K7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757509735; x=1758114535;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkwK3XaWUcRFgICEwDcH5Nixg8BKD124Dx7PHu00/a4=;
        b=gZDeJDVsiqvW1UYrBKoPgIjjzKdoPlHyjCk4VRwO+ll2WcI7Z9HwsWQREKc7KL9EDf
         Kiur/D2MJqDd3pHI9cg1yZYTQqtXKIIEjCRN72Y09XAkCdibnNA7Dn/vTeNqxGtG5SzV
         YWUEFXMDromZczp06jICjrXmER1FLwlMjN4jqNbKoqWPQ1q43NzC/sT8KxaRYKLgheML
         Leb+l3fGWtyku6tqlLUewXhfc2KQPbPcY2xImeBl7+W3zzuYOWjoaeYc1UQrPK78Odkv
         aRRfczoQ6mmgH/5wzRJ25zZc5JU+iL/PMrUjxqe5+5z/M7WfeZjXCm1bzdLZXD4nA8IG
         t7CQ==
X-Gm-Message-State: AOJu0YxfcfUNcG5LfDEk8FsTX+3qA4oSUm1GelBMDTBYWPmE1qAEbQFw
	hHa1NigzMEDtNpovqlQmgKZWcCfFm5eSRw4+0DrrVDgGWURgoKcqxJ99VYsI9nxQAmM=
X-Gm-Gg: ASbGncusXmqynFmuBsiTKbYApRDGuF7HLc6Xy8dj72TRwcUhHanRLKBASXJsTuD9uEy
	Do+grYyRbFCWpCrGZ5lvPmy+ze5OlBCspVRTWFff3WR2tD0i+D0a5S2b8s7/RFd/4OwjBfV5sPh
	LU7HRzS3C1nfLSyZXf4mhEQ+kO2a1qJsy4T6YxQFWrYGJ5piQ6kiyL/tnDkC7joTMS+wKjMg942
	eVzI6Umyh9rnISDFhwl/XrlRJxZH0qJmnM5bfQYQXD3ChbqfuMRv9f/BupZ8YFmcx+2ZOBaYwbC
	LO2ZE4WZ3LkMhKKzeqMvtSp9XyJiWcChvngJxsLIjLLdOvJblxCUMUeDxNWV/W54ykAW+85cYeq
	eYBdjwc1uh+1NPHeWezIA9GAYFPV9OUW04iai3JSj2qbvfk4HR16efDgN6lgzrzCahrYS
X-Google-Smtp-Source: AGHT+IHF5UeQkT35ICj424pgC7WGkdnG9i79vvf9gYhsfXlQkckOfGMWVw5061SwnmsLKY8LmZaM1A==
X-Received: by 2002:a05:6402:280c:b0:61c:1b27:56d4 with SMTP id 4fb4d7f45d1cf-6237c32e8f5mr14108356a12.35.1757509734863;
        Wed, 10 Sep 2025 06:08:54 -0700 (PDT)
Received: from cloudflare.com (79.184.140.27.ipv4.supernova.orange.pl. [79.184.140.27])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62bfef68606sm3205362a12.18.2025.09.10.06.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 06:08:53 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 10 Sep 2025 15:08:31 +0200
Subject: [PATCH net-next v3 1/2] tcp: Update bind bucket state on port
 release
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-update-bind-bucket-state-on-unhash-v3-1-023caaf4ae3c@cloudflare.com>
References: <20250910-update-bind-bucket-state-on-unhash-v3-0-023caaf4ae3c@cloudflare.com>
In-Reply-To: <20250910-update-bind-bucket-state-on-unhash-v3-0-023caaf4ae3c@cloudflare.com>
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
 net/ipv4/inet_connection_sock.c    | 12 +++++++----
 net/ipv4/inet_hashtables.c         | 44 +++++++++++++++++++++++++++++++++++++-
 net/ipv4/inet_timewait_sock.c      |  1 +
 7 files changed, 63 insertions(+), 8 deletions(-)

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
index ef4ccfd46ff6..943d9f2515b0 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -58,6 +58,18 @@ static u32 sk_ehashfn(const struct sock *sk)
 			    sk->sk_daddr, sk->sk_dport);
 }
 
+/**
+ * sk_is_connect_bind - Check if socket was auto-bound at connect() time.
+ * @sk: &struct inet_connection_sock or &struct inet_timewait_sock
+ */
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
@@ -87,10 +99,22 @@ struct inet_bind_bucket *inet_bind_bucket_create(struct kmem_cache *cachep,
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
@@ -121,6 +145,8 @@ static void inet_bind2_bucket_init(struct inet_bind2_bucket *tb2,
 #else
 	tb2->rcv_saddr = sk->sk_rcv_saddr;
 #endif
+	tb2->fastreuse = 0;
+	tb2->fastreuseport = 0;
 	INIT_HLIST_HEAD(&tb2->owners);
 	hlist_add_head(&tb2->node, &head->chain);
 	hlist_add_head(&tb2->bhash_node, &tb->bhash2);
@@ -143,11 +169,23 @@ struct inet_bind2_bucket *inet_bind2_bucket_create(struct kmem_cache *cachep,
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
@@ -191,6 +229,7 @@ static void __inet_put_port(struct sock *sk)
 	tb = inet_csk(sk)->icsk_bind_hash;
 	inet_csk(sk)->icsk_bind_hash = NULL;
 	inet_sk(sk)->inet_num = 0;
+	sk->sk_userlocks &= ~SOCK_CONNECT_BIND;
 
 	spin_lock(&head2->lock);
 	if (inet_csk(sk)->icsk_bind2_hash) {
@@ -277,7 +316,7 @@ int __inet_inherit_port(const struct sock *sk, struct sock *child)
 		}
 	}
 	if (update_fastreuse)
-		inet_csk_update_fastreuse(tb, child);
+		inet_csk_update_fastreuse(child, tb, tb2);
 	inet_bind_hash(child, tb, tb2, port);
 	spin_unlock(&head2->lock);
 	spin_unlock(&head->lock);
@@ -1136,6 +1175,8 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 					       head2, tb, sk);
 		if (!tb2)
 			goto error;
+		tb2->fastreuse = -1;
+		tb2->fastreuseport = -1;
 	}
 
 	/* Here we want to add a little bit of randomness to the next source
@@ -1148,6 +1189,7 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 
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


