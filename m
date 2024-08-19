Return-Path: <netdev+bounces-119636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FDC9566BF
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8B31C219AA
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B68A15CD46;
	Mon, 19 Aug 2024 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MqCCZAMa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356FB15E5DC
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059103; cv=none; b=VCaXjolF34C2cVZfGdrFT0NiKWYq41LaUnRnzOGCb59n3t1fgincxcNMk+UcpQmreu33iZ36oQ41iZWuEW3YOF24RamR2bSIR5dLxmtnwKfZwq1r52jdS4qKKfXP9sUufarRVwDdtCqzQ6cGvD+iqYrwfV4st4MYEmc69aH5cmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059103; c=relaxed/simple;
	bh=FO+RWLSyhGMBNzRRh1YqAI2ZT5Si/N+ZRKxO6IUdI4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h86FYHlPnQnmsko3TCo1Gw5Uwc9co0QQt+Ov6L8+oVPhDTUvNKwphqShicpre5VtdPJH6M3AIrjfAic0JmOqZm72srvRO9LcqXy3eLS5QXNqttlOUHf9pQFvDdIbowoZSn09jTlijDds2KP40J3dAy9J/zqb6rpttiXJ5J8k3CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MqCCZAMa; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8384008482so418705366b.2
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 02:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724059100; x=1724663900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsdVcOm9mMuGAQOHotG5LB9sNgR9FtmNiye/58wbMAI=;
        b=MqCCZAMayABODUj54cfLzj/DOy9iHDCaNF4E45QVLEC9AEL7/Z2iW9tB4NJ++Srmj+
         sm6fjXPQx0a01ggiT694GSgWYysSNcBFZi5NzsiELRsChHzenG01DQA/X0KBPR2/zr8s
         od21bn0pRbNfdT9ozOgfVhq5oj9WNRN5zpqYkXA7XZgKCvo1SvOjVoJlx+frmmiFBhAS
         wxJFfeOkbaMYV6s6QDfsqjmL8gneQhHe0u+1vETVxMSPHLosN2BXszNVFLsks8AXx3vD
         ojoy6SDdJalDr6tXNfl7Jr+KHqG8NbA0r8f1xk7yOp8Bq0sd67tnJ81lJgq4Bs+tco+z
         UZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724059100; x=1724663900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RsdVcOm9mMuGAQOHotG5LB9sNgR9FtmNiye/58wbMAI=;
        b=usGzbGgrjcIyGTQ2KicAGRPf09wPiseGrYjPvgMVsC80vFHhU0M8oXun+1jDOMb+UF
         J3oyOFa7Ib8vKmV3qtP0Y0BeWifqFy+vU+9AHPf8gpqNvfg4t73V/y/hRZMl5loRbKEr
         26aNGr4h8mig/hp8frcMGinqRTe6YOtqpoatNKZmaB8B6NpHG5lj80ghVLCp8WYGry+6
         mYYef12ttOnwFWE79viNffTH1101rvQ1Jls8hI4/G+rcqlueJF7Os8In58BQWP6KShLP
         nHASwTQolpp5AsyRFIFavCmSnF9hJtLwA/pyr5WCT7tFAN0KS5TksteC9OwJCrDwuF7Z
         oWQw==
X-Forwarded-Encrypted: i=1; AJvYcCXeaD/pOuhwfPNxWu8Rq81iGZtz4EyPUZPLj07SpDGlL7LLEB3pxFNTiA9qlsCHfgAdsT/DWxGzqrVRjb2yiP8tUFl4zPlV
X-Gm-Message-State: AOJu0YyUMbB0F4Jjo+ctBCGd0moOfau0Cnth10CjVaSbjfVL6lvwGe3H
	OVBjy5ZPbEdQr0WiNza+CLuz19FRiB/ef7C3RFJ+cJHDMhxm6bYmRVRcFSKra/7uFYknm0exFe9
	OsyDFWBYII6pJK5m6nVnXMrRKDxImVkayU4Cn
X-Google-Smtp-Source: AGHT+IEcWkukxOzUMr7E4zjqPmHdNglj8tBXb+s5pNv7FhbwfYVgINoXa//qVFgYXr5GWrd4sKSbIpV/pisJ+vxQQXs=
X-Received: by 2002:a17:907:3f19:b0:a72:5967:b3a with SMTP id
 a640c23a62f3a-a83a9fefd06mr453969366b.22.1724059099884; Mon, 19 Aug 2024
 02:18:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoDDXT4wBQK0akpg4FR+COfZ7dztz5GcWp6ah68nbvwzTg@mail.gmail.com>
 <20240818184849.56807-1-kuniyu@amazon.com> <CAL+tcoASNGr58b7_vF9_CCungW=ZZubE2xHDxb3QCQraAwsMpw@mail.gmail.com>
 <CAL+tcoDHKkObCn=_O6WE=hwgr4nz3LY-Xhm3P-OQ-eR3Ryqs1Q@mail.gmail.com>
 <CANn89iKxrMH2iGFiT7cef2Dq=Y5XOVgj8f582RpdCdfXgRwDiw@mail.gmail.com> <CAL+tcoAEGcaEdCjxs9_nM7ux_r8tuYhjsMtJZfemHQ+DLVqUYQ@mail.gmail.com>
