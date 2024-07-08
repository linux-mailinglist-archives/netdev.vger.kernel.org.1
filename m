Return-Path: <netdev+bounces-109834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F5792A0C0
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 13:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B621C20FC8
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 11:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EA97FBA8;
	Mon,  8 Jul 2024 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xs3TkAQU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D997E563;
	Mon,  8 Jul 2024 11:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720437161; cv=none; b=IDwj5yEesTy/0ixcKNghv/fIBOMtJ6ALmDe9VlX3Cp31j8w49EofOgepd8zJDs1FVNy6sJgfzLHVCx0zbH7zEIzN6r2jiAsZBbuR+TFaeXk2wGGJ9pdBdvfYSPhfZhADae45pBoOxKElq272Ap46g9XlaBXPzG8GD2z7eEhg+1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720437161; c=relaxed/simple;
	bh=5BLcsTfo0rV5f4qZJpImeGyVeTz/xEjb4R0RfWgOikI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EqILwUTvTTxFO/v1bHE066bGKlu6ZyhXfIAN+i4hQLtxsZtNOy2IF0tiHW0oJmRGWz7ftXsoQQJhKkukTiE7hh0eNtrPzpCglY1+WuTUmGcGUERtlgeRPD7aqrpsMwO1styYYJd802z46dZr0f8UJ9+Mlk6WU5roC8uSE3L3Dwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xs3TkAQU; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52e9f863c46so4017577e87.1;
        Mon, 08 Jul 2024 04:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720437157; x=1721041957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moshSUpTB58NWCr+RD24wwBakIQnGrq783baZS6Dezg=;
        b=Xs3TkAQU6iS/dEpfxmoMMWMWuKgTzryND12/41JlU0U1f7y4Da0GjdbBj9mBjoMrIf
         447SNbidIxqbRTwn+c3q4PO/lQDSgpXG+mM6aBf5M1VLvx7IpY1sLn83AZ7bUXnmPZ/w
         GsYY9vNysCzdwPbDE6DNeEQsJBPAOit2uCzCHw9DDaiZuAovD926T+Q8rdlO9rYuZdjs
         2Adw2jY4nXAmKJvW0K7MTXwsOadgCHWZj/p9j2+Tcg3OD3Br8ozii/l4T0DZpd9yc1c+
         fA0QX5QHO2L46x4dpuIAfpgFjviGPQeEjGmOeJkezIbkCaLf59I6lvYhkPBSpdRk8grx
         doHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720437157; x=1721041957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moshSUpTB58NWCr+RD24wwBakIQnGrq783baZS6Dezg=;
        b=nz9iIl1gcrHVraNHFT8qYEP3pzrHC5J/suDCxKZrZw+4fqP1hnSVvjyzdmL3V83Fdt
         k8ZHK0mHWHbOtcps2wHt/8BLwypJzYyhXSiApK6s9fqCzRhDpTXo/0ose0Uf7lf6nu0C
         TAfWTtWSwYpc+rkywmQC+q25SQa+8BkxN01pk8d/tTkv1y0uH94GHv4MY1SLO38xjZ1t
         1FnRYmdNhjXv5aoJ7mgJMZ+Z7P0ITUVhPlz1c3geJmQZVkW/RE2AD6kNOxh+F2kVjpPg
         uf9qXDFZ3IakEb+ctF1LWc+Bf3UDf5krUmTmV/CJufrC5tEc0TgL/zPr4NC1xr1TVuLo
         LS6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbaKQTcuYAymVRjZten4DoLDAJUVqeg6kz/bieKC/qzeH81NKmTa1b6JCR3tJKW7OSH2K2gjMJzhYfZJawEiEyImAIIYtHJG7iyup/TiJldU7yUrP9ibMAmjWSHv0sl41O9M3x
X-Gm-Message-State: AOJu0Yzz1mCRu3OtcbOjJzl/KXli1uI57aViPuQHe4JdhVc24SPXlNk8
	4Lwn1SEYSY55Wx/2XEY0jyK0kT//8bQpJ7n6gI5pBvxokJkkz0if
X-Google-Smtp-Source: AGHT+IE/QZe2jq+2zc6qJ5cM6luB7AB54IQHSX6ZtrahaqxiOGpqj60NN3IUSliA6KkCvVwT6VFuxA==
X-Received: by 2002:a19:6b0e:0:b0:52e:9df2:7ddd with SMTP id 2adb3069b0e04-52ea0629d76mr7520380e87.22.1720437157014;
        Mon, 08 Jul 2024 04:12:37 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36799382af8sm11288592f8f.59.2024.07.08.04.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 04:12:36 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	idosch@nvidia.com,
	amcohen@nvidia.com,
	petrm@nvidia.com,
	gnault@redhat.com,
	jbenc@redhat.com,
	b.galvani@gmail.com,
	martin.lau@kernel.org,
	daniel@iogearbox.net,
	aahila@google.com,
	liuhangbin@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v2 2/2] net: geneve: enable local address bind for geneve sockets
