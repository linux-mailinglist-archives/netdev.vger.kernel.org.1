Return-Path: <netdev+bounces-40185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDD17C6124
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 01:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570D91C2107B
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 23:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F05E2B768;
	Wed, 11 Oct 2023 23:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XkWMEreY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD852B752
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 23:33:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEB6AF
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697067228; x=1728603228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yQeuXrOg6mfRlLAComFksMcXgag/yuNEpfQigUYthuY=;
  b=XkWMEreYRomA+AgyPNIL4uNrnx8vmxFSgG9ZoA402L4uHCwW0rnqbN3e
   1dAKg2npuZ1ltUlreO/Gy0GsIuKwcZ+3UWsiN7PDMyNmOtC5B3bur5/Rz
   76G/DRWi9NP3CpWsFTi6+7VujKXZoLzUdv9lsTMbTlHEm3NPV///1VyQO
   1McF+KfnRoCjQgYL5/HTCidbmDH+FuuQBX91Zw6ViyBm4OrJk7eBavJlA
   RYK1h2RtqjCYC81Kpd6RdBqAaYHb2r1EGLgvzuo/NnjEmWyDWsiIj8ijv
   Sh6fsww5DcYD4xnLxIwZbL2Q4FC2SEpDYmT5uo2oZrVhKdJ1aqEdYqzcr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="388652590"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="388652590"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 16:33:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="824359291"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="824359291"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 16:33:46 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Vishal Agrawal <vagrawal@redhat.com>,
	Jay Vosburgh <jay.vosburgh@canonical.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 2/3] ice: reset first in crash dump kernels
Date: Wed, 11 Oct 2023 16:33:33 -0700
Message-ID: <20231011233334.336092-3-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011233334.336092-1-jacob.e.keller@intel.com>
References: <20231011233334.336092-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

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

Fixes: 837f08fdecbe ("ice: Add basic driver framework for Intel(R) E800 Series")
Reported-by: Vishal Agrawal <vagrawal@redhat.com>
Reviewed-by: Jay Vosburgh <jay.vosburgh@canonical.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
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
-- 
2.41.0


