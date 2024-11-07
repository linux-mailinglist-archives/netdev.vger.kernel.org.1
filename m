Return-Path: <netdev+bounces-142952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422FC9C0C46
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 734D91C22655
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6349D218584;
	Thu,  7 Nov 2024 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hCMAkpqu"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C659217F2B;
	Thu,  7 Nov 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730998989; cv=none; b=Wb802WhawrbLPj+4pahbZI0lkuKSt5KmXUaVWrG6rCpKK4//HqnN1AJFeaba9+ir43/VdyveqpNGf8OTl48sTyNW92kUionl2nWvBP15VfrFka9RQqSTcASAelttvKKj8Qa1aqECbSjtQhEcsISbO/wvYIkw913w/pEW+YFThLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730998989; c=relaxed/simple;
	bh=lnhfGsBPijdLmSTBoDTvyHj+rnR4uumf0PNicJs+/7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sJDF+ldHR68yR87WiNg8XK9FCmOGLj/eEg0Jxr5TpeiLh/lcLUODaJHd2AuUhno0rDkBKgRH3ExhDeexwGwEolgIoNibTHdnvaQXD7NJA+NEiqZqmWIUzB+ApRrvFbTg19i/k0TnhXA36Pli88I/1oBsV8WzL0mGF0jRezMJ5Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hCMAkpqu; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BBB50240007;
	Thu,  7 Nov 2024 17:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730998984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cp1IlwuXxuG3hVq1umEFzCMyS7Q+bM6rBW7jwZeMmgI=;
	b=hCMAkpqulm8WFtwNz9p/rJ6c5xyIR6Yt5pwkQVIQEvKoehCjYKLmaI2KMeC5YScXVkGK/Y
	4NYd/fMztQeBdkO9mv4nrEkULHwWlneZWnGmb9PGpDJ0GHxm/vRqIhCaYN6QTTjBG+X0Oj
	scxVELlEWOUEAsaalcEBe20LsxUW+gEceXA/+6bUFog+C/GZ1AiewiiZc8AsktcgIKll/L
	p9GURarjdeovSV44Sa/tJSDkksKWsLZNh4ZOZ+nghk9jhMxs2if4hbS9Z22nEoZX55hBYn
	Sb2Ksun51D0DOfrVf2l7vp9dd/Zru8vA/krrQP8IK2yKFc8pJimj03R/QqWHIQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next 0/7] net: freescale: ucc_geth: Phylink conversion
Date: Thu,  7 Nov 2024 18:02:47 +0100
Message-ID: <20241107170255.1058124-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello everyone,

This series aims at converting ucc_geth to phylink, one one part for
better SFP handling, and on the other hand as a preparation for complex
topology support with multiple PHYs being attached, which could involve
phylink. Even without considering the multi-phy case, this series brings
proper SFP support for that driver.

This driver is pretty old, which shows in the coding style. I did not
include a cleanup pass to get checkpatch happy, so a few patches will
complain about the CamelCase used in some internal structure
attrubutes...

The first 6 patches are preparation for the phylink conversion that's
done in patch 7.

The first patch removes support for the "interface" DT property which
has been deprecated for 17 years, allowing to simplify the phy mode
parsing.

The second patch splits the adjust_link function, as advised in the
phylink porting guide. This makes patch 7 easier to process.

Patches 3, 5 and 6 perform some cleanup on unsued or leftover constructs
to again make patch 7 easier to process.

Patch 5 addresses the WoL configuration in that driver.

Finally, patch 7 does the phylink conversion.

Note that there are some things that I wasn't able to test, namely the
TBI/RTBI handling. I did my best to replicate the existing logic, but I
don't have the hardware to test it.

Thanks,

Maxime

Maxime Chevallier (7):
  net: freescale: ucc_geth: Drop support for the "interface" DT property
  net: freescale: ucc_geth: split adjust_link for phylink conversion
  net: freescale: ucc_geth: Use netdev->phydev to access the PHY
  net: freescale: ucc_geth: Fix WOL configuration
  net: freescale: ucc_geth: Simplify frame length check
  net: freescale: ucc_geth: Hardcode the preamble length to 7 bytes
  net: freescale: ucc_geth: phylink conversion

 drivers/net/ethernet/freescale/Kconfig        |   3 +-
 drivers/net/ethernet/freescale/ucc_geth.c     | 600 +++++++-----------
 drivers/net/ethernet/freescale/ucc_geth.h     |  19 +-
 .../net/ethernet/freescale/ucc_geth_ethtool.c |  57 +-
 4 files changed, 247 insertions(+), 432 deletions(-)

-- 
2.47.0


