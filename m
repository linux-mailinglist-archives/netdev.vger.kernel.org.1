Return-Path: <netdev+bounces-178632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BE1A77EE9
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 17:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0757216BBDA
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 15:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9950820B7E8;
	Tue,  1 Apr 2025 15:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRdqBRaf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC30B20B1F6;
	Tue,  1 Apr 2025 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743521314; cv=none; b=lp4Hm31JKxyLIgybA3Bg/FQV9yHN9u6pgh8CeKMEk81jiXuk5ZeW2hdvTGI4dPzqAyjgMMkxmS6nuYhByYe1DJ+Uco4t0pI8K9mg4Ithw+tl+Uq7n1SD5UdW4C+GlUYGeTbw2jzc007zc1RaZGc2PtOb052uoVjRHR2Kf7oBhTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743521314; c=relaxed/simple;
	bh=T4m/nE01qegpsGCiEFUIyekp61gi9JebQvkw81pCVdU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hh/hbPavVbZEwNxwl8cTlUSceqY3D8UX28tjUk8kT1Nn1h9fPIp5MdVeLiNsU1Xm9BcABIL2DSx/h0DLsSQ6188uIHp4yylKPzv7XKrzjCR6AHFMztPA53nmH4qUBYEYdGnstVTGT2+xx0f/zpjQDFuz4J95zs7EVSbM7UtaNlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRdqBRaf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22403cbb47fso119044645ad.0;
        Tue, 01 Apr 2025 08:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743521312; x=1744126112; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QWoRQ0u8OSafzgnHjL0rkdECIXv/ii6wOIMSgWZzu/A=;
        b=PRdqBRafpJLvRzyafs9IKU+VS/aVBajIMF2TvJL8JaAMEvz1ab0FJpuQOG6my3JVdb
         UJ5BYfVg5NOSyEqYbpxQz0WmlsnFas4cWvLgYHbzCxnBBWRAgALBJk8wo3eJIpZQYzgF
         +RDY9CGXCgJ5tQV8DDtlW62xms+Lg1bGSzHFbNf+KGmzBRvkfu9LfjO6O4b52BDEH7xT
         K4kcEiIau+Gn1CCpdyjEyUbCuYqdvrvqgKJWXI/LBH7SMu3gOPXHEkb2MV4xTNQb+BQp
         ffOa2xKd0wMLyx5cfzvw+JrxsBhfOQgKKgrPnzOwfA0b/d4vDu11Ju6QUqbb9JgdnT2E
         QIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743521312; x=1744126112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QWoRQ0u8OSafzgnHjL0rkdECIXv/ii6wOIMSgWZzu/A=;
        b=Lx+D28VkcqAad0DkG11PaH8s6/iQffAcWKNJC0oHNEn3BVd6r20N3wkxP8ECEXP/JX
         G60os9SGHJnGOOSzZ2zNZd9EoCcs6fuTrko0pz9ItrS4tUFGyiaGf7kZFK2pzTolKEgo
         Vw6lFpmEmpPuzR4i0W382gyQ18wfLD/t3foLCIsQha9tF/qaHU6ueBerhdznbdhX9V80
         b7C9dvYrOt/MRjxcYIC0udtRVpwrKNyUcZiJLmA6gj2byqLrt74mDlLgawtVV+nF66hn
         3bwyGqv3rhDgQAkACd3Bp5ss1HtEb0ZoZV+4/ZpX9M5Nk6LN9UJUjDBd45yXnxO0rumL
         bL6A==
X-Forwarded-Encrypted: i=1; AJvYcCV/u55dpKP0W4NwBfI4eYxI6gTmq01RgTtCngEbtKZvW2X52bnGwZ5Qr7xebUSDyc9/yESDb+sH@vger.kernel.org, AJvYcCVLCErhhJIx4J1CgonuK3y515+oxGVTmWakHba5R7siUoio7dXa6RuINHV1/MMtOiaAKLIHK5kZ9/CYcro=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyaDam9koRuotUGD4WlQgf8+ACdpYTQkjXFkLgcrAck2ieDvRl
	AWJU4bWHlfaoOPRpLTEKdDgeeNuOA6UU26K+PNiZuGJXZHiZaQT4hK2SUw==
