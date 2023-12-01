Return-Path: <netdev+bounces-53033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC58580123C
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 19:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C871C20BCD
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16534F1FD;
	Fri,  1 Dec 2023 18:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jzHnAPS5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13DA106;
	Fri,  1 Dec 2023 10:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701454136; x=1732990136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X6oDrCudoe+j2q/7MS4iic+x0BAWts2PQMsDf+Rb5s4=;
  b=jzHnAPS5dkp/VKrwtnQoculSoS4tEVrjGP6n8gvBB7iToZJWqhrZGB6h
   mu5f4WodLgVT5ypXHAS5KMDmigJkgcXbSJgt/vWlVS8FrLl8LyEr36CXM
   Sgnej0MFACixLoDbwur6/9Ti/KfqZtkPHIUDRtfVmehT5lev8OA+PDENR
   wQ8hhSoB+VPyXNB0PI99vkx54TBp3FnO8R6h7lQfuqhuMLEIZ9mG5SKaR
   FCQbK/DonkF/81H2ZulOgxk5imzE6j7rTQorrMEzWvvyu/kNXxffC4TCD
   zVSA/AB8ybtwaYI94JqOW8zCHySfweQ2QjEa93w0Ki8TU432EzvnGsY7B
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="12244386"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="12244386"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 10:08:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="893272438"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="893272438"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 01 Dec 2023 10:08:54 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Konrad Knitter <konrad.knitter@intel.com>,
	anthony.l.nguyen@intel.com,
	jdelvare@suse.com,
	linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	Marcin Domagala <marcinx.domagala@intel.com>,
	Eric Joyner <eric.joyner@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 1/6] ice: read internal temperature sensor
Date: Fri,  1 Dec 2023 10:08:39 -0800
Message-ID: <20231201180845.219494-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231201180845.219494-1-anthony.l.nguyen@intel.com>
References: <20231201180845.219494-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Konrad Knitter <konrad.knitter@intel.com>

Since 4.30 firmware exposes internal thermal sensor reading via admin
queue commands. Expose those readouts via hwmon API when supported.

Datasheet:

Get Sensor Reading Command (Opcode: 0x0632)

+--------------------+--------+--------------------+-------------------------+
| Name               | Bytes  | Value              |          Remarks        |
+--------------------+--------+--------------------+-------------------------+
| Flags              | 1-0    |                    |                         |
| Opcode             | 2-3    | 0x0632             | Command opcode          |
| Datalen            | 4-5    | 0                  | No external buffer.     |
| Return value       | 6-7    |                    | Return value.           |
| Cookie High        | 8-11   | Cookie             |                         |
| Cookie Low         | 12-15  | Cookie             |                         |
| Sensor             | 16     |                    | 0x00: Internal temp     |
|                    |        |                    | 0x01-0xFF: Reserved.    |
| Format             | 17     | Requested response | Only 0x00 is supported. |
|                    |        | format             | 0x01-0xFF: Reserved.    |
| Reserved           | 18-23  |                    |                         |
| Data Address high  | 24-27  | Response buffer    |                         |
|                    |        | address            |                         |
| Data Address low   | 28-31  | Response buffer    |                         |
|                    |        | address            |                         |
+--------------------+--------+--------------------+-------------------------+

Get Sensor Reading Response (Opcode: 0x0632)

+--------------------+--------+--------------------+-------------------------+
| Name               | Bytes  | Value              |          Remarks        |
+--------------------+--------+--------------------+-------------------------+
| Flags              | 1-0    |                    |                         |
| Opcode             | 2-3    | 0x0632             | Command opcode          |
| Datalen            | 4-5    | 0                  | No external buffer      |
| Return value       | 6-7    |                    | Return value.           |
|                    |        |                    | EINVAL: Invalid         |
|                    |        |                    | parameters              |
|                    |        |                    | ENOENT: Unsupported     |
|                    |        |                    | sensor                  |
|                    |        |                    | EIO: Sensor access      |
|                    |        |                    | error                   |
| Cookie High        | 8-11   | Cookie             |                         |
| Cookie Low         | 12-15  | Cookie             |                         |
| Sensor Reading     | 16-23  |                    | Format of the reading   |
|                    |        |                    | is dependent on request |
| Data Address high  | 24-27  | Response buffer    |                         |
|                    |        | address            |                         |
| Data Address low   | 28-31  | Response buffer    |                         |
|                    |        | address            |                         |
+--------------------+--------+--------------------+-------------------------+

