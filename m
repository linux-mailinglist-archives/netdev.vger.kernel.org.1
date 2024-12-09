Return-Path: <netdev+bounces-150232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B44E39E98A5
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 15:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250F5188585C
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2551B0419;
	Mon,  9 Dec 2024 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="g4NOJPQo"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B546F1B0421
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754167; cv=none; b=hElVrN3zFXO5Rr5JUDtJF8sf+GuX4mWbPpIQMXAPOrRixXX5ANnS1tuV+Vs3gRJB6yTmhUS2Kf/cmqhEskxgI1PH5qWHi/n5cGWALoocjw/1241YFI6LIyWB8hEEFr/vnJKQxsW9WUA+xY6CxyjA6dNWkq9fF/DnfeXvuWXW1p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754167; c=relaxed/simple;
	bh=Nksm2B7YF/kxpTNDqcK9kU3i2yzLbmwGJNb6iIx/Kpk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bx6VX2qNqdxZI55VqUEOCXkRta0/6lWAmMT2nk7bWdn/9h+QpsrHzDoKu3oLMSPXcEMTSI1lY3jde7FiUrxSPDCoYX1FHZEDNhYKd7mXQSFdj3csKvAESo2vTyvFFD1wx9zzF5EEPTISP7UVy9ow7nYGnmydXqczXQn+Ct4X7yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=g4NOJPQo; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=K6jgVBpRZHxQ5DEqLZmFTAzvfUkownFqChtoVmYYGe0=; b=g4NOJPQou20GUDtPikUps6+r+R
	2LKLITAARSNn7nMVvamh6g/2cDhb8mPDJ8dM0+lVJltp6um92jEWqO3A+ZgOAT73BoO31lEipmI1y
	VGy+JSX/IN/cRtMLyqzoONggk3YhEmXdVRZXwyIC33Nn2gT7sFrl/hqx2zAgId2ryBhiLJmqbYrBh
	+oNVnICubueFwDcECqYq8+IAkGJbh7mqBbpuC8O2kYWkyeYytggbP5IHfFrBIOs0wh1e81VtaFwkD
	uhFX0AZnhCYdiYc/RSX46aB08tIjjLE1bvjvTBiclXCaYvdpp1EacEwRjR4agaZ3AY7MPNwdTckfc
	y4zK0QBA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57612)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tKeeg-0000w1-1v;
	Mon, 09 Dec 2024 14:22:35 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tKeed-00022f-2h;
	Mon, 09 Dec 2024 14:22:31 +0000
Date: Mon, 9 Dec 2024 14:22:31 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: [PATCH net-next 00/10] net: add phylink managed EEE support
Message-ID: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
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

Adding managed EEE support to phylink has been on the cards ever since
the idea in phylib was mooted. This overly large series attempts to do
so. I've included all the patches as it's important to get the driver
patches out there.

Patch 1 adds a definition for the clock stop capable bit in the PCS
MMD status register.

Patch 2 adds a phylib API to query whether the PHY allows the transmit
xMII clock to be stopped while in LPI mode. This capability is for MAC
drivers to save power when LPI is active, to allow them to stop their
transmit clock.

Patch 3 adds another phylib API to configure whether the receive xMII
clock may be disabled by the PHY. We do have an existing API,
phy_init_eee(), but... it only allows the control bit to be set which
is weird - what if a boot firmware or previous kernel has set this bit
and we want it clear?

Patch 4 starts on the phylink parts of this, extracting from
phylink_resolve() the detection of link-up. (Yes, okay, I could've
dropped this patch, but with 23 patches, it's not going to make that
much difference.)

Patch 5 adds phylink managed EEE support. Two new MAC APIs are added,
to enable and disable LPI. The enable method is passed the LPI timer
setting which it is expected to program into the hardware, and also a
flag ehther the transmit clock should be stopped.

 *** There are open questions here. Eagle eyed reviewers will notice
   pl->config->lpi_interfaces. There are MACs out there which only
   support LPI signalling on a subset of their interface types. Phylib
   doesn't understand this. I'm handling this at the moment by simply
   not activating LPI at the MAC, but that leads to ethtool --show-eee
   suggesting that EEE is active when it isn't.
 *** Should we pass the phy_interface_t to these functions?
 *** Should mac_enable_tx_lpi() be allowed to fail if the MAC doesn't
   support the interface mode?

The above questions remain unanswered from the RFC posting of this
series.

A change that has been included over the RFC version is the addition
of the mac_validate_tx_lpi() method, which allows MAC drivers to
validate the parameters to the ethtool set_eee() method. Implementations
of this are in mvneta and mvpp2.

An example of a MAC that this is the case are the Marvell ones - both
NETA and PP2 only support LPI signalling when connected via SGMII,
which makes being connected to a PHY which changes its link mode
problematical.

The remainder of the patches address the driver sides, which are
necessary to actually test phylink managed EEE.

 drivers/net/ethernet/marvell/mvneta.c            | 127 +++++++++++--------
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h       |   5 +
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c  |  98 +++++++++++++++
 drivers/net/ethernet/microchip/lan743x_ethtool.c |  21 ----
 drivers/net/ethernet/microchip/lan743x_main.c    |  39 ++++--
 drivers/net/ethernet/microchip/lan743x_main.h    |   1 -
 drivers/net/phy/phy.c                            |  47 ++++++-
 drivers/net/phy/phylink.c                        | 150 +++++++++++++++++++++--
 include/linux/phy.h                              |   2 +
 include/linux/phylink.h                          |  59 +++++++++
 include/uapi/linux/mdio.h                        |   1 +
 11 files changed, 458 insertions(+), 92 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

