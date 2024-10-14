Return-Path: <netdev+bounces-135047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C110499BF6B
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 07:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCB551C216A0
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 05:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE7513B287;
	Mon, 14 Oct 2024 05:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="zA8OwGZW"
X-Original-To: netdev@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A59633998
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 05:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728884671; cv=none; b=M1Lt+YYHX+Ug1n8pZTfpjdB+UtAt2HYED20RfiuhKxPRvf3giZ0H9WWH3UCcD/3AEMtrtbWihXLYRKkTqhpqecfgVJ9P/45HPqw9+ji6xZIWYMvJuNMEzhKIZBmr5eCbfQWCZSvZ1yA24HkmqbzCxKkUbshhuG+DdMvkaaE7ODg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728884671; c=relaxed/simple;
	bh=A3SsPtjELHjf0XPV9pBjDTL4MKNQLICWboT88ToXqbo=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=NZEGcG6w2FR6JH+lYRaLu/Ai3v0AIe7UtRmeMkNXreeS8baxXmQeJiy2NPPbtloz9lkPCUpd99KYFgMjVbGYsz2qu3jpq5m06eBlErNouYc8ad4lkxNzeWS/B8tbKiPLLfNzeTM1iXXcTs6a6Ltln63gFnYJ5nu5BZIuvgczNWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=zA8OwGZW; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1728884664; bh=zykUKuNup4jjj1keaoTageR77Aw8N8gLKffRUfbNM1M=;
	h=From:To:Cc:Subject:Date;
	b=zA8OwGZWXCukl/ydwSbcvqyD8yX/nPrr3rRtOKEUbdDO9HAr1pikZpE0tgtpNKz75
	 6K4iwAWtUoDWrmTnkQQ/sjxBLdby+g2f9ZF3Td/wEgu/tZp8kJqX/onO4D8rQTURT7
	 tQXfZ3wYw13T1cP85vcnGbwMi8QqySuP/wY6Unes=
Received: from localhost ([58.246.87.66])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id B163EEA5; Mon, 14 Oct 2024 13:44:22 +0800
X-QQ-mid: xmsmtpt1728884662tem01wy8w
Message-ID: <tencent_6BF819F333D995B4D3932826194B9B671207@qq.com>
X-QQ-XMAILINFO: MtZ4zLDUQmWftoaGVfpgi0UBPJG43WK+AXmPEzJmz8wRePCudnUm7nInAQ5bbP
	 3bpr52/zBq3Ol7pFuvMCyrXQ3A4gTGwORfQbtUhisKL62AXBaEbJbVheb56+27TdtetLkvW2GKGi
	 op4Y56NyLqjeYzDRZYQZkBL+d21TC1K48LCW2mysmVPWwefd8kmXJXsOtoItoC2GBFqJa+9lgr8m
	 GilFcQxjLyCigjY+4Pqg5a3aeD5ilzCcul5Ah+wPdWM5ACM9U7ohwkaQ61/UUkIiI3kDnDDiqnVa
	 UWkq/PMynrkF7GY+Y/GAIy14GbikmFiqUC3XD9VNrvRW8ITkGarq2eZXC0EvLd2q9W800xNA2Wo4
	 8wrxZ/hc8B2Hjw1ywaPrcIban+k7LuUfXOQaTdEdZB5V0gcPYKqFmYILMmal9En8JpCARi3J4Tsm
	 7bHilsC7nJvp/TaSCFGBZXQvTZJ+kxAM18XEy6VoI1lhf71xBAbQYvvS+pQx8VX2FKre2pM3vx4w
	 lxXswVSQctN4fevpryZJ4v4YnbNkq1DfwFDvtFUt9PIuAbHerM/9JN2f76/fy/iaRnfJo3b+Eaq7
	 MMocBE5Ju2uZshXUKUp+CWaMJK+Sde0/oMKLyQg3YZAsN5lb1bhOgyJwDUhb6gQAOssII7TiA4zq
	 KHhcYW7XFsvZgmb+uhDK8ngWv0hFwUoyut7mLtnDzSzE/HLZDdIWdohdRCX4UTtTO7NYA+lqTRur
	 Ohj15rS+Ro6opPCj0c5EEAdn3xnxuxJT5mjrG6NYKPZ1lDMAMmyvjbMUMTvjFMtwudG68BndRDFD
	 UAzL+EtP/2TgsUgQZ56TO+rb1NOoourF+UH2mrEeiG97wEz6DoPhMODT6mMcLJ/ZemoDHMfuOkmR
	 QA9nzeCHZqmCVm8ynt8XSZKmiDckIOKsm5GIgatZ7s62RlukwuTMdSCasPT8ACxJyXoujIw19mYI
	 8U19seLMrdQMnsLB9bu4dfzh3X/LzR
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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
Subject: [PATCH] net: stmmac: enable MAC after MTL configuring
Date: Mon, 14 Oct 2024 13:44:03 +0800
X-OQ-MSGID: <20241014054403.71750-1-2694439648@qq.com>
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

Signed-off-by: hailong.fan <hailong.fan@siengine.com>
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


