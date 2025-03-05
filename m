Return-Path: <netdev+bounces-171916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FD6A4F591
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 04:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC10189102D
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 03:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC9E19258E;
	Wed,  5 Mar 2025 03:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mqI9yCxZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80D718FC9F
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 03:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741146357; cv=none; b=W5gR9i7frCAKZra2somNxNRu5Hy9VnM1erxyJYsrf2J2cDsvaFEqTNFPb3FE0PkI4yynM1onPqofvMWaa2uJS5m5WY/oO6ELgwlMU0SN6PB2amQLJwnYk+VXrarfHci3qJOKxbU6F3JCJBsekk5SB3+qJVMfjJ8B2hDSwCc25lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741146357; c=relaxed/simple;
	bh=l2ALbw/Or/KY0igBNPyMfBtcrtyq4dnMWZKF8SomG3g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T3XmFbkGZn8o7KYULNuRD6NkGqUDhV9lI4ywUjKCAnoQKU36i9K3dwOQCsX+L18dc8iyj9goIhXrDiOElqG5sPTnxEhgphJKK+AT22H+W5yOLApcHU6p8V1xLyKHDRJgy0L4ht1CGb8Y+V7stvQMT/Zq5D/VHN5aQz9f7+GGy2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mqI9yCxZ; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-474ed10ad03so76725581cf.0
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 19:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741146355; x=1741751155; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aAwfzrqo0H5kRu+loR/5btYKLkYrZEQx1BjtZvK+xj4=;
        b=mqI9yCxZz9Tjh6Svg0echBXSvD15YCOwXtKS3uIB6S56HF4VlwTwA2njJqJpC/uT+g
         5JFyH/9Vf5XG9fmRdD9/8IYAcnTNIN9+rDQAzrCXakXhRkY4OyQvTiyv4Drkf8eljGQE
         NV1xeQAEHvaoaPlFwK8Ih1Q+KH/DQu6TVCJdeYw0xhzJNcn8AfQLAYq9IRodz+p5mPiC
         iWt7CmFNmDJ0DqPvfXEgu6oPoTdZqLeMvYVw5qezNBMzBBEe6VHNA5sFAC6Y6vsqsyn6
         TX77iTPK5mFrJyBM5wKQxIn5DFT+80EhUcaiqY+BYbtmwCeK9oWQOi5pIqp7JwQ40rb+
         qjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741146355; x=1741751155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aAwfzrqo0H5kRu+loR/5btYKLkYrZEQx1BjtZvK+xj4=;
        b=iv76OLQwOsIvDdAmTLg3Fe4hRm7fHZHyT5tKC+02Fuo09XHy3awx1kHRFDU+d2YacZ
         ZaUtHqw+7M5lbUott6TcSekxYgRp52iHuK+ACHB3dzfjv+CxqsxkvtCo9YvrXzoZDCpF
         wjivWE556Bg6MlURxs3yyGHHcLRTCmxMNn4+aaajz/UkxAuNSbELU9uituEUya0qNDOb
         5l4Xzpjz9ZywiFpEiNC9i+NgHnH3FM/cm9UtO5K+NWYIdeL1Cot6YXaudacAm7SG4ISZ
         HmLkJuEQlU0gOw05CgfTXsIRt85iXJ7wgskg9/PRmTeFjNdRdAvm/WyvowKtOgx2sme5
         YxfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVCocOEkGYZKLB7fwkTaG4t22FyYBvsia5Vx9cxF4ehm/Wyk0KP3t8gJXsZmx7kpq2aEtfLmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFylaU+fpR/r7zq136i9lHKo2kmNtoB3et1N/91d2o9qTaH1QG
	nUg1KA7yV15K6/L+Ut/6nfAxBO5cFP/s7kenON6vhk6zVqE/LNB2YZajarRo+sLirmTTCCOQrhE
	MAcPH6Sd5Dg==
