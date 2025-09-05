Return-Path: <netdev+bounces-220234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F3AB44DD2
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 08:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D40033ABCF6
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 06:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89B7281368;
	Fri,  5 Sep 2025 06:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2ifH0C5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F4D2701B8;
	Fri,  5 Sep 2025 06:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757052261; cv=none; b=SaWHJR5TgUNcy46dEBQvGJZJB8C2nXOtJ7+E2q/iXA4/kxZMLunnZMOswkuT3DtaUtG2e30Qv4Flo887it0Y3eXIqGyJvEeMv3DSSDao4eNyarOIbGIEJ5L6ty1uDCPV0Zq9eXUThYuFEHHLqveY1BDNi7ocpAaxGcfBbtsvXJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757052261; c=relaxed/simple;
	bh=HmjbunLEzRsRk/ZTamrUb88Ve5f4cz84c8bpjMnqi3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNoo7mXX7aTXc8oVMrIs8gtZB374btWx40/iTu9UANHBs5dnFLtfFadnZ4p7zpYgROtjP8YrPvO2H3+LnabZhyhahIcRFKPjNhzUgH9Du6AQe2GYnOsCH8MkghZb0YbbGTJGhwk0Q9bySu3nS9ZJHrjVXfut1k1maiB4EF+1ddY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2ifH0C5; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3f663c571ffso19027175ab.1;
        Thu, 04 Sep 2025 23:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757052259; x=1757657059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqqG99XdMrAd2jqq6H0JJFOaA0Ryarr1Yvyzp3zS8B4=;
        b=O2ifH0C5hnndC9FV6g+EbY8jFxt6iQQMnIhvCRgsecTgGGspShl1UevhN18jK24joj
         YeTLKKOsQSG/kVTXu6o7W0bqbRQMgj9n6BOYuEDmZkLMHdnsODyjeNetJY0MGZj7KQZj
         9APGkmCdkHDa4e7/Me24+p83Sw0s8iP+zZ4ziwTIHihj9Sd6pN/tkvzXsJMgjkqOa/VC
         pnxva/OR8XigzINuQuoCq33s5OQidhBy61Q9/8rN2FnmjgRDgiELsln95056t9Y+e8qj
         6SuGa4p6agsDie+4M7vwBKaJZ1Yod+KCQOnnf91VM+NxYBdDm8NCWGGWDwYR71OUhT9l
         EvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757052259; x=1757657059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqqG99XdMrAd2jqq6H0JJFOaA0Ryarr1Yvyzp3zS8B4=;
        b=Ap8i1s3S1Wkff6v3H4RgYCdr1x74myrD0/kdiU1gdNBBue6u3YKh18DR5ayfibIt//
         mcmEoYAp442PHwos6esa7LFTrjRI/Jl3q+qbu5DWGwU6uyBfaDxd5LjjCLcJ2P1mxYz2
         nke7GmwT0KKNNbEL4XBTiKg4YcxnKFvnV060MfvworkbUIau26jNme0oKZXR+dD5bzvd
         rOc1Y6+e8lZ0ODaO9iahDKJjZkfAAGvhH2ssPP1Olk6mGR6Ssz4xoTUtwtC3pzoF+cYd
         EfgCQpsuYn2UajJOs3XtR6U5mY5QHM0q26D7xGrqmYKv832b0A+RxKCfyDugp6Actkrx
         693g==
X-Forwarded-Encrypted: i=1; AJvYcCUwsJEyeQprw+TVwaEU4Bu5+N12sNW4Y+9OBUsTp7kkR7/UtkY+rNfSq+ReSCuB3No/A4159J9X@vger.kernel.org, AJvYcCXWeQHva9um7iJmsMClPe/imi1gby25dBezof0+3FNG/sbxQuGkFCsu+aqrnbt3+rKIF9M+0d+dI3N8vG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLlfoVoshL6vomMXrlduSw+FJRo72gffWeTUIaVv3FJDRqxCm/
	F3HQssVG+eeEE2CPAlGIM8v9MEqrmXouwRdxqqVNH8q1l6oWERCBo44IF/NkoyJLAUETtH+lcmK
	+KV77ECPowdQUTo7M/Bj2PgDS6SCDASk=
X-Gm-Gg: ASbGncskm/MR66wT2CmXg3izF2lWOAAnYLFmS8mOmymHrvs5/OGJS1ARqHYu0SrlJwq
	hddj1VQWdAo3Sn1AsylgNEuMrJiWiG6nkspJwvnK29x34C4mkjNkyut0tHBp8V/eIJokTdgKnkN
	fHfVgcaN1oIbAJPVNiAI4FdpFfVoI+Q3QxQpQr6+2yNoHfRLh1lypV6JBZdxoQArk0ewvaNMkdV
	j9/IYOtwFHbI9KHfJyX4A==
