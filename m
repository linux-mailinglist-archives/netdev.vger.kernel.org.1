Return-Path: <netdev+bounces-162027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D6AA255F1
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 10:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033A516495E
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 09:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4747B1FF1DA;
	Mon,  3 Feb 2025 09:34:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F7F1D7E2F;
	Mon,  3 Feb 2025 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738575280; cv=none; b=nbr5vn8VUFQd0jPJD4t1fimcNNA7NrNNo38XJ9x1dwWxZrij9gIFgs5FDfJxk8gtdaHj9v7FwhkQ+bnGzkOFOF3IwwBoQ3A1BPn186UeGxhSxPaKhe6whHurbzJsfLfenNfJ3Y1wk2LVcLKr/EFvv84g0gq7sCIo/yZTmn/FZvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738575280; c=relaxed/simple;
	bh=nkiHB6RasytsIQBmTBEy0ydOxCTy7fIAttbMb3muzt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O7vxQHh6LT4bA7BKbgI14Zngcd6DbLDerbt3ilUZkidM18+g40iG5WnyewByaVbZQtxfL3A7/WLiq/k+KfcSrF9mD2lVqblxu06WLnY9PqKaYip3U+cl0A2zUMYTap3BZKKiqQgoJBzgcL5IVV1YjrBP4Lqzer7QNnmeBBMMhSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22B201063;
	Mon,  3 Feb 2025 01:35:02 -0800 (PST)
Received: from e122027.cambridge.arm.com (e122027.cambridge.arm.com [10.1.34.25])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CCE63F5A1;
	Mon,  3 Feb 2025 01:34:33 -0800 (PST)
From: Steven Price <steven.price@arm.com>
To: "David S. Miller" <davem@davemloft.net>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Steven Price <steven.price@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Furong Xu <0x1207@gmail.com>,
	Petr Tesarik <petr@tesarici.cz>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yanteng Si <si.yanteng@linux.dev>,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH] net: stmmac: Allow zero for [tr]x_fifo_size
Date: Mon,  3 Feb 2025 09:34:18 +0000
Message-ID: <20250203093419.25804-1-steven.price@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8865d22656b4 ("net: stmmac: Specify hardware capability value
when FIFO size isn't specified") modified the behaviour to bail out if
both the FIFO size and the hardware capability were both set to zero.
However devices where has_gmac4 and has_xgmac are both false don't use
the fifo size and that commit breaks platforms for which these values
were zero.

Only warn and error out when (has_gmac4 || has_xgmac) where the values
are used and zero would cause problems, otherwise continue with the zero
values.

Fixes: 8865d22656b4 ("net: stmmac: Specify hardware capability value when FIFO size isn't specified")
Tested-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d04543e5697b..821404beb629 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7222,7 +7222,7 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 	if (!priv->plat->rx_fifo_size) {
 		if (priv->dma_cap.rx_fifo_size) {
 			priv->plat->rx_fifo_size = priv->dma_cap.rx_fifo_size;
-		} else {
+		} else if (priv->plat->has_gmac4 || priv->plat->has_xgmac) {
 			dev_err(priv->device, "Can't specify Rx FIFO size\n");
 			return -ENODEV;
 		}
@@ -7236,7 +7236,7 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 	if (!priv->plat->tx_fifo_size) {
 		if (priv->dma_cap.tx_fifo_size) {
 			priv->plat->tx_fifo_size = priv->dma_cap.tx_fifo_size;
-		} else {
+		} else if (priv->plat->has_gmac4 || priv->plat->has_xgmac) {
 			dev_err(priv->device, "Can't specify Tx FIFO size\n");
 			return -ENODEV;
 		}
-- 
2.43.0


