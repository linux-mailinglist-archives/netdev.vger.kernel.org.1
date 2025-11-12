Return-Path: <netdev+bounces-237869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86347C50F8F
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 08:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B804534CFBA
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 07:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FEA2D8DC4;
	Wed, 12 Nov 2025 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ru7imzey"
X-Original-To: netdev@vger.kernel.org
Received: from sonic304-47.consmr.mail.ne1.yahoo.com (sonic304-47.consmr.mail.ne1.yahoo.com [66.163.191.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D7F2C029D
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 07:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762933233; cv=none; b=UHvsx+oXlvbMaShg/8Y+c4PU3i1WJgSVKc+WT0fAnSZb+bET1I/V07UzUHm5z7LBP9LBGCHBQERuPbuORi+o0WvSwMyFvkVcvl2O3Vt2NavAnkrLm5glIeBYXFNEVlm8AfQj1nLW2DKs/XBYtK4CCADO45F5/Xlhe965t8AVWSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762933233; c=relaxed/simple;
	bh=OoJ/zJzrLIWKOMxGyXCLacqQaA90FKj7x6cwln09UA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcugIXvR5DreTvCcCEvLtMQMrNg/3eh59WCYi5Kg/48hOyJh8mzR8/Amj0lOkUtv9bG/h6Az1dz9FE6cV5v4hxh4W0+hNg8j6S1oy5FUv7YVeolBPex2DtiB/Mx7Rn8Zo9Q3zOkzv0UAEVNfrrYAFKK2fQTsI5LXpOr0GjC4oo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ru7imzey; arc=none smtp.client-ip=66.163.191.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762933231; bh=gQFK6/pqdltDR1oJK5uX3W6URmzRoO1lVHSeZ0hYKgE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ru7imzeyHJpe5X6ETeHtRsMhIspMZUv0sSFhdI2U1g6mEX2rFAHPy2oWvRN1BLtlixqvO06iZrCzfRXeA5EZ8t71INgsGvl2/b80Vr/dIdzSoBT/dWlM2i/P2chSafUlYWOXEempIM4Dt93fHVVhs4564IRYCJ4WxTO87PY3ccuB6h10QQMk5TGFzd04REM+QHyE17kvRaDI6flpmiTmvI7YupPq8uDvRbCAvKgbqFe1Cn4DdrIvQG8oXXC0+zE3TtyRiZ084+gxHyZiclVI4V5i90d8HS98sf+5mTsiwUiRST4X4A78795nGAzStRgzT8KOdWQzhzKY4Utl4zOypw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762933231; bh=Vxo0nwEaFAD3T9Y4jyxX5e32RzBCCm32wcDz869KGPt=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ZxjkbKhI9+QYRmv4MRaDmGRkxYldzkAnJSkcjfuMMJ0PA3mD3JAqycMIfDpKMc/ibikL/CTYWyz7Zy6mjbKaebU58hc15W6LdyKXJab8HtyoG29ZRTX5OFQIKUKFGDtN3DPrXIoCInUrU1bw6rm8MRS1SmTYQYWPOlYZKpEOcI8zZH4fPfEZHlI4aL690jKiA5jMzgZYu4Dsb9Vk40pyZA2+uK9HBLOgoHFTCuBPVKs/UG8+ft+ScHmWR+YO250aEe1EwCNykJubF/CRkqsSVcOg0aI/auWxkfopIEehNacgtjMM7SQuMMUiZxlqC51ymx6Dz+iqer169a8cKhzx8Q==
X-YMail-OSG: zHnUMqcVM1nt_VuQx5rK2KG792.OkFlG2EbifgA8bfDUSor216B3n9iggIG1TkD
 aCYUM8sW3IgswBabJm9U61CAOxVj3Dr1XpXFJ9MPVZ.1Jk6AUQW_TF76QbAUSQF2eWdfJJ_J7WJk
 mIJlWKeLnKK66kKkyk6GYtteb11_KKt2a3bjM1_oR2CWlB0Lp6LxgFH2fYGAVB1LeFmt5s0_3mF.
 xAJpSmuA14gV0JnNBCePe0aydGaRdm3OaHHfNxwqRXu8S2Kkgdb80WCrxMKljLbtenUbgbXatiJ_
 CXZwP1wXsvZxWNsEhOayL5wNrl8Uh_xW5oCHtQLiLPIKqaj3vXlz3z9A4XeWR2NX1dtaXI3UQxXr
 USBrRMM1zuSZ1MtvYe1S6.OBzUB4kqiKIj1wyKLqcmBHTJwe4vRtJEMSC8OFQ60OdpN3cP.ZnE.M
 JLFrn0thxR0cxxkhGoLxK6j9VaGpBrbRR4QDRqNGOKbN3.h33Nea2UZM.dsz.kb4LZMZtHAebjEv
 2Tlf2BRIn2VNJWRzxzvwt1dn7PV13kAXkJIipFzy8EVAs0Wq2rpP0XStCfZqa0aYEt3rL0G_mTMG
 CEt_MsodiupCqDSuppdEpCswgSLQCzsiJWpPlXdvxptSsMoQZ9d_fTtMH3CgNtP1gdn6CuV35JeL
 CV3_nI854DxHceqHhC_X_JVOWAKj.7aJYBlcms4TVxprDGonHOXxLOvBBGXZnz70H9I5DYklI6.K
 XBwE2D9DOtArLKx7QH5JKSC5LByiOrZPNWX86v0M1bi.n_.Yte.Y8RJZaVwCF2XUfDQr55jIULj.
 JehjZO5YyqlUfmLC_5Xt5KhlK0t2YgUqHCQgdBAJB.qPVWxPNATvbVWOVXe3k74mKA8r2LZfjkpX
 bA3bbsn5YYOz_wQO028pkJd4os_JGfft73hVE2Xh9f5GVOukHkc0pfivOm6LKS7rJAmIZeBivPBC
 qMUE9ESwOjrtFRbs4xgIH48_INKZ.zAGLT7dLhreTgjwTRUw5tKYrjWLuMdC3V.Nv3ixxzKOVhEB
 g6WMIRbHCslhtVlt_dhpbgYfDpGR7XCbIhQ14sCDAtnjRcYnOMwG5wz8D6IQzWLFmJ_7Okk3lava
 XQl1KogEBntf.VCjBdDyJI8SJlqjdl2pdjRUHHd3W9d07uSqBpUhNmPUTvqA0g.YDOq7dMpDmwVl
 XgXQofgQX26a57Vo7WURwzjnD6pb73Rcg6UZPmJGu9cfQEGxqI1kY1Q6N1_6EDxywxxMhpWjl9Ls
 Ua8GTgQIQbSn8TFslH2stY7UcdK2Smp4_wF4nrfVwXxTass1XXqbwXH61IkZZde65ymGfGoikzc3
 ajTW9MaeNrU.Wcd4Jwr8f5dD9nkga_5sp5j81TqhF0vR0M5zKzyXiDKxR.eyru9XMpcWkp3TKtB9
 g.fzs4l4GZX69qOcpeg9OpD.o9KMBuzopgV7jql3SVBX9s3cxdpt.hNLp8fgCrydVDLCAtdbsqEh
 iavCZbyxPeAtgMNfWu0YVUivqQny1s7Av5BAjL48u1aah.C5VFia63Gq3La_N4LoIEdRfx2vjXu5
 a7SUXMVD0J5JlB8Pj.C_Gy0iDXfk7nDbUENMjedkPd6t4ngUf.lQtAAXMTOd24F2UCPjJBZbiRB8
 mGOzpbLiIE4fahiaBseJLIROfTsnhMf0tTKoA__MgoKPWeQYTd5Kl21yLr7uR2aFc6KTQEn2Er75
 1Pcyn.WIzD3Le38Nwl3P68s.s3pQSEmZnw9j8D4Jfmfq3DbSOOpqqzYp5ICOF1Ju9SGIuM4MWDth
 FhCQlINEcfBSSXAX1D.n3oDKt_yg151.QcOYSgUtu_JSNSfAJEPIlil1OR1IErxrSxgvWwtpRC6P
 0BZ5Xwt5LOeOXXGM4.aAGAzon3ikGlPo3QC2GIkeyZZDoxF5u_1kczB2_IbvClYqHF83u0PGveLW
 1tkGeYS0JmY.742SpPIYS8bcqHbZUtGSagOqHPO7TfeThstnhkm20giQEcN3nT2hDMlgIlscYp5l
 SmaeKgYta6uZtM23z9cjRDEpTbOIonsmlgog8EMfu8aNTxrSeTFq3MtRlbnep2FC0RSkY.YqV1RC
 mWn4eVggT3qAB8bDKHL7DBkh6lx7Y0IVLlLjQ4OjlE.Wbl5UiVXJe0s66DyigpmN3tIPed3pUePe
 OA3gQTIWkx73DWntOI8VXO1jI6Ind9eMqGDS3l3.e5NhxV08z5EceD5V2AMXCmFy9vTXowsHSRPw
 HByjd
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: e846969f-424a-4b5a-9b68-29e0e667ec84
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Wed, 12 Nov 2025 07:40:31 +0000
Received: by hermes--production-ir2-5fcfdd8d7f-2cnbk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ce2e5d13638178c4daec60c4681fbbb6;
          Wed, 12 Nov 2025 07:28:21 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v4 03/14] net: skb: rename skb_dstref_restore to skb_dstref_set
Date: Wed, 12 Nov 2025 08:27:09 +0100
Message-ID: <20251112072720.5076-4-mmietus97@yahoo.com>
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

After changing skbuff to use the newly introduced dstref object,
skb_dstref_restore is essentially just a setter for the dstref
field.

Rename the skb_dstref_restore function to skb_dstref_set.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 include/linux/skbuff.h                  | 6 +++---
 include/net/tcp.h                       | 2 +-
 net/ieee802154/6lowpan/reassembly.c     | 2 +-
 net/ipv4/icmp.c                         | 2 +-
 net/ipv4/ip_fragment.c                  | 2 +-
 net/ipv4/ip_options.c                   | 2 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c | 2 +-
 net/ipv6/reassembly.c                   | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index c46f817897a4..b71251372600 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1176,11 +1176,11 @@ static inline dstref_t skb_dstref_steal(struct sk_buff *skb)
 }
 
 /**
- * skb_dstref_restore() - restore skb dstref removed via skb_dstref_steal()
+ * skb_dstref_set() - sets skb dstref
  * @skb: buffer
- * @dstref: dstref object from a call to skb_dstref_steal()
+ * @dstref: dstref object
  */
