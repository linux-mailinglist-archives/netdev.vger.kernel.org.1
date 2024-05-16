Return-Path: <netdev+bounces-96675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9CE8C7160
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 07:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C0E1C2250B
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 05:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF5018E3F;
	Thu, 16 May 2024 05:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YGPA49OJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1826FB2
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 05:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715837803; cv=none; b=Xv3avHOK4ludNaUD3BOFNL1/hswt8X8wC1Wywho8ouSHHOithiGq1fTosTYJSFehbyatYJqJm6zypUuqJ0oji1nsnoVushvp7GGmwaNkKZgPMSKeYONWYYHmAyqqol1DyWhjbp9EglguzV1HTvPI9U1IvqRUJCZtIl24TvYptCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715837803; c=relaxed/simple;
	bh=j1S3pnudf2Ex9QRHVmBfFc2X963iWwArPD3SuQWtJTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0w20vjowrIwPCCddzkZRNrBB5lPiDiJhumHa7I1WQy5eIfz3JWZ1A/9JyRMQi1LHFbRW0QFiRUHFNjP2/BdwR3Pf+TZhyaDofgvQ67wQL/oh2AK+mgnqAqMue9f6kS+plLzZCtjuYvt1HLJ2z2mXIRFqPM3b96vvNga8ZmMsZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YGPA49OJ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so2648a12.0
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 22:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715837800; x=1716442600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywG3beZysMqnZRsPvN3kGIHbJoBrSreZgq89DqRuwmA=;
        b=YGPA49OJonD4eUDZeVKMf6JTUNtJV3lSqL8+yZHZyMnDXmVQqErh2b0EXagFZsAOrX
         cUQ/nu3ruKfzjwdmRJWfdsZD7mu/JEkKC2hUBL2WQ2MnaDFyj5zr/pxK5XUGatRAFNtr
         RriK6MUkSswvya3H+T5AJGPUq9j8Pw3qgl6WgiXlmCPhbjsXjTyNx1TDyj2gGdXxKGKr
         GuW2adk5S6efRNHS0HScjkhnWTTN8d/VBvbWYGuGAoj1+adiUFmLz5Aes99oKG38oCMb
         FwLSF0H/mw1Puwv+RDby/vL5JtalKz6kPWHw/8SM3sNiIohudL6kJhRbdFBRDEkn0rMo
         laPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715837800; x=1716442600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywG3beZysMqnZRsPvN3kGIHbJoBrSreZgq89DqRuwmA=;
        b=OLU5ESexi4/ikMW+1CNUHh067x/VVIraSmnzaNRnCfMwU2Nj/g0CD5wCezSaM9L5mw
         pJhtRD5g0ND4dVL01N17vsmttbZSnSw/60lhbyXzBeelLzW9/Eszcyhjq9VtkD1PHkuO
         p8+qxyMpeRLSWtbNI6UlnsaHuMAuS2VPOop8OurwoJyP2RZXu/UkNPls+Pwq0Zo2iL8F
         JXQe+EEWctTYuuFxnWSVLVbLqt15bRFtH7Lu9yxmA7KCbQniAt/mAUaYzHx37XTtYVe0
         9MO43r++CB6dIQZsRWyN20QRNq7ecbul7ZmZEQBiW1Oj4216I5UjNYmlDdamlWPB6oAZ
         ni4w==
X-Forwarded-Encrypted: i=1; AJvYcCW6hhWUrtO34U+1+mYg3wo/zndG0UnRGIEr1L4CsV+I9ZavkVXuMC6zE5v5CScMm54Q+ZmbGLtXOwTdMcqpp5mJKtwDSfND
X-Gm-Message-State: AOJu0Yym1dzO6A4TyRLH4WHuM24o1itMFUSxZ9wuni4VFPnFWaHY8xra
	zqQ1G5dvPRpLYWP9b4CItIvHSTN3bWGeiGeh7lItSBlMsV/tYo+C01PSyTe0FdW6GOnjq+30YKE
	Kqjxl+vfCHfXkFePlRb4O784jt7I0ATuAqnsa
X-Google-Smtp-Source: AGHT+IEcjCemBDcvx6Po7/mJqoGcPxa88thbvn4bC7T51qnYDjrOUu+tG32cqbL9abBWUitYc8HzNrl2XhnNf688Zw4=
X-Received: by 2002:a05:6402:222a:b0:572:554b:ec66 with SMTP id
 4fb4d7f45d1cf-574ae571da7mr926976a12.3.1715837799983; Wed, 15 May 2024
 22:36:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7ec9b05b-7587-4182-b011-625bde9cef92@quicinc.com>
 <CANn89iKRuxON3pWjivs0kU-XopBiqTZn4Mx+wOKHVmQ97zAU5A@mail.gmail.com> <60b04b0a-a50e-4d4a-a2bf-ea420f428b9c@quicinc.com>
