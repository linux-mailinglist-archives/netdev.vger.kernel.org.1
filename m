Return-Path: <netdev+bounces-233230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A509C0EFB5
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 16:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8BF13AC2CB
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 15:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ED12FCC1B;
	Mon, 27 Oct 2025 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dehqVM9m"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F6A7081E;
	Mon, 27 Oct 2025 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579073; cv=none; b=EW3/gtDENdwKUiQ7J3/Jw9Zjgs9Cnzyds5vHA0wKW/sCVbQ4R1wClR8sYqe3nK4IYWDvy/6xI2GQGtGPL8dSwgQ6I84HNCTR4RntkKLkO0ppdboPVnwg3FGhafZdZLo2zyzLfveK/CyueJ2RfErvRa2sjbXB8w7Flo17XigdYZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579073; c=relaxed/simple;
	bh=E8ewEKmaWdaO+DsnCq55QFFGmbhvc1RLRyHIm9BxOBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UGq7t5K58Sx8QcfC/cN7o83qhdQUr4lQp5xnYlIFDfy/9WxGJ7tcmFN7e+rByizF3Al5T4nJXCcWtN16ael+gtMu1lVM2vfU0PkEyWiXLVP/I4UU/bsJmx/dvLVT8hZVR9rkEFV77MIl64BRIMg52R0tOPY5wwjnB761r5UI7YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dehqVM9m; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761579071; x=1793115071;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E8ewEKmaWdaO+DsnCq55QFFGmbhvc1RLRyHIm9BxOBE=;
  b=dehqVM9m/zk3i+Oowd9tY1APjrExEHy/YQwVndv8dA+1awOXFCvU7Io4
   5KXVx+puqoNaWw0Cm/+xG5Et/HocPhUf0GEeT82tCoe2ie12qNmgQ4KPO
   PyZXw580j6GSisM5YavYzS1CJOsEPJO6GvF1iw9HfjzDMH2OEEtWhkOdc
   zCxXxx7dY5tdY8NXPyHBsEiBSI/e1iBUjY3zS5SrvE02o2Of5OpWmslDD
   2K24Usf7kCopJahBwOJdidg8EDIM8KKUixQbHHB1CLqDVafc4UXBUwiQr
   nMBO6VC2qQZEafIBtg0pN74Mnda16JnRETNkll6Tuszpv4gUMg96hJOdp
   g==;
X-CSE-ConnectionGUID: kFMQKasaSgyMxhE6+1qxYg==
X-CSE-MsgGUID: ySYz1CeJQqOcD3gh7EoWLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67496481"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67496481"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 08:31:10 -0700
X-CSE-ConnectionGUID: EEr2mv6TTGes7MqZ4iKbDg==
X-CSE-MsgGUID: yVZ4CGGKTGKB4lDtuZQtrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="185541037"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa009.fm.intel.com with ESMTP; 27 Oct 2025 08:31:06 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH iwl-next v4] ice: add support for unmanaged DPLL on E830 NIC
Date: Mon, 27 Oct 2025 16:24:43 +0100
Message-Id: <20251027152443.1883663-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hardware variants of E830 may support an unmanaged DPLL where the
configuration is hardcoded within the hardware and firmware, meaning
users cannot modify settings. However, users are able to check the DPLL
lock status and obtain configuration information through the Linux DPLL
subsystem.

Availability of 'loss of lock' health status code determines if such
support is available, if true, register single DPLL device with 1 input
and 1 output and provide hardcoded/read only properties of a pin and
DPLL device. User is only allowed to check DPLL device status and receive
notifications on DPLL lock status change.

When present, the DPLL device locks to an external signal provided
through the PCIe/OCP pin. The expected input signal is 1PPS
(1 Pulse Per Second) embedded on a 10MHz reference clock.
The DPLL produces output:
- for MAC (Media Access Control) & PHY (Physical Layer) clocks,
- 1PPS for synchronization of onboard PHC (Precision Hardware Clock) timer.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
v4:
- add correct strcuture for reading supported health status codes and
  use it to parse the outcome of 0xFF21 AQ command.
---
 .../device_drivers/ethernet/intel/ice.rst     |  83 +++++
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  12 +
 drivers/net/ethernet/intel/ice/ice_common.c   | 135 ++++++++
 drivers/net/ethernet/intel/ice/ice_common.h   |   8 +
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 305 ++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_dpll.h     |  11 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  14 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  46 +++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   1 +
 9 files changed, 593 insertions(+), 22 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/intel/ice.rst b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
index 0bca293cf9cb..c5cf9af75ca9 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/ice.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
@@ -941,6 +941,89 @@ To see input signal on those PTP pins, you need to configure DPLL properly.
 Output signal is only visible on DPLL and to send it to the board SMA/U.FL pins,
 DPLL output pins have to be manually configured.
 
