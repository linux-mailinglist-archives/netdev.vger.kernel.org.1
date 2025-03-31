Return-Path: <netdev+bounces-178365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B31A8A76C1D
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 18:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB5E188E7C0
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08682147FC;
	Mon, 31 Mar 2025 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epM8scgQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11B7212FB0;
	Mon, 31 Mar 2025 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743439154; cv=none; b=d7f0bFJUEeimVvOCayRyw3IzxR7YWC8lKbp/s+UHf/SEMGR10Wx///5oFOta+hzmkbeXabYiRhpOsh533zRBi7yv0/51LrnUs+e3J6yVYPIkQFg0yHRTWIisFdABGJzHgIRvwlY/m6r1mZGWyFelyNI5U55SqH9p0VkwIYuntlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743439154; c=relaxed/simple;
	bh=Z8d4g9wEquUrOEcli/D/aANZ3jmocVZYpI2mvNFSYRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrlzI+SjyPOFHbrBC78+69IMTTGxPKrLcp7ltifl7Ezff57jaxBeYnfoT7k5erzm3IpDWyHO+4TAgU/G+F2al4z6hbEwMANyZOVaxnhTDAJ7RSMbjhsgXwEs1Q5LG8IC+zo0sTJW6T0yFOpntJmYqmCXHLByJOqr0LL+D1Nyil8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epM8scgQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so37112595e9.2;
        Mon, 31 Mar 2025 09:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743439151; x=1744043951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8d4g9wEquUrOEcli/D/aANZ3jmocVZYpI2mvNFSYRA=;
        b=epM8scgQmmLkOdNUxSTX/j2O9GeYjo1zReheYU2tLtieFX0jmytKD4FBBOvEhOMHyy
         jhkka8vHTRjETFuJB+3F+u06E30cUPhkDnmjDLG7qdrQCfJQ1t2xO0fd0IZeAmPvCZIC
         D4pBesJIoD0i0uuRv2F0TfjBWMjw5U9uQ0kFEAbKmRL6sRPflGs8fXYl3+zka2lQBeAV
         jXReMlQDtcBhJzXgVhh9qgHZE2Qa/iqejrHxotX9qj8E/rWpaWEKN/YHnULms1el1AVq
         XjLbyO6M2T5fWQRL4QGECN6vb1qdjXsIuzFmxwiKUPPvc56Q0FgZpbEj9ws8SdfVb1H2
         1pxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743439151; x=1744043951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8d4g9wEquUrOEcli/D/aANZ3jmocVZYpI2mvNFSYRA=;
        b=Tke1GEcYhVas7RsinNNyr+yBg6QpemcQYmowWrDWXACf/haeFuH1be7FAJq3RuZjz+
         eZ7ch66CHj5YcH0fnkSl1RvRPAt77ga4mvo3XU3YSsbu28/GJxkwVxMOcIUV5upxyWWH
         3u2exA4G5T2M8GquZx3qbRrZM7IJsitpwNsMTqumxJixZtcAfZ2yh6DCL2nW1gTW41rx
         SvbpgZm7i2qnetvIQlzkCmFNqiNs41KpPe3Wf2l8sN7sYF+8DO1MnNCfwSsOUEfqinky
         MaxQ9qmDi6eMXDGK/jF0DHN4frroJA3HNr9NOcQGvbUxGUQ26owOGrptc2zLZcmz4lmC
         jj+g==
X-Forwarded-Encrypted: i=1; AJvYcCXqlNw33K0d9tJKYk1mPeK3U4+qY/x/JGIfMcjl+OfwwNoHTgGmT1mB1CiUuIczgNBfmDuJFLkU@vger.kernel.org, AJvYcCXwOj3hdFxPMuS4NWX67EBmsS9IdZfyj/jNNcEIbKc4rmOImKL88SPwqq58eUQ+pYMLTAAi4KeI1gIygIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPd+F08/77rHXM2qDmqRRsLQWemOymgnCYXwxKSoGQZm5JHDpX
	kVItjNsbhdMQQ4clzTeY6vGKRFC7RMQPLxWuU0wLU4CGau2B1YuiWiqqZYE9VevouPiJIuF/dIq
	PK3+LbUU5YnKfDoRYcdICIk5xvRI=
