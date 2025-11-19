Return-Path: <netdev+bounces-239977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97754C6E97E
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 13:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 4A6352DFA4
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 12:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34AF35A959;
	Wed, 19 Nov 2025 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XaluQ3ka"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AFB359FA6
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 12:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763556522; cv=none; b=MCA3qcRAaz02xZlcQHE5zJb+Wp6fCOvp1C9u5fibsSMaA05w9ow56XCtfBdf4dr9UOITYXU9RH+gJA8iqY8rv419uv2f4auaL/SqQ0FQjrHs81CBkLj6JEvYENTX1NEMh/luGgtK+R7/19lJMgBR8R+7S9xrpMH3vuZq4gv8IyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763556522; c=relaxed/simple;
	bh=bxVbhB3Xpxg6h/78Bav5kxHJdxPV43hQH1Rn7DRhIic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5KyvmU13ukW4tII5LbCNp6m3bg8I3eRTyJmaXJwneHfuHYJ75TUpJR7bn0fuDnPxcKdJ/2sjkZpicfEMBj5iFxChoPzHgFA4qjzm0NrFp2lNxPVmfsPZPBE+Amsi3ZbkT3TQN/CI29A81vbUMKu9nenVJ1TRHRIAniCaCzyCeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XaluQ3ka; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763556517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UOywNwMO+bUoAh6RkCQsVOwjv0CLdPeWO2+VXHpQY0A=;
	b=XaluQ3kawpzjb4O1tei7YwX7N4kS0Ev2Jug76Phpxi0IeA3xEF9lcp+GNHU9MUkZN2DnKB
	TPqKrsJRGfAyK2A/urDw78cW1PkFaEsuh+V7WcqbJITdfsveteYZK6uSvMSji9kVA4bune
	2d752MCd9Cqls51gSq8W5XWC2qYSyQc=
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
Subject: [PATCH net-next v3 7/9] phy: mscc: add HW timestamp configuration reporting
Date: Wed, 19 Nov 2025 12:47:23 +0000
Message-ID: <20251119124725.3935509-8-vadim.fedorenko@linux.dev>
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


