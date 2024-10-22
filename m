Return-Path: <netdev+bounces-137731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0669E9A98C4
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 07:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F12D1F2391D
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 05:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E071146A93;
	Tue, 22 Oct 2024 05:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GYiApeLD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97F4145A18
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 05:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729575682; cv=none; b=RnMd/HO3waSjEsdIyK6zUL6IkAYoe30QfFqChXA7pPMrSgORw4eKXBEy3f0jtRGf8ynnZaPB8WMJrnBzT1G2psrZbmTZ7P45JVx8CJURXb8lXSn00spIidQLlQDvP8Bx7hXfzEE6pPBsRjA31b9S7fAI/2yBwQ/edKXtecRqs6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729575682; c=relaxed/simple;
	bh=uTEKeAjxWkCJOzxROyE+zpMPJ3k65YpKKun5rhvspe0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q/I6mbSJhBedBxqXdEK5HUoQbwngz3Ac7Bg0uN2K6F8iacRdsLvjA0l4Vh/9RCvl2tQwlXCOeHSuFZA+nDOnlAACfEBvb2/SYKy1ljgJfZ57g5vuur9sEouUi5jWNDXvlX5s+B9PQO2mHMh8l1lduAra/2bDFLnSffLLI6+uv3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GYiApeLD; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729575681; x=1761111681;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uTEKeAjxWkCJOzxROyE+zpMPJ3k65YpKKun5rhvspe0=;
  b=GYiApeLDuSkTSPbkMgsQpRx1LQRSqLbjy6egPYjxs35HAZfVpHV8e82H
   4K5tbAbxqzxfqqOmgap14i2wMB7+o5u4NIMa0aocDLFsExgT4HHy+QPLN
   S5KXw2ci2MMunxUUWgR5sEH5G8jVcyUaskx8gHuUwbunEQrRXYRzao6Hl
   SYFOuP53V7PIKSC+N7Jvvqg8qpAxo8hE2mrgas0/g6HZNISijlS44rHIM
   M9xdIwHQ4Sw9R6X6pc2T3ph2xfeXsFoRjjvho2wqpuvTrvfLN93asKqLe
   6CZygyrAqdwbdv8DdCsh7TshgDzJ6/XbJFNojS5NXQq305SbOpxXHOEGC
   Q==;
X-CSE-ConnectionGUID: f1UzUMXyTGGf1jJ7rGcfwA==
X-CSE-MsgGUID: sGwshbJWRtWkZnYCXqN06A==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="33015630"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="33015630"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 22:41:20 -0700
X-CSE-ConnectionGUID: VXDC8eG+RQunNdCqGPnVOQ==
X-CSE-MsgGUID: La8HS7fCQ5uVVqy+TwhWaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="84558124"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa003.jf.intel.com with ESMTP; 21 Oct 2024 22:41:17 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 16B2227BD9;
	Tue, 22 Oct 2024 06:41:16 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: [Intel-wired-lan] [PATCH iwl-next v12 12/14] iavf: Implement checking DD desc field
Date: Tue, 22 Oct 2024 07:41:19 -0400
Message-Id: <20241022114121.61284-13-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241022114121.61284-1-mateusz.polchlopek@intel.com>
References: <20241022114121.61284-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rx timestamping introduced in PF driver caused the need of refactoring
the VF driver mechanism to check packet fields.

The function to check errors in descriptor has been removed and from
now only previously set struct fields are being checked. The field DD
(descriptor done) needs to be checked at the very beginning, before
extracting other fields.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 54 ++++++++++++++++-----
 drivers/net/ethernet/intel/iavf/iavf_txrx.h | 16 ------
 drivers/net/ethernet/intel/iavf/iavf_type.h |  2 +
 3 files changed, 43 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 89b71509e521..283997b8a777 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -9,6 +9,25 @@
 #include "iavf_trace.h"
 #include "iavf_prototype.h"
 
