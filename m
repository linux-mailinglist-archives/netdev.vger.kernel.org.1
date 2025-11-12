Return-Path: <netdev+bounces-237863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FBDC50F74
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 08:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1AD34E3655
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 07:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FA22DC352;
	Wed, 12 Nov 2025 07:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="baMDNdgO"
X-Original-To: netdev@vger.kernel.org
Received: from sonic313-37.consmr.mail.ne1.yahoo.com (sonic313-37.consmr.mail.ne1.yahoo.com [66.163.185.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B9B2D9ED1
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762932965; cv=none; b=fawqSrwtqbfTVykS5/HP69r8Y4DA0yKQHOPBwVGHIV1I7NGw9lDwDbpXyNZl3RJw/e27cQl4cjFeeojyYnG5Q6Nc/XgbrUekSSWDt+CcDTxhtKPd6VJvlyops7C2hN0uVHV9BuxqyBmA/ygqGGXANnNd+3OvgnvrDALWm48CvVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762932965; c=relaxed/simple;
	bh=4uOGwnNgXH04gL7jR6qTSqYmJPn4ls5n7DDixCceq50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvK6zAWe90D6kA/MgL5fkSbIevx/RJcUMZgMIoy9vmWAjaws8yp9dMiuW+Nsoc7J1tDE+66h6fm4PFmWF9myKVscHjbd5/Uv3P7fFWJ6oicyHznAjaLNDJbLY/dGnNscSU3vmtvrEFsroFYu1fQ4370dspXD7hbZtkHYwNUoIsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=baMDNdgO; arc=none smtp.client-ip=66.163.185.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762932963; bh=p4lHo2A6K0Tq+mXNLWC4SEBu8Jb5v+Jfanesb5yXt5Q=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=baMDNdgOyHXNqB8uXZTwkhebGxMEBFDxC2SBAnhQhImkHxl90dTrd7NCP5WP6u3+1Gk5Y8eQN2xpmXU1Rm+AvEuk4OwVbQrNGYh3jlatcp1gixcj7rA1bQY+36liJQ38CXNl/p8825NfosBlucVmBDgtd14dO705fsXr5DvcKWAB5Xeg7fPKh0hs/4UhrjGCGA6bq3f2YL7pbjjVLJqZTBzHTPE6ChvW7Lwg7g8WEuwPS+eNfmJuojftNB1pTjmVmUqV8MbZQgx3D+OxkPschSMdUrBKEd2CqzhNbN7bcKZ5vizX+mk4J3YC02kb7InEQPU+V5nWB6KnrFv2Lmo/7Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762932963; bh=B4qbKfcfVwvUdJXDmNerK4pZld4pT8emHtY9hLZU4x6=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=MEK+MvDfXMM0y+vr2/LNOlqx7fZg7yWlhwaUigvqZB4LwBG7ywiH4U3jHAyE4jEkKGDl9lcmwAGcRJg/uZrNa0TN4Tl01BH6wIdh3szF6T7bmxR5KMQBTBQUc1cqWQ+xRDdrg6GoZYFdSnEapKIAOvUctCd/Q45QvVUqZhnq/D5Xs1BREzAQURs91Au4rUpD819bBtZHoCIITweNp1jD35IZUP8b5fEy6kNZHS6fRHamO2rXoZtMQfWYJ6vqZVvg0kHhxmtOuhQVxT5Yriv+/7+0Hi2+otbWtj2tp68a+cpWs8j5ajgYSWAMrPNm89kK5pnJOtbYrvD4N56R08D4oA==
X-YMail-OSG: ZFCTvgMVM1mMylDZmOxqlnreSoVcMHg43mVxKMLVFfcZ0tYstUPtV9j8UgKR2A4
 fKajeKQfU0_bzPajAUqY5ZHxX6L54fTcL7Pwhw9MDIy8r9JRMIuAn1_RKeGCkinmczaQBXZXXCER
 _e7r.tSXOdU0eMoI9rLgVAUDZ0OQJUFsust9MXYyl8EAIIzf_qurYofJBMxrGW.fsfyWH30KBfGn
 QdLtZrJ5z0Se0hdgQjuuTHyewh3_N0RF47XAKadv_6AnRdTZLFlxcTMO9OHQMxWKV6RFHi9wKi4N
 4wiaW2hc.1wbOXO4MlNLLIwKVbJD92bptiPN94.V642wmsWt9RLkTv57Tx9hBRsaYKjadzdNy0YJ
 lKcPXtDUR0S_MJV_yt3V8bSTOg48FDoiRi_WPZ4LX6.deqPtr7Cp_GHu7K0qy0UD3eDKDbC6ZoVg
 25_0pH8mF0BQEWgqzcOpRPNoEoRs1ha4on2VP6gheq1GyQcaQel.kY7S2bWSRH806ou4BDdfaAm6
 70qg2JJHUbg1U8HQjnaYF6RTUirriTHM.bqTinjIl.b2YCMHZ6VpOCC860ai4QnQOrRikPrEdkS.
 YgdLI145__u4Yod1DIg6legAyJskxyYltQfxveOmUDj_1B3q_T2N1kni_J1OgxUmpblLZw9AFqVz
 UWtTiu.TdMWVfsIcFlif9gOH6pCJRJzPCgskRo9JVzjrfMUM0s9rcJKJVyPNCWjedijZUR1YbtwD
 GP_3WrqorzEKxv3KIqu0S5QNnonZYNq4RrFq1OegwNw7Y8kHUFcWinchId3U_Ka8O900_jUG88md
 iyNjTjt1GoXNA1sJmdKy6ZCwMWMf.bLTYXcABV8SXeX7HshDxAUhGKE2KMeS2SEqI3BLW4kkG4Hd
 cpJLqKj9t8k6_IJyR2ArhAL5Q0.GGcVHN3uWbRzt6qLg719Wa7nbfjgjnkkNpqekxDM.27BrkNyW
 f29NpVpRJjo9n91lHUNOhG8OK.W7J_yNQ3Q7dI.Mo30tQHYjrJ_kKoC6Gu4lXMO6WsAdg18pP_h7
 wx4zC__YZ6Hrz79o1rFN4TfVf2N673OCRDXCKL8.1soaQ1TZM_vTs7VhtE2Z07L2Cl506XC_PS3I
 j8ov6XZcYji27KEwTx7ilIRX86YzTnadVs7Yh5LimVSzJC6MWR51CSvGIxst5FKTCdGcRQbB0ke_
 JmsAwPRySfw_yMIuPhi3HnDoGL_X_PrW0f92TF5llkLvGh_Lc7xYT_0JHH_YxWo5Ygk4hxFNVJjR
 v0Okfvh6gP9gE4Q_vbshkvXW2atMnBUlvwNJzH8ExeXc1hcC55vW7vuZJy1UwnYVLd9slwQsA2iV
 jaDLheJuAXfIz5W.3v33AcZBTh_YhSVLuW9nLkZH2t3m1Tb211wG_uN0eBFiVo.Qunva2RplMXi_
 f1RxIErlh.G4UZH1r13QoHnm0AWNTJ9gOP.EsPqdq1fr.afRriU3m_H3QzOAkanAJ6kWKaaNTzX6
 DA7iFn9nTagyD2_M5BUMx4eKG.dxSF8p_dmKeLThWL6vnr4Z9BHumf4nyXqbCAWb4evX5So__XVJ
 0dqb5NNAJQpetsXcADOi1HA6hGCEhCsfqPtCWdDiA9bTH_UX_1UFsgmYdWJnJtiA0HaqqspKjKfC
 Pxr7yKsK_MazAnO6zKFuOfOp8X8W4jEt_jZEZ_OpWyaEHtYK1bVODWu8oBnLUqVmASJu1ZQtFpi9
 hFmCEaDKCpV0Sx3KiB6QQEKd0TuDurPCqFxFq8An5gK7Lxmpb.bHufsvcMclflA1avjucjSKT1rg
 icspuY8jSdOXPFllaOIJkV6.6todeHGVZTZlhHXUfzwhyxvL.FEEuvWqSfzYJtmEDWv.PSaIGOrc
 RBujv2MhioPzCoVjW13GFoF8a8zfj.aWnVlt20Cxk9_pT2FWXE_lcD8D6eXmPrn.tXz811yrBlXB
 57YNolgglqRdH4lnjCCGJ6QtScVlTWkAFhldfV6onEKuDhXgWnNml2EA9v5XqRjXz7rkL3Bf2Jhe
 lHHg2Ngm5qlADmFP_qs5ng1W6qqvr2eOmyZrwlxlDvEQFuUxebPn6rvGI3sX0le4Ks4gOI.o5s5F
 EvI0Xj1wQyXwaTp0WmlCpnFWCuPOnJY3xnfPphi3sEtZgQj9XbiOfJUECaV2Bo6bfVf2v6P7Si41
 wYWU0vVx3fIS0euhzxxoeB5P3syVgtUR6f.21u8qcCL7xsT4b0mQq44mq2mwaBeiDgEv0QmBkssw
 HZSosgzqquQ--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 81e63dd1-af62-4099-a785-265cfc3d5caf
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 12 Nov 2025 07:36:03 +0000
Received: by hermes--production-ir2-5fcfdd8d7f-gtwf2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8a3972250952fefb5c72bc783ca56e47;
          Wed, 12 Nov 2025 07:34:00 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v4 12/14] net: sit: convert ipip6_tunnel_xmit to use a noref dst
Date: Wed, 12 Nov 2025 08:33:22 +0100
Message-ID: <20251112073324.5301-3-mmietus97@yahoo.com>
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

ipip6_tunnel_xmit unnecessarily references the dst_entry from the
dst_cache when interacting with the cache.

Reduce this overhead by avoiding the redundant refcount increments.

This change is safe since ipv4 supports noref xmit under RCU which is
already the case for ipip6_tunnel_xmit.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 net/ipv6/sit.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index ba65bb93b799..98f2e5fb5957 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -933,31 +933,28 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 			   IPPROTO_IPV6, 0, dst, tiph->saddr, 0, 0,
 			   sock_net_uid(tunnel->net, NULL));
 
