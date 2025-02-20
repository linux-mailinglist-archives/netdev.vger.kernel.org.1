Return-Path: <netdev+bounces-167995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7723DA3D1B9
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70C81609D7
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 07:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E1A1E47C9;
	Thu, 20 Feb 2025 07:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DC5JzIsW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277971E3780
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 07:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740035103; cv=none; b=SLMA+h5z8QdDkY/TDMGHB+XAGb3rTLrs8xSdnuWOHSkJIWh6EQ6W6tVLi0W8ea1O1TOzhmCLVexL2Z5qS6tXM2ISr8bWv6eIxelBmhsEUzbihKmfiFgLNCSXFbNe3e5Pzhb/06yDRf/kXEpyt86j7DUTkkBByCC1cT2ATt+y4OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740035103; c=relaxed/simple;
	bh=jhmRkTuagogNXCf1UwCNp0JoZIdMmUF4fLI73vvGbLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AoSBiGY4t0Io5H263fiJZhlH+C5r7I2s/Cut/q8mWZcHobRK5CwnvY4Mbzzn5rO4QNjdDEU7bEo1KwfspQr2n4kg1ZtCLw7cT0mlU0nvdrP3CxABNyC03UJGMYW3vIl7nUbfstOq2awln6LbW9zhMRk8UxjZDUe8Agb8+adA8d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=DC5JzIsW; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e3978c00a5aso492607276.1
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 23:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1740035101; x=1740639901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DqVvsVthq2h4/t7UrH240Bzi+oS8ZW8sparKJnfCVI=;
        b=DC5JzIsWaHx/lwgAi/m9pznMv4TeZSRJNc+6f3uNdAaueaD++8Q8DYsc2vvIQNofiN
         weteGjZJzRaSNyzlD1jq9s0KPf6Zp4+MrNafHVanxVLci/AsKVwlHu5BQmB1/fxKnZV8
         5fTVbnnmY7gbRPvWwwMZ5h+z+r3NZGOmGNn4UXQPVDaayLyXJuym8wTrAs/Foo+WeNy9
         6QUhAf+S80M2GnTZwYoCBPdinjv1xrE0sUr6fVYx4OyK4ZRCAbUHi2EKue4iiLi0ZxPv
         eMmZ+chVPG7gQdkxctWycJjFthRutstJohU7YVWyE3en3muaBVpXU7xR0Tw+iJVwEx4z
         bC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740035101; x=1740639901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DqVvsVthq2h4/t7UrH240Bzi+oS8ZW8sparKJnfCVI=;
        b=cXpLU0K9v6YkBRoODrnURte3BXiZ3pJesyJVbdQFttv6WdIAmpfELaXfSQHOTqzSc/
         HzPzhhuR8r1mXuC8pYd73Vd5ethIZgFUPdkSYCTDNatqvhZOAFap7Pz4t+8JBNzuWDf8
         DmLS5UJyBmwdgS+6JIFhLPAA2x4L9Aw9Bf9yyqHkOMUU6qT2Pa89pj7uCLuzTUCzVZIm
         uAtSw69kbw2hbP5uL+0DxQiMMIIfB/9IYQ+eilbTLqavpdl1qYXmCdA0FcysHfkWC41o
         ToaU5MlVjhj+jD34TvM/v4aYKAR7q1A9/zd9yWbk+dI72XMIGwJ3bqhgn+jfvMNvQd3w
         KnNg==
X-Forwarded-Encrypted: i=1; AJvYcCX4UMgqL1n/za4nqVB6gd/tAniFBa/LhPFTTuab62rVIxJ0vc3LTfF9piQ6MqHiDghMhrAddQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr5vKDl2qB4ewErfmZVgtZiJRKjHQOmnPJ5hfT7t7tLB9cmMPY
	5eub0+Df9xnyrkj99u422v77+wJluSveXHhx9CVE3I1IZIQPkUC0NWQt8EOliIb+h7a9F1xmc7M
	lcZe1BJTpzGltTm2DwNWs7kTmWc/2ULMHONanrw==
X-Gm-Gg: ASbGnctVARnTdXlWYY0UEXIqaGcepFeebdwcdnipzTyHuttcRyhTyzAy+b8AFTWSPDC
	A8aawBoTevnR7/wMSHnrJmpFzcMpbxaVAbNYIKnpjCLqYRIwLEarjpfZ+WMw4N4UYkpX/d8TA5B
	I=
