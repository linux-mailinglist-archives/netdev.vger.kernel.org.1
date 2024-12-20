Return-Path: <netdev+bounces-153793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9624A9F9B02
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 21:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1612163F91
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 20:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B6C22256F;
	Fri, 20 Dec 2024 20:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hTlh3zLk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D967C222571
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 20:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734725765; cv=none; b=BQI6vMtA8HHpgF9B5FVjShz4dgpoy/+KMLMrb2Kai1TSW1njmgU7C6rM9l1RQFY5YMQc/T2b8lG+EUNSAPxwq0C1pfwayNb+LD7Tw5qTny3FH7iQLLCQF6kiIVdYqvRsn6vYKQlAJz6zh+iSKQgmEkQt9j6RIcQPM/QWs7mxcz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734725765; c=relaxed/simple;
	bh=vyGGv2oeDkBczVrMmAPaWH5v+ZGaAlt1pKWji8sAi40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qyEbvlDSqusxq1aRfuaGOc5SEXQYoIxeYwPfUSxu2mmJLoTm6msa40qxYwhESh/B1msv2k6YCEIloLtQJcJGA/FOIP2OfSZ04nnYy3WL0hoP1xg7N5LUDR3szqofAz3yssR4YcWJwx5hPYut/INnfS6PrPVWDuxa1OHvRlxBr+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hTlh3zLk; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734725763; x=1766261763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vyGGv2oeDkBczVrMmAPaWH5v+ZGaAlt1pKWji8sAi40=;
  b=hTlh3zLkIsd5S/EpKnNSB5e4NpfdWKfwytdfhLoVfwtRsk0GzDr3qg/V
   geqPleM+z8FVDkqSbZ3WuKc5IV/gXmiCFV5XiZwJF4ijLCwcusgQCS3Qi
   r/IdkTvwXCNF07tZE35F02JDJvzG2tPCa79FACupGlrA5zMYx/OWMPYdj
   doxFkahSiSQhbBQiuBrXzrSKgjnWjvnIeSWDQgYQnVN0My/SZL1Ig+YU1
   xZfgJ8aDM8ZjdOdTFw/TFNu7dw0LXJA4E8dw+5Bqqrg5a19ENnc1kfwej
   L7T7HdhVuqmIqJtO7/v548wzT8deGPuBQT9WVbDKmJ6N38WHHsq9X5Ik4
   g==;
X-CSE-ConnectionGUID: sz7NGmQJQvGrOYNPrjiMMg==
X-CSE-MsgGUID: EkACWjGnRvq1HHOqsZMNAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="46292383"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="46292383"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 12:16:01 -0800
X-CSE-ConnectionGUID: YiIPawzHQiCkG12muqp7cg==
X-CSE-MsgGUID: veH4rs1uRp6Q+f2QHhvAWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102717090"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 20 Dec 2024 12:16:01 -0800
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
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Jan Sokolowski <jan.sokolowski@intel.com>,
	Bharath R <bharath.r@intel.com>
Subject: [PATCH net-next 02/10] ixgbe: Add support for E610 device capabilities detection
Date: Fri, 20 Dec 2024 12:15:07 -0800
Message-ID: <20241220201521.3363985-3-anthony.l.nguyen@intel.com>
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

Add low level support for E610 device capabilities detection. The
capabilities are discovered via the Admin Command Interface. Discover the
following capabilities:
- function caps: vmdq, dcb, rss, rx/tx qs, msix, nvm, orom, reset
- device caps: vsi, fdir, 1588
- phy caps

Co-developed-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Co-developed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Jan Sokolowski <jan.sokolowski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Bharath R <bharath.r@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 529 ++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  12 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   7 +
 3 files changed, 548 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 6a26f6b4d3d5..9e15b9c11120 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -495,3 +495,532 @@ void ixgbe_release_res(struct ixgbe_hw *hw, enum ixgbe_aci_res_ids res)
 		total_delay++;
 	}
 }
