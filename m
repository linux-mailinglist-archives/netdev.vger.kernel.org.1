Return-Path: <netdev+bounces-142723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BA79C01A3
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 10:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3AC8283BAD
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 09:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E659C1DFE2C;
	Thu,  7 Nov 2024 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9hwvFh2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437D5194A70
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730973469; cv=none; b=KnnivkPb4+zPxr4OVM8XM4l3lgShtC6MT5cJeIi94uZ8uZcZ32/wwZ9X+bh+FP3v5Z5QcnrfKxPwyNmaIR5HLCjxHHtq+F732RE6X8xKqtdIB9WBy48QSNvsODKu7hpqEKEeCxZgn4QMq3AE9i9atnh/aYH4MKTF4aXib2dQeD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730973469; c=relaxed/simple;
	bh=MJU1EyCof9Q6U90P4+nrNn4gGCjvXirqP0hLCZl3LEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cGjey+TtswHZ2M9k186Z+azhzV9+gy5aRQytrWbexnG1JKuFPVl2f3YAOIWEDGsi/Av49vxNVczD1uY9ORMMCOquC7bVzTbpNP3nmxGu+rCcrBGVrGmmYUFGsWttQXWS/80YBVcwMQLZRYmnhux9rVeWJcdSl28FDpKEX1mGhaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9hwvFh2; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a4e30bffe3so2926015ab.3
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 01:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730973467; x=1731578267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swi250FUFP4UE+CjUFc6+pT3SaKHLSGJpryP19KHcDg=;
        b=O9hwvFh25ULU2eRzgG77clLQBYM+JZ7p4HOAlwn5Ej5XqRrJ189NCWAACMETAH0OvV
         0YzDTLN6pVohK5zCZXZMHyVdVxpVJ91dr6rRXVeOpKfZ8X0BXEaawilN077H5Y1hr+OU
         jcdomd1HkYAzXxnpKJ0hUogBrOszglcBbi14h08J+BsstOqvklVIJiU+ti6LlOedwsFl
         KfKrHCtHubDpyX6diIH77nrlIZOrPRuH08Mg5o6DaCnjjwbDS/8zBcfuhQRz7fGx1btq
         TFpUb/mlUkkYLRKcGyOWdEC4fTCXq0/or9XAMFfA45mBmg2aUm7I9z/ZeXB1euVzI7qI
         c67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730973467; x=1731578267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swi250FUFP4UE+CjUFc6+pT3SaKHLSGJpryP19KHcDg=;
        b=v2aZE8hPr93WJBDwemD5hmGKUuiqPB9dw7zj/ci8GhS/e2N1cTi8i0bKHQ+NIIi5NM
         U1jUshHQgAzz4PATC+TKcqT0EAcp/+QA1+iVGRcf7VJc5wMZRjE+tKrIA5KAlLAArHZ/
         OJG8RMuKJ9ZGCUqqB+eqgQebZqD7Iet3XrWnpGJhUP1GTCYn4b8/1+SkTeORIMXzfcN2
         bg46E70Dbkl7/fFqi9bKld3xYfyPuZRJSF+gunkKNdGjC7pZ+3PiEyGez25yyeQmk2tW
         vYMH9B6iV/r20x/7F1o5Jo7R5jBtD0N9jebrejVr/tKj4CIXCc4zy9RtK3n1vgS5qDJk
         dE2A==
X-Forwarded-Encrypted: i=1; AJvYcCWF4e4whLCJNdWBWzaUkBKD53BTrSPl7UAtbxxN0FmQq1D1vBmXGzQ49DtDIn2MyR4OnX5VYdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQy6MfvF8F5Cqj8e0kzf8yigtpvPvmqTU1SAQ/AwsaBj+lCdzj
	2TxAiq/+VUh7Rd2SZISYzFefJVxU7vVda04Ka5zNnwpqbEXmsqLIZQYaO2290NbDIQoFscdU129
	G0wMH3pLBfrksFCd7EiIsycwmoQI=
X-Google-Smtp-Source: AGHT+IE/Zbhf/dnKsTYCWz9k5hD1W5siJH9qEY7FXg339nOOb/ygHabUd8ELi88mgpWaqetjSndYfPAAf6f1IDOuUhA=
X-Received: by 2002:a05:6e02:1746:b0:3a6:c724:2ec with SMTP id
 e9e14a558f8ab-3a6c724041emr182644065ab.2.1730973467238; Thu, 07 Nov 2024
 01:57:47 -0800 (PST)
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
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 7 Nov 2024 17:57:10 +0800
Message-ID: <CAL+tcoCzbLKV7xVRvQsYFAoZp1OrXQ1+-xn0rCgHfcTttT=-Uw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: avoid RST in 3-way shakehands due to
 failure in tcp_timewait_state_process
To: Eric Dumazet <edumazet@google.com>
Cc: Philo Lu <lulie@linux.alibaba.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 5:45=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
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

Sorry about this. Normally, I found an issue on those older kernels
and then I will test it on the net-next tree. The issue this patch
tried to fix can be reproduced, as we all see. But today regarding the
topic about re-sending an SYN quickly, I didn't conduct the test, only
analyzing the code :( Sorry for the noise.

>
> This also means you can write a packetdrill test to show the benefit
> of this patch,
> and send it as a new selftests ;)
>
> Back to packetdrill, and everyone will be happy.

Thanks for reminding me. It's really necessary for me to get started
to learn how to write various packetdrill tests.

