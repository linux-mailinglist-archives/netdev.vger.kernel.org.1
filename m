Return-Path: <netdev+bounces-120121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0C19585AC
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 13:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A7E3B227D1
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 11:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A2718F2DA;
	Tue, 20 Aug 2024 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRKLO1vr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B442718F2CE;
	Tue, 20 Aug 2024 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724152905; cv=none; b=Bwds2FrpDWNhuENxHpUSxwD9cb4oR8as3v1ZW7cjq76LjnfIH6AKjwD9OWL17/0DWGjVgDVnhQNiBggjzr5vxeY0edOvcnXORfAxN1WnXudwpYGx1cg5iiK/r7aEaoe7a5rHl/bzeHdEQURk3DjxxLMOCV3fCTp5WoIh9wBNzwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724152905; c=relaxed/simple;
	bh=POnQllIjebUTgpfuTApIGn7US+QsVt5h/4gX0qaklzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VmSTXidS+mECV8ipMGw9Mn1JPAdmIUf4JP54VqR27bcNM0WfUfJv9k4uMRv9V8030chWvkJs0a+upP/y4FX/evj6tnbvtvMEYlgWQg5w2D8NaxOKzNg/MLJPifbiqgeanjRYxerK4lu01JhRkqJWUSJq3CHaTH34Rb/99AMC3nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRKLO1vr; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-201f7fb09f6so36734775ad.2;
        Tue, 20 Aug 2024 04:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724152903; x=1724757703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZz2NAEXYWWgXfDrArGrQdZXL2FPNbqUoBX6awsOn9o=;
        b=PRKLO1vrxi+R8KQEwCOKuso3g2aes/7tLo2DyugUeE8tST1YxQtahu55XvJ48vj+kl
         71Qkf+gsm04TzZmFj5XlBfGdHvWpI04yGu9mw4F/7Xf1gmKliVv0bkoK4Ls3F14RAGnm
         bAjJnRVvACQA4kX8L6hZzcfuWHUCXcpQ82MkWf60B3hqKj0/rPh9JMojTFncOuVv1UCk
         sry8JFI2xEIC7ovj1uVT71RZNWC/5hnvMBT/OHxf4auVep8RrN8ibsKyVFPLt7U4pFJO
         XvqTUn4kbxviDaxnBXdIkxyACllLfmcBHGAwcCLkqEigmdVnCmBxypVJFqv+HDboIu8D
         nhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724152903; x=1724757703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZz2NAEXYWWgXfDrArGrQdZXL2FPNbqUoBX6awsOn9o=;
        b=iKzMx5E0CioskAKWkEJinU4I6cfX8e7Nze8Vsur3S+oF/dAr5OXmSHOqaZG/ZhEq8P
         S8kM8rLlf7l4nHPMYPrciHyY+sJ84mUOXz3sZbPE3sGp1hTdqmu+qe6XxAPjSw5JzIAP
         3tMzBoOtHUs6cvEUtf4aVMvL97/1tz4Ryqy2Ul7S8ww5wMuPPod0TUZI/ULW7Hpq8Xh+
         8KcKHaIIXQ73Alr25eCJBFkJ18H1gBL3FUO475WPMMG26/8xGQxB0NAHYmTqgcvA13KB
         sHFTu0RGXUgiHOld6qz9kTYhHPsVxMuXB+5Go7zvQEnxWP3irW0NcHxPHCe++qzqeaub
         fsZA==
X-Forwarded-Encrypted: i=1; AJvYcCUqYtyOeFouFOby38IDNxp0qQDonssTnYNjQSpXYqMXGDAbirDQJj2c7dVwEpoaJJIkGAKW87mDUx8YfRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGoBlhR8tJu77eFzk40qsmFIprCClmFyl09xJSh28Jdcnftwsz
	6UZBudprZSlVUdQjvrco0+7QPMLOEaB/n1Hsi27eCm9X4Tp5OJ5H
