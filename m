Return-Path: <netdev+bounces-46056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC917E105E
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 17:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9757E281799
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 16:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D923C1A5A1;
	Sat,  4 Nov 2023 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nSZ8eQsl"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248EA3C34
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 16:42:02 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C408E0
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 09:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wvYckrz1hj8zuphQTnd4lFXjP6gT/hB2v0eu5Pe45oQ=; b=nSZ8eQsl6NxA2kXOR4211HMdLB
	geJr2Eb2sysquvOCvVcGIQOlDGFCoAXcQbtyxTykTrqpQ15cExzWdPYf22DkEB4tgerhNs59Xb4yR
	GvyIe1fwmEG2x0AEi+AbnrjVKCg1yigqa+BylQuzIIuT9lcA+EX89HgbY32944nxVKog=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qzJic-000syE-50; Sat, 04 Nov 2023 17:41:54 +0100
Date: Sat, 4 Nov 2023 17:41:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Klaus Kudielka <klaus.kudielka@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev <netdev@vger.kernel.org>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH] leds: triggers: netdev: add a check, whether device is up
Message-ID: <196db01b-40ff-44ed-8e45-1b855940417f@lunn.ch>
References: <20231104125840.27914-1-klaus.kudielka@gmail.com>
 <0e3fb790-74f2-4bb3-b41e-65baa3b00093@lunn.ch>
 <95ff53a1d1b9102c81a05076f40d47242579fc37.camel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95ff53a1d1b9102c81a05076f40d47242579fc37.camel@gmail.com>

[Changes the Cc: list. Dropping LED people, adding a few netdev
people]

On Sat, Nov 04, 2023 at 04:27:45PM +0100, Klaus Kudielka wrote:
> On Sat, 2023-11-04 at 15:29 +0100, Andrew Lunn wrote:
> > On Sat, Nov 04, 2023 at 01:58:40PM +0100, Klaus Kudielka wrote:
> > > Some net devices do not report NO-CARRIER, if they haven't been brought
> > > up.
> > 
> > Hi Klaus
> > 
> > We should probably fix the driver. What device is it?
> > 
> > > In that case, the netdev trigger results in a wrong link state being
> > > displayed. Fix this, by adding a check, whether the device is up.
> > 
> > Is it wrong? Maybe the carrier really is up, even if the interface is
> > admin down. Broadcast packets are being received by the
> > hardware. Maybe there is a BMC sharing the link and it is active?
> 
> My particular example is Turris Omnia, eth2 (WAN), connected to SFP.
> SFP module is inserted, but no fiber connected, so definitely no carrier. 
> 
> *Without* the patch:
> 
> After booting, the device is down, but netdev trigger reports "link" active.
> This looks wrong to me.
> 
> I can then "ip link set eth2 up", and the "link" goes away - as I
> would have expected it to be from the beginning.

Thanks for the details.

A brain dump...

You do see a lot of MAC drivers doing a netif_carrier_off() in there
probe function. That suggests the carrier is on by default. I doubt we
can change that, we would break all the drivers which assume the
carrier is on by default, probably virtual devices and some real
devices.

Often the MAC and PHY are connected in the open() callback, when using
phylib. So that is too late.  phylink_create() is however mostly used
in the probe function. So it could set the carrier to off by default.
Russell, what do you think?

Turris Omnia uses mvneta. That does not turn the carrier off in its
probe function. So a quick fix would be to add it. However, that then
becomes pointless if we make phylink_create() disable the carrier.

	Andrew

