Return-Path: <netdev+bounces-97094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C5C8C9112
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 14:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEB2B1F21BAF
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70C076036;
	Sat, 18 May 2024 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tZTfMiNS"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350922BD18;
	Sat, 18 May 2024 12:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716036275; cv=none; b=APU9NDSOxQvcH15bkiuNpBlgwgiH9tZnZT2+sUK18eQLqmYUiqZurQSzzGjjozUXQptj9Ksc09XntKyniTy0wnQzSazgfnBt8P6yFbllO7hklhIbD+Y5Dd27gx3x4FcDnxnhm5pp+W4D12cmUntoHkZ074mbKlfqrx0b8/G/YV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716036275; c=relaxed/simple;
	bh=trHlkmVueSpzbMIM48Qj2NuKuHblG4sExkmhZdZ/kaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g56QhodFpfkbw6RUxJAQH0LINVplluOVbHahO5IYELapQ/RsIrGswieQbYW+dKX2sSadUMpRpyLBFCBkUtsXzq0UdTMufGkICNPHsoaEzkwxZt+nS9gO89zU4Q8eyGgbIpZHQjkjFKBJH+pQAm2lFU5xzeQHKqb7TzgtQgB7ztk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tZTfMiNS; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44ICiBSc055039;
	Sat, 18 May 2024 07:44:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716036251;
	bh=fbRzf+uBA4zF2HTBz3dtEjKx1tnV87uTG84AC6BwYCA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=tZTfMiNSk6dmT3/UD6ncrA53raA4xsXFNJiKHUUvltsfsAnfm3HR1Op0QmPdYRsHM
	 NLDf4tmz7nOkZH8paPGU1Rvs3+lmBtUx32wWchCz6ohXmc8AVVUpa1ShR+QuJx4Lx9
	 SgprH31adR8ciUvP2giEay0jZGAee8ft0oQtIka4=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44ICiBDK017753
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 07:44:11 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 07:44:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 07:44:11 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgY9a041511;
	Sat, 18 May 2024 07:44:07 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <rogerq@kernel.org>,
        <danishanwar@ti.com>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <misael.lopez@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH net-next 20/28] net: ethernet: ti: cpsw-proxy-client: implement and register ndo_tx_timeout
Date: Sat, 18 May 2024 18:12:26 +0530
Message-ID: <20240518124234.2671651-21-s-vadapalli@ti.com>
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

Add the function "vport_ndo_tx_timeout()" and register it as the driver's
.ndo_tx_timeout callback.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/cpsw-proxy-client.c | 26 +++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw-proxy-client.c b/drivers/net/ethernet/ti/cpsw-proxy-client.c
index 6886557aa2a1..92a014e83c6c 100644
--- a/drivers/net/ethernet/ti/cpsw-proxy-client.c
+++ b/drivers/net/ethernet/ti/cpsw-proxy-client.c
@@ -1596,11 +1596,37 @@ static void vport_ndo_get_stats(struct net_device *ndev,
 	stats->tx_dropped	= ndev->stats.tx_dropped;
 }
 
+static void vport_ndo_tx_timeout(struct net_device *ndev, unsigned int txqueue)
+{
+	struct virtual_port *vport = vport_ndev_to_vport(ndev);
+	struct netdev_queue *netif_txq;
+	struct tx_dma_chan *tx_chn;
+	unsigned long trans_start;
+
+	/* process every txq */
+	netif_txq = netdev_get_tx_queue(ndev, txqueue);
+	tx_chn = &vport->tx_chans[txqueue];
+	trans_start = READ_ONCE(netif_txq->trans_start);
+
+	netdev_err(ndev, "txq:%d DRV_XOFF: %d tmo: %u dql_avail:%d free_desc:%zu\n",
+		   txqueue, netif_tx_queue_stopped(netif_txq),
+		   jiffies_to_msecs(jiffies - trans_start),
+		   dql_avail(&netif_txq->dql),
+		   k3_cppi_desc_pool_avail(tx_chn->desc_pool));
+
+	if (netif_tx_queue_stopped(netif_txq)) {
+		/* try to recover if it was stopped by driver */
+		txq_trans_update(netif_txq);
+		netif_tx_wake_queue(netif_txq);
+	}
+}
+
 static const struct net_device_ops cpsw_proxy_client_netdev_ops = {
 	.ndo_open		= vport_ndo_open,
 	.ndo_stop		= vport_ndo_stop,
 	.ndo_start_xmit		= vport_ndo_xmit,
 	.ndo_get_stats64	= vport_ndo_get_stats,
+	.ndo_tx_timeout		= vport_ndo_tx_timeout,
 };
 
 static int init_netdev(struct cpsw_proxy_priv *proxy_priv, struct virtual_port *vport)
-- 
2.40.1


