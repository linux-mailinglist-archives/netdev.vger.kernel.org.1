Return-Path: <netdev+bounces-154511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E6F9FE4DD
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 10:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8675D1882789
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 09:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3A41A23A9;
	Mon, 30 Dec 2024 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eSZokVuX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490B31A08A4
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735551228; cv=none; b=KRCPMsyf31cw42hTwITfvvX871iFkG80wP62OfA5EBHSlqXQSW9UE0rYWTsx7Q0gPac32cVYpFYsb5S/EAnKxvfxtQ2bo/yvqygeOqlsytvaJpqHv35+Xkrpm03Q3tql9uaXJ+LOIoiT7pcuo6qQ0imBUKqK8cvhcGIXO6d0Q/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735551228; c=relaxed/simple;
	bh=nOxYaJvTz7+PlyshExqoeB/Pyq0iZ4T8URTGWeIV1JE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tUeuYZgwbZ41X3/6eCre7l8atdW5YVPRr3AUH0S4oPNfoRE76fGg9JZ/b5A3Vm4V9CM05sFE+4G3Bqmw9PXnVG1f6C8FzUwB/7SsrCYeK2BG0KtmvvI5+JfdXt5HSQY08RREE/ZhNOAUKi3NUCyYglbKATyNam5nZHtaK6aLRUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eSZokVuX; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3d0205bd5so13120343a12.3
        for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 01:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735551225; x=1736156025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZgzK/bpz7taDlrFjlkrXFbc1jcXA+0fkhgFAdoG/6A=;
        b=eSZokVuXws7Om9GQSA18ro4CJcGAnBvMpkrfhr0yfEB2Jdu4E+v0/LPqUHj/rxNVL8
         gw8nW8STD3ru/4uCNc8/j3HNA8Ya6WQm6BQM8+GPXkcUsSdB2+rlRnr5W4b7ajItBofC
         SNysv9xQ8VicJIhOhFzLUjR4/vvDi5ADPRe7k3izV4Ci6DEu124XVB9KDaW/Xkk0yy5M
         Wzt1ubkE0SEHDGatSRt/nWp7VOhlTMPLoLLz+mvdi1aGKwS1RoTkg+VzjC7t4SE0xbKv
         BxALS0EckJpc//+R3BFk0kspCQfCKWb1g2LHO8z+8URot8uGJ7vTEZX8W66ZTGsVyVcT
         cpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735551225; x=1736156025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZgzK/bpz7taDlrFjlkrXFbc1jcXA+0fkhgFAdoG/6A=;
        b=BQapV2qkwzHT0yFXABE0G7Um3oYlrExwah6kYG+4gGGnlsesYM1q8w9xxGO7TQ/+zd
         eRSNtmfC2fSIVE5/D5vVv45OmKLtSy3D7IFR6c1x+YfPXK9Hcj3i4c9p4JPXPpNXoT0D
         Cf4rl+Q56n01u2ccawnBg6a9qUFwhcDsdsEKcQE3a7hPafNVp9nQUdlRwYW/b3DnbOcp
         Ka/Zw2d3iMQBFoXxiFLnlk1GRHAFCfXomMoliLgkef5dYQBQ0HREEr/laVaOQ++oMi94
         MAEQU9yW7LMrIz4f5g4gv4p6CePIzx3bjtFNiKp9Monb251PiCjJ3m7Hd+73TDSMclNX
         vBJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNQDjjWtAmRH9kElA09L9A9NNsxlvRIGexkI38PyH3Hhv6g3SBlvBVNk1DNHhXliqRgpyEj3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5hjHUSaxwkcJIAuW2A6dQBMK3KyJzkCpK3X7T5tHavjE3VIO/
	nViHQ+dQXxAujpnk9ImLzLe7wRbka+lTEm0wEftdXU4/CCBePrNfCfl1nMUUi2ghpfhn6Pk38IU
	PHYhumGSHdSgpXv4RYwEF4eP2eaZDU0oPCZ1O
