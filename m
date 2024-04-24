Return-Path: <netdev+bounces-90950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99178B0BFE
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 16:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDEFB1C21F75
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 14:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B691C15E1EA;
	Wed, 24 Apr 2024 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i7/Z5fS2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD53A15E80F
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967588; cv=none; b=SYzvZI9hCbDeFquzFhISY67JEZFuA6ACI2I8wzh1yZnNawBDhnSrI8cXlu0dR/efP/lAwYonPPWka5IEqmfXShy/3ZZW+Ed8Jz7ejrxXEQI0dKPCxyiDomiWMwugl7wwfXF8GAi8fCciy1qmjo9WXY6cZoacS3Yixd7JPrMZCQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967588; c=relaxed/simple;
	bh=L7W22wXr/ax6YH7AXgNvt331sgGh6+hRqwjdKUj1gLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FV8e/dFQQ6fZPhlhUTHqfuK67wvfXaWYanaSKASKvareJJEeacdyH6Uwo0PTWdhLiEpwjxY3bpaC6kBjkKLqRPviG4yiMboyFoZ9bXKxh51jxMjZ61HpzeemyG03OJg5CdzmSWbSGKRD76O1SgVChrZzyR4jRbcVVAroIV9W2dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i7/Z5fS2; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713967587; x=1745503587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L7W22wXr/ax6YH7AXgNvt331sgGh6+hRqwjdKUj1gLo=;
  b=i7/Z5fS24n+LeA7WZp9k+o2IhIrmGVdw96E4hRnqlHqPO9qUurxHX7wG
   zwpUUOpHvlrsO4Xz+z6ujr5zTjHkbl/LfHYgeK8Q6S7VZvDi5yg7Z0Afj
   D2KitnV1vLX2ZOP2oZ7bZz4yxypNzRA9wDJtL5V66sG71npcmKRv+JIA/
   meXGgufnDWOJHOTAccxc7yh+qEmvv2x+khfmooAahFc7w+3p5p70GhrTX
   5kFGEmncy8Ak8DaZ5k2RQK/AwwDvj3M7vwcs0IF0NJmuKIL8qKvnwSbre
   ifqsOGlIuus1rMsUmXRlHu5vyGjMhIEeqXKkip1vPcM/xOsSYdoRRgQ80
   Q==;
X-CSE-ConnectionGUID: tG1EDjVYSpO6zSvd0U+qKw==
X-CSE-MsgGUID: QISwr+c0Qiqi425c60u6VA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="10138183"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="10138183"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 07:06:24 -0700
X-CSE-ConnectionGUID: f1uly/y0RZaak/G8fs5ewQ==
X-CSE-MsgGUID: krlgHBK0Q5+BQ05ec9qpEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="55922956"
Received: from amlin-018-251.igk.intel.com (HELO localhost.localdomain) ([10.102.18.251])
  by fmviesa001.fm.intel.com with ESMTP; 24 Apr 2024 07:06:20 -0700
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jiri@resnulli.us,
	horms@kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Stefan Wegrzyn <stefan.wegrzyn@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v5 4/5] ixgbe: Add support for NVM handling in E610 device
Date: Wed, 24 Apr 2024 16:22:50 +0200
Message-Id: <20240424142251.3887-5-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240424142251.3887-1-piotr.kwapulinski@intel.com>
References: <20240424142251.3887-1-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add low level support for accessing NVM in E610 device. NVM operations are
handled via the Admin Command Interface. Add the following NVM specific
operations:
- acquire, release, read
- validate checksum
- read shadow ram

Co-developed-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Co-developed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 290 ++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  12 +
 2 files changed, 302 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 369f05d..330c7e7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -2087,3 +2087,293 @@ int ixgbe_aci_get_netlist_node(struct ixgbe_hw *hw,
 
 	return 0;
 }
