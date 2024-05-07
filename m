Return-Path: <netdev+bounces-94114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F068BE26D
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 14:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECF69B25E90
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518A115ADB8;
	Tue,  7 May 2024 12:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0prA9tn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8A1158D6D;
	Tue,  7 May 2024 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715085890; cv=none; b=deSbdvcTzio9Jy8LsQbqnRUjS0B98QFYcHf2BA/TCxMmR+F85pwe8Xs/TOgr3egQ/u3yH3//Cp87/8lWY1wf3dt+QxJyzC1ZVs18z3ZVP3H4R+DBczPPUMGU0g7PAoY4PkcF7r7AmCW5FgTWVHPeVjSlZHkBL9oEqx7d8CGxIoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715085890; c=relaxed/simple;
	bh=VHaDqy4uCN9hdVx42KaFqF/f4VYZwWy/OWJxc5HEReo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cvz/hcPSvHABCySsPKKVh3TrhJ/LcTDem2HNdiGoKVDnSBWy33sfQuavuKTeWPw4hWmGUacnUEdlzpO+0cCv/2YMH534c2ygHtHYFz6eh5iIq0Seu2EVV3uDIsjqItm+qiE6YFR7gFc1c/WHo9zuWIA+AJcVeQVqgB+wpm69uXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0prA9tn; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-34e0d8b737eso3163011f8f.1;
        Tue, 07 May 2024 05:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715085887; x=1715690687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/QYkjOUDr+8s3NA0sZvLBYnsJKMzaMJ2QY9V4Fij30=;
        b=h0prA9tnc5qAi4RFThtGQfyYgXS4k0t3NlX4PKum4s+fvPrFqh0PsmgW0Z/yaVUR/p
         iKfcYPPNznUuWVBPQpBmk3VirE8RjJT+5LscKjZKXULG+EYpAHkZ8b0IuaTU4IDpW653
         fdSkK+bMwBiyuNAK14Rkf38XgwToXf2pfNYs14GVlutWHViyw/tXrToVJho5iObtYrxN
         SulDqx3TXtgKPfZVssMiQRXoQ9WoI3LKnUMKqNe0JSOJDg83z7P/2R3llck6USjSBenr
         7MmJOLE1S30JwVIG0N6UT7MGZpwB4O0SJt2hdGkxWfILV0ryr7nE5ifGt+eaIeXUGGjy
         tgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715085887; x=1715690687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/QYkjOUDr+8s3NA0sZvLBYnsJKMzaMJ2QY9V4Fij30=;
        b=cJGki1AkxevfmCFitXx06jFnL1P604Xxucs1iZSXDPYt7OoeCU5JmBA6Jf1oOgu0wx
         B6zUCumwUJWiDwWlG2n9PczotAHu6ZOHHZuX7Ct2V7YE3DNGKEq+I2gR/5IFVkla/ljn
         P6vOq2vW5Ywcc90I8vSvgJNv3cqCVDo90JviMhIkl+24PnAskzZccatl4jPXXPntgW10
         MCpCY4WHs8Gz3X/4FvV6aypFmfIIPny9P5e51T7nehqMF1RWgnAE2qINMFKvxkC13ygK
         cfxOKneOtpfjR1gs0G0sEOp8llo5nX53BZ9kz9ipGkSOaZC+Hq78u8AMNLdOJySFcrSh
         b2Sw==
X-Forwarded-Encrypted: i=1; AJvYcCViOq6kLIHEhdqLaidi4I0ZXN2h3wAWXr93DeS7eRIvXTDlWlrN+VnRc0izXyX10EPt3VUrwvcokhPgpPIBM1+HAXvNZJAAeNSotkhI6mvhiRTq+QKRWW8DeRqClihkQNAPOI0A
X-Gm-Message-State: AOJu0Ywd5wefTm2ibGq0kT5eg10cxu12Ru/Y/MlAwTCcbqcBtCDfsl0H
	/k+s7ZMdnEycPfcnLidG3qaykCmXn0M0stqI3BMbXHyHle5WdTyE
X-Google-Smtp-Source: AGHT+IHC3qNccXCFnuRqIob+JAHZIErqZ51mXsd8Hb+SDMcwyF3PJXzjvhA11tgjYLlzsd6n7fsdpg==
X-Received: by 2002:a5d:4304:0:b0:34d:75f3:4a77 with SMTP id ffacd0b85a97d-34f8174bb68mr2199109f8f.6.1715085886570;
        Tue, 07 May 2024 05:44:46 -0700 (PDT)
Received: from localhost ([45.130.85.2])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b00417ee886977sm23467416wmq.4.2024.05.07.05.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 05:44:46 -0700 (PDT)
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
Date: Tue,  7 May 2024 14:42:28 +0200
Message-Id: <20240507124229.446802-4-leone4fernando@gmail.com>
In-Reply-To: <20240507124229.446802-1-leone4fernando@gmail.com>
References: <20240507124229.446802-1-leone4fernando@gmail.com>
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
index 9a6a08ec7713..ed1b36a5ae52 100644
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
index d5ab791f7afa..cd5304e6cba2 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -441,10 +441,6 @@ config LWTUNNEL_BPF
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
index 21d6fbc7e884..cfd327ae389e 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -13,7 +13,7 @@ obj-y		     += dev.o dev_addr_lists.o dst.o netevent.o \
 			neighbour.o rtnetlink.o utils.o link_watch.o filter.o \
 			sock_diag.o dev_ioctl.o tso.o sock_reuseport.o \
 			fib_notifier.o xdp.o flow_offload.o gro.o \
-			netdev-genl.o netdev-genl-gen.o gso.o
+			netdev-genl.o netdev-genl-gen.o gso.o dst_cache.o
 
 obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
 
@@ -33,7 +33,6 @@ obj-$(CONFIG_CGROUP_NET_PRIO) += netprio_cgroup.o
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


