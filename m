Return-Path: <netdev+bounces-130511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC9498AB73
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 19:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0B61F23487
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 17:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A8F198A29;
	Mon, 30 Sep 2024 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zKWJTHIb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7275418C31
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727718935; cv=none; b=SQW/V7GrpYqNjsuf9MiAuFuzR7yhsOlc5IXZb76yVpKiKu4AP6jWlr6ws/3bg6F1hYe2cYzn/lcc2oIgZCM+g8Q2/p+ipOTNNIF5eFci5vyV+n/YLZhKA/mlbFV1gNwjYSo/5wShbr4PNtWE2gg7XkvkHz+VCx4U0yndgmS+pU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727718935; c=relaxed/simple;
	bh=ppSW4Jbr9qin0yfPYvgGd+q/CUmEXdgMD/qkneS/dL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onePEq/pXcPCoL4naRcUwsBy5CyA1OHNoaLtIRrfSy5trmn6Vf/ABIMquwBS8dIW/KGni7qBu74/B8T/kgidvm9DVR3xpIp4Ie09TeAy1BRlHx+G0K1NlJ7nZtnpzqLZG5Vcksw6HEAEcWndEnTg/P2M8JopUhvvW1MnpKXbtoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zKWJTHIb; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fac63abf63so16544821fa.1
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 10:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727718929; x=1728323729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmMBs98LDtNFfj+SiK12Jir/xT7VGYyGzgO+W0yI4Xk=;
        b=zKWJTHIb2XDR32CAJEfw/jJzERLcpz88cGIsvfqXI+GQdahmhE8QCHgaXW+Uv1G6wU
         nw+AGmCL2Z8hKPASsVKLB4c1nR/35nCHMgEKrhDNIcHf4JgbELz6EE+G1bUYptHQz37z
         y1yMQ5Q/VxhKRGaZEWhWtwuE9wZKEmgEApJpbWU5YziTN92TYkXnbphQ3zY+1/aKXkQy
         0GPROzpdLw+NigCiGgkBDhCB0zb4q3f2euKu0NJwuzhbI/9lWYVmL3479lp0q3FjzjXY
         aWgkmHaKcLrStRD+zmgw0Cpk2xZMzC/QUFIAcTN9z1xRcZp+S+hInOqNi6mKCPt+MS/1
         eDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727718929; x=1728323729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmMBs98LDtNFfj+SiK12Jir/xT7VGYyGzgO+W0yI4Xk=;
        b=wdnVlsSZdk8OigjJGyF5GS3Mo9Oytb5rk7QmtJpcltYdh8CTuP1+duqbnE6bFgxbEV
         2T7Qo5E7k18sgA6wfIHlyxRZqBiNOkrwoFUCmy0NqOzeWDXhtyevSzMpr6SgLJKYq6MA
         B9ih0p/BR778ANvO6049I+hQ99d5KOSHqDWvNNuqWb4caEBm4+vFNA8PYoCC4MO4fZeb
         BUB51Jkvie9AS2gtknExz481OyIHwFxIWHsJx4YHqXENJf3BhhzB5CBRvVm5b9qXC9tb
         bAf4q+cOlbn/ZuvNc2VfGj1TNpJyzqA1rJKXS5EIH1pY9O2vZuS134w5iDTCsm90mAVi
         wlNA==
X-Forwarded-Encrypted: i=1; AJvYcCUeviC6PihSP4ygAnH3/KWshd6YlINKq0fqm7/wgHBdLi8GAbem5n18yQQv01peZwBSODzYcOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS/tqikBF6h5B+db9xom5Th9lFEHbEqn8uRbUStB+rVET3sRm5
	E2GcCPdLGQ8+OD3u3nWNT9ud1XSJg+ZMQvjYuYZLeNoz8ItCJOynXo99cu6Pp799tQeUDDPxlDI
	cgk7hwT2BS6Pql8+FKg3kD6R1T3Bt0fmtHr8P
X-Google-Smtp-Source: AGHT+IFaWhge3OYdFsmWMEkqn7s/REeNWzemrf7Dhr2oa1/F3UMiKLY25YFE7s/vhBrTaz8d25Q93vdXaFc5sf6gxNw=
X-Received: by 2002:a2e:a98f:0:b0:2fa:c6f5:95b6 with SMTP id
 38308e7fff4ca-2fac6f59735mr27345921fa.45.1727718929159; Mon, 30 Sep 2024
 10:55:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930152304.472767-1-edumazet@google.com> <20240930152304.472767-3-edumazet@google.com>
 <66fae0f1f12f1_187400294c0@willemb.c.googlers.com.notmuch>
In-Reply-To: <66fae0f1f12f1_187400294c0@willemb.c.googlers.com.notmuch>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 30 Sep 2024 19:55:15 +0200
Message-ID: <CANn89iKdVt7AAh0bcx=zEUz0O+oBneOHvq2EjRbyNifQozEv4A@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net_sched: sch_fq: add the ability to
 offload pacing
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Jeffrey Ji <jeffreyji@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 7:33=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Eric Dumazet wrote:
> > From: Jeffrey Ji <jeffreyji@google.com>
> >
> > Some network devices have the ability to offload EDT (Earliest
> > Departure Time) which is the model used for TCP pacing and FQ packet
> > scheduler.
> >
> > Some of them implement the timing wheel mechanism described in
> > https://saeed.github.io/files/carousel-sigcomm17.pdf
> > with an associated 'timing wheel horizon'.
> >
> > This patchs adds to FQ packet scheduler TCA_FQ_OFFLOAD_HORIZON
> > attribute.
> >
> > Its value is capped by the device max_pacing_offload_horizon,
> > added in the prior patch.
> >
> > It allows FQ to let packets within pacing offload horizon
> > to be delivered to the device, which will handle the needed
> > delay without host involvement.
> >
> > Signed-off-by: Jeffrey Ji <jeffreyji@google.com>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> > @@ -1100,6 +1105,17 @@ static int fq_change(struct Qdisc *sch, struct n=
lattr *opt,
> >               WRITE_ONCE(q->horizon_drop,
> >                          nla_get_u8(tb[TCA_FQ_HORIZON_DROP]));
> >
> > +     if (tb[TCA_FQ_OFFLOAD_HORIZON]) {
> > +             u64 offload_horizon =3D (u64)NSEC_PER_USEC *
> > +                                   nla_get_u32(tb[TCA_FQ_OFFLOAD_HORIZ=
ON]);
> > +
> > +             if (offload_horizon <=3D qdisc_dev(sch)->max_pacing_offlo=
ad_horizon) {
> > +                     WRITE_ONCE(q->offload_horizon, offload_horizon);
>
> Do we expect that that an administrator will ever set the offload
> horizon different from the device horizon?

We want to be able to eventually deal with firmware/hardware bugs,
like lack of backpressure on the timer wheel, which probably has some
kind of capacity limit.

I think it is much better to let the admin choose, eventually
disabling the whole thing, or enabling it for a small horizon like
2500 ns.

>
> It might be useful to have a wildcard value that means "match
> hardware ability"?

 "ip link" will show the device max capability.
Same story for gso_max_size attribute.
We do not automatically set it to dev->tso_max_size

I do not think we have a precedent for a qdisc/link attribute where
the kernel automatically caps the user
choice with the device capability.

>
> Both here and in the device, realistic values will likely always be
> MSEC scale?

msec granularity proved to be not good for TCP stack, we went to us already=
.

Fast path compares in ns unit, storing the value in ns removes
multiplies from it.