In-Reply-To: <60b04b0a-a50e-4d4a-a2bf-ea420f428b9c@quicinc.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 16 May 2024 07:36:26 +0200
Message-ID: <CANn89i+QM1D=+fXQVeKv0vCO-+r0idGYBzmhKnj59Vp8FEhdxA@mail.gmail.com>
Subject: Re: Potential impact of commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
To: "Subash Abhinov Kasiviswanathan (KS)" <quic_subashab@quicinc.com>
Cc: soheil@google.com, ncardwell@google.com, yyd@google.com, ycheng@google.com, 
	quic_stranche@quicinc.com, davem@davemloft.net, kuba@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 4:32=E2=80=AFAM Subash Abhinov Kasiviswanathan (KS)
<quic_subashab@quicinc.com> wrote:
>
> On 5/15/2024 1:10 AM, Eric Dumazet wrote:
> > On Wed, May 15, 2024 at 6:47=E2=80=AFAM Subash Abhinov Kasiviswanathan =
(KS)
> > <quic_subashab@quicinc.com> wrote:
> >>
> >> We recently noticed that a device running a 6.6.17 kernel (A) was havi=
ng
> >> a slower single stream download speed compared to a device running
> >> 6.1.57 kernel (B). The test here is over mobile radio with iperf3 with
> >> window size 4M from a third party server.
> >
> > Hi Subash
> >
> > I think you gave many details, but please give us more of them :
>
> Hi Eric
>
> Thanks for getting back. Hope the information below is useful.
>
> >
> > 1) What driver is used on the receiver side.
> rmnet
>
> > 2) MTU
> 1372
>
> > 3) cat /proc/sys/net/ipv4/tcp_rmem
> 4096 6291456 16777216


DRS is historically sensitive to initial conditions.

tcp_rmem[1] seems too big here for DRS to kick smoothly.

I would use 0.5 MB perhaps, this will also also use less memory for
local (small rtt) connections

