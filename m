Return-Path: <netdev+bounces-230774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 323EEBEF35C
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 06:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD94F3E21B3
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 04:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1FB2BE643;
	Mon, 20 Oct 2025 04:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lwuhqbbn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344972BE639
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 04:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760932811; cv=none; b=pmvqSwLQoWRH+sXV+HjTXirxbOCDqBerJx4YI3gPzRc5b8SyvrtvWEbQ7O50Zw+LHiTnJBnd7CH9xyw7WYrYKI2tU2xvRQrkZMh94H22mPrkS0QjthfPfxvrn8W/DNbGIu/mtqUydoEoJuH/j84/Q85LUavcZRKEGUnTMVYF0BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760932811; c=relaxed/simple;
	bh=dPgG0ZE3Yj/qIHsnysGw2HwgvlzEI7DoOEPYWJ0sbcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqd831rj03WJCsdZnEoteN6Y27qiXNKMpg63h4R9q5nHvWSGG5oq0qtLH3XIF/BHIRUZ5pdSMKIgs9ioMFJd6hdvQZZYW9Gj9jxZGvqTnW/XRdVvZ4qzXasM6HaMAN7SHuuf0Xa/kfqmZMUNiLvzzEh6uzZv1SRumIdQ0ziSAw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lwuhqbbn; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-87be45cba29so56442986d6.2
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 21:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760932807; x=1761537607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGlyUJ6dWl6nFWnMZlQKvO9MHD3+EqVzrC0LlyJOg7g=;
        b=LwuhqbbntQSfrcK24vUDgIHCmT2s/PZJipZslZVRZdd9sbwnGablia5bvmocOyoQaD
         2D3fAtuGknJJIEWIGDORYQ6JhZUes22s3knmQVNr8IBggU/kfV8O/LF10QR4f6i3MaZo
         Wk28f8uVyd4NZaLrE0FueXlRfGBw4ukj7DSJmVmjsapkFTp4/KYHrFxkBDQ7CQw2mLEJ
         Pzqyn86sUjoaaynfaBrNBxdArbhv07wqNZaOFYyEobtMEdKSATFgKcFIiNnA+0+WPgGl
         p5V5P2qz79xfJoj8u2rYp3xDBpXzSemraiZp5/kzDUSFQwqRQDAUaTN+z50tROZJbD2B
         6AEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760932807; x=1761537607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGlyUJ6dWl6nFWnMZlQKvO9MHD3+EqVzrC0LlyJOg7g=;
        b=O7Uk4INr3P1/zdxCx9Ny0UTxX2ssvxvpcO220bsWKt4tweg9tY+RCZac9eyFMaLmdr
         DtjKtK6SaHOSEvnVBQxH58clk2BFWIpM2HJcNgxLs7N8kb6Od5zgX1JyhQ9Ph3DMz0F+
         gxh1o27Ey3vFPHIQ6fHtKeGpxPYjUGjIGhi4yq/cQPDRq1bmoikVk88kmc0ixUM2teN0
         yrSBmcGwjH9gerZWk8dR4tEIsnsnbu3cbyi7pneriggDxf/4QISY11d5WdlP2C1ul6Um
         HNa7LoqxdNKRypAfuUII3kXzhe2vWrADsA/8QQ8iGCLViACEEvWB5IulCP7LDd3C7x2F
         fC/w==
X-Forwarded-Encrypted: i=1; AJvYcCWSufjqLf1ZuynwanKCdtuULdQouywMTZqH0PYzqacKHPZm1SxPeSuzPd631AimrB87zbuyBs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxgS8TIOcfGdVcjP/xgxxUZFFEkMDx/3t/2fbgWWOHI07FX3tH
	7LrJVpqnn1KIEVt/5bVK1tmxGxpL+XrcR9R+YpIRDbuhgpU1sB7v5NAIRou+iz1JEYLmLQWjk7A
	PPHevwNgz0kfyagJ8Pgskv0VwQUviTF2qGYJApjXF
X-Gm-Gg: ASbGncs663SRKIeMwsljM5f1CifRzIFxZS7ChXzQ/xtFN+S6mpjRr/U7alX2LQyEmRx
	+yAGhOtllg8s8vG5bmvCl2P/Ceq0/Xim977/95QMSUlj7SYr7sbAidX1TGNkwT6mFXNk4WkPI3O
	08F+V92p7EZ2UuKtyvD7nPIg9oBYNAO6oAqZ6dqpPwsOL34n/BUQEEWccq8GhTTH1zqsTyMUOfM
	NpqeCX9Z8q1IFbQJqJQAqptFSqjek9uqGeO7ZwNI5plKpfV+5608TqJhM6SLOIKZwf8Yfd6ttR3
	wrtMpA==
