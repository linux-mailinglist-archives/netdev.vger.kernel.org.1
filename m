Return-Path: <netdev+bounces-251546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8If1N+a/b2kOMQAAu9opvQ
	(envelope-from <netdev+bounces-251546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:48:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C070048D4B
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9337F82BBC1
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD04C451065;
	Tue, 20 Jan 2026 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Vw7dF0Jh"
X-Original-To: netdev@vger.kernel.org
Received: from sonic312-24.consmr.mail.ne1.yahoo.com (sonic312-24.consmr.mail.ne1.yahoo.com [66.163.191.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C26F44D6AB
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926406; cv=none; b=cymzej6cLSmV50RQev3ggNFq/cZQflZw8dIINWOeS+5K+GJSRKvSZwjRwI6GCBuRKAzhfda2UivvBrl3vt/RYf9txHAgEMf0Tj49vv+Ahb1u2wWz95iD2TtWLp1LolcY/M0MXRSVunPadKziqtURzZsuXgjUD4wPLfa3jT2clV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926406; c=relaxed/simple;
	bh=uUjfpi0e4fmdZEqKEsErNeFAnQHCJFOvLlLmvjwFiCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWGV4IGqiRT0R39Kh3UT+kuu5/AQ7re7qTNTn10EkVP/r6AOuOzHrgQqSqGc1TDrZ969f8PevW+taDDr5Tud0mi1p35/jBYbh4bkaf6VfC7LoF8D6Eop1/3jDcBQ2TJhQitsh6ybgC+CjvjNs0TV7yh1C8rtdNtJWVj1SdpMgmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Vw7dF0Jh; arc=none smtp.client-ip=66.163.191.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768926403; bh=K9u0RmNxdiHsrAmlin4FMJAixJ4BpZ0KJpaJ7c4wO98=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Vw7dF0JhA1c/WlQNokpURUkbL9TbL9oiJJyceIAVzWxq7vjCQxIYJ+hh4/jdX28N16Sj/wp2ExMLrz0agGOGc2auP7Nn6JggJK5lwp6w2vo1oClT2yp1WjYhHURwl55Qwn9bGNqu9oRzJVRRdsUqAefw/R3219/WZhtvRLux9YTkaiaSkGKPmJ5bTyW1i11GYAqRAD7CpyzzZydx4a58TG0g9Pjrw75h+hpaQPTlscCRvXTdKM4sAqfaVjNXj60xBCOE2kuggdVV7507fuMA5lH8n6KZlA0h2ynnlXlxKkLPASyUppYKokRetUd//6HrHmJvPsp/meJM2bSYNnI1yg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768926403; bh=UXBlnTebcg6Fnf37i0mFOBv9H+9fLjt2PxcWs74K66P=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Czd3HFfqdAf6GxOUWXLCjrHtmKjFaujCswn+L+0vjuqyGZ6gNaTyGjr+7SM5nL6mCsAgo0HebSD3A+cqqG8mWX8dS5vn+SZVKg2Frfo753e4ADgVFeYGp2QpcBxEptkPE+evQcXkacS+nJ9Di4qw5m38kU4EBGTIuXAY/ByQktfa05v8eyYigD/P7XUXAumquqMzqdZCKCu8kPzR4Et8IBMbiB5zfx6g2z6MXgE6ofzR3R68Nu8h+F4Cif5+4OVGTsr2hIUcEfjzWOqMhSgvM+kemO4e9Wcz/cgnK41xdhZnkWiVjdi8Mhk3fWr5CC/okqNjNPvhNljMFkvW2BlktA==
X-YMail-OSG: IwxYX0UVM1nBcV_DvBKaHm.bPXMSBA1YWw7.u2LcShgJlVjiZ6uqxGQgm3LifvW
 PNcQHIK9QF_R2FCMXTHosVn4J3kddvFKhrA3KlOHucT6li_EQj.zH9IvJ5xwyZdjQciEp9reTaEg
 gU.68yHls.p1G.V3gzd0w5q9k1pybQqGRwbmKsH1u9B41vlZEKDHu_b3KoWWrsSBDxhNkZcLOVNM
 oLcZzNEs1.tIeSfKebxxKpxNA3HMgtIbRSWbuOPlHoNLTZfkH2wctQZzn2SeYBlUod6ZQrN2LQdG
 Bk3fLpRAMj1SnjlZ3ulHS53yUZ_c2e2YQ8e4bD5kAxAXh3.6bUZiZryQ8F.Fn.zM7BiyrCP4bHco
 fW8W7vtFTmA6b2oYenIah6n3bwd5rdEOO19F0P8m52cHiw7xOGqfeYQG64fR4MnVJY6Be2e.BEDD
 VnhCvwcY7OIJ.iqhwSLMlkebsb5iFd8HlshGptr1hYIaXHGYm43H4eoBNpJqRSJ5WQTj0dTgrH38
 OcUAVrZwDHjguRUuYik7zypl8t2rUb1bR9QErevMec9Pzs7RpKJAN0MUtxzbt8t2YvPUOheXsWKs
 y7ncI4rbRLlkRr7T5Oc3XqoTjYneZkkW2YEwQOwrN3MzHMNmbJgaJRUHwQ0TOJxdfTjru5z1NQ.V
 fNzFjeMPzV61nmAnNUoGLPS7alW06Ki_x7cs8KTpUdn2FdAnvJvbLfUbkOyyUebJsj2wyAXa1AAN
 zj.VX6kpKJFpfZV66FQviOWt0u.G7x6Lb95HruYLCJ0rui191yWrveTW_1ZFm2TmQ0EYTh5kBWcm
 J2czIXlfZXIBOAJJeGi243I4Bqt0wPWE.FpjyOwR1xyIFJJXXXcA3aHJWBYj_ah520M0qg9xALS6
 4c0sK11n8y1ClmrbADtlQZX5Lc3cJr8raMzDy18ZBx19NBEDp8vn8qqJHrMvQCUKdESfA691nr.F
 r8ILakGoCvHw4V5dfb9yE2B8uqv5XDBnOPLuw7lU.CTTWkcxUfY8fPmT.6awap7e1bhMJuq7K2tf
 z.ANQQZlUPS.r69xqIffnoM8Ij8S42pai.0GX5ABluNPRTBuhqyktYdrchTVJreVPBmu09Zi9Jtl
 mAUqi4HOMOtbPCgjruaxW7mgqFKG1ejF2VUQwviHHoctlk3DSj8RhnpqgD4BFWphGyxsYT7NVrUJ
 PDhD4Rrzh_Gq3aZPTNmPRMo1CWIIUb1CZZXsMlVIJYnYlQGvisgR75mYS7i_4I2GMDiS1zAj7nPV
 Gudk_QU9massgxbPW.INMH6nKYT60K0JglnPHBlv4Iwub2uwJkaEDrSgNvSxETnVfUf0BTJTPWO.
 .vLQup705Sw1769CmhFHBJV2eRn2beLyh85jMN.ozZJgE2l6JbEaCjXFuq1tbQNZ0QYr7AWYFMbN
 A4x.r18KwhqiPnMT2tGnPoQ9ckoGdAisyg7l8ttfTifoVU.ymg45JF1rfseEDPcnSfTR4kOF.62T
 qiwvZEP97a1V68iwugUdStK4eotBcrWvNvr6.2x81qSTb5oLrVY04iL0NTFYaVkjhn6sNfRob_Ax
 y0IRJg56Y.3DmPsA2V9m5XmiApW98jp67gkwNPzUl6ghNUakmqpsbaRcLJAUjQGHIPrbJLoGGjuy
 RWlFmdbV2znawq9__thMPvbc9Ed8KuGP2V6xARWxdcKeSk9Fu4SkiFGZY.EcyGv9YCc37ISImLDw
 kNA0y1wL.rYLZ1wsw9la8h5.V_PxYEMBBDhKZjCX4iSBzxNwM9vJUS_BxdPnIXIVPsXNOZiVoUjw
 xW10K55U1UEnC6yKSs5GggaopcCrZoKApcTQZWtCRHZQggXqp_x.YMQ3jLFW1WpLkJELLebKwHy8
 ZdcCzuAOBoXUxnnAS..1c60YW.095YRXDDu_TDYm3jRRCiFUqr.5kDI4QKgZ.BgabmGlqGTEN3NS
 GEI9nml_OjRPcnnG_1mNBNXdk0KiLgEsg2TNv.b5fay3iIj2zWD_qFiwx8R7RFgBwklOYeK7uuwt
 feykvMS7sb_QF2v9RF3cyDDh9_iaLEtbUtvv_PW59YgD2zeZBmfTQApL8TJQfAPGHNO3uVnKX.Ph
 07mXqoByzOX_G9Ch3lbJtDyeiwWIWuIjUmwKPLc_xAJxUsARtHVBpkQgyXBsMwym3zF1GMpHlFCc
 askhCXGJ6GgK3EatiZECDC6ozxeSfctnDpVU7kdgdAc8byJ4-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: cb060bb5-7b4f-4303-803c-319b9a251aba
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Tue, 20 Jan 2026 16:26:43 +0000
Received: by hermes--production-ir2-6fcf857f6f-vw7gs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5c743ac7fc5feeb5bdbb197ea32f25e9;
          Tue, 20 Jan 2026 16:26:39 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v6 04/11] net: tunnel: allow noref dsts in udp_tunnel{,6}_dst_lookup
Date: Tue, 20 Jan 2026 17:24:44 +0100
Message-ID: <20260120162451.23512-5-mmietus97@yahoo.com>
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
	TAGGED_FROM(0.00)[bounces-251546-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: C070048D4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update udp_tunnel{,6}_dst_lookup to return noref dsts when possible.
This is done using a new boolean which indicates whether the returned
dst is noref. When the returned dst is noref, the dst is only valid
inside the RCU read-side critical section in which it was queried.

Update all callers to properly use the new noref argument and convert
all tunnels that use udp_tunnel{,6}_dst_lookup to noref. This affects
bareudp, geneve and vxlan tunnels.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 drivers/net/bareudp.c          | 30 ++++++++++++-----
 drivers/net/geneve.c           | 61 +++++++++++++++++++++++-----------
 drivers/net/vxlan/vxlan_core.c | 41 +++++++++++++++--------
 include/net/udp_tunnel.h       |  6 ++--
 net/ipv4/udp_tunnel_core.c     | 16 ++++++---
 net/ipv6/ip6_udp_tunnel.c      | 17 +++++++---
 6 files changed, 116 insertions(+), 55 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 92ee4a36f86f..1aa3d5d74a84 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -315,6 +315,7 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	int min_headroom;
 	__u8 tos, ttl;
 	__be32 saddr;
+	bool noref;
 	int err;
 
 	if (skb_vlan_inet_prepare(skb, skb->protocol != htons(ETH_P_TEB)))
@@ -329,7 +330,8 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	rt = udp_tunnel_dst_lookup(skb, dev, bareudp->net, 0, &saddr, &info->key,
 				   sport, bareudp->port, key->tos,
 				   use_cache ?
-				   (struct dst_cache *)&info->dst_cache : NULL);
+				   (struct dst_cache *)&info->dst_cache : NULL,
+				   &noref);
 
 	if (IS_ERR(rt))
 		return PTR_ERR(rt);
@@ -364,7 +366,8 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			    !net_eq(bareudp->net, dev_net(bareudp->dev)),
 			    !test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags),
 			    0);
