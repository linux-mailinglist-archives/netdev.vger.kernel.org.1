Return-Path: <netdev+bounces-123118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BADD3963B57
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 08:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44729B22AB8
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 06:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A69153BEF;
	Thu, 29 Aug 2024 06:23:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6770B16D4CA
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 06:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912615; cv=none; b=rUOu9TLCcRPv2NhBq+fqO+3VJzfQ+ri+0kqIxxi9GRzi+C5C5Y4GCYSezA9F/61aGKUWGNGWemV8TJUGIiBwZBoLfIh6kMfCQN4bRc3Zh2cHtfD5DrcfI6UNtMBRil/xJ8RQSgBXXLS9B+yXTS8OetBBzoPH3TPfvjp2tpikbbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912615; c=relaxed/simple;
	bh=tqd/UpbuLK4fDS0wPAQt7nXr2DF6hHvwdCpb/IcE2wA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NEjFva7J0eeMRx/RjVuWrkRkFbCvvfWeoYqUbhn5Qf12HEueIDt7iZh2064dRioWah5a4Ot/4wpxzGPjbZXsuVUBw45AuEkn2w7e3lsgQ4o1FI0/5ELW7wEX00XpTk6WAM2NR5mI9iTcn8vEw2lgEmtN5s9eOGYIj9smFG2KRCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WvWS53SY1z2Dbc5;
	Thu, 29 Aug 2024 14:23:17 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id D1EE01400E8;
	Thu, 29 Aug 2024 14:23:29 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 29 Aug
 2024 14:23:28 +0800
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
Subject: [PATCH net-next v3 13/13] net: bcmasp: Simplify with __free()
Date: Thu, 29 Aug 2024 14:31:18 +0800
Message-ID: <20240829063118.67453-14-ruanjinjie@huawei.com>
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
v2:
- Split into 2 patches.
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index 297c2682a9cf..73e767aada2f 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1302,7 +1302,6 @@ static int bcmasp_probe(struct platform_device *pdev)
 {
 	const struct bcmasp_plat_data *pdata;
 	struct device *dev = &pdev->dev;
-	struct device_node *ports_node;
 	struct bcmasp_priv *priv;
 	struct bcmasp_intf *intf;
 	int ret = 0, count = 0;
@@ -1367,7 +1366,8 @@ static int bcmasp_probe(struct platform_device *pdev)
 	bcmasp_core_init(priv);
 	bcmasp_core_init_filters(priv);
 
-	ports_node = of_find_node_by_name(dev->of_node, "ethernet-ports");
+	struct device_node *ports_node __free(device_node) =
+		of_find_node_by_name(dev->of_node, "ethernet-ports");
 	if (!ports_node) {
 		dev_warn(dev, "No ports found\n");
 		return -EINVAL;
@@ -1377,10 +1377,9 @@ static int bcmasp_probe(struct platform_device *pdev)
 	for_each_available_child_of_node_scoped(ports_node, intf_node) {
 		intf = bcmasp_interface_create(priv, intf_node, i);
 		if (!intf) {
-			dev_err(dev, "Cannot create eth interface %d\n", i);
 			bcmasp_remove_intfs(priv);
-			ret = -ENOMEM;
-			goto of_put_exit;
+			return dev_err_probe(dev, -ENOMEM,
+					     "Cannot create eth interface %d\n", i);
 		}
 		list_add_tail(&intf->list, &priv->intfs);
 		i++;
@@ -1406,16 +1405,14 @@ static int bcmasp_probe(struct platform_device *pdev)
 				   "failed to register net_device: %d\n", ret);
 			priv->destroy_wol(priv);
 			bcmasp_remove_intfs(priv);
-			goto of_put_exit;
+			return ret;
 		}
 		count++;
 	}
 
 	dev_info(dev, "Initialized %d port(s)\n", count);
 
-of_put_exit:
-	of_node_put(ports_node);
-	return ret;
+	return 0;
 }
 
 static void bcmasp_remove(struct platform_device *pdev)
-- 
2.34.1


