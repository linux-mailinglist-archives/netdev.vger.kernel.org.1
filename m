Return-Path: <netdev+bounces-98255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF0D8D06D4
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 17:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76E56B327CB
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 15:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7626016B72F;
	Mon, 27 May 2024 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JsH71h82"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D727C16B720
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716821605; cv=none; b=kH3MCN72m4zK2sroiUmYHyN6aBI/Br8SfiSk2FpR3vA/zN07dM+HWy05yIdB3Xel3ipl9ZBLDyMJodUZK8LdB7qr0oSz50XNQB/E3/tzWk6gUY/0ywXyPMZXkpJKcT50zUTeTo3U1siMR+lJrV+emFp8Ytt3m/cIKRKmAx1gpxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716821605; c=relaxed/simple;
	bh=K5m2OvGkWLJ5usgFsiU07B9gBGXYjsor/hfiWd4Kdf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NLcnytYm54iZecaewKcnTsPC1TLX1RWUhcAxjRpNXQN1atRzIOYDr6pMIRVwjBsoI+Xeajd3WVkjQmRHfTBhaggNWxDaIxfDra8/z6ho0m2WlRHOz8qqKIo/QW8tk+pwEROxV+HthZHJ2mjxJ41DZoF5RfY0ebd801+7XEYosn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JsH71h82; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716821604; x=1748357604;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K5m2OvGkWLJ5usgFsiU07B9gBGXYjsor/hfiWd4Kdf0=;
  b=JsH71h82U5u/MvjQ3c7qdjHVBeAINndYWV+FryUhuqcbGXUzDrR7idIJ
   pQPaR3uZfOyS2pYzW8wMQgN2XyiKt4ieo6mmdf/fBtriraNTg0/KXLGN/
   9jeSCOEz3pcpqn3bsRE2YFrb7gIHqjgJcWtkUjbJxbJYOTKg05LJaFnb+
   U8sbFACIuddKCfpSAWc1kA+GCD1QYN3/0oCUqBn0+HrNhTfh7ri5WPhU6
   8x9SRRUfLuHdzEIxiDxwOu5OewGkBK/bKZ+sqfnrz82RM3AmCUfYGrSHa
   kgvnSz5fQLWi+mVZU9/6lyeWKkphlyqxm+1KKetjVcmYWZwozT09d6TZd
   w==;
X-CSE-ConnectionGUID: j4wK0I5zTgesZeaFsCLu8A==
X-CSE-MsgGUID: 6pSkeICtRvCYQ4WsaKqzwA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="11715268"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="11715268"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 07:53:23 -0700
X-CSE-ConnectionGUID: U14Ut1lbR6iEZWPKuqPz8g==
X-CSE-MsgGUID: SEwkiI0nTBqDm6RbRluYMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="39192033"
Received: from amlin-018-251.igk.intel.com (HELO localhost.localdomain) ([10.102.18.251])
  by fmviesa005.fm.intel.com with ESMTP; 27 May 2024 07:53:22 -0700
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next v7 6/7] ixgbe: Clean up the E610 link management related code
Date: Mon, 27 May 2024 17:10:22 +0200
Message-Id: <20240527151023.3634-7-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240527151023.3634-1-piotr.kwapulinski@intel.com>
References: <20240527151023.3634-1-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Required for enabling the link management in E610 device.

Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 17 +++++++++++------
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 12 ++++++------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 094653e..d18c46c 100644
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
@@ -5534,7 +5537,9 @@ static void ixgbe_sfp_link_config(struct ixgbe_adapter *adapter)
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
@@ -7223,11 +7228,11 @@ void ixgbe_update_stats(struct ixgbe_adapter *adapter)
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
2.31.1


