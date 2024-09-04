Return-Path: <netdev+bounces-124797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ADD96AF40
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 05:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D7D1B24465
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 03:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB83642A92;
	Wed,  4 Sep 2024 03:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="C9xol3kV"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0950545026;
	Wed,  4 Sep 2024 03:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725420323; cv=none; b=PZovWUvGJyw4k0Ud9XCcJlVF/uy7lqsxLf4Suhg6YD/uTG2kDEOhoMa9zXi+alu0v7Dc1dfQV5negJ73aPVUibXjbNTWTfspTjZPtatzPmGHKrIerqVgzDR5/AHel2aUPu2XawDfs0SzzXpqq0ZboxRf/r9mkC4rWZ5GJ5F0LUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725420323; c=relaxed/simple;
	bh=MuPuHsFQG9JLjGP15YRzsxLCk+z8S2UeLEaYflHLdFo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S37BhtGP/sXmwJQuxo64Zn5XoBsfwdZY+HVxtjCE2Igs2EY9xsVa7bSs/rNeDN7ZxfD7DxakxVKZh37cyNdouj7zxsJ8SP6EralMM0/VB3IySK9mQA7An+cZEisG1Sp7z/o4cSDt7WLxOLsTosc1RDahfNw3LWoQOm3+Nxt98w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=C9xol3kV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4843OrAqA2041656, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1725420293; bh=MuPuHsFQG9JLjGP15YRzsxLCk+z8S2UeLEaYflHLdFo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=C9xol3kVIKQeQyiz7a3DTdra0jLwkSKMco9SYMwljngg6ybQCKFSm91lrov2vnt48
	 Z/P4HY8mtEeNZOi5VBtIdMYMoae4exSX/HdfL13IoLv+l0Uo5TT54jzbZFYlUBAWMb
	 annADHrG53Gxt+DmvF1nPSxy2lqUoH4urDf5QSBndXXcnsUSNl5V+/gp1KAPsrIi+7
	 A9NY1lK9lYxZzp4rd+/ynppokV9+eWqRRJNGZ7sVXLy/n4R01xjEtfW4YrT/u4W7wS
	 nOm+xMFBM9P5qhCEzt+c2VvHX0Bf4RibA1lme0v/Eoava4TF8YWnucu25LxkGL9yTE
	 04U5eFWOXGugw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4843OrAqA2041656
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Sep 2024 11:24:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 11:24:54 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 4 Sep
 2024 11:24:53 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <jdamato@fastly.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v30 10/13] rtase: Implement ethtool function
Date: Wed, 4 Sep 2024 11:21:11 +0800
Message-ID: <20240904032114.247117-11-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904032114.247117-1-justinlai0215@realtek.com>
References: <20240904032114.247117-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Implement the ethtool function to support users to obtain network card
information, including obtaining various device settings, Report whether
physical link is up, Report pause parameters, Set pause parameters,
Return extended statistics about the device.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 7a31bef0576a..7882f2c0e1a4 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1710,9 +1710,83 @@ static void rtase_get_mac_address(struct net_device *dev)
 	rtase_rar_set(tp, dev->dev_addr);
 }
 
+static int rtase_get_settings(struct net_device *dev,
+			      struct ethtool_link_ksettings *cmd)
+{
+	u32 supported = SUPPORTED_MII | SUPPORTED_Pause | SUPPORTED_Asym_Pause;
+
+	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
+						supported);
+	cmd->base.speed = SPEED_5000;
+	cmd->base.duplex = DUPLEX_FULL;
+	cmd->base.port = PORT_MII;
+	cmd->base.autoneg = AUTONEG_DISABLE;
+
+	return 0;
+}
+
+static void rtase_get_pauseparam(struct net_device *dev,
+				 struct ethtool_pauseparam *pause)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	u16 value = rtase_r16(tp, RTASE_CPLUS_CMD);
+
+	pause->autoneg = AUTONEG_DISABLE;
+	pause->tx_pause = !!(value & RTASE_FORCE_TXFLOW_EN);
+	pause->rx_pause = !!(value & RTASE_FORCE_RXFLOW_EN);
+}
+
+static int rtase_set_pauseparam(struct net_device *dev,
+				struct ethtool_pauseparam *pause)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	u16 value = rtase_r16(tp, RTASE_CPLUS_CMD);
+
+	if (pause->autoneg)
+		return -EOPNOTSUPP;
+
+	value &= ~(RTASE_FORCE_TXFLOW_EN | RTASE_FORCE_RXFLOW_EN);
+
+	if (pause->tx_pause)
+		value |= RTASE_FORCE_TXFLOW_EN;
+
+	if (pause->rx_pause)
+		value |= RTASE_FORCE_RXFLOW_EN;
+
+	rtase_w16(tp, RTASE_CPLUS_CMD, value);
+	return 0;
+}
+
+static void rtase_get_eth_mac_stats(struct net_device *dev,
+				    struct ethtool_eth_mac_stats *stats)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	const struct rtase_counters *counters;
+
+	counters = tp->tally_vaddr;
+
+	rtase_dump_tally_counter(tp);
+
+	stats->FramesTransmittedOK = le64_to_cpu(counters->tx_packets);
+	stats->FramesReceivedOK = le64_to_cpu(counters->rx_packets);
+	stats->FramesLostDueToIntMACXmitError =
+		le64_to_cpu(counters->tx_errors);
+	stats->BroadcastFramesReceivedOK = le64_to_cpu(counters->rx_broadcast);
+}
+
+static const struct ethtool_ops rtase_ethtool_ops = {
+	.get_link = ethtool_op_get_link,
+	.get_link_ksettings = rtase_get_settings,
+	.get_pauseparam = rtase_get_pauseparam,
+	.set_pauseparam = rtase_set_pauseparam,
+	.get_eth_mac_stats = rtase_get_eth_mac_stats,
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
 static void rtase_init_netdev_ops(struct net_device *dev)
 {
 	dev->netdev_ops = &rtase_netdev_ops;
+	dev->ethtool_ops = &rtase_ethtool_ops;
 }
 
 static void rtase_reset_interrupt(struct pci_dev *pdev,
-- 
2.34.1


