Return-Path: <netdev+bounces-205944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73621B00E09
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 23:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B564B5C3C99
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 21:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6623A28C5D5;
	Thu, 10 Jul 2025 21:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j/mFtLF1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA111548C
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 21:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183928; cv=none; b=n3Wrq+jMJullJYb3J1Lq9UNQtSbBtgc6rmGAIv3mWr/p+oyEavf4SIQgbMlhEdWUWdUnblXhR18IF8cF1v/xzJzkR6pbO4KPX6qujaUonH8O14CkWLO0Sr6/YKIDztnWa/c7YN6nZCgH+LBXexjErQ7zeDcpRaNtuj7N91E4SOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183928; c=relaxed/simple;
	bh=SQMKwpA7Mdbwg7Q/cJVSkwLSPW+ShhE5vG/kLmfErg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcn/1dw7zFguCC5mKIgbrOSU0yaKjnT13HKZi4p0uGYZf9/Z79kOIGYvY/4N7LND14qwGQxqDc5ipmua7hpji4XrS9MFW0tJ9hLstUk97nkKenU3hBW/lvq2IrxE6hqXhWzcLtCaupfV7tehdYmhsBH/qUiTLGqbqRol7IVNp3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j/mFtLF1; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752183927; x=1783719927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SQMKwpA7Mdbwg7Q/cJVSkwLSPW+ShhE5vG/kLmfErg8=;
  b=j/mFtLF1EFPPljtdOsYLO2dXoX4Z3RoBPT7TDg7v5k64C7YoKd9ZRFaM
   1fa1RfGAb0H3ofhVGTvb9AG1DgKdBVIeFxbfDxqcRymtansE8T4+J/V+u
   C2RgJIEHQMyl+qE+fQfQmHoofbaXegJhnUTOIvyFGSFdqXEybn3JXNorc
   8mcXd1wkH3jskso2YLCoH81MdRJs5nXxEhzTAZdiaaBqrLpJTRRgCW5Wo
   KEo3NKL4G1Si4Ff2g6/9aBDhgFCHYUAXyWQThEnawUOSTBAN/WEdfpns/
   xJEAjFUzqQC8Eix8T0xK/aasIXs567hDQe6fIvaLCv28iyi+VPq2h6I7w
   A==;
X-CSE-ConnectionGUID: 7awCCRZwQ4mSk6o/pMXxgw==
X-CSE-MsgGUID: 9USvpLzMRJ6jF8WDHzGDtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54192346"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="54192346"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 14:45:26 -0700
X-CSE-ConnectionGUID: Hd4rjEKqSOetRWQHFT485w==
X-CSE-MsgGUID: +cjyiNghT76ZrHvU+jBHAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="161764930"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 10 Jul 2025 14:45:24 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	madhu.chittim@intel.com,
	yahui.cao@intel.com,
	przemyslaw.kitszel@intel.com
Subject: [PATCH net-next 1/8] ice: add support for reading and unpacking Rx queue context
Date: Thu, 10 Jul 2025 14:45:10 -0700
Message-ID: <20250710214518.1824208-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250710214518.1824208-1-anthony.l.nguyen@intel.com>
References: <20250710214518.1824208-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

In order to support live migration, the ice driver will need to read
certain data from the Rx queue context. This is stored in the hardware in a
packed format.

Since we use <linux/packing.h> for the mapping between the packed hardware
format and the unpacked structure, it is trivial to enable unpacking
support via the unpack_fields() function.

Add the ice_unpack_rxq_ctx() function based on the unpack_fields() API.
Re-use the same field definitions from the packing implementation.

Add ice_copy_rxq_ctx_from_hw() to copy the Rx queue context data from the
hardware registers.

Use these to implement ice_read_rxq_ctx() which will return the Rx queue
context to the caller in its unpacked ice_rlan_ctx struct.

This will enable the migration logic access to the relevant data about the
Rx device queues. It can easily be copied to the target system as part of
the migration payload, where it will be used to configure the Rx queues.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 60 +++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_common.h |  2 +
 2 files changed, 62 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 84cd8c6dcf39..ddde3487aea9 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1342,6 +1342,26 @@ static void ice_copy_rxq_ctx_to_hw(struct ice_hw *hw,
 	}
 }
 
