Return-Path: <netdev+bounces-45920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A5C7E068F
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 17:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15611C20D5F
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 16:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A369B1CA86;
	Fri,  3 Nov 2023 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YjO/8t0j"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBC914002
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 16:29:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322A0DC
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 09:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699028988; x=1730564988;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZM7k9U6K2HWp2Z+WbEZLG086m0b66EREtoBdOAA0A/M=;
  b=YjO/8t0jKlaNhC28f7PKaVdW35hzP3wnIkNIIfJItjtcUXNkGCfZ9aTU
   jQdCBQJK6sydWp7Fzx7LFrkVov7MTgK4/nAq0ZjYP1GNEtDeUpLIj5o1b
   ITwIxXLwIEDUAhl593IULOtbEqyhY5AdD2udSrpfalVbPCHaiUSWxvpmW
   BU5iDqElvfhJsQYU8QY4ezgSzz5Hl+fBzOxqPuGV9gJouLcCLlnPGANWe
   dhweS5TsYXbtHQEt0z6f2AzqWKdS/Ci8fjI+svq3K7grPf7ffPcAFoda1
   8q7PbLeng55yvrlmRAx334K0MkabkqWx7+vXrRixaon8i8LWYGgK6BtpM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="10512057"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="10512057"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 09:29:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="878698178"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="878698178"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by fmsmga002.fm.intel.com with ESMTP; 03 Nov 2023 09:29:45 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Andrii Staikov <andrii.staikov@intel.com>
Subject: [PATCH iwl-next] ice: periodically kick Tx timestamp interrupt
Date: Fri,  3 Nov 2023 17:29:43 +0100
Message-Id: <20231103162943.485467-1-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The E822 hardware for Tx timestamping keeps track of how many
outstanding timestamps are still in the PHY memory block. It will not
generate a new interrupt to the MAC until all of the timestamps in the
region have been read.

If somehow all the available data is not read, but the driver has exited
its interrupt routine already, the PHY will not generate a new interrupt
even if new timestamp data is captured. Because no interrupt is
generated, the driver never processes the timestamp data. This state
results in a permanent failure for all future Tx timestamps.

It is not clear how the driver and hardware could enter this state.
However, if it does, there is currently no recovery mechanism.

Add a recovery mechanism via the periodic PTP work thread which invokes
ice_ptp_periodic_work(). Introduce a new check,
ice_ptp_maybe_trigger_tx_interrupt() which checks the PHY timestamp
ready bitmask. If any bits are set, trigger a software interrupt by
writing to PFINT_OICR.

Once triggered, the main timestamp processing thread will read through
the PHY data and clear the outstanding timestamp data. Once cleared, new
data should trigger interrupts as expected.

This should allow recovery from such a state rather than leaving the
device in a state where we cannot process Tx timestamps.

It is possible that this function checks for timestamp data
simultaneously with the interrupt, and it might trigger additional
unnecessary interrupts. This will cause a small amount of additional
processing.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Andrii Staikov <andrii.staikov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 50 ++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 5fb9dbbdfc16..79c1fa61d1a8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2460,6 +2460,54 @@ enum ice_tx_tstamp_work ice_ptp_process_ts(struct ice_pf *pf)
 	}
 }
 
+/**
+ * ice_ptp_maybe_trigger_tx_interrupt - Trigger Tx timstamp interrupt
+ * @pf: Board private structure
+ *
+ * The device PHY issues Tx timestamp interrupts to the driver for processing
+ * timestamp data from the PHY. It will not interrupt again until all
+ * current timestamp data is read. In rare circumstances, it is possible that
+ * the driver fails to read all outstanding data.
+ *
+ * To avoid getting permanently stuck, periodically check if the PHY has
+ * outstanding timestamp data. If so, trigger an interrupt from software to
+ * process this data.
+ */
+static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
+{
+	struct device *dev = ice_pf_to_dev(pf);
+	struct ice_hw *hw = &pf->hw;
+	bool trigger_oicr = false;
+	unsigned int i;
+
+	if (ice_is_e810(hw))
+		return;
+
+	if (!ice_pf_src_tmr_owned(pf))
+		return;
+
+	for (i = 0; i < ICE_MAX_QUAD; i++) {
+		u64 tstamp_ready;
+		int err;
+
+		err = ice_get_phy_tx_tstamp_ready(&pf->hw, i, &tstamp_ready);
+		if (!err && tstamp_ready) {
+			trigger_oicr = true;
+			break;
+		}
+	}
+
+	if (trigger_oicr) {
+		/* Trigger a software interrupt, to ensure this data
+		 * gets processed.
+		 */
+		dev_dbg(dev, "PTP periodic task detected waiting timestamps. Triggering Tx timestamp interrupt now.\n");
+
+		wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);
+		ice_flush(hw);
+	}
+}
+
 static void ice_ptp_periodic_work(struct kthread_work *work)
 {
 	struct ice_ptp *ptp = container_of(work, struct ice_ptp, work.work);
@@ -2471,6 +2519,8 @@ static void ice_ptp_periodic_work(struct kthread_work *work)
 
 	err = ice_ptp_update_cached_phctime(pf);
 
+	ice_ptp_maybe_trigger_tx_interrupt(pf);
+
 	/* Run twice a second or reschedule if phc update failed */
 	kthread_queue_delayed_work(ptp->kworker, &ptp->work,
 				   msecs_to_jiffies(err ? 10 : 500));

base-commit: 75eabdb41c25d36bd15661df81033a4e3086c4c9
-- 
2.40.1


