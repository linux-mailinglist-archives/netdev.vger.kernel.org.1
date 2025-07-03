Return-Path: <netdev+bounces-203900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB14AF7F4A
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 19:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588E01CA2086
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 17:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0B82F2C66;
	Thu,  3 Jul 2025 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jsYw9SK3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B5F2F2C43
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751564576; cv=none; b=N2MGmwYe+hn8HZs/TBvAbJH0ivU0WVAkqb1uzhKb/oiwPwKQD40XdmsLveZ89vsAhCumDSGBAt55HOSBTfMwZOutkCql5TKIdIJlEEbsdnOXoz4G8HYxCydRA1w4PW5PXH17Lv/X7tOjwkA0d9/h11Rn0xBCC1Z4gLUXclaW9Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751564576; c=relaxed/simple;
	bh=l4UWPScS2b+lmBtxXsorNbdPMx8LRxUWQM6SeXXk9/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZDASKoy8Fdt2qo+kojM0vt9BMGQVjT3H6ETmZTBJdlr38OeU0H7ABnjwovzLyOFOq3Tlf0qbH8CjoNLQ2mcNVGFmqg+v0Ux7d2nI8sduHw232J1KMxROwuBRFo/qsMuf5LLU8uiLQkmpDlOk//r7uFIlolmoQy18XczTQ3ZAvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jsYw9SK3; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751564575; x=1783100575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l4UWPScS2b+lmBtxXsorNbdPMx8LRxUWQM6SeXXk9/M=;
  b=jsYw9SK3BQ4KSSMXhH2dfmCv60ghbUtF+ceBzAV34PBF3f7ioCOsVIGg
   +c6Wd4srj5B5unmnAHIJWNaycxUz96QVCpqjKKZYDL7aeBvOmONB5mp6g
   oBG0daBg31ZYAyrGkG7d0jsRqbVWbvyg0v3BOWUIw5OdKioSk9Q14a8BT
   /kxDSDmejLhfKp+8BURUwtxLt1DsIXi2YWBxEktER9Gby8SaAfa/1OtPB
   LIp5ZlaWpHQHlK0J6HRYw3FkYlVHoWR2IS8T1JUrq/VjnM7/zAE9aXB6o
   iCjRL8Q8ojpLhmGjY8JnL5kRtLEQOt6QgwZjsrLps5GuRSGS32gm/+i7p
   Q==;
X-CSE-ConnectionGUID: tAgpWRtPReeUwUoQQe8SSQ==
X-CSE-MsgGUID: GK1bRdJpSRu6Xv7v1aDfTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53767963"
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="53767963"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 10:42:52 -0700
X-CSE-ConnectionGUID: nk3kXSBxSjiKnpNXmVrXlA==
X-CSE-MsgGUID: eNrDepM+S/GzaWT5kOk8tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="154997928"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 03 Jul 2025 10:42:51 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	anthony.l.nguyen@intel.com
Subject: [PATCH net-next 10/12] ixgbe: spelling corrections
Date: Thu,  3 Jul 2025 10:42:37 -0700
Message-ID: <20250703174242.3829277-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250703174242.3829277-1-anthony.l.nguyen@intel.com>
References: <20250703174242.3829277-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Simon Horman <horms@kernel.org>

Correct spelling as flagged by codespell.

Signed-off-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c  | 4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c   | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c    | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   | 8 ++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h    | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c    | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c  | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h   | 4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c   | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c   | 2 +-
 11 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
