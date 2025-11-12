Return-Path: <netdev+bounces-237860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAE8C50F77
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 08:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F443A68D4
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 07:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648D42D97BB;
	Wed, 12 Nov 2025 07:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Pts68ZZN"
X-Original-To: netdev@vger.kernel.org
Received: from sonic313-37.consmr.mail.ne1.yahoo.com (sonic313-37.consmr.mail.ne1.yahoo.com [66.163.185.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AFD2D9797
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 07:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762932958; cv=none; b=cmQBLRGTKEkjSaJsav1y7uzHVnjmdwHw5QFuyhAIf1PCGzoNOlX3TUff44eFk5+wwUw4m1LW4/yj32kETVuAlaudPaUA2Huzjx+O54qgrnP4L2fG6dvtJMO2isqCXnfaHGNIzOC+BnZRByUQoqjGptxu+ncod9WzwaSafYmU5SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762932958; c=relaxed/simple;
	bh=OyU7iNrKx66tOSbtWr9f5sbmRQ8+Kw4kZvZJKKMruR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oxh+KlsRkSwlQJF/7ucXZgu1lQ0FNTvd7CpfP1PQB3soQyA1ATRUs3XiyrzOZWazCfLdqm08g+0W1brpbkTfNRkFl3dSqlYhaQi1xVHKgTZYGQoRYTOwNNWq2xtHs7rmqMd7mMzsUcloEL6WgocGgwmd02Q7rSWB8xtanZKPTtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Pts68ZZN; arc=none smtp.client-ip=66.163.185.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762932955; bh=CH0G10o9ovK4ErRUQI3fyw6Jpp8tKHNbeB7uxEnNREk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Pts68ZZNDz/C2ngjRB8G4u09AQs54fXtJMKQrnEYwbMR83x0s200tZff8oRQZzc+FUr1udeFhCeFxSLuW9gImeZPdYcflVTjxnAVRqMn2pbdsGCcwSXZB8gXcW/4HNGMuvRFTwD+KxJuoh8s26G+I6lo1FjqLdo/nEwg5Pcu/0j7Ej7c9lnLdgfiY5palh9CVHM221lWxZsuHwpRDPqOOSYgFqmbg0viKpmo29m/UJ5lVwC0rauXPAcoLCuoLvMQX/lTFRDwv/GbCC5wrwClVoVvXEMvpyZivMn1xTq5SG3m2+Um9esUFwJjDEuTY1E24fcRTc8H/7nax7G8XiMsxg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762932955; bh=owevqugNSvm/dXvu43EsRAEe2S9zwXcWRpEnXZffAJA=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ZMSORxfKzq3JcHBH39tqE2kz+G5rMM9DdJtjOGld85niZGeSyNGKBsB4kCEkRpPyjSqZN7KHMMKAEJQXSHrm6t+zKGakwO3Vml+1VKRGGv4u9Vecx3IfeQaGUWuxDnO2NMKEMo19k47Yk8p963AMHJ9tUKhKFAnEf4JBL5WuOmoOahGYe7KFan9yAw/dxq/2z1g61GM6dAE0l8e2y7GDrWiLLS5dNA/6IJjxJBJgR5WYOzSvaY3jJGj90i0stPo8y/pZ3fy3zzcvUOo3XD1qk9fedji9GZRWEzPzmmdaqIppzGcXtIsE+/2/TPc/gAj9L6ZXLytJHpqkDUMJ2puX4Q==
X-YMail-OSG: zN6d2HAVM1m9hflmCMiXD2TsqqkaW7Fop.SMyMFbHfwRbkMeMoqgspsST2hPkY9
 8ueCBzPNpq8Of7DLT1EPj0dtsbUO9QijbvzKCVU_bUW6mkNQU1OmkAcmKFIuyIaT55DVmFb21GrP
 RQ0tAlgth7.Bl_S4yJozqRY6sPAVRnd2JjfQcnJaZNAlulkEpp4WMZ8pYrgwR5yCKe4BCbizoq3h
 4UZMYiShpfLvjcUA8tjv7QEL3ufqQ9x8UmYAuYcQmHGami_3XMw43aemVrz3AYGTHWP429cczRso
 sXYIXqutVtBLnA3YgaAUbTZvZq9LEBxq5TWU0BaBoWeRBT4l5Ubr55AVSIVKEZhb.eCgg5nTogA0
 Vzc4KipUz2ulKMIAS_fzHb_LJxWeENJ3BWydIr3KRtmcwpHIox.YlLQxFdVidjVxkyEvDQ0ujjdJ
 3__4aM2fFvD_ytoM3zk_5TkAYsxR2RoOUqwDgjaWEPRewlD05gDD9A6IgMRiFIi4TA.hlGvvri8i
 GXtsreH1hkTBeqpHAkWXLkQV4dCZ.JFTrh5fVqRrmf5pwpATAw6Voikd0orDvdKohXoGVYT9k4sz
 EuJhw07uglwi3oIpBry76n_WurGPYwqdXZOSt9CINoIntMBtICt5zJ1Pg30iGnJKd1E9EHOOcUHc
 WWaWYTuNwJ.3gdrqahnNxtAv7cSAzYOu_xbKGWBXXXLn7B4vASzpECzwpE6SqnO4ArMFAwVpjTi1
 _9ZR.pSXaXVFsQDDDVOLhEoE97oASaVVEo_4_eyoFQwTH8I2uSytiSARxi6cuQyvW_Dt8kn_aaYD
 eedSy9ZDROno0Zp3ZyeY4avzo4WmIckEmgE2sVJhK87Ha1TZ7dAEGG06iYFd3ZnmNizIjpR.k3Il
 SjKvEOyyFfzyia.JbAQjLBozPi4ZTT.zwJhiL90psgwGPokhcYGxV7Qjpivx0..KY2.kEJgQ_JN.
 A89odhAJYWwpLIu_vfRzigDR_qrlS74CWFOS53_l6vfUz.sy.FD97A0m8WxAqOW0O5P5gAcsjdub
 Z.6vDv7j5F4s1ZZK0_cWABI.w0c2MkVClYqCLZt544pu1OpaoEMRCn7ZCLnb0Oz6XdoikYEdmqTI
 5XX_R_OPq0xNjln6A3PJOQ_.dybS3CA2MC9QaE30GrwkwPsEWxFdLtdniLgI5IALenzkfzRvyb54
 cfLxZxp2GnaVwcshyhqnCkCJ3_TcPyLvD7RI_dRHgIIzCW_QGVcDKaccLUQzudFohdcxqQYDbHk2
 7hlDu4FW5i2V7Z7iQSn4a_ZSwNKYLWI25kLL_D5x3dKy9irBRnKtKIWCj4qEVMJ5pV3Rmh1yVKE4
 cULWB.6JI7xINCvcDE6Y93oM9Sm0Vc4tDhTUewV_nSBmM4vq8.QkT_YZ.Us6zjHoNk_dtgemgfYu
 bzYaN0JC9JZ5jkJTxRm3Cgsy_oFpZ0S_8iZqZlq.M1A8u5mC9Eq7fzF_Yx9ED415wuHhoZkVqkqI
 axIASGzMRipWgvY4VfNFKPG2QBY21ieLmX2Q4YaYEcuCl_fijHC0z.b.UQPLEWhv8ie4BtGy4wva
 X2azNo89uW86HvwL4v8wQu6INs1qggT9Bc0tLIHISstSjQWidlriLojRdcvZ1FIAUVnsC3wt_1o8
 hxQkHWH7CoKiJaTkgNoDEKP94obmWe7O.5efE1fG4txGyRlWesnhE1l7vfrLLgBwhx6EIKD6Yhze
 FlI2DrbghvruSv8mz6OJnSI3AQ1ztPjL_q9LhFIPxDufmBZtQ4DWp_UbjWLdSoX3wbfygJQwVScZ
 Va3RjSRkuzKQFd4srgZRRWdD9_86Y7iY7wM9kq2mjBWAo2Fni54lNJdIPfWvjgAmxTAHIniwjDtR
 DrzutDO4sJrgbhZHQakj5A0ZlsokIvmgqyRcnDGN4o3AQnP9BuaShPm4da9BMXvjY9qDpLqNx5i6
 TmTFSMCROhaU05uBBTCdXkedolRWn1fkylQiS43R.gAkMT5ya0bV9stHcxntXYjrArkrzRnhlM9.
 tNJN35xspHwXc799NWE2m9XnKx6W1HQfX941yxntWhUy2Yvb2ddDRjZh37QW70lmkReL2E2puM9Y
 8b1LiFEu4vav5bzZH83LStgba4wtSWTmMgPwFz476DXRCh5u0itX6gdiDRK03eRX8.qdrzA74wNB
 _VmBbGHJ.0sOTAPaAekBes2RPr1xGIqz4gx01Jvdg8FcS8bvxoM6ofPENVuxT0nzj6SdJa8tZiA6
 rS_MsJ4rMqkw-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: f3893782-864e-449d-8175-4b2b5ba3e303
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 12 Nov 2025 07:35:55 +0000
Received: by hermes--production-ir2-5fcfdd8d7f-gtwf2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8a3972250952fefb5c72bc783ca56e47;
          Wed, 12 Nov 2025 07:33:53 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v4 10/14] net: tunnel: convert ip_md_tunnel_xmit to use a noref dst when possible
Date: Wed, 12 Nov 2025 08:33:20 +0100
Message-ID: <20251112073324.5301-1-mmietus97@yahoo.com>
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

ip_md_tunnel_xmit unnecessarily references the dst_entry from the
dst_cache when interacting with the cache.

Reduce this overhead by avoiding the redundant refcount increments.

This is only possible in flows where the cache is used. Otherwise, we
fall-back to a referenced dst.

This change is safe since ipv4 supports noref xmit under RCU which is
already the case for ip_md_tunnel_xmit.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 net/ipv4/ip_tunnel.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 6aa045793048..323d085cc377 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -578,6 +578,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	const struct iphdr *inner_iph;
 	struct rtable *rt = NULL;
 	struct flowi4 fl4;
+	dstref_t dstref;
 	__be16 df = 0;
 	u8 tos, ttl;
 	bool use_cache;
@@ -608,20 +609,26 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		goto tx_error;
 
 	use_cache = ip_tunnel_dst_cache_usable(skb, tun_info);
-	if (use_cache)
-		rt = dst_cache_get_ip4(&tun_info->dst_cache, &fl4.saddr);
+	if (use_cache) {
+		rt = dst_cache_get_ip4_rcu(&tun_info->dst_cache, &fl4.saddr);
+		dstref = dst_to_dstref_noref(&rt->dst);
+	}
 	if (!rt) {
 		rt = ip_route_output_key(tunnel->net, &fl4);
 		if (IS_ERR(rt)) {
 			DEV_STATS_INC(dev, tx_carrier_errors);
 			goto tx_error;
 		}
-		if (use_cache)
-			dst_cache_set_ip4(&tun_info->dst_cache, &rt->dst,
-					  fl4.saddr);
+		if (use_cache) {
+			dst_cache_steal_ip4(&tun_info->dst_cache, &rt->dst,
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
@@ -630,7 +637,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		df = htons(IP_DF);
 	if (tnl_update_pmtu(dev, skb, rt, df, inner_iph, tunnel_hlen,
 			    key->u.ipv4.dst, true)) {
-		ip_rt_put(rt);
+		dstref_drop(dstref);
 		goto tx_error;
 	}
 
@@ -647,13 +654,13 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	headroom += LL_RESERVED_SPACE(rt->dst.dev) + rt->dst.header_len;
 	if (skb_cow_head(skb, headroom)) {
-		ip_rt_put(rt);
+		dstref_drop(dstref);
 		goto tx_dropped;
 	}
 
 	ip_tunnel_adj_headroom(dev, headroom);
 
-	iptunnel_xmit(NULL, dst_to_dstref(&rt->dst), skb, fl4.saddr, fl4.daddr, proto, tos, ttl,
+	iptunnel_xmit(NULL, dstref, skb, fl4.saddr, fl4.daddr, proto, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
 	return;
 tx_error:
-- 
2.51.0