-static inline void skb_dstref_restore(struct sk_buff *skb, dstref_t dstref)
+static inline void skb_dstref_set(struct sk_buff *skb, dstref_t dstref)
 {
 	skb_dst_check_unset(skb);
 	skb->_dstref = dstref;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index e684f246e798..7a7408ad76fb 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2103,7 +2103,7 @@ static inline void tcp_skb_tsorted_anchor_cleanup(struct sk_buff *skb)
 	dstref_t _dstref_save = skb_dstref_steal(skb);
 
 #define tcp_skb_tsorted_restore(skb)		\
-	skb_dstref_restore(skb, _dstref_save);	\
+	skb_dstref_set(skb, _dstref_save);	\
 }
 
 void tcp_write_queue_purge(struct sock *sk);
diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index eb23c70c7416..183fb3f95809 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -146,7 +146,7 @@ static int lowpan_frag_queue(struct lowpan_frag_queue *fq,
 		int res;
 
 		res = lowpan_frag_reasm(fq, skb, prev_tail, ldev, refs);
-		skb_dstref_restore(skb, dstref);
+		skb_dstref_set(skb, dstref);
 		return res;
 	}
 	skb_dst_drop(skb);
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 6b19a0ffea21..bb6c0128a66b 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -553,7 +553,7 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
 		rt2 = skb_rtable(skb_in);
 		/* steal dst entry from skb_in, don't drop refcnt */
 		skb_dstref_steal(skb_in);
