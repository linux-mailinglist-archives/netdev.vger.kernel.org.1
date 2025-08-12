Return-Path: <netdev+bounces-212907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BA7B22789
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 14:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C0CE5070E9
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F4228000B;
	Tue, 12 Aug 2025 12:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caC7RS6L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A0927FD4B;
	Tue, 12 Aug 2025 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003166; cv=none; b=Pg2/LSw0eqtA4xq4Fw8TdoiuxlwAEoqsevQcKIwMg5Yyuvv2bviykx6+BbUCORxZ+ENM3YeP+d4lYjiU6KoAlQZpXq2wsY/FwUzi4ELFJPA2GIEEmuchNQ2A8BsMWlTJUpmj1KURnkevR8hUw6JdSwsCW7GMaR0hDJpWSGHAHkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003166; c=relaxed/simple;
	bh=5lvuF/LKGzSpcvNCfJjlm8GefNR/bRr9nGxk/wEHGag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XywNb6cp47fouQEhxGadeAEPEypWotw0TxpI+GbYjstftoCcybXPi7GNu6C2p4JsRud18gWoN7F2pgPp42/X3Ev6pZ/QCPxXwKjfe9WGB8RBjDRVeoN0gb8FcLyklpascQ1uqT+Nz78dUYvMHEOKRoFymIPgEopkewQzAM/iq+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caC7RS6L; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a0dc77a15so10901275e9.2;
        Tue, 12 Aug 2025 05:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755003163; x=1755607963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZWoObKWxZ9g5L+SiOfuz0ooW5EC167z8BwusUyzlgE=;
        b=caC7RS6L13LIC19IlJQPNDcWqvrPJGvR/PcK5c5NWTOPiWJ4qUWJ8rOSPHr3cvDv2a
         pphC7M6eY1QDpVD1ssoyqJDj3yegZF/1Ae5f9KRssIN9oLsczXoSzDFBye8i5eP/fTKh
         pVRxvWHP4AluzVTgkV2SB4qIk6zh9D6RTMccBb54TFOsRItFdVrSKuXay5sgtdzxaNg1
         eZES/rxbIF8q4UCMSx2OavtsskKMQOiMyOv9rYZlIcfqGTqMhkGwlHgF3jRkqWezFG9X
         y/WMP1laOF+AVkQGAVTM/zNzOcl5bozuPpKu+pgVdx+zQt7KBOSWclDkExIZo67woBaf
         +tvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755003163; x=1755607963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZWoObKWxZ9g5L+SiOfuz0ooW5EC167z8BwusUyzlgE=;
        b=pEqKmiDsSZjCCbssHjcQOtVgZuPZEIPeevyNNciB0+inEa1tx8k4DYlTXsmCdJp1KS
         O5JIoDNpR/RnLf34iC0Ah9haML7W6WW8S3tTgVf7xWSpKP61W9LklRKiEJIhxxRM5VVB
         fejH/oB2xzNamyvHtMiFHJPJLy915+vAUpnok3xdCw/vGamar1L1hqjtfUNyuLMtjac6
         KZYZWZnXCcGV225TSP/jSWudEr5Wx6docZ3fiGfrFT/UFH6/aiyqsf+eKVVY19BuHpwt
         NkvjQQ1MqPEK6SsHtYDUEJaQ/aowJvn0NE0/0FnRMO7XW+XqbjsgFHc/o12gXxKghLRz
         wJog==
X-Forwarded-Encrypted: i=1; AJvYcCXMFLjjMqZwS62ObKouEGtYas+H3MI5DBwc0TtunquJjVOv5aWRjC+xKTWu16KcfwAAWvIQCLxGRfMHlRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1rI0YOwVPCh/V6xXl2HANfT6rLuNP7XsMLtIeSrgOo/JWtujV
	wILASujjOf0uJiFcFQxBnkIyaudeBUtTJCHtmMwHBO/H+GSl7rh+WsS9DDElBBT0MYYzxg==
X-Gm-Gg: ASbGnctiYTXMLGzeyEAd3VwnKUwV1hvvVvCY/Pp5TI00x/FNgtgDCLYsIHU8d8DghAp
	4iRC1WzlPh9UqwQy1Ew0gPN2x1JLPkOCVc9xrCN75EfkYbP2kXGFu7hciV9whe8XCXPP7wa99Mk
	FBUqeaOc77AvSnvDM9q9yDyJty6B9dTilt9iYoiBYJtEzx4XhUyyPnX/IXDKoWejN0An57QnN8n
	MfGqmm7NrRmZrAzg6oynFZvuZNQbBvdlVAothEy4q2kg3dV/9bL1II5jSZRKTL9PCfCr3QAiGGg
	uScI4wi5VFrv1nxPIn+p9JWBfN4HuOS9z3Ja9ax5cmZvJlvaW4pdWWFBTnaLVKH98j5q4uPL1eK
	toMNAqMHpVaWh19UefKmgr8CQ27/jBXovAg==
