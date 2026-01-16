Return-Path: <netdev+bounces-250530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B27D2D31C82
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 14:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BEB93057091
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 13:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D8A25783A;
	Fri, 16 Jan 2026 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMil1hEw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C8023C512;
	Fri, 16 Jan 2026 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569830; cv=none; b=VvVeVhHLa4WnZ67qqbNDrfz7XNje4xdYDki5MFVyyuX2QeiO+5cPLpOCn/icRto8GkjeBZGOv+5P2dlyYL9elzm54NP3EW2kiW0G89eF4/oe/IIV2x5TcaGzA0JbX/AAZ5qr94Yh9PVgfTM8OKzpGM/tFwtNs6WT8wMItf2DXLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569830; c=relaxed/simple;
	bh=bVZV9rakU5u7YpgV0wxK4Al6zuACql0Jrr7GgqferEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIfPyfLlHo5fbBcBXew+R1HP4LI/pj+5jZQ0625IFhswUykHSnV02nOc/MjZAbr2QGltyROrpq/wqmPDQpeejngH6XM6rC6tNyDCN1ZSRVDk0JQUmLHQEmsrkeEXwekqKqTUF8MwZj2WRwapbj8Rn0WHhyzoIoAPKJFQwseFKE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMil1hEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41213C116C6;
	Fri, 16 Jan 2026 13:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768569830;
	bh=bVZV9rakU5u7YpgV0wxK4Al6zuACql0Jrr7GgqferEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OMil1hEw/4kEiWf86hJMe21WY3k20MG9dE0DzBXfQ8s6zkDe8SJ/Dz8xR38a1EORG
	 p4433uh9RFXf/EFYhaATTTwEd71x5qsXmFj3eAEBKtk+39a0dmSv9SiycTE6AQTZ6a
	 XDOVZV5uDkkscqYWOmCwEnWwJiHAkN2enfUb6q9L+oy5ji/SnCTnBZ1PUUrSlql5o6
	 HGCFvkHVa/K+lv/8Gq8M55yFwGqB4GHkgHpTsfSw768b28Dfr1QQvbSJVqdTkLe2ce
	 OzH5NsZbDwW3CLBL7RPhTLp5hTRSWoZ9tfABy6CitzSi46Xgrq4X2OgUA1klLdEKiG
	 BG0KBNsqiR/Tg==
Date: Fri, 16 Jan 2026 13:23:45 +0000
From: Lee Jones <lee@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 07/15] mfd: core: add ability for cells to probe
 on a custom parent OF node
Message-ID: <20260116132345.GA882947@google.com>
References: <20251216002955.bgjy52s4stn2eo4r@skbuf>
 <20251216091831.GG9275@google.com>
 <20251216162447.erl5cuxlj7yd3ktv@skbuf>
 <20260109103105.GE1118061@google.com>
 <20260109121432.lu2o22iijd4i57qq@skbuf>
 <20260115161407.GI2842980@google.com>
 <20260115161407.GI2842980@google.com>
 <20260115185759.femufww2b6ar27lz@skbuf>
 <20260116084021.GA374466@google.com>
 <20260116113847.wsxdmunt3dovb7k6@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260116113847.wsxdmunt3dovb7k6@skbuf>

On Fri, 16 Jan 2026, Vladimir Oltean wrote:

