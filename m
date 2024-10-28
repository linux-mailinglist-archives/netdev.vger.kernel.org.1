Return-Path: <netdev+bounces-139419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B359B236A
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 04:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECC8AB2126E
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 03:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D038C189BA2;
	Mon, 28 Oct 2024 03:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYJAUaKi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CE6189913;
	Mon, 28 Oct 2024 03:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730084882; cv=none; b=bNPUZ6NJYhLUJEf29ZwtO3ozRGHXl02OMZA/qN0Le+OgOp/o7MTz6I0AqDw5hkvAowEAoUfZ0nHtLYkpXhQiNnfGKenGqr+qk0dahuoQ0w8hrqwSi1u19jQwAkpbQEKL2MuPFXquJZX46cOKDzhOL/u1tB+3k0C7gnryV8baRGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730084882; c=relaxed/simple;
	bh=BuUgnL7h54rr2A/6ZDugxxWbzzOBYluHx6W8EmCTMgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ofy/W4wsiaDo51w1whsh9qKP6gtakyX0uEaanMdjEVRCZVhqSlcbrN0Jt+1H1nTIj8NG8yz5+fxFNrpEwsjY20GEVflbjwr3mNuInxvS93cSSsSOWzxXPXmcYhsdnn4X2WOIRaBBIMEBXClDABxlxuET67tH7FcQNuTw+K0hy7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYJAUaKi; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20cb89a4e4cso25072235ad.3;
        Sun, 27 Oct 2024 20:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730084878; x=1730689678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikOu3ozG9IaIbT4Vvh+Yk7rtkItRuerAPcX78kzIHYo=;
        b=TYJAUaKiRStF0XHS52kL7qZa+fY/WWezzeolbrMQB+jvDwXtSocpZs3tpzkAvk2GB1
         7GtU+wuDrgVhvsqKLbEG9Oof8qAZ9Uwhwmi1xQxq1bFLJCE4v+GxR25hC0cHLtqB3iHe
         Z4WNyIyEy/CrXcKvGSdciRC/agtctK24uAIWpmSuudW7J27Yc4e3yfTVUoRBo3oAmTPz
         a496e5QqdSV4CU6akP3VHpESrk17PbiWVRqoGMkmxXPGSaFCgutyyZh65hgFa5dBArmE
         e6i7c2JsXBKS3/r600tDwYYj161CeGSNXis8Q5jTRhVND3m2V3P5gFDVJpIoolj9Qov8
         2iYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730084878; x=1730689678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikOu3ozG9IaIbT4Vvh+Yk7rtkItRuerAPcX78kzIHYo=;
        b=v/QpK2k5xztwuecRl3VXAnOIdSHYkmBzUQ/kB6E+9fXuMFBve1NWnLBQzl2a31/62k
         fg27WOxcnKZ0Vw6QqMzbAJiLmdRVeBIJblOhBWMAhYYpdvXIa5SzDtsuY/m4zKc23hW+
         r+KinKqOw+vbb3L34pahi6HttXb99w3uUhOvPnmGpx4w9fXj5Etm34tuCcwHtYN3w4RM
         4o3DbSq3PA7iP1e6D8rPIOE0hhKg1ckDCsPq3PjRDwdBQ4LUS7E3bZawRJkW2mRIu/lG
         VOphNYBFVpsYCgDrR8PFj17bTPEcUL5h9ExT/DCLDz1l2lTjJMAI8ZQaW4xIChVXvWH4
         yUfg==
X-Forwarded-Encrypted: i=1; AJvYcCWMSDx/AuRWQB5klFkrtmCRQaOAWXTk8qL9HxqdZ1O1LOU+MCzfpAnQP3BU1Cl0q0eRwX6nupaZmZsS9k4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCFUBEBibfneiSSuwA8wrfxS3YNrRewh1GXEPVycJWsUSTOO+V
	c0Q1aRk/d8WpHgnhWmIBW/TbvKsDCPMfaw/+RfUDdC5mr1PEGs4wP8QDpA==
X-Google-Smtp-Source: AGHT+IHwr/E7cBYsiB558FY3+bsvh8hsMzFGb5XTNbqOwkYTfBo87w7Uxt5s4u5jzdfrHQvKeWlXig==
X-Received: by 2002:a17:903:2445:b0:20c:bcd8:5ccb with SMTP id d9443c01a7336-210c6c0610amr106464195ad.30.1730084877928;
        Sun, 27 Oct 2024 20:07:57 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-210bbf6d327sm41414155ad.67.2024.10.27.20.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 20:07:57 -0700 (PDT)
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
Subject: [PATCH net-next v5 2/6] net: stmmac: Rework macro definitions for gmac4 and xgmac
Date: Mon, 28 Oct 2024 11:07:25 +0800
Message-Id: <26f690d4f719ce09126aabfe86e4c9443c1ea530.1730084449.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730084449.git.0x1207@gmail.com>
References: <cover.1730084449.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename and add macro definitions to better reuse them in common code.

