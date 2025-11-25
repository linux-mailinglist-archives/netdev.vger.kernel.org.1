Return-Path: <netdev+bounces-241578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA4BC85FE8
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5641834C562
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 16:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FBF329362;
	Tue, 25 Nov 2025 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nndKed/q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3275C1487E9;
	Tue, 25 Nov 2025 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764088638; cv=none; b=Za4ZqkZw/trIYQCF6cM+4sSoSQ9ZzDE6V+NHTVXTW2MUNzHeBE0JnJvi5NM7xkltYMxcfGTeudwIF25FEpLWYMYuKJyiT5ZHena7DojF4zl9I4fvtsMpibopg/AHhOYq1FmG/zy7afpgs5y8SBtTW21aDqSze3XhSMyc3aOk+Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764088638; c=relaxed/simple;
	bh=nBeML0ip1QW4LgnV9TIkkO+eD75Thqh7vMCTrOjDcoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GZQ4DsbF2A9arTibA2HzYaYB6+d3U6yzvj4WushzG5JhWTIYoTjvLl0ivSZ4t/vhMn6/ps6MSPhT1bHnmDyg9oU+yF8QRrThk3gAMnYKsfUspT8XxIT40BuNAfezXG96iqtZ4XG77JR2MfX2J3th5wbrLUPH7gh0tykhfLwzpp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nndKed/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 975F9C4CEF1;
	Tue, 25 Nov 2025 16:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764088637;
	bh=nBeML0ip1QW4LgnV9TIkkO+eD75Thqh7vMCTrOjDcoU=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=nndKed/qvsGzyjQlpMxhJr5D8NDa+9pN2yxdtF96KeTreqZpkq5/JTdojK6YoKppl
	 Zy9vAqTZcpuSVzs5ajKlCPCfw6m4ru9lIoDvdlWnzCoAG9obF3xqT2UbR7iLQ60KRA
	 rKaSUfhg03RpuG+CkMbnHA7/iqyVuPqQwu1V2Yif6hWxg84aFi/THEe5qpcw8IAc58
	 +4EB+VkfYwbXU6Z94DYDb/vb7d9LMSYYeOajfYIHxo8K2Oycuf7/25YdT30DF2A+GR
	 cIt+d6oPRB5OfjY2Jvn1Gn+egl5ivHiUDrjRFabwbEpK7wTSiDDm9FnR+mWKoh33uh
	 J7WHOcJmDK2sA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81943D0EE00;
	Tue, 25 Nov 2025 16:37:17 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Date: Wed, 26 Nov 2025 00:37:12 +0800
Subject: [PATCH net-next] net: stmmac: dwmac: Disable flushing frames on Rx
 Buffer Unavailable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-a10_ext_fix-v1-1-d163507f646f@altera.com>
X-B4-Tracking: v=1; b=H4sIADfbJWkC/x2MSwqAMAwFr1KyttAUItariIifqNlUaUWE4t0NL
 ucxbwpkTsIZWlMg8S1ZjqiAlYF5H+PGVhZl8M4Toic7ohv4uYZVHkuBsHE0heBq0MeZWOe/1kH
 ky0Y1oX/fDzRrBKVnAAAA
X-Change-ID: 20251125-a10_ext_fix-5951805b9906
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rohan G Thomas <rohan.g.thomas@altera.com>, 
 Matthew Gerlach <matthew.gerlach@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764088636; l=6674;
 i=rohan.g.thomas@altera.com; s=20250815; h=from:subject:message-id;
 bh=1yOOam2AS2+5uDLyswXLrju6hz3Fas3Llt1CFCEF2XQ=;
 b=0nGCrQtOBgw4LLg/JEC16HfXKFngX7ZaZTAAG3vvYoi54fUKNVpkF6bRXIgxRlb7WXsCcGQjU
 dUDM7EjLUYEBhyqE0IYhZ/QVwrrpo3yYvvkDOPFJ42WkL9Oa9jBoOvv
X-Developer-Key: i=rohan.g.thomas@altera.com; a=ed25519;
 pk=5yZXkXswhfUILKAQwoIn7m6uSblwgV5oppxqde4g4TY=
X-Endpoint-Received: by B4 Relay for rohan.g.thomas@altera.com/20250815
 with auth_id=494
X-Original-From: Rohan G Thomas <rohan.g.thomas@altera.com>
Reply-To: rohan.g.thomas@altera.com

From: Rohan G Thomas <rohan.g.thomas@altera.com>

In Store and Forward mode, flushing frames when the receive buffer is
unavailable, can cause the MTL Rx FIFO to go out of sync. This results
in buffering of a few frames in the FIFO without triggering Rx DMA
from transferring the data to the system memory until another packet
is received. Once the issue happens, for a ping request, the packet is
forwarded to the system memory only after we receive another packet
and hece we observe a latency equivalent to the ping interval.

64 bytes from 192.168.2.100: seq=1 ttl=64 time=1000.344 ms

Also, we can observe constant gmacgrp_debug register value of
0x00000120, which indicates "Reading frame data".

The issue is not reproducible after disabling frame flushing when Rx
buffer is unavailable. But in that case, the Rx DMA enters a suspend
state due to buffer unavailability. To resume operation, software
must write to the receive_poll_demand register after adding new
descriptors, which reactivates the Rx DMA.

