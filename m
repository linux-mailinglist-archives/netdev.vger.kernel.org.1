Return-Path: <netdev+bounces-220408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CBBB45DBB
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 18:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 814CB189BD8F
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 16:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6EB1A9F90;
	Fri,  5 Sep 2025 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAVcJdZW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E2ADF49;
	Fri,  5 Sep 2025 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088981; cv=none; b=NWjl28zh9cMB2Nk2ZBrEtKXEibciJA982h+vtt6LXx2Qv3Qm32LU8l82ydwdHJLdWL0Dlyb1oRT+BGGebRN7ok0v13rhdkavHgF7nAdbdXyHjtM+xi0bMa0+/NZrE00CP6e3aazJ/OtURYx0ACtkCNjz2agA660BvxuubXWGMg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088981; c=relaxed/simple;
	bh=Y6nkfP6Mwe27gp2rtTzYBrNNgDXClm2/w37BCIXTatA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=BRtHjv4nQe4hyY1OxXN/eW6dRDgD7SeXCPhLJgAcvLU6SjylzbfxABYgq/1TsN1hTrj0CA+NGhTvqgxK+2rYfLFnOGE4qt/x86Du9mwW2awQ7HtQtOmZ0i14e1PGmSSbhv4BaHTqLdcEaO7xZExzb948PsSXtckj1trkCMwNRr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAVcJdZW; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-544a59e1e87so589517e0c.1;
        Fri, 05 Sep 2025 09:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757088979; x=1757693779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMSDoxqp1jtSfCJb+RjwFgpr+xmb0GbqAbZ92coeYUU=;
        b=bAVcJdZW0kAGIvu6JevZMkCD8pPqUAhujp7R9TNLd30aZP3XT+gvF8gfJbosZdQ82k
         rfpuknajPcvs0pVN3g7wcgmgvEyQCpjGZ7IUf2Z4ZretA/ArE9l3XB3HmUteneUeDH/z
         UumCaH7aqw0gcFYCWuwA+AS6MbAzJKVlsvct0Cy8Qi9xNDX5uFUmRCqO9zTAETWWB7dD
         z+SVUEeGrezFJUuM1MJWUv8SZhYsECsEQOK4MHSL1wKy0SjBV0a06LuG3p8z+Fzw1XqC
         PaZ+xn1z3YHIqFaKwfAAo8BWMCGP5CKsjm3tsNAD5cnbxTYjsZdAg9rrzzB46KyXzhBG
         J2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757088979; x=1757693779;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aMSDoxqp1jtSfCJb+RjwFgpr+xmb0GbqAbZ92coeYUU=;
        b=EsE45+ywZ4AfyZMgOXVnr7WJNUSDanNRH5yjQfmBYEf5+n3Kdn9iTtM9n6jf7kHxzB
         RkNniHAfciOMatJ/YWj3QJ88yxfbCzylNkdPDD2EJvz+yodQtnKhzsTfQmL1VdRXEk6K
         sT7D59OxsEWoTUAmGgct732ea347VNKauMgFrndSB220LPVKepRFZ6DvAh8Rl9mQKrBy
         09jg2q1l6ka6YKAJNKM0/bNJZPx5v2K1xsSB4v1OzER8Iqu9khNCJXMqmnCxik4xY4ol
         IVu8/EdgjmYU1CDbLhgDPvgeLEFVN0G/BlJZ4yE1flg+UsATp0tRaSsTfqEHILcY2klF
         KGxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHWoGaRZn0KnC8BVNCVC1odHERSdHQtTYJWxcZvowkUsfOPqSMzuTGLHu98aR6/ILnUCYd5nZRqqeNaRg=@vger.kernel.org, AJvYcCUkdqC2SkIibcoWkess8+0oSC9QGlTwnaK8DAAgohrcg8zHGrpYsge7ThlrRtOMkdqsLikQveti@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr9V9y1jT8EX1ILI+Tp6ndDidY9okgcCQlQL7EY1MIpKzMrik4
	NsP8Unb9Cbl7Sd40LEBlPRZ6h/uNQAfiEHWmwvv4E/iCMwXWwLu1/XTD
X-Gm-Gg: ASbGncuelDvFEyXfSpmkz4C0vrK9n8xA8RYuawctUIJTIa52L5ifQTY3fuaoqCTDJPb
	+C6MmuJSFuFDmKjumH8KOOCyOm7CYCKtP9xtZxm7ySVpCE/szSAYhpFpYY8gFwqoPO0G+nv2aRc
	ogJdUxYTYfbFhs5IzVYkiMPIYKp3iJOjBNvcz2GsFTz9u1wwwi8jFBTWDmgnvQ+zDsz8C6J48K5
	F1lFWIQobOMbPTpmrppp27FmU6k+q9cugwYjNavc+lYbRGzvLPugCzUeaGpEdkH3GGk9BJsVMUp
	Ho91606gw5aXrseAbTh1A4BNskk2AsWBZ/3xGtp9+aP8XkclTaXPBe3fMKnCEVYGDijmw5k48T8
	VqBdHHp4jdno4YxECZLVXppAVsHOvx2uKkRj+i6x2weWGv9DsJ6iIM27Fr3J1CHpDnybGaTQCi6
	JwNoCpHUJ3H4mcsl4DFRXk/Uw=
