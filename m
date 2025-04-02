Return-Path: <netdev+bounces-178907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A21A79848
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 00:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B1C170587
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 22:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D3C1F429C;
	Wed,  2 Apr 2025 22:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKv+7Qf6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E033B5BAF0
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 22:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743633325; cv=none; b=FmH8WplbNa5yqe0AcEgQa5e26S8ZyDysvJfJ+iscPdnfNiJJyGRSeaTYj7JcBFoYVkGH1fdOjF2AmKNty55vbGBm3efSF3S6OcDWdpOpjlP+r5qV1cha9Rq2IttC9SgYBoqVy1oYgw3e7jERkqJOALAp4V74UwLaIvoUwK61Uos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743633325; c=relaxed/simple;
	bh=DLxh5MuIyvhh7m6X1g/tBz06mB0DgFyjvKM7GfEPd9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHG4JCP/TjLJperMVaSUJmwE7CJBEr5COeSk4R1Pt0M49qZdMFNPu0Z6ba4c3UQZOYP+eSLFmFI0Dq1bsFAAXj2HopAefgqT7hR6iMmdObXpB9rzlxR1Rw+8sGHZqxQY750gfq/2MWmJH2W9t3KDxI7vSsadmQL3u/Q9dNuXxUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKv+7Qf6; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c0e0bc733so248456f8f.1
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 15:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743633322; x=1744238122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7u/lILhCVe7tBDSsAyhX8mHkwtrqrjms7ES/Xq1B1gY=;
        b=CKv+7Qf6aeYkD+/SUQPmWjsWgO5KbkgAbzk+3+uJmX2o5XKZY/kLNMOyUgw2EDFaMu
         Q1Jx6pNRqbpnsOMuSkrkwd5q0icacyAwOn+RaFhMtBS8x19JphI0uvUdvIz4g8HsEdAQ
         N70W+/hWQoxTX0MLgt2EgW4yFSDWc2hDiS6mGnilX5U7LlB5lygzUtXoQCJhJd3qogVA
         15SX0R5IfFuMa0TduAlvYANfkqVV6uVJN1sq8hD1ReZOLxaWNIy6fOjYWrugXZGsEzvk
         Co7V5+pDzr6p19Xr/UlnjxPw2yG2Wnkdk2rSr6B3WjKAW6hrHg/MlgHmilpecTeX6wq4
         MkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743633322; x=1744238122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7u/lILhCVe7tBDSsAyhX8mHkwtrqrjms7ES/Xq1B1gY=;
        b=Slw6qvkmWIp4z767OGbCvRq1CsrJtEp7oimAhNXzWV/1KAatykiAVJ3gQRYLs/1OJ+
         waRIePjX863EkuufHzAgCvOAkfDkLQeyRWc58Wo5cL+eWXLFO3nQFWlPDSnOHSyuqupy
         BBXJZVl3uL6RwGrgE2/1tnz/XHaBLaIy43C+KM84ZNEiTb33Qvk042K3LUEcK1Yzc+BN
         wgL1xdXNSGsHiaHwTW4GFCViJ5jgOmfHayENHA15r7MgSA9abnZ8I9X+7KOjRGOpLfXn
         QUPm3nhOvLJdqy2m1TQaXPhrTA6UZOcvpuQcP7Y9dilX7VAR1aVmGbB5mrxOwRKebo3A
         V8CQ==
X-Gm-Message-State: AOJu0Yybswj+AX4SqCir8437MBcHzLdJOx9tjrL159FvZmlH2FYPBnFo
	8ce/I/Q4gqfJv/ZXuYHlTp5mmWRLE4JCUCXG12gVxRLQ56hVwvvfnCXdLejs+/VO9uUwtFXDHSq
	+eR2DiWI/g54PwY+kXLUjhcfDlrY=
X-Gm-Gg: ASbGncviLxFQvYvDbz3F2TPFRhuk01mm+CbbHr+3RNR5xAkAl6ejXABvfCGn4b+IGCm
	pOQCuCL9h11Vt8GVeaaisW2rhdq5ze256QcQp3yrYU1FPfP9C0CnOoQaXSAOm9FgCwr1DulWRgO
	e7+YoqyTqYheOjyO77Wdx3TIdDCaAh9p09DTGjlo1TL7Qh77h+bm26m1VfMg4=
