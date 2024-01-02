Return-Path: <netdev+bounces-60937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6FE821F01
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 16:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3966E1C22357
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 15:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B580614A98;
	Tue,  2 Jan 2024 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rGQinfmC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BE714A82
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 15:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EVDn3Y0XNz8CjDsxaH7hM1RAHEjaxfnabhHRl2XbeNs=; b=rGQinfmCzeEh+CN/Db4GRvn6yR
	l/X7OybRulcY1G0Qhs9peC+XqWOo7Jnme94+XDDTvMZbu2UcHGRS4fLCDfNR1N8kU/dcKs4hrF7un
	MKjpOQ6KUMY2YkkwfLDrpXxoYQcm4ppfQq+ReKsKMjj7zRSn/O5cUfoVXDe4jxv3o1Fo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rKh27-004BGO-0A; Tue, 02 Jan 2024 16:50:23 +0100
Date: Tue, 2 Jan 2024 16:50:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: ezra@synergy-village.org, Russell King <linux@armlinux.org.uk>,
	Tristram Ha <Tristram.Ha@microchip.com>,
	Michael Walle <michael@walle.cc>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: mdio: Prevent Clause 45 scan on SMSC PHYs
Message-ID: <2013fa64-06a1-4b61-90dc-c5bd68d8efed@lunn.ch>
References: <20240101213113.626670-1-ezra.buehler@husqvarnagroup.com>
 <77fa1435-58e3-4fe1-b860-288ed143e7bc@gmail.com>
 <1297166c-38c1-4041-8a7f-403477b871cf@lunn.ch>
 <8eb06ee9-d02d-4113-ba1e-e8ee99acc2fd@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8eb06ee9-d02d-4113-ba1e-e8ee99acc2fd@gmail.com>

> Excluding all PHY's from a vendor for me is a quite big hammer.

Maybe it serves them right for getting this wrong?

Micrel is now part of Microchip, so in effect, this is the same broken
IP just with a different name and OUI. We have not seen any other
vendor get this wrong.

I do however disagree with this statement in the original patch:

> AFAICT all SMSC/Microchip PHYs are Clause 22 devices.

drivers/net/phy/smsc.c has a number of phy_write_mmd()/phy_read_mmd()
in it. But that device has a different OUI.

> I think we should make this more granular.
> And mdio-bus.c including micrel_phy.h also isn't too nice.
> Maybe we should move all OUI definitions in drivers to a
> core header. Because the OUI seems to be all we need from
> these headers.

That does seem a big change to make for 'one' broken PHY IP.

However, the commit message says:

> Running a Clause 45 scan on an SMSC/Microchip LAN8720A PHY will (at
> least with our setup) considerably slow down kernel startup and
> ultimately result in a board reset.

So we need to clarify the real issue here. Does the C45 scan work
correctly, but the board watchdog timer is too short and fires? We
should not be extended this workaround when its a bad watchdog
configuration issue...

       Andrew

