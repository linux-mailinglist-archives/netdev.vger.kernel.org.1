Return-Path: <netdev+bounces-172699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DE8A55C08
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B3B168BFB
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823A4610B;
	Fri,  7 Mar 2025 00:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9E7bUNc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACED3FF1;
	Fri,  7 Mar 2025 00:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741307557; cv=none; b=nKoPuc/8p9iVXdAxPa414HzJrEQpcuybh7ywF+25126NBXrEzn4vpsqWKQmvPw/UysigJ1nhesvMvJK/c+AjgzsLPzZvU0Bfcj5qmcKH8QSZXLBh6IuwLwCZVl6MqBOtC/r5+Xef/liGH6Uf1w16+DWnt9btw0+QejlvCYUR9NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741307557; c=relaxed/simple;
	bh=yeHroJuorqC9iv59/qhkFcftHF9SZ5knCvXTDkc+qCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAh3jZYONa5llJxDeNx8YxZ3D5KDNYoMZPWLP4EvaxqqAp9vCS8pqsuNk5YPpgpTD8arwS/etiH27/3kTnypl9HmboijAJ++AQibuupNEpKivxw1xd20LwOMKEWAPjkrG3NnDY7J4GVyqt58MgG2mlJmvKX4WpkweKZl29wGMxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9E7bUNc; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d43bb5727fso3908245ab.1;
        Thu, 06 Mar 2025 16:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741307554; x=1741912354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3Sup5qJO3qw7gpO+9tSvFrA+y2TmJev5Uqf9lLAcqs=;
        b=U9E7bUNc/twbuVEC9ORQU377dG88Rf4s15BKe9gCulCAswZ5qH8pjsgpFC4/Dt+5qc
         fKBLGEvSOBcbMPXMyyP8jsTpN4tALleVZbm/WB2I6TjrmUhCbcB9nJreAHWayrcbxjYK
         cwz6njDaIVpy0DkQFOsN1hz1UJNHg3iyZCN2vT7aT10c8ZiTdpGoBzhXCW+J5dEYuMKU
         BEohtK50M4jVbiBZivUbRVeQcWwhELZFSBrm4541FDbrXgdxALLU6NRFGC0cOXETYvrv
         Cdl5StSoov90jeSMun7ehxDYXxmITYGhal60BURNj7SjkNdWbD8pkBjD3aAfzxl8FUQ6
         5PlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741307554; x=1741912354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3Sup5qJO3qw7gpO+9tSvFrA+y2TmJev5Uqf9lLAcqs=;
        b=PQ4HT4fjLqPwhT6YBQfZELBkx/s5T57QVES5gKDYhiAgYbKe0dpw84J5++dI9vTqjb
         C5x2/7NWYpa/MMLxOHZqbSWpouruNXi4QoCDZjlJ5K7+iy3LX9JmfZvQat1QEU+wy507
         D7bsrLjvJUQAkn5i2tfQlKIfMrDKH/1/Pt3lvFWfJuz+9brD62MAy/N+gH7FRBPOrG8G
         qS1wUT4K978QOZ4v02Sp1ElvouOuiRqLEa6Af5Kyccorsg7lMNQR3kzRdx8aNylpaDx4
         gL3qX7yA+6SwwMw01pz5aEo2xLrBBB88bsfpCKCyXiY5kbXEfG6eyk1n+sDKWIuNpYrp
         Fn9w==
X-Forwarded-Encrypted: i=1; AJvYcCWlACerPgJt16H0MDu03UuMowGlhymzYCPr7eH4b5yn08jCXso1zB7jaGDj8VvbG/WudEKrHSWd4Z8/6BA=@vger.kernel.org, AJvYcCWrhycmvmuJFIxR5tDgXH+tkibkaXf4tlkDoxKkYNFc2YpLAxck9UPxSx/4MnlbvKhcjEVDM8/L@vger.kernel.org
X-Gm-Message-State: AOJu0YxFb2Fh71i0ZFgSwz5lzJ3LA0EpiTQtueVrsFbm6JJFJ8p9fiOR
	Y3ht+JaYx4WbgGQ25Y03NWOwy0pgrihncXNRAJxu9nG8WvnNTIsh21eCNzWKx9KYLF8LW010t+J
	1qWntF9wVMB6LqyAHHTRW50ttEuQ=
