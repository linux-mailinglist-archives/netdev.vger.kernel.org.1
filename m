Return-Path: <netdev+bounces-251560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAhAMWXOb2mgMQAAu9opvQ
	(envelope-from <netdev+bounces-251560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:50:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 571B149CB6
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1AF7A848A42
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72B534AAE2;
	Tue, 20 Jan 2026 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="l920Iyji"
X-Original-To: netdev@vger.kernel.org
Received: from sonic315-20.consmr.mail.ne1.yahoo.com (sonic315-20.consmr.mail.ne1.yahoo.com [66.163.190.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD0B34A786
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768927685; cv=none; b=m+PWzcIUO6u9golu15Ks/Uh98Oxt2GJd2sjyMexFMXeqGIwl+xMwhc+ai5aMq4GnRyQCiHCT62u2whxOsHnYfFlbwZmh5M/MoPaqBw/u7SsuGzvYfdTVhiiLksYL8QoOmPVpG77pePvxKmAKH9AxcJBexKTrrPzmxGHSCWbYSuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768927685; c=relaxed/simple;
	bh=1xBhA+SemGM8RszsJYiIlVK7UG9WJx0fAh4TOWi6Fyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2LlGAPymttptWsxoAKEjIzzYV/TpmiVR9Thp0JMmhtlG3/WZb0yHopS6I5QB7z/21t47IOTZIUlkgG0EgQ4uzR+ddWOPAdVKdnEXUUarpgkpED91jG+0gwAhuk2WMbQmN37686TY5b4pybScpavMwNJt/KzWMJ9oCeMbEbufqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=l920Iyji; arc=none smtp.client-ip=66.163.190.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768927678; bh=I70KElqDUQJQTDcufEq+MIbNvz1K2tPqb5tYJuIF/Ds=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=l920IyjiEp9qzfo12wZ0h/Ga4X3diNM9UmaJICprxAD/+2v9zbV2wmuTsZNR1BTnNCFj2PdlIGihkanD363w91GmxCasnz0i1aVLw6csVexrV0v+Aq9EiVAer/emJrKw2j+1sA01GeKNaLcZ2+I/bK6fkO5IrKvnoodavnW2jjCzNaev2qKYqeEo7LsL2mTe+sNfEFBSIPUH1F4IOozv/1f7AINOq8+p1w7ssGKLKenyRXTcBjZzJTULNeSMEIdwfBgBB4Wm69Fg+V0kqlL0tk2T82L+0Og4bDdr1HL+yw5SW2dQWk+Z2ryh4qFNH/KSiD153nitht7rMhWZpyCVXg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768927678; bh=MZhK2SCE1GvK1VhFCx33s43zZr5WnKsCwwPGzBo9Lid=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=fIgpZlUctje0ICjMagYGlKrKOVbE6E4+eQj+3VdJPzV4g1JuiMlkEzDCpdylb3NTZ8goZdSJ/FAx89bxcfqrm04ajXPjyV/Sk/Q6SMkkE0fQ4oGsYPvD2AGWjgQcFO/rHnwRnAJPwhRVRTsTeTu/vv1W+jMF6aD2oNGGUzGNpJe2lpV/J67cN22gkpsef7U4mU8RT0F8eQ8EUWlV881XWbTMsGcMeREUw61TQq4WfXuCU97zTXK0wf9r8eBTED3t3yBkI/dzSgO4laLAHeMZTGdbrQwRv2FBVjflrk3N9BiViE+LAbJ1PF7S1L9Zrvqmln/U3bD4FEU0ItTjux1vFA==
X-YMail-OSG: ZBRlKeEVM1mdhafgj.dIjZOjmWCXLkyNvBpvc5Zdi7HnR7YextjULSQYsiQPQdU
 I.qFwOutXtgFQVkGB823P0IKHNJt1RkZqnHJcjy6ZeKfoRwXi27GjHxtDwnt1h2idd1iH4CxTgxZ
 oHcDQ5ScOXc4SwlbvaMHXgsOoWgOohEPiGQlSj13AXCO4twUZupQ6CMNC4ys5Xjg56aWi9S5JKxM
 S8LNznJtP5QwMINWMxpPzoPYvvyJHnuX4kYa458wEazHpbI0iaI708thzvb65xX2AuaBQ8ZlrzWx
 Kx_QmmlZvCDzMpdVNHuedPltgQ_cgj9sKG9fcMG9LTa9de9GVFg0W3ST54AD1Tp8FIcSGjFVDeaz
 SWN3bcZhRBbVu9VmeQ9icUoJjXFFuUlvPWoGJmNixwP8Im.Qc8dHEhxd85PvClc3bHMr44NDBBsi
 bZcCVZmsGMc9oxydFry..GiOOVfk2Ox9NTHvEwlsKgsKHdhi0kYY8dmQyUeWWwq5H03EARa1eV3I
 Kq2a77lvXPhwxfUCouxygiYsj0zo_wkeRpdK6R9hGDZjszEVFSOfFxrMqBGbyAPGo5X2OX5nelEc
 5sKKmhHWEQJI8lNzo.I41GrjXHKN8IoGJicVamKI5jYV5ptXC1.FDMLFtXbdJDH1Y9WYRADON7Qq
 zDT8hSOv6I1LwRpflLBcj39P6e7i14WD9rpmwp0lC014fKTA4UJi4TK9YgBrnf7BDc2vpTwrzeWc
 Qq317DaY603WzY87LjF_O8QHk9_T.j9nf8esM2NhcUDuDqjIwYw6TCViJCz.HUoNXVwpFJqwWKGR
 doype3mOvKPwK7rQcZjeJfygN84s9emgVtTScj0gH_k5ZrIqRUUsEeFpiUT9SFCksp0Nwf4sHmwu
 t7hMMGmNP2fGoEaPVbOuYxQdRWIwM3cpIQY6yo2v8M6HqnrkvZibr3ymChUjnnthKgDzPTdFxca9
 DVLtUmvGn2NjUBpFoLg7a188jfYGnCdXokD9pArTqGRL08D9nJita1LkNYM3OA7JhrJcmHIOPv16
 6FzevypOlskjjDuspjiQHO1dQ3jxn8lbCiUMYMsfN.p1uZ20tyfxiQAPdKbwGJmUMl_wjdSVd0i0
 .KjtcI4oV96uuIHItvL9o49gHP2JD5.BRdT.qhkxSSWp6Hz5pdyip1Y6X0GBoix5jOrnqf77U6g8
 beGYj83b_E6dlfZEmv9T6AepoQ8TTyyEzszuozpjEj8VSuekbCkqm8Wy1kNrrzrW18wmao2fWoej
 qV5Xj2fz_Wo3uk_jVKe7Gj1yIbBqOtgAABYS5h81T5e2TDORcaRaNka7hbhMl08u01475Nw_pUog
 7zLDEEXtoZD1XgGxqY64slvj4VVabBh8sz_NqWmFAVcAB6MqTE.oBUVjsE7tB7GBT_P0395LNwVL
 Vwt0LXV7YO5xutKKWArKjaVUBex7oGTIazMIz17S.AB36tcdHF9ExpgutpFlEFaU97U3wzB9sEpt
 zuEr37g17RnYKnAv4_Q9jDk0Bww.x2mEQ6FhQjhp5pPQXwY.zupJO7iNlkLBj_AipZxOntxMqKKe
 KP9nqBpB.H.p2K0ho7078Bbo5Twce5gnAJBuqlIS6M.yxieFJzIF3otEAlSyx9zo9SZ8RVEWzDef
 ajB84KK89jF1zkSinAIwGsHULr59m7XzJHrEP_1bDqPdvEu.HHwwovS0BBNhRk1RDXR2gagigiTR
 ZAI8WYOziwO4fVpsvN8O9f4oRpnuQ8_.YnH2UPV0gXWXmRJAWWXnRdgDBd0Mp1qXWWB4F57V_1kr
 2kaOxDFzBqt1C6HAqSpGwAV.vhLPnnpKc7lobFZXGkYsk6mpmB5W0Q9B2YZeR8cmlVHCj3LmSUFQ
 n5Wxda9hr5pI7KtEVOcrbmW10KDxw_fN24tMhxsyJaMUOoHYWURTAudgXewgpsoBHuwpr1PUnktr
 zVyxW_Hg9fCb.vfQCRf_7a0zleesx4FSp2ycGsRDnQbpcDVx7okS5S.UstTxsMc.aJhCZ3C3u0Qk
 l_6hDKLcJ2CXEcNCrGsBQczN1xDzDxcQGeVE2ySMYAM4glyl0_2peQtInYVcSyW6r81RB7HdkpZv
 nUgP.6C5H9jBp.mAcuLFLR.3CB50KB5Y7HXdnmUtmVOQSSZMpZfyL5Cpdv7F.DjzGR1hyhb4GqPG
 ny6rROX0R.0YUiy7Awek9h2eGqBYB4RQgOpLm4KYltbWGsAKWgQ--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: fef47a2b-5bfd-438e-a41a-d8038d650f79
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 20 Jan 2026 16:47:58 +0000
Received: by hermes--production-ir2-6fcf857f6f-vw7gs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5c743ac7fc5feeb5bdbb197ea32f25e9;
          Tue, 20 Jan 2026 16:27:41 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v6 08/11] net: tunnel: convert ip_tunnel_xmit to use a noref dst when possible
Date: Tue, 20 Jan 2026 17:24:48 +0100
Message-ID: <20260120162451.23512-9-mmietus97@yahoo.com>
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
	TAGGED_FROM(0.00)[bounces-251560-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 571B149CB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 40ff6ad9b9b9..146e354810d2 100644
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


