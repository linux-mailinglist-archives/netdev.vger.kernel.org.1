Return-Path: <netdev+bounces-240116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4F4C70BE6
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C0274E069D
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473BE327BF5;
	Wed, 19 Nov 2025 19:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZM+cDxr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C47531ED75
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763579565; cv=none; b=TcA2QyOkv0QKyfE44iSwRER9zeriay1+M+UpKfpdCAX88c+8gUZdeyFbcZSv8G9/22Ewf3wPb2orJ+VKBWeWyXhlz9LbZaxBGoU+7/XUrpeLrh3V5jvRWLpxBLz0TjUDyYYBpsAp/fxLCOFp01ZYHi7tFuTp7ULop9kIzpxxXOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763579565; c=relaxed/simple;
	bh=bMS65+fovoKmDK9GhEGWg1KgY7vZ7lP6VIcJ20KrMrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gF17kNBBaFJleZic/Kp8/FAiVZK/XXqwYAUOuzpT2rzeTqorofSwEm3N165HMdTsQYij2RRWF+X7f2h+tmf9ux8tltHhQxMfmMleZKayLmCcpdSDF6xGeUyACMZCvBoRGhOjZVb6MhZ/d384j41pDf67e9Lx/X/j9lJ+1m/fQ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZM+cDxr; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b566859ecso66943f8f.2
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 11:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763579555; x=1764184355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMS65+fovoKmDK9GhEGWg1KgY7vZ7lP6VIcJ20KrMrA=;
        b=VZM+cDxrOu4xY853KHZCTWsGdbiLVuAqXT1XABwrtYqoHFPzl+H0ZW5WXQm/afwYOH
         799cV3RQPa1zM2i7P5Fd0f9XVywBrJoIFXV7J3OeykORGJOeAcUXWeOYT1wjMsz/CbNu
         p3R1GYlYem/agaHtmH9igUdWM0mtcR8o7f5YFpB67+QY5Lf45q1J8wBA+iO0M8saqhWn
         E3JcUn29cG1a5YdsmVyc6PvhiHzGLWJs/BTBYIpa7b9hcIl3IISJTHxGTqvFeBCDn1Yi
         ZB8+fo0OrmIJ9u2eDB/IV8CkRQAvne2QusFxSeJWakbZ6yIZdu+Lv6Y7dcx/NRBgVIzH
         +iQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763579555; x=1764184355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bMS65+fovoKmDK9GhEGWg1KgY7vZ7lP6VIcJ20KrMrA=;
        b=xI9wsPptogzGRH2vih3t9ajwDwiuyN1iOaBaBRDDog7jjggH6wQmf9eF8xi1mr6208
         Ju1EeMxiiQOuqRNTh/0Rudl/6W3jCMo6ay8kURzEC3wrVkv3PiuXcWihk5GzSivD7yr3
         MdFub7wuuaCdvznkK/ZKHfqWkDCQSFFoQiZbSergBcYEJNcQZi51Gjymy1bensQdff8w
         c1AJmcEsmnOITv7pJ0/oV+VBj8v0NfLaz5RpEIt/l+J8vM4kTVqTNgGDZb+UHyIuG7n6
         HhkrCi3wdLKXUER9frcpwIA3GBnsMU6eNMY5qHQh8xrgbj7C11mEMYr9+jR8LqGj1O2q
         m2lg==
X-Forwarded-Encrypted: i=1; AJvYcCU/DqduFIbm7H86JkDCDRp8oJh0Vvx0v+SUGACiBrDDrT9e9g+vh6eFG8vO9ld/rAsB6cGp8gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGaT6YOtS2Wj/LtB9qS05PlbZRamfiLiN7/tX/bGK43p5oB/xZ
	fCKVInUfI6NJFHTrcKY7EPa2aLuN+Fbj8yHKcPeO6F1ME04JBrXR/dg7NuiRNP1dHlj2trJACon
	4n1T0O1tuabKLE0wwWiqTuSHWt3BTOaE=
X-Gm-Gg: ASbGncvlPH8YaFhcrHLiU5a6VdDUY1C+Jo+kBph6H3qvlSS1ZJtTXD2gocYZbfKdTjQ
	plg2iWCNebqZQlqvtJOxwvxGtrfs+Rd7onpD9VOGGQjK0wPE3XVwNa7NVH4qzweIaS6hrGaDuu/
	V+RJc3D+qGG2mSFksDN1+b/7hkaiRlZm2PaZrgvduqzTvZcezKQ1eZTTW+c9l4YdRzOYLqVs6G6
	fNTvDwBj2TyYHbSTTf+7r52pi2BvwyND6GQyzYmN/bl7CSXOec1jr5PtdWI6cvblSWLVSpqY39H
	9C6OYF39UbpgbnK9x/Th7RpRxQcd
X-Google-Smtp-Source: AGHT+IFvLZxDmK/RPgeqKbFEKUnAVM2bSAWV56aP7totDO2mGx9MBQWklIEXgijZXPcF1E9WGFLIDuLzQeDXa+obLT4=
X-Received: by 2002:a05:6000:615:b0:42b:39ee:286f with SMTP id
 ffacd0b85a97d-42b593954c7mr20556654f8f.48.1763579555172; Wed, 19 Nov 2025
 11:12:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <401e9d39-2c28-480e-b1c4-d3601131c1fb@lunn.ch> <399ca61a-abf0-4b37-af32-018a9ef08312@trager.us>
 <2fcc7d12-b1cf-4a24-ac39-a3257e407ef7@lunn.ch> <4b7f0ce90f17bd0168cbf3192a18b48cdabfa14b.camel@gmail.com>
 <e38b51f0-b403-42b0-a8e5-8069755683f6@lunn.ch> <CAKgT0UcVs9SwiGjmXQcLVX7pSRwoQ2ZaWorXOc7Tm_FFi80pJA@mail.gmail.com>
 <174e07b4-68cc-4fbc-8350-a429f3f4e40f@lunn.ch> <83128442-9e77-482a-ba8f-08883c3f3269@trager.us>
 <0d462aaa-7f41-4649-a665-de8a30a5b514@lunn.ch> <CAKgT0UdH_t2FO7mXWyR3V2Lo0HzKUudUF8HciYjFrx7fNUJkyA@mail.gmail.com>
 <76b04a20-2e63-4ebf-841c-303371883094@lunn.ch>
