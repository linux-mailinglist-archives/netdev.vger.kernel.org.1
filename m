Return-Path: <netdev+bounces-97098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3378C911E
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 14:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B002B1F21F51
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D7F78C67;
	Sat, 18 May 2024 12:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oy4bA/9i"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DE777118;
	Sat, 18 May 2024 12:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716036284; cv=none; b=B0e8ZtkwBsXyKQypze4rIxRfd2cNJp65o4h6TTK8YAau1JXxViLoJ+MxPSgBbHSxstyIMlZW40l1HSnMkQg6YqPIDUq2NNxlOIbqXBf5h1b0YxIq3mTBIhqCogdfpJsjVq7gXMC51HYtXl4G75aL/ZuIGWXqNITY7xsUP74MWdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716036284; c=relaxed/simple;
	bh=9ikqwUURIJXjmOX0YEggmPaxUl5VbN4VNsrVNZ2xog0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NY3XN1LZR0PMrf1nPYApuchJo6AkXyvZQtDmAshdYPg2hheAJyECMW2aN/p7x5pFZUt9PpvRHAasjyGFuQXfusUOThDIWA9qeO2KDx1vyrHdd+ADAZHA3ENB5i/vsp5dC5/38tUbZ3UVc6qvmDZQyuAPuBL+cvGUGhyqiD/Yftk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oy4bA/9i; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44ICiPge110184;
	Sat, 18 May 2024 07:44:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716036265;
	bh=lP4vcrz4edMAL+hEj61bfOYsm3giMknUDGXG+pKdxIQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=oy4bA/9irURetstA9Fc5yO+3I4DC1KGhldjpzWdHlZ+6kWzxUjtNQD6XeLlzLCkup
	 0XhKmadGTcBioI/dBHjnZaUPwJ9uCE/byMKJ5B+AzytVc0CnRwG57KU4vyxCgDNCzu
	 Aeygm4F0CQmsKNv7kCXRdmeTARvh+sN8dk7HimgY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44ICiPNs052100
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 07:44:25 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 07:44:25 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 07:44:25 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgY9d041511;
	Sat, 18 May 2024 07:44:20 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <rogerq@kernel.org>,
        <danishanwar@ti.com>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <misael.lopez@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH net-next 23/28] net: ethernet: ti: cpsw-proxy-client: add sw tx/rx irq coalescing
Date: Sat, 18 May 2024 18:12:29 +0530
Message-ID: <20240518124234.2671651-24-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240518124234.2671651-1-s-vadapalli@ti.com>
References: <20240518124234.2671651-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add coalescing support for the interrupts corresponding to the TX and RX
DMA Channels using hrtimer.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/cpsw-proxy-client.c | 57 +++++++++++++++++++--
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw-proxy-client.c b/drivers/net/ethernet/ti/cpsw-proxy-client.c
index 450fc183eaac..408c9f78c059 100644
--- a/drivers/net/ethernet/ti/cpsw-proxy-client.c
+++ b/drivers/net/ethernet/ti/cpsw-proxy-client.c
@@ -58,13 +58,16 @@ struct rx_dma_chan {
 	struct k3_cppi_desc_pool	*desc_pool;
 	struct k3_udma_glue_rx_channel	*rx_chan;
 	struct napi_struct		napi_rx;
+	struct hrtimer			rx_hrtimer;
 	u32				rel_chan_idx;
 	u32				flow_base;
 	u32				flow_offset;
 	u32				thread_id;
 	u32				num_descs;
 	unsigned int			irq;
+	unsigned long			rx_pace_timeout;
 	char				rx_chan_name[CHAN_NAME_LEN];
+	bool				rx_irq_disabled;
 	bool				in_use;
 };
 
@@ -74,10 +77,12 @@ struct tx_dma_chan {
 	struct k3_cppi_desc_pool	*desc_pool;
 	struct k3_udma_glue_tx_channel	*tx_chan;
 	struct napi_struct		napi_tx;
+	struct hrtimer			tx_hrtimer;
 	u32				rel_chan_idx;
 	u32				thread_id;
 	u32				num_descs;
 	unsigned int			irq;
+	unsigned long			tx_pace_timeout;
 	char				tx_chan_name[CHAN_NAME_LEN];
 	bool				in_use;
 };
@@ -996,8 +1001,15 @@ static int vport_tx_poll(struct napi_struct *napi_tx, int budget)
 	if (num_tx >= budget)
 		return budget;
 
