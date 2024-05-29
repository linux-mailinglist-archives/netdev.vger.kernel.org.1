Return-Path: <netdev+bounces-98937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BD18D32DF
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 11:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223AC1C20A12
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 09:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789C516A374;
	Wed, 29 May 2024 09:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cd9F7j6g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A533E16A375
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 09:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716974613; cv=none; b=eSQ6DlFGzWpcgflH6OIBfa14JZTL/eH/SAEykaUjUE13Pry0xdeKpb5nCvM1B+29jQj/3VpyG+eqZKIHagBh1FzqcygbUoprzH21kdtGnkcd/2wLXzH6YZATvBJkwEm1chboeefvPa22FZusID+ae0HCMaZzolhmYCAN+PXNrzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716974613; c=relaxed/simple;
	bh=+OjztFofO5lpsTxNnbdTHN4ik5f+PrhWCZ2jAqiIrH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=niB9lltLkl64bH47vZZTUPLi2Z+gNQieymt7jxtS3NcsBvUIeQTVezWzU3JnVAtEZ5wcDHnu+vIHp/hWTEm7x1I/kxLtcGzcOaeW96bvSR9YoLikxva8LDVNlUKjPppuzumkc4Vpc1oKxnLrxwR6YWJWCIlCeXCejtk8QaNVKWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cd9F7j6g; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-579ce5fbeb6so8107a12.1
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 02:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716974610; x=1717579410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7GBURu0PL71WAnakYdPhkzVbeWXGKNeLlr4SUIfQ+8=;
        b=Cd9F7j6gCB4Eu34Qe4eeL8VmcuudWcoq5cvDTtOTk75ePP2HZpAJZK6TkjTT4UbfY5
         S4xPyutAxegkFW+Mo4p8+015Z8qXreEKR6ruvfeQCAT3V7Sel9/x+V29iDl3vOjpR0BF
         QlUhc+Egqw1CXKQAC5lfvEMMeklkwpmVnaYkBDFmzjocFOyGEXwmirvbY99xnZTZ+bOm
         2xs6ko9NXbefG3FU5Qb2fUyGTrwGBuOnFyDuJ21uzpoM91zlF71bETyagxmev3bqe/+y
         AWml4Q26MSQB04P3g/ArX7kVKwh0PbTbSDT3e7CazLlvrctIpg/cxECyW1X4I3wlbcSI
         krbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716974610; x=1717579410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7GBURu0PL71WAnakYdPhkzVbeWXGKNeLlr4SUIfQ+8=;
        b=T4EGUdv9WxTYDo16At2Vbi6/nPc2ZEZ7aHaF5LaBFvDdiX3DPLkXGDmLRVzF0bTz7O
         xWt7sDrVkPJaTNwkN7Hhfo6YdSHtC2gqSrBBgDJa/YgxaFglEzlNJoKdSozo5u8+R08+
         epD9/VC5xZiYDQ9jP/fMuemnj8XKHkO0o1JM4aT5V83cwJAtwprEwYKCFxjAkXLGr9gj
         GL55zrJUHpUr7rk/v9Vqg2XQSL66zjCVE+Y95cM1AqsQzUaFHlI+hEMy30ZHzWnmTao1
         Ij6qyiD2YKrREFwfzLCXjX2kgUsgEiTECzbYBSznPk1swhezYJoaGWxiuJAibhk2JxiQ
         ZJLg==
X-Forwarded-Encrypted: i=1; AJvYcCUCM7wBnZMyTwLlfBXJZpic9FUolEz/PdJ3xFJPQf4xbuY/YC3ePlokm9SQt70KvqiioTznqMxOuWjtJGUp2dY0dUJRMmGy
X-Gm-Message-State: AOJu0YwzubcAboryURUzoIgdhrxCpj9WFq/eG1Iao67fUDKEjqYRuHf+
	/8pmCjkVvfckIfTGmGdid3nbEFEDTe07fCu2ubNYjexdOMZm2iYPx5v2orAWbHIK3zljfU3TPi5
	rJMEtGo06M+Jz3bOGw2dZD6ePeP2F1D123kvbjX4X8fH4LJL/aQ==