-	ip_rt_put(rt);
+	if (!noref)
+		ip_rt_put(rt);
 	return 0;
 
 free_dst:
@@ -386,6 +389,7 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	int min_headroom;
 	__u8 prio, ttl;
 	__be16 sport;
+	bool noref;
 	int err;
 
 	if (skb_vlan_inet_prepare(skb, skb->protocol != htons(ETH_P_TEB)))
@@ -400,7 +404,8 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	dst = udp_tunnel6_dst_lookup(skb, dev, bareudp->net, sock, 0, &saddr,
 				     key, sport, bareudp->port, key->tos,
 				     use_cache ?
-				     (struct dst_cache *) &info->dst_cache : NULL);
+				     (struct dst_cache *)&info->dst_cache : NULL,
+				     &noref);
 	if (IS_ERR(dst))
 		return PTR_ERR(dst);
 
@@ -434,11 +439,13 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			     !test_bit(IP_TUNNEL_CSUM_BIT,
 				       info->key.tun_flags),
 			     0);
-	dst_release(dst);
+	if (!noref)
+		dst_release(dst);
 	return 0;
 
 free_dst:
-	dst_release(dst);
+	if (!noref)
+		dst_release(dst);
 	return err;
 }
 
@@ -507,6 +514,7 @@ static int bareudp_fill_metadata_dst(struct net_device *dev,
 	struct bareudp_dev *bareudp = netdev_priv(dev);
 	bool use_cache;
 	__be16 sport;
+	bool noref;
 
 	use_cache = ip_tunnel_dst_cache_usable(skb, info);
 	sport = udp_flow_src_port(bareudp->net, skb,
@@ -520,11 +528,13 @@ static int bareudp_fill_metadata_dst(struct net_device *dev,
 		rt = udp_tunnel_dst_lookup(skb, dev, bareudp->net, 0, &saddr,
 					   &info->key, sport, bareudp->port,
 					   info->key.tos,
-					   use_cache ? &info->dst_cache : NULL);
+					   use_cache ? &info->dst_cache : NULL,
+					   &noref);
 		if (IS_ERR(rt))
 			return PTR_ERR(rt);
 
-		ip_rt_put(rt);
+		if (!noref)
+			ip_rt_put(rt);
 		info->key.u.ipv4.src = saddr;
 	} else if (ip_tunnel_info_af(info) == AF_INET6) {
 		struct dst_entry *dst;
@@ -534,11 +544,13 @@ static int bareudp_fill_metadata_dst(struct net_device *dev,
 		dst = udp_tunnel6_dst_lookup(skb, dev, bareudp->net, sock,
 					     0, &saddr, &info->key,
 					     sport, bareudp->port, info->key.tos,
-					     use_cache ? &info->dst_cache : NULL);
+					     use_cache ? &info->dst_cache : NULL,
+					     &noref);
 		if (IS_ERR(dst))
 			return PTR_ERR(dst);
 
-		dst_release(dst);
+		if (!noref)
+			dst_release(dst);
 		info->key.u.ipv6.src = saddr;
 	} else {
 		return -EINVAL;
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 169a2b7d83e0..4d9c7ec29d40 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -766,7 +766,8 @@ static void geneve_build_header(struct genevehdr *geneveh,
 		ip_tunnel_info_opts_get(geneveh->options, info);
 }
 
-static int geneve_build_skb(struct dst_entry *dst, struct sk_buff *skb,
+static int geneve_build_skb(struct dst_entry *dst, bool noref,
+			    struct sk_buff *skb,
 			    const struct ip_tunnel_info *info,
 			    bool xnet, int ip_hdr_len,
 			    bool inner_proto_inherit)
@@ -797,7 +798,8 @@ static int geneve_build_skb(struct dst_entry *dst, struct sk_buff *skb,
 	return 0;
 
 free_dst:
-	dst_release(dst);
+	if (!noref)
+		dst_release(dst);
 	return err;
 }
 
@@ -831,6 +833,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 df = 0;
 	__be32 saddr;
 	__be16 sport;
+	bool noref;
 	int err;
 
 	if (skb_vlan_inet_prepare(skb, inner_proto_inherit))
@@ -849,7 +852,8 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 				   &info->key,
 				   sport, geneve->cfg.info.key.tp_dst, tos,
 				   use_cache ?
-				   (struct dst_cache *)&info->dst_cache : NULL);
+				   (struct dst_cache *)&info->dst_cache : NULL,
+				   &noref);
 	if (IS_ERR(rt))
 		return PTR_ERR(rt);
 
@@ -857,7 +861,8 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 				    GENEVE_IPV4_HLEN + info->options_len,
 				    netif_is_any_bridge_port(dev));
 	if (err < 0) {
-		dst_release(&rt->dst);
+		if (!noref)
+			dst_release(&rt->dst);
 		return err;
 	} else if (err) {
 		struct ip_tunnel_info *info;
@@ -868,7 +873,8 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 
 			unclone = skb_tunnel_info_unclone(skb);
 			if (unlikely(!unclone)) {
-				dst_release(&rt->dst);
+				if (!noref)
+					dst_release(&rt->dst);
 				return -ENOMEM;
 			}
 
@@ -877,13 +883,15 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		}
 
 		if (!pskb_may_pull(skb, ETH_HLEN)) {
-			dst_release(&rt->dst);
+			if (!noref)
+				dst_release(&rt->dst);
 			return -EINVAL;
 		}
 
 		skb->protocol = eth_type_trans(skb, geneve->dev);
 		__netif_rx(skb);
