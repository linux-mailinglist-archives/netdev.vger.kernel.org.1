Return-Path: <netdev+bounces-241258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7ADC820AC
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 19:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BCC3ADDB3
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 18:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3768316900;
	Mon, 24 Nov 2025 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bi627ITG"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C4A3168F8
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764007960; cv=none; b=S8vrGPpWCU19v3qL2KhDXA8YaXO5aOv4r0Ao9JqNC8mxJEX6lSxLGYLQtwn6tljd8YeYZaeXBx62V/HYp9Jqx6tkxQGh7/ygrJviG4ymZTgYengiOEPH2KoWFCh8mkjjIQ3kGlUiYhbPfFxjgCXeRgAaCkOxDrdBGGajXSn05BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764007960; c=relaxed/simple;
	bh=YYv17Pom9TozlwjuILchL5PpOMW9JkIowK8FYH/4oK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCdfu9KQTL7d5/bdx17Md0fhSE+d0imhdmEf4KokLv3bB1tQyeZ4SAuaOwutMuvzCMsGjMoiHXzh1gIQQmyTx5VaQebpDozl+L6b4yQYk02ix4eLx4CTAHC6UTJHvJ7wxGVpr+yTKCsF5quE0EzNCTqglJJuZ2YdJAgGAKnzYGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bi627ITG; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764007956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qp85VFyLkn6eJCNRomOcka7MZpUqP4tEdp7s6xar+so=;
	b=Bi627ITGMSai0ftdLPdpwspU5nDPsdmYSgQmw4OzHCCVyroZiJtvenvD1zR/Si2Fqq/ORk
	9mpu8qFe7Gjbx6+uXIANK38OVe8jyPKZHfDEV5lFHSZb+CzgUQbjtmv1xuI8XgHQm361zD
	8oZFHbLInpFTk6gjMAjprNEiooXXXPs=
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
Subject: [PATCH net-next v5 4/7] net: phy: dp83640: add HW timestamp configuration reporting
Date: Mon, 24 Nov 2025 18:11:48 +0000
Message-ID: <20251124181151.277256-5-vadim.fedorenko@linux.dev>
In-Reply-To: <20251124181151.277256-1-vadim.fedorenko@linux.dev>
References: <20251124181151.277256-1-vadim.fedorenko@linux.dev>
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


