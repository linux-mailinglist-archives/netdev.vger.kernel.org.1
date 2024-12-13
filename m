Return-Path: <netdev+bounces-151735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A00AF9F0BFF
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D05C283243
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E846B1DF991;
	Fri, 13 Dec 2024 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MNi8Ztqn"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4001DF735;
	Fri, 13 Dec 2024 12:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734092078; cv=none; b=UA5kMRvyH+TmsMtOq2U40e41GU65XqDiQJb3BapEV+DXOf78M/OKlELVHXXBKXzJ8dGkiIyB7GNO94Dw8RKyG3wdkHlIfQmK1LdoySr5OPQvJUCs28iz28zOlkemHaTqgaT3riKqqglbLmLdp/5U+ZLTDk3M67Qt1RHtp/Cs1VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734092078; c=relaxed/simple;
	bh=jOoctiZfKTqvCWcNeuKDlgMzMYajFnzH+9/vefBjlrM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kzs8SkUGRMQDjv5rpT9/Ww/OPmmt3SLE7PvhF33r26ZBN0joMtPiV2f1Kwr3davXdZMsZw6xgGFiPFlX4hN/ol0Ki+eehMOB5FUyFJBOHkhaJMxHOe5tnbOqufj8T3BtFgSBbz6TCJAIneAILH9OW0GcH3tJtjq59n3ddktnG0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MNi8Ztqn; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734092076; x=1765628076;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=jOoctiZfKTqvCWcNeuKDlgMzMYajFnzH+9/vefBjlrM=;
  b=MNi8ZtqnZXYfyjYXYHCirT/6mrQn/i7d8CWHl2kgNaRGC5VpAitRbukG
   b4zW+mccEt5rigDxWMNIvjBGAXj4qWPlPHAkJYULBFbdV6zhWAYq9Y9p9
   H74+dcvT6PJXDnje5Bg3l76cQzjRw6ee3PtaVFGAihaqDdP4+Tc93B5CH
   kn6lMC3ixqpnHdF8zTLBtokBr0dBOhcMF6JV7dXNkcNtCf9lzR80HsbBl
   zrhPKBSOXb0aDfVGxz5oUn+lGgU2Kxvd4Fx3FgAd+gfxzQF2/jJ/9QKES
   gRAfMpwMa9zPjAFeoM4yEsQub9Xr/Jlrt75gvoxG4/JEi8pJh0uG5z+fL
   A==;
X-CSE-ConnectionGUID: R6LocSygTBu1rZt5XxoMKA==
X-CSE-MsgGUID: bOHkutWTRsiGOdjJ+FzzOw==
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="35182256"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2024 05:14:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 13 Dec 2024 05:14:16 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 13 Dec 2024 05:14:11 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v7 1/5] net: phy: microchip_rds_ptp: Add header file for Microchip rds ptp library
Date: Fri, 13 Dec 2024 17:43:59 +0530
Message-ID: <20241213121403.29687-2-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241213121403.29687-1-divya.koppera@microchip.com>
References: <20241213121403.29687-1-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

This rds ptp header file will cover ptp macros for future phys in
Microchip where addresses will be same but base offset and mmd address
may changes.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
---
v6 -> v7
- No changes

v5 -> v6
- Renamed header file name, macros and function names to
  reflect ptp hardware code name.

v4 -> v5
- Reduced scope of config PTP Macro check to APIs

v3 -> v4
- Re-ordered mchp_ptp_clock structure.

v2 -> v3
- No changes

v1 -> v2
- Fixed sparse warnings and compilation errors/warnings reported by kernel
  test robot
---
 drivers/net/phy/microchip_rds_ptp.h | 219 ++++++++++++++++++++++++++++
 1 file changed, 219 insertions(+)
 create mode 100644 drivers/net/phy/microchip_rds_ptp.h

