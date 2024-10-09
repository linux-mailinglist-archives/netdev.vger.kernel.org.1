Return-Path: <netdev+bounces-133424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBF9995DC6
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 04:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9F92831C0
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 02:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EB813D601;
	Wed,  9 Oct 2024 02:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jG28Ul+n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347CD15442D;
	Wed,  9 Oct 2024 02:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728440971; cv=none; b=Ah07FgLRhpM4gOUjW9Pd/XE6eoWGHcG1YKaS8Pn4nVOG56TjNSfl0+fQuZa+MH2DK1qkPgpz33Z0s+AH2xAvpzgjL6lyAEQJoAED6a/8+1gksrSXsiuRqYNLMGElU622MiNaCqAvdvcfrxmhT+RltrMpYBiXKZn/0QWPuz4JZ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728440971; c=relaxed/simple;
	bh=Frgop5dI3MpmoWzTS13lVakpm6NizzC07ixLgWUG7hU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N2HIx7JX82uZmjkhn5C9w+Mol38aKbe+/zdl/uVEi0P4hMlZmDVtx9NfVlIdgJ+lnq7kssd2tILnc/lpyXvc+CXlm3ih6tp9m9GfETnkvU+iaSLOQdw86eHahbUvCiSNLKFCwhh+/n0Kvfymu88VvQAFSbkkiwd+vCxfFmf88BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jG28Ul+n; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-2e077a4b8c0so306264a91.1;
        Tue, 08 Oct 2024 19:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728440969; x=1729045769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+57bNIoFOfo1YPD2Iy9OO/eMOStU8dZYyQFQ7Wq2lE=;
        b=jG28Ul+nmNlVz+NQHziY1JLESGvbJzXvb1dnjx8Yu6DhNTBFK3x+CM8ZmJ9G00KdRr
         qVP+dHyHbBFjN/JWcWzg88ej0eywhZGnAWS5zoRx0kdKfay8uehMPoxbKCUbcbcL6bKC
         Dj3WcabbqrRPHMjpVRBUh48lmo7zI3g+ar2BC/a3uWaKWLX8ZjT1MpGJgl5V/7HGoMJm
         ftBsmvwFFkD6Nx+vlK0mAcwn0p7yn2ojnKyEGOqXyy3d+QvuCo5TeookoVuQ9NYh3+Ey
         BiH9mfDzwL9C0XCvJlfSFjd1EkHNX2wY/AelFYOv+jYA38WyGcJBPiS0cXX0XV2AAfpB
         kD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728440969; x=1729045769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+57bNIoFOfo1YPD2Iy9OO/eMOStU8dZYyQFQ7Wq2lE=;
        b=P0OcWG154pKi3UCypav1Ws7MOAFR34iKkI4zpaPLEbg32iN7kfX8tM1JYpK5hJbu1B
         VcYzyueIc63hfIpgdvvOHuCnGxjoEs/YT8OhvKiomIwj/8yiDi0j2frUwwECA/6OAVfN
         ffHmlQX6hGa7yJAIxaXqP1WOrrONiJir76cgeQdSUQruoXbBdyXGVP7O9/Yyao/Ow2xU
         YaQY6iw9TMzyKiPVvktg7wPnMPtc7wFI3S4lJcxyWABQZ5sUddLOFnABtWLWnOH7P+VS
         IylW7j5VO4rZYGNYjt/8qQvoWU+P8aDtGe6+TpkiL7P/ddYWlWGrx/EvsPhj0JYxspK9
         1t5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWH2c6pMFONWHQYplLTfYE+BZe0Y6v5KENJ86Q65lEFDUsZ7zOEPcpmV5PscIvLv33T8x/ck68O@vger.kernel.org, AJvYcCWK/scAQKlTmKQf8e1ykkBbx8d/TazDZBuC6W3HY54SzUW20TVUBoT5jgOkQsahFlJM/RsXN4JY6sRcbJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3y8pomYfhdNSCBqIN+S59Yffx8/0NhXlCFMmx3ZVuOklFN67v
	ylSeGfGznSSXUyHX2KqsxHgrIjvASUXc1PuAG9/rNLhGCk8qLgt1
X-Google-Smtp-Source: AGHT+IGP0BozauTf7SPCoHG24Nw2j8bYr1rrwkN7MuV4ZeX1FuYqQJwd5uqkhj2ywxtqUa6pNGGWRw==
X-Received: by 2002:a17:90a:c798:b0:2d8:9fbe:6727 with SMTP id 98e67ed59e1d1-2e2a0756277mr1716739a91.4.1728440969384;
        Tue, 08 Oct 2024 19:29:29 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a5706e8bsm336202a91.18.2024.10.08.19.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 19:29:28 -0700 (PDT)
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
Subject: [PATCH net-next v7 04/12] net: vxlan: add skb drop reasons to vxlan_rcv()
Date: Wed,  9 Oct 2024 10:28:22 +0800
Message-Id: <20241009022830.83949-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241009022830.83949-1-dongml2@chinatelecom.cn>
References: <20241009022830.83949-1-dongml2@chinatelecom.cn>
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


