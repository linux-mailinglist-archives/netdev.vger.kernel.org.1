Return-Path: <netdev+bounces-99180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F3B8D3F34
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 21:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E34C2876DB
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 19:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F48D1C2315;
	Wed, 29 May 2024 19:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BuYH45Hj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C004F15B0EB
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 19:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717012589; cv=none; b=PeCk7DZAbEyoXXc0HcMKqta9xqloYmbgYIDV5L2YtrfAzhMuHj1FvUwAwfqd/3uYyKQ3RiYttInCb6KBd36yDekY5m9LI3+ezu+jU55Wq8opQU/uN2YQkxo+oNtEZvJ824KPR6O8foT8I7fjRcTRxbcf06e0S0ADcEqfCP1ayew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717012589; c=relaxed/simple;
	bh=v/X1YH1+JJ+/inmNsfdoPo3WJXiBa+BH5PEacKfLScU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AYFPj0Rm6LGWqbQMt4efdbkWbkQOgKoWGIGNHOr/fdL0ndalr5+jjbEbaHad0u399REpJqkGL6DkyS3Dn0PQ3yQymC5DnObKscMnX22bxkl8OfL/7Ru/ObtER0B0BwB/MQpg5Y78ewGvDJoa/Hp0L6jZEvvej8tZ8yUAkkKE2gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BuYH45Hj; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ab11ecdbaso176260e87.3
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 12:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717012586; x=1717617386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8msXAyJo51zNUxwWZni2kGx5pGiaVinKn9EURRKyG7E=;
        b=BuYH45HjDZ44DLUj9g9IWyPHIdKLN9n319N4vhGQNOVSKd9S8XVoMRVE585zVc66S/
         j7XyiWbtXl0Fzzj0z/lUFLJMzbC11wLtOxjt1g36N+7G2bOaQEem76Dw5oxwlDwGx2a2
         uofBoJdlIWB42DoXa2nJhS5NHZr4GaaRW1voSiAa69ia+B6HOiwzOOvGL9ldh+kEJlnJ
         Zr83XWksqAgQgd0CRDKucavt7ZCD/JLfkcdvuVzEs5sqEP4hZ+ezz/mu1uwSSrvMeWtE
         9KPzgPCHGFMyU8vXxwoTIHGFPkZr3TPcYqXXes4EE6Tdoo+9VS7PZcfkeo2wjMV2cQdd
         ch7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717012586; x=1717617386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8msXAyJo51zNUxwWZni2kGx5pGiaVinKn9EURRKyG7E=;
        b=t6zMm9Uu2UjDjQkIrBGzbmpnhKIuKkScJBlPSNzJ7n/HXzSAFnnbXRdQJQfNtwQGz8
         hQdxrfzVayoRfQemCj1Fy5LQ7CQlD0XhYipdQoV24Qw2G68DFd6ZefB+O4mKA4mpREKZ
         2c4r2Tw0W9dH6uuXgbS8LTjCzX+WCVu/kLRuPcxBpx4GhMJtTpinAVK9Kf662bxKhMkz
         Ko2B/jT0Pk5Njv3RF0vniQII554eiy1D+efFRKdACZVKkzrg6Z3UYA0Vt30WhfmZplyY
         qng5j4G9MA3Pex3DgL3BKXV8IdiPgVR6oRhTFoTiWoTdR01gn+YQu/vhqUXxaP1B2TpH
         DSSg==
X-Forwarded-Encrypted: i=1; AJvYcCXawjpdGf2TTg49fWkvdj7EEtEbitvopB6Tmmr5p+EbJMJVmfHyjT00wbEZUeapxThqizk2ODpMLM0Bl20ccqrJLWLvA53B
X-Gm-Message-State: AOJu0YxeMdAqzCCpqjDKJaJOvCYpaf6L4UfjodJ+8od/PKQgNw6t3ELP
	D72oG3ZWXUroxdROw/eQIWyXDDirR7Vo2iTEGfEiu2gGFVgydXsyaF6rzToFodghUm2iU5Yd3lv
	cOTaVneJyBpE41bGHyNhd7fUedTcJiEoAKX13
X-Google-Smtp-Source: AGHT+IGj+nHwuSADJBi729Usw2X3RNmBU9MG+ajFcKaw6LKX1aWEE1NHFDIT9WF4pOG+xhHGEGrYRGT+GDj4FRDLmWM=
X-Received: by 2002:a05:6512:358f:b0:51d:1002:520d with SMTP id
 2adb3069b0e04-52b7d4905b8mr102462e87.64.1717012585790; Wed, 29 May 2024
 12:56:25 -0700 (PDT)
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
From: Kevin Yang <yyd@google.com>
Date: Wed, 29 May 2024 15:56:14 -0400
Message-ID: <CAPREpbY2FbmT77B3s7XtO4UQmuJROtmTShv69Hxb6O7FeAJqcw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] tcp: add sysctl_tcp_rto_min_us
To: Eric Dumazet <edumazet@google.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jason,

I guess I don't have anymore to add than what Eric and Tony mentioned.

The purpose of this sysctl is to resolve problems in a more straightforward
way than other existing methods.

Thanks
kevin

On Wed, May 29, 2024 at 5:23=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
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
>
> If you do not want to use the sysctl, this is fine, we do not force you.

