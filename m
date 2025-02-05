Return-Path: <netdev+bounces-163132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B099A29608
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 17:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86943A396A
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2842C194A44;
	Wed,  5 Feb 2025 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bonuQoZm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8149A18A6D7
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738772261; cv=none; b=LHF6C8Z/aAXX5jmaJad/ER36VS3UB0UY4cZrQaFjrEgaM8gMso/pODJWfziN1BoVsMlLUDMfSO42ER2OAVdhMr8jdpu9AbYxJVuuqjNEbxPBSYXYkIhBuoeNHfD349mQ4nccWbegxUOzlz1x3HsDTJTSGEZRscBcU2SApwFmNFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738772261; c=relaxed/simple;
	bh=YnfiA2/0X3RazuECYQeitXyQikrlbWZ+n7p2UF/xxxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XfRAqbzFfVdcqiyLyh+R1MurSKUDKh20P3MsVK8Lx7f8tqHpaRAjvSxvfiq7WSlOSarDawaaumR/cZ8xS65gq4MEcN1VEL/ZbbEdPGrZM37pfZKq0Ty/7nlsSdBKRMHCAbQqAhZsvhUI/vRX85ORXXffMuXRZAQHESl/Li5P+FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bonuQoZm; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3ce7c4115e8so3338625ab.1
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 08:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738772258; x=1739377058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atc085lUzexoNlY938Tq3NFnPxhCVbA3umTm7KgZPXI=;
        b=bonuQoZmCwkNV1xwqI6B1HJTq3Wvz0bji1WtS6BMUdWjeg195b1fFCkGFj4Wo/WzCS
         BdBOY/J11wAyApNgn59spCsp3VpP8E5pIwx39Uw6hKVTGo8xtGBUj+wFBdOZurvWsOz8
         353Ao5XNYDVfMsHLWzXYQu0fRi0e1+N/OHZ5zIuvNYu+y4RkHNJjDZ7jNd80/9DuZSy7
         IPPKeBFzL4ieecA32mrXMq0ZS213AtbliNNLu/PIsHy/s5QZbBVZRbB+zivJFGiEYeMl
         pLp6JQYvpC1tTHCYP10jmVbJSF5SeLBYJoYXLBLiX4lwBwmdHmusvIhR0FIVuGGzQMPI
         08rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738772258; x=1739377058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atc085lUzexoNlY938Tq3NFnPxhCVbA3umTm7KgZPXI=;
        b=b4U6x8wGybgiK7KUvt7ihzcPXZtifSNJnk6MGQYhYhn2QDrISDz0CuY1ZPqF+otxD7
         S4HvNGguXkM9iJlvVLbWF3GgAteISK61RScePmfq+tN32nKQzcAZ8vCrHJWzfbb8AHT/
         blglRpk05ECIN+Vazvb3+/CqtGEJmfWJ9OdMaFwtzn6jowY5Qu6ncHmWiy6Y5KPrzx6h
         yBek5DkazXwgRRMlGcFRk1M0xBHKkUBxPD4o6VVl6LU9LzFf1heH/C3Pb1ZtyFFiN0K1
         7IukbonAAMhdrXQG9I9fSL2PxywPCAS8jlMyxJsr2xWy0twmd0gJ4T/vCkwyOkh+dTZS
         epkA==
X-Forwarded-Encrypted: i=1; AJvYcCW2FIXD4t2zj+QdvCEmFTwJvNU0JhCXAU8OqYteu3O01I+L9ARIG72ijcukV90uuVl69cDPsjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg1Wqc8f5/kaXA7UF672DFTEeJnGHvEFp4Us5avPSbn8ZQun5j
	R/RwlTn15Zcoigp3uMYXoQsnbFAR9CcTXvfRp0jr0ra4MYQhbtxDPVHOeHfGVLv4cNsAqT4vAVo
	ww97Q0zy5++O6Mm7OUp91d1G4BUI=
X-Gm-Gg: ASbGncvx1jSYHq9Sn9h37hZT9RO+6p2j4s1h2q8ZvbA+a+d805vxJeIe0ne2DAfkDyq
	VL8gPI2F2Gu+djuBJJZ+9DVal/jP1vjljkMMJXwycbwNtqgIf3hPgSPq/aJVSSuqmZe3Qaz0=
X-Google-Smtp-Source: AGHT+IGzpiJqiwBcGd5Nl9xrMaRyWoUAnGtk4JdNBmIMDCm8PpuYJWtgdOIoe03Qg241B/E9QUxB/vRrdxxMnC9xpbY=
X-Received: by 2002:a05:6e02:1fe7:b0:3cf:ba90:6ad9 with SMTP id
 e9e14a558f8ab-3d05a24e629mr85965ab.9.1738772258449; Wed, 05 Feb 2025 08:17:38
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204144825.316785-1-edumazet@google.com> <CAL+tcoDCoSVdV_doreW9mqxxfxfn2oGw3ucNKCDFuLmDzkK=cQ@mail.gmail.com>
 <CANn89i+c_3C5FFv_M+jOPupyMULprP5=GhV97ZW=3za+ToCejw@mail.gmail.com>
