Return-Path: <netdev+bounces-73474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D7385CBE9
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 00:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35A91F23041
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 23:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741A515444E;
	Tue, 20 Feb 2024 23:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NE5szozN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1A3154431
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 23:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708471064; cv=none; b=b7HCtWiSw8Pm1O3e6gVkcUHuQ88eHYvPtwlJ/ceaZvzzDGmCUAsLbdIJXqlNNClryPuOrMgDf2IbylBBxnscKMJHxPh+N/nu/GZRym2/RisVxaELrQugl1Ax42lBt5vfKqhYb4HoZoIXMbZi/yM+GVhYipqjkdiYRBn4dXGJC+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708471064; c=relaxed/simple;
	bh=rLt2N4qD6L6RlGXQyss0vOroeT+miPoL8jbOXfsCIvc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bhbNziYvtZvTxuWzwgtBnTO0gL3w8DGCVqJldlLK23NF32Okn4X2ao2zUcMRmeFsvOFe3sLWnbSObVunc4E0wv5R9DRdLMtCx1BNPkBcB2xLL2TOuEgAZcTS6k4cexjZ3Z8zKksBJlxQAQ0YSzX0RsrJv7HVQ3d4Qd8tdbj18Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NE5szozN; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708471062; x=1740007062;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rLt2N4qD6L6RlGXQyss0vOroeT+miPoL8jbOXfsCIvc=;
  b=NE5szozNFmKfY94thzeafKj1oR8FoMrIumZXFYwpLxP3lB800vC2b8MC
   IGSXK0ddarWz/KdojZvBb5HG7l1USYdCgJLd2KV2Z+/wkOBYiyKopN5DZ
   nLyqzm2i3FPhtYLO/eVTlF8ImgG0mQJc6Nr7UStvz6rlLcEZVb0ieJD+L
   Hbh48YPM+Z6290LHCFynq1u2pmIWSaCJwI/STe35bWfaBSCuGNfoDerMp
   seeYfW4ZszXHWuW3Y4mdl7wDlOww6bqGcMkRdlopA2yRo1WrUJ5UfAu92
   FBM+gql6w6SKDpA9j/WCG9WYknl3RUGyA1Wq/LHsCJ4Kq7+MIZDVt+8XW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="5560983"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5560983"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 15:17:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="913165830"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="913165830"
Received: from jbrandeb-coyote30.jf.intel.com ([10.166.29.19])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 15:17:30 -0800
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	netdev@vger.kernel.org,
	Robert Elliott <elliott@hpe.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-net v1] ice: fix NULL pointer access during resume
Date: Tue, 20 Feb 2024 15:17:20 -0800
Message-Id: <20240220231720.14836-1-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ice_suspend/ice_resume cycle was not updated when refactoring was
done to the init path and I suspect this allowed a bug to creep in where
the driver was not correctly reinitialized during resume.

I was able to test against 6.1.77 kernel and that ice driver works fine
for suspend/resume with no panic.

Instead of tearing down interrupts and freeing a bunch of memory during
suspend, just begin an internal reset event, which takes care of all the
correct steps during suspend.  Likewise during resume we'll just let the
reset complete and the driver comes right back to life. This mirrors the
behavior of other suspend/resume code in drivers like fm10k.

Older kernel commits were made to this driver and to the i40e driver to
try to fix "disk" or hibernate suspend events with many CPUs. The PM
subsystem was updated since then but the drivers kept the old flows.
Testing with rtcwake -m [disk | mem] -s 10 - passes but my system won't
hibernate due to too much RAM, not enough swap.

The code is slightly refactored during this change in order to share a
common "prep" path between suspend and the pci error handler functions
which all do the same thing, so introduce ice_quiesce_before_reset().

While doing all this and compile testing I ran across the pm.h changes
to get rid of compilation problems when CONFIG_PM=n etc, so those small
changes are included here as well.

PANIC from 6.8.0-rc1:

[1026674.915596] PM: suspend exit
[1026675.664697] ice 0000:17:00.1: PTP reset successful
[1026675.664707] ice 0000:17:00.1: 2755 msecs passed between update to cached PHC time
[1026675.667660] ice 0000:b1:00.0: PTP reset successful
[1026675.675944] ice 0000:b1:00.0: 2832 msecs passed between update to cached PHC time
[1026677.137733] ixgbe 0000:31:00.0 ens787: NIC Link is Up 1 Gbps, Flow Control: None
[1026677.190201] BUG: kernel NULL pointer dereference, address: 0000000000000010
[1026677.192753] ice 0000:17:00.0: PTP reset successful
[1026677.192764] ice 0000:17:00.0: 4548 msecs passed between update to cached PHC time
[1026677.197928] #PF: supervisor read access in kernel mode
[1026677.197933] #PF: error_code(0x0000) - not-present page
[1026677.197937] PGD 1557a7067 P4D 0
[1026677.212133] ice 0000:b1:00.1: PTP reset successful
[1026677.212143] ice 0000:b1:00.1: 4344 msecs passed between update to cached PHC time
[1026677.212575]
[1026677.243142] Oops: 0000 [#1] PREEMPT SMP NOPTI
[1026677.247918] CPU: 23 PID: 42790 Comm: kworker/23:0 Kdump: loaded Tainted: G        W          6.8.0-rc1+ #1
[1026677.257989] Hardware name: Intel Corporation M50CYP2SBSTD/M50CYP2SBSTD, BIOS SE5C620.86B.01.01.0005.2202160810 02/16/2022
[1026677.269367] Workqueue: ice ice_service_task [ice]
[1026677.274592] RIP: 0010:ice_vsi_rebuild_set_coalesce+0x130/0x1e0 [ice]
[1026677.281421] Code: 0f 84 3a ff ff ff 41 0f b7 74 ec 02 66 89 b0 22 02 00 00 81 e6 ff 1f 00 00 e8 ec fd ff ff e9 35 ff ff ff 48 8b 43 30 49 63 ed <41> 0f b7 34 24 41 83 c5 01 48 8b 3c e8 66 89 b7 aa 02 00 00 81 e6
[1026677.300877] RSP: 0018:ff3be62a6399bcc0 EFLAGS: 00010202
[1026677.306556] RAX: ff28691e28980828 RBX: ff28691e41099828 RCX: 0000000000188000
[1026677.314148] RDX: 0000000000000000 RSI: 0000000000000010 RDI: ff28691e41099828
[1026677.321730] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[1026677.329311] R10: 0000000000000007 R11: ffffffffffffffc0 R12: 0000000000000010
[1026677.336896] R13: 0000000000000000 R14: 0000000000000000 R15: ff28691e0eaa81a0
[1026677.344472] FS:  0000000000000000(0000) GS:ff28693cbffc0000(0000) knlGS:0000000000000000
[1026677.353000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[1026677.359195] CR2: 0000000000000010 CR3: 0000000128df4001 CR4: 0000000000771ef0
[1026677.366779] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[1026677.374369] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[1026677.381952] PKRU: 55555554
[1026677.385116] Call Trace:
[1026677.388023]  <TASK>
[1026677.390589]  ? __die+0x20/0x70
[1026677.394105]  ? page_fault_oops+0x82/0x160
[1026677.398576]  ? do_user_addr_fault+0x65/0x6a0
[1026677.403307]  ? exc_page_fault+0x6a/0x150
[1026677.407694]  ? asm_exc_page_fault+0x22/0x30
[1026677.412349]  ? ice_vsi_rebuild_set_coalesce+0x130/0x1e0 [ice]
[1026677.418614]  ice_vsi_rebuild+0x34b/0x3c0 [ice]
[1026677.423583]  ice_vsi_rebuild_by_type+0x76/0x180 [ice]
[1026677.429147]  ice_rebuild+0x18b/0x520 [ice]
[1026677.433746]  ? delay_tsc+0x8f/0xc0
[1026677.437630]  ice_do_reset+0xa3/0x190 [ice]
[1026677.442231]  ice_service_task+0x26/0x440 [ice]
[1026677.447180]  process_one_work+0x174/0x340
[1026677.451669]  worker_thread+0x27e/0x390
[1026677.455890]  ? __pfx_worker_thread+0x10/0x10
[1026677.460627]  kthread+0xee/0x120
[1026677.464235]  ? __pfx_kthread+0x10/0x10
[1026677.468445]  ret_from_fork+0x2d/0x50
[1026677.472476]  ? __pfx_kthread+0x10/0x10
[1026677.476671]  ret_from_fork_asm+0x1b/0x30
[1026677.481050]  </TASK>

Fixes: 5b246e533d01 ("ice: split probe into smaller functions")
Reported-by: Robert Elliott <elliott@hpe.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
NOTE:
Requires Amritha's patch:
https://patchwork.ozlabs.org/project/intel-wired-lan/patch/170785373072.3325.9129916579186572531.stgit@anambiarhost.jf.intel.com/
to be applied before this will pass testing cleanly.

Checkpatch warns on no "Closes:" but this was reported on a private
list, so there is nothing to close.

Testing Hints: 'rtcwake -m mem -s 10' should result in a 10 second sleep
and wake, with the interface fully functional afterward. Please also
test that magic packet wake can be enabled on an adapter that supports
it, and that the magic packet wakes the system.
---
 drivers/net/ethernet/intel/ice/ice_main.c | 179 +++-------------------
 1 file changed, 25 insertions(+), 154 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index dd4a9bc0dfdc..2a16b4475d29 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5385,84 +5385,15 @@ static void ice_shutdown(struct pci_dev *pdev)
 	}
 }
 