X-Google-Smtp-Source: AGHT+IGG02qEea9RzA69wAtyN6NMx737uKpO+cCZNuZOSE+CUCGY8Gf+H/NYd9Y2KlLE3zu17fJ/Ndg+65RNZw==
X-Received: from qtbfh3.prod.google.com ([2002:a05:622a:5883:b0:467:518e:d31b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:11c8:b0:475:999:21b4 with SMTP id d75a77b69052e-4750b4c94c1mr23026981cf.37.1741146354647;
 Tue, 04 Mar 2025 19:45:54 -0800 (PST)
Date: Wed,  5 Mar 2025 03:45:50 +0000
In-Reply-To: <20250305034550.879255-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250305034550.879255-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250305034550.879255-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] inet: call inet6_ehashfn() once from inet6_hash_connect()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Jason Xing <kernelxing@tencent.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

inet6_ehashfn() being called from __inet6_check_established()
has a big impact on performance, as shown in the Tested section.

After prior patch, we can compute the hash for port 0
from inet6_hash_connect(), and derive each hash in
__inet_hash_connect() from this initial hash:

hash(saddr, lport, daddr, dport) == hash(saddr, 0, daddr, dport) + lport

Apply the same principle for __inet_check_established(),
although inet_ehashfn() has a smaller cost.

Tested:

Server: ulimit -n 40000; neper/tcp_crr -T 200 -F 30000 -6 --nolog
Client: ulimit -n 40000; neper/tcp_crr -T 200 -F 30000 -6 --nolog -c -H server

Before this patch:

  utime_start=0.286131
  utime_end=4.378886
  stime_start=11.952556
  stime_end=1991.655533
  num_transactions=1446830
  latency_min=0.001061085
  latency_max=12.075275028
  latency_mean=0.376375302
  latency_stddev=1.361969596
  num_samples=306383
  throughput=151866.56

perf top:

 50.01%  [kernel]       [k] __inet6_check_established
 20.65%  [kernel]       [k] __inet_hash_connect
 15.81%  [kernel]       [k] inet6_ehashfn
  2.92%  [kernel]       [k] rcu_all_qs
  2.34%  [kernel]       [k] __cond_resched
  0.50%  [kernel]       [k] _raw_spin_lock
  0.34%  [kernel]       [k] sched_balance_trigger
  0.24%  [kernel]       [k] queued_spin_lock_slowpath

After this patch:

  utime_start=0.315047
  utime_end=9.257617
  stime_start=7.041489
  stime_end=1923.688387
  num_transactions=3057968
  latency_min=0.003041375
  latency_max=7.056589232
  latency_mean=0.141075048    # Better latency metrics
  latency_stddev=0.526900516
  num_samples=312996
  throughput=320677.21        # 111 % increase, and 229 % for the series

perf top: inet6_ehashfn is no longer seen.

 39.67%  [kernel]       [k] __inet_hash_connect
 37.06%  [kernel]       [k] __inet6_check_established
  4.79%  [kernel]       [k] rcu_all_qs
  3.82%  [kernel]       [k] __cond_resched
  1.76%  [kernel]       [k] sched_balance_domains
  0.82%  [kernel]       [k] _raw_spin_lock
  0.81%  [kernel]       [k] sched_balance_rq
  0.81%  [kernel]       [k] sched_balance_trigger
  0.76%  [kernel]       [k] queued_spin_lock_slowpath

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/inet_hashtables.h |  4 +++-
 include/net/ip.h              |  2 +-
 net/ipv4/inet_hashtables.c    | 26 ++++++++++++++++++--------
 net/ipv6/inet6_hashtables.c   | 15 +++++++++++----
 4 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index f447d61d95982090aac492b31e4199534970c4fb..949641e925398f741f2d4dda5898efc683b305dc 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -527,10 +527,12 @@ static inline void sk_rcv_saddr_set(struct sock *sk, __be32 addr)
 
 int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 			struct sock *sk, u64 port_offset,
+			u32 hash_port0,
 			int (*check_established)(struct inet_timewait_death_row *,
 						 struct sock *, __u16,
 						 struct inet_timewait_sock **,
-						 bool rcu_lookup));
+						 bool rcu_lookup,
+						 u32 hash));
 
 int inet_hash_connect(struct inet_timewait_death_row *death_row,
 		      struct sock *sk);
diff --git a/include/net/ip.h b/include/net/ip.h
index ce5e59957dd553697536ddf111bb1406d9d99408..8a48ade24620b4c8e2ebb4726f27a69aac7138b0 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -357,7 +357,7 @@ static inline void inet_get_local_port_range(const struct net *net, int *low, in
 bool inet_sk_get_local_port_range(const struct sock *sk, int *low, int *high);
 
 #ifdef CONFIG_SYSCTL
-static inline bool inet_is_local_reserved_port(struct net *net, unsigned short port)
+static inline bool inet_is_local_reserved_port(const struct net *net, unsigned short port)
 {
 	if (!net->ipv4.sysctl_local_reserved_ports)
 		return false;
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 3025d2b708852acd9744709a897fca17564523d5..1e3a9573c19834cc96d0b4cbf816f86433134450 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -538,7 +538,8 @@ EXPORT_SYMBOL_GPL(__inet_lookup_established);
 static int __inet_check_established(struct inet_timewait_death_row *death_row,
 				    struct sock *sk, __u16 lport,
 				    struct inet_timewait_sock **twp,
-				    bool rcu_lookup)
+				    bool rcu_lookup,
+				    u32 hash)
 {
 	struct inet_hashinfo *hinfo = death_row->hashinfo;
 	struct inet_sock *inet = inet_sk(sk);
@@ -549,8 +550,6 @@ static int __inet_check_established(struct inet_timewait_death_row *death_row,
 	int sdif = l3mdev_master_ifindex_by_index(net, dif);
 	INET_ADDR_COOKIE(acookie, saddr, daddr);
 	const __portpair ports = INET_COMBINED_PORTS(inet->inet_dport, lport);
-	unsigned int hash = inet_ehashfn(net, daddr, lport,
-					 saddr, inet->inet_dport);
 	struct inet_ehash_bucket *head = inet_ehash_bucket(hinfo, hash);
 	struct inet_timewait_sock *tw = NULL;
 	const struct hlist_nulls_node *node;
@@ -1007,9 +1006,10 @@ static u32 *table_perturb;
 
 int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 		struct sock *sk, u64 port_offset,
+		u32 hash_port0,
 		int (*check_established)(struct inet_timewait_death_row *,
 			struct sock *, __u16, struct inet_timewait_sock **,
-			bool rcu_lookup))
+			bool rcu_lookup, u32 hash))
 {
 	struct inet_hashinfo *hinfo = death_row->hashinfo;
 	struct inet_bind_hashbucket *head, *head2;
@@ -1027,7 +1027,8 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 
 	if (port) {
 		local_bh_disable();
-		ret = check_established(death_row, sk, port, NULL, false);
+		ret = check_established(death_row, sk, port, NULL, false,
+					hash_port0 + port);
 		local_bh_enable();
 		return ret;
 	}
@@ -1071,7 +1072,8 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 				rcu_read_unlock();
 				goto next_port;
 			}
