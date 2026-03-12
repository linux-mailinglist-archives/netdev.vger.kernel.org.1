Return-Path: <netdev+bounces-267151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gH7zMIHmsmktQwAAu9opvQ
	(envelope-from <netdev+bounces-267151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:14:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D320275606
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B879F321275A
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DEE39937A;
	Thu, 12 Mar 2026 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LrUqYSsk"
X-Original-To: netdev@vger.kernel.org
Received: from sonic313-56.consmr.mail.ne1.yahoo.com (sonic313-56.consmr.mail.ne1.yahoo.com [66.163.185.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AC8373BF3
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331709; cv=none; b=IUFna2dj4gZiVV/LlQI3A9zT627F1hukIFXWlX1udOfdxyIGwhXHq6sk8XaZe+tYBcqiQB6ZGPtX7FH5nqId68GvetVYZIh0WIWKR1uflD073eJ2MVnXs+MrBUoFH/dA4cISUyK9e0qvRxT5z4YynF2iyB6i+Jc3m98Q4o0SOSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331709; c=relaxed/simple;
	bh=wpyJUNBKsvYeurbKQTfSq1mO12BUKOO9tIjWJmu40JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJLvhDJhMRGSTtvxqxucV9to/8SwG/wODVqymEfulQ/zA0CghH6QanQz38r7sIsheGAst2UHfzun+txMlyvOLJ3JvM8KqKUDXFJ6WVNIdOUFwNXj4ioroi8QyWyJvwMHcZZ78CSJbfm5VDKbnCsBhG6qwjHwvtM1BlPQY6vSrqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=LrUqYSsk; arc=none smtp.client-ip=66.163.185.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773331700; bh=8pN2NU997heflxGzHlEBMJhOCHPJpVnqFv3ppnrmmUA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=LrUqYSsku53M2DmQvoNO06bXxGwPejti6xEQ+HAQcdyvfdaJLbz9hvJ8s/D3OKhD2CiNX8I43Rxi1zTy+eYP/PJtu33rUjgm6EZj/EHXVK1nQjp3HfWmZdssLj0Fx+Z290BwEiRBQTi1OonPZh+8NyVAvyeil47YO32lW1tT/LjNpbsA88RlQBXA59hE5cA5NyD6OS6w2NSvUKf8WFGGvR9H6nbSf5EnL+VNLzPj351KkQhRq45Lgm+XpyGTIeuWIzuQftFR4sUSBo1ildL2K6Rnjy9W5WFyoOHIeTcLKaA1vFWkkqj9kv7dGuJ0AKqFIIA1DDZf9KHrrADtxLSylQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773331700; bh=fV0aZ3fN6hpk/nUcP37EaEedhq8ed9DvBQZxlLE9eDj=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=kzzVLLQY+VGORBwXFlN27QpC4BDbJlhDMzBwp9OlorYiTOdA9rqWXNX79sj5Up1hVbMwca5idYEZeZqWcq9q94H2VNr3aubgFqtNAZJpd0pBMkxr8VzZT31JNLsSpDNExSqlGZIjQo3a8aq7QNJZxfunzxWx0/ceiP2EWPw1EeXU3LJWNYRzu4qZQX4aJK+8Rrv9qCYC4AR0ivAzkD+V2kOSI3yOMv5K8RjqhVC0zMRbNllauvGSdviiNJZFbWAVKGXOvoi7KXOr3KfZhns2wuO0nG/AhKYkpUorIHBysPr5wWvqHF5dZq+vK42n2qKVWUGgzk1oN+AZu7KonWj92A==
X-YMail-OSG: OsQ7Tw4VM1kaLTU9NjNbnpsX1Sho0lT80V47ynBc3GAjbSAS3eRGQIJY7jz2MzN
 Dcd1B3KR.dKlTWX8xEojtWOE9lacPkiMxDt.T6eg9znyh9m9mvyTW63__amuBdYSHXtmjNrwW5pH
 Gr2fXpFNNK7AEN0Y7khw1Qio7qA8E4eYSr_LjruUGLNGzkHuxmrxiEQoU1BewQ1g3rDAiC4Fhb82
 QwexyJQjmSgLbrZDWk55TwYMzy.97lmIggT.C6Fn5CbmYiNAnrxp4vzWe.nuOOveANoowuMhMX4o
 3HbrxV0fQhVF2kFCRlR86rite9ikdwX.HbJ39DrI9hInvcSv17C48fJud_gtzDaMTSGf17zuXslc
 rmvsd6Qc17xDlcxnWYG4AsKmAHqIydhXrJvaYYnkfwDGGE3Hi3jVc9bdzp8M2yBkDtLHUVivsFBK
 .y_Y2TGtHtFH_XuD8PDlrs8PY0QKXZS8MtrC5mZlbnt1Xe4FuECOrbDi.e2TQ4b2.xPqtshKsU.9
 lGzUDWNGKAdv9vFYlv76yaz0fgP7AP4.J2h6QIfegZrNkH_x8rfpIWcCkh2ERrm35VN3GVPBuVGZ
 tFQBGwQmxMXVH6ioOeu7vSdSEaYqGRODZhIu0ev7aMsGk6E1V1wGczEv1SBsAuD2AuuAgFfSaAHN
 yAlzJQ5Kd8TtfMmUDbMzmSK1CDI3bBIBWjc_eY9ST3t7YVpF60UcNw4UN3_g6Kk8pteVcx271KWG
 T59Jcpr7mlvLwpGKfax9zTlu3kNa2tMzhETIsXPbJnHH4jPAGWxFobazsgQH1hxc0f2cE3riklM8
 rjzkb1OkPTezYsOJD.ragOicWHPeutywHfM5SY10ZWLX_7_XvaDzEJFgKxxk_GyZA04qAkez.xdA
 QUhxlvdl2kF0ODiZVLKlScx59J.RNk99zxTBv5yhirw0lNTO3NINborSRnBsGEeSF1KV_5P.8yN4
 G9PmSv05kmWJCpJe7tqntnUWe2Y0lEjCTU3PiI_7hpwBW0lTsUY8Dd8tFzVxbQRwsmdqsrTzsPbU
 eALXZgPQjkxgWx7zTzUFwsjvpzGNXCTywgnARMhXoQYgDxbSG4oHIz2wdmmfl6h1WPsRYF5G08Ya
 RSsKHA89EiYpPuxlOclal02GddVlSYLGpMBIaeDqk1ldkjCGmXo0Z5YYAD.7KeCa5ftdpEKK.BQP
 1kq5WMPHw1YbSH6QbWxIce6mS8GCYeoYPa7o3qNdYD6RH5JudPvf1NBa_umlJXdBTAI2LMjizLZF
 9FbfNCJFdk_Tcp0XIlPGHHXcEarHsPf7vnyPDI3UocK5uJS8k631EdPa4gYhEWJMJY_i9ulIkAZf
 i7f2udvmFnoEpo8_wZh2UvwLy9S36brLC8v9RZ7TJUkWibzRZyImINp4VAkv8c5aTdRs8GZq_mX9
 6tzeOmWOZySgcv15YKHsh47C9E16N6mndxurAgAcQM8QCSdO8z5mPO2O6vi2.FBW1j71fMyn_sse
 g0gwGFN1Sw2ZNmn0vaQvgFjKLcD3cU.mWRPuU0wTQX2PiJ6n46WA.gdszoIUv40u8aCFIyWno7wm
 gs6HM1e3zEUUzfUhf24bijSzbV3Pjm.Ugk8tk_eaeTajwB0cILH0vs8qb_Yf_.iQLufbY_LUz4FC
 K6gCkiJQ_z59hbWIsNYrVa_pqpOEOvrUpblzJw1uaFbTzHvg3N5lz7a1PyxrbkbgIQzJNmzMWRsu
 BPgyIRpKBP5vnuCaWWeqKq1dbglJQkdyQLeeRy0591GYD.UIhsPyMQbN9LPcmWlg2aHmvKP0BbbV
 bnuzCSGKXEYw1uIIFLI2AXDPWrWDbR1n_XnCHX3Cw9keM5xbpnBJfPJvurPjG_mrXOrdeHFWQFzB
 r5d2g.7smxakaRXstczI2Ifyws9Ytnq97qEVY.CWqruGfgCHnGln180WtuuUfZenZLqlYr__TtUG
 rjvjiqvCg3o7AFqCZtKuwquycfFCgaS0Ct_q8ZwmZ24UXOqq5UjoX5z_zXRL9v_rWMyiz_jP9ots
 epd1tCpGdVMZLvYE1XmacpugQEqRwPJ7mjY2wuo2Yvc2GN.zGJhpLAmfGw4lTmvDA9D6em.1ixwK
 tWMUcYDKbUrGzhi8mx1DrUUd2BLpYqpd3V3ER6nJF0t4WhCuNevzncMauOnUaqAQKYID7_obXXRe
 .rmM8DpaAmoIDDtTNJeU8kZ3L2SWlFw3tJSCoMyRzj.w6YSC8jM1E78D.XNV.
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 5186333f-69cd-47bf-aeb3-de6ecaef8229
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Mar 2026 16:08:20 +0000
Received: by hermes--production-ir2-bbcfb4457-pgdzr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 87d652406d88cc03e8e5278a11075b9d;
          Thu, 12 Mar 2026 15:58:06 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v8 03/11] net: tunnel: convert udp_tunnel{6,}_xmit_skb to noref
Date: Thu, 12 Mar 2026 16:56:49 +0100
Message-ID: <20260312155657.25676-4-mmietus97@yahoo.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zx2c4.com,yahoo.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-267151-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6D320275606
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

udp_tunnel{6,}_xmit_skb assume that a reference was taken on the dst
passed to them, and use that reference.

This forces callers to reference the dst, preventing noref optimizations.

Convert udp_tunnel{6,}_xmit_skb to be noref and drop the requirement
that a ref be taken on the dst.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 drivers/net/amt.c              | 3 +++
 drivers/net/bareudp.c          | 2 ++
 drivers/net/geneve.c           | 2 ++
 drivers/net/gtp.c              | 7 +++++++
 drivers/net/ovpn/udp.c         | 2 ++
 drivers/net/vxlan/vxlan_core.c | 2 ++
 drivers/net/wireguard/socket.c | 2 ++
 net/ipv4/udp_tunnel_core.c     | 3 ---
 net/ipv6/ip6_udp_tunnel.c      | 2 +-
 net/sctp/ipv6.c                | 3 +++
 net/sctp/protocol.c            | 4 ++++
 net/tipc/udp_media.c           | 2 ++
 12 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index f2f3139e38a5..a9fd2b864a1a 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -1050,6 +1050,7 @@ static bool amt_send_membership_update(struct amt_dev *amt,
 			    false,
 			    false,
 			    0);
+	ip_rt_put(rt);
 	amt_update_gw_status(amt, AMT_STATUS_SENT_UPDATE, true);
 	return false;
 }
@@ -1108,6 +1109,7 @@ static void amt_send_multicast_data(struct amt_dev *amt,
 			    false,
 			    false,
 			    0);
+	ip_rt_put(rt);
 }
 
 static bool amt_send_membership_query(struct amt_dev *amt,
@@ -1167,6 +1169,7 @@ static bool amt_send_membership_query(struct amt_dev *amt,
 			    false,
 			    false,
 			    0);
+	ip_rt_put(rt);
 	amt_update_relay_status(tunnel, AMT_STATUS_SENT_QUERY, true);
 	return false;
 }
diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 0df3208783ad..92ee4a36f86f 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -364,6 +364,7 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			    !net_eq(bareudp->net, dev_net(bareudp->dev)),
 			    !test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags),
 			    0);
+	ip_rt_put(rt);
 	return 0;
 
 free_dst:
@@ -433,6 +434,7 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			     !test_bit(IP_TUNNEL_CSUM_BIT,
 				       info->key.tun_flags),
 			     0);
+	dst_release(dst);
 	return 0;
 
 free_dst:
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 01cdd06102e0..4216a8ffd591 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1396,6 +1396,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			    !net_eq(geneve->net, dev_net(geneve->dev)),
 			    !test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags),
 			    0);
+	ip_rt_put(rt);
 	return 0;
 }
 
@@ -1487,6 +1488,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			     !test_bit(IP_TUNNEL_CSUM_BIT,
 				       info->key.tun_flags),
 			     0);
+	dst_release(dst);
 	return 0;
 }
 #endif
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index e8949f556209..09b774eed6c7 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -449,6 +449,7 @@ static int gtp0_send_echo_resp_ip(struct gtp_dev *gtp, struct sk_buff *skb)
 				    dev_net(gtp->dev)),
 			    false,
 			    0);
+	ip_rt_put(rt);
 
 	return 0;
 }
