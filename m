Return-Path: <netdev+bounces-220589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DBAB472F7
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 17:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024835A2EEF
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 15:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA7021ADAE;
	Sat,  6 Sep 2025 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCXUq2LL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86594AD2C;
	Sat,  6 Sep 2025 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757174036; cv=none; b=VC4bW5NHaI/GM6gw0npGneUkNtVa6fD7RLR0+c33nPugduDMFe4F/52dASlkP2xyjNdXHsRyaG2tdjwpW5o8D5/qxdZORqJU/3yK2cY1IBo/fwAQ1d6EgwoVLj4WLiLM4hg9lGiq3a32q16oyKSQ/fD4veuEo9/yVenC9rA0G/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757174036; c=relaxed/simple;
	bh=lDqw/L1siIY6OZRQjUxyCT52dQ1L5dPyRjetQ0ow7UE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+zIVLez8ytQPtTzQw9ElFGPsLG6p9gLqaJ8hourNZaZrtAK6kU7z2z9zt2ueTsAkn/BF5gcyelolqizzoB0KYGsuYl3wurN0xsKhA0GIl2EzISlsYQN9Kyxz48p4L1xJimiN5VaVOFjO7anxFDfXagBTbcXQKOff9wq9sLHmYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCXUq2LL; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3f669e78eadso17313175ab.1;
        Sat, 06 Sep 2025 08:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757174033; x=1757778833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNvdBeulXNxjicC6i7MFDiApXAdJhsSeWWtnDSi2t6E=;
        b=WCXUq2LLhbuldFSxJ7bkzbTa3B75VXaFs1Kgvh1oqZ3ZKpdWHlpobETEgm1hMMYUOk
         z2UfMvfhUPpWMX86ukiEH059ZWt3kQ0z/DSSNNCxiVT69O6U/VRQVaNwA1L7ReVta901
         BbRohZN98H15KBLa6BbrdDozrcXQ1c89iDJeTQmqnOWyhOg+OLF/v1W6/Uy3m7oT8zr2
         4CTtP7cCoCPHnlQfS7A7DLgry/kooAnZZumYVTv7RICcm2Ic7GpLMKPPJ6tWYHcUScJ1
         Y062bmZTC4yX3rT58tvF/P68WgoUg9di1I1rvkecP8d07wltwADc6msiS6lNfEJDCrzF
         /LNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757174033; x=1757778833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNvdBeulXNxjicC6i7MFDiApXAdJhsSeWWtnDSi2t6E=;
        b=BqULIVypMnq0vZRNDGCeg0/rmQh2RoX2NIiVItZWphxN2+QKULnxu3mkGEUyceEqBo
         JvDBysFQd1MUWyYevbxVDiCpLO8nhNPe4rQknIlGx4k+W9kmuOlWchQMx1N07H4ud6Gf
         4DdmBMB28GjbmXLBybeCPXGIGngTOEDKLPDnvHv6/f302tHRslUsbjqzN61EC0OH7BX5
         37+lLR0ly9SwVAXujFYLqhd/Qjts9WVZvNdL5SA72RMqIqSDd4pwaiMxdXiYKehOzfhn
         ft/DSgK4lq0jL9tWOEb/nvKv4t1VVd89dm2avK3qqct2dkx7x8IfRTlfstX86gtNuQju
         iYnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZf2Bqe2RoyBq+Vc3bQt3To6rWJ7xivRv3SFV5JAqUyKw9pl+9SbyJfjfqqGgTDLMgja6Vjr3+ikhNbbw=@vger.kernel.org, AJvYcCXntJwTiFVD6P12fL/9xFrFm3LnVS4NAavgQ1JH3ZfLZ9m+xZN0mRLM5VxQMvEhhuaQmkD+UlFa@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7cI18/0VIohPV5PLrplYJX/FFB46/I0eclSZkXqkkUZipgZ72
	G80IZhhsEucIKbrUJUoKD5LBpBg7EgBrZxLzei3xrIzAul/wKwvvO8vBdJAGzWYSMLPgEIYDDM0
	6G3smKnZI+EEIzCLM6ulXbBjqeV0fs6Y=