X-Gm-Gg: ASbGncusJdipuwxYJ4oUshOGuCpzVIG4z4vQK7m2DiImDJqqzWj/WgrwEqYnFzNHYqN
	6z5Kt0Ef9vXnHEmlA0ViMlN0tFuQPD5WmxyBYVv9RE1O/CCkze4VIP5yt3PJO8jux0O8SVeOIBa
	uy/GrDRss6U+qz6kFBTTooexbrSJqLA0ldIAVDItJ8D/oQ6X6c5L1HVoj6nWw=
X-Google-Smtp-Source: AGHT+IHZzXLpgViYZ4N1izMamI668R2BU8hGvXjTj9xo36k3cDMT/lFyo33eVfGT780WUYBHXlsgJZJWvr5rEwj0YiM=
X-Received: by 2002:a05:600c:5489:b0:43c:fda5:41e9 with SMTP id
 5b1f17b1804b1-43dbc419540mr92229645e9.31.1743439150876; Mon, 31 Mar 2025
 09:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
 <20250307173611.129125-10-maxime.chevallier@bootlin.com> <8d3a9c9bb76b1c6bc27d2bd01f4831b2cac83f7f.camel@gmail.com>
 <20250328090621.2d0b3665@fedora-2.home> <CAKgT0Ue_JzmJAPKBhe6XaMkDCy+YNNg5_5VvzOR6CCbqcaQg3Q@mail.gmail.com>
 <12e3b86d-27aa-420b-8676-97b603abb760@lunn.ch> <CAKgT0UcZRi1Eg2PbBnx0pDG_pCSV8tfELinNoJ-WH4g3CJOh2A@mail.gmail.com>
 <02c401a4-d255-4f1b-beaf-51a43cc087c5@lunn.ch> <Z-qsnN4umaz0QrG0@shell.armlinux.org.uk>
 <20250331182000.0d94902a@fedora.home>
In-Reply-To: <20250331182000.0d94902a@fedora.home>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 31 Mar 2025 09:38:34 -0700
X-Gm-Features: AQ5f1Jo4H2kJVBl3bUTBM3aQvZN8Nc6GirQhFLcIGY7KsXCNVmJ2NznhupG4LQQ
Message-ID: <CAKgT0UdJHkGRh5S4hHg0V=Abd7UizH49F+V2QJJQxguHvCYhMg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 09/13] net: phylink: Use phy_caps_lookup for
 fixed-link configuration
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	=?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Simon Horman <horms@kernel.org>, 
	Romain Gantois <romain.gantois@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 9:20=E2=80=AFAM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> On Mon, 31 Mar 2025 15:54:20 +0100
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
>
> > On Mon, Mar 31, 2025 at 04:17:02PM +0200, Andrew Lunn wrote:
> > > On Fri, Mar 28, 2025 at 04:26:04PM -0700, Alexander Duyck wrote:
> > > > A serdes PHY is part of it, but not a traditional twisted pair PHY =
as
> > > > we are talking about 25R, 50R(50GAUI & LAUI), and 100P interfaces. =
I
> > > > agree it is a different beast, but are we saying that the fixed-lin=
k
> > > > is supposed to be a twisted pair PHY only?
> > >
> > > With phylink, the PCS enumerates its capabilities, the PHY enumerates
> > > its capabilities, and the MAC enumerates it capabilities. phylink the=
n
> > > finds the subset which all support.
> > >
> > > As i said, historically, fixed_link was used in place of a PHY, since
> > > it emulated a PHY. phylinks implementation of fixed_link is however
> > > different. Can it be used in place of both a PCS and a PHY? I don't
> > > know.
> >
> > In fixed-link mode, phylink will use a PCS if the MAC driver says there
> > is one, but it will not look for a PHY.

