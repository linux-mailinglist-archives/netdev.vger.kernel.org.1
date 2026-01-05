Return-Path: <netdev+bounces-247127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F9FCF4CFD
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 17:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4232B30674E7
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 16:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEE23002DD;
	Mon,  5 Jan 2026 16:38:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939802DECD3;
	Mon,  5 Jan 2026 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631081; cv=none; b=mW+zFM3BJ4ioz3FMhn9ONbac8D9aBTdM/jGUv47RIumkQh/stKU6CsYLEh4wa8qq/6ymEQtFDOvJOs/jcmZ3/a7mHGd4A2k6B5EqsuqIJKZgKnmog2OGOy+qgtApOiXPvSUXwu6ZgNXWoKIkeoZQy65IbFloXsU8FwiLJZGnGnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631081; c=relaxed/simple;
	bh=5owUgFSMQq/ujyZ5GYcVW5tJsB88zAnWbYCJKcLdunk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=u+huHawwbrCy6YL9zOgnKK9npHSmfPLau/RDNhiALpOAgcqZiQw1P8ZKLp2g/5tzDdRz+TyIVNJ7EzKTKdd5i5niPsWKBAV0irri2obzOwBWRflhxg0LDqGwSNTaCM97hXltECs1ZIfGPErfJaeJXeqVxb3eJsGb4N5EcYBl73M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vcnaQ-000000000x7-1c3Z;
	Mon, 05 Jan 2026 16:37:42 +0000
Date: Mon, 5 Jan 2026 16:37:38 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Klein <michael@fossekall.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Bevan Weiss <bevan.weiss@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/5] net: phy: realtek: various improvements for
 2.5GE PHYs
Message-ID: <cover.1767630451.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This series improves the RealTek PHY driver, mostly for 2.5GE PHYs.
It implements configuring SGMII and 2500Base-X in-band auto-negotiation
and improves using the PHYs in Clause-22-only mode.

Note that the rtl822x_serdes_write() function introduced by this series
is going to be reused to configure polarities of SerDes RX and TX lanes
once series "PHY polarity inversion via generic device tree properties"
has been applied.

Access to other registers on MDIO_MMD_VEND2 is important for more than
just configuring autonegotiation, it is also used to setup ALDPS or to
disable the PHY responding to the MDIO broadcast address 0. Both will be
implemented by follow-up patches.

The address translation function for registers on MDIO_MMD_VEND2 into
paged registers can potentially also be used to describe other paged
access in a more consistent way, but that mostly makes sense on PHYs
which also support Clause-45, so this series doesn't convert all the
existing paged access on RealTek's 1GE PHYs which do not support
Clause-45.
---
Changes since initial submission:
 - use mmd_phy_read and mmd_phy_write
 - fix return value in on error (oldpage vs. ret)
 - fix wrong parameter name (reg vs. mmdreg)

Daniel Golle (5):
  net: phy: realtek: fix whitespace in struct phy_driver initializers
  net: phy: realtek: implement configuring in-band an
  net: phy: move mmd_phy_read and mmd_phy_write to phylib.h
  net: phy: realtek: use paged access for MDIO_MMD_VEND2 in C22 mode
  net: phy: realtek: get rid of magic number in rtlgen_read_status()

 drivers/net/phy/phylib-internal.h      |   6 -
 drivers/net/phy/phylib.h               |   5 +
 drivers/net/phy/realtek/realtek_main.c | 307 ++++++++++++++++++-------
 3 files changed, 235 insertions(+), 83 deletions(-)

-- 
2.52.0

