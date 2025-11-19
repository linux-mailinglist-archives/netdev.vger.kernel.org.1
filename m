Return-Path: <netdev+bounces-240098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D00EC70762
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 18:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 801A84E164F
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00092309EE0;
	Wed, 19 Nov 2025 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MquLeasH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7E030BB94
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 17:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763572976; cv=none; b=qzFdA/OXTumwN3U8f6GZv+a3JF21KGk27JPueCVwzCmiFY+wCcjlbILOCYOvHcvUeoYypvw66pAH1FTK2ZysefXgFh40v8dLSqOm0E/cwo+orbAXJ4wyvQG+2JQ8uuWChAgHqqEb1KB0SUXZalQ4mGC08DgHtHGuXUfONYh0d9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763572976; c=relaxed/simple;
	bh=eAvzJRVbMPDTn0OtUG9hOnATFGUdXnwLfwj2bhv6IcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urkZBHQ1rDhHEkKTkiMSeRkzCp3aiARF4cNrRgGJYsJ57kjCn9xI1lpc2Ch4Am8oKk9IqUWBtd1khbbH88/69rHhQU/vGj2C34cU5nbjGGsbUlkmf9BQDbSFKLhSboAvRgJDOXfd8oF3a+vGVvhOh0O/+Uek/Iq4X46pzyKS9Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MquLeasH; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b32ff5d10so785715f8f.1
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 09:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763572972; x=1764177772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJ7qtnVmny/w5kIeicL3mCw6YDxb80ihFwODcXdwSxQ=;
        b=MquLeasHvZ5u8OJBXBwbKOr1jxWORypcb5xkPNR+pFX1nHkpyVDQ5OPKTPBmxL4YS5
         wl3Pv1I5DB+9V3a9dTobnEsBgi+dw7/DKRT2ruYWL5X48RRdlxPTmBywTVSLZcJug/e/
         dTtk73UxLoYvNrGMXGx2eJ4Y+Yzfjv19iQTsyT+hDL030X9yOgTRIqmr2jqZyeRqV2nu
         uWFzpD5RjgOymM/mkT2ql3TnAqwrR7N4Rs1WQVXIF+AAcaR4v//SXwuqGBmRntO5auHO
         SKQwZtSYR7B60+fXEp8oMjAinNvmFewkcEk6CeId8wxNte7k3Q99UpbwBsvbWbB1zkhv
         GjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763572972; x=1764177772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mJ7qtnVmny/w5kIeicL3mCw6YDxb80ihFwODcXdwSxQ=;
        b=rlj8chZQOcbeU7EmK37hHNL8kTuBdcCQ3aPk1HUKPhm7ZWSikR/f4fxUP7+KU27SLf
         ahT0QxuHUhGMuGpHRLX3hq6n33gZeHHrgtvq4l7yDIlCTSa+jYPNsUrY9jBXWXtcCowa
         q5yMVwR5gr8U8Q1IqhVpThy4v6Ovvay9YppwgE3Ua3ouK3PMUK/Xbf7TnNHpR3sDu8NL
         Wjt1xUQN7rR6NE45HqIm4FX/s1JdR7PPky1MbRQ1yO/288akBoHcqu8lqPBwJblieuKo
         MyItsz1ZHlwy4gQpB6YIwEyU5Ef75wt5dsYCXzLPpA3Is3SecYs4GchDnZbTgU9ErAJA
         zFOw==
X-Forwarded-Encrypted: i=1; AJvYcCV9Mb//T/69+X5vyPbRs3iet1spl2sdR6FnVzBAKqX9ti5CC4tOxXtFxuE46SAWIh+qY2KEdEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV8z/52DO5bK9rKW8LbfYXfB7/D4bi+zzlUBMu5iC/NFzdNl4h
	rbkqRWVFsMf30+zNkePhhbdvXTcPQiIduY05I/DfeYFJFhO5rQ9Tt5mvAdAUrN2BZiCMy2FxaeH
	zwjudjT+DyDOkSElYkI62Z9OwfL5qvpU=
