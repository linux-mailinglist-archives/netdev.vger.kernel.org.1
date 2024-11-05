Return-Path: <netdev+bounces-142104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E872C9BD7D6
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 22:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EFF7B2291E
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 21:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805492161FC;
	Tue,  5 Nov 2024 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X8XsUjR7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4625C216427
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 21:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843362; cv=none; b=HErXBB77ntwwzKY8f/XiSFfl9xwjgZiJqnHM3KDt8ZlU80tEH+cozc34yE4tWIN4tF9W9VSXPOAlqnydilabJ8HT1G9gtnDyVhGXkmflDda7B3HeUgDFZxICKORJffuGPFBABwMoWNz2gMYeOsT9eSevyIDO7iPuejvw6n8HQFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843362; c=relaxed/simple;
	bh=fs47b3k7TnzdYnjiKW2cihXESV17iIsj1HH+Y7Az+Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHZADtvydSb3t3BUfx85w86NjGG66GAs/VWC29/srsJI9VPnnV2Am9hpZYbOy8W1jOF4wOz29b6ShvqZquRGJ78VG5QKLvW7tB4YalJjA1qDErDvAR/FqF9eS2SisYQawzEIBpchFOhDVVu1ZD4A1HBa+GqlOWm9aSQCvjIgVsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X8XsUjR7; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730843361; x=1762379361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fs47b3k7TnzdYnjiKW2cihXESV17iIsj1HH+Y7Az+Ng=;
  b=X8XsUjR7vrVwq1KPZUGGy7zU1x+yCYqLpWgjNKtzZbdj0w1ZntrXddYB
   xSlPg3A5r4ikCEj3FB1BVxWYtSdZRYtx98SmcF5oGNVghFb2ZjBbwBesa
   2AHD9abUJ2FCRXrhKybs4BBcLAqJNq8ccCVJYfbs9b8R/KLJKlOWiWEN8
   6tMMGBSWRpZSXWKmq4psQ/24xt+kdFzIWU5FNkNxGMzV3MSjjIN5W+oTu
   QPNEzbeSrPjOip/zkaL9u2MJscSEvdXAZIhndPXEPYIqMq7XBXwjdVXj8
   yNP/u6zHDxZNTEdCXe9RP5sBQtbfyRolNtE4y8fL7xsqnbn5+PY4ipnYE
   g==;
X-CSE-ConnectionGUID: PrWTGTzmSUyj2IyNJpu0Mw==
X-CSE-MsgGUID: wtN99q6TRKm2gnFYa39CFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="30735925"
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="30735925"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 13:49:16 -0800
X-CSE-ConnectionGUID: Wg8QJlc8TxOSOUWkDNs8Dw==
X-CSE-MsgGUID: +hsLn0LgSgeVBVEHzhFFQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="85010419"
Received: from coyotepass-34596-p1.jf.intel.com ([10.166.80.48])
  by orviesa008.jf.intel.com with ESMTP; 05 Nov 2024 13:49:06 -0800
From: Tarun K Singh <tarun.k.singh@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v1 3/4] idpf: Add init, reinit, and deinit control lock
Date: Tue,  5 Nov 2024 13:48:58 -0500
Message-ID: <20241105184859.741473-4-tarun.k.singh@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241105184859.741473-1-tarun.k.singh@intel.com>
References: <20241105184859.741473-1-tarun.k.singh@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new 'vport_init_lock' to prevent locking issue.

The existing 'vport_cfg_lock' was controlling the vport initialization,
re-initialization due to reset, and de-initialization of code flow.
In addition to controlling the above behavior it was also controlling
the parallel netdevice calls such as open/close from Linux OS, which
can happen independent of re-init or de-init of the vport(s). If first
one such as re-init or de-init is going on then the second operation
to config the netdevice with OS should not take place. The first
operation (init or de-init) takes the precedence if both are to happen
simultaneously.

Use of single lock cause deadlock and inconsistent behavior of code
flow. E.g. when driver undergoes reset via 'idpf_init_hard_reset', it
acquires the 'vport_cfg_lock', and during this process it tries to
unregister netdevice which may call 'idpf_stop' which tries to acquire
same lock causing it to deadlock.

To address above, add new lock 'vport_init_lock' which control the
initialization, re-initialization, and de-initialization flow.
The 'vport_cfg_lock' now exclusively controls the vport config
operations.

Add vport config lock around 'idpf_vport_stop()' and 'idpf_vport_open()'
to protect close and open operation at the same time.

