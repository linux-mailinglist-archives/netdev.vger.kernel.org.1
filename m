Return-Path: <netdev+bounces-101898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657EF9007EB
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 17:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4C028BA70
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CC418732D;
	Fri,  7 Jun 2024 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0YK8H7Mp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FF0194AD3
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772069; cv=none; b=aIzcWDGkYfrpM++Yc33yZVub5mXAKs6rQLT5mQR9l6TG3ohckMW/03LrMNGdvu82zcMjs23khIMSAsUt4IeZeCy2bOQ4M6qrihSeNczYbYssfpZMkrdyBvFzyAqtgByDw1AQuzMCgMT6NfiRFDsbJTDtea8Z/RUdc07py4YXIlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772069; c=relaxed/simple;
	bh=lmK288VZ+Au6UYiggllrjx3A4mW0p+aY1rqBCbrC0MA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HcP2FwexdW7mvSHSJybFf/GaJKd07hSzEviyYTk48J2qzxmOU5f77f8DeJ00HUhiUqk6/KFtuUKIfTRZftUHREZAQel6AI5GAXvTgfZ8ivh0LbMKuvws5aGTcvJJC2IvvXSL7vLMpYn2NoA4a8nwMd+b6OHHF+zUx/AUijOr/ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0YK8H7Mp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4216d9952d2so38385e9.0
        for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 07:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717772065; x=1718376865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDVi+2ZBhcOD3G6Gj3CAdm/DYMI+dRngfz2rmLeWYr0=;
        b=0YK8H7MpObBCV6BhjaW0shS6FTxHhqakXb0W/MgdxeBdH9pV87UIUitIT7AuCJ1T33
         EbMEytOeCqs4F1QY0G/o/sPzgn5GDUnaZphq0a9KUozIECmCdvLdECqetc8SPO7+1Xvx
         HQntFXmAWP0FgE/B9Ac6/d+xRaG34HUYB8lnfjo9C/P6QBkbTN5gLYVd7WuZ/SOV7iBa
         nIlpWTVCel+AD4lM9HhVEDHm5XhGnILpZZMG/qRXW9Hawl5bkDi9H42RxnvVZb5FBbih
         QLrIxTSqjQgRByNgq4i3PSLQ7FihrTlYTzRrtO1V3r4VaruhjAnNeaAxM5sNmaOa3v3Y
         wZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717772065; x=1718376865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDVi+2ZBhcOD3G6Gj3CAdm/DYMI+dRngfz2rmLeWYr0=;
        b=vkNGgxeEXdKoBi1se43hY0H3U4vb1phMF9hXfxngqKnk8UsIwhW5hqEjWp6l2+CX5u
         nOi0Y7ovakUm9V4rri//u9PZokNuChhOAglQEuyKNjVugVjB0yRSyB6iaxrWKU23LXLq
         1IEug8Au6R5h2S+97Mi2/GPn64SlyvUocxQG7Nq9Yq2TtmpYsOLqciqFMzdHtgIDYdw3
         uqjVHcJo3rMvCr7ernUjGNC12ghX4RTVwy67Tc7C4F04/Nzn29rH/O02VbwLVABUgzps
         MleypkvGO588Aad0ngQ/GjvIoEtdVttcnhL5tlzPtqscaOtiYXWQ39+bE8iW+Efqh9XD
         VAkA==
X-Forwarded-Encrypted: i=1; AJvYcCU94DHShkrMnU5ZzarsqtK/+u3etU8vFECoy6o/gXuZ0Wll3A30Y7qmgypyfL80GdSHLDedS8kqRf0jEG8y3W2gnyz36xU8
X-Gm-Message-State: AOJu0YxKxF5QIwo+Us2nA6JrcXtOc/hEMo+GPbe6ypHPyWwY3BIDRjrE
	qt29GW8GdqpGSq4toccntIfKf4O0zOn4zLZBGYdRsOGzX7AsHZ8rO9CT5GEdnDl8LR/b2msEX4U
	FSpxe0s5OCgKWJhjbq0+d2Zp8zGrMf7LRmBat
X-Google-Smtp-Source: AGHT+IHhjtFQr7/uCpnoTcDWiakgtql/TDb36sMa3eiVaH0v/oVDMMPuG6sxRwnu+MLy1eJlP+setAKoGZgq4oGViSY=
X-Received: by 2002:a05:600c:1e0f:b0:421:719b:cb6c with SMTP id
 5b1f17b1804b1-421719bcd6cmr818615e9.5.1717772064413; Fri, 07 Jun 2024
 07:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415210728.36949-1-victor@mojatatu.com> <127148e766b177a470a397d9c1615fae19934141.camel@sipsolutions.net>
In-Reply-To: <127148e766b177a470a397d9c1615fae19934141.camel@sipsolutions.net>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Jun 2024 16:54:10 +0200
Message-ID: <CANn89iLyXx8iRScGr5zzBVJ+-BnN==3JJ7DivQE_VUpaQVO4iQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: Fix mirred deadlock on device recursion
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, netdev@vger.kernel.org, renmingshuai@huawei.com, 
	pctammela@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 4:40=E2=80=AFPM Johannes Berg <johannes@sipsolutions=
