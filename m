Return-Path: <netdev+bounces-142718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 315D39C0163
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 10:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2D91F23A22
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 09:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C1B1E00AF;
	Thu,  7 Nov 2024 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="npA25JMA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7321D90D9
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730972938; cv=none; b=LUt+L5L1GLfScqo/nEZhrmP3WYYzMr9nO3QhGLl56La2i5ezERkFc7RR2KUddcU6M+W9T6cx3ZACxn3/fzv3QNRM+fh/YciNvcU6GrHqedsr5vEhwuuWKoT0SugzXia1lcfS5iomh+Ly0+MIPsHiBRBzEeJRsx8Q3y/oFIkSjhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730972938; c=relaxed/simple;
	bh=weBnE4J6wcgP60wIw1/i3o1vjSP60j6waMBpzGeWrOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLAC73GvPM70TA8+Z1qYEc3gsspioL4IqgBEleNiNn5rPDdyNY4nvP3dndLUtD8lwQmKqiWPz8icXB3qhE96709k1iZB4dInUTkz/HoTvNDjzJOg/n5ZvEMJBGN/8b+x0bb9oSu2IZuc1OgNppLiptehmzAET6E93LyaPaSjR8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=npA25JMA; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cefc36c5d4so980799a12.0
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 01:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730972934; x=1731577734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6n7MnLlibUpCnRHijaGt7uHvwPiqek2DbpMNRXrZsJ8=;
        b=npA25JMAZ9xiAIa4NlD5RPlTj8YII/8+DuXsF8M7J3mo1FLjHSwdZEztA4WriPU+kQ
         LWMTtOXj4ffO+5IynCKc0FiMzRSWMQruV2+HF8DZnmpvv/ObMcu6y5/tL9jS/x6t5Vr9
         tcW51Gw7vMYSCtIfIE68MoInmaq47WZ7LoP0AwDR/1/jD8AxkdMg3SmQnx5+JGYEc9GK
         dXfEck2S8viX/srR5MsTihlXH2hGx3BEEcnW5ompwccBSnuLxgSUbwxY/cGA6UuVzScV
         3+z2gBCUp6oY9lS3prvnwC+o/ah40tQ6B50suT6AnXmWyi0iyUJJbT2MBLNoj+nXYepV
         HAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730972934; x=1731577734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6n7MnLlibUpCnRHijaGt7uHvwPiqek2DbpMNRXrZsJ8=;
        b=ddvaEAtUcuXVxE23GXSVNMR0JSOe/bQhXSNURkd3YQvOgNrRDZ8aHDstIGzrS7en9l
         j2WqGX0H2MvUxZ5R3F6ovkg2iayfXdJhqS3dMpFqX7lgOmxrxlIpLQGxGSTNjarG+q62
         aBPGwbDkv0NgAlKoqTTK1UobTZDI/maZIXRJQ2vEIaATairmQtDZFy6eT80YMQLfaxrW
         LuUGCdiPqIN7clXgcuYaV3aExIkeMUWwZgvBlt19tYl95xQEuWCe37nW7ev0PL7w/I37
         0V5s5rPv7uJEs48PAxuM6YWnSu6WhcBkI4NTyJTw49ADImEShWVATXf/nbuzZTLg1KCu
         Yhqg==
X-Forwarded-Encrypted: i=1; AJvYcCVnv3dAzCFSQkGlchLbp2yR0091CAxuFJRe+Ww35AUyCTECKmGJD6EXfI1v4w72aPFOB5JgzH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlZBRfOd93KDOSI9OPJvXo4Irv4+w6N6NC2NVHi8keRrOlrOlj
	oYEnvyUhht3UdYC+DMOFcCSiguCZ9eE8iAFrBf5is90ChSVuvEulS28+n86jc6ioWPu+C9C5CZQ
	H81m0ILN5+lZAMtmBvAIw4WdOX3bYIGsIqWuN
