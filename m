Return-Path: <netdev+bounces-166866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE04A37A16
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 04:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BA1816BBB4
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 03:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605AC137C35;
	Mon, 17 Feb 2025 03:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXn+4njk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69EB14A8B;
	Mon, 17 Feb 2025 03:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739763603; cv=none; b=WWm9rzrhqR7RbqhFNIb8SYPVv/mrJbchNMeb7WDt2nPF5PCq2Tr1hDbAMHIuEur4mc+mCQCs+4iR2jP4Q86Oc5KbKYf6M6iEdVc1bysb9hSO3sw8FHig7UkiWbZGJ/vcff/61Hb/Rq/DHitgR/wrQCjJYMsIcDAsr0EE4l4rRnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739763603; c=relaxed/simple;
	bh=RK/P+pWG4JXB19s/DWzQXlS4u/zUdRoJ/2f25zmF/J4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZL8EBboGG5Xg8fmC+4zF+jeODnqfrbkzWPQ/Ei2lX1b8U4cCgSlfsxED6GByDcWKUXL4Zj8k2qLhxRNKF240luj8USiOla/NuiubZKqxUwBTSok0h4gzrnkHS14aJ60CDkUdHSHAvq4d0zRhGeOP4WIo9KU0I1thzeNz+7IX6SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXn+4njk; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f83a8afcbbso5955251a91.1;
        Sun, 16 Feb 2025 19:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739763601; x=1740368401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nl62NtlkEq5ALtFLjtQ5AGx38czK9K3XMJPBTb4YpgM=;
        b=mXn+4njkhkSI0CL6IcajJQJCWtUyFIgO8dkn7MpTJyMcCrv6Fl/d3XL2rTZQvTv4tG
         2kfv0v4amCP7JqD7d3WhD+bOgHZbZigx0RQvZFlV8YbfudYNepa46jOg/qJ+de8UlPP6
         kOEv/QaeeqEDzOt9No9PfhnHoTqBVj0qvsdy0qlOLM+6afN5k51JhmLHLJ0D2Q6ZHUhw
         71X7/Ylxw7m2Z3iym8Ibt4IqcAeOGsyb1ydyl3VJvVWMaIKfwPcs/QTJF5+i+pZMPTY+
         /qeHFNs8fb505y/0TMz8Uhpw1/Ra2ncbfjl0wydNtqyh8LLNca+vqHEBSCO+OUSDc+Ra
         Gszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739763601; x=1740368401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nl62NtlkEq5ALtFLjtQ5AGx38czK9K3XMJPBTb4YpgM=;
        b=u/4xkKC7Cl0af2fBbGWLttx1YqoXvpzazwsov+FkAvx5PxdCnw4HM6BUPsKMeqiEnq
         CC3H4bl10TR6XhMiFmxDpB9QMBmvsM6fi1yrRF2gI8lem3GvHFOcYEXegNE0f3f6YdjU
         tN57B2IwaEfZm0sFWp42NLPqpxTFQWMLIRAYRb8l1uETdn8ZKSH2xRufxL7TZwgKWDQv
         E0LiG/fLVxVwnk65hp6CfNB7ztcgq1+kx4waZFdGbl5OPa3pJ1HaJ6JazhckK+TymIyY
         U8CBMxVpwYIc+5MxaKArnJs7DFYt/ydHOoXiZOsppFH4A7JrHXT5/25Z//q9alsDHt9T
         8Xog==
X-Forwarded-Encrypted: i=1; AJvYcCU9pW217OKtGhSzi8aLohQffMIY5MosTnUavWlyr9G8FAi7o8ZQ+60sQzsl+8xA1kZiIQND3JPa@vger.kernel.org, AJvYcCVnbIpjz+RK+4qCNZhhuW1gtb9e+4f2ewtmZ19RbgdYXTCZyEKxBumULnrl/tOFKD5UWAkw04IwhF9QA4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuc4tg1MpTXopNNetztFKGQTTfIs16OR/zj8Iox2r0dgAiNnjr
	6ZK6m/pfGNAaX7yo6yzKth/G+ew5VWXGcpB0QXZxxivPPIZBB1RO
