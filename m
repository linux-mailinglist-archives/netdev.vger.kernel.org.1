Return-Path: <netdev+bounces-132473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F98991CD1
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 08:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBB641F22C9B
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 06:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B08B16EBEE;
	Sun,  6 Oct 2024 06:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdxcwWQu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7774249F9;
	Sun,  6 Oct 2024 06:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728197832; cv=none; b=F/jYHjSS8aupeODW33JGrJfKNoQnDeQpue0+Mw2axyFOWR+Qzb9DxPBrBB+OuDOGyOslPt/Phasrl6usI7GvaylYE6+BTD+Qe+8Z3tF4/Z0MvlRI1Pky5QPQGJxhEL0yF67SG4uQ0DyGcj+gUUOlWFxXjmlXUkgkKLJzdkd2IN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728197832; c=relaxed/simple;
	bh=Frgop5dI3MpmoWzTS13lVakpm6NizzC07ixLgWUG7hU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JzEjFFtI9zIgbWiGEMksabSzHPjzbobgvApDo1JSqASYUGz6jIgqjTPFZIOGwMORLhl4EK3Xwu+2oVlRljJFT0mZ9SUSojQZmjytOFCrZaI/gG5W1RhyVp95plCL4mEckDswxJuhlwt25lxMSGDCeG84fWReIgblwkQjxK115dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdxcwWQu; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-7db908c9c83so2080933a12.2;
        Sat, 05 Oct 2024 23:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728197830; x=1728802630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+57bNIoFOfo1YPD2Iy9OO/eMOStU8dZYyQFQ7Wq2lE=;
        b=UdxcwWQuK56wrsmKaBSuZMgHFpbpHoYxMnDryXE/Mfg6vwZ6NO2GK5PKlRMobcrXcu
         WzlwbdmAZoXt6M5YLWr7QeDKBZhJWH8b0s9mQwr7yOEq+mxr5m/FzKxlmLPcvzs6nTkP
         ndt/7BOhpYmkOU0fzC4+geTY23l6fBQdawjXhU+rsVqHnV2fQAp5PZXw5NEx5J+pVY3Q
         WaDRv1FgK15Z8SzvbjOv09ai2iS+P8Q4wBhE2glIQURVrLpIh2RnsOb3H1L8uO2yBaeJ
         XzBc8Fq8fr1E6YuUe4/3/tl4u24nH5VY66RxcEdGGJmxhuFl2fuyEsv/1mY5wN3bbAVp
         xyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728197830; x=1728802630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+57bNIoFOfo1YPD2Iy9OO/eMOStU8dZYyQFQ7Wq2lE=;
        b=DIrYU+lP25RGQBcOcKpiihSHbGze7iBpS5tt4flhHylx3TY2LCfZNv58x+PsgcH4V/
         PGYkp3I4J269DlR3rHnoWb0VVueW1CK7tAS2gnhph35qyEyJCNH2duRsjP+CyT8Xd8gr
         MdLWk9hVpenbUIB3EY8Z1LqoEq4kmJG4Y45uX8K3/jZS0+E/JB0VB+jzeYE4JFVWntDg
         MTGpoegq1olPqgf6AVXPRRdLBi8HHSsq575c/FsXusKiMBsDU/R8eVxdEUU9/vZ6/DGt
         HXiRd3s5O2I4vz6T17/BIvKnt5LFxKxtx8Ul4POni4gqiyKtGLGb1+m/HkXU9gnaYmym
         dUgA==
X-Forwarded-Encrypted: i=1; AJvYcCXdwWbw+QEjd7PAskH9NU/5Cq9Rgk8UVygWIsEiXnTyXvQjY/vojVMJIXQv/I3yPO4SF9Ic/EwR5+i747A=@vger.kernel.org, AJvYcCXz5qAcUZNSnrqwKXGvzFqOTwZhShOMRuXRDXf2ZeUfVO3tyahms4/nSrVmAhioV3I7Q2i621tP@vger.kernel.org
X-Gm-Message-State: AOJu0YykApU3AoKZOfrQzV8gk+H+pT5lGcDI5zu/BDsnuT3FO1kAPkcK
	Sx8HCalTVMyfs2QXBZlNt4fHSSseLy0qnUIqQONn7a+//Wt43X/Q
X-Google-Smtp-Source: AGHT+IF16Q0VFxMmBbVU5wZu/KZiIVVjG+ymcsTyHDlpfITH1HwpjHwRb8kaotXJhZDFgNATyDvS8Q==
X-Received: by 2002:a17:902:e745:b0:20b:9c8c:e9f3 with SMTP id d9443c01a7336-20bfe05cfb6mr134162745ad.14.1728197830122;
        Sat, 05 Oct 2024 23:57:10 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138af813sm21749865ad.9.2024.10.05.23.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 23:57:09 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org,
	aleksander.lobakin@intel.com,
	horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v5 04/12] net: vxlan: add skb drop reasons to vxlan_rcv()
Date: Sun,  6 Oct 2024 14:56:08 +0800
Message-Id: <20241006065616.2563243-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241006065616.2563243-1-dongml2@chinatelecom.cn>
References: <20241006065616.2563243-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce skb drop reasons to the function vxlan_rcv(). Following new
drop reasons are added:

  SKB_DROP_REASON_VXLAN_INVALID_HDR
  SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND
  SKB_DROP_REASON_IP_TUNNEL_ECN

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v3:
- modify vxlan_set_mac() and vxlan_remcsum() after this patch
v2:
- rename the drop reasons, as Ido advised.
- document the drop reasons
---
 drivers/net/vxlan/vxlan_core.c | 26 ++++++++++++++++++++------
 include/net/dropreason-core.h  | 16 ++++++++++++++++
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 0359c750d81e..4997a2c09c14 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1671,13 +1671,15 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	struct vxlan_metadata _md;
 	struct vxlan_metadata *md = &_md;
 	__be16 protocol = htons(ETH_P_TEB);
