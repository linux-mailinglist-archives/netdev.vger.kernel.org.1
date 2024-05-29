Return-Path: <netdev+bounces-98925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BF88D322D
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15161C232FB
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 08:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C614169370;
	Wed, 29 May 2024 08:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDGT5vEK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEA57317C
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 08:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972271; cv=none; b=C4NvkwdqT2S5wyl/MrcbZ5XY8n4lNVYp+U+RrkvyUCprRO78gX/zBzzJbNBjlHwa82SMvfsCkFFycBW/KhJm06i9jNu3VJ2ncfneUM29Q6uJ5zwBgPgMBs6I9qLfDoRvmsK3KAmOaRTxe+qZI76kwq83FJ6GjwUic31vT2OdWt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972271; c=relaxed/simple;
	bh=jK9dw8wBnrvF0Y4BMiNf+6nazyCul2QkD9ufjllYxEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=al2aNUQe1fErLUCcesQO5xaBaocTi5M+Hhw+QOj65aQliKXvXwHABvxqTX7kZmxSsQX8aUeG/HFEbP0pe4SII/SSdAxse+N32X5nGaoGFdE7BRBm+j078pomKPAAbfdeJPddrYcyF+Q8A15ka4XU3XfA8mBhNOguMLszYk1Z5+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDGT5vEK; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57857e0f465so2270148a12.1
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 01:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716972268; x=1717577068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwhGK/dKKh3bJit0AJ42oTgWIz3Op6s4zx3lBYuYj/0=;
        b=RDGT5vEKGdBkOAMJxe0M7qTpY6wxWJFtws2nqlgf4HnwngJyYHd5yQudWrhvnoSwxh
         TLa7yve3d6aoX4brnynxW/MjZBDIBUiPCS/qXK7rBUDYyUvqrJIWfadqPTCV2PS90PKt
         bZt22OmdD5jKrVjOO0eR5dB9D/8jB46M3S/3CyVg3+osgXj0W44BFv+5XexNdS46zQwh
         wqgdfAUp6EdxYmQvMeHyPeAGBqUI52+Jv80BKL9f9gkEbUnLHWtN92t/AB49wHJmCR+7
         vkiUlMspDGArwdpnnw5YEhxNerF3YjS/OUfjHJkNBghYfw8wYHPHA6EyJbc1MTNmYodt
         bAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716972268; x=1717577068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwhGK/dKKh3bJit0AJ42oTgWIz3Op6s4zx3lBYuYj/0=;
        b=IdF1tFpRvH/QzDKos5ng9RWsRzfT1i+KUARsm+n76MDv7cWo11VBDKasDU4Oxbmgvv
         RarPQeynq51cx19JpUGgZdNhrOafrYlQWAQl2fF1wkrgofFF9V2cryQW+hamByFPeCLd
         hqAV5uGo0IiSnI9qAbv3sdg1lXmf0xhfHOZdujl+fCyYFFwQv3azjiSaI6oYHMRZAf2i
         BpANYAHmb4629f4D7J6N2iZTOqaH1iekfoCX/lcqo8mXceON5IJOuTY89BALiIaFykFj
         HwAfEMAOVAAjEWoBUWxG2gxAhNWnbW1nH5mpSJrF2sZSOi5ijWyeS8S+VTCQGIvdM6CI
         7B2A==
X-Forwarded-Encrypted: i=1; AJvYcCUT6rnD6AZniLebENzdDfS5NIOXMgMYwrVVPwwpmX23NCZiOXpV/XmodYJY0FRX5P3DaeF49OSkzyQOojkfIwuuqjEHYs1B
X-Gm-Message-State: AOJu0YxByVDiyCH5s4034+XA9/RxYifTt5b+9uYDwi6fEgFdWKUBKb34
	gGNfD5DQNTlzmlVAM/CXNVgzEgo+KaajI0RTsFBjIaoGbRRiOg3aGTw7gwLIovQPsrioNLKFm7L
	XmqrZGz2RvWbIJwWAKOE3yreuOlPX4Q==
