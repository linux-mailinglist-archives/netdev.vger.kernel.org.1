Return-Path: <netdev+bounces-172556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D924A5569A
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A171E7A7251
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806FF270EB7;
	Thu,  6 Mar 2025 19:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6LWiE1P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14382702B1;
	Thu,  6 Mar 2025 19:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289244; cv=none; b=EKl+cTa2Ec8TEpoyaHp/QlDXkzf4TS3d5VUkSG7K9IcZAaoc3EbegZoNklBGIgKIddLtfiUnSYuVvVoJ9oVhxjLnHouVC+kMbTqsbv1s1diZtOwy6R/WfMG1frP32SyY3iqAQokpW310PeBwB1u4VHzh4QMvIKL1VrhoYmRhTQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289244; c=relaxed/simple;
	bh=9ENCTKeLEn1PJ1zMdgPRHmAQLdMXx0UFApLFQTECnSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C6b3iKsn6rTlmRHL4s0AoewkIAMEqi3LU9v4sZUzrpdTbvaTJTqFw/aTWwXBuTQFmeaRquXi8uYwXzNLOazgN9yfus4+jpyTYpptuGt5cZAuE3aCQi9cdIYDClw1Qdg7aEgXT15DtXl1bZLSgR/rGrWrhoHOCxbM4erv05vTPDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6LWiE1P; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2c239771aeaso563547fac.0;
        Thu, 06 Mar 2025 11:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741289242; x=1741894042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKwfTsEQw5Bi7D8464oJBTkyLsaylAPpitDMs+mgTDc=;
        b=W6LWiE1P7aLFsK/4tEbruCUDVidRDEoBvillmziije8Ecnb8V4SULD6ACGtqcXuhHy
         Xp78ab5+TAy3VhaTV+QejIhbCrV3rDCij8uC/nBom+N1ppceI8s5wIzRH5AXauwuWP7l
         85O6RBptUCXRCtyUlJ4AAcLGAEo0+NWe7oxwEfsUWUtcoAV5YPATe1zq7YGbiX5+6uos
         11jZbLcogGecDGLRTglqWV9vM+wwSl/zBCMQTc/YhQjVEj9yrQ4i+fkHLpsZOXwnca1r
         ZMg+aM89KyM/fYXafxDWSeiXHyM0g1FftOiI3Ycs267idncfnCtTLbl31t4UjLIDd0m0
         JgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741289242; x=1741894042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKwfTsEQw5Bi7D8464oJBTkyLsaylAPpitDMs+mgTDc=;
        b=I4Ijt2vWGlSVf5tR3cVp+SaUjH48XnO/ZlPFRdVfY/H5e1UUxDIoFywWKk25pvIT2m
         Fam65BbNpk6nADMhTSuozdtHV8VA6Kl1gN95qU2WDvBtLd4SvHgZ7PAk16v8aKaHhNDU
         AkK6lOXYZfvSGZJIh0Fuy36XA4/52XzCFU13lr05JnmxQCGzlzPyKVskY7exFGhWxYaJ
         YokuzO4/KfQP/7YwxXkJustcCB79Iy3KSDW7Hjtf1wmlVs1jFvbhXLNoWIt0upMn5YLm
         S81J6YIRQu3NlZugKzIbGTd0h58vM9ZUw7J4gZQAlVQhQ3GiQjyMeD31SXU24hpYi6pW
         Ms8g==
X-Forwarded-Encrypted: i=1; AJvYcCV7zqKO/A4D73dRkXjWxUIGoFLuZCgSsMmZmsdDVYUAnkuH6uwGFHEjNy9/XZDxQpKFhv8V1Sds@vger.kernel.org, AJvYcCWsWiMpdgyAvqx/QhyUtSc49ppyYeEqTYPHIwbUgHXVXjbZ+1eNtF3hQxjgd4uiNdVOJht9FmXtBnkjcfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw9J30JJLaZ0UWZqnnMN61Z071jBSL6b8jOHvbUtCCQ/YhlzKY
	IA/v36doYBX3yjiXYh0WPVDUeMqK0mQbfb0SeD7p9BFrvaZQuDaz
