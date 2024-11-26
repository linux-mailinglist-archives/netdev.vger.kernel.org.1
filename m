Return-Path: <netdev+bounces-147359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A262B9D9491
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43006B2C9F2
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7091B87DC;
	Tue, 26 Nov 2024 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zzT4dMuT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B7E18E057
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613064; cv=none; b=kpvdX3QU/IAkF89AxXC7hc4hZ1mLtXcj3jF30wfRuApwm80ru0C9A60nwLYIDWO1kNnzLnEjWpuGZvmesEZXh8B5VypOdWxjPyGi1Zy+jJhlQmVz0lKHfosQFmZNeGTHrWY9M7MMdJoAUoKRJRuwlVs9HLHu7n4RkQ4iCwRsaIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613064; c=relaxed/simple;
	bh=GMJieUXvxk3A4qUk9RdHTxj5k5tmVomz1Plx9yKmExc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VB2KEcGNr9Koc0p+G6+AeF8LGIEIygt0H8A5GGV+p12/UFdgq5fGvgPs5Q0dDDo2ReCHPpwgMLWa8PevlgEo/TfFhYCjw2QgslQdXGphT7zUPp6yKUarkpiD5nnxa3wFCtrhbOTvuPRVeIPvHKBCqaeaHm4tXD5IXp2aKvDmlRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zzT4dMuT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qVPL0RdD4hnmz4XYDjVggcqfPiFjhTjUbOauD820jSM=; b=zzT4dMuTJkpC3NnKY2hawXduOh
	PbEAYhOg6UWAai71+bXosnUAQX6y1wUPJD6QRmHaqz866weG4pV6klHL8w7ALIQ/HBlrMKx7UhAhy
	QPa4DCqlnTpChq6us+nNiYlPuJtn46kTGpzihoHcKAsXRQwXH+W278+thEykecLaAYtBJtnn+6hAZ
	u74FUonF6dKYIIHMC4bSZYHatmGFDC2w30VH8lPuJHAq9LNKPHlBeJZBtfgwYM/lEshBf2EYKEudY
	onFeRs7HfsXC+4n2tNKhOJ39JB4uzciZColpghXrw5eaLUPDxA3lt0KBokpBRX/lNXPhSI3ClukbC
	KLmGMU3w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39506)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tFrnX-0006RQ-2S;
	Tue, 26 Nov 2024 09:23:56 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tFrnQ-0004Ra-2v;
	Tue, 26 Nov 2024 09:23:48 +0000
Date: Tue, 26 Nov 2024 09:23:48 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Couzens <lynxis@fe80.eu>, Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC net-next 00/16] net: add negotiation of in-band
 capabilities
Message-ID: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

Yes, this is one patch over the limit of 15 for netdev - but I think it's
important to include the last patch to head off review comments like "why
don't you remove phylink_phy_no_inband() in this series?"

Phylink's handling of in-band has been deficient for a long time, and
people keep hitting problems with it. Notably, situations with the way-
to-late standardized 2500Base-X and whether that should or should not
have in-band enabled. We have also been carrying a hack in the form of
phylink_phy_no_inband() for a PHY that has been used on a SFP module,
but has no in-band capabilities, not even for SGMII.

When phylink is trying to operate in in-band mode, this series will look
at the capabilities of the MAC-side PCS and PHY, and work out whether
in-band can or should be used, programming the PHY as appropriate. This
includes in-band bypass mode at the PHY.

We don't... yet... support that on the MAC side PCS, because that
requires yet more complexity.

Patch 1 passes struct phylink and struct phylink_pcs into
phylink_pcs_neg_mode() so we can look at more state in this function in
a future patch.

Patch 2 splits "cur_link_an_mode" (the MLO_AN_* mode) into two separate
purposes - a requested and an active mode. The active mode is the one
we will be using for the MAC, which becomes dependent on the result of
in-band negotiation.

Patch 3 adds debug to phylink_major_config() so we can see what is going
on with the requested and active AN modes.

Patch 4 adds to phylib a method to get the in-band capabilities of the
PHY from phylib. Patches 5 and 6 add implementations for BCM84881 and
some Marvell PHYs found on SFPs.

Patch 7 adds to phylib a method to configure the PHY in-band signalling,
and patch 8 implements it for those Marvell PHYs that support the method
in patch 4.

Patch 9 does the same as patch 4 but for the MAC-side PCS, with patches
10 through 14 adding support to several PCS.

Patch 15 adds the code to phylink_pcs_neg_mode() which looks at the
capabilities, and works out whether to use in-band or out-band mode for
driving the link between the MAC PCS and PHY.

Patch 16 removes the phylink_phy_no_inband() hack now that we are
publishing the in-band capabilities from the BCM84881 PHY driver.

 drivers/net/ethernet/marvell/mvneta.c           |  27 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c |  25 +-
 drivers/net/pcs/pcs-lynx.c                      |  22 ++
 drivers/net/pcs/pcs-mtk-lynxi.c                 |  16 ++
 drivers/net/pcs/pcs-xpcs.c                      |  28 ++
 drivers/net/phy/bcm84881.c                      |  10 +
 drivers/net/phy/marvell.c                       |  48 ++++
 drivers/net/phy/phy.c                           |  52 ++++
 drivers/net/phy/phylink.c                       | 352 +++++++++++++++++++-----
 include/linux/phy.h                             |  34 +++
 include/linux/phylink.h                         |  17 ++
 11 files changed, 539 insertions(+), 92 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

