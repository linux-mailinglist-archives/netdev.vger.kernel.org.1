Return-Path: <netdev+bounces-179194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45022A7B1B0
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27B51888A31
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 21:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BAF18CBFB;
	Thu,  3 Apr 2025 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAP5Bksl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655A316F0FE
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 21:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743717243; cv=none; b=hcaB5FxvoMKoz/9zyt0vXGVS2m64gAUfdSD5RQ0OMZeh9DIM1AqF4rsXcjSzAAFhn3/UA4VDBIPyxpRM14ZIu9ohyzRJtuRGpRojXiEvsV73fo3ROekbwk4gAnAUVH8Vp+YINUDcgj6ppnhZtCIeHQyyGomexFdHTBz4GMX7S6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743717243; c=relaxed/simple;
	bh=Urd33bxq1a5stv1Pb/vT/2rG2h6Ysukr/iGwX1XqmEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJ8AGBI7+rYtaNWap1o8UiCRRJnU45VR6k4wbvwrOqjPMluBKIydaIjg5qdMtDh/Bp6fx8ZI9r9N6lFgVVRVO5tUbEf602xNZh++9jUalpcjH9rSxKcIiuHi8CSOzbRtGGSbOOv870EQyEhoIYGtSGjqXAGj8o+iw/sUhVPfz+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAP5Bksl; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso1599924f8f.1
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 14:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743717239; x=1744322039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWJQ445Ouv7UcpvFzboL1nD7c8uYnY2ecoKz1+J6Jbk=;
        b=fAP5BkslGnqAC0xOjxfeswymMeLUCAo1gRjJFxe1pw8TN1wFa3COnE9Wrkefakzz6P
         9UcwliXJfaGpsBwZ1it3SLMeHNQLOHejs0WX/71jiSRwiRos5ofOHKipCOAU1ikWfM7R
         dAIOxQf2mLgJg+VVTwLJZnhJkkwrqw4djNZzVqiD8J7xUGl/tQm8AM9b05Auis0q+iOV
         awN+vkplzwZCff1mTOjrQRAh2AtSaqBsJm9itdJjS6wgahlNjbKdaTdPKk1lquIuNYID
         BltgywhkQlQHU027uJkXfo9+dhj5VzQaCqE1BZvWoKhZskcKNJlLiFNba02UXzE4BTA2
         ircg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743717239; x=1744322039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWJQ445Ouv7UcpvFzboL1nD7c8uYnY2ecoKz1+J6Jbk=;
        b=NYkTcucKM4vONmCnOZlXH7I37twIESGhKzpZZuOJUIMvGEQ+mUoGg9DiE9ilhWxoYh
         GmiN7ruL+5shJizFKdS1uHdKHY/uzzuq5wg4ue4h6HbMjX82FPRoBTib3Ymfdu57iSGK
         YM3fCcyJS0QQYom1g9m8cCKcuKQkv92XJzMvrAaUguQFQbJKHijc4Ob+iRwkxuCdZTHL
         kKxZfg1eIKnoBr4D/32S6rsTDO37K+QagVLUSb+NPF4oc+mCa0oK5EV4tSCS4MpWMiw4
         1rT8LHPznLh39/500nIFiuJX/OIZMRmoBOT/GIU0p0um5K1nDch5qCeyWwrJ9+rfppf9
         ot1w==
X-Forwarded-Encrypted: i=1; AJvYcCWq/DYFJoYMML4YJ256fawFccYp6otOd9E6Tdxh9kMyHk4fumhfvK0K+G7387loMM0gy0exygc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUTyTVutFUC9huTJQm00MdFTeMFbihPCx73ScgMY41KcgPwvjW
	8x0nZRgKUQMA+XJjHiK0PwdqfPzW/8bIBZwanb+UyYQV7eRblG2szvKPzxubpZ9tn4EoqGTEBEr
	FNfFFAVdBLWi3bjKKGSO8JuxRkDw=
X-Gm-Gg: ASbGnctdh0V4TMgmhNXK0dSI1feVxSup+6dNrctpv48FcJWgJFz0TNQBz5/wdsqB3WT
	WxNScBY1y96eMHVSlfaQ/6foyp0v7P66XXOECASOirTiTm+abOtAVmgESwDoyaPvmZbJJHGv8wo
	ytUZVonoVdAq0pVhoOUBEXzoCI+aK3x/RLaZv7i2DymfLJJwt4GhQwnuUdRys=
X-Google-Smtp-Source: AGHT+IGbCVKr8IL3kwtYKeE0K5X6jm1zWrjcqGJg3ccOS83gQIwvQbocyx0AkI+m1WB3agXV/N68jnRfZ4RFlHjg+xI=
X-Received: by 2002:a05:6000:40cd:b0:390:dec3:2780 with SMTP id
 ffacd0b85a97d-39cba94d1eemr809536f8f.24.1743717239365; Thu, 03 Apr 2025
 14:53:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174354264451.26800.7305550288043017625.stgit@ahduyck-xeon-server.home.arpa>
 <174354300640.26800.16674542763242575337.stgit@ahduyck-xeon-server.home.arpa>
 <Z-6hcQGI8tgshtMP@shell.armlinux.org.uk> <20250403172953.5da50762@fedora.home>
 <de19e9f1-4ae3-4193-981c-e366c243352d@lunn.ch>
