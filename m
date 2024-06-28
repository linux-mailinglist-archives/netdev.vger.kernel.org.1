Return-Path: <netdev+bounces-107675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 090DD91BE39
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 14:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7A21C216AB
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 12:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98BB158216;
	Fri, 28 Jun 2024 12:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="t8yuA455"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48031581F3
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719576719; cv=none; b=mxb9JxJpnw+lUE+dHVhbr+zrhGU+x02rF+QWNzDDZpscexDf5Qs6hYJT8rZPi4Ekkr23AhVEUa2M484+HJrhFFrQvoO//+J8w3xo+03PL/KKbl2Eb10FGc/IJpMleoZG/Cp5LTWGjJjo8Qjm9WDWj9/EJ7d6IsojWu9P4XBng14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719576719; c=relaxed/simple;
	bh=354uVh4PBW1xMkPKueF1eUEWHI9SucpRrGYhB+3dgc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kVaccvoTThiGWHmHsRWy1bIcNDOzLPib8k+romyl5SEEUVCsvE6lbiYjBfsDgbItn9sBObwDTAQTIi4SPzEosdco0mEBDGq79CAFedsZ1I/l6HoWyABFBQoUI8Qbl9GtalUWoGniv7XQTcItYvISEnfGa9na4iKzaBZhDn+5m7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=t8yuA455; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ebe785b234so5133901fa.1
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 05:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719576716; x=1720181516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VphU30ShdKo0kFNxhFs5E1FivNI2EkbLhVXmpt36iUA=;
        b=t8yuA4554YrN9hCQW/cMXJf7QA86lB3CMjB19MtVTes4G7INqaGs4g1STFLwYCJlJT
         JDcozkdvFQlsF96w9ITY1ASgPXNFS5SYM5T/LqQIz9Q3IJ5dSLImj5//130FJLEk2Yp8
         PSG56vNZmYGI2j6lL3p24fJm///kiLEZgcLsepxgx7aQsoT4jMXWuS2riMLqhRMzfEVO
         4p4x/cFVuMQ5g7NHBeS0jtLAM5W50+x4SSa2b5YXWfnHajb6+EBAqbNBIMsX9FtLPcps
         tx3COeg3pxFeBD/20Ej1a7ShSuCwxJ1mYtYR3ue88L3Iy6oMD60jyCXSNkucQpC6Z0jo
         Qt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719576716; x=1720181516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VphU30ShdKo0kFNxhFs5E1FivNI2EkbLhVXmpt36iUA=;
        b=oYi5rrqMawBB3llSkKO2bgp+7sQFzqhdZBvS4TkRk1MD7MutaD8PHpYT4KjBkNnjI5
         ro614SaWkJ9wBxyq0M7X3Csp6kJtAJ+VNr6jxIC+5c7zjQRdebtTMtdjPFizRQKHdN9F
         ng5QHKu8KS5HB8ZvVfNoqslhiPy5dikvr8H6cpYaH9cXa5TVkUHcsrpiOnQ+GXieeVdn
         oZxdDs6yI7217viEtbt8etaEcNxd2KRyJUpKEmxYMhdn1A5POsaUTIT1R+XIfPvVg3Iz
         hH0ki57whwnDZbLmEBJ7PwHp70usQB9omO/j/p26u1/LYkjaop+/WcWOWLOHzxePQ6if
         u9SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWda1eVOGRT7IzL45SO32kih6IvB6tOm58hhlKmNOon4UsRJRETHPxopI+q8sIuCxI2mf6rm9Al+iTp2iSeRLH1k035gj7+
X-Gm-Message-State: AOJu0YyV1wt5nu06zbeOkebYBuCsswcOI251UIXiBLgsZJU+w6xvXHYD
	DiVzfFrXEmY6ejbxxsc9gHx3qlrlr5NoIokh8OzTIikLB2Znn68jNTW8TGUQapGCUIw5I9gMCXX
	Cu309QGigFN42KT48mJInpnkzltHALsGCrwFAFw==
