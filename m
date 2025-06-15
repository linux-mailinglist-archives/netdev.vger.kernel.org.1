Return-Path: <netdev+bounces-197881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C409ADA236
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 17:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DAD13B25C8
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 15:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509BF1C2335;
	Sun, 15 Jun 2025 15:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="U6K+sQPA"
X-Original-To: netdev@vger.kernel.org
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE431B423C;
	Sun, 15 Jun 2025 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749999839; cv=none; b=Cm3RC8TPTWU4c06lOACxk8EUUwZbNdYJzlavJuAkkVPxLkZV8q6Z2lC0ha4VvYXWYroPyX9+/QPdGq1OXpU8pUcc2qdaqVuJ+O6u5g4MJU8B4FeTbrsG5YJiWC4mqzbORUH9DZvGMMyDvIb/ZptqGThM59arSmu2xt6i3sLttNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749999839; c=relaxed/simple;
	bh=zNruei/Wq6DKudfKhgOlK/LAw0QNeY727tGMxqK5EFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCrPj6CLiJpyQhH6hOrh5R0z1DvV5gbWvRb7hJSRsgFpi2Whcu9RHQElmdyu811AamN6qcJBoASAMVuqmx0yG0r92lppfq82YHsrytXvswVrEcV7jhfZ5372trrNiF4HKxnprh2F/NYfE+UkMFPzFiJhv5Ilr/H4gUhjH3+eWGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=U6K+sQPA; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout1.routing.net (Postfix) with ESMTP id 693CA3FF6D;
	Sun, 15 Jun 2025 15:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1749999829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMCo+VFbKtuUjRwVkhv/z0zUgSXTtEAWBF4/x1hCKa8=;
	b=U6K+sQPA5/Dakm2sC94GpFCh+jFoVm5cqODuYLmxyarK2SX5IitN5I997cJETNty7qAZBB
	y7bO8ywAeRW2z2TI+hiVhu3mqDPAZFlTn3p3KZ/ODOXwUaJdA1Mtox/0z+Z/uaa5hNTUbN
	v2/z7RhKKDPOLvjmt2N5ouJXXUsxF7o=
Received: from frank-u24.. (fttx-pool-217.61.157.124.bambit.de [217.61.157.124])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 2E55C122704;
	Sun, 15 Jun 2025 15:03:49 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Simon Horman <horms@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>
Subject: [net-next v3 3/3] net: ethernet: mtk_eth_soc: change code to skip first IRQ completely
Date: Sun, 15 Jun 2025 17:03:18 +0200
Message-ID: <20250615150333.166202-4-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250615150333.166202-1-linux@fw-web.de>
References: <20250615150333.166202-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

On SoCs without MTK_SHARED_INT capability (mt7621 + mt7628) the first
IRQ (eth->irq[0]) was read but never used. Skip reading it now too.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 11 ++++++++---
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  4 ++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 9aec67c9c6d7..4d7de282b940 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -3346,10 +3346,15 @@ static int mtk_get_irqs(struct platform_device *pdev, struct mtk_eth *eth)
 		return 0;
 
 	for (i = 0; i < MTK_ETH_IRQ_MAX; i++) {
-		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT) && i > 0)
-			eth->irq[i] = eth->irq[MTK_ETH_IRQ_SHARED];
+		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT)) {
+			if (i == 0)
+				eth->irq[MTK_ETH_IRQ_SHARED] = platform_get_irq(pdev, i);
+			else
+				eth->irq[i] = eth->irq[MTK_ETH_IRQ_SHARED];
+		} else if (i < 2)  //skip the 1st and 4th IRQ on !MTK_SHARED_INT
+			eth->irq[i] = platform_get_irq(pdev, i + 1);
 		else
-			eth->irq[i] = platform_get_irq(pdev, i);
+			continue;
 
 		if (eth->irq[i] < 0) {
 			dev_err(&pdev->dev, "no IRQ%d resource found\n", i);
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 6b1208d05f79..ff2ae3c80179 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -643,8 +643,8 @@
 #define MTK_MAC_FSM(x)		(0x1010C + ((x) * 0x100))
 
 #define MTK_ETH_IRQ_SHARED	0
-#define MTK_ETH_IRQ_TX		1
-#define MTK_ETH_IRQ_RX		2
+#define MTK_ETH_IRQ_TX		0
+#define MTK_ETH_IRQ_RX		1
 #define MTK_ETH_IRQ_MAX		3
 
 struct mtk_rx_dma {
-- 
2.43.0


