Return-Path: <netdev+bounces-234195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F0FC1DAB6
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 00:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A7B44E4891
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 23:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5800C30100C;
	Wed, 29 Oct 2025 23:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wT8b7EQu"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129882FB962
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 23:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761779818; cv=none; b=KiBwLe7Tg7vPCurZSYP3hEBBq1qyCvAJXw+KPCZraTPNTRRyAdqPih8F+a1OoD+lBM9P1oePnlW8RvUtrGu52oQFpU+Joqmbam8wNlyRGqkQSKoXngwGRYgwe/ad/Ovkfrh+0CttNz6zJCybtDWjUysA5xy489OS1AHRriC5x/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761779818; c=relaxed/simple;
	bh=Ycgs+WJf0rX/3P2j0uxtgEizFAHSZxQl8X4dVHDOte8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anY10yfahM5Gr0KR08Mjyyvv3ZFZE+a8LxHHj8n/lgBQe66eBpQaxHau8+EjahN9sNYmLlDjSSqA6tVdr9n/vj7OKTJ1en3Ae+Lma9WqTeOTHRP3nePfJwcZ8vPIy8a6Kr5xiFkvE0an1mNhqZJWtTTjOmCWuDJNdTHcI23p1Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wT8b7EQu; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761779814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2rQ/6gGDRhyD58zZl7qcXPr50QtQkldHySxwTL0+jeE=;
	b=wT8b7EQuXoJbSgyjuUkiyP66g+TZmX4HIX4RN5zw2swDXxFFT7Ba68x7VZ5BLnQR336qnb
	ZA+259ZSrXyc5v7NqIcztl+aADJ2s/ZLnv3mXDPKv/d/ImSCPevkjEu8RMuyf3AXfjpgjo
	ZfqXDjx0MUeXr0SA/vGVWBP+m2hi76A=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	=?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>,
	socketcan@esd.eu,
	Manivannan Sadhasivam <mani@kernel.org>,
	Thomas Kopp <thomas.kopp@microchip.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Jimmy Assarsson <extja@kvaser.com>,
	Axel Forsman <axfo@kvaser.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 3/3] can: peak_usb: convert to use ndo_hwtstamp callbacks
Date: Wed, 29 Oct 2025 23:16:20 +0000
Message-ID: <20251029231620.1135640-4-vadim.fedorenko@linux.dev>
In-Reply-To: <20251029231620.1135640-1-vadim.fedorenko@linux.dev>
References: <20251029231620.1135640-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Convert driver to use ndo_hwtstamp_set()/ndo_hwtstamp_get() callbacks.
ndo_eth_ioctl handler does nothing after conversion - remove it.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 39 +++++++++-----------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 94b1d7f15d27..cf48bb26d46d 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -784,36 +784,33 @@ static int peak_usb_set_data_bittiming(struct net_device *netdev)
 	return 0;
 }
 
-static int peak_eth_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
+static int peak_hwtstamp_get(struct net_device *netdev,
+			     struct kernel_hwtstamp_config *config)
 {
-	struct hwtstamp_config hwts_cfg = { 0 };
-
-	switch (cmd) {
-	case SIOCSHWTSTAMP: /* set */
-		if (copy_from_user(&hwts_cfg, ifr->ifr_data, sizeof(hwts_cfg)))
-			return -EFAULT;
-		if (hwts_cfg.tx_type == HWTSTAMP_TX_OFF &&
-		    hwts_cfg.rx_filter == HWTSTAMP_FILTER_ALL)
-			return 0;
-		return -ERANGE;
-
-	case SIOCGHWTSTAMP: /* get */
-		hwts_cfg.tx_type = HWTSTAMP_TX_OFF;
-		hwts_cfg.rx_filter = HWTSTAMP_FILTER_ALL;
-		if (copy_to_user(ifr->ifr_data, &hwts_cfg, sizeof(hwts_cfg)))
-			return -EFAULT;
+	config->tx_type = HWTSTAMP_TX_OFF;
+	config->rx_filter = HWTSTAMP_FILTER_ALL;
+
+	return 0;
+}
+
+static int peak_hwtstamp_set(struct net_device *netdev,
+			     struct kernel_hwtstamp_config *config,
+			     struct netlink_ext_ack *extack)
+{
+	if (config->tx_type == HWTSTAMP_TX_OFF &&
+	    config->rx_filter == HWTSTAMP_FILTER_ALL)
 		return 0;
 
-	default:
-		return -EOPNOTSUPP;
-	}
+	NL_SET_ERR_MSG_MOD(extack, "Only RX HWTSTAMP_FILTER_ALL is supported");
+	return -ERANGE;
 }
 
 static const struct net_device_ops peak_usb_netdev_ops = {
 	.ndo_open = peak_usb_ndo_open,
 	.ndo_stop = peak_usb_ndo_stop,
-	.ndo_eth_ioctl = peak_eth_ioctl,
 	.ndo_start_xmit = peak_usb_ndo_start_xmit,
+	.ndo_hwtstamp_get = peak_hwtstamp_get,
+	.ndo_hwtstamp_set = peak_hwtstamp_set,
 };
 
 /* CAN-USB devices generally handle 32-bit CAN channel IDs.
-- 
2.47.3