+/**
+ * iavf_is_descriptor_done - tests DD bit in Rx descriptor
+ * @qw1: quad word 1 from descriptor to get Descriptor Done field from
+ * @flex: is the descriptor flex or legacy
+ *
+ * This function tests the descriptor done bit in specified descriptor. Because
+ * there are two types of descriptors (legacy and flex) the parameter rx_ring
+ * is used to distinguish.
+ *
+ * Return: true or false based on the state of DD bit in Rx descriptor.
+ */
+static bool iavf_is_descriptor_done(u64 qw1, bool flex)
+{
+	if (flex)
+		return FIELD_GET(IAVF_RXD_FLEX_DD_M, qw1);
+	else
+		return FIELD_GET(IAVF_RXD_LEGACY_DD_M, qw1);
+}
+
 static __le64 build_ctob(u32 td_cmd, u32 td_offset, unsigned int size,
 			 u32 td_tag)
 {
@@ -1063,6 +1082,7 @@ static void iavf_flex_rx_hash(const struct iavf_ring *ring, __le64 qw1,
  * @rx_desc: pointer to the EOP Rx descriptor
  * @skb: pointer to current skb being populated
  * @ptype: the packet type decoded by hardware
+ * @flex: is the descriptor flex or legacy
  *
  * This function checks the ring, descriptor, and packet information in
  * order to populate the hash, checksum, VLAN, protocol, and
@@ -1070,7 +1090,8 @@ static void iavf_flex_rx_hash(const struct iavf_ring *ring, __le64 qw1,
  **/
 static void iavf_process_skb_fields(const struct iavf_ring *rx_ring,
 				    const struct iavf_rx_desc *rx_desc,
-				    struct sk_buff *skb, u32 ptype)
+				    struct sk_buff *skb, u32 ptype,
+				    bool flex)
 {
 	struct libeth_rx_csum csum_bits;
 	struct libeth_rx_pt decoded_pt;
@@ -1079,14 +1100,14 @@ static void iavf_process_skb_fields(const struct iavf_ring *rx_ring,
 
 	decoded_pt = libie_rx_pt_parse(ptype);
 
-	if (rx_ring->rxdid == VIRTCHNL_RXDID_1_32B_BASE) {
-		iavf_legacy_rx_hash(rx_ring, qw0, qw1, skb, decoded_pt);
-		csum_bits = iavf_legacy_rx_csum(rx_ring->vsi, le64_to_cpu(qw1),
-						decoded_pt);
-	} else {
+	if (flex) {
 		iavf_flex_rx_hash(rx_ring, qw1, skb, decoded_pt);
 		csum_bits = iavf_flex_rx_csum(rx_ring->vsi, le64_to_cpu(qw1),
 					      decoded_pt);
+	} else {
+		iavf_legacy_rx_hash(rx_ring, qw0, qw1, skb, decoded_pt);
+		csum_bits = iavf_legacy_rx_csum(rx_ring->vsi, le64_to_cpu(qw1),
+						decoded_pt);
 	}
 	iavf_rx_csum(rx_ring->vsi, skb, decoded_pt, csum_bits);
 
@@ -1296,12 +1317,13 @@ iavf_extract_flex_rx_fields(const struct iavf_ring *rx_ring,
 
 static struct libeth_rqe_info
 iavf_extract_rx_fields(const struct iavf_ring *rx_ring,
-		       const struct iavf_rx_desc *rx_desc)
+		       const struct iavf_rx_desc *rx_desc,
+		       bool flex)
 {
-	if (rx_ring->rxdid == VIRTCHNL_RXDID_1_32B_BASE)
-		return iavf_extract_legacy_rx_fields(rx_ring, rx_desc);
-	else
+	if (flex)
 		return iavf_extract_flex_rx_fields(rx_ring, rx_desc);
+	else
+		return iavf_extract_legacy_rx_fields(rx_ring, rx_desc);
 }
 
 /**
@@ -1318,6 +1340,7 @@ iavf_extract_rx_fields(const struct iavf_ring *rx_ring,
  **/
 static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 {
+	bool flex = rx_ring->rxdid == VIRTCHNL_RXDID_2_FLEX_SQ_NIC;
 	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
 	struct sk_buff *skb = rx_ring->skb;
 	u16 cleaned_count = IAVF_DESC_UNUSED(rx_ring);
@@ -1327,6 +1350,7 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 		struct libeth_rqe_info fields;
 		struct libeth_fqe *rx_buffer;
 		struct iavf_rx_desc *rx_desc;
+		u64 qw1;
 
 		/* return some buffers to hardware, one at a time is too slow */
 		if (cleaned_count >= IAVF_RX_BUFFER_WRITE) {
@@ -1343,10 +1367,14 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 		 */
 		dma_rmb();
 
-		if (!iavf_test_staterr(rx_desc, IAVF_RXD_FLEX_DD_M))
+		qw1 = le64_to_cpu(rx_desc->qw1);
+		/* If DD field (descriptor done) is unset then other fields are
+		 * not valid
+		 */
+		if (!iavf_is_descriptor_done(qw1, flex))
 			break;
 
-		fields = iavf_extract_rx_fields(rx_ring, rx_desc);
+		fields = iavf_extract_rx_fields(rx_ring, rx_desc, flex);
 
 		iavf_trace(clean_rx_irq, rx_ring, rx_desc, skb);
 
@@ -1391,7 +1419,7 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 		total_rx_bytes += skb->len;
 
 		/* populate checksum, VLAN, and protocol */
-		iavf_process_skb_fields(rx_ring, rx_desc, skb, fields.ptype);
+		iavf_process_skb_fields(rx_ring, rx_desc, skb, fields.ptype, flex);
 
 		iavf_trace(clean_rx_irq_rx, rx_ring, rx_desc, skb);
 		iavf_receive_skb(rx_ring, skb, fields.vlan);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.h b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
index 3a1a39ee3615..dff5c8cd27ab 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
@@ -80,22 +80,6 @@ enum iavf_dyn_idx_t {
 	BIT_ULL(IAVF_FILTER_PCTYPE_NONF_UNICAST_IPV6_UDP) | \
 	BIT_ULL(IAVF_FILTER_PCTYPE_NONF_MULTICAST_IPV6_UDP))
 
-/**
- * iavf_test_staterr - tests bits in Rx descriptor status and error fields
- * @rx_desc: pointer to receive descriptor (in le64 format)
- * @stat_err_bits: value to mask
- *
- * This function does some fast chicanery in order to return the
- * value of the mask which is really only used for boolean tests.
- * The status_error_len doesn't need to be shifted because it begins
- * at offset zero.
- */
-static inline bool iavf_test_staterr(struct iavf_rx_desc *rx_desc,
-				     const u64 stat_err_bits)
-{
-	return !!(rx_desc->qw1 & cpu_to_le64(stat_err_bits));
-}
-
 /* How many Rx Buffers do we bundle into one write to the hardware ? */
 #define IAVF_RX_INCREMENT(r, i) \
 	do {					\
diff --git a/drivers/net/ethernet/intel/iavf/iavf_type.h b/drivers/net/ethernet/intel/iavf/iavf_type.h
index 3dc0907bf70d..e62a8a0067ea 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_type.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_type.h
@@ -212,6 +212,8 @@ struct iavf_rx_desc {
 #define IAVF_RXD_FLEX_PKT_LEN_M			GENMASK_ULL(45, 32)
 
 	aligned_le64 qw1;
+/* Descriptor done indication flag. */
+#define IAVF_RXD_LEGACY_DD_M			BIT(0)
 /* End of packet. Set to 1 if this descriptor is the last one of the packet */
 #define IAVF_RXD_LEGACY_EOP_M			BIT(1)
 /* L2 TAG 1 presence indication */
-- 
2.38.1


