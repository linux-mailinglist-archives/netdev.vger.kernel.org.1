Return-Path: <netdev+bounces-46058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2326B7E1074
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 18:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507061C208DA
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 17:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50DF210E2;
	Sat,  4 Nov 2023 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OR3iL8VG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A946A1863B
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 17:12:41 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9331BC
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 10:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=snGL9m8ofUqMKBNo/2+hpDfEVV0/gEsy0KmiSB+2FPI=; b=OR3iL8VGPRAzNG6RciU+n3eCpW
	7gdBcXHTmjEqviMV7nLhLp+LUMpp1nD14xv6gk8fC+m6ppHJrXGQ6NjkIwuOvUFJtl2gOv7bOtkkz
	qYlDloLfM46amAGTZqTgqM1kDhQsIBYHVhnDEDavArOvJ8f3TwHKNIah0xL4IuwKtrgkP25Pt+F4G
	WupIUo0K6MV5CZPmUibLTYlFpu9GiNltAdu0J+LEuhBnPIdy1qYwT/AoaRm4r6F36p8SW7WREYX7R
	J20a5JW0iKs7EgpmLDrCwZmZF7AcIH1/w7U0M7xGzVdJ4MSkgiShDVgfunoEqI7LTbT48XfybW6EP
	RnlzRHxw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49408)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qzKCF-0006Vs-2R;
	Sat, 04 Nov 2023 17:12:31 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qzKCG-00043g-K6; Sat, 04 Nov 2023 17:12:32 +0000
Date: Sat, 4 Nov 2023 17:12:32 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Klaus Kudielka <klaus.kudielka@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH] leds: triggers: netdev: add a check, whether device is up
Message-ID: <ZUZ7gAXs0/gDRbIc@shell.armlinux.org.uk>
References: <20231104125840.27914-1-klaus.kudielka@gmail.com>
 <0e3fb790-74f2-4bb3-b41e-65baa3b00093@lunn.ch>
 <95ff53a1d1b9102c81a05076f40d47242579fc37.camel@gmail.com>
 <196db01b-40ff-44ed-8e45-1b855940417f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <196db01b-40ff-44ed-8e45-1b855940417f@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Nov 04, 2023 at 05:41:54PM +0100, Andrew Lunn wrote:
> [Changes the Cc: list. Dropping LED people, adding a few netdev
> people]
> 
> On Sat, Nov 04, 2023 at 04:27:45PM +0100, Klaus Kudielka wrote:
> > After booting, the device is down, but netdev trigger reports "link" active.
> > This looks wrong to me.
> > 
> > I can then "ip link set eth2 up", and the "link" goes away - as I
> > would have expected it to be from the beginning.
> 
> Thanks for the details.
> 
> A brain dump...
> 
> You do see a lot of MAC drivers doing a netif_carrier_off() in there
> probe function. That suggests the carrier is on by default. I doubt we
> can change that, we would break all the drivers which assume the
> carrier is on by default, probably virtual devices and some real
> devices.

Note that one of the things that phylink will do is call
netif_carrier_off() when phylink_start() is called to ensure that the
netdev state matches its internal state.

> Often the MAC and PHY are connected in the open() callback, when using
> phylib. So that is too late.  phylink_create() is however mostly used
> in the probe function. So it could set the carrier to off by default.
> Russell, what do you think?

I was going to ask whether that would be a good idea - since it means
that the carrier is in the right state at probe time as well as after
phylink_start() has been called.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

