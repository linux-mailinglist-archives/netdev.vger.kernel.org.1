Return-Path: <netdev+bounces-237872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4355BC50F9E
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 08:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B45C24EAC46
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 07:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF5B2C2357;
	Wed, 12 Nov 2025 07:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QNSP4h7L"
X-Original-To: netdev@vger.kernel.org
Received: from sonic307-35.consmr.mail.ne1.yahoo.com (sonic307-35.consmr.mail.ne1.yahoo.com [66.163.190.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CE1285C91
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 07:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762933260; cv=none; b=Uq2J5TFZYQq2nvPqXKZ92lolhFajARKhRfcnbZEOPtWQs62YJpSKJKvZKNAK8Na84gUnOqHWYaOu6DhC3Csi0+NuMuODlEqVYf8GhHJZnBwzRZvJVly1EmZiPkd6/ntfhux9cYBr/auiUA2wwZVLmoto9ehphZoLbQCIWc4Kb50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762933260; c=relaxed/simple;
	bh=4py8zq2vMzN2RbYwePLUuLKq4mR3gTBV7CH8MGeb4NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X38H7gyIjsSNPIvDzWBVW2nHcaw/byidj6OSz5a1jTzizTxyBve5pngrg0BZyPNynZoyLJZ2/rGC3WbY8KO03NHi0HLErWlPwEVKTCJQGbv5NZ9N8yF8Zf5AwGsmUwRE36xEkCkLo61OGBZlH1UChYDjJ9J5aakxtoMMX2LAaCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=QNSP4h7L; arc=none smtp.client-ip=66.163.190.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762933257; bh=9ThG5p4idKz2r6wBgxhW6ww1129wo4brA66Aap8KXKg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=QNSP4h7Lnmplj9F/8P4ZXcoUw/XIEGMbqGSWsavSyIX0Xg2N/WNI8a9djh3RvfpvK7KWam7jCznhY/GvYJLb1C4D3jLHDRo5Ogm3CAoI0zl9gwAonU0zrDoF2O1RNThyp2ApfWW/DI63aKB6ip0wk2XPqO6jjuLmGOvAty3YGy0JgnbMZnb/pRtZCm27RrWlVF1A6sWuJbETIoVAbwbBhVhYdybjl9xYo0Cbuijmak8/fzk2dSLw8LT3ceWkFQhWGhAn5qif+4Mw/ieMhy88GrKB3rgLxgcmGNZivNCHwrtDUFWXi26xPnw5L3U0GYQCFD3+Pn0UCpxqU2vZQiOdiw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762933257; bh=fRG7HgWxoLvjWp+aY5BdNuzTEaKadTW/z93rox8XDcJ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ru2AY5E+ovbECFjdHmywJ95kTqpScFzVBH4JukksZhApKgzdp0NBrT4UmP9+9hdQflZQHjzlluYymDstnDK+VcXRKDrbZF0vQD7Jv/ca9C1I0IOlVxqvpCINkXRhVLANv0vV/6moVyD2SxeSKLJKiQQZDNKk0jbIcDmER/VLyUtzM68VgYW/2shOmdsuVMUcutT6TDaPy4h0iA8HZSs24y8EXtIA3iEeJUImOAZPxBbKYfsMacgVaj9JClYlN1abvdmulkZlAtC6AaPR+Xd+M1SDRYFA+zufyZFHlrpiDdsRk3GhqyGcRwaLAeDE4uOSW6Kw1gZ4r4ib6eNP2OD5kQ==
X-YMail-OSG: jFjVbu8VM1nQPQDG8_LzNOQ4hTpGiVNe6KfzOOadx2wJ1EiEtLZKofSkpLXlV0q
 aRYZnXhdleo4CLH2UMVa4APsBI6S1diPgWlV0hTvQXE6VYpVsUb4FZg2qvP2I0bumOtLNlTMNu9g
 EYFZ0RwgJschCS8wU8XnlG_tee4J3F3FI55ZKScj_3Tzq6PAw8ChOQnpD42kMOIHaCuboDhXe2iL
 AKLDftWg3WKoySilMIat.t66PWd_ulASvp1jsYdcc3kSCYb6kfDy1VHguI0xQNAupuyMq3mXsoN0
 LO6NsyNSKbyMXwj_pLk96HJRTvj65S4VWWVj3SGSgdkqqZakApF2MM4UzxffMhMcTm.oyldKQ28u
 2L40p3QAkwiKp2VRwDWgeD5FXeFSPrjcR8OZZQ9raKwbgCusl6hdKgzSSB4C5prDDMvrULgA2MwD
 1gm8z6_Q5LMWUjto63bQTjRjxZF8PCMM4kQVbcXvfY9RJMt.LgOzkzeHsTb1xgSUhGjSUvIwb6EP
 Rrb82OCEwlHfi.HVN4_5Lv20cHb_p.h3AOvTIODwcp0_f7kGZ8nAKeAMOIwjf5QH7Q.ikQjTYXA0
 QIIguJ__B4Bxpt9B6QlPELQgCHXc7wFynC.HHiBeoD7aTzvagLYe.enycmI7jHujleNhKHUAMi8W
 17COUr._IqogQo2JutxpP06JWnkgMjFHoilO8hpHxb2G_DlyRLCkKo95Dd1lXS2rZp5w_tq5J2tY
 iyfeJRFEpV312yiwJySf_tNosEqzKjFMTfDsIQzjHXBAOV7X3uRjj9RZlFZr7F7L1nEao0QI_elw
 zQnrb5lsBs_O.XR2Ltev964Ru_.e2YZiVmJPrEiCfqFtm___gpshCZKa.SGb6ogV.q0cv_ezuzDA
 .eozI9XJZ3fD6SY8djPCQg0Y6KO0XWJHP0xpMwukhhLt_ALCce_tbk1zuTp.fIXlA66IyB0XkhVj
 Tey8_I9D2Af35Sw_hfaguI0_05_9LUhdjuwnN2mXkXVbG8vauke9KwLCwPkP89o.jEU1tu6isGWY
 qvsZs6XCTQV8ILC5EKX8fIg2LNiLWgAvqBvaDhs9Qbatq9CbIu3X1KQmZBxSVMBZiIiXkbfJt3Fx
 IHgrTXbYPqFQx4DCjPmqIsN.DTknrn5JRCtewDiiSziSMyY4cQIkRQfMIZr7BPZ4w6Qo8VBwVXCn
 jtIbOOfYqvtCriUU749ObDEygdJcl32Vg_ZPhArm3eNIa4KlY.vLffRH_wJbo69AQMj_3xF0xLVj
 GjcK4G92NFLRH0N2jcpWjix.k1Bh88KznJbTutD0m9aHWCnZYRK6gX3VdArOvO3s8JPNd3CyxCud
 orf9j7BZUj3v6WeQ8Ub3Ke80051E0lRvazXPyqakrilbrNancY9cj.blEPgNSSxO2TPsKGZL1SNL
 gPoZaR3vArcPgc48aNaDxovhxUhgr4IjnEEgpwaKhFHxegljRriOVpAQMvzBqI6FS_6id2QY21BI
 DDTM4uxswwlPWcghf.x..rsirSuvurOVUcWEVTbrO8_tmLYg9H.jYoWXR9_AmdKOozPYQetzb_iq
 sj4.2dgiHkd7OukjQG7ltrdOL0QW_etzbiJksSzT6hlJjUaX3WM3cdWkRCMeiYuUAs1_6JgQCkHy
 9qO4.RX8tfPfcZ9DaVMXMcstcnJ8D42S_Rb8lz3Rxm57WOnpOq6zdhB50Tan43LlnvmS7l9xMSw_
 NT4xV.q.AKQeSkTSsQ3Ym7wmDDIkGcVF1CWdYLzsNe549NVdhuRWdy8rrrdhzQ_aByNXoemlv7mn
 3Pfk.rX.abGRRLQSc3O2E5MEnFkbtezBb0TdjeM_5gp.9SpgKywQ8WhAJBAywB2FR.ufpjQgn7mv
 M5phEgf45zv_E3DJiRq_qsKb316FCvB.oV05he5aILZAqX6PUYBHbVWQyVLSTnZlqC4ZNRZ2LznA
 CUvzslbKwTwloDRQxqGgMDHDbyYmztvaSBDRypjPP_AOG06.74zSPf9PDwZjMNrpOrP0kXKbPsI9
 jURceojecN7BVV5I7MY.MVRxCnTq.JRwgy3_4seRhpGCDMuAqTCXOdY4jAfFnr5g1fOwTtgZnwm7
 a3YwZi4LludPLDUUaUsWpjSsu5saGceunMd3TdWGaiPR2oY9OgsWLw6mKaZY.ZIn2TXgijgnmk4S
 PtNC0DRXFNW_GBI.hpzADoYzTIqVB.K7QAbZnbD21nB16w9kxXoXm.PmHFL5LP_k8VOA2xPNKR1X
 dFitckQ--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 8b66da30-5de0-456d-bc2b-58dfb7cd6042
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Wed, 12 Nov 2025 07:40:57 +0000
Received: by hermes--production-ir2-5fcfdd8d7f-2cnbk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ce2e5d13638178c4daec60c4681fbbb6;
          Wed, 12 Nov 2025 07:28:39 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v4 06/14] net: tunnel: return dstref in udp_tunnel{,6}_dst_lookup
Date: Wed, 12 Nov 2025 08:27:12 +0100
Message-ID: <20251112072720.5076-7-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112072720.5076-1-mmietus97@yahoo.com>
References: <20251112072720.5076-1-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update udp_tunnel{,6}_dst_lookup to return a dstref instead of
dst_entry/rtable. The returned dstref is only valid inside the RCU
read-side critical section in which it was queried. Update all callers
to take that into account.

VXLAN had one unique dst access (in vxlan_xmit_one) that was outside
of RCU, so that line had to be moved.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 drivers/net/bareudp.c          | 63 +++++++++++++-----------
 drivers/net/geneve.c           | 90 ++++++++++++++++++----------------
 drivers/net/vxlan/vxlan_core.c | 80 +++++++++++++++---------------
 include/net/udp_tunnel.h       |  8 +--
 net/ipv4/udp_tunnel_core.c     | 27 +++++-----
 net/ipv6/ip6_udp_tunnel.c      | 37 ++++++++------
 6 files changed, 164 insertions(+), 141 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 813866cd04db..12408ee37b3c 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -313,6 +313,7 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	struct rtable *rt;
 	__be16 sport, df;
 	int min_headroom;
+	dstref_t dstref;
 	__u8 tos, ttl;
 	__be32 saddr;
 	int err;
@@ -326,13 +327,15 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	sport = udp_flow_src_port(bareudp->net, skb,
 				  bareudp->sport_min, USHRT_MAX,
 				  true);
-	rt = udp_tunnel_dst_lookup(skb, dev, bareudp->net, 0, &saddr, &info->key,
-				   sport, bareudp->port, key->tos,
-				   use_cache ?
-				   (struct dst_cache *)&info->dst_cache : NULL);
+	err = udp_tunnel_dst_lookup(skb, dev, bareudp->net, 0, &saddr, &info->key,
+				    sport, bareudp->port, key->tos,
+				    use_cache ?
+				    (struct dst_cache *)&info->dst_cache : NULL, &dstref);
 
-	if (IS_ERR(rt))
-		return PTR_ERR(rt);
+	if (err)
+		return err;
+
+	rt = dst_rtable(dstref_dst(dstref));
 
 	skb_tunnel_check_pmtu(skb, &rt->dst,
 			      BAREUDP_IPV4_HLEN + info->options_len, false);
@@ -359,7 +362,7 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		goto free_dst;
 
 	skb_set_inner_protocol(skb, bareudp->ethertype);
-	udp_tunnel_xmit_skb(dst_to_dstref(&rt->dst), sock->sk, skb, saddr, info->key.u.ipv4.dst,
+	udp_tunnel_xmit_skb(dstref, sock->sk, skb, saddr, info->key.u.ipv4.dst,
 			    tos, ttl, df, sport, bareudp->port,
 			    !net_eq(bareudp->net, dev_net(bareudp->dev)),
 			    !test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags),
@@ -367,7 +370,7 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	return 0;
 
 free_dst:
-	dst_release(&rt->dst);
+	dstref_drop(dstref);
 	return err;
 }
 
@@ -383,6 +386,7 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	struct dst_entry *dst = NULL;
 	struct in6_addr saddr, daddr;
 	int min_headroom;
+	dstref_t dstref;
 	__u8 prio, ttl;
 	__be16 sport;
 	int err;
@@ -396,12 +400,15 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	sport = udp_flow_src_port(bareudp->net, skb,
 				  bareudp->sport_min, USHRT_MAX,
 				  true);
-	dst = udp_tunnel6_dst_lookup(skb, dev, bareudp->net, sock, 0, &saddr,
+	err = udp_tunnel6_dst_lookup(skb, dev, bareudp->net, sock, 0, &saddr,
 				     key, sport, bareudp->port, key->tos,
 				     use_cache ?
-				     (struct dst_cache *) &info->dst_cache : NULL);
-	if (IS_ERR(dst))
-		return PTR_ERR(dst);
+				     (struct dst_cache *)&info->dst_cache : NULL, &dstref);
+
+	if (err)
+		return err;
+
+	dst = dstref_dst(dstref);
 
 	skb_tunnel_check_pmtu(skb, dst, BAREUDP_IPV6_HLEN + info->options_len,
 			      false);
@@ -427,7 +434,7 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		goto free_dst;
 
 	daddr = info->key.u.ipv6.dst;
-	udp_tunnel6_xmit_skb(dst_to_dstref(dst), sock->sk, skb, dev,
+	udp_tunnel6_xmit_skb(dstref, sock->sk, skb, dev,
 			     &saddr, &daddr, prio, ttl,
 			     info->key.label, sport, bareudp->port,
 			     !test_bit(IP_TUNNEL_CSUM_BIT,
@@ -436,7 +443,7 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	return 0;
 
 free_dst:
-	dst_release(dst);
+	dstref_drop(dstref);
 	return err;
 }
 
@@ -503,8 +510,10 @@ static int bareudp_fill_metadata_dst(struct net_device *dev,
 {
 	struct ip_tunnel_info *info = skb_tunnel_info(skb);
 	struct bareudp_dev *bareudp = netdev_priv(dev);
+	dstref_t dstref;
 	bool use_cache;
 	__be16 sport;
+	int err;
 
 	use_cache = ip_tunnel_dst_cache_usable(skb, info);
 	sport = udp_flow_src_port(bareudp->net, skb,
@@ -512,31 +521,29 @@ static int bareudp_fill_metadata_dst(struct net_device *dev,
 				  true);
 
 	if (!ipv6_mod_enabled() || ip_tunnel_info_af(info) == AF_INET) {
-		struct rtable *rt;
 		__be32 saddr;
 
-		rt = udp_tunnel_dst_lookup(skb, dev, bareudp->net, 0, &saddr,
-					   &info->key, sport, bareudp->port,
-					   info->key.tos,
-					   use_cache ? &info->dst_cache : NULL);
-		if (IS_ERR(rt))
-			return PTR_ERR(rt);
+		err = udp_tunnel_dst_lookup(skb, dev, bareudp->net, 0, &saddr,
+					    &info->key, sport, bareudp->port,
+					    info->key.tos,
+					    use_cache ? &info->dst_cache : NULL, &dstref);
+		if (err)
+			return err;
 
-		ip_rt_put(rt);
+		dstref_drop(dstref);
 		info->key.u.ipv4.src = saddr;
 	} else if (ip_tunnel_info_af(info) == AF_INET6) {
-		struct dst_entry *dst;
 		struct in6_addr saddr;
 		struct socket *sock = rcu_dereference(bareudp->sock);
 
-		dst = udp_tunnel6_dst_lookup(skb, dev, bareudp->net, sock,
+		err = udp_tunnel6_dst_lookup(skb, dev, bareudp->net, sock,
 					     0, &saddr, &info->key,
 					     sport, bareudp->port, info->key.tos,
-					     use_cache ? &info->dst_cache : NULL);
-		if (IS_ERR(dst))
-			return PTR_ERR(dst);
+					     use_cache ? &info->dst_cache : NULL, &dstref);
+		if (err)
+			return err;
 
-		dst_release(dst);
+		dstref_drop(dstref);
 		info->key.u.ipv6.src = saddr;
 	} else {
 		return -EINVAL;
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 0c7949c0561f..0c307fad4f69 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -766,12 +766,13 @@ static void geneve_build_header(struct genevehdr *geneveh,
 		ip_tunnel_info_opts_get(geneveh->options, info);
 }
 
-static int geneve_build_skb(struct dst_entry *dst, struct sk_buff *skb,
+static int geneve_build_skb(dstref_t dstref, struct sk_buff *skb,
 			    const struct ip_tunnel_info *info,
 			    bool xnet, int ip_hdr_len,
 			    bool inner_proto_inherit)
 {
 	bool udp_sum = test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags);
+	struct dst_entry *dst = dstref_dst(dstref);
 	struct genevehdr *gnvh;
 	__be16 inner_proto;
 	int min_headroom;
@@ -797,7 +798,7 @@ static int geneve_build_skb(struct dst_entry *dst, struct sk_buff *skb,
 	return 0;
 
 free_dst:
-	dst_release(dst);
+	dstref_drop(dstref);
 	return err;
 }
 
@@ -826,6 +827,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	struct geneve_sock *gs4 = rcu_dereference(geneve->sock4);
 	const struct ip_tunnel_key *key = &info->key;
 	struct rtable *rt;
+	dstref_t dstref;
 	bool use_cache;
 	__u8 tos, ttl;
 	__be16 df = 0;
@@ -845,19 +847,21 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 				  geneve->cfg.port_min,
 				  geneve->cfg.port_max, true);
 
-	rt = udp_tunnel_dst_lookup(skb, dev, geneve->net, 0, &saddr,
-				   &info->key,
-				   sport, geneve->cfg.info.key.tp_dst, tos,
-				   use_cache ?
-				   (struct dst_cache *)&info->dst_cache : NULL);
-	if (IS_ERR(rt))
-		return PTR_ERR(rt);
+	err = udp_tunnel_dst_lookup(skb, dev, geneve->net, 0, &saddr,
+				    &info->key,
+				    sport, geneve->cfg.info.key.tp_dst, tos,
+				    use_cache ?
+				    (struct dst_cache *)&info->dst_cache : NULL, &dstref);
+	if (err)
+		return err;
+
+	rt = dst_rtable(dstref_dst(dstref));
 
 	err = skb_tunnel_check_pmtu(skb, &rt->dst,
 				    GENEVE_IPV4_HLEN + info->options_len,
 				    netif_is_any_bridge_port(dev));
 	if (err < 0) {
-		dst_release(&rt->dst);
+		dstref_drop(dstref);
 		return err;
 	} else if (err) {
 		struct ip_tunnel_info *info;
@@ -868,7 +872,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 
 			unclone = skb_tunnel_info_unclone(skb);
 			if (unlikely(!unclone)) {
-				dst_release(&rt->dst);
+				dstref_drop(dstref);
 				return -ENOMEM;
 			}
 
@@ -877,13 +881,13 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		}
 
 		if (!pskb_may_pull(skb, ETH_HLEN)) {
-			dst_release(&rt->dst);
+			dstref_drop(dstref);
 			return -EINVAL;
 		}
 
 		skb->protocol = eth_type_trans(skb, geneve->dev);
 		__netif_rx(skb);
-		dst_release(&rt->dst);
+		dstref_drop(dstref);
 		return -EMSGSIZE;
 	}
 
@@ -916,14 +920,13 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		}
 	}
 
-	err = geneve_build_skb(&rt->dst, skb, info, xnet, sizeof(struct iphdr),
+	err = geneve_build_skb(dstref, skb, info, xnet, sizeof(struct iphdr),
 			       inner_proto_inherit);
 	if (unlikely(err))
 		return err;
 
-	udp_tunnel_xmit_skb(dst_to_dstref(&rt->dst), gs4->sock->sk, skb, saddr,
-			    info->key.u.ipv4.dst, tos, ttl, df, sport,
-			    geneve->cfg.info.key.tp_dst,
+	udp_tunnel_xmit_skb(dstref, gs4->sock->sk, skb, saddr, info->key.u.ipv4.dst,
+			    tos, ttl, df, sport, geneve->cfg.info.key.tp_dst,
 			    !net_eq(geneve->net, dev_net(geneve->dev)),
 			    !test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags),
 			    0);
@@ -941,6 +944,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	const struct ip_tunnel_key *key = &info->key;
 	struct dst_entry *dst = NULL;
 	struct in6_addr saddr;
+	dstref_t dstref;
 	bool use_cache;
 	__u8 prio, ttl;
 	__be16 sport;
@@ -958,19 +962,21 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 				  geneve->cfg.port_min,
 				  geneve->cfg.port_max, true);
 
-	dst = udp_tunnel6_dst_lookup(skb, dev, geneve->net, gs6->sock, 0,
+	err = udp_tunnel6_dst_lookup(skb, dev, geneve->net, gs6->sock, 0,
 				     &saddr, key, sport,
 				     geneve->cfg.info.key.tp_dst, prio,
 				     use_cache ?
-				     (struct dst_cache *)&info->dst_cache : NULL);
-	if (IS_ERR(dst))
-		return PTR_ERR(dst);
+				     (struct dst_cache *)&info->dst_cache : NULL, &dstref);
+	if (err)
+		return err;
+
+	dst = dstref_dst(dstref);
 
 	err = skb_tunnel_check_pmtu(skb, dst,
 				    GENEVE_IPV6_HLEN + info->options_len,
 				    netif_is_any_bridge_port(dev));
 	if (err < 0) {
-		dst_release(dst);
+		dstref_drop(dstref);
 		return err;
 	} else if (err) {
 		struct ip_tunnel_info *info = skb_tunnel_info(skb);
@@ -980,7 +986,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 
 			unclone = skb_tunnel_info_unclone(skb);
 			if (unlikely(!unclone)) {
-				dst_release(dst);
+				dstref_drop(dstref);
 				return -ENOMEM;
 			}
 
@@ -989,13 +995,13 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		}
 
 		if (!pskb_may_pull(skb, ETH_HLEN)) {
-			dst_release(dst);
+			dstref_drop(dstref);
 			return -EINVAL;
 		}
 
 		skb->protocol = eth_type_trans(skb, geneve->dev);
 		__netif_rx(skb);
-		dst_release(dst);
+		dstref_drop(dstref);
 		return -EMSGSIZE;
 	}
 
@@ -1009,12 +1015,12 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			ttl = key->ttl;
 		ttl = ttl ? : ip6_dst_hoplimit(dst);
 	}
-	err = geneve_build_skb(dst, skb, info, xnet, sizeof(struct ipv6hdr),
+	err = geneve_build_skb(dstref, skb, info, xnet, sizeof(struct ipv6hdr),
 			       inner_proto_inherit);
 	if (unlikely(err))
 		return err;
 
-	udp_tunnel6_xmit_skb(dst_to_dstref(dst), gs6->sock->sk, skb, dev,
+	udp_tunnel6_xmit_skb(dstref, gs6->sock->sk, skb, dev,
 			     &saddr, &key->u.ipv6.dst, prio, ttl,
 			     info->key.label, sport, geneve->cfg.info.key.tp_dst,
 			     !test_bit(IP_TUNNEL_CSUM_BIT,
@@ -1081,10 +1087,11 @@ static int geneve_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 {
 	struct ip_tunnel_info *info = skb_tunnel_info(skb);
 	struct geneve_dev *geneve = netdev_priv(dev);
+	dstref_t dstref;
 	__be16 sport;
+	int err;
 
 	if (ip_tunnel_info_af(info) == AF_INET) {
-		struct rtable *rt;
 		struct geneve_sock *gs4 = rcu_dereference(geneve->sock4);
 		bool use_cache;
 		__be32 saddr;
@@ -1099,19 +1106,18 @@ static int geneve_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 					  geneve->cfg.port_min,
 					  geneve->cfg.port_max, true);
 
-		rt = udp_tunnel_dst_lookup(skb, dev, geneve->net, 0, &saddr,
-					   &info->key,
-					   sport, geneve->cfg.info.key.tp_dst,
-					   tos,
-					   use_cache ? &info->dst_cache : NULL);
-		if (IS_ERR(rt))
-			return PTR_ERR(rt);
+		err = udp_tunnel_dst_lookup(skb, dev, geneve->net, 0, &saddr,
+					    &info->key,
+					    sport, geneve->cfg.info.key.tp_dst,
+					    tos,
+					    use_cache ? &info->dst_cache : NULL, &dstref);
+		if (err)
+			return err;
 
-		ip_rt_put(rt);
+		dstref_drop(dstref);
 		info->key.u.ipv4.src = saddr;
 #if IS_ENABLED(CONFIG_IPV6)
 	} else if (ip_tunnel_info_af(info) == AF_INET6) {
-		struct dst_entry *dst;
 		struct geneve_sock *gs6 = rcu_dereference(geneve->sock6);
 		struct in6_addr saddr;
 		bool use_cache;
@@ -1126,14 +1132,14 @@ static int geneve_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 					  geneve->cfg.port_min,
 					  geneve->cfg.port_max, true);
 
-		dst = udp_tunnel6_dst_lookup(skb, dev, geneve->net, gs6->sock, 0,
+		err = udp_tunnel6_dst_lookup(skb, dev, geneve->net, gs6->sock, 0,
 					     &saddr, &info->key, sport,
 					     geneve->cfg.info.key.tp_dst, prio,
-					     use_cache ? &info->dst_cache : NULL);
-		if (IS_ERR(dst))
-			return PTR_ERR(dst);
+					     use_cache ? &info->dst_cache : NULL, &dstref);
+		if (err)
+			return err;
 
-		dst_release(dst);
+		dstref_drop(dstref);
 		info->key.u.ipv6.src = saddr;
 #endif
 	} else {
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 78e5a3393b48..02ccf60d854a 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2297,7 +2297,7 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 				 struct vxlan_dev *vxlan,
 				 int addr_family,
 				 __be16 dst_port, int dst_ifindex, __be32 vni,
-				 struct dst_entry *dst,
+				 dstref_t dstref,
 				 u32 rt_flags)
 {
 #if IS_ENABLED(CONFIG_IPV6)
@@ -2313,7 +2313,7 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 	    vxlan->cfg.flags & VXLAN_F_LOCALBYPASS) {
 		struct vxlan_dev *dst_vxlan;
 
-		dst_release(dst);
+		dstref_drop(dstref);
 		dst_vxlan = vxlan_find_vni(vxlan->net, dst_ifindex, vni,
 					   addr_family, dst_port,
 					   vxlan->cfg.flags);
@@ -2344,6 +2344,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 	struct vxlan_metadata _md;
 	struct vxlan_metadata *md = &_md;
 	unsigned int pkt_len = skb->len;
+	dstref_t dstref = DSTREF_EMPTY;
 	__be16 src_port = 0, dst_port;
 	struct dst_entry *ndst = NULL;
 	int addr_family;
@@ -2463,15 +2464,16 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		if (!ifindex)
 			ifindex = sock4->sock->sk->sk_bound_dev_if;
 
-		rt = udp_tunnel_dst_lookup(skb, dev, vxlan->net, ifindex,
-					   &saddr, pkey, src_port, dst_port,
-					   tos, use_cache ? dst_cache : NULL);
-		if (IS_ERR(rt)) {
-			err = PTR_ERR(rt);
+		err = udp_tunnel_dst_lookup(skb, dev, vxlan->net, ifindex,
+					    &saddr, pkey, src_port, dst_port,
+					    tos, use_cache ? dst_cache : NULL, &dstref);
+		if (err) {
 			reason = SKB_DROP_REASON_IP_OUTNOROUTES;
 			goto tx_error;
 		}
 
+		rt = dst_rtable(dstref_dst(dstref));
+
 		if (flags & VXLAN_F_MC_ROUTE)
 			ipcb_flags |= IPSKB_MCROUTE;
 
@@ -2479,7 +2481,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			/* Bypass encapsulation if the destination is local */
 			err = encap_bypass_if_local(skb, dev, vxlan, AF_INET,
 						    dst_port, ifindex, vni,
-						    &rt->dst, rt->rt_flags);
+						    dstref, rt->rt_flags);
 			if (err)
 				goto out_unlock;
 
@@ -2515,7 +2517,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 				unclone->key.u.ipv4.dst = saddr;
 			}
 			vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
-			dst_release(ndst);
+			dstref_drop(dstref);
 			goto out_unlock;
 		}
 
@@ -2528,7 +2530,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			goto tx_error;
 		}
 
-		udp_tunnel_xmit_skb(dst_to_dstref(&rt->dst), sock4->sock->sk, skb, saddr,
+		udp_tunnel_xmit_skb(dstref, sock4->sock->sk, skb, saddr,
 				    pkey->u.ipv4.dst, tos, ttl, df,
 				    src_port, dst_port, xnet, !udp_sum,
 				    ipcb_flags);
@@ -2541,17 +2543,17 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		if (!ifindex)
 			ifindex = sock6->sock->sk->sk_bound_dev_if;
 
-		ndst = udp_tunnel6_dst_lookup(skb, dev, vxlan->net, sock6->sock,
-					      ifindex, &saddr, pkey,
-					      src_port, dst_port, tos,
-					      use_cache ? dst_cache : NULL);
-		if (IS_ERR(ndst)) {
-			err = PTR_ERR(ndst);
-			ndst = NULL;
+		err = udp_tunnel6_dst_lookup(skb, dev, vxlan->net, sock6->sock,
+					     ifindex, &saddr, pkey,
+					     src_port, dst_port, tos,
+					     use_cache ? dst_cache : NULL, &dstref);
+		if (err) {
 			reason = SKB_DROP_REASON_IP_OUTNOROUTES;
 			goto tx_error;
 		}
 
+		ndst = dstref_dst(dstref);
+
 		if (flags & VXLAN_F_MC_ROUTE)
 			ip6cb_flags |= IP6SKB_MCROUTE;
 
@@ -2560,7 +2562,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 
 			err = encap_bypass_if_local(skb, dev, vxlan, AF_INET6,
 						    dst_port, ifindex, vni,
-						    ndst, rt6i_flags);
+						    dstref, rt6i_flags);
 			if (err)
 				goto out_unlock;
 		}
@@ -2583,7 +2585,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			}
 
 			vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
-			dst_release(ndst);
+			dstref_drop(dstref);
 			goto out_unlock;
 		}
 
@@ -2597,7 +2599,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			goto tx_error;
 		}
 