X-Gm-Gg: ASbGncvnJhLnrcS0Yf9qdNy5XA8xf7YxcSywMT+7sGNn2zDA9KN2xtdvJ7oFl80dAfI
	5Af6hODPyePrT+pHZhTP7+r55/eu9otzxtsko7rjnN0x2SvlYlsUy5vkScNxdrI4cVpcCw2Ztn5
	XeVzKFChsuYOC+QvNsgBqHH7qu
X-Google-Smtp-Source: AGHT+IEh2dbYwm4iLN8sq6X/wCxXJcNeuxBtXInN8JeCnK9EITMqRDB7bkIAOcdnlblpCsOvclxm8RrPAhjc+SlOAO8=
X-Received: by 2002:a05:6e02:164a:b0:3d0:235b:4810 with SMTP id
 e9e14a558f8ab-3d4418d50e2mr21827055ab.2.1741307553861; Thu, 06 Mar 2025
 16:32:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305-net-next-fix-tcp-win-clamp-v1-1-12afb705d34e@kernel.org>
 <CAL+tcoAqZmeV0-4rjH-EPmhBBaS=ZSwgcXhU8ZsBCr_aXS3Lqw@mail.gmail.com>
 <CANn89iLqgi5byZd+Si7jTdg7zrLNn13ejWAQjMRurvrQPeg3zg@mail.gmail.com> <CAL+tcoDH0DAWmvYR2RFPtWimq8MW8a1CRdoaTSABpS-OTx_L+w@mail.gmail.com>
