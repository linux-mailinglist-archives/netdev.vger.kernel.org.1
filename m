Return-Path: <netdev+bounces-220588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E54BCB47206
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 17:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B78E3AD6FF
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 15:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CF521FF2A;
	Sat,  6 Sep 2025 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZ1ZsdmZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95AD17BB21;
	Sat,  6 Sep 2025 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757172330; cv=none; b=JO9X9rIyHwX0d9ULhPf3NfXY3l6IO3S13ecD+F5AccQaT1UyS1YEQNM7FeSK8TAhADqTGev2VXExegLOWyIZAzsZGNUwZGfCkhbCXWzeva+zsVx74+ZXclgzBBP7Kuw0v3wFehgMRuRIecan307ZWRablXvHG+PlsaA7HZUIU54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757172330; c=relaxed/simple;
	bh=f30de0FQaoXycZpV1SFeYk2Wl9zmlvEQoCgvr4NeKhk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=o2+FCaL8wJt4EZvI3RmlqyzgEQMmAsEc+QlWcLvOhCO25/ybx2yGxfwb58mN55xF3E1djI0NMVqf+hcYa731llKKJNBzLOxYtaHrJ2nZc4D6z4NFDj453EYlP0y5ZFcBVq9hrwOS+hx7xb+rdEWC92UafQvW0x16VQ7483IZUeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZ1ZsdmZ; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-722d5d8fa11so26583666d6.3;
        Sat, 06 Sep 2025 08:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757172327; x=1757777127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKM9Z1IohGYjxaAPMF47eTayyL7R4dz2679H6xNeWFI=;
        b=HZ1ZsdmZ4t69lTH0BqMaG+AztArWOYxZEEJhMD9s1TUattA464sj7lhxkvWXd+2+9i
         zuQrQn9LQs0l6oHhAMcouT9wmO68vlpxiSoqKJAFJJd3MKQxqLnIeGJUksuPi4i/j2K2
         5gFPiAj5UwmL4P9GZQiRCy6KX6HMUWiFim4Jjz5gwX+qEPz9Tu0efrb4fO9shBI/E1Lv
         DEjdJSfqhafyZfJN4BfPjwB+EfXselMr0UQ1tI5MJKfhTZUBX9mfuJWCw4hITrw0e7Jv
         6Qd1HXoDLZeAJbIVvHTHDrf2urc4EDfnxfY0scbVgPyJRauh/tZRscKSVG1robHijJie
         NLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757172327; x=1757777127;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zKM9Z1IohGYjxaAPMF47eTayyL7R4dz2679H6xNeWFI=;
        b=A07tPNEM8w0MPiJ83QxAc0hShBkOETv58luH+gDk7Q8SMdHasgkMpOiYTtfYBxncor
         XKB9F+h5/U/RW6T+kOAi3ksRRGBJAgur8pVsaTdGUvHat2YwsVPHzj1sPNJYoYtxxdUR
         KyKQ0vEBZ21nMnnMd99yLZ5xsHU6zjNvT5uI/15JL4lkALsac0e2Ehzmr9/J3IVN3/D9
         YRsYYiKxWulYzd3We6sjF4/qhzyQ9h+B7nmpuQrpnk9Ws1r6NnZo+MX4QYh+gaqr+Vrv
         ueYZUuy0mus0Jlzi9d0xDv2n2wmOripL/kN4E6lX6WAAYFSEUDR2CnFbsSXBMgbtnkho
         f5NA==
X-Forwarded-Encrypted: i=1; AJvYcCVO+FJYkYewwneZWVlgqtvO+NRO4zNWbfOJXcOF+h3sKNq7/2V+1NSfuAaBiiUb9APA+ZZMjo1l@vger.kernel.org, AJvYcCXcocuLsgk6LiW5szevDAWuLadxx5SUdbFx/ltLAESZOgSO9cV9rUl3lv/0ln4YltFqd2xhMXbNuJpfS20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8gKnknaAP+pVoUXCOQtgrMDthRdfU4+czfNztPFgGB3A91g2h
	ifnaKRK/ez4e8OjWKFXPgcW1oVaHhSaXdOvnqBE0IENadDqS9S/WaLvv
