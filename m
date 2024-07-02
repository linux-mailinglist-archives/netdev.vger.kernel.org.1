Return-Path: <netdev+bounces-108514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6BE9240CF
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 16:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F9B1F23A0C
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 14:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2C01BA87E;
	Tue,  2 Jul 2024 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOtVC89n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F12D1B5837;
	Tue,  2 Jul 2024 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930390; cv=none; b=XKR66CHt/5Vi5JhO+vDXH9wXXekrzM4rCfqsua5AO16Sgcg8IG27LiZ2KTNAx6uwYBR6wC2XrEfskLyf8jwHql5D7MLZpArUkeaGDmkYi0z6htpXWw5fi2vRJaBG/uISUCzM4IqnjzFPi8HGQj06auCgo31uLIaHctZPjADdT3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930390; c=relaxed/simple;
	bh=Ql5Cmxr3kku2hogu34XCPqXs+1xbAKubjFv3FsUXM+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ufi0ue8clfarWgIBO7t3hd71xpsa1R17O52SCyPqrsbOocqrxE3zU3ETJcUcREkmmKWi5MzptpnfrRsmtY+iWowD7aAXYXQBpKAh7LPy8IeQSlYUClf6f4iRJiw08kscsIg2lFbth0M1PwqO5PMk/uGmK39prKqNOkKqbOzH4Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOtVC89n; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-42565697036so31847275e9.1;
        Tue, 02 Jul 2024 07:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719930387; x=1720535187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4MqlWd8iHWYyXJMtIyjohC0qGpKJ9VdkQfGVkxrLK8=;
        b=VOtVC89n4axoHcULV2arn3c7dsouvl3oK4TcHloATOtK20jAo92RJMNJObPSr0DTeZ
         DNDSNdHjCfT/2Nk7RmKZdFbWeOM70r9YRLEv4KwIcTF38VgAhnavBvHfCTcZGULg0cjq
         9s0ETLZ6aEalBmCKptSjB1IB5cCfcUPYS04+k8a0cYnSJyZyAS0KD1BUpXVCD9Fw1X/W
         JmgQpfahDXhsGiHPo7tPupRI8ilnSIXfWZKxo/VkjyG3T5xO9BoLPGWVSlwaloCwjHw0
         LbPt3MQJGg5ae4p+JTfr+HZguScXCkFCOPXCUkH6ZmQYS0YXb+U5ynV53VCWc5Y/Evuk
         FdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719930387; x=1720535187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4MqlWd8iHWYyXJMtIyjohC0qGpKJ9VdkQfGVkxrLK8=;
        b=wu4EBKSJlCHMA75t+n42AahmjLsEDJSPwzfB98ocLBxkjRoaYxAWSUp/BdagBqWsp6
         pMElJ1SqtRi9FAKl24f6OYq5XH38SAdojXJ7hMiZxXqYAnPeDyHCuEWrOC1VOgaH8viV
         fjrXkBN1q+gqCDskLDjsSZyR8hsKJIpEwxQRvkbPZaYYVNbbhK58PN5ZSx1LCFjorl5a
         aXGjs427RGRjWq18z1+gK7sxmOl5xZmknZtu2ZLYGj545JljVjz1Idn6jwN/RLmy4Q8x
         pzhpOFYD0DHPq6nZw5jyoFKpI1uJYSGaV+vvtwwnn4sFKRTzEJYYlVDRW1GKWALnXUir
         BQKg==
X-Forwarded-Encrypted: i=1; AJvYcCXetmjB/dYCilp0ruLLzFtoUzcyB3JelTVB2KDShprf7EnuxPvfjHyTGj4DQU1tpkPUjn16EYXOLSBbZE+nJxEHGMkEejWVCBa7egz5adShnNTGdrNHm+JMlKWk+yFcg7MO7RW3
X-Gm-Message-State: AOJu0Yyu4++57N8oSJ5Ne1o89cUiCoJn2DoAFkUuouFcGqVWJplkQs/y
	q12WXawwd5j1cY+TVajPzDmFvMBYkW6N0DUPxiFuVHu6vTrJrBMx
X-Google-Smtp-Source: AGHT+IGP4qE3Tvj79sElNbVWh0i9sNSGavCUhOuw3ifq7rizBdsGaHa2Na+Id4inXue2VNQMbc1wLA==
X-Received: by 2002:a05:600c:46d1:b0:424:7425:f8a0 with SMTP id 5b1f17b1804b1-4257989f82amr88023465e9.15.1719930386669;
        Tue, 02 Jul 2024 07:26:26 -0700 (PDT)