>
> >
> > Ideally, you could snapshot "ss -temoi dst <otherpeer>" on receive
> > side while the transfer is ongoing,
> > and possibly while stopping the receiver thread (kill -STOP `pidof iper=
f`)
> >
> 192.0.0.2 is the device side address. I've listed the output of "ss
> -temoi dst 223.62.236.10" mid transfer and one around the end of transfer=
.
>
> I believe iperf3 makes a control connection prior to triggering the data
> connection so it will list two flows.  The transfer between
> 192.0.0.2:42278 <-> 223.62.236.10:5215 is the main data connection in
> this case.
>
> //mid transfer
> State       Recv-Q Send-Q Local Address:Port                 Peer
> Address:Port
>
> ESTAB       0      0      192.0.0.2:42278                223.62.236.10:52=
15
>      ino:129232 sk:3218 fwmark:0xc0078 <->
>           skmem:(r0,rb8388608,t0,tb8388608,f0,w0,o0,bl0,d1) ts sack
> cubic wscale:7,6 rto:236 rtt:34.249/16.545 ato:40 mss:1320 rcvmss:1320
> advmss:1320 cwnd:10 ssthresh:1400 bytes_acked:38
> bytes_received:211495680 segs_out:46198 segs_in:160290 data_segs_out:1
> data_segs_in:160287 send 3.1Mbps lastsnd:3996 pacing_rate 6.2Mbps
> delivery_rate 452.4Kbps app_limited busy:24ms rcv_rtt:26.542
> rcv_space:3058440 minrtt:23.34
> ESTAB       0      0      192.0.0.2:42270                223.62.236.10:52=
15
>      ino:128718 sk:4273 fwmark:0xc0078 <->
>           skmem:(r0,rb6291456,t0,tb2097152,f0,w0,o0,bl0,d0) ts sack
> cubic wscale:10,9 rto:528 rtt:144.931/93.4 ato:40 mss:1320 rcvmss:536
> advmss:1320 cwnd:10 ssthresh:1400 bytes_acked:223 bytes_received:4
> segs_out:9 segs_in:8 data_segs_out:3 data_segs_in:4 send 728.6Kbps
> lastsnd:6064 lastrcv:3948 lastack:3948 pacing_rate 1.5Mbps delivery_rate
> 351.8Kbps app_limited busy:156ms rcv_space:13200 minrtt:30.021
>
> //close to end of transfer
> State       Recv-Q Send-Q Local Address:Port                 Peer
> Address:Port
>
> ESTAB       4324072 0      192.0.0.2:42278                223.62.236.10:5=
215
>       ino:129232 sk:3218 fwmark:0xc0078 <->
>           skmem:(r4511016,rb8388608,t0,tb8388608,f2776,w0,o0,bl0,d1) ts
> sack cubic wscale:7,6 rto:236 rtt:34.249/16.545 ato:40 mss:1320
> rcvmss:1320 advmss:1320 cwnd:10 ssthresh:1400 bytes_acked:38
> bytes_received:608252040 segs_out:133117 segs_in:460963 data_segs_out:1
> data_segs_in:460960 send 3.1Mbps lastsnd:10104 pacing_rate 6.2Mbps
> delivery_rate 452.4Kbps app_limited busy:24ms rcv_rtt:25.111
> rcv_space:3871560 minrtt:23.34
> ESTAB       0      294    192.0.0.2:42270                223.62.236.10:52=
15
>      timer:(on,412ms,0) ino:128718 sk:4273 fwmark:0xc0078 <->
>           skmem:(r0,rb6291456,t0,tb2097152,f2010,w2086,o0,bl0,d0) ts
> sack cubic wscale:10,9 rto:512 rtt:129.796/94.265 ato:40 mss:1320
> rcvmss:536 advmss:1320 cwnd:10 ssthresh:1400 bytes_acked:224
> bytes_received:5 segs_out:12 segs_in:9 data_segs_out:5 data_segs_in:5
> send 813.6Kbps lastsnd:48 lastrcv:52 lastack:52 pacing_rate 1.6Mbps
> delivery_rate 442.8Kbps app_limited busy:228ms unacked:1 rcv_space:13200
> notsent:290 minrtt:23.848
>
> > TCP is sensitive to the skb->len/skb->truesize ratio.
> > Some drivers are known to provide 'bad skbs' in this regard.
> >
> > Commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale") is
> > simply a step for dynamic
> > probing of skb->len/skb->truesize ratio, and give incentive for better
> > memory use.
> >
> > Ultimately, TCP RWIN derives from effective memory usage.
> >
> > Sending a too big RWIN can cause excessive memory usage or packet drops=
.
> > If you say RWIN was 6MB+ before the patch, this looks like a bug to me,
> > because tcp_rmem[2] =3D 6MB by default. There is no way a driver can
> > pack 6MB of TCP payload in 6MB of memory (no skb/headers overhead ???)
> > This would only work well in lossless networks, and if receiving
> > application drains TCP receive queue fast enough.
> >
> > Please take a look at these relevant patches.
> > Note they are not perfect patches, because usbnet can still provide
> > 'bad skbs', forcing TCP to send small RWIN.
> rmnet is not updating the truesize directly in the receive path. There
> is no cloning and there is an explicit copy of the data content to a
> freshly allocated skb similar to your commits shared below.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/dri=
vers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c?h=3Dv6.6.17#n385

Hmm... rmnet_map_deaggregate() looks very strange.

I also do not understand why this NIC driver uses gro_cells, which was
designed for virtual drivers like tunnels.

ca32fb034c19e00c changelog is sparse,
it does not explain why standard GRO could not be directly used.

>
>  From netif_receive_skb_entry tracing, I see that the truesize is around
> ~2.5K for ~1.5K packets.

This is a bit strange, this does not match :

> ESTAB       4324072 0      192.0.0.2:42278                223.62.236.10:5=
215
>       ino:129232 sk:3218 fwmark:0xc0078 <->
>           skmem:(r4511016,

-> 4324072 bytes of payload , using 4511016 bytes of memory



>
> >
> > d50729f1d60bca822ef6d9c1a5fb28d486bd7593 net: usb: smsc95xx: stop
> > lying about skb->truesize
> > 05417aa9c0c038da2464a0c504b9d4f99814a23b net: usb: sr9700: stop lying
> > about skb->truesize
> > 1b3b2d9e772b99ea3d0f1f2252bf7a1c94b88be6 net: usb: smsc75xx: stop
> > lying about skb->truesize
> > 9aad6e45c4e7d16b2bb7c3794154b828fb4384b4 usb: aqc111: stop lying about
> > skb->truesize
> > 4ce62d5b2f7aecd4900e7d6115588ad7f9acccca net: usb: ax88179_178a: stop
> > lying about skb->truesize
>
> I reviewed many of the tcpdumps from other tests internally and I
> consistently see the receiver window size scale to roughly half of what
> is specified in iperf3 regardless of whatever radio configurations or
> MTU. There was no download speed issue reported for any of these cases.
>
> I believe this particular download test is failing as the RTT is likely
> higher in this network than the other cases.

