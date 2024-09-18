Return-Path: <netdev+bounces-128801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FD997BC27
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 14:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6DD1F236EE
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 12:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043191898F7;
	Wed, 18 Sep 2024 12:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OEEuQy3Y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1669F18A959
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726662064; cv=none; b=Lvq+yiQkGNs7906m0EbzDTMwUVflc/NE94CUUYLLjOeaAf7Up3h8ktwrDG5Vtqe+VVFVui92g1iH45f7+59zWVt3Lpk37J6Ay+Tc7x6+fqi8sjgb+xc1CUMWZ85spipttUifVBCkA6SU8fovPA55x627TOJ/o44+NTg3wgTlP4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726662064; c=relaxed/simple;
	bh=/xb0lIJB4OXH2DE7Vw5O9oGz7BIWFUo8a44ejwJzqMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSY1WQhwlEi0Qga9qltFUVh+bCG4EOAJ3ddUbRvvLxbWHwjZet4p7J1a0BtMtMzt/TtFMs81bBqTAm3GFPQkTm/Li7gfXOcQGVEjHOcGkk0ZTIZkVLCgrf73o225dbP5wEjt7Ug2ARvPf6qSmsR2cAg837E6B6JuU8dCzvq4Bm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OEEuQy3Y; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726662064; x=1758198064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/xb0lIJB4OXH2DE7Vw5O9oGz7BIWFUo8a44ejwJzqMo=;
  b=OEEuQy3YvOoWS5Ur+a/bkLCo6DCW/fIKlAG13rXz9fLjWkV7fsHd1pU+
   i2iE7ms2IKjHDttk/ouZi+2TmoJ4OYgyXZdQMn517753rj6ALutZlwjRc
   vRZ/RSWB8QLdEwt5+B1qKgtlXNz4ku8Nf/Ej9oHJgiY6RuygfizlkXfR+
   HQ3vfVQkFPJ2jr+tc0Vec6/D7CQaQig9se0dOF6uqaGVbaQV3K8tlJQVw
   12veGVvRy9V6yqr9lLlpNluJJPrHxnc7GHmuMxM5XDj4Lz6mkJBc+2zCG
   RsQ+mbu90waqxR4e+htMPuEojfZDz3tGfYGOL3SQsrz1cR9DLxY6HVXB5
   w==;
X-CSE-ConnectionGUID: ESAP1/ElQku5oyJPfUZmbA==
X-CSE-MsgGUID: ZwCpg9RRT0y6DmVS4EawKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="25689230"
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="25689230"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 05:21:03 -0700
X-CSE-ConnectionGUID: lwtk3IncSe+plGL7pmG4aA==
X-CSE-MsgGUID: GQCV1tjHRPKeHsMXx8W7Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="69636467"
Received: from kkolacin-desk1.igk.intel.com ([10.217.160.108])
  by fmviesa008.fm.intel.com with ESMTP; 18 Sep 2024 05:21:00 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v11 iwl-next 5/7] ice: Add unified ice_capture_crosststamp
Date: Wed, 18 Sep 2024 14:12:33 +0200
Message-ID: <20240918122048.1554692-14-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918122048.1554692-9-karol.kolacinski@intel.com>
References: <20240918122048.1554692-9-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

Devices supported by ice driver use essentially the same logic for
performing a crosstimestamp. The only difference is that E830 hardware
has different offsets. Instead of having multiple implementations,
combine them into a single ice_capture_crosststamp() function.

To support both hardware types, the ice_capture_crosststamp function
must be able to determine the appropriate registers to access. To handle
this, pass a custom context structure instead of the PF pointer. This
structure, ice_crosststamp_ctx, contains a pointer to the PF, and
a pointer to the device configuration structure. This new structure also
will make it easier to implement historic snapshot support in a future
commit.

The device configuration structure is a static const data which defines
the offsets and flags for the various registers. This includes the lock
register, the cross timestamp control register, the upper and lower ART
system time capture registers, and the upper and lower device time
capture registers for each timer index.

Use the configuration structure to access all of the registers in
ice_capture_crosststamp(). Ensure that we don't over-run the device time
array by checking that the timer index is 0 or 1. Previously this was
simply assumed, and it would cause the device to read an incorrect and
likely garbage register.

