Return-Path: <netdev+bounces-164717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652D4A2ECEC
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 13:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4293E7A2236
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF9E22258C;
	Mon, 10 Feb 2025 12:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNQsyiTQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02485223323;
	Mon, 10 Feb 2025 12:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739191974; cv=none; b=iMpkYY3Jg4yZNBhVxH+8tzj1Dmtnfm6+NxrRzEEefF8WTtC6vYeax83UN56YHC5nfnLCMREEUwwduoCQEE08ZZcAPZ4KDA6M2E4vh6kmOC/NhCwdpp+ddV/EuIaU8dVu2A7LNc/2ZzchrW0B3NNbEp4WuePR7xXRkn5QYokPmTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739191974; c=relaxed/simple;
	bh=lnGFhwdKVASA4JZVSvAUxeffGE4LsRt1RUBlbxKoWMc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GnZo9IUmPebRoVWP3NERa78g4SDHqUSrBi0abFOqQB8QN4ej2w1FkWxdJcW8ZS8GSps2/c3kOEQghwpqFqxlsQnt/VB2V5h7urM853JsmHByN0jqwKJvhC1+cAgarB04txTjWp+Ul4r8d2WNx0aZoUDE6poW2FQuLudi0QFPNMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNQsyiTQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21f4500a5c3so81634485ad.3;
        Mon, 10 Feb 2025 04:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739191972; x=1739796772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3mTGFzTWHveCEIuDfSBcwTGP4FJ6Gf4w5lufq1wRrVY=;
        b=nNQsyiTQLpbWf+oARb5mVJg/3WNp1hHB8uSSYMDv24aBtRNPngO8KFzUGtgyJKYrbJ
         jAA+mPQn2YAn3fSBaLuVG0pdV8F3IhVDsxyBSASeQpwoka800s0HBwaqaPMEov9rguFT
         SYEtW9gnZY8YtLkdw8S8jNx3UY6LFiv6gONGOQb4qjoqjS/ll6ebDjW8nchC+N3OTbV4
         X1jmFj3zClntG/5KuB3vecmB7+cZAzDAK46pHI/UJobYZvgw16FZOgbNmfaPDrnqr9+H
         Y3Q7QeVXWKBbtRYAi6yIoPbuFI9lV/k4C3p1IwyHA9Ky0y1YiLbyxV2cjRw5DP+spb7K
         tLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739191972; x=1739796772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3mTGFzTWHveCEIuDfSBcwTGP4FJ6Gf4w5lufq1wRrVY=;
        b=vhghlgCQY29Ny0rCIGYuIW1KT+MCC+x2v+y4dRmzbmsSe+S63X//wlISwB5wnzQpoK
         5RihXz8IYWHorx+jyjyapnwzt/clpMEdQVkrmCS29EuY49uf+0Qir+JRWmGzDY7GD30w
         Ku7l/a3OtmSIHCNUYC/+Gdo2vx5rbFEA8Lo3wyTlPj6L1RntEWImcS1lFKoaZ/OsKcbs
         Rw+hlqtsD3bQzGVHpPcAmovdjeDjKnTh0wHny5DtBEvdkpi8YbtfH2vqR4U1l0XvtEJ/
         tbTuH+YYY8eH8rfhS+DoWSS0JRWby7Jb20OyKWGxGGi8ZZ+ThSsil27j0crMGYuiOkDV
         aoOw==
X-Forwarded-Encrypted: i=1; AJvYcCU+czPC9aKOAKAKO6iSBxK6Iu8M00lC0w+qY3PtF+vdiKj7coCznKLxiEGbC2Xez1GsAnXoDs3l@vger.kernel.org, AJvYcCUtYrfxM+mdW8SeblmIqOHbLwjfejvzUpqZA9AfVvWMXXZFriP1T+pOBOjXJUUaMfSDuY4XT7niREomwYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT9TxTk3yU7zg9M3Z99TOwv95ZSEdkToxXTO60QWHnLBQqIpxn
	SLdmapK9RxYmaIp8o+aJ0hGy7OKYKsrMKg8gBWt28zDjsOaF5kMd
X-Gm-Gg: ASbGnctSon5xHE1pCqp0h1+SrNXyx+kfUL4I+BwiJx1wnHUkVMR1E36lDfgmDpnhE2w
	PcfK9xz8PhkTqEREdUAEvWf3YY67p9kGWIhV0Dqrksub+e7UDK9xKOEcATLtaHCZNqPZ8ZgBd6D
	PKl6ZP3W7bsi+ktiQLaHr3bIGcupiHRh1H4l0qG6mq90HYr7vOJoL/d/owElkrS3T7LsgmkctUC
	HoE5FeqcAdeC59UYM4Vw54oB4GQlhDd5VF63PuHYbyu23mSU0dL/OrGzPtozdM5FK9HmWVZHL/f
	iHhlVX8b