X-Google-Smtp-Source: AGHT+IGtjGQs7JRxLOObHAgpuSB/pcN4Ela8EgoiSbpVTxAYXtViJRltryBQyo9GmHk+VsznnivHGw==
X-Received: by 2002:a17:902:da8b:b0:201:fac8:ff67 with SMTP id d9443c01a7336-20203e9b6c1mr151337895ad.17.1724152902687;
        Tue, 20 Aug 2024 04:21:42 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f03756f6sm76465355ad.172.2024.08.20.04.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 04:21:42 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v5 4/7] net: stmmac: configure FPE via ethtool-mm
Date: Tue, 20 Aug 2024 19:20:38 +0800
Message-Id: <d9dd1cdb2fe01c74987968942ce27424b763e548.1724152528.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724152528.git.0x1207@gmail.com>
References: <cover.1724152528.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement ethtool --show-mm and --set-mm callbacks.

NIC up/down, link up/down, suspend/resume, kselftest-ethtool_mm,
all tested okay.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |   8 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c  |  36 +++++-
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |   7 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |   4 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |   8 +-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 110 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  17 ++-
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   |   2 +-
 8 files changed, 179 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 31c387cc5f26..679efcc631f1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -58,10 +58,6 @@ static void dwmac4_core_init(struct mac_device_info *hw,
 	if (hw->pcs)
 		value |= GMAC_PCS_IRQ_DEFAULT;
 
-	/* Enable FPE interrupt */
-	if ((GMAC_HW_FEAT_FPESEL & readl(ioaddr + GMAC_HW_FEATURE3)) >> 26)
-		value |= GMAC_INT_FPE_EN;
-
 	writel(value, ioaddr + GMAC_INT_EN);
 
 	if (GMAC_INT_DEFAULT_ENABLE & GMAC_INT_TSIE)
@@ -1268,6 +1264,8 @@ const struct stmmac_ops dwmac410_ops = {
 	.fpe_configure = dwmac5_fpe_configure,
 	.fpe_send_mpacket = dwmac5_fpe_send_mpacket,
 	.fpe_irq_status = dwmac5_fpe_irq_status,
+	.fpe_get_add_frag_size = dwmac5_fpe_get_add_frag_size,
+	.fpe_set_add_frag_size = dwmac5_fpe_set_add_frag_size,
 	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
 	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
 	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
@@ -1320,6 +1318,8 @@ const struct stmmac_ops dwmac510_ops = {
 	.fpe_configure = dwmac5_fpe_configure,
 	.fpe_send_mpacket = dwmac5_fpe_send_mpacket,
 	.fpe_irq_status = dwmac5_fpe_irq_status,
+	.fpe_get_add_frag_size = dwmac5_fpe_get_add_frag_size,
+	.fpe_set_add_frag_size = dwmac5_fpe_set_add_frag_size,
 	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
 	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
 	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
index e02cebc3f1b7..4c91fa766b13 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@ -575,11 +575,11 @@ int dwmac5_flex_pps_config(void __iomem *ioaddr, int index,
 
 void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
 			  u32 num_txq, u32 num_rxq,
-			  bool enable)
+			  bool tx_enable, bool pmac_enable)
 {
 	u32 value;
 
-	if (enable) {
+	if (tx_enable) {
 		cfg->fpe_csr = EFPE;
 		value = readl(ioaddr + GMAC_RXQ_CTRL1);
 		value &= ~GMAC_RXQCTRL_FPRQ;
@@ -589,6 +589,21 @@ void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
 		cfg->fpe_csr = 0;
 	}
 	writel(cfg->fpe_csr, ioaddr + MAC_FPE_CTRL_STS);
+
+	value = readl(ioaddr + GMAC_INT_EN);
+
+	if (pmac_enable) {
+		if (!(value & GMAC_INT_FPE_EN)) {
+			/* Dummy read to clear any pending masked interrupts */
+			(void)readl(ioaddr + MAC_FPE_CTRL_STS);
+
+			value |= GMAC_INT_FPE_EN;
+		}
+	} else {
+		value &= ~GMAC_INT_FPE_EN;
+	}
+
+	writel(value, ioaddr + GMAC_INT_EN);
 }
 
 int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
@@ -638,3 +653,20 @@ void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
 
 	writel(value, ioaddr + MAC_FPE_CTRL_STS);
 }
+
+int dwmac5_fpe_get_add_frag_size(void __iomem *ioaddr)
+{
+	return FIELD_GET(AFSZ, readl(ioaddr + MTL_FPE_CTRL_STS));
+}
+
+void dwmac5_fpe_set_add_frag_size(void __iomem *ioaddr, u32 add_frag_size)
+{
+	u32 value;
+
+	value = readl(ioaddr + MTL_FPE_CTRL_STS);
+
+	value &= ~AFSZ;
+	value |= FIELD_PREP(AFSZ, add_frag_size);
+
+	writel(value, ioaddr + MTL_FPE_CTRL_STS);
+}
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
index bf33a51d229e..e369e65920fc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
@@ -39,6 +39,9 @@
 #define MAC_PPSx_INTERVAL(x)		(0x00000b88 + ((x) * 0x10))
 #define MAC_PPSx_WIDTH(x)		(0x00000b8c + ((x) * 0x10))
 
+#define MTL_FPE_CTRL_STS		0x00000c90
+#define AFSZ				GENMASK(1, 0)
+
 #define MTL_RXP_CONTROL_STATUS		0x00000ca0
 #define RXPI				BIT(31)
 #define NPE				GENMASK(23, 16)
@@ -104,10 +107,12 @@ int dwmac5_flex_pps_config(void __iomem *ioaddr, int index,
 			   u32 sub_second_inc, u32 systime_flags);
 void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
 			  u32 num_txq, u32 num_rxq,
-			  bool enable);
+			  bool tx_enable, bool pmac_enable);
 void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
 			     struct stmmac_fpe_cfg *cfg,
 			     enum stmmac_mpacket_type type);
 int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev);
