Return-Path: <netdev+bounces-157219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F1EA0977E
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 17:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 624507A2DB2
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 16:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E4E2135A9;
	Fri, 10 Jan 2025 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0O57frdn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FBA2139B1
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736526505; cv=none; b=UFg1lJlM+64P1+5tiA3lRrdrtg3iDpHxRxQKH3sjonXVQ8jFcLtLAcIt+hzQXfS1vCjGxmPcwobud4x9fnA+oq8DdzrkHa3MhBL0EzCyAkLDMZR31VDVYL5jjxeRoaVWhYRC4ClnOBJKH+joQ1Tp403ESJm3DMWn9NZEpP3HNq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736526505; c=relaxed/simple;
	bh=qK+VGFQfGs/M+Kok/pAsvEp4A2HwzBaZMR+luTlmb/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5aO7Vr6aNJP2QlK0jzX9O3fH7L0T701kLOBPM+yy7wNp4C4LYoor3voePRLCE3RFeZjakYl2aVPUGuJNmnIxJt7QsZXmClYPaShU+AutrYFc+fGeZO2VkhXUi+cvGQLwKDULuHc613hye9VbWSfXz5DF2ErZFh3GA85WiV/Mb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0O57frdn; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4678c9310afso235971cf.1
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 08:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736526503; x=1737131303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9ZWv+5A2l7TRwyqZwlMiG7FdbnpPMj+L8zZM6kSnHU=;
        b=0O57frdnwGCZ2mJyxh/5imysh9ZeniZYmENtqJ5Kll5eGEd7ajvCzPWvn3+R20CvQt
         NKUXv5VsnoZ2c96IPecFDl1mVOGri3H0CGXCpk71688y8IKw9stam9+GxD6xTMx4rPuT
         +3k2DbLGP/PZQ4sieiVUs5YW9sRXcP8OiJi+zC7pCwl8rLpRWHHqEzHaKp61w/fR+NIE
         OpL3H4leBrvwsiqVf222GqAsHpmi/M9zJKqZRMWgBkMUaqE7o+WfFAqVMzu+aMYXk6kF
         ST3tzgSexTdfvG8e/jh5y/kv6cQJGdYMKjrcJIA58NCyxmBSHw/ssdn18YI1Pm9XxyDD
         cdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736526503; x=1737131303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9ZWv+5A2l7TRwyqZwlMiG7FdbnpPMj+L8zZM6kSnHU=;
        b=MZvp8Bv3JAS0JGIF+50/D//5YWrcFgOLA4SC7ujxxnQYvoGBws4ooqe4jv+EZVMkce
         r+BT59qFSk6vMWITlHq13KEOumiehcnfw47wbb6rs55mry1XmP8vMAI2K3zn6puTlpLc
         zRaN0syKHollFRKl1Dk+h6pKJ8/ePf0viYDjCxYwmU6bdWZ2sGbNpBwDLSroYAciHpYz
         b3JCd4a/1nK5dyIVni6wkZhi2tdtg8AGzU7wYt7DEbiua4REnPneGuH7J9d86FtzRNDy
         3UFDtYvMGWd4Gqz8gP+uUt928spKGNDBs1gXgWhIOkei0nKK1iYJg2wADNi8d4gI3wKQ
         K18A==
X-Forwarded-Encrypted: i=1; AJvYcCVkpkmQDtZiprXMjJCfwXzgg1/eVIuR6f4udCYJVjqTM4AAcGS/DnZwW6Tpv7MRaZdOc/7PlIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0cGfV1ooTQuL5jQFCQFwaawE4pVNxwt1VdRxXpzpC8nVlwmuk
	1GE6SOQBZCMDvUm+UvrhPdKC3McIOckSUjFlRvwGfTYZKv0Zz8Bm4R9BsiqoP7wFNknmPifF1il
	ecq1kLpT1HVnTeMIXv40jeNVSrFb9ysD4JBg4
X-Gm-Gg: ASbGnctVztBnHYA9aZoA/J+0tw8mLSluQN8uZfXpP1sIdZlJgVIFXqNnYrtyZeTgC6I
	Dl5Gn3ouWOTJdTO5ojIU+wHCNlASPYVEBNzbh/WAJvgBXTr/gTX9SDcwDk669cwkWMCVX6w==
X-Google-Smtp-Source: AGHT+IGqwlsienI+v4dmQSrKRaZcCZu+YyvK8mzFMhb7IJ7zJEwIEiYY6NM6Iv3ALhXVVYUF1ptKGA4yosXccWGwYlk=
X-Received: by 2002:a05:622a:651:b0:46c:7d66:557f with SMTP id
 d75a77b69052e-46c87e07eb2mr3839341cf.8.1736526502763; Fri, 10 Jan 2025
 08:28:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109161802.3599-1-sensor1010@163.com> <CADVnQy=Uy+UxYivkUY1JZ4+c2rDD74VY8=vxmxf=NJxWcXa69Q@mail.gmail.com>
 <5d5290fb.a567.19450f031bf.Coremail.sensor1010@163.com> <CANn89iJLg1TKoFFaNtDOjFpyLW+YmxgSBCZQ4oTuJXX=RsKNzA@mail.gmail.com>
