Return-Path: <netdev+bounces-120728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2B095A67B
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 23:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536501C226AF
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 21:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6972217A5B7;
	Wed, 21 Aug 2024 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="N55au1ZO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02FB17A582
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 21:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275368; cv=none; b=UXqKEfTipyKoZDK+ZEa8omDm6uQCLC30FSs/cFVdS7h5DI4HRhgtwVPYBD7qa0cyLj58j4HfipxRZTUTAkHZHYMIXMCnN4gvB/5MjuKaSCsx8YzRLglO6yelqpLr9l8X06Dcd81q4e+JlQV9J5yu1qjqeXq8HTFpJjHKMIuXIgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275368; c=relaxed/simple;
	bh=iy/IjVlTNGIofXJn+fBanD7oMgCF1XdUz+M/FUjwUds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jkAWFdOilnD4MoXdLfyoLzrlbxeKZ63HG94aNa45mziWT4Q5ar3FCuCTHdfQYl2M0ZY6OMivC3fB73S7rJVtiP0FYBuiLciDTPWkceY8qWJxhG7tgnTfWTRIRCuTwE12XBVnzlNOlONju1oGO428fqTIBIwlCXWz1ueLnNuGpo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=N55au1ZO; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2021a99af5eso1215215ad.1
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 14:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724275366; x=1724880166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94T3lUdDtdwgdQTFptlIHtyUqLExlHZ5i97VvNIbOjU=;
        b=N55au1ZOOxMMetgtSVbN0nBR01PD8apOgWLfKNXN8WhfEaeNdgI/AR4hWrVa04vzzk
         mEhry90aU6T5XV8nnCGnOaS/QxNxAlDbWrahis8JzBskttlAMVkeM00FUor8fZ5B57dy
         ICBUn8eFIetLuDSSt5wlOio/iJJHMYclV57Ur0rALam19CirVprASkEvVDeAWd/EEKDF
         IHGB1oGAKpzqkBks5a+fT+rXyYVPHMGIMZX7fqBTQMeiTEk5S+pP+G3zu5KXQf40mdWa
         ovdyEfwPb7n2xva4IEl7YLdlYkXP+jliKAHWZZa48pYYpYhyqgO9SrD8Ih491gTXHn8e
         S3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275366; x=1724880166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94T3lUdDtdwgdQTFptlIHtyUqLExlHZ5i97VvNIbOjU=;
        b=ih8v+QCOC1sDaPvMJ2d9t6qNU4BcwFn2FC7EoZncWYUT3fP3TZv7aGn7L4FnlX17Js
         tGUF8EBmBCppmQjHg9Ct18ktRr8ZDIfpuaGxX447pe9i2Ib1Mh+H246AYtrTOGf/OUmX
         /2id8RxGIM4eOq69fi+Q5KVD/CJp0YVF7KWvmSqRfwtNZi8ZCE0Uuzl0c613OTpokf28
         Xi6k0ntqwp6PGwzMt+f42KiDgua4DCNSkGRuDn9pZfLflpQ6sghq0KjPteu2LWboAbNg
         UdWvE1qV19Iwbpm8bhybup50VXxoJ2xmS/xM0yrNo4h+9Eac4afogVjoJUFJQ1XbP5L6
         RKgg==
X-Forwarded-Encrypted: i=1; AJvYcCXJ1aDGM+GrV6wvrLyMXeElmaELeoMY69Bp+ejrCs9XNRNjzvyS296zIY13HyyVbNlayNobgKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMNKKAp6220f0frrd6kIIIVP2kAurBT6E5P6s3z3p18z8lNTk1
	5AlwRbG/h34dBp9Xg6uMpcxd5nMZFymglNF1QdAhLUx6UjarWGXNhACg0soUyQ==
X-Google-Smtp-Source: AGHT+IEHs5LtiLfbSIneogDIjUwPMc4bZeyIS/QRdHx8u3hzFdb7oh+J2yjCLQxcGgUZjXIS+YA46A==
X-Received: by 2002:a17:902:c409:b0:1fb:75b6:a40e with SMTP id d9443c01a7336-20368094748mr45581615ad.45.1724275366022;
        Wed, 21 Aug 2024 14:22:46 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:7a19:cf52:b518:f0d2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385ae701dsm388265ad.236.2024.08.21.14.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:22:45 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	willemdebruijn.kernel@gmail.com,
	pablo@netfilter.org,
	laforge@gnumonks.org,
	xeb@mail.ru
Cc: Tom Herbert <tom@herbertland.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v3 07/13] flow_dissector: Parse foo-over-udp (FOU)
Date: Wed, 21 Aug 2024 14:22:06 -0700
Message-Id: <20240821212212.1795357-8-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821212212.1795357-1-tom@herbertland.com>
References: <20240821212212.1795357-1-tom@herbertland.com>
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
index 452178cf0b59..fed1f98358e8 100644
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
@@ -855,11 +856,11 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
 		       u8 *p_ip_proto, int base_nhoff, unsigned int flags,
 		       unsigned int num_hdrs)
 {
+	__u8 encap_type, fou_protocol;
 	enum flow_dissect_ret ret;
 	const struct udphdr *udph;
 	struct udphdr _udph;
 	struct sock *sk;
-	__u8 encap_type;
 	int nhoff;
 
 	if (!(flags & FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS))
@@ -906,6 +907,9 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
 		}
 
 		encap_type = udp_sk(sk)->encap_type;
+		if (encap_type == UDP_ENCAP_FOU)
+			fou_protocol = fou_from_sock(sk)->protocol;
+
 		rcu_read_unlock();
 
 		break;
@@ -942,6 +946,9 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
 		}
 
 		encap_type = udp_sk(sk)->encap_type;
+		if (encap_type == UDP_ENCAP_FOU)
+			fou_protocol = fou_from_sock(sk)->protocol;
+
 		rcu_read_unlock();
 
 		break;
@@ -956,6 +963,10 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
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