X-Gm-Gg: ASbGncu9Ra8USipiAzqI/4oNl2gMGm0gXaiYFd4KlQelyvlDio40krRjYGvM6/BovKU
	74gRTiUjDDWV3v3LUJ+JJapUsKwJh0Xk9ZE3c2Q==
X-Google-Smtp-Source: AGHT+IEfL5IUbsjXFqe6Hh2JjYLBPuUpWQuaFonGGc6Jw1mEQyHRF/IMtrDtdgdZZdpOydtnswuAteCyGVj5IhFguPk=
X-Received: by 2002:a05:6402:510a:b0:5d2:60d9:a2ae with SMTP id
 4fb4d7f45d1cf-5d81de19afcmr30787843a12.33.1735551224469; Mon, 30 Dec 2024
 01:33:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295@epcas2p2.samsung.com>
 <20241203081247.1533534-1-youngmin.nam@samsung.com> <CANn89iK+7CKO31=3EvNo6-raUzyibwRRN8HkNXeqzuP9q8k_tA@mail.gmail.com>
 <CADVnQynUspJL4e3UnZTKps9WmgnE-0ngQnQmn=8gjSmyg4fQ5A@mail.gmail.com>
 <20241203181839.7d0ed41c@kernel.org> <Z0/O1ivIwiVVNRf0@perf>
 <CANn89iKms_9EX+wArf1FK7Cy3-Cr_ryX+MJ2YC8yt1xmvpY=Uw@mail.gmail.com>
 <Z1KRaD78T3FMffuX@perf> <CANn89iKOC9busc9G_akT=H45FvfVjWm97gmCyj=s7_zYJ43T3w@mail.gmail.com>
 <Z1K9WVykZbo6u7uG@perf> <CANn89i+BuU+1__zSWgjshFzfxFUttDEpn90V+p8+mVGCHidYAA@mail.gmail.com>
 <000001db4a23$746be360$5d43aa20$@samsung.com> <CANn89iLz=U2RW8S+Yy1WpFYb+dyyPR8TwbMpUUEeUpV9X2hYoA@mail.gmail.com>
 <000001db5136$336b1060$9a413120$@samsung.com> <CANn89iK8Kdpe_uZ2Q8z3k2=d=jUVCV5Z3hZa4jFedUgKm9hesQ@mail.gmail.com>
 <04f401db5a51$1f860810$5e921830$@samsung.com>
In-Reply-To: <04f401db5a51$1f860810$5e921830$@samsung.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 30 Dec 2024 10:33:33 +0100
Message-ID: <CANn89iK0g7uqduiAMZ0jax4_Y+P=0pJUArsd=LAhAHa2j+gRAg@mail.gmail.com>
Subject: Re: [PATCH] tcp: check socket state before calling WARN_ON
To: "Dujeong.lee" <dujeong.lee@samsung.com>
Cc: Youngmin Nam <youngmin.nam@samsung.com>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, davem@davemloft.net, dsahern@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, guo88.liu@samsung.com, 
	yiwang.cai@samsung.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	joonki.min@samsung.com, hajun.sung@samsung.com, d7271.choe@samsung.com, 
	sw.ju@samsung.com, iamyunsu.kim@samsung.com, kw0619.kim@samsung.com, 
	hsl.lim@samsung.com, hanbum22.lee@samsung.com, chaemoo.lim@samsung.com, 
	seungjin1.yu@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2024 at 1:24=E2=80=AFAM Dujeong.lee <dujeong.lee@samsung.co=
