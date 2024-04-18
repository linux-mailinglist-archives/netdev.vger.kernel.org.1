Return-Path: <netdev+bounces-88984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E43888A9273
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 07:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12D1E1C21B76
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 05:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6188E6EB49;
	Thu, 18 Apr 2024 05:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/vZiUtz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75E86A353
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 05:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713418492; cv=none; b=CPc9oFKo5gaUSwS8XvCHNwdIHQbvQoyRKD9EnaFRpYt3SKpSLi9N5hKzAhbTOy3N+LqjbchBCu6sNiIRi91OegsVVbbGEeV6UfYHaehMATYTHgAhHmP0J/P68JH5no7yiQ4CVRdcUJBybW1ZYbU9XJq0xMaNPf1nyEF0BiqcBqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713418492; c=relaxed/simple;
	bh=H81k6sDC1csk/WXgLfW0CS/dGv/MQEvs7t8FPOf0uBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mm32/zIcnVtND52pwZfCDo+YF9350cpQq1cBd/vibgixPpJ8uX0M1qoeZWO2HFUtX7RcEiZtAVHuq2Z5nezxMJFClHtLfTmFDpEt59ZUwESQD17GsJaE8xeoYoymk1yxlwY3JTnV0s87dySYJK80tw7qmqltRnQV6jw0+8HQZ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F/vZiUtz; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713418491; x=1744954491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H81k6sDC1csk/WXgLfW0CS/dGv/MQEvs7t8FPOf0uBc=;
  b=F/vZiUtzbUIHCSKAeBrox6D9/d7QAmA57HDkkHu/s+OQM3q8ZZq88EsQ
   4/TGnYtNZoVmJ+YqbgCEhSGleGHdx5jA3vUOk/TnE8bBDU/mAL8+EPfGk
   71jQM0Tk5I/LfgIRhdwvvKhMfv7lNMbf8nSxhoPwtFZUHAKsSz4zYqN+z
   VztZKUtZzBKLyejOl6iLBmg3HvMD0hkPCFldVr6TpIf7q8yIy/rOtKydI
   z0bTzwzh+7PHY6UiiC1lIHNTd/sgKM21Gp+WM1Ed4JG8loolwwpomDQIl
   0D72SMDBIFNPW9g6zSWkNsa89DjlXpnMZh9C6aOgVAQp4ZmCB1IN2ZUV2
   A==;
X-CSE-ConnectionGUID: SijEgvImQpOk5RsTEtcAFg==
X-CSE-MsgGUID: 4AWuhiysQMKii0CJwIgA5g==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8814680"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="8814680"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 22:34:51 -0700
X-CSE-ConnectionGUID: TvPuTnySQEivRAIIgpGxtA==
X-CSE-MsgGUID: uIDcC/zCQKOayI59E9hYFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="22947397"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa009.fm.intel.com with ESMTP; 17 Apr 2024 22:34:49 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id E5C9D27BA1;
	Thu, 18 Apr 2024 06:34:47 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	horms@kernel.org,
	anthony.l.nguyen@intel.com,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v5 10/12] iavf: Implement checking DD desc field
Date: Thu, 18 Apr 2024 01:24:58 -0400
Message-Id: <20240418052500.50678-11-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240418052500.50678-1-mateusz.polchlopek@intel.com>
References: <20240418052500.50678-1-mateusz.polchlopek@intel.com>
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
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 30 ++++++++++++++++++++-
 drivers/net/ethernet/intel/iavf/iavf_txrx.h | 17 ------------
 drivers/net/ethernet/intel/iavf/iavf_type.h |  1 +
 3 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index e2f46e29945f..8e90b0b2a292 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -8,6 +8,30 @@
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
@@ -1718,7 +1742,11 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
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
index 67e51b4883bc..54d858303839 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
@@ -153,23 +153,6 @@ static inline int iavf_skb_pad(void)
 #define IAVF_SKB_PAD (NET_SKB_PAD + NET_IP_ALIGN)
 #endif
 
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
index e80d1f7b3052..5527e6479ebd 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_type.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_type.h
@@ -318,6 +318,7 @@ union iavf_32byte_rx_desc {
  */
 #define IAVF_RX_DESC_STATUS_INT_UDP_0_MASK	BIT(18)
 
+#define IAVF_RX_FLEX_DESC_STATUS_ERR0_DD_BIT	BIT(0)
 #define IAVF_RX_FLEX_DESC_STATUS_ERR0_EOP_BIT	BIT(1)
 #define IAVF_RX_FLEX_DESC_STATUS_ERR0_RXE_BIT	BIT(10)
 
-- 
2.38.1


