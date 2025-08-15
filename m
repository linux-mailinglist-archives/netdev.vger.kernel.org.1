Return-Path: <netdev+bounces-214101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF03B2847E
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 18:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F04FF5625EE
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 16:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD0425782D;
	Fri, 15 Aug 2025 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6EZQOYO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DE81F582A;
	Fri, 15 Aug 2025 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276926; cv=none; b=h0RMSnmhE2FsKzVhZqlNGqtxbdoIM6HjaHPbdXHhpNlOZriWa2fN6RkXVEbAYdCIUqw2XZfanMqPK8wLrTc72T+mAUuj2tOkmhL0amsgpCeDyj78hB7wsJHcyUufzcHgtcFAkjSkAM4dDVbC75BO1uxOuROSEqCYeKBWWpI7Ga8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276926; c=relaxed/simple;
	bh=inws8rGfKLYVfokZMZsnBzF7qQWjCw/1Z/VQ/H87srg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CpiU5QZkyjGL2Bn6Hz5QyOcBqpRigYKjP5GqkOrkjhfBkgDWMTZALm4LbqFZv4YrAfk0WawKQ3yX7ldS5LRKZmJrnQCb9zTY9SU48ULCcllykkeYFsGpihg73OH+8M80CoEY+RpxtvwF96kEDtgFAixwwdn17dvFmr56HpyKTuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6EZQOYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB57DC4CEF5;
	Fri, 15 Aug 2025 16:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755276925;
	bh=inws8rGfKLYVfokZMZsnBzF7qQWjCw/1Z/VQ/H87srg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=D6EZQOYOAUAeF305N1gV7XWP8PF60SeQAOjLMO1wlTgas6veveIMLTz2fnidz4Oud
	 MBlT+tUJBdT2vTIoqV7HNodxVm56PUe6uX4yrHIgZ0N9Nz+XJxoUgztaIG9Zqjyzfp
	 FTaX3rEtIAcmi+r3E0BWxyri9Kr7Nke5dLq6on1qne25HkZ4DjjXw3HYTfuulfG1Qf
	 h1F1nKc7xxYp/slEvjKOo1513TSPOxA4UK9Fyb8dRDqvgN/fEXfbjq1Bb+OFXQyl8n
	 JvuJPqVf84UATwehLRVjdeeeix5KdgoczSsPe0THCCw4Oqmnoc3845oP1d85TXiv1b
	 ++Pk/8wWvYmcw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C56CA0ED1;
	Fri, 15 Aug 2025 16:55:25 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Date: Sat, 16 Aug 2025 00:55:23 +0800
Subject: [PATCH net-next v2 1/3] net: stmmac: xgmac: Do not enable RX FIFO
 Overflow interrupts
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250816-xgmac-minor-fixes-v2-1-699552cf8a7f@altera.com>
References: <20250816-xgmac-minor-fixes-v2-0-699552cf8a7f@altera.com>
In-Reply-To: <20250816-xgmac-minor-fixes-v2-0-699552cf8a7f@altera.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Serge Semin <fancer.lancer@gmail.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Jose Abreu <Jose.Abreu@synopsys.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rohan G Thomas <rohan.g.thomas@altera.com>, 
 Matthew Gerlach <matthew.gerlach@altera.com>, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755276924; l=1566;
 i=rohan.g.thomas@altera.com; s=20250815; h=from:subject:message-id;
 bh=E0GCiOkgubMN2NevEVBVfzpHtZM3l1Fx7YIgaGSXhBE=;
 b=OAU0E3PwMrRPvcg/pVQaA9iV5Ql2eiNQoRq+NwfecsLEHn+IbcprNx58bAx8/1GqsKDlnfZ81
 uRjhsjDGB0fA/n07LCtDi99v7dWkmYGkYG6I80P8piIOVSRWcgMpRt7
X-Developer-Key: i=rohan.g.thomas@altera.com; a=ed25519;
 pk=5yZXkXswhfUILKAQwoIn7m6uSblwgV5oppxqde4g4TY=
X-Endpoint-Received: by B4 Relay for rohan.g.thomas@altera.com/20250815
 with auth_id=494
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

Fixes: 2142754f8b9c ("net: stmmac: Add MAC related callbacks for XGMAC2")
Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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
2.32.0



