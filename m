Return-Path: <netdev+bounces-166248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEA8A352E9
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 01:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A6CF7A2F72
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 00:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6BF17E;
	Fri, 14 Feb 2025 00:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bJnX2EZd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB8A5227
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 00:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739493070; cv=none; b=uOQc8H1wlBR4WWQsv8W+QJdslOnaL+oiwS3ItMgJGRXkNJM1+SuC0LXtwbhU8eqrzn75Q3m8eqoo+Wbdwtczh0AudlaMJw4+31TIYbJx8QkiDJM8BYI18Z5JuyrHCj04VVGpIdvHb0/NvouVpHZ/kafzAoTkK3CuOX5TpBZVAHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739493070; c=relaxed/simple;
	bh=LdhfRMMMFoP5d+TjA1KNfYaAzjd0gw6NUfZeCVxznVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sAw0eu17weEM5ncLycVXMsXR0L7/gdXsDbFn5fCtVTZRweGL70CFnudnmeNmxtFUNeSjAuVcykDNZ2RZpWaH2ZGzhsjcBK6J7uao10iYj3pMLkkkOpJFWADHgfkljw8/BptDIpcGm5fW9GkI4wTFlGxMrUrYN6qRJ1+3cOxe6iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bJnX2EZd; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739493067; x=1771029067;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=LdhfRMMMFoP5d+TjA1KNfYaAzjd0gw6NUfZeCVxznVo=;
  b=bJnX2EZdGCNwO1JRDgr556gyNLDYiE0aVVeH1OHLQ7RRRyz/QgVtymjT
   PlVksMIbzwbAYpie+ai0GngTM7DvBnZHiGpUo3C2JQ1CVTkeZ8Vpl1g1c
   tZzjw5LZjNFcl4fWAx9ywQq4Wh4g5FEzt+nwq0lMhoPY1/Fql1yEHet1v
   yVgPLdyWT3hWFE6V7kA9NTykoHV82JgTtJBlHtHV3wqPZM5F1Got56xiB
   x7ZPy4OOzsgbqglG1CKqVcSqGt0crC/nf1jgjo+UY/LOaU+Bd9iCAZE/j
   oAofBJb1MVOWKwbau6nWzdFb4m19c4GE2PIgomOmA++Pl4AucWVDRK2Am
   w==;
X-CSE-ConnectionGUID: RECCXiYFSuWd4NMhr6SJIg==
X-CSE-MsgGUID: oS6lpAMuS42iYbaSdxwPng==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40486769"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="40486769"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 16:31:07 -0800
X-CSE-ConnectionGUID: Aame8dcxREScEMRz4vh7dQ==
X-CSE-MsgGUID: pU/VDK9vQs2Y0ypZGqRLqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="113824194"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 16:31:07 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 13 Feb 2025 16:30:59 -0800
Subject: [PATCH iwl-net v2] iavf: fix circular lock dependency with
 netdev_lock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-jk-iavf-abba-lock-crash-v2-1-033d7bf298f8@intel.com>
X-B4-Tracking: v=1; b=H4sIAMKOrmcC/42Nyw6CMBBFf4V07Zg+5OXK/zAsSjuVEQTTkqoh/
 LuVlTtdntycexYW0BMGdswW5jFSoGlMIHcZM50eLwhkEzPJZc6lUHDtgXR0oNtWwzCZHozXoQP
 FuWtbpTTWNUv23aOj5/Z8ZvQYYMSZNWnoKMyTf23FKLb553kUIKCsSluaIpcWxYnGGYe9mW6f1
 n++PVQ5d4Xmmtsvv1nX9Q2vLUQoBwEAAA==
X-Change-ID: 20250213-jk-iavf-abba-lock-crash-300fbb33ae99
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 netdev <netdev@vger.kernel.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Mailer: b4 0.14.2

We have recently seen reports of lockdep circular lock dependency warnings
when loading the iAVF driver:

