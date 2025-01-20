Return-Path: <netdev+bounces-159814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53412A1700D
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 17:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C798164A93
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 16:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01341E5718;
	Mon, 20 Jan 2025 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ImgF4KLC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA5519BA6
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737390187; cv=none; b=s6TqsMZ8WZItqpkBtxqbr28y/zbXMJFaoSIixOK97fyCw5loHFvgtUy2ZNw4JoBOzzGrb8Xo49HGJr6ihUM1M8g7MpFMF7WmyEjODrd2HPPzXd4R/0WmfIwh4tzEHvCpgIpFhMqnNffuw82eHnDQENnQZ8sn4PzTOKiWaUrautc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737390187; c=relaxed/simple;
	bh=RG01RpH/bLkNRh6ASv570OwzlkuP50tVr1dResw744U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSraRTeTWuiCgi2CVmAikZW/B+o8DjRGI2jiRn9gthPJtBbqO/wDT5cVU/dgMCu3Ntg30/REIMs8kQYY1yogY2qaPKCFJ38zdn0w73CHPxabGSmAAOGkGa5MzAAsq9pT7ZTEcIwdEWe56Rku0/CA0r3UzoQVyY/rqNrvpUSujug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ImgF4KLC; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d90a5581fcso8257107a12.1
        for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 08:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737390184; x=1737994984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Qmoe3LxIhHvxM/+eymvqxcBkLWxBUxLX+UpNauVonI=;
        b=ImgF4KLCEFjLSAIvIjybMrLLsLALSs9onIoVojTRKjfN8bBv8oOBEOzNXRe1ugOb+E
         uZ0X2aMJFjQSyhuiTN6DgJHsv2/jX8AVXWbnPUXRgNG8FhVawIbt5an0+22IU70GlLxe
         W1I5VX9o0AIW1v5vjoFr3Q3+4WI4+3sl44MBZpzoIwvy4BupfDlAu5ZzU9bFHupsHbSO
         6TZRDr7VmIr9O2Tgscia8lMopkKhzZ4bZXNl8Wj/5tGBy+ogHSTXZg9fXgXAtPrlwf6Z
         O26XzSffzeO8TjgSuyqztsN0TLtMI6jcoblhE1rF16iEAxRFwKoAVdXQ0y3A9AZI/UHo
         fPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737390184; x=1737994984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Qmoe3LxIhHvxM/+eymvqxcBkLWxBUxLX+UpNauVonI=;
        b=fn2ZLxXXG0ohUbjo+Sd439t26rGkC+pWVDEFScugnKoHRsBwkV0wFnaxxIwAhXVrvf
         EjrzHfaZmVFLk4ECU6ZNO1Uk20mDFg+MBE5n6CViWeeR17e/MNgbPjdyeDOG8dClSBfO
         ZQo07/Kp3uE5le5JG6C+Rni8lZahD7nJh27Ed4R3M+7jjJWNClokT5l9waR7RLVI7Aix
         +TgA9LqAQlllPLYUyMGokaEakn7gpyC6P7r5MA4NxNHGI4t1iE2z2ikP053rpllT9iQw
         fmBKqR6cfS3cbPqkS4fcZMQl81sZS6y5NaW/cEIFw/DFmJjP/IoqKJDugXkuWLAWdWlV
         iKOA==
X-Forwarded-Encrypted: i=1; AJvYcCXwx/l4pPKTbmlx8gv7UEfm6AA8jho04tN9HGn5SRH0+H4sNjGmMDO40tpV5KIAPxUn2mVoLSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNhw8Ibv+dOu2jq6vFs6uSBNKkm5pNtfj96ws4YgWNVbOVflyD
	OWeGkqkqyeKbSiEMWZNj/R7Qvi24/KX0NvfSeopRl0+SD57OpZt9Bvd7kqdjMRxZw/UryO3eS5+
	DusFH+0o2JFDpQumt1qZTFuFKCS7Y1z68pUjILg8y2C6/ONGeU14Rt8E=
X-Gm-Gg: ASbGnctr0Ki4sByxx+xZlKSGzPQ7eXWDfs2qumTfAIDjTcdwfIfBK8LezcjD+H0iS8y
	C1uICbvZBXvHulaQUiuu8Ps0SQqxXMrm7QI3ntxi9ilfZL3Xz6g==
