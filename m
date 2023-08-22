Return-Path: <netdev+bounces-29564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E660783D27
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 11:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52507280C37
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 09:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9AE8F6B;
	Tue, 22 Aug 2023 09:40:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FB0944C
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 09:40:49 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70345CD9
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 02:40:40 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.102])
	by gateway (Coremail) with SMTP id _____8BxuOiVguRkwt8aAA--.19236S3;
	Tue, 22 Aug 2023 17:40:37 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.102])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx3yOOguRkTzVgAA--.63227S5;
	Tue, 22 Aug 2023 17:40:36 +0800 (CST)
From: Feiyang Chen <chenfeiyang@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	chenhuacai@loongson.cn
Cc: Feiyang Chen <chenfeiyang@loongson.cn>,
	linux@armlinux.org.uk,
	dongbiao@loongson.cn,
	guyinggang@loongson.cn,
	siyanteng@loongson.cn,
	loongson-kernel@lists.loongnix.cn,
	netdev@vger.kernel.org,
	loongarch@lists.linux.dev,
	chris.chenfeiyang@gmail.com
Subject: [PATCH v4 03/11] stmmac: Add extended GMAC support for Loongson platforms
Date: Tue, 22 Aug 2023 17:40:28 +0800
Message-Id: <7ab619c05c2b04fc9552e9f3b995a82f661f339f.1692696115.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1692696115.git.chenfeiyang@loongson.cn>
References: <cover.1692696115.git.chenfeiyang@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Bx3yOOguRkTzVgAA--.63227S5
X-CM-SenderInfo: hfkh0wphl1t03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj9fXoWDXFW5GF4rWr48ur4fWr1UXFc_yoWxXw4rCo
	ZxXFZIqw4rWw1xurZ2kw1rtry7Xrn8Xayay3y8JrWkZa97trZ8ZFWrXrWfXF13tFW2gr98
	A34xta4DC3ySy3Z5l-sFpf9Il3svdjkaLaAFLSUrUUUUeb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYt7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6Fy26r45twAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j4PfQUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Loongson platforms use an extended GMAC which supports 64-bit DMA
and multi-channel.

There are two kinds of Loongson platforms. The first kind shares
the same registers and has similar logic with dwmac1000. The second
kind uses different registers and has more features.

Add extended GMAC support and then add two HWIF entries for Loongson
platforms.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
---
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h  |   2 +
 drivers/net/ethernet/stmicro/stmmac/dwegmac.h | 332 +++++++++++
 .../ethernet/stmicro/stmmac/dwegmac_core.c    | 552 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/dwegmac_dma.c | 516 ++++++++++++++++
 .../net/ethernet/stmicro/stmmac/dwegmac_dma.h | 190 ++++++
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |  54 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |   2 +
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |   2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   3 +-
 include/linux/stmmac.h                        |   1 +
 11 files changed, 1651 insertions(+), 5 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwegmac.h
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwegmac_core.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwegmac_dma.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwegmac_dma.h

diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index 10f32ded2bd9..1238cd736910 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -6,7 +6,7 @@ stmmac-objs:= stmmac_main.o stmmac_ethtool.o stmmac_mdio.o ring_mode.o	\
 	      mmc_core.o stmmac_hwtstamp.o stmmac_ptp.o dwmac4_descs.o	\
 	      dwmac4_dma.o dwmac4_lib.o dwmac4_core.o dwmac5.o hwif.o \
 	      stmmac_tc.o dwxgmac2_core.o dwxgmac2_dma.o dwxgmac2_descs.o \
-	      stmmac_xdp.o ring_mode64.o \
+	      stmmac_xdp.o ring_mode64.o dwegmac_core.o dwegmac_dma.o \
 	      $(stmmac-y)
 
 stmmac-$(CONFIG_STMMAC_SELFTESTS) += stmmac_selftests.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 90a7784f71cb..74528a16b93a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -36,6 +36,7 @@
 #define DWMAC_CORE_5_20		0x52
 #define DWXGMAC_CORE_2_10	0x21
 #define DWXLGMAC_CORE_2_00	0x20
+#define DWEGMAC_CORE_1_00	0x10
 
 /* Device ID */
 #define DWXGMAC_ID		0x76
@@ -547,6 +548,7 @@ int dwmac1000_setup(struct stmmac_priv *priv);
 int dwmac4_setup(struct stmmac_priv *priv);
 int dwxgmac2_setup(struct stmmac_priv *priv);
 int dwxlgmac2_setup(struct stmmac_priv *priv);
+int dwegmac_setup(struct stmmac_priv *priv);
 
 void stmmac_set_mac_addr(void __iomem *ioaddr, const u8 addr[6],
 			 unsigned int high, unsigned int low);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwegmac.h b/drivers/net/ethernet/stmicro/stmmac/dwegmac.h
