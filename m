Return-Path: <netdev+bounces-225526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B306B9519D
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F733A6D86
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 09:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB8D31E885;
	Tue, 23 Sep 2025 08:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZD/XVrj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BDF3203BB
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617976; cv=none; b=aKOYGc7qGL55w07jl1ZdtHtg7ESkAmKqmHLjaDrNESOfipH3eF7CWqa5WF95Xgwui6zvJK/vS+ZmCSYdGBQ6+CLguO1aWV4HaSvDa60N88mxxOuMbfdU0bedgiYb48yVDORK4iQtPxOUn6fBF9vXPl+Ngs8sjrb4tHlTVBURs4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617976; c=relaxed/simple;
	bh=mwpH+4zT1g+G6TEU7adv0o3lnrk9wxcULLWWDCh5YeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N+ywYyK4Hyr4nzmwkRN7jguBPgtQ9VJV+BjmB1Xw1v3OKvzEqbYKZmhn9GElGPzlP3Kta1O/3xGrJBPcSwWGu8efXdGORS7Q8qW1UBZF6arz7d9lhDUdL5Yk6e3D6B+F631kzUHMpG3FDADud5cTZGHSyalsb7Z5sP2HqQRPHd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZD/XVrj; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso6095767f8f.1
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 01:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758617972; x=1759222772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYiWSiIlw6279hv0NQoxwvuf0HzKxI1tMKOKA6xTFU8=;
        b=UZD/XVrj+M/AwItpf46z5iup56xPPjyoTu374bYix3ApnSKq+we5DJBiLfIZJcl/s9
         Xw8KBiVLhEl5SBq3FgPE8X5a/dRVztJ0hjzb+BGbTs7ioFNztlomc5u00l53o7c2Gdjv
         7NuNZqYIqNQt6XcLwF4W2YvBaIlWNjYATCUyChX1R3TukczdUIrV9kdOaPkQDXFjgCyh
         KFVOY8PLu/euIpaR4jJd1sdtIifVF6MxyreZ8cZf1DlGaDxFBfQnKz1jU/wlQj+DMmYm
         JvjoWxo/i9qoIWlKjbjN4vi5gm/ZP90Y4YNZYllOHdlUJ6HUj0h1GtfubQbnij7ATHyY
         Czmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758617972; x=1759222772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYiWSiIlw6279hv0NQoxwvuf0HzKxI1tMKOKA6xTFU8=;
        b=cxJxq3rDghhPYuuHVjjRaICv09mAvbzEql+3HzoTEHcTNfd2aucNHz6eLQejyrOAhM
         xk3nzUHJ3ZDxT2uMM4pGV1iHft3OPu0nSDIDz9jGdb8WUMrkfXzrDwFCGhjwGLgaSnyb
         F+gu+pC0qoM+7mICkmdO1y3C3UDgBI0hcs/obgF+SQJ02ZoHzSHRYBsYv/wvA+WQl47+
         TByFp7uil8QcRYtKup+ZSYqUDW0tsLF4XlCQQAgWk9I9dRx6jjLXdTVPOd9abHwT1f2i
         v2SXtQjAF889Bhdku5QCEWvyyP4NQqDQG5nzvXB7rDcY1XKoR25w5tyA/bQotgIk0y4K
         vL1w==
X-Gm-Message-State: AOJu0YwygfAvxiF68m0H6nDBRpsh4q5AsLQaXNcyiyFfgqPLQ551+TzA
	pIOJNvMXijRwzAx8l115RuAkWecIwj7wcvBpNwLLC0qmN+DT+3NjIzfyXhQozA==
