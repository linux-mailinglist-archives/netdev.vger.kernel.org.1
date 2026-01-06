Return-Path: <netdev+bounces-247388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 958A8CF94A9
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 17:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48F24301BEB3
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 16:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAF71E1DFC;
	Tue,  6 Jan 2026 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ff+p43d0"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D804C92
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767715719; cv=none; b=Xhp/Qio0Ebm4OFNlIQCr8CpayuEj+AXL6JkqgBTePfB75C5ae6Cvu7GFYbCS7mzlJuwLlyypEWBTgdTLVnu1n7Wpd4we4r65Rv56iRRMHf5ttFDP61OXcnBDZBl8r6XY5833xaYQ+gc4vNCPvP+y1PpQQPGkiNVm8CfPKkfm5O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767715719; c=relaxed/simple;
	bh=ex+KhyOVgb1LZHod4T7l/Ymwp/2jAiyyGQg2XSWvElM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnUirV2AmdlkyOPiHwbpYuOvwrMA9q2WnnnHCYS9qfpM1X+vZKAQfs9GFQspeB1192fq/O5V7fYXa3PBPgza+MojG74eGmEQp4P6KP4MkN+B2gUm2LszZ7IVKQHUa/Nj1AqEkfRGlzwgW5EB1sRDvhnd/E6d4OXIk4W2q0w2fUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ff+p43d0; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767715716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uiFE/MDy3/0kWuab1HOvPeDsg2kjJJU5i9Ob7XHMbjQ=;
	b=Ff+p43d06AbIxAQOcel7KNRq/Dpl0ay1qN8TsMT0eh9LY6l02l20m9ULdEijjnZBZ935Yq
	X5HUrKLpvVlOjTGvVmSJLTYGrGac1+JPK2w1giNpo54euXgRhm9sXxP2Ld68Z0DR00wWAe
	JgpCSEHctmD54rwnR2tpPRIDrC/Qrdo=
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
Subject: [PATCH net-next v3 1/4] net: phy: micrel: improve HW timestamping config logic
Date: Tue,  6 Jan 2026 16:07:20 +0000
Message-ID: <20260106160723.3925872-2-vadim.fedorenko@linux.dev>
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

The driver was adjusting stored values independently of what was
actually supported and configured. Improve logic to store values
once all checks are passing

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/phy/micrel.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 05de68b9f719..c0aea74a559f 100644
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
 
+	switch (config->tx_type) {
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
@@ -5081,6 +5087,18 @@ static int lan8841_hwtstamp_set(struct mii_timestamper *mii_ts,
 		return -ERANGE;
 	}
 
+	switch (config->tx_type) {
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
 	/* Setup parsing of the frames and enable the timestamping for ptp
 	 * frames
 	 */
-- 
2.47.3