In-Reply-To: <de19e9f1-4ae3-4193-981c-e366c243352d@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 3 Apr 2025 14:53:22 -0700
X-Gm-Features: ATxdqUHs_Q2OmWzFMALS0im0OxYzDGd54IUX_-Rq-Q4v4WyWZpZVVIZCUHX_3OE
Message-ID: <CAKgT0UdhTT=g+ODpzR5uoTEOkC8u+cfCp7H-8718Zphd=24buw@mail.gmail.com>
Subject: Re: [net PATCH 1/2] net: phy: Cleanup handling of recent changes to phy_lookup_setting
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	"Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org, hkallweit1@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 9:34=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Apr 03, 2025 at 05:29:53PM +0200, Maxime Chevallier wrote:
> > On Thu, 3 Apr 2025 15:55:45 +0100
> > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> >
> > > On Tue, Apr 01, 2025 at 02:30:06PM -0700, Alexander Duyck wrote:
> > > > From: Alexander Duyck <alexanderduyck@fb.com>
> > > >
> > > > The blamed commit introduced an issue where it was limiting the lin=
k
> > > > configuration so that we couldn't use fixed-link mode for any setti=
ngs
> > > > other than twisted pair modes 10G or less. As a result this was cau=
sing the
> > > > driver to lose any advertised/lp_advertised/supported modes when se=
tup as a
> > > > fixed link.
> > > >
> > > > To correct this we can add a check to identify if the user is in fa=
ct
> > > > enabling a TP mode and then apply the mask to select only 1 of each=
 speed
> > > > for twisted pair instead of applying this before we know the number=
 of bits
