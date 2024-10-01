Return-Path: <netdev+bounces-131033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E03298C6A0
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED031284530
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AE31CEE89;
	Tue,  1 Oct 2024 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iU5rsXqB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FB81CEAC8
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 20:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813839; cv=none; b=un5hVPLeZHbvW/OZ+NVaS4Y5FELmFJrQu9CL00dyF3y04tjti4qUeaWh88yeHh/ihQ0iOZJgPuv78LFwYwXuV5L7I3EVuPxqpX6qhbL1IGgKPfLiil56y/CJYnzg/JLHT9t2olbKJB7s30nlVJ7xslGyZwIyShsF3xh0oAzhjBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813839; c=relaxed/simple;
	bh=H8H3hNvTQ2yixBOplcs3XNJgaAo5gwzCCFNwuRMHxKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPzgRqmJhqW0AQe3zbtY5wFrMFCvsoOPQ6b61MM0Ylz8RsUd2D0u9E4talFAgFjg96k9hzdGKlByDYEav4Dq4AvDWOeG9q785B67mBBf+61T4s4V9TFEiq38mLKwosuby5WDhDZRYvO+TMzYh9paxeOgS7ZMFwG2vx0P00i9F8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iU5rsXqB; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727813838; x=1759349838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H8H3hNvTQ2yixBOplcs3XNJgaAo5gwzCCFNwuRMHxKk=;
  b=iU5rsXqBOUWjX6OCKuVlUAI4LWucRmESZNLZO1yZbZxmGg+q0hVjQ2/h
   pqM0ocdfziCf/9j0clfGuy3U8lbEXAu4x2q1EL6TAsN2HLAdBctkGFKV8
   V1n91SPUCEOOV9ck1ya2giBP/BQrD9z3o84ha0xQr6HmMhuuOfTqhWAdl
   akXyTKsb1HqHvB50sY6s/oJ2RWR05vzVftqsGC9X+9NEEHyCvR+q7QAV0
   VvWywXsYllIpsLBn3+m2N/RNkCwnju3YjICbo6Zw03tAsvRf6vuzZvip0
   dOAU68N+pi2G5iGryUQaxNPRNh90yrNi5NcPrV8T9MjAXhXfiVKU428UF
   Q==;
X-CSE-ConnectionGUID: lPLyR05kR+mWOKJCUFBQrw==
X-CSE-MsgGUID: d2cSDPhsR0yhjFSpJAjPiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="27063088"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="27063088"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 13:17:14 -0700
X-CSE-ConnectionGUID: OsW11CtzTd+l/N0Lmsfv2g==
X-CSE-MsgGUID: CGtto8CmRwa9174Zqwd2Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="73761862"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 01 Oct 2024 13:17:14 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Yochai Hagvi <yochai.hagvi@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 06/12] ice: Read SDP section from NVM for pin definitions
Date: Tue,  1 Oct 2024 13:16:53 -0700
Message-ID: <20241001201702.3252954-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241001201702.3252954-1-anthony.l.nguyen@intel.com>
References: <20241001201702.3252954-1-anthony.l.nguyen@intel.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   9 ++
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 138 ++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   6 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  60 ++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   1 +
 5 files changed, 186 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 0be1a98d7cc1..1f01f3501d6b 100644
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
index f733e673bf26..753709ef1ab2 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -39,7 +39,7 @@ static const struct ice_ptp_pin_desc ice_pin_desc_e810[] = {
 	{  ONE_PPS, { -1, 5 }},
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
 	/* name,   gpio */
 	{  GNSS, {  1, -1 }},
 	{  SMA1, {  1,  0 }},
@@ -2385,8 +2385,8 @@ static void ice_ptp_setup_pin_cfg(struct ice_pf *pf)
 
 		if (!ice_is_feature_supported(pf, ICE_F_SMA_CTRL))
 			name = ice_pin_names[desc->name_idx];
-		else
-			name = ice_pin_names_e810t[desc->name_idx];
+		else if (desc->name_idx != GPIO_NA)
+			name = ice_pin_names_nvm[desc->name_idx];
 		if (name)
 			strscpy(pin->name, name, sizeof(pin->name));
 
@@ -2397,17 +2397,17 @@ static void ice_ptp_setup_pin_cfg(struct ice_pf *pf)
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
@@ -2417,23 +2417,75 @@ static void ice_ptp_disable_sma_pins(struct ice_pf *pf)
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
+				     unsigned int num_entries,
+				     struct ice_ptp_pin_desc *pins)
 {
-	struct ice_ptp *ptp = &pf->ptp;
-	int err;
+	unsigned int n_pins = 0;
+	unsigned int i;
 
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
+		unsigned int bitmap_idx;
+		bool dir;
+		u16 gpio;
+
+		*bitmap = FIELD_GET(ICE_AQC_NVM_SDP_AC_PIN_M, entry);
+		dir = !!FIELD_GET(ICE_AQC_NVM_SDP_AC_DIR_M, entry);
+		gpio = FIELD_GET(ICE_AQC_NVM_SDP_AC_SDP_NUM_M, entry);
+		for_each_set_bit(bitmap_idx, bitmap, GPIO_NA + 1) {
+			unsigned int idx;
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
@@ -2474,15 +2526,49 @@ static void ice_ptp_set_funcs_e82x(struct ice_pf *pf)
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
+	unsigned int num_entries;
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
index dc1f5a95b970..b8ab162a5538 100644
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
2.42.0


