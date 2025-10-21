Return-Path: <netdev+bounces-231280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51489BF6F1E
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 16:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3349B3B1A20
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 14:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765F333A013;
	Tue, 21 Oct 2025 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="I+ERaNQe"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F58633B958;
	Tue, 21 Oct 2025 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761055251; cv=none; b=fASuYrDMcUbdT3d0T7OQoTE/DUZQWAcjdFcI940tlU4uORiRdOvbAe0za0735pAFlACmnJ9Qdwry2p9P3WzGIXTukxtgs0X1N6DfEI6gEOfjU1BEneoXg6Kl8VJNYUWLjdbEvGVl0gnFvCtMXmWuAB+yLWNe3BK+2/1xNHl8olw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761055251; c=relaxed/simple;
	bh=Z4e+Rda2bYfjLOZMWdTklKDon1bvj8FeVYa8pl1efVc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y+PqoIYbv5BXgoFRtkRY6f3pt6pZ2IXbVPzD4FdV8X/AIwMiCOId96xLp+nTMTfYswzj2HnaevWb1eMT4gelhIUh5e3+EAOvLyAYeIkhGeQrV+kdRfrMdKSW6pUIrtVByeZ1em/iTbh/soSfFWe3Enb3X86C82QCNmXD3mQkYvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=I+ERaNQe; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=opBLMIIAqFH/C9JqHJAmW6L6I2eQ3SJbotO5tszdkkw=;
	b=I+ERaNQevgxnbk0VcY7vk1EyDWj5hZ8e1WqC3F+EYXUFBWEfYX+f4RpWr4qcmryBYiGgO82gy
	p8ZZqwYykXuR7NKWF9a6YSdwqNSI8PN59ADJFyWyOquVbn0MLbJMo28Y0QIdZL5EZ+pmFc53jFp
	ufGyDdtKdkbcSgMb0K02Yf8=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4crYp047dgz1T4Kh;
	Tue, 21 Oct 2025 21:59:52 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B950140155;
	Tue, 21 Oct 2025 22:00:45 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Oct 2025 22:00:44 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net 3/3] net: hibmcge: fix the inappropriate netif_device_detach()
Date: Tue, 21 Oct 2025 22:00:16 +0800
Message-ID: <20251021140016.3020739-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20251021140016.3020739-1-shaojijie@huawei.com>
References: <20251021140016.3020739-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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
hibmcge will be unable to do slot_reset.

This path move netif_device_detach from error_detected to slot_reset,
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


