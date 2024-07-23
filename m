Return-Path: <netdev+bounces-112649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4672693A516
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 19:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2FAF1F2309A
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 17:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F95157A58;
	Tue, 23 Jul 2024 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kKGcmOYm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBBA14B06A
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 17:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721756483; cv=none; b=KSBCArgKewG8TMRoEWy7VIpPPoOejRZXBI34qHc+4kipYamxdTjWPpA8rUxPDgZtCiavtOdPiH/UYUg9xnDpRNROk69B5QhXUJM09T9KyNDXgBEzgN0AJ664ScriB2UMfAW9YyOYCPmrf+PqbbQVPAPBBijP5wM9xO9wkBdZguc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721756483; c=relaxed/simple;
	bh=4U6nY1UVLIjhBkyy6XslVSZ3OE7QQ9eNsRmBw4iBsEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nob44EVgiG54UtpI43kXq3on5zXKJLZAw+sEqbC4lvx0VR7P846rHWFGVTLOtx7wpGxkGxBdOUaWJlOAY27+7u0f6a1LG9qz+gjanuIx+WqWVtMnpBWhYqvuHVnM0dVh+E+f5gCC5YyB+fEsguE6yomja8S4dZusHc0wTVMVusM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kKGcmOYm; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a869e3e9dfso1436a12.0
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 10:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721756480; x=1722361280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QS0rs5uiilJ4EGx+K9TsmNUE3LF5jWvVz8vOLYlZ8oA=;
        b=kKGcmOYmNtf8qKQTlmv+CpuPoVLjfge0Igd8OnhQyWG3Wg/EpbMuhpytTBpGKdwADh
         GiN1BOYf/vHj4xayW6vTB684CGZ/ty4vUA0uBdc9GC4+5mVH2wfVkknfv4KFqFVRDRjW
         YZvy2wb/Vo4x3FRHZIgyXy06DBorzxvC6zBbaL3RkPozSwop+DiBz/xaiTDt3pHqHowA
         q8PVzMTlUEdG4A6ptr4HJ5xiyo57KbFBIb0ctSB4aWlOahr23rQu1EvvScGWwaeVo6vn
         O5Aqfyr0ZLwBvdg7oouFp8hxKESk24oPrH/PJr4a9WeiqCDiIyulEmcEX+8shBTj/Ptk
         oFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721756480; x=1722361280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QS0rs5uiilJ4EGx+K9TsmNUE3LF5jWvVz8vOLYlZ8oA=;
        b=XbELYf2dPERvhzu5bJXdEUaw/4wNxbFwoDD9WR0bvSGxJk3qjmJ6LmkBjvGRo0EVCI
         ekau52fZczylT3P23NXwJ/+LUB5NAIJ/KQH+1D9funwg+ibaAUDolDPKMmOaxDA4vCrT
         JV5JBHtIWYnWkTSO3jlOelIVTRj13hbXt6/uZ7/tkWT72xQK5VhvCuGVHl49VfrT2/Lu
         4GefBv0T/5w0lZARyEA7mJdOBmJAkjbBzO+YmySe7I86EPeB2yf0+fu12cIljCl7O/f0
         yHKn+CE/KoRH+NJDidIgc3A8V81x/fc9pUl7j1ZoLWfl4CSHMypjjbUsrG8a0setRFCn
         K7jg==
X-Forwarded-Encrypted: i=1; AJvYcCXkuBZIikf7tGsvyS+jrVkQFFLTqridL0eVR9o8V+rloK++lGb13FwsRIPItYUFuODGpeiC7lYD35h0Og2qX3GlXv6+/aeb
X-Gm-Message-State: AOJu0Yzi1fPz9e/EhZTobkWsE8Ggn93UoZzz/9rujW/SoHFkfoOaT8WW
	vre4HX8LUut8zJKhzbaz5W271Xr1KF3O3N0eqjChrJrrMkYPkCxdskZFWeWpIs27uQ5hhJBBd1W
	k0YAurNBj6CWJ0cGdsBmld4m1oMH6fRdsTuU5