X-Google-Smtp-Source: AGHT+IFY/eAAJFcD4vitGkVHUca2pVMuKjtQU6WUb3jtGtjhnnqqn/1iKAiFbhnjbTQxyI8lnuDV3w==
X-Received: by 2002:a05:6a21:8cc2:b0:1e1:a9dd:5a58 with SMTP id adf61e73a8af0-1ee03b129eemr26979741637.30.1739191972089;
        Mon, 10 Feb 2025 04:52:52 -0800 (PST)
Received: from gmail.com ([116.237.135.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-730851fa25bsm2641825b3a.180.2025.02.10.04.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 04:52:51 -0800 (PST)
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
Subject: [PATCH net-next v2] net: ethernet: mediatek: add EEE support
Date: Mon, 10 Feb 2025 20:52:45 +0800
Message-ID: <20250210125246.1950142-1-dqfext@gmail.com>
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
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 64 +++++++++++++++++++++
 drivers/net/ethernet/mediatek/mtk_eth_soc.h | 11 ++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 53485142938c..943636d822b5 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -786,6 +786,7 @@ static void mtk_mac_link_up(struct phylink_config *config,
 
 	mcr = mtk_r32(mac->hw, MTK_MAC_MCR(mac->id));
 	mcr &= ~(MAC_MCR_SPEED_100 | MAC_MCR_SPEED_1000 |
+		 MAC_MCR_EEE100M | MAC_MCR_EEE1G |
 		 MAC_MCR_FORCE_DPX | MAC_MCR_FORCE_TX_FC |
 		 MAC_MCR_FORCE_RX_FC);
 
@@ -811,6 +812,18 @@ static void mtk_mac_link_up(struct phylink_config *config,
 	if (rx_pause)
 		mcr |= MAC_MCR_FORCE_RX_FC;
 
+	if (mode == MLO_AN_PHY && phy && phy_init_eee(phy, false) >= 0) {
+		switch (speed) {
+		case SPEED_2500:
+		case SPEED_1000:
+			mcr |= MAC_MCR_EEE1G;
+			break;
+		case SPEED_100:
+			mcr |= MAC_MCR_EEE100M;
+			break;
+		}
+	}
+
 	mcr |= MAC_MCR_TX_EN | MAC_MCR_RX_EN | MAC_MCR_FORCE_LINK;
 	mtk_w32(mac->hw, mcr, MTK_MAC_MCR(mac->id));
 }
@@ -4474,6 +4487,55 @@ static int mtk_set_pauseparam(struct net_device *dev, struct ethtool_pauseparam
 	return phylink_ethtool_set_pauseparam(mac->phylink, pause);
 }
 
+static int mtk_get_eee(struct net_device *dev, struct ethtool_keee *eee)
+{
+	struct mtk_mac *mac = netdev_priv(dev);
+	u32 reg;
+	int ret;
+
+	ret = phylink_ethtool_get_eee(mac->phylink, eee);
+	if (ret)
+		return ret;
+
+	reg = mtk_r32(mac->hw, MTK_MAC_EEECR(mac->id));
+	eee->tx_lpi_enabled = !(reg & MAC_EEE_LPI_MODE);
+	eee->tx_lpi_timer = FIELD_GET(MAC_EEE_LPI_TXIDLE_THD, reg) * 1000;
+
+	return 0;
+}
+
+static int mtk_set_eee(struct net_device *dev, struct ethtool_keee *eee)
+{
+	struct mtk_mac *mac = netdev_priv(dev);
+	u32 txidle_thd_ms, reg;
+	int ret;
+
+	/* Tx idle timer in ms */
+	txidle_thd_ms = DIV_ROUND_UP(eee->tx_lpi_timer, 1000);
+	if (!FIELD_FIT(MAC_EEE_LPI_TXIDLE_THD, txidle_thd_ms))
+		return -EINVAL;
+
+	reg = FIELD_PREP(MAC_EEE_LPI_TXIDLE_THD, txidle_thd_ms);
+
+	/* PHY Wake-up time, this field does not have a reset value, so use the
+	 * reset value from MT7531 (36us for 100BaseT and 17us for 1000BaseT).
+	 */
+	reg |= FIELD_PREP(MAC_EEE_WAKEUP_TIME_1000, 17) |
+	       FIELD_PREP(MAC_EEE_WAKEUP_TIME_100, 36);
+
+	if (!eee->tx_lpi_enabled)
+		/* Force LPI Mode without a delay */
+		reg |= MAC_EEE_LPI_MODE;
+
+	ret = phylink_ethtool_set_eee(mac->phylink, eee);
+	if (ret)
+		return ret;
+
+	mtk_w32(mac->hw, reg, MTK_MAC_EEECR(mac->id));
+
+	return 0;
+}
+
 static u16 mtk_select_queue(struct net_device *dev, struct sk_buff *skb,
 			    struct net_device *sb_dev)
 {
@@ -4506,6 +4568,8 @@ static const struct ethtool_ops mtk_ethtool_ops = {
 	.set_pauseparam		= mtk_set_pauseparam,
 	.get_rxnfc		= mtk_get_rxnfc,
 	.set_rxnfc		= mtk_set_rxnfc,
+	.get_eee		= mtk_get_eee,
+	.set_eee		= mtk_set_eee,
 };
 
 static const struct net_device_ops mtk_netdev_ops = {
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


