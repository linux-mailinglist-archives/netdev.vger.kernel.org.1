Return-Path: <netdev+bounces-142717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6949C015B
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 10:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD421F22486
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 09:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30E0194A63;
	Thu,  7 Nov 2024 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="28ltB8ok"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E081C372
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730972723; cv=none; b=A1DQLVKm3E8XlBzBNanhhARGVh1/OFicaPicZsiZnUv60QYTnIB3gt6h7OQA39ZDpU6QRYSdQGJn7qG5RGN0RQLuQSj85RizoIrBRBYCZpyzkOsVZqrEA9cgg0yJ0iRd6eMrK06tvVLp/J7LoyuzfvsFjn/MiqBm8B1aCjniiaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730972723; c=relaxed/simple;
	bh=Nw88O+qc2Iiho2vWkhbwR/rx+YJlFtIEohK/QOiIjb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGtZGLPbg4h4ce3tj+OIEq5haia1whfQL4hgI2HTwOj2B0gVRsaCgVRW+2V9xj/VRlROKU4W9PQLuXDXKq5xvxaqFMLl5s9g0V7jDTAH8TSR6wV3+k/zujwaGNXUNLMGvPNy8K2vNhuUey9WciykatVMdtbSxvAf5jZFlOVO+8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=28ltB8ok; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cec93719ccso890690a12.2
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 01:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730972720; x=1731577520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WzwvVPMcv17tiqf1EYUKhCFf7ghDPC1Sgbbs0Vu05U=;
        b=28ltB8okMlM9G/uLnuwkGtsfPh0FqRFwhjhWF67a0kAx4+xvtq3GGWUIe2OSPBULzU
         4c3pZ8yRbsshVTYbm3nH0GHZq5wyzF8cm+rc4dNSTjaL4KvlVMt6zHUuukXXgwfYoWa9
         JruZX2ROnTvnJztZn21cfJnPWaifUUfXY3kPXa1aXYTguP2tnApMmFgRDsSmCYTri0Ve
         s5h0fHCBApx8zJq3ObkRyaJhac+3jFnX9PKKZtepmvKnGZ1OjeNBZnjhN4K+HAv+7xIz
         zNQVeaKWVpZb1ea0qlUtNqnxsLepxAOJGfhC3EZKMhKFN8FaSdwrmTmWk6oabiUzivKV
         YKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730972720; x=1731577520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WzwvVPMcv17tiqf1EYUKhCFf7ghDPC1Sgbbs0Vu05U=;
        b=Y/NeWN4IL1Rc05E/V1RwqA5juL31hI0sQTgztKb/76H+gETpyxIyUBP2REA/JdjmXS
         LJ/Lq09o88kVf8nqVBq4mpiej7YbX0o65Xoqlrjeb1G8S1jMLHpEfzfWhpylcQ5b8diA
         Ve2pIKEgzBDJuTiLhEi23sXGOMUPevtmhSlzjbvhI4iEa2B0EfrLh+UBitYGzhJblP2T
         VrtjDNaygDOU2uSReyJg3VHUE2y8f8RuKArKRSN49KCOldBfB1aJaknzT+a9K7vHpkqX
         HCnbTExQuPA5ZqFcTLr2efBFnFja0toR1lreJZp/wEB534oIdwWgDtgb61w1FqjKspRD
         t8sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDHULCQ7EE8cjp/IedXmh3EkR7DyBPkgZOoq9dxZfwa4mbkAwfOc1hMnYcwy+SOjrXB9j/ibA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhXhQ44VgZXHIs7W06vgM3tZfssj1AfrTdINQgrrSBDsFPwsRn
	ZgGoTGnGodvxWefYGeK7nzzuwp1ZPptODx3WgL0E2jNG3Jux0o50YQbZOgSaDJLUISr6QnrUduC
	t09Wtt2iDUzewm80y+TCU02+BCHiUn4VXuA+k
X-Google-Smtp-Source: AGHT+IFGkv2Wfyzs9qMDLFVHFHz8T62r+4XTiS3Qut0t5pCeA9xbzssJfqlrmZ1KCWjUNZ/pmriTqLdji4tyHAk1GLc=
X-Received: by 2002:a05:6402:2350:b0:5ce:dfbc:7fa5 with SMTP id
 4fb4d7f45d1cf-5cf05a33bd9mr615312a12.25.1730972720073; Thu, 07 Nov 2024
 01:45:20 -0800 (PST)
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
 <CAL+tcoBCqXiQ33XZv61vCes7_XV83DC0HSPy_w6eCn4pzzJeqA@mail.gmail.com> <CAL+tcoBPj2aULt5G4qis0D78ke=dt2ws7KBg4Gn+s4FtzjMZfQ@mail.gmail.com>
In-Reply-To: <CAL+tcoBPj2aULt5G4qis0D78ke=dt2ws7KBg4Gn+s4FtzjMZfQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Nov 2024 10:45:08 +0100
Message-ID: <CANn89iL7uBQQmQcZnbmX-23eyQn5GOecyp2ddcb-oqpJxK6G0w@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: avoid RST in 3-way shakehands due to
 failure in tcp_timewait_state_process
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Philo Lu <lulie@linux.alibaba.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 10:30=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Thu, Nov 7, 2024 at 5:00=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
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
>
> My mind went blank probably because of getting sick. Sorry. Why the
> tcpdump doesn't show the retransmitted SYN packet is our private
> kernel missed this following commit:
>
> commit 9603d47bad4642118fa19fd1562569663d9235f6
> Author: SeongJae Park <sjpark@amazon.de>
> Date:   Sun Feb 2 03:38:26 2020 +0000
>
>     tcp: Reduce SYN resend delay if a suspicous ACK is received
>
>     When closing a connection, the two acks that required to change closi=
ng
>     socket's status to FIN_WAIT_2 and then TIME_WAIT could be processed i=
n
>     reverse order.  This is possible in RSS disabled environments such as=
 a
>     connection inside a host.

Not having a patch from linux-5.6 does not really give a good impression,
please next time make sure your patches are needed for upstream trees,
net or net-next.

This also means you can write a packetdrill test to show the benefit
of this patch,
and send it as a new selftests ;)

Back to packetdrill, and everyone will be happy.

