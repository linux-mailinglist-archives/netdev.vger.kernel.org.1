Return-Path: <netdev+bounces-250486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B12FD2E293
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 09:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55AEB3030234
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 08:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45533081B8;
	Fri, 16 Jan 2026 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lsro2Q6E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10BD3064B3;
	Fri, 16 Jan 2026 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768552827; cv=none; b=aRe0PXSdzZmW4gokkU75d3Za5+NAkYbJQ1MCD/+WDOQe8rsoeAWyMJ++6K9RZbtjUAn3yc9DrhIMOQRwsji56E4aDvoSb1wWl5f2zZ9A0TcXaa0e9xGSt91BktbKwzfGlawCvjUgzX93edwFtEiWdXnSPKBPfzuK7ffvbpMTA7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768552827; c=relaxed/simple;
	bh=xEuhmAJoSFAlNtC81mN8dL/9XFsGG8is018hOlT9YiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUZGq2mpcWr/kChQT8jwJh3FvTKeSA7O+J6FQ3V0CnzsEdsBvH9QX35AryI3eMA4ff2vkirwY4mvjkoh1LcxitQ+tIvLn+t1vPsf0MqeiKkyvNva5KD/4s+dEkhyIfsbkOl2eisSw415F0auqdOx6HUxBae0Yaan/Ohygz4wKDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lsro2Q6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121AAC116C6;
	Fri, 16 Jan 2026 08:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768552827;
	bh=xEuhmAJoSFAlNtC81mN8dL/9XFsGG8is018hOlT9YiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lsro2Q6E80RXKV8QqFCPLQoU0W/cVuGM9XeFp8namQrUcq6BIbllWXMyLqbkF3mTz
	 dhHDLQt2BARHHIfZ3PggZYGNzxddrDPWqhD1FYKISqmD1wMyBAgfZklnXp+iHX678p
	 xUpS4qQic+YOL9DjfPWs5FE0QAvaIzESOw19ip6rbdLmPkXK/nKVDcC1U6l7/Sd6rh
	 Qp8fSKMUMrAdwngOtW04nRHQHr5pYfqLddV5HzjlCdnI/xoj8RiFbyHLXFG2sguPVs
	 PjwnDrXwpMmqfjZkiTth39/AUPFhk2si3D+lkBmsngP0ogOEgf9IctPgY4WGhMMs7u
	 g5rjG29Q89TlQ==
Date: Fri, 16 Jan 2026 08:40:21 +0000
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
Message-ID: <20260116084021.GA374466@google.com>
References: <20251121170308.tntvl2mcp2qwx6qz@skbuf>
 <20251215155028.GF9275@google.com>
 <20251216002955.bgjy52s4stn2eo4r@skbuf>
 <20251216091831.GG9275@google.com>
 <20251216162447.erl5cuxlj7yd3ktv@skbuf>
 <20260109103105.GE1118061@google.com>
 <20260109121432.lu2o22iijd4i57qq@skbuf>
 <20260115161407.GI2842980@google.com>
 <20260115161407.GI2842980@google.com>
 <20260115185759.femufww2b6ar27lz@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260115185759.femufww2b6ar27lz@skbuf>

On Thu, 15 Jan 2026, Vladimir Oltean wrote:

> On Thu, Jan 15, 2026 at 04:14:07PM +0000, Lee Jones wrote:
> > > > My plan, when and if I manage to find a few spare cycles, is to remove
> > > > MFD use from outside drivers/mfd.  That's been my rule since forever.
> > > > Having this in place ensures that the other rules are kept and (mild)
> > > > chaos doesn't ensue.  The MFD API is trivial to abuse.  You wouldn't
> > > > believe some of things I've seen over the years.  Each value I have is
> > > > there for a historical reason.
> > > 
> > > If you're also of the opinion that MFD is a Linux-specific
> > > implementation detail and a figment of our imagination as developers,
> > > then I certainly don't understand why Documentation/devicetree/bindings/mfd/
> > > exists for this separate device class that is MFD, and why you don't
> > > liberalize access to mfd_add_devices() instead.
> > 
> > The first point is a good one.  It mostly exists for historical
> > reasons and for want of a better place to locate the documentation.
> > 
> > I've explained why liberalising the mfd_*() API is a bad idea.  "Clever"
> > developers like to do some pretty crazy stuff involving the use of
> > multiple device registration APIs simultaneously.  I've also seen some
> > bonkers methods of dynamically populating MFD cells [*ahem* Patch 8
> > =;-)] and various other things.  Keeping the API in-house allows me to
> > keep things simple, easily readable and maintainable.
> 
> The only thing that's crazy to me is how the MFD documentation (+ my
> intuition as engineer to fill in the gaps where the documentation was
> lacking, aka in a lot of places) could be so far off from what you lay
> out as your maintainer expectations here.