X-Gm-Gg: ASbGncuW2yR3uAcopZCGCpqWC5kB5i406HNEBfu4IKPW3ePJ0F9aRAxyOzntk6H9isy
	V7NiJEYAbQDo47KPIAuefT2LY2ByVHyi6G3wgPvrmWmUUOqL73xQIjjs46T2jU905acnAOwQuw9
	2LZ9OG/3iiMNEETUiK4v2ChGmOFuuCZcO2VxcErKUcaaNZM77El7MuUkyawrvVDcXKtePDy8CsP
	ktEQsu0OmuijyTK1aFbZITDKYrIqAOI5sayLEj81Jjo2hDmFbA1qrJ5xBs+rP9BjF4niBQDtCHU
	8onGGqyXooT0UeWEBvGoqBu3R5tqleh4B70LA+B4xOmrth3jCD9kuxkE7r4evOkmPgSTqn31uTE
	cwCIfd9Hgn+lm
X-Google-Smtp-Source: AGHT+IGyH+Xdmhl/sdavZJd+xAXCyXcM0Rh4RDOkEnHuNVpvBoSSRnwp/JMa26joUyLsNPjQlXNOIg==
X-Received: by 2002:a05:6871:e082:b0:2c2:2d0f:40a3 with SMTP id 586e51a60fabf-2c2612f7582mr357227fac.31.1741289241657;
        Thu, 06 Mar 2025 11:27:21 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72a2dac3887sm366338a34.7.2025.03.06.11.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 11:27:20 -0800 (PST)
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
Subject: [PATCH net-next 01/14] net: bcmgenet: bcmgenet_hw_params clean up
Date: Thu,  6 Mar 2025 11:26:29 -0800
Message-Id: <20250306192643.2383632-2-opendmb@gmail.com>
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

The entries of the bcmgenet_hw_params array are broken out to
remove unused and duplicate entries and are made read only since
they should not change for a specific version of the GENET
hardware.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 183 ++++++++----------
 .../net/ethernet/broadcom/genet/bcmgenet.h    |   2 +-
 2 files changed, 84 insertions(+), 101 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 3e93f957430b..0c717a724c4e 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2,7 +2,7 @@
 /*
  * Broadcom GENET (Gigabit Ethernet) controller driver
  *
- * Copyright (c) 2014-2024 Broadcom
+ * Copyright (c) 2014-2025 Broadcom
  */
 
 #define pr_fmt(fmt)				"bcmgenet: " fmt
@@ -3726,123 +3726,106 @@ static const struct net_device_ops bcmgenet_netdev_ops = {
 	.ndo_change_carrier	= bcmgenet_change_carrier,
 };
 
