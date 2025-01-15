Return-Path: <netdev+bounces-158317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C32A115E8
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 01:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EAFC3A70AE
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1473182C5;
	Wed, 15 Jan 2025 00:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N6jceXrF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E527D35955
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 00:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736899743; cv=none; b=pf2RMM6RPkzflTyS/+sGmklMqTJ0n5VyRHEA75m0htEzCWnqCKz/sXHNITqwuGShAVtLabEV6Ns9eirbZBQTJG4RJFfZDhH9MDW+bbSgIb6GQHzs6gi+nZhWMYk3ELMxub3H6mgg8mSgHW1TcwXmdw9tYi060F/RLMw9RxlKAH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736899743; c=relaxed/simple;
	bh=dsfJByz0zacrHVJ4shOm9hleFXFOZ2DKSA8eeEYdJPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IiISg5nibnaMYmMfo75TvCb5E13yBSugoQaDCauLFaUGRC4pZccw+flQKvHqeBqhMlFwZGw7Q1WNyBPcMohboFQ42cXsBoYGUUngs10m/gjscSfL1DneAcewIfvCdEtNrm1U0fu+WgKBCINU/b68lPIZWjLQNykv4EZ+yz6ePKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N6jceXrF; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736899742; x=1768435742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dsfJByz0zacrHVJ4shOm9hleFXFOZ2DKSA8eeEYdJPs=;
  b=N6jceXrFx38E1dp//epa+CsXn7drx36YbsT3oziySUZ0OmUfqdKJ+uao
   oFnceLA03xran59ktrijNJ4El+mVYoMXOTnqLWRNv7WiSdRyzc47uX1g2
   bIgloEuAKafPSCElGkgJseKmCAqGT3NQlJU45LyTNJwYziD68XcUM91So
   tDokeahHymKn9glCqAnCjwV6RryD5wHhJLHCop7vHct7Rt82tI0H+q50F
   E8P50GMlmFpw58AQufV6v5SM8oFwZJRUK05kfUQaexBVM/DCI3hypqYjJ
   pXSAhdsK4j9U6kUj+uyCnDdcx9THo4qjSOiIUk085GKrdXzoPP47gI8S+
   Q==;
X-CSE-ConnectionGUID: V/TJkwwrRSm4mzMHokVWYA==
X-CSE-MsgGUID: m18jWDGyRuypPqlN0SMWvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="40897538"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="40897538"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 16:08:56 -0800
X-CSE-ConnectionGUID: Qa1DiVPYQcWOEKjSpAWYGw==
X-CSE-MsgGUID: Xs20a0WHT3mad8b5H1Qq0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128211460"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 14 Jan 2025 16:08:56 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: [PATCH net-next v2 13/13] ice: Add in/out PTP pin delays
Date: Tue, 14 Jan 2025 16:08:39 -0800
Message-ID: <20250115000844.714530-14-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115000844.714530-1-anthony.l.nguyen@intel.com>
References: <20250115000844.714530-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

HW can have different input/output delays for each of the pins.

Currently, only E82X adapters have delay compensation based on TSPLL
config and E810 adapters have constant 1 ms compensation, both cases
only for output delays and the same one for all pins.

E825 adapters have different delays for SDP and other pins. Those
delays are also based on direction and input delays are different than
output ones. This is the main reason for moving delays to pin
description structure.

Add a field in ice_ptp_pin_desc structure to reflect that. Delay values
are based on approximate calculations of HW delays based on HW spec.

Implement external timestamp (input) delay compensation.

Remove existing definitions and wrappers for periodic output propagation
delays.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 82 +++++++++++--------
 drivers/net/ethernet/intel/ice/ice_ptp.h      |  2 +
 .../net/ethernet/intel/ice/ice_ptp_consts.h   | 12 ---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   | 23 ------
 4 files changed, 49 insertions(+), 70 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index c03db3d26c3d..3eef0fea0c80 100644
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
@@ -1592,18 +1592,29 @@ void ice_ptp_extts_event(struct ice_pf *pf)
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
 