MFD has documentation?  =;-)

/me `find . | grep -i mfd`s

Okay, the only "MFD documentation" I can find is:

  Documentation/devicetree/bindings/mfd/mfd.txt

The first paragraph reflects the point I've been trying to make:

 "These devices comprise a nexus for HETEROGENEOUS hardware blocks
  containing more than one non-unique yet VARYING HARDWARE FUNCTIONALITY.

2 MDIO controllers are homogeneous to each other and are not varying.

How is the documentation and what I say "so far off"?

> > > > I had to go and remind myself of your DT:
> > > > 
> > > >         ethernet-switch@0 {
> > > >                 compatible = "nxp,sja1110a";
> > > > 
> > > >                 mdios {
> > > >                         mdio@0 {
> > > >                                 compatible = "nxp,sja1110-base-t1-mdio";
> > > >                         };
> > > > 
> > > >                         mdio@1 {
> > > >                                 compatible = "nxp,sja1110-base-tx-mdio";
> > > >                         };
> > > >                 };
> > > >         };
> > > > 
> > > > To my untrained eye, this looks like two instances of a MDIO device.
> > > > 
> > > > Are they truly different enough to be classified for "Multi"?
> > > 
> > > Careful about terms, these are MDIO "buses" and not MDIO "devices"
> > > (children of those buses).
> > 
> > Noted.  But then isn't it odd to see the bus mentioned in the compatible
> > string.  Don't we usually only see this in the controller's compatibles?
> 
> ???
> bus == controller.
> The "nxp,sja1110-base-t1-mdio" and "nxp,sja1110-base-tx-mdio" are MDIO
> buses/controllers following the Documentation/devicetree/bindings/net/mdio.yaml
> schema.
> There are plenty of other devices which have "$ref: mdio.yaml#" and
> which have "mdio" in their compatible string: "ti,davinci_mdio",
> "qcom,ipq8064-mdio"... This is the same thing.
> 
> The "MDIO bus" / "MDIO device" terminology distinction is no different
> than "SPI bus" / "SPI device", if that helps you better understand why I
> said "buses, not devices".

Okay, so these are the MDIO bus controllers - that's clear now, thank you.

I was confused by the t1 and tx parts.  Are these different types of
MDIO controllers or are they the same, but vary only in support / role?

But again, if these are "both MDIO controllers", then they are _same_.

> > > Let me reframe what I think you are saying.
> > > 
> > > If the aesthetics of the dt-bindings of my SPI device were like this (1):
> > > 
> > > (...)
> > > 
> > > then you wouldn't have had any issue about this not being MFD, correct?
> > 
> > Right.  This is more in-line with what I would expect to see.
> > 
> > > I think this is an important base fact to establish.
> > > It looks fairly similar to Colin Foster's bindings for VSC7512, save for
> > > the fact that the sub-devices are slightly more varied (which is inconsequential,
> > > as Andrew seems to agree).
> > > 
> > > However, the same physical reality is being described in these _actual_
> > > dt-bindings (2):
> > > 
> > > (...)
> > > 
> > > Your issue is that, when looking at these real dt-bindings,
> > > superficially the MDIO buses don't "look" like MFD.
> > > 
> > > To which, yes, I have no objection, they don't look like MFD because
> > > they were written as additions on top of the DSA schema structure, not
> > > according to the MFD schema.
> > > 
> > > In reality it doesn't matter much where the MDIO bus nodes are (they
> > > could have been under "regs" as well, or under "mfd@0"), because DSA
> > > ports get references to their children using phandles. It's just that
> > > they are _already_ where they are, and moving them would be an avoidable
> > > breaking change.
> > 
> > Right.  I think this is highly related to one of my previous comments.
> > 
> > I can't find it right now, but it was to the tune of; if a single driver
> > provides lots of functionality that _could_ be split-up, spread across
> > multiple different subsystems which all enumerate as completely
> > separate device-drivers, but isn't, then it still shouldn't meet the
> > criteria.
> 
> Any arbitrary set of distinct functions can be grouped into a new
> monolithic driver. Are you saying that grouping them together is fine,
> but never split them back up, at least not using MFD? What's the logic?

