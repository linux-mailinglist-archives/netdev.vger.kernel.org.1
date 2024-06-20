Return-Path: <netdev+bounces-105257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FC3910443
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32E9283B9D
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78D31AC44B;
	Thu, 20 Jun 2024 12:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jW4vK1w1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A33F1AD401
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 12:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718886727; cv=none; b=YQGJIktYbO0jwYoRF6YfQ/pupluRzXtMBdM2ocfDjBBrlNqYGBAC6SS+0ZZqmZsCYAg6IS8gtn2c3CLOPLduHbvxfBwcO+EgDfmCbUzeZ+MRbdGD3fCqWOKjt/v2jZMMgEVwKu/gtQRJArgCZSm2QKQG0qDCJL5UeGEAPPVTI5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718886727; c=relaxed/simple;
	bh=CsC8tWKXWqigv3FVjEzJq+a5FzgW/cwLvdxnWJJxKRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kp0ndypo/K7BEHE6Oj9Nj6AZd+SEKIUz51Xj0dn9JFLosH2Ad0eS7ApulqhwdUS1o32lbXD5MwDguzdfs05wPHa1SQdHxCwHyZCzB7Pg1vvWbncdGGN0kHjD3bs/A3CYCA0fFz9W01HBg4H/XUS2mVgtFJoIRGtENKifzrIt3SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jW4vK1w1; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718886723; x=1750422723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CsC8tWKXWqigv3FVjEzJq+a5FzgW/cwLvdxnWJJxKRs=;
  b=jW4vK1w1J5Ry079aRo/VfWt/8vrwgV+nwIgeB+f9TfUctPYVndf7HN10
   QHAEoU5l+pu5cBMO2dtkCvsGOd75yBcC1BNDRvb1tQaqd2gbFkwmf4vnO
   gqTHGIuWPMEPj7QygkEcrYScvWLKBRTNsYvyC3H4nCLWBRpjrM1nNDe8Q
   gd2SeaqQ+O+XrcmgQ13d7phHE2kJNaupnLDw0XrMJ+GZdrBAGMqgPwGUI
   OWofHux7ppe0OBrKA3TaQ7brtA8pAmYOHRkI0djuxA8y+bY0ozBTlJVZ+
   DVgl95ZkRf8ONN5ou8bD2oqFKSRliXCf/naLFzv9mJq7FgarD9njLf0df
   Q==;
X-CSE-ConnectionGUID: HgEjkX/kT1Ka4bhQNApq7Q==
X-CSE-MsgGUID: kTmMsIYNQE+cgVbIElZaHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="41262899"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="41262899"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 05:32:03 -0700
X-CSE-ConnectionGUID: 0SV54oEYR6W+xBguuGE6RA==
X-CSE-MsgGUID: X+5R44lOTO+kH1QVh2jnEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="79712963"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orviesa001.jf.intel.com with ESMTP; 20 Jun 2024 05:32:01 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v2 iwl-net 3/3] ice: Reject pin requests with unsupported flags
Date: Thu, 20 Jun 2024 14:27:10 +0200
Message-ID: <20240620123141.1582255-4-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620123141.1582255-1-karol.kolacinski@intel.com>
References: <20240620123141.1582255-1-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The driver receives requests for configuring pins via the .enable
callback of the PTP clock object. These requests come into the driver
with flags which modify the requested behavior from userspace. Current
implementation in ice does not reject flags that it doesn't support.
This causes the driver to incorrectly apply requests with such flags as
PTP_PEROUT_DUTY_CYCLE, or any future flags added by the kernel which it
is not yet aware of.

Fix this by properly validating flags in both ice_ptp_cfg_perout and
ice_ptp_cfg_extts. Ensure that we check by bit-wise negating supported
flags rather than just checking and rejecting known un-supported flags.
This is preferable, as it ensures better compatibility with future
kernels.

Fixes: 172db5f91d5f ("ice: add support for auxiliary input/output pins")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
V1 -> V2: adjusted indentation and added NULL config pointer check

 drivers/net/ethernet/intel/ice/ice_ptp.c | 38 ++++++++++++++----------
 drivers/net/ethernet/intel/ice/ice_ptp.h |  1 +
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 0500ced1adf8..163b312c7cbc 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1593,14 +1593,23 @@ void ice_ptp_extts_event(struct ice_pf *pf)
  * @store: If set to true, the values will be stored
  *
  * Configure an external timestamp event on the requested channel.
+ *
+ * Return: 0 on success, -EOPNOTUSPP on unsupported flags
  */