> > > > set.
> > > >
> > > > Fixes: de7d3f87be3c ("net: phylink: Use phy_caps_lookup for fixed-l=
ink configuration")
> > > > Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> > > > ---
> > > >  drivers/net/phy/phylink.c |   15 +++++++++++----
> > > >  1 file changed, 11 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> > > > index 16a1f31f0091..380e51c5bdaa 100644
> > > > --- a/drivers/net/phy/phylink.c
> > > > +++ b/drivers/net/phy/phylink.c
> > > > @@ -713,17 +713,24 @@ static int phylink_parse_fixedlink(struct phy=
link *pl,
> > > >           phylink_warn(pl, "fixed link specifies half duplex for %d=
Mbps link?\n",
> > > >                        pl->link_config.speed);
> > > >
> > > > - linkmode_zero(pl->supported);
> > > > - phylink_fill_fixedlink_supported(pl->supported);
> > > > -
> > > > + linkmode_fill(pl->supported);
> > > >   linkmode_copy(pl->link_config.advertising, pl->supported);
> > > >   phylink_validate(pl, pl->supported, &pl->link_config);
> > > >
> > > >   c =3D phy_caps_lookup(pl->link_config.speed, pl->link_config.dupl=
ex,
> > > >                       pl->supported, true);
> > > > - if (c)
> > > > + if (c) {
> > > >           linkmode_and(match, pl->supported, c->linkmodes);
> > > >
> > > > +         /* Compatbility with the legacy behaviour:
> > > > +          * Report one single BaseT mode.
> > > > +          */
> > > > +         phylink_fill_fixedlink_supported(mask);
> > > > +         if (linkmode_intersects(match, mask))
> > > > +                 linkmode_and(match, match, mask);
> > > > +         linkmode_zero(mask);
> > > > + }
> > > > +
> > >
> > > I'm still wondering about the wiseness of exposing more than one link
> > > mode for something that's supposed to be fixed-link.
> > >
> > > For gigabit fixed links, even if we have:
> > >
> > >     phy-mode =3D "1000base-x";
> > >     speed =3D <1000>;
> > >     full-duplex;
> > >
> > > in DT, we still state to ethtool:
> > >
> > >         Supported link modes:   1000baseT/Full
> > >         Advertised link modes:  1000baseT/Full
> > >         Link partner advertised link modes:  1000baseT/Full
> > >         Link partner advertised auto-negotiation: No
> > >         Speed: 1000Mb/s
> > >         Duplex: Full
> > >         Auto-negotiation: on
> > >
> > > despite it being a 1000base-X link. This is perfectly reasonable,
> > > because of the origins of fixed-links - these existed as a software
> > > emulated baseT PHY no matter what the underlying link was.
> > >
> > > So, is getting the right link mode for the underlying link important
> > > for fixed-links? I don't think it is. Does it make sense to publish
> > > multiple link modes for a fixed-link? I don't think it does, because
> > > if multiple link modes are published, it means that it isn't fixed.
> >
> > That's a good point. The way I saw that was :
> >
> >   "we report all the modes because, being fixed-link, it can be
> >   any of these modes."
> >
> > But I agree with you in that this doesn't show that "this is fixed,
> > don't try to change that, this won't work". So, I do agree with you now=
.
> >
> > > As for arguments about the number of lanes, that's a property of the
> > > PHY_INTERFACE_MODE_xxx. There's a long history of this, e.g. MII/RMII
> > > is effectively a very early illustration of reducing the number of
> > > lanes, yet we don't have separate link modes for these.
> > >
> > > So, I'm still uneasy about this approach.
> >
> > So, how about extending the compat list of "first link of each speed"
> > to all the modes, then once the "mediums" addition from the phy_port
> > lands, we simplify it down the following way :
> >
> > Looking at the current list of elegible fixed-link linkmodes, we have
> > (I'm taking this from one of your mails) :
> >
> > speed duplex  linkmode
> > 10M   Half    10baseT_Half
> > 10M   Full    10baseT_Full
> > 100M  Half    100baseT_Half
> > 100M  Full    100baseT_Full
> > 1G    Half    1000baseT_Half
> > 1G    Full    1000baseT_Full (this changed over time)
> > 2.5G  Full    2500baseT_Full
> > 5G    Full    5000baseT_Full
> > 10G   Full    10000baseCR_Full (used to be 10000baseKR_Full)
> > 20G   Full    20000baseKR2_Full =3D> there's no 20GBaseCR*
> > 25G   Full    25000baseCR_Full
> > 40G   Full    40000baseCR4_Full
> > 50G   Full    50000baseCR2_Full
> > 56G   Full    56000baseCR4_Full
> > 100G  Full    100000baseCR4_Full
> >
> > To avoid maintaining a hardcoded list, we could clearly specifying
> > what we report in fixed-link :
> >
> >  1 : Any BaseT mode for the given speed duplex (BaseT and not BaseT1)
> >  2 : If there's none, Any BaseK mode for that speed/duplex
> >  3 : If there's none, Any BaseC mode for that speed/duplex
> >
> > That's totally arbitrary of course, and if one day someone adds, say,
> > 25GBaseT, fixed-link linkmode will change. Another issue us 10G,
> > 10GBaseT exists, but wasn't the first choice.
>
> Maybe go back to why fixed-link exists? It is basically a hack to make
> MAC configuration easier. It was originally used for MAC to MAC
> connections, e.g. a NIC connected to a switch, without PHYs in the
> middle. By faking a PHY, there was no need to add any special
> configuration API to the MAC, the phylib adjust_link callback would be
> sufficient to tell the MAC to speed and duplex to use. For {R}{G}MII,
> or SGMII, that is all you need to know. The phy-mode told you to
> configure the MAC to MII, GMII, SGMII.

Another issue is that how you would define the connection between the
two endpoints is changing. Maxime is basing his data off of
speed/duplex however to source that he is pulling data from
link_mode_params that is starting to broaden including things like
lanes. I really think going forward lanes is going to start playing a
role as we get into the higher speeds and it is already becoming a
standard config item to use to strip out unsupported modes when
configuring the interface via autoneg.

> But things evolved since then. We started having PHYs which change
> their host side depending on their media side. SGMII for <=3D 1G,
> 2500BaseX, 5GBaseX, 10GBaseX. It became necessary for the adjust_link
> callback to look at more than just the speed/duplex, it also needed to
> look at the phy_interface_t. phy-mode looses its meaning, it might be
> considered the default until we know better.

I am wondering about that. I know I specified we were XLGMII for fbnic
but that has proven problematic since we aren't actually 40G. So we
are still essentially just reporting link up/down using that. That is
why I was looking at going with a fixed mode as I can at least specify
the correct speed duplex for the one speed I am using if I want to use
ethtool_ksettings_get.

I have a patch to add the correct phy_interface_t modes for 50, and
100G links. However one thing I am seeing is that after I set the
initial interface type I cannot change the interface type without the
SFP code added. One thing I was wondering. Should I just ignore the
phy_interface_t on the pcs_config call and use the link mode mask
flags in autoneg and the speed/duplex/lanes in non-autoneg to
configure the link? It seems like that is what the SFP code itself is
doing based on my patch 2 in the set.

> But consider the use case, a hack to allow configuration of a MAC to
> MAC connection. The link mode does not change depending on the media,
> there is no media. The switch will not be changing its port
> configuration. The link really is fixed. phy-mode tells you the basic
> configuration, and then adjust_link/mac_link_up tells you the
> speed/dupex if there are multiple speeds/duplex supported,
> e.g. RGMII/SGMII.
>
> What Alex is trying to do is abuse fixed link for something which is
> not a MAC-MAC connection, something which is not fixed. Do we want to
> support that?

How is it not a fixed link? If anything it was going to be more fixed
than what you described above. In our case the connection type is
indicated by the FW and we aren't meant to change it unless we want to
be without a link. The link goes up and down and that would be about
it. So we essentially advertise one link mode bit and are locked on
the interface configured at creation. I was basically taking that
config from the FW, creating a SW node with it, and then using that to
set up the link w/o permitting changes. The general idea was that I
would use that to limp along until I could get the QSFP support added
and then add support for configuring the link with the
ethtool_ksettings_set call. Mainly we just need that functionality for
our own testing as the production case is non-autoneg fixed links
only.

