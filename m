Return-Path: <netdev+bounces-172557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5104A5569D
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CE073AB95D
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3194D272900;
	Thu,  6 Mar 2025 19:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDelv4q+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A4C2702DC;
	Thu,  6 Mar 2025 19:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289246; cv=none; b=k6vdEQEyQvFShMDp9ncc8Ly1jjPT5pcDn8OPj7vwSB0ezW4hSYguCflWNy8oUFVXLWpkdpz3zfzTw0SftLq0i8CBmMc/qsAMR3KXXsmdo9H7Zr2yDvTvMoWooaLcAv4cxz2bbN2Bt/TXuZ1Z1LDTEAHlrX+JZyoHkKAm4nzCPHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289246; c=relaxed/simple;
	bh=qEllzekEq8IAT5Z4C/NYgdMx63iggK+4MAvrXHQtytw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DJUSez4UFV0OOgIkff0mULjaTHkOsKZ0KwvfBjVaZQLDbzpBpJqG3YdtPGOkmFEfyTFWTyKzCNSQE2+NNDB0L39w4SOkJm5g3Cwh150NC/EquHPVtRZrvxjQmPN37fguQHGvbC/Q+ailrS9DffLbLk2hwj98bX3toYXmjqSvpO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDelv4q+; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7273b01fe35so572559a34.2;
        Thu, 06 Mar 2025 11:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741289243; x=1741894043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSucofxhEHh6y9zz8syxu2bQtsSf8MLDI4wztpQhvDg=;
        b=UDelv4q+iyfXS24ud73WgvCHgvavFCSpxgfk66Rh2JTWlDFhrDcmnAjjYkPSLBblYF
         cLTMmsJuoWSy0BonLJnJNQGmQKO+OhFgl5Z38HCtmmHeRfn9+Zqnz2bV1mNY/Ob+hasH
         ljrDbvqXa+r8cQCBQXUJ+OAz79KxmhrJ58bZbU/HtR20kdt8GJT6Ng+MTxId+13g2txC
         q586boWatxxmhFsG3Sqhf6xVH+s1sNtZRyiblGiGzJzVr41X26k4bkJnJJtQtO/Q7poR
         Jj1IlT280nJcqoIFMFZt6B5M2+M7lCuJFBlSGz6613ClTCqHUTKh4VZbddG+RiS6Ee9B
         yS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741289243; x=1741894043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSucofxhEHh6y9zz8syxu2bQtsSf8MLDI4wztpQhvDg=;
        b=BPpUAHFivEBoCaI+NxNy4ZgSKzMlMcagZuvHhQN6H4vljRJpyxfYAdegiNhE+WV1tJ
         xfRJ/FyJYWV+nXCk2XQW8eSWXUJhoxz5t/LRMGIi7CpT+o8yFwUuClgJcd4CuIfjhzEB
         5pMbBE94WfQhIh8Ro7LKHEHIZIQmGUhTYZNey7EiaYQ4JIxFHhSL1paa431d/8H1dWUL
         ma5Wu7rNyh+bIyl7IL74/cx4PM5kzp1HU8xgSoLZcmDR4j34Nl3opxKgtyhdSAEZIlO3
         +nA+WIBq//QOj3lPP97+1MD6DrLsqy3oM2OBMIaFHwVk0MbY70PLg4UDNkW6e9by49u8
         Em0w==
X-Forwarded-Encrypted: i=1; AJvYcCUn60Bb/ygJ7itIx166RFeKIsqW/m5x5fZxEf6CL0YRs+t7mPD6MGEspruHE0BbSVFDYl0ZHvE8@vger.kernel.org, AJvYcCVDW8Cy7LsJ/ueb67ErgPySzjctbbv03TJaUy/mI32GpIus/Oi+qXUV3LlC426y4j8Ls+npsLp1DVIIF3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf9+7QkMWz6eNZmWaHdFqhK5tFkwDKsdanOtnR09kM9fey19Lg
	CHY6bEGShVOvKNBDY6Ts/dUtlN92W7pvEs3OANzYfjSRT7L5CW7+
X-Gm-Gg: ASbGncs2VsImAMxauTU8brbDtTrz6cOupMRKktFqBG1aYeEQXaps1qALpGLOzsX8xv4
	TfikKnXlLWYIPOMbnG7STvWn0OIyTiEHlingaq/89Ud5dmKIknj9+h7Ddp7Y5SZQHxm/Q3neQBT
	LmFutzlmlWWeBEaT05MjxczQwbEctzirZnb2XOCUYXQkxIlGxRTGdefdC55bINYQPXgCmdTSj56
	/1OGHA7CmDv/h8CxewG2QTyTDR/usV6e6S8FtLZnv0dKLzHIDo01quMF6pVk0budJbTYaZvcYab
	xh5iiODq0pSuH26+ksOq0hUSp1fjyJM5brYM7hgTCXEy6NnzpzakE2UAmb8LIiHHgOaucW7mmiF
	ruYW8xsR5F/nJ
