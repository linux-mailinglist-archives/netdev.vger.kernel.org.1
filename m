Return-Path: <netdev+bounces-242745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 178B2C94763
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 20:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4B87D347AFB
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 19:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A734031195D;
	Sat, 29 Nov 2025 19:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rnKdoGC0"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF8830FC03
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 19:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764446052; cv=none; b=AQWgSTMFqm1b7vOi+DQMWT2WEBJEODRbY38QCkudnXVzeh2uVDAKtOicksnkwhtyZGDBv82VmbaM3h2qdqOPzVRwut5+1rdcnNadf7kU8lrZhhCQLVoTtWV+2N1tV4XF1mZnQvgSRXC5b2DjTgFI7zBeakRUnGEH4fi+YoHcmpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764446052; c=relaxed/simple;
	bh=ASphiISnSqITH6lfMI4CpFFKU3s06qaFKQZ4j5VqmhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1HwR/+2UlxBR3kZxs0Yln+MJeXAyALylfEPT+0qqNXAEtMSiK1VbduY/C06K1oIe40j9qs46EX9VgorqIpG80WWCvtXwwlrVigP7XBJannpiPB7zHbROzgWFed2PxKsOkXPAFVEgO6/9u8JtsYNG21laqXOKr/33RhOe8ffA4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rnKdoGC0; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764446046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mPuelrv56pjFN3//16Dfuw4rpqtFcTSeUYrWOSAcUHM=;
	b=rnKdoGC0JYsEx3SdKjLmWUKU6MAzrUbmANuYCsyIk984yP/d9XUNmE2hbAoW8pjzGH3AG9
	ZI6mhdgre15Y2vjR3JWKtKVI0i8bxZn4DZ/GYhG1ovQgSDJRnm0i7d94DKamavNig7mcwz
	dCXxqrorS9fLw7rLFYKNlthJZOjEHks=
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
Subject: [PATCH net-next v2 2/4] net: phy: micrel: add HW timestamp configuration reporting
Date: Sat, 29 Nov 2025 19:53:32 +0000
Message-ID: <20251129195334.985464-3-vadim.fedorenko@linux.dev>
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

The driver stores HW timestamping configuration and can technically
report it. Add callback to do it.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/phy/micrel.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 1ada05dd305c..b48553edbfa4 100644
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
@@ -5934,6 +5947,7 @@ static int lan8841_probe(struct phy_device *phydev)
 	ptp_priv->mii_ts.rxtstamp = lan8841_rxtstamp;
 	ptp_priv->mii_ts.txtstamp = lan8814_txtstamp;
 	ptp_priv->mii_ts.hwtstamp_set = lan8841_hwtstamp_set;
+	ptp_priv->mii_ts.hwtstamp_get = lan8814_hwtstamp_get;
 	ptp_priv->mii_ts.ts_info = lan8841_ts_info;
 
 	phydev->mii_ts = &ptp_priv->mii_ts;
-- 
2.47.3


