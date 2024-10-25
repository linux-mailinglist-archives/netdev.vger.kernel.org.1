Return-Path: <netdev+bounces-139196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1839B0F18
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 21:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD16F1C22E7C
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 19:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212992064F1;
	Fri, 25 Oct 2024 19:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSZbYVmG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010C320D4FE;
	Fri, 25 Oct 2024 19:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884761; cv=none; b=r1xGDL9id+kdTCDrNH32Oa0eCs6uSkyAKvN1y1FZobCW3j1CV2betb2wusY2m87B83RsP9ufzBOOUOycXUXYmxvZdVWWLXSyUrUp1GjRPoEMH6zfQSRtue+E71yULwlF20F0oBj5UM902Iii1kDb/9tny8tuVE8G9Z/i2nsqH2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884761; c=relaxed/simple;
	bh=kXhHGNzdBLhRAY+KvWRM4xAk5QcUUIMZUhqGa36zOj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PnAjz+CTHQAB4+HBQMqfWJ4X3IkUyKoAP8wUbZv7uVrLel4+6oXPWwlnQgZRPeNUcQgT+NCQ50eWxPZNPqmrL2jgAux59XBZu25xg0k7bNcmuLaFDIeDhIYlhsGeN4LFqfZvs4ZFMbtZ2ULiZdL3zWRZZ+yTY0T/z0PVnJNj8mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSZbYVmG; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e2e41bd08bso31184057b3.2;
        Fri, 25 Oct 2024 12:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729884758; x=1730489558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OGTc1IGelQzRo6VF+xJwWEt+U6+tTV8KOTqMA95NRQ=;
        b=YSZbYVmGb3Js1CquiHQEOeeNLpBmq1lWkaidt5i6/rdVovr8NOOmZkMBEz6b2VXTdA
         Yj/oNwD7QhonNyVKh5Ml7UdYrFEu+v3Zc3Vf2O4FyvqLkUkQ5r6nqoDpTzVG4DUKPT2r
         DATCNGR72QrgQYsTlqzVeiQJHdyWLdAgXssa18Z+7rgG8p5TrOj8e89idc+xuFpD9dq7
         YGizYWgimkLxkkA8nsZs/R3Z3uHedwR5DG+8K53exrZrlkYVCjaKmCtv+VWnQnr74ifs
         Rvh4rOTIj0GeU4B5AWIk3omGbUs1enCy6k9MwO/i+/hmRSjOgRg0rCxKMFmOSt6DKn8Q
         VKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729884758; x=1730489558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OGTc1IGelQzRo6VF+xJwWEt+U6+tTV8KOTqMA95NRQ=;
        b=GL+OnNfirTBPiMaF+lNBJ4yBgSvLFWREwoTk4QBYSM7yhMgRugdYyHqFG3afjH9xn4
         EVGxtFODy4+dHipyVYC2KR7HI+hfaMFXlYcZZ5Q/Z4+wvc68pKTPcQhvNX2/85gSGD7W
         beGHDmmg0gx2Pv7oHG5VUNU9gh2lc3BWCYINdRQRS8x6aufXnO4lfuTC/eWAD6e9A5mU
         rxNLtUhCshGl5G2ab5VszeK8YdkH12VzP++TftSaURqNZHJX9GHLnBTn0Xuk8MJUiudm
         UU2Q3NiIPhl3oFu+vX34karH1Rv7DI/x69hwMfEYcYMrdWK2GdgacXgMurpDzVSII2A+
         9exQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfAq8cI20v2uuCqRIxDfuX3JmU9xRkhvImRQT6HM/urj9t/YBhknCKY3VRKZ6J8s+FMfeLj6zJbxurd9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbR3BGLL+wlxSNyD+Q6dpWLAgEzcwSZ6v/4L/OyZJ5+pB5I9z4
	NPVWvEIcv2sWvAqC1emMSQid+JF/im4ilu6Qi/eqtGzI9h7HQ34fK7SYr30J5HtaFuvYAJNVI7T
	rld8huV3TmJfed6v7AcAzW21puzU=
X-Google-Smtp-Source: AGHT+IEWqdzDAn21/R+IgfqiZgRRkeQqv49phY3X9Pmz4EABFQegbOOIeDadzmC/8Cxmk1V/kug1B0w3dmfkJldOmUE=
X-Received: by 2002:a05:690c:2a8e:b0:6e6:1018:64c7 with SMTP id
 00721157ae682-6e9d8b8dbadmr6557887b3.41.1729884758060; Fri, 25 Oct 2024
 12:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024205257.574836-1-rosenp@gmail.com> <20241025125704.GT1202098@kernel.org>
