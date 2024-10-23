Return-Path: <netdev+bounces-138258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967A09ACB90
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7E3D1C213CC
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B51D1BFE0D;
	Wed, 23 Oct 2024 13:49:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26741AAE00;
	Wed, 23 Oct 2024 13:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729691347; cv=none; b=scGdGk3DeHSnc3JVKfPJIkhz5L5tz0azVpmJqek9D1XjSX5cgeiAkBOKYuVQzROzTwZXdKRwdI5xaT4H472EZa7eulcYnjLNIurXTbg570RdPZEs9VT9yNgskZ4eVn/HbjTsLibRYVlanoKhTbGowyLFsqsWjAQwA0S6rGNc704=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729691347; c=relaxed/simple;
	bh=y+bCgOERS3BGmvKGma+ONtbzdoK4GPUzAA4kw8ibc8s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iGnDpQWUBVmC/YNR9sR0l+u3moDwKqSSPhCgzYXnr13yQ+N7TZ41EAF2azWUQlTcOQSldtzxLZPFEAE/x5RWA9q/GORZyYA5cKFci1FDPreiNy8z6Prf9uyTMyhzM0hfwcsDSkUuIV43IYXHx+WpRLZFMEi2m9PS7dxSh83X3OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XYVh80mSTzdkKR;
	Wed, 23 Oct 2024 21:46:32 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B5BC180087;
	Wed, 23 Oct 2024 21:49:02 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 21:49:01 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net-next 5/7] net: hibmcge: Add pauseparam supported in this module
Date: Wed, 23 Oct 2024 21:42:11 +0800
Message-ID: <20241023134213.3359092-6-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241023134213.3359092-1-shaojijie@huawei.com>
References: <20241023134213.3359092-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)

The MAC can automatically send or respond to pause frames.
This patch supports the function of enabling pause frames
by using ethtool.

Not support pause auto-negotiation.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.c  | 24 +++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   | 21 ++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |  3 +++
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |  1 +
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  2 ++
 5 files changed, 51 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
index a630c7d8ef5c..1e93d1dcf7a0 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
@@ -341,6 +341,28 @@ static void hbg_ethtool_get_regs(struct net_device *netdev,
 	}
 }
 
+static void hbg_ethtool_get_pauseparam(struct net_device *net_dev,
+				       struct ethtool_pauseparam *param)
+{
+	struct hbg_priv *priv = netdev_priv(net_dev);
+
+	hbg_hw_get_pause_enable(priv, &param->tx_pause, &param->rx_pause);
+}
+
+static int hbg_ethtool_set_pauseparam(struct net_device *net_dev,
+				      struct ethtool_pauseparam *param)
+{
+	struct hbg_priv *priv = netdev_priv(net_dev);
+
+	if (param->autoneg) {
+		netdev_err(net_dev, "autoneg unsupported\n");
+		return -EOPNOTSUPP;
+	}
+
+	hbg_hw_set_pause_enable(priv, !!param->tx_pause, !!param->rx_pause);
+	return 0;
+}
+
 static const struct ethtool_ops hbg_ethtool_ops = {
 	.get_link		= ethtool_op_get_link,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
@@ -350,6 +372,8 @@ static const struct ethtool_ops hbg_ethtool_ops = {
 	.get_ethtool_stats	= hbg_ethtool_get_stats,
 	.get_regs_len		= hbg_ethtool_get_regs_len,
 	.get_regs		= hbg_ethtool_get_regs,
+	.get_pauseparam         = hbg_ethtool_get_pauseparam,
+	.set_pauseparam         = hbg_ethtool_set_pauseparam,
 };
 
 void hbg_ethtool_set_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
index 29d66a0ea0a6..0cbe9f7229b3 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -220,6 +220,27 @@ void hbg_hw_set_mac_filter_enable(struct hbg_priv *priv, u32 enable)
 			    HBG_REG_REC_FILT_CTRL_UC_MATCH_EN_B, enable);
 }
 
+void hbg_hw_set_pause_enable(struct hbg_priv *priv, u32 tx_en, u32 rx_en)
+{
+	hbg_reg_write_field(priv, HBG_REG_PAUSE_ENABLE_ADDR,
+			    HBG_REG_PAUSE_ENABLE_TX_B, tx_en);
+	hbg_reg_write_field(priv, HBG_REG_PAUSE_ENABLE_ADDR,
+			    HBG_REG_PAUSE_ENABLE_RX_B, rx_en);
+}
+
+void hbg_hw_get_pause_enable(struct hbg_priv *priv, u32 *tx_en, u32 *rx_en)
+{
+	*tx_en = hbg_reg_read_field(priv, HBG_REG_PAUSE_ENABLE_ADDR,
+				    HBG_REG_PAUSE_ENABLE_TX_B);
+	*rx_en = hbg_reg_read_field(priv, HBG_REG_PAUSE_ENABLE_ADDR,
+				    HBG_REG_PAUSE_ENABLE_RX_B);
+}
+
+void hbg_hw_set_rx_pause_mac_addr(struct hbg_priv *priv, u64 mac_addr)
+{
+	hbg_reg_write64(priv, HBG_REG_FD_FC_ADDR_LOW_ADDR, mac_addr);
+}
+
 static void hbg_hw_init_transmit_ctrl(struct hbg_priv *priv)
 {
 	u32 ctrl = 0;
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
index 6eb4b7d2cba8..a4a049b5121d 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
@@ -56,5 +56,8 @@ u32 hbg_hw_get_fifo_used_num(struct hbg_priv *priv, enum hbg_dir dir);
 void hbg_hw_set_tx_desc(struct hbg_priv *priv, struct hbg_tx_desc *tx_desc);
 void hbg_hw_fill_buffer(struct hbg_priv *priv, u32 buffer_dma_addr);
 void hbg_hw_set_mac_filter_enable(struct hbg_priv *priv, u32 enable);
+void hbg_hw_set_pause_enable(struct hbg_priv *priv, u32 tx_en, u32 rx_en);
+void hbg_hw_get_pause_enable(struct hbg_priv *priv, u32 *tx_en, u32 *rx_en);
+void hbg_hw_set_rx_pause_mac_addr(struct hbg_priv *priv, u64 mac_addr);
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 0b7cfbd166ec..6331cda91575 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -196,6 +196,7 @@ static int hbg_net_set_mac_address(struct net_device *netdev, void *addr)
 	if (is_exists)
 		hbg_set_mac_to_mac_table(priv, index, NULL);
 
+	hbg_hw_set_rx_pause_mac_addr(priv, ether_addr_to_u64(mac_addr));
 	dev_addr_set(netdev, mac_addr);
 	return 0;
 }
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index bbfefe9c1e61..6088f1aef23e 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -51,6 +51,8 @@
 #define HBG_REG_PORT_ENABLE_RX_B		BIT(1)
 #define HBG_REG_PORT_ENABLE_TX_B		BIT(2)
 #define HBG_REG_PAUSE_ENABLE_ADDR		(HBG_REG_SGMII_BASE + 0x0048)
+#define HBG_REG_PAUSE_ENABLE_RX_B		BIT(0)
+#define HBG_REG_PAUSE_ENABLE_TX_B		BIT(1)
 #define HBG_REG_AN_NEG_STATE_ADDR		(HBG_REG_SGMII_BASE + 0x0058)
 #define HBG_REG_TRANSMIT_CTRL_ADDR		(HBG_REG_SGMII_BASE + 0x0060)
 #define HBG_REG_TRANSMIT_CTRL_PAD_EN_B		BIT(7)
-- 
2.33.0


