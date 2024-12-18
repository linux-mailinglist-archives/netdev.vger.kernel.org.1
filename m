Return-Path: <netdev+bounces-153083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7159F6BC9
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 18:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE9B316B13E
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE7D1547E2;
	Wed, 18 Dec 2024 17:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ns3vn857"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FB11DFE0C
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541400; cv=none; b=IkF8J/fC5Qf+glPh84LdSTq5HqBdbVIpTVxv411qBMW1crrMAlIfeWTvtZH8LyaBHqXj4TC3Qbrh7UxW/5s/06Y38t7o6A+7viBwwbiU3qIT38rUMJndmNCpRLQN3DIDlmTqOCJv3a3eaLB6WJ2TIYV8Hzp99+7QNh7ARtq4m6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541400; c=relaxed/simple;
	bh=YwPOY40LgGCD6jfywP775/m6uM4ihk8K4jKCQDY0srk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Piz6jZZaJVEk8F63roW1VSTJv+/yc6/tIeRrPyBAk3cxKS5SiNtSU4qqHcqzNhN7oI5IJYbcQ+XV2gCkMI1WqFEW4L2/ClZli/CebvgqmRETa/eooLo6rGRzDSz1x3B9fjzQY/CbOTGwuNdBtHeuiDcFVnZkENrf0TUu6LbGqDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ns3vn857; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734541398; x=1766077398;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YwPOY40LgGCD6jfywP775/m6uM4ihk8K4jKCQDY0srk=;
  b=Ns3vn857CIrA8cWAQPNh3dcZb+RHaFO1kML3DxBgBsSnF2yTJ3kV1L4L
   y0PCAWOEHLllTvxWgDf9kpg0R0kta0BmpCk5Vt89Kar7q68xt78oEWAh+
   BH33DaCeGwMlYBcsYqwNHczN7TaPoDWeEMQVs3Esfl73wQOISDYrMKgN4
   txIhIHMq8xnRLoQcVPPm2d+MSMR+TC8Jgr7j5Uzl9rmNwgNQ4DW6MOBY8
   PY7ONLz690SJ7dvkiwP2BEw/JYzUurrGjKpadIjFdOqg2QCThVN5xANi7
   aL2p+hPcCyPou8ahAvr8Q/FCT9EaBpyJkRpEWZF4u/rflp4y9OFjp4GmR
   A==;
X-CSE-ConnectionGUID: KQwyPMjNSOCpinnu7LyCQQ==
X-CSE-MsgGUID: dQ9sxj7tQs+IqMIZxCy15A==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="35184361"
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="35184361"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 09:03:11 -0800
X-CSE-ConnectionGUID: pFI8njKNRCSMd/sZdFQOuA==
X-CSE-MsgGUID: p4X/2kNTT3qddWPqxloEsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="98154781"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.5.147])
  by fmviesa008.fm.intel.com with ESMTP; 18 Dec 2024 09:03:10 -0800
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: kuba@kernel.org,
	netdev@vger.kernel.org,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Alice Michael <alice.michael@intel.com>,
	Eric Joyner <eric.joyner@intel.com>
Subject: [PATCH iwl-next v6] ice: Add E830 checksum offload support
Date: Wed, 18 Dec 2024 04:11:45 -0500
Message-ID: <20241218091145.240373-1-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

E830 supports raw receive and generic transmit checksum offloads.

Raw receive checksum support is provided by hardware calculating the
checksum over the whole packet, regardless of type. The calculated
checksum is provided to driver in the Rx flex descriptor. Then the driver
assigns the checksum to skb->csum and sets skb->ip_summed to
CHECKSUM_COMPLETE.

Generic transmit checksum support is provided by hardware calculating the
checksum given two offsets: the start offset to begin checksum calculation,
and the offset to insert the calculated checksum in the packet. Support is
advertised to the stack using NETIF_F_HW_CSUM feature.

E830 has the following limitations when both generic transmit checksum
offload and TCP Segmentation Offload (TSO) are enabled:

1. Inner packet header modification is not supported. This restriction
   includes the inability to alter TCP flags, such as the push flag. As a
   result, this limitation can impact the receiver's ability to coalesce
   packets, potentially degrading network throughput.
