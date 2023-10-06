Return-Path: <netdev+bounces-38546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8487BB5E7
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 13:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BEA91C20A6C
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 11:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9031A1C28C;
	Fri,  6 Oct 2023 11:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IrwNaIZa"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830731C2A2
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 11:05:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E1AE9
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 04:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696590345; x=1728126345;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kNrEmOh5WmMmAaFdoGUjMhORFctkIYyOww9zGbLkdFI=;
  b=IrwNaIZaZ3AqBLbbXYRJTGBEtjizK0vA4rwKECoBzNIB7F6C4ZXEnDmA
   G5a7aTbYvi5Hl3wm1MSftws3FMEcxh4IGEvh9A/6X+jSbeuua8xY2yXLd
   5tFb4v5VFTfxu3cgI4qVTJox1n0qDQIx6XAmYVcVenBYFrHmvoV3M/8yp
   FwjouhcE6foVXNtjQRs9mkuLxI3UyE7uFzn3K8IiZkB9E4xnuAaEvhTP6
   JiLmp8Sz+CNEExorGmhU37XnJvFxIdKJt67jyqGrWQua1ZDQTLaM3T0sS
   YoOubyBWPv3b5j4CChVCVLxIWUulWHt+COIUG95Vyl8oD9LbaTWZNtiPT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="2332739"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="2332739"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 04:05:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="895844417"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="895844417"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga001.fm.intel.com with ESMTP; 06 Oct 2023 04:04:10 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 69DCF36345;
	Fri,  6 Oct 2023 12:05:41 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Wilczynski <michal.wilczynski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-net v2 3/5] ice: Enable switching default Tx scheduler topology
Date: Fri,  6 Oct 2023 07:02:10 -0400
Message-Id: <20231006110212.96305-4-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231006110212.96305-1-mateusz.polchlopek@intel.com>
References: <20231006110212.96305-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Michal Wilczynski <michal.wilczynski@intel.com>

Introduce support for Tx scheduler topology change, based on user
selection, from default 9-layer to 5-layer.
Change requires NVM (version 3.20 or newer) and DDP package (OS Package
1.3.30 or newer - available for over a year in linux-firmware, since
commit aed71f296637 in linux-firmware ("ice: Update package to 1.3.30.0"))
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/?id=aed71f296637

