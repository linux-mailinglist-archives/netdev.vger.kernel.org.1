Return-Path: <netdev+bounces-112650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B480993A519
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 19:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E631C20B82
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 17:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F4115820C;
	Tue, 23 Jul 2024 17:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MhBy8TVC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1749314B06A
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 17:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721756583; cv=none; b=Btwlgucduf/aqrFwTTyI18SOmL5yIqGleG54D3btrS6h+GzZ/fRND10DeHUKyz+BzRgRX5atL5uvUaAsiMzQgC4CGp9Ti9r5ruF5R1QPoOQhG0ZK6TDZcXqacwCRDXBR2az9fPWZkVoC3fbhshgG5GYwQlyGP/T5A9mG88e2N/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721756583; c=relaxed/simple;
	bh=TY3kiRKxAFjCLbhUNgWskm5N0P7dw1RFZxjyo+2/m4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+GVKxb2SdfAyimwFzCET15Bn7vWD8VVowTdpjJxZ+M7H2tSm954xgcwHv9s+F7zGQSsf0zT+UTGzdjlJ2AoYNTH00OraSTDWYistSK5ELEpxACWt7nNkv0+5RyShIupiuYERLNzzRtUVL1c2uViW7bQdsj99Tly+8zFUow1eqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MhBy8TVC; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so1913a12.1
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 10:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721756579; x=1722361379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIYR3ae6VhEpoMTQR1MF3R8CKox0lnAUdUH806KyobM=;
        b=MhBy8TVCH+BcFuiHwrezoGVVrxgS1DmzV/tOT2mqujSSWevdgZHGLMROkaW4B7CjO2
         Trhy6+8OPslQj65l25jMoRru+65jyyPE6GaZUXo92WwsGn31T/HhH3XImL+CVoUpdD3h
         c+nSan/qCp7xaEkh6xyNXuaLQS8HCtWG9ECHOgv5HCrOw8e4BTZLjrWHfgM+3iYYoDaj
         bE+8hiQPrxaYckPzFWUV1KQ/6NM+wWVoGA2rCstWXoRWwKR2hu0XrPrY2YteUgQhn9y0
         PCaGtAUNJaaAEV0SzfAN6wgD1vgWAxV68S3dl6Jpjq0Fob0YPD4Kv5GpHuiM0AXe5Ppl
         c/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721756579; x=1722361379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIYR3ae6VhEpoMTQR1MF3R8CKox0lnAUdUH806KyobM=;
        b=VpMU1Nge2Se+oWmstxZyeyGUIhpbG4KP6iN3lx6yzd6ht7YMGA59gkIEi4KLvgJu0w
         5VLVLaQpUHwprzEzvHnwopt4MLzILAIHebSu1kv1t7bSTp3aePUzAGzhzPANEwlWvKrV
         C3WK6DI2zcmyeCUxJdiGmmunC7zPzP5kZoHLWB5TXD8hW9DlVxY6+BWoyE2Akjbiq7pU
         x2wGcsBqVbvaD4q1YALQYTI4QhNMvERuPGKkdzeenuR3X6SpUv17Uwxe3ymDFxyQb2EZ
         ef29S9UvCtV/Cji56RpIASTvrSg2ItY6BpRgYTjxQ4PzIvXFrKLnPBeMRkQAXPJLr7Ko
         acBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKgyE/a5RQ2j0j8Wf5u3UhPxgndEMlniX1GEIXTuVaRjV+s1X5XE7Lt+PC1cD85ER4nn2chAAVFAI4ppIkwKasIqNqLmrm
X-Gm-Message-State: AOJu0Yw6wXP/xWhgHr52aWYrXSq8kuLXMUcYRcYw7EdAQ7yQXfgD/3Yf
	SVUwI151cHqtsCw/b0RcrWCe71CwCz8gweUkjcjoqXiMuRGbk7yI5ScDrPSqxlSbdQhn+oeuVCy
	0Lj4cV0fbNWz3qzIcjy7ZC8Z8nX04GSa9HAlq
