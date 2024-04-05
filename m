Return-Path: <netdev+bounces-85158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAC5899A52
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 12:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE2D1B21A68
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 10:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FA1161931;
	Fri,  5 Apr 2024 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LTM6fxhs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753C71649D5
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712311644; cv=none; b=syv5y1fn5/tk23sKIYOuEhewVP1V4sL8gRllk69XwSwwNlzXTdz5sUYJFROL3HA2A5pHpfThA9Amj1J5IYlEFg7KtGdDEe5yn3N06vpLJfrEKTQZ+rSbC3ZViThP1RX2pJOup4Z6PmizjEu/DZrteEHsy9I0X2JT/LkirbsIDvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712311644; c=relaxed/simple;
	bh=IVBDs4L7Qd+JaeX6DTI07/w8MFx+zEAa5k58OsyrFq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbPxkZtSiaO04493bCr9hfPxmx13pm577cP1bUBzO3s27m2fn1jeuVmzXK2WuioHpjfOHFEfKdxeiXc3SJB+nunGZjRuiFoF4Y5XG845U3m/NGXcgmA2qJYDXTVhLzJbRQX1r6g/AgmrTcL5JwMMXde3s4EH6IkS4lLyArYotvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LTM6fxhs; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712311642; x=1743847642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IVBDs4L7Qd+JaeX6DTI07/w8MFx+zEAa5k58OsyrFq4=;
  b=LTM6fxhsCHGkBLMA5jAkNZcfjq0ckFNweKXR4aNgOeZuRagU4h0giXx1
   7Y8GXpd4O4sYtABt91vr4losJMEbKxZiEBkAl5XoeWP/ypfIm4NLVu7bI
   ZrEqnXf3Qf0XUjBTGjzOBWxCOQuTSzxy569l1g+SihlpUaVJqZ2WQBiLF
   CK3+DrP+2BA35+ZTR5u9eNyLaPqY4Lni31UpNKY49kSAPyhT3YYVkgiXc
   ujL67Ql5o0fcM3ILBQ0gvvzgzDz21998XuAfSu1QbByPAAjOjLWEo+8QB
   SEmT302HuxLQPyKIdJqhSbxmxUKi4LeKtYwrFA4ag+iHFaZ27z1iYLZmk
   Q==;
X-CSE-ConnectionGUID: 2Qams3HQR16tyP0pO9DM9Q==
X-CSE-MsgGUID: bYtWuPksS6G4XANoVlXB6Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7494017"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7494017"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 03:07:20 -0700
X-CSE-ConnectionGUID: ZFwg0/N4R72vkOA5bmZMbg==
X-CSE-MsgGUID: VQZUbGsPTl2nQSA3yeDioQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19536292"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orviesa007.jf.intel.com with ESMTP; 05 Apr 2024 03:07:19 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Prathisna Padmasanan <prathisna.padmasanan@intel.com>,
	Pawel Kaminski <pawel.kaminski@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v6 iwl-next 10/12] ice: Add NAC Topology device capability parser
Date: Fri,  5 Apr 2024 11:57:22 +0200
Message-ID: <20240405100648.144756-24-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240405100648.144756-14-karol.kolacinski@intel.com>
References: <20240405100648.144756-14-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

Add new device capability ICE_AQC_CAPS_NAC_TOPOLOGY which allows to
determine the mode of operation (1 or 2 NAC).
Define a new structure to store data from new capability and
corresponding parser code.

Co-developed-by: Prathisna Padmasanan <prathisna.padmasanan@intel.com>
Signed-off-by: Prathisna Padmasanan <prathisna.padmasanan@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Pawel Kaminski <pawel.kaminski@intel.com>
Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_common.c   | 31 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_type.h     | 10 ++++++
 3 files changed, 42 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 540c0bdca936..8eaf030a29c9 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -121,6 +121,7 @@ struct ice_aqc_list_caps_elem {
 #define ICE_AQC_CAPS_PCIE_RESET_AVOIDANCE		0x0076
 #define ICE_AQC_CAPS_POST_UPDATE_RESET_RESTRICT		0x0077
 #define ICE_AQC_CAPS_NVM_MGMT				0x0080
+#define ICE_AQC_CAPS_NAC_TOPOLOGY			0x0087
 #define ICE_AQC_CAPS_FW_LAG_SUPPORT			0x0092
 #define ICE_AQC_BIT_ROCEV2_LAG				0x01
 #define ICE_AQC_BIT_SRIOV_LAG				0x02
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 8ae257f8a191..d53e6794eace 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2583,6 +2583,34 @@ ice_parse_sensor_reading_cap(struct ice_hw *hw, struct ice_hw_dev_caps *dev_p,
 		  dev_p->supported_sensors);
 }
 
