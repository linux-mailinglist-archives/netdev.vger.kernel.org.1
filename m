Return-Path: <netdev+bounces-42671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F57E7CFC99
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 16:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05491C20E60
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 14:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1674B2FE15;
	Thu, 19 Oct 2023 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Mj1rEvY+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B782FE29;
	Thu, 19 Oct 2023 14:29:50 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3C9132;
	Thu, 19 Oct 2023 07:29:48 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8E27D6000D;
	Thu, 19 Oct 2023 14:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1697725786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xcMHe82tB7onpVbG/YH4HQ63t03Vfz3gc/mKWRc+CAI=;
	b=Mj1rEvY+y6c97LeiJ2aCQ/W/aC/HeGclbsg4EspJoHEgpIAACq3Mpda53p7I5wxKZlAs9w
	bsxUvzzRDGtF6oHQizZbLhJMLOfoDYPIzJvoK8CPGaxp8BHpFP5EdBOBLbwH65wifScv4I
	/KxcRpt6WZyZz4nNjVsaEMIO1YrokxrqCJDrzwYbOBICJ+oQ7CQxFFxjjJ1iQUls7SlZrD
	X0RDIZGlZRrExdzSNQVCKTVkKu7KEax37JM9Y1b05/Fb8Y2h68Tg85d+rkEYUC2frb+bjz
	eXobGMMLRBucwNfweVvuBMOn+OrtWrUHvX8mSdtHxFW7unEKJrRqWE4ga4MS+g==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 19 Oct 2023 16:29:20 +0200
Subject: [PATCH net-next v6 05/16] net: Make dev_set_hwtstamp_phylib
 accessible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231019-feature_ptp_netnext-v6-5-71affc27b0e5@bootlin.com>
References: <20231019-feature_ptp_netnext-v6-0-71affc27b0e5@bootlin.com>
In-Reply-To: <20231019-feature_ptp_netnext-v6-0-71affc27b0e5@bootlin.com>
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
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: kory.maincent@bootlin.com

Make the dev_set_hwtstamp_phylib function accessible in prevision to use
it from ethtool to reset the tstamp current configuration.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v6:
- Add missing EXPORT_SYMBOL_GPL call.
---
 include/linux/netdevice.h | 3 +++
 net/core/dev_ioctl.c      | 7 ++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e070a4540fba..b9d0411836db 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3922,6 +3922,9 @@ int generic_hwtstamp_get_lower(struct net_device *dev,
 int generic_hwtstamp_set_lower(struct net_device *dev,
 			       struct kernel_hwtstamp_config *kernel_cfg,
 			       struct netlink_ext_ack *extack);
+int dev_set_hwtstamp_phylib(struct net_device *dev,
+			    struct kernel_hwtstamp_config *cfg,
+			    struct netlink_ext_ack *extack);
 int dev_ethtool(struct net *net, struct ifreq *ifr, void __user *userdata);
 unsigned int dev_get_flags(const struct net_device *);
 int __dev_change_flags(struct net_device *dev, unsigned int flags,
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index b46aedc36939..cb60b0b9c31d 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -322,9 +322,9 @@ static int dev_get_hwtstamp(struct net_device *dev, struct ifreq *ifr)
  * frames and not forward them), it must set IFF_SEE_ALL_HWTSTAMP_REQUESTS in
  * dev->priv_flags.
  */
-static int dev_set_hwtstamp_phylib(struct net_device *dev,
-				   struct kernel_hwtstamp_config *cfg,
-				   struct netlink_ext_ack *extack)
+int dev_set_hwtstamp_phylib(struct net_device *dev,
+			    struct kernel_hwtstamp_config *cfg,
+			    struct netlink_ext_ack *extack)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
 	bool phy_ts = phy_has_hwtstamp(dev->phydev);
@@ -363,6 +363,7 @@ static int dev_set_hwtstamp_phylib(struct net_device *dev,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dev_set_hwtstamp_phylib);
 
 static int dev_set_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 {

-- 
2.25.1


