Return-Path: <netdev+bounces-205471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F4015AFEDE8
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 17:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26C61C43CCA
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5436F290D85;
	Wed,  9 Jul 2025 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/0QFozT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7829F5383
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075511; cv=none; b=HblovsS7BIlcVuKxqTP4RXVQmT/wwNALpPg3fM3CEF0YDp1xb8I161zMcaakFzlrlNHyQLpvK19xmvKZZBAcWbigttJdetxF+0ybs+GKXCFfK5uacFVFqfE00+XIcGn0HPa3vKWI008bDR7VXqIRulztZBprU85GXIzoDslYgSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075511; c=relaxed/simple;
	bh=ZfS9t9LvkDtG2A+sgKcdwB7jtZxHvLQWHQRmye40iCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AN101CD6lTKYegY3pnA0Zf9K5Nyu6oLMUFeiqGqtky1Nj+MsW3SiCPVjjQSd0vQptSAtyNCT7Rfrp8GwT0zyhn6hguoxjNHrlt+sI4VTTVezkbFEbZLaL/6s4K38H73niCMEKZUQPgjQOnRtsl69W5nUYzJklvrLTdLZ1VmIfak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/0QFozT; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a503d9ef59so58467f8f.3
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 08:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752075508; x=1752680308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZpjnARJO0f/PoGWyVv2w1DHAAsBvLSVfbD4NIlm7dU=;
        b=J/0QFozT0e+z+3qSYodRFSqLMVatE9YUpp6HsGAA7umTG5esYIXsv/udYzVnTUoa2J
         Rp+FrHLyOsiT1lITFjq+3oob87iLZvoHNt+wxTqAaq62p+NrJZb0OmPlzpSnnQ6+O3LY
         OPm+biBKS770I/HId2ZS4sSWDdiHgX8Zrw8HpYSNzM2ZUXY9wZshDlDWVT/0/mYgg/DC
         lRo60Avy6y350qG0vBNWCpfeQP5b6gLeF333NMSZFAK+84Gg3PZAlR+iH6eochzDDG0M
         MeoUxy6pfDyq4X59QOWatQ6JkwO68e/x9Js2FDA6+Z5zc/Z9slq8f7mYx3MlON65/+uR
         8rIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752075508; x=1752680308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZpjnARJO0f/PoGWyVv2w1DHAAsBvLSVfbD4NIlm7dU=;
        b=vnPuyIweshczT9gF4eOBlpbnUrsgG5V5Xq/9/viuqtXj8aYvAG80bA26hseoKZSmge
         oH7WkvbJQOimW7mDH1JRrfGW3MTHZXbTiTL8cquwEq6qN/RFJNXlDEHc8Rmcv1AzVIwC
         vm6ETd6r6Ylcacbl01ljG5alO1d/J1pOjm2IpYEj1iaQkTO5VdTcPl3GMrrR1My5inC7
         5a7cF7iwOupmiFqiKfRmGFxA0ziAK1y7+u0NG41vzBQR8VTBibotlNZCPgAGoiq8Jjhi
         oDtD+Ln1hV0VGFoGjdE2VOakrPpTR6orAMmPx1q4G4H8j4EIY7qCKnKdMRMgjRhR234x
         YL8A==
X-Forwarded-Encrypted: i=1; AJvYcCVRtAFoOLbWAPGnV9kSZwYC6qlwveSzDk5zasPwJ21cPpwjHmhhUyNf/isJvLW8XSuZQt0Max8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKjTzFZv+MrI0rmMZQAVqBdylY9YVmkYEjnegDobQGlR9XNGnC
	Z3rviywpBCvCaMMnB1J/LCF1NL8i/whRoXtuker7sFFRdM6kigGUJtowJFVFFnLNhiR5zCwLcXW
	JlBArthtdxWpclFYr+WerUfIWLCs7jSU=
X-Gm-Gg: ASbGncsGFAlTOkFHcRWatSQBKQnbFLzpcVolfPCDS4MeIn0tT6IJb6er2VDub2b6dQa
	nJA97bUYp9ItOfqcRA2fcbDOBDfUBUuIJfAjfYu/wwEnpDAAtIiJJdL/F0awVlowXfrlguETu+6
	+oO6FxdXVTVkQE3TEuLXPlgYMeB7qo0HyFVKvervKxK787X5t8uI8dMdNJzQQXVC/cv64+/2OpT
	41s
