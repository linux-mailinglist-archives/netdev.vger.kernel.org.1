Return-Path: <netdev+bounces-169426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A7BA43D55
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 12:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E8C19C3BB5
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693D9267AE1;
	Tue, 25 Feb 2025 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N3thMSVN"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BB32673AF;
	Tue, 25 Feb 2025 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740482450; cv=none; b=kSqnOWlM31bYbnDo2OlhKxNNL5T1IM3oesdwF/YvaqcNDpsIWoEdegxvILPWrld/3q/gk4z7S51BqKFFjkM1vcA3jI65ejob/K4PcJnMVznUbR2axliUimJrOqMHFFPPzZO7T5iFJfGWe6z7H1OR5Lwwn492bszzJGWRDYknguE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740482450; c=relaxed/simple;
	bh=v7F3hSk/X3JDb2HAN34QsZFKdg0OGqiV2zFYyKnFFCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bv653bwmEvZSVwbx9Fr5B6iSscGPGCYXNDIihFmNHsRlEORhvGTzYNlSV71x1B8JPp/nGz4hc7L6UBC5VXuDxOjjrCfZKrCSpCIp06mQYDtZidHJfHKfb9RHwLd80IAOG/fznb4S5PQtBHuU2Ney9lyrQmTHV96Wd/TdwoK/eWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N3thMSVN; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A5FC920484;
	Tue, 25 Feb 2025 11:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740482446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TjN0KbmQJwKC/VPowiOLg00sDmSlmM1PT1Bs4HCZ79Q=;
	b=N3thMSVN1NfvP+t/mlV0Q/auU37MuxBb6ZsSBr5mSsLaDUyOJ7QRlLl5L5dSxiwlZzOaVE
	9YM2fSYyekvukOgjsHiGnNn1GHCjFAy6i9ol1tRTOrAJzsL41+GcTnKJo4aVlrtup5hCtk
	ROBFGuzmObhhrK1b4cD5Jdbl2VkhBjYt/S2e0+0P0x40yXMC6xViOPRrvtO3uWqf2CoxSz
	nfuGy7Gjg6fFwsypq6seV/xZVpwfFJzTWnlheoTifc16uNFMj+1NJUQ2mw32UTrCtAVEr9
	aT/Ifxo5FXVuM8vBQseBLAjWcwTdDr1vIyRzeBS9WlzdC78N2I21gmoCUKTEDA==
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
Subject: [PATCH net-next v2 0/2] net: phy: sfp: Add single-byte SMBus SFP access
Date: Tue, 25 Feb 2025 12:20:38 +0100
Message-ID: <20250225112043.419189-1-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudehjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeejhfelieehgfffiefftdffiedvheefteehkedukefgteffteevffeuueejiedtveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudelpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello everyone,

This is V2 for the single-byte SMBus support for SFP cages as well as
embedded PHYs accessed over mdio-i2c.

Discussions in V1 [1] with Russell and Andrew showed that we should be mor
conservative with SMBus access, as it is either stated as non-compliant
with SFF-8472 for diag data, or simply blurry as to how well this will work
with Copper modules.

Tests on a variety of modules show that it looks OK however this is
really not enough to guarantee that it will work with all modules, so in
this V2 we :
 - Disable hwmon
 - Print a big warning indicating that it may not work as expected, but
   more importantly that the kernel isn't to blame, but rather the HW
   design.

I've added Sean's tested-by tags, I hope that's OK given I've added the
new flag to disable hwmon.

V1 ([1]): https://lore.kernel.org/netdev/20250223172848.1098621-1-maxime.chevallier@bootlin.com/#t

Maxime Chevallier (2):
  net: phy: sfp: Add support for SMBus module access
  net: mdio: mdio-i2c: Add support for single-byte SMBus operations

 drivers/net/mdio/mdio-i2c.c | 79 ++++++++++++++++++++++++++++++++++++-
 drivers/net/phy/sfp.c       | 79 ++++++++++++++++++++++++++++++++++---
 2 files changed, 151 insertions(+), 7 deletions(-)

-- 
2.48.1