In-Reply-To: <CAL+tcoDH0DAWmvYR2RFPtWimq8MW8a1CRdoaTSABpS-OTx_L+w@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 7 Mar 2025 08:31:57 +0800
X-Gm-Features: AQ5f1JrEBEKQoQu65o4Jf2jJo6otydaX4bSK3wpP2Kyj981A7kdWQVyArK7okBw
Message-ID: <CAL+tcoDSf9AQv5h-EB9mSdLqBP7W63Eejh+4PYOSiVATGa-Mgg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: clamp window like before the cleanup
To: Eric Dumazet <edumazet@google.com>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 7:18=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Thu, Mar 6, 2025 at 5:45=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Thu, Mar 6, 2025 at 6:22=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> > >
> > > On Wed, Mar 5, 2025 at 10:49=E2=80=AFPM Matthieu Baerts (NGI0)
> > > <matttbe@kernel.org> wrote:
> > > >
> > > > A recent cleanup changed the behaviour of tcp_set_window_clamp(). T=
his
> > > > looks unintentional, and affects MPTCP selftests, e.g. some tests
> > > > re-establishing a connection after a disconnect are now unstable.
> > > >
> > > > Before the cleanup, this operation was done:
> > > >
> > > >   new_rcv_ssthresh =3D min(tp->rcv_wnd, new_window_clamp);
> > > >   tp->rcv_ssthresh =3D max(new_rcv_ssthresh, tp->rcv_ssthresh);
> > > >
> > > > The cleanup used the 'clamp' macro which takes 3 arguments -- value=
,
> > > > lowest, and highest -- and returns a value between the lowest and t=
he
> > > > highest allowable values. This then assumes ...
> > > >
> > > >   lowest (rcv_ssthresh) <=3D highest (rcv_wnd)
> > > >
> > > > ... which doesn't seem to be always the case here according to the =
MPTCP
> > > > selftests, even when running them without MPTCP, but only TCP.
> > > >
> > > > For example, when we have ...
> > > >
> > > >   rcv_wnd < rcv_ssthresh < new_rcv_ssthresh
> > > >
> > > > ... before the cleanup, the rcv_ssthresh was not changed, while aft=
er
> > > > the cleanup, it is lowered down to rcv_wnd (highest).
> > > >
> > > > During a simple test with TCP, here are the values I observed:
> > > >
> > > >   new_window_clamp (val)  rcv_ssthresh (lo)  rcv_wnd (hi)
> > > >       117760   (out)         65495         <  65536
> > > >       128512   (out)         109595        >  80256  =3D> lo > hi
> > > >       1184975  (out)         328987        <  329088
> > > >
> > > >       113664   (out)         65483         <  65536
> > > >       117760   (out)         110968        <  110976
> > > >       129024   (out)         116527        >  109696 =3D> lo > hi
> > > >
> > > > Here, we can see that it is not that rare to have rcv_ssthresh (lo)
> > > > higher than rcv_wnd (hi), so having a different behaviour when the
> > > > clamp() macro is used, even without MPTCP.
> > > >
> > > > Note: new_window_clamp is always out of range (rcv_ssthresh < rcv_w=
nd)
> > > > here, which seems to be generally the case in my tests with small
> > > > connections.
> > > >
> > > > I then suggests reverting this part, not to change the behaviour.
> > > >
> > > > Fixes: 863a952eb79a ("tcp: tcp_set_window_clamp() cleanup")
> > > > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/551
> > > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > >
> > > Tested-by: Jason Xing <kerneljasonxing@gmail.com>
> > >
> > > Thanks for catching this. I should have done more tests :(
> > >
> > > Now I use netperf with TCP_CRR to test loopback and easily see the
> > > case where tp->rcv_ssthresh is larger than tp->rcv_wnd, which means
> > > tp->rcv_wnd is not the upper bound as you said.
> > >
> > > Thanks,
> > > Jason
> > >
> >
> > Patch looks fine to me but all our tests are passing with the current k=
ernel,
> > and I was not able to trigger the condition.
> >
> > Can you share what precise test you did ?
> >
> > Thanks !
>
> I did the test[1] on the virtual machine running the kernel [2]. And
> after seeing your reply, I checked out a clean branch and compiled the
> kernel with the patch reverted again and rebooted. The case can still
> be reliably reproduced in my machine. Here are some outputs from BPF
> program[3]:
>  sudo bpftrace tcp_cap.bt.2
> Attaching 1 probe...
> 4327813, 4326775, 4310912
> netperf
>         tcp_set_window_clamp+1
>         tcp_data_queue+1744
>         tcp_rcv_established+501
>         tcp_v4_do_rcv+369
>         tcp_v4_rcv+4800
>         ip_protocol_deliver_rcu+65
>
> 4327813, 4326827, 4310912
> netperf
>         tcp_set_window_clamp+1
>         tcp_data_queue+1744
>         tcp_rcv_established+501
>         tcp_v4_do_rcv+369
>         tcp_v4_rcv+4800
>         ip_protocol_deliver_rcu+65
>
> 418081, 417052, 417024
> swapper/11
>         tcp_set_window_clamp+1
>         tcp_data_queue+1744
>         tcp_rcv_established+501
>         tcp_v4_do_rcv+369
>         tcp_v4_rcv+4800
>         ip_protocol_deliver_rcu+65
>

Hi Eric, Matthieu

I did a quick analysis on this case. It turned out that
__release_sock() was dealing with skbs in sk_backlog one by one, then:
1) one skb went into tcp_grow_window(). At the beginning, rcv_ssthresh
is equal to rcv_wnd, but later rcv_ssthresh will increase by 'incr',
which means updated rcv_ssthresh is larger than rcv_wnd.
2) another skb went into tcp_set_window_clamp(), as I saw yesterday,
the issue happened: rcv_ssthresh > rcv_wnd.