+/**
+ * ice_parse_nac_topo_dev_caps - Parse ICE_AQC_CAPS_NAC_TOPOLOGY cap
+ * @hw: pointer to the HW struct
+ * @dev_p: pointer to device capabilities structure
+ * @cap: capability element to parse
+ *
+ * Parse ICE_AQC_CAPS_NAC_TOPOLOGY for device capabilities.
+ */
+static void ice_parse_nac_topo_dev_caps(struct ice_hw *hw,
+					struct ice_hw_dev_caps *dev_p,
+					struct ice_aqc_list_caps_elem *cap)
+{
+	dev_p->nac_topo.mode = le32_to_cpu(cap->number);
+	dev_p->nac_topo.id = le32_to_cpu(cap->phys_id) & ICE_NAC_TOPO_ID_M;
+
+	dev_info(ice_hw_to_dev(hw),
+		 "PF is configured in %s mode with IP instance ID %d\n",
+		 (dev_p->nac_topo.mode & ICE_NAC_TOPO_PRIMARY_M) ?
+		 "primary" : "secondary", dev_p->nac_topo.id);
+
+	ice_debug(hw, ICE_DBG_INIT, "dev caps: nac topology is_primary = %d\n",
+		  !!(dev_p->nac_topo.mode & ICE_NAC_TOPO_PRIMARY_M));
+	ice_debug(hw, ICE_DBG_INIT, "dev caps: nac topology is_dual = %d\n",
+		  !!(dev_p->nac_topo.mode & ICE_NAC_TOPO_DUAL_M));
+	ice_debug(hw, ICE_DBG_INIT, "dev caps: nac topology id = %d\n",
+		  dev_p->nac_topo.id);
+}
+
 /**
  * ice_parse_dev_caps - Parse device capabilities
  * @hw: pointer to the HW struct
@@ -2634,6 +2662,9 @@ ice_parse_dev_caps(struct ice_hw *hw, struct ice_hw_dev_caps *dev_p,
 		case ICE_AQC_CAPS_SENSOR_READING:
 			ice_parse_sensor_reading_cap(hw, dev_p, &cap_resp[i]);
 			break;
+		case ICE_AQC_CAPS_NAC_TOPOLOGY:
+			ice_parse_nac_topo_dev_caps(hw, dev_p, &cap_resp[i]);
+			break;
 		default:
 			/* Don't list common capabilities as unknown */
 			if (!found)
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 2baf305a0c95..948c4bdbb206 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -372,6 +372,15 @@ struct ice_ts_dev_info {
 	u8 ts_ll_int_read;
 };
 
+#define ICE_NAC_TOPO_PRIMARY_M	BIT(0)
+#define ICE_NAC_TOPO_DUAL_M	BIT(1)
+#define ICE_NAC_TOPO_ID_M	GENMASK(0xF, 0)
+
+struct ice_nac_topology {
+	u32 mode;
+	u8 id;
+};
+
 /* Function specific capabilities */
 struct ice_hw_func_caps {
 	struct ice_hw_common_caps common_cap;
@@ -393,6 +402,7 @@ struct ice_hw_dev_caps {
 	u32 num_flow_director_fltr;	/* Number of FD filters available */
 	struct ice_ts_dev_info ts_dev_info;
 	u32 num_funcs;
+	struct ice_nac_topology nac_topo;
 	/* bitmap of supported sensors
 	 * bit 0 - internal temperature sensor
 	 * bit 31:1 - Reserved
-- 
2.43.0


