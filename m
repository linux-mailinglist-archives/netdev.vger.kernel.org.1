Return-Path: <netdev+bounces-267144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4I+fCQLmsmktQwAAu9opvQ
	(envelope-from <netdev+bounces-267144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:12:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 319B22754C3
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF84630AAA53
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C373F0A8A;
	Thu, 12 Mar 2026 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JbHElXkQ"
X-Original-To: netdev@vger.kernel.org
Received: from sonic316-20.consmr.mail.ne1.yahoo.com (sonic316-20.consmr.mail.ne1.yahoo.com [66.163.187.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F362D3EDAD1
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331167; cv=none; b=JfKCpyM6vJX8sXCP/krzvZ1LUNYqlOZIe4GYHXtYApS+BJhrBUGBsY5DFxwWfPUPKFI05TTMoaNdMBYU8uYp8XAfPG1Gd9+NxWlqiwAPuXlYlHrVPUUlSR022bMdOekHqBgw0i78Qlz4EMBL+MhHuBv3Yq/1kxJb359vebPHoBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331167; c=relaxed/simple;
	bh=HdScR1ke+oeTrzEpjQawuMi7wuNwYQRtfSAOjRfdKYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Atq9SSWHG91yPTwUkHWrhMGfw9hurfsEGJx5/wIL68TPGkQ5rKLLKSbV0xabpz8DyyiKkNb2+JDDObIaITdNVY5BR3ZJ6jYXBdEjrw1hap/VCLfe8H5kwn/hQ1bLXAxbAjdJmZ9AdUQ9VfFhWqdf1CTqA4Cz9iAfJ7ZggjhelU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=JbHElXkQ; arc=none smtp.client-ip=66.163.187.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773331164; bh=8hL31pIyNZSdKzjHdSCEMPDRyF5+nOOmQomX5xp2eSs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=JbHElXkQ3zywHOBN27Q6MMY6jhF9fxnOSq3qlaGB45sqdGGHOFZLpcgLbJBkioojAknaH/otM91jKYasCzPDEt0Qvb1n1qfWu23L43VUacm7UJEaj9sDH2+f0iTGSHTj/GOg0uXLTVmlmyc1LK+J2k+sqgJsDClIjvw+osECpQFOkLWcbye6b2NmAh79Q9U++b+ZHfIWHrPg/0Q5as5bULlz3gG2xfakcda89TOKMM6lJfNmMme3L3THrxD7luR9zrWlDmIoHPEV5qqUtK+2raSExCZYbkvGUCf/90ypjM1NkBcnM8B6MwaH+Pmi1w+lALxnQ0U7C9vbI1PiWs7sog==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773331164; bh=vu+Fyc/p3+pzsyzbac2yVjcX0iATOyNnj/IHS7H2i7S=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=knkp117Gs71LMPzoLphvdE4pgQKZb6ZzXQx3OLV5LcG/MYRxYqMBdhcxhsjKdEZFTQV1ZKA5niSfHh4uhLaNTcE2tQJknjOlvsfHV9bohApyvqa4BnRSatDrrzzchMHZGim3B4ai950V8tMYHUauHqZl9DdMVPbZveT72y3niGzThdzuo3lNiIS2YMGS+Qw4drfAtJjB2GsN/Se732N8ejAJf9GysWYPGNyRLl0VvJWgwl6H9ZyiZJCCKotDuIT5EpC+a0RUM+3EpwTLfKW5xVffavenXcmknYbjARFbWLUIIWyq95EEKPEHZRs532SSsQ6M0RazG11Yj3sFirLoCg==
X-YMail-OSG: SllPBGkVM1kwTCOU5V13Il4NJ9_5je0_MB0TEsEX00TwSDhXrgqKlbeWVNbHrt2
 iK39Hvexz6YYeSrkuCVFpEg.XnxXGCDJQQ61iyHOEip84g_KjlCOIpaQ.wuOjYbZynA6Rojo73GQ
 cRbROQ1ujBRcko13ennujBSm0fCJfsqS03nuX2SeK0RaGVvS.fW7QPKq7bT4pkeOhLaqV1wCdSIK
 Jt9cHTGSARAYhhusy88Qwn3lkbOargrxOfhR6.F.Nb25bVScFtJcInMgl9LZ7JZTYbdyQz47kQq0
 oChNXsxg8RgC6rzLJsdCFcWuwpSxJN0Ed5yqWkpIk2eaLMLWcnJ66dLaXAAsP9GOR77RNSGu9HqO
 an5egCH7IBOL0uNmCAfBHWKmY7aM.NE6fwwxPm2xXcpImM8SkvR63kiYmOnVHieD_Tjr31LkxVgq
 EQLL4yTSM9vPrIA7xujdDWlzC8Fk1h0ohfiWaZdXjxzKRsJP5SoVJQeofGNIkYhpMftIL88AYmnz
 t.NIirV.MTySUnpGEDJSq0GWnqamTwK2zp7e_sR.tOqphTgXl_CI48inAS1n3d.mQvamuG0NPpkC
 DswnCqsyD53Ek_mt0__sENyeEBUr8tAgOg4SOCB0CH2Fm3Cnp4I2BI3EeLr1KtnGeLs2DqU69oyP
 .x0PmyZYx2fD12ao91oHaDY6ti7V0cQzi6Qru7Uu4SBa.aONJKAR.BcnVd7oWNxZmUJGDeddFx43
 HuEEAdEOG8DbGk85BAxsGyelDMsJb31pHkdf2aJphBnoXUmF2nt6XMUA4fbn9noYrOTVYhByQw8Q
 NwiYrEzuWPrnWV23.jU1vC.rynJiE31SdDGhci0n4dVBpNoMISWvX07Q0Z6GBWmJgOyIYEXoI2Aw
 smYKiuDukgpaC4GwBXXHXqvnv9jSNOkw1zHHLGtKEoET7d96ZhX_DFim0AiTRnWd4I7eWf5WKKD1
 G3hiq8jHCmr2OrkI3a3ezxKwn4AcbbF6Gbc4KU08wcEpF7gx6CAFy8AZWUuCCmGsRp04.g8jfbNy
 .3QgOnMVzsN6Z1DIJocIokgYD0Er1Izmpmk9.tr6XL1NQwL2Hl8gKQaL0.alCcBY2avLaA6qdS.m
 Ph0UTTQwCj7ujHtPveXCnvPvpDJh2s5lwKCc72ZsKES5t.7gwF7nQyYfBO71vkKAop2G.CYFfBvm
 c_tBr8ZdaZSboQc2mKnuNpPizf_Q3StksCGR1Oaz3y3787yRIN8RGKC6JbwmF8rfTZDpCUVUnbG9
 5IEtc1zY4qjeOJ0S67odBcthS1dyi3K_dvmkcsYm2.wV.UDesMKBjjt2QQej..0UrbIURlTEQ_50
 HYqNHbWUbgPKzTFOQdGEzo3eNcQtwQCp5kKNxcnU8PO8mY.lqiFRQPXsALzyy0BUFFPmmmfXID1.
 r6WjvIj3xve35nLF9Fnlb5tMVQ0_FXPsxpF1dwLoWBKvB2.lgu2U6T_bhz_q3kBiYYIUWFlYQnd5
 oOgBb2mIQIcPXfDDhgHfA1tVnFcNr6dNjGUcw7OeXPw.rkpGxXIy2sqAXpnMnkzxnKZC..BaJ4em
 XafO2B_Hyypkm6SYiORDZpvk2RSTKxZYwHqoZIFBz0X0rbFDYeCRfJTewL5yQIdLZFqhgFctQDDj
 D9dtT_vN8b1iK8NPVjSvR1kRkT2ElpvJs7dgw8p4Wj8KxHCrB.I1IDa39gD1IJbmwq2cN1XnPXJC
 8Nv.dqiFAgiIYbZvqr5tmfF0lkditxBD5Cvz.DIsuINV709U0PXvXHzNanvlaq8UACiuO29qElo9
 HKSMdixKt3or7aqjYaVKyBbFGSyxik3ofbEOo4UVulxHo2tfnPDGjYQoC09yzLEOdV5DQH53qcQv
 H5EQSTDZpfZBdXOBBjvYnDrt6ZHUC5sxvQIx2UIBPjvDgPI9IReX_1Ek_NcCgnvdmxJe_Xud7PQM
 bljl1zkUjlA6xAVrdSX2IJtDJQKdwIU7KnEza64TXDDuae3V8WcqFPeYPbDelfwNAYuGBjRDH9H3
 MWOLgp_QOMXcRlYby_568EFfIzJlMiyb76VPcapbMR44oiB1psr.43Tzc6OVlcSNN2p4snDNRoM8
 HzJMWmJuL97eIbgz6O1uDIQ2SiPBDjFA.GkjcqVi1kwEaFwdk0rsVjFzAO5KuOUg_rmM_6kNslh5
 62EcV0QjvBm0M9HS3DStLRRu1loeR20fwzL6oYNVpVTHBM7.4IrT_f2sA7Vs-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 8a0d0b7e-d458-44b9-99b1-e131fc47ee79
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Mar 2026 15:59:24 +0000
Received: by hermes--production-ir2-bbcfb4457-pgdzr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 87d652406d88cc03e8e5278a11075b9d;
          Thu, 12 Mar 2026 15:59:20 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v8 07/11] net: tunnel: convert ip_md_tunnel_xmit to use noref dsts
Date: Thu, 12 Mar 2026 16:56:53 +0100
Message-ID: <20260312155657.25676-8-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312155657.25676-1-mmietus97@yahoo.com>
References: <20260312155657.25676-1-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zx2c4.com,yahoo.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-267144-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmietus97@yahoo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 319B22754C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ip_md_tunnel_xmit unnecessarily references the dst_entry from the
dst_cache when interacting with the cache.

Reduce this overhead by avoiding the redundant refcount increments.

When using the cache, the found dst is either taken noref from the
cache or gets stolen into it. To reconcile both cache and the no cache
dst lookup flows to use a noref dst, we drop the found dst immediately
upon lookup in the no cache route lookup case.

This change is safe since ipv4 supports noref xmit under RCU which is
already the case for ip_md_tunnel_xmit.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 net/ipv4/ip_tunnel.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 2136a46bcdc5..d0e8fb7f040b 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -609,7 +609,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	use_cache = ip_tunnel_dst_cache_usable(skb, tun_info);
 	if (use_cache)
-		rt = dst_cache_get_ip4(&tun_info->dst_cache, &fl4.saddr);
+		rt = dst_cache_get_ip4_rcu(&tun_info->dst_cache, &fl4.saddr);
 	if (!rt) {
 		rt = ip_route_output_key(tunnel->net, &fl4);
 		if (IS_ERR(rt)) {
@@ -617,11 +617,12 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 			goto tx_error;
 		}
 		if (use_cache)
-			dst_cache_set_ip4(&tun_info->dst_cache, &rt->dst,
-					  fl4.saddr);
+			dst_cache_steal_ip4(&tun_info->dst_cache, &rt->dst,
+					    fl4.saddr);
+		else
+			ip_rt_put(rt);
 	}
 	if (rt->dst.dev == dev) {
-		ip_rt_put(rt);
 		DEV_STATS_INC(dev, collisions);
 		goto tx_error;
 	}
@@ -630,7 +631,6 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		df = htons(IP_DF);
 	if (tnl_update_pmtu(dev, skb, rt, df, inner_iph, tunnel_hlen,
 			    key->u.ipv4.dst, true)) {
-		ip_rt_put(rt);
 		goto tx_error;
 	}
 
@@ -647,7 +647,6 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	headroom += LL_RESERVED_SPACE(rt->dst.dev) + rt->dst.header_len;
 	if (skb_cow_head(skb, headroom)) {
-		ip_rt_put(rt);
 		goto tx_dropped;
 	}
 
@@ -655,7 +654,6 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, proto, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
-	ip_rt_put(rt);
 	return;
 tx_error:
 	DEV_STATS_INC(dev, tx_errors);
-- 
2.51.0


