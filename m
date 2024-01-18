Return-Path: <netdev+bounces-64252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6398B831EB5
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 18:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C985284933
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 17:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4772D2D63F;
	Thu, 18 Jan 2024 17:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bxMYEW7C"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA29A2D601
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705599983; cv=none; b=sTAtK+e1uwOiNWBP+7UIXiGxFERvrAa7Tn+PmIhIQkldqpRgPZEIpKoxKechdxuXFT6rIQWsDnOIjDYQAA3DAxqTrmRJt+5tr473Ikao6Lmx4iOJgnYRRdITxXmlh31qlx0o/5WggnZeTTEslY1mLpCFY3r4S/2rseb+PW4M0hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705599983; c=relaxed/simple;
	bh=yaPoMUGHcmmywvTpEwbEfgAOfPpiNDbg8eP4068lsig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nya0jYsy0N6Mi/tEt1FyCOaEFCSPp8WtEmh7IFdF35B8YSKhRVBxNuA1dRZASGvnoVe0aX05snxbGuL56v8jxOyxUsXqqcsJetxdTpMFA79aJ0U6zUOXhHbOOnj/aSQNppOWYqnnWcAOSX2vbJDTVJH0KPVEg5wPpLLIZtTJtFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bxMYEW7C; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705599982; x=1737135982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yaPoMUGHcmmywvTpEwbEfgAOfPpiNDbg8eP4068lsig=;
  b=bxMYEW7C6hqSzla5qEN9PIV21TeA7G9fbarKfWZlf6M++YFG4Nvxefv7
   q+9chsX76ZYXvv2YaQLOzKsjxVqc66XN1bV/q3+ySMPaTKJYP2q6c2qqW
   R18aw8+pP/bMIhDRs7d3K567ICwy9pMC5vInyfsF7D6zWOp9J4GMPbbkO
   n8Efh8UzQ6KLEEZbia8M84ZApNSajEaiyJ/njbfniPgK4UtAcFsOfCEcT
   BGx+PX1VFH4quLe1rJmVaW0/jE8Pi3KF54hFXC6xujw3W2XuTxCxtl3nm
   YSDzJKTeTzQ3+83bcnTFYtfROkFxtKgiC5ltR/yDxDBSp5Nm/kOP2clrW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="22001424"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="22001424"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 09:46:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="26819811"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by fmviesa001.fm.intel.com with ESMTP; 18 Jan 2024 09:46:20 -0800
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v6 iwl-next 7/7] ice: stop destroying and reinitalizing Tx tracker during reset
Date: Thu, 18 Jan 2024 18:45:52 +0100
Message-Id: <20240118174552.2565889-8-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240118174552.2565889-1-karol.kolacinski@intel.com>
References: <20240118174552.2565889-1-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
index 5ede4f61c054..c11eba07283c 100644
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
@@ -2715,6 +2731,11 @@ static int ice_ptp_rebuild_owner(struct ice_pf *pf)
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
@@ -2751,18 +2772,6 @@ void ice_ptp_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
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


