Return-Path: <netdev+bounces-83378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73252892172
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 17:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA0C288364
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E985D85627;
	Fri, 29 Mar 2024 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AMFX3ACv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745A812D21F
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711729065; cv=none; b=nLfVqdhLU/zaTBy0IfDQCo22268i0mKj5NdD8G6fumI/y5tHiou0fZHK75Cj0FCHeRcs31j2iNX2GwuKBtlZKOc322P/KVDI4KBD4w4X+560kFC4RM4bseK7pIpSCiF/DcrbkysBwz204kfDlG8UOmsLzUXKzjkzl68XLmfnCzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711729065; c=relaxed/simple;
	bh=5C6enD4DkTjMgpjXu28pdzwKLa/e87wqKcTJf5NZQ5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjGv1ZPkxw7NpW+CfA53NkTGYMlCptuOV7OWPjhyvGXb4VPOmUekKNv4X6eeyA/Tz8EkxaUB9GUg9PWyP2RvuY9bRwJxAyWEYVHyqup/GaWz8hKEVV/YLI6IOgirgRAmlwSINIzvFD1efzPylK5/ky+Vzn0fNZfbhX3Kz5CETdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AMFX3ACv; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711729063; x=1743265063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5C6enD4DkTjMgpjXu28pdzwKLa/e87wqKcTJf5NZQ5c=;
  b=AMFX3ACvZBwCm65Fj2RvCd7wyHLjjPkBEeioSe91a+OlgRNw+pV+jjRw
   lIu8oh3qJMaCpkopD+zVYpN2LGW6XAy6FLNRTPAKAOARnNRGr3UFEKzrX
   8y1wj3vVRakpGuhnpjE74fhk9HNDGtb/Z/idHc2C+S2Bn08S6lCSSTpSK
   Ceabl5w0sRwbHOElwqCAT+GWpSSHDNh4Oi2E6vDZpm8RQ0Ak85SjuWKE9
   EFfk0s9UTGKvYyM0WNwf8WpfRQAYOKGqR0RS60rrVLIGmcPL3e+6uDrle
   dL/zaR1SAetiFPE7xXzpzEfap5Hi0qXmA/II9f3+7BKofJZKf20nda4Vg
   g==;
X-CSE-ConnectionGUID: TkA7iRI/Qd+9GkYFmMYncA==
X-CSE-MsgGUID: jYWm7kiEQQKDvBQZCv/l1w==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="7038321"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="7038321"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 09:17:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="21474511"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by fmviesa005.fm.intel.com with ESMTP; 29 Mar 2024 09:17:42 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH v4 iwl-next 04/12] ice: Add PHY OFFSET_READY register clearing
Date: Fri, 29 Mar 2024 17:09:43 +0100
Message-ID: <20240329161730.47777-18-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329161730.47777-14-karol.kolacinski@intel.com>
References: <20240329161730.47777-14-karol.kolacinski@intel.com>
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


