Return-Path: <netdev+bounces-65474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B3283AB6B
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 15:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF66A1C29D0A
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 14:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3D07A70A;
	Wed, 24 Jan 2024 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="P4jugm+s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860E660DFF
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 14:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706105513; cv=none; b=J+JLFb5XFxTIeIE8aYIs3bM+VVVBypbqHRfaCyTRmvZLY5fJFVuJlUbCdop+L3ruJNZAE9IccXlfAs+dHN52CUCEa1xF4vNS5F4XbiwShJdO0zutO6eBbO7UIcQB2FY9QY76w07Oct26Ck4t7F89KRl7BZCCm2ndethZf166dzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706105513; c=relaxed/simple;
	bh=0DXa0y7UvNlWJGnHMekwfLNo0u9YMQwkajG5ISseosc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WqcNtC8ZmA2UWL6cBhtI+hiahpfPh7qIpLuJgN/XrrvTiNYpO7UzBrTYeUzEb653yr6jfKFIPnLmK/bJrf75Cas2deAlW8xTdDlZ3oNw7dKTs2gA1oZkxkUtktUKtI0dMEVjEXPLjkivvZiwCR6vXnBLKLxJSCymkq4UEcdLESQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=P4jugm+s; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso4551238276.3
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 06:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706105510; x=1706710310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7qH7dmDsBONbCoBI04aoU4qjunlCSm/BRIhuee3tO8=;
        b=P4jugm+slKUXduqs6ESxoP5BIcaBXvsCyFeyz1XmgB5pi11mjxWB5k+uWYai9Kx5Cs
         GUbZyjPwVssFC5vJ+GIJdHAQuyUpxanKbbDMKfVU7eEYamVz+3NgHVRW5AgpQNfRRiet
         ryeTQGQqSat/gEaRSpgl2xJY7nG6peiHKuAc9e91hmcL0v+7nQgkj23r/VVcrZtJDgzG
         IJ4iIXBhUqsCs5k2Q2X+4JZkwk5J+lfpbrm2Y9Udie0OA8+jLGs3Tdp6i1YPcWuxy6Bf
         q3mU4+c+pvJ6HBaWnt8Vd64zmQDBk+WFdczup2joqYP1mgBgYbePB7dg0pMCYgUR2dLe
         bROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706105510; x=1706710310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7qH7dmDsBONbCoBI04aoU4qjunlCSm/BRIhuee3tO8=;
        b=ImMbP2dQkXSsBuJIhUTeCNfJ1TBQV6S4VyeKApwdypj5bTeY/i4XVYgD2ZiAl4S51U
         U83vfOBtp4OIIeKsO7cVGlzWTc8oEkA4IGzQ4ZMD4sdhu6WG17QNXDFuXc1MyyB5oQ2i
         5oMARDBgUU4KKDxXXcm7PUh7Q3gpCwUjbtSguiUNXe0SA8tjI+vKle1SprvwKZl9njT+
         xKVa7ZLURaZX54p9z7TJZNT0hCoLznbPqTw9xw1+NhAQQdZOlJ//arzlItG2ny4oW3ml
         //MdneyP36sMFAZULT+YFxhZlB8kS8dbf1rE+0hA/QzZF1Utkw4BxAyYcQWpWwt8hmC9
         jgpQ==
X-Gm-Message-State: AOJu0YzBjpoG+fwHI8EM3+m9QrXkEdCGVbaouKLZgRi0NYvoEgOcI/8v
	yucsCqQYjdO13dFVXnja3eGLQ8Qwgt+AlHR4n/HIKDpGDquHEwIQewUEJxMdn7TJ0WgAgtHTxJU
	AmVFdHzgyba+vdXpwO/gHBTpd9lhrU53n4Vxa
X-Google-Smtp-Source: AGHT+IFb5+8C1djSmdn0cCc9NL7b3nVmUw3QW/oRdoYSyXX4AVErWN55X4uI6kMdIe7h+GG52BT9vLJOlkMxWfJ3kuA=
X-Received: by 2002:a25:ab23:0:b0:dc2:4cf5:abfe with SMTP id
 u32-20020a25ab23000000b00dc24cf5abfemr671085ybi.98.1706105510430; Wed, 24 Jan
 2024 06:11:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705432850.git.amery.hung@bytedance.com>
 <ZbAr_dWoRnjbvv04@google.com> <CAM0EoMkHZO9Mpz7JugN7+o95gqX8HBgAVK6R_jhRRYQ-D=QDFQ@mail.gmail.com>
 <44a35467-53cb-1031-df9d-0891d585db65@iogearbox.net>
