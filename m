Return-Path: <netdev+bounces-154681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAACA9FF6C1
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 09:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D88733A2489
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 08:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC56192B62;
	Thu,  2 Jan 2025 08:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bvKRMvo2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB9E1799B
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 08:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735805828; cv=none; b=lzyMW8/22/4bT9gOBA56wvef9O3k5w1wf8dxkzmnfGv0bXb9A3rRFuxfTQLnPXRb+4TZvSLyvsrcOGSg5nZwVnktA6jTXE9329Fi1RBXQWP3qi7BSpaqfktqjUQelOHpFXLNNNGbvghMf64Mwxo/A2sWDM62X45BjylIlnHIDiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735805828; c=relaxed/simple;
	bh=66NAGdikFNuw0RWcZOZ8O33OF77tkAWOj7KQu2ZQHEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3EPtjB9Gjn9A0fYWFMlYV7MOw+jy1WXuQvZuMb3+D5zd1x7ocX2kT1H8ncpsrqDZhPNqRxyVIf0+cq/O4J/FHwvdc2PfaqTucQ9IBrO9nIiWuRhvMgWpAoMGkCwgwd+msMi6cpPgOzrkEb/Tlqw8ikKJMd06c6SpGerw6DYCYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bvKRMvo2; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaef00ab172so1051461166b.3
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 00:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735805825; x=1736410625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/NmLVe4ej46uXLeYr0/31nN7cuR7x7VZxpuESk9o8o=;
        b=bvKRMvo2HbDqlUvxNiEddVw6D80QDOlzznVRz9LhAQo3ynB5mCuXTKBREL7WSm94Hp
         w9eDTveN5ZYf8ytHGAOxEGmzaDm0tvCI5KiNpgefRVyjn4LbjkX5R0XwRcKJ1sl0Vc8+
         wZohO3X7Kmx9/yfIURsuPHMdFJ2poBpPFeWM2eV57KZQVZ9Y+SAgKaE24mR4GR5zn7so
         zHiKQ3Y5CEuR9mH5zhi5TeK8PHUSI7cCuJ+ddXsQqccCZbgnfwBMZxAdlK/7enOyv4kJ
         JY2VtinoNLZy7d+/KIW17XP6x9MRsDyHQVoP2VwAudzTbRmD2kXrA+8ocCjBQ09enqIJ
         SOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735805825; x=1736410625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/NmLVe4ej46uXLeYr0/31nN7cuR7x7VZxpuESk9o8o=;
        b=vbq9bblMVpLuqoxGh4gPs0AoIcNYqwI4N3FNvMVPnZcKqFkO1GYHVmAE4oruinaRSX
         0vzlAbmt/UWQ/nYJCJ6WT6FdnF07lrBbTpfu74Y5JvS5ThTqiMvH0pBPp7h68p4C3PSw
         mWe8IFsTcBZJvQLvIkts/kWzvLTX38lD3hok5C6SZYmgUz6RnCB/OCAmFk9P8s7seKkM
         5e0MV6Fkr8jgOnsI6+SMnAl+kJ/s1EtIwyasFPP3bfdtGJGqH70gIcGdCk1E9pOBadjl
         IpQEBeR09f6hiyRag7m2+TWzibBcUXyN8Vd3RWm8kWoIFq6BW6Hej7u6ce90TLDD6ear
         wbyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZiS3JB20YOD72nYT6StKSmZAUN4b2Zkmz60se1wS2orpADaV5EWC6ZXA0qIVCa0GRCjonBXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Py54VrMMqCI1lo3tcVpLHwFy7rD0ymAxmWU1Fclj0yeXn+XH
	MD0m5A3PCWT1fYvx+Hh9r8LWpJbNgVhPUWtDHam6cD0a11j6PKYRLTr7YuqC34VdrsNGOoi9W+8
	j1F4uEK+336Sx/VhBuViPlLjgW7YLHXtOKj14
X-Gm-Gg: ASbGncvsGzT1fRHhdY1V/aJNp8mtqS/vG7F8Qh7z2L9st9bHU+gJ8zbXhlTdzr0LSZp
	ClZnKf/zIEexl6MJgceXcZYbnVmmXrp+vNRs=
X-Google-Smtp-Source: AGHT+IEc91yIGlsmKUdVj1zdZi8H6cWbaA1HUD0q8RojqkOxOLTCCuWwRwmBu91GAlPDs5lJGiGUr9thSB0MIRa12RQ=
X-Received: by 2002:a05:6402:2802:b0:5d3:cff5:635e with SMTP id
 4fb4d7f45d1cf-5d81de065b8mr105666727a12.26.1735805824527; Thu, 02 Jan 2025
 00:17:04 -0800 (PST)
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
 <04f401db5a51$1f860810$5e921830$@samsung.com> <CANn89iK0g7uqduiAMZ0jax4_Y+P=0pJUArsd=LAhAHa2j+gRAg@mail.gmail.com>
 <088701db5cac$71301b30$53905190$@samsung.com>
