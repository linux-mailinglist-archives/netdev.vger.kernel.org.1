Return-Path: <netdev+bounces-194754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 134DFACC459
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 12:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E00170645
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 10:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C07C2F2;
	Tue,  3 Jun 2025 10:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwJ6PiJB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908282C3250;
	Tue,  3 Jun 2025 10:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748946713; cv=none; b=CXmEbJEdFRy2Mh+1ciQSpjzNvaAIM1pFDi+UnyAuO1VPuLC8ryAFDa10fdWXo4SCa+qoJcF9sqfhz3kBpWmYjbQTPFW2ZTcp5OEO1v/AUiIGnyRwoYXlZN5dJTGFgU8K2Rb2VDBPERv2LLZ5WoCauXk8SNU8Y7Aa7Jlwpj5cON8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748946713; c=relaxed/simple;
	bh=uuxDSrjsyhnVvWBzx2UmTFB7qJOziG5gzMEKf3PHQeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NB+7cUKN4tEjJVE6tQjf+pCA7nsdwb6qCM9lL0KDzlu/EEZu38E7YHADi9BC7soqTvDQCv0DDfnlfmyO7wzEP1lwj/oH5WK3NTmGYYo/nlXgZ/XIXsMNzltux38UIof1VDVhp1KMaWSqU9NUwOVrSBz7VFd+YnByZAIOwndRe88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwJ6PiJB; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70e4bd65106so49826927b3.0;
        Tue, 03 Jun 2025 03:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748946710; x=1749551510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oI326PDFLfEyTSpkHywkLhXfSjGR6hFJeyLyI1zwG0M=;
        b=UwJ6PiJBE+ihaj7qS4+3K5L5jXXVSboGBiUKzpfMZ6asEPXDzt1/xa/X+FITMztfX2
         gmGoO+8Zyl2U1JyZrNiy78SkxgnR6YavYUNLvHKKeQkmjtpJg0L3LSQf9eK1XjScyCBs
         MVZPBHSTbnqaZJGwrIhf6jJaAwHVd9W1HNa0NUwQxdeaxxvaRO/XuMVZt6iLKRtZS/64
         7a8vxk/EoZO623y4RvfVit3EBlczayK48OfNkPMZvCWFCZek89jMCsXjUH719pS36c3b
         Jo5mgOsD6LDoxa/vuQtWcxy4OdfYdlujP0kcD6KLm+Uug68ELtLz4pG8C0RV/3V8nib9
         PLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748946710; x=1749551510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oI326PDFLfEyTSpkHywkLhXfSjGR6hFJeyLyI1zwG0M=;
        b=tzGgHESMj8r/iHT0zV8yIAkkQ+BGIcge7iHkLKbwpPgfcfAFfJsi4I4wikcpt2b9kw
         LmHRXK+nroGTSGyTlfzK2WAIkHk12yqpaKIpuDUIqqVo4L0JY29WraHggeqR0mI+e3do
         IWw5tEL63lW38imjdpOlIpQ4lpxaD1dfmSnfT5deT8gmmcmKFK9TUFtFJxWgd8qX+rZ5
         ZUws83uZ8zjyJEn9yV26sVeAWREmAzBUH5qQTB2esGCbW01pnxo+bs7YQ8w9VGE8+e6k
         mw3PS9yErh+3JRpsRFkCrZZ4XzSwFT7XNqAdxFr6OZM20iLW6MmDASSvYOQJ/wOc3v9f
         BArw==
X-Forwarded-Encrypted: i=1; AJvYcCWVB/WBXonK7wiU3UEXe+Zgmil8c9RZqv12S1ppd9lRp7srjs+RQE+9/r1d4syI5uBcbedfHTt3@vger.kernel.org, AJvYcCWsNRSuWZWOvnEGnqNxtzgflSW7uaZG1S61/g4Qmip40W3W5NHuPsrkcjd7VI0CO+7fBbU6Rp3xYr+n5Is=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3kGq69dxeJqPasPpe6LTYXqe+S6D7HVTMIO7AF+JThuWPsnqP
	c4toop1+8Hw/BdlHgT+jPASWGaFIU9ftJxyOio2j1etl02Jh7jS7DZl3a7eXcdcNVZOn9EKjqdG
	derlf+fVZpxbJ9Bj8R4n+HvN+2UzfTqk=
X-Gm-Gg: ASbGncsR8Rh3cJ0msMJ+Yr4iaR5QbA2fyQDOWD2wBD1ShXa90t6u4JCxlGSshR7nMBL
	9uaZBk3pQEr/0OydM8ttrs2b+a80oS0MhSYtRqNbKwdmgPsDvNVDfpA80qdU08COeVKRW3r79Hg
	yj7B9S4CZ9MTs36rX3J5lY8Rc7LElgxRQ=
