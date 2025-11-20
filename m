Return-Path: <netdev+bounces-240505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0F6C75C6E
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 18:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id E30D82BDB1
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A992F745C;
	Thu, 20 Nov 2025 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="krexigg3"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D482EDD6B
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763660785; cv=none; b=dHlrEwVEfzpvltqdENZAsaFdnf7GQJ3HGO+C2UAmlC5jdzhXghcXqBjlEQr5/vt6JaZvSK9mSo0vCG1ZM5E51ieLC4Pp/xQ0x9to8wnpr01skPOSOlj/Leu7ChI6PhTVTKLmeSuzg4FZhmElE/ee0o9AapzSd28PC3qg9tPtzPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763660785; c=relaxed/simple;
	bh=AJAwFDUDuZulXcZs/wM9P23T9Ra8Ftmu3Pqc3ZIG298=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MjACAs82iMa++TQSwyeoiQ26VnCYA7iq3iV1Dfpd+PFMlxJqnoeoVxNcFzlDMBIe5ya5+9aroCCDcyc4Y2OkLiSWsieNBOASjqCAs4Aw+YONjS1m83W7E08sf+NfsRAGiV71Ie2dKMRspP+6kV72Nya/KFmcAHW47Dni28DFaCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=krexigg3; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763660779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sw4xei3SSMwAkjXxigE5CeMQ1nmp1bA9j7ZC9gQXpOk=;
	b=krexigg3mUahKpPESzPg3/d21XpdjB8m1rt16YNlhlhBmehtyWIqmiSXZzaDX7viLyNYSe
	ur1bNPXB4jzr5mKHkjwaREQECFjBJ3GSYQVSn2Hbou+LbjcJdsgcWwwIdJxQBKbGEnJJV3
	3we61em5nzuttCWubIPeJgYIqYt/n2Y=
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
Subject: [PATCH net-next v4 6/7] net: phy: nxp-c45-tja11xx: add HW timestamp configuration reporting
Date: Thu, 20 Nov 2025 17:45:39 +0000
Message-ID: <20251120174540.273859-7-vadim.fedorenko@linux.dev>
In-Reply-To: <20251120174540.273859-1-vadim.fedorenko@linux.dev>
References: <20251120174540.273859-1-vadim.fedorenko@linux.dev>
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


