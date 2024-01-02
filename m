Return-Path: <netdev+bounces-60901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D17D6821D2E
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 15:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25EF1C21FF4
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 14:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116CFFC0D;
	Tue,  2 Jan 2024 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XzjsHMuA"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250ECFC08
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=J/6smZfOWkoR8/mi+p0Q4BCS59q/UR+Sakmr9kFJ1Y4=; b=XzjsHMuAiIh+T98w0ba2uPkKsI
	7ny/tIcRgS0lxcbgCnDNg/6+r41ogTyc3V8FjoXKG4GTPhddfioWkgIBqJwbWICd0ge3levwsU6wQ
	sVxKshRvTw7WnD1Bm8EHGCNzkCd+56FhZC3Yh/eC3w779f3PZjgeioZAd4PVHl1zf0EWuIQ1K8D5Q
	Z4IzBzTeKlVkWF8XZixKDAK+fNFyPk27APabiUsSvw3djedFCIXCrCrQ8xV9bNI89vNKVPhSj7fHA
	Mdto/JPlH4gTjmAoXfhBDyDE3HFqlOE11R6nKLkblFlLzDu0/QDwTk6632HZWlDpHKrDcyS+0kDyc
	0dASkbLA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51626)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKfJK-0006ab-0m;
	Tue, 02 Jan 2024 14:00:02 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKfJL-0005Ll-OC; Tue, 02 Jan 2024 14:00:03 +0000
Date: Tue, 2 Jan 2024 14:00:03 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, ezra@synergy-village.org,
	Tristram Ha <Tristram.Ha@microchip.com>,
	Michael Walle <michael@walle.cc>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: mdio: Prevent Clause 45 scan on SMSC PHYs
Message-ID: <ZZQW40bXteaiWDOZ@shell.armlinux.org.uk>
References: <20240101213113.626670-1-ezra.buehler@husqvarnagroup.com>
 <77fa1435-58e3-4fe1-b860-288ed143e7bc@gmail.com>
 <1297166c-38c1-4041-8a7f-403477b871cf@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1297166c-38c1-4041-8a7f-403477b871cf@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 02, 2024 at 02:42:17PM +0100, Andrew Lunn wrote:
> On Mon, Jan 01, 2024 at 11:44:38PM +0100, Heiner Kallweit wrote:
> > On 01.01.2024 22:31, Ezra Buehler wrote:
> > > Since commit 1a136ca2e089 ("net: mdio: scan bus based on bus
> > > capabilities for C22 and C45") our AT91SAM9G25-based GARDENA smart
> > > Gateway will no longer boot.
> > > 
> > > Prior to the mentioned change, probe_capabilities would be set to
> > > MDIOBUS_NO_CAP (0) and therefore, no Clause 45 scan was performed.
> > > Running a Clause 45 scan on an SMSC/Microchip LAN8720A PHY will (at
> > > least with our setup) considerably slow down kernel startup and
> > > ultimately result in a board reset.
> > > 
> > > AFAICT all SMSC/Microchip PHYs are Clause 22 devices. Some have a
> > > "Clause 45 protection" feature (e.g. LAN8830) and others like the
> > > LAN8804 will explicitly state the following in the datasheet:
> > > 
> > >     This device may respond to Clause 45 accesses and so must not be
> > >     mixed with Clause 45 devices on the same MDIO bus.
> > > 
> > 
> > I'm not convinced that some heuristic based on vendors is a
> > sustainable approach. Also I'd like to avoid (as far as possible)
> > that core code includes vendor driver headers. Maybe we could use
> > a new PHY driver flag. Approaches I could think of:
> 
> We already have a core hack for these broken PHYs:

Yes, and it is this very function that the patch at the start of this
thread is changing!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

