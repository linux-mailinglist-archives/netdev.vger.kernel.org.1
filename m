Return-Path: <netdev+bounces-225118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFE1B8EB57
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 03:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A7817AD0F
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 01:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8D61A239D;
	Mon, 22 Sep 2025 01:42:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057B619994F;
	Mon, 22 Sep 2025 01:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758505320; cv=none; b=U8rIJE1yvc2jpPc2IMXxTGESTRYp/PzJW6N6N32UFI32UpBv+J/VDZKadyRE8QF4Fb4m6tZv3BuKG6isFtEY8EhvhewQ4CR9tbX3v3Kih4to04XLzUzOcl5UjEfugBPXtOrJO62fG/lYfNQ6dJXF8ig7ogG0vPB3XXT9W427mBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758505320; c=relaxed/simple;
	bh=nC4J1hBqIrwKFMXJQMbvHhsCmWSsiihfzMmHhygB0Pw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b4cQcGUEwFIwVX17zYzTrpJVmr9Y7OEzcsKPuuURABWsYBhVzgwXGqXMfm8Lkpjyg8i2JXRJLP+zXLtMbhoxempqrkJcgn7oW0gSYZ7w2aD4SrmBjg2wkgr+15eqJ5gZl603Mh290zOgxrtT44KgFst4bCOu+s40J3/QuLXOCiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz16t1758505287t7b104226
X-QQ-Originating-IP: Q0K9e8j92/1+dRiZtXV/ckWjNmX7jv/wjlu7SwhOcps=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Sep 2025 09:41:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6633516336117102325
EX-QQ-RecipientCnt: 29
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	gur.stavi@huawei.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	danishanwar@ti.com,
	lee@trager.us,
	gongfan1@huawei.com,
	lorenzo@kernel.org,
	geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com,
	richardcochran@gmail.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	rdunlap@infradead.org,
	vadim.fedorenko@linux.dev,
	joerg@jo-so.de
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v13 2/5] net: rnpgbe: Add n500/n210 chip support with BAR2 mapping
Date: Mon, 22 Sep 2025 09:41:08 +0800
Message-Id: <20250922014111.225155-3-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250922014111.225155-1-dong100@mucse.com>
References: <20250922014111.225155-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OPDR7yTiJZVRT3SsUL44SS1B80o4Z6kOZNiV/qOvsSBeko+jnTrpCKwx
	9OaQnxCQA1A6EX0xVE8NhaGXCEU1vp2h2YyCQfUw4OZS119uGL4wLWUuf9IV064PTC+cGiP
	Ce1V2Dx78ZFjFoSDkA819AYXjU6wp+CsLYvLjLNuFgcRuA38r+XPjvAPx1rQrXBh9JTAnTA
	mm/snHUG/udhE8/vUxzjCmAFU+Bsyhq1KLg3SVWIS8bF/0F1p7J4D6niZ9d1gcAyncM1I3B
	z1apql3RFOTBI/ojwmhVoV/DRx1LvjKXbvUAFesKx9c8NuS1P2aOmxnn0K8hlzr1GPgaLxw
	NfKFU+dbNLv+IOTRk7UrP7/heavgofjP3IVxCtY0496EnIFR7HEBHtBj7yDjbIRLxyxWRjx
	4AjmaFGO+eXImvlCN7LiYVW6eErEfKX+Uu5I5ihvCurlu9z553YhOCR1AU6K9MrRmY9pMJC
	NvnMzK3jv5btebe1NmQyZOekVtlfkTpc8F77OGcoOe2dIa8GWXBGMjscKISvhfS+70R93IW
	4rNv8FiJgKlBoH/wefNP7MOHlk0Lr8HojRM9yZOwTWWkMarzZzdZsffO1unAK9nrBeykdOM
	l2VPDUD7GwS/Wx9vzNDDDxFlLCXoBu9BOq2JYMCpEGMal3gByjmjLegd1e2FzB0R0WLqC9N
	AoaJVQIKVgG2i9tnNZ/NuvRnsawo/rOkff4HgxixcsocQAoci29CaTJCD6LiI6mJ8B8zE1J
	Vh6nxRKpPbjQ+zxHDbZxnUTIwEitpfdIz+wP3fJ4f4yfyNx5frJMW47o3aPPsxHsHErYPZ0
	DBRHwrIiY+jsD7pEQG0kk1QDdHZ2+SaxphusLqAYrBPdIeCmSh8peZUGc1wFaHY80qKUcGj
	dr/ToTjFSDTn9aob/dvAItJQGlQPoY8QY9N+t4Rh1tCAWOXyEbMUoeYhyHNxM+RgBYXAC9c
	5q0GrkbzsA5+mlTr4Sg7fbKdOPHoyqvJCyS9R8+5xHVY/fNWPH263T9WCpWugqAQXb+zqY4
	o4lVXENxU88tT5tf1A2HglDDc0FZ0Po7iPG8LvUnM1upPt/Fix
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Add hardware initialization foundation for MUCSE 1Gbe controller,
including:
1. Map PCI BAR2 as hardware register base;
2. Bind PCI device to driver private data (struct mucse) and
   initialize hardware context (struct mucse_hw);