As to the rcv_wnd, in synchronised states, it can be only
changed/adjusted to new_win in tcp_select_window(). Thus, between
above 1) and 2) the sk didn't have the chance to update its rcv_wnd
value, so...

I attached two consecutive calltraces here:
[Fri Mar  7 08:00:52 2025] netserver, 1, 91234, 65483, (25751,130966)
[Fri Mar  7 08:00:52 2025] CPU: 0 UID: 266980 PID: 17465 Comm:
netserver Kdump: loaded Not tainted 6.14.0-rc4+ #415
[Fri Mar  7 08:00:52 2025] Hardware name: Tencent Cloud CVM, BIOS
seabios-1.9.1-qemu-project.org 04/01/2014
[Fri Mar  7 08:00:52 2025] Call Trace:
[Fri Mar  7 08:00:52 2025]  <TASK>
[Fri Mar  7 08:00:52 2025]  dump_stack_lvl+0x5b/0x70
[Fri Mar  7 08:00:52 2025]  dump_stack+0x10/0x20
[Fri Mar  7 08:00:52 2025]  tcp_grow_window+0x297/0x320
[Fri Mar  7 08:00:52 2025]  tcp_event_data_recv+0x265/0x400
[Fri Mar  7 08:00:52 2025]  tcp_data_queue+0x6d0/0xc70
[Fri Mar  7 08:00:52 2025]  tcp_rcv_established+0x1f5/0x760
[Fri Mar  7 08:00:52 2025]  ? schedule_timeout+0xe5/0x100
[Fri Mar  7 08:00:52 2025]  tcp_v4_do_rcv+0x171/0x2d0
[Fri Mar  7 08:00:52 2025]  __release_sock+0xd1/0xe0
[Fri Mar  7 08:00:52 2025]  release_sock+0x30/0xa0
[Fri Mar  7 08:00:52 2025]  inet_accept+0x5c/0x80
[Fri Mar  7 08:00:52 2025]  do_accept+0xf1/0x180
.....
[Fri Mar  7 08:00:52 2025] netserver, 0, 91234, 65483
[Fri Mar  7 08:00:52 2025] CPU: 0 UID: 266980 PID: 17465 Comm:
netserver Kdump: loaded Not tainted 6.14.0-rc4+ #415
[Fri Mar  7 08:00:52 2025] Hardware name: Tencent Cloud CVM, BIOS
seabios-1.9.1-qemu-project.org 04/01/2014
[Fri Mar  7 08:00:52 2025] Call Trace:
[Fri Mar  7 08:00:52 2025]  <TASK>
[Fri Mar  7 08:00:52 2025]  dump_stack_lvl+0x5b/0x70
[Fri Mar  7 08:00:52 2025]  dump_stack+0x10/0x20
[Fri Mar  7 08:00:52 2025]  tcp_set_window_clamp+0xc3/0x1f0
[Fri Mar  7 08:00:52 2025]  tcp_event_data_recv+0x35b/0x400
[Fri Mar  7 08:00:52 2025]  tcp_data_queue+0x6d0/0xc70
[Fri Mar  7 08:00:52 2025]  tcp_rcv_established+0x1f5/0x760
[Fri Mar  7 08:00:52 2025]  ? schedule_timeout+0xe5/0x100
[Fri Mar  7 08:00:52 2025]  tcp_v4_do_rcv+0x171/0x2d0
[Fri Mar  7 08:00:52 2025]  __release_sock+0xd1/0xe0
[Fri Mar  7 08:00:52 2025]  release_sock+0x30/0xa0
[Fri Mar  7 08:00:52 2025]  inet_accept+0x5c/0x80
[Fri Mar  7 08:00:52 2025]  do_accept+0xf1/0x180

Test is simple on my virtual machine just by running "netperf -H
127.0.0.1" which uses TCP_STREAM by default.

Thanks,
Jason

