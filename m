Return-Path: <netdev+bounces-25041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC575772BB4
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 18:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 859772814C7
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 16:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FD312B72;
	Mon,  7 Aug 2023 16:53:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1E812B62
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 16:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2119DC433BF;
	Mon,  7 Aug 2023 16:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691427228;
	bh=DE4uo4JK2isjtFObJJyFLlrT5b6CK5kuMo4uw+Jhg2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I1yQft+pI+78xzHUZr1bnc/ulnxJht9vwsrA2QllKenLRN3Gm/fUpD8ui/gy9hS+q
	 a1GefJuCGAdZr1b8XzrAobmQzv5gnJlcvDSKGTNGq7hieX2Btx5lnnt/fAJjzInCR+
	 Gr4o/RG7NvvkYz710vr22YLU3tjGh4LQDWHzcjeBZQMVavLvD4chMbkC3Ovw3Z5BS0
	 E2o2+CUc4p29SvvjMQ0ekGYIarsoO74ps2zBkuPdpwXTeRLHwS/xnp6raTTcBvT3b4
	 doPjxsb07YEXdxdJ/EwBv2XYBK8E8TkAMapZjObuQLqXdyQnGoKyQhngVz7huAhnJ5
	 tsTvsgJYtFzNQ==
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
Subject: [PATCH net-next v2 04/10] net: stmmac: enlarge max rx/tx queues and channels to 16
Date: Tue,  8 Aug 2023 00:41:45 +0800
Message-Id: <20230807164151.1130-5-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230807164151.1130-1-jszhang@kernel.org>
References: <20230807164151.1130-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xgmac supports up to 16 rx/tx queues and up to 16 channels.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 5 ++---
 include/linux/stmmac.h                              | 6 +++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index a0c2ef8bb0ac..aaae82d3d9dc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -202,9 +202,8 @@ static void dwxgmac2_map_mtl_to_dma(struct mac_device_info *hw, u32 queue,
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
index ef67dba775d0..11671fd6adee 100644
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