Add vport init lock around 'idpf_sriv_configure()' to protect it from
load and removal path. To accomplish it, use existing function
as wrapper and introduce another function 'idpf_sriov_config_vfs'
which is used inside the lock.

In idpf_remove, change 'idpf_sriov_configure' to
'idpf_sriov_config_vfs', and move inside the init lock.

Use these two locks in the following precedence:
'vport_init_lock' first, then 'vport_cfg_lock'.

Fixes: 8077c727561a ("idpf: add controlq init and reset checks")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Tarun K Singh <tarun.k.singh@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h      | 25 +++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_lib.c  | 41 ++++++++++++++++++---
 drivers/net/ethernet/intel/idpf/idpf_main.c |  7 +++-
 3 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 8dea2dd784af..34dbdc7d6c88 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -526,6 +526,7 @@ struct idpf_vc_xn_manager;
  * @crc_enable: Enable CRC insertion offload
  * @req_tx_splitq: TX split or single queue model to request
  * @req_rx_splitq: RX split or single queue model to request
+ * @vport_init_lock: Lock to protect vport init, re-init, and deinit flow
  * @vport_cfg_lock: Lock to protect the vport config flow
  * @vector_lock: Lock to protect vector distribution
  * @queue_lock: Lock to protect queue distribution
@@ -583,6 +584,7 @@ struct idpf_adapter {
 	bool req_tx_splitq;
 	bool req_rx_splitq;
 
+	struct mutex vport_init_lock;
 	struct mutex vport_cfg_lock;
 	struct mutex vector_lock;
 	struct mutex queue_lock;
@@ -786,6 +788,28 @@ static inline u16 idpf_get_max_tx_hdr_size(struct idpf_adapter *adapter)
 	return le16_to_cpu(adapter->caps.max_tx_hdr_size);
 }
 
+/**
+ * idpf_vport_init_lock -acquire init/deinit control lock
+ * @adapter: private data struct
+ *
+ * It controls and protect vport initialization, re-initialization,
+ * and deinitialization code flow and its resources. This
+ * lock is only used by non-datapath code.
+ */
+static inline void idpf_vport_init_lock(struct idpf_adapter *adapter)
+{
+	mutex_lock(&adapter->vport_init_lock);
+}
+
+/**
+ * idpf_vport_init_unlock - release vport init lock
+ * @adapter: private data struct
+ */
+static inline void idpf_vport_init_unlock(struct idpf_adapter *adapter)
+{
+	mutex_unlock(&adapter->vport_init_lock);
+}
+
 /**
  * idpf_vport_cfg_lock - Acquire the vport config lock
  * @adapter: private data struct
@@ -827,6 +851,7 @@ void idpf_set_ethtool_ops(struct net_device *netdev);
 void idpf_vport_intr_write_itr(struct idpf_q_vector *q_vector,
 			       u16 itr, bool tx);
 int idpf_sriov_configure(struct pci_dev *pdev, int num_vfs);
+int idpf_sriov_config_vfs(struct pci_dev *pdev, int num_vfs);
 
 u8 idpf_vport_get_hsplit(const struct idpf_vport *vport);
 bool idpf_vport_set_hsplit(const struct idpf_vport *vport, u8 val);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 778dc71fbf4a..931d0f988c95 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1000,7 +1000,10 @@ static void idpf_vport_dealloc(struct idpf_vport *vport)
 	unsigned int i = vport->idx;
 
 	idpf_deinit_mac_addr(vport);
+
+	idpf_vport_cfg_lock(adapter);
 	idpf_vport_stop(vport);
+	idpf_vport_cfg_unlock(adapter);
 
 	if (!test_bit(IDPF_HR_RESET_IN_PROG, adapter->flags))
 		idpf_decfg_netdev(vport);
@@ -1522,8 +1525,11 @@ void idpf_init_task(struct work_struct *work)
 	/* Once state is put into DOWN, driver is ready for dev_open */
 	np = netdev_priv(vport->netdev);
 	np->state = __IDPF_VPORT_DOWN;
