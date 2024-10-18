Return-Path: <netdev+bounces-136867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A506A9A35A1
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 08:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632C4284E23
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 06:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0854188904;
	Fri, 18 Oct 2024 06:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPpHiS5T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE7318801E;
	Fri, 18 Oct 2024 06:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233604; cv=none; b=pi+G33v3wcqKFQW6gD+LxVAp3QTQ7nmCdz2NHrEO+XYoHLmS1SVPAhUj8LH6uIhkITE2FmMRgHd7hjpLbHQSZSvKDJuJMp8p2eG54IvdhMl7GIfCKdBDjGsFmWlITgRFZ4lml1PvwplRhgRWBJSPKefSAOrrm8RPwmEyNdwL6jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233604; c=relaxed/simple;
	bh=9Ozjgby2cjg3kJkX6K+pIBPvO6K/hT/1CQZmm7vPlSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uQF14DP+uBKuk3An4NemfLYUGl7RUOJRs5XBAX86ClnPbROEeyeaWJZ63Xm08vOAsDvOaH4ZfoE+SCL2LAlhfyfoc4y6XVeJ5ZmbyJMnxkHZT1W+g9aXQTGuG4OjW9hFJxzoe7Qf3sxEiAEE+lchWf1YriQIxLKjD13jBzHFtn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPpHiS5T; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c805a0753so15005365ad.0;
        Thu, 17 Oct 2024 23:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729233601; x=1729838401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJBrMWadSURgW3lrGPFAUIV2ihBDIP0p4IQDH1u3f8Y=;
        b=SPpHiS5T0sLrVErw+OOIkwcs5qwynGqvz2n5xtrKFfgBpdzSqqY1GFrLfk3esaTLjj
         6Q5P3wEdsX7MADUvbnQ8lIjgKpzMSFbTCyLE5m5dLU0sBs3ynn27TSML+mBgyKMP2aCE
         AbRLwGtNATEVvyfLvcxJ9Gshg6VywQ0lSbLUi0a3Inp0G7heb62EUxHsEwWpj3RALsni
         R4SP03wkWuHJV07ejdlAvVMDw6nkM1jwbviZe8i/x3moSvQxRwtZrCc/S/GE6BASKJ6x
         pFk3JAdtIV6BfFTJNhzQGAQpE3KcfOPW7yzIUtnpigWgCbL6EczjfweTShu27b8pNQ5v
         OKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729233601; x=1729838401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJBrMWadSURgW3lrGPFAUIV2ihBDIP0p4IQDH1u3f8Y=;
        b=Y79bVTLmd+gUU437qyUK+YDd00+ZyK0yLd+tgs5bpI+ToEdVfHPDBwkDi5HZU6bxm4
         uC5p32nVX8AjH2BZ8vNykc5PF1D41XVHLpNVqRsQVwIGHJokDPyDM+ucxsTDywcNFcKF
         R8jJLEvYVYNJNqmcpqyUJ782/0i/4Y+k5YMqmFnM55LwLNajD6LkbVk+d5I1gXvaEVQb
         dz+gTOGgBzUHjuRW43YArzv5kiHDKdxP+I2BSWJrhUm4yEcJdiGhEviCvDES1NuJj0e6
         VpnBuhU67PV1qa0CN/6cgsuypkl7YaVl+ysIiCuwUwPbAx78ctVZSP3WNZ/if42JECBK
         jysA==
X-Forwarded-Encrypted: i=1; AJvYcCVkJcWhuW7RQACUC8vou/h5QGoHVPQA9zGVdZ3WP9aoTh8Yv8McMNnYnC7iQMMFnkvwMw9NTttirMMYXcY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8guwdf3HU6DWPk4H6ImoXJ1CTLcGSZwH72u5i+e/WyxzmqW6+
	5X5FWYK8dAxLDRtoV+smSQzEUiuomgE8gEhIL8usKv2WrDZ2H+lNrr17Uw==
