Return-Path: <netdev+bounces-179345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA56A7C10E
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 17:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8747F3B3090
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 15:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21391FDA96;
	Fri,  4 Apr 2025 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NV9kGc8B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F351FCF65
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743782219; cv=none; b=ifZV6S9okY3EmU+Pk89BBXu1O2kJ2WaV6wR7kOZIh9Qk1GFqkRZQ6rD+qnOE+Rn0ayNVAFLKTfkQhM8tW+BnAXNVatsC+DryQA+pMlYnUGZq7ihcUppSG5c7Yn+fx421TCURHZkkXPMo+vIAgZEFqLRwmZuDsGufpvijnP5Hmyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743782219; c=relaxed/simple;
	bh=oEinWYn2WzMXpFrS19fFmjPcheL0H/1c3+VVimA367w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lYxyuu7KnNfCCHAO/XrW1OqUhiPlpSmCJZM711IayGDme07vlyrpnU6C5uuq7mwH1ZE5PqwPPK692WbvQ7eW0lXSyg53WmPITqYo0h8D3svSoU7Tn3yPVEa5ty6GVjsq8lKTDZ1l7RToqfqUrjou8ThSLbMGHSEA/eTcQnHcv28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NV9kGc8B; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39c0dfba946so1449830f8f.3
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 08:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743782216; x=1744387016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEinWYn2WzMXpFrS19fFmjPcheL0H/1c3+VVimA367w=;
        b=NV9kGc8Ba5QZ8VrSzZNhl917Cc3yN8CbdqXJfAywyzMjAzrUipJT7RaaqpThdiegcT
         8PO6St/RJKv+iq3AvPEUOoxOVjNh6xXHsfD1XbZ1i0mFpuF7aKEDzZ52OweJsJ7OnlIa
         SBoTx+LNxesBleyiTow1wezELMffsKE96/03wTZpApzmaRC2mWRK8n0MwbYtHYlBQZfd
         8w2gY6vvrt2eOdcyXhVgrOzcjjQ6ZDlKsFW4JDb4ZloXcDsDl/Ou4cRNzC7HqtaudOpV
         TRTjYVvlCAYf/3Mf7V/7Ak0SjRDtNTtzO/owcwQYElKSa1lRg4OzZ5pqLyYDK3KLFDRb
         nRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743782216; x=1744387016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEinWYn2WzMXpFrS19fFmjPcheL0H/1c3+VVimA367w=;
        b=NiEUtWczDC5xvuSmuJ/tK1VsXbp6313pxVlMslel8/4IzOCeqcYg/E0wpLh2F09daN
         Mu591yjxc4jiAIuhTzODOsiJ/u6zM+Et5CFG8+7BPC7BHoKr8exsagjoYLzno+awm+nS
         f/8H4WfnDFo6pTZQ7KoO4tsv40hWe3udY0xJ7de0NexO83VBRZFOIcWw3ZL+aivr211k
         Y3yLBlprGcmew1x64SNEu5psr6Hmr3uSijKUbKphEsjH3zCyVCdhczkIMB0tCJZkSwkX
         atdwgc2SJZ4xmaDMXhNd4PHQFCNWl7IEAFeJIvFSuDOQlyW9C9X+2zE47A9Pg4hEcBfk
         hzpg==
X-Forwarded-Encrypted: i=1; AJvYcCW+ar8sWLXzTGlqRF+7DypkvX2aXeEWFfe0A84WJHtg04iQ9CKJJL0BESVLFTJmZap8M6sMbWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7MDDRfL0D8wUo96ShXDZG/rHSy05jCC7D1PyV4SGhN3vDHivc
	EEwJn10SBRa07gBEPzqnLmq8fCParSlIQYCsG+pL/weDFo6LgmhVp8pjFbDTw+/Sg6tpvxIc4IR
	ILjTa71Er53Xe/QuuQzwUS4lee/Q=
X-Gm-Gg: ASbGncupZCS6qs49mY0jLTbnP5GSiNxT9oCAnL328INPlF2sMuc1bLmrJ1SDmCTnBFq
	SZ1qW6o7LQpCaH5t9gdQjqFFuP9zjAOI1MpsXhC0huSjQKYVHPz4nuPNyD/GW4n7kAI7iqQBlt3
	peMxAxyL8KTbG90ZHTwz80zZ7J6sCzO+YrGiRDVqgPPEjuhlfuzs5EJ4b1+ZC2ovGy6cUeVQ==
