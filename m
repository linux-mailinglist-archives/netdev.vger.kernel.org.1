Return-Path: <netdev+bounces-140695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 605579B7AD0
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 13:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828081C21C82
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 12:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7117919D092;
	Thu, 31 Oct 2024 12:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWjKJjod"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E01C1A08B2;
	Thu, 31 Oct 2024 12:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378316; cv=none; b=mLLK6DWQK3DGrIwUw4gfdgBK+Jivy+R0jvGsMY2peGKbWxz3fyUI6IDXsiXdNX/krG+D2gLYC8PclAbJgElWfUVuGmzB/fei8VWttTox8kCUcQABCCAkws/UYcUtRb2STs0st4BJvL0ElDTRh5w1gLrWBWoTy8vu78ZsFa3V8/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378316; c=relaxed/simple;
	bh=Nag3b2hWtQEl30hz5TCfrUyWvGXMuk3VpBOmpZq+w4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ttxn+3Y2nnV9fSAZYH3qgMYibteatW+9wmC7BXs6cDFxIAOuLg+DfiBuYlqWjpLUpIUnJe9Bfn4x752+SRNC1FfSDg2mRjdS+9PXbKbOcAkMweaUbzFLeGW3f6C1+OhkQmElj4+fhdzjsz1DhJNaJISa1zPZNNDKtitl6LC1D7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWjKJjod; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso699421b3a.2;
        Thu, 31 Oct 2024 05:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730378311; x=1730983111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nU2caFtjLJow7ZnUUVJfpGtQO6czkRGSdnGX15Mzw20=;
        b=OWjKJjodrwT80MvCKtx29UyzBVzoWkipsUGTpzXMATnllCdX6A2Ln6gIxy1XqCnXC1
         ++7rpyX9UlYfgc6Q4QPzzI6/TY5PFclDxw1ps+5Ir15qEj9JDG7IEII8giUDLjFuQDmK
         yziG42aU7KVqrPnuOhsSi21WjDjW5emQ0C1eWE//I5Oc/wX43XMBqRRBmYJBzV/fcxM/
         7pYswtkqyqe9U0zi0MAJXfr0RwJG0UFcIQeot3SZ20v2TM5kCTey/zehI/0q7MqmSmYT
         ii8akeeEqr0noByAk1RQae8XbengWT/SOU18PtG37LtVwEFAKIKw3Tz85cJeAgGoRA6Q
         Gn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730378311; x=1730983111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nU2caFtjLJow7ZnUUVJfpGtQO6czkRGSdnGX15Mzw20=;
        b=dvVley40ssDFl+vyq9KCbn9KLp3gF7jiOrToHzAPAd+r8dk7BAVOdAq9+qqAPdxmkl
         ri2eTUbvrhINRB/t0RtwXVLrod0WX6hW5QONlGKHccYrPDgwhpHnz2TidLeqDpR1WRLS
         8gerzz7l4BrNnTJR9LgInQxFuXGzC2t/oJ03artEogpsWO6DbcYplPzmUvBtRoMKNUUk
         AyTsVgceJWP/KJgZcAehZeeLZ8iHTvY2OkySFWPEmJR0eYn8Fg8EP/F2df72RNXwEMhV
         +Gm6lvhZBBb9K93yGtE2i60FXAljTfaA+FlTluCccHODG8+cgUU5Z9C/xhgbaoHRhtsL
         w9Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXqAAFp1pfoCW4O8PR/BVWPgWmFiWz9Si4XsnYcuNFlY8F30Triu2CyIZBDQJmAs/IklM/1CG34k8z4XiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhGbiHf0L/dCcnKaaQD+TPpBrUWRnGwm6dYdRSTpBJLWhmJ/RJ
	m6ZnoEL6u44H35XdrZ46lp/wQAZQkeKHAhg5iBu8NHMb9hlKHjsfjZcQxA==
X-Google-Smtp-Source: AGHT+IGLJ54CUQmQmEiBbbETgqI0Kxo26AxxynsoAhwf36yJv8b1ulVtzONW85LXH4yRlch1/XBSCg==
X-Received: by 2002:a05:6a00:1910:b0:71e:5e04:be9b with SMTP id d2e1a72fcca58-72062fb21f2mr28778575b3a.12.1730378310924;
        Thu, 31 Oct 2024 05:38:30 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-720bc20f50esm1075931b3a.94.2024.10.31.05.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 05:38:30 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v7 1/8] net: stmmac: Introduce separate files for FPE implementation
Date: Thu, 31 Oct 2024 20:37:55 +0800
Message-Id: <9876134957283296792864da97eab60328f8d478.1730376866.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730376866.git.0x1207@gmail.com>
References: <cover.1730376866.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By moving FPE related code info separate files, FPE implementation
becomes a separate module initially.
No functional change intended.

Signed-off-by: Furong Xu <0x1207@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c  | 150 --------
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |  26 --
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |   2 -
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  27 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  10 -
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |   2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 354 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.h  |  45 +++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 149 +-------
 11 files changed, 405 insertions(+), 363 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h

diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index c2f0e91f6bf8..7e46dca90628 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -6,7 +6,7 @@ stmmac-objs:= stmmac_main.o stmmac_ethtool.o stmmac_mdio.o ring_mode.o	\
 	      mmc_core.o stmmac_hwtstamp.o stmmac_ptp.o dwmac4_descs.o	\
 	      dwmac4_dma.o dwmac4_lib.o dwmac4_core.o dwmac5.o hwif.o \
 	      stmmac_tc.o dwxgmac2_core.o dwxgmac2_dma.o dwxgmac2_descs.o \
-	      stmmac_xdp.o stmmac_est.o \
+	      stmmac_xdp.o stmmac_est.o stmmac_fpe.o \
 	      $(stmmac-y)
 
 stmmac-$(CONFIG_STMMAC_SELFTESTS) += stmmac_selftests.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index e65a65666cc1..4d217926820a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include "stmmac.h"
+#include "stmmac_fpe.h"
 #include "stmmac_pcs.h"
 #include "dwmac4.h"
 #include "dwmac5.h"
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
index 08add508db84..1c431b918719 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@ -572,153 +572,3 @@ int dwmac5_flex_pps_config(void __iomem *ioaddr, int index,
 	writel(val, ioaddr + MAC_PPS_CONTROL);
 	return 0;
 }
-
-void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
-			  u32 num_txq, u32 num_rxq,
-			  bool tx_enable, bool pmac_enable)
-{
-	u32 value;
-
-	if (tx_enable) {
-		cfg->fpe_csr = EFPE;
-		value = readl(ioaddr + GMAC_RXQ_CTRL1);
-		value &= ~GMAC_RXQCTRL_FPRQ;
-		value |= (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
-		writel(value, ioaddr + GMAC_RXQ_CTRL1);
-	} else {
-		cfg->fpe_csr = 0;
-	}
-	writel(cfg->fpe_csr, ioaddr + MAC_FPE_CTRL_STS);
-
-	value = readl(ioaddr + GMAC_INT_EN);
-
-	if (pmac_enable) {
-		if (!(value & GMAC_INT_FPE_EN)) {
-			/* Dummy read to clear any pending masked interrupts */
-			readl(ioaddr + MAC_FPE_CTRL_STS);
-
-			value |= GMAC_INT_FPE_EN;
-		}
-	} else {
-		value &= ~GMAC_INT_FPE_EN;
-	}
-
-	writel(value, ioaddr + GMAC_INT_EN);
-}
-
-int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
-{
-	u32 value;
-	int status;
-
-	status = FPE_EVENT_UNKNOWN;
-
-	/* Reads from the MAC_FPE_CTRL_STS register should only be performed
-	 * here, since the status flags of MAC_FPE_CTRL_STS are "clear on read"
-	 */
-	value = readl(ioaddr + MAC_FPE_CTRL_STS);
-
-	if (value & TRSP) {
-		status |= FPE_EVENT_TRSP;
-		netdev_dbg(dev, "FPE: Respond mPacket is transmitted\n");
-	}
-
-	if (value & TVER) {
-		status |= FPE_EVENT_TVER;
-		netdev_dbg(dev, "FPE: Verify mPacket is transmitted\n");
-	}
-
-	if (value & RRSP) {
-		status |= FPE_EVENT_RRSP;
-		netdev_dbg(dev, "FPE: Respond mPacket is received\n");
-	}
-
-	if (value & RVER) {
-		status |= FPE_EVENT_RVER;
-		netdev_dbg(dev, "FPE: Verify mPacket is received\n");
-	}
-
-	return status;
-}
-
-void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
-			     enum stmmac_mpacket_type type)
-{
-	u32 value = cfg->fpe_csr;
-
-	if (type == MPACKET_VERIFY)
-		value |= SVER;
-	else if (type == MPACKET_RESPONSE)
-		value |= SRSP;
-
-	writel(value, ioaddr + MAC_FPE_CTRL_STS);
-}
-
-int dwmac5_fpe_get_add_frag_size(const void __iomem *ioaddr)
-{
-	return FIELD_GET(DWMAC5_ADD_FRAG_SZ, readl(ioaddr + MTL_FPE_CTRL_STS));
-}
-
-void dwmac5_fpe_set_add_frag_size(void __iomem *ioaddr, u32 add_frag_size)
-{
-	u32 value;
-
-	value = readl(ioaddr + MTL_FPE_CTRL_STS);
-	writel(u32_replace_bits(value, add_frag_size, DWMAC5_ADD_FRAG_SZ),
-	       ioaddr + MTL_FPE_CTRL_STS);
-}
-
-#define ALG_ERR_MSG "TX algorithm SP is not suitable for one-to-many mapping"
-#define WEIGHT_ERR_MSG "TXQ weight %u differs across other TXQs in TC: [%u]"
-
-int dwmac5_fpe_map_preemption_class(struct net_device *ndev,
-				    struct netlink_ext_ack *extack, u32 pclass)
-{
-	u32 val, offset, count, queue_weight, preemptible_txqs = 0;
-	struct stmmac_priv *priv = netdev_priv(ndev);
-	u32 num_tc = ndev->num_tc;
-
-	if (!pclass)
-		goto update_mapping;
-
-	/* DWMAC CORE4+ can not program TC:TXQ mapping to hardware.
-	 *
-	 * Synopsys Databook:
-	 * "The number of Tx DMA channels is equal to the number of Tx queues,
-	 * and is direct one-to-one mapping."
-	 */
-	for (u32 tc = 0; tc < num_tc; tc++) {
-		count = ndev->tc_to_txq[tc].count;
-		offset = ndev->tc_to_txq[tc].offset;
-
-		if (pclass & BIT(tc))
-			preemptible_txqs |= GENMASK(offset + count - 1, offset);
-
-		/* This is 1:1 mapping, go to next TC */
-		if (count == 1)
-			continue;
-
-		if (priv->plat->tx_sched_algorithm == MTL_TX_ALGORITHM_SP) {
-			NL_SET_ERR_MSG_MOD(extack, ALG_ERR_MSG);
-			return -EINVAL;
-		}
-
-		queue_weight = priv->plat->tx_queues_cfg[offset].weight;
-
-		for (u32 i = 1; i < count; i++) {
-			if (priv->plat->tx_queues_cfg[offset + i].weight !=
-			    queue_weight) {
-				NL_SET_ERR_MSG_FMT_MOD(extack, WEIGHT_ERR_MSG,
-						       queue_weight, tc);
-				return -EINVAL;
-			}
-		}
-	}
-
-update_mapping:
-	val = readl(priv->ioaddr + MTL_FPE_CTRL_STS);
-	writel(u32_replace_bits(val, preemptible_txqs, DWMAC5_PREEMPTION_CLASS),
-	       priv->ioaddr + MTL_FPE_CTRL_STS);
-
-	return 0;
-}
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
index 6c6eb6790e83..00b151b3b688 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
@@ -11,15 +11,6 @@
 #define PRTYEN				BIT(1)
 #define TMOUTEN				BIT(0)
 
