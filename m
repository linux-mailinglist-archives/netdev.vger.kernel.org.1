Return-Path: <netdev+bounces-178168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B2DA751D3
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 22:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05FE16589E
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 21:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627691E0DE2;
	Fri, 28 Mar 2025 21:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWpIWNkq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6762118C907;
	Fri, 28 Mar 2025 21:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743195875; cv=none; b=oi3FJOanMvTxO2xkr1fNWgtKqH5K/4nnRj2TG80DS4GCBkRVnJjI/JDvtzajGHOXiTPpTyYGb3Uin0yEx2aOxONxyMbQMlMjtM+Rgdx5PrAQYMIVrPPEcqktPXYb4Kk6+Y5Zo1EkqIKV5r8ElDKaUcvOSxAegOaByQeykC2ULhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743195875; c=relaxed/simple;
	bh=q84Cqldj3c780hvZ42fdOHl8toWmkzmcCL5KtmV/fzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6bEsDCLWHLUtpNaEyb5iTO8TC94LumHbPsoZPFhBuBr224CcQyUC57B5whseKHf0OHKISlKC34yqrI+je/j6aWPSv6Vbp2eOIM5l3XZ9KiyMHlyVc01LoJp6iU/FkcUn8mO1MZrDiU3CH1uCJHLBaulWqT7sATbytcG4RJVsuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWpIWNkq; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so16827165e9.1;
        Fri, 28 Mar 2025 14:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743195871; x=1743800671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSIh3FrdOpkTgWau5+xAIdfW8HSRLARPhLkJnEuypeo=;
        b=bWpIWNkq8nIViBowwUuD3gKLmwC7dbmiCXkBDJ09e6sSSEJ+se8kIjPrhdv5/LqnCK
         xi1J2en8EenES0ATdpTjXFVxdemdoSiXWqDAyeuIjRq95NvE+HlsRlHjSLnKXIEGX1+m
         MEKhWYYZPCiuldeX75/dJK1X8mdiCGeBdDsEvw5y0bv18PZPBOrS6u1mZloL/1De3oz4
         esfYcOLGYjpW76QyitPyaNlG4Eh4YClReJvTrHmHAahfTX8Ib7mPvhEvON4aJWXP68Md
         x30ISPENVkISNFTwz3eV80itQp/herZ3U0HwwES47IGnxwM//Szd9ZIkUezFczUZbx3K
         j5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743195871; x=1743800671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSIh3FrdOpkTgWau5+xAIdfW8HSRLARPhLkJnEuypeo=;
        b=JNzQMy31UwrGqjAT456CPei0nVSVV1Vf2U5Jvrb32RBZmcNs48wdJ71cWNx57LG8lG
         xdoiJ2HQB43klvFHrRmF4n9CR1YaUSvjS/8uy9oYzTDMDj/22oZOlq/C4+QTlF4pmZAR
         GWwaTPJiaf9Ut/tN6NCtJkp2a6mKlupGMaN+DUSFe6hJhCjtOpmue2Y8m8YDVFk8ddjt
         h+Tej2Ze4IX/BVoSWRQicKj6MWaQ5BrxsISWzukOIZ+sBPgk6ahboxk+8LiX0loMZ5un
         Frg02NxoWZFvQ8w2klpXMOcF0hlHDYFW6ShH64r9Voj6huzPu2n4h8qXu94N5T7zz3C0
         S/VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWabdK70KiVps08MCc5UxB2H3cMmg1lJJE4A2TteO45At9awhuSubmj5XSrscr0FwJ1QXp4Ah6W@vger.kernel.org, AJvYcCWxx6Cw7+GFmMRNq0q+BWroeDK4VxE7FtGm8tjSOzEYj96Zdjg8w6V+M78KxkaEulyu7AmHqEaHUYA7F/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4XSTxILqKsmjzHfsxJEYlu1BELZgyi0aix3n6GKQwkdB1iwci
	VW3xMT5YaWsejvMnFtnd13CPzrdPn4sx2iqilUZIiPNfDSz8+/QYyOeTHgqDiAsudLkPLSsU9Hy
	A7SJzlMQCty1uIFNrhjE1gnVzujA=
X-Gm-Gg: ASbGncsizvLeoFJ52g9ET7Yxh1YSZaE73Ke6afcAaCa1tQfs1Os2kZXIQcDQBuYC8r/
	sOyGPOK+5U0ZwISgWQw4Ps2RHI0v9uKJ9PY5ntxztP5G0zG2rMxHfrOPjz44NAjF/dx3svXw/qn
	NXOoc4Do2AG7fRkmQxDOzgBuxQn5ZY0sbBdYN+9cKUdvdYz/rFn7dUTdHs63U=
X-Google-Smtp-Source: AGHT+IHjAnoCIWLjXR8uzmPgHPGAQG9boLgiFhjr5510YTiNguu/3twMTjqpO1bBTVP0FCTn7eICzR7WVhMECs2KUyU=
X-Received: by 2002:a7b:cc05:0:b0:43b:bb72:1dce with SMTP id
 5b1f17b1804b1-43d91045659mr36166375e9.5.1743195871227; Fri, 28 Mar 2025
 14:04:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
 <20250307173611.129125-10-maxime.chevallier@bootlin.com> <8d3a9c9bb76b1c6bc27d2bd01f4831b2cac83f7f.camel@gmail.com>
 <20250328090621.2d0b3665@fedora-2.home>
