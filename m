Return-Path: <netdev+bounces-173953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14ECA5C89B
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 16:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F00381618C8
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E152F25E805;
	Tue, 11 Mar 2025 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="of+hZPg8"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBFD25B691;
	Tue, 11 Mar 2025 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707805; cv=none; b=FrUwfpYuT3MBJRZcd7MAreTcC4aN6aey/a1ZQPsrt6H5j8pMuJq2/yY/GC6GLNWNEPz76HdSsvZw9MyOqOMwQ9i6DdERGH8sFVLtnunL8nrlW/T1nZq5m0oAu3n0NZi7IKWNBo5dSecShyahiPANvV5sRKWS0GLnOYKf6IxYBpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707805; c=relaxed/simple;
	bh=bgd5j5JiBhYU2Xa9KUz+Wa9gA8t7yfru0IU54bWjBiE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ELBUHztOPUqS5eSIOZ2iHFYzPsQuiFPZIHdYQVVwghPlramOyG/joEBWMavps95+2miIoTHZ6q8B6yXuyyZfqKHs1josPN5GDwG6yeV0NVQlCupo5wmnWm8Ve+uRwSPdYPb19pO16OLoxmUb+99PX1bWNKaLLoAQb0bcx/gp980=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=of+hZPg8; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52BFh5v61332568
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 10:43:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741707786;
	bh=AUhtus2LRR/f9mDsXKrJtEtC9OIA8rEjoQCsfNgcDkc=;
	h=From:To:CC:Subject:Date;
	b=of+hZPg8Y3UmkYXah2uvyRnBIAybBcmKTt7fvWSj1HHXWwe7eeazuxuqYucboC0lQ
	 2N57JNGL75Utvc0hB7/JckO/X8OpLpj/ALR8xs6MPpHd46xy/8pALi0LZ319QwR+7W
	 /y5iNKgd+f/2zMmpiIFz9+uPm+B0p5/5oZKhqZdk=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52BFh54v002591
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Mar 2025 10:43:05 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Mar 2025 10:43:05 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Mar 2025 10:43:05 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52BFh0FA096785;
	Tue, 11 Mar 2025 10:43:00 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <rogerq@kernel.org>,
        <horms@kernel.org>, <alexander.sverdlin@siemens.com>,
        <dan.carpenter@linaro.org>, <c-vankar@ti.com>, <jpanis@baylibre.com>,
        <npitre@baylibre.com>
CC: <vigneshr@ti.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH net v3] net: ethernet: ti: am65-cpsw: Fix NAPI registration sequence
Date: Tue, 11 Mar 2025 21:12:59 +0530
Message-ID: <20250311154259.102865-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Vignesh Raghavendra <vigneshr@ti.com>

Registering the interrupts for TX or RX DMA Channels prior to registering
their respective NAPI callbacks can result in a NULL pointer dereference.
This is seen in practice as a random occurrence since it depends on the
randomness associated with the generation of traffic by Linux and the
reception of traffic from the wire.

Fixes: 681eb2beb3ef ("net: ethernet: ti: am65-cpsw: ensure proper channel cleanup in error path")
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
4d872d51bc9d Merge tag 'x86-urgent-2025-03-10' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
of Mainline Linux.

v2 of this patch is at:
https://lore.kernel.org/r/20250311130103.68971-1-s-vadapalli@ti.com/
Changes since v2:
- Updated error handling in am65_cpsw_nuss_init_rx_chns() by introducing
  a new "goto label" namely "err_request_irq", since there are 3 different
  error paths leading to the existing "goto label" named "err_flow", of
  which, only one of them requires an extra netif_napi_del() invocation.
  This change is based on the feedback from 
  Alexander Sverdlin <alexander.sverdlin@siemens.com>
  at:
  https://lore.kernel.org/r/02d685e2aa8721a119f528bde2f4ec9533101663.camel@siemens.com/

