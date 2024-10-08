Return-Path: <netdev+bounces-133059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D902599463D
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 13:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561921F29082
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68121D358F;
	Tue,  8 Oct 2024 11:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jjtyqOh3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C04E18C00C
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 11:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728385603; cv=none; b=acN/qqtZdGsYerYPaoOBEeGpKcFUbiKfS9gruvpYA8+w49pNn0W0q+rsoxMVt2xYOLZqJPBcMxcW+FEDuP26ZeWFJGMn5DbSjo+UfyYdB3la2B4L/4nNjFEvNRnFrdEbMzzx8KEkMWf4qLg4QTSKStJjU2PN4bPWrjNUvenMLDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728385603; c=relaxed/simple;
	bh=CM/5/BC1rDAHBqkbM1uYElx5+Zk75flj/QHLxVn4/9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LHyjSf8aeyrsgiO0Cq/YfIB6GoC3g6gKx7/RFtMhpcGLuxcTvm9JmNMUOPHkIHHgPgqCsqoJqdeoE1Rn4sOCbmrZgm3/UYWTseVcA589fiEGx3VJsPqnMfddQUzVmH08EBZOF9UJJYQ/+Ja0jXOBC5MoMgVnI0E/chtN4Qwesdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jjtyqOh3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728385601; x=1759921601;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CM/5/BC1rDAHBqkbM1uYElx5+Zk75flj/QHLxVn4/9s=;
  b=jjtyqOh3gk14eQwnMgRqhSJEYQ981biZAECYCDDw9SW2PYseGn6Bt4Ih
   bYvTRN6mV1LbFmb0zSushnnuJ6dEftCUCKsrYD0zkcwuXRW8ou9Q0Z3Z3
   VaKVdtK9LzEUnd0EYaGwrjHhL/PPG/BZDwGJO2iC80vmaIYFYjMkdswOQ
   mS0Wk8xpzqZT8UbuE0k0H0GePX2XAq3wCcanCKf/t7GDbDhCZED7kGmqJ
   qAPUKdENjIvhAaXw6TMFcoVNZOY56Yr6G9S32JKjTzHUStEPQKrH8VTSr
   yulL18aRn57eh8SDV7fcIxsWIEGwfboXDRhUdVwBn9zgegSNloYVunCSe
   w==;
X-CSE-ConnectionGUID: 6WO/Z/4/S0eTQyg2yRyPmg==
X-CSE-MsgGUID: CTefRGmpTm2SCRofEfN6DA==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="31460455"
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208";a="31460455"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 04:06:37 -0700
X-CSE-ConnectionGUID: gle7KsqCQHerPu7lrpeU6A==
X-CSE-MsgGUID: bkasjxteRtGNo5ElMTeQIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208";a="80637430"
Received: from kkolacin-desk1.ger.corp.intel.com (HELO kkolacin-desk1.igk.intel.com) ([10.217.160.108])
  by orviesa003.jf.intel.com with ESMTP; 08 Oct 2024 04:06:36 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v2 iwl-next] ice: Add in/out PTP pin delays
Date: Tue,  8 Oct 2024 13:05:33 +0200
Message-ID: <20241008110626.1745728-2-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HW can have different input/output delays for each of the pins.
Add a field in ice_ptp_pin_desc structure to reflect that.

Implement external timestamp delay compensation.

