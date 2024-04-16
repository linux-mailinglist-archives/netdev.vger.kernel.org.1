Return-Path: <netdev+bounces-88437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C76888A734A
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 20:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615361F23215
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 18:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D488413774B;
	Tue, 16 Apr 2024 18:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sBmCGsXA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B1B1369B9
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 18:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713292456; cv=none; b=Y9ucawD9iBDssm6IPdk0S+E8xalViYC7D75GDzDYhqU1QFXa4e+TaEgidIzBf696mVY9iQThYGaJfK+ziH+x05sKjL4kkO6bsyXSuoNIq43KU+6fm6cIi6+Hke+81pZ/P34mKkG2IsPTcDFE5fy3gsjLnV6E8cZvF0Slq1KVBvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713292456; c=relaxed/simple;
	bh=KRxFQHyl5hDDENMteVrNhoLm4iSPPaU10DRfwxpZqj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JeoHRf36x3yPfRJ2l8afVtS/AwwU1EiZU9Y/SsvpoxmD08WUMT67Ovt0nnVFrEwqKTpur1k+RyR3/ymOpPqHLTx0K5NUcTsmyWGjzvNwKYEfHGxrIfCzG61pVbRNfhbMYLQQbtJqQC3Bx+lV4zysHDk/s6yx7HZ5VzoQwC4hj/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sBmCGsXA; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e2e851794so2485a12.0
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 11:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713292453; x=1713897253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mk4Rn9dlEZS52PurMADWXLJ7EQYv/b0/1q1qlwKXaNE=;
        b=sBmCGsXA4ZW7dn1kFnSpOM061sZFoV7bcbKa7rCHoszp/7EqyZ5FDajrhR/iVvvUj/
         CqFT22xfnadxYaMMgNQ/4RJhQYHJdkHVXTEUjns5CuAtvI69BMlXAGHt5BJVHNrDm8ja
         te2qz/xxdOsdYn3kXt9YmfjwpnIB48ekEXs3/wAcqIbRmE86/iJkL5wK7or6ZBCB4Sb9
         eaqZ0DZLXn3Hq3rKOIddcfXhVgv2sK29qID9id/dQ5lTedo6khBnSvaSL7JF4T7rs3ug
         TCAtRlOAzV9Ffe/v0nBPBRU/7emhk+xLzE0CcB5/yMMd5I79vW76hb+patzWUnac9IaW
         dLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713292453; x=1713897253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mk4Rn9dlEZS52PurMADWXLJ7EQYv/b0/1q1qlwKXaNE=;
        b=dqq2NKqA5QgaT7KKrrDj3RUfmIP3q+AcQscOeJbdLJpKktmSQ8l+RpvxaQEKq5n3yz
         JjqSgqOQVlOtZVMrEm1wDQKnCXs0xocTyCas/U8iLODlgsBYznRdj45AVVagHUWHUiNB
         fFqRC8qeviqO2kUwaWf5PUbRTDG3ZpjV0Z1070fItYSAIVv4w9L2Oq3Yk0pPBPk3vlBI
         7TgpZqHYG9bsLn2u0SwULW/tkIla/niq2SVzgNoaRIddG2UvnzdfLRh0PB1CdQ3Fy5+2
         GfqP/PvSLIN1vhx2cg4qBvkk3IQng64oZjrXsSlvvu7BFVHSf9WxxB+5WyRdR7UOoEj1
         cY7w==
X-Forwarded-Encrypted: i=1; AJvYcCXf/btnnQ7gODnEY/ngbr02ghXO/Fimwyiv+dU4kTxTl8BX5oH6oHX6z2vOjXtu3jv/fuV49fj7cjoav2C4qZIploFv9XYd
X-Gm-Message-State: AOJu0YzmrR3axwJltwI6u7nEjcC088hOZxe0tAOWQkv1at6j92/Z4mTO
	u+KlVmpTuq6BqH5MDVC0LEiTn2mftZQqn4iLsm7LIDuQosmlYMDakQ3DJht68AlT/6XIrvaIIzj
	uFvOrLwBfmprqijHB4ROLlMjLwERGr2Moay9b
X-Google-Smtp-Source: AGHT+IGa1rXf0x2pdJH6f1Jjj4H94A9ys2mwjXNT/LXnRach5JxvE7mknZEHhIwSY8yC68eYISjdW9mOStoFnpdzpzc=
X-Received: by 2002:a50:8d84:0:b0:570:49e3:60a8 with SMTP id
 r4-20020a508d84000000b0057049e360a8mr14765edh.7.1713292453086; Tue, 16 Apr
 2024 11:34:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415132054.3822230-1-edumazet@google.com> <20240415132054.3822230-2-edumazet@google.com>
 <20240416181915.GT2320920@kernel.org>
In-Reply-To: <20240416181915.GT2320920@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 16 Apr 2024 20:33:58 +0200
Message-ID: <CANn89i+X3zkk-RwRVuMursG-RY+R6P29AWK-pjjVuNKT91VsJw@mail.gmail.com>
Subject: Re: [PATCH net-next 01/14] net_sched: sch_fq: implement lockless fq_dump()
To: Simon Horman <horms@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 8:19=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Mon, Apr 15, 2024 at 01:20:41PM +0000, Eric Dumazet wrote:
> > Instead of relying on RTNL, fq_dump() can use READ_ONCE()
> > annotations, paired with WRITE_ONCE() in fq_change()
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/sched/sch_fq.c | 96 +++++++++++++++++++++++++++++-----------------
> >  1 file changed, 60 insertions(+), 36 deletions(-)
> >
> > diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> > index cdf23ff16f40bf244bb822e76016fde44e0c439b..934c220b3f4336dc2f70af7=
4d7758218492b675d 100644
> > --- a/net/sched/sch_fq.c
> > +++ b/net/sched/sch_fq.c
> > @@ -888,7 +888,7 @@ static int fq_resize(struct Qdisc *sch, u32 log)
> >               fq_rehash(q, old_fq_root, q->fq_trees_log, array, log);
> >
> >       q->fq_root =3D array;
> > -     q->fq_trees_log =3D log;
> > +     WRITE_ONCE(q->fq_trees_log, log);
> >
> >       sch_tree_unlock(sch);
> >
> > @@ -931,7 +931,7 @@ static void fq_prio2band_compress_crumb(const u8 *i=
n, u8 *out)
> >
> >       memset(out, 0, num_elems / 4);
> >       for (i =3D 0; i < num_elems; i++)
> > -             out[i / 4] |=3D in[i] << (2 * (i & 0x3));
> > +             out[i / 4] |=3D READ_ONCE(in[i]) << (2 * (i & 0x3));
> >  }
> >
>
> Hi Eric,
>
> I am a little unsure about the handling of q->prio2band in this patch.
>
> It seems to me that fq_prio2band_compress_crumb() is used to
> to store values in q->prio2band, and is called (indirectly)
> from fq_change() (and directly from fq_init()).
>
> While fq_prio2band_decompress_crumb() is used to read values
> from q->prio2band, and is called from fq_dump().
>
> So I am wondering if should use WRITE_ONCE() when storing elements
> of out. And fq_prio2band_decompress_crumb should use READ_ONCE when
> reading elements of in.

Yeah, you are probably right, I recall being a bit lazy on this part,
thanks !

