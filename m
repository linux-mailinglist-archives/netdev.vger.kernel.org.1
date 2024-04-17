Return-Path: <netdev+bounces-88611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 355C88A7E95
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 10:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57FC01C216D5
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 08:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E8C7C6CE;
	Wed, 17 Apr 2024 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kcRHl7z8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81888127E15
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 08:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343527; cv=none; b=kirHjwwpgSOmUcts1LioX/I/kKt/wDuxwdXu6BiPdNVHZmbGxwf4b4O+BR1WPhuroUsRUus84+2lfd6L0zMbF6/5HQ/QXLg4naZQAo+EM/IvyhZVTJIrBdIqpUk29VTgKRQ5VQkNeHlo2H/dOaKJac3Y5rfXGVtMtDrsjuv/ynU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343527; c=relaxed/simple;
	bh=Ez4AJ4iVphYZ/mXHw1Bve0PL0KLip+ji5KqPnywv6PY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xuu4edmyyxCrAIsRHbRPnnkeGQp/sFf5sijeD2X8Dys+fTPxSJW2CoAt5xaroMF5Xx7wED7bXJGpYkFfSlTdETuCslp1jZZYrkBwLB6y4Mpn85/+lUWFuvO3Io9gOPKbEJ0OTJQoaH5gh18aXwK2P6AI/PXUyB6v8hGm4hCYz1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kcRHl7z8; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5700ed3017fso9287a12.1
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 01:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713343524; x=1713948324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNeEdhdE6y6+VN2cy0iMoXnDuyG8MFV/0F7ILlmz9fc=;
        b=kcRHl7z85grscepALUYiRy9nFkAIHNhVoPO/B91uKUPAuo679Ljxi51rPXJYrCZ9gP
         p/5MmUELkhqdZHzLLIcGHpKnpbwV3Ee+k1BDgy1uhZMMckBplumHK5qkMXA6VFkDp2Lj
         zRCSWf59dO3OkjeToVcznP5c3zNGDjHUx8/PfLq+1sRdQbGQNRE1El/LGWhn30CoMQ0n
         Gu/DSrInVXFOSS+7yWNTGULNV7oLyXCluNuOOEhaJgScfZn0a77dxfb6ZQA2RctM06WU
         IEuHH7tr+xRQ/9/MIE1n0fQCUyKJ4iOmDH1ejqvrQpa2RuU2ER83Oemx2/zMTabt/szy
         UZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713343524; x=1713948324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNeEdhdE6y6+VN2cy0iMoXnDuyG8MFV/0F7ILlmz9fc=;
        b=CSEU7rFuFmLd4ehBiZvpMKpU9RyXuBP8D9r3uxpqlMdJV9ZSX/aF5ZBMnGL8YmSuEH
         HZ6fYzfD6/RNI5esYBNmadKq9PF+NC75JjOUcD6B58RoVA3gPRRk24ngihVQobc3Uq4l
         thSmJXeBt/SXniamShIIwxS3tPNvc6eydJH/yKlgFeFi1hGHNWvcrOyjqfNJ77ixk3/O
         CvEe+FEW7EuFDSPJaAbFpgyT+zT0o3/YpSRyIHRZKPK7TbbxS1yE6GpGbqoL9ks89hv8
         A/Gdm/kg+M0p/oXPNO30iAraKc49TpUyF9i/vQljeXyDcBBcjUmcwsYb+7P22AZG1DHn
         5RBw==
X-Forwarded-Encrypted: i=1; AJvYcCXKkdFzX8ch1Qm/Sf5FK7UwnXhOvX0k2gAcsMzv5bg747uIGRRvjLyW4JbLUaExAbLebD7csYqRcvwWClgy/+rEUO2ItL3i
X-Gm-Message-State: AOJu0YwTuI1F09wV52UI/HEE1cu9KNTZUDJhQNhnJxZOeQp53i7VrSL3
	hT6caOp9F86eOsqx5D+xZ90TWyCU6Lp9ViSwCHNeDA+TrvRbOzfS4OmjmqYMRPhKP5ffRbqgUU5
	wC0qATmdqQHzGHfkAz9pGN22Tg4UUyyyhE//c
X-Google-Smtp-Source: AGHT+IE2fcstLiatZ+VMAqVOE8K/Ppz+MvH11soX431rmKF3JH6yoP9A26xlLiDzKZTVthIFfB6HyPSaZ6edvBk4PEY=
X-Received: by 2002:a50:c347:0:b0:570:5cb3:b98 with SMTP id
 q7-20020a50c347000000b005705cb30b98mr89055edb.4.1713343523473; Wed, 17 Apr
 2024 01:45:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415132054.3822230-1-edumazet@google.com> <20240415132054.3822230-2-edumazet@google.com>
 <20240416181915.GT2320920@kernel.org> <CANn89i+X3zkk-RwRVuMursG-RY+R6P29AWK-pjjVuNKT91VsJw@mail.gmail.com>