This issue is observed in the socfpga platforms which has dwmac1000 IP
like Arria 10, Cyclone V and Agilex 7. Issue is reproducible after
running iperf3 server at the DUT for UDP lower packet sizes.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c | 5 +++--
 drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h     | 1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c     | 5 +++++
 drivers/net/ethernet/stmicro/stmmac/hwif.h          | 3 +++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   | 2 ++
 5 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
index 6d9b8fac3c6d0fd76733ab4a1a8cce2420fa40b4..5877fec9f6c30ed18cdcf5398816e444e0bd0091 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
@@ -135,10 +135,10 @@ static void dwmac1000_dma_operation_mode_rx(struct stmmac_priv *priv,
 
 	if (mode == SF_DMA_MODE) {
 		pr_debug("GMAC: enable RX store and forward mode\n");
-		csr6 |= DMA_CONTROL_RSF;
+		csr6 |= DMA_CONTROL_RSF | DMA_CONTROL_DFF;
 	} else {
 		pr_debug("GMAC: disable RX SF mode (threshold %d)\n", mode);
-		csr6 &= ~DMA_CONTROL_RSF;
+		csr6 &= ~(DMA_CONTROL_RSF | DMA_CONTROL_DFF);
 		csr6 &= DMA_CONTROL_TC_RX_MASK;
 		if (mode <= 32)
 			csr6 |= DMA_CONTROL_RTC_32;
@@ -262,6 +262,7 @@ const struct stmmac_dma_ops dwmac1000_dma_ops = {
 	.dma_rx_mode = dwmac1000_dma_operation_mode_rx,
 	.dma_tx_mode = dwmac1000_dma_operation_mode_tx,
 	.enable_dma_transmission = dwmac_enable_dma_transmission,
+	.enable_dma_reception = dwmac_enable_dma_reception,
 	.enable_dma_irq = dwmac_enable_dma_irq,
 	.disable_dma_irq = dwmac_disable_dma_irq,
 	.start_tx = dwmac_dma_start_tx,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
index d1c149f7a3dd9e472b237101666e11878707f0f2..054ecb20ce3f68bce5da3efaf36acf33e430d3f0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
@@ -169,6 +169,7 @@ static inline u32 dma_chan_base_addr(u32 base, u32 chan)
 #define NUM_DWMAC4_DMA_REGS	27
 
 void dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan);
+void dwmac_enable_dma_reception(void __iomem *ioaddr, u32 chan);
 void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
 			  u32 chan, bool rx, bool tx);
 void dwmac_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
index 467f1a05747ecf0be5b9f3392cd3d2049d676c21..97a803d68e3a2f120beaa7c3254748cf404236df 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
@@ -33,6 +33,11 @@ void dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan)
 	writel(1, ioaddr + DMA_CHAN_XMT_POLL_DEMAND(chan));
 }
 
+void dwmac_enable_dma_reception(void __iomem *ioaddr, u32 chan)
+{
+	writel(1, ioaddr + DMA_CHAN_RCV_POLL_DEMAND(chan));
+}
+
 void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
 			  u32 chan, bool rx, bool tx)
 {
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index f257ce4b6c66e0bbd3180d54ac7f5be934153a6b..df6e8a567b1f646f83effbb38d8e53441a6f6150 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -201,6 +201,7 @@ struct stmmac_dma_ops {
 	void (*dma_diagnostic_fr)(struct stmmac_extra_stats *x,
 				  void __iomem *ioaddr);
 	void (*enable_dma_transmission)(void __iomem *ioaddr, u32 chan);
+	void (*enable_dma_reception)(void __iomem *ioaddr, u32 chan);
 	void (*enable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
 			       u32 chan, bool rx, bool tx);
 	void (*disable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
@@ -261,6 +262,8 @@ struct stmmac_dma_ops {
 	stmmac_do_void_callback(__priv, dma, dma_diagnostic_fr, __args)
 #define stmmac_enable_dma_transmission(__priv, __args...) \
 	stmmac_do_void_callback(__priv, dma, enable_dma_transmission, __args)
+#define stmmac_enable_dma_reception(__priv, __args...) \
+	stmmac_do_void_callback(__priv, dma, enable_dma_reception, __args)
 #define stmmac_enable_dma_irq(__priv, __args...) \
 	stmmac_do_void_callback(__priv, dma, enable_dma_irq, __priv, __args)
 #define stmmac_disable_dma_irq(__priv, __args...) \
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 6cacedb2c9b3fefdd4c9ec8ba98d389443d21ebd..1ecca60baf74286da7f156b4c3c835b3cbabf1ba 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4973,6 +4973,8 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
 	rx_q->rx_tail_addr = rx_q->dma_rx_phy +
 			    (rx_q->dirty_rx * sizeof(struct dma_desc));
 	stmmac_set_rx_tail_ptr(priv, priv->ioaddr, rx_q->rx_tail_addr, queue);
+	/* Wake up Rx DMA from the suspend state if required */
+	stmmac_enable_dma_reception(priv, priv->ioaddr, queue);
 }
 
 static unsigned int stmmac_rx_buf1_len(struct stmmac_priv *priv,

---
base-commit: e3daf0e7fe9758613bec324fd606ed9caa187f74
change-id: 20251125-a10_ext_fix-5951805b9906

Best regards,
-- 
Rohan G Thomas <rohan.g.thomas@altera.com>