X-Google-Smtp-Source: AGHT+IFsGBvDlkorUK6Zgy7iQE/gP9l7eb2X+TcW3LxCReBR6b1y+Bri0aYa9CP1qwHsXgnATfFHeET8caEIDkN/o30=
X-Received: by 2002:a2e:7812:0:b0:2ec:5469:9d64 with SMTP id
 38308e7fff4ca-2ec5936fb2fmr123396611fa.32.1719576715798; Fri, 28 Jun 2024
 05:11:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627113018.25083-1-brgl@bgdev.pl> <20240627113018.25083-4-brgl@bgdev.pl>
 <Zn3q5f5yWznMjAXd@makrotopia.org> <d227011a-b4bf-427f-85c2-5db61ad0086c@lunn.ch>
 <Zn4Nq1QvhjAUaogb@makrotopia.org>
In-Reply-To: <Zn4Nq1QvhjAUaogb@makrotopia.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 28 Jun 2024 14:11:44 +0200
Message-ID: <CAMRc=Mcftb9MRAP50ZNMfQpsjLzc-=OKvxo5Xkeqdgs-rZFNug@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 3/3] net: phy: aquantia: add support for aqr115c
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 3:11=E2=80=AFAM Daniel Golle <daniel@makrotopia.org=
> wrote:
>
> On Fri, Jun 28, 2024 at 02:18:45AM +0200, Andrew Lunn wrote:
> > On Thu, Jun 27, 2024 at 11:42:45PM +0100, Daniel Golle wrote:
> > > Hi Bartosz,
> > >
> > > On Thu, Jun 27, 2024 at 01:30:17PM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > Add support for a new model to the Aquantia driver. This PHY suppor=
ts
> > > > Overlocked SGMII mode with 2.5G speeds.
> > >
> > > I don't think that there is such a thing as "Overclocked SGMII mode w=
ith
> > > 2.5G speed".
> >
> > Unfortunately, there is. A number of vendors say they do this, without
> > saying quite what they actually do.  As you point out, symbol
> > replication does not work, and in-band signalling also makes no
> > sense. So they throw all that away. Leaving just the higher clock
> > rate, single speed, and no in-band signalling.
> >
> > In the end, that looks very similar to 2500BaseX with broken inband
> > signalling.
>
> Let's call it that then: "2500Base-X with broken in-band signalling".
>
> MaxLinear describes that quite clearly in their (open!) datasheets[1],
> and gives some insight into the (mis-)use of the term "SGMII" in the
> industry as synonymous to just any type of serialized Ethernet MII:
>
> "
> 3.4 SGMII Interface
>
> The GPY211 implements a serial data interface, called SGMII or SerDes,
> to connect to another chip implementing the MAC layer (MAC SoC).
> "
> (page 32)
>
> Later on they mention that
> "
> 3.4.7 Auto-negotiation Modes Supported by SGMII
>
> Two modes are supported for the SGMII auto-negotiation protocol:
>  * Cisco* Serial-GMII Specification 1.8 [4]
>  * 1000BX IEEE 802.3 following IEEE Clause 37 [2]
> "
> (page 37)
>
> Aquantia's datasheets are only available under NDA, so I cannot quote
> them directly, but I can tell you that their definition of "SGMII" is
> pretty similar to that of MaxLinear.
>

Well, hopefully without breaching the NDA I can tell you that there's
no definition at all. At least not in the ~700 pages doc I have access
to anyway.

> >
> > > Hence I assume that what you meant to say here is that the PHY uses
> > > 2500Base-X as interface mode and performs rate-adaptation for speeds
> > > less than 2500M (or half-duplex) using pause frames.
> >
> > Not all systems assume rate adaptation. Some are known to use SGMII
> > for 10/100/1G with inband signalling, and then swap to 2500BaseX
> > without inband-signalling for 2.5G operation!
>
> Yes, most 2.5G PHYs out there (MaxLinear, RealTek) actually support both,
> with interface-mode switching being the better option compared to often
> rather problematic rate-adaptation...
>
> When it comes to Aquantia we are using 2500Base-X with rate adaptation
> for the older 2.5G PHYs, so I assume the newer ones would not differ in
> that regard. Or rather: If we were to introduce interface-mode-switching
> also for the Aquantia 2.5G PHYs then we should try doing it for all of
> them at least.
>
> >
> > 2.5G is a mess.
>
> +1
>

Not sure what to do, should I still be adding a new mode here or is it
fine to just explain in the commit message that this really is
"2500Base-X-sans-in-band-signalling" and keep the code as is? Or maybe
some quirk disallowing `managed =3D "in-band-status"`?

Bartosz