X-Google-Smtp-Source: AGHT+IHvUxZBn6UCO84dMVTjdeZzLWUsNTaiRCHtVcn6zlzzOaMFBZfPmlAJ42vf0yc0Hd3Y21DVxLRTW585Sbs8Q8A=
X-Received: by 2002:a17:906:f9c9:b0:a5a:f16:32b1 with SMTP id
 a640c23a62f3a-a62641cfb1dmr1005649266b.31.1716972267877; Wed, 29 May 2024
 01:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528171320.1332292-1-yyd@google.com> <CAL+tcoCR1Uh1fvVzf5pVyHTv+dHDK1zfbDTtuH_q1CMggUZqkA@mail.gmail.com>
 <CAL+tcoA0hTvOT2cjri-qBEkDCp8ROeyO4fp9jtSFPpY9pLXsgQ@mail.gmail.com> <CANn89iKb4nWKvByBwGFveLb5KL_F_Eh_7gPpJ-3fPkfQF7Zf0g@mail.gmail.com>
In-Reply-To: <CANn89iKb4nWKvByBwGFveLb5KL_F_Eh_7gPpJ-3fPkfQF7Zf0g@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 29 May 2024 16:43:51 +0800
Message-ID: <CAL+tcoCoVTNidWkTm6oUDVPH1cT3292Nqe9WjqTXuQvNYGK+tw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] tcp: add sysctl_tcp_rto_min_us
To: Eric Dumazet <edumazet@google.com>
Cc: Kevin Yang <yyd@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eric,

On Wed, May 29, 2024 at 3:39=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, May 29, 2024 at 9:00=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Wed, May 29, 2024 at 2:43=E2=80=AFPM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > Hello Kevin,
> > >
> > > On Wed, May 29, 2024 at 1:13=E2=80=AFAM Kevin Yang <yyd@google.com> w=
rote:
> > > >
> > > > Adding a sysctl knob to allow user to specify a default
> > > > rto_min at socket init time.
> > >
> > > I wonder what the advantage of this new sysctl knob is since we have
> > > had BPF or something like that to tweak the rto min already?
> > >
> > > There are so many places/parameters of the TCP stack that can be
> > > exposed to the user side and adjusted by new sysctls...
> > >
> > > Thanks,
> > > Jason
> > >
> > > >
> > > > After this patch series, the rto_min will has multiple sources:
> > > > route option has the highest precedence, followed by the
> > > > TCP_BPF_RTO_MIN socket option, followed by this new
> > > > tcp_rto_min_us sysctl.
> > > >
> > > > Kevin Yang (2):
> > > >   tcp: derive delack_max with tcp_rto_min helper
> > > >   tcp: add sysctl_tcp_rto_min_us
> > > >
> > > >  Documentation/networking/ip-sysctl.rst | 13 +++++++++++++
> > > >  include/net/netns/ipv4.h               |  1 +
> > > >  net/ipv4/sysctl_net_ipv4.c             |  8 ++++++++
> > > >  net/ipv4/tcp.c                         |  3 ++-
> > > >  net/ipv4/tcp_ipv4.c                    |  1 +
> > > >  net/ipv4/tcp_output.c                  | 11 ++---------
> > > >  6 files changed, 27 insertions(+), 10 deletions(-)
> > > >
> > > > --
> > > > 2.45.1.288.g0e0cd299f1-goog
> > > >
> > > >
> >
> > Oh, I think you should have added Paolo as well.
> >
> > +Paolo Abeni
>
> Many cloud customers do not have any BPF expertise.
> If they use existing BPF programs (added by a product), they might not
> have the ability to change it.
>
> We tried advising them to use route attributes, after
> commit bbf80d713fe75cfbecda26e7c03a9a8d22af2f4f ("tcp: derive
> delack_max from rto_min")
>
> Alas, dhcpd was adding its own routes, without the "rto_min 5"
> attribute, then systemd came...
> Lots of frustration, lots of wasted time, for something that has been
> used for more than a decade
> in Google DC.
>
> With a sysctl, we could have saved months of SWE, and helped our
> customers sooner.

I'm definitely aware of the importance of this kind of sysctl knob.
Many years ago (around 6 or 7 years ago), we already implemented
similar things in the private kernel.

For a long time, netdev guys often proposed the question as I did in
the previous email. I'm not against it, just repeating the same
question and asking ourselves again: is it really necessary? We still
have a lot of places to tune/control by introducing new sysctl.

For a long time, there have been plenty of papers studying different
combinations of different parameters in TCP stack so that they can
serve one particular case well.

Do we also need to expose remaining possible parameters to the user
side? Just curious...

Thanks,
Jason