-		udp_tunnel6_xmit_skb(dst_to_dstref(ndst), sock6->sock->sk, skb, dev,
+		udp_tunnel6_xmit_skb(dstref, sock6->sock->sk, skb, dev,
 				     &saddr, &pkey->u.ipv6.dst, tos, ttl,
 				     pkey->label, src_port, dst_port, !udp_sum,
 				     ip6cb_flags);
@@ -2615,12 +2617,12 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 	return;
 
 tx_error:
+	dstref_drop(dstref);
 	rcu_read_unlock();
 	if (err == -ELOOP)
 		DEV_STATS_INC(dev, collisions);
 	else if (err == -ENETUNREACH)
 		DEV_STATS_INC(dev, tx_carrier_errors);
-	dst_release(ndst);
 	DEV_STATS_INC(dev, tx_errors);
 	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX_ERRORS, 0);
 	kfree_skb_reason(skb, reason);
@@ -3208,6 +3210,8 @@ static int vxlan_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct ip_tunnel_info *info = skb_tunnel_info(skb);
 	__be16 sport, dport;
+	dstref_t dstref;
+	int err;
 
 	sport = udp_flow_src_port(dev_net(dev), skb, vxlan->cfg.port_min,
 				  vxlan->cfg.port_max, true);
@@ -3215,35 +3219,33 @@ static int vxlan_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 
 	if (ip_tunnel_info_af(info) == AF_INET) {
 		struct vxlan_sock *sock4 = rcu_dereference(vxlan->vn4_sock);
-		struct rtable *rt;
 
 		if (!sock4)
 			return -EIO;
 
-		rt = udp_tunnel_dst_lookup(skb, dev, vxlan->net, 0,
-					   &info->key.u.ipv4.src,
-					   &info->key,
-					   sport, dport, info->key.tos,
-					   &info->dst_cache);
-		if (IS_ERR(rt))
-			return PTR_ERR(rt);
-		ip_rt_put(rt);
+		err = udp_tunnel_dst_lookup(skb, dev, vxlan->net, 0,
+					    &info->key.u.ipv4.src,
+					    &info->key,
+					    sport, dport, info->key.tos,
+					    &info->dst_cache, &dstref);
+		if (err)
+			return err;
+		dstref_drop(dstref);
 	} else {
 #if IS_ENABLED(CONFIG_IPV6)
 		struct vxlan_sock *sock6 = rcu_dereference(vxlan->vn6_sock);
-		struct dst_entry *ndst;
 
 		if (!sock6)
 			return -EIO;
 
-		ndst = udp_tunnel6_dst_lookup(skb, dev, vxlan->net, sock6->sock,
-					      0, &info->key.u.ipv6.src,
-					      &info->key,
-					      sport, dport, info->key.tos,
-					      &info->dst_cache);
-		if (IS_ERR(ndst))
-			return PTR_ERR(ndst);
-		dst_release(ndst);
+		err = udp_tunnel6_dst_lookup(skb, dev, vxlan->net, sock6->sock,
+					     0, &info->key.u.ipv6.src,
+					     &info->key,
+					     sport, dport, info->key.tos,
+					     &info->dst_cache, &dstref);
+		if (err)
+			return err;
+		dstref_drop(dstref);
 #else /* !CONFIG_IPV6 */
 		return -EPFNOSUPPORT;
 #endif
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index b47e997be7f4..72f33139426a 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -147,21 +147,21 @@ void udp_tunnel6_xmit_skb(dstref_t dstref, struct sock *sk,
 
 void udp_tunnel_sock_release(struct socket *sock);
 
-struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
+int udp_tunnel_dst_lookup(struct sk_buff *skb,
 				     struct net_device *dev,
 				     struct net *net, int oif,
 				     __be32 *saddr,
 				     const struct ip_tunnel_key *key,
 				     __be16 sport, __be16 dport, u8 tos,
-				     struct dst_cache *dst_cache);
-struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
+				     struct dst_cache *dst_cache, dstref_t *dstref);
+int udp_tunnel6_dst_lookup(struct sk_buff *skb,
 					 struct net_device *dev,
 					 struct net *net,
 					 struct socket *sock, int oif,
 					 struct in6_addr *saddr,
 					 const struct ip_tunnel_key *key,
 					 __be16 sport, __be16 dport, u8 dsfield,
-					 struct dst_cache *dst_cache);
+					 struct dst_cache *dst_cache, dstref_t *dstref);
 
 struct metadata_dst *udp_tun_rx_dst(struct sk_buff *skb, unsigned short family,
 				    const unsigned long *flags,
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index e298861e005d..fdfa5420f9bf 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -227,13 +227,13 @@ struct metadata_dst *udp_tun_rx_dst(struct sk_buff *skb,  unsigned short family,
 }
 EXPORT_SYMBOL_GPL(udp_tun_rx_dst);
 
-struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
-				     struct net_device *dev,
-				     struct net *net, int oif,
-				     __be32 *saddr,
-				     const struct ip_tunnel_key *key,
-				     __be16 sport, __be16 dport, u8 tos,
-				     struct dst_cache *dst_cache)
+int udp_tunnel_dst_lookup(struct sk_buff *skb,
+			  struct net_device *dev,
+			  struct net *net, int oif,
+			  __be32 *saddr,
+			  const struct ip_tunnel_key *key,
+			  __be16 sport, __be16 dport, u8 tos,
+			  struct dst_cache *dst_cache, dstref_t *dstref)
 {
 	struct rtable *rt = NULL;
 	struct flowi4 fl4;
@@ -241,8 +241,10 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 #ifdef CONFIG_DST_CACHE
 	if (dst_cache) {
 		rt = dst_cache_get_ip4(dst_cache, saddr);
-		if (rt)
-			return rt;
+		if (rt) {
+			*dstref = dst_to_dstref(&rt->dst);
+			return 0;
+		}
 	}
 #endif
 
@@ -260,19 +262,20 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 	rt = ip_route_output_key(net, &fl4);
 	if (IS_ERR(rt)) {
 		netdev_dbg(dev, "no route to %pI4\n", &fl4.daddr);
-		return ERR_PTR(-ENETUNREACH);
+		return -ENETUNREACH;
 	}
 	if (rt->dst.dev == dev) { /* is this necessary? */
 		netdev_dbg(dev, "circular route to %pI4\n", &fl4.daddr);
 		ip_rt_put(rt);
-		return ERR_PTR(-ELOOP);
+		return -ELOOP;
 	}
 #ifdef CONFIG_DST_CACHE
 	if (dst_cache)
 		dst_cache_set_ip4(dst_cache, &rt->dst, fl4.saddr);
 #endif
 	*saddr = fl4.saddr;
-	return rt;
+	*dstref = dst_to_dstref(&rt->dst);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(udp_tunnel_dst_lookup);
 
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index 5b6083a27afb..ec7bf7d744fe 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -126,21 +126,23 @@ EXPORT_SYMBOL_GPL(udp_tunnel6_xmit_skb);
  *      @dport: UDP destination port
  *      @dsfield: The traffic class field
  *      @dst_cache: The dst cache to use for lookup
+ *      @dstref: Memory to store the dstref object returned from the lookup
  *      This function performs a route lookup on a UDP tunnel
  *
- *      It returns a valid dst pointer and stores src address to be used in
- *      tunnel in param saddr on success, else a pointer encoded error code.
+ *      On success, it stores the dstref object that represents the result of the lookup
+ *      in the dstref param, and the src address to be used for the tunnel in the saddr param.
+ *
+ *      Returns: 0 on success, negative error code on failure
  */
 
-struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
-					 struct net_device *dev,
-					 struct net *net,
-					 struct socket *sock,
-					 int oif,
-					 struct in6_addr *saddr,
-					 const struct ip_tunnel_key *key,
-					 __be16 sport, __be16 dport, u8 dsfield,
-					 struct dst_cache *dst_cache)
+int udp_tunnel6_dst_lookup(struct sk_buff *skb,
+			   struct net_device *dev,
+			   struct net *net,
+			   struct socket *sock, int oif,
+			   struct in6_addr *saddr,
+			   const struct ip_tunnel_key *key,
+			   __be16 sport, __be16 dport, u8 dsfield,
+			   struct dst_cache *dst_cache, dstref_t *dstref)
 {
 	struct dst_entry *dst = NULL;
 	struct flowi6 fl6;
@@ -148,8 +150,10 @@ struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 #ifdef CONFIG_DST_CACHE
 	if (dst_cache) {
 		dst = dst_cache_get_ip6(dst_cache, saddr);
-		if (dst)
-			return dst;
+		if (dst) {
+			*dstref = dst_to_dstref(dst);
+			return 0;
+		}
 	}
 #endif
 	memset(&fl6, 0, sizeof(fl6));
@@ -166,19 +170,20 @@ struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 					      NULL);
 	if (IS_ERR(dst)) {
 		netdev_dbg(dev, "no route to %pI6\n", &fl6.daddr);
-		return ERR_PTR(-ENETUNREACH);
+		return -ENETUNREACH;
 	}
 	if (dst_dev(dst) == dev) { /* is this necessary? */
 		netdev_dbg(dev, "circular route to %pI6\n", &fl6.daddr);
 		dst_release(dst);
-		return ERR_PTR(-ELOOP);
+		return -ELOOP;
 	}
 #ifdef CONFIG_DST_CACHE
 	if (dst_cache)
 		dst_cache_set_ip6(dst_cache, dst, &fl6.saddr);
 #endif
 	*saddr = fl6.saddr;
-	return dst;
+	*dstref = dst_to_dstref(dst);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(udp_tunnel6_dst_lookup);
 
-- 
2.51.0


