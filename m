Return-Path: <netdev+bounces-97549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD558CC157
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 14:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E5F1F236D4
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 12:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E3B13D607;
	Wed, 22 May 2024 12:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pXoVaK1o"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196BE13D604;
	Wed, 22 May 2024 12:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716381482; cv=none; b=f0lIHW79CkEzzUzUH4r8gN1INVMgImmWJksBZRmPzXymqdxyEjk+aKaY4Iz0wurlSdhX+sA8IAG3mZCVAzijq66tj/egytlgam/xa4uJUVZndQh2uBVkqT9l5vc9qDzx7p/uXPUnW6dcHKTbRjhzwtMQZOUpTI/bYb7Cj596+Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716381482; c=relaxed/simple;
	bh=uR+0GaiOK4i57o+GVRmrTDVdSaQ4AgJhLI6wd822j+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7/U5p7qVfUtGU3Q1QQoq59mc0y0krrHInvkBH1P+GrRotUAB/7qj4CI+iCoqz9SjTjSughMpXEm+gLuM1Xsyug2nrBc0PvpJPTTahwSk+bUjDJvEYM7WZdc3ZCF7fLccedBZODNt35N/uJAmi4t+eY6zpnfilScX/T6uo9uaLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pXoVaK1o; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AHlzVsmTWLPaYW8yXMskOSpDpuqcxd7LLht6Va77Reo=; b=pXoVaK1o7949NTgXfzSplILPFz
	TwtBZUJ36PoLt6gqL9sbnhR3aGHZzWfLQETUErxCWW68lTqlSJgAoKkmNPTldHoaSAPUCmvsV0YmZ
	Hleu4zCDPaF3l/4SnTW5XLPipv18Fp3YJ0Ghj8WH7qg2CQ7bRoeLqvH4C9iybmRo0+Lw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s9lE6-00Foyi-5u; Wed, 22 May 2024 14:37:50 +0200
Date: Wed, 22 May 2024 14:37:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Larry Chiu <larry.chiu@realtek.com>
Cc: Justin Lai <justinlai0215@realtek.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"horms@kernel.org" <horms@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH net-next v19 01/13] rtase: Add pci table supported in
 this module
Message-ID: <7aab03ba-d8ed-4c9c-8bfd-b2bbed0a922d@lunn.ch>
References: <20240517075302.7653-1-justinlai0215@realtek.com>
 <20240517075302.7653-2-justinlai0215@realtek.com>
 <d840e007-c819-42df-bc71-536328d4f5d7@lunn.ch>
 <e5d7a77511f746bdb0b38b6174ef5de4@realtek.com>
 <97e30c5f-1656-46d0-b06c-3607a90ec96f@lunn.ch>
 <f9133a36bbae41138c3080f8f6282bfd@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9133a36bbae41138c3080f8f6282bfd@realtek.com>

