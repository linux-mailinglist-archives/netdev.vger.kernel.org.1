Return-Path: <netdev+bounces-123109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A250963B4A
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 08:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5A48B21976
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 06:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33F2156F21;
	Thu, 29 Aug 2024 06:23:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70E042A99
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 06:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912604; cv=none; b=ebkpw2MyCjUMrLC4ePIkTpruhkz/WrwJPUctldCdfRk4AnJMs/lVqd5zwZyOXMPQ/DjSkt4mt52sSpa2vmRS7WJ/1HAanM/l7u9GzvbEpV+2+8oH5SKKexBzQW4r8wbhtZX2SPMuwrCo4jfzfXi54gCW6YfTGQNTMppO1pvCtlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912604; c=relaxed/simple;
	bh=BX4tQuVKxRHIDsrBEBabtw6bPxKpsSvOiHbMHmipqPs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GUoXlUxfzBHeZ6H8o9eQp0T4FT0KXeAEIKFk9yzMOjtf35obhTMr02CrT6rbnv8rzrqWOT4NmXwwVybnzal5DAyqnvWVD4DwFT2DyHSJxi77tTp4ry9JxoTqpwiXzF3ay1mSCzBKiOXnbXWpkrAk1W4Qqn/rKORerkWZLLKdMMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WvWLY31HTzQr3x;
	Thu, 29 Aug 2024 14:18:29 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 182D514035F;
	Thu, 29 Aug 2024 14:23:20 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 29 Aug
 2024 14:23:19 +0800
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
Subject: [PATCH net-next v3 02/13] net: stmmac: dwmac-sun8i: Use __free() to simplify code
Date: Thu, 29 Aug 2024 14:31:07 +0800
Message-ID: <20240829063118.67453-3-ruanjinjie@huawei.com>
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

Avoid need to manually handle of_node_put() by using __free(), which
can simplfy code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v3:
- Add Reviewed-by.
---
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c    | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 4a0ae92b3055..415a0d23b3a5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -774,19 +774,17 @@ static int sun8i_dwmac_reset(struct stmmac_priv *priv)
 static int get_ephy_nodes(struct stmmac_priv *priv)
 {
 	struct sunxi_priv_data *gmac = priv->plat->bsp_priv;
-	struct device_node *mdio_internal;
-	struct device_node *mdio_mux;
 	int ret;
 
-	mdio_mux = of_get_child_by_name(priv->device->of_node, "mdio-mux");
+	struct device_node *mdio_mux __free(device_node) =
+		of_get_child_by_name(priv->device->of_node, "mdio-mux");
 	if (!mdio_mux) {
 		dev_err(priv->device, "Cannot get mdio-mux node\n");
 		return -ENODEV;
 	}
 
-	mdio_internal = of_get_compatible_child(mdio_mux,
-						"allwinner,sun8i-h3-mdio-internal");
-	of_node_put(mdio_mux);
+	struct device_node *mdio_internal __free(device_node) =
+		of_get_compatible_child(mdio_mux, "allwinner,sun8i-h3-mdio-internal");
 	if (!mdio_internal) {
 		dev_err(priv->device, "Cannot get internal_mdio node\n");
 		return -ENODEV;
@@ -800,18 +798,14 @@ static int get_ephy_nodes(struct stmmac_priv *priv)
 		gmac->rst_ephy = of_reset_control_get_exclusive(iphynode, NULL);
 		if (IS_ERR(gmac->rst_ephy)) {
 			ret = PTR_ERR(gmac->rst_ephy);
-			if (ret == -EPROBE_DEFER) {
-				of_node_put(mdio_internal);
+			if (ret == -EPROBE_DEFER)
 				return ret;
-			}
 			continue;
 		}
 		dev_info(priv->device, "Found internal PHY node\n");
-		of_node_put(mdio_internal);
 		return 0;
 	}
 
-	of_node_put(mdio_internal);
 	return -ENODEV;
 }
 
-- 
2.34.1


