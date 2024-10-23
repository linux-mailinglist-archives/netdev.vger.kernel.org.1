Return-Path: <netdev+bounces-138229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43BA9ACA7F
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63501C23F52
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF161C3042;
	Wed, 23 Oct 2024 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fyGohM6l"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2D81B4F1F
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729687529; cv=none; b=OWhp4ZDcIt3fV89vLyqalUTI6cWRZ9EBJ3KWiANyR4OR02OM+8OyJUwY01gL8iD8sZcCjPan2hvsA6sfPOoX9XBmSZ1CJ0OgT+PrUKR57aayKrcc8CE8D+0RH4AMjMAOxv8t6mY2HvTFmRHyu0gEbCEN8RpE+SjY48IKo8nfokw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729687529; c=relaxed/simple;
	bh=gay8YKWqKB5Vo7s5ss/WtgJlXanEHy0FtC9Q71hTvUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H55/xnRArli/gllktYhsw6H2QqkXjKPU3WWp4ilhuInp92CmADxyVVLSzFHk3e7O78GkZnbiYOtuqEN7OtMr/HRDNPwzBfSiRFynmxV6nXCzP1z5PYb50r6nJ3r6lA6jpY7UhglvNqNpl2HtIXVgMadn48nlfw12ARYsHlL3VXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fyGohM6l; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729687528; x=1761223528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gay8YKWqKB5Vo7s5ss/WtgJlXanEHy0FtC9Q71hTvUY=;
  b=fyGohM6lpXVNtm8mX+fFnZVJbvI/za7q9AtzLWhfZfVKaDmg6WffaQbC
   TuBySaP+MEg/pwOTxI5jL/m1mnT+4omr5U45ViCQ/IHcQIjpeS9BBtXPn
   jHpMMSZDcklmf6Ntz0XeYEyWnQDQmUE2zIbdJY9ueBtD7ojGEHMlauZxG
   xsjH4gb13ITHVo2n+oDNaHdE8gu0058oCbYbyUGh3kE6mxLkvCqPfSqvn
   ZvxfsiPsd8H5kKepzPavL7mabhgTVed3eF40uSsv90fA6QZgDkqsP9qUm
   hJDu9CQuQeaWcSmR97YjRQhIpe9YdDDrk7M0Vcvz25CwNVQlmrzrnlwhk
   Q==;
X-CSE-ConnectionGUID: LpnKV/utQlu8zq60S17rkQ==
X-CSE-MsgGUID: 12VE/tAdSYWfEeSWBayUaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51814169"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51814169"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 05:45:26 -0700
X-CSE-ConnectionGUID: 9aqfdRgBSs+IAzq1TNHH9g==
X-CSE-MsgGUID: Z7qqp0HdSiOF3wRXBcbujg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="80119845"
Received: from pkwapuli-mobl1.ger.corp.intel.com (HELO vbox-pkwap.ger.corp.intel.com) ([10.246.19.66])
  by orviesa010.jf.intel.com with ESMTP; 23 Oct 2024 05:45:25 -0700
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v10 6/7] ixgbe: Clean up the E610 link management related code
Date: Wed, 23 Oct 2024 14:43:57 +0200
Message-ID: <20241023124358.6967-7-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241023124358.6967-1-piotr.kwapulinski@intel.com>
References: <20241023124358.6967-1-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Required for enabling the link management in E610 device.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 17 +++++++++++------
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 12 ++++++------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 6cb790b..af7f9494 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -236,6 +236,9 @@ static int ixgbe_get_parent_bus_info(struct ixgbe_adapter *adapter)
  * bandwidth details should be gathered from the parent bus instead of from the
  * device. Used to ensure that various locations all have the correct device ID
  * checks.