X-Gm-Gg: ASbGnctRCLG9HXqZEjNe6E/XNPps+5ornHk4GqH3rDLcQibmU+NGSao9MSWoyFp3Tq8
	kFxH8Wdw5gDFYS5/5kYwqRRBDEPlFoKFOpeo+fkc85ARPgPZ8QvlkyIN+wqWDlBpf53eeqiRA5P
	YtiJhbNQDB0HAgWcqk1Sl0HwAelWqrKPrAR3CqrWtT2QZYoGvtEpGA2v9tEe+6RWtxu9yo3T7Tp
	N1fX8Utv01r09NxIxnyWPpyun95BQJ5CWrbbEiofuJ+ou1qntl/Wm4YWAyFC8+UOd87gpDmY0po
	+gW3SRvfBt+iZdP+/pcqGOvWd8eTCWFBZL+AE8Nsju1cgNOq14cTJW7yw8vWtn6GDmwuNGNVww6
	RAYT9K0maC02KJFNJrcHzmPml7+IBCRNP2vXlbR2os3SC4edk9L0Vv3XgblYwxIpvbK+n42fgKR
	PNRIhrW0deiVrR
X-Google-Smtp-Source: AGHT+IGtoXCaDnFBYf6mkf1yk5zbRicQdconvYCbxg05Frl857tH9lYFNqY3ofy1XT4Ysp9v4pl8qg==
X-Received: by 2002:a05:6214:2689:b0:725:ddc0:e807 with SMTP id 6a1803df08f44-7393ec178bemr26400246d6.56.1757172327404;
        Sat, 06 Sep 2025 08:25:27 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-72f9ad0acedsm29306256d6.14.2025.09.06.08.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 08:25:26 -0700 (PDT)
Date: Sat, 06 Sep 2025 11:25:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Xin Zhao <jackzxcui1989@163.com>, 
 edumazet@google.com, 
 ferenc@fejes.dev, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1a11cce73202f@gmail.com>
In-Reply-To: <CAL+tcoBX4URyxxxuCT3XdzJ7R2zS-DjobdKfMjwc-R7h=ptFCg@mail.gmail.com>
References: <20250905040021.1893488-1-jackzxcui1989@163.com>
 <CAL+tcoDxyfAWOWT9gWC7wvcEy8tNYM7pF8suJhwUpdz+MWdxhw@mail.gmail.com>
 <CAL+tcoDYfbu7oCWgnWdb2rLee0AtdC9xS9ix9yJ4RQ3TVa6u4g@mail.gmail.com>
 <willemdebruijn.kernel.6a80e2e45f24@gmail.com>
 <CAL+tcoBX4URyxxxuCT3XdzJ7R2zS-DjobdKfMjwc-R7h=ptFCg@mail.gmail.com>
Subject: Re: [PATCH net-next v10 2/2] net: af_packet: Use hrtimer to do the
 retire operation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Sat, Sep 6, 2025 at 12:16=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > On Fri, Sep 5, 2025 at 2:03=E2=80=AFPM Jason Xing <kerneljasonxing@=
gmail.com> wrote:
> > > >
> > > > On Fri, Sep 5, 2025 at 12:01=E2=80=AFPM Xin Zhao <jackzxcui1989@1=
63.com> wrote:
> > > > >
> > > > > On Thu, Sep 4, 2025 at 11:26=E2=80=AF+0800 Jason Xing <kernelja=
sonxing@gmail.com> wrote:
> > > > >
> > > > > > > In the description of [PATCH net-next v10 0/2] net: af_pack=
et: optimize retire operation:
> > > > > > >
> > > > > > > Changes in v8:
> > > > > > > - Delete delete_blk_timer field, as suggested by Willem de =
Bruijn,
> > > > > > >   hrtimer_cancel will check and wait until the timer callba=
ck return and ensure
> > > > > > >   enter enter callback again;
> > > > > >
> > > > > > I see the reason now :)
> > > > > >
> > > > > > Please know that the history changes through versions will fi=
nally be
> > > > > > removed, only the official message that will be kept in the g=
it. So
> > > > > > this kind of change, I think, should be clarified officially =
since
> > > > > > you're removing a structure member. Adding more descriptions =
will be
> > > > > > helpful to readers in the future. Thank you.
> > > > >
> > > > > I will add some more information to the commit message of this =
2/2 PATCH.
> > > > >
> > > > >
> > > > >
> > > > > > > Consider the following timing sequence:
> > > > > > > timer   cpu0 (softirq context, hrtimer timeout)            =
    cpu1 (process context)
