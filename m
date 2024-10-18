Return-Path: <netdev+bounces-136868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4974B9A35A3
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 08:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3641C215FA
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 06:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778BE18801E;
	Fri, 18 Oct 2024 06:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wr91KH8n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FAA189528;
	Fri, 18 Oct 2024 06:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233610; cv=none; b=uM8LC+faJyaz9Klp7OhMUXblmLQMV2eGdxgnNgyRU4Hwqq3bEFkEA7UQgncqH20qFia6qRSCIedhbbhQ4GbtRXZr/5u3OVumvg41DSQvwi/3k80Q1lmWEBnNFH0YO1Fl8JtxPcymkcOE2SEaROSBRDINTiQ1rc1KfYOtlUu3nqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233610; c=relaxed/simple;
	bh=NX+bdehPA3g2ddnJznmS+IGVWlxcLHfdMJ4YdhSBBN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R+brKDIHPakl6szng2gQzDdZwK67QuvoNofCY/sKSBjU7SfOPpgECnDr2g/URcuS5E2DrjV5iHZ5vhbzcK1Z9xGi8N1cTYhMdmKe65dDnvcbDlk6Ucajabe0Q2YUTZ8zp2YnyfReJv0mBN+cUgUoezysb2bWkY7aK07Zc8dKTbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wr91KH8n; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20ca96a155cso14322625ad.2;
        Thu, 17 Oct 2024 23:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729233607; x=1729838407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHbmAwDjiYOV8KhTiLIYT7cbQ3af1qQULlja7wQ0pPc=;
        b=Wr91KH8n6Jubgbx04lf4FpIp/mTJ20zv+N0f8hEx/V7kC9o9zRFDjVB8598Vfitnb/
         ZD1A5gw26mwz2txvJ2TU5hVMrWWhyjq0tjtikuND3xCb454gYCo79SfC96BGKL0ldxWs
         7NQXobE72TBZubpf+//BaonByPdpkGwT7ACGq9MsuJKypaPHIFm3ftJTjB+MHNeXAKnf
         97ZC8UYixA6Jx/XV0vDySW6ZT+X+CY8PHKtXPXEJPxNV9tZIZgadfKoMTrdYROuEb3nZ
         U8JssXP7UMrZJWBEt94WOQ4FHltt+hL/fUynp1g5SB3zwrz9Ag/XsddgUnyqmeNRCkMs
         HHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729233607; x=1729838407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHbmAwDjiYOV8KhTiLIYT7cbQ3af1qQULlja7wQ0pPc=;
        b=SgcH4r9BdBg176nnvhAYxkYR0BaVP7EmRxEnvTTIbzpg1ZvBLSh9eGBMljIj5XPYNK
         UHArmWjVp1Er133qElJxwgo5qadNhke3ydU4p3mx33qXuWA2u/L96hUjkCpui4pVz9qj
         kyvsfHrgRcW22sgE91tBJ09XMjN8MNbfa/WiicEkikmX3jeobTzd9NMwlyPygfNnQ1uz
         QMonRJq7ty9kQ/boMCjNQ7S09S1Zb9Va7BBPGnstRpDvY+FqukRr2a4kuVWn/wvFY5MW
         s68z7xWSc+dwDLoE3VNlMSVhleQs2F89q5Nbz3RDwoyCJSiOI7C7ggTQ85r8uKsf2rdU
         an9g==
X-Forwarded-Encrypted: i=1; AJvYcCU/8lfHz7269B3UwyWKGYLZ1k8JUxg0eXNl3KxsGh4WsKUKXy6WgqaP4B+aP9VqY7IiXNsJ03OWs5+j/EY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZtj0yRZxWhBO/ftAWqxaymXtvdM3vKba6mV3TJnpyOlbEzH6Z
	wY2Hw+TvW/++83jTVj/De74teVpvuxkuWeiY7a0NRFPcIgnKt+jG3AIj2w==
X-Google-Smtp-Source: AGHT+IFJiPh28oIYkpyq/B5bxlxch6Jn09s9zfWCZDUfIpcfJRP3Ty80z+SZO0AQd3F0RY7s3L620w==
X-Received: by 2002:a17:902:f70f:b0:20b:8ef3:67a with SMTP id d9443c01a7336-20e5a70d30bmr20302425ad.7.1729233607153;
        Thu, 17 Oct 2024 23:40:07 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20e5a74766fsm6285455ad.73.2024.10.17.23.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 23:40:06 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v2 4/8] net: stmmac: Refactor stmmac_fpe_ops functions for reuse
Date: Fri, 18 Oct 2024 14:39:10 +0800
Message-Id: <fb21d9e693b10ef59d96355e2152b401e4bd75a8.1729233020.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729233020.git.0x1207@gmail.com>
References: <cover.1729233020.git.0x1207@gmail.com>
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

Refactor stmmac_fpe_ops function callbacks to avoid code duplication
between gmac4 and xgmac.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 78 ++++++++++++++-----
 1 file changed, 59 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index 0aa30e302dd8..8ac9aff101e8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -9,6 +9,15 @@
 #include "dwmac5.h"
 #include "dwxgmac2.h"
 
