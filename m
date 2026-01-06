Return-Path: <netdev+bounces-247389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2A3CF943C
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 17:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E438300EBA8
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 16:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2001823815B;
	Tue,  6 Jan 2026 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AqjvMWXe"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204303A1E73
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767715721; cv=none; b=BqtRvfdguaArIzhDlP6mHTYka9qoxdCK+XW+QJIvz0qwfwG2xJ65GXMWbfZo+bCGFdWCdZtoVoN3eD9eNQn/EEcKXP69ZhJlLTYK2bBuyt3rmL8RFQauftuHBsTj58VEZXn5BphpOwHb7XKCvZcD9PROR0jyYtF/eD/34llcGr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767715721; c=relaxed/simple;
	bh=mdYr1YryAu0zBl12yLb/d7Zs1w5c6gTKt/+089dV6T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6P3/8VA0Np2qHVejYhdcbNWnSxrMkla8U20i6dEsbU6EnQ5LBK3gjRPnSFoNIW6Eq09K/Z9dp4yeA542jlef3B5TZaKehEGm1I7kc4BRHdOY9jQm2s8hEVvNroAUp+keo2RGWQbmsSLEvjC9IeuxmIgDAU13QKVcxWIBPGA2mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AqjvMWXe; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767715717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t86369xywArR21M0qP80o3uJmGeNYRz9FG2Um0ECWo8=;
	b=AqjvMWXekjBYW9YhvMlzGycDZoE/PzDqbvRAHEC21Q4JuTtC1VTUZMxXtZlSmgGgEHS50z
	zWcNBCucR+pevPnkGGz6T0cTmSlqKcsiyfhlcMLjJs6sOK84l99vX3vylUTcOxPzdXr/0z
	ZnsEge36OwNhKKhCgHc2bvRnV8Fn3Bw=
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
Subject: [PATCH net-next v3 2/4] net: phy: micrel: add HW timestamp configuration reporting
Date: Tue,  6 Jan 2026 16:07:21 +0000
Message-ID: <20260106160723.3925872-3-vadim.fedorenko@linux.dev>
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

The driver stores HW timestamping configuration and can technically
report it. Add callback to do it.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/phy/micrel.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index c0aea74a559f..225d4adf28be 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -3147,6 +3147,18 @@ static void lan8814_flush_fifo(struct phy_device *phydev, bool egress)
 	lanphy_read_page_reg(phydev, LAN8814_PAGE_PORT_REGS, PTP_TSU_INT_STS);
 }
 
+static int lan8814_hwtstamp_get(struct mii_timestamper *mii_ts,
+				struct kernel_hwtstamp_config *config)
+{
+	struct kszphy_ptp_priv *ptp_priv =
+			  container_of(mii_ts, struct kszphy_ptp_priv, mii_ts);
+
+	config->tx_type = ptp_priv->hwts_tx_type;
+	config->rx_filter = ptp_priv->rx_filter;
+
+	return 0;
+}
+
 static int lan8814_hwtstamp_set(struct mii_timestamper *mii_ts,
 				struct kernel_hwtstamp_config *config,
 				struct netlink_ext_ack *extack)
@@ -4399,6 +4411,7 @@ static void lan8814_ptp_init(struct phy_device *phydev)
 	ptp_priv->mii_ts.rxtstamp = lan8814_rxtstamp;
 	ptp_priv->mii_ts.txtstamp = lan8814_txtstamp;
 	ptp_priv->mii_ts.hwtstamp_set = lan8814_hwtstamp_set;
+	ptp_priv->mii_ts.hwtstamp_get = lan8814_hwtstamp_get;
 	ptp_priv->mii_ts.ts_info  = lan8814_ts_info;
 
 	phydev->mii_ts = &ptp_priv->mii_ts;
@@ -5943,6 +5956,7 @@ static int lan8841_probe(struct phy_device *phydev)
 	ptp_priv->mii_ts.rxtstamp = lan8841_rxtstamp;
 	ptp_priv->mii_ts.txtstamp = lan8814_txtstamp;
 	ptp_priv->mii_ts.hwtstamp_set = lan8841_hwtstamp_set;
+	ptp_priv->mii_ts.hwtstamp_get = lan8814_hwtstamp_get;
 	ptp_priv->mii_ts.ts_info = lan8841_ts_info;
 
 	phydev->mii_ts = &ptp_priv->mii_ts;
-- 
2.47.3