> > > > > > > 0       hrtimer_run_softirq
> > > > > > > 1         __hrtimer_run_queues
> > > > > > > 2           __run_hrtimer
> > > > > > > 3             prb_retire_rx_blk_timer_expired
> > > > > > > 4               spin_lock(&po->sk.sk_receive_queue.lock);
> > > > > > > 5               _prb_refresh_rx_retire_blk_timer
> > > > > > > 6                 hrtimer_forward_now
> > > > > > > 7               spin_unlock(&po->sk.sk_receive_queue.lock)
> > > > > > > 8             raw_spin_lock_irq(&cpu_base->lock);          =
    tpacket_rcv
> > > > > > > 9             enqueue_hrtimer                              =
      spin_lock(&sk->sk_receive_queue.lock);
> > > > > > > 10                                                         =
      packet_current_rx_frame
> > > > > > > 11                                                         =
        __packet_lookup_frame_in_block
> > > > > > > 12            finish enqueue_hrtimer                       =
          prb_open_block
> > > > > > > 13                                                         =
            _prb_refresh_rx_retire_blk_timer
> > > > > > > 14                                                         =
              hrtimer_is_queued(&pkc->retire_blk_timer) =3D=3D true
> > > > > > > 15                                                         =
              hrtimer_forward_now
> > > > > > > 16                                                         =
                WARN_ON
> > > > > > > On cpu0 in the timing sequence above, enqueue_hrtimer is no=
t protected by sk_receive_queue.lock,
> > > > > > > while the hrtimer_forward_now is not protected by raw_spin_=
lock_irq(&cpu_base->lock).
> > > > > > >
> > > > > > > In my previous email, I provided an explanation. As a suppl=
ement, I would
> > > > > > > like to reiterate a paragraph from my earlier response to W=
illem.
> > > > > > > The point is that when the hrtimer is in the enqueued state=
, you cannot
> > > > > >
> > > > > > How about tring hrtimer_is_queued() beforehand?
> > > > > >
> > > > > > IIUC, with this patch applied, we will lose the opportunity t=
o refresh
> > > > > > the timer when the lookup function (in the above path I menti=
oned)
> > > > > > gets called compared to before. If the packet socket tries to=
 look up
> > > > > > a new block and it doesn't update its expiry time, the timer =
will soon
> > > > > > wake up. Does it sound unreasonable?
> > > > >
> > > > >
> > > > > I actually pointed out the issue with the timeout setting in a =
previous email:
> > > > > https://lore.kernel.org/netdev/20250826030328.878001-1-jackzxcu=
i1989@163.com/.
> > > > >
> > > > > Regarding the method you mentioned, using hrtimer_is_queued to =
assist in judgment, I had
> > > > > discussed this extensively with Willem in previous emails, and =
the conclusion was that
> > > > > it is not feasible. The reason is that in our scenario, the hrt=
imer always returns
> > > > > HRTIMER_RESTART, unlike the places you pointed out, such as tcp=
_pacing_check, where the
> > > > > corresponding hrtimer callbacks all return HRTIMER_NORESTART. S=
ince our scenario returns
> > > > > HRTIMER_RESTART, this can lead to many troublesome issues. The =
fundamental reason is that
> > > > > if HRTIMER_RESTART is returned, the hrtimer module will enqueue=
 the hrtimer after the
