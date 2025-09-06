Return-Path: <netdev+bounces-220512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3508B46770
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 02:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91B4C5C6806
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 00:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E7F79EA;
	Sat,  6 Sep 2025 00:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/vmHvgv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B890FCA4B;
	Sat,  6 Sep 2025 00:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757117681; cv=none; b=D/mupNlKLlkudypql3gVPkCxJCjN0B8yfZmXomdDwLy7JRv6RecopJ/+2cDa0U6fm531wiCTc6+B2YBUkSH6Trb7Dcq7anPwdTvlKTALDTNwNPHdtqyv9PdaZpPluAT4J2/l3GWkSAyde7Z7V7W1MAdqgaub2QJwcQAY7qLGdwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757117681; c=relaxed/simple;
	bh=b5RFy70RT8KrVTVaBvf7BbOsOEpDqUWWhb9k4Qqdwt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TI4Dr5PPZUHFIxoKRowlR1UzaL+YFtEH4UmGCP0Ys9rJf6dG0eZ4wKhZPu1xwWwG1QxDgqwz/N9TkX6OxamBzrchTuNTu6aU5G/hDZuyrvVmZQKqbfeGsdCpJkSPRB4V5V9Sk9d6oEIuAGmzPnn0w+PGkgvhiIB8w97c1hk/kNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/vmHvgv; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3f80e8fab9bso16448035ab.3;
        Fri, 05 Sep 2025 17:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757117679; x=1757722479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiDuiNmaZNxOe1vrzhZw/yrbe58pPT5AJhYBTyqsRck=;
        b=O/vmHvgv8QgyKG6lWx97TbQEAxRd+jqBmgppoBHbtNaV2PDVt9AuHj6lFdw7X4es0T
         X34h/fhMsLiTwFb/r3eiBbL93X4Qhv8fNL9DzGtUvOpX5W70D7XUVJkBCIzZcGdaoH7q
         e/UlGDXbuQkgVyI65AQcogg8zPcrF1M5wEMfm+2yDcMtIlbmWfSAP1BWr6whMnD9RfMg
         x2FTbTLx4O86dIpxRKbfzicJh4DGwehkX0kVnQk0Imu3Naak0FbJzY9UEmZGF7E4qVSv
         mRilhQgzXlfbJEry0XQRUhYzjrv/9JE3aYmtbxTiAkEJ27+ah1j+VcctVMshYLdH3H7a
         rmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757117679; x=1757722479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiDuiNmaZNxOe1vrzhZw/yrbe58pPT5AJhYBTyqsRck=;
        b=GM0QLJFUysy4ADT4X2pqzREZGyPnWWPKJtlmQMKLO6Kd/efpAzmxi8wGhfLaKJS8nw
         JIqEroWcind8aNPMCE7SA47q8h7gLPYrWKbb8rE95Qru+P9N6miPeUeNYQFzmpCv74IF
         mA6pxVNvIGijhJcWOSPyl7CpSalGQOfhNN5UwePiGse6yCKcLTGcsHyZUVe4zK6ftJe3
         iCMW/sNCx7EXBUt0Vb35prkOpQVz/XbhbGt7DijPL3FlMCeITnCCp9jj70jPXtRa8BIE
         x1c4oMQfSJZw0gdDZlDbXRrGJObb76kBS9gaiZVKZW6wknQlg/xk2b3VLR2HhcVpk7cU
         U3bA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ/bA8GOCjvVxajc7d99U5iMS/E5VaQ3JyHzerWjZx9/68Omi0WQCLoY8WHjs6x6uIIERqZA+T@vger.kernel.org, AJvYcCUnuNJvXoFWeh1JgKhRIkuM+Oj7Lf+zqkNMd44QRI23VNC7fssEjTz5q+szFuF6rCQJ9Rsys35i/S9Glzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqCyyiZRuIyeDS797G7QCjiS4p+Rw0cgUN3/hPx4DQdMKBLCTy
	yPgkB7DiW2wMWEcXjq+tm42GBEmiLX5m2vxRchh41IWm92ksOUQQ0w2X+fHynThLae/PUMI0j6s
	d8GP9jz20F7rMN9waiCOmuytyLLP+mJI=
X-Gm-Gg: ASbGncsdDwfuzxSOYjC84yitTRcLi8iCCYhYpEZIhdCYY9GwuMO0C5bTxLSvzljRXOV
	Y0x/0/C3mrL3H2xDLZk3bLEDOgtxyCu2YBpFadT6c1itXYlE91iIumMDLg6cBZP1/fkgoRMXWzc
	ASp4QsJb5alngB4Zmyhf48GAJIJuz31gZ4gpk57H7ZT3Id4HH46VgfPwzdJsyBUMJuXh2QsS0nP
	fi9p4cVGap+D7oY8J0C
