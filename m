Return-Path: <netdev+bounces-205931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCECB00D5C
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 22:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047661C876FD
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 20:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D1B28B50A;
	Thu, 10 Jul 2025 20:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1HEh9G4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3419E2FC017
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 20:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752180306; cv=none; b=c/w5bxcMdm885I0SgM1uIxK9tLcAOLIbbL5DM3Q1PuMjK0CBrnDe+iL/Nq/NwvbGY55zJPK/Qi4WgadjjhQdPF3tRNf9AXIa47EuhUy0jAbA7b9kcoUtiHS3J1y2v29ilm1GCexCcTc5SZWy+SHCxrFfvbVnydzjJJe2lbrKsI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752180306; c=relaxed/simple;
	bh=fnr2wLEsKBunAwVM2CQHVqnum+xCNPlFlC7W2Ut76jQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUgX7Xxbf4X1kvFaO0G7ZFYd7iBtoi8JaC9/JJTMq6oHReVbZiS34TwTAaislUuCaG3aa3KbPNoktF2+0q+4yvxilBfdWVK81eEDjtACVlHZ0KzDn6vWE5MtUT1abadWHXrPn6QJz5d1CN4WtS1YFvNfmmYie31Mx+ZKiS0Pkz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1HEh9G4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-454cc6e987dso5903435e9.0
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 13:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752180302; x=1752785102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJr8CSxlO6A2X31kSNvGQDubBn2GH5aSWJS4QhQSy7I=;
        b=S1HEh9G4dTq5lY7c89uvelqg0nxlb8skBXa6wXrByH8gDCj33jMu+xzyqh1Dw5IhzS
         uFv4rs2If3n9TDUfDf/fyHKm0PvySlbLaskJ8B0hsDMFOsFJn8edztE3bpWJspeZP8Ly
         M8GG+kfqusFXG9YZW4XKVCC/LmoNzDrAsuhGtVp7raho7LP86alqAupaNeaISSvJzyDw
         LhFpXnryYnwTCRrIRi6r912Vcy1pxIdIBOnCMcVeMF2PuOFiKEkMcD8oiJ14jHBsT0wj
         ocNslto9H/KjIfBLhQ4FA9fuvrrYedmNADgMtr8e6+XY0Zyvx/nwT4DrytiZe+tLE3G0
         mzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752180302; x=1752785102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJr8CSxlO6A2X31kSNvGQDubBn2GH5aSWJS4QhQSy7I=;
        b=lcbhKcX0f7DOP5VGicL0mWAFky6KaZZScktW1x62SR2aYyYNBf3Phs9hScTuDIWjrL
         BxyNXZApgQiMsr7Rt+fhwibDar6+iSo6+3gXYvlxbBjqM+KsmVHV0b3l4UNFOK9B2iU+
         cKchyfuB6bxfouGLn904rkTxTUR1bSzTgbam2nSkCZfkGYaWq+luurrrRfUtraOdB8X/
         P7nyUm3qNqLyoRQWll7AFJm3acDVK+x4eLWAn+0xWFacOY70iuqArfCX/TkkLC99veuq
         3Kn0BxQK+F9EWuJGAJoZAHHQjTSK9W9Lopi2kryCprSVrEWWP9tVBWuZNbEA2nGfkSWZ
         8XoA==
X-Forwarded-Encrypted: i=1; AJvYcCWZfQrrkOR2JXOQTA+9tehckDLZZjb6k0VGrzRjg5zEedMJXmevhZvvO3FlNob64f6A/ed3kgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqjSgCoQIis7Mlq+yvNZmEO1aQAY5/AfF6rvzwvJw9i1pWPMM4
	rkWlrOUcVRqTZdZXc2h6E+JLjAPbdUCxNEuBfpo116JlAAhdiDR/PMIwB8AVrt0GTnPyLgabq7y
	5H9DxgQjIGJZqBj70KnvpKUXMrGCpAl4=
X-Gm-Gg: ASbGnctXzXGWqKYLY27oACUR/6TPrRstbTZpcgdan1lq1EAmr11huXYohrr6ooiUmYS
	jU/GvyfovXTrWvUAAGbHdTdxJl5DjUDGME2bVPGGNeM8w3QJTByTUKklj2aFPTMx6aYteQEuo7R
	ke2D/mdKZxmshx6CyZhmMmAIlfVdpbloEA4dnKb6BDCTV9BNilZ3eMfC8if19LEaqMIJ5fjVlks
	QX2cspg0KezsAoKXrQdKk5pSsu27VDqGqSo0oIw
X-Google-Smtp-Source: AGHT+IGs1zj2X+mnw9SOem9pECR/UXkEPJfGQgUQipC9CSfofddfA28Tw9fVX3adpWKZSDMzQMZc91S+PTCuUmmLuCA=
X-Received: by 2002:a05:600c:5014:b0:43c:f3e1:a729 with SMTP id
 5b1f17b1804b1-454db8bf2demr46078345e9.12.1752180302220; Thu, 10 Jul 2025
 13:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aGT_hoBELDysGbrp@shell.armlinux.org.uk> <E1uWu14-005KXo-IO@rmk-PC.armlinux.org.uk>
 <20250702151426.0d25a4ac@fedora.home> <aGU2C3ipj8UmKHq_@shell.armlinux.org.uk>
 <CAKgT0UcWGH14B0zZnpHeJKw+5VU96LHFR1vR4CXVjqM10iBJSg@mail.gmail.com>
 <aGWF5Wee3vfoFtMj@shell.armlinux.org.uk> <CAKgT0UdVW6_hewR7zNzMd_h7b_Lm_SHdt72yVhc7cLHcfFxuYQ@mail.gmail.com>
 <14b442ad-c0ab-4276-8491-c692f0b7c5c9@lunn.ch> <CAKgT0UfXRsVEgvJScapiXNWyqB8Yd07t5dgrKX82MRup78tXrw@mail.gmail.com>
 <aHAH53ZEE3snK4IE@shell.armlinux.org.uk>
