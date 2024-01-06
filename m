Return-Path: <netdev+bounces-62167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FE4826014
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 16:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1FB1F22C14
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 15:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E2679E2;
	Sat,  6 Jan 2024 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bpGqXV5D"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E2479F5
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=O4Bp0dH9mNdHjvVwzFyt+ii47ST6ea16hbZN6epGVjs=; b=bp
	GqXV5DaEuySFB9Avz3UHEawW5WHAhiF7J78VK0XHqV9yyJhOr5FHY7Rb3L7IqBa37rTNJwEXx8XSf
	7isbP2ymeJe5sINYsb4GLODbjUceaaMtIUyRUFGnEPVZ1KJmQnpAOy+PS2fd8SrZGSDxs/jcpqaOB
	G0GPNlgQqehHeeg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rM8TO-004Wlq-9u; Sat, 06 Jan 2024 16:20:30 +0100
Date: Sat, 6 Jan 2024 16:20:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ezra Buehler <ezra@easyb.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Tristram Ha <Tristram.Ha@microchip.com>,
	Michael Walle <michael@walle.cc>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: mdio: Prevent Clause 45 scan on SMSC PHYs
Message-ID: <d6deee54-e5c3-4bdd-8a87-f1afeada8d9b@lunn.ch>
References: <20240101213113.626670-1-ezra.buehler@husqvarnagroup.com>
 <77fa1435-58e3-4fe1-b860-288ed143e7bc@gmail.com>
 <1297166c-38c1-4041-8a7f-403477b871cf@lunn.ch>
 <8eb06ee9-d02d-4113-ba1e-e8ee99acc2fd@gmail.com>
 <2013fa64-06a1-4b61-90dc-c5bd68d8efed@lunn.ch>
 <CAM1KZSn0+k4YKc2qy6DEafkL840ybjaun7FbD4OFwOwNZw_LEg@mail.gmail.com>
 <ZZRct1o21NIKbYX1@shell.armlinux.org.uk>
 <CAM1KZS=2Drnhx8SKcAbRniGhvy0d85FfKHOgK7MZxNWM7EAEmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM1KZS=2Drnhx8SKcAbRniGhvy0d85FfKHOgK7MZxNWM7EAEmQ@mail.gmail.com>

On Sat, Jan 06, 2024 at 01:41:01PM +0100, Ezra Buehler wrote:
> On Tue, Jan 2, 2024 at 7:58 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > Any ideas why the scan is taking so long?
> >
> > For each PHY address (of which there are 32) we scan each MMD between
> > 1 and 31 inclusive. We attempt to read the devices-in-package
> > registers. That means 32 * 32 * 2 calls to the mdiobus_c45_read(),
> > which is 2048 calls. Each is two MDIO transactions on the bus, so
> > that's 4096. Each is 64 bits long including preamble, and at 2.5MHz
> > (the "old" maximum) it should take about 100ms to scan the each
> > MMD on each PHY address to determine whether a device is present.
> >
> > I'm guessing the MDIO driver you are using is probably using a software
> > timeout which is extending the latency of each bus frame considerably.
> > Maybe that is where one should be looking if the timing is not
> > acceptable?
> 
> When profiling with ftrace, I see that executing macb_mdio_read_c45()
> takes about 20ms. The function calls  macb_mdio_wait_for_idle() 3 times,
> where the latter 2 invocations take about 10ms each. The
> macb_mdio_wait_for_idle() function invokes the read_poll_timeout() macro
> with a timeout of 1 second, which we obviously do not hit.
> 
> To me it looks like we are simply waiting for the hardware to perform
> the transaction, i.e. write out the address and read the register (which
> is read as 0xFFFF).
> 
> I've checked the MDIO clock, it is at 2MHz.
> 
> So, any suggestions for what to look into next?

Does a C22 read/write call to macb_mdio_wait_for_idle() take as long?

Could you hack a copy of readx_poll_timeout() and real_poll_timeout()
into the driver, and extend it to count how many times it goes around
the loop. Is the usleep_range() actually sleeping for 10ms because you
don't have any high resolution clocks, and a 100Hz tick? If so, you
might want to swap to 1000Hz tick, or NO_HZ, or enable a high
resolution clock, so that usleep_range() can actually sleep for short
times.

	   Andrew

