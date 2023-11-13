Return-Path: <netdev+bounces-47514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828697EA6C2
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72DA6B209ED
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BD93FB1C;
	Mon, 13 Nov 2023 23:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HqZZTkb3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB473E492
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:11:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B3ED73
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699917062; x=1731453062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hlLUuNEHmkWvz6BKJl5YmsC+CbXQBpzDNSH0OBV2tKk=;
  b=HqZZTkb3tAD4UZ4M88yfW4+YxUF0JQoUR8nCrTlUTabE3TNaqI/bDc3C
   NiSlCqZFWX+mkahFVo9rczhYjItLUooC47jVg9x85MW1bg8oOrJQ1Of9E
   iH1Mwjjp4930I5egMJC90ZtEhbuk05ZJlAeNPMWXpxZdmUIy7gnn2d7B6
   vpmHhJA20u8ZC5HMDfQ17Z6ejw1TiinwNWerGl//iZ3tx+qEF3t6a2sVd
   QMW2x3TDrT61zTg7KbfbnsTdnRsSSsUhy3elOkuWivsIfUfJWk1dG9Whq
   kod1Q/FKT4e0CGFpmLDtSLcJneMELj7dYRyOC2knMl1Ml4FA8A6ZctPGy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="375562668"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="375562668"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 15:10:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="888051437"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="888051437"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 13 Nov 2023 15:10:54 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 14/15] i40e: Move inline helpers to i40e_prototype.h
Date: Mon, 13 Nov 2023 15:10:33 -0800
Message-ID: <20231113231047.548659-15-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113231047.548659-1-anthony.l.nguyen@intel.com>
References: <20231113231047.548659-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ivan Vecera <ivecera@redhat.com>

Move version check helper functions from i40e_type.h to
i40e_prototype.h as per discussion [1].

[1] https://lore.kernel.org/all/cdcd6b97-1138-4cd7-854f-b3faa1f475f8@intel.com/#t

Cc: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/i40e/i40e_prototype.h  | 70 +++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_type.h   | 68 ------------------
 2 files changed, 70 insertions(+), 68 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index 001162042050..af4269330581 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -501,4 +501,74 @@ i40e_add_pinfo_to_list(struct i40e_hw *hw,
 /* i40e_ddp */
 int i40e_ddp_flash(struct net_device *netdev, struct ethtool_flash *flash);
 
+/* Firmware and AdminQ version check helpers */
+
+/**
+ * i40e_is_aq_api_ver_ge
+ * @hw: pointer to i40e_hw structure
+ * @maj: API major value to compare
+ * @min: API minor value to compare
+ *
+ * Assert whether current HW API version is greater/equal than provided.
+ **/
+static inline bool i40e_is_aq_api_ver_ge(struct i40e_hw *hw, u16 maj, u16 min)
+{
+	return (hw->aq.api_maj_ver > maj ||
+		(hw->aq.api_maj_ver == maj && hw->aq.api_min_ver >= min));
+}
+
+/**
+ * i40e_is_aq_api_ver_lt
+ * @hw: pointer to i40e_hw structure
+ * @maj: API major value to compare
+ * @min: API minor value to compare
+ *
+ * Assert whether current HW API version is less than provided.
+ **/
+static inline bool i40e_is_aq_api_ver_lt(struct i40e_hw *hw, u16 maj, u16 min)
+{
+	return !i40e_is_aq_api_ver_ge(hw, maj, min);
+}
+
+/**
+ * i40e_is_fw_ver_ge
+ * @hw: pointer to i40e_hw structure
+ * @maj: API major value to compare
+ * @min: API minor value to compare
+ *
+ * Assert whether current firmware version is greater/equal than provided.
+ **/
+static inline bool i40e_is_fw_ver_ge(struct i40e_hw *hw, u16 maj, u16 min)
+{
+	return (hw->aq.fw_maj_ver > maj ||
+		(hw->aq.fw_maj_ver == maj && hw->aq.fw_min_ver >= min));
+}
+
+/**
+ * i40e_is_fw_ver_lt
+ * @hw: pointer to i40e_hw structure
+ * @maj: API major value to compare
+ * @min: API minor value to compare
+ *
+ * Assert whether current firmware version is less than provided.
+ **/
+static inline bool i40e_is_fw_ver_lt(struct i40e_hw *hw, u16 maj, u16 min)
+{
+	return !i40e_is_fw_ver_ge(hw, maj, min);
+}
+
+/**
+ * i40e_is_fw_ver_eq
+ * @hw: pointer to i40e_hw structure
+ * @maj: API major value to compare
+ * @min: API minor value to compare
+ *
+ * Assert whether current firmware version is equal to provided.
+ **/
+static inline bool i40e_is_fw_ver_eq(struct i40e_hw *hw, u16 maj, u16 min)
+{
+	return (hw->aq.fw_maj_ver > maj ||
+		(hw->aq.fw_maj_ver == maj && hw->aq.fw_min_ver == min));
+}
+
 #endif /* _I40E_PROTOTYPE_H_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index e21a8e06f6b2..e3f73be5eb09 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -586,74 +586,6 @@ struct i40e_hw {
 	char err_str[16];
 };
 
