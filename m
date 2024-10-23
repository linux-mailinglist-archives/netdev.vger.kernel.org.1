Return-Path: <netdev+bounces-138107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B369ABFC5
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 09:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A49F1C23A74
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 07:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A80A1514FB;
	Wed, 23 Oct 2024 07:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhQCiubL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC8A150980;
	Wed, 23 Oct 2024 07:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729667194; cv=none; b=HVVidqWjuwVI0EuBlhTFt+vrT97osE0qR1h2U0K7OeDmFRFC+oXXcAOQcTzMyEjuqZfxPTewi0QTDfoX8gPimCoNnNsuTgHNgerKsCkIJR86bnBDx42HPLym/GhGFOBRKWSvoTwJWKR4BE14Ik5vvRFJOfbJhYCw5QKdKbph7mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729667194; c=relaxed/simple;
	bh=H5lNktqIs7JRp9TiqDKoOqnMM8anHIFZQXcFRUyGAjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=beKDM1LD0CSUKP+7zIY8dI65XD8TQ2rK3yar+4lliYkOub1ux9efPczFx/rkTYr42mbP+klo0a0HCU+f+pJFdpvavrIGDTGz8yCBF60wEKM4zySpK+sHt+sGsrnGc3UPAc7978PIugiVsB6DSyc+ocgb8IEgFyuwgoMNwr7RTwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhQCiubL; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20cbca51687so63749565ad.1;
        Wed, 23 Oct 2024 00:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729667191; x=1730271991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIBIrJmmOF079PuhBlqgSb/089m+AstZBOv3Z1cWfxU=;
        b=NhQCiubL21aItSdVq5SvZ0EzIDCMr6y37YfQgYcPEnatuLBjzBZxl3jGJ02tJneBVy
         TH9WRo/ytNaFaz3aVYOB6YaulWNjr148SeymgjJh6aIvKf4Uol/vfgD/oH0SH/149MeX
         sFmUjg3lhZ4PG7B+XOkuvfxJbp8bJrLf07cYDHluGDlqWQ8SqBTymdTbMRdS8LX3rKwQ
         uyvxqJqI4KrHKfrYfn0yJKaEAD63AO8a5xCg5YsTte+5BFEWtfdrGMx5/jHYugXVA4IT
         25OzcwZVzvtu0f6xj3tJtR6LaOnt0GcRdKGZ7PPiK3PGYCnz4g82ltRhzMM/r2l8TaA6
         WgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729667191; x=1730271991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIBIrJmmOF079PuhBlqgSb/089m+AstZBOv3Z1cWfxU=;
        b=BVptZhvUcsFnPS8W48/Jk5rotu0/1QuIFJSkeNv7RuhhjxCr7GtNx6qY55IzRjcVN0
         Mj+I0KZM+cL8e78evbUNuyWH+czA2G9wFidWW2twPgsP6BwPprNzO6qHqItgHPo9LwYR
         ISn3Q02QUoKWDwJQbARu1JjjnWqYmhYfoF6A1czXRAU9Ik3HiYTeRlUAU1pf8P9nvReB
         xXUgwUB2RvsTLgPAknvGZaKT8qWJZzhaj48LfAAhmxxOv2ZnvlDRvc0hEVsAq9TnF0pw
         3CqhdmuT18plWVDIEu38GG6Ybv6rEPn/+lLDno1RcrHBY8M4GTxkQsg5ArrYR9iZ/oe6
         pTbA==
X-Forwarded-Encrypted: i=1; AJvYcCX33Cms7YydQUTvkYaynCZtLuxnklq15NGW4/b9fmJkbvH6wfQkU9QDHvd+phkAS2uXZzyW8eB4IPgAPr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0P1mRZUxuH26zefxYcZA5RFF9RagjrpFrUTNaWTeehxtXEjT/
	iLlkWN9BRvhfhEK0sy/GA0hpJjFcWHVbP6Sjv/f2OqhSUwsRLMosF03uYg==
X-Google-Smtp-Source: AGHT+IEiivPJroFSBMxgNEdbdQw60N6r6CnZWHYNQgJanTe9ZRebeCkBCteGpEvhtGofmuLzwp6yzg==
X-Received: by 2002:a17:902:e54a:b0:20c:8907:902 with SMTP id d9443c01a7336-20fa9eb5a9bmr18783365ad.49.1729667190414;
        Wed, 23 Oct 2024 00:06:30 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20e7f0c167bsm51981745ad.140.2024.10.23.00.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 00:06:29 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v3 3/6] net: stmmac: Refactor FPE functions to generic version
