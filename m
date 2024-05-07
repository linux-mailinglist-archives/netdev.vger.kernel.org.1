Return-Path: <netdev+bounces-94131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1728BE4AF
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 15:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09571C21510
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 13:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF39015F3F1;
	Tue,  7 May 2024 13:49:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD5015E21B;
	Tue,  7 May 2024 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089799; cv=none; b=dosA5GEiGetw3Wq3sme8LZbW6rQzy1zXhtkesRaKOrEbRexyMnt3FK65kBT+rk+NZGFipRlmDUcdQi+tHCjbxNIhJKldEExorS4nQ18gXDmDFRtqPLUtf1jhi3r3fkmcj4OuaNtSqiDa57NyIDEKq++lFVAboL8F122uxd/7A9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089799; c=relaxed/simple;
	bh=rTb+6h5WdLhI0PJ2MZa/eSn7YcfXrozUwQkanBndH2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EFU4a6yzw90+wIYJ43ngX0YcCAYcu6CY+h2RW4MzsHGF6/Eh5y8F2olTeaTvI6NNY5EPW9tbeKwr+XsrROHZZTZy0XWdV84Ylmx7LsSIv3y4IS0g69khZQxDrMCoWzk8c3e5NOnTdVPTMAVLC70bvdHTa41YacbjacOwL7sXR3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VYfkf2gbjzCrP3;
	Tue,  7 May 2024 21:48:42 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 0EBC71403D4;
	Tue,  7 May 2024 21:49:53 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 21:49:52 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jiri@resnulli.us>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <chenhao418@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 net 7/7] net: hns3: fix kernel crash when devlink reload during initialization
Date: Tue, 7 May 2024 21:42:24 +0800
Message-ID: <20240507134224.2646246-8-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240507134224.2646246-1-shaojijie@huawei.com>
References: <20240507134224.2646246-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)

From: Yonglong Liu <liuyonglong@huawei.com>

The devlink reload process will access the hardware resources,
but the register operation is done before the hardware is initialized.
So, processing the devlink reload during initialization may lead to kernel
crash.

This patch fixes this by registering the devlink after
hardware initialization.

Fixes: cd6242991d2e ("net: hns3: add support for registering devlink for VF")
Fixes: 93305b77ffcb ("net: hns3: fix kernel crash when devlink reload during pf initialization")
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 17 +++++------------
 .../hisilicon/hns3/hns3vf/hclgevf_main.c        | 10 ++++------
 2 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 0773124440e9..ce60332d83c3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -11631,16 +11631,10 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 	if (ret)
 		goto out;
 
-	ret = hclge_devlink_init(hdev);
-	if (ret)
-		goto err_pci_uninit;
-
-	devl_lock(hdev->devlink);
-
 	/* Firmware command queue initialize */
 	ret = hclge_comm_cmd_queue_init(hdev->pdev, &hdev->hw.hw);
 	if (ret)
-		goto err_devlink_uninit;
+		goto err_pci_uninit;
 
 	/* Firmware command initialize */
 	ret = hclge_comm_cmd_init(hdev->ae_dev, &hdev->hw.hw, &hdev->fw_version,
@@ -11808,6 +11802,10 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 		dev_warn(&pdev->dev,
 			 "failed to wake on lan init, ret = %d\n", ret);
 
+	ret = hclge_devlink_init(hdev);
+	if (ret)
+		goto err_ptp_uninit;
+
 	hclge_state_init(hdev);
 	hdev->last_reset_time = jiffies;
 
@@ -11815,8 +11813,6 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 		 HCLGE_DRIVER_NAME);
 
 	hclge_task_schedule(hdev, round_jiffies_relative(HZ));
-
-	devl_unlock(hdev->devlink);
 	return 0;
 
 err_ptp_uninit:
@@ -11830,9 +11826,6 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 	pci_free_irq_vectors(pdev);
 err_cmd_uninit:
 	hclge_comm_cmd_uninit(hdev->ae_dev, &hdev->hw.hw);
-err_devlink_uninit:
-	devl_unlock(hdev->devlink);
-	hclge_devlink_uninit(hdev);
 err_pci_uninit:
 	pcim_iounmap(pdev, hdev->hw.hw.io_base);
 	pci_release_regions(pdev);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 08db8e84be4e..43ee20eb03d1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -2845,10 +2845,6 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 	if (ret)
 		return ret;
 
-	ret = hclgevf_devlink_init(hdev);
-	if (ret)
-		goto err_devlink_init;
-
 	ret = hclge_comm_cmd_queue_init(hdev->pdev, &hdev->hw.hw);
 	if (ret)
 		goto err_cmd_queue_init;
@@ -2941,6 +2937,10 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 
 	hclgevf_init_rxd_adv_layout(hdev);
 
+	ret = hclgevf_devlink_init(hdev);
+	if (ret)
+		goto err_config;
+
 	set_bit(HCLGEVF_STATE_SERVICE_INITED, &hdev->state);
 
 	hdev->last_reset_time = jiffies;
@@ -2960,8 +2960,6 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 err_cmd_init:
 	hclge_comm_cmd_uninit(hdev->ae_dev, &hdev->hw.hw);
 err_cmd_queue_init:
-	hclgevf_devlink_uninit(hdev);
-err_devlink_init:
 	hclgevf_pci_uninit(hdev);
 	clear_bit(HCLGEVF_STATE_IRQ_INITED, &hdev->state);
 	return ret;
-- 
2.30.0