Date: Mon,  8 Jul 2024 13:11:03 +0200
Message-Id: <20240708111103.9742-3-richardbgobert@gmail.com>
In-Reply-To: <20240708111103.9742-1-richardbgobert@gmail.com>
References: <20240708111103.9742-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for binding to a local address in geneve sockets.
It achieves this by adding a new netlink local argument and geneve_addr union
to represent local address to bind to, and copying it to udp_port_cfg in
geneve_create_sock.

Also change geneve_find_sock to search the socket based on listening address.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 drivers/net/geneve.c               | 78 ++++++++++++++++++++++++++----
 drivers/net/vxlan/vxlan_core.c     |  5 +-
 include/net/geneve.h               |  6 +++
 include/uapi/linux/if_link.h       |  2 +
 tools/include/uapi/linux/if_link.h |  2 +
 5 files changed, 81 insertions(+), 12 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 838e85ddec67..d192efdfabcd 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -57,6 +57,7 @@ struct geneve_config {
 	bool			ttl_inherit;
 	enum ifla_geneve_df	df;
 	bool			inner_proto_inherit;
+	union geneve_addr saddr;
 };
 
 /* Pseudo network device */
@@ -461,7 +462,8 @@ static int geneve_udp_encap_err_lookup(struct sock *sk, struct sk_buff *skb)
 }
 
 static struct socket *geneve_create_sock(struct net *net, bool ipv6,
-					 __be16 port, bool ipv6_rx_csum)
+					 __be16 port, bool ipv6_rx_csum,
+					 union geneve_addr *local_addr)
 {
 	struct socket *sock;
 	struct udp_port_cfg udp_conf;
@@ -473,9 +475,17 @@ static struct socket *geneve_create_sock(struct net *net, bool ipv6,
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
 
 	udp_conf.local_udp_port = port;
@@ -582,7 +592,8 @@ static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
 
 /* Create new listen socket if needed */
 static struct geneve_sock *geneve_socket_create(struct net *net, __be16 port,
-						bool ipv6, bool ipv6_rx_csum)
+						bool ipv6, bool ipv6_rx_csum,
+						union geneve_addr *local_addr)
 {
 	struct geneve_net *gn = net_generic(net, geneve_net_id);
 	struct geneve_sock *gs;
@@ -594,7 +605,7 @@ static struct geneve_sock *geneve_socket_create(struct net *net, __be16 port,
 	if (!gs)
 		return ERR_PTR(-ENOMEM);
 
-	sock = geneve_create_sock(net, ipv6, port, ipv6_rx_csum);
+	sock = geneve_create_sock(net, ipv6, port, ipv6_rx_csum, local_addr);
 	if (IS_ERR(sock)) {
 		kfree(gs);
 		return ERR_CAST(sock);
@@ -653,16 +664,25 @@ static void geneve_sock_release(struct geneve_dev *geneve)
 
 static struct geneve_sock *geneve_find_sock(struct geneve_net *gn,
 					    sa_family_t family,
-					    __be16 dst_port)
+					    __be16 dst_port,
+					    union geneve_addr *saddr)
 {
 	struct geneve_sock *gs;
 
 	list_for_each_entry(gs, &gn->sock_list, list) {
-		if (inet_sk(gs->sock->sk)->inet_sport == dst_port &&
-		    geneve_get_sk_family(gs) == family) {
-			return gs;
+		struct sock *sk = gs->sock->sk;
+		struct inet_sock *inet = inet_sk(sk);
+
+		if (inet->inet_sport == dst_port && geneve_get_sk_family(gs) == family) {
+			if (family == AF_INET && inet->inet_rcv_saddr == saddr->sin.sin_addr.s_addr)
+				return gs;
+#if IS_ENABLED(CONFIG_IPV6)
+			else if (ipv6_addr_cmp(&sk->sk_v6_rcv_saddr, &saddr->sin6.sin6_addr) == 0)
+				return gs;
+#endif
 		}
 	}
+
 	return NULL;
 }
 
@@ -675,14 +695,16 @@ static int geneve_sock_add(struct geneve_dev *geneve, bool ipv6)
 	__u8 vni[3];
 	__u32 hash;
 
-	gs = geneve_find_sock(gn, ipv6 ? AF_INET6 : AF_INET, geneve->cfg.info.key.tp_dst);
+	gs = geneve_find_sock(gn, ipv6 ? AF_INET6 : AF_INET, geneve->cfg.info.key.tp_dst,
+			      &geneve->cfg.saddr);
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
 
@@ -1234,6 +1256,8 @@ static const struct nla_policy geneve_policy[IFLA_GENEVE_MAX + 1] = {
 	[IFLA_GENEVE_TTL_INHERIT]	= { .type = NLA_U8 },
 	[IFLA_GENEVE_DF]		= { .type = NLA_U8 },
 	[IFLA_GENEVE_INNER_PROTO_INHERIT]	= { .type = NLA_FLAG },
+	[IFLA_GENEVE_LOCAL]	= NLA_POLICY_EXACT_LEN(sizeof_field(struct iphdr, saddr)),
+	[IFLA_GENEVE_LOCAL6]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
 };
 
 static int geneve_validate(struct nlattr *tb[], struct nlattr *data[],
@@ -1561,6 +1585,31 @@ static int geneve_nl2info(struct nlattr *tb[], struct nlattr *data[],
 		cfg->inner_proto_inherit = true;
 	}
 
+	if (data[IFLA_GENEVE_LOCAL]) {
+		if (changelink && cfg->saddr.sa.sa_family != AF_INET) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_GENEVE_LOCAL], "New local address family does not match old");
+			return -EOPNOTSUPP;
+		}
+
+		cfg->saddr.sin.sin_addr.s_addr = nla_get_in_addr(data[IFLA_GENEVE_LOCAL]);
+		cfg->saddr.sa.sa_family = AF_INET;
+	}
+
+	if (data[IFLA_GENEVE_LOCAL6]) {
+#if IS_ENABLED(CONFIG_IPV6)
+		if (changelink && cfg->saddr.sa.sa_family != AF_INET6) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_GENEVE_LOCAL6], "New local address family does not match old");
+			return -EOPNOTSUPP;
+		}
+
+		cfg->saddr.sin6.sin6_addr = nla_get_in6_addr(data[IFLA_GENEVE_LOCAL6]);
+		cfg->saddr.sa.sa_family = AF_INET6;
+#else
+		NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_GENEVE_LOCAL6], "IPv6 support not enabled in the kernel");
+		return -EPFNOSUPPORT;
+#endif
+	}
+
 	return 0;
 change_notsup:
 	NL_SET_ERR_MSG_ATTR(extack, data[attrtype],
@@ -1741,6 +1790,7 @@ static size_t geneve_get_size(const struct net_device *dev)
 		nla_total_size(sizeof(__u8)) + /* IFLA_GENEVE_UDP_ZERO_CSUM6_RX */
 		nla_total_size(sizeof(__u8)) + /* IFLA_GENEVE_TTL_INHERIT */
 		nla_total_size(0) +	 /* IFLA_GENEVE_INNER_PROTO_INHERIT */
+		nla_total_size(sizeof(struct in6_addr)) + /* IFLA_GENEVE_LOCAL{6} */
 		0;
 }
 