+/**
+ * ice_copy_rxq_ctx_from_hw - Copy packed Rx Queue context from HW registers
+ * @hw: pointer to the hardware structure
+ * @rxq_ctx: pointer to the packed Rx queue context
+ * @rxq_index: the index of the Rx queue
+ */
+static void ice_copy_rxq_ctx_from_hw(struct ice_hw *hw,
+				     ice_rxq_ctx_buf_t *rxq_ctx,
+				     u32 rxq_index)
+{
+	u32 *ctx = (u32 *)rxq_ctx;
+
+	/* Copy each dword separately from HW */
+	for (int i = 0; i < ICE_RXQ_CTX_SIZE_DWORDS; i++, ctx++) {
+		*ctx = rd32(hw, QRX_CONTEXT(i, rxq_index));
+
+		ice_debug(hw, ICE_DBG_QCTX, "qrxdata[%d]: %08X\n", i, *ctx);
+	}
+}
+
 #define ICE_CTX_STORE(struct_name, struct_field, width, lsb) \
 	PACKED_FIELD((lsb) + (width) - 1, (lsb), struct struct_name, struct_field)
 
@@ -1385,6 +1405,21 @@ static void ice_pack_rxq_ctx(const struct ice_rlan_ctx *ctx,
 		    QUIRK_LITTLE_ENDIAN | QUIRK_LSW32_IS_FIRST);
 }
 
+/**
+ * ice_unpack_rxq_ctx - Unpack Rx queue context from a HW buffer
+ * @buf: the HW buffer to unpack from
+ * @ctx: the Rx queue context to unpack
+ *
+ * Unpack the Rx queue context from the HW buffer into the CPU-friendly
+ * structure.
+ */
+static void ice_unpack_rxq_ctx(const ice_rxq_ctx_buf_t *buf,
+			       struct ice_rlan_ctx *ctx)
+{
+	unpack_fields(buf, sizeof(*buf), ctx, ice_rlan_ctx_fields,
+		      QUIRK_LITTLE_ENDIAN | QUIRK_LSW32_IS_FIRST);
+}
+
 /**
  * ice_write_rxq_ctx - Write Rx Queue context to hardware
  * @hw: pointer to the hardware structure
@@ -1410,6 +1445,31 @@ int ice_write_rxq_ctx(struct ice_hw *hw, struct ice_rlan_ctx *rlan_ctx,
 	return 0;
 }
 
+/**
+ * ice_read_rxq_ctx - Read Rx queue context from HW
+ * @hw: pointer to the hardware structure
+ * @rlan_ctx: pointer to the Rx queue context
+ * @rxq_index: the index of the Rx queue
+ *
+ * Read the Rx queue context from the hardware registers, and unpack it into
+ * the sparse Rx queue context structure.
+ *
+ * Returns: 0 on success, or -EINVAL if the Rx queue index is invalid.
+ */
+int ice_read_rxq_ctx(struct ice_hw *hw, struct ice_rlan_ctx *rlan_ctx,
+		     u32 rxq_index)
+{
+	ice_rxq_ctx_buf_t buf = {};
+
+	if (rxq_index > QRX_CTRL_MAX_INDEX)
+		return -EINVAL;
+
+	ice_copy_rxq_ctx_from_hw(hw, &buf, rxq_index);
+	ice_unpack_rxq_ctx(&buf, rlan_ctx);
+
+	return 0;
+}
+
 /* LAN Tx Queue Context */
 static const struct packed_field_u8 ice_tlan_ctx_fields[] = {
 				    /* Field			Width	LSB */
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index e8979b80c2f0..01992440bb9f 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -118,6 +118,8 @@ void ice_set_safe_mode_caps(struct ice_hw *hw);
 
 int ice_write_rxq_ctx(struct ice_hw *hw, struct ice_rlan_ctx *rlan_ctx,
 		      u32 rxq_index);
+int ice_read_rxq_ctx(struct ice_hw *hw, struct ice_rlan_ctx *rlan_ctx,
+		     u32 rxq_index);
 
 int
 ice_aq_get_rss_lut(struct ice_hw *hw, struct ice_aq_get_set_rss_lut_params *get_params);
-- 
2.47.1


