Return-Path: <netdev+bounces-163120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7E1A29594
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 17:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097983A4C84
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33B918A6D7;
	Wed,  5 Feb 2025 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fsEhsinM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BB7197A8B
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738771239; cv=none; b=GB+q+47ngSLX/UncGEXo62z0WPwo+7TmnA3xKpjA2kMYQtDGEBZY7mvkmxQ67zbzN88u100FPys1Goq37V8gyRAz4i9AEi0dRWA66Hx9Ifk3pgyfFztwMfLtxLfJLCX0KppIOLpxhFkodR0ms8VNEvO5ouiSdgnyDoVrfSxJpfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738771239; c=relaxed/simple;
	bh=JyF9N/NKQzuUvYfjjv7MilKf8RWbp9WHlHliLoQ4A80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGwxZzB/o8bMZwzaeCJ0FOPU811H482kIDrqpodR2oge4Rvbk4y3joWXjyw1REKEYbr5H50O+BckgIzQhldpy5jGxFSGqmlElfNlpUFm7o6o1L+fw0OV4bJnHMgwLFH8IcVGQxiZDnjp7XD+Pr3WYNp5DmQnq5G155y0Q3sihyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fsEhsinM; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5dcd9158685so2502552a12.3
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 08:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738771236; x=1739376036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=074NBHYhuGi557UdfSV5pHNBMivsFNGn53Mdz6TE6I0=;
        b=fsEhsinMs8P7GxcFx2grlkoUzGnuyJqotabc4YemB3LX1eudAoPdgCV3abdOwlZVpE
         6FdHmUDF8JGskwJW/HPp/QSKd3ToXRt2N3BJ3+IKYRgXMRgPo5Qx2PwLYObQZwyth9G8
         fqTxARQDSVHwFytW1FySMjkXclPx7Ch5vjapts/KBpKw0FqWOpA/Mtu05TGI0IfUls0J
         xk6qKg/L7oAypdDgbqjrOIW/2SPY4On3vKiK2xtssD/B8Vp9xhI/Bd8Uq5gX9pVN4Vde
         tGCA7PFHBr9giJcKzrk8bMvs1mANZUQrO3aGDkX2jiJFkYcGJ1iktT8vz0M+XzHBD/ql
         Euvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738771236; x=1739376036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=074NBHYhuGi557UdfSV5pHNBMivsFNGn53Mdz6TE6I0=;
        b=l1zhJajvpa0IPtBb8lllR+AFZ4Gsfmtxs2d5HU4PebKMAE5ZCreuf3ciaP3n3GcVX/
         JMCyR7ZcKo/NXS6v5LPNB5jgtxbvHUFpW1kYHrwTgTPz+62zky6b3OLHa3NIDsZGGFeO
         WSrQIcn2iArThI7z8n3I6VLWFTm+kBVWdsRlh2jXJDMTE+UrkRKtai7Q0TVAh1rDOX4B
         AJRT7jGAOoYvW8Afz+2+8QLAZwXThucggojWP07frtzWaMx+llGbC4lL6RAPbjcPzu79
         iPY3VbkBTm7MIRTalvdb+jlfqE1I6b+CH10SU53Q1dkx7SbFK0MGnaQjhup3Kud2cFPv
         QDnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLH4X7BX8sWuK45FPJp6WTzlZ6pY4T/lTxOUAn+88NpXqCBB0f7yiSOPS05VHt/xxQV8Ta5uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWiMMKUpvxEHgcLuxjEpBXmNFqMFdbI66c4oRBpQJ4zFYjlgNx
	nU13U4z7KWIB1DtC6ju54cRv2cQ+Von6NHpPfETPzMhtiWWV+JxeV5VdllO5EZCst/7BMKJxkHg
	n0oJF8A3EAVIpa4ZvrhKAlN5HsZD06rN6+4U+LqQVEQTxO2efbQ==
X-Gm-Gg: ASbGnctQvud8ENp6J3af+bsKKYn90ztsBIVByINhOtreB2Sa7Ys79LL8OkUlL/Kq7hQ
	Wsg2E2azryVt0AOCocal39qa3z0HZDJTh8TxX44OoOH5NJMd949sTsz3C9uGPYjEzpTATLkN1
X-Google-Smtp-Source: AGHT+IFw5odlxGi78EFC9EaiEdWg0Lh6jDaVm9wSLymHbF5/DfEYAlSQ05AJlhhcQtuajH/RSMB2mLWDYe6n7O6qyjY=
X-Received: by 2002:a05:6402:40cd:b0:5d1:fb79:c1b2 with SMTP id
 4fb4d7f45d1cf-5dcdb732c20mr4483736a12.11.1738771234152; Wed, 05 Feb 2025
 08:00:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204144825.316785-1-edumazet@google.com> <CAL+tcoDCoSVdV_doreW9mqxxfxfn2oGw3ucNKCDFuLmDzkK=cQ@mail.gmail.com>