@@ -708,6 +709,7 @@ static int gtp1u_send_echo_resp(struct gtp_dev *gtp, struct sk_buff *skb)
 				    dev_net(gtp->dev)),
 			    false,
 			    0);
+	ip_rt_put(rt);
 	return 0;
 }
 
@@ -1308,6 +1310,7 @@ static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 				    !net_eq(sock_net(pktinfo.pctx->sk),
 					    dev_net(dev)),
 				    false, 0);
+		ip_rt_put(pktinfo.rt);
 		break;
 	case AF_INET6:
 #if IS_ENABLED(CONFIG_IPV6)
@@ -1318,6 +1321,7 @@ static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 				     0,
 				     pktinfo.gtph_port, pktinfo.gtph_port,
 				     false, 0);
+		dst_release(&pktinfo.rt6->dst);
 #else
 		goto tx_err;
 #endif
@@ -2400,6 +2404,7 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 		return -ENODEV;
 	}
 
+	rcu_read_lock();
 	udp_tunnel_xmit_skb(rt, sk, skb_to_send,
 			    fl4.saddr, fl4.daddr,
 			    inet_dscp_to_dsfield(fl4.flowi4_dscp),
@@ -2409,6 +2414,8 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 			    !net_eq(sock_net(sk),
 				    dev_net(gtp->dev)),
 			    false, 0);
