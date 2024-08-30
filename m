Return-Path: <netdev+bounces-123555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4419654FE
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 04:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16911C22AF5
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 02:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD9814B097;
	Fri, 30 Aug 2024 02:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6+5bdGu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E36D14D44E;
	Fri, 30 Aug 2024 02:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983371; cv=none; b=gQ94mdrjMWyAiG8+QL30wzX610ne8UBIKtOH/P63ibyXrFe95fES/Cw4TaoDv3fsfWLakPHdBaYb+QOZAvAvd+Kc/k5A6G1XD6GGu+9ps/CDUJ/Zr7nBQN5B2C9d+tRGgSBufNeH7uCcVjCt23qNesFc+BkfI+AFF1u6XlwnLX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983371; c=relaxed/simple;
	bh=ZH7n45LSFeKrmwjcD4SmmDveEnkcgkl6hEY/I4tNcCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QdAm+5GVL9yOO6KtAxulOiuXAs9LOGV4Z2gCSAb6f6eWYDQnlPOVKGehWKCEKqUD5Zzrpoyfl7xKah3JCZo8SLj1yim7x96dA5mGNEaK546xP4Qzt38nknRuk4+Xhxyqx4LwwJImCNLFHVm2q+7dOQm00Bwth34QjUeYmvo3xmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6+5bdGu; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-715cdc7a153so1058129b3a.0;
        Thu, 29 Aug 2024 19:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724983369; x=1725588169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dgev/vaZRZT3ES19Hr7IamdmE2x1ljBGTv1DhPYSR7k=;
        b=K6+5bdGunjpr+uN/M/CeLGfEWBZ5mmyIiNnsEoswsXb+Dr4n5sEEJsTMzYA2DUb4QY
         s/M0B5fyOpdD1T47gddoDctp7zk+y8UsCoDQfIJ1+4Ig1RPLNZ/kTFcjWsQhTR3lN6JO
         piQcFrWA1tLoIAQ1gNQOP2cKOq5GD8TdRQcLnhUnRUyDGUyZiqYllUpn5+0FJjPZtIXh
         V5GCoyqZ+dGVr1JtVf2/w6Hz8PbhSwJr2WYWD9OgCZBGt/lyWgOfDepReKWkqClNyJzE
         sghvbGNAJM67nklW+4UAoJ31ZtrBxUZPqDZOEVOZ0pAPkMrBaCD4xdn60mIsabY1rxa3
         zXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724983369; x=1725588169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dgev/vaZRZT3ES19Hr7IamdmE2x1ljBGTv1DhPYSR7k=;
        b=m5bw5gYEhEgw+9lfvrS1OLnIU5+P4//6fDND9IqoxI78EMoZECKSvlW6tcygE3oL5X
         UUOfqgQ/BbfBPXqz9lueS2syt3dAkIzEQlBY7+tnUQPqu50qbfyLVxkbphzlEtVQZVDW
         SGTxFkcNLXrLLFErsxidYTuP2iXU1NrRmB4mSB02JDb+BC2V2kg0lnLk6itpwOngC8Ac
         v5X6zQd/2oYq4Cs6IjffX0N2LoodxZox+PjOn8rU49+f4PRFUC7Jdu/OMabn/3/8EBHH
         fvNQvd2b0zGcOOKxEQp20oUubWUnNLb41RBeEVoGJHbl0i1Gs9XG2MLYXLOTrCd7GxsS
         IrGA==
X-Forwarded-Encrypted: i=1; AJvYcCWGT4g+hraULLxcWe2GEwQDFu9cPGgtlKuk/E1D3dWTRjy8/FinheBNpluI5mQW0jeHVtCJSwT996Bsomo=@vger.kernel.org, AJvYcCWvbA3RdFqUDr/ZYD/ae/54DRV1d7Y+BD0DohTJ06oJelR7UeX1GGZSe9vsc1q20btaLbJ9UITg@vger.kernel.org
X-Gm-Message-State: AOJu0YxuL1YVMtb/w3hECOS6eRU5Tnn2Oy10okQwHgmTlXm2LtLYvF21
	DqmFbXO7RYtB/R02PZTYoTjIV5l1ONoVOcLUdnun9MA0TG2nC1Pg
X-Google-Smtp-Source: AGHT+IFVV05w1BOg6a02IYmRAUhJljTKcApeQedoMAfs0lF1Rb9x2GNI4Vy7/KDL89s30og/owLbmQ==
X-Received: by 2002:a05:6a00:1905:b0:712:7512:add9 with SMTP id d2e1a72fcca58-7170a85ab58mr1203639b3a.13.1724983369201;
        Thu, 29 Aug 2024 19:02:49 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a6b60sm1764221b3a.87.2024.08.29.19.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 19:02:48 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org
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
Subject: [PATCH net-next v2 07/12] net: vxlan: add skb drop reasons to vxlan_rcv()
Date: Fri, 30 Aug 2024 09:59:56 +0800
Message-Id: <20240830020001.79377-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240830020001.79377-1-dongml2@chinatelecom.cn>
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce skb drop reasons to the function vxlan_rcv(). Following new
vxlan drop reasons are added:

  VXLAN_DROP_INVALID_HDR
  VXLAN_DROP_VNI_NOT_FOUND

