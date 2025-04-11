Return-Path: <netdev+bounces-181813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19AFA8683A
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1693B4BCC
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 21:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7AE279349;
	Fri, 11 Apr 2025 21:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vRPSt8Nk"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD8F298CAB
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 21:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744406789; cv=none; b=Ap1n+ORa9L6cd/uedtM2Arlg5IPgGp98FSsrnicvOSLV1DZ7rNsejRPjaWypT+IibC9Iab43PY47TeeVWwZzlkf/e74I01G0WWK+D6u++CUSeJiTx8gpioN7sJly71zBuEpiuw++nuvXh1pPdHiY4hKzw2S32Z8qF5bS1YIT8YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744406789; c=relaxed/simple;
	bh=4FOnzUK0CnUdgBPPx1D937tWdRrinepuTK52wpUJg1I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ENsJPtGCYyXtPbF6Ps053A3LUECdTO99Lwz3jmbwXO/A8Oyz1rnSTjeIR9vthyRNHWllppQT/CLqUWfeOPtxm9h0TRWYWSUf/5qcxTBlS/kubMO3k9pHspUL9lvO9i7r4dE2HRE01gVMLKbE0dHNcWDmNGcUqSumDXwbJnAhVVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vRPSt8Nk; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=s6mMboaFKsC5gzPhm03rlKp3f74qjmNq5mKQ8hxjpU0=; b=vRPSt8NkE5g1r3ruC5jlkX+LIN
	q3/lsinSGK3NCQillOrn5rtB4JXxHug7HDLq3xPp0Lh09bOPRjfg68HkGz78biGTsyTTchzJBtUHt
	fSMOpndbjrlCIsKA44q0GGPcUsJ2VY9ugr+ny9ryFQaBafuO+ADbe4Hl7W+lgG3qzbGkGMt8gZEU2
	Rg3FmAU+ncFouZEBDh84ln7aK+dsrGdR3ug4lN40eD3uxUDreP2sst9nR5JpqLd0O3DRaGPVv9kj0
	9p7uU5GXV9qOlo+qH9Lvhs2oPzZEyPIGG/nyrVm0Xmi04/TgC0hqF1/OL1FLgIJm6LNzz6Qp7B+uI
	UlkcQISg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35600)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u3LtD-0003rS-0B;
	Fri, 11 Apr 2025 22:26:19 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u3Lt9-0004ww-1r;
	Fri, 11 Apr 2025 22:26:15 +0100
Date: Fri, 11 Apr 2025 22:26:15 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH RFC net-next 0/5] Marvell PTP support
Message-ID: <Z_mI94gkKkBslWmv@shell.armlinux.org.uk>
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

This series is a work in progress, and represents the current state of
things, superseding Kory's patches which were based in a very old
version of my patches - and my patches were subsequently refactored
and further developed about five years ago. Due to them breaking
mvpp2 if merged, there was no point in posting them until such time
that the underlying issues with PTP were resolved - and they now have
been.

Marvell re-uses their PTP IP in several of their products - PHYs,
switches and even some ethernet MACs contain the same IP. It really
doesn't make sense to duplicate the code in each of these use cases.

Therefore, this series introduces a Marvell PTP core that can be
re-used - a TAI module, which handles the global parts of the PTP
core, and the TS module, which handles the per-port timestamping.

I will note at this point that although the Armada 388 TRM states that
NETA contains the same IP, attempts to access the registers returns
zero, and it is not known if that is due to the board missing something
or whether it isn't actually implemented. I do have some early work
re-using this, but when I discovered that the TAI registers read as
zero and wouldn't accept writes, I haven't progressed that.

Today, I have converted the mv88e6xxx DSA code to use the Marvell TAI
module from patch 1, and for the sake of getting the code out there,
I have included the "hacky" patches in this series - with the issues
with DSA VLANs that I reported this evening and subsequently
investigated, I've not had any spare time to properly prepare that
part of this series. (Being usurped from phylink by stmmac - for which
I have a big stack of patches that I can't get out because of being
usurped, and then again by Marvell PTP, and then again by DSA VLAN
stuff... yea, I'm feeling like I have zero time to do anything right
now.) The mv88e6xxx DSA code still needs to be converted to use the
Marvell TS part of patch 1, but I won't be able to test that after
Sunday, and I'm certainly not working on this over this weekend.

Anyway, this is what it is - and this is likely the state of it for
a while yet, because I won't be able to sensibly access the hardware
for testing for an undefined period of time.

The PHY parts seem to work, although not 100% reliably, with the
occasional overrun, particularly on the receive side. I'm not sure
whether this is down to a hardware bug or not, or MDIO driver bug,
because we certainly aren't missing timestamping a SKB. This has been
tested at L2 and L4.

I'm not sure which packets we should be timestamping (remembering
that this is global config across all ports.)
https://chronos.uk/wordpress/wp-content/uploads/TechnicalBrief-IEEE1588v2PTP.pdf
suggests Sync, Delay_req and Delay_resp need to be timestamped,
possibly PDelay_req and PDelay_resp as well, but I haven't seen
those produced by PTPDv2 nor ptp4l.

There's probably other stuff I should mention, but as I've been at
this into the evening for almost every day this week, I'm mentally
exhausted.

Sorry also if this isn't coherent.

 drivers/net/dsa/mv88e6xxx/Kconfig               |   1 +
 drivers/net/dsa/mv88e6xxx/chip.h                |  26 +-
 drivers/net/dsa/mv88e6xxx/hwtstamp.c            |  17 +-
 drivers/net/dsa/mv88e6xxx/hwtstamp.h            |   1 +
 drivers/net/dsa/mv88e6xxx/ptp.c                 | 519 ++++++++-------------
 drivers/net/dsa/mv88e6xxx/ptp.h                 |   1 -
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c |   2 +
 drivers/net/phy/Kconfig                         |  13 +
 drivers/net/phy/Makefile                        |   1 +
 drivers/net/phy/marvell.c                       |  21 +-
 drivers/net/phy/marvell_ptp.c                   | 307 ++++++++++++
 drivers/net/phy/marvell_ptp.h                   |  21 +
 drivers/ptp/Kconfig                             |   4 +
 drivers/ptp/Makefile                            |   2 +
 drivers/ptp/ptp_marvell_tai.c                   | 449 ++++++++++++++++++
 drivers/ptp/ptp_marvell_ts.c                    | 593 ++++++++++++++++++++++++
 include/linux/marvell_ptp.h                     | 129 ++++++
 17 files changed, 1764 insertions(+), 343 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

