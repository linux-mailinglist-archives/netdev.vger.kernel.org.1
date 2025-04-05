Return-Path: <netdev+bounces-179443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C85CA7CBD3
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 22:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F802176DB3
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 20:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE8014B96E;
	Sat,  5 Apr 2025 20:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ukj66vBN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F86D625
	for <netdev@vger.kernel.org>; Sat,  5 Apr 2025 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743885730; cv=none; b=L0nWVxZJxtz8NqhTKtGIVxMOHUx7qKfixioW80F/df4DAqvwdu4YGQi9OEY8LKUySpypPkf8qx0w0NGrqzfUDxCs/bgcs/VUeq3YASYm+mDYIadWxM4kz3fhewMEDR4NS/F+4mjT0x6a+shoMSpBf+XW68p5II1Z54lo8ulR05A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743885730; c=relaxed/simple;
	bh=slJE5un7dwk3e9295wI0H8d+Qp12gjVQZ5YtkguOOJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wt7ROG5PGU++93hMWnxgEP9yk5yHfOxX+3UIuYV3vc3S+UfZ9J5XYLEzJtoRtRul30hju+lZCqqnZs/Rv2fNH9Z52R3Jg7+Bn0hvtLFup8CxaSvDdhqjqiXQy9/6ANkehETHIvkyHB5nCLVlEgSa6qK9WFmKzttrOXOB/NA40Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ukj66vBN; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfe574976so21167875e9.1
        for <netdev@vger.kernel.org>; Sat, 05 Apr 2025 13:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743885727; x=1744490527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slJE5un7dwk3e9295wI0H8d+Qp12gjVQZ5YtkguOOJw=;
        b=Ukj66vBNZjmE6a2DtXiDJFFWk6cIyP1iEwHyvGToVEfUemUIOguDw3aO7MolbFTxOA
         90YLh0hti0kAl5HUbxaWuOoG5yPDwJtPOO93w92/2AhD/3W1LRoiKHw3VAs2wlpVu1AK
         Q8kzVm8sjG9ayedOBlmUTZ8Crswh5Vi2t4MkRwa5H55nkdDeF9ScRzRe7Xn4VWpCKiUW
         c97F4igd5qM6Kheh5KY8vaz91zgMrpHqmEKZV9hJy+QBlaVYkKrhfFjQN+crrRFBA+4z
         AC0tYJQtAgJdfYQQGffn/6S6rI5OXdtHHh3oiAGSYIbOhS2W5ETw3xIkCPRWK9cKNa16
         xIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743885727; x=1744490527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slJE5un7dwk3e9295wI0H8d+Qp12gjVQZ5YtkguOOJw=;
        b=ZCAxaqgxSnf80rDDRUdu5sDfP/FPKE/BrXX45lJREXlokoVinn28dvo59A1bcZSSNe
         tj/0LtdfV7iCmjKubc5cmCdoZnBYE8fmDtmBdUYfSbyjee7IKPXXNCFAtalIH5dY1FPd
         ulF2TCvL8urORC6ud2fTF6k0SH2mGxJQ1tHlMyLOw0TtAnPmShE98+jjE8NT9rEpsAdC
         tchtt78tRaIAt0IAPCUQ19q5RGFcN5q9xnO65UchAqmAMtuTW7nKSaxeGWNvhkIyLAQj
         AcmpYsNkn8r71hzIZeXiGwyECxJS4CncWVFXHp7DuGcxZOD320qU0I4IDWJZ6tlT/Sjy
         V9hA==
X-Forwarded-Encrypted: i=1; AJvYcCVH3TS+xZ9ml5T8dUrVBlH5ljIAzV2rwjq0ZFWyQ/86bn1DLEiuEH3/0MOgIFrz1wduVeNsJGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIWKqrclCa0dptx1Z6TvNtruwizswMKdDfE4HBcNQkHeT7yL2w
	fBrNzdZybBf1A4HRHBJP7EuTH5iQn4URtwS0k1m48cwF3M35FhJwCyJKL3S08Ld/VPuy00jvwVT
	J4W+sHlJuIY4RyQUpRcUlsUOfvgg=