In-Reply-To: <CAL+tcoAEGcaEdCjxs9_nM7ux_r8tuYhjsMtJZfemHQ+DLVqUYQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Aug 2024 11:18:07 +0200
Message-ID: <CANn89iJmEgeRv5w+YwdOGf0bbS6hNRtYWQ860QGu=KMJqVKZAw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: do not allow to connect with the four-tuple
 symmetry socket
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, 0x7f454c46@gmail.com, davem@davemloft.net, 
	dima@arista.com, dsahern@kernel.org, kernelxing@tencent.com, kuba@kernel.org, 
	ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 11:02=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> Hello Eric,
>
> On Mon, Aug 19, 2024 at 3:30=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Mon, Aug 19, 2024 at 2:27=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > On Mon, Aug 19, 2024 at 7:48=E2=80=AFAM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > Hello Kuniyuki,
> > > >
> > > > On Mon, Aug 19, 2024 at 2:49=E2=80=AFAM Kuniyuki Iwashima <kuniyu@a=
mazon.com> wrote:
> > > > >
> > > > > From: Jason Xing <kerneljasonxing@gmail.com>
> > > > > Date: Sun, 18 Aug 2024 21:50:51 +0800
> > > > > > On Sun, Aug 18, 2024 at 1:16=E2=80=AFPM Jason Xing <kerneljason=
xing@gmail.com> wrote:
> > > > > > >
> > > > > > > On Sun, Aug 18, 2024 at 12:25=E2=80=AFPM Jason Xing <kernelja=
sonxing@gmail.com> wrote:
> > > > > > > >
> > > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > > >
> > > > > > > > Four-tuple symmetry here means the socket has the same remo=
te/local
> > > > > > > > port and ipaddr, like this, 127.0.0.1:8000 -> 127.0.0.1:800=
0.
> > > > > > > > $ ss -nat | grep 8000
> > > > > > > > ESTAB      0      0          127.0.0.1:8000       127.0.0.1=
:8000
> > > > > >
> > > > > > Thanks to the failed tests appearing in patchwork, now I'm awar=
e of
> > > > > > the technical term called "self-connection" in English to descr=
ibe
> > > > > > this case. I will update accordingly the title, body messages,
> > > > > > function name by introducing "self-connection" words like this =
in the
> > > > > > next submission.
> > > > > >
> > > > > > Following this clue, I saw many reports happening in these year=
s, like
> > > > > > [1][2]. Users are often astonished about this phenomenon and lo=
st and
> > > > > > have to find various ways to workaround it. Since, in my opinio=
n, the
> > > > > > self-connection doesn't have any advantage and usefulness,
> > > > >
> > > > > It's useful if you want to test simultaneous connect (SYN_SENT ->=
 SYN_RECV)
> > > > > path as you see in TCP-AO tests.  See RFC 9293 and the (!ack && s=
yn) case
> > > > > in tcp_rcv_synsent_state_process().
> > > > >
> > > > >   https://www.rfc-editor.org/rfc/rfc9293.html#section-3.5-7
> > > >
> > > > Yes, I noticed this one: self-connection is one particular case amo=
ng
> > > > simultaneously open cases. Honestly, it's really strange that clien=
t
> > > > and server uses a single socket.
> > > >
> > > > >
> > > > > So you can't remove self-connect functionality, the recent main u=
ser is
> > > > > syzkaller though.
> > > >
> > > > Ah, thanks for reminding me. It seems that I have to drop this patc=
h
> > > > and there is no good way to resolve the issue in the kernel.
> > > >
> > >
> > > Can we introduce one sysctl knob to control it since we can tell ther=
e
> > > are many user reports/complaints through the internet? Default settin=
g
> > > of the new knob is to allow users to connect to itself like right now=
,
> > > not interfering with many years of habits, like what the test tools
> > > currently use.
> > >
> > > Can I give it a shot?
> >
> > No you can not.
>
> May I ask why? Is it because self-connection adheres to the
> simultaneously open part in RFC 9293?

This will break some user programs, obviously.

I will ask you the opposite : What RFC prevents the current situation ?

>
> I feel this case is very particular, not explained well in the RFC.
> Usually, we don't consider one socket to act as client and server
> unless in debug or test circumstances. As you can see, some people
> have encountered the issue for a long time.

Can you provide links to the issues ? How can a programmer hit this
using standard and documented ways (passive, active flows) ?

>
> >
> > netfilter can probably do this.
>
> Sure, It can do. It can be a little bit helpful, but clumsy. We have
> to set specific rules for each possible listener and then drop those
> SYN packets if they carry the same remote and local port/ip.
>
> Thanks,
> Jason

