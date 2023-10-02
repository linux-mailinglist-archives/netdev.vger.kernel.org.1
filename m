Return-Path: <netdev+bounces-37510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D6B7B5BAE
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 22:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 48533281F62
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 20:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AF3200BA;
	Mon,  2 Oct 2023 20:02:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1CA1F956
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 20:02:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892DFAC;
	Mon,  2 Oct 2023 13:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696276960; x=1727812960;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QSUega9DohiHtZANJ0msxTsPiln6mFa8NddCKUeRwmk=;
  b=cWOurX7uuPDEM0rR+rcFSZrmVclMM8BJM5ICrIUveApmSjmvmri66iEg
   Vok1uTsjGSPtcc1Yc0YOzM9Ka4B9KY0D0L0covR0Yl4VFIkT5rODjwNIm
   wFXJcqwO0h8Mw5QWb1yiNZfuBlRq6zK6rckiMXxZdfOi7K9i5bJbjvUPX
   89QAQpEy4fV/j4GPAfnpninNzTfDCHWj6/pB4AL0CjKIO8GY4zg25mt12
   csJk/6n49EtZvNuPDm4cEKwQMyt2EfoM1de4MXrwvuyyEW5ken0auiG2Z
   1xzzCildQBH0H1DrF/NanQhKb8VBI9hgmdau6ezPUbUWAssUP1zU1/SJ6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="1318509"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="1318509"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 13:02:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="750696427"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="750696427"
Received: from jbrandeb-spr1.jf.intel.com ([10.166.28.233])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 13:02:38 -0700
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	linux-pci@vger.kernel.org,
	pmenzel@molgen.mpg.de,
	netdev@vger.kernel.org,
	jkc@redhat.com,
	Vishal Agrawal <vagrawal@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net v2] ice: reset first in crash dump kernels
Date: Mon,  2 Oct 2023 13:02:32 -0700
Message-Id: <20231002200232.3682771-1-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When the system boots into the crash dump kernel after a panic, the ice
networking device may still have pending transactions that can cause errors
or machine checks when the device is re-enabled. This can prevent the crash
dump kernel from loading the driver or collecting the crash data.

To avoid this issue, perform a function level reset (FLR) on the ice device
via PCIe config space before enabling it on the crash kernel. This will
clear any outstanding transactions and stop all queues and interrupts.
Restore the config space after the FLR, otherwise it was found in testing
that the driver wouldn't load successfully.

The following sequence causes the original issue:
- Load the ice driver with modprobe ice
- Enable SR-IOV with 2 VFs: echo 2 > /sys/class/net/eth0/device/sriov_num_vfs
- Trigger a crash with echo c > /proc/sysrq-trigger
- Load the ice driver again (or let it load automatically) with modprobe ice
- The system crashes again during pcim_enable_device()

Reported-by: Vishal Agrawal <vagrawal@redhat.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
v2: respond to list comments and update commit message
v1: initial version
---
 drivers/net/ethernet/intel/ice/ice_main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c8286adae946..6550c46e4e36 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6,6 +6,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <generated/utsrelease.h>
+#include <linux/crash_dump.h>
 #include "ice.h"
 #include "ice_base.h"
 #include "ice_lib.h"
@@ -5014,6 +5015,20 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 		return -EINVAL;
 	}
 
+	/* when under a kdump kernel initiate a reset before enabling the
+	 * device in order to clear out any pending DMA transactions. These
+	 * transactions can cause some systems to machine check when doing
+	 * the pcim_enable_device() below.
+	 */
+	if (is_kdump_kernel()) {
+		pci_save_state(pdev);
+		pci_clear_master(pdev);
+		err = pcie_flr(pdev);
+		if (err)
+			return err;
+		pci_restore_state(pdev);
+	}
+
 	/* this driver uses devres, see
 	 * Documentation/driver-api/driver-model/devres.rst
 	 */

base-commit: 6a70e5cbedaf8ad10528ac9ac114f3ec20f422df
-- 
2.39.3