index 444da982593f..406c15f58034 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
@@ -45,7 +45,7 @@ static void ixgbe_set_pcie_completion_timeout(struct ixgbe_hw *hw)
 		goto out;
 
 	/*
-	 * if capababilities version is type 1 we can write the
+	 * if capabilities version is type 1 we can write the
 	 * timeout of 10ms to 250ms through the GCR register
 	 */
 	if (!(gcr & IXGBE_GCR_CAP_VER2)) {
@@ -751,7 +751,7 @@ static int ixgbe_reset_hw_82598(struct ixgbe_hw *hw)
 	/*
 	 * Store the original AUTOC value if it has not been
 	 * stored off yet.  Otherwise restore the stored original
-	 * AUTOC value since the reset operation sets back to deaults.
+	 * AUTOC value since the reset operation sets back to defaults.
 	 */
 	autoc = IXGBE_READ_REG(hw, IXGBE_AUTOC);
 	if (hw->mac.orig_link_settings_stored == false) {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 5784d5d1896e..4ff19426ab74 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -244,7 +244,7 @@ int ixgbe_setup_fc_generic(struct ixgbe_hw *hw)
 	 */
 	if (hw->phy.media_type == ixgbe_media_type_backplane) {
 		/* Need the SW/FW semaphore around AUTOC writes if 82599 and
-		 * LESM is on, likewise reset_pipeline requries the lock as
+		 * LESM is on, likewise reset_pipeline requires the lock as
 		 * it also writes AUTOC.
 		 */
 		ret_val = hw->mac.ops.prot_autoc_write(hw, reg_bp, locked);
@@ -301,7 +301,7 @@ int ixgbe_start_hw_generic(struct ixgbe_hw *hw)
 			return ret_val;
 	}
 
-	/* Cashe bit indicating need for crosstalk fix */
+	/* Cache bit indicating need for crosstalk fix */
 	switch (hw->mac.type) {
 	case ixgbe_mac_82599EB:
 	case ixgbe_mac_X550EM_x:
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
index 7dcf6ecd157b..011fda9c6193 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
@@ -744,7 +744,7 @@ void ixgbe_free_fcoe_ddp_resources(struct ixgbe_adapter *adapter)
  * ixgbe_setup_fcoe_ddp_resources - setup all fcoe ddp context resources
  * @adapter: ixgbe adapter
  *
- * Sets up ddp context resouces
+ * Sets up ddp context resources
  *
  * Returns : 0 indicates success or -EINVAL on failure
  */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
index 54d75cf94cc1..170a29d162c6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
@@ -891,7 +891,7 @@ static int ixgbe_alloc_q_vector(struct ixgbe_adapter *adapter,
 	q_vector->rx.itr = IXGBE_ITR_ADAPTIVE_MAX_USECS |
 			   IXGBE_ITR_ADAPTIVE_LATENCY;
 
-	/* intialize ITR */
+	/* initialize ITR */
 	if (txr_count && !rxr_count) {
 		/* tx only vector */
 		if (adapter->tx_itr_setting == 1)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 4f2d7f6e3faa..6122a0abb41f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2371,7 +2371,7 @@ static struct sk_buff *ixgbe_build_skb(struct ixgbe_ring *rx_ring,
 	struct sk_buff *skb;
 
 	/* Prefetch first cache line of first page. If xdp->data_meta
-	 * is unused, this points extactly as xdp->data, otherwise we
+	 * is unused, this points exactly as xdp->data, otherwise we
 	 * likely have a consumer accessing first few bytes of meta
 	 * data, and then actual data.
 	 */
@@ -2494,7 +2494,7 @@ static void ixgbe_rx_buffer_flip(struct ixgbe_ring *rx_ring,
  * This function provides a "bounce buffer" approach to Rx interrupt
  * processing.  The advantage to this is that on systems that have
  * expensive overhead for IOMMU access this provides a means of avoiding
- * it by maintaining the mapping of the page to the syste.
+ * it by maintaining the mapping of the page to the system.
  *
  * Returns amount of work completed
  **/
@@ -5063,7 +5063,7 @@ static void ixgbe_scrub_vfta(struct ixgbe_adapter *adapter, u32 vfta_offset)
 		/* pull VLAN ID from VLVF */
 		vid = vlvf & VLAN_VID_MASK;
 
-		/* only concern outselves with a certain range */
+		/* only concern ourselves with a certain range */
 		if (vid < vid_start || vid >= vid_end)
 			continue;
 
@@ -11289,7 +11289,7 @@ void ixgbe_txrx_ring_enable(struct ixgbe_adapter *adapter, int ring)
  * ixgbe_enumerate_functions - Get the number of ports this device has
  * @adapter: adapter structure
  *
- * This function enumerates the phsyical functions co-located on a single slot,
+ * This function enumerates the physical functions co-located on a single slot,
  * in order to determine how many ports a device has. This is most useful in
  * determining the required GT/s of PCIe bandwidth necessary for optimal
  * performance.
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
index bf65e82b4c61..4af149b63a39 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
@@ -34,7 +34,7 @@
 #define IXGBE_VT_MSGTYPE_CTS      0x20000000  /* Indicates that VF is still
 						 clear to send requests */
 #define IXGBE_VT_MSGINFO_SHIFT    16
-/* bits 23:16 are used for exra info for certain messages */
+/* bits 23:16 are used for extra info for certain messages */
 #define IXGBE_VT_MSGINFO_MASK     (0xFF << IXGBE_VT_MSGINFO_SHIFT)
 
 /* definitions to support mailbox API version negotiation */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index 2d54828bdfbb..2449e4cf2679 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -1323,7 +1323,7 @@ int ixgbe_check_phy_link_tnx(struct ixgbe_hw *hw, ixgbe_link_speed *speed,
  *	@hw: pointer to hardware structure
  *
  *	Restart autonegotiation and PHY and waits for completion.
- *      This function always returns success, this is nessary since
+ *	This function always returns success, this is necessary since
  *	it is called via a function pointer that could call other
  *	functions that could return an error.
  **/
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index bd9a054d7d94..32ac1e020d91 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -706,7 +706,7 @@ static inline void ixgbe_vf_reset_event(struct ixgbe_adapter *adapter, u32 vf)
 	u32 reg_val;
 	u32 queue;
 
-	/* remove VLAN filters beloning to this VF */
+	/* remove VLAN filters belonging to this VF */
 	ixgbe_clear_vf_vlans(adapter, vf);
 
 	/* add back PF assigned VLAN or VLAN 0 */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 80dfc94c89f7..36577091cd9e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -238,7 +238,7 @@ struct ixgbe_thermal_sensor_data {
 #define NVM_VER_INVALID		0xFFFF
 #define NVM_ETK_VALID		0x8000
 #define NVM_INVALID_PTR		0xFFFF
-#define NVM_VER_SIZE		32   /* version sting size */
+#define NVM_VER_SIZE		32   /* version string size */
 
 struct ixgbe_nvm_version {
 	u32 etk_id;
@@ -2024,7 +2024,7 @@ enum {
 /* EEPROM Addressing bits based on type (0-small, 1-large) */
 #define IXGBE_EEC_ADDR_SIZE 0x00000400
 #define IXGBE_EEC_SIZE      0x00007800 /* EEPROM Size */
-#define IXGBE_EERD_MAX_ADDR 0x00003FFF /* EERD alows 14 bits for addr. */
+#define IXGBE_EERD_MAX_ADDR 0x00003FFF /* EERD allows 14 bits for addr. */
 
 #define IXGBE_EEC_SIZE_SHIFT          11
 #define IXGBE_EEPROM_WORD_SIZE_SHIFT  6
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
index f1ab95aa8c83..c2353aed0120 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
@@ -47,7 +47,7 @@ int ixgbe_get_invariants_X540(struct ixgbe_hw *hw)
 }
 
 /**
- *  ixgbe_setup_mac_link_X540 - Set the auto advertised capabilitires
+ *  ixgbe_setup_mac_link_X540 - Set the auto advertised capabilities
  *  @hw: pointer to hardware structure
  *  @speed: new link speed
  *  @autoneg_wait_to_complete: true when waiting for completion is needed
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index a8263f59ebba..bfa647086c70 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -3316,7 +3316,7 @@ static enum ixgbe_media_type ixgbe_get_media_type_X550em(struct ixgbe_hw *hw)
 	return media_type;
 }
 
-/** ixgbe_init_ext_t_x550em - Start (unstall) the external Base T PHY.
+/** ixgbe_init_ext_t_x550em - Start (uninstall) the external Base T PHY.
  ** @hw: pointer to hardware structure
  **/
 static int ixgbe_init_ext_t_x550em(struct ixgbe_hw *hw)
-- 
2.47.1


