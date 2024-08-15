Return-Path: <netdev+bounces-118833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74458952E7D
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19C5C285AA6
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2E81A08DB;
	Thu, 15 Aug 2024 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdEd9IZf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC7819D8B5;
	Thu, 15 Aug 2024 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725974; cv=none; b=kKbYR4Oy71uti13+ivIryxArioN7Tv1JdLUIFq2SdlR2/PXUMDJqsCILCJwcrIvtok0/FO3AtmZu+1EaVzuWXb1rOn2NWuUV74XjuH37J4ZPis35u6dEiBZmgc79S8ZQ+gfaFivspldQSigAu2tsF9XUjfq7kUWdblfRjfgPX5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725974; c=relaxed/simple;
	bh=kijj1/AFXNkC+5igNj4phJYmZKPlr4zd/y0SMGAtjgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T0v7MfQh0QZQdVlJNvf48704q+aLo9428BM6LKohX5xC3kZ65+KnV9GkGQ0/i/RJmeHa2xdel59csflWwcUjfaqCad256kOrfMggVm3dB8x0RAUJFIyLLN8mK/xWoHgVT+CkXClzew3rWDiXX/vXF66rVTyiFYRtowzatBktrKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdEd9IZf; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-70eae5896bcso726004b3a.2;
        Thu, 15 Aug 2024 05:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723725972; x=1724330772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MkzFShyb9+4TRjrRvu+V84H/xt2mywXwxPvbQCkE2k=;
        b=ZdEd9IZfCgocsmR4j8N4sJS3RW2LpKWNqaDKBDLO/p2eK1UN9oMoNXuSlMN05ngOXh
         Skq9nN0yvOXmNZlv5X21nEKX6RrgNEdMJd1ZN9qNYWnqvcW/0gMm0u2fLzj81Qsg9Wn7
         14NVd0qu/c4zkn+yIOn1QW+fIt6EjhxPVGxNo9hS5ntd8KjdNBdYZVOKoHW6m97b/qRW
         fbGmbnDZ7DafksXESnvyJ5h/D51sm/1b/MDTTxqQbU4i8E7il8zSv6+ZcfI1GvsGx7Pw
         ogv9YSIa3VjrpzrR15KWhpttJJ1iRGNzi1+S3eyCZBjF0Zaj7JII7YvLVCXrKw1TG59+
         phFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723725972; x=1724330772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MkzFShyb9+4TRjrRvu+V84H/xt2mywXwxPvbQCkE2k=;
        b=aR/exO3Fa7EmXP8jBlKtu615C0/izyOIljU8QEFSsCWp65n3TWNa8rvb98MEjsNjuB
         xduDvkOLxcrNxMOyrcJ6jhQfqn/2bma5zg0LsLIUC76LE7DGxkWLqRhFhCatbH/0qyC9
         Eky8K/dBOqNVYW4MLUOrgtUbna26UOpjc3fusI88LUCW6XwWSsRvxNQ2UAu0XKXZUSi4
         6yGlVvQksgh/aFgdFHI4YqXzNnvUl2E9mzS+AonX+AuuGUNwyxX8Cn++Hvy/oELjp2Kl
         LLWRJTCfG9+bPLsfd2q3j2eCMs/GgxSaNihve4gqGRdHnWEtvOT7JXzDdjMGlIdy7cjL
         ugkA==
X-Forwarded-Encrypted: i=1; AJvYcCWPUvYIsJmIH1naei3EIxQJ6PKwi1M9nZWtHlktLrG4egrJT2o6WtwZfNifSQ2kRHZdtrkv+FMKKA5AxO87+By9qbIHh2LY5bcuB1GmlIsBoj6J664knlxv1tgln2D1//iVvyI7
X-Gm-Message-State: AOJu0YzbSrjBnlcqKFUWB/S8lTKXUA00RZKSZNdI7JwwO/MCY3lhuxcI
	DeTjH04g34YbvhVsWl8niNHJeMT54HW1t/UfCuFBWRL9torHADJo