X-Gm-Gg: ASbGncsJgcwyu3FWktpb7iAsk30h9r46yVhWqh3FkV+sGmFeNGI1Tyz5ATkAgJAhbfi
	2JvEgAtn0hd+c4DFalxlXjA04hWhWqbK4b+onhvFeEE8McRoMEpRd2E3wP5B6gnOTTOuVBgNpw5
	kibauxF7Z8Cfv0wcTk/1Glvhlej97fbwWuc0Err1LVloKfxUmIovuv9ToPlGic/Gr0w8lItVsdy
	jWgQ6D/UfksXLLp8gjxtGI+FJgUKVEJM2r67CU460s/NULWaafvBnv3c9V247HKiuIbtD0rC3jz
	VaPq9NvPmqXfNRP8ZkxZjI8d2f8NixWPEQidG1I=
X-Google-Smtp-Source: AGHT+IEzCSLIifpeQ6gEe1TWgl+EjWrhoirX6l/Eo7aQlp7Vi6wI4vDiKCri4fk0klkz8surs2ex43mb/zWCEinrgr8=
X-Received: by 2002:a05:6000:4024:b0:429:ccd0:d36c with SMTP id
 ffacd0b85a97d-42cb20d0f18mr3867540f8f.14.1763572972234; Wed, 19 Nov 2025
 09:22:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <eca707a6-7161-4efc-9831-69fbfa56eb93@lunn.ch> <52e1917a-2030-4019-bb9f-a836dc47bda9@trager.us>
 <401e9d39-2c28-480e-b1c4-d3601131c1fb@lunn.ch> <399ca61a-abf0-4b37-af32-018a9ef08312@trager.us>
 <2fcc7d12-b1cf-4a24-ac39-a3257e407ef7@lunn.ch> <4b7f0ce90f17bd0168cbf3192a18b48cdabfa14b.camel@gmail.com>
 <e38b51f0-b403-42b0-a8e5-8069755683f6@lunn.ch> <CAKgT0UcVs9SwiGjmXQcLVX7pSRwoQ2ZaWorXOc7Tm_FFi80pJA@mail.gmail.com>
 <174e07b4-68cc-4fbc-8350-a429f3f4e40f@lunn.ch> <83128442-9e77-482a-ba8f-08883c3f3269@trager.us>
 <0d462aaa-7f41-4649-a665-de8a30a5b514@lunn.ch>
In-Reply-To: <0d462aaa-7f41-4649-a665-de8a30a5b514@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 19 Nov 2025 09:22:15 -0800
X-Gm-Features: AWmQ_bnguGweEEVeKsgwuRLgF4bvgdOCnesRtRukrwPIFFJfT9o94TgYaZAWNpw
Message-ID: <CAKgT0UdH_t2FO7mXWyR3V2Lo0HzKUudUF8HciYjFrx7fNUJkyA@mail.gmail.com>
Subject: Re: Ethtool: advance phy debug support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Lee Trager <lee@trager.us>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Susheela Doddagoudar <susheelavin@gmail.com>, netdev@vger.kernel.org, mkubecek@suse.cz, 
	Hariprasad Kelam <hkelam@marvell.com>, Alexander Duyck <alexanderduyck@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 6:20=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Strictly speaking settings don't have to be mapped to ethernet
> > configurations, at least not in our IP. I could use a 3 lane setup
> > alternating between NRZ and PAM4 each with different TX coefficients de=
spite
> > this not making any sense. This is where the argument comes in that PRB=
S
> > testing and TX coefficients don't belong in ethtool. The argument for
> > putting everything in phy is to create a generic interface that works f=
or
> > all phys, not just ethernet. That would give us something like
>
> Please could you always make it clear which definition of phy you are
> using. generic phy, or phylib phy. Here you appear to be meaning
> generic phy. For TX coefficients, that mostly makes sense to me.
>
> There is maybe one exception i can think of, the Aquantia phylib
> phy. You have a setup of a SoC with a MAC, PCS, SERDES lane, and then
> a discrete aquantia BaseT PHY which has its own PCS and the all the
> usual analogue stuff to put the bitstream on twisted pairs. There are
> undocumented registers in phylib PHY to configuring the eye etc. There
> currently are no phylib phys with embedded generic phys. There is no
> reason it cannot be done, just nobody has done it so far. And there is
> no reason this is special to the aquantia PHY, other phylib phys using
> a SERDES towards the MAC could also have such registers.

I think part of the issue is the fact that a PMA/PMD and a PHY get
blurred due to the fact that a phylib driver will automatically bind
to said PMA/PMD. I partially blame the legacy setup versus the c45
device partitioning for the confusion. For the most part our generic
phy is a PMD. That is why I am attempting to portray it in the fbnic
driver as such using a c45 interface.

