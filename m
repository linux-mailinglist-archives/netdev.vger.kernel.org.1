Return-Path: <netdev+bounces-239645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E18C6ACF1
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 18:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 19FB73A3576
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 16:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19DA36A001;
	Tue, 18 Nov 2025 16:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mggf4iF+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB49C3559F7
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 16:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763485168; cv=none; b=tebSIf+BgV/s3PNwlvMQ7QJjEAQmtiyu3dYY+zhNflUkw5RwYFiMOUOk0J7Q69Mp05oFWhyvwk8HONR/eVvomcfZcBrl9sIJ5Z+j0fikE2d9cbqrVxw4vCbmIkJNbwvZoRN0TLuidef7p61N6vwT5CYqWhkTs64L7zogs8QmACE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763485168; c=relaxed/simple;
	bh=fPvMfbsUVW3soL7mLIoS0QbuUDldlguwz+RwU0RJsLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHI6/yVeRQWo0ntwhhGXtELSJQaawc/7HDOjN2eO+j9KTAxJGSu4MEtwPNKSk3B/qS1iJVyK8FmPnvCkelCCJKubQLi4QRcC1JeV1MZ/Pz7grZN72j6Fs65oGS5udX3qHVOKY4dhRO1q7rpUGQ8hp4NgXin8VYzayDSL7gPKCT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mggf4iF+; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b3108f41fso3553768f8f.3
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 08:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763485165; x=1764089965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPvMfbsUVW3soL7mLIoS0QbuUDldlguwz+RwU0RJsLk=;
        b=mggf4iF+BOK3KnV1y9hkWG1P8lSLQAlyaxGnduKBz3OJYspTgEwITf09VvBXf0tYF7
         9GQ5RiEyp4bgbvCmNHMDESJPgBU6coZlWXji59/ZB1E6NKk/0GzeiCKDe9FYb937H9K1
         IbG6EWwbQREryzzYVMbYjIMLJ4T5ZJS7/985MF7THeKTvap3XWw9Fpl0LItxuvd0a1bI
         c2xI1CksRAGOyB7g1eiH/J+dIWEKGHy3RaxxZm9i4BrfMRvmbt9UP+9huQJT66KWg9Q3
         1tY/nGEtFxujZ157p3SQFjx8TFn1DiV1XQ6iuixvy7tvy1DAsupiuEElB9hJSZfN6/1X
         /TVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763485165; x=1764089965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fPvMfbsUVW3soL7mLIoS0QbuUDldlguwz+RwU0RJsLk=;
        b=prv0GA1BjRaDtv4deYCAJqOYBsrbrOx0h8DPzaVOUZyTUYRoW6PPapfj50uKzz6TOT
         SK2km7Sgv8fOLCY9cZN1uDEUm7/maO3Q6YuskntkqidxGWZcgJLXOPCzCNo7u8NN4cNZ
         /HwxV/fDTX5AkD5xjqFTP/I83+EA8M+fbdYbs8WEjFNdi6iWfxLksbZAwe1zov8LER5S
         xfZ8rmhfTjT5xZGTOw6fgXDDZ9W6Zc6wfh3CkJjRizOECXcO/Q7W4ss5KV8oe1QG9+JU
         N+5HfSffFRbugZLCo03AIOJcCKxgBv4A4TzlFDWQTCXGuNKX2zIiBFzCYtG0pC1/TMGU
         dvZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzbXQXYyjlHf57gBPffLInKcLM6NOWtgnUlNHotHewGRf2j7s4O5On0/WmE6xWtOBByu/O5MA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzWS9TVbKPSz7nYYnUn/tL0s0ycTTMtNkaSuLWuLtxLlzmKfBE
	Yv4FhbCRUfs3IcrisHvoTZg3jLFpkB87g/e0b5GmYX/1lRwvLZDZgGEsexSU9XICySXjKXgOsAT
	V+vuBnR9cxMTr6aeht/kZl44lplxTAmw=
X-Gm-Gg: ASbGncs/P037LkJDdpSG3aw7mgOfK/KtrCgN3jRUbeLFD/Q7vKXK4fZ3HPJ2tNo6Uwh
	Ny8YdXHbPdeffkaoTXtr5GQg4iD9pg/0O3rDfM8tFydXpWVrEgeIxVxo5tVEu7C3ZLgFven+Hfg
	3jXIqW5Ucz+HQIzjCtZMqxVZgYzEfj5ffdQD+SKyfxzyvDDhBwLuUFEuEjN7MCYekPYhqCqFF4o
	85nSC59ZT+hmJ64aBYpOiRkHQORJGd+pDsi6wu1KA1KtLje8fzWAZugErn8c4JLLpeKBcTEvhPS
	pKA=