Signed-off-by: Furong Xu <0x1207@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 77 ++++++++++---------
 1 file changed, 39 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index 0a90e8f0df29..70ea475046f0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -9,23 +9,23 @@
 #include "dwmac5.h"
 #include "dwxgmac2.h"
 
-#define MAC_FPE_CTRL_STS		0x00000234
-#define TRSP				BIT(19)
-#define TVER				BIT(18)
-#define RRSP				BIT(17)
-#define RVER				BIT(16)
-#define SRSP				BIT(2)
-#define SVER				BIT(1)
-#define EFPE				BIT(0)
-
-#define MTL_FPE_CTRL_STS		0x00000c90
+#define GMAC5_MAC_FPE_CTRL_STS		0x00000234
+#define XGMAC_MAC_FPE_CTRL_STS		0x00000280
+
+#define GMAC5_MTL_FPE_CTRL_STS		0x00000c90
+#define XGMAC_MTL_FPE_CTRL_STS		0x00001090
 /* Preemption Classification */
-#define DWMAC5_PREEMPTION_CLASS		GENMASK(15, 8)
+#define FPE_MTL_PREEMPTION_CLASS	GENMASK(15, 8)
 /* Additional Fragment Size of preempted frames */
-#define DWMAC5_ADD_FRAG_SZ		GENMASK(1, 0)
+#define FPE_MTL_ADD_FRAG_SZ		GENMASK(1, 0)
 
