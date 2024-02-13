Return-Path: <netdev+bounces-71454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD36853515
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 16:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8E81F21BBD
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 15:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0B25EE76;
	Tue, 13 Feb 2024 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kItGWadT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADFD5EE6F
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839357; cv=none; b=OQ/tuTMQhccgI7pdLp7uK11WHj8T83z0kVGXXCJ3T3FL6NyF4WzZNusQIDs8QKbGpd4lgloXKY7Cwi68C8lzNuZsRHVHhkoCz43Tnn/Ys4jtBR1woOsEqO5EbFV+BmtUqKun1gcBkOsCdTgQ0Ilv7zoYRuSFOQDavDm7GgBDkyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839357; c=relaxed/simple;
	bh=DBcIe8xV1TuzUY3YQD5No1dAV87CjCuOmjMB/G5/8Z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+cctyV3lMJ/vf/618izj/b29ZgumbJK4/fWnc8GKvsznKgpUmFuRD0BF3X412ZIlFJe+pRDmTfLQUYolQe2QqAab7K74TTnuViFRYtZy62GIwKZEK3vJ8DZ09Vm7JwD0wneHdZAphCoHVaVWse9G7lI7hPwZ1l5RPKIcRfx1Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kItGWadT; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-561f0f116ecso11126a12.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 07:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707839354; x=1708444154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btl9AilTHs6i0wOMaqaeeQt6wBIRS4ri8unbNibUxxI=;
        b=kItGWadTTGXP0Xn3br7hEOKSdApUL1TJaGVsZLWlMvqZOz3aDOjlAszfVcHflCR3Ry
         PX3CXOjgxF6TTRfxfMGkhrIivKg/9sgYjk5jR5S1dQ1bgjj8/ATY05ewan+cG/jWqiDF
         iPMslJ8uS9ZDYnToQmeaS9TNelqOtn0o/eQoVyvS8lLvGE2k43n9bCF0Qkn3jvRvKiID
         kNfejEWp64kjynCFeSs8dRf9n3qSDnRTlQMOB+D/NPe8sTQ85Nr4fGL1m6OU+qW4dtOl
         4AZL+/5katfyRTacCeL7E0DT0CQ2uvXlSHVKLqtoa3Ul5tG/LhLw+1MDT5LTZ/kJa1gs
         zZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707839354; x=1708444154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btl9AilTHs6i0wOMaqaeeQt6wBIRS4ri8unbNibUxxI=;
        b=Jw6Cb5ljACBT1Kp7pv2V3h7gnQBQyA8buktOysNpppfNFGIgl9/QeL/x+atKLL2pse
         zoo9RDClcKTPXaRK7NLeZAaj07ZqBhs40qkVHMCyf/HVrHPrsFGKG9vkL3YmIG4TgqYz
         0Td2o5Ucthf1T6/9hXGq13nCOHyAeD+xveozhUIeCMLhTT97CxbE8IHrvN2/S3a2gGtg
         eIEFjy0bKTsn/kCLOGtfH+YBWmyTh5bfPQW+8iV+kIIONfl6uvYyPM3q5z5iY515GXuw
         8heURyhFHbgL2PRdpQu+MDB19TblZEHBBEQstocxVnTeUzrzEzHTxZqQhqr5eeXj22PH
         mKwA==
X-Forwarded-Encrypted: i=1; AJvYcCUIdQ1JhEksvbqGyLcha2VsM77UAlFs23bzSqa4SnmonBDslzi+L0b1cU8zB/3fd9Xgx8UlkVsbRQldI5zsxIOK9Q8uyWsB
X-Gm-Message-State: AOJu0YxkBXMG0wJN8b5o0eNoHGEfF9wn4fpAz+Br3D/5n/FA49U9eTAK
	YU6srzMpTeujnBg3u2pL7Vs04dcsCyq+wOyU0uAFb9dy17+u3DMZRjBoQMxiLc4W0UjrcPf0tCc
	KIjpxdX5kJTpgS1L+rUWsKDoSZ0xwp134qHoj
