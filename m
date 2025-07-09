Return-Path: <netdev+bounces-205511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6EFAFF00E
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 19:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FDBB16B799
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 17:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0905D41C71;
	Wed,  9 Jul 2025 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrPUFaxg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBA7235046
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752082878; cv=none; b=QA2GMg+OwWOMvTndCff4xmc47vZbeEzXzTsmR3x7Ed0nrlkMcZiqTw3A/fvszJEURsUESaSkEzCmTMxMppOb4MWL5XUiNSqO48O3ORLauGyWNG+uIOsLwmL2LC5J20kaBuBv7pgUOUvSp4Bdc+3+PJjm0M77Xxkj1R9ackN8Jq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752082878; c=relaxed/simple;
	bh=vglIedOkN4YvuLM292JV4xEwE9wMABjbRvAoJwnAtt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGecl4dVWBzbpwkCZ9a3v9uLn1REeCzu1P6pEQ/eL/lynEFvzWJps76X1Wq+TfH0LBpnjNma/P/ZZyofYxIK5FUFp+B4dp6IZFuM3ePCSpu2b92EJTyWxSlxxDL9DYlt8SI8dNj/rsqbIn9smr57uiq/K6wuK5p/KCSR97tGX6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrPUFaxg; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so958835e9.1
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 10:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752082875; x=1752687675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgLda+rXHsys2E47MijEktQVC7+YXqh4Sd2HYM1ecnM=;
        b=ZrPUFaxg0ub2SJKZ8Nr3moug2wHnZTxYEzCyBsHCxUAunDeJrYchKHluQyuHDUMgCP
         m79YsSRVuR6y+OLgtCvfet+c3EIkbssVuU0ZX1UP2msm5G0bEfSf2SYmH+9zMORU5UeQ
         +qu4ZIGrIcTWBcAr+ElPLcVsH0anscUQIpa+qvwMgSGaePK9YqZmsTd5yyq+RISN3LWL
         JQqFCP8Cj7lVkmUzsL00tK7SydeSMVIctKX+D1gbgpUZDRzKLMQQb+WYGRT0eaERGlJe
         C+wzf65j1N54gUJgAV6RMZ0gSiqUsYGRPPseuNJdk7OzBCRsoU3o9rzFN9DN0kWPJS9t
         j6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752082875; x=1752687675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JgLda+rXHsys2E47MijEktQVC7+YXqh4Sd2HYM1ecnM=;
        b=vGiTZWItWv2Gz2Z19DxV+Vqvo3KOYAaZP6C+2FtrqThCbQxJcBWLkHWp0Hs1gcuyL0
         lV2kUIm8syx9EIus8dow2mALRYqVXBWFsWYVH+Fot97oafV4jtD6EG6S+zwJUirY3I3e
         L0M0u4lqMl2LjsHLpHVVa31HkTbi1Xqko+d50DbvuUTUdAiZom7X7U7ABB6HEk9Bs1ev
         +UdT8uC/WVBIPxbILGqRGED3QGM3PlFA8HQwcr5EhIkibqGanHDa5YaIt2M9DtSDl7ey
         T/od/lDvVXWrnYmB0fj3guY10vLqhI04JpiweSm6R2ob9Oo9Qlpawk1QH8+3nzWLgcW3
         YMfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrbOVhQIKwpXInm16YnYyDs4IqGE1Xul1QraK/TzhBKV4DSYWe6k8MbC9I3rKaeAa70ydEkhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPINew/NCPgxAntz8SX2ynqXqy0kqH5ueSEV7LC0Q5b4203a5Q
	U9WfQamIJbRune2bULaPLXV34YXWfk6RBUSmf+K5IBV3qUSZd+x2v8rdFRsvYVKCuFCTOlaOQS2
	9k9xL9YoEPJVfvuE0op3x7FxU51jz01k=
X-Gm-Gg: ASbGncs5E9Vz39toVVVVpYnG5YlGhjXLvrXDJuo+IPGNoqQJFPFIDGreZubNj7tqNtq
	KYA1F+T7loCdLm8ISeuC1E1VPOGjhmqDnkm3nNzJOjR2IHdrZlSdtMMn9Bu0cfN9HlQy8Sk6KtR
	6a8FO+lTsxXnLiQGeKyshBIDQQHKCmxbY2/ZIjQVPQTDFj+t21u106wgsBsZ0BNIvjPJPe6AStR
	yG6
X-Google-Smtp-Source: AGHT+IE1tzcQI23rKMxSfnp+RSioa5uHXpUTsXzv9HOPlaYrANuWRLpT5aZuTCpLnondWxO6ODEnSSdu3ggySTCzjjE=
X-Received: by 2002:a05:600c:8207:b0:445:1984:2479 with SMTP id
 5b1f17b1804b1-454d52db33bmr34957245e9.5.1752082875123; Wed, 09 Jul 2025
 10:41:15 -0700 (PDT)
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
 <aG6Pd8sqgL5rILm-@shell.armlinux.org.uk>
