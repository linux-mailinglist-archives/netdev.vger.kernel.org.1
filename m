Return-Path: <netdev+bounces-240502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13336C75C6B
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 18:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id BBC952BB63
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADF12E7178;
	Thu, 20 Nov 2025 17:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S8lAzav0"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24732E9EB8
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763660765; cv=none; b=CeaFMG+n8jdP6q5IiB83YujPEMBzytR+1W6+yI9xwyEbQ/oVa+WWFXFhd9phD4oTd1KtmG/HuF7iGL/HQ/gGsJtINRrFRhk5hF4iNCoUDCFvVDoOJGxjziBztYq/DmCPgoD2UdOtGr4fuLjNU77jwPyjCtDE5zsifzyXX2Ggz3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763660765; c=relaxed/simple;
	bh=uttRoXzq6IAoqGtcFw8a2WYggVEpEqICLYi38St9lgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bs0JzLDkrgn4xvcrQ5AihmojtPkvTZsvUFPsPlJlSWJvVvT5FzAkzvFPyTPAxB/tD9dx+N58MLTLtpzMV326734/8Ea1yPRqPINYSlxf8at32mNgy6FPgMlcAFbrv4DmXN5de5WD2dcdPzX7NBPBlf3loabLCuXC9B6gfTR/dJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S8lAzav0; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763660761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p3IhDbVgOwLXjxPjHY24H6omlGzE6uS6sIRjUBjWfoQ=;
	b=S8lAzav0frZi7TRorVOlq8mbkcFbNhGDjEAaa1WRPSNykBxIIrKBybHL0/uBn1hNZhmW34
	V6nHuRu5hc1VOHqkkFmXPwyR5q41sGZZ9Qmksj8j8Zt0OCfVi8so9uDSeF94GYVYRgYPuk
	1EGDdls+yYPsqo2UJBFytDL/4LnxhtA=
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
Subject: [PATCH net-next v4 3/7] net: phy: broadcom: add HW timestamp configuration reporting
Date: Thu, 20 Nov 2025 17:45:36 +0000
Message-ID: <20251120174540.273859-4-vadim.fedorenko@linux.dev>
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

The driver stores configuration information and can technically report
it. Implement hwtstamp_get callback to report the configuration.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/phy/bcm-phy-ptp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/phy/bcm-phy-ptp.c b/drivers/net/phy/bcm-phy-ptp.c
index 6815e844a62e..65d609ed69fb 100644
--- a/drivers/net/phy/bcm-phy-ptp.c
+++ b/drivers/net/phy/bcm-phy-ptp.c
@@ -780,6 +780,18 @@ static void bcm_ptp_txtstamp(struct mii_timestamper *mii_ts,
 	kfree_skb(skb);
 }
 
+static int bcm_ptp_hwtstamp_get(struct mii_timestamper *mii_ts,
+				struct kernel_hwtstamp_config *cfg)
+{
+	struct bcm_ptp_private *priv = mii2priv(mii_ts);
+
+	cfg->rx_filter = priv->hwts_rx ? HWTSTAMP_FILTER_PTP_V2_EVENT
+				       : HWTSTAMP_FILTER_NONE;
+	cfg->tx_type = priv->tx_type;
+
+	return 0;
+}
+
 static int bcm_ptp_hwtstamp_set(struct mii_timestamper *mii_ts,
 				struct kernel_hwtstamp_config *cfg,
 				struct netlink_ext_ack *extack)
@@ -899,6 +911,7 @@ static void bcm_ptp_init(struct bcm_ptp_private *priv)
 	priv->mii_ts.rxtstamp = bcm_ptp_rxtstamp;
 	priv->mii_ts.txtstamp = bcm_ptp_txtstamp;
 	priv->mii_ts.hwtstamp_set = bcm_ptp_hwtstamp_set;
+	priv->mii_ts.hwtstamp_get = bcm_ptp_hwtstamp_get;
 	priv->mii_ts.ts_info = bcm_ptp_ts_info;
 
 	priv->phydev->mii_ts = &priv->mii_ts;
-- 
2.47.3