X-Google-Smtp-Source: AGHT+IGU0cXDBPG8yAPSUJWdh2MB9MuKsZGi2W5aRHFNyVopHo1nFV+PmwOjYd+HiIHz5k4UFzdKCwiFWfFC9lLqO/g=
X-Received: by 2002:a05:6e02:218e:b0:3f6:69ec:ea17 with SMTP id
 e9e14a558f8ab-3fd89071964mr17394225ab.29.1757117678657; Fri, 05 Sep 2025
 17:14:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905040021.1893488-1-jackzxcui1989@163.com>
 <CAL+tcoDxyfAWOWT9gWC7wvcEy8tNYM7pF8suJhwUpdz+MWdxhw@mail.gmail.com>
 <CAL+tcoDYfbu7oCWgnWdb2rLee0AtdC9xS9ix9yJ4RQ3TVa6u4g@mail.gmail.com> <willemdebruijn.kernel.6a80e2e45f24@gmail.com>
In-Reply-To: <willemdebruijn.kernel.6a80e2e45f24@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 6 Sep 2025 08:14:02 +0800
X-Gm-Features: Ac12FXzuYyK8FhzU3zCUUbktYarpO07wKBZXxm2mjR-3BE9H5hGoGflLjlDMyIs
Message-ID: <CAL+tcoBX4URyxxxuCT3XdzJ7R2zS-DjobdKfMjwc-R7h=ptFCg@mail.gmail.com>
Subject: Re: [PATCH net-next v10 2/2] net: af_packet: Use hrtimer to do the
 retire operation
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Xin Zhao <jackzxcui1989@163.com>, edumazet@google.com, ferenc@fejes.dev, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 12:16=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Fri, Sep 5, 2025 at 2:03=E2=80=AFPM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> > >
> > > On Fri, Sep 5, 2025 at 12:01=E2=80=AFPM Xin Zhao <jackzxcui1989@163.c=
om> wrote:
> > > >
> > > > On Thu, Sep 4, 2025 at 11:26=E2=80=AF+0800 Jason Xing <kerneljasonx=
ing@gmail.com> wrote:
> > > >
> > > > > > In the description of [PATCH net-next v10 0/2] net: af_packet: =
optimize retire operation:
> > > > > >
> > > > > > Changes in v8:
> > > > > > - Delete delete_blk_timer field, as suggested by Willem de Brui=
jn,
> > > > > >   hrtimer_cancel will check and wait until the timer callback r=
eturn and ensure
> > > > > >   enter enter callback again;
> > > > >
> > > > > I see the reason now :)
> > > > >
> > > > > Please know that the history changes through versions will finall=
y be
> > > > > removed, only the official message that will be kept in the git. =
So
> > > > > this kind of change, I think, should be clarified officially sinc=
e
> > > > > you're removing a structure member. Adding more descriptions will=
 be
> > > > > helpful to readers in the future. Thank you.
> > > >
> > > > I will add some more information to the commit message of this 2/2 =
PATCH.
> > > >
> > > >
> > > >
> > > > > > Consider the following timing sequence:
> > > > > > timer   cpu0 (softirq context, hrtimer timeout)                =
cpu1 (process context)
> > > > > > 0       hrtimer_run_softirq
> > > > > > 1         __hrtimer_run_queues
> > > > > > 2           __run_hrtimer
> > > > > > 3             prb_retire_rx_blk_timer_expired
> > > > > > 4               spin_lock(&po->sk.sk_receive_queue.lock);
> > > > > > 5               _prb_refresh_rx_retire_blk_timer
> > > > > > 6                 hrtimer_forward_now
> > > > > > 7               spin_unlock(&po->sk.sk_receive_queue.lock)
> > > > > > 8             raw_spin_lock_irq(&cpu_base->lock);              =
tpacket_rcv
> > > > > > 9             enqueue_hrtimer                                  =
  spin_lock(&sk->sk_receive_queue.lock);
> > > > > > 10                                                             =
  packet_current_rx_frame
> > > > > > 11                                                             =
    __packet_lookup_frame_in_block
> > > > > > 12            finish enqueue_hrtimer                           =
      prb_open_block
> > > > > > 13                                                             =
        _prb_refresh_rx_retire_blk_timer
> > > > > > 14                                                             =
          hrtimer_is_queued(&pkc->retire_blk_timer) =3D=3D true
> > > > > > 15                                                             =
          hrtimer_forward_now
> > > > > > 16                                                             =
            WARN_ON
> > > > > > On cpu0 in the timing sequence above, enqueue_hrtimer is not pr=
otected by sk_receive_queue.lock,
> > > > > > while the hrtimer_forward_now is not protected by raw_spin_lock=
_irq(&cpu_base->lock).
> > > > > >
> > > > > > In my previous email, I provided an explanation. As a supplemen=
t, I would
> > > > > > like to reiterate a paragraph from my earlier response to Wille=
m.
> > > > > > The point is that when the hrtimer is in the enqueued state, yo=
u cannot
> > > > >
> > > > > How about tring hrtimer_is_queued() beforehand?
> > > > >
> > > > > IIUC, with this patch applied, we will lose the opportunity to re=
fresh
> > > > > the timer when the lookup function (in the above path I mentioned=
)
> > > > > gets called compared to before. If the packet socket tries to loo=
k up
> > > > > a new block and it doesn't update its expiry time, the timer will=
 soon