In-Reply-To: <CANn89iJLg1TKoFFaNtDOjFpyLW+YmxgSBCZQ4oTuJXX=RsKNzA@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 10 Jan 2025 11:28:06 -0500
X-Gm-Features: AbW1kvbdnB2V2owkSZJ8BTegzxV6OiOd2N3i8Qd5pQSq4nS3zeM7nmaPdtuX2_Q
Message-ID: <CADVnQykJBub7Fd_dUoNWbROuSgd+KHOr4JpdBDc3DJVLgU2ULg@mail.gmail.com>
Subject: Re: Re: [PATCH] tcp: Add an extra check for consecutive failed
 keepalive probes
To: Eric Dumazet <edumazet@google.com>
Cc: lizhe <sensor1010@163.com>, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 11:22=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
>
>
> On Fri, Jan 10, 2025 at 4:58=E2=80=AFPM lizhe <sensor1010@163.com> wrote:
> >
> > Hi, Neal
> >
> >
> > If the TCP_USER_TIMEOUT option is not enabled, and attempts to send TCP=
 keepalive probes continuously fail,
> >
> > then who limits the number of increments to icsk->icsk_probes_out?
> >
> >
> > Adding this code is feasible. If not added, the system would continuous=
ly send keepalive probes without any limit.
> >
> > If these probes continually fail, the process would persist indefinitel=
y because there would be no measure in place to restrict the increments of =
icsk->icsk_probes_out++.
> >
> >
>
> I think you should provide a packetdrill test, as Neal suggested.
>
> If you write a packetdrill test, chances are very high you will see the c=
ode is currently fine.

Yes, indeed. :-)

AFAICT we don't even need a new packetdrill test... I provided a
"repeated keepalive failures" packetdrill test earlier in this thread.
If folks run that test, they should find that recent Linux kernels
correctly terminate a connection after the configured number of
keepalive probes fail.

If there is some corner case we are missing, then you might want to
start from that packetdrill test I pasted in, and try to demonstrate
your corner case that you think the code is missing.

thanks,
neal