X-Google-Smtp-Source: AGHT+IHY7W6fRw0PtIeKmDTwqYrzr7HzSY0z2rXbI1Ev3Ki7jWlTXaQ8YZBUQZSAAb2llhE6a7ykJxlcqn48s1+6Fes=
X-Received: by 2002:a05:6e02:b2a:b0:3f8:e97d:1bd1 with SMTP id
 e9e14a558f8ab-3f8e97d2040mr11921285ab.0.1757052258871; Thu, 04 Sep 2025
 23:04:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905040021.1893488-1-jackzxcui1989@163.com>
In-Reply-To: <20250905040021.1893488-1-jackzxcui1989@163.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 5 Sep 2025 14:03:41 +0800
X-Gm-Features: Ac12FXyTd5Kt1wcd7IjIAKD7eYm2C4nZSFJfhukXRhAVbb6w3h2BBeFgksmfdx8
Message-ID: <CAL+tcoDxyfAWOWT9gWC7wvcEy8tNYM7pF8suJhwUpdz+MWdxhw@mail.gmail.com>
Subject: Re: [PATCH net-next v10 2/2] net: af_packet: Use hrtimer to do the
 retire operation
To: Xin Zhao <jackzxcui1989@163.com>
Cc: willemdebruijn.kernel@gmail.com, edumazet@google.com, ferenc@fejes.dev, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 12:01=E2=80=AFPM Xin Zhao <jackzxcui1989@163.com> wr=
ote:
>
> On Thu, Sep 4, 2025 at 11:26=E2=80=AF+0800 Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
>
> > > In the description of [PATCH net-next v10 0/2] net: af_packet: optimi=
ze retire operation:
> > >
> > > Changes in v8:
> > > - Delete delete_blk_timer field, as suggested by Willem de Bruijn,
> > >   hrtimer_cancel will check and wait until the timer callback return =
and ensure
> > >   enter enter callback again;
> >
> > I see the reason now :)
> >
> > Please know that the history changes through versions will finally be
> > removed, only the official message that will be kept in the git. So
> > this kind of change, I think, should be clarified officially since
> > you're removing a structure member. Adding more descriptions will be
> > helpful to readers in the future. Thank you.
>
> I will add some more information to the commit message of this 2/2 PATCH.
>
>
>
> > > Consider the following timing sequence:
> > > timer   cpu0 (softirq context, hrtimer timeout)                cpu1 (=
process context)
> > > 0       hrtimer_run_softirq
> > > 1         __hrtimer_run_queues
> > > 2           __run_hrtimer
> > > 3             prb_retire_rx_blk_timer_expired
> > > 4               spin_lock(&po->sk.sk_receive_queue.lock);
> > > 5               _prb_refresh_rx_retire_blk_timer
> > > 6                 hrtimer_forward_now
> > > 7               spin_unlock(&po->sk.sk_receive_queue.lock)
> > > 8             raw_spin_lock_irq(&cpu_base->lock);              tpacke=
t_rcv
> > > 9             enqueue_hrtimer                                    spin=
_lock(&sk->sk_receive_queue.lock);
> > > 10                                                               pack=
et_current_rx_frame
> > > 11                                                                 __=
packet_lookup_frame_in_block
> > > 12            finish enqueue_hrtimer                                 =
prb_open_block
> > > 13                                                                   =
  _prb_refresh_rx_retire_blk_timer
> > > 14                                                                   =
    hrtimer_is_queued(&pkc->retire_blk_timer) =3D=3D true
> > > 15                                                                   =
    hrtimer_forward_now
> > > 16                                                                   =
      WARN_ON