X-Gm-Gg: ASbGncvUXOlWsM8leolAnTthtdFkPAeFSyU35PxjfQzmaygK7hi2kU3RWfjM983IpaU
	6g3JA9y5mSy87BVkKWpoQiVl8HdzLK1/vxwh3UMIZGelTx+/v/jqrhyqa2vcPiJ4TC/hkgRPEGw
	xo9J+BSQuwAzbHIzM2bWOWd7ZCx08yGGPeQ0jH8Y5chWessgzy7cJvs3ZJEppF9fGnVijMcYwE5
	I2Rh71Y9uNUQWGnN4bF6q18iZgXgiOWlTwEl36gDXKiBpo36VslPuMH4wnbACjfMHCvJ/wweqni
	PZ0haT0Y0omSQni9EphfOaSYUnLipGhQQ92MOf0V5iw/AE92E0MP5iqUbg6LNb6sxq4X5ZG2e1c
	AsxM0DgPY5PW3FdqOocB8KQsj
X-Google-Smtp-Source: AGHT+IEoyq6eWRZ10eRzbU6lc1mU8jyJ+JmDPIL8wHVPlaY78fQ2mYq34IsqtsHOAz3s29OhpbqapQ==
X-Received: by 2002:a17:902:f549:b0:224:a74:28cd with SMTP id d9443c01a7336-2292f9767camr203073785ad.31.1743521311689;
        Tue, 01 Apr 2025 08:28:31 -0700 (PDT)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2291f1f7cc2sm89178845ad.258.2025.04.01.08.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 08:28:31 -0700 (PDT)
Message-ID: <3517cb7b3b10c29a6bf407f2e35fdebaf7a271e3.camel@gmail.com>
Subject: Re: [PATCH net-next v5 09/13] net: phylink: Use phy_caps_lookup for
 fixed-link configuration
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,  thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org,  Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>,  =?ISO-8859-1?Q?K=F6ry?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Simon Horman <horms@kernel.org>, Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 01 Apr 2025 08:28:29 -0700
In-Reply-To: <20250331091449.155e14a4@fedora-2.home>
References: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
	 <20250307173611.129125-10-maxime.chevallier@bootlin.com>
	 <8d3a9c9bb76b1c6bc27d2bd01f4831b2cac83f7f.camel@gmail.com>
	 <20250328090621.2d0b3665@fedora-2.home>
	 <CAKgT0Ue_JzmJAPKBhe6XaMkDCy+YNNg5_5VvzOR6CCbqcaQg3Q@mail.gmail.com>
	 <20250331091449.155e14a4@fedora-2.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-03-31 at 09:14 +0200, Maxime Chevallier wrote:
