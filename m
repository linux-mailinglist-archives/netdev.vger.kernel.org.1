Return-Path: <netdev+bounces-136940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EBE9A3B4A
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 12:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00ED21C21B02
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 10:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2321201272;
	Fri, 18 Oct 2024 10:17:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62972038AE;
	Fri, 18 Oct 2024 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246658; cv=none; b=S5Lg/APU062XkxH1/ZQf7nursopH2B2UI4SF9e5kgSoagKN6RQrQCnMGPCzhClFo3F0bcVFqEdUVpDrGjiSwi8NvJg1B81773oBIyZNkWkAoqU2JlOdVecM3ZVWD66YosM+EFZPZxsHcFEv2G5siqFJQ5aOppgdvDp9k160tMvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246658; c=relaxed/simple;
	bh=XV9p0hEwSd0t/By3via0AD4hz2CjjTYV+fmYkB+2NZo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TiPGF1ehYwEwF3veDBtcqH/k30ci+CPFBoH98gXZITpccaGyLC9s1kngAZunovo6VpnQ/HZMb7QiJzB73HCALGf5SoPENnBEApZ6UgEDqsDbY6ya+DoqQiLahEfGJqCIJEb/L4Iov0qZwejWUug06qm/lQ56SIRMrXLRt0nQZtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XVLDN672YzfdLP;
	Fri, 18 Oct 2024 18:15:00 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id CFEEC1402CF;
	Fri, 18 Oct 2024 18:17:28 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 18:17:28 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <shenjian15@huawei.com>, <salil.mehta@huawei.com>
CC: <liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>,
	<shaojijie@huawei.com>, <lanhao@huawei.com>, <chenhao418@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 net 6/9] net: hns3: don't auto enable misc vector
Date: Fri, 18 Oct 2024 18:10:56 +0800
Message-ID: <20241018101059.1718375-7-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241018101059.1718375-1-shaojijie@huawei.com>
References: <20241018101059.1718375-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)

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
index 35c618c794be..728f4777e51f 100644
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
@@ -3780,7 +3781,7 @@ static int hclge_misc_irq_init(struct hclge_dev *hdev)
 	snprintf(hdev->misc_vector.name, HNAE3_INT_NAME_LEN, "%s-misc-%s",
 		 HCLGE_NAME, pci_name(hdev->pdev));
 	ret = request_irq(hdev->misc_vector.vector_irq, hclge_misc_irq_handle,
-			  0, hdev->misc_vector.name, hdev);
+			  IRQ_NOAUTOEN, hdev->misc_vector.name, hdev);
 	if (ret) {
 		hclge_free_vector(hdev, 0);
 		dev_err(&hdev->pdev->dev, "request misc irq(%d) fail\n",
@@ -11916,9 +11917,6 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 
 	hclge_init_rxd_adv_layout(hdev);
 
-	/* Enable MISC vector(vector0) */
-	hclge_enable_vector(&hdev->misc_vector, true);
-
 	ret = hclge_init_wol(hdev);
 	if (ret)
 		dev_warn(&pdev->dev,
@@ -11931,6 +11929,10 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 	hclge_state_init(hdev);
 	hdev->last_reset_time = jiffies;
 
+	/* Enable MISC vector(vector0) */
+	enable_irq(hdev->misc_vector.vector_irq);
+	hclge_enable_vector(&hdev->misc_vector, true);
+
 	dev_info(&hdev->pdev->dev, "%s driver initialization finished.\n",
 		 HCLGE_DRIVER_NAME);
 
@@ -12336,7 +12338,7 @@ static void hclge_uninit_ae_dev(struct hnae3_ae_dev *ae_dev)
 
 	/* Disable MISC vector(vector0) */
 	hclge_enable_vector(&hdev->misc_vector, false);
-	synchronize_irq(hdev->misc_vector.vector_irq);
+	disable_irq(hdev->misc_vector.vector_irq);
 
 	/* Disable all hw interrupts */
 	hclge_config_mac_tnl_int(hdev, false);
-- 
2.33.0