In-Reply-To: <aHAH53ZEE3snK4IE@shell.armlinux.org.uk>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 10 Jul 2025 13:44:25 -0700
X-Gm-Features: Ac12FXw2UXJK4W3aU_xWFKpOY1Hz6ggOH1WxeNvVjZOOfu1IoqHa0p8IgrJE-1E
Message-ID: <CAKgT0UfB-CKBsAPHRA3TMuiAdiAbBEVTHcEUgmCHL-q0zJMRJA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: phylink: add phylink_sfp_select_interface_speed()
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 11:35=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Jul 10, 2025 at 10:22:44AM -0700, Alexander Duyck wrote:
> > On Thu, Jul 10, 2025 at 9:11=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > > What is wrong, that it is reporting LP information, or that it is
> > > reporting it does not support autoneg when in fact it is actually
> > > doing autoneg?
> >
> > I have some debug code on here that is reporting the FW config as the
> > "LP Advertised". I had borrowed that approach from the phylink
> > fixedlink config as I thought it was a good way for me to know what
> > the FW was requesting without having to report it out to a log file.
>
> There are a few points to be made here.
>
> 1. Fixed link configuration is not the same as !autoneg setting with
>    the presence of a PHY. !autoneg with a PHY present means that the
>    PHY has been instructed not to perform autonegotiation, but to set
>    the specified parameters for the link and only allow the link to
>    operate at the specified speed/duplex. There are exceptions - as
>    users expect 1G to work with "autoneg" disabled, and 1G requires
>    AN in order to bring the link up. Some PHYs support disabling the
>    autoneg function at 1G speed by internally ignoring the request
>    to disable autoneg, and instead only advertising to the link
>    partner that 1G at the specified duplex is supported. We took
>    that and turned it into a software thing for all PHYs as some
>    PHYs decided to go a different route - basically not supporting
>    the AN enable bit being turned off at 1G speeds.
>
> 2. Fixed link configuration is a software concept where there is no
>    accessible PHY present. Phylink rejects fixed link configuration
>    with a PHY. There is no support to configure a PHY into fixed
>    speed/duplex if present, and has never been supported prior to
>    phylink.
>
> 3. The history. Prior to phylink (and it remains in some cases today),
>    fixed link configuration was created by providing a software
>    emulated PHY to phylib for the MAC driver to use, thus avoiding
>    MAC drivers having to add explicit code for fixed links. They
>    looked just like a normal PHY, but was limited to no faster than
>    1G speeds as the software emulation is a Clause 22 PHY.
>
>    This software emulated PHY replaces the presence of a physical
>    PHY (there is none) and the PHY it emulates looks like a PHY that
>    supports AN, has AN enabled, but only supports a single speed
>    and duplex, only advertises a single baseT(x) speed and duplex,
>    and the link partner agrees on the speed and duplex. This "fools
>    phylib into resolving the speed and duplex as per the fixed link
>    configuration.
>
>    However, in reality, there is no AN.
>
>    This has become part of the user API, because the MII registers of
>    the fixed link PHY were exported to userspace, and of course through
>    ethtool.
>
>    There has never been a MII API for reading the fixed link parameters
>    for speeds > 1G, so while phylink enables fixed link configuration
>    for those speeds, there is no MII register support for this for
>    userspace.

So the issue is in our setup we have a SerDes PHY so it isn't a real
MII based PHY and it is being managed by the firmware so we don't have
direct access.

One thought I was playing around with was emulating a 25/50/100G PMA
and AN in software and exposing that as the interface to the FW to
play the role of the PHY. The FW is playing the role of a device tree
configuration in that the EEPROM is pre-programmed with the expected
speed/lane/FEC configuration and the FW is reading that to determine
what the link configuration should be as we cannot use autoneg as the
switch port on the other side doesn't support it. For our production
use case we will always be using that speed, but for testing we will
need to support the ability to set manual speeds.

> (As an aside)
> Someone earlier today sent a reminder about a bug I'd introduced for
> 10GBASE-R, 5GBASE-R and another interface (I don't recall right now)
> and I proposed a patch that only cleared the Autoneg bit in the
> adertising mask. Having been reminded about it, and had Andrew's
> input on this thread, I'm wondering whether config.advertising
> should be entirely cleared as in !autoneg mode, the advertising mask
> makes no sense.
>
> However, I'm supposed to be on my vacation, so I'm not going to start
> testing anything... this email as a bonus that would've otherwise have
> been delayed by about two weeks... but the way things are going (family
> issues) it could turn out to be a lot longer as I may have to become a
> full time carer. So much for an opportunity to have an opportunity to
> relax, which I desperately need.

Enjoy your vacation. It will probably take me a while to try to work
out an acceptable solution for how to deal with the buried/hidden PHY
behind the firmware anyway. For now this thread has become more about
fbnic anyway then your original patch since we have more-or-less
verified it works as expected.

