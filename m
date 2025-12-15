Return-Path: <netdev+bounces-244792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DCCCBEC5E
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 16:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F45A30463BB
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 15:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E11308F23;
	Mon, 15 Dec 2025 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uz/ABmHN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F612D73B2;
	Mon, 15 Dec 2025 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765813833; cv=none; b=G2mOzH9HS0iYwmw7We272JRD2jJTvCTGVBZhEyVPMe+am+yGa1GYpQFPWf0F4gH30I9WeBnj21ZjQ37eZcYUb9BzUVE140SM2ymuyqGYlrAkRxZ8t7i9Xf85uZZlgO7Nc09ZAvajWNw7VSQSdpPJKuDFBP8QwiELwOgnhd/oEcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765813833; c=relaxed/simple;
	bh=ueOYq0Wq2pAOzqDJ3xhrugYedZRgAoikFM+pzjO+wYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPr6oiV2Xd66Cxwi/+09KPW4EraIWbD7By43e7jDHsryavabzV8Ao36Isfze+y3r7eudmXyKKJhD0hx/SEZNX/EKCqRGLlV+rKGQTS3m9rPwYQy3XA6n0LrmI0NfsTvS8YhxRiXyrcLev/X2ATLqew1Qv7mopMVlI4DIXhAFGJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uz/ABmHN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C82C4CEF5;
	Mon, 15 Dec 2025 15:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765813833;
	bh=ueOYq0Wq2pAOzqDJ3xhrugYedZRgAoikFM+pzjO+wYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uz/ABmHNcSbWLY6/mgeBQe3jsSbUg7VwV64sxnGlViiHnT3c0OD1cR2x76R9E5hbA
	 GdwrKRXrr6G6ASQeklnP3XRdhE3eToi8n8W6NXEmm+u9FCyux5hPEi5ZFJ9EtK8/+V
	 QG+9Fb5Nsk6YZHQ00cJU6U4Li2/fwGvBfMy95lg+D52CK7pMOjyGUa77esYb1vS3hw
	 Mi/n16fx/FWDkEm/0vK9BVt5b0ngAHs6uqtdV1Bh8O1T+Cq/FhMXNLXAAWvxj/1gGd
	 miLYwa/o9hnsw2bp9aFxZ0X/F9X/MqPVsTyRZ2Wdrc2oOwiDkBcwARN4x/+VDlA08M
	 rbHbxR4np8Glw==
Date: Mon, 15 Dec 2025 15:50:28 +0000
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
Message-ID: <20251215155028.GF9275@google.com>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-8-vladimir.oltean@nxp.com>
 <20251120144136.GF661940@google.com>
 <20251120153622.p6sy77coa3de6srw@skbuf>
 <20251121120646.GB1117685@google.com>
 <20251121170308.tntvl2mcp2qwx6qz@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251121170308.tntvl2mcp2qwx6qz@skbuf>

Sorry for the delay.

Just getting around to some task items en-route back from Plumbers.