X-Google-Smtp-Source: AGHT+IGgcYN8VKkWjnN+QgIkKZGabOX2FW67nvjEjdbo1vBDgxbKnR9+R3OxVhFbCiPhaCB9C6iQTw==
X-Received: by 2002:a05:6830:3486:b0:72a:e65:e675 with SMTP id 46e09a7af769-72a37c64565mr287665a34.23.1741289243292;
        Thu, 06 Mar 2025 11:27:23 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72a2dac3887sm366338a34.7.2025.03.06.11.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 11:27:22 -0800 (PST)
From: Doug Berger <opendmb@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doug Berger <opendmb@gmail.com>
Subject: [PATCH net-next 02/14] net: bcmgenet: add bcmgenet_has_* helpers
Date: Thu,  6 Mar 2025 11:26:30 -0800
Message-Id: <20250306192643.2383632-3-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306192643.2383632-1-opendmb@gmail.com>
References: <20250306192643.2383632-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce helper functions to indicate whether the driver should
make use of a particular feature that it supports. These helpers
abstract the implementation of how the feature availability is
encoded.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 20 +++++++-------
 .../net/ethernet/broadcom/genet/bcmgenet.h    | 27 ++++++++++++++++++-
 drivers/net/ethernet/broadcom/genet/bcmmii.c  |  6 ++---
 3 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 0c717a724c4e..769d920a0fc0 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -104,7 +104,7 @@ static inline void dmadesc_set_addr(struct bcmgenet_priv *priv,
 	 * the platform is explicitly configured for 64-bits/LPAE.
 	 */
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
-	if (priv->hw_params->flags & GENET_HAS_40BITS)
+	if (bcmgenet_has_40bits(priv))
 		bcmgenet_writel(upper_32_bits(addr), d + DMA_DESC_ADDRESS_HI);
 #endif
 }
