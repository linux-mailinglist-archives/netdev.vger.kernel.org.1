Return-Path: <netdev+bounces-178444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D42A770D2
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 00:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32B9188BDC9
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 22:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD12921B9CF;
	Mon, 31 Mar 2025 22:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fL/Swizj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E076742A94;
	Mon, 31 Mar 2025 22:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743459602; cv=none; b=UzKQJ45/qKihhMNE0d2DlOipYozkmpWMG6vLws6NLRRAF9vChIuhnT674jqLnF+N+125Md9CTjWy6Fd8E7f5+GNuzGJa6V1v1m33y9yo0AR7tiHxhVw3MhdEQiDedpewrPlNYB2lOXwK1kGqAyRXM2/9oYYa6HZEWL8NFgOXhZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743459602; c=relaxed/simple;
	bh=6Imi+mj6K0Ur5HmqiOzqPpY5VuUrlHSMhZMS4R6+nSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YmxzzIWmlNMsaru5Kny3rlKB6rvcYSaD1d8fykBtoxYrnHq852bzgRUXL3qrEeL+vLp1WaBIQktFki5kXm384lavYmBWCk3/wsGly2oEUqvzRU1/LZBWsAxoAZtUF2uCij3p32coQAXAfA6IdD0p2VQ1ER/Wz4KIUgh6WdY9LAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fL/Swizj; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c0e0bc733so2454915f8f.1;
        Mon, 31 Mar 2025 15:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743459599; x=1744064399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+hSR1+tIbx5yMHcV2MZCy95L6aErMxELApRXynVAjg=;
        b=fL/SwizjMfW0NmLG8kUirG28IRChM7w+Wa/FmxfFHZ/qT0tD0yzbtwzL0kdgROtczA
         vQ7TF2fdUJXHv91lnP0TtoMabBEKeGx1GtOo0Yup2oPCbVrlw7wgkBdFaG9Sqod6jli7
         80gFlMD7ZBpqxJgRGkydhoRBNzmTcpg2Mno9Kg8mKhSWj93tRRH5J+O5Kap/QXuLhp2i
         /OgjJ23FsBkrU/Am4bCK1vwDbCsrvTIVe5lw/iID7rHx1i3xAwEUm2ZHoL55oV5yunTR
         k4RF1g5melvdYk/5FUWYO+rpC0nxv9x074fHHKagj0PDY04rcu8nYAA6grKBmlL0QyEw
         g7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743459599; x=1744064399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+hSR1+tIbx5yMHcV2MZCy95L6aErMxELApRXynVAjg=;
        b=S/RdeawxSM2/Ic5uAmCTnT8jf27eKgs88zAwYBvAWN0j86r7TaD9AnEHyA3nL1vW2V
         XcStewyHGAsW+ny31EOfiHBKtXJR2cPMRwHb5GDuJCo4PRFWjDldOw5BbqPwkmviAm9S
         LZsQGhyA4YGtB4VcmUdGd+QQWEkx64S2TVoi8zm3kB4IBDM6ijiUiQkmWPLppKn9SkEB
         w0guGaYvoh9QjTF+ZQs8EMXXXsPDoHj/dewO7Ba9Q+f1sKHR1h1c4PFhBDsfoGEL1jC8
         Tv3X4f/313IasP1rDzNEjftWWkmsI3h4p6CY87z5qBgFlIflaw5iXg0Rwu9lkMQU2xJ4
         idNw==
X-Forwarded-Encrypted: i=1; AJvYcCX/KIKQHvMmnoo/URt7InBvIgUyTFdnactCEXsZTyTnHvqdspPffjpGZ4zqiAvGzskoPFjTGIm9Pd0Ai3w=@vger.kernel.org, AJvYcCXAigFtG/jCn3O3igbrlaI1kCAuLgHGe9MezoDyMujPr/cIHCN9MCia99KulP3WTjaXJopWVeNV@vger.kernel.org
X-Gm-Message-State: AOJu0YxvXfFLYXFjOddjPMAdUGgSehqGjURatMKX+tPZlZdI40aaxR9T
	YYCjvbgZVWkoHlI+c0BGG0APJGf0x3raNhEiCj0NYSfu9rz2jOBENd4SWee4gpXwXU0V9iu+wVM
	oGVVaxzmThMW2Ygd+C2HIcB8FG+U=
