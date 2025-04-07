Return-Path: <netdev+bounces-179773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BE6A7E80A
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2601C1720AA
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CFC21506C;
	Mon,  7 Apr 2025 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtyQ2/hB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933E9215063;
	Mon,  7 Apr 2025 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046513; cv=none; b=t0H3HQJs0GAu3JnUCsxExntdMBalGMOqwSi6g91tAUqzrD3A6V4R+PJDvyiPPoBicku3sepSAoPZItPhTC8WoGuaCprb+/UTuAWDohlvLm9ETvHaDHIBdV4ghRBrsrwSg2o1fb5K/cs7LtpZNIAN6SYVNLp3aD7Lx5B7iZqB7ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046513; c=relaxed/simple;
	bh=S72Mkz3zgNGVcDS4hZJ2hQzXmNaocN7YC3Oo5EyLwos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1sPKi8i3QXkuMPX+OxxHRCqL1QljRSnKQqjPZy0epfZET9T9AtRRqhZBASYOSFNZ2AGT3297jQh33N0imhKDH5/EIDs/JmpajpFAHwXfo5uBB/UgT+Fl7eVZM87GOAb8VJPj7OsBppatIhy2ad9wbris2QSnCc92kVOmtwwjx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtyQ2/hB; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c54f67db99so545928185a.1;
        Mon, 07 Apr 2025 10:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744046510; x=1744651310; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Lpv+G8DKtsTH/9Jnl9+3WmC00rN+BEBcmyoDdyEm2g=;
        b=MtyQ2/hBKPeHSEKLn72xOz6idDoJ2UlDaWmcIaMoCOqJOYNyLwhyITYOU5LwUXitUI
         SI0xMPGqj+C3o56bHla2kOt6oF1Oz2uYzUSyui79w+pFH+xB6wM4jEk69snA5/GTrDpL
         XBRFCJnZfeXE5Wfn8dOt9XXP9j49LADEBuotCratE1v3PvFphxpqnrlDHad46ag3KkSd
         EbSuKdHQ1VlXYIzHht3KD+b439aGBJlN5AxwSfVA52fU4NBdWmrDzVJnhpkCVWbf52DY
         5U541bmg1eOYz54yWiT/4Duf4yMphqAYUW7WhYP18Uitq3cGtl0gncXcDMAwz9NKpFlz
         O7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744046510; x=1744651310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Lpv+G8DKtsTH/9Jnl9+3WmC00rN+BEBcmyoDdyEm2g=;
        b=dnJiQ0uWJF+0RxO6uXhe9hTVhMJH6urvpm79wqyLL1UH/TACSTtzdvO+OR8KpwFLRt
         JRMvPYPOMuEVPAiTPucJDoGdPEYr74T4ANgprMWdZuEdmfGNgxM2ua4iuPPEzugmOGoD
         RBDB1KHLFCkNBVuOMXV1PL3vjUuDc+Zp9UoDI8JI1Zk6jOP7aKI81eJUa9WiItunKq26
         ykV5AapXNXWGJ1O6G3GyM9jK23o1cHMYvIH8/tMb1set/h0/mjFtwDWSYqr8VAsrf8gd
         bcUcj5U+2PEcl6UW3iTwSstw1pnHCkzvbija0H/kHFThtEbd6zVSE7YkOEsPVMOzXSlU
         59+A==
X-Forwarded-Encrypted: i=1; AJvYcCUPcoEjiNyykNHZ9+rC66BYd1niLX+kKEt1/p5uBOliHs+lYzBrzDB4ZVCvkfi1gw4NQacWcTgizlsG@vger.kernel.org, AJvYcCUe5lqTMFAOBeGTT9q7OY0tPp0qqmf2yCqXUFghjghpAsU5dBJMLcQ0t8GcaHEhNQpCUvW216MF@vger.kernel.org, AJvYcCXU4UFbqnSRHUGGi2YJ8ukYQKnQs/8IRSQ0RxH9MQ+mymFyiHpjgI1xsITOagLgEOyj9wu0htNNrCe+2d4J@vger.kernel.org, AJvYcCXoGgrQN7EvNU+oACNEs6tf5DK6wT/iSvFhN6BxfpIHtwyc6KBQW2gEaxh1YwwV8u21BM/EO8glt6o7@vger.kernel.org
X-Gm-Message-State: AOJu0YyXPeXurmFHlwQGGqk+46PB3FCGBCRVTHTNzXsXYTtra0GUBVo5
	nlpolrxT744n69eVcuLyalhOLmbfKHzIeYZgv513dzuz7yMiUeHk1iNmuaBg+7YO0RjhNeDmFFG
	XKZXbR1devbih3TpYda7dhcuQjo0=