X-Google-Smtp-Source: AGHT+IHOYm1A9mTHfW0EPFbxWKPYIZ1MEvU6dQHWyo37Nlc775xMPnIz2fjR+tg0YrVZYbm6T7oTqIRhmPhk5nGTIQU=
X-Received: by 2002:a5d:6d8b:0:b0:390:eacd:7009 with SMTP id
 ffacd0b85a97d-39cba9337bbmr2998454f8f.42.1743782215835; Fri, 04 Apr 2025
 08:56:55 -0700 (PDT)
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
 <Z-8XZiNHDoEawqww@shell.armlinux.org.uk>
In-Reply-To: <Z-8XZiNHDoEawqww@shell.armlinux.org.uk>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 4 Apr 2025 08:56:19 -0700
X-Gm-Features: ATxdqUEhr1mJCwCVBiNZOgioKEP2bpwqv4o5YtoXmMB50e3a1BgatSSLlTgCuMQ
Message-ID: <CAKgT0UepS3X-+yiXcMhAC-F87Zcd74W2-2RDzLEBZpL3ceGNUw@mail.gmail.com>
Subject: Re: [net PATCH 1/2] net: phy: Cleanup handling of recent changes to phy_lookup_setting
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	netdev@vger.kernel.org, hkallweit1@gmail.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 4:19=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Apr 03, 2025 at 02:53:22PM -0700, Alexander Duyck wrote:
> > On Thu, Apr 3, 2025 at 9:34=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wro=
te:
> > > Maybe go back to why fixed-link exists? It is basically a hack to mak=
e
> > > MAC configuration easier. It was originally used for MAC to MAC
> > > connections, e.g. a NIC connected to a switch, without PHYs in the
> > > middle. By faking a PHY, there was no need to add any special
> > > configuration API to the MAC, the phylib adjust_link callback would b=
e
> > > sufficient to tell the MAC to speed and duplex to use. For {R}{G}MII,
> > > or SGMII, that is all you need to know. The phy-mode told you to
> > > configure the MAC to MII, GMII, SGMII.
> >
> > Another issue is that how you would define the connection between the
> > two endpoints is changing. Maxime is basing his data off of
> > speed/duplex however to source that he is pulling data from
> > link_mode_params that is starting to broaden including things like
> > lanes.
>
> Just a quick correction - this is not entirely correct. It's speed,
> duplex and "lanes" is defined by interface mode.
>
> For example, 10GBASER is a single lane, as is SGMII, 1000BASE-X,
> 2500BASE-X. XLGMII and CGMII are defined by 802.3 as 8 lanes (clause
> 81.)
>
> speed and duplex just define the speed operated over the link defined
> by the PHY interface mode.
>
> (I've previously described why we don't go to that depth with fixed
> links, but to briefly state it, it's what we've done in the past and
> it's visible to the user, and we try to avoid breaking userspace.)

Part of the issue is that I think I may be mixing terms up and I have
to be careful of that. If I am not mistaken you refer to the PHY as
the full setup from the MII down to the other side of the PMA or maybe
PMD. I also have to resist calling our PMA a PHY as it is a SerDes
PHY, not an Ethernet PHY. Am I understanding that correctly? The PMD
is where we get into the media types, but the reason why I am focused
on lanes is because my interfaces are essentially defined by the
combination of an MII on the top, and coming out the bottom at the PMA
we have either one or two lanes operating in NRZ or PAM4 giving us at
least 4 total combinations that I am concerned with excluding the
media type since I am essentially running chip to module.

> > I really think going forward lanes is going to start playing a
> > role as we get into the higher speeds and it is already becoming a
> > standard config item to use to strip out unsupported modes when
> > configuring the interface via autoneg.
>
> Don't vendors already implement downshift for cases where there are
> problems with lanes/cabling?

One issue with doing any sort of downshift is that RSFEC and the
alignment markers are different for each configuration. As such I
don't think downshifting is an option without changing interface
modes. If the other end is 50R2 and one of the lanes is dead then the
link is dead. No optional downshift to 25R.

> > I am wondering about that. I know I specified we were XLGMII for fbnic
> > but that has proven problematic since we aren't actually 40G.
>
> If you aren't actually 40G, then you aren't actually XLGMII as
> defined by 802.3... so that begs the question - what are you!

Confused.. Sadly confused..

So I am still trying to grok all this but I think I am getting there.
The issue is that XLGMII was essentially overclocked to get to the
50GMII. That is what we do have. Our hardware supports a 50GMII with
open loop rate matching to 25G, and CGMII, but they refer to the
50GMII as XLGMII throughout the documentation which led to my initial
confusion when I implemented the limited support we have upstream now.
On the PMA end of things like I mentioned we support NRZ (25.78125) or
PAM4 (26.5625*2) and 1 or 2 lanes.

To complicate things 50G is a mess in and of itself. There are two
specifications for the 50R2 w/ RS setup. One is the IEEE which uses
RS544 and the other is the Ethernet Consortium which uses RS528. If I
reference LAUI or LAUI-2 that is the the setup the IEEE referred to in
their 50G setup w/o FEC. Since that was the common overlap between the
two setups I figured I would use that to refer to this mode. I am also
overloading the meaning of it to reference 50G with RS528 or BASER.

> > So we
> > are still essentially just reporting link up/down using that. That is
> > why I was looking at going with a fixed mode as I can at least specify
> > the correct speed duplex for the one speed I am using if I want to use
> > ethtool_ksettings_get.
> >
> > I have a patch to add the correct phy_interface_t modes for 50, and
> > 100G links. However one thing I am seeing is that after I set the
> > initial interface type I cannot change the interface type without the
> > SFP code added. One thing I was wondering. Should I just ignore the
> > phy_interface_t on the pcs_config call and use the link mode mask
> > flags in autoneg and the speed/duplex/lanes in non-autoneg to
> > configure the link? It seems like that is what the SFP code itself is
> > doing based on my patch 2 in the set.
>
> That is most certainly *not* what the SFP code is doing. As things stand
> today, everything respects the PHY interface mode, if it says SGMII then
> we get SGMII. If it says 1000BASE-X, we get 1000BASE-X. If it says
> 2500BASE-X, then that's what we get... and so on.

I think I may be starting to understand where my confusing came from.
While the SFP code may be correctly behaved I don't think other PCS
drivers are, either that or they were implemented for much more than
what they support. For example looking at the xpcs
(https://elixir.bootlin.com/linux/v6.14-rc6/C/ident/xpcs_get_max_xlgmii_spe=
ed)
I don't see how you are getting 100G out of an XLGMII interface. I'm
guessing somebody is checking for bits that will never be set.

So then if I am understanding correctly the expectation right now is
that once an interface mode is set, it is set. Do I have that right?
Is it acceptable for pcs_get_state to return an interface value other
than what is currently set? Based on the code I would assume that is
the case, but currently that won't result in a change without a
phydev.

> The SFP code has added support to switch between 2500BASE-X and
> 1000BASE-X because this is a use case with optical SFPs that can operate
> at either speed. That's why this happens for the SFP case.

Okay, so it looks like I will have to add code for new use cases then
as essentially there are standards in place for how to autoneg between
one or two lane modes as long as we stick to either NRZ or PAM4.

> For PHYs, modern PHYs switch their host facing interface, so we support
> the interface mode changing there - under the control of the PHY and
> most certainly not under user control (the user doesn't know how the
> PHY has been configured and whether the PHY does switch or rate
> adapt.)

I think I see what I am missing. The issue I have is that, assuming I
can ever get autoneg code added, we can essentially get autoneg that
tells us to jump between 50R or 100R2, or 25R and 50R2. If I am not
mistaken based on the current model each of those would be a different
interface mode.

Now there are 2 ways we can get there. The first would be to have the
user specify it. With the SFP code as it is I think that solution
should be mostly addressed. The issue is what happens if I do get
autoneg up and running. That is the piece it sounds like we will need
more code for.

> For everything else, we're in fixed host interface mode, because that
> is how we've been - and to do anything else is new development.

Yeah, that is the part I need to dig into I guess. As it stands I have
patches in the works to add the interface modes and support for
QSFP+/28. Looks like I will need to add support for allowing the PCS
to provide enough info to switch interface modes.

