Return-Path: <netdev+bounces-185028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 709D4A98454
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 10:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65B1164F52
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 08:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC271DE3C3;
	Wed, 23 Apr 2025 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QQ7J27Q2"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987AE2F50;
	Wed, 23 Apr 2025 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745398529; cv=none; b=qoFFqMuunm+PW6zE+/czbEJbtQWs1ZCKd3L9NhOu6iSx0SHuUFw1VnaqrzF6ySkp6yv5k0nT8fEuhf/F8Ff+/TEypR4eSBoniZK4F142Db80yPX9IpVGxKjQp/V68PvCU7rpKzyLa4voUZrth5B1v6NIH9s/8IB17DwlBC7ZZQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745398529; c=relaxed/simple;
	bh=GmZXHGHXKCTH5lfJe/7BwnWTYaqqA1ttDbt5A5paCMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VdOJnnggCZ7hF9oPQwvCjYyiaB2s452WtuRvUp7om8YnifY9kWu2sYnB1vJVzm4NNoTS5zylGOLQ6l3ZDSTmjN+/tsauzsdHFqgrHgzP86jwwkfbcyynrVyYTYIZ2bolCHhneIMngIUoHuKCEeDhr6X/ELKhvWi3ldG+ktft5DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QQ7J27Q2; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0F5F54320D;
	Wed, 23 Apr 2025 08:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745398525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ksyz6m46nUEkhV/lupqSm/mMV33jOYnyxoq+uKjnAK8=;
	b=QQ7J27Q21qru3hCWVcFRAJfWv4nGd6XMFtmjtHjzXzyFGF8O8rOYKXlFazGxolJc9Wg7/P
	OFLIAFAUqf05tZC/bArocTRiR04LabS1sbgq1i+l+MB62bRwVrFA4c6CT80QBuKIXs7LkU
	v52q493swMY+3IQkah5zL+I8CNH56IA3Y/yYpjeqiptW9orFROBj/LBzFb2nQtxt7UWOaW
	jyJAnpLLjACE//GHZbL8KVy7ysx/VLgZ7/Q5v0G/4kdUilDCRExMcWgihAEYYPSgSE9Ajb
	PaoItV7UzX0cQiS2R7S/Gehb7AuXkiszo7oZSOTHdTFsv03YaWoCntWFCZJdMw==
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
Subject: [PATCH net v2 0/3] net: stmmac: socfpga: 1000BaseX support and cleanups
Date: Wed, 23 Apr 2025 12:46:42 +0200
Message-ID: <20250423104646.189648-1-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeiudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepjefhleeihefgffeiffdtffeivdehfeetheekudekgfetffetveffueeujeeitdevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtoheplhhinhhugiesrghrmhhli
 hhnuhigrdhorhhgrdhukhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
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

Changes in V2: 
 - Added Russell's review tags
 - Reworked patch 2 to check for phy_interface when configuring the
   adapter, as suggested by Russell.

V1: https://lore.kernel.org/netdev/20250422094701.49798-1-maxime.chevallier@bootlin.com/

Maxime Chevallier (3):
  net: stmmac: socfpga: Enable internal GMII when using 1000BaseX
  net: stmmac: socfpga: Don't check for phy to enable the SGMII adapter
  net: stmmac: socfpga: Remove unused pcs-mdiodev field

 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c   | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

-- 
2.49.0