-	rt = dst_cache_get_ip4(&tunnel->dst_cache, &fl4.saddr);
+	rt = dst_cache_get_ip4_rcu(&tunnel->dst_cache, &fl4.saddr);
 	if (!rt) {
 		rt = ip_route_output_flow(tunnel->net, &fl4, NULL);
 		if (IS_ERR(rt)) {
 			DEV_STATS_INC(dev, tx_carrier_errors);
 			goto tx_error_icmp;
 		}
-		dst_cache_set_ip4(&tunnel->dst_cache, &rt->dst, fl4.saddr);
+		dst_cache_steal_ip4(&tunnel->dst_cache, &rt->dst, fl4.saddr);
 	}
 
 	if (rt->rt_type != RTN_UNICAST && rt->rt_type != RTN_LOCAL) {
-		ip_rt_put(rt);
 		DEV_STATS_INC(dev, tx_carrier_errors);
 		goto tx_error_icmp;
 	}
 	tdev = rt->dst.dev;
 
 	if (tdev == dev) {
-		ip_rt_put(rt);
 		DEV_STATS_INC(dev, collisions);
 		goto tx_error;
 	}
 
 	if (iptunnel_handle_offloads(skb, SKB_GSO_IPXIP4)) {
-		ip_rt_put(rt);
 		goto tx_error;
 	}
 
