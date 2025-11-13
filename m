Return-Path: <netdev+bounces-238313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F90EC57390
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86FC83A8E2A
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF23333B943;
	Thu, 13 Nov 2025 11:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uM4yUJvM"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C194D33BBD3
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033562; cv=none; b=tfW766HmistCdVzCdIkQXk75r9g0pbTlcVuDxMkIBUKdx2o1BVy0gVFBBGurDT4D6+m3fbyPo0i8jYoDyLJ9brZdcNY7xUfsKaH+l5iVWBehaIEVO9xQA+iUIB8JLanZr1PCyB/XTe5QLkDL/673B3urNMGPn0IrzayEgUJm+as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033562; c=relaxed/simple;
	bh=FSDDPMiS8rO56jPusgBoh+RHhMuF7LmYdUrSgUMVh98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8koiHk7WzEW5ksWzi22ItQeQ5WF+L7iKT2hz87KY5Y0jo/WXA2Op/lIMyCSiEfzBAHpJuHqpYrc20TIb4QNDK8jT0MnRqB4waK1GsUV4PeVbOkasgJ/gjY3gcq5Pbave6T7xBw4Rg4chbNZ7ba2XuDdSo/WSxZqdopao4eAZSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uM4yUJvM; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763033558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FPgyYFzPzsZVkh75m60RrdwmoponMr51azBYvaHVoBM=;
	b=uM4yUJvMmEoMfqtEGZa/4S0FRCdlCfgRARo2NIePi03VOe+ACQG9bTnJB/FfujJoaCnqVI
	nQsRKFLcJDlJopN9I1B2EZrFzgRv+Sd3N49xNZ3gbU1rsqmXXV7aPPGCQZJdypNfM33osh
	v7oeefFS5ZmUYxv3fSyXBq5c1Cpey3A=
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
Subject: [PATCH net-next v2 4/9] net: phy: dp83640: add HW timestamp configuration reporting
Date: Thu, 13 Nov 2025 11:32:02 +0000
Message-ID: <20251113113207.3928966-5-vadim.fedorenko@linux.dev>
In-Reply-To: <20251113113207.3928966-1-vadim.fedorenko@linux.dev>
References: <20251113113207.3928966-1-vadim.fedorenko@linux.dev>
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


