Return-Path: <netdev+bounces-237769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4CCC501B9
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 01:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18CC33B2A3C
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 00:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC951494D9;
	Wed, 12 Nov 2025 00:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t7KuF4YP"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C0F72610
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 00:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762905804; cv=none; b=uXvs6V1KodHbDfbwgm/mxw0WgF2q8vn/UwbNHkq0fwDcp5xrlFwwyd0oQ2B8VWyjZ8Z7xyI0hvjw8C7b9WP4T6ba5Jw+YmPEBO+ykvNjHBwvRUVUGc8u9+4/cLC0wWiFLIFCNpZjfTzJilK1whhsh9U+BNiknaZtv7juLAdTpZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762905804; c=relaxed/simple;
	bh=ccvrjKWkv/aTrhjrA/Vat/MuKzUokCtdoK+NfdejOCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEbzjyTqw7gA6jW+lIvgJdM/fmzQkWIbBa3J9NYRLdfTLHZyoTcVgqc1u53vsB4n3QHObslzxH+dYH08RAHacbm8jvKFzBWgCRXDKoM0/Nh33Zfpq9iHILpxyVXkgkXJWyTVo/g1MufDY/9NJrxa/DHFjwJ1dmfKRZ2ieBp7txg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t7KuF4YP; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762905801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SuhHsBhiyya7Y1HZfpbHqUZ4yLsOLkD5BydKZ1LnOng=;
	b=t7KuF4YPqbChrCou9lkukpcCg4oAOr3dpz70oJmtyMP8j9YbZHexgtQ4dA9O7/Xv1gjJM6
	ZtAW0imLQWaHEgokBAXOXbD4soiDfwzjV9w4CVrfz8hFDrNxITb5ICNxEXaPLz3Yk8RSce
	fINnr5XWZFIg4jWLTh7tAivftNm2z1I=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH net-next 4/8] net: phy: micrel: add HW timestamp configuration reporting
Date: Wed, 12 Nov 2025 00:02:53 +0000
Message-ID: <20251112000257.1079049-5-vadim.fedorenko@linux.dev>
In-Reply-To: <20251112000257.1079049-1-vadim.fedorenko@linux.dev>
References: <20251112000257.1079049-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The driver stores HW timestamping configuration and can technically
report it. Add callback to do it.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/phy/micrel.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index d626106b6e1b..cada0339f9ac 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -3145,6 +3145,18 @@ static void lan8814_flush_fifo(struct phy_device *phydev, bool egress)
 	lanphy_read_page_reg(phydev, LAN8814_PAGE_PORT_REGS, PTP_TSU_INT_STS);
 }
 
+static int lan8814_hwtstamp_get(struct mii_timestamper *mii_ts,
+				struct kernel_hwtstamp_config *config)
+{
+	struct kszphy_ptp_priv *ptp_priv =
+			  container_of(mii_ts, struct kszphy_ptp_priv, mii_ts);
+
+	config->tx_type = ptp_priv->hwts_tx_type;
+	config->rx_filter = ptp_priv->rx_filter;
+
+	return 0;
+}
+
 static int lan8814_hwtstamp_set(struct mii_timestamper *mii_ts,
 				struct kernel_hwtstamp_config *config,
 				struct netlink_ext_ack *extack)
@@ -4388,6 +4400,7 @@ static void lan8814_ptp_init(struct phy_device *phydev)
 	ptp_priv->mii_ts.rxtstamp = lan8814_rxtstamp;
 	ptp_priv->mii_ts.txtstamp = lan8814_txtstamp;
 	ptp_priv->mii_ts.hwtstamp_set = lan8814_hwtstamp_set;
+	ptp_priv->mii_ts.hwtstamp_get = lan8814_hwtstamp_get;
 	ptp_priv->mii_ts.ts_info  = lan8814_ts_info;
 
 	phydev->mii_ts = &ptp_priv->mii_ts;
@@ -5028,6 +5041,19 @@ static void lan8841_ptp_enable_processing(struct kszphy_ptp_priv *ptp_priv,
 #define LAN8841_PTP_TX_TIMESTAMP_EN		443
 #define LAN8841_PTP_TX_MOD			445
 
+static int lan8841_hwtstamp_get(struct mii_timestamper *mii_ts,
+				struct kernel_hwtstamp_config *config)
+{
+	struct kszphy_ptp_priv *ptp_priv;
+
+	ptp_priv = container_of(mii_ts, struct kszphy_ptp_priv, mii_ts);
+
+	config->tx_type = ptp_priv->hwts_tx_type;
+	config->rx_filter = ptp_priv->rx_filter;
+
+	return 0;
+}
+
 static int lan8841_hwtstamp_set(struct mii_timestamper *mii_ts,
 				struct kernel_hwtstamp_config *config,
 				struct netlink_ext_ack *extack)
@@ -5911,6 +5937,7 @@ static int lan8841_probe(struct phy_device *phydev)
 	ptp_priv->mii_ts.rxtstamp = lan8841_rxtstamp;
 	ptp_priv->mii_ts.txtstamp = lan8814_txtstamp;
 	ptp_priv->mii_ts.hwtstamp_set = lan8841_hwtstamp_set;
+	ptp_priv->mii_ts.hwtstamp_get = lan8841_hwtstamp_get;
 	ptp_priv->mii_ts.ts_info = lan8841_ts_info;
 
 	phydev->mii_ts = &ptp_priv->mii_ts;
-- 
2.47.3


