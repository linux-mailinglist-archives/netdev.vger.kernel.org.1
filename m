Return-Path: <netdev+bounces-52246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1848F7FDF74
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 19:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB011C20AA0
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 18:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA493529C;
	Wed, 29 Nov 2023 18:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k3teRwIz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1712E12C
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 10:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701283316; x=1732819316;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FuM6+pB8IDds+B7QD+pku6Po3IZK41UrFEWqjt8/w94=;
  b=k3teRwIztb0kLdbb7o+0JYhvgL331OZEUtVHvI9xF4ZXdBPL3fLkEEWi
   PQMU6Lopq2imDCrPJcpMG/90RiINQeIkvS7GWMvpywKsESfiqWF+3Vgxr
   XK7yi0h/qpjOavA40M5Om2W/OKRXFeE2uoEe0PLvwVNyHBT5nXaC7WxaW
   nH0PwOQrQ/jRHlW5zGGwu0uGbtSNE1kS8osMyPpy7jq/L/5++tFhRoaZl
   DIiucrPsKzy3BbPUq7LMT5yVXFQVO/R9QxegGH54HhabHJXFSCumo1gnd
   Y6kQR3Rhf//RTuWgKgkoVT1CluE0s4wauNH35K+AUHQb6RbJC0/xdQuAV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="193022"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="193022"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 10:41:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="772776470"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="772776470"
Received: from fedora-sys-rao.jf.intel.com (HELO f37-upstream-rao..) ([10.166.5.220])
  by fmsmga007.fm.intel.com with ESMTP; 29 Nov 2023 10:41:54 -0800
From: Ranganatha Rao <ranganatha.rao@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Slawomir Laba <slawomirx.laba@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Ranganatha Rao <ranganatha.rao@intel.com>
Subject: [PATCH iwl-net, v2] iavf: Fix iavf_shutdown to call iavf_remove instead iavf_close
Date: Wed, 29 Nov 2023 10:35:26 -0500
Message-ID: <20231129153526.57912-1-ranganatha.rao@intel.com>
X-Mailer: git-send-email 2.41.0
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
Co-authored-by: Ranganatha Rao <ranganatha.rao@intel.com>
Signed-off-by: Ranganatha Rao <ranganatha.rao@intel.com>

---
v2: Add reproduction steps in commit log
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 72 ++++++---------------
 1 file changed, 21 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index c862ebcd2e39..3c177dcd3b38 100644
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
@@ -4825,34 +4804,6 @@ int iavf_process_config(struct iavf_adapter *adapter)
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
@@ -5063,16 +5014,21 @@ static int __maybe_unused iavf_resume(struct device *dev_d)
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
@@ -5184,11 +5140,25 @@ static void iavf_remove(struct pci_dev *pdev)
 
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


