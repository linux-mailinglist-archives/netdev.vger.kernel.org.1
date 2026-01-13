Return-Path: <netdev+bounces-249514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEDDD1A610
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 17:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86AE830635C6
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC25431A7F4;
	Tue, 13 Jan 2026 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="MCJB1u0T"
X-Original-To: netdev@vger.kernel.org
Received: from sonic308-36.consmr.mail.ne1.yahoo.com (sonic308-36.consmr.mail.ne1.yahoo.com [66.163.187.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D7531CA50
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768322578; cv=none; b=tAOcFhEZuozxZQs7aK2BC63UojXpZc/z2jIOa74lnXzJIHFQPvZH0rRwqsOOto4p8JMZOWf0A4Ezk66oyi3SPmNmu4jaPBQ0ucvjYolmChoJJ4H7Y2bqyraoR8CgcDgGQfkEpuVB8XocIl8uue49py4t2yYlL6XQpOkrNhn7RIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768322578; c=relaxed/simple;
	bh=HXHFN1SAivXgZsW76kkE/sJgm2YKViYztrsfaqwlTQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diR8z4wmC/LHQ0JdtamUGczouoKFGvq79FKYQBkgE2p1g9bNXkheA4UhANj1P6vigf5qIEwSn26YFGyrEnYfaDoHFwuad7JneZ1GndAgJX5pUSJDA+MFVkx2qkpiX9JRcldek9DBHPrmro1AuBaQQzPIJ2V0znyI/mBQ4sgR0NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=MCJB1u0T; arc=none smtp.client-ip=66.163.187.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768322576; bh=DWABmPF1nroYq4cGS3H7q6MyLD61wzJkC5LTvdgTRm0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=MCJB1u0ThudlZgomBuJrPZd9cp3Cy50DFemahNyyqFdpmh7uNZW1x9jy6y7K6iB9CwG8OJ3jffVp3QEXJkaSXQHMYEezcG39jjk06ZZwGo4KK+m34edOJAbvKRbPJBCBxWP/Tq143gQT6GfLIH5p5+Agv5CvSG+YSy6g+1HxUEAWP9o57bAEeUoE9TyNITnLxHYyIJjhsWhqYBjqIbz4qkjyf65gElFuojCFMHq6iSLzORxr0pmKlrnOyyKH6JVU7zktdUNw3g68Iy+tz1DRyEFSjYI0ZZwjbqyY4yHykZ3I0mGfHUWrJmslmwAZ/e2+/jtGnZGqdBrPcVx9/LFTBQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768322576; bh=Fj0kYIlrZguPkcCc3Rl6z/QDCv0xvxtz7WABaw5+ChV=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ssqBRv7NOXda3sZix40fMBPOlTwp+yxjnUUPb+88Z9Uk+0icDb7cH7nKu7eXIvQ+2Bfw2O6i+AZdPL23GqOWkYr3bXB1kH+fbzqCQTPJzuFQnHm4ftapjWV9WCv7hiohHvTlcysaSv3SDd4XdPZJ2t8KqJdp4Nm407hjW7xMiezyYY+gu18JShE9dvJIyV8vRh2Q4Vv1bgbknShK7CPE0TaeWqNb/jw72T2q3PinDec/BiH/YoHluXBDUcVi8Mnp4lZk/7JDV+3MKBg1yp8gucbJthRpuUb0gSM/WioWz2/iH2u+oPB99n6b7giZxnrgXeKuBxpUBOffJvodvksJhg==
X-YMail-OSG: i65XzCgVM1kvqFBGtrBVy58jyfkQEwQemmVGYL0TpHlfe24QVC4HoWdFRq_elWu
 ieZ0Coa8H2LPBYF_KAcPArMEKcAZXUocFvuEt1VJrJQTxKIv1kCmDmPEwBUzIM2OVqVe3P70dY8y
 uLgkOIbUk4TuHRirFpv4_EDQlFO2lMBfVf0Ezy.8BWaTEkNFmQJy.sMb_poqUuxsDUfu3LIgFGZM
 13lTNdlw5UjLUD61xfi9PBLZpPC6v6JlMPuP9qQTT_YPmJbFVL_uF10qMvfwANbU99spKzRinZdC
 ZCOoskFg6CvZSmEH0vTlyaLw6UubOu5PVSdTapcMGYPUjtI.i0WIQwR_9B4.9rS1IqdB7ReffjKM
 Ot7aBdL4Vjhw0paFRWYE.GuJLkZdu_sOz9q1Rh5tc5UiRN7cAtdD97iOfCpjAIIiuqVWUiX1R8lO
 3HSczf2dCCqr4A.tdA2XJw.z2TugdbAqNPuMiMjx9KyBoUxNA7g2KCfBSAan7qPaLtMz1WhpIJqc
 AcGXA_4bFNWntSOJ9hsM1Q_tOeSNspFZaxUmpW2yxrHEKaZN6vQ.Oyc6FxCJDA6GvFT.WF7aJiK8
 T7zRFqSPtTbjXK8rq3JwDKGQw5GRKHPiQDQazy3etHlB5ObzV_5GqQbnC_.w.CqZJwFGTP5JFyMe
 radpOpRuo9rMAjYTCuhzSiNzTNAJH5wCu9O58V7e6dH6ryM13HWyqOJsqr3pkPQhcllOXt8kgwlD
 KYnqYcsX686YGscni2xx9NSqUaYN7oCetnzsvd.Tga8TcGCDAVm.go16cCWZPXXld_W8kpSLVkhm
 CH.l1wPE1zfoadFiMsKsNVpKscIAbFirQ0OALGZDZxb.RN.ZnYkFtYgQdYuYpyYPS.QIcwXXto8P
 WZPiVAZGTKTF3oJ7yDU_IIlVSl4mEvi1lCM6d60xBRkcYRD8JkHVKzJuh6rteBVGSBm3pbBqzdLj
 uYZsuMahTOMwj4svzUSPiyz5cMUwVYc9m_qJGhwsD3WnOhxlHLdxZC5Rk8k6B8uHeBqAtE5zdASw
 aKnUlRsAAdxP0Ki.TUe2cMGWDgeN8Xgqcb57ELBvnKLqlD68RJvKf6pOfOySRPjPR3Ti.GfUyLJ6
 RoMHN_nsu_7plrRHTjRE_lIoXTQ.1PmNMZGOqMeOGrakubFyTGovnGBYzd3s0r.fDiFm1qUTs43k
 aD1sDq8sTfZNjgVeRIffbkyItCs2zd333g1cYnGZs7cTCxFLOF1m2Hndx3Oyg9C2AIdYHPUWwM5N
 07ufhwLPYGL2W6JcFcG.kDaaDWy8sn0B6UFzhKCLPid0BXHC0tfTL605BdVtsO0jM_xntiAK9XlH
 NeNBMcX3NcRL2H3EG0Dq1s2iPseTGgPa7nIlyRZkUCxOWPDmi.cz58w3O3shkKKS6F4Wep4A6O_S
 bYMOiI0hfdxvbc9W99nEUF5h8aRpPMqreR77kq2LPWsgIjlFH0YmEiT8NNVp0oQPulCpwFTkOeM9
 uRSGwW5pq0fQ2nJUUK8GloqNDoN3Uk1bAOOJm6xgdpQOonCqDbGPNe7g2WHJzd6AeRf6IdL9ooVB
 0qQvykIN0BMa4ROZ9S74w07_td2s2wuT11sKE9NwlbgXW63Ah5RFzKr_vPbVFbLm4UiRU8oTo56N
 pzoACPNJ.nsHCDFMGzMXp0FXbvGX3VCnBtxvz9HP64bhkSrPjdrwdHrteEKAJaUvpOiRXWipVY2Y
 5BHKN5C_J91jXzT5fb1SBLWCdK4WJc4oipklWRSIgP6w35YueR_OSEzNpv.6UuxQwBlDzLH_8i17
 YUjBHQ_6W6L5MhDWftM.w8Z8NN54ITYGrsgkB_5qMHEzoc.GWvmRtcnvRcE5xzI4wcHw1PzG3AoJ
 0N_irMr8EvjaJcmA9jP.zahiE6KUhEZqJCIivh.wndVQCl9GS7_HbiqgbTqCPsTWNMVKCwG374EL
 qGbRThzw2DQdZRMWz.mz8qfzXm8QE4rmg8FBhHY7VZzmhqNN4Iu2.keRCcLgmHztMY6CD.kAD31Q
 0jN8fkO3d6BkFxaDVX8UGFuvSzGhRCCxQcy_mmt9euatI1D_3lj5jjy.gtKYcE2pdsMVadtCGmmX
 1Rsg7ncCH2ova88czL6g4AEbylSHKMa4twcZi9OErRKO5WwKEU.y4kK3Dc_HNISza.LnJBS7twCD
 8o71piyGO_4b8WCac0YIts8ZIVGElUQLlh.Bsj6FYY5JQaG6XQSMwXcQNAOScoVeR4QD2GJQVThz
 1rhZv6ksa2MYV255uBSYkFA--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 218043de-c0fa-4b74-b7e2-db006ebd4bb9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 13 Jan 2026 16:42:56 +0000
Received: by hermes--production-ir2-6fcf857f6f-7nlzs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 11e96f127f9288c2e2174b22f2ee0351;
          Tue, 13 Jan 2026 16:30:47 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v5 02/11] net: tunnel: convert iptunnel_xmit to noref
Date: Tue, 13 Jan 2026 17:29:45 +0100
Message-ID: <20260113162954.5948-3-mmietus97@yahoo.com>
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

iptunnel_xmit assumes that a reference was taken on the dst passed to it,
and uses that reference.

This forces callers to reference the dst, preventing noref optimizations.

Convert iptunnel_xmit to be noref and drop the requirement that a ref be
taken on the dst.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 net/ipv4/ip_tunnel.c       | 2 ++
 net/ipv4/ip_tunnel_core.c  | 2 +-
 net/ipv4/udp_tunnel_core.c | 1 +
 net/ipv6/sit.c             | 1 +
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 158a30ae7c5f..8a0c611ab1bf 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -655,6 +655,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, proto, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
+	ip_rt_put(rt);
 	return;
 tx_error:
 	DEV_STATS_INC(dev, tx_errors);
@@ -844,6 +845,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
+	ip_rt_put(rt);
 	return;
 
 #if IS_ENABLED(CONFIG_IPV6)
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index 2e61ac137128..70f0f123b0ba 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -61,7 +61,7 @@ void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
 	skb_scrub_packet(skb, xnet);
 
 	skb_clear_hash_if_not_l4(skb);
-	skb_dst_set(skb, &rt->dst);
+	skb_dst_set_noref(skb, &rt->dst);
 	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
 	IPCB(skb)->flags = ipcb_flags;
 
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index b1f667c52cb2..a34066d91375 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -192,6 +192,7 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 
 	iptunnel_xmit(sk, rt, skb, src, dst, IPPROTO_UDP, tos, ttl, df, xnet,
 		      ipcb_flags);
+	ip_rt_put(rt);
 }
 EXPORT_SYMBOL_GPL(udp_tunnel_xmit_skb);
 
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index cf37ad9686e6..a0d699082747 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1028,6 +1028,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
+	ip_rt_put(rt);
 	return NETDEV_TX_OK;
 
 tx_error_icmp:
-- 
2.51.0