-	if (napi_complete_done(napi_tx, num_tx))
-		enable_irq(tx_chn->irq);
+	if (napi_complete_done(napi_tx, num_tx)) {
+		if (unlikely(tx_chn->tx_pace_timeout && !tdown)) {
+			hrtimer_start(&tx_chn->tx_hrtimer,
+				      ns_to_ktime(tx_chn->tx_pace_timeout),
+				      HRTIMER_MODE_REL_PINNED);
+		} else {
+			enable_irq(tx_chn->irq);
+		}
+	}
 
 	return 0;
 }
@@ -1179,12 +1191,38 @@ static int vport_rx_poll(struct napi_struct *napi_rx, int budget)
 		num_rx++;
 	}
 
-	if (num_rx < budget && napi_complete_done(napi_rx, num_rx))
-		enable_irq(rx_chn->irq);
+	if (num_rx < budget && napi_complete_done(napi_rx, num_rx)) {
+		if (rx_chn->rx_irq_disabled) {
+			rx_chn->rx_irq_disabled = false;
+			if (unlikely(rx_chn->rx_pace_timeout)) {
+				hrtimer_start(&rx_chn->rx_hrtimer,
+					      ns_to_ktime(rx_chn->rx_pace_timeout),
+					      HRTIMER_MODE_REL_PINNED);
+			} else {
+				enable_irq(rx_chn->irq);
+			}
+		}
+	}
 
 	return num_rx;
 }
 
+static enum hrtimer_restart vport_tx_timer_cb(struct hrtimer *timer)
+{
+	struct tx_dma_chan *tx_chn = container_of(timer, struct tx_dma_chan, tx_hrtimer);
+
+	enable_irq(tx_chn->irq);
+	return HRTIMER_NORESTART;
+}
+
+static enum hrtimer_restart vport_rx_timer_cb(struct hrtimer *timer)
+{
+	struct rx_dma_chan *rx_chn = container_of(timer, struct rx_dma_chan, rx_hrtimer);
+
+	enable_irq(rx_chn->irq);
+	return HRTIMER_NORESTART;
+}
+
 static u32 vport_get_link(struct net_device *ndev)
 {
 	struct virtual_port *vport = vport_ndev_to_vport(ndev);
@@ -1326,6 +1364,7 @@ static void vport_stop(struct virtual_port *vport)
 		k3_udma_glue_reset_tx_chn(tx_chn->tx_chan, tx_chn, vport_tx_cleanup);
 		k3_udma_glue_disable_tx_chn(tx_chn->tx_chan);
 		napi_disable(&tx_chn->napi_tx);
+		hrtimer_cancel(&tx_chn->tx_hrtimer);
 	}
 
 	for (i = 0; i < vport->num_rx_chan; i++) {
@@ -1336,6 +1375,7 @@ static void vport_stop(struct virtual_port *vport)
 		k3_udma_glue_reset_rx_chn(rx_chn->rx_chan, 0, rx_chn, vport_rx_cleanup,
 					  false);
 		napi_disable(&rx_chn->napi_rx);
+		hrtimer_cancel(&rx_chn->rx_hrtimer);
 	}
 }
 
@@ -1381,6 +1421,10 @@ static int vport_open(struct virtual_port *vport, netdev_features_t features)
 	for (i = 0; i < vport->num_rx_chan; i++) {
 		rx_chn = &vport->rx_chans[i];
 		napi_enable(&rx_chn->napi_rx);
+		if (rx_chn->rx_irq_disabled) {
+			rx_chn->rx_irq_disabled = false;
+			enable_irq(rx_chn->irq);
+		}
 	}
 
 	return 0;
@@ -1708,11 +1752,15 @@ static int init_netdev(struct cpsw_proxy_priv *proxy_priv, struct virtual_port *
 	for (i = 0; i < vport->num_tx_chan; i++) {
 		tx_chn = &vport->tx_chans[i];
 		netif_napi_add_tx(vport->ndev, &tx_chn->napi_tx, vport_tx_poll);
+		hrtimer_init(&tx_chn->tx_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
+		tx_chn->tx_hrtimer.function = &vport_tx_timer_cb;
 	}
 
 	for (i = 0; i < vport->num_rx_chan; i++) {
 		rx_chn = &vport->rx_chans[i];
 		netif_napi_add(vport->ndev, &rx_chn->napi_rx, vport_rx_poll);
+		hrtimer_init(&rx_chn->rx_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
+		rx_chn->rx_hrtimer.function = &vport_rx_timer_cb;
 	}
 
 	ret = register_netdev(vport->ndev);
@@ -1771,6 +1819,7 @@ static irqreturn_t rx_irq_handler(int irq, void *dev_id)
 {
 	struct rx_dma_chan *rx_chn = dev_id;
 
+	rx_chn->rx_irq_disabled = true;
 	disable_irq_nosync(irq);
 	napi_schedule(&rx_chn->napi_rx);
 
-- 
2.40.1


