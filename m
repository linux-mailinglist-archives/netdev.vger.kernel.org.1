Return-Path: <netdev+bounces-105174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D037890FF99
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 10:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F2FF28172A
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 08:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895191A8C0D;
	Thu, 20 Jun 2024 08:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8nO+F8W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5BE3D994;
	Thu, 20 Jun 2024 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873560; cv=none; b=aQ8zinRtLxFin7//pcymwFHprkpxR/QBhNZ+3jReeAtgj/MPeOrA+eFZE1kqrwP+7PdDFqlRbw0jUeL5dMfotA6/PvDK4COR4fgESuVjDfxm8mYghDfw8Gq24OREDZ04pprApLUA3ro9xpJPteceKKuuuAOuNhN3Y/zAeQ5zTTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873560; c=relaxed/simple;
	bh=cfW8+iR+f2HC19SB2sEKjqX8/oAWZeHnmAqWL+6fR1E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MnqaE4HwmGSP5FLZasTPllbzpmAXJj7y6Q3nfvvgSW+Oi3d0Y1NjImJ1at3gp1mrh0thF/8owaagOF7WVC0l0smdbMZ22zYvovrdLlOUjohO3NSoDSiHYeKgLGNAMr0QE/NOc5ODRPanYcs6IhRLwFXZ1E5yRGv0YqjujATvMHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8nO+F8W; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7152e097461so53525a12.1;
        Thu, 20 Jun 2024 01:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718873558; x=1719478358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eB/cLhg3WSWwUi9V50hFyuG/XhsXVW1cGn/by2rdEtI=;
        b=Y8nO+F8WTmmsoOdoDKGIo6imj1qjy3R8whP4UNXIeWcrRygKQsNM6S5tUUNnGPnvh8
         hruxhPGka9DPRXsRTHWVZM7ViHdpoFuk7ydfmx7SX8rBAWP664DquL8Vld0rnpnzJZpS
         G2Jy0n7HZsxMvvfyWfVcGHv/M+4JA67DhZG/foJhJmIikCBuHNVObtXFEmIXWcCCYeCO
         pSf6tVcKZcTuw1GuFyP6b4o+5sSvEN9l+ab0erC63rbgzacLCccxsp9zw4PW0xuJKKDA
         dfnGc3r+qypsatQsEqI/XL2TObP2ogc2h+I9pdWVIjlPOUuTihw7L7/LT2Tta/Ok5SpJ
         HoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718873558; x=1719478358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eB/cLhg3WSWwUi9V50hFyuG/XhsXVW1cGn/by2rdEtI=;
        b=Sq3lKYe/dmcYkLOqxPeuGmGxH9s8o7JDk4uLcQgadWlAIga5j1sXE9Pu6OR4xjKRw9
         HrtgZYXb6VKuXGeibYEEMvA+Z8/WDB5zTO7KIxnnbWQbS2bkva78/UsDY8kG64Dd34/o
         PANz6uVvDLHScQ/AsmzlG6f13ZS67HOrObdstgDzwBa4RLMO3jp+KdyTkZRgGp8/8F07
         4cwqL69bMW2wIAkGHEBFL1xL9sfq8OPVwbe/DJmb8E+z7OfLDHgJtkQpevOthLQxQB0i
         1bf2UWIeWN/w+0Qpb7nUaZZWe5X1phI9TEw/fXxJarMNp2ZT2QG0LR8liw9HcJLZF4cN
         TXkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPSpnulV9OQCLu0RrR5L3CttJDwJiqqrlRvd+/4QrTG7YRYi4YhHWUop52wzOOUAiSXd62DS0AhUNihSLOhnEtVNcPY0kn5DOBadd6
X-Gm-Message-State: AOJu0YwxtiRUsrTh4M+DBLiooujpi6HoE160FDumWsR68ztEdGRWZPJP
	KUA5eFbzfWoXW+PfC/aE/QAenpAUWsycp6ccYYxOLU6fukytxZFq
