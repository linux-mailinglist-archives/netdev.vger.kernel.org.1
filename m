Return-Path: <netdev+bounces-82511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A9E88E6EA
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 15:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83441F31417
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 14:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2872E158D71;
	Wed, 27 Mar 2024 13:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VDrdUHHP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5608158A31
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711546475; cv=none; b=FM04UtRAY7/6vCQDjKAn1xaGGktGcMdAWT9Z8jlk21zIDgNc0PaYr0Nw4+rHBrRzrQpYYK95mOxMCJ7e6q7TxF9aUB9v9MapgkKEMvmw3IEP0A/1Bd54tXkJRp1t3OryWvgzK0Dr4MtOq9oAH85EntoRQhJYKsU6hr8RjeR/2wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711546475; c=relaxed/simple;
	bh=6lGF6vMGdljZnKEL+Lko5pt873z/i9BVn8qi3/zJ4rQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AZBVSBK6J0tm3bXVYfNNtvj61R5hRzgf5Xp6LSswNVkPpXJojhX5op+kw4FvPOJIPLhKH4ujjyT9TBCF2HEJ89xJ2WGqEnPc/2d5aViLFHQ+weHqQlbUAgYDPAY5+0jdY5kaG888Ls8/QpRD9Q7vAn83OzhhjTEN2YJSVfJumBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VDrdUHHP; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711546473; x=1743082473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6lGF6vMGdljZnKEL+Lko5pt873z/i9BVn8qi3/zJ4rQ=;
  b=VDrdUHHPUCIaKKMZdpOwG1W+DzRqloLqAyw3rh3Z47PozGFBszrq9Y8r
   easZB2AfxX51Nhuv5Q3Edw4+Gg+3fbMTWM6xZiMFpMqtaTEyE+Xr+UOf7
   7g0hF5mOVEoKy6TJ3cdSPdqn5RMvdKnktBFu4unk4fS0zJ2OH8VUPlKme
   CDxXABQftavikDU9zQ1X56lnkI5spT6NbhCv82Gq4/jzyAP6xXQUCHD8Z
   z67gh1xMYxH1xxozjehU85DzU1Zwo014hv77EZrY4/AKKhgxnQVKYQiXr
   62Y/5cY6BliTVdfYd+x3XeD0Oe9mumc94ORPNonPmcuurHJeZhZD6D7l8
   w==;
X-CSE-ConnectionGUID: I9EXg2/2QR6TOlZ6ysr+Qw==
X-CSE-MsgGUID: hn+nunbyQCqZK6vdwQWM+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="9608532"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="9608532"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 06:34:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="16355739"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa009.fm.intel.com with ESMTP; 27 Mar 2024 06:34:30 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id E51D4284E2;
	Wed, 27 Mar 2024 13:34:28 +0000 (GMT)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v2 10/12] iavf: Implement checking DD desc field
Date: Wed, 27 Mar 2024 09:25:41 -0400
Message-Id: <20240327132543.15923-11-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240327132543.15923-1-mateusz.polchlopek@intel.com>
References: <20240327132543.15923-1-mateusz.polchlopek@intel.com>
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
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 26 ++++++++++++++++++++-
 drivers/net/ethernet/intel/iavf/iavf_txrx.h | 17 --------------
 drivers/net/ethernet/intel/iavf/iavf_type.h |  1 +
 3 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index c9c4f255bc8b..baf3cf80e3ac 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -8,6 +8,26 @@
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
+ */
+static bool iavf_is_descriptor_done(struct iavf_ring *rx_ring,
+				    union iavf_rx_desc *rx_desc)
+{
+	if (rx_ring->rxdid == VIRTCHNL_RXDID_1_32B_BASE)
+		return !!(FIELD_GET(cpu_to_le64(IAVF_RX_DESC_STATUS_DD_MASK),
+				    rx_desc->wb.qword1.status_error_len));
+
+	return !!(FIELD_GET(cpu_to_le16(IAVF_RX_FLEX_DESC_STATUS_ERR0_DD_BIT),
+		  rx_desc->flex_wb.status_error0));
+}
+
 static __le64 build_ctob(u32 td_cmd, u32 td_offset, unsigned int size,
 			 u32 td_tag)
 {
@@ -1720,7 +1740,11 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
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
index 90447a8c3a7a..b84416918e7d 100644
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