X-Google-Smtp-Source: AGHT+IHh/wfMScbBwtIW8QO5qPkZeR5p953JQxTOgqpj5DsncH5t1HAQr1rVSHVCwl1xKQ7zIR1pNQ==
X-Received: by 2002:a05:6122:2022:b0:543:e955:d5fa with SMTP id 71dfb90a1353d-5449ff8d3d3mr8000515e0c.0.1757088978435;
        Fri, 05 Sep 2025 09:16:18 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-54493cf3f24sm9598666e0c.26.2025.09.05.09.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 09:16:17 -0700 (PDT)
Date: Fri, 05 Sep 2025 12:16:17 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Xin Zhao <jackzxcui1989@163.com>
Cc: willemdebruijn.kernel@gmail.com, 
 edumazet@google.com, 
 ferenc@fejes.dev, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.6a80e2e45f24@gmail.com>
In-Reply-To: <CAL+tcoDYfbu7oCWgnWdb2rLee0AtdC9xS9ix9yJ4RQ3TVa6u4g@mail.gmail.com>
References: <20250905040021.1893488-1-jackzxcui1989@163.com>
 <CAL+tcoDxyfAWOWT9gWC7wvcEy8tNYM7pF8suJhwUpdz+MWdxhw@mail.gmail.com>
 <CAL+tcoDYfbu7oCWgnWdb2rLee0AtdC9xS9ix9yJ4RQ3TVa6u4g@mail.gmail.com>
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
> On Fri, Sep 5, 2025 at 2:03=E2=80=AFPM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >
> > On Fri, Sep 5, 2025 at 12:01=E2=80=AFPM Xin Zhao <jackzxcui1989@163.c=
om> wrote:
> > >
> > > On Thu, Sep 4, 2025 at 11:26=E2=80=AF+0800 Jason Xing <kerneljasonx=
ing@gmail.com> wrote:
> > >
> > > > > In the description of [PATCH net-next v10 0/2] net: af_packet: =
optimize retire operation:
> > > > >
> > > > > Changes in v8:
> > > > > - Delete delete_blk_timer field, as suggested by Willem de Brui=
jn,
> > > > >   hrtimer_cancel will check and wait until the timer callback r=
eturn and ensure
> > > > >   enter enter callback again;
> > > >
> > > > I see the reason now :)
> > > >
> > > > Please know that the history changes through versions will finall=
y be
> > > > removed, only the official message that will be kept in the git. =
So
> > > > this kind of change, I think, should be clarified officially sinc=
e
> > > > you're removing a structure member. Adding more descriptions will=
 be
> > > > helpful to readers in the future. Thank you.
> > >
> > > I will add some more information to the commit message of this 2/2 =
PATCH.
> > >
> > >
> > >
> > > > > Consider the following timing sequence:
> > > > > timer   cpu0 (softirq context, hrtimer timeout)                =
cpu1 (process context)
> > > > > 0       hrtimer_run_softirq
> > > > > 1         __hrtimer_run_queues
> > > > > 2           __run_hrtimer
> > > > > 3             prb_retire_rx_blk_timer_expired
> > > > > 4               spin_lock(&po->sk.sk_receive_queue.lock);
> > > > > 5               _prb_refresh_rx_retire_blk_timer
> > > > > 6                 hrtimer_forward_now
> > > > > 7               spin_unlock(&po->sk.sk_receive_queue.lock)
> > > > > 8             raw_spin_lock_irq(&cpu_base->lock);              =
tpacket_rcv
> > > > > 9             enqueue_hrtimer                                  =
  spin_lock(&sk->sk_receive_queue.lock);
> > > > > 10                                                             =
  packet_current_rx_frame
> > > > > 11                                                             =
    __packet_lookup_frame_in_block
> > > > > 12            finish enqueue_hrtimer                           =
      prb_open_block
> > > > > 13                                                             =
        _prb_refresh_rx_retire_blk_timer
> > > > > 14                                                             =
          hrtimer_is_queued(&pkc->retire_blk_timer) =3D=3D true
> > > > > 15                                                             =
          hrtimer_forward_now
> > > > > 16                                                             =
            WARN_ON
> > > > > On cpu0 in the timing sequence above, enqueue_hrtimer is not pr=
otected by sk_receive_queue.lock,
> > > > > while the hrtimer_forward_now is not protected by raw_spin_lock=
_irq(&cpu_base->lock).
> > > > >
> > > > > In my previous email, I provided an explanation. As a supplemen=
t, I would
> > > > > like to reiterate a paragraph from my earlier response to Wille=
m.
> > > > > The point is that when the hrtimer is in the enqueued state, yo=
u cannot
> > > >
> > > > How about tring hrtimer_is_queued() beforehand?
> > > >
> > > > IIUC, with this patch applied, we will lose the opportunity to re=
fresh
> > > > the timer when the lookup function (in the above path I mentioned=
)
> > > > gets called compared to before. If the packet socket tries to loo=
k up
> > > > a new block and it doesn't update its expiry time, the timer will=
 soon