> In any case, you have to provide a Fixes: tag for any bug fix for network=
ing code,
> as explained in Documentation/process/maintainer-netdev.rst
>
>  Thank you.
>
> >
> > _Lizhe,
> >
> > thx
> >
> >
> >
> >
> >
> >
> >
> >
> >
> > At 2025-01-10 00:31:55, "Neal Cardwell" <ncardwell@google.com> wrote:
> > >On Thu, Jan 9, 2025 at 11:21=E2=80=AFAM Lizhe <sensor1010@163.com> wro=
te:
> > >>
> > >> Add an additional check to handle situations where consecutive
> > >> keepalive probe packets are sent without receiving a response.
> > >>
> > >> Signed-off-by: Lizhe <sensor1010@163.com>
> > >> ---
> > >>  net/ipv4/tcp_timer.c | 6 ++++++
> > >>  1 file changed, 6 insertions(+)
> > >>
> > >> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> > >> index b412ed88ccd9..5a5dee8cd6d3 100644
> > >> --- a/net/ipv4/tcp_timer.c
> > >> +++ b/net/ipv4/tcp_timer.c
> > >> @@ -828,6 +828,12 @@ static void tcp_keepalive_timer (struct timer_l=
ist *t)
> > >>                 }
> > >>                 if (tcp_write_wakeup(sk, LINUX_MIB_TCPKEEPALIVE) <=
=3D 0) {
> > >>                         icsk->icsk_probes_out++;
> > >> +                       if (icsk->icsk_probes_out >=3D keepalive_pro=
bes(tp)) {
> > >> +                               tcp_send_active_reset(sk, GFP_ATOMIC=
,
> > >> +                                               SK_RST_REASON_TCP_KE=
EPALIVE_TIMEOUT);
> > >> +                               tcp_write_err(sk);
> > >> +                               goto out;
> > >> +                       }
> > >>                         elapsed =3D keepalive_intvl_when(tp);
> > >>                 } else {
> > >>                         /* If keepalive was lost due to local conges=
tion,
> > >> --
> > >
> > >Can you please explain the exact motivation for your patch, ideally
> > >providing either a tcpdump trace or packetdrill test to document the
> > >scenario you are concerned about?
> > >
> > >The Linux TCP keepalive logic in tcp_keepalive_timer() already
> > >includes logic (a few lines above the spot you propose to patch) that
> > >ensures that a connection will be closed with ETIMEDOUT if consecutive
> > >keepalive probes fail:
> > >
> > >                if ((user_timeout !=3D 0 &&
> > >                    elapsed >=3D msecs_to_jiffies(user_timeout) &&
> > >                    icsk->icsk_probes_out > 0) ||
> > >                    (user_timeout =3D=3D 0 &&
> > >                    icsk->icsk_probes_out >=3D keepalive_probes(tp))) =
{
> > >                        tcp_send_active_reset(sk, GFP_ATOMIC,
> > >
> > >SK_RST_REASON_TCP_KEEPALIVE_TIMEOUT);
> > >                        tcp_write_err(sk);
> > >                        goto out;
> > >                }
> > >                if (tcp_write_wakeup(sk, LINUX_MIB_TCPKEEPALIVE) <=3D =
0) {
> > >                        icsk->icsk_probes_out++;
> > >                        elapsed =3D keepalive_intvl_when(tp);
> > >
> > >AFAICT your patch nearly duplicates the existing logic, but changes
> > >the application-visible behavior to close the connection after one
> > >fewer timer expiration, thus breaking the semantics of the
> > >net.ipv4.tcp_keepalive_probes.
> > >
> > >neal
> > >
> > >---
> > >
> > >ps: For reference, here is a packetdrill test we use to test this
> > >functionality; this passes on recent Linux kernels:
> > >
> > >// Test TCP keepalive behavior without TCP timestamps enabled.
> > >
> > >`../common/defaults.sh`
> > >
> > >// Create a socket.
> > >    0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
> > >   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> > >
> > >   +0 bind(3, ..., ...) =3D 0
> > >   +0 listen(3, 1) =3D 0
> > >
> > >// Establish a connection.
> > >   +0 < S 0:0(0) win 20000 <mss 1000,nop,nop,sackOK,nop,wscale 8>
> > >   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
> > >  +.1 < . 1:1(0) ack 1 win 20000
> > >   +0 accept(3, ..., ...) =3D 4
> > >
> > >// Verify keepalives are disabled by default.
> > >   +0 getsockopt(4, SOL_SOCKET, SO_KEEPALIVE, [0], [4]) =3D 0
> > >// Enable keepalives:
> > >   +0 setsockopt(4, SOL_SOCKET, SO_KEEPALIVE, [1], 4) =3D 0
> > >
> > >// Verify default TCP_KEEPIDLE is 7200, from net.ipv4.tcp_keepalive_ti=
me=3D7200:
> > >   +0 getsockopt(4, SOL_TCP, TCP_KEEPIDLE, [7200], [4]) =3D 0
> > >// Start sending keepalive probes after 3 seconds of idle
> > >   +0 setsockopt(4, SOL_TCP, TCP_KEEPIDLE, [3], 4) =3D 0
> > >
> > >// Verify default TCP_KEEPINTVL is 75, from net.ipv4.tcp_keepalive_int=
vl=3D75:
> > >   +0 getsockopt(4, SOL_TCP, TCP_KEEPINTVL, [75], [4]) =3D 0
> > >// Send keepalive probes every 2 seconds.
> > >   +0 setsockopt(4, SOL_TCP, TCP_KEEPINTVL, [2], 4) =3D 0
> > >
> > >// Verify default TCP_KEEPCNT is 9, from net.ipv4.tcp_keepalive_probes=
=3D9:
> > >   +0 getsockopt(4, SOL_TCP, TCP_KEEPCNT, [9], [4]) =3D 0
> > >// Send 4 keepalive probes before giving up.
> > >   +0 setsockopt(4, SOL_TCP, TCP_KEEPCNT, [4], 4) =3D 0
> > >
> > >// Set up an epoll operation to verify that connections terminated by =
failed
> > >// keepalives will wake up blocked epoll waiters with EPOLLERR|EPOLLHU=
P:
> > >   +0 epoll_create(1) =3D 5
> > >   +0 epoll_ctl(5, EPOLL_CTL_ADD, 4, {events=3DEPOLLERR, fd=3D4}) =3D =
0
> > >   +0...11 epoll_wait(5, {events=3DEPOLLERR|EPOLLHUP, fd=3D4}, 1, 1500=
0) =3D 1
> > >
> > >// Verify keepalive behavior looks correct, given the parameters above=
:
> > >
> > >// Start sending keepalive probes after 3 seconds of idle.
> > >   +3 > . 0:0(0) ack 1
> > >// Send keepalive probes every 2 seconds.
> > >   +2 > . 0:0(0) ack 1
> > >   +2 > . 0:0(0) ack 1
> > >   +2 > . 0:0(0) ack 1
> > >   +2 > R. 1:1(0) ack 1
> > >// Sent 4 keepalive probes and then gave up and reset the connection.
> > >
> > >// Verify that we get the expected error when we try to use the socket=
:
> > >   +0 read(4, ..., 1000) =3D -1 ETIMEDOUT (Connection timed out)

