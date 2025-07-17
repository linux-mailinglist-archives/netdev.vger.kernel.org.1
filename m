Return-Path: <netdev+bounces-207838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA19B08C3F
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 13:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C8F3A69E4
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE462BDC06;
	Thu, 17 Jul 2025 11:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Npy2UPfZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C53D136358;
	Thu, 17 Jul 2025 11:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753315; cv=none; b=oAe9Ke+770CdB0NLf0rs4qfN/LgADzChT+0JShNREwJo4q1MeotWdI100UKho6Le2t3FtP9FjmWV1dnUd3F5H0DzB0uyE6o5p9rdHiiEf725hxxEbRWV9xGBCdQ/7xtckfN1vuVvdiNGtZPFxEICxYqWyLeTERGnFc6isDZaYDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753315; c=relaxed/simple;
	bh=eE6ITxDuIJfEiD0MPyo74zQJCWbgv/+KNDuj42o3f4o=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gMiRpCY/izSPxUyUyAKkQfI3/BwU5OJb0IWrblH6dVyD/XMONah41myigErtVsPKkVwfZUQSv/FHFdT3RPKdLLwhin7cl29yr8fgfCWCk0Ld5uIlCtWirmICkmSVtmEZ2YzBlLTjsHuuuAUgzGvHkMiJm4zCp7OoegnrR6Z9K+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Npy2UPfZ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4f379662cso646811f8f.0;
        Thu, 17 Jul 2025 04:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752753312; x=1753358112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=flDybFiyCaDc4poe3ad+U4bvumYcoJHYkl7fFvJ0otI=;
        b=Npy2UPfZJCYjXlP0iE0Z5F1C3DFYW36UXAWAvY+QoQKE9t5f1F/VrP7BAv9XeTR54h
         Z86YJVkq2SBpBDSx8MCbyWxdcj0KOr13c9Nicx5LNY1w7BasKydyyoLfAUAeNUqngZv6
         eINQ4CRe31lLwJqyQCDVCJWknkiinepYmlsZGS6qDR5t5Cf5lpkYucdOOEWRzbl2xuoa
         yx1+xlUxCSWFScqX8dXEUGKBmYcEQoUimeq8HHFEe0GRIgSZkLngbKSDTHSqn/brvjw4
         1N3pbWiXobtIqEV//ueWMbC4BScz7/gnIeRxTLp3nyl6ZFsX4oeMTX/lbNodWF6AAnSl
         KfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752753312; x=1753358112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flDybFiyCaDc4poe3ad+U4bvumYcoJHYkl7fFvJ0otI=;
        b=gKvPjTwnWDPYSJuECMTtlps22UmZLJHus5rV1TzrLnOgCoTJO2i6Ig/qhmzpjOIA/r
         bghH+nWo0/H6zG6b9jhvK2hTGo2X4X0UeY+nWne9RTAI7nZVZXN+hsZoN8wryVtRCU2k
         4X90ibF0ufQYfSBcqnnGh+Vb/wTZE+msqBIOhKC5J2e5LQP6kxWnzjTHjw5oVS/7xKeR
         XLqRqaT4HTPkNU3C8vR+MImJ13e1C1zx3+Mz+7CoQ0vqf7mZzr1lOJo/9yuo4CWna8Sq
         nbiO90inqvoDp8BGQTJgQ6lfPofNcMpxG43/pGLw/VSqQRjG9THQIMPM3vqKUl5B6dnx
         NfLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU84KioPw/daJXURBMNPmxpiTKvJO4ldioJv1A2wUmuYEtkHSo23NQXiYJOgIt1R/ZJVeNBnWM47gYhfM0=@vger.kernel.org, AJvYcCWdp+Cyd6Puc0JEqD54wTrJoMNvX6uMwNIk7t5CaXtBY6a5wvzm35aNq+hsh/lNdPvtdZ+7RJ91@vger.kernel.org
X-Gm-Message-State: AOJu0YyFIrT6Qz6s24gQan2jscW+MmBzIEWMddDy2E9JXjV6DFF4J6Kj
	uLiD+vk1M8i5OHpnRx0/fUnQHlGXJAt3m3Elm0iKai+fOFRV6VrOW0WX
X-Gm-Gg: ASbGnctRx3yWhFf7ggVrx2NyIk9rEOL0r/U0KwYAtMyMqdL+zeOzRJkRZ9TfyYmFT73
	IQdcc03Pvv4f8FSDTiv51prI/3lzHXKpaEKMKKdGUUm6vZuCGtZ0wYJP6A/DhHBKudgKOlbM21+
	/0x0hQXBOT0Quu0xb/xqvxBEllDqQeAGjbxlz2JhzAfYhp/ODcJ/tP0TTi8DgUP1dV08OSoXQCF
	Y+QfweFVv55QVM5JHnUTCX70Db+LmqDfztcmhJxr5Eld5UC8qtcJeg57YruoAkB+4ZbL44RTdeO
	5YTsXI3rjTlT9dV8ypTH9s55Hh3GRoCMnAnfKmVCsCMWAD9gN9HdcvcxBu8amJoF
X-Google-Smtp-Source: AGHT+IGIKfh4UTQ2Yhz/05JGa5MRm0R4h9gb11NzCJ+FgcdoRBhzp7NO+ZZam7qCZw+LjhLURgBtDQ==
X-Received: by 2002:a05:6000:4801:b0:3a4:f7d9:3f56 with SMTP id ffacd0b85a97d-3b60e4b831fmr4778902f8f.2.1752753311437;
        Thu, 17 Jul 2025 04:55:11 -0700 (PDT)
Received: from localhost ([45.84.137.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc3a62sm20393530f8f.40.2025.07.17.04.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 04:55:11 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	razor@blackwall.org,
	idosch@nvidia.com,
	petrm@nvidia.com,
	menglong8.dong@gmail.com,
	richardbgobert@gmail.com,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 4/4] net: geneve: enable binding geneve sockets to local addresses
Date: Thu, 17 Jul 2025 13:54:12 +0200
Message-Id: <20250717115412.11424-5-richardbgobert@gmail.com>
In-Reply-To: <20250717115412.11424-1-richardbgobert@gmail.com>
References: <20250717115412.11424-1-richardbgobert@gmail.com>
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
 drivers/net/geneve.c               | 80 +++++++++++++++++++++++++++---
 include/net/geneve.h               |  6 +++
 include/uapi/linux/if_link.h       |  2 +
 tools/include/uapi/linux/if_link.h |  2 +
 4 files changed, 82 insertions(+), 8 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 54384f9b3872..bc88b9a52410 100644
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
+						union geneve_addr *saddr)
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
+
+		else if (ipv6_addr_cmp(&sk->sk_v6_rcv_saddr,
+				       &saddr->sin6.sin6_addr) != 0)
+			continue;
+
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