X-Gm-Gg: ASbGncs5wM9ast9VDo1xF/RLrCR/5840aie3YTMcpMZmZdBUR/6WWelLjT3fkltizzD
	A9YzqOz3hMK+nrnDD3COLMngTscJ4ibIsu6JyGV6zkT91ewXQiDb3r2P2DntxBylD2yYWEnxssS
	vONAhUGgGm3XM2rBP+Ci/sVm0pmLl9stZB0vL2CmHRZEcH/FO79gV944Rw5V/cncOvSvp19LIJK
	dNnLhuJOzp6SzSt2hA2
X-Google-Smtp-Source: AGHT+IF+XSMSKQnJkMLPtBg9/xIgVukPumwXHUholQ5OYnsVbpfU7B+e3D9d9dgnErjkF2O536rDu1szAUQp60uxHUw=
X-Received: by 2002:a05:6e02:3bc7:b0:3f1:b54f:5cf7 with SMTP id
 e9e14a558f8ab-3fe02f55292mr26884465ab.9.1757174033424; Sat, 06 Sep 2025
 08:53:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905040021.1893488-1-jackzxcui1989@163.com>
 <CAL+tcoDxyfAWOWT9gWC7wvcEy8tNYM7pF8suJhwUpdz+MWdxhw@mail.gmail.com>
 <CAL+tcoDYfbu7oCWgnWdb2rLee0AtdC9xS9ix9yJ4RQ3TVa6u4g@mail.gmail.com>
 <willemdebruijn.kernel.6a80e2e45f24@gmail.com> <CAL+tcoBX4URyxxxuCT3XdzJ7R2zS-DjobdKfMjwc-R7h=ptFCg@mail.gmail.com>
 <willemdebruijn.kernel.1a11cce73202f@gmail.com>
In-Reply-To: <willemdebruijn.kernel.1a11cce73202f@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 6 Sep 2025 23:53:17 +0800
X-Gm-Features: Ac12FXzMr3LvxGeLsXIpPDoGW-XEOVsQcziD6ZME3mBFxDLF_tTsx0lN25ANDMw
Message-ID: <CAL+tcoBo7ixXKkiy=ywG0UFbcqhSdN==uNg3ykeQo+w6yZ-F6w@mail.gmail.com>
Subject: Re: [PATCH net-next v10 2/2] net: af_packet: Use hrtimer to do the
 retire operation
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Xin Zhao <jackzxcui1989@163.com>, edumazet@google.com, ferenc@fejes.dev, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 11:25=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Sat, Sep 6, 2025 at 12:16=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > On Fri, Sep 5, 2025 at 2:03=E2=80=AFPM Jason Xing <kerneljasonxing@=
gmail.com> wrote:
> > > > >
> > > > > On Fri, Sep 5, 2025 at 12:01=E2=80=AFPM Xin Zhao <jackzxcui1989@1=
63.com> wrote:
> > > > > >
> > > > > > On Thu, Sep 4, 2025 at 11:26=E2=80=AF+0800 Jason Xing <kernelja=
sonxing@gmail.com> wrote:
> > > > > >
> > > > > > > > In the description of [PATCH net-next v10 0/2] net: af_pack=
et: optimize retire operation:
> > > > > > > >
> > > > > > > > Changes in v8:
> > > > > > > > - Delete delete_blk_timer field, as suggested by Willem de =
Bruijn,
> > > > > > > >   hrtimer_cancel will check and wait until the timer callba=
ck return and ensure
> > > > > > > >   enter enter callback again;
> > > > > > >
> > > > > > > I see the reason now :)
> > > > > > >
> > > > > > > Please know that the history changes through versions will fi=
nally be
> > > > > > > removed, only the official message that will be kept in the g=
it. So
> > > > > > > this kind of change, I think, should be clarified officially =
since
> > > > > > > you're removing a structure member. Adding more descriptions =
will be
> > > > > > > helpful to readers in the future. Thank you.
> > > > > >
> > > > > > I will add some more information to the commit message of this =
2/2 PATCH.
> > > > > >
> > > > > >
> > > > > >
> > > > > > > > Consider the following timing sequence:
> > > > > > > > timer   cpu0 (softirq context, hrtimer timeout)            =
    cpu1 (process context)
