Return-Path: <netdev+bounces-47666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1257EAEFD
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 12:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2731C20ABF
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 11:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1518A3E479;
	Tue, 14 Nov 2023 11:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pcoSlQhj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CFE2D62C;
	Tue, 14 Nov 2023 11:29:08 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0BB1BD;
	Tue, 14 Nov 2023 03:28:57 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 590736000B;
	Tue, 14 Nov 2023 11:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1699961336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fTFlVLwCnwNosdSRaYT8M2FlIV0h7hvqkTQ58WCJDWw=;
	b=pcoSlQhjbg9SnMn9iJ0WtD9UD7q1CmUfc7XViSS5jPyQOOB0cEO/sX36IqWGyg4oHIdACV
	qpiQICAexHuSHe5lzuXtOGv77GC4uwlAYr/0CQQRIN2AsztGYW/9nfN69QoXdaS3xIkUyU
	Yzfvh6xDO1UZOy5/MhC3zJ32jFgA031LFVxXQpazqCA8RnXR+s+dNlGBXNkJ08MCOzksL9
	C81RsMYkkuOLQI/m117zipbw/hs1FQ4J0BddIcHMDTxWkIKgTmzivQvTRfQACuP/7meFv+
	MjeteGVNRrBn8xW5Y2VRdmze997Wdrm6xjU+oAajb7xTefOqKvMMgSa9imvHWg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 14 Nov 2023 12:28:33 +0100
Subject: [PATCH net-next v7 05/16] net: Make dev_set_hwtstamp_phylib
 accessible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-feature_ptp_netnext-v7-5-472e77951e40@bootlin.com>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
In-Reply-To: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
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
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

Make the dev_set_hwtstamp_phylib function accessible in prevision to use
it from ethtool to reset the tstamp current configuration.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v6:
- Add missing EXPORT_SYMBOL_GPL call.
---
 include/linux/netdevice.h | 3 +++
 net/core/dev_ioctl.c      | 7 ++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index a16c9cc063fe..2d840d7056f2 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3942,6 +3942,9 @@ int generic_hwtstamp_get_lower(struct net_device *dev,
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
index feeddf95f450..9a66cf5015f2 100644
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


