Return-Path: <netdev+bounces-241256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 14493C820A6
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 19:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 043A84E74A5
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 18:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4682C11F5;
	Mon, 24 Nov 2025 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mm4a8Qvr"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76301318146
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 18:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764007956; cv=none; b=R7tAP4eLK0ednE7yel+RLR92aEaE90KVSr/L0qVOHxQoStM/49VCt5CjxP8xOn/BLcL5HBW/Yn+aWF/8ps79G7OzwcXMTP0bS0mUue9miErCG7Qqnudkk5Wp5TJNwV4vQyymXj4fwkFFgTeysHHP3vGViyPRus/NY3RQaVDdExI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764007956; c=relaxed/simple;
	bh=uttRoXzq6IAoqGtcFw8a2WYggVEpEqICLYi38St9lgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQbrcFEGOxdW4FC4nIw5PDBSr408sQyZ/zO0iGLT1hGPznVI3KAfWIxs3bSLst2lemmCui8qs6mUN3rB4n2XhQ4Yr7wtBx/J1OJL16v5Yj84OxgCDdB8/oC5DZTPeV19UfQ7nqL0WOrIs3g/ozrOjBuhPwfkUqSQCMQcYSmU5f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mm4a8Qvr; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764007952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p3IhDbVgOwLXjxPjHY24H6omlGzE6uS6sIRjUBjWfoQ=;
	b=mm4a8QvrxYWIqlBj7DFpf4zN0SXNEZTXQNXV+TBc+N/oY/5njWAHw4COXYmvcqvvdYKzu4
	GdL8qmNjQPM9MG8NdisIu9V75w7mMtKUvD2dqGL/HVFi8c3IkHA8Chmsx/JCTRaV/TswLP
	QDDIGEORul3q5aA6djqMFbjmz4Z9yqY=
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
Subject: [PATCH net-next v5 3/7] net: phy: broadcom: add HW timestamp configuration reporting
Date: Mon, 24 Nov 2025 18:11:47 +0000
Message-ID: <20251124181151.277256-4-vadim.fedorenko@linux.dev>
In-Reply-To: <20251124181151.277256-1-vadim.fedorenko@linux.dev>
References: <20251124181151.277256-1-vadim.fedorenko@linux.dev>
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


