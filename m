Return-Path: <netdev+bounces-185598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570F7A9B114
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 16:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 213DA7A423A
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 14:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA72B18C933;
	Thu, 24 Apr 2025 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URIpi8i4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FE5481C4
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745505357; cv=none; b=OmMWifKNkVPDj1Tw6uvKIq6Njn37OTkyWRrKc4nRKo9sisyfCa7WmCLxf2r2aNVrU3RdZShKVT89YKFW9R4M+Na3AijdFxIsYf7/rQggMVbLxFrhnZfgpANmi7MCtdhsCdrvBPDgev8X9nlMBhbVRJ6dFtT+J/re9KvKX5tnRys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745505357; c=relaxed/simple;
	bh=burZZfCJMCxupOAgx9R869sckdKCTXRWeGH5XnM+zUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FnuWG2HzklhNq+FDm36f0T8ldYYTPhn26LS6PzqI5ceWKau859bgCmZMht7K7aLAeL1tDOhbOntcOFZ/qJD3zsKEbdldUs51b1L4so5791rwz5g5jjD2NmZ1e78isEiVMe4JLe8P0qgOZT3EvzyNg9/831WO3RezIp1EPT9m2yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URIpi8i4; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c560c55bc1so127307185a.1
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 07:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745505355; x=1746110155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUCbMPXNvGzD4gvYlAMub6HMFxgJ/FS/k2CTkjvhy+o=;
        b=URIpi8i4Z+SP4wEpuH4fqM6T0ZrxcuS0Fq3vZGtkbSI5EKsfGoCTr/5rLmWKivYTb9
         YuElZhL+Jt/v5DNqwazCf/6NMmhv6Gt9Q6j+i4sOhHLDD1l2iPjym85AU7WpMm7MyzpF
         XrCztv4Pwd5LQmzetNeiXya828mUQAL8Ifl5qyAiUuVkvEc6R0grSmgqWpluGvI9UPAW
         DS+H5M9EhBWxtczH/mBrCC9mMl0lidm1b/Up7thrRZHAUw9Q7b30NWwsCB3LDyk0MGiy
         ysykOjkY7/bDDJV18sesdxExbRqq0vhRPgDXOqy683YJVmP+9McToRQYpE321V3h1kSw
         xlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745505355; x=1746110155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUCbMPXNvGzD4gvYlAMub6HMFxgJ/FS/k2CTkjvhy+o=;
        b=osaIq8drrler6ScwxhHL3/1pKQ+0mFwZkdLcixfBsubSs4EMS61Q6c98c0vBjReWAA
         lG3OBK3KvMlPVolH6kXpCo/7T6W0KaP1+3x1rP5RMHlrYeM0wJt/omc1rg1dH7XGrBEq
         VpR5Aw1z5ZpEm7NYoDpFQw8is/L1/grnWjKfC3TbwjzlAh0wApZF25I+LpPGRcWwPqVX
         aKQpXsoTtv5sY2oAn64Ja5PGg3c2iTbmYSeEs6dCDruP0dv96GC/ABDItmbJJrbXfN1/
         +0oJdCSoa13LcKbRrpflQs26xTVtKRiRa8hpJxmTrsYfIQcQGaXGJAvNRr4MqnfO5FxF
         HhnQ==
X-Gm-Message-State: AOJu0YyllkM2wruotOGGv9dIijBHxVMovQ8i9MREgil0Rp937GPvOoOO
	y8YjfkvPa0Tl9KHiOttZ6DTM7NcH9sllSH25JyeCt4nqPCmLJKTYdKs0zQ==
X-Gm-Gg: ASbGncunAxc0HTMtwTI7/2Et+SGu3c2VrZ5BS7FgX+QlF5DmZcKaJHX3CQJENficoXM
	UPdF2vktjkbHZhxCVptsUaUad+GBUdMpCJK82vzSW1penL2m1lYlr4aii2gYqIHt8FKhZF7yFS6
	NY52oe34+3vGsUks32GR2dhNrAwbSHxesgimZcI3A0vkn09QMLvpgq91vyBzqOCYvKbxLi4wKTQ
	E6ScnMzyfyeFAYtli+8X3k+XhdFXJ2HDb3u6qVLK4t0PoyWN7qwSFq9U2aPx5h9+YdStyauk/13
	NXMtQpkZsAZbabMVoPlCo9FzXbdEdJj40ODHh0S2oC2au11PNhpceClKVoTVilj2Nm2c1YSZr7S
	EBkillr3pCQUOH1mfTqAoUIjurj2wOUOTxmQ4IfpoSJY=
X-Google-Smtp-Source: AGHT+IEmfPj93cbfDnABpi6Ta9s59+iAi7FuK7X0ZUrcfwR0EUc82e9lOKFLAanpJ+UhzDmfaIkxnw==
X-Received: by 2002:a05:620a:1789:b0:7c5:a41a:b1a with SMTP id af79cd13be357-7c956e9bd7fmr399581685a.10.1745505354705;
        Thu, 24 Apr 2025 07:35:54 -0700 (PDT)
Received: from willemb.c.googlers.com.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958c91a8dsm94743985a.1.2025.04.24.07.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 07:35:54 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/3] ip: load balance tcp connections to single dst addr and port
Date: Thu, 24 Apr 2025 10:35:19 -0400
Message-ID: <20250424143549.669426-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
In-Reply-To: <20250424143549.669426-1-willemdebruijn.kernel@gmail.com>
References: <20250424143549.669426-1-willemdebruijn.kernel@gmail.com>
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

v1->v2
  - add (__force __be16) to use random data as __be16
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
index e5e4c71be3af..507b2e5dec50 100644
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
+			hash_keys.ports.src = (__force __be16)get_random_u16();
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
+				hash_keys.ports.src = (__force __be16)get_random_u16();
+			else
+				hash_keys.ports.src = fl4->fl4_sport;
 			hash_keys.ports.dst = fl4->fl4_dport;
 			hash_keys.basic.ip_proto = fl4->flowi4_proto;
 		}
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index d0351e95d916..aa6b45bd3515 100644
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
+			hash_keys.ports.src = (__force __be16)get_random_u16();
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
+				hash_keys.ports.src = (__force __be16)get_random_u16();
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


