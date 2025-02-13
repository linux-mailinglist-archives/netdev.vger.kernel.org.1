Return-Path: <netdev+bounces-165721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A64BAA333DE
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27772188A2EE
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 00:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970BC4A29;
	Thu, 13 Feb 2025 00:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EsMkzTfH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75519B663
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 00:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739405455; cv=none; b=p4Oq8vuL+YFlW2fENtR57GecvNEYM5O8pqjXRB2rj5WL2uDhP+wrQgnmVKOKOXMqm2ZNkWOqqziYEMFyF+3e8FRzS8maUvWlQS75PBVU9fA49xfem1EfuI/RpaSS45gOt1hw/XXz1aRvl1yp2qRVweLvKECY640Vageqjwv0Ul0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739405455; c=relaxed/simple;
	bh=SifCzjX4GY5GN2rUJ8a5yh5rfxDC24HGCOd98DeaIb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7AnC84eorpOEE3SBo84jnwAcZC9aQHxF4ywib7GUIOgnwSz+3dIH5KL+1xXDIckZOGeKbi87YeAk0obN5Ycjh88csusr4T8HXjx5Q2MzNAGyaTje8ifMV2iR20E9Do/g4BeErQcwl6eyLwZ6L3RAHVvPeUFesjx3DWOMzNeQGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EsMkzTfH; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-8671441a730so120898241.0
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 16:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739405452; x=1740010252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+WfHu/v5u/KfWiPWoeUIJ/AgU1PcO3O1k2ZFWW7w5c=;
        b=EsMkzTfHZfKB8K2EWd4Cf1dwoDqLwkqBc5i0SbeyEeZG4DMz20nWPT10xodcREXCQ5
         NPaN9UGXB9apCvROxz8FfI8hptTTNaJtsu2Mjv8X6SVYoToUEWI2BckhaVyfze+1ukOF
         6THGobEFoAZAMUD2vL/GiN2MReNLSzLJXtm2DZyOS1ulJTsbghlpMuOLPWdbCfkShKIC
         CplAZGNVF8qBtslAkTifgMwcBQ+vzv3wo0vcTs9o30zD6bCN96K2uTIiHpIKKjwgEvsM
         IEZnqoz8haawfWup/d/rrFIuHm65zYeKYsgS5QXrNRDHU812FFQwl1LqeifO6MzI8N1m
         YKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739405452; x=1740010252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+WfHu/v5u/KfWiPWoeUIJ/AgU1PcO3O1k2ZFWW7w5c=;
        b=YKusQQv8OfVKR8mo4lWb7YK9TUe6EWnf9Q3cqZhj8bDInqIyx5onmEfGG2FluzlFSl
         xK7p21B8OXTpq39xPYeNHY3Mei8FOBxzyBks2l7Fq+TMqVLc8bQzFuMfRHWem0KbkmJS
         E3/Ro6Yi3Vo/8M5JKUGOoa3stKPFL+hWF7Gt9ihZR0mkALEPrGcvwhKxcdSodaF1ulL+
         QSCR/lZR/HueC9n2rIIQ1EaHpVBePKZ5i8/wqYUjF7Axsd8PSRNJPni2MtdUsyQ5ZPuI
         4d5gJSeM5HM83tUfr1qrT79O2DaWv7weezbAgzTePgoRmiR7+rqok0bYJH62edDtvhG7
         HWsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU20DJGJwEQ9PC3xdf++GEu99Gu/2MLUWb+L0HiQDrMvQz1ZEyjAZm2a54m9k7STfbmir1kgQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqngifGemko3/zVHnn2kgCvjILxdgVak2xKBsf4xDZ9ZVCMxxF
	3ZwXBHl6Yu724s8wAWauxPuGQckuLzkKyCRuZ4Rf3YZA8dLu8T1Tk6Gj4RFnQH6cWDmWIYNuhcA
	2zSU+bfemzifUow3HHd0HfG6Bhq4bPHVwss5S
X-Gm-Gg: ASbGncv8+L0o5ChsNIoL8e4RHm24ZrvnDzAZH0VYQavkzcapei6WJYAV8x0jsK2YqOg
	AIl+Aiggd9ASC4+ZdwArq/IJb+xRSbUGntO8xPBvgljpj7DdiNiGJyH7P1U+8m8H/szbSjyjyrw
	vc2DRkCb9a4QY/7CdA4+VMpfYAtA==
X-Google-Smtp-Source: AGHT+IEUmixnq02JlWKfwvEaLZDC3tHu+8a5G6UODHmdG4Lm1heidGpNx7OzILYgZRHUPwr+ZA1zRmmMlpPG+CZd8NQ=
X-Received: by 2002:a05:6102:2ad4:b0:4bb:5d61:1288 with SMTP id
 ada2fe7eead31-4bbf231f56fmr6157553137.23.1739405452181; Wed, 12 Feb 2025
 16:10:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210174504.work.075-kees@kernel.org> <3biiqfwwvlbkvo5tx56nmcl4rzbq5w7u3kxn5f5ctwsolxpubo@isskxigmypwz>
 <d11de4d4-1205-43d0-8a7d-a43d55a4f3eb@gmail.com>
