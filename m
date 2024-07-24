Return-Path: <netdev+bounces-112752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFC293AFEC
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 12:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3131F226AB
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 10:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C73C15099A;
	Wed, 24 Jul 2024 10:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gYL8KmQM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D187514658F
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721817430; cv=none; b=IPKerqRdVX6Zxx/2wyEUecEFOl3gi8W5VfHo5DQwziigwXNZi9vytAJYgjxp7DOlVF8L2o+nI8J2ThNuoCT2LAg8Sjp0PoN9r/ldMG/5M44gtNQyZbOPY3ilEOJP2rZDbx6cIdTmg5K9MVQMUhh4V/tPCyQsURLhEdw6NskKmAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721817430; c=relaxed/simple;
	bh=pa/6/LCNvsi3TsDP0rS/vJWrnNHp/M3qxsFPShH1/70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wt0uukzp0Sy8kve337nl1Q3T/fhrOrBtp7gHhJ2b7BgWvtykpdty0XEVhW0BhFEwvGLj1dRoslzqrtYkS+UJp0WIWwAEzV/ir+Tec1HRKuXvbQSCT0QDsmekejrFseme+2NaNLhkgZwmnO43Y7M9GNQrOqGmVEA4XYdxIJ1O5k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gYL8KmQM; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so12384a12.1
        for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 03:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721817427; x=1722422227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGO7kHN4KsIBivy4gaaDJKsKMKsqAfPXI0roq5/QWpE=;
        b=gYL8KmQME4XnwVsPDqmQvfVcpcOdPrrHlWRNBm4dP08f0RwYf6W0LbNgX6UCl/LSuY
         qnKVrFg8GUt3asUZpM/yP1au2U7Nm+iPArjMuBEmDVp8mv0uQsBxIhU1Ewh7CRFJE7Ku
         0kCIEDgI4jfrtO/KylkGjNoHiWBKV82i3tVTXsp/2HYhOgnlOwPjeb4xq0RbWLUYdHFi
         iVQpaJozPuKRRaE4L1BvyLxWwtqjUOJCBUWlBKhOjINY+SEUKtdeSO/+OBg1RvHlfPrB
         9Cs/Wro24vfBBtfDE66ds4LWdlZ6fB1zxoITJ5F0nQrhCwlUzA+rS53OVXtiC1iqS+tH
         lFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721817427; x=1722422227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGO7kHN4KsIBivy4gaaDJKsKMKsqAfPXI0roq5/QWpE=;
        b=m2uKpYVLTpBXZ5dXK3SjfLC4cNMKp8zVypksyDSChiBUPGZDKJOqlcdlxXLraQCyj/
         ++yifDK4CWACTunqHfXUfphyVyxmYoB9r1c2/8AagX7cwixVDO5Ijxl99xLQFKOA74fk
         RMDAFEQDwgVKaebR1GR2ZMHDnecMl+OChBEC9WRdr2cxyKzQxRuNcHQHC7QuS0EFVnEf
         ZGOd1GZD/Je4E+0N6vUW0xorhLVNmv+pHmGJqMUbxCUqiMFMUNHutTkLkl5ye0tBi6a7
         EXAseS3CE/32PPDScnYAO574RVJ73pUDzkRwRTONHI6VZR+prQClXV6yJaw+qd/GeD+p
         vzjg==
X-Forwarded-Encrypted: i=1; AJvYcCWlYUpoUocCcBdKVJxChJzDqVdr/PEmqBifwS/GIoAI1mEfLCsHyJDvgrlMzvbuWui3n9/6JqhprqSuQ9YFm8UJKCEVdvBI
X-Gm-Message-State: AOJu0Yy5TkoQXP+LflfqDyKJNO8B6xfm8oMuu0Lokx4v4ns3fnSbIr2H
	fZ4g9Tu8VuSZIQxAfF0MWnsVjD7BcyEeoQrUoOdSR6kW+R9Cp35/sX0slUGnafKEpxGqE6eo7jI
	N7tAV4iEdq3K+ONChlucaJCJddbeRkI77xxtg
