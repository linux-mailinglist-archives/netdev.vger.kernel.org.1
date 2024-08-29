Return-Path: <netdev+bounces-123111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9607C963B4E
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 08:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8BA91C23A6F
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 06:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B92A15C148;
	Thu, 29 Aug 2024 06:23:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B62313E02A
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 06:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912607; cv=none; b=sSuHCn6oO0AH0aAZNba4scWZpEWcUQCTfwHeecAT4OiizYL9E3xvzUVhss02A6Gjsw2MAFvU5ZlKErJaq9T1dly6BFRBX9k5HyqcVrsOnbieJ5aU3RQUv0rYUjdZzXcKjdsdGAJOs4wDTxXzE3jfo+0lw4LvXaTB9emxi9RrwO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912607; c=relaxed/simple;
	bh=nfRvCwtUxCdNFz5wE3FVRo2Y/4Gnoo4XC79a+VeWSCs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JI5n/1OUJz6tGCpCCXiRiXDj04qwm0EaR7xGOOrhTPmH2wWJvCBkq2u+ANjypz/4Mv6+e18quD7jsWtb0JHYDNjUAz7NAIjRxv8NCoyAJXq4PoQrMdbuWKCy1pT/re/4wdvIUL4DQP7FoSIqK/ea/s70Fp0QRaH3ZS8zUA1qYGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WvWRw6WYNz1S91W;
	Thu, 29 Aug 2024 14:23:08 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id D4E591A016C;
	Thu, 29 Aug 2024 14:23:21 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 29 Aug
 2024 14:23:20 +0800
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
Subject: [PATCH net-next v3 04/13] net: dsa: realtek: Use __free() to simplify code
Date: Thu, 29 Aug 2024 14:31:09 +0800
Message-ID: <20240829063118.67453-5-ruanjinjie@huawei.com>
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
Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
---
v3:
- Move "return ret" up to the only place it can come from.
- Use ret only in the loop.
v2
- Split into 2 patches.
---
 drivers/net/dsa/realtek/rtl8366rb.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 11243f89c98a..31d2d5356c1e 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -1010,15 +1010,14 @@ static int rtl8366rb_setup_all_leds_off(struct realtek_priv *priv)
 static int rtl8366rb_setup_leds(struct realtek_priv *priv)
 {
 	struct dsa_switch *ds = &priv->ds;
-	struct device_node *leds_np;
 	struct dsa_port *dp;
-	int ret = 0;
 
 	dsa_switch_for_each_port(dp, ds) {
 		if (!dp->dn)
 			continue;
 
-		leds_np = of_get_child_by_name(dp->dn, "leds");
+		struct device_node *leds_np __free(device_node) =
+			of_get_child_by_name(dp->dn, "leds");
 		if (!leds_np) {
 			dev_dbg(priv->dev, "No leds defined for port %d",
 				dp->index);
@@ -1026,15 +1025,11 @@ static int rtl8366rb_setup_leds(struct realtek_priv *priv)
 		}
 
 		for_each_child_of_node_scoped(leds_np, led_np) {
-			ret = rtl8366rb_setup_led(priv, dp,
-						  of_fwnode_handle(led_np));
+			int ret = rtl8366rb_setup_led(priv, dp,
+						      of_fwnode_handle(led_np));
 			if (ret)
-				break;
+				return ret;
 		}
-
-		of_node_put(leds_np);
-		if (ret)
-			return ret;
 	}
 	return 0;
 }
-- 
2.34.1