m> wrote:
>
> On Wed, Dec 18, 2024 7:28 PM Eric Dumazet <edumazet@google.com> wrote:
>
> > On Wed, Dec 18, 2024 at 11:18=E2=80=AFAM Dujeong.lee <dujeong.lee@samsu=
ng.com>
> > wrote:
> > >
> > > Tue, December 10, 2024 at 4:10 PM Dujeong Lee wrote:
> > > > On Tue, Dec 10, 2024 at 12:39 PM Dujeong Lee wrote:
> > > > > On Mon, Dec 9, 2024 at 7:21 PM Eric Dumazet <edumazet@google.com>
> > wrote:
> > > > > > On Mon, Dec 9, 2024 at 11:16=E2=80=AFAM Dujeong.lee
> > > > > > <dujeong.lee@samsung.com>
> > > > > > wrote:
> > > > > > >
> > > > > >
> > > > > > > Thanks for all the details on packetdrill and we are also
> > > > > > > exploring
> > > > > > USENIX 2013 material.
> > > > > > > I have one question. The issue happens when DUT receives TCP
> > > > > > > ack with
> > > > > > large delay from network, e.g., 28seconds since last Tx. Is
> > > > > > packetdrill able to emulate this network delay (or congestion)
> > > > > > in script
> > > > > level?
> > > > > >
> > > > > > Yes, the packetdrill scripts can wait an arbitrary amount of
> > > > > > time between each event
> > > > > >
> > > > > > +28 <next event>
> > > > > >
> > > > > > 28 seconds seems okay. If the issue was triggered after 4 days,
> > > > > > packetdrill would be impractical ;)
> > > > >
> > > > > Hi all,
> > > > >
> > > > > We secured new ramdump.
> > > > > Please find the below values with TCP header details.
> > > > >
> > > > > tp->packets_out =3D 0
> > > > > tp->sacked_out =3D 0
> > > > > tp->lost_out =3D 1
> > > > > tp->retrans_out =3D 1
> > > > > tp->rx_opt.sack_ok =3D 5 (tcp_is_sack(tp)) mss_cache =3D 1400
> > > > > ((struct inet_connection_sock *)sk)->icsk_ca_state =3D 4 ((struct
> > > > > inet_connection_sock *)sk)->icsk_pmtu_cookie =3D 1500
> > > > >
> > > > > Hex from ip header:
> > > > > 45 00 00 40 75 40 00 00 39 06 91 13 8E FB 2A CA C0 A8 00 F7 01 BB
> > > > > A7 CC 51
> > > > > F8 63 CC 52 59 6D A6 B0 10 04 04 77 76 00 00 01 01 08 0A 89 72 C8
> > > > > 42
> > > > > 62 F5
> > > > > F5 D1 01 01 05 0A 52 59 6D A5 52 59 6D A6
> > > > >
> > > > > Transmission Control Protocol
> > > > > Source Port: 443
> > > > > Destination Port: 42956
> > > > > TCP Segment Len: 0
> > > > > Sequence Number (raw): 1375232972
> > > > > Acknowledgment number (raw): 1381592486
> > > > > 1011 .... =3D Header Length: 44 bytes (11)
> > > > > Flags: 0x010 (ACK)
> > > > > Window: 1028
> > > > > Calculated window size: 1028
> > > > > Urgent Pointer: 0
> > > > > Options: (24 bytes), No-Operation (NOP), No-Operation (NOP),
> > > > > Timestamps, No-Operation (NOP), No-Operation (NOP), SACK
> > > > >
> > > > > If anyone wants to check other values, please feel free to ask me
> > > > >
> > > > > Thanks,
> > > > > Dujeong.
> > > >
> > > > I have a question.
> > > >
> > > > From the latest ramdump I could see that
> > > > 1) tcp_sk(sk)->packets_out =3D 0
> > > > 2) inet_csk(sk)->icsk_backoff =3D 0
> > > > 3) sk_write_queue.len =3D 0
> > > > which suggests that tcp_write_queue_purge was indeed called.
> > > >
> > > > Noting that:
> > > > 1) tcp_write_queue_purge reset packets_out to 0 and
> > > > 2) in_flight should be non-negative where in_flight =3D packets_out=
 -
