Return-Path: <netdev+bounces-239975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B7EC6E973
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 13:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 059592E85C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 12:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286E43559D9;
	Wed, 19 Nov 2025 12:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="enyDhOLH"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020992DCF5D
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763556519; cv=none; b=NC//JcALpCTKVlGqbjZdb50UxVluJRwCUvf/UkJJpokCOA3iJtiPmmD1XewdtnDGnojB6GFfF2vqSZETrX6hL5fia5kZ6eU4I6lM0TxpWIdkr1nCYKvjo5VIrgGARGWq7EsyYQ+oMFbpsxAgDPliP8aTiqYnK2jpVJlIIC53dwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763556519; c=relaxed/simple;
	bh=7lnB6dJ3Z4vfMot/njOH3ffWKkRH7rjIjU5HLWBaz7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NfAVYS59jXHxoQScM6Bha40h4j2r0a2kbmzKfdppiwoRhtpRuSv+aN6Wv/sruDanFTEq3DjK4HTQJJtKatEx6dQfL8FVCcj1+4Q7C6I9Uo01chuUCMNWSWQkSjb04tOgE0e6YD6E1wx/w4ZhQ8GMExJLNXuTO8Q2bL7GeEEUdlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=enyDhOLH; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763556512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2u0BGHldxIiW1dEeKzMf0T+kLPUpu7hP2nps4rUC+48=;
	b=enyDhOLHnf2QEZpmwL0G+r/5kYXpxcb6CtonGx2J98BHxEqUKTAeFOxgzqP0xoj6owJSOu
	7X50fZ7+V49VLC4YdteJTo1RfCwciWdqa4oPAqApobqtJy4I86vI52oTKkbSijLxZl1Odq
	S8zJ38oziY7Gzi4CDYdFheqwta+tpu4=
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
Subject: [PATCH net-next v3 5/9] net: phy: micrel: add HW timestamp configuration reporting
Date: Wed, 19 Nov 2025 12:47:21 +0000
Message-ID: <20251119124725.3935509-6-vadim.fedorenko@linux.dev>
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
 drivers/net/phy/micrel.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 05de68b9f719..b149d539aec3 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -3147,6 +3147,18 @@ static void lan8814_flush_fifo(struct phy_device *phydev, bool egress)
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
@@ -4390,6 +4402,7 @@ static void lan8814_ptp_init(struct phy_device *phydev)
 	ptp_priv->mii_ts.rxtstamp = lan8814_rxtstamp;
 	ptp_priv->mii_ts.txtstamp = lan8814_txtstamp;
 	ptp_priv->mii_ts.hwtstamp_set = lan8814_hwtstamp_set;
+	ptp_priv->mii_ts.hwtstamp_get = lan8814_hwtstamp_get;
 	ptp_priv->mii_ts.ts_info  = lan8814_ts_info;
 
 	phydev->mii_ts = &ptp_priv->mii_ts;
@@ -5042,6 +5055,19 @@ static void lan8841_ptp_enable_processing(struct kszphy_ptp_priv *ptp_priv,
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
@@ -5925,6 +5951,7 @@ static int lan8841_probe(struct phy_device *phydev)
 	ptp_priv->mii_ts.rxtstamp = lan8841_rxtstamp;
 	ptp_priv->mii_ts.txtstamp = lan8814_txtstamp;
 	ptp_priv->mii_ts.hwtstamp_set = lan8841_hwtstamp_set;
+	ptp_priv->mii_ts.hwtstamp_get = lan8841_hwtstamp_get;
 	ptp_priv->mii_ts.ts_info = lan8841_ts_info;
 
 	phydev->mii_ts = &ptp_priv->mii_ts;
-- 
2.47.3