-/**
- * i40e_is_aq_api_ver_ge
- * @hw: pointer to i40e_hw structure
- * @maj: API major value to compare
- * @min: API minor value to compare
- *
- * Assert whether current HW API version is greater/equal than provided.
- **/
-static inline bool i40e_is_aq_api_ver_ge(struct i40e_hw *hw, u16 maj, u16 min)
-{
-	return (hw->aq.api_maj_ver > maj ||
-		(hw->aq.api_maj_ver == maj && hw->aq.api_min_ver >= min));
-}
-
-/**
- * i40e_is_aq_api_ver_lt
- * @hw: pointer to i40e_hw structure
- * @maj: API major value to compare
- * @min: API minor value to compare
- *
- * Assert whether current HW API version is less than provided.
- **/
-static inline bool i40e_is_aq_api_ver_lt(struct i40e_hw *hw, u16 maj, u16 min)
-{
-	return !i40e_is_aq_api_ver_ge(hw, maj, min);
-}
-
-/**
- * i40e_is_fw_ver_ge
- * @hw: pointer to i40e_hw structure
- * @maj: API major value to compare
- * @min: API minor value to compare
- *
- * Assert whether current firmware version is greater/equal than provided.
- **/
-static inline bool i40e_is_fw_ver_ge(struct i40e_hw *hw, u16 maj, u16 min)
-{
-	return (hw->aq.fw_maj_ver > maj ||
-		(hw->aq.fw_maj_ver == maj && hw->aq.fw_min_ver >= min));
-}
-
-/**
- * i40e_is_fw_ver_lt
- * @hw: pointer to i40e_hw structure
- * @maj: API major value to compare
- * @min: API minor value to compare
- *
- * Assert whether current firmware version is less than provided.
- **/
-static inline bool i40e_is_fw_ver_lt(struct i40e_hw *hw, u16 maj, u16 min)
-{
-	return !i40e_is_fw_ver_ge(hw, maj, min);
-}
-
-/**
- * i40e_is_fw_ver_eq
- * @hw: pointer to i40e_hw structure
- * @maj: API major value to compare
- * @min: API minor value to compare
- *
- * Assert whether current firmware version is equal to provided.
- **/
-static inline bool i40e_is_fw_ver_eq(struct i40e_hw *hw, u16 maj, u16 min)
-{
-	return (hw->aq.fw_maj_ver > maj ||
-		(hw->aq.fw_maj_ver == maj && hw->aq.fw_min_ver == min));
-}
-
 struct i40e_driver_version {
 	u8 major_version;
 	u8 minor_version;
-- 
2.41.0


