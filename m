Return-Path: <netdev+bounces-242746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7827C94766
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 20:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 82F32347C6F
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 19:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC321311979;
	Sat, 29 Nov 2025 19:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fELkCnB/"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6044A24EA90
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 19:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764446052; cv=none; b=N/iJ7TXfqYlcSE6bvF2SrugTB5Oq2htRapSf0brEkQefOQIB2VOasHy0wHpvIvkR2f5ybbNKQEIJR6YDaCkIWlyBWzQT2J/Ki4WgZJL9y8Yf26pJams/ZS9b5W4rt85XsMy4fgiQxzHfk1ImCAe4wU2KtfeAm4TJ0FOkZwDv+7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764446052; c=relaxed/simple;
	bh=Hf5pChy6SqRiQU4wfzcgjo+naiBOdFrgBXSDT2sZuQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bE6+qJ4wJcQK3q6KmOzG6KI+l3fF4YkxXOjZ076MNG2T0W3Pm+tgoBOSxw2CRvygLYu16MRLr4L0EffKY2bSPMixTWAHbVgufXnTDWECB5hCaXCegGxDbK29X94DYWzpCRUQfMoZDXui8hQZ6GqSZt92335kjpyh3L6mT15hWEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fELkCnB/; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764446048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OK98pOCHgFJvWBYQWUiXPaF6mu5wBIrt8IFqqKs9vJY=;
	b=fELkCnB/298U9kfvyMjuiiOCRYSRFXtFfbc85J+Lq2EVMfhk69cb7mWZqqGlXu/l+6fIEP
	PjAFlcqI+ry0Wt8zuDSz/U3P7Dmx2oosOHAM37Hftj1g3pUhlLbXlXWN3qAalrhz6fC6Lj
	MQHUC+nQYb8olTpiKaH0Nw2lP4z/A0I=
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
Subject: [PATCH net-next v2 4/4] net: phy: microchip_rds_ptp: add HW timestamp configuration reporting
Date: Sat, 29 Nov 2025 19:53:34 +0000
Message-ID: <20251129195334.985464-5-vadim.fedorenko@linux.dev>
In-Reply-To: <20251129195334.985464-1-vadim.fedorenko@linux.dev>
References: <20251129195334.985464-1-vadim.fedorenko@linux.dev>
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
index 6a7a0bb95301..ad066d66a467 100644
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