X-Gm-Gg: ASbGncsHz2rzk8G0u4iDm4xozMNHmOhhd8ADEvufzp7CEePF/2TyEmyYy9Zz9RZ/L9Q
	SQ0Ns1slcxdlFGKnczkAug/n4h3pYmnX84DEpmAOHILbOTM0cYD3oMeqlhEODN3oQ4VX7hyzbbg
	IL+cUlBby8t/+KcSus2lgUBssuSpJkuvaXNh6gJ8xpJLTJImunFNYGGmC7KxY=
X-Google-Smtp-Source: AGHT+IH710bT9g/U2TdkZFtQNDRT5KP2YrflOaPhUCg5oxWMg3kwd5YqxglVKFy0GpVLNb1WdtMm81QmOQFojf+2fNI=
X-Received: by 2002:a5d:5846:0:b0:391:48d4:bcf2 with SMTP id
 ffacd0b85a97d-39cb35b260amr6654782f8f.12.1743885726505; Sat, 05 Apr 2025
 13:42:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174354264451.26800.7305550288043017625.stgit@ahduyck-xeon-server.home.arpa>
 <174354300640.26800.16674542763242575337.stgit@ahduyck-xeon-server.home.arpa>
 <Z-6hcQGI8tgshtMP@shell.armlinux.org.uk> <20250403172953.5da50762@fedora.home>
 <de19e9f1-4ae3-4193-981c-e366c243352d@lunn.ch> <CAKgT0UdhTT=g+ODpzR5uoTEOkC8u+cfCp7H-8718Zphd=24buw@mail.gmail.com>
 <Z-8XZiNHDoEawqww@shell.armlinux.org.uk> <CAKgT0UepS3X-+yiXcMhAC-F87Zcd74W2-2RDzLEBZpL3ceGNUw@mail.gmail.com>
 <3087356b-305f-402a-9666-4776bb6206a1@lunn.ch> <CAKgT0UfG6Du3RepV4v0hyta4f5jcUt3P1Bh7E2Jo2Cn4kWJtGw@mail.gmail.com>
 <eb115770-a8b1-4806-b8b9-ec98f44a98ee@lunn.ch>
In-Reply-To: <eb115770-a8b1-4806-b8b9-ec98f44a98ee@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sat, 5 Apr 2025 13:41:29 -0700
X-Gm-Features: ATxdqUEWxTmYDmaaESLxm-NWfCMlUbn09IUXngE_Yd2VZbNCBdsaYELGYV1XeTM
Message-ID: <CAKgT0Uf1R0BadAZe0ANMpS00AZB228e2-Am9LaZxzeSTCWS4aQ@mail.gmail.com>
Subject: Re: [net PATCH 1/2] net: phy: Cleanup handling of recent changes to phy_lookup_setting
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, 
	hkallweit1@gmail.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 5, 2025 at 7:51=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > So for us, we have:
> > >
> > > MAC - PHY
> > > MAC - PCS - PHY
> > > MAC - PCS - SFP cage
> > > MAC - PCS - PHY - SFP cage
> >
> > Is this last one correct? I would have thought it would be MAC - PCS -
> > SFP cage - PHY. At least that is how I remember it being with some of
> > the igb setups I worked on back in the day.
>
> This PHY is acting as an MII converter. What comes out of the PCS
> cannot be directly connected to the SFP cage, it needs a
> translation. The Marvell 10G PHY can do this, you see this with some
> of the Marvell reference designs.
>
> There could also be a PHY inside the SFP cage, if the media is
> Base-T. Linux is not great at describing that situation, multiple PHYs
> for one link, but it is getting better at that, thanks to the work
> Bootlin is doing.
>
> >
> > > This is why i keep saying you are pushing the envelope. SoC currently
> > > top out at 10GbaseX. There might be 4 lanes to implement that 10G, or
> > > 1 lane, but we don't care, they all get connected to a PHY, and BaseT
> > > comes out the other side.
> >
> > I know we are pushing the envelope. That was one of the complaints we
> > had when you insisted that we switch this over to phylink. If anything
> > 50G sounds like it will give the 2500BaseX a run for its money in
> > terms of being even more confusing and complicated.
>
> Well, 2500BaseX itself it straight forward. It is the vendors that
> make it complex by having broken implementations.
>
> Does your 50G mode follow the standard?