+	enum skb_drop_reason reason;
 	bool raw_proto = false;
 	void *oiph;
 	__be32 vni = 0;
 	int nh;
 
 	/* Need UDP and VXLAN header to be present */
-	if (!pskb_may_pull(skb, VXLAN_HLEN))
+	reason = pskb_may_pull_reason(skb, VXLAN_HLEN);
+	if (reason)
 		goto drop;
 
 	unparsed = *vxlan_hdr(skb);
@@ -1686,6 +1688,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		netdev_dbg(skb->dev, "invalid vxlan flags=%#x vni=%#x\n",
 			   ntohl(vxlan_hdr(skb)->vx_flags),
 			   ntohl(vxlan_hdr(skb)->vx_vni));
+		reason = SKB_DROP_REASON_VXLAN_INVALID_HDR;
 		/* Return non vxlan pkt */
 		goto drop;
 	}
@@ -1699,8 +1702,10 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	vni = vxlan_vni(vxlan_hdr(skb)->vx_vni);
 
 	vxlan = vxlan_vs_find_vni(vs, skb->dev->ifindex, vni, &vninode);
-	if (!vxlan)
+	if (!vxlan) {
+		reason = SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND;
 		goto drop;
+	}
 
 	/* For backwards compatibility, only allow reserved fields to be
 	 * used by VXLAN extensions if explicitly requested.
@@ -1713,8 +1718,10 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	}
 
 	if (__iptunnel_pull_header(skb, VXLAN_HLEN, protocol, raw_proto,
-				   !net_eq(vxlan->net, dev_net(vxlan->dev))))
+				   !net_eq(vxlan->net, dev_net(vxlan->dev)))) {
+		reason = SKB_DROP_REASON_NOMEM;
 		goto drop;
+	}
 
 	if (vs->flags & VXLAN_F_REMCSUM_RX)
 		if (unlikely(!vxlan_remcsum(&unparsed, skb, vs->flags)))
@@ -1728,8 +1735,10 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		tun_dst = udp_tun_rx_dst(skb, vxlan_get_sk_family(vs), flags,
 					 key32_to_tunnel_id(vni), sizeof(*md));
 
-		if (!tun_dst)
+		if (!tun_dst) {
+			reason = SKB_DROP_REASON_NOMEM;
 			goto drop;
+		}
 
 		md = ip_tunnel_info_opts(&tun_dst->u.tun_info);
 
@@ -1753,6 +1762,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		 * is more robust and provides a little more security in
 		 * adding extensions to VXLAN.
 		 */
+		reason = SKB_DROP_REASON_VXLAN_INVALID_HDR;
 		goto drop;
 	}
 
@@ -1773,7 +1783,8 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 
 	skb_reset_network_header(skb);
 
-	if (!pskb_inet_may_pull(skb)) {
+	reason = pskb_inet_may_pull_reason(skb);
+	if (reason) {
 		DEV_STATS_INC(vxlan->dev, rx_length_errors);
 		DEV_STATS_INC(vxlan->dev, rx_errors);
 		vxlan_vnifilter_count(vxlan, vni, vninode,
@@ -1785,6 +1796,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	oiph = skb->head + nh;
 
 	if (!vxlan_ecn_decapsulate(vs, oiph, skb)) {
+		reason = SKB_DROP_REASON_IP_TUNNEL_ECN;
 		DEV_STATS_INC(vxlan->dev, rx_frame_errors);
 		DEV_STATS_INC(vxlan->dev, rx_errors);
 		vxlan_vnifilter_count(vxlan, vni, vninode,
@@ -1799,6 +1811,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		dev_core_stats_rx_dropped_inc(vxlan->dev);
 		vxlan_vnifilter_count(vxlan, vni, vninode,
 				      VXLAN_VNI_STATS_RX_DROPS, 0);
+		reason = SKB_DROP_REASON_DEV_READY;
 		goto drop;
 	}
 
@@ -1811,8 +1824,9 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 drop:
+	reason = reason ?: SKB_DROP_REASON_NOT_SPECIFIED;
 	/* Consume bad packet */
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return 0;
 }
 
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 4748680e8c88..98259d2b3e92 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -92,6 +92,9 @@
 	FN(PACKET_SOCK_ERROR)		\
 	FN(TC_CHAIN_NOTFOUND)		\
 	FN(TC_RECLASSIFY_LOOP)		\
+	FN(VXLAN_INVALID_HDR)		\
+	FN(VXLAN_VNI_NOT_FOUND)		\
+	FN(IP_TUNNEL_ECN)		\
 	FNe(MAX)
 
 /**
@@ -418,6 +421,19 @@ enum skb_drop_reason {
 	 * iterations.
 	 */
 	SKB_DROP_REASON_TC_RECLASSIFY_LOOP,
+	/**
+	 * @SKB_DROP_REASON_VXLAN_INVALID_HDR: VXLAN header is invalid. E.g.:
+	 * 1) reserved fields are not zero
+	 * 2) "I" flag is not set
+	 */
+	SKB_DROP_REASON_VXLAN_INVALID_HDR,
+	/** @SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND: no VXLAN device found for VNI */
+	SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND,
+	/**
+	 * @SKB_DROP_REASON_IP_TUNNEL_ECN: skb is dropped according to
+	 * RFC 6040 4.2, see __INET_ECN_decapsulate() for detail.
+	 */
+	SKB_DROP_REASON_IP_TUNNEL_ECN,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
-- 
2.39.5


