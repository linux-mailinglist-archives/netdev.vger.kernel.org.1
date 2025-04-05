Return-Path: <netdev+bounces-179442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590B0A7CBCB
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 22:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EEB7166854
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 20:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1741A8F84;
	Sat,  5 Apr 2025 20:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQBhOCdN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAA42F36
	for <netdev@vger.kernel.org>; Sat,  5 Apr 2025 20:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743884625; cv=none; b=BwBbVJpjFIx2T0zXnZraLAi78BFCTSNSeK1TJ1XAyQvNCRZ6bu7u0j1u49bp8k27RMIod963uhQAx08L3AO/EbakIUxgm2bMfRBuf9SCKzPCZDyQTBj5YuVxdmhsWW3+V6Qj323RHJuFrq04AUO/186WHMOmIB3+nB5zxShyyZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743884625; c=relaxed/simple;
	bh=iJXg6DeVteLy/1VNM0WiyGd9CBBMqPEt0kPTXkmFF9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WiEWWyRPe8tAN3P867SVJLdYdpqxe7y0j1gHq1T8EaA2a7uZqmgrsGMHKc65rODwpq56trI9tGUuFhtRe7yTpHJWR86IzUYs3JLpJn1eFMjtQX9wpkgmF/nE2BXApJHCQYW4mdvAIVGQ1dL2kiHHeJZItoOW0cvKLn9ceWPi33A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQBhOCdN; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf680d351so24293695e9.0
        for <netdev@vger.kernel.org>; Sat, 05 Apr 2025 13:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743884621; x=1744489421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8gas5YgXIe2Xv7j6RgIBuUzCGbfC00GIDH60biF60Q=;
        b=LQBhOCdN9UKMrllyDAcyfpi4D2jN6EUR3+7RnudcWaz9RY+I6IcQ810610gb1pd2kU
         O0bxsmLlLFMPomDKYLx/lRgzZJmN/UOzZyHKD+tXk5rH5XtAZx/YEQI5E1JnHHy8nE/t
         US4xut2s1UMEAIRY5WZFCFcgqm48eT7/SwRN7SQAnEW4lMAhrclDeZRHxhM4M7VYy3/M
         OYvBNY3Y1LicVIlKykvJIbhnGc1fU5Sr/VH7I06EmlkafGHsjJZKPlMGq1kdM20gOmOY
         P8y4oaz5KhyI6OUpbborqnE0GTpTH2mL/jwO0RCSRveKWiW7eUQIEfJSD1eMQJsJ8Gsv
         y/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743884621; x=1744489421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8gas5YgXIe2Xv7j6RgIBuUzCGbfC00GIDH60biF60Q=;
        b=mAdYcZPm0A0L9EGB45yIfvXp4GlTvLUjLgREpvyF4TAaLrk9wZ2pclE4odn0OMig5H
         BWh9DzxmIqI7pJnp0fMUWfmhj0rXEckH/0aG+o8Olh6B6JVjUhrCnZIszLKQhq8DT7Ii
         ktI25RTq9V/JHi2IciGi3d6Ic9eQnPd6ZUaoPuglpoyC5VoAOSjXc5naZGL4fT8i0163
         0R2RQaNEev59Ea9UkETizjddZDYBvdX885orXLvAN3LETZ6xUqr8fctkDE+PCXX45aVQ
         4F+AMz8PLaO1iAbzY0OOq7cz5P5q6mrRjMMwJFwLVxQNaLika2NzcKudG44QI4JNOTaJ
         F9Qw==
X-Forwarded-Encrypted: i=1; AJvYcCX3kNT2T+RozOmoph+x0M4bYdDY47Udcgrli+sqtgYEnccij0YaqceCmL8VfKciFEMCGEXdC6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZdmZjNXfSEn/VT4RWmZYVEDQgG4juqgROsy6ob3clpXCOmdu1
	aP78blsFRc9/7uOjitq3t57zBwApDSOl5E3ZOhsv+VCzMy0jVZJXQ4UYdLwnSioR0O7uPAv19aa
	D7r5RIIdu3QvslIW+r7GUrBK4VPg=