> > > > > > > > 0       hrtimer_run_softirq
> > > > > > > > 1         __hrtimer_run_queues
> > > > > > > > 2           __run_hrtimer
> > > > > > > > 3             prb_retire_rx_blk_timer_expired
> > > > > > > > 4               spin_lock(&po->sk.sk_receive_queue.lock);
> > > > > > > > 5               _prb_refresh_rx_retire_blk_timer
> > > > > > > > 6                 hrtimer_forward_now
> > > > > > > > 7               spin_unlock(&po->sk.sk_receive_queue.lock)
> > > > > > > > 8             raw_spin_lock_irq(&cpu_base->lock);          =
    tpacket_rcv
> > > > > > > > 9             enqueue_hrtimer                              =
      spin_lock(&sk->sk_receive_queue.lock);
> > > > > > > > 10                                                         =
      packet_current_rx_frame
> > > > > > > > 11                                                         =
        __packet_lookup_frame_in_block
> > > > > > > > 12            finish enqueue_hrtimer                       =
          prb_open_block
> > > > > > > > 13                                                         =
            _prb_refresh_rx_retire_blk_timer
> > > > > > > > 14                                                         =
              hrtimer_is_queued(&pkc->retire_blk_timer) =3D=3D true
> > > > > > > > 15                                                         =
              hrtimer_forward_now
> > > > > > > > 16                                                         =
                WARN_ON
> > > > > > > > On cpu0 in the timing sequence above, enqueue_hrtimer is no=
t protected by sk_receive_queue.lock,
> > > > > > > > while the hrtimer_forward_now is not protected by raw_spin_=
lock_irq(&cpu_base->lock).
> > > > > > > >
> > > > > > > > In my previous email, I provided an explanation. As a suppl=
ement, I would
> > > > > > > > like to reiterate a paragraph from my earlier response to W=
illem.
> > > > > > > > The point is that when the hrtimer is in the enqueued state=
, you cannot
> > > > > > >
> > > > > > > How about tring hrtimer_is_queued() beforehand?
> > > > > > >
> > > > > > > IIUC, with this patch applied, we will lose the opportunity t=
o refresh
> > > > > > > the timer when the lookup function (in the above path I menti=
oned)
> > > > > > > gets called compared to before. If the packet socket tries to=
 look up
> > > > > > > a new block and it doesn't update its expiry time, the timer =
will soon
> > > > > > > wake up. Does it sound unreasonable?
> > > > > >
> > > > > >
> > > > > > I actually pointed out the issue with the timeout setting in a =
previous email:
> > > > > > https://lore.kernel.org/netdev/20250826030328.878001-1-jackzxcu=
i1989@163.com/.
> > > > > >
> > > > > > Regarding the method you mentioned, using hrtimer_is_queued to =
assist in judgment, I had
> > > > > > discussed this extensively with Willem in previous emails, and =
the conclusion was that
> > > > > > it is not feasible. The reason is that in our scenario, the hrt=
imer always returns
> > > > > > HRTIMER_RESTART, unlike the places you pointed out, such as tcp=
_pacing_check, where the
> > > > > > corresponding hrtimer callbacks all return HRTIMER_NORESTART. S=
ince our scenario returns
> > > > > > HRTIMER_RESTART, this can lead to many troublesome issues. The =
fundamental reason is that
> > > > > > if HRTIMER_RESTART is returned, the hrtimer module will enqueue=
 the hrtimer after the
> > > > > > callback returns, which leads to exiting the protection of our =
sk_receive_queue lock.
> > > > > >
> > > > > > Returning to the functionality here, if we really want to updat=
e the hrtimer's timeout
> > > > > > outside of the timer callback, there are two key points to note=
:
> > > > > >
> > > > > > 1. Accurately knowing whether the current context is a timer ca=
llback or tpacket_rcv.
> > > > > > 2. How to update the hrtimer's timeout in a non-timer callback =
scenario.
> > > > > >
> > > > > > To start with the first point, it has already been explained in=
 previous emails that
