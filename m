Return-Path: <netdev+bounces-210160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 908D7B12332
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 19:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F17AE13AC
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 17:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CF12EFD98;
	Fri, 25 Jul 2025 17:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="YJDE//0i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7866424291C
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753465670; cv=none; b=RADSQ3fOihj39IOI5M5HrB7tDL5AOZt4lrKpPor35jHlBDMrt+jCMuWeoR1jiBo6CqovjCMzDIpZoUw+CMRQvM2tOPg9Ak8mSyqJBvJt9l/uUcSbo1GgEt7zx91lIwULsoOIJhfJKBsE974p+uB36WzBzQKB+RSymUb4QkhN+DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753465670; c=relaxed/simple;
	bh=9eDIK3jVCFBYpk17cfWHRUnPmLO8AyLiFNJ2QzMQUxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N38zTqSQd69jxuQT9qXabfPrrpD8DrtUgceiEz7KVX6/hwJCea0+joD1dSbkBAbPVIjGF79i9u+iZGcvq5z5BE5mGZGda0Hkpcd6rNvNj1uDLE6a5OfpGPn7KucCRvV1F1IO/L3F3Hxj47Pj5HAzldZSWEKByShh6SWLIKnwzGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=YJDE//0i; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32cd0dfbdb8so23205721fa.0
        for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 10:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1753465667; x=1754070467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8igKGnqKWRhclIAZjFMGAieuZQEAwLSx36AxSWzK5I=;
        b=YJDE//0iVUgoS9TC2yJy8ctxmWeggEC6MjZAuYdbt5MGGHI9lY82BZJsyFFIUNrgd4
         W/0t46NDB6QrsW1jJDyujPZsEbf8ut7ttP+jWtA72jLWtmCpxk+XVIEscm+ANYPrSvHq
         UII23stwe2Mbg11ylsKH2ByNYWJUn6KfVLuKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753465667; x=1754070467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8igKGnqKWRhclIAZjFMGAieuZQEAwLSx36AxSWzK5I=;
        b=N5UY47iZmpLL659RM9BZXeTcvXm4nv1HsU8o679tnpcUJgllnNxoASiNPjdalgg4Dw
         9vq64mOvEvdcS5WDZSnSWpvqVwiqEpZMCm+I0wvzPb7K0MiTghWrQkkz7ujTF8eObpM3
         s5jhDSseBuHRrgUy3MyfztF66aZbzm4WXF3P6fZChv3SG3quWAFWKHyujX3Gt11t1W6A
         wRD1hnZ33Cl397zYJs7SCFYyLyEKcXH0KWfmHLfAh7PuicKghJMFnQnO5lrkBXuiS0ca
         N8BYZTIbYqE1l+NPny5YBjE2MgDn9OypF9rz8L7diTT1QeAli3A8pf40xaEEF5cFADWo
         Op4A==
X-Forwarded-Encrypted: i=1; AJvYcCWjBFq40JFEvAXoFXWjgEUzZzLKB4AOwb7B+O67dh68JWsCx53MaiSIdtQICjHTRPAsG1hHAzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsofB0BhPXTATzP9xOxqfiCIUza/E1rXRzoMVqy8ipZwtxUvUj
	sR+VPlq2spJ5Fjxs5mSrIDDCNpbcFwYCI8U1YkBTf6HuBBR+CeoVoiMNMHVzqVx6nmcBclMP9tn
	zQVjMvDYwNmwAolm8D1uNvtHRLfMxUYZ9YU2h/69kLg==
X-Gm-Gg: ASbGncuxFCNGtOM8/UFJoRifd847IYPCalqdClzJtdCQ167bpFlAgeXQ10kRIiRO/RH
	MkvqPCgCOXAsuGx9YE6h8Rm67guob21XsU9YHwD2ItdS6RjLaZ1HXRo+fi3bpXWz8ICmlXir4zd
	QOZNHcx6J5lIJftymkfS4W9p6NZnDUwJeX1I5Nhp7VbL1QRBEvBPmDOH8CQ2mg1WQmuP/jlfhS5
	5GkDw==
X-Google-Smtp-Source: AGHT+IFkfnmzNmODcw4O7GHq9qDajGK55gSY11imeb8rrw6tCnKTZQzJU4QShIdnMeRS5NUn9qCF5ViF1iJkhuno3kI=
X-Received: by 2002:a05:6512:3da3:b0:553:a60d:6898 with SMTP id
 2adb3069b0e04-55b5f4aab78mr769594e87.45.1753465666466; Fri, 25 Jul 2025
 10:47:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724-nexthop_dump-v1-1-6b43fffd5bac@openai.com> <aIOPQH-S5LAPCb1u@shredder>
In-Reply-To: <aIOPQH-S5LAPCb1u@shredder>
From: Christoph Paasch <cpaasch@openai.com>
Date: Fri, 25 Jul 2025 10:47:35 -0700
X-Gm-Features: Ac12FXzjzTO4-C8ogjX_JnB8KHGgWNT6UwjDM8_9OPCEHmsQhP-m538QaT5BTBo
Message-ID: <CADg4-L8qauZSuC4=a-Ut4CSmUeyZNT4sprmSxbwWkQ9q-TrRqA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: Make nexthop-dumps scale linearly with the
 number of nexthops