X-Gm-Gg: ASbGnctubaXIgclAnpo0tG6kSoKTeOrd0o/T1Kw+CH52O/3HBpifLHZbdSFdlldDaaL
	ainSDjX0hZ+wfR0spMTvQxSrA3eN9Noa7VPr1ZOF6XEV8fAEf0Ku2abSHKc729/pAPaZERXbWfu
	hC2BONJfAqxF2RV7umFN8Mn6e2btPVfAlbBrECHpV8askryoeyBBrsJm1moHzVpZehu5ltYXHhK
	cqZUYR72omcnYXMBGbx2Z5kAEMvaiAyKK/qMGzbzPCqZ5W0KM4UGO6ALk0/jO1GKVUCawbsvaFT
	jaLFj55lTsg8HYvP7e7gKPgTyQZfncKTRC5hNbsuLnW/UNsWZeslw6BTmyJ+n/1JZA7Zvt/Zf4Y
	MHMU4NKAqJH2O0MzWR+ToRZ8=
X-Google-Smtp-Source: AGHT+IGClJdJiVhI5jJZUAbVwrS1FBA8/oKDSDW4t0gzkJprCRTYzuYqCR9Df0AIVJ3AbEfUDArkWw==
X-Received: by 2002:a5d:5f92:0:b0:3eb:5e99:cbb9 with SMTP id ffacd0b85a97d-405c5bd7687mr1648976f8f.10.1758617972340;
        Tue, 23 Sep 2025 01:59:32 -0700 (PDT)
Received: from localhost ([45.10.155.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46d7a566a27sm67571115e9.20.2025.09.23.01.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 01:59:32 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	ecree.xilinx@gmail.com,
	willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	corbet@lwn.net,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	dsahern@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	aleksander.lobakin@intel.com,
	florian.fainelli@broadcom.com,
	alexander.duyck@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v8 3/5] net: gso: restore ids of outer ip headers correctly
Date: Tue, 23 Sep 2025 10:59:06 +0200
Message-Id: <20250923085908.4687-4-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250923085908.4687-1-richardbgobert@gmail.com>
References: <20250923085908.4687-1-richardbgobert@gmail.com>
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
Reviewed-by: Edward Cree <ecree.xilinx@gmail.com> # for sfc
---
 .../networking/segmentation-offloads.rst      | 22 ++++++++++++-------
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  8 +++++--
 drivers/net/ethernet/sfc/ef100_tx.c           | 17 ++++++++++----
 include/linux/netdevice.h                     |  9 ++++++--
 include/linux/skbuff.h                        |  8 ++++++-
 net/core/dev.c                                | 10 +++++++--
 net/ipv4/af_inet.c                            | 13 +++++------
 net/ipv4/tcp_offload.c                        |  6 ++---
 8 files changed, 63 insertions(+), 30 deletions(-)

diff --git a/Documentation/networking/segmentation-offloads.rst b/Documentation/networking/segmentation-offloads.rst
index 085e8fab03fd..72f69b22b28c 100644
--- a/Documentation/networking/segmentation-offloads.rst
+++ b/Documentation/networking/segmentation-offloads.rst
@@ -43,10 +43,19 @@ also point to the TCP header of the packet.
 For IPv4 segmentation we support one of two types in terms of the IP ID.
 The default behavior is to increment the IP ID with every segment.  If the
 GSO type SKB_GSO_TCP_FIXEDID is specified then we will not increment the IP
-ID and all segments will use the same IP ID.  If a device has
-NETIF_F_TSO_MANGLEID set then the IP ID can be ignored when performing TSO
-and we will either increment the IP ID for all frames, or leave it at a
-static value based on driver preference.
+ID and all segments will use the same IP ID.
+
+For encapsulated packets, SKB_GSO_TCP_FIXEDID refers only to the outer header.
+SKB_GSO_TCP_FIXEDID_INNER can be used to specify the same for the inner header.
+Any combination of these two GSO types is allowed.
+
+If a device has NETIF_F_TSO_MANGLEID set then the IP ID can be ignored when
+performing TSO and we will either increment the IP ID for all frames, or leave
+it at a static value based on driver preference.  For encapsulated packets,
+NETIF_F_TSO_MANGLEID is relevant for both outer and inner headers, unless the
+DF bit is not set on the outer header, in which case the device driver must
+guarantee that the IP ID field is incremented in the outer header with every
+segment.
 
 
 UDP Fragmentation Offload
@@ -124,10 +133,7 @@ Generic Receive Offload
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
index b8c609d91d11..480f66e21132 100644
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
+		skb_shinfo(skb)->gso_type |= encap ? SKB_GSO_TCP_FIXEDID_INNER :
+						     SKB_GSO_TCP_FIXEDID;
+	}
 
 	skb->csum_start = (unsigned char *)tcp - skb->head;
 	skb->csum_offset = offsetof(struct tcphdr, check);