X-Google-Smtp-Source: AGHT+IFYA3WBlMtteRm7WFwC2yyhFDBWSC/SzjTMn5wJ4XW1fNJv+N06gqmG3fAX/bXD50JlXqUBTLsU6eG+/nK4NYg=
X-Received: by 2002:a05:690c:3507:b0:70f:8883:ce60 with SMTP id
 00721157ae682-71057d235b9mr236379697b3.26.1748946710432; Tue, 03 Jun 2025
 03:31:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250531101308.155757-1-noltari@gmail.com> <20250531101308.155757-9-noltari@gmail.com>
 <a8332eba-70c3-482a-a644-c86c13792f8b@broadcom.com> <CAOiHx=nmuZe+aeZQrRSB6re1K0G9DzL-+w+dAs5Bkdze72Rf0w@mail.gmail.com>
 <CAKR-sGe7dB9kn28-3mcj41VXpVYGLvLQc85j=JcuJpsT4-6Nrg@mail.gmail.com>
In-Reply-To: <CAKR-sGe7dB9kn28-3mcj41VXpVYGLvLQc85j=JcuJpsT4-6Nrg@mail.gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 3 Jun 2025 12:31:39 +0200
X-Gm-Features: AX0GCFsFZn1C5j_Ne9lcqqgeB1dDnLf6KSY2cR6OJQs5Lz2en_2ixVFPrfS9oM8
Message-ID: <CAOiHx=mBPv-BDO2sDfW0wi_50BUsDje3t0HixVCXaQWLtkOkgQ@mail.gmail.com>
Subject: Re: [RFC PATCH 08/10] net: dsa: b53: fix unicast/multicast flooding
 on BCM5325
To: =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vivien.didelot@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dgcbueu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 12:18=E2=80=AFPM =C3=81lvaro Fern=C3=A1ndez Rojas
<noltari@gmail.com> wrote:
>
> Hi Jonas,
>
> El lun, 2 jun 2025 a las 22:08, Jonas Gorski
> (<jonas.gorski@gmail.com>) escribi=C3=B3:
> >
> > On Mon, Jun 2, 2025 at 8:09=E2=80=AFPM Florian Fainelli
> > <florian.fainelli@broadcom.com> wrote:
> > >
> > > On 5/31/25 03:13, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> > > > BCM5325 doesn't implement UC_FLOOD_MASK, MC_FLOOD_MASK and IPMC_FLO=
OD_MASK
> > > > registers.
> > > > This has to be handled differently with other pages and registers.
> > > >
> > > > Fixes: a8b659e7ff75 ("net: dsa: act as passthrough for bridge port =
flags")
> > > > Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> > > > ---
> > >
> > > [snip]
> > >
> > > > +/*****************************************************************=
********
> > > > + * IEEE 802.1X Registers
> > > > + *****************************************************************=
********/
> > > > +
> > > > +/* Multicast DLF Drop Control register (16 bit) */
> > > > +#define B53_IEEE_MCAST_DLF           0x94
> > > > +#define B53_IEEE_MCAST_DROP_EN               BIT(11)
> > > > +
> > > > +/* Unicast DLF Drop Control register (16 bit) */
> > > > +#define B53_IEEE_UCAST_DLF           0x96
> > > > +#define B53_IEEE_UCAST_DROP_EN               BIT(11)
> > >
> > > Are you positive the 5325 implements all of those registers? They are
> > > not documented in my databook.
> >
> > They are in 5325E-DS14-R pages 112 - 112 (134/135)
> >
> > That being said, I don't thing we need to touch the MC/BC/DLF rate
> > control registers when enabling/disabling flooding - these only limit
> > how much traffic may be UC / MC  on a port, but apart from that they
> > do not limit flooding. We don't limit this on other switch models
> > either.
>
> In that case there's nothing to enable/disable on the BCM5325 and we
> should do an early return on b53_port_set_ucast_flood and
> b53_port_set_mcast_flood since UC_FLOOD_MASK, MC_FLOOD_MASK and
> IPMC_FLOOD_MASK don't exist.

You are adding calls to modify the B53_IEEE_UCAST_DLF and
B53_IEEE_MCAST_DLF registers, which are fine and look correct. And
AFAICT these are the equivalent to UC_FLOOD_MASK and MC_FLOOD_MASK,
with no IPMC_FLOOD_MASK equivalent.

It's only the rate control ones I'm not sure are the right thing to
do, at least in the same patch.

Regards,
Jonas