Sensor Reading for Sensor 0x00 (Internal Chip Temperature):

+--------------------+--------+--------------------+-------------------------+
| Name               | Bytes  | Value              |          Remarks        |
+--------------------+--------+--------------------+-------------------------+
| Thermal Sensor     | 0      |                    | Reading in degrees      |
| reading            |        |                    | Celsius. Signed int8    |
| Warning High       | 1      |                    | Warning High threshold  |
| threshold          |        |                    | in degrees Celsius.     |
|                    |        |                    | Unsigned int8.          |
|                    |        |                    | 0xFF when unsupported   |
| Critical High      | 2      |                    | Critical High threshold |
| threshold          |        |                    | in degrees Celsius.     |
|                    |        |                    | Unsigned int8.          |
|                    |        |                    | 0xFF when unsupported   |
| Fatal High         | 3      |                    | Fatal High threshold    |
| threshold          |        |                    | in degrees Celsius.     |
|                    |        |                    | Unsigned int8.          |
|                    |        |                    | 0xFF when unsupported   |
| Reserved           | 4-7    |                    |                         |
+--------------------+--------+--------------------+-------------------------+

Driver provides current reading from HW as well as device specific
thresholds for thermal alarm (Warning, Critical, Fatal) events.

$ sensors

Output
=========================================================
ice-pci-b100
Adapter: PCI adapter
temp1:        +62.0°C  (high = +95.0°C, crit = +105.0°C)
                       (emerg = +115.0°C)

Tested on Intel Corporation Ethernet Controller E810-C for SFP

Co-developed-by: Marcin Domagala <marcinx.domagala@intel.com>
Signed-off-by: Marcin Domagala <marcinx.domagala@intel.com>
Co-developed-by: Eric Joyner <eric.joyner@intel.com>
Signed-off-by: Eric Joyner <eric.joyner@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/Kconfig            |  11 ++
 drivers/net/ethernet/intel/ice/Makefile       |   1 +
 drivers/net/ethernet/intel/ice/ice.h          |   1 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  28 ++++
 drivers/net/ethernet/intel/ice/ice_common.c   |  54 +++++++-
 drivers/net/ethernet/intel/ice/ice_common.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_hwmon.c    | 126 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_hwmon.h    |  15 +++
 drivers/net/ethernet/intel/ice/ice_main.c     |   5 +
 drivers/net/ethernet/intel/ice/ice_type.h     |   7 +
 10 files changed, 249 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_hwmon.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_hwmon.h

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 06ddd7147c7f..d55638ad8704 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -299,6 +299,17 @@ config ICE
 	  To compile this driver as a module, choose M here. The module
 	  will be called ice.
 
+config ICE_HWMON
+	bool "Intel(R) Ethernet Connection E800 Series Support HWMON support"
+	default y
+	depends on ICE && HWMON && !(ICE=y && HWMON=m)
+	help
+	  Say Y if you want to expose thermal sensor data on Intel devices.
+
+	  Some of our devices contain internal thermal sensors.
+	  This data is available via the hwmon sysfs interface and exposes
+	  the onboard sensors.
+
 config ICE_SWITCHDEV
 	bool "Switchdev Support"
 	default y
diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index 0679907980f7..b40b4179b9f4 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -49,3 +49,4 @@ ice-$(CONFIG_RFS_ACCEL) += ice_arfs.o
 ice-$(CONFIG_XDP_SOCKETS) += ice_xsk.o
 ice-$(CONFIG_ICE_SWITCHDEV) += ice_eswitch.o ice_eswitch_br.o
 ice-$(CONFIG_GNSS) += ice_gnss.o
