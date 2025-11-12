Return-Path: <netdev+bounces-237768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ADCC501B3
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 01:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFEF53B2715
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 00:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522D784A35;
	Wed, 12 Nov 2025 00:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m2OBfITw"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549DD13D503
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 00:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762905803; cv=none; b=DeiHJ6ioCtX10fxAGYERjkJB1VmBCd634VDBz28vtXGGdaH99iT15NExFAhJjexRe1ncz1lRobJDmOqVnGRmjRgw1E78jcwrOQJDP3VE8gDWH0bARM/rH+g/EqaTtO4RGFOBsZTlwcc9xGY9v9yXZl0Kq6JdMevFQjSCEhW19b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762905803; c=relaxed/simple;
	bh=FSDDPMiS8rO56jPusgBoh+RHhMuF7LmYdUrSgUMVh98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NK01PqGmKR/98T0nzBfWcl3XwUgSxcrvawPY8mT1XdAOfOKDvz31d6VOZLok1m/CcQpkx+yx8+GllfCfiHAi3lDsdUnLUMbS18YvNOWuZzIxo91pvUX/sRy1PZpgiReImOppLMNrJrL6nvVmB9v9veUKUV4Mfw/QXOXx96f6Lj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m2OBfITw; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762905799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FPgyYFzPzsZVkh75m60RrdwmoponMr51azBYvaHVoBM=;
	b=m2OBfITwFj8uI/n2HBDiDitVsJCGHhLIRphh+59iE0K1/Rn4J3OlegBJXOGAkfulzRdMJm
	UCoBMYmzV0xOe+y4cKMlnAEKY6aWiq3D1rQrM0ClfyoW6jVjZOUTaZvPtk0wSebeJJxB7b
	LsP1b6jao1lR/OiYwD+0UyLGiMhLIf4=
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
Subject: [PATCH net-next 3/8] net: phy: dp83640: add HW timestamp configuration reporting
Date: Wed, 12 Nov 2025 00:02:52 +0000
Message-ID: <20251112000257.1079049-4-vadim.fedorenko@linux.dev>
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