-		dst_release(&rt->dst);
+		if (!noref)
+			dst_release(&rt->dst);
 		return -EMSGSIZE;
 	}
 
@@ -916,7 +924,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		}
 	}
 
-	err = geneve_build_skb(&rt->dst, skb, info, xnet, sizeof(struct iphdr),
+	err = geneve_build_skb(&rt->dst, noref, skb, info, xnet, sizeof(struct iphdr),
 			       inner_proto_inherit);
 	if (unlikely(err))
 		return err;
@@ -926,7 +934,8 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			    !net_eq(geneve->net, dev_net(geneve->dev)),
 			    !test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags),
 			    0);
-	ip_rt_put(rt);
+	if (!noref)
+		ip_rt_put(rt);
 	return 0;
 }
 
@@ -944,6 +953,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	bool use_cache;
 	__u8 prio, ttl;
 	__be16 sport;
+	bool noref;
 	int err;
 
 	if (skb_vlan_inet_prepare(skb, inner_proto_inherit))
@@ -962,7 +972,8 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 				     &saddr, key, sport,
 				     geneve->cfg.info.key.tp_dst, prio,
 				     use_cache ?
-				     (struct dst_cache *)&info->dst_cache : NULL);
+				     (struct dst_cache *)&info->dst_cache : NULL,
+				     &noref);
 	if (IS_ERR(dst))
 		return PTR_ERR(dst);
 
