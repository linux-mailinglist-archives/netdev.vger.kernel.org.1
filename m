Return-Path: <netdev+bounces-224557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E87B86404
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B59516DD93
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9326F316187;
	Thu, 18 Sep 2025 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FfRos2Hv"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505D62C21C5
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217102; cv=none; b=TfDwK7nd1Q6wYiqKqVChhy1VT/+5mKvMfE0pmJHLkGBtV/FnBYIl2Adk7VJ+DhMQIMAvx9jkBG/43mkkx+6GkRwkSlnw7KwgANuxKDUKqYrIqLkFIvTB2p2JPon2x6wDjgCX6Ty43qphuQ06rw6qUiaFCkth/Jr4ozftIQ7zHNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217102; c=relaxed/simple;
	bh=7p4vk9SJMVJtxgIlm9i2lnHJbpCpVahPs3lc8OI/TyM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rKnFCABk9PDIKD9jAr9A3YKYN5yNMmZG5Y02HkuiiPMM4sJFzyQv/zVwpYpZmdyJINec7J+r+M+CvWnNLdvqPpgXpT+6id3aPH3Apknenk2bw5frBHhHUS8JbM7ZvM1Joix8K5p5EnmInp96vpb5bh7w1uSYyBRz7YWG4Wa/vIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FfRos2Hv; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=w2WHCpDN98I3HWubH9UPncj5+4jOw2k7Gihj9A0jNfo=; b=FfRos2HvtJ4xaHEoSUMrgUSvQW
	d0EWxvAIlz0YMQ+J5yII1sPSPFLHiKw7/u4OCtEttebeF2/aAM+dZqrxhsjAsEvc0CPtvajz96UeN
	9kx5OdFgTpSbl3Gczn6dvEAd/y/9YWA/7i/V+I715tTS0hJt+A12z+08OfYKGS5j+W+TYCwt2p0bU
	PH6ZglwlPZojtU1MnhAb8Vv0fVJIc4s/ou+PaqV2qTb0Dn4cPHYKWUoX3HxCIDPtRT+VJNRc23yi9
	AtE2JGYVXDlBCzfVNS+eSNPeyF1ZLV+GkblOW1Wor7w155/TNXTERp5zGRZl9n1lHKK2VoZL6X11e
	ygrYZlVw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53084)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uzIaH-000000001Zw-2GLH;
	Thu, 18 Sep 2025 18:38:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uzIaF-000000001M6-2VPn;
	Thu, 18 Sep 2025 18:38:15 +0100
Date: Thu, 18 Sep 2025 18:38:15 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH RFC net-next 00/20] Marvell PTP stuffs
Message-ID: <aMxDh17knIDhJany@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Not for merging, and, yes, it's more than 15 patches.

As the merge window is approaching, I thought I would share my current
state with the Marvell PTP library. I don't consider this ready for
merging yet, as I still have decisions to make on the structure for
multi-port setups such as DSA. 88E6165 support is also likely broken.

You will have noticed I've pushed out some patches cleaning up stuff
in the mv88e6xxx driver, and also making it easier for PTP clock
drivers to clean up when unregistering.

This series contains potentially another independent patch, adding
the ability to get the hwtstamp configuration from a MII timestamper,
although of course, the only known user right now is the Marvell PHY
PTP support (specifically 88E1510) in this series.

One of the things I don't like about the conversion for mv88e6xxx is
the "drop the old code, plug in the new". The hwtstamp.c changes
are split up, but they result in stuff becoming non-functional during
the transition.

The only thing I can think of doing to solve that is to forward the
hwtstamp_set() call to both implementations, and then convert the
tx side, rx side, and remove the old.

I've been running this for about 10 days (with reboots) between two
machines, one using the PHY side as the GM, and the other using
DSA as the slave. All seems happy, no timeouts on getting the
timestamps for the Sync or Delay_Req packets:

ptp4l[3032.775]: master offset        -60 s2 freq   -3984 path delay     11144
ptp4l[3033.775]: master offset        -16 s2 freq   -3958 path delay     11144
ptp4l[3034.775]: master offset         45 s2 freq   -3901 path delay     11144
ptp4l[3035.775]: master offset        203 s2 freq   -3730 path delay     11144
ptp4l[3036.775]: master offset        115 s2 freq   -3757 path delay     11144
ptp4l[3037.775]: master offset       -186 s2 freq   -4023 path delay     11144
ptp4l[3038.775]: master offset       -244 s2 freq   -4137 path delay     11144
ptp4l[3039.775]: master offset       -122 s2 freq   -4088 path delay     11137

I've tested both L2 and L4 configurations. Whether I get these to
a point that I can post some of them for real next week is uncertain,
and I certainly won't post them unless I feel they are ready -
especially not before I'm happy with the library.

 drivers/net/dsa/mv88e6xxx/Kconfig    |   1 +
 drivers/net/dsa/mv88e6xxx/chip.c     |  10 +
 drivers/net/dsa/mv88e6xxx/chip.h     |  63 +--
 drivers/net/dsa/mv88e6xxx/hwtstamp.c | 664 ++++++++++++------------------
 drivers/net/dsa/mv88e6xxx/hwtstamp.h |  26 +-
 drivers/net/dsa/mv88e6xxx/ptp.c      | 527 +++++++++---------------
 drivers/net/dsa/mv88e6xxx/ptp.h      |  30 +-
 drivers/net/phy/Kconfig              |  13 +
 drivers/net/phy/Makefile             |   1 +
 drivers/net/phy/marvell.c            |  15 +-
 drivers/net/phy/marvell_ptp.c        | 369 +++++++++++++++++
 drivers/net/phy/marvell_ptp.h        |  17 +
 drivers/net/phy/phy.c                |   3 +
 drivers/ptp/Kconfig                  |   4 +
 drivers/ptp/Makefile                 |   2 +
 drivers/ptp/ptp_marvell_tai.c        | 445 ++++++++++++++++++++
 drivers/ptp/ptp_marvell_ts.c         | 778 +++++++++++++++++++++++++++++++++++
 include/linux/marvell_ptp.h          | 159 +++++++
 include/linux/mii_timestamper.h      |   3 +
 19 files changed, 2318 insertions(+), 812 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