In-Reply-To: <088701db5cac$71301b30$53905190$@samsung.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 2 Jan 2025 09:16:53 +0100
Message-ID: <CANn89iJCYaLuHHt4umWzUHCXHLHtdwThz3uuQ9vFbG9_=eibdg@mail.gmail.com>
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

On Thu, Jan 2, 2025 at 1:22=E2=80=AFAM Dujeong.lee <dujeong.lee@samsung.com=
> wrote:
>
> On Mon, Dec 30, 2024 at 6:34 PM Eric Dumazet <edumazet@google.com>
> wrote:
> >
> > On Mon, Dec 30, 2024 at 1:24=E2=80=AFAM Dujeong.lee <dujeong.lee@samsun=
g.com>
> > wrote:
> > >
> > > On Wed, Dec 18, 2024 7:28 PM Eric Dumazet <edumazet@google.com> wrote=
:
> > >
> > > > On Wed, Dec 18, 2024 at 11:18=E2=80=AFAM Dujeong.lee
> > > > <dujeong.lee@samsung.com>
> > > > wrote:
> > > > >
> > > > > Tue, December 10, 2024 at 4:10 PM Dujeong Lee wrote:
> > > > > > On Tue, Dec 10, 2024 at 12:39 PM Dujeong Lee wrote:
> > > > > > > On Mon, Dec 9, 2024 at 7:21 PM Eric Dumazet
> > > > > > > <edumazet@google.com>
> > > > wrote:
> > > > > > > > On Mon, Dec 9, 2024 at 11:16=E2=80=AFAM Dujeong.lee
> > > > > > > > <dujeong.lee@samsung.com>
> > > > > > > > wrote:
> > > > > > > > >
> > > > > > > >
> > > > > > > > > Thanks for all the details on packetdrill and we are also
> > > > > > > > > exploring
> > > > > > > > USENIX 2013 material.
> > > > > > > > > I have one question. The issue happens when DUT receives
> > > > > > > > > TCP ack with
> > > > > > > > large delay from network, e.g., 28seconds since last Tx. Is
> > > > > > > > packetdrill able to emulate this network delay (or
> > > > > > > > congestion) in script
> > > > > > > level?
> > > > > > > >
> > > > > > > > Yes, the packetdrill scripts can wait an arbitrary amount o=
f
> > > > > > > > time between each event
> > > > > > > >
> > > > > > > > +28 <next event>
> > > > > > > >
> > > > > > > > 28 seconds seems okay. If the issue was triggered after 4
> > > > > > > > days, packetdrill would be impractical ;)
> > > > > > >
> > > > > > > Hi all,
> > > > > > >
> > > > > > > We secured new ramdump.
> > > > > > > Please find the below values with TCP header details.
> > > > > > >
> > > > > > > tp->packets_out =3D 0
> > > > > > > tp->sacked_out =3D 0
> > > > > > > tp->lost_out =3D 1
> > > > > > > tp->retrans_out =3D 1
> > > > > > > tp->rx_opt.sack_ok =3D 5 (tcp_is_sack(tp)) mss_cache =3D 1400
> > > > > > > ((struct inet_connection_sock *)sk)->icsk_ca_state =3D 4
> > > > > > > ((struct inet_connection_sock *)sk)->icsk_pmtu_cookie =3D 150=
0
> > > > > > >
> > > > > > > Hex from ip header:
> > > > > > > 45 00 00 40 75 40 00 00 39 06 91 13 8E FB 2A CA C0 A8 00 F7 0=
1
> > > > > > > BB
> > > > > > > A7 CC 51
> > > > > > > F8 63 CC 52 59 6D A6 B0 10 04 04 77 76 00 00 01 01 08 0A 89 7=
2
> > > > > > > C8
> > > > > > > 42
> > > > > > > 62 F5
> > > > > > > F5 D1 01 01 05 0A 52 59 6D A5 52 59 6D A6
> > > > > > >
> > > > > > > Transmission Control Protocol
> > > > > > > Source Port: 443
> > > > > > > Destination Port: 42956
> > > > > > > TCP Segment Len: 0
> > > > > > > Sequence Number (raw): 1375232972 Acknowledgment number (raw)=
:
> > > > > > > 1381592486
> > > > > > > 1011 .... =3D Header Length: 44 bytes (11)
> > > > > > > Flags: 0x010 (ACK)
> > > > > > > Window: 1028
> > > > > > > Calculated window size: 1028
> > > > > > > Urgent Pointer: 0
> > > > > > > Options: (24 bytes), No-Operation (NOP), No-Operation (NOP),
> > > > > > > Timestamps, No-Operation (NOP), No-Operation (NOP), SACK
> > > > > > >
> > > > > > > If anyone wants to check other values, please feel free to as=
k
> > > > > > > me
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Dujeong.
> > > > > >
> > > > > > I have a question.
> > > > > >
> > > > > > From the latest ramdump I could see that
> > > > > > 1) tcp_sk(sk)->packets_out =3D 0
> > > > > > 2) inet_csk(sk)->icsk_backoff =3D 0
> > > > > > 3) sk_write_queue.len =3D 0
> > > > > > which suggests that tcp_write_queue_purge was indeed called.
> > > > > >
> > > > > > Noting that:
> > > > > > 1) tcp_write_queue_purge reset packets_out to 0 and
> > > > > > 2) in_flight should be non-negative where in_flight =3D
> > > > > > packets_out - left_out + retrans_out, what if we reset left_out
> > > > > > and retrans_out as well in tcp_write_queue_purge?
> > > > > >
> > > > > > Do we see any potential issue with this?
> > > > >
> > > > > Hello Eric and Neal.
> > > > >
> > > > > It is a gentle reminder.
> > > > > Could you please review the latest ramdump values and and questio=
n?
> > > >
> > > > It will have to wait next year, Neal is OOO.
> > > >
> > > > I asked a packetdrill reproducer, I can not spend days working on a=
n
> > > > issue that does not trigger in our production hosts.
> > > >
> > > > Something could be wrong in your trees, or perhaps some eBPF progra=
m
> > > > changing the state of the socket...
> > >
> > > Hi Eric
> > >
> > > I tried to make packetdrill script for local mode, which injects dela=
yed
> > acks for data and FIN after close.
> > >
> > > // Test basic connection teardown where local process closes first:
> > > // the local process calls close() first, so we send a FIN.
> > > // Then we receive an delayed ACK for data and FIN.
> > > // Then we receive a FIN and ACK it.
> > >
> > > `../common/defaults.sh`
> > >     0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3                    =
           //