@@ -970,7 +981,8 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 				    GENEVE_IPV6_HLEN + info->options_len,
 				    netif_is_any_bridge_port(dev));
 	if (err < 0) {
-		dst_release(dst);
+		if (!noref)
+			dst_release(dst);
 		return err;
 	} else if (err) {
 		struct ip_tunnel_info *info = skb_tunnel_info(skb);
@@ -980,7 +992,8 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 
 			unclone = skb_tunnel_info_unclone(skb);
 			if (unlikely(!unclone)) {
-				dst_release(dst);
+				if (!noref)
+					dst_release(dst);
 				return -ENOMEM;
 			}
 
@@ -989,13 +1002,15 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		}
 
 		if (!pskb_may_pull(skb, ETH_HLEN)) {
-			dst_release(dst);
+			if (!noref)
+				dst_release(dst);
 			return -EINVAL;
 		}
 
 		skb->protocol = eth_type_trans(skb, geneve->dev);
 		__netif_rx(skb);
-		dst_release(dst);
+		if (!noref)
+			dst_release(dst);
 		return -EMSGSIZE;
 	}
 
@@ -1009,7 +1024,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			ttl = key->ttl;
 		ttl = ttl ? : ip6_dst_hoplimit(dst);
 	}
-	err = geneve_build_skb(dst, skb, info, xnet, sizeof(struct ipv6hdr),
+	err = geneve_build_skb(dst, noref, skb, info, xnet, sizeof(struct ipv6hdr),
 			       inner_proto_inherit);
 	if (unlikely(err))
 		return err;
@@ -1020,7 +1035,8 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			     !test_bit(IP_TUNNEL_CSUM_BIT,
 				       info->key.tun_flags),
 			     0);
