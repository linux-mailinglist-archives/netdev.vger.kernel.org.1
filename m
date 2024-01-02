Return-Path: <netdev+bounces-60894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8962821CF6
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 14:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57DDA286C44
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 13:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D22FFBEF;
	Tue,  2 Jan 2024 13:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WYUrWrob"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B06211C8A
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1vT57HHsXRU/zM0JQghGfD4NR7J5y4rS9QGv+G0Wyyc=; b=WYUrWrobD5xFZ+hZMZxzy3kTtZ
	zh7HP7d0+eUIfnqcOeA53+g3iHKlgCvZUoAWigw80B3t0R+OoV/mPE4EtngkHiarjVMH6lVI4GTZn
	alAVxHagvOS591BgK8DivZWbiRd37CDuSgVtBnL4ZLJyEPPVcXXL4wRoVs7V/DPTMtLs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rKf29-004AYk-Lu; Tue, 02 Jan 2024 14:42:17 +0100
Date: Tue, 2 Jan 2024 14:42:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: ezra@synergy-village.org, Russell King <linux@armlinux.org.uk>,
	Tristram Ha <Tristram.Ha@microchip.com>,
	Michael Walle <michael@walle.cc>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: mdio: Prevent Clause 45 scan on SMSC PHYs
Message-ID: <1297166c-38c1-4041-8a7f-403477b871cf@lunn.ch>
References: <20240101213113.626670-1-ezra.buehler@husqvarnagroup.com>
 <77fa1435-58e3-4fe1-b860-288ed143e7bc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77fa1435-58e3-4fe1-b860-288ed143e7bc@gmail.com>

On Mon, Jan 01, 2024 at 11:44:38PM +0100, Heiner Kallweit wrote:
> On 01.01.2024 22:31, Ezra Buehler wrote:
> > Since commit 1a136ca2e089 ("net: mdio: scan bus based on bus
> > capabilities for C22 and C45") our AT91SAM9G25-based GARDENA smart
> > Gateway will no longer boot.
> > 
> > Prior to the mentioned change, probe_capabilities would be set to
> > MDIOBUS_NO_CAP (0) and therefore, no Clause 45 scan was performed.
> > Running a Clause 45 scan on an SMSC/Microchip LAN8720A PHY will (at
> > least with our setup) considerably slow down kernel startup and
> > ultimately result in a board reset.
> > 
> > AFAICT all SMSC/Microchip PHYs are Clause 22 devices. Some have a
> > "Clause 45 protection" feature (e.g. LAN8830) and others like the
> > LAN8804 will explicitly state the following in the datasheet:
> > 
> >     This device may respond to Clause 45 accesses and so must not be
> >     mixed with Clause 45 devices on the same MDIO bus.
> > 
> 
> I'm not convinced that some heuristic based on vendors is a
> sustainable approach. Also I'd like to avoid (as far as possible)
> that core code includes vendor driver headers. Maybe we could use
> a new PHY driver flag. Approaches I could think of:

We already have a core hack for these broken PHYs:

/*
 * There are some C22 PHYs which do bad things when where is a C45
 * transaction on the bus, like accepting a read themselves, and
 * stomping over the true devices reply, to performing a write to
 * themselves which was intended for another device. Now that C22
 * devices have been found, see if any of them are bad for C45, and if we
 * should skip the C45 scan.
 */
static bool mdiobus_prevent_c45_scan(struct mii_bus *bus)
{
        int i;

        for (i = 0; i < PHY_MAX_ADDR; i++) {
                struct phy_device *phydev;
                u32 oui;

                phydev = mdiobus_get_phy(bus, i);
                if (!phydev)
                        continue;
                oui = phydev->phy_id >> 10;

                if (oui == MICREL_OUI)
                        return true;
        }
        return false;
}

So it seems we need to extend this with another OUI.

	Andrew

