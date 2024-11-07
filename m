Return-Path: <netdev+bounces-142681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B8A9BFFEF
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 09:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61A7282614
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 08:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0DF1D95BE;
	Thu,  7 Nov 2024 08:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiJrm8mk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA51D1D8E10
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730968030; cv=none; b=FemT0kHFCHOC+CJlSVbLXqhcwgoo3BCMHjbRtMb86qFPM9uYzTB5DA14ETm3hADon6zfIzFIXfnkZ0ZG3ysK6CUgZZvjRXEkNXdBDQGy2tCXABH/nadz5+JIxLiLKHpSV642l7iOC1NKTrEpgfyVePhtxJ5BfRLz8h8rtLVmy08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730968030; c=relaxed/simple;
	bh=08nL/hljM++xTEbWQrvIOMYlj5ZnMPIJmkQdlu/fmvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdNsqKN6J6ngGTZ5WE+dALXqpQbYdK6dSgxKsg45rrLVAhxoecmMjyrFD8l7w1M3r3TZlOLZ1CFpjOw6OMzgLs8DJH+fiokgQbaXMUH5Jb0ok5fe2NfkJ/Wn1V48RptlfMir9KR5DaONjDe5X9pROXI1JVkIqeDfPk6Hixzottw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiJrm8mk; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-83ac05206f6so25025239f.2
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 00:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730968028; x=1731572828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1i27eoKmRGm1K6ciR9sekgV335uQNnSFdmjddLNOWP8=;
        b=WiJrm8mkhBgMtwmWoK2aqvEoNESiRpeiLTxu5aSgaYsHA792wmFRdj5khdxDkN2AYd
         cLCXzWJifPQLtd5eZZH6G3MX5stcO2QBF3/91u0KkURrl/9kfEe+uePrChTNA96xuBXX
         +jfqCCJ/FVyAxkOxm8Zm3DFEOK9BMSWDjJjZVAXart4cOL4qDqeA5SVz6O3bwcIRBT0L
         k4AdlszkjYD8hab64OBbrdEzRh0qtbiZ55B1vC9Hu/TwqkY1e3Ojx8rWF3/VXSATuQSh
         /B+bsZog/HIgbZijskjcQg0bmECLnxGSYqINya7TC2+WHIfAkzIKnmYhS4Ss9GWGkkLG
         yS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730968028; x=1731572828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1i27eoKmRGm1K6ciR9sekgV335uQNnSFdmjddLNOWP8=;
        b=FaucganH5QQhnopGZFHLc7oFM4cG6NIA3+JjG7iOF3Hcb2JiOtM4Sgub3vWOwsx1Ak
         P82J+F+BX5nMBAAs6q+0Xr0vuBf4Tkf+oTSo81ppKNy6V3YzzTOMwROiA9Gp+MKOyOO3
         xtpebpuTdvgtjhOEyjDCssb2t84s215CzuQ7kWFJAsbtXgJMhUn6LoOodFgyIDH/s7P+
         2m10xdY3MOXldNP17N6rPnZdW5KS7a30g45kipHOEgnBntonAbdLd+3+ekfnxqakZKKk
         D7MNnxeWP9QOAn1rmydBR/OQkqfK1DGhHP1rVnJksgQ6s0bSjcm25cJZMLhFMaHcXL1b
         91bg==
X-Forwarded-Encrypted: i=1; AJvYcCXKL48B5YZii036zQeT1jo+ZX353z3yXbrk/H5ZCl0kWCUUee3+rjPzqLrFy6dt6H3+245MsI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl1beXPR9NpaGCJDhujASWHlfXV142BvMRMbamr2Wn1/p5Avua
	Z5r47rqqi3PtyaaIqt6rDfUdVs364uuW5HwcUzgeXOGtlB9ZHG+LsQ1JEH8tnWUYijzo9gO4K3G
	o5G+sqBKZA3RhZUHOOUdZ8ZrJcrI=
X-Google-Smtp-Source: AGHT+IGWjhwJ2svaWJWPAHN43+RE8qCY1BVhDLzpJu1gr2kL3gtb2hvHvsuc2ojmkKHSln8KMdnhQZP6z8N/FyZL7Jk=
X-Received: by 2002:a92:cda4:0:b0:3a5:e250:bba1 with SMTP id
 e9e14a558f8ab-3a6ed11094bmr4191915ab.18.1730968027846; Thu, 07 Nov 2024
 00:27:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105025511.42652-1-kerneljasonxing@gmail.com>
 <92c1d976-7bb6-49ff-9131-edba30623f76@linux.alibaba.com> <CAL+tcoBZaDhBuSKHzGEqgxkzOazX3K-Vo2=mCdOy+iLp4sPAhg@mail.gmail.com>
 <75708260-7eb4-42fe-9d9b-605f8eef488b@linux.alibaba.com>