-	dst_release(dst);
+	if (!noref)
+		dst_release(dst);
 	return 0;
 }
 #endif
@@ -1083,6 +1099,7 @@ static int geneve_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 	struct ip_tunnel_info *info = skb_tunnel_info(skb);
 	struct geneve_dev *geneve = netdev_priv(dev);
 	__be16 sport;
+	bool noref;
 
 	if (ip_tunnel_info_af(info) == AF_INET) {
 		struct rtable *rt;
@@ -1104,11 +1121,13 @@ static int geneve_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 					   &info->key,
 					   sport, geneve->cfg.info.key.tp_dst,
 					   tos,
-					   use_cache ? &info->dst_cache : NULL);
+					   use_cache ? &info->dst_cache : NULL,
+					   &noref);
 		if (IS_ERR(rt))
 			return PTR_ERR(rt);
 
-		ip_rt_put(rt);
+		if (!noref)
+			ip_rt_put(rt);
 		info->key.u.ipv4.src = saddr;
 #if IS_ENABLED(CONFIG_IPV6)
 	} else if (ip_tunnel_info_af(info) == AF_INET6) {
@@ -1130,11 +1149,13 @@ static int geneve_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 		dst = udp_tunnel6_dst_lookup(skb, dev, geneve->net, gs6->sock, 0,
 					     &saddr, &info->key, sport,
 					     geneve->cfg.info.key.tp_dst, prio,
-					     use_cache ? &info->dst_cache : NULL);
+					     use_cache ? &info->dst_cache : NULL,
+					     &noref);
 		if (IS_ERR(dst))
 			return PTR_ERR(dst);
 