X-Google-Smtp-Source: AGHT+IGpEGmnbpfKoi6MTzaKqeSpQV3Yxo8Rsm1ZAEHznAjZAqnNJpVOFG0G/D7KLQ70l1HJIaMrhB6taXvhixeOiPs=
X-Received: by 2002:a05:6402:13c2:b0:57c:c5e2:2c37 with SMTP id
 4fb4d7f45d1cf-5aacb8e3ef4mr26832a12.3.1721756579027; Tue, 23 Jul 2024
 10:42:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8b06dd4ec057d912ca3947bacf15529272dea796.1721749627.git.petrm@nvidia.com>
 <CANn89iJQB4Po=J32rg10CNE+hrGqGZWfdWqKPdY6FK0UgQpxXg@mail.gmail.com>
 <CANn89iLvqJXmCktm=8WoSuSWOAVHe35fy+WHet-U+psMW2gAoQ@mail.gmail.com> <CANn89iJ6vG3n0bUbGuHosRDwW97z7CT4m4+_D91onPK5rd8xVw@mail.gmail.com>
In-Reply-To: <CANn89iJ6vG3n0bUbGuHosRDwW97z7CT4m4+_D91onPK5rd8xVw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Jul 2024 19:42:47 +0200
Message-ID: <CANn89iLcHERTvExi7zEVwArxBzaa2C-y_W_UPQa2ZWzYdT_d+Q@mail.gmail.com>
Subject: Re: [PATCH net] net: nexthop: Initialize all fields in dumped nexthops
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, mlxsw@nvidia.com, Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 7:41=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Jul 23, 2024 at 7:26=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Tue, Jul 23, 2024 at 6:50=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Tue, Jul 23, 2024 at 6:05=E2=80=AFPM Petr Machata <petrm@nvidia.co=
m> wrote:
> > > >
> > > > struct nexthop_grp contains two reserved fields that are not initia=
lized by
> > > > nla_put_nh_group(), and carry garbage. This can be observed e.g. wi=
th
> > > > strace (edited for clarity):
> > > >
> > > >     # ip nexthop add id 1 dev lo
> > > >     # ip nexthop add id 101 group 1
> > > >     # strace -e recvmsg ip nexthop get id 101
> > > >     ...
> > > >     recvmsg(... [{nla_len=3D12, nla_type=3DNHA_GROUP},
> > > >                  [{id=3D1, weight=3D0, resvd1=3D0x69, resvd2=3D0x67=
}]] ...) =3D 52
> > > >
> > > > The fields are reserved and therefore not currently used. But as th=
ey are, they
> > > > leak kernel memory, and the fact they are not just zero complicates=
 repurposing
> > > > of the fields for new ends. Initialize the full structure.
> > > >
> > > > Fixes: 430a049190de ("nexthop: Add support for nexthop groups")
> > > > Signed-off-by: Petr Machata <petrm@nvidia.com>
> > > > Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> > >
> > > Interesting... not sure why syzbot did not catch this one.
> > >
> > > Reviewed-by: Eric Dumazet <edumazet@google.com>
> >
> > Hmmm... Do we have the guarantee that the compiler initializes padding =
?
> >
> > AFAIK, padding at the end of the structure is not initialized.
>
> I am asking this because syzbot found a similar issue in net/sched/act_ct=
.c
>
> My current WIP is :
>
> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> index 113b907da0f757af7be920cc9b3a1b1c769f5804..3ba8e7e739b58a96e66ca64d3=
8bff758500df3e1
> 100644
> --- a/net/sched/act_ct.c
> +++ b/net/sched/act_ct.c
> @@ -44,6 +44,8 @@ static DEFINE_MUTEX(zones_mutex);
>  struct zones_ht_key {
>         struct net *net;
>         u16 zone;
> +       /* Note : pad[] must be the last field. */
> +       u8  pad[];
>  };
>
>  struct tcf_ct_flow_table {
> @@ -60,7 +62,7 @@ struct tcf_ct_flow_table {
>  static const struct rhashtable_params zones_params =3D {
>         .head_offset =3D offsetof(struct tcf_ct_flow_table, node),
>         .key_offset =3D offsetof(struct tcf_ct_flow_table, key),
> -       .key_len =3D sizeof_field(struct tcf_ct_flow_table, key),
> +       .key_len =3D offsetof(struct zones_ht_key, pad),
>         .automatic_shrinking =3D true,
>  };

I guess your patch is fine, because the holes in struct nexthop_grp are nam=
ed.

