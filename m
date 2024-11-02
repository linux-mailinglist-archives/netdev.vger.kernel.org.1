Return-Path: <netdev+bounces-141194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821269B9FD9
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 12:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7DDCB2157D
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 11:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3034A187355;
	Sat,  2 Nov 2024 11:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7YUAfqa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B88156C5E;
	Sat,  2 Nov 2024 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548767; cv=none; b=SLZBR7ZCZjycAsjsUaTNKsIG22LBtW/0AV5/00z741TAk5ZsKfJo24Rs4VvSAiEQytBlhoneJYVUpg3Eb8qpyLb7wUbPj8ybDlZBjhjKflYq+tTong/Fe4JGlUvPMS0uicg27Q605bsKqFfUpDaI6WwZxIGTqDaPUlMrEYULoyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548767; c=relaxed/simple;
	bh=6BZBv2koBZFEV3fNfwGJ8Fje5PDD4OA7Ov5A9pHFnMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RpVmikyo6pvu9C9ApG/9rWzPHclHF+1t7+OFQjwnBGbzmu5+uFImS3uN0LmVpLOA4GvXkewU73uLhqXCrQ6mY+eELK/t3QseDYD9YQpcMgWT/w0RoUbsh+yyOvR5cG0PWEwQgoiOG9b8BWDFhnBh6nyVd2R8N5uy2dymMHP9vZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7YUAfqa; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e344ccb049so1751507b3.0;
        Sat, 02 Nov 2024 04:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730548764; x=1731153564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8eATJCki+TxES4vc6y+ssSPQ0d6v6bnz/0z0oHNrr0=;
        b=i7YUAfqar32MOhmejoUDmXsd0yOIy8emH7h4B2NU75HrKFsb9WlQre+0pa9CXa/3E9
         nVKXWFDgO6Oo2+hOd8g3UOX6sEz/Pcn38yDemgC07MUpndGXCTXZ7FmGqg1n0OELeyDC
         i4THzsrQMMQOcdYbJuxtLsDGEkEIRRJ5tPcJ4O2PKfuR8yt8cWSdN9yS0O6Buom/wPHu
         qdh6TK/+YgX4Duo+de0ks9T2GUZIsMKuJIOAIDHYuyxTcu4xZulYABski5fS7+/yAteh
         8WkFUvlpaxgEEl8v5bQuAIYvy/CD0XKkjQF/bMFukCFLSIh01EM+zQbpJtZTaUxuV7LC
         02UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730548764; x=1731153564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8eATJCki+TxES4vc6y+ssSPQ0d6v6bnz/0z0oHNrr0=;
        b=cAOkNer8mynA+AF2q8s5LcNbb4CHfEEBxJS5u4k/PPdiw2RNYRR5W9dYTdTzsJIiaX
         zPC3RsfpDRf3KcgrSbtvIYTpzfCC7GKFKFZf7yFBsSBfxu9C9bCO38U/xx7ZAe5ULaXq
         K0shmOghWBsR5bmaYlkb8APaHvtJslKH7Z1feGPHJBr+iQ28Dzpun43gnltnqFDXaSLc
         X8ECgsuBPY2i8mZtiGzyCCiFHeBfeFZNH2lEG8FV/1qlVLKI/klsM79fO+EUf7ZTuG87
         /UjoVuG1aq52BFnxtNTvrDDUDTVIKBfEuqJsdZFdNdgRoW0MeqQt57VN9yA9q70HiL4q
         tZ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUM5OD6Kq7nDX/xleiUp7/ApyzQOKKji+YFFeqPC5ACbvlFNpKcSKJJFsKiTADVhjZKzYlL9Ty9JZHl/nnO@vger.kernel.org, AJvYcCVWddnQZwcspE1lCUtB9uy57sTepE76fJ4CYMTvxwoMiwkZZjFveznBkF4PEhteMxNRO58Z2Mzc@vger.kernel.org, AJvYcCXGmwHDqC8v6awd1LMQR8tRFKvWSIBECOabojU6EKMBl7wY9V8fBjz8X57R4IwKmR+sZmyGN2L72kbK@vger.kernel.org
X-Gm-Message-State: AOJu0YzfW0ruumPIye4Y4mzmmtzaqetRQz1G/oEKFqvznjNfJqdt5Axs
	SunQ214duHIMovb6YzXfx0hnh6JxYH3Oy6R8cIPu+vNy+OxXWi9BYvG6nnd6JkvqLjoHSBefNPa
	dzdHrMOWaynzAqJGD3LGhybfXbNE=
