Return-Path: <netdev+bounces-111689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F09F693210C
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 09:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715881F22CAB
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 07:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BA522309;
	Tue, 16 Jul 2024 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tv+DX5xE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24C2101CA
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 07:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721114112; cv=none; b=oElnVWytAQdqPcwrDvogL7X4OS23QGfdFxYuJTAyb94VdrPaXNm4AlJ0QNZB232Js10Iq1af2RSv5A4E05W7UnUdic3nWwUnncXNL+H9OwFLvrP5hOtb1awhTjfkzEJlKmr3yOsUYSwGwb6J1irzQASlvt71KJnmMfEhhnvU3vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721114112; c=relaxed/simple;
	bh=ahW7EzcmZwslEiOBlqfnNZ57dNnTSeqDC5XpmJB3xEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UkIyNbZx1er0/I5t7wY0eddQvqzfL3NXL8g+QFcJGD3zBAw3W8YKh/bkqkmrZz8BW+5CyLvAI77b7PU+fkIXesYdWj0OggkGrhyMDEHq3I4Ybo0BLuiQdguWGh7EBzd9we6ch5j3wMlkbd3pIOdD9105NDRouk4Z+xuKMkn5+oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tv+DX5xE; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57cf8880f95so6541402a12.3
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 00:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721114108; x=1721718908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahW7EzcmZwslEiOBlqfnNZ57dNnTSeqDC5XpmJB3xEo=;
        b=Tv+DX5xEdifiBhclArxsMKFWwh+w+HAtm7AmBxvcH8rVOG0+6aQOUG/J4iNm5KiRsE
         Xoyspa2IRqTaJB9qLKZIwTu22gso3N/XgHpfoh83MuNa+WdonAotHU4mhRUKPCZ5WKD4
         Hmi+LAGpPvjUWoWmCjB1hUeubUR7Zkq6eLKGmdcRlQPbVmouN4JLq2YsZYAH2QW6jAZf
         Mlx4ofm90i51XbpMmG/KGiKMSDnB/f1F7/yWlcDcb2Y0S+AweESCD6R6WKg9e094RSfc
         t9t7tQioz7hHLN8Gcjjb/YFsCOIZ+lJRoepGhhlOOcajp90nlgP26Tmo2wzadLPwu7YJ
         YeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721114108; x=1721718908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahW7EzcmZwslEiOBlqfnNZ57dNnTSeqDC5XpmJB3xEo=;
        b=cikIMfcVm3CuFt5vaTKZ2NJR6DoTLV8mYzPSXAHB2wyucdMUtnQfxoByyoGrxquBBa
         G9bLCxN16+j5+ncOGc+iXyD388Kt0SG9QzABZVbDZpc2DebkpWj9bd7iT82+R3fR80dZ
         6Gb68ssWpGgxzGtQQ2M46M8hZhe354JEcG4MN7mlAjsHRqE8ZuAoLYAR0DzkWDHcqeL0
         LWwA6a9/DXKW2kbWUVUTE4yBxiu7F8nU/B+W2aB5LSQkDSZxOLWtqiRI8zNqmU2/zCC6
         8kH+x3rsUTzH1pHtFBE9xlxDt2SN4L2fNEiUlno3NMQw1sWfViLbcME2tufjTNnhbj+c
         NJ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjq5RgbVWL5o2wRhds2xSuHSnEuRf4kBxToTPAWvbE4NmP8jCe0lbo3iy0IUSwlDW26GDM9+A/zXAgxob3qU+6KMh09WPB
X-Gm-Message-State: AOJu0Yxpb9U3+LzxNs7/tW3rGVhzO9ry8PVBFeWw8BqVo8sgHM9ezmYQ
	dplK4ZsRV/sHB9u7Z7ZtdqE2UsNfjH7i1YJub7HuKeVR5OlQJJDeQAsu/yNtIfKMJvn1HN3w/4l
	tdc6qqURsEzQ7K9RDjn4OlTRPYCA=