> > Create socket
> > >    +.01...0.011 connect(3, ..., ...) =3D 0                           =
           //
> > Initiate connection
> > >    +0 >  S 0:0(0) <...>                                              =
         // Send
> > SYN
> > >    +0 < S. 0:0(0) ack 1 win 32768 <mss 1000,nop,wscale 6,nop,nop,sack=
OK>
> > // Receive SYN-ACK with TCP options
> > >    +0 >  . 1:1(0) ack 1                                              =
         // Send
> > ACK
> > >
> > >    +0 write(3, ..., 1000) =3D 1000                                   =
           //
> > Write 1000 bytes
> > >    +0 >  P. 1:1001(1000) ack 1                                       =
         // Send
> > data with PSH flag
> > >
> > >    +0 close(3) =3D 0                                                 =
           // Local
> > side initiates close
> > >    +0 >  F. 1001:1001(0) ack 1                                       =
         // Send
> > FIN
> > >    +1 < . 1:1(0) ack 1001 win 257                                    =
          //
> > Receive ACK for data
> > >    +0 < . 1:1(0) ack 1002 win 257                                    =
         //
> > Receive ACK for FIN
> > >
> > >    +0 < F. 1:1(0) ack 1002 win 257                                   =
         //
> > Receive FIN from remote
> > >    +0 >  . 1002:1002(0) ack 2                                        =
         // Send
