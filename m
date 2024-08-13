Return-Path: <netdev+bounces-118046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ACC950601
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 15:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6DA1C210D7
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 13:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FC919D095;
	Tue, 13 Aug 2024 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LinPp8cK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45C919D067
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723554502; cv=none; b=tHMY0TslVdqnA1I74wAhTuJwJCRbaR8iiEIBuaPI1z4Vv92RBlvltPFbqXGwr1vvxjZK3ztR8waWp/SpufnWn5M1fFDsf7sDURXm/h/zNIrpnlexbJ1gbHpvQsllkrtUKL7cQLH8kewZbj82wahMci/EQROXRo2Mc/WUWIr4HNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723554502; c=relaxed/simple;
	bh=9WfknfY3gEo5nflsyRpOyU/rMo17JdlH2EcYgg0AfLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oqjt9fag4mniTk6Xa8uRhpv3gXEA+kpWkCbvDdC9+3/UzH4+o0UzV284Mpjf1EqH5vecDsMNhS8m49HlIdAXaEI07gA0gO6z6oqkhcZ4uiwwLFX0sv55Pbf3KOUyP4GPOI/ngDWUvUj4cohxHuXj4JUbYhV1zOUrDsgMTXXyDCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LinPp8cK; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723554501; x=1755090501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9WfknfY3gEo5nflsyRpOyU/rMo17JdlH2EcYgg0AfLg=;
  b=LinPp8cKABsTR2LuqevmJKufnqDdWcWCKejFiNfZ0fgnQh/uQLcU4Yfg
   8DKzEIrWhfsZOoN1LL7c1395fhe7U+0yGcPQ64gz7KISHbyJ9eq6O7czi
   NJGyb2DDDsONflZlFyw7UiPh+2FV0jsYrZT1n4M9pm/tRG9xePFX6mYNg
   op55MI9Ep+XN5DFUPeRyZhuRqPs8nJgVPjcB89PLncZtVfknUrBVolpjj
   N/xLM8DGvagZbFp/T8kOyg0xyBJHe3N8SnrJZFblrY5jQBsw2URUzrR9h
   WAdSImVJ0iCT4+EKtLHvmNvuOUQJm1o5LJrYa+O76RW8BT/3JJcP1N+t7
   g==;
X-CSE-ConnectionGUID: npqhTcsDTUuhJmA/gfAbHg==
X-CSE-MsgGUID: fMnROLASQ9GfSIWe7HQ6pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="32290940"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="32290940"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 06:08:18 -0700
X-CSE-ConnectionGUID: KmH/TP2+RDebJse3mTMPBQ==
X-CSE-MsgGUID: Owqdsen2Rn+pncZvvEMjiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="59417158"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa008.jf.intel.com with ESMTP; 13 Aug 2024 06:08:15 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 992FB32C95;
	Tue, 13 Aug 2024 14:08:13 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	aleksander.lobakin@intel.com
Cc: netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: [Intel-wired-lan] [PATCH iwl-next v9 12/14] iavf: Implement checking DD desc field
Date: Tue, 13 Aug 2024 08:55:11 -0400
Message-Id: <20240813125513.8212-13-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240813125513.8212-1-mateusz.polchlopek@intel.com>
References: <20240813125513.8212-1-mateusz.polchlopek@intel.com>
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

Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 90 +++++++++++++++------
 drivers/net/ethernet/intel/iavf/iavf_txrx.h | 16 ----
 2 files changed, 65 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index cbcd6c7e675e..8f529cfaf7a8 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -9,6 +9,28 @@
 #include "iavf_trace.h"
 #include "iavf_prototype.h"
 