X-Google-Smtp-Source: AGHT+IG71xz8S5s9qS5q/Pu4ajD+UsYkmEJqo6Mje8PDFhxN0W7EfPJ0YZ5Vw3L0NbGWMb+cNy3oeA==
X-Received: by 2002:a05:6a21:3403:b0:1c0:e925:f3e1 with SMTP id adf61e73a8af0-1c8eaf8eb8cmr7864555637.50.1723725972254;
        Thu, 15 Aug 2024 05:46:12 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af2b942sm923605b3a.183.2024.08.15.05.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:46:11 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	idosch@nvidia.com,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 06/10] net: vxlan: add skb drop reasons to vxlan_rcv()
Date: Thu, 15 Aug 2024 20:42:58 +0800
Message-Id: <20240815124302.982711-7-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815124302.982711-1-dongml2@chinatelecom.cn>
References: <20240815124302.982711-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce skb drop reasons to the function vxlan_rcv(). Following new
vxlan drop reasons are added:

  VXLAN_DROP_FLAGS
  VXLAN_DROP_VNI
  VXLAN_DROP_MAC

And Following core skb drop reason is added:

  SKB_DROP_REASON_IP_TUNNEL_ECN

As ip tunnel is a public module, I'm not sure how to deal with it. So I
simply add it to the core drop reasons.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/vxlan/drop.h       |  3 +++
 drivers/net/vxlan/vxlan_core.c | 35 +++++++++++++++++++++++++---------
 include/net/dropreason-core.h  |  6 ++++++
 3 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/net/vxlan/drop.h b/drivers/net/vxlan/drop.h
index 83e10550dd6a..cae1e0ea8c56 100644
--- a/drivers/net/vxlan/drop.h
+++ b/drivers/net/vxlan/drop.h
@@ -9,6 +9,9 @@
 #include <net/dropreason.h>
 
 #define VXLAN_DROP_REASONS(R)			\
