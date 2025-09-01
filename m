Return-Path: <netdev+bounces-218732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC787B3E1CF
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 13:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89C21188BD40
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 11:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E4D31E10E;
	Mon,  1 Sep 2025 11:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRQyZeg7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904FB31A563;
	Mon,  1 Sep 2025 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726747; cv=none; b=euaMQluFVbFNViAaizFil84Lo60NQBN5f51EiMNJ5FvtYIoFqWla6VYb2UTcVFe6C4tGM2WmFI7wSUgFii9upEBp3d1/HfU0YRMdR3SrnVbi2yOxmsKHwsWm9FOm3T0DIBNgbHeWZSmzUuVv2XAIpocIBfZ3GBZEv8NW2rmWtDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726747; c=relaxed/simple;
	bh=3LZWn+oJa1XrmamB3nxjIOuGYR+wiH/4YPR43qRbO1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bVmStXp0rPbhc6LGkHIhKp5Dj8Do4OYBtRuwrEH+KaGluQYwruHhS+iKl2nbGvxZwqqSCh7n5TrtCbCs7PYsTxZShDWc/4m6c3SEA7l7/fgc/QosL9qSvVkirSyRDgqrYyIDYUciPC3Pdo5trlfBAAX+FECjou6thmO6kUo2ujI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRQyZeg7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b84c9775cso10211785e9.0;
        Mon, 01 Sep 2025 04:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756726744; x=1757331544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Vz2uLP5sgW+Jf4jqufs4uxX+PC38XDpQssaRr5A8bo=;
        b=iRQyZeg7eC96cYfpFtTDxa44yuYJxtV3k69B0DtG+QluGqJrbpgBaFlkTAdXloomX6
         OcGOb3nD5w4sxDshD4H3OEfz6mrtEH4BCY59Gy+YkST0gBjcL9wrYwHmQCqsqR5vLHMB
         Akt4lsmCFfEyaVrm8mR12S6FXHDMh/qUuIPTD4WhlI4DZuH65KXvJ51wYkihlsYLYtTJ
         qyuowSCEE+AjMVEtJTHfDRWO5UNgyeigkr2YP9QYN0rAYe9ofogTB/qADTPT5tofuIt1
         CmmglSa/JG0hKSSpUfJr2MTlQQBzYBGH++LhwOjlFf3664PQCx1y9qxeLHgU2J2UfV+r
         MspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756726744; x=1757331544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Vz2uLP5sgW+Jf4jqufs4uxX+PC38XDpQssaRr5A8bo=;
        b=aUJfh+KjAeJ2a8UR9HkTY3BpEjurudSudLa76/xsURZnDEAjpzI35ngXEELhJYauCD
         qHSgktsP2MO3lKsIajnekWScLpOXGz8ucdVqn2mGRuYf8pgBplguK88c8ywnsTzs0+M3
         p/hHVEHMtlc+HNzv7c+0T0BRVWzo58ExOoogAXWU5rf33eHKuyFcNUfO0Daxa2h2BE0/
         YEAllqCbRWiIZFFqwQOP8R84yMwfr5/5LVAJ24NHajOaFXOgmwNJAq5fAl48FRP2HMFS
         ruSje/3QiXczgNW4c73EsqdHAfSCgaiWlp7dQRKSmgym2ksBsnayxwIjBxinSjYPENfH
         scgw==
X-Forwarded-Encrypted: i=1; AJvYcCWUQJfC74TvzH2tOrEpJa2+vfvLVRX7hTcLbcU5YcQdURHel92MwtUkHzmEuQLuh9fLFv5UPbwXbx1T6NE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN4RoJJ2NPcruGRxY5E3zk42620QN90/VWRvO4674gcjHLaJij
	4tZI0/wxoCKX9odBlKoGVXQFRR586CB21yT11Et1xykz5Jxu2QYvRIrWNiBAtXsIgZU=
X-Gm-Gg: ASbGncuWk380Zqc+PLRisZm55ay6lOJWdzQytD25zEtWwwc850Gg27x6kxxxabILwaR
	NePR4Rd9bpM7c3cBd1ci2B4+3nmxCFxGTdcfqIf5hJfvvBL2rC+m91JQ28lnrfXEx20BhPmxBfT
	I3f2as+bz4vvR+nml0r8cKYSAY+ONCwucYNNs4CMWi3vsMrjLudYmuUYoVFsWkYxUmCV/wU2slB
	Fv0RQ+iZxjsWBcpA+TrwhWnUT9hdje+TEJixYkz10N9p0WtQxNjxFiM7vj3Uof2tHXj8pMklZdo
	rNIkXQF16bHkBcbD4/G2GB6Z697fziDiw9jXXX3oubnlaW077USpf+JIJ3WLplccdMS16ZCGJwX
	NUSHLsU15pKVA/HjpjHimSSzAlNM1Ipj9MRN85bm+g2OXVW2b
X-Google-Smtp-Source: AGHT+IGQFwjKS/+f2kTv8gb0Vfi6+Uy1yW8hq0IOEoski1ECqODHSLpZo6NUdu7XjiYjQ3MeUxgWLQ==
X-Received: by 2002:a05:600c:1389:b0:45b:47e1:ef71 with SMTP id 5b1f17b1804b1-45b85599151mr53173445e9.36.1756726743718;
        Mon, 01 Sep 2025 04:39:03 -0700 (PDT)