In-Reply-To: <44a35467-53cb-1031-df9d-0891d585db65@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 24 Jan 2024 09:11:39 -0500
Message-ID: <CAM0EoMm45HX=zd1qMThugYRGA9bugM-OT9NPx++VWj_zYowDmQ@mail.gmail.com>
Subject: Re: [RFC PATCH v7 0/8] net_sched: Introduce eBPF based Qdisc
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Stanislav Fomichev <sdf@google.com>, Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, toke@redhat.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 8:08=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 1/24/24 1:09 PM, Jamal Hadi Salim wrote:
> > On Tue, Jan 23, 2024 at 4:13=E2=80=AFPM Stanislav Fomichev <sdf@google.=
com> wrote:
> >> On 01/17, Amery Hung wrote:
> >>> Hi,
> >>>
> >>> I am continuing the work of ebpf-based Qdisc based on Cong=E2=80=99s =
previous
> >>> RFC. The followings are some use cases of eBPF Qdisc:
> >>>
> >>> 1. Allow customizing Qdiscs in an easier way. So that people don't
> >>>     have to write a complete Qdisc kernel module just to experiment
> >>>     some new queuing theory.
> >>>
> >>> 2. Solve EDT's problem. EDT calcuates the "tokens" in clsact which
> >>>     is before enqueue, it is impossible to adjust those "tokens" afte=
r
> >>>     packets get dropped in enqueue. With eBPF Qdisc, it is easy to
> >>>     be solved with a shared map between clsact and sch_bpf.
> >>>
> >>> 3. Replace qevents, as now the user gains much more control over the
> >>>     skb and queues.
> >>>
> >>> 4. Provide a new way to reuse TC filters. Currently TC relies on filt=
er
> >>>     chain and block to reuse the TC filters, but they are too complic=
ated
> >>>     to understand. With eBPF helper bpf_skb_tc_classify(), we can inv=
oke
> >>>     TC filters on _any_ Qdisc (even on a different netdev) to do the
> >>>     classification.
> >>>
> >>> 5. Potentially pave a way for ingress to queue packets, although
> >>>     current implementation is still only for egress.
> >>>
> >>> I=E2=80=99ve combed through previous comments and appreciated the fee=
dbacks.
> >>> Some major changes in this RFC is the use of kptr to skb to maintain
> >>> the validility of skb during its lifetime in the Qdisc, dropping rbtr=
ee
> >>> maps, and the inclusion of two examples.
> >>>
> >>> Some questions for discussion:
> >>>
> >>> 1. We now pass a trusted kptr of sk_buff to the program instead of
> >>>     __sk_buff. This makes most helpers using __sk_buff incompatible
> >>>     with eBPF qdisc. An alternative is to still use __sk_buff in the
> >>>     context and use bpf_cast_to_kern_ctx() to acquire the kptr. Howev=
er,
> >>>     this can only be applied to enqueue program, since in dequeue pro=
gram
> >>>     skbs do not come from ctx but kptrs exchanged out of maps (i.e., =
there
> >>>     is no __sk_buff). Any suggestion for making skb kptr and helper
> >>>     functions compatible?
> >>>
> >>> 2. The current patchset uses netlink. Do we also want to use bpf_link
> >>>     for attachment?
> >>
> >> [..]
> >>
> >>> 3. People have suggested struct_ops. We chose not to use struct_ops s=
ince
> >>>     users might want to create multiple bpf qdiscs with different
> >>>     implementations. Current struct_ops attachment model does not see=
m
> >>>     to support replacing only functions of a specific instance of a m=
odule,
> >>>     but I might be wrong.
> >>
> >> I still feel like it deserves at leasta try. Maybe we can find some po=
tential
> >> path where struct_ops can allow different implementations (Martin prob=
ably
> >> has some ideas about that). I looked at the bpf qdisc itself and it do=
esn't
> >> really have anything complicated (besides trying to play nicely with o=
ther
> >> tc classes/actions, but I'm not sure how relevant that is).
> >
> > Are you suggesting that it is a nuisance to integrate with the
> > existing infra? I would consider it being a lot more than "trying to
> > play nicely". Besides, it's a kfunc and people will not be forced to
> > use it.
>
> What's the use case?

What's the use case for enabling existing infra to work? Sure, let's
rewrite everything from scratch in ebpf. And then introduce new
tooling which well funded companies are capable of owning the right
resources to build and manage. Open source is about choices and
sharing and this is about choices and sharing.

> If you already go that route to implement your own
> qdisc, why is there a need to take the performane hit and go all the
> way into old style cls/act infra when it can be done in a more straight
> forward way natively?

Who is forcing you to use the kfunc? This is about choice.
What is ebpf these days anyways? Is it a) a programming environment or
b) is it the only way to do things? I see it as available infra i.e #a
not as the answer looking for a question.  IOW, as something we can
use to build the infra we need and use kfuncs when it makes sense. Not
everybody has infinite resources to keep hacking things into ebpf.

> For the vast majority of cases this will be some
> very lightweight classification anyway (if not outsourced to tc egress
> given the lock). If there is a concrete production need, it could be
> added, otherwise if there is no immediate use case which cannot be solved
> otherwise I would not add unnecessary kfuncs.

"Unnecessary" is really your view.

cheers,
jamal

> Cheers,
> Daniel