> On Fri, Nov 21, 2025 at 12:06:46PM +0000, Lee Jones wrote:
> > MFD is Linuxisum, simply used to split devices up such that each
> > component can be located it their own applicable subsystem and be
> > reviewed and maintained by the subject matter experts of those domains.
> 
> Perfect, so the SJA1110 fits the MFD bill perfectly.
> 
> I'm getting the impression that the more I write to explain, the fewer
> chances I have for you to read. I'll try to keep things as concise as I
> can, but please remember that:
> - We've had the exact same discussions with Colin Foster's VSC7512
>   work, which you ended up accepting
> - This email sent to you in 2022 and again in the other reply on patch 8:
>   https://lore.kernel.org/lkml/20221222134844.lbzyx5hz7z5n763n@skbuf/
>   already explains what is the kind of hardware I'm dealing with
> 
> > TL;DR: if your device only deals with Networking, that's where it should
> > live.  And from there, it should handle its own device registration and
> > instantiation without reaching into other, non-related subsystems.
> 
> Ok, you make a vague reference which I think I understand the point of.
> 
> I need to merge the discussion with the one from patch 8:
> https://lore.kernel.org/netdev/20251121120037.GA1117685@google.com/
> where you say:
> 
> | Another more recent avenue you may explore is the Auxiliary Bus.
> 
> Excerpt from documentation here:
> https://docs.kernel.org/driver-api/auxiliary_bus.html
> 
>   When Should the Auxiliary Bus Be Used
> 
>   (...)
>   The emphasis here is on a common generic interface that keeps subsystem
>   customization out of the bus infrastructure.
>   (...)
>   A key requirement for utilizing the auxiliary bus is that there is no
>   dependency on a physical bus, device, register accesses or regmap
>   support. These individual devices split from the core cannot live on the
>   platform bus as they are not physical devices that are controlled by
>   DT/ACPI. The same argument applies for not using MFD in this scenario as
>   MFD relies on individual function devices being physical devices.
> 
> The thesis I need to defend is that the SJA1110 usage is 100% fit for
> MFD and 0% auxiliary bus. In order to explain it I have to give a bit of
> history on DSA.
> 
> DSA is a Linuxism for managing Ethernet switches. Key thing is they are
> a hardware IP with registers to configure them. There are many ways
> to integrate an Ethernet switch hardware IP in a chip that you sell.
> You can (a) sell the IP itself for SoC vendors to put in their address
> space and access using MMIO, or you can (b) sell them an entire chip
> with the switch IP in it, that they access over a bus like PCIe, SPI,
> I2C, MDIO, whatever, and integrate with their existing Linux SoC.
> 
> DSA has started from a place where it didn't really understand that its
> core domain of expertise was the Ethernet switching IP itself. The first
> devices it supported were all of the (b) kind, discrete chips on buses.
> Thus, many drivers were written where DSA takes charge of the struct
> spi_device, mdio_device, i2c_client etc.
> 
> These early drivers are simplistic, they configure the switch to pass
> traffic, and the PHYs through the internal MDIO bus to establish a link,
> and voila! They pass traffic, they're good to go.
> 
> Then you start to want to develop these further. You want to avoid
> polling PHYs for link status every second.. well, you find there's an
> interrupt controller in that chip too, that you should be using with
> irqchip. You want to read the chip's temperature to prevent it from
> overheating - you find temperature sensors too, for which you register
> with hwmon. You find reset blocks, clock generation blocks, power
> management blocks, GPIO controllers, what have you.
> 
> See, the more you look at the datasheet, the more you start to notice
> an entire universe of hardware IPs, and then.. you notice a microcontroller!
> Those hardware IPs are all also memory-mapped in the address space of
> that microcontroller, and when you from Linux are accessing them, you're
> just going through a SPI-to-AHB bridge.
> 
> Things become really shitty when the DSA chip that you want to drive
> from drivers/net/dsa has a full-blown microprocessor capable of running
> Linux instead of that microcontroller! Then you have to support driving
> the same switch from the small Linux, using MMIO, or from the big Linux,
> over SPI.
> 
> Out of a lack of expressivity that we as engineers have, we call both
> the SoC at large "a switch", and the switching IP "a switch". Hell,
> we even call the rack-mounted pizza box computer with many ports "a switch",
> no wonder nobody understands anything! We just name things after the
> most important thing that's in them.
> 
> So unwind 100 steps from the rabbit hole and ask: what does DSA concern
> itself with?
> 
> Ideally, the answer is "the Ethernet switch IP". This is always mapped
> in somebody's address space from address X to Y.
> 
> Practically, legacy makes it that DSA concerns itself with the entire
> address space of SPI devices, MDIO devices, I2C devices etc. If you
> imagine a microprocessor in these discrete chips (which is architecturally
> almost always possible), the device tree of that would only describe a
> single region with the Ethernet switching IP, and Linux would probe a
> platform device for that. The rest is.. other stuff (of various degrees
> of functional relatedness, but nonetheless, other stuff) with *other*
> platform devices.
> 
> So, DSA is in a process of trying to define a conversion model that is
> coherent, compatible with the past, minimal in its description,
> applicable to other devices, and not a pain in the butt.
> 
> Fact of the matter is, we will always clash with the MFD maintainer in
> this process, and it simply doesn't scale for us to keep repeating the
> same stuff over and over. It is just too much friction. We went through
> this once, with Colin Foster who added the Microchip VSC7512 as MFD
> through your tree, and that marked the first time when a DSA driver over
> a SPI device concerned itself with just the switching IP, using MFD as
> the abstraction layer.
> 
> The NXP SJA1110 is just another step in that journey, but this one is
> harder because it has legacy device tree bindings to maintain. However,
> if we are to accept that Colin Foster's work was not an architectural
> mistake, then the SJA1110 is not the end of the road either, and you
> have to be prepared for more devices to come and do the same thing.
> 
> So practically speaking, the fact that DSA has these particular needs
> is just a fact. Treat the above description as a "global prompt", if you
> will :)
> 
> So why not the auxiliary bus? That creates auxiliary_device structures,
> which are fake things that some core device wants to keep out to make
> things leaner. But what we want is a platform_device, because that is
> the common denominator between what kind of drivers the "small Linux"
> and the "big Linux" would use for the same hardware IPs. MFD gives us
> exactly that, and regmap provides the abstraction between MMIO and SPI.
> 
> ================================================================
> 
> The above was the "global prompt" that you need to have in your context,
> now let's return to the patch at hand.
> 
> SJA1110 is *not* capable of running Linux inside. This allows us to get
> away with partial conversions, where the DSA driver still remains in
> charge of the entire SPI device, but delegates the other stuff to MFD.
> 
> The existing bindings cannot be broken. Hindsight is 20/20, but whatever
> stupid decisions I made in the past with this "mdios" container node are
> there to stay.

