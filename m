Return-Path: <netdev+bounces-234809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D17C27566
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 02:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC34B1B2558A
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 01:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D3624339D;
	Sat,  1 Nov 2025 01:39:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B050241103;
	Sat,  1 Nov 2025 01:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761961197; cv=none; b=JE84Ql0tO6hFwlLf5D0+5cnfGJ3kCpfZALcIU4GNi/9ouAwknvMI8fffg/YkuMgyJ43ADOBwDYzwu52GQDYf3E0pflc7bBVltgl1HLdqtP64hN6DVce177kD759pSAcakxREKmHCiujr9wizOsNAwoFk4jWGFlk+ck5ilSy9usY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761961197; c=relaxed/simple;
	bh=0JJ/ovzmfSJ1jb9Vdak2WoRAgXatAloCuZPSZSQiBUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GdpXQEQrueK1UaeAIw0ebuNO3CIdGEj67ppPP5A57gkDtywXH1A8ZgqdWmWVBvsDlXbFI4fDOSOGAl8TBPgH+29rPjrN3aTNqlCCjcPYbM3lk4QNWwAnDPLxlqcP5Lihoz64zY4u+mEZFnbIYV0tuTLC9s4WnCbc2OT0ukpANCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz9t1761961149t5bf02ebc
X-QQ-Originating-IP: lCxtVeECq/4qItkkogW3/QyrOcFN1Ck76J7066IvL1U=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 01 Nov 2025 09:39:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9246569070979694762
EX-QQ-RecipientCnt: 17
From: Dong Yibo <dong100@mucse.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
	danishanwar@ti.com,
	vadim.fedorenko@linux.dev,
	geert+renesas@glider.be,
	mpe@ellerman.id.au,
	lorenzo@kernel.org,
	lukas.bulwahn@redhat.com
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v17 2/5] net: rnpgbe: Add n500/n210 chip support with BAR2 mapping
Date: Sat,  1 Nov 2025 09:38:46 +0800
Message-Id: <20251101013849.120565-3-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251101013849.120565-1-dong100@mucse.com>
References: <20251101013849.120565-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: OFwcIyq3IdMx57B83+VtCWjIDJabzRTY0K0jn8kN2/h+ZaTXU/tfbF0e
	QVw+KZQe8/ku9yT/2ss7gEcBazS7vuypyz22sQHirnX4ywylJb9+aZISHf2l+UOILrAH64x
	g5jh8fTK82NOP+9h8JkA1OyXOzsTfWhq12qGmIRiLLxDPnteta0rOczz5DqjDwDQY3TMymT
	aysaFTcy6JFVR+mJ3I1AO5KR6SM+w6C3T8/SoSdSUTtPG9W1XtvKwCrYKb4OM9AJ+BTN8Bq
	aTem9b/NKpkpeO4irqFy5wbVHgvN+VcnzQdwwiYcVq28FwcMCItCFd0j2VYSJdd2cg6r7a6
	nuBa2Z/v7n4nSZccE/3IIryR00vm1HBGpcH3gX5o5/PfKUcYkSFm/W0gBfIleF7kRLKfWC0
	lWv4rH7CiVAT8wZDVlyvbIwW89LZC+rsmfPXhClwWF/QEKie/UCjJMt9DRHwKMu9CYjk4LR
	8scm90mN7EYf6iAgSfx4mm2dY0OvRfSXpKyhKvAL94Xn/++eAcemMLoWuupIm6iLG0qmrJC
	28T7xb1Z3MCpUEEU7SNKcToh80AIGjTVHbj5MAb6I6OFv9o/k1Be0fYBbMhwHGqGk2QN1Xv
	HUk2tlNxWR7pGRT+KuFsma7pWQkTrzwDo6dk68mlJ5vp7cNLozgCbkfsaPtVquLbOL455w1
	igEJJ33QDWfV+UULDhs0XQi04TMejbUy9P+iOttNFss5b36UGEl4VTMm50wwI0Ho69+gViO
	++h4EYvwyg/OM9woyqyRUn6Sa0wLiOlfsDT/2pE0YiYE0O5iKa+eXusoPiWPt7mcbSUF1u2
	xyRim8rLailLNWnR4wP/vZKWSBYWbFi3E68ift7pTluXabGHcxTjrAswWtBciARyZYuuDwE
	8zQLRaUQg35zEN5dcZNUgfhtZC1zTMlUObZER2DRjxKobDdK8QEwH9pNwz2cqgwTx/v3WLu
	HEIrKm6ax/st83PcFbVU6xEaDnLMvM1clIj/rXI2QwbRkuVmIbUKA+halI4tNw2tVL6NRGq
	/aYTyFWIQTPKU0zkiLM9H1cX2F9ymgsFERJ9hFjg==
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
index 019e819fb497..305657d73e25 100644
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