diff --git a/drivers/net/phy/microchip_rds_ptp.h b/drivers/net/phy/microchip_rds_ptp.h
new file mode 100644
index 000000000000..ffcf1e56184f
--- /dev/null
+++ b/drivers/net/phy/microchip_rds_ptp.h
@@ -0,0 +1,219 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Copyright (C) 2024 Microchip Technology
+ */
+
+#ifndef _MICROCHIP_RDS_PTP_H
+#define _MICROCHIP_RDS_PTP_H
+
+#include <linux/ptp_clock_kernel.h>
+#include <linux/ptp_clock.h>
+#include <linux/ptp_classify.h>
+#include <linux/net_tstamp.h>
+#include <linux/mii.h>
+#include <linux/phy.h>
+
+#define MCHP_RDS_PTP_CMD_CTL(b)			((b) + 0x0)
+#define MCHP_RDS_PTP_CMD_CTL_LTC_STEP_NSEC	BIT(6)
+#define MCHP_RDS_PTP_CMD_CTL_LTC_STEP_SEC	BIT(5)
+#define MCHP_RDS_PTP_CMD_CTL_CLOCK_LOAD		BIT(4)
+#define MCHP_RDS_PTP_CMD_CTL_CLOCK_READ		BIT(3)
+#define MCHP_RDS_PTP_CMD_CTL_EN			BIT(1)
+#define MCHP_RDS_PTP_CMD_CTL_DIS		BIT(0)
+
+#define MCHP_RDS_PTP_REF_CLK_CFG(b)		((b) + 0x2)
+#define MCHP_RDS_PTP_REF_CLK_SRC_250MHZ		0x0
+#define MCHP_RDS_PTP_REF_CLK_PERIOD_OVERRIDE	BIT(9)
+#define MCHP_RDS_PTP_REF_CLK_PERIOD		4
+#define MCHP_RDS_PTP_REF_CLK_CFG_SET	(MCHP_RDS_PTP_REF_CLK_SRC_250MHZ |\
+					 MCHP_RDS_PTP_REF_CLK_PERIOD_OVERRIDE |\
+					 MCHP_RDS_PTP_REF_CLK_PERIOD)
+
+#define MCHP_RDS_PTP_LTC_SEC_HI(b)		((b) + 0x5)
+#define MCHP_RDS_PTP_LTC_SEC_MID(b)		((b) + 0x6)
+#define MCHP_RDS_PTP_LTC_SEC_LO(b)		((b) + 0x7)
+#define MCHP_RDS_PTP_LTC_NS_HI(b)		((b) + 0x8)
+#define MCHP_RDS_PTP_LTC_NS_LO(b)		((b) + 0x9)
+#define MCHP_RDS_PTP_LTC_RATE_ADJ_HI(b)		((b) + 0xc)
+#define MCHP_RDS_PTP_LTC_RATE_ADJ_HI_DIR	BIT(15)
+#define MCHP_RDS_PTP_LTC_RATE_ADJ_LO(b)		((b) + 0xd)
+#define MCHP_RDS_PTP_STEP_ADJ_HI(b)		((b) + 0x12)
+#define MCHP_RDS_PTP_STEP_ADJ_HI_DIR		BIT(15)
+#define MCHP_RDS_PTP_STEP_ADJ_LO(b)		((b) + 0x13)
+#define MCHP_RDS_PTP_LTC_READ_SEC_HI(b)		((b) + 0x29)
+#define MCHP_RDS_PTP_LTC_READ_SEC_MID(b)	((b) + 0x2a)
+#define MCHP_RDS_PTP_LTC_READ_SEC_LO(b)		((b) + 0x2b)
+#define MCHP_RDS_PTP_LTC_READ_NS_HI(b)		((b) + 0x2c)
+#define MCHP_RDS_PTP_LTC_READ_NS_LO(b)		((b) + 0x2d)
+#define MCHP_RDS_PTP_OP_MODE(b)			((b) + 0x41)
+#define MCHP_RDS_PTP_OP_MODE_DIS		0
+#define MCHP_RDS_PTP_OP_MODE_STANDALONE		1
+#define MCHP_RDS_PTP_LATENCY_CORRECTION_CTL(b)	((b) + 0x44)
+#define MCHP_RDS_PTP_PREDICTOR_EN		BIT(6)
+#define MCHP_RDS_PTP_TX_PRED_DIS		BIT(1)
+#define MCHP_RDS_PTP_RX_PRED_DIS		BIT(0)
+#define MCHP_RDS_PTP_LATENCY_SETTING		(MCHP_RDS_PTP_PREDICTOR_EN | \
+						 MCHP_RDS_PTP_TX_PRED_DIS | \
+						 MCHP_RDS_PTP_RX_PRED_DIS)
+
+#define MCHP_RDS_PTP_INT_EN(b)			((b) + 0x0)
+#define MCHP_RDS_PTP_INT_STS(b)			((b) + 0x01)
+#define MCHP_RDS_PTP_INT_TX_TS_OVRFL_EN		BIT(3)
+#define MCHP_RDS_PTP_INT_TX_TS_EN		BIT(2)
+#define MCHP_RDS_PTP_INT_RX_TS_OVRFL_EN		BIT(1)
+#define MCHP_RDS_PTP_INT_RX_TS_EN		BIT(0)
+#define MCHP_RDS_PTP_INT_ALL_MSK	(MCHP_RDS_PTP_INT_TX_TS_OVRFL_EN | \
+					 MCHP_RDS_PTP_INT_TX_TS_EN | \
+					 MCHP_RDS_PTP_INT_RX_TS_OVRFL_EN |\
+					 MCHP_RDS_PTP_INT_RX_TS_EN)
+
+#define MCHP_RDS_PTP_CAP_INFO(b)		((b) + 0x2e)
+#define MCHP_RDS_PTP_TX_TS_CNT(v)		(((v) & GENMASK(11, 8)) >> 8)
+#define MCHP_RDS_PTP_RX_TS_CNT(v)		((v) & GENMASK(3, 0))
+
+#define MCHP_RDS_PTP_RX_PARSE_CONFIG(b)		((b) + 0x42)
+#define MCHP_RDS_PTP_RX_PARSE_L2_ADDR_EN(b)	((b) + 0x44)
+#define MCHP_RDS_PTP_RX_PARSE_IPV4_ADDR_EN(b)	((b) + 0x45)
+
+#define MCHP_RDS_PTP_RX_TIMESTAMP_CONFIG(b)	((b) + 0x4e)
+#define MCHP_RDS_PTP_RX_TIMESTAMP_CONFIG_PTP_FCS_DIS BIT(0)
+
+#define MCHP_RDS_PTP_RX_VERSION(b)		((b) + 0x48)
+#define MCHP_RDS_PTP_RX_TIMESTAMP_EN(b)		((b) + 0x4d)
+
+#define MCHP_RDS_PTP_RX_INGRESS_NS_HI(b)	((b) + 0x54)
+#define MCHP_RDS_PTP_RX_INGRESS_NS_HI_TS_VALID	BIT(15)
+
+#define MCHP_RDS_PTP_RX_INGRESS_NS_LO(b)	((b) + 0x55)
+#define MCHP_RDS_PTP_RX_INGRESS_SEC_HI(b)	((b) + 0x56)
+#define MCHP_RDS_PTP_RX_INGRESS_SEC_LO(b)	((b) + 0x57)
+#define MCHP_RDS_PTP_RX_MSG_HDR2(b)		((b) + 0x59)
+
+#define MCHP_RDS_PTP_TX_PARSE_CONFIG(b)		((b) + 0x82)
+#define MCHP_RDS_PTP_PARSE_CONFIG_LAYER2_EN	BIT(0)
+#define MCHP_RDS_PTP_PARSE_CONFIG_IPV4_EN	BIT(1)
+#define MCHP_RDS_PTP_PARSE_CONFIG_IPV6_EN	BIT(2)
+
+#define MCHP_RDS_PTP_TX_PARSE_L2_ADDR_EN(b)	((b) + 0x84)
+#define MCHP_RDS_PTP_TX_PARSE_IPV4_ADDR_EN(b)	((b) + 0x85)
+
+#define MCHP_RDS_PTP_TX_VERSION(b)		((b) + 0x88)
+#define MCHP_RDS_PTP_MAX_VERSION(x)		(((x) & GENMASK(7, 0)) << 8)
+#define MCHP_RDS_PTP_MIN_VERSION(x)		((x) & GENMASK(7, 0))
+
+#define MCHP_RDS_PTP_TX_TIMESTAMP_EN(b)		((b) + 0x8d)
+#define MCHP_RDS_PTP_TIMESTAMP_EN_SYNC		BIT(0)
+#define MCHP_RDS_PTP_TIMESTAMP_EN_DREQ		BIT(1)
+#define MCHP_RDS_PTP_TIMESTAMP_EN_PDREQ		BIT(2)
+#define MCHP_RDS_PTP_TIMESTAMP_EN_PDRES		BIT(3)
+#define MCHP_RDS_PTP_TIMESTAMP_EN_ALL	(MCHP_RDS_PTP_TIMESTAMP_EN_SYNC |\
+					 MCHP_RDS_PTP_TIMESTAMP_EN_DREQ |\
+					 MCHP_RDS_PTP_TIMESTAMP_EN_PDREQ |\
+					 MCHP_RDS_PTP_TIMESTAMP_EN_PDRES)
+
+#define MCHP_RDS_PTP_TX_TIMESTAMP_CONFIG(b)	((b) + 0x8e)
+#define MCHP_RDS_PTP_TX_TIMESTAMP_CONFIG_PTP_FCS_DIS BIT(0)
+
+#define MCHP_RDS_PTP_TX_MOD(b)			((b) + 0x8f)
+#define MCHP_RDS_PTP_TX_MOD_PTP_SYNC_TS_INSERT	BIT(12)
+#define MCHP_RDS_PTP_TX_MOD_PTP_FU_TS_INSERT	BIT(11)
+
+#define MCHP_RDS_PTP_TX_EGRESS_NS_HI(b)		((b) + 0x94)
+#define MCHP_RDS_PTP_TX_EGRESS_NS_HI_TS_VALID	BIT(15)
+
+#define MCHP_RDS_PTP_TX_EGRESS_NS_LO(b)		((b) + 0x95)
+#define MCHP_RDS_PTP_TX_EGRESS_SEC_HI(b)	((b) + 0x96)
+#define MCHP_RDS_PTP_TX_EGRESS_SEC_LO(b)	((b) + 0x97)
+#define MCHP_RDS_PTP_TX_MSG_HDR2(b)		((b) + 0x99)
+
+#define MCHP_RDS_PTP_TSU_GEN_CONFIG(b)		((b) + 0xc0)
+#define MCHP_RDS_PTP_TSU_GEN_CFG_TSU_EN		BIT(0)
+
+#define MCHP_RDS_PTP_TSU_HARD_RESET(b)		((b) + 0xc1)
+#define MCHP_RDS_PTP_TSU_HARDRESET		BIT(0)
+
+/* Represents 1ppm adjustment in 2^32 format with
+ * each nsec contains 4 clock cycles in 250MHz.
+ * The value is calculated as following: (1/1000000)/((2^-32)/4)
+ */
+#define MCHP_RDS_PTP_1PPM_FORMAT		17179
+#define MCHP_RDS_PTP_FIFO_SIZE			8
+#define MCHP_RDS_PTP_MAX_ADJ			31249999
+
+#define BASE_CLK(p)		((p)->clk_base_addr)
+#define BASE_PORT(p)		((p)->port_base_addr)
+#define PTP_MMD(p)		((p)->mmd)
+
+enum mchp_rds_ptp_fifo_dir {
+	MCHP_RDS_PTP_INGRESS_FIFO,
+	MCHP_RDS_PTP_EGRESS_FIFO
+};
+
+struct mchp_rds_ptp_clock {
+	struct mii_timestamper mii_ts;
+	struct phy_device *phydev;
+	struct ptp_clock *ptp_clock;
+
+	struct sk_buff_head tx_queue;
+	struct sk_buff_head rx_queue;
+	struct list_head rx_ts_list;
+
+	struct ptp_clock_info caps;
+
+	/* Lock for Rx ts fifo */
+	spinlock_t rx_ts_lock;
+	int hwts_tx_type;
+
+	enum hwtstamp_rx_filters rx_filter;
+	int layer;
+	int version;
+	u16 port_base_addr;
+	u16 clk_base_addr;
+
+	/* Lock for phc */
+	struct mutex ptp_lock;
+	u8 mmd;
+};
+
+struct mchp_rds_ptp_rx_ts {
+	struct list_head list;
+	u32 seconds;
+	u32 nsec;
+	u16 seq_id;
+};
+
+#if IS_ENABLED(CONFIG_MICROCHIP_PHY_RDS_PTP)
+
+struct mchp_rds_ptp_clock *mchp_rds_ptp_probe(struct phy_device *phydev, u8 mmd,
+					      u16 clk_base, u16 port_base);
+
+int mchp_rds_ptp_top_config_intr(struct mchp_rds_ptp_clock *clock,
+				 u16 reg, u16 val, bool enable);
+
+irqreturn_t mchp_rds_ptp_handle_interrupt(struct mchp_rds_ptp_clock *clock);
+
+#else
+
+static inline struct mchp_rds_ptp_clock *mchp_rds_ptp_probe(struct phy_device
+							    *phydev, u8 mmd,
+							    u16 clk_base,
+							    u16 port_base)
+{
+	return NULL;
+}
+
+static inline int mchp_rds_ptp_top_config_intr(struct mchp_rds_ptp_clock *clock,
+					       u16 reg, u16 val, bool enable)
+{
+	return 0;
+}
+
+static inline irqreturn_t mchp_rds_ptp_handle_interrupt(struct
+							mchp_rds_ptp_clock
+							* clock)
+{
+	return IRQ_NONE;
+}
+
+#endif //CONFIG_MICROCHIP_PHY_RDS_PTP
+
+#endif //_MICROCHIP_RDS_PTP_H
-- 
2.17.1