X-Google-Smtp-Source: AGHT+IFPVVzQnCKIVXDN53k7IJQP37d2yWCvRHg7UMWmmtgwfiAGAz66ILD4xJz+zokoERAfxxqG/uLGYeD56UZoCis=
X-Received: by 2002:a05:6000:2893:b0:42b:5592:ebe6 with SMTP id
 ffacd0b85a97d-42b592d34e3mr16113151f8f.0.1763485164818; Tue, 18 Nov 2025
 08:59:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOdo=cNAy4kTrJ7KxEf2CQ_kiuR5sMD6jG3mJSFeSwqD6RdUtw@mail.gmail.com>
 <843c25c6-dd49-4710-b449-b03303c7cf45@bootlin.com> <eca707a6-7161-4efc-9831-69fbfa56eb93@lunn.ch>
 <52e1917a-2030-4019-bb9f-a836dc47bda9@trager.us> <401e9d39-2c28-480e-b1c4-d3601131c1fb@lunn.ch>
 <399ca61a-abf0-4b37-af32-018a9ef08312@trager.us> <2fcc7d12-b1cf-4a24-ac39-a3257e407ef7@lunn.ch>
 <4b7f0ce90f17bd0168cbf3192a18b48cdabfa14b.camel@gmail.com> <e38b51f0-b403-42b0-a8e5-8069755683f6@lunn.ch>
In-Reply-To: <e38b51f0-b403-42b0-a8e5-8069755683f6@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 18 Nov 2025 08:58:47 -0800
X-Gm-Features: AWmQ_bmI7A-WCOU_u8UyXVjfphKKab5wIaaUlsvYIt5iZ2u1YXV6Pc-z9KAbyBY
Message-ID: <CAKgT0UcVs9SwiGjmXQcLVX7pSRwoQ2ZaWorXOc7Tm_FFi80pJA@mail.gmail.com>
Subject: Re: Ethtool: advance phy debug support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Lee Trager <lee@trager.us>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Susheela Doddagoudar <susheelavin@gmail.com>, netdev@vger.kernel.org, mkubecek@suse.cz, 
	Hariprasad Kelam <hkelam@marvell.com>, Alexander Duyck <alexanderduyck@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 5:50=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > As i said before, what is important is we have an architecture that
> > > allows for PRBS in different locations. You don't need to implement
> > > all those locations, just the plumbing you need for your use case. So
> > > MAC calling phylink, calling into the PCS driver. We might also need
> > > some enumeration of where the PRBSes are, and being able to select
> > > which one you want to use, e.g. you could have a PCS with PRBS, doing
> > > SGMII connecting to a Marvell PHY which also has PRBS.
> >
> > It seems to me like we would likely end up with two different setups.
> > For the SerDes PHYs they would likely end up with support for many more
> > test patterns than a standard Ethernet PHY would.
> >
> > I know I had been looking at section 45.2.1.168 - 45.2.1.174 of the
> > IEEE 802.3 spec as that would be the standard for a PMA/PMD interface,
> > or section 45.2.3.17 - 45.2.3.20 for the PCS interface, as to how to do
> > this sort of testing on Ethernet using a c45 PHY. I wonder if we
> > couldn't use those registers as a general guide for putting together
> > the interface to enable the PHY testing with the general idea being
> > that the APIs should translate to similar functionality as what is
> > exposed in the IEEE spec.
>
> It probably needs somebody to look at the different PRBS and see what
> is common and what is different. 802.3 is a good starting point.
> If you look around you can find some Marvell documents:
>
> https://www.mouser.com/pdfDocs/marvell-phys-transceivers-alaska-c-88x5113=
-datasheet-2018-07.pdf
> https://www.marvell.com/content/dam/marvell/en/public-collateral/phys-tra=
nsceivers/marvell-phys-transceivers-alaska-m-88e21x0-datasheet.pdf
> https://www.marvell.com/content/dam/marvell/en/public-collateral/phys-tra=
nsceivers/marvell-phys-transceivers-alaska-x-88x2222-datasheet.pdf
>
> And there are other vendors:
>
> https://www.ti.com/lit/ds/symlink/dp83tc811r-q1.pdf
>
> But we should also make use of the flexibility of netlink. We can
> probably get a core set of attributes, but maybe also allow each PRBS
> to make use of additional attributes?

The point I was trying to make is that Ethernet only uses a subset of
the available tests that most of these devices provide. There are only
a few tests recommended for the various media types. Most of the test
types are called out in the various sections and 45.2.1.170 lists many
of them off.

> > It isn't so much hard wired as limited based on the cable connected to
> > it. In addition the other end doesn't do any sort of autoneg.
>
> For PRBS, i doubt you want negotiation. Do you actually have a link
> partner? Or it is some test equipment? If you are tuning SERDES
> windows/eyes, you have to assume you are going to make the link worse,
> before it gets better, and so autoneg will fail. So i expect the
> general case of anybody using PRBS is going to want to use 'ethtool -s
> autoneg off' to force the system into a specific mode.

