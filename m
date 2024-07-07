Return-Path: <netdev+bounces-109677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4376892983A
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 15:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869C3281538
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 13:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5905210E7;
	Sun,  7 Jul 2024 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8FO1svc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C0022612
	for <netdev@vger.kernel.org>; Sun,  7 Jul 2024 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720360663; cv=none; b=ZUkd1eDTEDDqhIqBAHcZAYriI3OnEBqUNCxaJojVDKXzTHkYdCGHvy9vCMP20SRxGZETQW8QcemEG0G4KfISa62ypzVPjbWf5uVQn1N4fqD3Kdo1h70ac1M98DN1WY4r8r/FPBgCX/myKKUln4COuKcRdgr6NCqX2zMELKDNJNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720360663; c=relaxed/simple;
	bh=WwXw8EVPIbw56+Q2pOYW5wV7aVKGnGP4o9krqM3EjuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=InnDEyzSg11Fv7DXGJUae2T8odQNiy2QrM8TNKQelHqdjRdb1OjhhlexMmUKnOEhUKZMllYPrS31Swlx3Vs4yCmByKxK2f336qMsQAp18RGVdevHpoZNjJPk/7D+aEFbMJnIT1XX5CAt6Nm4nz8UsqZprfgtkIokKwhLC3hBMl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8FO1svc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9B8C4AF10
	for <netdev@vger.kernel.org>; Sun,  7 Jul 2024 13:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720360663;
	bh=WwXw8EVPIbw56+Q2pOYW5wV7aVKGnGP4o9krqM3EjuA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d8FO1svcKlBI+NqwsSSeju1A8AAImfc7CkldX72T3nJHT5dDYRezHt9gCPoBMsCDl
	 sNJ9CErRbnwWeUJESYLphzyh7IUBw7lPjNnOepQ4mvTXx2DsILEF8FYntB0elSPUPG
	 5myqU2zWwHeUxAeGWRn/Ii8CTpZFr3IQduJi1usG633SzGa1scuOKNWzLZJcsV9uJk
	 9w20thaCNil+KdTiFsvalbLywliR3IULG1sichlB+7KcRb9oCnOIIsw4nRsTY51nuf
	 +lKo1DDlsHfKyVLKEU/dbeRTCTu2Q+xpApqt48A3feJzMQ4v2xIeF+3VQN3zmipxCx
	 fYYbPIE/cO52A==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58b0beaf703so3590934a12.2
        for <netdev@vger.kernel.org>; Sun, 07 Jul 2024 06:57:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7gLg/yguNgb+KytQWh9ljeZmtaggjAEzbBRjKDnHfOLv4BXIILdlZ0Zft1TxxbqJh+DXivWHhBvsY6t7JpIlv0MEj3qJ9
X-Gm-Message-State: AOJu0YwPIqmVFnG4DIVxuFUlK8cCoObgBp7rjBrk2fcdDIDyVYbg0C7d
	z6zrS/F7qoANbPHRMXJEwO4YnNOYzBBc0f6l6K2I7JcCVm+tARC7ARJ27B+z9GfyEqdDNqWe9Is
	qrg2dykwpaT0L6cDnV+JKvP6vpS0=
X-Google-Smtp-Source: AGHT+IEcVF/ll1Ap/rucx7t12aUCrW0IbtE7yYcJ+6tZUKQN1qxOGONK5qa1Y3RLKhL2CfVqweZnMiKQJsDVn54PcUc=
X-Received: by 2002:a17:907:608f:b0:a6f:e819:da9c with SMTP id
 a640c23a62f3a-a77ba4cffbamr690322866b.43.1720360661727; Sun, 07 Jul 2024
 06:57:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716973237.git.siyanteng@loongson.cn> <16ec5a0665bcce96757be140019d81b0fe5f6303.1716973237.git.siyanteng@loongson.cn>
 <ktvlui43g6q7ju3tmga7ut3rg2hkhnbxwfbjzr46jx4kjbubwk@l4gqqvhih5ug>
 <CAAhV-H4JEec7CuNDaQX3AUT=9itcTRgRtWa61XACrYEvvLfd8g@mail.gmail.com>
 <yz2pb6h7dkbz3egpilkadcmqfnejtpphtlgypc2ppwhzhv23vv@d3ipubmg36xt>
 <8652851c-a407-4e20-b3f3-11a8a797debf@loongson.cn> <kgysya6lhczbqiq4al6f5tgppmjuzamucbaitl4ho5cdekjsan@6qxlyr6j66yd>
 <2b819d91-8c2a-4262-9cbb-c10e520f10c9@loongson.cn> <CAAhV-H6ZzBJHNqGApXc-5wiCt9DqM51TMkC2zmj5xhoC-rfrnA@mail.gmail.com>
 <d7s5plkdd2ihxlhnvpds2r4dywivkfkszew567uevzkfv56ae2@r3p6asvdyu3j>