> > > On cpu0 in the timing sequence above, enqueue_hrtimer is not protecte=
d by sk_receive_queue.lock,
> > > while the hrtimer_forward_now is not protected by raw_spin_lock_irq(&=
cpu_base->lock).
> > >
> > > In my previous email, I provided an explanation. As a supplement, I w=
ould
> > > like to reiterate a paragraph from my earlier response to Willem.
> > > The point is that when the hrtimer is in the enqueued state, you cann=
ot
> >
> > How about tring hrtimer_is_queued() beforehand?
> >
> > IIUC, with this patch applied, we will lose the opportunity to refresh
> > the timer when the lookup function (in the above path I mentioned)
> > gets called compared to before. If the packet socket tries to look up
> > a new block and it doesn't update its expiry time, the timer will soon
> > wake up. Does it sound unreasonable?
>
>
> I actually pointed out the issue with the timeout setting in a previous e=
mail:
> https://lore.kernel.org/netdev/20250826030328.878001-1-jackzxcui1989@163.=
com/.
>
> Regarding the method you mentioned, using hrtimer_is_queued to assist in =
judgment, I had
> discussed this extensively with Willem in previous emails, and the conclu=
sion was that
> it is not feasible. The reason is that in our scenario, the hrtimer alway=
s returns
> HRTIMER_RESTART, unlike the places you pointed out, such as tcp_pacing_ch=
eck, where the
> corresponding hrtimer callbacks all return HRTIMER_NORESTART. Since our s=
cenario returns
> HRTIMER_RESTART, this can lead to many troublesome issues. The fundamenta=
l reason is that
> if HRTIMER_RESTART is returned, the hrtimer module will enqueue the hrtim=
er after the
> callback returns, which leads to exiting the protection of our sk_receive=
_queue lock.
>
> Returning to the functionality here, if we really want to update the hrti=
mer's timeout
> outside of the timer callback, there are two key points to note:
>
> 1. Accurately knowing whether the current context is a timer callback or =
tpacket_rcv.
> 2. How to update the hrtimer's timeout in a non-timer callback scenario.
>
> To start with the first point, it has already been explained in previous =
emails that
> executing hrtimer_forward outside of a timer callback is not allowed. The=
refore, we
> must accurately determine whether we are in a timer callback; only in tha=
t context can
> we use the hrtimer_forward function to update.
> In the original code, since the same _prb_refresh_rx_retire_blk_timer fun=
ction was called,
> distinguishing between contexts required code restructuring. Now that thi=
s patch removes
> the _prb_refresh_rx_retire_blk_timer function, achieving this accurate di=
stinction is not
> too difficult.
> The key issue is the second point. If we are not inside the hrtimer's cal=
lback, we cannot
> use hrtimer_forward to update the timeout.
> So what other interface can we use? You might
> suggest using hrtimer_start, but fundamentally, hrtimer_start cannot be c=
alled if it has
> already been started previously. Therefore, wouldn=E2=80=99t you need to =
add hrtimer_cancel to
> confirm that the hrtimer has been canceled? Once hrtimer_cancel is added,=
 there will also
> be scenarios where it is restarted, which means we need to consider the c=
oncurrent
> scenario when the socket exits and also calls hrtimer_cancel. This might =
require adding
> logic for that concurrency scenario, and you might even need to reintrodu=
ce the
> delete_blk_timer variable to indicate whether the packet_release operatio=
n has been
> triggered so that the hrtimer does not restart in the tpacket_rcv scenari=
o.
>
> In fact, in a previous v7 version, I proposed a change that I personally =
thought was
> quite good, which can be seen here:
> https://lore.kernel.org/netdev/20250822132051.266787-1-jackzxcui1989@163.=
com/. However,
> this change introduced an additional variable and more logic. Willem also=
 pointed out
> that the added complexity to avoid a non-problematic issue was unnecessar=
y.

Admittedly it's a bit complex.

>
> As mentioned in Changes in v8:
>   The only special case is when prb_open_block is called from tpacket_rcv=
.
>   That would set the timeout further into the future than the already que=
ued
>   timer. An earlier timeout is not problematic. No need to add complexity=
 to
>   avoid that.

It'd be better to highlight this in the commit message as well to
avoid further repeat questions from others. It's an obvious change in
this patch :)

In the meanwhile, you should adjust the comments above
prb_retire_rx_blk_timer_expired() and prb_open_block() because you
removed the refresh logic there.

>
> It is not problematic, as Willem point it out in
> https://lore.kernel.org/netdev/willemdebruijn.kernel.2d7599ee951fd@gmail.=
com/
>
>
> In the end:
>
> So, if you agree with the current changes in v10 and do not wish to add t=
he timeout
> setting under tpacket_rcv, that=E2=80=99s fine.
> If you do not agree, then the only alternative I can think of is to use a=
 combination
> of hrtimer_cancel and hrtimer_start under prb_open_block, and we would al=
so need to
> reintroduce the delete_blk_timer variable to help determine whether the h=
rtimer was
> canceled due to the packet_release behavior. If we really want to make th=
is change,
> it does add quite a bit of logic, and we would also need Willem's agreeme=
nt.

Thanks, I think I know enough about this long background. Let's stick
with the approach you provided in the next respin :)

Thanks,
Jason

