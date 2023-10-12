Return-Path: <netdev+bounces-40247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A777D7C661C
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 09:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0936B2826D9
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 07:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A268DDDB;
	Thu, 12 Oct 2023 07:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a6Lv8GRn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27D0DF45
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 07:08:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D49C0
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 00:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697094491; x=1728630491;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=00vVXI6ctGjcttDkxdSR9TKHuYmvkUDnrMI1SwgUr0k=;
  b=a6Lv8GRnniKkzWY4n35Q5ZW5CeTVjiAA62/kQGzOCh+trY1aKVxDgMZK
   caC9MeveBeZl8rs+3/7pi4ovr782D0qHpuyAoVjZ86CJkdJ4ScNCCaAsK
   yQrhIKKt4oKXj+GGIvx0z8ZqzX6ywrATUEdshSQZJ75V7tMfcIFCOcGP3
   4AIB7olOlx9HCUSdsW0Za5jiZEBybSMGf6U/0mhpcZ8sActsDssW8J5S0
   oOKeKBHU8pOYKlyoqQbOEoR/ZwuZGLZmmRAdXZOKkv8yZbvr7Dj1j7F/X
   ja42VWsbV1R2aYbRckQ5rWgWWDvJTW5D5WjMGcZCZaMtiFUUkxmFwy+6k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="383715921"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="383715921"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 00:08:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="927883887"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="927883887"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga005.jf.intel.com with ESMTP; 12 Oct 2023 00:08:06 -0700
Received: from kord.igk.intel.com (kord.igk.intel.com [10.123.220.9])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id DAE4B34926;
	Thu, 12 Oct 2023 08:08:04 +0100 (IST)
From: Konrad Knitter <konrad.knitter@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	Konrad Knitter <konrad.knitter@intel.com>,
	Marcin Domagala <marcinx.domagala@intel.com>,
	Eric Joyner <eric.joyner@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v3] ice: read internal temperature sensor
Date: Thu, 12 Oct 2023 09:13:59 +0200
Message-Id: <20231012071358.1101438-1-konrad.knitter@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Since 4.30 firmware exposes internal thermal sensor reading via admin
queue commands. Expose those readouts via hwmon API when supported.

Driver provides current reading from HW as well as device specific
thresholds for thermal alarm (Warning, Critical, Fatal) events.

$ sensors

Output
=========================================================
ice-pci-b100
Adapter: PCI adapter
temp1:        +62.0°C  (high = +95.0°C, crit = +105.0°C)
                       (emerg = +115.0°C)

Co-developed-by: Marcin Domagala <marcinx.domagala@intel.com>
Signed-off-by: Marcin Domagala <marcinx.domagala@intel.com>
Co-developed-by: Eric Joyner <eric.joyner@intel.com>
Signed-off-by: Eric Joyner <eric.joyner@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
---
v3: add SPDX identification to ice_hwmon files
v2: fix formmating issues, added hwmon maintainers to Cc
---
 drivers/net/ethernet/intel/ice/Makefile       |   1 +
 drivers/net/ethernet/intel/ice/ice.h          |   1 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  28 ++++
 drivers/net/ethernet/intel/ice/ice_common.c   |  57 +++++++-
 drivers/net/ethernet/intel/ice/ice_common.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_hwmon.c    | 130 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_hwmon.h    |  10 ++
 drivers/net/ethernet/intel/ice/ice_main.c     |   5 +
 drivers/net/ethernet/intel/ice/ice_type.h     |   4 +
 9 files changed, 237 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_hwmon.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_hwmon.h

diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index 8757bec23fb3..b4c8f5303e57 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -36,6 +36,7 @@ ice-y := ice_main.o	\
 	 ice_repr.o	\
 	 ice_tc_lib.o	\
 	 ice_fwlog.o	\
+	 ice_hwmon.o	\
 	 ice_debugfs.o
 ice-$(CONFIG_PCI_IOV) +=	\
 	ice_sriov.o		\
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index ad5614d4449c..61d26be502b2 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -650,6 +650,7 @@ struct ice_pf {
 #define ICE_MAX_VF_AGG_NODES		32
 	struct ice_agg_node vf_agg_node[ICE_MAX_VF_AGG_NODES];
 	struct ice_dplls dplls;
+	struct device *hwmon_dev;
 };
 
 extern struct workqueue_struct *ice_lag_wq;
diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 1202abfb9eb3..3c4295f8e4ba 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -117,6 +117,7 @@ struct ice_aqc_list_caps_elem {
 #define ICE_AQC_CAPS_NET_VER				0x004C
 #define ICE_AQC_CAPS_PENDING_NET_VER			0x004D
 #define ICE_AQC_CAPS_RDMA				0x0051
+#define ICE_AQC_CAPS_SENSOR_READING			0x0067
 #define ICE_AQC_CAPS_PCIE_RESET_AVOIDANCE		0x0076
 #define ICE_AQC_CAPS_POST_UPDATE_RESET_RESTRICT		0x0077
 #define ICE_AQC_CAPS_NVM_MGMT				0x0080
@@ -1393,6 +1394,30 @@ struct ice_aqc_get_phy_rec_clk_out {
 	__le16 node_handle;
 };
 
+/* Get sensor reading (direct 0x0632) */
+struct ice_aqc_get_sensor_reading {
+	u8 sensor;
+	u8 format;
+	u8 reserved[6];
+	__le32 addr_high;
+	__le32 addr_low;
+};
+
+/* Get sensor reading response (direct 0x0632) */
+struct ice_aqc_get_sensor_reading_resp {
+	union {
+		u8 raw[8];
+		/* Output data for sensor 0x00, format 0x00 */
+		struct {
+			s8 temp;
+			u8 temp_warning_threshold;
+			u8 temp_critical_threshold;
+			u8 temp_fatal_threshold;
+			u8 reserved[4];
+		} s0f0;
+	} data;
+};
+
 struct ice_aqc_link_topo_params {
 	u8 lport_num;
 	u8 lport_num_valid;
@@ -2438,6 +2463,8 @@ struct ice_aq_desc {
 		struct ice_aqc_restart_an restart_an;
 		struct ice_aqc_set_phy_rec_clk_out set_phy_rec_clk_out;
 		struct ice_aqc_get_phy_rec_clk_out get_phy_rec_clk_out;
+		struct ice_aqc_get_sensor_reading get_sensor_reading;
+		struct ice_aqc_get_sensor_reading_resp get_sensor_reading_resp;
 		struct ice_aqc_gpio read_write_gpio;
 		struct ice_aqc_sff_eeprom read_write_sff_param;
 		struct ice_aqc_set_port_id_led set_port_id_led;
@@ -2617,6 +2644,7 @@ enum ice_adminq_opc {
 	ice_aqc_opc_set_mac_lb				= 0x0620,
 	ice_aqc_opc_set_phy_rec_clk_out			= 0x0630,
 	ice_aqc_opc_get_phy_rec_clk_out			= 0x0631,
+	ice_aqc_opc_get_sensor_reading			= 0x0632,
 	ice_aqc_opc_get_link_topo			= 0x06E0,
 	ice_aqc_opc_read_i2c				= 0x06E2,
 	ice_aqc_opc_write_i2c				= 0x06E3,
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 283492314215..e566485a01b2 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2462,6 +2462,26 @@ ice_parse_fdir_dev_caps(struct ice_hw *hw, struct ice_hw_dev_caps *dev_p,
 		  dev_p->num_flow_director_fltr);
 }
 
+/**
+ * ice_parse_sensor_reading_cap - Parse ICE_AQC_CAPS_SENSOR_READING cap
+ * @hw: pointer to the HW struct
+ * @dev_p: pointer to device capabilities structure
+ * @cap: capability element to parse
+ *
+ * Parse ICE_AQC_CAPS_SENSOR_READING for device capability for reading
+ * enabled sensors.
+ */
+static void
+ice_parse_sensor_reading_cap(struct ice_hw *hw, struct ice_hw_dev_caps *dev_p,
+			     struct ice_aqc_list_caps_elem *cap)
+{
+	dev_p->supported_sensors = le32_to_cpu(cap->number);
+
+	ice_debug(hw, ICE_DBG_INIT,
+		  "dev caps: supported sensors (bitmap) = 0x%x\n",
+		  dev_p->supported_sensors);
+}
+
 /**
  * ice_parse_dev_caps - Parse device capabilities
  * @hw: pointer to the HW struct
@@ -2507,9 +2527,12 @@ ice_parse_dev_caps(struct ice_hw *hw, struct ice_hw_dev_caps *dev_p,
 		case ICE_AQC_CAPS_1588:
 			ice_parse_1588_dev_caps(hw, dev_p, &cap_resp[i]);
 			break;
-		case  ICE_AQC_CAPS_FD:
+		case ICE_AQC_CAPS_FD:
 			ice_parse_fdir_dev_caps(hw, dev_p, &cap_resp[i]);
 			break;
+		case ICE_AQC_CAPS_SENSOR_READING:
+			ice_parse_sensor_reading_cap(hw, dev_p, &cap_resp[i]);
+			break;
 		default:
 			/* Don't list common capabilities as unknown */
 			if (!found)
@@ -5292,6 +5315,38 @@ ice_aq_get_phy_rec_clk_out(struct ice_hw *hw, u8 *phy_output, u8 *port_num,
 	return status;
 }
 
+/**
+ * ice_aq_get_sensor_reading
+ * @hw: pointer to the HW struct
+ * @sensor: sensor type
+ * @format: requested response format
+ * @data: pointer to data to be read from the sensor
+ *
+ * Get sensor reading (0x0632)
+ */
+int ice_aq_get_sensor_reading(struct ice_hw *hw, u8 sensor, u8 format,
+			      struct ice_aqc_get_sensor_reading_resp *data)
+{
+	struct ice_aqc_get_sensor_reading *cmd;
+	struct ice_aq_desc desc;
+	int status;
+
+	if (!data)
+		return -EINVAL;
+
+	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_get_sensor_reading);
+	cmd = &desc.params.get_sensor_reading;
+	cmd->sensor = sensor;
+	cmd->format = format;
+
+	status = ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
+	if (!status)
+		memcpy(data, &desc.params.get_sensor_reading_resp,
+		       sizeof(*data));
+
+	return status;
+}
+
 /**
  * ice_replay_pre_init - replay pre initialization
  * @hw: pointer to the HW struct
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 4a75c0c89301..e23787c17505 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -240,6 +240,8 @@ ice_aq_set_phy_rec_clk_out(struct ice_hw *hw, u8 phy_output, bool enable,
 int
 ice_aq_get_phy_rec_clk_out(struct ice_hw *hw, u8 *phy_output, u8 *port_num,
 			   u8 *flags, u16 *node_handle);
+int ice_aq_get_sensor_reading(struct ice_hw *hw, u8 sensor, u8 format,
+			      struct ice_aqc_get_sensor_reading_resp *data);
 void
 ice_stat_update40(struct ice_hw *hw, u32 reg, bool prev_stat_loaded,
 		  u64 *prev_stat, u64 *cur_stat);
diff --git a/drivers/net/ethernet/intel/ice/ice_hwmon.c b/drivers/net/ethernet/intel/ice/ice_hwmon.c
new file mode 100644
index 000000000000..6b23ae27169c
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_hwmon.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2022, Intel Corporation. */
+
+#include "ice.h"
+#include "ice_hwmon.h"
+#include "ice_adminq_cmd.h"
+
+#include <linux/hwmon.h>
+
+#define ICE_INTERNAL_TEMP_SENSOR 0
+#define ICE_INTERNAL_TEMP_SENSOR_FORMAT 0
+
+#define TEMP_FROM_REG(reg) ((reg) * 1000)
+
+static const struct hwmon_channel_info *ice_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_MAX |
+			   HWMON_T_CRIT | HWMON_T_EMERGENCY),
+	NULL
+};
+
+static int ice_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			  u32 attr, int channel, long *val)
+{
+	struct ice_aqc_get_sensor_reading_resp resp;
+	struct ice_pf *pf = dev_get_drvdata(dev);
+	int ret;
+
+	if (type != hwmon_temp)
+		return -EOPNOTSUPP;
+
+	ret = ice_aq_get_sensor_reading(&pf->hw,
+					ICE_INTERNAL_TEMP_SENSOR,
+					ICE_INTERNAL_TEMP_SENSOR_FORMAT,
+					&resp);
+	if (ret) {
+		dev_warn(dev, "%s HW read failure (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	switch (attr) {
+	case hwmon_temp_input:
+		*val = TEMP_FROM_REG(resp.data.s0f0.temp);
+		break;
+	case hwmon_temp_max:
+		*val = TEMP_FROM_REG(resp.data.s0f0.temp_warning_threshold);
+		break;
+	case hwmon_temp_crit:
+		*val = TEMP_FROM_REG(resp.data.s0f0.temp_critical_threshold);
+		break;
+	case hwmon_temp_emergency:
+		*val = TEMP_FROM_REG(resp.data.s0f0.temp_fatal_threshold);
+		break;
+	default:
+		dev_warn(dev, "%s unsupported attribute (%d)\n",
+			 __func__, attr);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static umode_t ice_hwmon_is_visible(const void *data,
+				    enum hwmon_sensor_types type, u32 attr,
+				    int channel)
+{
+	if (type != hwmon_temp)
+		return 0;
+
+	switch (attr) {
+	case hwmon_temp_input:
+	case hwmon_temp_crit:
+	case hwmon_temp_max:
+	case hwmon_temp_emergency:
+		return 0444;
+	}
+
+	return 0;
+}
+
+static const struct hwmon_ops ice_hwmon_ops = {
+	.is_visible = ice_hwmon_is_visible,
+	.read = ice_hwmon_read
+};
+
+static const struct hwmon_chip_info ice_chip_info = {
+	.ops = &ice_hwmon_ops,
+	.info = ice_hwmon_info
+};
+
+static bool ice_is_internal_reading_supported(struct ice_pf *pf)
+{
+	if (pf->hw.pf_id)
+		return false;
+
+	unsigned long sensors = pf->hw.dev_caps.supported_sensors;
+
+	if (!_test_bit(ICE_SENSOR_SUPPORT_E810_INT_TEMP_BIT, &sensors))
+		return false;
+
+	return true;
+};
+
+void ice_hwmon_init(struct ice_pf *pf)
+{
+	struct device *dev = ice_pf_to_dev(pf);
+	struct device *hdev;
+
+	if (!ice_is_internal_reading_supported(pf))
+		return;
+
+	hdev = hwmon_device_register_with_info(dev, "ice", pf, &ice_chip_info,
+					       NULL);
+	if (IS_ERR(hdev)) {
+		dev_warn(dev,
+			 "hwmon_device_register_with_info returns error (%ld)",
+			 PTR_ERR(hdev));
+		return;
+	}
+	pf->hwmon_dev = hdev;
+}
+
+void ice_hwmon_exit(struct ice_pf *pf)
+{
+	if (!ice_is_internal_reading_supported(pf))
+		return;
+	if (!pf->hwmon_dev)
+		return;
+	hwmon_device_unregister(pf->hwmon_dev);
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_hwmon.h b/drivers/net/ethernet/intel/ice/ice_hwmon.h
new file mode 100644
index 000000000000..8c74d19933d7
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_hwmon.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2022, Intel Corporation. */
+
+#ifndef _ICE_HWMON_H_
+#define _ICE_HWMON_H_
+
+void ice_hwmon_init(struct ice_pf *pf);
+void ice_hwmon_exit(struct ice_pf *pf);
+
+#endif /* _ICE_HWMON_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index afe19219a640..8f7e901a6c95 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -14,6 +14,7 @@
 #include "ice_dcb_lib.h"
 #include "ice_dcb_nl.h"
 #include "ice_devlink.h"
+#include "ice_hwmon.h"
 /* Including ice_trace.h with CREATE_TRACE_POINTS defined will generate the
  * ice tracepoint functions. This must be done exactly once across the
  * ice driver.
@@ -4785,6 +4786,8 @@ static void ice_init_features(struct ice_pf *pf)
 
 	if (ice_init_lag(pf))
 		dev_warn(dev, "Failed to init link aggregation support\n");
+
+	ice_hwmon_init(pf);
 }
 
 static void ice_deinit_features(struct ice_pf *pf)
@@ -5310,6 +5313,8 @@ static void ice_remove(struct pci_dev *pdev)
 		ice_free_vfs(pf);
 	}
 
+	ice_hwmon_exit(pf);
+
 	ice_service_task_stop(pf);
 	ice_aq_cancel_waiting_tasks(pf);
 	set_bit(ICE_DOWN, pf->state);
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 877a92099ef0..0b5425d33adf 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -378,6 +378,8 @@ struct ice_hw_func_caps {
 	struct ice_ts_func_info ts_func_info;
 };
 
+#define ICE_SENSOR_SUPPORT_E810_INT_TEMP_BIT	0
+
 /* Device wide capabilities */
 struct ice_hw_dev_caps {
 	struct ice_hw_common_caps common_cap;
@@ -386,6 +388,8 @@ struct ice_hw_dev_caps {
 	u32 num_flow_director_fltr;	/* Number of FD filters available */
 	struct ice_ts_dev_info ts_dev_info;
 	u32 num_funcs;
+	/* bitmap of supported sensors */
+	u32 supported_sensors;
 };
 
 /* MAC info */

base-commit: 2318d58f358e7aef726c038aff87a68bec8f09e0
-- 
2.35.3


