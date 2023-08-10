Return-Path: <netdev+bounces-26518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B3D777FDF
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82EB31C2167A
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AB722EF1;
	Thu, 10 Aug 2023 18:01:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C679522EE2
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 18:01:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134D610C0
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 11:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691690486; x=1723226486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ag013UxMfEube2zroTN9l9woXHuyA3wOPIqtXzKXoUw=;
  b=Mas7dSzUlplnxMR7V+Muu2XcuNIDyAqJnHapxMCn5XeAnLl1FoBX/izc
   pzVa9gs3B0nZ0UcXVrA2+bb3v0WqrFwpixDcrNIoUwxFUlDfP/aukR9v4
   S4ykYaZZJtyuyJEqsDNd7HGEY5h5SJT56hju+/AfgXqRLKa8t99ETLwum
   QjtaqDXtPzr1QH1pLF5/bWowBF+hbT8NResm2IaX1p5jMtmJ2DTMgf+Um
   4CxmQm363Wqs278gNQM9eEmZtirpon5z4670vBTLmEI8NmQSGsDlu4ffY
   cUG7YRRJYxqD/yqH/ZvCceOvcZbyKlc66/KDWLP8jhOTm5QAF/j64YuVl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="361618473"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="361618473"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 11:01:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="709253388"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="709253388"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga006.jf.intel.com with ESMTP; 10 Aug 2023 11:01:23 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	Naama Meir <naamax.meir@linux.intel.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net-next 2/2] e1000e: Use PME poll to circumvent unreliable ACPI wake
Date: Thu, 10 Aug 2023 10:54:10 -0700
Message-Id: <20230810175410.1964221-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230810175410.1964221-1-anthony.l.nguyen@intel.com>
References: <20230810175410.1964221-1-anthony.l.nguyen@intel.com>
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

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

On some I219 devices, ethernet cable plugging detection only works once
from PCI D3 state. Subsequent cable plugging does set PME bit correctly,
but device still doesn't get woken up.

Since I219 connects to the root complex directly, it relies on platform
firmware (ACPI) to wake it up. In this case, the GPE from _PRW only
works for first cable plugging but fails to notify the driver for
subsequent plugging events.

The issue was originally found on CNP, but the same issue can be found
on ADL too. So workaround the issue by continuing use PME poll after
first ACPI wake. As PME poll is always used, the runtime suspend
restriction for CNP can also be removed.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Acked-by: Sasha Neftin <sasha.neftin@intel.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 771a3c909c45..18a5e73b8680 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7021,6 +7021,8 @@ static __maybe_unused int e1000e_pm_runtime_resume(struct device *dev)
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 	int rc;
 
+	pdev->pme_poll = true;
+
 	rc = __e1000_resume(pdev);
 	if (rc)
 		return rc;
@@ -7682,7 +7684,7 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_SMART_PREPARE);
 
-	if (pci_dev_run_wake(pdev) && hw->mac.type != e1000_pch_cnp)
+	if (pci_dev_run_wake(pdev))
 		pm_runtime_put_noidle(&pdev->dev);
 
 	return 0;
-- 
2.38.1


