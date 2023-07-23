Return-Path: <netdev+bounces-20191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B440575E3A9
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 18:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BEB11C209C9
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 16:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC235187A;
	Sun, 23 Jul 2023 16:22:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE7C46AC
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 16:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13453C433C7;
	Sun, 23 Jul 2023 16:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690129333;
	bh=xPpxwJzBLsCaca6qQZWRTcviG5VQc7YuCxtBnfOO0Sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AETGN3psgYDDeZ7dEs61AH+fm3ZEVg3r6pj/bYdGI19yI2nBvxoq0BdIEj8AhmTR1
	 E01kZ3OlafYNozk7XyhxhkUA1OPn5TbDbIcaks21KcjxCV9SiUd6ihHPkwcAD17LKS
	 MTNfuC/XyK9+n6hZH5nXwAHIT1fn3I1n4WQ9lQi08GVemg4wuBDEe82fWemSYoHW07
	 yTP2s1rO9QZNg9GcA5PROay5Sqh4jnA1Qqg3U3i/Pdld8KzmqzmHfJf7KUrh3aen4X
	 d0Ir96HVrfapgb2TSqjGl/AbCkicw4A46nqADKQcL1BjAjXs4iHPo4U4WPoiyvA/Cr
	 Kror3MKocjfTw==
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
Subject: [PATCH net-next 02/10] net: stmmac: xgmac: add more feature parsing from hw cap
Date: Mon, 24 Jul 2023 00:10:21 +0800
Message-Id: <20230723161029.1345-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230723161029.1345-1-jszhang@kernel.org>
References: <20230723161029.1345-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The XGMAC_HWFEAT_GMIISEL bit also indicates whether support 10/100Mbps
or not.
The XGMAC_HWFEAT_HDSEL bit indicates whether support half duplex or
not.
The XGMAC_HWFEAT_ADDMACADRSEL bit indicates whether support Multiple
MAC address registers or not.
The XGMAC_HWFEAT_SMASEL bit indicates whether support SMA (MDIO)
Interface or not.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     | 3 +++
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 153321fe42c3..81cbb13a101d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -111,6 +111,7 @@
 #define XGMAC_LPI_TIMER_CTRL		0x000000d4
 #define XGMAC_HW_FEATURE0		0x0000011c
 #define XGMAC_HWFEAT_SAVLANINS		BIT(27)
+#define XGMAC_HWFEAT_ADDMACADRSEL	GENMASK(22, 18)
 #define XGMAC_HWFEAT_RXCOESEL		BIT(16)
 #define XGMAC_HWFEAT_TXCOESEL		BIT(14)
 #define XGMAC_HWFEAT_EEESEL		BIT(13)
@@ -121,7 +122,9 @@
 #define XGMAC_HWFEAT_MMCSEL		BIT(8)
 #define XGMAC_HWFEAT_MGKSEL		BIT(7)
 #define XGMAC_HWFEAT_RWKSEL		BIT(6)
+#define XGMAC_HWFEAT_SMASEL		BIT(5)
 #define XGMAC_HWFEAT_VLHASH		BIT(4)
+#define XGMAC_HWFEAT_HDSEL		BIT(3)
 #define XGMAC_HWFEAT_GMIISEL		BIT(1)
 #define XGMAC_HW_FEATURE1		0x00000120
 #define XGMAC_HWFEAT_L3L4FNUM		GENMASK(30, 27)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index b09395f5edcb..b5ba4e0cca55 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -406,6 +406,10 @@ static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
 	dma_cap->pmt_remote_wake_up = (hw_cap & XGMAC_HWFEAT_RWKSEL) >> 6;
 	dma_cap->vlhash = (hw_cap & XGMAC_HWFEAT_VLHASH) >> 4;
 	dma_cap->mbps_1000 = (hw_cap & XGMAC_HWFEAT_GMIISEL) >> 1;
+	dma_cap->mbps_10_100 = (hw_cap & XGMAC_HWFEAT_GMIISEL) >> 1;
+	dma_cap->half_duplex = (hw_cap & XGMAC_HWFEAT_HDSEL) >> 3;
+	dma_cap->multi_addr = (hw_cap & XGMAC_HWFEAT_ADDMACADRSEL) >> 18;
+	dma_cap->sma_mdio = (hw_cap & XGMAC_HWFEAT_SMASEL) >> 5;
 
 	/* MAC HW feature 1 */
 	hw_cap = readl(ioaddr + XGMAC_HW_FEATURE1);
-- 
2.40.1


