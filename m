Return-Path: <netdev+bounces-108562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433C29244CD
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 19:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35D8D1C22A4A
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 17:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28591BE257;
	Tue,  2 Jul 2024 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PnvGDHCP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46551BE240
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940506; cv=none; b=KuuleH3FWy3ro/6oblVl1uukMPBxOYya1yFnbBEZFHddzZRZBV6qtXUCUaZXaKxei/d6/dgwWjxl8EJ3z/2pwhAAR1AD0a+4zVOjQrQL4qLrDVneOd3WtAvE1KMSkUDZRzN2wxQyiiR7mmnrRjC6FzW92QvBecHdRomf19PfIak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940506; c=relaxed/simple;
	bh=j0PK/x2qe2oXgWLwMMZiYQ3QzWfrDSIO2L2lDCQZ/ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcByQZU9VgYg9Ni541Kf+h8R/O4uspw0lA6JqZARnsgPvO7Aa2gpqiOTzvolqT07Xpf+MYONeQqe7vQijrzTxkR9VYb5cJiJ0mzGL9hpU8+3MT/RSsb22X4uqx9pFRuhgT2OytRzNO7mfPiKiVT6pMvVTaPU4CxIfnSSTzI72is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PnvGDHCP; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719940504; x=1751476504;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j0PK/x2qe2oXgWLwMMZiYQ3QzWfrDSIO2L2lDCQZ/ro=;
  b=PnvGDHCPxpwDaaoeiSYi8IP0zCAcZRCD8u2tqlF0XSHuL6IdAy07QJFG
   XIokkS4cJTOwGhSnI+2LM5gQYGxLVjTjXdxEea/fddBJTlHdSH0U5/w7K
   AGVc4EE5GLOGrmdfic8V+juFAgxz9yFAZ9c4ydcOY4z7KRhb9RYvgK8cl
   8xTuwVmTesPVOzxhm7m3CyB507yBGdVdjoiK62IoooluF/OZw+cnkWw5v
   tFM+15fjybzxSVb+4A91cYFtqiWrN5jjiCPFzQy5EYjMvoT8qf/3F1mRn
   mRH3k8LIlEHCjHgXJeF4hCKqH+MMqEKv+A9+B9e0SEyE6YT+gKrlXScT/
   w==;
X-CSE-ConnectionGUID: mffmuvvDS1WV3IZobkUA9Q==
X-CSE-MsgGUID: ZIksUzpWQz2RJB3ghj3TTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="20032323"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="20032323"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 10:15:03 -0700
X-CSE-ConnectionGUID: t/68rRquRkKoi+94pB1Fzw==
X-CSE-MsgGUID: +8vwvK7SR16BEEqLn4/SqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="76708749"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 02 Jul 2024 10:15:02 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Milena Olech <milena.olech@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	maciej.fijalkowski@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net v2 1/4] ice: Fix improper extts handling
Date: Tue,  2 Jul 2024 10:14:54 -0700
Message-ID: <20240702171459.2606611-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702171459.2606611-1-anthony.l.nguyen@intel.com>
References: <20240702171459.2606611-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Milena Olech <milena.olech@intel.com>

Extts events are disabled and enabled by the application ts2phc.
However, in case where the driver is removed when the application is
running, a specific extts event remains enabled and can cause a kernel
crash.
As a side effect, when the driver is reloaded and application is started
again, remaining extts event for the channel from a previous run will
keep firing and the message "extts on unexpected channel" might be
printed to the user.

To avoid that, extts events shall be disabled when PTP is released.

Fixes: 172db5f91d5f ("ice: add support for auxiliary input/output pins")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 105 ++++++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_ptp.h |   8 ++
 2 files changed, 91 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 0f17fc1181d2..4d6555fadd83 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1584,27 +1584,24 @@ void ice_ptp_extts_event(struct ice_pf *pf)
 /**
  * ice_ptp_cfg_extts - Configure EXTTS pin and channel
  * @pf: Board private structure
- * @ena: true to enable; false to disable
  * @chan: GPIO channel (0-3)
- * @gpio_pin: GPIO pin
- * @extts_flags: request flags from the ptp_extts_request.flags
+ * @config: desired EXTTS configuration.
+ * @store: If set to true, the values will be stored
+ *
+ * Configure an external timestamp event on the requested channel.
  */
