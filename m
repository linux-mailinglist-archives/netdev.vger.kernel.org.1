Return-Path: <netdev+bounces-123108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDC8963B48
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 08:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B07286384
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 06:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F333914F9DD;
	Thu, 29 Aug 2024 06:23:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1427214D430
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 06:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912604; cv=none; b=b7vHFW8oidhhDFNuPbCIUrINA6sym1GW9e5pZhtx4CkHZqdlMqsNtH/GEcVd/ztEHxf+w6zo1CnJYuz+fbVzeh+P2QWtEyaE6skWUUeNtyn3CLr0DVfrKjBM5XoRFPQogNefKv/xJSYm4BuBLWDNmGf6MhhdsqP6v1u9iwcgKCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912604; c=relaxed/simple;
	bh=C2KPCMDV8PNgc3PGpuWU5pi0y5zq1XefhXEB6ugn73c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aa/aeTUp5JiDwOPdwlb/ZEr776i7G6LbAGgzEwP/e21Qk3MtbU9Bzq/dgUxpj6gFcwUo9mFeyoSsbt4oh5hyqKKkVItCXEszXFPbRLwvu0NTnTTz4TrgXni2VOfn3ef0cUzdn8jgWTwhdXNBcGEull/m10oBG+4jrqmCPiJyiAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WvWRY5FRCzyR3l;
	Thu, 29 Aug 2024 14:22:49 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id EEE6214035F;
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
Subject: [PATCH net-next v3 03/13] net: dsa: realtek: Use for_each_child_of_node_scoped()
Date: Thu, 29 Aug 2024 14:31:08 +0800
Message-ID: <20240829063118.67453-4-ruanjinjie@huawei.com>
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

Avoid need to manually handle of_node_put() by using
for_each_child_of_node_scoped(), which can simplfy code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v3:
- Sort the variables, longest first, shortest last
- Add Reviewed-by.
v2:
- Split into 2 patches.
---
 drivers/net/dsa/realtek/rtl8366rb.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 9e821b42e5f3..11243f89c98a 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -1009,8 +1009,8 @@ static int rtl8366rb_setup_all_leds_off(struct realtek_priv *priv)
 
 static int rtl8366rb_setup_leds(struct realtek_priv *priv)
 {
-	struct device_node *leds_np, *led_np;
 	struct dsa_switch *ds = &priv->ds;
+	struct device_node *leds_np;
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


