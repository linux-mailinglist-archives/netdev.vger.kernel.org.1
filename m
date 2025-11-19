Return-Path: <netdev+bounces-239979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42026C6EA3D
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ABEC0387426
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 12:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF41B35F8D0;
	Wed, 19 Nov 2025 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hux5cFyz"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7FC35B13C
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763556526; cv=none; b=GvjwETk+We6yzNfgWxSwyOMGyikqG5IHwELEANyxBrIJ/873PdYGSi7NWfH16u7rKCPF2L5sF3kwM52VO8JQruagxoscAfNWSdPp6kLYaWfehpYeE7Qmuh4TyIRa4xU9mctsnKyRrkjWM59CQ0ZmbNRMZ14csvqHDx5xSZTuu9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763556526; c=relaxed/simple;
	bh=YtVQU2/dR/HMmHbX1xQKNnEPAKmqJq9hCsPN6LU/NZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=taCeY48S2F3KhfRzw9LPBni2PQdKwjjHA61AMMMCU9EmuWOU9Y1uhU/gjMoXMmM95cH85fw/ehuh7u/1cwdWNgy33h/Le3+5KMj2ZkhzbjN46uv7VacpHJQoTlM5mfzbiGxu01eH2IXQb7KQC/7ROspGNyFapWWMZ92kAvqAA9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hux5cFyz; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763556521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rs0QW+z5X48n3fVCzgY8RZKxvf5A6SWguiEqCblviR8=;
	b=Hux5cFyzSd0VmGiVa+5XyMyhdUe5aJu6xFZnF0ilqcps0yVVRMdr2qkiMAPBkEUdeGcOFN
	NrvmbhNj9kGVGGKghImHcI47ixYA0LKe/mSUGvkGQ73PwhzAB4hZ+s1U6TbcoY1+xQ6O47
	u9v2TjRvB34dkQWqKZIUzfwPODEMBX8=
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
Subject: [PATCH net-next v3 9/9] ptp: ptp_ines: add HW timestamp configuration reporting
Date: Wed, 19 Nov 2025 12:47:25 +0000
Message-ID: <20251119124725.3935509-10-vadim.fedorenko@linux.dev>
In-Reply-To: <20251119124725.3935509-1-vadim.fedorenko@linux.dev>
References: <20251119124725.3935509-1-vadim.fedorenko@linux.dev>
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


