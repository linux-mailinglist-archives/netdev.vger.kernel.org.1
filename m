Return-Path: <netdev+bounces-242411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0732DC902DA
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 22:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F2FE3AACB8
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 21:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207BD31CA7D;
	Thu, 27 Nov 2025 21:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FxuvTIU/"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF7F309DA1
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764277992; cv=none; b=ldJr462lhhUzKQoGCuZjz+/W31FK7l2+b9WCI9Zki3l6dY4Kj1vKzZzp3/Zx8mmM1IbHBAZBfEOJlx3dvYdYCq+GUrAT4PXXKkTioDdti9+SzzgzNs0p0cEITxtjpFTQTyOtvKaKX53s3BLeZjQUSHoVhfiT7xOBK/4ZgvbJOGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764277992; c=relaxed/simple;
	bh=xJ/OB4zWIPXmyuzdWbGRw6jKkF+9Efk7zBngKVp75rE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UfjHRqYx2ko4MRZ4VeQzufEhBMdxUmStWeB7JYVqlHyXuo8KtTMF+cJUtYhpKVqSW6i55lpnve8rPUZwPjG8AjoNW3n2+MTFvZOWyf262y7d/Yke/TBabAJOMpYYYEojYDksx12A8d1TaXZTC3rnXrnSqoVmZbilZR9pcUft/PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FxuvTIU/; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764277988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xpDAvDBgI8DTVQ7EG68Y4y8TJdB90TpiE1/9MK64G5U=;
	b=FxuvTIU/Hr5eQDorz+IAZUNm/YjhQYCpL1OiGACDyedbcNBdlKfnRAJ+uNSvOgBdpPIiI+
	rSdRwubCwpdISvX5BB934/Quq0yEuA5/gtCvmx2p3CCIB2WBk+TlDA4Ak4qHNB3kjcKkZt
	+c2gN5Na2UnUwglCl3sXJPql6HZZNv4=
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
Subject: [PATCH net-next 3/4] net: phy: microchip_rds_ptp: improve HW ts config logic
Date: Thu, 27 Nov 2025 21:12:44 +0000
Message-ID: <20251127211245.279737-4-vadim.fedorenko@linux.dev>
In-Reply-To: <20251127211245.279737-1-vadim.fedorenko@linux.dev>
References: <20251127211245.279737-1-vadim.fedorenko@linux.dev>
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
 drivers/net/phy/microchip_rds_ptp.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/microchip_rds_ptp.c b/drivers/net/phy/microchip_rds_ptp.c
index 4c6326b0ceaf..6b0933ef9142 100644
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
@@ -553,7 +550,7 @@ static int mchp_rds_ptp_hwtstamp_set(struct mii_timestamper *mii_ts,
 	if (rc < 0)
 		return rc;
 
-	if (clock->hwts_tx_type == HWTSTAMP_TX_ONESTEP_SYNC)
+	if (config->tx_type == HWTSTAMP_TX_ONESTEP_SYNC)
 		/* Enable / disable of the TX timestamp in the SYNC frames */
 		rc = mchp_rds_phy_modify_mmd(clock, MCHP_RDS_PTP_TX_MOD,
 					     MCHP_RDS_PTP_PORT,
@@ -587,8 +584,13 @@ static int mchp_rds_ptp_hwtstamp_set(struct mii_timestamper *mii_ts,
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