+ice-$(CONFIG_ICE_HWMON) += ice_hwmon.o
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index cd7dcd0fa7f2..3ea33947b878 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -655,6 +655,7 @@ struct ice_pf {
 #define ICE_MAX_VF_AGG_NODES		32
 	struct ice_agg_node vf_agg_node[ICE_MAX_VF_AGG_NODES];
 	struct ice_dplls dplls;
+	struct device *hwmon_dev;
 };
 
 extern struct workqueue_struct *ice_lag_wq;
diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index d7fdb7ba7268..f77a3c70f262 100644
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
@@ -1413,6 +1414,30 @@ struct ice_aqc_get_phy_rec_clk_out {
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
+		struct _packed {
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
@@ -2443,6 +2468,8 @@ struct ice_aq_desc {
 		struct ice_aqc_restart_an restart_an;
 		struct ice_aqc_set_phy_rec_clk_out set_phy_rec_clk_out;
 		struct ice_aqc_get_phy_rec_clk_out get_phy_rec_clk_out;
+		struct ice_aqc_get_sensor_reading get_sensor_reading;
+		struct ice_aqc_get_sensor_reading_resp get_sensor_reading_resp;
 		struct ice_aqc_gpio read_write_gpio;
 		struct ice_aqc_sff_eeprom read_write_sff_param;
 		struct ice_aqc_set_port_id_led set_port_id_led;
@@ -2618,6 +2645,7 @@ enum ice_adminq_opc {
 	ice_aqc_opc_set_mac_lb				= 0x0620,
 	ice_aqc_opc_set_phy_rec_clk_out			= 0x0630,
 	ice_aqc_opc_get_phy_rec_clk_out			= 0x0631,
+	ice_aqc_opc_get_sensor_reading			= 0x0632,
 	ice_aqc_opc_get_link_topo			= 0x06E0,
 	ice_aqc_opc_read_i2c				= 0x06E2,
 	ice_aqc_opc_write_i2c				= 0x06E3,
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 9a6c25f98632..8d97434e1413 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2710,6 +2710,26 @@ ice_parse_fdir_dev_caps(struct ice_hw *hw, struct ice_hw_dev_caps *dev_p,
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
@@ -2755,9 +2775,12 @@ ice_parse_dev_caps(struct ice_hw *hw, struct ice_hw_dev_caps *dev_p,
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
@@ -5540,6 +5563,35 @@ ice_aq_get_phy_rec_clk_out(struct ice_hw *hw, u8 *phy_output, u8 *port_num,
 	return status;
 }
 
+/**
+ * ice_aq_get_sensor_reading
+ * @hw: pointer to the HW struct
+ * @data: pointer to data to be read from the sensor
+ *
+ * Get sensor reading (0x0632)
+ */
+int ice_aq_get_sensor_reading(struct ice_hw *hw,
+			      struct ice_aqc_get_sensor_reading_resp *data)
+{
+	struct ice_aqc_get_sensor_reading *cmd;
+	struct ice_aq_desc desc;
+	int status;
+
+	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_get_sensor_reading);
+	cmd = &desc.params.get_sensor_reading;
+#define ICE_INTERNAL_TEMP_SENSOR_FORMAT	0
+#define ICE_INTERNAL_TEMP_SENSOR	0
+	cmd->sensor = ICE_INTERNAL_TEMP_SENSOR;
+	cmd->format = ICE_INTERNAL_TEMP_SENSOR_FORMAT;
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
index 31fdcac33986..5f7aa293d4ae 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -241,6 +241,8 @@ ice_aq_set_phy_rec_clk_out(struct ice_hw *hw, u8 phy_output, bool enable,
 int
 ice_aq_get_phy_rec_clk_out(struct ice_hw *hw, u8 *phy_output, u8 *port_num,
 			   u8 *flags, u16 *node_handle);
+int ice_aq_get_sensor_reading(struct ice_hw *hw,
+			      struct ice_aqc_get_sensor_reading_resp *data);
 void
 ice_stat_update40(struct ice_hw *hw, u32 reg, bool prev_stat_loaded,
 		  u64 *prev_stat, u64 *cur_stat);
diff --git a/drivers/net/ethernet/intel/ice/ice_hwmon.c b/drivers/net/ethernet/intel/ice/ice_hwmon.c
new file mode 100644
index 000000000000..e4c2c1bff6c0
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_hwmon.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023, Intel Corporation. */
+
+#include "ice.h"
+#include "ice_hwmon.h"
+#include "ice_adminq_cmd.h"
+
+#include <linux/hwmon.h>
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
+	ret = ice_aq_get_sensor_reading(&pf->hw, &resp);
+	if (ret) {
+		dev_warn_ratelimited(dev,
+				     "%s HW read failure (%d)\n",
+				     __func__,
+				     ret);
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
+		dev_dbg(dev, "%s unsupported attribute (%d)\n",
+			__func__, attr);
+		return -EOPNOTSUPP;
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
+	/* Only the first PF will report temperature for a chip.
+	 * Note that internal temp reading is not supported
+	 * for older FW (< v4.30).
+	 */
+	if (pf->hw.pf_id)
+		return false;
+
+	unsigned long sensors = pf->hw.dev_caps.supported_sensors;
+
+	return _test_bit(ICE_SENSOR_SUPPORT_E810_INT_TEMP_BIT, &sensors);
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
+	if (!pf->hwmon_dev)
+		return;
+	hwmon_device_unregister(pf->hwmon_dev);
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_hwmon.h b/drivers/net/ethernet/intel/ice/ice_hwmon.h
new file mode 100644
index 000000000000..d66d40354f5a
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_hwmon.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023, Intel Corporation. */
+
+#ifndef _ICE_HWMON_H_
+#define _ICE_HWMON_H_
+
+#ifdef CONFIG_ICE_HWMON
+void ice_hwmon_init(struct ice_pf *pf);
+void ice_hwmon_exit(struct ice_pf *pf);
+#else /* CONFIG_ICE_HWMON */
+static inline void ice_hwmon_init(struct ice_pf *pf) { }
+static inline void ice_hwmon_exit(struct ice_pf *pf) { }
+#endif /* CONFIG_ICE_HWMON */
+
+#endif /* _ICE_HWMON_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 43ba3e55b8c1..b8ad414dac47 100644
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
@@ -4685,6 +4686,8 @@ static void ice_init_features(struct ice_pf *pf)
 
 	if (ice_init_lag(pf))
 		dev_warn(dev, "Failed to init link aggregation support\n");
+
+	ice_hwmon_init(pf);
 }
 
 static void ice_deinit_features(struct ice_pf *pf)
@@ -5210,6 +5213,8 @@ static void ice_remove(struct pci_dev *pdev)
 		ice_free_vfs(pf);
 	}
 
+	ice_hwmon_exit(pf);
+
 	ice_service_task_stop(pf);
 	ice_aq_cancel_waiting_tasks(pf);
 	set_bit(ICE_DOWN, pf->state);
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index a18ca0ff879f..5a80158e49ed 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -377,6 +377,8 @@ struct ice_hw_func_caps {
 	struct ice_ts_func_info ts_func_info;
 };
 
+#define ICE_SENSOR_SUPPORT_E810_INT_TEMP_BIT	0
+
 /* Device wide capabilities */
 struct ice_hw_dev_caps {
 	struct ice_hw_common_caps common_cap;
@@ -385,6 +387,11 @@ struct ice_hw_dev_caps {
 	u32 num_flow_director_fltr;	/* Number of FD filters available */
 	struct ice_ts_dev_info ts_dev_info;
 	u32 num_funcs;
+	/* bitmap of supported sensors
+	 * bit 0 - internal temperature sensor
+	 * bit 31:1 - Reserved
+	 */
+	u32 supported_sensors;
 };
 
 /* MAC info */
-- 
2.41.0