Enable 5-layer topology switch in init path of the driver. To accomplish
that upload of the DDP package needs to be delayed, until change in Tx
topology is finished. To trigger the Tx change user selection should be
changed in NVM using devlink. Then the platform should be rebooted.

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ddp.c  |  2 +-
 drivers/net/ethernet/intel/ice/ice_ddp.h  |  2 +-
 drivers/net/ethernet/intel/ice/ice_main.c | 97 ++++++++++++++++++-----
 3 files changed, 80 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index 95c7712b56b8..44591bcdb537 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -1950,7 +1950,7 @@ ice_get_set_tx_topo(struct ice_hw *hw, u8 *buf, u16 buf_size,
  * The function will apply the new Tx topology from the package buffer
  * if available.
  */
-int ice_cfg_tx_topo(struct ice_hw *hw, u8 *buf, u32 len)
+int ice_cfg_tx_topo(struct ice_hw *hw, const u8 *buf, u32 len)
 {
 	u8 *current_topo, *new_topo = NULL;
 	struct ice_run_time_cfg_seg *seg;
diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.h b/drivers/net/ethernet/intel/ice/ice_ddp.h
index c00203df35da..b6f126e11dea 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.h
@@ -432,6 +432,6 @@ u16 ice_pkg_buf_get_active_sections(struct ice_buf_build *bld);
 void *ice_pkg_enum_section(struct ice_seg *ice_seg, struct ice_pkg_enum *state,
 			   u32 sect_type);
 
-int ice_cfg_tx_topo(struct ice_hw *hw, u8 *buf, u32 len);
+int ice_cfg_tx_topo(struct ice_hw *hw, const u8 *buf, u32 len);
 
 #endif
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 3363c69d49da..ad3a1572a635 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4319,11 +4319,11 @@ static char *ice_get_opt_fw_name(struct ice_pf *pf)
 /**
  * ice_request_fw - Device initialization routine
  * @pf: pointer to the PF instance
+ * @firmware: double pointer to firmware struct
  */
-static void ice_request_fw(struct ice_pf *pf)
+static int ice_request_fw(struct ice_pf *pf, const struct firmware **firmware)
 {
 	char *opt_fw_filename = ice_get_opt_fw_name(pf);
-	const struct firmware *firmware = NULL;
 	struct device *dev = ice_pf_to_dev(pf);
 	int err = 0;
 
@@ -4332,29 +4332,86 @@ static void ice_request_fw(struct ice_pf *pf)
 	 * and warning messages for other errors.
 	 */
 	if (opt_fw_filename) {
-		err = firmware_request_nowarn(&firmware, opt_fw_filename, dev);
-		if (err) {
-			kfree(opt_fw_filename);
-			goto dflt_pkg_load;
-		}
-
-		/* request for firmware was successful. Download to device */
-		ice_load_pkg(firmware, pf);
+		err = firmware_request_nowarn(firmware, opt_fw_filename, dev);
 		kfree(opt_fw_filename);
-		release_firmware(firmware);
-		return;
+		if (!err)
+			return err;
 	}
+	err = request_firmware(firmware, ICE_DDP_PKG_FILE, dev);
+	if (err)
+		dev_err(dev, "The DDP package file was not found or could not be read. Entering Safe Mode\n");
+
+	return err;
+}
+
+/**
+ * ice_init_tx_topology - performs Tx topology initialization
+ * @hw: pointer to the hardware structure
+ * @firmware: pointer to firmware structure
+ */
+static int
+ice_init_tx_topology(struct ice_hw *hw, const struct firmware *firmware)
+{
+	u8 num_tx_sched_layers = hw->num_tx_sched_layers;
+	struct ice_pf *pf = hw->back;
+	struct device *dev;
+	int err;
+
+	dev = ice_pf_to_dev(pf);
 
-dflt_pkg_load:
-	err = request_firmware(&firmware, ICE_DDP_PKG_FILE, dev);
+	err = ice_cfg_tx_topo(hw, firmware->data, firmware->size);
+	if (!err) {
+		if (hw->num_tx_sched_layers > num_tx_sched_layers)
+			dev_info(dev, "Tx scheduling layers switching feature disabled\n");
+		else
+			dev_info(dev, "Tx scheduling layers switching feature enabled\n");
+		/* if there was a change in topology ice_cfg_tx_topo triggered
+		 * a CORER and we need to re-init hw
+		 */
+		ice_deinit_hw(hw);
+		err = ice_init_hw(hw);
+
+		return err;
+	} else if (err == -EIO) {
+		dev_info(dev, "DDP package does not support Tx scheduling layers switching feature - please update to the latest DDP package and try again\n");
+	}
+
+	return 0;
+}
+
+/**
+ * ice_init_ddp_config - DDP related configuration
+ * @hw: pointer to the hardware structure
+ * @pf: pointer to pf structure
+ *
+ * This function loads DDP file from the disk, then initializes Tx
+ * topology. At the end DDP package is loaded on the card.
+ */
+static int ice_init_ddp_config(struct ice_hw *hw, struct ice_pf *pf)
+{
+	struct device *dev = ice_pf_to_dev(pf);
+	const struct firmware *firmware = NULL;
+	int err;
+
+	err = ice_request_fw(pf, &firmware);
 	if (err) {
-		dev_err(dev, "The DDP package file was not found or could not be read. Entering Safe Mode\n");
-		return;
+		dev_err(dev, "Fail during requesting FW: %d\n", err);
+		return err;
 	}
 
-	/* request for firmware was successful. Download to device */
+	err = ice_init_tx_topology(hw, firmware);
+	if (err) {
+		dev_err(dev, "Fail during initialization of Tx topology: %d\n",
+			err);
+		release_firmware(firmware);
+		return err;
+	}
+
+	/* Download firmware to device */
 	ice_load_pkg(firmware, pf);
 	release_firmware(firmware);
+
+	return 0;
 }
 
 /**
@@ -4614,9 +4671,11 @@ static int ice_init_dev(struct ice_pf *pf)
 
 	ice_init_feature_support(pf);
 
-	ice_request_fw(pf);
+	err = ice_init_ddp_config(hw, pf);
+	if (err)
+		return err;
 
-	/* if ice_request_fw fails, ICE_FLAG_ADV_FEATURES bit won't be
+	/* if ice_init_ddp_config fails, ICE_FLAG_ADV_FEATURES bit won't be
 	 * set in pf->state, which will cause ice_is_safe_mode to return
 	 * true
 	 */
-- 
2.38.1


