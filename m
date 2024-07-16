Return-Path: <netdev+bounces-111700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 519369321C4
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 10:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CBF01C21714
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 08:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81C44D8CE;
	Tue, 16 Jul 2024 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+GY12Hf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A583224
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721118442; cv=none; b=N2yf/UdgvNUBiZsZ9xRkB4lnBpvXkrs1L9MHTVJVgpJ5OG3GIyqVfmVP25+2B6Vdb28lxqvyptVl0+qC1bMkx5Dz7qIkH9qTG93+OnKbKFAEl2kSa7DZT70k65fGgo6oyYt8bTkETwyaZBR+iTiX75q76LBybpl38ZMEyU/bRcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721118442; c=relaxed/simple;
	bh=lBG/3u90fX8K2kuxr9Kwj93d03puCLO+SC8J2kUjkWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WC4+CkYUD8Wg6TsXuvBB+vptorlsbVF2x5i7+TAQQWALPVVDU8JFrtRB6jRq24ilcu3LRN0glT5EOW4uBjrDi29CkgALEmHJNzsR+mKFxYaF6zWeOIUsVE0JS/BI9GxC3r+2t5bSoWRhLkw0AfMB6L7/ahXufwgXTk4T2twKqfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+GY12Hf; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-58f9874aeb4so6623484a12.0
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 01:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721118439; x=1721723239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBG/3u90fX8K2kuxr9Kwj93d03puCLO+SC8J2kUjkWQ=;
        b=O+GY12HfmdLyWMgFW4hBrB64z2FsqEztKIN0Qdh80pA4lxRtEqUnU/Pr4ONRKYOF2m
         r31hjwBragna9sP9NMlL88X261QagpOWlV1hrQK1Te5pvsBhCamGw4qTKnAzPJkRc/5U
         ACSKcZrQLyw+F5k/m7GUOYOQFvx8WYzyUxngg8OErURinkNxlDZWUZBPEIB62cfPxH4D
         OfkzY89N8iCX87jhckLa1yyUJLIvnw9uXcVgfn9EnPbkrW40ZUj8edWVI+Ajsj0jZcYX
         kFSqtLURj0GAWD3wPnNbys8fgLuu7WCN6vkCUuZMEJiFnVfPs4qI3gfl7qtG+z4GozXn
         ahmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721118439; x=1721723239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBG/3u90fX8K2kuxr9Kwj93d03puCLO+SC8J2kUjkWQ=;
        b=VRicSUeXdbrVY1MewtQhSA5Y0rvsxVZlChUAnhznPlhnOGfvmvUzqAUHT+Y3Vsr0j7
         +bVGqnH0Xs87vmm4yoonYvkjG1PcwMUTULM8LRWZAsBvhyesThc5UYO23cThLrTuWaHa
         SUxFp+YNPqcJliRTDd665JizNacuslaoH4JPlMuQhOx9e/ZVF1qpUulMDl3++rZGpnd4
         xhV5NNQfOlVYib8QxKCV3xk4+q+01M6Vh7f1s3eMO5LNHqiKtdMrypw+i2ks8Tng5jzI
         CPnyCZidmmaqJEwsaM3GX1tJWdd4YvvkmkUw8B/DtIg94ma/kx98qhLYLV+c2bkPoVh1
         wT6w==
X-Forwarded-Encrypted: i=1; AJvYcCVhIU32h7sDKnH8JW9TthmZVHaKVatPZriVYKFf3LvxZq2RKpBRhuizxe49H8xyDpfDAzssUsPkZO8r7O3R9smWhig8MWoh
X-Gm-Message-State: AOJu0YxOmDrIwM07mjLEEMl7SRsOuHV6OZJy45GLUzFBaCr4cRTBVSz4
	ogCsoCuJIRktS2FEqtgdthJl8iaVc/2qHF5mlnCUJwNX2SV6m4jXu12yWDZYPXevKsiXl5J/cXx
	4lFpFZaUn+3I+JrE0yq4yHhe5xp7uPg==
X-Google-Smtp-Source: AGHT+IFvEsMIs7qcNsvkjTCw6ehtd4KMq4olX+eSXecS+SY4qu62Vcb+2DKQ4Px4I5QLB3o634Sov+T8zXayY/bqU70=
X-Received: by 2002:a50:8adb:0:b0:57c:f091:f607 with SMTP id
 4fb4d7f45d1cf-59ef00b4020mr823905a12.29.1721118438929; Tue, 16 Jul 2024
 01:27:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715033118.32322-1-kerneljasonxing@gmail.com>
 <CANn89iLXgGT2NL5kg7LQrzCFT_n7GJzb9FExdOD3fRNFEc1z0A@mail.gmail.com>
 <CAL+tcoA38fXgnJtdDz8NBm=F0-=oGp=oEySnWEhNB16dqzG9eQ@mail.gmail.com>
 <CANn89iK7hDCGQsGiX5rD6S29u1u8k5za-SOBaxY59S=C+BgaKA@mail.gmail.com>
 <CAL+tcoAuQFHf_NPNF6ogK8dTZu0V0kts=KyNqfWHJxHWShc3Hw@mail.gmail.com> <CAL+tcoDJGqZh7UcQdemPQ4h_5OEoN3cpvn5F=NEbhMX8TNPNcA@mail.gmail.com>