X-Google-Smtp-Source: AGHT+IFMbxyKVoPx41xbCrD0GPiI2GpxGV8kau6mx1CGcW2fC32QAQ0PlbBb0QPHWgT/KLrfKzplVdzjum4zHSCNoGI=
X-Received: by 2002:a05:690c:4484:b0:6d3:c7d:5eaa with SMTP id
 00721157ae682-6e9d8b22e4amr116494867b3.8.1730548764251; Sat, 02 Nov 2024
 04:59:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029202349.69442-1-l.rubusch@gmail.com> <20241029202349.69442-12-l.rubusch@gmail.com>
 <20241101193528.GA4067749-robh@kernel.org>
In-Reply-To: <20241101193528.GA4067749-robh@kernel.org>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sat, 2 Nov 2024 12:58:47 +0100
Message-ID: <CAFXKEHa5A039NfyGFnXH4pm1FN9YwDuTLtoa9Xn8xzZYwTCvKg@mail.gmail.com>
Subject: Re: [PATCH v4 11/23] net: stmmac: add support for dwmac 3.72a
To: Rob Herring <robh@kernel.org>
Cc: krzk+dt@kernel.org, a.fatoum@pengutronix.de, conor+dt@kernel.org, 
	dinguyen@kernel.org, marex@denx.de, s.trumtrar@pengutronix.de, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 8:35=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Oct 29, 2024 at 08:23:37PM +0000, Lothar Rubusch wrote:
> > The dwmac 3.72a is an ip version that can be found on Intel/Altera Arri=
a10
> > SoCs. Going by the hardware features "snps,multicast-filter-bins" and
> > "snps,perfect-filter-entries" shall be supported. Thus add a
> > compatibility flag, and extend coverage of the driver for the 3.72a.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c   | 1 +
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c b/driv=
ers/net/ethernet/stmicro/stmmac/dwmac-generic.c
> > index 598eff926..b9218c07e 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
> > @@ -56,6 +56,7 @@ static const struct of_device_id dwmac_generic_match[=
] =3D {
> >       { .compatible =3D "snps,dwmac-3.610"},
> >       { .compatible =3D "snps,dwmac-3.70a"},
> >       { .compatible =3D "snps,dwmac-3.710"},
> > +     { .compatible =3D "snps,dwmac-3.72a"},
> >       { .compatible =3D "snps,dwmac-4.00"},
> >       { .compatible =3D "snps,dwmac-4.10a"},
> >       { .compatible =3D "snps,dwmac"},
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/dr=
ivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > index 54797edc9..e7e2d6c20 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > @@ -522,6 +522,7 @@ stmmac_probe_config_dt(struct platform_device *pdev=
, u8 *mac)
> >       if (of_device_is_compatible(np, "st,spear600-gmac") ||
> >               of_device_is_compatible(np, "snps,dwmac-3.50a") ||
> >               of_device_is_compatible(np, "snps,dwmac-3.70a") ||
> > +             of_device_is_compatible(np, "snps,dwmac-3.72a") ||
>
> All these of_device_is_compatible() checks should really go away and all
> the settings just come from match table data. Then everything is const
> and we're not matching multiple times at run-time. That would be a bit
> of refactoring though...

I can see your point, but I have some doubts on that. As I asked
before, my current scope is actually on upstreaming my .dts/.dtsi
files. This would be nice, since I'm doing it in parallel in u-boot
and they're going to dts/upstream so we're waiting on the kernel
community here.

I'm unclear what additionally to fixing my .dts files is needed. Shall
I fix all? / some? / none? of the errors your dtbs check bot gives?
First, most of the errors come from not covered bindings. Since TXT
files for socfpga never were converted to YAML. Should I do this? I
guess this would increase coverage of dt-bindings check and reduce the
errors tremendously. But I'd see it as a different patch set if so. Is
this needed to upstream my .dts files?
Second, the maintainer of platform socfpga seems to be currently on a
sabbatical. At least I hope he's fine and not sick or burned out. But
also I would like to get some feedback on the .dts files. Please help
me if you can give me some.
Third, when I update things like the mentioned dwmac things and try to
update the driver compatible to best of my knowledge, I understand
that it would be better to refactor a redundantly checked
compatibility to just one check in the driver.
But, I only have one hardware: an Arria10 SOM which is affected here.
And, is it really anyway needed to refactor networking drivers for
upstreamining my .dts/.dtsi files at the end of the day?

Please don't missunderstand me. I can absolutely see your point here
and appreciate all type of feedback. Anyway IMHO these are all
different topics i.e. different sets of patches, or smells a bit like
scope creep. I separated the 2 patches for a different set, as Jakub
wrote.

