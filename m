Return-Path: <netdev+bounces-98938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEF18D3314
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 11:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5606F2866FF
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 09:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5E316E866;
	Wed, 29 May 2024 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/qrG7OP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07AB16A362
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716975059; cv=none; b=GiG9vnUcTc311P1y/eHU7b8bBm1DCvkhGCKupv/VP0d8vUCpPXKiMdc4pHO7My0TXCf2YIZj2qYH1gh+kxvja38sd5xHiDeKV6EOG8KFZW0M/OrPBl+W0GRUJ+mFCWg0oJrq+BU4z8Noz1WTsG0snjmSsxaL8DZNyjptcAEIHPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716975059; c=relaxed/simple;
	bh=+WbZZRGHrssLMeLon91AiFN9cADaNh+3AfqIXKaKheQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzGCgQ9KQOQ6ppbLZDVTH2ulWBM/C9T0QA7UNNV4ug3n3STwHIfCCcidJokIubwhoYT/MloVK199yEZg2V64wNCTR/I7Nfro+2ySeMV0lOqthuUO5Wm84FTeeXh+aBkDPpm6uUSD0LuR36NmGe8ag2nWrlV7PVR5G1ZVTG5ONYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/qrG7OP; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57857e0f464so2389774a12.0
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 02:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716975056; x=1717579856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+D1noNdZo3JqMmM5Zvr1w/cUIMDNnQfUL0atjgPeQwg=;
        b=e/qrG7OPVg0DGRRNnSTsUDTZcj8WhP+k7EzQV685GyRyqwM1S64iKYG2rn9k6FwQTW
         m4GLFNXbrpJQEKSWVc4pt2Oh+SfSV1JQB+RE1OlTCogDciocSjrGjeRaMCblQtx1umdq
         MeN7ahzO7vspOZ+tSS3gGo8LglCkbz/HWCvR9FnjtLX0NhLP4hDMVeNg41fjI27Ef0pB
         fptt9YZbo7J4uaxsGSJflz8MdDWBSOJmqFjWPBh+mzqwb09IUq28cEsUGelnY5P58Ix+
         YHuOMP0wCawDpU7z/2ATM+dvhJTbC0STH/hD2qpKViFqQFAjf4GjHKvy6wK7hIdYC+AI
         yigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716975056; x=1717579856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+D1noNdZo3JqMmM5Zvr1w/cUIMDNnQfUL0atjgPeQwg=;
        b=HvOiQ5QaNLWb+J/ca6z0bUd9oz1AVXzN4UOf7lZT2laPrIXm79PzmfJw3KrXUUgFPQ
         hRJQLJ4pzyRo0M5+sQAacAGiPn6M6ZPR7BFdmv2WigUwTreAvIpInzuqXQJgKAOfNuv6
         q9HUSj+Eawf3s6rPNRLWYDREj4oUBFarxquiAS/MNW2orcAxvpun9lOV+vdOEntjQsVG
         MTFjVLi0aZMzW9r6tqJrz1qIBjhi+XYXelgDM/FhAtG2kjVlbSY5vz6phqJ1+gTnPgfL
         4728BVm4D+E7FwnOhFIWlawlI5Xo2xZUpSg94PshT9FRy6nuh6J1pSrpDUFBrEwXGwEQ
         K2OQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2W28JtJjXtWWLDZuT/dDfCGWRMWsvUiT4c6tANaqk7HHxlWLvC26O6U0dSc06sDnQsU/rUpEFGXtyFv63Lm1btI0q0BUr
X-Gm-Message-State: AOJu0YwuGSsnzLTLzQUYX09yrBLuWBqdUIsOHHbkrKoJx2waYKCPsrCV
	WLdbMJc4vcvr6c+9hctZmKzkvl3oC9cyu6db+0+wezBmGZfmG6RZBvBG0vi3DGIoV18VcHEPLEL
	KCVnpV5PKTBiwRRA9jeCdLQwmWC4=
X-Google-Smtp-Source: AGHT+IG05CK5f0Y7Qyg0/TDK5HVfMFFwOPxnvYSRFfGbdxAMkvH5nC5bcVm7BQubZzCZzkWJ9xgldLweNducjYiiOfo=
X-Received: by 2002:a17:906:7242:b0:a65:b33a:3574 with SMTP id
 a640c23a62f3a-a65b33a38d0mr10786966b.0.1716975055840; Wed, 29 May 2024
 02:30:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528171320.1332292-1-yyd@google.com> <CAL+tcoCR1Uh1fvVzf5pVyHTv+dHDK1zfbDTtuH_q1CMggUZqkA@mail.gmail.com>
 <CAL+tcoA0hTvOT2cjri-qBEkDCp8ROeyO4fp9jtSFPpY9pLXsgQ@mail.gmail.com>
 <CANn89iKb4nWKvByBwGFveLb5KL_F_Eh_7gPpJ-3fPkfQF7Zf0g@mail.gmail.com>
 <CAL+tcoCoVTNidWkTm6oUDVPH1cT3292Nqe9WjqTXuQvNYGK+tw@mail.gmail.com> <CANn89iKhDfP4Nx0xSLsBSTLNuTGds1LGmSnmRC5hhtEbkzUBjQ@mail.gmail.com>