+
+/**
+ * ixgbe_parse_e610_caps - Parse common device/function capabilities
+ * @hw: pointer to the HW struct
+ * @caps: pointer to common capabilities structure
+ * @elem: the capability element to parse
+ * @prefix: message prefix for tracing capabilities
+ *
+ * Given a capability element, extract relevant details into the common
+ * capability structure.
+ *
+ * Return: true if the capability matches one of the common capability ids,
+ * false otherwise.
+ */
+static bool ixgbe_parse_e610_caps(struct ixgbe_hw *hw,
+				  struct ixgbe_hw_caps *caps,
+				  struct ixgbe_aci_cmd_list_caps_elem *elem,
+				  const char *prefix)
+{
+	u32 logical_id = le32_to_cpu(elem->logical_id);
+	u32 phys_id = le32_to_cpu(elem->phys_id);
+	u32 number = le32_to_cpu(elem->number);
+	u16 cap = le16_to_cpu(elem->cap);
+
+	switch (cap) {
+	case IXGBE_ACI_CAPS_VALID_FUNCTIONS:
+		caps->valid_functions = number;
+		break;
+	case IXGBE_ACI_CAPS_SRIOV:
+		caps->sr_iov_1_1 = (number == 1);
+		break;
+	case IXGBE_ACI_CAPS_VMDQ:
+		caps->vmdq = (number == 1);
+		break;
+	case IXGBE_ACI_CAPS_DCB:
+		caps->dcb = (number == 1);
+		caps->active_tc_bitmap = logical_id;
+		caps->maxtc = phys_id;
+		break;
+	case IXGBE_ACI_CAPS_RSS:
+		caps->rss_table_size = number;
+		caps->rss_table_entry_width = logical_id;
+		break;
+	case IXGBE_ACI_CAPS_RXQS:
+		caps->num_rxq = number;
+		caps->rxq_first_id = phys_id;
+		break;
+	case IXGBE_ACI_CAPS_TXQS:
+		caps->num_txq = number;
+		caps->txq_first_id = phys_id;
+		break;
+	case IXGBE_ACI_CAPS_MSIX:
+		caps->num_msix_vectors = number;
+		caps->msix_vector_first_id = phys_id;
+		break;
+	case IXGBE_ACI_CAPS_NVM_VER:
+		break;
+	case IXGBE_ACI_CAPS_MAX_MTU:
+		caps->max_mtu = number;
+		break;
+	case IXGBE_ACI_CAPS_PCIE_RESET_AVOIDANCE:
+		caps->pcie_reset_avoidance = (number > 0);
+		break;
+	case IXGBE_ACI_CAPS_POST_UPDATE_RESET_RESTRICT:
+		caps->reset_restrict_support = (number == 1);
+		break;
+	case IXGBE_ACI_CAPS_EXT_TOPO_DEV_IMG0:
+	case IXGBE_ACI_CAPS_EXT_TOPO_DEV_IMG1:
+	case IXGBE_ACI_CAPS_EXT_TOPO_DEV_IMG2:
+	case IXGBE_ACI_CAPS_EXT_TOPO_DEV_IMG3:
+	{
+		u8 index = cap - IXGBE_ACI_CAPS_EXT_TOPO_DEV_IMG0;
+
+		caps->ext_topo_dev_img_ver_high[index] = number;
+		caps->ext_topo_dev_img_ver_low[index] = logical_id;
+		caps->ext_topo_dev_img_part_num[index] =
+			FIELD_GET(IXGBE_EXT_TOPO_DEV_IMG_PART_NUM_M, phys_id);
+		caps->ext_topo_dev_img_load_en[index] =
+			(phys_id & IXGBE_EXT_TOPO_DEV_IMG_LOAD_EN) != 0;
+		caps->ext_topo_dev_img_prog_en[index] =
+			(phys_id & IXGBE_EXT_TOPO_DEV_IMG_PROG_EN) != 0;
+		break;
+	}
+	default:
+		/* Not one of the recognized common capabilities */
+		return false;
+	}
+
+	return true;
+}
+
+/**
+ * ixgbe_parse_valid_functions_cap - Parse IXGBE_ACI_CAPS_VALID_FUNCTIONS caps
+ * @hw: pointer to the HW struct
+ * @dev_p: pointer to device capabilities structure
+ * @cap: capability element to parse
+ *
+ * Parse IXGBE_ACI_CAPS_VALID_FUNCTIONS for device capabilities.
+ */
+static void
+ixgbe_parse_valid_functions_cap(struct ixgbe_hw *hw,
+				struct ixgbe_hw_dev_caps *dev_p,
+				struct ixgbe_aci_cmd_list_caps_elem *cap)
+{
+	dev_p->num_funcs = hweight32(le32_to_cpu(cap->number));
+}
+
+/**
+ * ixgbe_parse_vf_dev_caps - Parse IXGBE_ACI_CAPS_VF device caps
+ * @hw: pointer to the HW struct
+ * @dev_p: pointer to device capabilities structure
+ * @cap: capability element to parse
+ *
+ * Parse IXGBE_ACI_CAPS_VF for device capabilities.
+ */
+static void ixgbe_parse_vf_dev_caps(struct ixgbe_hw *hw,
+				    struct ixgbe_hw_dev_caps *dev_p,
+				    struct ixgbe_aci_cmd_list_caps_elem *cap)
+{
+	dev_p->num_vfs_exposed = le32_to_cpu(cap->number);
+}
+
+/**
+ * ixgbe_parse_vsi_dev_caps - Parse IXGBE_ACI_CAPS_VSI device caps
+ * @hw: pointer to the HW struct
+ * @dev_p: pointer to device capabilities structure
+ * @cap: capability element to parse
+ *
+ * Parse IXGBE_ACI_CAPS_VSI for device capabilities.
+ */
+static void ixgbe_parse_vsi_dev_caps(struct ixgbe_hw *hw,
+				     struct ixgbe_hw_dev_caps *dev_p,
+				     struct ixgbe_aci_cmd_list_caps_elem *cap)
+{
+	dev_p->num_vsi_allocd_to_host = le32_to_cpu(cap->number);
+}
+
+/**
+ * ixgbe_parse_fdir_dev_caps - Parse IXGBE_ACI_CAPS_FD device caps
+ * @hw: pointer to the HW struct
+ * @dev_p: pointer to device capabilities structure
+ * @cap: capability element to parse
+ *
+ * Parse IXGBE_ACI_CAPS_FD for device capabilities.
+ */
+static void ixgbe_parse_fdir_dev_caps(struct ixgbe_hw *hw,
+				      struct ixgbe_hw_dev_caps *dev_p,
+				      struct ixgbe_aci_cmd_list_caps_elem *cap)
+{
+	dev_p->num_flow_director_fltr = le32_to_cpu(cap->number);
+}
+
+/**
+ * ixgbe_parse_dev_caps - Parse device capabilities
+ * @hw: pointer to the HW struct
+ * @dev_p: pointer to device capabilities structure
+ * @buf: buffer containing the device capability records
+ * @cap_count: the number of capabilities
+ *
+ * Helper device to parse device (0x000B) capabilities list. For
+ * capabilities shared between device and function, this relies on
+ * ixgbe_parse_e610_caps.
+ *
+ * Loop through the list of provided capabilities and extract the relevant
+ * data into the device capabilities structured.
+ */
+static void ixgbe_parse_dev_caps(struct ixgbe_hw *hw,
+				 struct ixgbe_hw_dev_caps *dev_p,
+				 void *buf, u32 cap_count)
+{
+	struct ixgbe_aci_cmd_list_caps_elem *cap_resp;
+	u32 i;
+
+	cap_resp = (struct ixgbe_aci_cmd_list_caps_elem *)buf;
+
+	memset(dev_p, 0, sizeof(*dev_p));
+
+	for (i = 0; i < cap_count; i++) {
+		u16 cap = le16_to_cpu(cap_resp[i].cap);
+
+		ixgbe_parse_e610_caps(hw, &dev_p->common_cap, &cap_resp[i],
+				      "dev caps");
+
+		switch (cap) {
+		case IXGBE_ACI_CAPS_VALID_FUNCTIONS:
+			ixgbe_parse_valid_functions_cap(hw, dev_p,
+							&cap_resp[i]);
+			break;
+		case IXGBE_ACI_CAPS_VF:
+			ixgbe_parse_vf_dev_caps(hw, dev_p, &cap_resp[i]);
+			break;
+		case IXGBE_ACI_CAPS_VSI:
+			ixgbe_parse_vsi_dev_caps(hw, dev_p, &cap_resp[i]);
+			break;
+		case  IXGBE_ACI_CAPS_FD:
+			ixgbe_parse_fdir_dev_caps(hw, dev_p, &cap_resp[i]);
+			break;
+		default:
+			/* Don't list common capabilities as unknown */
+			break;
+		}
+	}
+}
+
+/**
+ * ixgbe_parse_vf_func_caps - Parse IXGBE_ACI_CAPS_VF function caps
+ * @hw: pointer to the HW struct
+ * @func_p: pointer to function capabilities structure
+ * @cap: pointer to the capability element to parse
+ *
+ * Extract function capabilities for IXGBE_ACI_CAPS_VF.
+ */
+static void ixgbe_parse_vf_func_caps(struct ixgbe_hw *hw,
+				     struct ixgbe_hw_func_caps *func_p,
+				     struct ixgbe_aci_cmd_list_caps_elem *cap)
+{
+	func_p->num_allocd_vfs = le32_to_cpu(cap->number);
+	func_p->vf_base_id = le32_to_cpu(cap->logical_id);
+}
+
+/**
+ * ixgbe_get_num_per_func - determine number of resources per PF
+ * @hw: pointer to the HW structure
+ * @max: value to be evenly split between each PF
+ *
+ * Determine the number of valid functions by going through the bitmap returned
+ * from parsing capabilities and use this to calculate the number of resources
+ * per PF based on the max value passed in.
+ *
+ * Return: the number of resources per PF or 0, if no PH are available.
+ */
+static u32 ixgbe_get_num_per_func(struct ixgbe_hw *hw, u32 max)
+{
+#define IXGBE_CAPS_VALID_FUNCS_M	GENMASK(7, 0)
+	u8 funcs = hweight8(hw->dev_caps.common_cap.valid_functions &
+			    IXGBE_CAPS_VALID_FUNCS_M);
+
+	return funcs ? (max / funcs) : 0;
+}
+
+/**
+ * ixgbe_parse_vsi_func_caps - Parse IXGBE_ACI_CAPS_VSI function caps
+ * @hw: pointer to the HW struct
+ * @func_p: pointer to function capabilities structure
+ * @cap: pointer to the capability element to parse
+ *
+ * Extract function capabilities for IXGBE_ACI_CAPS_VSI.
+ */
+static void ixgbe_parse_vsi_func_caps(struct ixgbe_hw *hw,
+				      struct ixgbe_hw_func_caps *func_p,
+				      struct ixgbe_aci_cmd_list_caps_elem *cap)
+{
+	func_p->guar_num_vsi = ixgbe_get_num_per_func(hw, IXGBE_MAX_VSI);
+}
+
+/**
+ * ixgbe_parse_func_caps - Parse function capabilities
+ * @hw: pointer to the HW struct
+ * @func_p: pointer to function capabilities structure
+ * @buf: buffer containing the function capability records
+ * @cap_count: the number of capabilities
+ *
+ * Helper function to parse function (0x000A) capabilities list. For
+ * capabilities shared between device and function, this relies on
+ * ixgbe_parse_e610_caps.
+ *
+ * Loop through the list of provided capabilities and extract the relevant
+ * data into the function capabilities structured.
+ */
+static void ixgbe_parse_func_caps(struct ixgbe_hw *hw,
+				  struct ixgbe_hw_func_caps *func_p,
+				  void *buf, u32 cap_count)
+{
+	struct ixgbe_aci_cmd_list_caps_elem *cap_resp;
+	u32 i;
+
+	cap_resp = (struct ixgbe_aci_cmd_list_caps_elem *)buf;
+
+	memset(func_p, 0, sizeof(*func_p));
+
+	for (i = 0; i < cap_count; i++) {
+		u16 cap = le16_to_cpu(cap_resp[i].cap);
+
+		ixgbe_parse_e610_caps(hw, &func_p->common_cap,
+				      &cap_resp[i], "func caps");
+
+		switch (cap) {
+		case IXGBE_ACI_CAPS_VF:
+			ixgbe_parse_vf_func_caps(hw, func_p, &cap_resp[i]);
+			break;
+		case IXGBE_ACI_CAPS_VSI:
+			ixgbe_parse_vsi_func_caps(hw, func_p, &cap_resp[i]);
+			break;
+		default:
+			/* Don't list common capabilities as unknown */
+			break;
+		}
+	}
+}
+
+/**
+ * ixgbe_aci_list_caps - query function/device capabilities
+ * @hw: pointer to the HW struct
+ * @buf: a buffer to hold the capabilities
+ * @buf_size: size of the buffer
+ * @cap_count: if not NULL, set to the number of capabilities reported
+ * @opc: capabilities type to discover, device or function
+ *
+ * Get the function (0x000A) or device (0x000B) capabilities description from
+ * firmware and store it in the buffer.
+ *
+ * If the cap_count pointer is not NULL, then it is set to the number of
+ * capabilities firmware will report. Note that if the buffer size is too
+ * small, it is possible the command will return -ENOMEM. The
+ * cap_count will still be updated in this case. It is recommended that the
+ * buffer size be set to IXGBE_ACI_MAX_BUFFER_SIZE (the largest possible
+ * buffer that firmware could return) to avoid this.
+ *
+ * Return: the exit code of the operation.
+ * Exit code of -ENOMEM means the buffer size is too small.
+ */
+int ixgbe_aci_list_caps(struct ixgbe_hw *hw, void *buf, u16 buf_size,
+			u32 *cap_count, enum ixgbe_aci_opc opc)
+{
+	struct ixgbe_aci_cmd_list_caps *cmd;
+	struct ixgbe_aci_desc desc;
+	int err;
+
+	cmd = &desc.params.get_cap;
+
+	if (opc != ixgbe_aci_opc_list_func_caps &&
+	    opc != ixgbe_aci_opc_list_dev_caps)
+		return -EINVAL;
+
+	ixgbe_fill_dflt_direct_cmd_desc(&desc, opc);
+	err = ixgbe_aci_send_cmd(hw, &desc, buf, buf_size);
+
+	if (cap_count)
+		*cap_count = le32_to_cpu(cmd->count);
+
+	return err;
+}
+
+/**
+ * ixgbe_discover_dev_caps - Read and extract device capabilities
+ * @hw: pointer to the hardware structure
+ * @dev_caps: pointer to device capabilities structure
+ *
+ * Read the device capabilities and extract them into the dev_caps structure
+ * for later use.
+ *
+ * Return: the exit code of the operation.
+ */
+int ixgbe_discover_dev_caps(struct ixgbe_hw *hw,
+			    struct ixgbe_hw_dev_caps *dev_caps)
+{
+	u32 cap_count;
+	u8 *cbuf;
+	int err;
+
+	cbuf = kzalloc(IXGBE_ACI_MAX_BUFFER_SIZE, GFP_KERNEL);
+	if (!cbuf)
+		return -ENOMEM;
+
+	/* Although the driver doesn't know the number of capabilities the
+	 * device will return, we can simply send a 4KB buffer, the maximum
+	 * possible size that firmware can return.
+	 */
+	cap_count = IXGBE_ACI_MAX_BUFFER_SIZE /
+		    sizeof(struct ixgbe_aci_cmd_list_caps_elem);
+
+	err = ixgbe_aci_list_caps(hw, cbuf, IXGBE_ACI_MAX_BUFFER_SIZE,
+				  &cap_count,
+				  ixgbe_aci_opc_list_dev_caps);
+	if (!err)
+		ixgbe_parse_dev_caps(hw, dev_caps, cbuf, cap_count);
+
+	kfree(cbuf);
+
+	return 0;
+}
+
+/**
+ * ixgbe_discover_func_caps - Read and extract function capabilities
+ * @hw: pointer to the hardware structure
+ * @func_caps: pointer to function capabilities structure
+ *
+ * Read the function capabilities and extract them into the func_caps structure
+ * for later use.
+ *
+ * Return: the exit code of the operation.
+ */
+int ixgbe_discover_func_caps(struct ixgbe_hw *hw,
+			     struct ixgbe_hw_func_caps *func_caps)
+{
+	u32 cap_count;
+	u8 *cbuf;
+	int err;
+
+	cbuf = kzalloc(IXGBE_ACI_MAX_BUFFER_SIZE, GFP_KERNEL);
+	if (!cbuf)
+		return -ENOMEM;
+
+	/* Although the driver doesn't know the number of capabilities the
+	 * device will return, we can simply send a 4KB buffer, the maximum
+	 * possible size that firmware can return.
+	 */
+	cap_count = IXGBE_ACI_MAX_BUFFER_SIZE /
+		    sizeof(struct ixgbe_aci_cmd_list_caps_elem);
+
+	err = ixgbe_aci_list_caps(hw, cbuf, IXGBE_ACI_MAX_BUFFER_SIZE,
+				  &cap_count,
+				  ixgbe_aci_opc_list_func_caps);
+	if (!err)
+		ixgbe_parse_func_caps(hw, func_caps, cbuf, cap_count);
+
+	kfree(cbuf);
+
+	return 0;
+}
+
+/**
+ * ixgbe_get_caps - get info about the HW
+ * @hw: pointer to the hardware structure
+ *
+ * Retrieve both device and function capabilities.
+ *
+ * Return: the exit code of the operation.
+ */
+int ixgbe_get_caps(struct ixgbe_hw *hw)
+{
+	int err;
+
+	err = ixgbe_discover_dev_caps(hw, &hw->dev_caps);
+	if (err)
+		return err;
+
+	return ixgbe_discover_func_caps(hw, &hw->func_caps);
+}
+
+/**
+ * ixgbe_aci_disable_rxen - disable RX
+ * @hw: pointer to the HW struct
+ *
+ * Request a safe disable of Receive Enable using ACI command (0x000C).
+ *
+ * Return: the exit code of the operation.
+ */
+int ixgbe_aci_disable_rxen(struct ixgbe_hw *hw)
+{
+	struct ixgbe_aci_cmd_disable_rxen *cmd;
+	struct ixgbe_aci_desc desc;
+
+	cmd = &desc.params.disable_rxen;
+
+	ixgbe_fill_dflt_direct_cmd_desc(&desc, ixgbe_aci_opc_disable_rxen);
+
+	cmd->lport_num = hw->bus.func;
+
+	return ixgbe_aci_send_cmd(hw, &desc, NULL, 0);
+}
+
+/**
+ * ixgbe_aci_get_phy_caps - returns PHY capabilities
+ * @hw: pointer to the HW struct
+ * @qual_mods: report qualified modules
+ * @report_mode: report mode capabilities
+ * @pcaps: structure for PHY capabilities to be filled
+ *
+ * Returns the various PHY capabilities supported on the Port
+ * using ACI command (0x0600).
+ *
+ * Return: the exit code of the operation.
+ */
+int ixgbe_aci_get_phy_caps(struct ixgbe_hw *hw, bool qual_mods, u8 report_mode,
+			   struct ixgbe_aci_cmd_get_phy_caps_data *pcaps)
+{
+	struct ixgbe_aci_cmd_get_phy_caps *cmd;
+	u16 pcaps_size = sizeof(*pcaps);
+	struct ixgbe_aci_desc desc;
+	int err;
+
+	cmd = &desc.params.get_phy;
+
+	if (!pcaps || (report_mode & ~IXGBE_ACI_REPORT_MODE_M))
+		return -EINVAL;
+
+	ixgbe_fill_dflt_direct_cmd_desc(&desc, ixgbe_aci_opc_get_phy_caps);
+
+	if (qual_mods)
+		cmd->param0 |= cpu_to_le16(IXGBE_ACI_GET_PHY_RQM);
+
+	cmd->param0 |= cpu_to_le16(report_mode);
+	err = ixgbe_aci_send_cmd(hw, &desc, pcaps, pcaps_size);
+	if (!err && report_mode == IXGBE_ACI_REPORT_TOPO_CAP_MEDIA) {
+		hw->phy.phy_type_low = le64_to_cpu(pcaps->phy_type_low);
+		hw->phy.phy_type_high = le64_to_cpu(pcaps->phy_type_high);
+		memcpy(hw->link.link_info.module_type, &pcaps->module_type,
+		       sizeof(hw->link.link_info.module_type));
+	}
+
+	return err;
+}
+
+/**
+ * ixgbe_copy_phy_caps_to_cfg - Copy PHY ability data to configuration data
+ * @caps: PHY ability structure to copy data from
+ * @cfg: PHY configuration structure to copy data to
+ *
+ * Helper function to copy data from PHY capabilities data structure
+ * to PHY configuration data structure
+ */
+void ixgbe_copy_phy_caps_to_cfg(struct ixgbe_aci_cmd_get_phy_caps_data *caps,
+				struct ixgbe_aci_cmd_set_phy_cfg_data *cfg)
+{
+	if (!caps || !cfg)
+		return;
+
+	memset(cfg, 0, sizeof(*cfg));
+	cfg->phy_type_low = caps->phy_type_low;
+	cfg->phy_type_high = caps->phy_type_high;
+	cfg->caps = caps->caps;
+	cfg->low_power_ctrl_an = caps->low_power_ctrl_an;
+	cfg->eee_cap = caps->eee_cap;
+	cfg->eeer_value = caps->eeer_value;
+	cfg->link_fec_opt = caps->link_fec_options;
+	cfg->module_compliance_enforcement =
+		caps->module_compliance_enforcement;
+}
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
index 18b831b6797d..5c5a6769b566 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
@@ -15,5 +15,17 @@ void ixgbe_fill_dflt_direct_cmd_desc(struct ixgbe_aci_desc *desc, u16 opcode);
 int ixgbe_acquire_res(struct ixgbe_hw *hw, enum ixgbe_aci_res_ids res,
 		      enum ixgbe_aci_res_access_type access, u32 timeout);
 void ixgbe_release_res(struct ixgbe_hw *hw, enum ixgbe_aci_res_ids res);