Date: Wed, 23 Oct 2024 15:05:23 +0800
Message-Id: <4949cb6845b8a4e7c79af4165814fad270459f7b.1729663066.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729663066.git.0x1207@gmail.com>
References: <cover.1729663066.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FPE implementation for DWMAC4 and DWXGMAC differs only for:
1) Offset address of MAC_FPE_CTRL_STS and MTL_FPE_CTRL_STS
2) FPRQ(Frame Preemption Residue Queue) field in MAC_RxQ_Ctrl1
3) Bit offset of Frame Preemption Interrupt Enable

Refactor FPE functions to avoid code duplication.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h  |   1 -
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  10 --
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |   2 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |   2 -
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |   7 +
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  20 +--
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |   1 +
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |   4 +-
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 148 ++++++++++--------
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.h  |  19 +--
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   3 +-
 11 files changed, 107 insertions(+), 110 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
index 28fff6cab812..0c050324997a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -69,7 +69,6 @@
 #define GMAC_RXQCTRL_TACPQE		BIT(21)
 #define GMAC_RXQCTRL_TACPQE_SHIFT	21
 #define GMAC_RXQCTRL_FPRQ		GENMASK(26, 24)
-#define GMAC_RXQCTRL_FPRQ_SHIFT		24
 
 /* MAC Packet Filtering */
 #define GMAC_PACKET_FILTER_PR		BIT(0)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 4d217926820a..c25781874aa7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -1262,11 +1262,6 @@ const struct stmmac_ops dwmac410_ops = {
 	.set_arp_offload = dwmac4_set_arp_offload,
 	.config_l3_filter = dwmac4_config_l3_filter,
 	.config_l4_filter = dwmac4_config_l4_filter,
-	.fpe_configure = dwmac5_fpe_configure,
-	.fpe_send_mpacket = dwmac5_fpe_send_mpacket,
-	.fpe_irq_status = dwmac5_fpe_irq_status,
-	.fpe_get_add_frag_size = dwmac5_fpe_get_add_frag_size,
-	.fpe_set_add_frag_size = dwmac5_fpe_set_add_frag_size,
 	.fpe_map_preemption_class = dwmac5_fpe_map_preemption_class,
 	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
 	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
