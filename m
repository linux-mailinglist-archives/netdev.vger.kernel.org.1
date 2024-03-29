Return-Path: <netdev+bounces-83253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FE489179A
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 12:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3043B1C217D9
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 11:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DB46A34D;
	Fri, 29 Mar 2024 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3CXEN6Z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D369513AF2
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 11:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711711435; cv=none; b=WUhGCDYOpK50QXMVbS/l6KE4LA1X5PxENnT5XpE/BdWBBmlZ9QsIIAQEJiJfBZIh805M6XU24+WdM8QdZXA47KOI1av8ukCXiBuC3KRfPBwm4/b242wVJoBijgw5L+B7V90Cq0ej7YstV9MRv1t/mZd9QEoFzlpnif8OAEaCquQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711711435; c=relaxed/simple;
	bh=5C6enD4DkTjMgpjXu28pdzwKLa/e87wqKcTJf5NZQ5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9dQIYTgTpBCzlYwN2hxerW5af32bpWhadwijlU1mGKjf3Rv/jhld4xJM6mEQjqclWHwCP102RUYPI55Mlj8MNlR/rfei4fveCbcyz2W5mT5QUWO98hgEZQYYYEVfRzN8/j6NTY6zzw9QEJ4PzoaTbCB7E+9kdSjrCYicr5vJDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3CXEN6Z; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711711434; x=1743247434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5C6enD4DkTjMgpjXu28pdzwKLa/e87wqKcTJf5NZQ5c=;
  b=h3CXEN6ZEcbajGiU1IRNAYDibXQlA7h7iTei7kD366HUXPpu+Vjjj/O9
   /aCEN+zQtIH9CkESQ/HGFQgSZu4QOQ+MoUoM5yYH2pXSBGPAIsLTbD36g
   BxGVA8HA2BkAvIXCKcLlrUzp45Ypix3qs5eDnWmm4B8jk06MtNJu9QVmD
   wUPVzwXToIo71nc7R1HwIOUk7EGQ4Y3YfP3qIXxFlvfW2OzA16lB597gh
   k9V3l4ESUEOrUNZ2aekl8Zl8qxqMvK3AgpnkfDt7NdCT9lj8yUWYgXcI3
   k33td0DM8z++kjFI0u6N1pBcIIymcXMB2jHsKK+wJabW/yrlQun1e2ZIq
   w==;
X-CSE-ConnectionGUID: +S3ci3aVSBWuAmuoYdc2SA==
X-CSE-MsgGUID: /Y0GpQ7SSd+C92lpA/TLsA==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6755184"
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="6755184"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 04:23:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="16836699"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by fmviesa010.fm.intel.com with ESMTP; 29 Mar 2024 04:23:51 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH v3 iwl-next 04/12] ice: Add PHY OFFSET_READY register clearing
Date: Fri, 29 Mar 2024 12:21:48 +0100
Message-ID: <20240329112339.29642-18-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329112339.29642-14-karol.kolacinski@intel.com>
References: <20240329112339.29642-14-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a possibility to mark all transmitted/received timestamps as invalid
by clearing PHY OFFSET_READY registers.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 11 ++++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 32 +++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  1 +
 3 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 3019988a43c8..7980482bbf56 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1930,11 +1930,14 @@ ice_ptp_settime64(struct ptp_clock_info *info, const struct timespec64 *ts)
 	struct ice_hw *hw = &pf->hw;
 	int err;
 
-	/* For Vernier mode, we need to recalibrate after new settime
-	 * Start with disabling timestamp block
+	/* For Vernier mode on E82X, we need to recalibrate after new settime.
+	 * Start with marking timestamps as invalid.
 	 */
-	if (pf->ptp.port.link_up)
-		ice_ptp_port_phy_stop(&pf->ptp.port);
+	if (hw->ptp.phy_model == ICE_PHY_E82X) {
+		err = ice_ptp_clear_phy_offset_ready_e82x(hw);
+		if (err)
+			dev_warn(ice_pf_to_dev(pf), "Failed to mark timestamps as invalid before settime\n");
+	}
 
 	if (!ice_ptp_lock(hw)) {
 		err = -EBUSY;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 12f04ad263c5..6967a918ab5e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2405,6 +2405,38 @@ int ice_phy_cfg_rx_offset_e82x(struct ice_hw *hw, u8 port)
 	return 0;
 }
 
+/**
+ * ice_ptp_clear_phy_offset_ready_e82x - Clear PHY TX_/RX_OFFSET_READY registers
+ * @hw: pointer to the HW struct
+ *
+ * Clear PHY TX_/RX_OFFSET_READY registers, effectively marking all transmitted
+ * and received timestamps as invalid.
+ */
+int ice_ptp_clear_phy_offset_ready_e82x(struct ice_hw *hw)
+{
+	u8 port;
+
+	for (port = 0; port < hw->ptp.num_lports; port++) {
+		int err;
+
+		err = ice_write_phy_reg_e82x(hw, port, P_REG_TX_OR, 0);
+		if (err) {
+			dev_warn(ice_hw_to_dev(hw),
+				 "Failed to clear PHY TX_OFFSET_READY register\n");
+			return err;
+		}
+
+		err = ice_write_phy_reg_e82x(hw, port, P_REG_RX_OR, 0);
+		if (err) {
+			dev_warn(ice_hw_to_dev(hw),
+				 "Failed to clear PHY RX_OFFSET_READY register\n");
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * ice_read_phy_and_phc_time_e82x - Simultaneously capture PHC and PHY time
  * @hw: pointer to the HW struct
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 5645b20a9f87..5223e17d2806 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -208,6 +208,7 @@ int ice_ptp_init_time(struct ice_hw *hw, u64 time);
 int ice_ptp_write_incval(struct ice_hw *hw, u64 incval);
 int ice_ptp_write_incval_locked(struct ice_hw *hw, u64 incval);
 int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj);
+int ice_ptp_clear_phy_offset_ready_e82x(struct ice_hw *hw);
 int ice_read_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx, u64 *tstamp);
 int ice_clear_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx);
 void ice_ptp_reset_ts_memory(struct ice_hw *hw);
-- 
2.43.0