And Following core skb drop reason is added:

  SKB_DROP_REASON_IP_TUNNEL_ECN

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- rename the drop reasons, as Ido advised.
- document the drop reasons
---
 drivers/net/vxlan/drop.h       | 10 ++++++++++
 drivers/net/vxlan/vxlan_core.c | 35 +++++++++++++++++++++++++---------
 include/net/dropreason-core.h  |  6 ++++++
 3 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/drivers/net/vxlan/drop.h b/drivers/net/vxlan/drop.h
index 876b4a9de92f..416532633881 100644
--- a/drivers/net/vxlan/drop.h
+++ b/drivers/net/vxlan/drop.h
@@ -11,6 +11,8 @@
 #define VXLAN_DROP_REASONS(R)			\
 	R(VXLAN_DROP_INVALID_SMAC)		\
 	R(VXLAN_DROP_ENTRY_EXISTS)		\
+	R(VXLAN_DROP_INVALID_HDR)		\
+	R(VXLAN_DROP_VNI_NOT_FOUND)		\
 	/* deliberate comment for trailing \ */
 
 enum vxlan_drop_reason {
@@ -23,6 +25,14 @@ enum vxlan_drop_reason {
 	 * one pointing to a nexthop
 	 */
 	VXLAN_DROP_ENTRY_EXISTS,
+	/**
+	 * @VXLAN_DROP_INVALID_HDR: the vxlan header is invalid, such as:
+	 * 1) the reserved fields are not zero
+	 * 2) the "I" flag is not set
+	 */
+	VXLAN_DROP_INVALID_HDR,
+	/** @VXLAN_DROP_VNI_NOT_FOUND: no vxlan device found for the vni */
+	VXLAN_DROP_VNI_NOT_FOUND,
 };
 
 static inline void
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 58c175432a15..ab1c14a807f2 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1674,13 +1674,15 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
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
@@ -1689,6 +1691,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		netdev_dbg(skb->dev, "invalid vxlan flags=%#x vni=%#x\n",
 			   ntohl(vxlan_hdr(skb)->vx_flags),
 			   ntohl(vxlan_hdr(skb)->vx_vni));
+		reason = (u32)VXLAN_DROP_INVALID_HDR;
 		/* Return non vxlan pkt */
 		goto drop;
 	}
@@ -1702,8 +1705,10 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	vni = vxlan_vni(vxlan_hdr(skb)->vx_vni);
 
 	vxlan = vxlan_vs_find_vni(vs, skb->dev->ifindex, vni, &vninode);
-	if (!vxlan)
+	if (!vxlan) {
+		reason = (u32)VXLAN_DROP_VNI_NOT_FOUND;
 		goto drop;
+	}
 
 	/* For backwards compatibility, only allow reserved fields to be
 	 * used by VXLAN extensions if explicitly requested.
@@ -1716,12 +1721,16 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
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
+		if (unlikely(reason))
 			goto drop;
+	}
 
 	if (vxlan_collect_metadata(vs)) {
 		IP_TUNNEL_DECLARE_FLAGS(flags) = { };
@@ -1731,8 +1740,10 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		tun_dst = udp_tun_rx_dst(skb, vxlan_get_sk_family(vs), flags,
 					 key32_to_tunnel_id(vni), sizeof(*md));
 
-		if (!tun_dst)
+		if (!tun_dst) {
+			reason = SKB_DROP_REASON_NOMEM;
 			goto drop;
+		}
 
 		md = ip_tunnel_info_opts(&tun_dst->u.tun_info);
 
@@ -1756,11 +1767,13 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		 * is more robust and provides a little more security in
 		 * adding extensions to VXLAN.
 		 */
+		reason = (u32)VXLAN_DROP_INVALID_HDR;
 		goto drop;
 	}
 
 	if (!raw_proto) {
-		if (!vxlan_set_mac(vxlan, vs, skb, vni))
+		reason = vxlan_set_mac(vxlan, vs, skb, vni);
+		if (reason)
 			goto drop;
 	} else {
 		skb_reset_mac_header(skb);
@@ -1776,7 +1789,8 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 
 	skb_reset_network_header(skb);
 
-	if (!pskb_inet_may_pull(skb)) {
+	reason = pskb_inet_may_pull_reason(skb);
+	if (reason) {
 		DEV_STATS_INC(vxlan->dev, rx_length_errors);
 		DEV_STATS_INC(vxlan->dev, rx_errors);
 		vxlan_vnifilter_count(vxlan, vni, vninode,
@@ -1788,6 +1802,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	oiph = skb->head + nh;
 
 	if (!vxlan_ecn_decapsulate(vs, oiph, skb)) {
+		reason = SKB_DROP_REASON_IP_TUNNEL_ECN;
 		DEV_STATS_INC(vxlan->dev, rx_frame_errors);
 		DEV_STATS_INC(vxlan->dev, rx_errors);
 		vxlan_vnifilter_count(vxlan, vni, vninode,
@@ -1802,6 +1817,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		dev_core_stats_rx_dropped_inc(vxlan->dev);
 		vxlan_vnifilter_count(vxlan, vni, vninode,
 				      VXLAN_VNI_STATS_RX_DROPS, 0);
+		reason = SKB_DROP_REASON_DEV_READY;
 		goto drop;
 	}
 
@@ -1814,8 +1830,9 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 drop:
+	reason = reason ?: SKB_DROP_REASON_NOT_SPECIFIED;
 	/* Consume bad packet */
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return 0;
 }
 
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 4748680e8c88..d38371f33e2b 100644
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


