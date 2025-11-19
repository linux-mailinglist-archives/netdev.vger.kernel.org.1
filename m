Return-Path: <netdev+bounces-239914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B71C6DFE6
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 11:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17F8E4F59E3
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2474834BA2D;
	Wed, 19 Nov 2025 10:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Zo7vfu7Z"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D96B72623
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 10:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763547810; cv=none; b=bGosLSFhPyWNTMSdwEMgRhMNfj0wqf/DCllp7UzW2cLXwK9uKk3htgFks6vpG6TgQzECechW67aUChRf19p9K+pK7QcaftX3/Od68uzymOn+beqTjLZ/HlHufqRNUZppmSVPciDy9jdCg3Nr50Mg2jEXO3eQMUAZGr8mAoxJrGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763547810; c=relaxed/simple;
	bh=lQWUU15NmoZUmUKJJ0DXuOb2w7FjFKo6nq8WuJd5jes=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=XCbxjFTGqNBmoYalyC/hmWrqwvHaN1iqXYFRS14Sqg44p7RWa902JK12u9OW8D3+aMDJE8y4jiHcAOi34bzRWj3SIXK0AbO5YTzgdq38sSB8nDG6STlHiy7mRr1A7UEKt49Om15fG2G86W2T9cJkK0a5zO6JzQlxcMIKiGmuPTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Zo7vfu7Z; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sbRkLsOzrPKfiOjtitRKcKtlTS1mD+vXrFtZbAGt4MQ=; b=Zo7vfu7Z6HTQHQvm2FYRanNvTh
	1eTs+K0wgvZnVzuYb/rlhngHfF+SSxcoC5Mws6OrriKZipx3nQHhyQqvKruhUfvvOQypt+OI6Lq36
	xc8Wf5twdC6E1ByYQoQ6WRiXq66CB1LE7GqQ+0j05OjyBLFMp2bOPdxCCutKfWGrE9VaQU/Q8bxMD
	XgYaI3fbgxSjkEWC0UZAOL6RGdxwaC9y9e/3gOb+jGgb7Lw6D3In0u4BY9E1TWddxpw+E45a5G7+F
	U8B9P92swp13X8nkSGhzBsRx0FIXnS8pJynrHdBlZR4Xkhe6RRG8XzVONLN1ZhuiS/qFUGk+P0MDw
	F7UJ2GhA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48928 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vLfLM-000000004Us-3O3A;
	Wed, 19 Nov 2025 10:23:20 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vLfLL-0000000FMap-49gf;
	Wed, 19 Nov 2025 10:23:20 +0000
In-Reply-To: <aR2aaDs6rqfu32B-@shell.armlinux.org.uk>
References: <aR2aaDs6rqfu32B-@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 2/6] net: stmmac: move common DMA AXI register bits
 to common.h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vLfLL-0000000FMap-49gf@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 19 Nov 2025 10:23:19 +0000

