Return-Path: <netdev+bounces-88638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D868A7F09
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 11:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4AAB28336D
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 09:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F086512F5AC;
	Wed, 17 Apr 2024 09:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zXGA3O1O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5804112B16A
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 09:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344589; cv=none; b=cFkeUF7PdjmQj9JUeq2Dup8rjWzUK538jlWbENHriFCHg5GjyRLOxzt+ke/0Dgk4sxoK8I9M7XMf2djheyZ+A87zTe08McJZ3YnZek4L83jlLSUZ1Wsyiwu5GbbmMmBKmaWyAFBK99B7rgj8HTFBugLpdCtqRi3o2n30l+egmmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344589; c=relaxed/simple;
	bh=c3x1WWAjvQ9L6jxaILXvEihEKfF3yPNzw1mmk5TzDm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cyrXIvH8rOfz5Yb7qIKGO/+SAtW5JRNmFU9MdkovE0iZsXx2HYmEkgVtxW3Dmfgm+BX4OBIvpxKnGLWmOsMRM7HFoTwo8AjZyHUjeeERHmmr1pjG1qVGKSkfknX1hmau6CltizlOlA78Ym/bkkIW6d0IjEdeGAs2iyumrkDs/uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zXGA3O1O; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56fd95160e5so6894a12.0
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 02:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713344587; x=1713949387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qw4QVuFdV0t5j6l8eLsmKjgYFLjItZJ+AfV99LSApYY=;
        b=zXGA3O1OpYkxD7t9aQr5layqFXhIV1VEy0xTVF3xaA4fHXlNvTlrpuxLnBNFBveMR7
         o88WG0Ec5r7LQ+24WQMBJR8Q1ixnbFdYxcGakXevuzQoP0E7YD1TSoPq8NahNtfCSawS
         VvVM3YIkaGJmoaocuGlXiV5TBRtsNFfEiA093liNuwZB5vx3Qj1d8/sOevSJa8zHF3Rn
         iQK2zL0g9fI/WPbnAsNwFG8GsS/w6nl4szjba4PUNXRE9xjUdDa+e7u19+zwkoKz7LHn
         gM44TiR1TBXJMp0dunD3DCB+VfpPGrmHlOW7iNJ7n6bxggvWxPChPBLAoaLz3QVaS5u6
         /ECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713344587; x=1713949387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qw4QVuFdV0t5j6l8eLsmKjgYFLjItZJ+AfV99LSApYY=;
        b=HAwFkNeVmKls+m7WuelEWOBmTolFPwdHjI4et9Hpw5C1EVzoynU3RK/mrAdy9Sn5YC
         M8yqqmiCSFw40hs5jODAG7lu5ZoInXZNy9Wdll0a6vABeKa9Oa9rWouimw326l1gLgsf
         UEKWT/j2duoB9iHAWAsvH2EhM++NoaC1JmDDbsrGZ3dI3cwVROyCIBYSShcVCTe1H4bh
         KVhjv2uFhsmXNNy2Vo89qCHHC/IFnpJlrOmM3qBSgMU+SAcJ2a4KEWUWlhJojEA+AWzi
         EIxigZ9vO6/zIQjzjBWhSsQK9u6stMhatXAyi8ZIRAjrMwKPFUUfa14S/lintqWdZnUX
         ugwA==
X-Forwarded-Encrypted: i=1; AJvYcCViWu/+HZnpdVfulWnR+SzR+m3dF2+d+D5nVLI0HqJdQCSHf/cat7ewjFfhSTTcS5s6qPkM7+1LaNxNne0LLQsz4XJikEEL
X-Gm-Message-State: AOJu0YyOmbbIb4RVtcIXU2R7EE8atszwNL6GbkB8WoSsY5fXYgfEE2dz
	8lr2QQ9ZUeBD3/mr8AU2HbJKXBE+YXgOwqpfsIW5Do8SUiKw2eiH91sOWZ4FaRyADQtgQg13tYf
	ovmYZsKOhy99WVGzqeY94dJmVJoamdAdSoDHX
X-Google-Smtp-Source: AGHT+IHWG3gtNj8HfdjenwtXHVj5eEU1xeXDgJETyhlyvDgKlafTWuBYJG4PqLYYjqBV0RD4PrDDBQZb+S5HnKYNbWQ=
X-Received: by 2002:aa7:c90c:0:b0:570:49fb:79d0 with SMTP id
 b12-20020aa7c90c000000b0057049fb79d0mr115412edt.3.1713344586393; Wed, 17 Apr
 2024 02:03:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415132054.3822230-1-edumazet@google.com> <20240415132054.3822230-2-edumazet@google.com>
 <20240416181915.GT2320920@kernel.org> <CANn89i+X3zkk-RwRVuMursG-RY+R6P29AWK-pjjVuNKT91VsJw@mail.gmail.com>
 <CANn89i+iNKvCv+RPtCa4KOY9DCEQJfGP9xHSedFUbWZHt2DSFw@mail.gmail.com> <20240417090046.GB3846178@kernel.org>
