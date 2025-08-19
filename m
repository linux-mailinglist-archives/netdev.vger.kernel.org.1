Return-Path: <netdev+bounces-214875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA38B2B981
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 08:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C4758094A
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 06:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF98026B09F;
	Tue, 19 Aug 2025 06:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrQWDh45"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F3426AA88;
	Tue, 19 Aug 2025 06:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755585183; cv=none; b=E+OTag6mxf7fnTh8OmkdUWsom7lk1eSjdKDYYErn99uppWdgBc4V38zbSZaNKHgois9+s/FQNDabdYc0VdBGaURkwABGMen1InrmNzSvjCkOkFNAt8FU80kbcW7WCvkbn5s/2pLv8EVMjcOPSQ9Rf9vlP9Vrq5g/UvBkgCaAczg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755585183; c=relaxed/simple;
	bh=OfLyoH0cg9GZUNRAwURHWhCQ0NMGnYXZtKLKS7BlHK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VvRCHs2rejY1bA01p5Ev37eGzMhwGIWgsxpbOyMbENqkjEcCWE5z94ap3qAZ6biiY2pVkT0H+aLEd8Wou/4zq/ZM0YEr/kIcs1UhwCt16QAmrwO0WQDoVorieMzzl1P30JHyMNURaBSMqBiurki1eB1bYtUXDh0Ls5rjZJldDF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrQWDh45; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b9edf504e6so2318879f8f.3;
        Mon, 18 Aug 2025 23:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755585180; x=1756189980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lA0Q2VNB/j3y3014rbHE36ssQRvnzL/ofA2ZgCqaRk=;
        b=IrQWDh45sKZ/ybZN688hHQHZ3y2wr98RibUgWT9b/YJHTPcTC8SINPRaiIqP8Z0w/M
         9pmVPmZF3ANuih2D+2NYOaPQEuYJ5n1bOr43yiunegr+GeDiBNXlQ3CSgkyE9P5kUekU
         jBCGGif6mNNaQI0/HvuWoJU8vGdIubfm9z9G01q6hkyBl0MjV7qh5T6Ao+tdL61cvSzp
         +cgxuxiJfX+1LODVefdAq83GyoAlcPqrQ2tQrNFqhfEGhZ1ES4g4eH8uIIQJXrhAV3ZC
         DnsQlJMs5dTdC6uKAtnVXBSGJXRuHl8dTzUjWFPoDBQEKVC2jGYRp3ktFtt23GCvNzoQ
         pjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755585180; x=1756189980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3lA0Q2VNB/j3y3014rbHE36ssQRvnzL/ofA2ZgCqaRk=;
        b=s1NBLRT3Y0r77e33E93VuCkzqEW9/ci4P91PPsBpO5qQHkMb6wT9kx671IMb7akrIa
         g2wIT0rgWU6J9lOp3mJ1ytbLQQUm0Q3m9S/dzF3D581mXoxnk5W60y8tGf8RSF84d7J+
         CYcE7D0fDgUECNJie5bawafSBha/yTcrsNiWX9/xUiZIh7Yfowdj+xnV9yye0GlGVagY
         0vORrwHaOLJnbeiChCvvUhn4wlcjxFnPLpY2r2mHEpAN91U/avPHOoaQs5eDis/bSfGy
         68HQCBOu3s6U2Ha0ofyng4o1M25CQihnXq+f+eutzEFcDQ2tI3TTxFZgIxcij4/O7XwP
         KubA==
X-Forwarded-Encrypted: i=1; AJvYcCUBCtLfGbmYsgrm2GoU7bclsW/GZcaD/PhIZ3i54lBdQstZwUKMAL2Xns5S8Eevm/UCKUQs/lFW18Hc8Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcltHw+43cwkZCS961lr5vBe34H60J2ANBK6vd4dXW6OpEDFGr
	HEkEmM8DmTKiHDo6LLi0qSYtEkTPEFzp3XnH/CspoM7sF1/x0Cm4LIO5SfvfKCSIWPo=
X-Gm-Gg: ASbGncvk1aps1msaTwnAq4E7SfYbhxPzLfJGhkt+TJNcOPO1k3VG4BvwecTbxZB4TO9
	x4cQVLrXYo4uUzuc+Zd81SGh0Lm7K2xBJbFXRHlRrGEP9bdNd1u/jAxbm6PM35TI2FveYBC4EB8
	wZp5I/diACP+EGd0aaJmg/s0h+7tBdI/OsKLGcgG4ei3Rf3JKp83xIaBO2M/CaBbmrWo+3WXTVE
	5jfumUL2QUotJjjGPDtMojDwfFVttwFSfp3DW3xg+4/4GqAwxD7/kumG+Lf0mnshFsdgCP4P2ib
	PNlhihxBfxWzgjz6UboEdsB2jnl8iua3AM3AzgIKx9KMQvifJaFpEY0x1FctDoyGZe2Q/+ffU5n
	PBW+lfNdP8/v1Ihy1HQPQnw3tx91WYN0Yhw==
X-Google-Smtp-Source: AGHT+IEBs20KmwTJSX6hRMbY4Z681eGmU5/G+LjS/vApaV8EC2YwgwzYwXikSV51QPfovELicuhK2A==
X-Received: by 2002:a05:6000:230a:b0:3b8:d7c7:71bb with SMTP id ffacd0b85a97d-3c0e92984e1mr1022370f8f.21.1755585179599;
        Mon, 18 Aug 2025 23:32:59 -0700 (PDT)