X-Gm-Gg: ASbGncuN7yda73FF3c11lPZNkb/cO2dudMorzqXWfuUcl8UHnA7lPSSRDHKeebOYoVw
	KKYVnLIOzS8SEgo6zYk5zi134HhIh9BOsboGX/k/SRywiZ6IFeRQVTIWTNJi4jbRu/Z0++0Tdnh
	grVDcEldOVHwqmF9FVPj409Bz/F3+rYLGg3sbwJmBqf5agtTO82ooI9C87i0orbkVsUkJP1VZz4
	ZV+XD+HGZDm2+bXPkTiWfGLhb9LetKYMsVteia2s3IbXCh2W5J7g0YLDRL80FPH/nHSwnMExU3k
	ej7DGpLg
X-Google-Smtp-Source: AGHT+IFMjtFP6+eFxDZoPED1z+G8rAnlAtkY/tMQA24zNyKne9VxhqPhvrZG/sxzoSOa5figDdM6qw==
X-Received: by 2002:a17:90b:4b48:b0:2fa:2133:bc87 with SMTP id 98e67ed59e1d1-2fc0f955234mr25277232a91.6.1739763600850;
        Sun, 16 Feb 2025 19:40:00 -0800 (PST)
Received: from gmail.com ([116.237.135.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc327a9d68sm5895139a91.1.2025.02.16.19.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 19:40:00 -0800 (PST)
From: Qingfang Deng <dqfext@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v3] net: ethernet: mediatek: add EEE support
Date: Mon, 17 Feb 2025 11:39:53 +0800
Message-ID: <20250217033954.3698772-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add EEE support to MediaTek SoC Ethernet. The register fields are
similar to the ones in MT7531, except that the LPI threshold is in
milliseconds.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
v3: use phylink managed EEE

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 65 +++++++++++++++++++++
 drivers/net/ethernet/mediatek/mtk_eth_soc.h | 11 ++++
 2 files changed, 76 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 0ad965ced5ef..985010a7b277 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -815,12 +815,58 @@ static void mtk_mac_link_up(struct phylink_config *config,
 	mtk_w32(mac->hw, mcr, MTK_MAC_MCR(mac->id));
 }
 
+static void mtk_mac_disable_tx_lpi(struct phylink_config *config)
+{
+	struct mtk_mac *mac = container_of(config, struct mtk_mac,
+					   phylink_config);
+	struct mtk_eth *eth = mac->hw;
+
+	mtk_m32(eth, MAC_MCR_EEE100M | MAC_MCR_EEE1G, 0, MTK_MAC_MCR(mac->id));
+}
+
+static int mtk_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
+				 bool tx_clk_stop)
+{
+	struct mtk_mac *mac = container_of(config, struct mtk_mac,
+					   phylink_config);
+	struct mtk_eth *eth = mac->hw;
+	u32 val;
+
+	/* Tx idle timer in ms */
+	timer = DIV_ROUND_UP(timer, 1000);
+
+	/* If the timer is zero, then set LPI_MODE, which allows the
+	 * system to enter LPI mode immediately rather than waiting for
+	 * the LPI threshold.
+	 */
+	if (!timer)
+		val = MAC_EEE_LPI_MODE;
+	else if (FIELD_FIT(MAC_EEE_LPI_TXIDLE_THD, timer))
+		val = FIELD_PREP(MAC_EEE_LPI_TXIDLE_THD, timer);
+	else
+		val = MAC_EEE_LPI_TXIDLE_THD;
+
+	if (tx_clk_stop)
+		val |= MAC_EEE_CKG_TXIDLE;
+
+	/* PHY Wake-up time, this field does not have a reset value, so use the
+	 * reset value from MT7531 (36us for 100M and 17us for 1000M).
+	 */
+	val |= FIELD_PREP(MAC_EEE_WAKEUP_TIME_1000, 17) |
+	       FIELD_PREP(MAC_EEE_WAKEUP_TIME_100, 36);
+
+	mtk_w32(eth, val, MTK_MAC_EEECR(mac->id));
+	mtk_m32(eth, 0, MAC_MCR_EEE100M | MAC_MCR_EEE1G, MTK_MAC_MCR(mac->id));
+}
+
 static const struct phylink_mac_ops mtk_phylink_ops = {
 	.mac_select_pcs = mtk_mac_select_pcs,
 	.mac_config = mtk_mac_config,
 	.mac_finish = mtk_mac_finish,
 	.mac_link_down = mtk_mac_link_down,
 	.mac_link_up = mtk_mac_link_up,
+	.mac_disable_tx_lpi = mtk_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi = mtk_mac_enable_tx_lpi,
 };
 
 static int mtk_mdio_init(struct mtk_eth *eth)