-static void ice_ptp_cfg_extts(struct ice_pf *pf, unsigned int chan,
-			      struct ice_extts_channel *config, bool store)
+static int ice_ptp_cfg_extts(struct ice_pf *pf, unsigned int chan,
+			     struct ice_extts_channel *config, bool store)
 {
 	u32 func, aux_reg, gpio_reg, irq_reg;
 	struct ice_hw *hw = &pf->hw;
 	u8 tmr_idx;
 
+	/* Reject requests with unsupported flags */
+	if (config->flags & ~(PTP_ENABLE_FEATURE |
+			      PTP_RISING_EDGE |
+			      PTP_FALLING_EDGE |
+			      PTP_STRICT_FLAGS))
+		return -EOPNOTSUPP;
+
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 
 	irq_reg = rd32(hw, PFINT_OICR_ENA);
@@ -1641,6 +1650,8 @@ static void ice_ptp_cfg_extts(struct ice_pf *pf, unsigned int chan,
 
 	if (store)
 		memcpy(&pf->ptp.extts_channels[chan], config, sizeof(*config));
+
+	return 0;
 }
 
 /**
@@ -1699,6 +1710,9 @@ static int ice_ptp_cfg_clkout(struct ice_pf *pf, unsigned int chan,
 	u32 func, val, gpio_pin;
 	u8 tmr_idx;
 
+	if (config && config->flags & ~PTP_PEROUT_PHASE)
+		return -EOPNOTSUPP;
+
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 
 	/* 0. Reset mode & out_en in AUX_OUT */
@@ -1838,7 +1852,6 @@ ice_ptp_gpio_enable_e810(struct ptp_clock_info *info,
 	bool sma_pres = false;
 	unsigned int chan;
 	u32 gpio_pin;
-	int err;
 
 	if (ice_is_feature_supported(pf, ICE_F_SMA_CTRL))
 		sma_pres = true;
@@ -1867,14 +1880,14 @@ ice_ptp_gpio_enable_e810(struct ptp_clock_info *info,
 			clk_cfg.gpio_pin = chan;
 		}
 
+		clk_cfg.flags = rq->perout.flags;
 		clk_cfg.period = ((rq->perout.period.sec * NSEC_PER_SEC) +
 				   rq->perout.period.nsec);
 		clk_cfg.start_time = ((rq->perout.start.sec * NSEC_PER_SEC) +
 				       rq->perout.start.nsec);
 		clk_cfg.ena = !!on;
 
-		err = ice_ptp_cfg_clkout(pf, chan, &clk_cfg, true);
-		break;
+		return ice_ptp_cfg_clkout(pf, chan, &clk_cfg, true);
 	}
 	case PTP_CLK_REQ_EXTTS:
 	{
@@ -1899,14 +1912,11 @@ ice_ptp_gpio_enable_e810(struct ptp_clock_info *info,
 		extts_cfg.gpio_pin = gpio_pin;
 		extts_cfg.ena = !!on;
 
-		ice_ptp_cfg_extts(pf, chan, &extts_cfg, true);
-		return 0;
+		return ice_ptp_cfg_extts(pf, chan, &extts_cfg, true);
 	}
 	default:
 		return -EOPNOTSUPP;
 	}
-
-	return err;
 }
 
 /**
@@ -1919,19 +1929,18 @@ static int ice_ptp_gpio_enable_e823(struct ptp_clock_info *info,
 				    struct ptp_clock_request *rq, int on)
 {
 	struct ice_pf *pf = ptp_info_to_pf(info);
-	int err;
 
 	switch (rq->type) {
 	case PTP_CLK_REQ_PPS:
 	{
 		struct ice_perout_channel clk_cfg = {};
 
+		clk_cfg.flags = rq->perout.flags;
 		clk_cfg.gpio_pin = PPS_PIN_INDEX;
 		clk_cfg.period = NSEC_PER_SEC;
 		clk_cfg.ena = !!on;
 
-		err = ice_ptp_cfg_clkout(pf, PPS_CLK_GEN_CHAN, &clk_cfg, true);
-		break;
+		return ice_ptp_cfg_clkout(pf, PPS_CLK_GEN_CHAN, &clk_cfg, true);
 	}
 	case PTP_CLK_REQ_EXTTS:
 	{
@@ -1941,14 +1950,11 @@ static int ice_ptp_gpio_enable_e823(struct ptp_clock_info *info,
 		extts_cfg.gpio_pin = TIME_SYNC_PIN_INDEX;
 		extts_cfg.ena = !!on;
 
-		ice_ptp_cfg_extts(pf, rq->extts.index, &extts_cfg, true);
-		return 0;
+		return ice_ptp_cfg_extts(pf, rq->extts.index, &extts_cfg, true);
 	}
 	default:
 		return -EOPNOTSUPP;
 	}
-
-	return err;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index f1171cdd93c8..e2af9749061c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -29,6 +29,7 @@ enum ice_ptp_pin_e810t {
 struct ice_perout_channel {
 	bool ena;
 	u32 gpio_pin;
+	u32 flags;
 	u64 period;
 	u64 start_time;
 };
-- 
2.43.0