X-Google-Smtp-Source: AGHT+IHs0tNrtzRp3O9N1FheaA+NdOs7XVGXdKgPcEb4qc/FdgXoEbxwYptVmxXsLqCAd3JsfmwPhRIaRSgf6Qqnf8o=
X-Received: by 2002:a05:6402:4304:b0:578:4e12:8e55 with SMTP id
 4fb4d7f45d1cf-57a05d20c55mr91523a12.1.1716974609637; Wed, 29 May 2024
 02:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528171320.1332292-1-yyd@google.com> <CAL+tcoCR1Uh1fvVzf5pVyHTv+dHDK1zfbDTtuH_q1CMggUZqkA@mail.gmail.com>
 <CAL+tcoA0hTvOT2cjri-qBEkDCp8ROeyO4fp9jtSFPpY9pLXsgQ@mail.gmail.com>
 <CANn89iKb4nWKvByBwGFveLb5KL_F_Eh_7gPpJ-3fPkfQF7Zf0g@mail.gmail.com> <CAL+tcoCoVTNidWkTm6oUDVPH1cT3292Nqe9WjqTXuQvNYGK+tw@mail.gmail.com>
In-Reply-To: <CAL+tcoCoVTNidWkTm6oUDVPH1cT3292Nqe9WjqTXuQvNYGK+tw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 May 2024 11:23:15 +0200
Message-ID: <CANn89iKhDfP4Nx0xSLsBSTLNuTGds1LGmSnmRC5hhtEbkzUBjQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] tcp: add sysctl_tcp_rto_min_us
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Kevin Yang <yyd@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 10:44=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> Hello Eric,
>
> On Wed, May 29, 2024 at 3:39=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, May 29, 2024 at 9:00=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > On Wed, May 29, 2024 at 2:43=E2=80=AFPM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > Hello Kevin,
> > > >
> > > > On Wed, May 29, 2024 at 1:13=E2=80=AFAM Kevin Yang <yyd@google.com>=
 wrote:
> > > > >
> > > > > Adding a sysctl knob to allow user to specify a default
> > > > > rto_min at socket init time.
> > > >
> > > > I wonder what the advantage of this new sysctl knob is since we hav=
e
> > > > had BPF or something like that to tweak the rto min already?
> > > >
> > > > There are so many places/parameters of the TCP stack that can be
> > > > exposed to the user side and adjusted by new sysctls...
> > > >
> > > > Thanks,
> > > > Jason
> > > >
> > > > >
> > > > > After this patch series, the rto_min will has multiple sources:
> > > > > route option has the highest precedence, followed by the
> > > > > TCP_BPF_RTO_MIN socket option, followed by this new
> > > > > tcp_rto_min_us sysctl.
> > > > >
> > > > > Kevin Yang (2):
> > > > >   tcp: derive delack_max with tcp_rto_min helper
> > > > >   tcp: add sysctl_tcp_rto_min_us
> > > > >
> > > > >  Documentation/networking/ip-sysctl.rst | 13 +++++++++++++
> > > > >  include/net/netns/ipv4.h               |  1 +
> > > > >  net/ipv4/sysctl_net_ipv4.c             |  8 ++++++++
> > > > >  net/ipv4/tcp.c                         |  3 ++-
> > > > >  net/ipv4/tcp_ipv4.c                    |  1 +
> > > > >  net/ipv4/tcp_output.c                  | 11 ++---------
> > > > >  6 files changed, 27 insertions(+), 10 deletions(-)
> > > > >
> > > > > --
> > > > > 2.45.1.288.g0e0cd299f1-goog
> > > > >
> > > > >
> > >
> > > Oh, I think you should have added Paolo as well.
> > >
> > > +Paolo Abeni
> >
> > Many cloud customers do not have any BPF expertise.
> > If they use existing BPF programs (added by a product), they might not
> > have the ability to change it.
> >
> > We tried advising them to use route attributes, after
> > commit bbf80d713fe75cfbecda26e7c03a9a8d22af2f4f ("tcp: derive
> > delack_max from rto_min")
> >
> > Alas, dhcpd was adding its own routes, without the "rto_min 5"
> > attribute, then systemd came...
> > Lots of frustration, lots of wasted time, for something that has been
> > used for more than a decade
> > in Google DC.
> >
> > With a sysctl, we could have saved months of SWE, and helped our
> > customers sooner.
>
> I'm definitely aware of the importance of this kind of sysctl knob.
> Many years ago (around 6 or 7 years ago), we already implemented
> similar things in the private kernel.
>
> For a long time, netdev guys often proposed the question as I did in
> the previous email. I'm not against it, just repeating the same
> question and asking ourselves again: is it really necessary? We still
> have a lot of places to tune/control by introducing new sysctl.
>
> For a long time, there have been plenty of papers studying different
> combinations of different parameters in TCP stack so that they can
> serve one particular case well.
>
> Do we also need to expose remaining possible parameters to the user
> side? Just curious...

You know, counting CLOSE_WAIT can be done with  eBPF program just fine.

I think long-time TCP maintainers like Eric Dumazet, Neal Cardwell,
and Yuchung Cheng know better,
you will have to trust us.

If you do not want to use the sysctl, this is fine, we do not force you.