On Wed, May 22, 2024 at 04:43:11AM +0000, Larry Chiu wrote:
> 
> > On Tue, May 21, 2024 at 06:20:04AM +0000, Larry Chiu wrote:
> > >
> > > >> + *  Below is a simplified block diagram of the chip and its relevant
> > interfaces.
> > > >> + *
> > > >> + *               *************************
> > > >> + *               *                       *
> > > >> + *               *  CPU network device   *
> > > >> + *               *                       *
> > > >> + *               *   +-------------+     *
> > > >> + *               *   |  PCIE Host  |     *
> > > >> + *               ***********++************
> > > >> + *                          ||
> > > >> + *                         PCIE
> > > >> + *                          ||
> > > >> + *      ********************++**********************
> > > >> + *      *            | PCIE Endpoint |             *
> > > >> + *      *            +---------------+             *
> > > >> + *      *                | GMAC |                  *
> > > >> + *      *                +--++--+  Realtek         *
> > > >> + *      *                   ||     RTL90xx Series  *
> > > >> + *      *                   ||                     *
> > > >> + *      *     +-------------++----------------+    *
> > > >> + *      *     |           | MAC |             |    *
> > > >> + *      *     |           +-----+             |    *
> > > >> + *      *     |                               |    *
> > > >> + *      *     |     Ethernet Switch Core      |    *
> > > >> + *      *     |                               |    *
> > > >> + *      *     |   +-----+           +-----+   |    *
> > > >> + *      *     |   | MAC |...........| MAC |   |    *
> > > >> + *      *     +---+-----+-----------+-----+---+    *
> > > >> + *      *         | PHY |...........| PHY |        *
> > > >> + *      *         +--++-+           +--++-+        *
> > > >> + *      *************||****************||***********
> > > >> + *
> > > >> + *  The block of the Realtek RTL90xx series is our entire chip
> > > >> + architecture,
> > > >> + *  the GMAC is connected to the switch core, and there is no PHY in
> > between.
> > > >
> > > >Given this architecture, this driver cannot be used unless there is a switch
> > > >driver as well. This driver is nearly ready to be merged. So what are your
> > > >plans for the switch driver? Do you have a first version you can post? That
> > > >will reassure us you do plan to release a switch driver, and not use a SDK in
> > > >userspace.
> > > >
> > > >        Andrew
> > >
> > > Hi Andrew,
> > > This GMAC is configured after the switch is boot-up and does not require a
> > > switch driver to work.
> > 
> > But if you cannot configure the switch, it is pointless passing the switch
> > packets. The Linux architecture is that Linux needs to be able to control the
> > switch somehow. There needs to be a driver with the switchdev API on its
> > upper side which connects it to the Linux network stack. Ideally the lower
> > side of this driver can directly write switch registers. Alternatively it can make
> > some sort of RPC to firmware which configures the switch.
> > 
> > Before committing this MAC driver, we will want to be convinced there is a
> > switchdev driver for the switch.
> > 
> >         Andrew
> 
> 
> I know what you mean.
> But actually this GMAC works like a NIC connected to an Ethernet Switch not a 
> management port, its packets communicating with other ports.

Linux has two different models for switches.

The first is switchdev. Linux has a netdev per port of the switch, and
use you those netdev's to manage the switch, just as if they are
individual NICs.

The second is very, very old, since the beginning of Ethernet
switches. The cable comes out of the machine and plugs into the
switch. Linux has no idea there is a switch there, the switch is just
part of the magic if networking. This also means Linux cannot manage
the switch, it is a different box, a different administration domain.

The second model does not really work here. The switch is not in
another box at the end of a cable. It is integrated into the SoC!
 
> The PCIe Endpoint is a multi-function device, the other function is used to 
> control the switch register, we are still working on where to put this driver in 
> Linux. We thought it should be separated into different device drivers, or you 
> think we should register two pcie functions in this driver.

Look at the architecture of other switch drivers. There are two broad
categories.

1) Pure switchdev drivers, e.g. mellanox, sparx5, prestera. There is
one driver which provides both the netdev interfaces per port, and
implements the switchdev API for managing the switch.

2) DSA + switchdev, e.g. mv88e6xxx, rtl8365, starfigher2, etc. These
use a conventional NIC to provide the conduit to pass packets to the
switch. These packets have additional headers, added by a tag driver,
indicating which port a packet should go out. And there is a switch
driver, which makes use of the DSA framework to manage the switch. DSA
provides the netdev per port.

This is actually something i ask you about with version 1 of the
patches. I've forget what your answer was, and we concentrated on
getting your code up to mainline quality. Now it is time to go back to
that question.

How do you control where a packet passed over this GMAC NIC goes
within the switch? Is there an additional header? Are their fields in
the DMA descriptor?

If your hardware is DSA like, you can write another driver which binds
to a different PCI function. If however you use DMA descriptors, you
need a pure switchdev driver, one driver which binds to multiple PCI
functions.

	Andrew

