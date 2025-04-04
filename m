Return-Path: <netdev+bounces-179274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8C3A7BAD8
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 12:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690AD3BB046
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 10:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0F91EEA5F;
	Fri,  4 Apr 2025 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JNd9RvwO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D9C1EB5F1
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743762588; cv=none; b=LqWrwtu1/OpcpDc9MYdxXZl+1185torfh4vT7bVKHZPcJHJ0P9z83LLhO4qb79BscoiTcpvTX6TZMLh3GgK4xrLILaUducJpbZpUJCd1dmM839NOFNjIztKm9cWxD6gWpM6+msQqH/ysGg4pNn2ZLDwshWE8U2fYLlVornTM9E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743762588; c=relaxed/simple;
	bh=eYdMXKc46o68HlzUweUMWvRSpXW5tTwbEG/zYbnvEaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=es5YKfZtX/x/HgssRRFRIXHPvvdHGtaooPdRd5ogg0/zI6YKKDcAjm020GLIreObBLLlabL3e4L3nlwnTmFPbNc2coP2FfPVvy0RSGu2QtJ2pnuPQxgHwgJFwE2URAhVnmcPEWrfPMD1MAmeNnPUgTvUTiW+jnvKTItUim8B8Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JNd9RvwO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743762586; x=1775298586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eYdMXKc46o68HlzUweUMWvRSpXW5tTwbEG/zYbnvEaE=;
  b=JNd9RvwOdhKg9J/TcvYTim+kkujRdfZ/qfpKKcKM5qFwRBinDBzNiwtW
   1gjiCIC0V6oj6cfFAuusbntSH0L/2u2WqV1D/SGSJxhy3o26ZOGkWkrNL
   o4NqxgGrBPhOGqPAhmL82G+SLSL4ZTBANRBRUqWO94RtCKaVZi/0HhbUY
   bMeQIDX+tZDC4tHgdE14BbQNmhqpvkZGp79fN+j+btiVvgOxyVhKmV3M1
   onuN7wS2Yiu7MuDduqFjefbA8UBALBYgvaSoaQt2YuFNPOOCxFy7sbnUW
   SXBhrfcgrShvoNXn6B11e0/FUY9SrMOKtVeKw41lP8OiboZ8NyPlATndd
   A==;
X-CSE-ConnectionGUID: eiNbZOdRQe64idJ45CkFHQ==
X-CSE-MsgGUID: 9X71uzXBQgKJp7i7VJ2Q7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="48992445"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="48992445"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 03:29:45 -0700
X-CSE-ConnectionGUID: WmB5IEF3QOGV45MBuA5m+w==
X-CSE-MsgGUID: T5hNANURR/mfQ0t+vKoAIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="164485304"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa001.jf.intel.com with ESMTP; 04 Apr 2025 03:29:42 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id C16FF33EA0;
	Fri,  4 Apr 2025 11:29:40 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-net 2/6] iavf: centralize watchdog requeueing itself
Date: Fri,  4 Apr 2025 12:23:17 +0200
Message-Id: <20250404102321.25846-3-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250404102321.25846-1-przemyslaw.kitszel@intel.com>
References: <20250404102321.25846-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Centralize the unlock(critlock); unlock(netdev); queue_delayed_work(watchog_task);
pattern to one place.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 103 ++++++++------------
 1 file changed, 41 insertions(+), 62 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index a77c72643528..2c6e033c7341 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2911,6 +2911,8 @@ static void iavf_init_config_adapter(struct iavf_adapter *adapter)
 	iavf_change_state(adapter, __IAVF_INIT_FAILED);
 }
 
+static const int IAVF_NO_RESCHED = -1;
+
 /**
  * iavf_watchdog_task - Periodic call-back task
  * @work: pointer to work_struct
@@ -2922,6 +2924,7 @@ static void iavf_watchdog_task(struct work_struct *work)
 						    watchdog_task.work);
 	struct net_device *netdev = adapter->netdev;
 	struct iavf_hw *hw = &adapter->hw;
+	int msec_delay;
 	u32 reg_val;
 
 	netdev_lock(netdev);
@@ -2940,79 +2943,57 @@ static void iavf_watchdog_task(struct work_struct *work)
 	switch (adapter->state) {
 	case __IAVF_STARTUP:
 		iavf_startup(adapter);
-		mutex_unlock(&adapter->crit_lock);
-		netdev_unlock(netdev);
-		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
-				   msecs_to_jiffies(30));
-		return;
+		msec_delay = 30;
+		goto watchdog_done;
 	case __IAVF_INIT_VERSION_CHECK:
 		iavf_init_version_check(adapter);
-		mutex_unlock(&adapter->crit_lock);
-		netdev_unlock(netdev);
-		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
-				   msecs_to_jiffies(30));
-		return;
+		msec_delay = 30;
+		goto watchdog_done;
 	case __IAVF_INIT_GET_RESOURCES:
 		iavf_init_get_resources(adapter);
-		mutex_unlock(&adapter->crit_lock);
-		netdev_unlock(netdev);
-		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
-				   msecs_to_jiffies(1));
-		return;
+		msec_delay = 1;
+		goto watchdog_done;
 	case __IAVF_INIT_EXTENDED_CAPS:
 		iavf_init_process_extended_caps(adapter);
-		mutex_unlock(&adapter->crit_lock);
-		netdev_unlock(netdev);
-		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
-				   msecs_to_jiffies(1));
-		return;
+		msec_delay = 1;
+		goto watchdog_done;
 	case __IAVF_INIT_CONFIG_ADAPTER:
 		iavf_init_config_adapter(adapter);
-		mutex_unlock(&adapter->crit_lock);
-		netdev_unlock(netdev);
-		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
-				   msecs_to_jiffies(1));
-		return;
+		msec_delay = 1;
+		goto watchdog_done;
 	case __IAVF_INIT_FAILED:
 		if (test_bit(__IAVF_IN_REMOVE_TASK,
 			     &adapter->crit_section)) {
 			/* Do not update the state and do not reschedule
 			 * watchdog task, iavf_remove should handle this state
 			 * as it can loop forever
 			 */
