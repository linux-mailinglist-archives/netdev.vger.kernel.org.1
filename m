Return-Path: <netdev+bounces-112624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB6A93A38C
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 17:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945431F2340F
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB8C15445E;
	Tue, 23 Jul 2024 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEShzoyq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEF613B599
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721747582; cv=none; b=KxSnfNws/hZCS7S6yGPoF2e29xM5OoVYkGYhE+ikL6PybHzij4L1PqMu+4fLygt5yLPsBp+mfHcMSzPFgg6riBvUeBqz6YdcHWENdXqSiAEO94sJW8jfKB67QnXuBWkbjqXVZUIuhOJJcJMzbN7eTwHAc4x0dVFMUc0QVa42pt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721747582; c=relaxed/simple;
	bh=RdtvgtuaOcYYGAxfTnhR5KN8q6+ALW9Q+gM1K/h3/Ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFHQi1o48t+Pis1TTDDaXKeyrFvDP5JjaCGOH+Vx7p8nwjZSmP39v3p9q6aTdROWVLocrrw/OqjB3Vw1GljfLQtwf82pQ5u5d9hDW88SLsh/+L95fWhp+GD0xFnO7uzTu578F6l/TrN/HI8abouGkrHZ431DnJ+Pwjkv0nkhsyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEShzoyq; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso5400373a12.1
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 08:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721747579; x=1722352379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeqs40XzXZX1rBnaQ1wtDslXayStwzHEtW/ZSlLOfOU=;
        b=fEShzoyqDLrdW+NSDw7kLIMERL9aGaYALpXrRZTkeZfbACV+eRIIoWkhqg9jC1DtUf
         BuzuSPBPRuOJsv3Gn/lHE2Au5MhnZlVtdt1vC/K1hi5GmTC1W98DhV6yq74aSoHieTUq
         bMzw9bB95BoSrwiZaBiE073U3N6R31O/ib0LYfeU3SLE1P0tY8FrzLNFmsqLlF9zgMLQ
         JXPIsFqXkCgeTyxqyeKqYFKFLUuI2mjdvh8w405Tgi5L0RF2LDJ/rO8LoZdQDLT7qwdY
         6m0QH4e1Qe9CYkSjnEtYlfVrbXmP+LntMzexQWCmucjpFJCOvjR1//iI8XWBfFP2Gf1K
         n68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721747579; x=1722352379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yeqs40XzXZX1rBnaQ1wtDslXayStwzHEtW/ZSlLOfOU=;
        b=HF50/Q4gsTAvgFWM1VV6H8y8lpFwyXtg8Cn2ryek0cTiqkGq9epQ6d5+PNuvnTNPZr
         B25UFsQZ/7fx5rXBfB4ytLYoBFnXi+EFQZuf8/SjZBH7bToYwTDWvnjOoJgBnbAh3Q8N
         wAI4w4BWSu9tGRXhdEGBurbUyW/3ZAXjTH402yW0AxgTT5bBtCR/lOhz+WYiDwkr9/CK
         QmFfnKbyv3VM4pBJc6NdbLGL+dMdS21h+AGp+QeHFGE/w0YpB1iNPhu+uPNBuw2b+3MW
         08p4edGOQIYnibX1b2Pc0HDc5Gk3YdMwkkyoF4fnkaSQ9AMMQsmKuddVECC+TBQBB4um
         hWPg==
X-Forwarded-Encrypted: i=1; AJvYcCXXSuHVLge3+RKw6nezj0n+sAItBMS03zITzzGTuNkFSvIxB82B8bV1Zvmxr6tdvw1e4XYFcFGU2bKvZ/Sg+ztn/JyGJPLC
X-Gm-Message-State: AOJu0Yw9wXJD20P4Oe8PKM7rwFbsaAIPCRM/5RpHYpBCWhrUh2lYfFAO
	pSssIG2tsZJthsQqczs6MgCtw0miK26TQeSkSF/bj+mlOzwT+N71IKehmo3/qYEGj01G3kGS9ew
	yhG11+0J9LtLDCduJp/mXzx1ysCkjQsN6
