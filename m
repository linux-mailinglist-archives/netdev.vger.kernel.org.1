Return-Path: <netdev+bounces-249526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA324D1A7A6
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 17:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8303C30084C4
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFB634E745;
	Tue, 13 Jan 2026 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZWDZ2L7d"
X-Original-To: netdev@vger.kernel.org
Received: from sonic303-48.consmr.mail.ne1.yahoo.com (sonic303-48.consmr.mail.ne1.yahoo.com [66.163.188.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08EF34DCFD
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323264; cv=none; b=T+r61qnYhNrYjNGcUpNjxZWkdYSBSKpLRXPmXSQ3IjdP568fsgncaGqMJ31OTUDh0xQbor8/UZqDwk2cWKGEcEUruPTRwt3PuTNupV5t6UR7S/cwOUoORbUKnEsV3+wJEbWHHSRwEP2pYs3Mw9oISmZtsco340SmynFTIcq02mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323264; c=relaxed/simple;
	bh=NzYkJPriGm4ZhauSkqsRYS8/B1aLGsP/rICiFhBOc0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLbsCbveZqyQ72mkkT7tOvtUnA9Ccqrs0yoLH7fJDmT+0keksXgo+QMhEF2Y+cEPrw5CMIkeT8dZanb3jHbugasc1UfQA0aOrg5XaGdrbEjl5Kl+3CA8fyPsEE/iH6IyzUJLhic9qiku1rxTPRDOht2ZEcKFw60xy/M8huu+4QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ZWDZ2L7d; arc=none smtp.client-ip=66.163.188.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768323263; bh=889QYnhqf+RsZx7NYfE0t8NONf9HYNseVXmPrwfUvJg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ZWDZ2L7d1zhP7DwU3zreqGjB7RN2T4cwVRlVFbCpkdOlZpGmV5obfM2WbA+LZEsMENh6d2dXcMTHw4KFhAI8+obB+7BnkiuOiW77YoIwOlFYosvf0JzjhiRkC1YrQ8t0fjeuREIrHZG4OjADps3N/QPj4Lw+2DU7669ir+vA2ckPlq01V4JtvT7NFga6yEVROFzn6G7zLKlE/pcKJXXVgXOW+8Pwgb0aqdlDzIPd6CKyBrXfuHfne1/I6SuGyyrcYWRka43hMdaFPtKnimmNinNUvF4XT6B5DAMjynNBVKUzaAvziqhdVTcvnktyb2gRpFWHBcjT4LGMyZMYMhzOEg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768323263; bh=A+G6W2baCO6ENsDT0zMlOSVI3G8n9vAcHfz1ykdG8et=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=VQoYwgrJ9dhdEoxri6iWrJgIVM/PpN8zzWE7yQ8roTu4mavW7yFE4S3a4UICg1Asd1XXD09BEEVp3G4ih9byupGrU89Lq/5MCk6kpZUo6CJh3OyPKbuLtTsY8Vq8hZtCZN0wDcRvcjfNe08R9qkKhJAnGY95mugZz2KqBNGY0iK3A0F1aGfGU8R+kc0+CE+5xhPA2pQQpHahHs4W+GUWXgZEZd5kJY0s+VNVpRXNal6yxsBQOIutnAajLK3TOTN8CeEhlqYGCMi1SswDC/dsYolHC78P0BCIpFpKS7eb9Dpp3Gql349oZc/tcwnXQchyFUQczyDv++EzQ9DKhJoL6A==
X-YMail-OSG: 8NF.PowVM1kcGhGoNG__0nGwOEhzgS_3uQfarJu4HUHLTRNUnZCDnz9u2teRp2H
 iNjHmxriTnK.O5T1jmntcqDpwwbzJzzLBZfvr2tuvrIPv77X3ORNspklaK6arcbCcti2TIPTvwxD
 y_PVNqTAMwRIT_mrhtDd9jSuYMEPclTRGB_301V883e_KfRgMlRuNQ.x8jY_o4.ZTBlYohB_qzmi
 YR0sk0NU3i1yYd05TTYvGiUUAamTbTxlBSb7Bzc3Xq7Oz8TuqO7x1tRrBHcmEu_47psWkW82vFzH
 5GXiOAX2yfns3eM_Crfqfy3yxnaXEjrM.aUCga_xD8SXUlSGZLg1vOU639kBP7eqLgVFeb68eBz9
 O3BV7Scvpn_G7nSuoSPthYmfGS.bd.wX9bNNG.3t5waHRph3Nmz2wmmW.wiSyrQBJOJOEeCB5rmp
 zD1AlyM4mpyDIFrw71gCw4WQpmleKyCkfoRdoqPTMnP73NnqHXWnx_SntO48262RXTawudwi6Ihr
 .oZbDYJqp5iIZrEHUaGJtB2CaZwo36cj.1g4Owh.vJLXInbfg5enAktPyZ2nzNQt3_c.AUOvUjr.
 mUqPxanq8J5C.j1MSb9QP_q1AMBb8RjIlVzO6X4FG.dWLaQRz1PPVcILuxYBEYfI2wtkpkjy1Rog
 jOuZOnxrx_rhrAodZ4qWF0g2cREG8t1cReSpUGryirdwjESeF4LdiInUvcA_6C.jQjzKxoMVeOwV
 kAZztiFal7qK2WXpmEc0VDqWQPn8ln.GxzxtJGF7jTBH3vl4FdIuxusBqLNqCTCqI8an0SjB8QFp
 K7j2GUIkGiQ4Ae_udGLNRxQ86CapaU_AOSEjmd6krTPJqLqT6PbgwGVPAhzuepnuSD5QCkAFFNLQ
 LLS1b8asQPiMLeYsZjXOZPCICKct23.peNyc9ZeBAtGX7wKL0OEEJFc5EuXR4O.DTPuWhUhlTEuL
 _cWSyCdzDBGuQpS2dt_5kboT.ID5SxBhDr1lCsvAfbBK.8WUINDwFFYaIoLJUjWxcdP7QGBEZNrL
 2fNDY75M_G273SfmugcZn7WhxZFpAamvQwI7.g1R4GwPKXrmPM7SH4ngO8SokirSW._Qra5TAa9M
 FBMjLfdznAVCrZRVzMuGEFVhkrJFF1NaBfFLSWPRdUNCRjxVN2hF_wCzXACIvSxPnoW9Gj2wSHgx
 d7klpQvbsxjvqHyIXo9_ACZFWKbh0vPnwq2K3U4KyJhu_CftNy5CXih7QbO.r57zSMxCB7MGWVW2
 exd9V2d4DVh4YB5QZ7ocL2mKdtlhXI5RAIm_L8yRTxrMLOCEvuUTdraEw9QNJ3zjneOBaoaXSOt2
 m7SGGQkW6FBYQXusCuXcdXN61OrfvM1aPMK4KodA8nNvg2Bkr.2iRTWLz1vVCHMzbMop.AwJPu2E
 MIfPk7Q6po6cqPBVSIfpOkIO_sXwETNstO6S0.jM.DD9omduMqwZzHRysbwzXJSl8vWxdVJdm6PU
 Vc1VA2rffY4YPR1K_UCeK6kGFIbOQI7KC9n2feU1v3xgh0.mKOhbnPPIxDDdqgSWD0NSvg2uUdS5
 x27NFRdGDjBC0Lkw1O0HVk.SwJ4C1IPUUZQn.FUkb0nTXogvEs_wOr_GmZ5sRIhugkhWLUvRJCCr
 CWVAQAMTzll_sBB_EgkWTyrspyby09Y6IiQe3EGZlpBZ8WjXfT1OMiEVcjoKiUblroLht2nH5ylP
 XukdGytbPFmPmLFtspqP0L02d9R_FeH6CKTB6eOjTZM82LXXxBMGIot6ChPPcT6S3GIRAJkOu8tk
 N20Ah95WmZpMoRU7c3h55Jb0.3fXJqr070WWD4bPQNyA7xZ0m5ia0xFiNMWrjLsj_G5cX5PsmuXq
 4y3yudwSVXif5UC7z6oBbGTkL20UYenRC1gSlEFZv7WZpAiCzNBIwAx64rRDwxlVBb9wkC2FIOP3
 ZaJqZGDsAWnpZ7b9upicK5ZzyL48nRlond327dbwyqwhGsb8RYddWTtVOvh0NAzcoD9zD2EA6THS
 0AxQYY2GMDofkkUOBvEmbg5.PemKDJMtRo3axBh_iLkOuT68fV5hSXzYFk6b1Fo17xn.YYDYm9VL
 B0RxLtI75.FFwUxYknCAVHDC7mM0me73CfycccLJU.bkCyko90lSjSD1Qrlfe90laFUqvODdBsB2
 WYZOoCtgF90q14jJq5lzGuiJkHjCjrxgaYlF_lGMHY_PHXmeqn72dNSYNAuCFCHI37VxoHvKpe5i
 QltVkgUVuVDq854Tp7Wam
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: ad9cbb14-2429-40b4-8b0c-fd4b6d27f1bd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Tue, 13 Jan 2026 16:54:23 +0000
Received: by hermes--production-ir2-6fcf857f6f-7nlzs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 11e96f127f9288c2e2174b22f2ee0351;
          Tue, 13 Jan 2026 16:32:06 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v5 07/11] net: tunnel: convert ip_md_tunnel_xmit to use a noref dst when possible
Date: Tue, 13 Jan 2026 17:29:50 +0100
Message-ID: <20260113162954.5948-8-mmietus97@yahoo.com>
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

ip_md_tunnel_xmit unnecessarily references the dst_entry from the
dst_cache when interacting with the cache.

Reduce this overhead by avoiding the redundant refcount increments.

This is only possible in flows where the cache is used. Otherwise, we
fall-back to a referenced dst.

This change is safe since ipv4 supports noref xmit under RCU which is
already the case for ip_md_tunnel_xmit.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 net/ipv4/ip_tunnel.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 8a0c611ab1bf..ab10759dd2e4 100644
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
 	}
 	if (rt->dst.dev == dev) {
-		ip_rt_put(rt);
+		if (!use_cache)
+			ip_rt_put(rt);
 		DEV_STATS_INC(dev, collisions);
 		goto tx_error;
 	}
@@ -630,7 +631,8 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		df = htons(IP_DF);
 	if (tnl_update_pmtu(dev, skb, rt, df, inner_iph, tunnel_hlen,
 			    key->u.ipv4.dst, true)) {
-		ip_rt_put(rt);
+		if (!use_cache)
+			ip_rt_put(rt);
 		goto tx_error;
 	}
 
@@ -647,7 +649,8 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	headroom += LL_RESERVED_SPACE(rt->dst.dev) + rt->dst.header_len;
 	if (skb_cow_head(skb, headroom)) {
-		ip_rt_put(rt);
+		if (!use_cache)
+			ip_rt_put(rt);
 		goto tx_dropped;
 	}
 
@@ -655,7 +658,8 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, proto, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
-	ip_rt_put(rt);
+	if (!use_cache)
+		ip_rt_put(rt);
 	return;
 tx_error:
 	DEV_STATS_INC(dev, tx_errors);
-- 
2.51.0