-#define MAC_FPE_CTRL_STS		0x00000234
-#define TRSP				BIT(19)
-#define TVER				BIT(18)
-#define RRSP				BIT(17)
-#define RVER				BIT(16)
-#define SRSP				BIT(2)
-#define SVER				BIT(1)
-#define EFPE				BIT(0)
-
 #define MAC_PPS_CONTROL			0x00000b70
 #define PPS_MAXIDX(x)			((((x) + 1) * 8) - 1)
 #define PPS_MINIDX(x)			((x) * 8)
@@ -39,12 +30,6 @@
 #define MAC_PPSx_INTERVAL(x)		(0x00000b88 + ((x) * 0x10))
 #define MAC_PPSx_WIDTH(x)		(0x00000b8c + ((x) * 0x10))
 
-#define MTL_FPE_CTRL_STS		0x00000c90
-/* Preemption Classification */
-#define DWMAC5_PREEMPTION_CLASS		GENMASK(15, 8)
-/* Additional Fragment Size of preempted frames */
-#define DWMAC5_ADD_FRAG_SZ		GENMASK(1, 0)
-
 #define MTL_RXP_CONTROL_STATUS		0x00000ca0
 #define RXPI				BIT(31)
 #define NPE				GENMASK(23, 16)
@@ -108,16 +93,5 @@ int dwmac5_rxp_config(void __iomem *ioaddr, struct stmmac_tc_entry *entries,
 int dwmac5_flex_pps_config(void __iomem *ioaddr, int index,
 			   struct stmmac_pps_cfg *cfg, bool enable,
 			   u32 sub_second_inc, u32 systime_flags);
-void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
-			  u32 num_txq, u32 num_rxq,
-			  bool tx_enable, bool pmac_enable);
-void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
-			     struct stmmac_fpe_cfg *cfg,
-			     enum stmmac_mpacket_type type);
-int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev);
-int dwmac5_fpe_get_add_frag_size(const void __iomem *ioaddr);
-void dwmac5_fpe_set_add_frag_size(void __iomem *ioaddr, u32 add_frag_size);
-int dwmac5_fpe_map_preemption_class(struct net_device *ndev,
-				    struct netlink_ext_ack *extack, u32 pclass);
 
 #endif /* __DWMAC5_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 6a2c7d22df1e..917796293c26 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -193,8 +193,6 @@
 #define XGMAC_MDIO_ADDR			0x00000200
 #define XGMAC_MDIO_DATA			0x00000204
 #define XGMAC_MDIO_C22P			0x00000220
-#define XGMAC_FPE_CTRL_STS		0x00000280
-#define XGMAC_EFPE			BIT(0)
 #define XGMAC_ADDRx_HIGH(x)		(0x00000300 + (x) * 0x8)
 #define XGMAC_ADDR_MAX			32
 #define XGMAC_AE			BIT(31)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index f519d43738b0..111ba5a524ed 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -8,6 +8,7 @@
 #include <linux/crc32.h>
 #include <linux/iopoll.h>
 #include "stmmac.h"
