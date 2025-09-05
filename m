Return-Path: <netdev+bounces-220238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4C8B44E33
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 08:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18F5173494
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 06:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3648E233145;
	Fri,  5 Sep 2025 06:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAIdJVmx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831A1A55;
	Fri,  5 Sep 2025 06:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757054749; cv=none; b=opXOXjKqaHgajXRTZw8npcRdBVRsNL9uZ25C4ia0Zn9F/XcdZIuJXK/4D0lKbvzB6dRgNVihumkaaHXbvbeUrJOaI+aDWkfCz6Sz0wY1tHGoCN45NKBrpq8QidPlj+vMJrMiOWdfgkNVSlIaJzLwI46SX+vM8Djx4omgkGvfBs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757054749; c=relaxed/simple;
	bh=D8qjd6uOB+cLD7mni+zG6iqBAqIrkrGPtosL5HqdQpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNheosZihjVqOAyrZhf0OeZ0wmASXUHsdXf54N1SciNgXay7UCs33Lh4ixpMVTOMEzo2h47sF9oMEZ6dHWkZK4dZ9icir+Fmids4bEMmge/E9c5sFpguq0wiyDk3wSfIu1Og9URfPdgHEwqhEyDfF5GOO6gkjP2SRHJVT7Mjs1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAIdJVmx; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3f4d7feef27so12851475ab.3;
        Thu, 04 Sep 2025 23:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757054746; x=1757659546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ObiAp89bZ6nnnxD4zTTgY8mWdO0E5S1BFTQ6XkTPWU=;
        b=XAIdJVmxM1or8c7JKVWe6GMn1emyx0njtQ8I/RmzNxVbf9g+zLb4TZfBuTECYEPhHm
         /FN5rKJDMrU/b+ioCRqMuCuPIHXApKSquAC2jD+fisMNS9Bs/u1IcrCbznaVa60aOvMK
         cvo6mOcsL5jz2Nl+ft9OUu/qgJnN2hVRBkN0r14hHo2ixky8U/ZnLGvSUgWggnZEQEOG
         Qz090XvNQsD5vh5Ad6YHbRu4I7HSJI8u4F+eIDtyyd54QB+fjWbJSt+x2qHT/qYQzXvj
         fi7dl5O11eDNc0UU5wDigp47xaBG7NrRpwUbZjKrGYJ9jrMITpf2Ry8AghhJ6BB0DG3P
         Zm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757054746; x=1757659546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ObiAp89bZ6nnnxD4zTTgY8mWdO0E5S1BFTQ6XkTPWU=;
        b=vCwirgLCfsts7HGLJgeu8lTdlUIQNLNh0Se86mr/rl345UIaRmnLPH0U2DQNp2u1Lb
         J1yr9Zv9ym0+6YVXyVPMVTFWe6bEF+qYlwvGmU1ozy98y1tMn1UV0B6CtuQNU9JygicY
         /kOypZ5FUMoPXJpiOBOU8sHG/N0KX+ywIFX+qwgrS/E/HLj7RdeFCa8vGsuWrRy4J8Hy
         bS08viu+IJ8Ia3Wdjr9T9bUhiH3hdze9NnwqashZmor9OVxdFxeKSwg0hL1jkZjEgeTM
         0yF80TswnOjqprCaPmKBJzCF6Q/fpnLQ2wmMqMjfmzZQo9+A8el0ut9JUF89RsYPA2+C
         aCBw==
X-Forwarded-Encrypted: i=1; AJvYcCVYPAiHkSVyuZ9tkwZI6AUVDspU/dR5KYJRmX34yd8EKxdEDrR1nVtkrNLT/p8+D2vcABc7AChx4IDjLZs=@vger.kernel.org, AJvYcCXjmoNHq3Ib7fAHD1JMi9B4FRQBkJHqo9t9ub0nhhp4WLszhnzmEZGMpM/Ul4S2jqVKDLLL9+zA@vger.kernel.org
X-Gm-Message-State: AOJu0YygU/ifzOY4ADAZ4UluypTsG3k1R5x9mFA8GAVg367G/LUaW4Ej
	18M8kkpPJc8d5KvDFYFUq2Pg35Nl0HqU5xyzBxOpFcfBVsKEPmiulyyKqyYmMjuFuOaesiFBIE3
	vrvfaFi4Sw2VYYGN8uZPwSLkyY4/lWBk=
