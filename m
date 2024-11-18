Return-Path: <netdev+bounces-145798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E0C9D0F29
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 12:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C034B2E67E
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 10:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF0B1993B1;
	Mon, 18 Nov 2024 10:48:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803171991AF;
	Mon, 18 Nov 2024 10:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731926880; cv=none; b=r5QQEVc/Y7prvIbtChdr+Qb+KLkn8PVYanXLu7eudqwHimXEtxp0PsNUTW12FaM2PnNRfRuc8hRgnI3HgUtn2PHqe14O2EhIIycXPAdwIZv2IOYlSDm2ZZlxfriHQyXQYgBiOdz1p3MWUilqn/woWNY0Z2+PaCvaACPJPTFFVH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731926880; c=relaxed/simple;
	bh=UrWPpTx4MwnWXf2qpZmAB3pF1AYWlHqHVxM3NaUcazE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+CbO2eVW0elsEaVXRWZzf5RKilCYYpE0LMKqHaEhUSzncorr5unnrdJigG+Ok6Xpg+u0BAZ/ug1YYrdR4RAiiYULEa3g3T65/PLe/zgZySXOcLVrwZ+Mb31YOp9Azh3EiW4eoktkqU2+BhyRodiman8oifD1E8rLPd4IErgFFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 18 Nov
 2024 18:47:35 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 18 Nov 2024 18:47:35 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC: <jacky_chou@aspeedtech.com>
Subject: [net-next 3/3] net: mdio: aspeed: Add dummy read for fire control
Date: Mon, 18 Nov 2024 18:47:35 +0800
Message-ID: <20241118104735.3741749-4-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241118104735.3741749-1-jacky_chou@aspeedtech.com>
References: <20241118104735.3741749-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add a dummy read to ensure triggering mdio controller before starting
polling the status of mdio controller.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/mdio/mdio-aspeed.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
index 4d5a115baf85..feae30bc3e78 100644
--- a/drivers/net/mdio/mdio-aspeed.c
+++ b/drivers/net/mdio/mdio-aspeed.c
@@ -62,6 +62,8 @@ static int aspeed_mdio_op(struct mii_bus *bus, u8 st, u8 op, u8 phyad, u8 regad,
 		| FIELD_PREP(ASPEED_MDIO_DATA_MIIRDATA, data);
 
 	iowrite32(ctrl, ctx->base + ASPEED_MDIO_CTRL);
+	/* Add dummy read to ensure triggering mdio controller */
+	(void)ioread32(ctx->base + ASPEED_MDIO_CTRL);
 
 	return readl_poll_timeout(ctx->base + ASPEED_MDIO_CTRL, ctrl,
 				!(ctrl & ASPEED_MDIO_CTRL_FIRE),
-- 
2.25.1


