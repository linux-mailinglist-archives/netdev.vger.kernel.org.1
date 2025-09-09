Return-Path: <netdev+bounces-221187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF07DB4F028
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 14:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2863A48AD
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 12:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A178232C317;
	Tue,  9 Sep 2025 12:09:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E9D1B78F3;
	Tue,  9 Sep 2025 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419784; cv=none; b=N3SyXwceo/rkSynFs2m/p7RgliUVjZ9bfR55EfDJTp3fg9Vdfdxr056UoOG5Bbppia5g5bQ0Yub7x8CDMq5ISTBUFGewUhJ95iWOfqOwCxZShwcajLEfxgATL/0ujgWWDOcfVn881yLh+55mUtCAv8jQA6vwSHrBQMCKzaAYT78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419784; c=relaxed/simple;
	bh=GaMsjjnsCrxG1jnK6+i13sqfkbQKOcsDVn4n1S6j6uI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VS2AhUH+VyG2AnBKhCGszMgyKaJkIqX9VAZ3MZKqmsI4lVwPw+3P33fXekdCKl2V41E0khwU1Vzfmw1/1/xhKAgmzVmpQVKLhOhcS0544V6HECYj7UT4MbThWRX3euljYkw1JqAjx8MxWBctTrqB20Sz4EBDYqZqfjzLCtD864A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz6t1757419764tc459fa02
X-QQ-Originating-IP: +ZpL/WanXej060O0qZvysoRwPVHC5Q6zsOTH/B2nD5E=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 09 Sep 2025 20:09:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17648290205751983736
EX-QQ-RecipientCnt: 28
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
	vadim.fedorenko@linux.dev
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v11 2/5] net: rnpgbe: Add n500/n210 chip support with BAR2 mapping
Date: Tue,  9 Sep 2025 20:09:03 +0800
Message-Id: <20250909120906.1781444-3-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250909120906.1781444-1-dong100@mucse.com>
References: <20250909120906.1781444-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MQZ/dZQlO/THfcA9T3Al8bsUPS+kA1cwHW/NRHWo7yMgdY17PT4pm6zE
	9H5L3l9ZDyW3qaJ/QFajDStXnEhCwJ6eB7BRU1OhrM/p+M7dh6MdWG5wtua1LdC6WbFzBNp
	tu4g+GzYzpSqmpLr45M6ydGANSsEN3/xFX9iw1xStb9YbjuK+cee9qiLj0avzPRLtw1YP5l
	GFNPgRWgYeAPUHZ0jEgFuEMClMOrmoty+RLxb8W58iHq9v6x1IRP0BXqeAZOMYKtVa+fJON
	NjD6Dg48obb0Y257J0M2nQyomwKCiwNjcksvsEOVwMWRQQQcbPgGYzbXuVdTB/q2k0cJumA
	P9YpLTdmDUYXBYi/2uHKlPH7NXmUiNIRG5fCqH748OVjKX7n9uqGLhvNKmBMJUhJrst81Up
	S2rzrS8E4Tbj1D4izViXxwXHeq219I5ysKgJaHDDfzhndcvl57jm2BhkbffkShG2psm95pq
	JVdTXAs3BZP/b3wp/BK1EzwVIKH6rT1y/yMhG3zp8zlKZb/qZxg8S2M8iU9661JfAx0+EHq
	pqTswWeG6T93Jlzp9rUxOFDxr7n2I0Iv75vue6Zp2WwnEXgMemFzf+vyJrdI9sTLksJjyjF
	4r9Az97XQqJ1sDhr1bxJy7zuX8KgRx6UI5xFz6E44SuW1Ksm3A5Y2WQnGSzezxdIAu+Jt14
	/QVfVzfbtR5XNe205PTNlK7NRcLmQmPqLoEBqwQgGS6AtvuonFdtC0Q8XaI/SfMUeKOIsWy
	WsBqz2An/zwHm4x2BNhOK1NXWvlxiAXNbpWgmKRZU2vDAOQOAV59cl1ansNSVyFPGlCsoBT
	BUCEbSGKWn36sQ43LEgeNULLXuy05nLp+A+/3+pWqUVBMJC3I0WcEeuTcaROlfxTFfhshwQ
	td2zosWd35/ZO2IOjc3jEucjvAHqXUsqwMfU0BEjBTUWWrrIpWRRRlr6AJ5+5UVDi347aF2
	mHEC5URNOZg2O1GA+BmBjnWZF/yp5J7miuB9co4mVFTiyIy+7IB4fynOl6QmLuBu22EPpFO
	cwOK2sACh6wHc1FdM5
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Add hardware initialization foundation for MUCSE 1Gbe controller,
including:
1. Map PCI BAR2 as hardware register base;
2. Bind PCI device to driver private data (struct mucse) and
   initialize hardware context (struct mucse_hw);
3. Reserve board-specific init framework via rnpgbe_init_hw.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 10 +++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  9 +++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 79 +++++++++++++++++++
 3 files changed, 98 insertions(+)
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
index 000000000000..1a0b22d651b9
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#ifndef _RNPGBE_HW_H
+#define _RNPGBE_HW_H
+
+/**************** CHIP Resource ****************************/
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