> > > > wake up. Does it sound unreasonable?
> > >
> > >
> > > I actually pointed out the issue with the timeout setting in a prev=
ious email:
> > > https://lore.kernel.org/netdev/20250826030328.878001-1-jackzxcui198=
9@163.com/.
> > >
> > > Regarding the method you mentioned, using hrtimer_is_queued to assi=
st in judgment, I had
> > > discussed this extensively with Willem in previous emails, and the =
conclusion was that
> > > it is not feasible. The reason is that in our scenario, the hrtimer=
 always returns
> > > HRTIMER_RESTART, unlike the places you pointed out, such as tcp_pac=
ing_check, where the
> > > corresponding hrtimer callbacks all return HRTIMER_NORESTART. Since=
 our scenario returns
> > > HRTIMER_RESTART, this can lead to many troublesome issues. The fund=
amental reason is that
> > > if HRTIMER_RESTART is returned, the hrtimer module will enqueue the=
 hrtimer after the
> > > callback returns, which leads to exiting the protection of our sk_r=
eceive_queue lock.
> > >
> > > Returning to the functionality here, if we really want to update th=
e hrtimer's timeout
> > > outside of the timer callback, there are two key points to note:
> > >
> > > 1. Accurately knowing whether the current context is a timer callba=
ck or tpacket_rcv.
> > > 2. How to update the hrtimer's timeout in a non-timer callback scen=
ario.
> > >
> > > To start with the first point, it has already been explained in pre=
vious emails that
> > > executing hrtimer_forward outside of a timer callback is not allowe=
d. Therefore, we
> > > must accurately determine whether we are in a timer callback; only =
in that context can
> > > we use the hrtimer_forward function to update.
> > > In the original code, since the same _prb_refresh_rx_retire_blk_tim=
er function was called,
> > > distinguishing between contexts required code restructuring. Now th=
at this patch removes
> > > the _prb_refresh_rx_retire_blk_timer function, achieving this accur=
ate distinction is not
> > > too difficult.
> > > The key issue is the second point. If we are not inside the hrtimer=
's callback, we cannot
> > > use hrtimer_forward to update the timeout.
> > > So what other interface can we use? You might
> > > suggest using hrtimer_start, but fundamentally, hrtimer_start canno=
t be called if it has
> > > already been started previously. Therefore, wouldn=E2=80=99t you ne=
ed to add hrtimer_cancel to
> > > confirm that the hrtimer has been canceled? Once hrtimer_cancel is =
added, there will also
> > > be scenarios where it is restarted, which means we need to consider=
 the concurrent
> > > scenario when the socket exits and also calls hrtimer_cancel. This =
might require adding
> > > logic for that concurrency scenario, and you might even need to rei=
ntroduce the
> > > delete_blk_timer variable to indicate whether the packet_release op=
eration has been
> > > triggered so that the hrtimer does not restart in the tpacket_rcv s=
cenario.
> > >
> > > In fact, in a previous v7 version, I proposed a change that I perso=
nally thought was
> > > quite good, which can be seen here:
> > > https://lore.kernel.org/netdev/20250822132051.266787-1-jackzxcui198=
9@163.com/. However,
> > > this change introduced an additional variable and more logic. Wille=
m also pointed out
> > > that the added complexity to avoid a non-problematic issue was unne=
cessary.
> >
> > Admittedly it's a bit complex.
> >
> > >
> > > As mentioned in Changes in v8:
> > >   The only special case is when prb_open_block is called from tpack=
et_rcv.
> > >   That would set the timeout further into the future than the alrea=
dy queued
> > >   timer. An earlier timeout is not problematic. No need to add comp=
lexity to
> > >   avoid that.
> >
> > It'd be better to highlight this in the commit message as well to
> > avoid further repeat questions from others. It's an obvious change in=

> > this patch :)
> =

> BTW, I have to emphasize that after this patch, the hrtimer will run
> periodically and unconditionally. As far as I know, it's not possible
> to run hundreds and thousands packet sockets in production, so it
> might not be a huge problem.

In tcp each sk has its own hrtimers (tcp_init_xmit_timers). =


> Or else, numerous timers are likely to
> cause spikes/jitters, especially when timeout is very small (which can
> be 1ms timeout for HZ=3D1000 system). It would be great if you state th=
e
> possible side effects in the next version.
> =

> Willem, any thoughts on this?

Essentially that is what the existing timer also did. There was no
path where the timer was being disabled.

It could be continuously delayed from tpacket_rcv if that happened
came before the timer fires each time. That is no longer the case
with this change. It is probably good to call that out explicitly.



