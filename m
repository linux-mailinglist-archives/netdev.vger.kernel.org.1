Return-Path: <netdev+bounces-240504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53825C75CE8
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 18:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8863B358606
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4E42ED16B;
	Thu, 20 Nov 2025 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DzgOD0iE"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37FD2EC542
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763660781; cv=none; b=MDzJTkobYM0VzN4uZFVsqY6/B1Y+rCKm2WcoMya20xbIQEARFH0dJS04EQ2e/S5Qlrx8iZe2FuMNuJzJyQOv7wgExW8faFEKk/wTF/BBh8eGGb5Y9/mEl4PVskXPDl5rr9GX/OlqfqieGikhylIi8rYXFHAkZsSo9FTxq9GpIIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763660781; c=relaxed/simple;
	bh=1Ca/qY2Ml8cCPq7Hvu9n+qnHsxbbM3anR3yM+OPfJsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUHi/lxIg07UYu60LRwY8P/pl69xJdDuaTmPy935bhPn3PwZZzp+g/CKWYGHx98YfMF2g1StbIfM5Qah2BDcFHV2lR0pIjlptwceTSMphDMvGc3HDyWQS/XFfx0GQZOOuKy2rkvwB121drP5DBekYgijUPBmxlZRK6NVnKdsFmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DzgOD0iE; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763660776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nG1loUxdNCihYysCEIG0CYK3HtZUZmCA9fU4W7Hq6/Q=;
	b=DzgOD0iE5ZCXPEG/Rp9gyQBB3nhWJB7KR15pt3cbHKY9WKMnEiJAj7yAo7QEcM3/ZjTUKI
	eohKqKo2UlpqAU0nbP9elD1Tt2yaso0AHxKMzQEomkvWKNQ+BjQFMy1kCOOoMNvyVqWKgd
	HITMM+kaMWb2rJhJTiXUJVZvOXzHwjs=
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
Subject: [PATCH net-next v4 5/7] phy: mscc: add HW timestamp configuration reporting
Date: Thu, 20 Nov 2025 17:45:38 +0000
Message-ID: <20251120174540.273859-6-vadim.fedorenko@linux.dev>
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

The driver stores HW configuration and can technically report it.
Add callback to do it.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/phy/mscc/mscc_ptp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
index dc06614222f6..4865eac74b0e 100644
--- a/drivers/net/phy/mscc/mscc_ptp.c
+++ b/drivers/net/phy/mscc/mscc_ptp.c
@@ -1051,6 +1051,18 @@ static void vsc85xx_ts_reset_fifo(struct phy_device *phydev)
 			     val);
 }
 
+static int vsc85xx_hwtstamp_get(struct mii_timestamper *mii_ts,
+				struct kernel_hwtstamp_config *cfg)
+{
+	struct vsc8531_private *vsc8531 =
+		container_of(mii_ts, struct vsc8531_private, mii_ts);
+
+	cfg->tx_type = vsc8531->ptp->tx_type;
+	cfg->rx_filter = vsc8531->ptp->rx_filter;
+
+	return 0;
+}
+
 static int vsc85xx_hwtstamp_set(struct mii_timestamper *mii_ts,
 				struct kernel_hwtstamp_config *cfg,
 				struct netlink_ext_ack *extack)
@@ -1612,6 +1624,7 @@ int vsc8584_ptp_probe(struct phy_device *phydev)
 	vsc8531->mii_ts.rxtstamp = vsc85xx_rxtstamp;
 	vsc8531->mii_ts.txtstamp = vsc85xx_txtstamp;
 	vsc8531->mii_ts.hwtstamp_set = vsc85xx_hwtstamp_set;
+	vsc8531->mii_ts.hwtstamp_get = vsc85xx_hwtstamp_get;
 	vsc8531->mii_ts.ts_info  = vsc85xx_ts_info;
 	phydev->mii_ts = &vsc8531->mii_ts;
 
-- 
2.47.3


