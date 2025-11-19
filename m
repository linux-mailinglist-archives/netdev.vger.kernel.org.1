Return-Path: <netdev+bounces-239976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A6DC6E9C9
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 13:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 0185E2E6A4
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 12:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0BF357A5D;
	Wed, 19 Nov 2025 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UvQe5GRV"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0B332A3C1
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 12:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763556521; cv=none; b=DOeYwLGubrNH7UYo7cD4+KB58+qlh4puLZx4Tp/WqwsNIqvZ1ta07BvkInDSaIsRfVbewUl8ocaq/EXjyEcP447GYtISlS5xILZhJM97OKFakZAilx9giOyrw+i6w3aDxVx32XQ9BkRwjyLFl79mkJnVYq92lbHiZUrNN07eJpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763556521; c=relaxed/simple;
	bh=MFWi07Qz1u4GhaXEcJrXZ9xaqLdDeg7Rf7Pz/ZpfnlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMP1QrBuc3I7J0r9lggiIAp0wzSByCRObRG6gBBnLXMqHjNielyc8mNIxcLIvJuTVzDbIvlq+9LYiHCmL/3cY0bIooSGcM0NW7wUrZWCzh1kYdj89EE4hF7+RcabBuD27/rs+RLAjMX6Q7rLGiTSlLb7fxtr4KClUYVu4AD8PSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UvQe5GRV; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763556516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tT8bL4H498iID4RcA1C8KwwjIzdAuqyL7myKexgzgBk=;
	b=UvQe5GRVhutu1DWIeybMj4YmaczONAYSSEXoBaDmER0tmNrlFiH7Kx20dkEhs3kwtxdUmC
	nEfg04zu8S9P6ZCsnq+ON1WOGFGMk8QGayxh/MbukBWcB3rDuAzzoIxrkHDMVggMpdQGky
	Ab6tBwAPOQRA2IeBL3VkLmNNWamCjjw=
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
Subject: [PATCH net-next v3 6/9] net: phy: microchip_rds_ptp: add HW timestamp configuration reporting
Date: Wed, 19 Nov 2025 12:47:22 +0000
Message-ID: <20251119124725.3935509-7-vadim.fedorenko@linux.dev>
In-Reply-To: <20251119124725.3935509-1-vadim.fedorenko@linux.dev>
References: <20251119124725.3935509-1-vadim.fedorenko@linux.dev>
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
 drivers/net/phy/microchip_rds_ptp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/phy/microchip_rds_ptp.c b/drivers/net/phy/microchip_rds_ptp.c
index 4c6326b0ceaf..d2beb3a2e6c3 100644
--- a/drivers/net/phy/microchip_rds_ptp.c
+++ b/drivers/net/phy/microchip_rds_ptp.c
@@ -476,6 +476,18 @@ static bool mchp_rds_ptp_rxtstamp(struct mii_timestamper *mii_ts,
 	return true;
 }
 
+static int mchp_rds_ptp_hwtstamp_get(struct mii_timestamper *mii_ts,
+				     struct kernel_hwtstamp_config *config)
+{
+	struct mchp_rds_ptp_clock *clock =
+				container_of(mii_ts, struct mchp_rds_ptp_clock,
+					     mii_ts);
+	config->tx_type = clock->hwts_tx_type;
+	config->rx_filter = clock->rx_filter;
+
+	return 0;
+}
+
 static int mchp_rds_ptp_hwtstamp_set(struct mii_timestamper *mii_ts,
 				     struct kernel_hwtstamp_config *config,
 				     struct netlink_ext_ack *extack)
@@ -1282,6 +1294,7 @@ struct mchp_rds_ptp_clock *mchp_rds_ptp_probe(struct phy_device *phydev, u8 mmd,
 	clock->mii_ts.rxtstamp = mchp_rds_ptp_rxtstamp;
 	clock->mii_ts.txtstamp = mchp_rds_ptp_txtstamp;
 	clock->mii_ts.hwtstamp_set = mchp_rds_ptp_hwtstamp_set;
+	clock->mii_ts.hwtstamp_get = mchp_rds_ptp_hwtstamp_get;
 	clock->mii_ts.ts_info = mchp_rds_ptp_ts_info;
 
 	phydev->mii_ts = &clock->mii_ts;
-- 
2.47.3