@@ -966,7 +963,6 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 
 		if (mtu < IPV4_MIN_MTU) {
 			DEV_STATS_INC(dev, collisions);
-			ip_rt_put(rt);
 			goto tx_error;
 		}
 
@@ -980,7 +976,6 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 
 		if (skb->len > mtu && !skb_is_gso(skb)) {
 			icmpv6_ndo_send(skb, ICMPV6_PKT_TOOBIG, 0, mtu);
-			ip_rt_put(rt);
 			goto tx_error;
 		}
 	}
@@ -1003,7 +998,6 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 	    (skb_cloned(skb) && !skb_clone_writable(skb, 0))) {
 		struct sk_buff *new_skb = skb_realloc_headroom(skb, max_headroom);
 		if (!new_skb) {
-			ip_rt_put(rt);
 			DEV_STATS_INC(dev, tx_dropped);
 			kfree_skb(skb);
 			return NETDEV_TX_OK;
@@ -1020,14 +1014,13 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 	tos = INET_ECN_encapsulate(tos, ipv6_get_dsfield(iph6));
 
 	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0) {
-		ip_rt_put(rt);
 		goto tx_error;
 	}
 
 	skb_set_inner_ipproto(skb, IPPROTO_IPV6);
 
-	iptunnel_xmit(NULL, dst_to_dstref(&rt->dst), skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
-		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
+	iptunnel_xmit(NULL, dst_to_dstref_noref(&rt->dst), skb, fl4.saddr, fl4.daddr, protocol,
+		      tos, ttl, df, !net_eq(tunnel->net, dev_net(dev)), 0);
 	return NETDEV_TX_OK;
 
 tx_error_icmp:
-- 
2.51.0