-			if (!check_established(death_row, sk, port, &tw, true))
+			if (!check_established(death_row, sk, port, &tw, true,
+					       hash_port0 + port))
 				break;
 			rcu_read_unlock();
 			goto next_port;
@@ -1090,7 +1092,8 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 					goto next_port_unlock;
 				WARN_ON(hlist_empty(&tb->bhash2));
 				if (!check_established(death_row, sk,
-						       port, &tw, false))
+						       port, &tw, false,
+						       hash_port0 + port))
 					goto ok;
 				goto next_port_unlock;
 			}
@@ -1197,11 +1200,18 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 int inet_hash_connect(struct inet_timewait_death_row *death_row,
 		      struct sock *sk)
 {
+	const struct inet_sock *inet = inet_sk(sk);
+	const struct net *net = sock_net(sk);
 	u64 port_offset = 0;
+	u32 hash_port0;
 
 	if (!inet_sk(sk)->inet_num)
 		port_offset = inet_sk_port_offset(sk);
-	return __inet_hash_connect(death_row, sk, port_offset,
+
+	hash_port0 = inet_ehashfn(net, inet->inet_rcv_saddr, 0,
+				  inet->inet_daddr, inet->inet_dport);
+
+	return __inet_hash_connect(death_row, sk, port_offset, hash_port0,
 				   __inet_check_established);
 }
 EXPORT_SYMBOL_GPL(inet_hash_connect);
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 3d95f1e75a118ff8027d4ec0f33910d23b6af832..76ee521189eb77c48845eeeac9d50b3a93a250a6 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -264,7 +264,8 @@ EXPORT_SYMBOL_GPL(inet6_lookup);
 static int __inet6_check_established(struct inet_timewait_death_row *death_row,
 				     struct sock *sk, const __u16 lport,
 				     struct inet_timewait_sock **twp,
-				     bool rcu_lookup)
+				     bool rcu_lookup,
+				     u32 hash)
 {
 	struct inet_hashinfo *hinfo = death_row->hashinfo;
 	struct inet_sock *inet = inet_sk(sk);
@@ -274,8 +275,6 @@ static int __inet6_check_established(struct inet_timewait_death_row *death_row,
 	struct net *net = sock_net(sk);
 	const int sdif = l3mdev_master_ifindex_by_index(net, dif);
 	const __portpair ports = INET_COMBINED_PORTS(inet->inet_dport, lport);
-	const unsigned int hash = inet6_ehashfn(net, daddr, lport, saddr,
-						inet->inet_dport);
 	struct inet_ehash_bucket *head = inet_ehash_bucket(hinfo, hash);
 	struct inet_timewait_sock *tw = NULL;
 	const struct hlist_nulls_node *node;
@@ -354,11 +353,19 @@ static u64 inet6_sk_port_offset(const struct sock *sk)
 int inet6_hash_connect(struct inet_timewait_death_row *death_row,
 		       struct sock *sk)
 {
+	const struct in6_addr *daddr = &sk->sk_v6_rcv_saddr;
+	const struct in6_addr *saddr = &sk->sk_v6_daddr;
+	const struct inet_sock *inet = inet_sk(sk);
+	const struct net *net = sock_net(sk);
 	u64 port_offset = 0;
+	u32 hash_port0;
 
 	if (!inet_sk(sk)->inet_num)
 		port_offset = inet6_sk_port_offset(sk);
-	return __inet_hash_connect(death_row, sk, port_offset,
+
+	hash_port0 = inet6_ehashfn(net, daddr, 0, saddr, inet->inet_dport);
+
+	return __inet_hash_connect(death_row, sk, port_offset, hash_port0,
 				   __inet6_check_established);
 }
 EXPORT_SYMBOL_GPL(inet6_hash_connect);
-- 
2.48.1.711.g2feabab25a-goog