X-Gm-Gg: ASbGncsCXC51tmL5urFpucQ7lzGj2CVFPXHr7VmGRLLBP42txxxScgfr49HDF0OLKeh
	XTQWZ+4TKxwWQExK3WqnZVo8r0/6l3+woeghR2+56m//EE4c/VXM1D0Z1HTV8XEeCitrwULi/xS
	MCcsXUCPcP9QSdcqLc3p70qBbcHt4bYssvD3UMKhpfvQgW5Xjv8YUAWofOMy1yoz1tkZt/I1WHg
	1KZSybrAb76FJjhNcQtkRxY9IVqyOZ3
X-Google-Smtp-Source: AGHT+IGr4rlyUYeotvjLMlveZYQJ03/SyqoIlIDi+NlWOdBD4pVXZEfnRy8PUghK31+dx0Q/rybz59J8gHh8C9nx/DU=
X-Received: by 2002:a05:6e02:2706:b0:3eb:5862:7cef with SMTP id
 e9e14a558f8ab-3f4024c779cmr296689965ab.22.1757054746457; Thu, 04 Sep 2025
 23:45:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905040021.1893488-1-jackzxcui1989@163.com> <CAL+tcoDxyfAWOWT9gWC7wvcEy8tNYM7pF8suJhwUpdz+MWdxhw@mail.gmail.com>
In-Reply-To: <CAL+tcoDxyfAWOWT9gWC7wvcEy8tNYM7pF8suJhwUpdz+MWdxhw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 5 Sep 2025 14:45:08 +0800
X-Gm-Features: Ac12FXz6J7-kbTv_qE7tOJM-feIbCUDYWLyM7LfI-L3SstbDoio-f2Vac5CK5XA
Message-ID: <CAL+tcoDYfbu7oCWgnWdb2rLee0AtdC9xS9ix9yJ4RQ3TVa6u4g@mail.gmail.com>
Subject: Re: [PATCH net-next v10 2/2] net: af_packet: Use hrtimer to do the
 retire operation
To: Xin Zhao <jackzxcui1989@163.com>
Cc: willemdebruijn.kernel@gmail.com, edumazet@google.com, ferenc@fejes.dev, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 2:03=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Fri, Sep 5, 2025 at 12:01=E2=80=AFPM Xin Zhao <jackzxcui1989@163.com> =
wrote:
> >
> > On Thu, Sep 4, 2025 at 11:26=E2=80=AF+0800 Jason Xing <kerneljasonxing@=
gmail.com> wrote:
> >
> > > > In the description of [PATCH net-next v10 0/2] net: af_packet: opti=
mize retire operation:
> > > >
> > > > Changes in v8:
> > > > - Delete delete_blk_timer field, as suggested by Willem de Bruijn,
> > > >   hrtimer_cancel will check and wait until the timer callback retur=
n and ensure
> > > >   enter enter callback again;
> > >
> > > I see the reason now :)
> > >
> > > Please know that the history changes through versions will finally be
> > > removed, only the official message that will be kept in the git. So
> > > this kind of change, I think, should be clarified officially since
> > > you're removing a structure member. Adding more descriptions will be
> > > helpful to readers in the future. Thank you.
> >
> > I will add some more information to the commit message of this 2/2 PATC=
H.
> >
> >
> >
> > > > Consider the following timing sequence:
> > > > timer   cpu0 (softirq context, hrtimer timeout)                cpu1=
 (process context)
> > > > 0       hrtimer_run_softirq
> > > > 1         __hrtimer_run_queues
> > > > 2           __run_hrtimer
> > > > 3             prb_retire_rx_blk_timer_expired
> > > > 4               spin_lock(&po->sk.sk_receive_queue.lock);
> > > > 5               _prb_refresh_rx_retire_blk_timer
> > > > 6                 hrtimer_forward_now
> > > > 7               spin_unlock(&po->sk.sk_receive_queue.lock)
> > > > 8             raw_spin_lock_irq(&cpu_base->lock);              tpac=
ket_rcv
> > > > 9             enqueue_hrtimer                                    sp=
in_lock(&sk->sk_receive_queue.lock);
> > > > 10                                                               pa=
cket_current_rx_frame
> > > > 11                                                                 =
__packet_lookup_frame_in_block
> > > > 12            finish enqueue_hrtimer                               =
  prb_open_block
> > > > 13                                                                 =
    _prb_refresh_rx_retire_blk_timer
> > > > 14                                                                 =
      hrtimer_is_queued(&pkc->retire_blk_timer) =3D=3D true
> > > > 15                                                                 =
      hrtimer_forward_now
> > > > 16                                                                 =
        WARN_ON
> > > > On cpu0 in the timing sequence above, enqueue_hrtimer is not protec=
ted by sk_receive_queue.lock,
> > > > while the hrtimer_forward_now is not protected by raw_spin_lock_irq=
(&cpu_base->lock).
> > > >
> > > > In my previous email, I provided an explanation. As a supplement, I=
 would
