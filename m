Return-Path: <netdev+bounces-116312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C034949E83
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 05:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B02A11F25F21
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 03:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C789B191F8E;
	Wed,  7 Aug 2024 03:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="YFsk22Y9"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0803215B999;
	Wed,  7 Aug 2024 03:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723002210; cv=none; b=UhxVv/jhPZE8lSEFMsxpXOQ/y8Rmz/blz0Pa6ROgtIe0oNMjis4pJEdA7QdUfvzUR2Ojly/2iROWbW5ULbh3IKWTZutR78nqKunxk3j2rN+v4PiOQM8T1rBQJLw2x//9pk/SuP50ZNdoQSIzwOjfqDNt06WHjeIXTO+osTgH65k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723002210; c=relaxed/simple;
	bh=fWT+zEHJyC1BeaMIQ2OJZ3mpPddoACy4KY+LkITn940=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oTztHFFmnY/ilKRsCzxLdKFrVTuHu/bNV8f1EPK6/c7JZWB97JmkPGJD7gUDJGJrA5BR88Hvtv/0e+W2aoSi+NsnnUHnbv4+jlzyIAwa5IgONav2x7gV6PLFopyIlZzrtKSVQMhluV3/0thnoutLBzU7bnqxIeqFTWuFqctoyKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=YFsk22Y9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4773h7kV51923831, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723002187; bh=fWT+zEHJyC1BeaMIQ2OJZ3mpPddoACy4KY+LkITn940=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=YFsk22Y9a3I6qox4jnnBe+Gd+TndZHbTuR6C3zySsrnhGlV0bQOcPP5QzutY6OWF/
	 X/94BnSPHqviX+NmswvNIusMhkZnzleJr7f10BWvRmaACDrp6SHsTDEcG4F+74uPpY
	 fvtiJ7bQ0Qn79XDQT1F/nhUtXMKk5jB/K83zg1/Cz8UGQUFkctg0yddGcDU8FD8OBt
	 6P15KqzZELkSmaTf8ZMZs+apeaOyNetXDrGgAVBoRDy07LiqQLwmbfdb1Aq2ZdAwel
	 gqxY2qZA/FVraTcd5ffsCLTpXiAaPPrm+3p6KlSCLEptMqa5E3PwsoHqFQ/DsM1wr9
	 JTAy9lxT+SHGQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4773h7kV51923831
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Aug 2024 11:43:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 Aug 2024 11:43:07 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 7 Aug
 2024 11:43:07 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <jdamato@fastly.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v26 10/13] rtase: Implement ethtool function
Date: Wed, 7 Aug 2024 11:37:20 +0800
Message-ID: <20240807033723.485207-11-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807033723.485207-1-justinlai0215@realtek.com>
References: <20240807033723.485207-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Implement the ethtool function to support users to obtain network card
information, including obtaining various device settings, Report whether
physical link is up, Report pause parameters, Set pause parameters,
Return extended statistics about the device.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 57c04eb7693f..bdf6098d5e1c 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1714,9 +1714,101 @@ static void rtase_get_mac_address(struct net_device *dev)
 	rtase_rar_set(tp, dev->dev_addr);
 }
 
+static void rtase_get_drvinfo(struct net_device *dev,
+			      struct ethtool_drvinfo *info)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+
+	strscpy(info->driver, KBUILD_MODNAME, sizeof(info->driver));
+	strscpy(info->bus_info, pci_name(tp->pdev), sizeof(info->bus_info));
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
+	} else if (value & RTASE_FORCE_TXFLOW_EN) {
+		pause->tx_pause = 1;
+	} else if (value & RTASE_FORCE_RXFLOW_EN) {
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


