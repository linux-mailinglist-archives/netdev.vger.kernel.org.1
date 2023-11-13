Return-Path: <netdev+bounces-47509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4E17EA6BD
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235CB1F23080
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE393E48E;
	Mon, 13 Nov 2023 23:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E2Uddfkm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FAB3E478
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:11:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17C5D55
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699917060; x=1731453060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=loDVw9NK7A6jlYT47ck8TKzqrp5WKHVhSbj8yHv1Lw8=;
  b=E2Uddfkm68H1OkUMXly0as2F/i/ZTeFJXrPrqHimtVCfbImxfgQgl1k4
   rLy8CEm0s99ZusUTe6WZVWNmr89GbHdCRW8Xzp7bs/bdy4cTem5LBTFzz
   CQ7KOT4i/qn3ge34n+Lq2IJgmoczOMiSR3jqTZKTkGuk+tD1BuyWDj2gp
   louRj2fBFYhcemF15JlFWVesb04Ipqa5Mqt4lwe/7XnOr43NL5aqYaQIO
   nYhr6HSNWeL68HZ4x4od3boL/dQgDWpDeGnx4yzmTVRC8+l3Fxj0DW9a1
   JYdbUZczv3fhjSJ75z5P56PMZqtUTixnHAEmxCBedJNLa17/elQcjniEG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="375562640"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="375562640"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 15:10:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="888051420"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="888051420"
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
	Jacob Keller <jacob.e.keller@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 09/15] i40e: Initialize hardware capabilities at single place
Date: Mon, 13 Nov 2023 15:10:28 -0800
Message-ID: <20231113231047.548659-10-anthony.l.nguyen@intel.com>
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

Some i40e_hw.caps bits are set in i40e_set_hw_caps(), some of them
in i40e_init_adminq() and the rest of them in i40e_sw_init().
Consolidate the initialization to single proper place i40e_set_hw_caps().

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c | 66 ++++++++++++++-----
 drivers/net/ethernet/intel/i40e/i40e_debug.h  |  1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 55 +---------------
 .../net/ethernet/intel/i40e/i40e_register.h   |  1 +
 4 files changed, 51 insertions(+), 72 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index 6754f6b3508c..86591140f748 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -522,10 +522,52 @@ static void i40e_set_hw_caps(struct i40e_hw *hw)
 			/* The ability to RX (not drop) 802.1ad frames */
 			set_bit(I40E_HW_CAP_802_1AD, hw->caps);
 		}
+		if ((aq->api_maj_ver == 1 && aq->api_min_ver > 4) ||
+		    aq->api_maj_ver > 1) {
+			/* Supported in FW API version higher than 1.4 */
+			set_bit(I40E_HW_CAP_GENEVE_OFFLOAD, hw->caps);
+		}
+		if ((aq->fw_maj_ver == 4 && aq->fw_min_ver < 33) ||
+		    aq->fw_maj_ver < 4) {
+			set_bit(I40E_HW_CAP_RESTART_AUTONEG, hw->caps);
+			/* No DCB support  for FW < v4.33 */
+			set_bit(I40E_HW_CAP_NO_DCB_SUPPORT, hw->caps);
+		}
+		if ((aq->fw_maj_ver == 4 && aq->fw_min_ver < 3) ||
+		    aq->fw_maj_ver < 4) {
+			/* Disable FW LLDP if FW < v4.3 */
+			set_bit(I40E_HW_CAP_STOP_FW_LLDP, hw->caps);
+		}
+		if ((aq->fw_maj_ver == 4 && aq->fw_min_ver >= 40) ||
+		    aq->fw_maj_ver >= 5) {
+			/* Use the FW Set LLDP MIB API if FW > v4.40 */
+			set_bit(I40E_HW_CAP_USE_SET_LLDP_MIB, hw->caps);
+		}
+		if (aq->fw_maj_ver >= 6) {
+			/* Enable PTP L4 if FW > v6.0 */
+			set_bit(I40E_HW_CAP_PTP_L4, hw->caps);
+		}
 		break;
 	case I40E_MAC_X722:
 		set_bit(I40E_HW_CAP_AQ_SRCTL_ACCESS_ENABLE, hw->caps);
 		set_bit(I40E_HW_CAP_NVM_READ_REQUIRES_LOCK, hw->caps);
