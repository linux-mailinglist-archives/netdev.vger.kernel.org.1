Return-Path: <netdev+bounces-231584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8ACBFAD7D
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 10:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3A6450663F
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 08:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6835130AAB4;
	Wed, 22 Oct 2025 08:15:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B8B307AF5;
	Wed, 22 Oct 2025 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120909; cv=none; b=RF6PLSPpgqwVUo2SkkiUrIu4Cq+CSi9f6/1VmiyrH/MDaPw2ytRtFBKKNQHLGRPyNpHwaSkHdm3w0qFCflVlL/7oKoLeKPobo+on/q19tSW0o4lVCApHynDHx0tVoOqxCzJMHsaQS+3j5aO+bvMjjtqUCdoi0VkD52NDm6nmm2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120909; c=relaxed/simple;
	bh=0JJ/ovzmfSJ1jb9Vdak2WoRAgXatAloCuZPSZSQiBUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JhCbqnPUn4ohR+khTe33lexjBWIBabfu6bRSs1BrfTyz6x+soTwl5p7BnIGLot18ZdKdLHouHvlFFhmhXlQByKJYqCbbto9g/V3qR1FvLCdroNdjw4GhxfQSlS5o+Q+ErkvlOP+hRV+ZoeN5JHUj48v/axKjQUV4fsGek0SBAOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz17t1761120850tb1eb85de
X-QQ-Originating-IP: Qnq1rIXX6wkrfS7oTX1QPvuBjBCKdt3P49Rf2PK2a3A=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 22 Oct 2025 16:14:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12093381508814799168
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
Subject: [PATCH net-next v15 2/5] net: rnpgbe: Add n500/n210 chip support with BAR2 mapping
Date: Wed, 22 Oct 2025 16:13:48 +0800
Message-Id: <20251022081351.99446-3-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251022081351.99446-1-dong100@mucse.com>
References: <20251022081351.99446-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NwIS3Zdzte8wjKFJMFA0f9Iyx6T0SGofc2bEl+tk4DZ9sVHZldW8X8eL
	j5FkUsU3pwQAdBMxl4cPDnaPOp8R9OI/p6ZdbpLSa8YnCLJEMViaoPf/lLLZpWwSa6KBMfW
	s44B+6IbK3vrygTbDsVBF2e7AUqFpxG22FOEij+Bmv9VoGnzjY/R7EYSJK9VLjk4+uhAgGQ
	tbbcLJw8qzqrVXCpo8tzin0n3hGiELYRFFfBsd4dD6/ZQI0ht2b4Plm7kGv/2DuR+ek7+uN
	vwysrjpYh/wMOCtLwKB3Hd25vCh2AQpfYN6nq6pjky0XkOTLo2uy2KPv3crFEIjxzvbjVJd
	Cy1tdY8sCIf44N8Rmoe8+cF6Dc41MJvfPrmdwRlxhUjYWK8Y+v42fBv0xj0iilICgk0/tJd
	SvboGhm/uycNpMAwwHVPJ+UgaTz1mlbcuWzmqTh5bU3p3NxVi3D0/O3a1amekLwsAv5PCTK
	470RAq5PWFdkPOJX3IRL8c0v8J5DKZjJMST/PbpjuADGN2ZVOTLutNZ6TJ2+e1ILEX1LQFZ
	766n5WnC7qRQQuOUM/HHAq/VIvNQFtJWGLSvc2oIAvw/1mD6S0qBRAnIAw7MtwK/JpzAfyr
	fQE2hr5bCEk4LTEu5x9iAFl062JNaHojCQY+l7iDRiaURE+QXLIkpCGN45f7g1Z01yubs1T
	466In6y1m57xlAAAevLKNstm5KDQcHfrtkMFRslYpLM28FQ5QTDDZf9I5lW4Jt0ndJ6ZnmV
	8YF2RiBxMYfhVlltSAdyDWHLaP/c9m2in6U0x6cxSVdJkxek5zmUn+QblhKQlpFsLlOCHp1
	Rogl77MqGLc10aJ93aHt95w+UC9VEchEmK6dzNVLWC76p6UJugHiZZokPFkj67z+bDHU9ZK
	CcXpPjMTvI0Co5JqPVmejs3HoNjsUhGkVAt8R8hHoPZGfCx4KGSWM27XdbqnYujtCmncHK3
	gHwt5I4Zs0h4sU/cRwrXf4caNr9UWPq06AwBx5bSVOJfxSkPVM955++O0uVItl3iJAd98pM
	ObCBIs3d1ZEpGSBAAn
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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


