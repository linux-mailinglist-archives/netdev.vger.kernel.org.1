Return-Path: <netdev+bounces-220258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADDBB45166
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 10:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8CC93AB14B
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 08:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9FA3002D1;
	Fri,  5 Sep 2025 08:29:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A2D30AD0D;
	Fri,  5 Sep 2025 08:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060952; cv=none; b=Q23penrrS+NsBFPHSolIuD5uqcMu+LhrE9Ir6I72MJ5lGVI795Sv/GouDx4yQlQRzvd0ZhlumMpWR/87hZJMmD0HYAAMQzI55xX4nGoM2ZOURuPA8xrViA8xnw4Xs71JEoKCvi5LaMIGgxPVDgJxX7IJAGADSxN6x8YdahohW8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060952; c=relaxed/simple;
	bh=y3GLFD6cVXQc/Gkt2yfxxAkJvYmpbOPjoB/5gi1C08E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bRhzn0WSW1RGWncIh9QIir20utuQPu20TKBWgJYHITQc4kDm5uFxdQdQkGncOjSE/iDpKIhz4XtJ5V97nAC1BcZOngOy+6CU7WRyAk9f+RUygUq/X0QIow/Gi6RkIK675276uNjCJLLgT8M5vZl6AVShVTaz5VmCoOY2ongEheg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cJ8XG6X9Mz2Cg1j;
	Fri,  5 Sep 2025 16:24:30 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id D009514022E;
	Fri,  5 Sep 2025 16:29:00 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.55) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Sep 2025 16:28:59 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas
	<helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
	<guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>, Meny Yossefi
	<meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>, Lee Trager
	<lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Suman Ghosh <sumang@marvell.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Joe Damato <jdamato@fastly.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH net-next v04 02/14] hinic3: HW management interfaces
Date: Fri, 5 Sep 2025 16:28:36 +0800
Message-ID: <603ae8e87791ac0f0fab819f2acf4c58a509bb2d.1757057860.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1757057860.git.zhuyikai1@h-partners.com>
References: <cover.1757057860.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Initialize hardware management config of irq, aeq and ceq.
These will send hardware messages to driver.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/Makefile   |   1 +
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    | 102 ++++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.h    |   3 +
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |  10 ++
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  |  12 +++
 .../net/ethernet/huawei/hinic3/hinic3_lld.c   |   1 +
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.c  |  21 ++++
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.h  |   2 +
 8 files changed, 152 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/Makefile b/drivers/net/ethernet/huawei/hinic3/Makefile
index 2a0ed8e2c63e..a9f055cfef52 100644
--- a/drivers/net/ethernet/huawei/hinic3/Makefile
+++ b/drivers/net/ethernet/huawei/hinic3/Makefile
@@ -14,6 +14,7 @@ hinic3-objs := hinic3_cmdq.o \
 	       hinic3_lld.o \
 	       hinic3_main.o \
 	       hinic3_mbox.o \
+	       hinic3_mgmt.o \
 	       hinic3_netdev_ops.o \
 	       hinic3_nic_cfg.o \
 	       hinic3_nic_io.o \
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
index 0599fc4f3fb0..8db5e2c9ff10 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
@@ -8,6 +8,108 @@
 #include "hinic3_hwif.h"
 #include "hinic3_mbox.h"
 
