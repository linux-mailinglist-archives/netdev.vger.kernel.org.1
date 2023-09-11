Return-Path: <netdev+bounces-32933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 323D879AB37
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 22:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF255281389
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 20:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9608A1640D;
	Mon, 11 Sep 2023 20:29:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D7D15AE3
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 20:29:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37989185
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 13:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694464140; x=1726000140;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fdrvQfmRxQknU+dczfycNt7x+lgPOiem3g1uCHkWU7E=;
  b=MikQtSISs1edHwl9DEpYboEyTq37DK3hQbEVcsBsJu4ID5PBrIk9rGjS
   K85m0EG8YYXsB1nMHCAVJjwhPrQlJ28tQAG5OgXm1fOE2rs+jgMEbB/CP
   NBe5Qr2fsqLubjakCtyfxxEGMYj3zoujxT37AAN4mHOVgEXuEOynF53mD
   W6GzP7aw4fWHipgS1khVnmSO4Xrhhhyn3GfeQy/5TKkYyHFvEBM9Uvrxg
   1EzBvASrDC/J+6//J0fSmtnVz/nTP57TXrKAgn2fUzG58XlW604P5FMuw
   YiDkTh3rRMzMyCHtOpfBWWXuIaDIP4XpjheMmxaLKRdiu7yqZapM0d56V
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="409156988"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="409156988"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 13:28:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="772718598"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="772718598"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga008.jf.intel.com with ESMTP; 11 Sep 2023 13:28:59 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Corinna Vinschen <vinschen@redhat.com>,
	anthony.l.nguyen@intel.com,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net] igb: clean up in all error paths when enabling SR-IOV
Date: Mon, 11 Sep 2023 13:28:49 -0700
Message-Id: <20230911202849.147504-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Corinna Vinschen <vinschen@redhat.com>

After commit 50f303496d92 ("igb: Enable SR-IOV after reinit"), removing
the igb module could hang or crash (depending on the machine) when the
module has been loaded with the max_vfs parameter set to some value != 0.

In case of one test machine with a dual port 82580, this hang occurred:

[  232.480687] igb 0000:41:00.1: removed PHC on enp65s0f1
[  233.093257] igb 0000:41:00.1: IOV Disabled
[  233.329969] pcieport 0000:40:01.0: AER: Multiple Uncorrected (Non-Fatal) err0
[  233.340302] igb 0000:41:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fata)
[  233.352248] igb 0000:41:00.0:   device [8086:1516] error status/mask=00100000
[  233.361088] igb 0000:41:00.0:    [20] UnsupReq               (First)
[  233.368183] igb 0000:41:00.0: AER:   TLP Header: 40000001 0000040f cdbfc00c c
[  233.376846] igb 0000:41:00.1: PCIe Bus Error: severity=Uncorrected (Non-Fata)
[  233.388779] igb 0000:41:00.1:   device [8086:1516] error status/mask=00100000
[  233.397629] igb 0000:41:00.1:    [20] UnsupReq               (First)
[  233.404736] igb 0000:41:00.1: AER:   TLP Header: 40000001 0000040f cdbfc00c c
[  233.538214] pci 0000:41:00.1: AER: can't recover (no error_detected callback)
[  233.538401] igb 0000:41:00.0: removed PHC on enp65s0f0
[  233.546197] pcieport 0000:40:01.0: AER: device recovery failed
[  234.157244] igb 0000:41:00.0: IOV Disabled
[  371.619705] INFO: task irq/35-aerdrv:257 blocked for more than 122 seconds.
[  371.627489]       Not tainted 6.4.0-dirty #2
[  371.632257] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this.
[  371.641000] task:irq/35-aerdrv   state:D stack:0     pid:257   ppid:2      f0
[  371.650330] Call Trace:
[  371.653061]  <TASK>
[  371.655407]  __schedule+0x20e/0x660
[  371.659313]  schedule+0x5a/0xd0
[  371.662824]  schedule_preempt_disabled+0x11/0x20
[  371.667983]  __mutex_lock.constprop.0+0x372/0x6c0
[  371.673237]  ? __pfx_aer_root_reset+0x10/0x10
[  371.678105]  report_error_detected+0x25/0x1c0
[  371.682974]  ? __pfx_report_normal_detected+0x10/0x10
[  371.688618]  pci_walk_bus+0x72/0x90
[  371.692519]  pcie_do_recovery+0xb2/0x330
[  371.696899]  aer_process_err_devices+0x117/0x170
[  371.702055]  aer_isr+0x1c0/0x1e0
[  371.705661]  ? __set_cpus_allowed_ptr+0x54/0xa0
[  371.710723]  ? __pfx_irq_thread_fn+0x10/0x10
[  371.715496]  irq_thread_fn+0x20/0x60
[  371.719491]  irq_thread+0xe6/0x1b0
[  371.723291]  ? __pfx_irq_thread_dtor+0x10/0x10
[  371.728255]  ? __pfx_irq_thread+0x10/0x10
[  371.732731]  kthread+0xe2/0x110
[  371.736243]  ? __pfx_kthread+0x10/0x10
[  371.740430]  ret_from_fork+0x2c/0x50
[  371.744428]  </TASK>

The reproducer was a simple script:

  #!/bin/sh
  for i in `seq 1 5`; do
    modprobe -rv igb
    modprobe -v igb max_vfs=1
    sleep 1
    modprobe -rv igb
  done

It turned out that this could only be reproduce on 82580 (quad and
dual-port), but not on 82576, i350 and i210.  Further debugging showed
that igb_enable_sriov()'s call to pci_enable_sriov() is failing, because
dev->is_physfn is 0 on 82580.

Prior to commit 50f303496d92 ("igb: Enable SR-IOV after reinit"),
igb_enable_sriov() jumped into the "err_out" cleanup branch.  After this
commit it only returned the error code.

So the cleanup didn't take place, and the incorrect VF setup in the
igb_adapter structure fooled the igb driver into assuming that VFs have
been set up where no VF actually existed.

Fix this problem by cleaning up again if pci_enable_sriov() fails.

Fixes: 50f303496d92 ("igb: Enable SR-IOV after reinit")
Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 13ba9c74bd84..76b34cee1da3 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3827,8 +3827,11 @@ static int igb_enable_sriov(struct pci_dev *pdev, int num_vfs, bool reinit)
 	}
 
 	/* only call pci_enable_sriov() if no VFs are allocated already */
-	if (!old_vfs)
+	if (!old_vfs) {
 		err = pci_enable_sriov(pdev, adapter->vfs_allocated_count);
+		if (err)
+			goto err_out;
+	}
 
 	goto out;
 
-- 
2.38.1


