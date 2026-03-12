Return-Path: <netdev+bounces-267155-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM6SKRnmsmktQwAAu9opvQ
	(envelope-from <netdev+bounces-267155-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:13:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A4B27551A
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3648306D8CA
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E3B3F23CD;
	Thu, 12 Mar 2026 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="liTnbyzv"
X-Original-To: netdev@vger.kernel.org
Received: from sonic304-21.consmr.mail.ne1.yahoo.com (sonic304-21.consmr.mail.ne1.yahoo.com [66.163.191.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548503ED11B
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331824; cv=none; b=WlBOPxpryKmjCUFSa9D3RKBYRSPMwVbmMN6Y6GWG/2AVQKksbmvWsynGyHidS2Rp4OCaNXhuLzuIfehcHCWjnfty5WBPURtr9YcpD6ZyUz/4cPaCbUQ9pwQmWDMkX69TrbIYzbyPHPnC+5IkeoBcOzu531/8BULhJVj86VHv548=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331824; c=relaxed/simple;
	bh=AkXD26KzaY+OlgrHHTE7tsC10wBKp2pkv7aNgCGzIww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mixUxGhDF5pK8PrqiYchXfaeaJ8os2kz2+TKjBp68Vzx5p6/GX6veRE0GWkhMLF1uX/eIGKuhQYG+ygoFiGSLGA3/SdvddPBcl02+gF7z5F8/gW2cJmj8Vdx9eLdLywv8o/ZDskiqeHtNXcT/4LtTAwJQ34KLGEyayhB5n/Y0pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=liTnbyzv; arc=none smtp.client-ip=66.163.191.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773331822; bh=GYV4wHLRGxe+HR9la8QDKGfk1cL+xdRZxQXeXs54/iw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=liTnbyzvckmG/TtHZgc0xso6hyElHtr38A78apfNfO6udmTclpvkJ+acsn9uu7u6qTdtW4M48zj4R8YiuyqNAfuW/B8TlzNYd5nYsl/8fAgfWWvskNEUMwkMP6UCKvChuMbLAt2LDT2nboOp0gbLFH4W4FQsOWdYI6Fs1ogCD6PBuGvvXT177ZvVUWrlKopFq7nZQiThvfXo2O8nHGF88poSCo1V/32wQBmf+PmrXAqLIHWMgmIopt0D0uZpYB86giIz8TbaUGNSVfAQoV0DGQ8h/DAY1qGYG+GMoSOBqrDN2Kq8QT/5OB7dFZ3DzfoRybBqzsQjSIzCbSqw47Gmnw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773331822; bh=rEakYb0T09UyGkicvE0SN7ndq8mpFblVCa/qnyXoZ2+=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=s1S45o5LW1Ys/52/54We/XQ0LPuqMhJg3bDa+B9LQEb3GnqM0lyzVYWvDHkdcGDjjgjcSdUpiEA2G0EX4dqcTVgEA8rueYv3YWIitDFtWYl7Ob5iE8dTrx3JcO+F9hFOKPEQqA/sD6SMMM2VamrfmrAjZOrxXY1vhqp2S6TvcB5j2XxYexG0+yrvlN1WtuBRXXj7e/ELHC+WJ7moYXIPN2uHN7p6gRKfhOeWQ9jmYrV9dYkn1+Fkn+eiu0iMYadIe+fDm9AcY5c7TVjSfE0e4NgjFYUYe3XXs7eATaf4ZyAK++syQ0CGnI9hUGyxQNHajQBdAecqtwl7N0MBJQxznQ==
X-YMail-OSG: k9IoagYVM1nwMY6XBvS9LDz9p2vvaYttgudt3x7RUnTekolZqqyYxNbWBssIM25
 VlmShNGvfcg8S_Iwt7FRcqVbj1tCBk87pYza3lxEWeJVnSyvlCsgQFBVBZ5C4bdqJQijteUoXzlM
 aLHr7LBlbF6QhtMfrHJtrzsB0I.5bc5BwOZXn5y05wLaIZLoDV.J7cLsfU5pxwUca4AcUxGlHxh3
 ymVB9cPXsre6_E7v3TU4sMCgaP4RZ9z3ueoxYkbMK6led.FyfLtL0jBjvx2YeNNEMmQkedmjF8.4
 esLd35pSCpstpnBicj42RJQS2shAy.6NVnk7aEQU58923PmfeTn1Ui3pxDPhUWW.KKgWHkFgSu_5
 H4tiFwhimu1fH3YHTT_LVN1ATUDbD9g1.YwaM7VG.5vga89enxnL0beZBQqB03LNxwveg0tcvzKW
 6up_CTpy6Evu2yLL9UM4z1YJMCQfjejY6vGYWubUm7Kw4VMJdT3XKLEFacLlKaKcMn5nInDQsge_
 xYnYrLHztfQLPuTniLJ7fIE.YdXpS5m6jPvX5FMDhZI7ZNglDulqCAEWHfjed_5Op.4UZfE.Akbh
 sruq3z2Wn7SR0MSIqBoACzD3MqFj_j3m21ylf71otd3O2c3rhkHTz8Ym_SMrA.UoA3NkqG3.V6Dw
 m5a359AKJl3e6RDuelaF6ckA_vu1xgT9yYjVZVWcCSRWKGrYS8AGRxX8FgjxCkgAytWQWdwKxEFL
 tVyxMFso7R4Rnd_g3YIOUeI6rER0DNaGLuB0s.xhnLY_MpSw.d7rm7CA7GOdYBUV0w_a.EM50KQk
 13.Ty_59qIC0gRphjtL6GA0N7juqYPnOG00byZEvn2DVkrOElsIyk5fK6W0EZyDPnTwi_dLX9w_o
 HSWVlw14bHt0gVON25AWGbtHYuoNIrGhsakE04qYM9p7yc4w4K..i8BJ72tVktwUHS.pd98.p.CA
 fPhch040oJHudlf2XIiYVBmaw.pDSPoYJT0_lrbJLhgRoaZedVRiA2DVcFw2U0bKVj0jrCV7wY87
 xdTUI053sMyR6P72J1LwM31Y59SvLjwEkX0E5t67TiUCkiOiQDf03dLJrNOgQ4wM4GIox1ZWe8RV
 SYupNoHkUomieV6riewF7OFOetWxeSl83kjjIhR3c_SkONT0UN2yIVZW4cBGDMtbifYSby_6S8SG
 wuHMXVR3Pk5MOFlzwV_6jcof8Q5aiNpEDhXgwgrRv_GWz9oF_XJGpdb7ppX1BnFPOLhgZc_qNO11
 RLSJIttE1JW1eZJg14H8P9Ge_TU5qK1gvyfPugPQ8g9uU81FSuOMIyTBXgt94vqxfjIQ7efpu9BJ
 Fd0XQrlXaoiu8.kqB9cw0Ow9Wq6wtl7VmeP6lhG0VHZZ21dtlUueVgbqdn5MthpFwzWUhCSrDRhY
 eGjnfaHg4h9efI79Fth8YIxd4uBTj2SqOjpRe5Azqp89rHunh3Xw0pUGKSX7uhuQyvhj18YmSzMA
 _0Hyppzksi0LxO9yWkH.qFBvkWRmRICC3k.QYC1yhp6FEbFabzMDHx3B2R4fLiW1fv8aO4kcxH.I
 hirA8PGlHeTL1H5GvlQjWvEKHVvuUa0Nc.ms3uYzAVb0oXa9EqPuG2zGYUOolE796VXog2ZOCera
 FY66jLvM8p_iHJGzEfMRlr7sddb8_cDwfgFDVBUbE2DT_84Ed64o1IaDrw4ZfQLEeH9u9lmij7Xu
 W97cO6NWmINI8rfYVvLyZJqqZ9thOIWiu83GRJcXAIr5lhyWTJiGu1vrf3Z8aZXMe.hoYTfJ5CCz
 eqwvE9UUd4PPzQJm5tx6BXPYzJAYahcs7MYMuAE8tbX39ueqv6iKuQYkp_L8CLZzedLG9a7BJrWf
 laUxBQV7LFlMgF_tLrNqODynXlVZ3i04fLkoSSq4eeRruMW6.ZCcQloj.t9zhJHvdQa8_xb0EAPw
 84lwWT6F6bqgljNakC4lG.SQDWaCH.i.xEYsNCv1qzT1U6J1_OZx5q7dgMHX2s_w_IWGJdMHQsGU
 9qralY8Xv.BzaCo4sCdNcdDgnx.WopJxms.eb8Cxd4C2t6H3uHkQUY9JAeJvAyqmlr0UILvCN8.g
 _Lls_umm33wZ7dg6BXetgIhUPob7sIFiaBE6pHxe4OXSdHjB1hIfcYSz4p2V6BVmKQtqU9MS75a6
 5TF3PKCw2cEMFWmH424nApnwJql8QlhTRXW420jyvwiJTP44Sh9egVnmDpQ--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: f79e20fd-f89d-4d88-8ec8-df8711f35bfd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Mar 2026 16:10:22 +0000
Received: by hermes--production-ir2-bbcfb4457-pgdzr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 87d652406d88cc03e8e5278a11075b9d;
          Thu, 12 Mar 2026 16:00:09 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v8 10/11] net: sit: convert ipip6_tunnel_xmit to use a noref dst
Date: Thu, 12 Mar 2026 16:56:56 +0100
Message-ID: <20260312155657.25676-11-mmietus97@yahoo.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zx2c4.com,yahoo.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-267155-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 27A4B27551A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ipip6_tunnel_xmit unnecessarily references the dst_entry from the
dst_cache when interacting with the cache.

Reduce this overhead by avoiding the redundant refcount increments.

This change is safe since ipv4 supports noref xmit under RCU which is
already the case for ipip6_tunnel_xmit.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 net/ipv6/sit.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 34d4d72dc58a..2dd43d472e5d 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -934,31 +934,28 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
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
 
@@ -967,7 +964,6 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 
 		if (mtu < IPV4_MIN_MTU) {
 			DEV_STATS_INC(dev, collisions);
-			ip_rt_put(rt);
 			goto tx_error;
 		}
 
@@ -981,7 +977,6 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 
 		if (skb->len > mtu && !skb_is_gso(skb)) {
 			icmpv6_ndo_send(skb, ICMPV6_PKT_TOOBIG, 0, mtu);
-			ip_rt_put(rt);
 			goto tx_error;
 		}
 	}
@@ -1004,7 +999,6 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 	    (skb_cloned(skb) && !skb_clone_writable(skb, 0))) {
 		struct sk_buff *new_skb = skb_realloc_headroom(skb, max_headroom);
 		if (!new_skb) {
-			ip_rt_put(rt);
 			DEV_STATS_INC(dev, tx_dropped);
 			kfree_skb(skb);
 			return NETDEV_TX_OK;
@@ -1020,16 +1014,13 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
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


