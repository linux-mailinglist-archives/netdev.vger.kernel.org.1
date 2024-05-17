Return-Path: <netdev+bounces-96898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2AD8C81F4
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 10:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27A781C2103E
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 08:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818F31803A;
	Fri, 17 May 2024 07:58:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BCC1AAA5;
	Fri, 17 May 2024 07:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932725; cv=none; b=JFvHX0blfkVeeGLnOJi0MJ3eWe6CL8iQkxXJlcw/cLzn3az6fwkRSEznhI+dcjIEg8GFqbmdhH1+DwFWEcyVizHLa7KLorDoo5s5olnx7SsDpYQahSYZjS3ueaY5+64O9VQN3GkyA6z2F7ZRf/PUYSDhiTJoy46qDUrpUoH7O0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932725; c=relaxed/simple;
	bh=Wc5GI7U8V/JnhoWOotT6w1Du4fMLUAF5FLkiNexfbU8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g7zLLZNHYN7lxzlrhAHdh3rZDqH3HfvtPJJ6sBBm9nZy75MZiKcFcj7AODK3+QKExQUpEj4U2Qyq3ifRdl+HDdY5+3jj6Elfdp7yYMHEJGvbn8nyncB9yfEIPRE/VaV8azWUsbxQkgIGl6MtLxgHC9cDYZvDoEW7MKUGko2Glq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44H7wLmL52161420, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44H7wLmL52161420
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 15:58:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 17 May 2024 15:58:21 +0800
Received: from RTDOMAIN (172.21.210.160) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 17 May
 2024 15:58:20 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <pkshih@realtek.com>, <larry.chiu@realtek.com>,
        Justin Lai
	<justinlai0215@realtek.com>
Subject: [PATCH net-next v19 10/13] rtase: Implement ethtool function
Date: Fri, 17 May 2024 15:52:59 +0800
Message-ID: <20240517075302.7653-11-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240517075302.7653-1-justinlai0215@realtek.com>
References: <20240517075302.7653-1-justinlai0215@realtek.com>
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
Return a set of strings that describe the requested objects, Get number
of strings that @get_strings will write, Return extended statistics
about the device.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index b94041b1d4fd..52281bb64dd9 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1757,9 +1757,112 @@ static void rtase_get_mac_address(struct net_device *dev)
 	rtase_rar_set(tp, dev->dev_addr);
 }
 
+static void rtase_get_drvinfo(struct net_device *dev,
+			      struct ethtool_drvinfo *drvinfo)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+
+	strscpy(drvinfo->driver, KBUILD_MODNAME, 32);
+	strscpy(drvinfo->bus_info, pci_name(tp->pdev), 32);
+}
+
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
+
+	if ((value & (RTASE_FORCE_TXFLOW_EN | RTASE_FORCE_RXFLOW_EN)) ==
+	    (RTASE_FORCE_TXFLOW_EN | RTASE_FORCE_RXFLOW_EN)) {
+		pause->rx_pause = 1;
+		pause->tx_pause = 1;
+	} else if ((value & RTASE_FORCE_TXFLOW_EN)) {
+		pause->tx_pause = 1;
+	} else if ((value & RTASE_FORCE_RXFLOW_EN)) {
+		pause->rx_pause = 1;
+	}
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
+	if (!counters)
+		return;
+
+	rtase_dump_tally_counter(tp);
+
+	stats->FramesTransmittedOK = le64_to_cpu(counters->tx_packets);
+	stats->SingleCollisionFrames = le32_to_cpu(counters->tx_one_collision);
+	stats->MultipleCollisionFrames =
+		le32_to_cpu(counters->tx_multi_collision);
+	stats->FramesReceivedOK = le64_to_cpu(counters->rx_packets);
+	stats->FrameCheckSequenceErrors = le32_to_cpu(counters->rx_errors);
+	stats->AlignmentErrors = le16_to_cpu(counters->align_errors);
+	stats->FramesAbortedDueToXSColls = le16_to_cpu(counters->tx_aborted);
+	stats->FramesLostDueToIntMACXmitError =
+		le64_to_cpu(counters->tx_errors);
+	stats->FramesLostDueToIntMACRcvError =
+		le16_to_cpu(counters->rx_missed);
+	stats->MulticastFramesReceivedOK = le32_to_cpu(counters->rx_multicast);
+	stats->BroadcastFramesReceivedOK = le64_to_cpu(counters->rx_broadcast);
+}
+
+static const struct ethtool_ops rtase_ethtool_ops = {
+	.get_drvinfo = rtase_get_drvinfo,
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