X-Google-Smtp-Source: AGHT+IFAJciDlGAVyRLEZgxxRTitH0IfVwmIO26PFgeze0pAH6+/HEy35YhMKKevXZj/y6eHU5MVrLj4+bBEqgh3L1E=
X-Received: by 2002:a05:6402:2686:b0:5db:67a7:e741 with SMTP id
 4fb4d7f45d1cf-5db7d2f5e87mr10197138a12.8.1737390184014; Mon, 20 Jan 2025
 08:23:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117214035.2414668-1-jmaloy@redhat.com> <CADVnQymiwUG3uYBGMc1ZEV9vAUQzEOD4ymdN7Rcqi7yAK9ZB5A@mail.gmail.com>
 <afb9ff14-a2f1-4c5a-a920-bce0105a7d41@redhat.com> <c41deefb-9bc8-47b8-bff0-226bb03265fe@redhat.com>
In-Reply-To: <c41deefb-9bc8-47b8-bff0-226bb03265fe@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 Jan 2025 17:22:52 +0100
X-Gm-Features: AbW1kvZ-kTg7Cw5oio-4BZkrdrJQpmBk5EMkpQsT4vVSq6RMZpBCQ3GEnhYOt9w
Message-ID: <CANn89i+RRxyROe3wx6f4y1nk92Y-0eaahjh-OGb326d8NZnK9A@mail.gmail.com>
Subject: Re: [net,v2] tcp: correct handling of extreme memory squeeze
To: Jon Maloy <jmaloy@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, passt-dev@passt.top, sbrivio@redhat.com, lvivier@redhat.com, 
	dgibson@redhat.com, eric.dumazet@gmail.com, 
	Menglong Dong <menglong8.dong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 5:10=E2=80=AFPM Jon Maloy <jmaloy@redhat.com> wrote=
