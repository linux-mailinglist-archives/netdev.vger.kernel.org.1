Return-Path: <netdev+bounces-249515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C41D4D1A613
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 17:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94BE93027A5D
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDF03246EE;
	Tue, 13 Jan 2026 16:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fE0cxEtM"
X-Original-To: netdev@vger.kernel.org
Received: from sonic313-35.consmr.mail.ne1.yahoo.com (sonic313-35.consmr.mail.ne1.yahoo.com [66.163.185.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559012571C5
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768322595; cv=none; b=QyfjgsT461e/sgmBRcEB7kUt7P5kQDHA1L28CJjlGxe4hJyUNOzoBCu+bG9AywWJYvrtm9MX3cDituCaKBXEcIcGl3zF8yND8afLMHGN0XUBskZZQbz5ZnY5OWO8JrE0GkD5+we2eiKs52k5UYSb1VQHn0V7G2I8HaVvsck3F0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768322595; c=relaxed/simple;
	bh=oqUrSL4lf3tYBFyaT/ify6X5U5o296WFynLQeU6ytBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0Cw6KCw7KIAlJlvxWvX+pcISioBa289ojR2nagkzOwZ6resw8LM1VkjX+LhxDg3jMhgtb4qbAuIgX1LX1ejOlvjqRrPJkU22WlrFWii7L7edtSrRzwTAwvvLnUp+xvfpstsx0rSnbt1aF5vTmQpwLO22HGhL/d7YR9m0VjD7/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=fE0cxEtM; arc=none smtp.client-ip=66.163.185.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768322593; bh=GJxqCb9d+Qv3aRQe8F/WJT/zj1IQzolQ6CI7JT0Afos=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=fE0cxEtM9FnsTgWrbEdBPwCfc2ntgJ+a2O9asQEq1gMfhqmuCd7RKmoA1cQ8Hr+QD6cwHE0Jr8cxKBxjq37qhNyGydrKDE8wGfwiHP1WAWyF+evUz0SRJnV6V5dVMKaRZjGVJzpQig3UToOr5+FnCT5WQsJwfozLMqUoq1UD6UfsLZ1tXCsl8R3cyx2HAlG1fWZYnw5EWqrnP8xfQBP9br6LWOf6HMX117l8//LwKw3D8Jgd+naz+ZskTyFSFeZYAhavXJYEq941ZCQF4nOrAPPjYBxjx0Ocucv2rXrYHOgtahms/qNZCpIS6U8B+J+FsNQdK9SGhoxvVAoALHJoHA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768322593; bh=Nfu0XCRzoI2wHSpi3ux8gNVrLskQFFPQ8nDOoWzZ7fE=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Su7ME1/i4+381D/fPTa+l1FLQZIHzEIF9ZXJbUa8YZzClbRKE0Z4XqaqKhmcAfSD/B2M2shDB3FSBjxJNMjbE7k6S5TtrcfATy+6spKl6UbKXvav1rqwT5FURR6Cj2laXo7pDCIp9E+YWeKvZeJVzSwAAmi4DlV+tDLOV19XbESXSeQwO5CQJKxQcSFOKSMiwJH5JwZ4SuMmqaTi9kMMzsu3wM1zHbMq6sq6o8FumfVk3AjR9YirgmV8sRrAYaGO2/AelSxNoSIJHq44jfU7nZXJ8qXKEGtUu/xo+beWmx8qqlzVWSCCdg/JFFScQDxnWwK7kE60guXpaoLFVBIh6A==
X-YMail-OSG: o4Q3Fa8VM1n5AiKS4agNjR_fX9tk8DjO_Ma6NfmFIkHqpbyK_qY0ngxqP8Gn93d
 dvZ9ADumrpMQmxAcVgxDJomMv2mz6oP4g8KUdm9iRK8fCteT2MD7kR62Ch0Dtk4e1o8i_9Ne8cAz
 AmHlc9fHoAZBVUFOYxk8Hvc.2HaysPSRSVl7h2UVB5OvVRi7U7fQqQU8PPx3a7wEZbx2tOg74E6J
 AEWJg3zAJz_c1n_..bPj7VYDX_fELft3IiuZ_U_lyzaccadpeG7cLMOq3g1gQj5X17_R1iyS1GGH
 wWlllQVlOPf9eQZovNIawDe7tzy2MtTNh1i7haX2gG2TmNXuRv77HDj7R4NpZzrjJCJGnIyfgFzt
 yQME3Q9OcYzXbWlwctHnHXDo3sj9v3d.KKxzM4jBbwhg4wiAfhIXN86NcKLoF_PMFvyCf9qmz.Ko
 Si3aF9OrEQyv1oEE079Wda4jeBFIr6e0sz4RshMsy5OYWkqKCpkzTKkrWFX6Zu97ql8SQWNV9j5T
 YyT7E1rj8jUMVM1Ve4XcSs4qQLMtO.VtC_RpvYbb_G6RlPhTdlVfDUID0NfQYy99TOkMhkuTScYw
 Xuqseu4Qa96O1e3YuiTXRRKAEkzqfyL2fiBUeVzoymHo3UrXenDppA5uuAsFllF1_Ecqbk52Wbjm
 IYeU720DI4tRHT_vCCGc.PiXbVsjBA1Qav8VqVwoQzW2AciwItNn0jeDP_0KwJLTPJ6rxlbFAsw6
 MaCYc05rbSpwOxQNSGzZC1y2ozmLyte6V0g.v01glMo4tHdrldB6X2OTPn2XcF_83Ls_Ii52bxbO
 WpiLixQkp_NVbJV_zH3EsOL0b0oG2kvct3QdvHTTPcojgXtkAYAxeq2GoDQTnumA.GHkZSekIfJm
 _hAbel2QlK7_j7M._PixHQ8Dg3VIZ3yAuA1_U62sA.xPEV26B95tyOPOiTWTsG_of4k2Wrg_HYKP
 xorjMDlEMXb0vY8jsXCvydnRF.9BkiRxAXQZzPz9zqjjWoRisXAuRicbC9qSQfkEEDyFAVPO.FsT
 AYkUkgJKex6hLgNiT9Q4KDRfrZGnl.wcEhbHyc3PNIXRNw1p0Wy2fEcu7v4PjuxO9b7KUqo_x9cb
 STCdEfpfgVw0yaYcG1opJwHzolWPnxqr7Btj5PYpFEYQujZc6s1ta7Ft0vh9B1LnH8sKA73IuwA0
 cuVvPJ9ZFtGf1vjL28FEirV1P6pASwE5P5WT0VqBsvLVxixIqqzdO6D7RWFrzkEczkfQtTAur2z_
 gyTIUpwKH8BR4MnTDubNRk4UBWzZQeV2WVIbkK5Fc9aH8TgW.Hg5yF_OWrDkUMteYy4Qrq7Q5k89
 08ZGTI8rFUDEl89d_98OTwztUPBxjvoORUOxFzxCx4uOzb8JXUVU2UW.IBEmrC49N8urDzXYNhJo
 pYlY.xhVj2seZfq_y6yfZFXHUqPkofjj0AJHnSQ1BQi5Gl6bugSyy2_2ycewvME1ohQg98I7thX8
 eW1ryiDBUafpmq74Jjg_jKhZ06vprn4azwnv6I_k6VC5YubczMnD7zvz98oIetNHeHHCDDiFtzJI
 LEBGFM9zOEa9QGrE43R2hrrNtr7WtcsbEn1JFBqcgqqDDm2vv_avrqTv2SGAAg2VY.hWOXI14aPZ
 4ZtFNREJBqeG4ZJC1xfk9R74RIoIAXqLeWnRJw_KusEjgkHHRb4kH3E0JuurQHS5jMIdeSpVY.fv
 f7uIOpQtYxCN6c8ykRlK6r7pjLizFUVFLsEU4n.dNIbvKNhMFlqVdLqfDymIT7IV3VXhDEzfAgVb
 cVo6Okix1PYbHZT4B0dEes3.qCaZYmuwgdURZYHtaLP.brM7AsimowkiTDP4PJEsGYzSfCgIl0CP
 ttPljnazNlcxc5YYlhJgdlGOZUzlzhWol36_NjGa4SD2EHaQnjNMXG14E1CfeDyoWje0fns1GXJT
 sSXTLqsBoUNnou8t8XFcDDEuBG7ccjfh1MgqAsd9naLtkZOVFDF1MqnNkYLHbYoD691NnH1.HjQe
 VrYaWtYNatEjuScJFQcZB_u.JGjxIs8KBHZgTILGg0fzz.z9ajBzE_6Pb.biLRRM6CSCNo1UCH8_
 RtOPPWLZCANymT_VRRNrfJhmua3bS4lIfreoupVs9vhNjPwG05Pqee0VVWht4GRhvMFAGt7zhJcl
 cZWL99jJ9pJfMPW9XSQc_yRUpNj2Pr.oMBYi6Mqd7BjVP.Hn7Ua4Wm6VKYBnrvo.c4wcwct4y_Fi
 5iy0_f6ILNWbFuXyqpU8ReA--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: f79a2744-095a-412f-b4ec-9d270ad54bdd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 13 Jan 2026 16:43:13 +0000
Received: by hermes--production-ir2-6fcf857f6f-7nlzs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 11e96f127f9288c2e2174b22f2ee0351;
          Tue, 13 Jan 2026 16:31:02 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v5 03/11] net: tunnel: convert udp_tunnel{6,}_xmit_skb to noref
Date: Tue, 13 Jan 2026 17:29:46 +0100
Message-ID: <20260113162954.5948-4-mmietus97@yahoo.com>
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
 drivers/net/gtp.c              | 5 +++++
 drivers/net/ovpn/udp.c         | 2 ++
 drivers/net/vxlan/vxlan_core.c | 2 ++
 drivers/net/wireguard/socket.c | 2 ++
 net/ipv4/udp_tunnel_core.c     | 1 -
 net/ipv6/ip6_udp_tunnel.c      | 2 +-
 net/sctp/ipv6.c                | 1 +
 net/sctp/protocol.c            | 1 +
 net/tipc/udp_media.c           | 2 ++
 12 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 902c817a0dea..e9eeaa7b6fe7 100644
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
index 77b0c3d52041..169a2b7d83e0 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -926,6 +926,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			    !net_eq(geneve->net, dev_net(geneve->dev)),
 			    !test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags),
 			    0);