> > > > > callback returns, which leads to exiting the protection of our =
sk_receive_queue lock.
> > > > >
> > > > > Returning to the functionality here, if we really want to updat=
e the hrtimer's timeout
> > > > > outside of the timer callback, there are two key points to note=
:
> > > > >
> > > > > 1. Accurately knowing whether the current context is a timer ca=
llback or tpacket_rcv.
> > > > > 2. How to update the hrtimer's timeout in a non-timer callback =
scenario.
> > > > >
> > > > > To start with the first point, it has already been explained in=
 previous emails that
> > > > > executing hrtimer_forward outside of a timer callback is not al=
lowed. Therefore, we
> > > > > must accurately determine whether we are in a timer callback; o=
nly in that context can
> > > > > we use the hrtimer_forward function to update.
> > > > > In the original code, since the same _prb_refresh_rx_retire_blk=
_timer function was called,
> > > > > distinguishing between contexts required code restructuring. No=
w that this patch removes
> > > > > the _prb_refresh_rx_retire_blk_timer function, achieving this a=
ccurate distinction is not
> > > > > too difficult.
> > > > > The key issue is the second point. If we are not inside the hrt=
imer's callback, we cannot
> > > > > use hrtimer_forward to update the timeout.
> > > > > So what other interface can we use? You might
> > > > > suggest using hrtimer_start, but fundamentally, hrtimer_start c=
annot be called if it has
> > > > > already been started previously. Therefore, wouldn=E2=80=99t yo=
u need to add hrtimer_cancel to
> > > > > confirm that the hrtimer has been canceled? Once hrtimer_cancel=
 is added, there will also
> > > > > be scenarios where it is restarted, which means we need to cons=
ider the concurrent
> > > > > scenario when the socket exits and also calls hrtimer_cancel. T=
his might require adding
> > > > > logic for that concurrency scenario, and you might even need to=
 reintroduce the
> > > > > delete_blk_timer variable to indicate whether the packet_releas=
e operation has been
> > > > > triggered so that the hrtimer does not restart in the tpacket_r=
cv scenario.
> > > > >
> > > > > In fact, in a previous v7 version, I proposed a change that I p=
ersonally thought was
> > > > > quite good, which can be seen here:
> > > > > https://lore.kernel.org/netdev/20250822132051.266787-1-jackzxcu=
i1989@163.com/. However,
> > > > > this change introduced an additional variable and more logic. W=
illem also pointed out
> > > > > that the added complexity to avoid a non-problematic issue was =
unnecessary.
> > > >
> > > > Admittedly it's a bit complex.
> > > >
> > > > >
> > > > > As mentioned in Changes in v8:
> > > > >   The only special case is when prb_open_block is called from t=
packet_rcv.
> > > > >   That would set the timeout further into the future than the a=
lready queued
> > > > >   timer. An earlier timeout is not problematic. No need to add =
complexity to
> > > > >   avoid that.
> > > >
> > > > It'd be better to highlight this in the commit message as well to=

> > > > avoid further repeat questions from others. It's an obvious chang=
e in
> > > > this patch :)
> > >
> > > BTW, I have to emphasize that after this patch, the hrtimer will ru=
n
> > > periodically and unconditionally. As far as I know, it's not possib=
le
> > > to run hundreds and thousands packet sockets in production, so it
> > > might not be a huge problem.
> >
> > In tcp each sk has its own hrtimers (tcp_init_xmit_timers).
> =

> Right, but they don't get woken up so frequently in normal cases. I'm
> worried because in production I saw a huge impact caused by the 1ms
> timer from numerous sockets:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3De4dd0d3a2f64b8bd8029ec70f52bdbebd0644408
> But AFAIK I don't see a real use case where people use so many packet
> sockets. If it happens, in the future we might get complaints. We'll
> see:)

Hrtimers share an interrupt.

The worst case additional overhead is if timer expiration is a little
bit slower than packet arrival rate (and thus tpacket_rcv event rate).

Because the higher the tpacket_rcv rate relatively, the smaller the
timer callback overhead is. And if timeout frequency is higher than
tpacket_rcv, it would fire anyway.

So worst case the overhead is a doubling of block management calls?

I don't have hard numbers but the cost of removing a timer and
reprogramming from inside tpacket_rcv just to defer seems higher than
accepting this bounded (relative to other operations) cost of
spurious wakeups.

