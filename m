Return-Path: <netdev+bounces-215526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC43B2EFB9
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 09:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCCC61CC398F
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 07:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C112E88A8;
	Thu, 21 Aug 2025 07:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVdBqjEu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8F9188906;
	Thu, 21 Aug 2025 07:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761480; cv=none; b=bPPHlMK2Q4argLB10zNG5m3EjAq5DGm3E/Vqvqk92z7bDgWxTcs9W2hXy4mI+jrbOO23DicHstbWzUTLDBg5YGbtqKwO24RR08qZmHZxJJ1/AacT6jhDzNsnAuEndvGFCzAAYFsuytHVrIYhBZC2dXogLfR9CDiecWHS2AfKzQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761480; c=relaxed/simple;
	bh=HLGzR+DDbRyzTz2xyLktrbTmvWJRixILj4bbjktND4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hp1XiIPPDKkaBwY/SW4th5ugNbplYpmvDGKGftlXuAytJsZygETZpCczFnqm6qHsucX5DTLbVK5NjFpGeu3CVOHdRID3uvIxXpUNreaeap0aQz4ZszhzJ0F44TEYz8hXOpxETd4JLg2+HRap+jdcsob3taWPAe33XRRhnaFNYNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVdBqjEu; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9dc55d84bso670155f8f.1;
        Thu, 21 Aug 2025 00:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755761475; x=1756366275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jOReh4+cKshxOW4VBEHuCirp17ve5WnbRigcug4rX4=;
        b=IVdBqjEu6sTpPcXebHfcBIlKWiv16JRfu0YBcBkO/O1W3+QPC7CHaRvcK9sVy8BSwN
         NLym4Enxhrkbvdlwa80Qcgcz5PIPKMRi8Dsp1OxieAw+b8GYlXumK6PT42Sbe1jKTX8o
         Vkw+wI28Wv8UPGEaJZ6ZFGb9x+pudKCsC5XwJNeV/lhSmm06UsjrCfUcvh2ze/E7ew0o
         sbZOpfY8tkBqBPCY8KL15Z44oxVnopyfDniIDaWpgB13RPmVVcc5Nx/mkcaJXj+mGuUn
         pH1dT5iQiT2I1x11WBlPMvEZYbpsjwBFmw6hW2LX2HuLN7j3dgV5vQPYjzFJP52hyB9o
         AJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755761475; x=1756366275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jOReh4+cKshxOW4VBEHuCirp17ve5WnbRigcug4rX4=;
        b=MW+EZ14JPZqbJOQc0+Cb+sxncwpN3vtMwUNKyyy64kqYmALqr8+xHqZJMtlc77zVPW
         R9LRiY4o16H0gc9w/hIKLvOBKJ95xIh4A7oE6Ip+HEUmjkoWOwzk0m6XkUY3MGJ0sHJP
         lt0sTSdMZbLhudSJ6BqNMxmnP1FSm9xCNoylkinmtSyS2mpmKc1zmSJIuMf7gCu1ypmi
         BLjVCXoKcslmEC6D1nvPZt9OGGH8gMs2xl9Bb4kEopWAYnmiZ12lZQQH3f8PofQMSXVO
         zWKNKySixv328ebZHixBGxzHxLYHLZcEMuAlooGp78DXHv3kZaczcWOqRXroEnQExi8C
         JUCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQZYj9ETsx+pp2zrlZVXmIiEJgcRPl8Fu6psPBF80QL47iIcxqQ8xVKoEPbldL72A0WHdil5CmI1Yzyzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcOSWrecyQj3MdzxIjYlJgnrvCwugIhPpoCQM6t/PKUCMsFjOs
	fgcCDXqlB41bGlp65EnHErlmyFVLiyBFNXyaSIyujgjeooovTFAi1NFWMOKblA==
