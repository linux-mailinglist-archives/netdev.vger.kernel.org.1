Return-Path: <netdev+bounces-242409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8F6C902D4
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 22:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C17E3AAA02
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 21:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70833191C2;
	Thu, 27 Nov 2025 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jAEANarw"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC042D77FF
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 21:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764277990; cv=none; b=hKs400gHBnqye7in9MhDsV6ZjX28P/kw9yARuPtsqLrUkDZ7eHBQtF0TbO7lq/ETr0b7wxKocXb9UEcLnsm+HNLGeIsh2RiRUaV5182bIgMaL1bhkzL4o/DDCLOKDUA2F6SBaF4aaDYD/tzvPBx5Vub0qPgPRzO3lZoy97tNGjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764277990; c=relaxed/simple;
	bh=qF1OfxGnOUXYDn5jlTg7lG+gAELhr88oJTB32+p5+ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apTBeU49l66dHnmacCgt3Tb0fgtVyqYsQaKCvEyAaeJsbsHh5K/5lc3HB1EWLr13l6ZSZZudTEFNplYSYUqr4w6qlv5cAhAcHxbh74To7PmtgUNMgFmQ5TPTmNZz0v8T6oXzawR9Ig9S33ti21TXm/yq6z0p32m89tAhMWJbdwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jAEANarw; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764277986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NoNwb6F3TeH/x8JrjLl22JdK9hkCQTeCOCJMnJQ7Crk=;
	b=jAEANarwc6VeEupBVOYVtbG1tfOw3p4Vz5WcISRoS6Dyk1IwLpHy9jl7LSgGJi4bwcjF8p
	s6mBJAqSO0ep38IwfbwYQXp17s+3ZO7cDMFZr3Yph9HgRi+DgCIdN9u47le29cN4WIMffC
	qleTcBHbH0YE5vmA7w3WJfHx8ssaEZk=
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
Subject: [PATCH net-next 1/4] net: phy: micrel: improve HW timestamping config logic
Date: Thu, 27 Nov 2025 21:12:42 +0000
Message-ID: <20251127211245.279737-2-vadim.fedorenko@linux.dev>
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

The driver was adjusting stored values independently of what was
actually supported and configured. Improve logic to store values
once all checks are passing

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/phy/micrel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 05de68b9f719..2c9a17d4ff18 100644
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
@@ -3187,6 +3184,9 @@ static int lan8814_hwtstamp_set(struct mii_timestamper *mii_ts,
 		return -ERANGE;
 	}
 
+	ptp_priv->hwts_tx_type = config->tx_type;
+	ptp_priv->rx_filter = config->rx_filter;
+
 	if (ptp_priv->layer & PTP_CLASS_L2) {
 		rxcfg = PTP_RX_PARSE_CONFIG_LAYER2_EN_;
 		txcfg = PTP_TX_PARSE_CONFIG_LAYER2_EN_;
-- 
2.47.3


