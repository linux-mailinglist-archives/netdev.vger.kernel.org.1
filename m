Return-Path: <netdev+bounces-122168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88117960383
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 09:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B61261C2255F
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 07:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A128518756A;
	Tue, 27 Aug 2024 07:44:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0066F158875;
	Tue, 27 Aug 2024 07:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744676; cv=none; b=OjW4c4Jjdj/qSPbnYBEixGZffNl7PtgOB153uBTZJiAZsLNc5CywfT2HKa/0/oPJkcOxmpQYLny/MPUMeyG2fqMzCJ1hG1eE3LHWq0bNSftOnAMZMoOgL5SZO8vaSng2VTLntvD0bZj4nnD/4mz20+z2tvoNvv0TXPH/ecZeE0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744676; c=relaxed/simple;
	bh=g9ZvAHk+N+rt85ClMjsz9HfcR2QjF4Ufi+FbhGOz9tY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gVssElx9lRT/WkqsvEQp53zIqfnhS6WKN7FsBhBSbSgtiyrslRQUJfxjsYT1m0JkWMyNVi6T6wlYUHG6n8ft51KNK6iH6L1lpewr0wAA5nT2O8eiudCW6RbBmvYxABPdW4oTwFO9B+FK47VQzrhL4xfxGbyWT9iaUjy+Sp2rvRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WtKLB3T2CzyRCS;
	Tue, 27 Aug 2024 15:44:02 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B15F140137;
	Tue, 27 Aug 2024 15:44:31 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Aug
 2024 15:44:30 +0800
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
Subject: [PATCH -next 2/7] net: dsa: realtek: Use for_each_child_of_node_scoped() and __free()
Date: Tue, 27 Aug 2024 15:52:14 +0800
Message-ID: <20240827075219.3793198-3-ruanjinjie@huawei.com>
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

Avoid need to manually handle of_node_put() by using
for_each_child_of_node_scoped() and __free(), which can simplfy code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/net/dsa/realtek/rtl8366rb.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 9e821b42e5f3..0acdcdd93ea2 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -1009,7 +1009,6 @@ static int rtl8366rb_setup_all_leds_off(struct realtek_priv *priv)
 
 static int rtl8366rb_setup_leds(struct realtek_priv *priv)
 {
-	struct device_node *leds_np, *led_np;
 	struct dsa_switch *ds = &priv->ds;
 	struct dsa_port *dp;
 	int ret = 0;
@@ -1018,23 +1017,21 @@ static int rtl8366rb_setup_leds(struct realtek_priv *priv)
 		if (!dp->dn)
 			continue;
 
-		leds_np = of_get_child_by_name(dp->dn, "leds");
+		struct device_node *leds_np __free(device_node) =
+			of_get_child_by_name(dp->dn, "leds");
 		if (!leds_np) {
 			dev_dbg(priv->dev, "No leds defined for port %d",
 				dp->index);
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
 
-		of_node_put(leds_np);
 		if (ret)
 			return ret;
 	}
-- 
2.34.1