Especially as we start getting into the higher speeds such as 50R1 and
all those PAM4 based variants we are going to run into things like
link training which have to be handled somehow as normally that is the
responsibility of the PMD which is a sub-component within the PHY.

> > I don't think there is much value in that which is why I like creating =
an
> > ethernet specific version. It makes a cleaner user interface which requ=
ire
> > less technical details from the user. I like piggy backing off of ethto=
ol -s
> > since users are custom to NIC speed, not lanes and mode. That would giv=
e us
> > something like
> >
> > ethtool -s eth42 100000baseCR2  - Test fbnic in PAM4 with 2 lanes
>
> Yep, that i like.

I'm not a huge fan as it actually is hiding a bunch of the details
under the hood. Also it blocks several specific test types that may be
needed. It may work fine for a cable test for a specific link config,
but it is only touching the tip of the iceberg in terms of what may be
needed for PRBS testing.

A good metaphor for something like this would be taking a car for a
test drive versus balancing the tires. In the case of the PRBS test we
may want to take the individual lanes and test them one at a time and
at various frequencies to deal with potential cross talk and such. It
isn't until we have verified everything is good there that we would
then want to take the combination of lanes, add FEC and a PCS, and try
sending encoded traffic over it. That said, maybe I am arguing the
generic phy version of this testing versus the Ethernet phy version of
it.

> >
> > ethtool --set-phy-tunable eth42 tx-coefficent 0 1 8 55 0 - Sets the
> > tx-coefficent for PAM4, this way users doesn't have to know the mapping
> > between mode and speed
>
> And this i don't. --set-phy-tunable is for a phylib PHY. Its for a
> device which converts a bitstream to analogue signals on twisted
> pair. fbnic does not have such a device. What you do have is a generic
> phy, even if currently you don't model it in Linux with an actual
> generic phy. But that is 'just code'. And the generic phy API does
> have some networking specific APIs, so i don't see why you cannot add
> another API for enumerating and setting TX coefficients.

I don't disagree with you on this. It is one of the reasons why I
mentioned that the generic phy would end up being a superset of
anything the phylib phy could do. The phylib setups are focused on
things like interface type and link configuration. However those don't
really apply to things like a PRBS test which is mostly about just
generating and verifying a signal on individual lanes.

> The other problem with what you have above is you only reference the
> netdev, and not which of the multiple generic phys that netdev might
> have. Think of the SoC-PCS-generic_phy-lane-generic_phy-PCS-BaseT
> system above. Both the SoC and the phylib phy can have coefficient
> registers. You need to enumerate which you want to set.
>
> For a long time we had this same problem with phylib, a netdev can
> have multiple phylib phys, but the kAPI had no way to indicate which
> of those phys you wanted to configure. We mostly have that solved now,
> but we should learn from that experience, and not repeat the same
> problem.

True. In our case we have both PCS capability for PRBS and generic phy
capability for that. Being able to control those at either level would
be useful. In my mind I was thinking it might be best for us to go
after PCS first in the case of fbnic due to the fact that the PMD is
managed by the firmware.

> > ethtool --start-prbs eth42 prbs31 - Start the PRBS31 test
>
> and this has the same problem, which prbs associated to the netdev do
> you want to run prb31? There could be one in the SoC PCS, the BaseT
> PCS pointing back towards the Soc, and maybe in the BaseT PHY pointing
> towards the line?
>
> So you need something like
>
> ethtool --list-prbs eth42
>
> to list all the PRBSes associated to the netdev, maybe also listing
> its capabilities. And then something like:
>
> ethtool --start-prbs eth42 --prbs 1 --mode prbs31
>
> to make use of the 1st PRBS, rather than the 0th.
>
>         Andrew

Really this gets at the more fundamental problem. We still don't have
a good way to break out all the components within the link setup.
Things like lanes are still an abstract concept in the network setup
and aren't really represented at all in the phylink/phylib code. Part
of the reason for me breaking out the generic PHY as a PMD in fbnic
was because we needed a way to somehow include the training state for
it into the total link state.

I suspect to some extent we would need to look at something similar
for all the PRBS testing and such to provide a way for the PCS, FEC,
etc to all play with a generic phy in the setup and have it make sense
to it as a network device.