@@ -1317,11 +1312,6 @@ const struct stmmac_ops dwmac510_ops = {
 	.set_arp_offload = dwmac4_set_arp_offload,
 	.config_l3_filter = dwmac4_config_l3_filter,
 	.config_l4_filter = dwmac4_config_l4_filter,
-	.fpe_configure = dwmac5_fpe_configure,
-	.fpe_send_mpacket = dwmac5_fpe_send_mpacket,
-	.fpe_irq_status = dwmac5_fpe_irq_status,
-	.fpe_get_add_frag_size = dwmac5_fpe_get_add_frag_size,
-	.fpe_set_add_frag_size = dwmac5_fpe_set_add_frag_size,
 	.fpe_map_preemption_class = dwmac5_fpe_map_preemption_class,
 	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
 	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 917796293c26..efd47db05dbc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -85,7 +85,6 @@
 #define XGMAC_MCBCQ			GENMASK(11, 8)
 #define XGMAC_MCBCQ_SHIFT		8
 #define XGMAC_RQ			GENMASK(7, 4)
-#define XGMAC_RQ_SHIFT			4
 #define XGMAC_UPQ			GENMASK(3, 0)
 #define XGMAC_UPQ_SHIFT			0
 #define XGMAC_RXQ_CTRL2			0x000000a8
@@ -96,6 +95,7 @@
 #define XGMAC_LPIIS			BIT(5)
 #define XGMAC_PMTIS			BIT(4)
 #define XGMAC_INT_EN			0x000000b4
+#define XGMAC_FPEIE			BIT(15)
 #define XGMAC_TSIE			BIT(12)
 #define XGMAC_LPIIE			BIT(5)
 #define XGMAC_PMTIE			BIT(4)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 111ba5a524ed..de6ffda31a80 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1545,7 +1545,6 @@ const struct stmmac_ops dwxgmac210_ops = {
 	.config_l3_filter = dwxgmac2_config_l3_filter,
 	.config_l4_filter = dwxgmac2_config_l4_filter,
 	.set_arp_offload = dwxgmac2_set_arp_offload,
-	.fpe_configure = dwxgmac3_fpe_configure,
 };
 
 static void dwxlgmac2_rx_queue_enable(struct mac_device_info *hw, u8 mode,
@@ -1602,7 +1601,6 @@ const struct stmmac_ops dwxlgmac2_ops = {
 	.config_l3_filter = dwxgmac2_config_l3_filter,
 	.config_l4_filter = dwxgmac2_config_l4_filter,
 	.set_arp_offload = dwxgmac2_set_arp_offload,
-	.fpe_configure = dwxgmac3_fpe_configure,
 };
 
 int dwxgmac2_setup(struct stmmac_priv *priv)
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 88cce28b2f98..cfc50289aed6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -6,6 +6,7 @@
 
 #include "common.h"
 #include "stmmac.h"
+#include "stmmac_fpe.h"
 #include "stmmac_ptp.h"
 #include "stmmac_est.h"
 
@@ -185,6 +186,7 @@ static const struct stmmac_hwif_entry {
 			.ptp_off = PTP_GMAC4_OFFSET,
 			.mmc_off = MMC_GMAC4_OFFSET,
 			.est_off = EST_GMAC4_OFFSET,
+			.fpe_reg = &dwmac5_fpe_reg,
 		},
 		.desc = &dwmac4_desc_ops,
 		.dma = &dwmac4_dma_ops,
@@ -205,6 +207,7 @@ static const struct stmmac_hwif_entry {
 			.ptp_off = PTP_GMAC4_OFFSET,
 			.mmc_off = MMC_GMAC4_OFFSET,
 			.est_off = EST_GMAC4_OFFSET,
+			.fpe_reg = &dwmac5_fpe_reg,
 		},
 		.desc = &dwmac4_desc_ops,
 		.dma = &dwmac410_dma_ops,
@@ -225,6 +228,7 @@ static const struct stmmac_hwif_entry {
 			.ptp_off = PTP_GMAC4_OFFSET,
 			.mmc_off = MMC_GMAC4_OFFSET,
 			.est_off = EST_GMAC4_OFFSET,
+			.fpe_reg = &dwmac5_fpe_reg,
 		},
 		.desc = &dwmac4_desc_ops,
 		.dma = &dwmac410_dma_ops,
@@ -246,6 +250,7 @@ static const struct stmmac_hwif_entry {
 			.ptp_off = PTP_XGMAC_OFFSET,
 			.mmc_off = MMC_XGMAC_OFFSET,
 			.est_off = EST_XGMAC_OFFSET,
+			.fpe_reg = &dwxgmac3_fpe_reg,
 		},
 		.desc = &dwxgmac210_desc_ops,
 		.dma = &dwxgmac210_dma_ops,
@@ -267,6 +272,7 @@ static const struct stmmac_hwif_entry {
 			.ptp_off = PTP_XGMAC_OFFSET,
 			.mmc_off = MMC_XGMAC_OFFSET,
 			.est_off = EST_XGMAC_OFFSET,
+			.fpe_reg = &dwxgmac3_fpe_reg,
 		},
 		.desc = &dwxgmac210_desc_ops,
 		.dma = &dwxgmac210_dma_ops,
@@ -353,6 +359,7 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 		mac->est = mac->est ? : entry->est;
 
 		priv->hw = mac;
+		priv->fpe_cfg.reg = entry->regs.fpe_reg;
 		priv->ptpaddr = priv->ioaddr + entry->regs.ptp_off;
 		priv->mmcaddr = priv->ioaddr + entry->regs.mmc_off;
 		if (entry->est)
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index d5a9f01ecac5..64f8ed67dcc4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -420,15 +420,6 @@ struct stmmac_ops {
 				bool en, bool udp, bool sa, bool inv,
 				u32 match);
 	void (*set_arp_offload)(struct mac_device_info *hw, bool en, u32 addr);
-	void (*fpe_configure)(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
-			      u32 num_txq, u32 num_rxq,
-			      bool tx_enable, bool pmac_enable);
-	void (*fpe_send_mpacket)(void __iomem *ioaddr,
-				 struct stmmac_fpe_cfg *cfg,
-				 enum stmmac_mpacket_type type);
-	int (*fpe_irq_status)(void __iomem *ioaddr, struct net_device *dev);
-	int (*fpe_get_add_frag_size)(const void __iomem *ioaddr);
-	void (*fpe_set_add_frag_size)(void __iomem *ioaddr, u32 add_frag_size);
 	int (*fpe_map_preemption_class)(struct net_device *ndev,
 					struct netlink_ext_ack *extack,
 					u32 pclass);
@@ -530,16 +521,6 @@ struct stmmac_ops {
 	stmmac_do_callback(__priv, mac, config_l4_filter, __args)
 #define stmmac_set_arp_offload(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, set_arp_offload, __args)
-#define stmmac_fpe_configure(__priv, __args...) \
-	stmmac_do_void_callback(__priv, mac, fpe_configure, __args)
-#define stmmac_fpe_send_mpacket(__priv, __args...) \
-	stmmac_do_void_callback(__priv, mac, fpe_send_mpacket, __args)
-#define stmmac_fpe_irq_status(__priv, __args...) \
-	stmmac_do_callback(__priv, mac, fpe_irq_status, __args)
-#define stmmac_fpe_get_add_frag_size(__priv, __args...) \
-	stmmac_do_callback(__priv, mac, fpe_get_add_frag_size, __args)
-#define stmmac_fpe_set_add_frag_size(__priv, __args...) \
-	stmmac_do_void_callback(__priv, mac, fpe_set_add_frag_size, __args)
 #define stmmac_fpe_map_preemption_class(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, fpe_map_preemption_class, __args)
 
@@ -678,6 +659,7 @@ struct stmmac_est_ops {
 	stmmac_do_void_callback(__priv, est, irq_status, __args)
 
 struct stmmac_regs_off {
+	const struct stmmac_fpe_reg *fpe_reg;
 	u32 ptp_off;
 	u32 mmc_off;
 	u32 est_off;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 816b979e72cc..1d86439b8a14 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -152,6 +152,7 @@ struct stmmac_fpe_cfg {
 	 */
 	spinlock_t lock;
 
+	const struct stmmac_fpe_reg *reg;
 	u32 fpe_csr;				/* MAC_FPE_CTRL_STS reg cache */
 
 	enum ethtool_mm_verify_status status;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 2792a4c6cbcd..f2783f7c46f3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -1294,7 +1294,7 @@ static int stmmac_get_mm(struct net_device *ndev,
 	else
 		state->tx_active = false;
 
-	frag_size = stmmac_fpe_get_add_frag_size(priv, priv->ioaddr);
+	frag_size = stmmac_fpe_get_add_frag_size(priv);
 	state->tx_min_frag_size = ethtool_mm_frag_size_add_to_min(frag_size);
 
 	spin_unlock_irqrestore(&priv->fpe_cfg.lock, flags);
@@ -1329,7 +1329,7 @@ static int stmmac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
 	if (!cfg->verify_enabled)
 		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
 
-	stmmac_fpe_set_add_frag_size(priv, priv->ioaddr, frag_size);
+	stmmac_fpe_set_add_frag_size(priv, frag_size);
 	stmmac_fpe_apply(priv);
 
 	spin_unlock_irqrestore(&fpe_cfg->lock, flags);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index 70ea475046f0..d2ea941370dc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -27,19 +27,30 @@
 #define STMMAC_MAC_FPE_CTRL_STS_SVER	BIT(1)
 #define STMMAC_MAC_FPE_CTRL_STS_EFPE	BIT(0)
 
+struct stmmac_fpe_reg {
+	const u32 mac_fpe_reg;		/* offset of MAC_FPE_CTRL_STS */
+	const u32 mtl_fpe_reg;		/* offset of MTL_FPE_CTRL_STS */
+	const u32 rxq_ctrl1_reg;	/* offset of MAC_RxQ_Ctrl1 */
+	const u32 fprq_mask;		/* Frame Preemption Residue Queue */
+	const u32 int_en_reg;		/* offset of MAC_Interrupt_Enable */
+	const u32 int_en_bit;		/* Frame Preemption Interrupt Enable */
+};
+
 void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
 {
 	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
 	unsigned long flags;
 
+	if (!priv->dma_cap.fpesel)
+		return;
+
 	timer_shutdown_sync(&fpe_cfg->verify_timer);
 
 	spin_lock_irqsave(&fpe_cfg->lock, flags);
 
 	if (is_up && fpe_cfg->pmac_enabled) {
 		/* VERIFY process requires pmac enabled when NIC comes up */
-		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
-				     priv->plat->tx_queues_to_use,
+		stmmac_fpe_configure(priv, priv->plat->tx_queues_to_use,
 				     priv->plat->rx_queues_to_use,
 				     false, true);
 
@@ -47,8 +58,7 @@ void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
 		stmmac_fpe_apply(priv);
 	} else {
 		/* No link => turn off EFPE */
-		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
-				     priv->plat->tx_queues_to_use,
+		stmmac_fpe_configure(priv, priv->plat->tx_queues_to_use,
 				     priv->plat->rx_queues_to_use,
 				     false, false);
 	}
@@ -68,8 +78,7 @@ void stmmac_fpe_event_status(struct stmmac_priv *priv, int status)
 
 	/* LP has sent verify mPacket */
 	if ((status & FPE_EVENT_RVER) == FPE_EVENT_RVER)
-		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
-					MPACKET_RESPONSE);
+		stmmac_fpe_send_mpacket(priv, MPACKET_RESPONSE);
 
 	/* Local has sent verify mPacket */
 	if ((status & FPE_EVENT_TVER) == FPE_EVENT_TVER &&
@@ -107,8 +116,7 @@ static void stmmac_fpe_verify_timer(struct timer_list *t)
 	case ETHTOOL_MM_VERIFY_STATUS_INITIAL:
 	case ETHTOOL_MM_VERIFY_STATUS_VERIFYING:
 		if (fpe_cfg->verify_retries != 0) {
-			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
-						fpe_cfg, MPACKET_VERIFY);
+			stmmac_fpe_send_mpacket(priv, MPACKET_VERIFY);
 			rearm = true;
 		} else {
 			fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
@@ -118,8 +126,7 @@ static void stmmac_fpe_verify_timer(struct timer_list *t)
 		break;
 
 	case ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED:
-		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
-				     priv->plat->tx_queues_to_use,
+		stmmac_fpe_configure(priv, priv->plat->tx_queues_to_use,
 				     priv->plat->rx_queues_to_use,
 				     true, true);
 		break;
@@ -164,8 +171,7 @@ void stmmac_fpe_apply(struct stmmac_priv *priv)
 	 * Otherwise let the timer code do it.
 	 */
 	if (!fpe_cfg->verify_enabled) {
-		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
-				     priv->plat->tx_queues_to_use,
+		stmmac_fpe_configure(priv, priv->plat->tx_queues_to_use,
 				     priv->plat->rx_queues_to_use,
 				     fpe_cfg->tx_enabled,
 				     fpe_cfg->pmac_enabled);
@@ -178,50 +184,60 @@ void stmmac_fpe_apply(struct stmmac_priv *priv)
 	}
 }
 
-void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
-			  u32 num_txq, u32 num_rxq,
+void stmmac_fpe_configure(struct stmmac_priv *priv, u32 num_txq, u32 num_rxq,
 			  bool tx_enable, bool pmac_enable)
 {
+	struct stmmac_fpe_cfg *cfg = &priv->fpe_cfg;
+	const struct stmmac_fpe_reg *reg = cfg->reg;
+	void __iomem *ioaddr = priv->ioaddr;
 	u32 value;
 
+	if (!reg)
+		return;
+
 	if (tx_enable) {
 		cfg->fpe_csr = STMMAC_MAC_FPE_CTRL_STS_EFPE;
-		value = readl(ioaddr + GMAC_RXQ_CTRL1);
-		value &= ~GMAC_RXQCTRL_FPRQ;
-		value |= (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
-		writel(value, ioaddr + GMAC_RXQ_CTRL1);
+		value = readl(ioaddr + reg->rxq_ctrl1_reg);
+		value &= ~reg->fprq_mask;
+		/* Keep this SHIFT, FIELD_PREP() expects a constant mask :-/ */
+		value |= (num_rxq - 1) << __bf_shf(reg->fprq_mask);
+		writel(value, ioaddr + reg->rxq_ctrl1_reg);
 	} else {
 		cfg->fpe_csr = 0;
 	}
-	writel(cfg->fpe_csr, ioaddr + GMAC5_MAC_FPE_CTRL_STS);
+	writel(cfg->fpe_csr, ioaddr + reg->mac_fpe_reg);
 
-	value = readl(ioaddr + GMAC_INT_EN);
+	value = readl(ioaddr + reg->int_en_reg);
 
 	if (pmac_enable) {
-		if (!(value & GMAC_INT_FPE_EN)) {
+		if (!(value & reg->int_en_bit)) {
 			/* Dummy read to clear any pending masked interrupts */
-			readl(ioaddr + GMAC5_MAC_FPE_CTRL_STS);
+			readl(ioaddr + reg->mac_fpe_reg);
 
-			value |= GMAC_INT_FPE_EN;
+			value |= reg->int_en_bit;
 		}
 	} else {
-		value &= ~GMAC_INT_FPE_EN;
+		value &= ~reg->int_en_bit;
 	}
 
-	writel(value, ioaddr + GMAC_INT_EN);
+	writel(value, ioaddr + reg->int_en_reg);
 }
 
-int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
+int stmmac_fpe_irq_status(struct stmmac_priv *priv)
 {
+	const struct stmmac_fpe_reg *reg = priv->fpe_cfg.reg;
+	void __iomem *ioaddr = priv->ioaddr;
+	struct net_device *dev = priv->dev;
+	int status = FPE_EVENT_UNKNOWN;
 	u32 value;
-	int status;
 
-	status = FPE_EVENT_UNKNOWN;
+	if (!reg)
+		return status;
 
 	/* Reads from the MAC_FPE_CTRL_STS register should only be performed
 	 * here, since the status flags of MAC_FPE_CTRL_STS are "clear on read"
 	 */
-	value = readl(ioaddr + GMAC5_MAC_FPE_CTRL_STS);
+	value = readl(ioaddr + reg->mac_fpe_reg);
 
 	if (value & STMMAC_MAC_FPE_CTRL_STS_TRSP) {
 		status |= FPE_EVENT_TRSP;
@@ -246,32 +262,47 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
 	return status;
 }
 
-void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
+void stmmac_fpe_send_mpacket(struct stmmac_priv *priv,
 			     enum stmmac_mpacket_type type)
 {
-	u32 value = cfg->fpe_csr;
+	const struct stmmac_fpe_reg *reg = priv->fpe_cfg.reg;
+	void __iomem *ioaddr = priv->ioaddr;
+	u32 value = priv->fpe_cfg.fpe_csr;
+
+	if (!reg)
+		return;
 
 	if (type == MPACKET_VERIFY)
 		value |= STMMAC_MAC_FPE_CTRL_STS_SVER;
 	else if (type == MPACKET_RESPONSE)
 		value |= STMMAC_MAC_FPE_CTRL_STS_SRSP;
 
-	writel(value, ioaddr + GMAC5_MAC_FPE_CTRL_STS);
+	writel(value, ioaddr + reg->mac_fpe_reg);
 }
 
-int dwmac5_fpe_get_add_frag_size(const void __iomem *ioaddr)
+int stmmac_fpe_get_add_frag_size(struct stmmac_priv *priv)
 {
-	return FIELD_GET(FPE_MTL_ADD_FRAG_SZ,
-			 readl(ioaddr + GMAC5_MTL_FPE_CTRL_STS));
+	const struct stmmac_fpe_reg *reg = priv->fpe_cfg.reg;
+	void __iomem *ioaddr = priv->ioaddr;
+
+	if (!reg)
+		return 0;
+
+	return FIELD_GET(FPE_MTL_ADD_FRAG_SZ, readl(ioaddr + reg->mtl_fpe_reg));
 }
 
-void dwmac5_fpe_set_add_frag_size(void __iomem *ioaddr, u32 add_frag_size)
+void stmmac_fpe_set_add_frag_size(struct stmmac_priv *priv, u32 add_frag_size)
 {
+	const struct stmmac_fpe_reg *reg = priv->fpe_cfg.reg;
+	void __iomem *ioaddr = priv->ioaddr;
 	u32 value;
 
-	value = readl(ioaddr + GMAC5_MTL_FPE_CTRL_STS);
+	if (!reg)
+		return;
+
+	value = readl(ioaddr + reg->mtl_fpe_reg);
 	writel(u32_replace_bits(value, add_frag_size, FPE_MTL_ADD_FRAG_SZ),
-	       ioaddr + GMAC5_MTL_FPE_CTRL_STS);
+	       ioaddr + reg->mtl_fpe_reg);
 }
 
 #define ALG_ERR_MSG "TX algorithm SP is not suitable for one-to-many mapping"
@@ -329,27 +360,20 @@ int dwmac5_fpe_map_preemption_class(struct net_device *ndev,
 	return 0;
 }
 
-void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
-			    u32 num_txq, u32 num_rxq,
-			    bool tx_enable, bool pmac_enable)
-{
-	u32 value;
-
-	if (!tx_enable) {
-		value = readl(ioaddr + XGMAC_MAC_FPE_CTRL_STS);
-
-		value &= ~STMMAC_MAC_FPE_CTRL_STS_EFPE;
-
-		writel(value, ioaddr + XGMAC_MAC_FPE_CTRL_STS);
-		return;
-	}
-
-	value = readl(ioaddr + XGMAC_RXQ_CTRL1);
-	value &= ~XGMAC_RQ;
-	value |= (num_rxq - 1) << XGMAC_RQ_SHIFT;
-	writel(value, ioaddr + XGMAC_RXQ_CTRL1);
-
-	value = readl(ioaddr + XGMAC_MAC_FPE_CTRL_STS);
-	value |= STMMAC_MAC_FPE_CTRL_STS_EFPE;
-	writel(value, ioaddr + XGMAC_MAC_FPE_CTRL_STS);
-}
+const struct stmmac_fpe_reg dwmac5_fpe_reg = {
+	.mac_fpe_reg = GMAC5_MAC_FPE_CTRL_STS,
+	.mtl_fpe_reg = GMAC5_MTL_FPE_CTRL_STS,
+	.rxq_ctrl1_reg = GMAC_RXQ_CTRL1,
+	.fprq_mask = GMAC_RXQCTRL_FPRQ,
+	.int_en_reg = GMAC_INT_EN,
+	.int_en_bit = GMAC_INT_FPE_EN,
+};
+
+const struct stmmac_fpe_reg dwxgmac3_fpe_reg = {
+	.mac_fpe_reg = XGMAC_MAC_FPE_CTRL_STS,
+	.mtl_fpe_reg = XGMAC_MTL_FPE_CTRL_STS,
+	.rxq_ctrl1_reg = XGMAC_RXQ_CTRL1,
+	.fprq_mask = XGMAC_RQ,
+	.int_en_reg = XGMAC_INT_EN,
+	.int_en_bit = XGMAC_FPEIE,
+};
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
index 25725fd5182f..9c7ddf34de24 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
@@ -25,21 +25,18 @@ void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up);
 void stmmac_fpe_event_status(struct stmmac_priv *priv, int status);
 void stmmac_fpe_init(struct stmmac_priv *priv);
 void stmmac_fpe_apply(struct stmmac_priv *priv);
-
-void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
-			  u32 num_txq, u32 num_rxq,
+void stmmac_fpe_configure(struct stmmac_priv *priv, u32 num_txq, u32 num_rxq,
 			  bool tx_enable, bool pmac_enable);
-void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
-			     struct stmmac_fpe_cfg *cfg,
+void stmmac_fpe_send_mpacket(struct stmmac_priv *priv,
 			     enum stmmac_mpacket_type type);
-int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev);
-int dwmac5_fpe_get_add_frag_size(const void __iomem *ioaddr);
-void dwmac5_fpe_set_add_frag_size(void __iomem *ioaddr, u32 add_frag_size);
+int stmmac_fpe_irq_status(struct stmmac_priv *priv);
+int stmmac_fpe_get_add_frag_size(struct stmmac_priv *priv);
+void stmmac_fpe_set_add_frag_size(struct stmmac_priv *priv, u32 add_frag_size);
+
 int dwmac5_fpe_map_preemption_class(struct net_device *ndev,
 				    struct netlink_ext_ack *extack, u32 pclass);
 
-void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
-			    u32 num_txq, u32 num_rxq,
-			    bool tx_enable, bool pmac_enable);
+extern const struct stmmac_fpe_reg dwmac5_fpe_reg;
+extern const struct stmmac_fpe_reg dwxgmac3_fpe_reg;
 
 #endif
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ab547430a717..7874a955ab60 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5944,8 +5944,7 @@ static void stmmac_common_interrupt(struct stmmac_priv *priv)
 				      &priv->xstats, tx_cnt);
 
 	if (priv->dma_cap.fpesel) {
-		int status = stmmac_fpe_irq_status(priv, priv->ioaddr,
-						   priv->dev);
+		int status = stmmac_fpe_irq_status(priv);
 
 		stmmac_fpe_event_status(priv, status);
 	}
-- 
2.34.1


