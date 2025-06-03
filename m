Return-Path: <netdev+bounces-194751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FD0ACC438
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 12:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496E73A34EB
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 10:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C24B1C3C1F;
	Tue,  3 Jun 2025 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9K8a4Ky"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39B91531E3;
	Tue,  3 Jun 2025 10:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748945931; cv=none; b=tRxlF4B29jOFze4406cG/S8c03SoZQWGIejF6jGq0nTdBOAY6zq45y8kwrM3TaoqMD0+xEYmv8LqkBTClajLGS20sE3lJxvTdrzMDNy/T75JA1kul2D+X17UiQr3OsLS+isxtV5aqneBY3dQ2VnqIJDHC+l0ccIfbID4q0qiHYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748945931; c=relaxed/simple;
	bh=myd45d0i3xtNd60c7nVWYYckLHlit4IIiH9M202Dspk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GdqUFjcveLoNkUXnqjfPTabm55utniWi0d9AhRIjuh8apF0U00OyFOLCP9XS7lmS5Vmtr9SGU6acodZqr5hDifXq3MdsTvwa3W/D1baQr52C+RuydmL3dlbox3fuP+BlWouZckh/5rHH0yKHDATe4gIkGlilCcvzM0ivPb5krxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9K8a4Ky; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3109f106867so6830624a91.1;
        Tue, 03 Jun 2025 03:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748945929; x=1749550729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70huqT6ptBSO340GgOIthwb677KQu/LcWxypJ+D6Bb4=;
        b=B9K8a4KyWTVMTTHNv02YZVR6pRTOPQVde3rLGuzablf2Ax3DrXUc2SMm2TRxLFAElV
         DMpzUZQOMWjCcHroN6UvQteuUiTMsKBS+IHtwxg4XwOiKRMGDf+tdwEDr1Snw4Ccbv3B
         KMbt//s2KVl3cf/M1bPlRlxaVfP2QwYmhskXlUzbW66uXD/ohqxUOrvrVjCQ/gAGJ/5b
         IBFZ57w2h7cKBi3AyJyEV8Llust5t3WGljDDMsRtZnNLKf98qjTp8oZFcrrrzbUKysP/
         /Oisk0a2XPM11K2PMTl06KXRrjAtM/WXf/ZQQxIx3Gr+Y4kHqJVdUorqfKzplC2T15Z3
         Kaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748945929; x=1749550729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70huqT6ptBSO340GgOIthwb677KQu/LcWxypJ+D6Bb4=;
        b=R4MnyZQLiRmKhIhuSpaLdMscxCJ1MtcPNjD6bh48AhGR1w6uPbFJURF6MkdyGywYiG
         /htC8pbWnw6czGDA+8kLFj1ysCHhPI2DfDO16kq9rSrSC+lywOrT2dNpllzYrMXCZ7ha
         NpOZGFCWTcmltVVcs4MjuT880Po0m8pdzzRz5p+pOw9BRxzznRqxIsQpxFEUkrssIJiH
         XVhew/iUogg8DaQio3nNTb6ZyKYUZt/MqRBuupNm9QuoscZIXcys7a+qX7d/G9/Yz3/9
         HQTyuVEIPuMybT/U66BBQ/yjLMC6I79ZEMm9DmLlpQTTfNfKvhT0HtGP9nGDnVYYy0iZ
         648w==
X-Forwarded-Encrypted: i=1; AJvYcCUCR/M34Ozjd/V+XbR/vHKxQ2FUv47FxqtbDxDplxXNTE4YxeUVOomLxm0/NMaYbFZl748wQ8peHea5PRE=@vger.kernel.org, AJvYcCV5RHJtxWhPn3p2cckMjOCUsWX8V1l4hpTIa4QuMUattj6K4R4VLKvD7QwGnvU/J9iOiUm1xS27@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4iANQyCEKOz4fHf6ZwML7EancQzX62jT3EKrvODDnlOixkfp9
	GpO4N4BPZQTAbu5keeHfuIi72cdr3QGA7hrTlHdEkvoK0nYR04nqAoARYNi/JvMa4nhvk1FackB
	su/B2hQ4vDnhtMAozwPyQWhaBo0Ya19c=
