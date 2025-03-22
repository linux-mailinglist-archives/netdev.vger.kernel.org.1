Return-Path: <netdev+bounces-176848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09665A6C829
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 08:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA161B60816
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 07:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B531C84D6;
	Sat, 22 Mar 2025 07:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EgsjnvDw"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82AC2868B;
	Sat, 22 Mar 2025 07:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742630274; cv=none; b=SLebPaBw+g4yLKEywOxCMlq3fSNTg+E9itBafOYME2GpXTIkKEAHZVoT7empk9azEsNPbAHz87Kz6ObsoqUUbQffLl5cek4h/pCaFxZve1RgHz6XExvK3KSVLBBzbjI4vPqG4AczcDTtNPGsHEelyTswTD/WTU5GNvpI9K3Zxtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742630274; c=relaxed/simple;
	bh=C97LG8CJZiuZwaMNTjL04R/Od5awdopTjnJYZU1Daq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LyPLV3Y5kIaCK7/vyHIzqRVxbAhTW/ytQbdihl6L8hfSDiKqzT+++RR3W5p/Dc4HYQe0d/XO7ZckjmcLGLw+jUxxRy7NMFj40WnaJ9vx4jRLcJkdsGLZ1SEt/uZZOAlvU2M86Sv4E3X9kLFOF+bv912sqQaM5Buz2RnUT/a6ngw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EgsjnvDw; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 30CB244394;
	Sat, 22 Mar 2025 07:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742630269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Trg8qS1naZwEoSOhGz+PEKgCQkXYZcev0jt+Mer2iMc=;
	b=EgsjnvDwZJ1vtSQzk+BZk0Sn7Mqb7KccPRMEjOzqfFGLwTeMTt9UsstoSAQoimN5dL4Z7L
	hkp4lLVRXYAWLx6m8BNXbwT6pB43sr8Sq3uCJegzdwKz0BuhTAnT+mcJpIanG4lT4l8z25
	u3FSpLdStx5o2v2gBhgmncpifUjmLJcLfRWWPevaRs1BJDZ4ndl5qxiM9TECmqy3yftgCf
	KpIBeTf4Baoy18ChEFsaBf04VxNVb97A0p+Lxw23eiZsvth9Gw40OwTbSyZIOI6QIG9CSf
	EFT0yeSXWAuE6Z0S1JFgNVHHjLNQQPnPyS1xl/LBVZxtiwP6qCX1dZBbfyknmA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Antoine Tenart <atenart@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [PATCH net-next v4 0/2]  net: phy: sfp: Add single-byte SMBus SFP access
Date: Sat, 22 Mar 2025 08:57:43 +0100
Message-ID: <20250322075745.120831-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheefgeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepjefhleeihefgffeiffdtffeivdehfeetheekudekgfetffetveffueeujeeitdevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduledprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvl
 hdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello everyone,

This is V4 for the single-byte SMBus support for SFP cages as well as
embedded PHYs accessed over mdio-i2c.

V4: Cosmetic cleanups reported by Paolo :
 - xmas tree in patch 1
 - Extra parenthesis in patch 2

V3:
 - Rework patch 1 to use i2c_max_block_size

V2:
 - Disabled hwmon and add a big warning when in single-byte mode

V3 : https://lore.kernel.org/netdev/20250314162319.516163-1-maxime.chevallier@bootlin.com/
V2 : https://lore.kernel.org/netdev/20250225112043.419189-1-maxime.chevallier@bootlin.com/
V1 : https://lore.kernel.org/netdev/20250223172848.1098621-1-maxime.chevallier@bootlin.com/#t

Maxime

Maxime Chevallier (2):
  net: phy: sfp: Add support for SMBus module access
  net: mdio: mdio-i2c: Add support for single-byte SMBus operations

 drivers/net/mdio/mdio-i2c.c | 79 ++++++++++++++++++++++++++++++++++-
 drivers/net/phy/sfp.c       | 82 +++++++++++++++++++++++++++++++++----
 2 files changed, 152 insertions(+), 9 deletions(-)

-- 
2.48.1