> > > > > wake up. Does it sound unreasonable?
> > > >
> > > >
> > > > I actually pointed out the issue with the timeout setting in a prev=
ious email:
> > > > https://lore.kernel.org/netdev/20250826030328.878001-1-jackzxcui198=
9@163.com/.
> > > >
> > > > Regarding the method you mentioned, using hrtimer_is_queued to assi=
st in judgment, I had
> > > > discussed this extensively with Willem in previous emails, and the =
conclusion was that
> > > > it is not feasible. The reason is that in our scenario, the hrtimer=
 always returns
> > > > HRTIMER_RESTART, unlike the places you pointed out, such as tcp_pac=
ing_check, where the
> > > > corresponding hrtimer callbacks all return HRTIMER_NORESTART. Since=
 our scenario returns
> > > > HRTIMER_RESTART, this can lead to many troublesome issues. The fund=
amental reason is that
> > > > if HRTIMER_RESTART is returned, the hrtimer module will enqueue the=
 hrtimer after the
> > > > callback returns, which leads to exiting the protection of our sk_r=
eceive_queue lock.
> > > >
> > > > Returning to the functionality here, if we really want to update th=
e hrtimer's timeout
> > > > outside of the timer callback, there are two key points to note:
> > > >
> > > > 1. Accurately knowing whether the current context is a timer callba=
ck or tpacket_rcv.
> > > > 2. How to update the hrtimer's timeout in a non-timer callback scen=
ario.
> > > >
> > > > To start with the first point, it has already been explained in pre=
vious emails that
> > > > executing hrtimer_forward outside of a timer callback is not allowe=
d. Therefore, we
> > > > must accurately determine whether we are in a timer callback; only =
in that context can
> > > > we use the hrtimer_forward function to update.
> > > > In the original code, since the same _prb_refresh_rx_retire_blk_tim=
er function was called,
> > > > distinguishing between contexts required code restructuring. Now th=
at this patch removes
> > > > the _prb_refresh_rx_retire_blk_timer function, achieving this accur=
ate distinction is not
> > > > too difficult.
> > > > The key issue is the second point. If we are not inside the hrtimer=
's callback, we cannot
> > > > use hrtimer_forward to update the timeout.
> > > > So what other interface can we use? You might
> > > > suggest using hrtimer_start, but fundamentally, hrtimer_start canno=
t be called if it has
> > > > already been started previously. Therefore, wouldn=E2=80=99t you ne=
ed to add hrtimer_cancel to
> > > > confirm that the hrtimer has been canceled? Once hrtimer_cancel is =
added, there will also
> > > > be scenarios where it is restarted, which means we need to consider=
 the concurrent
> > > > scenario when the socket exits and also calls hrtimer_cancel. This =
might require adding
> > > > logic for that concurrency scenario, and you might even need to rei=
ntroduce the
> > > > delete_blk_timer variable to indicate whether the packet_release op=
eration has been
> > > > triggered so that the hrtimer does not restart in the tpacket_rcv s=
cenario.
> > > >
> > > > In fact, in a previous v7 version, I proposed a change that I perso=
nally thought was
> > > > quite good, which can be seen here:
> > > > https://lore.kernel.org/netdev/20250822132051.266787-1-jackzxcui198=
9@163.com/. However,
> > > > this change introduced an additional variable and more logic. Wille=
m also pointed out
> > > > that the added complexity to avoid a non-problematic issue was unne=
cessary.
> > >
> > > Admittedly it's a bit complex.
> > >
> > > >
> > > > As mentioned in Changes in v8:
> > > >   The only special case is when prb_open_block is called from tpack=
et_rcv.
> > > >   That would set the timeout further into the future than the alrea=
dy queued
> > > >   timer. An earlier timeout is not problematic. No need to add comp=
lexity to
> > > >   avoid that.
> > >
> > > It'd be better to highlight this in the commit message as well to
> > > avoid further repeat questions from others. It's an obvious change in
> > > this patch :)
> >
> > BTW, I have to emphasize that after this patch, the hrtimer will run
> > periodically and unconditionally. As far as I know, it's not possible
> > to run hundreds and thousands packet sockets in production, so it
> > might not be a huge problem.
>
> In tcp each sk has its own hrtimers (tcp_init_xmit_timers).

Right, but they don't get woken up so frequently in normal cases. I'm
worried because in production I saw a huge impact caused by the 1ms
timer from numerous sockets:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3De4dd0d3a2f64b8bd8029ec70f52bdbebd0644408
But AFAIK I don't see a real use case where people use so many packet
sockets. If it happens, in the future we might get complaints. We'll
see:)

Thanks,
Jason