-#define XGMAC_FPE_CTRL_STS		0x00000280
-#define XGMAC_EFPE			BIT(0)
+#define STMMAC_MAC_FPE_CTRL_STS_TRSP	BIT(19)
+#define STMMAC_MAC_FPE_CTRL_STS_TVER	BIT(18)
+#define STMMAC_MAC_FPE_CTRL_STS_RRSP	BIT(17)
+#define STMMAC_MAC_FPE_CTRL_STS_RVER	BIT(16)
+#define STMMAC_MAC_FPE_CTRL_STS_SRSP	BIT(2)
+#define STMMAC_MAC_FPE_CTRL_STS_SVER	BIT(1)
+#define STMMAC_MAC_FPE_CTRL_STS_EFPE	BIT(0)
 
 void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
 {
@@ -185,7 +185,7 @@ void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
 	u32 value;
 
 	if (tx_enable) {
-		cfg->fpe_csr = EFPE;
+		cfg->fpe_csr = STMMAC_MAC_FPE_CTRL_STS_EFPE;
 		value = readl(ioaddr + GMAC_RXQ_CTRL1);
 		value &= ~GMAC_RXQCTRL_FPRQ;
 		value |= (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
@@ -193,14 +193,14 @@ void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
 	} else {
 		cfg->fpe_csr = 0;
 	}
-	writel(cfg->fpe_csr, ioaddr + MAC_FPE_CTRL_STS);
+	writel(cfg->fpe_csr, ioaddr + GMAC5_MAC_FPE_CTRL_STS);
 
 	value = readl(ioaddr + GMAC_INT_EN);
 
 	if (pmac_enable) {
 		if (!(value & GMAC_INT_FPE_EN)) {
 			/* Dummy read to clear any pending masked interrupts */
-			readl(ioaddr + MAC_FPE_CTRL_STS);
+			readl(ioaddr + GMAC5_MAC_FPE_CTRL_STS);
 
 			value |= GMAC_INT_FPE_EN;
 		}
@@ -221,24 +221,24 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
 	/* Reads from the MAC_FPE_CTRL_STS register should only be performed
 	 * here, since the status flags of MAC_FPE_CTRL_STS are "clear on read"
 	 */
-	value = readl(ioaddr + MAC_FPE_CTRL_STS);
+	value = readl(ioaddr + GMAC5_MAC_FPE_CTRL_STS);
 
-	if (value & TRSP) {
+	if (value & STMMAC_MAC_FPE_CTRL_STS_TRSP) {
 		status |= FPE_EVENT_TRSP;
 		netdev_dbg(dev, "FPE: Respond mPacket is transmitted\n");
 	}
 
-	if (value & TVER) {
+	if (value & STMMAC_MAC_FPE_CTRL_STS_TVER) {
 		status |= FPE_EVENT_TVER;
 		netdev_dbg(dev, "FPE: Verify mPacket is transmitted\n");
 	}
 
-	if (value & RRSP) {
+	if (value & STMMAC_MAC_FPE_CTRL_STS_RRSP) {
 		status |= FPE_EVENT_RRSP;
 		netdev_dbg(dev, "FPE: Respond mPacket is received\n");
 	}
 
-	if (value & RVER) {
+	if (value & STMMAC_MAC_FPE_CTRL_STS_RVER) {
 		status |= FPE_EVENT_RVER;
 		netdev_dbg(dev, "FPE: Verify mPacket is received\n");
 	}
@@ -252,25 +252,26 @@ void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
 	u32 value = cfg->fpe_csr;
 
 	if (type == MPACKET_VERIFY)
-		value |= SVER;
+		value |= STMMAC_MAC_FPE_CTRL_STS_SVER;
 	else if (type == MPACKET_RESPONSE)
-		value |= SRSP;
+		value |= STMMAC_MAC_FPE_CTRL_STS_SRSP;
 
-	writel(value, ioaddr + MAC_FPE_CTRL_STS);
+	writel(value, ioaddr + GMAC5_MAC_FPE_CTRL_STS);
 }
 
 int dwmac5_fpe_get_add_frag_size(const void __iomem *ioaddr)
 {
-	return FIELD_GET(DWMAC5_ADD_FRAG_SZ, readl(ioaddr + MTL_FPE_CTRL_STS));
+	return FIELD_GET(FPE_MTL_ADD_FRAG_SZ,
+			 readl(ioaddr + GMAC5_MTL_FPE_CTRL_STS));
 }
 
 void dwmac5_fpe_set_add_frag_size(void __iomem *ioaddr, u32 add_frag_size)
 {
 	u32 value;
 
-	value = readl(ioaddr + MTL_FPE_CTRL_STS);
-	writel(u32_replace_bits(value, add_frag_size, DWMAC5_ADD_FRAG_SZ),
-	       ioaddr + MTL_FPE_CTRL_STS);
+	value = readl(ioaddr + GMAC5_MTL_FPE_CTRL_STS);
+	writel(u32_replace_bits(value, add_frag_size, FPE_MTL_ADD_FRAG_SZ),
+	       ioaddr + GMAC5_MTL_FPE_CTRL_STS);
 }
 
 #define ALG_ERR_MSG "TX algorithm SP is not suitable for one-to-many mapping"
@@ -321,9 +322,9 @@ int dwmac5_fpe_map_preemption_class(struct net_device *ndev,
 	}
 
 update_mapping:
-	val = readl(priv->ioaddr + MTL_FPE_CTRL_STS);
-	writel(u32_replace_bits(val, preemptible_txqs, DWMAC5_PREEMPTION_CLASS),
-	       priv->ioaddr + MTL_FPE_CTRL_STS);
+	val = readl(priv->ioaddr + GMAC5_MTL_FPE_CTRL_STS);
+	writel(u32_replace_bits(val, preemptible_txqs, FPE_MTL_PREEMPTION_CLASS),
+	       priv->ioaddr + GMAC5_MTL_FPE_CTRL_STS);
 
 	return 0;
 }
@@ -335,11 +336,11 @@ void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
 	u32 value;
 
 	if (!tx_enable) {
-		value = readl(ioaddr + XGMAC_FPE_CTRL_STS);
+		value = readl(ioaddr + XGMAC_MAC_FPE_CTRL_STS);
 
-		value &= ~XGMAC_EFPE;
+		value &= ~STMMAC_MAC_FPE_CTRL_STS_EFPE;
 
-		writel(value, ioaddr + XGMAC_FPE_CTRL_STS);
+		writel(value, ioaddr + XGMAC_MAC_FPE_CTRL_STS);
 		return;
 	}
 
@@ -348,7 +349,7 @@ void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
 	value |= (num_rxq - 1) << XGMAC_RQ_SHIFT;
 	writel(value, ioaddr + XGMAC_RXQ_CTRL1);
 
-	value = readl(ioaddr + XGMAC_FPE_CTRL_STS);
-	value |= XGMAC_EFPE;
-	writel(value, ioaddr + XGMAC_FPE_CTRL_STS);
+	value = readl(ioaddr + XGMAC_MAC_FPE_CTRL_STS);
+	value |= STMMAC_MAC_FPE_CTRL_STS_EFPE;
+	writel(value, ioaddr + XGMAC_MAC_FPE_CTRL_STS);
 }
-- 
2.34.1


