Return-Path: <netdev+bounces-151457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3359EF475
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 18:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC5B28BFC0
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 17:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DFA225A58;
	Thu, 12 Dec 2024 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cV89OMS5"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E8422332B;
	Thu, 12 Dec 2024 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023231; cv=none; b=CMoOIAHIKeScUoPb8osr5k8y+u+eBvB47N0KiO3HaL9LT2LjSknuM/wgsjILdsGjfLUk3dkqFaacnoa9HmlAvyoRr5q7yIO38UUzpmJj+JGzXtXCvrLBS1v2/2eO4FxaEGJTofusNp96TZGi8L8a7aINhWlnaTrUSdIPwtb56ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023231; c=relaxed/simple;
	bh=RYbZJtucpSigeMYPdtI0+z6/SDVinaJQBiQLbpoHf+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dMc66d32WXL2Zj2rp87u0SCDLmJVSDZ08weLHDmnfgmsaa39aiZx3O4DvqWtW/MW42BJnbmQpjQMLy1Dsp9/X3+9Up1SfkEqgOqhmoUV86Fk2v2XUMsBNFmRZ+RN8aCpjRT9SFdyoEyI54u0SbU60dNvMdV7+2LEFxZBwPnSjh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cV89OMS5; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 12D0960002;
	Thu, 12 Dec 2024 17:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734023221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=msvoSwtKy3Xw3ahbD1M7vZdznKOSerhqCQxIPQ0W5ME=;
	b=cV89OMS52qTlCt/+UdMwCBW6+wws6W+ifkEQXgBigBQtF5tnEFhF73J966kyTbGAKYy20t
	ruN4KjmDedMF9YdNZ8NduTH7tJBsRaW+tzg5m8aT/kikAVH0U+1+oenvp4LbekRRF3vVx0
	r2EZsTVVqyQSHNSak+8kmB6/k2AejneFgfXFrKuBeCXoV+9V1J+IqqvClTB4bSFsZxTYxo
	VVmhhFNcsS8pizgaeLfJ3mfGzQlEspxZpg4pI7IVaUQ/PGlibi5AftldkM2qGPUUJgq734
	LKchRU1/oj2WWg99vQGsgnpU9+j2uiqzC+GzBPZEwkdEq4CB2tkZj3K5Ys/qmQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 12 Dec 2024 18:06:41 +0100
Subject: [PATCH net-next v21 1/5] net: Make dev_get_hwtstamp_phylib
 accessible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-feature_ptp_netnext-v21-1-2c282a941518@bootlin.com>
References: <20241212-feature_ptp_netnext-v21-0-2c282a941518@bootlin.com>
In-Reply-To: <20241212-feature_ptp_netnext-v21-0-2c282a941518@bootlin.com>
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
 donald.hunter@gmail.com, danieller@nvidia.com, ecree.xilinx@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Shannon Nelson <shannon.nelson@amd.com>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: kory.maincent@bootlin.com

Make the dev_get_hwtstamp_phylib function accessible in prevision to use
it from ethtool to read the hwtstamp current configuration.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
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
index d043dee25a68..357543cbde65 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -310,5 +310,7 @@ static inline void dev_xmit_recursion_dec(void)
 int dev_set_hwtstamp_phylib(struct net_device *dev,
 			    struct kernel_hwtstamp_config *cfg,
 			    struct netlink_ext_ack *extack);
+int dev_get_hwtstamp_phylib(struct net_device *dev,
+			    struct kernel_hwtstamp_config *cfg);
 
 #endif
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 46d43b950471..67cf68817f23 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -266,8 +266,8 @@ static int dev_eth_ioctl(struct net_device *dev,
  * -EOPNOTSUPP for phylib for now, which is still more accurate than letting
  * the netdev handle the GET request.
  */
-static int dev_get_hwtstamp_phylib(struct net_device *dev,
-				   struct kernel_hwtstamp_config *cfg)
+int dev_get_hwtstamp_phylib(struct net_device *dev,
+			    struct kernel_hwtstamp_config *cfg)
 {
 	if (phy_is_default_hwtstamp(dev->phydev))
 		return phy_hwtstamp_get(dev->phydev, cfg);

-- 
2.34.1