-#ifdef CONFIG_PM
-/**
- * ice_prepare_for_shutdown - prep for PCI shutdown
- * @pf: board private structure
- *
- * Inform or close all dependent features in prep for PCI device shutdown
- */
-static void ice_prepare_for_shutdown(struct ice_pf *pf)
-{
-	struct ice_hw *hw = &pf->hw;
-	u32 v;
-
-	/* Notify VFs of impending reset */
-	if (ice_check_sq_alive(hw, &hw->mailboxq))
-		ice_vc_notify_reset(pf);
-
-	dev_dbg(ice_pf_to_dev(pf), "Tearing down internal switch for shutdown\n");
-
-	/* disable the VSIs and their queues that are not already DOWN */
-	ice_pf_dis_all_vsi(pf, false);
-
-	ice_for_each_vsi(pf, v)
-		if (pf->vsi[v])
-			pf->vsi[v]->vsi_num = 0;
-
-	ice_shutdown_all_ctrlq(hw);
-}
-
-/**
- * ice_reinit_interrupt_scheme - Reinitialize interrupt scheme
- * @pf: board private structure to reinitialize
- *
- * This routine reinitialize interrupt scheme that was cleared during
- * power management suspend callback.
- *
- * This should be called during resume routine to re-allocate the q_vectors
- * and reacquire interrupts.
- */
-static int ice_reinit_interrupt_scheme(struct ice_pf *pf)
+static int ice_quiesce_before_reset(struct ice_pf *pf)
 {
-	struct device *dev = ice_pf_to_dev(pf);
-	int ret, v;
-
-	/* Since we clear MSIX flag during suspend, we need to
-	 * set it back during resume...
-	 */
-
-	ret = ice_init_interrupt_scheme(pf);
-	if (ret) {
-		dev_err(dev, "Failed to re-initialize interrupt %d\n", ret);
-		return ret;
-	}
-
-	/* Remap vectors and rings, after successful re-init interrupts */
-	ice_for_each_vsi(pf, v) {
-		if (!pf->vsi[v])
-			continue;
+	int ret = ice_service_task_stop(pf);
 
-		ret = ice_vsi_alloc_q_vectors(pf->vsi[v]);
-		if (ret)
-			goto err_reinit;
-		ice_vsi_map_rings_to_vectors(pf->vsi[v]);
-	}
-
-	ret = ice_req_irq_msix_misc(pf);
-	if (ret) {
-		dev_err(dev, "Setting up misc vector failed after device suspend %d\n",
-			ret);
-		goto err_reinit;
+	if (!test_bit(ICE_PREPARED_FOR_RESET, pf->state)) {
+		set_bit(ICE_PFR_REQ, pf->state);
+		ice_prepare_for_reset(pf, ICE_RESET_PFR);
 	}
 
-	return 0;
-
-err_reinit:
-	while (v--)
-		if (pf->vsi[v])
-			ice_vsi_free_q_vectors(pf->vsi[v]);
-
 	return ret;
 }
 
@@ -5473,66 +5404,29 @@ static int ice_reinit_interrupt_scheme(struct ice_pf *pf)
  * Power Management callback to quiesce the device and prepare
  * for D3 transition.
  */
-static int __maybe_unused ice_suspend(struct device *dev)
+static int ice_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct ice_pf *pf;
-	int disabled, v;
 
 	pf = pci_get_drvdata(pdev);
 
 	if (!ice_pf_state_is_nominal(pf)) {
-		dev_err(dev, "Device is not ready, no need to suspend it\n");
+		dev_err(dev, "Device is not ready for suspend.\n");
 		return -EBUSY;
 	}
 
-	/* Stop watchdog tasks until resume completion.
-	 * Even though it is most likely that the service task is
-	 * disabled if the device is suspended or down, the service task's
-	 * state is controlled by a different state bit, and we should
-	 * store and honor whatever state that bit is in at this point.
-	 */
-	disabled = ice_service_task_stop(pf);
-
-	ice_unplug_aux_dev(pf);
-
-	/* Already suspended?, then there is nothing to do */
-	if (test_and_set_bit(ICE_SUSPENDED, pf->state)) {
-		if (!disabled)
-			ice_service_task_restart(pf);
-		return 0;
-	}
-
-	if (test_bit(ICE_DOWN, pf->state) ||
-	    ice_is_reset_in_progress(pf->state)) {
-		dev_err(dev, "can't suspend device in reset or already down\n");
-		if (!disabled)
-			ice_service_task_restart(pf);
-		return 0;
-	}
+	/* Stop watchdog tasks until resume completion */
+	ice_quiesce_before_reset(pf);
+	set_bit(ICE_SUSPENDED, pf->state);
 
 	ice_setup_mc_magic_wake(pf);
-
-	ice_prepare_for_shutdown(pf);
-
 	ice_set_wake(pf);
 
-	/* Free vectors, clear the interrupt scheme and release IRQs
-	 * for proper hibernation, especially with large number of CPUs.
-	 * Otherwise hibernation might fail when mapping all the vectors back
-	 * to CPU0.
-	 */
-	ice_free_irq_msix_misc(pf);
-	ice_for_each_vsi(pf, v) {
-		if (!pf->vsi[v])
-			continue;
-		ice_vsi_free_q_vectors(pf->vsi[v]);
-	}
-	ice_clear_interrupt_scheme(pf);
-
 	pci_save_state(pdev);
 	pci_wake_from_d3(pdev, pf->wol_ena);
 	pci_set_power_state(pdev, PCI_D3hot);
+
 	return 0;
 }
 
