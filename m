Return-Path: <netdev+bounces-152879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 202CA9F62F3
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB90D7A3A3A
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 10:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C181A23AB;
	Wed, 18 Dec 2024 10:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SNqnne0R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2621A2390
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734517693; cv=none; b=B3B55AQM95kEWeQTbF5v7VZpMXAPkGl8fbgsCfXS/g5J7Tn95zq1q22aTFr/QQRv7/eDLn19obsoXN730tUEedlGAZWqfq2lHm7nSemPxM/DDoL+cji9BWzZL0h8cKu5hAT/WNIw6/RyQoJlC/xOCoPHHILYBoJmT4Px5aW2EHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734517693; c=relaxed/simple;
	bh=xWEGBBMZlrnPHnIAxIg1D5H/4U2KnkKtU7jD9UwTCWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hLrNBC3AfuN+vjAKpU+m2HbrfkDYQpT3shfS6nMC4eHXPkspb37MdVIxUgbwDY1UCDWs9W3hp1QWi924XU6Y8D82IBLpA2CzPybObvsr15JNDWZLrQkf8SymRxPPC3ivhHpxrWcj8hFCiSNM93FRdcrDwhn4TcYsiLfUAaMMit8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SNqnne0R; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3e6f6cf69so3565315a12.1
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 02:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734517690; x=1735122490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWEGBBMZlrnPHnIAxIg1D5H/4U2KnkKtU7jD9UwTCWY=;
        b=SNqnne0RS0QFdXKscFHrhvDzeK1kewkt0Gn5tPNpqc+/xJJZGmvBljJOhjJyZcZrFi
         V2k7YT8aIuwx+SurGCg9b0IJkn3HHG1k/8n63v70Q+r58SeXYYBeMecNzrE9Q0+cjzGo
         S5e1bKF5wY/y9X3PaHlk2Gf51YwydzRbL2XRjuH/kHdCdWlzxMHEe2bDzfeiNrjaQYWL
         uIIbNiaf+37Lq8yS0vaCzqSQJIoPuGi/UwL0cZQvqGGLjbzEtWM5vQQL7ciw+Geuh0of
         Q9K5p6tD+qep2HazbNqjSMtqvjyLOQrjy6StboiqhaNXAW8yfhY88oHkkDksYIt6b4Yb
         OxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734517690; x=1735122490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWEGBBMZlrnPHnIAxIg1D5H/4U2KnkKtU7jD9UwTCWY=;
        b=qQGbAg8dED7jZgUShQezM5OCtnUzaU2NNI6hRMJdWEmnpoL8sSmQZq0daUaKxtCWtS
         lXGDmAS7hqFQx+rC3qhwbbMhQDrzz8YNrG/C1NCo0u8mhaAvw29vUpSpcGQedykEj+Yy
         5tndWEto2dKbFP31Nd6vC7JE8yl6qC9kCM2lQrCpSZpHHlpUmTe58tLKYFEe4pixS6Vu
         Tas9BRkncDuGNOwsxul9RolOCAsUHaVgz/n2Hpo+YIKxwFFY18KlDYWWbBMEDaeV/XLl
         OhZ0ufq+VNCBGxD5mJSq/ywRZOFdZnmC27gIFoSg7aRj0eWDvq7kbG7J+E2El0SEWC3H
         jbDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd4L9JrbdwG+ui6hNJT/peWGIUGIV/O6rY4JZIeZqyJJizUNlGB1S6HSrkDKUKZmncm9V7ORw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrST4T8sWuDhZQXjVsSN0qdJBzI/akYuBA07QVHGEwH3NQgiCi
	OpVqAYg8JFOejLkkTK4mcC6Hnd3R9mRVWNmgob1QujcUoSXVamRrYLbf1g3gzXPmRngN8nO+fI8
	YveUet+KIrPMtzezj5gdSas8LD28yDQmRFLDo
X-Gm-Gg: ASbGncvjtqI7xIlt+LeuKTp6NbYTLP2SZKEGbBDDGZ+y+CeItsupUHTcvRD20+VQLuk
	E6Wl5Hs+NJi41dgH1ugogXkx2YAbKz6kHeow2Pbz0JKXThyykXXgf7sVlbOYI1+f8f7ni6zI=
X-Google-Smtp-Source: AGHT+IGl0ofl/X8Pt3OgAOoAtvL9aND7aGB7sDTB0qbEW9hssXgCsNN3fJOA8M3zaFbNLUjZLtwRrPZ3Zgfq4F4QcrA=
X-Received: by 2002:a05:6402:524d:b0:5cf:bcaf:98ec with SMTP id
 4fb4d7f45d1cf-5d7ee3f54f7mr2335896a12.26.1734517689880; Wed, 18 Dec 2024
 02:28:09 -0800 (PST)
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
 <000001db5136$336b1060$9a413120$@samsung.com>
