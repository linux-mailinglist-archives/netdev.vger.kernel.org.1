Return-Path: <netdev+bounces-148564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EFB9E22EE
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9622285AA5
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6791F707A;
	Tue,  3 Dec 2024 15:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uzpHGTaf"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00101F7063
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239831; cv=none; b=uQj9o9C9oV6zws0q6SjK7y1+aQ90/AhMClRXL5sdV5SqFXb3/Hjcr3KWvxOHq014QZN4hzlBhawFSmfcJZxT+GMm6lL+9XGchY1Pd9zrCsHu8CDYcbN97hB6Ekz97BAP+MLwazAq/g/Y63ujARGftt0H7GGPJ8habaq2OWZGP0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239831; c=relaxed/simple;
	bh=ZMI0K+6xqKyX6Z8RDnilRp8QOEjaklt3mvlzHYrZo7I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ax4hrn76qnKSNckAcqTZ3yAN9VRdG5ITsdLdqrrJKHoxxQM0CyrQGLh4vczZojFZ0gvUJTcR3Q/j3OOdVc5rXSZIoXw5W1udm13tkpk6/MpFFPQ2+0VyjJmqFpj17rhTjKYSAV3mDDYtEtqz9PYCTI8o5zGwcW92Nzk2yRi7hYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=uzpHGTaf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rikHpGwng0obDx2Cuu2BZ8MfNMk4EzfP1WI6ngcxJtc=; b=uzpHGTafowlLjLY5nYQbxvKxhT
	SAEnvQ/Bw5/5m//g0LGDE8RthToOwQ2pmH2WXHaO9HDpCCuRiZ8TiyD2SQ4pj7r82N5h8ofcfqPNI
	GtlGTKdVwwuZNEta/cGx71Xo54rLylRUDbJ0IC/mE83Xb1KLPR5Y05sLXZ8LKaQ4sGCNpyZmzkyxA
	JTcoS8PsGPU5bet6D+gG88NudKyGdUCyq6Wx9nw432o8uKCr8HnskHibaRspADtyJ053D6XrLWjB9
	TM6LfoPRwkj9IEXz0PJK/CkDUwkgsS7B3CUW7gLSUnqC3Z5xc7HcpZo6xkjGAY19Ni9mj13XuIIn1
	5qoXz4/A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35404)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tIUqz-00027J-0w;
	Tue, 03 Dec 2024 15:30:21 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tIUqx-0004ek-2H;
	Tue, 03 Dec 2024 15:30:19 +0000
Date: Tue, 3 Dec 2024 15:30:19 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 00/13] net: add negotiation of in-band capabilities
Message-ID: <Z08kCwxdkU4n2V6x@shell.armlinux.org.uk>
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

This is a repost without RFC for this series, shrunk down to 13 patches
by removing the non-Marvell PCS.

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

We don't... yet... support bypass on the MAC side PCS, because that
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
10 and 11 adding support to Marvell NETA and PP2.

Patch 12 adds the code to phylink_pcs_neg_mode() which looks at the
capabilities, and works out whether to use in-band or out-band mode for
driving the link between the MAC PCS and PHY.

Patch 13 removes the phylink_phy_no_inband() hack now that we are
publishing the in-band capabilities from the BCM84881 PHY driver.

Three more PCS, omitted from this series due to the limit of 15 patches,
will be sent once this has been merged.

 drivers/net/ethernet/marvell/mvneta.c           |  27 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c |  25 +-
 drivers/net/phy/bcm84881.c                      |  10 +
 drivers/net/phy/marvell.c                       |  48 ++++
 drivers/net/phy/phy.c                           |  53 ++++
 drivers/net/phy/phylink.c                       | 352 +++++++++++++++++++-----
 include/linux/phy.h                             |  34 +++
 include/linux/phylink.h                         |  17 ++
 8 files changed, 474 insertions(+), 92 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

