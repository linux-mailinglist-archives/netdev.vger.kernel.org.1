Return-Path: <netdev+bounces-153797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B714C9F9B08
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 21:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E1518909B4
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 20:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34660222D44;
	Fri, 20 Dec 2024 20:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eO5LlN5M"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499F922579F
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734725768; cv=none; b=eXq6JXrdHEvK8dScNmDrIexiBp+5jl+vzzoNeHBKEEY5AmqFWv3PN7yH7trK2o03KMlnuDJKp/1aFqV6XM221ICWWsMU7tCxPgcGtt5UJVjm1/xZ9rLvej4VznZBqkhjzWNoXNxew5TbVpVfvWzdzHhIonJkjDnuN1HiTgWnI/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734725768; c=relaxed/simple;
	bh=XAaB7yAoN8lpI/4/GCTr+yIYN6CBfHXkfhgws6ejkJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clVc0ft4hcxPevqjCY/Pney8OGEk4kESl2pIMg55aibASljGxQvLEk+37AaaHJryYTaqI3QeNRjZdAsAK1tfOcWITF92ZlmAeSbi+iojDB6bE53QUNfU6ePeNjXIGqTMtG78gZ3q0mj2Ow78id074KU114ZiKwfDGEfKOgJagZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eO5LlN5M; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734725766; x=1766261766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XAaB7yAoN8lpI/4/GCTr+yIYN6CBfHXkfhgws6ejkJo=;
  b=eO5LlN5Mk2rz191Earw+8FIwjFw7tNnH4Bt/pmPvmCfkOK+FkDWxjPP8
   HlcY8F76gPtL1+HeoQ9sJ0yYv+QQ7c2hKzIbGt5U1fPUNur7ISBPGcNWt
   St0aQSakV4WxyIXhhS16ILsZQxBdqmF9VzHBsWFvtUFH97Wd2R/0xllRt
   txSzCOLsteYHfnGuW4z0nw918nRSHAswbMRP12TpgK76rpYKEkFsAA4oN
   PEtesCKmKaucLdKl91/pVkXYVZdzXb4ptxkep4JNY/VzoJi1ex0d9Fr1g
   fO98s8oud0/M60ytTJpL5EN15z8BcQALN8rHy7EuTB+xh3+om2s0xg5Pm
   g==;
X-CSE-ConnectionGUID: bfd+baGXRNWbDAZz8c9YXw==
X-CSE-MsgGUID: y+NM1xSHROm8tSq5GeodqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="46292402"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="46292402"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 12:16:03 -0800
X-CSE-ConnectionGUID: nTMVEqmvRxOeilGJlfSoZA==
X-CSE-MsgGUID: sa60WyxcQKGXfwfGAMg4sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102717104"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 20 Dec 2024 12:16:02 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	Stefan Wegrzyn <stefan.wegrzyn@intel.com>,
	Bharath R <bharath.r@intel.com>
Subject: [PATCH net-next 05/10] ixgbe: Add support for EEPROM dump in E610 device
Date: Fri, 20 Dec 2024 12:15:10 -0800
Message-ID: <20241220201521.3363985-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220201521.3363985-1-anthony.l.nguyen@intel.com>
References: <20241220201521.3363985-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Add low level support for EEPROM dump for the specified network device.

Co-developed-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Bharath R <bharath.r@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 95 +++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  5 +
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |  7 ++
 3 files changed, 107 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index a35e28d99269..6bf3562b3ce2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -2073,6 +2073,38 @@ int ixgbe_enter_lplu_e610(struct ixgbe_hw *hw)
 	return ixgbe_aci_set_phy_cfg(hw, &phy_cfg);
 }
 
+/**
+ * ixgbe_init_eeprom_params_e610 - Initialize EEPROM params
+ * @hw: pointer to hardware structure
+ *
+ * Initialize the EEPROM parameters ixgbe_eeprom_info within the ixgbe_hw
+ * struct in order to set up EEPROM access.
+ *
+ * Return: the operation exit code.
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
@@ -2319,6 +2351,36 @@ int ixgbe_read_flat_nvm(struct ixgbe_hw  *hw, u32 offset, u32 *length,
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
+ * Return: the operation exit code.
+ */
+int ixgbe_read_sr_buf_aci(struct ixgbe_hw *hw, u16 offset, u16 *words,
+			  u16 *data)
+{
+	u32 bytes = *words * 2;
+	int err;
+
+	err = ixgbe_read_flat_nvm(hw, offset * 2, &bytes, (u8 *)data, true);
+	if (err)
+		return err;
+
+	*words = bytes / 2;
+
+	for (int i = 0; i < *words; i++)
+		data[i] = le16_to_cpu(((__le16 *)data)[i]);
+
+	return 0;
+}
+
 /**
  * ixgbe_read_ee_aci_e610 - Read EEPROM word using the admin command.
  * @hw: pointer to hardware structure
@@ -2352,6 +2414,39 @@ int ixgbe_read_ee_aci_e610(struct ixgbe_hw *hw, u16 offset, u16 *data)
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
+ * Return: the operation exit code.
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
index 412ddd123cd1..9cfcfeec6e0b 100644
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
index ecc3fc8c8d52..8d06ade3c7cd 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -12,11 +12,18 @@
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
+#define GLNVM_GENS_SR_SIZE_M	GENMASK(7, 5)
+
 /* Flash Access Register */
 #define IXGBE_GLNVM_FLA			0x000B6108 /* Reset Source: POR */
 #define IXGBE_GLNVM_FLA_LOCKED_S	6
-- 
2.47.1