2. The Maximum Segment Size (MSS) is limited to 1023 bytes, which prevents
   support of Maximum Transmission Unit (MTU) greater than 1063 bytes.

Therefore NETIF_F_HW_CSUM and NETIF_F_ALL_TSO features are mutually
exclusive. NETIF_F_HW_CSUM hardware feature support is indicated but is not
enabled by default. Instead, IP checksums and NETIF_F_ALL_TSO are the
defaults. Enforcement of mutual exclusivity of NETIF_F_HW_CSUM and
NETIF_F_ALL_TSO is done in ice_set_features(). Mutual exclusivity
of IP checksums and NETIF_F_HW_CSUM is handled by netdev_fix_features().

When NETIF_F_HW_CSUM is requested the provided skb->csum_start and
skb->csum_offset are passed to hardware in the Tx context descriptor
generic checksum (GCS) parameters. Hardware calculates the 1's complement
from skb->csum_start to the end of the packet, and inserts the result in
the packet at skb->csum_offset.

Co-developed-by: Alice Michael <alice.michael@intel.com>
Signed-off-by: Alice Michael <alice.michael@intel.com>
Co-developed-by: Eric Joyner <eric.joyner@intel.com>
Signed-off-by: Eric Joyner <eric.joyner@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
Changelog:
v1->v2
- Update commit message with additional details.
- Add newlines, and add params around
- Return early from ice_fix_features() to avoid extra indentation and
  large if block.
- Move and change some defines.
- replace htons and le16_t_cpu with swap16.
- Use FIELD_PREP where possible.
- Removed checksum valid bit check STATUS1_L2TAG2P_S. This check is not
  needed since there is no situation which will return an error.
v2->v3
- Minor fixes in commit message.
- Removed unused register defines in ice_hw_autogen.h.
- Moved GCS and TSO feature fix to helper function
  ice_fix_features_gcs(), and updated logic.
- Update to align naming with related flags.
v3->v4
- Move a check for GCS and TSO mutual exclusivity from
  ice_fix_features() to ice_set_features().
v4->v5
- Remove lingering GCS and TSO mutual exclusivity comments and code in
  ice_fix_features().
- Remove unused variable ICE_TX_FLAGS_RING_GCS.
- Remove Tested-by and Signed-off-by tag due to changes to patch.
- Use ICE_TX_GCS_DESC_TYPE_M and ICE_TX_GCS_DESC_CSUM_PSH in
  ice_tx_csum() to set the GCS decriptor field type.
