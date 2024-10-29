Return-Path: <netdev+bounces-140002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 107509B4FD3
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 17:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C853128197E
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 16:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A901C19C572;
	Tue, 29 Oct 2024 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xnnNRQjs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AFE198A31
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730220801; cv=none; b=dPgQMI8EjTb4+lkLQCRpCO1hLMLU9ACTyw9fzqhfkg7NDwj/agVIbzBJ8fsKBqNM/c9UrjRhKBCQizW/L3NGY4yS2jG6AbUotuT33N5l1ak+7deTvXF6o/QDMjEGqdS1xk2Xv8NRuvB4/brYBHwWjiaOH+zeJpYhu8YzQUbeuLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730220801; c=relaxed/simple;
	bh=x54Z0wtG2LrpbQbONudacBNWMadlunhKzlrTTDYlviA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBcIwMVeqYWrjn3YtpbVHvZgBvH8g1aZ6tL0aT4bWuNUP9kWaYDsWh6C8Mv8qCZ4WYLisEjSQUmWXYsvHdTuJO+IkoUjldHwEhqEVcxMHPOn6ickVGTyDRXLAioxMB02qFopTGhAwne+HdQwsW07ls4x+tVeMzvwbygKBo9xKec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xnnNRQjs; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so62578a12.0
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 09:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730220798; x=1730825598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOwg/Y87ZW2RQ/8S0ZvL41CF+lRaeGUDZjoUQ+FbW20=;
        b=xnnNRQjsfMI0Sui8mr2WhpNp+w3QWy/CthFD9le/UpROFx5jGU6KPiHJQuwbc/XI/d
         QXgt9Cx+d5BSXvLmKtIINDvPVotZgUacCnjQMR7j7rJNeYaeVdfaY40oCr1BT3Ker0dR
         7YyFZRyD1PnHsr7A/ugFZcNKHlFU1vKhbuw+sXj40doNxbA1z7WB4+x7jXYxoW8OgnVx
         KpZOEoqueFulOxVwSp0uBPbDFRBqFgeOiL0UEdDc7HCjp9mmTi8R8q1uvKW7Bl2i+3A6
         JRQiLdQ6vdJanunC6fDiFzjKbJP0ImExS3CazV8BwCCjPerLBEp9ZCOpa65rWkXTwUEA
         6egw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730220798; x=1730825598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOwg/Y87ZW2RQ/8S0ZvL41CF+lRaeGUDZjoUQ+FbW20=;
        b=E6IRMgPF9SF7ykgGyRqlfBnHHzOBSibG+0gHT16cr4vRScM3lpoweozLtzVKB62g6k
         2/U6VxRI+kRIPuGKMcFvlPH3i1bRhyL3UxR+Fc7Ci1dGx2fKk58isPCgiSKZ1FFczVGJ
         37ogpbTJ4N2xDelAAQYXJYdGAXHlT82rOUL6UpHEyGrol5GqKqat+XelzsJbSxIzzYle
         nn1ggk1zK2G5UYYAgjGBklh8lTBQfF756LX2G8m7gS7oJPHmq4QOh4SH19GTOXkZ0tIz
         M+Zl+BpGUebIaX0qyDMfI6DV6dNq10/IBjdybw61ziHdfd7c8rUyjQcPSstmql68oFEm
         rNkA==
X-Forwarded-Encrypted: i=1; AJvYcCW6rk3IJbkbi6s+FKblcoUWHVO/4c2tKrk8y0R1VUFrbb+oFObGjk/2kQQJmRdbcL3ugG5M9hc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqzh7gUfvi4fhqG5N2GhvDkK17H2IdSib4Xt6kyBInVGYmku7z
	8SC2eE4EOTFs1H30UnHKlvQ1kqX8/eHdAmxEzprF8jVHCOacfEf80p0AyimX2tCmSDZMpIZSha7
	DYqHuyHSxPx8sLfdZXyNHm/w2n64+FzQw34lc
X-Google-Smtp-Source: AGHT+IF+S4AhSXvWVvX42SCxvI0frHbFabV+YTQCZidncDNzoHivaZ1K4UhBlEyLYMjjorIm78IBQDPZ8yct+zR7g84=
X-Received: by 2002:a05:6402:1ed3:b0:5cb:881e:6d3c with SMTP id
 4fb4d7f45d1cf-5cd2902892dmr2551635a12.8.1730220797629; Tue, 29 Oct 2024
 09:53:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021221248.60378-1-chia-yu.chang@nokia-bell-labs.com>
 <20241021221248.60378-2-chia-yu.chang@nokia-bell-labs.com> <ea2ccad9-6a4a-48e1-8e99-0289e13d501c@redhat.com>
In-Reply-To: <ea2ccad9-6a4a-48e1-8e99-0289e13d501c@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 29 Oct 2024 17:53:03 +0100
Message-ID: <CANn89iKU5G-vEPkLFY9vGyNBEA-G6msGiPJqiBNAcw4nNXoSbg@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 1/1] sched: Add dualpi2 qdisc
To: Paolo Abeni <pabeni@redhat.com>
Cc: chia-yu.chang@nokia-bell-labs.com, netdev@vger.kernel.org, 
	davem@davemloft.net, stephen@networkplumber.org, jhs@mojatatu.com, 
	kuba@kernel.org, dsahern@kernel.org, ij@kernel.org, ncardwell@google.com, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com, Olga Albisser <olga@albisser.org>, 
	Olivier Tilmans <olivier.tilmans@nokia.com>, Henrik Steen <henrist@henrist.net>, 
	Bob Briscoe <research@bobbriscoe.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 1:56=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 10/22/24 00:12, chia-yu.chang@nokia-bell-labs.com wrote:
> > +/* Default alpha/beta values give a 10dB stability margin with max_rtt=
=3D100ms. */
> > +static void dualpi2_reset_default(struct dualpi2_sched_data *q)
> > +{
> > +     q->sch->limit =3D 10000;                          /* Max 125ms at=
 1Gbps */
> > +
> > +     q->pi2.target =3D 15 * NSEC_PER_MSEC;
> > +     q->pi2.tupdate =3D 16 * NSEC_PER_MSEC;
> > +     q->pi2.alpha =3D dualpi2_scale_alpha_beta(41);    /* ~0.16 Hz * 2=
56 */
> > +     q->pi2.beta =3D dualpi2_scale_alpha_beta(819);    /* ~3.20 Hz * 2=
56 */
> > +
> > +     q->step.thresh =3D 1 * NSEC_PER_MSEC;
> > +     q->step.in_packets =3D false;
> > +
> > +     dualpi2_calculate_c_protection(q->sch, q, 10);  /* wc=3D10%, wl=
=3D90% */
> > +
> > +     q->ecn_mask =3D INET_ECN_ECT_1;
> > +     q->coupling_factor =3D 2;         /* window fairness for equal RT=
Ts */
> > +     q->drop_overload =3D true;        /* Preserve latency by dropping=
 */
> > +     q->drop_early =3D false;          /* PI2 drops on dequeue */
> > +     q->split_gso =3D true;
>
> This is a very unexpected default. Splitting GSO packets earlier WRT the
> H/W constaints definitely impact performances in a bad way.
>
> Under which condition this is expected to give better results?
> It should be at least documented clearly.

I agree, it is very strange to see this orthogonal feature being
spread in some qdisc.

Also, it seems this qdisc could be a mere sch_prio queue, with two
sch_pie children, or two sch_fq or sch_fq_codel ?

Many of us are using fq_codel or fq, there is no way we can switch to
dualpi2 just to experiment things.