> On Fri, Jan 16, 2026 at 08:40:21AM +0000, Lee Jones wrote:
> > On Thu, 15 Jan 2026, Vladimir Oltean wrote:
> > 
> > > On Thu, Jan 15, 2026 at 04:14:07PM +0000, Lee Jones wrote:
> > > > > > My plan, when and if I manage to find a few spare cycles, is to remove
> > > > > > MFD use from outside drivers/mfd.  That's been my rule since forever.
> > > > > > Having this in place ensures that the other rules are kept and (mild)
> > > > > > chaos doesn't ensue.  The MFD API is trivial to abuse.  You wouldn't
> > > > > > believe some of things I've seen over the years.  Each value I have is
> > > > > > there for a historical reason.
> > > > > 
> > > > > If you're also of the opinion that MFD is a Linux-specific
> > > > > implementation detail and a figment of our imagination as developers,
> > > > > then I certainly don't understand why Documentation/devicetree/bindings/mfd/
> > > > > exists for this separate device class that is MFD, and why you don't
> > > > > liberalize access to mfd_add_devices() instead.
> > > > 
> > > > The first point is a good one.  It mostly exists for historical
> > > > reasons and for want of a better place to locate the documentation.
> > > > 
> > > > I've explained why liberalising the mfd_*() API is a bad idea.  "Clever"
> > > > developers like to do some pretty crazy stuff involving the use of
> > > > multiple device registration APIs simultaneously.  I've also seen some
> > > > bonkers methods of dynamically populating MFD cells [*ahem* Patch 8
> > > > =;-)] and various other things.  Keeping the API in-house allows me to
> > > > keep things simple, easily readable and maintainable.
> > > 
> > > The only thing that's crazy to me is how the MFD documentation (+ my
> > > intuition as engineer to fill in the gaps where the documentation was
> > > lacking, aka in a lot of places) could be so far off from what you lay
> > > out as your maintainer expectations here.
> > 
> > MFD has documentation?  =;-)
> > 
> > /me `find . | grep -i mfd`s
> > 
> > Okay, the only "MFD documentation" I can find is:
> > 
> >   Documentation/devicetree/bindings/mfd/mfd.txt
> 
> Exactly my point!
> 
> > The first paragraph reflects the point I've been trying to make:
> > 
> >  "These devices comprise a nexus for HETEROGENEOUS hardware blocks
> >   containing more than one non-unique yet VARYING HARDWARE FUNCTIONALITY.
> > 
> > 2 MDIO controllers are homogeneous to each other and are not varying.
> 
> I get the impression you didn't look at patch 14, where I also added the
> ethernet-pcs blocks to MFD children.

That could well be one of the issues.

Please send me the full and finalised DTS hunk.

> > How is the documentation and what I say "so far off"?
> 
> Well, it's far off because I got the genuine impression that I'm making
> legitimate use of the MFD API.

That doesn't sound like a lack of parity between the docs and my views,
as previously suggested.  The cited doc appears to be in precise
alignment with respect to the points I've been trying to communicate
with you.

> > Okay, so these are the MDIO bus controllers - that's clear now, thank you.
> > 
> > I was confused by the t1 and tx parts.  Are these different types of
> > MDIO controllers or are they the same, but vary only in support / role?
> > 
> > But again, if these are "both MDIO controllers", then they are _same_.
> 
> Their register map (i.e. way of accessing the underlying MDIO devices,
> aka internal PHYs) is different. They have different drivers, one is
> added by patch 3 and the other by patch 4.
> Here is the link to the entire set:
> https://lore.kernel.org/netdev/20251118190530.580267-1-vladimir.oltean@nxp.com/

Okay, so if we can say that the MDIO devices are different enough,
despite the nomenclature and that there are additional devices
(Ethernet), then one of the contentious issues can be put to one side.

