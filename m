Return-Path: <netdev+bounces-139424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19A49B2382
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 04:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D6028176C
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 03:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EDA189913;
	Mon, 28 Oct 2024 03:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vo22N6rP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1282188A0C;
	Mon, 28 Oct 2024 03:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730085870; cv=none; b=TL9LhoVxEIBHU+qsIFSRObkHS7PSpQWdStJCKKpes3xt5MVz/XQxGWMVuDFfR0Z+n1xH/tbIBEVBYyOxknBZs3g2VjlLmdgR5d1pv5vqTkfu3c8i6QkEBHxPWwnA0Bs3t22hiQvva1nz1QTS924ur0yqjB4NtZQBK9imPNeMNnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730085870; c=relaxed/simple;
	bh=zE7eCy/1afvnVV7jCXuMku+GBh/gDHAiY4CVzFxB4sQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wt87/BPFjp4wNyo71+fR05ag87gMLUPc9acyztLVOj+aJxa7lXYUYXJ97yBHJ9FaI3jXN5MzSIywxfWgfxiZQOW5OpaISAfB300wk8b233+t/xIJXc56eV1dUxxjhToUWglkh7LMLKT7Py2AqlQwNxigwB9StI33aVkmKM2sB9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vo22N6rP; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e2e2baf1087so3796009276.2;
        Sun, 27 Oct 2024 20:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730085866; x=1730690666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LsMfBBmOBwWJ706gG81NMDaw5BKeazByaIcL6Ba5p4=;
        b=Vo22N6rPbOe2f6fsnooGb2itwtfX8jqUt5shf9g/eKvGsNW+gsY27DasuBRs5tpNg7
         z98zbnKWcesZD5ccu+Kw+lyTNwNfve8Pyeyi7UNbz6Qm8E52FEbE90Qj8c/khq4y82/h
         yx3qvbX1/9x/A/bqrBg8AumoMsm0jyeWkxch2lBUr8oVDSF8RYrlzRcgCA4dxz4hXu/p
         tF1WT5Nta16ZERRCaGU1+5nQUGRVIR0BppTFGSgNMEHmvBVZVI7ETEMD8GXC0R6FWBH8
         G6MFpQJ6Poklhf2FGRQofZk9cnwro9oJ8th8BKY3I4UyE6SNgQxYPnwdydIkYdPaClMx
         Uo+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730085866; x=1730690666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LsMfBBmOBwWJ706gG81NMDaw5BKeazByaIcL6Ba5p4=;
        b=TGQfcaZfl+hMS1uMIEp8G6rceTMmJZsGBSv6VAtXMRglMyZIuwGAyd4ywheqpQ6fgc
         IzmPp8NwTP0kzrgSj46a+jE47kZgmoAkYY0HnfGOE+Gvz2+UHSxvYfrdTofu5PrOZ2cq
         2LW9TGBb9JQAT2WNZdHSuqPo09T2ZVbYimS7ucHuUXBy+PpKn67dXwvwZCt3g1fS5fOV
         +QPItOrm61pmu0k1Pbv6xTEZsdwftm0f00s0KMl7G/2CO51Jg/WxY4hHu5JA0ktxdamm
         oJ8ipTbMh3skaE6+UsUYrHBPfNIrWbvpV0SWq+d3uDzkV+dTeATgqYoBOOzIlujD5vrN
         CQ5w==
X-Forwarded-Encrypted: i=1; AJvYcCW3f3fSKQ0VXB6wSbw8Gw7rXsO+LTtUGHKJvB1e4Yx6m7TLN/yYLcgC1pmIhpM3eRSBrONzxpvq@vger.kernel.org, AJvYcCWHRMV4X97HyjS9zGK8WUA96Y42oWPBaTYjJWkCNF13bH7sU9EC5s47Sd5L6PndZZRi3lMRqHcZ6Mc+Dqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxygS6UY7t1bFvY8H1fhGAaPbi7szeTlujlwTD9jvjk9HrfmfdM
	2U4/0gxMNz6Ko9vZNQ8zt3WXedNTrzslBmC0xgcMrT20bYn0CMVOM/+bSVpGaFLyAGMciZdYVlG
	jm9sXbfhJwu6Y0/9XWVlns3xo/hc=
X-Google-Smtp-Source: AGHT+IGRY3rC/NrdebzcOHdIAZjlwCiuV3fa+vk8Et1mo1f2JvxrEQedTw7LqVt3Q/akWIRXPvoKSaEHYH3jE9P1bXM=
X-Received: by 2002:a05:690c:b8a:b0:672:8ad4:9461 with SMTP id
 00721157ae682-6e9d8b3c742mr65925587b3.41.1730085865822; Sun, 27 Oct 2024
 20:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024205257.574836-1-rosenp@gmail.com> <20241025125704.GT1202098@kernel.org>
 <CAKxU2N98hnVAE9WF72HhxzVEfhnRAgMykVgBErL9b3gupqqrxQ@mail.gmail.com> <87ttcxrm8y.fsf@mpe.ellerman.id.au>
