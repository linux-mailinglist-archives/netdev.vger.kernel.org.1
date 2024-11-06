Return-Path: <netdev+bounces-142350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268A39BE5BB
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 12:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39B17B2311F
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 11:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6A41DED5F;
	Wed,  6 Nov 2024 11:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dBmwFSYR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FAF1DF756
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730893079; cv=none; b=FYTyXtCIj6BuBxo7jkH3/FSgs4ruD8DVgb9Kle3DEGu4aGeNJJomC1SLquOEkaXLL2f6KUdRfm2Dh/MO0XKpLL8nCn3ATuzW6ecVvURvHxGeYZwTNbXi/oNe3WvRd9i6pBQkpn7A7J+CxOvuZRA36kZ+5jwN7PMobACqZsj+/iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730893079; c=relaxed/simple;
	bh=ztrWwR6guZAPWdxMTUFxLER/SjYkJNBYZ4m35vm44FQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZkZNhOuG3vuYB046Rh4xz0Nmb5hx8HnrvWRYq+Cz2EKnIhXh9AUamtFYX4e5cmz70JSevJDIj13LlGJIo61kXF9mqPJJZFnJ8bE302aqtfgEOqE5iyvY1RwvxaCmmiUVepdIbadQdoGycZ2oXHhF0/C0kcIiy2oKPZESDB54PfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dBmwFSYR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730893078; x=1762429078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ztrWwR6guZAPWdxMTUFxLER/SjYkJNBYZ4m35vm44FQ=;
  b=dBmwFSYRXbF8a0s8O2XjD0H4skRIvosfuEdRX6ok/cNYU+fT05AJb+9Y
   i9cb/l3tgizY63aT0VnRd5ZrV11/fS9IEAhmGHL1WmwZOuiKGiusgO8fk
   dsaRjvA0f1hVlsPJmGdxPoJ6Qht2mcJYlAc00idJtvYgamSx2D88kNnO4
   3HTHhqz9W6bvlcN8Y+jMAnrdPC8ANVgvRqyLGIyC3fLnl5ifBdPEXtKaB
   F/AXA6OVBm0DfsTSSEPCgTiM4sTKGIlwUK5ssvVafAMA6RVkZNHA5gQe7
   iMNrFYCJ1O4wvmrH7R13Q5QwPL7a43exq+rk2+f0dzLMqdpprg1iSdzQt
   g==;
X-CSE-ConnectionGUID: 7LvdOD0xQu+1zkp6l1nBmA==
X-CSE-MsgGUID: iKXvt1qvTd+hIHBWO4qE9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30455530"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30455530"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 03:37:57 -0800
X-CSE-ConnectionGUID: mrTBur+nQCWwDXKJFCD8aA==
X-CSE-MsgGUID: I3v25XRQSkWT7K6gdY3gVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="122020162"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa001.jf.intel.com with ESMTP; 06 Nov 2024 03:37:55 -0800
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 64F242FC41;
	Wed,  6 Nov 2024 11:37:54 +0000 (GMT)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v13 12/14] iavf: Implement checking DD desc field
Date: Wed,  6 Nov 2024 12:37:29 -0500
Message-Id: <20241106173731.4272-13-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241106173731.4272-1-mateusz.polchlopek@intel.com>
References: <20241106173731.4272-1-mateusz.polchlopek@intel.com>
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
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
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