> > ACK for FIN
> > >
> > >
> > > But got below error when I run the script.
> > >
> > > $ sudo ./packetdrill ../tcp/close/close-half-delayed-ack.pkt
> > > ../tcp/close/close-half-delayed-ack.pkt:22: error handling packet:
> > > live packet field tcp_fin: expected: 0 (0x0) vs actual: 1 (0x1) scrip=
t
> > > packet:  1.010997 . 1002:1002(0) ack 2 actual packet:  0.014840 F.
> > > 1001:1001(0) ack 1 win 256
> >
> > This means the FIN was retransmited earlier.
> > Then the data segment was probably also retransmit.
> >
> > You can use "tcpdump -i any &" while developing your script.
> >
> >     0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
> >        // Create socket
> >    +.01...0.111 connect(3, ..., ...) =3D 0
> >        // Initiate connection
> >    +0 >  S 0:0(0) <...>
> >        // Send SYN
> >   +.1 < S. 0:0(0) ack 1 win 32768 <mss 1000,nop,wscale
> > 6,nop,nop,sackOK>      // Receive SYN-ACK with TCP options
> >    +0 >  . 1:1(0) ack 1
> >        // Send ACK
> >
> >    +0 write(3, ..., 1000) =3D 1000
> >        // Write 1000 bytes
> >    +0 >  P. 1:1001(1000) ack 1
> >        // Send data with PSH flag
> >
> >    +0 close(3) =3D 0
> >        // Local side initiates close
> >    +0 >  F. 1001:1001(0) ack 1
> >        // Send FIN
> >   +.2 >  F. 1001:1001(0) ack 1    // FIN retransmit
> > +.2~+.4 >  P. 1:1001(1000) ack 1 // RTX
> >
> >    +0 < . 1:1(0) ack 1001 win 257
> >         // Receive ACK for data
> >    +0 > F. 1001:1001(0) ack 1 // FIN retransmit
> >    +0 < . 1:1(0) ack 1002 win 257
> >        // Receive ACK for FIN
> >
> >    +0 < F. 1:1(0) ack 1002 win 257
> >        // Receive FIN from remote
> >    +0 >  . 1002:1002(0) ack 2
> >        // Send ACK for FIN
>
> Hi Eric,
>
> I modified the script and inlined tcpdump capture
>
> `../common/defaults.sh`
>     0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3                        =
       // Create socket
>    +.01...0.011 connect(3, ..., ...) =3D 0                               =
       // Initiate connection
>    +0 >  S 0:0(0) <...>                                                  =
     // Send SYN
> 1 0.000000 192.168.114.235 192.0.2.1 TCP 80 40784 =E2=86=92 8080 [SYN] Se=
q=3D0 Win=3D65535 Len=3D0 MSS=3D1460 SACK_PERM TSval=3D2913446377 TSecr=3D0=
 WS=3D256
>
>    +0 < S. 0:0(0) ack 1 win 32768 <mss 1000,nop,wscale 6,nop,nop,sackOK> =
     // Receive SYN-ACK with TCP options
> 2 0.000209 192.0.2.1 192.168.114.235 TCP 72 8080 =E2=86=92 40784 [SYN, AC=
K] Seq=3D0 Ack=3D1 Win=3D32768 Len=3D0 MSS=3D1000 WS=3D64 SACK_PERM
>
>    +0 >  . 1:1(0) ack 1                                                  =
     // Send ACK
> 3 0.000260 192.168.114.235 192.0.2.1 TCP 60 40784 =E2=86=92 8080 [ACK] Se=
q=3D1 Ack=3D1 Win=3D65536 Len=3D0
>
>    +0 write(3, ..., 1000) =3D 1000                                       =
       // Write 1000 bytes
>    +0 >  P. 1:1001(1000) ack 1                                           =
     // Send data with PSH flag
> 4 0.000344 192.168.114.235 192.0.2.1 TCP 1060 40784 =E2=86=92 8080 [PSH, =
ACK] Seq=3D1 Ack=3D1 Win=3D65536 Len=3D1000
>
>    +0 close(3) =3D 0                                                     =
       // Local side initiates close
>    +0 >  F. 1001:1001(0) ack 1                                           =
     // Send FIN
> 5 0.000381 192.168.114.235 192.0.2.1 TCP 60 40784 =E2=86=92 8080 [FIN, AC=
K] Seq=3D1001 Ack=3D1 Win=3D65536 Len=3D0
>
>    +.2 >  F. 1001:1001(0) ack 1                                          =
     // FIN retransmit
> 6 0.004545 192.168.114.235 192.0.2.1 TCP 60 [TCP Retransmission] 40784 =
=E2=86=92 8080 [FIN, ACK] Seq=3D1001 Ack=3D1 Win=3D65536 Len=3D0
>
>    +.2~+.4 >  P. 1:1001(1000) ack 1                                      =
     // RTX
>    +0 < . 1:1(0) ack 1001 win 257                                        =
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
> And hit below error.
> ../tcp/close/close-half-delayed-ack.pkt:18: error handling packet: timing=
 error: expected outbound packet at 0.210706 sec but happened at 0.014838 s=
ec; tolerance 0.025002 sec
> script packet:  0.210706 F. 1001:1001(0) ack 1
> actual packet:  0.014838 F. 1001:1001(0) ack 1 win 256
>
> For me, it looks like delay in below line does not take effect by packetd=
rill.
> +.2 >  F. 1001:1001(0) ack 1                                             =
  // FIN retransmit

I think you misunderstood how packetdrill works.

In packetdrill, you can specify delays for incoming packets (to
account for network delays, or remote TCP stack bugs/behavior)

But outgoing packets are generated by the kernel TCP stack.
Packetdrill checks that these packets have the expected layouts and
sent at the expected time.