+	ip_rt_put(rt);
 	return 0;
 }
 
@@ -1019,6 +1020,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			     !test_bit(IP_TUNNEL_CSUM_BIT,
 				       info->key.tun_flags),
 			     0);
+	dst_release(dst);
 	return 0;
 }
 #endif
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 4213c3b2d532..3cd1f16136a3 100644
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
@@ -2409,6 +2413,7 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 			    !net_eq(sock_net(sk),
 				    dev_net(gtp->dev)),
 			    false, 0);
+	ip_rt_put(rt);
 	return 0;
 }
 
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index d6a0f7a0b75d..c82ba71b6aff 100644
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
index e957aa12a8a4..09ddf0586176 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2538,6 +2538,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 				    pkey->u.ipv4.dst, tos, ttl, df,
 				    src_port, dst_port, xnet, !udp_sum,
 				    ipcb_flags);
+		ip_rt_put(rt);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
 		struct vxlan_sock *sock6;
@@ -2613,6 +2614,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
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
index a34066d91375..b1f667c52cb2 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -192,7 +192,6 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 
 	iptunnel_xmit(sk, rt, skb, src, dst, IPPROTO_UDP, tos, ttl, df, xnet,
 		      ipcb_flags);
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
index 531cb0690007..38fd1cf3148f 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -264,6 +264,7 @@ static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	udp_tunnel6_xmit_skb(dst, sk, skb, NULL, &fl6->saddr, &fl6->daddr,
 			     tclass, ip6_dst_hoplimit(dst), label,
 			     sctp_sk(sk)->udp_port, t->encap_port, false, 0);
+	dst_release(dst);
 	return 0;
 }
 
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 2c3398f75d76..ff18ed0a65ff 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1074,6 +1074,7 @@ static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 			    fl4->daddr, dscp, ip4_dst_hoplimit(dst), df,
 			    sctp_sk(sk)->udp_port, t->encap_port, false, false,
 			    0);
+	dst_release(dst);
 	return 0;
 }
 
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index b85ab0fb3b8c..ba4ff5b3354f 100644
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


