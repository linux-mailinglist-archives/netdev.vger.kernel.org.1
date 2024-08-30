Return-Path: <netdev+bounces-123653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901E4966050
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 13:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E611280A7C
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 11:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED23E1A4B6D;
	Fri, 30 Aug 2024 11:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YtBKmRGm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6141A4ADC
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016253; cv=none; b=s+n/am2fQs5FEA2YOGI2vwDGsIhagyYILrMj3GSHr4AjGXIRmxFFIwde9wa5g0ZWQ43BB/e+QgNeVsTDw6UlmCkKHSz7GTs8mV/Ai90vfnY/uOxxXCArTl6EC4r8fwoZ8Ungzq1CY2K7M5kX+WfyM4c2TqHmwqBZe826i5P9HGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016253; c=relaxed/simple;
	bh=u3cUfzSKD0VjJiTqsSm49z1DKxsoO9Ejng/IhWZGTlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blXWVUwo6nQrwPkFuIhTJNJM13ex1ImSpMB+NO47DTkMTBRh/hswZRpFFqeEauvtJ/jQNbxcrEHiRd7PiGljwfYTIR/1CLukSLbR32t05uGx0UtvvjwNo/OsnaIKZ7GVLb1GwV9/5MNDS+T+XwO3XmlGhi6oSfaPfkuIONRdqSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YtBKmRGm; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725016253; x=1756552253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u3cUfzSKD0VjJiTqsSm49z1DKxsoO9Ejng/IhWZGTlA=;
  b=YtBKmRGmzhaJQu/nmNEiR2OQGdrhDN/qOkNQ6suJQMBMb9o+uByZseC9
   o4spCEafkUl0x6ZZjYE9UH9cTEWfzPLQxTXZ0/zJt/Juud+8bx5IVv95g
   4m4D/aE2F/1ArONNVsp3/zkwTl9sk3oxy1q/p/PPmb0wUkJfnwNlg7MII
   y0jkE4dVJeHvMaaTLjGoEULNQtlc49adpuyNR3e0xAy5Seiz9oQM1IMmQ
   PzJUxm1h5Ho71Q4L6QXfZQtp2p31h5Q/jndWxVSIe/6Xt53cbovKgfBlN
   hWUO0ilXbYLg1TdVkBol5V5B7Zd8voE3q5ukjXE1vWBOkzWD/iSCFJKPY
   g==;
X-CSE-ConnectionGUID: smwF764dQ3G/KgpnsCg8Dg==
X-CSE-MsgGUID: MA2hqz0hTQW9qWjin/cbGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23517615"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="23517615"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 04:10:52 -0700
X-CSE-ConnectionGUID: 57drXlLGR3OF4jigw67lEg==
X-CSE-MsgGUID: DhW8FnVOQHWC3u78YM4jVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="68273677"
Received: from kkolacin-desk1.igk.intel.com ([10.217.160.108])
  by fmviesa005.fm.intel.com with ESMTP; 30 Aug 2024 04:10:49 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v4 iwl-next 7/7] ice: Enable 1PPS out from CGU for E825C products
Date: Fri, 30 Aug 2024 13:07:23 +0200
Message-ID: <20240830111028.1112040-16-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240830111028.1112040-9-karol.kolacinski@intel.com>
References: <20240830111028.1112040-9-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>

Implement configuring 1PPS signal output from CGU. Use maximal amplitude
because Linux PTP pin API does not have any way for user to set signal
level.

This change is necessary for E825C products to properly output any
signal from 1PPS pin.

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
V1 -> V2: Added return value description, renamed the function and
          enable parameter. Reworded commit message.

 drivers/net/ethernet/intel/ice/ice_ptp.c    | 10 +++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 23 +++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  1 +
 3 files changed, 34 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 753709ef1ab2..382aa8d9a23a 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -4,6 +4,7 @@
 #include "ice.h"
 #include "ice_lib.h"
 #include "ice_trace.h"
+#include "ice_cgu_regs.h"
 
 static const char ice_pin_names[][64] = {
 	"SDP0",
@@ -1699,6 +1700,15 @@ static int ice_ptp_write_perout(struct ice_hw *hw, unsigned int chan,
 	/* 0. Reset mode & out_en in AUX_OUT */
 	wr32(hw, GLTSYN_AUX_OUT(chan, tmr_idx), 0);
 
+	if (ice_is_e825c(hw)) {
+		int err;
+
+		/* Enable/disable CGU 1PPS output for E825C */
+		err = ice_cgu_cfg_pps_out(hw, !!period);
+		if (err)
+			return err;
+	}
+
 	/* 1. Write perout with half of required period value.
 	 * HW toggles output when source clock hits the TGT and then adds
 	 * GLTSYN_CLKO value to the target, so it ends up with 50% duty cycle.
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 07ecf2a86742..6dff422b7f4e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -661,6 +661,29 @@ static int ice_cfg_cgu_pll_e825c(struct ice_hw *hw,
 	return 0;
 }
 
+#define ICE_ONE_PPS_OUT_AMP_MAX 3
+
+/**
+ * ice_cgu_cfg_pps_out - Configure 1PPS output from CGU
+ * @hw: pointer to the HW struct
+ * @enable: true to enable 1PPS output, false to disable it
+ *
+ * Return: 0 on success, other negative error code when CGU read/write failed
+ */
+int ice_cgu_cfg_pps_out(struct ice_hw *hw, bool enable)
+{
+	union nac_cgu_dword9 dw9;
+	int err;
+
+	err = ice_read_cgu_reg_e82x(hw, NAC_CGU_DWORD9, &dw9.val);
+	if (err)
+		return err;
+
+	dw9.one_pps_out_en = enable;
+	dw9.one_pps_out_amp = enable * ICE_ONE_PPS_OUT_AMP_MAX;
+	return ice_write_cgu_reg_e82x(hw, NAC_CGU_DWORD9, dw9.val);
+}
+
 /**
  * ice_cfg_cgu_pll_dis_sticky_bits_e82x - disable TS PLL sticky bits
  * @hw: pointer to the HW struct
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index ff98f76969e3..fc946fcd28b9 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -331,6 +331,7 @@ extern const struct ice_vernier_info_e82x e822_vernier[NUM_ICE_PTP_LNK_SPD];
 
 /* Device agnostic functions */
 u8 ice_get_ptp_src_clock_index(struct ice_hw *hw);
+int ice_cgu_cfg_pps_out(struct ice_hw *hw, bool enable);
 bool ice_ptp_lock(struct ice_hw *hw);
 void ice_ptp_unlock(struct ice_hw *hw);
 void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd);
-- 
2.46.0