X-Google-Smtp-Source: AGHT+IGG+4mLBuigpNfF6lVk6qoiHtkhfDai6x6X4Q8m2lcCoJ/gzG9WGJ0x900Lt06/+r9abUHL+g==
X-Received: by 2002:a05:600c:1f0e:b0:458:c045:ee99 with SMTP id 5b1f17b1804b1-45a10c0f75cmr27229555e9.28.1755003162472;
        Tue, 12 Aug 2025 05:52:42 -0700 (PDT)
Received: from localhost ([45.10.155.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5873c43sm322343075e9.22.2025.08.12.05.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:52:42 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	andrew+netdev@lunn.ch,
	dsahern@kernel.org,
	shuah@kernel.org,
	daniel@iogearbox.net,
	jacob.e.keller@intel.com,
	razor@blackwall.org,
	idosch@nvidia.com,
	petrm@nvidia.com,
	menglong8.dong@gmail.com,
	martin.lau@kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v5 4/5] net: geneve: enable binding geneve sockets to local addresses
Date: Tue, 12 Aug 2025 14:51:54 +0200
Message-Id: <20250812125155.3808-5-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250812125155.3808-1-richardbgobert@gmail.com>
References: <20250812125155.3808-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow binding geneve sockets to local addresses, similar to
the VXLAN "local" option. Add a netlink option to configure
the local address.

Like VXLAN, Geneve sockets can be bound to non-local addresses,
meaning they may be UP before their outgoing interfaces.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 Documentation/netlink/specs/rt-link.yaml |  8 +++
 drivers/net/geneve.c                     | 80 +++++++++++++++++++++---
 include/net/geneve.h                     |  6 ++
 include/uapi/linux/if_link.h             |  2 +
 tools/include/uapi/linux/if_link.h       |  2 +
 5 files changed, 90 insertions(+), 8 deletions(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 210394c188a3..8188ca95fad6 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -1907,6 +1907,14 @@ attribute-sets:
         name: port-range
         type: binary
         struct: ifla-geneve-port-range
+      -
+        name: local
+        type: binary
+        display-hint: ipv4
+      -
+        name: local6
+        type: binary
+        display-hint: ipv6
   -
     name: linkinfo-iptun-attrs
     name-prefix: ifla-iptun-
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 54384f9b3872..2360ca891762 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -61,6 +61,7 @@ struct geneve_config {
 	bool			inner_proto_inherit;
 	u16			port_min;
 	u16			port_max;
+	union geneve_addr	saddr;
 };
 
 /* Pseudo network device */
@@ -465,7 +466,8 @@ static int geneve_udp_encap_err_lookup(struct sock *sk, struct sk_buff *skb)
 }
 
 static struct socket *geneve_create_sock(struct net *net, bool ipv6,
-					 __be16 port, bool ipv6_rx_csum)
+					 __be16 port, bool ipv6_rx_csum,
+					 union geneve_addr *local_addr)
 {
 	struct socket *sock;
 	struct udp_port_cfg udp_conf;
@@ -477,11 +479,20 @@ static struct socket *geneve_create_sock(struct net *net, bool ipv6,
 		udp_conf.family = AF_INET6;
 		udp_conf.ipv6_v6only = 1;
 		udp_conf.use_udp6_rx_checksums = ipv6_rx_csum;
+#if IS_ENABLED(CONFIG_IPV6)
+		memcpy(&udp_conf.local_ip6,
+		       &local_addr->sin6.sin6_addr,
+		       sizeof(local_addr->sin6.sin6_addr));
+#endif
 	} else {
 		udp_conf.family = AF_INET;
 		udp_conf.local_ip.s_addr = htonl(INADDR_ANY);
+		memcpy(&udp_conf.local_ip,
+		       &local_addr->sin.sin_addr,
+		       sizeof(local_addr->sin.sin_addr));
 	}
 
+	udp_conf.freebind = 1;
 	udp_conf.local_udp_port = port;
 
 	/* Open UDP socket */
@@ -586,7 +597,8 @@ static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
 
 /* Create new listen socket if needed */
 static struct geneve_sock *geneve_socket_create(struct net *net, __be16 port,
-						bool ipv6, bool ipv6_rx_csum)
+						bool ipv6, bool ipv6_rx_csum,
+						union geneve_addr *local_addr)
 {
 	struct geneve_net *gn = net_generic(net, geneve_net_id);
 	struct geneve_sock *gs;
@@ -598,7 +610,7 @@ static struct geneve_sock *geneve_socket_create(struct net *net, __be16 port,
 	if (!gs)
 		return ERR_PTR(-ENOMEM);
 
-	sock = geneve_create_sock(net, ipv6, port, ipv6_rx_csum);
+	sock = geneve_create_sock(net, ipv6, port, ipv6_rx_csum, local_addr);
 	if (IS_ERR(sock)) {
 		kfree(gs);
 		return ERR_CAST(sock);
@@ -657,12 +669,24 @@ static void geneve_sock_release(struct geneve_dev *geneve)
 
 static struct geneve_sock *geneve_find_sock(struct geneve_net *gn,
 					    sa_family_t family,
-					    __be16 dst_port)
+					    __be16 dst_port,
+					    union geneve_addr *saddr)
 {
 	struct geneve_sock *gs;
 
 	list_for_each_entry(gs, &gn->sock_list, list) {
-		if (inet_sk(gs->sock->sk)->inet_sport == dst_port &&
+		struct sock *sk = gs->sock->sk;
+		struct inet_sock *inet = inet_sk(sk);
+
+		if (family == AF_INET &&
+		    inet->inet_rcv_saddr != saddr->sin.sin_addr.s_addr)
+			continue;
+#if IS_ENABLED(CONFIG_IPV6)
+		else if (ipv6_addr_cmp(&sk->sk_v6_rcv_saddr,
+				       &saddr->sin6.sin6_addr) != 0)
+			continue;
+#endif
+		if (inet->inet_sport == dst_port &&
 		    geneve_get_sk_family(gs) == family) {
 			return gs;
 		}
@@ -679,14 +703,16 @@ static int geneve_sock_add(struct geneve_dev *geneve, bool ipv6)
 	__u8 vni[3];
 	__u32 hash;
 
-	gs = geneve_find_sock(gn, ipv6 ? AF_INET6 : AF_INET, geneve->cfg.info.key.tp_dst);
+	gs = geneve_find_sock(gn, ipv6 ? AF_INET6 : AF_INET,
+			      geneve->cfg.info.key.tp_dst, &geneve->cfg.saddr);
 	if (gs) {
 		gs->refcnt++;
 		goto out;
 	}
 
 	gs = geneve_socket_create(net, geneve->cfg.info.key.tp_dst, ipv6,
-				  geneve->cfg.use_udp6_rx_checksums);
+				  geneve->cfg.use_udp6_rx_checksums,
+				  &geneve->cfg.saddr);
 	if (IS_ERR(gs))
 		return PTR_ERR(gs);
 
@@ -1246,6 +1272,8 @@ static const struct nla_policy geneve_policy[IFLA_GENEVE_MAX + 1] = {
 	[IFLA_GENEVE_DF]		= { .type = NLA_U8 },
 	[IFLA_GENEVE_INNER_PROTO_INHERIT]	= { .type = NLA_FLAG },
 	[IFLA_GENEVE_PORT_RANGE]	= NLA_POLICY_EXACT_LEN(sizeof(struct ifla_geneve_port_range)),
+	[IFLA_GENEVE_LOCAL]	= NLA_POLICY_EXACT_LEN(sizeof_field(struct iphdr, saddr)),
+	[IFLA_GENEVE_LOCAL6]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
 };
 
 static int geneve_validate(struct nlattr *tb[], struct nlattr *data[],
@@ -1596,6 +1624,32 @@ static int geneve_nl2info(struct nlattr *tb[], struct nlattr *data[],
 		cfg->inner_proto_inherit = true;
 	}
 
+	if (data[IFLA_GENEVE_LOCAL]) {
+		if (changelink && (ip_tunnel_info_af(info) != AF_INET)) {
+			attrtype = IFLA_GENEVE_LOCAL;
+			goto change_notsup;
+		}
+
+		cfg->saddr.sin.sin_addr.s_addr = nla_get_in_addr(data[IFLA_GENEVE_LOCAL]);
+		cfg->saddr.sa.sa_family = AF_INET;
+	}
+
+	if (data[IFLA_GENEVE_LOCAL6]) {
+#if IS_ENABLED(CONFIG_IPV6)
+		if (changelink && (ip_tunnel_info_af(info) != AF_INET6)) {
+			attrtype = IFLA_GENEVE_LOCAL6;
+			goto change_notsup;
+		}
+
+		cfg->saddr.sin6.sin6_addr = nla_get_in6_addr(data[IFLA_GENEVE_LOCAL6]);
+		cfg->saddr.sa.sa_family = AF_INET6;
+#else
+		NL_SET_ERR_MSG_ATTR(extack, data[IFLA_GENEVE_LOCAL6],
+				    "IPv6 support not enabled in the kernel");
+		return -EPFNOSUPPORT;
+#endif
+	}
+
 	return 0;
 change_notsup:
 	NL_SET_ERR_MSG_ATTR(extack, data[attrtype],
@@ -1782,6 +1836,7 @@ static size_t geneve_get_size(const struct net_device *dev)
 		nla_total_size(sizeof(__u8)) + /* IFLA_GENEVE_TTL_INHERIT */
 		nla_total_size(0) +	 /* IFLA_GENEVE_INNER_PROTO_INHERIT */
 		nla_total_size(sizeof(struct ifla_geneve_port_range)) + /* IFLA_GENEVE_PORT_RANGE */
+		nla_total_size(sizeof(struct in6_addr)) + /* IFLA_GENEVE_LOCAL{6} */
 		0;
 }
 
@@ -1807,16 +1862,25 @@ static int geneve_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		if (nla_put_in_addr(skb, IFLA_GENEVE_REMOTE,
 				    info->key.u.ipv4.dst))
 			goto nla_put_failure;
+
+		if (nla_put_in_addr(skb, IFLA_GENEVE_LOCAL,
+				    info->key.u.ipv4.src))
+			goto nla_put_failure;
+
 		if (nla_put_u8(skb, IFLA_GENEVE_UDP_CSUM,
 			       test_bit(IP_TUNNEL_CSUM_BIT,
 					info->key.tun_flags)))
 			goto nla_put_failure;
-
 #if IS_ENABLED(CONFIG_IPV6)
 	} else if (!metadata) {
 		if (nla_put_in6_addr(skb, IFLA_GENEVE_REMOTE6,
 				     &info->key.u.ipv6.dst))
 			goto nla_put_failure;
+
+		if (nla_put_in6_addr(skb, IFLA_GENEVE_LOCAL6,
+				     &info->key.u.ipv6.src))
+			goto nla_put_failure;
+
 		if (nla_put_u8(skb, IFLA_GENEVE_UDP_ZERO_CSUM6_TX,
 			       !test_bit(IP_TUNNEL_CSUM_BIT,
 					 info->key.tun_flags)))
diff --git a/include/net/geneve.h b/include/net/geneve.h
index 5c96827a487e..7b12c70db11f 100644
--- a/include/net/geneve.h
+++ b/include/net/geneve.h
@@ -62,6 +62,12 @@ struct genevehdr {
 	u8 options[];
 };
 
+union geneve_addr {
+	struct sockaddr_in sin;
+	struct sockaddr_in6 sin6;
+	struct sockaddr sa;
+};
+
 static inline bool netif_is_geneve(const struct net_device *dev)
 {
 	return dev->rtnl_link_ops &&
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 7350129b1444..ff362d76a0d4 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1442,6 +1442,8 @@ enum {
 	IFLA_GENEVE_DF,
 	IFLA_GENEVE_INNER_PROTO_INHERIT,
 	IFLA_GENEVE_PORT_RANGE,
+	IFLA_GENEVE_LOCAL,
+	IFLA_GENEVE_LOCAL6,
 	__IFLA_GENEVE_MAX
 };
 #define IFLA_GENEVE_MAX	(__IFLA_GENEVE_MAX - 1)
diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index eee934cc2cf4..894a1aa91133 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -1438,6 +1438,8 @@ enum {
 	IFLA_GENEVE_TTL_INHERIT,
 	IFLA_GENEVE_DF,
 	IFLA_GENEVE_INNER_PROTO_INHERIT,
+	IFLA_GENEVE_LOCAL,
+	IFLA_GENEVE_LOCAL6,
 	__IFLA_GENEVE_MAX
 };
 #define IFLA_GENEVE_MAX	(__IFLA_GENEVE_MAX - 1)
-- 
2.36.1


