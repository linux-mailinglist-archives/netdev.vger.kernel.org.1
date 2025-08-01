Return-Path: <netdev+bounces-211369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C202DB185CE
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 18:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5EA61C23D1B
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 16:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0200928CF70;
	Fri,  1 Aug 2025 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AudlOqrg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4BC28C87E
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754065802; cv=none; b=YkPFYbboTwAxsVgBbcp+oKijjbp76L7FBYX38H5L7CJ2q9ma7r6v0e+fKv+lcNefqezKtvNtxKSEKvr0ukGafMFrdpwW74zJYia+I2KOvKaa6GiWyvAPnmjcXSHNYhQiXhXWlbFJuX3LzqAu/6UQ9mA8/kOfQHwTJQy36zVcX4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754065802; c=relaxed/simple;
	bh=TOhjdgtXBZk8RePVQ0ag7zCBD6SGRZXdiHn7T+UX/7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIXta+FSeCbaP5rV5SYKZheN69FgWD1eEURgJ//TT5Gqgluhr4R+na54oMRkdA8H8AE8qvvMrzvSgXJoVhVa3wW3odMd6IiR0wcqdOgh7PM1faZO3uolUkDqjpnAWt/MM9wZCD33u0CUN4aWCFzZ1EHAynzwI0TcGJ3GZHZz+JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AudlOqrg; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-31f255eb191so2096408a91.0
        for <netdev@vger.kernel.org>; Fri, 01 Aug 2025 09:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754065801; x=1754670601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uE0FLJ92omJpNIThZHJ0nHCyQykBtleGSlXomyX3Rug=;
        b=AudlOqrgFK3Dk3agN+ToH6Arfwh4ROV5HYTb6pcbxNpKsAvmiMjaPPITHLloW6gOjr
         BHkGluxD3JTnfj7bspLnFsOiQ3eDsd7OxTIopgBYZcvqZA2v1say+/LyBI3R+NmzrMwv
         g2KLZyjqITGCxN7A0oZU4AVziKOcaL4Pn+Gk9REJ4MPoztsUnMbs0bxGke9Af7gQnYT3
         ulQX41lZdO0ZONvHSsC5wRP1yJQwwsqwbcZTTGz2hQVNG8PxQFxptgzE7BIam1EBrQUP
         UQFBd+wz6KUHlbdfx+81s62pkojIBAIhzDpPgpadP+qYUakIRA0yadseKhOeTw24NVjY
         FgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754065801; x=1754670601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uE0FLJ92omJpNIThZHJ0nHCyQykBtleGSlXomyX3Rug=;
        b=rBiqAe53w2oVd9/ePW/T3vsWclG4mYtEgO+eOhUsejtFm0AAsujJicMmX3wxr49M/L
         sqhefmoxQevaQpSkw2GwZ3stJg7q2nr7Qd4S2gCELfotEv2JotdPtGJ9T4NXD2J7LRVq
         RFc19kvrUyv/uZKA9ueDJd1B6UURTby6bqeW6R8Bi631Nh+aL8GNP2F5r/qaZ6obScVt
         9irI8FAK1KbNEyDgnShCKF0IfCLuvQolvu+GUkpvQQ2D6Gkw2K0wE7ClVUvEa4KY0mYA
         ioro+GPJnKwlEKQMtnINkjfeBmSDwkGIwCVdayHISUaIBPqdzo+AUMu8zusk3YutT+ok
         HUUA==
X-Forwarded-Encrypted: i=1; AJvYcCXfbbo0m9zde9hsfgrIaZ3n6aJrsW81YZPu4Fbs2tBPojwhl0Z3NT1O2l/T4EAF9mRjv0cjdKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YycuvVjIjamr6/5oYE5DQ6pkRoBJuh2jq9rEqE7aIuVZ2MUCPh4
	WwzcDCD+tQb15wl01WeGkjXalC8teu0gbMUZtzeCaCkgciMWns1RkSGl0HEPknIJrv8+DgUGzdG
	kI4+9K7zte+KwecQTGG3ZlVqosNJ+8CcTFpAIqo82
X-Gm-Gg: ASbGnctRB5xh/zpnIV8Zogzos059aO6CngLr8EZNP4MyBN7yStRoh4i+nsqO3uTKebx
	KIeom8gI1/Gwf4K+9ygX6qPGa1VbQd3liIgowBlUDocvDqHIcTtnh4SjRJ1L8DsDnIH+XggpGxK
	yJCuzqIusKk+ExLCkNQl7er9wFuQ1kEMgQHPmAAhlmpcFLDQs/xwLcst7+TEMJeszn1LAfdqBgz
	t7K5GwqYSJ890aHl7pLooFgwN3Ste2yH5wo9RIU
