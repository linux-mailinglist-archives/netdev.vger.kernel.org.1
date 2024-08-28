Return-Path: <netdev+bounces-122586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D92B961CE3
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 05:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59096285969
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 03:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B511509B3;
	Wed, 28 Aug 2024 03:16:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89B413C670;
	Wed, 28 Aug 2024 03:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724814965; cv=none; b=c+jKAkLOzJoReuZysymmwy4Le9XxWTxPyVHwf+xI6c9n0Qv8TLkhK28S09KV/o42LTbQUd3xGnkaZCGFffv5zDLPu/6L80k2/h7GiFmIgPL4jaOJIq88q6ogKJJqXWLdT/tDf3AahO5iKI9uaWGsGLKMa14G3MqBVSt/MMQcbig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724814965; c=relaxed/simple;
	bh=KtCLfUO5d4KcCMinRnDksVftKcIPGroSL2PjQSzRVaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pMpEpI7spyhCTe6jU2VPAy9zKbtqTWf1DMGcSruNnE3d3/hNBf6jsdIu7QCvqnvISLzXmnAxwbp92eKNBzX+r5jsQZIhGkM/ecnjdZtKLwhEWjFLHhcFGhdb1PyK0/UTuKKJnNoZWAwG188qXyUr8dwg4kg2aafyWas8LpjTLmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WtqJ5580Pz1xwPj;
	Wed, 28 Aug 2024 11:13:57 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 3792F140135;
	Wed, 28 Aug 2024 11:15:55 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 28 Aug
 2024 11:15:54 +0800
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
Subject: [PATCH net-next v2 03/13] net: dsa: realtek: Use for_each_child_of_node_scoped()
Date: Wed, 28 Aug 2024 11:23:33 +0800
Message-ID: <20240828032343.1218749-4-ruanjinjie@huawei.com>
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
v2:
- Split into 2 patches.
---
 drivers/net/dsa/realtek/rtl8366rb.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 9e821b42e5f3..7001b8b1c028 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -1009,7 +1009,7 @@ static int rtl8366rb_setup_all_leds_off(struct realtek_priv *priv)
 
 static int rtl8366rb_setup_leds(struct realtek_priv *priv)
 {
-	struct device_node *leds_np, *led_np;
+	struct device_node *leds_np;
 	struct dsa_switch *ds = &priv->ds;
 	struct dsa_port *dp;
 	int ret = 0;
@@ -1025,13 +1025,11 @@ static int rtl8366rb_setup_leds(struct realtek_priv *priv)
 			continue;
 		}
 
-		for_each_child_of_node(leds_np, led_np) {
+		for_each_child_of_node_scoped(leds_np, led_np) {
 			ret = rtl8366rb_setup_led(priv, dp,
 						  of_fwnode_handle(led_np));
-			if (ret) {
-				of_node_put(led_np);
+			if (ret)
 				break;
-			}
 		}
 
 		of_node_put(leds_np);
-- 
2.34.1