+	rcu_read_unlock();
+	ip_rt_put(rt);
 	return 0;
 }
 
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 272b535ecaad..2e202bd2b73f 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -200,6 +200,7 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	udp_tunnel_xmit_skb(rt, sk, skb, fl.saddr, fl.daddr, 0,
 			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
 			    fl.fl4_dport, false, sk->sk_no_check_tx, 0);
+	ip_rt_put(rt);
 	ret = 0;
 err:
 	local_bh_enable();
@@ -275,6 +276,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	udp_tunnel6_xmit_skb(dst, sk, skb, skb->dev, &fl.saddr, &fl.daddr, 0,
 			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
 			     fl.fl6_dport, udp_get_no_check6_tx(sk), 0);
+	dst_release(dst);
 	ret = 0;
 err:
 	local_bh_enable();
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 17c941aac32d..4482a47dbe15 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2545,6 +2545,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 				    pkey->u.ipv4.dst, tos, ttl, df,
 				    src_port, dst_port, xnet, !udp_sum,
 				    ipcb_flags);
+		ip_rt_put(rt);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
 		struct vxlan_sock *sock6;
@@ -2620,6 +2621,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 				     &saddr, &pkey->u.ipv6.dst, tos, ttl,
 				     pkey->label, src_port, dst_port, !udp_sum,
 				     ip6cb_flags);