X-Gm-Gg: ASbGncvm7USg8lJIh02cYrcDmriUbQoPZr5OEYyhH+ekmFIUEekW1u5KZzMjZw/qhDz
	eNmQeHIoxl9usGUjdIqtxGcWgi+Ews4VvnWXSUWGmebkpENdW4ZKHlumzf++hmjQ6NMX9oY1edN
	WhlgObAqMIhWpAmpGYQi5Gi2V/RvLviXGmSMm+Ug/XIjWLrO5I25jmf3YhZSiqp6dfSPQ=
X-Google-Smtp-Source: AGHT+IFKdJlxQDPpwIlOWRylCF1tesMVeTdg7R2okl539fFA1Vg3wuEauXM5tgTgd+fNiRzwCx4qmhOuDVvam+0erWg=
X-Received: by 2002:a17:90b:4c09:b0:312:1b53:5ead with SMTP id
 98e67ed59e1d1-31240d1c0d7mr23255282a91.4.1748945928882; Tue, 03 Jun 2025
 03:18:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250531101308.155757-1-noltari@gmail.com> <20250531101308.155757-9-noltari@gmail.com>
 <a8332eba-70c3-482a-a644-c86c13792f8b@broadcom.com> <CAOiHx=nmuZe+aeZQrRSB6re1K0G9DzL-+w+dAs5Bkdze72Rf0w@mail.gmail.com>
In-Reply-To: <CAOiHx=nmuZe+aeZQrRSB6re1K0G9DzL-+w+dAs5Bkdze72Rf0w@mail.gmail.com>
From: =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Date: Tue, 3 Jun 2025 12:18:15 +0200
X-Gm-Features: AX0GCFv4JEbh2JLg-oJFNxNP6YLTksnO0gB3S-DotEdw2V91RfbTd5BRS5LyFL8
Message-ID: <CAKR-sGe7dB9kn28-3mcj41VXpVYGLvLQc85j=JcuJpsT4-6Nrg@mail.gmail.com>
Subject: Re: [RFC PATCH 08/10] net: dsa: b53: fix unicast/multicast flooding
 on BCM5325
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vivien.didelot@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dgcbueu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

El lun, 2 jun 2025 a las 22:08, Jonas Gorski
(<jonas.gorski@gmail.com>) escribi=C3=B3:
>
> On Mon, Jun 2, 2025 at 8:09=E2=80=AFPM Florian Fainelli
> <florian.fainelli@broadcom.com> wrote:
> >
> > On 5/31/25 03:13, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> > > BCM5325 doesn't implement UC_FLOOD_MASK, MC_FLOOD_MASK and IPMC_FLOOD=
_MASK
> > > registers.
> > > This has to be handled differently with other pages and registers.
> > >
> > > Fixes: a8b659e7ff75 ("net: dsa: act as passthrough for bridge port fl=
ags")
> > > Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> > > ---
> >
> > [snip]
> >
> > > +/*******************************************************************=
******
> > > + * IEEE 802.1X Registers
> > > + *******************************************************************=
******/
> > > +
> > > +/* Multicast DLF Drop Control register (16 bit) */
> > > +#define B53_IEEE_MCAST_DLF           0x94
> > > +#define B53_IEEE_MCAST_DROP_EN               BIT(11)
> > > +
> > > +/* Unicast DLF Drop Control register (16 bit) */
> > > +#define B53_IEEE_UCAST_DLF           0x96
> > > +#define B53_IEEE_UCAST_DROP_EN               BIT(11)
> >
> > Are you positive the 5325 implements all of those registers? They are
> > not documented in my databook.
>
> They are in 5325E-DS14-R pages 112 - 112 (134/135)
>
> That being said, I don't thing we need to touch the MC/BC/DLF rate
> control registers when enabling/disabling flooding - these only limit
> how much traffic may be UC / MC  on a port, but apart from that they
> do not limit flooding. We don't limit this on other switch models
> either.

In that case there's nothing to enable/disable on the BCM5325 and we
should do an early return on b53_port_set_ucast_flood and
b53_port_set_mcast_flood since UC_FLOOD_MASK, MC_FLOOD_MASK and
IPMC_FLOOD_MASK don't exist.

>
> Regards,
> Jonas

Best regards,
=C3=81lvaro.