From what I can tell the 50GbaseR portion of it follows the standard.
The LAUI stuff is another story. It looks like it mostly compiles but
I am having to blur some definitions as the IEEE version had no FEC
and with ours we have the options for RS528 or BASER which more
closely matches up with 25GbaseR

> SoC vendors tend to follow the standard, which is why there is so much
> code sharing possible. They often just purchase IP to implement the
> boring parts like the PCS, there is no magic sauce there, all the
> vendor differentiation is in the MAC, if they try to differentiate at
> all in networking.
>
> The current market is SoCs have 10G. Microchip does have a 25G link in
> its switches, which uses phylink. We might see more 25G, or we might
> see a jump to 40G.
>
> I know your register layout does not follow the standard, but i hope
> the registers themselves do. So i guess what will happen is when
> somebody else has a 40G PCS, maybe even the same licensed IP, they
> will write a translation layer on top of yours to make your registers
> standards compliment, and then reuse your driver. This assumes you are
> following the standard, plus/minus some integration quirks.
>
> If you have thrown the standard out the window, and nothing is going
> to be reusable then maybe you should hide it away in the MAC
> driver.

So the ugly bit for us is that there are no MII interfaces to the PCS
or PMA. It is all MMIO accesses a register map and a number of signals
were just routed to registers in another section of the part for us to
read to or write from.

> > If anything we most closely resemble the setup with just the SFP cage
> > and no PHY. So I suspect we will probably need that whole set in place
> > in order for things to function as expected.
>
> That is how we have seen new link modes added. Going from 2.5G to 5G
> to 10G is not that big, so the patchsets are reasonably small. But the
> jump from 10G to 40G is probably bigger.
>
> If you internally use fixed-link as a development crutch, that is not
> a problem. If however you want it in mainline, then we need to look at
> the big picture, does it fit with what fixed-link is meant to be?

It just impacts the order in which I do things. By going with a fixed
link I could add the phylink functionality to the driver as I went. I
can go the other way around, it just means I can't test the
functionality as I add it. Instead it will be adding all the code and
then suddenly it all just works. At this point I have it mostly
working with the few items I have already pointed out so I can
probably just re-order things to push the functionality changes first,
and then enable the driver to use them bypassing the fixed-link step.

> What is also going to make things complex is the BMC. SoCs and
> switches don't have BMCs, Linux via phylink and all the other pieces
> of the puzzle are in complete control of driving the hardware. We
> don't have a good story for when Linux is only partially in control of
> the hardware, because the BMC is also controlling some of it.

Fortunately the BMC isn't much of an issue as I think I figured out
the one problem I had on Thursday. One of the first things we did is
establish a lockout/tagout procedure for the link and TCAM
configuration. Essentially the FW/BMC is in control when the driver
isn't loaded. When we call open we send a message to the FW indicating
we are locking it out and taking ownership. At that point it shouldn't
modify anything unless we ask it to, or we don't send a heartbeat
message for 2 minutes.

If anything we were the problem child is that the code as it is
currently written defaults to taking down the link and re-configuring
everything on driver load. This was causing a bunch of heartburn
because it was causing the BMC to lose link for a few seconds. However
as of Thursday I realized we can essentially just use our
pcs_get_state call at the start of our configure routine to identify
if we actually need to reconfigure things or if the link is already up
with the configuration we want. Doing that the only thing that causes
any link issues is the initial phylink_link_down in phylink_resume,
however that is much less significant as it doesn't actually trigger
any link down events on the FW and the time it is down is only a
fraction of a second versus the several seconds it takes for a PCS
reset and for the PMA to complete link training.