In-Reply-To: <CANn89iKhDfP4Nx0xSLsBSTLNuTGds1LGmSnmRC5hhtEbkzUBjQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 29 May 2024 17:30:17 +0800
Message-ID: <CAL+tcoDLZ-VXOHphM_=qv5qO74rFOLYjch5QrHXgiVAk52c9Vg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] tcp: add sysctl_tcp_rto_min_us
To: Eric Dumazet <edumazet@google.com>
Cc: Kevin Yang <yyd@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 5:23=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, May 29, 2024 at 10:44=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >
> > Hello Eric,
> >
> > On Wed, May 29, 2024 at 3:39=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Wed, May 29, 2024 at 9:00=E2=80=AFAM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > On Wed, May 29, 2024 at 2:43=E2=80=AFPM Jason Xing <kerneljasonxing=
@gmail.com> wrote:
> > > > >
> > > > > Hello Kevin,
> > > > >
> > > > > On Wed, May 29, 2024 at 1:13=E2=80=AFAM Kevin Yang <yyd@google.co=
m> wrote:
> > > > > >
> > > > > > Adding a sysctl knob to allow user to specify a default
> > > > > > rto_min at socket init time.
> > > > >
> > > > > I wonder what the advantage of this new sysctl knob is since we h=
ave
> > > > > had BPF or something like that to tweak the rto min already?
> > > > >
> > > > > There are so many places/parameters of the TCP stack that can be
> > > > > exposed to the user side and adjusted by new sysctls...
> > > > >
> > > > > Thanks,
> > > > > Jason
> > > > >
> > > > > >
> > > > > > After this patch series, the rto_min will has multiple sources:
> > > > > > route option has the highest precedence, followed by the
> > > > > > TCP_BPF_RTO_MIN socket option, followed by this new
> > > > > > tcp_rto_min_us sysctl.
> > > > > >
> > > > > > Kevin Yang (2):
> > > > > >   tcp: derive delack_max with tcp_rto_min helper
> > > > > >   tcp: add sysctl_tcp_rto_min_us
> > > > > >
> > > > > >  Documentation/networking/ip-sysctl.rst | 13 +++++++++++++
> > > > > >  include/net/netns/ipv4.h               |  1 +
> > > > > >  net/ipv4/sysctl_net_ipv4.c             |  8 ++++++++
> > > > > >  net/ipv4/tcp.c                         |  3 ++-
> > > > > >  net/ipv4/tcp_ipv4.c                    |  1 +
> > > > > >  net/ipv4/tcp_output.c                  | 11 ++---------
> > > > > >  6 files changed, 27 insertions(+), 10 deletions(-)
> > > > > >
> > > > > > --
> > > > > > 2.45.1.288.g0e0cd299f1-goog
> > > > > >
> > > > > >
> > > >
> > > > Oh, I think you should have added Paolo as well.
> > > >
> > > > +Paolo Abeni
> > >
> > > Many cloud customers do not have any BPF expertise.
> > > If they use existing BPF programs (added by a product), they might no=
t
> > > have the ability to change it.
> > >
> > > We tried advising them to use route attributes, after
> > > commit bbf80d713fe75cfbecda26e7c03a9a8d22af2f4f ("tcp: derive
> > > delack_max from rto_min")
> > >
> > > Alas, dhcpd was adding its own routes, without the "rto_min 5"
> > > attribute, then systemd came...
> > > Lots of frustration, lots of wasted time, for something that has been
> > > used for more than a decade
> > > in Google DC.
> > >
> > > With a sysctl, we could have saved months of SWE, and helped our
> > > customers sooner.
> >
> > I'm definitely aware of the importance of this kind of sysctl knob.
> > Many years ago (around 6 or 7 years ago), we already implemented
> > similar things in the private kernel.
> >
> > For a long time, netdev guys often proposed the question as I did in
> > the previous email. I'm not against it, just repeating the same
> > question and asking ourselves again: is it really necessary? We still
> > have a lot of places to tune/control by introducing new sysctl.
> >
> > For a long time, there have been plenty of papers studying different
> > combinations of different parameters in TCP stack so that they can
> > serve one particular case well.
> >
> > Do we also need to expose remaining possible parameters to the user
> > side? Just curious...
>
> You know, counting CLOSE_WAIT can be done with  eBPF program just fine.
>
> I think long-time TCP maintainers like Eric Dumazet, Neal Cardwell,
> and Yuchung Cheng know better,
> you will have to trust us.

You get me wrong, Eric. I trust you, of course. I'm just out of
curiosity because I saw some threads facing the same question before.

And, as I said, it has been used in our private kernel for a long
time. So it's useful.

BTW, what do you think of that close-wait patch since you mention it.

Thanks,
Jason

