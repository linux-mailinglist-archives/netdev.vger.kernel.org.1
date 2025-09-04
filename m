Return-Path: <netdev+bounces-219792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4D0B43006
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 04:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93BAF1B252B2
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 02:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E151E0083;
	Thu,  4 Sep 2025 02:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgCC0RtK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AB11D63F7;
	Thu,  4 Sep 2025 02:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756954271; cv=none; b=l8+7Vx8MJlXldODHqvuflgoo/kOYQHa/jSvwSFmvWw/a9xcbln6FxsMnxkbVhxENFlD0ZHdmqH6eWBeocL3voUHlz3yH7KyYLT8eU3H8+O6ormFd5e06Mg15V8FZI+9yGdpBkNdXgZgRstCnEdpalt0WONiPPhTxBU6CnSPoaSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756954271; c=relaxed/simple;
	bh=OF30K7FDdcXtvu5oS0/wdWuR2qoZi0C7UesAYg7PKOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JKnG+z/F9W75JtT0Cbi2q3Li3kkkidV0oF/xNB/QKk32INAkbimYMPj5ehDm8FfUYcaS/rJqvi6B4MyJ00OzsVSJw3rwVxamfl/1eqhrLSaDc4QaIHgE18nG2zVoUHTls70ja7zJeplolDFSc9YwOEKZQoUXeO0AhTJAW/rlwNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgCC0RtK; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3f05a8fa19bso6397535ab.1;
        Wed, 03 Sep 2025 19:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756954269; x=1757559069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdYYElzui6keIWtchIjfaAQ3jyOTkggwQRUR9HmccM0=;
        b=cgCC0RtKqWxTpCjY2aHmQ5AAwT7JvSnMt2KkrRK7g01seedlS+DwzCcjo9oEIMeI5O
         eI9Sy7AVPh49CEsGc5q7QxkFUq+4JS6qfj4NMhgPbLeooGXNs1bfFpP3IVpHeSayVLPO
         fP6m9kxrlBIrodwVEfIPFLDlPj02G0KFH6FrUkXk9HZgUjzD04lWF2awQHC6+F52kd++
         AGMANegsJZXChNz2QNsS9F5pOG8Sr8bfdQNS0x0bzN28EYi8KSPuJijBX51hZJRLoEQJ
         cywhYAsvfvd/eYYbuSlD+rFIVgULKV7Uthl30fhDNvOHun2R/mInNG6MheKwqtHZwkqb
         4M6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756954269; x=1757559069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdYYElzui6keIWtchIjfaAQ3jyOTkggwQRUR9HmccM0=;
        b=KhjtIm2Ogkgzu0PQZ2eQax7qzjsDX9QH2WWui9zY055Q2kpzdXMAns5fwYLvEQ9PxU
         MaBlS2wR2AHmrkUh9R1xAcIN8qWSgTR4t3akCBpq69/tHQIIhR7vL4yi2EorhixYuZmD
         scxO2+AtsEyDCRlt44wwgVcxLug1YYfu0LKbYy8A1/5kAYAMNCJzyM0I7pmIWBGVreOG
         l4Q+7RCDXQY5vMNwYzAZTCJ8Cv1U8BjK8ke4it85tYl/yvif8aCBqruDRzfemC2E8HOj
         ZD2MG8phwdrr1sUlQ+M7Dzv60O/S7yV5oZVr+14TQWFyGRwCUL1Jif3gXQfxquYglae+
         IoYg==
X-Forwarded-Encrypted: i=1; AJvYcCU3IYLsBcuP4ow6tmNHS2hOAEbc71vRs4lQxjVw3yfGLSlY7maIDG9MtQ4ZwkkXyrjCIKUUYiAg@vger.kernel.org, AJvYcCXXQRHz1y85IU7hJicknGSZDUArjebz9hmEHUUw6DX75BfHpZJPEau4f9LmhRsvbF07cij4w1o/iKpMEf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBMy0uG789t43dKgv/61113whikEc16Uq3BtxtnsqDvgxbbpzC
	48fj6ZNelimyVK/JP60x5Ir28Fq2DwzYd8Da3cAt5rrX9sdIhv/xkZFhiGIuIZh3V1CbBWPSKDb
	hvEdI+KsASxDXCzqHgvjvYLQwtL+uZ3s=