+int dwmac5_fpe_get_add_frag_size(void __iomem *ioaddr);
+void dwmac5_fpe_set_add_frag_size(void __iomem *ioaddr, u32 add_frag_size);
 
 #endif /* __DWMAC5_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index cbf2dd976ab1..55a175ced77f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1506,11 +1506,11 @@ static void dwxgmac2_set_arp_offload(struct mac_device_info *hw, bool en,
 
 static void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
 				   u32 num_txq,
-				   u32 num_rxq, bool enable)
+				   u32 num_rxq, bool tx_enable, bool pmac_enable)
 {
 	u32 value;
 
-	if (!enable) {
+	if (!tx_enable) {
 		value = readl(ioaddr + XGMAC_FPE_CTRL_STS);
 
 		value &= ~XGMAC_EFPE;
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index d3da82982012..ba4418eaa8ba 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -421,11 +421,13 @@ struct stmmac_ops {
 	void (*set_arp_offload)(struct mac_device_info *hw, bool en, u32 addr);
 	void (*fpe_configure)(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
 			      u32 num_txq, u32 num_rxq,
-			      bool enable);
+			      bool tx_enable, bool pmac_enable);
 	void (*fpe_send_mpacket)(void __iomem *ioaddr,
 				 struct stmmac_fpe_cfg *cfg,
 				 enum stmmac_mpacket_type type);
 	int (*fpe_irq_status)(void __iomem *ioaddr, struct net_device *dev);
+	int (*fpe_get_add_frag_size)(void __iomem *ioaddr);
+	void (*fpe_set_add_frag_size)(void __iomem *ioaddr, u32 add_frag_size);
 };
 
 #define stmmac_core_init(__priv, __args...) \
@@ -530,6 +532,10 @@ struct stmmac_ops {
 	stmmac_do_void_callback(__priv, mac, fpe_send_mpacket, __args)
 #define stmmac_fpe_irq_status(__priv, __args...) \
 	stmmac_do_callback(__priv, mac, fpe_irq_status, __args)
+#define stmmac_fpe_get_add_frag_size(__priv, __args...) \
+	stmmac_do_callback(__priv, mac, fpe_get_add_frag_size, __args)
+#define stmmac_fpe_set_add_frag_size(__priv, __args...) \
+	stmmac_do_void_callback(__priv, mac, fpe_set_add_frag_size, __args)
 
 /* PTP and HW Timer helpers */
 struct stmmac_hwtimestamp {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 7008219fd88d..a8cdcacecc26 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -19,6 +19,7 @@
 #include "stmmac.h"
 #include "dwmac_dma.h"
 #include "dwxgmac2.h"
+#include "dwmac5.h"
 
 #define REG_SPACE_SIZE	0x1060
 #define GMAC4_REG_SPACE_SIZE	0x116C
@@ -1270,6 +1271,112 @@ static int stmmac_set_tunable(struct net_device *dev,
 	return ret;
 }
 
+static int stmmac_get_mm(struct net_device *ndev,
+			 struct ethtool_mm_state *state)
+{
+	struct stmmac_priv *priv = netdev_priv(ndev);
+	unsigned long flags;
+	u32 add_frag_size;
+
+	if (!priv->dma_cap.fpesel)
+		return -EOPNOTSUPP;
+
+	spin_lock_irqsave(&priv->fpe_cfg.lock, flags);
+
+	state->pmac_enabled = priv->fpe_cfg.pmac_enabled;
+	state->verify_time = priv->fpe_cfg.verify_time;
+	state->verify_enabled = priv->fpe_cfg.verify_enabled;
+	state->verify_status = priv->fpe_cfg.status;
+	state->rx_min_frag_size = ETH_ZLEN;
+
+	/* 802.3-2018 clause 30.14.1.6, says that the aMACMergeVerifyTime
+	 * variable has a range between 1 and 128 ms inclusive. Limit to that.
+	 */
+	state->max_verify_time = 128;
+
+	/* Cannot read MAC_FPE_CTRL_STS register here, or FPE interrupt events
+	 * can be lost.
+	 *
+	 * See commit 37e4b8df27bc ("net: stmmac: fix FPE events losing")
+	 */
+	state->tx_enabled = !!(priv->fpe_cfg.fpe_csr == EFPE);
+
+	/* FPE active if common tx_enabled and verification success or disabled (forced) */
+	state->tx_active = state->tx_enabled &&
+			   (state->verify_status == ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED ||
+			    state->verify_status == ETHTOOL_MM_VERIFY_STATUS_DISABLED);
+
+	add_frag_size = stmmac_fpe_get_add_frag_size(priv, priv->ioaddr);
+	state->tx_min_frag_size = ethtool_mm_frag_size_add_to_min(add_frag_size);
+
+	spin_unlock_irqrestore(&priv->fpe_cfg.lock, flags);
+
+	return 0;
+}
+
+static int stmmac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
+			 struct netlink_ext_ack *extack)
+{
+	struct stmmac_priv *priv = netdev_priv(ndev);
+	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
+	unsigned long flags;
+	u32 add_frag_size;
+	int err;
+
+	if (!priv->dma_cap.fpesel)
+		return -EOPNOTSUPP;
+
+	/* Wait for the fpe_task that's currently in progress to finish */
+	flush_workqueue(priv->fpe_wq);
+
+	err = ethtool_mm_frag_size_min_to_add(cfg->tx_min_frag_size,
+					      &add_frag_size, extack);
+	if (err)
+		return err;
+
+	spin_lock_irqsave(&priv->fpe_cfg.lock, flags);
+
+	fpe_cfg->pmac_enabled = cfg->pmac_enabled;
+	fpe_cfg->verify_time = cfg->verify_time;
+	fpe_cfg->verify_enabled = cfg->verify_enabled;
+
+	stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
+			     priv->plat->tx_queues_to_use,
+			     priv->plat->rx_queues_to_use,
+			     cfg->tx_enabled, cfg->pmac_enabled);
+
+	stmmac_fpe_set_add_frag_size(priv, priv->ioaddr, add_frag_size);
+
+	if (cfg->verify_enabled)
+		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
+					MPACKET_VERIFY);
+	else
+		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
+
+	spin_unlock_irqrestore(&priv->fpe_cfg.lock, flags);
+
+	return 0;
+}
+
+static void stmmac_get_mm_stats(struct net_device *ndev,
+				struct ethtool_mm_stats *s)
+{
+	struct stmmac_priv *priv = netdev_priv(ndev);
+	struct stmmac_counters *mmc = &priv->mmc;
+
+	if (!priv->dma_cap.rmon)
+		return;
+
+	stmmac_mmc_read(priv, priv->mmcaddr, mmc);
+
+	s->MACMergeFrameAssErrorCount = mmc->mmc_rx_packet_assembly_err_cntr;
+	s->MACMergeFrameSmdErrorCount = mmc->mmc_rx_packet_smd_err_cntr;
+	s->MACMergeFrameAssOkCount = mmc->mmc_rx_packet_assembly_ok_cntr;
+	s->MACMergeFragCountRx = mmc->mmc_rx_fpe_fragment_cntr;
+	s->MACMergeFragCountTx = mmc->mmc_tx_fpe_fragment_cntr;
+	s->MACMergeHoldCount = mmc->mmc_tx_hold_req_cntr;
+}
+
 static const struct ethtool_ops stmmac_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
@@ -1309,6 +1416,9 @@ static const struct ethtool_ops stmmac_ethtool_ops = {
 	.set_tunable = stmmac_set_tunable,
 	.get_link_ksettings = stmmac_ethtool_get_link_ksettings,
 	.set_link_ksettings = stmmac_ethtool_set_link_ksettings,
+	.get_mm = stmmac_get_mm,
+	.set_mm = stmmac_set_mm,
+	.get_mm_stats = stmmac_get_mm_stats,
 };
 
 void stmmac_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 6ae95f20b24f..3df9cad0848b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3537,8 +3537,21 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 
 	stmmac_set_hw_vlan_mode(priv, priv->hw);
 
-	if (priv->dma_cap.fpesel)
+	if (priv->dma_cap.fpesel) {
+		/* A SW reset just happened in stmmac_init_dma_engine(),
+		 * we should restore fpe_cfg to HW, or FPE will stop working
+		 * from suspend/resume.
+		 */
+		spin_lock(&priv->fpe_cfg.lock);
+		stmmac_fpe_configure(priv, priv->ioaddr,
+				     &priv->fpe_cfg,
+				     priv->plat->tx_queues_to_use,
+				     priv->plat->rx_queues_to_use,
+				     false, priv->fpe_cfg.pmac_enabled);
+		spin_unlock(&priv->fpe_cfg.lock);
+
 		stmmac_fpe_start_wq(priv);
+	}
 
 	return 0;
 }
@@ -7417,7 +7430,7 @@ static void stmmac_fpe_verify_task(struct work_struct *work)
 			stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
 					     priv->plat->tx_queues_to_use,
 					     priv->plat->rx_queues_to_use,
-					     false);
+					     false, fpe_cfg->pmac_enabled);
 			spin_unlock_irqrestore(&priv->fpe_cfg.lock, flags);
 			break;
 		}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 783829a6479c..a58282d6458c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1093,7 +1093,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 			     &priv->fpe_cfg,
 			     priv->plat->tx_queues_to_use,
 			     priv->plat->rx_queues_to_use,
-			     false);
+			     false, false);
 	netdev_info(priv->dev, "disabled FPE\n");
 
 	return ret;
-- 
2.34.1


