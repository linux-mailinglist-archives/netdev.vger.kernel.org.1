Return-Path: <netdev+bounces-98501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADAF8D19A6
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20FCC281A95
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 11:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3E116C84D;
	Tue, 28 May 2024 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JkBT0EMk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0009F16D324
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896045; cv=none; b=m00tl0VxDB7f0dBPxRg8ayZFOgxRM7lvYHks1Ue4KbuVhk/Xc5opfeKyZY9iT45muDsKwMNPHhw9um3iaoQKqh6KqQLbPBhRkRnC/5Brn8IxpyBizTltFYhkuhDJJNRXkbyp/r2WIa22wTXXk+heBvmpLQo16hiSGj6j4Lk/T9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896045; c=relaxed/simple;
	bh=eV0lxpXkCoamU6+zg0eGXExILgVQ2uro7nTGSixxTzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mGm+CmcRnJuLR8HF9spT2n0aHsmrLAgIwiqRzDPSqOu/Jy+vnyQSTxaAnpFEeWa7x8VSC0gf+rf4UmrFGJ0oOe6ySrl8pTPPylYxP9S/cnP5f2008jE5vzPWGMl5EMFF5lJfxOFEyTa0lK3IZNX4xrwuumSmnUujbCWlqitAwRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JkBT0EMk; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716896044; x=1748432044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eV0lxpXkCoamU6+zg0eGXExILgVQ2uro7nTGSixxTzg=;
  b=JkBT0EMkLWD0x4S41ehrcpu86b8/2r6wtmyAhVkjGjS/p+HX4p9YEa0x
   Nz262Loet3H/GW/eH1CqpCgD1Q/d6+LKml4JbQ3Vgekqe210+ZmInMwIa
   2kAIEW/R+82szbs1+Wv0kspMbnKqV1eUMoWu8z+9SywHTCSqORYMxamOW
   gCRNJ6ZdobRqRL8l7ytRlbu5sf0puQfTU0ooa9TtrxQt/slL0L9WV5X1I
   OaN4wn1kWCOVcQDWb3Zja+v+7d32+pN4ROY25lH8jDA3e6i3i2GmWJhi+
   i8pjHGJi5SC9n7by6+v/L6KepkJ8szI6H5VaRL4FStwsqSXeiI+KUBxLh
   A==;
X-CSE-ConnectionGUID: eQeVA9nYRjKHsIooviBOFg==
X-CSE-MsgGUID: Wqhqc4GlQf2tdB+Sb4gCOg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="30757406"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="30757406"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 04:34:03 -0700
X-CSE-ConnectionGUID: NIESINl1S8KgJyJWpbmJAA==
X-CSE-MsgGUID: 5C6G0EjXRtaqTS/e93xJ9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="35126719"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa009.jf.intel.com with ESMTP; 28 May 2024 04:34:01 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 1E94027BB5;
	Tue, 28 May 2024 12:34:01 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v6 10/12] iavf: Implement checking DD desc field
Date: Tue, 28 May 2024 07:22:59 -0400
Message-Id: <20240528112301.5374-11-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240528112301.5374-1-mateusz.polchlopek@intel.com>
References: <20240528112301.5374-1-mateusz.polchlopek@intel.com>
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
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 30 ++++++++++++++++++++-
 drivers/net/ethernet/intel/iavf/iavf_txrx.h | 17 ------------
 drivers/net/ethernet/intel/iavf/iavf_type.h |  1 +
 3 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 97da5af52ad7..78da3b2e81a7 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -9,6 +9,30 @@
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
+ * Return: true or false based on the state of DD bit in Rx descriptor
+ */
+static bool iavf_is_descriptor_done(struct iavf_ring *rx_ring,
+				    union iavf_rx_desc *rx_desc)
+{
+	u64 status_error_len = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
+
+	if (rx_ring->rxdid == VIRTCHNL_RXDID_1_32B_BASE)
+		return !!(FIELD_GET(IAVF_RX_DESC_STATUS_DD_MASK,
+			  status_error_len));
+
+	return !!(FIELD_GET((IAVF_RX_FLEX_DESC_STATUS_ERR0_DD_BIT),
+		  le16_to_cpu(rx_desc->flex_wb.status_error0)));
+}
+
 static __le64 build_ctob(u32 td_cmd, u32 td_offset, unsigned int size,
 			 u32 td_tag)
 {
@@ -1367,7 +1391,11 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 		 * verified the descriptor has been written back.
 		 */
 		dma_rmb();
-		if (!iavf_test_staterr(rx_desc, IAVF_RX_DESC_STATUS_DD_MASK))
+
+		/* If DD field (descriptor done) is unset then other fields are
+		 * not valid
+		 */
+		if (!iavf_is_descriptor_done(rx_ring, rx_desc))
 			break;
 
 		iavf_extract_rx_fields(rx_ring, rx_desc, &fields);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.h b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
index 3661cd57a068..3add31924d75 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
@@ -82,23 +82,6 @@ enum iavf_dyn_idx_t {
 
 #define iavf_rx_desc iavf_32byte_rx_desc
 
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
-static inline bool iavf_test_staterr(union iavf_rx_desc *rx_desc,
-				     const u64 stat_err_bits)
-{
-	return !!(rx_desc->wb.qword1.status_error_len &
-		  cpu_to_le64(stat_err_bits));
-}
-
 struct iavf_rx_extracted {
 	unsigned int size;
 	u16 vlan_tag;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_type.h b/drivers/net/ethernet/intel/iavf/iavf_type.h
index 82c16a720807..61012ee5de2e 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_type.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_type.h
@@ -316,6 +316,7 @@ union iavf_32byte_rx_desc {
  */
 #define IAVF_RX_DESC_STATUS_INT_UDP_0_MASK	BIT(18)
 
+#define IAVF_RX_FLEX_DESC_STATUS_ERR0_DD_BIT	BIT(0)
 #define IAVF_RX_FLEX_DESC_STATUS_ERR0_EOP_BIT	BIT(1)
 #define IAVF_RX_FLEX_DESC_STATUS_ERR0_RXE_BIT	BIT(10)
 
-- 
2.38.1


