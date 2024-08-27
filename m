Return-Path: <netdev+bounces-122171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C3F960389
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 09:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33FB1282E52
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 07:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899421990AF;
	Tue, 27 Aug 2024 07:44:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E991714A3;
	Tue, 27 Aug 2024 07:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744678; cv=none; b=gj7LzNXOhFw9Yk14xrH1gJyMflm4WtlmBz5kfw+EJuImyF2sE31i31GEPE2DsO8ret4rgXerTkUfOQcnn48xobW02KavWh/+NAF+MbKF0iXbyU546R+hot/F9tp25VK0iaTFBTekkNHbmpiMn+JBSe2/ar1Lp5i20J6ZqDboEGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744678; c=relaxed/simple;
	bh=6oQfqsiOHa148ej6oqVjJ4ZyoSRmgAX54PXgsOHoj68=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZCQIaD60DF+2CNWzea5ST/PZUdyxKF7kJpwt4gWBbU9KgLzBg9Sc6R+5fP1sGVUdg8vnfQqwCFep61KhlDOJILLVlM6sMcd0nilmp2tOjGEek6oCjIDy4xnXskplNxbLa6dB/RxfrpvB40JtA0QIle0VrUPq7fNfmbJ3spbpbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WtKGy6L3Hz1HFm4;
	Tue, 27 Aug 2024 15:41:14 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 60CF5140154;
	Tue, 27 Aug 2024 15:44:33 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Aug
 2024 15:44:32 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <woojung.huh@microchip.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linus.walleij@linaro.org>,
	<alsi@bang-olufsen.dk>, <justin.chen@broadcom.com>,
	<sebastian.hesselbarth@gmail.com>, <alexandre.torgue@foss.st.com>,
	<joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>, <wens@csie.org>,
	<jernej.skrabec@gmail.com>, <samuel@sholland.org>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <ansuelsmth@gmail.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bcm-kernel-feedback-list@broadcom.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<linux-stm32@st-md-mailman.stormreply.com>, <krzk@kernel.org>,
	<jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 4/7] net: mdio: mux-mmioreg: Simplified with scoped function and dev_err_probe()
Date: Tue, 27 Aug 2024 15:52:16 +0800
Message-ID: <20240827075219.3793198-5-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827075219.3793198-1-ruanjinjie@huawei.com>
References: <20240827075219.3793198-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Avoids the need for manual cleanup of_node_put() in early exits
from the loop by using for_each_available_child_of_node_scoped().

And use the dev_err_probe() helper to simplify error handling during probe.
This also handle scenario, when EDEFER is returned and useless error
is printed.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/net/mdio/mdio-mux-mmioreg.c | 51 ++++++++++++-----------------
 1 file changed, 21 insertions(+), 30 deletions(-)

diff --git a/drivers/net/mdio/mdio-mux-mmioreg.c b/drivers/net/mdio/mdio-mux-mmioreg.c
index de08419d0c98..08c484ccdcbe 100644
--- a/drivers/net/mdio/mdio-mux-mmioreg.c
+++ b/drivers/net/mdio/mdio-mux-mmioreg.c
@@ -96,7 +96,7 @@ static int mdio_mux_mmioreg_switch_fn(int current_child, int desired_child,
 
 static int mdio_mux_mmioreg_probe(struct platform_device *pdev)
 {
-	struct device_node *np2, *np = pdev->dev.of_node;
+	struct device_node *np = pdev->dev.of_node;
 	struct mdio_mux_mmioreg_state *s;
 	struct resource res;
 	const __be32 *iprop;
@@ -109,52 +109,43 @@ static int mdio_mux_mmioreg_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = of_address_to_resource(np, 0, &res);
-	if (ret) {
-		dev_err(&pdev->dev, "could not obtain memory map for node %pOF\n",
-			np);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "could not obtain memory map for node %pOF\n", np);
 	s->phys = res.start;
 
 	s->iosize = resource_size(&res);
 	if (s->iosize != sizeof(uint8_t) &&
 	    s->iosize != sizeof(uint16_t) &&
 	    s->iosize != sizeof(uint32_t)) {
-		dev_err(&pdev->dev, "only 8/16/32-bit registers are supported\n");
-		return -EINVAL;
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "only 8/16/32-bit registers are supported\n");
 	}
 
 	iprop = of_get_property(np, "mux-mask", &len);
-	if (!iprop || len != sizeof(uint32_t)) {
-		dev_err(&pdev->dev, "missing or invalid mux-mask property\n");
-		return -ENODEV;
-	}
-	if (be32_to_cpup(iprop) >= BIT(s->iosize * 8)) {
-		dev_err(&pdev->dev, "only 8/16/32-bit registers are supported\n");
-		return -EINVAL;
-	}
+	if (!iprop || len != sizeof(uint32_t))
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "missing or invalid mux-mask property\n");
+	if (be32_to_cpup(iprop) >= BIT(s->iosize * 8))
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "only 8/16/32-bit registers are supported\n");
 	s->mask = be32_to_cpup(iprop);
 
 	/*
 	 * Verify that the 'reg' property of each child MDIO bus does not
 	 * set any bits outside of the 'mask'.
 	 */
-	for_each_available_child_of_node(np, np2) {
+	for_each_available_child_of_node_scoped(np, np2) {
 		u64 reg;
 
-		if (of_property_read_reg(np2, 0, &reg, NULL)) {
-			dev_err(&pdev->dev, "mdio-mux child node %pOF is "
-				"missing a 'reg' property\n", np2);
-			of_node_put(np2);
-			return -ENODEV;
-		}
-		if ((u32)reg & ~s->mask) {
-			dev_err(&pdev->dev, "mdio-mux child node %pOF has "
-				"a 'reg' value with unmasked bits\n",
-				np2);
-			of_node_put(np2);
-			return -ENODEV;
-		}
+		if (of_property_read_reg(np2, 0, &reg, NULL))
+			return dev_err_probe(&pdev->dev, -ENODEV,
+					     "mdio-mux child node %pOF is missing a 'reg' property\n",
+					     np2);
+		if ((u32)reg & ~s->mask)
+			return dev_err_probe(&pdev->dev, -ENODEV,
+					     "mdio-mux child node %pOF has a 'reg' value with unmasked bits\n",
+					     np2);
 	}
 
 	ret = mdio_mux_init(&pdev->dev, pdev->dev.of_node,
-- 
2.34.1


