Return-Path: <netdev+bounces-233071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D8BC0BC11
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 04:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA74518A2BC8
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 03:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2182D7DD7;
	Mon, 27 Oct 2025 03:29:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F2E237713;
	Mon, 27 Oct 2025 03:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761535798; cv=none; b=UupXxr+An0wZypiV3LB+LEknvFJADIXg/UyBigPqs/tsAy8Br7+zwoHUpZfKJd4DdVOAdsJEDoJOri4cYBra4Amk7XeDJevlrnLzxJPjIfjGGj9H87ijPTLhno4IjJA+WJc/HbUhgt5xgzZyZWBq4W1vvImLhbqs6rx4NnyHn4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761535798; c=relaxed/simple;
	bh=0JJ/ovzmfSJ1jb9Vdak2WoRAgXatAloCuZPSZSQiBUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K6akyo6zvEkP0BdlEhTVr37feusb2c/edNZmoAyjm22bv98Q3crMezb8ZGYOfd58fWqKUq5atsR4Ml2M7qs9TLEFbGjSZ103x5daoEfTPaqwnK8id5WCkNWFa30r2vy2i8M1SvH2W+UryKegLeb0afSv7jmtabP5Gxyzqly8OQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz2t1761535764t6eab0f86
X-QQ-Originating-IP: J7BdTkrpzSDqmf5R7Ze+Gav7qVZe5k22TbavH0t757Q=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 27 Oct 2025 11:29:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10408304198966839365
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
Subject: [PATCH net-next v16 2/5] net: rnpgbe: Add n500/n210 chip support with BAR2 mapping
Date: Mon, 27 Oct 2025 11:29:02 +0800
Message-Id: <20251027032905.94147-3-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251027032905.94147-1-dong100@mucse.com>
References: <20251027032905.94147-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: OAj1qrjhA85Aij9gO9YcsnVsIv6K812OP5AXq8XQdF4/ngUgLJ0G8jHp
	jufCxLycAKP82CLZS9dIb8Y8z621TtE2IuZm+kto9vA6E78UThgewOQd+nE74Zd/GmR39qG
	vNsmNCgUO1AmVRRQO5dyLjnLYA40SGWldmEite0Z/CRRyX7OcerN0K8XBjBkaUOwWZrhWFK
	xFug+mJD2FDQ4egJ2avgW715boI8ofVsHMObQPK/9gfaIvyKNLUnWKdBUFcgVnByvXACSzO
	REqUsGjq7NsolMCAVGFv5Ud4BxOzO7EeozNc2vLmfvfmyeR8EvDUaOESf788McQ6frw6IiG
	sJzUNWgLsEWgovQaSC3irU0DMaj36QiPX0ATahLEUOXuuUMyfS5CP2dvBGksFl3CV3I88a+
	boM//U+ssQN6mE+EdkpKdEFyUoSTOtyRy6cPzMdpRgUe1KtFQrPgU6eeUZ+H11/uq9mi5C6
	rhqoBMxdIl3ajLM7P5yJdeWdVr5oebwjjcZceMypxnJ4YZDgrLkNqx1oAMZGpny9YIz/gRg
	ZHOJeeN4DMYHROIlvlm2/v9jc2q7xf3aQ7jLbGgLkKKDzs4oDbeISdzGjyFm2ubVv/AJhJU
	q2X1n7VjC9RH+C+tvZLe+coDwOJvb8w3a/yKjCMvISOPS/3hE8mHbWisAc3stKfhtlSESI4
	nzB3vHsU9ohcTy8Ot1jbxHExcNwK2ay0NIBVMVXRJ4XVIS6W2YTb93HojoDWxKsrPoWdx8E
	c17D1yDxrd2RKEuWuQRmB+SjQRUSYgFjBGQUmMBExRviqK4TYH9ID6EOSzqrM6+kg5/s/HO
	QqzUthoGsjq/fKw7fiM/CCKqKxMr3yvg4gb7D1YYqmveTFBZv9cs5grCV/H4IDaulFuQem4
	UJ4HXavied+OnKBEUnf/sc2zzi9GG6bNpfDL3Lhb9LN+ToPm2Tnmo5NdD8uWDHAUxwG7aUY
	VgppCTnEAaU/3coNukpB+u2LzDe2OczzHTQFtBhiaK8zYreqPTg018q4OMhl44sXSc+busO
	Vb0a1FaXSIkx3MXnQcmxFZq/xtI9g=
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