Admittedly the documentation does reference much lower speeds as being
the use case. I was a bit of an eager beaver and started assembling
things without really reading the directions. I just kind of assumed
what I could or couldn't get away with within the interface.

> > > You are pushing the envelope here, and maybe we need to take a step
> > > back and consider what is a fixed link, how does it fit into the MAC,
> > > PCS, PHY model of enumeration? Maybe fixed link should only represent
> > > the PHY and we need a second sort of fixed_link object to represent
> > > the PCS? I don't know?
> >
> > As I previously wrote today in response to an earlier email, the
> > link modes that phylink used were the first-match from the old
> > settings[] array in phylib which is now gone. This would only ever
> > return _one_ link mode, which invariably was a baseT link mode for
> > the slower speeds.
> >
> > Maxime's first approach at adapting this to his new system was to
> > set every single link mode that corresponded with the speed. I
> > objected to that, because it quickly gets rediculous when we end
> > up with lots of link modes being indicated for e.g. 10, 100M, 1G
> > but the emulated PHY for these speeds only indicates baseT. That's
> > just back-compatibility but... in principle changing the link modes
> > that are reported to userspace for a fixed link is something we
> > should not be doing - we don't know if userspace tooling has come
> > to rely on that.
> >
> > Yes, it's a bit weird to be reporting 1000baseT for a 1000BASE-X
> > interface mode, but that's what we've always done in the past and
> > phylink was coded to maintain that (following the principle that
> > we shouldn't do gratuitous changes to the information exposed to
> > userspace.)
> >
> > Maxime's replacement approach is to just expose baseT, which
> > means that for the speeds which do not have a baseT mode, we go
> > from supporting it but with a weird link mode (mostly baseCR*)
> > based on first-match in the settings[] table, to not supporting the
> > speed.
>
> I very wrongfully considered that there was no >10G fixed-link users, I
> plan to fix that with something like the proposed patch in the
> discussion, that reports all linkmodes for speeds above 10G (looks less
> like a randomly selected mode, you can kind-of see what's going on as
> you get all the linkmodes) but is a change in what we expose to
> userspace.

I am not sure if there are any >10G users. I haven't landed anything
in the kernel yet and like I said what I was doing was more of a hack
to enable backwards compatibility on older kernels w/ the correct
supported and advertised modes. If I have to patch one kernel to make
it work for me that would be manageable.

One thing I was thinking about that it looks like this code might
prevent would be reinterpreting the meaning of duplex. Currently we
only have 3 values for it 0 (half), 1 (Full), and ~0 (Unknown). One
thought I had is that once we are over 1G we don't really care about
that anymore as everything is Full duplex and instead care about
lanes. As it turns out the duplex values currently used would work
well to be extended out to lanes. Essentially 0 would still be half, 1
would be 1 lane full duplex, 2-8 could be the number of full duplex
lanes the interface is using, and unknown lane count would still be ~0
since it is unlikely we will end up with anything other than a power
of 2 number of lanes anyway. With that you could greatly sort out a
number of modes in your setup. We would then have to do some cleanups
here and there to do something like "duplex =3D=3D DUPLEX_UNKNOWN ? duplex
: !!duplex" to clean up any cases where the legacy values are
expected.

Likewise if you were to look at adding the port type that might allow
for further division and cleanup. With that someone could specify the
speed, duplex, and port type and they would be able to pretty
precisely pick out a specific fixed mode.

> Or maybe simpler, I could extend the list of compat fixed-link linkmodes
> to all speeds with the previous arbitrary values that Russell listed in
> the other mail (that way, no user-visible changes :) )
>
> I was hoping Alexander could give option 1 a try, but let me know if
> you think we should instead adopt option 2, which is probably the safer
> on.

I can try to get to it, but I have a number of meetings today so I may
not be able to get to it until tomorrow morning.

Also I suspect this may have an impact outside of just the fixed link
setup. I will have to try some other spots to see if I see anything
odd pop up as I suspect that I will have issues with 50R2/50R running
over top of each other after these changes.

Thanks,

- Alex

