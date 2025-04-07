Return-Path: <netdev+bounces-179664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00193A7E099
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E755189C7B1
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991AD1C174E;
	Mon,  7 Apr 2025 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AuO/IiLC"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C61E19D8A0;
	Mon,  7 Apr 2025 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034590; cv=none; b=c38nUZCrUEBBUbGDmxFx6UdqDJbm3ZNi3Fw3WPUIUX1ca2UZL+vMF+Y7Rgl4C5OKoFagQZ1syr/Tn3OwbB/F9TrkYBANnzgWfCINDHcEH5tDUrLop9zW3UsPNjmCCH6nnTiRPBxUdlDfO0F5VRELgKs20jIZjsQ582esOVVPEgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034590; c=relaxed/simple;
	bh=KPF2la8YsglBTuMvLbWhTYCt+BK0GVxaMR8VNCYLl+o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hr6sHtsvP3AN8LB6HTCetw91hF9IlRPwGVS65TFoGflfUXOwrSPwzdVUNpsdr3aPJu+qkeFVAPjSu+8Xh2ZIE8tQmsqbT3S8p0B4E90T60FsPtYyVXFCQTb0zt8mm5YkK8Ef5QUFaw6n7kGx1QHC9lbz0MqrGrSNwbkkF0IOzDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AuO/IiLC; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 920864429F;
	Mon,  7 Apr 2025 14:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744034586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0WrqoE2Jvp8HrYqDXCtaMpBnF0ILCPR74SbQnJiE/tU=;
	b=AuO/IiLCH1azcsZvITOvx+a21+oD/X1FMVcvU1+Dl+Fhe+1avrUWZsoCL/MS1zeiV+vOuc
	il4AAWGeMn8CIVFtYofoe5ZYlXST2b+ebhZMeE64tCuwkJ2eG8JNkqesOm9sNNyZbQuUio
	fsxkZEt1K+oRqcyH3d1ZZEqNUM/6FU6pASHNa62tFSLw7x8n8uYY4ESpvTamUaTKYXqEfb
	8ACGNI4HjFSvxHlx7sORuHfWOq7xbakW3Pwx+0pcONOj3BQWIhqateFaZc4hOgblqwDGnJ
	AiVtIaW3HqwVj4iZ+yCsiWeD0cB8Ce/3dbapE/uOPkroodfGtbyE5PPzidNrvA==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v2 0/2] Add Marvell PHY PTP support
Date: Mon, 07 Apr 2025 16:02:59 +0200
Message-Id: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABPb82cC/x3MWwqDMBBG4a3IPDeQTtVetiJFQvpHB2waJqkI4
 t4b+vg9nLNThgoyPZqdFKtk+cQKPjXkZxcnGHlVE1vu7JlbE+DKVzG+na5YljGVZMLterG+d/f
 WM9UyKYJs/+tAEcVEbIWex/EDPnw2SG8AAAA=
X-Change-ID: 20250124-feature_marvell_ptp-f8730c6a94c2
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Russell King <rmk+kernel@armlinux.org.uk>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtfeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthekredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedugefgudfftefhtdeghedtieeiueevleeludeiieetjeekteehleehfeetuefggeenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduhedprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepr
 ghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrihgthhgrrhgutghotghhrhgrnhesghhmrghilhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

Add PTP basic support for Marvell 88E151x PHYs.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (1):
      net: phy: Move Marvell PHY drivers to its own subdirectory

Russell King (1):
      net: phy: Add Marvell PHY PTP support

 MAINTAINERS                                        |   2 +-
 drivers/net/phy/Kconfig                            |  23 +-
 drivers/net/phy/Makefile                           |   5 +-
 drivers/net/phy/marvell/Kconfig                    |  35 +
 drivers/net/phy/marvell/Makefile                   |   7 +
 drivers/net/phy/{ => marvell}/marvell-88q2xxx.c    |   0
 drivers/net/phy/{ => marvell}/marvell-88x2222.c    |   0
 drivers/net/phy/{ => marvell}/marvell10g.c         |   0
 .../net/phy/{marvell.c => marvell/marvell_main.c}  |  18 +-
 drivers/net/phy/marvell/marvell_ptp.c              | 725 +++++++++++++++++++++
 drivers/net/phy/marvell/marvell_ptp.h              |  26 +
 drivers/net/phy/marvell/marvell_tai.c              | 279 ++++++++
 drivers/net/phy/marvell/marvell_tai.h              |  36 +
 13 files changed, 1128 insertions(+), 28 deletions(-)
---
base-commit: e9363f5834ade5fa092751ed42080edfdf4ff93e
change-id: 20250124-feature_marvell_ptp-f8730c6a94c2

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


