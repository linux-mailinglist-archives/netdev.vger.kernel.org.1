Return-Path: <netdev+bounces-237772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08124C501BF
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 01:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766DE3B30E5
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 00:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C0B44C63;
	Wed, 12 Nov 2025 00:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qz9e3D5c"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341731B808
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 00:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762905816; cv=none; b=g/Dqh6FVbE5V/JnLHtX5IRt0lX4ZM3GpszHMuXt8ymkk5i7OeyvcaScFy2ZxuG2XMP9o05lD5xeWGMDHFk589BnvCfzoXg/yFSR7okH8zvg40mrY0I+poCiptSADwTKSmX0ZY8HIUuLftzfEOwR3PsrZXMNaUPZ5T8clpfcit3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762905816; c=relaxed/simple;
	bh=ibEa6wtihI+flh0rgIB7PgGBHeBIeb4uYf+VOz0BPpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NU8kV2iUEePDHkiOa1sSQ6ntRuxxab4Hx0DL5TXMt+DFssSwUKRP1bZY1NbuQDgZB/CLJashnG7wJXpuo/otYzVj3g2R5p/SaAYZP/EWJjb0+KaZ70l/jSB9CUOOpFDYUSulvlEUjkvX1NWnaELBjhu1Es7CMu/h0xSz7rPAKho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qz9e3D5c; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762905813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GTLsczkV5AJGqikXOVqqQkBv1J84gYETaEtrBiQLCk0=;
	b=Qz9e3D5cgGt6TX1uShNa2+Lx1P9WtXJzxsN8Ro3JMO8CK5XhG17YmOZn5jElknr5rmrhAX
	VEyR1Gcim45lTVSdG0uDuROMq+tXK5EqTvbQP8SbBtSxJ/YdB/k1tHUEieBBmXPcbnG+VC
	jO7/OMhuOfnQ2Lyn4hwDhvgIMYpKAK8=
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
Subject: [PATCH net-next 7/8] net: phy: nxp-c45-tja11xx: add HW timestamp configuration reporting
Date: Wed, 12 Nov 2025 00:02:56 +0000
Message-ID: <20251112000257.1079049-8-vadim.fedorenko@linux.dev>
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
 drivers/net/phy/nxp-c45-tja11xx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 13a8fac223a9..f526528d2e32 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -1012,6 +1012,19 @@ static bool nxp_c45_rxtstamp(struct mii_timestamper *mii_ts,
 	return true;
 }
 
+static int nxp_c45_hwtstamp_get(struct mii_timestamper *mii_ts,
+				struct kernel_hwtstamp_config *cfg)
+{
+	struct nxp_c45_phy *priv = container_of(mii_ts, struct nxp_c45_phy,
+						mii_ts);
+
+	cfg->tx_type = priv->hwts_tx;
+	cfg->rx_filter = priv->hwts_rx ? HWTSTAMP_FILTER_PTP_V2_L2_EVENT
+				       : HWTSTAMP_FILTER_NONE;
+
+	return 0;
+}
+
 static int nxp_c45_hwtstamp_set(struct mii_timestamper *mii_ts,
 				struct kernel_hwtstamp_config *cfg,
 				struct netlink_ext_ack *extack)
@@ -1750,6 +1763,7 @@ static int nxp_c45_probe(struct phy_device *phydev)
 		priv->mii_ts.rxtstamp = nxp_c45_rxtstamp;
 		priv->mii_ts.txtstamp = nxp_c45_txtstamp;
 		priv->mii_ts.hwtstamp_set = nxp_c45_hwtstamp_set;
+		priv->mii_ts.hwtstamp_get = nxp_c45_hwtstamp_get;
 		priv->mii_ts.ts_info = nxp_c45_ts_info;
 		phydev->mii_ts = &priv->mii_ts;
 		ret = nxp_c45_init_ptp_clock(priv);
-- 
2.47.3


