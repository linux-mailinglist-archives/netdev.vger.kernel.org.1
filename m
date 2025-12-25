Return-Path: <netdev+bounces-246045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA374CDD6BE
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 08:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 530AD3019860
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 07:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAE82F25F4;
	Thu, 25 Dec 2025 07:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b="NbrdSO1Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail113.out.titan.email (mail113.out.titan.email [3.230.178.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E392F39A1
	for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 07:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.230.178.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766647617; cv=none; b=WEaC484AP7PeCt3zLOzW/PAaN82HN8/IskOJSKGUOCZYfdfJPBDGiMbdQLXRUWUj1n7LT6ENW+D9RmR1GnTbNRnvZP8jMAZt3dGY+/vl4acNcm56vEoQNGlX/FWhaYQ+MmwsnymjR92hSqzQbaBEdOCWWb8/vNiBGUED6oXlzBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766647617; c=relaxed/simple;
	bh=AaCxfGbs4G0zIDvCCJ3w80prViNwKEAn35srwoDj0cE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1tLyP9RIkSC6581FT2EfIU1a+GtEGHMT+PS/hn4Nntqq7UKHsmaa4TjKpE3oMrsJGNuenTBKuMuJqYaILms9Ha8QjN1XKbBi+9cwF5Y6G983gbNHckPvNtShw0ckuTOybq3d/1Rnq4DtrjJQEU4KFBWdwo/cPtz5RjJHiuq0d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b=NbrdSO1Y; arc=none smtp.client-ip=3.230.178.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 4dcKrd4rsxz7t9b;
	Thu, 25 Dec 2025 07:20:01 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=2DtVVUURSyn+eJnDGDo+nTrPZa0VEF6APFfdZSkIL6Y=;
	c=relaxed/relaxed; d=ziyao.cc;
	h=to:cc:references:from:date:mime-version:subject:message-id:in-reply-to:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1766647201; v=1;
	b=NbrdSO1YzIMnYV1jNIx6lszb+2Tt6wjWzs7ZWvPSvUv7rkFsgeljyBU82Kba+zN3ZoGimOof
	+HlSgAQMAMysAoA+yZLl8byexEy3XL3AhOo8iWzOVrP15nVXHbeVB0rRWpTkPhBQ0Gf95TpqqjY
	vFtdk+orHtYuB17A5SuzOWUU=
