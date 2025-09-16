Return-Path: <netdev+bounces-223491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B39EB5952E
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 13:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CBB41BC8230
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE372D94BA;
	Tue, 16 Sep 2025 11:30:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ECC2D8779;
	Tue, 16 Sep 2025 11:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758022251; cv=none; b=DGbJkMhYuvZju0pkyT2AqlVGdvErsuBKSq0szFD7GgCq4gfOK7tFgs0fzhohYKXuoNeSHXFkqjlE9xRGRxEGhS8wVM6TN9hmDQsMb5mnqvcEgA4DLlTeDM8X6vhUcZ+ed6xcpGOTQV/5ZwPg4O88PU2qQhtEC9KVfj8jRNdqLUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758022251; c=relaxed/simple;
	bh=IbC3ZsCT/eOG9VQXgf0W2xD3H/jaZ9QReTLZcER3r0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qq8jrtTyVP5bjByae8Ia5L5cz/o4lBB38X8K0ffDj+ybCH2W/FF8Gpv6X6n4UPnERldqJWyQK3RL3z+j045l5CNjCQ8Wms/bVh1HwapSqtiw5bWNNAx/k2gm9aeFyvbKuRiiVEDjGTl90+pfnkovloErc8blKuQPV0Grk7mfQ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz17t1758022217tf7fa742c
X-QQ-Originating-IP: q6OkXb2Ki/dpCXj1w6PFIBtYVIQ2SOSS1CWTuFEQNhQ=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 16 Sep 2025 19:30:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7849755565001832494
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
Subject: [PATCH net-next v12 2/5] net: rnpgbe: Add n500/n210 chip support with BAR2 mapping
Date: Tue, 16 Sep 2025 19:29:49 +0800
Message-Id: <20250916112952.26032-3-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250916112952.26032-1-dong100@mucse.com>
References: <20250916112952.26032-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MY/4gqRZUG70yrmzalFPrECEUzCeeQUeQ3TNy0WqzUhFsqwNOF5vS2M/
	yySltSMVME8C44B+BEwcU/UqCi+JEQbvew4+wDhrfreM2yzeqJlZE1CSyUb/NOOzM9uvP0n
	Dy0didrqzbCS0/cGaIEWcOgUIHEIPj46wJjUfORnT91eHtX0f74hqO/Jqa3ow/sWz6WttS9
	FiKPKUkwisdvTff5n2hvSorV8bd4TIbnq9FNAmgdfBIMLJMZ4rLIx8ghYo1RJEjC6Ai+Hlb
	/dxpEgOHKDeNNyhVTpuoCSIB0BJiepRQzKimqnlLvPYqFf+bAgNHDiqf/QxTTiDi5yzRLoR
	A55W+1nPieI0JqqrnCO3byI5oeisRcupyL3I9SE5roP0KJunTdWmS6Z+RVdx0SZ+hxjp1jp
	L1c4ba7F7aUAu/XtQnheHtiYHxdjAckJK4lmHU0wp9ONS1GqcSnQszJgW2Fg6vau+qr3JOO
	v+s0TKvU+v4VgFvnzOuXH30r8oPTzh93H5KfEWk4b4pkEGXe55XPCpvsuCzyOmNPWz+IWMN
	CYsV5FveH7KfNmJFGMCyMOTgYnR/DE5hD/0+BZ2QncsRb5h8z/Q+wCKdOFK5syki/8Ji0Ms
	0NOZoLX4x4CGwYlX0GerVSsVndbk00K6wWR65L0sEULjO5VvyYxtoTo61U7TBeHssB25jqp
	lCuIy7W4b7qxOREDXNsUamkklmop9MTvC3pITH49aLmWq8inZGk98iA4ZXcoEMRI2Knh9/k
	VGMOiWnCRDq6CiyySf4sFaJOg2Qfugy9X76xMQ5s0eg/jqgKdCyngxc4YwhPeptru5dt5WN
	4Lv4wagazGWF7879U6QXCkJC3T2hyd8k5p7CVbOYUs7rQTEn8iA9i9gAQDEUeMOo+xsq8ZD
	ZXR7glt7kfgDWbsy0B0OL8+ryOUBtnNU8TkEnYavn/IQYsX2ih9whfr3puT/Iz7nWzfduOr
	oFdUB9ZWIGC9EXzvTWiYowVyo9QfgoUQNmWQ0rRszS3LN2ybKWAZzCFqs11v0l08j5sp5Bw
	qou293nAYc1EStAMlyDc/wmNkriNqqYdpVXF0ykA==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Add hardware initialization foundation for MUCSE 1Gbe controller,
including:
1. Map PCI BAR2 as hardware register base;
2. Bind PCI device to driver private data (struct mucse) and
   initialize hardware context (struct mucse_hw);
3. Reserve board-specific init framework via rnpgbe_init_hw.

Signed-off-by: Dong Yibo <dong100@mucse.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 10 +++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  8 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 79 +++++++++++++++++++
 3 files changed, 97 insertions(+)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 3c37fe2534a8..3b122dd508ce 100644
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
 #define PCI_VENDOR_ID_MUCSE 0x8848
 #define PCI_DEVICE_ID_N500_QUAD_PORT 0x8308
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
index 60bbc806f17b..0afe39621661 100644
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
 
@@ -25,6 +28,54 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
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
@@ -37,6 +88,7 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
  **/
 static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
+	int board_type = id->driver_data;
 	int err;
 
 	err = pci_enable_device_mem(pdev);
@@ -63,6 +115,9 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		dev_err(&pdev->dev, "pci_save_state failed %d\n", err);
 		goto err_free_regions;
 	}
+	err = rnpgbe_add_adapter(pdev, board_type);
+	if (err)
+		goto err_free_regions;
 
 	return 0;
 err_free_regions:
@@ -72,6 +127,23 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -83,6 +155,7 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
  **/
 static void rnpgbe_remove(struct pci_dev *pdev)
 {
+	rnpgbe_rm_adapter(pdev);
 	pci_release_mem_regions(pdev);
 	pci_disable_device(pdev);
 }
@@ -93,6 +166,12 @@ static void rnpgbe_remove(struct pci_dev *pdev)
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