X-Google-Smtp-Source: AGHT+IFDW8zWR7Layykn8cLqUZLFPS60TnRqTULHn58xcUL/vdFWoHzc45SmZrz/9b3Gu8U4bjVKR20SGkNKSkpZDj0=
X-Received: by 2002:a05:6402:90e:b0:5ce:b1da:3003 with SMTP id
 4fb4d7f45d1cf-5ceb928c6f6mr17060575a12.20.1730972934325; Thu, 07 Nov 2024
 01:48:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105025511.42652-1-kerneljasonxing@gmail.com>
 <92c1d976-7bb6-49ff-9131-edba30623f76@linux.alibaba.com> <CAL+tcoBZaDhBuSKHzGEqgxkzOazX3K-Vo2=mCdOy+iLp4sPAhg@mail.gmail.com>
 <75708260-7eb4-42fe-9d9b-605f8eef488b@linux.alibaba.com> <CAL+tcoBA78svT_vTMOLV-pbwKM1o_SDbjs7AAZLhHOtrd8akBg@mail.gmail.com>
 <CANn89iL5df5_EiDX7JxaFbfmZ9gDo=8ZyLXhbZs+-yp8zVD=GA@mail.gmail.com>
 <CAL+tcoBCqXiQ33XZv61vCes7_XV83DC0HSPy_w6eCn4pzzJeqA@mail.gmail.com>
 <CAL+tcoBPj2aULt5G4qis0D78ke=dt2ws7KBg4Gn+s4FtzjMZfQ@mail.gmail.com> <CANn89iL7uBQQmQcZnbmX-23eyQn5GOecyp2ddcb-oqpJxK6G0w@mail.gmail.com>
In-Reply-To: <CANn89iL7uBQQmQcZnbmX-23eyQn5GOecyp2ddcb-oqpJxK6G0w@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Nov 2024 10:48:42 +0100
Message-ID: <CANn89iLWKae2usuBj9=K7zjuoDqF33n9pUVOcRLh3ehTOGs=NA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: avoid RST in 3-way shakehands due to
 failure in tcp_timewait_state_process
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Philo Lu <lulie@linux.alibaba.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 10:45=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Nov 7, 2024 at 10:30=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Thu, Nov 7, 2024 at 5:00=E2=80=AFPM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> > >
> > > On Thu, Nov 7, 2024 at 4:37=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
> > > >
> > > > On Thu, Nov 7, 2024 at 9:27=E2=80=AFAM Jason Xing <kerneljasonxing@=
gmail.com> wrote:
> > > > >
> > > > > On Thu, Nov 7, 2024 at 4:22=E2=80=AFPM Philo Lu <lulie@linux.alib=
aba.com> wrote:
> > > > > >
> > > > > >
> > > > > >
> > > > > > On 2024/11/7 16:01, Jason Xing wrote:
> > > > > > > On Thu, Nov 7, 2024 at 3:51=E2=80=AFPM Philo Lu <lulie@linux.=
alibaba.com> wrote:
> > > > > > >>
> > > > > > >> Hi Jason,
> > > > > > >>
> > > > > > >> On 2024/11/5 10:55, Jason Xing wrote:
> > > > > > >>> From: Jason Xing <kernelxing@tencent.com>
> > > > > > >>>
> > > > > > >>> We found there are rare chances that some RST packets appea=
r during
> > > > > > >>> the shakehands because the timewait socket cannot accept th=
e SYN and
> > > > > > >>> doesn't return TCP_TW_SYN in tcp_timewait_state_process().
> > > > > > >>>
> > > > > > >>> Here is how things happen in production:
> > > > > > >>> Time        Client(A)        Server(B)
> > > > > > >>> 0s          SYN-->
> > > > > > >>> ...
> > > > > > >>> 132s                         <-- FIN
> > > > > > >>> ...
> > > > > > >>> 169s        FIN-->
> > > > > > >>> 169s                         <-- ACK
> > > > > > >>> 169s        SYN-->
> > > > > > >>> 169s                         <-- ACK
> > > > > > >>> 169s        RST-->
> > > > > > >>> As above picture shows, the two flows have a start time dif=
ference
> > > > > > >>> of 169 seconds. B starts to send FIN so it will finally ent=
er into
> > > > > > >>> TIMEWAIT state. Nearly at the same time A launches a new co=
nnection
> > > > > > >>> that soon is reset by itself due to receiving a ACK.
> > > > > > >>>
> > > > > > >>> There are two key checks in tcp_timewait_state_process() wh=
en timewait
> > > > > > >>> socket in B receives the SYN packet:
> > > > > > >>> 1) after(TCP_SKB_CB(skb)->seq, rcv_nxt)
> > > > > > >>> 2) (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_tsval=
) < 0)
> > > > > > >>>
> > > > > > >>> Regarding the first rule, it fails as expected because in t=
he first
> > > > > > >>> connection the seq of SYN sent from A is 1892994276, then 1=
69s have
> > > > > > >>> passed, the second SYN has 239034613 (caused by overflow of=
 s32).
