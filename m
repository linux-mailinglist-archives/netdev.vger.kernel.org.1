Return-Path: <netdev+bounces-61004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C723E822245
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 20:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0563FB20F9F
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 19:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6780815E9F;
	Tue,  2 Jan 2024 19:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ucM9RwU4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEAB15E97
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 19:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GK7ohoY1pbrtZO07doSQp+gcs5kdn4HCPhJRWxtyZ6c=; b=ucM9RwU4tzkMgnuK76O734u22s
	39TU+Y3zEbSIjPgZSuOhXgSWojOY02HcevkLl7o03ov9pbeMCFHFkob4PcEuE5MGy6KHde5Cer+6I
	uHLO3jRudzJZk/QF6hPIFlx6dAgIkq9DYbcqD08QxrCzmi9BzWOOPVmFCB7hYk0FnQJY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rKklH-004CJL-7t; Tue, 02 Jan 2024 20:49:15 +0100
Date: Tue, 2 Jan 2024 20:49:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ezra Buehler <ezra@easyb.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Tristram Ha <Tristram.Ha@microchip.com>,
	Michael Walle <michael@walle.cc>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: mdio: Prevent Clause 45 scan on SMSC PHYs
Message-ID: <7e0d6081-f777-4f40-b0be-a12171f772f4@lunn.ch>
References: <20240101213113.626670-1-ezra.buehler@husqvarnagroup.com>
 <77fa1435-58e3-4fe1-b860-288ed143e7bc@gmail.com>
 <1297166c-38c1-4041-8a7f-403477b871cf@lunn.ch>
 <8eb06ee9-d02d-4113-ba1e-e8ee99acc2fd@gmail.com>
 <2013fa64-06a1-4b61-90dc-c5bd68d8efed@lunn.ch>
 <CAM1KZSn0+k4YKc2qy6DEafkL840ybjaun7FbD4OFwOwNZw_LEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM1KZSn0+k4YKc2qy6DEafkL840ybjaun7FbD4OFwOwNZw_LEg@mail.gmail.com>

> By skimming over some datasheets for similar SMSC/Microchip PHYs, I
> could not find any evidence that they support Clause 45 scanning
> (other than not responding).

Do you find any reference to Clause 22 scanning being supported in the
datasheets?

What we expect is that C22 registers 2 and 3 contain ID values. If
there is no device at the address on the bus, nothing should respond,
and the pull up on the bus should result in a read of 0xffff. If we
get a value other than 0xffff, we know there is a device there. The
same is basically true for C45, but because each address has 32 MMD
spaces, its a bit more complex. But still, if there is no device
there, it should return 0xffff when reading an ID register. This is
all part of IEEE 802.3, so there is no real need to specific this in
the datasheet, other than to say its conformance to 802.3, or list
where it does not conform.

> 
> > drivers/net/phy/smsc.c has a number of phy_write_mmd()/phy_read_mmd()
> > in it. But that device has a different OUI.
> 
> I guess I am confused here, AFAICT all PHYs in smsc.c have the same OUI
> (phy_id >> 10).

My error. I forgot about the odd shift. So smsc.c does use the 01f0
OUI.

> > However, the commit message says:
> >
> > > Running a Clause 45 scan on an SMSC/Microchip LAN8720A PHY will (at
> > > least with our setup) considerably slow down kernel startup and
> > > ultimately result in a board reset.
> >
> > So we need to clarify the real issue here. Does the C45 scan work
> > correctly, but the board watchdog timer is too short and fires? We
> > should not be extended this workaround when its a bad watchdog
> > configuration issue...
> 
> Changing the watchdog configuration is not an option here. We are
> talking about a slowdown of several seconds here, that is not acceptable
> on its own.

I'm with Russell here, we should understand why its so slow. And by
fixing that, you might find access in general gets better.

       Andrew


