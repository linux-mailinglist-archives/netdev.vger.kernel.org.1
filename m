Return-Path: <netdev+bounces-110843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFE492E906
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 15:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C3B282807
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 13:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E720115ECF9;
	Thu, 11 Jul 2024 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYbSzOLz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F356A15ECE8;
	Thu, 11 Jul 2024 13:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720703689; cv=none; b=qggWQYItvsSFKieJtTnCbFwqYi9yMYzuUcWSwGVKWtb8sJN8Ryux7qZFqUDxd9wtOQ6aJ0LbadXFmm8U/GqHLVDTbKogP4ddLn2KKj8b5OhUCx3KQG0SQ5Qb3BoLrw0fgXwG8rlSoSl8JohUqZolhTavEVOu2f+aWuA080qavg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720703689; c=relaxed/simple;
	bh=9G8XS2wtphz43VqzBU1txAKhGgyi2ubX8r62w9fEKo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MHA48OJvQtcR+3OBZoe3y1dYYALR1XEhDiiISe5SD2/XmYTIlaDgrfSADgwKyY6mhKSRazJZ+1Cvc3KMnL8GJjBHWb5ulSUgvZ+svo6RhVmej5iuv4058goxsWUpyivvwmoZnDmhVuM1Uuu+DGcfo4Xhej9L9+PyTAfYrGujpbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYbSzOLz; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-367a9ab4d81so447962f8f.1;
        Thu, 11 Jul 2024 06:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720703686; x=1721308486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kv/MFuHfyCwBSQ9yZ0GUCYIIFHVeU0epX1hLo6SPlh0=;
        b=BYbSzOLzwNPkcG9KJfh7nq+N4acdZUbhokiWMGZQq/1sxkpM7zd8868X4wdpdiJxO6
         fddgEHxows0fMjTS7Zb0MD0VGkrQfO8am0u4H6zCumjZqHhQRR0xVeODm9WE45QYj6U2
         eHybXCzdKo20pxdemCcKAExWvj7WT8a2d6arbU7mNyZGB4/Hf5t38f2EbdD17UONFkyo
         9f6cZ5YeF9TdARhUy1/abouOAqmrQTN44geHZQkrnui0sDxN9+/QuJLVZtz46miwBupo
         4w3ErpDJaCjwzK7CY+prK7RTpuU1nny8ZtkUD5Y0mIyYODC4iuONXlXWoVoIbUq1EOdm
         B2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720703686; x=1721308486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kv/MFuHfyCwBSQ9yZ0GUCYIIFHVeU0epX1hLo6SPlh0=;
        b=DxfOXXX47qVLyChzPPY0VudieHXzf9ZkiwBMF94G3pZlbGqjfNkS3NrKiJqAvDMTKS
         kQoD2OwmxjihWUYD+f82p4qMmN7o6YDa+2GYCzDjIrMYDAAvkQGmBXZBSjQzEQ44h4mv
         qHcWbaGzQ8RLAYlTowS+cr4dFsRFNLr6wpm7LEgA30zBG7eoYEo6d+hdI9sR0IIQot/a
         WLjdimYO5RFVmhrrmw1wkHUOMT3vxi5W1iznZ43lZqXad0m7MMk69FyQjRU0hTNZ4LUD
         nV9dHqy5mq+R1IWizU1XD3NuEyL2728PpQ3N1LrIYwkaWskV55dzMfd44L2PK4RjimmB
         Tmeg==
X-Forwarded-Encrypted: i=1; AJvYcCUQKlLhubxH2GjlKZ8k/OyuCvNyM/kRo5Tz93REOpl2KO6lfHMMIjUVqcJYmL7PsQHEQS5vO4Gnzkkbs5uXZGrkTVxxKFdBl7+EPo+Y5PtUVDhw/HcZ87/UO2LkAvKCPucpbIU7
X-Gm-Message-State: AOJu0YyHi86C+wf8XjQhCd1o+dkx8jnL+jNc0JVk+1d3UDdT9p58jcq7
	di2tYJTQ23ou+n5icessN/JxwJswnNjW2d15vgak1ndT5aLno6bI