:
>
>
>
> On 2025-01-20 00:03, Jon Maloy wrote:
> >
> >
> > On 2025-01-18 15:04, Neal Cardwell wrote:
> >> On Fri, Jan 17, 2025 at 4:41=E2=80=AFPM <jmaloy@redhat.com> wrote:
> >>>
> >>> From: Jon Maloy <jmaloy@redhat.com>
> >>>
> >>> Testing with iperf3 using the "pasta" protocol splicer has revealed
> >>> a bug in the way tcp handles window advertising in extreme memory
> >>> squeeze situations.
> >>>
> >>> Under memory pressure, a socket endpoint may temporarily advertise
> >>> a zero-sized window, but this is not stored as part of the socket dat=
a.
> >>> The reasoning behind this is that it is considered a temporary settin=
g
> >>> which shouldn't influence any further calculations.
> >>>
> >>> However, if we happen to stall at an unfortunate value of the current
> >>> window size, the algorithm selecting a new value will consistently fa=
il
> >>> to advertise a non-zero window once we have freed up enough memory.
> >>
> >> The "if we happen to stall at an unfortunate value of the current
> >> window size" phrase is a little vague... :-) Do you have a sense of
> >> what might count as "unfortunate" here? That might help in crafting a
> >> packetdrill test to reproduce this and have an automated regression
> >> test.
> >
> > Obviously, it happens when the following code snippet in
> >
> > __tcp_cleanup_rbuf() {
> >     [....]
> >     if (copied > 0 && !time_to_ack &&
> >         !(sk->sk_shutdown & RCV_SHUTDOWN)) {
> >              __u32 rcv_window_now =3D tcp_receive_window(tp);
> >
> >              /* Optimize, __tcp_select_window() is not cheap. */
> >              if (2*rcv_window_now <=3D tp->window_clamp) {
> >                  __u32 new_window =3D __tcp_select_window(sk);
> >
> >                  /* Send ACK now, if this read freed lots of space
> >                   * in our buffer. Certainly, new_window is new window.
> >                   * We can advertise it now, if it is not less than
> >                   * current one.
> >                   * "Lots" means "at least twice" here.
> >                   */
> >                  if (new_window && new_window >=3D 2 * rcv_window_now)
> >                          time_to_ack =3D true;
> >             }
> >      }
> >      [....]
> > }
> >
> > yields time_to_ack =3D false, i.e.  __tcp_select_window(sk) returns
> > a value new_window  < (2 *  tcp_receive_window(tp)).
> >
> > In my log I have for brevity used the following names:
> >
> > win_now: same as rcv_window_now
> >      (=3D tcp_receive_window(tp),
> >       =3D tp->rcv_wup + tp->rcv_wnd - tp->rcv_nxt,
> >       =3D 265469200 + 262144 -  265600160,
> >       =3D 131184)
> >
> > new_win: same as new_window
> >       (=3D __tcp_select_window(sk),
> >        =3D 0 first time, later 262144 )
> >
> > rcv_wnd: same as tp->rcv_wnd,
> >        (=3D262144)
> >
> > We see that although the last test actually is pretty close
> > (262144 >=3D 262368 ? =3D> false) it is not close enough.
> >
> >
> > We also notice that
> > (tp->rcv_nxt - tp->rcv_wup) =3D (265600160 - 265469200) =3D 130960.
> > 130960 < tp->rcv_wnd / 2, so the last test in __tcp_cleanup_rbuf():
> > (new_window >=3D 2 * rcv_window_now) will always be false.
> >
> >
> > Too me it looks like __tcp_select_window(sk) doesn't at all take the
> > freed-up memory into account when calculating a new window. I haven't
> > looked into why that is happening.
> >
> >>
> >>> This means that this side's notion of the current window size is
> >>> different from the one last advertised to the peer, causing the latte=
r
> >>> to not send any data to resolve the sitution.
> >>
> >> Since the peer last saw a zero receive window at the time of the
> >> memory-pressure drop, shouldn't the peer be sending repeated zero
> >> window probes, and shouldn't the local host respond to a ZWP with an
> >> ACK with the correct non-zero window?
> >
> > It should, but at the moment when I found this bug the peer stack was
> > not the Linux kernel stack, but one we develop for our own purpose. We
> > fixed that later, but it still means that traffic stops for a couple of
> > seconds now and then before the timer restarts the flow. This happens
> > too often for comfort in our usage scenarios.
> > We can of course blame the the peer stack, but I still feel this is a
> > bug, and that it could be handled better by the kernel stack.
> >>
> >> Do you happen to have a tcpdump .pcap of one of these cases that you
> >> can share?
> >
> > I had one, although not for this particular run, and I cannot find it
> > right now. I will continue looking or make a new one. Is there some
> > shared space I can put it?
>
> Here it is. Look at frame #1067.
>
> https://passt.top/static/iperf3_jon_zero_window_cut.pcap
> >
> >>
> >>> The problem occurs on the iperf3 server side, and the socket in quest=
ion
> >>> is a completely regular socket with the default settings for the
> >>> fedora40 kernel. We do not use SO_PEEK or SO_RCVBUF on the socket.
> >>>
> >>> The following excerpt of a logging session, with own comments added,
> >>> shows more in detail what is happening:
> >>>
> >>> //              tcp_v4_rcv(->)
> >>> //                tcp_rcv_established(->)
> >>> [5201<->39222]:     =3D=3D=3D=3D Activating log @ net/ipv4/tcp_input.=
c/
> >>> tcp_data_queue()/5257 =3D=3D=3D=3D
> >>> [5201<->39222]:     tcp_data_queue(->)
> >>> [5201<->39222]:        DROPPING skb [265600160..265665640], reason:
> >>> SKB_DROP_REASON_PROTO_MEM
> >>>                         [rcv_nxt 265600160, rcv_wnd 262144, snt_ack
> >>> 265469200, win_now 131184]
> >>
> >> What is "win_now"? That doesn't seem to correspond to any variable
> >> name in the Linux source tree.
> >
> > See above.
> >
> >   Can this be renamed to the
> >> tcp_select_window() variable it is printing, like "cur_win" or
> >> "effective_win" or "new_win", etc?
> >>
> >> Or perhaps you can attach your debugging patch in some email thread? I
> >> agree with Eric that these debug dumps are a little hard to parse
> >> without seeing the patch that allows us to understand what some of
> >> these fields are...
> >>
> >> I agree with Eric that probably tp->pred_flags should be cleared, and
> >> a packetdrill test for this would be super-helpful.
> >
> > I must admit I have never used packetdrill, but I can make an effort.
>
> I hear from other sources that you cannot force a memory exhaustion with
> packetdrill anyway, so this sounds like a pointless exercise.

We certainly can and should add a feature like that to packetdrill.

Documentation/fault-injection/ has some relevant information.

Even without this, tcp_try_rmem_schedule() is reading sk->sk_rcvbuf
that could be lowered by a packetdrill script I think.

