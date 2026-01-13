Return-Path: <netdev+bounces-249512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E103D1A53B
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 17:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 934533009246
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7CF3033C1;
	Tue, 13 Jan 2026 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DprPjnu6"
X-Original-To: netdev@vger.kernel.org
Received: from sonic304-48.consmr.mail.ne1.yahoo.com (sonic304-48.consmr.mail.ne1.yahoo.com [66.163.191.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4332EC571
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768322345; cv=none; b=XIeYMHpa2QpSzQClIBo2VTjeM3yCxL35+6pPXpmvT6UprF50vpUMU6bPB/c1ZGDvpakYUfuF8buXlxogoW3E2Rk6HJpKKWaXwZh+DovRrflEqLl+nwS49UfBCdboKN8xkQY2BLHTNCeJyBvf92/F+g2cJimjog9PSCEABiWJwKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768322345; c=relaxed/simple;
	bh=2w57D7+/qM2bN39wHQ6aVPREns/S7reCjkZxvxUUs+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyaNRH6nnkTeLeZlnO8Fie3nEiTyNUAcJS7dcC2IY4iu/1d+rvXpi9ACrIpBAN7UUa/4lIa3Ho/DhSY2udCk8IMLbGnqHxz7seieyiR17PMR4GM9FmhDdDAe3efCRNO6/fzF4xScbC2xVmWObLaBmXLb0JlU36n3BvIvqVHan5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=DprPjnu6; arc=none smtp.client-ip=66.163.191.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768322343; bh=4dgYFtQ0gYiUVlEZESl8Fg3z22Mb/lpYMkBBBd4uWeY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=DprPjnu6Dkdy6vIgYuea2Z4D5JjelWN90iRZUd1C7z9N+p1/uQkabQvMtSMV0cIXKYs5i0gCW4lYuGHybrtXUVShBUOdALlMcGKZmj/hAfTnrIhTwV3o/BReonRenOVmrHSLzvHt3Mg/pACBc9cWGfCl4hqAZ/VMmfVxahZb/3dpUIHK2ODAJcFwJlK0PuwJq0JMbcsaykggwMuQybXjK3bxuu307SuAji5c31+V07wV7CrecijBe/zSP/rErRZ7FcubM4AK892lR6Jl6T9u3BY2fuoh/t4BB25vjgJkdje4aSHu8NONCxN2E+SYRbTWuC6pmfusnFYTz7YoCD6L2Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768322343; bh=dcM8ZVNeslV6MU5LZ4u+HueU/RtmyblkypNVCjP6bVI=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Ufy8k8c6e4RS3fir/1gjUOkI5AfH0H52t5AmORmCTSb5FrUScbXXXwn0G9UBUTRpDYb2RBKOUzsu25XGco2g8cWHRp+B+pYfRLuqX9Hxbmi0O734H08P76KWQe4h2pZTbYJTp4IYces79pDBmIMx5BUie8v5GWu6kO2XWQksus3cUPGTOA/cmy+YgvrGGf/4CSWge0uW0cKEZa9wANq60PWjlmxoJBvMvKvPzogS3wLtK73QOPzjcmwQWn/KlMHMBZzlHWLCUDXnr1M7jn56Tzebo7XwahxD+l4HoDSETN0tF9Socz1vsC8wun6ffPAM5hwJaiVeS6CexaYuBoE8Gg==
X-YMail-OSG: nXhnAzIVM1ln4NRKHdeCj2gQ_LOSRjbJF7GaFYE35pTPBFCOnOS55AAJlEWL5Mz
 QrDe0k0zesFAEZmJjA1LOl80y3zOLocNVgRTsestzcgReMU4648kRbcJJ6._bl.njAChlvUPeEZ_
 bKLLRABnFuBMGZoWePZixpQesnQt35vVFmQvzPA1KgSVz0rDZMk0_ETh0CXfgAwuJtYkPNwaJW53
 k7gy4EA05mZACAktrWhAQwuVenctOSFwN_ZNzg2qalzJy1FZmSyTMw11nxTbVqO9zfj1zIFCRD7C
 rg6oJg.NWRosnxtj1t0ECc5nZba4wNuyCsGdgbuMRgLD6IClOruMuKc9t4nf5wKEriAnpdO8JKUH
 JwsToTy3Mj.5Yy3UgybmRERakl_SdMkQNFfa.NYe69Q0l0QXXOSn56HNh63FLWhVNhV_AxINN_24
 pbLnvWi4fgY2apHT8S4OqmOUiKNg1oqfkA5atdpJTJGZ2pcs0l5n_NnjnvkbGntFm7vDJ4nqa_KK
 G6AHEafvL46Dd5ITMXEk7dnv46fcxk3RnAq5Pt586ucax_YhZFcA3QrvOfY9mGtCPtaKjzP5y6lt
 FT37CzaKdfLalJzUvv5HjLWP3vlnyKW3oTjtp_0f27N1R_aYk5AhypcBN6.fXxOMzMUygJbvI.26
 BLbdfwAy83NMr7Td.CKU4bYYKxY70cHne4SygMbc11z.wEGZJ2Yx3ViuvaJkEr5Yz_hUbDi9e6uo
 DaMlVvHSJPLxT1T.gWr3RshQqHv07us2WpTgEMZLTrKDtXYOWn0x_gHQvV4iGDEJ8SxFlmlgyL_D
 HeQViXdBMXBBSG67HA57zdK6sqoSJulL7uUMdHNHNZ6W5gPB6JwF06vOvkhZGwwjy1kMdlMPx83Q
 UNgSNMgNn4rIZCIVS3l81ty5LWiqmisQ5beCR8LsVPLB9ZB.IUkLb7CAs.roeaBGSLo0etKPEWgB
 Cnn7u2ps7rwa3O38BczRoXsDiIQYpQWTvgj95E6TAzpt_wl1ZVIhL1Yt55SugFiVzI2NAFb9tHMo
 JO3MwmexHrBTeOwvGt4JB20BCj8LHqJjwydC.CyAMqjbl4ARiuRuIZi88LjSK8CJb94uXZFu1NJO
 QbOrCyJ58Awun9x.2AfNH_iogaYBiQMrOWZQ6aoDg_vClptVj3Y_qBJG.TnFQltG0bXx9B2x1PrU
 fTUzYAVZZHmgZlavIxBUTQjLocXsDWFIuLiV5PBBngWeIxIeLgmZMw1jnUzxzO1E1v4US6PeSBAF
 KxU_QSHBco.vf_tFOqrBxpk86Tx3KI0x1aczIwp7C9UIMvwKHUzAWYxFJtiPUvZ0Q4f3kbtF_FvE
 xskTQbdCKXvjbLSdTEX30Co6mjqF_a0y5eOZC.7wOgi0XmdxxE.VmS4vYvlHlucKdM6zHnqZ7DKP
 8UrFde8vXaANvauS5v4IXup.qO0W8ccQOX8FrtUSC0PE5FN89MRIFDjy3jDgfGQjDaG0ync1jGF8
 ZGQhVWMOmqkN92VfGppImsUmo20KiW_fYX98j7KG7YMdvif.f6R4sOx.jK8XSyOo2v2x7Qa0Bf3b
 9N4rC57dC4HFhsBycegBsoNskHd12mk3Q6tzhxYoAtRiq1BtTuGgTqly6AgH6hhKyDBv.AI1tc51
 PH9PqEdSlSdfT.XJzSQZaidxB6NoqiVCPNrVWb577oOxPr_ntuallSxPTXdb2SmQYULjqoBhSzxk
 DGL1OInQrPmbAL9kBVffHxnfnF2pblc4G5DpFJwR7reuhd1hDicWDSIMczDSWgLEhG0IqSeFHZ4.
 eMyOz1qRbISNl4v8yRBodaIVfB_AYWBeX3ueu0a9RVqdlz3UO1qcLSfPM8uyat8GE4gZjWrJzgf_
 MiYu6ZW0K72U8Dz2OtjVLw3molrUpG1xtBuF04suo8gNQmF6xeIZN0Y9XvGeNbXGV04HBA0KJa.T
 TOy3zYwbKZS5GhdDPVkCuxGjRiSYJ9EDvYkxEmGLUETJP6MzC8uXvW58XWvcoQ_m8Iy3RyvIWLQD
 fY3IruPaFEW5pXBPRHx0pIGklm_Qhep2SebV0k26yJ_lA2rXJMy_eiZYsLBrBmi_zk_.26a5DklF
 v_uRDZ8HsAvPhY3OzUF1bAH3x54Szco5R1dsMUCFVEB7bX3DEPYW3F5zaM5tAbgAUp.TPFcOPASz
 qxGOfmWg7jk4nZiNd9j1SxpQHrZMPTfP8KLcaGdMi7tlrLKKK9__8lz_h0MqVGu6JV6hF26HYvGg
 GGlovJEQtpMzh14qHK9n7fbjoBeI-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 3dd3a67d-d5a0-419b-b78b-54829d6b4829
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 13 Jan 2026 16:39:03 +0000
Received: by hermes--production-ir2-6fcf857f6f-9ndng (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ae45f0023da4d2f517b44dd167b3090b;
          Tue, 13 Jan 2026 16:37:00 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v5 10/11] net: sit: convert ipip6_tunnel_xmit to use a noref dst
Date: Tue, 13 Jan 2026 17:36:13 +0100
Message-ID: <20260113163614.6212-2-mmietus97@yahoo.com>
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

ipip6_tunnel_xmit unnecessarily references the dst_entry from the
dst_cache when interacting with the cache.

Reduce this overhead by avoiding the redundant refcount increments.

This change is safe since ipv4 supports noref xmit under RCU which is
already the case for ipip6_tunnel_xmit.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 net/ipv6/sit.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index a0d699082747..e9183e502242 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -933,14 +933,14 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
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
@@ -951,13 +951,11 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
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
 
@@ -966,7 +964,6 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 
 		if (mtu < IPV4_MIN_MTU) {
 			DEV_STATS_INC(dev, collisions);
-			ip_rt_put(rt);
 			goto tx_error;
 		}
 
@@ -980,7 +977,6 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 
 		if (skb->len > mtu && !skb_is_gso(skb)) {
 			icmpv6_ndo_send(skb, ICMPV6_PKT_TOOBIG, 0, mtu);
-			ip_rt_put(rt);
 			goto tx_error;
 		}
 	}
@@ -1003,7 +999,6 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 	    (skb_cloned(skb) && !skb_clone_writable(skb, 0))) {
 		struct sk_buff *new_skb = skb_realloc_headroom(skb, max_headroom);
 		if (!new_skb) {
-			ip_rt_put(rt);
 			DEV_STATS_INC(dev, tx_dropped);
 			kfree_skb(skb);
 			return NETDEV_TX_OK;
@@ -1019,16 +1014,13 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 		ttl = iph6->hop_limit;
 	tos = INET_ECN_encapsulate(tos, ipv6_get_dsfield(iph6));
 
-	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0) {
-		ip_rt_put(rt);
+	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0)
 		goto tx_error;
-	}
 
 	skb_set_inner_ipproto(skb, IPPROTO_IPV6);
 
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
-	ip_rt_put(rt);
 	return NETDEV_TX_OK;
 
 tx_error_icmp:
-- 
2.51.0


