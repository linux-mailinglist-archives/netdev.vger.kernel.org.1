Return-Path: <netdev+bounces-253727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLSqA+dkeGnTpgEAu9opvQ
	(envelope-from <netdev+bounces-253727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:10:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5D8909DA
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60D5A3029AC1
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043EF32AAAA;
	Tue, 27 Jan 2026 07:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BEtMpXgk"
X-Original-To: netdev@vger.kernel.org
Received: from sonic305-20.consmr.mail.ne1.yahoo.com (sonic305-20.consmr.mail.ne1.yahoo.com [66.163.185.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5FF2C08D5
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 07:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769497758; cv=none; b=FwEf3fjP4KpNPbqsmcPsspWvWY+lYxv7rSHlhUP59sIlAL0RJ0NuUOYix3idmCAjDNoH/C+1EBS2nvG/6I8mf9fDeMYWn5pKBsW5AcJQyH1IAixq7zJHZy28XGc14XiSI+dr2ZIAQT31zHZ/85sUxBoKzwMxAkl79kZ3tSKw+U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769497758; c=relaxed/simple;
	bh=fykhDRP3zy5AwfLXmaVhSn7b8RvfYkugxuQo2p/Ckrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUjauX/PFBezxO7lbIzF3jwokmZ5L5u+DZeUqw+KgH4fHl9oFIMkSrzxcakl29B+e7/U3veqAGLHRocniVb0bf34vdM/jGTpr/Z1j/tFAjkWuyZfJzh/UFCsZbNsyMWW4aafoPkb50LX5n0V7+QqeMCo5wjyWi/ocMtGt9es2LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=BEtMpXgk; arc=none smtp.client-ip=66.163.185.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769497756; bh=RuQlHCBcGftm9G6xbG1a4uPE+kAqmf4P3/ymDJRxVpk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=BEtMpXgke/pnMcofHv4tV3b5IPkvM5lmPkbne3RDmMFZBASNiV5MIebOaTjmo6pb9Wm8xkjrDDrJPc478VskoTPrf/eOgTeZaeliwLQtpK0kFHIOJ8oBBR6aFSGuhcFnD1WjVQdVKGD5jIoXD7Im9BnRN9NqOUon06Wtr+hKXUgNOlaEwtnTVPgR9RBuUN0V16tugnsL1qXgDyZrW0malCS3M5vRGW/yxiYPnMc1UFdCC7ftdzkp7ewHsoPqy/nZi+WfV83tuu9J7ukDSvq96MCL/szhhuAsA7OVuHc0924IpEZLSdDnR7FbpRjef4y+r1IpxjpwSpmdRF6Z6IXdIg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769497756; bh=MwT0jHCjsvJS7KswzFDhi6jRz7XZ3T1/Jr3bG4oIbcF=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=kwXgSLx/9ySvuP9jmUffqPc1Ov8LMTVo9dM6vgSHWC9iFt1RQ7KXHqi8QupjhWGZdWmorASnaorXQXeTw6E5LNwh2d57Om3mZz5bUWYNd/jzupX8jHnDCYCcMCqRVEKMeHtMMIvEl+wcKZ7FEn/OceJJm/P6pNf5rewhdzYNCxfEklFkwG+TTFz4Tw3LzOHH+XpH4yGETHyNnPbKjWA26iF0ckES0tPPNV2lYneNsoJ395/jzCMeYw5ZVbBsnVI/f4x421dr9zj8/4FmZ9cVyJpsgKsvh3TcZsuM7+fDBXDgs46DI8Xx+YRmU/s/Vjd1lKEhBMl9RE5SjbYUI8TvPQ==
X-YMail-OSG: huIjfqcVM1nf6rRQusfRxmE7aek4u6sEaQx7w.rEQErAcylPxYDKVrVifmEMB2y
 1.sDCz.eoAl63bhGjlLY0BQyGNRDmW3RoBx1hnEb2jDI9ZWPnf7jFi7WO71qVgNTjfM4RMsaPkeS
 oXeLs6roHdFGFXVBZLzXBkEfZMK7mFq8bTgasgDNShbLzSUJ..py6tCfFbOdZqkG.xr35kJ2_hG_
 JZwgaHJJ1XPUyeCF8SYXppGrjw1elVIbHOHQYa906sZ7gziz_LX8Kb1IRShPB.27w_5rbSb_HyLL
 mWppctJJErKSYCETUJQbOaq4pl_fNcfw_zzftsagXJsPAloIh8cMH5gpU2HclNU5seoHb1MWtQMu
 NLsRbN0hM4.mRUDqfW2OcpRVbsfL4F8wFhcrZPGqToG5WUdr0GASufGIF9jDVQF_1LyzsrRiiA3B
 DiZYk6l6VyCxTesaCzFa5Md8MbwdQgUORB3NI0W2tUIOwdQQ8roEG3zEZ3x24alonk6EINN_EyOR
 C8YgasxOYPA_rFbmoAIHvi8_p1_B.OLo6J_xAUEv71BFDqun3wnRY29bwP78RjLyg_2UR7wYNvd0
 l2B67Mb4cXLmSUvPqcWPSfp9zA9OMuTyPzSvxtLt_PKwwemVpBLq4E2XymFn4ukwTBXA1w8lcwVb
 tAlbuKfnL63KdXdDTBx4dafrf.jIfy6saOCaIiys6MmlCeJSi0b3ndG5Pxsei3qlrOR4WO5XZMU8
 .SeCmauNvFgudCX_aYd3aq2sJ67R5DpiRTHT3HDTeqwIpWiTzzz2roVO59tlHPR70XMnfGrRDyRb
 nk9zeInOz6QyvcAV4Xd2vYE3fHa51m6_qqcovX.2r1Or5fyU_IzGAK9QFq7by9sU1iVE6ftUfh.y
 FKhN4mmelUlOdWNArJ50dIfA0lJ6pq5j4a4eMFBmSzTYfXAnkQWw6cltW_oSwfjRMIGPt2.mNeNr
 LXjbeTw8MzwAB5enohPr8.T3Y4wYHtvhFW.Mbk0bfBwu7EXLD5YHBlQeCKOixZ6JmW1UvbDRfBxm
 DzLF6b7pMT1z.sy3EBBLyur8anq.5bj8FbhQLog_DM_aXpfENtM4tvJBldR8nqALEU2LzV3vQnpm
 BSHkEnybFe5T99GGKF0_axUQF.Ggx79nvExHlBx44WTkLuR1E4k0KfRwo1AdKZd266BmvdqTfFL9
 k1dmru_Wqo7S5w2UjEDryG80uQ34bJ5MAdDqWfNMqbcgiOnNkBeecbUKNZeDmQiP20.x4NmqGtpc
 vWYfuMXFexnzyUfRjqknLM.sGvatDkPenkoaWG9zeXf7.CkYZSX6lVieSwbOUxSVJgW5y8PSpJfQ
 m35OpYhK_N81OKOtR212XarhISHDeNMX52x8Z1RkJ9z0PLImFw2M_KsQWdXjj9tjsZlL_JCAfAD4
 3wveYzyax1wE0CC6U9KI_oUiYL_EG59vemD0Bc3g.gDewNWkIMEo1kG228oSOO8JGdYSaQ2qVItS
 DqWwGQj6sk.cNNycSFCOzOcybr.U0bR0QIfqBXOpRkiC8I_XJXvNZ588pAjCBuFaaK37SizEhdWS
 z.bOWDNH3y5Lrbcbja1j1okE55vHRlLvq9ce0V22wJLhZ_rrSwFTUvnz7kbM_eFNG4qnJ.gcid2D
 T1.GilPeXcd64VaPpbJaXC3MxpqS5vwXTFhDjLx.LEW0ztDAEwpiRY81s_aQ0ZgM6LjFlqr3NT1l
 B1h_0ugSfL6Q5ggosAWfdqycrdm8jsI4oxwBTxp8kLpTUSu4lfK6GR3em2zl3y4lMzT67y2FJ2NY
 fceA23qfXNuVd9v.JCsIYI3ZhKLZQuBSENqLcprvIUcaw4Enol4O1gPaLj1J_g_NyBkIwb3A2v4s
 vxRpflnpqc_EAIQWMK2uK6tUIoU5Ar3rcimtb1NpLC9OWaMoCliBc9Q6tooXfrPG3wV9Ol.i8lYc
 G6VQUoM0eapJpZRP7r.DpJOVpU8TvSE5lzu3Mh1vMBN9eic4kD48iTiITSKYGxUSylsn616T1ntA
 .LXQLs0VnkrL9jD.uEnEj_enelfIZjvQaqSpuaQ5d80Y0c0x69zZKBNSa6MiIVDogsnv24RXzzD5
 eLc1mpVpxV7RuxIaYjmwrWBhYn5qToovZBwqoCRubWY5UhGs8sTsHf1_DvLwdkDJfOR96g3NSf6W
 LTAlYWavwxkzauTc_JjOgJD7aG8nrC7WPRPVjNtRzKCbY8gw-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: b1457fba-7669-4ce1-b593-f83a28ec0635
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Jan 2026 07:09:16 +0000
Received: by hermes--production-ir2-6fcf857f6f-gch58 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 84771875e54e61ed0bb89230515c8a5a;
          Tue, 27 Jan 2026 07:09:13 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v7 10/11] net: sit: convert ipip6_tunnel_xmit to use a noref dst
Date: Tue, 27 Jan 2026 08:04:51 +0100
Message-ID: <20260127070452.6581-11-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127070452.6581-1-mmietus97@yahoo.com>
References: <20260127070452.6581-1-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FREEMAIL_CC(0.00)[zx2c4.com,yahoo.com];
	TAGGED_FROM(0.00)[bounces-253727-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmietus97@yahoo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[yahoo.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C5D8909DA
X-Rspamd-Action: no action

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