X-Google-Smtp-Source: AGHT+IEObiUrZLFp3MPTIXqfaisgS3ZRwhxPOkM6OdmagNimrcJzKRihl0RpFBqvNXqmYU+is4OYslwQ5+h2WBoFFPs=
X-Received: by 2002:a05:6402:5ca:b0:5a1:a7cb:8f86 with SMTP id
 4fb4d7f45d1cf-5a93eebf214mr2631196a12.0.1721747579253; Tue, 23 Jul 2024
 08:12:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723135742.35102-1-kerneljasonxing@gmail.com>
 <CANn89i+dYsvrVwWCRX=B1ZyL3nZUjnNtaQ5rfizDOV5XhHV2dQ@mail.gmail.com> <CAL+tcoDZ2VDCd00ydv-RzMudq=d+jVukiDLgs7RpsJwvGqBp1Q@mail.gmail.com>
In-Reply-To: <CAL+tcoDZ2VDCd00ydv-RzMudq=d+jVukiDLgs7RpsJwvGqBp1Q@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 23 Jul 2024 23:12:20 +0800
Message-ID: <CAL+tcoCC2g1iHA__vr8bbUX-kba2bBi2NbQNZnxOAMTJOQQAWg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net: add an entry for CONFIG_NET_RX_BUSY_POLL
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 11:09=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> On Tue, Jul 23, 2024 at 10:57=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Tue, Jul 23, 2024 at 3:57=E2=80=AFPM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > When I was doing performance test on unix_poll(), I found out that
> > > accessing sk->sk_ll_usec when calling sock_poll()->sk_can_busy_loop()
> > > occupies too much time, which causes around 16% degradation. So I
> > > decided to turn off this config, which cannot be done apparently
> > > before this patch.
> >
> > Too many CONFIG_ options, distros will enable it anyway.
> >
> > In my builds, offset of sk_ll_usec is 0xe8.
> >
> > Are you using some debug options or an old tree ?

I forgot to say: I'm running the latest kernel which I pulled around
two hours ago. Whatever kind of configs with/without debug options I
use, I can still reproduce it.

> >
> > I can not understand how a 16% degradation can occur, reading a field
> > in a cache line which contains read mostly fields for af_unix socket.
> >
> > I think you need to provide more details / analysis, and perhaps come
> > to a different conclusion.
>
> Thanks for your comments.
>
> I'm also confused about the result. The design of the cache line is
> correct from my perspective because they are all read mostly fields as
> you said.
>
> I was doing some tests by using libmicro[1] and found this line '41.30
> =E2=94=82      test  %r14d,%r14d' by using perf. So I realised that there=
 is
> something strange here. Then I disable that config, the result turns
> out to be better than before. One of my colleagues can prove it.
>
> In this patch, I described a story about why I would like to let
> people disable/enable it, but investigating this part may be another
> different thing, I think. I will keep trying.
>
> [1]: https://github.com/redhat-performance/libMicro.git
> running 'https://github.com/redhat-performance/libMicro.git' to see the r=
esults
>
> >
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > > More data not much related if you're interested:
> > >   5.82 =E2=94=82      mov   0x18(%r13),%rdx
> > >   0.03 =E2=94=82      mov   %rsi,%r12
> > >   1.76 =E2=94=82      mov   %rdi,%rbx
> > >        =E2=94=82    sk_can_busy_loop():
> > >   0.50 =E2=94=82      mov   0x104(%rdx),%r14d
> > >  41.30 =E2=94=82      test  %r14d,%r14d
> > > Note: I run 'perf record -e  L1-dcache-load-misses' to diagnose
> > > ---
> > >  net/Kconfig | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/Kconfig b/net/Kconfig
> > > index d27d0deac0bf..1f1b793984fe 100644
> > > --- a/net/Kconfig
> > > +++ b/net/Kconfig
> > > @@ -335,8 +335,10 @@ config CGROUP_NET_CLASSID
> > >           being used in cls_cgroup and for netfilter matching.
> > >
> > >  config NET_RX_BUSY_POLL
> > > -       bool
> > > +       bool "Low latency busy poll timeout"
> > >         default y if !PREEMPT_RT || (PREEMPT_RT && !NETCONSOLE)
> > > +       help
> > > +         Approximate time in us to spin waiting for packets on the d=
evice queue.
> >
> > Wrong comment. It is a y/n choice, no 'usec' at this stage.
>
> Oh, I see.
>
> Thanks,
> Jason
>
> >
> > >
> > >  config BQL
> > >         bool
> > > --
> > > 2.37.3
> > >

