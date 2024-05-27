Return-Path: <netdev+bounces-98188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F00818D0134
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 15:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B61281AFA
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 13:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F09A15E5DD;
	Mon, 27 May 2024 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YWLM28g0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F43E4EB55
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816052; cv=none; b=olBW0oOHuRlMdHUa2iFdinqJtvBmOcs4Kg5Qq4Qr3ibhnUD7Ke1sfNcQzjVMtShr3mjnbBdouEk9AQLUDgaDYuXetkcIZbawodiV3A7MX8ynnpPcydkr7GwlyAs7pK1GOw22vptt+/6uPeZqoR8MGIXn7kEQz8RMvZ9OtFTSqu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816052; c=relaxed/simple;
	bh=3MkKkpmrskRT0NF+eJzt1tmnBR8XJm29Y5ePAg/pC44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WScWTFBwWyqwt86GX6GAN3bQ9hbgheuy3+dQri/4m5/hLFnlbVaRYJhSEIROeDCKGRGVt8jpNHDMNksPsdQsiDWj35HC9oAWeazMfWRuKvjGTEDx5SLTzI4ryHP378tsYW1j360gGRXdkVguTyUtR0H36ZQxEmLoMt5lmQp9uXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YWLM28g0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=oYvyGuL3FYNlT2/HXT/HMIfkTEQHXwOW5dyOd97dqms=; b=YW
	LM28g0Rj5s1wMmNsRCQHZSBQa7LOpZH61kBbLWe+jOmdLSyZ/GTSNh+In8WYSzL0Nw/FermcJmRiz
	gbaTUrGa6rgQ1nfPZuz2EDbAWLkJF8JaznezNJsrwjded3XZ2ybfwKTJgXmVNInBSqi1xzsAVmEfU
	1yqMAJUSvZqKbsU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sBaHH-00G4aH-NU; Mon, 27 May 2024 15:20:39 +0200
Date: Mon, 27 May 2024 15:20:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kamil =?iso-8859-1?B?SG9y4Wss?= 2N <kamilh@axis.com>
Cc: netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] net: phy: bcm54811: New link mode for BroadR-Reach
Message-ID: <79af2fc0-7439-4c6d-9059-048440c3a406@lunn.ch>
References: <20240506144015.2409715-1-kamilh@axis.com>
 <20240506144015.2409715-2-kamilh@axis.com>
 <25798e60-d1cc-40ce-b081-80afdb182dd6@lunn.ch>
 <96a99806-624c-4fa4-aa08-0d5c306cff25@axis.com>
 <b5c6b65b-d4be-4ebc-a529-679d42e56c39@lunn.ch>
 <c39dd894-bd63-430b-a60c-402c04f5dbf7@axis.com>
 <1188b119-1191-4afa-8381-d022d447086c@lunn.ch>
 <ed59ba76-ea86-4007-9b53-ebeb02951b34@axis.com>
 <44c85449-1a9b-4a5e-8962-1d2c37138f97@lunn.ch>
 <b9ce037f-8720-4a6c-8cfe-01bffee230c1@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9ce037f-8720-4a6c-8cfe-01bffee230c1@axis.com>

> > So IEEE and BRR autoneg are mutually exclusive. It would be good to
> > see if 802.3 actually says or implies that. Generic functions like
> > ksetting_set/get should be based on 802.3, so when designing the API
> > we should focus on that, not what the particular devices you are
> > interested in support.
> I am not sure about how to determine whether IEEE 802.3 says anything about
> the IEEE and BRR modes auto-negotiation mutual exclusivity - it is purely
> question of the implementation, in our case in the Broadcom PHYs.

CLause 22 and clause 45 might say something. e.g. the documentation
about BMSR_ANEGCAPABLE might indicate what link modes it covers.

> One of the
> BRR modes (1BR100) is direct equivalent of 100Base-T1 as specified in IEEE
> 802.3bw. As it requests different hardware to be connected, I doubt there is
> any (even theoretical) possibility to negotiate with a set of supported
> modes including let's say 100Base-T1 and 100Base-T.
> > 
> > We probably want phydev->supports listing all modes, IEEE and BRR. Is
> > there a bit equivalent to BMSR_ANEGCAPABLE indicating the hardware can
> > do BRR autoneg? If there is, we probably want to add a
> > ETHTOOL_LINK_MODE_Autoneg_BRR_BIT.
> There is "LDS Ability" (LRESR_LDSABILITY) bit in the LRE registers set of
> BCM54810, which is equivalent to BMSR_ANEGCAPABLE and it is at same position
> (bit 3 of the status register), so that just this could work.
> 
> But just in our case, the LDS Ability bit is "reserved" and "reads as 1"
> (BCM54811, BCM54501). So at least for these two it cannot be used as an
> indication of aneg capability.
> 
> LDS is "long-distance signaling" int he Broadcom's terminology, "a special
> new type of auto-negotiation"....

For generic code, we should go from what 802.3 says. Does clause 22 or
clause 45 define anything like LDS Ability? If you look at how 802.3
C22/C45 works, it is mostly self describing. You can read registers to
determine what the PHY supports. So it is possible to have generic
genphy_read_abilities() and genphy_c45_pma_read_abilities which does
most of the work. Ideally we just want to extend them to cover BBR
link modes.

> > ksetting_set should enforce this mutual exclusion. So
> > phydev->advertise should never be set containing invalid combination,
> > ksetting_set() should return an error.
> > 
> > I guess we need to initialize phydev->advertise to IEEE link modes in
> > order to not cause regressions. However, if the PHY does not support
> > any IEEE modes, it can then default to BRR link modes. It would also
> > make sense to have a standardized DT property to indicate BRR should
> > be used by default.
> 
> With device tree property it would be about the same situation as with phy
> tunable, wouldn't? The tunable was already in the first version of this
> patch and it (or DT property) is same type of solution, one knows in advance
> which set of link modes to use. I personally feel the DT as better method,
> because the IEEE/BRR selection is of hardware nature and cannot be easily
> auto-detected - exactly what the DT is for.

If we decide IEEE and BRR are mutually exclusive because of the
coupling, then this is clearly a hardware property. So DT, and maybe
sometime in the future ACPI, is the correct way to describe this.

> There is description of the LDS negotioation in BCM54810 datasheet saying
> that if the PHY detects standard Ethernet link pulses on a wire pair, it
> transitions automatically from BRR-LDS to Clause 28 auto-negotioation mode.
> Thus, at least the 54810 can be set so that it starts in BRR mode and if
> there is no BRR PHY at the other end and the other end is also set to
> auto-negotiate (Clause-28), the auto-negotiation continues in IEEE mode and
> potentially results in the PHY in IEEE mode. In this case, it would make
> sense to have both BRR and IEEE link modes in same list and just start with
> BRR, leaving on the PHY itself the decision to fall back to IEEE. The
> process would be sub-optimal in most use cases - who would use BRR PHY in
> hardwired IEEE circuit..?
> 
> However, I cannot promise to do such a driver because I do not have the
> BCM54810 available nor it is my task here.

That is fine. At the moment, we are just trying to explore all the
corners before we decide how this should work. 802.3 should be our
main guide, but also look at real hardware.

> OK so back to the proposed new parameter for ethtool, the "linkmode" would
> mean forced setting of  given link mode - so use the link_mode_masks as 1 of
> N or just pass the link mode number as another parameter?

The autoneg off should be enough to indicate what the passed link mode
means. However, it could also be placed into a new property it that
seems more logical for the API. When it comes to the internal API, i
think it will be a new member anyway.

	Andrew

