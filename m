Return-Path: <netdev+bounces-28134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A54477E566
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 17:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC84281B49
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 15:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F3F15AEC;
	Wed, 16 Aug 2023 15:41:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F5D101DB
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 15:41:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB9FC433C7;
	Wed, 16 Aug 2023 15:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692200484;
	bh=txwgc7mnnsmcD2eGCJ5tky3C5uEWpaD5DMyct9tbf5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Idw8nBH3ufcz1hDSmcG2WbpHUhGAiI6pvqX38a6xog1CwntcfQ4+AP2a4zOb2zcCP
	 1rHM36XZKHDVUgIlBSg9vf+mdcESOAZZWmISsMwod+8P0pzhOT24Vk0Ej6lxcM3Msn
	 cbRAVSEVnkpu5kkvSwxsZjJ+YR1Jm6+c7N20mluxk/wYtYykE9H5HmrBt3QfuujV8r
	 3yO31F7chLeFdiLRBEw33l3zXwrDDjr021rqqJ5TyhhaBjSEbcNncvHWVNdW6K16T7
	 j4LkUEZx4+OTRlFyL5KDRsCVwX8qnuJozRRhbiKjFMvy//XUzOENWUbLPM7jyKKzBn
	 VZf3TybluMATA==
From: Jisheng Zhang <jszhang@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v4 3/9] net: stmmac: enlarge max rx/tx queues and channels to 16
Date: Wed, 16 Aug 2023 23:29:20 +0800
Message-Id: <20230816152926.4093-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230816152926.4093-1-jszhang@kernel.org>
References: <20230816152926.4093-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xgmac supports up to 16 rx/tx queues and up to 16 channels.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Acked-by: Alexandre TORGUE <alexandre.torgue@foss.st.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 5 ++---
 include/linux/stmmac.h                              | 6 +++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 38782662ff98..8ac994553bc1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -232,9 +232,8 @@ static void dwxgmac2_map_mtl_to_dma(struct mac_device_info *hw, u32 queue,
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value, reg;
 
-	reg = (queue < 4) ? XGMAC_MTL_RXQ_DMA_MAP0 : XGMAC_MTL_RXQ_DMA_MAP1;
-	if (queue >= 4)
-		queue -= 4;
+	reg = XGMAC_MTL_RXQ_DMA_MAP0 + (queue & ~0x3);
+	queue &= 0x3;
 
 	value = readl(ioaddr + reg);
 	value &= ~XGMAC_QxMDMACH(queue);
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 784277d666eb..9c90e2e295d4 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -15,9 +15,9 @@
 #include <linux/platform_device.h>
 #include <linux/phy.h>
 
-#define MTL_MAX_RX_QUEUES	8
-#define MTL_MAX_TX_QUEUES	8
-#define STMMAC_CH_MAX		8
+#define MTL_MAX_RX_QUEUES	16
+#define MTL_MAX_TX_QUEUES	16
+#define STMMAC_CH_MAX		16
 
 #define STMMAC_RX_COE_NONE	0
 #define STMMAC_RX_COE_TYPE1	1
-- 
2.40.1


