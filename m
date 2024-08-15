Return-Path: <netdev+bounces-119003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C38B953CE2
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 23:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E1B1C250DF
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBAC1547FB;
	Thu, 15 Aug 2024 21:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="BxszTmEl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6BC154BFE
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 21:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758382; cv=none; b=EBa5J43sXPt51SDDvn3+0y5lqSKpSBbBrdpn8IbMOYMkBw3R8WHu8liFC+CgnPfiDCiVw57NMnyVggRZOdYJM0T2nRoZeYsarwtTk+cevFOVmeAZyxcWZhsgc6Q55jt2PR9abLqhZ/ZCbiGIa8W5mckr0ZZPbfZj3seCGTudBY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758382; c=relaxed/simple;
	bh=oalgP9O9gpcKlYJBcSNPBq0Wmbsxw0YVzP2gX8IN3c0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=isIxo6Hj3sHLn6+OQBGa2W4n68o2QCeGwTDw6mMqcamri39AO7ZN6Wr+I0p7BE+EjUZ7sLh1c2VXeDDLIknvugXNKdshcubOCA6KzRs/D8AJzMCiEgRk5zHRDt/lx5BStXFiT0jr35Elo9v7ofV9sVC7HO0mFGgw/rdjSAfa+X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=BxszTmEl; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso1102802a12.2
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1723758380; x=1724363180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fl4aAKLOqzFhxiacmKbEmhmC238Jn9ZCDBpZAd6LT98=;
        b=BxszTmElL7Uadld+n9iCUxyVnfnmNRQlm8I9pZhPcbIBrHIwLTBvCEf1PYQNt2S7nf
         wVdCQ3jbtTY9WnH7FHooa9ObHZ98P+IYyxSU+g2kf5/5KJhSEEx0f0Fz/FJ20nw/SQ+z
         IZxJR7zvIVb9vOl3WLjxcugKiWKmhboaOIDr3XXiNrQv+f7Kh+nKheuL2lZqe2QsgjGz
         0eiec7pJdzZGGOEVh5RyJaq8BnhCK3nR0V8LsFzsWzMMEfVrUO/2FGIw60sgUD616CKE
         B6j1sMUVXgxbD2kywZDkXjgBV7bREcNID+kepiPggIQlQ1J43qrQ/Oxgxo432rg7GihA
         55Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723758380; x=1724363180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fl4aAKLOqzFhxiacmKbEmhmC238Jn9ZCDBpZAd6LT98=;
        b=wmEbEAw3rQ4gFa+yo//LBsCq7EjetKDQTocSqxsdnmkqUAXP5PSGOdjojkgaveCP/1
         nKxWqhf/RMXleC5ufUNol6ugcytVQxRm/jH0tpGHr+5E3yD4kUE6u3FNygwJi8vlSk6l
         AtCR5y7Jot6S5oV4bC4Grv7RrDQLKRYD5z0g6b6ZAwCU7V4s0bO1SJV3d90hHCRct8Dp
         GM3qhovHihcDhV/rxyjs9TjLhPZo7GFzlenPKYj5WIQQH3eXG+7SOZXIn/hPFvNgeE+m
         dO1HkrRJPHTb+DsduZEh3dRr+A13+gqHw84TzDDyRzBmQSsMph3vEI+zuMBpZ1KK2WcR
         Rjww==
X-Forwarded-Encrypted: i=1; AJvYcCUZOHqxwFiWC/jCsvNW8NVyjqll9Lbelovm/yoKgv9qwgwAcJKl0m7YrWbGHd6jO1O4kt5Pi//+gkJ4TUhw/3cN22zmsyP1
X-Gm-Message-State: AOJu0YzkZBL6RHHiGDkuv6U+XIyuKv6myYsXI/uGqn7q6AYJWKgyyBFU
	ji6TfA3JoE9+tDcfjCw/Ce5LnWigJtQQEeqDhG88KnxK6igj0qTtPW9UBGOmYw==
X-Google-Smtp-Source: AGHT+IHSdyyb6Yx9BAUbTphNur0zx8hkm9pMcynVfm2tE7Tg7dhCrQYQFFcDT4ngYP2ljfLZmTkM+A==
X-Received: by 2002:a17:90b:224e:b0:2c8:716f:b46e with SMTP id 98e67ed59e1d1-2d3dfc61a62mr1173056a91.16.1723758380431;
        Thu, 15 Aug 2024 14:46:20 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:99b4:e046:411:1b72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2c652ffsm303288a91.10.2024.08.15.14.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:46:20 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 06/12] flow_dissector: Parse foo-over-udp (FOU)