In-Reply-To: <20250328090621.2d0b3665@fedora-2.home>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 28 Mar 2025 14:03:54 -0700
X-Gm-Features: AQ5f1JrqUuVU1cELZWHl4GZ4y0CRqhay8dli4FbMitdEQ0Er264WOxmb-vT1-Wg
Message-ID: <CAKgT0Ue_JzmJAPKBhe6XaMkDCy+YNNg5_5VvzOR6CCbqcaQg3Q@mail.gmail.com>
Subject: Re: [PATCH net-next v5 09/13] net: phylink: Use phy_caps_lookup for
 fixed-link configuration
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, 
	linux-arm-kernel@lists.infradead.org, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	=?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Simon Horman <horms@kernel.org>, 
	Romain Gantois <romain.gantois@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 1:06=E2=80=AFAM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> On Thu, 27 Mar 2025 18:16:00 -0700
> Alexander H Duyck <alexander.duyck@gmail.com> wrote:
>
> > On Fri, 2025-03-07 at 18:36 +0100, Maxime Chevallier wrote:
> > > When phylink creates a fixed-link configuration, it finds a matching
> > > linkmode to set as the advertised, lp_advertising and supported modes
> > > based on the speed and duplex of the fixed link.
> > >
> > > Use the newly introduced phy_caps_lookup to get these modes instead o=
f
> > > phy_lookup_settings(). This has the side effect that the matched
> > > settings and configured linkmodes may now contain several linkmodes (=
the
> > > intersection of supported linkmodes from the phylink settings and the
> > > linkmodes that match speed/duplex) instead of the one from
> > > phy_lookup_settings().
> > >
> > > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > > ---
> > >  drivers/net/phy/phylink.c | 44 +++++++++++++++++++++++++++----------=
--
> > >  1 file changed, 31 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> > > index cf9f019382ad..8e2b7d647a92 100644
> > > --- a/drivers/net/phy/phylink.c
> > > +++ b/drivers/net/phy/phylink.c
> > > @@ -802,12 +802,26 @@ static int phylink_validate(struct phylink *pl,=
 unsigned long *supported,
> > >     return phylink_validate_mac_and_pcs(pl, supported, state);
> > >  }
> > >
> > > +static void phylink_fill_fixedlink_supported(unsigned long *supporte=
d)
> > > +{
> > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, supported);
> > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, supported);
> > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, supported);
> > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, supported);
> > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, supported)=
;
> > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, supported)=
;
> > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported)=
;
> > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, supported)=
;
> > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, supported=
);
> > > +}
> > > +
> >
> > Any chance we can go with a different route here than just locking
> > fixed mode to being only for BaseT configurations?
> >
> > I am currently working on getting the fbnic driver up and running and I
> > am using fixed-link mode as a crutch until I can finish up enabling
> > QSFP module support for phylink and this just knocked out the supported
> > link modes as I was using 25CR, 50CR, 50CR2, and 100CR2.
> >
> > Seems like this should really be something handled by some sort of
> > validation function rather than just forcing all devices using fixed
> > link to assume that they are BaseT. I know in our direct attached
> > copper case we aren't running autoneg so that plan was to use fixed
> > link until we can add more flexibility by getting QSFP support going.
>
> These baseT mode were for compatibility with the previous way to deal
> with fixed links, but we can extend what's being report above 10G with
> other modes. Indeed the above code unnecessarily restricts the
> linkmodes. Can you tell me if the following patch works for you ?
>
> Maxime
>
> -----------
>
> From 595888afb23f209f2b1002d0b0406380195d53c1 Mon Sep 17 00:00:00 2001
> From: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Date: Fri, 28 Mar 2025 08:53:00 +0100
> Subject: [PATCH] net: phylink: Allow fixed-link registration above 10G
>
> The blamed commit introduced a helper to keep the linkmodes reported by
> fixed links identical to what they were before phy_caps. This means
> filtering linkmodes only to report BaseT modes.
>
> Doing so, it also filtered out any linkmode above 10G. Reinstate the
> reporting of linkmodes above 10G, where we report any linkmodes that
> exist at these speeds.
>
> Reported-by: Alexander H Duyck <alexander.duyck@gmail.com>
> Closes: https://lore.kernel.org/netdev/8d3a9c9bb76b1c6bc27d2bd01f4831b2ca=
c83f7f.camel@gmail.com/
> Fixes: de7d3f87be3c ("net: phylink: Use phy_caps_lookup for fixed-link co=
nfiguration")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  drivers/net/phy/phylink.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 69ca765485db..de90fed9c207 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -715,16 +715,25 @@ static int phylink_parse_fixedlink(struct phylink *=
pl,
>                 phylink_warn(pl, "fixed link specifies half duplex for %d=
Mbps link?\n",
>                              pl->link_config.speed);
>
> -       linkmode_zero(pl->supported);
> -       phylink_fill_fixedlink_supported(pl->supported);
> +       linkmode_fill(pl->supported);
>
>         linkmode_copy(pl->link_config.advertising, pl->supported);
>         phylink_validate(pl, pl->supported, &pl->link_config);
>
> +       phylink_fill_fixedlink_supported(match);
> +

I worry that this might put you back into the same problem again with
the older drivers. In addition it is filling in modes that shouldn't
be present after the validation.

One thought on this. You might look at checking to see if the TP bit
is set in the supported modes after validation and then use your
fixedlink_supported as a mask if it is supporting twisted pair
connections. One possibility would be to go through and filter the
modes based on the media type where you could basically filter out TP,
Fiber, and Backplane connection types and use that as a second pass
based on the settings by basically doing a set of AND and OR
operations.

Also I am not sure it makes sense to say we can't support multiple
modes on a fixed connection. For example in the case of SerDes links
and the like it isn't unusual to see support for CR/KR advertised at
the same speed on the same link and use the exact same configuration
so a fixed config could support both and advertise both at the same
time if I am not mistaken.

