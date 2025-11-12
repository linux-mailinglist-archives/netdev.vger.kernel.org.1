Return-Path: <netdev+bounces-237773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F31C501BC
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 01:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 658964EEB13
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 00:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB2212B93;
	Wed, 12 Nov 2025 00:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E/Qm23oS"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4925C2E0
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 00:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762905818; cv=none; b=hso8khYsOjj3Ng76dEDH17ML9qSMUKZl6ZnNsAXDn9y0zfllgFliFgkM1VSF9RkEdRpzU5irsWmEdKmK+6w3muszJuudgId52GGrJn9nGIEYiVjxA+BaPLbXXjUVTLzDDgxZvqaYP95daH7BQcesH1erY84Qv00WPnfFr82M/Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762905818; c=relaxed/simple;
	bh=YtVQU2/dR/HMmHbX1xQKNnEPAKmqJq9hCsPN6LU/NZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9s279f+BVuDkciT737wrFmSdoQ9g9EbyFZLo1K0cPMIlV9s+URwSecVeG3B0MPxixWv8FSzkL8UReWGdOjPw0LkxGfIhsZ2I0UxQ1iw3bYNvSdyrqNeU6k3GHTGA5bSshPyKf3dgpMFrLptJViVXBHu62pG6+5odCdZEFm+muM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E/Qm23oS; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762905814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rs0QW+z5X48n3fVCzgY8RZKxvf5A6SWguiEqCblviR8=;
	b=E/Qm23oSJOt90/k36y91Z2JZ/YaBXNa8Su7YDTUE0r7YMGrFlQYAOj963KbBEG/ajaBgxk
	BkCXCo3u5QzX9EyE0qfAis0Hi5sC6uROphPcwfTY9JgNeDjvfRR1Saaeol9+rJieLTvHNP
	Pg8F8j69ST97cE0Iskb7VvBZu4D5xXQ=
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
Subject: [PATCH net-next 8/8] ptp: ptp_ines: add HW timestamp configuration reporting
Date: Wed, 12 Nov 2025 00:02:57 +0000
Message-ID: <20251112000257.1079049-9-vadim.fedorenko@linux.dev>
In-Reply-To: <20251112000257.1079049-1-vadim.fedorenko@linux.dev>
References: <20251112000257.1079049-1-vadim.fedorenko@linux.dev>
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


