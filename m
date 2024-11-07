Return-Path: <netdev+bounces-142703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB299C00C1
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 10:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC80283735
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 09:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A331D8E0D;
	Thu,  7 Nov 2024 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6MWv9Fq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E59194096
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730970069; cv=none; b=fHZtmD0j0QQN3s15ZTLqSH33jc8/4iu3MFrvXMdGG/JMUYBbVbuA4EuSARe7l3QvbgIJrUoDDCNdZuqjAiPkdMg7N99zVWO9oUIdBRCDYSt53ShoepwoOux/cLHXqKN26iXItMd/dVKxwioPcAx19mBewAG3D8iNiGD5jgeUlio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730970069; c=relaxed/simple;
	bh=92oPYBnUwrTKq9c/h+HNw7XJN2/PAl9qBhIw+Mv6WqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7/jDUI0YGLsTtOFiY5R+muJ5tiSId/wcXM45UKZPG+hzOP3Tv7HLzMWEXLoe18bddfBoIWBWBPnDCtSUlZHbvOgyd214yItLC0j9dUdSiNJ6+PnRynXZc04K8mrq0X47TFP6Z+NzwML6VF1nbSbIiIo6H8KjXOE0WOCIVZ2SBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6MWv9Fq; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-83aa3ced341so29494239f.0
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 01:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730970067; x=1731574867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zk6+/Sf19VFgJkEuHSIAmFcRzw9xSmdS9sAgSp/35ls=;
        b=b6MWv9FqqQTl5Nsw0nN2Z0a8Ua1Yi/RkoQK3JGDzFs1++RYlITi9RVQwMa8doOituQ
         Fa4WW8lxmecWdMuWcI6RZqkQOppoKwuKpfUC13IzjN0MxH8MY/6g8jtUk1ueItZc4UAQ
         g2djLlDJvQOdleQQ8nf4wsqJZuR1E1tWEEWueOddxtszVDxRsBr/v2MPOww8kIBMkBMP
         9+7VpXxN5NNTSkyQP2R7Y9sx0OAKXOdvsZ2m2xW9JQyTg2RMSjBc/ev282oJd2mZlaUf
         3U7KEgQiijTT/lj7hEWUEk/GawfBAMXnbAl0rVwXFYn6CUh+AZLmxRa34ej9CPz7G0lD
         mJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730970067; x=1731574867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zk6+/Sf19VFgJkEuHSIAmFcRzw9xSmdS9sAgSp/35ls=;
        b=EdjV3NkV1woyEqlN1EszSW4bRaMmzsfnk3EHbHLTRCO599WQ2PVrFce1fGuTV3nmK7
         VSfraG+lJvXNV3f7UtfwpqKzI9nZqecLdXhzz3vgnt3KWVfg1sNiAmZNfzMQX+KgZuvP
         AMbGEWEA+0KHUhdH9dIiCZtH1Qusu35x3ym3319oVi/oGVD3sV74jJOceZXgcrSmYbqv
         i+tY7+A+UZXNYUyOgGQdxpnxb1qEWL90zaa3IesaxNv5xHVi2OGtVUCWCvIt9VYkYLip
         ch5ZR/ATrLQm0E97YpMYlNI2IablPNGl6k/Yy+HOpeZVwmRW0D4p510VKedi4cMD24X/
         qcYw==
X-Forwarded-Encrypted: i=1; AJvYcCUpufgwgoNVLS8iaAHw5kiEdul+WPM4UCQlOqKDOZJVXzjyIfB6cPpRr5dcWXfxRDS4tU2JGA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMV4mvGT3hk5+hCQ27+xZlcsKxRDew2j3h/VL18e/duz1A1Snr
	chqVcgKFVQy3H5vT2wewyqZRbuvzu5HMxQhriKuuyaQ5v2iZWyu+G9PJEuFYZ300PPCXAZIZAKJ
	eOehailWleAhGad/gh5d6SoPsMWo=
X-Google-Smtp-Source: AGHT+IFzolN4sxN9C4z4kmyRClqZ0oEtDVS3qoSU0YClPttQ80kONTtvTopn8IeFkA6PSlcALJyrJBa+KG3pKF3KV2Q=
X-Received: by 2002:a05:6e02:12c9:b0:3a6:c122:508c with SMTP id
 e9e14a558f8ab-3a6ed110b41mr5741925ab.19.1730970067055; Thu, 07 Nov 2024
 01:01:07 -0800 (PST)
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
In-Reply-To: <CANn89iL5df5_EiDX7JxaFbfmZ9gDo=8ZyLXhbZs+-yp8zVD=GA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 7 Nov 2024 17:00:30 +0800
Message-ID: <CAL+tcoBCqXiQ33XZv61vCes7_XV83DC0HSPy_w6eCn4pzzJeqA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: avoid RST in 3-way shakehands due to
 failure in tcp_timewait_state_process