X-Google-Smtp-Source: AGHT+IEs94Fq00UYMg5Sicrz9SjuKUPAKAWeXPjab4RT2ycFW7toSuS7B8hYNkIbGhpyAPnAQa8FJQmDvu6wMPQ2NaQ=
X-Received: by 2002:a05:6402:35ca:b0:57c:db99:a131 with SMTP id
 4fb4d7f45d1cf-59eefebec56mr853800a12.29.1721114107949; Tue, 16 Jul 2024
 00:15:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715033118.32322-1-kerneljasonxing@gmail.com>
 <CANn89iLXgGT2NL5kg7LQrzCFT_n7GJzb9FExdOD3fRNFEc1z0A@mail.gmail.com>
 <CAL+tcoA38fXgnJtdDz8NBm=F0-=oGp=oEySnWEhNB16dqzG9eQ@mail.gmail.com> <CANn89iK7hDCGQsGiX5rD6S29u1u8k5za-SOBaxY59S=C+BgaKA@mail.gmail.com>
In-Reply-To: <CANn89iK7hDCGQsGiX5rD6S29u1u8k5za-SOBaxY59S=C+BgaKA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 16 Jul 2024 15:14:30 +0800
Message-ID: <CAL+tcoAuQFHf_NPNF6ogK8dTZu0V0kts=KyNqfWHJxHWShc3Hw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: introduce rto_max_us sysctl knob
To: Eric Dumazet <edumazet@google.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	dsahern@kernel.org, ncardwell@google.com, corbet@lwn.net, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 2:57=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Jul 15, 2024 at 11:42=E2=80=AFPM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >
> > Hello Eric,
> >
> > On Mon, Jul 15, 2024 at 10:40=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Sun, Jul 14, 2024 at 8:31=E2=80=AFPM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > As we all know, the algorithm of rto is exponential backoff as RFC
> > > > defined long time ago.
> > >
> > > This is weak sentence. Please provide RFC numbers instead.
> >
> > RFC 6298. I will update it.
> >
> > >
> > > > After several rounds of repeatedly transmitting
> > > > a lost skb, the expiry of rto timer could reach above 1 second with=
in
> > > > the upper bound (120s).
> > >
> > > This is confusing. What do you mean exactly ?
> >
> > I will rewrite this part. What I was trying to say is that waiting
> > more than 1 second is not very friendly to some applications,
> > especially the expiry time can reach 120 seconds which is too long.
>
> Says who ? I think this needs IETF approval.

Did you get me wrong? I mean this rto_max is the same as rto_min_us,
which can be tuned by users.

>
> >
> > >
> > > >
> > > > Waiting more than one second to retransmit for some latency-sensiti=
ve
> > > > application is a little bit unacceptable nowadays, so I decided to
> > > > introduce a sysctl knob to allow users to tune it. Still, the maxim=
um
> > > > value is 120 seconds.
> > >
> > > I do not think this sysctl needs usec resolution.
> >
> > Are you suggesting using jiffies is enough? But I have two reasons:
> > 1) Keep the consistency with rto_min_us
> > 2) If rto_min_us can be set to a very small value, why not rto_max?
>
> rto_max is usually 3 order of magnitude higher than rto_min
>
> For HZ=3D100, using jiffies for rto_min would not allow rto_min < 10 ms.
> Some of us use 5 msec rto_min.
>
> jiffies is plain enough for rto_max.

I got it. Thanks.

>
>
> >
> > What do you think?
>
> I think you missed many many details really.
>
> Look at all TCP_RTO_MAX instances in net/ipv4/tcp_timer.c and ask
> yourself how many things
> will break if we allow a sysctl value with 1 second for rto_max.

I'm not modifying the TCP_RTO_MAX value which is tooooo complicated.
Instead, I'm trying to control the maximum expiry time in the
ICSK_TIME_RETRANS timer. So it's only involved in three cases:
1) syn retrans
2) synack retrans
3) data retrans

Thanks,
Jason