X-Google-Smtp-Source: AGHT+IGRL2TwWz5ZQWBv+fazHAVWwUtGiI2y8l2mAZDjq3q6MulT1To7PwOC3v9Wfmpj4hZZm1uQaUZL1RY6uwAMJt0=
X-Received: by 2002:a05:6000:184e:b0:391:a43:8bbd with SMTP id
 ffacd0b85a97d-39c2f8dc719mr273720f8f.21.1743633322031; Wed, 02 Apr 2025
 15:35:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174354264451.26800.7305550288043017625.stgit@ahduyck-xeon-server.home.arpa>
 <174354301312.26800.4565150748823347100.stgit@ahduyck-xeon-server.home.arpa> <Z-17nu2epjG1EiAd@shell.armlinux.org.uk>
In-Reply-To: <Z-17nu2epjG1EiAd@shell.armlinux.org.uk>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 2 Apr 2025 15:34:45 -0700
X-Gm-Features: AQ5f1Jonorizg6vbcyGy3bzmvNuGNHP9B6G6UAwlpfHpBMI1lPCOG71iWPxCxWI
Message-ID: <CAKgT0UfyhFXWRAsW_i3GRQmY-RprruU7gXb8f=-J_5kvRQEMBA@mail.gmail.com>
Subject: Re: [net PATCH 2/2] net: phylink: Set advertising based on
 phy_lookup_setting in ksettings_set
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	maxime.chevallier@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 11:02=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Tue, Apr 01, 2025 at 02:30:13PM -0700, Alexander Duyck wrote:
> > From: Alexander Duyck <alexanderduyck@fb.com>
> >
> > While testing a driver that supports mulitple speeds on the same SFP mo=
dule
> > I noticed I wasn't able to change them when I was not using
> > autonegotiation. I would attempt to update the speed, but it had no eff=
ect.
> >
> > A bit of digging led me to the fact that we weren't updating the advert=
ised
> > link mask and as a result the interface wasn't being updated when I
> > requested an updated speed. This change makes it so that we apply the s=
peed
> > from the phy settings to the config.advertised following a behavior sim=
ilar
> > to what we already do when setting up a fixed-link.
> >
> > Fixes: ea269a6f7207 ("net: phylink: Update SFP selected interface on ad=
vertising changes")
> > Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> > ---
> >  drivers/net/phy/phylink.c |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> > index 380e51c5bdaa..f561a803e5ce 100644
> > --- a/drivers/net/phy/phylink.c
> > +++ b/drivers/net/phy/phylink.c
> > @@ -2763,6 +2763,7 @@ int phylink_ethtool_ksettings_set(struct phylink =
*pl,
> >
> >               config.speed =3D c->speed;
> >               config.duplex =3D c->duplex;
> > +             linkmode_and(config.advertising, c->linkmodes, pl->suppor=
ted);
>
> I had thought that ethtool provided an appropriate advertising mask
> when aneg is disabled, but it just preserves the old mask, which seems
> to be the intended behaviour (if one looks at phylib, that's also what
> happens there.) We should not deviate from that with a user API.
>
> So, I would like to change how this works somewhat to avoid a user
> visible change. Also, interface mode changing on AUTONEG_DISABLED was
> never intended to work. Indeed, mvneta and mvpp2 don't support
> AUTONEG_DISABLED for 1000BASE-X nor 2500BASE-X which is where this
> interface switching was implemented (for switching between these two.)
>
> I've already got rid of the phylink_sfp_select_interface() usage when
> a module is inserted (see phylink_sfp_config_optical(), where we base
> the interface selection off interface support masks there rather than
> advertisements - it used to be advertisements.)
>
> We now have phylink_interface_max_speed() which gives the speed of
> the interface, which gives us the possibility of doing something
> like this for the AUTONEG_DISABLE state:
>
>         phy_interface_and(interfaces, pl->config->supported_interfaces,
>                           pl->sfp_interfaces);



>         best_speed =3D SPEED_UNKNOWN;
>         best_interface =3D PHY_INTERFACE_MODE_NA;
>
>         for_each_set_bit(interface, interfaces, __ETHTOOL_LINK_MODE_MASK_=
NBITS) {
>                 max_speed =3D phylink_interface_max_speed(interface);
>                 if (max_speed < config.speed)
>                         continue;
>                 if (max_speed =3D=3D config.speed)
>                         return interface;
>                 if (best_speed =3D=3D SPEED_UNKNOWN ||
>                     max_speed < best_speed) {
>                         best_speed =3D max_speed;
>                         best_interface =3D interface;
>                 }
>         }
>
>         return best_interface;
>
> to select the interface from aneg-disabled state.
>
> Do you think that would work for you?

That should work. The only case where it might get iffy would be a
QSFP-DD cable that supported both NRZ and PAM4. In that case we might
get a 50R1 when we are expecting a 50R2. However that is kind of a
problem throughout with all the pure speed/duplex checks. The only way
to get around that would be to add a new check for lanes to kind of
take the place of duplex as we would need to also have the lanes
match.

