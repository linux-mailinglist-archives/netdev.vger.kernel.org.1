Return-Path: <netdev+bounces-249509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C018D1A52F
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 17:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 350F83053390
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB0230AAD8;
	Tue, 13 Jan 2026 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="a5O6w8/v"
X-Original-To: netdev@vger.kernel.org
Received: from sonic315-47.consmr.mail.ne1.yahoo.com (sonic315-47.consmr.mail.ne1.yahoo.com [66.163.190.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC25F2264C9
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768322006; cv=none; b=GMwKbJ7fV7m9fJVeXRdR50KZLNaGkglNd1fExwae5FeV5s9UbCu0/wViOvSCk++Fr3b0n3gDUCe+vea7WP4GjIXFJSzs1GspgWFbq39iu2xqhj1OJYxYp94tXiKF2fRp/pME5TOZ+lZhGeC8s6SQ4DjETWjTlqmI586ICJpMTRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768322006; c=relaxed/simple;
	bh=uUjfpi0e4fmdZEqKEsErNeFAnQHCJFOvLlLmvjwFiCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAAhEyc76MYrhVJMvkRky2ArFC0xb6JDrw2EXy6KL9oGemwdxDg5mld7v1IQLhmRMTKlieySFmvu4LdHs2JmgxN7k/IxHnmqAVNPm/gU16gpyjAYecCyMcBah4ERfMWFOisQGlmIZ6f9Qp11ZxqnRDYlYqrDXnHMP4zy8YTIH6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=a5O6w8/v; arc=none smtp.client-ip=66.163.190.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768322004; bh=K9u0RmNxdiHsrAmlin4FMJAixJ4BpZ0KJpaJ7c4wO98=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=a5O6w8/v8/bLxcuzpQEExCbJD/+bpzx6o9E8z/JvAWjZkkucem5xytjih0Ez8BGTesDo1a8/LrdRbIqmd+DNgy1sdXPEmKRwDUqMU3AQT1+aZDatGIXduoP4Dz3rC4/wFefCiF0MbuCQmImedB2RiCtpmwSaNIbxayLYdkuKUKXtYmYfLHTGoA8psdktr7fz5PKV178kOfbCISKRVxdFQdHUJUs63uZee73wbCXLecEN5+/EyQsW66Ke8g8nUaz9LtAmBgLZB1M07isDf9rvpwB6sWHWQIn8xq3U3+6p+O1Cno4Vun3YZ6v+bITiVCTc8nB+udC8/O6vmPbGANngbQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768322004; bh=Btir2hWXsIz5CpeTC4pAhq6reLx66QDIR1h0zpe2yew=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=asNNsh2JtDqxADkxCk6owKcMkffxcDRTSiJWjk0JEv5uOHCCwmbao0RDJCfgACv8Cty/3nVoLesPQXb0teWXZ/kCmeiyA1gwWgqXqaCkFBcrVxyA4+WiWWMFrvr8yoxTc+WR5m0s2x67uXj8tknBVOA85HGthK1NgSqIBG/W4Nfi5G9CHJs5lin71xGf8jb00sWqPNJjdFURxE5fkPkzHAoXhRD7dIuaUC1cmKKdFq/huSwo2kEIlWaD3LK0+zQVmqCH1+D4IE8dpTPPy1D7mABz3Nu5ykE6+995CLNYKmgKlHhnoB+lhO0bvOasIl8KIWKGPpHe3g9HWkC9TBAC7Q==
X-YMail-OSG: mx.dB2UVM1lawdztiTI24PaxKjpxzAsHvpymKc7RblXEs8lO6P..a8j2NpmJRnC
 ncYkca6svUWc06pYNWeY4CZr3KYPxH7mj2e1Ul5fN8jSMrFTAvQvBpWjFO.Cw8r_pXDd1nEdPMGG
 iIdiBSROyCdgdkEus3Gsa56zJi.AF6upU3arTOUAS30ljuBGVMxZucHSZSdBJJrORC7z4b2qGCn2
 ZzwNuXkKhdRnEPKo6kR_0JkwdujbhsM9LoJxqSf1Qlsol3zKW.vlnZo4czeWE4fzk8IOY3HMo434
 iCCWLDmsyfmrLiO_BLN1l4exfSbgk5TIJI2hAg6nQBM7E62U4J7gU0rSHfZnbyo9qzzo1_KAysnW
 cW9IzAdNpHOn0ve7Zh6ag35LdpPRZXjhSnF3QsvEQT.yxF_CHZTV718x7Uyb9ATyGEyuiZAZNW5D
 i5mAbZicGrn62G.aa95a_d5d5IVxvN91uZMZVjr6kF3Jwbi8EiKmgpaz6brIQZbcH.gM4IRJJzDT
 u1ejt6tynIekXjbFHEWjCLkziCXpkvb4t.TtNL..bVB4FLb1UIZ25bWVwfXhn5EVDY5jFvIyJ4wn
 uR3Glx24_aJKaMf3Y4l_aihd.f4qyuDTphqYDCcKzVtil5CqeHXHix7V9DlzZWE_WTfyj40SaggT
 1j3JdaUYxu_xL.QA2ESSCZRzH4HnxcLTX5BiEDM81IvFyH9Onc_TM0SNcr781CxfJ6hJhWmQiUrU
 MFfB0EqoLNmevfDnWoIx81ve_kZXK_4cXvH.UP.rhq.GU9rz6UggfiVwXLbgSXHVIajQTPq5dNVA
 6X9Neo1OdIO.YA8rucrcfZ88_DwkmxXeXqPuxL0lIbn.UB3tFVCDBz4eNHD8R4cuCn11L.vy_357
 UFZGWylx3Y.Kfsv1kICoCPWGVVKBiwkvskgSZwJWFr2wkn71kfZZr5_.OCxDzm60CMQo60cCE4oL
 g6cy9dGNhZiN9FZxyePqHWLRFyqfgC7Nd9J.GvLKZjtMGNACv4aNUc_G8__zgWE0876Nq7e9dxR7
 8DVMI6lQrTLFSdqtSUOlTagy.x6OmKKw2hvRUkh5bNXf7zHRXENtkKt4MniafGRBpH4_WqhzMoay
 0WU__GGxrMSQ3BoXCITFz58cpXVKJ0IeiDNEcqiaQmNWEAXK3cr8Ig..3C7sToSaKXvGRUcqOXu6
 rcyUZ79xBInW2v1B5pWD06xxiqemLYhD_nhzPAYzlSC6qlLRg_reu8x0Yi5u3lyYbnLHJJm0fQJ0
 l2SN0brnMLjSbwmBsiY7wJ46NgZGD4ghbiT6cQ_U32MO5hByZZJNRuOlfAiG8OjV9qvZcFdebPjV
 QJP8h5boGajXDFmjQJTieuqJk4uzrdYzMl.dwi0xwfDZiIVnPni4y20ngEdkX1tnGCkGN71EG_hr
 iSwlnLyvWVVGgwr020rI3iFJCmNnHrj388NA2tBqlvzefEfZJ8R5ODi9bUQdxBpBMataolybw4lD
 48EpW3TQVXgyLvPU90HMN4nW0_8W4jh5XJwEXU_xW25F4bIyiWyRN1Tzjh8F.8moDeZShzPDILcR
 A2tIVkJHY.LC13kNS1vacyOyuD0zrU._GEvgfZ5QJHhGH1VToN2LQOSoq1ym8GANMj.0.5w1w_O_
 K1i67xoneBCT6830nCKG5Rj.kmdFxt9dJohASZZ_CzJrV9QF8Ll9q62oDmo8cbT0pMpLhHdBlf_Z
 8CnG.NT2c7dhn0_XSqcuBe7Zmdv0n0.uP0HXU.XvWjXl3aPGCrZqui6ed1OkpRRMsLeOccZmZ64d
 UtvD0W9m4AgOEXQTQ3XQB7chT_VCKxAqkaGtp2jDzIdmM11FIR1po.VaeRu.nft3cR5yYwANcQrz
 eT1gjewVWxmTvu7wCm6z2ZzvTYrQpm5JiVBIIRK0Xd97kxe_ya12P7.HrEAmyfLlUTODFaZ4NAQQ
 R.F.4Zd01.9s0aVI0D5oFJSR1sUBJ6orXIIU8rYrdfyGEszEZHrOLVo_WFvDlpf.MjLVAg7Yotjh
 tT56XdIPVvfYPtm8d6PPzFy46E2WB4YQa0ecqTnuRmHTuEz.32GnW0c7OvfnwSkMZLrhIWvLmqyp
 nimFaV0NF0n_SlRsf5unKTYH9bAbeCJ8zPlMc3BzDaCtPw4wFXGa0BfrILWaZzObWKaDA3QPrRgA
 YGlrnRyC1N8ZYbJbArgtWvgoiepRFIcgIxmnZ5q4OH_Pe3rctRM2T_tD.TCRz39.7z4cc5SSvLfA
 _lNYTecQl6gZRGNPufUuOfg--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: c47bab52-6ddf-4199-a614-3c3b7bd0dc6e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 13 Jan 2026 16:33:24 +0000
Received: by hermes--production-ir2-6fcf857f6f-7nlzs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 11e96f127f9288c2e2174b22f2ee0351;
          Tue, 13 Jan 2026 16:31:18 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v5 04/11] net: tunnel: allow noref dsts in udp_tunnel{,6}_dst_lookup
Date: Tue, 13 Jan 2026 17:29:47 +0100
Message-ID: <20260113162954.5948-5-mmietus97@yahoo.com>
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


