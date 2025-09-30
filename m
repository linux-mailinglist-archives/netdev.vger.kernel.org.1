Return-Path: <netdev+bounces-227344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D9EBACCA8
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 14:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0151895BD0
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 12:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACE02222D1;
	Tue, 30 Sep 2025 12:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OMS2Lnj6"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA19D20F08E;
	Tue, 30 Sep 2025 12:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759234605; cv=none; b=DWZbljNpq2dqZc3YqhgfnpIHhsVenjaPqp342zGuBcyO5sGSulG4XTlbyG2HJkPvsoUFnIpQ94FluGEuKK/nJGv5j81dqu4RgralsJdHq3vYukD+BZste3jAz9151fxdXW9k1gEKC5Vvu3bysMuybWwM71Ws9uE5+8aeqhvq2Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759234605; c=relaxed/simple;
	bh=htDw1G9v16Kq9cORxh2j5a9aXo00LjcFCzJfXGxc8Gc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MgfTxDEnSBexHVI0IZStb+KwUspLBnlrhg9t2Y3SKKodtAbyCnfnXT7d4OXFzuVmdGcYZzdCq/OPbsNPb2u61enl2a11pHsRjOU4dgqhTqBdkyS5p7+cAUoK0xCGeoIuBhHAqiuxxfGi6PsWj9RHxWzn7aBKYKm8VwAmoZtmh/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OMS2Lnj6; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58UCGMx92452077;
	Tue, 30 Sep 2025 07:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1759234582;
	bh=eQzqneoZALoPGRFFvWnZ1GCMXeesYcgJGLBteg4QWxo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=OMS2Lnj6FEor2tCevR6C+qzWpPC+o/QsQtq9zVQUzTKMyECBB3WhrBccgi2b/KKqw
	 nwgf7BXupzcCobH2nqiFN4sUrQXWAJGWM9f7M4ojdjtAKRbYcpGIpshfSLsz4hd1CA
	 fkTlr51YaGx0NVas4PfQmUfwuxqlP46xLaq5q2Yg=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58UCGMWZ3905820
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 30 Sep 2025 07:16:22 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 30
 Sep 2025 07:16:21 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 30 Sep 2025 07:16:21 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58UCGLSp2892158;
	Tue, 30 Sep 2025 07:16:21 -0500
From: Nishanth Menon <nm@ti.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
        Paolo
 Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: Santosh Shilimkar <ssantosh@kernel.org>, Simon Horman <horms@kernel.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 1/3] net: ethernet: ti: netcp: Handle both ERR_PTR and NULL from knav_dma_open_channel
Date: Tue, 30 Sep 2025 07:16:07 -0500
Message-ID: <20250930121609.158419-2-nm@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250930121609.158419-1-nm@ti.com>
References: <20250930121609.158419-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The knav_dma_open_channel function has inconsistent return behavior: the
header returns NULL when the driver is disabled, while the driver
implementation returns ERR_PTR(-EINVAL). This inconsistency creates
confusion for callers.

Prepare for standardizing the function to return NULL by updating callers
to handle both ERR_PTR and NULL return values using IS_ERR_OR_NULL()
checks.

Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes in V2:
* renewed version

 drivers/net/ethernet/ti/netcp_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
index 857820657bac..2f9d26c791e3 100644
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -1338,10 +1338,10 @@ int netcp_txpipe_open(struct netcp_tx_pipe *tx_pipe)
 
 	tx_pipe->dma_channel = knav_dma_open_channel(dev,
 				tx_pipe->dma_chan_name, &config);
-	if (IS_ERR(tx_pipe->dma_channel)) {
+	if (IS_ERR_OR_NULL(tx_pipe->dma_channel)) {
 		dev_err(dev, "failed opening tx chan(%s)\n",
 			tx_pipe->dma_chan_name);
-		ret = PTR_ERR(tx_pipe->dma_channel);
+		ret = -EINVAL;
 		goto err;
 	}
 
@@ -1678,10 +1678,10 @@ static int netcp_setup_navigator_resources(struct net_device *ndev)
 
 	netcp->rx_channel = knav_dma_open_channel(netcp->netcp_device->device,
 					netcp->dma_chan_name, &config);
-	if (IS_ERR(netcp->rx_channel)) {
+	if (IS_ERR_OR_NULL(netcp->rx_channel)) {
 		dev_err(netcp->ndev_dev, "failed opening rx chan(%s\n",
 			netcp->dma_chan_name);
-		ret = PTR_ERR(netcp->rx_channel);
+		ret = -EINVAL;
 		goto fail;
 	}
 
-- 
2.47.0