X-Google-Smtp-Source: AGHT+IFED4lOtdtdY7T7vKtxzd3NDb2pb9kiI5fKhBmPEIf4oqqpldTDNbvYt5Ep+K3E8YgnZOZXyuV/x1CVnoGcIH4=
X-Received: by 2002:a05:6402:2681:b0:5a1:4658:cb98 with SMTP id
 4fb4d7f45d1cf-5aac71248ddmr41191a12.0.1721756479339; Tue, 23 Jul 2024
 10:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8b06dd4ec057d912ca3947bacf15529272dea796.1721749627.git.petrm@nvidia.com>
 <CANn89iJQB4Po=J32rg10CNE+hrGqGZWfdWqKPdY6FK0UgQpxXg@mail.gmail.com> <CANn89iLvqJXmCktm=8WoSuSWOAVHe35fy+WHet-U+psMW2gAoQ@mail.gmail.com>
In-Reply-To: <CANn89iLvqJXmCktm=8WoSuSWOAVHe35fy+WHet-U+psMW2gAoQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Jul 2024 19:41:08 +0200
Message-ID: <CANn89iJ6vG3n0bUbGuHosRDwW97z7CT4m4+_D91onPK5rd8xVw@mail.gmail.com>
Subject: Re: [PATCH net] net: nexthop: Initialize all fields in dumped nexthops
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, mlxsw@nvidia.com, Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 7:26=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Jul 23, 2024 at 6:50=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Tue, Jul 23, 2024 at 6:05=E2=80=AFPM Petr Machata <petrm@nvidia.com>=
 wrote:
> > >
> > > struct nexthop_grp contains two reserved fields that are not initiali=
zed by
> > > nla_put_nh_group(), and carry garbage. This can be observed e.g. with
> > > strace (edited for clarity):
> > >
> > >     # ip nexthop add id 1 dev lo
> > >     # ip nexthop add id 101 group 1
> > >     # strace -e recvmsg ip nexthop get id 101
> > >     ...
> > >     recvmsg(... [{nla_len=3D12, nla_type=3DNHA_GROUP},
> > >                  [{id=3D1, weight=3D0, resvd1=3D0x69, resvd2=3D0x67}]=
] ...) =3D 52
> > >
> > > The fields are reserved and therefore not currently used. But as they=
 are, they
> > > leak kernel memory, and the fact they are not just zero complicates r=
epurposing
> > > of the fields for new ends. Initialize the full structure.
> > >
> > > Fixes: 430a049190de ("nexthop: Add support for nexthop groups")
> > > Signed-off-by: Petr Machata <petrm@nvidia.com>
> > > Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> >
> > Interesting... not sure why syzbot did not catch this one.
> >
> > Reviewed-by: Eric Dumazet <edumazet@google.com>
>
> Hmmm... Do we have the guarantee that the compiler initializes padding ?
>
> AFAIK, padding at the end of the structure is not initialized.

I am asking this because syzbot found a similar issue in net/sched/act_ct.c

My current WIP is :

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 113b907da0f757af7be920cc9b3a1b1c769f5804..3ba8e7e739b58a96e66ca64d38b=
ff758500df3e1
100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -44,6 +44,8 @@ static DEFINE_MUTEX(zones_mutex);
 struct zones_ht_key {
        struct net *net;
        u16 zone;
+       /* Note : pad[] must be the last field. */
+       u8  pad[];
 };

 struct tcf_ct_flow_table {
@@ -60,7 +62,7 @@ struct tcf_ct_flow_table {
 static const struct rhashtable_params zones_params =3D {
        .head_offset =3D offsetof(struct tcf_ct_flow_table, node),
        .key_offset =3D offsetof(struct tcf_ct_flow_table, key),
-       .key_len =3D sizeof_field(struct tcf_ct_flow_table, key),
+       .key_len =3D offsetof(struct zones_ht_key, pad),
        .automatic_shrinking =3D true,
 };

