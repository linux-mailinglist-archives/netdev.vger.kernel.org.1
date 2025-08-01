Return-Path: <netdev+bounces-211405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 644C2B188BC
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 23:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E864D1C858C8
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 21:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C595B28D8C7;
	Fri,  1 Aug 2025 21:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPxqqoFx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A139528C851
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 21:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754083664; cv=none; b=l5PCWVdmJJHamKbGxO2xpeVnp6EClHXnRZ3/PtTloFJMk2gvyfY/jQ8hyRgXx82WwYUxOcO+o2Sq3wie6xOHCzAOJbXfFnb2QPfzUGjCQ07ZBZ4i1VS4lA8bDnJNhPmVmTRE8wMPj6pLG09su/8Alv/TYcSL+wsVW3FCLkm8CEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754083664; c=relaxed/simple;
	bh=C8XDvOKmcJBECgbnipD22cNIweV0/aoc5e5obigLrW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XZS2O4lmqSfL1rzs1ABndGz1qG5BXH18BmtnTSzW2jOAhv0n/uryDImxtQz4Y5kDBuQ/hWBIWpcdTLxkRnY+2dPpX2O5t7qWKZDRT36+CgtV+jl0Eg4fAsK93fH2MzuSKjYeHF85X8wNDnulqcrbfmsILIuYMvMPURVqiz4N3hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPxqqoFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7560C4CEE7;
	Fri,  1 Aug 2025 21:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754083664;
	bh=C8XDvOKmcJBECgbnipD22cNIweV0/aoc5e5obigLrW4=;
	h=From:To:Cc:Subject:Date:From;
	b=PPxqqoFxB5K50H0zt/fTLv8oyfCL1mYpbEQRizY1k56969phCSLrGfFF3N0LUhTER
	 1iZ33ugbawuV6PVEGbM5wWwvqvWFLOzvCAF7gjmBw/dz/v9ugST+Zkb6qkoc2jDafX
	 hLxPbGkoN3tnKD6YnSkC0Y3rZOMZEY7TuvfoZFbd2GPW65wmcIBsFG3eKix579ActC
	 ChR1NnIU+BKNS7oDqvzbhfU23D1EQXOzyKBxus1PISeqZMXhqMw4dtSfS892MgcfK2
	 RgEmCjASUf69kh1+1+KNwbXPfleSMg7YfvxYLtggMPpolQf6RkEcn6CdW9v/0ilb8L
	 wPQTA1AReYTpg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	csokas.bence@prolan.hu,
	geert@linux-m68k.org
Subject: [PATCH net] Revert "net: mdio_bus: Use devm for getting reset GPIO"
Date: Fri,  1 Aug 2025 14:27:42 -0700
Message-ID: <20250801212742.2607149-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 3b98c9352511db627b606477fc7944b2fa53a165.

Russell says:

  Using devm_*() [here] is completely wrong, because this is called
  from mdiobus_register_device(). This is not the probe function
  for the device, and thus there is no code to trigger the release of
  the resource on unregistration.

  Moreover, when the mdiodev is eventually probed, if the driver fails
  or the driver is unbound, the GPIO will be released, but a reference
  will be left behind.

  Using devm* with a struct device that is *not* currently being probed
  is fundamentally wrong - an abuse of devm.

Reported-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/95449490-fa58-41d4-9493-c9213c1f2e7d@sirena.org.uk
Suggested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Fixes: 3b98c9352511 ("net: mdio_bus: Use devm for getting reset GPIO")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: hkallweit1@gmail.com
CC: linux@armlinux.org.uk
CC: csokas.bence@prolan.hu
CC: geert@linux-m68k.org
---
 drivers/net/phy/mdio_bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 24bdab5bdd24..fda2e27c1810 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -36,8 +36,8 @@
 static int mdiobus_register_gpiod(struct mdio_device *mdiodev)
 {
 	/* Deassert the optional reset signal */
-	mdiodev->reset_gpio = devm_gpiod_get_optional(&mdiodev->dev,
-						      "reset", GPIOD_OUT_LOW);
+	mdiodev->reset_gpio = gpiod_get_optional(&mdiodev->dev,
+						 "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(mdiodev->reset_gpio))
 		return PTR_ERR(mdiodev->reset_gpio);
 
-- 
2.50.1