In-Reply-To: <76b04a20-2e63-4ebf-841c-303371883094@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 19 Nov 2025 11:11:58 -0800
X-Gm-Features: AWmQ_bknQLfen3nh-GfT-xLAz-6cDbcSHo3gxTFyDbuSG68wszfISi4jwtEPtTM
Message-ID: <CAKgT0UfUhgo+8BmKdTQCYJvJZ44Cqr89zYXenWkc4k3W5P9uDQ@mail.gmail.com>
Subject: Re: Ethtool: advance phy debug support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Lee Trager <lee@trager.us>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Susheela Doddagoudar <susheelavin@gmail.com>, netdev@vger.kernel.org, mkubecek@suse.cz, 
	Hariprasad Kelam <hkelam@marvell.com>, Alexander Duyck <alexanderduyck@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 10:30=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> > I think part of the issue is the fact that a PMA/PMD and a PHY get
> > blurred due to the fact that a phylib driver will automatically bind
> > to said PMA/PMD.
>
> You have some control over that. When you create the MDIO bus, you can
> set mii_bus->phy_mask to make it ignore addresses on the bus. Or,
> since you don't have a real MDIO bus, set the ID registers to 0xffff
> and it will decided there is no device there.
>
> If you were using device tree, you could also bind an mdio_device
> device to it, rather than a phy_device. This is how we handle Ethernet
> switches on MDIO busses.

Okay. I will take a look. Since what we need is mostly to enable the
XPCS driver I can look at masking most of the interfaces if it doesn't
block access to that driver.

> > A good metaphor for something like this would be taking a car for a
> > test drive versus balancing the tires. In the case of the PRBS test we
> > may want to take the individual lanes and test them one at a time and
> > at various frequencies to deal with potential cross talk and such. It
> > isn't until we have verified everything is good there that we would
> > then want to take the combination of lanes, add FEC and a PCS, and try
> > sending encoded traffic over it. That said, maybe I am arguing the
> > generic phy version of this testing versus the Ethernet phy version of
> > it.
>
> I think you need to decide what your real use cases are.

The problem is we end up using the PRBS for a number of things in
terms of testing. Odds are we will want more the generic phy approach
versus trying to tie things to link and such. Most of our use cases
for PRBS generally don't include linking itself as most of it involves
signal testing more than anything else. As I mentioned earlier I think
most of it comes down to general SerDes PHY versus an Ethernet PHY.
The Ethernet case is much more specific in terms of how things go
together.

> > True. In our case we have both PCS capability for PRBS and generic phy
> > capability for that. Being able to control those at either level would
> > be useful. In my mind I was thinking it might be best for us to go
> > after PCS first in the case of fbnic due to the fact that the PMD is
> > managed by the firmware.
>
> And hopefully the PCS code is a lot more reusable since it should work
> for any PCS conforming to 802.3, once you have straightened out the
> odd register mapping your hardware has.

Yeah, in theory anyway. I will have to look into it more as the IEEE
seems to call out that the control is for a single lane test only.
Also I just realized that our hardware doesn't have the PRBS option
bits called out in the IEEE so it looks like it is limited in terms of
the patterns it could generate.

> > Really this gets at the more fundamental problem. We still don't have
> > a good way to break out all the components within the link setup.
> > Things like lanes are still an abstract concept in the network setup
> > and aren't really represented at all in the phylink/phylib code. Part
> > of the reason for me breaking out the generic PHY as a PMD in fbnic
> > was because we needed a way to somehow include the training state for
> > it into the total link state.
> >
> > I suspect to some extent we would need to look at something similar
> > for all the PRBS testing and such to provide a way for the PCS, FEC,
> > etc to all play with a generic phy in the setup and have it make sense
> > to it as a network device.
>
> I think we probably do need to represent the lanes somehow. But there
> are lots of open questions. Do we have one phylink_pcs per lane? Or
> one phylink_pcs which can handle multiple lanes, all being configured
> the same? What needs to be considered here is probably splitting, when
> you create two netdev instances each with two lanes, or 4 netdev
> instances each with one lane? That is probably easier when there is a
> phylink_pcs per lane, or at least, some structure which represents a
> lane within a PCS.

For now I am expressing each lane as a separate phy addr in fbnic.
Basically 0 is lane 0, and 1 is lane 1. What makes this more
complicated is that for the IEEE modes I believe everything can be
done with just the one PCS. When we start getting to the Ethernet
Consortium 50R2 mode then we have to access the PCS as two halves to
configure the PCS vendor bits, and the RSFEC. This will likely become
more obvious once I get past the PMD training link flap issues and can
start onto my next patch set.

If nothing else I think this discussion has actually given me a few
ideas to improve my other patch set. Specifically I am going to move
the SW PMD away from including any PMA bits in it. It would be truer
to the actual hardware since the generic phy is really just a PMD and
doesn't report link status or anything like that. It at most just
tells us if there is a signal or not, and if it has completed
training.