-		skb_dstref_restore(skb_in, dstref);
+		skb_dstref_set(skb_in, dstref);
 	}
 
 	if (err)
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 33080c5350ed..a077070240b8 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -368,7 +368,7 @@ static int ip_frag_queue(struct ipq *qp, struct sk_buff *skb, int *refs)
 		dstref_t dstref = skb_dstref_steal(skb);
 
 		err = ip_frag_reasm(qp, skb, prev_tail, dev, refs);
-		skb_dstref_restore(skb, dstref);
+		skb_dstref_set(skb, dstref);
 		if (err)
 			inet_frag_kill(&qp->q, refs);
 		return err;
diff --git a/net/ipv4/ip_options.c b/net/ipv4/ip_options.c
index d6c712269052..9e247ec9aa97 100644
--- a/net/ipv4/ip_options.c
+++ b/net/ipv4/ip_options.c
@@ -621,7 +621,7 @@ int ip_options_rcv_srr(struct sk_buff *skb, struct net_device *dev)
 		rt2 = skb_rtable(skb);
 		if (err || (rt2->rt_type != RTN_UNICAST && rt2->rt_type != RTN_LOCAL)) {
 			skb_dst_drop(skb);
-			skb_dstref_restore(skb, dstref);
+			skb_dstref_set(skb, dstref);
 			return -EINVAL;
 		}
 		dstref_drop(dstref);
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index 9fab51fb9497..c03ede44cfc7 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -289,7 +289,7 @@ static int nf_ct_frag6_queue(struct frag_queue *fq, struct sk_buff *skb,
 		dstref_t dstref = skb_dstref_steal(skb);
 
 		err = nf_ct_frag6_reasm(fq, skb, prev, dev, refs);
-		skb_dstref_restore(skb, dstref);
+		skb_dstref_set(skb, dstref);
 
 		/* After queue has assumed skb ownership, only 0 or
 		 * -EINPROGRESS must be returned.
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index aa8427f56ff3..016ca7344427 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -221,7 +221,7 @@ static int ip6_frag_queue(struct net *net,
 		dstref_t dstref = skb_dstref_steal(skb);
 
 		err = ip6_frag_reasm(fq, skb, prev_tail, dev, refs);
-		skb_dstref_restore(skb, dstref);
+		skb_dstref_set(skb, dstref);
 		return err;
 	}
 
-- 
2.51.0


