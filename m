Return-Path: <netdev+bounces-123117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C22C963B56
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 08:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5E41C23DAD
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 06:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2666E174EEB;
	Thu, 29 Aug 2024 06:23:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD36616CD1C
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 06:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912614; cv=none; b=MmO2rtFy2mnu5ZRClGekrqQ1QVaTYX6nSosGkl4Appky37WhAYLQdUoQZuqGGMv24uHjdl7WAhSfYCBHXCsFxUV7aByL/zBLDNuiBlcCX+AdyEdsjSUQrLP93z/gEHJNI36q7ES8P7/L8pKUIDrOUBmqUQ7GQZUkXzZWvTgtOuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912614; c=relaxed/simple;
	bh=bWmJpqsDs5NUlsb7fgi5+hDXO+UkXRI0RbNo4eqa0co=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K3uNa391Bsn/znrTAqA688HcT+zJdoM3ZDF5X6RlyQqopt80ISNxZ9i9TUpNYSvYWpm8CMkfRYEjtQOJ4SmgRSxoq/wd/AVQqpAZ9+A41tVWhYHHePclotomHHvDhes4gXvgS0oSFYPlx41K+haglKR6Hu7wVNsCON0KNG5hTQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WvWPq2spszfbCX;
	Thu, 29 Aug 2024 14:21:19 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id A76AA180AE6;
	Thu, 29 Aug 2024 14:23:23 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 29 Aug
 2024 14:23:22 +0800
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
Subject: [PATCH net-next v3 06/13] net: phy: Use for_each_available_child_of_node_scoped()
Date: Thu, 29 Aug 2024 14:31:11 +0800
Message-ID: <20240829063118.67453-7-ruanjinjie@huawei.com>
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
for_each_available_child_of_node_scoped(), which can simplfy code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v3:
- Add Reviewed-by
v2
- Split into 2 patches.
---
 drivers/net/phy/phy_device.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 243dae686992..560e338b307a 100644
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
 			of_node_put(leds);
 			phy_leds_unregister(phydev);
 			return err;
-- 
2.34.1