In-Reply-To: <000001db5136$336b1060$9a413120$@samsung.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 18 Dec 2024 11:27:58 +0100
Message-ID: <CANn89iK8Kdpe_uZ2Q8z3k2=d=jUVCV5Z3hZa4jFedUgKm9hesQ@mail.gmail.com>
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

On Wed, Dec 18, 2024 at 11:18=E2=80=AFAM Dujeong.lee <dujeong.lee@samsung.c=
om> wrote:
>
> Tue, December 10, 2024 at 4:10 PM Dujeong Lee wrote:
> > On Tue, Dec 10, 2024 at 12:39 PM Dujeong Lee wrote:
> > > On Mon, Dec 9, 2024 at 7:21 PM Eric Dumazet <edumazet@google.com> wro=
te:
> > > > On Mon, Dec 9, 2024 at 11:16=E2=80=AFAM Dujeong.lee
> > > > <dujeong.lee@samsung.com>
> > > > wrote:
> > > > >
> > > >
> > > > > Thanks for all the details on packetdrill and we are also
> > > > > exploring
> > > > USENIX 2013 material.
> > > > > I have one question. The issue happens when DUT receives TCP ack
> > > > > with
> > > > large delay from network, e.g., 28seconds since last Tx. Is
> > > > packetdrill able to emulate this network delay (or congestion) in
> > > > script
> > > level?
> > > >
> > > > Yes, the packetdrill scripts can wait an arbitrary amount of time
> > > > between each event
> > > >
> > > > +28 <next event>
> > > >
> > > > 28 seconds seems okay. If the issue was triggered after 4 days,
> > > > packetdrill would be impractical ;)
> > >
> > > Hi all,
> > >
> > > We secured new ramdump.
> > > Please find the below values with TCP header details.
> > >
> > > tp->packets_out =3D 0
> > > tp->sacked_out =3D 0
> > > tp->lost_out =3D 1
> > > tp->retrans_out =3D 1
> > > tp->rx_opt.sack_ok =3D 5 (tcp_is_sack(tp)) mss_cache =3D 1400
> > > ((struct inet_connection_sock *)sk)->icsk_ca_state =3D 4 ((struct
> > > inet_connection_sock *)sk)->icsk_pmtu_cookie =3D 1500
> > >
> > > Hex from ip header:
> > > 45 00 00 40 75 40 00 00 39 06 91 13 8E FB 2A CA C0 A8 00 F7 01 BB A7
> > > CC 51
> > > F8 63 CC 52 59 6D A6 B0 10 04 04 77 76 00 00 01 01 08 0A 89 72 C8 42
> > > 62 F5
> > > F5 D1 01 01 05 0A 52 59 6D A5 52 59 6D A6
> > >
> > > Transmission Control Protocol
> > > Source Port: 443
> > > Destination Port: 42956
> > > TCP Segment Len: 0
> > > Sequence Number (raw): 1375232972
> > > Acknowledgment number (raw): 1381592486
> > > 1011 .... =3D Header Length: 44 bytes (11)
> > > Flags: 0x010 (ACK)
> > > Window: 1028
> > > Calculated window size: 1028
> > > Urgent Pointer: 0
> > > Options: (24 bytes), No-Operation (NOP), No-Operation (NOP),
> > > Timestamps, No-Operation (NOP), No-Operation (NOP), SACK
> > >
> > > If anyone wants to check other values, please feel free to ask me
> > >
> > > Thanks,
> > > Dujeong.
> >
> > I have a question.
> >
> > From the latest ramdump I could see that
> > 1) tcp_sk(sk)->packets_out =3D 0
> > 2) inet_csk(sk)->icsk_backoff =3D 0
> > 3) sk_write_queue.len =3D 0
> > which suggests that tcp_write_queue_purge was indeed called.
> >
> > Noting that:
> > 1) tcp_write_queue_purge reset packets_out to 0 and
> > 2) in_flight should be non-negative where in_flight =3D packets_out -
> > left_out + retrans_out, what if we reset left_out and retrans_out as we=
ll
> > in tcp_write_queue_purge?
> >
> > Do we see any potential issue with this?
>
> Hello Eric and Neal.
>
> It is a gentle reminder.
> Could you please review the latest ramdump values and and question?

It will have to wait next year, Neal is OOO.

I asked a packetdrill reproducer, I can not spend days working on an
issue that does not trigger in our production hosts.

Something could be wrong in your trees, or perhaps some eBPF program
changing the state of the socket...