In-Reply-To: <d7s5plkdd2ihxlhnvpds2r4dywivkfkszew567uevzkfv56ae2@r3p6asvdyu3j>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 7 Jul 2024 21:57:28 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6A_=5MjC1iriO2fHbvamLXkcn9susXxpru2LN5Qu0xLA@mail.gmail.com>
Message-ID: <CAAhV-H6A_=5MjC1iriO2fHbvamLXkcn9susXxpru2LN5Qu0xLA@mail.gmail.com>
Subject: Re: [PATCH net-next v13 14/15] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Yanteng Si <siyanteng@loongson.cn>, andrew@lunn.ch, hkallweit1@gmail.com, 
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	Jose.Abreu@synopsys.com, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 7, 2024 at 6:51=E2=80=AFPM Serge Semin <fancer.lancer@gmail.com=
> wrote:
>
> On Sat, Jul 06, 2024 at 06:36:06PM +0800, Huacai Chen wrote:
> > On Sat, Jul 6, 2024 at 6:31=E2=80=AFPM Yanteng Si <siyanteng@loongson.c=
n> wrote:
> > >
> > >
> > > =E5=9C=A8 2024/7/5 20:17, Serge Semin =E5=86=99=E9=81=93:
> > > > On Fri, Jul 05, 2024 at 08:06:32PM +0800, Yanteng Si wrote:
> > > >>>>> But if you aren't comfortable with such naming we can change th=
e
> > > >>>>> macro to something like:
> > > >>>>> #define DWMAC_CORE_LOONGSON_MULTI_CH    0x10
> > > >>>> Maybe DWMAC_CORE_LOONGSON_MULTICHAN or DWMAC_CORE_LOONGSON_MULTI=
_CHAN
> > > >>>> is a little better?
> > > >>>>
> > > >>> Well, I don't have a strong opinion about that in this case.
> > > >>> Personally I prefer to have the shortest and still readable versi=
on.
> > > >>> It decreases the probability of the lines splitting in case of th=
e
> > > >>> long-line statements or highly indented code. From that perspecti=
ve
> > > >>> something like DWMAC_CORE_LS_MULTI_CH would be even better. But s=
eeing
> > > >>> the driver currently don't have such cases, we can use any of tho=
se
> > > >>> name. But it's better to be of such length so the code lines the =
name
> > > >>> is utilized in wouldn't exceed +80 chars.
> > > >> Okay.
> > > >>
> > > >> I added an indent before 0xXX and left three Spaces before the com=
ment,
> > > >>
> > > >> which uses huacai's MULTICHAN and doesn't exceed 80 chars.
> > > > I meant that it's better to have the length of the macro name so
> > > > !the code where it's utilized!
> > > > wouldn't exceed +80 chars. That's the criteria for the upper length
> > > > boundary I normally follow in such cases.
> > > >
> > > Oh, I see!
> > >
> > > Hmm, let's compare the two options:
> > >
> > > DWMAC_CORE_LS_MULTI_CH
> > >
> > > DWMAC_CORE_LS_MULTICHAN
> > >
> > > With just one more char, the increased readability seems to be
> > > worth it.
> > If you really like short names, please use DWMAC_CORE_MULTICHAN. LS
> > has no valuable meaning in this loongson-specific file.
>
> At least some version of the Loongson vendor name should be in the
> macro. Omitting it may cause a confusion since the name would turn to
> a too generic form. Seeing the multi DMA-channels feature is the
> Synopsys invention, should you meet the macro like DWMAC_CORE_MULTI_CH
> in the code that may cause an impression that there is a special
> Synopsys DW MAC ID for that. Meanwhile in fact the custom ID is
> specific for the Loongson GMAC/GNET controllers only.
Well,
I prefer
DWMAC_CORE_LOONGSON_MULTI_CHAN / DWMAC_CORE_LOONGSON_MULTICHAN /
DWMAC_CORE_LOONGSON_MCH / DWMAC_CORE_MULTICHAN,
But I also accept DWMAC_CORE_LS_MULTI_CHAN / DWMAC_CORE_LS_MULTICHAN,
But I can't accept DWMAC_CORE_LS2K2000.

Huacai

>
> -Serge(y)
>
> >
> > Huacai
> >
> > >
> > >
> > > Thanks,
> > >
> > > Yanteng
> > >

