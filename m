Return-Path: <netdev+bounces-240503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD91C75CA7
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 18:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC41E4E2AC8
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13A12F5496;
	Thu, 20 Nov 2025 17:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PrEhBROz"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8C036D514
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 17:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763660767; cv=none; b=M5Jq0nji/DjlSVc+YNBUyhFZ6x5uxcVXZeup+LxdV7CRbtlTG4Dte53pwO4lvENci968zRoGfbt+oco5XujiL1r5z9J0MpdHSNv3WuKeK0qeTlVb4/4/GUBudLswFMQAwVPNBcmmOVuDNOn/lmkpGUW+uDqkSFrzQNo1RSZpqFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763660767; c=relaxed/simple;
	bh=YYv17Pom9TozlwjuILchL5PpOMW9JkIowK8FYH/4oK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBWoZebZzAa2cfCoveMjZPizmcU5wnRFxVApmajawArp+ksjw7VIPx+eVm/a18qgiSkBwznp0hsbQOtOhttiiY8Co3wGXlFXO1nANXxd1BYONfbv/ea0NomWo4WJ1aQccczw9ZMz/vewAHb4jlwk9fMUJEWlceoJDi07NF492w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PrEhBROz; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763660763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qp85VFyLkn6eJCNRomOcka7MZpUqP4tEdp7s6xar+so=;
	b=PrEhBROzIARQk2TPioLv8CNCT/aq7VC1jEehSwx9HpyvNku62/+TjcrMZ9pxt4WueuF0j+
	BXjof8iNbsgJmsAigtWdZkDCPD0uppq7vroyEaNlvB9lwOwVYQ+TMrsCsIzAE13XH37JlZ
	ayaU5PoCGzO/Wzrv1LY9KrNJENMPECI=
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
Subject: [PATCH net-next v4 4/7] net: phy: dp83640: add HW timestamp configuration reporting
Date: Thu, 20 Nov 2025 17:45:37 +0000
Message-ID: <20251120174540.273859-5-vadim.fedorenko@linux.dev>
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

The driver stores configuration of TX timestamping and can technically
report it. Patch RX timestamp configuration storage to be more precise
on reporting and add callback to actually report it.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/phy/dp83640.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index f733a8b72d40..b950acc9c49b 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -1176,6 +1176,18 @@ static irqreturn_t dp83640_handle_interrupt(struct phy_device *phydev)
 	return IRQ_HANDLED;
 }
 
+static int dp83640_hwtstamp_get(struct mii_timestamper *mii_ts,
+				struct kernel_hwtstamp_config *cfg)
+{
+	struct dp83640_private *dp83640 =
+		container_of(mii_ts, struct dp83640_private, mii_ts);
+
+	cfg->rx_filter = dp83640->hwts_rx_en;
+	cfg->tx_type = dp83640->hwts_tx_en;
+
+	return 0;
+}
+
 static int dp83640_hwtstamp_set(struct mii_timestamper *mii_ts,
 				struct kernel_hwtstamp_config *cfg,
 				struct netlink_ext_ack *extack)
@@ -1198,7 +1210,7 @@ static int dp83640_hwtstamp_set(struct mii_timestamper *mii_ts,
 	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
 	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
 	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
-		dp83640->hwts_rx_en = 1;
+		dp83640->hwts_rx_en = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
 		dp83640->layer = PTP_CLASS_L4;
 		dp83640->version = PTP_CLASS_V1;
 		cfg->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
@@ -1206,7 +1218,7 @@ static int dp83640_hwtstamp_set(struct mii_timestamper *mii_ts,
 	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
 	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
-		dp83640->hwts_rx_en = 1;
+		dp83640->hwts_rx_en = HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
 		dp83640->layer = PTP_CLASS_L4;
 		dp83640->version = PTP_CLASS_V2;
 		cfg->rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
@@ -1214,7 +1226,7 @@ static int dp83640_hwtstamp_set(struct mii_timestamper *mii_ts,
 	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
 	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
-		dp83640->hwts_rx_en = 1;
+		dp83640->hwts_rx_en = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
 		dp83640->layer = PTP_CLASS_L2;
 		dp83640->version = PTP_CLASS_V2;
 		cfg->rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
@@ -1222,7 +1234,7 @@ static int dp83640_hwtstamp_set(struct mii_timestamper *mii_ts,
 	case HWTSTAMP_FILTER_PTP_V2_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_SYNC:
 	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
-		dp83640->hwts_rx_en = 1;
+		dp83640->hwts_rx_en = HWTSTAMP_FILTER_PTP_V2_EVENT;
 		dp83640->layer = PTP_CLASS_L4 | PTP_CLASS_L2;
 		dp83640->version = PTP_CLASS_V2;
 		cfg->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
@@ -1408,6 +1420,7 @@ static int dp83640_probe(struct phy_device *phydev)
 	dp83640->mii_ts.rxtstamp = dp83640_rxtstamp;
 	dp83640->mii_ts.txtstamp = dp83640_txtstamp;
 	dp83640->mii_ts.hwtstamp_set = dp83640_hwtstamp_set;
+	dp83640->mii_ts.hwtstamp_get = dp83640_hwtstamp_get;
 	dp83640->mii_ts.ts_info  = dp83640_ts_info;
 
 	INIT_DELAYED_WORK(&dp83640->ts_work, rx_timestamp_work);
-- 
2.47.3