In-Reply-To: <CANn89i+c_3C5FFv_M+jOPupyMULprP5=GhV97ZW=3za+ToCejw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Feb 2025 00:17:02 +0800
X-Gm-Features: AWEUYZmp33M_zp9IUTmjfmkTSXAJzg0uPfdCDYvGD1fjg_Ww13J4fcjDN40BWjg
Message-ID: <CAL+tcoA-fwcq7LRPx7z=42YC_CNsrNMoUznCPf8OkkSdWyiJAA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: flush_backlog() small changes
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 12:00=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Feb 5, 2025 at 4:22=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > Hi Eric,
> >
> > On Tue, Feb 4, 2025 at 10:49=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > Add READ_ONCE() around reads of skb->dev->reg_state, because
> > > this field can be changed from other threads/cpus.
> > >
> > > Instead of calling dev_kfree_skb_irq() and kfree_skb()
> > > while interrupts are masked and locks held,
> > > use a temporary list and use __skb_queue_purge_reason()
> > >
> > > Use SKB_DROP_REASON_DEV_READY drop reason to better
> > > describe why these skbs are dropped.
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > >  net/core/dev.c | 12 ++++++++----
> > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index c0021cbd28fc11e4c4eb6184d98a2505fa674871..cd31e78a7d8a2229e3dc1=
7d08bb638f862148823 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -6119,16 +6119,18 @@ EXPORT_SYMBOL(netif_receive_skb_list);
> > >  static void flush_backlog(struct work_struct *work)
> > >  {
> > >         struct sk_buff *skb, *tmp;
> > > +       struct sk_buff_head list;
> > >         struct softnet_data *sd;
> > >
> > > +       __skb_queue_head_init(&list);
> > >         local_bh_disable();
> > >         sd =3D this_cpu_ptr(&softnet_data);
> > >
> > >         backlog_lock_irq_disable(sd);
> > >         skb_queue_walk_safe(&sd->input_pkt_queue, skb, tmp) {
> > > -               if (skb->dev->reg_state =3D=3D NETREG_UNREGISTERING) =
{
> > > +               if (READ_ONCE(skb->dev->reg_state) =3D=3D NETREG_UNRE=
GISTERING) {
> > >                         __skb_unlink(skb, &sd->input_pkt_queue);
> > > -                       dev_kfree_skb_irq(skb);
> > > +                       __skb_queue_tail(&list, skb);
> >
> > I wonder why we cannot simply replace the above function with
> > 'dev_kfree_skb_irq_reason(skb, SKB_DROP_REASON_DEV_READY);'?
>
> Because this horribly expensive thing pushes packets to another perc-cpu =
list,
> and raises a softirq to perform the freeing later from BH.

Agreed about this case. How about changing kfree_skb_reason(skb, ...)?

>
>
> >
> > >                         rps_input_queue_head_incr(sd);
> > >                 }
> > >         }
> > > @@ -6136,14 +6138,16 @@ static void flush_backlog(struct work_struct =
*work)
> > >
> > >         local_lock_nested_bh(&softnet_data.process_queue_bh_lock);
> > >         skb_queue_walk_safe(&sd->process_queue, skb, tmp) {
> > > -               if (skb->dev->reg_state =3D=3D NETREG_UNREGISTERING) =
{
> > > +               if (READ_ONCE(skb->dev->reg_state) =3D=3D NETREG_UNRE=
GISTERING) {
> > >                         __skb_unlink(skb, &sd->process_queue);
> > > -                       kfree_skb(skb);
> > > +                       __skb_queue_tail(&list, skb);
> >
> > Same here.
>
> Please read the changelog, I think you missed the point.

I meant why not directly use kfree_skb_reason(skb, ...) here? It's
simpler, right? Then don't bother to use a temporary list.

>
> >
> > >                         rps_input_queue_head_incr(sd);
> > >                 }
> > >         }
> > >         local_unlock_nested_bh(&softnet_data.process_queue_bh_lock);
> > >         local_bh_enable();
> > > +
> > > +       __skb_queue_purge_reason(&list, SKB_DROP_REASON_DEV_READY);
> >
> > I'm also worried that dev_kfree_skb_irq() is not the same as
> > kfree_skb_reason() because of the following commit:
> > commit 7df5cb75cfb8acf96c7f2342530eb41e0c11f4c3
> > Author: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
> > Date:   Thu Jul 23 11:31:48 2020 -0600
> >
> >     dev: Defer free of skbs in flush_backlog
> >
> >     IRQs are disabled when freeing skbs in input queue.
> >     Use the IRQ safe variant to free skbs here.
> >
> >     Fixes: 145dd5f9c88f ("net: flush the softnet backlog in process con=
text")
> >     Signed-off-by: Subash Abhinov Kasiviswanathan <subashab@codeaurora.=
org>
> >     Signed-off-by: David S. Miller <davem@davemloft.net>
>
> The point of this patch is to no longer attempt the kfree_skb() while bei=
ng
> in hard or soft irq blocking sections.
>
> Therefore call efficient kfree_skb() instead of expensive fallbacks
> that were designed
> for callers in hard irq contexts.

Thanks for the explanation!

Thanks,
Jason