In-Reply-To: <CAL+tcoDCoSVdV_doreW9mqxxfxfn2oGw3ucNKCDFuLmDzkK=cQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Feb 2025 17:00:23 +0100
X-Gm-Features: AWEUYZkuQVz2wIKcQYfCZUUe7OjMn1mckWAipVsA688X0uN-3g0vIlS5a7rNTx4
Message-ID: <CANn89i+c_3C5FFv_M+jOPupyMULprP5=GhV97ZW=3za+ToCejw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: flush_backlog() small changes
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 4:22=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> Hi Eric,
>
> On Tue, Feb 4, 2025 at 10:49=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > Add READ_ONCE() around reads of skb->dev->reg_state, because
> > this field can be changed from other threads/cpus.
> >
> > Instead of calling dev_kfree_skb_irq() and kfree_skb()
> > while interrupts are masked and locks held,
> > use a temporary list and use __skb_queue_purge_reason()
> >
> > Use SKB_DROP_REASON_DEV_READY drop reason to better
> > describe why these skbs are dropped.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/core/dev.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index c0021cbd28fc11e4c4eb6184d98a2505fa674871..cd31e78a7d8a2229e3dc17d=
08bb638f862148823 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -6119,16 +6119,18 @@ EXPORT_SYMBOL(netif_receive_skb_list);
> >  static void flush_backlog(struct work_struct *work)
> >  {
> >         struct sk_buff *skb, *tmp;
> > +       struct sk_buff_head list;
> >         struct softnet_data *sd;
> >
> > +       __skb_queue_head_init(&list);
> >         local_bh_disable();
> >         sd =3D this_cpu_ptr(&softnet_data);
> >
> >         backlog_lock_irq_disable(sd);
> >         skb_queue_walk_safe(&sd->input_pkt_queue, skb, tmp) {
> > -               if (skb->dev->reg_state =3D=3D NETREG_UNREGISTERING) {
> > +               if (READ_ONCE(skb->dev->reg_state) =3D=3D NETREG_UNREGI=
STERING) {
> >                         __skb_unlink(skb, &sd->input_pkt_queue);
> > -                       dev_kfree_skb_irq(skb);
> > +                       __skb_queue_tail(&list, skb);
>
> I wonder why we cannot simply replace the above function with
> 'dev_kfree_skb_irq_reason(skb, SKB_DROP_REASON_DEV_READY);'?

Because this horribly expensive thing pushes packets to another perc-cpu li=
st,
and raises a softirq to perform the freeing later from BH.


>
> >                         rps_input_queue_head_incr(sd);
> >                 }
> >         }
> > @@ -6136,14 +6138,16 @@ static void flush_backlog(struct work_struct *w=
ork)
> >
> >         local_lock_nested_bh(&softnet_data.process_queue_bh_lock);
> >         skb_queue_walk_safe(&sd->process_queue, skb, tmp) {
> > -               if (skb->dev->reg_state =3D=3D NETREG_UNREGISTERING) {
> > +               if (READ_ONCE(skb->dev->reg_state) =3D=3D NETREG_UNREGI=
STERING) {
> >                         __skb_unlink(skb, &sd->process_queue);
> > -                       kfree_skb(skb);
> > +                       __skb_queue_tail(&list, skb);
>
> Same here.

Please read the changelog, I think you missed the point.

>
> >                         rps_input_queue_head_incr(sd);
> >                 }
> >         }
> >         local_unlock_nested_bh(&softnet_data.process_queue_bh_lock);
> >         local_bh_enable();
> > +
> > +       __skb_queue_purge_reason(&list, SKB_DROP_REASON_DEV_READY);
>
> I'm also worried that dev_kfree_skb_irq() is not the same as
> kfree_skb_reason() because of the following commit:
> commit 7df5cb75cfb8acf96c7f2342530eb41e0c11f4c3
> Author: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
> Date:   Thu Jul 23 11:31:48 2020 -0600
>
>     dev: Defer free of skbs in flush_backlog
>
>     IRQs are disabled when freeing skbs in input queue.
>     Use the IRQ safe variant to free skbs here.
>
>     Fixes: 145dd5f9c88f ("net: flush the softnet backlog in process conte=
xt")
>     Signed-off-by: Subash Abhinov Kasiviswanathan <subashab@codeaurora.or=
g>
>     Signed-off-by: David S. Miller <davem@davemloft.net>

The point of this patch is to no longer attempt the kfree_skb() while being
in hard or soft irq blocking sections.

Therefore call efficient kfree_skb() instead of expensive fallbacks
that were designed
for callers in hard irq contexts.