-		dst_release(dst);
+		if (!noref)
+			dst_release(dst);
 		info->key.u.ipv6.src = saddr;
 #endif
 	} else {
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 09ddf0586176..f01340b99e08 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2298,6 +2298,7 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 				 int addr_family,
 				 __be16 dst_port, int dst_ifindex, __be32 vni,
 				 struct dst_entry *dst,
+				 bool noref,
 				 u32 rt_flags)
 {
 #if IS_ENABLED(CONFIG_IPV6)
@@ -2313,7 +2314,8 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 	    vxlan->cfg.flags & VXLAN_F_LOCALBYPASS) {
 		struct vxlan_dev *dst_vxlan;
 
-		dst_release(dst);
+		if (!noref)
+			dst_release(dst);
 		dst_vxlan = vxlan_find_vni(vxlan->net, dst_ifindex, vni,
 					   addr_family, dst_port,
 					   vxlan->cfg.flags);
@@ -2346,6 +2348,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 	unsigned int pkt_len = skb->len;
 	__be16 src_port = 0, dst_port;
 	struct dst_entry *ndst = NULL;
+	bool noref = false;
 	int addr_family;
 	__u8 tos, ttl;
 	int ifindex;
@@ -2471,7 +2474,8 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 
 		rt = udp_tunnel_dst_lookup(skb, dev, vxlan->net, ifindex,
 					   &saddr, pkey, src_port, dst_port,
-					   tos, use_cache ? dst_cache : NULL);
+					   tos, use_cache ? dst_cache : NULL,
+					   &noref);
 		if (IS_ERR(rt)) {
 			err = PTR_ERR(rt);
 			reason = SKB_DROP_REASON_IP_OUTNOROUTES;
@@ -2485,7 +2489,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			/* Bypass encapsulation if the destination is local */
 			err = encap_bypass_if_local(skb, dev, vxlan, AF_INET,
 						    dst_port, ifindex, vni,
-						    &rt->dst, rt->rt_flags);
+						    &rt->dst, noref, rt->rt_flags);
 			if (err)
 				goto out_unlock;
 
