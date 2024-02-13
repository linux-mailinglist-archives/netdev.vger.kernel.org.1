Return-Path: <netdev+bounces-71376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36900853207
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 14:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6441D1C20CDD
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB4E55E71;
	Tue, 13 Feb 2024 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ItIRxTTR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CC356440
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831306; cv=none; b=V++cImHSr9xKyz1k89A7t+6dKZre74rzKKCtMM3K73coR8w96WSkjs5PIGfhTR0acxl21K4FoYWZbeJQyXn+Y2CwrzKTHuhKDoRnnNQC46lMylP8Lr4aTgXxUduZ80VlI9bPwOWp4GCDRO51Y2JsVoknBQw0wzrWXLGGWS4Y5dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831306; c=relaxed/simple;
	bh=zFdw8A8gFCi5AzLDuZucN6CY+Sj5qTh979MWdi+hVsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZN72HJJrKwg1sbM5VPB35FUFtiaDX0LbiAnx+g8FGbl68F8QiwFMMWFSt2RZ6ZQJNAsbypL85xZpH1aCgOOfFombK5gBSOJP84EdyoymPQmkRgm65KvbgFEKIK/ikDj6l/RNtsO8L7Ejm+HH+6Va/sduXRElE/5jqC42VsAm3qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ItIRxTTR; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56101dee221so8549a12.1
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 05:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707831303; x=1708436103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9D7WJAJOW3grtGcQd2/F+Hkudt5TMk0CwS0QtDNqp+M=;
        b=ItIRxTTRGZwSVlK1k44b6Ty32DONHeXAWgCzfQKLP3a0G5mxHWzdasQaLSdrEO7/jq
         kktVui9E8jEx4Snw3nq/RO2hYyyGghYykJ676FW2mZnMjpy3LucERJWAgGMXeTw2yJ+0
         c1ZWB4zRcY1EDB9e+WNskntpjcTb1SbC2RdkLjkgaEfXd9n8cKwiOzOXB4fYcL71IWVK
         MiO/aPN1PeiCgLS/R2acknBgJ6jMJxbMta00q4G8tYK+Njvb8iQSgq820B8x9x7MiUfN
         bRTs3olDR09yq1lJAoQorKs8fho0rok1OXFEFQBThcEkTvAT3QPAoj/bF/8sBoxvhojE
         Zexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707831303; x=1708436103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9D7WJAJOW3grtGcQd2/F+Hkudt5TMk0CwS0QtDNqp+M=;
        b=cBTuZr/yIdsUyQCxQl/Nsh1cA0AcpLETpwFE4dzPTgdT1E4fARMCSMdN8QrLoiBJwV
         pyHHUU8CVj2jDagpcswJXOLL/Yp+jAhkGoF5ueVXqoJwmo/x2DiUl/lh4nJdVhg0fMl1
         S5e6joFHjU0e3R8NZPYM9iXNoVBJPeyPUmk6ZxjkWbObG/byBxXnWonCvNC5GKe4g4BI
         av9Fy92daW4lx699OyP0hgstloRp4axaVtPl7a50ujg1ZDODNmd6VR7/emoblxpMrAnC
         oNW+ZKqV/KqrwakXTzc96lAdZPMTuyb1HGqfnRRZqmZ1omkbDhHDE367HlvVB/JSglNm
         uJKg==
X-Forwarded-Encrypted: i=1; AJvYcCW4rizFrp8rvRI807B5mUDKWmCj5kOS+qELKf1fIJAtxDrC1AIl+pM1Y45OQcmk71USj5xp6bp5WbNB6Qmh1IuyD8krL5O2
X-Gm-Message-State: AOJu0YznikfKZWFQr9GRmYDVoiTsmLSBO3J4U1Bfe3kCPiSpxLPgzS42
	D5ts4FAFHWClSaqRBUDt+Oj0hcvyRHHcfxVpO5RFxZCMn4mjHJaePrHkcrtl3ic4O3K5IU/AWHA
	xSemAgoYTCxNw8Pk9VE8a0RJNcHxj67LaeNVr8NnzEh0BMcaxnB9S
X-Google-Smtp-Source: AGHT+IGC2WRBAQU3oaeio96VlSPAdkneNkZS5J51Sayp3w6GfyKzi2VO2lFGpSXSMiSAt/kt22ZOyoMyrNGRpX9BuAE=
X-Received: by 2002:a50:9b5e:0:b0:55f:8851:d03b with SMTP id
 a30-20020a509b5e000000b0055f8851d03bmr115571edj.5.1707831302889; Tue, 13 Feb
 2024 05:35:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209221233.3150253-1-jmaloy@redhat.com> <8d77d8a4e6a37e80aa46cd8df98de84714c384a5.camel@redhat.com>
 <CANn89iJW=nEzVjqxzPht20dUnfqxWGXMO2_EpKUV4JHawBRxfw@mail.gmail.com> <eaee3c892545e072095e7b296ddde598f1e966d9.camel@redhat.com>
In-Reply-To: <eaee3c892545e072095e7b296ddde598f1e966d9.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 13 Feb 2024 14:34:48 +0100
Message-ID: <CANn89iL=npDL0S+w-F-iE2kmQ2rnNSA7K9ic9s-4ByLkvHPHYg@mail.gmail.com>
Subject: Re: [PATCH v3] tcp: add support for SO_PEEK_OFF
To: Paolo Abeni <pabeni@redhat.com>
Cc: kuba@kernel.org, passt-dev@passt.top, sbrivio@redhat.com, 
	lvivier@redhat.com, dgibson@redhat.com, jmaloy@redhat.com, 
	netdev@vger.kernel.org, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 2:02=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Tue, 2024-02-13 at 13:24 +0100, Eric Dumazet wrote:
> > On Tue, Feb 13, 2024 at 11:49=E2=80=AFAM Paolo Abeni <pabeni@redhat.com=
> wrote:
> >
> > > > @@ -2508,7 +2508,10 @@ static int tcp_recvmsg_locked(struct sock *s=
k, struct msghdr *msg, size_t len,
> > > >               WRITE_ONCE(*seq, *seq + used);
> > > >               copied +=3D used;
> > > >               len -=3D used;
> > > > -
> > > > +             if (flags & MSG_PEEK)
> > > > +                     sk_peek_offset_fwd(sk, used);
> > > > +             else
> > > > +                     sk_peek_offset_bwd(sk, used);
> >
> > Yet another cache miss in TCP fast path...
> >
> > We need to move sk_peek_off in a better location before we accept this =
patch.
> >
> > I always thought MSK_PEEK was very inefficient, I am surprised we
> > allow arbitrary loops in recvmsg().
>
> Let me double check I read the above correctly: are you concerned by
> the 'skb_queue_walk(&sk->sk_receive_queue, skb) {' loop that could
> touch a lot of skbs/cachelines before reaching the relevant skb?
>
> The end goal here is allowing an user-space application to read
> incrementally/sequentially the received data while leaving them in
> receive buffer.
>
> I don't see a better option than MSG_PEEK, am I missing something?


This sk_peek_offset protocol, needing  sk_peek_offset_bwd() in the non
MSG_PEEK case is very strange IMO.

Ideally, we should read/write over sk_peek_offset only when MSG_PEEK
is used by the caller.

That would only touch non fast paths.

Since the API is mono-threaded anyway, the caller should not rely on
the fact that normal recvmsg() call
would 'consume' sk_peek_offset.