> > > > left_out + retrans_out, what if we reset left_out and retrans_out a=
s
> > > > well in tcp_write_queue_purge?
> > > >
> > > > Do we see any potential issue with this?
> > >
> > > Hello Eric and Neal.
> > >
> > > It is a gentle reminder.
> > > Could you please review the latest ramdump values and and question?
> >
> > It will have to wait next year, Neal is OOO.
> >
> > I asked a packetdrill reproducer, I can not spend days working on an is=
sue
> > that does not trigger in our production hosts.
> >
> > Something could be wrong in your trees, or perhaps some eBPF program
> > changing the state of the socket...
>
> Hi Eric
>
> I tried to make packetdrill script for local mode, which injects delayed =
acks for data and FIN after close.
>
> // Test basic connection teardown where local process closes first:
> // the local process calls close() first, so we send a FIN.
> // Then we receive an delayed ACK for data and FIN.
> // Then we receive a FIN and ACK it.
>
> `../common/defaults.sh`
>     0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3                        =
       // Create socket
>    +.01...0.011 connect(3, ..., ...) =3D 0                               =
       // Initiate connection
>    +0 >  S 0:0(0) <...>                                                  =
     // Send SYN
>    +0 < S. 0:0(0) ack 1 win 32768 <mss 1000,nop,wscale 6,nop,nop,sackOK> =
     // Receive SYN-ACK with TCP options
>    +0 >  . 1:1(0) ack 1                                                  =
     // Send ACK
>
>    +0 write(3, ..., 1000) =3D 1000                                       =
       // Write 1000 bytes
>    +0 >  P. 1:1001(1000) ack 1                                           =
     // Send data with PSH flag
>
>    +0 close(3) =3D 0                                                     =
       // Local side initiates close
>    +0 >  F. 1001:1001(0) ack 1                                           =
     // Send FIN
>    +1 < . 1:1(0) ack 1001 win 257                                        =
      // Receive ACK for data
>    +0 < . 1:1(0) ack 1002 win 257                                        =
     // Receive ACK for FIN
>
>    +0 < F. 1:1(0) ack 1002 win 257                                       =
     // Receive FIN from remote
>    +0 >  . 1002:1002(0) ack 2                                            =
     // Send ACK for FIN
>
>
> But got below error when I run the script.
>
> $ sudo ./packetdrill ../tcp/close/close-half-delayed-ack.pkt
> ../tcp/close/close-half-delayed-ack.pkt:22: error handling packet: live p=
acket field tcp_fin: expected: 0 (0x0) vs actual: 1 (0x1)
> script packet:  1.010997 . 1002:1002(0) ack 2
> actual packet:  0.014840 F. 1001:1001(0) ack 1 win 256

This means the FIN was retransmited earlier.
Then the data segment was probably also retransmit.

You can use "tcpdump -i any &" while developing your script.

    0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
       // Create socket
   +.01...0.111 connect(3, ..., ...) =3D 0
       // Initiate connection
   +0 >  S 0:0(0) <...>
       // Send SYN
  +.1 < S. 0:0(0) ack 1 win 32768 <mss 1000,nop,wscale
6,nop,nop,sackOK>      // Receive SYN-ACK with TCP options
   +0 >  . 1:1(0) ack 1
       // Send ACK

   +0 write(3, ..., 1000) =3D 1000
       // Write 1000 bytes
   +0 >  P. 1:1001(1000) ack 1
       // Send data with PSH flag

   +0 close(3) =3D 0
       // Local side initiates close
   +0 >  F. 1001:1001(0) ack 1
       // Send FIN
  +.2 >  F. 1001:1001(0) ack 1    // FIN retransmit
+.2~+.4 >  P. 1:1001(1000) ack 1 // RTX

   +0 < . 1:1(0) ack 1001 win 257
        // Receive ACK for data
   +0 > F. 1001:1001(0) ack 1 // FIN retransmit
   +0 < . 1:1(0) ack 1002 win 257
       // Receive ACK for FIN

   +0 < F. 1:1(0) ack 1002 win 257
       // Receive FIN from remote
   +0 >  . 1002:1002(0) ack 2
       // Send ACK for FIN