.net> wrote:
>
> Hi all,
>
> I noticed today that this causes a userspace visible change in behaviour
> (and a regression in some of our tests) for transmitting to a device
> when it has no carrier, when noop_qdisc is assigned to it. Instead of
> silently dropping the packets, -ENOBUFS will be returned if the socket
> opted in to RECVERR.
>
> The reason for this is that the static noop_qdisc:
>
> struct Qdisc noop_qdisc =3D {
>         .enqueue        =3D       noop_enqueue,
>         .dequeue        =3D       noop_dequeue,
>         .flags          =3D       TCQ_F_BUILTIN,
>         .ops            =3D       &noop_qdisc_ops,
>         .q.lock         =3D       __SPIN_LOCK_UNLOCKED(noop_qdisc.q.lock)=
,
>         .dev_queue      =3D       &noop_netdev_queue,
>         .busylock       =3D       __SPIN_LOCK_UNLOCKED(noop_qdisc.busyloc=
k),
>         .gso_skb =3D {
>                 .next =3D (struct sk_buff *)&noop_qdisc.gso_skb,
>                 .prev =3D (struct sk_buff *)&noop_qdisc.gso_skb,
>                 .qlen =3D 0,
>                 .lock =3D __SPIN_LOCK_UNLOCKED(noop_qdisc.gso_skb.lock),
>         },
>         .skb_bad_txq =3D {
>                 .next =3D (struct sk_buff *)&noop_qdisc.skb_bad_txq,
>                 .prev =3D (struct sk_buff *)&noop_qdisc.skb_bad_txq,
>                 .qlen =3D 0,
>                 .lock =3D __SPIN_LOCK_UNLOCKED(noop_qdisc.skb_bad_txq.loc=
k),
>         },
> };
>
> doesn't have an owner set, and it's obviously not allocated via
> qdisc_alloc(). Thus, it defaults to 0, so if you get to it on CPU 0 (I
> was using ARCH=3Dum which isn't even SMP) then it will just always run
> into the
>
> > +     if (unlikely(READ_ONCE(q->owner) =3D=3D smp_processor_id())) {
> > +             kfree_skb_reason(skb, SKB_DROP_REASON_TC_RECLASSIFY_LOOP)=
;
> > +             return NET_XMIT_DROP;
> > +     }
>
> case.
>
> I'm not sure I understand the busylock logic well enough, so almost
> seems to me we shouldn't do this whole thing on the noop_qdisc at all,
> e.g. via tagging owner with -2 to say don't do it:
>
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3865,9 +3865,11 @@ static inline int __dev_xmit_skb(struct sk_buff *s=
kb, struct Qdisc *q,
>                 qdisc_run_end(q);
>                 rc =3D NET_XMIT_SUCCESS;
>         } else {
> -               WRITE_ONCE(q->owner, smp_processor_id());
> +               if (q->owner !=3D -2)
> +                       WRITE_ONCE(q->owner, smp_processor_id());
>                 rc =3D dev_qdisc_enqueue(skb, q, &to_free, txq);
> -               WRITE_ONCE(q->owner, -1);
> +               if (q->owner !=3D -2)
> +                       WRITE_ONCE(q->owner, -1);
>                 if (qdisc_run_begin(q)) {
>                         if (unlikely(contended)) {
>                                 spin_unlock(&q->busylock);
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 2a637a17061b..e857e4638671 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -657,6 +657,7 @@ static struct netdev_queue noop_netdev_queue =3D {
>  };
>
>  struct Qdisc noop_qdisc =3D {
> +       .owner          =3D       -2,
>         .enqueue        =3D       noop_enqueue,
>         .dequeue        =3D       noop_dequeue,
>         .flags          =3D       TCQ_F_BUILTIN,
>
>
> (and yes, I believe it doesn't need to be READ_ONCE for the check
> against -2 since that's mutually exclusive with all other values)
>
> Or maybe simply ignoring the value for the noop_qdisc:
>
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3822,7 +3822,7 @@ static inline int __dev_xmit_skb(struct sk_buff *sk=
b, struct Qdisc *q,
>                 return rc;
>         }
>
> -       if (unlikely(READ_ONCE(q->owner) =3D=3D smp_processor_id())) {
> +       if (unlikely(q !=3D &noop_qdisc && READ_ONCE(q->owner) =3D=3D smp=
_processor_id())) {
>                 kfree_skb_reason(skb, SKB_DROP_REASON_TC_RECLASSIFY_LOOP)=
;
>                 return NET_XMIT_DROP;
>         }
>
> That's shorter, but I'm not sure if there might be other special
> cases...
>
> Or maybe someone can think of an even better fix?

Why not simply initialize noop_qdisc.owner to -1 ?

