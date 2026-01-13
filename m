Return-Path: <netdev+bounces-249511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE70D1A4C3
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 17:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E212A3010748
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0DE30B527;
	Tue, 13 Jan 2026 16:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XFAtjFz/"
X-Original-To: netdev@vger.kernel.org
Received: from sonic312-51.consmr.mail.ne1.yahoo.com (sonic312-51.consmr.mail.ne1.yahoo.com [66.163.191.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A1917BED0
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768322067; cv=none; b=PwgybYoTFAKbJNd1SuN/yixMJ7MmxzvqYZhglQ6WPnfgxpOGdqEzaGDhzPYxc8C4sFY8nNQ0zYKEnioeswb3RQtWTkcgDxCDJLmThj46XZi6/SWZshIhUvDHkgUjkjWHVKbuvHvWKLrzN+Lv8hUhKfo7Xx14UbWYVq050cvFSeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768322067; c=relaxed/simple;
	bh=8xj3U9/3yxUNDQNum0sjSyfzBl1q6pLkeHRAvXpcWSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUQRYLKdAYne8ztTXnp8F2zCbn+bcbwRiARusAn1wGUhaIa/9pgX3E3SVZ6uY/lZZMVh1PxnxCrrmuZmHr3M7G+w4vFYBRlBRjow/zatKkfkIwJi+baZJnsCMUlEKyVykpJrfDLvuX+eufmI2yTpJ8RWLs03mIoIq/Db5YboDAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=XFAtjFz/; arc=none smtp.client-ip=66.163.191.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768322065; bh=JEJ5C2+G5aZ/9Hkl48dcVJ0+yWVtroZZD+X3SWb6xVU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=XFAtjFz/kikMIiCHy3fstBgUS9zbV9rHOk/eqfbuKsoE/tKiJWsdMi6EnrFFrXTXpb3PRFz2/ZYDZJQy98Ho671sGk+6QEtElTgOolmlXakq236kB0nyj78GG0qVatmE1IGuteYG6lknd2bp76Qv9Zw8vWdJ3db9MtbpEqqr9LlgG5VW8K1zzLzeEgtWnRhdLdUX6QBpCOhR4QExeJpmWpzUb8b8oBO7J6rzzpk9I+6ux8MTUbHdps/CNn4L0DW/DEv250GS8/R1VRSRonYTlvnNEe2uYLiPLyYFHDKNz05KpA5F7fkdHXMRH87cE1x98q42RtSIHkW01+FKh7PLpg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768322065; bh=JHbeLlmx36ZDowYv3Wiu3iFz335TqiD/22EAR/3srqz=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ULnT6flQCsu3ZMU87xwKOhcj1QQbifCFBhef4VcAdOeTaEgF7NqjMSUcmKFdVscQ4wdshP/DbwZABGJf+QS29CM+SYk3EFAn+k9W8YR0x2OTdEaArQyjlXFzGBjNliRnoxTVQ5efHnbAPAo4cm3aPeln74YPsYNBux/cXtN00TfJJGcXNl88cFJfNDYg5smJwwtAbCswpang4kqpYfc2wV8atZ6ZpYluv9eH2oK53BnylmqEYh2sNGxp+UPvtCdrMIe79AWyuaIljHS+S9CuRQIXbBrfd5+rLPd52CmcvPjxlGmrJ86lCg/qgmP0uVSJROOyutw1FdNqMjJ9k8Yu5g==
X-YMail-OSG: b.WQqqwVM1mZRnXHtAtnybrRjS0cCFhjsCOQKF2_6JXWdCtUEC9udQfT4VOcfsE
 CA.Z7cAlZKTXaQpFY_GR7mYrM4WU5YvzsjhT.ImiviOQNKbL6Gzjq3JuWnCA7u06rY0zZJkfBx6d
 JguJZRDnYd_mLAYmN4mbyA7D4PdEGteS1AVQZoZxB2lfk_EH8tQVK0f06HALJcltzrXG_PCef_u0
 B5U_yafQhVOrAhWb7YBDTIRspwPFknISUQA8w55YWtbCXT5kLVwn6TdvR64MksghbobtV5XbGZlK
 wi8X0tfBLU966FvfyB91OS02TT54E6dhsGIX3DUN7m_t6sLacs3L.JA_byDNzYfKoHeMu5yOqYTN
 u5AxNKolCj7LwZbawKTQRZmfCK.yOVJi9d.o14LshrzpEoqPcQMkEJt47GGS6A2.D0MOC.z5bYUp
 5Vu2j5EkDLkHgQAFfhy4.5Z59B38IK5Q0iSWZ_aSgxAQAT9VYVs.kLdsIgegl7Eccq4FK5xwNiBb
 y2NyuisP23OfAoCXNt64vu5FKct4JHYINwMpgiHkDi5EqL5giftFThQnelVEqqJsWL7ngiYr2Xng
 BVW_EmUJ_zGOjMnK8ar1GYFOHXyocqZ2s3SuROwKHx286rXOq_a2D8cFpv6tKvipnv22Gks3MuCe
 ampkhDsRBy6i1JMRYgxy5HhvY4qygRDuO5sd5jQAX.LGdM1cFhOyojrdL8G857VG8DyIlQhq3dd0
 OL2_Hp1.SirWarYqwOORvzJpSzG4J4Fk5mItxXrE.zdGZfhP0poEvuNzVcvveXQMN09ZL3kgIv4w
 _GvgUjH_P.sCYV6JDRwz5pTYdr94WI3hkeIPt1GlHCMUBgPyZzmHzCjSkxjvvGYNMJ4mUAFVlakk
 TGE3A2D8X5kYVwsEl5jZvekW9Q0qCvGdJbUTjzXO4iB.ExBieSM57Yk.ZaL.vzlPYSzQg8pLlBgV
 kM1nCFzndkeez68Eo.pRvtoKP6yU.9c6sqOaabbXl3hyNUn1JGfC8OQBtCIXzT1aO6uqcyPHKQHE
 _v_JUMdVHKY8SXh9BhyIbj.KIe6Gi40HFP_r4K1Q6rdjVzIfdFQmR1TDtCfP9kzqIODb31Az8C5O
 Qle8Jt56s6zAzURkJB_2dfZ5HNdsir849rmQn8w535r9ixdGTotDNmcgaTIqwGs7R8vV2VQL8T9e
 YL0G0HMq2s3jSj7Lc2SOeI6FGsGUXnGHbt6I_aoBoL84tE9ji1US027b5zi_tPU1IGJLUkiPbul2
 LJAvP5SXba39rRP3bNzRZ12ffF2gnH42UmWGzsmcZ8bSRdbZsZdt37Sg6yD9XkBN6DzxetcBGDIc
 bazZcXNeWAxJe0YO2VJOoinl1ipj7b7guvanirGvPglpndYfQko46zXpXtjy8Wyl3h_RFsRM7z6_
 SNCGRgS8wnP.RdsseP7BLqVrRA7IJ_tsmKxUMsUrlB2n7Ut_4c_wWRMP2ltU3ajQ8MvC3LOS5CXH
 srcWEPZdhBJG9qBEnmBo0CILVLCAy6bZj4v8K4gk03sQSSYk3m9xvczAdjcH5FXCc71Prygt3sg_
 bblts5fTc5DFJV3hCNA3Ko0CBJ4aECCUiJleoLYuAyTMu.ZU7qoiJI0rga3KSfnxDkDS.seBVilc
 FJM4l6Pw3CnnamAijlFOaG29PlA.2.S4cOY91F.zh4Rpi8qzMlS3ro7OhUAv6r7JV7ahhnhTxiMG
 2HheoST3Hg21cpjif8F0oKV9Xa.Ic_m4uscgqL7S5sCgrQiqlEkxyrBIoIR3frwGXZ64WhrVKtbP
 qHo63lp9fbax1aiqX.WL5s9Vfm7WY0ZoeuFBX77winteHn_Uq8ltQY8LQGYNYGalSbdlevKF9.Wz
 PdAqau1.EA1KTMhsgJQ8VCRAA_tCxmY1iZLAvMcdSBdSuJFs9pXbgTqKZ61MjQ5UpEKd3NW9Xj._
 nfTLrRLewMFURsRpZ8dE5j.rbRAoahUJwoBtyQuO3RrxJ04d5CWlHCQJYJLZ8FWmtYqPfsHCEVaU
 oUeBzTpGieCMWorDSzqpbOs2cZFaC_zSpW8v9Y9GLe1dgzJHLWfCtR9vWRxlvEmFw06Ft8o7p8Q0
 ZuZEytMjyl.pM5WfkkfttjpJE75F5K69mPm0ZXVo2Lsd32ytlqmFMd4Tsl1dKOFiHFeOzC.Z0aDZ
 NHmH5quMe3PqYR3VdLjTILj3PH46VAXEUT.Z2yn4p7r9Mq3uMzfwGyLlbJJ7vd6BBLCskciywuE9
 XggNYET.8AI35B90nzhYDMw--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 30117211-8dfb-4cf5-b6f7-fc58cb2b8bc7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Tue, 13 Jan 2026 16:34:25 +0000
Received: by hermes--production-ir2-6fcf857f6f-7nlzs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 11e96f127f9288c2e2174b22f2ee0351;
          Tue, 13 Jan 2026 16:32:22 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v5 08/11] net: tunnel: convert ip_tunnel_xmit to use a noref dst when possible
Date: Tue, 13 Jan 2026 17:29:51 +0100
Message-ID: <20260113162954.5948-9-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113162954.5948-1-mmietus97@yahoo.com>
References: <20260113162954.5948-1-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip_tunnel_xmit unnecessarily references the dst_entry from the
dst_cache when interacting with the cache.

Reduce this overhead by avoiding the redundant refcount increments.

This is only possible in flows where the cache is used. Otherwise, we
fall-back to a referenced dst.

This change is safe since ipv4 supports noref xmit under RCU which is
already the case for ip_tunnel_xmit.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 net/ipv4/ip_tunnel.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index ab10759dd2e4..fa34e6cfbe35 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -681,6 +681,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	struct rtable *rt = NULL;		/* Route to the other host */
 	__be16 payload_protocol;
 	bool use_cache = false;
+	bool noref = true;
 	struct flowi4 fl4;
 	bool md = false;
 	bool connected;
@@ -775,11 +776,11 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	if (connected && md) {
 		use_cache = ip_tunnel_dst_cache_usable(skb, tun_info);
 		if (use_cache)
-			rt = dst_cache_get_ip4(&tun_info->dst_cache,
-					       &fl4.saddr);
+			rt = dst_cache_get_ip4_rcu(&tun_info->dst_cache,
+						   &fl4.saddr);
 	} else {
-		rt = connected ? dst_cache_get_ip4(&tunnel->dst_cache,
-						&fl4.saddr) : NULL;
+		rt = connected ? dst_cache_get_ip4_rcu(&tunnel->dst_cache,
+						       &fl4.saddr) : NULL;
 	}
 
 	if (!rt) {
@@ -790,15 +791,18 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 			goto tx_error;
 		}
 		if (use_cache)
-			dst_cache_set_ip4(&tun_info->dst_cache, &rt->dst,
-					  fl4.saddr);
+			dst_cache_steal_ip4(&tun_info->dst_cache, &rt->dst,
+					    fl4.saddr);
 		else if (!md && connected)
-			dst_cache_set_ip4(&tunnel->dst_cache, &rt->dst,
-					  fl4.saddr);
+			dst_cache_steal_ip4(&tunnel->dst_cache, &rt->dst,
+					    fl4.saddr);
+		else
+			noref = false;
 	}
 
 	if (rt->dst.dev == dev) {
-		ip_rt_put(rt);
+		if (!noref)
+			ip_rt_put(rt);
 		DEV_STATS_INC(dev, collisions);
 		goto tx_error;
 	}
@@ -808,7 +812,8 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		df |= (inner_iph->frag_off & htons(IP_DF));
 
 	if (tnl_update_pmtu(dev, skb, rt, df, inner_iph, 0, 0, false)) {
-		ip_rt_put(rt);
+		if (!noref)
+			ip_rt_put(rt);
 		goto tx_error;
 	}
 
@@ -839,7 +844,8 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 			+ rt->dst.header_len + ip_encap_hlen(&tunnel->encap);
 
 	if (skb_cow_head(skb, max_headroom)) {
-		ip_rt_put(rt);
+		if (!noref)
+			ip_rt_put(rt);
 		DEV_STATS_INC(dev, tx_dropped);
 		kfree_skb(skb);
 		return;
@@ -849,7 +855,8 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
-	ip_rt_put(rt);
+	if (!noref)
+		ip_rt_put(rt);
 	return;
 
 #if IS_ENABLED(CONFIG_IPV6)
-- 
2.51.0