X-Gm-Gg: ASbGncvOuFVPbb/YU3up7/+no4LcB4U9wIFbMhEva5pYYCDA9k0dYDtV97nOTzeDFnC
	PlUbku2H5jIFn7v/Zfs1D/0N7+lFrDtXrWoWQ6UaGhTtfXnRel314oNmK+H6GuTf7wxVq1VjX40
	lMJj27ZCUnXacaE4HXTP55QULrKNAQyWMTlpB2Y3kEcojq5Xr+jQ/qVg0o6vHZ3Ko4ZRNbm3N2p
	e3BMxVbYkT+tRwdi+1vbzcV2AkKxzwETu7eXFaFlBmh0Za5HDfUo4Wd5TlFJf8Ya/HLaP/ZolX0
	78GK9FMG8wZdxPT3tGaDzfQlRH+cm+GzeGVqO/744lK7Q8a5RXoFdnlUWiaHRxl7ULlDcp/g2Te
	N5JA=
X-Google-Smtp-Source: AGHT+IEuEngzprfOZ1og99RUamkEFKIb3jxu/1ifU4zZ0UntoYSrz41rdwQcZVaNZS26rZp1Y4Hl+Q==
X-Received: by 2002:adf:e588:0:b0:3c5:374c:1265 with SMTP id ffacd0b85a97d-3c5374c164bmr106205f8f.24.1755761475080;
        Thu, 21 Aug 2025 00:31:15 -0700 (PDT)
