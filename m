Return-Path: <netdev+bounces-54591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 680208078A9
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 20:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4AC6282117
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 19:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D48147F55;
	Wed,  6 Dec 2023 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJQYIILt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4615FEE
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 11:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701890968; x=1733426968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DHcFzeyn/0o/6C2beC5UYTv9p7T0PqHMseFDRQAj34Y=;
  b=ZJQYIILtWFx7xli8aMQntbOtSZ0TDOW6AaHBWij7vhF0m/y3/BWKKhGA
   H2atinfDfPzdHsNopaUlMqSN2su0nSfRwHKqoxFZ+UaFWTnv3YRzGuhsf
   M8OM+LhUk/NSEMdGbQCvT/rY0qzPgk4MDtd6YAa7lwu6z7KfQZRuIJG6Z
   PCj/jbPBT80Ans5i3+I80T8jyZ8A1+o823AmVmQ0oA9bJtxKtP2byvyoI
   qGhsIHr0h+YgxLr/Bb7mxBjzgrVXFQnJ0gnCg/PcCgQ5ID0xJybWGXR2w
   l8xCO4iTl1JwGfCo0FIjs99sKJPWm6pCSOVSVueK3f59IjLXyfvd2zZQC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1214425"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1214425"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 11:29:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="889446503"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="889446503"
Received: from unknown (HELO gklab-003-001.igk.intel.com) ([10.211.3.1])
  by fmsmga002.fm.intel.com with ESMTP; 06 Dec 2023 11:29:26 -0800
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Jan Glaza <jan.glaza@intel.com>,
	Michal Michalik <michal.michalik@intel.com>
Subject: [PATCH iwl-next v1 1/3] ice: introduce new E825C devices family
Date: Wed,  6 Dec 2023 20:29:17 +0100
Message-Id: <20231206192919.3826128-2-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231206192919.3826128-1-grzegorz.nitka@intel.com>
References: <20231206192919.3826128-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce new Intel Ethernet E825C family devices.
Add new PCI device IDs which are going to be supported by the
driver:
- 579C: Intel(R) Ethernet Connection E825-C for backplane
- 579D: Intel(R) Ethernet Connection E825-C for QSFP
- 579E: Intel(R) Ethernet Connection E825-C for SFP
- 579F: Intel(R) Ethernet Connection E825-C for SGMII

Add helper function ice_is_e825c() to verify if the running device
belongs to E825C family.

Co-developed-by: Jan Glaza <jan.glaza@intel.com>
Signed-off-by: Jan Glaza <jan.glaza@intel.com>
Co-developed-by: Michal Michalik <michal.michalik@intel.com>
Signed-off-by: Michal Michalik <michal.michalik@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 19 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_common.h |  1 +
 drivers/net/ethernet/intel/ice/ice_devids.h |  8 ++++++++
 drivers/net/ethernet/intel/ice/ice_main.c   |  4 ++++
 4 files changed, 32 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 41b0ac666cb9..0a519310472b 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -240,6 +240,25 @@ bool ice_is_e823(struct ice_hw *hw)
 	}
 }
 
+/**
+ * ice_is_e825c - Check if a device is E825C family device
+ * @hw: pointer to the hardware structure
+ *
+ * Return: true if the device is E825-C based, false if not.
+ */
+bool ice_is_e825c(struct ice_hw *hw)
+{
+	switch (hw->device_id) {
+	case ICE_DEV_ID_E825C_BACKPLANE:
+	case ICE_DEV_ID_E825C_QSFP:
+	case ICE_DEV_ID_E825C_SFP:
+	case ICE_DEV_ID_E825C_SGMII:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /**
  * ice_clear_pf_cfg - Clear PF configuration
  * @hw: pointer to the hardware structure
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 9696ed59d1a8..39be42ae3711 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -250,6 +250,7 @@ ice_stat_update32(struct ice_hw *hw, u32 reg, bool prev_stat_loaded,
 		  u64 *prev_stat, u64 *cur_stat);
 bool ice_is_e810t(struct ice_hw *hw);
 bool ice_is_e823(struct ice_hw *hw);
+bool ice_is_e825c(struct ice_hw *hw);
 int
 ice_sched_query_elem(struct ice_hw *hw, u32 node_teid,
 		     struct ice_aqc_txsched_elem_data *buf);
diff --git a/drivers/net/ethernet/intel/ice/ice_devids.h b/drivers/net/ethernet/intel/ice/ice_devids.h
index a2d384dbfc76..9dfae9bce758 100644
--- a/drivers/net/ethernet/intel/ice/ice_devids.h
+++ b/drivers/net/ethernet/intel/ice/ice_devids.h
@@ -71,5 +71,13 @@
 #define ICE_DEV_ID_E822L_10G_BASE_T	0x1899
 /* Intel(R) Ethernet Connection E822-L 1GbE */
 #define ICE_DEV_ID_E822L_SGMII		0x189A
+/* Intel(R) Ethernet Connection E825-C for backplane */
+#define ICE_DEV_ID_E825C_BACKPLANE	0x579c
+/* Intel(R) Ethernet Connection E825-C for QSFP */
+#define ICE_DEV_ID_E825C_QSFP		0x579d
+/* Intel(R) Ethernet Connection E825-C for SFP */
+#define ICE_DEV_ID_E825C_SFP		0x579e
+/* Intel(R) Ethernet Connection E825-C 1GbE */
+#define ICE_DEV_ID_E825C_SGMII		0x579f
 
 #endif /* _ICE_DEVIDS_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c04ee2255d95..0c3b64f65a0d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5774,6 +5774,10 @@ static const struct pci_device_id ice_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_1GBE) },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_QSFP) },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822_SI_DFLT) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E825C_BACKPLANE), },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E825C_QSFP), },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E825C_SFP), },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E825C_SGMII), },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_BACKPLANE) },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_QSFP56) },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_SFP) },
-- 
2.39.3


