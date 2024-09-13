Return-Path: <netdev+bounces-128135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED236978311
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 16:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1CE0289E58
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 14:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55139381B9;
	Fri, 13 Sep 2024 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OzGqYlt1"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7172C2EB02
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726239441; cv=none; b=NEDuW3w5bA5H0te31GhEOp1nAOv0d8cQQ0gUnh2u3KegjRkBD2OtGSVnRjVzEmfBmhuX6LYX/C+AQ5eZ3L7vn9f/GEfHy/GALDZep24GbUXkEAVg9Vf1Tug/3nUsd28AhAcekDKWxqFHQ4nMLu3BD/F0khkB4mEKS3uTXAoeH04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726239441; c=relaxed/simple;
	bh=9ypuQrSVvfxeeJhMmpbTSY+TsDH8/u/9ZkPhzlDgw6o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B+Yz5pjMvWEfNlzr/YlVjKpjPSCvwO+R90tTtXSLYwoSdIsbvLG37OHRClryKFqA2JdRsYLtmuxJpX/RZZuoe6zdUVmliF4WMNeJRkK4U0XwE5G6bosqlsa3DeO6XlPgKjiCKuoni0VH8EbG6GpbV+/aZkJcjAEpc8N65CFyO+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OzGqYlt1; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726239437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sqPwZBdOFC2kmYnJsv9Gtj6yUf0eG7sqHAFicEZ9CaI=;
	b=OzGqYlt1JQB4wNJbgyO+3/IIt5HwxQxW0nWnVrcxOxOULsLZPzrEXvLPp8Q9OQ38JmcC78
	FemuATVLeUp6nIzvYR23VpA4wGOMfTxc5nnSYsOfKAibHmj/rZBCwmGngHxncfhtmw0lBo
	tRWP9CadEN4K1s+3csOpOSn76LZV6nc=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	Robert Hancock <robert.hancock@calian.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net v2] net: xilinx: axienet: Schedule NAPI in two steps
Date: Fri, 13 Sep 2024 10:57:11 -0400
Message-Id: <20240913145711.2284295-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

As advised by Documentation/networking/napi.rst, masking IRQs after
calling napi_schedule can be racy. Avoid this by only masking/scheduling
if napi_schedule_prep returns true.

Fixes: 9e2bc267e780 ("net: axienet: Use NAPI for TX completion path")
Fixes: cc37610caaf8 ("net: axienet: implement NAPI and GRO receive")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
---

Changes in v2:
- Don't use the irqoff variant of __napi_schedule

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 9eb300fc3590..3de6559ceea6 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1222,9 +1222,10 @@ static irqreturn_t axienet_tx_irq(int irq, void *_ndev)
 		u32 cr = lp->tx_dma_cr;
 
 		cr &= ~(XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK);
-		axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, cr);
-
-		napi_schedule(&lp->napi_tx);
+		if (napi_schedule_prep(&lp->napi_tx)) {
+			axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, cr);
+			__napi_schedule(&lp->napi_tx);
+		}
 	}
 
 	return IRQ_HANDLED;
@@ -1266,9 +1267,10 @@ static irqreturn_t axienet_rx_irq(int irq, void *_ndev)
 		u32 cr = lp->rx_dma_cr;
 
 		cr &= ~(XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK);
-		axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, cr);
-
-		napi_schedule(&lp->napi_rx);
+		if (napi_schedule_prep(&lp->napi_rx)) {
+			axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, cr);
+			__napi_schedule(&lp->napi_rx);
+		}
 	}
 
 	return IRQ_HANDLED;
-- 
2.35.1.1320.gc452695387.dirty


