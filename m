Return-Path: <netdev+bounces-78757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0438765BA
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 14:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4DD1C20B04
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 13:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500F623767;
	Fri,  8 Mar 2024 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="juRy3gWb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF0738387
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709906166; cv=none; b=UyxcOWNHdayihLaBfOT9Ahr+FeLHl2ruXtLMLx3WyRleqGCOyGNPVYRC61t51oyLygdpZM3/U9z06XVdLc7W8f9qaFzW8lF60XLC5AcriNqLnzMFCxvFKRoRT36fgrn9g27VrZF0xVqaa2XBMGnu3yR9C3WEnCkHc9qZhkYjPEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709906166; c=relaxed/simple;
	bh=jwqxhOdS5M9NP9yW+JCwh/2VuGMq9kNefZwXxNE3FWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mrt3XP/2jJaISxbwkGY8zAqiUX1dcduCGdDUygLRTQAIVw5WeCDtsIElD8Z5H5lLzEjhVoi8oXRNImOZ1ck4btPIaISNVIrT7bRcdYg6IXXuquHJ7cakC5Z7DE+Ahp0MU9NJadouf9l6sDNaWiHvxNi3QmQZCdYCvMZYYpfQLkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=juRy3gWb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=cyDzGGnplDHenq/0riLCEFvoHYTLvOAG3G8mTfhOCdc=; b=ju
	Ry3gWb+P+ob5sTkGM1CpF4jm1VhL9Drm0ZlGirM0Yk4tTkWrsOJonts2YR0Lp7Mo7a1+bURVkR06l
	3RgFVAyKn+4LHU8Vz+8ZzkYIz7GoVynR/aKTlFLscuLoTe7ImsZLsyn7ruXKvW51ZD/O7b60j9qDu
	EHbV1flarwwFh/s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1riai6-009mlR-9A; Fri, 08 Mar 2024 14:56:30 +0100
Date: Fri, 8 Mar 2024 14:56:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Sagar Dhoot (QUIC)" <quic_sdhoot@quicinc.com>
Cc: "mkubecek@suse.cz" <mkubecek@suse.cz>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Nagarjuna Chaganti (QUIC)" <quic_nchagant@quicinc.com>,
	"Priya Tripathi (QUIC)" <quic_ppriyatr@quicinc.com>
Subject: Re: Ethtool query: Reset advertised speed modes if speed value is
 not passed in "set_link_ksettings"
Message-ID: <fb8b2333-cde2-4ec4-9382-f3a563954d06@lunn.ch>
References: <CY8PR02MB95678EBD09E287FBE73076B9F9202@CY8PR02MB9567.namprd02.prod.outlook.com>
 <945530a2-c8e9-49fd-95ce-b39388bd9a95@lunn.ch>
 <CY8PR02MB956757D131ED149C97F7D0DBF9272@CY8PR02MB9567.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY8PR02MB956757D131ED149C97F7D0DBF9272@CY8PR02MB9567.namprd02.prod.outlook.com>

On Fri, Mar 08, 2024 at 06:33:00AM +0000, Sagar Dhoot (QUIC) wrote:
> Hi Andrew,
> 
> Thanks for the quick response. Maybe I have put up a confusing scenario.
> 
> Let me rephrase with autoneg on.
> 
> 1. "ethtool eth_interface"
> 2. "ethtool -s eth_interface speed 25000 autoneg on"

phylib will ignore speed if autoneg is on

https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/phy.c#L1044

It only copies speed/duplex when autoneg is off.

	if (autoneg == AUTONEG_DISABLE) {
		phydev->speed = speed;
		phydev->duplex = duplex;
	}

When configuring the PHY:

https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/phy_device.c#L2234

	if (AUTONEG_ENABLE != phydev->autoneg)
		return genphy_setup_forced(phydev);

So we only force the PHY when autoneg is off, and it is
genphy_setup_forced() which uses this speed/duplex.

If you are trying to influence the link mode while autoneg is
enabled, you should be using advertise N

          advertise N
                  Sets the speed and  duplex  advertised  by  autonegotiation.
                  The  argument is a hexadecimal value using one or a combina‐
                  tion of the following values:
                  0x001                          10baseT Half
                  0x002                          10baseT Full
                  0x100000000000000000000000     10baseT1L Full
                  0x8000000000000000000000000    10baseT1S Full
                  0x10000000000000000000000000   10baseT1S Half
                  0x20000000000000000000000000   10baseT1S_P2MP Half
                  0x004                          100baseT Half
                  0x008                          100baseT Full

I think the hexadecimal part is out of date and you can now also use
symbolic names.

Another thing to think about. What does the speed here actually mean:

> 2. "ethtool -s eth_interface speed 25000 autoneg on"

phylib assumes it is the baseT speed:

        ETHTOOL_LINK_MODE_10baseT_Half_BIT      = 0,
        ETHTOOL_LINK_MODE_10baseT_Full_BIT      = 1,
        ETHTOOL_LINK_MODE_100baseT_Half_BIT     = 2,
        ETHTOOL_LINK_MODE_100baseT_Full_BIT     = 3,
        ETHTOOL_LINK_MODE_1000baseT_Half_BIT    = 4,
        ETHTOOL_LINK_MODE_1000baseT_Full_BIT    = 5,

However, what does 25000 mean? We currently don't have a
25000BaseT. So how do you decide which of the following to select:

        ETHTOOL_LINK_MODE_25000baseCR_Full_BIT  = 31,
        ETHTOOL_LINK_MODE_25000baseKR_Full_BIT  = 32,
        ETHTOOL_LINK_MODE_25000baseSR_Full_BIT  = 33,

This is where advertise N is much better, an actual linkmode, not just
a speed.

	 Andrew