@@ -5540,10 +5434,9 @@ static int __maybe_unused ice_suspend(struct device *dev)
  * ice_resume - PM callback for waking up from D3
  * @dev: generic device information structure
  */
-static int __maybe_unused ice_resume(struct device *dev)
+static int ice_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	enum ice_reset_req reset_type;
 	struct ice_pf *pf;
 	struct ice_hw *hw;
 	int ret;
@@ -5566,32 +5459,24 @@ static int __maybe_unused ice_resume(struct device *dev)
 
 	pf->wakeup_reason = rd32(hw, PFPM_WUS);
 	ice_print_wake_reason(pf);
-
-	/* We cleared the interrupt scheme when we suspended, so we need to
-	 * restore it now to resume device functionality.
-	 */
-	ret = ice_reinit_interrupt_scheme(pf);
-	if (ret)
-		dev_err(dev, "Cannot restore interrupt scheme: %d\n", ret);
+	pci_wake_from_d3(pdev, false);
 
 	clear_bit(ICE_DOWN, pf->state);
-	/* Now perform PF reset and rebuild */
-	reset_type = ICE_RESET_PFR;
-	/* re-enable service task for reset, but allow reset to schedule it */
 	clear_bit(ICE_SERVICE_DIS, pf->state);
+	clear_bit(ICE_SUSPENDED, pf->state);
 