-			mutex_unlock(&adapter->crit_lock);
-			netdev_unlock(netdev);
-			return;
+			msec_delay = IAVF_NO_RESCHED;
+			goto watchdog_done;
 		}
 		if (++adapter->aq_wait_count > IAVF_AQ_MAX_ERR) {
 			dev_err(&adapter->pdev->dev,
 				"Failed to communicate with PF; waiting before retry\n");
 			adapter->flags |= IAVF_FLAG_PF_COMMS_FAILED;
 			iavf_shutdown_adminq(hw);
-			mutex_unlock(&adapter->crit_lock);
-			netdev_unlock(netdev);
-			queue_delayed_work(adapter->wq,
-					   &adapter->watchdog_task, (5 * HZ));
-			return;
+			msec_delay = 5000;
+			goto watchdog_done;
 		}
 		/* Try again from failed step*/
 		iavf_change_state(adapter, adapter->last_state);
-		mutex_unlock(&adapter->crit_lock);
-		netdev_unlock(netdev);
-		queue_delayed_work(adapter->wq, &adapter->watchdog_task, HZ);
-		return;
+		msec_delay = 1000;
+		goto watchdog_done;
 	case __IAVF_COMM_FAILED:
 		if (test_bit(__IAVF_IN_REMOVE_TASK,
 			     &adapter->crit_section)) {
 			/* Set state to __IAVF_INIT_FAILED and perform remove
 			 * steps. Remove IAVF_FLAG_PF_COMMS_FAILED so the task
 			 * doesn't bring the state back to __IAVF_COMM_FAILED.
 			 */
 			iavf_change_state(adapter, __IAVF_INIT_FAILED);
 			adapter->flags &= ~IAVF_FLAG_PF_COMMS_FAILED;
-			mutex_unlock(&adapter->crit_lock);
-			netdev_unlock(netdev);
-			return;
+			msec_delay = IAVF_NO_RESCHED;
+			goto watchdog_done;
 		}
 		reg_val = rd32(hw, IAVF_VFGEN_RSTAT) &
 			  IAVF_VFGEN_RSTAT_VFR_STATE_MASK;
@@ -3030,18 +3011,11 @@ static void iavf_watchdog_task(struct work_struct *work)
 		}
 		adapter->aq_required = 0;
 		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
-		mutex_unlock(&adapter->crit_lock);
-		netdev_unlock(netdev);
-		queue_delayed_work(adapter->wq,
-				   &adapter->watchdog_task,
-				   msecs_to_jiffies(10));
-		return;
+		msec_delay = 10;
+		goto watchdog_done;
 	case __IAVF_RESETTING:
-		mutex_unlock(&adapter->crit_lock);
-		netdev_unlock(netdev);
-		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
-				   HZ * 2);
-		return;
+		msec_delay = 2000;
+		goto watchdog_done;
 	case __IAVF_DOWN:
 	case __IAVF_DOWN_PENDING:
 	case __IAVF_TESTING:
@@ -3068,36 +3042,41 @@ static void iavf_watchdog_task(struct work_struct *work)
 		break;
 	case __IAVF_REMOVE:
 	default:
-		mutex_unlock(&adapter->crit_lock);
-		netdev_unlock(netdev);
-		return;
+		msec_delay = IAVF_NO_RESCHED;
+		goto watchdog_done;
 	}
 
 	/* check for hw reset */
 	reg_val = rd32(hw, IAVF_VF_ARQLEN1) & IAVF_VF_ARQLEN1_ARQENABLE_MASK;
 	if (!reg_val) {
 		adapter->aq_required = 0;
 		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 		dev_err(&adapter->pdev->dev, "Hardware reset detected\n");
 		iavf_schedule_reset(adapter, IAVF_FLAG_RESET_PENDING);
-		mutex_unlock(&adapter->crit_lock);
-		netdev_unlock(netdev);
-		queue_delayed_work(adapter->wq,
-				   &adapter->watchdog_task, HZ * 2);
-		return;
+		msec_delay = 2000;
+		goto watchdog_done;
 	}
 
 	mutex_unlock(&adapter->crit_lock);
 restart_watchdog:
 	netdev_unlock(netdev);
+
+	/* note that we schedule a different task */
 	if (adapter->state >= __IAVF_DOWN)
 		queue_work(adapter->wq, &adapter->adminq_task);
 	if (adapter->aq_required)
-		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
-				   msecs_to_jiffies(20));
+		msec_delay = 20;
 	else
+		msec_delay = 2000;
+	goto skip_unlock;
+watchdog_done:
+	mutex_unlock(&adapter->crit_lock);
+	netdev_unlock(netdev);
+skip_unlock:
+
+	if (msec_delay != IAVF_NO_RESCHED)
 		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
-				   HZ * 2);
+				   msecs_to_jiffies(msec_delay));
 }
 
 /**
-- 
2.39.3


