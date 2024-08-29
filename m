Return-Path: <netdev+bounces-123114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06345963B51
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 08:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0B51F22910
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 06:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAC61547D1;
	Thu, 29 Aug 2024 06:23:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4B21662F4
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 06:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912610; cv=none; b=m6q2B72CbHhKepnuLo9GtA7YQlBXKMmZ5rLtYUu67Skr0c1+g1klZFKIsB4wHfw+gwVGsxmDimwwb5/Td4kOx7ohnkI1BoRvGD3UodHnnyxQHBbO/064kC2tvV0uxteMrxeBXZDKaWIMvJuXHSbBdR4OjSl1nDQ3f+pF7TwMiKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912610; c=relaxed/simple;
	bh=RRA9SYmxB5ylmwLyUdV8pgqZhfl5pw2uLR3VD07/E1E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZzKJSPp5250oTw5c/qHmryn8wbLxTCEpGnRCSynvyYUvfYLNnlgDgWRUevn8U6H67r0+tU9UOAyOueasE/ZEWAotsNqfjI7a9ED2QFD6ejEnPcVVXaBgXk8zc0J3slFQ8UAa+xcQXXaFJkSnyLfsMAA7kmZAmTDHvkdu16983wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WvWRg0yt1zyQy9;
	Thu, 29 Aug 2024 14:22:55 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A34218007C;
	Thu, 29 Aug 2024 14:23:26 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 29 Aug
 2024 14:23:25 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <woojung.huh@microchip.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linus.walleij@linaro.org>,
	<alsi@bang-olufsen.dk>, <justin.chen@broadcom.com>,
	<sebastian.hesselbarth@gmail.com>, <alexandre.torgue@foss.st.com>,
	<joabreu@synopsys.com>, <wens@csie.org>, <jernej.skrabec@gmail.com>,
	<samuel@sholland.org>, <mcoquelin.stm32@gmail.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <ansuelsmth@gmail.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<krzk@kernel.org>, <jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next v3 09/13] net: mv643xx_eth: Simplify with scoped for each OF child loop
Date: Thu, 29 Aug 2024 14:31:14 +0800
Message-ID: <20240829063118.67453-10-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829063118.67453-1-ruanjinjie@huawei.com>
References: <20240829063118.67453-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Use scoped for_each_available_child_of_node_scoped() when iterating
over device nodes to make code a bit simpler.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v3:
- Add Reviewed-by.
---
 drivers/net/ethernet/marvell/mv643xx_eth.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index f35ae2c88091..9e80899546d9 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2802,7 +2802,7 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
 static int mv643xx_eth_shared_of_probe(struct platform_device *pdev)
 {
 	struct mv643xx_eth_shared_platform_data *pd;
-	struct device_node *pnp, *np = pdev->dev.of_node;
+	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
 	/* bail out if not registered from DT */
@@ -2816,10 +2816,9 @@ static int mv643xx_eth_shared_of_probe(struct platform_device *pdev)
 
 	mv643xx_eth_property(np, "tx-checksum-limit", pd->tx_csum_limit);
 
-	for_each_available_child_of_node(np, pnp) {
+	for_each_available_child_of_node_scoped(np, pnp) {
 		ret = mv643xx_eth_shared_of_add_port(pdev, pnp);
 		if (ret) {
-			of_node_put(pnp);
 			mv643xx_eth_shared_of_remove();
 			return ret;
 		}
-- 
2.34.1


