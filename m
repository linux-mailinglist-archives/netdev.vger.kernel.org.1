Return-Path: <netdev+bounces-104460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E0C90C9B6
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8B9E1F234F7
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1824A170855;
	Tue, 18 Jun 2024 10:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nr4B0UtO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C790F16F277
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718707413; cv=none; b=L5TbJBTDqm0ykfQZGknCb9ijsmOAKSzGu304EnHLyMuO6cpz4ntkrBbZX/GZ0NkaJM3nyQkhwGXfJCvKvoXtnkag/vqeXwPwTS7vWnfGPeXGKuVMFvamP9vomzLwFNdKl+VYappuNAzOFr3B3DvWOrhqXzM/2shUrQihX2mS10I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718707413; c=relaxed/simple;
	bh=V5N+k9e+K8IChb6ZHPElGgsyagVkTjyu4SF1Lng2fl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IkCFBI/cygis0ejR1hWTylaU5Su02SRqwWM9gIS0tBlYHp4JAIh73sg4/rMg5xy3v4vmXYoasitbqbJoJYgF6tDdo1xA6YGspPqsolJfafKXm3EkRuCCGlb1Kt0iniwJRXb3z5o3MNtW9FqsnRud6FDHHUHatSuib7Yzk6//TNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nr4B0UtO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718707411; x=1750243411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V5N+k9e+K8IChb6ZHPElGgsyagVkTjyu4SF1Lng2fl0=;
  b=Nr4B0UtOObaMRYsL8vRA/PZbB7kYrZPba2iw/VJ/LjwLMpbGjaPp2PSM
   i1HQQDxmWTIS28ABBC/uulIDA+T6h4rhDyXcGu7N7l8YiCIB5/2oVyAqS
   HfmfpZOan2P21jR7v0AAzVXy3u77SDT17mX8/UXE4uS6g8LKmpOjl2OUk
   Ld253o4L5o3eyIbAvqCZW0PLT7Sa09zNzzcpnzhpM9/YHXKsrvrS0UPu+
   Ic4EdFntSRU8m9QiV+BtE15/Xg+J3qCknzczKDRNcQmuLzkECM8A0nx8w
   eenL7oxUHR1/FKHV3aERu9Mv4GfP4zvVjUkFEZOIOb04SenQlhVLh5w0V
   w==;
X-CSE-ConnectionGUID: u2kbv3amTp6GGKiCaWS11A==
X-CSE-MsgGUID: KOFcbGw3SRSH7th7isyZcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15719457"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15719457"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 03:43:30 -0700
X-CSE-ConnectionGUID: MlY/9n05QkqcGcAxogdLyA==
X-CSE-MsgGUID: w0beraEARDCNvec3xuUJOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="42227777"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orviesa007.jf.intel.com with ESMTP; 18 Jun 2024 03:43:28 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH iwl-net 3/3] ice: Reject pin requests with unsupported flags
Date: Tue, 18 Jun 2024 12:41:38 +0200
Message-ID: <20240618104310.1429515-4-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618104310.1429515-1-karol.kolacinski@intel.com>
References: <20240618104310.1429515-1-karol.kolacinski@intel.com>
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
 drivers/net/ethernet/intel/ice/ice_ptp.c | 41 ++++++++++++++----------
 drivers/net/ethernet/intel/ice/ice_ptp.h |  1 +
 2 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index b952cad42f92..5fa377786f4c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1591,14 +1591,23 @@ void ice_ptp_extts_event(struct ice_pf *pf)
  * @store: If set to true, the values will be stored
  *
  * Configure an external timestamp event on the requested channel.
-  */
-static void ice_ptp_cfg_extts(struct ice_pf *pf, unsigned int chan,
-			      struct ice_extts_channel *config, bool store)
+ *
+ * Return: 0 on sucess, -EOPNOTUSPP on unsupported flags
+ */
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
+	return -EOPNOTSUPP;
+
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 
 	irq_reg = rd32(hw, PFINT_OICR_ENA);
@@ -1639,6 +1648,8 @@ static void ice_ptp_cfg_extts(struct ice_pf *pf, unsigned int chan,
 
 	if (store)
 		memcpy(&pf->ptp.extts_channels[chan], config, sizeof(*config));
+
+	return 0;
 }
 
 /**
@@ -1697,6 +1708,9 @@ static int ice_ptp_cfg_clkout(struct ice_pf *pf, unsigned int chan,
 	u32 func, val, gpio_pin;
 	u8 tmr_idx;
 
+	if (config->flags & ~PTP_PEROUT_PHASE)
+		return -EOPNOTSUPP;
+
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 
 	/* 0. Reset mode & out_en in AUX_OUT */
@@ -1836,7 +1850,6 @@ ice_ptp_gpio_enable_e810(struct ptp_clock_info *info,
 	bool sma_pres = false;
 	unsigned int chan;
 	u32 gpio_pin;
-	int err;
 
 	if (ice_is_feature_supported(pf, ICE_F_SMA_CTRL))
 		sma_pres = true;
@@ -1865,14 +1878,14 @@ ice_ptp_gpio_enable_e810(struct ptp_clock_info *info,
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
@@ -1897,14 +1910,12 @@ ice_ptp_gpio_enable_e810(struct ptp_clock_info *info,
 		extts_cfg.gpio_pin = gpio_pin;
 		extts_cfg.ena = !!on;
 
-		ice_ptp_cfg_extts(pf, chan, &extts_cfg, true);
-		return 0;
+
+		return ice_ptp_cfg_extts(pf, chan, &extts_cfg, true);
 	}
 	default:
 		return -EOPNOTSUPP;
 	}
-
-	return err;
 }
 
 /**
@@ -1917,19 +1928,18 @@ static int ice_ptp_gpio_enable_e823(struct ptp_clock_info *info,
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
@@ -1939,14 +1949,11 @@ static int ice_ptp_gpio_enable_e823(struct ptp_clock_info *info,
 		extts_cfg.gpio_pin = TIME_SYNC_PIN_INDEX;
 		extts_cfg.ena = !!on;
 
-		ice_ptp_cfg_extts(pf, rq->extts.index, &extts_cfg, true);
-		break;
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


