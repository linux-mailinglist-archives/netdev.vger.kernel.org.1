Return-Path: <netdev+bounces-123112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E2D963B4F
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 08:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45F51F238DC
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 06:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31F215F40B;
	Thu, 29 Aug 2024 06:23:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECB6154C15
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 06:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912607; cv=none; b=X+DIJ04BJXA+TRyX8+qtDhTiISwzYT0UwrrEdfF/PAk1PamkK/VbAImsjaWargSOtK70tUG85Tno6Deq1XuRMeK09FTL1fufH8a+LqX0WfYe/j2tOPo8qA/hciVY0X8TIL6g2MipUEf+bodzDC0iPZCKHExV47naHFzHj4NZhZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912607; c=relaxed/simple;
	bh=wdWAELdeM5a1XrCFiTafXFuM/CMg2YWzelCISEZEQak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=plXK9MjMKGyN4CieG5/PI+LwiCsbW762dT2IiTxeqPYjD0P8HUyZfeWx+oeLOvliHTbZfNt8bF9tVYRGaSdLBcQdu7sO1J9FWSqWOm28zW4ppFrNKhQSzSR7iTvoRHJR5EET7CJ8EshfrHzBz6k81WratnNJzqbazzPaBqkqW2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WvWRx5nchz1S9MX;
	Thu, 29 Aug 2024 14:23:09 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id BAF64140153;
	Thu, 29 Aug 2024 14:23:22 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 29 Aug
 2024 14:23:21 +0800
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
Subject: [PATCH net-next v3 05/13] net: phy: Fix missing of_node_put() for leds
Date: Thu, 29 Aug 2024 14:31:10 +0800
Message-ID: <20240829063118.67453-6-ruanjinjie@huawei.com>
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

The call of of_get_child_by_name() will cause refcount incremented
for leds, if it succeeds, it should call of_node_put() to decrease
it, fix it.

Fixes: 01e5b728e9e4 ("net: phy: Add a binding for PHY LEDs")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v3:
- Add Reviewed-by.
v2:
- Split into 2 patches.
- Use of_node_put() rather than __free() to fix it.
---
 drivers/net/phy/phy_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 8f5314c1fecc..243dae686992 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3424,11 +3424,13 @@ static int of_phy_leds(struct phy_device *phydev)
 		err = of_phy_led(phydev, led);
 		if (err) {
 			of_node_put(led);
+			of_node_put(leds);
 			phy_leds_unregister(phydev);
 			return err;
 		}
 	}
 
+	of_node_put(leds);
 	return 0;
 }
 
-- 
2.34.1