X-Gm-Gg: ASbGncu1c9yhOv5nu3RIWQruhQags4j+CCotDNm4MhzAoViioL9YKZkd/P1p49qTzKZ
	wkewPAmAN0Z0FDjWsaG79LNuFOaju5tpop+OeCcnDQGpef3XHqSKAhwdvfWv+RayTn9IDFtCX7q
	RdvTbzrHnQu5T5hEnB+HeQ1LJDkQtwTnxowJuXAMg23U8FeVVlnecjsainhEq5fU6K0ME2ojhUE
	f+uBuA99bhU/NNP
X-Google-Smtp-Source: AGHT+IHorivs1eX9ym2GXJm6V1JI0kksTBmT/2MdLfNvO45Ayv/9hE9OY3Vl2xIL/+EKHeq6hJhpeBpes3ywnDBbXIg=
X-Received: by 2002:a05:6e02:1a29:b0:3e9:9473:2801 with SMTP id
 e9e14a558f8ab-3f400475c1cmr269044215ab.10.1756954268657; Wed, 03 Sep 2025
 19:51:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903161709.563847-1-jackzxcui1989@163.com>
In-Reply-To: <20250903161709.563847-1-jackzxcui1989@163.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 4 Sep 2025 10:50:32 +0800
X-Gm-Features: Ac12FXzdwxlqEKk2jx9QINftmgTEfN5cMlsKYrRHWD3sZdZt8q8gNY-nvXdPgTU
Message-ID: <CAL+tcoAMM-eeSdLfnqHrBRiLmiTULi5mJF5AaU5scHP=32s1oQ@mail.gmail.com>
Subject: Re: [PATCH net-next v10 2/2] net: af_packet: Use hrtimer to do the
 retire operation
To: Xin Zhao <jackzxcui1989@163.com>
Cc: willemdebruijn.kernel@gmail.com, edumazet@google.com, ferenc@fejes.dev, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 12:17=E2=80=AFAM Xin Zhao <jackzxcui1989@163.com> wr=
ote:
>
> On Tue, Sep 2, 2025 at 23:43=E2=80=AF+0800 Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
>
> > >         p1->max_frame_len =3D p1->kblk_size - BLK_PLUS_PRIV(p1->blk_s=
izeof_priv);
> > >         prb_init_ft_ops(p1, req_u);
> > > -       prb_setup_retire_blk_timer(po);
> > > +       hrtimer_setup(&p1->retire_blk_timer, prb_retire_rx_blk_timer_=
expired,
> > > +                     CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
> > > +       hrtimer_start(&p1->retire_blk_timer, p1->interval_ktime,
> > > +                     HRTIMER_MODE_REL_SOFT);
> >
> > You expect to see it start at the setsockopt phase? Even if it's far
> > from the real use of recv at the moment.
> >
> > >         prb_open_block(p1, pbd);
> > >  }
>
> Before applying this patch, init_prb_bdqc also start the timer by mod_tim=
er:
>
> init_prb_bdqc
>   prb_open_block
>     _prb_refresh_rx_retire_blk_timer
>       mod_timer
>
> So the current timer's start time is almost the same as it was before app=
lying
> the patch.
>
>
> > > @@ -917,7 +873,6 @@ static void prb_open_block(struct tpacket_kbdq_co=
re *pkc1,
> > >         pkc1->pkblk_end =3D pkc1->pkblk_start + pkc1->kblk_size;
> > >
> > >         prb_thaw_queue(pkc1);
> > > -       _prb_refresh_rx_retire_blk_timer(pkc1);
> >
> > Could you say more on why you remove this here and only reset/update
> > the expiry time in the timer handler? Probably I missed something
> > appearing in the previous long discussion.
> >
> > >
> > >         smp_wmb();
> > >  }
>
> In the description of [PATCH net-next v10 0/2] net: af_packet: optimize r=
etire operation:
>
> Changes in v7:
>   When the callback return, without sk_buff_head lock protection, __run_h=
rtimer will
>   enqueue the timer if return HRTIMER_RESTART. Setting the hrtimer expire=
s while
>   enqueuing a timer may cause chaos in the hrtimer red-black tree.
>
> Neither hrtimer_set_expires nor hrtimer_forward_now is allowed when the h=
rtimer has
> already been enqueued. Therefore, the only place where the hrtimer timeou=
t can be set is
> within the callback, at which point the hrtimer is in a non-enqueued stat=
e and can have
> its timeout set.