Thanks for drafting all of this.  It's not an ideal level of verboseness
for a busy maintainer with 50+ of reviews to do, but I appreciate your
depth of knowledge and the eloquence of the writing.

There does appear to be at least some level of misunderstanding between
us.  I'm not for one moment suggesting that a switch can't be an MFD. If
it contains probe-able components that need to be split-up across
multiple different subsystems, then by all means, move the core driver
into drivers/mfd/ and register child devices 'till your heart's content.

What I am saying, however, is that from what I can see in front of me,
there doesn't appear to be any evidence that this device belongs there.

Unless there's something I'm missing, it looks awfully like you're
simply trying to register a couple of platform deices devices and you've
chosen to use the MFD API as a convenient way to do so.  That is not
what MFD is for.

Side note: The implementation is also janky.

> Fact of the matter is, we will always clash with the MFD maintainer in
> this process, and it simply doesn't scale for us to keep repeating the
> same stuff over and over. It is just too much friction. We went through
> this once, with Colin Foster who added the Microchip VSC7512 as MFD
> through your tree, and that marked the first time when a DSA driver over
> a SPI device concerned itself with just the switching IP, using MFD as
> the abstraction layer.

I don't recall those discussions from 3 years ago, but the Ocelot
platform, whatever it may be, seems to have quite a lot more
cross-subsystem device support requirements going on than I see here:

drivers/i2c/busses/i2c-designware-platdrv.c
drivers/irqchip/irq-mscc-ocelot.c
drivers/mfd/ocelot-*
drivers/net/dsa/ocelot/*
drivers/net/ethernet/mscc/ocelot*
drivers/net/mdio/mdio-mscc-miim.c
drivers/phy/mscc/phy-ocelot-serdes.c
drivers/pinctrl/pinctrl-microchip-sgpio.c
drivers/pinctrl/pinctrl-ocelot.c
drivers/power/reset/ocelot-reset.c
drivers/spi/spi-dw-mmio.c
net/dsa/tag_ocelot_8021q.c

> - We've had the exact same discussions with Colin Foster's VSC7512
>   work, which you ended up accepting

Quick update: After doing a little searching for Colin's original
patch-set, I've managed to find as far back as v5 (v16 was merged),
which I believe was the first version that proposed using MFD.  There
were lots of review comments and an insistence to add more than one
device (rather than adding them subsequently) to make it a true MFD,
however, I don't see any suggestion that MFD wasn't the right place for
it.

> Then you start to want to develop these further. You want to avoid
> polling PHYs for link status every second.. well, you find there's an
> interrupt controller in that chip too, that you should be using with
> irqchip. You want to read the chip's temperature to prevent it from
> overheating - you find temperature sensors too, for which you register
> with hwmon. You find reset blocks, clock generation blocks, power
> management blocks, GPIO controllers, what have you.

Absolutely!  MFD would be perfect for that.

My point is, you don't seem to have have any of that here.

-- 
Lee Jones [李琼斯]

