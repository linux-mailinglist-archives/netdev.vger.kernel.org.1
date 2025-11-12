Return-Path: <netdev+bounces-237871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61374C50FC8
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 08:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B65D3AB960
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 07:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D73A2C2357;
	Wed, 12 Nov 2025 07:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="po6VYVL7"
X-Original-To: netdev@vger.kernel.org
Received: from sonic306-47.consmr.mail.ne1.yahoo.com (sonic306-47.consmr.mail.ne1.yahoo.com [66.163.189.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0E1285C91
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 07:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762933248; cv=none; b=jki4dCkmGIgzEHlEXHsCOLKotusvD/Tsli9LKmAwDKEf6xmjdYzVKbJnzH3MSqLu350ihS5k43BhhR2lZSOR8zCJG3sChF5j9g3yyyNb5EFFaACHljua9B5I/roK+S+GNcMSqhyRY5npSppEtL4eKD+/X5rk0CRKV7DpistuehE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762933248; c=relaxed/simple;
	bh=1UtgLw7gOO+fYSXoy8rj72+TiyRKjxp5FxJpsTB7gqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FAzF3cm8GLCfbdgWANfXtUMKLDZ6GEsCwTCS94ggGXJ915cT4xecJ0T0E25xTnhJqsECN+QTSdhhK1a+RLKndDGC+Jv9NrZH8UTq+2SH2m51Z1XIWDq7s6mlMqwN7ULl/3yCUMwCMoWQSbfpV5yhQVZRYuZAJ+k5MDIOZyRd83Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=po6VYVL7; arc=none smtp.client-ip=66.163.189.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762933245; bh=2npYkrrX09nRuPCRqUxNcTzvASoivQM/9znl8RxG3e4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=po6VYVL7ORVw/cORlgHl4fHeYt3hgeCcVNnos9f2hSUHu1/ev5Q1mg62xO9AyB3PuGl2fWe3Nxd0+L77WQvEeaxVbxS/mqZUlMponoWdWE5cq95GutLa1RCQKY4YGaiHqcPISAXMw99myCGelB9ttG5T+0gkPL+O3ERk+Ujn3grKsZ9bIYAUql9dUQFVv2LYfF2WdZsESfGNKIqKaQkBHF5aG17Vjb69L5oFHwdDLeV4BGUWDJQ1Hse3R4Vgc5iG8RfbWb+TBms2Ud9nmWcTyivYgyJ/5vu8M8XYg2HuDYrZc0TDcnNfSoEiay/CdcOJD6gKDEnHu6kpan6VNAQgVw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762933245; bh=bJyyF0q3QOZYfk/YVCpk2A4qT+2H/hipLChmlRL5Kp8=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=jc1gXtamO6PinHy/8Dj7HsMtKqESv1Rx4vhYrllJ/flYhbRnDFGTOq0AZwt2uRLMSS/bLsVDxdRha9w+hN2aBsclaeP3M0eWJUK3uSy6ab7ZW70EtcElMLmg+d4+3YCL8barv4vNb0HGhq/ZDE7yef1c3i+qPl+KEOP8Rt4Q2T4J4fgu1UcblJc6OYMFF32Yxq6hZDzXVEl56VAAS3FaVfKpbu/nfZ/+lNVFQ1D8gjZnzVIODHfSJqUKjiFT0B1CkLtXYXYsTIbUCQu2D++RgsPNdIdLuohYCX9JFoEof1TZhi2TjDnmkSjUg/Ibog5j18mCZWDpmW2G1sT3UJ1dmw==
X-YMail-OSG: s3cMtfoVM1nnKqGZ6rMGvebXahQfNrVuMQu0HcsEDeSnaKiKJgwpzCDg2Rx0KoK
 hnK7oAHH6jSONvUFldJJtiEJBGUzFEUPjhXv63ieA8Jx10gWE_LUWAH97dtI1IQKORw4yBpFrxDH
 6s1aw6xUT3AeG7LDjzKLIqNoblzFDJg3fFtKLzZbJZONxXqQTaE3WbPEdp4S94SDYwDxqCXTez0w
 PKaiGyFhTG3R3DMSkKAXGzl6A71eX9ID0AHjF0SicqZOk9s4AeD3_EozIDeVPAkPs7jYVf9GOB5.
 VbGzHsWa989n05GPR6qGPAQzbU86KirPpyJr7nKQd.RRgvckmkc90I0A5LyaMwJV.4KBAEaKj63I
 5VfjZcQVEzJgw4tLD7UlbQud0mw3DfdX_VjZIXUT43C6FoqG2EBNp1CsoefudiB949Riz1mrrKHt
 FMHfXMI2bmh6KvWaT_VFb6pcYztG3_HnVWpse4QAsv2k31f4dDS_A6w5bJDIbw_pBodgJUH9.G7O
 FxqT.hrnhjvH.iXoeVrXfXH24ZwYClF_9W.Y12yS3vOMhIdSxMrMqSTr6ExVo80sQSOXlqL7beOx
 dNNZ7hGCe6M8p5e2urbRvRJNu65.HVg24fxC8rEJnlx11OqXDWVwWkV1ut66yaaC6zLRLKpKIgHu
 3v715b5qOcWnalrT0OOkN6VNDipVwYGxEfkQz39gRovRDQ2EaIQiTeudPQK9DS1rxasv4FTLffGX
 6r4W0VsX3huMNeDgvJYVXai_KKIgOF10on6l3mah30dABo7VtuJ8kh5UmwltS8xqivd7p8.AewrF
 H0J6H2IabvazC_LhNOYWm.dgzb3.MMXJCX7D.pLJ6GxkbGZIIm3pvsUGHTcX4PdxXblU7aOFNhI_
 7C3ORsexCTxMQ9oD_O6dOtgk56gZBa5rCmi1wF7JyE3JvoyF8l9OY2GUPcNlOcRBLTWsKR1y10ka
 5aOsuS_bLrVl.SKLeWCol5gcUJXJtidFh_nScNlQRqtSbh8qUx3e4M.oB7CmpBKCPQPqGbV7VdO4
 xjBSL0tKlM0lx_3mgqUrzxwcRTw2_9rS7._uQ7X_fy8zeZG_EkYtK0hw57TghEAG9wLxz5paPP.j
 9Qyn1uuTAyFjwhBr_pWDKsDv4DxdUGg_RSck_tgfzMKDFsrjr0NzI7Il5wSEqj9ly_sYRLsG3m5V
 988RivfAWZp9g8Gs_6ZsSL6xSH_YL47Nnq0ITUkLEj5YOZA1IUjGE7KS7Yf0Tb8pp_9qc8eFdFSy
 mukmGAO.LlfBL3oqHIUF7Cb4bB1WEWLFkD5amiTokFPMR6PT1KmDEaC6heUljbll50VM0xx4S.XK
 g.oy7Fuq1ZZQjO_fjvPZALAagUSd8S4rXhhja3UTCzwrWTp.Zt6tKzxecACg477_MXFiyOsPqMQD
 Tny3CvyE6vKQrwLqqTnpDrz5v79qgaTaX5Qd7SroGHfmJurnLYxVH76bDOWU_1B0B_PJjrvgdmc6
 idcWSjC7h6pHtW7inM98VyN3i_ZZYx9SvoRRBqenXaLOaMe1n43P4ifnHVoWaTrUGKC7WgLo6LAc
 ZtvAq.NCYJGjmkiC1VfZITt9PE3r8VDO7_ohoQcS6Byh_BeZEkF4EpwJfvUrtBpmg3aHggKxfcgr
 h54Z4OOMLt6G7TjvgdlIeQ9N63LOtEP3ScEHYC0hyaMdfX7kwBZZk5HIWtIXcvj0Fmy5HNXLSDlm
 zaFvQbd8r.2QkWwFbsc4Wm9DvaHEV19niNi8ZMGhn4nDu9rhllvibT4He5fb9INX6ezQ2PvsrNQj
 YXJDKWy06FT3qvtqflNk94WhyQQcQL5MG8.QXEmBiwsuewaEX1CbFP4q9lhM.xbxYzWsQmHybv4c
 OzhW74318HeJjrnyKMU_SrhdR6reTVY0uUIwv0wAHQ7X7D_erj3PNbyuUGGkg7QUpwMAsvC3poPQ
 ScsdGpTxL8lED2AlSqKlfbHCOvaqJCIjVomUeK0qgN2G2TiBrjcTzCQDwjEKxBlNY6p5DHNJGHXP
 Zv4az_phfCKPw3kjroqw2DBd.5quGjKr1op27rckuN1H2aeeC81.xSmByzRZD33bHc6GdIoFXY6d
 IcfcQauD.2WmvJ5CKJIbTjXRJm0yVZGDI8Cvxw0Leq_AIcxQYFCrwZD4TCMRmQF3mKASWUtzW9Ca
 PVi5Nw2VY0I1SYo3IUDYbC6cWMQqEPK81_LUok7t_eV2QS4.sklGbxIULBhPBCiaigOWHdW4wfbT
 pvNPvwPM-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 37b18ee8-d70f-4a89-8e4e-0afc113d1991
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 12 Nov 2025 07:40:45 +0000
Received: by hermes--production-ir2-5fcfdd8d7f-2cnbk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ce2e5d13638178c4daec60c4681fbbb6;
          Wed, 12 Nov 2025 07:28:32 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v4 05/14] net: tunnel: use dstref in ip and udp tunnel xmit functions
Date: Wed, 12 Nov 2025 08:27:11 +0100
Message-ID: <20251112072720.5076-6-mmietus97@yahoo.com>
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

Update iptunnel_xmit and udp{,6}_tunnel_xmit_skb to use dstref
instead of dst_entry/rtable when specifying the destination of
the skb.

This allows passing potentially noref dsts to tunnel xmit functions,
which previously only accepted referenced dsts. This change does not
add any new noref xmit flows.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 drivers/net/amt.c              |  6 +++---
 drivers/net/bareudp.c          |  4 ++--
 drivers/net/geneve.c           |  7 ++++---
 drivers/net/gtp.c              | 10 +++++-----
 drivers/net/ovpn/udp.c         |  4 ++--
 drivers/net/vxlan/vxlan_core.c |  4 ++--
 drivers/net/wireguard/socket.c |  4 ++--
 include/net/ip_tunnels.h       |  2 +-
 include/net/udp_tunnel.h       |  4 ++--
 net/ipv4/ip_tunnel.c           |  4 ++--
 net/ipv4/ip_tunnel_core.c      |  9 +++++----
 net/ipv4/udp_tunnel_core.c     |  4 ++--
 net/ipv6/ip6_udp_tunnel.c      |  4 ++--
 net/ipv6/sit.c                 |  2 +-
 net/sctp/ipv6.c                |  2 +-
 net/sctp/protocol.c            |  2 +-
 net/tipc/udp_media.c           |  4 ++--
 17 files changed, 39 insertions(+), 37 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 902c817a0dea..2fe0937a372c 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -1039,7 +1039,7 @@ static bool amt_send_membership_update(struct amt_dev *amt,
 		skb_set_inner_protocol(skb, htons(ETH_P_IP));
 	else
 		skb_set_inner_protocol(skb, htons(ETH_P_IPV6));
-	udp_tunnel_xmit_skb(rt, sock->sk, skb,
+	udp_tunnel_xmit_skb(dst_to_dstref(&rt->dst), sock->sk, skb,
 			    fl4.saddr,
 			    fl4.daddr,
 			    AMT_TOS,
@@ -1097,7 +1097,7 @@ static void amt_send_multicast_data(struct amt_dev *amt,
 		skb_set_inner_protocol(skb, htons(ETH_P_IP));
 	else
 		skb_set_inner_protocol(skb, htons(ETH_P_IPV6));
-	udp_tunnel_xmit_skb(rt, sock->sk, skb,
+	udp_tunnel_xmit_skb(dst_to_dstref(&rt->dst), sock->sk, skb,
 			    fl4.saddr,
 			    fl4.daddr,
 			    AMT_TOS,
@@ -1156,7 +1156,7 @@ static bool amt_send_membership_query(struct amt_dev *amt,
 		skb_set_inner_protocol(skb, htons(ETH_P_IP));
 	else
 		skb_set_inner_protocol(skb, htons(ETH_P_IPV6));
-	udp_tunnel_xmit_skb(rt, sock->sk, skb,
+	udp_tunnel_xmit_skb(dst_to_dstref(&rt->dst), sock->sk, skb,
 			    fl4.saddr,
 			    fl4.daddr,
 			    AMT_TOS,
diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 0df3208783ad..813866cd04db 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -359,7 +359,7 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		goto free_dst;
 
 	skb_set_inner_protocol(skb, bareudp->ethertype);
-	udp_tunnel_xmit_skb(rt, sock->sk, skb, saddr, info->key.u.ipv4.dst,
+	udp_tunnel_xmit_skb(dst_to_dstref(&rt->dst), sock->sk, skb, saddr, info->key.u.ipv4.dst,
 			    tos, ttl, df, sport, bareudp->port,
 			    !net_eq(bareudp->net, dev_net(bareudp->dev)),
 			    !test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags),
@@ -427,7 +427,7 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		goto free_dst;
 
 	daddr = info->key.u.ipv6.dst;
-	udp_tunnel6_xmit_skb(dst, sock->sk, skb, dev,
+	udp_tunnel6_xmit_skb(dst_to_dstref(dst), sock->sk, skb, dev,
 			     &saddr, &daddr, prio, ttl,
 			     info->key.label, sport, bareudp->port,
 			     !test_bit(IP_TUNNEL_CSUM_BIT,
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 77b0c3d52041..0c7949c0561f 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -921,8 +921,9 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	if (unlikely(err))
 		return err;
 
-	udp_tunnel_xmit_skb(rt, gs4->sock->sk, skb, saddr, info->key.u.ipv4.dst,
-			    tos, ttl, df, sport, geneve->cfg.info.key.tp_dst,
+	udp_tunnel_xmit_skb(dst_to_dstref(&rt->dst), gs4->sock->sk, skb, saddr,
+			    info->key.u.ipv4.dst, tos, ttl, df, sport,
+			    geneve->cfg.info.key.tp_dst,
 			    !net_eq(geneve->net, dev_net(geneve->dev)),
 			    !test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags),
 			    0);
@@ -1013,7 +1014,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	if (unlikely(err))
 		return err;
 
-	udp_tunnel6_xmit_skb(dst, gs6->sock->sk, skb, dev,
+	udp_tunnel6_xmit_skb(dst_to_dstref(dst), gs6->sock->sk, skb, dev,
 			     &saddr, &key->u.ipv6.dst, prio, ttl,
 			     info->key.label, sport, geneve->cfg.info.key.tp_dst,
 			     !test_bit(IP_TUNNEL_CSUM_BIT,
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 5cb59d72bc82..1db34e7dbf0e 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -439,7 +439,7 @@ static int gtp0_send_echo_resp_ip(struct gtp_dev *gtp, struct sk_buff *skb)
 		return -1;
 	}
 
-	udp_tunnel_xmit_skb(rt, gtp->sk0, skb,
+	udp_tunnel_xmit_skb(dst_to_dstref(&rt->dst), gtp->sk0, skb,
 			    fl4.saddr, fl4.daddr,
 			    iph->tos,
 			    ip4_dst_hoplimit(&rt->dst),
@@ -698,7 +698,7 @@ static int gtp1u_send_echo_resp(struct gtp_dev *gtp, struct sk_buff *skb)
 		return -1;
 	}
 
-	udp_tunnel_xmit_skb(rt, gtp->sk1u, skb,
+	udp_tunnel_xmit_skb(dst_to_dstref(&rt->dst), gtp->sk1u, skb,
 			    fl4.saddr, fl4.daddr,
 			    iph->tos,
 			    ip4_dst_hoplimit(&rt->dst),
@@ -1299,7 +1299,7 @@ static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	switch (pktinfo.pctx->sk->sk_family) {
 	case AF_INET:
-		udp_tunnel_xmit_skb(pktinfo.rt, pktinfo.sk, skb,
+		udp_tunnel_xmit_skb(dst_to_dstref(&pktinfo.rt->dst), pktinfo.sk, skb,
 				    pktinfo.fl4.saddr, pktinfo.fl4.daddr,
 				    pktinfo.tos,
 				    ip4_dst_hoplimit(&pktinfo.rt->dst),
@@ -1311,7 +1311,7 @@ static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		break;
 	case AF_INET6:
 #if IS_ENABLED(CONFIG_IPV6)
-		udp_tunnel6_xmit_skb(&pktinfo.rt6->dst, pktinfo.sk, skb, dev,
+		udp_tunnel6_xmit_skb(dst_to_dstref(&pktinfo.rt6->dst), pktinfo.sk, skb, dev,
 				     &pktinfo.fl6.saddr, &pktinfo.fl6.daddr,
 				     pktinfo.tos,
 				     ip6_dst_hoplimit(&pktinfo.rt->dst),
@@ -2400,7 +2400,7 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 		return -ENODEV;
 	}
 
-	udp_tunnel_xmit_skb(rt, sk, skb_to_send,
+	udp_tunnel_xmit_skb(dst_to_dstref(&rt->dst), sk, skb_to_send,
 			    fl4.saddr, fl4.daddr,
 			    inet_dscp_to_dsfield(fl4.flowi4_dscp),
 			    ip4_dst_hoplimit(&rt->dst),
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index d6a0f7a0b75d..a765aee6e36b 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -197,7 +197,7 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
 
 transmit:
-	udp_tunnel_xmit_skb(rt, sk, skb, fl.saddr, fl.daddr, 0,
+	udp_tunnel_xmit_skb(dst_to_dstref(&rt->dst), sk, skb, fl.saddr, fl.daddr, 0,
 			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
 			    fl.fl4_dport, false, sk->sk_no_check_tx, 0);
 	ret = 0;
@@ -272,7 +272,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	 * udp_tunnel_xmit_skb()
 	 */
 	skb->ignore_df = 1;
-	udp_tunnel6_xmit_skb(dst, sk, skb, skb->dev, &fl.saddr, &fl.daddr, 0,
+	udp_tunnel6_xmit_skb(dst_to_dstref(dst), sk, skb, skb->dev, &fl.saddr, &fl.daddr, 0,
 			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
 			     fl.fl6_dport, udp_get_no_check6_tx(sk), 0);
 	ret = 0;
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index a5c55e7e4d79..78e5a3393b48 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2528,7 +2528,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			goto tx_error;
 		}
 
-		udp_tunnel_xmit_skb(rt, sock4->sock->sk, skb, saddr,
+		udp_tunnel_xmit_skb(dst_to_dstref(&rt->dst), sock4->sock->sk, skb, saddr,
 				    pkey->u.ipv4.dst, tos, ttl, df,
 				    src_port, dst_port, xnet, !udp_sum,
 				    ipcb_flags);
@@ -2597,7 +2597,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			goto tx_error;
 		}
 
-		udp_tunnel6_xmit_skb(ndst, sock6->sock->sk, skb, dev,
+		udp_tunnel6_xmit_skb(dst_to_dstref(ndst), sock6->sock->sk, skb, dev,
 				     &saddr, &pkey->u.ipv6.dst, tos, ttl,
 				     pkey->label, src_port, dst_port, !udp_sum,
 				     ip6cb_flags);
diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.c
index 253488f8c00f..342247d324ab 100644
--- a/drivers/net/wireguard/socket.c
+++ b/drivers/net/wireguard/socket.c
@@ -82,7 +82,7 @@ static int send4(struct wg_device *wg, struct sk_buff *skb,
 	}
 
 	skb->ignore_df = 1;
-	udp_tunnel_xmit_skb(rt, sock, skb, fl.saddr, fl.daddr, ds,
+	udp_tunnel_xmit_skb(dst_to_dstref(&rt->dst), sock, skb, fl.saddr, fl.daddr, ds,
 			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
 			    fl.fl4_dport, false, false, 0);
 	goto out;
@@ -149,7 +149,7 @@ static int send6(struct wg_device *wg, struct sk_buff *skb,
 	}
 
 	skb->ignore_df = 1;
-	udp_tunnel6_xmit_skb(dst, sock, skb, skb->dev, &fl.saddr, &fl.daddr, ds,
+	udp_tunnel6_xmit_skb(dst_to_dstref(dst), sock, skb, skb->dev, &fl.saddr, &fl.daddr, ds,
 			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
 			     fl.fl6_dport, false, 0);
 	goto out;
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index ecae35512b9b..22a51f25206c 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -603,7 +603,7 @@ static inline int iptunnel_pull_header(struct sk_buff *skb, int hdr_len,
 	return __iptunnel_pull_header(skb, hdr_len, inner_proto, false, xnet);
 }
 
-void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
+void iptunnel_xmit(struct sock *sk, dstref_t dstref, struct sk_buff *skb,
 		   __be32 src, __be32 dst, u8 proto,
 		   u8 tos, u8 ttl, __be16 df, bool xnet, u16 ipcb_flags);
 struct metadata_dst *iptunnel_metadata_reply(struct metadata_dst *md,
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 9acef2fbd2fd..b47e997be7f4 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -131,12 +131,12 @@ void udp_tunnel_notify_add_rx_port(struct socket *sock, unsigned short type);
 void udp_tunnel_notify_del_rx_port(struct socket *sock, unsigned short type);
 
 /* Transmit the skb using UDP encapsulation. */
-void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb,
+void udp_tunnel_xmit_skb(dstref_t dstref, struct sock *sk, struct sk_buff *skb,
 			 __be32 src, __be32 dst, __u8 tos, __u8 ttl,
 			 __be16 df, __be16 src_port, __be16 dst_port,
 			 bool xnet, bool nocheck, u16 ipcb_flags);
 
-void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
+void udp_tunnel6_xmit_skb(dstref_t dstref, struct sock *sk,
 			  struct sk_buff *skb,
 			  struct net_device *dev,
 			  const struct in6_addr *saddr,
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 158a30ae7c5f..6aa045793048 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -653,7 +653,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	ip_tunnel_adj_headroom(dev, headroom);
 
-	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, proto, tos, ttl,
+	iptunnel_xmit(NULL, dst_to_dstref(&rt->dst), skb, fl4.saddr, fl4.daddr, proto, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
 	return;
 tx_error:
@@ -842,7 +842,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	ip_tunnel_adj_headroom(dev, max_headroom);
 
-	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
+	iptunnel_xmit(NULL, dst_to_dstref(&rt->dst), skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
 	return;
 
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index 2e61ac137128..5bdc3c3c5a2e 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -47,13 +47,14 @@ const struct ip6_tnl_encap_ops __rcu *
 		ip6tun_encaps[MAX_IPTUN_ENCAP_OPS] __read_mostly;
 EXPORT_SYMBOL(ip6tun_encaps);
 
-void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
+void iptunnel_xmit(struct sock *sk, dstref_t dstref, struct sk_buff *skb,
 		   __be32 src, __be32 dst, __u8 proto,
 		   __u8 tos, __u8 ttl, __be16 df, bool xnet,
 		   u16 ipcb_flags)
 {
 	int pkt_len = skb->len - skb_inner_network_offset(skb);
-	struct net *net = dev_net(rt->dst.dev);
+	struct dst_entry *ndst = dstref_dst(dstref);
+	struct net *net = dev_net(ndst->dev);
 	struct net_device *dev = skb->dev;
 	struct iphdr *iph;
 	int err;
@@ -61,7 +62,7 @@ void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
 	skb_scrub_packet(skb, xnet);
 
 	skb_clear_hash_if_not_l4(skb);
-	skb_dst_set(skb, &rt->dst);
+	skb_dstref_set(skb, dstref);
 	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
 	IPCB(skb)->flags = ipcb_flags;
 
@@ -73,7 +74,7 @@ void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
 
 	iph->version	=	4;
 	iph->ihl	=	sizeof(struct iphdr) >> 2;
-	iph->frag_off	=	ip_mtu_locked(&rt->dst) ? 0 : df;
+	iph->frag_off	=	ip_mtu_locked(ndst) ? 0 : df;
 	iph->protocol	=	proto;
 	iph->tos	=	tos;
 	iph->daddr	=	dst;
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 54386e06a813..e298861e005d 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -171,7 +171,7 @@ void udp_tunnel_notify_del_rx_port(struct socket *sock, unsigned short type)
 }
 EXPORT_SYMBOL_GPL(udp_tunnel_notify_del_rx_port);
 
-void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb,
+void udp_tunnel_xmit_skb(dstref_t dstref, struct sock *sk, struct sk_buff *skb,
 			 __be32 src, __be32 dst, __u8 tos, __u8 ttl,
 			 __be16 df, __be16 src_port, __be16 dst_port,
 			 bool xnet, bool nocheck, u16 ipcb_flags)
@@ -190,7 +190,7 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 
 	udp_set_csum(nocheck, skb, src, dst, skb->len);
 
-	iptunnel_xmit(sk, rt, skb, src, dst, IPPROTO_UDP, tos, ttl, df, xnet,
+	iptunnel_xmit(sk, dstref, skb, src, dst, IPPROTO_UDP, tos, ttl, df, xnet,
 		      ipcb_flags);
 }
 EXPORT_SYMBOL_GPL(udp_tunnel_xmit_skb);
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index 0ff547a4bff7..5b6083a27afb 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -74,7 +74,7 @@ int udp_sock_create6(struct net *net, struct udp_port_cfg *cfg,
 }
 EXPORT_SYMBOL_GPL(udp_sock_create6);
 
-void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
+void udp_tunnel6_xmit_skb(dstref_t dstref, struct sock *sk,
 			  struct sk_buff *skb,
 			  struct net_device *dev,
 			  const struct in6_addr *saddr,
@@ -95,7 +95,7 @@ void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 
 	uh->len = htons(skb->len);
 
-	skb_dst_set(skb, dst);
+	skb_dstref_set(skb, dstref);
 
 	udp6_set_csum(nocheck, skb, saddr, daddr, skb->len);
 
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index cf37ad9686e6..ba65bb93b799 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1026,7 +1026,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 
 	skb_set_inner_ipproto(skb, IPPROTO_IPV6);
 
-	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
+	iptunnel_xmit(NULL, dst_to_dstref(&rt->dst), skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
 	return NETDEV_TX_OK;
 
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index d725b2158758..53a6d3adf452 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -261,7 +261,7 @@ static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
 	label = ip6_make_flowlabel(sock_net(sk), skb, fl6->flowlabel, true, fl6);
 
-	udp_tunnel6_xmit_skb(dst, sk, skb, NULL, &fl6->saddr, &fl6->daddr,
+	udp_tunnel6_xmit_skb(dst_to_dstref(dst), sk, skb, NULL, &fl6->saddr, &fl6->daddr,
 			     tclass, ip6_dst_hoplimit(dst), label,
 			     sctp_sk(sk)->udp_port, t->encap_port, false, 0);
 	return 0;
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 9dbc24af749b..77c16318f62e 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1102,7 +1102,7 @@ static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_reset_inner_mac_header(skb);
 	skb_reset_inner_transport_header(skb);
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
-	udp_tunnel_xmit_skb(dst_rtable(dst), sk, skb, fl4->saddr,
+	udp_tunnel_xmit_skb(dst_to_dstref(dst), sk, skb, fl4->saddr,
 			    fl4->daddr, dscp, ip4_dst_hoplimit(dst), df,
 			    sctp_sk(sk)->udp_port, t->encap_port, false, false,
 			    0);
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index b85ab0fb3b8c..8e165b219863 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -195,7 +195,7 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 		}
 
 		ttl = ip4_dst_hoplimit(&rt->dst);
-		udp_tunnel_xmit_skb(rt, ub->ubsock->sk, skb, src->ipv4.s_addr,
+		udp_tunnel_xmit_skb(dst_to_dstref(&rt->dst), ub->ubsock->sk, skb, src->ipv4.s_addr,
 				    dst->ipv4.s_addr, 0, ttl, 0, src->port,
 				    dst->port, false, true, 0);
 #if IS_ENABLED(CONFIG_IPV6)
@@ -217,7 +217,7 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 			dst_cache_set_ip6(cache, ndst, &fl6.saddr);
 		}
 		ttl = ip6_dst_hoplimit(ndst);
-		udp_tunnel6_xmit_skb(ndst, ub->ubsock->sk, skb, NULL,
+		udp_tunnel6_xmit_skb(dst_to_dstref(ndst), ub->ubsock->sk, skb, NULL,
 				     &src->ipv6, &dst->ipv6, 0, ttl, 0,
 				     src->port, dst->port, false, 0);
 #endif
-- 
2.51.0