-/* Array of GENET hardware parameters/characteristics */
-static struct bcmgenet_hw_params bcmgenet_hw_params[] = {
-	[GENET_V1] = {
-		.tx_queues = 0,
-		.tx_bds_per_q = 0,
-		.rx_queues = 0,
-		.rx_bds_per_q = 0,
-		.bp_in_en_shift = 16,
-		.bp_in_mask = 0xffff,
-		.hfb_filter_cnt = 16,
-		.qtag_mask = 0x1F,
-		.hfb_offset = 0x1000,
-		.rdma_offset = 0x2000,
-		.tdma_offset = 0x3000,
-		.words_per_bd = 2,
-	},
-	[GENET_V2] = {
-		.tx_queues = 4,
-		.tx_bds_per_q = 32,
-		.rx_queues = 0,
-		.rx_bds_per_q = 0,
-		.bp_in_en_shift = 16,
-		.bp_in_mask = 0xffff,
-		.hfb_filter_cnt = 16,
-		.qtag_mask = 0x1F,
-		.tbuf_offset = 0x0600,
-		.hfb_offset = 0x1000,
-		.hfb_reg_offset = 0x2000,
-		.rdma_offset = 0x3000,
-		.tdma_offset = 0x4000,
-		.words_per_bd = 2,
-		.flags = GENET_HAS_EXT,
-	},
-	[GENET_V3] = {
-		.tx_queues = 4,
-		.tx_bds_per_q = 32,
-		.rx_queues = 0,
-		.rx_bds_per_q = 0,
-		.bp_in_en_shift = 17,
-		.bp_in_mask = 0x1ffff,
-		.hfb_filter_cnt = 48,
-		.hfb_filter_size = 128,
-		.qtag_mask = 0x3F,
-		.tbuf_offset = 0x0600,
-		.hfb_offset = 0x8000,
-		.hfb_reg_offset = 0xfc00,
-		.rdma_offset = 0x10000,
-		.tdma_offset = 0x11000,
-		.words_per_bd = 2,
-		.flags = GENET_HAS_EXT | GENET_HAS_MDIO_INTR |
-			 GENET_HAS_MOCA_LINK_DET,
-	},
-	[GENET_V4] = {
-		.tx_queues = 4,
-		.tx_bds_per_q = 32,
-		.rx_queues = 0,
-		.rx_bds_per_q = 0,
-		.bp_in_en_shift = 17,
-		.bp_in_mask = 0x1ffff,
-		.hfb_filter_cnt = 48,
-		.hfb_filter_size = 128,
-		.qtag_mask = 0x3F,
-		.tbuf_offset = 0x0600,
-		.hfb_offset = 0x8000,
-		.hfb_reg_offset = 0xfc00,
-		.rdma_offset = 0x2000,
-		.tdma_offset = 0x4000,
-		.words_per_bd = 3,
-		.flags = GENET_HAS_40BITS | GENET_HAS_EXT |
-			 GENET_HAS_MDIO_INTR | GENET_HAS_MOCA_LINK_DET,
-	},
-	[GENET_V5] = {
-		.tx_queues = 4,
-		.tx_bds_per_q = 32,
-		.rx_queues = 0,
-		.rx_bds_per_q = 0,
-		.bp_in_en_shift = 17,
-		.bp_in_mask = 0x1ffff,
-		.hfb_filter_cnt = 48,
-		.hfb_filter_size = 128,
-		.qtag_mask = 0x3F,
-		.tbuf_offset = 0x0600,
-		.hfb_offset = 0x8000,
-		.hfb_reg_offset = 0xfc00,
-		.rdma_offset = 0x2000,
-		.tdma_offset = 0x4000,
-		.words_per_bd = 3,
-		.flags = GENET_HAS_40BITS | GENET_HAS_EXT |
-			 GENET_HAS_MDIO_INTR | GENET_HAS_MOCA_LINK_DET,
-	},
+/* GENET hardware parameters/characteristics */
+static const struct bcmgenet_hw_params bcmgenet_hw_params_v1 = {
+	.tx_queues = 0,
+	.tx_bds_per_q = 0,
+	.rx_queues = 0,
+	.rx_bds_per_q = 0,
+	.bp_in_en_shift = 16,
+	.bp_in_mask = 0xffff,
+	.hfb_filter_cnt = 16,
+	.qtag_mask = 0x1F,
+	.hfb_offset = 0x1000,
+	.rdma_offset = 0x2000,
+	.tdma_offset = 0x3000,
+	.words_per_bd = 2,
+};
+
+static const struct bcmgenet_hw_params bcmgenet_hw_params_v2 = {
+	.tx_queues = 4,
+	.tx_bds_per_q = 32,
+	.rx_queues = 0,
+	.rx_bds_per_q = 0,
+	.bp_in_en_shift = 16,
+	.bp_in_mask = 0xffff,
+	.hfb_filter_cnt = 16,
+	.qtag_mask = 0x1F,
+	.tbuf_offset = 0x0600,
+	.hfb_offset = 0x1000,
+	.hfb_reg_offset = 0x2000,
+	.rdma_offset = 0x3000,
+	.tdma_offset = 0x4000,
+	.words_per_bd = 2,
+	.flags = GENET_HAS_EXT,
+};
+
+static const struct bcmgenet_hw_params bcmgenet_hw_params_v3 = {
+	.tx_queues = 4,
+	.tx_bds_per_q = 32,
+	.rx_queues = 0,
+	.rx_bds_per_q = 0,
+	.bp_in_en_shift = 17,
+	.bp_in_mask = 0x1ffff,
+	.hfb_filter_cnt = 48,
+	.hfb_filter_size = 128,
+	.qtag_mask = 0x3F,
+	.tbuf_offset = 0x0600,
+	.hfb_offset = 0x8000,
+	.hfb_reg_offset = 0xfc00,
+	.rdma_offset = 0x10000,
+	.tdma_offset = 0x11000,
+	.words_per_bd = 2,
+	.flags = GENET_HAS_EXT | GENET_HAS_MDIO_INTR |
+		 GENET_HAS_MOCA_LINK_DET,
+};
+
+static const struct bcmgenet_hw_params bcmgenet_hw_params_v4 = {
+	.tx_queues = 4,
+	.tx_bds_per_q = 32,
+	.rx_queues = 0,
+	.rx_bds_per_q = 0,
+	.bp_in_en_shift = 17,
+	.bp_in_mask = 0x1ffff,
+	.hfb_filter_cnt = 48,
+	.hfb_filter_size = 128,
+	.qtag_mask = 0x3F,
+	.tbuf_offset = 0x0600,
+	.hfb_offset = 0x8000,
+	.hfb_reg_offset = 0xfc00,
+	.rdma_offset = 0x2000,
+	.tdma_offset = 0x4000,
+	.words_per_bd = 3,
+	.flags = GENET_HAS_40BITS | GENET_HAS_EXT |
+		 GENET_HAS_MDIO_INTR | GENET_HAS_MOCA_LINK_DET,
 };
 
 /* Infer hardware parameters from the detected GENET version */
 static void bcmgenet_set_hw_params(struct bcmgenet_priv *priv)
 {
-	struct bcmgenet_hw_params *params;
+	const struct bcmgenet_hw_params *params;
 	u32 reg;
 	u8 major;
 	u16 gphy_rev;
 
-	if (GENET_IS_V5(priv) || GENET_IS_V4(priv)) {
-		bcmgenet_dma_regs = bcmgenet_dma_regs_v3plus;
-		genet_dma_ring_regs = genet_dma_ring_regs_v4;
-	} else if (GENET_IS_V3(priv)) {
+	/* default to latest values */
+	params = &bcmgenet_hw_params_v4;
+	bcmgenet_dma_regs = bcmgenet_dma_regs_v3plus;
+	genet_dma_ring_regs = genet_dma_ring_regs_v4;
+	if (GENET_IS_V3(priv)) {
+		params = &bcmgenet_hw_params_v3;
 		bcmgenet_dma_regs = bcmgenet_dma_regs_v3plus;
 		genet_dma_ring_regs = genet_dma_ring_regs_v123;
 	} else if (GENET_IS_V2(priv)) {
+		params = &bcmgenet_hw_params_v2;
 		bcmgenet_dma_regs = bcmgenet_dma_regs_v2;
 		genet_dma_ring_regs = genet_dma_ring_regs_v123;
 	} else if (GENET_IS_V1(priv)) {
+		params = &bcmgenet_hw_params_v1;
 		bcmgenet_dma_regs = bcmgenet_dma_regs_v1;
 		genet_dma_ring_regs = genet_dma_ring_regs_v123;
 	}
-
-	/* enum genet_version starts at 1 */
-	priv->hw_params = &bcmgenet_hw_params[priv->version];
-	params = priv->hw_params;
+	priv->hw_params = params;
 
 	/* Read GENET HW version */
 	reg = bcmgenet_sys_readl(priv, SYS_REV_CTRL);
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 43b923c48b14..1078a31ac794 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -596,7 +596,7 @@ struct bcmgenet_priv {
 	struct bcmgenet_rx_ring rx_rings[DESC_INDEX + 1];
 
 	/* other misc variables */
-	struct bcmgenet_hw_params *hw_params;
+	const struct bcmgenet_hw_params *hw_params;
 	unsigned autoneg_pause:1;
 	unsigned tx_pause:1;
 	unsigned rx_pause:1;
-- 
2.34.1