X-Google-Smtp-Source: AGHT+IEYSIicyADdCPkVkJb9qW9fbgvEYpNmDm5QqCs36TVq0BifkMw6E49Bz9qod7hDZDlRGPtcnNSaTXB1nyV9ejQ=
X-Received: by 2002:ac8:5883:0:b0:4d0:e037:6bd2 with SMTP id
 d75a77b69052e-4e89d4150a0mr167900401cf.83.1760932806725; Sun, 19 Oct 2025
 21:00:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251019170016.138561-1-peng.yu@alibaba-inc.com>
 <CANn89iLsDDQuuQF2i73_-HaHMUwd80Q_ePcoQRy_8GxY2N4eMQ@mail.gmail.com> <befd947e-8725-4637-8fac-6a364b0b4df0.peng.yu@alibaba-inc.com>
In-Reply-To: <befd947e-8725-4637-8fac-6a364b0b4df0.peng.yu@alibaba-inc.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 19 Oct 2025 20:59:54 -0700
X-Gm-Features: AS18NWC6F1R_I0KBruG0TdOotc8Di3KFGXIV9tbul7OG-wYVpC98nHHzEY6rIio
Message-ID: <CANn89iJN4V8SeythtQVrSjhztWmCySdAxR8h35i4Ea2ceq9k8w@mail.gmail.com>
Subject: Re: [PATCH] net: set is_cwnd_limited when the small queue check fails
To: "YU, Peng" <peng.yu@alibaba-inc.com>
Cc: Peng Yu <yupeng0921@gmail.com>, ncardwell <ncardwell@google.com>, 
	kuniyu <kuniyu@google.com>, netdev <netdev@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 4:00=E2=80=AFPM YU, Peng <peng.yu@alibaba-inc.com> =
wrote:
>
> I think we know the root cause in the driver. We are using the
> virtio_net driver. We found that the issue happens after this driver
> commit:
>
> b92f1e6751a6 virtio-net: transmit napi
>
> According to our test, the issue will happen if we apply below change:
>
>
>  static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
>  {
>         struct virtio_net_hdr_mrg_rxbuf *hdr;
> @@ -1130,6 +1174,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, =
struct net_device *dev)
>         int err;
>         struct netdev_queue *txq =3D netdev_get_tx_queue(dev, qnum);
>         bool kick =3D !skb->xmit_more;
> +       bool use_napi =3D sq->napi.weight;
>
>         /* Free up any pending old buffers before queueing new ones. */
>         free_old_xmit_skbs(sq);
> @@ -1152,8 +1197,10 @@ static netdev_tx_t start_xmit(struct sk_buff *skb,=
 struct net_device *dev)
>         }
>
>         /* Don't wait up for transmitted skbs to be freed. */
> -       skb_orphan(skb);
> -       nf_reset(skb);
> +       if (!use_napi) {
> +               skb_orphan(skb);
> +               nf_reset(skb);
> +       }
>
>
> Before this change, the driver will invoke skb_orphan immediately when
> it receives a skb, then the tcp layer will decrease the wmem_alloc.
> Thus the small queue check won't fail. After applying this change, the
> virtio_net driver will tell tcp layer to decrease the wmem_alloc when
> the skp is really sent out.
> If we set use_napi to false, the virtio_net driver will invoke
> skb_orphan immediately as before, then the issue won't happen.
> But invoking skb_orphan in start_xmit looks like a workaround to me,
> I'm not sure if we should rollback this change.  The small queue check
> and cwnd window would come into a kind of "dead lock" situation to me,
> so I suppose we should fix that "dead lock".  If you believe we
> shouldn't change TCP layer for this issue, may I know the correct
> direction to resolve this issue? Should we modify the virtio_net
> driver, let it always invoke skb_orphan as before?
> As a workaround, we set the virtio_net module parameter napi_tx to
> false, then the use_napi would be false too. Thus the issue won't
> happen. But we indeed want to enable napi_tx, so may I know what's
> your suggestion about this issue?
>

