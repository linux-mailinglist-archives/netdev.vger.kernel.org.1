Return-Path: <netdev+bounces-179275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC39A7BAD9
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 12:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E603B99ED
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 10:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9A01EF0AB;
	Fri,  4 Apr 2025 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OUiwFk5Y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DFE1EB5F2
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743762588; cv=none; b=u9oBBXbhBWswHGPXuItyyTE05yMa8OSXSPvAzwiEGVlsuFFT0Vy9Uza7KWs+3imwL5LD2LVmIAiefoohs/wo9YLTx1/w809hSirhsP+fn0PPCljEfpj3wVecC5CkBaNaI++sz+mKKJnVXblAItDMtq2zTsITtbtbudkcvUTJxCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743762588; c=relaxed/simple;
	bh=HOhC5WYvKkujcXUSuHQdfZVzRjpS/bRRl4PLGlFXK7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aQTs5fq3mmfejtFtjrYGJNMotmnaO+dnuBPUj3Rw+VdjfTqNxP8sX9pWM3NBl59j7B4058iAkdu5dS0ZyNPzlWtFnrYOc+W9ap5znM1tAe+92UfV6YNUvW9Xt05hXUz/hrhWtTFiRjvJZhDtryeXAnegWBPX6ob+9LTBWEP+02g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OUiwFk5Y; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743762586; x=1775298586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HOhC5WYvKkujcXUSuHQdfZVzRjpS/bRRl4PLGlFXK7g=;
  b=OUiwFk5YBOyQT+FC274OEOwlVlOtjaPEnzZFr8y6kswXpW1L4rR9fiU9
   wGoBJI2zbBWQ7MTGhrGwgpiRu1rdUSq4IQ9oiyOqnZgERjqKUiUSLmCgH
   85DlByqF8nxK0qJFwHMGJzyocH6SG88aq++vlQGv7aVCi2TJOu7kz+C8y
   BgMqBzuF80kF72GaV0b9FDewGRuiUpmMm1ILnJSsw/tzH0uc0/+VYQtxo
   73VtTT8wfHcyMIQ6JWno5lIPyhA3OZKNWF47ybkgYQshpMTb8ABNUC6I0
   Qm3mbNbaTLuHsAsrgwd8KaOnA/zKtewhYOltemalH+AwgF33kjpTqaPSz
   A==;
X-CSE-ConnectionGUID: BYQ7PkN2RGmj+pp9ZF9fEQ==
X-CSE-MsgGUID: BHWiME5mQdaSG0oO40qNzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="48992442"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="48992442"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 03:29:45 -0700
X-CSE-ConnectionGUID: LHuVmylZRaqpKE1LKfGZqg==
X-CSE-MsgGUID: HPuqOXThR+CrqbzNU0UaeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="164485305"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa001.jf.intel.com with ESMTP; 04 Apr 2025 03:29:43 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id D367F33EA7;
	Fri,  4 Apr 2025 11:29:41 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net 4/6] iavf: extract iavf_watchdog_step() out of iavf_watchdog_task()
Date: Fri,  4 Apr 2025 12:23:19 +0200
Message-Id: <20250404102321.25846-5-przemyslaw.kitszel@intel.com>
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

Finish up easy refactor of watchdog_task, total for this + prev two
commits is:
 1 file changed, 47 insertions(+), 82 deletions(-)

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 87 +++++++++------------
 1 file changed, 39 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 5efe44724d11..4b6963ffaba5 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2913,88 +2913,63 @@ static void iavf_init_config_adapter(struct iavf_adapter *adapter)
 
 static const int IAVF_NO_RESCHED = -1;
 