X-Google-Smtp-Source: AGHT+IFXvNp2GtPHB/rOoVDcBxoOx/jrspmAd0FOI/r802ksTh2sb5Cd59QeeoKSeeZiFMETBAUOz01PFsITpt35NCI=
X-Received: by 2002:a05:6402:270e:b0:58b:15e4:d786 with SMTP id
 4fb4d7f45d1cf-5aacbfa0c33mr270635a12.5.1721817425456; Wed, 24 Jul 2024
 03:37:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8b06dd4ec057d912ca3947bacf15529272dea796.1721749627.git.petrm@nvidia.com>
 <CANn89iJQB4Po=J32rg10CNE+hrGqGZWfdWqKPdY6FK0UgQpxXg@mail.gmail.com>
 <CANn89iLvqJXmCktm=8WoSuSWOAVHe35fy+WHet-U+psMW2gAoQ@mail.gmail.com>
 <CANn89iJ6vG3n0bUbGuHosRDwW97z7CT4m4+_D91onPK5rd8xVw@mail.gmail.com>
 <CANn89iLcHERTvExi7zEVwArxBzaa2C-y_W_UPQa2ZWzYdT_d+Q@mail.gmail.com> <87o76n85ml.fsf@nvidia.com>
In-Reply-To: <87o76n85ml.fsf@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Jul 2024 12:36:54 +0200
Message-ID: <CANn89iLGh6sG8AhD_dgb15Es6MsATZ+QHkNzHwm5iufTCXZ+SA@mail.gmail.com>
Subject: Re: [PATCH net] net: nexthop: Initialize all fields in dumped nexthops
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, mlxsw@nvidia.com, Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 12:09=E2=80=AFPM Petr Machata <petrm@nvidia.com> wr=
ote:
>
>
> Eric Dumazet <edumazet@google.com> writes:
>
> > On Tue, Jul 23, 2024 at 7:41=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> >>
> >> On Tue, Jul 23, 2024 at 7:26=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
> >> >
> >> > On Tue, Jul 23, 2024 at 6:50=E2=80=AFPM Eric Dumazet <edumazet@googl=
e.com> wrote:
> >> > >
> >> > > On Tue, Jul 23, 2024 at 6:05=E2=80=AFPM Petr Machata <petrm@nvidia=
.com> wrote:
> >> > > >
> >> > > > struct nexthop_grp contains two reserved fields that are not ini=
tialized by
> >> > > > nla_put_nh_group(), and carry garbage. This can be observed e.g.=
 with
> >> > > > strace (edited for clarity):
> >> > > >
> >> > > >     # ip nexthop add id 1 dev lo
> >> > > >     # ip nexthop add id 101 group 1
> >> > > >     # strace -e recvmsg ip nexthop get id 101
> >> > > >     ...
> >> > > >     recvmsg(... [{nla_len=3D12, nla_type=3DNHA_GROUP},
> >> > > >                  [{id=3D1, weight=3D0, resvd1=3D0x69, resvd2=3D0=
x67}]] ...) =3D 52
> >> > > >
> >> > > > The fields are reserved and therefore not currently used. But as=
 they are, they
> >> > > > leak kernel memory, and the fact they are not just zero complica=
tes repurposing
> >> > > > of the fields for new ends. Initialize the full structure.
> >> > > >
> >> > > > Fixes: 430a049190de ("nexthop: Add support for nexthop groups")
> >> > > > Signed-off-by: Petr Machata <petrm@nvidia.com>
> >> > > > Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> >> > >
> >> > > Interesting... not sure why syzbot did not catch this one.
>
> Could it? I'm not sure of the exact syzcaller capabilities, but there
> are no warnings, no splats etc. It just returns values.

Yes, KMSAN can detect such things (uninit-value)