In-Reply-To: <87ttcxrm8y.fsf@mpe.ellerman.id.au>
From: Rosen Penev <rosenp@gmail.com>
Date: Sun, 27 Oct 2024 20:24:14 -0700
Message-ID: <CAKxU2N-YZxg2_KF37Lw3mckYZLm4+DZS25P0bC7uuZLK4n0brw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: freescale: use ethtool string helpers
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Madalin Bucur <madalin.bucur@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 27, 2024 at 7:32=E2=80=AFPM Michael Ellerman <mpe@ellerman.id.a=
u> wrote:
>
> Rosen Penev <rosenp@gmail.com> writes:
> > On Fri, Oct 25, 2024 at 5:57=E2=80=AFAM Simon Horman <horms@kernel.org>=
 wrote:
> >>
> >> On Thu, Oct 24, 2024 at 01:52:57PM -0700, Rosen Penev wrote:
> >> > The latter is the preferred way to copy ethtool strings.
> >> >
> >> > Avoids manually incrementing the pointer. Cleans up the code quite w=
ell.
> >> >
> >> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >>
> >> ...
> >>
> >> > diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/dr=
ivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
> >> > index b0060cf96090..10c5fa4d23d2 100644
> >> > --- a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
> >> > +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
> >> > @@ -243,38 +243,24 @@ static void dpaa_get_ethtool_stats(struct net_=
device *net_dev,
> >> >  static void dpaa_get_strings(struct net_device *net_dev, u32 string=
set,
> >> >                            u8 *data)
> >> >  {
> >> > -     unsigned int i, j, num_cpus, size;
> >> > -     char string_cpu[ETH_GSTRING_LEN];
> >> > -     u8 *strings;
> >> > +     unsigned int i, j, num_cpus;
> >> >
> >> > -     memset(string_cpu, 0, sizeof(string_cpu));
> >> > -     strings   =3D data;
> >> > -     num_cpus  =3D num_online_cpus();
> >> > -     size      =3D DPAA_STATS_GLOBAL_LEN * ETH_GSTRING_LEN;
> >> > +     num_cpus =3D num_online_cpus();
> >> >
> >> >       for (i =3D 0; i < DPAA_STATS_PERCPU_LEN; i++) {
> >> > -             for (j =3D 0; j < num_cpus; j++) {
> >> > -                     snprintf(string_cpu, ETH_GSTRING_LEN, "%s [CPU=
 %d]",
> >> > -                              dpaa_stats_percpu[i], j);
> >> > -                     memcpy(strings, string_cpu, ETH_GSTRING_LEN);
> >> > -                     strings +=3D ETH_GSTRING_LEN;
> >> > -             }
> >> > -             snprintf(string_cpu, ETH_GSTRING_LEN, "%s [TOTAL]",
> >> > -                      dpaa_stats_percpu[i]);
> >> > -             memcpy(strings, string_cpu, ETH_GSTRING_LEN);
> >> > -             strings +=3D ETH_GSTRING_LEN;
> >> > -     }
> >> > -     for (j =3D 0; j < num_cpus; j++) {
> >> > -             snprintf(string_cpu, ETH_GSTRING_LEN,
> >> > -                      "bpool [CPU %d]", j);
> >> > -             memcpy(strings, string_cpu, ETH_GSTRING_LEN);
> >> > -             strings +=3D ETH_GSTRING_LEN;
> >> > +             for (j =3D 0; j < num_cpus; j++)
> >> > +                     ethtool_sprintf(&data, "%s [CPU %d]",
> >> > +                                     dpaa_stats_percpu[i], j);
> >> > +
> >> > +             ethtool_sprintf(&data, "%s [TOTAL]", dpaa_stats_percpu=
[i]);
> >> >       }
> >> > -     snprintf(string_cpu, ETH_GSTRING_LEN, "bpool [TOTAL]");
> >> > -     memcpy(strings, string_cpu, ETH_GSTRING_LEN);
> >> > -     strings +=3D ETH_GSTRING_LEN;
> >> > +     for (i =3D 0; j < num_cpus; i++)
> >>
> >> Perhaps this should consistently use i, rather than i and j:
> >>
> >>         for (i =3D 0; i < num_cpus; i++)
> >>
> >> Flagged by W=3D1 builds with clang-18.
>
> > I really need to compile test this on a PPC system.
>
> Cross compiling should be sufficient.
>
> There's some pointers here:
>   https://github.com/linuxppc/wiki/wiki/Building-powerpc-kernels
>
> Or there's also libc-less cross compilers on kernel.org, eg:
>   https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/14=
.2.0/x86_64-gcc-14.2.0-nolibc-powerpc64-linux.tar.xz
I ended up building linux on cfarm.
>
>
> cheers