+	R(VXLAN_DROP_FLAGS)			\
+	R(VXLAN_DROP_VNI)			\
+	R(VXLAN_DROP_MAC)			\
 	/* deliberate comment for trailing \ */
 
 enum vxlan_drop_reason {
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index e971c4785962..9a61f04bb95d 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1668,6 +1668,7 @@ static bool vxlan_ecn_decapsulate(struct vxlan_sock *vs, void *oiph,
 /* Callback from net/ipv4/udp.c to receive packets */
 static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 {
+	enum skb_drop_reason reason = pskb_may_pull_reason(skb, VXLAN_HLEN);
 	struct vxlan_vni_node *vninode = NULL;
 	struct vxlan_dev *vxlan;
 	struct vxlan_sock *vs;
@@ -1681,7 +1682,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	int nh;
 
 	/* Need UDP and VXLAN header to be present */
-	if (!pskb_may_pull(skb, VXLAN_HLEN))
+	if (reason != SKB_NOT_DROPPED_YET)
 		goto drop;
 
 	unparsed = *vxlan_hdr(skb);
@@ -1690,6 +1691,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		netdev_dbg(skb->dev, "invalid vxlan flags=%#x vni=%#x\n",
 			   ntohl(vxlan_hdr(skb)->vx_flags),
 			   ntohl(vxlan_hdr(skb)->vx_vni));
+		reason = (u32)VXLAN_DROP_FLAGS;
 		/* Return non vxlan pkt */
 		goto drop;
 	}
@@ -1703,8 +1705,10 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	vni = vxlan_vni(vxlan_hdr(skb)->vx_vni);
 
 	vxlan = vxlan_vs_find_vni(vs, skb->dev->ifindex, vni, &vninode);
-	if (!vxlan)
+	if (!vxlan) {
+		reason = (u32)VXLAN_DROP_VNI;
 		goto drop;
+	}
 
 	/* For backwards compatibility, only allow reserved fields to be
 	 * used by VXLAN extensions if explicitly requested.
@@ -1717,12 +1721,16 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	}
 
 	if (__iptunnel_pull_header(skb, VXLAN_HLEN, protocol, raw_proto,
-				   !net_eq(vxlan->net, dev_net(vxlan->dev))))
+				   !net_eq(vxlan->net, dev_net(vxlan->dev)))) {
+		reason = SKB_DROP_REASON_NOMEM;
 		goto drop;
+	}
 
-	if (vs->flags & VXLAN_F_REMCSUM_RX)
-		if (unlikely(!vxlan_remcsum(&unparsed, skb, vs->flags)))
+	if (vs->flags & VXLAN_F_REMCSUM_RX) {
+		reason = vxlan_remcsum(&unparsed, skb, vs->flags);
+		if (unlikely(reason != SKB_NOT_DROPPED_YET))
 			goto drop;
+	}
 
 	if (vxlan_collect_metadata(vs)) {
 		IP_TUNNEL_DECLARE_FLAGS(flags) = { };
@@ -1732,8 +1740,10 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		tun_dst = udp_tun_rx_dst(skb, vxlan_get_sk_family(vs), flags,
 					 key32_to_tunnel_id(vni), sizeof(*md));
 
-		if (!tun_dst)
+		if (!tun_dst) {
+			reason = SKB_DROP_REASON_NOMEM;
 			goto drop;
+		}
 
 		md = ip_tunnel_info_opts(&tun_dst->u.tun_info);
 
@@ -1757,12 +1767,15 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		 * is more robust and provides a little more security in
 		 * adding extensions to VXLAN.
 		 */
+		reason = (u32)VXLAN_DROP_FLAGS;
 		goto drop;
 	}
 
 	if (!raw_proto) {
-		if (!vxlan_set_mac(vxlan, vs, skb, vni))
+		if (!vxlan_set_mac(vxlan, vs, skb, vni)) {
+			reason = (u32)VXLAN_DROP_MAC;
 			goto drop;
+		}
 	} else {
 		skb_reset_mac_header(skb);
 		skb->dev = vxlan->dev;
@@ -1777,7 +1790,8 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 
 	skb_reset_network_header(skb);
 
-	if (!pskb_inet_may_pull(skb)) {
+	reason = pskb_inet_may_pull_reason(skb);
+	if (reason != SKB_NOT_DROPPED_YET) {
 		DEV_STATS_INC(vxlan->dev, rx_length_errors);
 		DEV_STATS_INC(vxlan->dev, rx_errors);
 		vxlan_vnifilter_count(vxlan, vni, vninode,
@@ -1789,6 +1803,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	oiph = skb->head + nh;
 
 	if (!vxlan_ecn_decapsulate(vs, oiph, skb)) {
+		reason = SKB_DROP_REASON_IP_TUNNEL_ECN;
 		DEV_STATS_INC(vxlan->dev, rx_frame_errors);
 		DEV_STATS_INC(vxlan->dev, rx_errors);
 		vxlan_vnifilter_count(vxlan, vni, vninode,
@@ -1803,6 +1818,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		dev_core_stats_rx_dropped_inc(vxlan->dev);
 		vxlan_vnifilter_count(vxlan, vni, vninode,
 				      VXLAN_VNI_STATS_RX_DROPS, 0);
+		reason = SKB_DROP_REASON_DEV_READY;
 		goto drop;
 	}
 
@@ -1815,8 +1831,9 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 drop:
+	SKB_DR_RESET(reason);
 	/* Consume bad packet */
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return 0;
 }
 
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 8da0129d1ed6..8388c0ae893d 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -92,6 +92,7 @@
 	FN(PACKET_SOCK_ERROR)		\
 	FN(TC_CHAIN_NOTFOUND)		\
 	FN(TC_RECLASSIFY_LOOP)		\
+	FN(IP_TUNNEL_ECN)		\
 	FNe(MAX)
 
 /**
@@ -418,6 +419,11 @@ enum skb_drop_reason {
 	 * iterations.
 	 */
 	SKB_DROP_REASON_TC_RECLASSIFY_LOOP,
+	/**
+	 * @SKB_DROP_REASON_IP_TUNNEL_ECN: skb is dropped according to
+	 * RFC 6040 4.2, see __INET_ECN_decapsulate() for detail.
+	 */
+	SKB_DROP_REASON_IP_TUNNEL_ECN,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
-- 
2.39.2


