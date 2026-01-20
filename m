Return-Path: <netdev+bounces-251548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AIBO5PJb2mgMQAAu9opvQ
	(envelope-from <netdev+bounces-251548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:29:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9329E4976E
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF6B282CE0D
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B765E3B8BDC;
	Tue, 20 Jan 2026 16:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="e47M4vwg"
X-Original-To: netdev@vger.kernel.org
Received: from sonic301-32.consmr.mail.ne1.yahoo.com (sonic301-32.consmr.mail.ne1.yahoo.com [66.163.184.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092443019D9
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926504; cv=none; b=Y/mTMaCkDyCmNrH4lShebb4w3WypPLfHyC5IIS6DrxZAdulXtRbybDQEhE1dYrR2A4U/gY0+YI3lFCJM1PvQkDIj7ojetqZVZIyCsgGvrsfDzVkhBanL1cR+paRwhyqN7UQa2b8h2DVtw+DEjqUeIzM6sTwMKN5dCuAbUzYN2Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926504; c=relaxed/simple;
	bh=fykhDRP3zy5AwfLXmaVhSn7b8RvfYkugxuQo2p/Ckrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUagynbICIGE+x0OFlat6HeAWVoyyWN+IZHw046WD9V0pNEsJCFPYmuhqfIERPpOIbYCA2VVZ8C4gcZewClSret+fcW/Gm4tqb1IB+Vli3qHz7jkhy/OrUyYFCwquVXYLg+IFs1SeUXxWLEnf2eNZ23cB4DWIVzOutqX6aRPwzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=e47M4vwg; arc=none smtp.client-ip=66.163.184.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768926501; bh=RuQlHCBcGftm9G6xbG1a4uPE+kAqmf4P3/ymDJRxVpk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=e47M4vwg87Ah33TYOLJBGe4h+zn2N58F3Vx8PJUbiGKC1Vax4QIEVCLZFhMrMNLlMokPajcdOnuroq3nc2frl1/O4bEFRLFN+2MOQDdxrzCMTwZvuMrrSRlcINA6l+S6vqwUO3Z9IBYrml/xmywTjNh/v0EUsHaItD5jiemlfJ3HKe0adB1LqhGP3b66yxasuyhdu7ReQvUWfZ1NkeODc+gRelo7DrSG2C4UnuRAJpwd02/UklQ+SCSXWvdPaOQ6yr59TBPrStvmSXRjKX327B+T+UPMy9RF9+j43MvJZtcuaYk9ShILvkWMTwbbZMlwYHI2OzeaYgTRz53w/EpemA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768926501; bh=NQyYsDw9dYGUi09hOn36f/pTe+cA35+gqJwuGesJvjM=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=KKNtHwfAFZxMvccGazhwXeZJtAL/zlbJzqTxFGtV+A6jEdlZDi02XxMiXL80KaELI6nnFP4jQNvlbufE7TBUJN9eybfEh1QIv7Aj7varbBcAQzqNEkmPNvB6jtyvcoxMg+2aAEbPIW3iEF4WgZAvn3ZTKluM0VYLztQ94NdAxJ9DGyciq3XpfHZbQ7cqT5v3kWCeponzAYK6vFDSg8olwGxPEsLKi68ViYMmQYww9l/xgOclnY+++3NmMZGpJ0gCA0vaufkTRRRpkKr689K9rr0yJprz2uvS/XVAxUHTj1OzHNJOYUJ3ViBHnGP63pokUVNxk0O+y6WZ8idn57kHqg==
X-YMail-OSG: zHgidKQVM1nXlgMO.Puxp4iNkar4CMuIk8a089KO_U48Nxfw8o23ma6.9GQyOPZ
 ux3ghAutNUE8H6HFRrOTn97q9IM9laUS1v4ori7holMFFHGNH7pmAct.4uHh0vsf3vwzIkx7lxou
 vEgMfRuQamP23umfhVBuEsZgTI4rRLX81fj4TOsLdHzD2FvRWuAQT1_b2aBtZYKDnBt0oRwtPIFm
 7xkD4jthcVJF6phCSgGBtHFa4NKvkRidDp3986JlWAlncKlgJNUVhTEoxMOfUcYPciT3a97clnoE
 db0LJPZ4Dn5mI20K8scYiWBWE_.9TFVioISI662cay3QPhAcsXf2TCZ8IXRmH9yUxVXu9sZtIvT2
 K6FN7hNe8RSPunk6zUlWXbu0tetCnuUFbABJzpg8fxsnwmzQ4dQLja63LxhVXkMGNyt7m5Ym8lDe
 .xGb26r3_g_._ZsmzYcu5ANxpalDI9vM2emEK_E6AJ7WAnPf_8WCyNKpNLgv65p0zh50nBtLZezN
 vj0KQ2CaEPMDbqZ5ZKy0f.xcGNWZqXyAqTF3ydcz0RSufrxPe2js9tLlh4lgDoKhhXeBbk0xfAg3
 YPOfKAv0iVM7dGN_f3.pqkgwMrInwAOnPyGYRnaCWHp0ypn58WL7sdQxbi0RcJ0RQ02PQDOEXEux
 chjsnZR7XNQbxF4.VFvieRfwVIJPeRJgDicLW3gquFVzLIEd_K.EQEh19v_64VAyjNFR6UnMkqXw
 2ceTdNcFu8GRACBW54hkmb9l7YPalSNu0qE6wiLGYIqA5yTQGovwmfC0PJ88VuhPJD4B0Rl_0zBj
 UF9b4zQn9dLY4UHZpjBAi1QeBkU91Q.mf2lmbQZBD6EIAfOf_RYHWrDCEprywhJocbs0o07cNQSB
 A9C.GpaTa2j_rzyISiLDLMVPWubDQZGMXg2N1VAz2XmoVtW04BFarQ40whZEsrt4ubEzqhiIzgIo
 c1dSrKmET37K8vqrZZJ..R.jc07lxtLCx_sgTCQicwFoUtytapZ4.t.dUW8wd.Qi43X1fcb8ATH7
 CVY8qOGJzeuZS2uMZ05ccyMxJFB2R2nNeCkmhILRQuNitSxI3y0Qlz7VgIec3sZqkavP5JOq.JV.
 .yA4_wKXGA23TwjSmM726amgz_ZKuzQgThdcat6KsA8G0BKMEgrwt1G2pxsbI_9uaNB_wq2VBkC9
 PKxyx0PjFfTevXWeyp0vmc7PB0gEIZh.BeuYl6uigoXMR68Q7_ka6Bc5sqOy2pbymTXamFXf3X__
 Nyl84OJiJkJADUeCtgSFNWrMH2SoLa7p.trEAhq80yzmjaUFO4q33TOYS1bYdD4Ex_y_BXqvlnDF
 fGnrzhcDEW9PT3iQbibPRuzdfD4DfIylELamZ_Bs.M3fCzAHDV2deeWxrTNseictdbcRqzNlJS55
 FcJlNV8i7vbHlbhbv2LPs45rytexp53UXNOpsSYLOeJMB2cnFS2l3w5SfNcvLDhQjQa6oh.iDi3m
 N9T0s9az.439TwA1Tmtmo4HcAheHr5b8PYz0Nzl843NEtCed1uZfmOOU_q4FpSCos.tlfs4ymJau
 D.WTZiILjNB4hLKFtj9SO8r7cL18RjDGJbufkqhM0TxO04JBCtepS2_.uu03N1b_imcQ85nqzKts
 lhIlriW7VBb_D5IvIiDihqpcxzLYLg6GtSbDNrnn1ltdKKA.N.7lufaVo3d8eO4bQaSOH5CjtG8C
 g_aNs52ltSeyxriyDkeE59hb.ecs3Kn5UTIitr1FTBYPb6Z377Vy_THqTGUHUCgZirTNLSs9a._q
 xKpW3akx1r0uZVTPJUqrU6JeRMrULsWcPGefQ2pZsGiZE4PdhbLN8an8R0kj4FESOiAg8A1eSVvk
 WIy9oGNO3A0e7zL5hYepzC5G9KI7VRWqRPPrm0s32KKZ4qaRnpZG97aqEA9xg.kGCvSil8YSk.bE
 UP.Z7MVKsdb3ZpywB_VcslthzXHH6K6mN90mLwD7aNUbKzDqRTEx9oDxEIvDBf3vWlwHACpb_.Fb
 yHOhFc8aH_1bOomrMz5PmJIIo9PpqXWfj5KIadpHcCOSkYcrpjYm1PvVR6HrxXx9jtyJfEscCiMq
 jwfv4AbTbRYHNWfzZpgzoEQZYJl0GmkVjV9xSw4NWrtA7Ga_YmAdeVn2enXLaUS6JQiW4mSaHVQv
 aXh5F_abSzxalflu_PCuKmZr05il36b2637ao1UDYBunreirPeqM-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 6cda06a1-5758-4ef6-a8d5-f98b4fc65dd3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 20 Jan 2026 16:28:21 +0000
Received: by hermes--production-ir2-6fcf857f6f-vw7gs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5c743ac7fc5feeb5bdbb197ea32f25e9;
          Tue, 20 Jan 2026 16:28:14 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v6 10/11] net: sit: convert ipip6_tunnel_xmit to use a noref dst
Date: Tue, 20 Jan 2026 17:24:50 +0100
Message-ID: <20260120162451.23512-11-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120162451.23512-1-mmietus97@yahoo.com>
References: <20260120162451.23512-1-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-251548-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[zx2c4.com,yahoo.com];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[yahoo.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_POLICY_ALLOW(0.00)[yahoo.com,reject];
	FROM_NEQ_ENVFROM(0.00)[mmietus97@yahoo.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 9329E4976E
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
index a0d699082747..857f9a3692dc 100644
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
@@ -1019,16 +1013,13 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
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