In-Reply-To: <20240417090046.GB3846178@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Apr 2024 11:02:55 +0200
Message-ID: <CANn89iJwJHz4T-Rz03TYJcGCn8fBUncK-Wbefn_zPDh7Vy80Kw@mail.gmail.com>
Subject: Re: [PATCH net-next 01/14] net_sched: sch_fq: implement lockless fq_dump()
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 11:00=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Wed, Apr 17, 2024 at 10:45:09AM +0200, Eric Dumazet wrote:
> > On Tue, Apr 16, 2024 at 8:33=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Tue, Apr 16, 2024 at 8:19=E2=80=AFPM Simon Horman <horms@kernel.or=
g> wrote:
> > > >
> > > > On Mon, Apr 15, 2024 at 01:20:41PM +0000, Eric Dumazet wrote:
> > > > > Instead of relying on RTNL, fq_dump() can use READ_ONCE()
> > > > > annotations, paired with WRITE_ONCE() in fq_change()
> > > > >
> > > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > > ---
> > > > >  net/sched/sch_fq.c | 96 +++++++++++++++++++++++++++++-----------=
------
> > > > >  1 file changed, 60 insertions(+), 36 deletions(-)
> > > > >
> > > > > diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> > > > > index cdf23ff16f40bf244bb822e76016fde44e0c439b..934c220b3f4336dc2=
f70af74d7758218492b675d 100644
> > > > > --- a/net/sched/sch_fq.c
> > > > > +++ b/net/sched/sch_fq.c
> > > > > @@ -888,7 +888,7 @@ static int fq_resize(struct Qdisc *sch, u32 l=
og)
> > > > >               fq_rehash(q, old_fq_root, q->fq_trees_log, array, l=
og);
> > > > >
> > > > >       q->fq_root =3D array;
> > > > > -     q->fq_trees_log =3D log;
> > > > > +     WRITE_ONCE(q->fq_trees_log, log);
> > > > >
> > > > >       sch_tree_unlock(sch);
> > > > >
> > > > > @@ -931,7 +931,7 @@ static void fq_prio2band_compress_crumb(const=
 u8 *in, u8 *out)
> > > > >
> > > > >       memset(out, 0, num_elems / 4);
> > > > >       for (i =3D 0; i < num_elems; i++)
> > > > > -             out[i / 4] |=3D in[i] << (2 * (i & 0x3));
> > > > > +             out[i / 4] |=3D READ_ONCE(in[i]) << (2 * (i & 0x3))=
;
> > > > >  }
> > > > >
> > > >
> > > > Hi Eric,
> > > >
> > > > I am a little unsure about the handling of q->prio2band in this pat=
ch.
> > > >
> > > > It seems to me that fq_prio2band_compress_crumb() is used to
> > > > to store values in q->prio2band, and is called (indirectly)
> > > > from fq_change() (and directly from fq_init()).
> > > >
> > > > While fq_prio2band_decompress_crumb() is used to read values
> > > > from q->prio2band, and is called from fq_dump().
> > > >
> > > > So I am wondering if should use WRITE_ONCE() when storing elements
> > > > of out. And fq_prio2band_decompress_crumb should use READ_ONCE when
> > > > reading elements of in.
> > >
> > > Yeah, you are probably right, I recall being a bit lazy on this part,
> > > thanks !
> >
> > I will squash in V2 this part :
> >
> > diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> > index 934c220b3f4336dc2f70af74d7758218492b675d..238974725679327b0a0d483=
c011e15fc94ab0878
> > 100644
> > --- a/net/sched/sch_fq.c
> > +++ b/net/sched/sch_fq.c
> > @@ -106,6 +106,8 @@ struct fq_perband_flows {
> >         int                 quantum; /* based on band nr : 576KB, 192KB=
, 64KB */
> >  };
> >
> > +#define FQ_PRIO2BAND_CRUMB_SIZE ((TC_PRIO_MAX + 1) >> 2)
> > +
> >  struct fq_sched_data {
> >  /* Read mostly cache line */
> >
> > @@ -122,7 +124,7 @@ struct fq_sched_data {
> >         u8              rate_enable;
> >         u8              fq_trees_log;
> >         u8              horizon_drop;
> > -       u8              prio2band[(TC_PRIO_MAX + 1) >> 2];
> > +       u8              prio2band[FQ_PRIO2BAND_CRUMB_SIZE];
> >         u32             timer_slack; /* hrtimer slack in ns */
> >
> >  /* Read/Write fields. */
> > @@ -159,7 +161,7 @@ struct fq_sched_data {
> >  /* return the i-th 2-bit value ("crumb") */
> >  static u8 fq_prio2band(const u8 *prio2band, unsigned int prio)
> >  {
> > -       return (prio2band[prio / 4] >> (2 * (prio & 0x3))) & 0x3;
> > +       return (READ_ONCE(prio2band[prio / 4]) >> (2 * (prio & 0x3))) &=
 0x3;
> >  }
>
> Thanks Eric,
>
> assuming that it is ok for this version of fq_prio2band() to run
> from fq_enqueue(), this update looks good to me.

It is ok, a READ_ONCE() here is not adding any constraint on compiler outpu=
t.

