Return-Path: <netdev+bounces-108492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30B3923F56
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E666B1C21E47
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6227816631A;
	Tue,  2 Jul 2024 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oh9FO3Xh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3596F1B581A
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927913; cv=none; b=M7wwcstKe7lB8u4tHsKEB0VJLMGt3f3vZmUywq0sd1EB4nc0uL7uh2RHKUpRvfYBsLcz91WD8Pp2jWzpTyxY1PXZHyvSD5D09ezVBNQ/j95zXnEQbS82WXeVR9JkdRlTmVv6WxO7hANyon7IyNi4Pdb1SO8iIvEfkZQBRK+FIz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927913; c=relaxed/simple;
	bh=cjWNrCtX/PrnW2hIrF9mN7MD3DfyGqd1VfF53tDk2VI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeGpn96OwwzPdyhdynG13HWS0/0eVcf5BQCKvSuE+W7Vy/cwn+Y+I570/s9BiG5+MxjlvAxPFiiEQPJSyyBUIyNUCJ0/kSFCVNQRq36X4NsPueu09q4qvD/OjRf8W5Z2GiqtySpW1n1u3OcbKIcQmpMJNq6LHq5+aSKQwsJd9Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oh9FO3Xh; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719927911; x=1751463911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cjWNrCtX/PrnW2hIrF9mN7MD3DfyGqd1VfF53tDk2VI=;
  b=Oh9FO3Xheo7FK5EGU2g+MHEIVtjmmet+uMD8g5QpmscOXtwqTDd7bJgN
   qi89DqaBqvgaTMjoTwTklwDXL+31A/7Da55Y+ckg8du/evMxPLXl4wdKT
   hnvaO4K4RoLRnZ+THV+0aQXN/PhwMoV2mEuNPH5JzMrqoDmukb55AmQMG
   sCN7sov0cnMYHbTf6xy/0bN0WvVGAv3k7PmBNP2eevAMTn7pJJh9DaaLS
   rkhFRmbjjS4SthTQLPZNm2sLD5k9w9a90ahWx3kpCgVYh0WUjG7Jmx/ny
   37ntfZr8pPmX7IKQscwb0cNFvzwcP7nqnqaj7VVH/LHIgE9fK46RmDz04
   Q==;
X-CSE-ConnectionGUID: rumzQ3jpToaEqj3XR3kWIQ==
X-CSE-MsgGUID: XjHUV6DOSnq9CDLn7qkQGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="16826448"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="16826448"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 06:45:10 -0700
X-CSE-ConnectionGUID: c5ew5pijQnWwJdmFO8LnKw==
X-CSE-MsgGUID: PT19IWTxSQypd/ghE3pmcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="83460573"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.132])
  by orviesa001.jf.intel.com with ESMTP; 02 Jul 2024 06:45:08 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Yochai Hagvi <yochai.hagvi@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v2 iwl-next 6/7] ice: Read SDP section from NVM for pin definitions
Date: Tue,  2 Jul 2024 15:41:35 +0200
Message-ID: <20240702134448.132374-15-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702134448.132374-9-karol.kolacinski@intel.com>
References: <20240702134448.132374-9-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yochai Hagvi <yochai.hagvi@intel.com>

PTP pins assignment and their related SDPs (Software Definable Pins) are
currently hardcoded.
Fix that by reading NVM section instead on products supporting this,
which are E810 products.
If SDP section is not defined in NVM, the driver continues to use the
hardcoded table.

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Yochai Hagvi <yochai.hagvi@intel.com>
Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   9 ++
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 138 ++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   6 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  60 ++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   1 +
 5 files changed, 186 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 66f02988d549..a710ce4e4482 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1742,6 +1742,15 @@ struct ice_aqc_nvm {
 };
 
 #define ICE_AQC_NVM_START_POINT			0