new file mode 100644
index 000000000000..6f8fcf3ed409
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwegmac.h
@@ -0,0 +1,332 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Loongson Technology Corporation Limited
+ */
+
+#ifndef __DWEGMAC_H__
+#define __DWEGMAC_H__
+
+#include <linux/phy.h>
+#include "common.h"
+
+#define GMAC_CONTROL			0x00000000	/* Configuration */
+#define GMAC_FRAME_FILTER		0x00000004	/* Frame Filter */
+#define GMAC_HASH_HIGH			0x00000008	/* Multicast Hash Table High */
+#define GMAC_HASH_LOW			0x0000000c	/* Multicast Hash Table Low */
+#define GMAC_MII_ADDR			0x00000010	/* MII Address */
+#define GMAC_MII_DATA			0x00000014	/* MII Data */
+#define GMAC_FLOW_CTRL			0x00000018	/* Flow Control */
+#define GMAC_VLAN_TAG			0x0000001c	/* VLAN Tag */
+#define GMAC_DEBUG			0x00000024	/* GMAC debug register */
+#define GMAC_WAKEUP_FILTER		0x00000028	/* Wake-up Frame Filter */
+
+#define GMAC_INT_STATUS			0x00000038	/* interrupt status register */
+#define GMAC_INT_STATUS_PMT		BIT(3)
+#define GMAC_INT_STATUS_MMCIS		BIT(4)
+#define GMAC_INT_STATUS_MMCRIS		BIT(5)
+#define GMAC_INT_STATUS_MMCTIS		BIT(6)
+#define GMAC_INT_STATUS_MMCCSUM		BIT(7)
+#define GMAC_INT_STATUS_TSTAMP		BIT(9)
+#define GMAC_INT_STATUS_LPIIS		BIT(10)
+
+/* interrupt mask register */
+#define	GMAC_INT_MASK			0x0000003c
+#define	GMAC_INT_DISABLE_RGMII		BIT(0)
+#define	GMAC_INT_DISABLE_PCSLINK	BIT(1)
+#define	GMAC_INT_DISABLE_PCSAN		BIT(2)
+#define	GMAC_INT_DISABLE_PMT		BIT(3)
+#define	GMAC_INT_DISABLE_TIMESTAMP	BIT(9)
+#define	GMAC_INT_DISABLE_PCS		(GMAC_INT_DISABLE_RGMII | \
+					 GMAC_INT_DISABLE_PCSLINK | \
+					 GMAC_INT_DISABLE_PCSAN)
+#define	GMAC_INT_DEFAULT_MASK		(GMAC_INT_DISABLE_TIMESTAMP | \
+					 GMAC_INT_DISABLE_PCS)
+
+/* PMT Control and Status */
+#define GMAC_PMT			0x0000002c
+enum power_event {
+	pointer_reset = 0x80000000,
+	global_unicast = 0x00000200,
+	wake_up_rx_frame = 0x00000040,
+	magic_frame = 0x00000020,
+	wake_up_frame_en = 0x00000004,
+	magic_pkt_en = 0x00000002,
+	power_down = 0x00000001,
+};
+
+/* Energy Efficient Ethernet (EEE)
+ *
+ * LPI status, timer and control register offset
+ */
+#define LPI_CTRL_STATUS			0x0030
+#define LPI_TIMER_CTRL			0x0034
+
+/* LPI control and status defines */
+#define LPI_CTRL_STATUS_LPITXA		0x00080000	/* Enable LPI TX Automate */
+#define LPI_CTRL_STATUS_PLSEN		0x00040000	/* Enable PHY Link Status */
+#define LPI_CTRL_STATUS_PLS		0x00020000	/* PHY Link Status */
+#define LPI_CTRL_STATUS_LPIEN		0x00010000	/* LPI Enable */
+#define LPI_CTRL_STATUS_RLPIST		0x00000200	/* Receive LPI state */
+#define LPI_CTRL_STATUS_TLPIST		0x00000100	/* Transmit LPI state */
+#define LPI_CTRL_STATUS_RLPIEX		0x00000008	/* Receive LPI Exit */
+#define LPI_CTRL_STATUS_RLPIEN		0x00000004	/* Receive LPI Entry */
+#define LPI_CTRL_STATUS_TLPIEX		0x00000002	/* Transmit LPI Exit */
+#define LPI_CTRL_STATUS_TLPIEN		0x00000001	/* Transmit LPI Entry */
+
+/* GMAC HW ADDR regs */
+#define GMAC_ADDR_HIGH(reg)		((reg > 15) ? 0x00000800 + (reg - 16) * 8 : \
+					 0x00000040 + (reg * 8))
+#define GMAC_ADDR_LOW(reg)		((reg > 15) ? 0x00000804 + (reg - 16) * 8 : \
+					 0x00000044 + (reg * 8))
+#define GMAC_MAX_PERFECT_ADDRESSES	1
+
+#define GMAC_PCS_BASE			0x000000c0	/* PCS register base */
+#define GMAC_RGSMIIIS			0x000000d8	/* RGMII/SMII status */
+
+/* SGMII/RGMII status register */
+#define GMAC_RGSMIIIS_LNKMODE		BIT(0)
+#define GMAC_RGSMIIIS_SPEED		GENMASK(2, 1)
+#define GMAC_RGSMIIIS_SPEED_SHIFT	1
+#define GMAC_RGSMIIIS_LNKSTS		BIT(3)
+#define GMAC_RGSMIIIS_JABTO		BIT(4)
+#define GMAC_RGSMIIIS_FALSECARDET	BIT(5)
+#define GMAC_RGSMIIIS_SMIDRXS		BIT(16)
+/* LNKMOD */
+#define GMAC_RGSMIIIS_LNKMOD_MASK	0x1
+/* LNKSPEED */
+#define GMAC_RGSMIIIS_SPEED_125		0x2
+#define GMAC_RGSMIIIS_SPEED_25		0x1
+#define GMAC_RGSMIIIS_SPEED_2_5		0x0
+
+/* GMAC Configuration defines */
+#define GMAC_CONTROL_2K			0x08000000	/* IEEE 802.3as 2K packets */
+#define GMAC_CONTROL_TC			0x01000000	/* Transmit Conf. in RGMII/SGMII */
+#define GMAC_CONTROL_WD			0x00800000	/* Disable Watchdog on receive */
+#define GMAC_CONTROL_JD			0x00400000	/* Jabber disable */
+#define GMAC_CONTROL_BE			0x00200000	/* Frame Burst Enable */
+#define GMAC_CONTROL_JE			0x00100000	/* Jumbo frame */
+enum inter_frame_gap {
+	GMAC_CONTROL_IFG_88 = 0x00040000,
+	GMAC_CONTROL_IFG_80 = 0x00020000,
+	GMAC_CONTROL_IFG_40 = 0x000e0000,
+};
+#define GMAC_CONTROL_DCRS		0x00010000	/* Disable carrier sense */
+#define GMAC_CONTROL_PS			0x00008000	/* Port Select 0:GMI 1:MII */
+#define GMAC_CONTROL_FES		0x00004000	/* Speed 0:10 1:100 */
+#define GMAC_CONTROL_DO			0x00002000	/* Disable Rx Own */
+#define GMAC_CONTROL_LM			0x00001000	/* Loop-back mode */
+#define GMAC_CONTROL_DM			0x00000800	/* Duplex Mode */
+#define GMAC_CONTROL_IPC		0x00000400	/* Checksum Offload */
+#define GMAC_CONTROL_DR			0x00000200	/* Disable Retry */
+#define GMAC_CONTROL_LUD		0x00000100	/* Link up/down */
+#define GMAC_CONTROL_ACS		0x00000080	/* Auto Pad/FCS Stripping */
+#define GMAC_CONTROL_DC			0x00000010	/* Deferral Check */
+#define GMAC_CONTROL_TE			0x00000008	/* Transmitter Enable */
+#define GMAC_CONTROL_RE			0x00000004	/* Receiver Enable */
+
+#define GMAC_CORE_INIT			(GMAC_CONTROL_JD | GMAC_CONTROL_PS | \
+					 GMAC_CONTROL_BE | GMAC_CONTROL_DCRS | \
+					 GMAC_CONTROL_ACS)
+
+/* GMAC Frame Filter defines */
+#define GMAC_FRAME_FILTER_PR		0x00000001	/* Promiscuous Mode */
+#define GMAC_FRAME_FILTER_HUC		0x00000002	/* Hash Unicast */
+#define GMAC_FRAME_FILTER_HMC		0x00000004	/* Hash Multicast */
+#define GMAC_FRAME_FILTER_DAIF		0x00000008	/* DA Inverse Filtering */
+#define GMAC_FRAME_FILTER_PM		0x00000010	/* Pass all multicast */
+#define GMAC_FRAME_FILTER_DBF		0x00000020	/* Disable Broadcast frames */
+#define GMAC_FRAME_FILTER_PCF		0x00000080	/* Pass Control frames */
+#define GMAC_FRAME_FILTER_SAIF		0x00000100	/* Inverse Filtering */
+#define GMAC_FRAME_FILTER_SAF		0x00000200	/* Source Address Filter */
+#define GMAC_FRAME_FILTER_HPF		0x00000400	/* Hash or perfect Filter */
+#define GMAC_FRAME_FILTER_RA		0x80000000	/* Receive all mode */
+/* GMII ADDR  defines */
+#define GMAC_MII_ADDR_WRITE		0x00000002	/* MII Write */
+#define GMAC_MII_ADDR_BUSY		0x00000001	/* MII Busy */
+/* GMAC FLOW CTRL defines */
+#define GMAC_FLOW_CTRL_PT_MASK		0xffff0000	/* Pause Time Mask */
+#define GMAC_FLOW_CTRL_PT_SHIFT		16
+#define GMAC_FLOW_CTRL_UP		0x00000008	/* Unicast pause frame enable */
+#define GMAC_FLOW_CTRL_RFE		0x00000004	/* Rx Flow Control Enable */
+#define GMAC_FLOW_CTRL_TFE		0x00000002	/* Tx Flow Control Enable */
+#define GMAC_FLOW_CTRL_FCB_BPA		0x00000001	/* Flow Control Busy ... */
+
+/* DEBUG Register defines */
+/* MTL TxStatus FIFO */
+#define GMAC_DEBUG_TXSTSFSTS		BIT(25)	/* MTL TxStatus FIFO Full Status */
+#define GMAC_DEBUG_TXFSTS		BIT(24) /* MTL Tx FIFO Not Empty Status */
+#define GMAC_DEBUG_TWCSTS		BIT(22) /* MTL Tx FIFO Write Controller */
+/* MTL Tx FIFO Read Controller Status */
+#define GMAC_DEBUG_TRCSTS_MASK		GENMASK(21, 20)
+#define GMAC_DEBUG_TRCSTS_SHIFT		20
+#define GMAC_DEBUG_TRCSTS_IDLE		0
+#define GMAC_DEBUG_TRCSTS_READ		1
+#define GMAC_DEBUG_TRCSTS_TXW		2
+#define GMAC_DEBUG_TRCSTS_WRITE		3
+#define GMAC_DEBUG_TXPAUSED		BIT(19) /* MAC Transmitter in PAUSE */
+/* MAC Transmit Frame Controller Status */
+#define GMAC_DEBUG_TFCSTS_MASK		GENMASK(18, 17)
+#define GMAC_DEBUG_TFCSTS_SHIFT		17
+#define GMAC_DEBUG_TFCSTS_IDLE		0
+#define GMAC_DEBUG_TFCSTS_WAIT		1
+#define GMAC_DEBUG_TFCSTS_GEN_PAUSE	2
+#define GMAC_DEBUG_TFCSTS_XFER		3
+/* MAC GMII or MII Transmit Protocol Engine Status */
+#define GMAC_DEBUG_TPESTS		BIT(16)
+#define GMAC_DEBUG_RXFSTS_MASK		GENMASK(9, 8) /* MTL Rx FIFO Fill-level */
+#define GMAC_DEBUG_RXFSTS_SHIFT		8
+#define GMAC_DEBUG_RXFSTS_EMPTY		0
+#define GMAC_DEBUG_RXFSTS_BT		1
+#define GMAC_DEBUG_RXFSTS_AT		2
+#define GMAC_DEBUG_RXFSTS_FULL		3
+#define GMAC_DEBUG_RRCSTS_MASK		GENMASK(6, 5) /* MTL Rx FIFO Read Controller */
+#define GMAC_DEBUG_RRCSTS_SHIFT		5
+#define GMAC_DEBUG_RRCSTS_IDLE		0
+#define GMAC_DEBUG_RRCSTS_RDATA		1
+#define GMAC_DEBUG_RRCSTS_RSTAT		2
+#define GMAC_DEBUG_RRCSTS_FLUSH		3
+#define GMAC_DEBUG_RWCSTS		BIT(4) /* MTL Rx FIFO Write Controller Active */
+/* MAC Receive Frame Controller FIFO Status */
+#define GMAC_DEBUG_RFCFCSTS_MASK	GENMASK(2, 1)
+#define GMAC_DEBUG_RFCFCSTS_SHIFT	1
+/* MAC GMII or MII Receive Protocol Engine Status */
+#define GMAC_DEBUG_RPESTS		BIT(0)
+
+/*--- DMA BLOCK defines ---*/
+/* DMA Bus Mode register defines */
+#define DMA_BUS_MODE_DA			0x00000002	/* Arbitration scheme */
+#define DMA_BUS_MODE_DSL_MASK		0x0000007c	/* Descriptor Skip Length */
+#define DMA_BUS_MODE_DSL_SHIFT		2		/*   (in DWORDS)      */
+/* Programmable burst length (passed thorugh platform)*/
+#define DMA_BUS_MODE_PBL_MASK		0x00003f00	/* Programmable Burst Len */
+#define DMA_BUS_MODE_PBL_SHIFT		8
+#define DMA_BUS_MODE_ATDS		0x00000080	/* Alternate Descriptor Size */
+
+enum rx_tx_priority_ratio {
+	double_ratio = 0x00004000,	/* 2:1 */
+	triple_ratio = 0x00008000,	/* 3:1 */
+	quadruple_ratio = 0x0000c000,	/* 4:1 */
+};
+
+#define DMA_BUS_MODE_FB			0x00010000	/* Fixed burst */
+#define DMA_BUS_MODE_MB			0x04000000	/* Mixed burst */
+#define DMA_BUS_MODE_RPBL_MASK		0x007e0000	/* Rx-Programmable Burst Len */
+#define DMA_BUS_MODE_RPBL_SHIFT		17
+#define DMA_BUS_MODE_USP		0x00800000
+#define DMA_BUS_MODE_MAXPBL		0x01000000
+#define DMA_BUS_MODE_AAL		0x02000000
+
+/* DMA CRS Control and Status Register Mapping */
+#define DMA_HOST_TX_DESC		0x00001048	/* Current Host Tx descriptor */
+#define DMA_HOST_RX_DESC		0x0000104c	/* Current Host Rx descriptor */
+/*  DMA Bus Mode register defines */
+#define DMA_BUS_PR_RATIO_MASK		0x0000c000	/* Rx/Tx priority ratio */
+#define DMA_BUS_PR_RATIO_SHIFT		14
+#define DMA_BUS_FB			0x00010000	/* Fixed Burst */
+
+/* DMA operation mode defines (start/stop tx/rx are placed in common header)*/
+/* Disable Drop TCP/IP csum error */
+#define DMA_CONTROL_DT			0x04000000
+#define DMA_CONTROL_RSF			0x02000000	/* Receive Store and Forward */
+#define DMA_CONTROL_DFF			0x01000000	/* Disaable flushing */
+/* Threshold for Activating the FC */
+enum rfa {
+	act_full_minus_1 = 0x00800000,
+	act_full_minus_2 = 0x00800200,
+	act_full_minus_3 = 0x00800400,
+	act_full_minus_4 = 0x00800600,
+};
+/* Threshold for Deactivating the FC */
+enum rfd {
+	deac_full_minus_1 = 0x00400000,
+	deac_full_minus_2 = 0x00400800,
+	deac_full_minus_3 = 0x00401000,
+	deac_full_minus_4 = 0x00401800,
+};
+#define DMA_CONTROL_TSF	0x00200000	/* Transmit  Store and Forward */
+
+enum ttc_control {
+	DMA_CONTROL_TTC_64 = 0x00000000,
+	DMA_CONTROL_TTC_128 = 0x00004000,
+	DMA_CONTROL_TTC_192 = 0x00008000,
+	DMA_CONTROL_TTC_256 = 0x0000c000,
+	DMA_CONTROL_TTC_40 = 0x00010000,
+	DMA_CONTROL_TTC_32 = 0x00014000,
+	DMA_CONTROL_TTC_24 = 0x00018000,
+	DMA_CONTROL_TTC_16 = 0x0001c000,
+};
+#define DMA_CONTROL_TC_TX_MASK		0xfffe3fff
+
+#define DMA_CONTROL_EFC			0x00000100
+#define DMA_CONTROL_FEF			0x00000080
+#define DMA_CONTROL_FUF			0x00000040
+
+/* Receive flow control activation field
+ * RFA field in DMA control register, bits 23,10:9
+ */
+#define DMA_CONTROL_RFA_MASK		0x00800600
+
+/* Receive flow control deactivation field
+ * RFD field in DMA control register, bits 22,12:11
+ */
+#define DMA_CONTROL_RFD_MASK		0x00401800
+
+/* RFD and RFA fields are encoded as follows
+ *
+ *   Bit Field
+ *   0,00 - Full minus 1KB (only valid when rxfifo >= 4KB and EFC enabled)
+ *   0,01 - Full minus 2KB (only valid when rxfifo >= 4KB and EFC enabled)
+ *   0,10 - Full minus 3KB (only valid when rxfifo >= 4KB and EFC enabled)
+ *   0,11 - Full minus 4KB (only valid when rxfifo > 4KB and EFC enabled)
+ *   1,00 - Full minus 5KB (only valid when rxfifo > 8KB and EFC enabled)
+ *   1,01 - Full minus 6KB (only valid when rxfifo > 8KB and EFC enabled)
+ *   1,10 - Full minus 7KB (only valid when rxfifo > 8KB and EFC enabled)
+ *   1,11 - Reserved
+ *
+ * RFD should always be > RFA for a given FIFO size. RFD == RFA may work,
+ * but packet throughput performance may not be as expected.
+ *
+ * Be sure that bit 3 in GMAC Register 6 is set for Unicast Pause frame
+ * detection (IEEE Specification Requirement, Annex 31B, 31B.1, Pause
+ * Description).
+ *
+ * Be sure that DZPA (bit 7 in Flow Control Register, GMAC Register 6),
+ * is set to 0. This allows pause frames with a quanta of 0 to be sent
+ * as an XOFF message to the link peer.
+ */
+
+#define RFA_FULL_MINUS_1K		0x00000000
+#define RFA_FULL_MINUS_2K		0x00000200
+#define RFA_FULL_MINUS_3K		0x00000400
+#define RFA_FULL_MINUS_4K		0x00000600
+#define RFA_FULL_MINUS_5K		0x00800000
+#define RFA_FULL_MINUS_6K		0x00800200
+#define RFA_FULL_MINUS_7K		0x00800400
+
+#define RFD_FULL_MINUS_1K		0x00000000
+#define RFD_FULL_MINUS_2K		0x00000800
+#define RFD_FULL_MINUS_3K		0x00001000
+#define RFD_FULL_MINUS_4K		0x00001800
+#define RFD_FULL_MINUS_5K		0x00400000
+#define RFD_FULL_MINUS_6K		0x00400800
+#define RFD_FULL_MINUS_7K		0x00401000
+
+enum rtc_control {
+	DMA_CONTROL_RTC_64 = 0x00000000,
+	DMA_CONTROL_RTC_32 = 0x00000008,
+	DMA_CONTROL_RTC_96 = 0x00000010,
+	DMA_CONTROL_RTC_128 = 0x00000018,
+};
+#define DMA_CONTROL_TC_RX_MASK		0xffffffe7
+
+#define DMA_CONTROL_OSF			0x00000004	/* Operate on second frame */
+
+/* MMC registers offset */
+#define GMAC_MMC_CTRL			0x100
+#define GMAC_MMC_RX_INTR		0x104
+#define GMAC_MMC_TX_INTR		0x108
+#define GMAC_MMC_RX_CSUM_OFFLOAD	0x208
+#define GMAC_EXTHASH_BASE		0x500
+
+extern const struct stmmac_dma_ops dwegmac_dma_ops;
+#endif /* __DWEGMAC_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwegmac_core.c b/drivers/net/ethernet/stmicro/stmmac/dwegmac_core.c
new file mode 100644
index 000000000000..4e0c8731adfb
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwegmac_core.c
@@ -0,0 +1,552 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Loongson Technology Corporation Limited
+ */
+
+#include <linux/crc32.h>
+#include <linux/slab.h>
+#include <linux/ethtool.h>
+#include <linux/io.h>
+#include "stmmac.h"
+#include "stmmac_pcs.h"
+#include "dwegmac.h"
+
+static void dwegmac_core_init(struct mac_device_info *hw,
+			      struct net_device *dev)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	u32 value = readl(ioaddr + GMAC_CONTROL);
+	int mtu = dev->mtu;
+
+	/* Configure GMAC core */
+	value |= GMAC_CORE_INIT;
+
+	if (mtu > 1500)
+		value |= GMAC_CONTROL_2K;
+	if (mtu > 2000)
+		value |= GMAC_CONTROL_JE;
+
+	if (hw->ps) {
+		value |= GMAC_CONTROL_TE;
+
+		value &= ~hw->link.speed_mask;
+		switch (hw->ps) {
+		case SPEED_1000:
+			value |= hw->link.speed1000;
+			break;
+		case SPEED_100:
+			value |= hw->link.speed100;
+			break;
+		case SPEED_10:
+			value |= hw->link.speed10;
+			break;
+		}
+	}
+
+	writel(value, ioaddr + GMAC_CONTROL);
+
+	/* Mask GMAC interrupts */
+	value = GMAC_INT_DEFAULT_MASK;
+
+	if (hw->pcs)
+		value &= ~GMAC_INT_DISABLE_PCS;
+
+	writel(value, ioaddr + GMAC_INT_MASK);
+
+#ifdef STMMAC_VLAN_TAG_USED
+	/* Tag detection without filtering */
+	writel(0x0, ioaddr + GMAC_VLAN_TAG);
+#endif
+}
+
+static int dwegmac_rx_ipc_enable(struct mac_device_info *hw)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	u32 value = readl(ioaddr + GMAC_CONTROL);
+
+	if (hw->rx_csum)
+		value |= GMAC_CONTROL_IPC;
+	else
+		value &= ~GMAC_CONTROL_IPC;
+
+	writel(value, ioaddr + GMAC_CONTROL);
+
+	value = readl(ioaddr + GMAC_CONTROL);
+
+	return !!(value & GMAC_CONTROL_IPC);
+}
+
+static void dwegmac_dump_regs(struct mac_device_info *hw, u32 *reg_space)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	int i;
+
+	for (i = 0; i < 55; i++)
+		reg_space[i] = readl(ioaddr + i * 4);
+}
+
+static void dwegmac_set_umac_addr(struct stmmac_priv *priv,
+				  struct mac_device_info *hw,
+				  const unsigned char *addr,
+				  unsigned int reg_n)
+{
+	void __iomem *ioaddr = hw->pcsr;
+
+	stmmac_set_mac_addr(ioaddr, addr, GMAC_ADDR_HIGH(reg_n),
+			    GMAC_ADDR_LOW(reg_n));
+}
+
+static void dwegmac_get_umac_addr(struct stmmac_priv *priv,
+				  struct mac_device_info *hw,
+				  unsigned char *addr,
+				  unsigned int reg_n)
+{
+	void __iomem *ioaddr = hw->pcsr;
+
+	stmmac_get_mac_addr(ioaddr, addr, GMAC_ADDR_HIGH(reg_n),
+			    GMAC_ADDR_LOW(reg_n));
+}
+
+static void dwegmac_set_mchash(void __iomem *ioaddr, u32 *mcfilterbits,
+			       int mcbitslog2)
+{
+	int numhashregs, regs;
+
+	switch (mcbitslog2) {
+	case 6:
+		writel(mcfilterbits[0], ioaddr + GMAC_HASH_LOW);
+		writel(mcfilterbits[1], ioaddr + GMAC_HASH_HIGH);
+		return;
+	case 7:
+		numhashregs = 4;
+		break;
+	case 8:
+		numhashregs = 8;
+		break;
+	default:
+		pr_debug("STMMAC: err in setting multicast filter\n");
+		return;
+	}
+	for (regs = 0; regs < numhashregs; regs++)
+		writel(mcfilterbits[regs],
+		       ioaddr + GMAC_EXTHASH_BASE + regs * 4);
+}
+
+static void dwegmac_set_filter(struct stmmac_priv *priv,
+			       struct mac_device_info *hw,
+			       struct net_device *dev)
+{
+	void __iomem *ioaddr = (void __iomem *)dev->base_addr;
+	unsigned int value = 0;
+	unsigned int perfect_addr_number = hw->unicast_filter_entries;
+	u32 mc_filter[8];
+	int mcbitslog2 = hw->mcast_bits_log2;
+
+	pr_debug("%s: # mcasts %d, # unicast %d\n", __func__,
+		 netdev_mc_count(dev), netdev_uc_count(dev));
+
+	memset(mc_filter, 0, sizeof(mc_filter));
+
+	if (dev->flags & IFF_PROMISC) {
+		value = GMAC_FRAME_FILTER_PR | GMAC_FRAME_FILTER_PCF;
+	} else if (dev->flags & IFF_ALLMULTI) {
+		value = GMAC_FRAME_FILTER_PM;	/* pass all multi */
+	} else if (!netdev_mc_empty(dev) && (mcbitslog2 == 0)) {
+		/* Fall back to all multicast if we've no filter */
+		value = GMAC_FRAME_FILTER_PM;
+	} else if (!netdev_mc_empty(dev)) {
+		struct netdev_hw_addr *ha;
+
+		/* Hash filter for multicast */
+		value = GMAC_FRAME_FILTER_HMC;
+
+		netdev_for_each_mc_addr(ha, dev) {
+			/* The upper n bits of the calculated CRC are used to
+			 * index the contents of the hash table. The number of
+			 * bits used depends on the hardware configuration
+			 * selected at core configuration time.
+			 */
+			int bit_nr = bitrev32(~crc32_le(~0, ha->addr,
+					      ETH_ALEN)) >>
+					      (32 - mcbitslog2);
+			/* The most significant bit determines the register to
+			 * use (H/L) while the other 5 bits determine the bit
+			 * within the register.
+			 */
+			mc_filter[bit_nr >> 5] |= 1 << (bit_nr & 31);
+		}
+	}
+
+	value |= GMAC_FRAME_FILTER_HPF;
+	dwegmac_set_mchash(ioaddr, mc_filter, mcbitslog2);
+
+	/* Handle multiple unicast addresses (perfect filtering) */
+	if (netdev_uc_count(dev) > perfect_addr_number) {
+		/* Switch to promiscuous mode if more than unicast
+		 * addresses are requested than supported by hardware.
+		 */
+		value |= GMAC_FRAME_FILTER_PR;
+	} else {
+		int reg = 1;
+		struct netdev_hw_addr *ha;
+
+		netdev_for_each_uc_addr(ha, dev) {
+			stmmac_set_mac_addr(ioaddr, ha->addr,
+					    GMAC_ADDR_HIGH(reg),
+					    GMAC_ADDR_LOW(reg));
+			reg++;
+		}
+
+		while (reg < perfect_addr_number) {
+			writel(0, ioaddr + GMAC_ADDR_HIGH(reg));
+			writel(0, ioaddr + GMAC_ADDR_LOW(reg));
+			reg++;
+		}
+	}
+
+#ifdef FRAME_FILTER_DEBUG
+	/* Enable Receive all mode (to debug filtering_fail errors) */
+	value |= GMAC_FRAME_FILTER_RA;
+#endif
+	writel(value, ioaddr + GMAC_FRAME_FILTER);
+}
+
+static void dwegmac_flow_ctrl(struct mac_device_info *hw, unsigned int duplex,
+			      unsigned int fc, unsigned int pause_time,
+			      u32 tx_cnt)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	/* Set flow such that DZPQ in Mac Register 6 is 0,
+	 * and unicast pause detect is enabled.
+	 */
+	unsigned int flow = GMAC_FLOW_CTRL_UP;
+
+	pr_debug("GMAC Flow-Control:\n");
+	if (fc & FLOW_RX) {
+		pr_debug("\tReceive Flow-Control ON\n");
+		flow |= GMAC_FLOW_CTRL_RFE;
+	}
+	if (fc & FLOW_TX) {
+		pr_debug("\tTransmit Flow-Control ON\n");
+		flow |= GMAC_FLOW_CTRL_TFE;
+	}
+
+	if (duplex) {
+		pr_debug("\tduplex mode: PAUSE %d\n", pause_time);
+		flow |= (pause_time << GMAC_FLOW_CTRL_PT_SHIFT);
+	}
+
+	writel(flow, ioaddr + GMAC_FLOW_CTRL);
+}
+
+static void dwegmac_pmt(struct mac_device_info *hw, unsigned long mode)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	unsigned int pmt = 0;
+
+	if (mode & WAKE_MAGIC) {
+		pr_debug("GMAC: WOL Magic frame\n");
+		pmt |= power_down | magic_pkt_en;
+	}
+	if (mode & WAKE_UCAST) {
+		pr_debug("GMAC: WOL on global unicast\n");
+		pmt |= power_down | global_unicast | wake_up_frame_en;
+	}
+
+	writel(pmt, ioaddr + GMAC_PMT);
+}
+
+/* RGMII or SMII interface */
+static void dwegmac_rgsmii(void __iomem *ioaddr, struct stmmac_extra_stats *x)
+{
+	u32 status;
+
+	status = readl(ioaddr + GMAC_RGSMIIIS);
+	x->irq_rgmii_n++;
+
+	/* Check the link status */
+	if (status & GMAC_RGSMIIIS_LNKSTS) {
+		int speed_value;
+
+		x->pcs_link = 1;
+
+		speed_value = ((status & GMAC_RGSMIIIS_SPEED) >>
+			       GMAC_RGSMIIIS_SPEED_SHIFT);
+		if (speed_value == GMAC_RGSMIIIS_SPEED_125)
+			x->pcs_speed = SPEED_1000;
+		else if (speed_value == GMAC_RGSMIIIS_SPEED_25)
+			x->pcs_speed = SPEED_100;
+		else
+			x->pcs_speed = SPEED_10;
+
+		x->pcs_duplex = (status & GMAC_RGSMIIIS_LNKMOD_MASK);
+
+		pr_info("Link is Up - %d/%s\n", (int)x->pcs_speed,
+			x->pcs_duplex ? "Full" : "Half");
+	} else {
+		x->pcs_link = 0;
+		pr_info("Link is Down\n");
+	}
+}
+
+static int dwegmac_irq_status(struct mac_device_info *hw,
+			      struct stmmac_extra_stats *x)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	u32 intr_status = readl(ioaddr + GMAC_INT_STATUS);
+	u32 intr_mask = readl(ioaddr + GMAC_INT_MASK);
+	int ret = 0;
+
+	/* Discard masked bits */
+	intr_status &= ~intr_mask;
+
+	/* Not used events (e.g. MMC interrupts) are not handled. */
+	if ((intr_status & GMAC_INT_STATUS_MMCTIS))
+		x->mmc_tx_irq_n++;
+	if (unlikely(intr_status & GMAC_INT_STATUS_MMCRIS))
+		x->mmc_rx_irq_n++;
+	if (unlikely(intr_status & GMAC_INT_STATUS_MMCCSUM))
+		x->mmc_rx_csum_offload_irq_n++;
+	if (unlikely(intr_status & GMAC_INT_DISABLE_PMT)) {
+		/* clear the PMT bits 5 and 6 by reading the PMT status reg */
+		readl(ioaddr + GMAC_PMT);
+		x->irq_receive_pmt_irq_n++;
+	}
+
+	/* MAC tx/rx EEE LPI entry/exit interrupts */
+	if (intr_status & GMAC_INT_STATUS_LPIIS) {
+		/* Clean LPI interrupt by reading the Reg 12 */
+		ret = readl(ioaddr + LPI_CTRL_STATUS);
+
+		if (ret & LPI_CTRL_STATUS_TLPIEN)
+			x->irq_tx_path_in_lpi_mode_n++;
+		if (ret & LPI_CTRL_STATUS_TLPIEX)
+			x->irq_tx_path_exit_lpi_mode_n++;
+		if (ret & LPI_CTRL_STATUS_RLPIEN)
+			x->irq_rx_path_in_lpi_mode_n++;
+		if (ret & LPI_CTRL_STATUS_RLPIEX)
+			x->irq_rx_path_exit_lpi_mode_n++;
+	}
+
+	dwmac_pcs_isr(ioaddr, GMAC_PCS_BASE, intr_status, x);
+
+	if (intr_status & PCS_RGSMIIIS_IRQ)
+		dwegmac_rgsmii(ioaddr, x);
+
+	return ret;
+}
+
+static void dwegmac_set_eee_mode(struct mac_device_info *hw,
+				 bool en_tx_lpi_clockgating)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	u32 value;
+
+	/*TODO - en_tx_lpi_clockgating treatment */
+
+	/* Enable the link status receive on RGMII, SGMII ore SMII
+	 * receive path and instruct the transmit to enter in LPI
+	 * state.
+	 */
+	value = readl(ioaddr + LPI_CTRL_STATUS);
+	value |= LPI_CTRL_STATUS_LPIEN | LPI_CTRL_STATUS_LPITXA;
+	writel(value, ioaddr + LPI_CTRL_STATUS);
+}
+
+static void dwegmac_reset_eee_mode(struct mac_device_info *hw)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	u32 value;
+
+	value = readl(ioaddr + LPI_CTRL_STATUS);
+	value &= ~(LPI_CTRL_STATUS_LPIEN | LPI_CTRL_STATUS_LPITXA);
+	writel(value, ioaddr + LPI_CTRL_STATUS);
+}
+
+static void dwegmac_set_eee_pls(struct mac_device_info *hw, int link)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	u32 value;
+
+	value = readl(ioaddr + LPI_CTRL_STATUS);
+
+	if (link)
+		value |= LPI_CTRL_STATUS_PLS;
+	else
+		value &= ~LPI_CTRL_STATUS_PLS;
+
+	writel(value, ioaddr + LPI_CTRL_STATUS);
+}
+
+static void dwegmac_set_eee_timer(struct mac_device_info *hw, int ls, int tw)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	int value = ((tw & 0xffff)) | ((ls & 0x7ff) << 16);
+
+	/* Program the timers in the LPI timer control register:
+	 * LS: minimum time (ms) for which the link
+	 *  status from PHY should be ok before transmitting
+	 *  the LPI pattern.
+	 * TW: minimum time (us) for which the core waits
+	 *  after it has stopped transmitting the LPI pattern.
+	 */
+	writel(value, ioaddr + LPI_TIMER_CTRL);
+}
+
+static void dwegmac_ctrl_ane(void __iomem *ioaddr, bool ane, bool srgmi_ral,
+			     bool loopback)
+{
+	dwmac_ctrl_ane(ioaddr, GMAC_PCS_BASE, ane, srgmi_ral, loopback);
+}
+
+static void dwegmac_rane(void __iomem *ioaddr, bool restart)
+{
+	dwmac_rane(ioaddr, GMAC_PCS_BASE, restart);
+}
+
+static void dwegmac_get_adv_lp(void __iomem *ioaddr, struct rgmii_adv *adv)
+{
+	dwmac_get_adv_lp(ioaddr, GMAC_PCS_BASE, adv);
+}
+
+static void dwegmac_debug(struct stmmac_priv *priv, void __iomem *ioaddr,
+			  struct stmmac_extra_stats *x,
+			  u32 rx_queues, u32 tx_queues)
+{
+	u32 value = readl(ioaddr + GMAC_DEBUG);
+
+	if (value & GMAC_DEBUG_TXSTSFSTS)
+		x->mtl_tx_status_fifo_full++;
+	if (value & GMAC_DEBUG_TXFSTS)
+		x->mtl_tx_fifo_not_empty++;
+	if (value & GMAC_DEBUG_TWCSTS)
+		x->mmtl_fifo_ctrl++;
+	if (value & GMAC_DEBUG_TRCSTS_MASK) {
+		u32 trcsts = (value & GMAC_DEBUG_TRCSTS_MASK)
+			     >> GMAC_DEBUG_TRCSTS_SHIFT;
+		if (trcsts == GMAC_DEBUG_TRCSTS_WRITE)
+			x->mtl_tx_fifo_read_ctrl_write++;
+		else if (trcsts == GMAC_DEBUG_TRCSTS_TXW)
+			x->mtl_tx_fifo_read_ctrl_wait++;
+		else if (trcsts == GMAC_DEBUG_TRCSTS_READ)
+			x->mtl_tx_fifo_read_ctrl_read++;
+		else
+			x->mtl_tx_fifo_read_ctrl_idle++;
+	}
+	if (value & GMAC_DEBUG_TXPAUSED)
+		x->mac_tx_in_pause++;
+	if (value & GMAC_DEBUG_TFCSTS_MASK) {
+		u32 tfcsts = (value & GMAC_DEBUG_TFCSTS_MASK)
+			      >> GMAC_DEBUG_TFCSTS_SHIFT;
+
+		if (tfcsts == GMAC_DEBUG_TFCSTS_XFER)
+			x->mac_tx_frame_ctrl_xfer++;
+		else if (tfcsts == GMAC_DEBUG_TFCSTS_GEN_PAUSE)
+			x->mac_tx_frame_ctrl_pause++;
+		else if (tfcsts == GMAC_DEBUG_TFCSTS_WAIT)
+			x->mac_tx_frame_ctrl_wait++;
+		else
+			x->mac_tx_frame_ctrl_idle++;
+	}
+	if (value & GMAC_DEBUG_TPESTS)
+		x->mac_gmii_tx_proto_engine++;
+	if (value & GMAC_DEBUG_RXFSTS_MASK) {
+		u32 rxfsts = (value & GMAC_DEBUG_RXFSTS_MASK)
+			     >> GMAC_DEBUG_RRCSTS_SHIFT;
+
+		if (rxfsts == GMAC_DEBUG_RXFSTS_FULL)
+			x->mtl_rx_fifo_fill_level_full++;
+		else if (rxfsts == GMAC_DEBUG_RXFSTS_AT)
+			x->mtl_rx_fifo_fill_above_thresh++;
+		else if (rxfsts == GMAC_DEBUG_RXFSTS_BT)
+			x->mtl_rx_fifo_fill_below_thresh++;
+		else
+			x->mtl_rx_fifo_fill_level_empty++;
+	}
+	if (value & GMAC_DEBUG_RRCSTS_MASK) {
+		u32 rrcsts = (value & GMAC_DEBUG_RRCSTS_MASK) >>
+			     GMAC_DEBUG_RRCSTS_SHIFT;
+
+		if (rrcsts == GMAC_DEBUG_RRCSTS_FLUSH)
+			x->mtl_rx_fifo_read_ctrl_flush++;
+		else if (rrcsts == GMAC_DEBUG_RRCSTS_RSTAT)
+			x->mtl_rx_fifo_read_ctrl_read_data++;
+		else if (rrcsts == GMAC_DEBUG_RRCSTS_RDATA)
+			x->mtl_rx_fifo_read_ctrl_status++;
+		else
+			x->mtl_rx_fifo_read_ctrl_idle++;
+	}
+	if (value & GMAC_DEBUG_RWCSTS)
+		x->mtl_rx_fifo_ctrl_active++;
+	if (value & GMAC_DEBUG_RFCFCSTS_MASK)
+		x->mac_rx_frame_ctrl_fifo = (value & GMAC_DEBUG_RFCFCSTS_MASK)
+					    >> GMAC_DEBUG_RFCFCSTS_SHIFT;
+	if (value & GMAC_DEBUG_RPESTS)
+		x->mac_gmii_rx_proto_engine++;
+}
+
+static void dwegmac_set_mac_loopback(void __iomem *ioaddr, bool enable)
+{
+	u32 value = readl(ioaddr + GMAC_CONTROL);
+
+	if (enable)
+		value |= GMAC_CONTROL_LM;
+	else
+		value &= ~GMAC_CONTROL_LM;
+
+	writel(value, ioaddr + GMAC_CONTROL);
+}
+
+const struct stmmac_ops dwegmac_ops = {
+	.core_init = dwegmac_core_init,
+	.set_mac = stmmac_set_mac,
+	.rx_ipc = dwegmac_rx_ipc_enable,
+	.dump_regs = dwegmac_dump_regs,
+	.host_irq_status = dwegmac_irq_status,
+	.set_filter = dwegmac_set_filter,
+	.flow_ctrl = dwegmac_flow_ctrl,
+	.pmt = dwegmac_pmt,
+	.set_umac_addr = dwegmac_set_umac_addr,
+	.get_umac_addr = dwegmac_get_umac_addr,
+	.set_eee_mode = dwegmac_set_eee_mode,
+	.reset_eee_mode = dwegmac_reset_eee_mode,
+	.set_eee_timer = dwegmac_set_eee_timer,
+	.set_eee_pls = dwegmac_set_eee_pls,
+	.debug = dwegmac_debug,
+	.pcs_ctrl_ane = dwegmac_ctrl_ane,
+	.pcs_rane = dwegmac_rane,
+	.pcs_get_adv_lp = dwegmac_get_adv_lp,
+	.set_mac_loopback = dwegmac_set_mac_loopback,
+};
+
+int dwegmac_setup(struct stmmac_priv *priv)
+{
+	struct mac_device_info *mac = priv->hw;
+
+	dev_info(priv->device, "\tExtended DWMAC\n");
+
+	priv->dev->priv_flags |= IFF_UNICAST_FLT;
+	mac->pcsr = priv->ioaddr;
+	mac->multicast_filter_bins = priv->plat->multicast_filter_bins;
+	mac->unicast_filter_entries = priv->plat->unicast_filter_entries;
+	mac->mcast_bits_log2 = 0;
+
+	if (mac->multicast_filter_bins)
+		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
+
+	mac->link.duplex = GMAC_CONTROL_DM;
+	mac->link.speed10 = GMAC_CONTROL_PS;
+	mac->link.speed100 = GMAC_CONTROL_PS | GMAC_CONTROL_FES;
+	mac->link.speed1000 = 0;
+	mac->link.speed_mask = GMAC_CONTROL_PS | GMAC_CONTROL_FES;
+	mac->mii.addr = GMAC_MII_ADDR;
+	mac->mii.data = GMAC_MII_DATA;
+	mac->mii.addr_shift = 11;
+	mac->mii.addr_mask = 0x0000F800;
+	mac->mii.reg_shift = 6;
+	mac->mii.reg_mask = 0x000007C0;
+	mac->mii.clk_csr_shift = 2;
+	mac->mii.clk_csr_mask = GENMASK(5, 2);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwegmac_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwegmac_dma.c
new file mode 100644
index 000000000000..9bb0564fbeff
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwegmac_dma.c
@@ -0,0 +1,516 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Loongson Technology Corporation Limited
+ */
+
+#include <linux/io.h>
+#include "stmmac.h"
+#include "dwegmac.h"
+#include "dwegmac_dma.h"
+
+static int dwegmac_dma_reset(struct stmmac_priv *priv, void __iomem *ioaddr)
+{
+	u32 value = readl(ioaddr + DMA_BUS_MODE);
+
+	value |= DMA_BUS_MODE_SFT_RESET;
+	writel(value, ioaddr + DMA_BUS_MODE);
+
+	return readl_poll_timeout(ioaddr + DMA_BUS_MODE, value,
+				 !(value & DMA_BUS_MODE_SFT_RESET),
+				 10000, 200000);
+}
+
+static void dwegmac_enable_dma_transmission(struct stmmac_priv *priv,
+					    void __iomem *ioaddr, u32 chan)
+{
+	writel(1, ioaddr + DMA_CHAN_XMT_POLL_DEMAND(chan));
+}
+
+static void dwegmac_enable_dma_irq(struct stmmac_priv *priv,
+				   void __iomem *ioaddr,
+				   u32 chan, bool rx, bool tx)
+{
+	u32 value = readl(ioaddr + DMA_CHAN_INTR_ENA(chan));
+
+	if (rx)
+		value |= DMA_INTR_DEFAULT_RX;
+	if (tx)
+		value |= DMA_INTR_DEFAULT_TX;
+
+	writel(value, ioaddr + DMA_CHAN_INTR_ENA(chan));
+}
+
+static void dwegmac_disable_dma_irq(struct stmmac_priv *priv,
+				    void __iomem *ioaddr,
+				    u32 chan, bool rx, bool tx)
+{
+	u32 value = readl(ioaddr + DMA_CHAN_INTR_ENA(chan));
+
+	if (rx)
+		value &= ~DMA_INTR_DEFAULT_RX;
+	if (tx)
+		value &= ~DMA_INTR_DEFAULT_TX;
+
+	writel(value, ioaddr + DMA_CHAN_INTR_ENA(chan));
+}
+
+static void dwegmac_dma_start_tx(struct stmmac_priv *priv,
+				 void __iomem *ioaddr, u32 chan)
+{
+	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
+
+	value |= DMA_CONTROL_ST;
+	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
+}
+
+static void dwegmac_dma_stop_tx(struct stmmac_priv *priv,
+				void __iomem *ioaddr, u32 chan)
+{
+	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
+
+	value &= ~DMA_CONTROL_ST;
+	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
+}
+
+static void dwegmac_dma_start_rx(struct stmmac_priv *priv,
+				 void __iomem *ioaddr, u32 chan)
+{
+	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
+
+	value |= DMA_CONTROL_SR;
+	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
+}
+
+static void dwegmac_dma_stop_rx(struct stmmac_priv *priv,
+				void __iomem *ioaddr, u32 chan)
+{
+	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
+
+	value &= ~DMA_CONTROL_SR;
+	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
+}
+
+static int dwegmac_dma_interrupt(struct stmmac_priv *priv,
+				 void __iomem *ioaddr,
+				 struct stmmac_extra_stats *x,
+				 u32 chan, u32 dir)
+{
+	int ret = 0;
+	u32 intr_status = readl(ioaddr + DMA_CHAN_STATUS(chan));
+
+	if (dir == DMA_DIR_RX)
+		intr_status &= DMA_STATUS_MSK_RX;
+	else if (dir == DMA_DIR_TX)
+		intr_status &= DMA_STATUS_MSK_TX;
+
+	/* ABNORMAL interrupts */
+	if (unlikely(intr_status & (DMA_STATUS_TX_AIS | DMA_STATUS_RX_AIS))) {
+		if (unlikely(intr_status & DMA_STATUS_UNF)) {
+			ret = tx_hard_error_bump_tc;
+			x->tx_undeflow_irq++;
+		}
+		if (unlikely(intr_status & DMA_STATUS_TJT))
+			x->tx_jabber_irq++;
+
+		if (unlikely(intr_status & DMA_STATUS_OVF))
+			x->rx_overflow_irq++;
+
+		if (unlikely(intr_status & DMA_STATUS_RU))
+			x->rx_buf_unav_irq++;
+		if (unlikely(intr_status & DMA_STATUS_RPS))
+			x->rx_process_stopped_irq++;
+		if (unlikely(intr_status & DMA_STATUS_RWT))
+			x->rx_watchdog_irq++;
+		if (unlikely(intr_status & DMA_STATUS_ETI))
+			x->tx_early_irq++;
+		if (unlikely(intr_status & DMA_STATUS_TPS)) {
+			x->tx_process_stopped_irq++;
+			ret = tx_hard_error;
+		}
+		if (unlikely(intr_status &
+			     (DMA_STATUS_TX_FBI | DMA_STATUS_RX_FBI))) {
+			x->fatal_bus_error_irq++;
+			ret = tx_hard_error;
+		}
+	}
+	/* TX/RX NORMAL interrupts */
+	if (likely(intr_status & (DMA_STATUS_TX_NIS | DMA_STATUS_RX_NIS))) {
+		x->normal_irq_n++;
+		if (likely(intr_status & DMA_STATUS_RI)) {
+			u32 value = readl(ioaddr + DMA_INTR_ENA);
+			/* to schedule NAPI on real RIE event. */
+			if (likely(value & DMA_INTR_ENA_RIE)) {
+				x->rx_normal_irq_n++;
+				ret |= handle_rx;
+			}
+		}
+		if (likely(intr_status & DMA_STATUS_TI)) {
+			x->tx_normal_irq_n++;
+			ret |= handle_tx;
+		}
+		if (unlikely(intr_status & DMA_STATUS_ERI))
+			x->rx_early_irq++;
+	}
+
+	writel((intr_status & 0x7ffff), ioaddr + DMA_CHAN_STATUS(chan));
+
+	return ret;
+}
+
+static void dwegmac_dma_axi(struct stmmac_priv *priv, void __iomem *ioaddr,
+			    struct stmmac_axi *axi)
+{
+	u32 value = readl(ioaddr + DMA_AXI_BUS_MODE);
+	int i;
+
+	pr_info("dwegmac: Master AXI performs %s burst length\n",
+		!(value & DMA_AXI_UNDEF) ? "fixed" : "any");
+
+	if (axi->axi_lpi_en)
+		value |= DMA_AXI_EN_LPI;
+	if (axi->axi_xit_frm)
+		value |= DMA_AXI_LPI_XIT_FRM;
+
+	if (priv->plat->dma_cfg->dma64) {
+		value &= ~DMA_AXI_WR_OSR64_LMT;
+		value |= (axi->axi_wr_osr_lmt & DMA_AXI_WR_OSR64_LMT_MASK) <<
+			 DMA_AXI_WR_OSR64_LMT_SHIFT;
+
+		value &= ~DMA_AXI_RD_OSR64_LMT;
+		value |= (axi->axi_rd_osr_lmt & DMA_AXI_RD_OSR64_LMT_MASK) <<
+			 DMA_AXI_RD_OSR64_LMT_SHIFT;
+	} else {
+		value &= ~DMA_AXI_WR_OSR_LMT;
+		value |= (axi->axi_wr_osr_lmt & DMA_AXI_WR_OSR_LMT_MASK) <<
+			 DMA_AXI_WR_OSR_LMT_SHIFT;
+
+		value &= ~DMA_AXI_RD_OSR_LMT;
+		value |= (axi->axi_rd_osr_lmt & DMA_AXI_RD_OSR_LMT_MASK) <<
+			 DMA_AXI_RD_OSR_LMT_SHIFT;
+	}
+
+	/* Depending on the UNDEF bit the Master AXI will perform any burst
+	 * length according to the BLEN programmed (by default all BLEN are
+	 * set).
+	 */
+	for (i = 0; i < AXI_BLEN; i++) {
+		switch (axi->axi_blen[i]) {
+		case 256:
+			value |= DMA_AXI_BLEN256;
+			break;
+		case 128:
+			value |= DMA_AXI_BLEN128;
+			break;
+		case 64:
+			value |= DMA_AXI_BLEN64;
+			break;
+		case 32:
+			value |= DMA_AXI_BLEN32;
+			break;
+		case 16:
+			value |= DMA_AXI_BLEN16;
+			break;
+		case 8:
+			value |= DMA_AXI_BLEN8;
+			break;
+		case 4:
+			value |= DMA_AXI_BLEN4;
+			break;
+		}
+	}
+
+	writel(value, ioaddr + DMA_AXI_BUS_MODE);
+}
+
+static void dwegmac_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
+			     struct stmmac_dma_cfg *dma_cfg, int atds)
+{
+	u32 value = readl(ioaddr + DMA_BUS_MODE);
+	int txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
+	int rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
+
+	/* Set the DMA PBL (Programmable Burst Length) mode.
+	 *
+	 * Note: before stmmac core 3.50 this mode bit was 4xPBL, and
+	 * post 3.5 mode bit acts as 8*PBL.
+	 */
+	if (dma_cfg->pblx8)
+		value |= DMA_BUS_MODE_MAXPBL;
+	value |= DMA_BUS_MODE_USP;
+	value &= ~(DMA_BUS_MODE_PBL_MASK | DMA_BUS_MODE_RPBL_MASK);
+	value |= (txpbl << DMA_BUS_MODE_PBL_SHIFT);
+	value |= (rxpbl << DMA_BUS_MODE_RPBL_SHIFT);
+
+	/* Set the Fixed burst mode */
+	if (dma_cfg->fixed_burst)
+		value |= DMA_BUS_MODE_FB;
+
+	/* Mixed Burst has no effect when fb is set */
+	if (dma_cfg->mixed_burst)
+		value |= DMA_BUS_MODE_MB;
+
+	if (atds)
+		value |= DMA_BUS_MODE_ATDS;
+
+	if (dma_cfg->aal)
+		value |= DMA_BUS_MODE_AAL;
+
+	writel(value, ioaddr + DMA_BUS_MODE);
+
+	/* Mask interrupts by writing to CSR7 */
+	writel(DMA_INTR_DEFAULT_MASK, ioaddr + DMA_INTR_ENA);
+}
+
+static void dwegmac_dma_init_channel(struct stmmac_priv *priv,
+				     void __iomem *ioaddr,
+				     struct stmmac_dma_cfg *dma_cfg,
+				     u32 chan)
+{
+	u32 value;
+	int txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
+	int rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
+
+	if (!priv->plat->multi_msi_en)
+		return;
+
+	/* common channel control register config */
+	value = readl(ioaddr + DMA_CHAN_BUS_MODE(chan));
+
+	/* Set the DMA PBL (Programmable Burst Length) mode.
+	 *
+	 * Note: before stmmac core 3.50 this mode bit was 4xPBL, and
+	 * post 3.5 mode bit acts as 8*PBL.
+	 */
+	if (dma_cfg->pblx8)
+		value |= DMA_BUS_MODE_MAXPBL;
+	value |= DMA_BUS_MODE_USP;
+	value &= ~(DMA_BUS_MODE_PBL_MASK | DMA_BUS_MODE_RPBL_MASK);
+	value |= (txpbl << DMA_BUS_MODE_PBL_SHIFT);
+	value |= (rxpbl << DMA_BUS_MODE_RPBL_SHIFT);
+
+	/* Set the Fixed burst mode */
+	if (dma_cfg->fixed_burst)
+		value |= DMA_BUS_MODE_FB;
+
+	/* Mixed Burst has no effect when fb is set */
+	if (dma_cfg->mixed_burst)
+		value |= DMA_BUS_MODE_MB;
+
+	value |= DMA_BUS_MODE_ATDS;
+
+	if (dma_cfg->aal)
+		value |= DMA_BUS_MODE_AAL;
+
+	writel(value, ioaddr + DMA_CHAN_BUS_MODE(chan));
+
+	/* Mask interrupts by writing to CSR7 */
+	writel(DMA_INTR_DEFAULT_MASK, ioaddr + DMA_CHAN_INTR_ENA(chan));
+
+	if (dma_cfg->dma64)
+		writel(0x100, ioaddr + DMA_CHAN_NEWFUNC_CONFIG(chan));
+}
+
+static void dwegmac_dma_init_rx(struct stmmac_priv *priv,
+				void __iomem *ioaddr,
+				struct stmmac_dma_cfg *dma_cfg,
+				dma_addr_t dma_rx_phy, u32 chan)
+{
+	if (dma_cfg->dma64) {
+		writel(lower_32_bits(dma_rx_phy), ioaddr +
+		       DMA_CHAN_RCV_BASE_ADDR64(chan));
+		writel(upper_32_bits(dma_rx_phy), ioaddr +
+		       DMA_CHAN_RCV_BASE_ADDR64_HI(chan));
+		writel(upper_32_bits(dma_rx_phy), ioaddr +
+		       DMA_RCV_BASE_ADDR64_HI_SHADOW1);
+		writel(upper_32_bits(dma_rx_phy), ioaddr +
+		       DMA_RCV_BASE_ADDR64_HI_SHADOW2);
+	} else {
+		writel(lower_32_bits(dma_rx_phy), ioaddr +
+		       DMA_CHAN_RCV_BASE_ADDR(chan));
+	}
+}
+
+static void dwegmac_dma_init_tx(struct stmmac_priv *priv,
+				void __iomem *ioaddr,
+				struct stmmac_dma_cfg *dma_cfg,
+				dma_addr_t dma_tx_phy, u32 chan)
+{
+	if (dma_cfg->dma64) {
+		writel(lower_32_bits(dma_tx_phy), ioaddr +
+		       DMA_CHAN_TX_BASE_ADDR64(chan));
+		writel(upper_32_bits(dma_tx_phy), ioaddr +
+		       DMA_CHAN_TX_BASE_ADDR64_HI(chan));
+	} else {
+		writel(lower_32_bits(dma_tx_phy), ioaddr +
+		       DMA_CHAN_TX_BASE_ADDR(chan));
+	}
+}
+
+static u32 dwegmac_configure_fc(u32 csr6, int rxfifosz)
+{
+	csr6 &= ~DMA_CONTROL_RFA_MASK;
+	csr6 &= ~DMA_CONTROL_RFD_MASK;
+
+	/* Leave flow control disabled if receive fifo size is less than
+	 * 4K or 0. Otherwise, send XOFF when fifo is 1K less than full,
+	 * and send XON when 2K less than full.
+	 */
+	if (rxfifosz < 4096) {
+		csr6 &= ~DMA_CONTROL_EFC;
+		pr_debug("GMAC: disabling flow control, rxfifo too small(%d)\n",
+			 rxfifosz);
+	} else {
+		csr6 |= DMA_CONTROL_EFC;
+		csr6 |= RFA_FULL_MINUS_1K;
+		csr6 |= RFD_FULL_MINUS_2K;
+	}
+	return csr6;
+}
+
+static void dwegmac_dma_operation_mode_rx(struct stmmac_priv *priv,
+					  void __iomem *ioaddr, int mode,
+					  u32 channel, int fifosz, u8 qmode)
+{
+	u32 csr6 = readl(ioaddr + DMA_CHAN_CONTROL(channel));
+
+	if (mode == SF_DMA_MODE) {
+		pr_debug("GMAC: enable RX store and forward mode\n");
+		csr6 |= DMA_CONTROL_RSF;
+	} else {
+		pr_debug("GMAC: disable RX SF mode (threshold %d)\n", mode);
+		csr6 &= ~DMA_CONTROL_RSF;
+		csr6 &= DMA_CONTROL_TC_RX_MASK;
+		if (mode <= 32)
+			csr6 |= DMA_CONTROL_RTC_32;
+		else if (mode <= 64)
+			csr6 |= DMA_CONTROL_RTC_64;
+		else if (mode <= 96)
+			csr6 |= DMA_CONTROL_RTC_96;
+		else
+			csr6 |= DMA_CONTROL_RTC_128;
+	}
+
+	/* Configure flow control based on rx fifo size */
+	csr6 = dwegmac_configure_fc(csr6, fifosz);
+
+	writel(csr6, ioaddr + DMA_CHAN_CONTROL(channel));
+}
+
+static void dwegmac_dma_operation_mode_tx(struct stmmac_priv *priv,
+					  void __iomem *ioaddr, int mode,
+					  u32 channel, int fifosz, u8 qmode)
+{
+	u32 csr6 = readl(ioaddr + DMA_CHAN_CONTROL(channel));
+
+	if (mode == SF_DMA_MODE) {
+		pr_debug("GMAC: enable TX store and forward mode\n");
+		/* Transmit COE type 2 cannot be done in cut-through mode. */
+		csr6 |= DMA_CONTROL_TSF;
+		/* Operating on second frame increase the performance
+		 * especially when transmit store-and-forward is used.
+		 */
+		csr6 |= DMA_CONTROL_OSF;
+	} else {
+		pr_debug("GMAC: disabling TX SF (threshold %d)\n", mode);
+		csr6 &= ~DMA_CONTROL_TSF;
+		csr6 &= DMA_CONTROL_TC_TX_MASK;
+		/* Set the transmit threshold */
+		if (mode <= 32)
+			csr6 |= DMA_CONTROL_TTC_32;
+		else if (mode <= 64)
+			csr6 |= DMA_CONTROL_TTC_64;
+		else if (mode <= 128)
+			csr6 |= DMA_CONTROL_TTC_128;
+		else if (mode <= 192)
+			csr6 |= DMA_CONTROL_TTC_192;
+		else
+			csr6 |= DMA_CONTROL_TTC_256;
+	}
+
+	writel(csr6, ioaddr + DMA_CHAN_CONTROL(channel));
+}
+
+static void dwegmac_dump_dma_regs(struct stmmac_priv *priv,
+				  void __iomem *ioaddr, u32 *reg_space)
+{
+	int i;
+
+	for (i = 0; i < NUM_DWEGMAC_DMA_REGS; i++)
+		if (i < 12 || i > 17)
+			reg_space[DMA_BUS_MODE / 4 + i] =
+				readl(ioaddr + DMA_BUS_MODE + i * 4);
+}
+
+static int dwegmac_get_hw_feature(struct stmmac_priv *priv,
+				  void __iomem *ioaddr,
+				  struct dma_features *dma_cap)
+{
+	u32 hw_cap = readl(ioaddr + DMA_HW_FEATURE);
+
+	if (!hw_cap) {
+		/* 0x00000000 is the value read on old hardware that does not
+		 * implement this register
+		 */
+		return -EOPNOTSUPP;
+	}
+
+	dma_cap->mbps_10_100 = (hw_cap & DMA_HW_FEAT_MIISEL);
+	dma_cap->mbps_1000 = (hw_cap & DMA_HW_FEAT_GMIISEL) >> 1;
+	dma_cap->half_duplex = (hw_cap & DMA_HW_FEAT_HDSEL) >> 2;
+	dma_cap->hash_filter = (hw_cap & DMA_HW_FEAT_HASHSEL) >> 4;
+	dma_cap->multi_addr = (hw_cap & DMA_HW_FEAT_ADDMAC) >> 5;
+	dma_cap->pcs = (hw_cap & DMA_HW_FEAT_PCSSEL) >> 6;
+	dma_cap->sma_mdio = (hw_cap & DMA_HW_FEAT_SMASEL) >> 8;
+	dma_cap->pmt_remote_wake_up = (hw_cap & DMA_HW_FEAT_RWKSEL) >> 9;
+	dma_cap->pmt_magic_frame = (hw_cap & DMA_HW_FEAT_MGKSEL) >> 10;
+	/* MMC */
+	dma_cap->rmon = (hw_cap & DMA_HW_FEAT_MMCSEL) >> 11;
+	/* IEEE 1588-2002 */
+	dma_cap->time_stamp =
+	    (hw_cap & DMA_HW_FEAT_TSVER1SEL) >> 12;
+	/* IEEE 1588-2008 */
+	dma_cap->atime_stamp = (hw_cap & DMA_HW_FEAT_TSVER2SEL) >> 13;
+	/* 802.3az - Energy-Efficient Ethernet (EEE) */
+	dma_cap->eee = (hw_cap & DMA_HW_FEAT_EEESEL) >> 14;
+	dma_cap->av = (hw_cap & DMA_HW_FEAT_AVSEL) >> 15;
+	/* TX and RX csum */
+	dma_cap->tx_coe = (hw_cap & DMA_HW_FEAT_TXCOESEL) >> 16;
+	dma_cap->rx_coe_type1 = (hw_cap & DMA_HW_FEAT_RXTYP1COE) >> 17;
+	dma_cap->rx_coe_type2 = (hw_cap & DMA_HW_FEAT_RXTYP2COE) >> 18;
+	dma_cap->rxfifo_over_2048 = (hw_cap & DMA_HW_FEAT_RXFIFOSIZE) >> 19;
+	/* TX and RX number of channels */
+	dma_cap->number_rx_channel = (hw_cap & DMA_HW_FEAT_RXCHCNT) >> 20;
+	dma_cap->number_tx_channel = (hw_cap & DMA_HW_FEAT_TXCHCNT) >> 22;
+	/* Alternate (enhanced) DESC mode */
+	dma_cap->enh_desc = (hw_cap & DMA_HW_FEAT_ENHDESSEL) >> 24;
+
+	return 0;
+}
+
+static void dwegmac_rx_watchdog(struct stmmac_priv *priv,
+				void __iomem *ioaddr, u32 riwt, u32 queue)
+{
+	writel(riwt, ioaddr + DMA_CHAN_RX_WATCHDOG(queue));
+}
+
+const struct stmmac_dma_ops dwegmac_dma_ops = {
+	.reset = dwegmac_dma_reset,
+	.init = dwegmac_dma_init,
+	.init_chan = dwegmac_dma_init_channel,
+	.init_rx_chan = dwegmac_dma_init_rx,
+	.init_tx_chan = dwegmac_dma_init_tx,
+	.axi = dwegmac_dma_axi,
+	.dump_regs = dwegmac_dump_dma_regs,
+	.dma_rx_mode = dwegmac_dma_operation_mode_rx,
+	.dma_tx_mode = dwegmac_dma_operation_mode_tx,
+	.enable_dma_transmission = dwegmac_enable_dma_transmission,
+	.enable_dma_irq = dwegmac_enable_dma_irq,
+	.disable_dma_irq = dwegmac_disable_dma_irq,
+	.start_tx = dwegmac_dma_start_tx,
+	.stop_tx = dwegmac_dma_stop_tx,
+	.start_rx = dwegmac_dma_start_rx,
+	.stop_rx = dwegmac_dma_stop_rx,
+	.dma_interrupt = dwegmac_dma_interrupt,
+	.get_hw_feature = dwegmac_get_hw_feature,
+	.rx_watchdog = dwegmac_rx_watchdog,
+};
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwegmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwegmac_dma.h
new file mode 100644
index 000000000000..aadc13eae502
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwegmac_dma.h
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Loongson Technology Corporation Limited
+ */
+
+#ifndef __DWEGMAC_DMA_H__
+#define __DWEGMAC_DMA_H__
+
+/* DMA CRS Control and Status Register Mapping */
+#define DMA_BUS_MODE			0x00001000	/* Bus Mode */
+#define DMA_XMT_POLL_DEMAND		0x00001004	/* Transmit Poll Demand */
+#define DMA_RCV_POLL_DEMAND		0x00001008	/* Received Poll Demand */
+#define DMA_RCV_BASE_ADDR		0x0000100c	/* Receive List Base */
+#define DMA_RCV_BASE_ADDR64		0x00001090
+#define DMA_RCV_BASE_ADDR64_HI		0x00001094
+#define DMA_RCV_BASE_ADDR64_HI_SHADOW1	0x00001068
+#define DMA_RCV_BASE_ADDR64_HI_SHADOW2	0x000010a8
+#define DMA_TX_BASE_ADDR		0x00001010	/* Transmit List Base */
+#define DMA_TX_BASE_ADDR64		0x00001098
+#define DMA_TX_BASE_ADDR64_HI		0x0000109c
+#define DMA_STATUS			0x00001014	/* Status Register */
+#define DMA_CONTROL			0x00001018	/* Ctrl (Operational Mode) */
+#define DMA_INTR_ENA			0x0000101c	/* Interrupt Enable */
+#define DMA_MISSED_FRAME_CTR		0x00001020	/* Missed Frame Counter */
+#define DMA_NEWFUNC_CONFIG		0x00001080	/* New Function Config */
+
+/* SW Reset */
+#define DMA_BUS_MODE_SFT_RESET		0x00000001	/* Software Reset */
+
+/* Rx watchdog register */
+#define DMA_RX_WATCHDOG			0x00001024
+
+/* AXI Master Bus Mode */
+#define DMA_AXI_BUS_MODE		0x00001028
+
+#define DMA_AXI_EN_LPI			BIT(31)
+#define DMA_AXI_LPI_XIT_FRM		BIT(30)
+#define DMA_AXI_WR_OSR_LMT		GENMASK(23, 20)
+#define DMA_AXI_WR_OSR_LMT_SHIFT	20
+#define DMA_AXI_WR_OSR_LMT_MASK		0xf
+#define DMA_AXI_RD_OSR_LMT		GENMASK(19, 16)
+#define DMA_AXI_RD_OSR_LMT_SHIFT	16
+#define DMA_AXI_RD_OSR_LMT_MASK		0xf
+#define DMA_AXI_WR_OSR64_LMT		GENMASK(21, 20)
+#define DMA_AXI_WR_OSR64_LMT_SHIFT	20
+#define DMA_AXI_WR_OSR64_LMT_MASK	0x3
+#define DMA_AXI_RD_OSR64_LMT		GENMASK(17, 16)
+#define DMA_AXI_RD_OSR64_LMT_SHIFT	16
+#define DMA_AXI_RD_OSR64_LMT_MASK	0x3
+
+#define DMA_AXI_OSR_MAX			0xf
+#define DMA_AXI_MAX_OSR_LIMIT		((DMA_AXI_OSR_MAX << DMA_AXI_WR_OSR_LMT_SHIFT) | \
+					 (DMA_AXI_OSR_MAX << DMA_AXI_RD_OSR_LMT_SHIFT))
+#define DMA_AXI_OSR64_MAX		0x3
+#define DMA_AXI_MAX_OSR64_LIMIT		((DMA_AXI_OSR64_MAX << DMA_AXI_WR_OSR64_LMT_SHIFT) | \
+					 (DMA_AXI_OSR64_MAX << DMA_AXI_RD_OSR64_LMT_SHIFT))
+#define	DMA_AXI_1KBBE			BIT(13)
+#define DMA_AXI_AAL			BIT(12)
+#define DMA_AXI_BLEN256			BIT(7)
+#define DMA_AXI_BLEN128			BIT(6)
+#define DMA_AXI_BLEN64			BIT(5)
+#define DMA_AXI_BLEN32			BIT(4)
+#define DMA_AXI_BLEN16			BIT(3)
+#define DMA_AXI_BLEN8			BIT(2)
+#define DMA_AXI_BLEN4			BIT(1)
+#define DMA_BURST_LEN_DEFAULT		(DMA_AXI_BLEN256 | DMA_AXI_BLEN128 | \
+					 DMA_AXI_BLEN64 | DMA_AXI_BLEN32 | \
+					 DMA_AXI_BLEN16 | DMA_AXI_BLEN8 | \
+					 DMA_AXI_BLEN4)
+
+#define DMA_AXI_UNDEF			BIT(0)
+
+#define DMA_AXI_BURST_LEN_MASK		0x000000fe
+
+#define DMA_CUR_TX_BUF_ADDR		0x00001050	/* Current Host Tx Buffer */
+#define DMA_CUR_RX_BUF_ADDR		0x00001054	/* Current Host Rx Buffer */
+#define DMA_HW_FEATURE			0x00001058	/* HW Feature Register */
+
+/* DMA Control register defines */
+#define DMA_CONTROL_ST			0x00002000	/* Start/Stop Transmission */
+#define DMA_CONTROL_SR			0x00000002	/* Start/Stop Receive */
+
+/* DMA Normal interrupt */
+#define DMA_INTR_ENA_NIE		0x00060000	/* Normal Summary */
+#define DMA_INTR_ENA_TIE		0x00000001	/* Transmit Interrupt */
+#define DMA_INTR_ENA_TUE		0x00000004	/* Transmit Buffer Unavailable */
+#define DMA_INTR_ENA_RIE		0x00000040	/* Receive Interrupt */
+#define DMA_INTR_ENA_ERE		0x00004000	/* Early Receive */
+
+#define DMA_INTR_NORMAL			(DMA_INTR_ENA_NIE | DMA_INTR_ENA_RIE | \
+					 DMA_INTR_ENA_TIE)
+
+/* DMA Abnormal interrupt */
+#define DMA_INTR_ENA_AIE		0x00018000	/* Abnormal Summary */
+#define DMA_INTR_ENA_FBE		0x00002000	/* Fatal Bus Error */
+#define DMA_INTR_ENA_ETE		0x00000400	/* Early Transmit */
+#define DMA_INTR_ENA_RWE		0x00000200	/* Receive Watchdog */
+#define DMA_INTR_ENA_RSE		0x00000100	/* Receive Stopped */
+#define DMA_INTR_ENA_RUE		0x00000080	/* Receive Buffer Unavailable */
+#define DMA_INTR_ENA_UNE		0x00000020	/* Tx Underflow */
+#define DMA_INTR_ENA_OVE		0x00000010	/* Receive Overflow */
+#define DMA_INTR_ENA_TJE		0x00000008	/* Transmit Jabber */
+#define DMA_INTR_ENA_TSE		0x00000002	/* Transmit Stopped */
+
+#define DMA_INTR_ABNORMAL		(DMA_INTR_ENA_AIE | DMA_INTR_ENA_FBE | \
+					 DMA_INTR_ENA_UNE)
+
+/* DMA default interrupt mask */
+#define DMA_INTR_DEFAULT_MASK		(DMA_INTR_NORMAL | DMA_INTR_ABNORMAL)
+#define DMA_INTR_DEFAULT_RX		(DMA_INTR_ENA_RIE)
+#define DMA_INTR_DEFAULT_TX		(DMA_INTR_ENA_TIE)
+
+/* DMA Status register defines */
+#define DMA_STATUS_GLPII		0x10000000	/* GMAC LPI interrupt */
+#define DMA_STATUS_EB_MASK		0x0e000000	/* Error Bits Mask */
+#define DMA_STATUS_EB_TX_ABORT		0x00080000	/* Error Bits - TX Abort */
+#define DMA_STATUS_EB_RX_ABORT		0x00100000	/* Error Bits - RX Abort */
+#define DMA_STATUS_TS_MASK		0x01c00000	/* Transmit Process State */
+#define DMA_STATUS_TS_SHIFT		22
+#define DMA_STATUS_RS_MASK		0x00380000	/* Receive Process State */
+#define DMA_STATUS_RS_SHIFT		19
+#define DMA_STATUS_TX_NIS		0x00040000	/* Normal Tx Interrupt Summary */
+#define DMA_STATUS_RX_NIS		0x00020000	/* Normal Rx Interrupt Summary */
+#define DMA_STATUS_TX_AIS		0x00010000	/* Abnormal Tx Interrupt Summary */
+#define DMA_STATUS_RX_AIS		0x00008000	/* Abnormal Rx Interrupt Summary */
+#define DMA_STATUS_ERI			0x00004000	/* Early Receive Interrupt */
+#define DMA_STATUS_TX_FBI		0x00002000	/* Fatal Tx Bus Error Interrupt */
+#define DMA_STATUS_RX_FBI		0x00001000	/* Fatal Rx Bus Error Interrupt */
+#define DMA_STATUS_ETI			0x00000400	/* Early Transmit Interrupt */
+#define DMA_STATUS_RWT			0x00000200	/* Receive Watchdog Timeout */
+#define DMA_STATUS_RPS			0x00000100	/* Receive Process Stopped */
+#define DMA_STATUS_RU			0x00000080	/* Receive Buffer Unavailable */
+#define DMA_STATUS_RI			0x00000040	/* Receive Interrupt */
+#define DMA_STATUS_UNF			0x00000020	/* Transmit Underflow */
+#define DMA_STATUS_OVF			0x00000010	/* Receive Overflow */
+#define DMA_STATUS_TJT			0x00000008	/* Transmit Jabber Timeout */
+#define DMA_STATUS_TU			0x00000004	/* Transmit Buffer Unavailable */
+#define DMA_STATUS_TPS			0x00000002	/* Transmit Process Stopped */
+#define DMA_STATUS_TI			0x00000001	/* Transmit Interrupt */
+#define DMA_CONTROL_FTF			0x00100000	/* Flush transmit FIFO */
+
+#define DMA_STATUS_MSK_RX_COMMON	(DMA_STATUS_RX_NIS | \
+					 DMA_STATUS_RX_AIS | \
+					 DMA_STATUS_RX_FBI)
+
+#define DMA_STATUS_MSK_TX_COMMON	(DMA_STATUS_TX_NIS | \
+					 DMA_STATUS_TX_AIS | \
+					 DMA_STATUS_TX_FBI)
+
+#define DMA_STATUS_MSK_RX		(DMA_STATUS_ERI | \
+					 DMA_STATUS_RWT | \
+					 DMA_STATUS_RPS | \
+					 DMA_STATUS_RU | \
+					 DMA_STATUS_RI | \
+					 DMA_STATUS_OVF | \
+					 DMA_STATUS_MSK_RX_COMMON)
+
+#define DMA_STATUS_MSK_TX		(DMA_STATUS_ETI | \
+					 DMA_STATUS_UNF | \
+					 DMA_STATUS_TJT | \
+					 DMA_STATUS_TU | \
+					 DMA_STATUS_TPS | \
+					 DMA_STATUS_TI | \
+					 DMA_STATUS_MSK_TX_COMMON)
+
+/* Following DMA defines are chanels oriented */
+#define DMA_CHAN_OFFSET			0x100
+
+static inline u32 dma_chan_base_addr(u32 base, u32 chan)
+{
+	return base + chan * DMA_CHAN_OFFSET;
+}
+
+#define DMA_CHAN_NEWFUNC_CONFIG(chan)	dma_chan_base_addr(DMA_NEWFUNC_CONFIG, chan)
+#define DMA_CHAN_XMT_POLL_DEMAND(chan)	dma_chan_base_addr(DMA_XMT_POLL_DEMAND, chan)
+#define DMA_CHAN_INTR_ENA(chan)		dma_chan_base_addr(DMA_INTR_ENA, chan)
+#define DMA_CHAN_CONTROL(chan)		dma_chan_base_addr(DMA_CONTROL, chan)
+#define DMA_CHAN_STATUS(chan)		dma_chan_base_addr(DMA_STATUS, chan)
+#define DMA_CHAN_BUS_MODE(chan)		dma_chan_base_addr(DMA_BUS_MODE, chan)
+#define DMA_CHAN_RCV_BASE_ADDR(chan)	dma_chan_base_addr(DMA_RCV_BASE_ADDR, chan)
+#define DMA_CHAN_RCV_BASE_ADDR64(chan)	dma_chan_base_addr(DMA_RCV_BASE_ADDR64, chan)
+#define DMA_CHAN_RCV_BASE_ADDR64_HI(chan)	dma_chan_base_addr(DMA_RCV_BASE_ADDR64_HI, chan)
+#define DMA_CHAN_TX_BASE_ADDR(chan)	dma_chan_base_addr(DMA_TX_BASE_ADDR, chan)
+#define DMA_CHAN_TX_BASE_ADDR64(chan)	dma_chan_base_addr(DMA_TX_BASE_ADDR64, chan)
+#define DMA_CHAN_TX_BASE_ADDR64_HI(chan)	dma_chan_base_addr(DMA_TX_BASE_ADDR64_HI, chan)
+#define DMA_CHAN_RX_WATCHDOG(chan)	dma_chan_base_addr(DMA_RX_WATCHDOG, chan)
+
+#define NUM_DWEGMAC_DMA_REGS	23
+
+#endif /* __DWEGMAC_DMA_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index c5768bbec38e..4674af3d78cb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -61,7 +61,7 @@ static int stmmac_dwmac1_quirks(struct stmmac_priv *priv)
 		dev_info(priv->device, "Enhanced/Alternate descriptors\n");
 
 		/* GMAC older than 3.50 has no extended descriptors */