diff --git a/drivers/net/ethernet/sfc/ef100_tx.c b/drivers/net/ethernet/sfc/ef100_tx.c
index e6b6be549581..03005757c060 100644
--- a/drivers/net/ethernet/sfc/ef100_tx.c
+++ b/drivers/net/ethernet/sfc/ef100_tx.c
@@ -189,6 +189,7 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
 {
 	bool gso_partial = skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL;
 	unsigned int len, ip_offset, tcp_offset, payload_segs;
+	u32 mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
 	u32 mangleid = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
 	unsigned int outer_ip_offset, outer_l4_offset;
 	u16 vlan_tci = skb_vlan_tag_get(skb);
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
index ca8be45dd8be..646fb66ba948 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -674,7 +674,7 @@ enum {
 	/* This indicates the tcp segment has CWR set. */
 	SKB_GSO_TCP_ECN = 1 << 2,
 
-	SKB_GSO_TCP_FIXEDID = 1 << 3,
+	__SKB_GSO_TCP_FIXEDID = 1 << 3,
 
 	SKB_GSO_TCPV6 = 1 << 4,
 
@@ -707,6 +707,12 @@ enum {
 	SKB_GSO_FRAGLIST = 1 << 18,
 
 	SKB_GSO_TCP_ACCECN = 1 << 19,
+
+	/* These indirectly map onto the same netdev feature.
+	 * If NETIF_F_TSO_MANGLEID is set it may mangle both inner and outer IDs.
+	 */
+	SKB_GSO_TCP_FIXEDID = 1 << 30,
+	SKB_GSO_TCP_FIXEDID_INNER = 1 << 31,
 };
 
 #if BITS_PER_LONG > 32
diff --git a/net/core/dev.c b/net/core/dev.c
index 93a25d87b86b..3b5cba01a611 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3768,8 +3768,14 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	if (!(skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL))
 		features &= ~dev->gso_partial_features;
 
-	/* Make sure to clear the IPv4 ID mangling feature if the
-	 * IPv4 header has the potential to be fragmented.
+	/* Make sure to clear the IPv4 ID mangling feature if the IPv4 header
+	 * has the potential to be fragmented so that TSO does not generate
+	 * segments with the same ID. For encapsulated packets, the ID mangling
+	 * feature is guaranteed not to use the same ID for the outer IPv4
+	 * headers of the generated segments if the headers have the potential
+	 * to be fragmented, so there is no need to clear the IPv4 ID mangling
+	 * feature (see the section about NETIF_F_TSO_MANGLEID in
+	 * segmentation-offloads.rst).
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
index 1949eede9ec9..2cb93da93abc 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -471,7 +471,6 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
 	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
 	struct tcphdr *th = tcp_hdr(skb);
-	bool is_fixedid;
 
 	if (unlikely(NAPI_GRO_CB(skb)->is_flist)) {
 		skb_shinfo(skb)->gso_type |= SKB_GSO_FRAGLIST | SKB_GSO_TCPV4;
@@ -485,10 +484,9 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 	th->check = ~tcp_v4_check(skb->len - thoff, iph->saddr,
 				  iph->daddr, 0);
 
-	is_fixedid = (NAPI_GRO_CB(skb)->ip_fixedid >> skb->encapsulation) & 1;
-
+	BUILD_BUG_ON(SKB_GSO_TCP_FIXEDID << 1 != SKB_GSO_TCP_FIXEDID_INNER);
 	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4 |
-			(is_fixedid * SKB_GSO_TCP_FIXEDID);
+			(NAPI_GRO_CB(skb)->ip_fixedid * SKB_GSO_TCP_FIXEDID);
 
 	tcp_gro_complete(skb);
 	return 0;
-- 
2.36.1