In-Reply-To: <d11de4d4-1205-43d0-8a7d-a43d55a4f3eb@gmail.com>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 12 Feb 2025 16:10:40 -0800
X-Gm-Features: AWEUYZktjfLB0-Uv9mkLV-i_REAZ7bFxF9SxqOc292IN5aDUReN9RqbNh26rT8M
Message-ID: <CAFhGd8om_1W7inq+V4a4EP3e5y1y+qw7C3wi3DR4WpspYzZenQ@mail.gmail.com>
Subject: Re: [PATCH] net/mlx4_core: Avoid impossible mlx4_db_alloc() order value
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Yishai Hadas <yishaih@nvidia.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 6:22=E2=80=AFAM Tariq Toukan <ttoukan.linux@gmail.c=
om> wrote:
>
>
>
> On 11/02/2025 2:01, Justin Stitt wrote:
> > On Mon, Feb 10, 2025 at 09:45:05AM -0800, Kees Cook wrote:
> >> GCC can see that the value range for "order" is capped, but this leads
> >> it to consider that it might be negative, leading to a false positive
> >> warning (with GCC 15 with -Warray-bounds -fdiagnostics-details):
> >>
> >> ../drivers/net/ethernet/mellanox/mlx4/alloc.c:691:47: error: array sub=
script -1 is below array bounds of 'long unsigned int *[2]' [-Werror=3Darra=
y-bounds=3D]
> >>    691 |                 i =3D find_first_bit(pgdir->bits[o], MLX4_DB_=
PER_PAGE >> o);
> >>        |                                    ~~~~~~~~~~~^~~
> >>    'mlx4_alloc_db_from_pgdir': events 1-2
> >>    691 |                 i =3D find_first_bit(pgdir->bits[o], MLX4_DB_=
PER_PAGE >> o);                        |                     ^~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>        |                     |                         |              =
                                     |                     |               =
          (2) out of array bounds here
> >>        |                     (1) when the condition is evaluated to tr=
ue                             In file included from ../drivers/net/etherne=
t/mellanox/mlx4/mlx4.h:53,
> >>                   from ../drivers/net/ethernet/mellanox/mlx4/alloc.c:4=
2:
> >> ../include/linux/mlx4/device.h:664:33: note: while referencing 'bits'
> >>    664 |         unsigned long          *bits[2];
> >>        |                                 ^~~~
> >>
> >> Switch the argument to unsigned int, which removes the compiler needin=
g
> >> to consider negative values.
> >>
> >> Signed-off-by: Kees Cook <kees@kernel.org>
> >> ---
> >> Cc: Tariq Toukan <tariqt@nvidia.com>
> >> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> >> Cc: "David S. Miller" <davem@davemloft.net>
> >> Cc: Eric Dumazet <edumazet@google.com>
> >> Cc: Jakub Kicinski <kuba@kernel.org>
> >> Cc: Paolo Abeni <pabeni@redhat.com>
> >> Cc: Yishai Hadas <yishaih@nvidia.com>
> >> Cc: netdev@vger.kernel.org
> >> Cc: linux-rdma@vger.kernel.org
> >> ---
> >>   drivers/net/ethernet/mellanox/mlx4/alloc.c | 6 +++---
> >>   include/linux/mlx4/device.h                | 2 +-
> >>   2 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/mellanox/mlx4/alloc.c b/drivers/net/=
ethernet/mellanox/mlx4/alloc.c
> >> index b330020dc0d6..f2bded847e61 100644
> >> --- a/drivers/net/ethernet/mellanox/mlx4/alloc.c
> >> +++ b/drivers/net/ethernet/mellanox/mlx4/alloc.c
> >> @@ -682,9 +682,9 @@ static struct mlx4_db_pgdir *mlx4_alloc_db_pgdir(s=
truct device *dma_device)
> >>   }
> >>
> >>   static int mlx4_alloc_db_from_pgdir(struct mlx4_db_pgdir *pgdir,
> >> -                                struct mlx4_db *db, int order)
> >> +                                struct mlx4_db *db, unsigned int orde=
r)
> >>   {
> >> -    int o;
> >> +    unsigned int o;
> >>      int i;
> >>
> >>      for (o =3D order; o <=3D 1; ++o) {
> >
> >    ^ Knowing now that @order can only be 0 or 1 can this for loop (and
> >    goto) be dropped entirely?
> >
>
> Maybe I'm missing something...
> Can you please explain why you think this can be dropped?

I meant "rewritten to use two if statements" instead of "dropped". I
think "replaced" or "refactored" was the word I wanted.

>
>
> >    The code is already short and sweet so I don't feel strongly either
> >    way.
> >
> >> @@ -712,7 +712,7 @@ static int mlx4_alloc_db_from_pgdir(struct mlx4_db=
_pgdir *pgdir,
> >>      return 0;
> >>   }
> >>
> >> -int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, int order=
)
> >> +int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, unsigned =
int order)
> >>   {
> >>      struct mlx4_priv *priv =3D mlx4_priv(dev);
> >>      struct mlx4_db_pgdir *pgdir;
> >> diff --git a/include/linux/mlx4/device.h b/include/linux/mlx4/device.h
> >> index 27f42f713c89..86f0f2a25a3d 100644
> >> --- a/include/linux/mlx4/device.h
> >> +++ b/include/linux/mlx4/device.h
> >> @@ -1135,7 +1135,7 @@ int mlx4_write_mtt(struct mlx4_dev *dev, struct =
mlx4_mtt *mtt,
> >>   int mlx4_buf_write_mtt(struct mlx4_dev *dev, struct mlx4_mtt *mtt,
> >>                     struct mlx4_buf *buf);
> >>
> >> -int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, int order=
);
> >> +int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, unsigned =
int order);
> >>   void mlx4_db_free(struct mlx4_dev *dev, struct mlx4_db *db);
> >>
> >>   int mlx4_alloc_hwq_res(struct mlx4_dev *dev, struct mlx4_hwq_resourc=
es *wqres,
> >> --
> >> 2.34.1
> >>
> >
> > Justin
> >
>