X-Gm-Gg: ASbGncueNLIbJPQ8WU9KHeOtA8sk5z/XyDsFBGtkVizuAlNNJFEFLBjyryyLDO6j8gp
	VmfvxGdganCsLSzAHfXR+sFwCwpyWPYdTdranVpE/3y4oEQuehF/osOy+Vpj3Xsg2BSaIOPj5Y1
	GAKpQ+0UzdRTfcdshRG1dz+HBJHcax9MW3LyoMNOADs2yKC8N9yNLGCcl4Zfo=
X-Google-Smtp-Source: AGHT+IE0Cgk45Apb8PS21OxPRAQTVhHNwivcwCAEDVBRks4AzrkAx0J3MlSnjiSCdaiWqbvc31ugNo2Gu7IuWlZJGSI=
X-Received: by 2002:a05:600c:c1a:b0:43b:c592:7e16 with SMTP id
 5b1f17b1804b1-43ebee7410emr127807895e9.3.1743884620471; Sat, 05 Apr 2025
 13:23:40 -0700 (PDT)
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
 <Z_DzhKiMkjFVNMMY@shell.armlinux.org.uk>
In-Reply-To: <Z_DzhKiMkjFVNMMY@shell.armlinux.org.uk>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sat, 5 Apr 2025 13:23:04 -0700
X-Gm-Features: ATxdqUGxbPiHZlJRc4HF8RcGw7WAoncs4FBU1Qaz2CsDMbdArN0d1XiePWDW2pI
Message-ID: <CAKgT0UdRRMJihC2nFgHLgxB177tMpHQ==Um_gnsbwoYCm_81KA@mail.gmail.com>
Subject: Re: [net PATCH 1/2] net: phy: Cleanup handling of recent changes to phy_lookup_setting
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	netdev@vger.kernel.org, hkallweit1@gmail.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 5, 2025 at 2:10=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Fri, Apr 04, 2025 at 08:56:19AM -0700, Alexander Duyck wrote:
> > On Thu, Apr 3, 2025 at 4:19=E2=80=AFPM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Thu, Apr 03, 2025 at 02:53:22PM -0700, Alexander Duyck wrote:
> > > > On Thu, Apr 3, 2025 at 9:34=E2=80=AFAM Andrew Lunn <andrew@lunn.ch>=
 wrote:
> > > > > Maybe go back to why fixed-link exists? It is basically a hack to=
 make
