Return-Path: <netdev+bounces-203578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D05AF6772
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 03:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0D3C7A21CA
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8E322D795;
	Thu,  3 Jul 2025 01:51:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0302206BE;
	Thu,  3 Jul 2025 01:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507481; cv=none; b=rKlVqg4CvZ27DFOsez0oM0mX0vEOmCdYsr3SimmpbXBE/Hylgbsjpt1A18LZJ8CnKMmzYgjhY2vEJwKINUJ7iLVrNqElI4AiMjwUQhTg72bDIl3Hup8zXp1yk6vmglMtA7ajEzxrni/gFarBFP9/j6e3XFxdwvMXc2ZhHJA3tfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507481; c=relaxed/simple;
	bh=6nh/VQZP1yp5oaO0NBYX4L0oSdeEk8O7IH7gIRviAbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Obh/LSxIqvT77wMK8JQMEbrmD6A0flbb3eScO7hv6jllMSxIojXXrOgHhwncRPUzMc7yc19sJaPg2syxn5lZkXDLLIQsTvsMPpjKOOASYq3HOxLgLfA8DfATw/IuE2GF6SoyX40X4tAV5kM3wF0WbuL7s7kNl3zKMNLCc0mCCc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz8t1751507382td1c89071
X-QQ-Originating-IP: xJeTsFil+XDuLv8iZYorRJWz8bl9sbrolKBgQiPhEQM=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Jul 2025 09:49:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9439932055034713164
EX-QQ-RecipientCnt: 22
From: Dong Yibo <dong100@mucse.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
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
	alexanderduyck@fb.com
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH 06/15] net: rnpgbe: Add some functions for hw->ops
Date: Thu,  3 Jul 2025 09:48:50 +0800
Message-Id: <20250703014859.210110-7-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250703014859.210110-1-dong100@mucse.com>
References: <20250703014859.210110-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N/18iCB8Aki/unHBuxg3fMIT/Vd2WPZCFwCIYECJOI+BYAzHpiA3/UfI
	/nVnI+5UWRU+hJwWZr7L/hlpDNiyk2pS6exYDbwotdFKAUa4bqisZlPmRYXAO2MIFtbaBP8
	vfut+6ihA9radWBWguhXHyKqI2m80SiK/qRnavRKLuWwiJmTlRmPwK/iJWYhFZTqO69J+pV
	2R7BbDjhAcFhtmNqZp67TA+ZlaadbC9V1dfLbfouc4Nz+xx9ypvI7lRKtzFPPVRfrOQsLzH
	tn765RjZeyZcepmK9mt0F9EVEpfXwzgoXkIsZnsvB02PQrXzeMDLavHlAekd00LLHktUQXs
	SXKKL9BE52MHLe+Ju8dR3X5qbqppG9Rhs64PPhHEf1WKBbYy8ZcFVgoGi6z2zOxnkRU1APZ
	c7JmYAFctp+edWudQAk7r2O/INmMLm5XYXpZTdrWH1Ohch3tBhiayfsHTdocjZZH0GJtGfZ
	1iy9KHRG42TM+2F3FgTsjseVsglfByg6A3Pda0KpZS8CIPyu0rrjjtS9mXv1cW4Mk9O3UhO
	SOz5Cx/y6sBflhZ5s9cmpyFfMEe5ouvO42PyPP/1EbANT5q9k0ew5SnAqytI5FSxASZ1mXr
	NLCeDFc8oXNy8OQ52cQGaL7qm4662gS5qm9WmrOoz8t52fU2an/+/0Osna2tGzZ4jnMGD0S
	74vUtshPswjjTULF6pjBwV4KrTH3LDPnjC8hnjv4Ujt3RRwSUQjBi5S+1CfddhFHk364Lx9
	oteReGVwTQWaYIyhhvD/mZ9YR/HCMf4RQr+KZ3NiIePA2DCWdblBWW9ChhhbRd8AjgbTx7t
	vqo9ttBevYh/J/mXgqlekXHU8p/I531PqiMyNFlWYXybMrBhA4hFXBAxBpUZ0nCpkRsi8Lf
	/NBYwjDJavMzIz1b2B/o1kRpwsPTTIGq5HeYb4Hce0TYyIaRJrGa6aFxPHd73tLxBm4Pjzf
	OXGRGLZuk0uIz0zgtot2RLdHVjwNRjJeOAaN1+3C2MTFScvnM0Hzt6ry0Qpv9QZK/TnXYrd
	mrqMJMfdhmzKUjPGTrJcrHtpTvdmA=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Initialize functions (init, reset ...) to control chip.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  39 +++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  90 ++++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  15 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  27 ++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |   5 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 209 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |  76 ++++++-
 7 files changed, 452 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 4e07d39d55ba..17297f9ff9c1 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -145,6 +145,25 @@ struct mucse_mbx_info {
 
 #include "rnpgbe_mbx.h"
 
+struct lldp_status {
+	int enable;
+	int inteval;
+};
+
+struct mucse_hw_operations {
+	int (*init_hw)(struct mucse_hw *hw);
+	int (*reset_hw)(struct mucse_hw *hw);
+	void (*start_hw)(struct mucse_hw *hw);
+	/* ops to fw */
+	void (*driver_status)(struct mucse_hw *hw, bool enable, int mode);
+};
+
+enum {
+	mucse_driver_insmod,
+	mucse_driver_suspuse,
+	mucse_driver_force_control_phy,
+};
+
 struct mucse_hw {
 	void *back;
 	u8 pfvfnum;
@@ -167,6 +186,7 @@ struct mucse_hw {
 	int max_vfs;
 	int max_vfs_noari;
 	enum rnpgbe_hw_type hw_type;
+	struct mucse_hw_operations ops;
 	struct mucse_dma_info dma;
 	struct mucse_eth_info eth;
 	struct mucse_mac_info mac;
@@ -191,7 +211,11 @@ struct mucse_hw {
 #define M_HW_FEATURE_EEE ((u32)(1 << 17))
 #define M_HW_SOFT_MASK_OTHER_IRQ ((u32)(1 << 18))
 	u32 feature_flags;
+	u32 driver_version;
 	u16 usecstocount;
+	int nr_lane;
+	struct lldp_status lldp_status;
+	int link;
 };
 
 struct mucse {
@@ -223,7 +247,18 @@ struct rnpgbe_info {
 #define PCI_DEVICE_ID_N210 0x8208
 #define PCI_DEVICE_ID_N210L 0x820a
 
-#define rnpgbe_rd_reg(reg) readl((void *)(reg))
-#define rnpgbe_wr_reg(reg, val) writel((val), (void *)(reg))
+#define m_rd_reg(reg) readl((void *)(reg))
+#define m_wr_reg(reg, val) writel((val), (void *)(reg))
+#define hw_wr32(hw, reg, val) m_wr_reg((hw)->hw_addr + (reg), (val))
+#define dma_wr32(dma, reg, val) m_wr_reg((dma)->dma_base_addr + (reg), (val))
+#define dma_rd32(dma, reg) m_rd_reg((dma)->dma_base_addr + (reg))
+#define eth_wr32(eth, reg, val) m_wr_reg((eth)->eth_base_addr + (reg), (val))
+#define eth_rd32(eth, reg) m_rd_reg((eth)->eth_base_addr + (reg))
+
+#define mucse_err(mucse, fmt, arg...) \
+	dev_err(&(mucse)->pdev->dev, fmt, ##arg)
+
+#define mucse_dbg(mucse, fmt, arg...) \
+	dev_dbg(&(mucse)->pdev->dev, fmt, ##arg)
 
 #endif /* _RNPGBE_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index 08d082fa3066..c495a6f79fd0 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -7,6 +7,94 @@
 #include "rnpgbe.h"
 #include "rnpgbe_hw.h"
 #include "rnpgbe_mbx.h"
+#include "rnpgbe_mbx_fw.h"
+
+static int rnpgbe_init_hw_ops_n500(struct mucse_hw *hw)
+{
+	int status = 0;
+	/* Reset the hardware */
+	status = hw->ops.reset_hw(hw);
+	if (status == 0)
+		hw->ops.start_hw(hw);
+
+	return status;
+}
+
+/**
+ * rnpgbe_reset_hw_ops_n500 - Do a hardware reset
+ * @hw: hw information structure
+ *
+ * rnpgbe_reset_hw_ops_n500 calls fw to do a hardware
+ * reset, and cleans some regs to default.
+ *
+ **/
+static int rnpgbe_reset_hw_ops_n500(struct mucse_hw *hw)
+{
+	int i;
+	struct mucse_dma_info *dma = &hw->dma;
+	struct mucse_eth_info *eth = &hw->eth;
+	/* Call adapter stop to dma */
+	dma_wr32(dma, RNPGBE_DMA_AXI_EN, 0);
+	if (mucse_mbx_fw_reset_phy(hw))
+		return -EIO;
+
+	eth_wr32(eth, RNPGBE_ETH_ERR_MASK_VECTOR,
+		 RNPGBE_PKT_LEN_ERR | RNPGBE_HDR_LEN_ERR);
+	dma_wr32(dma, RNPGBE_DMA_RX_PROG_FULL_THRESH, 0xa);
+	for (i = 0; i < 12; i++)
+		m_wr_reg(hw->ring_msix_base + RING_VECTOR(i), 0);
+
+	hw->link = 0;
+
+	return 0;
+}
+
+/**
+ * rnpgbe_start_hw_ops_n500 - Setup hw to start
+ * @hw: hw information structure
+ *
+ * rnpgbe_start_hw_ops_n500 initializes default
+ * hw status, ready to start.
+ *
+ **/
+static void rnpgbe_start_hw_ops_n500(struct mucse_hw *hw)
+{
+	struct mucse_eth_info *eth = &hw->eth;
+	struct mucse_dma_info *dma = &hw->dma;
+	u32 value;
+
+	value = dma_rd32(dma, RNPGBE_DMA_DUMY);
+	value |= BIT(0);
+	dma_wr32(dma, RNPGBE_DMA_DUMY, value);
+	dma_wr32(dma, RNPGBE_DMA_CONFIG, DMA_VEB_BYPASS);
+	dma_wr32(dma, RNPGBE_DMA_AXI_EN, (RX_AXI_RW_EN | TX_AXI_RW_EN));
+	eth_wr32(eth, RNPGBE_ETH_BYPASS, 0);
+	eth_wr32(eth, RNPGBE_ETH_DEFAULT_RX_RING, 0);
+}
+
+static void rnpgbe_driver_status_hw_ops_n500(struct mucse_hw *hw,
+					     bool enable,
+					     int mode)
+{
+	switch (mode) {
+	case mucse_driver_insmod:
+		mucse_mbx_ifinsmod(hw, enable);
+		break;
+	case mucse_driver_suspuse:
+		mucse_mbx_ifsuspuse(hw, enable);
+		break;
+	case mucse_driver_force_control_phy:
+		mucse_mbx_ifforce_control_mac(hw, enable);
+		break;
+	}
+}
+
+static struct mucse_hw_operations hw_ops_n500 = {
+	.init_hw = &rnpgbe_init_hw_ops_n500,
+	.reset_hw = &rnpgbe_reset_hw_ops_n500,
+	.start_hw = &rnpgbe_start_hw_ops_n500,
+	.driver_status = &rnpgbe_driver_status_hw_ops_n500,
+};
 
 /**
  * rnpgbe_get_invariants_n500 - setup for hw info
@@ -80,7 +168,9 @@ static void rnpgbe_get_invariants_n500(struct mucse_hw *hw)
 		M_NET_FEATURE_STAG_FILTER | M_NET_FEATURE_STAG_OFFLOAD;
 	/* start the default ahz, update later*/
 	hw->usecstocount = 125;
+	hw->max_vfs_noari = 1;
 	hw->max_vfs = 7;
+	memcpy(&hw->ops, &hw_ops_n500, sizeof(hw->ops));
 }
 
 static void rnpgbe_get_invariants_n210(struct mucse_hw *hw)
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index ff7bd9b21550..35e3cb77a38b 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -14,8 +14,21 @@
 #define RNPGBE_RING_BASE (0x1000)
 #define RNPGBE_MAC_BASE (0x20000)
 #define RNPGBE_ETH_BASE (0x10000)
-
+/* dma regs */
+#define DMA_VEB_BYPASS BIT(4)
+#define RNPGBE_DMA_CONFIG (0x0004)
 #define RNPGBE_DMA_DUMY (0x000c)
+#define RNPGBE_DMA_AXI_EN (0x0010)
+#define RX_AXI_RW_EN (0x03 << 0)
+#define TX_AXI_RW_EN (0x03 << 2)
+#define RNPGBE_DMA_RX_PROG_FULL_THRESH (0x00a0)
+#define RING_VECTOR(n) (0x04 * (n))
+/* eth regs */
+#define RNPGBE_ETH_BYPASS (0x8000)
+#define RNPGBE_ETH_ERR_MASK_VECTOR (0x8060)
+#define RNPGBE_ETH_DEFAULT_RX_RING (0x806c)
+#define RNPGBE_PKT_LEN_ERR (2)
+#define RNPGBE_HDR_LEN_ERR (1)
 /* chip resourse */
 #define RNPGBE_MAX_QUEUES (8)
 /* multicast control table */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index a7b8eb53cd69..e811e9624ead 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -17,6 +17,7 @@ char rnpgbe_driver_name[] = "rnpgbe";
 static const char rnpgbe_driver_string[] =
 	"mucse 1 Gigabit PCI Express Network Driver";
 #define DRV_VERSION "1.0.0"
+static u32 driver_version = 0x01000000;
 const char rnpgbe_driver_version[] = DRV_VERSION;
 static const char rnpgbe_copyright[] =
 	"Copyright (c) 2020-2025 mucse Corporation.";
@@ -147,6 +148,11 @@ static int init_firmware_for_n210(struct mucse_hw *hw)
 	return err;
 }
 
+static int rnpgbe_sw_init(struct mucse *mucse)
+{
+	return 0;
+}
+
 /**
  * rnpgbe_add_adpater - add netdev for this pci_dev
  * @pdev: PCI device information structure
@@ -202,7 +208,7 @@ static int rnpgbe_add_adpater(struct pci_dev *pdev,
 		}
 
 		/* get dma version */
-		dma_version = rnpgbe_rd_reg(hw_addr);
+		dma_version = m_rd_reg(hw_addr);
 		break;
 	case rnpgbe_hw_n210:
 	case rnpgbe_hw_n210L:
@@ -219,7 +225,7 @@ static int rnpgbe_add_adpater(struct pci_dev *pdev,
 		}
 
 		/* get dma version */
-		dma_version = rnpgbe_rd_reg(hw_addr);
+		dma_version = m_rd_reg(hw_addr);
 		break;
 	default:
 		err = -EIO;
@@ -227,8 +233,12 @@ static int rnpgbe_add_adpater(struct pci_dev *pdev,
 	}
 	hw->hw_addr = hw_addr;
 	hw->dma.dma_version = dma_version;
+	hw->driver_version = driver_version;
+	hw->nr_lane = 0;
 	ii->get_invariants(hw);
 	hw->mbx.ops.init_params(hw);
+	/* echo fw driver insmod */
+	hw->ops.driver_status(hw, true, mucse_driver_insmod);
 
 	if (mucse_mbx_get_capability(hw)) {
 		dev_err(&pdev->dev,
@@ -237,6 +247,16 @@ static int rnpgbe_add_adpater(struct pci_dev *pdev,
 		goto err_free_net;
 	}
 
+	err = rnpgbe_sw_init(mucse);
+	if (err)
+		goto err_free_net;
+
+	err = hw->ops.reset_hw(hw);
+	if (err) {
+		dev_err(&pdev->dev, "Hw reset failed\n");
+		goto err_free_net;
+	}
+
 	return 0;
 
 err_free_net:
@@ -303,10 +323,13 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 static void rnpgbe_rm_adpater(struct mucse *mucse)
 {
 	struct net_device *netdev;
+	struct mucse_hw *hw = &mucse->hw;
 
 	netdev = mucse->netdev;
 	pr_info("= remove rnpgbe:%s =\n", netdev->name);
+	hw->ops.driver_status(hw, false, mucse_driver_insmod);
 	free_netdev(netdev);
+	mucse->netdev = NULL;
 	pr_info("remove complete\n");
 }
 
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
index 2040b86f4cad..fbb154051313 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
@@ -34,9 +34,8 @@ static inline u32 PF_VF_SHM(struct mucse_mbx_info *mbx, int vf)
 #define MBOX_CTRL_PF_HOLD_SHM (BIT(3)) /* VF:RO, PF:WR */
 #define MBOX_IRQ_EN 0
 #define MBOX_IRQ_DISABLE 1
-#define mbx_rd32(hw, reg) rnpgbe_rd_reg((hw)->hw_addr + (reg))
-#define mbx_wr32(hw, reg, val) rnpgbe_wr_reg((hw)->hw_addr + (reg), (val))
-#define hw_wr32(hw, reg, val) rnpgbe_wr_reg((hw)->hw_addr + (reg), (val))
+#define mbx_rd32(hw, reg) m_rd_reg((hw)->hw_addr + (reg))
+#define mbx_wr32(hw, reg, val) m_wr_reg((hw)->hw_addr + (reg), (val))
 
 extern struct mucse_mbx_operations mucse_mbx_ops_generic;
 
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
index 7fdfccdba80b..8e26ffcabfda 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
@@ -3,6 +3,7 @@
 
 #include <linux/pci.h>
 
+#include "rnpgbe.h"
 #include "rnpgbe_mbx_fw.h"
 
 /**
@@ -139,3 +140,211 @@ int mucse_mbx_get_capability(struct mucse_hw *hw)
 
 	return -EIO;
 }
+
+static struct mbx_req_cookie *mbx_cookie_zalloc(int priv_len)
+{
+	struct mbx_req_cookie *cookie;
+
+	cookie = kzalloc(struct_size(cookie, priv, priv_len), GFP_KERNEL);
+
+	if (cookie) {
+		cookie->timeout_jiffes = 30 * HZ;
+		cookie->magic = COOKIE_MAGIC;
+		cookie->priv_len = priv_len;
+	}
+
+	return cookie;
+}
+
+/**
+ * mucse_mbx_fw_post_req - Posts a mbx req to firmware and wait reply
+ * @hw: Pointer to the HW structure
+ * @req: Pointer to the cmd req structure
+ * @cookie: Pointer to the req cookie
+ *
+ * mucse_mbx_fw_post_req posts a mbx req to firmware and wait for the
+ * reply. cookie->wait will be set in irq handler.
+ *
+ * Returns 0 on success, negative on failure
+ **/
+static int mucse_mbx_fw_post_req(struct mucse_hw *hw,
+				 struct mbx_fw_cmd_req *req,
+				 struct mbx_req_cookie *cookie)
+{
+	int err = 0;
+
+	/* if pcie off, nothing todo */
+	if (pci_channel_offline(hw->pdev))
+		return -EIO;
+
+	cookie->errcode = 0;
+	cookie->done = 0;
+	init_waitqueue_head(&cookie->wait);
+
+	if (mutex_lock_interruptible(&hw->mbx.lock))
+		return -EAGAIN;
+
+	err = mucse_write_mbx(hw, (u32 *)req,
+			      L_WD(req->datalen + MBX_REQ_HDR_LEN),
+			      MBX_FW);
+	if (err) {
+		mutex_unlock(&hw->mbx.lock);
+		return err;
+	}
+
+	if (cookie->timeout_jiffes != 0) {
+retry:
+		err = wait_event_interruptible_timeout(cookie->wait,
+						       cookie->done == 1,
+						       cookie->timeout_jiffes);
+		if (err == -ERESTARTSYS)
+			goto retry;
+		if (err == 0)
+			err = -ETIME;
+		else
+			err = 0;
+	} else {
+		wait_event_interruptible(cookie->wait, cookie->done == 1);
+	}
+
+	mutex_unlock(&hw->mbx.lock);
+
+	if (cookie->errcode)
+		err = cookie->errcode;
+
+	return err;
+}
+
+int rnpgbe_mbx_lldp_get(struct mucse_hw *hw)
+{
+	int err;
+	struct mbx_req_cookie *cookie = NULL;
+	struct mbx_fw_cmd_reply reply;
+	struct mbx_fw_cmd_req req;
+	struct get_lldp_reply *get_lldp;
+
+	cookie = mbx_cookie_zalloc(sizeof(*get_lldp));
+	if (!cookie)
+		return -ENOMEM;
+
+	get_lldp = (struct get_lldp_reply *)cookie->priv;
+	memset(&req, 0, sizeof(req));
+	memset(&reply, 0, sizeof(reply));
+	build_get_lldp_req(&req, cookie, hw->nr_lane);
+	if (hw->mbx.other_irq_enabled) {
+		err = mucse_mbx_fw_post_req(hw, &req, cookie);
+	} else {
+		err = mucse_fw_send_cmd_wait(hw, &req, &reply);
+		get_lldp = &reply.get_lldp;
+	}
+
+	if (err == 0) {
+		hw->lldp_status.enable = get_lldp->value;
+		hw->lldp_status.inteval = get_lldp->inteval;
+	}
+
+	kfree(cookie);
+
+	return err ? -err : 0;
+}
+
+int mucse_mbx_ifinsmod(struct mucse_hw *hw, int status)
+{
+	int err;
+	struct mbx_fw_cmd_req req;
+	struct mbx_fw_cmd_reply reply;
+
+	memset(&req, 0, sizeof(req));
+	memset(&reply, 0, sizeof(reply));
+	build_ifinsmod(&req, hw->driver_version, status);
+	if (mutex_lock_interruptible(&hw->mbx.lock))
+		return -EAGAIN;
+
+	if (status) {
+		err = hw->mbx.ops.write_posted(hw, (u32 *)&req,
+				L_WD((req.datalen + MBX_REQ_HDR_LEN)),
+				MBX_FW);
+	} else {
+		err = hw->mbx.ops.write(hw, (u32 *)&req,
+				L_WD((req.datalen + MBX_REQ_HDR_LEN)),
+				MBX_FW);
+	}
+
+	mutex_unlock(&hw->mbx.lock);
+	return err;
+}
+
+int mucse_mbx_ifsuspuse(struct mucse_hw *hw, int status)
+{
+	int err;
+	struct mbx_fw_cmd_req req;
+	struct mbx_fw_cmd_reply reply;
+
+	memset(&req, 0, sizeof(req));
+	memset(&reply, 0, sizeof(reply));
+	build_ifsuspuse(&req, hw->nr_lane, status);
+	if (mutex_lock_interruptible(&hw->mbx.lock))
+		return -EAGAIN;
+
+	err = hw->mbx.ops.write_posted(hw, (u32 *)&req,
+				       L_WD((req.datalen + MBX_REQ_HDR_LEN)),
+				       MBX_FW);
+	mutex_unlock(&hw->mbx.lock);
+
+	return err;
+}
+
+int mucse_mbx_ifforce_control_mac(struct mucse_hw *hw, int status)
+{
+	int err;
+	struct mbx_fw_cmd_req req;
+	struct mbx_fw_cmd_reply reply;
+
+	memset(&req, 0, sizeof(req));
+	memset(&reply, 0, sizeof(reply));
+	build_ifforce(&req, hw->nr_lane, status);
+	if (mutex_lock_interruptible(&hw->mbx.lock))
+		return -EAGAIN;
+
+	err = hw->mbx.ops.write_posted(hw, (u32 *)&req,
+				       L_WD((req.datalen + MBX_REQ_HDR_LEN)),
+				       MBX_FW);
+	mutex_unlock(&hw->mbx.lock);
+
+	return err;
+}
+
+/**
+ * mucse_mbx_fw_reset_phy - Posts a mbx req to reset hw
+ * @hw: Pointer to the HW structure
+ *
+ * mucse_mbx_fw_reset_phy posts a mbx req to firmware to reset hw.
+ * It uses mucse_fw_send_cmd_wait if no irq, and mucse_mbx_fw_post_req
+ * if other irq is registered.
+ *
+ * Returns 0 on success, negative on failure
+ **/
+int mucse_mbx_fw_reset_phy(struct mucse_hw *hw)
+{
+	struct mbx_fw_cmd_req req;
+	struct mbx_fw_cmd_reply reply;
+	int ret;
+
+	memset(&req, 0, sizeof(req));
+	memset(&reply, 0, sizeof(reply));
+	if (hw->mbx.other_irq_enabled) {
+		struct mbx_req_cookie *cookie = mbx_cookie_zalloc(0);
+
+		if (!cookie)
+			return -ENOMEM;
+
+		build_reset_phy_req(&req, cookie);
+		ret = mucse_mbx_fw_post_req(hw, &req, cookie);
+		kfree(cookie);
+		return ret;
+
+	} else {
+		build_reset_phy_req(&req, &req);
+		return mucse_fw_send_cmd_wait(hw, &req, &reply);
+	}
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
index c5f2c3ff4068..66d8cd02bc0e 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
@@ -25,7 +25,7 @@ struct mbx_req_cookie {
 	wait_queue_head_t wait;
 	int done;
 	int priv_len;
-	char priv[64];
+	char priv[];
 };
 
 enum MUCSE_FW_CMD {
@@ -525,6 +525,80 @@ static inline void build_phy_abalities_req(struct mbx_fw_cmd_req *req,
 	req->cookie = cookie;
 }
 
+static inline void build_get_lldp_req(struct mbx_fw_cmd_req *req, void *cookie,
+				      int nr_lane)
+{
+#define LLDP_TX_GET (1)
+
+	req->flags = 0;
+	req->opcode = LLDP_TX_CTRL;
+	req->datalen = sizeof(req->lldp_tx);
+	req->cookie = cookie;
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+	req->lldp_tx.lane = nr_lane;
+	req->lldp_tx.op = LLDP_TX_GET;
+	req->lldp_tx.enable = 0;
+}
+
+static inline void build_ifinsmod(struct mbx_fw_cmd_req *req,
+				  unsigned int nr_lane,
+				  int status)
+{
+	req->flags = 0;
+	req->opcode = DRIVER_INSMOD;
+	req->datalen = sizeof(req->ifinsmod);
+	req->cookie = NULL;
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+	req->ifinsmod.lane = nr_lane;
+	req->ifinsmod.status = status;
+}
+
+static inline void build_ifsuspuse(struct mbx_fw_cmd_req *req,
+				   unsigned int nr_lane,
+				   int status)
+{
+	req->flags = 0;
+	req->opcode = SYSTEM_SUSPUSE;
+	req->datalen = sizeof(req->ifsuspuse);
+	req->cookie = NULL;
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+	req->ifinsmod.lane = nr_lane;
+	req->ifinsmod.status = status;
+}
+
+static inline void build_ifforce(struct mbx_fw_cmd_req *req,
+				 unsigned int nr_lane,
+				 int status)
+{
+	req->flags = 0;
+	req->opcode = SYSTEM_FORCE;
+	req->datalen = sizeof(req->ifforce);
+	req->cookie = NULL;
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+	req->ifforce.lane = nr_lane;
+	req->ifforce.status = status;
+}
+
+static inline void build_reset_phy_req(struct mbx_fw_cmd_req *req,
+				       void *cookie)
+{
+	req->flags = 0;
+	req->opcode = RESET_PHY;
+	req->datalen = 0;
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+	req->cookie = cookie;
+}
+
 int mucse_mbx_get_capability(struct mucse_hw *hw);
+int rnpgbe_mbx_lldp_get(struct mucse_hw *hw);
+int mucse_mbx_ifinsmod(struct mucse_hw *hw, int status);
+int mucse_mbx_ifsuspuse(struct mucse_hw *hw, int status);
+int mucse_mbx_ifforce_control_mac(struct mucse_hw *hw, int status);
+int mucse_mbx_fw_reset_phy(struct mucse_hw *hw);
 
 #endif /* _RNPGBE_MBX_FW_H */
-- 
2.25.1