> > > > like to reiterate a paragraph from my earlier response to Willem.
> > > > The point is that when the hrtimer is in the enqueued state, you ca=
nnot
> > >
> > > How about tring hrtimer_is_queued() beforehand?
> > >
> > > IIUC, with this patch applied, we will lose the opportunity to refres=
h
> > > the timer when the lookup function (in the above path I mentioned)
> > > gets called compared to before. If the packet socket tries to look up
> > > a new block and it doesn't update its expiry time, the timer will soo=
n
> > > wake up. Does it sound unreasonable?
> >
> >
> > I actually pointed out the issue with the timeout setting in a previous=
 email:
> > https://lore.kernel.org/netdev/20250826030328.878001-1-jackzxcui1989@16=
3.com/.
> >
> > Regarding the method you mentioned, using hrtimer_is_queued to assist i=
n judgment, I had
> > discussed this extensively with Willem in previous emails, and the conc=
lusion was that
> > it is not feasible. The reason is that in our scenario, the hrtimer alw=
ays returns
> > HRTIMER_RESTART, unlike the places you pointed out, such as tcp_pacing_=
check, where the
> > corresponding hrtimer callbacks all return HRTIMER_NORESTART. Since our=
 scenario returns
> > HRTIMER_RESTART, this can lead to many troublesome issues. The fundamen=
tal reason is that
> > if HRTIMER_RESTART is returned, the hrtimer module will enqueue the hrt=
imer after the
> > callback returns, which leads to exiting the protection of our sk_recei=
ve_queue lock.
> >
> > Returning to the functionality here, if we really want to update the hr=
timer's timeout
> > outside of the timer callback, there are two key points to note:
> >
> > 1. Accurately knowing whether the current context is a timer callback o=
r tpacket_rcv.
> > 2. How to update the hrtimer's timeout in a non-timer callback scenario=
.
> >
> > To start with the first point, it has already been explained in previou=
s emails that
> > executing hrtimer_forward outside of a timer callback is not allowed. T=
herefore, we
> > must accurately determine whether we are in a timer callback; only in t=
hat context can
> > we use the hrtimer_forward function to update.
> > In the original code, since the same _prb_refresh_rx_retire_blk_timer f=
unction was called,
> > distinguishing between contexts required code restructuring. Now that t=
his patch removes
> > the _prb_refresh_rx_retire_blk_timer function, achieving this accurate =
distinction is not
> > too difficult.
> > The key issue is the second point. If we are not inside the hrtimer's c=
allback, we cannot
> > use hrtimer_forward to update the timeout.
> > So what other interface can we use? You might
> > suggest using hrtimer_start, but fundamentally, hrtimer_start cannot be=
 called if it has
> > already been started previously. Therefore, wouldn=E2=80=99t you need t=
o add hrtimer_cancel to
> > confirm that the hrtimer has been canceled? Once hrtimer_cancel is adde=
d, there will also
> > be scenarios where it is restarted, which means we need to consider the=
 concurrent
> > scenario when the socket exits and also calls hrtimer_cancel. This migh=
t require adding
> > logic for that concurrency scenario, and you might even need to reintro=
duce the
> > delete_blk_timer variable to indicate whether the packet_release operat=
ion has been
> > triggered so that the hrtimer does not restart in the tpacket_rcv scena=
rio.
> >
> > In fact, in a previous v7 version, I proposed a change that I personall=
y thought was
> > quite good, which can be seen here:
> > https://lore.kernel.org/netdev/20250822132051.266787-1-jackzxcui1989@16=
3.com/. However,
> > this change introduced an additional variable and more logic. Willem al=
so pointed out
> > that the added complexity to avoid a non-problematic issue was unnecess=
ary.
>
> Admittedly it's a bit complex.
>
> >
> > As mentioned in Changes in v8:
> >   The only special case is when prb_open_block is called from tpacket_r=
cv.
> >   That would set the timeout further into the future than the already q=
ueued
> >   timer. An earlier timeout is not problematic. No need to add complexi=
ty to
> >   avoid that.
>
> It'd be better to highlight this in the commit message as well to
> avoid further repeat questions from others. It's an obvious change in
> this patch :)

BTW, I have to emphasize that after this patch, the hrtimer will run
periodically and unconditionally. As far as I know, it's not possible
to run hundreds and thousands packet sockets in production, so it
might not be a huge problem. Or else, numerous timers are likely to
cause spikes/jitters, especially when timeout is very small (which can
be 1ms timeout for HZ=3D1000 system). It would be great if you state the
possible side effects in the next version.

Willem, any thoughts on this?

Thanks,
Jason

