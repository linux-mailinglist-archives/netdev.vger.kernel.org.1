Return-Path: <netdev+bounces-55950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 980C480CEEE
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410411F219B6
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4168B4AF69;
	Mon, 11 Dec 2023 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mKxhz3w+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47083AB
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 07:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702306965; x=1733842965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9ScAq09hYEJMh5QtZv0jv/+C5ikdy9w1RFO5ONE7WUw=;
  b=mKxhz3w+wSHR2g8Mymav02fHhh0/jWj667FqLm+X+l+Xx3iT6vBYmrWR
   K+l4tWgMYnJDuP82IyC0KNKAofRQX9ioVB6eJyVaB9q0p9iTCyZkOFaXM
   di4zryf+VjT4NLosNNAvrYQcBgeSYKh35vtM+GgU7KURHRFH+gdJCv5Ma
   ElUOmafrpk7HqPckROp+Lde/amfK3mMgm698yaLWFBGUjfwiwJXPGgG3B
   hcK0V23HZ0zU5o2SrTLXU/AsxAepFxztXEo66ZnEAr210OHRF4yxkjdM5
   7Il6UcajZaDDQhqGH+ZjLljcVIwBpKJBT3WGmDBUCVVMorp69OAtB/ymY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="393532337"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="393532337"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 07:02:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="773090884"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="773090884"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orsmga002.jf.intel.com with ESMTP; 11 Dec 2023 07:02:43 -0800
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v2 iwl-next 6/6] ice: stop destroying and reinitalizing Tx tracker during reset
Date: Mon, 11 Dec 2023 16:02:26 +0100
Message-Id: <20231211150226.295090-7-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231211150226.295090-1-karol.kolacinski@intel.com>
References: <20231211150226.295090-1-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The ice driver currently attempts to destroy and re-initialize the Tx
timestamp tracker during the reset flow. The release of the Tx tracker
only happened during CORE reset or GLOBAL reset. The ice_ptp_rebuild()
function always calls the ice_ptp_init_tx function which will allocate
a new tracker data structure, resulting in memory leaks during PF reset.

Certainly the driver should not be allocating a new tracker without
removing the old tracker data, as this results in a memory leak.
Additionally, there's no reason to remove the tracker memory during a
reset. Remove this logic from the reset and rebuild flow. Instead of
releasing the Tx tracker, flush outstanding timestamps just before we
reset the PHY timestamp block in ice_ptp_cfg_phy_interrupt().

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 33 +++++++++++++++---------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 2f862b2e1a90..d0e9f793f4d1 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -963,6 +963,22 @@ ice_ptp_mark_tx_tracker_stale(struct ice_ptp_tx *tx)
 	spin_unlock_irqrestore(&tx->lock, flags);
 }
 
+/**
+ * ice_ptp_flush_all_tx_tracker - Flush all timestamp trackers on this clock
+ * @pf: Board private structure
+ *
+ * Called by the clock owner to flush all the Tx timestamp trackers associated
+ * with the clock.
+ */
+static void
+ice_ptp_flush_all_tx_tracker(struct ice_pf *pf)
+{
+	struct ice_ptp_port *port;
+
+	list_for_each_entry(port, &pf->ptp.ports_owner.ports, list_member)
+		ice_ptp_flush_tx_tracker(ptp_port_to_pf(port), &port->tx);
+}
+
 /**
  * ice_ptp_release_tx_tracker - Release allocated memory for Tx tracker
  * @pf: Board private structure
@@ -2721,6 +2737,11 @@ static int ice_ptp_rebuild_owner(struct ice_pf *pf)
 	/* Release the global hardware lock */
 	ice_ptp_unlock(hw);
 
+	/* Flush software tracking of any outstanding timestamps since we're
+	 * about to flush the PHY timestamp block.
+	 */
+	ice_ptp_flush_all_tx_tracker(pf);
+
 	if (!ice_is_e810(hw)) {
 		/* Enable quad interrupts */
 		err = ice_ptp_cfg_phy_interrupt(pf, true, 1);
@@ -2759,18 +2780,6 @@ void ice_ptp_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 			goto err;
 	}
 
-	/* Init Tx structures */
-	if (ice_is_e810(&pf->hw)) {
-		err = ice_ptp_init_tx_e810(pf, &ptp->port.tx);
-	} else {
-		kthread_init_delayed_work(&ptp->port.ov_work,
-					  ice_ptp_wait_for_offsets);
-		err = ice_ptp_init_tx_e82x(pf, &ptp->port.tx,
-					   ptp->port.port_num);
-	}
-	if (err)
-		goto err;
-
 	ptp->state = ICE_PTP_READY;
 
 	/* Start periodic work going */
-- 
2.40.1