Received: from localhost ([45.130.85.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0c18cfsm203393795e9.45.2024.07.02.07.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 07:26:26 -0700 (PDT)
From: Leone Fernando <leone4fernando@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemb@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leone Fernando <leone4fernando@gmail.com>
Subject: [PATCH net-next v2 3/4] net: route: always compile dst_cache
Date: Tue,  2 Jul 2024 16:24:05 +0200
Message-Id: <20240702142406.465415-4-leone4fernando@gmail.com>
In-Reply-To: <20240702142406.465415-1-leone4fernando@gmail.com>
References: <20240702142406.465415-1-leone4fernando@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

make dst_cache to always compile, delete all relevant ifdefs

Signed-off-by: Leone Fernando <leone4fernando@gmail.com>
---
 drivers/net/Kconfig        | 1 -
 include/net/dst_metadata.h | 2 --
 include/net/ip_tunnels.h   | 2 --
 net/Kconfig                | 4 ----
 net/core/Makefile          | 3 +--
 net/core/dst.c             | 4 ----
 net/ipv4/Kconfig           | 1 -
 net/ipv4/ip_tunnel_core.c  | 4 ----
 net/ipv4/udp_tunnel_core.c | 4 ----
 net/ipv6/Kconfig           | 4 ----
 net/ipv6/ip6_udp_tunnel.c  | 4 ----
 net/netfilter/nft_tunnel.c | 2 --
 net/openvswitch/Kconfig    | 1 -
 net/sched/act_tunnel_key.c | 2 --
 14 files changed, 1 insertion(+), 37 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 9920b3a68ed1..6819ce6db863 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -78,7 +78,6 @@ config WIREGUARD
 	depends on IPV6 || !IPV6
 	depends on !KMSAN # KMSAN doesn't support the crypto configs below
 	select NET_UDP_TUNNEL
-	select DST_CACHE
 	select CRYPTO
 	select CRYPTO_LIB_CURVE25519
 	select CRYPTO_LIB_CHACHA20POLY1305
diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
index 4160731dcb6e..46cebd8ea374 100644
--- a/include/net/dst_metadata.h
+++ b/include/net/dst_metadata.h
@@ -165,7 +165,6 @@ static inline struct metadata_dst *tun_dst_unclone(struct sk_buff *skb)
 
 	memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
 	       sizeof(struct ip_tunnel_info) + md_size);
-#ifdef CONFIG_DST_CACHE
 	/* Unclone the dst cache if there is one */
 	if (new_md->u.tun_info.dst_cache.cache) {
 		int ret;
@@ -176,7 +175,6 @@ static inline struct metadata_dst *tun_dst_unclone(struct sk_buff *skb)
 			return ERR_PTR(ret);
 		}
 	}
