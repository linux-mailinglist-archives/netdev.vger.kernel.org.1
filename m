Return-Path: <netdev+bounces-266330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CI6yNNSFsGk5kQIAu9opvQ
	(envelope-from <netdev+bounces-266330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:57:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DA42580F2
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5209C3180AD1
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 20:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86B43B9619;
	Tue, 10 Mar 2026 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C8bH+bd7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F013B4E80
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 20:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773176227; cv=none; b=ZQ4ErVR1R7CGaxt5aMzdt47YatnvmtzBZxkWbwd92grziEDHMg5rAwV5Y3C5CquRB0s3/X00RtoFNJSfR7pJvaxL7PZv6OnjbvkmTVsS8WBtrvCJy6ibSczcbtwQ5i7CC5edoaMRr18nos49dMH+mbJvHKLvfNqeJ4sqPu4BtlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773176227; c=relaxed/simple;
	bh=MdprQbL6wSBvHDqyCxRJqEHirmch5REJel5/IjKbMQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhODZheNKP7Sp7x5wqTUVDIPALmzmDMbi4RykeEWIve81aSfPvB/5xaaCB4XqDKuNRdJOXRfrrzkms7Xqgj6eC85jIZukWhYct4R8bTVO9EWPUhr2MfUx592WgRU4YqSp773124k2EVaj99v1MAl3y9XATC3GExoRyz7PT7IArg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C8bH+bd7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773176225; x=1804712225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MdprQbL6wSBvHDqyCxRJqEHirmch5REJel5/IjKbMQY=;
  b=C8bH+bd7J9PTl8tQnPBlIiDFgrvUx63ZTNfsCphWpjt5EUyFdpqtxud6
   mvPg7AMWJihkMEPTp+7gvyxD/YWz2mckNpvGx84Y9f/TcTFWzTw+o7Efp
   r5yXyZV3i2UiaJiWP7P4iQwL9+2zRsc7I8xdQGNQ/ZJqY1ukJjWUVcD+5
   hVo4dL2nnx15adRzRBTbmFLybVIy1zMCIyvtp/73ijwSG5RmcEhS249GD
   3idfXhx9i4O9g1Bj9bQVydDsj1c6l9bb0QW1Fr3PpeQm/QxrCKciQ9Evk
   BUWrZBpN/9Fy8YAGNzBs+fa5DH8MT0fbDtAMm4FUV2gdmBWtjcjAnblCc
   w==;
X-CSE-ConnectionGUID: OjYYfEqjTAyV43mEIg7c+A==
X-CSE-MsgGUID: hZpKrzmZRT6KrVPt7xhkTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="85326077"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="85326077"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 13:57:01 -0700
X-CSE-ConnectionGUID: N4abdRVXSoql7A9fT6Bvug==
X-CSE-MsgGUID: dLbpLKa8QeqOMmnKOgq+bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="258162880"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 10 Mar 2026 13:57:00 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	ivecera@redhat.com,
	shaojijie@huawei.com,
	sdf@fomichev.me,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 3/5] iavf: fix incorrect reset handling in callbacks
Date: Tue, 10 Mar 2026 13:56:51 -0700
Message-ID: <20260310205654.4109072-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260310205654.4109072-1-anthony.l.nguyen@intel.com>
References: <20260310205654.4109072-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 50DA42580F2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266330-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action

From: Petr Oros <poros@redhat.com>

Three driver callbacks schedule a reset and wait for its completion:
ndo_change_mtu(), ethtool set_ringparam(), and ethtool set_channels().