-		if (priv->synopsys_id >= DWMAC_CORE_3_50) {
+		if (priv->synopsys_id >= DWMAC_CORE_3_50 || priv->plat->has_egmac) {
 			dev_info(priv->device, "Enabled extended descriptors\n");
 			priv->extend_desc = 1;
 		} else {
@@ -107,6 +107,7 @@ static const struct stmmac_hwif_entry {
 	bool gmac;
 	bool gmac4;
 	bool xgmac;
+	bool egmac;
 	u32 min_id;
 	u32 dev_id;
 	const struct stmmac_regs_off regs;
@@ -125,6 +126,7 @@ static const struct stmmac_hwif_entry {
 		.gmac = false,
 		.gmac4 = false,
 		.xgmac = false,
+		.egmac = false,
 		.min_id = 0,
 		.regs = {
 			.ptp_off = PTP_GMAC3_X_OFFSET,
@@ -143,6 +145,7 @@ static const struct stmmac_hwif_entry {
 		.gmac = true,
 		.gmac4 = false,
 		.xgmac = false,
+		.egmac = false,
 		.min_id = 0,
 		.regs = {
 			.ptp_off = PTP_GMAC3_X_OFFSET,
@@ -161,6 +164,7 @@ static const struct stmmac_hwif_entry {
 		.gmac = false,
 		.gmac4 = true,
 		.xgmac = false,
+		.egmac = false,
 		.min_id = 0,
 		.regs = {
 			.ptp_off = PTP_GMAC4_OFFSET,
@@ -179,6 +183,7 @@ static const struct stmmac_hwif_entry {
 		.gmac = false,
 		.gmac4 = true,
 		.xgmac = false,
+		.egmac = false,
 		.min_id = DWMAC_CORE_4_00,
 		.regs = {
 			.ptp_off = PTP_GMAC4_OFFSET,
@@ -197,6 +202,7 @@ static const struct stmmac_hwif_entry {
 		.gmac = false,
 		.gmac4 = true,
 		.xgmac = false,
+		.egmac = false,
 		.min_id = DWMAC_CORE_4_10,
 		.regs = {
 			.ptp_off = PTP_GMAC4_OFFSET,
@@ -215,6 +221,7 @@ static const struct stmmac_hwif_entry {
 		.gmac = false,
 		.gmac4 = true,
 		.xgmac = false,
+		.egmac = false,
 		.min_id = DWMAC_CORE_5_10,
 		.regs = {
 			.ptp_off = PTP_GMAC4_OFFSET,
@@ -233,6 +240,7 @@ static const struct stmmac_hwif_entry {
 		.gmac = false,
 		.gmac4 = false,
 		.xgmac = true,
+		.egmac = false,
 		.min_id = DWXGMAC_CORE_2_10,
 		.dev_id = DWXGMAC_ID,
 		.regs = {
@@ -252,6 +260,7 @@ static const struct stmmac_hwif_entry {
 		.gmac = false,
 		.gmac4 = false,
 		.xgmac = true,
+		.egmac = false,
 		.min_id = DWXLGMAC_CORE_2_00,
 		.dev_id = DWXLGMAC_ID,
 		.regs = {
@@ -267,11 +276,50 @@ static const struct stmmac_hwif_entry {
 		.mmc = &dwxgmac_mmc_ops,
 		.setup = dwxlgmac2_setup,
 		.quirks = stmmac_dwxlgmac_quirks,
+	}, {
+		.gmac = false,
+		.gmac4 = false,
+		.xgmac = false,
+		.egmac = true,
+		.min_id = DWEGMAC_CORE_1_00,
+		.regs = {
+			.ptp_off = PTP_GMAC3_X_OFFSET,
+			.mmc_off = MMC_GMAC3_X_OFFSET,
+		},
+		.desc = NULL,
+		.dma = &dwegmac_dma_ops,
+		.mac = &dwegmac_ops,
+		.hwtimestamp = &stmmac_ptp,
+		.mode = NULL,
+		.tc = NULL,
+		.mmc = &dwmac_mmc_ops,
+		.setup = dwegmac_setup,
+		.quirks = stmmac_dwmac1_quirks,
+	}, {
+		.gmac = false,
+		.gmac4 = false,
+		.xgmac = false,
+		.egmac = true,
+		.min_id = DWMAC_CORE_3_50,
+		.regs = {
+			.ptp_off = PTP_GMAC3_X_OFFSET,
+			.mmc_off = MMC_GMAC3_X_OFFSET,
+		},
+		.desc = NULL,
+		.dma = &dwmac1000_dma_ops,
+		.mac = &dwmac1000_ops,
+		.hwtimestamp = &stmmac_ptp,
+		.mode = NULL,
+		.tc = NULL,
+		.mmc = &dwmac_mmc_ops,
+		.setup = dwmac1000_setup,
+		.quirks = stmmac_dwmac1_quirks,
 	},
 };
 
 int stmmac_hwif_init(struct stmmac_priv *priv)
 {
+	bool needs_egmac = priv->plat->has_egmac;
 	bool needs_xgmac = priv->plat->has_xgmac;
 	bool needs_gmac4 = priv->plat->has_gmac4;
 	bool needs_gmac = priv->plat->has_gmac;
@@ -281,7 +329,7 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 	u32 id, dev_id = 0;
 	int i, ret;
 
-	if (needs_gmac) {
+	if (needs_gmac || needs_egmac) {
 		id = stmmac_get_id(priv, GMAC_VERSION);
 	} else if (needs_gmac4 || needs_xgmac) {
 		id = stmmac_get_id(priv, GMAC4_VERSION);
@@ -321,6 +369,8 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 			continue;
 		if (needs_xgmac ^ entry->xgmac)
 			continue;
+		if (needs_egmac ^ entry->egmac)
+			continue;
 		/* Use synopsys_id var because some setups can override this */
 		if (priv->synopsys_id < entry->min_id)
 			continue;
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 00be9a7003c8..41989903e8c9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -667,6 +667,8 @@ extern const struct stmmac_dma_ops dwxgmac210_dma_ops;
 extern const struct stmmac_desc_ops dwxgmac210_desc_ops;
 extern const struct stmmac_mmc_ops dwmac_mmc_ops;
 extern const struct stmmac_mmc_ops dwxgmac_mmc_ops;
+extern const struct stmmac_ops dwegmac_ops;
+extern const struct stmmac_dma_ops dwegmac_dma_ops;
 
 #define GMAC_VERSION		0x00000020	/* GMAC CORE Version */
 #define GMAC4_VERSION		0x00000110	/* GMAC4+ CORE Version */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 2ae73ab842d4..dba33ce392a8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -596,7 +596,7 @@ static void stmmac_get_ethtool_stats(struct net_device *dev,
 				priv->xstats.phy_eee_wakeup_error_n = val;
 		}
 
-		if (priv->synopsys_id >= DWMAC_CORE_3_50)
+		if (priv->synopsys_id >= DWMAC_CORE_3_50 || priv->plat->has_egmac)
 			stmmac_mac_debug(priv, priv->ioaddr,
 					(void *)&priv->xstats,
 					rx_queues_count, tx_queues_count);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e8619853b6d6..f91dd3f69fef 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6936,7 +6936,8 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 	 * riwt_off field from the platform.
 	 */
 	if (((priv->synopsys_id >= DWMAC_CORE_3_50) ||
-	    (priv->plat->has_xgmac)) && (!priv->plat->riwt_off)) {
+	    (priv->plat->has_xgmac) || (priv->plat->has_egmac)) &&
+	    (!priv->plat->riwt_off)) {
 		priv->use_riwt = 1;
 		dev_info(priv->device,
 			 "Enable RX Mitigation via HW Watchdog Timer\n");
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 2fcd83f6db14..0e36259a9568 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -295,5 +295,6 @@ struct plat_stmmacenet_data {
 	bool serdes_up_after_phy_linkup;
 	const struct dwmac4_addrs *dwmac4_addrs;
 	bool has_integrated_pcs;
+	int has_egmac;
 };
 #endif
-- 
2.39.3


