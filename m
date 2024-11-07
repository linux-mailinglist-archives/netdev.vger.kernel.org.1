Return-Path: <netdev+bounces-142684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14D89C0020
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 09:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F1E283104
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 08:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F28E1D9A41;
	Thu,  7 Nov 2024 08:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ptx/YmxS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DC91D9341
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730968644; cv=none; b=BhDeRSZ7h/CvPfElum623LcGKjwcASZW5L5ZcGsLlHD8JXcqecsmsZFLjsVnM3DD9RcFvnw/fCX36APPERBXBNXf+yT4bJTR6ksktnz3pawJHE5vRPBR1L/sLKcj3IagZxJ2NpekCWsOuSn4AbMCPbK15nk/j/IfQxrfgZKCqvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730968644; c=relaxed/simple;
	bh=RnF/ourWMw3HMuenho6W7g2QXdtvO00A1FgXQ2xIsUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwrJEI276heqpQKfv5ERPsPKDumDUbL9ELsabr4d7ZIAwYUxlDSFz/dgHqKVvTNRMzszNtJ/1XNI/p2BeSIBBQUABMmknvFJnLhuF6PLAK311DXZiFsdPo8vFrzgM7TIO0+Stai23g6PnWg4JohhXcTAingsq0PFjC8FFJoOpCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ptx/YmxS; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ceccffadfdso851320a12.2
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 00:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730968641; x=1731573441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBJ3R1XZ2oB5gTK75zV6aj2IPzKZ42EU+Cm8R5JYXU0=;
        b=Ptx/YmxScdj3JKQ1OxLdaSEQwppiGBrJwV0qbnNT0qVc1lByIv3m8+g3SPVqcrp7VQ
         WBFk4wD1u0RLrvR9zgwJ/1GLkVr4af5FOrOIBoR5/pwsduvG3PdPb5WHFMMHoLu2ebdk
         wl+EiHonBX6fyC0C6nWVNDRdusvgRVEKzYIP7zu03jcc3Zkm7ZQQZdp3FqJVQClqPxQh
         NoWOTbM+JJBeFL+DaHcOO1bxcbed7VwzEXXDbNAWGUWmhxnTksF+HlVOyHuL14GiqFBu
         Sx+Vh7iMW8+P9+CEhIC9GUBIoh+3+TcdeK7E8ryWgaLSJoCtv64fXw7v781VAffI38Q7
         mycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730968641; x=1731573441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FBJ3R1XZ2oB5gTK75zV6aj2IPzKZ42EU+Cm8R5JYXU0=;
        b=ohxHGUau+MSDB5tO6T63RhQPE8F41LFW5ESMMHhii8NU7BEViW3CmExRPMDGvjQcUz
         DKT8Z1F/79GEATpFkau8EodDTGsRGMhZuUqwqg2K6Bf8XeaR+74QWWu0lF9MUc42QO9f
         FNnuZQMV3E+Bzi7Z5ov2bkEcBcUFh+Nju+1VCogRWriOD5NMZC1X5q6ChSuCczKMBOTc
         LgH90owmsDGKrkyHn+mbGBwndvxME399bNaNaQgYtk3eu7gU09fnl+oGk/Mrrd4Q0/X1
         EHjVSKdcW0pZwTBRdTWC4iIrzyD9+7nJ5MTK4LWYC3RY+SqJoXMiLjx6QAeSdfhkd+Nm
         nu+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJvSN1rkWfwXYUjUo0glwsw5UZI6mKi4u5BBdUqWlbC1HFI4+Sguu/IMXZfgU84n0f9+Rme4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoB2JqcDWldLRj7sOGpS1gSwGNYpdvTk/m9KohuRCkpy4mlnze
	8V2q1LMhuMWlcnMcSuWsnoVNS6kO3H1NckaK3upEm7oaS1nZmnr5LhMLOnOqxPoASWj+1+7XYsI
	nPV8bO/i2P62lvwzacA0WDDWNeYYpK9H2CIuz
X-Google-Smtp-Source: AGHT+IG2u2+Ha7Xxj3B+aq2fSvbsyTZBEEnkDRi15T/jpky79hE4RgEM1BZrbr/qt45ko2b1MvRjidS7sTSHqeH0M1w=
X-Received: by 2002:a05:6402:51ca:b0:5ce:d43c:70a8 with SMTP id
 4fb4d7f45d1cf-5cf05a34292mr333061a12.25.1730968640624; Thu, 07 Nov 2024
 00:37:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105025511.42652-1-kerneljasonxing@gmail.com>
 <92c1d976-7bb6-49ff-9131-edba30623f76@linux.alibaba.com> <CAL+tcoBZaDhBuSKHzGEqgxkzOazX3K-Vo2=mCdOy+iLp4sPAhg@mail.gmail.com>
 <75708260-7eb4-42fe-9d9b-605f8eef488b@linux.alibaba.com> <CAL+tcoBA78svT_vTMOLV-pbwKM1o_SDbjs7AAZLhHOtrd8akBg@mail.gmail.com>
