Return-Path: <netdev+bounces-123574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA7096557D
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 05:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EF6BB21697
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 03:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82E5136337;
	Fri, 30 Aug 2024 03:05:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A6071750
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 03:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724987154; cv=none; b=BwS7vR7y3fr659P2Iw5jIoL8WQJzMgwBGdg5jv+U0Qc1GB71hbvJv/emdAX6lVJLI26PYCWdPYXI0hinyW1NP8Wv5qFAhlDe2zAgTO3cn9LA9jTWBWOr0cfykvHm5f0098QJDG2IsBFQdFUFRXqU9reGegOEoLfsX7ZR0vJcloI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724987154; c=relaxed/simple;
	bh=OeQC3mVGMaxIz8MfG4l1DZlSCVoC+D0oyUO1TzMd7mk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2jFs+e64m3pg6KcBHmIt4xPwTpOHJ9xgkCpVlb6fA1+X6U25wJY7m/mlowc4j5B3HJpsusVnZJYNmULGJSDjcHCkrht6DYyKTngXID+L5yaQv1nI/DVVaRh7mHTyjcoR+AArN9/ZxD1IqpctoeJnohr3qlC4dToREYlHJwbZZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Ww2zK65xrz1xwgV;
	Fri, 30 Aug 2024 11:03:41 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 3EDD21402C6;
	Fri, 30 Aug 2024 11:05:40 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 11:05:39 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <woojung.huh@microchip.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linus.walleij@linaro.org>,
	<alsi@bang-olufsen.dk>, <justin.chen@broadcom.com>,
	<sebastian.hesselbarth@gmail.com>, <alexandre.torgue@foss.st.com>,
	<joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>, <wens@csie.org>,
	<jernej.skrabec@gmail.com>, <samuel@sholland.org>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <bcm-kernel-feedback-list@broadcom.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<linux-stm32@st-md-mailman.stormreply.com>, <krzk@kernel.org>,
	<jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next v4 1/8] net: stmmac: dwmac-sun8i: Use for_each_child_of_node_scoped()
Date: Fri, 30 Aug 2024 11:13:18 +0800
Message-ID: <20240830031325.2406672-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830031325.2406672-1-ruanjinjie@huawei.com>
References: <20240830031325.2406672-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Avoid need to manually handle of_node_put() by using
for_each_child_of_node_scoped(), which can simplfy code.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v4:
- Add Reviewed-by.
- Signed-off-by: should always be last.
v3:
- Sort the variables, longest first, shortest last
- Add Reviewed-by.
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index cc93f73a380e..4a0ae92b3055 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -774,8 +774,8 @@ static int sun8i_dwmac_reset(struct stmmac_priv *priv)
 static int get_ephy_nodes(struct stmmac_priv *priv)
 {
 	struct sunxi_priv_data *gmac = priv->plat->bsp_priv;
-	struct device_node *mdio_mux, *iphynode;
 	struct device_node *mdio_internal;
+	struct device_node *mdio_mux;
 	int ret;
 
 	mdio_mux = of_get_child_by_name(priv->device->of_node, "mdio-mux");
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