Date: Thu, 15 Aug 2024 14:45:21 -0700
Message-Id: <20240815214527.2100137-7-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815214527.2100137-1-tom@herbertland.com>
References: <20240815214527.2100137-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse FOU by getting the FOU protocol from the matching socket.
This includes moving "struct fou" and "fou_from_sock" to fou.h

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 include/net/fou.h         | 16 ++++++++++++++++
 net/core/flow_dissector.c | 13 ++++++++++++-
 net/ipv4/fou_core.c       | 16 ----------------
 3 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/include/net/fou.h b/include/net/fou.h
index 824eb4b231fd..8574767b91b6 100644
--- a/include/net/fou.h
+++ b/include/net/fou.h
@@ -17,6 +17,22 @@ int __fou_build_header(struct sk_buff *skb, struct ip_tunnel_encap *e,
 int __gue_build_header(struct sk_buff *skb, struct ip_tunnel_encap *e,
 		       u8 *protocol, __be16 *sport, int type);
 
+struct fou {
+	struct socket *sock;
+	u8 protocol;
+	u8 flags;
+	__be16 port;
+	u8 family;
+	u16 type;
+	struct list_head list;
+	struct rcu_head rcu;
+};
+
+static inline struct fou *fou_from_sock(struct sock *sk)
+{
+	return sk->sk_user_data;
+}
+
 int register_fou_bpf(void);
 
 #endif
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 57cfae4b5d2f..ce7119dbf1ab 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -8,6 +8,7 @@
 #include <linux/filter.h>
 #include <net/dsa.h>
 #include <net/dst_metadata.h>
+#include <net/fou.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
 #include <net/gre.h>
@@ -865,11 +866,11 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
 		       int *p_nhoff, int hlen, __be16 *p_proto,
 		       u8 *p_ip_proto, int base_nhoff, unsigned int flags)
 {
+	__u8 encap_type, fou_protocol;
 	enum flow_dissect_ret ret;
 	const struct udphdr *udph;
 	struct udphdr _udph;
 	struct sock *sk;
-	__u8 encap_type;
 	int nhoff;
 
 	if (!(flags & FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS))
@@ -902,6 +903,9 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
 		}
 
 		encap_type = udp_sk(sk)->encap_type;
+		if (encap_type == UDP_ENCAP_FOU)
+			fou_protocol = fou_from_sock(sk)->protocol;
+
 		rcu_read_unlock();
 
 		break;
@@ -938,6 +942,9 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
 		}
 
 		encap_type = udp_sk(sk)->encap_type;
+		if (encap_type == UDP_ENCAP_FOU)
+			fou_protocol = fou_from_sock(sk)->protocol;
+
 		rcu_read_unlock();
 
 		break;
@@ -951,6 +958,10 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
 	ret = FLOW_DISSECT_RET_OUT_GOOD;
 
 	switch (encap_type) {
+	case UDP_ENCAP_FOU:
+		*p_ip_proto = fou_protocol;
+		ret = FLOW_DISSECT_RET_IPPROTO_AGAIN;
+		break;
 	case UDP_ENCAP_VXLAN:
 	case UDP_ENCAP_VXLAN_GPE:
 		ret = __skb_flow_dissect_vxlan(skb, flow_dissector,
diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index 8241f762e45b..137eb80c56a2 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -21,17 +21,6 @@
 
 #include "fou_nl.h"
 
-struct fou {
-	struct socket *sock;
-	u8 protocol;
-	u8 flags;
-	__be16 port;
-	u8 family;
-	u16 type;
-	struct list_head list;
-	struct rcu_head rcu;
-};
-
 #define FOU_F_REMCSUM_NOPARTIAL BIT(0)
 
 struct fou_cfg {
@@ -48,11 +37,6 @@ struct fou_net {
 	struct mutex fou_lock;
 };
 
-static inline struct fou *fou_from_sock(struct sock *sk)
-{
-	return sk->sk_user_data;
-}
-
 static int fou_recv_pull(struct sk_buff *skb, struct fou *fou, size_t len)
 {
 	/* Remove 'len' bytes from the packet (UDP header and
-- 
2.34.1


