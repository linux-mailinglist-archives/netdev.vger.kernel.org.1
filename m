Return-Path: <netdev+bounces-237868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CF5C50F98
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 08:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B59F94E17EC
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 07:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E78A2D8DAF;
	Wed, 12 Nov 2025 07:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bpcw8yv0"
X-Original-To: netdev@vger.kernel.org
Received: from sonic313-37.consmr.mail.ne1.yahoo.com (sonic313-37.consmr.mail.ne1.yahoo.com [66.163.185.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA6429B8DD
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 07:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762933229; cv=none; b=agiTK9zvXGBmFKdxBMvz7/biE1lg13ayDvzPtnYBIFicEi3WC2E1DTTz72iDOzMhTa02BW+j/3UGLoUgI/AJINPm+Q1gRvEIUUZ2L4uwatEMiSuFqyU4Gzb1rVudOu3skOrVyOsCsBRGC6RVzd/efeGSgqZxfUIO5zjl5S6tM0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762933229; c=relaxed/simple;
	bh=fge2H24MGzAAprHWrq6b5rg8EIpFF7RodOw5XAeH1AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzGXQfeacCv79ZoSuk0+oSsNGnYHUREGJ5uyu6Gsoh2VZdcsqNJic40nFvHFc29USQSZfchnDdfaNu+RasD7+AC1u/3L1QaoRvE7nPEPP3zulPQ3+ylAPsCajhwEu+R5Or6zwI0ja4V6dJxu4rNqVw2g1D9098V7pInQLupwGuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=bpcw8yv0; arc=none smtp.client-ip=66.163.185.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762933226; bh=JwfF9inOH3TrRN2JOn88BFiqi5q1CObX1AM3tEb8hhU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=bpcw8yv04E6BgwLNTHBTM4Ulypi+P51M6/DP1VeU7td8CjJi8SGNlV8bbkk7r1kYPgdWspjiDrOaR3jSAX4rJeV5HxI8XymdPpiF6yHmo19/nz5bzObj5OOfxIaJ+1l3uIzOlGjU8TNcy/lulXbp1FbV3LE6eA7bCedLV++46+1wsq6hEWkaIzksYsNv78ijXTaaeGvKHVFl5FvUpn9IUY1StBGl/kkeZqhRoLodqNkBzG//HyMFjFBQDQYMNtCizNPd3BTqf3tEAaTPEDLbW8TQ63o9MOkRRUPAuJL4aLM5NWY5S7+fMbM8N3A5toQgaMyXtUUqZDrkecO/MYbeCQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762933226; bh=gVqxyx8XLHLaopwe4wlMCOcq9uTxvaJq9QcemRp5n2G=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=qIk8oTQrnDBbQYymVaoLoiNv8yhdvxCwlE6NxDAZpQA5rz6O/GZs7ZCFkuBdtiYehcRYFKhSGe3KcFjiVPowA1ipZ9MHHVKNgi9dMROGvmLA5XhzglAgpNWQx90S4TiQp+ViXz1g7SEjGxQNsBMrzFCfJ78vd23vr8HnMnC+f9uUS5d6Ebf1LYzllaPkNUhPQMvoZdL8LHcq2Wn/Y85wOUuhKBFsxLScarzY4fZdcN6xWm6ZiJns9+ExNhX/UIWI+yEcUt2QhZnsziCUn88X6QTK3sFNWv0LIaUc9xiDAfOLWrgIxOcpmm1pyc9HlBrXwHyuhwadhGGjMXDnJi9LVg==
X-YMail-OSG: 9U1XMnUVM1kcXHY1bpLdAyPjzxHF7CnpCMzre9WThg2_L29CNk_Ft_9.boAitPi
 GVrVeb7gkSVaFyzWdAznSImTbHZwC.Vk1IDCEoq2_gZsBY0TcIf75.ZLSgKEN6vztBTBfvBrIRTV
 Q03auPu_2.rEtmFwVBFEwfagyjp.rm9N2MAQOGXK03UZxjzeoZpkQXTkxRL6sZ5RbY5IW6EDtmwK
 23G1mdEaMEfH.V_oqmU2gqDIjYTPL19EDKRpq3sYZYwEtZYyG1hrhNc_iRUUgbVocTGDHvVEJqNK
 G5Wvp7rIZPUOtNT8QzDIpjSpkqq2oko6GyxqF9.OZjKiWOhm75O8d1kZjgM_8XGVNF1t8uNT8Uwo
 3lmBNzbTMd5St0Q_8x9Nwq1vwxISnSmfRDyzhlKzlKlyFec2puf3A5OxspKbQIs45kH9k6YzW8uB
 qgJ7Z8RXY_CteVJfB.OnvYHruaob36pRO0WudaAVhHY4nS_h0.TKzgwPz7gJcITJA3hrb3p82vAT
 jsz8WOZIstqpn3t75.7r0h44AFIOYiCRElQAwvOptY9QCE.pxLqacX43Q_rKIKYbxMNoLjkCA5aw
 _.eMhugIsP_EJUzga35OASjkwCJqOD.qLIOUdS3qB2UMEmA.LXhjkjIoI6nTscRxFKLoGWvjloVq
 TvNFeN5xNGm4wQQe.DHYK3J5AX1_85Hf6rKy74wk5wss0hq8TlWKZvw50GP6pC0SoOxlTt23.C7U
 P6OVYq_lQ4hJ12DfE4gjayaZZrvIojK8uI6zqr_ks3o_0bJFG0QQcm6zIZamGJokvrAwUN1cZrWx
 YQxLeE9T_odJfL_rComoa7CxffuuvqduEwy05A5XvRlHXe6Uql7c8S2m.GdfkDpYXOI3JrzKkv7F
 TQthbzkqcHqqumx4GD3iqZWBGmvPbcWhht5PpvaH4vXmGpK_Ok2Dyud3JkkrYVwaS8lqy8fwQWiR
 1LU0xZgA4KohJYua.UowZ.JHnbjOspzo3yvz8yMhxQ3s1VD3wriJu.iY25c1WADiamtIW9Adn6vk
 y.wQm0DrRuuhgkXjCq1ZF0CjKcJQTsacidDI7.i2SxnSvQrLs3ikaaDUKso_D5O4yKDRLg5YRVJr
 B59J6LtRf8.FXVvUo4MMlyqBLmOvNAf4DnqwSAy0bnq_Sz2TXPomRAnTn2hMRgdP_idr7Kjy9gmy
 BCVoUerPRXTR2NOEUmnhP.V.xCbYk5i5qTBC7AA4hvtuv39LJzN1o86LMpy1ZUalwgcTNc.g9hSK
 7rvET.04NepTX321dIB0dyqYeaOJchwWtheIqRbAwLDaN8uX1zpmr0zU6oXOGhanXXhuLhiH_IDw
 UOdEDe2q0IPegh.eMsJsPq.k6DitybytH85T5DKTFCR6UrF0oT2WwGNuBhIFhTXXQtN3iZtVulP4
 lohatLmbsq39wZ99IcmAKOCV9omnftNtK6YePSwOCeFvHfque.JfIXrdH469LOAttPpndfP0Pz41
 rtr6v97eGiTTfbs9XRbV5I62rkPRWu6wSqSYF67bcAniceHyH0bhx4KyQru0AKzQYmNlp22tPSUu
 bMxkjiXFeiDZXBXgTXPz5mGIC2QSX_ztelvHN3IEi.c7LZYjWVIK_1hTqDwq9CwTbaU7ldkm8jKF
 Hm.Iqe6pp5JwBcSOx_l5SNmRgOBhLuVhYkh1BFsq9xxOs2mfV3hF4D.XIY4zLNpVo21LJRP3eW0_
 .ihPtUYWiKdKp5cWDQz0QVe5Y.2adPLUOAwsfZ62Thx5nU3trJoPi4_DyDLLrsq3MReT1FakFimD
 N1yVxgXuqo3Cgq1Km_E7VWG7kVR__DPFKtjS9.K8G4CBd9BaWna1cB_808HUVPRlCAlRY_xcSA0h
 RPtNplKKMs_ZxxJuT.Be19irLOFVtZoGXwuQePmExqASFkuEQjmFBWHTPKseQZnzjxnIsMgKwiys
 IzUsYuO3lSWb3uQ4pqF5ug7PEUptOIaSYTNbB3_PNptWd1YQbrdEob6tpMET989tiEJZt0ERusY_
 _ZEbb6fOzY2DBaWGgZ2m90RGDoe0C34MR7a9aWCVgAstDy83PwEyHuQkQKjEteJaDmsoHoEKzW8j
 w7.rNo5ztS86XY_8zsda3ebMo3FYNRXzqHj_vpsMIzeqi3plYWUzww48bQiWzwP6ximjY_CNN.zR
 logopdP8eOEcdUlHdMHQ8Y8hTpmFGIlLNPUyiDNAXhqabW96IAxAg5ATs64hERhn7tQzVj6kNjpi
 at.4-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: dc3e7a2a-b0ec-48d6-ab57-733d8763aaf7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 12 Nov 2025 07:40:26 +0000
Received: by hermes--production-ir2-5fcfdd8d7f-2cnbk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ce2e5d13638178c4daec60c4681fbbb6;
          Wed, 12 Nov 2025 07:28:10 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v4 02/14] net: skb: use dstref for storing dst entry
Date: Wed, 12 Nov 2025 08:27:08 +0100
Message-ID: <20251112072720.5076-3-mmietus97@yahoo.com>
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

Use the newly introduced dstref object for storing the dst entry
in skb instead of using _skb_refdst, and remove code related
to _skb_refdst.

This is mostly a cosmetic improvement. It improves readability
of functions that previously had to awkwardly access the
internal _skb_refdst, or use its value directly by storing it
in an unsigned long. (this can be seen in pktgen_output_ipsec)

This also fixes functions that used the raw refdst value incorrectly,
which may have resulted in subtle bugs, such as in __skb_dst_copy,
where the refdst value was used directly. (could have resulted in
slow_gro being set even when the dst was NULL if the refdst had the
noref bit set)

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 include/linux/skbuff.h                  | 63 +++++++++----------------
 include/net/dst.h                       | 26 ++++------
 include/net/dst_metadata.h              |  6 +--
 include/net/tcp.h                       |  9 ++--
 net/core/pktgen.c                       |  2 +-
 net/ieee802154/6lowpan/reassembly.c     |  5 +-
 net/ipv4/icmp.c                         |  6 +--
 net/ipv4/ip_fragment.c                  |  5 +-
 net/ipv4/ip_options.c                   |  8 ++--
 net/ipv6/netfilter/nf_conntrack_reasm.c |  5 +-
 net/ipv6/reassembly.c                   |  5 +-
 net/openvswitch/actions.c               | 16 +++----
 net/openvswitch/datapath.h              |  2 +-
 net/sched/sch_frag.c                    | 18 +++----
 14 files changed, 71 insertions(+), 105 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index fb3fec9affaa..c46f817897a4 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -39,6 +39,7 @@
 #include <net/net_debug.h>
 #include <net/dropreason-core.h>
 #include <net/netmem.h>
+#include <net/dstref.h>
 
 /**
  * DOC: skb checksums
@@ -786,7 +787,7 @@ enum skb_tstamp_type {
  *	@dev: Device we arrived on/are leaving by
  *	@dev_scratch: (aka @dev) alternate use of @dev when @dev would be %NULL
  *	@cb: Control buffer. Free for use by every layer. Put private vars here
- *	@_skb_refdst: destination entry (with norefcount bit)
+ *	@_dstref: dstref object pointing to a destination entry
  *	@len: Length of actual data
  *	@data_len: Data length
  *	@mac_len: Length of link layer header
@@ -919,7 +920,7 @@ struct sk_buff {
 
 	union {
 		struct {
-			unsigned long	_skb_refdst;
+			dstref_t	_dstref;
 			void		(*destructor)(struct sk_buff *skb);
 		};
 		struct list_head	tcp_tsorted_anchor;
@@ -1141,13 +1142,6 @@ static inline bool skb_pfmemalloc(const struct sk_buff *skb)
 	return unlikely(skb->pfmemalloc);
 }
 
-/*
- * skb might have a dst pointer attached, refcounted or not.
- * _skb_refdst low order bit is set if refcount was _not_ taken
- */
-#define SKB_DST_NOREF	1UL
-#define SKB_DST_PTRMASK	~(SKB_DST_NOREF)
-
 /**
  * skb_dst - returns skb dst_entry
  * @skb: buffer
@@ -1156,52 +1150,40 @@ static inline bool skb_pfmemalloc(const struct sk_buff *skb)
  */
 static inline struct dst_entry *skb_dst(const struct sk_buff *skb)
 {
-	/* If refdst was not refcounted, check we still are in a
-	 * rcu_read_lock section
-	 */
-	WARN_ON((skb->_skb_refdst & SKB_DST_NOREF) &&
-		!rcu_read_lock_held() &&
-		!rcu_read_lock_bh_held());
-	return (struct dst_entry *)(skb->_skb_refdst & SKB_DST_PTRMASK);
+	return dstref_dst(skb->_dstref);
 }
 
 static inline void skb_dst_check_unset(struct sk_buff *skb)
 {
-	DEBUG_NET_WARN_ON_ONCE((skb->_skb_refdst & SKB_DST_PTRMASK) &&
-			       !(skb->_skb_refdst & SKB_DST_NOREF));
+	DEBUG_NET_WARN_ON_ONCE(__dstref_dst(skb->_dstref) &&
+			       !dstref_is_noref(skb->_dstref));
 }
 
 /**
- * skb_dstref_steal() - return current dst_entry value and clear it
+ * skb_dstref_steal() - return current dstref object and clear it
  * @skb: buffer
  *
- * Resets skb dst_entry without adjusting its reference count. Useful in
- * cases where dst_entry needs to be temporarily reset and restored.
- * Note that the returned value cannot be used directly because it
- * might contain SKB_DST_NOREF bit.
- *
- * When in doubt, prefer skb_dst_drop() over skb_dstref_steal() to correctly
- * handle dst_entry reference counting.
+ * Steals the dstref from the skb, returns it, and leaves an empty dstref instead.
  *
- * Returns: original skb dst_entry.
+ * Returns: original dstref object.
  */
-static inline unsigned long skb_dstref_steal(struct sk_buff *skb)
+static inline dstref_t skb_dstref_steal(struct sk_buff *skb)
 {
-	unsigned long refdst = skb->_skb_refdst;
+	dstref_t dstref = skb->_dstref;
 
-	skb->_skb_refdst = 0;
-	return refdst;
+	skb->_dstref = DSTREF_EMPTY;
+	return dstref;
 }
 
 /**
- * skb_dstref_restore() - restore skb dst_entry removed via skb_dstref_steal()
+ * skb_dstref_restore() - restore skb dstref removed via skb_dstref_steal()
  * @skb: buffer
- * @refdst: dst entry from a call to skb_dstref_steal()
+ * @dstref: dstref object from a call to skb_dstref_steal()
  */
-static inline void skb_dstref_restore(struct sk_buff *skb, unsigned long refdst)
+static inline void skb_dstref_restore(struct sk_buff *skb, dstref_t dstref)
 {
 	skb_dst_check_unset(skb);
-	skb->_skb_refdst = refdst;
+	skb->_dstref = dstref;
 }
 
 /**
@@ -1216,7 +1198,7 @@ static inline void skb_dst_set(struct sk_buff *skb, struct dst_entry *dst)
 {
 	skb_dst_check_unset(skb);
 	skb->slow_gro |= !!dst;
-	skb->_skb_refdst = (unsigned long)dst;
+	skb->_dstref = dst_to_dstref(dst);
 }
 
 /**
@@ -1226,15 +1208,14 @@ static inline void skb_dst_set(struct sk_buff *skb, struct dst_entry *dst)
  *
  * Sets skb dst, assuming a reference was not taken on dst.
  * If dst entry is cached, we do not take reference and dst_release
- * will be avoided by refdst_drop. If dst entry is not cached, we take
+ * will be avoided by dstref_drop. If dst entry is not cached, we take
  * reference, so that last dst_release can destroy the dst immediately.
  */
 static inline void skb_dst_set_noref(struct sk_buff *skb, struct dst_entry *dst)
 {
 	skb_dst_check_unset(skb);
-	WARN_ON(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
 	skb->slow_gro |= !!dst;
-	skb->_skb_refdst = (unsigned long)dst | SKB_DST_NOREF;
+	skb->_dstref = dst_to_dstref_noref(dst);
 }
 
 /**
@@ -1243,7 +1224,7 @@ static inline void skb_dst_set_noref(struct sk_buff *skb, struct dst_entry *dst)
  */
 static inline bool skb_dst_is_noref(const struct sk_buff *skb)
 {
-	return (skb->_skb_refdst & SKB_DST_NOREF) && skb_dst(skb);
+	return dstref_is_noref(skb->_dstref) && skb_dst(skb);
 }
 
 /* For mangling skb->pkt_type from user space side from applications
@@ -5088,7 +5069,7 @@ static inline bool skb_irq_freeable(const struct sk_buff *skb)
 	return !skb->destructor &&
 		!secpath_exists(skb) &&
 		!skb_nfct(skb) &&
-		!skb->_skb_refdst &&
+		!__dstref_dst(skb->_dstref) &&
 		!skb_has_frag_list(skb);
 }
 
diff --git a/include/net/dst.h b/include/net/dst.h
index d7169f067637..47458e51a89c 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -288,12 +288,6 @@ static inline dstref_t dstref_clone(dstref_t dstref)
 	return dstref;
 }
 
-static inline void refdst_drop(unsigned long refdst)
-{
-	if (!(refdst & SKB_DST_NOREF))
-		dst_release((struct dst_entry *)(refdst & SKB_DST_PTRMASK));
-}
-
 /**
  * skb_dst_drop - drops skb dst
  * @skb: buffer
@@ -302,23 +296,19 @@ static inline void refdst_drop(unsigned long refdst)
  */
 static inline void skb_dst_drop(struct sk_buff *skb)
 {
-	if (skb->_skb_refdst) {
-		refdst_drop(skb->_skb_refdst);
-		skb->_skb_refdst = 0UL;
-	}
+	dstref_drop(skb->_dstref);
+	skb->_dstref = DSTREF_EMPTY;
 }
 
-static inline void __skb_dst_copy(struct sk_buff *nskb, unsigned long refdst)
+static inline void __skb_dst_copy(struct sk_buff *nskb, dstref_t dstref)
 {
-	nskb->slow_gro |= !!refdst;
-	nskb->_skb_refdst = refdst;
-	if (!(nskb->_skb_refdst & SKB_DST_NOREF))
-		dst_clone(skb_dst(nskb));
+	nskb->slow_gro |= !!__dstref_dst(dstref);
+	nskb->_dstref = dstref_clone(dstref);
 }
 
 static inline void skb_dst_copy(struct sk_buff *nskb, const struct sk_buff *oskb)
 {
-	__skb_dst_copy(nskb, oskb->_skb_refdst);
+	__skb_dst_copy(nskb, oskb->_dstref);
 }
 
 /**
@@ -349,11 +339,11 @@ static inline bool skb_dst_force(struct sk_buff *skb)
 		if (!dst_hold_safe(dst))
 			dst = NULL;
 
-		skb->_skb_refdst = (unsigned long)dst;
+		skb->_dstref = dst_to_dstref(dst);
 		skb->slow_gro |= !!dst;
 	}
 
-	return skb->_skb_refdst != 0UL;
+	return __dstref_dst(skb->_dstref) != NULL;
 }
 
 
diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
index 1fc2fb03ce3f..109322ef0d25 100644
--- a/include/net/dst_metadata.h
+++ b/include/net/dst_metadata.h
@@ -102,12 +102,12 @@ static inline int skb_metadata_dst_cmp(const struct sk_buff *skb_a,
 {
 	const struct metadata_dst *a, *b;
 
-	if (!(skb_a->_skb_refdst | skb_b->_skb_refdst))
-		return 0;
-
 	a = (const struct metadata_dst *) skb_dst(skb_a);
 	b = (const struct metadata_dst *) skb_dst(skb_b);
 
+	if (!a && !b)
+		return 0;
+
 	if (!a != !b || a->type != b->type)
 		return 1;
 
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 190b3714e93b..e684f246e798 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2091,20 +2091,19 @@ void tcp_chrono_start(struct sock *sk, const enum tcp_chrono type);
 void tcp_chrono_stop(struct sock *sk, const enum tcp_chrono type);
 
 /* This helper is needed, because skb->tcp_tsorted_anchor uses
- * the same memory storage than skb->destructor/_skb_refdst
+ * the same memory storage than skb->destructor/_dstref
  */
 static inline void tcp_skb_tsorted_anchor_cleanup(struct sk_buff *skb)
 {
 	skb->destructor = NULL;
-	skb->_skb_refdst = 0UL;
+	skb->_dstref = DSTREF_EMPTY;
 }
 
 #define tcp_skb_tsorted_save(skb) {		\
-	unsigned long _save = skb->_skb_refdst;	\
-	skb->_skb_refdst = 0UL;
+	dstref_t _dstref_save = skb_dstref_steal(skb);
 
 #define tcp_skb_tsorted_restore(skb)		\
-	skb->_skb_refdst = _save;		\
+	skb_dstref_restore(skb, _dstref_save);	\
 }
 
 void tcp_write_queue_purge(struct sock *sk);
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index d41b03fd1f63..e0ac4fbaed06 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -2713,7 +2713,7 @@ static int pktgen_output_ipsec(struct sk_buff *skb, struct pktgen_dev *pkt_dev)
 	 * supports both transport/tunnel mode + ESP/AH type.
 	 */
 	if ((x->props.mode == XFRM_MODE_TUNNEL) && (pkt_dev->spi != 0))
-		skb->_skb_refdst = (unsigned long)&pkt_dev->xdst.u.dst | SKB_DST_NOREF;
+		skb->_dstref = dst_to_dstref_noref(&pkt_dev->xdst.u.dst);
 
 	rcu_read_lock_bh();
 	err = pktgen_xfrm_outer_mode_output(x, skb);
diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index ddb6a5817d09..eb23c70c7416 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -142,12 +142,11 @@ static int lowpan_frag_queue(struct lowpan_frag_queue *fq,
 
 	if (fq->q.flags == (INET_FRAG_FIRST_IN | INET_FRAG_LAST_IN) &&
 	    fq->q.meat == fq->q.len) {
+		dstref_t dstref = skb_dstref_steal(skb);
 		int res;
-		unsigned long orefdst = skb->_skb_refdst;
 
-		skb->_skb_refdst = 0UL;
 		res = lowpan_frag_reasm(fq, skb, prev_tail, ldev, refs);
-		skb->_skb_refdst = orefdst;
+		skb_dstref_restore(skb, dstref);
 		return res;
 	}
 	skb_dst_drop(skb);
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 1b7fb5d935ed..6b19a0ffea21 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -536,7 +536,7 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
 			err = PTR_ERR(rt2);
 	} else {
 		struct flowi4 fl4_2 = {};
-		unsigned long orefdst;
+		dstref_t dstref;
 
 		fl4_2.daddr = fl4_dec.saddr;
 		rt2 = ip_route_output_key(net, &fl4_2);
@@ -545,7 +545,7 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
 			goto relookup_failed;
 		}
 		/* Ugh! */
-		orefdst = skb_dstref_steal(skb_in);
+		dstref = skb_dstref_steal(skb_in);
 		err = ip_route_input(skb_in, fl4_dec.daddr, fl4_dec.saddr,
 				     dscp, rt2->dst.dev) ? -EINVAL : 0;
 
@@ -553,7 +553,7 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
 		rt2 = skb_rtable(skb_in);
 		/* steal dst entry from skb_in, don't drop refcnt */
 		skb_dstref_steal(skb_in);
-		skb_dstref_restore(skb_in, orefdst);
+		skb_dstref_restore(skb_in, dstref);
 	}
 
 	if (err)
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index f7012479713b..33080c5350ed 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -365,11 +365,10 @@ static int ip_frag_queue(struct ipq *qp, struct sk_buff *skb, int *refs)
 
 	if (qp->q.flags == (INET_FRAG_FIRST_IN | INET_FRAG_LAST_IN) &&
 	    qp->q.meat == qp->q.len) {
-		unsigned long orefdst = skb->_skb_refdst;
+		dstref_t dstref = skb_dstref_steal(skb);
 
-		skb->_skb_refdst = 0UL;
 		err = ip_frag_reasm(qp, skb, prev_tail, dev, refs);
-		skb->_skb_refdst = orefdst;
+		skb_dstref_restore(skb, dstref);
 		if (err)
 			inet_frag_kill(&qp->q, refs);
 		return err;
diff --git a/net/ipv4/ip_options.c b/net/ipv4/ip_options.c
index be8815ce3ac2..d6c712269052 100644
--- a/net/ipv4/ip_options.c
+++ b/net/ipv4/ip_options.c
@@ -591,7 +591,7 @@ int ip_options_rcv_srr(struct sk_buff *skb, struct net_device *dev)
 	unsigned char *optptr = skb_network_header(skb) + opt->srr;
 	struct rtable *rt = skb_rtable(skb);
 	struct rtable *rt2;
-	unsigned long orefdst;
+	dstref_t dstref;
 	int err;
 
 	if (!rt)
@@ -615,16 +615,16 @@ int ip_options_rcv_srr(struct sk_buff *skb, struct net_device *dev)
 		}
 		memcpy(&nexthop, &optptr[srrptr-1], 4);
 
