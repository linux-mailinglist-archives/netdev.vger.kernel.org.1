Return-Path: <netdev+bounces-242743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DF3C94756
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 20:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F5A3A7985
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 19:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D0C310650;
	Sat, 29 Nov 2025 19:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DE7BHWxg"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642A825785E
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764446051; cv=none; b=hViTeHxfMU+iDNLWt8A4vI81lOgpQiHDBdvejupjKsWSwOd6x/7n1TgoRJ5yUvid6dw0kXDZuadtngZ0UKad20xcwyRLZk3ubfVhbvGbjmXRPOGU11op8UC6B6YKZO8bifHNe9CUZlqrwJrJcrT7c5H7TKpQHGEWk2Fgd2r2+Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764446051; c=relaxed/simple;
	bh=E7cjfeGaOHv4Mf5QCfOdlz3oaLPwFFV3vSARJ4ltYDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dBte+MKuCTH59FucQljiG5wK+QDF35nKjE+Z+gMLGU+lkbV6OdNi2cdx8Yz9X0V+YYv+XETTFkE5dnogCmjddRrwPaU86rDM3mIyVnmFoAU6f7LuGpZvO/BiO8vK/qLEhoCyb1LvhBerJVfN04Dl9dxKuRcWlVWqZ+caX7JRCWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DE7BHWxg; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764446044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wge4fy7tJX3DK8sLoAtd+IXpgr85J4lMoyiSBOOzL/k=;
	b=DE7BHWxgamjq/D26yBEFyXwU0/a8V5jqz73qiecNHofsv6IRUxMg1/3nmh4qyoM02JpJXH
	OhPLMwCzGM2KZC7CfE5f3EICOG/dEKySjPXYQu5wq12uBwihfS87bC/7wwKj9hbq60tUv0
	Df7b8No20NejC8BS5kY6PPEZ5sKezO4=
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
Subject: [PATCH net-next v2 1/4] net: phy: micrel: improve HW timestamping config logic
Date: Sat, 29 Nov 2025 19:53:31 +0000
Message-ID: <20251129195334.985464-2-vadim.fedorenko@linux.dev>
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

The driver was adjusting stored values independently of what was
actually supported and configured. Improve logic to store values
once all checks are passing

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/phy/micrel.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 05de68b9f719..1ada05dd305c 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -3157,9 +3157,6 @@ static int lan8814_hwtstamp_set(struct mii_timestamper *mii_ts,
 	int txcfg = 0, rxcfg = 0;
 	int pkt_ts_enable;
 
-	ptp_priv->hwts_tx_type = config->tx_type;
-	ptp_priv->rx_filter = config->rx_filter;
-
 	switch (config->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		ptp_priv->layer = 0;
@@ -3187,6 +3184,18 @@ static int lan8814_hwtstamp_set(struct mii_timestamper *mii_ts,
 		return -ERANGE;
 	}
 
+	switch (config->rx_filter) {
+	case HWTSTAMP_TX_OFF:
+	case HWTSTAMP_TX_ON:
+	case HWTSTAMP_TX_ONESTEP_SYNC:
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	ptp_priv->hwts_tx_type = config->tx_type;
+	ptp_priv->rx_filter = config->rx_filter;
+
 	if (ptp_priv->layer & PTP_CLASS_L2) {
 		rxcfg = PTP_RX_PARSE_CONFIG_LAYER2_EN_;
 		txcfg = PTP_TX_PARSE_CONFIG_LAYER2_EN_;
@@ -5051,9 +5060,6 @@ static int lan8841_hwtstamp_set(struct mii_timestamper *mii_ts,
 	int txcfg = 0, rxcfg = 0;
 	int pkt_ts_enable;
 
-	ptp_priv->hwts_tx_type = config->tx_type;
-	ptp_priv->rx_filter = config->rx_filter;
-
 	switch (config->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		ptp_priv->layer = 0;
@@ -5081,6 +5087,9 @@ static int lan8841_hwtstamp_set(struct mii_timestamper *mii_ts,
 		return -ERANGE;
 	}
 
+	ptp_priv->hwts_tx_type = config->tx_type;
+	ptp_priv->rx_filter = config->rx_filter;
+
 	/* Setup parsing of the frames and enable the timestamping for ptp
 	 * frames
 	 */
-- 
2.47.3


