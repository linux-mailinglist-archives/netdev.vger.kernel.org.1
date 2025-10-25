Return-Path: <netdev+bounces-232742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D939C08835
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 03:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96A2D1B20C4D
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 01:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12749227B8E;
	Sat, 25 Oct 2025 01:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="YXlondH9"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9302248BE;
	Sat, 25 Oct 2025 01:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761356852; cv=none; b=FBrkZQp7LVNYVvxVcbybvDLluXbp1kGj6Q5vWDlr5VZWjVdx9pc3mOQae1hJdbKQpedGY6zIGjcHFqnrYXZJMMhqrNqEdUfm3MGa8eHS3+Ga9QytMD9lr0EO3PCAIdEeiFC0xMk8l5a8JhVAXNyVJch1MbEn3fP32+z3fWmRTqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761356852; c=relaxed/simple;
	bh=lZmi+kDKB8xe3+r6YR8pg5xCUqYbMb13nnYqmOXobTc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AYjMcSaEElJezOwsT8FlFzX5elAUs6fHg0XhAusqgbuLK8ukhu/xDn/tQ59h+Qld8bSjlK9yz+eOs+2BG+sCI4Xx6c/e7vKuJO0WITAkD6ZVwBmC3NkJtIK95mnzDMyixZbTXMrz02nLIEPA7z+alwmt4WJDWOzh3U1JKXl4F/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=YXlondH9; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8ARD8jSxMbMRlCipcLCAszwV8F4zDQebgu4xxdqqPBE=;
	b=YXlondH9+saWTPMYWXqURHpeRCB2/gpaU4diy07cTwJNih9AKbJxfr4C8eupHhchvS1NPsIjW
	Vaduihag4g6nsZEwMzp0j/mFI/8twV3818UVPcJqGXPBWoWV+PSiUicJV5S/navqzdaSx+5TdKU
	HKZ13CwknIsKC08EtCK7oS4=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ctjLB3pcyznTW3;
	Sat, 25 Oct 2025 09:46:42 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B5061400CA;
	Sat, 25 Oct 2025 09:47:22 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 25 Oct 2025 09:47:21 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jacob.e.keller@intel.com>, <jonathan.cameron@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH V2 net 3/3] net: hibmcge: fix the inappropriate netif_device_detach()
Date: Sat, 25 Oct 2025 09:46:42 +0800
Message-ID: <20251025014642.265259-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20251025014642.265259-1-shaojijie@huawei.com>
References: <20251025014642.265259-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)

current, driver will call netif_device_detach() in
pci_error_handlers.error_detected() and do reset in
pci_error_handlers.slot_reset().
However, if pci_error_handlers.slot_reset() is not called
after pci_error_handlers.error_detected(),
driver will be detached and unable to recover.

drivers/pci/pcie/err.c/report_error_detected() says:
  If any device in the subtree does not have an error_detected
  callback, PCI_ERS_RESULT_NO_AER_DRIVER prevents subsequent
  error callbacks of any device in the subtree, and will
  exit in the disconnected error state.

Therefore, when the hibmcge device and other devices that do not
support the error_detected callback are under the same subtree,
hibmcge will be unable to do slot_reset even for non-fatal errors.

This path move netif_device_detach() from error_detected() to slot_reset(),
ensuring that detach and reset are always executed together.

Fixes: fd394a334b1c ("net: hibmcge: Add support for abnormal irq handling feature")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
index 83cf75bf7a17..e11495b7ee98 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
@@ -136,12 +136,11 @@ static pci_ers_result_t hbg_pci_err_detected(struct pci_dev *pdev,
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
 
-	netif_device_detach(netdev);
-
-	if (state == pci_channel_io_perm_failure)
+	if (state == pci_channel_io_perm_failure) {
+		netif_device_detach(netdev);
 		return PCI_ERS_RESULT_DISCONNECT;
+	}
 
-	pci_disable_device(pdev);
 	return PCI_ERS_RESULT_NEED_RESET;
 }
 
@@ -150,6 +149,9 @@ static pci_ers_result_t hbg_pci_err_slot_reset(struct pci_dev *pdev)
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct hbg_priv *priv = netdev_priv(netdev);
 
+	netif_device_detach(netdev);
+	pci_disable_device(pdev);
+
 	if (pci_enable_device(pdev)) {
 		dev_err(&pdev->dev,
 			"failed to re-enable PCI device after reset\n");
-- 
2.33.0


