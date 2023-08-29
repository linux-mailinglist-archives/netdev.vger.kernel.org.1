Return-Path: <netdev+bounces-31190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7AC78C284
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 12:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37120280DBE
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 10:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D2E156F5;
	Tue, 29 Aug 2023 10:41:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CADD156C8
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 10:41:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD911A4
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 03:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693305673; x=1724841673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lMLK+r4px6A8YKQ01i0GxE+1NW6ncI5cNHaegedXoo0=;
  b=LFSyfsOq2nNRv6/khB8KpnCcUa/B+ZGH/K8+0Kxw0UT4jUvm2onWRupI
   CaLFwTAkyKQLP0G8bm+dDSeY0hbcaXzhWaYFJrmkkw90waJ85mWXYBwtY
   MrvEv+44yZUzUJB3ycnzrN7nK5eOwLlGA9hQ8un/WUo4hDL7V2i+J6+AM
   08XGQBTTJ18D1okO51iCVDLJ6jBLz5R7pJvmTlbGna7JyzwO9CvbdnZoU
   YsRFQhfilId/SAMB20Gl4H1kBAUFDOzQyxXVx9OncgNezzFNZ5aJrYmQC
   viJ8wmWjtdGglXUSmgAIufchfz/GRew71cw3s6GYPF6GY8AVWcLkBshOV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="461696931"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="461696931"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 03:41:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="853229862"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="853229862"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2023 03:41:11 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v4 iwl-next 11/11] ice: stop destroying and reinitalizing Tx tracker during reset
Date: Tue, 29 Aug 2023 12:40:41 +0200
Message-Id: <20230829104041.64131-12-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230829104041.64131-1-karol.kolacinski@intel.com>
References: <20230829104041.64131-1-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 33 +++++++++++++++---------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index f9df35ebaff4..a228d62f72c0 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -868,6 +868,22 @@ ice_ptp_mark_tx_tracker_stale(struct ice_ptp_tx *tx)
 	spin_unlock(&tx->lock);
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
@@ -2575,6 +2591,11 @@ static int ice_ptp_rebuild_owner(struct ice_pf *pf)
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
@@ -2610,18 +2631,6 @@ void ice_ptp_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 	if (ice_pf_src_tmr_owned(pf) && reset_type != ICE_RESET_PFR)
 		ice_ptp_rebuild_owner(pf);
 
-	/* Init Tx structures */
-	if (ice_is_e810(&pf->hw)) {
-		err = ice_ptp_init_tx_e810(pf, &ptp->port.tx);
-	} else {
-		kthread_init_delayed_work(&ptp->port.ov_work,
-					  ice_ptp_wait_for_offsets);
-		err = ice_ptp_init_tx_e822(pf, &ptp->port.tx,
-					   ptp->port.port_num);
-	}
-	if (err)
-		goto err;
-
 	ptp->state = ICE_PTP_READY;
 
 	/* Start periodic work going */
-- 
2.39.2