X-Google-Smtp-Source: AGHT+IEZKNMBrP2lM6Bm1hvdsTewtlhF0pZu3ss6WiHXL5gZNQY6DZIWU72QwbDGVzIjUzPcFFZ/gZnnd/15t3X4IzU=
X-Received: by 2002:a05:6902:3486:b0:e58:227:e963 with SMTP id
 3f1490d57ef6-e5dc9070168mr14747916276.21.1740035100978; Wed, 19 Feb 2025
 23:05:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217055843.19799-1-nick.hu@sifive.com> <889918c4-51ae-4216-9374-510e4cbdc3f1@intel.com>
 <CAKddAkBZWZqY+-TERah+Q+WUfkqzcpFMA=ySSuTxxBjfP7tKZg@mail.gmail.com> <Z7bSLq1vkYJUzvGM@mev-dev.igk.intel.com>
In-Reply-To: <Z7bSLq1vkYJUzvGM@mev-dev.igk.intel.com>
From: Nick Hu <nick.hu@sifive.com>
Date: Thu, 20 Feb 2025 15:04:50 +0800
X-Gm-Features: AWEUYZn2ntlAc-JtJt8X-ZlCzhTS64HhwD2QJ_NWHZfmvIV2rb2qYohzCaDzrzQ
Message-ID: <CAKddAkBGYqcWQdtFWe1+cnUjxVEiYrd4yw9sxy3GAO+RGkoFBw@mail.gmail.com>
Subject: Re: [PATCH] net: axienet: Set mac_managed_pm
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Michal Simek <michal.simek@amd.com>, 
	Russell King <linux@armlinux.org.uk>, Francesco Dolcini <francesco.dolcini@toradex.com>, 
	Praneeth Bajjuri <praneeth@ti.com>, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal

Thanks for the information! I'll pay attention next time.

On Thu, Feb 20, 2025 at 3:00=E2=80=AFPM Michal Swiatkowski
<michal.swiatkowski@linux.intel.com> wrote:
>
> On Thu, Feb 20, 2025 at 10:47:40AM +0800, Nick Hu wrote:
> > Hi Jacob
> >
> > On Thu, Feb 20, 2025 at 7:29=E2=80=AFAM Jacob Keller <jacob.e.keller@in=
tel.com> wrote:
> > >
> > >
> > >
> > > On 2/16/2025 9:58 PM, Nick Hu wrote:
> > > Nit: subject should include the "net" prefix since this is clearly a =
bug
> > > fix.
> > >
> > I've added the 'net' prefix to the subject 'net: axienet: Set
> > mac_managed_pm'. Is there something I'm missing?
> >
>
> It should be [PATCH net] net: axienet: Set mac_managed_pm
> Like here for example [1]. You can look at netdev FAQ [2]. It is
> described there how to specify the subject.
>
> Probably you don't need to resend it only because of that.
>
> [1] https://lore.kernel.org/netdev/CAL+tcoC3TuZPTwnHTDvXC+JPoJbgW2UywZ2=
=3Dxv=3DE=3Dutokb3pCQ@mail.gmail.com/T/#m2b5603fbf355216ab035aa0f69c10c5f4b=
a98772
> [2] https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.txt
>
> Thanks,
> Michal
>
> > > > The external PHY will undergo a soft reset twice during the resume =
process
> > > > when it wake up from suspend. The first reset occurs when the axien=
et
> > > > driver calls phylink_of_phy_connect(), and the second occurs when
> > > > mdio_bus_phy_resume() invokes phy_init_hw(). The second soft reset =
of the
> > > > external PHY does not reinitialize the internal PHY, which causes i=
ssues
> > > > with the internal PHY, resulting in the PHY link being down. To pre=
vent
> > > > this, setting the mac_managed_pm flag skips the mdio_bus_phy_resume=
()
> > > > function.
> > > >
> > > > Fixes: a129b41fe0a8 ("Revert "net: phy: dp83867: perform soft reset=
 and retain established link"")
> > > > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > > > ---
> > >
> > > Otherwise, the fix seems correct to me.
> > >
> > > Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> > >
> > > >  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/dr=
ivers/net/ethernet/xilinx/xilinx_axienet_main.c
> > > > index 2ffaad0b0477..2deeb982bf6b 100644
> > > > --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> > > > +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> > > > @@ -3078,6 +3078,7 @@ static int axienet_probe(struct platform_devi=
ce *pdev)
> > > >
> > > >       lp->phylink_config.dev =3D &ndev->dev;
> > > >       lp->phylink_config.type =3D PHYLINK_NETDEV;
> > > > +     lp->phylink_config.mac_managed_pm =3D true;
> > > >       lp->phylink_config.mac_capabilities =3D MAC_SYM_PAUSE | MAC_A=
SYM_PAUSE |
> > > >               MAC_10FD | MAC_100FD | MAC_1000FD;
> > > >
> > >
> >
> > Regards,
> > Nick

Regards,
Nick

