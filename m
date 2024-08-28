Return-Path: <netdev+bounces-122582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40014961CD7
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 05:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4717B21E2A
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 03:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7129013D52C;
	Wed, 28 Aug 2024 03:15:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2921304BF;
	Wed, 28 Aug 2024 03:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724814957; cv=none; b=KsTCM1MkR4ukyqP4tvqYpdcGrptjxDzwxGpVJo3Rq1Vf+dhFa0JeDxOU5MbTR6ru8+cIcIvFfwZOdGuXqBYzTN5tjyZHGYIWgx5ICkkd+WnATlQwmf1cIuuwJAcXTMdYAhHfNmHuRMzFX3jO5vSCsL8cUyHAiyrzURkKVtcBoHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724814957; c=relaxed/simple;
	bh=OZIotPfATJG10qlLDO1uMu9SkZx6sX/US1BzCTa8p4w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=idsf70h2hmLJSp3NWo0RzhCcrcioQ9adXVirFGCGbw9R5UBXvkh4uiaxF8PUK5uaoVXXo/x/HmtVyhRrdqypEcgNmEKe0ZcCAStPlI1Qgv1/QS69XOERz3AIBdZ0QVqwMJLSvu32ORjHeilFfgoUqMsl6zVEEIXT7Be4xxIsjoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WtqHx3WJGzfbh2;
	Wed, 28 Aug 2024 11:13:49 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 3984414022E;
	Wed, 28 Aug 2024 11:15:53 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 28 Aug
 2024 11:15:52 +0800
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
Subject: [PATCH net-next v2 01/13] net: stmmac: dwmac-sun8i: Use for_each_child_of_node_scoped()
Date: Wed, 28 Aug 2024 11:23:31 +0800
Message-ID: <20240828032343.1218749-2-ruanjinjie@huawei.com>
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

Avoid need to manually handle of_node_put() by using
for_each_child_of_node_scoped(), which can simplfy code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index cc93f73a380e..8c5b4e0c0976 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -774,7 +774,7 @@ static int sun8i_dwmac_reset(struct stmmac_priv *priv)
 static int get_ephy_nodes(struct stmmac_priv *priv)
 {
 	struct sunxi_priv_data *gmac = priv->plat->bsp_priv;
-	struct device_node *mdio_mux, *iphynode;
+	struct device_node *mdio_mux;
 	struct device_node *mdio_internal;
 	int ret;
 
@@ -793,7 +793,7 @@ static int get_ephy_nodes(struct stmmac_priv *priv)
 	}
 
 	/* Seek for internal PHY */
-	for_each_child_of_node(mdio_internal, iphynode) {
+	for_each_child_of_node_scoped(mdio_internal, iphynode) {
 		gmac->ephy_clk = of_clk_get(iphynode, 0);
 		if (IS_ERR(gmac->ephy_clk))
 			continue;
@@ -801,14 +801,12 @@ static int get_ephy_nodes(struct stmmac_priv *priv)
 		if (IS_ERR(gmac->rst_ephy)) {
 			ret = PTR_ERR(gmac->rst_ephy);
 			if (ret == -EPROBE_DEFER) {
-				of_node_put(iphynode);
 				of_node_put(mdio_internal);
 				return ret;
 			}
 			continue;
 		}
 		dev_info(priv->device, "Found internal PHY node\n");
-		of_node_put(iphynode);
 		of_node_put(mdio_internal);
 		return 0;
 	}
-- 
2.34.1