@@ -2521,7 +2525,8 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 				unclone->key.u.ipv4.dst = saddr;
 			}
 			vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
-			dst_release(ndst);
+			if (!noref)
+				dst_release(ndst);
 			goto out_unlock;
 		}
 
@@ -2538,7 +2543,8 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 				    pkey->u.ipv4.dst, tos, ttl, df,
 				    src_port, dst_port, xnet, !udp_sum,
 				    ipcb_flags);
-		ip_rt_put(rt);
+		if (!noref)
+			ip_rt_put(rt);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
 		struct vxlan_sock *sock6;
@@ -2557,7 +2563,8 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		ndst = udp_tunnel6_dst_lookup(skb, dev, vxlan->net, sock6->sock,
 					      ifindex, &saddr, pkey,
 					      src_port, dst_port, tos,
-					      use_cache ? dst_cache : NULL);
+					      use_cache ? dst_cache : NULL,
+					      &noref);
 		if (IS_ERR(ndst)) {
 			err = PTR_ERR(ndst);
 			ndst = NULL;
@@ -2573,7 +2580,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 
 			err = encap_bypass_if_local(skb, dev, vxlan, AF_INET6,
 						    dst_port, ifindex, vni,
-						    ndst, rt6i_flags);
+						    ndst, noref, rt6i_flags);
 			if (err)
 				goto out_unlock;
 		}
@@ -2596,7 +2603,8 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			}
 
 			vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
-			dst_release(ndst);
+			if (!noref)
+				dst_release(ndst);
 			goto out_unlock;
 		}
 
@@ -2614,7 +2622,8 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 				     &saddr, &pkey->u.ipv6.dst, tos, ttl,
 				     pkey->label, src_port, dst_port, !udp_sum,
 				     ip6cb_flags);
-		dst_release(ndst);
+		if (!noref)
+			dst_release(ndst);
 #endif
 	}
 	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX, pkt_len);
@@ -2634,7 +2643,8 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		DEV_STATS_INC(dev, collisions);
 	else if (err == -ENETUNREACH)
 		DEV_STATS_INC(dev, tx_carrier_errors);
-	dst_release(ndst);
+	if (!noref)
+		dst_release(ndst);
 	DEV_STATS_INC(dev, tx_errors);
 	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX_ERRORS, 0);
 	kfree_skb_reason(skb, reason);
@@ -3222,6 +3232,7 @@ static int vxlan_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct ip_tunnel_info *info = skb_tunnel_info(skb);
 	__be16 sport, dport;
+	bool noref;
 
 	sport = udp_flow_src_port(dev_net(dev), skb, vxlan->cfg.port_min,
 				  vxlan->cfg.port_max, true);
@@ -3238,10 +3249,11 @@ static int vxlan_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 					   &info->key.u.ipv4.src,
 					   &info->key,
 					   sport, dport, info->key.tos,
-					   &info->dst_cache);
+					   &info->dst_cache, &noref);
 		if (IS_ERR(rt))
 			return PTR_ERR(rt);
-		ip_rt_put(rt);
+		if (!noref)
+			ip_rt_put(rt);
 	} else {
 #if IS_ENABLED(CONFIG_IPV6)
 		struct vxlan_sock *sock6 = rcu_dereference(vxlan->vn6_sock);
@@ -3254,10 +3266,11 @@ static int vxlan_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 					      0, &info->key.u.ipv6.src,
 					      &info->key,
 					      sport, dport, info->key.tos,
-					      &info->dst_cache);
+					      &info->dst_cache, &noref);
 		if (IS_ERR(ndst))
 			return PTR_ERR(ndst);
-		dst_release(ndst);
+		if (!noref)
+			dst_release(ndst);
 #else /* !CONFIG_IPV6 */
 		return -EPFNOSUPPORT;
 #endif
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 9acef2fbd2fd..ba53a71b90ec 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -153,7 +153,8 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 				     __be32 *saddr,
 				     const struct ip_tunnel_key *key,
 				     __be16 sport, __be16 dport, u8 tos,
