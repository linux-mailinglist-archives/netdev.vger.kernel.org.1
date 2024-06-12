Return-Path: <netdev+bounces-102907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC87E905640
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 17:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA96286CE6
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 15:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C556317FAC7;
	Wed, 12 Jun 2024 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DhGsknc2"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A4117E90D;
	Wed, 12 Jun 2024 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204705; cv=none; b=ZSjtm78sZuX4M2pjGCyP21ONpWmHpELLCyjsM2qOGQtG791SJ7ys4f0m+nAeCWOrAz7LWBvpDO48QawxTPxeKKAue/M72GEFba1yuwBHXil024RsPrsPvALKB1ZeP2JTyht/oRAlbeQSMkGC2tpyF1HrVXoxK1onI/Qw8QOgRa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204705; c=relaxed/simple;
	bh=IjMflVvqVRERvYARWe4LKlkVuXmMgcYCDaoitd2X9iQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KmwSb5/aOG5uMkrrlfDy8twXrVdYGgLsHejNChSztjqP1WS4fm0HFNzrgzIuIfBU3xSEohXm+bp6Sdu776THd44xZa/hW5o0zfoyG7DPFwdS/H5rAN/axr/GkL9okHPfkYeWkegVi4F1BTtuAWyR4SrUIJcjZ4jId02P5V2k7ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DhGsknc2; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E006740014;
	Wed, 12 Jun 2024 15:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718204701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HrY8w0IMosIqtvCpNeKN+wcauJqxms1gGg8T+SvT1J8=;
	b=DhGsknc2iMg01U1I3UsOtw472sE1E4CIKYFjVUUfh9i9VX4pvSaSemxyCFIvToUp/T81Be
	xuer4IPVSBXdH0pqCjF9pGjBSDKm4r70V0m6J4u32xNsRd3RHT+cNxYr4pR1Zz8oUgzLyI
	ptBBYTahOp94pszWCdVhu57X00E0+LaDrRiMVj9Bx7q5Rq9tHQTGFQKid4/vi69vp6y+Mz
	J/+dw7VvWWkuidwO8QNkruKaU4InhdZa261b3JYWSkrEqRPXn8fsY3ZvlDduofjr+U9I+8
	n2B7JFThTUfuNiAPENiuMW58ApiVG23dpvSnG9lIfRBjZ1OpsU3j+gtEmXwRPA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 12 Jun 2024 17:04:06 +0200
Subject: [PATCH net-next v15 06/14] net: net_tstamp: Add unspec field to
 hwtstamp_source enumeration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-feature_ptp_netnext-v15-6-b2a086257b63@bootlin.com>
References: <20240612-feature_ptp_netnext-v15-0-b2a086257b63@bootlin.com>
In-Reply-To: <20240612-feature_ptp_netnext-v15-0-b2a086257b63@bootlin.com>
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

Prepare for future support of saving hwtstamp source in PTP xarray by
introducing HWTSTAMP_SOURCE_UNSPEC to hwtstamp_source enum, setting it
to 0 to match old behavior of no source defined.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v8:
- New patch
---
 include/linux/net_tstamp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/net_tstamp.h b/include/linux/net_tstamp.h
index 3799c79b6c83..662074b08c94 100644
--- a/include/linux/net_tstamp.h
+++ b/include/linux/net_tstamp.h
@@ -14,6 +14,7 @@
 					 SOF_TIMESTAMPING_RAW_HARDWARE)
 
 enum hwtstamp_source {
+	HWTSTAMP_SOURCE_UNSPEC,
 	HWTSTAMP_SOURCE_NETDEV,
 	HWTSTAMP_SOURCE_PHYLIB,
 };

-- 
2.34.1