-	if (ice_schedule_reset(pf, reset_type))
-		dev_err(dev, "Reset during resume failed.\n");
+	/* force a reset, but it may already have been scheduled in
+	 * ice_suspend, but either way the reset will execute
+	 * once the service task is restarted
+	 */
+	ice_schedule_reset(pf, ICE_RESET_PFR);
 
-	clear_bit(ICE_SUSPENDED, pf->state);
 	ice_service_task_restart(pf);
-
 	/* Restart the service task */
 	mod_timer(&pf->serv_tmr, round_jiffies(jiffies + pf->serv_tmr_period));
 
 	return 0;
 }
-#endif /* CONFIG_PM */
 
 /**
  * ice_pci_err_detected - warning that PCI error has been detected
@@ -5612,14 +5497,8 @@ ice_pci_err_detected(struct pci_dev *pdev, pci_channel_state_t err)
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
-	if (!test_bit(ICE_SUSPENDED, pf->state)) {
-		ice_service_task_stop(pf);
-
-		if (!test_bit(ICE_PREPARED_FOR_RESET, pf->state)) {
-			set_bit(ICE_PFR_REQ, pf->state);
-			ice_prepare_for_reset(pf, ICE_RESET_PFR);
-		}
-	}
+	if (!test_bit(ICE_SUSPENDED, pf->state))
+		ice_quiesce_before_reset(pf);
 
 	return PCI_ERS_RESULT_NEED_RESET;
 }
@@ -5698,14 +5577,8 @@ static void ice_pci_err_reset_prepare(struct pci_dev *pdev)
 {
 	struct ice_pf *pf = pci_get_drvdata(pdev);
 
-	if (!test_bit(ICE_SUSPENDED, pf->state)) {
-		ice_service_task_stop(pf);
-
-		if (!test_bit(ICE_PREPARED_FOR_RESET, pf->state)) {
-			set_bit(ICE_PFR_REQ, pf->state);
-			ice_prepare_for_reset(pf, ICE_RESET_PFR);
-		}
-	}
+	if (!test_bit(ICE_SUSPENDED, pf->state))
+		ice_quiesce_before_reset(pf);
 }
 
 /**
@@ -5761,7 +5634,7 @@ static const struct pci_device_id ice_pci_tbl[] = {
 };
 MODULE_DEVICE_TABLE(pci, ice_pci_tbl);
 
-static __maybe_unused SIMPLE_DEV_PM_OPS(ice_pm_ops, ice_suspend, ice_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(ice_pm_ops, ice_suspend, ice_resume);
 
 static const struct pci_error_handlers ice_pci_err_handler = {
 	.error_detected = ice_pci_err_detected,
@@ -5776,9 +5649,7 @@ static struct pci_driver ice_driver = {
 	.id_table = ice_pci_tbl,
 	.probe = ice_probe,
 	.remove = ice_remove,
-#ifdef CONFIG_PM
-	.driver.pm = &ice_pm_ops,
-#endif /* CONFIG_PM */
+	.driver.pm = pm_sleep_ptr(&ice_pm_ops),
 	.shutdown = ice_shutdown,
 	.sriov_configure = ice_sriov_configure,
 	.sriov_get_vf_total_msix = ice_sriov_get_vf_total_msix,

base-commit: 23f9c2c066e7e5052406fb8f04a115d3d0260b22
-- 
2.39.3