+struct stmmac_fpe_configure_info {
+	const u32 rxq_ctrl1_reg;	/* offset of MAC_RxQ_Ctrl1 */
+	const u32 fprq_mask;		/* Frame Preemption Residue Queue */
+	const u32 fprq_shift;
+	const u32 mac_fpe_reg;		/* offset of MAC_FPE_CTRL_STS */
+	const u32 int_en_reg;		/* offset of MAC_Interrupt_Enable */
+	const u32 int_en_bit;		/* Frame Preemption Interrupt Enable */
+};
+
 void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
 {
 	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
@@ -160,41 +169,42 @@ void stmmac_fpe_apply(struct stmmac_priv *priv)
 	}
 }
 
-static void dwmac5_fpe_configure(void __iomem *ioaddr,
-				 struct stmmac_fpe_cfg *cfg,
-				 u32 num_txq, u32 num_rxq,
-				 bool tx_enable, bool pmac_enable)
+static void common_fpe_configure(void __iomem *ioaddr,
+				 struct stmmac_fpe_cfg *cfg, u32 num_rxq,
+				 bool tx_enable, bool pmac_enable,
+				 const struct stmmac_fpe_configure_info *info)
 {
 	u32 value;
 
 	if (tx_enable) {
 		cfg->fpe_csr = STMMAC_MAC_FPE_CTRL_STS_EFPE;
-		value = readl(ioaddr + GMAC_RXQ_CTRL1);
-		value &= ~GMAC_RXQCTRL_FPRQ;
-		value |= (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
-		writel(value, ioaddr + GMAC_RXQ_CTRL1);
+		value = readl(ioaddr + info->rxq_ctrl1_reg);
+		value &= ~info->fprq_mask;
+		/* Keep this SHIFT, FIELD_PREP() expects a constant mask :-/ */
+		value |= (num_rxq - 1) << info->fprq_shift;
+		writel(value, ioaddr + info->rxq_ctrl1_reg);
 	} else {
 		cfg->fpe_csr = 0;
 	}
-	writel(cfg->fpe_csr, ioaddr + GMAC5_MAC_FPE_CTRL_STS);
+	writel(cfg->fpe_csr, ioaddr + info->mac_fpe_reg);
 
-	value = readl(ioaddr + GMAC_INT_EN);
+	value = readl(ioaddr + info->int_en_reg);
 
 	if (pmac_enable) {
-		if (!(value & GMAC_INT_FPE_EN)) {
+		if (!(value & info->int_en_bit)) {
 			/* Dummy read to clear any pending masked interrupts */
-			readl(ioaddr + GMAC5_MAC_FPE_CTRL_STS);
+			readl(ioaddr + info->mac_fpe_reg);
 
-			value |= GMAC_INT_FPE_EN;
+			value |= info->int_en_bit;
 		}
 	} else {
-		value &= ~GMAC_INT_FPE_EN;
+		value &= ~info->int_en_bit;
 	}
 
-	writel(value, ioaddr + GMAC_INT_EN);
+	writel(value, ioaddr + info->int_en_reg);
 }
 
-static int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
+static int common_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
 {
 	u32 value;
 	int status;
@@ -204,7 +214,7 @@ static int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
 	/* Reads from the MAC_FPE_CTRL_STS register should only be performed
 	 * here, since the status flags of MAC_FPE_CTRL_STS are "clear on read"
 	 */
-	value = readl(ioaddr + GMAC5_MAC_FPE_CTRL_STS);
+	value = readl(ioaddr);
 
 	if (value & STMMAC_MAC_FPE_CTRL_STS_TRSP) {
 		status |= FPE_EVENT_TRSP;
@@ -229,7 +239,7 @@ static int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
 	return status;
 }
 
-static void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
+static void common_fpe_send_mpacket(void __iomem *ioaddr,
 				    struct stmmac_fpe_cfg *cfg,
 				    enum stmmac_mpacket_type type)
 {
@@ -240,7 +250,37 @@ static void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
 	else if (type == MPACKET_RESPONSE)
 		value |= STMMAC_MAC_FPE_CTRL_STS_SRSP;
 
-	writel(value, ioaddr + GMAC5_MAC_FPE_CTRL_STS);
+	writel(value, ioaddr);
+}
+
+static void dwmac5_fpe_configure(void __iomem *ioaddr,
+				 struct stmmac_fpe_cfg *cfg,
+				 u32 num_txq, u32 num_rxq,
+				 bool tx_enable, bool pmac_enable)
+{
+	static const struct stmmac_fpe_configure_info dwmac5_fpe_info = {
+		.rxq_ctrl1_reg = GMAC_RXQ_CTRL1,
+		.fprq_mask = GMAC_RXQCTRL_FPRQ,
+		.fprq_shift = GMAC_RXQCTRL_FPRQ_SHIFT,
+		.mac_fpe_reg = GMAC5_MAC_FPE_CTRL_STS,
+		.int_en_reg = GMAC_INT_EN,
+		.int_en_bit = GMAC_INT_FPE_EN,
+	};
+
+	common_fpe_configure(ioaddr, cfg, num_rxq, tx_enable, pmac_enable,
+			     &dwmac5_fpe_info);
+}
+
+static int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
+{
+	return common_fpe_irq_status(ioaddr + GMAC5_MAC_FPE_CTRL_STS, dev);
+}
+
+static void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
+				    struct stmmac_fpe_cfg *cfg,
+				    enum stmmac_mpacket_type type)
+{
+	common_fpe_send_mpacket(ioaddr + GMAC5_MAC_FPE_CTRL_STS, cfg, type);
 }
 
 static int dwmac5_fpe_get_add_frag_size(const void __iomem *ioaddr)
-- 
2.34.1


