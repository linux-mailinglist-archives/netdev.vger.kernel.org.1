Return-Path: <netdev+bounces-151455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 867199EF63B
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 18:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A380E189E5F7
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 17:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4F5223E96;
	Thu, 12 Dec 2024 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LmMSw1JO"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645CB222D75;
	Thu, 12 Dec 2024 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023229; cv=none; b=n/t1mT60hgJJgShJuA8Q57hbk4goKzwkqo7YSSClLBKg8Wiu+VBFrgD33kbfjHPcVsZBqLb/2MZSDONsdDxrO+NXNulz3mdvYPq/NgIWFhKHw0tJ/XD/TzP1yOoJGHe1cR+tv+U4zfjpfusSGCzGW6PuDCuZOvHo7NJktgplNGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023229; c=relaxed/simple;
	bh=ZjvHZkc5inY+pRASyJgpQhjoZd37S6DxzdVDTHf6W+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QT2E4/Wn3ElWzOKmMW1AhU0RBhPPeC1cyVxz6xZnufesxc8c9CvgRPa1ow18CbGlk4gukwM1NSUM6y6Dt7wF7Q1b7wuZCkLPF7UGNBdWfn7TznY4UQMgDy1ymMnjXOhsHprNSQ2NWxAmMNN49AqD4mNHPbz2ty94f6uy2j8Pn6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LmMSw1JO; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 92BE96000B;
	Thu, 12 Dec 2024 17:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734023224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMy6XiHeL00a21AbpVvnbAktcJJ0pCxX4TSIpkEjL+M=;
	b=LmMSw1JO3XrnRUJGR/ff9c1mi6Ye10Uv/qCOb5cCedCWwlj+6Wp33ExsypfmByCkwHGKBK
	UcDv9NHpXH26dWSjg84O+z0flpKP4P5u6ClydqVf2bxuu3v/p8UQWkX8w2JsdFUAfgBILZ
	Bu5WiYlCn7G0M1S0oiFO4a56Fvo0ZV1gwm+8rSEScZoqETJuV+3K1V7OBa1SV/AiRmnwJ+
	yY91sPTfXb9U+7AlIhjVyFvRqiYz9jU2uD8cmyQiMb6vlJ7XFleeqqVLJNVnXeGX4osJ5K
	PbRG9/UOlOiepe1mGsMKXkkQ1Ml0sULtXjMAIBzPLLc13Csj0JsMPMjgxb3yIg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 12 Dec 2024 18:06:42 +0100
Subject: [PATCH net-next v21 2/5] net: Make net_hwtstamp_validate
 accessible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-feature_ptp_netnext-v21-2-2c282a941518@bootlin.com>
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

Make the net_hwtstamp_validate function accessible in prevision to use
it from ethtool to validate the hwtstamp configuration before setting it.

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
 net/core/dev.h       | 1 +
 net/core/dev_ioctl.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.h b/net/core/dev.h
index 357543cbde65..aa91eed55a40 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -312,5 +312,6 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
 			    struct netlink_ext_ack *extack);
 int dev_get_hwtstamp_phylib(struct net_device *dev,
 			    struct kernel_hwtstamp_config *cfg);
+int net_hwtstamp_validate(const struct kernel_hwtstamp_config *cfg);
 
 #endif
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 67cf68817f23..1f09930fca26 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -184,7 +184,7 @@ static int dev_ifsioc_locked(struct net *net, struct ifreq *ifr, unsigned int cm
 	return err;
 }
 
-static int net_hwtstamp_validate(const struct kernel_hwtstamp_config *cfg)
+int net_hwtstamp_validate(const struct kernel_hwtstamp_config *cfg)
 {
 	enum hwtstamp_tx_types tx_type;
 	enum hwtstamp_rx_filters rx_filter;

-- 
2.34.1