-				     struct dst_cache *dst_cache);
+				     struct dst_cache *dst_cache,
+				     bool *noref);
 struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 					 struct net_device *dev,
 					 struct net *net,
@@ -161,7 +162,8 @@ struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 					 struct in6_addr *saddr,
 					 const struct ip_tunnel_key *key,
 					 __be16 sport, __be16 dport, u8 dsfield,
-					 struct dst_cache *dst_cache);
+					 struct dst_cache *dst_cache,
+					 bool *noref);
 
 struct metadata_dst *udp_tun_rx_dst(struct sk_buff *skb, unsigned short family,
 				    const unsigned long *flags,
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index b1f667c52cb2..978cd59281f6 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -233,16 +233,19 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 				     __be32 *saddr,
 				     const struct ip_tunnel_key *key,
 				     __be16 sport, __be16 dport, u8 tos,
-				     struct dst_cache *dst_cache)
+				     struct dst_cache *dst_cache,
+				     bool *noref)
 {
 	struct rtable *rt = NULL;
 	struct flowi4 fl4;
 
 #ifdef CONFIG_DST_CACHE
 	if (dst_cache) {
-		rt = dst_cache_get_ip4(dst_cache, saddr);
-		if (rt)
+		rt = dst_cache_get_ip4_rcu(dst_cache, saddr);
+		if (rt) {
+			*noref = true;
 			return rt;
+		}
 	}
 #endif
 
@@ -267,9 +270,12 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 		ip_rt_put(rt);
 		return ERR_PTR(-ELOOP);
 	}
+	*noref = false;
 #ifdef CONFIG_DST_CACHE
-	if (dst_cache)
-		dst_cache_set_ip4(dst_cache, &rt->dst, fl4.saddr);
+	if (dst_cache) {
+		dst_cache_steal_ip4(dst_cache, &rt->dst, fl4.saddr);
+		*noref = true;
+	}
 #endif
 	*saddr = fl4.saddr;
 	return rt;
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index d58815db8182..b166ba225551 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -126,6 +126,7 @@ EXPORT_SYMBOL_GPL(udp_tunnel6_xmit_skb);
  *      @dport: UDP destination port
  *      @dsfield: The traffic class field
  *      @dst_cache: The dst cache to use for lookup
+ *      @noref: Is the returned dst noref?
  *      This function performs a route lookup on a UDP tunnel
  *
  *      It returns a valid dst pointer and stores src address to be used in
@@ -140,16 +141,19 @@ struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 					 struct in6_addr *saddr,
 					 const struct ip_tunnel_key *key,
 					 __be16 sport, __be16 dport, u8 dsfield,
-					 struct dst_cache *dst_cache)
+					 struct dst_cache *dst_cache,
+					 bool *noref)
 {
 	struct dst_entry *dst = NULL;
 	struct flowi6 fl6;
 
 #ifdef CONFIG_DST_CACHE
 	if (dst_cache) {
-		dst = dst_cache_get_ip6(dst_cache, saddr);
-		if (dst)
+		dst = dst_cache_get_ip6_rcu(dst_cache, saddr);
+		if (dst) {
+			*noref = true;
 			return dst;
+		}
 	}
 #endif
 	memset(&fl6, 0, sizeof(fl6));
@@ -173,9 +177,12 @@ struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 		dst_release(dst);
 		return ERR_PTR(-ELOOP);
 	}
+	*noref = false;
 #ifdef CONFIG_DST_CACHE
-	if (dst_cache)
-		dst_cache_set_ip6(dst_cache, dst, &fl6.saddr);
+	if (dst_cache) {
+		dst_cache_steal_ip6(dst_cache, dst, &fl6.saddr);
+		*noref = true;
+	}
 #endif
 	*saddr = fl6.saddr;
 	return dst;
-- 
2.51.0


