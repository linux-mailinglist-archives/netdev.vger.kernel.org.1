Return-Path: <netdev+bounces-28544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC20177FCB4
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 19:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3265D2817AF
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 17:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0479A171BF;
	Thu, 17 Aug 2023 17:09:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18F6171A4
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 17:09:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2106C433CD;
	Thu, 17 Aug 2023 17:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692292183;
	bh=txwgc7mnnsmcD2eGCJ5tky3C5uEWpaD5DMyct9tbf5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KGFOMjSyshRYy3S7XmxI5nPwYr+UR97M+Uh9kYY13NwiaS+05J/F2VA8eBRBJ+h4g
	 NwVxLm2D4MtYAqWJgx0cxNBFZ+XmiIyaMJKnKfxwYQBmkgCrWo1pVgkmAVjjeaNs7I
	 f8+/jGpS8e+4JeAt6WdDPZ93j2ckQIcov4iPDj1KhSYQgRSWrNc1LdQwRlO+HBP0n2
	 4wg1UdU4Ue4cpSGbnhMZZ21Sikktib0l3Hfsl7itDJZkueJfK6AgcAoVYSBnYPO8pf
	 Ku6lmXDAQi17J6N1E2v6F3BWBCvKninvj6L6lseyqsi8w37BH3ZBebKR9xKhkpyH7x
	 xF0FHfQHOK8jw==
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
Subject: [PATCH net-next v5 3/9] net: stmmac: enlarge max rx/tx queues and channels to 16
Date: Fri, 18 Aug 2023 00:57:43 +0800
Message-Id: <20230817165749.672-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230817165749.672-1-jszhang@kernel.org>
References: <20230817165749.672-1-jszhang@kernel.org>
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


