Return-Path: <netdev+bounces-122173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E10D4960390
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 09:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BDF51F23BC6
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 07:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25E519DF58;
	Tue, 27 Aug 2024 07:44:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0B019923A;
	Tue, 27 Aug 2024 07:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744680; cv=none; b=CmqRP4zeGg1/XZdok+NRsSDtDKTtgCTj6xGZZP951GVO2mMSgiNI/H9QTj2GYe8Z69xOwyr3iy8QQ0ZzaqiTfLie8H1/vdCnNTtvdL3Ud/p2+SoCwbcES33vtLm2em24lXk9gpD0YZYXAGMxKElngjET02wRfpxAgswFUdom9m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744680; c=relaxed/simple;
	bh=9WmcpDhjQpmGtaapVjGKh4LJjWs0+hFNOD0OuHPxsU8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZG28SD6Z8LlUgCQfVnqoXEIgwv/juxYMRwFy2acmD26Qftsa3gd4dxbPSX7s1Gds62gTQnrB/YCBI8g/xA2BewGnYDYy5XA/oDmMU1Q/D7jsvoHb12+iXHt04wZAJHdbVM6HHm71WgO4nBFS0hy/roM8L6BaeEwF2v/tLs6GgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WtKFJ03pPz20mhj;
	Tue, 27 Aug 2024 15:39:48 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 19E411400F4;
	Tue, 27 Aug 2024 15:44:36 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Aug
 2024 15:44:35 +0800
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
Subject: [PATCH -next 7/7] net: bcmasp: Simplify with scoped for each OF child loop
Date: Tue, 27 Aug 2024 15:52:19 +0800
Message-ID: <20240827075219.3793198-8-ruanjinjie@huawei.com>
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

Use scoped for_each_available_child_of_node_scoped() and __free()
when iterating over device nodes to make code a bit simpler.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index 20c6529ec135..73e767aada2f 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1300,7 +1300,6 @@ static void bcmasp_remove_intfs(struct bcmasp_priv *priv)
 
 static int bcmasp_probe(struct platform_device *pdev)
 {
-	struct device_node *ports_node, *intf_node;
 	const struct bcmasp_plat_data *pdata;
 	struct device *dev = &pdev->dev;
 	struct bcmasp_priv *priv;
@@ -1367,21 +1366,20 @@ static int bcmasp_probe(struct platform_device *pdev)
 	bcmasp_core_init(priv);
 	bcmasp_core_init_filters(priv);
 
-	ports_node = of_find_node_by_name(dev->of_node, "ethernet-ports");
+	struct device_node *ports_node __free(device_node) =
+		of_find_node_by_name(dev->of_node, "ethernet-ports");
 	if (!ports_node) {
 		dev_warn(dev, "No ports found\n");
 		return -EINVAL;
 	}
 
 	i = 0;
-	for_each_available_child_of_node(ports_node, intf_node) {
+	for_each_available_child_of_node_scoped(ports_node, intf_node) {
 		intf = bcmasp_interface_create(priv, intf_node, i);
 		if (!intf) {
-			dev_err(dev, "Cannot create eth interface %d\n", i);
 			bcmasp_remove_intfs(priv);
-			of_node_put(intf_node);
-			ret = -ENOMEM;
-			goto of_put_exit;
+			return dev_err_probe(dev, -ENOMEM,
+					     "Cannot create eth interface %d\n", i);
 		}
 		list_add_tail(&intf->list, &priv->intfs);
 		i++;
@@ -1407,16 +1405,14 @@ static int bcmasp_probe(struct platform_device *pdev)
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