[ 1504.790308] ======================================================
[ 1504.790309] WARNING: possible circular locking dependency detected
[ 1504.790310] 6.13.0 #net_next_rt.c2933b2befe2.el9 Not tainted
[ 1504.790311] ------------------------------------------------------
[ 1504.790312] kworker/u128:0/13566 is trying to acquire lock:
[ 1504.790313] ffff97d0e4738f18 (&dev->lock){+.+.}-{4:4}, at: register_netdevice+0x52c/0x710
[ 1504.790320]
[ 1504.790320] but task is already holding lock:
[ 1504.790321] ffff97d0e47392e8 (&adapter->crit_lock){+.+.}-{4:4}, at: iavf_finish_config+0x37/0x240 [iavf]
[ 1504.790330]
[ 1504.790330] which lock already depends on the new lock.
[ 1504.790330]
[ 1504.790330]
[ 1504.790330] the existing dependency chain (in reverse order) is:
[ 1504.790331]
[ 1504.790331] -> #1 (&adapter->crit_lock){+.+.}-{4:4}:
[ 1504.790333]        __lock_acquire+0x52d/0xbb0
[ 1504.790337]        lock_acquire+0xd9/0x330
[ 1504.790338]        mutex_lock_nested+0x4b/0xb0
[ 1504.790341]        iavf_finish_config+0x37/0x240 [iavf]
[ 1504.790347]        process_one_work+0x248/0x6d0
[ 1504.790350]        worker_thread+0x18d/0x330
[ 1504.790352]        kthread+0x10e/0x250
[ 1504.790354]        ret_from_fork+0x30/0x50
[ 1504.790357]        ret_from_fork_asm+0x1a/0x30
[ 1504.790361]
[ 1504.790361] -> #0 (&dev->lock){+.+.}-{4:4}:
[ 1504.790364]        check_prev_add+0xf1/0xce0
[ 1504.790366]        validate_chain+0x46a/0x570
[ 1504.790368]        __lock_acquire+0x52d/0xbb0
[ 1504.790370]        lock_acquire+0xd9/0x330
[ 1504.790371]        mutex_lock_nested+0x4b/0xb0
[ 1504.790372]        register_netdevice+0x52c/0x710
[ 1504.790374]        iavf_finish_config+0xfa/0x240 [iavf]
[ 1504.790379]        process_one_work+0x248/0x6d0
[ 1504.790381]        worker_thread+0x18d/0x330
[ 1504.790383]        kthread+0x10e/0x250
[ 1504.790385]        ret_from_fork+0x30/0x50
[ 1504.790387]        ret_from_fork_asm+0x1a/0x30
[ 1504.790389]
[ 1504.790389] other info that might help us debug this:
[ 1504.790389]
[ 1504.790389]  Possible unsafe locking scenario:
[ 1504.790389]
[ 1504.790390]        CPU0                    CPU1
[ 1504.790391]        ----                    ----
[ 1504.790391]   lock(&adapter->crit_lock);
[ 1504.790393]                                lock(&dev->lock);
[ 1504.790394]                                lock(&adapter->crit_lock);
[ 1504.790395]   lock(&dev->lock);
[ 1504.790397]
[ 1504.790397]  *** DEADLOCK ***

This appears to be caused by the change in commit 5fda3f35349b ("net: make
netdev_lock() protect netdev->reg_state"), which added a netdev_lock() in
register_netdevice.

The iAVF driver calls register_netdevice() from iavf_finish_config(), as a
final stage of its state machine post-probe. It currently takes the RTNL
lock, then the netdev lock, and then the device critical lock. This pattern
is used throughout the driver. Thus there is a strong dependency that the
crit_lock should not be acquired before the net device lock. The change to
register_netdevice creates an ABBA lock order violation because the iAVF
driver is holding the crit_lock while calling register_netdevice, which
then takes the netdev_lock.

It seems likely that future refactors could result in netdev APIs which
hold the netdev_lock while calling into the driver. This means that we
should not re-order the locks so that netdev_lock is acquired after the
device private crit_lock.

Instead, notice that we already release the netdev_lock prior to calling
the register_netdevice. This flow only happens during the early driver
initialization as we transition through the __IAVF_STARTUP,
__IAVF_INIT_VERSION_CHECK, __IAVF_INIT_GET_RESOURCES, etc.

Analyzing the places where we take crit_lock in the driver there are two
sources:

a) several of the work queue tasks including adminq_task, watchdog_task,
reset_task, and the finish_config task.

