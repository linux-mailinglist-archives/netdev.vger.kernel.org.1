Return-Path: <netdev+bounces-149244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9A69E4E24
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 08:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0AC7284FF3
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 07:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677E81BBBD7;
	Thu,  5 Dec 2024 07:22:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF2E1B85D7;
	Thu,  5 Dec 2024 07:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383336; cv=none; b=i0/+wSoQP6ewbayeukY249pl1vb4U2ypw3KqPjk7ScUAglSh3GzdVJcrgz/JC+elSiMyhj6dbg1VjmNxZCdLR5LDqmDvQS99wSawP7u2uM49jVvv2YbMhkgsAc8/sbT4nN4zqcezJK4yYEsdRk0C8NBi32oUEpytqztgP1EX0x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383336; c=relaxed/simple;
	bh=r9NYc8MfyGenoK5VR4Xw9lt9XWCXnQGy/+CYZVZ2k/Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cAxD3a6CI1E0HlNYNFajxp1vGUEBLUq3iMZ/3nYXWl2OxQ6duu9v1y8+B+1BDyIHP52Lzh6aA9hD3qSockM7cMRXdqGw6+6epn4EKfV3jFld6RHEQdBg7QPVEqRHHC1QFVy7G89GVESx75/9xVvc5c4aSCR2ztGOYcPuY93j9hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 5 Dec
 2024 15:20:48 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 5 Dec 2024 15:20:48 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <jacky_chou@aspeedtech.com>
Subject: [PATCH net-next v4 3/7] net: ftgmac100: Add reset toggling for Aspeed SOCs
Date: Thu, 5 Dec 2024 15:20:44 +0800
Message-ID: <20241205072048.1397570-4-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241205072048.1397570-1-jacky_chou@aspeedtech.com>
References: <20241205072048.1397570-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Toggle the SCU reset before hardware initialization.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 17ec35e75a65..96c1eee547c4 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -9,6 +9,7 @@
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
 #include <linux/clk.h>
+#include <linux/reset.h>
 #include <linux/dma-mapping.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
@@ -98,6 +99,7 @@ struct ftgmac100 {
 	struct work_struct reset_task;
 	struct mii_bus *mii_bus;
 	struct clk *clk;
+	struct reset_control *rst;
 
 	/* AST2500/AST2600 RMII ref clock gate */
 	struct clk *rclk;
@@ -1979,6 +1981,22 @@ static int ftgmac100_probe(struct platform_device *pdev)
 				  priv->base + FTGMAC100_OFFSET_TM);
 	}
 
+	priv->rst = devm_reset_control_get_optional_exclusive(priv->dev, NULL);
+	if (IS_ERR(priv->rst))
+		goto err_register_netdev;
+
+	err = reset_control_assert(priv->rst);
+	if (err) {
+		dev_err(priv->dev, "Failed to reset mac (%d)\n", err);
+		goto err_register_netdev;
+	}
+	usleep_range(10000, 20000);
+	err = reset_control_deassert(priv->rst);
+	if (err) {
+		dev_err(priv->dev, "Failed to deassert mac reset (%d)\n", err);
+		goto err_register_netdev;
+	}
+
 	/* Default ring sizes */
 	priv->rx_q_entries = priv->new_rx_q_entries = DEF_RX_QUEUE_ENTRIES;
 	priv->tx_q_entries = priv->new_tx_q_entries = DEF_TX_QUEUE_ENTRIES;
-- 
2.25.1