It does feel like there should be a kernel interface for managing
register offsets like this, but the closest thing I saw was
<linux/regmap.h> which is interesting but not quite what we're looking
for...

Use rd32_poll_timeout() to read lock_reg and ctl_reg.

Add snapshot system time for historic interpolation.

Remove X86_FEATURE_ART and X86_FEATURE_TSC_KNOWN_FREQ from all E82X
devices because those are SoCs, which will always have those features.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
V7 -> V8: Moved E830 cross timestamp handling to "ice: Implement PTP support for
          E830 devices" and explained the rest of previous changes in the commit
          description
V4 -> V5: Removed unnecessary CPU features check for SoCs (E82X) and
          X86_FEATURE_TSC_KNOWN_FREQ check for E830

 drivers/net/ethernet/intel/ice/ice_ptp.c | 204 ++++++++++++++---------
 1 file changed, 129 insertions(+), 75 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 4913f8f060f7..47c356d68e2e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2149,93 +2149,142 @@ static int ice_ptp_adjtime(struct ptp_clock_info *info, s64 delta)
 	return 0;
 }
 
-#ifdef CONFIG_ICE_HWTS
 /**
- * ice_ptp_get_syncdevicetime - Get the cross time stamp info
+ * struct ice_crosststamp_cfg - Device cross timestamp configuration
+ * @lock_reg: The hardware semaphore lock to use
+ * @lock_busy: Bit in the semaphore lock indicating the lock is busy
+ * @ctl_reg: The hardware register to request cross timestamp
+ * @ctl_active: Bit in the control register to request cross timestamp
+ * @art_time_l: Lower 32-bits of ART system time
+ * @art_time_h: Upper 32-bits of ART system time
+ * @dev_time_l: Lower 32-bits of device time (per timer index)
+ * @dev_time_h: Upper 32-bits of device time (per timer index)
+ */
+struct ice_crosststamp_cfg {
+	/* HW semaphore lock register */
+	u32 lock_reg;
+	u32 lock_busy;
+
+	/* Capture control register */
+	u32 ctl_reg;
+	u32 ctl_active;
+
+	/* Time storage */
+	u32 art_time_l;
+	u32 art_time_h;
+	u32 dev_time_l[2];
+	u32 dev_time_h[2];
+};
+
+static const struct ice_crosststamp_cfg ice_crosststamp_cfg_e82x = {
+	.lock_reg = PFHH_SEM,
+	.lock_busy = PFHH_SEM_BUSY_M,
+	.ctl_reg = GLHH_ART_CTL,
+	.ctl_active = GLHH_ART_CTL_ACTIVE_M,
+	.art_time_l = GLHH_ART_TIME_L,
+	.art_time_h = GLHH_ART_TIME_H,
+	.dev_time_l[0] = GLTSYN_HHTIME_L(0),
+	.dev_time_h[0] = GLTSYN_HHTIME_H(0),
+	.dev_time_l[1] = GLTSYN_HHTIME_L(1),
+	.dev_time_h[1] = GLTSYN_HHTIME_H(1),
+};
+
+/**
+ * struct ice_crosststamp_ctx - Device cross timestamp context
+ * @snapshot: snapshot of system clocks for historic interpolation
+ * @pf: pointer to the PF private structure
+ * @cfg: pointer to hardware configuration for cross timestamp
+ */
+struct ice_crosststamp_ctx {
+	struct system_time_snapshot snapshot;
+	struct ice_pf *pf;
+	const struct ice_crosststamp_cfg *cfg;
+};
+
+/**
+ * ice_capture_crosststamp - Capture a device/system cross timestamp
  * @device: Current device time
  * @system: System counter value read synchronously with device time
- * @ctx: Context provided by timekeeping code
+ * @__ctx: Context passed from ice_ptp_getcrosststamp
  *
  * Read device and system (ART) clock simultaneously and return the corrected
  * clock values in ns.
+ *
+ * Return: zero on success, or a negative error code on failure.
  */