+Unmanaged DPLL Support
+----------------------
+Hardware variants of E830 may support an unmanaged DPLL:
+
+- Intel® Ethernet Network Adapter E830-XXVDA8F for OCP 3.0,
+
+- Intel® Ethernet Network Adapter E830-XXVDA4F.
+
+In the case of the unmanaged DPLL, the configuration is hardcoded within the
+hardware and firmware, meaning users cannot modify settings. However,
+users can check the DPLL lock status and obtain configuration information
+through the Linux DPLL subsystem.
+
+When present, the DPLL device locks to an external signal provided through the
+PCIe/OCP pin. The expected input signal is 1PPS (1 Pulse Per Second) embedded
+on a 10MHz reference clock.
+The DPLL produces output:
+
+- for MAC (Media Access Control) & PHY (Physical Layer) clocks,
+
+- 1PPS for synchronization of onboard PHC (Precision Hardware Clock) timer.
+
+Requirements: The Linux kernel must have support for both the DPLL Subsystem
+and the Embedded Sync patch series.
+
+Example output of querying the Linux DPLL subsystem can be found below.
+
+.. code-block:: console
+  :caption: Dumping the DPLL pins
+
+  $ <ynl> --spec Documentation/netlink/specs/dpll.yaml --dump pin-get
+  [{'board-label': '1588-TIME_SYNC',
+    'capabilities': set(),
+    'clock-id': 282574471561216,
+    'esync-frequency': 1,
+    'esync-frequency-supported': [{'frequency-max': 1, 'frequency-min': 1}],
+    'esync-pulse': 25,
+    'frequency': 10000000,
+    'id': 13,
+    'module-name': 'ice',
+    'parent-device': [{'direction': 'input',
+                       'parent-id': 6,
+                       'state': 'connected'}],
+    'phase-adjust-max': 0,
+    'phase-adjust-min': 0,
+    'type': 'ext'},
+    {'board-label': 'MAC-PHY-CLK',
+      'capabilities': set(),
+    'clock-id': 282574471561216,
+    'frequency': 156250000,
+    'id': 14,
+    'module-name': 'ice',
+    'parent-device': [{'direction': 'output',
+                       'parent-id': 6,
+                       'state': 'connected'}],
+    'phase-adjust-max': 0,
+    'phase-adjust-min': 0,
+    'type': 'synce-eth-port'},
+  {'board-label': '1588-TIME_REF',
+    'capabilities': set(),
+    'clock-id': 282574471561216,
+    'frequency': 1,
+    'id': 15,
+    'module-name': 'ice',
+    'parent-device': [{'direction': 'output',
+                       'parent-id': 6,
+                       'state': 'connected'}],
+    'phase-adjust-max': 0,
+    'phase-adjust-min': 0,
+    'type': 'int-oscillator'}]
+
+.. code-block:: console
+  :caption: Dumping the DPLL devices
+
+  $ <ynl> --spec Documentation/netlink/specs/dpll.yaml --dump device-get
+  [{'clock-id': 282574471561216,
+    'id': 6,
+    'lock-status': 'locked',
+    'mode': 'automatic',
+    'mode-supported': ['automatic'],
+    'module-name': 'ice',
+    'type': 'eec'}]
+
 GNSS module
 -----------
 Requires kernel compiled with CONFIG_GNSS=y or CONFIG_GNSS=m.
diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 859e9c66f3e7..3f8c1b8befc3 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1498,6 +1498,7 @@ struct ice_aqc_get_link_topo {
 #define ICE_AQC_GET_LINK_TOPO_NODE_NR_PCA9575		0x21
 #define ICE_AQC_GET_LINK_TOPO_NODE_NR_ZL30632_80032	0x24
 #define ICE_AQC_GET_LINK_TOPO_NODE_NR_SI5383_5384	0x25
+#define ICE_AQC_GET_LINK_TOPO_NODE_NR_ZL80640		0x27
 #define ICE_AQC_GET_LINK_TOPO_NODE_NR_E822_PHY		0x30
 #define ICE_AQC_GET_LINK_TOPO_NODE_NR_C827		0x31
 #define ICE_AQC_GET_LINK_TOPO_NODE_NR_GEN_CLK_MUX	0x47
@@ -2481,11 +2482,14 @@ enum ice_aqc_health_status {
 	ICE_AQC_HEALTH_STATUS_ERR_BMC_RESET			= 0x50B,
 	ICE_AQC_HEALTH_STATUS_ERR_LAST_MNG_FAIL			= 0x50C,
 	ICE_AQC_HEALTH_STATUS_ERR_RESOURCE_ALLOC_FAIL		= 0x50D,
+	ICE_AQC_HEALTH_STATUS_INFO_LOSS_OF_LOCK			= 0x601,
 	ICE_AQC_HEALTH_STATUS_ERR_FW_LOOP			= 0x1000,
 	ICE_AQC_HEALTH_STATUS_ERR_FW_PFR_FAIL			= 0x1001,
 	ICE_AQC_HEALTH_STATUS_ERR_LAST_FAIL_AQ			= 0x1002,
 };
 
+#define ICE_AQC_HEALTH_STATUS_CODE_NUM				64
+
 /* Get Health Status (indirect 0xFF22) */
 struct ice_aqc_get_health_status {
 	__le16 health_status_count;
@@ -2512,6 +2516,13 @@ struct ice_aqc_health_status_elem {
 	__le32 internal_data2;
 };
 
+/* Get Health Status response buffer entry, (0xFF21)
+ * repeated per reported health status
+ */
+struct ice_aqc_health_status_supp_elem {
+	__le16 health_status_code;
+};
+
 /* Admin Queue command opcodes */
 enum ice_adminq_opc {
 	/* AQ commands */
@@ -2675,6 +2686,7 @@ enum ice_adminq_opc {
 
 	/* System Diagnostic commands */
 	ice_aqc_opc_set_health_status_cfg		= 0xFF20,
+	ice_aqc_opc_get_supported_health_status_codes	= 0xFF21,
 	ice_aqc_opc_get_health_status			= 0xFF22,
 
 	/* FW Logging Commands */
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 046bc9c65c51..1c497439d33a 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -3081,6 +3081,29 @@ bool ice_is_cgu_in_netlist(struct ice_hw *hw)
 	return false;
 }
 
+/**
+ * ice_is_unmanaged_cgu_in_netlist - check for unmanaged CGU presence
+ * @hw: pointer to the hw struct
+ *
+ * Check if the unmanaged Clock Generation Unit (CGU) device is present in the netlist.
+ * Save the CGU part number in the hw structure for later use.
+ * Return:
+ * * true - unmanaged cgu is present
+ * * false - unmanaged cgu is not present
+ */
+bool ice_is_unmanaged_cgu_in_netlist(struct ice_hw *hw)
+{
+	if (!ice_find_netlist_node(hw, ICE_AQC_LINK_TOPO_NODE_TYPE_CLK_CTRL,
+				   ICE_AQC_LINK_TOPO_NODE_CTX_GLOBAL,
+				   ICE_AQC_GET_LINK_TOPO_NODE_NR_ZL80640,
+				   NULL)) {
+		hw->cgu_part_number = ICE_AQC_GET_LINK_TOPO_NODE_NR_ZL80640;
+		return true;
+	}
+
+	return false;
+}
+
 /**
  * ice_is_gps_in_netlist
  * @hw: pointer to the hw struct
@@ -6343,6 +6366,118 @@ bool ice_is_fw_health_report_supported(struct ice_hw *hw)
 				     ICE_FW_API_HEALTH_REPORT_PATCH);
 }
 
+/**
+ * ice_aq_get_health_status_supported - get supported health status codes
+ * @hw: pointer to the HW struct
+ * @buff: pointer to buffer where health status elements will be stored
+ * @num: number of health status elements buffer can hold
+ *
+ * Return:
+ * * 0 - success,
+ * * negative - AQ error code.
+ */
+static int
+ice_aq_get_health_status_supported(struct ice_hw *hw,
+				   struct ice_aqc_health_status_supp_elem *buff,
+				   int num)
+{
+	u16 code = ice_aqc_opc_get_supported_health_status_codes;
+	struct libie_aq_desc desc;
+
+	ice_fill_dflt_direct_cmd_desc(&desc, code);
+
+	return ice_aq_send_cmd(hw, &desc, buff, num * sizeof(*buff), NULL);
+}
+
+/**
+ * ice_aq_get_health_status - get current health status array from the firmware
+ * @hw: pointer to the HW struct
+ * @buff: pointer to buffer where health status elements will be stored
+ * @num: number of health status elements buffer can hold
+ *
+ * Return:
+ * * 0 - success,
+ * * negative - AQ error code.
+ */
+int ice_aq_get_health_status(struct ice_hw *hw,
+			     struct ice_aqc_health_status_elem *buff, int num)
+{
+	struct libie_aq_desc desc;
+
+	ice_fill_dflt_direct_cmd_desc(&desc,
+				      ice_aqc_opc_get_health_status);
+
+	return ice_aq_send_cmd(hw, &desc, buff, num * sizeof(*buff), NULL);
+}
+
+/**
+ * ice_is_health_status_code_supported - check if health status code is supported
+ * @hw: pointer to the hardware structure
+ * @code: health status code to check
+ * @supported: pointer to boolean result
+ *
+ * Return: 0 on success, negative error code otherwise
+ */
+int ice_is_health_status_code_supported(struct ice_hw *hw, u16 code,
+					bool *supported)
+{
+	const int BUFF_SIZE = ICE_AQC_HEALTH_STATUS_CODE_NUM;
+	struct ice_aqc_health_status_supp_elem *buff;
+	int ret;
+
+	buff = kcalloc(BUFF_SIZE, sizeof(*buff), GFP_KERNEL);
+	if (!buff)
+		return -ENOMEM;
+	ret = ice_aq_get_health_status_supported(hw, buff, BUFF_SIZE);
+	if (ret)
+		goto free_buff;
+	for (int i = 0; i < BUFF_SIZE && buff[i].health_status_code; i++)
+		if (le16_to_cpu(buff[i].health_status_code) == code) {
+			*supported = true;
+			break;
+		}
+
+free_buff:
+	kfree(buff);
+	return ret;
+}
+
+/**
+ * ice_get_last_health_status_code - get last health status for given code
+ * @hw: pointer to the hardware structure
+ * @out: pointer to the health status struct to be filled
+ * @code: health status code to check
+ *
+ * Return: 0 on success, negative error code otherwise
+ */
+int ice_get_last_health_status_code(struct ice_hw *hw,
+				    struct ice_aqc_health_status_elem *out,
+				    u16 code)
+{
+	const int BUFF_SIZE = ICE_AQC_HEALTH_STATUS_CODE_NUM;
+	struct ice_aqc_health_status_elem *buff;
+	int ret, last_status = -1;
+
+	buff = kcalloc(BUFF_SIZE, sizeof(*buff), GFP_KERNEL);
+	if (!buff)
+		return -ENOMEM;
+	ret = ice_aq_get_health_status(hw, buff, BUFF_SIZE);
+	if (ret)
+		goto free_buff;
+	for (int i = 0; i < BUFF_SIZE && buff[i].health_status_code; i++)
+		if (le16_to_cpu(buff[i].health_status_code) == code)
+			last_status = i;
+
+	if (last_status >= 0)
+		memcpy(out, &buff[last_status], sizeof(*out));
+	else
+		memset(out, 0, sizeof(*out));
+
+free_buff:
+	kfree(buff);
+	return ret;
+}
+
 /**
  * ice_aq_set_health_status_cfg - Configure FW health events
  * @hw: pointer to the HW struct
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index e700ac0dc347..cbecee66e2a7 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -162,6 +162,7 @@ ice_aq_get_phy_caps(struct ice_port_info *pi, bool qual_mods, u8 report_mode,
 bool ice_is_phy_rclk_in_netlist(struct ice_hw *hw);
 bool ice_is_clock_mux_in_netlist(struct ice_hw *hw);
 bool ice_is_cgu_in_netlist(struct ice_hw *hw);
+bool ice_is_unmanaged_cgu_in_netlist(struct ice_hw *hw);
 bool ice_is_gps_in_netlist(struct ice_hw *hw);
 int
 ice_aq_get_netlist_node(struct ice_hw *hw, struct ice_aqc_get_link_topo *cmd,
@@ -188,6 +189,13 @@ ice_get_link_default_override(struct ice_link_default_override_tlv *ldo,
 			      struct ice_port_info *pi);
 bool ice_is_phy_caps_an_enabled(struct ice_aqc_get_phy_caps_data *caps);
 bool ice_is_fw_health_report_supported(struct ice_hw *hw);
+int ice_aq_get_health_status(struct ice_hw *hw,
+			     struct ice_aqc_health_status_elem *buff, int num);
+int ice_is_health_status_code_supported(struct ice_hw *hw, u16 code,
+					bool *supported);
+int ice_get_last_health_status_code(struct ice_hw *hw,
+				    struct ice_aqc_health_status_elem *out,
+				    u16 code);
 int ice_aq_set_health_status_cfg(struct ice_hw *hw, u8 event_source);
 int ice_aq_get_phy_equalization(struct ice_hw *hw, u16 data_in, u16 op_code,
 				u8 serdes_num, int *output);
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 00160c1f788e..fb23878af6d8 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -22,6 +22,8 @@
 #define ICE_DPLL_TSPLL_INPUT_NUM_E825		1
 #define ICE_DPLL_TSPLL_OUTPUT_NUM_E825		1
 #define ICE_DPLL_TSPLL_IDX_E825			1
+#define ICE_DPLL_HEALTH_STATUS_LOCKED		1
+#define ICE_DPLL_HEALTH_STATUS_UNLOCKED		0
 
 #define ICE_DPLL_PIN_SW_INPUT_ABS(in_idx) \
 	(ICE_DPLL_SW_PIN_INPUT_BASE_SFP + (in_idx))
@@ -103,6 +105,10 @@ static struct dpll_pin_frequency ice_cgu_pin_freq_156_25mhz[] = {
 	DPLL_PIN_FREQUENCY_RANGE(156250000, 156250000),
 };
 
+static const struct dpll_pin_frequency ice_esync_range_unmanaged[] = {
+	DPLL_PIN_FREQUENCY_1PPS,
+};
+
 /**
  * ice_dpll_is_sw_pin - check if given pin shall be controlled by SW
  * @pf: private board structure
@@ -1190,9 +1196,11 @@ ice_dpll_pin_state_get(const struct dpll_pin *pin, void *pin_priv,
 		return -EBUSY;
 
 	mutex_lock(&pf->dplls.lock);
-	ret = ice_dpll_pin_state_update(pf, p, pin_type, extack);
-	if (ret)
-		goto unlock;
+	if (!pf->dplls.unmanaged) {
+		ret = ice_dpll_pin_state_update(pf, p, pin_type, extack);
+		if (ret)
+			goto unlock;
+	}
 	if (pin_type == ICE_DPLL_PIN_TYPE_INPUT ||
 	    pin_type == ICE_DPLL_PIN_TYPE_OUTPUT ||
 	    pin_type == ICE_DPLL_PIN_TYPE_INPUT_TSPLL_E825)
@@ -2346,9 +2354,12 @@ ice_dpll_input_esync_get(const struct dpll_pin *pin, void *pin_priv,
 		mutex_unlock(&pf->dplls.lock);
 		return -EOPNOTSUPP;
 	}
-	esync->range = ice_esync_range;
+	if (pf->dplls.unmanaged)
+		esync->range = ice_esync_range_unmanaged;
+	else
+		esync->range = ice_esync_range;
 	esync->range_num = ARRAY_SIZE(ice_esync_range);
-	if (p->flags[0] & ICE_AQC_GET_CGU_IN_CFG_FLG2_ESYNC_EN) {
+	if (p->flags[0] & ICE_DPLL_IN_ESYNC_ENABLED) {
 		esync->freq = DPLL_PIN_FREQUENCY_1_HZ;
 		esync->pulse = ICE_DPLL_PIN_ESYNC_PULSE_HIGH_PERCENT;
 	} else {
@@ -2878,6 +2889,21 @@ static const struct dpll_pin_ops ice_dpll_output_ops = {
 	.esync_get = ice_dpll_output_esync_get,
 };
 
+static const struct dpll_pin_ops ice_dpll_input_unmanaged_ops = {
+	.frequency_get = ice_dpll_input_frequency_get,
+	.direction_get = ice_dpll_input_direction,
+	.state_on_dpll_get = ice_dpll_input_state_get,
+#if defined(HAVE_DPLL_ESYNC)
+	.esync_get = ice_dpll_input_esync_get,
+#endif /* HAVE_DPLL_ESYNC */
+};
+
+static const struct dpll_pin_ops ice_dpll_output_unmanaged_ops = {
+	.frequency_get = ice_dpll_output_frequency_get,
+	.direction_get = ice_dpll_output_direction,
+	.state_on_dpll_get = ice_dpll_output_state_get,
+};
+
 static const struct dpll_device_ops ice_dpll_ops = {
 	.lock_status_get = ice_dpll_lock_status_get,
 	.mode_get = ice_dpll_mode_get,
@@ -3503,9 +3529,11 @@ ice_dpll_init_direct_pins(struct ice_pf *pf, bool cgu,
 		ret = ice_dpll_register_pins(first, pins, ops, count);
 		if (ret)
 			goto release_pins;
-		ret = ice_dpll_register_pins(second, pins, ops, count);
-		if (ret)
-			goto unregister_first;
+		if (second) {
+			ret = ice_dpll_register_pins(second, pins, ops, count);
+			if (ret)
+				goto unregister_first;
+		}
 	}
 	if (pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825) {
 		ret = ice_dpll_register_pins(first, pins, ops, count);
@@ -3701,6 +3729,18 @@ static void ice_dpll_deinit_pins(struct ice_pf *pf, bool cgu)
 	struct ice_dpll *dp = &d->pps;
 	struct ice_dpll *dt = &d->tspll;
 
+	if (d->unmanaged) {
+		ice_dpll_unregister_pins(de->dpll, inputs,
+					 &ice_dpll_input_unmanaged_ops,
+					 num_inputs);
+		ice_dpll_unregister_pins(de->dpll, outputs,
+					 &ice_dpll_output_unmanaged_ops,
+					 num_outputs);
+		ice_dpll_release_pins(inputs, num_inputs);
+		ice_dpll_release_pins(outputs, num_outputs);
+		return;
+	}
+
 	ice_dpll_deinit_rclk_pin(pf);
 	if (cgu) {
 		ice_dpll_unregister_pins(dp->dpll, inputs, &ice_dpll_input_ops,
@@ -3768,8 +3808,13 @@ static int ice_dpll_init_pins(struct ice_pf *pf, bool cgu)
 		output_ops = NULL;
 		break;
 	default:
-		input_ops = &ice_dpll_input_ops;
-		output_ops = &ice_dpll_output_ops;
+		if (!pf->dplls.unmanaged) {
+			input_ops = &ice_dpll_input_ops;
+			output_ops = &ice_dpll_output_ops;
+		} else {
+			input_ops = &ice_dpll_input_unmanaged_ops;
+			output_ops = &ice_dpll_output_unmanaged_ops;
+		}
 		break;
 	}
 	ret = ice_dpll_init_direct_pins(pf, cgu, pf->dplls.inputs, 0,
@@ -3778,13 +3823,15 @@ static int ice_dpll_init_pins(struct ice_pf *pf, bool cgu)
 	if (ret)
 		return ret;
 	count = pf->dplls.num_inputs;
-	if (cgu) {
+	if (cgu || pf->dplls.unmanaged) {
 		ret = ice_dpll_init_direct_pins(pf, cgu, pf->dplls.outputs,
 						count, pf->dplls.num_outputs,
 						output_ops, pf->dplls.eec.dpll,
 						pf->dplls.pps.dpll);
 		if (ret)
 			goto deinit_inputs;
+		if (pf->dplls.unmanaged)
+			return 0;
 		count += pf->dplls.num_outputs;
 		if (!pf->dplls.generic) {
 			ret = ice_dpll_init_direct_pins(pf, cgu, pf->dplls.sma,
@@ -3953,7 +4000,7 @@ ice_dpll_init_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu,
 
 		if (type == DPLL_TYPE_PPS && ice_dpll_is_pps_phase_monitor(pf))
 			ops =  &ice_dpll_pom_ops;
-		if (cgu)
+		if (cgu && !pf->dplls.unmanaged)
 			ice_dpll_update_state(pf, d, true);
 		ret = dpll_device_register(d->dpll, type, ops, d);
 		if (ret) {
@@ -3980,6 +4027,33 @@ static void ice_dpll_deinit_worker(struct ice_pf *pf)
 	kthread_destroy_worker(d->kworker);
 }
 
+/**
+ * ice_dpll_pin_freq_info - find pin frequency from supported ones
+ * @hw: pointer to the hardware structure
+ * @pin_idx: pin index
+ * @input: if input pin
+ *
+ * This function searches through the array of supported frequencies for a
+ * DPLL pin and returns single frequency pin is capable, if pin support only
+ * one frequency. Shall be used only for dpll with driver hardcoded frequency.
+ *
+ * Return:
+ * * 0 - failure, pin uses multiple frequencies,
+ * * frequency - success.
+ */
+static u64 ice_dpll_pin_freq_info(struct ice_hw *hw, u8 pin_idx, bool input)
+{
+	struct dpll_pin_frequency *freqs;
+	u8 freq_num;
+
+	/* Get supported frequencies for this pin */
+	freqs = ice_cgu_get_pin_freq_supp(hw, pin_idx, input, &freq_num);
+	if (!freqs || freq_num != 1 || freqs[0].min != freqs[0].max)
+		return 0;
+
+	return freqs[0].min;
+}
+
 /**
  * ice_dpll_init_worker - Initialize DPLLs periodic worker
  * @pf: board private structure
@@ -4228,6 +4302,15 @@ ice_dpll_init_info_direct_pins(struct ice_pf *pf,
 		pins[i].prop.board_label = ice_cgu_get_pin_name(hw, i, input);
 		pins[i].prop.type = ice_cgu_get_pin_type(hw, i, input);
 		if (input) {
+			if (pf->dplls.unmanaged) {
+				pins[i].freq = ice_dpll_pin_freq_info(hw, i,
+								      input);
+				pins[i].state[0] = DPLL_PIN_STATE_CONNECTED;
+				pins[i].status =
+					ICE_AQC_GET_CGU_IN_CFG_STATUS_ESYNC_CAP;
+				pins[i].flags[0] = ICE_DPLL_IN_ESYNC_ENABLED;
+				continue;
+			}
 			ret = ice_aq_get_cgu_ref_prio(hw, de->dpll_idx, i,
 						      &de->input_prio[i]);
 			if (ret)
@@ -4241,6 +4324,12 @@ ice_dpll_init_info_direct_pins(struct ice_pf *pf,
 			if (ice_dpll_is_sw_pin(pf, i, true))
 				pins[i].hidden = true;
 		} else {
+			if (pf->dplls.unmanaged) {
+				pins[i].freq = ice_dpll_pin_freq_info(hw, i,
+								      input);
+				pins[i].state[0] = DPLL_PIN_STATE_CONNECTED;
+				continue;
+			}
 			ret = ice_cgu_get_output_pin_state_caps(hw, i, &caps);
 			if (ret)
 				return ret;
@@ -4258,10 +4347,13 @@ ice_dpll_init_info_direct_pins(struct ice_pf *pf,
 		pins[i].prop.freq_supported_num = freq_supp_num;
 		pins[i].pf = pf;
 	}
-	if (input)
+	if (input && !pf->dplls.unmanaged) {
 		ret = ice_dpll_init_ref_sync_inputs(pf);
+		if (ret)
+			return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
 /**
@@ -4447,6 +4539,81 @@ static void ice_dpll_deinit_info(struct ice_pf *pf)
 	kfree(pf->dplls.pps.input_prio);
 }
 
+/**
+ * ice_dpll_lock_state_init_unmanaged - initialize lock state for unmanaged dpll
+ * @pf: board private structure
+ *
+ * Initialize the lock state for unmanaged DPLL by checking health status.
+ * For unmanaged DPLL, we rely on hardware autonomous operation.
+ *
+ * Return:
+ * * 0 - success
+ * * negative - init failure reason
+ */
+static int ice_dpll_lock_state_init_unmanaged(struct ice_pf *pf)
+{
+	u16 code = ICE_AQC_HEALTH_STATUS_INFO_LOSS_OF_LOCK;
+	struct ice_aqc_health_status_elem buff;
+	int ret;
+
+	ret = ice_get_last_health_status_code(&pf->hw, &buff, code);
+	if (ret)
+		return ret;
+	ice_dpll_lock_state_set_unmanaged(pf, &buff, false);
+
+	return ret;
+}
+
+/**
+ * ice_dpll_init_info_unmanaged - init dpll information for unmanaged dpll
+ * @pf: board private structure
+ *
+ * Acquire (from HW) and set basic dpll information (on pf->dplls struct).
+ * For unmanaged dpll mode.
+ *
+ * Return:
+ * * 0 - success
+ * * negative - init failure reason
+ */
+static int ice_dpll_init_info_unmanaged(struct ice_pf *pf)
+{
+	struct ice_dplls *d = &pf->dplls;
+	struct ice_dpll *de = &d->eec;
+	int ret = 0;
+
+	d->clock_id = ice_generate_clock_id(pf);
+	d->num_inputs = ice_cgu_get_pin_num(&pf->hw, true);
+	d->num_outputs = ice_cgu_get_pin_num(&pf->hw, false);
+	ice_dpll_lock_state_init_unmanaged(pf);
+	d->inputs = kcalloc(d->num_inputs, sizeof(*d->inputs), GFP_KERNEL);
+	if (!d->inputs)
+		return -ENOMEM;
+
+	ret = ice_dpll_init_pins_info(pf, ICE_DPLL_PIN_TYPE_INPUT);
+	if (ret)
+		goto deinit_info;
+
+	d->outputs = kcalloc(d->num_outputs, sizeof(*d->outputs), GFP_KERNEL);
+	if (!d->outputs) {
+		ret = -ENOMEM;
+		goto deinit_info;
+	}
+
+	ret = ice_dpll_init_pins_info(pf, ICE_DPLL_PIN_TYPE_OUTPUT);
+	if (ret)
+		goto deinit_info;
+
+	de->mode = DPLL_MODE_AUTOMATIC;
+	dev_dbg(ice_pf_to_dev(pf), "%s - success, inputs:%u, outputs:%u\n",
+		__func__, d->num_inputs, d->num_outputs);
+	return 0;
+deinit_info:
+	dev_err(ice_pf_to_dev(pf), "%s - fail: d->inputs:%p, d->outputs:%p\n",
+		__func__, d->inputs, d->outputs);
+	ice_dpll_deinit_info(pf);
+	return ret;
+}
+
 /**
  * ice_dpll_init_info_e825c - prepare pf's dpll information structure for e825c
  * device
@@ -4559,6 +4726,7 @@ static int ice_dpll_init_info(struct ice_pf *pf, bool cgu)
 	dp->dpll_idx = abilities.pps_dpll_idx;
 	d->num_inputs = abilities.num_inputs;
 	d->num_outputs = abilities.num_outputs;
+
 	d->input_phase_adj_max = le32_to_cpu(abilities.max_in_phase_adj) &
 		ICE_AQC_GET_CGU_MAX_PHASE_ADJ;
 	d->output_phase_adj_max = le32_to_cpu(abilities.max_out_phase_adj) &
@@ -4627,6 +4795,42 @@ static int ice_dpll_init_info(struct ice_pf *pf, bool cgu)
 	return ret;
 }
 
+/**
+ * ice_dpll_lock_state_set_unmanaged - determine lock state from health status
+ * @pf: board private structure
+ * @buff: health status buffer
+ * @notify: if true, notify dpll device
+ *
+ * Set unmanaged dpll lock state based on health status code and internal data.
+ * Context: Acquires and releases pf->dplls.lock (must release before notify
+ * if called).
+ */
+void ice_dpll_lock_state_set_unmanaged(struct ice_pf *pf,
+				       struct ice_aqc_health_status_elem *buff,
+				       bool notify)
+{
+	u32 internal_data = le32_to_cpu(buff->internal_data1);
+	struct ice_dpll *d = &pf->dplls.eec;
+
+	if (!ice_pf_src_tmr_owned(pf))
+		return;
+
+	mutex_lock(&pf->dplls.lock);
+	if (buff->health_status_code == 0 ||
+	    internal_data == ICE_DPLL_HEALTH_STATUS_LOCKED)
+		d->dpll_state = DPLL_LOCK_STATUS_LOCKED;
+	else
+		d->dpll_state = DPLL_LOCK_STATUS_UNLOCKED;
+
+	if (d->prev_dpll_state == d->dpll_state)
+		notify = false;
+	else
+		d->prev_dpll_state = d->dpll_state;
+	mutex_unlock(&pf->dplls.lock);
+	if (notify && d->dpll)
+		dpll_device_change_ntf(d->dpll);
+}
+
 /**
  * ice_dpll_deinit - Disable the driver/HW support for dpll subsystem
  * the dpll device.
@@ -4646,18 +4850,59 @@ void ice_dpll_deinit(struct ice_pf *pf)
 	if (pf->dplls.periodic_work)
 		ice_dpll_deinit_worker(pf);
 
-	ice_dpll_deinit_pins(pf, cgu);
-	if (pf->hw.mac_type != ICE_MAC_GENERIC_3K_E825)
-		ice_dpll_deinit_dpll(pf, &pf->dplls.pps, cgu);
-	else
+	ice_dpll_deinit_pins(pf, cgu || pf->dplls.unmanaged);
+	if (pf->hw.mac_type != ICE_MAC_GENERIC_3K_E825) {
+		if (!pf->dplls.unmanaged)
+			ice_dpll_deinit_dpll(pf, &pf->dplls.pps, cgu);
+	} else {
 		ice_dpll_deinit_dpll(pf, &pf->dplls.tspll, cgu);
-	ice_dpll_deinit_dpll(pf, &pf->dplls.eec, cgu);
+	}
+	ice_dpll_deinit_dpll(pf, &pf->dplls.eec, cgu || pf->dplls.unmanaged);
 	ice_dpll_deinit_info(pf);
 	mutex_destroy(&pf->dplls.lock);
 }
 
 /**
- * ice_dpll_init - initialize support for dpll subsystem
+ * ice_dpll_init_unmanaged - initialize support for unmanaged dpll subsystem
+ * @pf: board private structure
+ *
+ * Set up the device dplls for unmanaged mode, register them and pins connected
+ * within Linux dpll subsystem. Allow userspace to obtain state of DPLL.
+ *
+ * Context: Initializes pf->dplls.lock mutex.
+ */
+static void ice_dpll_init_unmanaged(struct ice_pf *pf)
+{
+	struct ice_dplls *d = &pf->dplls;
+	int err;
+
+	if (!ice_pf_src_tmr_owned(pf))
+		return;
+	err = ice_dpll_init_info_unmanaged(pf);
+	if (err)
+		goto err_exit;
+	mutex_init(&d->lock);
+	err = ice_dpll_init_dpll(pf, &pf->dplls.eec, true, DPLL_TYPE_EEC);
+	if (err)
+		goto deinit_info;
+	err = ice_dpll_init_pins(pf, true);
+	if (err)
+		goto deinit_eec;
+	set_bit(ICE_FLAG_DPLL, pf->flags);
+
+	return;
+
+deinit_eec:
+	ice_dpll_deinit_dpll(pf, &pf->dplls.eec, true);
+deinit_info:
+	ice_dpll_deinit_info(pf);
+	mutex_destroy(&d->lock);
+err_exit:
+	dev_warn(ice_pf_to_dev(pf), "DPLLs init failure err:%d\n", err);
+}
+
+/**
+ * ice_dpll_init_managed - initialize support for managed dpll subsystem
  * @pf: board private structure
  *
  * Set up the device dplls, register them and pins connected within Linux dpll
@@ -4666,7 +4911,7 @@ void ice_dpll_deinit(struct ice_pf *pf)
  *
  * Context: Initializes pf->dplls.lock mutex.
  */
-void ice_dpll_init(struct ice_pf *pf)
+static void ice_dpll_init_managed(struct ice_pf *pf)
 {
 	bool cgu = ice_is_feature_supported(pf, ICE_F_CGU);
 	struct ice_dplls *d = &pf->dplls;
@@ -4720,3 +4965,21 @@ void ice_dpll_init(struct ice_pf *pf)
 	mutex_destroy(&d->lock);
 	dev_warn(ice_pf_to_dev(pf), "DPLLs init failure err:%d\n", err);
 }
+
+/**
+ * ice_dpll_init - initialize support for dpll subsystem
+ * @pf: board private structure
+ *
+ * Set up the device dplls, register them and pins connected within Linux dpll
+ * subsystem. Allow userspace to obtain state of DPLL and handling of DPLL
+ * configuration requests.
+ *
+ * Context: Initializes pf->dplls.lock mutex.
+ */
+void ice_dpll_init(struct ice_pf *pf)
+{
+	if (!pf->dplls.unmanaged)
+		ice_dpll_init_managed(pf);
+	else
+		ice_dpll_init_unmanaged(pf);
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index 6c2a79843cde..8f479d799af6 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -8,6 +8,9 @@
 
 #define ICE_DPLL_RCLK_NUM_MAX	4
 
+#define ICE_DPLL_UNMANAGED_PIN_NUM	4
+#define ICE_DPLL_IN_ESYNC_ENABLED	ICE_AQC_GET_CGU_IN_CFG_FLG2_ESYNC_EN
+
 /**
  * enum ice_dpll_pin_sw - enumerate ice software pin indices:
  * @ICE_DPLL_PIN_SW_1_IDX: index of first SW pin
@@ -143,6 +146,7 @@ struct ice_dplls {
 	s32 output_phase_adj_max;
 	u32 periodic_counter;
 	bool generic;
+	bool unmanaged;
 	void (*periodic_work)(struct kthread_work *work);
 };
 
@@ -156,9 +160,16 @@ ice_dpll_pin_store_state(struct ice_dpll_pin *pin, int parent, bool state)
 #if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
 void ice_dpll_init(struct ice_pf *pf);
 void ice_dpll_deinit(struct ice_pf *pf);
+void ice_dpll_lock_state_set_unmanaged(struct ice_pf *pf,
+				       struct ice_aqc_health_status_elem *buff,
+				       bool notify);
 #else
 static inline void ice_dpll_init(struct ice_pf *pf) { }
 static inline void ice_dpll_deinit(struct ice_pf *pf) { }
+static inline void
+ice_dpll_lock_state_set_unmanaged(struct ice_pf *pf,
+				  struct ice_aqc_health_status_elem *buff,
+				  bool notify) { }
 #endif
 
 #endif
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 0b6175ade40d..b16ede1f139d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4797,8 +4797,20 @@ static void ice_init_features(struct ice_pf *pf)
 	if (ice_is_feature_supported(pf, ICE_F_GNSS))
 		ice_gnss_init(pf);
 
+	/* Initialize unmanaged DPLL detection */
+	{
+		u16 code = ICE_AQC_HEALTH_STATUS_INFO_LOSS_OF_LOCK;
+		int err;
+
+		err = ice_is_health_status_code_supported(&pf->hw, code,
+							  &pf->dplls.unmanaged);
+		if (err || !ice_is_unmanaged_cgu_in_netlist(&pf->hw))
+			pf->dplls.unmanaged = false;
+	}
+
 	if (ice_is_feature_supported(pf, ICE_F_CGU) ||
-	    ice_is_feature_supported(pf, ICE_F_PHY_RCLK))
+	    ice_is_feature_supported(pf, ICE_F_PHY_RCLK) ||
+	    pf->dplls.unmanaged)
 		ice_dpll_init(pf);
 
 	/* Note: Flow director init failure is non-fatal to load */
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 10496e4e641c..7adf88d7ef0b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -20,6 +20,10 @@ static struct dpll_pin_frequency ice_cgu_pin_freq_10_mhz[] = {
 	DPLL_PIN_FREQUENCY_10MHZ,
 };
 
+static struct dpll_pin_frequency ice_cgu_pin_freq_156_25mhz[] = {
+	DPLL_PIN_FREQUENCY_RANGE(156250000, 156250000),
+};
+
 static const struct ice_cgu_pin_desc ice_e810t_sfp_cgu_inputs[] = {
 	{ "CVL-SDP22",	  ZL_REF0P, DPLL_PIN_TYPE_INT_OSCILLATOR,
 		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
@@ -136,6 +140,18 @@ static const struct ice_cgu_pin_desc ice_e825c_inputs[] = {
 	{ "CLK_IN_1",	 0, DPLL_PIN_TYPE_MUX, 0 },
 };
 
+static const struct ice_cgu_pin_desc ice_e830_unmanaged_inputs[] = {
+	{ "1588-TIME_SYNC", 0, DPLL_PIN_TYPE_EXT,
+	  ARRAY_SIZE(ice_cgu_pin_freq_10_mhz), ice_cgu_pin_freq_10_mhz },
+};
+
+static const struct ice_cgu_pin_desc ice_e830_unmanaged_outputs[] = {
+	{ "MAC-PHY-CLK", 0, DPLL_PIN_TYPE_SYNCE_ETH_PORT,
+	  ARRAY_SIZE(ice_cgu_pin_freq_156_25mhz), ice_cgu_pin_freq_156_25mhz },
+	{ "1588-TIME_REF", 1, DPLL_PIN_TYPE_INT_OSCILLATOR,
+	  ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz},
+};
+
 /* Low level functions for interacting with and managing the device clock used
  * for the Precision Time Protocol.
  *
@@ -5703,6 +5719,24 @@ ice_cgu_get_pin_desc(struct ice_hw *hw, bool input, int *size)
 	case ICE_DEV_ID_E825C_SGMII:
 		t = ice_get_pin_desc_e82x(hw, input, size);
 		break;
+	case ICE_DEV_ID_E830CC_BACKPLANE:
+	case ICE_DEV_ID_E830CC_QSFP56:
+	case ICE_DEV_ID_E830CC_SFP:
+	case ICE_DEV_ID_E830CC_SFP_DD:
+	case ICE_DEV_ID_E830C_BACKPLANE:
+	case ICE_DEV_ID_E830C_QSFP:
+	case ICE_DEV_ID_E830C_SFP:
+	case ICE_DEV_ID_E830_XXV_BACKPLANE:
+	case ICE_DEV_ID_E830_XXV_QSFP:
+	case ICE_DEV_ID_E830_XXV_SFP:
+		if (input) {
+			t = ice_e830_unmanaged_inputs;
+			*size = ARRAY_SIZE(ice_e830_unmanaged_inputs);
+		} else {
+			t = ice_e830_unmanaged_outputs;
+			*size = ARRAY_SIZE(ice_e830_unmanaged_outputs);
+		}
+		break;
 	default:
 		break;
 	}
@@ -5729,6 +5763,18 @@ int ice_cgu_get_num_pins(struct ice_hw *hw, bool input)
 	return 0;
 }
 
+/**
+ * ice_cgu_get_pin_num - get pin description array size
+ * @hw: pointer to the hw struct
+ * @input: if request is done against input or output pins
+ *
+ * Return: size of pin description array for given hw.
+ */
+int ice_cgu_get_pin_num(struct ice_hw *hw, bool input)
+{
+	return ice_cgu_get_num_pins(hw, input);
+}
+
 /**
  * ice_cgu_get_pin_type - get pin's type
  * @hw: pointer to the hw struct
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 2c2fa1e73ee0..1d5d0f37f8db 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -357,6 +357,7 @@ int ice_read_sma_ctrl(struct ice_hw *hw, u8 *data);
 int ice_write_sma_ctrl(struct ice_hw *hw, u8 data);
 int ice_ptp_read_sdp_ac(struct ice_hw *hw, __le16 *entries, uint *num_entries);
 int ice_cgu_get_num_pins(struct ice_hw *hw, bool input);
+int ice_cgu_get_pin_num(struct ice_hw *hw, bool input);
 enum dpll_pin_type ice_cgu_get_pin_type(struct ice_hw *hw, u8 pin, bool input);
 struct dpll_pin_frequency *
 ice_cgu_get_pin_freq_supp(struct ice_hw *hw, u8 pin, bool input, u8 *num);
-- 
2.38.1


