Return-Path: <netdev+bounces-230775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6B8BEF377
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 06:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9191899E46
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 04:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BD4286D53;
	Mon, 20 Oct 2025 04:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmeX32rg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D361A72604
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 04:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760933007; cv=none; b=t+fAhrFsdNAmAkbbYaWEupQnJJeF80K6Xn6gF22frL4UM8IJ5V4QfP9mbDWdg3MAbtF3+2ttfTG0Pr5SRcLsZ5QoX3zpv/vLc7BkiDNmPglLE92p7E08sn3LEQB3ta8YrzcCy7pDWoAj3eo9ChskdeUCDT53VKbTk1CCl/yegz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760933007; c=relaxed/simple;
	bh=v2fkTBuesvfSQcf7cdq7b3Skx0ennDQhSr1qQAdg5AE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBnguE+7QHIAQNg9UoCinFCoYS2N4Ip8urXo4kQT+zrpkhWs6+ibnRUAY5ZaNx8sgUxVbLjB9ElomeD8ccwU1HiGyJD86p/sdh+w3XqKfTK9XLx2XiL8lOdwKBvQWiVHDCpRYjwUNkwCL8WOkTWw8h2ei7ATO3jD1CTjPvmeIMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmeX32rg; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-430ab5ee3afso37285375ab.2
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 21:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760933005; x=1761537805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZzYPhFtKG8qZ+c0G+Q5SohWqQmN/HP+dWRRz/8yezI=;
        b=ZmeX32rgFkXtWPOt1/xxf4OAK9EBPu5O4xhtdFqBPFF/GMi0SHItjiHYT7dq+QwO77
         OTpvwtThgsS4nfLROxOtxv3fTmITfoRAP4W78TCqvWUlbuT/Nj6V00RN4RNwZGNtyTOk
         A7pkyeUvu5FIixpDCXi6jjTmY9cMN3BLH617z4pgdkJRxbVPWg5WGrFwMgRcT0a9kvcI
         89vJr6EOBMq8uT4wDAOkcUaK+8RnFnO9FNMitXdsx1O3gRoQhxHwOQz5u8zmraEr1Vvy
         J5+W3bwEU0WU4tiAy36dqJ9X2TSbk7Mxr3Va1OogmcjWQNB4moILuZgzfoO8qJWN2yxj
         1jPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760933005; x=1761537805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZzYPhFtKG8qZ+c0G+Q5SohWqQmN/HP+dWRRz/8yezI=;
        b=pMF+JL9c8c/kubJfV9bpzQnsgqvkRBgRN0yV5OSFF1OYsZXt3KR5xnAF2cSBbqbOuY
         8RxRCEbKYCxxEoml/KAh9vHeN1aK7Feq644POfOnZ1dYzU4Yjg3SJwIH+tm2orNpHvEM
         uZf4m6iqBLpHAqWIDDxQJEDAAo5E8AU4YUaVlvNdeeYtERhAqj/T/1DsDADmgotNocvn
         gUGi2TjUmzf/zCPZgaF5FUFyNKSUK/bBy2FLBUpOiiOa8L09Ar/uyq9/jatohawkvEsW
         f4t3B1lMT4rVd+PiQg+2pbMkcQhQF8vRWaXmetYWWL4u/LV3woWzBIWs8Sl1krBySeEE
         rQIw==
X-Forwarded-Encrypted: i=1; AJvYcCWExkuDdCMSpZpjfxti7fTPcDzr5CWLJD3gUjwqUUsiXhD8NnFqwcm6Zox6FsGnKGEYZZIn984=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzCTcpGf6D9Gvm9J0LsrcKegtbwCXTCs0jhG4E8kV4zdSLUO8Q
	djfXKtuANWgkKkHT6mdZrmnh5XiMbn1X7JCu8EBGNgGECIRmERfFUtqXK93rnQneRm0sfZvf6LB
	DZzoY5epQdZQBdrVFbhfwEeU5WM+uyxc=
X-Gm-Gg: ASbGnctjb3H1/8AExKEIeqAH9JxFDQwodyByrs7+8EFXpW+Zju+4S2vhpYFMnZTHlgj
	qdcyqEo2IBgs2LSL905rWz5yUejD0C+ioccPT8FishQ3pZYb6ZuoowUE35ybTrL8Ix0Rs4ufirx
	uCvNrk2fi78P6+XM1y6c2ezW7So2QxQKwAoZ1KiQnjrBjUAt9+0ZQipsEls2ukh8e00aUmDxPlI
	aAyq89xu8ZXP5dCdoDkAwY4iqqyz8c9wBzWnFJgDlkEkGVKVSnbSLMzyInp
X-Google-Smtp-Source: AGHT+IEfj2QHWyrtrUy7ZHTXAJMV22isjYur/l73otCD7Q/nWelGuO1Wbgm8DgSpJvRzfJ5SUrH+PzjuBd0Jr5wKTFU=
X-Received: by 2002:a05:6e02:2591:b0:430:c312:214c with SMTP id
 e9e14a558f8ab-430c5234d18mr159034125ab.5.1760933004887; Sun, 19 Oct 2025
 21:03:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251019170016.138561-1-peng.yu@alibaba-inc.com>
 <CANn89iLsDDQuuQF2i73_-HaHMUwd80Q_ePcoQRy_8GxY2N4eMQ@mail.gmail.com> <befd947e-8725-4637-8fac-6a364b0b4df0.peng.yu@alibaba-inc.com>
In-Reply-To: <befd947e-8725-4637-8fac-6a364b0b4df0.peng.yu@alibaba-inc.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 20 Oct 2025 12:02:48 +0800
X-Gm-Features: AS18NWB6D7M0NE1HreAJyZxZc2KbkCwHvUtgvFfI4jFcRpGnvz6ahYuqHx-nXEs
Message-ID: <CAL+tcoB3veWSGcsd6Dw=3Z8SsUYyO4Os4fUh7Cy=87JVzeC3sw@mail.gmail.com>
Subject: Re: [PATCH] net: set is_cwnd_limited when the small queue check fails
To: "YU, Peng" <peng.yu@alibaba-inc.com>
Cc: Eric Dumazet <edumazet@google.com>, Peng Yu <yupeng0921@gmail.com>, 
	ncardwell <ncardwell@google.com>, kuniyu <kuniyu@google.com>, 
	netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 7:00=E2=80=AFAM YU, Peng <peng.yu@alibaba-inc.com> =
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

Very classic and annoying issues that I believe not few people have
encountered... We eventually resorted to orphan mode just as you did,
FYI.

But as to fixing it thoroughly, I agree with Eric's thoughts.

> But invoking skb_orphan in start_xmit looks like a workaround to me,
> I'm not sure if we should rollback this change.  The small queue check
> and cwnd window would come into a kind of "dead lock" situation to me,
> so I suppose we should fix that "dead lock".  If you believe we
> shouldn't change TCP layer for this issue, may I know the correct
> direction to resolve this issue? Should we modify the virtio_net
> driver, let it always invoke skb_orphan as before?

Have you ever noticed the issue cannot be reliably reproduced? It's
only randomly happening on some VMs without any reason. Once I suspect
the policy/logic from the host side might have some problems, like too
slow frequency of triggering IRQ.

Thanks,
Jason

> As a workaround, we set the virtio_net module parameter napi_tx to
> false, then the use_napi would be false too. Thus the issue won't
> happen. But we indeed want to enable napi_tx, so may I know what's
> your suggestion about this issue?
>
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

