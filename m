Return-Path: <netdev+bounces-184676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B808A96D66
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B173BE26B
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 13:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCD128134E;
	Tue, 22 Apr 2025 13:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EKqsglQO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA37B1DF984
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745329754; cv=none; b=J2UUhJWKQiOjbUBDJ4argUIHE56oYztEkJKsrSanmCdQCREb9twU2+udLy7c2xSaOqrMB1eH/n9hfq7Run1BeP/w/aCybcjcFrYGuWKkqDafyAPovCjhytb8/BmAQ77pdVrEN9XvmvLKjn4oO4jNF13HJPjdz1eXf1fgv7njMJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745329754; c=relaxed/simple;
	bh=y9J3K4N516lEL1EVy4HxLCy7pwsRdj0c3Xdq9uWUNRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0CzolAodTfUAO4ZOL2o3qsaQD24+smkE6dIdmqDEwEhKQZoE92Av7yAKvP4mVXtu/pIF0Q+1Xx4CrPuGvDYPJYr3Rk6Mg8PaQO4A9OWHdtMufQ0rz8SZL7C2TJWElj2YLXHUWzsBaIJq3VBNTkwY2Ol+fivEnhwKlu0biC3MNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EKqsglQO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=tCSCFhx3YiffOVSFNi045P/Ib5QYowrwCZasa44zxKs=; b=EK
	qsglQONC+Wo0Uq6JBjRnwu2/wHVpn38i4QQc4SWbR53WSqb3iszlMqNeomfy4OfB387zhSxy4e5hU
	bwZkqRSv0Ig2M1xpHEKEk7GY4FMl8jch9wxAu1ZUXwDPVoH1j0vstNh8K6ndgeqojrqDxXKH71TBs
	JT1ErqE3xBF1pe8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u7Dzi-00ACo0-5G; Tue, 22 Apr 2025 15:49:02 +0200
Date: Tue, 22 Apr 2025 15:49:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
	linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	pabeni@redhat.com
Subject: Re: [net-next PATCH 0/2] net: phylink: Fix issue w/ BMC link flap
Message-ID: <e3305a73-6a18-409b-a782-a89702e43a80@lunn.ch>
References: <174481691693.986682.7535952762130777433.stgit@ahduyck-xeon-server.home.arpa>
 <de130c97-c344-42ee-b3bc-0ca5f9dc36df@lunn.ch>
 <CAKgT0UcXY3y3=0AnbbbRH75gh2ciBKhQj2tzQAbcHW_acKeoQw@mail.gmail.com>
 <06490a1a-427c-4e35-b9c3-154a0c88ed60@lunn.ch>
 <CAKgT0UfeH4orZq5AnHvgeTL3i05fPu-GNmBwTnnrGFWOdU+6Cg@mail.gmail.com>
 <CAKgT0Udw-XQmRan1qBaBEkCOqNd2FRNgPd8E8Au+Wmih7QVsWA@mail.gmail.com>
 <20250421182143.56509949@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250421182143.56509949@kernel.org>

On Mon, Apr 21, 2025 at 06:21:43PM -0700, Jakub Kicinski wrote:
> On Mon, 21 Apr 2025 09:50:25 -0700 Alexander Duyck wrote:
> > On Mon, Apr 21, 2025 at 8:51 AM Alexander Duyck wrote:
> > > On Sun, Apr 20, 2025 at 2:58 PM Andrew Lunn <andrew@lunn.ch> wrote:  
> > > > > 2. Expectations for our 25G+ interfaces to behave like multi-host NICs
> > > > > that are sharing a link via firmware. Specifically that
> > > > > loading/unloading the driver or ifconfig up/down on the host interface
> > > > > should not cause the link to bounce and/or drop packets for any other
> > > > > connections, which in this case includes the BMC.  
> > > >
> > > > For this, it would be nice to point to some standard which describes
> > > > this, so we have a generic, vendor agnostic, description of how this
> > > > is supposed to work.
> > >
> > > The problem here is this is more-or-less a bit of a "wild west" in
> > > terms of the spec setup. From what I can tell OCP 3.0 defines how to
> > > set up the PCIe bifurcation but doesn't explain what the expected
> > > behavior is for the shared ports. One thing we might look into would
> > > be the handling for VEPA(Virtual Ethernet Port Aggregator) or VEB
> > > (Virtual Ethernet Bridging) as that wouldn't be too far off from what
> > > inspired most of the logic in the hardware. Essentially the only
> > > difference is that instead of supporting VFs most of these NICs are
> > > supporting multiple PFs.  
> > 
> > So looking at 802.1Q-2022 section 40 I wonder if we don't need to
> > essentially define ourselves as an edge relay as our setup is pretty
> > close to what is depicted in figure 40-1. In our case an S-channel
> > essentially represents 2 SerDes lanes on an QSFP cable, with the
> > switch playing the role of the EVB bridge.
> > 
> > Anyway I think that is probably the spec we need to dig into if we are
> > looking for how the link is being shared and such. I'll try to do some
> > more reading myself to get caught up on all this as the last time I
> > had been reading through this it was called VEB instead of EVB.. :-/
> 
> Interesting. My gut feeling is that even if we make Linux and the NIC
> behave nicely according to 802.1Q, we'll also need to make some changes
> on the BMC side. And there we may encounter pushback as the status quo
> works quite trivially for devices with PHY control in FW.

As i see it, we have two things stacked on top of each other. We have
what is standardised for NC-SI, DSP0222. That gives a basis, and then
there is vendor stuff on top for multi-host, which is more strict.

Linux should have generic support for DSP0222. I've seen vendors hack
around with WoL to make it work. It would be nice to replace that hack
with a method to tell phylink to enable support for DSP0222. A
standardised method, since as additional ops, or a flag. phylink can
then separate admin down from carrier down when needed.

Then we have vendor stuff on top. 

> BTW Saeed posted a devlink param to "keep link up" recently:
> https://lore.kernel.org/all/20250414195959.1375031-11-saeed@kernel.org/
> Intel has ethtool priv flags to the same effect, in their 40G and 100G
> drivers, but with reverse polarity:
> https://docs.kernel.org/networking/device_drivers/ethernet/intel/i40e.html#setting-the-link-down-on-close-private-flag
> These are all for this exact use case. In the past Ido added module
> power policy, which is the only truly generic configurable, and one we
> should probably build upon:
> https://docs.kernel.org/networking/ethtool-netlink.html#c.ethtool_module_power_mode_policy
> I'm not sure if this is expected to include PCS or it's just telling
> the module to keep the laser on..

Ideally, we want to define something vendor agnostic. And i would
prefer we talk about the high level concept, sharing the NIC with a
BMC and multiple hosts, rather than the low level, keep link up.

The whole concept of a multi-host NIC is new to me. So i at least need
to get up to speed with it. I've no idea if Russell has come across it
before, since it is not a SoC concept.

I don't really want to agree to anything until i do have that concept
understood. That is part of why i asked about a standard. It is a
dense document answering a lot of questions. Without a standard, i
need to ask a lot of questions.

I also think there is a lot more to it than just keeping the laser
on. For NC-SI, DSP0222 that probably does cover a big chunk of the
problem, but for multi-host, my gut is telling me there is more to it.

Let me do some research and thinking about multi-host.

	Andrew