-	if (test_and_clear_bit(IDPF_VPORT_UP_REQUESTED, vport_config->flags))
+	if (test_and_clear_bit(IDPF_VPORT_UP_REQUESTED, vport_config->flags)) {
+		idpf_vport_cfg_lock(adapter);
 		idpf_vport_open(vport);
+		idpf_vport_cfg_unlock(adapter);
+	}
 
 	/* Spawn and return 'idpf_init_task' work queue until all the
 	 * default vports are created
@@ -1601,17 +1607,19 @@ static int idpf_sriov_ena(struct idpf_adapter *adapter, int num_vfs)
 }
 
 /**
- * idpf_sriov_configure - Configure the requested VFs
+ * idpf_sriov_config_vfs - Configure the requested VFs
  * @pdev: pointer to a pci_dev structure
  * @num_vfs: number of vfs to allocate
  *
  * Enable or change the number of VFs. Called when the user updates the number
  * of VFs in sysfs.
  **/
-int idpf_sriov_configure(struct pci_dev *pdev, int num_vfs)
+int idpf_sriov_config_vfs(struct pci_dev *pdev, int num_vfs)
 {
 	struct idpf_adapter *adapter = pci_get_drvdata(pdev);
 
+	lockdep_assert_held(&adapter->vport_init_lock);
+
 	if (!idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS, VIRTCHNL2_CAP_SRIOV)) {
 		dev_info(&pdev->dev, "SR-IOV is not supported on this device\n");
 
@@ -1634,6 +1642,26 @@ int idpf_sriov_configure(struct pci_dev *pdev, int num_vfs)
 	return 0;
 }
 
+/**
+ * idpf_sriov_configure - Call idpf_sriov_config_vfs to configure
+ * @pdev: pointer to a pci_dev structure
+ * @num_vfs: number of vfs to allocate
+ *
+ * Enable or change the number of VFs. Called when the user updates the number
+ * of VFs in sysfs.
+ **/
+int idpf_sriov_configure(struct pci_dev *pdev, int num_vfs)
+{
+	struct idpf_adapter *adapter = pci_get_drvdata(pdev);
+	int ret;
+
+	idpf_vport_init_lock(adapter);
+	ret = idpf_sriov_config_vfs(pdev, num_vfs);
+	idpf_vport_init_unlock(adapter);
+
+	return ret;
+}
+
 /**
  * idpf_deinit_task - Device deinit routine
  * @adapter: Driver specific private structure
@@ -1733,7 +1761,7 @@ static int idpf_init_hard_reset(struct idpf_adapter *adapter)
 	int err;
 	u16 i;
 
-	mutex_lock(&adapter->vport_cfg_lock);
+	idpf_vport_init_lock(adapter);
 
 	dev_info(dev, "Device HW Reset initiated\n");
 
@@ -1798,7 +1826,7 @@ static int idpf_init_hard_reset(struct idpf_adapter *adapter)
 		msleep(100);
 
 unlock_mutex:
-	mutex_unlock(&adapter->vport_cfg_lock);
+	idpf_vport_init_unlock(adapter);
 
 	return err;
 }
@@ -2155,6 +2183,9 @@ static int idpf_open(struct net_device *netdev)
 	struct idpf_vport *vport;
 	int err;
 
+	if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
+		return 0;
+
 	idpf_vport_cfg_lock(adapter);
 	vport = idpf_netdev_to_vport(netdev);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 0522b3a6f42c..04bbc048c829 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -28,10 +28,13 @@ static void idpf_remove(struct pci_dev *pdev)
 	 * end up in bad state.
 	 */
 	cancel_delayed_work_sync(&adapter->vc_event_task);
+
+	idpf_vport_init_lock(adapter);
 	if (adapter->num_vfs)
-		idpf_sriov_configure(pdev, 0);
+		idpf_sriov_config_vfs(pdev, 0);
 
 	idpf_vc_core_deinit(adapter);
+	idpf_vport_init_unlock(adapter);
 
 	/* Be a good citizen and leave the device clean on exit */
 	adapter->dev_ops.reg_ops.trigger_reset(adapter, IDPF_HR_FUNC_RESET);
@@ -72,6 +75,7 @@ static void idpf_remove(struct pci_dev *pdev)
 	kfree(adapter->vcxn_mngr);
 	adapter->vcxn_mngr = NULL;
 
+	mutex_destroy(&adapter->vport_init_lock);
 	mutex_destroy(&adapter->vport_cfg_lock);
 	mutex_destroy(&adapter->vector_lock);
 	mutex_destroy(&adapter->queue_lock);
@@ -229,6 +233,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_cfg_hw;
 	}
 
+	mutex_init(&adapter->vport_init_lock);
 	mutex_init(&adapter->vport_cfg_lock);
 	mutex_init(&adapter->vector_lock);
 	mutex_init(&adapter->queue_lock);
-- 
2.46.0