v5->v6
- Fix build error.
---
 drivers/net/ethernet/intel/ice/ice.h          |  1 +
 .../net/ethernet/intel/ice/ice_lan_tx_rx.h    |  9 +++++--
 drivers/net/ethernet/intel/ice/ice_lib.c      |  8 +++++-
 drivers/net/ethernet/intel/ice/ice_main.c     | 18 +++++++++++++
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 27 ++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  2 ++
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 26 ++++++++++++++++++
 7 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 2f5d6f974185..0d2c80578633 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -203,6 +203,7 @@ enum ice_feature {
 	ICE_F_SMA_CTRL,
 	ICE_F_CGU,
 	ICE_F_GNSS,
+	ICE_F_GCS,
 	ICE_F_ROCE_LAG,
 	ICE_F_SRIOV_LAG,
 	ICE_F_MBX_LIMIT,
diff --git a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
index 611577ebc29d..5b98222fe27f 100644
--- a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
+++ b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
@@ -229,7 +229,7 @@ struct ice_32b_rx_flex_desc_nic {
 	__le16 status_error1;
 	u8 flexi_flags2;
 	u8 ts_low;
-	__le16 l2tag2_1st;
+	__le16 raw_csum;
 	__le16 l2tag2_2nd;
 
 	/* Qword 3 */
@@ -500,10 +500,15 @@ enum ice_tx_desc_len_fields {
 struct ice_tx_ctx_desc {
 	__le32 tunneling_params;
 	__le16 l2tag2;
-	__le16 rsvd;
+	__le16 gcs;
 	__le64 qw1;
 };
 
+#define ICE_TX_GCS_DESC_START_M		GENMASK(7, 0)
+#define ICE_TX_GCS_DESC_OFFSET_M	GENMASK(11, 8)
+#define ICE_TX_GCS_DESC_TYPE_M		GENMASK(14, 12)
+#define ICE_TX_GCS_DESC_CSUM_PSH	1
+
 #define ICE_TXD_CTX_QW1_CMD_S	4
 #define ICE_TXD_CTX_QW1_CMD_M	(0x7FUL << ICE_TXD_CTX_QW1_CMD_S)
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index e07fc8851e1d..23d4b0677b21 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1420,6 +1420,10 @@ static int ice_vsi_alloc_rings(struct ice_vsi *vsi)
 		ring->dev = dev;
 		ring->count = vsi->num_rx_desc;
 		ring->cached_phctime = pf->ptp.cached_phc_time;
+
+		if (ice_is_feature_supported(pf, ICE_F_GCS))
+			ring->flags |= ICE_RX_FLAGS_RING_GCS;
+
 		WRITE_ONCE(vsi->rx_rings[i], ring);
 	}
 
@@ -3883,8 +3887,10 @@ void ice_init_feature_support(struct ice_pf *pf)
 		break;
 	}
 
-	if (pf->hw.mac_type == ICE_MAC_E830)
+	if (pf->hw.mac_type == ICE_MAC_E830) {
 		ice_set_feature_support(pf, ICE_F_MBX_LIMIT);
+		ice_set_feature_support(pf, ICE_F_GCS);
+	}
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 89fa3d53d317..16677dca58a8 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3666,6 +3666,12 @@ void ice_set_netdev_features(struct net_device *netdev)
 	 */
 	netdev->hw_features |= NETIF_F_RXFCS;
 
+	/* Mutual exclusivity for TSO and GCS is enforced by the set features
+	 * ndo callback.
+	 */
+	if (ice_is_feature_supported(pf, ICE_F_GCS))
+		netdev->hw_features |= NETIF_F_HW_CSUM;
+
 	netif_set_tso_max_size(netdev, ICE_MAX_TSO_SIZE);
 }
 
@@ -6567,6 +6573,18 @@ ice_set_features(struct net_device *netdev, netdev_features_t features)
 	if (changed & NETIF_F_LOOPBACK)
 		ret = ice_set_loopback(vsi, !!(features & NETIF_F_LOOPBACK));
 
