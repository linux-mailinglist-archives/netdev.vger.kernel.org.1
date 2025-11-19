Return-Path: <netdev+bounces-239916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 60529C6DF69
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 11:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9109A383A59
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0367433555C;
	Wed, 19 Nov 2025 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="U6LmayG+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CF8328B7F
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 10:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763547824; cv=none; b=j+ohj9G6ZvzvVEL+euI9YLXykwG4i0bQNQjPWwzqOTZ7hy0hd1KUuVguDCEuPbVTa/jVfxYIG3J9ludtHPJnMwPIIpofO6sYOjCsSq4tCeavvWI39LNq6QNqFSok/Dww8QTEvZ1b1FGfT/t67JytVbICXcOqbr7GKZXVpT2lCzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763547824; c=relaxed/simple;
	bh=wa3DNnZHepn8SXb6ymA+u+uGgEh1D9CiwM99d7+ENQI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=cOG6WHE89N7kGKjx+t/rBkbKfgTUIpMX7djH9HFAERcaUXMD18MCK0EpKSb1yVLykhjNh/qVguV8kDGIyY04wax8LBx7OuWbOQIu0Ck5hcX766YiqQMTjMPQt4ftIVu/rfzJsU6suFjEAV0Z5fn+k0lhrvYRheSAWk/Vepkth+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=U6LmayG+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9iDncoQGiEhNI5V55KDLPdARKCA/m2+u9E1QVFZ9aCs=; b=U6LmayG+rUjbAk50jqbxIlpV3X
	BScBQJyk9bHJcCT1d0qwJEJinbuxGqzfnzp4PY06wC7iqSIggexELX3IShWwaC+sLeZLOj+qIqka+
	VtfsjcfIGK+bDk4O7RENLPcXoTKXCrZSiiZ3DqviQ7rrglDy6fsmKY0mKN43LkByDIUGC/C97a8IL
	zsaw/M8J296sfc9jePaEFUJpTzBVBonfE2l3G5/9u7i6rUTLLEWwKO9QU1u9XmEEhwAWUkL7MKY5u
	OPbHLX7GSeklOKNEs+jC9UEpEVwqVGAG41c5ZFDCkuSpNcfd3IFHxbMW4l/wnLBopyEzkpNtQ9I3E
	DZCP4vNw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39210 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vLfLX-000000004VS-0a0b;
	Wed, 19 Nov 2025 10:23:31 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vLfLW-0000000FMb1-0zKV;
	Wed, 19 Nov 2025 10:23:30 +0000
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
Subject: [PATCH net-next 4/6] net: stmmac: move stmmac_axi_blen_to_mask() to
 stmmac_main.c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vLfLW-0000000FMb1-0zKV@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 19 Nov 2025 10:23:30 +0000

Move the call to stmmac_axi_blen_to_mask() out of the individual
MAC version drivers into the main code in stmmac_init_dma_engine(),
passing the resulting value through a new member, axi_blen_regval,
in the struct stmmac_axi structure.

There is now no need for stmmac_axi_blen_to_dma_mask() to use
u32p_replace_bits(), so use FIELD_PREP() instead.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c | 3 +--
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c    | 3 +--
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c  | 3 +--
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   | 8 ++++++--
 include/linux/stmmac.h                              | 1 +
 5 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
index b6476a1bfeab..6d9b8fac3c6d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
@@ -41,8 +41,7 @@ static void dwmac1000_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
 	 * set). Note that the UNDEF bit is readonly, and is the inverse of
 	 * Bus Mode bit 16.
 	 */
-	stmmac_axi_blen_to_mask(&value, axi->axi_blen,
-				ARRAY_SIZE(axi->axi_blen));
+	value = (value & ~DMA_AXI_BLEN_MASK) | axi->axi_blen_regval;
 
 	writel(value, ioaddr + DMA_AXI_BUS_MODE);
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
index 90d03c7b29f4..7b513324cfb0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
@@ -40,8 +40,7 @@ static void dwmac4_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
 	 * set). Note that the UNDEF bit is readonly, and is the inverse of
 	 * Bus Mode bit 16.
 	 */
-	stmmac_axi_blen_to_mask(&value, axi->axi_blen,
-				ARRAY_SIZE(axi->axi_blen));
+	value = (value & ~DMA_AXI_BLEN_MASK) | axi->axi_blen_regval;
 
 	writel(value, ioaddr + DMA_SYS_BUS_MODE);
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 8a2cb6ca9588..cc1bdc0975d5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -106,8 +106,7 @@ static void dwxgmac2_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
 	 * set). Note that the UNDEF bit is readonly, and is the inverse of
 	 * Bus Mode bit 16.
 	 */
-	stmmac_axi_blen_to_mask(&value, axi->axi_blen,
-				ARRAY_SIZE(axi->axi_blen));
+	value = (value & ~DMA_AXI_BLEN_MASK) | axi->axi_blen_regval;
 
 	writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
 	writel(XGMAC_TDPS, ioaddr + XGMAC_TX_EDMA_CTRL);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e5ed61154557..99a7d4c463d9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -223,7 +223,7 @@ void stmmac_axi_blen_to_mask(u32 *regval, const u32 *blen, size_t len)
 		val |= burst >> 2;
 	}
 
-	u32p_replace_bits(regval, val, DMA_AXI_BLEN_MASK);
+	*regval = FIELD_PREP(DMA_AXI_BLEN_MASK, val);
 }
 
 /**
@@ -3212,8 +3212,12 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 	/* DMA Configuration */
 	stmmac_dma_init(priv, priv->ioaddr, priv->plat->dma_cfg);
 
-	if (priv->plat->axi)
+	if (priv->plat->axi) {
+		/* Encode the AXI burst length to a register value */
+		stmmac_axi_blen_to_mask(&priv->plat->axi->axi_blen_regval,
+					priv->plat->axi->axi_blen, AXI_BLEN);
 		stmmac_axi(priv, priv->ioaddr, priv->plat->axi);
+	}
 
 	/* DMA CSR Channel configuration */
 	for (chan = 0; chan < dma_csr_ch; chan++) {
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 673b068fdadf..d1a41fe0825f 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -113,6 +113,7 @@ struct stmmac_axi {
 	u32 axi_wr_osr_lmt;
 	u32 axi_rd_osr_lmt;
 	bool axi_kbbe;
+	u32 axi_blen_regval;
 	u32 axi_blen[AXI_BLEN];
 	bool axi_fb;
 	bool axi_mb;
-- 
2.47.3