> > > > > MAC configuration easier. It was originally used for MAC to MAC
> > > > > connections, e.g. a NIC connected to a switch, without PHYs in th=
e
> > > > > middle. By faking a PHY, there was no need to add any special
> > > > > configuration API to the MAC, the phylib adjust_link callback wou=
ld be
> > > > > sufficient to tell the MAC to speed and duplex to use. For {R}{G}=
MII,
> > > > > or SGMII, that is all you need to know. The phy-mode told you to
> > > > > configure the MAC to MII, GMII, SGMII.
> > > >
> > > > Another issue is that how you would define the connection between t=
he
> > > > two endpoints is changing. Maxime is basing his data off of
> > > > speed/duplex however to source that he is pulling data from
> > > > link_mode_params that is starting to broaden including things like
> > > > lanes.
> > >
> > > Just a quick correction - this is not entirely correct. It's speed,
> > > duplex and "lanes" is defined by interface mode.
> > >
> > > For example, 10GBASER is a single lane, as is SGMII, 1000BASE-X,
> > > 2500BASE-X. XLGMII and CGMII are defined by 802.3 as 8 lanes (clause
> > > 81.)
> > >
> > > speed and duplex just define the speed operated over the link defined
> > > by the PHY interface mode.
> > >
> > > (I've previously described why we don't go to that depth with fixed
> > > links, but to briefly state it, it's what we've done in the past and
> > > it's visible to the user, and we try to avoid breaking userspace.)
> >
> > Part of the issue is that I think I may be mixing terms up and I have
> > to be careful of that. If I am not mistaken you refer to the PHY as
> > the full setup from the MII down to the other side of the PMA or maybe
> > PMD. I also have to resist calling our PMA a PHY as it is a SerDes
> > PHY, not an Ethernet PHY.
>
> The model that we have in the kernel is:
>
>        '------- Optional ----------`
>   MAC --- PCS --- Optional Serdes -------- Optional PHY --- Media
>        `---------------------------'  ^
>                                       PHY_INTERFACE_MODE_xxx

Okay that more-or-less matches with what I was thinking.

> For example, in PHY_INTERFACE_MODE_MII (defined by clause 22), this is
> typically used for setups that only support 100M/10M speeds between the
> MAC and ethernet PHY to connect to the media.
>
> In the case of PHY_INTERFACE_MODE_1000BASEX (clause 36), then there will
> generally be a PCS block, sometimes there's a separate serdes block, and
> sometimes there may be a PHY. Other times, there may not be a PHY and
> the Serdes directly connects to the media.
>
> To simplify things, we continue to use the PHY_INTERFACE_MODE_xxx to
> define the properties of the interface on the right hand side of the
> MAC/PCS/Serdes, even when there is no PHY.
>
> As an illustration of the kind of properties, consider Cisco SGMII vs
> 1000BASE-X. These are physically the same interface, but the protocol
> differs slightly. Then take 2500BASE-X (ignore 802.3's definition,
> they were years late to that party and so we have a long history of
> vendor implementations, and thus practically their definition is
> irrelevant.) 2500BASE-X is generally implemented by taking the 802.3
> 1000BASE-X implementation, and up-clocking it by 2.5x.
>
> 1000BASE-X, 2500BASE-X and SGMII are all single lane. XGMII, for 2.5G,
> 5G and 10G speeds, is divided into four lanes of 8 data lines and one
> control signal.
>
>
> In terms of the layers that 802.3 uses, this is where things can get
> confusing. Consider MAC-PCS-Serdes-Media vs MAC-PCS-Serdes-PHY-Media.
>
> The former does conform to the 802.3 layering:
>
>         MAC
>         RS
>         GMII
>         PCS
>         PMA
>         PMD
>         media
>
> The latter case, however, is effectively:
>
>         MAC     \
>         RS      |
>         GMII    | Host
>         PCS     |
>         PMA     |
>         PMD     /
>
>         PMD     \
>         PMA     |
>         PCS     | External Ethernet PHY, either on a PCB, module or
>         PCS     | pluggable module
>         PMA     |
>         PMD     /
>
> The effective presence of three PCS, PMA and PMDs make talking about
> these things more complex. Throw into this that Ethernet PHYs may not
> split out these functions to software, especially the host-facing
> PCS/PMA, except maybe through some control bits in overall control
> registers or through pinstrapping.
>
> Nevertheless, PHY_INTERFACE_MODE_xxx defines the operating mode of
> the PCS/PMA/PMD in the host, and also the host facing PMD/PMA/PCS
> of any following PHY.
>
> When considering ethtool link modes, negotiated speed/duplex, and
> configured speed/ duplex are about the ultimate media that is
> presented to the user.

I am following so far. Fortunately in our case the setup will be
pretty simple as we mostly conform to the 802.3 setup with only a few
minor issues at 50G. I think I might also realize part of my issue in
terms of the stuff about "lanes". It essentially comes down to really
an issue about media type. I think making sure we have the QSFP module
code in place will probably take care of most of it as it should limit
us to either 25R/50R2 or 50R/100R2 so we can avoid the confusion on
the to 50G modes.

> So, in the former case, where the media is connected directly to the
> serdes, the PHY interface mode needs to agree with the ethtool link
> modes. In the case of PHY_INTERFACE_MODE_1000BASEX, the media we can
> only support that can be directly connected are the 1000BASE-X family,
> and ethtool doesn't distinguish between each of those medias, so we
> only have ETHTOOL_LINK_MODE_1000baseX_Full_BIT.
>
> For PHY_INTERFACE_MODE_10GBASER, things get a bit more complicated,
> because we have each media type as a separate ethtool link mode, but
> it can support these connected directly:
>         ETHTOOL_LINK_MODE_10000baseCR_Full_BIT
>         ETHTOOL_LINK_MODE_10000baseSR_Full_BIT
>         ETHTOOL_LINK_MODE_10000baseLR_Full_BIT
>         ETHTOOL_LINK_MODE_10000baseLRM_Full_BIT
>         ETHTOOL_LINK_MODE_10000baseER_Full_BIT
>
> PHY interface modes tend to lag behind the ethtool link modes, so it's
> entirely possible that definitions to support interfaces that support
> the faster link speeds are missing.

Yeah, this is where I was essentially hacking in "fixed-link" to
establish an initial connection while I was working to prop up the PHY
interface support in the kernel. The speeds have been there in ethtool
for some time, but the only interface that has been there was the
XLGMII which was puzzling me as the implementations for it currently
seem to be very misleading.

> > Am I understanding that correctly? The PMD
> > is where we get into the media types, but the reason why I am focused
> > on lanes is because my interfaces are essentially defined by the
> > combination of an MII on the top, and coming out the bottom at the PMA
> > we have either one or two lanes operating in NRZ or PAM4 giving us at
> > least 4 total combinations that I am concerned with excluding the
> > media type since I am essentially running chip to module.
>
> It seems to me that what you are describing conforms with the former
> case above, so PHY_INTERFACE_MODE_xxx describes the interface presented
> to the media, and speed/duplex describe the data speed over that link.
> The ethtool link modes describe the properties of the media itself.
>
> > > If you aren't actually 40G, then you aren't actually XLGMII as
> > > defined by 802.3... so that begs the question - what are you!
> >
> > Confused.. Sadly confused..
> >
> > So I am still trying to grok all this but I think I am getting there.
> > The issue is that XLGMII was essentially overclocked to get to the
> > 50GMII.
>
> This is what happened with 2500BASE-X. Vendors went off and did their
> own thing to create that higher speed interface. Many just up-clocked
> their 1000BASE-X implementation to provide the faster data rate.

Yeah, I think this is what we have on our hands. Essentially the
XLGMII 50G is likely based on the Ethernet Consortium approach to it
so it is just a 40G that was up-clocked to get to 50 and then make use
of half the lanes from a 100R4. That is why I was referring to it as
LAUI as it definitely isn't the 50BaseR.

> > That is what we do have. Our hardware supports a 50GMII with
> > open loop rate matching to 25G, and CGMII, but they refer to the
> > 50GMII as XLGMII throughout the documentation which led to my initial
> > confusion when I implemented the limited support we have upstream now.
> > On the PMA end of things like I mentioned we support NRZ (25.78125) or
> > PAM4 (26.5625*2) and 1 or 2 lanes.
>
> Great. This reminds me of the confusion caused by vendors overloading
> the "SGMII" term, which means we're now endlessly trying to
> disambiguate between SGMII being used for "we have a single lane
> serial gigabit media independent interface" and "we have an interface
> that supports the Cisco SGMII modifications of the IEEE 802.3
> 1000BASE-X specification."
>
> I don't think vendors just don't have any clue of the impacts of their
> stupid naming abuse. It causes *major* problems, so to hear that it
> continues with other interface modes (a) is not surprising, (b) is
> very disappointing.
>
> To get to the bottom of these interface types you are talking about,
> it sounds like each lane is a balanced pair of conductors in each
> direction? Do you know what kind of protocol is run over those lanes?
> Could it be essentially 25GBASE-R (e.g. it would be if operating with
> one lane NRZ.) This would make sense, because 25GBASE-R is 25Gb/s with
> 64B/66B, which gives a data rate of 25.78125Mbd.
>
> To get to the 50Gb/s NRZ, I'm guessing the hardware effectively runs
> 25GBASE-R over two lanes, doubling the data rate.

Yeah. The part has two PCS blocks that are running in parallel for
50R2 (Ethernet Consortium Version). There is an IEEE version of it,
but nobody runs it as it would require new cabling since it requires
26.5625Mbd per lane to run it, so they are all sticking with the
non-IEEE version.

> For PAM4, there doesn't seem to be anything defined in 802.3 for 25G
> data rates, so I guess we have another pair of vendor specific
> interface modes.

This is covered in the 802.3cd spec. The two types they define are
50BaseR and 100BaseP. They bump the clock rate to 26.5625Mbd, make
RS544 mandatory, and add PAM4 as a requirement for 50R1 and 100R2.

> > To complicate things 50G is a mess in and of itself. There are two
> > specifications for the 50R2 w/ RS setup. One is the IEEE which uses
> > RS544 and the other is the Ethernet Consortium which uses RS528. If I
> > reference LAUI or LAUI-2 that is the the setup the IEEE referred to in
> > their 50G setup w/o FEC. Since that was the common overlap between the
> > two setups I figured I would use that to refer to this mode. I am also
> > overloading the meaning of it to reference 50G with RS528 or BASER.
>
> Hmm, I'm guessing 50G is defined in 802.3 after the 2018 edition (which
> is the latest I have at the moment.)

Correct. As mentioned it is in the 2022 edition.

> > > That is most certainly *not* what the SFP code is doing. As things st=
and
> > > today, everything respects the PHY interface mode, if it says SGMII t=
hen
> > > we get SGMII. If it says 1000BASE-X, we get 1000BASE-X. If it says
> > > 2500BASE-X, then that's what we get... and so on.
> >
> > I think I may be starting to understand where my confusing came from.
> > While the SFP code may be correctly behaved I don't think other PCS
> > drivers are, either that or they were implemented for much more than
> > what they support. For example looking at the xpcs
> > (https://elixir.bootlin.com/linux/v6.14-rc6/C/ident/xpcs_get_max_xlgmii=
_speed)
> > I don't see how you are getting 100G out of an XLGMII interface. I'm
> > guessing somebody is checking for bits that will never be set.
>
> I don't think anyone reviewed the XLGMII code there - it was added by
> 7c6dbd29a73e ("net: phy: xpcs: Add XLGMII support"). I don't have XPCS
> documentation to be able to comment, but as XLGMII as defined by 802.3
> supports up to 40G, it does raise questions - is this another case
> of overloading 802.3's XLGMII... no idea without further research.
>
> As you've found, these kinds of vendor inventions and overloading of
> terms thing just creates confusion.
>
> The problem for the kernel is if one of those vendor inventions becomes
> established and its part of a kernel-external API, then fixing it later
> becomes rather difficult.
>
> > So then if I am understanding correctly the expectation right now is
> > that once an interface mode is set, it is set. Do I have that right?
>
> That certainly used to be the case before phylink. Phylink exists to
> address several issues:
>
> 1. How do we hot-plug ethernet PHYs (drivers/net/phy) from a network
>    interface without needing to tear down the interface.
>
> 2. How do we reconfigure the network device as a whole while it is up
>    to switch between different interface modes.
>
> The former came from me being sent a SolidRun Clearfog (the original
> Armada 388) based platform, which had a SFP cage on, and the need to
> support copper SFP modules which have a PHY integrated on them.
>
> The latter also came from me when I was sent the Macchiatobin board,
> which had Marvell 88X3310 PHYs on which switch their host facing
> interface between 10GBASE-R, 5GBASE-R, 2500BASE-X and SGMII depending
> on what was negotiated on the PHYs media side.
>
> So, ethernet drivers such as mvneta and mvpp2 (used on these two
> platforms) are coded to allow interface modes to be switched between.

Okay, I might look at those two then. I'm usually the type to follow
an existing example then adapt/refactor it once I have it up and
running.

> The stmmac driver, however, is very much not, and I'm not sure that the
> hardware supports switching modes - but I'm working on the stmmac
> driver, trying to improve it. The phylink integration there is what I
> would best describe as "botched". It works but I'd say that it's not
> correct. E.g. The hardware can have an integrated PCS, but the code
> entirely bypasses phylink, messing with network device state that
> phylink relies upon, which can cause phylink to malfunction.
>
> > Is it acceptable for pcs_get_state to return an interface value other
> > than what is currently set? Based on the code I would assume that is
> > the case, but currently that won't result in a change without a
> > phydev.
>
> As mentioned previously, we've supported this for PHYs. Currently the
> code in phylink only allows interface changes when a PHY is present:
>
>                 /* Only update if the PHY link is up */
>                 if (pl->phydev && pl->phy_state.link) {
>                         /* If the interface has changed, force a link dow=
n
>                          * event if the link isn't already down, and re-r=
esolve.
>                          */
>                         if (link_state.interface !=3D pl->phy_state.inter=
face) {
>                                 retrigger =3D true;
>                                 link_state.link =3D false;
>                         }
>                         ...
>                         mac_config =3D true;
>                 }
>
> ...
>         if (mac_config) {
>                 if (link_state.interface !=3D pl->link_config.interface) =
{
>                         /* The interface has changed, force the link down=
 and
>                          * then reconfigure.
>                          */
>                         if (cur_link_state) {
>                                 phylink_link_down(pl);
>                                 cur_link_state =3D false;
>                         }
>                         phylink_major_config(pl, false, &link_state);
>                         pl->link_config.interface =3D link_state.interfac=
e;
>                 }
>         }
>
> but there is no fundamental reason why we couldn't allow that without
> a PHY, but with a few caveats:
>
> 1. provided that the change in interface mode doesn't result in a
>    different PCS being selected by mac_select_pcs() (which we should
>    probably enforce in this case).
>
> 2. provided that the change in interface mode doesn't cause the PCS's
>    pcs_get_state() method to report differently as a result of that
>    interface change. (The reason is, some PCS behave differently
>    depending on interface mode.)
>
> These two caveats should be obvious, because they can lead to the
> interface mode/link endlessly toggling if either are false.

These should be pretty easy for us to stick to. Currently we just have
the one PCS so we shouldn't be changing it. As far as the
pcs_get_state call, the general setup for now is that it is just doing
link checking. What we will likely be adding is some logic to handle
delaying the link_up a bit to address some link bouncing due to the
PMA doing link training, and then other then that it would be autoneg
which is kind of low on the totem pole for us since we don't have any
link partners that will currently be using it, but is something we may
end up supporting.

> > > The SFP code has added support to switch between 2500BASE-X and
> > > 1000BASE-X because this is a use case with optical SFPs that can oper=
ate
> > > at either speed. That's why this happens for the SFP case.
> >
> > Okay, so it looks like I will have to add code for new use cases then
> > as essentially there are standards in place for how to autoneg between
> > one or two lane modes as long as we stick to either NRZ or PAM4.
>
> As I think I've mentioned previously, I would like to find a different
> solution in the ksettings_set() code that is functionally similar to
> userspace (so we don't break use cases there) but without being tied
> to calling into the SFP code.

It seems like part of the issue is that the use of the advertising
field if autoneg is disabled is kind-of undefined. From what I can
tell ethtool code will cleanup the advertised mode if autoneg is
enabled (https://elixir.bootlin.com/linux/v6.14-rc6/C/ident/ethnl_auto_link=
modes),
however if we are in fixed mode it isn't touching it. I'm honestly
wondering if the advertising field should be ignored when in a
non-autoneg setup.

As far as deriving the media type, the SFP seems to be a good way for
me to figure that out, at least for the QSFP+/28 cables I have seen so
far. They at least lock me down into either 25CR/50CR2 or 50CR/100CR2
depending on the cable. So if I do get around to supporting clause 73
autoneg I think I should already be half way there as the supported
fields are locked down based on that already. One thing I may do in
the meantime is use the firmware provided link info as the
lp_advertising value until I can get true c73 up and running.

> The original code that handled optical interfaces did the same as
> ksettings_set() - going from ethtool link modes to a PHY interface
> mode. I revamped that path to use a bitmap of interface modes having
> also introduced the interface modes that the network device supports.
> This has turned out to be much easier to understand.
>
> I don't like that ksettings_set() still uses the old way, because
> that's a recipe for fragility with things going weird. We have
> phylink_choose_sfp_interface() now which chooses the interface based
> on preference, which the ksettings_set() code doesn't do, but it
> should... something that needs addressing.
>
> It sounds like your issue needs to be rolled into this as well.

I think the "fixed-link" and ksettings_set issues are similar.
Basically we just need a good way to define how we get from a fixed
mode to an interface type without autoneg.

> What I'm thinking is that we need to do is limit the bitmap of
> PHY interface modes supported by the MAC and optional SFP by the
> maximum data of the advertised link modes, and then do a preference
> based selection. In the case of fixed-link mode, I've proposed a
> solution there in one of my previous emails that bases it off the
> maximum speed of supported PHY interface modes.

Well for my setup there are essentially 3 components that come into
play. The MII interface selection is based purely on the speed (and a
little bit fec), so we are either 50GMII w/ rate matching, 50GMII, or
CGMII. However I don't need it to determine if we can get a link, I
can configure it at link_up time. The SFP cage selects the signal rate
of the individual lanes of the link based on the cable which when
combined with the speed defines what my AUI selection has to be. So
the PCS and the SFP are the two components I need to be in agreement
when it comes to determining the interface mode in order to get a
link, the MAC or MII interface can be a much later
selection/configuration.

So if anything I wonder if the PCS shouldn't select the interface type
instead of the other way around. Actually looking at the code it seems
like the phylink_validate_mask and phylink_choose_sfp_interface would
make the most sense. We could essentially just pass the speed and
duplex as part of the link_state and validate using those instead of
the advertising mask. Then the PCS could essentially own the decision
to mask itself down to the 1 bit it wants for that speed, then after
that it would be up to the phylink code to decide which interface it
wants to select.

> > > For PHYs, modern PHYs switch their host facing interface, so we suppo=
rt
> > > the interface mode changing there - under the control of the PHY and
> > > most certainly not under user control (the user doesn't know how the
> > > PHY has been configured and whether the PHY does switch or rate
> > > adapt.)
> >
> > I think I see what I am missing. The issue I have is that, assuming I
> > can ever get autoneg code added, we can essentially get autoneg that
> > tells us to jump between 50R or 100R2, or 25R and 50R2. If I am not
> > mistaken based on the current model each of those would be a different
> > interface mode.
>
> Yes, I agree.
>
> > Now there are 2 ways we can get there. The first would be to have the
> > user specify it. With the SFP code as it is I think that solution
> > should be mostly addressed. The issue is what happens if I do get
> > autoneg up and running. That is the piece it sounds like we will need
> > more code for.
> >
> > > For everything else, we're in fixed host interface mode, because that
> > > is how we've been - and to do anything else is new development.
> >
> > Yeah, that is the part I need to dig into I guess. As it stands I have
> > patches in the works to add the interface modes and support for
> > QSFP+/28. Looks like I will need to add support for allowing the PCS
> > to provide enough info to switch interface modes.
>
> Before I agree/disagree, let's see what the code ends up looking like.
> I don't think it's going to be too bad based on what we've discussed
> here.

Yes, as always code talks.. I'll submit an RFC next week. For the most
part the only real issue getting QSFP support going is that I have to
support 2 different base pages, one for SFF8472 and one for SFF8636,
so I am having to change the eeprom structure and adding logic to skip
SFF8472 specific accesses.