Waiting for reset in ndo_change_mtu() and set_ringparam() was added by
commit c2ed2403f12c ("iavf: Wait for reset in callbacks which trigger
it") to fix a race condition where adding an interface to bonding
immediately after MTU or ring parameter change failed because the
interface was still in __RESETTING state. The same commit also added
waiting in iavf_set_priv_flags(), which was later removed by commit
53844673d555 ("iavf: kill "legacy-rx" for good").

Waiting in set_channels() was introduced earlier by commit 4e5e6b5d9d13
("iavf: Fix return of set the new channel count") to ensure the PF has
enough time to complete the VF reset when changing channel count, and to
return correct error codes to userspace.

Commit ef490bbb2267 ("iavf: Add net_shaper_ops support") added
net_shaper_ops to iavf, which required reset_task to use _locked NAPI
variants (napi_enable_locked, napi_disable_locked) that need the netdev
instance lock.

Later, commit 7e4d784f5810 ("net: hold netdev instance lock during
rtnetlink operations") and commit 2bcf4772e45a ("net: ethtool: try to
protect all callback with netdev instance lock") started holding the
netdev instance lock during ndo and ethtool callbacks for drivers with
net_shaper_ops.

Finally, commit 120f28a6f314 ("iavf: get rid of the crit lock")
replaced the driver's crit_lock with netdev_lock in reset_task, causing
incorrect behavior: the callback holds netdev_lock and waits for
reset_task, but reset_task needs the same lock:

  Thread 1 (callback)               Thread 2 (reset_task)
  -------------------               ---------------------
  netdev_lock()                     [blocked on workqueue]
  ndo_change_mtu() or ethtool op
    iavf_schedule_reset()
    iavf_wait_for_reset()           iavf_reset_task()
      waiting...                      netdev_lock() <- blocked

This does not strictly deadlock because iavf_wait_for_reset() uses
wait_event_interruptible_timeout() with a 5-second timeout. The wait
eventually times out, the callback returns an error to userspace, and
after the lock is released reset_task completes the reset. This leads to
incorrect behavior: userspace sees an error even though the configuration
change silently takes effect after the timeout.

Fix this by extracting the reset logic from iavf_reset_task() into a new
iavf_reset_step() function that expects netdev_lock to be already held.
The three callbacks now call iavf_reset_step() directly instead of
scheduling the work and waiting, performing the reset synchronously in
the caller's context which already holds netdev_lock. This eliminates
both the incorrect error reporting and the need for
iavf_wait_for_reset(), which is removed along with the now-unused
reset_waitqueue.

The workqueue-based iavf_reset_task() becomes a thin wrapper that
acquires netdev_lock and calls iavf_reset_step(), preserving its use
for PF-initiated resets.

The callbacks may block for several seconds while iavf_reset_step()
polls hardware registers, but this is acceptable since netdev_lock is a
per-device mutex and only serializes operations on the same interface.

v3:
- Remove netif_running() guard from iavf_set_channels(). Unlike
  set_ringparam where descriptor counts are picked up by iavf_open()
  directly, num_req_queues is only consumed during
  iavf_reinit_interrupt_scheme() in the reset path. Skipping the reset
  on a down device would silently discard the channel count change.
- Remove dead reset_waitqueue code (struct field, init, and all
  wake_up calls) since iavf_wait_for_reset() was the only consumer.

Fixes: 120f28a6f314 ("iavf: get rid of the crit lock")
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h        |  3 +-
 .../net/ethernet/intel/iavf/iavf_ethtool.c    | 19 ++---
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 77 ++++++-------------
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  1 -
 4 files changed, 31 insertions(+), 69 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index a87e0c6d4017..e9fb0a0919e3 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -260,7 +260,6 @@ struct iavf_adapter {
 	struct work_struct adminq_task;
 	struct work_struct finish_config;
 	wait_queue_head_t down_waitqueue;
-	wait_queue_head_t reset_waitqueue;
 	wait_queue_head_t vc_waitqueue;
 	struct iavf_q_vector *q_vectors;
 	struct list_head vlan_filter_list;
@@ -626,5 +625,5 @@ void iavf_add_adv_rss_cfg(struct iavf_adapter *adapter);
 void iavf_del_adv_rss_cfg(struct iavf_adapter *adapter);
 struct iavf_mac_filter *iavf_add_filter(struct iavf_adapter *adapter,
 					const u8 *macaddr);
-int iavf_wait_for_reset(struct iavf_adapter *adapter);
+void iavf_reset_step(struct iavf_adapter *adapter);
 #endif /* _IAVF_H_ */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index f3a1b2fb9bf8..ab67c709d5a0 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -492,7 +492,6 @@ static int iavf_set_ringparam(struct net_device *netdev,
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	u32 new_rx_count, new_tx_count;
-	int ret = 0;
 
 	if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
 		return -EINVAL;
@@ -537,13 +536,11 @@ static int iavf_set_ringparam(struct net_device *netdev,
 	}
 
 	if (netif_running(netdev)) {
-		iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
-		ret = iavf_wait_for_reset(adapter);
-		if (ret)
-			netdev_warn(netdev, "Changing ring parameters timeout or interrupted waiting for reset");
+		adapter->flags |= IAVF_FLAG_RESET_NEEDED;
+		iavf_reset_step(adapter);
 	}
 
-	return ret;
+	return 0;
 }
 
 /**
@@ -1723,7 +1720,6 @@ static int iavf_set_channels(struct net_device *netdev,
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	u32 num_req = ch->combined_count;
-	int ret = 0;
 
 	if ((adapter->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_ADQ) &&
 	    adapter->num_tc) {
@@ -1745,13 +1741,10 @@ static int iavf_set_channels(struct net_device *netdev,
 
 	adapter->num_req_queues = num_req;
 	adapter->flags |= IAVF_FLAG_REINIT_ITR_NEEDED;
-	iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
+	adapter->flags |= IAVF_FLAG_RESET_NEEDED;
+	iavf_reset_step(adapter);
 
-	ret = iavf_wait_for_reset(adapter);
-	if (ret)
-		netdev_warn(netdev, "Changing channel count timeout or interrupted waiting for reset");
-
-	return ret;
+	return 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index c7abd3331e03..7925ee152c76 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -185,31 +185,6 @@ static bool iavf_is_reset_in_progress(struct iavf_adapter *adapter)
 	return false;
 }
 
-/**
- * iavf_wait_for_reset - Wait for reset to finish.
- * @adapter: board private structure
- *
- * Returns 0 if reset finished successfully, negative on timeout or interrupt.
- */
-int iavf_wait_for_reset(struct iavf_adapter *adapter)
-{
-	int ret = wait_event_interruptible_timeout(adapter->reset_waitqueue,
-					!iavf_is_reset_in_progress(adapter),
-					msecs_to_jiffies(5000));
-
-	/* If ret < 0 then it means wait was interrupted.
-	 * If ret == 0 then it means we got a timeout while waiting
-	 * for reset to finish.
-	 * If ret > 0 it means reset has finished.
-	 */
-	if (ret > 0)
-		return 0;
-	else if (ret < 0)
-		return -EINTR;
-	else
-		return -EBUSY;
-}
-
 /**
  * iavf_allocate_dma_mem_d - OS specific memory alloc for shared code
  * @hw:   pointer to the HW structure
@@ -3113,18 +3088,16 @@ static void iavf_reconfig_qs_bw(struct iavf_adapter *adapter)
 }
 
 /**
- * iavf_reset_task - Call-back task to handle hardware reset
- * @work: pointer to work_struct
+ * iavf_reset_step - Perform the VF reset sequence
+ * @adapter: board private structure
  *
- * During reset we need to shut down and reinitialize the admin queue
- * before we can use it to communicate with the PF again. We also clear
- * and reinit the rings because that context is lost as well.
- **/
-static void iavf_reset_task(struct work_struct *work)
+ * Requests a reset from PF, polls for completion, and reconfigures
+ * the driver. Caller must hold the netdev instance lock.
+ *
+ * This can sleep for several seconds while polling HW registers.
+ */
+void iavf_reset_step(struct iavf_adapter *adapter)
 {
-	struct iavf_adapter *adapter = container_of(work,
-						      struct iavf_adapter,
-						      reset_task);
 	struct virtchnl_vf_resource *vfres = adapter->vf_res;
 	struct net_device *netdev = adapter->netdev;
 	struct iavf_hw *hw = &adapter->hw;
@@ -3135,7 +3108,7 @@ static void iavf_reset_task(struct work_struct *work)
 	int i = 0, err;
 	bool running;
 
-	netdev_lock(netdev);
+	netdev_assert_locked(netdev);
 
 	iavf_misc_irq_disable(adapter);
 	if (adapter->flags & IAVF_FLAG_RESET_NEEDED) {
@@ -3180,7 +3153,6 @@ static void iavf_reset_task(struct work_struct *work)
 		dev_err(&adapter->pdev->dev, "Reset never finished (%x)\n",
 			reg_val);
 		iavf_disable_vf(adapter);
-		netdev_unlock(netdev);
 		return; /* Do not attempt to reinit. It's dead, Jim. */
 	}
 
@@ -3192,7 +3164,6 @@ static void iavf_reset_task(struct work_struct *work)
 		iavf_startup(adapter);
 		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
 				   msecs_to_jiffies(30));
-		netdev_unlock(netdev);
 		return;
 	}
 
@@ -3335,9 +3306,6 @@ static void iavf_reset_task(struct work_struct *work)
 
 	adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
 
-	wake_up(&adapter->reset_waitqueue);
-	netdev_unlock(netdev);
-
 	return;
 reset_err:
 	if (running) {
@@ -3346,10 +3314,21 @@ static void iavf_reset_task(struct work_struct *work)
 	}
 	iavf_disable_vf(adapter);
 
-	netdev_unlock(netdev);
 	dev_err(&adapter->pdev->dev, "failed to allocate resources during reinit\n");
 }
 