-		orefdst = skb_dstref_steal(skb);
+		dstref = skb_dstref_steal(skb);
 		err = ip_route_input(skb, nexthop, iph->saddr, ip4h_dscp(iph),
 				     dev) ? -EINVAL : 0;
 		rt2 = skb_rtable(skb);
 		if (err || (rt2->rt_type != RTN_UNICAST && rt2->rt_type != RTN_LOCAL)) {
 			skb_dst_drop(skb);
-			skb_dstref_restore(skb, orefdst);
+			skb_dstref_restore(skb, dstref);
 			return -EINVAL;
 		}
-		refdst_drop(orefdst);
+		dstref_drop(dstref);
 		if (rt2->rt_type != RTN_LOCAL)
 			break;
 		/* Superfast 8) loopback forward */
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index 64ab23ff559b..9fab51fb9497 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -286,11 +286,10 @@ static int nf_ct_frag6_queue(struct frag_queue *fq, struct sk_buff *skb,
 
 	if (fq->q.flags == (INET_FRAG_FIRST_IN | INET_FRAG_LAST_IN) &&
 	    fq->q.meat == fq->q.len) {
-		unsigned long orefdst = skb->_skb_refdst;
+		dstref_t dstref = skb_dstref_steal(skb);
 
-		skb->_skb_refdst = 0UL;
 		err = nf_ct_frag6_reasm(fq, skb, prev, dev, refs);
-		skb->_skb_refdst = orefdst;
+		skb_dstref_restore(skb, dstref);
 
 		/* After queue has assumed skb ownership, only 0 or
 		 * -EINPROGRESS must be returned.
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 25ec8001898d..aa8427f56ff3 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -218,11 +218,10 @@ static int ip6_frag_queue(struct net *net,
 
 	if (fq->q.flags == (INET_FRAG_FIRST_IN | INET_FRAG_LAST_IN) &&
 	    fq->q.meat == fq->q.len) {
-		unsigned long orefdst = skb->_skb_refdst;
+		dstref_t dstref = skb_dstref_steal(skb);
 
-		skb->_skb_refdst = 0UL;
 		err = ip6_frag_reasm(fq, skb, prev_tail, dev, refs);
-		skb->_skb_refdst = orefdst;
+		skb_dstref_restore(skb, dstref);
 		return err;
 	}
 
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 2832e0794197..31ec8c9e0758 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -761,7 +761,7 @@ static int ovs_vport_output(struct net *net, struct sock *sk,
 		return -ENOMEM;
 	}
 
-	__skb_dst_copy(skb, data->dst);
+	__skb_dst_copy(skb, data->dstref);
 	*OVS_CB(skb) = data->cb;
 	skb->inner_protocol = data->inner_protocol;
 	if (data->vlan_tci & VLAN_CFI_MASK)
@@ -806,7 +806,7 @@ static void prepare_frag(struct vport *vport, struct sk_buff *skb,
 	struct ovs_frag_data *data;
 
 	data = this_cpu_ptr(&ovs_pcpu_storage->frag_data);
-	data->dst = skb->_skb_refdst;
+	data->dstref = skb->_dstref;
 	data->vport = vport;
 	data->cb = *OVS_CB(skb);
 	data->inner_protocol = skb->inner_protocol;
@@ -844,7 +844,7 @@ static void ovs_fragment(struct net *net, struct vport *vport,
 
 	if (key->eth.type == htons(ETH_P_IP)) {
 		struct rtable ovs_rt = { 0 };
-		unsigned long orig_dst;
+		dstref_t orig_dstref;
 
 		prepare_frag(vport, skb, orig_network_offset,
 			     ovs_key_mac_proto(key));
@@ -852,14 +852,14 @@ static void ovs_fragment(struct net *net, struct vport *vport,
 			 DST_OBSOLETE_NONE, DST_NOCOUNT);
 		ovs_rt.dst.dev = vport->dev;
 
-		orig_dst = skb->_skb_refdst;
+		orig_dstref = skb->_dstref;
 		skb_dst_set_noref(skb, &ovs_rt.dst);
 		IPCB(skb)->frag_max_size = mru;
 
 		ip_do_fragment(net, skb->sk, skb, ovs_vport_output);
-		refdst_drop(orig_dst);
+		dstref_drop(orig_dstref);
 	} else if (key->eth.type == htons(ETH_P_IPV6)) {
-		unsigned long orig_dst;
+		dstref_t orig_dstref;
 		struct rt6_info ovs_rt;
 
 		prepare_frag(vport, skb, orig_network_offset,
@@ -869,12 +869,12 @@ static void ovs_fragment(struct net *net, struct vport *vport,
 			 DST_OBSOLETE_NONE, DST_NOCOUNT);
 		ovs_rt.dst.dev = vport->dev;
 
-		orig_dst = skb->_skb_refdst;
+		orig_dstref = skb->_dstref;
 		skb_dst_set_noref(skb, &ovs_rt.dst);
 		IP6CB(skb)->frag_max_size = mru;
 
 		ipv6_stub->ipv6_fragment(net, skb->sk, skb, ovs_vport_output);
-		refdst_drop(orig_dst);
+		dstref_drop(orig_dstref);
 	} else {
 		WARN_ONCE(1, "Failed fragment ->%s: eth=%04x, MRU=%d, MTU=%d.",
 			  ovs_vport_name(vport), ntohs(key->eth.type), mru,
diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index db0c3e69d66c..6bc15cb3a363 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -179,7 +179,7 @@ struct ovs_net {
 
 #define MAX_L2_LEN	(VLAN_ETH_HLEN + 3 * MPLS_HLEN)
 struct ovs_frag_data {
-	unsigned long dst;
+	dstref_t dstref;
 	struct vport *vport;
 	struct ovs_skb_cb cb;
 	__be16 inner_protocol;
diff --git a/net/sched/sch_frag.c b/net/sched/sch_frag.c
index d1d87dce7f3f..bafbbac761da 100644
--- a/net/sched/sch_frag.c
+++ b/net/sched/sch_frag.c
@@ -8,7 +8,7 @@
 #include <net/ip6_fib.h>
 
 struct sch_frag_data {
-	unsigned long dst;
+	dstref_t dstref;
 	struct qdisc_skb_cb cb;
 	__be16 inner_protocol;
 	u16 vlan_tci;
@@ -33,7 +33,7 @@ static int sch_frag_xmit(struct net *net, struct sock *sk, struct sk_buff *skb)
 		return -ENOMEM;
 	}
 
-	__skb_dst_copy(skb, data->dst);
+	__skb_dst_copy(skb, data->dstref);
 	*qdisc_skb_cb(skb) = data->cb;
 	skb->inner_protocol = data->inner_protocol;
 	if (data->vlan_tci & VLAN_CFI_MASK)
@@ -58,7 +58,7 @@ static void sch_frag_prepare_frag(struct sk_buff *skb,
 	struct sch_frag_data *data;
 
 	data = this_cpu_ptr(&sch_frag_data_storage);
-	data->dst = skb->_skb_refdst;
+	data->dstref = skb->_dstref;
 	data->cb = *qdisc_skb_cb(skb);
 	data->xmit = xmit;
 	data->inner_protocol = skb->inner_protocol;
@@ -97,7 +97,7 @@ static int sch_fragment(struct net *net, struct sk_buff *skb,
 
 	if (skb_protocol(skb, true) == htons(ETH_P_IP)) {
 		struct rtable sch_frag_rt = { 0 };
-		unsigned long orig_dst;
+		dstref_t orig_dstref;
 
 		local_lock_nested_bh(&sch_frag_data_storage.bh_lock);
 		sch_frag_prepare_frag(skb, xmit);
@@ -105,15 +105,15 @@ static int sch_fragment(struct net *net, struct sk_buff *skb,
 			 DST_OBSOLETE_NONE, DST_NOCOUNT);
 		sch_frag_rt.dst.dev = skb->dev;
 
-		orig_dst = skb->_skb_refdst;
+		orig_dstref = skb->_dstref;
 		skb_dst_set_noref(skb, &sch_frag_rt.dst);
 		IPCB(skb)->frag_max_size = mru;
 
 		ret = ip_do_fragment(net, skb->sk, skb, sch_frag_xmit);
 		local_unlock_nested_bh(&sch_frag_data_storage.bh_lock);
-		refdst_drop(orig_dst);
+		dstref_drop(orig_dstref);
 	} else if (skb_protocol(skb, true) == htons(ETH_P_IPV6)) {
-		unsigned long orig_dst;
+		dstref_t orig_dstref;
 		struct rt6_info sch_frag_rt;
 
 		local_lock_nested_bh(&sch_frag_data_storage.bh_lock);
@@ -123,14 +123,14 @@ static int sch_fragment(struct net *net, struct sk_buff *skb,
 			 DST_OBSOLETE_NONE, DST_NOCOUNT);
 		sch_frag_rt.dst.dev = skb->dev;
 
-		orig_dst = skb->_skb_refdst;
+		orig_dstref = skb->_dstref;
 		skb_dst_set_noref(skb, &sch_frag_rt.dst);
 		IP6CB(skb)->frag_max_size = mru;
 
 		ret = ipv6_stub->ipv6_fragment(net, skb->sk, skb,
 					       sch_frag_xmit);
 		local_unlock_nested_bh(&sch_frag_data_storage.bh_lock);
-		refdst_drop(orig_dst);
+		dstref_drop(orig_dstref);
 	} else {
 		net_warn_ratelimited("Fail frag %s: eth=%x, MRU=%d, MTU=%d\n",
 				     netdev_name(skb->dev),
-- 
2.51.0