3. Reserve board-specific init framework via rnpgbe_init_hw.

Signed-off-by: Dong Yibo <dong100@mucse.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 10 +++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  8 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 80 +++++++++++++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index d3439d28c654..a121ce4872a6 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -9,6 +9,16 @@ enum rnpgbe_boards {
 	board_n210
 };
 
+struct mucse_hw {
+	void __iomem *hw_addr;
+};
+
+struct mucse {
+	struct net_device *netdev;
+	struct pci_dev *pdev;
+	struct mucse_hw hw;
+};
+
 /* Device IDs */
 #define PCI_VENDOR_ID_MUCSE               0x8848
 #define RNPGBE_DEVICE_ID_N500_QUAD_PORT   0x8308
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
new file mode 100644
index 000000000000..3a779806e8be
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#ifndef _RNPGBE_HW_H
+#define _RNPGBE_HW_H
+
+#define RNPGBE_MAX_QUEUES 8
+#endif /* _RNPGBE_HW_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 2e1bf70d2fc0..0b6576c1878a 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -2,8 +2,11 @@
 /* Copyright(c) 2020 - 2025 Mucse Corporation. */
 
 #include <linux/pci.h>
+#include <net/rtnetlink.h>
+#include <linux/etherdevice.h>
 
 #include "rnpgbe.h"
+#include "rnpgbe_hw.h"
 
 static const char rnpgbe_driver_name[] = "rnpgbe";
 
@@ -21,6 +24,54 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
 	{0, },
 };
 
+/**
+ * rnpgbe_add_adapter - Add netdev for this pci_dev
+ * @pdev: PCI device information structure
+ * @board_type: board type
+ *
+ * rnpgbe_add_adapter initializes a netdev for this pci_dev
+ * structure. Initializes Bar map, private structure, and a
+ * hardware reset occur.
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+static int rnpgbe_add_adapter(struct pci_dev *pdev,
+			      int board_type)
+{
+	struct net_device *netdev;
+	void __iomem *hw_addr;
+	struct mucse *mucse;
+	struct mucse_hw *hw;
+	int err;
+
+	netdev = alloc_etherdev_mq(sizeof(struct mucse), RNPGBE_MAX_QUEUES);
+	if (!netdev)
+		return -ENOMEM;
+
+	SET_NETDEV_DEV(netdev, &pdev->dev);
+	mucse = netdev_priv(netdev);
+	mucse->netdev = netdev;
+	mucse->pdev = pdev;
+	pci_set_drvdata(pdev, mucse);
+
+	hw = &mucse->hw;
+	hw_addr = devm_ioremap(&pdev->dev,
+			       pci_resource_start(pdev, 2),
+			       pci_resource_len(pdev, 2));
+	if (!hw_addr) {
+		err = -EIO;
+		goto err_free_net;
+	}
+
+	hw->hw_addr = hw_addr;
+
+	return 0;
+
+err_free_net:
+	free_netdev(netdev);
+	return err;
+}
+
 /**
  * rnpgbe_probe - Device initialization routine
  * @pdev: PCI device information struct
@@ -33,6 +84,7 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
  **/
 static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
+	int board_type = id->driver_data;
 	int err;
 
 	err = pci_enable_device_mem(pdev);
@@ -60,6 +112,10 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_free_regions;
 	}
 
+	err = rnpgbe_add_adapter(pdev, board_type);
+	if (err)
+		goto err_free_regions;
+
 	return 0;
 err_free_regions:
 	pci_release_mem_regions(pdev);
@@ -68,6 +124,23 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return err;
 }
 
+/**
+ * rnpgbe_rm_adapter - Remove netdev for this mucse structure
+ * @pdev: PCI device information struct
+ *
+ * rnpgbe_rm_adapter remove a netdev for this mucse structure
+ **/
+static void rnpgbe_rm_adapter(struct pci_dev *pdev)
+{
+	struct mucse *mucse = pci_get_drvdata(pdev);
+	struct net_device *netdev;
+
+	if (!mucse)
+		return;
+	netdev = mucse->netdev;
+	free_netdev(netdev);
+}
+
 /**
  * rnpgbe_remove - Device removal routine
  * @pdev: PCI device information struct
@@ -79,6 +152,7 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
  **/
 static void rnpgbe_remove(struct pci_dev *pdev)
 {
+	rnpgbe_rm_adapter(pdev);
 	pci_release_mem_regions(pdev);
 	pci_disable_device(pdev);
 }
@@ -89,6 +163,12 @@ static void rnpgbe_remove(struct pci_dev *pdev)
  **/
 static void rnpgbe_dev_shutdown(struct pci_dev *pdev)
 {
+	struct mucse *mucse = pci_get_drvdata(pdev);
+	struct net_device *netdev = mucse->netdev;
+
+	rtnl_lock();
+	netif_device_detach(netdev);
+	rtnl_unlock();
 	pci_disable_device(pdev);
 }
 
-- 
2.25.1