X-Gm-Gg: ASbGncsf2UEvhp621mAOV85TBLjK0nDXL7TqZo4RpDfRs/YxMEB/TsdcVw/xuiEX3jZ
	2JucOrQvPDpTeGZv+2VhoSnLHFs+Z3K6SFkZ7yetIurdOPMg75K+zH7GyqMmqZcYoQgB18Q5gHS
	skvwjoBWPQ8zljgLcIcl8p2P4Z3ZBaODHWneAmyUpLG4BNeodmTdf1C2ICFEY=
X-Google-Smtp-Source: AGHT+IFgSysh56KurewSd3Nk/bNUGW3qwrcRPIQP/JUmaMtg6PyNAGFcsjnPPM0EApLH1ebhQAo8saKc84XBpk9ytY0=
X-Received: by 2002:a05:6000:2405:b0:39c:140b:feec with SMTP id
 ffacd0b85a97d-39c140bff36mr6815630f8f.7.1743459598932; Mon, 31 Mar 2025
 15:19:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
 <20250307173611.129125-10-maxime.chevallier@bootlin.com> <8d3a9c9bb76b1c6bc27d2bd01f4831b2cac83f7f.camel@gmail.com>
 <Z-qPs7y8C09xh5_b@shell.armlinux.org.uk>
In-Reply-To: <Z-qPs7y8C09xh5_b@shell.armlinux.org.uk>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 31 Mar 2025 15:19:22 -0700
X-Gm-Features: AQ5f1JoSBA9-etYU7M7NADKlb-o6h_I8MawO0ZvLruH8CUNhEKhc15qJBi4pe_E
Message-ID: <CAKgT0Ud1ZRBiaDGzHmgWWNjZgGHTbcGUNFzftD3e0ndy2E9nyw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 09/13] net: phylink: Use phy_caps_lookup for
 fixed-link configuration
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net, 
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, 
	linux-arm-kernel@lists.infradead.org, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	=?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Simon Horman <horms@kernel.org>, 
	Romain Gantois <romain.gantois@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 5:51=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Mar 27, 2025 at 06:16:00PM -0700, Alexander H Duyck wrote:
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
> Please look back at phylink's historical behaviour. Phylink used to
> use phy_lookup_setting() to locate the linkmode for the speed and
> duplex. That is the behaviour that we should be aiming to preserve.
>
> We were getting:
>
> speed   duplex  linkmode
> 10M     Half    10baseT_Half
> 10M     Full    10baseT_Full
> 100M    Half    100baseT_Half
> 100M    Full    100baseT_Full
> 1G      Half    1000baseT_Half
> 1G      Full    1000baseT_Full (this changed over time)
> 2.5G    Full    2500baseT_Full
> 5G      Full    5000baseT_Full
>
> At this point, things get weird because of the way linkmodes were
> added, as we return the _first_ match. Before commit 3c6b59d6f07c
> ("net: phy: Add more link modes to the settings table"):
>
> 10G     Full    10000baseKR_Full
> Faster speeds not supported
>
> After the commit:
> 10G     Full    10000baseCR_Full
> 20G     Full    20000baseKR2_Full
> 25G     Full    25000baseCR_Full
> 40G     Full    40000baseCR4_Full
> 50G     Full    50000baseCR2_Full
> 56G     Full    56000baseCR4_Full
> 100G    Full    100000baseCR4_Full
>
> It's all a bit random. :(

I agree. I was using pcs_validate to overcome some of that by limiting
myself to *mostly* one link type at each speed. The only spot that got
a bit iffy was the 50G as I support 50GAUI and LAUI-2. I was
overcoming that by tracking the number of lanes expected and filtering
for one or the other.

One thought I had proposed in another email was to look at adding more
data to the fields. In the case of duplex we could overload it to also
be the number of lanes as they represent full duplex lanes anyway.
With that you could sort out some of the CR vs CR2 noise.

In addition I wonder if we shouldn't also look at including port type
in the data. Using that you could essentially go through the
post-validated supported values and OR in the types that belong to the
various link modes for TP, FIBER, DA, ect. That would sort out some of
the KR vs CR vs SR vs LR noise.

