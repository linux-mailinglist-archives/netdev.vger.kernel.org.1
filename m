Return-Path: <netdev+bounces-137334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DB19A586E
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 03:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB8B9B21605
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 01:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877E5C8CE;
	Mon, 21 Oct 2024 01:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="IvRt+qBB"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB09DDA8
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 01:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729472898; cv=none; b=r1dysc19ycIMy22W+4tsBCFBuUKs0I0nld0Zg+bfF/eQFcSlyr16ZBkesZvC2ZxmSg2C2SnfdnIcV9iGyz/US6i76DkyOIsoS5b9OlWwJQV9oWdEpyvWEr0eaZwGHuwgvqRUMqeI/38FE7RUAgXBOnyDhAti14md+Zpd47TYR7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729472898; c=relaxed/simple;
	bh=RdMhlqqkg+MjjMlwmkbvT3niaq2+CGtmgkWv1f5fzFE=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=bjTi2C74tmXijg7Sq24Eq+Q80xljPLhSMS7+8/9BYa2j/eNS/dzoQvATZbPRVXg/PLUxOFO/ESZxaO/mWE4U3wcCrP4HzG3s0nyAENEXz3SkSIHiiI9KxvZx7ZLdOqzrMpXGCchZbrTQs+gUOJ/JBCj3VyGOCAZQqw72+sbXnI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=IvRt+qBB; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1729472590; bh=pXdO7FzWdme0VVOEOK6+AI3hpoZS5YDRXo5kibSnml0=;
	h=From:To:Cc:Subject:Date;
	b=IvRt+qBBbeGG9CS7Fje80VwovXE/v97RkvRfMtc5zWWeyNhr5Y6YfoQpks3e0Gj2Y
	 pwqrWoOj/g0sruVBW+eDelBZd5mKMXjQpOqEhLu11k44vg4oVkWNDKVzVTsevWsFq1
	 912oRuTcia5p2icEbdH074bW19K2rRH/7354o390=
Received: from localhost ([58.246.87.66])
	by newxmesmtplogicsvrszgpuc1-0.qq.com (NewEsmtp) with SMTP
	id C7BECE2; Mon, 21 Oct 2024 09:03:07 +0800
X-QQ-mid: xmsmtpt1729472587tn8xvfi5d
Message-ID: <tencent_CCC29C4F562F2DEFE48289DB52F4D91BDE05@qq.com>
X-QQ-XMAILINFO: OUUXHEo9i1ukMlaV8FBgvyQA6Aslcp3UpBMlH8jpNXs53ckQAdSj0fGh3LvFlV
	 cLkLIPdZtk4ovPL3ZtKOIE+dv62rqEI86yEdye7KUVFgmIGpkXJn1PXXiZNoZ6q9fWYqAJojmAk1
	 eLoYEDR4QVXfaLt98p12DGZfnKVqybMkF+PYTMmy4ipuX/A6PaQhHlT5BTZd/SXEKaaxYs3Tmtf0
	 teAs5xH4XR4Aow21Xi5IuWtCmHO10OKNiTL6gC4QeRimqs5gsCScKeuuXPpMLixI0Mk/Azgo06fz
	 CahWY6GXbhhe881UmAF2sfcHbVzTtIJVaqTeS9nR+N8NGFldjkpzBHADpfZFtoVVinoLl6ojLSbR
	 cred4hRv12+bnqQQL2JbZWiDyll/WrFOWxJodS1ALOwWfxxuL1gWsITD20dSO0cmbLoPokACzhQM
	 E65R86YArLCNlp14RANPuy1Jlhj0kAPp+Wm33MC/ctz1obxW0Ky3zkdeiciFe4yK/389rUU33bgX
	 T6C6GEBExXw2MMG9iigfeKlJ/Pxl3Jqp95gyCuUOpsxtf7YkyIfN1q69zB4sMh7SRt1cdDVsx5Ui
	 c56muyusSIpLZodj9g64Akqfsr9qa+T86B8vspb0oJCC7zFj8UdwgkkWu0zU5OfvZ7qOyt79DqIh
	 oUHBeSEYOGQUOaNxu5OKqKIxRvwaiB4YCae2BUt9I24wVsuSBrbwAL60yag2VRUsQdvLnYtHmuPK
	 TnwvT6EmoqEpbDJUfX5EO4+c0KiSrCZZPaflnsoCF69K7jaQYNAvxTxBsjrWwmJTD1R8mjkkPwEL
	 cAiWxEEiaPyEzAh9E+a0tdq2hOJZ5Hv37QBxDBYglpxdrroSCVyl0wzSYR5/qWJb0FrE3VARr/C1
	 kq/DJCk9ixTZhtfLAb3J6qKvUFgTQPJ6TwcSK83nQyJoN1Pq8OGgY54un5hrpwls1SdSw+wVg9VQ
	 G3VdPLBLk=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: 2694439648@qq.com
