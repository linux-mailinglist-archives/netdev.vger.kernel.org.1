Return-Path: <netdev+bounces-142709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA379C00FA
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 10:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C1A01C2111A
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 09:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953DB1D8E0D;
	Thu,  7 Nov 2024 09:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izSpZhZz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8386126C01
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730971146; cv=none; b=clu46RqaYlnCfG3CpTVFSwwS0TYI449ogVXhCKqxHE0JAxOWqG03nR5uj9cimXBQrHVJMkl30Jztkd+BLSqxaPg2yjy0MQqTxXEtXY0lLm4iYoXR8GfGV0E3U381h/BuEUPE1segFLa92UqwpUBoqQvkX5XBMib3uUB1WdjenME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730971146; c=relaxed/simple;
	bh=Z4/E9iVYnajtg9nQINEbj0Ls4pzHNG7G1C6NP8twmzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ts9y6ykBi98Hp2snFGU+AUuWY3iAt0bpuLbxb+p0IXsjDBHYzSL0ONxZnz4m5yUyPKB2oo23skrUuwkdlUzwfBqX5m3l5ZzZjVSP5MfNw1Z3sEvmHvWZ17H0pRavZMy0cIuSHf6fhYNgAHG6ZsUL9I2Sm3sinhEB2FgfgWC1P9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izSpZhZz; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a3a5cd2a3bso2990175ab.3
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 01:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730971144; x=1731575944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+xcizzEsPvBD/KJDZodZqeAIICmhjB2WqiSSuN6E0M=;
        b=izSpZhZz5VXEuovgwHl2sabWIerlQrvoqRAbQ3MNqzLLTiecZLooowul7f6/2U7ae5
         j45/QAOHpsoSiyyJolSgGezPfboO1MtyuJRZMGau1yg8KrjPpIFrMV2FT6ZFJes/RwSg
         EKqZZ7ciLJhP2PzS94vvMjNlArSBfx1d+OngtX0i7T4hzhXlw3Se1yRXAC+kacZVb1ch
         Yy6fAwfKuitcnGMS0TMQ5n538hgMzvf+ghT0foqC19oPLsQKTrVBXL+D1Xq0CPB/AmUv
         J9Kt2g2rb0du81JpTkolfsKeI9A8qsjjnY+CB8GbPnonBxg5/Beex46odLMvQ9BYPZxu
         x6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730971144; x=1731575944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+xcizzEsPvBD/KJDZodZqeAIICmhjB2WqiSSuN6E0M=;
        b=uO1R2e5DjR9J+YGJAaLNm5c9bz4oREjEIm9aWdZ1j7cx2YijtX3lYSIi4UN3iGHZGO
         3XMe1QP2teGt7rFB9xGtB6b0chjXtKXXFsXdjdxwUZycKAvZfaT5dwWbF3G4iXR8FNA6
         2jThY5Zm3/TQqLqLSaWEjwlOaFmYJPv6c8A6PfKmjwofStlnZiUanKUtHz6Aui8ZB5J/
         WW6QcC3pTwxGj+pUT3zqol61rqxzExr4vM8OsmtQDdVXZ859P9gEKXHBBWGXWIlEHene
         VU0SSlH7G0CuyVC8DXdiCAm8enQ+8dP1eXPWiH2JGY5CkXvjE4vnl7l7FnGVtl6Nz9PV
         i+/w==
X-Forwarded-Encrypted: i=1; AJvYcCUCmyr7Rnryp49GOFN2giVxb0nw9NCnY8qTNBuIhMHdr+yHI8hWI+hZ0iqMbP5761OplY5nGPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdfvD0kSjMy6QSKvAw1ciaqdyi4HCk7bBOp+gfZlBFQWopaCaC
	ZXKJhMmN3fyiLMqUJqvcUM42Gmr2sfjVtDaZTBc0jKa97sVVyFaVqK0oifFg+RxdeVA2n4ynrGO
	9D5SfSQMoWqg2GOvGe9MOuE09WFw=
X-Google-Smtp-Source: AGHT+IH/BzCo3NpZfXpFfL0eWldWT8ADOIiYdB0RSYNOdnq7RV4G2d7qjK/QJOFhdEOOcioVYN4SZyXfe9ZKZfSV8P0=
X-Received: by 2002:a92:db02:0:b0:3a6:aade:e328 with SMTP id
 e9e14a558f8ab-3a6aadee571mr228490965ab.4.1730971143893; Thu, 07 Nov 2024
 01:19:03 -0800 (PST)
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
 <CAL+tcoBCqXiQ33XZv61vCes7_XV83DC0HSPy_w6eCn4pzzJeqA@mail.gmail.com> <CANn89iLEPSBnvVe+qPZ1SeQ86JYh3CoR_LioDGwdPNumqyYWLw@mail.gmail.com>
In-Reply-To: <CANn89iLEPSBnvVe+qPZ1SeQ86JYh3CoR_LioDGwdPNumqyYWLw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 7 Nov 2024 17:18:27 +0800
Message-ID: <CAL+tcoBnm+0U2w1mFet7D4f91aMejhkSALT4yO5LJXWE5Yqubg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: avoid RST in 3-way shakehands due to
 failure in tcp_timewait_state_process