+ *
+ * Return: true if information should be collected from the parent bus, false
+ *         otherwise
  */
 static inline bool ixgbe_pcie_from_parent(struct ixgbe_hw *hw)
 {
@@ -5532,7 +5535,9 @@ static void ixgbe_sfp_link_config(struct ixgbe_adapter *adapter)
  * ixgbe_non_sfp_link_config - set up non-SFP+ link
  * @hw: pointer to private hardware struct
  *
- * Returns 0 on success, negative on failure
+ * Configure non-SFP link.
+ *
+ * Return: 0 on success, negative on failure
  **/
 static int ixgbe_non_sfp_link_config(struct ixgbe_hw *hw)
 {
@@ -7221,11 +7226,11 @@ void ixgbe_update_stats(struct ixgbe_adapter *adapter)
 	for (i = 0; i < 16; i++) {
 		hwstats->qptc[i] += IXGBE_READ_REG(hw, IXGBE_QPTC(i));
 		hwstats->qprc[i] += IXGBE_READ_REG(hw, IXGBE_QPRC(i));
-		if ((hw->mac.type == ixgbe_mac_82599EB) ||
-		    (hw->mac.type == ixgbe_mac_X540) ||
-		    (hw->mac.type == ixgbe_mac_X550) ||
-		    (hw->mac.type == ixgbe_mac_X550EM_x) ||
-		    (hw->mac.type == ixgbe_mac_x550em_a)) {
+		if (hw->mac.type == ixgbe_mac_82599EB ||
+		    hw->mac.type == ixgbe_mac_X540 ||
+		    hw->mac.type == ixgbe_mac_X550 ||
+		    hw->mac.type == ixgbe_mac_X550EM_x ||
+		    hw->mac.type == ixgbe_mac_x550em_a) {
 			hwstats->qbtc[i] += IXGBE_READ_REG(hw, IXGBE_QBTC_L(i));
 			IXGBE_READ_REG(hw, IXGBE_QBTC_H(i)); /* to clear */
 			hwstats->qbrc[i] += IXGBE_READ_REG(hw, IXGBE_QBRC_L(i));
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index a5f6449..7eeafc9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -3504,13 +3504,13 @@ static int ixgbe_reset_hw_X550em(struct ixgbe_hw *hw)
 	return status;
 }
 
-/** ixgbe_set_ethertype_anti_spoofing_X550 - Enable/Disable Ethertype
+/** ixgbe_set_ethertype_anti_spoofing_x550 - Enable/Disable Ethertype
  *	anti-spoofing
  *  @hw:  pointer to hardware structure
  *  @enable: enable or disable switch for Ethertype anti-spoofing
  *  @vf: Virtual Function pool - VF Pool to set for Ethertype anti-spoofing
  **/
-static void ixgbe_set_ethertype_anti_spoofing_X550(struct ixgbe_hw *hw,
+static void ixgbe_set_ethertype_anti_spoofing_x550(struct ixgbe_hw *hw,
 						   bool enable, int vf)
 {
 	int vf_target_reg = vf >> 3;
@@ -3526,12 +3526,12 @@ static void ixgbe_set_ethertype_anti_spoofing_X550(struct ixgbe_hw *hw,
 	IXGBE_WRITE_REG(hw, IXGBE_PFVFSPOOF(vf_target_reg), pfvfspoof);
 }
 
-/** ixgbe_set_source_address_pruning_X550 - Enable/Disbale src address pruning
+/** ixgbe_set_source_address_pruning_x550 - Enable/Disable src address pruning
  *  @hw: pointer to hardware structure
  *  @enable: enable or disable source address pruning
  *  @pool: Rx pool to set source address pruning for
  **/
-static void ixgbe_set_source_address_pruning_X550(struct ixgbe_hw *hw,
+static void ixgbe_set_source_address_pruning_x550(struct ixgbe_hw *hw,
 						  bool enable,
 						  unsigned int pool)
 {
@@ -3830,9 +3830,9 @@ static int ixgbe_write_phy_reg_x550a(struct ixgbe_hw *hw, u32 reg_addr,
 	.set_mac_anti_spoofing		= &ixgbe_set_mac_anti_spoofing, \
 	.set_vlan_anti_spoofing		= &ixgbe_set_vlan_anti_spoofing, \
 	.set_source_address_pruning	= \
-				&ixgbe_set_source_address_pruning_X550, \
+				&ixgbe_set_source_address_pruning_x550, \
 	.set_ethertype_anti_spoofing	= \
-				&ixgbe_set_ethertype_anti_spoofing_X550, \
+				&ixgbe_set_ethertype_anti_spoofing_x550, \
 	.disable_rx_buff		= &ixgbe_disable_rx_buff_generic, \
 	.enable_rx_buff			= &ixgbe_enable_rx_buff_generic, \
 	.get_thermal_sensor_data	= NULL, \
-- 
2.43.0