In-Reply-To: <CAL+tcoDJGqZh7UcQdemPQ4h_5OEoN3cpvn5F=NEbhMX8TNPNcA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 16 Jul 2024 16:26:41 +0800
Message-ID: <CAL+tcoAZxz3OAZvDPYaQd3Gdmb9zpHy4iX_F6AJDLGp70VZX_A@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: introduce rto_max_us sysctl knob
To: Eric Dumazet <edumazet@google.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	dsahern@kernel.org, ncardwell@google.com, corbet@lwn.net, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 4:11=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Tue, Jul 16, 2024 at 3:14=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Tue, Jul 16, 2024 at 2:57=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Mon, Jul 15, 2024 at 11:42=E2=80=AFPM Jason Xing <kerneljasonxing@=
gmail.com> wrote:
> > > >
> > > > Hello Eric,
> > > >
> > > > On Mon, Jul 15, 2024 at 10:40=E2=80=AFPM Eric Dumazet <edumazet@goo=
gle.com> wrote:
> > > > >
> > > > > On Sun, Jul 14, 2024 at 8:31=E2=80=AFPM Jason Xing <kerneljasonxi=
ng@gmail.com> wrote:
> > > > > >
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >
> > > > > > As we all know, the algorithm of rto is exponential backoff as =
RFC
> > > > > > defined long time ago.
> > > > >
> > > > > This is weak sentence. Please provide RFC numbers instead.
> > > >
> > > > RFC 6298. I will update it.
> > > >
> > > > >
> > > > > > After several rounds of repeatedly transmitting
> > > > > > a lost skb, the expiry of rto timer could reach above 1 second =
within
> > > > > > the upper bound (120s).
> > > > >
> > > > > This is confusing. What do you mean exactly ?
> > > >
> > > > I will rewrite this part. What I was trying to say is that waiting
> > > > more than 1 second is not very friendly to some applications,
> > > > especially the expiry time can reach 120 seconds which is too long.
> > >
> > > Says who ? I think this needs IETF approval.
> >
> > Did you get me wrong? I mean this rto_max is the same as rto_min_us,
> > which can be tuned by users.
> >
> > >
> > > >
> > > > >
> > > > > >
> > > > > > Waiting more than one second to retransmit for some latency-sen=
sitive
> > > > > > application is a little bit unacceptable nowadays, so I decided=
 to
> > > > > > introduce a sysctl knob to allow users to tune it. Still, the m=
aximum
> > > > > > value is 120 seconds.
> > > > >
> > > > > I do not think this sysctl needs usec resolution.
> > > >
> > > > Are you suggesting using jiffies is enough? But I have two reasons:
> > > > 1) Keep the consistency with rto_min_us
> > > > 2) If rto_min_us can be set to a very small value, why not rto_max?
> > >
> > > rto_max is usually 3 order of magnitude higher than rto_min
> > >
> > > For HZ=3D100, using jiffies for rto_min would not allow rto_min < 10 =
ms.
> > > Some of us use 5 msec rto_min.
> > >
> > > jiffies is plain enough for rto_max.
> >
> > I got it. Thanks.
> >
> > >
> > >
> > > >
> > > > What do you think?
> > >
> > > I think you missed many many details really.
> > >
> > > Look at all TCP_RTO_MAX instances in net/ipv4/tcp_timer.c and ask
> > > yourself how many things
> > > will break if we allow a sysctl value with 1 second for rto_max.
> >
> > I'm not modifying the TCP_RTO_MAX value which is tooooo complicated.
> > Instead, I'm trying to control the maximum expiry time in the
> > ICSK_TIME_RETRANS timer. So it's only involved in three cases:
> > 1) syn retrans
> > 2) synack retrans
> > 3) data retrans
>
> To be clearer, my initial goal is to accelerate the speed of
> retransmitting data. There is a simpler way to implement it only in
> tcp_retransmit_timer().

Sorry to keep replying to this thread so frequently. I have to admit
tuning rto max is much more complicated than rto min. I think simply
reducing the time of retrans is not a feasible way.

