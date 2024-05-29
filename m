Return-Path: <netdev+bounces-98943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 641C78D3348
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 11:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197041F25F7B
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 09:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC23716ABEE;
	Wed, 29 May 2024 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PHxHKtPh"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9205316A37A;
	Wed, 29 May 2024 09:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716975705; cv=none; b=PjObq8t6oJ//yqAkFo/sdONrameLUAs+72RfixHW4QOmfDDEGM1vz6muO24DQ9faIzVcLzJ/SegmIyaxAQW5YAPWafGM7otfSE9VAs6QTedEXh50Qf5da5+Pug7cr1s/UfcZoAxpBP/OrABZVPM2HnY7o+iAqO3ocVkrguIT7y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716975705; c=relaxed/simple;
	bh=gnOJv3IJnG4MxVBS3Rs8JRq/t9ZNB4Rqjtb6Bc5CGuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OujwfP3/4m24R7DVjyJQKgFW+BwhKOCGHBNnDkZ2cL/11z1FGdQtlbmlp6dxtzJXymk/zu0jIx2S54kk12OSIHG67TISQp+NPma96bE+NBv809UGFqegp/PInJ/pAKFIHJRplvKm/evJDzEgs2ZH2jhT2iNYn3ul1VnClRVWSTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PHxHKtPh; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B87FA6000B;
	Wed, 29 May 2024 09:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716975701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KUn20jBzGgQX3nN2BNPFK9rn+KLdbsza5Fx8uyTOtm8=;
	b=PHxHKtPhvyFheEhGJqYy80zSeICNjjbrij222ku3aAvpg30KFtiSlk3o6WlMR3U3vUWhi/
	vmhfXFTzGxgTNFD4xe81LaRH4nL3yP5//gSjqvQoHhoLwyWHd3b/GKwbrx2+qKX1153J5R
	66qJwHFRDZVALEF3+N+o4E+DySD5VvH4aP7lkAl+0jqdQH7BKcvIshMzZgfUich2D5EFtp
	N3flxV8BKOtIXRZKJGf7nySBIAreG8U69KqKTdKhGL9qF7RL3bzMwhMAiagpe0fDOxQSkN
	M5ay6V0Tx5vzqvo3nWfnqt3rCUrW4CChGBenYC6DXf/ZF0mjN/KD/S8H7PbMpA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 29 May 2024 11:39:36 +0200
Subject: [PATCH net-next v13 04/14] net: Make net_hwtstamp_validate
 accessible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-feature_ptp_netnext-v13-4-6eda4d40fa4f@bootlin.com>
References: <20240529-feature_ptp_netnext-v13-0-6eda4d40fa4f@bootlin.com>
In-Reply-To: <20240529-feature_ptp_netnext-v13-0-6eda4d40fa4f@bootlin.com>
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
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: kory.maincent@bootlin.com

Make the net_hwtstamp_validate function accessible in prevision to use
it from ethtool to validate the hwtstamp configuration before setting it.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
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
index 75094405b569..7e2425326170 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -171,5 +171,6 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
 			    struct netlink_ext_ack *extack);
 int dev_get_hwtstamp_phylib(struct net_device *dev,
 			    struct kernel_hwtstamp_config *cfg);
+int net_hwtstamp_validate(const struct kernel_hwtstamp_config *cfg);
 
 #endif
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index b8cf8c55fa2d..6aaa8326bf8f 100644
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


