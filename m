Return-Path: <netdev+bounces-184306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F230CA948AE
	for <lists+netdev@lfdr.de>; Sun, 20 Apr 2025 20:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D798170AB8
	for <lists+netdev@lfdr.de>; Sun, 20 Apr 2025 18:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A301D20CCEB;
	Sun, 20 Apr 2025 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgqZYg7f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29051E9904
	for <netdev@vger.kernel.org>; Sun, 20 Apr 2025 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745172346; cv=none; b=oMFy4AXYxFFPHBhzqd4JNpfjSVoMQiDr8sdL3+i0QR3Rw4Y6+sYpNWWUlNo/++jlgc0HK4AY4iKE2PqzWcU9kZn3DQYF7K+y3K/9LjYS3OzcUIJdBff8pGF8Fc/HXO61KItuwhXJB2bZYv5RJjGIRPYsPF8lMmwkNqKKomGau0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745172346; c=relaxed/simple;
	bh=iUdSr4xpXDDz37A3/6kujG6bqN6D17uv2pT3j8Ztf48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0a0Pt1aNmLxfdd/OptHLUhcoQh1K2XLG2VB7EFk2Zmfqqw6qXngxCecVz5nvTZWUhXipeBtLFTJJjRjysOjnLryWI0jyxKITV8wuJTOzNLn++44PM045ZMVeYTRaNktBp+1Dro8tv2lzEanPGaPr7LHkw2E7nxiML5nAThxoL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgqZYg7f; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6ecfa716ec1so31658916d6.2
        for <netdev@vger.kernel.org>; Sun, 20 Apr 2025 11:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745172344; x=1745777144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rq7kWK52h9IVGIo39gR+cnz3fLdJjkbpncf2bk3iQ84=;
        b=LgqZYg7fxlntJK2IjCJn560yzLkpbfyd4FIXzHe9OMnqeaUlmSRQDU+C9m/RUyJmZk
         Qo3df0Gf6Nps6WUcz9gYvwYs8SInqbmkQmLJ2T2IG0+EpiJcG0Nu0IbRy4rR6jJXy22e
         sW2M/01ANlWsc8ytmw5PeRDnLocLlhjPPFaNCaABA5FDrPb/dBpX11EQRDH7pBWd00Z9
         jvXzs65KLA8xiVdU/5RfcmdW3ASI5x8nwCFlCyzm+drZEv2GBjuiIr6AntsDB6BCJkA8
         LiEQSb2TgcOiAqQHfkKLW+hhmL8CFbnG/hZA0vx9wNpmZnPj/WH41gytCcGGMsUew2Es
         HQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745172344; x=1745777144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rq7kWK52h9IVGIo39gR+cnz3fLdJjkbpncf2bk3iQ84=;
        b=Zb2q4ElORCNuzDJrmOXIT6wiH1FsbrBpTnvRpuTBTPymTnMBzyNvtSCqwzJ7tUubE6
         UUibW7qks42rWr8wjWAvLZG7CRk/9CtI8GJcN6ql6MFbng+6K7a10BuBkBJTXBt011Vp
         TaVq5ArRcVUH4CCXHfT6gqSawsVFtVPSSaCE61VymHJsSP6gCE3Fzv1s9cg1otJszBRD
         KGNNlPcAFDUPjCsMUJlAJvs84lTxmGd9c2yS5xhyDeK9Azi/ScMzp0+EkigRbwks1VJj
         gQvupA7BmpeVuDhCafBPIgQ24RJA/gVP8Pj+L67iI9wgH/0s0pPBFT0TjTdZCnym9GMq
         ek7A==
X-Gm-Message-State: AOJu0Yy07cobIoWHVxr2jAEisz7yDlPznP+6mkyrEZh+tLAxKsA4FgbF
	awceB5BlClfhKTbB+4PBq2fNK5mWJT8ZynORW0sE0L+IMbQy1LfTrBoAAw==
X-Gm-Gg: ASbGncs95uDBM8Sz9+Ga3W0qdescWB19L8scvxK8jPDj5tayGb1TAYPBtdN6CvO6avN
	tlaCrnryLsPVtxrNST5dcw3Aj77X0rB2O1RtnktLZFZmtBv7E9dE00yi6VvYWJ32jH8NZ/fLFzZ
	vZMmysaY5x0oFG7QwfpDfLd2eW2GUQEn7LgBxUQgWkiak9NonLGYU8Fh+3BEs9K6DHextaFiTgA
	MSFVcDGAlF3b5ZUEFNEZyEr7kyUFoeOiQfWtq31vumvgyu3Y95RsLVMRh1VKfJ4GneptiQPrhPN
	7lAv3AGH6GPzIkSkZgNwlFzHI1gJtipVvTaepKFNs9w8lg0loZ3XNVLyrgEFq1NmRnJCSz+2a0y
	n7lKeb1VvtZlWTLqWmmVwhqze7RShNWLLmB8uUhKmrcc=