X-Google-Smtp-Source: AGHT+IEsjAzDFNp4aNdqpR23bZpOkisreDar8Y5spcJhAvjfLqXymOIIrhsRJsdIRjwsRBetir5qryrZp3jzrvGZX9U=
X-Received: by 2002:a17:90b:1d12:b0:312:f88d:25f9 with SMTP id
 98e67ed59e1d1-321161ea336mr540178a91.7.1754065800518; Fri, 01 Aug 2025
 09:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731184829.1433735-1-kuniyu@google.com> <CANn89iJKYPAMR+ofaJLsQpew2E-0DH4eLh5-QF7tB56-8BfWxg@mail.gmail.com>
In-Reply-To: <CANn89iJKYPAMR+ofaJLsQpew2E-0DH4eLh5-QF7tB56-8BfWxg@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 1 Aug 2025 09:29:49 -0700
X-Gm-Features: Ac12FXw7VAxdAIFnB_01p-RPPgqrMPY38M1NUt7rvrOSgriMopiJPGKxsd4wsL0
Message-ID: <CAAVpQUCDNGxtk2Hu0P6f0Ec2-2bOdn9H=uq_hpZ3_P-zcxoiLw@mail.gmail.com>
Subject: Re: [PATCH v1 net] netdevsim: Fix wild pointer access in nsim_queue_free().
To: Eric Dumazet <edumazet@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Breno Leitao <leitao@debian.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+8aa80c6232008f7b957d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 12:35=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Jul 31, 2025 at 11:48=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google=
.com> wrote:
> >
> > syzbot reported the splat below. [0]
> >
> > When nsim_queue_uninit() is called from nsim_init_netdevsim(),
> > register_netdevice() has not been called, thus dev->dstats has
> > not been allocated.
> >
> > Let's not call dev_dstats_rx_dropped_add() in such a case.
> >
> >
> > Fixes: 2a68a22304f9 ("netdevsim: account dropped packet length in stats=
 on queue free")
> > Reported-by: syzbot+8aa80c6232008f7b957d@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/688bb9ca.a00a0220.26d0e1.0050.GA=
E@google.com/
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  drivers/net/netdevsim/netdev.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/net=
dev.c
> > index 39fe28af48b9..5cbc005136d8 100644
> > --- a/drivers/net/netdevsim/netdev.c
> > +++ b/drivers/net/netdevsim/netdev.c
> > @@ -710,9 +710,13 @@ static struct nsim_rq *nsim_queue_alloc(void)
> >  static void nsim_queue_free(struct net_device *dev, struct nsim_rq *rq=
)
> >  {
> >         hrtimer_cancel(&rq->napi_timer);
> > -       local_bh_disable();
> > -       dev_dstats_rx_dropped_add(dev, rq->skb_queue.qlen);
> > -       local_bh_enable();
> > +
> > +       if (likely(dev->reg_state !=3D NETREG_UNINITIALIZED)) {
>
> I find this test about reg_state a bit fragile...
>
> I probably would have made dev_dstats_rx_dropped_add() a bit stronger,
> it is not used in a fast path.

I thought I should avoid local_bh_disable() too, but yes,
it's unlikely and in the slow path.

I'll use the blow diff in v2.

Thank you Eric!

>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 5e5de4b0a433c6613224b53750921ab9f5a39c85..0b7ad5ae4b85d480aee8531e8=
21027e6ebe7119b
> 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3021,11 +3021,13 @@ static inline void
> dev_dstats_rx_dropped(struct net_device *dev)
>  static inline void dev_dstats_rx_dropped_add(struct net_device *dev,
>                                              unsigned int packets)
>  {
> -       struct pcpu_dstats *dstats =3D this_cpu_ptr(dev->dstats);
> +       if (dev->dstats) {
> +               struct pcpu_dstats *dstats =3D this_cpu_ptr(dev->dstats);
>
> -       u64_stats_update_begin(&dstats->syncp);
> -       u64_stats_add(&dstats->rx_drops, packets);
> -       u64_stats_update_end(&dstats->syncp);
> +               u64_stats_update_begin(&dstats->syncp);
> +               u64_stats_add(&dstats->rx_drops, packets);
> +               u64_stats_update_end(&dstats->syncp);
> +       }
>  }
>
>  static inline void dev_dstats_tx_add(struct net_device *dev,