Can we use hrtimer_is_queued() instead? Please see tcp_pacing_check()
as an example. But considering your following explanation, I think
it's okay now.

>
>
> Changes in v8:
>   Simplify the logic related to setting timeout, as suggestd by Willem de=
 Bruijn.
>   Currently timer callback just restarts itself unconditionally, so delet=
e the
>  'out:' label, do not forward hrtimer in prb_open_block, call hrtimer_for=
ward_now
>   directly and always return HRTIMER_RESTART. The only special case is wh=
en
>   prb_open_block is called from tpacket_rcv. That would set the timeout f=
urther
>   into the future than the already queued timer. An earlier timeout is no=
t
>   problematic. No need to add complexity to avoid that.
>
> This paragraph explains that if the block's retire timeout is not adjuste=
d within
> the timer callback, it will only result in an earlier-than-expected retir=
e timeout,
> which is not problematic. Therefore, it is unnecessary to increase the lo=
gical complexity
> to ensure block retire timeout occurs as expected each time.

Sounds fair.

>
>
> > The whole structure needs a new organization?
> >
> > Before:
> >         /* size: 152, cachelines: 3, members: 22 */
> >         /* sum members: 144, holes: 2, sum holes: 8 */
> >         /* paddings: 1, sum paddings: 4 */
> >         /* last cacheline: 24 bytes */
> > After:
> >         /* size: 176, cachelines: 3, members: 19 */
> >         /* sum members: 163, holes: 4, sum holes: 13 */
> >         /* paddings: 1, sum paddings: 4 */
> >         /* forced alignments: 1, forced holes: 1, sum forced holes: 6 *=
/
> >         /* last cacheline: 48 bytes */
>
> What about the following organization:?
>
> /* kbdq - kernel block descriptor queue */
> struct tpacket_kbdq_core {
>         struct pgv      *pkbdq;
>         unsigned int    feature_req_word;
>         unsigned int    hdrlen;
>         unsigned short  kactive_blk_num;
>         unsigned short  blk_sizeof_priv;
>         unsigned char   reset_pending_on_curr_blk;
>
>         char            *pkblk_start;
>         char            *pkblk_end;
>         int             kblk_size;
>         unsigned int    max_frame_len;
>         unsigned int    knum_blocks;
>         char            *prev;
>         char            *nxt_offset;
>
>         unsigned short  version;
>
>         uint64_t        knxt_seq_num;
>         struct sk_buff  *skb;
>
>         rwlock_t        blk_fill_in_prog_lock;
>
>         /* timer to retire an outstanding block */
>         struct hrtimer  retire_blk_timer;
>
>         /* Default is set to 8ms */
> #define DEFAULT_PRB_RETIRE_TOV  (8)
>
>         ktime_t         interval_ktime;
> };

Could you share the result after running 'pahole --hex -C
tpacket_kbdq_core vmlinux'?

Thanks,
Jason