In-Reply-To: <aG6Pd8sqgL5rILm-@shell.armlinux.org.uk>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 9 Jul 2025 10:40:38 -0700
X-Gm-Features: Ac12FXxWeLI_ORtDQEsDO6Jzc_wqlEOQK4c4aP62L2cLparirX6nT-cI2iVJCnw
Message-ID: <CAKgT0Ufe7waHg+RBRE0+5ks2ykVTaK=25dgFKOD9waUviGXw+w@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: phylink: add phylink_sfp_select_interface_speed()
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 8:49=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Jul 09, 2025 at 08:37:51AM -0700, Alexander Duyck wrote:
> > On Wed, Jul 2, 2025 at 12:18=E2=80=AFPM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Wed, Jul 02, 2025 at 11:07:52AM -0700, Alexander Duyck wrote:
> > > > On Wed, Jul 2, 2025 at 6:37=E2=80=AFAM Russell King (Oracle)
> > > > <linux@armlinux.org.uk> wrote:
> > > > >
> > > > > On Wed, Jul 02, 2025 at 03:14:26PM +0200, Maxime Chevallier wrote=
:
> > > > > > On Wed, 02 Jul 2025 10:44:34 +0100
> > > > > > "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:
> > > > > >
> > > > > > > Add phylink_sfp_select_interface_speed() which attempts to se=
lect the
> > > > > > > SFP interface based on the ethtool speed when autoneg is turn=
ed off.
> > > > > > > This allows users to turn off autoneg for SFPs that support m=
ultiple
> > > > > > > interface modes, and have an appropriate interface mode selec=
ted.
> > > > > > >
> > > > > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org=
.uk>
> > > > > >
> > > > > > Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > > > > >
> > > > > > I don't have any hardware to perform relevant tests on this :(
> > > > >
> > > > > Me neither, I should've said. I'd like to see a t-b from
> > > > > Alexander Duyck who originally had the problem before this is
> > > > > merged.
> > > >
> > > > It will probably be several days before I can get around to testing=
 it
> > > > since I am slammed with meetings most of the next two days, then ha=
ve
> > > > a holiday weekend coming up.
> > >
> > > I, too, have a vacation - from tomorrow for three weeks. I may dip in
> > > and out of kernel emails during that period, but it depends what
> > > happens each day.
> >
> > So I was able to go in and test it. I ended up just running the
> > testing in QEMU w/ my patch set that currently enables QSFP support.
> > From what I can tell it appears to be mostly working. Before when I
> > tried to alter the speed to go from 100G to 50G it wouldn't change.
> > After your patch set it appears to change, although I am noticing a
> > slight difference from the default config.
> >
> > So by default we come up in the 100G w/ the QSFP configuration:
> > [root@localhost fbnic]# ethtool enp1s0
> > Settings for enp1s0:
> >         Supported ports: [  ]
> >         Supported link modes:   50000baseCR/Full
> >                                 100000baseCR2/Full
> >         Supported pause frame use: Symmetric Receive-only
> >         Supports auto-negotiation: No
> >         Supported FEC modes: RS
> >         Advertised link modes:  100000baseCR2/Full
> >         Advertised pause frame use: Symmetric Receive-only
> >         Advertised auto-negotiation: No
> >         Advertised FEC modes: RS
> >         Link partner advertised link modes:  100000baseCR2/Full
> >         Link partner advertised pause frame use: No
> >         Link partner advertised auto-negotiation: No
> >         Link partner advertised FEC modes: RS
> >         Speed: 100000Mb/s
> >         Duplex: Full
> >         Auto-negotiation: off
> >         Port: Other
> >         PHYAD: 0
> >         Transceiver: internal
> >         Link detected: yes
> >
> > I then change the speed to 50G and it links back up after a few
> > seconds, however the "Advertised link modes" goes from
> > "100000baseCR2/Full" to "Not reported" as shown here:
> > [root@localhost fbnic]# ethtool -s enp1s0 speed 50000
> > [root@localhost fbnic]# ethtool enp1s0
> > Settings for enp1s0:
> >         Supported ports: [  ]
> >         Supported link modes:   50000baseCR/Full
> >                                 100000baseCR2/Full
> >         Supported pause frame use: Symmetric Receive-only
> >         Supports auto-negotiation: No
> >         Supported FEC modes: RS
> >         Advertised link modes:  Not reported
> >         Advertised pause frame use: Symmetric Receive-only
> >         Advertised auto-negotiation: No
> >         Advertised FEC modes: RS
> >         Link partner advertised link modes:  100000baseCR2/Full
> >         Link partner advertised pause frame use: No
> >         Link partner advertised auto-negotiation: No
> >         Link partner advertised FEC modes: RS
> >         Speed: 50000Mb/s
> >         Duplex: Full
> >         Auto-negotiation: off
> >         Port: Other
> >         PHYAD: 0
> >         Transceiver: internal
> >         Link detected: yes
> >
> > So all-in-all it is an improvement over the previous behavior although
> > there may still need to be some work done to improve the consistency
> > so that it more closely matches up with what happens when you
> > initially configure the interface.
>
> Likely, it's ethtool doing that. Autoneg-off (fixed speed) modes
> generally don't have an advertisement. I suggest you debug at UAPI
> level.

Makes sense. If I change the line to:
[root@localhost fbnic]# ethtool -s enp1s0 speed 50000 advertise
0x840000000000000

Then I am able to get it to populate the advertised mode as it did
before and we can switch back and forth with the advertised mode
listed matching the advertised speed. So it looks like the
ksettings_set call just takes in what is there and ANDs it a few times
to validate what is being selected.