> > > > > Let me reframe what I think you are saying.
> > > > > 
> > > > > If the aesthetics of the dt-bindings of my SPI device were like this (1):
> > > > > 
> > > > > (...)
> > > > > 
> > > > > then you wouldn't have had any issue about this not being MFD, correct?
> > > > 
> > > > Right.  This is more in-line with what I would expect to see.
> > > > 
> > > > > I think this is an important base fact to establish.
> > > > > It looks fairly similar to Colin Foster's bindings for VSC7512, save for
> > > > > the fact that the sub-devices are slightly more varied (which is inconsequential,
> > > > > as Andrew seems to agree).
> > > > > 
> > > > > However, the same physical reality is being described in these _actual_
> > > > > dt-bindings (2):
> > > > > 
> > > > > (...)
> > > > > 
> > > > > Your issue is that, when looking at these real dt-bindings,
jj> > > > > superficially the MDIO buses don't "look" like MFD.
> > > > > 
> > > > > To which, yes, I have no objection, they don't look like MFD because
> > > > > they were written as additions on top of the DSA schema structure, not
> > > > > according to the MFD schema.
> > > > > 
> > > > > In reality it doesn't matter much where the MDIO bus nodes are (they
> > > > > could have been under "regs" as well, or under "mfd@0"), because DSA
> > > > > ports get references to their children using phandles. It's just that
> > > > > they are _already_ where they are, and moving them would be an avoidable
> > > > > breaking change.
> > > > 
> > > > Right.  I think this is highly related to one of my previous comments.
> > > > 
> > > > I can't find it right now, but it was to the tune of; if a single driver
> > > > provides lots of functionality that _could_ be split-up, spread across
> > > > multiple different subsystems which all enumerate as completely
> > > > separate device-drivers, but isn't, then it still shouldn't meet the
> > > > criteria.
> > > 
> > > Any arbitrary set of distinct functions can be grouped into a new
> > > monolithic driver. Are you saying that grouping them together is fine,
> > > but never split them back up, at least not using MFD? What's the logic?
> > 
> > No, the opposite I think?
> > 
> > I'm saying that when they are grouped into a monolithic driver, they do
> > not match the criteria of an MFD, but if the _varying_ functionality was
> > split-up and probed individually, they would.  Take this example:
> > 
> > # Bad
> > static struct mfd_cell cells[] = {
> > 	MFD_CELL_NAME("abc-monolithic")
> > };
> > 
> > # Bad
> > static struct mfd_cell cells[] = {
> > 	MFD_CELL_NAME("abc-function-a")
> > 	MFD_CELL_NAME("abc-function-a")
> > };
> > 
> > # Good
> > static struct mfd_cell cells[] = {
> > 	MFD_CELL_NAME("abc-function-a")
> > 	MFD_CELL_NAME("abc-function-b")
> > };
> > 
> > At the moment, from what I see in front of me, you are the middle one.
> 
> I think you are missing patch 14.

Right, I hadn't seen that.

Would I be correct in saying that you're pulling out information from
DT, then populating MFD cells with it?  If so, that is one of the
reasons I like to be able to keep an eye on how the MFD API is being
used.  Populating one device registration API from another is also not
allowed and has been the source of some of the most contentious
submissions I've seen.

Looks like I briefly mentioned this before:

 "I've explained why liberalising the mfd_*() API is a bad idea.  "Clever"
  developers like to do some pretty crazy stuff involving the use of
  MULTIPLE DEVICE REGISTRATION APIS SIMULTANEOUSLY.  I've also seen some       <-----------
  bonkers methods of DYNAMICALLY POPULATING MFD CELLS [*ahem* Patch 8          <-----------
  =;-)] and various other things.  Keeping the API in-house allows me to
  keep things simple, easily readable and maintainable."

Add in a few function pointers to be used as un-debugable call-backs and
you're well on the way getting a perfect score for breaking all of the
guidelines that I use to keep code "simple, easily readable and
maintainable"!   ;)