To: Eric Dumazet <edumazet@google.com>
Cc: Philo Lu <lulie@linux.alibaba.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 4:37=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Thu, Nov 7, 2024 at 9:27=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > On Thu, Nov 7, 2024 at 4:22=E2=80=AFPM Philo Lu <lulie@linux.alibaba.co=
m> wrote:
> > >
> > >
> > >
> > > On 2024/11/7 16:01, Jason Xing wrote:
> > > > On Thu, Nov 7, 2024 at 3:51=E2=80=AFPM Philo Lu <lulie@linux.alibab=
a.com> wrote:
> > > >>
> > > >> Hi Jason,
> > > >>
> > > >> On 2024/11/5 10:55, Jason Xing wrote:
> > > >>> From: Jason Xing <kernelxing@tencent.com>
> > > >>>
> > > >>> We found there are rare chances that some RST packets appear duri=
ng
> > > >>> the shakehands because the timewait socket cannot accept the SYN =
and
> > > >>> doesn't return TCP_TW_SYN in tcp_timewait_state_process().
> > > >>>
> > > >>> Here is how things happen in production:
> > > >>> Time        Client(A)        Server(B)
> > > >>> 0s          SYN-->
> > > >>> ...
> > > >>> 132s                         <-- FIN
> > > >>> ...
> > > >>> 169s        FIN-->
> > > >>> 169s                         <-- ACK
> > > >>> 169s        SYN-->
> > > >>> 169s                         <-- ACK
> > > >>> 169s        RST-->
> > > >>> As above picture shows, the two flows have a start time differenc=
e
> > > >>> of 169 seconds. B starts to send FIN so it will finally enter int=
o
> > > >>> TIMEWAIT state. Nearly at the same time A launches a new connecti=
on
> > > >>> that soon is reset by itself due to receiving a ACK.
> > > >>>
> > > >>> There are two key checks in tcp_timewait_state_process() when tim=
ewait
> > > >>> socket in B receives the SYN packet:
> > > >>> 1) after(TCP_SKB_CB(skb)->seq, rcv_nxt)
> > > >>> 2) (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_tsval) < 0)
> > > >>>
> > > >>> Regarding the first rule, it fails as expected because in the fir=
st
> > > >>> connection the seq of SYN sent from A is 1892994276, then 169s ha=
ve
> > > >>> passed, the second SYN has 239034613 (caused by overflow of s32).
> > > >>>
> > > >>> Then how about the second rule?
> > > >>> It fails again!
> > > >>> Let's take a look at how the tsval comes out:
> > > >>> __tcp_transmit_skb()
> > > >>>       -> tcp_syn_options()
> > > >>>           -> opts->tsval =3D tcp_skb_timestamp_ts(tp->tcp_usec_ts=
, skb) + tp->tsoffset;
> > > >>> The timestamp depends on two things, one is skb->skb_mstamp_ns, t=
he
> > > >>> other is tp->tsoffset. The latter value is fixed, so we don't nee=
d
> > > >>> to care about it. If both operations (sending FIN and then starti=
ng
> > > >>> sending SYN) from A happen in 1ms, then the tsval would be the sa=
me.
> > > >>> It can be clearly seen in the tcpdump log. Notice that the tsval =
is
> > > >>> with millisecond precision.
> > > >>>
> > > >>> Based on the above analysis, I decided to make a small change to
> > > >>> the check in tcp_timewait_state_process() so that the second flow
> > > >>> would not fail.
> > > >>>
> > > >>
> > > >> I wonder what a bad result the RST causes. As far as I know, the c=
lient
> > > >> will not close the connect and return. Instead, it re-sends an SYN=
 in
> > > >> TCP_TIMEOUT_MIN(2) jiffies (implemented in
> > > >> tcp_rcv_synsent_state_process). So the second connection could sti=
ll be
> > > >> established successfully, at the cost of a bit more delay. Like:
> > > >>
> > > >>    Time        Client(A)        Server(B)
> > > >>    0s          SYN-->
> > > >>    ...
> > > >>    132s                         <-- FIN
> > > >>    ...
> > > >>    169s        FIN-->
> > > >>    169s                         <-- ACK
> > > >>    169s        SYN-->
> > > >>    169s                         <-- ACK
> > > >>    169s        RST-->
> > > >> ~2jiffies    SYN-->

It doesn't happen. I dare to say the SYN will not be retransmitted
soon which I can tell from many tcpdump logs I captured.

> > > >>                                 <-- SYN,ACK
> > > >
> > > > That's exactly what I meant here :) Originally I didn't expect the
> > > > application to relaunch a connection in this case.
> > >
> > > s/application/kernel/, right?
> >
> > No. Perhaps I didn't make myself clear. If the kernel doesn't silently
> > drop the SYN and then send back an ACK, the application has to call
> > the connect() syscall again.
>
> My suggestion to stop the confusion:

Oh, right now, I realized that Philo and I are not on the same page :(
Please forget that conversation.

My points are:
1) If B silently drops the SYN packet, A will retransmit an SYN packet
and then the connection will be established. It's what I tried to
propose and would like to see. It also adheres to the RFC 6191.
2) As kuniyuki pointed out on the contrary, sending an ACK (like the
current implementation) instead of silently dropping the SYN packet is
actually a challenge ack. If so, I think we need to consider this ACK
as a challenge ack like what tcp_send_challenge_ack() does.

I'd like to hear more about your opinions on the above conclusion.

Thanks!