b) various callbacks which ultimately stem back to .ndo operations or
ethtool operations.

The latter cannot be triggered until after the netdevice registration is
completed successfully.

The iAVF driver uses alloc_ordered_workqueue, which is an unbound workqueue
that has a max limit of 1, and thus guarantees that only a single work item
on the queue is executing at any given time, so none of the other work
threads could be executing due to the ordered workqueue guarantees.

The iavf_finish_config() function also does not do anything else after
register_netdevice, unless it fails. It seems unlikely that the driver
private crit_lock is protecting anything that register_netdevice() itself
touches.

Thus, to fix this ABBA lock violation, lets simply release the
adapter->crit_lock as well as netdev_lock prior to calling
register_netdevice(). We do still keep holding the RTNL lock as required by
the function. If we do fail to register the netdevice, then we re-acquire
the adapter critical lock to finish the transition back to
__IAVF_INIT_CONFIG_ADAPTER.

This ensures every call where both netdev_lock and the adapter->crit_lock
are acquired under the same ordering.

Fixes: afc664987ab3 ("eth: iavf: extend the netdev_lock usage")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
Changes in v2:
- Add Intel Wired LAN for patchwork integration
- Link to v1: https://lore.kernel.org/r/20250213-jk-iavf-abba-lock-crash-v1-1-d4850f6a0a0d@intel.com
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 852e5b62f0a5dc038c0e5c0f76541870e69384ac..6faa62bced3a2ccb935219ba0726275c8ae60365 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1983,7 +1983,7 @@ static int iavf_reinit_interrupt_scheme(struct iavf_adapter *adapter, bool runni
 static void iavf_finish_config(struct work_struct *work)
 {
 	struct iavf_adapter *adapter;
-	bool netdev_released = false;
+	bool locks_released = false;
 	int pairs, err;
 
 	adapter = container_of(work, struct iavf_adapter, finish_config);
@@ -2012,19 +2012,22 @@ static void iavf_finish_config(struct work_struct *work)
 		netif_set_real_num_tx_queues(adapter->netdev, pairs);
 
 		if (adapter->netdev->reg_state != NETREG_REGISTERED) {
+			mutex_unlock(&adapter->crit_lock);
 			netdev_unlock(adapter->netdev);
-			netdev_released = true;
+			locks_released = true;
 			err = register_netdevice(adapter->netdev);
 			if (err) {
 				dev_err(&adapter->pdev->dev, "Unable to register netdev (%d)\n",
 					err);
 
 				/* go back and try again.*/
+				mutex_lock(&adapter->crit_lock);
 				iavf_free_rss(adapter);
 				iavf_free_misc_irq(adapter);
 				iavf_reset_interrupt_capability(adapter);
 				iavf_change_state(adapter,
 						  __IAVF_INIT_CONFIG_ADAPTER);
+				mutex_unlock(&adapter->crit_lock);
 				goto out;
 			}
 		}
@@ -2040,9 +2043,10 @@ static void iavf_finish_config(struct work_struct *work)
 	}
 
 out:
-	mutex_unlock(&adapter->crit_lock);
-	if (!netdev_released)
+	if (!locks_released) {
+		mutex_unlock(&adapter->crit_lock);
 		netdev_unlock(adapter->netdev);
+	}
 	rtnl_unlock();
 }
 

---
base-commit: 348f968b89bfeec0bb53dd82dba58b94d97fbd34
change-id: 20250213-jk-iavf-abba-lock-crash-300fbb33ae99

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