@@ -1651,9 +1651,9 @@ static int bcmgenet_power_down(struct bcmgenet_priv *priv,
 
 	case GENET_POWER_PASSIVE:
 		/* Power down LED */
-		if (priv->hw_params->flags & GENET_HAS_EXT) {
+		if (bcmgenet_has_ext(priv)) {
 			reg = bcmgenet_ext_readl(priv, EXT_EXT_PWR_MGMT);
-			if (GENET_IS_V5(priv) && !priv->ephy_16nm)
+			if (GENET_IS_V5(priv) && !bcmgenet_has_ephy_16nm(priv))
 				reg |= EXT_PWR_DOWN_PHY_EN |
 				       EXT_PWR_DOWN_PHY_RD |
 				       EXT_PWR_DOWN_PHY_SD |
@@ -1681,7 +1681,7 @@ static void bcmgenet_power_up(struct bcmgenet_priv *priv,
 {
 	u32 reg;
 
-	if (!(priv->hw_params->flags & GENET_HAS_EXT))
+	if (!bcmgenet_has_ext(priv))
 		return;
 
 	reg = bcmgenet_ext_readl(priv, EXT_EXT_PWR_MGMT);
@@ -1690,7 +1690,7 @@ static void bcmgenet_power_up(struct bcmgenet_priv *priv,
 	case GENET_POWER_PASSIVE:
 		reg &= ~(EXT_PWR_DOWN_DLL | EXT_PWR_DOWN_BIAS |
 			 EXT_ENERGY_DET_MASK);
-		if (GENET_IS_V5(priv) && !priv->ephy_16nm) {
+		if (GENET_IS_V5(priv) && !bcmgenet_has_ephy_16nm(priv)) {
 			reg &= ~(EXT_PWR_DOWN_PHY_EN |
 				 EXT_PWR_DOWN_PHY_RD |
 				 EXT_PWR_DOWN_PHY_SD |
@@ -2523,7 +2523,7 @@ static void bcmgenet_link_intr_enable(struct bcmgenet_priv *priv)
 	} else if (priv->ext_phy) {
 		int0_enable |= UMAC_IRQ_LINK_EVENT;
 	} else if (priv->phy_interface == PHY_INTERFACE_MODE_MOCA) {
-		if (priv->hw_params->flags & GENET_HAS_MOCA_LINK_DET)
+		if (bcmgenet_has_moca_link_det(priv))
 			int0_enable |= UMAC_IRQ_LINK_EVENT;
 	}
 	bcmgenet_intrl2_0_writel(priv, int0_enable, INTRL2_CPU_MASK_CLEAR);
@@ -2588,7 +2588,7 @@ static void init_umac(struct bcmgenet_priv *priv)
 	}
 
 	/* Enable MDIO interrupts on GENET v3+ */
-	if (priv->hw_params->flags & GENET_HAS_MDIO_INTR)
+	if (bcmgenet_has_mdio_intr(priv))
 		int0_enable |= (UMAC_IRQ_MDIO_DONE | UMAC_IRQ_MDIO_ERROR);
 
 	bcmgenet_intrl2_0_writel(priv, int0_enable, INTRL2_CPU_MASK_CLEAR);
@@ -3228,7 +3228,7 @@ static irqreturn_t bcmgenet_isr0(int irq, void *dev_id)
 		}
 	}
 
-	if ((priv->hw_params->flags & GENET_HAS_MDIO_INTR) &&
+	if (bcmgenet_has_mdio_intr(priv) &&
 		status & (UMAC_IRQ_MDIO_DONE | UMAC_IRQ_MDIO_ERROR)) {
 		wake_up(&priv->wq);
 	}
@@ -3881,7 +3881,7 @@ static void bcmgenet_set_hw_params(struct bcmgenet_priv *priv)
 	}
 
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
-	if (!(params->flags & GENET_HAS_40BITS))
+	if (!bcmgenet_has_40bits(priv))
 		pr_warn("GENET does not support 40-bits PA\n");
 #endif
 
@@ -4060,7 +4060,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
 	bcmgenet_set_hw_params(priv);
 
 	err = -EIO;
-	if (priv->hw_params->flags & GENET_HAS_40BITS)
+	if (bcmgenet_has_40bits(priv))
 		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
 	if (err)
 		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 1078a31ac794..9b73ae55c0d6 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2014-2024 Broadcom
+ * Copyright (c) 2014-2025 Broadcom
  */
 
 #ifndef __BCMGENET_H__
@@ -650,6 +650,31 @@ struct bcmgenet_priv {
 	struct ethtool_keee eee;
 };
 
+static inline bool bcmgenet_has_40bits(struct bcmgenet_priv *priv)
+{
+	return !!(priv->hw_params->flags & GENET_HAS_40BITS);
+}
+
+static inline bool bcmgenet_has_ext(struct bcmgenet_priv *priv)
+{
+	return !!(priv->hw_params->flags & GENET_HAS_EXT);
+}
+
+static inline bool bcmgenet_has_mdio_intr(struct bcmgenet_priv *priv)
+{
+	return !!(priv->hw_params->flags & GENET_HAS_MDIO_INTR);
+}
+
+static inline bool bcmgenet_has_moca_link_det(struct bcmgenet_priv *priv)
+{
+	return !!(priv->hw_params->flags & GENET_HAS_MOCA_LINK_DET);
+}
+
+static inline bool bcmgenet_has_ephy_16nm(struct bcmgenet_priv *priv)
+{
+	return priv->ephy_16nm;
+}
+
 #define GENET_IO_MACRO(name, offset)					\
 static inline u32 bcmgenet_##name##_readl(struct bcmgenet_priv *priv,	\
 					u32 off)			\
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index c4a3698cef66..71c619d2bea5 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -2,7 +2,7 @@
 /*
  * Broadcom GENET MDIO routines
  *
- * Copyright (c) 2014-2024 Broadcom
+ * Copyright (c) 2014-2025 Broadcom
  */
 
 #include <linux/acpi.h>
@@ -154,7 +154,7 @@ void bcmgenet_phy_power_set(struct net_device *dev, bool enable)
 	u32 reg = 0;
 
 	/* EXT_GPHY_CTRL is only valid for GENETv4 and onward */
-	if (GENET_IS_V4(priv) || priv->ephy_16nm) {
+	if (GENET_IS_V4(priv) || bcmgenet_has_ephy_16nm(priv)) {
 		reg = bcmgenet_ext_readl(priv, EXT_GPHY_CTRL);
 		if (enable) {
 			reg &= ~EXT_CK25_DIS;
@@ -184,7 +184,7 @@ void bcmgenet_phy_power_set(struct net_device *dev, bool enable)
 
 static void bcmgenet_moca_phy_setup(struct bcmgenet_priv *priv)
 {
-	if (priv->hw_params->flags & GENET_HAS_MOCA_LINK_DET)
+	if (bcmgenet_has_moca_link_det(priv))
 		fixed_phy_set_link_update(priv->dev->phydev,
 					  bcmgenet_fixed_phy_link_update);
 }
-- 
2.34.1