In-Reply-To: <20241025125704.GT1202098@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 25 Oct 2024 12:32:27 -0700
Message-ID: <CAKxU2N98hnVAE9WF72HhxzVEfhnRAgMykVgBErL9b3gupqqrxQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: freescale: use ethtool string helpers
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Madalin Bucur <madalin.bucur@nxp.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 5:57=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Thu, Oct 24, 2024 at 01:52:57PM -0700, Rosen Penev wrote:
> > The latter is the preferred way to copy ethtool strings.
> >
> > Avoids manually incrementing the pointer. Cleans up the code quite well=
.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> ...
>
> > diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/drive=
rs/net/ethernet/freescale/dpaa/dpaa_ethtool.c
> > index b0060cf96090..10c5fa4d23d2 100644
> > --- a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
> > +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
> > @@ -243,38 +243,24 @@ static void dpaa_get_ethtool_stats(struct net_dev=
ice *net_dev,
> >  static void dpaa_get_strings(struct net_device *net_dev, u32 stringset=
,
> >                            u8 *data)
> >  {
> > -     unsigned int i, j, num_cpus, size;
> > -     char string_cpu[ETH_GSTRING_LEN];
> > -     u8 *strings;
> > +     unsigned int i, j, num_cpus;
> >
> > -     memset(string_cpu, 0, sizeof(string_cpu));
> > -     strings   =3D data;
> > -     num_cpus  =3D num_online_cpus();
> > -     size      =3D DPAA_STATS_GLOBAL_LEN * ETH_GSTRING_LEN;
> > +     num_cpus =3D num_online_cpus();
> >
> >       for (i =3D 0; i < DPAA_STATS_PERCPU_LEN; i++) {
> > -             for (j =3D 0; j < num_cpus; j++) {
> > -                     snprintf(string_cpu, ETH_GSTRING_LEN, "%s [CPU %d=
]",
> > -                              dpaa_stats_percpu[i], j);
> > -                     memcpy(strings, string_cpu, ETH_GSTRING_LEN);
> > -                     strings +=3D ETH_GSTRING_LEN;
> > -             }
> > -             snprintf(string_cpu, ETH_GSTRING_LEN, "%s [TOTAL]",
> > -                      dpaa_stats_percpu[i]);
> > -             memcpy(strings, string_cpu, ETH_GSTRING_LEN);
> > -             strings +=3D ETH_GSTRING_LEN;
> > -     }
> > -     for (j =3D 0; j < num_cpus; j++) {
> > -             snprintf(string_cpu, ETH_GSTRING_LEN,
> > -                      "bpool [CPU %d]", j);
> > -             memcpy(strings, string_cpu, ETH_GSTRING_LEN);
> > -             strings +=3D ETH_GSTRING_LEN;
> > +             for (j =3D 0; j < num_cpus; j++)
> > +                     ethtool_sprintf(&data, "%s [CPU %d]",
> > +                                     dpaa_stats_percpu[i], j);
> > +
> > +             ethtool_sprintf(&data, "%s [TOTAL]", dpaa_stats_percpu[i]=
);
> >       }
> > -     snprintf(string_cpu, ETH_GSTRING_LEN, "bpool [TOTAL]");
> > -     memcpy(strings, string_cpu, ETH_GSTRING_LEN);
> > -     strings +=3D ETH_GSTRING_LEN;
> > +     for (i =3D 0; j < num_cpus; i++)
>
> Perhaps this should consistently use i, rather than i and j:
>
>         for (i =3D 0; i < num_cpus; i++)
>
> Flagged by W=3D1 builds with clang-18.
I really need to compile test this on a PPC system.
>
> > +             ethtool_sprintf(&data, "bpool [CPU %d]", i);
> > +
> > +     ethtool_puts(&data, "bpool [TOTAL]");
> >
> > -     memcpy(strings, dpaa_stats_global, size);
> > +     for (i =3D 0; i < DPAA_STATS_GLOBAL_LEN; i++)
> > +             ethtool_puts(&data, dpaa_stats_global[i]);
> >  }
> >
> >  static int dpaa_get_hash_opts(struct net_device *dev,
>
> ...

