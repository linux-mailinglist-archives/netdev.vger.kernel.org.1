Return-Path: <netdev+bounces-122169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B80C960385
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 09:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B6E282ACD
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 07:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528C71925B5;
	Tue, 27 Aug 2024 07:44:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF23B158218;
	Tue, 27 Aug 2024 07:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744677; cv=none; b=CNwvd2tKfvty8HUsaEIgAQMKbEg0riwhuHdIrZGo7amXoi5dwmlIpPo+BgQmb8g1gK91D5IqHy2Vbh3p//osFipDHAJx1Mu2XGXBL5aeyX4H0umGmaKE8w6bjwYxMgCzwj1WQo8GIL06aZTHPDPjmu2Lb3PW6QqbgM7kOw2tBH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744677; c=relaxed/simple;
	bh=xpQdtN/7TkKZDh5NKU1G4LJqTWkDaV8ddKqKicbmXxY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q6RHSymZWxavOXWUzkx9QNNcq5ihpBGMQqm4dbvUL5APKIKRxs5ODN/bSfiqdPFLAAG/w8cbKv9QkVhduQMIxGx5TzXQ17Noy2wyyYc7zLloQsZ1CdcGWQNm6i3Y+aP77C4mWPFeX5V4BcfKB650ktcQStTxcDE5z9YGMCFeT9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WtKKs5ltyz16PVw;
	Tue, 27 Aug 2024 15:43:45 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 7713E1401F1;
	Tue, 27 Aug 2024 15:44:32 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Aug
 2024 15:44:31 +0800
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
Subject: [PATCH -next 3/7] net: phy: Fix missing of_node_put() for leds
Date: Tue, 27 Aug 2024 15:52:15 +0800
Message-ID: <20240827075219.3793198-4-ruanjinjie@huawei.com>
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

The call of of_get_child_by_name() will cause refcount incremented for
leds, if it succeeds, it should call of_node_put() to decrease it. Fix
it by using __free(). Also use for_each_available_child_of_node_scoped()
to simplfy it.

Fixes: 01e5b728e9e4 ("net: phy: Add a binding for PHY LEDs")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/net/phy/phy_device.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 8f5314c1fecc..2fca33ff79e7 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3407,7 +3407,6 @@ static int of_phy_led(struct phy_device *phydev,
 static int of_phy_leds(struct phy_device *phydev)
 {
 	struct device_node *node = phydev->mdio.dev.of_node;
-	struct device_node *leds, *led;
 	int err;
 
 	if (!IS_ENABLED(CONFIG_OF_MDIO))
@@ -3416,14 +3415,13 @@ static int of_phy_leds(struct phy_device *phydev)
 	if (!node)
 		return 0;
 
-	leds = of_get_child_by_name(node, "leds");
+	struct device_node *leds __free(device_node) = of_get_child_by_name(node, "leds");
 	if (!leds)
 		return 0;
 
-	for_each_available_child_of_node(leds, led) {
+	for_each_available_child_of_node_scoped(leds, led) {
 		err = of_phy_led(phydev, led);
 		if (err) {
-			of_node_put(led);
 			phy_leds_unregister(phydev);
 			return err;
 		}
-- 
2.34.1


