Return-Path: <netdev+bounces-47516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 875597EA6C4
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4210D28104B
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05E93FB36;
	Mon, 13 Nov 2023 23:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bLHhsAdH"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3C23E493
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:11:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D353BD6E
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699917062; x=1731453062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wdcR45T36/LaqSJiy3s9gqvO+6Zss4YT1ggrh2hoyao=;
  b=bLHhsAdH3TbPDxjWJ/KJet2zZXihQBWPlEYVNXMkB0946Ht6A/6z5wCH
   AEbeEFZRX03d2qhEozaXTgLA4GCHqmTeTdbmXlEBOW9O3lI2tgFOy206i
   aiZHkP9LyvQTZtVb4KutQjWJrY9mLChfi10P4d4H0jPL0D2NxkJcLRTpW
   7FCGUUjpQQopf5x6D6uZRPetlBcQR1vRjyXSxvk/dynEfVIGdoRUoASsn
   huxLwFA4jQIDULxteR1p42Qh1gEaBcYGX8nOxdq5oELjUdQtTSgAV2OHy
   1rAiGTUuDUmBJOukVpA3Q5YBTWUNt5jQCagzsRveG2E4PLLJRl0uzfxYv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="375562657"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="375562657"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 15:10:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="888051430"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="888051430"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 13 Nov 2023 15:10:53 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 12/15] i40e: Use helpers to check running FW and AQ API versions
Date: Mon, 13 Nov 2023 15:10:31 -0800
Message-ID: <20231113231047.548659-13-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113231047.548659-1-anthony.l.nguyen@intel.com>
References: <20231113231047.548659-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ivan Vecera <ivecera@redhat.com>