Remove existing definitions and wrappers for periodic output propagation
delays.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
V1 -> V2: removed duplicate gpio_pin variable and restored missing
          ICE_E810_E830_SYNC_DELAY

 drivers/net/ethernet/intel/ice/ice_ptp.c      | 82 +++++++++++--------
 drivers/net/ethernet/intel/ice/ice_ptp.h      |  2 +
 .../net/ethernet/intel/ice/ice_ptp_consts.h   | 12 ---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   | 23 ------
 4 files changed, 49 insertions(+), 70 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 9bc22620f838..afecbd189750 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -16,28 +16,28 @@ static const char ice_pin_names[][64] = {
 };
 
 static const struct ice_ptp_pin_desc ice_pin_desc_e82x[] = {
-	/* name,        gpio */
-	{  TIME_SYNC, {  4, -1 }},
-	{  ONE_PPS,   { -1,  5 }},
+	/* name,        gpio,       delay */
+	{  TIME_SYNC, {  4, -1 }, { 0,  0 }},
+	{  ONE_PPS,   { -1,  5 }, { 0, 11 }},
 };
 
 static const struct ice_ptp_pin_desc ice_pin_desc_e825c[] = {
-	/* name,        gpio */
-	{  SDP0,      {  0,  0 }},
-	{  SDP1,      {  1,  1 }},
-	{  SDP2,      {  2,  2 }},
-	{  SDP3,      {  3,  3 }},
-	{  TIME_SYNC, {  4, -1 }},
-	{  ONE_PPS,   { -1,  5 }},
+	/* name,        gpio,       delay */
+	{  SDP0,      {  0,  0 }, { 15, 14 }},
+	{  SDP1,      {  1,  1 }, { 15, 14 }},
+	{  SDP2,      {  2,  2 }, { 15, 14 }},
+	{  SDP3,      {  3,  3 }, { 15, 14 }},
+	{  TIME_SYNC, {  4, -1 }, { 11,  0 }},
+	{  ONE_PPS,   { -1,  5 }, {  0,  9 }},
 };
 
 static const struct ice_ptp_pin_desc ice_pin_desc_e810[] = {
-	/* name,      gpio */
-	{  SDP0,    {  0, 0 }},
-	{  SDP1,    {  1, 1 }},
-	{  SDP2,    {  2, 2 }},
-	{  SDP3,    {  3, 3 }},
-	{  ONE_PPS, { -1, 5 }},
+	/* name,        gpio,       delay */
+	{  SDP0,      {  0,  0 }, { 0, 1 }},
+	{  SDP1,      {  1,  1 }, { 0, 1 }},
+	{  SDP2,      {  2,  2 }, { 0, 1 }},
+	{  SDP3,      {  3,  3 }, { 0, 1 }},
+	{  ONE_PPS,   { -1,  5 }, { 0, 1 }},
 };
 
 static const char ice_pin_names_nvm[][64] = {
@@ -49,12 +49,12 @@ static const char ice_pin_names_nvm[][64] = {
 };
 
 static const struct ice_ptp_pin_desc ice_pin_desc_e810_sma[] = {
-	/* name,   gpio */
-	{  GNSS, {  1, -1 }},
-	{  SMA1, {  1,  0 }},
-	{  UFL1, { -1,  0 }},
-	{  SMA2, {  3,  2 }},
-	{  UFL2, {  3, -1 }},
+	/* name,   gpio,       delay */
+	{  GNSS, {  1, -1 }, { 0, 0 }},
+	{  SMA1, {  1,  0 }, { 0, 1 }},
+	{  UFL1, { -1,  0 }, { 0, 1 }},
+	{  SMA2, {  3,  2 }, { 0, 1 }},
+	{  UFL2, {  3, -1 }, { 0, 0 }},
 };
 
 static struct ice_pf *ice_get_ctrl_pf(struct ice_pf *pf)
@@ -1561,18 +1561,29 @@ void ice_ptp_extts_event(struct ice_pf *pf)
 	 * Event is defined in GLTSYN_EVNT_0 register
 	 */
 	for (chan = 0; chan < GLTSYN_EVNT_H_IDX_MAX; chan++) {
+		int pin_desc_idx;
+
 		/* Check if channel is enabled */
-		if (pf->ptp.ext_ts_irq & (1 << chan)) {
-			lo = rd32(hw, GLTSYN_EVNT_L(chan, tmr_idx));
-			hi = rd32(hw, GLTSYN_EVNT_H(chan, tmr_idx));
-			event.timestamp = (((u64)hi) << 32) | lo;
-			event.type = PTP_CLOCK_EXTTS;
-			event.index = chan;
-
-			/* Fire event */
-			ptp_clock_event(pf->ptp.clock, &event);
-			pf->ptp.ext_ts_irq &= ~(1 << chan);
+		if (!(pf->ptp.ext_ts_irq & (1 << chan)))
+			continue;
+
+		lo = rd32(hw, GLTSYN_EVNT_L(chan, tmr_idx));
+		hi = rd32(hw, GLTSYN_EVNT_H(chan, tmr_idx));
+		event.timestamp = (u64)hi << 32 | lo;
+
+		/* Add delay compensation */
+		pin_desc_idx = ice_ptp_find_pin_idx(pf, PTP_PF_EXTTS, chan);
+		if (pin_desc_idx >= 0) {
+			const struct ice_ptp_pin_desc *desc;
+
+			desc = &pf->ptp.ice_pin_desc[pin_desc_idx];
+			event.timestamp -= desc->delay[0];
 		}
+
+		event.type = PTP_CLOCK_EXTTS;
+		event.index = chan;
+		pf->ptp.ext_ts_irq &= ~(1 << chan);
+		ptp_clock_event(pf->ptp.clock, &event);
 	}
 }
 
@@ -1767,9 +1778,9 @@ static int ice_ptp_write_perout(struct ice_hw *hw, unsigned int chan,
 static int ice_ptp_cfg_perout(struct ice_pf *pf, struct ptp_perout_request *rq,
 			      int on)
 {
+	unsigned int gpio_pin, prop_delay;
 	u64 clk, period, start, phase;
 	struct ice_hw *hw = &pf->hw;
-	unsigned int gpio_pin;
 	int pin_desc_idx;
 
 	if (rq->flags & ~PTP_PEROUT_PHASE)
@@ -1780,6 +1791,7 @@ static int ice_ptp_cfg_perout(struct ice_pf *pf, struct ptp_perout_request *rq,
 		return -EIO;
 
 	gpio_pin = pf->ptp.ice_pin_desc[pin_desc_idx].gpio[1];
+	prop_delay = pf->ptp.ice_pin_desc[pin_desc_idx].delay[1];
 	period = rq->period.sec * NSEC_PER_SEC + rq->period.nsec;
 
 	/* If we're disabling the output or period is 0, clear out CLKO and TGT
@@ -1811,11 +1823,11 @@ static int ice_ptp_cfg_perout(struct ice_pf *pf, struct ptp_perout_request *rq,
 	 * at the next multiple of period, maintaining phase.
 	 */
 	clk = ice_ptp_read_src_clk_reg(pf, NULL);
-	if (rq->flags & PTP_PEROUT_PHASE || start <= clk - ice_prop_delay(hw))
+	if (rq->flags & PTP_PEROUT_PHASE || start <= clk - prop_delay)
 		start = div64_u64(clk + period - 1, period) * period + phase;
 
 	/* Compensate for propagation delay from the generator to the pin. */
-	start -= ice_prop_delay(hw);
+	start -= prop_delay;
 
 	return ice_ptp_write_perout(hw, rq->index, gpio_pin, start, period);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 5af474285780..23cd7878bcc8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -210,6 +210,7 @@ enum ice_ptp_pin_nvm {
  * struct ice_ptp_pin_desc - hardware pin description data
  * @name_idx: index of the name of pin in ice_pin_names
  * @gpio: the associated GPIO input and output pins
+ * @delay: input and output signal delays in nanoseconds
  *
  * Structure describing a PTP-capable GPIO pin that extends ptp_pin_desc array
  * for the device. Device families have separate sets of available pins with
@@ -218,6 +219,7 @@ enum ice_ptp_pin_nvm {
 struct ice_ptp_pin_desc {
 	int name_idx;
 	int gpio[2];
+	unsigned int delay[2];
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
index 585ce200c60f..c3e9b78087a8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
@@ -341,8 +341,6 @@ const struct ice_time_ref_info_e82x e82x_time_ref[NUM_ICE_TIME_REF_FREQ] = {
 		823437500, /* 823.4375 MHz PLL */
 		/* nominal_incval */
 		0x136e44fabULL,
-		/* pps_delay */
-		11,
 	},
 
 	/* ICE_TIME_REF_FREQ_122_880 -> 122.88 MHz */
@@ -351,8 +349,6 @@ const struct ice_time_ref_info_e82x e82x_time_ref[NUM_ICE_TIME_REF_FREQ] = {
 		783360000, /* 783.36 MHz */
 		/* nominal_incval */
 		0x146cc2177ULL,
-		/* pps_delay */
-		12,
 	},
 
 	/* ICE_TIME_REF_FREQ_125_000 -> 125 MHz */
@@ -361,8 +357,6 @@ const struct ice_time_ref_info_e82x e82x_time_ref[NUM_ICE_TIME_REF_FREQ] = {
 		796875000, /* 796.875 MHz */
 		/* nominal_incval */
 		0x141414141ULL,
-		/* pps_delay */
-		12,
 	},
 
 	/* ICE_TIME_REF_FREQ_153_600 -> 153.6 MHz */
@@ -371,8 +365,6 @@ const struct ice_time_ref_info_e82x e82x_time_ref[NUM_ICE_TIME_REF_FREQ] = {
 		816000000, /* 816 MHz */
 		/* nominal_incval */
 		0x139b9b9baULL,
-		/* pps_delay */
-		12,
 	},
 
 	/* ICE_TIME_REF_FREQ_156_250 -> 156.25 MHz */
@@ -381,8 +373,6 @@ const struct ice_time_ref_info_e82x e82x_time_ref[NUM_ICE_TIME_REF_FREQ] = {
 		830078125, /* 830.78125 MHz */
 		/* nominal_incval */
 		0x134679aceULL,
-		/* pps_delay */
-		11,
 	},
 
 	/* ICE_TIME_REF_FREQ_245_760 -> 245.76 MHz */
@@ -391,8 +381,6 @@ const struct ice_time_ref_info_e82x e82x_time_ref[NUM_ICE_TIME_REF_FREQ] = {
 		783360000, /* 783.36 MHz */
 		/* nominal_incval */
 		0x146cc2177ULL,
-		/* pps_delay */
-		12,
 	},
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 5c11d8a69fd3..5b4dc921deee 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -80,7 +80,6 @@ struct ice_phy_reg_info_eth56g {
  * struct ice_time_ref_info_e82x
  * @pll_freq: Frequency of PLL that drives timer ticks in Hz
  * @nominal_incval: increment to generate nanoseconds in GLTSYN_TIME_L
- * @pps_delay: propagation delay of the PPS output signal
  *
  * Characteristic information for the various TIME_REF sources possible in the
  * E822 devices
@@ -88,7 +87,6 @@ struct ice_phy_reg_info_eth56g {
 struct ice_time_ref_info_e82x {
 	u64 pll_freq;
 	u64 nominal_incval;
-	u8 pps_delay;
 };
 
 /**
@@ -326,9 +324,7 @@ extern const struct ice_vernier_info_e82x e822_vernier[NUM_ICE_PTP_LNK_SPD];
  */
 #define ICE_E810_PLL_FREQ		812500000
 #define ICE_PTP_NOMINAL_INCVAL_E810	0x13b13b13bULL
-#define ICE_E810_OUT_PROP_DELAY_NS	1
 #define ICE_E810_E830_SYNC_DELAY	0
-#define ICE_E825C_OUT_PROP_DELAY_NS	11
 
 /* Device agnostic functions */
 u8 ice_get_ptp_src_clock_index(struct ice_hw *hw);
@@ -390,11 +386,6 @@ static inline u64 ice_e82x_nominal_incval(enum ice_time_ref_freq time_ref)
 	return e82x_time_ref[time_ref].nominal_incval;
 }
 
-static inline u64 ice_e82x_pps_delay(enum ice_time_ref_freq time_ref)
-{
-	return e82x_time_ref[time_ref].pps_delay;
-}
-
 /* E822 Vernier calibration functions */
 int ice_stop_phy_timer_e82x(struct ice_hw *hw, u8 port, bool soft_reset);
 int ice_start_phy_timer_e82x(struct ice_hw *hw, u8 port);
@@ -432,20 +423,6 @@ int ice_phy_cfg_ptp_1step_eth56g(struct ice_hw *hw, u8 port);
 #define ICE_ETH56G_NOMINAL_THRESH4	0x7777
 #define ICE_ETH56G_NOMINAL_TX_THRESH	0x6
 
-static inline u64 ice_prop_delay(const struct ice_hw *hw)
-{
-	switch (hw->mac_type) {
-	case ICE_MAC_E810:
-		return ICE_E810_OUT_PROP_DELAY_NS;
-	case ICE_MAC_GENERIC:
-		return ice_e82x_pps_delay(ice_e82x_time_ref(hw));
-	case ICE_MAC_GENERIC_3K_E825:
-		return ICE_E825C_OUT_PROP_DELAY_NS;
-	default:
-		return 0;
-	}
-}
-
 /**
  * ice_get_base_incval - Get base clock increment value
  * @hw: pointer to the HW struct

base-commit: 85a30ab1a599eb2f21c044d935950311082db4c5
-- 
2.46.2