+/**
+ * iavf_is_descriptor_done - tests DD bit in Rx descriptor
+ * @rx_ring: the ring parameter to distinguish descriptor type (flex/legacy)
+ * @rx_desc: pointer to receive descriptor
+ *
+ * This function tests the descriptor done bit in specified descriptor. Because
+ * there are two types of descriptors (legacy and flex) the parameter rx_ring
+ * is used to distinguish.
+ *
+ * Return: true or false based on the state of DD bit in Rx descriptor.
+ */
+static bool iavf_is_descriptor_done(struct iavf_ring *rx_ring,
+				    struct iavf_rx_desc *rx_desc)
+{
+	__le64 qw1 = rx_desc->qw1;
+
+	if (rx_ring->rxdid == VIRTCHNL_RXDID_1_32B_BASE)
+		return !!le64_get_bits(qw1, IAVF_RXD_LEGACY_DD_M);
+
+	return !!le64_get_bits(qw1, IAVF_RXD_FLEX_DD_M);
+}
+
 static __le64 build_ctob(u32 td_cmd, u32 td_offset, unsigned int size,
 			 u32 td_tag)
 {
@@ -1223,24 +1245,31 @@ iavf_extract_legacy_rx_fields(const struct iavf_ring *rx_ring,
 			      const struct iavf_rx_desc *rx_desc, u32 *ptype)
 {
 	struct libeth_rqe_info fields = {};
-	u64 qw0 = le64_to_cpu(rx_desc->qw0);
 	u64 qw1 = le64_to_cpu(rx_desc->qw1);
-	u64 qw2 = le64_to_cpu(rx_desc->qw2);
-	bool l2tag1p;
-	bool l2tag2p;
 
-	fields.eop = FIELD_GET(IAVF_RXD_LEGACY_EOP_M, qw1);
 	fields.len = FIELD_GET(IAVF_RXD_LEGACY_LENGTH_M, qw1);
-	fields.rxe = FIELD_GET(IAVF_RXD_LEGACY_RXE_M, qw1);
-	*ptype = FIELD_GET(IAVF_RXD_LEGACY_PTYPE_M, qw1);
-
-	l2tag1p = FIELD_GET(IAVF_RXD_LEGACY_L2TAG1P_M, qw1);
-	if (l2tag1p && (rx_ring->flags & IAVF_TXRX_FLAGS_VLAN_TAG_LOC_L2TAG1))
-		fields.vlan_tag = FIELD_GET(IAVF_RXD_LEGACY_L2TAG1_M, qw0);
+	fields.eop = FIELD_GET(IAVF_RXD_LEGACY_EOP_M, qw1);
 
-	l2tag2p = FIELD_GET(IAVF_RXD_LEGACY_L2TAG2P_M, qw2);
-	if (l2tag2p && (rx_ring->flags & IAVF_RXR_FLAGS_VLAN_TAG_LOC_L2TAG2_2))
-		fields.vlan_tag = FIELD_GET(IAVF_RXD_LEGACY_L2TAG2_M, qw2);
+	if (fields.eop) {
+		bool l2tag1p, l2tag2p;
+		u64 qw0 = le64_to_cpu(rx_desc->qw0);
+		u64 qw2 = le64_to_cpu(rx_desc->qw2);
+
+		fields.rxe = FIELD_GET(IAVF_RXD_LEGACY_RXE_M, qw1);
+		*ptype = FIELD_GET(IAVF_RXD_LEGACY_PTYPE_M, qw1);
+
+		l2tag1p = FIELD_GET(IAVF_RXD_LEGACY_L2TAG1P_M, qw1);
+		if (l2tag1p &&
+		    (rx_ring->flags & IAVF_TXRX_FLAGS_VLAN_TAG_LOC_L2TAG1))
+			fields.vlan_tag = FIELD_GET(IAVF_RXD_LEGACY_L2TAG1_M,
+						    qw0);
+
+		l2tag2p = FIELD_GET(IAVF_RXD_LEGACY_L2TAG2P_M, qw2);
+		if (l2tag2p &&
+		    (rx_ring->flags & IAVF_RXR_FLAGS_VLAN_TAG_LOC_L2TAG2_2))
+			fields.vlan_tag = FIELD_GET(IAVF_RXD_LEGACY_L2TAG2_M,
+						    qw2);
+	}
 
 	return fields;
 }
@@ -1266,21 +1295,29 @@ iavf_extract_flex_rx_fields(const struct iavf_ring *rx_ring,
 	struct libeth_rqe_info fields = {};
 	u64 qw0 = le64_to_cpu(rx_desc->qw0);
 	u64 qw1 = le64_to_cpu(rx_desc->qw1);
-	u64 qw2 = le64_to_cpu(rx_desc->qw2);
-	bool l2tag1p, l2tag2p;
 
 	fields.len = FIELD_GET(IAVF_RXD_FLEX_PKT_LEN_M, qw0);
-	fields.rxe = FIELD_GET(IAVF_RXD_FLEX_RXE_M, qw1);
 	fields.eop = FIELD_GET(IAVF_RXD_FLEX_EOP_M, qw1);
-	*ptype = FIELD_GET(IAVF_RXD_FLEX_PTYPE_M, qw0);
 
-	l2tag1p = FIELD_GET(IAVF_RXD_FLEX_L2TAG1P_M, qw1);
-	if (l2tag1p && (rx_ring->flags & IAVF_TXRX_FLAGS_VLAN_TAG_LOC_L2TAG1))
-		fields.vlan_tag = FIELD_GET(IAVF_RXD_FLEX_L2TAG1_M, qw1);
+	if (fields.len) {
+		bool l2tag1p, l2tag2p;
+		u64 qw2 = le64_to_cpu(rx_desc->qw2);
+
+		fields.rxe = FIELD_GET(IAVF_RXD_FLEX_RXE_M, qw1);
+		*ptype = FIELD_GET(IAVF_RXD_FLEX_PTYPE_M, qw0);
 
-	l2tag2p = FIELD_GET(IAVF_RXD_FLEX_L2TAG2P_M, qw2);
-	if (l2tag2p && (rx_ring->flags & IAVF_RXR_FLAGS_VLAN_TAG_LOC_L2TAG2_2))
-		fields.vlan_tag = FIELD_GET(IAVF_RXD_FLEX_L2TAG2_2_M, qw2);
+		l2tag1p = FIELD_GET(IAVF_RXD_FLEX_L2TAG1P_M, qw1);
+		if (l2tag1p &&
+		    (rx_ring->flags & IAVF_TXRX_FLAGS_VLAN_TAG_LOC_L2TAG1))
+			fields.vlan_tag = FIELD_GET(IAVF_RXD_FLEX_L2TAG1_M,
+						    qw1);
+
+		l2tag2p = FIELD_GET(IAVF_RXD_FLEX_L2TAG2P_M, qw2);
+		if (l2tag2p &&
+		    (rx_ring->flags & IAVF_RXR_FLAGS_VLAN_TAG_LOC_L2TAG2_2))
+			fields.vlan_tag = FIELD_GET(IAVF_RXD_FLEX_L2TAG2_2_M,
+						    qw2);
+	}
 
 	return fields;
 }
@@ -1335,7 +1372,10 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 		 */
 		dma_rmb();
 
-		if (!iavf_test_staterr(rx_desc, IAVF_RXD_FLEX_DD_M))
+		/* If DD field (descriptor done) is unset then other fields are
+		 * not valid
+		 */
+		if (!iavf_is_descriptor_done(rx_ring, rx_desc))
 			break;
 
 		fields = iavf_extract_rx_fields(rx_ring, rx_desc, &ptype);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.h b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
index 59e7a58bc0f7..b72741f11338 100644
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
-- 
2.38.1


