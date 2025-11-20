Return-Path: <netdev+bounces-240506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D9BC75CE2
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 18:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4AF33359398
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935A22FB0BE;
	Thu, 20 Nov 2025 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qSLln7UT"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5012264D9
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763660787; cv=none; b=gC/Cro7Ex9WHVxAVmbsg4uhXNJTUyRUS1LGJwzpoaLvzMY9nScVEWMr4Pyf53XHuDNnZUwomVp/RH4JgVrLMXYaB6Z0nAA/aRtqZXC3FOlMRPGUzCgTpwOtYqmaoRbjvEwr8NKro8bgF9383sdxV8pIsIPVBih2PBbgZNTV0pak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763660787; c=relaxed/simple;
	bh=lBVK/NMBG2bbJXTnaPUxiRWjlWIcq3RZlrjt/m91qY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4kcPkqT15DvX6pjWcddDHODVjwOi1iCfwbJj4dKXQjDC1ovcDnBqc9cfZDoWubNILhqvAnewHs5Gjgat8G9nFSzVDGzwfiBRvxzHZW4JqX1HRahljYWur5iy9LFb2JsgunJiArBqlfAzNOc2WsS6my9qLT+PRBC4WoX2XVlFV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qSLln7UT; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763660781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kZA509ZaoFbOnVkSrxC5EzqKdrRmWjn3MZq7DYU5cIs=;
	b=qSLln7UTOjd3jtsxxKtrH+nxvSp6p89iRpYn6wUZf6xpQRG2POAoZjfRi8GscMcbB2mMXT
	b2c5KjumIDDg5kNwfD9MXmuHc4i7FTXw+a+z63tV18YqDUobsgpjCftgzjsNC/wbb1rEMU
	+7fnBBGkXEA14UUTf3T20r5jzhxQKIc=
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
Subject: [PATCH net-next v4 7/7] ptp: ptp_ines: add HW timestamp configuration reporting
Date: Thu, 20 Nov 2025 17:45:40 +0000
Message-ID: <20251120174540.273859-8-vadim.fedorenko@linux.dev>
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

The driver partially stores HW timestamping configuration, but missing
pieces can be read from HW. Add callback to report configuration.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/ptp/ptp_ines.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/ptp/ptp_ines.c b/drivers/ptp/ptp_ines.c
index 56c798e77f20..790eb42b78db 100644
--- a/drivers/ptp/ptp_ines.c
+++ b/drivers/ptp/ptp_ines.c
@@ -328,6 +328,28 @@ static u64 ines_find_txts(struct ines_port *port, struct sk_buff *skb)
 	return ns;
 }
 
+static int ines_hwtstamp_get(struct mii_timestamper *mii_ts,
+			     struct kernel_hwtstamp_config *cfg)
+{
+	struct ines_port *port = container_of(mii_ts, struct ines_port, mii_ts);
+	unsigned long flags;
+	u32 port_conf;
+
+	cfg->rx_filter = port->rxts_enabled ? HWTSTAMP_FILTER_PTP_V2_EVENT
+					    : HWTSTAMP_FILTER_NONE;
+	if (port->txts_enabled) {
+		spin_lock_irqsave(&port->lock, flags);
+		port_conf = ines_read32(port, port_conf);
+		spin_unlock_irqrestore(&port->lock, flags);
+		cfg->tx_type = (port_conf & CM_ONE_STEP) ? HWTSTAMP_TX_ONESTEP_P2P
+							 : HWTSTAMP_TX_OFF;
+	} else {
+		cfg->tx_type = HWTSTAMP_TX_OFF;
+	}
+
+	return 0;
+}
+
 static int ines_hwtstamp_set(struct mii_timestamper *mii_ts,
 			     struct kernel_hwtstamp_config *cfg,
 			     struct netlink_ext_ack *extack)
@@ -710,6 +732,7 @@ static struct mii_timestamper *ines_ptp_probe_channel(struct device *device,
 	port->mii_ts.rxtstamp = ines_rxtstamp;
 	port->mii_ts.txtstamp = ines_txtstamp;
 	port->mii_ts.hwtstamp_set = ines_hwtstamp_set;
+	port->mii_ts.hwtstamp_get = ines_hwtstamp_get;
 	port->mii_ts.link_state = ines_link_state;
 	port->mii_ts.ts_info = ines_ts_info;
 
-- 
2.47.3