In-Reply-To: <75708260-7eb4-42fe-9d9b-605f8eef488b@linux.alibaba.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 7 Nov 2024 16:26:31 +0800
Message-ID: <CAL+tcoBA78svT_vTMOLV-pbwKM1o_SDbjs7AAZLhHOtrd8akBg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: avoid RST in 3-way shakehands due to
 failure in tcp_timewait_state_process
To: Philo Lu <lulie@linux.alibaba.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 4:22=E2=80=AFPM Philo Lu <lulie@linux.alibaba.com> w=
rote:
>
>
>
> On 2024/11/7 16:01, Jason Xing wrote:
> > On Thu, Nov 7, 2024 at 3:51=E2=80=AFPM Philo Lu <lulie@linux.alibaba.co=
m> wrote:
> >>
> >> Hi Jason,
> >>
> >> On 2024/11/5 10:55, Jason Xing wrote:
> >>> From: Jason Xing <kernelxing@tencent.com>
> >>>
> >>> We found there are rare chances that some RST packets appear during
> >>> the shakehands because the timewait socket cannot accept the SYN and
> >>> doesn't return TCP_TW_SYN in tcp_timewait_state_process().
> >>>
> >>> Here is how things happen in production:
> >>> Time        Client(A)        Server(B)
> >>> 0s          SYN-->
> >>> ...
> >>> 132s                         <-- FIN
> >>> ...
> >>> 169s        FIN-->
> >>> 169s                         <-- ACK
> >>> 169s        SYN-->
> >>> 169s                         <-- ACK
> >>> 169s        RST-->
> >>> As above picture shows, the two flows have a start time difference
> >>> of 169 seconds. B starts to send FIN so it will finally enter into
> >>> TIMEWAIT state. Nearly at the same time A launches a new connection
> >>> that soon is reset by itself due to receiving a ACK.
> >>>
> >>> There are two key checks in tcp_timewait_state_process() when timewai=
t
> >>> socket in B receives the SYN packet:
> >>> 1) after(TCP_SKB_CB(skb)->seq, rcv_nxt)
> >>> 2) (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_tsval) < 0)
> >>>
> >>> Regarding the first rule, it fails as expected because in the first
> >>> connection the seq of SYN sent from A is 1892994276, then 169s have
> >>> passed, the second SYN has 239034613 (caused by overflow of s32).
> >>>
> >>> Then how about the second rule?
> >>> It fails again!
> >>> Let's take a look at how the tsval comes out:
> >>> __tcp_transmit_skb()
> >>>       -> tcp_syn_options()
> >>>           -> opts->tsval =3D tcp_skb_timestamp_ts(tp->tcp_usec_ts, sk=
b) + tp->tsoffset;
> >>> The timestamp depends on two things, one is skb->skb_mstamp_ns, the
> >>> other is tp->tsoffset. The latter value is fixed, so we don't need
> >>> to care about it. If both operations (sending FIN and then starting
> >>> sending SYN) from A happen in 1ms, then the tsval would be the same.
> >>> It can be clearly seen in the tcpdump log. Notice that the tsval is
> >>> with millisecond precision.
> >>>
> >>> Based on the above analysis, I decided to make a small change to
> >>> the check in tcp_timewait_state_process() so that the second flow
> >>> would not fail.
> >>>
> >>
> >> I wonder what a bad result the RST causes. As far as I know, the clien=
t
> >> will not close the connect and return. Instead, it re-sends an SYN in
> >> TCP_TIMEOUT_MIN(2) jiffies (implemented in
> >> tcp_rcv_synsent_state_process). So the second connection could still b=
e
> >> established successfully, at the cost of a bit more delay. Like:
> >>
> >>    Time        Client(A)        Server(B)
> >>    0s          SYN-->
> >>    ...
> >>    132s                         <-- FIN
> >>    ...
> >>    169s        FIN-->
> >>    169s                         <-- ACK
> >>    169s        SYN-->
> >>    169s                         <-- ACK
> >>    169s        RST-->
> >> ~2jiffies    SYN-->
> >>                                 <-- SYN,ACK
> >
> > That's exactly what I meant here :) Originally I didn't expect the
> > application to relaunch a connection in this case.
>
> s/application/kernel/, right?

No. Perhaps I didn't make myself clear. If the kernel doesn't silently
drop the SYN and then send back an ACK, the application has to call
the connect() syscall again.

> Because the retry is transparent to user
> applications except the additional latency. I think all of these are
> finished in a single connect() :)

Right.