+#include "stmmac_fpe.h"
 #include "stmmac_ptp.h"
 #include "dwxlgmac2.h"
 #include "dwxgmac2.h"
@@ -1504,32 +1505,6 @@ static void dwxgmac2_set_arp_offload(struct mac_device_info *hw, bool en,
 	writel(value, ioaddr + XGMAC_RX_CONFIG);
 }
 
-static void dwxgmac3_fpe_configure(void __iomem *ioaddr,
-				   struct stmmac_fpe_cfg *cfg,
-				   u32 num_txq, u32 num_rxq,
-				   bool tx_enable, bool pmac_enable)
-{
-	u32 value;
-
-	if (!tx_enable) {
-		value = readl(ioaddr + XGMAC_FPE_CTRL_STS);
-
-		value &= ~XGMAC_EFPE;
-
-		writel(value, ioaddr + XGMAC_FPE_CTRL_STS);
-		return;
-	}
-
-	value = readl(ioaddr + XGMAC_RXQ_CTRL1);
-	value &= ~XGMAC_RQ;
-	value |= (num_rxq - 1) << XGMAC_RQ_SHIFT;
-	writel(value, ioaddr + XGMAC_RXQ_CTRL1);
-
-	value = readl(ioaddr + XGMAC_FPE_CTRL_STS);
-	value |= XGMAC_EFPE;
-	writel(value, ioaddr + XGMAC_FPE_CTRL_STS);
-}
-
 const struct stmmac_ops dwxgmac210_ops = {
 	.core_init = dwxgmac2_core_init,
 	.set_mac = dwxgmac2_set_mac,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index ea135203ff2e..816b979e72cc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -146,15 +146,6 @@ struct stmmac_channel {
 	u32 index;
 };
 
-/* FPE link-partner hand-shaking mPacket type */
-enum stmmac_mpacket_type {
-	MPACKET_VERIFY = 0,
-	MPACKET_RESPONSE = 1,
-};
-
-#define STMMAC_FPE_MM_MAX_VERIFY_RETRIES	3
-#define STMMAC_FPE_MM_MAX_VERIFY_TIME_MS	128
-
 struct stmmac_fpe_cfg {
 	/* Serialize access to MAC Merge state between ethtool requests
 	 * and link state updates.
@@ -420,7 +411,6 @@ bool stmmac_eee_init(struct stmmac_priv *priv);
 int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt);
 int stmmac_reinit_ringparam(struct net_device *dev, u32 rx_size, u32 tx_size);
 int stmmac_bus_clks_config(struct stmmac_priv *priv, bool enabled);
-void stmmac_fpe_apply(struct stmmac_priv *priv);
 
 static inline bool stmmac_xdp_is_enabled(struct stmmac_priv *priv)
 {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 2a37592a6281..2792a4c6cbcd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -17,9 +17,9 @@
 #include <linux/net_tstamp.h>
 
 #include "stmmac.h"
+#include "stmmac_fpe.h"
 #include "dwmac_dma.h"
 #include "dwxgmac2.h"
-#include "dwmac5.h"
 
 #define REG_SPACE_SIZE	0x1060
 #define GMAC4_REG_SPACE_SIZE	0x116C
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
new file mode 100644
index 000000000000..59e666668ac1
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -0,0 +1,354 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Furong Xu <0x1207@gmail.com>
+ * stmmac FPE(802.3 Qbu) handling
+ */
+#include "stmmac.h"
+#include "stmmac_fpe.h"
+#include "dwmac4.h"
+#include "dwmac5.h"
+#include "dwxgmac2.h"
+
+#define MAC_FPE_CTRL_STS		0x00000234
+#define TRSP				BIT(19)
+#define TVER				BIT(18)
+#define RRSP				BIT(17)
+#define RVER				BIT(16)
+#define SRSP				BIT(2)
+#define SVER				BIT(1)
+#define EFPE				BIT(0)
+
+#define MTL_FPE_CTRL_STS		0x00000c90
+/* Preemption Classification */
+#define DWMAC5_PREEMPTION_CLASS		GENMASK(15, 8)
+/* Additional Fragment Size of preempted frames */
+#define DWMAC5_ADD_FRAG_SZ		GENMASK(1, 0)
+
+#define XGMAC_FPE_CTRL_STS		0x00000280
+#define XGMAC_EFPE			BIT(0)
+
+void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
+{
+	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
+	unsigned long flags;
+
+	timer_shutdown_sync(&fpe_cfg->verify_timer);
+
+	spin_lock_irqsave(&fpe_cfg->lock, flags);
+
+	if (is_up && fpe_cfg->pmac_enabled) {
+		/* VERIFY process requires pmac enabled when NIC comes up */
+		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
+				     priv->plat->tx_queues_to_use,
+				     priv->plat->rx_queues_to_use,
+				     false, true);
+
+		/* New link => maybe new partner => new verification process */
+		stmmac_fpe_apply(priv);
+	} else {
+		/* No link => turn off EFPE */
+		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
+				     priv->plat->tx_queues_to_use,
+				     priv->plat->rx_queues_to_use,
+				     false, false);
+	}
+
+	spin_unlock_irqrestore(&fpe_cfg->lock, flags);
+}
+
+void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
+			     enum stmmac_mpacket_type type)
+{
+	u32 value = cfg->fpe_csr;
+
+	if (type == MPACKET_VERIFY)
+		value |= SVER;
+	else if (type == MPACKET_RESPONSE)
+		value |= SRSP;
+
+	writel(value, ioaddr + MAC_FPE_CTRL_STS);
+}
+
+void stmmac_fpe_event_status(struct stmmac_priv *priv, int status)
+{
+	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
+
+	/* This is interrupt context, just spin_lock() */
+	spin_lock(&fpe_cfg->lock);
+
+	if (!fpe_cfg->pmac_enabled || status == FPE_EVENT_UNKNOWN)
+		goto unlock_out;
+
+	/* LP has sent verify mPacket */
+	if ((status & FPE_EVENT_RVER) == FPE_EVENT_RVER)
+		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
+					MPACKET_RESPONSE);
+
+	/* Local has sent verify mPacket */
+	if ((status & FPE_EVENT_TVER) == FPE_EVENT_TVER &&
+	    fpe_cfg->status != ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED)
+		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_VERIFYING;
+
+	/* LP has sent response mPacket */
+	if ((status & FPE_EVENT_RRSP) == FPE_EVENT_RRSP &&
+	    fpe_cfg->status == ETHTOOL_MM_VERIFY_STATUS_VERIFYING)
+		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
+
+unlock_out:
+	spin_unlock(&fpe_cfg->lock);
+}
+
+/**
+ * stmmac_fpe_verify_timer - Timer for MAC Merge verification
+ * @t:  timer_list struct containing private info
+ *
+ * Verify the MAC Merge capability in the local TX direction, by
+ * transmitting Verify mPackets up to 3 times. Wait until link
+ * partner responds with a Response mPacket, otherwise fail.
+ */
+static void stmmac_fpe_verify_timer(struct timer_list *t)
+{
+	struct stmmac_fpe_cfg *fpe_cfg = from_timer(fpe_cfg, t, verify_timer);
+	struct stmmac_priv *priv = container_of(fpe_cfg, struct stmmac_priv,
+						fpe_cfg);
+	unsigned long flags;
+	bool rearm = false;
+
+	spin_lock_irqsave(&fpe_cfg->lock, flags);
+
+	switch (fpe_cfg->status) {
+	case ETHTOOL_MM_VERIFY_STATUS_INITIAL:
+	case ETHTOOL_MM_VERIFY_STATUS_VERIFYING:
+		if (fpe_cfg->verify_retries != 0) {
+			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
+						fpe_cfg, MPACKET_VERIFY);
+			rearm = true;
+		} else {
+			fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
+		}
+
+		fpe_cfg->verify_retries--;
+		break;
+
+	case ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED:
+		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
+				     priv->plat->tx_queues_to_use,
+				     priv->plat->rx_queues_to_use,
+				     true, true);
+		break;
+
+	default:
+		break;
+	}
+
+	if (rearm) {
+		mod_timer(&fpe_cfg->verify_timer,
+			  jiffies + msecs_to_jiffies(fpe_cfg->verify_time));
+	}
+
+	spin_unlock_irqrestore(&fpe_cfg->lock, flags);
+}
+
+static void stmmac_fpe_verify_timer_arm(struct stmmac_fpe_cfg *fpe_cfg)
+{
+	if (fpe_cfg->pmac_enabled && fpe_cfg->tx_enabled &&
+	    fpe_cfg->verify_enabled &&
+	    fpe_cfg->status != ETHTOOL_MM_VERIFY_STATUS_FAILED &&
+	    fpe_cfg->status != ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED) {
+		timer_setup(&fpe_cfg->verify_timer, stmmac_fpe_verify_timer, 0);
+		mod_timer(&fpe_cfg->verify_timer, jiffies);
+	}
+}
+
+void stmmac_fpe_init(struct stmmac_priv *priv)
+{
+	priv->fpe_cfg.verify_retries = STMMAC_FPE_MM_MAX_VERIFY_RETRIES;
+	priv->fpe_cfg.verify_time = STMMAC_FPE_MM_MAX_VERIFY_TIME_MS;
+	priv->fpe_cfg.status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
+	timer_setup(&priv->fpe_cfg.verify_timer, stmmac_fpe_verify_timer, 0);
+	spin_lock_init(&priv->fpe_cfg.lock);
+}
+
+void stmmac_fpe_apply(struct stmmac_priv *priv)
+{
+	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
+
+	/* If verification is disabled, configure FPE right away.
+	 * Otherwise let the timer code do it.
+	 */
+	if (!fpe_cfg->verify_enabled) {
+		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
+				     priv->plat->tx_queues_to_use,
+				     priv->plat->rx_queues_to_use,
+				     fpe_cfg->tx_enabled,
+				     fpe_cfg->pmac_enabled);
+	} else {
+		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_INITIAL;
+		fpe_cfg->verify_retries = STMMAC_FPE_MM_MAX_VERIFY_RETRIES;
+
+		if (netif_running(priv->dev))
+			stmmac_fpe_verify_timer_arm(fpe_cfg);
+	}
+}
+
+void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
+			  u32 num_txq, u32 num_rxq,
+			  bool tx_enable, bool pmac_enable)
+{
+	u32 value;
+
+	if (tx_enable) {
+		cfg->fpe_csr = EFPE;
+		value = readl(ioaddr + GMAC_RXQ_CTRL1);
+		value &= ~GMAC_RXQCTRL_FPRQ;
+		value |= (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
+		writel(value, ioaddr + GMAC_RXQ_CTRL1);
+	} else {
+		cfg->fpe_csr = 0;
+	}
+	writel(cfg->fpe_csr, ioaddr + MAC_FPE_CTRL_STS);
+
+	value = readl(ioaddr + GMAC_INT_EN);
+
+	if (pmac_enable) {
+		if (!(value & GMAC_INT_FPE_EN)) {
+			/* Dummy read to clear any pending masked interrupts */
+			readl(ioaddr + MAC_FPE_CTRL_STS);
+
+			value |= GMAC_INT_FPE_EN;
+		}
+	} else {
+		value &= ~GMAC_INT_FPE_EN;
+	}
+
+	writel(value, ioaddr + GMAC_INT_EN);
+}
+
+int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
+{
+	u32 value;
+	int status;
+
+	status = FPE_EVENT_UNKNOWN;
+
+	/* Reads from the MAC_FPE_CTRL_STS register should only be performed
+	 * here, since the status flags of MAC_FPE_CTRL_STS are "clear on read"
+	 */
+	value = readl(ioaddr + MAC_FPE_CTRL_STS);
+
+	if (value & TRSP) {
+		status |= FPE_EVENT_TRSP;
+		netdev_dbg(dev, "FPE: Respond mPacket is transmitted\n");
+	}
+
+	if (value & TVER) {
+		status |= FPE_EVENT_TVER;
+		netdev_dbg(dev, "FPE: Verify mPacket is transmitted\n");
+	}
+
+	if (value & RRSP) {
+		status |= FPE_EVENT_RRSP;
+		netdev_dbg(dev, "FPE: Respond mPacket is received\n");
+	}
+
+	if (value & RVER) {
+		status |= FPE_EVENT_RVER;
+		netdev_dbg(dev, "FPE: Verify mPacket is received\n");
+	}
+
+	return status;
+}
+
+int dwmac5_fpe_get_add_frag_size(const void __iomem *ioaddr)
+{
+	return FIELD_GET(DWMAC5_ADD_FRAG_SZ, readl(ioaddr + MTL_FPE_CTRL_STS));
+}
+
+void dwmac5_fpe_set_add_frag_size(void __iomem *ioaddr, u32 add_frag_size)
+{
+	u32 value;
+
+	value = readl(ioaddr + MTL_FPE_CTRL_STS);
+	writel(u32_replace_bits(value, add_frag_size, DWMAC5_ADD_FRAG_SZ),
+	       ioaddr + MTL_FPE_CTRL_STS);
+}
+
+#define ALG_ERR_MSG "TX algorithm SP is not suitable for one-to-many mapping"
+#define WEIGHT_ERR_MSG "TXQ weight %u differs across other TXQs in TC: [%u]"
+
+int dwmac5_fpe_map_preemption_class(struct net_device *ndev,
+				    struct netlink_ext_ack *extack, u32 pclass)
+{
+	u32 val, offset, count, queue_weight, preemptible_txqs = 0;
+	struct stmmac_priv *priv = netdev_priv(ndev);
+	u32 num_tc = ndev->num_tc;
+
+	if (!pclass)
+		goto update_mapping;
+
+	/* DWMAC CORE4+ can not program TC:TXQ mapping to hardware.
+	 *
+	 * Synopsys Databook:
+	 * "The number of Tx DMA channels is equal to the number of Tx queues,
+	 * and is direct one-to-one mapping."
+	 */
+	for (u32 tc = 0; tc < num_tc; tc++) {
+		count = ndev->tc_to_txq[tc].count;
+		offset = ndev->tc_to_txq[tc].offset;
+
+		if (pclass & BIT(tc))
+			preemptible_txqs |= GENMASK(offset + count - 1, offset);
+
+		/* This is 1:1 mapping, go to next TC */
+		if (count == 1)
+			continue;
+
+		if (priv->plat->tx_sched_algorithm == MTL_TX_ALGORITHM_SP) {
+			NL_SET_ERR_MSG_MOD(extack, ALG_ERR_MSG);
+			return -EINVAL;
+		}
+
+		queue_weight = priv->plat->tx_queues_cfg[offset].weight;
+
+		for (u32 i = 1; i < count; i++) {
+			if (priv->plat->tx_queues_cfg[offset + i].weight !=
+			    queue_weight) {
+				NL_SET_ERR_MSG_FMT_MOD(extack, WEIGHT_ERR_MSG,
+						       queue_weight, tc);
+				return -EINVAL;
+			}
+		}
+	}
+
+update_mapping:
+	val = readl(priv->ioaddr + MTL_FPE_CTRL_STS);
+	writel(u32_replace_bits(val, preemptible_txqs, DWMAC5_PREEMPTION_CLASS),
+	       priv->ioaddr + MTL_FPE_CTRL_STS);
+
+	return 0;
+}
+
+void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
+			    u32 num_txq, u32 num_rxq,
+			    bool tx_enable, bool pmac_enable)
+{
+	u32 value;
+
+	if (!tx_enable) {
+		value = readl(ioaddr + XGMAC_FPE_CTRL_STS);
+
+		value &= ~XGMAC_EFPE;
+
+		writel(value, ioaddr + XGMAC_FPE_CTRL_STS);
+		return;
+	}
+
+	value = readl(ioaddr + XGMAC_RXQ_CTRL1);
+	value &= ~XGMAC_RQ;
+	value |= (num_rxq - 1) << XGMAC_RQ_SHIFT;
+	writel(value, ioaddr + XGMAC_RXQ_CTRL1);
+
+	value = readl(ioaddr + XGMAC_FPE_CTRL_STS);
+	value |= XGMAC_EFPE;
+	writel(value, ioaddr + XGMAC_FPE_CTRL_STS);
+}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
new file mode 100644
index 000000000000..25725fd5182f
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 Furong Xu <0x1207@gmail.com>
+ * stmmac FPE(802.3 Qbu) handling
+ */
+#ifndef _STMMAC_FPE_H_
+#define _STMMAC_FPE_H_
+
+#include <linux/types.h>
+#include <linux/netdevice.h>
+
+#define STMMAC_FPE_MM_MAX_VERIFY_RETRIES	3
+#define STMMAC_FPE_MM_MAX_VERIFY_TIME_MS	128
+
+/* FPE link-partner hand-shaking mPacket type */
+enum stmmac_mpacket_type {
+	MPACKET_VERIFY = 0,
+	MPACKET_RESPONSE = 1,
+};
+
+struct stmmac_priv;
+struct stmmac_fpe_cfg;
+
+void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up);
+void stmmac_fpe_event_status(struct stmmac_priv *priv, int status);
+void stmmac_fpe_init(struct stmmac_priv *priv);
+void stmmac_fpe_apply(struct stmmac_priv *priv);
+
+void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
+			  u32 num_txq, u32 num_rxq,
+			  bool tx_enable, bool pmac_enable);
+void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
+			     struct stmmac_fpe_cfg *cfg,
+			     enum stmmac_mpacket_type type);
+int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev);
+int dwmac5_fpe_get_add_frag_size(const void __iomem *ioaddr);
+void dwmac5_fpe_set_add_frag_size(void __iomem *ioaddr, u32 add_frag_size);
+int dwmac5_fpe_map_preemption_class(struct net_device *ndev,
+				    struct netlink_ext_ack *extack, u32 pclass);
+
+void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
+			    u32 num_txq, u32 num_rxq,
+			    bool tx_enable, bool pmac_enable);
+
+#endif
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d3895d7eecfc..ab547430a717 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -43,6 +43,7 @@
 #include <net/pkt_cls.h>
 #include <net/xdp_sock_drv.h>
 #include "stmmac_ptp.h"