+#define ICE_AQC_NVM_SECTOR_UNIT			4096
+#define ICE_AQC_NVM_SDP_AC_PTR_OFFSET		0xD8
+#define ICE_AQC_NVM_SDP_AC_PTR_M		GENMASK(14, 0)
+#define ICE_AQC_NVM_SDP_AC_PTR_INVAL		0x7FFF
+#define ICE_AQC_NVM_SDP_AC_PTR_TYPE_M		BIT(15)
+#define ICE_AQC_NVM_SDP_AC_SDP_NUM_M		GENMASK(2, 0)
+#define ICE_AQC_NVM_SDP_AC_DIR_M		BIT(3)
+#define ICE_AQC_NVM_SDP_AC_PIN_M		GENMASK(15, 6)
+#define ICE_AQC_NVM_SDP_AC_MAX_SIZE		7
 
 #define ICE_AQC_NVM_TX_TOPO_MOD_ID		0x14B
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 1594d10a0858..e324d96c34c6 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -39,7 +39,7 @@ static const struct ice_ptp_pin_desc ice_pin_desc_e810[] = {
 	{  ONE_PPS,   { 5, -1 }},
 };
 
-static const char ice_pin_names_e810t[][64] = {
+static const char ice_pin_names_nvm[][64] = {
 	"GNSS",
 	"SMA1",
 	"U.FL1",
@@ -47,7 +47,7 @@ static const char ice_pin_names_e810t[][64] = {
 	"U.FL2",
 };
 
-static const struct ice_ptp_pin_desc ice_pin_desc_e810t[] = {
+static const struct ice_ptp_pin_desc ice_pin_desc_e810_sma[] = {
 	/* name, gpio */
 	{  GNSS, { -1,  1 }},
 	{  SMA1, {  0,  1 }},
@@ -2402,8 +2402,8 @@ static void ice_ptp_setup_pin_cfg(struct ice_pf *pf)
 
 		if (!ice_is_feature_supported(pf, ICE_F_SMA_CTRL))
 			name = ice_pin_names[desc->name_idx];
-		else
-			name = ice_pin_names_e810t[desc->name_idx];
+		else if (desc->name_idx != GPIO_NA)
+			name = ice_pin_names_nvm[desc->name_idx];
 		if (name)
 			strscpy(pin->name, name, sizeof(pin->name));
 
@@ -2424,17 +2424,17 @@ static void ice_ptp_setup_pin_cfg(struct ice_pf *pf)
 }
 
 /**
- * ice_ptp_disable_sma_pins - Disable SMA pins
+ * ice_ptp_disable_pins - Disable PTP pins
  * @pf: pointer to the PF structure
  *
  * Disable the OS access to the SMA pins. Called to clear out the OS
  * indications of pin support when we fail to setup the SMA control register.
  */
-static void ice_ptp_disable_sma_pins(struct ice_pf *pf)
+static void ice_ptp_disable_pins(struct ice_pf *pf)
 {
 	struct ptp_clock_info *info = &pf->ptp.info;
 
-	dev_warn(ice_pf_to_dev(pf), "Failed to configure  SMA pin control\n");
+	dev_warn(ice_pf_to_dev(pf), "Failed to configure PTP pin control\n");
 
 	info->enable = NULL;
 	info->verify = NULL;
@@ -2444,23 +2444,75 @@ static void ice_ptp_disable_sma_pins(struct ice_pf *pf)
 }
 
 /**
- * ice_ptp_setup_pins_e810t - Setup PTP pins in sysfs
- * @pf: pointer to the PF instance
+ * ice_ptp_parse_sdp_entries - update ice_ptp_pin_desc structure from NVM
+ * @pf: pointer to the PF structure
+ * @entries: SDP connection section from NVM
+ * @num_entries: number of valid entries in sdp_entries
+ * @pins: PTP pins array to update
+ *
+ * Return: 0 on success, negative error code otherwise.
  */
-static void ice_ptp_setup_pins_e810t(struct ice_pf *pf)
+static int ice_ptp_parse_sdp_entries(struct ice_pf *pf, __le16 *entries,
+				     uint num_entries,
+				     struct ice_ptp_pin_desc *pins)
 {
-	struct ice_ptp *ptp = &pf->ptp;
-	int err;
+	uint n_pins = 0;
+	uint i;
 
-	ptp->ice_pin_desc = ice_pin_desc_e810t;
-	ptp->info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e810t);
-	ptp->info.pin_config = ptp->pin_desc;
-	ice_ptp_setup_pin_cfg(pf);
+	/* Setup ice_pin_desc array */
+	for (i = 0; i < ICE_N_PINS_MAX; i++) {
+		pins[i].name_idx = -1;
+		pins[i].gpio[0] = -1;
+		pins[i].gpio[1] = -1;
+	}
+
+	for (i = 0; i < num_entries; i++) {
+		u16 entry = le16_to_cpu(entries[i]);
+		DECLARE_BITMAP(bitmap, GPIO_NA);
+		uint bitmap_idx;
+		bool dir;
+		u16 gpio;
+
+		*bitmap = FIELD_GET(ICE_AQC_NVM_SDP_AC_PIN_M, entry);
+		dir = !!FIELD_GET(ICE_AQC_NVM_SDP_AC_DIR_M, entry);
+		gpio = FIELD_GET(ICE_AQC_NVM_SDP_AC_SDP_NUM_M, entry);
+		for_each_set_bit(bitmap_idx, bitmap, GPIO_NA + 1) {
+			uint idx;
+
+			/* Check if entry's pin bit is valid */
+			if (bitmap_idx >= NUM_PTP_PINS_NVM &&
+			    bitmap_idx != GPIO_NA)
+				continue;
 
-	/* Clear SMA status */
-	err = ice_ptp_set_sma_cfg(pf);
-	if (err)
-		ice_ptp_disable_sma_pins(pf);
+			/* Check if pin already exists */
+			for (idx = 0; idx < ICE_N_PINS_MAX; idx++)
+				if (pins[idx].name_idx == bitmap_idx)
+					break;
+
+			if (idx == ICE_N_PINS_MAX) {
+				/* Pin not found, setup its entry and name */
+				idx = n_pins++;
+				pins[idx].name_idx = bitmap_idx;
+				if (bitmap_idx == GPIO_NA)
+					strscpy(pf->ptp.pin_desc[idx].name,
+						ice_pin_names[gpio],
+						sizeof(pf->ptp.pin_desc[idx]
+							       .name));
+			}
+
+			/* Setup in/out GPIO number */
+			pins[idx].gpio[dir] = gpio;
+		}
+	}
+
+	for (i = 0; i < n_pins; i++) {
+		dev_dbg(ice_pf_to_dev(pf),
+			"NVM pin entry[%d] : name_idx %d gpio_out %d gpio_in %d\n",
+			i, pins[i].name_idx, pins[i].gpio[1], pins[i].gpio[0]);
+	}
+
+	pf->ptp.info.n_pins = n_pins;
+	return 0;
 }
 
 /**
@@ -2501,15 +2553,49 @@ static void ice_ptp_set_funcs_e82x(struct ice_pf *pf)
  */
 static void ice_ptp_set_funcs_e810(struct ice_pf *pf)
 {
-	if (ice_is_e810t(&pf->hw) &&
-	    ice_is_feature_supported(pf, ICE_F_SMA_CTRL)) {
-		ice_ptp_setup_pins_e810t(pf);
-		return;
+	__le16 entries[ICE_AQC_NVM_SDP_AC_MAX_SIZE];
+	struct ice_ptp_pin_desc *desc = NULL;
+	struct ice_ptp *ptp = &pf->ptp;
+	uint num_entries;
+	int err;
+
+	err = ice_ptp_read_sdp_ac(&pf->hw, entries, &num_entries);
+	if (err) {
+		/* SDP section does not exist in NVM or is corrupted */
+		if (ice_is_feature_supported(pf, ICE_F_SMA_CTRL)) {
+			ptp->ice_pin_desc = ice_pin_desc_e810_sma;
+			ptp->info.n_pins =
+				ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e810_sma);
+		} else {
+			pf->ptp.ice_pin_desc = ice_pin_desc_e810;
+			pf->ptp.info.n_pins =
+				ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e810);
+			err = 0;
+		}
+	} else {
+		desc = devm_kcalloc(ice_pf_to_dev(pf), ICE_N_PINS_MAX,
+				    sizeof(struct ice_ptp_pin_desc),
+				    GFP_KERNEL);
+		if (!desc)
+			goto err;
+
+		err = ice_ptp_parse_sdp_entries(pf, entries, num_entries, desc);
+		if (err)
+			goto err;
+
+		ptp->ice_pin_desc = (const struct ice_ptp_pin_desc *)desc;
 	}
 
-	pf->ptp.ice_pin_desc = ice_pin_desc_e810;
-	pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e810);
+	ptp->info.pin_config = ptp->pin_desc;
 	ice_ptp_setup_pin_cfg(pf);
+
+	if (ice_is_feature_supported(pf, ICE_F_SMA_CTRL))
+		err = ice_ptp_set_sma_cfg(pf);
+err:
+	if (err) {
+		devm_kfree(ice_pf_to_dev(pf), desc);
+		ice_ptp_disable_pins(pf);
+	}
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 27b32da999df..77b637427d67 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -199,12 +199,14 @@ enum ice_ptp_pin {
 	ONE_PPS
 };
 
-enum ice_ptp_pin_e810t {
+enum ice_ptp_pin_nvm {
 	GNSS = 0,
 	SMA1,
 	UFL1,
 	SMA2,
-	UFL2
+	UFL2,
+	NUM_PTP_PINS_NVM,
+	GPIO_NA = 9
 };
 
 /* Per-channel register definitions */
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 3c314f3d8107..07ecf2a86742 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -5313,6 +5313,66 @@ int ice_read_pca9575_reg(struct ice_hw *hw, u8 offset, u8 *data)
 	return ice_aq_read_i2c(hw, link_topo, 0, addr, 1, data, NULL);
 }
 
+/**
+ * ice_ptp_read_sdp_ac - read SDP available connections section from NVM
+ * @hw: pointer to the HW struct
+ * @entries: returns the SDP available connections section from NVM
+ * @num_entries: returns the number of valid entries
+ *
+ * Return: 0 on success, negative error code if NVM read failed or section does
+ * not exist or is corrupted
+ */
+int ice_ptp_read_sdp_ac(struct ice_hw *hw, __le16 *entries, uint *num_entries)
+{
+	__le16 data;
+	u32 offset;
+	int err;
+
+	err = ice_acquire_nvm(hw, ICE_RES_READ);
+	if (err)
+		goto exit;
+
+	/* Read the offset of SDP_AC */
+	offset = ICE_AQC_NVM_SDP_AC_PTR_OFFSET;
+	err = ice_aq_read_nvm(hw, 0, offset, sizeof(data), &data, false, true,
+			      NULL);
+	if (err)
+		goto exit;
+
+	/* Check if section exist */
+	offset = FIELD_GET(ICE_AQC_NVM_SDP_AC_PTR_M, le16_to_cpu(data));
+	if (offset == ICE_AQC_NVM_SDP_AC_PTR_INVAL) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	if (offset & ICE_AQC_NVM_SDP_AC_PTR_TYPE_M) {
+		offset &= ICE_AQC_NVM_SDP_AC_PTR_M;
+		offset *= ICE_AQC_NVM_SECTOR_UNIT;
+	} else {
+		offset *= sizeof(data);
+	}
+
+	/* Skip reading section length and read the number of valid entries */
+	offset += sizeof(data);
+	err = ice_aq_read_nvm(hw, 0, offset, sizeof(data), &data, false, true,
+			      NULL);
+	if (err)
+		goto exit;
+	*num_entries = le16_to_cpu(data);
+
+	/* Read SDP configuration section */
+	offset += sizeof(data);
+	err = ice_aq_read_nvm(hw, 0, offset, *num_entries * sizeof(data),
+			      entries, false, true, NULL);
+
+exit:
+	if (err)
+		dev_dbg(ice_hw_to_dev(hw), "Failed to configure SDP connection section\n");
+	ice_release_nvm(hw);
+	return err;
+}
+
 /**
  * ice_ptp_init_phy_e810 - initialize PHY parameters
  * @ptp: pointer to the PTP HW struct
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index c42831449787..ff98f76969e3 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -405,6 +405,7 @@ int ice_read_sma_ctrl(struct ice_hw *hw, u8 *data);
 int ice_write_sma_ctrl(struct ice_hw *hw, u8 data);
 int ice_read_pca9575_reg(struct ice_hw *hw, u8 offset, u8 *data);
 bool ice_is_pca9575_present(struct ice_hw *hw);
+int ice_ptp_read_sdp_ac(struct ice_hw *hw, __le16 *entries, uint *num_entries);
 enum dpll_pin_type ice_cgu_get_pin_type(struct ice_hw *hw, u8 pin, bool input);
 struct dpll_pin_frequency *
 ice_cgu_get_pin_freq_supp(struct ice_hw *hw, u8 pin, bool input, u8 *num);
-- 
2.45.2


