Return-Path: <netdev+bounces-267631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPwqF1eRtGn7qAAAu9opvQ
	(envelope-from <netdev+bounces-267631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:36:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E29DB28A7A9
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA854318FCAD
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8776A38656A;
	Fri, 13 Mar 2026 22:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q43cexc9"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (lpdvsmtp11.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA47A382F1D;
	Fri, 13 Mar 2026 22:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773441304; cv=none; b=tNqHYFeJw6GCdHUAibs8lDTmrzAsG6VD04gYZMY/fa/mY0Cc8HIsf9nFQZ7ycPXDAvM0/i1+P2tOymiZiAkLqeXUhssR+vta0fAD7sVFJHHF1dXFSeIqP9Pze3Lv51nncgr4dMUAvnob3TTjNlLuB+tRP0DjWPKUc3V/w3Bvl0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773441304; c=relaxed/simple;
	bh=cT6/TM32GZN95J/cO5+rfwCg/Y+HIflpdLWEoyKmAZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vk0WwdLnzpLPMIYtT6dduFAkxAM/k/CqPzXpatjZoQR24rBTnOjXHL9y7cE+9r4xkDDm/quLmlxGawM1ixDsoLPZ78NrtMX3Wcvv/LzHt9S9UYhwPH8k7P4w1dDtB/h40M0ERxkhMB/MIIseeQp2G01yVFak3oYw3JT2tcfSUp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Q43cexc9; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id EDED2C008F5C;
	Fri, 13 Mar 2026 15:22:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com EDED2C008F5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1773440545;
	bh=cT6/TM32GZN95J/cO5+rfwCg/Y+HIflpdLWEoyKmAZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q43cexc9v5HW1QxbD2Au0OhpWO3hXoUxeCa4F7YKbdAMXX7AUDUAbllifJndjYYAj
	 rmawNfMLGZyoR1j+YJH+3PcEqG+X33oP8VkgpC9drOEavuiJ2G/NANkHvMP2nC2ZGQ
	 zIU0jlK80yiJuO1g3HuFSSgJ07U0elxHaQa5qBI4=
Received: from lvnvdb8054.lvn.broadcom.net (lvnvdb8054.lvn.broadcom.net [10.17.214.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id E13A7B92;
	Fri, 13 Mar 2026 15:22:24 -0700 (PDT)
From: "\\Jitendra Vegiraju" <jitendra.vegiraju@broadcom.com>
To: netdev@vger.kernel.org
Cc: alexandre.torgue@foss.st.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	jitendra.vegiraju@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	richardcochran@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	rmk+kernel@armlinux.org.uk,
	rohan.g.thomas@altera.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	me@ziyao.cc,
	siyanteng@cqsoftware.com.cn,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	weishangjuan@eswincomputing.com,
	wens@kernel.org,
	vladimir.oltean@nxp.com,
	lizhi2@eswincomputing.com,
	boon.khai.ng@altera.com,
	maxime.chevallier@bootlin.com,
	matthew.gerlach@altera.com,
	chenchuangyu@xiaomi.com,
	yangtiezhu@loongson.cn,
	ovidiu.panait.rb@renesas.com,
	chenhuacai@kernel.org,
	florian.fainelli@broadcom.com,
	quic_abchauha@quicinc.com
Subject: [PATCH net-next v7 4/5] net: stmmac: Add PCI driver support for BCM8958x
Date: Fri, 13 Mar 2026 15:22:05 -0700
Message-ID: <20260313222206.778760-5-jitendra.vegiraju@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260313222206.778760-1-jitendra.vegiraju@broadcom.com>
References: <20260313222206.778760-1-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=dkimrelay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267631-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[foss.st.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,broadcom.com,iogearbox.net,armlinux.org.uk,altera.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lunn.ch,fomichev.me,ziyao.cc,cqsoftware.com.cn,bp.renesas.com,eswincomputing.com,nxp.com,bootlin.com,xiaomi.com,loongson.cn,renesas.com,quicinc.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jitendra.vegiraju@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[39];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid]
X-Rspamd-Queue-Id: E29DB28A7A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>

Add PCI ethernet driver support for Broadcom BCM8958x SoC devices used
in automotive applications.

This SoC device has PCIe ethernet MAC attached to an integrated ethernet
switch using XGMII interface. The PCIe ethernet controller is presented to
the Linux host as PCI network device.

The following block diagram gives an overview of the application.
             +=================================+
             |       Host CPU/Linux            |
             +=================================+
                        || PCIe
                        ||
        +==========================================+
        |           +--------------+               |
        |           | PCIE Endpoint|               |
        |           | Ethernet     |               |
        |           | Controller   |               |
        |           |   DMA        |               |
        |           +--------------+               |
        |           |   MAC        |   BCM8958X    |
        |           +--------------+   SoC         |
        |               || XGMII                   |
        |               ||                         |
        |           +--------------+               |
        |           | Ethernet     |               |
        |           | switch       |               |
        |           +--------------+               |
        |             || || || ||                  |
        +==========================================+
                      || || || || More external interfaces

The MAC IP block on BCM8958x is based on Synopsis XGMAC 4.00a core. This
driver uses common dwxgmac2 code where applicable.
Driver functionality specific to this MAC is implemented in dw25gmac.c.

Management of integrated ethernet switch on this SoC is not handled via
the PCIe interface.

This SoC device has PCIe ethernet MAC directly attached to an integrated
ethernet switch using XGMII interface. Since device tree support is not
available on this platform, a software node is created to enable
fixed-link support using phylink driver.

Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-brcm.c  | 434 ++++++++++++++++++
 1 file changed, 434 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.c

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.c
new file mode 100644
index 000000000000..f1baf6e67cf5
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.c
@@ -0,0 +1,434 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024-2026 Broadcom Corporation
+ *
+ * PCI driver for ethernet interface of BCM8958X automotive switch chip.
+ *
+ * High level block diagram of the device.
+ *              +=================================+
+ *              |       Host CPU/Linux            |
+ *              +=================================+
+ *                         || PCIe
+ *                         ||
+ *         +==========================================+
+ *         |           +--------------+               |
+ *         |           | PCIE Endpoint|               |
+ *         |           | Ethernet     |               |
+ *         |           | Controller   |               |
+ *         |           |   DMA        |               |
+ *         |           +--------------+               |
+ *         |           |   MAC        |   BCM8958X    |
+ *         |           +--------------+   SoC         |
+ *         |               || XGMII                   |
+ *         |               ||                         |
+ *         |           +--------------+               |
+ *         |           | Ethernet     |               |
+ *         |           | switch       |               |
+ *         |           +--------------+               |
+ *         |             || || || ||                  |
+ *         +==========================================+
+ *                       || || || || More external interfaces
+ *
+ * This SoC device has PCIe ethernet MAC directly attached to an integrated
+ * ethernet switch using XGMII interface. Since devicetree support is not
+ * available on this platform, a software node is created to enable
+ * fixed-link support using phylink driver.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/dmi.h>
+#include <linux/pci.h>
+#include <linux/phy.h>
+#include <linux/of_mdio.h>
+#include "stmmac.h"
+#include "stmmac_libpci.h"
+#include "dwxgmac2.h"
+#include "dw25gmac.h"
+
+#define PCI_DEVICE_ID_BROADCOM_BCM8958X		0xa00d
+#define BRCM_MAX_MTU				1500
+
+/* TX and RX Queue counts */
+#define BRCM_TX_Q_COUNT				4
+#define BRCM_RX_Q_COUNT				4
+
+#define BRCM_XGMAC_BAR0_MASK			BIT(0)
+
+#define BRCM_XGMAC_IOMEM_MISC_REG_OFFSET	0x0
+#define BRCM_XGMAC_IOMEM_MBOX_REG_OFFSET	0x1000
+#define BRCM_XGMAC_IOMEM_CFG_REG_OFFSET		0x3000
+
+#define XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_LOW	0x940
+#define XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_LO_VALUE	0x00000001
+#define XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_HIGH	0x944
+#define XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_HI_VALUE	0x88000000
+
+#define XGMAC_PCIE_MISC_MII_CTRL_OFFSET			0x4
+#define XGMAC_PCIE_MISC_MII_CTRL_PAUSE_RX		BIT(0)
+#define XGMAC_PCIE_MISC_MII_CTRL_PAUSE_TX		BIT(1)
+#define XGMAC_PCIE_MISC_MII_CTRL_LINK_UP		BIT(2)
+#define XGMAC_PCIE_MISC_PCIESS_CTRL_OFFSET		0x8
+#define XGMAC_PCIE_MISC_PCIESS_CTRL_EN_MSI_MSIX		BIT(9)
+#define XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_LO_OFFSET	0x90
+#define XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_LO_VALUE	0x00000001
+#define XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_HI_OFFSET	0x94
+#define XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_HI_VALUE	0x88000000
+#define XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST0_OFFSET	0x700
+#define XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST0_VALUE	1
+#define XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST1_OFFSET	0x704
+#define XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST1_VALUE	1
+#define XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST_DBELL_OFFSET	0x728
+#define XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST_DBELL_VALUE	1
+#define XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_SBD_ALL_OFFSET	0x740
+#define XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_SBD_ALL_VALUE	0
+
+/* MSIX Vector map register starting offsets */
+#define XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_RX0_PF0_OFFSET	0x840
+#define XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_TX0_PF0_OFFSET	0x890
+#define BRCM_MAX_DMA_CHANNEL_PAIRS		4
+#define BRCM_XGMAC_MSI_MAC_VECTOR		0
+#define BRCM_XGMAC_MSI_RX_VECTOR_START		1
+#define BRCM_XGMAC_MSI_TX_VECTOR_START		2
+#define BRCM_XGMAC_MSI_VECTOR_MAX	(BRCM_XGMAC_MSI_RX_VECTOR_START + \
+					 BRCM_MAX_DMA_CHANNEL_PAIRS * 2)
+
+static const struct property_entry fixed_link_properties[] = {
+	PROPERTY_ENTRY_U32("speed", 10000),
+	PROPERTY_ENTRY_BOOL("full-duplex"),
+	PROPERTY_ENTRY_BOOL("pause"),
+	{ }
+};
+
+static const struct software_node parent_swnode = {
+	.name = "phy-device",
+};
+
+static const struct software_node fixed_link_swnode = {
+	.name = "fixed-link",           /* MUST be named "fixed-link" */
+	.parent = &parent_swnode,
+	.properties = fixed_link_properties,
+};
+
+static const struct software_node *brcm_swnodes[] = {
+	&parent_swnode,
+	&fixed_link_swnode,
+	NULL
+};
+
+struct brcm_priv_data {
+	void __iomem *mbox_regs;    /* MBOX  Registers*/
+	void __iomem *misc_regs;    /* MISC  Registers*/
+	void __iomem *xgmac_regs;   /* XGMAC Registers*/
+};
+
+struct dwxgmac_brcm_pci_info {
+	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
+};
+
+static void misc_iowrite(struct brcm_priv_data *brcm_priv,
+			 u32 reg, u32 val)
+{
+	iowrite32(val, brcm_priv->misc_regs + reg);
+}
+
+static void dwxgmac_brcm_common_default_data(struct plat_stmmacenet_data *plat)
+{
+	int i;
+
+	plat->force_sf_dma_mode = true;
+	plat->mac_port_sel_speed = SPEED_10000;
+	plat->clk_ptp_rate = 125000000;
+	plat->clk_ref_rate = 250000000;
+	plat->tx_coe = true;
+	plat->rx_coe = STMMAC_RX_COE_TYPE1;
+	plat->rss_en = 1;
+	plat->max_speed = SPEED_10000;
+
+	/* Set default value for multicast hash bins */
+	plat->multicast_filter_bins = HASH_TABLE_SIZE;
+
+	/* Set default value for unicast filter entries */
+	plat->unicast_filter_entries = 1;
+
+	/* Set the maxmtu to device's default */
+	plat->maxmtu = BRCM_MAX_MTU;
+
+	/* Set default number of RX and TX queues to use */
+	plat->tx_queues_to_use = BRCM_TX_Q_COUNT;
+	plat->rx_queues_to_use = BRCM_RX_Q_COUNT;
+
+	plat->tx_sched_algorithm = MTL_TX_ALGORITHM_SP;
+	for (i = 0; i < plat->tx_queues_to_use; i++) {
+		plat->tx_queues_cfg[i].use_prio = false;
+		plat->tx_queues_cfg[i].prio = 0;
+		plat->tx_queues_cfg[i].mode_to_use = MTL_QUEUE_AVB;
+	}
+
+	plat->rx_sched_algorithm = MTL_RX_ALGORITHM_SP;
+	for (i = 0; i < plat->rx_queues_to_use; i++) {
+		plat->rx_queues_cfg[i].use_prio = false;
+		plat->rx_queues_cfg[i].mode_to_use = MTL_QUEUE_AVB;
+		plat->rx_queues_cfg[i].pkt_route = 0x0;
+		plat->rx_queues_cfg[i].chan = i;
+	}
+}
+
+static int dwxgmac_brcm_default_data(struct pci_dev *pdev,
+				     struct plat_stmmacenet_data *plat)
+{
+	/* Set common default data first */
+	dwxgmac_brcm_common_default_data(plat);
+	plat->core_type = DWMAC_CORE_25GMAC;
+	plat->bus_id = 0;
+	plat->phy_addr = 0;
+	plat->phy_interface = PHY_INTERFACE_MODE_XGMII;
+
+	plat->dma_cfg->pbl = 8;
+	plat->dma_cfg->pblx8 = 1;
+	plat->dma_cfg->aal = 0;
+	plat->dma_cfg->eame = 1;
+
+	plat->axi->axi_wr_osr_lmt = 31;
+	plat->axi->axi_rd_osr_lmt = 31;
+	plat->axi->axi_fb = 0;
+	plat->axi->axi_blen_regval = DMA_AXI_BLEN64;
+	return 0;
+}
+
+static struct dwxgmac_brcm_pci_info dwxgmac_brcm_pci_info = {
+	.setup = dwxgmac_brcm_default_data,
+};
+
+static void brcm_config_misc_regs(struct pci_dev *pdev,
+				  struct brcm_priv_data *brcm_priv)
+{
+	pci_write_config_dword(pdev, XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_LOW,
+			       XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_LO_VALUE);
+	pci_write_config_dword(pdev, XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_HIGH,
+			       XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_HI_VALUE);
+
+	misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_LO_OFFSET,
+		     XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_LO_VALUE);
+	misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_HI_OFFSET,
+		     XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_HI_VALUE);
+
+	/* Enable Switch Link */
+	misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MII_CTRL_OFFSET,
+		     XGMAC_PCIE_MISC_MII_CTRL_PAUSE_RX |
+		     XGMAC_PCIE_MISC_MII_CTRL_PAUSE_TX |
+		     XGMAC_PCIE_MISC_MII_CTRL_LINK_UP);
+}
+
+static int brcm_config_multi_msi(struct pci_dev *pdev,
+				 struct plat_stmmacenet_data *plat,
+				 struct stmmac_resources *res)
+{
+	int ret;
+	int i;
+
+	ret = pci_alloc_irq_vectors(pdev, BRCM_XGMAC_MSI_VECTOR_MAX,
+				    BRCM_XGMAC_MSI_VECTOR_MAX,
+				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "%s: multi MSI enablement failed\n",
+			__func__);
+		return ret;
+	}
+
+	/* For RX MSI */
+	for (i = 0; i < plat->rx_queues_to_use; i++)
+		res->rx_irq[i] =
+			pci_irq_vector(pdev,
+				       BRCM_XGMAC_MSI_RX_VECTOR_START + i * 2);
+
+	/* For TX MSI */
+	for (i = 0; i < plat->tx_queues_to_use; i++)
+		res->tx_irq[i] =
+			pci_irq_vector(pdev,
+				       BRCM_XGMAC_MSI_TX_VECTOR_START + i * 2);
+
+	res->irq = pci_irq_vector(pdev, BRCM_XGMAC_MSI_MAC_VECTOR);
+
+	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
+	plat->flags |= STMMAC_FLAG_TSO_EN;
+	plat->flags |= STMMAC_FLAG_SPH_DISABLE;
+	return 0;
+}
+
+static int brcm_pci_resume(struct device *dev, void *bsp_priv)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	brcm_config_misc_regs(pdev, bsp_priv);
+
+	return stmmac_pci_plat_resume(dev, bsp_priv);
+}
+
+static int dwxgmac_brcm_pci_probe(struct pci_dev *pdev,
+				  const struct pci_device_id *id)
+{
+	struct dwxgmac_brcm_pci_info *info =
+		(struct dwxgmac_brcm_pci_info *)id->driver_data;
+	struct plat_stmmacenet_data *plat;
+	struct brcm_priv_data *brcm_priv;
+	struct stmmac_resources res;
+	struct device *dev;
+	int rx_offset;
+	int tx_offset;
+	int vector;
+	int ret;
+
+	dev = &pdev->dev;
+
+	brcm_priv = devm_kzalloc(&pdev->dev, sizeof(*brcm_priv), GFP_KERNEL);
+	if (!brcm_priv)
+		return -ENOMEM;
+
+	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
+	if (!plat)
+		return -ENOMEM;
+
+	plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg),
+				     GFP_KERNEL);
+	if (!plat->dma_cfg)
+		return -ENOMEM;
+
+	plat->axi = devm_kzalloc(&pdev->dev, sizeof(*plat->axi), GFP_KERNEL);
+	if (!plat->axi)
+		return -ENOMEM;
+
+	/* This device is directly attached to the switch chip internal to the
+	 * SoC using XGMII interface. Since no MDIO is present, register
+	 * fixed-link software_node to create phylink.
+	 */
+	software_node_register_node_group(brcm_swnodes);
+	device_set_node(dev, software_node_fwnode(&parent_swnode));
+
+	/* Disable D3COLD as our device does not support it */
+	pci_d3cold_disable(pdev);
+
+	/* Enable PCI device */
+	ret = pcim_enable_device(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "%s: ERROR: failed to enable device\n",
+			__func__);
+		return ret;
+	}
+
+	pci_set_master(pdev);
+
+	memset(&res, 0, sizeof(res));
+	res.addr = pcim_iomap_region(pdev, 0, pci_name(pdev));
+	if (IS_ERR(res.addr))
+		return dev_err_probe(&pdev->dev, PTR_ERR(res.addr),
+				     "failed to map IO region\n");
+	/* MISC Regs */
+	brcm_priv->misc_regs = res.addr + BRCM_XGMAC_IOMEM_MISC_REG_OFFSET;
+	/* MBOX Regs */
+	brcm_priv->mbox_regs = res.addr + BRCM_XGMAC_IOMEM_MBOX_REG_OFFSET;
+	/* XGMAC config Regs */
+	res.addr += BRCM_XGMAC_IOMEM_CFG_REG_OFFSET;
+	brcm_priv->xgmac_regs = res.addr;
+
+	plat->suspend		= stmmac_pci_plat_suspend;
+	plat->resume		= brcm_pci_resume;
+	plat->bsp_priv = brcm_priv;
+
+	ret = info->setup(pdev, plat);
+	if (ret)
+		return ret;
+
+	pci_write_config_dword(pdev, XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_LOW,
+			       XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_LO_VALUE);
+	pci_write_config_dword(pdev, XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_HIGH,
+			       XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_HI_VALUE);
+
+	misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_LO_OFFSET,
+		     XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_LO_VALUE);
+	misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_HI_OFFSET,
+		     XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_HI_VALUE);
+
+	/* SBD Interrupt */
+	misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_SBD_ALL_OFFSET,
+		     XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_SBD_ALL_VALUE);
+	/* EP_DOORBELL Interrupt */
+	misc_iowrite(brcm_priv,
+		     XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST_DBELL_OFFSET,
+		     XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST_DBELL_VALUE);
+	/* EP_H0 Interrupt */
+	misc_iowrite(brcm_priv,
+		     XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST0_OFFSET,
+		     XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST0_VALUE);
+	/* EP_H1 Interrupt */
+	misc_iowrite(brcm_priv,
+		     XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST1_OFFSET,
+		     XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST1_VALUE);
+
+	rx_offset = XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_RX0_PF0_OFFSET;
+	tx_offset = XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_TX0_PF0_OFFSET;
+	vector = BRCM_XGMAC_MSI_RX_VECTOR_START;
+	for (int i = 0; i < BRCM_MAX_DMA_CHANNEL_PAIRS; i++) {
+		/* RX Interrupt */
+		misc_iowrite(brcm_priv, rx_offset, vector++);
+		/* TX Interrupt */
+		misc_iowrite(brcm_priv, tx_offset, vector++);
+		rx_offset += 4;
+		tx_offset += 4;
+	}
+
+	/* Enable Switch Link */
+	misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MII_CTRL_OFFSET,
+		     XGMAC_PCIE_MISC_MII_CTRL_PAUSE_RX |
+		     XGMAC_PCIE_MISC_MII_CTRL_PAUSE_TX |
+		     XGMAC_PCIE_MISC_MII_CTRL_LINK_UP);
+	/* Enable MSI-X */
+	misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_PCIESS_CTRL_OFFSET,
+		     XGMAC_PCIE_MISC_PCIESS_CTRL_EN_MSI_MSIX);
+
+	ret = brcm_config_multi_msi(pdev, plat, &res);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"%s: ERROR: failed to enable IRQ\n", __func__);
+		goto err_disable_msi;
+	}
+
+	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
+	if (ret)
+		goto err_disable_msi;
+
+	return ret;
+
+err_disable_msi:
+	pci_free_irq_vectors(pdev);
+
+	return ret;
+}
+
+static void dwxgmac_brcm_pci_remove(struct pci_dev *pdev)
+{
+	stmmac_dvr_remove(&pdev->dev);
+	pci_free_irq_vectors(pdev);
+	device_set_node(&pdev->dev, NULL);
+	software_node_unregister_node_group(brcm_swnodes);
+}
+
+static const struct pci_device_id dwxgmac_brcm_id_table[] = {
+	{ PCI_DEVICE_DATA(BROADCOM, BCM8958X, &dwxgmac_brcm_pci_info) },
+	{}
+};
+
+MODULE_DEVICE_TABLE(pci, dwxgmac_brcm_id_table);
+
+static struct pci_driver dwxgmac_brcm_pci_driver = {
+	.name = "brcm-bcm8958x",
+	.id_table = dwxgmac_brcm_id_table,
+	.probe	= dwxgmac_brcm_pci_probe,
+	.remove = dwxgmac_brcm_pci_remove,
+	.driver = {
+		.pm = &stmmac_simple_pm_ops,
+	},
+};
+
+module_pci_driver(dwxgmac_brcm_pci_driver);
+
+MODULE_DESCRIPTION("Broadcom 10G Automotive Ethernet PCIe driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


