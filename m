Return-Path: <netdev+bounces-197879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D8EADA232
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 17:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0181216DC67
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 15:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DD3195FE8;
	Sun, 15 Jun 2025 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="J8Yqe5gw"
X-Original-To: netdev@vger.kernel.org
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BEB1DFCE;
	Sun, 15 Jun 2025 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749999833; cv=none; b=Xv20A1blMxQnulGIMefVXVDHiTRJkCM2sFgloRpJVtjAUY54sPSQq0IuuzKTMzmkBneCtIpZMRck/xF3gM7fJwqfRFfyoypiIJ6lZ7rk6kcxmZUNaUAHcaxwg2dyOTh+dCM/wX2RtUHae59Bl1rrg/HciBHxgCX72+U7R9fHKy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749999833; c=relaxed/simple;
	bh=ZFr4QXz7uBQKE0XCTjQ03VCU73ORvAP4grrovwS4gDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZGHJXL2jJFXcC23/IO3ZeKuID2PazyxplJ4BKdoNXFWNjYIKsa5qWJ2kPaeStrn+q6fIDL0sHgKYRD8Z07W2W4HRQk9qDfFBKSxvaera4oJqdRiywVIuFbHsqsrEdKE6QrxV3EbCc0NLWgWgRlC1lS6Os6hWdte6h3nNJAXzzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=J8Yqe5gw; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout3.routing.net (Postfix) with ESMTP id D94FD601A6;
	Sun, 15 Jun 2025 15:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1749999829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aixnyQqpwBBGhHOV75XTz3/geaACNpR9Nv0eB+S8FK0=;
	b=J8Yqe5gwIPPcjzAuk6Glt67DYlSm3Akx7NALxfTtUJ3av+yOpI8e9+oiW+8cUnhmb2Wm8A
	RYEy2ZBEupAiQVhN+P/TA5F/5S9xF67C+Mk1cKeIYc3a/w1qEjYUW+q1VsQk1TiEUGimU0
	0FbU8dlJ9qnkYHRXCmWhcVb4Drg8trc=
Received: from frank-u24.. (fttx-pool-217.61.157.124.bambit.de [217.61.157.124])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id A0566122704;
	Sun, 15 Jun 2025 15:03:48 +0000 (UTC)
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
Subject: [net-next v3 1/3] net: ethernet: mtk_eth_soc: support named IRQs
Date: Sun, 15 Jun 2025 17:03:16 +0200
Message-ID: <20250615150333.166202-2-linux@fw-web.de>
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

Add named interrupts and keep index based fallback for exiting devicetrees.

Currently only rx and tx IRQs are defined to be used with mt7988, but
later extended with RSS/LRO support.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2:
- move irqs loading part into own helper function
- reduce indentation
- place mtk_get_irqs helper before the irq_handler (note for simon)
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 39 +++++++++++++++------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index b38e4f2de674..f91ea87d2f72 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -3336,6 +3336,30 @@ static void mtk_tx_timeout(struct net_device *dev, unsigned int txqueue)
 	schedule_work(&eth->pending_work);
 }
 
+static int mtk_get_irqs(struct platform_device *pdev, struct mtk_eth *eth)
+{
+	int i;
+
+	eth->irq[1] = platform_get_irq_byname(pdev, "tx");
+	eth->irq[2] = platform_get_irq_byname(pdev, "rx");
+	if (eth->irq[1] >= 0 && eth->irq[2] >= 0)
+		return 0;
+
+	for (i = 0; i < 3; i++) {
+		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT) && i > 0)
+			eth->irq[i] = eth->irq[0];
+		else
+			eth->irq[i] = platform_get_irq(pdev, i);
+
+		if (eth->irq[i] < 0) {
+			dev_err(&pdev->dev, "no IRQ%d resource found\n", i);
+			return -ENXIO;
+		}
+	}
+
+	return 0;
+}
+
 static irqreturn_t mtk_handle_irq_rx(int irq, void *_eth)
 {
 	struct mtk_eth *eth = _eth;
@@ -5105,17 +5129,10 @@ static int mtk_probe(struct platform_device *pdev)
 		}
 	}
 
-	for (i = 0; i < 3; i++) {
-		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT) && i > 0)
-			eth->irq[i] = eth->irq[0];
-		else
-			eth->irq[i] = platform_get_irq(pdev, i);
-		if (eth->irq[i] < 0) {
-			dev_err(&pdev->dev, "no IRQ%d resource found\n", i);
-			err = -ENXIO;
-			goto err_wed_exit;
-		}
-	}
+	err = mtk_get_irqs(pdev, eth);
+	if (err)
+		goto err_wed_exit;
+
 	for (i = 0; i < ARRAY_SIZE(eth->clks); i++) {
 		eth->clks[i] = devm_clk_get(eth->dev,
 					    mtk_clks_source_name[i]);
-- 
2.43.0