+int ixgbe_aci_list_caps(struct ixgbe_hw *hw, void *buf, u16 buf_size,
+			u32 *cap_count, enum ixgbe_aci_opc opc);
+int ixgbe_discover_dev_caps(struct ixgbe_hw *hw,
+			    struct ixgbe_hw_dev_caps *dev_caps);
+int ixgbe_discover_func_caps(struct ixgbe_hw *hw,
+			     struct ixgbe_hw_func_caps *func_caps);
+int ixgbe_get_caps(struct ixgbe_hw *hw);
+int ixgbe_aci_disable_rxen(struct ixgbe_hw *hw);
+int ixgbe_aci_get_phy_caps(struct ixgbe_hw *hw, bool qual_mods, u8 report_mode,
+			   struct ixgbe_aci_cmd_get_phy_caps_data *pcaps);
+void ixgbe_copy_phy_caps_to_cfg(struct ixgbe_aci_cmd_get_phy_caps_data *caps,
+				struct ixgbe_aci_cmd_set_phy_cfg_data *cfg);
 
 #endif /* _IXGBE_E610_H_ */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 2e38e8f6fac1..13b777d702a2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -42,6 +42,7 @@
 
 #include "ixgbe.h"
 #include "ixgbe_common.h"
+#include "ixgbe_e610.h"
 #include "ixgbe_dcb_82599.h"
 #include "ixgbe_mbx.h"
 #include "ixgbe_phy.h"
@@ -10933,6 +10934,12 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		goto err_sw_init;
 
+	if (adapter->hw.mac.type == ixgbe_mac_e610) {
+		err = ixgbe_get_caps(&adapter->hw);
+		if (err)
+			dev_err(&pdev->dev, "ixgbe_get_caps failed %d\n", err);
+	}
+
 	if (adapter->hw.mac.type == ixgbe_mac_82599EB)
 		adapter->flags2 |= IXGBE_FLAG2_AUTO_DISABLE_VF;
 
-- 
2.47.1


