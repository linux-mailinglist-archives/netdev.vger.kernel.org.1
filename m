Return-Path: <netdev+bounces-165802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE64BA3368F
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 05:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B351D188C3F4
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 04:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A909207A37;
	Thu, 13 Feb 2025 04:03:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FD31EA84;
	Thu, 13 Feb 2025 04:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739419407; cv=none; b=RGN8+dZYRY5n5BF4kbkvKcZxWooNO/cIYB+OJVvJhyhgTXE5zN4lyn+ffbFYnYNB0To4+Qkt+pxBT6yqh7QZ6mQX3MNo34SeFhuHOFveGy7cLgTuxbTO47MODNJ8YKaa4ORJeWKKqlAwlIvijGFniQOmTvsyVo2ig9FUPPOQbLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739419407; c=relaxed/simple;
	bh=CCO5WfOLk+foeNlfhvUrcae4/NXR3GRrP3Kp4TEs66g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rme2B3GV/DeNXvV8EdJBt954j6ecxsqOS66zCkV3pX8Ze56B6Yzqf4JnUg8PeAVFIxsTf1M0QN9cL4VjALQyod30a2Us6DziMsoet1Zj2qXZ8LFKoUQB+6NU3GDh3WWElPB4rBgSyBNhYRFUmblc0Yz9oia2ShfH62KVwDSx3rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YthHr6S7zz1W5dt;
	Thu, 13 Feb 2025 11:58:48 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id CBC4D1800B6;
	Thu, 13 Feb 2025 12:03:16 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 13 Feb 2025 12:03:15 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net-next 7/7] net: hibmcge: Add ioctl supported in this module
Date: Thu, 13 Feb 2025 11:55:29 +0800
Message-ID: <20250213035529.2402283-8-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250213035529.2402283-1-shaojijie@huawei.com>
References: <20250213035529.2402283-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk100013.china.huawei.com (7.202.194.61)

This patch implements the ioctl interface to
read and write the PHY register.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c  | 18 ++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c  | 10 ++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.h  |  2 ++
 3 files changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 78999d41f41d..afd04ed65eee 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -273,6 +273,23 @@ static netdev_features_t hbg_net_fix_features(struct net_device *netdev,
 	return features & HBG_SUPPORT_FEATURES;
 }
 
+static int hbg_net_eth_ioctl(struct net_device *dev, struct ifreq *ifr, s32 cmd)
+{
+	struct hbg_priv *priv = netdev_priv(dev);
+
+	if (test_bit(HBG_NIC_STATE_RESETTING, &priv->state))
+		return -EBUSY;
+
+	switch (cmd) {
+	case SIOCGMIIPHY:
+	case SIOCGMIIREG:
+	case SIOCSMIIREG:
+		return hbg_mdio_ioctl(priv, ifr, cmd);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static const struct net_device_ops hbg_netdev_ops = {
 	.ndo_open		= hbg_net_open,
 	.ndo_stop		= hbg_net_stop,
@@ -284,6 +301,7 @@ static const struct net_device_ops hbg_netdev_ops = {
 	.ndo_set_rx_mode	= hbg_net_set_rx_mode,
 	.ndo_get_stats64	= hbg_net_get_stats,
 	.ndo_fix_features	= hbg_net_fix_features,
+	.ndo_eth_ioctl		= hbg_net_eth_ioctl,
 };
 
 static void hbg_service_task(struct work_struct *work)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
index 8de6d57bd5f3..7080f3011f2d 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
@@ -246,3 +246,13 @@ int hbg_mdio_init(struct hbg_priv *priv)
 	hbg_mdio_init_hw(priv);
 	return hbg_phy_connect(priv);
 }
+
+int hbg_mdio_ioctl(struct hbg_priv *priv, struct ifreq *ifr, int cmd)
+{
+	struct hbg_mac *mac = &priv->mac;
+
+	if (!mac->phydev)
+		return -ENODEV;
+
+	return phy_mii_ioctl(mac->phydev, ifr, cmd);
+}
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.h
index febd02a309c7..3edca6cd0801 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.h
@@ -9,4 +9,6 @@
 int hbg_mdio_init(struct hbg_priv *priv);
 void hbg_phy_start(struct hbg_priv *priv);
 void hbg_phy_stop(struct hbg_priv *priv);
+int hbg_mdio_ioctl(struct hbg_priv *priv, struct ifreq *ifr, int cmd);
+
 #endif
-- 
2.33.0


