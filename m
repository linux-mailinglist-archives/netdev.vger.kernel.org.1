Return-Path: <netdev+bounces-147763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547029DB9F9
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 15:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE8D1644B1
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 14:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602131B2190;
	Thu, 28 Nov 2024 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZEZXvS2j"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1CF25761;
	Thu, 28 Nov 2024 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732805701; cv=none; b=r8oqAt6JQKCTp03I2BRAyPoBxNFdl2oSbGUCbwSGdVgoD/kDipREYAdqj0/agkLQ0IYy5vTDaiBkoLTdHM+f81e/Py6dbvE9ctF9j7vybWSFAV62CtcD6dpDTgVq5OcJ/NCG2qFIKE/9pHA6J5SDltHgpAb4dqszla5nbCB5x/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732805701; c=relaxed/simple;
	bh=oK5/ZfLAfITjssEqahd/DRUlrl74PB/u3ZIoqPO5Xp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqAQoketzLZc1kjLaG+9xfpzT+p5j5Z3XpDfGSNgjkDqK2b7fhLAlCac40EyIR4t7i71DPQaCFiTfNDvsk/pxudhl8Y5AxV6gsgCh1H30JMrsbNA3Rgn56SpnS6vVsT5mCFgASGMudkPuNfSeta31nUwGYURxYuyQygQLo54DVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZEZXvS2j; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=07eZLac9ud6nmkcZrKjIbBNlfOQ1ZTo1Ed25V+4ovnY=; b=ZE
	ZXvS2jS+V/aPeNgWSa1MnaQP91+4gTLqgBMyQ114EzGNLpCusrI83fLfgM7jV8N7ScMDi+DddoptI
	hZ1G1484vxq/rmNjSHWCPRuUjR2+cdYW9zHf57r7ylMrr99HaAaRtOeK1K/CRNGnZ18iZXivUqQlk
	Te7O75DKELfEFvo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tGfuu-00EiLw-Uk; Thu, 28 Nov 2024 15:54:52 +0100
Date: Thu, 28 Nov 2024 15:54:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc: netdev <netdev@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] PHY: Fix no autoneg corner case
Message-ID: <2428ec56-f2db-4769-aaca-ca09e57b8162@lunn.ch>
References: <m3plmhhx6d.fsf@t19.piap.pl>
 <c57a8f12-744c-4855-bd18-2197a8caf2a2@lunn.ch>
 <m3wmgnhnsb.fsf@t19.piap.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m3wmgnhnsb.fsf@t19.piap.pl>

On Thu, Nov 28, 2024 at 07:31:48AM +0100, Krzysztof Hałasa wrote:
> Andrew,
> 
> Andrew Lunn <andrew@lunn.ch> writes:
> 
> >> Unfortunately it's initially set based on the supported capability
> >> rather than the actual hw setting.
> >
> > We need a clear definition of 'initially', and when does it actually
> > matter.
> >
> > Initially, things like speed, duplex and set to UNKNOWN. They don't
> > make any sense until the link is up. phydev->advertise is set to
> > phydev->supported, so that we advertise all the capabilities of the
> > PHY. However, at probe, this does not really matter, it is only when
> > phy_start() is called is the hardware actually configured with what it
> > should advertise, or even if it should do auto-neg or not.
> >
> > In the end, this might not matter.
> 
> Nevertheless, it seems it does matter.
> 
> >> While in most cases there is no
> >> difference (i.e., autoneg is supported and on by default), certain
> >> adapters (e.g. fiber optics) use fixed settings, configured in hardware.
> >
> > If the hardware is not capable of supporting autoneg, why is autoneg
> > in phydev->supported? To me, that is the real issue here.
> 
> Well, autoneg *IS* supported by the PHY in this case.
> No autoneg in phydev->supported would mean I can't enable it if needed,
> wouldn't it?
> 
> It is supported but initially disabled.
> 
> With current code, PHY correctly connects to the other side, all the
> registers are valid etc., the PHY indicates, for example, a valid link
> with 100BASE-FX full duplex etc.
> 
> Yet the Linux netdev, ethtool etc. indicate no valid link, autoneg on,
> and speed/duplex unknown. It's just completely inconsistent with the
> real hardware state.
> 
> It seems the phy/phylink code assumes the PHY starts with autoneg
> enabled (if supported). This is simply an incorrect assumption.

This is sounding like a driver bug. When phy_start() is called it
kicks off the PHY state machine. That should result in
phy_config_aneg() being called. That function is badly named, since it
is used both for autoneg and forced setting. The purpose of that call
is to configure the PHY to the configuration stored in
phydev->advertise, etc. So if the PHY by hardware defaults has autoneg
disabled, but the configuration in phydev says it should be enabled,
calling phy_config_aneg() should actually enabled autoneg. It is
possible there is a phylib bug here, because we try to not to kick off
autoneg if it is not needed, because it is slow. I've not looked at
the code, but it could be we see there is link, and skip calling
phy_config_aneg()? Maybe try booting with the cable disconnected so
there is no link?

> BTW if the code meant to enable autoneg, it would do exactly that -
> enable it by writing to PHY command register.

Assuming bug free code.

> Then the hw and sw state
> would be consistent again (though initial configuration would be
> ignored, not very nice). Now the code doesn't enable autoneg, it only
> *indicates* it's enabled and in reality it's not.

I would say there are two different issues here.

1) It seems like we are not configuring the hardware to match phydev.
2) We are overwriting how the bootloader etc configured the hardware.

2) is always hard, because how do we know the PHY is not messed up
from a previous boot/crash cycle etc. In general, a driver should try
to put the hardware into a well known state. If we have a clear use
case for this, we can consider how to implement it.

	Andrew