> > > > > > executing hrtimer_forward outside of a timer callback is not al=
lowed. Therefore, we
> > > > > > must accurately determine whether we are in a timer callback; o=
nly in that context can
> > > > > > we use the hrtimer_forward function to update.
> > > > > > In the original code, since the same _prb_refresh_rx_retire_blk=
_timer function was called,
> > > > > > distinguishing between contexts required code restructuring. No=
w that this patch removes
> > > > > > the _prb_refresh_rx_retire_blk_timer function, achieving this a=
ccurate distinction is not
> > > > > > too difficult.
> > > > > > The key issue is the second point. If we are not inside the hrt=
imer's callback, we cannot
> > > > > > use hrtimer_forward to update the timeout.
> > > > > > So what other interface can we use? You might
> > > > > > suggest using hrtimer_start, but fundamentally, hrtimer_start c=
annot be called if it has
> > > > > > already been started previously. Therefore, wouldn=E2=80=99t yo=
u need to add hrtimer_cancel to
> > > > > > confirm that the hrtimer has been canceled? Once hrtimer_cancel=
 is added, there will also
> > > > > > be scenarios where it is restarted, which means we need to cons=
ider the concurrent
> > > > > > scenario when the socket exits and also calls hrtimer_cancel. T=
his might require adding
> > > > > > logic for that concurrency scenario, and you might even need to=
 reintroduce the
> > > > > > delete_blk_timer variable to indicate whether the packet_releas=
e operation has been
> > > > > > triggered so that the hrtimer does not restart in the tpacket_r=
cv scenario.
> > > > > >
> > > > > > In fact, in a previous v7 version, I proposed a change that I p=
ersonally thought was
> > > > > > quite good, which can be seen here:
> > > > > > https://lore.kernel.org/netdev/20250822132051.266787-1-jackzxcu=
i1989@163.com/. However,
> > > > > > this change introduced an additional variable and more logic. W=
illem also pointed out
> > > > > > that the added complexity to avoid a non-problematic issue was =
unnecessary.
> > > > >
> > > > > Admittedly it's a bit complex.
> > > > >
> > > > > >
> > > > > > As mentioned in Changes in v8:
> > > > > >   The only special case is when prb_open_block is called from t=
packet_rcv.
> > > > > >   That would set the timeout further into the future than the a=
lready queued
> > > > > >   timer. An earlier timeout is not problematic. No need to add =
complexity to
> > > > > >   avoid that.
> > > > >
> > > > > It'd be better to highlight this in the commit message as well to
> > > > > avoid further repeat questions from others. It's an obvious chang=
e in
> > > > > this patch :)
> > > >
> > > > BTW, I have to emphasize that after this patch, the hrtimer will ru=
n
> > > > periodically and unconditionally. As far as I know, it's not possib=
le
> > > > to run hundreds and thousands packet sockets in production, so it
> > > > might not be a huge problem.
> > >
> > > In tcp each sk has its own hrtimers (tcp_init_xmit_timers).
> >
> > Right, but they don't get woken up so frequently in normal cases. I'm
> > worried because in production I saw a huge impact caused by the 1ms
> > timer from numerous sockets:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3De4dd0d3a2f64b8bd8029ec70f52bdbebd0644408
> > But AFAIK I don't see a real use case where people use so many packet
> > sockets. If it happens, in the future we might get complaints. We'll
> > see:)
>
> Hrtimers share an interrupt.
>
> The worst case additional overhead is if timer expiration is a little
> bit slower than packet arrival rate (and thus tpacket_rcv event rate).
>
> Because the higher the tpacket_rcv rate relatively, the smaller the
> timer callback overhead is. And if timeout frequency is higher than
> tpacket_rcv, it would fire anyway.

That's true.

>
> So worst case the overhead is a doubling of block management calls?

Maybe. I dunno.

>
> I don't have hard numbers but the cost of removing a timer and
> reprogramming from inside tpacket_rcv just to defer seems higher than
> accepting this bounded (relative to other operations) cost of
> spurious wakeups.

A few months ago, I saw that one of the applications had a bug and
created more than one thousand packet sockets, which slowed down the
overall performance. At least, the primary reason for not introducing
big changes from my side is I can't come up with a case that needs so
many packet sockets in production. Hence I align with your perspective
so far :)

Thanks,
Jason

