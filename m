Return-Path: <netdev+bounces-183477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4456A90CBB
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D4A87AAE6F
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 20:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE9522655E;
	Wed, 16 Apr 2025 20:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="juAXe9Pd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C90189915
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 20:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744833924; cv=none; b=FIAnVgayucfUgVTE0j+2o9heSYBJ4YXrDtPHjueA2K0cf71oKSWNNAO8IFzYE5iOs0tZhsXcXJQzmqaFeF+0Z7zDOSbnHqVEqyiY5ndd1q2rH+t/Aw0aIKMKwRBJ65ZCje1onLxJe5D0tPLr/t+UAwDx93SK7ExXAnLdO8c+fOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744833924; c=relaxed/simple;
	bh=DesI0ZdCoUDCynYy9G0+AI7PwSwmjPpqYhtRuEo8BNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1Y1MAYwcR5+VoHzpKOKm/+vNxopcX6KjYs+1xTxvvn91r3bSY0jWdx2MEftUa7mTitO3K4ebElbqSFgERWm7Saq4T2CeDjusm5b9GuQqOvChwaQshqadhtixZT5OENy4G7Qpjzno6lTPI8JNyTqZN3jtJjGoZ+IsjqbuhCZm7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=juAXe9Pd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rpdoC1q/CcJTaZYytbzGXhIOK+sgf3JysdRuJ15cWNE=; b=juAXe9PdIVTOrcWboJQBKPffGP
	O+MFDi28/mYwLa8UN1MK0Tomoz8MQe5uQ1sAeC1AaHMqTOSFvcMXTrFF2JWlwOrNLf0PkAXmOinQy
	SlsVgZCrSrxhSg/dI4Efcq3wIvmdo0+LK13kRpUNmzYK5HA5PHvDwpuWpK+xcoAh/K+URsdZI3EXJ
	TRxxek9Xpkv6eRJFVCiEdgNXGiU/Rk5lArJkKuflcT3MymMGj2q6ZQ1P5D7XXJ9VLqTZVxzyUH397
	Z94c6J8yFMrRr9VqThnTgSSD5O4kZOSoxqPkpiWB18o+EyTg6z1HyntYZsL5wUBe7rnhm3wCuiJTq
	ETpyX/Xg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55258)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u590Y-0001t2-0b;
	Wed, 16 Apr 2025 21:05:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u590V-0001hX-2u;
	Wed, 16 Apr 2025 21:05:15 +0100
Date: Wed, 16 Apr 2025 21:05:15 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [net-next PATCH 2/2] net: phylink: Fix issues with link
 balancing w/ BMC present
Message-ID: <aAANe/qMWIRY2K5l@shell.armlinux.org.uk>
References: <174481691693.986682.7535952762130777433.stgit@ahduyck-xeon-server.home.arpa>
 <174481734008.986682.1350602067856870465.stgit@ahduyck-xeon-server.home.arpa>
 <Z__URcfITnra19xy@shell.armlinux.org.uk>
 <CAKgT0UcgZpE4CMDmnR2V2GTz3tyd+atU-mgMqiHesZVXN8F_+g@mail.gmail.com>
 <aAACyQ494eO4LFQD@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAACyQ494eO4LFQD@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Apr 16, 2025 at 08:19:38PM +0100, Russell King (Oracle) wrote:
> So, when a Linux network driver probes, it starts out in administrative
> state *DOWN*. When the administrator configures the network driver,
> .ndo_open is called, which is expected to configure the network adapter.
> 
> Part of that process is to call phylink_start() as one of the last
> steps, which detects whether the link is up or not. If the link is up,
> then phylink will call netif_carrier_on() and .mac_link_up(). This
> tells the core networking layers that the network interface is now
> ready to start sending packets, and it will begin queueing packets for
> the network driver to process - not before.
> 
> Prior to .ndo_open being called, the networking layers do not expect
> traffic from the network device no matter what physical state the
> media link is in. If .ndo_open fails, the same applies - no traffic is
> expected to be passed to the core network layers from the network
> layers because as far as the network stack is concerned, the interface
> is still administratively down.
> 
> Thus, the fact that your BMC thinks that the link is up is irrelevant.
> 
> So, start off in a state that packet activity is suspended even if the
> link is up at probe time. Only start packet activity (reception and
> transmission) once .mac_link_up() has been called. Stop that activity
> when .mac_link_down() is subsequently called.
> 
> There have been lots of NICs out there where the physical link doesn't
> follow the adminstrative state of the network interface. This is not a
> problem. It may be desirable that it does, but a desire is not the same
> as "it must".

Let me be crystal clear on this.

Phylink has a contract with all existing users. That contract is:

Initial state: link down.

Driver calls phylink_start() in its .ndo_open method.

Phylink does configuration of the PHY and link according to the
chosen link parameters by calling into the MAC, PCS, and phylib as
appropriate.

If the link is then discovered to be up (it might have been already
up before phylink_start() was called), phylink will call the various
components such as PCS and MAC to inform them that the link is now up.
This will mean calling the .mac_link_up() method. Otherwise (if the
link is discovered to be down when the interface is brought up) no
call to either .mac_link_up() nor .mac_link_down() will be made.

If the link _subsequently_ goes down, then phylink deals with that
and calls .mac_link_down() - only if .mac_link_up() was previously
called (that's one of the bugs you discovered, that on resume it
gets called anyway. I've submitted a fix for that contract breach,
which only affects a very small number of drivers - stmmac, ucc_geth
and your fbnic out of 22 total ethernet users plus however many DSA
users we have.)

Only if .mac_link_down() has been called, if the link subsequently
comes back up, then the same process happens as before resulting in
.mac_link_up() being called.

If the interface is taken down, then .mac_link_down() will be called
if and only if .mac_link_up() had been called.

The ordering of .mac_link_up() / .mac_link_down() is a strict
contract term with phylink users.

The reason for this contract: phylink users may have ordering
requirements.

For example, on mac_link_down(), they may wait for packet activity to
stop, and then place the MAC in reset. If called without a previous
.mac_link_up call, the wait stage may time out due to the MAC being
in reset. (Ocelot may suffer with this.)

Another example is fs_enet which also relies on this strict ordering
as described above.

There could be others - there are some that call into firmware on
calls to .mac_link_up() / .mac_link_down() and misordering those
depends on what the firmware is doing, which we have no visibility
of.

As I stated, this is the contract that phylink gave to users, and
the contract still stands, and can't be broken to behave differently
(e.g. calling .mac_link_down() after phylink_start() without an
intervening call to .mac_link_up()) otherwise existing users will
break. Bugs that go against that contract will be fixed, but the
contract will not be intentionally broken.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

