Return-Path: <netdev+bounces-247391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C60CF9478
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 17:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A21953080087
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 16:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B962023DEB6;
	Tue,  6 Jan 2026 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TfjkWm88"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3FE23BD1F
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767715723; cv=none; b=dUcFpukx0lDKJKqii4VMZm74Yntp1zALy6grdsucykfCI+jM8T0cB3cPS8ckv22NfegaZtF1iJ+FE3YAFDJ+PwORKP38/f78vpDfOG14zh/YWcDp6zNi9KzuaGXTh5dskGg41/ulEZO2hlm20TUkr3m6X+yJZcOhp03kDe0PCqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767715723; c=relaxed/simple;
	bh=YxBre04v/idpTBzhEzguGTkOLCLdO8gcNJ/Fw78z/wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WD1c+ipr2gmZaMb+5g+QOrEh/mcgkDJtUozajrjtEUN636oqPNG4cZS28tUs7bHbRblaHBQOQQSM/Rby8JmSeLsMeJ0dLAFbF7dm238fF8KdW8Z8y5KGq9/7h7aU0g2VLRwoldFpP1baN8f0oSAlTUsytsmTKPAESJvRXT5htFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TfjkWm88; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767715719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ijOKNek0O/qs2Nl6wS1xdmOW2TJ2YZ7Jq+xVgId/1Vs=;
	b=TfjkWm88B2+dudX5uvQ1WoUe6gAlEAb+BhMdYBaJdNIA7/YGOktZ9+qQLQtYa2gyUzU6CB
	zc9rzcN7SS7qLCu6OepCoik6EgjZ5+EKYIS827HRB2jjP4Cysw9At8Ci3GNGRZ0An9ECAg
	0zHrEPfjtQDwHFrweuuYyKv7LMx+ctc=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v3 4/4] net: phy: microchip_rds_ptp: add HW timestamp configuration reporting
Date: Tue,  6 Jan 2026 16:07:23 +0000
Message-ID: <20260106160723.3925872-5-vadim.fedorenko@linux.dev>
In-Reply-To: <20260106160723.3925872-1-vadim.fedorenko@linux.dev>
References: <20260106160723.3925872-1-vadim.fedorenko@linux.dev>
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

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/phy/microchip_rds_ptp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/phy/microchip_rds_ptp.c b/drivers/net/phy/microchip_rds_ptp.c
index 5f6e7cd11622..f5f2928e705f 100644
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
@@ -1293,6 +1305,7 @@ struct mchp_rds_ptp_clock *mchp_rds_ptp_probe(struct phy_device *phydev, u8 mmd,
 	clock->mii_ts.rxtstamp = mchp_rds_ptp_rxtstamp;
 	clock->mii_ts.txtstamp = mchp_rds_ptp_txtstamp;
 	clock->mii_ts.hwtstamp_set = mchp_rds_ptp_hwtstamp_set;
+	clock->mii_ts.hwtstamp_get = mchp_rds_ptp_hwtstamp_get;
 	clock->mii_ts.ts_info = mchp_rds_ptp_ts_info;
 
 	phydev->mii_ts = &clock->mii_ts;
-- 
2.47.3