To: Eric Dumazet <edumazet@google.com>
Cc: Philo Lu <lulie@linux.alibaba.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 5:17=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Thu, Nov 7, 2024 at 10:01=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Thu, Nov 7, 2024 at 4:37=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> > >
> > > On Thu, Nov 7, 2024 at 9:27=E2=80=AFAM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> > > >
> > > > On Thu, Nov 7, 2024 at 4:22=E2=80=AFPM Philo Lu <lulie@linux.alibab=
a.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 2024/11/7 16:01, Jason Xing wrote:
> > > > > > On Thu, Nov 7, 2024 at 3:51=E2=80=AFPM Philo Lu <lulie@linux.al=
ibaba.com> wrote:
> > > > > >>
> > > > > >> Hi Jason,
> > > > > >>
> > > > > >> On 2024/11/5 10:55, Jason Xing wrote:
> > > > > >>> From: Jason Xing <kernelxing@tencent.com>
> > > > > >>>
> > > > > >>> We found there are rare chances that some RST packets appear =
during
> > > > > >>> the shakehands because the timewait socket cannot accept the =
SYN and
> > > > > >>> doesn't return TCP_TW_SYN in tcp_timewait_state_process().
> > > > > >>>
> > > > > >>> Here is how things happen in production:
> > > > > >>> Time        Client(A)        Server(B)
> > > > > >>> 0s          SYN-->
> > > > > >>> ...
> > > > > >>> 132s                         <-- FIN
> > > > > >>> ...
> > > > > >>> 169s        FIN-->
> > > > > >>> 169s                         <-- ACK
> > > > > >>> 169s        SYN-->
> > > > > >>> 169s                         <-- ACK
> > > > > >>> 169s        RST-->
> > > > > >>> As above picture shows, the two flows have a start time diffe=
rence
> > > > > >>> of 169 seconds. B starts to send FIN so it will finally enter=
 into
> > > > > >>> TIMEWAIT state. Nearly at the same time A launches a new conn=
ection
> > > > > >>> that soon is reset by itself due to receiving a ACK.
> > > > > >>>
> > > > > >>> There are two key checks in tcp_timewait_state_process() when=
 timewait
> > > > > >>> socket in B receives the SYN packet:
> > > > > >>> 1) after(TCP_SKB_CB(skb)->seq, rcv_nxt)
> > > > > >>> 2) (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_tsval) =
< 0)
> > > > > >>>
> > > > > >>> Regarding the first rule, it fails as expected because in the=
 first
> > > > > >>> connection the seq of SYN sent from A is 1892994276, then 169=
s have
> > > > > >>> passed, the second SYN has 239034613 (caused by overflow of s=
32).
> > > > > >>>
> > > > > >>> Then how about the second rule?
> > > > > >>> It fails again!
> > > > > >>> Let's take a look at how the tsval comes out:
> > > > > >>> __tcp_transmit_skb()
> > > > > >>>       -> tcp_syn_options()
> > > > > >>>           -> opts->tsval =3D tcp_skb_timestamp_ts(tp->tcp_use=
c_ts, skb) + tp->tsoffset;
> > > > > >>> The timestamp depends on two things, one is skb->skb_mstamp_n=
s, the
> > > > > >>> other is tp->tsoffset. The latter value is fixed, so we don't=
 need
> > > > > >>> to care about it. If both operations (sending FIN and then st=
arting
> > > > > >>> sending SYN) from A happen in 1ms, then the tsval would be th=
e same.
> > > > > >>> It can be clearly seen in the tcpdump log. Notice that the ts=
val is
> > > > > >>> with millisecond precision.
> > > > > >>>
> > > > > >>> Based on the above analysis, I decided to make a small change=
 to
> > > > > >>> the check in tcp_timewait_state_process() so that the second =
flow
> > > > > >>> would not fail.
> > > > > >>>
> > > > > >>
> > > > > >> I wonder what a bad result the RST causes. As far as I know, t=
he client
> > > > > >> will not close the connect and return. Instead, it re-sends an=
 SYN in
> > > > > >> TCP_TIMEOUT_MIN(2) jiffies (implemented in
> > > > > >> tcp_rcv_synsent_state_process). So the second connection could=
 still be
> > > > > >> established successfully, at the cost of a bit more delay. Lik=
e:
> > > > > >>
> > > > > >>    Time        Client(A)        Server(B)
> > > > > >>    0s          SYN-->
> > > > > >>    ...
> > > > > >>    132s                         <-- FIN
> > > > > >>    ...
> > > > > >>    169s        FIN-->
> > > > > >>    169s                         <-- ACK
> > > > > >>    169s        SYN-->
> > > > > >>    169s                         <-- ACK
> > > > > >>    169s        RST-->
> > > > > >> ~2jiffies    SYN-->
> >
> > It doesn't happen. I dare to say the SYN will not be retransmitted
> > soon which I can tell from many tcpdump logs I captured.
> >
> > > > > >>                                 <-- SYN,ACK
> > > > > >
> > > > > > That's exactly what I meant here :) Originally I didn't expect =
the
> > > > > > application to relaunch a connection in this case.
> > > > >
> > > > > s/application/kernel/, right?
> > > >
> > > > No. Perhaps I didn't make myself clear. If the kernel doesn't silen=
tly
> > > > drop the SYN and then send back an ACK, the application has to call
> > > > the connect() syscall again.
> > >
> > > My suggestion to stop the confusion:
> >
> > Oh, right now, I realized that Philo and I are not on the same page :(
> > Please forget that conversation.
> >
> > My points are:
> > 1) If B silently drops the SYN packet, A will retransmit an SYN packet
> > and then the connection will be established. It's what I tried to
> > propose and would like to see. It also adheres to the RFC 6191.
> > 2) As kuniyuki pointed out on the contrary, sending an ACK (like the
> > current implementation) instead of silently dropping the SYN packet is
> > actually a challenge ack. If so, I think we need to consider this ACK
> > as a challenge ack like what tcp_send_challenge_ack() does.
>
> Like where ? Again, a packetdrill test will clarify all of this.

Well, okay, Let me try.

