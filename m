Return-Path: <netdev+bounces-146565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A68D49D4594
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 02:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04FF91F2220B
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 01:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52426139D1E;
	Thu, 21 Nov 2024 01:53:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com [115.124.28.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2580663A9;
	Thu, 21 Nov 2024 01:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732153997; cv=none; b=ZQKYVpl5CZvQDJxunDzd6bkjtwU60QK9vKOWGzJIrZMEQJ0fRPKg9+yTq5EPKhZW+2lQ6n50ZmtSnvd4+PQs3ZeyfJAadugfrF2GoTyyisfBwqcYvndbFkh4AAXne2EhdK3165F1QlNzjGsjC35fXmJhAYEVNkjZxkIOscKLCLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732153997; c=relaxed/simple;
	bh=j/p/HssU2JnZI9zAiuBv2XdhpX2DpdWx0czp3mpWJdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IaG8FsN/DNm8WLvVAYbBMwzevZaaUyNjQz348bMkZtFloKDD+cmo7ehArgQikyVbUy3u3j2gzvDVHD5eEzZ0OpMiNScZsJo2YllbFFGnvLKkAgRISUyaR88DeYgwCt4cVAY35tJTGETHhUZqxDWnDQbSdHe6a6jQ7GyVgbncf5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.aGmppTi_1732100199 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 20 Nov 2024 18:56:39 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com,
	Frank.Sae@motor-comm.com
Subject: [PATCH net-next v2 01/21] motorcomm:yt6801: Add support for a pci table in this module
Date: Thu, 21 Nov 2024 09:53:09 +0800
Message-Id: <20241120105625.22508-2-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for a pci table in this module, and implement pci_driver
function to initialize this driver, or remove this driver.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../ethernet/motorcomm/yt6801/yt6801_pci.c    |  104 ++
 .../ethernet/motorcomm/yt6801/yt6801_type.h   | 1398 +++++++++++++++++
 2 files changed, 1502 insertions(+)
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c
new file mode 100644
index 000000000..c93698586
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology Co.,Ltd. */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#ifdef CONFIG_PCI_MSI
+#include <linux/pci.h>
+#endif
+
+static int fxgmac_probe(struct pci_dev *pcidev, const struct pci_device_id *id)
+{
+	struct device *dev = &pcidev->dev;
+	struct fxgmac_resources res;
+	int i, ret;
+
+	ret = pcim_enable_device(pcidev);
+	if (ret) {
+		dev_err(dev, "%s pcim_enable_device err:%d\n", __func__, ret);
+		return ret;
+	}
+
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+		if (pci_resource_len(pcidev, i) == 0)
+			continue;
+
+		ret = pcim_iomap_regions(pcidev, BIT(i), FXGMAC_DRV_NAME);
+		if (ret) {
+			dev_err(dev, "%s, pcim_iomap_regions err:%d\n",
+				__func__, ret);
+			return ret;
+		}
+		break;
+	}
+
+	pci_set_master(pcidev);
+
+	memset(&res, 0, sizeof(res));
+	res.irq = pcidev->irq;
+	res.addr = pcim_iomap_table(pcidev)[i];
+
+	return fxgmac_drv_probe(&pcidev->dev, &res);
+}
+
+static void fxgmac_remove(struct pci_dev *pcidev)
+{
+	struct fxgmac_pdata *pdata = dev_get_drvdata(&pcidev->dev);
+	struct net_device *netdev = pdata->netdev;
+	struct device *dev = &pcidev->dev;
+
+	unregister_netdev(netdev);
+	pdata->hw_ops.reset_phy(pdata);
+	free_netdev(netdev);
+
+#ifdef CONFIG_PCI_MSI
+	if (FIELD_GET(FXGMAC_FLAG_MSIX_ENABLED, pdata->int_flags)) {
+		pci_disable_msix(pcidev);
+		kfree(pdata->msix_entries);
+		pdata->msix_entries = NULL;
+	}
+#endif
+
+	dev_dbg(dev, "%s has been removed\n", netdev->name);
+}
+
+static int __fxgmac_shutdown(struct pci_dev *pcidev, bool *wake_en)
+{
+	struct fxgmac_pdata *pdata = dev_get_drvdata(&pcidev->dev);
+	struct net_device *netdev = pdata->netdev;
+
+	rtnl_lock();
+	fxgmac_net_powerdown(pdata, !!pdata->wol);
+	if (wake_en)
+		*wake_en = !!pdata->wol;
+
+	netif_device_detach(netdev);
+	rtnl_unlock();
+
+	return 0;
+}
+
+#define MOTORCOMM_PCI_ID			0x1f0a
+#define YT6801_PCI_DEVICE_ID			0x6801
+
+static const struct pci_device_id fxgmac_pci_tbl[] = {
+	{ PCI_DEVICE(MOTORCOMM_PCI_ID, YT6801_PCI_DEVICE_ID) },
+	{ 0 }
+};
+
+MODULE_DEVICE_TABLE(pci, fxgmac_pci_tbl);
+
+static struct pci_driver fxgmac_pci_driver = {
+	.name		= FXGMAC_DRV_NAME,
+	.id_table	= fxgmac_pci_tbl,
+	.probe		= fxgmac_probe,
+	.remove		= fxgmac_remove,
+};
+
+module_pci_driver(fxgmac_pci_driver);
+
+MODULE_DESCRIPTION(FXGMAC_DRV_DESC);
+MODULE_VERSION(FXGMAC_DRV_VERSION);
+MODULE_AUTHOR("Motorcomm Electronic Tech. Co., Ltd.");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h b/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h
new file mode 100644
index 000000000..50a29579d
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h
@@ -0,0 +1,1398 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology Co.,Ltd. */
+
+#ifndef YT6801_TYPE_H
+#define YT6801_TYPE_H
+
+#include <linux/netdevice.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/mii.h>
+
+/****************  Other configuration register. *********************/
+#define GLOBAL_CTRL0					0x1000
+
+#define EPHY_CTRL					0x1004
+#define EPHY_CTRL_RESET_POS				0
+#define EPHY_CTRL_RESET_LEN				1
+#define  EPHY_CTRL_STA_RESET				(0 << 0)
+#define  EPHY_CTRL_STA_RELEASE				BIT(0)
+#define EPHY_CTRL_STA_LINKUP_POS			1
+#define EPHY_CTRL_STA_LINKUP_LEN			1
+#define  EPHY_CTRL_STA_LINKDOWN				(0 << 1)
+#define  EPHY_CTRL_STA_LINKUP				BIT(1)
+#define EPHY_CTRL_STA_DUPLEX_POS			2
+#define EPHY_CTRL_STA_DUPLEX_LEN			1
+#define EPHY_CTRL_STA_SPEED_POS				3
+#define EPHY_CTRL_STA_SPEED_LEN				2
+
+#define WOL_CTRL					0x100c
+#define WOL_LINKCHG_EN_POS				0
+#define WOL_LINKCHG_EN_LEN				1
+#define WOL_PKT_EN_POS					1
+#define WOL_PKT_EN_LEN					1
+#define WOL_WAIT_TIME_POS				2
+#define WOL_WAIT_TIME_LEN				13
+
+#define OOB_WOL_CTRL					0x1010
+#define OOB_WOL_CTRL_DIS_POS				0
+#define OOB_WOL_CTRL_DIS_LEN				1
+
+/* RSS implementation registers */
+
+/* 10 RSS key registers */
+#define MGMT_RSS_KEY0					0x1020
+#define MGMT_RSS_KEY9					0x1044
+#define MGMT_RSS_KEY_INC				0x4
+
+/* RSS control register */
+#define MGMT_RSS_CTRL					0x1048
+#define MGMT_RSS_CTRL_OPT_POS				0
+#define MGMT_RSS_CTRL_OPT_LEN				8
+#define  MGMT_RSS_CTRL_IPV4_EN				0x01
+#define  MGMT_RSS_CTRL_TCPV4_EN				0x02
+#define  MGMT_RSS_CTRL_UDPV4_EN				0x04
+#define  MGMT_RSS_CTRL_IPV6_EN				0x08
+#define  MGMT_RSS_CTRL_TCPV6_EN				0x10
+#define  MGMT_RSS_CTRL_UDPV6_EN				0x20
+#define  MGMT_RSS_CTRL_OPT_MASK				0xff
+#define MGMT_RSS_CTRL_DEFAULT_Q_POS			8
+#define MGMT_RSS_CTRL_DEFAULT_Q_LEN			2
+#define  MGMT_RSS_CTRL_DEFAULT_Q_MASK			0x3
+#define MGMT_RSS_CTRL_TBL_SIZE_POS			10
+#define MGMT_RSS_CTRL_TBL_SIZE_LEN			3
+#define  MGMT_RSS_CTRL_TBL_SIZE_MASK			0x7
+#define MGMT_RSS_CTRL_RSSE_POS				31
+#define MGMT_RSS_CTRL_RSSE_LEN				1
+
+/* rss indirection table (IDT) */
+#define MGMT_RSS_IDT					0x1050
+/* b0:1 entry0
+ * b2:3 entry1
+ * ...
+ */
+#define MGMT_RSS_IDT_INC				4
+#define MGMT_RSS_IDT_ENTRY_SIZE				16
+#define MGMT_RSS_IDT_ENTRY_MASK				0x3
+
+/* MAC management registers bit positions and sizes */
+#define MGMT_INT_CTRL0					0x1100
+#define MGMT_INT_CTRL0_INT_STATUS_POS			0
+#define MGMT_INT_CTRL0_INT_STATUS_LEN			16
+#define  MGMT_INT_CTRL0_INT_STATUS_RX			0x000f
+#define  MGMT_INT_CTRL0_INT_STATUS_TX			0x0010
+#define  MGMT_INT_CTRL0_INT_STATUS_MISC			0x0020
+#define  MGMT_INT_CTRL0_INT_STATUS_MASK			0xffff
+
+#define MGMT_INT_CTRL0_INT_MASK_POS			16
+#define MGMT_INT_CTRL0_INT_MASK_LEN			16
+#define  MGMT_INT_CTRL0_INT_MASK_RXCH			0x000f
+#define  MGMT_INT_CTRL0_INT_MASK_TXCH			0x0010
+#define  MGMT_INT_CTRL0_INT_MASK_EX_PMT			0xf7ff
+#define  MGMT_INT_CTRL0_INT_MASK_DISABLE		0xf000
+#define  MGMT_INT_CTRL0_INT_MASK_MASK			0xffff
+
+/* Interrupt Ctrl1 */
+#define INT_CTRL1				0x1104
+#define INT_CTRL1_TMR_CNT_CFG_MAX_POS		0
+#define INT_CTRL1_TMR_CNT_CFG_MAX_LEN		10
+#define INT_CTRL1_MSI_AIO_EN_POS		16
+#define INT_CTRL1_MSI_AIO_EN_LEN		1
+
+/* Interrupt Moderation */
+#define INT_MOD					0x1108
+#define INT_MOD_RX_POS				0
+#define INT_MOD_RX_LEN				12
+#define  INT_MOD_200_US				200
+#define INT_MOD_TX_POS				16
+#define INT_MOD_TX_LEN				12
+
+/* LTR latency message, only for SW enable. */
+#define LTR_CTRL1				0x1134
+#define LTR_CTRL1_LTR_MSG_POS			0
+#define LTR_CTRL1_LTR_MSG_LEN			32
+
+#define LTR_CTRL2				0x1138
+#define LTR_CTRL2_DBG_DATA_POS			0
+#define LTR_CTRL2_DBG_DATA_LEN			32
+
+/* LTR_CTRL3, LTR latency message, only for System IDLE Start. */
+#define LTR_IDLE_ENTER				0x113c
+#define LTR_IDLE_ENTER_POS			0
+#define LTR_IDLE_ENTER_LEN			10
+#define  LTR_IDLE_ENTER_900_US			900
+#define LTR_IDLE_ENTER_SCALE_POS		10
+#define LTR_IDLE_ENTER_SCALE_LEN		5
+#define  LTR_IDLE_ENTER_SCALE_1_NS		0
+#define  LTR_IDLE_ENTER_SCALE_32_NS		1
+#define  LTR_IDLE_ENTER_SCALE_1024_NS		2
+#define  LTR_IDLE_ENTER_SCALE_32768_NS		3
+#define  LTR_IDLE_ENTER_SCALE_1048576_NS	4
+#define  LTR_IDLE_ENTER_SCALE_33554432_NS	5
+#define LTR_IDLE_ENTER_REQUIRE_POS		15
+#define LTR_IDLE_ENTER_REQUIRE_LEN		1
+#define  LTR_IDLE_ENTER_REQUIRE			1
+
+/* LTR_CTRL4, LTR latency message, only for System IDLE End. */
+#define LTR_IDLE_EXIT				0x1140
+#define LTR_IDLE_EXIT_POS			0
+#define LTR_IDLE_EXIT_LEN			10
+#define  LTR_IDLE_EXIT_171_US			171
+#define LTR_IDLE_EXIT_SCALE_POS			10
+#define LTR_IDLE_EXIT_SCALE_LEN			5
+#define  LTR_IDLE_EXIT_SCALE			2
+#define LTR_IDLE_EXIT_REQUIRE_POS		15
+#define LTR_IDLE_EXIT_REQUIRE_LEN		1
+#define  LTR_IDLE_EXIT_REQUIRE			1
+
+/* Osc_ctrl */
+#define MGMT_XST_OSC_CTRL			 0x1158
+#define MGMT_XST_OSC_CTRL_EN_XST_POS		0
+#define MGMT_XST_OSC_CTRL_EN_XST_LEN		1
+#define MGMT_XST_OSC_CTRL_EN_OSC_POS		1
+#define MGMT_XST_OSC_CTRL_EN_OSC_LEN		1
+#define MGMT_XST_OSC_CTRL_XST_OSC_SEL_POS	2
+#define MGMT_XST_OSC_CTRL_XST_OSC_SEL_LEN	1
+
+#define MGMT_WPI_CTRL0				0x1160
+#define MGMT_WPI_CTRL0_WPI_MODE_POS		0
+#define MGMT_WPI_CTRL0_WPI_MODE_LEN		2
+#define  MGMT_WPI_CTRL0_WPI_MODE_NORMAL		0x00
+#define  MGMT_WPI_CTRL0_WPI_MODE_WR		0x01
+#define  MGMT_WPI_CTRL0_WPI_MODE_RD		0x02
+#define  MGMT_WPI_CTRL0_RAM_OP_DONE		0x04
+#define  MGMT_WPI_CTRL0_WPI_OP_DONE		0x08
+#define MGMT_WPI_CTRL0_WPI_PKT_LEN_POS		4
+#define MGMT_WPI_CTRL0_WPI_PKT_LEN_LEN		14
+#define MGMT_WPI_CTRL0_WPI_FAIL			BIT(31)
+
+#define MGMT_WPI_CTRL1_DATA			0x1164
+
+#define LPW_CTRL				0x1188
+#define LPW_CTRL_ASPM_LPW_EN_POS		9
+#define LPW_CTRL_ASPM_LPW_EN_LEN		1
+
+#define MSIX_TBL_MASK				0x120c
+
+/* msi table */
+#define MSI_ID_RXQ0				0
+#define MSI_ID_RXQ1				1
+#define MSI_ID_RXQ2				2
+#define MSI_ID_RXQ3				3
+#define MSI_ID_TXQ0				4
+#define MSI_ID_PHY_OTHER			5
+#define MSIX_TBL_RXTX_NUM			5
+#define MSIX_TBL_MAX_NUM			6
+
+#define MSI_PBA					0x1300
+
+#define EFUSE_OP_CTRL_0				0x1500
+#define EFUSE_OP_MODE_POS			0
+#define EFUSE_OP_MODE_LEN			2
+#define  EFUSE_OP_MODE_ROW_WRITE		0x0
+#define  EFUSE_OP_MODE_ROW_READ			0x1
+#define  EFUSE_OP_MODE_AUTO_LOAD		0x2
+#define  EFUSE_OP_MODE_READ_BLANK		0x3
+#define EFUSE_OP_START_POS			2
+#define EFUSE_OP_START_LEN			1
+#define EFUSE_OP_ADDR_POS			8
+#define EFUSE_OP_ADDR_LEN			8
+#define EFUSE_OP_WR_DATA_POS			16
+#define EFUSE_OP_WR_DATA_LEN			8
+
+#define EFUSE_OP_CTRL_1				0x1504
+#define EFUSE_OP_DONE_POS			1
+#define EFUSE_OP_DONE_LEN			1
+#define EFUSE_OP_PGM_PASS_POS			2
+#define EFUSE_OP_PGM_PASS_LEN			1
+#define EFUSE_OP_BIST_ERR_CNT_POS		8
+#define EFUSE_OP_BIST_ERR_CNT_LEN		8
+#define EFUSE_OP_BIST_ERR_ADDR_POS		16
+#define EFUSE_OP_BIST_ERR_ADDR_LEN		8
+#define EFUSE_OP_RD_DATA_POS			24
+#define EFUSE_OP_RD_DATA_LEN			8
+
+/* MAC addr can be configured through effuse */
+#define MACA0LR_FROM_EFUSE			0x1520
+#define MACA0HR_FROM_EFUSE			0x1524
+
+#define SYS_RESET				0x152c
+#define SYS_RESET_POS				31
+#define SYS_RESET_LEN				1
+
+#define EFUSE_LED_ADDR				0x00
+#define EFUSE_LED_POS				0
+#define EFUSE_LED_LEN				5
+#define EFUSE_OOB_ADDR				0x07
+#define EFUSE_OOB_POS				2
+#define EFUSE_OOB_LEN				1
+
+#define MGMT_WOL_CTRL				0x1530
+#define MGMT_WOL_CTRL_WPI_LINK_CHG		BIT(0) /* Waken by link-change */
+#define MGMT_WOL_CTRL_WPI_MGC_PKT		BIT(1) /* Waken by magic-packet */
+#define MGMT_WOL_CTRL_WPI_RWK_PKT		BIT(2) /* Waken by remote patten packet */
+#define MGMT_WOL_CTRL_WPI_RWK_PKT_NUMBER	BIT(16)
+
+#define MGMT_SIGDET				0x17f8
+#define MGMT_SIGDET_POS				13
+#define MGMT_SIGDET_LEN				3
+#define  MGMT_SIGDET_20MV			0
+#define  MGMT_SIGDET_25MV			1
+#define  MGMT_SIGDET_30MV			2
+#define  MGMT_SIGDET_35MV			3
+#define  MGMT_SIGDET_40MV			4
+#define  MGMT_SIGDET_45MV			5 /* default value */
+#define  MGMT_SIGDET_50MV			6
+#define  MGMT_SIGDET_55MV			7
+
+#define PCIE_SERDES_PLL				0x199c
+#define PCIE_SERDES_PLL_AUTOOFF_POS		0
+#define PCIE_SERDES_PLL_AUTOOFF_LEN		1
+
+#define NS_OF_GLB_CTL				0x1B00
+
+#define NS_TPID_PRO				0x1B04
+#define NS_TPID_PRO_CTPID_POS			0
+#define NS_TPID_PRO_CTPID_LEN			16
+#define NS_TPID_PRO_STPID_POS			16
+#define NS_TPID_PRO_STPID_LEN			16
+
+#define NS_LUT_ROMOTE0				0x1B08
+#define NS_LUT_ROMOTE1				0X1B0C
+#define NS_LUT_ROMOTE2				0X1B10
+#define NS_LUT_ROMOTE3				0X1B14
+#define NS_LUT_TARGET0				0X1B18
+#define NS_LUT_TARGET1				0X1B1C
+#define NS_LUT_TARGET2				0X1B20
+#define NS_LUT_TARGET3				0X1B24
+#define NS_LUT_SOLICITED0			0X1B28
+#define NS_LUT_SOLICITED1			0X1B2C
+#define NS_LUT_SOLICITED2			0X1B30
+#define NS_LUT_SOLICITED3			0X1B34
+#define NS_LUT_MAC_ADDR				0X1B38
+#define NS_LUT_MAC_ADDR_CTL			0X1B3C
+#define NS_LUT_MAC_ADDR_LOW_POS			0
+#define NS_LUT_MAC_ADDR_LOW_LEN			16
+#define NS_LUT_TARGET_ISANY_POS			16
+#define NS_LUT_TARGET_ISANY_LEN			1
+#define NS_LUT_REMOTE_AWARED_POS		17
+#define NS_LUT_REMOTE_AWARED_LEN		1
+#define NS_LUT_DST_IGNORED_POS			18
+#define NS_LUT_DST_IGNORED_LEN			1
+#define NS_LUT_DST_CMP_TYPE_POS			19
+#define NS_LUT_DST_CMP_TYPE_LEN			1
+#define NS_LUT_REMOTE_AWARED_POS		17
+#define NS_LUT_REMOTE_AWARED_LEN		1
+#define NS_LUT_DST_IGNORED_POS			18
+#define NS_LUT_DST_IGNORED_LEN			1
+#define NS_LUT_DST_CMP_TYPE_POS			19
+#define NS_LUT_DST_CMP_TYPE_LEN			1
+
+#define NS_LUT_TARGET4				0X1B78
+#define NS_LUT_TARGET5				0X1B7c
+#define NS_LUT_TARGET6				0X1B80
+#define NS_LUT_TARGET7				0X1B84
+
+/****************  GMAC register. *********************/
+/* MAC register offsets */
+#define MAC_OFFSET			0x2000
+#define MAC_CR				0x0000
+#define MAC_ECR				0x0004
+#define MAC_PFR				0x0008
+#define MAC_WTR				0x000c
+#define MAC_HTR0			0x0010
+#define MAC_VLANTR			0x0050
+#define MAC_VLANHTR			0x0058
+#define MAC_VLANIR			0x0060
+#define MAC_IVLANIR			0x0064
+#define MAC_Q0TFCR			0x0070
+#define MAC_RFCR			0x0090
+#define MAC_RQC0R			0x00a0
+#define MAC_RQC1R			0x00a4
+#define MAC_RQC2R			0x00a8
+#define MAC_RQC3R			0x00ac
+#define MAC_ISR				0x00b0
+#define MAC_IER				0x00b4
+#define MAC_TX_RX_STA			0x00b8
+#define MAC_PMT_STA			0x00c0
+#define MAC_RWK_PAC			0x00c4
+#define MAC_LPI_STA			0x00d0
+#define MAC_LPI_CONTROL			0x00d4
+#define MAC_LPI_TIMER			0x00d8
+#define MAC_MS_TIC_COUNTER		0x00dc
+#define MAC_AN_CR			0x00e0
+#define MAC_AN_SR			0x00e4
+#define MAC_AN_ADV			0x00e8
+#define MAC_AN_LPA			0x00ec
+#define MAC_AN_EXP			0x00f0
+#define MAC_PHYIF_STA			0x00f8
+#define MAC_VR				0x0110
+#define MAC_DBG_STA			0x0114
+#define MAC_HWF0R			0x011c
+#define MAC_HWF1R			0x0120
+#define MAC_HWF2R			0x0124
+#define MAC_HWF3R			0x0128
+#define MAC_MDIO_ADDRESS		0x0200
+#define MAC_MDIO_DATA			0x0204
+#define MAC_GPIOCR			0x0208
+#define MAC_GPIO_SR			0x020c
+#define MAC_ARP_PROTO_ADDR		0x0210
+#define MAC_CSR_SW_CTRL			0x0230
+#define MAC_MACA0HR			0x0300
+#define MAC_MACA0LR			0x0304
+#define MAC_MACA1HR			0x0308
+#define MAC_MACA1LR			0x030c
+
+#define MAC_QTFCR_INC			4
+#define MAC_MACA_INC			4
+#define MAC_HTR_INC			4
+#define MAC_RQC2_INC			4
+#define MAC_RQC2_Q_PER_REG		4
+
+/* MAC register entry bit positions and sizes */
+#define MAC_HWF0R_ADDMACADRSEL_POS	18
+#define MAC_HWF0R_ADDMACADRSEL_LEN	5
+#define MAC_HWF0R_ARPOFFSEL_POS		9
+#define MAC_HWF0R_ARPOFFSEL_LEN		1
+#define MAC_HWF0R_EEESEL_POS		13
+#define MAC_HWF0R_EEESEL_LEN		1
+#define MAC_HWF0R_ACTPHYIFSEL_POS	28
+#define MAC_HWF0R_ACTPHYIFSEL_LEN	3
+#define MAC_HWF0R_MGKSEL_POS		7
+#define MAC_HWF0R_MGKSEL_LEN		1
+#define MAC_HWF0R_MMCSEL_POS		8
+#define MAC_HWF0R_MMCSEL_LEN		1
+#define MAC_HWF0R_RWKSEL_POS		6
+#define MAC_HWF0R_RWKSEL_LEN		1
+#define MAC_HWF0R_RXCOESEL_POS		16
+#define MAC_HWF0R_RXCOESEL_LEN		1
+#define MAC_HWF0R_SAVLANINS_POS		27
+#define MAC_HWF0R_SAVLANINS_LEN		1
+#define MAC_HWF0R_SMASEL_POS		5
+#define MAC_HWF0R_SMASEL_LEN		1
+#define MAC_HWF0R_TSSEL_POS		12
+#define MAC_HWF0R_TSSEL_LEN		1
+#define MAC_HWF0R_TSSTSSEL_POS		25
+#define MAC_HWF0R_TSSTSSEL_LEN		2
+#define MAC_HWF0R_TXCOESEL_POS		14
+#define MAC_HWF0R_TXCOESEL_LEN		1
+#define MAC_HWF0R_VLHASH_POS		4
+#define MAC_HWF0R_VLHASH_LEN		1
+#define MAC_HWF1R_ADDR64_POS		14
+#define MAC_HWF1R_ADDR64_LEN		2
+#define MAC_HWF1R_ADVTHWORD_POS		13
+#define MAC_HWF1R_ADVTHWORD_LEN		1
+#define MAC_HWF1R_DBGMEMA_POS		19
+#define MAC_HWF1R_DBGMEMA_LEN		1
+#define MAC_HWF1R_DCBEN_POS		16
+#define MAC_HWF1R_DCBEN_LEN		1
+#define MAC_HWF1R_HASHTBLSZ_POS		24
+#define MAC_HWF1R_HASHTBLSZ_LEN		2
+#define MAC_HWF1R_L3L4FNUM_POS		27
+#define MAC_HWF1R_L3L4FNUM_LEN		4
+#define MAC_HWF1R_RAVSEL_POS		21
+#define MAC_HWF1R_RAVSEL_LEN		1
+#define MAC_HWF1R_AVSEL_POS		20
+#define MAC_HWF1R_AVSEL_LEN		1
+#define MAC_HWF1R_RXFIFOSIZE_POS	0
+#define MAC_HWF1R_RXFIFOSIZE_LEN	5
+#define MAC_HWF1R_SPHEN_POS		17
+#define MAC_HWF1R_SPHEN_LEN		1
+#define MAC_HWF1R_TSOEN_POS		18
+#define MAC_HWF1R_TSOEN_LEN		1
+#define MAC_HWF1R_TXFIFOSIZE_POS	6
+#define MAC_HWF1R_TXFIFOSIZE_LEN	5
+#define MAC_HWF2R_AUXSNAPNUM_POS	28
+#define MAC_HWF2R_AUXSNAPNUM_LEN	3
+#define MAC_HWF2R_PPSOUTNUM_POS		24
+#define MAC_HWF2R_PPSOUTNUM_LEN		3
+#define MAC_HWF2R_RXCHCNT_POS		12
+#define MAC_HWF2R_RXCHCNT_LEN		4
+#define MAC_HWF2R_RXQCNT_POS		0
+#define MAC_HWF2R_RXQCNT_LEN		4
+#define MAC_HWF2R_TXCHCNT_POS		18
+#define MAC_HWF2R_TXCHCNT_LEN		4
+#define MAC_HWF2R_TXQCNT_POS		6
+#define MAC_HWF2R_TXQCNT_LEN		4
+#define MAC_IER_TSIE_POS		12
+#define MAC_IER_TSIE_LEN		1
+
+#define MAC_ISR_PHYIF_STA_POS		0
+#define MAC_ISR_AN_SR0_POS		1
+#define MAC_ISR_AN_SR1_POS		2
+#define MAC_ISR_AN_SR2_POS		3
+#define MAC_ISR_PMT_STA_POS		4
+#define MAC_ISR_LPI_STA_POS		5
+#define MAC_ISR_MMC_STA_POS		8
+#define MAC_ISR_RX_MMC_STA_POS		9
+#define MAC_ISR_TX_MMC_STA_POS		10
+#define MAC_ISR_IPCRXINT_POS		11
+#define MAC_ISR_TX_RX_STA0_POS		13
+#define MAC_ISR_TSIS_POS		12
+#define MAC_ISR_TX_RX_STA1_POS		14
+#define MAC_ISR_GPIO_SR_POS		15
+
+#define MAC_MACA1HR_AE_POS		31
+#define MAC_MACA1HR_AE_LEN		1
+#define MAC_PFR_HMC_POS			2
+#define MAC_PFR_HMC_LEN			1
+#define MAC_PFR_HPF_POS			10
+#define MAC_PFR_HPF_LEN			1
+#define MAC_PFR_PM_POS			4 /* Pass all Multicast. */
+#define MAC_PFR_PM_LEN			1
+#define MAC_PFR_DBF_POS			5 /* Disable Broadcast Packets. */
+#define MAC_PFR_DBF_LEN			1
+
+/* Hash Unicast. 0x0 (DISABLE). compares the DA field with the values
+ * programmed in DA registers.
+ */
+#define MAC_PFR_HUC_POS			1
+#define MAC_PFR_HUC_LEN			1
+#define MAC_PFR_PR_POS			0 /* Enable Promiscuous Mode. */
+#define MAC_PFR_PR_LEN			1
+#define MAC_PFR_VTFE_POS		16
+#define MAC_PFR_VTFE_LEN		1
+#define MAC_Q0TFCR_PT_POS		16
+#define MAC_Q0TFCR_PT_LEN		16
+#define MAC_Q0TFCR_TFE_POS		1
+#define MAC_Q0TFCR_TFE_LEN		1
+#define MAC_CR_ARPEN_POS		31
+#define MAC_CR_ARPEN_LEN		1
+#define MAC_CR_ACS_POS			20
+#define MAC_CR_ACS_LEN			1
+#define MAC_CR_CST_POS			21
+#define MAC_CR_CST_LEN			1
+#define MAC_CR_IPC_POS			27
+#define MAC_CR_IPC_LEN			1
+#define MAC_CR_JE_POS			16
+#define MAC_CR_JE_LEN			1
+#define MAC_CR_LM_POS			12
+#define MAC_CR_LM_LEN			1
+#define MAC_CR_RE_POS			0
+#define MAC_CR_RE_LEN			1
+#define MAC_CR_PS_POS			15
+#define MAC_CR_PS_LEN			1
+#define MAC_CR_FES_POS			14
+#define MAC_CR_FES_LEN			1
+#define MAC_CR_DM_POS			13
+#define MAC_CR_DM_LEN			1
+#define MAC_CR_TE_POS			1
+#define MAC_CR_TE_LEN			1
+#define MAC_ECR_DCRCC_POS		16
+#define MAC_ECR_DCRCC_LEN		1
+#define MAC_ECR_HDSMS_POS		20
+#define MAC_ECR_HDSMS_LEN		3
+/* Maximum Size for Splitting the Header Data */
+#define  FXGMAC_SPH_HDSMS_SIZE_64B		0
+#define  FXGMAC_SPH_HDSMS_SIZE_128B		1
+#define  FXGMAC_SPH_HDSMS_SIZE_256B		2
+#define  FXGMAC_SPH_HDSMS_SIZE_512B		3
+#define  FXGMAC_SPH_HDSMS_SIZE_1023B		4
+#define MAC_RFCR_PFCE_POS		8
+#define MAC_RFCR_PFCE_LEN		1
+#define MAC_RFCR_RFE_POS		0
+#define MAC_RFCR_RFE_LEN		1
+#define MAC_RFCR_UP_POS			1
+#define MAC_RFCR_UP_LEN			1
+#define MAC_RQC0R_RXQ0EN_POS		0
+#define MAC_RQC0R_RXQ0EN_LEN		2
+#define MAC_LPIIE_POS			5
+#define MAC_LPIIE_LEN			1
+#define MAC_LPIATE_POS			20
+#define MAC_LPIATE_LEN			1
+#define MAC_LPITXA_POS			19
+#define MAC_LPITXA_LEN			1
+#define MAC_PLS_POS			17
+#define MAC_PLS_LEN			1
+#define MAC_LPIEN_POS			16
+#define MAC_LPIEN_LEN			1
+#define MAC_LPI_ENTRY_TIMER		8
+#define MAC_LPIET_POS			3
+#define MAC_LPIET_LEN			17
+#define MAC_TWT_TIMER			0x10
+#define MAC_TWT_POS			0
+#define MAC_TWT_LEN			16
+#define MAC_LST_TIMER			2
+#define MAC_LST_POS			16
+#define MAC_LST_LEN			10
+#define MAC_MS_TIC			24
+#define MAC_MS_TIC_POS			0
+#define MAC_MS_TIC_LEN			12
+
+/* RSS table */
+#define MAC_RSSAR_ADDRT_POS		2
+#define MAC_RSSAR_ADDRT_LEN		1
+#define MAC_RSSAR_CT_POS		1
+#define MAC_RSSAR_CT_LEN		1
+#define MAC_RSSAR_OB_POS		0
+#define MAC_RSSAR_OB_LEN		1
+#define MAC_RSSAR_RSSIA_POS		8
+#define MAC_RSSAR_RSSIA_LEN		8
+
+/* RSS indirection table */
+#define MAC_RSSDR_DMCH_POS		0
+#define MAC_RSSDR_DMCH_LEN		2
+
+#define MAC_VLANHTR_VLHT_POS		0
+#define MAC_VLANHTR_VLHT_LEN		16
+#define MAC_VLANIR_VLTI_POS		20
+#define MAC_VLANIR_VLTI_LEN		1
+#define MAC_VLANIR_CSVL_POS		19
+#define MAC_VLANIR_CSVL_LEN		1
+#define MAC_VLANIR_VLP_POS		18
+#define MAC_VLANIR_VLP_LEN		1
+#define MAC_VLANIR_VLC_POS		16
+#define MAC_VLANIR_VLC_LEN		2
+#define MAC_VLANIR_VLT_POS		0
+#define MAC_VLANIR_VLT_LEN		16
+#define MAC_VLANTR_DOVLTC_POS		20
+#define MAC_VLANTR_DOVLTC_LEN		1
+#define MAC_VLANTR_ERSVLM_POS		19
+#define MAC_VLANTR_ERSVLM_LEN		1
+#define MAC_VLANTR_ESVL_POS		18
+#define MAC_VLANTR_ESVL_LEN		1
+#define MAC_VLANTR_ETV_POS		16
+#define MAC_VLANTR_ETV_LEN		1
+#define MAC_VLANTR_EVLS_POS		21
+#define MAC_VLANTR_EVLS_LEN		2
+#define MAC_VLANTR_EVLRXS_POS		24
+#define MAC_VLANTR_EVLRXS_LEN		1
+#define MAC_VLANTR_VL_POS		0
+#define MAC_VLANTR_VL_LEN		16
+#define MAC_VLANTR_VTHM_POS		25
+#define MAC_VLANTR_VTHM_LEN		1
+#define MAC_VLANTR_VTIM_POS		17
+#define MAC_VLANTR_VTIM_LEN		1
+#define MAC_VR_DEVID_POS		16
+#define MAC_VR_DEVID_LEN		16
+#define MAC_VR_SVER_POS			0
+#define MAC_VR_SVER_LEN			8
+#define MAC_VR_USERVER_POS		8
+#define MAC_VR_USERVER_LEN		8
+
+#define MAC_DBG_STA_TX_BUSY		0x70000
+#define MTL_TXQ_DEG_TX_BUSY		0x10
+
+#define MAC_MDIO_ADDR_BUSY		1
+#define MAC_MDIO_ADDR_GOC_POS		2
+#define MAC_MDIO_ADDR_GOC_LEN		2
+#define MAC_MDIO_ADDR_GB_POS		0
+#define MAC_MDIO_ADDR_GB_LEN		1
+
+#define MAC_MDIO_DATA_RA_POS		16
+#define MAC_MDIO_DATA_RA_LEN		16
+#define MAC_MDIO_DATA_GD_POS		0
+#define MAC_MDIO_DATA_GD_LEN		16
+
+/* bit definitions for PMT and WOL */
+#define MAC_PMT_STA_PWRDWN_POS		0
+#define MAC_PMT_STA_PWRDWN_LEN		1
+#define MAC_PMT_STA_MGKPKTEN_POS	1
+#define MAC_PMT_STA_MGKPKTEN_LEN	1
+#define MAC_PMT_STA_RWKPKTEN_POS	2
+#define MAC_PMT_STA_RWKPKTEN_LEN	1
+#define MAC_PMT_STA_MGKPRCVD_POS	5
+#define MAC_PMT_STA_MGKPRCVD_LEN	1
+#define MAC_PMT_STA_RWKPRCVD_POS	6
+#define MAC_PMT_STA_RWKPRCVD_LEN	1
+#define MAC_PMT_STA_GLBLUCAST_POS	9
+#define MAC_PMT_STA_GLBLUCAST_LEN	1
+#define MAC_PMT_STA_RWKPTR_POS		24
+#define MAC_PMT_STA_RWKPTR_LEN		4
+#define MAC_PMT_STA_RWKFILTERST_POS	31
+#define MAC_PMT_STA_RWKFILTERST_LEN	1
+
+/* MMC register offsets */
+#define MMC_CR				0x0700
+#define MMC_RISR			0x0704
+#define MMC_TISR			0x0708
+#define MMC_RIER			0x070c
+#define MMC_TIER			0x0710
+#define MMC_TXOCTETCOUNT_GB_LO		0x0714
+#define MMC_TXFRAMECOUNT_GB_LO		0x0718
+#define MMC_TXBROADCASTFRAMES_G_LO	0x071c
+#define MMC_TXMULTICASTFRAMES_G_LO	0x0720
+#define MMC_TX64OCTETS_GB_LO		0x0724
+#define MMC_TX65TO127OCTETS_GB_LO	0x0728
+#define MMC_TX128TO255OCTETS_GB_LO	0x072c
+#define MMC_TX256TO511OCTETS_GB_LO	0x0730
+#define MMC_TX512TO1023OCTETS_GB_LO	0x0734
+#define MMC_TX1024TOMAXOCTETS_GB_LO	0x0738
+#define MMC_TXUNICASTFRAMES_GB_LO	0x073c
+#define MMC_TXMULTICASTFRAMES_GB_LO	0x0740
+#define MMC_TXBROADCASTFRAMES_GB_LO	0x0744
+#define MMC_TXUNDERFLOWERROR_LO		0x0748
+#define MMC_TXSINGLECOLLISION_G		0x074c
+#define MMC_TXMULTIPLECOLLISION_G	0x0750
+#define MMC_TXDEFERREDFRAMES		0x0754
+#define MMC_TXLATECOLLISIONFRAMES	0x0758
+#define MMC_TXEXCESSIVECOLLSIONFRAMES	0x075c
+#define MMC_TXCARRIERERRORFRAMES	0x0760
+#define MMC_TXOCTETCOUNT_G_LO		0x0764
+#define MMC_TXFRAMECOUNT_G_LO		0x0768
+#define MMC_TXEXCESSIVEDEFERRALERROR	0x076c
+#define MMC_TXPAUSEFRAMES_LO		0x0770
+#define MMC_TXVLANFRAMES_G_LO		0x0774
+#define MMC_TXOVERSIZEFRAMES		0x0778
+#define MMC_RXFRAMECOUNT_GB_LO		0x0780
+#define MMC_RXOCTETCOUNT_GB_LO		0x0784
+#define MMC_RXOCTETCOUNT_G_LO		0x0788
+#define MMC_RXBROADCASTFRAMES_G_LO	0x078c
+#define MMC_RXMULTICASTFRAMES_G_LO	0x0790
+#define MMC_RXCRCERROR_LO		0x0794
+#define MMC_RXALIGNERROR		0x0798
+#define MMC_RXRUNTERROR			0x079c
+#define MMC_RXJABBERERROR		0x07a0
+#define MMC_RXUNDERSIZE_G		0x07a4
+#define MMC_RXOVERSIZE_G		0x07a8
+#define MMC_RX64OCTETS_GB_LO		0x07ac
+#define MMC_RX65TO127OCTETS_GB_LO	0x07b0
+#define MMC_RX128TO255OCTETS_GB_LO	0x07b4
+#define MMC_RX256TO511OCTETS_GB_LO	0x07b8
+#define MMC_RX512TO1023OCTETS_GB_LO	0x07bc
+#define MMC_RX1024TOMAXOCTETS_GB_LO	0x07c0
+#define MMC_RXUNICASTFRAMES_G_LO	0x07c4
+#define MMC_RXLENGTHERROR_LO		0x07c8
+#define MMC_RXOUTOFRANGETYPE_LO		0x07cc
+#define MMC_RXPAUSEFRAMES_LO		0x07d0
+#define MMC_RXFIFOOVERFLOW_LO		0x07d4
+#define MMC_RXVLANFRAMES_GB_LO		0x07d8
+#define MMC_RXWATCHDOGERROR		0x07dc
+#define MMC_RXRECEIVEERRORFRAME		0x07e0
+#define MMC_RXCONTROLFRAME_G		0x07e4
+#define MMC_IPCRXINTMASK		0x0800
+#define MMC_IPCRXINT			0x0808
+
+/* MMC register entry bit positions and sizes */
+#define MMC_CR_CR_POS				0
+#define MMC_CR_CR_LEN				1
+#define MMC_CR_CSR_POS				1
+#define MMC_CR_CSR_LEN				1
+#define MMC_CR_ROR_POS				2
+#define MMC_CR_ROR_LEN				1
+#define MMC_CR_MCF_POS				3
+#define MMC_CR_MCF_LEN				1
+#define MMC_RIER_ALL_INTERRUPTS_POS		0
+#define MMC_RIER_ALL_INTERRUPTS_LEN		28
+#define MMC_RISR_RXFRAMECOUNT_GB_POS		0
+#define MMC_RISR_RXFRAMECOUNT_GB_LEN		1
+#define MMC_RISR_RXOCTETCOUNT_GB_POS		1
+#define MMC_RISR_RXOCTETCOUNT_GB_LEN		1
+#define MMC_RISR_RXOCTETCOUNT_G_POS		2
+#define MMC_RISR_RXOCTETCOUNT_G_LEN		1
+#define MMC_RISR_RXBROADCASTFRAMES_G_POS	3
+#define MMC_RISR_RXBROADCASTFRAMES_G_LEN	1
+#define MMC_RISR_RXMULTICASTFRAMES_G_POS	4
+#define MMC_RISR_RXMULTICASTFRAMES_G_LEN	1
+#define MMC_RISR_RXCRCERROR_POS			5
+#define MMC_RISR_RXCRCERROR_LEN			1
+#define MMC_RISR_RXALIGNERROR_POS		6
+#define MMC_RISR_RXALIGNERROR_LEN		1
+#define MMC_RISR_RXRUNTERROR_POS		7
+#define MMC_RISR_RXRUNTERROR_LEN		1
+#define MMC_RISR_RXJABBERERROR_POS		8
+#define MMC_RISR_RXJABBERERROR_LEN		1
+#define MMC_RISR_RXUNDERSIZE_G_POS		9
+#define MMC_RISR_RXUNDERSIZE_G_LEN		1
+#define MMC_RISR_RXOVERSIZE_G_POS		10
+#define MMC_RISR_RXOVERSIZE_G_LEN		1
+#define MMC_RISR_RX64OCTETS_GB_POS		11
+#define MMC_RISR_RX64OCTETS_GB_LEN		1
+#define MMC_RISR_RX65TO127OCTETS_GB_POS		12
+#define MMC_RISR_RX65TO127OCTETS_GB_LEN		1
+#define MMC_RISR_RX128TO255OCTETS_GB_POS	13
+#define MMC_RISR_RX128TO255OCTETS_GB_LEN	1
+#define MMC_RISR_RX256TO511OCTETS_GB_POS	14
+#define MMC_RISR_RX256TO511OCTETS_GB_LEN	1
+#define MMC_RISR_RX512TO1023OCTETS_GB_POS	15
+#define MMC_RISR_RX512TO1023OCTETS_GB_LEN	1
+#define MMC_RISR_RX1024TOMAXOCTETS_GB_POS	16
+#define MMC_RISR_RX1024TOMAXOCTETS_GB_LEN	1
+#define MMC_RISR_RXUNICASTFRAMES_G_POS		17
+#define MMC_RISR_RXUNICASTFRAMES_G_LEN		1
+#define MMC_RISR_RXLENGTHERROR_POS		18
+#define MMC_RISR_RXLENGTHERROR_LEN		1
+#define MMC_RISR_RXOUTOFRANGETYPE_POS		19
+#define MMC_RISR_RXOUTOFRANGETYPE_LEN		1
+#define MMC_RISR_RXPAUSEFRAMES_POS		20
+#define MMC_RISR_RXPAUSEFRAMES_LEN		1
+#define MMC_RISR_RXFIFOOVERFLOW_POS		21
+#define MMC_RISR_RXFIFOOVERFLOW_LEN		1
+#define MMC_RISR_RXVLANFRAMES_GB_POS		22
+#define MMC_RISR_RXVLANFRAMES_GB_LEN		1
+#define MMC_RISR_RXWATCHDOGERROR_POS		23
+#define MMC_RISR_RXWATCHDOGERROR_LEN		1
+#define MMC_RISR_RXERRORFRAMES_POS		24
+#define MMC_RISR_RXERRORFRAMES_LEN		1
+#define MMC_RISR_RXERRORCONTROLFRAMES_POS	25
+#define MMC_RISR_RXERRORCONTROLFRAMES_LEN	1
+#define MMC_RISR_RXLPIMICROSECOND_POS		26
+#define MMC_RISR_RXLPIMICROSECOND_LEN		1
+#define MMC_RISR_RXLPITRANSITION_POS		27
+#define MMC_RISR_RXLPITRANSITION_LEN		1
+
+#define MMC_TIER_ALL_INTERRUPTS_POS		0
+#define MMC_TIER_ALL_INTERRUPTS_LEN		28
+#define MMC_TISR_TXOCTETCOUNT_GB_POS		0
+#define MMC_TISR_TXOCTETCOUNT_GB_LEN		1
+#define MMC_TISR_TXFRAMECOUNT_GB_POS		1
+#define MMC_TISR_TXFRAMECOUNT_GB_LEN		1
+#define MMC_TISR_TXBROADCASTFRAMES_G_POS	2
+#define MMC_TISR_TXBROADCASTFRAMES_G_LEN	1
+#define MMC_TISR_TXMULTICASTFRAMES_G_POS	3
+#define MMC_TISR_TXMULTICASTFRAMES_G_LEN	1
+#define MMC_TISR_TX64OCTETS_GB_POS		4
+#define MMC_TISR_TX64OCTETS_GB_LEN		1
+#define MMC_TISR_TX65TO127OCTETS_GB_POS		5
+#define MMC_TISR_TX65TO127OCTETS_GB_LEN		1
+#define MMC_TISR_TX128TO255OCTETS_GB_POS	6
+#define MMC_TISR_TX128TO255OCTETS_GB_LEN	1
+#define MMC_TISR_TX256TO511OCTETS_GB_POS	7
+#define MMC_TISR_TX256TO511OCTETS_GB_LEN	1
+#define MMC_TISR_TX512TO1023OCTETS_GB_POS	8
+#define MMC_TISR_TX512TO1023OCTETS_GB_LEN	1
+#define MMC_TISR_TX1024TOMAXOCTETS_GB_POS	9
+#define MMC_TISR_TX1024TOMAXOCTETS_GB_LEN	1
+#define MMC_TISR_TXUNICASTFRAMES_GB_POS		10
+#define MMC_TISR_TXUNICASTFRAMES_GB_LEN		1
+#define MMC_TISR_TXMULTICASTFRAMES_GB_POS	11
+#define MMC_TISR_TXMULTICASTFRAMES_GB_LEN	1
+#define MMC_TISR_TXBROADCASTFRAMES_GB_POS	12
+#define MMC_TISR_TXBROADCASTFRAMES_GB_LEN	1
+#define MMC_TISR_TXUNDERFLOWERROR_POS		13
+#define MMC_TISR_TXUNDERFLOWERROR_LEN		1
+#define MMC_TISR_TXSINGLECOLLISION_G_POS	14
+#define MMC_TISR_TXSINGLECOLLISION_G_LEN	1
+#define MMC_TISR_TXMULTIPLECOLLISION_G_POS	15
+#define MMC_TISR_TXMULTIPLECOLLISION_G_LEN	1
+#define MMC_TISR_TXDEFERREDFRAMES_POS		16
+#define MMC_TISR_TXDEFERREDFRAMES_LEN		1
+#define MMC_TISR_TXLATECOLLISIONFRAMES_POS	17
+#define MMC_TISR_TXLATECOLLISIONFRAMES_LEN	1
+#define MMC_TISR_TXEXCESSIVECOLLISIONFRAMES_POS 18
+#define MMC_TISR_TXEXCESSIVECOLLISIONFRAMES_LEN 1
+#define MMC_TISR_TXCARRIERERRORFRAMES_POS	19
+#define MMC_TISR_TXCARRIERERRORFRAMES_LEN	1
+#define MMC_TISR_TXOCTETCOUNT_G_POS		20
+#define MMC_TISR_TXOCTETCOUNT_G_LEN		1
+#define MMC_TISR_TXFRAMECOUNT_G_POS		21
+#define MMC_TISR_TXFRAMECOUNT_G_LEN		1
+#define MMC_TISR_TXEXCESSIVEDEFERRALFRAMES_POS	22
+#define MMC_TISR_TXEXCESSIVEDEFERRALFRAMES_LEN	1
+#define MMC_TISR_TXPAUSEFRAMES_POS		23
+#define MMC_TISR_TXPAUSEFRAMES_LEN		1
+#define MMC_TISR_TXVLANFRAMES_G_POS		24
+#define MMC_TISR_TXVLANFRAMES_G_LEN		1
+#define MMC_TISR_TXOVERSIZE_G_POS		25
+#define MMC_TISR_TXOVERSIZE_G_LEN		1
+#define MMC_TISR_TXLPIMICROSECOND_POS		26
+#define MMC_TISR_TXLPIMICROSECOND_LEN		1
+#define MMC_TISR_TXLPITRANSITION_POS		27
+#define MMC_TISR_TXLPITRANSITION_LEN		1
+
+/* MTL register offsets */
+#define MTL_OMR					0x0c00
+#define MTL_FDCR				0x0c08
+#define MTL_FDSR				0x0c0c
+#define MTL_FDDR				0x0c10
+#define MTL_INT_SR				0x0c20
+#define MTL_RQDCM0R				0x0c30
+#define MTL_ECC_INT_SR				0x0ccc
+
+#define MTL_RQDCM_INC				4
+#define MTL_RQDCM_Q_PER_REG			4
+
+/* MTL register entry bit positions and sizes */
+#define MTL_OMR_ETSALG_POS			5
+#define MTL_OMR_ETSALG_LEN			2
+#define MTL_OMR_RAA_POS				2
+#define MTL_OMR_RAA_LEN				1
+
+/* MTL queue register offsets */
+#define MTL_Q_BASE				0x0d00
+#define MTL_Q_INC				0x40
+#define MTL_Q_INT_CTL_SR			0x0d2c
+
+#define MTL_Q_TQOMR				0x00
+#define MTL_Q_TQUR				0x04
+#define MTL_Q_RQOMR				0x30
+#define MTL_Q_RQMPOCR				0x34
+#define MTL_Q_RQDR				0x38
+#define MTL_Q_RQCR				0x3c
+#define MTL_Q_IER				0x2c
+#define MTL_Q_ISR				0x2c
+#define MTL_TXQ_DEG				0x08 /* transmit debug */
+
+/* MTL queue register entry bit positions and sizes */
+#define MTL_Q_RQDR_PRXQ_POS			16
+#define MTL_Q_RQDR_PRXQ_LEN			14
+#define MTL_Q_RQDR_RXQSTS_POS			4
+#define MTL_Q_RQDR_RXQSTS_LEN			2
+#define MTL_Q_RQOMR_RFA_POS			8
+#define MTL_Q_RQOMR_RFA_LEN			6
+#define MTL_Q_RQOMR_RFD_POS			14
+#define MTL_Q_RQOMR_RFD_LEN			6
+#define MTL_Q_RQOMR_EHFC_POS			7
+#define MTL_Q_RQOMR_EHFC_LEN			1
+#define MTL_Q_RQOMR_RQS_POS			20
+#define MTL_Q_RQOMR_RQS_LEN			9
+#define MTL_Q_RQOMR_RSF_POS			5
+#define MTL_Q_RQOMR_RSF_LEN			1
+#define MTL_Q_RQOMR_FEP_POS			4
+#define MTL_Q_RQOMR_FEP_LEN			1
+#define MTL_Q_RQOMR_FUP_POS			3
+#define MTL_Q_RQOMR_FUP_LEN			1
+#define MTL_Q_RQOMR_RTC_POS			0
+#define MTL_Q_RQOMR_RTC_LEN			2
+#define MTL_Q_TQOMR_FTQ_POS			0
+#define MTL_Q_TQOMR_FTQ_LEN			1
+#define MTL_Q_TQOMR_TQS_POS			16
+#define MTL_Q_TQOMR_TQS_LEN			7
+#define MTL_Q_TQOMR_TSF_POS			1
+#define MTL_Q_TQOMR_TSF_LEN			1
+#define MTL_Q_TQOMR_TTC_POS			4
+#define MTL_Q_TQOMR_TTC_LEN			3
+#define MTL_Q_TQOMR_TXQEN_POS			2
+#define MTL_Q_TQOMR_TXQEN_LEN			2
+
+/* MTL queue register value */
+#define MTL_RSF_DISABLE				0x00
+#define MTL_RSF_ENABLE				0x01
+#define MTL_TSF_DISABLE				0x00
+#define MTL_TSF_ENABLE				0x01
+#define MTL_FEP_DISABLE				0x00
+#define MTL_FEP_ENABLE				0x01
+
+#define MTL_RX_THRESHOLD_64			0x00
+#define MTL_RX_THRESHOLD_32			0x01
+#define MTL_RX_THRESHOLD_96			0x02
+#define MTL_RX_THRESHOLD_128			0x03
+#define MTL_TX_THRESHOLD_32			0x00
+#define MTL_TX_THRESHOLD_64			0x01
+#define MTL_TX_THRESHOLD_96			0x02
+#define MTL_TX_THRESHOLD_128			0x03
+#define MTL_TX_THRESHOLD_192			0x04
+#define MTL_TX_THRESHOLD_256			0x05
+#define MTL_TX_THRESHOLD_384			0x06
+#define MTL_TX_THRESHOLD_512			0x07
+
+#define MTL_ETSALG_WRR				0x00
+#define MTL_ETSALG_WFQ				0x01
+#define MTL_ETSALG_DWRR				0x02
+#define MTL_ETSALG_SP				0x03
+
+#define MTL_RAA_SP				0x00
+#define MTL_RAA_WSP				0x01
+
+#define MTL_Q_DISABLED				0x00
+#define MTL_Q_EN_IF_AV				0x01
+#define MTL_Q_ENABLED				0x02
+
+#define MTL_RQDCM0R_Q0MDMACH			0x0
+#define MTL_RQDCM0R_Q1MDMACH			0x00000100
+#define MTL_RQDCM0R_Q2MDMACH			0x00020000
+#define MTL_RQDCM0R_Q3MDMACH			0x03000000
+#define MTL_RQDCM1R_Q4MDMACH			0x00000004
+#define MTL_RQDCM1R_Q5MDMACH			0x00000500
+#define MTL_RQDCM1R_Q6MDMACH			0x00060000
+#define MTL_RQDCM1R_Q7MDMACH			0x07000000
+#define MTL_RQDCM2R_Q8MDMACH			0x00000008
+#define MTL_RQDCM2R_Q9MDMACH			0x00000900
+#define MTL_RQDCM2R_Q10MDMACH			0x000A0000
+#define MTL_RQDCM2R_Q11MDMACH			0x0B000000
+
+#define MTL_RQDCM0R_Q0DDMACH			0x10
+#define MTL_RQDCM0R_Q1DDMACH			0x00001000
+#define MTL_RQDCM0R_Q2DDMACH			0x00100000
+#define MTL_RQDCM0R_Q3DDMACH			0x10000000
+#define MTL_RQDCM1R_Q4DDMACH			0x00000010
+#define MTL_RQDCM1R_Q5DDMACH			0x00001000
+#define MTL_RQDCM1R_Q6DDMACH			0x00100000
+#define MTL_RQDCM1R_Q7DDMACH			0x10000000
+
+/* MTL traffic class register offsets */
+#define MTL_TC_BASE				MTL_Q_BASE
+#define MTL_TC_INC				MTL_Q_INC
+
+#define MTL_TC_TQDR				0x08
+#define MTL_TC_ETSCR				0x10
+#define MTL_TC_ETSSR				0x14
+#define MTL_TC_QWR				0x18
+
+#define MTL_TC_TQDR_TRCSTS_POS			1
+#define MTL_TC_TQDR_TRCSTS_LEN			2
+#define MTL_TC_TQDR_TXQSTS_POS			4
+#define MTL_TC_TQDR_TXQSTS_LEN			1
+
+/* MTL traffic class register entry bit positions and sizes */
+#define MTL_TC_ETSCR_TSA_POS			0
+#define MTL_TC_ETSCR_TSA_LEN			2
+#define MTL_TC_QWR_QW_POS			0
+#define MTL_TC_QWR_QW_LEN			21
+
+/* MTL traffic class register value */
+#define MTL_TSA_SP				0x00
+#define MTL_TSA_ETS				0x02
+
+/* DMA register offsets */
+#define DMA_MR					0x1000
+#define DMA_SBMR				0x1004
+#define DMA_ISR					0x1008
+#define DMA_DSR0				0x100c
+#define DMA_DSR1				0x1010
+#define DMA_DSR2				0x1014
+#define DMA_AXIARCR				0x1020
+#define DMA_AXIAWCR				0x1024
+#define DMA_AXIAWRCR				0x1028
+#define DMA_SAFE_ISR				0x1080
+#define DMA_ECC_IE				0x1084
+#define DMA_ECC_INT_SR				0x1088
+
+/* DMA register entry bit positions and sizes */
+#define DMA_ISR_MACIS_POS			17
+#define DMA_ISR_MACIS_LEN			1
+#define DMA_ISR_MTLIS_POS			16
+#define DMA_ISR_MTLIS_LEN			1
+#define DMA_MR_SWR_POS				0
+#define DMA_MR_SWR_LEN				1
+#define DMA_MR_TXPR_POS				11
+#define DMA_MR_TXPR_LEN				1
+#define DMA_MR_INTM_POS				16
+#define DMA_MR_INTM_LEN				2
+#define DMA_MR_QUREAD_POS			19
+#define DMA_MR_QUREAD_LEN			1
+#define DMA_MR_TNDF_POS				20
+#define DMA_MR_TNDF_LEN				2
+#define DMA_MR_RNDF_POS				22
+#define DMA_MR_RNDF_LEN				2
+
+#define DMA_SBMR_EN_LPI_POS			31
+#define DMA_SBMR_EN_LPI_LEN			1
+#define DMA_SBMR_LPI_XIT_PKT_POS		30
+#define DMA_SBMR_LPI_XIT_PKT_LEN		1
+#define DMA_SBMR_WR_OSR_LMT_POS			24
+#define DMA_SBMR_WR_OSR_LMT_LEN			6
+#define DMA_SBMR_RD_OSR_LMT_POS			16
+#define DMA_SBMR_RD_OSR_LMT_LEN			8
+#define DMA_SBMR_AAL_POS			12
+#define DMA_SBMR_AAL_LEN			1
+#define DMA_SBMR_EAME_POS			11
+#define DMA_SBMR_EAME_LEN			1
+#define DMA_SBMR_AALE_POS			10
+#define DMA_SBMR_AALE_LEN			1
+#define DMA_SBMR_BLEN_4_POS			1
+#define DMA_SBMR_BLEN_4_LEN			1
+#define DMA_SBMR_BLEN_8_POS			2
+#define DMA_SBMR_BLEN_8_LEN			1
+#define DMA_SBMR_BLEN_16_POS			3
+#define DMA_SBMR_BLEN_16_LEN			1
+#define DMA_SBMR_BLEN_32_POS			4
+#define DMA_SBMR_BLEN_32_LEN			1
+#define DMA_SBMR_BLEN_64_POS			5
+#define DMA_SBMR_BLEN_64_LEN			1
+#define DMA_SBMR_BLEN_128_POS			6
+#define DMA_SBMR_BLEN_128_LEN			1
+#define DMA_SBMR_BLEN_256_POS			7
+#define DMA_SBMR_BLEN_256_LEN			1
+#define DMA_SBMR_FB_POS				0
+#define DMA_SBMR_FB_LEN				1
+
+/* DMA register values */
+#define DMA_DSR_RPS_LEN			4
+#define DMA_DSR_TPS_LEN			4
+#define DMA_DSR_Q_LEN			(DMA_DSR_RPS_LEN + DMA_DSR_TPS_LEN)
+#define DMA_DSR0_TPS_START		12
+#define DMA_DSRX_FIRST_QUEUE		3
+#define DMA_DSRX_INC			4
+#define DMA_DSRX_QPR			4
+#define DMA_DSRX_TPS_START		4
+#define DMA_TPS_STOPPED			0x00
+#define DMA_TPS_SUSPENDED		0x06
+
+/* DMA channel register offsets */
+#define DMA_CH_BASE			0x1100
+#define DMA_CH_INC			0x80
+
+#define DMA_CH_CR			0x00
+#define DMA_CH_TCR			0x04
+#define DMA_CH_RCR			0x08
+#define DMA_CH_TDLR_HI			0x10
+#define DMA_CH_TDLR_LO			0x14
+#define DMA_CH_RDLR_HI			0x18
+#define DMA_CH_RDLR_LO			0x1c
+#define DMA_CH_TDTR_LO			0x20
+#define DMA_CH_RDTR_LO			0x28
+#define DMA_CH_TDRLR			0x2c
+#define DMA_CH_RDRLR			0x30
+#define DMA_CH_IER			0x34
+#define DMA_CH_RIWT			0x38
+#define DMA_CH_CATDR_LO			0x44
+#define DMA_CH_CARDR_LO			0x4c
+#define DMA_CH_CATBR_HI			0x50
+#define DMA_CH_CATBR_LO			0x54
+#define DMA_CH_CARBR_HI			0x58
+#define DMA_CH_CARBR_LO			0x5c
+#define DMA_CH_SR			0x60
+
+/* DMA channel register entry bit positions and sizes */
+#define DMA_CH_CR_PBLX8_POS			16
+#define DMA_CH_CR_PBLX8_LEN			1
+#define DMA_CH_CR_SPH_POS			24
+#define DMA_CH_CR_SPH_LEN			1
+#define DMA_CH_IER_AIE_POS			14
+#define DMA_CH_IER_AIE_LEN			1
+#define DMA_CH_IER_FBEE_POS			12
+#define DMA_CH_IER_FBEE_LEN			1
+#define DMA_CH_IER_NIE_POS			15
+#define DMA_CH_IER_NIE_LEN			1
+#define DMA_CH_IER_RBUE_POS			7
+#define DMA_CH_IER_RBUE_LEN			1
+#define DMA_CH_IER_RIE_POS			6
+#define DMA_CH_IER_RIE_LEN			1
+#define DMA_CH_IER_RSE_POS			8
+#define DMA_CH_IER_RSE_LEN			1
+#define DMA_CH_IER_TBUE_POS			2
+#define DMA_CH_IER_TBUE_LEN			1
+#define DMA_CH_IER_TIE_POS			0
+#define DMA_CH_IER_TIE_LEN			1
+#define DMA_CH_IER_TXSE_POS			1
+#define DMA_CH_IER_TXSE_LEN			1
+#define DMA_CH_RCR_PBL_POS			16
+#define DMA_CH_RCR_PBL_LEN			6
+#define DMA_CH_RCR_RBSZ_POS			1
+#define DMA_CH_RCR_RBSZ_LEN			14
+#define DMA_CH_RCR_SR_POS			0
+#define DMA_CH_RCR_SR_LEN			1
+#define DMA_CH_RIWT_RWT_POS			0
+#define DMA_CH_RIWT_RWT_LEN			8
+#define DMA_CH_SR_FBE_POS			12
+#define DMA_CH_SR_FBE_LEN			1
+#define DMA_CH_SR_RBU_POS			7
+#define DMA_CH_SR_RBU_LEN			1
+#define DMA_CH_SR_RI_POS			6
+#define DMA_CH_SR_RI_LEN			1
+#define DMA_CH_SR_RPS_POS			8
+#define DMA_CH_SR_RPS_LEN			1
+#define DMA_CH_SR_TBU_POS			2
+#define DMA_CH_SR_TBU_LEN			1
+#define DMA_CH_SR_TI_POS			0
+#define DMA_CH_SR_TI_LEN			1
+#define DMA_CH_SR_TPS_POS			1
+#define DMA_CH_SR_TPS_LEN			1
+#define DMA_CH_TCR_OSP_POS			4
+#define DMA_CH_TCR_OSP_LEN			1
+#define DMA_CH_TCR_PBL_POS			16
+#define DMA_CH_TCR_PBL_LEN			6
+#define DMA_CH_TCR_ST_POS			0
+#define DMA_CH_TCR_ST_LEN			1
+#define DMA_CH_TCR_TSE_POS			12
+#define DMA_CH_TCR_TSE_LEN			1
+
+/* DMA channel register values */
+#define DMA_OSP_DISABLE				0x00
+#define DMA_OSP_ENABLE				0x01
+#define DMA_PBL_1				1
+#define DMA_PBL_2				2
+#define DMA_PBL_4				4
+#define DMA_PBL_8				8
+#define DMA_PBL_16				16
+#define DMA_PBL_32				32
+#define DMA_PBL_64				64
+#define DMA_PBL_128				128
+#define DMA_PBL_256				256
+#define DMA_PBL_X8_DISABLE			0x00
+#define DMA_PBL_X8_ENABLE			0x01
+
+/* Descriptor/Packet entry bit positions and sizes */
+#define RX_PACKET_ERRORS_CRC_POS		2
+#define RX_PACKET_ERRORS_CRC_LEN		1
+#define RX_PACKET_ERRORS_FRAME_POS		3
+#define RX_PACKET_ERRORS_FRAME_LEN		1
+#define RX_PACKET_ERRORS_LENGTH_POS		0
+#define RX_PACKET_ERRORS_LENGTH_LEN		1
+#define RX_PACKET_ERRORS_OVERRUN_POS		1
+#define RX_PACKET_ERRORS_OVERRUN_LEN		1
+
+#define RX_PKT_ATTR_CSUM_DONE_POS		0
+#define RX_PKT_ATTR_CSUM_DONE_LEN		1
+#define RX_PKT_ATTR_VLAN_CTAG_POS		1
+#define RX_PKT_ATTR_VLAN_CTAG_LEN		1
+#define RX_PKT_ATTR_INCOMPLETE_POS		2
+#define RX_PKT_ATTR_INCOMPLETE_LEN		1
+#define RX_PKT_ATTR_CONTEXT_NEXT_POS		3
+#define RX_PKT_ATTR_CONTEXT_NEXT_LEN		1
+#define RX_PKT_ATTR_CONTEXT_POS			4
+#define RX_PKT_ATTR_CONTEXT_LEN			1
+#define RX_PKT_ATTR_RX_TSTAMP_POS		5
+#define RX_PKT_ATTR_RX_TSTAMP_LEN		1
+#define RX_PKT_ATTR_RSS_HASH_POS		6
+#define RX_PKT_ATTR_RSS_HASH_LEN		1
+
+#define RX_NORMAL_DESC0_OVT_POS			0
+#define RX_NORMAL_DESC0_OVT_LEN			16
+#define RX_NORMAL_DESC2_HL_POS			0
+#define RX_NORMAL_DESC2_HL_LEN			10
+#define RX_NORMAL_DESC3_CDA_LEN			1
+#define RX_NORMAL_DESC3_CTXT_POS		30
+#define RX_NORMAL_DESC3_CTXT_LEN		1
+#define RX_NORMAL_DESC3_ES_POS			15
+#define RX_NORMAL_DESC3_ES_LEN			1
+#define RX_NORMAL_DESC3_ETLT_POS		16
+#define RX_NORMAL_DESC3_ETLT_LEN		3
+#define RX_NORMAL_DESC3_FD_POS			29
+#define RX_NORMAL_DESC3_FD_LEN			1
+#define RX_NORMAL_DESC3_INTE_POS		30
+#define RX_NORMAL_DESC3_INTE_LEN		1
+#define RX_NORMAL_DESC3_L34T_LEN		4
+#define RX_NORMAL_DESC3_RSV_POS			26
+#define RX_NORMAL_DESC3_RSV_LEN			1
+#define RX_NORMAL_DESC3_LD_POS			28
+#define RX_NORMAL_DESC3_LD_LEN			1
+#define RX_NORMAL_DESC3_OWN_POS			31
+#define RX_NORMAL_DESC3_OWN_LEN			1
+#define RX_NORMAL_DESC3_BUF2V_POS		25
+#define RX_NORMAL_DESC3_BUF2V_LEN		1
+#define RX_NORMAL_DESC3_BUF1V_POS		24
+#define RX_NORMAL_DESC3_BUF1V_LEN		1
+#define RX_NORMAL_DESC3_PL_POS			0
+#define RX_NORMAL_DESC3_PL_LEN			15
+
+/* Inner VLAN Tag. Valid only when Double VLAN tag processing and VLAN tag
+ * stripping are enabled.
+ */
+#define RX_NORMAL_DESC0_WB_IVT_POS		16
+#define RX_NORMAL_DESC0_WB_IVT_LEN		16
+#define RX_NORMAL_DESC0_WB_OVT_POS		0  /* Outer VLAN Tag. */
+#define RX_NORMAL_DESC0_WB_OVT_LEN		16
+#define RX_NORMAL_DESC0_WB_OVT_VLANID_POS	0  /* Outer VLAN ID. */
+#define RX_NORMAL_DESC0_WB_OVT_VLANID_LEN	12
+#define RX_NORMAL_DESC0_WB_OVT_CFI_POS		12 /* Outer VLAN CFI. */
+#define RX_NORMAL_DESC0_WB_OVT_CFI_LEN		1
+#define RX_NORMAL_DESC0_WB_OVT_PRIO_POS		13 /* Outer VLAN Priority. */
+#define RX_NORMAL_DESC0_WB_OVT_PRIO_LEN		3
+
+#define RX_NORMAL_DESC1_WB_IPCE_POS		7  /* IP Payload Error. */
+#define RX_NORMAL_DESC1_WB_IPCE_LEN		1
+#define RX_NORMAL_DESC1_WB_IPV6_POS		5  /* IPV6 Header Present. */
+#define RX_NORMAL_DESC1_WB_IPV6_LEN		1
+#define RX_NORMAL_DESC1_WB_IPV4_POS		4  /* IPV4 Header Present. */
+#define RX_NORMAL_DESC1_WB_IPV4_LEN		1
+#define RX_NORMAL_DESC1_WB_IPHE_POS		3  /* IP Header Error. */
+#define RX_NORMAL_DESC1_WB_IPHE_LEN		1
+#define RX_NORMAL_DESC1_WB_PT_POS		0
+#define RX_NORMAL_DESC1_WB_PT_LEN		3
+
+/* Hash Filter Status. When this bit is set, it indicates that the packet
+ * passed the MAC address hash filter
+ */
+#define RX_NORMAL_DESC2_WB_HF_POS		18
+#define RX_NORMAL_DESC2_WB_HF_LEN		1
+
+/* Destination Address Filter Fail. When Flexible RX Parser is disabled, and
+ * this bit is set, it indicates that the packet err
+ * the DA Filter in the MAC.
+ */
+#define RX_NORMAL_DESC2_WB_DAF_POS		17
+#define RX_NORMAL_DESC2_WB_DAF_LEN		1
+
+#define RX_NORMAL_DESC2_WB_RAPARSER_POS		11
+#define RX_NORMAL_DESC2_WB_RAPARSER_LEN		3
+
+#define RX_NORMAL_DESC3_WB_LD_POS		28
+#define RX_NORMAL_DESC3_WB_LD_LEN		1
+
+/* When this bit is set, it indicates that the status in RDES0 is valid and
+ * it is written by the DMA.
+ */
+#define RX_NORMAL_DESC3_WB_RS0V_POS		25
+#define RX_NORMAL_DESC3_WB_RS0V_LEN		1
+
+/* When this bit is set, it indicates that a Cyclic Redundancy Check (CRC)
+ * Error occurred on the received packet.This field is valid only when
+ * the LD bit of RDES3 is set.
+ */
+#define RX_NORMAL_DESC3_WB_CE_POS		24
+#define RX_NORMAL_DESC3_WB_CE_LEN		1
+
+#define RX_DESC3_L34T_IPV4_TCP			1
+#define RX_DESC3_L34T_IPV4_UDP			2
+#define RX_DESC3_L34T_IPV4_ICMP			3
+#define RX_DESC3_L34T_IPV6_TCP			9
+#define RX_DESC3_L34T_IPV6_UDP			10
+#define RX_DESC3_L34T_IPV6_ICMP			11
+
+#define RX_DESC1_PT_UDP				1
+#define RX_DESC1_PT_TCP				2
+#define RX_DESC1_PT_ICMP			3
+#define RX_DESC1_PT_AV_TAG_DATA			6
+#define RX_DESC1_PT_AV_TAG_CTRL			7
+#define RX_DESC1_PT_AV_NOTAG_CTRL		5
+
+#define RX_CONTEXT_DESC3_TSA_LEN		1
+#define RX_CONTEXT_DESC3_TSD_LEN		1
+
+#define TX_PKT_ATTR_CSUM_ENABLE_POS		0
+#define TX_PKT_ATTR_CSUM_ENABLE_LEN		1
+#define TX_PKT_ATTR_TSO_ENABLE_POS		1
+#define TX_PKT_ATTR_TSO_ENABLE_LEN		1
+#define TX_PKT_ATTR_VLAN_CTAG_POS		2
+#define TX_PKT_ATTR_VLAN_CTAG_LEN		1
+#define TX_PKT_ATTR_PTP_POS			3
+#define TX_PKT_ATTR_PTP_LEN			1
+
+#define TX_CONTEXT_DESC2_MSS_POS		0
+#define TX_CONTEXT_DESC2_MSS_LEN		14
+#define TX_CONTEXT_DESC2_IVLTV_POS		16 /* Inner VLAN Tag. */
+#define TX_CONTEXT_DESC2_IVLTV_LEN		16
+
+#define TX_CONTEXT_DESC3_CTXT_POS		30
+#define TX_CONTEXT_DESC3_CTXT_LEN		1
+#define TX_CONTEXT_DESC3_TCMSSV_POS		26
+#define TX_CONTEXT_DESC3_TCMSSV_LEN		1
+#define TX_CONTEXT_DESC3_IVTIR_POS		18
+#define TX_CONTEXT_DESC3_IVTIR_LEN		2
+#define TX_CONTEXT_DESC3_IVTIR_INSERT		2
+
+/* Insert an inner VLAN tag with the tag value programmed in the
+ * MAC_Inner_VLAN_Incl register or context descriptor.
+ */
+/* Indicates that the Inner VLAN TAG, IVLTV field of context TDES2 is valid. */
+#define TX_CONTEXT_DESC3_IVLTV_POS		17
+#define TX_CONTEXT_DESC3_IVLTV_LEN		1
+/* Indicates that the VT field of context TDES3 is valid. */
+#define TX_CONTEXT_DESC3_VLTV_POS		16
+#define TX_CONTEXT_DESC3_VLTV_LEN		1
+#define TX_CONTEXT_DESC3_VT_POS			0
+#define TX_CONTEXT_DESC3_VT_LEN			16
+
+/* Header Length or Buffer 1 Length. */
+#define TX_NORMAL_DESC2_HL_B1L_POS		0
+#define TX_NORMAL_DESC2_HL_B1L_LEN		14
+#define TX_NORMAL_DESC2_IC_POS			31 /* Interrupt on Completion. */
+#define TX_NORMAL_DESC2_IC_LEN			1
+/* Transmit Timestamp Enable or External TSO Memory Write Enable. */
+#define TX_NORMAL_DESC2_TTSE_POS		30
+#define TX_NORMAL_DESC2_TTSE_LEN		1
+/* LAN Tag Insertion or Replacement. */
+#define TX_NORMAL_DESC2_VTIR_POS		14
+#define TX_NORMAL_DESC2_VTIR_LEN		2
+#define TX_NORMAL_DESC2_VLAN_INSERT		0x2
+
+#define TX_NORMAL_DESC3_TCPPL_POS		0
+#define TX_NORMAL_DESC3_TCPPL_LEN		18
+/* Frame Length or TCP Payload Length. */
+#define TX_NORMAL_DESC3_FL_POS			0
+#define TX_NORMAL_DESC3_FL_LEN			15
+
+/* Checksum Insertion Control or TCP Payload Length. */
+#define TX_NORMAL_DESC3_CIC_POS			16
+#define TX_NORMAL_DESC3_CIC_LEN			2
+#define TX_NORMAL_DESC3_TSE_POS			18 /* TCP Segmentation Enable. */
+#define TX_NORMAL_DESC3_TSE_LEN			1
+
+/* THL: TCP/UDP Header Length.If the TSE bit is set, this field contains
+ * the length of the TCP / UDP header.The minimum value of this field must
+ * be 5 for TCP header.The value must be equal to 2 for UDP header. This
+ * field is valid only for the first descriptor.
+ */
+#define TX_NORMAL_DESC3_TCPHDRLEN_POS		19
+#define TX_NORMAL_DESC3_TCPHDRLEN_LEN		4
+#define TX_NORMAL_DESC3_CPC_POS			26 /* CRC Pad Control. */
+#define TX_NORMAL_DESC3_CPC_LEN			2
+#define TX_NORMAL_DESC3_LD_POS			28 /* Last Descriptor. */
+#define TX_NORMAL_DESC3_LD_LEN			1
+#define TX_NORMAL_DESC3_FD_POS			29 /* First Descriptor. */
+#define TX_NORMAL_DESC3_FD_LEN			1
+/* Context Type.This bit should be set to 1'b0 for normal descriptor. */
+#define TX_NORMAL_DESC3_CTXT_POS		30
+#define TX_NORMAL_DESC3_CTXT_LEN		1
+#define TX_NORMAL_DESC3_OWN_POS			31 /* Own Bit. */
+#define TX_NORMAL_DESC3_OWN_LEN			1
+
+/* Phy generic register definitions count */
+#define FXGMAC_PHY_REG_CNT		32
+
+#define PHY_SPEC_CTRL			0x10  /* PHY specific func control */
+#define PHY_SPEC_STATUS			0x11  /* PHY specific status */
+#define PHY_INT_MASK			0x12  /* Interrupt mask register */
+#define PHY_INT_STATUS			0x13  /* Interrupt status register */
+#define PHY_DBG_ADDR			0x1e  /* Extended reg's address */
+#define PHY_DBG_DATA			0x1f  /* Extended reg's date */
+
+#define PHY_SPEC_CTRL_CRS_ON		0x0008 /* PHY specific func control */
+
+/* PHY specific status */
+#define PHY_SPEC_STATUS_DUPLEX		0x2000
+#define PHY_SPEC_STATUS_LINK		0x0400
+
+/* Interrupt mask register */
+#define PHY_INT_MASK_LINK_UP		0x0400
+#define PHY_INT_MASK_LINK_DOWN		0x0800
+
+#define PHY_EXT_SLEEP_CONTROL1			0x27
+#define PHY_EXT_ANALOG_CFG2			0x51
+#define PHY_EXT_ANALOG_CFG3			0x52
+#define PHY_EXT_ANALOG_CFG8			0x57
+#define PHY_EXT_COMMON_LED_CFG			0xa00b
+#define PHY_EXT_COMMON_LED0_CFG			0xa00c
+#define PHY_EXT_COMMON_LED1_CFG			0xa00d
+#define PHY_EXT_COMMON_LED2_CFG			0xa00e
+#define PHY_EXT_COMMON_LED_BLINK_CFG		0xa00f
+
+#define PHY_EXT_SLEEP_CONTROL1_PLLON_IN_SLP	0x4000
+
+#define PHY_EXT_ANALOG_CFG2_VAL			0x4a9
+
+#define PHY_EXT_ANALOG_CFG3_ADC_START_CFG	GENMASK(15, 14)
+
+#define PHY_EXT_ANALOG_CFG8_VAL			0x274c
+
+#define FXGMAC_ADVERTISE_1000_CAP (ADVERTISE_1000FULL | ADVERTISE_1000HALF)
+#define FXGMAC_ADVERTISE_100_10_CAP                                            \
+	(ADVERTISE_100FULL | ADVERTISE_100HALF | ADVERTISE_10FULL | \
+	 ADVERTISE_10HALF)
+
+/* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
+#define field_get(_mask, _reg)	(((_reg) & (_mask)) >> (ffs(_mask) - 1))
+#define field_prep(_mask, _val)	(((_val) << (ffs(_mask) - 1)) & (_mask))
+
+#define FXGMAC_SET_BITS_MASK(_pos, _len) GENMASK((_pos) + _len - 1, (_pos))
+
+#define FXGMAC_GET_BITS(_var, _pos, _len)                                      \
+	field_get(FXGMAC_SET_BITS_MASK(_pos, _len), _var)
+
+#define FXGMAC_GET_BITS_LE(_var, _pos, _len)                                   \
+	field_get(FXGMAC_SET_BITS_MASK(_pos, _len), le32_to_cpu(_var))
+
+static inline u32 fxgmac_set_bits(u32 *val, u32 pos, u32 len, u32 set_val)
+{
+	u32 mask = FXGMAC_SET_BITS_MASK(pos, len);
+	u32 new_val = *val;
+
+	new_val &= ~mask;
+	new_val |= field_prep(mask, set_val);
+	*val = new_val;
+
+	return new_val;
+}
+
+static inline u32 fxgmac_set_bits_le(u32 *old_val, u32 pos, u32 len,
+				     u32 set_val)
+{
+	*old_val = cpu_to_le32(fxgmac_set_bits(old_val, pos, len, set_val));
+	return *old_val;
+}
+
+#define rd32_mac(pdata, addr)	(readl((pdata)->hw_addr + MAC_OFFSET + (addr)))
+#define wr32_mac(pdata, val, addr)                                             \
+	(writel(val, (pdata)->hw_addr + MAC_OFFSET + (addr)))
+
+#define rd32_mem(pdata, addr)		(readl((pdata)->hw_addr + (addr)))
+#define wr32_mem(pdata, val, addr)	(writel(val, (pdata)->hw_addr + (addr)))
+
+#define FXGMAC_MTL_REG(n, reg)		(MTL_Q_BASE + ((n) * MTL_Q_INC) + (reg))
+#define FXGMAC_DMA_REG(channel, reg)	(((channel)->dma_reg_offset) + (reg))
+#define yt_err(yt, fmt, arg...)		dev_err((yt)->dev, fmt, ##arg)
+#define yt_dbg(yt, fmt, arg...)		dev_dbg((yt)->dev, fmt, ##arg)
+
+#endif /* YT6801_TYPE_H */
-- 
2.34.1


