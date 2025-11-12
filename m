Return-Path: <netdev+bounces-237770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B059C501B0
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 01:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B3E04EBF96
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 00:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29D3EACD;
	Wed, 12 Nov 2025 00:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qJ6ylYnh"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107DD4A23
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 00:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762905814; cv=none; b=A6uscEDUcnFnsStjKK6EfebQy0Vml7HK8ERNPMKSTFGOj2i8Z2ooGpvGCLq5QbgZ0weO9LdKAn+ff5185/BZKUwSsywYGPkR0PjgnBeCfVYaIzUorpXKPZoxhCK9cM5+fnxGMpi2Kgvx45ack4/Ubk8U1PRgkoDXlXEq4h32vTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762905814; c=relaxed/simple;
	bh=MFWi07Qz1u4GhaXEcJrXZ9xaqLdDeg7Rf7Pz/ZpfnlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baxFWMvdUpIGiLo4sK8KHraL0jaUv3zN7yyDN2qI+9oizOMbBqcutYdoH9SFc214gj+jvJ3yCgb2NaM+HfMprmgd5HyZaSyV865TKQih7+Rba6cFNINI1NrzQCdoOSMIbMs03DSihK3ZnXhx6y98Cb5OsSivwdDeLT87sgvBLIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qJ6ylYnh; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762905809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tT8bL4H498iID4RcA1C8KwwjIzdAuqyL7myKexgzgBk=;
	b=qJ6ylYnhpnX0CfhiosjGjoC0udj5GEZWIpfa+4zJt920zuXxeCwhaVV9SMbhsNXe1hdWNP
	n+2YEooXq+8w8IwqW/2pHTI5JN6xFcDwfFjIkn9IuHX8diuFJ0lwV5GAt3jH3zpkGiY3hF
	xeF4516CJ8RKJuIQwLMgFqKfXRqp9Xo=
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
Subject: [PATCH net-next 5/8] net: phy: microchip_rds_ptp: add HW timestamp configuration reporting
Date: Wed, 12 Nov 2025 00:02:54 +0000
Message-ID: <20251112000257.1079049-6-vadim.fedorenko@linux.dev>
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


