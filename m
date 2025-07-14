Return-Path: <netdev+bounces-206580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C98AB03892
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 10:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 514807AADF9
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 07:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D6623A9BF;
	Mon, 14 Jul 2025 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDrDuibB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDC9223324;
	Mon, 14 Jul 2025 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752480028; cv=none; b=owXfBeXm2UQL5kpAGKzUtOPW+otQJsrOO21CTYLIfUdf0dyS3awIjWq2M5UOPMb8xbdWZ59f+G/+YzdOMSbAHxrYv18slB77HGYopbjT/V2WAZWh8zoEWVo2OWWyglbqJhYKOaa/BvwvlRUJKq6QT8YmozhCyZnYa2514JLpUUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752480028; c=relaxed/simple;
	bh=XpzvAHUxAzYVFgTQa2ypdhi4koHcoO778v2ak/zqA4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ndsWBtUjLB5MLpjvv46lqmDp1BICgqS2928WAt8rUtVvz/Ov2fr2i3tL7pBa6Zf0BND6KcxCcifPzmR0ymHxse/wAu54lzLk5cE8WLOt/fhNMt2ow7vG6WWkCHidZkh0RyPfB9axMRgshvIGiM+a5xFrebyqK2kU+hAJwXabCJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDrDuibB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E15EDC4CEF5;
	Mon, 14 Jul 2025 08:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752480028;
	bh=XpzvAHUxAzYVFgTQa2ypdhi4koHcoO778v2ak/zqA4E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HDrDuibBTCydpiKJ0NbveuCOlz7D3WxJr3Rf8dLFGuFGFjp0wpaLejaB8MuItUD+1
	 BL2dih69sQ6thOdZodL3eqIvpYNdPD396Pdhi5xkWqsuTcRN6lzycgmgC5oi8+4jif
	 BN77iEwF2KWHaOVGfgkndxiPW3c3yc7Z3UyaEv7MHbMQdaOdRwWUB9Bbe3MyUEBEPB
	 CfoQaBRoa3BxpUVICYUgQzyOt6HW2nAzvm1rersBHsjZ8JS2t9eQZaExlXZcfaMgQ+
	 4+yL/dJACiSGqixmATbMO6Ufr50HRhEZzHxnt2Ndt+mZSt1Xz3I5Z9V8HqlGvXwzyZ
	 m+jMqI87e1UmA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D094CC83F1B;
	Mon, 14 Jul 2025 08:00:27 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Date: Mon, 14 Jul 2025 15:59:17 +0800
Subject: [PATCH net-next 1/3] net: stmmac: xgmac: Disable RX FIFO Overflow
 interrupts
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-xgmac-minor-fixes-v1-1-c34092a88a72@altera.com>
References: <20250714-xgmac-minor-fixes-v1-0-c34092a88a72@altera.com>
In-Reply-To: <20250714-xgmac-minor-fixes-v1-0-c34092a88a72@altera.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Serge Semin <fancer.lancer@gmail.com>, 
 Romain Gantois <romain.gantois@bootlin.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rohan G Thomas <rohan.g.thomas@altera.com>, 
 Matthew Gerlach <matthew.gerlach@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752480026; l=1448;
 i=rohan.g.thomas@altera.com; s=20250415; h=from:subject:message-id;
 bh=oFA2+kb2AvW4R/3k8yiyiYdyPGfCRckJUe8sIarPelM=;
 b=EpWkcMwrFCOnahq0Sl2yqqNCuHkZ5+aiumNQUuGm3nIiRP/zrTLO8zBmThd3neqcinM6oKkYO
 eznyo+EFxqaBHNVY5L+WIa8S1nkwy9pKMLTjSZ2QiRppcCei+eDBdO+
X-Developer-Key: i=rohan.g.thomas@altera.com; a=ed25519;
 pk=TLFM1xzY5sPOABaIaXHDNxCAiDwRegVWoy1tP842z5E=
X-Endpoint-Received: by B4 Relay for rohan.g.thomas@altera.com/20250415
 with auth_id=460
X-Original-From: Rohan G Thomas <rohan.g.thomas@altera.com>
Reply-To: rohan.g.thomas@altera.com

From: Rohan G Thomas <rohan.g.thomas@altera.com>

Enabling RX FIFO Overflow interrupts is counterproductive
and causes an interrupt storm when RX FIFO overflows.
Disabling this interrupt has no side effect and eliminates
interrupt storms when the RX FIFO overflows.

Commit 8a7cb245cf28 ("net: stmmac: Do not enable RX FIFO
overflow interrupts") disables RX FIFO overflow interrupts
for DWMAC4 IP and removes the corresponding handling of
this interrupt. This patch is doing the same thing for
XGMAC IP.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 5dcc95bc0ad28b756accf9670c5fa00aa94fcfe3..7201a38842651a865493fce0cefe757d6ae9bafa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -203,10 +203,6 @@ static void dwxgmac2_dma_rx_mode(struct stmmac_priv *priv, void __iomem *ioaddr,
 	}
 
 	writel(value, ioaddr + XGMAC_MTL_RXQ_OPMODE(channel));
-
-	/* Enable MTL RX overflow */
-	value = readl(ioaddr + XGMAC_MTL_QINTEN(channel));
-	writel(value | XGMAC_RXOIE, ioaddr + XGMAC_MTL_QINTEN(channel));
 }
 
 static void dwxgmac2_dma_tx_mode(struct stmmac_priv *priv, void __iomem *ioaddr,

-- 
2.25.1



