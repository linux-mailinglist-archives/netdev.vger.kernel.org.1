Return-Path: <netdev+bounces-53036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C8E80123E
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 19:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F951F20FC0
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF054F217;
	Fri,  1 Dec 2023 18:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rw7YnoZf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D21F9
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 10:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701454139; x=1732990139;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tLx+b65f8UmfQhumsK2V04ccWylY+s2ccqnYvr6ckd0=;
  b=Rw7YnoZfSn0HIq2S29wBThb/pNYVzuEion45e1xM2VAsSm45GfP7GqaV
   z2zIHSgoYAlzvSi6Q8zmwCiTI9T3Wb6wGDHgnHnxiBQf8SW0vaNNp/YYD
   kIQCNzRNuEwpOE00HUL4lwX4N64xSVtGx1IS7teTkFKP8CdVxwuh5oCte
   ZYeISwbr3Z6BPBAKWh0AOo7lT5xVbNFA0kVcBly9kK2kzoX55+hXKqxV4
   hDuXHIybSMo8Wf468RdMiJeGY5e940LKjYjPlA435XDuWmU4U6hRRE5sY
   XpUuY9lSkiLN+K++EqzJIq/kJ8fEW6cpJurscv9E6wGPgMiX7piXOmzFU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="12244407"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="12244407"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 10:08:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="893272450"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="893272450"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 01 Dec 2023 10:08:55 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Andrii Staikov <andrii.staikov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 5/6] ice: periodically kick Tx timestamp interrupt
Date: Fri,  1 Dec 2023 10:08:43 -0800
Message-ID: <20231201180845.219494-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231201180845.219494-1-anthony.l.nguyen@intel.com>
References: <20231201180845.219494-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 50 ++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index ac3f24693a50..03fc9c7cd21a 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2442,6 +2442,54 @@ enum ice_tx_tstamp_work ice_ptp_process_ts(struct ice_pf *pf)
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
@@ -2453,6 +2501,8 @@ static void ice_ptp_periodic_work(struct kthread_work *work)
 
 	err = ice_ptp_update_cached_phctime(pf);
 
+	ice_ptp_maybe_trigger_tx_interrupt(pf);
+
 	/* Run twice a second or reschedule if phc update failed */
 	kthread_queue_delayed_work(ptp->kworker, &ptp->work,
 				   msecs_to_jiffies(err ? 10 : 500));
-- 
2.41.0


