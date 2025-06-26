Return-Path: <netdev+bounces-201386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AB0AE93E7
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 04:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F8B77AFA0A
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 02:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDC01DE2BF;
	Thu, 26 Jun 2025 02:13:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA481C5D44;
	Thu, 26 Jun 2025 02:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750903983; cv=none; b=Px0BiT3rgIfBhY5fBUcWAQYu1m+zAhKURNJLz+7JYSuaCjUQJGNF8iDbrmBkqiVSUv9kCUGdV22I4La7kulFL5KgAQLw0brnTSY2SPQaioMj3zL3qyE8E0zsQMrdnfSBtUYfOV63b6QOjHgWNwdfZC/J9oJOXRUj05yAa5jUpb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750903983; c=relaxed/simple;
	bh=6L8GoP+5WqzddAh8kYsfwbUi0ImEROV6JwfXPep3qD0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CngdX4SlS7FixpZhdhkawI08OAy8zQ8m7fJqZ9Eodt7IzGNVpi+Y7Yb/biqR8zg8m3ah7muLGM6ivda1drbt6DUtEMHy2J4Q5y7A18ybSf81cEoPztxLhiQPM0oxYRFga7ahegpt4pdeqepYv3uwu9iVPqBX6y9xy+G1IW8VB7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bSMd15tlbztSbs;
	Thu, 26 Jun 2025 10:11:49 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id C18EE14027D;
	Thu, 26 Jun 2025 10:12:58 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Jun 2025 10:12:57 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH v3 net-next 1/3] net: hibmcge: support scenario without PHY
Date: Thu, 26 Jun 2025 10:06:11 +0800
Message-ID: <20250626020613.637949-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250626020613.637949-1-shaojijie@huawei.com>
References: <20250626020613.637949-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100013.china.huawei.com (7.202.194.61)

Currently, the driver uses phylib to operate PHY by default.

On some boards, the PHY device is separated from the MAC device.
As a result, the hibmcge driver cannot operate the PHY device.

In this patch, the driver determines whether a PHY is available
based on register configuration. If no PHY is available,
the driver use fixed_phy to register fake phydev.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
ChangeLog:
v2 -> v3:
  - Use fixed_phy to re-implement the no-phy scenario, suggested by Andrew Lunn
  v2: https://lore.kernel.org/all/20250623034129.838246-1-shaojijie@huawei.com/
---
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
index 42b0083c9193..41558fe7770c 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2024 Hisilicon Limited.
 
 #include <linux/phy.h>
+#include <linux/phy_fixed.h>
 #include <linux/rtnetlink.h>
 #include "hbg_common.h"
 #include "hbg_hw.h"
@@ -19,6 +20,7 @@
 #define HBG_MDIO_OP_INTERVAL_US		(5 * 1000)
 
 #define HBG_NP_LINK_FAIL_RETRY_TIMES	5
+#define HBG_NO_PHY	0xFF
 
 static void hbg_mdio_set_command(struct hbg_mac *mac, u32 cmd)
 {
@@ -229,6 +231,39 @@ void hbg_phy_stop(struct hbg_priv *priv)
 	phy_stop(priv->mac.phydev);
 }
 
+static void hbg_fixed_phy_uninit(void *data)
+{
+	fixed_phy_unregister((struct phy_device *)data);
+}
+
+static int hbg_fixed_phy_init(struct hbg_priv *priv)
+{
+	struct fixed_phy_status hbg_fixed_phy_status = {
+		.link = 1,
+		.speed = SPEED_1000,
+		.duplex = DUPLEX_FULL,
+		.pause = 1,
+		.asym_pause = 1,
+	};
+	struct device *dev = &priv->pdev->dev;
+	struct phy_device *phydev;
+	int ret;
+
+	phydev = fixed_phy_register(&hbg_fixed_phy_status, NULL);
+	if (IS_ERR(phydev)) {
+		dev_err_probe(dev, IS_ERR(phydev),
+			      "failed to register fixed PHY device\n");
+		return IS_ERR(phydev);
+	}
+
+	ret = devm_add_action_or_reset(dev, hbg_fixed_phy_uninit, phydev);
+	if (ret)
+		return ret;
+
+	priv->mac.phydev = phydev;
+	return hbg_phy_connect(priv);
+}
+
 int hbg_mdio_init(struct hbg_priv *priv)
 {
 	struct device *dev = &priv->pdev->dev;
@@ -238,6 +273,9 @@ int hbg_mdio_init(struct hbg_priv *priv)
 	int ret;
 
 	mac->phy_addr = priv->dev_specs.phy_addr;
+	if (mac->phy_addr == HBG_NO_PHY)
+		return hbg_fixed_phy_init(priv);
+
 	mdio_bus = devm_mdiobus_alloc(dev);
 	if (!mdio_bus)
 		return dev_err_probe(dev, -ENOMEM,
-- 
2.33.0