X-Google-Smtp-Source: AGHT+IGsS874WnrFtUOTPyI4Qn/agw3rFHyEhGOMETNbdgrhODcOysO8jwRtZw8mC/mIDifBqviXww==
X-Received: by 2002:a17:902:dac7:b0:20c:5bf8:bd6e with SMTP id d9443c01a7336-20e5a8fb30amr19403765ad.48.1729233601438;
        Thu, 17 Oct 2024 23:40:01 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20e5a74766fsm6285455ad.73.2024.10.17.23.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 23:40:00 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/8] net: stmmac: Rework macro definitions for gmac4 and xgmac
Date: Fri, 18 Oct 2024 14:39:09 +0800
Message-Id: <67d6b04934773de6732c4dd331c3441d90bc6dbe.1729233020.git.0x1207@gmail.com>
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

Rename and add macro definitions to better reuse them in common code.

Signed-off-by: Furong Xu <0x1207@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 49 ++++++++++---------
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.h  | 26 +++++-----
 2 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index c01eb7243d56..0aa30e302dd8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -168,7 +168,7 @@ static void dwmac5_fpe_configure(void __iomem *ioaddr,
 	u32 value;
 
 	if (tx_enable) {
-		cfg->fpe_csr = EFPE;
+		cfg->fpe_csr = STMMAC_MAC_FPE_CTRL_STS_EFPE;
 		value = readl(ioaddr + GMAC_RXQ_CTRL1);
 		value &= ~GMAC_RXQCTRL_FPRQ;
 		value |= (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
@@ -176,14 +176,14 @@ static void dwmac5_fpe_configure(void __iomem *ioaddr,
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
@@ -204,24 +204,24 @@ static int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
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
@@ -236,16 +236,17 @@ static void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
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
 
 static int dwmac5_fpe_get_add_frag_size(const void __iomem *ioaddr)
 {
-	return FIELD_GET(DWMAC5_ADD_FRAG_SZ, readl(ioaddr + MTL_FPE_CTRL_STS));
+	return FIELD_GET(FPE_MTL_ADD_FRAG_SZ,
+			 readl(ioaddr + GMAC5_MTL_FPE_CTRL_STS));
 }
 
 static void dwmac5_fpe_set_add_frag_size(void __iomem *ioaddr,
@@ -253,9 +254,9 @@ static void dwmac5_fpe_set_add_frag_size(void __iomem *ioaddr,
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
@@ -307,9 +308,9 @@ static int dwmac5_fpe_map_preemption_class(struct net_device *ndev,
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
@@ -322,11 +323,11 @@ static void dwxgmac3_fpe_configure(void __iomem *ioaddr,
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
 
@@ -335,9 +336,9 @@ static void dwxgmac3_fpe_configure(void __iomem *ioaddr,
 	value |= (num_rxq - 1) << XGMAC_RQ_SHIFT;
 	writel(value, ioaddr + XGMAC_RXQ_CTRL1);
 
-	value = readl(ioaddr + XGMAC_FPE_CTRL_STS);
-	value |= XGMAC_EFPE;
-	writel(value, ioaddr + XGMAC_FPE_CTRL_STS);
+	value = readl(ioaddr + XGMAC_MAC_FPE_CTRL_STS);
+	value |= STMMAC_MAC_FPE_CTRL_STS_EFPE;
+	writel(value, ioaddr + XGMAC_MAC_FPE_CTRL_STS);
 }
 
 const struct stmmac_fpe_ops dwmac5_fpe_ops = {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
index a113b5c57de9..c0305f11575b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
@@ -8,23 +8,23 @@
 #define STMMAC_FPE_MM_MAX_VERIFY_RETRIES	3
 #define STMMAC_FPE_MM_MAX_VERIFY_TIME_MS	128
 
-#define MAC_FPE_CTRL_STS		0x00000234
-#define TRSP				BIT(19)
-#define TVER				BIT(18)
-#define RRSP				BIT(17)
-#define RVER				BIT(16)
-#define SRSP				BIT(2)
-#define SVER				BIT(1)
-#define EFPE				BIT(0)
+#define GMAC5_MAC_FPE_CTRL_STS		0x00000234
+#define XGMAC_MAC_FPE_CTRL_STS		0x00000280
 
-#define MTL_FPE_CTRL_STS		0x00000c90
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
 
 /* FPE link-partner hand-shaking mPacket type */
 enum stmmac_mpacket_type {
-- 
2.34.1


