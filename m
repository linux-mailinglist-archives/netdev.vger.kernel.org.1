Return-Path: <netdev+bounces-242744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F64C94760
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 20:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F31D834764A
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 19:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503F53112D2;
	Sat, 29 Nov 2025 19:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yh/JE6to"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED0326E711
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 19:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764446052; cv=none; b=gjsLUyByOSCWnvYjerF2w64BNudyXgCNTBRNNVZY4phNSJ+NexYDc5kW5luPuEsDx1OeTpRtEsstOC+tuCg8UCBJi85idqOFQJpX7IEyHqcvyHoqhB7DTG4NysTCx1A/QFf765RdLBwEPfUtAN6x3RwY0kHfBw+z/gFdyDVDvtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764446052; c=relaxed/simple;
	bh=AmKvzSrZMLoYFXE1Fy5H9Wnevpnwg5FbcPZFBZB4YEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOX2xW01iLmLrQNkr9fE5t/Sabpl/3RMQYbd11xcHCIIiMHXm7g6NoMSHL0Qu9Ad8nIRH/KOP2eu8I57Sbnqv+C110z+tu4mCD/vbTONzkPph4oBxwvWpMKqv1MRMhuKQMIE0JMICHMpoANYEcMqBeij+SAQ2TK7BAjbMQ6l9JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yh/JE6to; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764446047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CqKCE32SGizJk4C0icBjZnPZNNH7EEizmFaB3Bn5xHs=;
	b=Yh/JE6to4IG0omnfuK9kTOroC1cADuONg1NTCw7jZV7/d4mJ5zCIlQB9feqjiWm4Gv9sgh
	gmxCMTVDKbmy5x5zyQ3jNUvSkJRYDYvx7kCBhIQogs76JiYTMpmOXOkuQlkozZncIY8cmQ
	KcZZwvSOp3/cu1r76PkxpRTl/hQ2kXo=
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
Subject: [PATCH net-next v2 3/4] net: phy: microchip_rds_ptp: improve HW ts config logic
Date: Sat, 29 Nov 2025 19:53:33 +0000
Message-ID: <20251129195334.985464-4-vadim.fedorenko@linux.dev>
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

The driver stores new HW timestamping configuration values
unconditionally and may create inconsistency with what is actually
configured in case of error. Improve the logic to store new values only
once everything is configured.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/phy/microchip_rds_ptp.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/microchip_rds_ptp.c b/drivers/net/phy/microchip_rds_ptp.c
index 4c6326b0ceaf..6a7a0bb95301 100644
--- a/drivers/net/phy/microchip_rds_ptp.c
+++ b/drivers/net/phy/microchip_rds_ptp.c
@@ -488,9 +488,6 @@ static int mchp_rds_ptp_hwtstamp_set(struct mii_timestamper *mii_ts,
 	unsigned long flags;
 	int rc;
 
-	clock->hwts_tx_type = config->tx_type;
-	clock->rx_filter = config->rx_filter;
-
 	switch (config->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		clock->layer = 0;
@@ -518,6 +515,15 @@ static int mchp_rds_ptp_hwtstamp_set(struct mii_timestamper *mii_ts,
 		return -ERANGE;
 	}
 
+	switch (config->rx_filter) {
+	case HWTSTAMP_TX_ONESTEP_SYNC:
+	case HWTSTAMP_TX_ON:
+	case HWTSTAMP_TX_OFF:
+		break;
+	default:
+		return -ERANGE;
+	}
+
 	/* Setup parsing of the frames and enable the timestamping for ptp
 	 * frames
 	 */
@@ -553,7 +559,7 @@ static int mchp_rds_ptp_hwtstamp_set(struct mii_timestamper *mii_ts,
 	if (rc < 0)
 		return rc;
 
-	if (clock->hwts_tx_type == HWTSTAMP_TX_ONESTEP_SYNC)
+	if (config->tx_type == HWTSTAMP_TX_ONESTEP_SYNC)
 		/* Enable / disable of the TX timestamp in the SYNC frames */
 		rc = mchp_rds_phy_modify_mmd(clock, MCHP_RDS_PTP_TX_MOD,
 					     MCHP_RDS_PTP_PORT,
@@ -587,8 +593,13 @@ static int mchp_rds_ptp_hwtstamp_set(struct mii_timestamper *mii_ts,
 	/* Now enable the timestamping interrupts */
 	rc = mchp_rds_ptp_config_intr(clock,
 				      config->rx_filter != HWTSTAMP_FILTER_NONE);
+	if (rc < 0)
+		return rc;
 
-	return rc < 0 ? rc : 0;
+	clock->hwts_tx_type = config->tx_type;
+	clock->rx_filter = config->rx_filter;
+
+	return 0;
 }
 
 static int mchp_rds_ptp_ts_info(struct mii_timestamper *mii_ts,
-- 
2.47.3