No, the opposite I think?

I'm saying that when they are grouped into a monolithic driver, they do
not match the criteria of an MFD, but if the _varying_ functionality was
split-up and probed individually, they would.  Take this example:

# Bad
static struct mfd_cell cells[] = {
	MFD_CELL_NAME("abc-monolithic")
};

# Bad
static struct mfd_cell cells[] = {
	MFD_CELL_NAME("abc-function-a")
	MFD_CELL_NAME("abc-function-a")
};

# Good
static struct mfd_cell cells[] = {
	MFD_CELL_NAME("abc-function-a")
	MFD_CELL_NAME("abc-function-b")
};

At the moment, from what I see in front of me, you are the middle one.

> > > Exactly. DSA drivers get more developed with new each new hardware
> > > generation, and you wouldn't want to see an MFD driver + its bindings
> > > "just in case" new sub-devices will appear, when currently the DSA
> > > switch is the only component supported by Linux (and maybe its internal
> > > MDIO bus).
> > 
> > If only one device is currently supported, then again, it doesn't meet
> > the criteria.  I've had a bunch of developers attempt to upstream
> > support for a single device and insist that more sub-devices are coming
> > which would make it an MFD, but that's not how it works.  Devices must
> > meet the criteria _now_.  So I usually ask them go take the time to get
> > at least one more device ready before attempting to upstream.
> 
> sja1105 is a multi-generational DSA driver. Gen 1 SJA1105E/T has 0
> sub-devices, Gen 2 SJA1105R/S have 1 sub-device (XPCS) and Gen3 SJA1110
> have 5+ sub-devices.
> 
> The driver was written for Gen 1, then was expanded for the later
> generations as the silicon was released (multiple years in between these
> events).
> 
> You are effectively saying:
> - MAX77540 wouldn't have been accepted as MFD on its own, it was
>   effectively carried in by MAX77541 support.
> - A driver that doesn't have sufficiently varied subfunctions doesn't
>   qualify as MFD.
> - A monolithic driver whose subfunctions can be split up doesn't meet
>   the MFD criteria.

If it "can", but isn't, then it doesn't, that's correct.

But if it _is_ split-up then it does.

> So in your rule system, a multi-generational driver which evolves into
> having multiple sub-devices has no chance of ever using MFD, unless it
> is written after the evolution has stopped, and the old generations
> become obsolete.

I'm really not.  I'm saying that if the driver were to be spit-up, then
it _would_ match the criteria and it would be free to use MFD to
register those split-up sub-devices.

> Unless you're of the opinion that it's my fault for not predicting the
> future and waiting until the SJA1110 came out in order to write an MFD
> driver, I suggest you could reconsider your rules so that they're less
> focused on your comfort as maintainer, at the expense of fairness and
> coherency for other developers.

This isn't what I've said at all.

What I have said is that even though you've split this up, you have only
split it up into 2 homogeneous devices / controllers, which still does
not qualify.

If you have plans to split out another varying function, other than an
MDIO controller, then do so and you can then easily qualify.