Received: from localhost ([45.10.155.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c074d43956sm2317648f8f.19.2025.08.18.23.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 23:32:59 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	shenjian15@huawei.com,
	salil.mehta@huawei.com,
	shaojijie@huawei.com,
	andrew+netdev@lunn.ch,
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
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	florian.fainelli@broadcom.com,
	willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v2 3/5] net: gso: restore ids of outer ip headers correctly
Date: Tue, 19 Aug 2025 08:32:21 +0200
Message-Id: <20250819063223.5239-4-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250819063223.5239-1-richardbgobert@gmail.com>
References: <20250819063223.5239-1-richardbgobert@gmail.com>
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
NETIF_F_TSO_MANGLEID_{INNER,OUTER} to provide more granular control to
drivers.

This commit also modifies a few drivers that use SKB_GSO_FIXEDID directly.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 Documentation/networking/segmentation-offloads.rst |  4 ++--
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |  8 ++++++--
 drivers/net/ethernet/sfc/ef100_tx.c                | 14 ++++++++------
 include/linux/netdevice.h                          |  9 +++++++--
 include/linux/skbuff.h                             |  6 +++++-
 net/core/dev.c                                     |  7 +++----
 net/ipv4/af_inet.c                                 | 13 ++++++-------
 net/ipv4/tcp_offload.c                             |  4 +---
 9 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/Documentation/networking/segmentation-offloads.rst b/Documentation/networking/segmentation-offloads.rst
index 085e8fab03fd..21c759b81f4e 100644
--- a/Documentation/networking/segmentation-offloads.rst
+++ b/Documentation/networking/segmentation-offloads.rst
@@ -42,8 +42,8 @@ also point to the TCP header of the packet.
 
 For IPv4 segmentation we support one of two types in terms of the IP ID.
 The default behavior is to increment the IP ID with every segment.  If the
-GSO type SKB_GSO_TCP_FIXEDID is specified then we will not increment the IP
-ID and all segments will use the same IP ID.  If a device has
+GSO type SKB_GSO_TCP_FIXEDID_{OUTER,INNER} is specified then we will not
+increment the IP ID and all segments will use the same IP ID.  If a device has
 NETIF_F_TSO_MANGLEID set then the IP ID can be ignored when performing TSO
 and we will either increment the IP ID for all frames, or leave it at a
 static value based on driver preference.
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index bfa5568baa92..b28f890b0af5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3868,7 +3868,7 @@ static int hns3_gro_complete(struct sk_buff *skb, u32 l234info)
 		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
 
 	if (l234info & BIT(HNS3_RXD_GRO_FIXID_B))
-		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID;
+		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID_OUTER;
 
 	skb->csum_start = (unsigned char *)th - skb->head;
 	skb->csum_offset = offsetof(struct tcphdr, check);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index b8c609d91d11..78df60c62225 100644
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
+					     SKB_GSO_TCP_FIXEDID_INNER : SKB_GSO_TCP_FIXEDID_OUTER;
+	}
 
 	skb->csum_start = (unsigned char *)tcp - skb->head;
 	skb->csum_offset = offsetof(struct tcphdr, check);
diff --git a/drivers/net/ethernet/sfc/ef100_tx.c b/drivers/net/ethernet/sfc/ef100_tx.c
index e6b6be549581..aab2425e62bb 100644
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
@@ -200,8 +201,10 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
 	bool outer_csum;
 	u32 paylen;
 
-	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID)
-		mangleid = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID_OUTER)
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
index 5e5de4b0a433..e55ba6918b0a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5287,13 +5287,18 @@ void skb_warn_bad_offload(const struct sk_buff *skb);
 
 static inline bool net_gso_ok(netdev_features_t features, int gso_type)
 {
-	netdev_features_t feature = (netdev_features_t)gso_type << NETIF_F_GSO_SHIFT;
+	netdev_features_t feature;
+
+	if (gso_type & (SKB_GSO_TCP_FIXEDID_OUTER | SKB_GSO_TCP_FIXEDID_INNER))
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
index 14b923ddb6df..5cfbf6e8c7ea 100644
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
+	SKB_GSO_TCP_FIXEDID_OUTER = 1 << 30,
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
index 76e38092cd8a..7f29b485009d 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1393,14 +1393,13 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 
 	segs = ERR_PTR(-EPROTONOSUPPORT);
 
-	if (!skb->encapsulation || encap) {
-		udpfrag = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP);
-		fixedid = !!(skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID);
+	/* fixed ID is invalid if DF bit is not set */
+	fixedid = !!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCP_FIXEDID_OUTER << encap));
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
index 74f46663eeae..83fa6b2aecf4 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -485,10 +485,8 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 	th->check = ~tcp_v4_check(skb->len - thoff, iph->saddr,
 				  iph->daddr, 0);
 
-	bool is_fixedid = (NAPI_GRO_CB(skb)->ip_fixedid >> skb->encapsulation) & 1;
-
 	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4 |
-			(is_fixedid * SKB_GSO_TCP_FIXEDID);
+			(NAPI_GRO_CB(skb)->ip_fixedid * SKB_GSO_TCP_FIXEDID_OUTER);
 
 	tcp_gro_complete(skb);
 	return 0;
-- 
2.36.1