X-Google-Smtp-Source: AGHT+IG29R1xkG7sO20UM7Bynb3QEWPylGMWz8i2r+kSlQaykhIEXIBYj4BavRXcp/veYVG4yqFpCw==
X-Received: by 2002:adf:e111:0:b0:363:d980:9a9e with SMTP id ffacd0b85a97d-367ceacab69mr5407151f8f.55.1720703686173;
        Thu, 11 Jul 2024 06:14:46 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7e1b3sm7686616f8f.20.2024.07.11.06.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 06:14:45 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	horms@kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v3 2/2] net: geneve: enable local address bind for geneve sockets
Date: Thu, 11 Jul 2024 15:14:11 +0200
Message-Id: <20240711131411.10439-3-richardbgobert@gmail.com>
In-Reply-To: <20240711131411.10439-1-richardbgobert@gmail.com>
References: <20240711131411.10439-1-richardbgobert@gmail.com>
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
 drivers/net/geneve.c               | 82 +++++++++++++++++++++++++++---
 include/net/geneve.h               |  6 +++
 include/uapi/linux/if_link.h       |  2 +
 tools/include/uapi/linux/if_link.h |  2 +
 4 files changed, 84 insertions(+), 8 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 838e85ddec67..6756851598b7 100644
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
@@ -653,16 +664,28 @@ static void geneve_sock_release(struct geneve_dev *geneve)
 
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
+		if (inet->inet_sport == dst_port &&
 		    geneve_get_sk_family(gs) == family) {
-			return gs;
+			if (family == AF_INET &&
+			    inet->inet_rcv_saddr == saddr->sin.sin_addr.s_addr)
+				return gs;
+#if IS_ENABLED(CONFIG_IPV6)
+			else if (ipv6_addr_cmp(&sk->sk_v6_rcv_saddr,
+					       &saddr->sin6.sin6_addr) == 0)
+				return gs;
+#endif
 		}
 	}
+
 	return NULL;
 }
 
@@ -675,14 +698,16 @@ static int geneve_sock_add(struct geneve_dev *geneve, bool ipv6)
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
 
@@ -1234,6 +1259,8 @@ static const struct nla_policy geneve_policy[IFLA_GENEVE_MAX + 1] = {
 	[IFLA_GENEVE_TTL_INHERIT]	= { .type = NLA_U8 },
 	[IFLA_GENEVE_DF]		= { .type = NLA_U8 },
 	[IFLA_GENEVE_INNER_PROTO_INHERIT]	= { .type = NLA_FLAG },
+	[IFLA_GENEVE_LOCAL]	= NLA_POLICY_EXACT_LEN(sizeof_field(struct iphdr, saddr)),
+	[IFLA_GENEVE_LOCAL6]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
 };
 
 static int geneve_validate(struct nlattr *tb[], struct nlattr *data[],
@@ -1561,6 +1588,34 @@ static int geneve_nl2info(struct nlattr *tb[], struct nlattr *data[],
 		cfg->inner_proto_inherit = true;
 	}
 
+	if (data[IFLA_GENEVE_LOCAL]) {
+		if (changelink && cfg->saddr.sa.sa_family != AF_INET) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_GENEVE_LOCAL],
+					    "New local address family does not match old");
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
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_GENEVE_LOCAL6],
+					    "New local address family does not match old");
+			return -EOPNOTSUPP;
+		}
+
+		cfg->saddr.sin6.sin6_addr = nla_get_in6_addr(data[IFLA_GENEVE_LOCAL6]);
+		cfg->saddr.sa.sa_family = AF_INET6;
+#else
+		NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_GENEVE_LOCAL6],
+				    "IPv6 support not enabled in the kernel");
+		return -EPFNOSUPPORT;
+#endif
+	}
+
 	return 0;
 change_notsup:
 	NL_SET_ERR_MSG_ATTR(extack, data[attrtype],
@@ -1741,6 +1796,7 @@ static size_t geneve_get_size(const struct net_device *dev)
 		nla_total_size(sizeof(__u8)) + /* IFLA_GENEVE_UDP_ZERO_CSUM6_RX */
 		nla_total_size(sizeof(__u8)) + /* IFLA_GENEVE_TTL_INHERIT */
 		nla_total_size(0) +	 /* IFLA_GENEVE_INNER_PROTO_INHERIT */
+		nla_total_size(sizeof(struct in6_addr)) + /* IFLA_GENEVE_LOCAL{6} */
 		0;
 }
 
@@ -1762,6 +1818,11 @@ static int geneve_fill_info(struct sk_buff *skb, const struct net_device *dev)
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
@@ -1772,6 +1833,11 @@ static int geneve_fill_info(struct sk_buff *skb, const struct net_device *dev)
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


