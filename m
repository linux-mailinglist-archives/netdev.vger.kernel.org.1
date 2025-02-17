Return-Path: <netdev+bounces-166928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E97BA37EDA
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 10:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B52F169F44
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 09:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0005215F41;
	Mon, 17 Feb 2025 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUcCqQR1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB36215F4E;
	Mon, 17 Feb 2025 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739785230; cv=none; b=bhgO3TuKoiLWgPzHhpUyh7GIsNLD8hCESJkfqQtPFCbLZ/Oojn7O8xHxAgemdanIVi4eWudnq9w/QwED1Pu2LSlgIg2usP5eEtIjZbtlUBVFg+dS4CFtWljOfy93Ov8q3O8g09OQIdKAoKwgMRALqnrLhSLnyceq+iFtkPtzRvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739785230; c=relaxed/simple;
	bh=kYgXWMJwq6XOl64XcIksXL3q8esusZOw1JjspQSIEDQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Gspu2JQk9os3wglante4DcGlnaDNT7WcwYNHVMm74MQ9VA2hyxs35w9KxCynpDGy3vZrG+ZQsJ/wbdl2gjuQC05nVVltq/05Pj84+CpIue0olSsc/YlmCCilDx1J5GffjM4WrHxWagzOwahhNJlXLsw2pq+3GXIYlZDzM5hik2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUcCqQR1; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220dc3831e3so58011965ad.0;
        Mon, 17 Feb 2025 01:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739785228; x=1740390028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pJdSXpXW9LlkBOPkFR0Utx/8PFGdBu9YmyGsnlOk7f4=;
        b=LUcCqQR1NCiDI78IVYRALxwYeAE+WOFPfh0qOXSSedxZ3DD1VdmCumcBrOpWFPncPI
         yDe1TGvXOjXtKMAwj9HEslmnmT+XsX9ulgS6QPeG18yLXr633/sbGiSTTg6gP9YAnBlj
         QC3AfiwfkHzqv/XvailH81/vGK5hF6epspVhzdRcpQV4YJyMxxfAYdP+Yn1TxznL4/37
         UUAG8MLPTxRlHh2PwPnR3htMD+Lw8Sds0CVgw6+YIbuhFlKQSog32pXiGtjohF+Pi4J1
         lutRKl0NG+2hhVGEahancEQoQXLnJFt/SdjeSm09O6sx/Qgv5ZKWufmxVcDqFDQ9OlMB
         SVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739785228; x=1740390028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pJdSXpXW9LlkBOPkFR0Utx/8PFGdBu9YmyGsnlOk7f4=;
        b=KhDpU8ZkU/FqPD4QUcLQmKf1MNzxcm87ftKetR1ZZhyttxJFhuGVR37hNtKsVgAZZa
         Im+IuXxO7YbLRgDOKkX9kg6JoaqPxNL2c14PgJn8nBxUXaWg9L8dKZ06tXI14c4gCx0a
         8tKzew1sArf5ijs4Muw1HBeTxQB7x2xhVTWv8MQRo7jwHcDNQsGrvMX2FgAfvH4OZngj
         jycfTcfRtqagku/GGSIW4VvVor63OhxhyGnmDsSNfBd7lcbhErsUySjc3G6++CSQ0126
         YdRvmkQzjlOV0KJIX2EfEakxZGKXa06VaB6rdLPjChIpvi3wlZB2vXrOlVn3qVKzWi1u
         bsHg==
X-Forwarded-Encrypted: i=1; AJvYcCVEFOzJMnKNo0caJ2P3YdUqDHcVA2136yqluVVhjXSIKegpErEMFvXycuu7Aq3afJk0fdUBbcjV6G3/LSI=@vger.kernel.org, AJvYcCXJg6eX+tIFJdD9ryheEwMiKY45CCBGUksrL0p3UkXuDOPmKz7t3UucXvlHbEx2HcV9g6iaRY63@vger.kernel.org
X-Gm-Message-State: AOJu0YwQDIvQNnqTBcxfyA45Z9yyzuKZhrB/BNUsnFTZjr+H6VtWLiBY
	4rovP/t+cRqtR0imbt5In1Ks7R2hjcx0zFVoO5J+W8Vg3etIHgcS
X-Gm-Gg: ASbGnctmbBBzUa7VusMwjb8flnWpr4sQj0NffeOhEKfTab9BhkvX/gl+bKixkUkfJTv
	qZNu2O8m3ea40NoiLqVlWi/k1Iuy2JnMiArmJu5eKPhkmuncjL3e2CCpmcM31WclIa0NDE890Up
	wCuJGeulgc2lhLN1HAs16mEQyD0lIK314TnC3REx3bXAU1o/pmWfVNu7oZAW/Nn+l0bqIkFRoRg
	PrmsQZkbEFjqKt2o5j/FUH/P4NdxtHoOghjIV22VLxyx1JDllc5s9XPsFL9Q+4r1u4k9DSfSktn
	7zQur7Uz
X-Google-Smtp-Source: AGHT+IElh54SBERly9RJ4+nFUA5iu6PJvcF2dB2EW9JHMiqhpE+vcHK/m2s43XEf/EAUzaCYFZraHQ==
X-Received: by 2002:a05:6a00:4643:b0:725:f1e9:5334 with SMTP id d2e1a72fcca58-7323c751ab9mr34939772b3a.8.1739785228464;
        Mon, 17 Feb 2025 01:40:28 -0800 (PST)
Received: from gmail.com ([116.237.135.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732425467adsm7947446b3a.15.2025.02.17.01.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 01:40:28 -0800 (PST)
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
Subject: [PATCH net-next v4] net: ethernet: mediatek: add EEE support
Date: Mon, 17 Feb 2025 17:40:21 +0800
Message-ID: <20250217094022.1065436-1-dqfext@gmail.com>
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
v4: fix build warning

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 67 +++++++++++++++++++++
 drivers/net/ethernet/mediatek/mtk_eth_soc.h | 11 ++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 0ad965ced5ef..922330b3f4d7 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -815,12 +815,60 @@ static void mtk_mac_link_up(struct phylink_config *config,
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
+
+	return 0;
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
@@ -4469,6 +4517,20 @@ static int mtk_set_pauseparam(struct net_device *dev, struct ethtool_pauseparam
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
@@ -4501,6 +4563,8 @@ static const struct ethtool_ops mtk_ethtool_ops = {
 	.set_pauseparam		= mtk_set_pauseparam,
 	.get_rxnfc		= mtk_get_rxnfc,
 	.set_rxnfc		= mtk_set_rxnfc,
+	.get_eee		= mtk_get_eee,
+	.set_eee		= mtk_set_eee,
 };
 
 static const struct net_device_ops mtk_netdev_ops = {
@@ -4610,6 +4674,9 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
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


