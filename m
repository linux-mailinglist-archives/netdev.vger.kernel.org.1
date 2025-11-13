Return-Path: <netdev+bounces-238312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BF6C5738D
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 72D9434CFC9
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0EA33BBB1;
	Thu, 13 Nov 2025 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oG7OR4sx"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B3733B943
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 11:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033560; cv=none; b=kkoNT6q0BVdgq+05AyJWcoUupvV3KQt8/frnCeCBoVZ7mV+Qo5d6Fc9snFfnSO12sl2oy/vPR80Z6/fxGfdpXPemQP1iNevGmhM5sH/CG7g86O+TKjIjeP3dr+0rkw0QuILfjrqqtTdE5NBxs8Qh5/K5RIFecZntObsoEOYkzaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033560; c=relaxed/simple;
	bh=9kqR75Rm7xAyXMp2bU67Frn84D/xTapSOkmmETyenAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYnM181ftM2Srj7lmVrha2LGoIa7ohbAUuS8sv6hGTDRx+NhhHgViMxo2yBegfj8bGcB7wcrMsh04yG4CvfkipP2tudUGY4YG/8pyFJwgpMgQa4AxWoCfoKEMTDmPQVLyN6bwnPnpApEvaO4HTa0kOHCpy7Jv3nhtbqU7L+Wp6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oG7OR4sx; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763033556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t7DmaBU3wFK5HLBIMy94QrsJfR5bcX/8ZOoykoqqi/Y=;
	b=oG7OR4sxQImVbAJ0sg8eIGWyNcERPAHNBWqr7cuwOEyWLY+RPz4DxRaGHwNTD7W/CEf2LT
	UZcteQGkBZFzXdeVZFpXM2+YMoZ63jqbE3Br3YN7lzxwd3HcR/z332WzWCgObNbrUipoM8
	L/w60ir8jAlvlyaWHZCE6fmWWDjnc/k=
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
Subject: [PATCH net-next v2 3/9] net: phy: broadcom: add HW timestamp configuration reporting
Date: Thu, 13 Nov 2025 11:32:01 +0000
Message-ID: <20251113113207.3928966-4-vadim.fedorenko@linux.dev>
In-Reply-To: <20251113113207.3928966-1-vadim.fedorenko@linux.dev>
References: <20251113113207.3928966-1-vadim.fedorenko@linux.dev>
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


