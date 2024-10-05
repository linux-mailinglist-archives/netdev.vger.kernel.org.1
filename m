Return-Path: <netdev+bounces-132408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B907799189D
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 18:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9CAD1C21101
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 16:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0CB1586CB;
	Sat,  5 Oct 2024 16:59:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD9215531A;
	Sat,  5 Oct 2024 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728147561; cv=none; b=rZ65oT6Ua1c33+85GAlGkgj2JHOFd0Bc5+sTkrNr+PpaHtL+kd/5zm/gULRiSiMx9XxPbATz4TIaJKmlpJ0ZEhRxwp3WRhWWBZOP9Cdj321E2PZLz6tlB1PSVeQvhPm35C6EdWOOT1MDXOlCOICFC3X1U6eIh5oHpUBWWSepqok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728147561; c=relaxed/simple;
	bh=K+d+p5QqIfVdqp85SspcQuxl+jVmdiqeQ1RiL0GZcAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H48FAWb5hPgKAN2lMuhlAL9WnHNtq62MObtjrV6fkFDggbDoyzOgwiPg4VAc25A/yeO7kqjzOCjEuTwwPTIapHFVhUlTiys2X7km7RMsmXwePt0cDpc4/U3KspEBy5L48mg9GGuNXpcgbj4amFhZvoQsNfsJB/IyicTm2kab488=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sx87c-000000004DW-3Qqy;
	Sat, 05 Oct 2024 16:59:12 +0000
Date: Sat, 5 Oct 2024 17:59:08 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next] net: phy: always set polarity_modes if op
 is supported
Message-ID: <ZwFwXBbMFeIZNntQ@makrotopia.org>
References: <473d62f268f2a317fd81d0f38f15d2f2f98e2451.1728056697.git.daniel@makrotopia.org>
 <5c821b2d-17eb-4078-942f-3c1317b025ff@lunn.ch>
 <ZwBn-GJq3BovSJd4@makrotopia.org>
 <e288f85c-2e5e-457f-b0d7-665c6410ccb4@lunn.ch>
 <ZwFggnUO-vAXr2v_@makrotopia.org>
 <2b6f2938-12de-4ebb-9750-084de5d2af0b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b6f2938-12de-4ebb-9750-084de5d2af0b@lunn.ch>

On Sat, Oct 05, 2024 at 06:35:58PM +0200, Andrew Lunn wrote:
> On Sat, Oct 05, 2024 at 04:51:30PM +0100, Daniel Golle wrote:
> > On Sat, Oct 05, 2024 at 04:17:56PM +0200, Andrew Lunn wrote:
> > > > I'll add "active-high" as an additional property then, as I found out
> > > > that both, Aquantia and Intel/MaxLinear are technically speaking
> > > > active-low by default (ie. after reset) and what we need to set is a
> > > > property setting the LED to be driven active-high (ie. driving VDD
> > > > rather than GND) instead. I hope it's not too late to make this change
> > > > also for the Aquantia driver.
> > > 
> > > Adding a new property should not affect backwards compatibility, so it
> > > should be safe to merge at any time.
> > 
> > Ok, I will proceed in that direction then and post a patch shortly.
> > My intial assumption that absence of 'active-low' would always imply
> > the LED being driven active-high was due to the commit description of
> > the introduction of the active-low property:
> > 
> > commit c94d1783136eb66f2a464a6891a32eeb55eaeacc
> > Author: Christian Marangi <ansuelsmth@gmail.com>
> > Date:   Thu Jan 25 21:36:57 2024 +0100
> > 
> >     dt-bindings: net: phy: Make LED active-low property common
> > 
> >     Move LED active-low property to common.yaml. This property is currently
> >     defined multiple times by bcm LEDs. This property will now be supported
> >     in a generic way for PHY LEDs with the use of a generic function.
> > 
> >     With active-low bool property not defined, active-high is always
> >     assumed.
> 
> So we have a difference between the commit message and what the
> binding actually says. I would go by what the binding says.

+1

> 
> However, what about the actual implementations? Do any do what the
> commit message says?

The current implementation for PHY LEDs:
 - 'active-low' property is present: Change LED polarity (in many cases
   wrongly from initially being active-low to active-high).
 - 'active-low' property is not set: Don't touch polarity settings.

See drivers/net/phy/phy_device.c, from line 3360:
        if (of_property_read_bool(led, "active-low"))
                set_bit(PHY_LED_ACTIVE_LOW, &modes);
        if (of_property_read_bool(led, "inactive-high-impedance"))
                set_bit(PHY_LED_INACTIVE_HIGH_IMPEDANCE, &modes);
 
        if (modes) {
                /* Return error if asked to set polarity modes but not supported */
                if (!phydev->drv->led_polarity_set)
                        return -EINVAL;
 
                err = phydev->drv->led_polarity_set(phydev, index, modes);
                if (err)
                        return err;
        }

led_polarity_set() is not called if neither 'active-low' nor
'inactive-high-impedance' are set.