> Although for SJA1105R/S, I am indeed in the middle position (it has to
> do with the multi-generational aspect I was telling you about).
> 
> > > > > Exactly. DSA drivers get more developed with new each new hardware
> > > > > generation, and you wouldn't want to see an MFD driver + its bindings
> > > > > "just in case" new sub-devices will appear, when currently the DSA
> > > > > switch is the only component supported by Linux (and maybe its internal
> > > > > MDIO bus).
> > > > 
> > > > If only one device is currently supported, then again, it doesn't meet
> > > > the criteria.  I've had a bunch of developers attempt to upstream
> > > > support for a single device and insist that more sub-devices are coming
> > > > which would make it an MFD, but that's not how it works.  Devices must
> > > > meet the criteria _now_.  So I usually ask them go take the time to get
> > > > at least one more device ready before attempting to upstream.
> > > 
> > > sja1105 is a multi-generational DSA driver. Gen 1 SJA1105E/T has 0
> > > sub-devices, Gen 2 SJA1105R/S have 1 sub-device (XPCS) and Gen3 SJA1110
> > > have 5+ sub-devices.
> > > 
> > > The driver was written for Gen 1, then was expanded for the later
> > > generations as the silicon was released (multiple years in between these
> > > events).
> > > 
> > > You are effectively saying:
> > > - MAX77540 wouldn't have been accepted as MFD on its own, it was
> > >   effectively carried in by MAX77541 support.
> > > - A driver that doesn't have sufficiently varied subfunctions doesn't
> > >   qualify as MFD.
> > > - A monolithic driver whose subfunctions can be split up doesn't meet
> > >   the MFD criteria.
> > 
> > If it "can", but isn't, then it doesn't, that's correct.
> > 
> > But if it _is_ split-up then it does.
> > 
> > > So in your rule system, a multi-generational driver which evolves into
> > > having multiple sub-devices has no chance of ever using MFD, unless it
> > > is written after the evolution has stopped, and the old generations
> > > become obsolete.
> > 
> > I'm really not.  I'm saying that if the driver were to be spit-up, then
> > it _would_ match the criteria and it would be free to use MFD to
> > register those split-up sub-devices.
> 
> I don't know what you meant to say, but I quote what you actually said,
> and how I interpreted it:
> 
> "if a single driver provides lots of functionality that _could_ be
> split-up, (...), but isn't [ split up ], then it still shouldn't meet
> the criteria [ for using the MFD API ]."

That's correct.  I stand by that.

... but if it is split-up into heterogeneous parts which get registered
separately then it should meet the criteria.

You're hearing "once driver has been merged, it cannot be split-up in
such as way that the MFD API cannot be used" and I'm saying the exact
opposite of that.  It absolutely can be used if the new layout meets the
criteria.

I'm not sure how much more I can make it.

> > > Unless you're of the opinion that it's my fault for not predicting
> > > the future and waiting until the SJA1110 came out in order to
> > > write an MFD driver, I suggest you could reconsider your rules so
> > > that they're less focused on your comfort as maintainer, at the
> > > expense of fairness and coherency for other developers.
> > 
> > This isn't what I've said at all.
> > 
> > What I have said is that even though you've split this up, you have
> > only split it up into 2 homogeneous devices / controllers, which
> > still does not qualify.
> > 
> > If you have plans to split out another varying function, other than
> > an MDIO controller, then do so and you can then easily qualify.
> 
> Ok, so we're getting close, you just need to take a look at patch 14.

I have looked at that now.  And yes, it solves this problem.

However, as I've explained above, it creates another.