+		set_bit(I40E_HW_CAP_RSS_AQ, hw->caps);
+		set_bit(I40E_HW_CAP_128_QP_RSS, hw->caps);
+		set_bit(I40E_HW_CAP_ATR_EVICT, hw->caps);
+		set_bit(I40E_HW_CAP_WB_ON_ITR, hw->caps);
+		set_bit(I40E_HW_CAP_MULTI_TCP_UDP_RSS_PCTYPE, hw->caps);
+		set_bit(I40E_HW_CAP_NO_PCI_LINK_CHECK, hw->caps);
+		set_bit(I40E_HW_CAP_USE_SET_LLDP_MIB, hw->caps);
+		set_bit(I40E_HW_CAP_GENEVE_OFFLOAD, hw->caps);
+		set_bit(I40E_HW_CAP_PTP_L4, hw->caps);
+		set_bit(I40E_HW_CAP_WOL_MC_MAGIC_PKT_WAKE, hw->caps);
+		set_bit(I40E_HW_CAP_OUTER_UDP_CSUM, hw->caps);
+
+		if (rd32(hw, I40E_GLQF_FDEVICTENA(1)) !=
+		    I40E_FDEVICT_PCTYPE_DEFAULT) {
+			hw_warn(hw, "FD EVICT PCTYPES are not right, disable FD HW EVICT\n");
+			clear_bit(I40E_HW_CAP_ATR_EVICT, hw->caps);
+		}
 
 		if (aq->api_maj_ver > 1 ||
 		    (aq->api_maj_ver == 1 &&
@@ -553,6 +595,12 @@ static void i40e_set_hw_caps(struct i40e_hw *hw)
 	     aq->api_min_ver >= 5))
 		set_bit(I40E_HW_CAP_NVM_READ_REQUIRES_LOCK, hw->caps);
 
+	/* The ability to RX (not drop) 802.1ad frames was added in API 1.7 */
+	if (aq->api_maj_ver > 1 ||
+	    (aq->api_maj_ver == 1 &&
+	     aq->api_min_ver >= 7))
+		set_bit(I40E_HW_CAP_802_1AD, hw->caps);
+
 	if (aq->api_maj_ver > 1 ||
 	    (aq->api_maj_ver == 1 &&
 	     aq->api_min_ver >= 8))
@@ -646,24 +694,6 @@ int i40e_init_adminq(struct i40e_hw *hw)
 			   &oem_lo);
 	hw->nvm.oem_ver = ((u32)oem_hi << 16) | oem_lo;
 
