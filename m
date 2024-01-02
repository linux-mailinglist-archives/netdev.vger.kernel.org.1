Return-Path: <netdev+bounces-60918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 931BA821D93
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 15:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC5C2B221DE
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 14:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE2C10955;
	Tue,  2 Jan 2024 14:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UkK68bMR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14159111BB
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ibHLYwAjcl76zjO2C+zQyU5QchckEvpJ/gIPTiFTzQ0=; b=UkK68bMRWtalUnQ2jhdo17Z0AA
	C2xrMpSbsHQ0y6Sbih/hsyS7BKDnTXC0I59sEH5El0dokXcIHYeMk1Ot4DDYF1sM5K99qRhszvpBv
	NAX2hXkLZ5qjWXHQ0J0WZdrI1WFyNoOVA9UqbaU9k7N6W0jbw6ry83bMtzaGSYmVEb5F5Q7vWjyDx
	ZeRBvY50yF3PnI7edN2SwZiyxr5P1CsmqaFqcNy5QKhsA98T3ZkAr0xzR3Emt9Ts095hcvIWoPGfh
	8GVoO/S8oGhP2AojWiSF8sm+tFhrh5dowhQfAq8Vz8w9mqy2YpL8u/KSqUHwPAHi5bg+KpMrPkZJ0
	90S3p8Gg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37498)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKfgm-0006cU-1d;
	Tue, 02 Jan 2024 14:24:16 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKfgn-0005N3-NL; Tue, 02 Jan 2024 14:24:17 +0000
Date: Tue, 2 Jan 2024 14:24:17 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next] net: phylink: avoid one unnecessary
 phylink_validate() call during phylink_create()
Message-ID: <ZZQckTKmEjSbgCDo@shell.armlinux.org.uk>
References: <20231214170659.868759-1-vladimir.oltean@nxp.com>
 <ZXs467Epke85f0Im@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXs467Epke85f0Im@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 14, 2023 at 05:18:35PM +0000, Russell King (Oracle) wrote:
> I'll say this for the benefit of the netdev developers - my time is
> currently being spent elsewhere (e.g. ARM64 VCPU hotplug) so I don't
> have a lot of time to review netdev patches. With only a few days
> left to Christmas vacations and my intention not to work over that
> period, this means that I'm unlikely to be able to review changes
> such as this - and they do need review.
> 
> If I get some spare time, then I will review them.
> 
> However, probably best to wait until the new year before sending
> patches that touch phylink - which will involve adding stress on my
> side.

So... getting back to this as I have platforms I can test with in front
of me now... On October 5th, you asked by email what the purpose of
this was. I replied same day, stating the purpose of it, citing mvneta.
I did state in that email about reporting "absolutely nothing" to
userspace, but in fact it's the opposite - without this validate()
call, we report absolutely everything.

With it removed, booting my Armada 388 Clearfog platform with the
ethernet interface not having been brought up, and then running ethtool
on it, this is what I get:

# ethtool eno0
Settings for eno0:
        Supported ports: [ TP    AUI     MII     FIBRE   BNC     Backplane ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Half 1000baseT/Full
                                10000baseT/Full
                                2500baseX/Full
                                1000baseKX/Full
                                10000baseKX4/Full
                                10000baseKR/Full
                                10000baseR_FEC
                                20000baseMLD2/Full
                                20000baseKR2/Full
                                40000baseKR4/Full
                                40000baseCR4/Full
                                40000baseSR4/Full
                                40000baseLR4/Full
                                56000baseKR4/Full
                                56000baseCR4/Full
                                56000baseSR4/Full
                                56000baseLR4/Full
                                25000baseCR/Full
                                25000baseKR/Full
                                25000baseSR/Full
                                50000baseCR2/Full
                                50000baseKR2/Full
                                100000baseKR4/Full
                                100000baseSR4/Full
                                100000baseCR4/Full
                                100000baseLR4_ER4/Full
                                50000baseSR2/Full
                                1000baseX/Full
                                10000baseCR/Full
                                10000baseSR/Full
                                10000baseLR/Full
                                10000baseLRM/Full
                                10000baseER/Full
                                2500baseT/Full
                                5000baseT/Full
                                50000baseKR/Full
                                50000baseSR/Full
                                50000baseCR/Full
                                50000baseLR_ER_FR/Full
                                50000baseDR/Full
                                100000baseKR2/Full
                                100000baseSR2/Full
                                100000baseCR2/Full
                                100000baseLR2_ER2_FR2/Full
                                100000baseDR2/Full
                                200000baseKR4/Full
                                200000baseSR4/Full
                                200000baseLR4_ER4_FR4/Full
                                200000baseDR4/Full
                                200000baseCR4/Full
                                100baseT1/Full
                                1000baseT1/Full
                                400000baseKR8/Full
                                400000baseSR8/Full
                                400000baseLR8_ER8_FR8/Full
                                400000baseDR8/Full
                                400000baseCR8/Full
                                100000baseKR/Full
                                100000baseSR/Full
                                100000baseLR_ER_FR/Full
                                100000baseCR/Full
                                100000baseDR/Full
                                200000baseKR2/Full
                                200000baseSR2/Full
                                200000baseLR2_ER2_FR2/Full
                                200000baseDR2/Full
                                200000baseCR2/Full
                                400000baseKR4/Full
                                400000baseSR4/Full
                                400000baseLR4_ER4_FR4/Full
                                400000baseDR4/Full
                                400000baseCR4/Full
                                100baseFX/Half 100baseFX/Full
                                10baseT1L/Full
                                800000baseCR8/Full
                                800000baseKR8/Full
                                800000baseDR8/Full
                                800000baseDR8_2/Full
                                800000baseSR8/Full
                                800000baseVR8/Full
                                10baseT1S/Full
                                10baseT1S/Half
                                10baseT1S_P2MP/Half
        Supported pause frame use: Symmetric Receive-only
        Supports auto-negotiation: Yes
        Supported FEC modes: None        RS      BASER   LLRS
        Advertised link modes:  Not reported
        Advertised pause frame use: No
        Advertised auto-negotiation: No
        Advertised FEC modes: Not reported
        Speed: Unknown!
        Duplex: Half
        Auto-negotiation: off
        Port: MII
        PHYAD: 0
        Transceiver: internal
        Supports Wake-on: d
        Wake-on: d
        Link detected: no

Does that look like sensible output for a network interface that can
only do up to 2.5G speeds to you?

The phylink_validate() there serves to restrict the link modes to
something sensible in the case where we are expecting a PHY to be
attached to the interface, but the MAC driver attaches the PHY at
open time, but the network interface has yet to be opened.

So... I completely disagree with removing this phylink_validate()
call - it's there so we report something sane to userspace for
network drivers that attach PHYs at open time before that PHY is
attached.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