> > > > Is there any reason not to put mdio_cbt and mdio_cbt1 resources
> > > > into the device tree
> > > 
> > > That ship has sailed and there are device trees in circulation
> > > with existing mdio_cbtx/mdio_cbt1 bindings.
> > > 
> > > > or make them available somewhere else (e.g.
> > > > driver.of_match_table.data) and use of_platform_populate()
> > > > instead of mfd_add_devices() (I can't remember if we've
> > > > suggested that before or not).
> > > 
> > > I never got of_platform_populate() to work for a pretty
> > > fundamental reason, so I don't have enough information to know
> > > what you're on about with making the mdio_cbtx/mdio_cbt1 resources
> > > available to it.
> > > 
> > > > Right, I think we've discussed this enough.  I've made a
> > > > decision.
> > > > 
> > > > If the of_platform_populate() solution doesn't work for you for
> > > > some reason (although I think it should),
> > > 
> > > Quote from the discussion on patch 8:
> > > 
> > > I did already explore of_platform_populate() on this thread which
> > > asked for advice (to which you were also copied):
> > > https://lore.kernel.org/lkml/20221222134844.lbzyx5hz7z5n763n@skbuf/
> > > 
> > >     It looks like of_platform_populate() would be an alternative
> > >     option for this task, but that doesn't live up to the task
> > >     either. It will assume that the addresses of the SoC children
> > >     are in the CPU's address space (IORESOURCE_MEM), and attempt
> > >     to translate them. It simply doesn't have the concept of
> > >     IORESOURCE_REG. The MFD drivers which call
> > >     of_platform_populate() (simple-mfd-i2c.c) simply don't have
> > >     unit addresses for their children, and this is why address
> > >     translation isn't a problem for them.
> > > 
> > >     In fact, this seems to be a rather large limitation of
> > >     include/linux/of_address.h. Even something as simple as
> > >     of_address_count() will end up trying to translate the address
> > >     into the CPU memory space, so not even open-coding the
> > >     resource creation in the SoC driver is as simple as it
> > >     appears.
> > > 
> > >     Is there a better way than completely open-coding the parsing
> > >     of the OF addresses when turning them into IORESOURCE_REG
> > >     resources (or open-coding mfd_cells for each child)? Would
> > >     there be a desire in creating a generic set of helpers which
> > >     create platform devices with IORESOURCE_REG resources, based
> > >     solely on OF addresses of children? What would be the correct
> > >     scope for these helpers?
> > 
> > Does this all boil down that pesky empty 'mdio' "container"?
> 
> Why do you keep calling it empty?

Because it has no compatible, unit address or any of its own values,
which appears to make it untraversable using the present machinery.

> > Or even if it doesn't: if what you have is a truly valid DT, then
> > why not adapt drivers/of/platform.c to cater for your use-case?
> > Then you could take your pick from whatever works better for you out
> > of of_platform_populate(), 'simple-bus' or even 'simple-mfd'.
> 
> I asked 3 years ago whether there's any interest in expanding
> of_platform_populate() for IORESOURCE_REG and there wasn't any
> response. It's a big task with overreaching side effects and you don't
> just pick up on this on a Friday afternoon.

Enjoy your weekend - we can wait until Monday! ;)

There clearly wasn't any other users.  Or at least people that haven't
found other ways around the issue.  But if you need it, and you can
justify the work with a clear use-case, write support for it.

> > > > given the points you've put forward, I would be content for you
> > > > to house the child device registration (via mfd_add_devices) in
> > > > drivers/mfd if you so wish.
> > > 
> > > Thanks! But I don't know how this helps me :)
> > > 
> > > Since your offer involves changing dt-bindings in order to
> > > separate the MFD parent from the DSA switch (currently the DSA
> > > driver probes on the spi_device, clashing with the MFD parent
> > > which wants the same thing), I will have to pass.
> > 
> > I haven't taken a look at the DT bindings in close enough detail to
> > provide a specific solution, but _perhaps_ it would be possible to
> > match the MFD driver to the existing compatible, then use the MFD
> > driver to register the current DSA driver.
> 
> The MFD driver and the DSA driver would compete for the same OF node.
> And again, you'd still return to the problem of where to attach the
> DSA switch's sub-devices in the device tree (currently to the "mdios"
> and "regs" child nodes, which MFD doesn't support probing on, unless
> we apply the mfd_cell.parent_of_node patch).

No, the MFD driver would adopt the compatible and register the DSA
driver for device-driver matching. You could then obtain the node for
parsing the DSA using node->parent.

I suspect you'd be better off manually crawling through the 'mdio' cell
in the child drivers using node->parent.

