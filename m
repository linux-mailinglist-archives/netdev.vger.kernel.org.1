Return-Path: <netdev+bounces-244745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B579CBDF19
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 14:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4985A3065AF0
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 13:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79512C11CB;
	Mon, 15 Dec 2025 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="PS5w+HxT"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF87428314C;
	Mon, 15 Dec 2025 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765803599; cv=none; b=DJnoK7A67h8JeQqqy2uAXTVYqjWo3AKKG7SmsRo2tJwGnTsZjHFdbi6Nft7X/wu1mAQX/pfo2ivGbmjGucNTjmXa4miC23VTzWCYn/8vudf4xQ/mWoV/mZPr9YT2irAKnt1QyieW+UFiBr/jhAd5d6hJ+CF4iOZYU4rTO17yTRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765803599; c=relaxed/simple;
	bh=R4Xzecd54OJmMh4TJGjXIZ9a7lE0KHo3ViFXr9BIvQA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTmIdoaCo7n3MINVTsP+AdjqZWqPYzr16bGpZVRAI4xF/W5W3IomD04iICHJAxskkrPHR8ImAX3SX9dl242rGNXu+IQkefY+VVVHLYS5C6nZ9PIraG88eFPSpDgzkFK2gI59GiVoF839qgF3kaKcYSRdWwvh6va4NYv2tTxe1hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=PS5w+HxT; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Rb4tGSAlhwE5xmc71ZEpWi9znYIU9Ma+BEfBMd337Cs=;
	b=PS5w+HxTQsauvl5a224Ru8IOW9HqZSEFIy9QAMa3p+4rvaa+CxqMy3+eyYT4rWCZ+cOp95U4M
	fTGz6IJXg3l7u4iB618MEW8RVkQbdz1YjSlDCqbN6/k25Cri4X54lqbZIBMpRSDNpeM8x+PhNhd
	/hp5vNHroWizuo+hjri9oEI=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dVKpk4k9qz12LDf;
	Mon, 15 Dec 2025 20:57:34 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 6FEEC180B6A;
	Mon, 15 Dec 2025 20:59:49 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Dec 2025 20:59:48 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<Frank.Sae@motor-comm.com>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<salil.mehta@huawei.com>, <shiyongbang@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH RFC net-next 2/6] net: phy: add support to set default rules
Date: Mon, 15 Dec 2025 20:57:01 +0800
Message-ID: <20251215125705.1567527-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20251215125705.1567527-1-shaojijie@huawei.com>
References: <20251215125705.1567527-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100013.china.huawei.com (7.202.194.61)

The node of led need add new property: rules,
and rules can be set as:
BIT(TRIGGER_NETDEV_LINK) | BIT(TRIGGER_NETDEV_RX)

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/phy/phy_device.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index c5ce057f88ff..65bd0bf11e78 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3208,6 +3208,26 @@ static void phy_leds_unregister(struct phy_device *phydev)
 	}
 }
 
+static int fwnode_phy_led_set_rules(struct phy_device *phydev,
+				    struct fwnode_handle *led, u32 index)
+{
+	u32 rules;
+	int err;
+
+	if (!fwnode_property_present(led, "rules"))
+		return 0;
+
+	err = fwnode_property_read_u32(led, "rules", &rules);
+	if (err)
+		return err;
+
+	err = phydev->drv->led_hw_is_supported(phydev, index, rules);
+	if (err)
+		return err;
+
+	return phydev->drv->led_hw_control_set(phydev, index, rules);
+}
+
 static int fwnode_phy_led(struct phy_device *phydev,
 			  struct fwnode_handle *led)
 {
@@ -3253,6 +3273,11 @@ static int fwnode_phy_led(struct phy_device *phydev,
 			return err;
 	}
 
+	err = fwnode_phy_led_set_rules(phydev, led, index);
+	if (err)
+		phydev_warn(phydev, "failed to set rules for led%u, err = %d\n",
+			    index, err);
+
 	phyled->index = index;
 	if (phydev->drv->led_brightness_set)
 		cdev->brightness_set_blocking = phy_led_set_brightness;
-- 
2.33.0


