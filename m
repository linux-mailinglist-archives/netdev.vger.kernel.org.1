Return-Path: <netdev+bounces-219798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2F4B43077
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 05:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34CB1C23CB1
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 03:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B7726E71D;
	Thu,  4 Sep 2025 03:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFhSmq+f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C821F1302;
	Thu,  4 Sep 2025 03:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756956424; cv=none; b=nnxIHyv2wgBQQRgAUwyW4mwlOXYXiU5isOFS3C80HOBH2vj2BNln0+3Gy8ESUXHjV+fCX0nhtefaN6Z9tv85Fzmy/SgHQCRf4NAzRoMSr8ivsY6ZZd8d9tIqFhsdEnZUHcAyQFyjYfWiuMeG98d5+tlkpzTmQ73aZYAA6MiUMwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756956424; c=relaxed/simple;
	bh=T7o2vR9v/NyTpj4YHVsT0sDyK1JkjQg5Xz4p1ImpF10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NbGDrwKX+Fbrdb4j/Yxp3NST6nd9C2hlVIV5xn7M+213JE/+9giLugKBnfmbrtpTGGDs1QcN7mixkiUpBP4DD2+CONGW7rKPyGFgoxSrHzeZECLzA6g7JuUreBOe2mWRifLqQxi0f8BvkfUCzN7AcLvKQIzw2lyi5R5lD/JZAH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFhSmq+f; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3f65d600d35so6610025ab.0;
        Wed, 03 Sep 2025 20:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756956422; x=1757561222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bP9u6IDD8DedDeQulxVxdn26xs4TZxFphEmYs0nd0AY=;
        b=jFhSmq+fkGU9HgrenBkQthHWEyAknVggYI+/J8MBO0XRe/xOAjl/uuCbtdSRQTQmS9
         1tRtiYzBM3nS9E82VvTFFVs0MSF/0aIwp/6xXXP50er4O3OSuUofyFdIU9IRZaQSQvu2
         Fvhe+THAqJKhPwsWJrAtmtXgg9pFwCya7t+cBeSrfb5y/s0WJYlSBwNT+O9TeV40cmlq
         C//z1zFdvXjyFKQ5TyVdtC3cXBk5QhlaecPTz9MrKiaTyQ1qSDdp2K+dk1u2sOSxtdWd
         EB+pzRCwfC16lEBxSyZDW6jFLl1t7yYoof99Aiqx8BC3qgwf2UdirlCE0TqZehMvt0SS
         ZOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756956422; x=1757561222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bP9u6IDD8DedDeQulxVxdn26xs4TZxFphEmYs0nd0AY=;
        b=eZY4fQ2CDUGzB/A++kS/M1XRmcD3VlLdMnF4EIr8He4j6QSxYI3LSRAQrLPXR9KcCU
         Sk+dT+bXJeEN1iTm74kEEj+GMutFHHRP2TIVcK7Qg1ZuvtALHBUxHykiQxUCVsZ/kuHn
         WL1qFsp2gGxr9gslnz+HU6ZWL/5gtzL3yHm5WZKkOovNpJUlVbSoZMQYSlYTmeOd/ULP
         MNP0HLNtsyR9FeycxpH73TYW/Lj5i/HjvVqGfD5vmBiWd/VHMyQn1eER9pPGypz5FZYM
         SVzTQ5/2fwuWSIc+5S3lMNEX26xcC2iD4bMfyg4UDIcPi7tEuai+HRDGID0vYBxYNByB
         RG1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWhbPcs33b3E5oAJlqLWknPDys8pls7KaXWC4xwAxtrIOr3cl0cgYvz/dY1LqbKn09nhIN/DvFdr8bEWGM=@vger.kernel.org, AJvYcCWtCLAceuvDiu/3c7c72L+ccvwlS6X/hn1gchm6UC4lCBr6UVvUqqFaQxWekO+7b8FsICrxKRI6@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6mn+1qWxduvNKVe+A7kgMFny7jc5nCLTUIbzPtWbSX4R73q2x
	QXMpIwVJ251UFZGX3C+3RSAmJgKvXOY/sk1zE1xE8gwpB6d0INka8DvoSmK9v77wn4LaCPleAXB
	UKk3zNLHHRub3lRrk/3w4/mWd+gSEee0=
X-Gm-Gg: ASbGncul95fX7Y5gqWva7VfXun2qvAJC8q4orl5fKXsDogbSesQoBZFBj3ztte3wRZ4
	wBBxTr6NTKrfIxgIISYJSxQIyUEQ2KLQ8HzgBv/369txjm+tF7Ci0Xj6uj6fAhKpsDOCZBPnLIB
	1PtL5Qo2ffMmiDw+aQxDQc6F7OxcEPq8wFz8B+OuWqfHEN7Lue+q0apf2enFhPyFT3TAjj4PYhG
	Zutm+L+XHXRzTnu
X-Google-Smtp-Source: AGHT+IFEJoPaNt7tgEVdA9038q9wZC7h1mgWs+ysmO1YruDQCgZ7grUdUWptBw+9V1QPVyWeWoh5iUy+M3r3jRfLweE=
X-Received: by 2002:a05:6e02:168c:b0:3f1:6141:8a40 with SMTP id
 e9e14a558f8ab-3f4021cb5ffmr281884885ab.23.1756956422190; Wed, 03 Sep 2025
 20:27:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903170716.595528-1-jackzxcui1989@163.com>
