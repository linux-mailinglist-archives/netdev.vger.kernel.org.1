Return-Path: <netdev+bounces-250668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A93FD389DF
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 00:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9494B3002D3F
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 23:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3883161B8;
	Fri, 16 Jan 2026 23:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dpHIgoZQ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6E92DCC1F
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 23:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768605909; cv=none; b=roWWw7PHdl/pb0IYcLMGCwDpD190a5RjmpTj/Fe793kj59POa/R+winp8U/rmFPQDgJNvLcNJMRnbpJWrEz9amckoR2DPS9zeSEiO/DYXS8eBqAPMq/28PgXnU67cglNNqGtuPj5EPIs5xxauMFYqPwzij2fygGQZwoDfIMwtJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768605909; c=relaxed/simple;
	bh=irgeM8Nboc20yv0qBskz6KhlZ8H047L/xCOOI1e44tE=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=rHVL9MZImYMjiZY6Cn5TCp3U/wW3q8U3S3gUkmJGshsoFKSMeN6GuuFLbdlYdEdub9ef2H9HIoMHQKKAJ6g33lFJEyKC7fhN2wfVN4MAqvZjAVS0bDgkKT8N9Y44Dd7rAn34el5giOD7+/B8eH5I/HOXaCYZL8erqoqhUKora2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dpHIgoZQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kIYBZYHbSuff3l7sAHhcXWX3iDvTERmwHuTeLbzpX8M=; b=dpHIgoZQ4tpA8MPgX8U/cCNmEx
	KNNxBIgSO4gK7dP/F5e2CUKYtRIsD3BB3+ccG5ZSvu4Tao6OVcDQ6DT8LfOwcbwwxgtZEW5pb2GAQ
	b8qJ7gxL58jll05fvRI5itD2bhGmYLP6o6qjM1TkD+KdDq7r1dxWfCxUKHB1WDKJ0OOlL/aHEkZyZ
	9h246Y8yIrmN4rTzefaHapns2KyoEAp1NUVqYmLriYXyJLtRTwbIu/a3I1MsE01Gx3zN4V1vDCyX5
	OTh+OoF+VlpAsjuwRlfEZHt89Hjhj1Y2XnhDYiliuKYUYQhO+e83eNuv+xEdC2CakuTfA49aq5dFc
	LNJGraWA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52834 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vgtBc-000000002lj-3N0W;
	Fri, 16 Jan 2026 23:25:00 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vgtBc-00000005D6v-040n;
	Fri, 16 Jan 2026 23:25:00 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
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
Subject: [PATCH RFC net-next] net: stmmac: enable RPS and RBU interrupts
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vgtBc-00000005D6v-040n@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 16 Jan 2026 23:25:00 +0000

Enable receive process stopped and receive buffer unavailable
interrupts, so that the statistic counters can be updated.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---

Maxime,

You may find this patch useful, as it makes the "rx_buf_unav_irq"
and "rx_process_stopped_irq" ethtool statistic counters functional.
This means that the lack of receive descriptors can still be detected
even if the receive side doesn't actually stall.

I'm not sure why we publish these statistic counters if we don't
enable the interrupts to allow them to ever be non-zero.

 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
index 9d9077a4ac9f..d7f86b398abe 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
@@ -99,6 +99,8 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
 #define DMA_CHAN_INTR_ENA_NIE_4_10	BIT(15)
 #define DMA_CHAN_INTR_ENA_AIE_4_10	BIT(14)
 #define DMA_CHAN_INTR_ENA_FBE		BIT(12)
+#define DMA_CHAN_INTR_ENA_RPS		BIT(8)
+#define DMA_CHAN_INTR_ENA_RBU		BIT(7)
 #define DMA_CHAN_INTR_ENA_RIE		BIT(6)
 #define DMA_CHAN_INTR_ENA_TIE		BIT(0)
 
@@ -107,6 +109,8 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
 					 DMA_CHAN_INTR_ENA_TIE)
 
 #define DMA_CHAN_INTR_ABNORMAL		(DMA_CHAN_INTR_ENA_AIE | \
+					 DMA_CHAN_INTR_ENA_RPS | \
+					 DMA_CHAN_INTR_ENA_RBU | \
 					 DMA_CHAN_INTR_ENA_FBE)
 /* DMA default interrupt mask for 4.00 */
 #define DMA_CHAN_INTR_DEFAULT_MASK	(DMA_CHAN_INTR_NORMAL | \
@@ -119,6 +123,8 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
 					 DMA_CHAN_INTR_ENA_TIE)
 
 #define DMA_CHAN_INTR_ABNORMAL_4_10	(DMA_CHAN_INTR_ENA_AIE_4_10 | \
+					 DMA_CHAN_INTR_ENA_RPS | \
+					 DMA_CHAN_INTR_ENA_RBU | \
 					 DMA_CHAN_INTR_ENA_FBE)
 /* DMA default interrupt mask for 4.10a */
 #define DMA_CHAN_INTR_DEFAULT_MASK_4_10	(DMA_CHAN_INTR_NORMAL_4_10 | \
-- 
2.47.3