Received: from localhost ([45.84.137.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c4c218c62asm1275395f8f.64.2025.08.21.00.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 00:31:14 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	ecree.xilinx@gmail.com,
	dsahern@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	aleksander.lobakin@intel.com,
	florian.fainelli@broadcom.com,
	willemdebruijn.kernel@gmail.com,
	alexander.duyck@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v3 3/5] net: gso: restore ids of outer ip headers correctly
Date: Thu, 21 Aug 2025 09:30:45 +0200
Message-Id: <20250821073047.2091-4-richardbgobert@gmail.com>
In-Reply-To: <20250821073047.2091-1-richardbgobert@gmail.com>
References: <20250821073047.2091-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, NETIF_F_TSO_MANGLEID indicates that the inner-most ID can
be mangled. Outer IDs can always be mangled.

Make GSO preserve outer IDs by default, with NETIF_F_TSO_MANGLEID allowing
both inner and outer IDs to be mangled. In the future, we could add
NETIF_F_TSO_MANGLEID_INNER to provide more granular control to
drivers.

This commit also modifies a few drivers that use SKB_GSO_FIXEDID directly.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c |  8 ++++++--
 drivers/net/ethernet/sfc/ef100_tx.c             | 12 +++++++-----
 include/linux/netdevice.h                       |  9 +++++++--
 include/linux/skbuff.h                          |  6 +++++-
 net/core/dev.c                                  |  7 +++----
 net/ipv4/af_inet.c                              | 13 ++++++-------
 net/ipv4/tcp_offload.c                          |  5 +----
 7 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index b8c609d91d11..505c4ce7cef8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1289,8 +1289,12 @@ static void mlx5e_shampo_update_ipv4_tcp_hdr(struct mlx5e_rq *rq, struct iphdr *
 	tcp->check = ~tcp_v4_check(skb->len - tcp_off, ipv4->saddr,
 				   ipv4->daddr, 0);
 	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4;
-	if (ntohs(ipv4->id) == rq->hw_gro_data->second_ip_id)
-		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID;
+	if (ntohs(ipv4->id) == rq->hw_gro_data->second_ip_id) {
+		bool encap = rq->hw_gro_data->fk.control.flags & FLOW_DIS_ENCAPSULATION;
+
+		skb_shinfo(skb)->gso_type |= encap ?
+					     SKB_GSO_TCP_FIXEDID_INNER : SKB_GSO_TCP_FIXEDID;
+	}
 
 	skb->csum_start = (unsigned char *)tcp - skb->head;
 	skb->csum_offset = offsetof(struct tcphdr, check);
diff --git a/drivers/net/ethernet/sfc/ef100_tx.c b/drivers/net/ethernet/sfc/ef100_tx.c
index e6b6be549581..4efd22b44986 100644
--- a/drivers/net/ethernet/sfc/ef100_tx.c
+++ b/drivers/net/ethernet/sfc/ef100_tx.c
@@ -189,7 +189,8 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
 {
 	bool gso_partial = skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL;
 	unsigned int len, ip_offset, tcp_offset, payload_segs;
-	u32 mangleid = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
+	u32 mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
+	u32 mangleid_inner = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
 	unsigned int outer_ip_offset, outer_l4_offset;
 	u16 vlan_tci = skb_vlan_tag_get(skb);
 	u32 mss = skb_shinfo(skb)->gso_size;
@@ -201,7 +202,9 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
 	u32 paylen;
 
 	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID)
-		mangleid = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
+		mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID_INNER)
+		mangleid_inner = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
 	if (efx->net_dev->features & NETIF_F_HW_VLAN_CTAG_TX)
 		vlan_enable = skb_vlan_tag_present(skb);
 
@@ -239,14 +242,13 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
 			      ESF_GZ_TX_TSO_CSO_INNER_L4, 1,
 			      ESF_GZ_TX_TSO_INNER_L3_OFF_W, ip_offset >> 1,
 			      ESF_GZ_TX_TSO_INNER_L4_OFF_W, tcp_offset >> 1,
-			      ESF_GZ_TX_TSO_ED_INNER_IP4_ID, mangleid,
+			      ESF_GZ_TX_TSO_ED_INNER_IP4_ID, mangleid_inner,
 			      ESF_GZ_TX_TSO_ED_INNER_IP_LEN, 1,
 			      ESF_GZ_TX_TSO_OUTER_L3_OFF_W, outer_ip_offset >> 1,
 			      ESF_GZ_TX_TSO_OUTER_L4_OFF_W, outer_l4_offset >> 1,
 			      ESF_GZ_TX_TSO_ED_OUTER_UDP_LEN, udp_encap && !gso_partial,
 			      ESF_GZ_TX_TSO_ED_OUTER_IP_LEN, encap && !gso_partial,
-			      ESF_GZ_TX_TSO_ED_OUTER_IP4_ID, encap ? mangleid :
-								     ESE_GZ_TX_DESC_IP4_ID_NO_OP,
+			      ESF_GZ_TX_TSO_ED_OUTER_IP4_ID, mangleid_outer,
 			      ESF_GZ_TX_TSO_VLAN_INSERT_EN, vlan_enable,
 			      ESF_GZ_TX_TSO_VLAN_INSERT_TCI, vlan_tci
 		);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5e5de4b0a433..f47d4d67bce9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5287,13 +5287,18 @@ void skb_warn_bad_offload(const struct sk_buff *skb);
 
 static inline bool net_gso_ok(netdev_features_t features, int gso_type)
 {
-	netdev_features_t feature = (netdev_features_t)gso_type << NETIF_F_GSO_SHIFT;
+	netdev_features_t feature;
+
+	if (gso_type & (SKB_GSO_TCP_FIXEDID | SKB_GSO_TCP_FIXEDID_INNER))
+		gso_type |= __SKB_GSO_TCP_FIXEDID;
+
+	feature = ((netdev_features_t)gso_type << NETIF_F_GSO_SHIFT) & NETIF_F_GSO_MASK;
 
 	/* check flags correspondence */
 	BUILD_BUG_ON(SKB_GSO_TCPV4   != (NETIF_F_TSO >> NETIF_F_GSO_SHIFT));
 	BUILD_BUG_ON(SKB_GSO_DODGY   != (NETIF_F_GSO_ROBUST >> NETIF_F_GSO_SHIFT));
 	BUILD_BUG_ON(SKB_GSO_TCP_ECN != (NETIF_F_TSO_ECN >> NETIF_F_GSO_SHIFT));
-	BUILD_BUG_ON(SKB_GSO_TCP_FIXEDID != (NETIF_F_TSO_MANGLEID >> NETIF_F_GSO_SHIFT));
+	BUILD_BUG_ON(__SKB_GSO_TCP_FIXEDID != (NETIF_F_TSO_MANGLEID >> NETIF_F_GSO_SHIFT));
 	BUILD_BUG_ON(SKB_GSO_TCPV6   != (NETIF_F_TSO6 >> NETIF_F_GSO_SHIFT));
 	BUILD_BUG_ON(SKB_GSO_FCOE    != (NETIF_F_FSO >> NETIF_F_GSO_SHIFT));
 	BUILD_BUG_ON(SKB_GSO_GRE     != (NETIF_F_GSO_GRE >> NETIF_F_GSO_SHIFT));
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 14b923ddb6df..9e4540d379ba 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -674,7 +674,7 @@ enum {
 	/* This indicates the tcp segment has CWR set. */
 	SKB_GSO_TCP_ECN = 1 << 2,
 
-	SKB_GSO_TCP_FIXEDID = 1 << 3,
+	__SKB_GSO_TCP_FIXEDID = 1 << 3,
 
 	SKB_GSO_TCPV6 = 1 << 4,
 
@@ -707,6 +707,10 @@ enum {
 	SKB_GSO_FRAGLIST = 1 << 18,
 
 	SKB_GSO_TCP_ACCECN = 1 << 19,
+
+	/* These don't correspond with netdev features. */
+	SKB_GSO_TCP_FIXEDID = 1 << 30,
+	SKB_GSO_TCP_FIXEDID_INNER = 1 << 31,
 };
 
 #if BITS_PER_LONG > 32
diff --git a/net/core/dev.c b/net/core/dev.c
index 68dc47d7e700..9941c39b5970 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3772,10 +3772,9 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	 * IPv4 header has the potential to be fragmented.
 	 */
 	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4) {
-		struct iphdr *iph = skb->encapsulation ?
-				    inner_ip_hdr(skb) : ip_hdr(skb);
-
-		if (!(iph->frag_off & htons(IP_DF)))
+		if (!(ip_hdr(skb)->frag_off & htons(IP_DF)) ||
+		    (skb->encapsulation &&
+		     !(inner_ip_hdr(skb)->frag_off & htons(IP_DF))))
 			features &= ~NETIF_F_TSO_MANGLEID;
 	}
 
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 76e38092cd8a..fc7a6955fa0a 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1393,14 +1393,13 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 
 	segs = ERR_PTR(-EPROTONOSUPPORT);
 
-	if (!skb->encapsulation || encap) {
-		udpfrag = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP);
-		fixedid = !!(skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID);
+	/* fixed ID is invalid if DF bit is not set */
+	fixedid = !!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCP_FIXEDID << encap));
+	if (fixedid && !(ip_hdr(skb)->frag_off & htons(IP_DF)))
+		goto out;
 