> > Is there any reason not to put mdio_cbt and mdio_cbt1 resources into the
> > device tree
> 
> That ship has sailed and there are device trees in circulation with
> existing mdio_cbtx/mdio_cbt1 bindings.
> 
> > or make them available somewhere else (e.g. driver.of_match_table.data)
> > and use of_platform_populate() instead of mfd_add_devices() (I can't
> > remember if we've suggested that before or not).
> 
> I never got of_platform_populate() to work for a pretty fundamental
> reason, so I don't have enough information to know what you're on about
> with making the mdio_cbtx/mdio_cbt1 resources available to it.
> 
> > Right, I think we've discussed this enough.  I've made a decision.
> > 
> > If the of_platform_populate() solution doesn't work for you for some
> > reason (although I think it should),
> 
> Quote from the discussion on patch 8:
> 
> I did already explore of_platform_populate() on this thread which asked
> for advice (to which you were also copied):
> https://lore.kernel.org/lkml/20221222134844.lbzyx5hz7z5n763n@skbuf/
> 
>     It looks like of_platform_populate() would be an alternative option for
>     this task, but that doesn't live up to the task either. It will assume
>     that the addresses of the SoC children are in the CPU's address space
>     (IORESOURCE_MEM), and attempt to translate them. It simply doesn't have
>     the concept of IORESOURCE_REG. The MFD drivers which call
>     of_platform_populate() (simple-mfd-i2c.c) simply don't have unit
>     addresses for their children, and this is why address translation isn't
>     a problem for them.
> 
>     In fact, this seems to be a rather large limitation of include/linux/of_address.h.
>     Even something as simple as of_address_count() will end up trying to
>     translate the address into the CPU memory space, so not even open-coding
>     the resource creation in the SoC driver is as simple as it appears.
> 
>     Is there a better way than completely open-coding the parsing of the OF
>     addresses when turning them into IORESOURCE_REG resources (or open-coding
>     mfd_cells for each child)? Would there be a desire in creating a generic
>     set of helpers which create platform devices with IORESOURCE_REG resources,
>     based solely on OF addresses of children? What would be the correct
>     scope for these helpers?

Does this all boil down that pesky empty 'mdio' "container"?

Or even if it doesn't: if what you have is a truly valid DT, then why
not adapt drivers/of/platform.c to cater for your use-case?  Then you
could take your pick from whatever works better for you out of
of_platform_populate(), 'simple-bus' or even 'simple-mfd'.

> > given the points you've put forward, I would be content for you to
> > house the child device registration (via mfd_add_devices) in
> > drivers/mfd if you so wish.
> 
> Thanks! But I don't know how this helps me :)
> 
> Since your offer involves changing dt-bindings in order to separate the
> MFD parent from the DSA switch (currently the DSA driver probes on the
> spi_device, clashing with the MFD parent which wants the same thing), I
> will have to pass.

I haven't taken a look at the DT bindings in close enough detail to
provide a specific solution, but _perhaps_ it would be possible to match
the MFD driver to the existing compatible, then use the MFD driver to
register the current DSA driver.

However, after this most recent exchange, I am even less confident that
using the MFD API to register only 2 MDIO controllers is the right thing
to do.

> Not because I insist on being difficult, but because I know that when I
> change dt-bindings, the old ones don't just disappear and will continue
> to have to be supported, likely through a separate code path that would
> also increase code complexity.

Right, they have to be backwardly compatible, I get that.

> > Although I still don't think modifying the core to ignore bespoke empty
> > "container" nodes is acceptable.  It looks like this was merged without
> > a proper DT review.  I'm surprised that this was accepted.
> 
> There was a debate when this was accepted, but we didn't come up with
> anything better to fulfill the following constraints:
> - As per mdio.yaml, the $nodename has to follow the pattern:
>   '^mdio(-(bus|external))?(@.+|-([0-9]+))?$'
> - There are two MDIO buses. So we have to choose the variant with a
>   unit-address (both MDIO buses are for internal PHYs, so we can't call
>   one "mdio" and the other "mdio-external").
> - Nodes with a unit address can't be hierarchical neighbours with nodes
>   with no unit address (concretely: "ethernet-ports" from
>   Documentation/devicetree/bindings/net/ethernet-switch.yaml, the main
>   schema that the DSA switch conforms to). This is because their parent
>   either has #address-cells = <0>, or #address-cells = <1>. It can't
>   simultaneously have two values.
> 
> Simply put, there is no good place to attach child nodes with unit
> addresses to a DT node following the DSA (or the more general
> ethernet-switch) schema. The "mdios" container node serves exactly that
> adaptation purpose.
> 
> I am genuinely curious how you would have handled this better, so that I
> also know better next time when I'm in a similar situation.
> 
> Especially since "mdios" is not the only container node with this issue.
> The "regs" node proposed in patch 14 serves exactly the same purpose
> (#address-cells adaptation), and needs the exact same ".parent_of_node = regs_node"
> workaround in the mfd_cell.

Please correct me if I'm wrong, but from what I have gathered, all
you're trying to do here is probe a couple of child devices
(controllers, whatever) and you've chosen to use MFD for this purpose
because the other, more generic machinery that would normally _just
work_ for simple scenarios like this, do not because you are attempting
to support a non-standard DT.  Or at least one that isn't supported.

With that in mind, some suggestions going forward in order of preference:

- Adapt the current auto-registering infrastructure to support your DT layout
  - of_platform_populate(), simple-bus, simple-mfd, etc
- Use fundamental / generic / flexible APIs that do not have specific rules
  - platform_*()
- Move the mfd_device_add() usage into drivers/mfd
  - Although after this exchange, this is now my least preferred option

Hope that helps.  Good luck with however you decide to proceed.

-- 
Lee Jones [李琼斯]

