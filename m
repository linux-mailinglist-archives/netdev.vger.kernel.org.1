Return-Path: <netdev+bounces-116280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6888949D0B
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 02:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFAF31C21552
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 00:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC671DFEB;
	Wed,  7 Aug 2024 00:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k4ZdKTCj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30D81DDEB
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 00:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722991010; cv=none; b=dfqELMo12SpNtEeX5EqPnhLPgdDPmY5qCim3/Fi4Bs2F1nQWHiXmVQux8dq+0NtTeoekA3/NMcAcHuB/oNHaIWmJtXx0Rjn/pjPrdxZcWzBEnSAXXNpUaOG4YIQgk94902PGaHbSBKDsbsblbtcI27sXJpqfMNgvRlvo3IpEUOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722991010; c=relaxed/simple;
	bh=8WR6VOKinrRYanLaA5NwZ8rozUY7FOgk66VVTRV++uw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f5UO833J4Idv4V0xTSjVFF61B+HMLaLD8IW/tWiuRUnSnIZpHg0dw/xGEQsAsPRS4pXdQl7FIdoWGDt0Itf3c9ITGomfwWodCkxjZF8b/6ogv4FXEqOPrFh8O77zb/asQ17tX1YBnoMU2l/87c+xmUhCiFO1T5kEk4rFXXoHe+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k4ZdKTCj; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722991009; x=1754527009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8WR6VOKinrRYanLaA5NwZ8rozUY7FOgk66VVTRV++uw=;
  b=k4ZdKTCj5iWWF4lpUa6Y5jeQif9buL8jiGvJY/1mmHborHGpWL1COAAW
   rxCaPe/IaJuggmpDpw+nuVpbNp2+LNLTdAJJpQScFHAWDteQf1Yc90x3q
   lKFKs/WT+sZnxaw+ijQX8Y8O4KDWalemY5Yn0jRd4Nh+x8TH4TLtvmV9d
   fA8HR3u/jy4vSeIZbiUlQQui/vsBKVMi78hc3/k3FKdg9XyLLWOkcYruE
   da4ERChxIPZfe2xyBayImV5q9anDO9egIPHngivcUpfsDcl8e9iYWQ0/v
   V5qGT2GTqtLAYipzl3rS78keLL9Ct9tRtNTZUFWv7yPNhq3X45cF4gZpQ
   A==;
X-CSE-ConnectionGUID: GNfRr3VST7a2Zj9K6rrreA==
X-CSE-MsgGUID: vRjpF1yVQe+ro2QRPlpauA==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="31669744"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="31669744"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 17:36:49 -0700
X-CSE-ConnectionGUID: YefdZEw/T4yTRd6p5xjdTQ==
X-CSE-MsgGUID: xpfh385pRd+kEFufZ0BG3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="61496999"
Received: from timelab-spr09.ch.intel.com (HELO timelab-spr09.sc.intel.com) ([143.182.136.138])
  by orviesa003.jf.intel.com with ESMTP; 06 Aug 2024 17:36:47 -0700
From: christopher.s.hall@intel.com
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	vinicius.gomes@intel.com,
	david.zage@intel.com,
	vinschen@redhat.com,
	rodrigo.cadore@l-acoustics.com,
	Christopher S M Hall <christopher.s.hall@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-net v1 1/5] igc: Ensure the PTM cycle is reliably triggered
Date: Tue,  6 Aug 2024 17:30:28 -0700
Message-Id: <20240807003032.10300-2-christopher.s.hall@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807003032.10300-1-christopher.s.hall@intel.com>
References: <20240807003032.10300-1-christopher.s.hall@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christopher S M Hall <christopher.s.hall@intel.com>

Writing to clear the PTM status 'valid' bit while the PTM cycle is
triggered results in unreliable PTM operation. To fix this, clear the
PTM 'trigger' and status after each PTM transaction.

The issue can be reproduced with the following:

$ sudo phc2sys -R 1000 -O 0 -i tsn0 -m

Note: 1000 Hz (-R 1000) is unrealistically large, but provides a way to
quickly reproduce the issue.

PHC2SYS exits with:

"ioctl PTP_OFFSET_PRECISE: Connection timed out" when the PTM transaction
  fails

Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
Signed-off-by: Christopher S M Hall <christopher.s.hall@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h |  1 +
 drivers/net/ethernet/intel/igc/igc_ptp.c     | 70 ++++++++++++--------
 2 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 511384f3ec5c..ec191d26c650 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -583,6 +583,7 @@
 #define IGC_PTM_STAT_T4M1_OVFL		BIT(3) /* T4 minus T1 overflow */
 #define IGC_PTM_STAT_ADJUST_1ST		BIT(4) /* 1588 timer adjusted during 1st PTM cycle */
 #define IGC_PTM_STAT_ADJUST_CYC		BIT(5) /* 1588 timer adjusted during non-1st PTM cycle */
+#define IGC_PTM_STAT_ALL        	GENMASK(5, 0) /* Used to clear all status */
 
 /* PCIe PTM Cycle Control */
 #define IGC_PTM_CYCLE_CTRL_CYC_TIME(msec)	((msec) & 0x3ff) /* PTM Cycle Time (msec) */
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 946edbad4302..00cc80d8d164 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -974,11 +974,38 @@ static void igc_ptm_log_error(struct igc_adapter *adapter, u32 ptm_stat)
 	}
 }
 