-		/* fixed ID is invalid if DF bit is not set */
-		if (fixedid && !(ip_hdr(skb)->frag_off & htons(IP_DF)))
-			goto out;
-	}
+	if (!skb->encapsulation || encap)
+		udpfrag = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP);
 
 	ops = rcu_dereference(inet_offloads[proto]);
 	if (likely(ops && ops->callbacks.gso_segment)) {
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 56817ef12ad2..be5c2294610e 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -472,7 +472,6 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
 	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
 	struct tcphdr *th = tcp_hdr(skb);
-	bool is_fixedid;
 
 	if (unlikely(NAPI_GRO_CB(skb)->is_flist)) {
 		skb_shinfo(skb)->gso_type |= SKB_GSO_FRAGLIST | SKB_GSO_TCPV4;
@@ -486,10 +485,8 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 	th->check = ~tcp_v4_check(skb->len - thoff, iph->saddr,
 				  iph->daddr, 0);
 
-	is_fixedid = (NAPI_GRO_CB(skb)->ip_fixedid >> skb->encapsulation) & 1;
-
 	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4 |
-			(is_fixedid * SKB_GSO_TCP_FIXEDID);
+			(NAPI_GRO_CB(skb)->ip_fixedid * SKB_GSO_TCP_FIXEDID);
 
 	tcp_gro_complete(skb);
 	return 0;
-- 
2.36.1