> On Fri, 28 Mar 2025 14:03:54 -0700
> Alexander Duyck <alexander.duyck@gmail.com> wrote:
>=20
> > On Fri, Mar 28, 2025 at 1:06=E2=80=AFAM Maxime Chevallier
> > <maxime.chevallier@bootlin.com> wrote:
> > >=20
> > > On Thu, 27 Mar 2025 18:16:00 -0700
> > > Alexander H Duyck <alexander.duyck@gmail.com> wrote:
> > > =20
> > > > On Fri, 2025-03-07 at 18:36 +0100, Maxime Chevallier wrote: =20
> > > > > When phylink creates a fixed-link configuration, it finds a match=
ing
> > > > > linkmode to set as the advertised, lp_advertising and supported m=
odes
> > > > > based on the speed and duplex of the fixed link.
> > > > >=20
> > > > > Use the newly introduced phy_caps_lookup to get these modes inste=
ad of
> > > > > phy_lookup_settings(). This has the side effect that the matched
> > > > > settings and configured linkmodes may now contain several linkmod=
es (the
> > > > > intersection of supported linkmodes from the phylink settings and=
 the
> > > > > linkmodes that match speed/duplex) instead of the one from
> > > > > phy_lookup_settings().
> > > > >=20
> > > > > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > > > > ---
> > > > >  drivers/net/phy/phylink.c | 44 +++++++++++++++++++++++++++------=
------
> > > > >  1 file changed, 31 insertions(+), 13 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.=
c
> > > > > index cf9f019382ad..8e2b7d647a92 100644
> > > > > --- a/drivers/net/phy/phylink.c
> > > > > +++ b/drivers/net/phy/phylink.c
> > > > > @@ -802,12 +802,26 @@ static int phylink_validate(struct phylink =
*pl, unsigned long *supported,
> > > > >     return phylink_validate_mac_and_pcs(pl, supported, state);
> > > > >  }
> > > > >=20
> > > > > +static void phylink_fill_fixedlink_supported(unsigned long *supp=
orted)
> > > > > +{
> > > > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, supporte=
d);
> > > > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, supporte=
d);
> > > > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, support=
ed);
> > > > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, support=
ed);
> > > > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, suppor=
ted);
> > > > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, suppor=
ted);
> > > > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, suppor=
ted);
> > > > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, suppor=
ted);
> > > > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, suppo=
rted);
> > > > > +}
> > > > > + =20
> > > >=20
> > > > Any chance we can go with a different route here than just locking
> > > > fixed mode to being only for BaseT configurations?
> > > >=20
> > > > I am currently working on getting the fbnic driver up and running a=
nd I
> > > > am using fixed-link mode as a crutch until I can finish up enabling
> > > > QSFP module support for phylink and this just knocked out the suppo=
rted
> > > > link modes as I was using 25CR, 50CR, 50CR2, and 100CR2.
> > > >=20
> > > > Seems like this should really be something handled by some sort of
> > > > validation function rather than just forcing all devices using fixe=
d
> > > > link to assume that they are BaseT. I know in our direct attached
> > > > copper case we aren't running autoneg so that plan was to use fixed
> > > > link until we can add more flexibility by getting QSFP support goin=
g. =20
> > >=20
> > > These baseT mode were for compatibility with the previous way to deal
> > > with fixed links, but we can extend what's being report above 10G wit=
h
> > > other modes. Indeed the above code unnecessarily restricts the
> > > linkmodes. Can you tell me if the following patch works for you ?
> > >=20
> > > Maxime
> > >=20
> > > -----------
> > >=20
> > > From 595888afb23f209f2b1002d0b0406380195d53c1 Mon Sep 17 00:00:00 200=
1
> > > From: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > > Date: Fri, 28 Mar 2025 08:53:00 +0100
> > > Subject: [PATCH] net: phylink: Allow fixed-link registration above 10=
G
> > >=20
> > > The blamed commit introduced a helper to keep the linkmodes reported =
by
> > > fixed links identical to what they were before phy_caps. This means
> > > filtering linkmodes only to report BaseT modes.
> > >=20
> > > Doing so, it also filtered out any linkmode above 10G. Reinstate the
> > > reporting of linkmodes above 10G, where we report any linkmodes that
> > > exist at these speeds.
> > >=20
> > > Reported-by: Alexander H Duyck <alexander.duyck@gmail.com>
> > > Closes: https://lore.kernel.org/netdev/8d3a9c9bb76b1c6bc27d2bd01f4831=
b2cac83f7f.camel@gmail.com/
> > > Fixes: de7d3f87be3c ("net: phylink: Use phy_caps_lookup for fixed-lin=
k configuration")
> > > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > > ---
> > >  drivers/net/phy/phylink.c | 17 +++++++++++++----
> > >  1 file changed, 13 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> > > index 69ca765485db..de90fed9c207 100644
> > > --- a/drivers/net/phy/phylink.c
> > > +++ b/drivers/net/phy/phylink.c
> > > @@ -715,16 +715,25 @@ static int phylink_parse_fixedlink(struct phyli=
nk *pl,
> > >                 phylink_warn(pl, "fixed link specifies half duplex fo=
r %dMbps link?\n",
> > >                              pl->link_config.speed);
> > >=20
> > > -       linkmode_zero(pl->supported);
> > > -       phylink_fill_fixedlink_supported(pl->supported);
> > > +       linkmode_fill(pl->supported);
> > >=20
> > >         linkmode_copy(pl->link_config.advertising, pl->supported);
> > >         phylink_validate(pl, pl->supported, &pl->link_config);
> > >=20
> > > +       phylink_fill_fixedlink_supported(match);
> > > + =20
> >=20
> > I worry that this might put you back into the same problem again with
> > the older drivers. In addition it is filling in modes that shouldn't
> > be present after the validation.
>=20
> Note that I'm not directly filling pl->supported here.
>=20
> [...]
>=20
>  	c =3D phy_caps_lookup(pl->link_config.speed, pl->link_config.duplex,
>  			    pl->supported, true);
> -	if (c)
> -		linkmode_and(match, pl->supported, c->linkmodes);
> +	if (c) {
> +		/* Compatbility with the legacy behaviour : Report one single
> +		 * BaseT mode for fixed-link speeds under or at 10G, or all
> +		 * linkmodes at the speed/duplex for speeds over 10G
> +		 */
> +		if (linkmode_intersects(match, c->linkmodes))
> +			linkmode_and(match, match, c->linkmodes);
> +		else
> +			linkmode_copy(match, c->linkmodes);
> +	}
>=20
> [...]
>=20
> 	if (c) {
> 		linkmode_or(pl->supported, pl->supported, match);
> 		linkmode_or(pl->link_config.lp_advertising,
> 			    pl->link_config.lp_advertising, match);
> 	}
>=20
> For speeds above 10G, you will get all the modes for the requested
> speed, so it should solve the issue in the next steps of your code
> where you need matching linkmodes for your settings ? Did you give it a
> try ?
>=20
> You may end up with too many linkmodes, but for fixed-link we don't
> really expect these modes to precisely represent any real linkmodes

Here is more the quick-n-dirty approach that I think does what you were
trying to do without breaking stuff:

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 16a1f31f0091..380e51c5bdaa 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -713,17 +713,24 @@ static int phylink_parse_fixedlink(struct phylink *pl=
,
                phylink_warn(pl, "fixed link specifies half duplex for %dMb=
ps link?\n",
                             pl->link_config.speed);
=20
-       linkmode_zero(pl->supported);
-       phylink_fill_fixedlink_supported(pl->supported);
-
+       linkmode_fill(pl->supported);
        linkmode_copy(pl->link_config.advertising, pl->supported);
        phylink_validate(pl, pl->supported, &pl->link_config);
=20
        c =3D phy_caps_lookup(pl->link_config.speed, pl->link_config.duplex=
,
                            pl->supported, true);
-       if (c)
+       if (c) {
                linkmode_and(match, pl->supported, c->linkmodes);
=20
+               /* Compatbility with the legacy behaviour:
+                * Report one single BaseT mode.
+                */
+               phylink_fill_fixedlink_supported(mask);
+               if (linkmode_intersects(match, mask))
+                       linkmode_and(match, match, mask);
+               linkmode_zero(mask);
+       }
+
        linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, mask);
        linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, mask);
        linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, mask);

Basically we still need the value to be screened by the pl->supported.
The one change is that we have to run the extra screening on the
intersect instead of skipping the screening, or doing it before we even
start providing bits.

With this approach we will even allow people to use non twisted pair
setups regardless of speed as long as they don't provide any twisted
pair modes in the standard set.

I will try to get this tested today and if it works out I will submit
it for net. I just need to test this and an SFP ksettings_set issue I
found when we aren't using autoneg.

