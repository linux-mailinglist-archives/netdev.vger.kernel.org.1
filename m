Return-Path: <netdev+bounces-122587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9144961CE4
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 05:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7E1D1C237CB
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 03:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94AA153573;
	Wed, 28 Aug 2024 03:16:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AB514B07A;
	Wed, 28 Aug 2024 03:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724814965; cv=none; b=NG/vwttPNiJSTTbQ50I7KQsT6kVlD50FIIF8tlr9Cw87OSVVxfwfVzrSD08L5cmeNAI4DWvSaRWO7p6namghcoSYkHIy30OldOhMp2ZKHOdymALC3SV6BErV/6rNUZnBPlWqautF5UQjUqn5VSeU7G8k9u38Qle+tSIWw0GLrr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724814965; c=relaxed/simple;
	bh=1OCWzjGLwAeFFQa37W1kA8JVPAji1S4eB3ktGoXoK9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2nVBmlKq9auHHrScBnJ6KV8ojqRqEQPYcHpZNU4ITauD06+YDbnkdC5GKi0e2zvK/N3xW2zMEFCWX6WVrQzrC7jrSVcLWyMb/+zXzb0Z5O9rrhjDqI7a++MNQIhNOiSJNyaXabV9WkTAFVbxJGW6RsNSl0JJbMN2fTg/5sb4iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WtqJV5WXjzpTr8;
	Wed, 28 Aug 2024 11:14:18 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 4BD2314022E;
	Wed, 28 Aug 2024 11:16:00 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 28 Aug
 2024 11:15:59 +0800
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
Subject: [PATCH net-next v2 08/13] net: mdio: mux-mmioreg: Simplified with dev_err_probe()
Date: Wed, 28 Aug 2024 11:23:38 +0800
Message-ID: <20240828032343.1218749-9-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828032343.1218749-1-ruanjinjie@huawei.com>
References: <20240828032343.1218749-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Use the dev_err_probe() helper to simplify code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Split into 2 patches.
---
 drivers/net/mdio/mdio-mux-mmioreg.c | 45 ++++++++++++-----------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/net/mdio/mdio-mux-mmioreg.c b/drivers/net/mdio/mdio-mux-mmioreg.c
index 4d87e61fec7b..08c484ccdcbe 100644
--- a/drivers/net/mdio/mdio-mux-mmioreg.c
+++ b/drivers/net/mdio/mdio-mux-mmioreg.c
@@ -109,30 +109,26 @@ static int mdio_mux_mmioreg_probe(struct platform_device *pdev)
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
@@ -142,17 +138,14 @@ static int mdio_mux_mmioreg_probe(struct platform_device *pdev)
 	for_each_available_child_of_node_scoped(np, np2) {
 		u64 reg;
 
-		if (of_property_read_reg(np2, 0, &reg, NULL)) {
-			dev_err(&pdev->dev, "mdio-mux child node %pOF is "
-				"missing a 'reg' property\n", np2);
-			return -ENODEV;
-		}
-		if ((u32)reg & ~s->mask) {
-			dev_err(&pdev->dev, "mdio-mux child node %pOF has "
-				"a 'reg' value with unmasked bits\n",
-				np2);
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