I think you should start a conversation with virtio_net experts,
instead of making TCP
bufferbloated again.

TX completions dynamics are important, and we are not going to
penalize all drivers
just because of one.

You are claiming deadlocks, but the mechanisms in place are proven to
work damn well.

>
> ------------------------------------------------------------------
> From:Eric Dumazet <edumazet@google.com>
> Send Time:2025 Oct. 20 (Mon.) 01:43
> To:Peng Yu<yupeng0921@gmail.com>
> CC:ncardwell<ncardwell@google.com>; kuniyu<kuniyu@google.com>; netdev<net=
dev@vger.kernel.org>; "linux-kernel"<linux-kernel@vger.kernel.org>; Peng YU=
<peng.yu@alibaba-inc.com>
> Subject:Re: [PATCH] net: set is_cwnd_limited when the small queue check f=
ails
>
>
> On Sun, Oct 19, 2025 at 10:00 AM Peng Yu <yupeng0921@gmail.com> wrote:
> >
> > The limit of the small queue check is calculated from the pacing rate,
> > the pacing rate is calculated from the cwnd. If the cwnd is small,
> > the small queue check may fail.
> > When the samll queue check fails, the tcp layer will send less
> > packages, then the tcp_is_cwnd_limited would alreays return false,
> > then the cwnd would have no chance to get updated.
> > The cwnd has no chance to get updated, it keeps small, then the pacing
> > rate keeps small, and the limit of the small queue check keeps small,
> > then the small queue check would always fail.
> > It is a kind of dead lock, when a tcp flow comes into this situation,
> > it's throughput would be very small, obviously less then the correct
> > throughput it should have.
> > We set is_cwnd_limited to true when the small queue check fails, then
> > the cwnd would have a chance to get updated, then we can break this
> > deadlock.
> >
> > Below ss output shows this issue:
> >
> > skmem:(r0,rb131072,
> > t7712, <------------------------------ wmem_alloc =3D 7712
> > tb243712,f2128,w219056,o0,bl0,d0)
> > ts sack cubic wscale:7,10 rto:224 rtt:23.364/0.019 ato:40 mss:1448
> > pmtu:8500 rcvmss:536 advmss:8448
> > cwnd:28 <------------------------------ cwnd=3D28
> > bytes_sent:2166208 bytes_acked:2148832 bytes_received:37
> > segs_out:1497 segs_in:751 data_segs_out:1496 data_segs_in:1
> > send 13882554bps lastsnd:7 lastrcv:2992 lastack:7
> > pacing_rate 27764216bps <--------------------- pacing_rate=3D27764216bp=
s
> > delivery_rate 5786688bps delivered:1485 busy:2991ms unacked:12
> > rcv_space:57088 rcv_ssthresh:57088 notsent:188240
> > minrtt:23.319 snd_wnd:57088
> >
> > limit=3D(27764216 / 8) / 1024 =3D 3389 < 7712
> > So the samll queue check fails. When it happens, the throughput is
> > obviously less than the normal situation.
> >
> > By setting the tcp_is_cwnd_limited to true when the small queue check
> > failed, we can avoid this issue, the cwnd could increase to a reasonalb=
e
> > size, in my test environment, it is about 4000. Then the small queue
> > check won't fail.
>
>
> >
> > Signed-off-by: Peng Yu <peng.yu@alibaba-inc.com>
> > ---
> >  net/ipv4/tcp_output.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index b94efb3050d2..8c70acf3a060 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -2985,8 +2985,10 @@ static bool tcp_write_xmit(struct sock *sk, unsi=
gned int mss_now, int nonagle,
> >                     unlikely(tso_fragment(sk, skb, limit, mss_now, gfp)=
))
> >                         break;
> >
> > -               if (tcp_small_queue_check(sk, skb, 0))
> > +               if (tcp_small_queue_check(sk, skb, 0)) {
> > +                       is_cwnd_limited =3D true;
> >                         break;
> > +               }
> >
> >                 /* Argh, we hit an empty skb(), presumably a thread
> >                  * is sleeping in sendmsg()/sk_stream_wait_memory().
> > --
> > 2.47.3
>
> Sorry this makes no sense to me.  CWND_LIMITED should not be hijacked.
>
> Something else is preventing your flows to get to nominal speed,
> because we have not seen anything like that.
>
> It is probably a driver issue or a receive side issue : Instead of
> trying to work around the issue, please root cause it.

