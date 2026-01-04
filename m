Return-Path: <netdev+bounces-246753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DECCF0F75
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 14:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AD4F3007291
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 13:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699382F9D85;
	Sun,  4 Jan 2026 13:11:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BB92C3266;
	Sun,  4 Jan 2026 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767532298; cv=none; b=layl0abYs7tez1/+zBIPsItSoo28km89pwq92EhUFQMh9ep7pKGe1TjaIg0GmhyL0D7D3RrZqFGmkZYLwx7wa0qUj1nFqLE1BNCDCni/XO5LrxRgY5jA2YIu9lrnmqbMRkRwCqxSONpyCew8STznQ/CQ2dB/z7QjOpu4e/JXSEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767532298; c=relaxed/simple;
	bh=C2KFtjJLvSfwCmLieVUm6V7HgaSokC+yFW8FNjiDwik=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QLy3MziuPncDOe4s8Dz4s11v/F0cxZaPDHS/K8/Yk9gBQFFhbC+1Ko3PMOCZaD40zHw8hl23WD0miKY0JkYEp8eglPm+W2IRLyTVY5VlNl7uKSuxKtvmxhOB5miOR9nOsECuHVvmayz3cr6b9NlDFF/to2OX//fPks/Mwsu5HRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vcNt8-000000003Mn-1tyB;
	Sun, 04 Jan 2026 13:11:18 +0000
Date: Sun, 4 Jan 2026 13:11:15 +0000
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
Subject: [PATCH net-next 0/4] net: phy: realtek: various improvements for
 2.5GE PHYs
Message-ID: <cover.1767531485.git.daniel@makrotopia.org>
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
and improves using the PHYs in Clause-22 mode.

Note that the rtl822x_serdes_write() function introduced by this series
is going to be reused configure polarities of SerDes RX and TX lanes once
series "PHY polarity inversion via generic device tree properties" has
been applied.

Access to other registers on MDIO_MMD_VEND2 is important for more than
just configuring autonegotiation, it is also used to setup ALDPS or to
disable the PHY responding to the MDIO broadcast address 0. Both will
be implemented by follow-up patches.

The address translation function for registers on MDIO_MMD_VEND2 into
paged registers can potentially also be used to describe other paged access
in a more consistent way, but that mostly makes sense on PHYs which also
support Clause-45, so this series doesn't convert all the existing
paged access on RealTek's 1GE PHYs which do not support Clause-45.

Daniel Golle (4):
  net: phy: realtek: fix whitespace in struct phy_driver initializers
  net: phy: realtek: implement configuring in-band an
  net: phy: realtek: use paged access for MDIO_MMD_VEND2 in C22 mode
  net: phy: realtek: get rid of magic number in rtlgen_read_status()

 drivers/net/phy/realtek/realtek_main.c | 332 +++++++++++++++++++------
 1 file changed, 255 insertions(+), 77 deletions(-)

-- 
2.52.0