Received: from localhost ([45.10.155.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7c461edasm96830885e9.9.2025.09.01.04.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 04:39:03 -0700 (PDT)
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
Subject: [PATCH net-next v4 3/5] net: gso: restore ids of outer ip headers correctly
Date: Mon,  1 Sep 2025 13:38:24 +0200
Message-Id: <20250901113826.6508-4-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250901113826.6508-1-richardbgobert@gmail.com>
References: <20250901113826.6508-1-richardbgobert@gmail.com>
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
both inner and outer IDs to be mangled.

This commit also modifies a few drivers that use SKB_GSO_FIXEDID directly.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 .../networking/segmentation-offloads.rst        |  9 ++++-----
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c |  8 ++++++--
 drivers/net/ethernet/sfc/ef100_tx.c             | 17 +++++++++++++----
 include/linux/netdevice.h                       |  9 +++++++--
 include/linux/skbuff.h                          |  6 +++++-
 net/core/dev.c                                  |  4 +++-
 net/ipv4/af_inet.c                              | 13 ++++++-------
 net/ipv4/tcp_offload.c                          |  5 +----
 8 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/Documentation/networking/segmentation-offloads.rst b/Documentation/networking/segmentation-offloads.rst
index 085e8fab03fd..d5dccfc6b82b 100644
--- a/Documentation/networking/segmentation-offloads.rst
+++ b/Documentation/networking/segmentation-offloads.rst
@@ -46,7 +46,9 @@ GSO type SKB_GSO_TCP_FIXEDID is specified then we will not increment the IP
 ID and all segments will use the same IP ID.  If a device has
 NETIF_F_TSO_MANGLEID set then the IP ID can be ignored when performing TSO
 and we will either increment the IP ID for all frames, or leave it at a
-static value based on driver preference.
+static value based on driver preference. For outer headers of encapsulated
+packets, the device drivers must guarantee that the IPv4 ID field is
+incremented in the case that a given header does not have the DF bit set.
 
 
 UDP Fragmentation Offload
@@ -124,10 +126,7 @@ Generic Receive Offload
 Generic receive offload is the complement to GSO.  Ideally any frame
 assembled by GRO should be segmented to create an identical sequence of
 frames using GSO, and any sequence of frames segmented by GSO should be
-able to be reassembled back to the original by GRO.  The only exception to
-this is IPv4 ID in the case that the DF bit is set for a given IP header.
-If the value of the IPv4 ID is not sequentially incrementing it will be
-altered so that it is when a frame assembled via GRO is segmented via GSO.
+able to be reassembled back to the original by GRO.
 
 
 Partial Generic Segmentation Offload
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
index e6b6be549581..24971346df00 100644
--- a/drivers/net/ethernet/sfc/ef100_tx.c
+++ b/drivers/net/ethernet/sfc/ef100_tx.c
@@ -190,6 +190,7 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
 	bool gso_partial = skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL;
 	unsigned int len, ip_offset, tcp_offset, payload_segs;
 	u32 mangleid = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
+	u32 mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
 	unsigned int outer_ip_offset, outer_l4_offset;
 	u16 vlan_tci = skb_vlan_tag_get(skb);
 	u32 mss = skb_shinfo(skb)->gso_size;
@@ -200,8 +201,17 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
 	bool outer_csum;
 	u32 paylen;
 
-	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID)
-		mangleid = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
+	if (encap) {
+		if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID_INNER)
+			mangleid = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
+		if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID)
+			mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
+	} else {
+		if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID)
+			mangleid = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
+		mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
+	}
+
 	if (efx->net_dev->features & NETIF_F_HW_VLAN_CTAG_TX)
 		vlan_enable = skb_vlan_tag_present(skb);
 
@@ -245,8 +255,7 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
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
index f3a3b761abfb..3d19c888b839 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5290,13 +5290,18 @@ void skb_warn_bad_offload(const struct sk_buff *skb);
 
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
index ca8be45dd8be..cf95b325f9b4 100644
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
index 93a25d87b86b..f57c8dbf307f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3769,7 +3769,9 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 		features &= ~dev->gso_partial_features;
 
 	/* Make sure to clear the IPv4 ID mangling feature if the
-	 * IPv4 header has the potential to be fragmented.
+	 * IPv4 header has the potential to be fragmented. For
+	 * encapsulated packets, the outer headers are guaranteed to
+	 * have incrementing IDs if DF is not set.
 	 */
 	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4) {
 		struct iphdr *iph = skb->encapsulation ?
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
index 1949eede9ec9..e6612bd84d09 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -471,7 +471,6 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
 	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
 	struct tcphdr *th = tcp_hdr(skb);
-	bool is_fixedid;
 
 	if (unlikely(NAPI_GRO_CB(skb)->is_flist)) {
 		skb_shinfo(skb)->gso_type |= SKB_GSO_FRAGLIST | SKB_GSO_TCPV4;
@@ -485,10 +484,8 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
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


