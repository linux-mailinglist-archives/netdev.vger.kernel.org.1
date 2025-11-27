Return-Path: <netdev+bounces-242412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F10C902E0
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 22:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8485A4E62A3
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 21:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA99309DA1;
	Thu, 27 Nov 2025 21:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VkvdXbUL"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FF131DD96
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 21:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764277994; cv=none; b=ZJ3RLSrDiTiNornpxHOc+Otl2Yv2QTNbMHmOHGGpdsOsFJq/UmfSdJTdAcgtJ8/18YpHktPrKeBH8EDn0i8UMDX6KGH5F3LVKAqhtyNGQ14vxoOB5bMvDmHnLaWCrlvDuK1nAxH/jOLcEPqtWYKTPy9GwSrNMtxilIiFAaG5kOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764277994; c=relaxed/simple;
	bh=HywE0QBcpJK94TKIdFY/HnZ45J6f/UnfagSfWvNcZ54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+t1FsfbVp1QtXINZb2pawSSNnafE+z5bjuhQvjY6hu6m0Oa7EmmYrELJjYqBHhfkMWaqfgPttDvszah9sLdbaWGq3v5xxYc+B1fTHfQa23s3CmW/KJ3I6nOajv3DTx+JO6mPj6SvafMojtaP/EKQWIwjV9tzuUCibYnaDWrS6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VkvdXbUL; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764277989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DB+KuPs2/E0RWnis775CpvnHtYOVvqqdW0jnvvVlzhI=;
	b=VkvdXbULvvuhx/y4BdqP6GuuQ2nV0O/8WlMGcNdOq+L+IEr1kClwnMfObWRdocs6dZpu2S
	Akl5fyDbhsSkk4PAf3v7PU0tWUUTo1GM7E9UtkiD3717XZv93fzE+R8cFANdOzYztm6YhQ
	VY8MMMylfBjCLlesfyXKUiP1oKItx4E=
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
Subject: [PATCH net-next 4/4] net: phy: microchip_rds_ptp: add HW timestamp configuration reporting
Date: Thu, 27 Nov 2025 21:12:45 +0000
Message-ID: <20251127211245.279737-5-vadim.fedorenko@linux.dev>
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

The driver stores HW timestamping configuration and can technically
report it. Add callback to do it.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/phy/microchip_rds_ptp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/phy/microchip_rds_ptp.c b/drivers/net/phy/microchip_rds_ptp.c
index 6b0933ef9142..46d145b0badf 100644
--- a/drivers/net/phy/microchip_rds_ptp.c
+++ b/drivers/net/phy/microchip_rds_ptp.c
@@ -476,6 +476,18 @@ static bool mchp_rds_ptp_rxtstamp(struct mii_timestamper *mii_ts,
 	return true;
 }
 
+static int mchp_rds_ptp_hwtstamp_get(struct mii_timestamper *mii_ts,
+				     struct kernel_hwtstamp_config *config)
+{
+	struct mchp_rds_ptp_clock *clock =
+				container_of(mii_ts, struct mchp_rds_ptp_clock,
+					     mii_ts);
+	config->tx_type = clock->hwts_tx_type;
+	config->rx_filter = clock->rx_filter;
+
+	return 0;
+}
+
 static int mchp_rds_ptp_hwtstamp_set(struct mii_timestamper *mii_ts,
 				     struct kernel_hwtstamp_config *config,
 				     struct netlink_ext_ack *extack)
@@ -1284,6 +1296,7 @@ struct mchp_rds_ptp_clock *mchp_rds_ptp_probe(struct phy_device *phydev, u8 mmd,
 	clock->mii_ts.rxtstamp = mchp_rds_ptp_rxtstamp;
 	clock->mii_ts.txtstamp = mchp_rds_ptp_txtstamp;
 	clock->mii_ts.hwtstamp_set = mchp_rds_ptp_hwtstamp_set;
+	clock->mii_ts.hwtstamp_get = mchp_rds_ptp_hwtstamp_get;
 	clock->mii_ts.ts_info = mchp_rds_ptp_ts_info;
 
 	phydev->mii_ts = &clock->mii_ts;
-- 
2.47.3