In-Reply-To: <CAL+tcoBA78svT_vTMOLV-pbwKM1o_SDbjs7AAZLhHOtrd8akBg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Nov 2024 09:37:09 +0100
Message-ID: <CANn89iL5df5_EiDX7JxaFbfmZ9gDo=8ZyLXhbZs+-yp8zVD=GA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: avoid RST in 3-way shakehands due to
 failure in tcp_timewait_state_process
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Philo Lu <lulie@linux.alibaba.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 9:27=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Thu, Nov 7, 2024 at 4:22=E2=80=AFPM Philo Lu <lulie@linux.alibaba.com>=
 wrote:
> >
> >
> >
> > On 2024/11/7 16:01, Jason Xing wrote:
> > > On Thu, Nov 7, 2024 at 3:51=E2=80=AFPM Philo Lu <lulie@linux.alibaba.=
com> wrote:
> > >>
> > >> Hi Jason,
> > >>
> > >> On 2024/11/5 10:55, Jason Xing wrote:
> > >>> From: Jason Xing <kernelxing@tencent.com>
> > >>>
> > >>> We found there are rare chances that some RST packets appear during
> > >>> the shakehands because the timewait socket cannot accept the SYN an=
d
> > >>> doesn't return TCP_TW_SYN in tcp_timewait_state_process().
> > >>>
> > >>> Here is how things happen in production:
> > >>> Time        Client(A)        Server(B)
> > >>> 0s          SYN-->
> > >>> ...
> > >>> 132s                         <-- FIN
> > >>> ...
> > >>> 169s        FIN-->
> > >>> 169s                         <-- ACK
> > >>> 169s        SYN-->
> > >>> 169s                         <-- ACK
> > >>> 169s        RST-->
> > >>> As above picture shows, the two flows have a start time difference
> > >>> of 169 seconds. B starts to send FIN so it will finally enter into
> > >>> TIMEWAIT state. Nearly at the same time A launches a new connection
> > >>> that soon is reset by itself due to receiving a ACK.
> > >>>
> > >>> There are two key checks in tcp_timewait_state_process() when timew=
ait
> > >>> socket in B receives the SYN packet:
> > >>> 1) after(TCP_SKB_CB(skb)->seq, rcv_nxt)
> > >>> 2) (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_tsval) < 0)
> > >>>
> > >>> Regarding the first rule, it fails as expected because in the first
> > >>> connection the seq of SYN sent from A is 1892994276, then 169s have
> > >>> passed, the second SYN has 239034613 (caused by overflow of s32).
> > >>>
> > >>> Then how about the second rule?
> > >>> It fails again!
> > >>> Let's take a look at how the tsval comes out:
> > >>> __tcp_transmit_skb()
> > >>>       -> tcp_syn_options()
> > >>>           -> opts->tsval =3D tcp_skb_timestamp_ts(tp->tcp_usec_ts, =
skb) + tp->tsoffset;
> > >>> The timestamp depends on two things, one is skb->skb_mstamp_ns, the
> > >>> other is tp->tsoffset. The latter value is fixed, so we don't need
> > >>> to care about it. If both operations (sending FIN and then starting
> > >>> sending SYN) from A happen in 1ms, then the tsval would be the same=
.
> > >>> It can be clearly seen in the tcpdump log. Notice that the tsval is
> > >>> with millisecond precision.
> > >>>
> > >>> Based on the above analysis, I decided to make a small change to
> > >>> the check in tcp_timewait_state_process() so that the second flow
> > >>> would not fail.
> > >>>
> > >>
> > >> I wonder what a bad result the RST causes. As far as I know, the cli=
ent
> > >> will not close the connect and return. Instead, it re-sends an SYN i=
n
> > >> TCP_TIMEOUT_MIN(2) jiffies (implemented in
> > >> tcp_rcv_synsent_state_process). So the second connection could still=
 be
> > >> established successfully, at the cost of a bit more delay. Like:
> > >>
> > >>    Time        Client(A)        Server(B)
> > >>    0s          SYN-->
> > >>    ...
> > >>    132s                         <-- FIN
> > >>    ...
> > >>    169s        FIN-->
> > >>    169s                         <-- ACK
> > >>    169s        SYN-->
> > >>    169s                         <-- ACK
> > >>    169s        RST-->
> > >> ~2jiffies    SYN-->
> > >>                                 <-- SYN,ACK
> > >
> > > That's exactly what I meant here :) Originally I didn't expect the
> > > application to relaunch a connection in this case.
> >
> > s/application/kernel/, right?
>
> No. Perhaps I didn't make myself clear. If the kernel doesn't silently
> drop the SYN and then send back an ACK, the application has to call
> the connect() syscall again.

My suggestion to stop the confusion:

Provide a packetdrill test.

