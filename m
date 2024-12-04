Return-Path: <netdev+bounces-149020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4DE9E3DFF
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 16:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3E72B36BA7
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1B9209F5B;
	Wed,  4 Dec 2024 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TDrs7lF6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DCF208997
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322791; cv=none; b=VyyOKSaFFC97T612DwobMokKzDFae5aEXOo78QpvKEy2ueoLFLpqZ6POb6MfNTBKtT6dz18pHaRDYIPYOPaAULxiu/aXfVBEMMFOLRV1jHEnVbtB77ymPqmWlDYSdljmn4URFXOxdRBR+R9Q96ODEG2SOsbGaABqSJD7jrywL6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322791; c=relaxed/simple;
	bh=TZd6v4WISf8ar3vaZLQT0ooYqtYeGrgBhdjf32uWuBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMBERc/z0iQ7fAZi4Md5ovX96hzTxeXJ4EIo+VQ4Os2rugJ7u+lmGOaKu8oj2JdL/iyIJZTrzG4/rUU217Jz9uOPBGMLNw1fkklYHby8IE1g9BfNGOm+HEbHM0/QdeBfnemKIfiJ8paP/uVKCzK/cwUcbrzlAOirO6VM6fFKohI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TDrs7lF6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733322790; x=1764858790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TZd6v4WISf8ar3vaZLQT0ooYqtYeGrgBhdjf32uWuBs=;
  b=TDrs7lF6j03kej3q1fIfeanAKEo2IG3MMann8n8EwaCQGBVS8ZoloFDp
   mgXUR2+dnIGhSRoIuIFgEXp81EQVJDMBoHduJ1uap+YDpTUw6whVZbxmj
   8AtjuM1vuOdmDXpFbi0e2vKsrirtujXhfBLUpb1YQOUMwTONQrAj/L/dJ
   p2WDyFCPUlEQOIteLtqZdLVFtxLXjs2F93Av6HlGQbD5WUh7MivqkvGWd
   adFP6eE+MuAvIwS8mbks1WSXovMo5q8AdDoieNChNc7waJG/WS4fiqeYE
   h8mDzhVdMDG+0FPXamm/5QX88wyVkkGURGp9HEK8qJbPMDBIK6BvE/L/B
   Q==;
X-CSE-ConnectionGUID: NVCVoDpuTHSnH6JxzI+Lcg==
X-CSE-MsgGUID: CbRPN1KuTXCkAIVZTPEAgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="44621846"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="44621846"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 06:33:10 -0800
X-CSE-ConnectionGUID: XaXOjI38R6i31IUn3ziSgQ==
X-CSE-MsgGUID: GcRW3XuTRm6PeWKXoMuStw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="93456584"
Received: from pkwapuli-mobl1.ger.corp.intel.com (HELO vbox-pkwap.ger.corp.intel.com) ([10.245.87.141])
  by fmviesa006.fm.intel.com with ESMTP; 04 Dec 2024 06:33:08 -0800
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Subject: [PATCH iwl-next v11 5/8] ixgbe: Add support for EEPROM dump in E610 device
Date: Wed,  4 Dec 2024 15:31:09 +0100
Message-ID: <20241204143112.29411-6-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241204143112.29411-1-piotr.kwapulinski@intel.com>
References: <20241204143112.29411-1-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add low level support for EEPROM dump for the specified network device.

Co-developed-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 93 +++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  5 +
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |  8 ++
 3 files changed, 106 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 0542b4b..503a047 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -2070,6 +2070,38 @@ int ixgbe_enter_lplu_e610(struct ixgbe_hw *hw)
 	return ixgbe_aci_set_phy_cfg(hw, &phy_cfg);
 }
 