-	if (hw->mac.type == I40E_MAC_XL710 &&
-	    hw->aq.api_maj_ver == I40E_FW_API_VERSION_MAJOR &&
-	    hw->aq.api_min_ver >= I40E_MINOR_VER_GET_LINK_INFO_XL710) {
-		set_bit(I40E_HW_CAP_AQ_PHY_ACCESS, hw->caps);
-		set_bit(I40E_HW_CAP_FW_LLDP_STOPPABLE, hw->caps);
-	}
-	if (hw->mac.type == I40E_MAC_X722 &&
-	    hw->aq.api_maj_ver == I40E_FW_API_VERSION_MAJOR &&
-	    hw->aq.api_min_ver >= I40E_MINOR_VER_FW_LLDP_STOPPABLE_X722) {
-		set_bit(I40E_HW_CAP_FW_LLDP_STOPPABLE, hw->caps);
-	}
-
-	/* The ability to RX (not drop) 802.1ad frames was added in API 1.7 */
-	if (hw->aq.api_maj_ver > 1 ||
-	    (hw->aq.api_maj_ver == 1 &&
-	     hw->aq.api_min_ver >= 7))
-		set_bit(I40E_HW_CAP_802_1AD, hw->caps);
-
 	if (hw->aq.api_maj_ver > I40E_FW_API_VERSION_MAJOR) {
 		ret_code = -EIO;
 		goto init_adminq_free_arq;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debug.h b/drivers/net/ethernet/intel/i40e/i40e_debug.h
index 27ebc72d8bfe..e9871dfb32bd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debug.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_debug.h
@@ -37,6 +37,7 @@ struct i40e_hw;
 struct device *i40e_hw_to_dev(struct i40e_hw *hw);
 
 #define hw_dbg(hw, S, A...) dev_dbg(i40e_hw_to_dev(hw), S, ##A)
+#define hw_warn(hw, S, A...) dev_warn(i40e_hw_to_dev(hw), S, ##A)
 
 #define i40e_debug(h, m, s, ...)				\
 do {								\
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 5696864c5151..8948bdc8bda1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -12782,62 +12782,10 @@ static int i40e_sw_init(struct i40e_pf *pf)
 				 pf->hw.func_caps.fd_filters_best_effort;
 	}
 
-	if (pf->hw.mac.type == I40E_MAC_X722) {
-		set_bit(I40E_HW_CAP_RSS_AQ, pf->hw.caps);
-		set_bit(I40E_HW_CAP_128_QP_RSS, pf->hw.caps);
-		set_bit(I40E_HW_CAP_ATR_EVICT, pf->hw.caps);
-		set_bit(I40E_HW_CAP_WB_ON_ITR, pf->hw.caps);
-		set_bit(I40E_HW_CAP_MULTI_TCP_UDP_RSS_PCTYPE, pf->hw.caps);
-		set_bit(I40E_HW_CAP_NO_PCI_LINK_CHECK, pf->hw.caps);
-		set_bit(I40E_HW_CAP_USE_SET_LLDP_MIB, pf->hw.caps);
-		set_bit(I40E_HW_CAP_GENEVE_OFFLOAD, pf->hw.caps);
-		set_bit(I40E_HW_CAP_PTP_L4, pf->hw.caps);
-		set_bit(I40E_HW_CAP_WOL_MC_MAGIC_PKT_WAKE, pf->hw.caps);
-		set_bit(I40E_HW_CAP_OUTER_UDP_CSUM, pf->hw.caps);
-
-#define I40E_FDEVICT_PCTYPE_DEFAULT 0xc03
-		if (rd32(&pf->hw, I40E_GLQF_FDEVICTENA(1)) !=
-		    I40E_FDEVICT_PCTYPE_DEFAULT) {
-			dev_warn(&pf->pdev->dev,
-				 "FD EVICT PCTYPES are not right, disable FD HW EVICT\n");
-			clear_bit(I40E_HW_CAP_ATR_EVICT, pf->hw.caps);
-		}
-	} else if ((pf->hw.aq.api_maj_ver > 1) ||
-		   ((pf->hw.aq.api_maj_ver == 1) &&
-		    (pf->hw.aq.api_min_ver > 4))) {
-		/* Supported in FW API version higher than 1.4 */
-		set_bit(I40E_HW_CAP_GENEVE_OFFLOAD, pf->hw.caps);
-	}
-
 	/* Enable HW ATR eviction if possible */
 	if (test_bit(I40E_HW_CAP_ATR_EVICT, pf->hw.caps))
 		set_bit(I40E_FLAG_HW_ATR_EVICT_ENA, pf->flags);
 
-	if ((pf->hw.mac.type == I40E_MAC_XL710) &&
-	    (((pf->hw.aq.fw_maj_ver == 4) && (pf->hw.aq.fw_min_ver < 33)) ||
-	    (pf->hw.aq.fw_maj_ver < 4))) {
-		set_bit(I40E_HW_CAP_RESTART_AUTONEG, pf->hw.caps);
-		/* No DCB support  for FW < v4.33 */
-		set_bit(I40E_HW_CAP_NO_DCB_SUPPORT, pf->hw.caps);
-	}
-
-	/* Disable FW LLDP if FW < v4.3 */
-	if ((pf->hw.mac.type == I40E_MAC_XL710) &&
-	    (((pf->hw.aq.fw_maj_ver == 4) && (pf->hw.aq.fw_min_ver < 3)) ||
-	    (pf->hw.aq.fw_maj_ver < 4)))
-		set_bit(I40E_HW_CAP_STOP_FW_LLDP, pf->hw.caps);
-
-	/* Use the FW Set LLDP MIB API if FW > v4.40 */
-	if ((pf->hw.mac.type == I40E_MAC_XL710) &&
-	    (((pf->hw.aq.fw_maj_ver == 4) && (pf->hw.aq.fw_min_ver >= 40)) ||
-	    (pf->hw.aq.fw_maj_ver >= 5)))
-		set_bit(I40E_HW_CAP_USE_SET_LLDP_MIB, pf->hw.caps);
-
-	/* Enable PTP L4 if FW > v6.0 */
-	if (pf->hw.mac.type == I40E_MAC_XL710 &&
-	    pf->hw.aq.fw_maj_ver >= 6)
-		set_bit(I40E_HW_CAP_PTP_L4, pf->hw.caps);
-
 	if (pf->hw.func_caps.vmdq && num_online_cpus() != 1) {
 		pf->num_vmdq_vsis = I40E_DEFAULT_NUM_VMDQ_VSI;
 		set_bit(I40E_FLAG_VMDQ_ENA, pf->flags);
@@ -12855,8 +12803,7 @@ static int i40e_sw_init(struct i40e_pf *pf)
 	 * if NPAR is functioning so unset this hw flag in this case.
 	 */
 	if (pf->hw.mac.type == I40E_MAC_XL710 &&
-	    pf->hw.func_caps.npar_enable &&
-	    test_bit(I40E_HW_CAP_FW_LLDP_STOPPABLE, pf->hw.caps))
+	    pf->hw.func_caps.npar_enable)
 		clear_bit(I40E_HW_CAP_FW_LLDP_STOPPABLE, pf->hw.caps);
 
 #ifdef CONFIG_PCI_IOV
diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
index f408fcf23ce8..d561687303ea 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_register.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
@@ -899,6 +899,7 @@
 #define I40E_GLQF_ORT_FLX_PAYLOAD_SHIFT 7
 #define I40E_GLQF_ORT_FLX_PAYLOAD_MASK I40E_MASK(0x1, I40E_GLQF_ORT_FLX_PAYLOAD_SHIFT)
 #define I40E_GLQF_FDEVICTENA(_i) (0x00270384 + ((_i) * 4)) /* _i=0...1 */ /* Reset: CORER */
+#define I40E_FDEVICT_PCTYPE_DEFAULT 0xc03
 /* Redefined for X722 family */
 #define I40E_GLGEN_STAT_CLEAR 0x00390004 /* Reset: CORER */
 #endif /* _I40E_REGISTER_H_ */
-- 
2.41.0


