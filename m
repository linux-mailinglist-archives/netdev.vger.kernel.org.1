Return-Path: <netdev+bounces-130731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D4198B5AD
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 09:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23391F21A9F
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 07:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB7A1BD514;
	Tue,  1 Oct 2024 07:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWBu/oH7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB79E1BD035;
	Tue,  1 Oct 2024 07:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768103; cv=none; b=Ly6FuJ+0AFXRNe6U7FYrfd7GHkqQDFEzhICH4tXFlnPsSKvNE11nN2Jrnq6GFZB4YCPTyqqb7q5PkgHIdShAtTskNM71OqAtFjEHvsHYmqBJ063JhMWLVODc7eiJRPSNbHNOFe5Tih9JEiow8usGDM6RhxA5D3JUarVY4PHXd88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768103; c=relaxed/simple;
	bh=LHjrFsENDzImAMlLbJXgCPkwV+GY8wu50+WIKjPLPBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NRwMtV0GIiwTaAbu5uKeN6MfEHAKxBvBeQHck0s0wn3YAgZVapyhsYa1DznzrR+mRqDLc2gaKZ0FFn7iDqF+PO0YjUSHoivdsHtz+d+/muP/Mp3uaiIeY9QFLM4V+bHmebZ/6jZT30aFpkOxtgnpr15YntWKxJxHDHbAMmwTB/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWBu/oH7; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-20b6458ee37so31715845ad.1;
        Tue, 01 Oct 2024 00:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727768101; x=1728372901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fV5t/4F28NBF1vanp0Nr10+/6g51hEg6HDIVD4nVz0g=;
        b=cWBu/oH7b8ZkeJ/H0N/RoE2ID3bMZHr1A4lEzPtl+Ywn/F75SnBA82dnZCIDFVKRTD
         Y8T4ATge6opRF/YECbdvu1c9dqnzpvSPzxjfV+AR3Ulk/X8/SwZ+uvq4mD5geCQ6GFo4
         xvvZd84QJYjvPryMhXmppwD+/A7PMrRR3mvFZPcUREKE0eGuUDWNYYjQa1T7BlzAwGUb
         zXPCcLMEB3hv4i+oKCzIPYpsAKiQAQQreFAr0rjB8bLRVZ2m+dgpSYkAOvknlBjK/qd0
         J/khi4wwzhc87/3qLu3yfe702ZGIuY6DOeIlE0+lp17uKfEhSYjj4M4L+OSLVNvmQ3c6
         M0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727768101; x=1728372901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fV5t/4F28NBF1vanp0Nr10+/6g51hEg6HDIVD4nVz0g=;
        b=RrL49I3DajQ0jESrrPmCw9BSG+40GG7w860EHSvfml67MSvEWf+UZZmQzYxq89Elpd
         zX47V6hWYcOFNV3crSlHU/BytnuYI8daX1cJ1RxRYWrd8EK4BDZXkBQRo8R79n3sU7uP
         jjIxUVt/yezBZ/t7+5VMsHVCBTBtuQb7ouA8FnswaDw7NG3aZX8HADPIUS/U0C7EBkRL
         gn4M6sO8/QUYIMybjCnS6MvEoPd3Q5TGCUshVFCSRJN7U51TZq4M5Wz1XfQojWRdJxkN
         y7wdRfH0MKyVKlD0x3G3xTLOtL/lFaxVPNtRUziCJcbtvZyZhQktQvRZTy2e9aCctuv+
         2f3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/5aeezr9V2XcOiKSqqNqbkYHg5v8th+YircDCS5VODb7SA/H+kPwugQqtjJrF/pVjbZD6E5bqHuyEoYs=@vger.kernel.org, AJvYcCXPQOPnNbJXOlpbOkLy0MlyFe6VUtuaFJPjYo6SMHTslwOAm6qYAdfWGuxWFqqbqP61iUhwrra4@vger.kernel.org
X-Gm-Message-State: AOJu0YwSZ9fQi7hOyKDVendHhrqGUWIlFMIlaOzBLzlYUzX0DXuk0vIs
	vT1eecuggd/Zm4y4CYr6rZPPXDPRUUlTm43AAhHOUszzEU0iuiyy
X-Google-Smtp-Source: AGHT+IHTbeRbLLeiETPaSestlxNuWwZMK1fU3X+yqy/e1gHPFdB2ZikcwhJwMyQ98n7HLwskJ1T+KQ==
X-Received: by 2002:a17:903:230c:b0:20b:a9b2:b560 with SMTP id d9443c01a7336-20ba9b2b832mr36404425ad.6.1727768100901;
        Tue, 01 Oct 2024 00:35:00 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37da2667sm64545575ad.102.2024.10.01.00.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 00:35:00 -0700 (PDT)
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
Subject: [PATCH net-next v4 04/12] net: vxlan: add skb drop reasons to vxlan_rcv()
Date: Tue,  1 Oct 2024 15:32:17 +0800
Message-Id: <20241001073225.807419-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241001073225.807419-1-dongml2@chinatelecom.cn>
References: <20241001073225.807419-1-dongml2@chinatelecom.cn>
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
index 53dcb9fffc04..04c56f952f29 100644
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


