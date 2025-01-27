Return-Path: <netdev+bounces-161075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B9AA1D343
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 10:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5541885592
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 09:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498491FDA84;
	Mon, 27 Jan 2025 09:25:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B68126BEE;
	Mon, 27 Jan 2025 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737969903; cv=none; b=T7V6Ej1oD/LnFzdll4+c84IDR/MKzbaOl1bhwOCQ4yU80pQVpUY5LrV6w36lSYPn8ea4QtGBaWvB4curHXpdML0qxi3DGiiKtHuMEzuAk5/3rqdzyoMTkMhz7LJYc5ltHCYf2RGGmQNz9v9ijqHwNAJ2PFE9SSPqsaEIZ15u2i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737969903; c=relaxed/simple;
	bh=EflSrG9KbKJ9RvEErWpM2cwRI+yKZfxPjt435VTpixE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PK975pT5u4kQI+lMp83WM+S3mNtk26BvkBWaFW/6gLWXtaVoXrthr95BDu5xz/5Rr4aZlBqmmVSPGmMguS6GMQDyFyjNN5LoA42zHvFvcbl9iRaEP7nuM8dGSUqQR5A0JOQ/3bPXMUccF5UPHC8krjdBCm8Wz+vK9jFpmxjOsTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 27 Jan 2025 18:24:59 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id BFEB32006FCC;
	Mon, 27 Jan 2025 18:24:59 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Mon, 27 Jan 2025 18:24:59 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id 1A431C3C1E;
	Mon, 27 Jan 2025 18:24:59 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH net 2/3] net: stmmac: Fix use of queue max macros for Rx coalesce
Date: Mon, 27 Jan 2025 18:24:49 +0900
Message-Id: <20250127092450.2945611-3-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250127092450.2945611-1-hayashi.kunihiko@socionext.com>
References: <20250127092450.2945611-1-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix macros for maximum queue number to keep consistency.

Fixes: db2f2842e6f5 ("net: stmmac: add per-queue TX & RX coalesce ethtool support")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 86c071baedf2..1793ddd69164 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -265,7 +265,7 @@ struct stmmac_priv {
 	/* Frequently used values are kept adjacent for cache effect */
 	u32 tx_coal_frames[MTL_MAX_TX_QUEUES];
 	u32 tx_coal_timer[MTL_MAX_TX_QUEUES];
-	u32 rx_coal_frames[MTL_MAX_TX_QUEUES];
+	u32 rx_coal_frames[MTL_MAX_RX_QUEUES];
 
 	int hwts_tx_en;
 	bool tx_path_in_lpi_mode;
@@ -275,7 +275,7 @@ struct stmmac_priv {
 	u32 sarc_type;
 
 	unsigned int rx_copybreak;
-	u32 rx_riwt[MTL_MAX_TX_QUEUES];
+	u32 rx_riwt[MTL_MAX_RX_QUEUES];
 	int hwts_rx_en;
 
 	void __iomem *ioaddr;
-- 
2.25.1


