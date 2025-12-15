Return-Path: <netdev+bounces-244744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B389DCBDEE3
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 14:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA574301E995
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 12:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6B0299944;
	Mon, 15 Dec 2025 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="CHYyXwoj"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC5F1487E9;
	Mon, 15 Dec 2025 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765803598; cv=none; b=SbWP2mEKuRTQqFi/1pghdHH6ze+ElRI6uAgQaPDaNPnt1kdgSGYXHhdrWBSWGbQqknxXp5jCsHnEvNNmsUSZQ8Qk3H48dvwN4SrUr7akSXp2k5c8ZwtLFfUxzqBjqAD/aXI0WhKaTMydfH94m7nj+hIxVgoVNGUAzE3fvW/S6f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765803598; c=relaxed/simple;
	bh=bwdu7BgczwxVS19Z5tjz0gT9XRdUBc54mzmiO7ERc1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SUbKIsR9wspPEKwey02A4kNs4+SY+KwewtuxUq1RE5kZ8TZm6DwJsE2N0P10DRL0Y6hTqeg1+74XcZ4WmdRHKBee9XRoqJxsOkhZnerVJGB6RHCgtYgSY5VzGASIFtcon9vJJDuPaoQkxKzORCjy00O6G7XQ3Xdel3JV+w7c0V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=CHYyXwoj; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7tciCYRPK0qkdByByNvvvvMGEYxrxnq1OwZmH1xLhxc=;
	b=CHYyXwojEQ7mw3EiJekJIUcWDSyYCCUKwaYUspyAg+9KUvzG9hhAy7z4aGe3IePKJhF1Ikr0Z
	dHNecv/M4djF3k2Z+S84ib2Rpe6Yc2zNpkP0txY82bPBfWhRT5aqutNrWiTU2+uLSNhJLvcDdup
	Mgf72VFtqHDXsGM4nXMUwsM=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dVKq21NW6z1prMW;
	Mon, 15 Dec 2025 20:57:50 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 132D518048A;
	Mon, 15 Dec 2025 20:59:51 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Dec 2025 20:59:50 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<Frank.Sae@motor-comm.com>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<salil.mehta@huawei.com>, <shiyongbang@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH RFC net-next 5/6] net: hibmcge: support get phy device from apci
Date: Mon, 15 Dec 2025 20:57:04 +0800
Message-ID: <20251215125705.1567527-6-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20251215125705.1567527-1-shaojijie@huawei.com>
References: <20251215125705.1567527-1-shaojijie@huawei.com>
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

support get phy device from apci.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
index fb6ece3935e7..36997634486b 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 // Copyright (c) 2024 Hisilicon Limited.
 
+#include <linux/acpi.h>
 #include <linux/phy.h>
 #include <linux/phy_fixed.h>
 #include <linux/rtnetlink.h>
@@ -348,12 +349,36 @@ static int hbg_register_phy_leds_software_node(struct hbg_priv *priv,
 					&phydev->mdio.dev);
 }
 
+static int hbg_find_phy_device_from_acpi(struct hbg_priv *priv)
+{
+	struct device *dev = &priv->pdev->dev;
+	struct fwnode_handle *phy_fwnode;
+	struct phy_device *phydev;
+
+	phy_fwnode = fwnode_get_phy_node(dev_fwnode(dev));
+	if (IS_ERR(phy_fwnode))
+		return dev_err_probe(dev, PTR_ERR(phydev),
+				     "failed to get phy fwnode\n");
+
+	phydev = fwnode_phy_find_device(phy_fwnode);
+	/* We're done with the phy_node handle */
+	fwnode_handle_put(phy_fwnode);
+	if (!phydev)
+		return dev_err_probe(dev, -ENODEV,
+				     "failed to get phy fwnode device\n");
+	priv->mac.phydev = phydev;
+	return 0;
+}
+
 static int hbg_find_phy_device(struct hbg_priv *priv, struct mii_bus *mdio_bus)
 {
 	struct device *dev = &priv->pdev->dev;
 	struct phy_device *phydev;
 	int ret;
 
+	if (has_acpi_companion(dev))
+		return hbg_find_phy_device_from_acpi(priv);
+
 	phydev = get_phy_device(mdio_bus, priv->mac.phy_addr, false);
 	if (IS_ERR(phydev))
 		return dev_err_probe(dev, -ENODEV,
-- 
2.33.0