X-Google-Smtp-Source: AGHT+IGzyNtp0tq09RP6SB6AIpoaxPAutGNojx0t2KFBu/kHa7dHO+Kj81oCbCM196nYMyzSbljw2E2q3d2IpYz41js=
X-Received: by 2002:a05:6000:3106:b0:3a3:66cb:d530 with SMTP id
 ffacd0b85a97d-3b5e4513838mr2424904f8f.23.1752075507424; Wed, 09 Jul 2025
 08:38:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aGT_hoBELDysGbrp@shell.armlinux.org.uk> <E1uWu14-005KXo-IO@rmk-PC.armlinux.org.uk>
 <20250702151426.0d25a4ac@fedora.home> <aGU2C3ipj8UmKHq_@shell.armlinux.org.uk>
 <CAKgT0UcWGH14B0zZnpHeJKw+5VU96LHFR1vR4CXVjqM10iBJSg@mail.gmail.com> <aGWF5Wee3vfoFtMj@shell.armlinux.org.uk>
In-Reply-To: <aGWF5Wee3vfoFtMj@shell.armlinux.org.uk>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 9 Jul 2025 08:37:51 -0700
X-Gm-Features: Ac12FXwsvl8XuHEZD-scGkdMI78RFcpKA7HQCkXUJAtsRItn03vi9P88FhTW7vQ
Message-ID: <CAKgT0UdVW6_hewR7zNzMd_h7b_Lm_SHdt72yVhc7cLHcfFxuYQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: phylink: add phylink_sfp_select_interface_speed()
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 12:18=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Jul 02, 2025 at 11:07:52AM -0700, Alexander Duyck wrote:
> > On Wed, Jul 2, 2025 at 6:37=E2=80=AFAM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Wed, Jul 02, 2025 at 03:14:26PM +0200, Maxime Chevallier wrote:
> > > > On Wed, 02 Jul 2025 10:44:34 +0100
> > > > "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:
> > > >
> > > > > Add phylink_sfp_select_interface_speed() which attempts to select=
 the
> > > > > SFP interface based on the ethtool speed when autoneg is turned o=
ff.
> > > > > This allows users to turn off autoneg for SFPs that support multi=
ple
> > > > > interface modes, and have an appropriate interface mode selected.
> > > > >
> > > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > >
> > > > Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > > >
> > > > I don't have any hardware to perform relevant tests on this :(
> > >
> > > Me neither, I should've said. I'd like to see a t-b from
> > > Alexander Duyck who originally had the problem before this is
> > > merged.
> >
> > It will probably be several days before I can get around to testing it
> > since I am slammed with meetings most of the next two days, then have
> > a holiday weekend coming up.
>
> I, too, have a vacation - from tomorrow for three weeks. I may dip in
> and out of kernel emails during that period, but it depends what
> happens each day.

So I was able to go in and test it. I ended up just running the
testing in QEMU w/ my patch set that currently enables QSFP support.
From what I can tell it appears to be mostly working. Before when I
tried to alter the speed to go from 100G to 50G it wouldn't change.
After your patch set it appears to change, although I am noticing a
slight difference from the default config.

So by default we come up in the 100G w/ the QSFP configuration:
[root@localhost fbnic]# ethtool enp1s0
Settings for enp1s0:
        Supported ports: [  ]
        Supported link modes:   50000baseCR/Full
                                100000baseCR2/Full
        Supported pause frame use: Symmetric Receive-only
        Supports auto-negotiation: No
        Supported FEC modes: RS
        Advertised link modes:  100000baseCR2/Full
        Advertised pause frame use: Symmetric Receive-only
        Advertised auto-negotiation: No
        Advertised FEC modes: RS
        Link partner advertised link modes:  100000baseCR2/Full
        Link partner advertised pause frame use: No
        Link partner advertised auto-negotiation: No
        Link partner advertised FEC modes: RS
        Speed: 100000Mb/s
        Duplex: Full
        Auto-negotiation: off
        Port: Other
        PHYAD: 0
        Transceiver: internal
        Link detected: yes

I then change the speed to 50G and it links back up after a few
seconds, however the "Advertised link modes" goes from
"100000baseCR2/Full" to "Not reported" as shown here:
[root@localhost fbnic]# ethtool -s enp1s0 speed 50000
[root@localhost fbnic]# ethtool enp1s0
Settings for enp1s0:
        Supported ports: [  ]
        Supported link modes:   50000baseCR/Full
                                100000baseCR2/Full
        Supported pause frame use: Symmetric Receive-only
        Supports auto-negotiation: No
        Supported FEC modes: RS
        Advertised link modes:  Not reported
        Advertised pause frame use: Symmetric Receive-only
        Advertised auto-negotiation: No
        Advertised FEC modes: RS
        Link partner advertised link modes:  100000baseCR2/Full
        Link partner advertised pause frame use: No
        Link partner advertised auto-negotiation: No
        Link partner advertised FEC modes: RS
        Speed: 50000Mb/s
        Duplex: Full
        Auto-negotiation: off
        Port: Other
        PHYAD: 0
        Transceiver: internal
        Link detected: yes

So all-in-all it is an improvement over the previous behavior although
there may still need to be some work done to improve the consistency
so that it more closely matches up with what happens when you
initially configure the interface.

