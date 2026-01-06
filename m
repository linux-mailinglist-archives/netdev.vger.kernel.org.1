Return-Path: <netdev+bounces-247390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C48CF94AF
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 17:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4C073026528
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 16:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1414823F42D;
	Tue,  6 Jan 2026 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dxRD6o02"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC541F418F
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767715722; cv=none; b=bT5xy/pzSk3IOdAY0MtFZW38qdOe+ALO+8hB8swlyDtAdksg06qCTa6cqe4QvePdLRHpr+3gA30ZTCLFGXU1PyILO9HtzKHoRxmKQnsCsf++d4yNf1LdvLAmqfyRcgz4CqOUefCK6xcx1yHk//6CB3j8KT3GWzDtzIaYxcVsWsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767715722; c=relaxed/simple;
	bh=YRoHbzi0dcE7LICy+XqEV4QvvohAmFgL/p9kUiaf0Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0fXUGY+t3YdsXXG6upGyAvzimrEVDlbWbIOv5C0HmH0UIDTdgDksg9prIZ0+KRuPUHE6+g+UsVS/jWFqUUZNJ9GE24wRWA8pn/DpL2Q1QeGZRZttCSbLUrsbc6em2nMc1SOG2j0JbVp/9zIQWlPel8pucuGFOdM2kLLq68AHSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dxRD6o02; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767715718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qyUs/3ewEU2RqZxRL9sARioe4npBt5kZego5+rVMIhA=;
	b=dxRD6o02MkAIn17NukyieLFrt6z5PvCbxDpw0Fk5YSv9cbLH3J4vTb2jIVFMDBHoW7h5Ey
	8nhFQFw+0/Pfplvi+E1GF+IT/ea8/uuDsXN44TUnF2UvYpzDbm1Rw/aWgRth8xQjMi6DXB
	mZptp6RA0rOxUiRCPMn5e8bFR4E19Lc=
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
Subject: [PATCH net-next v3 3/4] net: phy: microchip_rds_ptp: improve HW ts config logic
Date: Tue,  6 Jan 2026 16:07:22 +0000
Message-ID: <20260106160723.3925872-4-vadim.fedorenko@linux.dev>
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

The driver stores new HW timestamping configuration values
unconditionally and may create inconsistency with what is actually
configured in case of error. Improve the logic to store new values only
once everything is configured.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/phy/microchip_rds_ptp.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/microchip_rds_ptp.c b/drivers/net/phy/microchip_rds_ptp.c
index 4c6326b0ceaf..5f6e7cd11622 100644
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
 
+	switch (config->tx_type) {
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


