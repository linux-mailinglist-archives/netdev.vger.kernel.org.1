Return-Path: <netdev+bounces-174927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2308AA61624
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 17:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 661914635FD
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 16:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA51202C2E;
	Fri, 14 Mar 2025 16:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ki4jHKF9"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855C660B8A;
	Fri, 14 Mar 2025 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741969411; cv=none; b=Dihh8PogHF9vE70wcEilJaFvZKNVGmyKzSi/1tI6vDc6lsbeYCVGorI9AbwN+EKkqu/fPaoERm7w8FFefHo1zjBKMzjkZSqO3j9LjOlNj4SIg3OzVFMTPXh7LfRKWTU8I3L3qn1bW4wtGzXAy+y4SwJ4gkuB59DF+q5TqIbKOzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741969411; c=relaxed/simple;
	bh=vSWQVomwrfHKjYe2iJ8X5RVgOYv3X/qw594x01JsaU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rb3q6RZSqQZsjcVUKXmSa1/Wf+av1uFc+q9b+rdyboQO4DuzmtrWGWakMzU+mufndixggvnzQhSU4+YU6u6sEtBsXnuOq2KifTzEv9WixjbsOeQlB1VaqbMxlOlr8Y9fnCxIcOteuMGbVjxd4QVx1tbeKhRYeGzVvMOHpvmvKHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ki4jHKF9; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 54A23443B2;
	Fri, 14 Mar 2025 16:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741969402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TDp3vIin6lJbFWhNe9iY4/vQj4YH5SmKv/hehLoFjhs=;
	b=Ki4jHKF9uGks72msYY5kkuWX95cjyijrPFe2bUEA4jOTe1hct0zbaY3JkA2HDE19VRQydc
	jqT9CLACzgRnKZ1HrpNNOYDLTq7M24rrSfHF3BoeFQuVKnhSND5XBIUmd9zC5cFKS4oaFq
	JWNyRUGfrhVG8suSl6d3rG/kaeeOnEn6+qbD6dL2O7PxwCCpgQL1klMeqbZfonnzItTPTV
	mJqV7ADEx1fVTecgHFTGehAG9vjBdutHWCTPbWCMKPHtDtIDa4D3R/LI6e8UpPdBEvxDw1
	hpCRbgHPuYM+k5CFeUMui+CmQy/x2Z3nhlPoVOYhWar09Lp3LfELI35UlGxDpg==
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
Subject: [PATCH net-next v3 0/2] net: phy: sfp: Add single-byte SMBus SFP access 
Date: Fri, 14 Mar 2025 17:23:16 +0100
Message-ID: <20250314162319.516163-1-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedufeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepjefhleeihefgffeiffdtffeivdehfeetheekudekgfetffetveffueeujeeitdevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrqddvrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduledprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrn
 hgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello everyone,

This is V3 for the single-byte SMBus support for SFP cages as well as
embedded PHYs accessed over mdio-i2c.

Discussions on the previous iteration raised some questions on the
ordering of the accesses (from Andrew), after further testing it still
seems correct to me, I can properly read EEPROMS and by hacking around,
read 16 bits values (although this is disabled anyways).

This series compared to V2 changes the approach used internally to use
the degraded mode (no hwmon), by setting the i2c_block_size to 1 and
re-using the logic already in place to deal with that.

As we now have 2 scenarios for 1-byte accesses (broken EEPROM that needs
to be accessed 1 byte at a time or single-byte SMBus), I've updated some
of the in-place error logs. Users should still be plenty warned and
made aware of the situation.

I also renamed the internal helpers to reflect that we use single-byte
accesses.

The rest was left untouched (I didn't have time yet to test around with
Rollball for example or 16-bits SMBus).

As I reworked patch 1, I dropped Sean's tested-by :(

V2 : https://lore.kernel.org/netdev/20250225112043.419189-1-maxime.chevallier@bootlin.com/
V1 : https://lore.kernel.org/netdev/20250223172848.1098621-1-maxime.chevallier@bootlin.com/#t

@Maintainers: I already have a few series queued for review, let me know
if you prefer that I resend that one at a later time.

Maxime

Maxime Chevallier (2):
  net: phy: sfp: Add support for SMBus module access
  net: mdio: mdio-i2c: Add support for single-byte SMBus operations

 drivers/net/mdio/mdio-i2c.c | 79 ++++++++++++++++++++++++++++++++++-
 drivers/net/phy/sfp.c       | 82 +++++++++++++++++++++++++++++++++----
 2 files changed, 152 insertions(+), 9 deletions(-)

-- 
2.48.1


