Return-Path: <netdev+bounces-173887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C0CA5C1C6
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AAFB3AE47B
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8049EEC0;
	Tue, 11 Mar 2025 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lAEBg8pp"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3B279C2;
	Tue, 11 Mar 2025 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741698092; cv=none; b=MjmOB+C/G7m9ai4kcfUdCkrj29ikxR6oce4kROeyFcQ6ldGM+ICHxUuB5ypM1wCSxPH93vVoazF9gQFEh+lbn95sI4F/h7rSuWpKH4BKFrcss0nn3+Q+8SfMH5mijKeV1cyTcF5meWY8P4EZsNOVHkubr5p6CYRmSgFjc4DoKS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741698092; c=relaxed/simple;
	bh=aRNJqNnEYA9kV9uGJrXyC91rR2ZSKkOrRlh4M0WPKBY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ue0Je2HtFnq5BEZ38esn+Kn0wg5spvk+OKW8k45oglaT2wWpBYCjST+74Hi61/g+R9ZOU20eo0JX/5C+TNIZ7U8V/dBi3VogMEHLISZN3OEhdFQxka2NN7an0XK6JlM4+xvOEfFZatige1hGhOyXpnwBBKpMY3CQIF0Uy+k1lPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lAEBg8pp; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52BD19rl709386
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 11 Mar 2025 08:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741698069;
	bh=yVflShp+Qrm9WBJxQRs9hAkbpogZWdsryN8xD+f/PYk=;
	h=From:To:CC:Subject:Date;
	b=lAEBg8pp3bqap/14acOXVb09mEcxpERgUo+4wNaxI2qH/WgKqq0Tvif2ZXeLo+RrG
	 PWHfLWlBKg8oHL7/Tojk8/zOKyexISRRbCZkwVuAIjeRenocxMOYL7x3+tlGAYYb5/
	 65il3PeSfVRm2DFj90etxJUwwDqomGr9VXeVmA4o=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52BD19Sp044036;
	Tue, 11 Mar 2025 08:01:09 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Mar 2025 08:01:08 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Mar 2025 08:01:08 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52BD14sa041825;
	Tue, 11 Mar 2025 08:01:04 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <rogerq@kernel.org>,
        <horms@kernel.org>, <alexander.sverdlin@siemens.com>,
        <dan.carpenter@linaro.org>, <c-vankar@ti.com>, <jpanis@baylibre.com>
CC: <vigneshr@ti.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH net v2] net: ethernet: ti: am65-cpsw: Fix NAPI registration sequence
Date: Tue, 11 Mar 2025 18:31:03 +0530
Message-ID: <20250311130103.68971-1-s-vadapalli@ti.com>
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

v1 of this patch is at:
https://lore.kernel.org/all/20250311061214.4111634-1-s-vadapalli@ti.com/
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

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 28 +++++++++++++-----------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 2806238629f8..b88edf2dd8f4 100644
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
@@ -2579,9 +2583,6 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 			flow->irq = -EINVAL;
 			goto err_flow;
 		}
-
-		netif_napi_add(common->dma_ndev, &flow->napi_rx,
-			       am65_cpsw_nuss_rx_poll);
 	}
 
 	/* setup classifier to route priorities to flows */
@@ -2590,10 +2591,11 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 	return 0;
 
 err_flow:
-	for (--i; i >= 0 ; i--) {
+	netif_napi_del(&flow->napi_rx);
+	for (--i; i >= 0; i--) {
 		flow = &rx_chn->flows[i];
-		netif_napi_del(&flow->napi_rx);
 		devm_free_irq(dev, flow->irq, flow);
+		netif_napi_del(&flow->napi_rx);
 	}
 
 err:
-- 
2.34.1