To: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	hailong.fan@siengine.com
Subject: [PATCH v1] net: stmmac: enable MAC after MTL configuring
Date: Mon, 21 Oct 2024 09:03:05 +0800
X-OQ-MSGID: <9e4821f4b153f01611066ccc2b7d33416426a6ea.1729472506.git.hailong.fan@siengine.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "hailong.fan" <hailong.fan@siengine.com>

DMA maybe block while ETH is opening,
Adjust the enable sequence, put the MAC enable last

For example, ETH is directly connected to the switch,
which never power down and sends broadcast packets at regular intervals.
During the process of opening ETH, data may flow into the MTL FIFO,
once MAC RX is enabled. and then, MTL will be set, such as FIFO size.
Once enable DMA, There is a certain probability that DMA will read
incorrect data from MTL FIFO, causing DMA to hang up.
By read DMA_Debug_Status, you can be observed that the RPS remains at
a certain value forever. The correct process should be to configure
MAC/MTL/DMA before enabling DMA/MAC

Signed-off-by: hailong.fan <hailong.fan@siengine.com>

---
V0-V1:
   1. update commit messages
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c   |  8 --------
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 12 ------------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  6 +++---
 3 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
index 0d185e54e..92448d858 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
@@ -50,10 +50,6 @@ void dwmac4_dma_start_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
 
 	value |= DMA_CONTROL_ST;
 	writel(value, ioaddr + DMA_CHAN_TX_CONTROL(dwmac4_addrs, chan));
-
-	value = readl(ioaddr + GMAC_CONFIG);
-	value |= GMAC_CONFIG_TE;
-	writel(value, ioaddr + GMAC_CONFIG);
 }
 
 void dwmac4_dma_stop_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
@@ -77,10 +73,6 @@ void dwmac4_dma_start_rx(struct stmmac_priv *priv, void __iomem *ioaddr,
 	value |= DMA_CONTROL_SR;
 
 	writel(value, ioaddr + DMA_CHAN_RX_CONTROL(dwmac4_addrs, chan));
-
-	value = readl(ioaddr + GMAC_CONFIG);
-	value |= GMAC_CONFIG_RE;
-	writel(value, ioaddr + GMAC_CONFIG);
 }
 
 void dwmac4_dma_stop_rx(struct stmmac_priv *priv, void __iomem *ioaddr,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 7840bc403..cba12edc1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -288,10 +288,6 @@ static void dwxgmac2_dma_start_tx(struct stmmac_priv *priv,
 	value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
 	value |= XGMAC_TXST;
 	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
-
-	value = readl(ioaddr + XGMAC_TX_CONFIG);
-	value |= XGMAC_CONFIG_TE;
-	writel(value, ioaddr + XGMAC_TX_CONFIG);
 }
 
 static void dwxgmac2_dma_stop_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
@@ -302,10 +298,6 @@ static void dwxgmac2_dma_stop_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
 	value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
 	value &= ~XGMAC_TXST;
 	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
-
-	value = readl(ioaddr + XGMAC_TX_CONFIG);
-	value &= ~XGMAC_CONFIG_TE;
-	writel(value, ioaddr + XGMAC_TX_CONFIG);
 }
 
 static void dwxgmac2_dma_start_rx(struct stmmac_priv *priv,
@@ -316,10 +308,6 @@ static void dwxgmac2_dma_start_rx(struct stmmac_priv *priv,
 	value = readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
 	value |= XGMAC_RXST;
 	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
-
-	value = readl(ioaddr + XGMAC_RX_CONFIG);
-	value |= XGMAC_CONFIG_RE;
-	writel(value, ioaddr + XGMAC_RX_CONFIG);
 }
 
 static void dwxgmac2_dma_stop_rx(struct stmmac_priv *priv, void __iomem *ioaddr,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e21404822..c19ca62a4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3437,9 +3437,6 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 		priv->hw->rx_csum = 0;
 	}
 
-	/* Enable the MAC Rx/Tx */
-	stmmac_mac_set(priv, priv->ioaddr, true);
-
 	/* Set the HW DMA mode and the COE */
 	stmmac_dma_operation_mode(priv);
 
@@ -3523,6 +3520,9 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 	/* Start the ball rolling... */
 	stmmac_start_all_dma(priv);
 
+	/* Enable the MAC Rx/Tx */
+	stmmac_mac_set(priv, priv->ioaddr, true);
+
 	stmmac_set_hw_vlan_mode(priv, priv->hw);
 
 	return 0;
-- 
2.34.1