v1 of this patch is at:
https://lore.kernel.org/r/20250311061214.4111634-1-s-vadapalli@ti.com/
Changes since v1:
- Based on the feedback provided by Alexander Sverdlin <alexander.sverdlin@siemens.com>
  the patch has been updated to account for the cleanup path in terms of an imbalance
  between the number of successful netif_napi_add_tx/netif_napi_add calls and the
  number of successful devm_request_irq() calls. In the event of an error, we will
  always have one extra successful netif_napi_add_tx/netif_napi_add that needs to be
  cleaned up before we clean an equal number of netif_napi_add_tx/netif_napi_add and
  devm_request_irq.

Regards,
Siddharth.

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 32 +++++++++++++-----------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 2806238629f8..bef734c6e5c2 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2306,14 +2306,18 @@ static void am65_cpsw_nuss_remove_tx_chns(struct am65_cpsw_common *common)
 static int am65_cpsw_nuss_ndev_add_tx_napi(struct am65_cpsw_common *common)
 {
 	struct device *dev = common->dev;
+	struct am65_cpsw_tx_chn *tx_chn;
 	int i, ret = 0;
 
 	for (i = 0; i < common->tx_ch_num; i++) {
-		struct am65_cpsw_tx_chn *tx_chn = &common->tx_chns[i];
+		tx_chn = &common->tx_chns[i];
 
 		hrtimer_init(&tx_chn->tx_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
 		tx_chn->tx_hrtimer.function = &am65_cpsw_nuss_tx_timer_callback;
 
+		netif_napi_add_tx(common->dma_ndev, &tx_chn->napi_tx,
+				  am65_cpsw_nuss_tx_poll);
+
 		ret = devm_request_irq(dev, tx_chn->irq,
 				       am65_cpsw_nuss_tx_irq,
 				       IRQF_TRIGGER_HIGH,
@@ -2323,19 +2327,16 @@ static int am65_cpsw_nuss_ndev_add_tx_napi(struct am65_cpsw_common *common)
 				tx_chn->id, tx_chn->irq, ret);
 			goto err;
 		}
-
-		netif_napi_add_tx(common->dma_ndev, &tx_chn->napi_tx,
-				  am65_cpsw_nuss_tx_poll);
 	}
 
 	return 0;
 
 err:
-	for (--i ; i >= 0 ; i--) {
-		struct am65_cpsw_tx_chn *tx_chn = &common->tx_chns[i];
-
-		netif_napi_del(&tx_chn->napi_tx);
+	netif_napi_del(&tx_chn->napi_tx);
+	for (--i; i >= 0; i--) {
+		tx_chn = &common->tx_chns[i];
 		devm_free_irq(dev, tx_chn->irq, tx_chn);
+		netif_napi_del(&tx_chn->napi_tx);
 	}
 
 	return ret;
@@ -2569,6 +2570,9 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 			     HRTIMER_MODE_REL_PINNED);
 		flow->rx_hrtimer.function = &am65_cpsw_nuss_rx_timer_callback;
 
+		netif_napi_add(common->dma_ndev, &flow->napi_rx,
+			       am65_cpsw_nuss_rx_poll);
+
 		ret = devm_request_irq(dev, flow->irq,
 				       am65_cpsw_nuss_rx_irq,
 				       IRQF_TRIGGER_HIGH,
@@ -2577,11 +2581,8 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 			dev_err(dev, "failure requesting rx %d irq %u, %d\n",
 				i, flow->irq, ret);
 			flow->irq = -EINVAL;
-			goto err_flow;
+			goto err_request_irq;
 		}
-
-		netif_napi_add(common->dma_ndev, &flow->napi_rx,
-			       am65_cpsw_nuss_rx_poll);
 	}
 
 	/* setup classifier to route priorities to flows */
@@ -2589,11 +2590,14 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 
 	return 0;
 
+err_request_irq:
+	netif_napi_del(&flow->napi_rx);
+
 err_flow:
-	for (--i; i >= 0 ; i--) {
+	for (--i; i >= 0; i--) {
 		flow = &rx_chn->flows[i];
-		netif_napi_del(&flow->napi_rx);
 		devm_free_irq(dev, flow->irq, flow);
+		netif_napi_del(&flow->napi_rx);
 	}
 
 err:
-- 
2.34.1