In-Reply-To: <CANn89i+X3zkk-RwRVuMursG-RY+R6P29AWK-pjjVuNKT91VsJw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Apr 2024 10:45:09 +0200
Message-ID: <CANn89i+iNKvCv+RPtCa4KOY9DCEQJfGP9xHSedFUbWZHt2DSFw@mail.gmail.com>
Subject: Re: [PATCH net-next 01/14] net_sched: sch_fq: implement lockless fq_dump()
To: Simon Horman <horms@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 8:33=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Apr 16, 2024 at 8:19=E2=80=AFPM Simon Horman <horms@kernel.org> w=
rote:
> >
> > On Mon, Apr 15, 2024 at 01:20:41PM +0000, Eric Dumazet wrote:
> > > Instead of relying on RTNL, fq_dump() can use READ_ONCE()
> > > annotations, paired with WRITE_ONCE() in fq_change()
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > >  net/sched/sch_fq.c | 96 +++++++++++++++++++++++++++++---------------=
--
> > >  1 file changed, 60 insertions(+), 36 deletions(-)
> > >
> > > diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> > > index cdf23ff16f40bf244bb822e76016fde44e0c439b..934c220b3f4336dc2f70a=
f74d7758218492b675d 100644
> > > --- a/net/sched/sch_fq.c
> > > +++ b/net/sched/sch_fq.c
> > > @@ -888,7 +888,7 @@ static int fq_resize(struct Qdisc *sch, u32 log)
> > >               fq_rehash(q, old_fq_root, q->fq_trees_log, array, log);
> > >
> > >       q->fq_root =3D array;
> > > -     q->fq_trees_log =3D log;
> > > +     WRITE_ONCE(q->fq_trees_log, log);
> > >
> > >       sch_tree_unlock(sch);
> > >
> > > @@ -931,7 +931,7 @@ static void fq_prio2band_compress_crumb(const u8 =
*in, u8 *out)
> > >
> > >       memset(out, 0, num_elems / 4);
> > >       for (i =3D 0; i < num_elems; i++)
> > > -             out[i / 4] |=3D in[i] << (2 * (i & 0x3));
> > > +             out[i / 4] |=3D READ_ONCE(in[i]) << (2 * (i & 0x3));
> > >  }
> > >
> >
> > Hi Eric,
> >
> > I am a little unsure about the handling of q->prio2band in this patch.
> >
> > It seems to me that fq_prio2band_compress_crumb() is used to
> > to store values in q->prio2band, and is called (indirectly)
> > from fq_change() (and directly from fq_init()).
> >
> > While fq_prio2band_decompress_crumb() is used to read values
> > from q->prio2band, and is called from fq_dump().
> >
> > So I am wondering if should use WRITE_ONCE() when storing elements
> > of out. And fq_prio2band_decompress_crumb should use READ_ONCE when
> > reading elements of in.
>
> Yeah, you are probably right, I recall being a bit lazy on this part,
> thanks !

I will squash in V2 this part :

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 934c220b3f4336dc2f70af74d7758218492b675d..238974725679327b0a0d483c011=
e15fc94ab0878
100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -106,6 +106,8 @@ struct fq_perband_flows {
        int                 quantum; /* based on band nr : 576KB, 192KB, 64=
KB */
 };

+#define FQ_PRIO2BAND_CRUMB_SIZE ((TC_PRIO_MAX + 1) >> 2)
+
 struct fq_sched_data {
 /* Read mostly cache line */

@@ -122,7 +124,7 @@ struct fq_sched_data {
        u8              rate_enable;
        u8              fq_trees_log;
        u8              horizon_drop;
-       u8              prio2band[(TC_PRIO_MAX + 1) >> 2];
+       u8              prio2band[FQ_PRIO2BAND_CRUMB_SIZE];
        u32             timer_slack; /* hrtimer slack in ns */

 /* Read/Write fields. */
@@ -159,7 +161,7 @@ struct fq_sched_data {
 /* return the i-th 2-bit value ("crumb") */
 static u8 fq_prio2band(const u8 *prio2band, unsigned int prio)
 {
-       return (prio2band[prio / 4] >> (2 * (prio & 0x3))) & 0x3;
+       return (READ_ONCE(prio2band[prio / 4]) >> (2 * (prio & 0x3))) & 0x3=
;
 }

 /*
@@ -927,11 +929,15 @@ static const struct nla_policy
fq_policy[TCA_FQ_MAX + 1] =3D {
 static void fq_prio2band_compress_crumb(const u8 *in, u8 *out)
 {
        const int num_elems =3D TC_PRIO_MAX + 1;
+       u8 tmp[FQ_PRIO2BAND_CRUMB_SIZE];
        int i;

-       memset(out, 0, num_elems / 4);
+       memset(tmp, 0, sizeof(tmp));
        for (i =3D 0; i < num_elems; i++)
-               out[i / 4] |=3D READ_ONCE(in[i]) << (2 * (i & 0x3));
+               tmp[i / 4] |=3D in[i] << (2 * (i & 0x3));
+
+       for (i =3D 0; i < FQ_PRIO2BAND_CRUMB_SIZE; i++)
+               WRITE_ONCE(out[i], tmp[i]);
 }

 static void fq_prio2band_decompress_crumb(const u8 *in, u8 *out)