+	/* Due to E830 hardware limitations, TSO (NETIF_F_ALL_TSO) with GCS
+	 * (NETIF_F_HW_CSUM) is not supported.
+	 */
+	if (ice_is_feature_supported(pf, ICE_F_GCS) &&
+	    ((features & NETIF_F_HW_CSUM) && (features & NETIF_F_ALL_TSO))) {
+		if (netdev->features & NETIF_F_HW_CSUM)
+			dev_err(ice_pf_to_dev(pf), "To enable TSO, you must first disable HW checksum.\n");
+		else
+			dev_err(ice_pf_to_dev(pf), "To enable HW checksum, you must first disable TSO.\n");
+		return -EIO;
+	}
+
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 5d2d7736fd5f..f2b2d6bc0c43 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1753,6 +1753,7 @@ ice_tx_map(struct ice_tx_ring *tx_ring, struct ice_tx_buf *first,
 static
 int ice_tx_csum(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 {
+	const struct ice_tx_ring *tx_ring = off->tx_ring;
 	u32 l4_len = 0, l3_len = 0, l2_len = 0;
 	struct sk_buff *skb = first->skb;
 	union {
@@ -1902,6 +1903,30 @@ int ice_tx_csum(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 	l3_len = l4.hdr - ip.hdr;
 	offset |= (l3_len / 4) << ICE_TX_DESC_LEN_IPLEN_S;
 
+	if ((tx_ring->netdev->features & NETIF_F_HW_CSUM) &&
+	    !(first->tx_flags & ICE_TX_FLAGS_TSO) &&
+	    !skb_csum_is_sctp(skb)) {
+		/* Set GCS */
+		u16 csum_start = (skb->csum_start - skb->mac_header) / 2;
+		u16 csum_offset = skb->csum_offset / 2;
+		u16 gcs_params;
+
+		gcs_params = FIELD_PREP(ICE_TX_GCS_DESC_START_M, csum_start) |
+			     FIELD_PREP(ICE_TX_GCS_DESC_OFFSET_M, csum_offset) |
+			     FIELD_PREP(ICE_TX_GCS_DESC_TYPE_M,
+					ICE_TX_GCS_DESC_CSUM_PSH);
+
+		/* Unlike legacy HW checksums, GCS requires a context
+		 * descriptor.
+		 */
+		off->cd_qw1 |= ICE_TX_DESC_DTYPE_CTX;
+		off->cd_gcs_params = gcs_params;
+		/* Fill out CSO info in data descriptors */
+		off->td_offset |= offset;
+		off->td_cmd |= cmd;
+		return 1;
+	}
+
 	/* Enable L4 checksum offloads */
 	switch (l4_proto) {
 	case IPPROTO_TCP:
@@ -2383,7 +2408,7 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
 		/* setup context descriptor */
 		cdesc->tunneling_params = cpu_to_le32(offload.cd_tunnel_params);
 		cdesc->l2tag2 = cpu_to_le16(offload.cd_l2tag2);
-		cdesc->rsvd = cpu_to_le16(0);
+		cdesc->gcs = cpu_to_le16(offload.cd_gcs_params);
 		cdesc->qw1 = cpu_to_le64(offload.cd_qw1);
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index cb347c852ba9..5b0b54ac5c00 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -193,6 +193,7 @@ struct ice_tx_offload_params {
 	u32 td_l2tag1;
 	u32 cd_tunnel_params;
 	u16 cd_l2tag2;
+	u16 cd_gcs_params;
 	u8 header_len;
 };
 
@@ -367,6 +368,7 @@ struct ice_rx_ring {
 #define ICE_RX_FLAGS_RING_BUILD_SKB	BIT(1)
 #define ICE_RX_FLAGS_CRC_STRIP_DIS	BIT(2)
 #define ICE_RX_FLAGS_MULTIDEV		BIT(3)
+#define ICE_RX_FLAGS_RING_GCS		BIT(4)
 	u8 flags;
 	/* CL5 - 5th cacheline starts here */
 	struct xdp_rxq_info xdp_rxq;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index 2719f0e20933..45cfaabc41cb 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -80,6 +80,23 @@ ice_rx_hash_to_skb(const struct ice_rx_ring *rx_ring,
 		libeth_rx_pt_set_hash(skb, hash, decoded);
 }
 
+/**
+ * ice_rx_gcs - Set generic checksum in skb
+ * @skb: skb currently being received and modified
+ * @rx_desc: receive descriptor
+ */
+static void ice_rx_gcs(struct sk_buff *skb,
+		       const union ice_32b_rx_flex_desc *rx_desc)
+{
+	const struct ice_32b_rx_flex_desc_nic *desc;
+	u16 csum;
+
+	desc = (struct ice_32b_rx_flex_desc_nic *)rx_desc;
+	skb->ip_summed = CHECKSUM_COMPLETE;
+	csum = (__force u16)desc->raw_csum;
+	skb->csum = csum_unfold((__force __sum16)swab16(csum));
+}
+
 /**
  * ice_rx_csum - Indicate in skb if checksum is good
  * @ring: the ring we care about
@@ -107,6 +124,15 @@ ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
 	rx_status0 = le16_to_cpu(rx_desc->wb.status_error0);
 	rx_status1 = le16_to_cpu(rx_desc->wb.status_error1);
 
+	if ((ring->flags & ICE_RX_FLAGS_RING_GCS) &&
+	    rx_desc->wb.rxdid == ICE_RXDID_FLEX_NIC &&
+	    (decoded.inner_prot == LIBETH_RX_PT_INNER_TCP ||
+	     decoded.inner_prot == LIBETH_RX_PT_INNER_UDP ||
+	     decoded.inner_prot == LIBETH_RX_PT_INNER_ICMP)) {
+		ice_rx_gcs(skb, rx_desc);
+		return;
+	}
+
 	/* check if HW has decoded the packet and checksum */
 	if (!(rx_status0 & BIT(ICE_RX_FLEX_DESC_STATUS0_L3L4P_S)))
 		return;
-- 
2.45.0