X-Google-Smtp-Source: AGHT+IFtPWqlxfv8kQukkyro94nEzUKIQRWiIhsat1P80UHejThOk10R45cuLnJjpk1JyEp7KgHhd/zgVDlklcZJN9Q=
X-Received: by 2002:a50:8ad6:0:b0:55f:9918:dadd with SMTP id
 k22-20020a508ad6000000b0055f9918daddmr1251edk.2.1707839354237; Tue, 13 Feb
 2024 07:49:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209221233.3150253-1-jmaloy@redhat.com> <8d77d8a4e6a37e80aa46cd8df98de84714c384a5.camel@redhat.com>
 <CANn89iJW=nEzVjqxzPht20dUnfqxWGXMO2_EpKUV4JHawBRxfw@mail.gmail.com>
 <eaee3c892545e072095e7b296ddde598f1e966d9.camel@redhat.com>
 <CANn89iL=npDL0S+w-F-iE2kmQ2rnNSA7K9ic9s-4ByLkvHPHYg@mail.gmail.com> <20072ba530b34729589a3d527c420a766b49e205.camel@redhat.com>
In-Reply-To: <20072ba530b34729589a3d527c420a766b49e205.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 13 Feb 2024 16:49:01 +0100
Message-ID: <CANn89iL2FvTVYv6ym58=4L-K-kSan6R4PEv488ztyX4HsNquug@mail.gmail.com>
Subject: Re: [PATCH v3] tcp: add support for SO_PEEK_OFF
To: Paolo Abeni <pabeni@redhat.com>
Cc: kuba@kernel.org, passt-dev@passt.top, sbrivio@redhat.com, 
	lvivier@redhat.com, dgibson@redhat.com, jmaloy@redhat.com, 
	netdev@vger.kernel.org, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 4:28=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Tue, 2024-02-13 at 14:34 +0100, Eric Dumazet wrote:
> > On Tue, Feb 13, 2024 at 2:02=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > >
> > > On Tue, 2024-02-13 at 13:24 +0100, Eric Dumazet wrote:
> > > > On Tue, Feb 13, 2024 at 11:49=E2=80=AFAM Paolo Abeni <pabeni@redhat=
.com> wrote:
> > > >
> > > > > > @@ -2508,7 +2508,10 @@ static int tcp_recvmsg_locked(struct soc=
k *sk, struct msghdr *msg, size_t len,
> > > > > >               WRITE_ONCE(*seq, *seq + used);
> > > > > >               copied +=3D used;
> > > > > >               len -=3D used;
> > > > > > -
> > > > > > +             if (flags & MSG_PEEK)
> > > > > > +                     sk_peek_offset_fwd(sk, used);
> > > > > > +             else
> > > > > > +                     sk_peek_offset_bwd(sk, used);
> > > >
> > > > Yet another cache miss in TCP fast path...
> > > >
> > > > We need to move sk_peek_off in a better location before we accept t=
his patch.
> > > >
> > > > I always thought MSK_PEEK was very inefficient, I am surprised we
> > > > allow arbitrary loops in recvmsg().
> > >
> > > Let me double check I read the above correctly: are you concerned by
> > > the 'skb_queue_walk(&sk->sk_receive_queue, skb) {' loop that could
> > > touch a lot of skbs/cachelines before reaching the relevant skb?
> > >
> > > The end goal here is allowing an user-space application to read
> > > incrementally/sequentially the received data while leaving them in
> > > receive buffer.
> > >
> > > I don't see a better option than MSG_PEEK, am I missing something?
> >
> >
> > This sk_peek_offset protocol, needing  sk_peek_offset_bwd() in the non
> > MSG_PEEK case is very strange IMO.
> >
> > Ideally, we should read/write over sk_peek_offset only when MSG_PEEK
> > is used by the caller.
> >
> > That would only touch non fast paths.
> >
> > Since the API is mono-threaded anyway, the caller should not rely on
> > the fact that normal recvmsg() call
> > would 'consume' sk_peek_offset.
>
> Storing in sk_peek_seq the tcp next sequence number to be peeked should
> avoid changes in the non MSG_PEEK cases.
>
> AFAICS that would need a new get_peek_off() sock_op and a bit somewhere
> (in sk_flags?) to discriminate when sk_peek_seq is actually set. Would
> that be acceptable?

We could have a parallel SO_PEEK_OFFSET option, reusing the same socket fie=
ld.

The new semantic would be : Supported by TCP (so far), and tcp
recvmsg() only reads/writes this field when MSG_PEEK is used.
Applications would have to clear the values themselves.

BTW I see the man pages say SO_PEEK_OFF is "is currently supported
only for unix(7) sockets"