X-Gm-Gg: ASbGncsswi+xwOix0cGA5ff2L81OJfVVriXHgshi1oQqiARGcXWvI1S69WwC4UH0A1C
	VHUQNwff9jVmwvIGSMyDCwWdPN8VG1C2q6LrTPDFNqP4kep1JWdmuFWkJPJsPW6P4ZYBfE5770i
	mEl5frJP+mVNeEpmTx71wSB3i+IzhxvZDYHPE=
X-Google-Smtp-Source: AGHT+IE7oF7zYUiFClD9j+MaUG+QMzWikeMa5fdbd6jkjTVPOvWSr5tLM3OX7RIKBrrUgH1CqT/Ky1y9rQ5HCbtZCIc=
X-Received: by 2002:a0c:c688:0:b0:6ed:18cd:956d with SMTP id
 6a1803df08f44-6f0d25479aamr4072856d6.22.1744046510291; Mon, 07 Apr 2025
 10:21:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403181907.1947517-1-sean.anderson@linux.dev>
 <20250407182738.498d96b0@kmaincent-XPS-13-7390> <720b6db8-49c5-47e7-98da-f044fc38fc1a@linux.dev>
 <CA+_ehUyAo7fMTe_P0ws_9zrcbLEWVwBXDKbezcKVkvDUUNg0rg@mail.gmail.com> <1aec6dab-ed03-4ca3-8cd1-9cfbb807be10@linux.dev>
In-Reply-To: <1aec6dab-ed03-4ca3-8cd1-9cfbb807be10@linux.dev>
From: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Date: Mon, 7 Apr 2025 19:21:38 +0200
X-Gm-Features: ATxdqUFVoaO2wEB2GhdEUNwWwPj2cMvxUNhs7goYdYdDae4Y74aVkceCOkA0pWY
Message-ID: <CA+_ehUzeMBFrDEb7Abn3UO3S7VVjMiKc+2o=p5RGjPDkfLPVtQ@mail.gmail.com>
Subject: Re: [RFC net-next PATCH 00/13] Add PCS core support
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Kory Maincent <kory.maincent@bootlin.com>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, upstream@airoha.com, 
	Heiner Kallweit <hkallweit1@gmail.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Clark Wang <xiaoning.wang@nxp.com>, 
	Claudiu Beznea <claudiu.beznea@microchip.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, 
	Conor Dooley <conor+dt@kernel.org>, Ioana Ciornei <ioana.ciornei@nxp.com>, 
	Jonathan Corbet <corbet@lwn.net>, Joyce Ooi <joyce.ooi@intel.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Li Yang <leoyang.li@nxp.com>, 
	Madalin Bucur <madalin.bucur@nxp.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Michal Simek <michal.simek@amd.com>, Naveen N Rao <naveen@kernel.org>, 
	Nicholas Piggin <npiggin@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Rob Herring <robh+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, Robert Hancock <robert.hancock@calian.com>, 
	Saravana Kannan <saravanak@google.com>, Shawn Guo <shawnguo@kernel.org>, UNGLinuxDriver@microchip.com, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"

