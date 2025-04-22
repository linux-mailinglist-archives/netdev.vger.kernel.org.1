Return-Path: <netdev+bounces-184590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D799A964FA
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 11:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8C4178C5E
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 09:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CDA1F4606;
	Tue, 22 Apr 2025 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NCv/7+1a"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9111B1EB1A8;
	Tue, 22 Apr 2025 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745315243; cv=none; b=R3cHQQultgggH///Tq5Dv8dCGRX4rdCySGn1skE+0MjNHoTfyYXL0hCbn9ckgxTJNqp6gcRAaGHJKQ3mRGumHJAmJol2MUTTCK0d16Ds9ieY8gy605s+G8WJxK1d84H9tZ08zrNDBxuS9PTsIBoj+ZrTiYRbDJ8BO3mCosOoVaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745315243; c=relaxed/simple;
	bh=LETj/ihRbceFgO7zekmM9Jci+dyLy0wKV2esC4XRAq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=azUbpWd8JdhdAsvpUwpVZmhGx7UQ6rOJ41oFSqmdxOlO3n0HjmJA3H3w7XdUnHgiNdOYzDvRl7+KEW3N7lmOsELjQ+9hwd/U+nq0ytYFb6lFk71EZIrzmw0q2xWNi3MTJNXxZSuPC+8Au5szNWtVSbYlpgrnutkzE7L0JqebggI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NCv/7+1a; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4501C432F9;
	Tue, 22 Apr 2025 09:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745315232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Uicg+PWgEa62Lbm/5RBrHSig7QCgYW+uliLkHIFRzEI=;
	b=NCv/7+1an2DDckptxZ2tZfimTLdTIe5C1SVkaKXpFzLs2L0w/yyE33wUg25y/K4qfLWuFo
	rbWjjF7YOSMfr0X6VNK+W0WoKeqVJGC/bY5TMZ+w9JT6IznjlfacTSh4Z1aMe6mZXbDaD/
	tfbvBvtqrGq+RO40gRXl/cLouHeM07k+tzHUJVTgAGKFQ4lKc/KKccHuU354FPXbjR1qTF
	uUCS0uBhPOJqvaOT4WBysbBVvLAiuBtvh0P7M1c6tiIl4efDIL/LKkQN7Wc6fr0JzVJgLI
	D8UfyBU8cTgApKL72SZCJusxXgSf9KRBRsb8/CkI9hm2/TZ+S7ekor4n2UOi1A==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Subject: [PATCH net 0/3] net: stmmac: socfpga: 1000BaseX support and cleanups
Date: Tue, 22 Apr 2025 11:46:54 +0200
Message-ID: <20250422094701.49798-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefgedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephedtheeufeeutdekudelfedvfefgieduveetveeuhffgffekkeehueffueehhfeunecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmegtkedufeemgeejtgeimeejudelrgemlegusghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemtgekudefmeegjegtieemjedulegrmeeluggsfhdphhgvlhhopeguvghvihgtvgdqgedtrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtt
 hhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello everyone,

This small series sorts-out 1000BaseX support and does a bit of cleanup
for the Lynx conversion.

Patch 1 makes sure that we set the right phy_mode when working in
1000BaseX mode, so that the internal GMII is configured correctly.

Patch 2 removes a check for phy_device upon calling fix_mac_speed(). As
the SGMII adapter may be chained to a Lynx PCS, checking for a
phy_device to be attached to the netdev before enabling the SGMII
adapter doesn't make sense, as we won't have a downstream PHY when using
1000BaseX.

Patch 3 cleans an unused field from the PCS conversion.

Maxime Chevallier (3):
  net: stmmac: socfpga: Enable internal GMII when using 1000BaseX
  net: stmmac: socfpga: Don't check for phy to enable the SGMII adapter
  net: stmmac: socfpga: Remove unused pcs-mdiodev field

 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

-- 
2.49.0