+static int hinic3_init_irq_info(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cfg_mgmt_info *cfg_mgmt = hwdev->cfg_mgmt;
+	struct hinic3_hwif *hwif = hwdev->hwif;
+	u16 intr_num = hwif->attr.num_irqs;
+	struct hinic3_irq_info *irq_info;
+	u16 intr_needed;
+
+	intr_needed = hwif->attr.msix_flex_en ? (hwif->attr.num_aeqs +
+		      hwif->attr.num_ceqs + hwif->attr.num_sq) : intr_num;
+	if (intr_needed > intr_num) {
+		dev_warn(hwdev->dev, "Irq num cfg %d is less than the needed irq num %d msix_flex_en %d\n",
+			 intr_num, intr_needed, hwdev->hwif->attr.msix_flex_en);
+		intr_needed = intr_num;
+	}
+
+	irq_info = &cfg_mgmt->irq_info;
+	irq_info->irq = kcalloc(intr_num, sizeof(struct hinic3_irq),
+				GFP_KERNEL);
+	if (!irq_info->irq)
+		return -ENOMEM;
+
+	irq_info->num_irq_hw = intr_needed;
+	mutex_init(&irq_info->irq_mutex);
+
+	return 0;
+}
+
+static int hinic3_init_irq_alloc_info(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cfg_mgmt_info *cfg_mgmt = hwdev->cfg_mgmt;
+	struct hinic3_irq *irq = cfg_mgmt->irq_info.irq;
+	u16 nreq = cfg_mgmt->irq_info.num_irq_hw;
+	struct pci_dev *pdev = hwdev->pdev;
+	int actual_irq;
+	u16 i;
+
+	actual_irq = pci_alloc_irq_vectors(pdev, 2, nreq, PCI_IRQ_MSIX);
+	if (actual_irq < 0) {
+		dev_err(hwdev->dev, "Alloc msix entries with threshold 2 failed. actual_irq: %d\n",
+			actual_irq);
+		return -ENOMEM;
+	}
+
+	nreq = actual_irq;
+	cfg_mgmt->irq_info.num_irq = nreq;
+
+	for (i = 0; i < nreq; ++i) {
+		irq[i].msix_entry_idx = i;
+		irq[i].irq_id = pci_irq_vector(pdev, i);
+		irq[i].allocated = false;
+	}
+
+	return 0;
+}
+
+int hinic3_init_cfg_mgmt(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cfg_mgmt_info *cfg_mgmt;
+	int err;
+
+	cfg_mgmt = kzalloc(sizeof(*cfg_mgmt), GFP_KERNEL);
+	if (!cfg_mgmt)
+		return -ENOMEM;
+
+	hwdev->cfg_mgmt = cfg_mgmt;
+
+	err = hinic3_init_irq_info(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init hinic3_irq_mgmt_info, err: %d\n",
+			err);
+		goto err_free_cfg_mgmt;
+	}
+
+	err = hinic3_init_irq_alloc_info(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init hinic3_irq_info, err: %d\n",
+			err);
+		goto err_free_irq_info;
+	}
+
+	return 0;
+
+err_free_irq_info:
+	kfree(cfg_mgmt->irq_info.irq);
+	cfg_mgmt->irq_info.irq = NULL;
+err_free_cfg_mgmt:
+	kfree(cfg_mgmt);
+
+	return err;
+}
+
+void hinic3_free_cfg_mgmt(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cfg_mgmt_info *cfg_mgmt = hwdev->cfg_mgmt;
+
+	pci_free_irq_vectors(hwdev->pdev);
+	kfree(cfg_mgmt->irq_info.irq);
+	cfg_mgmt->irq_info.irq = NULL;
+	kfree(cfg_mgmt);
+}
+
 int hinic3_alloc_irqs(struct hinic3_hwdev *hwdev, u16 num,
 		      struct msix_entry *alloc_arr, u16 *act_num)
 {
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
index e017b1ae9f05..5978cbd56fb2 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
@@ -42,6 +42,9 @@ struct hinic3_cfg_mgmt_info {
 	struct hinic3_dev_cap  cap;
 };
 
+int hinic3_init_cfg_mgmt(struct hinic3_hwdev *hwdev);
+void hinic3_free_cfg_mgmt(struct hinic3_hwdev *hwdev);
+
 int hinic3_alloc_irqs(struct hinic3_hwdev *hwdev, u16 num,
 		      struct msix_entry *alloc_arr, u16 *act_num);
 void hinic3_free_irq(struct hinic3_hwdev *hwdev, u32 irq_id);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
index 09e8b0dce7b3..d941b365b574 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 
+#include "hinic3_eqs.h"
 #include "hinic3_hw_comm.h"
 #include "hinic3_hwdev.h"
 #include "hinic3_hwif.h"
@@ -46,8 +47,16 @@ int hinic3_init_hwdev(struct pci_dev *pdev)
 		goto err_free_hwif;
 	}
 
+	err = hinic3_init_cfg_mgmt(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init config mgmt\n");
+		goto err_destroy_workqueue;
+	}
+
 	return 0;
 
+err_destroy_workqueue:
+	destroy_workqueue(hwdev->workq);
 err_free_hwif:
 	hinic3_free_hwif(hwdev);
 err_free_hwdev:
@@ -59,6 +68,7 @@ int hinic3_init_hwdev(struct pci_dev *pdev)
 
 void hinic3_free_hwdev(struct hinic3_hwdev *hwdev)
 {
+	hinic3_free_cfg_mgmt(hwdev);
 	destroy_workqueue(hwdev->workq);
 	hinic3_free_hwif(hwdev);
 	kfree(hwdev);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
index 90b8e211587f..f07bcab51ba5 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
@@ -144,6 +144,18 @@ static int init_hwif_attr(struct hinic3_hwdev *hwdev)
 
 	set_hwif_attr(&hwif->attr, attr0, attr1, attr2, attr3, attr6);
 
+	if (!hwif->attr.num_ceqs) {
+		dev_err(hwdev->dev, "Ceq num cfg in fw is zero\n");
+		return -EFAULT;
+	}
+
+	if (!hwif->attr.num_irqs) {
+		dev_err(hwdev->dev,
+			"Irq num cfg in fw is zero, msix_flex_en %d\n",
+			hwif->attr.msix_flex_en);
+		return -EFAULT;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
index 9f3d6af71cc8..10477fb9cc34 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
@@ -308,6 +308,7 @@ static void hinic3_func_uninit(struct pci_dev *pdev)
 {
 	struct hinic3_pcidev *pci_adapter = pci_get_drvdata(pdev);
 
+	hinic3_flush_mgmt_workq(pci_adapter->hwdev);
 	hinic3_detach_aux_devices(pci_adapter->hwdev);
 	hinic3_free_hwdev(pci_adapter->hwdev);
 }
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.c b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.c
new file mode 100644
index 000000000000..c38d10cd7fac
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
+
+#include "hinic3_eqs.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_mbox.h"
+#include "hinic3_mgmt.h"
+
+void hinic3_flush_mgmt_workq(struct hinic3_hwdev *hwdev)
+{
+	if (hwdev->aeqs)
+		flush_workqueue(hwdev->aeqs->workq);
+}
+
+void hinic3_mgmt_msg_aeqe_handler(struct hinic3_hwdev *hwdev, u8 *header,
+				  u8 size)
+{
+	if (MBOX_MSG_HEADER_GET(*(__force __le64 *)header, SOURCE) ==
+				MBOX_MSG_FROM_MBOX)
+		hinic3_mbox_func_aeqe_handler(hwdev, header, size);
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h
index 4edabeb32112..bbef3b32a6ec 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h
@@ -9,5 +9,7 @@
 struct hinic3_hwdev;
 
 void hinic3_flush_mgmt_workq(struct hinic3_hwdev *hwdev);
+void hinic3_mgmt_msg_aeqe_handler(struct hinic3_hwdev *hwdev,
+				  u8 *header, u8 size);
 
 #endif
-- 
2.43.0


