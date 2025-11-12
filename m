Return-Path: <netdev+bounces-237861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C957C50F6E
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 08:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DB844EB5D0
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 07:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BF72DC32B;
	Wed, 12 Nov 2025 07:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="dGZcRbdZ"
X-Original-To: netdev@vger.kernel.org
Received: from sonic313-37.consmr.mail.ne1.yahoo.com (sonic313-37.consmr.mail.ne1.yahoo.com [66.163.185.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93012DAFB5
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 07:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762932961; cv=none; b=cBYy4OVSZHBVL+IOQ/LykFaZOEuMySWT0PxiWHO3LFVQOJsSYki0QoW7ibjQYl9ZN0jhdAEcorM9kM56fc5ahGDAKLnY9mqESsUwzlWWHr4ZaFKOhtRAFhSuud5NqsGFf7bz12sViY82poDnlP+pU7u3yKcEIvj/Hc32R3KHZps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762932961; c=relaxed/simple;
	bh=xKSPWvxG63rilafRXyU9Fop6vCm4NZIH4QOA0l24T0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WapYL8LBz75NyYJd91NBS2vkyxfnkc30nGeYopxn4hQ4J9CkdImhQz94RJ5NfbttjQwhsxjqRtBmrbzLKhB4bWavj+c70so+sDJuXme1LzpC54MFFVHJMNHwR6QZ+mf/NYJMCFxJKJZRKsvbR8ci3gRdtpkHRacHjGAsO/FKecI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=dGZcRbdZ; arc=none smtp.client-ip=66.163.185.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762932959; bh=UB9vqI2QENZ2Dc+ZfRRQEi4CjWvycYHYP4fqQNT9vKc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=dGZcRbdZoI7y90mInF1SgkHr28Z1C4ZZMfb/I04yqY4nvNqH0o9/pvM2gu8+jmod/1sDSq5+Rn8GKWOmaaWQilJJtiJIyYkJMLVwE0T91/vkkyMeu3wJd5MYpQ4FRqbcdGCBsI5iIxaPSEcvx1xzXfrqzZpfwy/PSzyIgvs3gEZlBmDa6WpzbA0EsVNE+WQlRYnXJMWU5t2MYxu1JY0iBDgIas5yRk9gFGk3AXXC6to0M+1TbbEwqZCzvPKdj+2s+blmEy1CkuVgx9GapD+6r8JjX8un2YuJ22+5cSoaoqr/IH5qmjEFz1sTmSlY2SjTu54eHs2aRo57d2uJWxaUPg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762932959; bh=ppLYZcpv2hhaKVLYQbib1wwZMjWxa8DZDQajeDLU3rC=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=EYjU1ZTJL90HI4tcAX7NSVaqkyKaICHq5QqTri36ORdEfd42fnzJK6b5O8pXOU12gvTYM4F6Qq1H2LLX1j2Q1BIDFl5FONF9ca3I21rcwqS0hgYrpbE0yD/+U/bSI3rlb+TxJ3Yoy4Mp6XBlVDUizOzb6f7Srw3QsRRtbIEu4Dlx1ynfJhkspoE6VzuqhVlT74d4BLlJxlYTreInJQrEJJeOILGOQcQB+zwj22Ah64OHDaOtKW8/m78mP55JfQAInWDcBVVs2w2ueGPMAe+DaU9tF3WoQ+GzXC6/jdvsx7aa5xby4yE7shdagPubZzc72DRypj3F9YfY9SAOcfBLDA==
X-YMail-OSG: vPB0LAMVM1kDsC5rB3uym3a6VJqrm2RmFqCGvQkNy2Zh70F2xBumr02OLRaooen
 sx14Bt3QA9UxPnQoI8BAJeoOv.2gAkkwzFU4eAumnEnvWW6iWT45s975q7qvNZUl.ku2in.VRB2h
 mjv52EEs4VcQu_m3MnS75_X0jWgPD0zl8kBV0eSNm_3GqvqU4cihjfJ3lPWKdY8DPQEYmMLCfLcr
 f9CXBbWGOIs_TbvkpAITFn2CXc1eexw5W1gnhtGHD_ODhhUedrhOVlF9M.IBVz6GRZeL1waIe4FK
 k7umi15lxBoxTtHassEBDgAz.YBwBCnCdPkyjqd_B5OsYlgwhArrqQVgvy3IL2EnxQc68aGA9M2O
 IAUfO.MkzH2fcC9SPfjqcFNGjM0MoUbjJB1wvb5EGTvBAkU4UVa_Wzwf0wiCWt3fCpet5_ZqDwbK
 _o1kycVCTGvYJUy5L7qEAiFVAeOOOSzu9LPI594HbkXBBdumq0_Pi_weIWT2X0wkeQn0t8eQhmOe
 ur.1VROaU7d2QNPzFA.aGx627m6P21g_Oa3yu_6rBoSOKFx9OL3rp6qBnIk30IGopeZpN7FsCefM
 v9nEHelRAAVcnmsHcKNWBpJunQjjbi0lkdHBpV2SAW9pE4LwsFxlj7igPZyLWnjiiQr1O6JM7LGp
 scYJy6DF38prDP47Dh3PKWwS4CngN6kkp0lmgB1DExJvsGzSSbKFvZtcS8sH148_6uh7J0J4fOrX
 KJ7Gw2n1Nyk6UBNc4CLuWxegtuDmfNkj5qZNY3amXeWe.BHfOYRTfAOGmdL1rH9meOe2ZZeiKdiE
 nXiebvjjaobLw3AlJJH8RiwzHNwXS8bHeXbJ_uC_2O3LQsAsZr4raAi.wy7Kl1K7boe3VStQsw1M
 5xY7xWUYdv5Sw5M.zDiB16PfspMAX.aKl2dMQ8LV5BrhXNJIVMvfDl5cAjYYPGV5nQghc5cw66r0
 RSKLY7AETmcdJ3JMKJ3bf31OUPZ5lfAS5JrMgC42c.u.C9CeT_XbHxC3I16p7LtS3umesNYbDpfq
 uGkt7PawD3uTJQTURL53c20LVPM6qJ3s9XA6JPTgM_BzDd3C0CEnpfEsZ5a32GuR1hx7WIhItFyN
 iirBVYhrtCJNtWysnAkUnRxxWwJb2ki14MZuvbl.39tp9N0hUBp9L3YkliIsEGBCH7VLE_eu5RXE
 24eSXzjRMtCOrw9L0KntngjSQiWF03UZ7zmhBWL_tDxutZIzHndlUXFoUa5t.rZVWtiOcBo3S2LE
 D98NvpPGCF14XjPVM0iLlJ_W8YcRRGleprwrgYp9HTs4WMGXMRdEQxBJtM8rvHmfofQPUEa4bar3
 lfXs0Z_nvYUEsS8U_PNEpPBOD2OQvs9CZlxl3cTSZ7fUIrnJd6GgtOMM.Z2QpLLaskB8vNznz9av
 EAHnn1WTECi.qBqqe_hauZHk5X9k9QxtkiuvbGncdBwOgGFeQsQdp0hGcKt7npdHrray5plXWGPq
 f9m3EvDGtfSRFBg9nanpqr6NsLJVn0gQDwOCRlbCF3CDPVrnhbAEvqsh5YDqt4rsDYogIxh9WgWc
 Z5ZYS61n9OWOy.0UB88VH3hHSc1jnlLKA_zGXxB_1WU3e.bmoqkRh4wnnuDwvQ60RgozyG2i4WHg
 DVoNKarLCNXTtzayiDOMNgdZMxWSeaG5AqHubj0a9UWHa4wTvQU6YCVyunUSVTN8Vjh3jzAgb4cd
 g0TTGEgKTk1o8Z_L4de4BUBi26gG5MTOixUn7JJKHkI2PdjpRN1Lsw_58Kui.CFAbJxE0LsVxp4J
 IT7YviSUrmFokRNuXtYM1KnhgHV2Gk0JWuCC9YCPNKRxpDE0RYOxEZ_mL2clrFqkBxoKZfbkCfSk
 TSmRiXbkbdqSjw_98CgLwge17tFnTruXlfqX9PwE32hRcbzSu3vDKAAYLIUtc.HEZvJi8Qm1tOS7
 CWhfj7MrkUXNND7CIQ0NHZxPc67wHxQMs7BRZXaf9RbifaTwp8OJoYZL.ZrUcBrqPOboSgzWZi5M
 FbrHZQ2WGXmDhZ9_Q2GuLXsCLbV97b4b1pfkJ1D9Hz6j6re24QxB99mo6eal_zl6Cznka_TEQtd3
 AfdRJLAp1wj.9FWUQwe0HFu8TZPYNivNDEaZt8e5fH4TEp9Sz0Bat16zrrIZ4hlXDlV30MJVq4zE
 fIxBbrWoLQPN9qfdRhCUfBM4NnE7ta6GIQQJ7vDGJjWG4OZb5IEH2pTvVHBPiVp4WSC6ko.qkBkT
 OsGj8KgpW7Jo-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: a59bedab-66ae-4b85-a5f2-6c9cd3dbd7df
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 12 Nov 2025 07:35:59 +0000
Received: by hermes--production-ir2-5fcfdd8d7f-gtwf2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8a3972250952fefb5c72bc783ca56e47;
          Wed, 12 Nov 2025 07:33:57 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v4 11/14] net: tunnel: convert ip_tunnel_xmit to use a noref dst when possible
Date: Wed, 12 Nov 2025 08:33:21 +0100
Message-ID: <20251112073324.5301-2-mmietus97@yahoo.com>
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

ip_tunnel_xmit unnecessarily references the dst_entry from the
dst_cache when interacting with the cache.

Reduce this overhead by avoiding the redundant refcount increments.

This is only possible in flows where the cache is used. Otherwise, we
fall-back to a referenced dst.

This change is safe since ipv4 supports noref xmit under RCU which is
already the case for ip_tunnel_xmit.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 net/ipv4/ip_tunnel.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 323d085cc377..65f4e1cda69d 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -685,6 +685,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	bool use_cache = false;
 	struct flowi4 fl4;
 	bool md = false;
+	dstref_t dstref;
 	bool connected;
 	u8 tos, ttl;
 	__be32 dst;
@@ -777,30 +778,37 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
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
 
-	if (!rt) {
+	if (rt) {
+		dstref = dst_to_dstref_noref(&rt->dst);
+	} else {
 		rt = ip_route_output_key(tunnel->net, &fl4);
 
 		if (IS_ERR(rt)) {
 			DEV_STATS_INC(dev, tx_carrier_errors);
 			goto tx_error;
 		}
-		if (use_cache)
-			dst_cache_set_ip4(&tun_info->dst_cache, &rt->dst,
-					  fl4.saddr);
-		else if (!md && connected)
-			dst_cache_set_ip4(&tunnel->dst_cache, &rt->dst,
-					  fl4.saddr);
+		if (use_cache) {
+			dst_cache_steal_ip4(&tun_info->dst_cache, &rt->dst,
+					    fl4.saddr);
+			dstref = dst_to_dstref_noref(&rt->dst);
+		} else if (!md && connected) {
+			dst_cache_steal_ip4(&tunnel->dst_cache, &rt->dst,
+					    fl4.saddr);
+			dstref = dst_to_dstref_noref(&rt->dst);
+		} else {
+			dstref = dst_to_dstref(&rt->dst);
+		}
 	}
 
 	if (rt->dst.dev == dev) {
-		ip_rt_put(rt);
+		dstref_drop(dstref);
 		DEV_STATS_INC(dev, collisions);
 		goto tx_error;
 	}
@@ -810,7 +818,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		df |= (inner_iph->frag_off & htons(IP_DF));
 
 	if (tnl_update_pmtu(dev, skb, rt, df, inner_iph, 0, 0, false)) {
-		ip_rt_put(rt);
+		dstref_drop(dstref);
 		goto tx_error;
 	}
 
@@ -841,7 +849,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 			+ rt->dst.header_len + ip_encap_hlen(&tunnel->encap);
 
 	if (skb_cow_head(skb, max_headroom)) {
-		ip_rt_put(rt);
+		dstref_drop(dstref);
 		DEV_STATS_INC(dev, tx_dropped);
 		kfree_skb(skb);
 		return;
@@ -849,7 +857,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	ip_tunnel_adj_headroom(dev, max_headroom);
 
-	iptunnel_xmit(NULL, dst_to_dstref(&rt->dst), skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
+	iptunnel_xmit(NULL, dstref, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
 	return;
 
-- 
2.51.0