+#include "stmmac_fpe.h"
 #include "stmmac.h"
 #include "stmmac_xdp.h"
 #include <linux/reset.h>
@@ -966,35 +967,6 @@ static void stmmac_mac_config(struct phylink_config *config, unsigned int mode,
 	/* Nothing to do, xpcs_config() handles everything */
 }
 
-static void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
-{
-	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
-	unsigned long flags;
-
-	timer_shutdown_sync(&fpe_cfg->verify_timer);
-
-	spin_lock_irqsave(&fpe_cfg->lock, flags);
-
-	if (is_up && fpe_cfg->pmac_enabled) {
-		/* VERIFY process requires pmac enabled when NIC comes up */
-		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
-				     priv->plat->tx_queues_to_use,
-				     priv->plat->rx_queues_to_use,
-				     false, true);
-
-		/* New link => maybe new partner => new verification process */
-		stmmac_fpe_apply(priv);
-	} else {
-		/* No link => turn off EFPE */
-		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
-				     priv->plat->tx_queues_to_use,
-				     priv->plat->rx_queues_to_use,
-				     false, false);
-	}
-
-	spin_unlock_irqrestore(&fpe_cfg->lock, flags);
-}
-
 static void stmmac_mac_link_down(struct phylink_config *config,
 				 unsigned int mode, phy_interface_t interface)
 {
@@ -5953,35 +5925,6 @@ static int stmmac_set_features(struct net_device *netdev,
 	return 0;
 }
 
-static void stmmac_fpe_event_status(struct stmmac_priv *priv, int status)
-{
-	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
-
-	/* This is interrupt context, just spin_lock() */
-	spin_lock(&fpe_cfg->lock);
-
-	if (!fpe_cfg->pmac_enabled || status == FPE_EVENT_UNKNOWN)
-		goto unlock_out;
-
-	/* LP has sent verify mPacket */
-	if ((status & FPE_EVENT_RVER) == FPE_EVENT_RVER)
-		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
-					MPACKET_RESPONSE);
-
-	/* Local has sent verify mPacket */
-	if ((status & FPE_EVENT_TVER) == FPE_EVENT_TVER &&
-	    fpe_cfg->status != ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED)
-		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_VERIFYING;
-
-	/* LP has sent response mPacket */
-	if ((status & FPE_EVENT_RRSP) == FPE_EVENT_RRSP &&
-	    fpe_cfg->status == ETHTOOL_MM_VERIFY_STATUS_VERIFYING)
-		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
-
-unlock_out:
-	spin_unlock(&fpe_cfg->lock);
-}
-
 static void stmmac_common_interrupt(struct stmmac_priv *priv)
 {
 	u32 rx_cnt = priv->plat->rx_queues_to_use;
@@ -7337,90 +7280,6 @@ int stmmac_reinit_ringparam(struct net_device *dev, u32 rx_size, u32 tx_size)
 	return ret;
 }
 
