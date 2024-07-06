Return-Path: <netdev+bounces-109622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF080929299
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 12:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56C2281863
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 10:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F075560B8A;
	Sat,  6 Jul 2024 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qocugEfu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEE9482C6
	for <netdev@vger.kernel.org>; Sat,  6 Jul 2024 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720262181; cv=none; b=YnUWfB9Rk+PEak1MyyRSgvzXSWkzZT4pKvx3TRqiENDd+Q01RnFPpfOTAf7qu6B0Wu7XV29F4zUXxXIdqODRpKop1HBTdw29HA1gQGVdzHqwbYRvBsw4+kIovkvZr2lSYqnXwb3ZNsQBjzikdLIhJm1kou8oK0nLlF6WAdqFGzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720262181; c=relaxed/simple;
	bh=2Hh1ZgnzffR80ZpYUcHKZxfXmhH5Jq9yRBC9ByE6UWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMUc+1q9XSJ5hrJQA2TtUfMBnbebexQ3qk091f1/6CKBMppSmU1VHdusZnORrIoDAAyO60onIHMJ9Ttp475pOZUwptHacGEIwb7P8mMxYccyGYmm6U2xTLLlidktzlHAy6o09dUcjQs1GCBpi1IXBkEr2OUzpprcZ/M+pedYWfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qocugEfu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AE2C4AF0F
	for <netdev@vger.kernel.org>; Sat,  6 Jul 2024 10:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720262181;
	bh=2Hh1ZgnzffR80ZpYUcHKZxfXmhH5Jq9yRBC9ByE6UWM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qocugEfubxwAg5TxyXfgj2QedNmDugEWpNRh88IfmyBQXY56GSjTHzrB0SL5AR3Rd
	 nqgM5QXG5uOw4naaBa/wOAXqVdyotlWpHyiLZfRz9gC8Wyv/bo0ocoZe1lE+/Wggig
	 FJMqv1w7YJKueu3m6LQ0H6Ee42C6RnkNASoBEPbj1b55zhHxYrE0NeFHCus3u7AO/6
	 6C+V1p/v8J7pZ8MQkOHNxS1qPV0XrgUSv3CqXDzzQDEfR92EfbhJYo3YnBFHfMEmsK
	 ibRielU4o21C5bY6QnBx+g5OWiErDvjSgeWFcgz0hbG4uhnZp9kFFaLBmZVU8BvHN3
	 6BeMJ0HFK2HUA==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a77e7420697so27061066b.1
        for <netdev@vger.kernel.org>; Sat, 06 Jul 2024 03:36:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUuzrjRDSdqMoDT+D1dAqioJRe/7NmQq/5ZKdo8A/n4mJm9b7bj1/l5hQyyv1f736hOKDnZMe7dKn5Sg67R2X6itELpToCZ
X-Gm-Message-State: AOJu0YyjtGL0H0wzU0/7sro1xkiMMDbD7GOE1pHbi3EVGFvzAAOLfXEv
	BTo1m201AFonSGYHEu0JJ8Bq1nWNb0wNmEjS0ME+/ELS1KDSX0s2ROwHUBAPIp9IgOqi8wIuh5M
	E3igdRux6n0N9U4/s2omFnQmdlps=
X-Google-Smtp-Source: AGHT+IHoc1Ozq1ktxMaj0iShUNiaSoAHUT7LgyYz75ipsaXfOJg5Dh5FP81HHDgCjMaYRfopLn9NDfLsWlO80g6FsQQ=
X-Received: by 2002:a17:906:a38c:b0:a6f:6b6a:e8d0 with SMTP id
 a640c23a62f3a-a77ba44d2fdmr440685566b.7.1720262179870; Sat, 06 Jul 2024
 03:36:19 -0700 (PDT)
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
 <2b819d91-8c2a-4262-9cbb-c10e520f10c9@loongson.cn>
In-Reply-To: <2b819d91-8c2a-4262-9cbb-c10e520f10c9@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 6 Jul 2024 18:36:06 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6ZzBJHNqGApXc-5wiCt9DqM51TMkC2zmj5xhoC-rfrnA@mail.gmail.com>
Message-ID: <CAAhV-H6ZzBJHNqGApXc-5wiCt9DqM51TMkC2zmj5xhoC-rfrnA@mail.gmail.com>
Subject: Re: [PATCH net-next v13 14/15] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
To: Yanteng Si <siyanteng@loongson.cn>
Cc: Serge Semin <fancer.lancer@gmail.com>, andrew@lunn.ch, hkallweit1@gmail.com, 
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	Jose.Abreu@synopsys.com, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 6, 2024 at 6:31=E2=80=AFPM Yanteng Si <siyanteng@loongson.cn> w=
rote:
>
>
> =E5=9C=A8 2024/7/5 20:17, Serge Semin =E5=86=99=E9=81=93:
> > On Fri, Jul 05, 2024 at 08:06:32PM +0800, Yanteng Si wrote:
> >>>>> But if you aren't comfortable with such naming we can change the
> >>>>> macro to something like:
> >>>>> #define DWMAC_CORE_LOONGSON_MULTI_CH    0x10
> >>>> Maybe DWMAC_CORE_LOONGSON_MULTICHAN or DWMAC_CORE_LOONGSON_MULTI_CHA=
N
> >>>> is a little better?
> >>>>
> >>> Well, I don't have a strong opinion about that in this case.
> >>> Personally I prefer to have the shortest and still readable version.
> >>> It decreases the probability of the lines splitting in case of the
> >>> long-line statements or highly indented code. From that perspective
> >>> something like DWMAC_CORE_LS_MULTI_CH would be even better. But seein=
g
> >>> the driver currently don't have such cases, we can use any of those
> >>> name. But it's better to be of such length so the code lines the name
> >>> is utilized in wouldn't exceed +80 chars.
> >> Okay.
> >>
> >> I added an indent before 0xXX and left three Spaces before the comment=
,
> >>
> >> which uses huacai's MULTICHAN and doesn't exceed 80 chars.
> > I meant that it's better to have the length of the macro name so
> > !the code where it's utilized!
> > wouldn't exceed +80 chars. That's the criteria for the upper length
> > boundary I normally follow in such cases.
> >
> Oh, I see!
>
> Hmm, let's compare the two options:
>
> DWMAC_CORE_LS_MULTI_CH
>
> DWMAC_CORE_LS_MULTICHAN
>
> With just one more char, the increased readability seems to be
> worth it.
If you really like short names, please use DWMAC_CORE_MULTICHAN. LS
has no valuable meaning in this loongson-specific file.

Huacai

>
>
> Thanks,
>
> Yanteng
>