-static int
-ice_ptp_cfg_extts(struct ice_pf *pf, bool ena, unsigned int chan, u32 gpio_pin,
-		  unsigned int extts_flags)
+static void ice_ptp_cfg_extts(struct ice_pf *pf, unsigned int chan,
+			      struct ice_extts_channel *config, bool store)
 {
 	u32 func, aux_reg, gpio_reg, irq_reg;
 	struct ice_hw *hw = &pf->hw;
 	u8 tmr_idx;
 
-	if (chan > (unsigned int)pf->ptp.info.n_ext_ts)
-		return -EINVAL;
-
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 
 	irq_reg = rd32(hw, PFINT_OICR_ENA);
 
-	if (ena) {
+	if (config->ena) {
 		/* Enable the interrupt */
 		irq_reg |= PFINT_OICR_TSYN_EVNT_M;
 		aux_reg = GLTSYN_AUX_IN_0_INT_ENA_M;
@@ -1613,9 +1610,9 @@ ice_ptp_cfg_extts(struct ice_pf *pf, bool ena, unsigned int chan, u32 gpio_pin,
 #define GLTSYN_AUX_IN_0_EVNTLVL_FALLING_EDGE	BIT(1)
 
 		/* set event level to requested edge */
-		if (extts_flags & PTP_FALLING_EDGE)
+		if (config->flags & PTP_FALLING_EDGE)
 			aux_reg |= GLTSYN_AUX_IN_0_EVNTLVL_FALLING_EDGE;
-		if (extts_flags & PTP_RISING_EDGE)
+		if (config->flags & PTP_RISING_EDGE)
 			aux_reg |= GLTSYN_AUX_IN_0_EVNTLVL_RISING_EDGE;
 
 		/* Write GPIO CTL reg.
@@ -1636,9 +1633,47 @@ ice_ptp_cfg_extts(struct ice_pf *pf, bool ena, unsigned int chan, u32 gpio_pin,
 
 	wr32(hw, PFINT_OICR_ENA, irq_reg);
 	wr32(hw, GLTSYN_AUX_IN(chan, tmr_idx), aux_reg);
-	wr32(hw, GLGEN_GPIO_CTL(gpio_pin), gpio_reg);
+	wr32(hw, GLGEN_GPIO_CTL(config->gpio_pin), gpio_reg);
 
-	return 0;
+	if (store)
+		memcpy(&pf->ptp.extts_channels[chan], config, sizeof(*config));
+}
+
+/**
+ * ice_ptp_disable_all_extts - Disable all EXTTS channels
+ * @pf: Board private structure
+ */
+static void ice_ptp_disable_all_extts(struct ice_pf *pf)
+{
+	struct ice_extts_channel extts_cfg = {};
+	int i;
+
+	for (i = 0; i < pf->ptp.info.n_ext_ts; i++) {
+		if (pf->ptp.extts_channels[i].ena) {
+			extts_cfg.gpio_pin = pf->ptp.extts_channels[i].gpio_pin;
+			extts_cfg.ena = false;
+			ice_ptp_cfg_extts(pf, i, &extts_cfg, false);
+		}
+	}
+
+	synchronize_irq(pf->oicr_irq.virq);
+}
+
+/**
+ * ice_ptp_enable_all_extts - Enable all EXTTS channels
+ * @pf: Board private structure
+ *
+ * Called during reset to restore user configuration.
+ */
+static void ice_ptp_enable_all_extts(struct ice_pf *pf)
+{
+	int i;
+
+	for (i = 0; i < pf->ptp.info.n_ext_ts; i++) {
+		if (pf->ptp.extts_channels[i].ena)
+			ice_ptp_cfg_extts(pf, i, &pf->ptp.extts_channels[i],
+					  false);
+	}
 }
 
 /**
@@ -1795,7 +1830,6 @@ ice_ptp_gpio_enable_e810(struct ptp_clock_info *info,
 			 struct ptp_clock_request *rq, int on)
 {
 	struct ice_pf *pf = ptp_info_to_pf(info);
-	struct ice_perout_channel clk_cfg = {0};
 	bool sma_pres = false;
 	unsigned int chan;
 	u32 gpio_pin;
@@ -1806,6 +1840,9 @@ ice_ptp_gpio_enable_e810(struct ptp_clock_info *info,
 
 	switch (rq->type) {
 	case PTP_CLK_REQ_PEROUT:
+	{
+		struct ice_perout_channel clk_cfg = {};
+
 		chan = rq->perout.index;
 		if (sma_pres) {
 			if (chan == ice_pin_desc_e810t[SMA1].chan)
@@ -1833,7 +1870,11 @@ ice_ptp_gpio_enable_e810(struct ptp_clock_info *info,
 
 		err = ice_ptp_cfg_clkout(pf, chan, &clk_cfg, true);
 		break;
+	}
 	case PTP_CLK_REQ_EXTTS:
+	{
+		struct ice_extts_channel extts_cfg = {};
+
 		chan = rq->extts.index;
 		if (sma_pres) {
 			if (chan < ice_pin_desc_e810t[SMA2].chan)
@@ -1849,9 +1890,13 @@ ice_ptp_gpio_enable_e810(struct ptp_clock_info *info,
 			gpio_pin = chan;
 		}
 
-		err = ice_ptp_cfg_extts(pf, !!on, chan, gpio_pin,
-					rq->extts.flags);
-		break;
+		extts_cfg.flags = rq->extts.flags;
+		extts_cfg.gpio_pin = gpio_pin;
+		extts_cfg.ena = !!on;
+
+		ice_ptp_cfg_extts(pf, chan, &extts_cfg, true);
+		return 0;
+	}
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -1869,21 +1914,31 @@ static int ice_ptp_gpio_enable_e823(struct ptp_clock_info *info,
 				    struct ptp_clock_request *rq, int on)
 {
 	struct ice_pf *pf = ptp_info_to_pf(info);
-	struct ice_perout_channel clk_cfg = {0};
 	int err;
 
 	switch (rq->type) {
 	case PTP_CLK_REQ_PPS:
+	{
+		struct ice_perout_channel clk_cfg = {};
+
 		clk_cfg.gpio_pin = PPS_PIN_INDEX;
 		clk_cfg.period = NSEC_PER_SEC;
 		clk_cfg.ena = !!on;
 
 		err = ice_ptp_cfg_clkout(pf, PPS_CLK_GEN_CHAN, &clk_cfg, true);
 		break;
+	}
 	case PTP_CLK_REQ_EXTTS:
-		err = ice_ptp_cfg_extts(pf, !!on, rq->extts.index,
-					TIME_SYNC_PIN_INDEX, rq->extts.flags);
-		break;
+	{
+		struct ice_extts_channel extts_cfg = {};
+
+		extts_cfg.flags = rq->extts.flags;
+		extts_cfg.gpio_pin = TIME_SYNC_PIN_INDEX;
+		extts_cfg.ena = !!on;
+
+		ice_ptp_cfg_extts(pf, rq->extts.index, &extts_cfg, true);
+		return 0;
+	}
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -2720,6 +2775,10 @@ static int ice_ptp_rebuild_owner(struct ice_pf *pf)
 		ice_ptp_restart_all_phy(pf);
 	}
 
+	/* Re-enable all periodic outputs and external timestamp events */
+	ice_ptp_enable_all_clkout(pf);
+	ice_ptp_enable_all_extts(pf);
+
 	return 0;
 }
 
@@ -3275,6 +3334,8 @@ void ice_ptp_release(struct ice_pf *pf)
 
 	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
 
+	ice_ptp_disable_all_extts(pf);
+
 	kthread_cancel_delayed_work_sync(&pf->ptp.work);
 
 	ice_ptp_port_phy_stop(&pf->ptp.port);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 3af20025043a..f1171cdd93c8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -33,6 +33,12 @@ struct ice_perout_channel {
 	u64 start_time;
 };
 
+struct ice_extts_channel {
+	bool ena;
+	u32 gpio_pin;
+	u32 flags;
+};
+
 /* The ice hardware captures Tx hardware timestamps in the PHY. The timestamp
  * is stored in a buffer of registers. Depending on the specific hardware,
  * this buffer might be shared across multiple PHY ports.
@@ -226,6 +232,7 @@ enum ice_ptp_state {
  * @ext_ts_irq: the external timestamp IRQ in use
  * @kworker: kwork thread for handling periodic work
  * @perout_channels: periodic output data
+ * @extts_channels: channels for external timestamps
  * @info: structure defining PTP hardware capabilities
  * @clock: pointer to registered PTP clock device
  * @tstamp_config: hardware timestamping configuration
@@ -249,6 +256,7 @@ struct ice_ptp {
 	u8 ext_ts_irq;
 	struct kthread_worker *kworker;
 	struct ice_perout_channel perout_channels[GLTSYN_TGT_H_IDX_MAX];
+	struct ice_extts_channel extts_channels[GLTSYN_TGT_H_IDX_MAX];
 	struct ptp_clock_info info;
 	struct ptp_clock *clock;
 	struct hwtstamp_config tstamp_config;
-- 
2.41.0


