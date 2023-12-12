Return-Path: <netdev+bounces-56589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F61280F7FD
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 21:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEC53B20F41
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 20:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBB364129;
	Tue, 12 Dec 2023 20:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KBJz5KRT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64598BD
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 12:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702413382; x=1733949382;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ws0sqRTAwKSfM+yFT7+KFhYb9i40f8BjVoNLgKCocyk=;
  b=KBJz5KRTKqiNI8L4oQiJU9xoi24CGjwwgvbWrZlPWT66ULDOI5h4e8q0
   Zj99GL5zOxSiGl2TPEa9V5Hx+rbYfzyTrFjlcrBE2reciuD7YPrkkAGah
   MdoQbfOgPMDO+UNTQva0vju+d9pip7WfAKiOufR7MWVMy27YIEbth38ba
   +Qr/gkj0GuKDXy/GhzgU7msLHWMkaUzcILNWn1pYCQHiismHeuKGTvEyQ
   yQ4tIXtKYhyuAbJJcCOhTcHbmDfLpmGUmpDfsXxktZmY82+8Ymp50D3pc
   7Qj0/Uac6+EX4XKxBr+hrDTrRW50vDisu+2bzmId2uHmXapMkMLeQd98C
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="16418350"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="16418350"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 12:36:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="839577725"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="839577725"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga008.fm.intel.com with ESMTP; 12 Dec 2023 12:36:20 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Slawomir Laba <slawomirx.laba@intel.com>,
	anthony.l.nguyen@intel.com,
	madhu.chittim@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Ranganatha Rao <ranganatha.rao@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 3/3] iavf: Fix iavf_shutdown to call iavf_remove instead iavf_close
Date: Tue, 12 Dec 2023 12:36:09 -0800
Message-ID: <20231212203613.513423-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212203613.513423-1-anthony.l.nguyen@intel.com>
References: <20231212203613.513423-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Slawomir Laba <slawomirx.laba@intel.com>

Make the flow for pci shutdown be the same to the pci remove.

iavf_shutdown was implementing an incomplete version
of iavf_remove. It misses several calls to the kernel like
iavf_free_misc_irq, iavf_reset_interrupt_capability, iounmap
that might break the system on reboot or hibernation.

Implement the call of iavf_remove directly in iavf_shutdown to
close this gap.

Fixes below error messages (dmesg) during shutdown stress tests -
[685814.900917] ice 0000:88:00.0: MAC 02:d0:5f:82:43:5d does not exist for
 VF 0
[685814.900928] ice 0000:88:00.0: MAC 33:33:00:00:00:01 does not exist for
VF 0

Reproduction:

1. Create one VF interface:
echo 1 > /sys/class/net/<interface_name>/device/sriov_numvfs

2. Run live dmesg on the host:
dmesg -wH

3. On SUT, script below steps into vf_namespace_assignment.sh

<#!/bin/sh> // Remove <>. Git removes # line
if=<VF name> (edit this per VF name)
loop=0

while true; do

echo test round $loop
let loop++

ip netns add ns$loop
ip link set dev $if up
ip link set dev $if netns ns$loop
ip netns exec ns$loop ip link set dev $if up
ip netns exec ns$loop ip link set dev $if netns 1
ip netns delete ns$loop

done

4. Run the script for at least 1000 iterations on SUT:
./vf_namespace_assignment.sh

Expected result:
No errors in dmesg.

Fixes: 129cf89e5856 ("iavf: rename functions and structs to new name")
Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Co-developed-by: Ranganatha Rao <ranganatha.rao@intel.com>
Signed-off-by: Ranganatha Rao <ranganatha.rao@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 72 ++++++---------------
 1 file changed, 21 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 98116872f6bd..e8d5b889addc 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -276,27 +276,6 @@ void iavf_free_virt_mem(struct iavf_hw *hw, struct iavf_virt_mem *mem)
 	kfree(mem->va);
 }
 
-/**
- * iavf_lock_timeout - try to lock mutex but give up after timeout
- * @lock: mutex that should be locked
- * @msecs: timeout in msecs
- *
- * Returns 0 on success, negative on failure
- **/
-static int iavf_lock_timeout(struct mutex *lock, unsigned int msecs)
-{
-	unsigned int wait, delay = 10;
-
-	for (wait = 0; wait < msecs; wait += delay) {
-		if (mutex_trylock(lock))
-			return 0;
-
-		msleep(delay);
-	}
-
-	return -1;
-}
-
 /**
  * iavf_schedule_reset - Set the flags and schedule a reset event
  * @adapter: board private structure
@@ -4914,34 +4893,6 @@ int iavf_process_config(struct iavf_adapter *adapter)
 	return 0;
 }
 
-/**
- * iavf_shutdown - Shutdown the device in preparation for a reboot
- * @pdev: pci device structure
- **/
-static void iavf_shutdown(struct pci_dev *pdev)
-{
-	struct iavf_adapter *adapter = iavf_pdev_to_adapter(pdev);
-	struct net_device *netdev = adapter->netdev;
-
-	netif_device_detach(netdev);
-
-	if (netif_running(netdev))
-		iavf_close(netdev);
-
-	if (iavf_lock_timeout(&adapter->crit_lock, 5000))
-		dev_warn(&adapter->pdev->dev, "%s: failed to acquire crit_lock\n", __func__);
-	/* Prevent the watchdog from running. */
-	iavf_change_state(adapter, __IAVF_REMOVE);
-	adapter->aq_required = 0;
-	mutex_unlock(&adapter->crit_lock);
-
-#ifdef CONFIG_PM
-	pci_save_state(pdev);
-
-#endif
-	pci_disable_device(pdev);
-}
-
 /**
  * iavf_probe - Device Initialization Routine
  * @pdev: PCI device information struct
@@ -5152,16 +5103,21 @@ static int __maybe_unused iavf_resume(struct device *dev_d)
  **/
 static void iavf_remove(struct pci_dev *pdev)
 {
-	struct iavf_adapter *adapter = iavf_pdev_to_adapter(pdev);
 	struct iavf_fdir_fltr *fdir, *fdirtmp;
 	struct iavf_vlan_filter *vlf, *vlftmp;
 	struct iavf_cloud_filter *cf, *cftmp;
 	struct iavf_adv_rss *rss, *rsstmp;
 	struct iavf_mac_filter *f, *ftmp;
+	struct iavf_adapter *adapter;
 	struct net_device *netdev;
 	struct iavf_hw *hw;
 
-	netdev = adapter->netdev;
+	/* Don't proceed with remove if netdev is already freed */
+	netdev = pci_get_drvdata(pdev);
+	if (!netdev)
+		return;
+
+	adapter = iavf_pdev_to_adapter(pdev);
 	hw = &adapter->hw;
 
 	if (test_and_set_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section))
@@ -5273,11 +5229,25 @@ static void iavf_remove(struct pci_dev *pdev)
 
 	destroy_workqueue(adapter->wq);
 
+	pci_set_drvdata(pdev, NULL);
+
 	free_netdev(netdev);
 
 	pci_disable_device(pdev);
 }
 
+/**
+ * iavf_shutdown - Shutdown the device in preparation for a reboot
+ * @pdev: pci device structure
+ **/
+static void iavf_shutdown(struct pci_dev *pdev)
+{
+	iavf_remove(pdev);
+
+	if (system_state == SYSTEM_POWER_OFF)
+		pci_set_power_state(pdev, PCI_D3hot);
+}
+
 static SIMPLE_DEV_PM_OPS(iavf_pm_ops, iavf_suspend, iavf_resume);
 
 static struct pci_driver iavf_driver = {
-- 
2.41.0


