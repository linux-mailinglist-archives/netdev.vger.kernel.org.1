Return-Path: <netdev+bounces-90923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7A48B0B47
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 15:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027E82823F6
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 13:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C43A15EFC0;
	Wed, 24 Apr 2024 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jeWxm0tr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F6815EFAA
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965885; cv=none; b=g1Uk0Zek8hOgQCyxF6E0OSitfCzWQCyelSDNZdkrzSJKGd7qi7iato4C0wFWDEbhwFDcNlf3A1M4O2j0NahnwgCjZSOncjOsw0x177WlzyuFCuCBD8f0WSxTgkqOG43ctcakTqc7enOXU4hwXYQDis5wVPkva5wXC4wM1c/Ponw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965885; c=relaxed/simple;
	bh=WHGksUCw2van3vja+RvHfGk3dTU+4lfcucDK0sX8ZEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FngoNRgVLt01FwhYw3d97V8VbhMwu/nu9zoNlZ201qg9ccbWsbIjvrQGJG4H4Q5/0+BkEf/W9djOozIybc7Xfl4sVhj9HXHZioEdtbV9jw+OAdvTdw0qK4H3SkgjZyuVYFIrJO/j15fOJtLQQBf3H8rtgPI2Z9LgBC6/739drzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jeWxm0tr; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713965884; x=1745501884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WHGksUCw2van3vja+RvHfGk3dTU+4lfcucDK0sX8ZEA=;
  b=jeWxm0troLVihVPeBF2SRKlS1Hd7jS8mPMx1/8YmcNAhda8J2mQ1Spag
   obaYiVWM9JouY6FftAbdXxC76gVGE4LIGAQOWxlYYA4i1hOp6nwc61fRB
   FfhTXLLSne3GWSHxomj+x4lxKAwLJOdgMitKDgoKsaknd0Qk1ToQJln94
   sGLtvh3/1I9Napd+E1fTgL/7NNny+DNoFEzIa1g6NYGrkZpERIcPd3W65
   2gltxbcxYMrCRCjzA2IkF+1hTEb58JY46URGPQWr0+YuERXkpErPqn0AW
   +/uNUTPIoDs5lK4gZKmHQ3lFQXc8Jt9KwIgbIEj1+Ft2EwNwE8CmjDNJF
   Q==;
X-CSE-ConnectionGUID: 0Fk58IXXQTGPR7zW3ce78g==
X-CSE-MsgGUID: ZbXhH8aBTFS9vlpb+2pYyA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="27110500"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="27110500"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 06:38:03 -0700
X-CSE-ConnectionGUID: 48H5X69yS/K6MpN6oEiyXQ==
X-CSE-MsgGUID: Eucl3E22TPyUPL1s1UUzNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="24601268"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orviesa010.jf.intel.com with ESMTP; 24 Apr 2024 06:37:58 -0700
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
Subject: [PATCH v10 iwl-next 10/12] ice: Add NAC Topology device capability parser
Date: Wed, 24 Apr 2024 15:30:18 +0200
Message-ID: <20240424133542.113933-25-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240424133542.113933-16-karol.kolacinski@intel.com>
References: <20240424133542.113933-16-karol.kolacinski@intel.com>
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
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  2 ++
 drivers/net/ethernet/intel/ice/ice_common.c   | 31 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_type.h     | 10 ++++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 540c0bdca936..4c125e06310a 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -121,6 +121,8 @@ struct ice_aqc_list_caps_elem {
 #define ICE_AQC_CAPS_PCIE_RESET_AVOIDANCE		0x0076
 #define ICE_AQC_CAPS_POST_UPDATE_RESET_RESTRICT		0x0077
 #define ICE_AQC_CAPS_NVM_MGMT				0x0080
+#define ICE_AQC_CAPS_TX_SCHED_TOPO_COMP_MODE		0x0085
+#define ICE_AQC_CAPS_NAC_TOPOLOGY			0x0087
 #define ICE_AQC_CAPS_FW_LAG_SUPPORT			0x0092
 #define ICE_AQC_BIT_ROCEV2_LAG				0x01
 #define ICE_AQC_BIT_SRIOV_LAG				0x02
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index b225f4a8bc21..3e4db33f9d40 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2588,6 +2588,34 @@ ice_parse_sensor_reading_cap(struct ice_hw *hw, struct ice_hw_dev_caps *dev_p,
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
@@ -2639,6 +2667,9 @@ ice_parse_dev_caps(struct ice_hw *hw, struct ice_hw_dev_caps *dev_p,
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
index 62ff21b3ee22..f4eb0d03ee4f 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -373,6 +373,15 @@ struct ice_ts_dev_info {
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
@@ -394,6 +403,7 @@ struct ice_hw_dev_caps {
 	u32 num_flow_director_fltr;	/* Number of FD filters available */
 	struct ice_ts_dev_info ts_dev_info;
 	u32 num_funcs;
+	struct ice_nac_topology nac_topo;
 	/* bitmap of supported sensors
 	 * bit 0 - internal temperature sensor
 	 * bit 31:1 - Reserved
-- 
2.43.0


