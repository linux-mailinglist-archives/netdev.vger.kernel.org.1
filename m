Return-Path: <netdev+bounces-168854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C088A4106A
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 18:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D656C172892
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 17:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB821519B1;
	Sun, 23 Feb 2025 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JqpuI2oL"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE0286329;
	Sun, 23 Feb 2025 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740331742; cv=none; b=YLKGZ0fMzXTfq0VOf96J8XsErIbwVU7MtskWqi2+tVlvKYhzqq/dPiQC1R1qOfn8TZ25K5JKwTOcecgLuN6N8rGaHBzxipdN/SKOl1MTpuDnyVHs1p/L60kN7NpzdkL0GImMAKCFhFpTM+q2wWomREHH/2oo0ZFAVjEV4L+Xmww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740331742; c=relaxed/simple;
	bh=7vXAeaUG1AYhclmHZtd+laCqdo9lQHHn9NE9x5PMots=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P6+3zhyNJTkRmwd/9ZFnvMO8vsaCt0nOzNC5Rz04OWAr+DybyWBP+eF3dxdL2s1JSGIr8qwp1b4KenXBYhWl5xa6hreye96RZgwTT9hByFa0iHfDjPEyIBe4Euh80vS6OBnQ0y9iAKtPdUwq3/BwsNF64lrvHhri6OA3dbLTKNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JqpuI2oL; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4E93442D46;
	Sun, 23 Feb 2025 17:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740331731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4mA7+Sysr9KQUMiKpwYaPwZV6pFVC/GbVfhlN9xqL4o=;
	b=JqpuI2oLA7zdevZSv6qHAf873CiP1poe3og3jnNESI4AYhTsCjBn7httBIP2wk7qIaFWpU
	6pwf0EYThkDEOMyDjYJO7q6LoE1kmfuZfWxtwlh7QsFA2WupAvAZwrwaxHO8dp4lLIhtLX
	TVdgtPZJJFZ3AzZcQUbJFRoGbJjXDIPXG0DGihVoGWOv1brLN0TitX8JL7080tp9zj8T6c
	3HKJPsOSWtoFvTQArfUMxpSuQVZMcWPuJesF1EPK6ml075MmiVKAdRPcCLkMqcLy7wxf77
	/O9Ue8DEZblmLiX/9B01pBYvwDHDjNh7KiHOqpEfqFn16rBWVwh5OLeUFUgDwA==
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
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net-next 0/2] net: phy: sfp: Add single-byte SMBus SFP access
Date: Sun, 23 Feb 2025 18:28:45 +0100
Message-ID: <20250223172848.1098621-1-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejieeggecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehtdehueefuedtkeduleefvdefgfeiudevteevuefhgfffkeekheeuffeuhefhueenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvt
 hesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi everyone,

Some PHYs such as the VSC8552 have embedded "Two-wire Interfaces" designed to
access SFP modules downstream. These controllers are actually SMBus controllers
that can only perform single-byte accesses for read and write.

This series adds support for accessing SFP modules through single-byte SMBus,
which could be relevant for other setups.

The first patch deals with the SFP module access by itself, for addresses 0x50
and 0x51.

The second patch allows accessing embedded PHYs within the module with single-byte
SMBus, adding this in the mdio-i2c driver.

As raw i2c transfers are always more efficient, we make sure that the smbus accesses
are only used if we really have no other choices.

This has been tested with the following modules (as reported upon module insertion)

Fiber modules :

	UBNT             UF-MM-1G         rev      sn FT20051201212    dc 200512
	PROLABS          SFP-1GSXLC-T-C   rev A1   sn PR2109CA1080     dc 220607
	CISCOSOLIDOPTICS CWDM-SFP-1490    rev 1.0  sn SOSC49U0891      dc 181008
	CISCOSOLIDOPTICS CWDM-SFP-1470    rev 1.0  sn SOSC47U1175      dc 190620
	OEM              SFP-10G-SR       rev 02   sn CSSSRIC3174      dc 181201
	FINISAR CORP.    FTLF1217P2BTL-HA rev A    sn PA3A0L6          dc 230716
	OEM              ES8512-3LCD05    rev 10   sn ESC22SX296055    dc 220722
	SOURCEPHOTONICS  SPP10ESRCDFF     rev 10   sn E8G2017450       dc 140715
	CXR              SFP-STM1-MM-850  rev 0000 sn K719017031       dc 200720

 Copper modules

	OEM              SFT-7000-RJ45-AL rev 11.0 sn EB1902240862     dc 190313
	FINISAR CORP.    FCLF8521P2BTL    rev A    sn P1KBAPD          dc 190508
	CHAMPION ONE     1000SFPT         rev -    sn     GBC59750     dc 19110401

DAC :

	OEM              SFP-H10GB-CU1M   rev R    sn CSC200803140115  dc 200827

In all cases, read/write operations happened without errors, and the internal
PHY (if any) was always properly detected and accessible

I haven't tested with any RollBall SFPs though, as I don't have any, and I don't
have Copper modules with anything else than a Marvell 88e1111 inside. The support
for the VSC8552 SMBus may follow at some point.

Thanks,

Maxime

Maxime Chevallier (2):
  net: phy: sfp: Add support for SMBus module access
  net: mdio: mdio-i2c: Add support for single-byte SMBus operations

 drivers/net/mdio/mdio-i2c.c | 79 ++++++++++++++++++++++++++++++++++++-
 drivers/net/phy/sfp.c       | 65 +++++++++++++++++++++++++++---
 2 files changed, 138 insertions(+), 6 deletions(-)

-- 
2.48.1