-/**
- * stmmac_fpe_verify_timer - Timer for MAC Merge verification
- * @t:  timer_list struct containing private info
- *
- * Verify the MAC Merge capability in the local TX direction, by
- * transmitting Verify mPackets up to 3 times. Wait until link
- * partner responds with a Response mPacket, otherwise fail.
- */
-static void stmmac_fpe_verify_timer(struct timer_list *t)
-{
-	struct stmmac_fpe_cfg *fpe_cfg = from_timer(fpe_cfg, t, verify_timer);
-	struct stmmac_priv *priv = container_of(fpe_cfg, struct stmmac_priv,
-						fpe_cfg);
-	unsigned long flags;
-	bool rearm = false;
-
-	spin_lock_irqsave(&fpe_cfg->lock, flags);
-
-	switch (fpe_cfg->status) {
-	case ETHTOOL_MM_VERIFY_STATUS_INITIAL:
-	case ETHTOOL_MM_VERIFY_STATUS_VERIFYING:
-		if (fpe_cfg->verify_retries != 0) {
-			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
-						fpe_cfg, MPACKET_VERIFY);
-			rearm = true;
-		} else {
-			fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
-		}
-
-		fpe_cfg->verify_retries--;
-		break;
-
-	case ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED:
-		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
-				     priv->plat->tx_queues_to_use,
-				     priv->plat->rx_queues_to_use,
-				     true, true);
-		break;
-
-	default:
-		break;
-	}
-
-	if (rearm) {
-		mod_timer(&fpe_cfg->verify_timer,
-			  jiffies + msecs_to_jiffies(fpe_cfg->verify_time));
-	}
-
-	spin_unlock_irqrestore(&fpe_cfg->lock, flags);
-}
-
-static void stmmac_fpe_verify_timer_arm(struct stmmac_fpe_cfg *fpe_cfg)
-{
-	if (fpe_cfg->pmac_enabled && fpe_cfg->tx_enabled &&
-	    fpe_cfg->verify_enabled &&
-	    fpe_cfg->status != ETHTOOL_MM_VERIFY_STATUS_FAILED &&
-	    fpe_cfg->status != ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED) {
-		timer_setup(&fpe_cfg->verify_timer, stmmac_fpe_verify_timer, 0);
-		mod_timer(&fpe_cfg->verify_timer, jiffies);
-	}
-}
-
-void stmmac_fpe_apply(struct stmmac_priv *priv)
-{
-	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
-
-	/* If verification is disabled, configure FPE right away.
-	 * Otherwise let the timer code do it.
-	 */
-	if (!fpe_cfg->verify_enabled) {
-		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
-				     priv->plat->tx_queues_to_use,
-				     priv->plat->rx_queues_to_use,
-				     fpe_cfg->tx_enabled,
-				     fpe_cfg->pmac_enabled);
-	} else {
-		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_INITIAL;
-		fpe_cfg->verify_retries = STMMAC_FPE_MM_MAX_VERIFY_RETRIES;
-
-		if (netif_running(priv->dev))
-			stmmac_fpe_verify_timer_arm(fpe_cfg);
-	}
-}
-
 static int stmmac_xdp_rx_timestamp(const struct xdp_md *_ctx, u64 *timestamp)
 {
 	const struct stmmac_xdp_buff *ctx = (void *)_ctx;
@@ -7699,11 +7558,7 @@ int stmmac_dvr_probe(struct device *device,
 
 	mutex_init(&priv->lock);
 
-	priv->fpe_cfg.verify_retries = STMMAC_FPE_MM_MAX_VERIFY_RETRIES;
-	priv->fpe_cfg.verify_time = STMMAC_FPE_MM_MAX_VERIFY_TIME_MS;
-	priv->fpe_cfg.status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
-	timer_setup(&priv->fpe_cfg.verify_timer, stmmac_fpe_verify_timer, 0);
-	spin_lock_init(&priv->fpe_cfg.lock);
+	stmmac_fpe_init(priv);
 
 	/* If a specific clk_csr value is passed from the platform
 	 * this means that the CSR Clock Range selection cannot be
-- 
2.34.1


