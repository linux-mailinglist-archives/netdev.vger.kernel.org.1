Return-Path: <netdev+bounces-238316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD2FC57355
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6155D4E512F
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2432933E36B;
	Thu, 13 Nov 2025 11:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c7BisnB4"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360832FF648
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 11:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033572; cv=none; b=OkmUb6AFu5H+LzBe+PuJmLumBX7MXL3zp1gKZczCdUn0qxf3oGEgcmp0lD9ZZABk1tFhzuY+27eKTiG2ppwaXaRtPGwkrn5R/hpAILh1Ean1jMtQhzVcHdxEWBsL00C03olFkR4qbrGyf7r36MrrGgfl0c/GXMaG6GfqcZMEqcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033572; c=relaxed/simple;
	bh=bxVbhB3Xpxg6h/78Bav5kxHJdxPV43hQH1Rn7DRhIic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kw+6g4taMom3XZUTs0qX8SX7yS7N3K2jOLYNWu0Rctj5ye9V3f0N+uesgX4XF8luds/JLvhSXaChWsGEi9iRKQOXEVLxErkovr498HYfNr2UvQNzhf0g2e+uFdA4hHK3nzcRKzxs+NxivzHTqJz+49qk4Kj0Jx//R0ukkD0+ax8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c7BisnB4; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763033568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UOywNwMO+bUoAh6RkCQsVOwjv0CLdPeWO2+VXHpQY0A=;
	b=c7BisnB4NXkk7gtN+xvt6egYUALKNhHyRPIh8xPN0wVRZS/sVw89LYNLIAkIfmzQpXF7sW
	EKUAUFeKGEUYXrT+jdX/vQ+g/HKvRBrburod3+D1VcF8bIIL+sfyie3A7miD/NZf7/CUVT
	mqY3r/LnE1R2TnV6wqDUnnhWSYiV05U=
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
Subject: [PATCH net-next v2 7/9] phy: mscc: add HW timestamp configuration reporting
Date: Thu, 13 Nov 2025 11:32:05 +0000
Message-ID: <20251113113207.3928966-8-vadim.fedorenko@linux.dev>
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

The driver stores HW configuration and can technically report it.
Add callback to do it.

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