To: Ido Schimmel <idosch@idosch.org>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 7:05=E2=80=AFAM Ido Schimmel <idosch@idosch.org> wr=
ote:
>
> On Thu, Jul 24, 2025 at 05:10:36PM -0700, Christoph Paasch via B4 Relay w=
rote:
> > From: Christoph Paasch <cpaasch@openai.com>
> >
> > When we have a (very) large number of nexthops, they do not fit within =
a
> > single message. rtm_dump_walk_nexthops() thus will be called repeatedly
> > and ctx->idx is used to avoid dumping the same nexthops again.
> >
> > The approach in which we avoid dumpint the same nexthops is by basicall=
y
>
> s/dumpint/dumping/
>
> > walking the entire nexthop rb-tree from the left-most node until we fin=
d
> > a node whose id is >=3D s_idx. That does not scale well.
> >
> > Instead of this non-efficient  approach, rather go directly through the
>                                ^ double space
> s/non-efficient/inefficient/ ?
>
> > tree to the nexthop that should be dumped (the one whose nh_id >=3D
> > s_idx). This allows us to find the relevant node in O(log(n)).
> >
> > We have quite a nice improvement with this:
> >
> > Before:
> > =3D=3D=3D=3D=3D=3D=3D
> >
> > --> ~1M nexthops:
> > $ time ~/libnl/src/nl-nh-list | wc -l
> > 1050624
> >
> > real  0m21.080s
> > user  0m0.666s
> > sys   0m20.384s
> >
> > --> ~2M nexthops:
> > $ time ~/libnl/src/nl-nh-list | wc -l
> > 2101248
> >
> > real  1m51.649s
> > user  0m1.540s
> > sys   1m49.908s
> >
> > After:
> > =3D=3D=3D=3D=3D=3D
> >
> > --> ~1M nexthops:
> > $ time ~/libnl/src/nl-nh-list | wc -l
> > 1050624
> >
> > real  0m1.157s
> > user  0m0.926s
> > sys   0m0.259s
> >
> > --> ~2M nexthops:
> > $ time ~/libnl/src/nl-nh-list | wc -l
> > 2101248
> >
> > real  0m2.763s
> > user  0m2.042s
> > sys   0m0.776s
>
> I was able to reproduce these results.
>
> >
> > Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> > ---
> >  net/ipv4/nexthop.c | 34 +++++++++++++++++++++++++++++++++-
> >  1 file changed, 33 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> > index 29118c43ebf5f1e91292fe227d4afde313e564bb..226447b1c17d22eab9121be=
d88c0c2b9148884ac 100644
> > --- a/net/ipv4/nexthop.c
> > +++ b/net/ipv4/nexthop.c
> > @@ -3511,7 +3511,39 @@ static int rtm_dump_walk_nexthops(struct sk_buff=
 *skb,
> >       int err;
> >
> >       s_idx =3D ctx->idx;
> > -     for (node =3D rb_first(root); node; node =3D rb_next(node)) {
> > +
> > +     /*
> > +      * If this is not the first invocation, ctx->idx will contain the=
 id of
> > +      * the last nexthop we processed.  Instead of starting from the v=
ery first
> > +      * element of the red/black tree again and linearly skipping the
> > +      * (potentially large) set of nodes with an id smaller than s_idx=
, walk the
> > +      * tree and find the left-most node whose id is >=3D s_idx.  This=
 provides an
> > +      * efficient O(log n) starting point for the dump continuation.
> > +      */
>
> Please try to keep lines at 80 characters.
>
> > +     if (s_idx !=3D 0) {
> > +             struct rb_node *tmp =3D root->rb_node;
> > +
> > +             node =3D NULL;
> > +             while (tmp) {
> > +                     struct nexthop *nh;
> > +
> > +                     nh =3D rb_entry(tmp, struct nexthop, rb_node);
> > +                     if (nh->id < s_idx) {
> > +                             tmp =3D tmp->rb_right;
> > +                     } else {
> > +                             /* Track current candidate and keep looki=
ng on
> > +                              * the left side to find the left-most
> > +                              * (smallest id) that is still >=3D s_idx=
.
> > +                              */
>
> I'm aware that netdev now accepts both comment styles, but it's a bit
> weird to mix both in the same commit and at the same function.
>
> > +                             node =3D tmp;
> > +                             tmp =3D tmp->rb_left;
> > +                     }
> > +             }
> > +     } else {
> > +             node =3D rb_first(root);
> > +     }
> > +
> > +     for (; node; node =3D rb_next(node)) {
> >               struct nexthop *nh;
> >
> >               nh =3D rb_entry(node, struct nexthop, rb_node);
>
> The code below is:
>
> if (nh->id < s_idx)
>         continue;
>
> Can't it be removed given the above code means we start at a nexthop
> whose identifier is at least s_idx ?

Yes, we can drop this check.

Thanks for all your feedback. Will resubmit when net-next reopens.


Christoph