+static void igc_ptm_trigger(struct igc_hw *hw)
+{
+	u32 ctrl;
+
+	/* To "manually" start the PTM cycle we need to set the
+	 * trigger (TRIG) bit
+	 */
+	ctrl = rd32(IGC_PTM_CTRL);
+	ctrl |= IGC_PTM_CTRL_TRIG;
+	wr32(IGC_PTM_CTRL, ctrl);
+	/* Perform flush after write to CTRL register otherwise
+	 * transaction may not start
+	 */
+	wrfl();
+}
+
+static void igc_ptm_reset(struct igc_hw *hw)
+{
+	u32 ctrl;
+
+	ctrl = rd32(IGC_PTM_CTRL);
+	ctrl &= ~IGC_PTM_CTRL_TRIG;
+	wr32(IGC_PTM_CTRL, ctrl);
+	/* Write to clear all status */
+	wr32(IGC_PTM_STAT, IGC_PTM_STAT_ALL);
+}
+
 static int igc_phc_get_syncdevicetime(ktime_t *device,
 				      struct system_counterval_t *system,
 				      void *ctx)
 {
-	u32 stat, t2_curr_h, t2_curr_l, ctrl;
+	u32 stat, t2_curr_h, t2_curr_l;
 	struct igc_adapter *adapter = ctx;
 	struct igc_hw *hw = &adapter->hw;
 	int err, count = 100;
@@ -994,25 +1021,13 @@ static int igc_phc_get_syncdevicetime(ktime_t *device,
 		 * are transitory. Repeating the process returns valid
 		 * data eventually.
 		 */
-
-		/* To "manually" start the PTM cycle we need to clear and
-		 * then set again the TRIG bit.
-		 */
-		ctrl = rd32(IGC_PTM_CTRL);
-		ctrl &= ~IGC_PTM_CTRL_TRIG;
-		wr32(IGC_PTM_CTRL, ctrl);
-		ctrl |= IGC_PTM_CTRL_TRIG;
-		wr32(IGC_PTM_CTRL, ctrl);
-
-		/* The cycle only starts "for real" when software notifies
-		 * that it has read the registers, this is done by setting
-		 * VALID bit.
-		 */
-		wr32(IGC_PTM_STAT, IGC_PTM_STAT_VALID);
+		igc_ptm_trigger(hw);
 
 		err = readx_poll_timeout(rd32, IGC_PTM_STAT, stat,
 					 stat, IGC_PTM_STAT_SLEEP,
 					 IGC_PTM_STAT_TIMEOUT);
+		igc_ptm_reset(hw);
+
 		if (err < 0) {
 			netdev_err(adapter->netdev, "Timeout reading IGC_PTM_STAT register\n");
 			return err;
@@ -1021,15 +1036,7 @@ static int igc_phc_get_syncdevicetime(ktime_t *device,
 		if ((stat & IGC_PTM_STAT_VALID) == IGC_PTM_STAT_VALID)
 			break;
 
-		if (stat & ~IGC_PTM_STAT_VALID) {
-			/* An error occurred, log it. */
-			igc_ptm_log_error(adapter, stat);
-			/* The STAT register is write-1-to-clear (W1C),
-			 * so write the previous error status to clear it.
-			 */
-			wr32(IGC_PTM_STAT, stat);
-			continue;
-		}
+		igc_ptm_log_error(adapter, stat);
 	} while (--count);
 
 	if (!count) {
@@ -1255,7 +1262,7 @@ void igc_ptp_stop(struct igc_adapter *adapter)
 void igc_ptp_reset(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
-	u32 cycle_ctrl, ctrl;
+	u32 cycle_ctrl, ctrl, stat;
 	unsigned long flags;
 	u32 timadj;
 
@@ -1290,14 +1297,19 @@ void igc_ptp_reset(struct igc_adapter *adapter)
 		ctrl = IGC_PTM_CTRL_EN |
 			IGC_PTM_CTRL_START_NOW |
 			IGC_PTM_CTRL_SHRT_CYC(IGC_PTM_SHORT_CYC_DEFAULT) |
-			IGC_PTM_CTRL_PTM_TO(IGC_PTM_TIMEOUT_DEFAULT) |
-			IGC_PTM_CTRL_TRIG;
+			IGC_PTM_CTRL_PTM_TO(IGC_PTM_TIMEOUT_DEFAULT);
 
 		wr32(IGC_PTM_CTRL, ctrl);
 
 		/* Force the first cycle to run. */
-		wr32(IGC_PTM_STAT, IGC_PTM_STAT_VALID);
+		igc_ptm_trigger(hw);
+
+		if (readx_poll_timeout_atomic(rd32, IGC_PTM_STAT, stat,
+					      stat, IGC_PTM_STAT_SLEEP,
+					      IGC_PTM_STAT_TIMEOUT))
+			netdev_err(adapter->netdev, "Timeout reading IGC_PTM_STAT register\n");
 
+		igc_ptm_reset(hw);
 		break;
 	default:
 		/* No work to do. */
-- 
2.34.1