> > However, after this most recent exchange, I am even less confident
> > that using the MFD API to register only 2 MDIO controllers is the
> > right thing to do.
> > 
> > > Not because I insist on being difficult, but because I know that
> > > when I change dt-bindings, the old ones don't just disappear and
> > > will continue to have to be supported, likely through a separate
> > > code path that would also increase code complexity.
> > 
> > Right, they have to be backwardly compatible, I get that.
> > 
> > > > Although I still don't think modifying the core to ignore
> > > > bespoke empty "container" nodes is acceptable.  It looks like
> > > > this was merged without a proper DT review.  I'm surprised that
> > > > this was accepted.
> > > 
> > > There was a debate when this was accepted, but we didn't come up
> > > with anything better to fulfill the following constraints: - As
> > > per mdio.yaml, the $nodename has to follow the pattern:
> > > '^mdio(-(bus|external))?(@.+|-([0-9]+))?$' - There are two MDIO
> > > buses. So we have to choose the variant with a unit-address (both
> > > MDIO buses are for internal PHYs, so we can't call one "mdio" and
> > > the other "mdio-external"). - Nodes with a unit address can't be
> > > hierarchical neighbours with nodes with no unit address
> > > (concretely: "ethernet-ports" from
> > > Documentation/devicetree/bindings/net/ethernet-switch.yaml, the
> > > main schema that the DSA switch conforms to). This is because
> > > their parent either has #address-cells = <0>, or #address-cells =
> > > <1>. It can't simultaneously have two values.
> > > 
> > > Simply put, there is no good place to attach child nodes with unit
> > > addresses to a DT node following the DSA (or the more general
> > > ethernet-switch) schema. The "mdios" container node serves exactly
> > > that adaptation purpose.
> > > 
> > > I am genuinely curious how you would have handled this better, so
> > > that I also know better next time when I'm in a similar situation.
> > > 
> > > Especially since "mdios" is not the only container node with this
> > > issue. The "regs" node proposed in patch 14 serves exactly the
> > > same purpose (#address-cells adaptation), and needs the exact same
> > > ".parent_of_node = regs_node" workaround in the mfd_cell.
> > 
> > Please correct me if I'm wrong, but from what I have gathered, all
> > you're trying to do here is probe a couple of child devices
> > (controllers, whatever) and you've chosen to use MFD for this
> > purpose because the other, more generic machinery that would
> > normally _just work_ for simple scenarios like this, do not because
> > you are attempting to support a non-standard DT.  Or at least one
> > that isn't supported.
> 
> Sorry, what makes the DT non-standard?

The fact that the current OF APIs can't parse / traverse it.

> > With that in mind, some suggestions going forward in order of
> > preference:
> > 
> > - Adapt the current auto-registering infrastructure to support your
> > DT layout - of_platform_populate(), simple-bus, simple-mfd, etc -
> > Use fundamental / generic / flexible APIs that do not have specific
> > rules - platform_*() - Move the mfd_device_add() usage into
> > drivers/mfd - Although after this exchange, this is now my least
> > preferred option
> 
> I could explore other options, but I want to be prepared to answer
> other maintainers' question "why didn't you use MFD?". There is no
> clear answer to that, you are not providing answers that have taken
> all evidence into account, so that is why I'm being extremely pushy,
> sorry.

That's fine.  If questioned, point them to this summary:

What you're doing here; attempting to reverse engineer old DTBs by
extracting information from them to populate a different device
registration API (DT, MFD, Plat, ACPI, etc) is not suitable for MFD due
to reasons pertaining to; keeping things simple, easily readable and
maintainable (see Patch 14 for an example of this).

 - MFDs should contain multiple, varying, heterogeneous devices
 - MFD parents should only use one registration API at a time
 - The MFD API should not be used outside of drivers/mfd
 - Dynamically allocating mfd_cells is STRONGLY discouraged

If you think that you can match all of the above criteria, then you may
use the MFD API.  If not, then it is not suitable for your use-case and
you should seek other means of device registration.  I suggest;
of_platform_populate(), platform_add_devices() [and friends],
'simple-bus' and 'simple-mfd', although I'm sure there are others.

-- 
Lee Jones [李琼斯]