@@ -1762,6 +1812,11 @@ static int geneve_fill_info(struct sk_buff *skb, const struct net_device *dev)
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
@@ -1772,6 +1827,11 @@ static int geneve_fill_info(struct sk_buff *skb, const struct net_device *dev)
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
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 9a797147beb7..79be743874c7 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -90,13 +90,12 @@ static struct vxlan_sock *vxlan_find_sock(struct net *net, sa_family_t family,
 		    vxlan_get_sk_family(vs) == family &&
 		    vs->flags == flags &&
 		    vs->sock->sk->sk_bound_dev_if == ifindex) {
-			if (family == AF_INET && inet->inet_rcv_saddr == saddr->sin.sin_addr.s_addr) {
+			if (family == AF_INET && inet->inet_rcv_saddr == saddr->sin.sin_addr.s_addr)
 				return vs;
-			}
+
 #if IS_ENABLED(CONFIG_IPV6)
 			else if (ipv6_addr_cmp(&sk->sk_v6_rcv_saddr, &saddr->sin6.sin6_addr) == 0)
 				return vs;
-			}
 #endif
 		}
 
diff --git a/include/net/geneve.h b/include/net/geneve.h
index 5c96827a487e..8dcd7fff2c0f 100644
--- a/include/net/geneve.h
+++ b/include/net/geneve.h
@@ -68,6 +68,12 @@ static inline bool netif_is_geneve(const struct net_device *dev)
 	       !strcmp(dev->rtnl_link_ops->kind, "geneve");
 }
 
+union geneve_addr {
+	struct sockaddr_in sin;
+	struct sockaddr_in6 sin6;
+	struct sockaddr sa;
+};
+
 #ifdef CONFIG_INET
 struct net_device *geneve_dev_create_fb(struct net *net, const char *name,
 					u8 name_assign_type, u16 dst_port);
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 6dc258993b17..25ddf4dda47b 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1419,6 +1419,8 @@ enum {
 	IFLA_GENEVE_TTL_INHERIT,
 	IFLA_GENEVE_DF,
 	IFLA_GENEVE_INNER_PROTO_INHERIT,
+	IFLA_GENEVE_LOCAL,
+	IFLA_GENEVE_LOCAL6,
 	__IFLA_GENEVE_MAX
 };
 #define IFLA_GENEVE_MAX	(__IFLA_GENEVE_MAX - 1)
diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index f0d71b2a3f1e..8321c8b32f6e 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -888,6 +888,8 @@ enum {
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