> > > > > > >>>
> > > > > > >>> Then how about the second rule?
> > > > > > >>> It fails again!
> > > > > > >>> Let's take a look at how the tsval comes out:
> > > > > > >>> __tcp_transmit_skb()
> > > > > > >>>       -> tcp_syn_options()
> > > > > > >>>           -> opts->tsval =3D tcp_skb_timestamp_ts(tp->tcp_u=
sec_ts, skb) + tp->tsoffset;
> > > > > > >>> The timestamp depends on two things, one is skb->skb_mstamp=
_ns, the
> > > > > > >>> other is tp->tsoffset. The latter value is fixed, so we don=
't need
> > > > > > >>> to care about it. If both operations (sending FIN and then =
starting
> > > > > > >>> sending SYN) from A happen in 1ms, then the tsval would be =
the same.
> > > > > > >>> It can be clearly seen in the tcpdump log. Notice that the =
tsval is
> > > > > > >>> with millisecond precision.
> > > > > > >>>
> > > > > > >>> Based on the above analysis, I decided to make a small chan=
ge to
> > > > > > >>> the check in tcp_timewait_state_process() so that the secon=
d flow
> > > > > > >>> would not fail.
> > > > > > >>>
> > > > > > >>
> > > > > > >> I wonder what a bad result the RST causes. As far as I know,=
 the client
> > > > > > >> will not close the connect and return. Instead, it re-sends =
an SYN in
> > > > > > >> TCP_TIMEOUT_MIN(2) jiffies (implemented in
> > > > > > >> tcp_rcv_synsent_state_process). So the second connection cou=
ld still be
> > > > > > >> established successfully, at the cost of a bit more delay. L=
ike:
> > > > > > >>
> > > > > > >>    Time        Client(A)        Server(B)
> > > > > > >>    0s          SYN-->
> > > > > > >>    ...
> > > > > > >>    132s                         <-- FIN
> > > > > > >>    ...
> > > > > > >>    169s        FIN-->
> > > > > > >>    169s                         <-- ACK
> > > > > > >>    169s        SYN-->
> > > > > > >>    169s                         <-- ACK
> > > > > > >>    169s        RST-->
> > > > > > >> ~2jiffies    SYN-->
> > >
> > > It doesn't happen. I dare to say the SYN will not be retransmitted
> > > soon which I can tell from many tcpdump logs I captured.
> >
> > My mind went blank probably because of getting sick. Sorry. Why the
> > tcpdump doesn't show the retransmitted SYN packet is our private
> > kernel missed this following commit:
> >
> > commit 9603d47bad4642118fa19fd1562569663d9235f6
> > Author: SeongJae Park <sjpark@amazon.de>
> > Date:   Sun Feb 2 03:38:26 2020 +0000
> >
> >     tcp: Reduce SYN resend delay if a suspicous ACK is received
> >
> >     When closing a connection, the two acks that required to change clo=
sing
> >     socket's status to FIN_WAIT_2 and then TIME_WAIT could be processed=
 in
> >     reverse order.  This is possible in RSS disabled environments such =
as a
> >     connection inside a host.
>
> Not having a patch from linux-5.6 does not really give a good impression,
> please next time make sure your patches are needed for upstream trees,
> net or net-next.
>
> This also means you can write a packetdrill test to show the benefit
> of this patch,
> and send it as a new selftests ;)
>
> Back to packetdrill, and everyone will be happy.

Well, there is selftest already, not based on packetdrill because
we had no packetdrill support yet in selftests

commit af8c8a450bf4698a8a6a7c68956ea5ccafe4cc88
Author: SeongJae Park <sjpark@amazon.de>
Date:   Sun Feb 2 03:38:27 2020 +0000

    selftests: net: Add FIN_ACK processing order related latency spike test

