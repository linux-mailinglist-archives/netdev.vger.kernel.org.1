Return-Path: <netdev+bounces-110287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E07492BC10
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 15:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5EF1F21948
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 13:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D532018EFC9;
	Tue,  9 Jul 2024 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nPuRXSPM"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693E31822F2;
	Tue,  9 Jul 2024 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533243; cv=none; b=rP0AoOAZHZzFbn1zhxDgMKBs0QuJhbhS6M9V92Zq0S+RaYBL6EXhcmO+g3U7bK4ssTso321fGZ89LUJxcHwEZvTb/8B6i4XnqN29BY3H0iJPYq6uYenKU/PKdic1cjLIR26f0JYOm7lG3jE+v8cxGCbp4BNpEjHhccJeveCptdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533243; c=relaxed/simple;
	bh=W1tC5xJk4Wrts3EnwFmCQeU3EfX1KmwXtc0NbYeo96Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rs9ls6fg+p8z9KgBIMX9IcWqEfldIWCU9QH3rbEhHjJ7ukDMIMQ4APGr6ok8V6O2d4631kWQCcfSKbXcSw9pRK0Nt54I2pfrMQruzh868in7RjUreu8fHO4y0Q7dfCby711bg0Kxyb80z6eUUMYZCbwtBTlIbEOw7EdTIeSUPa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nPuRXSPM; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 25D431BF211;
	Tue,  9 Jul 2024 13:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720533239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bMtj1UK9293PQ7bYkd4UcBMlUztaA9CiGQ2VZIkJZAo=;
	b=nPuRXSPMVXRx7tGwBIP/o+xmxWXlhv5rsJmAFqrqnWqNhLXaG5pb3v7pI2bpNu7LizSwb/
	ctcUBxmy6GnBnx4f/Gxef/9lTjvK1J3ZmAfSjM9PiSon4EGPSzwPXwTJk/z0qIPo55fSyQ
	akIqyj154zIuhjmZDVtECduDbjaK9yqzI1khJw75TCG+RHL25SIDxEu7JMXOrrGd2EbnMr
	oV2Z5UD745tRa+9Ofq2wzwm3LzkaUqPCS3/zO1R+M3YpUg9RskqIhmgNGrhSFrRYTpx1S9
	1KY/SZJXrBuUlj6lmMKIaB19+dtHhN0GQiZ/TdkPqHHpmXtqliOHbMou4kBeYA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 09 Jul 2024 15:53:34 +0200
Subject: [PATCH net-next v17 02/14] net: Make dev_get_hwtstamp_phylib
 accessible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-feature_ptp_netnext-v17-2-b5317f50df2a@bootlin.com>
References: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
In-Reply-To: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, 
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
 donald.hunter@gmail.com, danieller@nvidia.com, ecree.xilinx@gmail.com
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Shannon Nelson <shannon.nelson@amd.com>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: kory.maincent@bootlin.com

Make the dev_get_hwtstamp_phylib function accessible in prevision to use
it from ethtool to read the hwtstamp current configuration.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v8:
- New patch

Change in v10:
- Remove export symbol as ethtool can't be built as a module.
- Move the declaration to net/core/dev.h instead of netdevice.h
---
 net/core/dev.h       | 2 ++
 net/core/dev_ioctl.c | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.h b/net/core/dev.h
index 5654325c5b71..9d4ceaf9bdc0 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -187,5 +187,7 @@ static inline void dev_xmit_recursion_dec(void)
 int dev_set_hwtstamp_phylib(struct net_device *dev,
 			    struct kernel_hwtstamp_config *cfg,
 			    struct netlink_ext_ack *extack);
+int dev_get_hwtstamp_phylib(struct net_device *dev,
+			    struct kernel_hwtstamp_config *cfg);
 
 #endif
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index b9719ed3c3fd..b8cf8c55fa2d 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -268,8 +268,8 @@ static int dev_eth_ioctl(struct net_device *dev,
  * -EOPNOTSUPP for phylib for now, which is still more accurate than letting
  * the netdev handle the GET request.
  */
-static int dev_get_hwtstamp_phylib(struct net_device *dev,
-				   struct kernel_hwtstamp_config *cfg)
+int dev_get_hwtstamp_phylib(struct net_device *dev,
+			    struct kernel_hwtstamp_config *cfg)
 {
 	if (phy_has_hwtstamp(dev->phydev))
 		return phy_hwtstamp_get(dev->phydev, cfg);

-- 
2.34.1


