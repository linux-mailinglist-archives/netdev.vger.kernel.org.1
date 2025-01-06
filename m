Return-Path: <netdev+bounces-155499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DA8A02853
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 15:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7EB1651CE
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 14:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F611DF25F;
	Mon,  6 Jan 2025 14:44:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B551DE4C3;
	Mon,  6 Jan 2025 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736174657; cv=none; b=L1oSZtTwYsZ9D+TwLrxKdvQEEJCtDOeL7uQ1XPIIWvBQEGVj4hnkVoM8FMBOqQKYZTeIMZ5XzlkC72FbZQmV4UbSQCjoHvT4Fm1ded8ZHnn+LTQNV685J6pYFI2PTWlvgasBJorb550aywt86YmgbBpzDU78uARwcL0zohYxTSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736174657; c=relaxed/simple;
	bh=N6lJmn/mW4VFM4e2xlkdIby5DEN/1KOgabP+UWFblUU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=grUtkYWx9L4Od0dRcXKiuhD6oiInU/cFuCB/63u/zjfdlNYr6d9X6DyP4odnfag5ahWbgOuHXOHV15yGhac662k9VedMJIofeyn6ULbDvSSf8UW9iEML379ckxWmEg9nwOvX+DzXM1kBPNBt4WA3w89yVdrV42IHMYqti3JMgvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YRcLd4QLVz1kxhY;
	Mon,  6 Jan 2025 22:41:13 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C7061401F2;
	Mon,  6 Jan 2025 22:44:12 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 6 Jan 2025 22:44:11 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.swiatkowski@linux.intel.com>,
	<shaojijie@huawei.com>
Subject: [PATCH V3 net 4/7] net: hns3: don't auto enable misc vector
Date: Mon, 6 Jan 2025 22:36:39 +0800
Message-ID: <20250106143642.539698-5-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250106143642.539698-1-shaojijie@huawei.com>
References: <20250106143642.539698-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemk100013.china.huawei.com (7.202.194.61)

From: Jian Shen <shenjian15@huawei.com>

Currently, there is a time window between misc irq enabled
and service task inited. If an interrupte is reported at
this time, it will cause warning like below:

[   16.324639] Call trace:
[   16.324641]  __queue_delayed_work+0xb8/0xe0
[   16.324643]  mod_delayed_work_on+0x78/0xd0
[   16.324655]  hclge_errhand_task_schedule+0x58/0x90 [hclge]
[   16.324662]  hclge_misc_irq_handle+0x168/0x240 [hclge]
[   16.324666]  __handle_irq_event_percpu+0x64/0x1e0
[   16.324667]  handle_irq_event+0x80/0x170
[   16.324670]  handle_fasteoi_edge_irq+0x110/0x2bc
[   16.324671]  __handle_domain_irq+0x84/0xfc
[   16.324673]  gic_handle_irq+0x88/0x2c0
[   16.324674]  el1_irq+0xb8/0x140
[   16.324677]  arch_cpu_idle+0x18/0x40
[   16.324679]  default_idle_call+0x5c/0x1bc
[   16.324682]  cpuidle_idle_call+0x18c/0x1c4
[   16.324684]  do_idle+0x174/0x17c
[   16.324685]  cpu_startup_entry+0x30/0x6c
[   16.324687]  secondary_start_kernel+0x1a4/0x280
[   16.324688] ---[ end trace 6aa0bff672a964aa ]---

So don't auto enable misc vector when request irq..

Fixes: 7be1b9f3e99f ("net: hns3: make hclge_service use delayed workqueue")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c  | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 7d44dc777dc5..db7845009252 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -6,6 +6,7 @@
 #include <linux/etherdevice.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -3770,7 +3771,7 @@ static int hclge_misc_irq_init(struct hclge_dev *hdev)
 	snprintf(hdev->misc_vector.name, HNAE3_INT_NAME_LEN, "%s-misc-%s",
 		 HCLGE_NAME, pci_name(hdev->pdev));
 	ret = request_irq(hdev->misc_vector.vector_irq, hclge_misc_irq_handle,
-			  0, hdev->misc_vector.name, hdev);
+			  IRQF_NO_AUTOEN, hdev->misc_vector.name, hdev);
 	if (ret) {
 		hclge_free_vector(hdev, 0);
 		dev_err(&hdev->pdev->dev, "request misc irq(%d) fail\n",
@@ -11906,9 +11907,6 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 
 	hclge_init_rxd_adv_layout(hdev);
 
-	/* Enable MISC vector(vector0) */
-	hclge_enable_vector(&hdev->misc_vector, true);
-
 	ret = hclge_init_wol(hdev);
 	if (ret)
 		dev_warn(&pdev->dev,
@@ -11921,6 +11919,10 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 	hclge_state_init(hdev);
 	hdev->last_reset_time = jiffies;
 
+	/* Enable MISC vector(vector0) */
+	enable_irq(hdev->misc_vector.vector_irq);
+	hclge_enable_vector(&hdev->misc_vector, true);
+
 	dev_info(&hdev->pdev->dev, "%s driver initialization finished.\n",
 		 HCLGE_DRIVER_NAME);
 
@@ -12326,7 +12328,7 @@ static void hclge_uninit_ae_dev(struct hnae3_ae_dev *ae_dev)
 
 	/* Disable MISC vector(vector0) */
 	hclge_enable_vector(&hdev->misc_vector, false);
-	synchronize_irq(hdev->misc_vector.vector_irq);
+	disable_irq(hdev->misc_vector.vector_irq);
 
 	/* Disable all hw interrupts */
 	hclge_config_mac_tnl_int(hdev, false);
-- 
2.33.0


