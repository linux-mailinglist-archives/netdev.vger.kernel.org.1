Return-Path: <netdev+bounces-122593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 368D0961CF2
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 05:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E810D2865D2
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 03:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05B0158DCA;
	Wed, 28 Aug 2024 03:16:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09510157492;
	Wed, 28 Aug 2024 03:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724814969; cv=none; b=lLy4QzPBH7u2WIO5Uq9lglrw3o54FRC8kex1rkAnPo/b82MFVKyfHz4BoDnVSRgIvEWgECdATGTWJ63g6CJHHS5K2kEktOydmtklQy1gQ58hiM4hixeDErXSsfm4grq/V2LmxB9jZOssq8nBFUWt8NrTmwps2ACvcJg6juLkiqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724814969; c=relaxed/simple;
	bh=7eY+KRpA2qaSp/dJs4C1zRmxe1bVO/DRfivqxf8o0ak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ODwJjpU4gO/ydGcQTOMVjquQ8vsL1kRc8u+0Q899k+lkCDBoGq1TnLfSEpPrhtkwJt+kcniFBSlg955C9/TVIFo2p+3m/rbBwQ/of58bc6MYR+nDJUHfczKu62C9I1SMsKbXvsE5bi/+FP1UqWyllFJIeG8OSf3TFjmTC6FWgzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WtqF02NC5z20mqm;
	Wed, 28 Aug 2024 11:11:16 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F5D9140135;
	Wed, 28 Aug 2024 11:16:05 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 28 Aug
 2024 11:16:04 +0800
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
Subject: [PATCH net-next v2 13/13] net: bcmasp: Simplify with __free()
Date: Wed, 28 Aug 2024 11:23:43 +0800
Message-ID: <20240828032343.1218749-14-ruanjinjie@huawei.com>
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

Avoid need to manually handle of_node_put() by using __free(), which
can simplfy code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Split into 2 patches.
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index 70219094b7f6..73e767aada2f 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1300,7 +1300,6 @@ static void bcmasp_remove_intfs(struct bcmasp_priv *priv)
 
 static int bcmasp_probe(struct platform_device *pdev)
 {
-	struct device_node *ports_node;
 	const struct bcmasp_plat_data *pdata;
 	struct device *dev = &pdev->dev;
 	struct bcmasp_priv *priv;
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


