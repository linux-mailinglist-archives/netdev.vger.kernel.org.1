Return-Path: <netdev+bounces-267628-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOwSFsqQtGn7qAAAu9opvQ
	(envelope-from <netdev+bounces-267628-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:33:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B517428A741
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C7E03157969
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDF138550F;
	Fri, 13 Mar 2026 22:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OUTl/mQ7"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (lpdvsmtp09.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A045376463;
	Fri, 13 Mar 2026 22:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773441194; cv=none; b=iIVUUKMV0i0ff4nDQhhsEI0UK45Y6pKi8rE6q/TKmAhMUn0pO1VegfsAeOXlmBW34Xl9C01yV5jGUHJroIgvLBYLgRjqe4gjVx7NuwnEQqo9nI3QIGQ7TSZlAsjRwsJqJFcrPcRYswox0WJr8jrfkMqCVYMqxydDepMoeHXMh10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773441194; c=relaxed/simple;
	bh=Wtaaj1f3ECS55N5jjE+tNqpgRkM2wx8aPa/eGJrh2u4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnu56VwW/Yay733mVByY3J//Z0cp2ne6BL9h3Jv6QccwMeeeRc5DlmW8xwCewo91UvyRgxXsAxu2svfNeGf0/4r5wHBEu7G/tj2fSD+4tiKfwlUL6IvFJVAjNHQxcjjM0n5t0uRkwqjXY4iQJNeX/BuP7f68zDdYyy1VQH6rKYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OUTl/mQ7; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id E03F8C008EEA;
	Fri, 13 Mar 2026 15:22:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com E03F8C008EEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1773440545;
	bh=Wtaaj1f3ECS55N5jjE+tNqpgRkM2wx8aPa/eGJrh2u4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OUTl/mQ7KSKB3EixnHI4xce0WqyaglZOB8GKmFY/TFb+8LpCrdvyOTN3WM8ErFJkc
	 BNLFw7AZotUVGHv3IkhBkWPvexVcV46u85Qu2TxGWM4APuLLikGYyT/BL1AZuPtYun
	 aDi54hM1YPF8c1zwEBKYF63OFlfpLdSDY6u+YUoc=
Received: from lvnvdb8054.lvn.broadcom.net (lvnvdb8054.lvn.broadcom.net [10.17.214.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id D8860B90;
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
Subject: [PATCH net-next v7 2/5] net: stmmac: Add DW25GMAC support in stmmac core driver
Date: Fri, 13 Mar 2026 15:22:03 -0700
Message-ID: <20260313222206.778760-3-jitendra.vegiraju@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=dkimrelay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267628-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[39];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B517428A741
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>

The DW25GMAC adds new DMA architecture called Hyper-DMA (HDMA) for
virtualization scalability.
This is realized by decoupling physical DMA channels (PDMA) from a
potentially large number of virtual DMA channels (VDMA). The VDMAs provide
software abstraction to facilitate more dma channels in driver that map to
available PDMAs for frame transmission and reception.
Since the 25GMAC is a derivative of XGMAC, majority of IP is common to
both MAC IPs.

To add support for the HDMA in 25GMAC, a new instance of dma_ops,
dw25gmac400_dma_ops is introduced.
To support the current needs, a simple one-to-one mapping of dw25gmac's
logical VDMA (channel) to TC to PDMAs is used. Most of the other dma
operation functions in existing dwxgamc2_dma.c file are reused whereever
applicable.
Added setup function for DW25GMAC's stmmac_hwif_entry in stmmac core.

Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
---
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h  |  12 +-
 .../net/ethernet/stmicro/stmmac/dw25gmac.c    | 161 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/dw25gmac.h    |  92 ++++++++++
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |   1 +
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  39 +++++
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  51 ++++++
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |   1 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  35 ++++
 9 files changed, 392 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dw25gmac.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dw25gmac.h

diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index c9263987ef8d..99734014976a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -6,7 +6,7 @@ stmmac-objs:= stmmac_main.o stmmac_ethtool.o stmmac_mdio.o ring_mode.o	\
 	      mmc_core.o stmmac_hwtstamp.o stmmac_ptp.o dwmac4_descs.o	\
 	      dwmac4_dma.o dwmac4_lib.o dwmac4_core.o dwmac5.o hwif.o \
 	      stmmac_tc.o dwxgmac2_core.o dwxgmac2_dma.o dwxgmac2_descs.o \
-	      stmmac_xdp.o stmmac_est.o stmmac_fpe.o stmmac_vlan.o \
+	      stmmac_xdp.o stmmac_est.o stmmac_fpe.o stmmac_vlan.o dw25gmac.o \
 	      stmmac_pcs.o $(stmmac-y)
 
 stmmac-$(CONFIG_STMMAC_SELFTESTS) += stmmac_selftests.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 46454e2886ce..75a862a92d9d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -42,13 +42,18 @@
 #define DWXGMAC_CORE_2_20	0x22
 #define DWXLGMAC_CORE_2_00	0x20
 
+#define DW25GMAC_CORE_3_20	0x32
+#define DW25GMAC_CORE_4_00	0x40
+
 /* Device ID */
 #define DWXGMAC_ID		0x76
+#define DW25GMAC_ID		0x55
 #define DWXLGMAC_ID		0x27
 
 static inline bool dwmac_is_xmac(enum dwmac_core_type core_type)
 {
-	return core_type == DWMAC_CORE_GMAC4 || core_type == DWMAC_CORE_XGMAC;
+	return core_type == DWMAC_CORE_GMAC4 || core_type == DWMAC_CORE_XGMAC ||
+	       core_type == DWMAC_CORE_25GMAC;
 }
 
 #define STMMAC_CHAN0	0	/* Always supported and default for all chips */
@@ -328,6 +333,9 @@ struct stmmac_safety_stats {
 #define PHY_INTF_GMII		0
 #define PHY_INTF_RGMII		1
 
+/* DW25GMAC uses different encoding - defaults to XGMII */
+#define PHY_INTF_DW25GMAC_XGMII	0
+
 /* MSI defines */
 #define STMMAC_MSI_VEC_MAX	32
 
@@ -596,6 +604,7 @@ struct mac_link {
 		u32 speed2500;
 		u32 speed5000;
 		u32 speed10000;
+		u32 speed25000;
 	} xgmii;
 	struct {
 		u32 speed25000;
@@ -655,6 +664,7 @@ int dwmac100_setup(struct stmmac_priv *priv);
 int dwmac1000_setup(struct stmmac_priv *priv);
 int dwmac4_setup(struct stmmac_priv *priv);
 int dwxgmac2_setup(struct stmmac_priv *priv);
+int dw25gmac_setup(struct stmmac_priv *priv);
 int dwxlgmac2_setup(struct stmmac_priv *priv);
 
 void stmmac_set_mac_addr(void __iomem *ioaddr, const u8 addr[6],
diff --git a/drivers/net/ethernet/stmicro/stmmac/dw25gmac.c b/drivers/net/ethernet/stmicro/stmmac/dw25gmac.c
new file mode 100644
index 000000000000..82eb22bff73e
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dw25gmac.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024-2026 Broadcom Corporation
+ */
+#include "stmmac.h"
+#include "dwxgmac2.h"
+#include "dw25gmac.h"
+
+u32 dw25gmac_decode_vdma_count(u32 regval)
+{
+	/* compressed encoding for vdma count */
+	if (regval < 16) /* Direct mapping */
+		return regval + 1;
+	else if (regval < 20) /* 20, 24, 28, 32 */
+		return 20 + (regval - 16) * 4;
+	else if (regval < 24) /* 40, 48, 56, 64 */
+		return 40 + (regval - 20) * 8;
+	else if (regval < 28) /* 80, 96, 112, 128 */
+		return 80 + (regval - 24) * 16;
+	else  /* not defined */
+		return 0;
+}
+
+static int rd_dma_ch_ind(void __iomem *ioaddr, u8 mode, u32 channel)
+{
+	u32 reg_val = 0;
+
+	reg_val |= FIELD_PREP(XXVGMAC_MODE_SELECT, mode);
+	reg_val |= FIELD_PREP(XXVGMAC_ADDR_OFFSET, channel);
+	reg_val |= XXVGMAC_CMD_TYPE | XXVGMAC_OB;
+	writel(reg_val, ioaddr + XXVGMAC_DMA_CH_IND_CONTROL);
+	return readl(ioaddr + XXVGMAC_DMA_CH_IND_DATA);
+}
+
+static void wr_dma_ch_ind(void __iomem *ioaddr, u8 mode, u32 channel, u32 val)
+{
+	u32 reg_val = 0;
+
+	writel(val, ioaddr + XXVGMAC_DMA_CH_IND_DATA);
+	reg_val |= FIELD_PREP(XXVGMAC_MODE_SELECT, mode);
+	reg_val |= FIELD_PREP(XXVGMAC_ADDR_OFFSET, channel);
+	reg_val |= XGMAC_OB;
+	writel(reg_val, ioaddr + XXVGMAC_DMA_CH_IND_CONTROL);
+}
+
+void dw25gmac_dma_init(void __iomem *ioaddr,
+		       struct stmmac_dma_cfg *dma_cfg)
+{
+	u32 tx_pdmas, rx_pdmas;
+	u32 hw_cap;
+	u32 value;
+	u32 i;
+
+	value = readl(ioaddr + XGMAC_DMA_SYSBUS_MODE);
+	value &= ~(XGMAC_AAL | XGMAC_EAME);
+	if (dma_cfg->aal)
+		value |= XGMAC_AAL;
+	if (dma_cfg->eame)
+		value |= XGMAC_EAME;
+	writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
+
+	/* Get PDMA counts from HW */
+	hw_cap = readl(ioaddr + XGMAC_HW_FEATURE2);
+	tx_pdmas = FIELD_GET(XGMAC_HWFEAT_TXQCNT, hw_cap) + 1;
+	rx_pdmas = FIELD_GET(XGMAC_HWFEAT_RXQCNT, hw_cap) + 1;
+
+	/* Initialize all PDMAs with burst length fields */
+	for (i = 0; i < tx_pdmas; i++) {
+		value = rd_dma_ch_ind(ioaddr, MODE_TXEXTCFG, i);
+		value &= ~(XXVGMAC_TXPBL | XXVGMAC_TPBLX8_MODE);
+		if (dma_cfg->pblx8)
+			value |= XXVGMAC_TPBLX8_MODE;
+		value |= FIELD_PREP(XXVGMAC_TXPBL, dma_cfg->pbl);
+		wr_dma_ch_ind(ioaddr, MODE_TXEXTCFG, i, value);
+	}
+
+	for (i = 0; i < rx_pdmas; i++) {
+		value = rd_dma_ch_ind(ioaddr, MODE_RXEXTCFG, i);
+		value &= ~(XXVGMAC_RXPBL | XXVGMAC_RPBLX8_MODE);
+		if (dma_cfg->pblx8)
+			value |= XXVGMAC_RPBLX8_MODE;
+		value |= FIELD_PREP(XXVGMAC_RXPBL, dma_cfg->pbl);
+		wr_dma_ch_ind(ioaddr, MODE_RXEXTCFG, i, value);
+	}
+}
+
+void dw25gmac_dma_init_tx_chan(struct stmmac_priv *priv,
+			       void __iomem *ioaddr,
+			       struct stmmac_dma_cfg *dma_cfg,
+			       dma_addr_t dma_addr, u32 chan)
+{
+	u32 value;
+	u32 tc;
+
+	/* Descriptor cache size and prefetch threshold size */
+	value = rd_dma_ch_ind(ioaddr, MODE_TXDESCCTRL, chan);
+	value &= ~XXVGMAC_TXDCSZ;
+	value |= FIELD_PREP(XXVGMAC_TXDCSZ,
+			    XXVGMAC_TXDCSZ_256BYTES);
+	value &= ~XXVGMAC_TDPS;
+	value |= FIELD_PREP(XXVGMAC_TDPS, XXVGMAC_TDPS_HALF);
+	wr_dma_ch_ind(ioaddr, MODE_TXDESCCTRL, chan, value);
+
+	/* Use one-to-one mapping between VDMA, TC, and PDMA. */
+	tc = chan;
+
+	/* 1-to-1 PDMA to TC mapping */
+	value = rd_dma_ch_ind(ioaddr, MODE_TXEXTCFG, chan);
+	value &= ~XXVGMAC_TP2TCMP;
+	value |= FIELD_PREP(XXVGMAC_TP2TCMP, tc);
+	wr_dma_ch_ind(ioaddr, MODE_TXEXTCFG, chan, value);
+
+	/* 1-to-1 VDMA to TC mapping */
+	value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
+	value &= ~XXVGMAC_TVDMA2TCMP;
+	value |= FIELD_PREP(XXVGMAC_TVDMA2TCMP, tc);
+	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
+
+	writel(upper_32_bits(dma_addr),
+	       ioaddr + XGMAC_DMA_CH_TxDESC_HADDR(chan));
+	writel(lower_32_bits(dma_addr),
+	       ioaddr + XGMAC_DMA_CH_TxDESC_LADDR(chan));
+}
+
+void dw25gmac_dma_init_rx_chan(struct stmmac_priv *priv,
+			       void __iomem *ioaddr,
+			       struct stmmac_dma_cfg *dma_cfg,
+			       dma_addr_t dma_addr, u32 chan)
+{
+	u32 value;
+	u32 tc;
+
+	/* Descriptor cache size and prefetch threshold size */
+	value = rd_dma_ch_ind(ioaddr, MODE_RXDESCCTRL, chan);
+	value &= ~XXVGMAC_RXDCSZ;
+	value |= FIELD_PREP(XXVGMAC_RXDCSZ,
+			    XXVGMAC_RXDCSZ_256BYTES);
+	value &= ~XXVGMAC_RDPS;
+	value |= FIELD_PREP(XXVGMAC_RDPS, XXVGMAC_RDPS_HALF);
+	wr_dma_ch_ind(ioaddr, MODE_RXDESCCTRL, chan, value);
+
+	/* Use one-to-one mapping between VDMA, TC, and PDMA. */
+	tc = chan;
+
+	/* 1-to-1 PDMA to TC mapping */
+	value = rd_dma_ch_ind(ioaddr, MODE_RXEXTCFG, chan);
+	value &= ~XXVGMAC_RP2TCMP;
+	value |= FIELD_PREP(XXVGMAC_RP2TCMP, tc);
+	wr_dma_ch_ind(ioaddr, MODE_RXEXTCFG, chan, value);
+
+	/* 1-to-1 VDMA to TC mapping */
+	value = readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
+	value &= ~XXVGMAC_RVDMA2TCMP;
+	value |= FIELD_PREP(XXVGMAC_RVDMA2TCMP, tc);
+	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
+
+	writel(upper_32_bits(dma_addr),
+	       ioaddr + XGMAC_DMA_CH_RxDESC_HADDR(chan));
+	writel(lower_32_bits(dma_addr),
+	       ioaddr + XGMAC_DMA_CH_RxDESC_LADDR(chan));
+}
diff --git a/drivers/net/ethernet/stmicro/stmmac/dw25gmac.h b/drivers/net/ethernet/stmicro/stmmac/dw25gmac.h
new file mode 100644
index 000000000000..b2eee66f04d5
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dw25gmac.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2024-2026 Broadcom Corporation
+ * DW25GMAC definitions.
+ */
+#ifndef __STMMAC_DW25GMAC_H__
+#define __STMMAC_DW25GMAC_H__
+
+/* Hardware features */
+#define XXVGMAC_HWFEAT_VDMA_RXCNT	GENMASK(16, 12)
+#define XXVGMAC_HWFEAT_VDMA_TXCNT	GENMASK(22, 18)
+
+/* DMA Indirect Registers*/
+#define XXVGMAC_DMA_CH_IND_CONTROL	0x00003080
+#define XXVGMAC_MODE_SELECT		GENMASK(27, 24)
+enum dma_ch_ind_modes {
+	MODE_TXEXTCFG	 = 0x0,	  /* Tx Extended Config */
+	MODE_RXEXTCFG	 = 0x1,	  /* Rx Extended Config */
+	MODE_TXDBGSTS	 = 0x2,	  /* Tx Debug Status */
+	MODE_RXDBGSTS	 = 0x3,	  /* Rx Debug Status */
+	MODE_TXDESCCTRL	 = 0x4,	  /* Tx Descriptor control */
+	MODE_RXDESCCTRL	 = 0x5,	  /* Rx Descriptor control */
+};
+
+#define XXVGMAC_ADDR_OFFSET		GENMASK(14, 8)
+#define XXVGMAC_AUTO_INCR		GENMASK(5, 4)
+#define XXVGMAC_CMD_TYPE		BIT(1)
+#define XXVGMAC_OB			BIT(0)
+#define XXVGMAC_DMA_CH_IND_DATA		0x00003084
+
+/* TX Config definitions */
+#define XXVGMAC_TXPBL			GENMASK(29, 24)
+#define XXVGMAC_TPBLX8_MODE		BIT(19)
+#define XXVGMAC_TP2TCMP			GENMASK(18, 16)
+#define XXVGMAC_ORRQ			GENMASK(13, 8)
+
+/* RX Config definitions */
+#define XXVGMAC_RXPBL			GENMASK(29, 24)
+#define XXVGMAC_RPBLX8_MODE		BIT(19)
+#define XXVGMAC_RP2TCMP			GENMASK(18, 16)
+#define XXVGMAC_OWRQ			GENMASK(13, 8)
+
+/* Tx Descriptor control */
+#define XXVGMAC_TXDCSZ			GENMASK(2, 0)
+#define XXVGMAC_TXDCSZ_0BYTES		0
+#define XXVGMAC_TXDCSZ_64BYTES		1
+#define XXVGMAC_TXDCSZ_128BYTES		2
+#define XXVGMAC_TXDCSZ_256BYTES		3
+#define XXVGMAC_TDPS			GENMASK(5, 3)
+#define XXVGMAC_TDPS_ZERO		0
+#define XXVGMAC_TDPS_1_8TH		1
+#define XXVGMAC_TDPS_1_4TH		2
+#define XXVGMAC_TDPS_HALF		3
+#define XXVGMAC_TDPS_3_4TH		4
+
+/* Rx Descriptor control */
+#define XXVGMAC_RXDCSZ			GENMASK(2, 0)
+#define XXVGMAC_RXDCSZ_0BYTES		0
+#define XXVGMAC_RXDCSZ_64BYTES		1
+#define XXVGMAC_RXDCSZ_128BYTES		2
+#define XXVGMAC_RXDCSZ_256BYTES		3
+#define XXVGMAC_RDPS			GENMASK(5, 3)
+#define XXVGMAC_RDPS_ZERO		0
+#define XXVGMAC_RDPS_1_8TH		1
+#define XXVGMAC_RDPS_1_4TH		2
+#define XXVGMAC_RDPS_HALF		3
+#define XXVGMAC_RDPS_3_4TH		4
+
+/* DWCXG_DMA_CH(#i) Registers*/
+#define XXVGMAC_DSL			GENMASK(20, 18)
+#define XXVGMAC_MSS			GENMASK(13, 0)
+#define XXVGMAC_TFSEL			GENMASK(30, 29)
+#define XXVGMAC_TQOS			GENMASK(27, 24)
+#define XXVGMAC_IPBL			BIT(15)
+#define XXVGMAC_TVDMA2TCMP		GENMASK(6, 4)
+#define XXVGMAC_RPF			BIT(31)
+#define XXVGMAC_RVDMA2TCMP		GENMASK(30, 28)
+#define XXVGMAC_RQOS			GENMASK(27, 24)
+
+u32 dw25gmac_decode_vdma_count(u32 regval);
+
+void dw25gmac_dma_init(void __iomem *ioaddr,
+		       struct stmmac_dma_cfg *dma_cfg);
+
+void dw25gmac_dma_init_tx_chan(struct stmmac_priv *priv,
+			       void __iomem *ioaddr,
+			       struct stmmac_dma_cfg *dma_cfg,
+			       dma_addr_t dma_addr, u32 chan);
+void dw25gmac_dma_init_rx_chan(struct stmmac_priv *priv,
+			       void __iomem *ioaddr,
+			       struct stmmac_dma_cfg *dma_cfg,
+			       dma_addr_t dma_addr, u32 chan);
+#endif /* __STMMAC_DW25GMAC_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 51943705a2b0..eb302a885dd3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -17,6 +17,7 @@
 #define XGMAC_CONFIG_SS_OFF		29
 #define XGMAC_CONFIG_SS_MASK		GENMASK(31, 29)
 #define XGMAC_CONFIG_SS_10000		(0x0 << XGMAC_CONFIG_SS_OFF)
+#define XGMAC_CONFIG_SS_25000		(0x1 << XGMAC_CONFIG_SS_OFF)
 #define XGMAC_CONFIG_SS_2500_GMII	(0x2 << XGMAC_CONFIG_SS_OFF)
 #define XGMAC_CONFIG_SS_1000_GMII	(0x3 << XGMAC_CONFIG_SS_OFF)
 #define XGMAC_CONFIG_SS_100_MII		(0x4 << XGMAC_CONFIG_SS_OFF)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 915e7c2ab11f..c6b08d751c7f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -13,6 +13,7 @@
 #include "stmmac_vlan.h"
 #include "dwxlgmac2.h"
 #include "dwxgmac2.h"
+#include "dw25gmac.h"
 
 static void dwxgmac2_core_init(struct mac_device_info *hw,
 			       struct net_device *dev)
@@ -1559,6 +1560,44 @@ int dwxgmac2_setup(struct stmmac_priv *priv)
 	return 0;
 }
 
+int dw25gmac_setup(struct stmmac_priv *priv)
+{
+	struct mac_device_info *mac = priv->hw;
+
+	dev_info(priv->device, "\tDW25GMAC\n");
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
+	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+			 MAC_1000FD | MAC_2500FD | MAC_5000FD |
+			 MAC_10000FD | MAC_25000FD;
+	mac->link.duplex = 0;
+	mac->link.speed10 = XGMAC_CONFIG_SS_10_MII;
+	mac->link.speed100 = XGMAC_CONFIG_SS_100_MII;
+	mac->link.speed1000 = XGMAC_CONFIG_SS_1000_GMII;
+	mac->link.speed2500 = XGMAC_CONFIG_SS_2500_GMII;
+	mac->link.xgmii.speed2500 = XGMAC_CONFIG_SS_2500;
+	mac->link.xgmii.speed5000 = XGMAC_CONFIG_SS_5000;
+	mac->link.xgmii.speed10000 = XGMAC_CONFIG_SS_10000;
+	mac->link.xgmii.speed25000 = XGMAC_CONFIG_SS_25000;
+	mac->link.speed_mask = XGMAC_CONFIG_SS_MASK;
+
+	mac->mii.addr = XGMAC_MDIO_ADDR;
+	mac->mii.data = XGMAC_MDIO_DATA;
+	mac->mii.addr_mask = GENMASK(20, 16);
+	mac->mii.reg_mask = GENMASK(15, 0);
+	mac->mii.clk_csr_mask = GENMASK(21, 19);
+
+	return 0;
+}
+
 int dwxlgmac2_setup(struct stmmac_priv *priv)
 {
 	struct mac_device_info *mac = priv->hw;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 03437f1cf3df..99f5b5598fcf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -7,6 +7,7 @@
 #include <linux/iopoll.h>
 #include "stmmac.h"
 #include "dwxgmac2.h"
+#include "dw25gmac.h"
 
 static int dwxgmac2_dma_reset(void __iomem *ioaddr)
 {
@@ -470,6 +471,26 @@ static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
 	return 0;
 }
 
+static int dw25gmac_get_hw_feature(void __iomem *ioaddr,
+				   struct dma_features *dma_cap)
+{
+	u32 hw_cap;
+	int ret;
+
+	ret = dwxgmac2_get_hw_feature(ioaddr, dma_cap);
+
+	/* For DW25GMAC VDMA channel count is channel count */
+	hw_cap = readl(ioaddr + XGMAC_HW_FEATURE2);
+	dma_cap->number_tx_channel =
+		dw25gmac_decode_vdma_count(FIELD_GET(XXVGMAC_HWFEAT_VDMA_TXCNT,
+						     hw_cap));
+	dma_cap->number_rx_channel =
+		dw25gmac_decode_vdma_count(FIELD_GET(XXVGMAC_HWFEAT_VDMA_RXCNT,
+						     hw_cap));
+
+	return ret;
+}
+
 static void dwxgmac2_rx_watchdog(struct stmmac_priv *priv, void __iomem *ioaddr,
 				 u32 riwt, u32 queue)
 {
@@ -611,3 +632,33 @@ const struct stmmac_dma_ops dwxgmac210_dma_ops = {
 	.enable_sph = dwxgmac2_enable_sph,
 	.enable_tbs = dwxgmac2_enable_tbs,
 };
+
+const struct stmmac_dma_ops dw25gmac400_dma_ops = {
+	.reset = dwxgmac2_dma_reset,
+	.init = dw25gmac_dma_init,
+	.init_chan = dwxgmac2_dma_init_chan,
+	.init_rx_chan = dw25gmac_dma_init_rx_chan,
+	.init_tx_chan = dw25gmac_dma_init_tx_chan,
+	.axi = dwxgmac2_dma_axi,
+	.dump_regs = dwxgmac2_dma_dump_regs,
+	.dma_rx_mode = dwxgmac2_dma_rx_mode,
+	.dma_tx_mode = dwxgmac2_dma_tx_mode,
+	.enable_dma_irq = dwxgmac2_enable_dma_irq,
+	.disable_dma_irq = dwxgmac2_disable_dma_irq,
+	.start_tx = dwxgmac2_dma_start_tx,
+	.stop_tx = dwxgmac2_dma_stop_tx,
+	.start_rx = dwxgmac2_dma_start_rx,
+	.stop_rx = dwxgmac2_dma_stop_rx,
+	.dma_interrupt = dwxgmac2_dma_interrupt,
+	.get_hw_feature = dw25gmac_get_hw_feature,
+	.rx_watchdog = dwxgmac2_rx_watchdog,
+	.set_rx_ring_len = dwxgmac2_set_rx_ring_len,
+	.set_tx_ring_len = dwxgmac2_set_tx_ring_len,
+	.set_rx_tail_ptr = dwxgmac2_set_rx_tail_ptr,
+	.set_tx_tail_ptr = dwxgmac2_set_tx_tail_ptr,
+	.enable_tso = dwxgmac2_enable_tso,
+	.qmode = dwxgmac2_qmode,
+	.set_bfsize = dwxgmac2_set_bfsize,
+	.enable_sph = dwxgmac2_enable_sph,
+	.enable_tbs = dwxgmac2_enable_tbs,
+};
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 374f326efa01..bb50b4fa9db7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -686,6 +686,7 @@ extern const struct stmmac_dma_ops dwmac410_dma_ops;
 extern const struct stmmac_ops dwmac510_ops;
 extern const struct stmmac_tc_ops dwmac4_tc_ops;
 extern const struct stmmac_tc_ops dwmac510_tc_ops;
+extern const struct stmmac_dma_ops dw25gmac400_dma_ops;
 
 #define GMAC_VERSION		0x00000020	/* GMAC CORE Version */
 #define GMAC4_VERSION		0x00000110	/* GMAC4+ CORE Version */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f0160ff54a59..05d0c369ad05 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -144,6 +144,10 @@ static const char *stmmac_dwxgmac_phyif[4] = {
 	[PHY_INTF_RGMII]	= "RGMII",
 };
 
+static const char *stmmac_dw25gmac_phyif[2] = {
+	[PHY_INTF_DW25GMAC_XGMII]	= "XGMII",
+};
+
 static irqreturn_t stmmac_interrupt(int irq, void *dev_id);
 /* For MSI interrupts handling */
 static irqreturn_t stmmac_mac_interrupt(int irq, void *dev_id);
@@ -1019,6 +1023,32 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 		default:
 			return;
 		}
+	} else if (interface == PHY_INTERFACE_MODE_XGMII) {
+		switch (speed) {
+		case SPEED_25000:
+			ctrl |= priv->hw->link.xgmii.speed25000;
+			break;
+		case SPEED_10000:
+			ctrl |= priv->hw->link.xgmii.speed10000;
+			break;
+		case SPEED_5000:
+			ctrl |= priv->hw->link.xgmii.speed5000;
+			break;
+		case SPEED_2500:
+			ctrl |= priv->hw->link.xgmii.speed2500;
+			break;
+		case SPEED_1000:
+			ctrl |= priv->hw->link.speed1000;
+			break;
+		case SPEED_100:
+			ctrl |= priv->hw->link.speed100;
+			break;
+		case SPEED_10:
+			ctrl |= priv->hw->link.speed10;
+			break;
+		default:
+			return;
+		}
 	} else if (interface == PHY_INTERFACE_MODE_XLGMII) {
 		switch (speed) {
 		case SPEED_100000:
@@ -7343,6 +7373,11 @@ static void stmmac_print_actphyif(struct stmmac_priv *priv)
 		phyif_table = stmmac_dwxgmac_phyif;
 		phyif_table_size = ARRAY_SIZE(stmmac_dwxgmac_phyif);
 		break;
+
+	case DWMAC_CORE_25GMAC:
+		phyif_table = stmmac_dw25gmac_phyif;
+		phyif_table_size = ARRAY_SIZE(stmmac_dw25gmac_phyif);
+		break;
 	}
 
 	if (priv->dma_cap.actphyif < phyif_table_size)
-- 
2.34.1