In-Reply-To: <20250903170716.595528-1-jackzxcui1989@163.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 4 Sep 2025 11:26:26 +0800
X-Gm-Features: Ac12FXwGF5iy9mf_S8K4jjwnYmB644KAbE1Rd4FOgkrdNcUrcjWYN8oW58ugqg0
Message-ID: <CAL+tcoB0dbRnQUFqV9WEzZx+UxjYTt_yP21951HPvu9Dg9jxeg@mail.gmail.com>
Subject: Re: [PATCH net-next v10 2/2] net: af_packet: Use hrtimer to do the
 retire operation
To: Xin Zhao <jackzxcui1989@163.com>
Cc: willemdebruijn.kernel@gmail.com, edumazet@google.com, ferenc@fejes.dev, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 1:07=E2=80=AFAM Xin Zhao <jackzxcui1989@163.com> wro=
te:
>
> On Wed, Sep 3, 2025 at 00:42=E2=80=AF+0800 Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
>
> > One more review from my side is that as to the removal of
> > delete_blk_timer, I'm afraid it deserves a clarification in the commit
> > message.
> >
> > > > -       spin_unlock_bh(&rb_queue->lock);
> > > > -
> > > > -       prb_del_retire_blk_timer(pkc);
> > > > -}
> > > > -
>
> In the description of [PATCH net-next v10 0/2] net: af_packet: optimize r=
etire operation:
>
> Changes in v8:
> - Delete delete_blk_timer field, as suggested by Willem de Bruijn,
>   hrtimer_cancel will check and wait until the timer callback return and =
ensure
>   enter enter callback again;

I see the reason now :)

Please know that the history changes through versions will finally be
removed, only the official message that will be kept in the git. So
this kind of change, I think, should be clarified officially since
you're removing a structure member. Adding more descriptions will be
helpful to readers in the future. Thank you.

>
> I will also emphasize the removal of delete_blk_timer in the commit messa=
ge for this 2/2
> commit. The updated commit message for the 2/2 patch is as follows=EF=BC=
=9A
>
> Changes in v8:
> - Simplify the logic related to setting timeout.
> - Delete delete_blk_timer field, hrtimer_cancel will check and wait until
>   the timer callback return.
>
>
> > I gradually understand your thought behind this modification. You're
> > trying to move the timer operation out of prb_open_block() and then
> > spread the timer operation into each caller.
> >
> > You probably miss the following call trace:
> > packet_current_rx_frame() -> __packet_lookup_frame_in_block() ->
> > prb_open_block() -> _prb_refresh_rx_retire_blk_timer()
> > ?
> >
> > May I ask why bother introducing so many changes like this instead of
> > leaving it as-is?
>
>
>
>
> Consider the following timing sequence:
> timer   cpu0 (softirq context, hrtimer timeout)                cpu1 (proc=
ess context)
> 0       hrtimer_run_softirq
> 1         __hrtimer_run_queues
> 2           __run_hrtimer
> 3             prb_retire_rx_blk_timer_expired
> 4               spin_lock(&po->sk.sk_receive_queue.lock);
> 5               _prb_refresh_rx_retire_blk_timer
> 6                 hrtimer_forward_now
> 7               spin_unlock(&po->sk.sk_receive_queue.lock)
> 8             raw_spin_lock_irq(&cpu_base->lock);              tpacket_rc=
v
> 9             enqueue_hrtimer                                    spin_loc=
k(&sk->sk_receive_queue.lock);
> 10                                                               packet_c=
urrent_rx_frame
> 11                                                                 __pack=
et_lookup_frame_in_block
> 12            finish enqueue_hrtimer                                 prb_=
open_block
> 13                                                                     _p=
rb_refresh_rx_retire_blk_timer
> 14                                                                       =
hrtimer_is_queued(&pkc->retire_blk_timer) =3D=3D true
> 15                                                                       =
hrtimer_forward_now
> 16                                                                       =
  WARN_ON
> On cpu0 in the timing sequence above, enqueue_hrtimer is not protected by=
 sk_receive_queue.lock,
> while the hrtimer_forward_now is not protected by raw_spin_lock_irq(&cpu_=
base->lock).
>
> In my previous email, I provided an explanation. As a supplement, I would
> like to reiterate a paragraph from my earlier response to Willem.
> The point is that when the hrtimer is in the enqueued state, you cannot

How about tring hrtimer_is_queued() beforehand?

IIUC, with this patch applied, we will lose the opportunity to refresh
the timer when the lookup function (in the above path I mentioned)
gets called compared to before. If the packet socket tries to look up
a new block and it doesn't update its expiry time, the timer will soon
wake up. Does it sound unreasonable?

Thanks,
Jason

> call interfaces like hrtimer_forward_now. The kernel has a WARN_ON check
> in hrtimer_forward_now for this reason. Similarly, you also cannot call
> interfaces like hrtimer_set_expires. The kernel does not include a WARN_O=
N
> check in hrtimer_set_expires to avoid increasing the code size, as
> hrtimer_set_expires is an inline function.
>
>
> Thanks
> Xin Zhao
>