+/**
+ * ixgbe_init_eeprom_params_E610 - Initialize EEPROM params
+ * @hw: pointer to hardware structure
+ *
+ * Initialize the EEPROM parameters ixgbe_eeprom_info within the ixgbe_hw
+ * struct in order to set up EEPROM access.
+ *
+ * Return: the operation exit code
+ */
+int ixgbe_init_eeprom_params_e610(struct ixgbe_hw *hw)
+{
+	struct ixgbe_eeprom_info *eeprom = &hw->eeprom;
+	u32 gens_stat;
+	u8 sr_size;
+
+	if (eeprom->type != ixgbe_eeprom_uninitialized)
+		return 0;
+
+	eeprom->type = ixgbe_flash;
+
+	gens_stat = IXGBE_READ_REG(hw, GLNVM_GENS);
+	sr_size = FIELD_GET(GLNVM_GENS_SR_SIZE_M, gens_stat);
+
+	/* Switching to words (sr_size contains power of 2). */
+	eeprom->word_size = BIT(sr_size) * IXGBE_SR_WORDS_IN_1KB;
+
+	hw_dbg(hw, "Eeprom params: type = %d, size = %d\n", eeprom->type,
+	       eeprom->word_size);
+
+	return 0;
+}
+
 /**
  * ixgbe_aci_get_netlist_node - get a node handle
  * @hw: pointer to the hw struct
@@ -2316,6 +2348,34 @@ int ixgbe_read_flat_nvm(struct ixgbe_hw  *hw, u32 offset, u32 *length,
 	return err;
 }
 
+/**
+ * ixgbe_read_sr_buf_aci - Read Shadow RAM buffer via ACI
+ * @hw: pointer to the HW structure
+ * @offset: offset of the Shadow RAM words to read (0x000000 - 0x001FFF)
+ * @words: (in) number of words to read; (out) number of words actually read
+ * @data: words read from the Shadow RAM
+ *
+ * Read 16 bit words (data buf) from the Shadow RAM. Acquire/release the NVM
+ * ownership.
+ *
+ * Return: the operation exit code
+ */
+int ixgbe_read_sr_buf_aci(struct ixgbe_hw *hw, u16 offset, u16 *words,
+			  u16 *data)
+{
+	u32 bytes = *words * 2, i;
+	int err;
+
+	err = ixgbe_read_flat_nvm(hw, offset * 2, &bytes, (u8 *)data, true);
+
+	*words = bytes / 2;
+
+	for (i = 0; i < *words; i++)
+		data[i] = le16_to_cpu(((__le16 *)data)[i]);
+
+	return err;
+}
+
 /**
  * ixgbe_read_ee_aci_e610 - Read EEPROM word using the admin command.
  * @hw: pointer to hardware structure
@@ -2349,6 +2409,39 @@ int ixgbe_read_ee_aci_e610(struct ixgbe_hw *hw, u16 offset, u16 *data)
 	return err;
 }
 
+/**
+ * ixgbe_read_ee_aci_buffer_e610 - Read EEPROM words via ACI
+ * @hw: pointer to hardware structure
+ * @offset: offset of words in the EEPROM to read
+ * @words: number of words to read
+ * @data: words to read from the EEPROM
+ *
+ * Read 16 bit words from the EEPROM via the ACI. Initialize the EEPROM params
+ * prior to the read. Acquire/release the NVM ownership.
+ *
+ * Return: the operation exit code
+ */
+int ixgbe_read_ee_aci_buffer_e610(struct ixgbe_hw *hw, u16 offset,
+				  u16 words, u16 *data)
+{
+	int err;
+
+	if (hw->eeprom.type == ixgbe_eeprom_uninitialized) {
+		err = hw->eeprom.ops.init_params(hw);
+		if (err)
+			return err;
+	}
+
+	err = ixgbe_acquire_nvm(hw, IXGBE_RES_READ);
+	if (err)
+		return err;
+
+	err = ixgbe_read_sr_buf_aci(hw, offset, &words, data);
+	ixgbe_release_nvm(hw);
+
+	return err;
+}
+
 /**
  * ixgbe_validate_eeprom_checksum_e610 - Validate EEPROM checksum
  * @hw: pointer to hardware structure
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
index 412ddd1..9cfcfee 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
@@ -56,6 +56,7 @@ int ixgbe_identify_module_e610(struct ixgbe_hw *hw);
 int ixgbe_setup_phy_link_e610(struct ixgbe_hw *hw);
 int ixgbe_set_phy_power_e610(struct ixgbe_hw *hw, bool on);
 int ixgbe_enter_lplu_e610(struct ixgbe_hw *hw);
+int ixgbe_init_eeprom_params_e610(struct ixgbe_hw *hw);
 int ixgbe_aci_get_netlist_node(struct ixgbe_hw *hw,
 			       struct ixgbe_aci_cmd_get_link_topo *cmd,
 			       u8 *node_part_number, u16 *node_handle);
@@ -69,7 +70,11 @@ int ixgbe_nvm_validate_checksum(struct ixgbe_hw *hw);
 int ixgbe_read_sr_word_aci(struct ixgbe_hw  *hw, u16 offset, u16 *data);
 int ixgbe_read_flat_nvm(struct ixgbe_hw  *hw, u32 offset, u32 *length,
 			u8 *data, bool read_shadow_ram);
+int ixgbe_read_sr_buf_aci(struct ixgbe_hw *hw, u16 offset, u16 *words,
+			  u16 *data);
 int ixgbe_read_ee_aci_e610(struct ixgbe_hw *hw, u16 offset, u16 *data);
+int ixgbe_read_ee_aci_buffer_e610(struct ixgbe_hw *hw, u16 offset,
+				  u16 words, u16 *data);
 int ixgbe_validate_eeprom_checksum_e610(struct ixgbe_hw *hw, u16 *checksum_val);
 
 #endif /* _IXGBE_E610_H_ */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index ecc3fc8..9dba8b5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -12,11 +12,19 @@
 /* Checksum and Shadow RAM pointers */
 #define E610_SR_SW_CHECKSUM_WORD		0x3F
 
+/* Shadow RAM related */
+#define IXGBE_SR_WORDS_IN_1KB	512
+
 /* Firmware Status Register (GL_FWSTS) */
 #define GL_FWSTS		0x00083048 /* Reset Source: POR */
 #define GL_FWSTS_EP_PF0		BIT(24)
 #define GL_FWSTS_EP_PF1		BIT(25)
 
+/* Global NVM General Status Register */
+#define GLNVM_GENS		0x000B6100 /* Reset Source: POR */
+#define GLNVM_GENS_SR_SIZE_S	5
+#define GLNVM_GENS_SR_SIZE_M	GENMASK(7, 5)
+
 /* Flash Access Register */
 #define IXGBE_GLNVM_FLA			0x000B6108 /* Reset Source: POR */
 #define IXGBE_GLNVM_FLA_LOCKED_S	6
-- 
2.43.0