X-Google-Smtp-Source: AGHT+IEmKmHEsNjSGrqpoUKBQw6eg+ckhuujPTMdS+oAOp1CeIUP6o8hfE4wARCQsHOeFNPFZkI2zg==
X-Received: by 2002:a17:90a:f281:b0:2c4:f32c:6b with SMTP id 98e67ed59e1d1-2c7b3ba85abmr7335661a91.19.1718873557978;
        Thu, 20 Jun 2024 01:52:37 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c7e4ff8affsm1133215a91.11.2024.06.20.01.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 01:52:37 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xfr@outlook.com,
	rock.xu@nio.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v1] net: stmmac: xgmac: increase length limit of descriptor ring
Date: Thu, 20 Jun 2024 16:52:00 +0800
Message-Id: <20240620085200.583709-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DWXGMAC CORE supports a ring length of 65536 descriptors, bump max length
from 1024 to 65536

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  2 ++
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 24 +++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 6a2c7d22df1e..264f4f876c74 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -11,6 +11,8 @@
 
 /* Misc */
 #define XGMAC_JUMBO_LEN			16368
+#define XGMAC_DMA_MAX_TX_SIZE		65536
+#define XGMAC_DMA_MAX_RX_SIZE		65536
 
 /* MAC Registers */
 #define XGMAC_TX_CONFIG			0x00000000
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 18468c0228f0..3ae465c5a712 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -491,9 +491,16 @@ static void stmmac_get_ringparam(struct net_device *netdev,
 				 struct netlink_ext_ack *extack)
 {
 	struct stmmac_priv *priv = netdev_priv(netdev);
+	u32 dma_max_rx_size = DMA_MAX_RX_SIZE;
+	u32 dma_max_tx_size = DMA_MAX_TX_SIZE;
 
-	ring->rx_max_pending = DMA_MAX_RX_SIZE;
-	ring->tx_max_pending = DMA_MAX_TX_SIZE;
+	if (priv->plat->has_xgmac) {
+		dma_max_rx_size = XGMAC_DMA_MAX_RX_SIZE;
+		dma_max_tx_size = XGMAC_DMA_MAX_TX_SIZE;
+	}
+
+	ring->rx_max_pending = dma_max_rx_size;
+	ring->tx_max_pending = dma_max_tx_size;
 	ring->rx_pending = priv->dma_conf.dma_rx_size;
 	ring->tx_pending = priv->dma_conf.dma_tx_size;
 }
@@ -503,12 +510,21 @@ static int stmmac_set_ringparam(struct net_device *netdev,
 				struct kernel_ethtool_ringparam *kernel_ring,
 				struct netlink_ext_ack *extack)
 {
+	struct stmmac_priv *priv = netdev_priv(netdev);
+	u32 dma_max_rx_size = DMA_MAX_RX_SIZE;
+	u32 dma_max_tx_size = DMA_MAX_TX_SIZE;
+
+	if (priv->plat->has_xgmac) {
+		dma_max_rx_size = XGMAC_DMA_MAX_RX_SIZE;
+		dma_max_tx_size = XGMAC_DMA_MAX_TX_SIZE;
+	}
+
 	if (ring->rx_mini_pending || ring->rx_jumbo_pending ||
 	    ring->rx_pending < DMA_MIN_RX_SIZE ||
-	    ring->rx_pending > DMA_MAX_RX_SIZE ||
+	    ring->rx_pending > dma_max_rx_size ||
 	    !is_power_of_2(ring->rx_pending) ||
 	    ring->tx_pending < DMA_MIN_TX_SIZE ||
-	    ring->tx_pending > DMA_MAX_TX_SIZE ||
+	    ring->tx_pending > dma_max_tx_size ||
 	    !is_power_of_2(ring->tx_pending))
 		return -EINVAL;
 
-- 
2.34.1