Received: from ketchup (unknown [117.171.66.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp-out.flockmail.com (Postfix) with ESMTPSA id 4dcKrW4jg2z7t7x;
	Thu, 25 Dec 2025 07:19:55 +0000 (UTC)
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
From: Yao Zi <me@ziyao.cc>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Yao Zi <me@ziyao.cc>,
	Runhua He <hua@aosc.io>,
	Xi Ruoyao <xry111@xry111.site>
Subject: [RFC PATCH net-next v5 2/3] net: stmmac: Add glue driver for Motorcomm YT6801 ethernet controller
Date: Thu, 25 Dec 2025 07:19:13 +0000
Message-ID: <20251225071914.1903-3-me@ziyao.cc>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251225071914.1903-1-me@ziyao.cc>
References: <20251225071914.1903-1-me@ziyao.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1766647201450675091.30087.132984512848861048@prod-use1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=WtDRMcfv c=1 sm=1 tr=0 ts=694ce5a1
	a=rBp+3XZz9uO5KTvnfbZ58A==:117 a=rBp+3XZz9uO5KTvnfbZ58A==:17
	a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10 a=CEWIc4RMnpUA:10
	a=I1Pul6OlCCIL1mTB2g4A:9 a=3z85VNIBY5UIEeAh_hcH:22
	a=NWVoK91CQySWRX1oVYDe:22

Motorcomm YT6801 is a PCIe ethernet controller based on DWMAC4 IP. It
integrates an GbE phy, supporting WOL, VLAN tagging and various types
of offloading. It ships an on-chip eFuse for storing various vendor
configuration, including MAC address.

This patch adds basic glue code for the controller, allowing it to be
set up and transmit data at a reasonable speed. Features like WOL could
be implemented in the future.

Signed-off-by: Yao Zi <me@ziyao.cc>
Tested-by: Mingcong Bai <jeffbai@aosc.io>
Tested-by: Runhua He <hua@aosc.io>
Tested-by: Xi Ruoyao <xry111@xry111.site>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   9 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-motorcomm.c | 386 ++++++++++++++++++
 3 files changed, 396 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 907fe2e927f0..07088d03dbab 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -374,6 +374,15 @@ config DWMAC_LOONGSON
 	  This selects the LOONGSON PCI bus support for the stmmac driver,
 	  Support for ethernet controller on Loongson-2K1000 SoC and LS7A1000 bridge.
 
+config DWMAC_MOTORCOMM
+	tristate "Motorcomm PCI DWMAC support"
+	depends on PCI
+	select MOTORCOMM_PHY
+	select STMMAC_LIBPCI
+	help
+	  This enables glue driver for Motorcomm DWMAC-based PCI Ethernet
+	  controllers. Currently only YT6801 is supported.
+
 config STMMAC_PCI
 	tristate "STMMAC PCI bus support"
 	depends on PCI
diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index 7bf528731034..c9263987ef8d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -48,4 +48,5 @@ obj-$(CONFIG_STMMAC_LIBPCI)	+= stmmac_libpci.o
 obj-$(CONFIG_STMMAC_PCI)	+= stmmac-pci.o
 obj-$(CONFIG_DWMAC_INTEL)	+= dwmac-intel.o
 obj-$(CONFIG_DWMAC_LOONGSON)	+= dwmac-loongson.o
+obj-$(CONFIG_DWMAC_MOTORCOMM)	+= dwmac-motorcomm.o
 stmmac-pci-objs:= stmmac_pci.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
new file mode 100644
index 000000000000..e1630f5bd65f
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
@@ -0,0 +1,386 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * DWMAC glue driver for Motorcomm PCI Ethernet controllers
+ *
+ * Copyright (c) 2025 Yao Zi <me@ziyao.cc>
+ */
+
+#include <linux/bits.h>
+#include <linux/dev_printk.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/stmmac.h>
+
+#include "dwmac4.h"
+#include "stmmac.h"
+#include "stmmac_libpci.h"
+
+#define DRIVER_NAME "dwmac-motorcomm"
+
+#define PCI_VENDOR_ID_MOTORCOMM			0x1f0a
+
+/* Register definition */
+#define EPHY_CTRL				0x1004
+/* Clearing this bit asserts resets for internal MDIO bus and PHY */
+#define  EPHY_MDIO_PHY_RESET			BIT(0)
+#define OOB_WOL_CTRL				0x1010
+#define  OOB_WOL_CTRL_DIS			BIT(0)
+#define MGMT_INT_CTRL0				0x1100
+#define INT_MODERATION				0x1108
+#define  INT_MODERATION_RX			GENMASK(11, 0)
+#define  INT_MODERATION_TX			GENMASK(27, 16)
+#define EFUSE_OP_CTRL_0				0x1500
+#define  EFUSE_OP_MODE				GENMASK(1, 0)
+#define   EFUSE_OP_ROW_READ			0x1
+#define  EFUSE_OP_START				BIT(2)
+#define  EFUSE_OP_ADDR				GENMASK(15, 8)
+#define EFUSE_OP_CTRL_1				0x1504
+#define  EFUSE_OP_DONE				BIT(1)
+#define  EFUSE_OP_RD_DATA			GENMASK(31, 24)
+#define SYS_RESET				0x152c
+#define  SYS_RESET_RESET			BIT(31)
+#define GMAC_OFFSET				0x2000
+
+/* Constants */
+#define EFUSE_READ_TIMEOUT_US			20000
+#define EFUSE_PATCH_REGION_OFFSET		18
+#define EFUSE_PATCH_MAX_NUM			39
+#define EFUSE_ADDR_MACA0LR			0x1520
+#define EFUSE_ADDR_MACA0HR			0x1524
+
+struct motorcomm_efuse_patch {
+	__le16 addr;
+	__le32 data;
+} __packed;
+
+struct dwmac_motorcomm_priv {
+	void __iomem *base;
+	struct device *dev;
+};
+
+static int motorcomm_efuse_read_byte(struct dwmac_motorcomm_priv *priv,
+				     u8 offset, u8 *byte)
+{
+	u32 reg;
+	int ret;
+
+	writel(FIELD_PREP(EFUSE_OP_MODE, EFUSE_OP_ROW_READ)	|
+	       FIELD_PREP(EFUSE_OP_ADDR, offset)		|
+	       EFUSE_OP_START, priv->base + EFUSE_OP_CTRL_0);
+
+	ret = readl_poll_timeout(priv->base + EFUSE_OP_CTRL_1,
+				 reg, reg & EFUSE_OP_DONE, 2000,
+				 EFUSE_READ_TIMEOUT_US);
+
+	*byte = FIELD_GET(EFUSE_OP_RD_DATA, reg);
+
+	return ret;
+}
+
+static int motorcomm_efuse_read_patch(struct dwmac_motorcomm_priv *priv,
+				      u8 index,
+				      struct motorcomm_efuse_patch *patch)
+{
+	u8 *p = (u8 *)patch, offset;
+	int i, ret;
+
+	for (i = 0; i < sizeof(*patch); i++) {
+		offset = EFUSE_PATCH_REGION_OFFSET + sizeof(*patch) * index + i;
+
+		ret = motorcomm_efuse_read_byte(priv, offset, &p[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int motorcomm_efuse_get_patch_value(struct dwmac_motorcomm_priv *priv,
+					   u16 addr, u32 *value)
+{
+	struct motorcomm_efuse_patch patch;
+	int i, ret;
+
+	for (i = 0; i < EFUSE_PATCH_MAX_NUM; i++) {
+		ret = motorcomm_efuse_read_patch(priv, i, &patch);
+		if (ret)
+			return ret;
+
+		if (patch.addr == 0) {
+			return -ENOENT;
+		} else if (le16_to_cpu(patch.addr) == addr) {
+			*value = le32_to_cpu(patch.data);
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
+static int motorcomm_efuse_read_mac(struct dwmac_motorcomm_priv *priv, u8 *mac)
+{
+	u32 maca0lr, maca0hr;
+	int ret;
+
+	ret = motorcomm_efuse_get_patch_value(priv, EFUSE_ADDR_MACA0LR,
+					      &maca0lr);
+	if (ret)
+		return dev_err_probe(priv->dev, ret,
+				     "failed to read maca0lr from eFuse\n");
+
+	ret = motorcomm_efuse_get_patch_value(priv, EFUSE_ADDR_MACA0HR,
+					      &maca0hr);
+	if (ret)
+		return dev_err_probe(priv->dev, ret,
+				     "failed to read maca0hr from eFuse\n");
+
+	mac[0] = FIELD_GET(GENMASK(15, 8), maca0hr);
+	mac[1] = FIELD_GET(GENMASK(7, 0), maca0hr);
+	mac[2] = FIELD_GET(GENMASK(31, 24), maca0lr);
+	mac[3] = FIELD_GET(GENMASK(23, 16), maca0lr);
+	mac[4] = FIELD_GET(GENMASK(15, 8), maca0lr);
+	mac[5] = FIELD_GET(GENMASK(7, 0), maca0lr);
+
+	return 0;
+}
+
+static void motorcomm_deassert_mdio_phy_reset(struct dwmac_motorcomm_priv *priv)
+{
+	u32 reg = readl(priv->base + EPHY_CTRL);
+
+	reg |= EPHY_MDIO_PHY_RESET;
+
+	writel(reg, priv->base + EPHY_CTRL);
+}
+
+static void motorcomm_reset(struct dwmac_motorcomm_priv *priv)
+{
+	u32 reg = readl(priv->base + SYS_RESET);
+
+	reg &= ~SYS_RESET_RESET;
+	writel(reg, priv->base + SYS_RESET);
+
+	reg |= SYS_RESET_RESET;
+	writel(reg, priv->base + SYS_RESET);
+
+	motorcomm_deassert_mdio_phy_reset(priv);
+}
+
+static void motorcomm_init(struct dwmac_motorcomm_priv *priv)
+{
+	writel(0x0, priv->base + MGMT_INT_CTRL0);
+
+	writel(FIELD_PREP(INT_MODERATION_RX, 200) |
+	       FIELD_PREP(INT_MODERATION_TX, 200),
+	       priv->base + INT_MODERATION);
+
+	/*
+	 * OOB WOL must be disabled during normal operation, or DMA interrupts
+	 * cannot be delivered to the host.
+	 */
+	writel(OOB_WOL_CTRL_DIS, priv->base + OOB_WOL_CTRL);
+}
+
+static int motorcomm_resume(struct device *dev, void *bsp_priv)
+{
+	struct dwmac_motorcomm_priv *priv = bsp_priv;
+	int ret;
+
+	ret = stmmac_pci_plat_resume(dev, bsp_priv);
+	if (ret)
+		return ret;
+
+	/*
+	 * When recovering from D3hot, EPHY_MDIO_PHY_RESET is automatically
+	 * asserted, and must be deasserted for normal operation.
+	 */
+	motorcomm_deassert_mdio_phy_reset(priv);
+	motorcomm_init(priv);
+
+	return 0;
+}
+
+static struct plat_stmmacenet_data *
+motorcomm_default_plat_data(struct pci_dev *pdev)
+{
+	struct plat_stmmacenet_data *plat;
+	struct device *dev = &pdev->dev;
+
+	plat = stmmac_plat_dat_alloc(dev);
+	if (!plat)
+		return NULL;
+
+	plat->mdio_bus_data = devm_kzalloc(dev, sizeof(*plat->mdio_bus_data),
+					   GFP_KERNEL);
+	if (!plat->mdio_bus_data)
+		return NULL;
+
+	plat->dma_cfg = devm_kzalloc(dev, sizeof(*plat->dma_cfg), GFP_KERNEL);
+	if (!plat->dma_cfg)
+		return NULL;
+
+	plat->axi = devm_kzalloc(dev, sizeof(*plat->axi), GFP_KERNEL);
+	if (!plat->axi)
+		return NULL;
+
+	plat->dma_cfg->pbl		= DEFAULT_DMA_PBL;
+	plat->dma_cfg->pblx8		= true;
+	plat->dma_cfg->txpbl		= 32;
+	plat->dma_cfg->rxpbl		= 32;
+	plat->dma_cfg->eame		= true;
+	plat->dma_cfg->mixed_burst	= true;
+
+	plat->axi->axi_wr_osr_lmt	= 1;
+	plat->axi->axi_rd_osr_lmt	= 1;
+	plat->axi->axi_mb		= true;
+	plat->axi->axi_blen_regval	= DMA_AXI_BLEN4 | DMA_AXI_BLEN8 |
+					  DMA_AXI_BLEN16 | DMA_AXI_BLEN32;
+
+	plat->bus_id		= pci_dev_id(pdev);
+	plat->phy_interface	= PHY_INTERFACE_MODE_GMII;
+	/*
+	 * YT6801 requires an 25MHz clock input/oscillator to function, which
+	 * is likely the source of CSR clock.
+	 */
+	plat->clk_csr		= STMMAC_CSR_20_35M;
+	plat->tx_coe		= 1;
+	plat->rx_coe		= 1;
+	plat->clk_ref_rate	= 125000000;
+	plat->core_type		= DWMAC_CORE_GMAC4;
+	plat->suspend		= stmmac_pci_plat_suspend;
+	plat->resume		= motorcomm_resume;
+	plat->flags		= STMMAC_FLAG_TSO_EN |
+				  STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP;
+
+	return plat;
+}
+
+static void motorcomm_free_irq(void *data)
+{
+	struct pci_dev *pdev = data;
+
+	pci_free_irq_vectors(pdev);
+}
+
+static int motorcomm_setup_irq(struct pci_dev *pdev,
+			       struct stmmac_resources *res,
+			       struct plat_stmmacenet_data *plat)
+{
+	int ret;
+
+	ret = pci_alloc_irq_vectors(pdev, 6, 6, PCI_IRQ_MSIX);
+	if (ret > 0) {
+		res->rx_irq[0]	= pci_irq_vector(pdev, 0);
+		res->tx_irq[0]	= pci_irq_vector(pdev, 4);
+		res->irq	= pci_irq_vector(pdev, 5);
+
+		plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
+	} else {
+		dev_info(&pdev->dev, "failed to allocate MSI-X vector: %d\n",
+			 ret);
+		dev_info(&pdev->dev, "try MSI instead\n");
+
+		ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
+		if (ret < 0)
+			return dev_err_probe(&pdev->dev, ret,
+					     "failed to allocate MSI\n");
+
+		res->irq = pci_irq_vector(pdev, 0);
+	}
+
+	return devm_add_action_or_reset(&pdev->dev, motorcomm_free_irq, pdev);
+}
+
+static int motorcomm_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct plat_stmmacenet_data *plat;
+	struct dwmac_motorcomm_priv *priv;
+	struct stmmac_resources res = {};
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+
+	plat = motorcomm_default_plat_data(pdev);
+	if (!plat)
+		return -ENOMEM;
+
+	plat->bsp_priv = priv;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to enable device\n");
+
+	priv->base = pcim_iomap_region(pdev, 0, DRIVER_NAME);
+	if (IS_ERR(priv->base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->base),
+				     "failed to map IO region\n");
+
+	pci_set_master(pdev);
+
+	/*
+	 * Some PCIe addons cards based on YT6801 don't deliver MSI(X) with ASPM
+	 * enabled. Sadly there isn't a reliable way to read out OEM of the
+	 * card, so let's disable L1 state unconditionally for safety.
+	 */
+	ret = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1);
+	if (ret)
+		dev_warn(&pdev->dev, "failed to disable L1 state: %d\n", ret);
+
+	motorcomm_reset(priv);
+
+	ret = motorcomm_efuse_read_mac(priv, res.mac);
+	if (ret == -ENOENT) {
+		dev_warn(&pdev->dev, "eFuse contains no valid MAC address\n");
+		dev_warn(&pdev->dev, "fallback to random MAC address\n");
+
+		eth_random_addr(res.mac);
+	} else if (ret) {
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to read MAC address from eFuse\n");
+	}
+
+	ret = motorcomm_setup_irq(pdev, &res, plat);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to setup IRQ\n");
+
+	motorcomm_init(priv);
+
+	res.addr = priv->base + GMAC_OFFSET;
+
+	return stmmac_dvr_probe(&pdev->dev, plat, &res);
+}
+
+static void motorcomm_remove(struct pci_dev *pdev)
+{
+	stmmac_dvr_remove(&pdev->dev);
+}
+
+static const struct pci_device_id dwmac_motorcomm_pci_id_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOTORCOMM, 0x6801) },
+	{ },
+};
+MODULE_DEVICE_TABLE(pci, dwmac_motorcomm_pci_id_table);
+
+static struct pci_driver dwmac_motorcomm_pci_driver = {
+	.name = DRIVER_NAME,
+	.id_table = dwmac_motorcomm_pci_id_table,
+	.probe = motorcomm_probe,
+	.remove = motorcomm_remove,
+	.driver = {
+		.pm = &stmmac_simple_pm_ops,
+	},
+};
+
+module_pci_driver(dwmac_motorcomm_pci_driver);
+
+MODULE_DESCRIPTION("DWMAC glue driver for Motorcomm PCI Ethernet controllers");
+MODULE_AUTHOR("Yao Zi <me@ziyao.cc>");
+MODULE_LICENSE("GPL");
-- 
2.51.2