@@ -1798,9 +1809,9 @@ static int ice_ptp_write_perout(struct ice_hw *hw, unsigned int chan,
 static int ice_ptp_cfg_perout(struct ice_pf *pf, struct ptp_perout_request *rq,
 			      int on)
 {
+	unsigned int gpio_pin, prop_delay_ns;
 	u64 clk, period, start, phase;
 	struct ice_hw *hw = &pf->hw;
-	unsigned int gpio_pin;
 	int pin_desc_idx;
 
 	if (rq->flags & ~PTP_PEROUT_PHASE)
@@ -1811,6 +1822,7 @@ static int ice_ptp_cfg_perout(struct ice_pf *pf, struct ptp_perout_request *rq,
 		return -EIO;
 
 	gpio_pin = pf->ptp.ice_pin_desc[pin_desc_idx].gpio[1];
+	prop_delay_ns = pf->ptp.ice_pin_desc[pin_desc_idx].delay[1];
 	period = rq->period.sec * NSEC_PER_SEC + rq->period.nsec;
 
 	/* If we're disabling the output or period is 0, clear out CLKO and TGT
@@ -1842,11 +1854,11 @@ static int ice_ptp_cfg_perout(struct ice_pf *pf, struct ptp_perout_request *rq,
 	 * at the next multiple of period, maintaining phase.
 	 */
 	clk = ice_ptp_read_src_clk_reg(pf, NULL);
-	if (rq->flags & PTP_PEROUT_PHASE || start <= clk - ice_prop_delay(hw))
+	if (rq->flags & PTP_PEROUT_PHASE || start <= clk - prop_delay_ns)
 		start = div64_u64(clk + period - 1, period) * period + phase;
 
 	/* Compensate for propagation delay from the generator to the pin. */
-	start -= ice_prop_delay(hw);
+	start -= prop_delay_ns;
 
 	return ice_ptp_write_perout(hw, rq->index, gpio_pin, start, period);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 824e73b677a4..201f63054c08 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -211,6 +211,7 @@ enum ice_ptp_pin_nvm {
  * struct ice_ptp_pin_desc - hardware pin description data
  * @name_idx: index of the name of pin in ice_pin_names
  * @gpio: the associated GPIO input and output pins
+ * @delay: input and output signal delays in nanoseconds
  *
  * Structure describing a PTP-capable GPIO pin that extends ptp_pin_desc array
  * for the device. Device families have separate sets of available pins with
@@ -219,6 +220,7 @@ enum ice_ptp_pin_nvm {
 struct ice_ptp_pin_desc {
 	int name_idx;
 	int gpio[2];
+	unsigned int delay[2];
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
index d75f0eddd631..f05222cf5487 100644
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
index 231dd00cf38c..6779ce120515 100644
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
@@ -326,8 +324,6 @@ extern const struct ice_vernier_info_e82x e822_vernier[NUM_ICE_PTP_LNK_SPD];
  */
 #define ICE_E810_PLL_FREQ		812500000
 #define ICE_PTP_NOMINAL_INCVAL_E810	0x13b13b13bULL
-#define ICE_E810_OUT_PROP_DELAY_NS	1
-#define ICE_E825C_OUT_PROP_DELAY_NS	11
 
 /* Device agnostic functions */
 u8 ice_get_ptp_src_clock_index(struct ice_hw *hw);
@@ -389,11 +385,6 @@ static inline u64 ice_e82x_nominal_incval(enum ice_time_ref_freq time_ref)
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
-	switch (hw->ptp.phy_model) {
-	case ICE_PHY_ETH56G:
-		return ICE_E825C_OUT_PROP_DELAY_NS;
-	case ICE_PHY_E810:
-		return ICE_E810_OUT_PROP_DELAY_NS;
-	case ICE_PHY_E82X:
-		return ice_e82x_pps_delay(ice_e82x_time_ref(hw));
-	default:
-		return 0;
-	}
-}
-
 /**
  * ice_get_base_incval - Get base clock increment value
  * @hw: pointer to the HW struct
-- 
2.47.1