@@ -4469,6 +4515,20 @@ static int mtk_set_pauseparam(struct net_device *dev, struct ethtool_pauseparam
 	return phylink_ethtool_set_pauseparam(mac->phylink, pause);
 }
 
+static int mtk_get_eee(struct net_device *dev, struct ethtool_keee *eee)
+{
+	struct mtk_mac *mac = netdev_priv(dev);
+
+	return phylink_ethtool_get_eee(mac->phylink, eee);
+}
+
+static int mtk_set_eee(struct net_device *dev, struct ethtool_keee *eee)
+{
+	struct mtk_mac *mac = netdev_priv(dev);
+
+	return phylink_ethtool_set_eee(mac->phylink, eee);
+}
+
 static u16 mtk_select_queue(struct net_device *dev, struct sk_buff *skb,
 			    struct net_device *sb_dev)
 {
@@ -4501,6 +4561,8 @@ static const struct ethtool_ops mtk_ethtool_ops = {
 	.set_pauseparam		= mtk_set_pauseparam,
 	.get_rxnfc		= mtk_get_rxnfc,
 	.set_rxnfc		= mtk_set_rxnfc,
+	.get_eee		= mtk_get_eee,
+	.set_eee		= mtk_set_eee,
 };
 
 static const struct net_device_ops mtk_netdev_ops = {
@@ -4610,6 +4672,9 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 	mac->phylink_config.type = PHYLINK_NETDEV;
 	mac->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
 		MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD;
+	mac->phylink_config.lpi_capabilities = MAC_100FD | MAC_1000FD |
+		MAC_2500FD;
+	mac->phylink_config.lpi_timer_default = 1000;
 
 	/* MT7623 gmac0 is now missing its speed-specific PLL configuration
 	 * in its .mac_config method (since state->speed is not valid there.
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 0d5225f1d3ee..90a377ab4359 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -453,6 +453,8 @@
 #define MAC_MCR_RX_FIFO_CLR_DIS	BIT(12)
 #define MAC_MCR_BACKOFF_EN	BIT(9)
 #define MAC_MCR_BACKPR_EN	BIT(8)
+#define MAC_MCR_EEE1G		BIT(7)
+#define MAC_MCR_EEE100M		BIT(6)
 #define MAC_MCR_FORCE_RX_FC	BIT(5)
 #define MAC_MCR_FORCE_TX_FC	BIT(4)
 #define MAC_MCR_SPEED_1000	BIT(3)
@@ -461,6 +463,15 @@
 #define MAC_MCR_FORCE_LINK	BIT(0)
 #define MAC_MCR_FORCE_LINK_DOWN	(MAC_MCR_FORCE_MODE)
 
+/* Mac EEE control registers */
+#define MTK_MAC_EEECR(x)		(0x10104 + (x * 0x100))
+#define MAC_EEE_WAKEUP_TIME_1000	GENMASK(31, 24)
+#define MAC_EEE_WAKEUP_TIME_100		GENMASK(23, 16)
+#define MAC_EEE_LPI_TXIDLE_THD		GENMASK(15, 8)
+#define MAC_EEE_CKG_TXIDLE		BIT(3)
+#define MAC_EEE_CKG_RXLPI		BIT(2)
+#define MAC_EEE_LPI_MODE		BIT(0)
+
 /* Mac status registers */
 #define MTK_MAC_MSR(x)		(0x10108 + (x * 0x100))
 #define MAC_MSR_EEE1G		BIT(7)
-- 
2.43.0