-#endif
 
 	skb_dst_drop(skb);
 	skb_dst_set(skb, &new_md->dst);
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 3877315cf8b8..c929789e614c 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -102,9 +102,7 @@ struct ip_tunnel_encap {
 struct ip_tunnel_info {
 	struct ip_tunnel_key	key;
 	struct ip_tunnel_encap	encap;
-#ifdef CONFIG_DST_CACHE
 	struct dst_cache	dst_cache;
-#endif
 	u8			options_len;
 	u8			mode;
 };
diff --git a/net/Kconfig b/net/Kconfig
index d27d0deac0bf..7c4115aa99e5 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -447,10 +447,6 @@ config LWTUNNEL_BPF
 	  Allows to run BPF programs as a nexthop action following a route
 	  lookup for incoming and outgoing packets.
 
-config DST_CACHE
-	bool
-	default n
-
 config GRO_CELLS
 	bool
 	default n
diff --git a/net/core/Makefile b/net/core/Makefile
index 62be9aef2528..9e732a58764e 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -13,7 +13,7 @@ obj-y		     += dev.o dev_addr_lists.o dst.o netevent.o \
 			neighbour.o rtnetlink.o utils.o link_watch.o filter.o \
 			sock_diag.o dev_ioctl.o tso.o sock_reuseport.o \
 			fib_notifier.o xdp.o flow_offload.o gro.o \
-			netdev-genl.o netdev-genl-gen.o gso.o
+			netdev-genl.o netdev-genl-gen.o gso.o dst_cache.o
 
 obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
 
@@ -34,7 +34,6 @@ obj-$(CONFIG_CGROUP_NET_PRIO) += netprio_cgroup.o
 obj-$(CONFIG_CGROUP_NET_CLASSID) += netclassid_cgroup.o
 obj-$(CONFIG_LWTUNNEL) += lwtunnel.o
 obj-$(CONFIG_LWTUNNEL_BPF) += lwt_bpf.o
-obj-$(CONFIG_DST_CACHE) += dst_cache.o
 obj-$(CONFIG_HWBM) += hwbm.o
 obj-$(CONFIG_GRO_CELLS) += gro_cells.o
 obj-$(CONFIG_FAILOVER) += failover.o
diff --git a/net/core/dst.c b/net/core/dst.c
index 95f533844f17..f035c39be104 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -291,10 +291,8 @@ EXPORT_SYMBOL_GPL(metadata_dst_alloc);
 
 void metadata_dst_free(struct metadata_dst *md_dst)
 {
-#ifdef CONFIG_DST_CACHE
 	if (md_dst->type == METADATA_IP_TUNNEL)
 		dst_cache_destroy(&md_dst->u.tun_info.dst_cache);
-#endif
 	if (md_dst->type == METADATA_XFRM)
 		dst_release(md_dst->u.xfrm_info.dst_orig);
 	kfree(md_dst);
@@ -326,10 +324,8 @@ void metadata_dst_free_percpu(struct metadata_dst __percpu *md_dst)
 	for_each_possible_cpu(cpu) {
 		struct metadata_dst *one_md_dst = per_cpu_ptr(md_dst, cpu);
 
-#ifdef CONFIG_DST_CACHE
 		if (one_md_dst->type == METADATA_IP_TUNNEL)
 			dst_cache_destroy(&one_md_dst->u.tun_info.dst_cache);
-#endif
 		if (one_md_dst->type == METADATA_XFRM)
 			dst_release(one_md_dst->u.xfrm_info.dst_orig);
 	}
diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index 8e94ed7c56a0..189f716b03e8 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -185,7 +185,6 @@ config NET_IPGRE_DEMUX
 
 config NET_IP_TUNNEL
 	tristate
-	select DST_CACHE
 	select GRO_CELLS
 	default n
 
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index a3676155be78..05fbc40c5d16 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -683,13 +683,11 @@ static int ip_tun_build_state(struct net *net, struct nlattr *attr,
 		return err;
 	}
 
-#ifdef CONFIG_DST_CACHE
 	err = dst_cache_init(&tun_info->dst_cache, GFP_KERNEL);
 	if (err) {
 		lwtstate_free(new_state);
 		return err;
 	}
-#endif
 
 	if (tb[LWTUNNEL_IP_ID])
 		tun_info->key.tun_id = nla_get_be64(tb[LWTUNNEL_IP_ID]);
@@ -727,11 +725,9 @@ static int ip_tun_build_state(struct net *net, struct nlattr *attr,
 
 static void ip_tun_destroy_state(struct lwtunnel_state *lwtstate)
 {
-#ifdef CONFIG_DST_CACHE
 	struct ip_tunnel_info *tun_info = lwt_tun_info(lwtstate);
 
 	dst_cache_destroy(&tun_info->dst_cache);
-#endif
 }
 
 static int ip_tun_fill_encap_opts_geneve(struct sk_buff *skb,
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index e4e0fa869fa4..576ab973d1f4 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -216,13 +216,11 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 	struct rtable *rt = NULL;
 	struct flowi4 fl4;
 
-#ifdef CONFIG_DST_CACHE
 	if (dst_cache) {
 		rt = dst_cache_get_ip4(dst_cache, saddr);
 		if (rt)
 			return rt;
 	}
-#endif
 
 	memset(&fl4, 0, sizeof(fl4));
 	fl4.flowi4_mark = skb->mark;
@@ -245,10 +243,8 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 		ip_rt_put(rt);
 		return ERR_PTR(-ELOOP);
 	}
-#ifdef CONFIG_DST_CACHE
 	if (dst_cache)
 		dst_cache_set_ip4(dst_cache, &rt->dst, fl4.saddr);
-#endif
 	*saddr = fl4.saddr;
 	return rt;
 }
diff --git a/net/ipv6/Kconfig b/net/ipv6/Kconfig
index 08d4b7132d4c..093c768d41ab 100644
--- a/net/ipv6/Kconfig
+++ b/net/ipv6/Kconfig
@@ -124,7 +124,6 @@ config IPV6_MIP6
 config IPV6_ILA
 	tristate "IPv6: Identifier Locator Addressing (ILA)"
 	depends on NETFILTER
-	select DST_CACHE
 	select LWTUNNEL
 	help
 	  Support for IPv6 Identifier Locator Addressing (ILA).
@@ -203,7 +202,6 @@ config IPV6_NDISC_NODETYPE
 config IPV6_TUNNEL
 	tristate "IPv6: IP-in-IPv6 tunnel (RFC2473)"
 	select INET6_TUNNEL
-	select DST_CACHE
 	select GRO_CELLS
 	help
 	  Support for IPv6-in-IPv6 and IPv4-in-IPv6 tunnels described in
@@ -291,7 +289,6 @@ config IPV6_SEG6_LWTUNNEL
 	bool "IPv6: Segment Routing Header encapsulation support"
 	depends on IPV6
 	select LWTUNNEL
-	select DST_CACHE
 	select IPV6_MULTIPLE_TABLES
 	help
 	  Support for encapsulation of packets within an outer IPv6
@@ -333,7 +330,6 @@ config IPV6_IOAM6_LWTUNNEL
 	bool "IPv6: IOAM Pre-allocated Trace insertion support"
 	depends on IPV6
 	select LWTUNNEL
-	select DST_CACHE
 	help
 	  Support for the insertion of IOAM Pre-allocated Trace
 	  Header using the lightweight tunnels mechanism.
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index c99053189ea8..de92aea01cfc 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -145,13 +145,11 @@ struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 	struct dst_entry *dst = NULL;
 	struct flowi6 fl6;
 
-#ifdef CONFIG_DST_CACHE
 	if (dst_cache) {
 		dst = dst_cache_get_ip6(dst_cache, saddr);
 		if (dst)
 			return dst;
 	}
-#endif
 	memset(&fl6, 0, sizeof(fl6));
 	fl6.flowi6_mark = skb->mark;
 	fl6.flowi6_proto = IPPROTO_UDP;
@@ -173,10 +171,8 @@ struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 		dst_release(dst);
 		return ERR_PTR(-ELOOP);
 	}
-#ifdef CONFIG_DST_CACHE
 	if (dst_cache)
 		dst_cache_set_ip6(dst_cache, dst, &fl6.saddr);
-#endif
 	*saddr = fl6.saddr;
 	return dst;
 }
diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index 60a76e6e348e..aa4a872edae2 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -514,13 +514,11 @@ static int nft_tunnel_obj_init(const struct nft_ctx *ctx,
 		return -ENOMEM;
 
 	memcpy(&md->u.tun_info, &info, sizeof(info));
-#ifdef CONFIG_DST_CACHE
 	err = dst_cache_init(&md->u.tun_info.dst_cache, GFP_KERNEL);
 	if (err < 0) {
 		metadata_dst_free(md);
 		return err;
 	}
-#endif
 	ip_tunnel_info_opts_set(&md->u.tun_info, &priv->opts.u, priv->opts.len,
 				priv->opts.flags);
 	priv->md = md;
diff --git a/net/openvswitch/Kconfig b/net/openvswitch/Kconfig
index 29a7081858cd..b7a5ab6374b8 100644
--- a/net/openvswitch/Kconfig
+++ b/net/openvswitch/Kconfig
@@ -13,7 +13,6 @@ config OPENVSWITCH
 	select LIBCRC32C
 	select MPLS
 	select NET_MPLS_GSO
-	select DST_CACHE
 	select NET_NSH
 	select NF_CONNTRACK_OVS if NF_CONNTRACK
 	select NF_NAT_OVS if NF_NAT
diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
index af7c99845948..9d673b642b7c 100644
--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -476,11 +476,9 @@ static int tunnel_key_init(struct net *net, struct nlattr *nla,
 			goto err_out;
 		}
 
-#ifdef CONFIG_DST_CACHE
 		ret = dst_cache_init(&metadata->u.tun_info.dst_cache, GFP_KERNEL);
 		if (ret)
 			goto release_tun_meta;
-#endif
 
 		if (opts_len) {
 			ret = tunnel_key_opts_set(tb[TCA_TUNNEL_KEY_ENC_OPTS],
-- 
2.34.1