Use new helpers to check versions of running FW and provided
AQ API to make the code more readable.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c | 56 +++++++------------
 drivers/net/ethernet/intel/i40e/i40e_common.c | 25 ++++-----
 drivers/net/ethernet/intel/i40e/i40e_dcb.c    |  7 +--
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  6 +-
 4 files changed, 36 insertions(+), 58 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index 86591140f748..29fc46abf690 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -508,42 +508,35 @@ static int i40e_shutdown_arq(struct i40e_hw *hw)
  **/
 static void i40e_set_hw_caps(struct i40e_hw *hw)
 {
-	struct i40e_adminq_info *aq = &hw->aq;
-
 	bitmap_zero(hw->caps, I40E_HW_CAPS_NBITS);
 
 	switch (hw->mac.type) {
 	case I40E_MAC_XL710:
-		if (aq->api_maj_ver > 1 ||
-		    (aq->api_maj_ver == 1 &&
-		     aq->api_min_ver >= I40E_MINOR_VER_GET_LINK_INFO_XL710)) {
+		if (i40e_is_aq_api_ver_ge(hw, 1,
+					  I40E_MINOR_VER_GET_LINK_INFO_XL710)) {
 			set_bit(I40E_HW_CAP_AQ_PHY_ACCESS, hw->caps);
 			set_bit(I40E_HW_CAP_FW_LLDP_STOPPABLE, hw->caps);
 			/* The ability to RX (not drop) 802.1ad frames */
 			set_bit(I40E_HW_CAP_802_1AD, hw->caps);
 		}
-		if ((aq->api_maj_ver == 1 && aq->api_min_ver > 4) ||
-		    aq->api_maj_ver > 1) {
+		if (i40e_is_aq_api_ver_ge(hw, 1, 5)) {
 			/* Supported in FW API version higher than 1.4 */
 			set_bit(I40E_HW_CAP_GENEVE_OFFLOAD, hw->caps);
 		}
-		if ((aq->fw_maj_ver == 4 && aq->fw_min_ver < 33) ||
-		    aq->fw_maj_ver < 4) {
+		if (i40e_is_fw_ver_lt(hw, 4, 33)) {
 			set_bit(I40E_HW_CAP_RESTART_AUTONEG, hw->caps);
 			/* No DCB support  for FW < v4.33 */
 			set_bit(I40E_HW_CAP_NO_DCB_SUPPORT, hw->caps);
 		}
-		if ((aq->fw_maj_ver == 4 && aq->fw_min_ver < 3) ||
-		    aq->fw_maj_ver < 4) {
+		if (i40e_is_fw_ver_lt(hw, 4, 3)) {
 			/* Disable FW LLDP if FW < v4.3 */
 			set_bit(I40E_HW_CAP_STOP_FW_LLDP, hw->caps);
 		}
-		if ((aq->fw_maj_ver == 4 && aq->fw_min_ver >= 40) ||
-		    aq->fw_maj_ver >= 5) {
-			/* Use the FW Set LLDP MIB API if FW > v4.40 */
+		if (i40e_is_fw_ver_ge(hw, 4, 40)) {
+			/* Use the FW Set LLDP MIB API if FW >= v4.40 */
 			set_bit(I40E_HW_CAP_USE_SET_LLDP_MIB, hw->caps);
 		}
-		if (aq->fw_maj_ver >= 6) {
+		if (i40e_is_fw_ver_ge(hw, 6, 0)) {
 			/* Enable PTP L4 if FW > v6.0 */
 			set_bit(I40E_HW_CAP_PTP_L4, hw->caps);
 		}
@@ -569,19 +562,16 @@ static void i40e_set_hw_caps(struct i40e_hw *hw)
 			clear_bit(I40E_HW_CAP_ATR_EVICT, hw->caps);
 		}
 
-		if (aq->api_maj_ver > 1 ||
-		    (aq->api_maj_ver == 1 &&
-		     aq->api_min_ver >= I40E_MINOR_VER_FW_LLDP_STOPPABLE_X722))
+		if (i40e_is_aq_api_ver_ge(hw, 1,
+					  I40E_MINOR_VER_FW_LLDP_STOPPABLE_X722))
 			set_bit(I40E_HW_CAP_FW_LLDP_STOPPABLE, hw->caps);
 
-		if (aq->api_maj_ver > 1 ||
-		    (aq->api_maj_ver == 1 &&
-		     aq->api_min_ver >= I40E_MINOR_VER_GET_LINK_INFO_X722))
+		if (i40e_is_aq_api_ver_ge(hw, 1,
+					  I40E_MINOR_VER_GET_LINK_INFO_X722))
 			set_bit(I40E_HW_CAP_AQ_PHY_ACCESS, hw->caps);
 
-		if (aq->api_maj_ver > 1 ||
-		    (aq->api_maj_ver == 1 &&
-		     aq->api_min_ver >= I40E_MINOR_VER_FW_REQUEST_FEC_X722))
+		if (i40e_is_aq_api_ver_ge(hw, 1,
+					  I40E_MINOR_VER_FW_REQUEST_FEC_X722))
 			set_bit(I40E_HW_CAP_X722_FEC_REQUEST, hw->caps);
 
 		fallthrough;
@@ -590,25 +580,17 @@ static void i40e_set_hw_caps(struct i40e_hw *hw)
 	}
 
 	/* Newer versions of firmware require lock when reading the NVM */
-	if (aq->api_maj_ver > 1 ||
-	    (aq->api_maj_ver == 1 &&
-	     aq->api_min_ver >= 5))
+	if (i40e_is_aq_api_ver_ge(hw, 1, 5))
 		set_bit(I40E_HW_CAP_NVM_READ_REQUIRES_LOCK, hw->caps);
 
 	/* The ability to RX (not drop) 802.1ad frames was added in API 1.7 */
-	if (aq->api_maj_ver > 1 ||
-	    (aq->api_maj_ver == 1 &&
-	     aq->api_min_ver >= 7))
+	if (i40e_is_aq_api_ver_ge(hw, 1, 7))
 		set_bit(I40E_HW_CAP_802_1AD, hw->caps);
 
-	if (aq->api_maj_ver > 1 ||
-	    (aq->api_maj_ver == 1 &&
-	     aq->api_min_ver >= 8))
+	if (i40e_is_aq_api_ver_ge(hw, 1, 8))
 		set_bit(I40E_HW_CAP_FW_LLDP_PERSISTENT, hw->caps);
 
-	if (aq->api_maj_ver > 1 ||
-	    (aq->api_maj_ver == 1 &&
-	     aq->api_min_ver >= 9))
+	if (i40e_is_aq_api_ver_ge(hw, 1, 9))
 		set_bit(I40E_HW_CAP_AQ_PHY_ACCESS_EXTENDED, hw->caps);
 }
 
@@ -694,7 +676,7 @@ int i40e_init_adminq(struct i40e_hw *hw)
 			   &oem_lo);
 	hw->nvm.oem_ver = ((u32)oem_hi << 16) | oem_lo;
 
-	if (hw->aq.api_maj_ver > I40E_FW_API_VERSION_MAJOR) {
+	if (i40e_is_aq_api_ver_ge(hw, I40E_FW_API_VERSION_MAJOR + 1, 0)) {
 		ret_code = -EIO;
 		goto init_adminq_free_arq;
 	}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index df7ba349030d..e171f4814e21 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1374,8 +1374,8 @@ i40e_aq_get_phy_capabilities(struct i40e_hw *hw,
 
 	if (report_init) {
 		if (hw->mac.type ==  I40E_MAC_XL710 &&
-		    hw->aq.api_maj_ver == I40E_FW_API_VERSION_MAJOR &&
-		    hw->aq.api_min_ver >= I40E_MINOR_VER_GET_LINK_INFO_XL710) {
+		    i40e_is_aq_api_ver_ge(hw, I40E_FW_API_VERSION_MAJOR,
+					  I40E_MINOR_VER_GET_LINK_INFO_XL710)) {
 			status = i40e_aq_get_link_info(hw, true, NULL, NULL);
 		} else {
 			hw->phy.phy_types = le32_to_cpu(abilities->phy_type);
@@ -1645,9 +1645,8 @@ int i40e_aq_get_link_info(struct i40e_hw *hw,
 	else
 		hw_link_info->lse_enable = false;
 
-	if ((hw->mac.type == I40E_MAC_XL710) &&
-	    (hw->aq.fw_maj_ver < 4 || (hw->aq.fw_maj_ver == 4 &&
-	     hw->aq.fw_min_ver < 40)) && hw_link_info->phy_type == 0xE)
+	if (hw->mac.type == I40E_MAC_XL710 && i40e_is_fw_ver_lt(hw, 4, 40) &&
+	    hw_link_info->phy_type == 0xE)
 		hw_link_info->phy_type = I40E_PHY_TYPE_10GBASE_SFPP_CU;
 
 	if (test_bit(I40E_HW_CAP_AQ_PHY_ACCESS, hw->caps) &&
@@ -5223,14 +5222,14 @@ int i40e_aq_rx_ctl_read_register(struct i40e_hw *hw,
  **/
 u32 i40e_read_rx_ctl(struct i40e_hw *hw, u32 reg_addr)
 {
-	bool use_register;
+	bool use_register = false;
 	int status = 0;
 	int retry = 5;
 	u32 val = 0;
 
-	use_register = (((hw->aq.api_maj_ver == 1) &&
-			(hw->aq.api_min_ver < 5)) ||
-			(hw->mac.type == I40E_MAC_X722));
+	if (i40e_is_aq_api_ver_lt(hw, 1, 5) || hw->mac.type == I40E_MAC_X722)
+		use_register = true;
+
 	if (!use_register) {
 do_retry:
 		status = i40e_aq_rx_ctl_read_register(hw, reg_addr, &val, NULL);
@@ -5285,13 +5284,13 @@ int i40e_aq_rx_ctl_write_register(struct i40e_hw *hw,
  **/
 void i40e_write_rx_ctl(struct i40e_hw *hw, u32 reg_addr, u32 reg_val)
 {
-	bool use_register;
+	bool use_register = false;
 	int status = 0;
 	int retry = 5;
 
-	use_register = (((hw->aq.api_maj_ver == 1) &&
-			(hw->aq.api_min_ver < 5)) ||
-			(hw->mac.type == I40E_MAC_X722));
+	if (i40e_is_aq_api_ver_lt(hw, 1, 5) || hw->mac.type == I40E_MAC_X722)
+		use_register = true;
+
 	if (!use_register) {
 do_retry:
 		status = i40e_aq_rx_ctl_write_register(hw, reg_addr,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.c b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
index 39e44a2e0677..498728e16a37 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
@@ -804,14 +804,11 @@ int i40e_get_dcb_config(struct i40e_hw *hw)
 	int ret = 0;
 
 	/* If Firmware version < v4.33 on X710/XL710, IEEE only */
-	if ((hw->mac.type == I40E_MAC_XL710) &&
-	    (((hw->aq.fw_maj_ver == 4) && (hw->aq.fw_min_ver < 33)) ||
-	      (hw->aq.fw_maj_ver < 4)))
+	if (hw->mac.type == I40E_MAC_XL710 && i40e_is_fw_ver_lt(hw, 4, 33))
 		return i40e_get_ieee_dcb_config(hw);
 
 	/* If Firmware version == v4.33 on X710/XL710, use old CEE struct */
-	if ((hw->mac.type == I40E_MAC_XL710) &&
-	    ((hw->aq.fw_maj_ver == 4) && (hw->aq.fw_min_ver == 33))) {
+	if (hw->mac.type == I40E_MAC_XL710 && i40e_is_fw_ver_eq(hw, 4, 33)) {
 		ret = i40e_aq_get_cee_dcb_config(hw, &cee_v1_cfg,
 						 sizeof(cee_v1_cfg), NULL);
 		if (!ret) {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 8948bdc8bda1..7ded598a68e6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -15819,15 +15819,15 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		 hw->vendor_id, hw->device_id, hw->subsystem_vendor_id,
 		 hw->subsystem_device_id);
 
-	if (hw->aq.api_maj_ver == I40E_FW_API_VERSION_MAJOR &&
-	    hw->aq.api_min_ver > I40E_FW_MINOR_VERSION(hw))
+	if (i40e_is_aq_api_ver_ge(hw, I40E_FW_API_VERSION_MAJOR,
+				  I40E_FW_MINOR_VERSION(hw) + 1))
 		dev_dbg(&pdev->dev,
 			"The driver for the device detected a newer version of the NVM image v%u.%u than v%u.%u.\n",
 			 hw->aq.api_maj_ver,
 			 hw->aq.api_min_ver,
 			 I40E_FW_API_VERSION_MAJOR,
 			 I40E_FW_MINOR_VERSION(hw));
-	else if (hw->aq.api_maj_ver == 1 && hw->aq.api_min_ver < 4)
+	else if (i40e_is_aq_api_ver_lt(hw, 1, 4))
 		dev_info(&pdev->dev,
 			 "The driver for the device detected an older version of the NVM image v%u.%u than expected v%u.%u. Please update the NVM image.\n",
 			 hw->aq.api_maj_ver,
-- 
2.41.0