+
+/**
+ * ixgbe_acquire_nvm - Generic request for acquiring the NVM ownership
+ * @hw: pointer to the HW structure
+ * @access: NVM access type (read or write)
+ *
+ * Request NVM ownership.
+ *
+ * Return: the exit code of the operation.
+ */
+int ixgbe_acquire_nvm(struct ixgbe_hw *hw,
+		      enum ixgbe_aci_res_access_type access)
+{
+	u32 fla;
+
+	/* Skip if we are in blank NVM programming mode */
+	fla = IXGBE_READ_REG(hw, IXGBE_GLNVM_FLA);
+	if ((fla & IXGBE_GLNVM_FLA_LOCKED_M) == 0)
+		return 0;
+
+	return ixgbe_acquire_res(hw, IXGBE_NVM_RES_ID, access,
+				 IXGBE_NVM_TIMEOUT);
+}
+
+/**
+ * ixgbe_release_nvm - Generic request for releasing the NVM ownership
+ * @hw: pointer to the HW structure
+ *
+ * Release NVM ownership.
+ */
+void ixgbe_release_nvm(struct ixgbe_hw *hw)
+{
+	u32 fla;
+
+	/* Skip if we are in blank NVM programming mode */
+	fla = IXGBE_READ_REG(hw, IXGBE_GLNVM_FLA);
+	if ((fla & IXGBE_GLNVM_FLA_LOCKED_M) == 0)
+		return;
+
+	ixgbe_release_res(hw, IXGBE_NVM_RES_ID);
+}
+
+/**
+ * ixgbe_aci_read_nvm - read NVM
+ * @hw: pointer to the HW struct
+ * @module_typeid: module pointer location in words from the NVM beginning
+ * @offset: byte offset from the module beginning
+ * @length: length of the section to be read (in bytes from the offset)
+ * @data: command buffer (size [bytes] = length)
+ * @last_command: tells if this is the last command in a series
+ * @read_shadow_ram: tell if this is a shadow RAM read
+ *
+ * Read the NVM using ACI command (0x0701).
+ *
+ * Return: the exit code of the operation.
+ */
+int ixgbe_aci_read_nvm(struct ixgbe_hw *hw, u16 module_typeid, u32 offset,
+		       u16 length, void *data, bool last_command,
+		       bool read_shadow_ram)
+{
+	struct ixgbe_aci_cmd_nvm *cmd;
+	struct ixgbe_aci_desc desc;
+
+	if (offset > IXGBE_ACI_NVM_MAX_OFFSET)
+		return -EINVAL;
+
+	cmd = &desc.params.nvm;
+
+	ixgbe_fill_dflt_direct_cmd_desc(&desc, ixgbe_aci_opc_nvm_read);
+
+	if (!read_shadow_ram && module_typeid == IXGBE_ACI_NVM_START_POINT)
+		cmd->cmd_flags |= IXGBE_ACI_NVM_FLASH_ONLY;
+
+	/* If this is the last command in a series, set the proper flag. */
+	if (last_command)
+		cmd->cmd_flags |= IXGBE_ACI_NVM_LAST_CMD;
+	cmd->module_typeid = module_typeid;
+	cmd->offset_low = offset & 0xFFFF;
+	cmd->offset_high = (offset >> 16) & 0xFF;
+	cmd->length = length;
+
+	return ixgbe_aci_send_cmd(hw, &desc, data, length);
+}
+
+/**
+ * ixgbe_nvm_validate_checksum - validate checksum
+ * @hw: pointer to the HW struct
+ *
+ * Verify NVM PFA checksum validity using ACI command (0x0706).
+ * If the checksum verification failed, IXGBE_ERR_NVM_CHECKSUM is returned.
+ * The function acquires and then releases the NVM ownership.
+ *
+ * Return: the exit code of the operation.
+ */
+int ixgbe_nvm_validate_checksum(struct ixgbe_hw *hw)
+{
+	struct ixgbe_aci_cmd_nvm_checksum *cmd;
+	struct ixgbe_aci_desc desc;
+	int err;
+
+	err = ixgbe_acquire_nvm(hw, IXGBE_RES_READ);
+	if (err)
+		return err;
+
+	cmd = &desc.params.nvm_checksum;
+
+	ixgbe_fill_dflt_direct_cmd_desc(&desc, ixgbe_aci_opc_nvm_checksum);
+	cmd->flags = IXGBE_ACI_NVM_CHECKSUM_VERIFY;
+
+	err = ixgbe_aci_send_cmd(hw, &desc, NULL, 0);
+
+	ixgbe_release_nvm(hw);
+
+	if (!err && cmd->checksum != IXGBE_ACI_NVM_CHECKSUM_CORRECT) {
+		struct ixgbe_adapter *adapter = container_of(hw, struct ixgbe_adapter,
+							     hw);
+
+		err = -EIO;
+		netdev_err(adapter->netdev, "Invalid Shadow Ram checksum");
+	}
+
+	return err;
+}
+
+/**
+ * ixgbe_read_sr_word_aci - Reads Shadow RAM via ACI
+ * @hw: pointer to the HW structure
+ * @offset: offset of the Shadow RAM word to read (0x000000 - 0x001FFF)
+ * @data: word read from the Shadow RAM
+ *
+ * Reads one 16 bit word from the Shadow RAM using ixgbe_read_flat_nvm.
+ *
+ * Return: the exit code of the operation.
+ */
+int ixgbe_read_sr_word_aci(struct ixgbe_hw  *hw, u16 offset, u16 *data)
+{
+	u32 bytes = sizeof(u16);
+	u16 data_local;
+	int err;
+
+	err = ixgbe_read_flat_nvm(hw, offset * sizeof(u16), &bytes,
+				  (u8 *)&data_local, true);
+	if (err)
+		return err;
+
+	*data = data_local;
+	return 0;
+}
+
+/**
+ * ixgbe_read_flat_nvm - Read portion of NVM by flat offset
+ * @hw: pointer to the HW struct
+ * @offset: offset from beginning of NVM
+ * @length: (in) number of bytes to read; (out) number of bytes actually read
+ * @data: buffer to return data in (sized to fit the specified length)
+ * @read_shadow_ram: if true, read from shadow RAM instead of NVM
+ *
+ * Reads a portion of the NVM, as a flat memory space. This function correctly
+ * breaks read requests across Shadow RAM sectors, prevents Shadow RAM size
+ * from being exceeded in case of Shadow RAM read requests and ensures that no
+ * single read request exceeds the maximum 4KB read for a single admin command.
+ *
+ * Returns an error code on failure. Note that the data pointer may be
+ * partially updated if some reads succeed before a failure.
+ *
+ * Return: the exit code of the operation.
+ */
+int ixgbe_read_flat_nvm(struct ixgbe_hw  *hw, u32 offset, u32 *length,
+			u8 *data, bool read_shadow_ram)
+{
+	u32 inlen = *length;
+	u32 bytes_read = 0;
+	bool last_cmd;
+	int err;
+
+	/* Verify the length of the read if this is for the Shadow RAM */
+	if (read_shadow_ram && ((offset + inlen) >
+				(hw->eeprom.word_size * 2u)))
+		return -EINVAL;
+
+	do {
+		u32 read_size, sector_offset;
+
+		/* ixgbe_aci_read_nvm cannot read more than 4KB at a time.
+		 * Additionally, a read from the Shadow RAM may not cross over
+		 * a sector boundary. Conveniently, the sector size is also 4KB.
+		 */
+		sector_offset = offset % IXGBE_ACI_MAX_BUFFER_SIZE;
+		read_size = min_t(u32,
+				  IXGBE_ACI_MAX_BUFFER_SIZE - sector_offset,
+				  inlen - bytes_read);
+
+		last_cmd = !(bytes_read + read_size < inlen);
+
+		/* ixgbe_aci_read_nvm takes the length as a u16. Our read_size
+		 * is calculated using a u32, but the IXGBE_ACI_MAX_BUFFER_SIZE
+		 * maximum size guarantees that it will fit within the 2 bytes.
+		 */
+		err = ixgbe_aci_read_nvm(hw, IXGBE_ACI_NVM_START_POINT,
+					 offset, (u16)read_size,
+					 data + bytes_read, last_cmd,
+					 read_shadow_ram);
+		if (err)
+			break;
+
+		bytes_read += read_size;
+		offset += read_size;
+	} while (!last_cmd);
+
+	*length = bytes_read;
+	return err;
+}
+
+/**
+ * ixgbe_read_ee_aci_e610 - Read EEPROM word using the admin command.
+ * @hw: pointer to hardware structure
+ * @offset: offset of  word in the EEPROM to read
+ * @data: word read from the EEPROM
+ *
+ * Reads a 16 bit word from the EEPROM using the ACI.
+ * If the EEPROM params are not initialized, the function
+ * initialize them before proceeding with reading.
+ * The function acquires and then releases the NVM ownership.
+ *
+ * Return: the exit code of the operation.
+ */
+int ixgbe_read_ee_aci_e610(struct ixgbe_hw *hw, u16 offset, u16 *data)
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
+	err = ixgbe_read_sr_word_aci(hw, offset, data);
+	ixgbe_release_nvm(hw);
+
+	return err;
+}
+
+/**
+ * ixgbe_validate_eeprom_checksum_e610 - Validate EEPROM checksum
+ * @hw: pointer to hardware structure
+ * @checksum_val: calculated checksum
+ *
+ * Performs checksum calculation and validates the EEPROM checksum. If the
+ * caller does not need checksum_val, the value can be NULL.
+ * If the EEPROM params are not initialized, the function
+ * initialize them before proceeding.
+ * The function acquires and then releases the NVM ownership.
+ *
+ * Return: the exit code of the operation.
+ */
+int ixgbe_validate_eeprom_checksum_e610(struct ixgbe_hw *hw, u16 *checksum_val)
+{
+	int err;
+
+	if (hw->eeprom.type == ixgbe_eeprom_uninitialized) {
+		err = hw->eeprom.ops.init_params(hw);
+		if (err)
+			return err;
+	}
+
+	err = ixgbe_nvm_validate_checksum(hw);
+	if (err)
+		return err;
+
+	if (checksum_val) {
+		u16 tmp_checksum;
+
+		err = ixgbe_acquire_nvm(hw, IXGBE_RES_READ);
+		if (err)
+			return err;
+
+		err = ixgbe_read_sr_word_aci(hw, E610_SR_SW_CHECKSUM_WORD,
+					     &tmp_checksum);
+		ixgbe_release_nvm(hw);
+
+		if (!err)
+			*checksum_val = tmp_checksum;
+	}
+
+	return err;
+}
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
index 9be412a..df54a80 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
@@ -58,5 +58,17 @@ int ixgbe_enter_lplu_e610(struct ixgbe_hw *hw);
 int ixgbe_aci_get_netlist_node(struct ixgbe_hw *hw,
 			       struct ixgbe_aci_cmd_get_link_topo *cmd,
 			       u8 *node_part_number, u16 *node_handle);
+int ixgbe_acquire_nvm(struct ixgbe_hw *hw,
+		      enum ixgbe_aci_res_access_type access);
+void ixgbe_release_nvm(struct ixgbe_hw *hw);
+int ixgbe_aci_read_nvm(struct ixgbe_hw *hw, u16 module_typeid, u32 offset,
+		       u16 length, void *data, bool last_command,
+		       bool read_shadow_ram);
+int ixgbe_nvm_validate_checksum(struct ixgbe_hw *hw);
+int ixgbe_read_sr_word_aci(struct ixgbe_hw  *hw, u16 offset, u16 *data);
+int ixgbe_read_flat_nvm(struct ixgbe_hw  *hw, u32 offset, u32 *length,
+			u8 *data, bool read_shadow_ram);
+int ixgbe_read_ee_aci_e610(struct ixgbe_hw *hw, u16 offset, u16 *data);
+int ixgbe_validate_eeprom_checksum_e610(struct ixgbe_hw *hw, u16 *checksum_val);
 
 #endif /* _IXGBE_E610_H_ */
-- 
2.31.1