-/**
- * iavf_watchdog_task - Periodic call-back task
- * @work: pointer to work_struct
- **/
-static void iavf_watchdog_task(struct work_struct *work)
+/* return: msec delay for requeueing itself */
+static int iavf_watchdog_step(struct iavf_adapter *adapter)
 {
-	struct iavf_adapter *adapter = container_of(work,
-						    struct iavf_adapter,
-						    watchdog_task.work);
-	struct net_device *netdev = adapter->netdev;
 	struct iavf_hw *hw = &adapter->hw;
-	int msec_delay;
 	u32 reg_val;
 
-	netdev_lock(netdev);
-	if (!mutex_trylock(&adapter->crit_lock)) {
-		if (adapter->state == __IAVF_REMOVE) {
-			netdev_unlock(netdev);
-			return;
-		}
-
-		msec_delay = 20;
-		goto restart_watchdog;
-	}
+	netdev_assert_locked(adapter->netdev);
+	lockdep_assert_held(&adapter->crit_lock);
 
 	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)
 		iavf_change_state(adapter, __IAVF_COMM_FAILED);
 
 	switch (adapter->state) {
 	case __IAVF_STARTUP:
 		iavf_startup(adapter);
-		msec_delay = 30;
-		goto watchdog_done;
+		return 30;
 	case __IAVF_INIT_VERSION_CHECK:
 		iavf_init_version_check(adapter);
-		msec_delay = 30;
-		goto watchdog_done;
+		return 30;
 	case __IAVF_INIT_GET_RESOURCES:
 		iavf_init_get_resources(adapter);
-		msec_delay = 1;
-		goto watchdog_done;
+		return 1;
 	case __IAVF_INIT_EXTENDED_CAPS:
 		iavf_init_process_extended_caps(adapter);
-		msec_delay = 1;
-		goto watchdog_done;
+		return 1;
 	case __IAVF_INIT_CONFIG_ADAPTER:
 		iavf_init_config_adapter(adapter);
-		msec_delay = 1;
-		goto watchdog_done;
+		return 1;
 	case __IAVF_INIT_FAILED:
 		if (test_bit(__IAVF_IN_REMOVE_TASK,
 			     &adapter->crit_section)) {
 			/* Do not update the state and do not reschedule
 			 * watchdog task, iavf_remove should handle this state
 			 * as it can loop forever
 			 */
-			msec_delay = IAVF_NO_RESCHED;
-			goto watchdog_done;
+			return IAVF_NO_RESCHED;
 		}
 		if (++adapter->aq_wait_count > IAVF_AQ_MAX_ERR) {
 			dev_err(&adapter->pdev->dev,
 				"Failed to communicate with PF; waiting before retry\n");
 			adapter->flags |= IAVF_FLAG_PF_COMMS_FAILED;
 			iavf_shutdown_adminq(hw);
-			msec_delay = 5000;
-			goto watchdog_done;
+			return 5000;
 		}
 		/* Try again from failed step*/
 		iavf_change_state(adapter, adapter->last_state);
-		msec_delay = 1000;
-		goto watchdog_done;
+		return 1000;
 	case __IAVF_COMM_FAILED:
 		if (test_bit(__IAVF_IN_REMOVE_TASK,
 			     &adapter->crit_section)) {
 			/* Set state to __IAVF_INIT_FAILED and perform remove
 			 * steps. Remove IAVF_FLAG_PF_COMMS_FAILED so the task
 			 * doesn't bring the state back to __IAVF_COMM_FAILED.
 			 */
 			iavf_change_state(adapter, __IAVF_INIT_FAILED);
 			adapter->flags &= ~IAVF_FLAG_PF_COMMS_FAILED;
-			msec_delay = IAVF_NO_RESCHED;
-			goto watchdog_done;
+			return IAVF_NO_RESCHED;
 		}
 		reg_val = rd32(hw, IAVF_VFGEN_RSTAT) &
 			  IAVF_VFGEN_RSTAT_VFR_STATE_MASK;
@@ -3012,11 +2987,9 @@ static void iavf_watchdog_task(struct work_struct *work)
 		}
 		adapter->aq_required = 0;
 		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
-		msec_delay = 10;
-		goto watchdog_done;
+		return 10;
 	case __IAVF_RESETTING:
-		msec_delay = 2000;
-		goto watchdog_done;
+		return 2000;
 	case __IAVF_DOWN:
 	case __IAVF_DOWN_PENDING:
 	case __IAVF_TESTING:
@@ -3043,8 +3016,7 @@ static void iavf_watchdog_task(struct work_struct *work)
 		break;
 	case __IAVF_REMOVE:
 	default:
-		msec_delay = IAVF_NO_RESCHED;
-		goto watchdog_done;
+		return IAVF_NO_RESCHED;
 	}
 
 	/* check for hw reset */
@@ -3055,12 +3027,31 @@ static void iavf_watchdog_task(struct work_struct *work)
 		dev_err(&adapter->pdev->dev, "Hardware reset detected\n");
 		iavf_schedule_reset(adapter, IAVF_FLAG_RESET_PENDING);
 	}
-	if (adapter->aq_required)
+
+	return adapter->aq_required ? 20 : 2000;
+}
+
+static void iavf_watchdog_task(struct work_struct *work)
+{
+	struct iavf_adapter *adapter = container_of(work,
+						    struct iavf_adapter,
+						    watchdog_task.work);
+	struct net_device *netdev = adapter->netdev;
+	int msec_delay;
+
+	netdev_lock(netdev);
+	if (!mutex_trylock(&adapter->crit_lock)) {
+		if (adapter->state == __IAVF_REMOVE) {
+			netdev_unlock(netdev);
+			return;
+		}
+
 		msec_delay = 20;
-	else
-		msec_delay = 2000;
+		goto restart_watchdog;
+	}
+
+	msec_delay = iavf_watchdog_step(adapter);
 
-watchdog_done:
 	mutex_unlock(&adapter->crit_lock);
 restart_watchdog:
 	netdev_unlock(netdev);
-- 
2.39.3