+		dst_release(ndst);
 #endif
 	}
 	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX, pkt_len);
diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.c
index 253488f8c00f..ee7d9c675909 100644
--- a/drivers/net/wireguard/socket.c
+++ b/drivers/net/wireguard/socket.c
@@ -85,6 +85,7 @@ static int send4(struct wg_device *wg, struct sk_buff *skb,
 	udp_tunnel_xmit_skb(rt, sock, skb, fl.saddr, fl.daddr, ds,
 			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
 			    fl.fl4_dport, false, false, 0);
+	ip_rt_put(rt);
 	goto out;
 
 err:
@@ -152,6 +153,7 @@ static int send6(struct wg_device *wg, struct sk_buff *skb,
 	udp_tunnel6_xmit_skb(dst, sock, skb, skb->dev, &fl.saddr, &fl.daddr, ds,
 			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
 			     fl.fl6_dport, false, 0);
+	dst_release(dst);
 	goto out;
 
 err:
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 8a91f36cc052..b1f667c52cb2 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -190,11 +190,8 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 
 	udp_set_csum(nocheck, skb, src, dst, skb->len);
 
-	rcu_read_lock();
 	iptunnel_xmit(sk, rt, skb, src, dst, IPPROTO_UDP, tos, ttl, df, xnet,
 		      ipcb_flags);
-	rcu_read_unlock();
-	ip_rt_put(rt);
 }
 EXPORT_SYMBOL_GPL(udp_tunnel_xmit_skb);
 
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index cef3e0210744..d58815db8182 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -95,7 +95,7 @@ void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 
 	uh->len = htons(skb->len);
 
-	skb_dst_set(skb, dst);
+	skb_dst_set_noref(skb, dst);
 
 	udp6_set_csum(nocheck, skb, saddr, daddr, skb->len);
 
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 53a5c027f8e3..43340eac8ec5 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -261,9 +261,12 @@ static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
 	label = ip6_make_flowlabel(sock_net(sk), skb, fl6->flowlabel, true, fl6);
 
+	rcu_read_lock();
 	udp_tunnel6_xmit_skb(dst, sk, skb, NULL, &fl6->saddr, &fl6->daddr,
 			     tclass, ip6_dst_hoplimit(dst), label,
 			     sctp_sk(sk)->udp_port, t->encap_port, false, 0);
+	rcu_read_unlock();
+	dst_release(dst);
 	return 0;
 }
 
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 828a59b8e7bf..815279410bf9 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1070,10 +1070,14 @@ static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_reset_inner_mac_header(skb);
 	skb_reset_inner_transport_header(skb);
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
+
+	rcu_read_lock();
 	udp_tunnel_xmit_skb(dst_rtable(dst), sk, skb, fl4->saddr,
 			    fl4->daddr, dscp, ip4_dst_hoplimit(dst), df,
 			    sctp_sk(sk)->udp_port, t->encap_port, false, false,
 			    0);
+	rcu_read_unlock();
+	dst_release(dst);
 	return 0;
 }
 
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 2b8e385d1e51..df0d82fed02e 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -198,6 +198,7 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 		udp_tunnel_xmit_skb(rt, ub->ubsock->sk, skb, src->ipv4.s_addr,
 				    dst->ipv4.s_addr, 0, ttl, 0, src->port,
 				    dst->port, false, true, 0);
+		ip_rt_put(rt);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
 		if (!ndst) {
@@ -220,6 +221,7 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 		udp_tunnel6_xmit_skb(ndst, ub->ubsock->sk, skb, NULL,
 				     &src->ipv6, &dst->ipv6, 0, ttl, 0,
 				     src->port, dst->port, false, 0);
+		dst_release(ndst);
 #endif
 	}
 	local_bh_enable();
-- 
2.51.0