+static void iavf_reset_task(struct work_struct *work)
+{
+	struct iavf_adapter *adapter = container_of(work,
+						      struct iavf_adapter,
+						      reset_task);
+	struct net_device *netdev = adapter->netdev;
+
+	netdev_lock(netdev);
+	iavf_reset_step(adapter);
+	netdev_unlock(netdev);
+}
+
 /**
  * iavf_adminq_task - worker thread to clean the admin queue
  * @work: pointer to work_struct containing our data
@@ -4615,22 +4594,17 @@ static int iavf_close(struct net_device *netdev)
 static int iavf_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
-	int ret = 0;
 
 	netdev_dbg(netdev, "changing MTU from %d to %d\n",
 		   netdev->mtu, new_mtu);
 	WRITE_ONCE(netdev->mtu, new_mtu);
 
 	if (netif_running(netdev)) {
-		iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
-		ret = iavf_wait_for_reset(adapter);
-		if (ret < 0)
-			netdev_warn(netdev, "MTU change interrupted waiting for reset");
-		else if (ret)
-			netdev_warn(netdev, "MTU change timed out waiting for reset");
+		adapter->flags |= IAVF_FLAG_RESET_NEEDED;
+		iavf_reset_step(adapter);
 	}
 
-	return ret;
+	return 0;
 }
 
 /**
@@ -5435,9 +5409,6 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Setup the wait queue for indicating transition to down status */
 	init_waitqueue_head(&adapter->down_waitqueue);
 
-	/* Setup the wait queue for indicating transition to running state */
-	init_waitqueue_head(&adapter->reset_waitqueue);
-
 	/* Setup the wait queue for indicating virtchannel events */
 	init_waitqueue_head(&adapter->vc_waitqueue);
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 88156082a41d..a52c100dcbc5 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -2736,7 +2736,6 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 	case VIRTCHNL_OP_ENABLE_QUEUES:
 		/* enable transmits */
 		iavf_irq_enable(adapter, true);
-		wake_up(&adapter->reset_waitqueue);
 		adapter->flags &= ~IAVF_FLAG_QUEUES_DISABLED;
 		break;
 	case VIRTCHNL_OP_DISABLE_QUEUES:
-- 
2.47.1


