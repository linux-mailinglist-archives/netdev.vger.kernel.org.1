Return-Path: <netdev+bounces-16534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FA074DB74
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 18:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1AE280C76
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 16:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620E112B9A;
	Mon, 10 Jul 2023 16:47:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A4F107B4
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 16:47:53 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21470183
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 09:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689007670; x=1720543670;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=evV4Q30whqijhUorQB+jrnszg+WnG+f6dEBGrAsJog4=;
  b=HmECUOn2f2b4zMb0XGwyyW+29COXRvERE/e9M5PRYHY02Vc30Dte1erc
   CqBc38kWpTxgGhW2UXtIGOQE59ygy0byU/BDjYINo52mQutDfFGgHFmWo
   rt4ZIKuGBz4ITJsXFwfIy6pTLKK/y4LK4eTSV5CI6s1DqoMvAiR7c9HF5
   y7flFdSOfHExej3mcs05M9mvSwG4hi/T7SOKYPxhrVFiFphpzBNm986jh
   aZt6qpT371oYL+H/ZMyjrGmlhBBN6uYOVZQyDKwpmq+9VsSN3DzMhd8uv
   UCWsBM62BsvZKxkvb266rk0ULRsR/33ozQ9jOMiJimnoRzkSXZwYjU221
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="349199520"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="349199520"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 09:47:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="834336930"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="834336930"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga002.fm.intel.com with ESMTP; 10 Jul 2023 09:47:48 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net-next] e1000e: Use PME poll to circumvent unreliable ACPI wake
Date: Mon, 10 Jul 2023 09:42:13 -0700
Message-Id: <20230710164213.2821481-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
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