Il giorno lun 7 apr 2025 alle ore 19:00 Sean Anderson
<sean.anderson@linux.dev> ha scritto:
>
> On 4/7/25 12:46, Christian Marangi (Ansuel) wrote:
> > Il giorno lun 7 apr 2025 alle ore 18:33 Sean Anderson
> > <sean.anderson@linux.dev> ha scritto:
> >>
> >> On 4/7/25 12:27, Kory Maincent wrote:
> >> > On Thu,  3 Apr 2025 14:18:54 -0400
> >> > Sean Anderson <sean.anderson@linux.dev> wrote:
> >> >
> >> >> This series adds support for creating PCSs as devices on a bus with a
> >> >> driver (patch 3). As initial users,
> >> >>
> >> >> - The Lynx PCS (and all of its users) is converted to this system (patch 5)
> >> >> - The Xilinx PCS is broken out from the AXI Ethernet driver (patches 6-8)
> >> >> - The Cadence MACB driver is converted to support external PCSs (namely
> >> >>   the Xilinx PCS) (patches 9-10).
> >> >>
> >> >> The last few patches add device links for pcs-handle to improve boot times,
> >> >> and add compatibles for all Lynx PCSs.
> >> >>
> >> >> Care has been taken to ensure backwards-compatibility. The main source
> >> >> of this is that many PCS devices lack compatibles and get detected as
> >> >> PHYs. To address this, pcs_get_by_fwnode_compat allows drivers to edit
> >> >> the devicetree to add appropriate compatibles.
> >> >
> >> > I don't dive into your patch series and I don't know if you have heard about it
> >> > but Christian Marangi is currently working on fwnode for PCS:
> >> > https://lore.kernel.org/netdev/20250406221423.9723-1-ansuelsmth@gmail.com
> >> >
> >> > Maybe you should sync with him!
> >>
> >> I saw that series and made some comments. He is CC'd on this one.
> >>
> >> I think this approach has two advantages:
> >>
> >> - It completely solves the problem of the PCS being unregistered while the netdev
> >>   (or whatever) is up
> >> - I have designed the interface to make it easy to convert existing
> >>   drivers that may not be able to use the "standard" probing process
> >>   (because they have to support other devicetree structures for
> >>   backwards-compatibility).
> >>
> >
> > I notice this and it's my fault for taking too long to post v2 of the PCS patch.
> > There was also this idea of entering the wrapper hell but I scrapped that early
> > as I really feel it's a workaround to the current problem present for
> > PCS handling.
>
> It's no workaround. The fundamental problem is that drivers can become
> unbound at any time, and we cannot make consumers drop their references.
> Every subsystem must deal with this reality, or suffer from
> user-after-free bugs. See [1-3] for discussion of this problem in
> relation to PCSs and PHYs, and [4] for more discussion of my approach.
>
> [1] https://lore.kernel.org/netdev/YV7Kp2k8VvN7J0fY@shell.armlinux.org.uk/
> [2] https://lore.kernel.org/netdev/20220816163701.1578850-1-sean.anderson@seco.com/
> [3] https://lore.kernel.org/netdev/9747f8ef-66b3-0870-cbc0-c1783896b30d@seco.com/
> [3] https://lpc.events/event/17/contributions/1627/
>
> > And the real problem IMHO is that currently PCS handling is fragile and with too
> > many assumptions. With Daniel we also discussed backwards-compatibility.
> > (mainly needed for mt7621 and mt7986 (for mediatek side those are the 2
> > that slipped in before it was correctly complained that things were
> > taking a bad path)
> >
> > We feel v2 permits correct support of old implementations.
> > The ""legacy"" implementation pose the assumption that PCS is never removed
> > (unless the MAC driver is removed)
> > That fits v2 where a MAC has to initially provide a list of PCS to
> > phylink instance.
>
> And what happens when the driver is unbound from the device and suddenly
> a PCS on that list is free'd memory but is in active use by a netdev?
>

driver bug for not correctly implementing the removal task.

The approach is remove as provider and call phylink removal phase
under rtnl lock.
We tested this with unbind, that is actually the main problem we are
trying to address
and works correctly.

> > With this implementation, a MAC can manually parse whatever PCS node structure
> > is in place and fill the PCS.
> >
> > As really the "late" removal/addition of a PCS can only be supported with fwnode
> > implementation as dedicated PCS driver will make use of that.
>
> I agree that a "cells" approach would require this, but
>
> - There are no in-tree examples of where this is necessary
> - I think this would be easy to add when necessary
>

There are no in-tree cause only now we are starting to support
complex configuration with multiple PCS placed outside the MAC.

I feel it's better to define a standard API for them now before
we permit even more MAC driver to implement custom property
and have to address tons of workaround for compatibility.

> > I honestly hope we can skip having to enter the wrapper hell.
>
> Unfortunately, this is required by the kernel driver model :l
>
> > Anyway I also see you made REALLY GOOD documentation.
>
> Thanks. One of my peeves is subsystems that have zero docs...
>
> > Would be ideal to
> > collaborate for that. Anyway it's up to net maintainers on what path to follow.
> >
> > Just my 2 cent on the PCS topic.
>
> --Sean