X-Google-Smtp-Source: AGHT+IGUlIbX/tvwfJNrYG+9mgNzmcX3Xlr9KrSNcw9Ysv4ChT8ErnhPO33Nx5udloxkXg2ZH9qVNw==
X-Received: by 2002:a05:6214:f67:b0:6ed:14cd:d179 with SMTP id 6a1803df08f44-6f2c44ed56cmr166102496d6.3.1745172343692;
        Sun, 20 Apr 2025 11:05:43 -0700 (PDT)
Received: from willemb.c.googlers.com.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2c21cccsm34333676d6.106.2025.04.20.11.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 11:05:43 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	idosch@nvidia.com,
	kuniyu@amazon.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 2/3] ip: load balance tcp connections to single dst addr and port
Date: Sun, 20 Apr 2025 14:04:30 -0400
Message-ID: <20250420180537.2973960-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
In-Reply-To: <20250420180537.2973960-1-willemdebruijn.kernel@gmail.com>
References: <20250420180537.2973960-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Load balance new TCP connections across nexthops also when they
connect to the same service at a single remote address and port.

This affects only port-based multipath hashing:
fib_multipath_hash_policy 1 or 3.

Local connections must choose both a source address and port when
connecting to a remote service, in ip_route_connect. This
"chicken-and-egg problem" (commit 2d7192d6cbab ("ipv4: Sanitize and
simplify ip_route_{connect,newports}()")) is resolved by first
selecting a source address, by looking up a route using the zero
wildcard source port and address.

As a result multiple connections to the same destination address and
port have no entropy in fib_multipath_hash.

This is not a problem when forwarding, as skb-based hashing has a
4-tuple. Nor when establishing UDP connections, as autobind there
selects a port before reaching ip_route_connect.

Load balance also TCP, by using a random port in fib_multipath_hash.
Port assignment in inet_hash_connect is not atomic with
ip_route_connect. Thus ports are unpredictable, effectively random.

Implementation details:

Do not actually pass a random fl4_sport, as that affects not only
hashing, but routing more broadly, and can match a source port based
policy route, which existing wildcard port 0 will not. Instead,
define a new wildcard flowi flag that is used only for hashing.

Selecting a random source is equivalent to just selecting a random
hash entirely. But for code clarity, follow the normal 4-tuple hash
process and only update this field.

fib_multipath_hash can be reached with zero sport from other code
paths, so explicitly pass this flowi flag, rather than trying to infer
this case in the function itself.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 include/net/flow.h  |  1 +
 include/net/route.h |  3 +++
 net/ipv4/route.c    | 13 ++++++++++---
 net/ipv6/route.c    | 13 ++++++++++---
 net/ipv6/tcp_ipv6.c |  2 ++
 5 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/include/net/flow.h b/include/net/flow.h
index 2a3f0c42f092..a1839c278d87 100644
--- a/include/net/flow.h
+++ b/include/net/flow.h
@@ -39,6 +39,7 @@ struct flowi_common {
 #define FLOWI_FLAG_ANYSRC		0x01
 #define FLOWI_FLAG_KNOWN_NH		0x02
 #define FLOWI_FLAG_L3MDEV_OIF		0x04
+#define FLOWI_FLAG_ANY_SPORT		0x08
 	__u32	flowic_secid;
 	kuid_t  flowic_uid;
 	__u32		flowic_multipath_hash;
diff --git a/include/net/route.h b/include/net/route.h
index c605fd5ec0c0..8e39aa822cf9 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -326,6 +326,9 @@ static inline void ip_route_connect_init(struct flowi4 *fl4, __be32 dst,
 	if (inet_test_bit(TRANSPARENT, sk))
 		flow_flags |= FLOWI_FLAG_ANYSRC;
 
+	if (IS_ENABLED(CONFIG_IP_ROUTE_MULTIPATH) && !sport)
+		flow_flags |= FLOWI_FLAG_ANY_SPORT;
+
 	flowi4_init_output(fl4, oif, READ_ONCE(sk->sk_mark), ip_sock_rt_tos(sk),
 			   ip_sock_rt_scope(sk), protocol, flow_flags, dst,
 			   src, dport, sport, sk->sk_uid);
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index e5e4c71be3af..685e8d3b4f5d 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2037,8 +2037,12 @@ static u32 fib_multipath_custom_hash_fl4(const struct net *net,
 		hash_keys.addrs.v4addrs.dst = fl4->daddr;
 	if (hash_fields & FIB_MULTIPATH_HASH_FIELD_IP_PROTO)
 		hash_keys.basic.ip_proto = fl4->flowi4_proto;
-	if (hash_fields & FIB_MULTIPATH_HASH_FIELD_SRC_PORT)
-		hash_keys.ports.src = fl4->fl4_sport;
+	if (hash_fields & FIB_MULTIPATH_HASH_FIELD_SRC_PORT) {
+		if (fl4->flowi4_flags & FLOWI_FLAG_ANY_SPORT)
+			hash_keys.ports.src = get_random_u16();
+		else
+			hash_keys.ports.src = fl4->fl4_sport;
+	}
 	if (hash_fields & FIB_MULTIPATH_HASH_FIELD_DST_PORT)
 		hash_keys.ports.dst = fl4->fl4_dport;
 
@@ -2093,7 +2097,10 @@ int fib_multipath_hash(const struct net *net, const struct flowi4 *fl4,
 			hash_keys.control.addr_type = FLOW_DISSECTOR_KEY_IPV4_ADDRS;
 			hash_keys.addrs.v4addrs.src = fl4->saddr;
 			hash_keys.addrs.v4addrs.dst = fl4->daddr;
-			hash_keys.ports.src = fl4->fl4_sport;
+			if (fl4->flowi4_flags & FLOWI_FLAG_ANY_SPORT)
+				hash_keys.ports.src = get_random_u16();
+			else
+				hash_keys.ports.src = fl4->fl4_sport;
 			hash_keys.ports.dst = fl4->fl4_dport;
 			hash_keys.basic.ip_proto = fl4->flowi4_proto;
 		}
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 945857a8bfe3..39f07cdbbc64 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2492,8 +2492,12 @@ static u32 rt6_multipath_custom_hash_fl6(const struct net *net,
 		hash_keys.basic.ip_proto = fl6->flowi6_proto;
 	if (hash_fields & FIB_MULTIPATH_HASH_FIELD_FLOWLABEL)
 		hash_keys.tags.flow_label = (__force u32)flowi6_get_flowlabel(fl6);
-	if (hash_fields & FIB_MULTIPATH_HASH_FIELD_SRC_PORT)
-		hash_keys.ports.src = fl6->fl6_sport;
+	if (hash_fields & FIB_MULTIPATH_HASH_FIELD_SRC_PORT) {
+		if (fl6->flowi6_flags & FLOWI_FLAG_ANY_SPORT)
+			hash_keys.ports.src = get_random_u16();
+		else
+			hash_keys.ports.src = fl6->fl6_sport;
+	}
 	if (hash_fields & FIB_MULTIPATH_HASH_FIELD_DST_PORT)
 		hash_keys.ports.dst = fl6->fl6_dport;
 
@@ -2547,7 +2551,10 @@ u32 rt6_multipath_hash(const struct net *net, const struct flowi6 *fl6,
 			hash_keys.control.addr_type = FLOW_DISSECTOR_KEY_IPV6_ADDRS;
 			hash_keys.addrs.v6addrs.src = fl6->saddr;
 			hash_keys.addrs.v6addrs.dst = fl6->daddr;
-			hash_keys.ports.src = fl6->fl6_sport;
+			if (fl6->flowi6_flags & FLOWI_FLAG_ANY_SPORT)
+				hash_keys.ports.src = get_random_u16();
+			else
+				hash_keys.ports.src = fl6->fl6_sport;
 			hash_keys.ports.dst = fl6->fl6_dport;
 			hash_keys.basic.ip_proto = fl6->flowi6_proto;
 		}
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 7dcb33f879ee..e8e68a142649 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -267,6 +267,8 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
 	fl6.flowi6_mark = sk->sk_mark;
 	fl6.fl6_dport = usin->sin6_port;
 	fl6.fl6_sport = inet->inet_sport;
+	if (IS_ENABLED(CONFIG_IP_ROUTE_MULTIPATH) && !fl6.fl6_sport)
+		fl6.flowi6_flags = FLOWI_FLAG_ANY_SPORT;
 	fl6.flowi6_uid = sk->sk_uid;
 
 	opt = rcu_dereference_protected(np->opt, lockdep_sock_is_held(sk));
-- 
2.49.0.805.g082f7c87e0-goog


