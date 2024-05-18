Return-Path: <netdev+bounces-97089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B388C9102
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 14:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5781C20C84
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDC073199;
	Sat, 18 May 2024 12:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tW7Ip1tl"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E551673176;
	Sat, 18 May 2024 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716036238; cv=none; b=WpbTA19N+Q+L4YMMpAKXx3sJmoTn5uBB5tRvpPuybDmzPiUjAFQUfv1xDU03+B5NI3E2VqtCcDO/L/2c1HulSsB1qGj0AxvLxv9Be0EUsl0KvkV75f4EGwhHGWSPYPmBQoGmJwVpI7JfKc3zVrBTWOWRMI+Zc/csevl/ip+sP2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716036238; c=relaxed/simple;
	bh=5h6ODGkc0sX5ceDWUsNUPY8nudq5cP9FauIbQ+umf0k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TcTbaG+fNGF86RhJKDqfF+XSKWjs2E5vUH92g5Zr5fC+nIm438ubT9lAy7ELfE9mHeNRdlwJTwxcyJkIlAdGXE6kc57Kmnj6KqH9uylf/XnAeNL18a74kuQWrg5xbUBHp2Apa9dNN3jVefJBkGY5Pp60BteD+t6hxN0aZ6NxrFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tW7Ip1tl; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44IChi4S002817;
	Sat, 18 May 2024 07:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716036224;
	bh=LcRO+fF6vZiIuvVdbUfzVYscZs4/NXqdS1YbI7UC3Lg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=tW7Ip1tlUcJWBx3LDawPmKULqGHjQ7qwrg2CKQ/IAEccO545q8q6onOvGKPZIZzHH
	 EXKMMHot2ThfXjNJmUMgCX94rjjnbpI1UnQ1mR+inu+oVTLhNGgulkci55clNlzeY5
	 grcicOF44olGLvRF3d+Dt6GBNV9vVQaHM5fGtHZU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44IChhdO004255
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 07:43:43 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 07:43:43 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 07:43:43 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgY9U041511;
	Sat, 18 May 2024 07:43:39 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <rogerq@kernel.org>,
        <danishanwar@ti.com>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <misael.lopez@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH net-next 14/28] net: ethernet: ti: cpsw-proxy-client: add and register dma irq handlers
Date: Sat, 18 May 2024 18:12:20 +0530
Message-ID: <20240518124234.2671651-15-s-vadapalli@ti.com>
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

Add the function "register_dma_irq_handlers()" to register the TX and RX
DMA Interrupt handlers for all the TX and RX DMA Channels for every Virtual
Port.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/cpsw-proxy-client.c | 60 +++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw-proxy-client.c b/drivers/net/ethernet/ti/cpsw-proxy-client.c
index 30d53a8e174e..b0f0e5db3a74 100644
--- a/drivers/net/ethernet/ti/cpsw-proxy-client.c
+++ b/drivers/net/ethernet/ti/cpsw-proxy-client.c
@@ -1279,6 +1279,66 @@ static int init_netdevs(struct cpsw_proxy_priv *proxy_priv)
 	return ret;
 }
 
+static irqreturn_t tx_irq_handler(int irq, void *dev_id)
+{
+	struct tx_dma_chan *tx_chn = dev_id;
+
+	disable_irq_nosync(irq);
+	napi_schedule(&tx_chn->napi_tx);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t rx_irq_handler(int irq, void *dev_id)
+{
+	struct rx_dma_chan *rx_chn = dev_id;
+
+	disable_irq_nosync(irq);
+	napi_schedule(&rx_chn->napi_rx);
+
+	return IRQ_HANDLED;
+}
+
+static int register_dma_irq_handlers(struct cpsw_proxy_priv *proxy_priv)
+{
+	struct device *dev = proxy_priv->dev;
+	struct rx_dma_chan *rx_chn;
+	struct tx_dma_chan *tx_chn;
+	struct virtual_port *vport;
+	u32 i, j;
+	int ret;
+
+	for (i = 0; i < proxy_priv->num_virt_ports; i++) {
+		vport = &proxy_priv->virt_ports[i];
+
+		for (j = 0; j < vport->num_tx_chan; j++) {
+			tx_chn = &vport->tx_chans[j];
+
+			ret = devm_request_irq(dev, tx_chn->irq, tx_irq_handler,
+					       IRQF_TRIGGER_HIGH, tx_chn->tx_chan_name, tx_chn);
+			if (ret) {
+				dev_err(dev, "failed to request tx irq: %u, err: %d\n",
+					tx_chn->irq, ret);
+				return ret;
+			}
+		}
+
+		for (j = 0; j < vport->num_rx_chan; j++) {
+			rx_chn = &vport->rx_chans[j];
+
+			ret = devm_request_irq(dev, rx_chn->irq, rx_irq_handler,
+					       IRQF_TRIGGER_HIGH, rx_chn->rx_chan_name, rx_chn);
+			if (ret) {
+				dev_err(dev, "failed to request rx irq: %u, err: %d\n",
+					rx_chn->irq, ret);
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int cpsw_proxy_client_probe(struct rpmsg_device *rpdev)
 {
 	struct cpsw_proxy_priv *proxy_priv;
-- 
2.40.1