Move the common DMA AXI register bits to common.h so they can be shared
and we can provide a common function to convert the axi->dma_blen[]
array to the format needed for this register.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/common.h     | 10 ++++++++++
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h |  9 +--------
 drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h  | 11 ++---------
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h   | 16 ++++++++--------
 4 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 7395bbb94aea..3c6e7fe7b999 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -548,6 +548,16 @@ struct dma_features {
 #define LPI_CTRL_STATUS_TLPIEX	BIT(1)	/* Transmit LPI Exit */
 #define LPI_CTRL_STATUS_TLPIEN	BIT(0)	/* Transmit LPI Entry */
 
+/* Common definitions for AXI Master Bus Mode */
+#define DMA_AXI_AAL		BIT(12)
+#define DMA_AXI_BLEN256		BIT(7)
+#define DMA_AXI_BLEN128		BIT(6)
+#define DMA_AXI_BLEN64		BIT(5)
+#define DMA_AXI_BLEN32		BIT(4)
+#define DMA_AXI_BLEN16		BIT(3)
+#define DMA_AXI_BLEN8		BIT(2)
+#define DMA_AXI_BLEN4		BIT(1)
+
 #define STMMAC_CHAIN_MODE	0x1
 #define STMMAC_RING_MODE	0x2
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
index 4f980dcd3958..dfcb7ce79e76 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
@@ -69,15 +69,8 @@
 
 #define DMA_SYS_BUS_MB			BIT(14)
 #define DMA_AXI_1KBBE			BIT(13)
-#define DMA_SYS_BUS_AAL			BIT(12)
+#define DMA_SYS_BUS_AAL			DMA_AXI_AAL
 #define DMA_SYS_BUS_EAME		BIT(11)
-#define DMA_AXI_BLEN256			BIT(7)
-#define DMA_AXI_BLEN128			BIT(6)
-#define DMA_AXI_BLEN64			BIT(5)
-#define DMA_AXI_BLEN32			BIT(4)
-#define DMA_AXI_BLEN16			BIT(3)
-#define DMA_AXI_BLEN8			BIT(2)
-#define DMA_AXI_BLEN4			BIT(1)
 #define DMA_SYS_BUS_FB			BIT(0)
 
 #define DMA_BURST_LEN_DEFAULT		(DMA_AXI_BLEN256 | DMA_AXI_BLEN128 | \
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
index 5d9c18f5bbf5..967a735e9a0b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
@@ -68,20 +68,13 @@ static inline u32 dma_chan_base_addr(u32 base, u32 chan)
 #define DMA_AXI_OSR_MAX		0xf
 #define DMA_AXI_MAX_OSR_LIMIT ((DMA_AXI_OSR_MAX << DMA_AXI_WR_OSR_LMT_SHIFT) | \
 			       (DMA_AXI_OSR_MAX << DMA_AXI_RD_OSR_LMT_SHIFT))
-#define	DMA_AXI_1KBBE		BIT(13)
-#define DMA_AXI_AAL		BIT(12)
-#define DMA_AXI_BLEN256		BIT(7)
-#define DMA_AXI_BLEN128		BIT(6)
-#define DMA_AXI_BLEN64		BIT(5)
-#define DMA_AXI_BLEN32		BIT(4)
-#define DMA_AXI_BLEN16		BIT(3)
-#define DMA_AXI_BLEN8		BIT(2)
-#define DMA_AXI_BLEN4		BIT(1)
 #define DMA_BURST_LEN_DEFAULT	(DMA_AXI_BLEN256 | DMA_AXI_BLEN128 | \
 				 DMA_AXI_BLEN64 | DMA_AXI_BLEN32 | \
 				 DMA_AXI_BLEN16 | DMA_AXI_BLEN8 | \
 				 DMA_AXI_BLEN4)
 
+#define	DMA_AXI_1KBBE		BIT(13)
+
 #define DMA_AXI_UNDEF		BIT(0)
 
 #define DMA_AXI_BURST_LEN_MASK	0x000000FE
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index e48cfa05000c..16c6d03fc929 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -338,16 +338,16 @@
 #define XGMAC_RD_OSR_LMT_SHIFT		16
 #define XGMAC_EN_LPI			BIT(15)
 #define XGMAC_LPI_XIT_PKT		BIT(14)
-#define XGMAC_AAL			BIT(12)
+#define XGMAC_AAL			DMA_AXI_AAL
 #define XGMAC_EAME			BIT(11)
 #define XGMAC_BLEN			GENMASK(7, 1)
-#define XGMAC_BLEN256			BIT(7)
-#define XGMAC_BLEN128			BIT(6)
-#define XGMAC_BLEN64			BIT(5)
-#define XGMAC_BLEN32			BIT(4)
-#define XGMAC_BLEN16			BIT(3)
-#define XGMAC_BLEN8			BIT(2)
-#define XGMAC_BLEN4			BIT(1)
+#define XGMAC_BLEN256			DMA_AXI_BLEN256
+#define XGMAC_BLEN128			DMA_AXI_BLEN128
+#define XGMAC_BLEN64			DMA_AXI_BLEN64
+#define XGMAC_BLEN32			DMA_AXI_BLEN32
+#define XGMAC_BLEN16			DMA_AXI_BLEN16
+#define XGMAC_BLEN8			DMA_AXI_BLEN8
+#define XGMAC_BLEN4			DMA_AXI_BLEN4
 #define XGMAC_UNDEF			BIT(0)
 #define XGMAC_TX_EDMA_CTRL		0x00003040
 #define XGMAC_TDPS			GENMASK(29, 0)
-- 
2.47.3