-static int
-ice_ptp_get_syncdevicetime(ktime_t *device,
-			   struct system_counterval_t *system,
-			   void *ctx)
+static int ice_capture_crosststamp(ktime_t *device,
+				   struct system_counterval_t *system,
+				   void *__ctx)
 {
-	struct ice_pf *pf = (struct ice_pf *)ctx;
-	struct ice_hw *hw = &pf->hw;
-	u32 hh_lock, hh_art_ctl;
-	int i;
+	struct ice_crosststamp_ctx *ctx = __ctx;
+	const struct ice_crosststamp_cfg *cfg;
+	u32 lock, ctl, ts_lo, ts_hi, tmr_idx;
+	struct ice_pf *pf;
+	struct ice_hw *hw;
+	int err;
+	u64 ts;
 
-#define MAX_HH_HW_LOCK_TRIES	5
-#define MAX_HH_CTL_LOCK_TRIES	100
+	cfg = ctx->cfg;
+	pf = ctx->pf;
+	hw = &pf->hw;
 
-	for (i = 0; i < MAX_HH_HW_LOCK_TRIES; i++) {
-		/* Get the HW lock */
-		hh_lock = rd32(hw, PFHH_SEM + (PFTSYN_SEM_BYTES * hw->pf_id));
-		if (hh_lock & PFHH_SEM_BUSY_M) {
-			usleep_range(10000, 15000);
-			continue;
-		}
-		break;
-	}
-	if (hh_lock & PFHH_SEM_BUSY_M) {
-		dev_err(ice_pf_to_dev(pf), "PTP failed to get hh lock\n");
+	tmr_idx = hw->func_caps.ts_func_info.tmr_index_assoc;
+	if (tmr_idx > 1)
+		return -EINVAL;
+
+	/* Poll until we obtain the cross-timestamp hardware semaphore */
+	err = rd32_poll_timeout(hw, cfg->lock_reg, lock,
+				!(lock & cfg->lock_busy),
+				10 * USEC_PER_MSEC, 50 * USEC_PER_MSEC);
+	if (err) {
+		dev_err(ice_pf_to_dev(pf), "PTP failed to get cross timestamp lock\n");
 		return -EBUSY;
 	}
 
+	/* Snapshot system time for historic interpolation */
+	ktime_get_snapshot(&ctx->snapshot);
+
 	/* Program cmd to master timer */
 	ice_ptp_src_cmd(hw, ICE_PTP_READ_TIME);
 
 	/* Start the ART and device clock sync sequence */
-	hh_art_ctl = rd32(hw, GLHH_ART_CTL);
-	hh_art_ctl = hh_art_ctl | GLHH_ART_CTL_ACTIVE_M;
-	wr32(hw, GLHH_ART_CTL, hh_art_ctl);
-
-	for (i = 0; i < MAX_HH_CTL_LOCK_TRIES; i++) {
-		/* Wait for sync to complete */
-		hh_art_ctl = rd32(hw, GLHH_ART_CTL);
-		if (hh_art_ctl & GLHH_ART_CTL_ACTIVE_M) {
-			udelay(1);
-			continue;
-		} else {
-			u32 hh_ts_lo, hh_ts_hi, tmr_idx;
-			u64 hh_ts;
-
-			tmr_idx = hw->func_caps.ts_func_info.tmr_index_assoc;
-			/* Read ART time */
-			hh_ts_lo = rd32(hw, GLHH_ART_TIME_L);
-			hh_ts_hi = rd32(hw, GLHH_ART_TIME_H);
-			hh_ts = ((u64)hh_ts_hi << 32) | hh_ts_lo;
-			system->cycles = hh_ts;
-			system->cs_id = CSID_X86_ART;
-			/* Read Device source clock time */
-			hh_ts_lo = rd32(hw, GLTSYN_HHTIME_L(tmr_idx));
-			hh_ts_hi = rd32(hw, GLTSYN_HHTIME_H(tmr_idx));
-			hh_ts = ((u64)hh_ts_hi << 32) | hh_ts_lo;
-			*device = ns_to_ktime(hh_ts);
-			break;
-		}
-	}
+	ctl = rd32(hw, cfg->ctl_reg);
+	ctl |= cfg->ctl_active;
+	wr32(hw, cfg->ctl_reg, ctl);
 
+	/* Poll until hardware completes the capture */
+	err = rd32_poll_timeout(hw, cfg->ctl_reg, ctl, !(ctl & cfg->ctl_active),
+				5, 20 * USEC_PER_MSEC);
+	if (err)
+		goto err_timeout;
+
+	/* Read ART system time */
+	ts_lo = rd32(hw, cfg->art_time_l);
+	ts_hi = rd32(hw, cfg->art_time_h);
+	ts = ((u64)ts_hi << 32) | ts_lo;
+	system->cycles = ts;
+	system->cs_id = CSID_X86_ART;
+
+	/* Read Device source clock time */
+	ts_lo = rd32(hw, cfg->dev_time_l[tmr_idx]);
+	ts_hi = rd32(hw, cfg->dev_time_h[tmr_idx]);
+	ts = ((u64)ts_hi << 32) | ts_lo;
+	*device = ns_to_ktime(ts);
+
+err_timeout:
 	/* Clear the master timer */
 	ice_ptp_src_cmd(hw, ICE_PTP_NOP);
 
 	/* Release HW lock */
-	hh_lock = rd32(hw, PFHH_SEM + (PFTSYN_SEM_BYTES * hw->pf_id));
-	hh_lock = hh_lock & ~PFHH_SEM_BUSY_M;
-	wr32(hw, PFHH_SEM + (PFTSYN_SEM_BYTES * hw->pf_id), hh_lock);
-
-	if (i == MAX_HH_CTL_LOCK_TRIES)
-		return -ETIMEDOUT;
+	lock = rd32(hw, cfg->lock_reg);
+	lock &= ~cfg->lock_busy;
+	wr32(hw, cfg->lock_reg, lock);
 
-	return 0;
+	return err;
 }
 
 /**
- * ice_ptp_getcrosststamp_e82x - Capture a device cross timestamp
+ * ice_ptp_getcrosststamp - Capture a device cross timestamp
  * @info: the driver's PTP info structure
  * @cts: The memory to fill the cross timestamp info
  *
@@ -2243,22 +2292,31 @@ ice_ptp_get_syncdevicetime(ktime_t *device,
  * clock. Fill the cross timestamp information and report it back to the
  * caller.
  *
- * This is only valid for E822 and E823 devices which have support for
- * generating the cross timestamp via PCIe PTM.
- *
  * In order to correctly correlate the ART timestamp back to the TSC time, the
  * CPU must have X86_FEATURE_TSC_KNOWN_FREQ.
+ *
+ * Return: zero on success, or a negative error code on failure.
  */
-static int
-ice_ptp_getcrosststamp_e82x(struct ptp_clock_info *info,
-			    struct system_device_crosststamp *cts)
+static int ice_ptp_getcrosststamp(struct ptp_clock_info *info,
+				  struct system_device_crosststamp *cts)
 {
 	struct ice_pf *pf = ptp_info_to_pf(info);
+	struct ice_crosststamp_ctx ctx = {
+		.pf = pf,
+	};
+
+	switch (pf->hw.mac_type) {
+	case ICE_MAC_GENERIC:
+	case ICE_MAC_GENERIC_3K_E825:
+		ctx.cfg = &ice_crosststamp_cfg_e82x;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
 
-	return get_device_system_crosststamp(ice_ptp_get_syncdevicetime,
-					     pf, NULL, cts);
+	return get_device_system_crosststamp(ice_capture_crosststamp, &ctx,
+					     &ctx.snapshot, cts);
 }
-#endif /* CONFIG_ICE_HWTS */
 
 /**
  * ice_ptp_get_ts_config - ioctl interface to read the timestamping config
@@ -2519,12 +2577,8 @@ static int ice_ptp_parse_sdp_entries(struct ice_pf *pf, __le16 *entries,
  */
 static void ice_ptp_set_funcs_e82x(struct ice_pf *pf)
 {
-#ifdef CONFIG_ICE_HWTS
-	if (boot_cpu_has(X86_FEATURE_ART) &&
-	    boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ))
-		pf->ptp.info.getcrosststamp = ice_ptp_getcrosststamp_e82x;
+	pf->ptp.info.getcrosststamp = ice_ptp_getcrosststamp;
 
-#endif /* CONFIG_ICE_HWTS */
 	if (pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825) {
 		pf->ptp.ice_pin_desc = ice_pin_desc_e825c;
 		pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e825c);
-- 
2.46.0


