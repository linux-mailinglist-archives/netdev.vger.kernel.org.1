Return-Path: <netdev+bounces-29541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EE0783B07
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 09:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A0E281001
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 07:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C567079ED;
	Tue, 22 Aug 2023 07:36:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E1279DF
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 07:36:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087C0133
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 00:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692689785; x=1724225785;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bAcGHkc+BDZTeEBPWBUcR2G/1CyIxh7FabUDc3RWk80=;
  b=bssP91zwWmUpl84cVq7GTZtRn38nc1y9wqhtdxnpFdpLscFHTfYlbdAJ
   zfIHfnMWFJSptsGL+dcA30RwfLTYSDa0MNWXnUhyUNNgxbLvlQEOlmmpp
   fwSiGXu0tMbHD6gHOtKK0brmd7M0ery+Yv497u8K8WswReCmYDrzcUmT6
   8mxKz7cZolrVGWSROCq9OHTdhPh0SCnCab8f1wl4VcbZNEQH3SjmfWKPw
   6BtycoUNGL0UrzQQyh2UxYNV3pjVf66bGg/X6E3pRvGKzqviHqAVCyTU6
   Q2sYg8Al1yreE2jltGlLlHJ+uG/dlRII/JDli72z1Cmavqzk1GCPlJri1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="437723486"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="437723486"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 00:36:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="713060718"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="713060718"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga006.jf.intel.com with ESMTP; 22 Aug 2023 00:36:11 -0700
Received: from rozewie.igk.intel.com (rozewie.igk.intel.com [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id D5FD0333CE;
	Tue, 22 Aug 2023 08:36:10 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next] ice: Disable Cage Max Power override
Date: Tue, 22 Aug 2023 09:34:52 +0200
Message-Id: <20230822073452.28446-1-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

NVM module called "Cage Max Power override" allows to
change max power in the cage. This can be achieved
using external tools. The responsibility of the ice driver is to
go back to the default settings whenever port split is done.
This is achieved by clearing Override Enable bit in the
NVM module. Override of the max power is disabled so the
default value will be used.

Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  9 +++++
 drivers/net/ethernet/intel/ice/ice_devlink.c  | 35 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_nvm.c      |  2 +-
 drivers/net/ethernet/intel/ice/ice_nvm.h      |  4 +++
 4 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index ffbe9d3a5d77..a3a49d922650 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1569,6 +1569,15 @@ struct ice_aqc_nvm {
 	__le32 addr_low;
 };
 
+#define ICE_AQC_NVM_CMPO_MOD_ID			0x153
+
+/* Cage Max Power override NVM module */
+struct ice_aqc_nvm_cmpo {
+	__le16 length;
+#define ICE_AQC_NVM_CMPO_ENABLE	BIT(8)
+	__le16 cages_cfg[8];
+};
+
 #define ICE_AQC_NVM_START_POINT			0
 
 /* NVM Checksum Command (direct, 0x0706) */
diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index 80dc5445b50d..e9300df9ef40 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -591,6 +591,36 @@ static void ice_devlink_port_options_print(struct ice_pf *pf)
 	kfree(options);
 }
 
+#define ICE_NUM_OF_CAGES 8
+
+/**
+ * ice_devlink_aq_clear_cmpo - clear Cage Max Power override
+ * @hw: pointer to the HW struct
+ *
+ * Read Cage Max Power override NVM module, clear override
+ * enable bit for each of the cages. Write the settings back to
+ * the NVM.
+ */
+static int
+ice_devlink_aq_clear_cmpo(struct ice_hw *hw)
+{
+	struct ice_aqc_nvm_cmpo data;
+	int ret, i;
+
+	ret = ice_aq_read_nvm(hw, ICE_AQC_NVM_CMPO_MOD_ID, 0, sizeof(data),
+			      &data, true, false, NULL);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ICE_NUM_OF_CAGES; i++)
+		data.cages_cfg[i] &= ~cpu_to_le16(ICE_AQC_NVM_CMPO_ENABLE);
+
+	/* Do not update the length word since it is not permitted */
+	return ice_aq_update_nvm(hw, ICE_AQC_NVM_CMPO_MOD_ID, 2,
+				 sizeof(data.cages_cfg), data.cages_cfg,
+				 false, 0, NULL);
+}
+
 /**
  * ice_devlink_aq_set_port_option - Send set port option admin queue command
  * @pf: the PF to print split port options
@@ -623,6 +653,11 @@ ice_devlink_aq_set_port_option(struct ice_pf *pf, u8 option_idx,
 		return -EIO;
 	}
 
+	status = ice_devlink_aq_clear_cmpo(&pf->hw);
+	if (status)
+		dev_dbg(dev, "Failed to clear Cage Max Power override, err %d aq_err %d\n",
+			status, pf->hw.adminq.sq_last_status);
+
 	status = ice_nvm_write_activate(&pf->hw, ICE_AQC_NVM_ACTIV_REQ_EMPR, NULL);
 	if (status) {
 		dev_dbg(dev, "ice_nvm_write_activate failed, err %d aq_err %d\n",
diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
index f6f52a248066..745f2459943f 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.c
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
@@ -18,7 +18,7 @@
  *
  * Read the NVM using the admin queue commands (0x0701)
  */
-static int
+int
 ice_aq_read_nvm(struct ice_hw *hw, u16 module_typeid, u32 offset, u16 length,
 		void *data, bool last_command, bool read_shadow_ram,
 		struct ice_sq_cd *cd)
diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.h b/drivers/net/ethernet/intel/ice/ice_nvm.h
index 774c2317967d..90f36e19e06b 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.h
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.h
@@ -15,6 +15,10 @@ struct ice_orom_civd_info {
 int ice_acquire_nvm(struct ice_hw *hw, enum ice_aq_res_access_type access);
 void ice_release_nvm(struct ice_hw *hw);
 int
+ice_aq_read_nvm(struct ice_hw *hw, u16 module_typeid, u32 offset, u16 length,
+		void *data, bool last_command, bool read_shadow_ram,
+		struct ice_sq_cd *cd);
+int
 ice_read_flat_nvm(struct ice_hw *hw, u32 offset, u32 *length, u8 *data,
 		  bool read_shadow_ram);
 int
-- 
2.40.1