Right. With PRBS you already should know what the link partner is
configured for. It is usually a manual process on both sides. That is
why I mentioned the cable/module EEPROM. The cable will indicate the
number of lanes present and the recommended/maximum frequency and
modulation it is supposed to be used at. With that you can essentially
determine what the correct setup would be to test it as this is mostly
just a long duration cable test. The only imitation is if there is
something in between such as a PMA/PMD that is configured for 2 lanes
instead of 4.

> > As far as the testing itself, we aren't going to be linking anyway. So
> > the configured speed/duplex won't matter.
>
> I'm surprised about that. Again, general case, would a 1G 1000baseX
> allow/require different tuning to a 2500BaseX link? It is clocked at a
> different frequency? Duplex however is probably not an issue, does an
> SGMII SERDES running at 100Half even look different to a 100Full? The
> SERDES always runs at the same speed, 10/100 just require symbol
> duplication to full the stream up to 1G. And link modes > 1G don't
> have a duplex setting.

I think we have a different understanding of what "link" means. For
most modern setups we aren't sending the data over an individual lane.
In many cases the MAC has several virtual lanes it is using. It is
being multiplexed via MLD or RS-FEC encoding and passed that way. So
you cannot get "link" without passing the signal through those.

When we are doing a PRBS test we aren't using those and are just
sending the raw pattern across trying to check for noise on the wire.
The Tx side is essentially shouting into the abyss and hopefully the
other end is configured to verify the signal. Likewise the Rx side
gets configured, but it doesn't guarantee that there is a transmitter
on the other end to send to it. It is very much a manual setup
process. The PRBS testing is per individual lane and is in no-way
aggregating them together or splitting them up into virtual lanes. As
such in my point of view it isn't providing/getting a "link". To
properly set it all up you have to essentially kick off the Tx on both
sides, and then you can start collecting samples by enabling the Rx
which then has to get a signal lock on that lane, and then collect the
data. So the process, while similar to getting a "link", is very much
different from getting the link at the various BASE-R speed
capabilities that are verified by the test.

> > When we are testing either
> > the PCS or the PMA/PMD is essentially running the show and everything
> > above it is pretty much cut off. So the MAC isn't going to see a link
> > anyway. In the grand scheme of things it is basically just a matter of
> > setting up the lanes and frequency/modulation for those lanes.
>
> And the kernel API for that, at the top level is ksettings_set(). I
> agree the MAC is not sending packets etc, but it is the one
> configuring everything below it, via phylink/phylib or firmware. Is
> there really any difference between a real configuration and a PRBS
> configuration for testing a link mode?

The problem is the test config may not make sense to the MAC. As I
mentioned, PRBS testing is done per lane, not for the entire link. As
such we would be asking an individual lane or set of lanes to get
configured for a specific frequency/modulation and then to run a
specific pattern. Arguably we would probably want to keep the MAC out
of the PRBS testing setup for that reason.

> And then we need a second API to access whatever you want to tune,
> which i guess is vendor specific. As far as i remember, Lee's basic
> design did separate this into a different API after looking around at
> what different vendors provided.

Yes. Again most of these settings appear to be per-lane in both the IP
we have and the IEEE specification. For example it occurs to me that a
device could be running a 25G or 50G link over a single QSFP cable,
and still have testing enabled for the unused 2 or 3 lanes on the
cable potentially assuming the PMA/PMD is a 4 lane link and is only
using one or two lanes for the link.

> > This is one of the reasons why I was thinking of something like a
> > phydev being provided by the driver. Specifically it provides an
> > interface that can be inspected by a netdev via standard calls to
> > determine things like if the link is allowed to come up. In the case of
> > the phydev code it already had all the bits in place for PHY_CABLETEST
> > as a state.
>
> And this is why i talked about infrastructure, or core for PRBS,
> something which can deal with a netdev state transitions. A don't see
> a phydev as a good representation of a PRBS. We probably want a PRBS
> 'device' which can be embedded in a phydev, or a PCS, or a generic
> PHY, which registers itself to the PRBS core, and it is associated to
> a netdev.

One thing we may want to consider instead of having a PRBS device
might be to look at having something like a "lane" device. As it
currently stands, I think we are going to start running into issues as
we start fanning out the setups and adding more lanes or running
devices in parallel. The 50G-R2 setup was already a challenge and odds
are 800G(https://ethernettechnologyconsortium.org/wp-content/uploads/2021/1=
0/Ethernet-Technology-Consortium_800G-Specification_r1.1.pdf)
is going to be a similar mess if not worse as it starts making much
more use of the lane muxing and multiple PCS devices.

