Return-Path: <netdev+bounces-123576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E729C965584
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 05:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4048285BC4
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 03:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E3913A243;
	Fri, 30 Aug 2024 03:06:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526F9137764
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 03:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724987167; cv=none; b=IzcyfAACDaCu5QVF17qbgQV9C7azETSLF6ghu3wF6kQVTbe6BoLTSeHYO0M5+U2W+xtOBUXKCF2tjx0lrZxkZ1G2sPp4m/xZDKQDzX7xK4sHQuTC7JZyCzoQUK1lspoThaY2ewogLVpy9DbfE4OKUYLbwPW93p/qNSK4kM5nG3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724987167; c=relaxed/simple;
	bh=n78vuofp2s4tJftkXQbkxBEeD7/tE4CjgAxg/Q3G2YU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wv1Z1ZYaevtau2iqevwvUbI27B0cJyHeSfTqwiBk0rR7/F1uLKUWuPcHxFV5ATcdER5B6/jiFxH62XhLNAV7EKJS9WClYMhIiktn27+VK4gKyGIYhwlEv2v2W2OBnyhbBgSGRcOMFGwOHT7SV4ssESFvRQywA9BMQyN8fucGaBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ww2zF2RbPzLqyD;
	Fri, 30 Aug 2024 11:03:37 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 0827E1401F3;
	Fri, 30 Aug 2024 11:05:42 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 11:05:40 +0800
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
Subject: [PATCH net-next v4 3/8] net: phy: Use for_each_available_child_of_node_scoped()
Date: Fri, 30 Aug 2024 11:13:20 +0800
Message-ID: <20240830031325.2406672-4-ruanjinjie@huawei.com>
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
for_each_available_child_of_node_scoped(), which can simplfy code.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v4:
- Rebased on the previous fix patch has been stripped out.
- Add Reviewed-by.
v3:
- Add Reviewed-by
v2
- Split into 2 patches.
---
 drivers/net/phy/phy_device.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 8f5314c1fecc..7c4a09455493 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3407,7 +3407,7 @@ static int of_phy_led(struct phy_device *phydev,
 static int of_phy_leds(struct phy_device *phydev)
 {
 	struct device_node *node = phydev->mdio.dev.of_node;
-	struct device_node *leds, *led;
+	struct device_node *leds;
 	int err;
 
 	if (!IS_ENABLED(CONFIG_OF_MDIO))
@@ -3420,10 +3420,9 @@ static int of_phy_leds(struct phy_device *phydev)
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


