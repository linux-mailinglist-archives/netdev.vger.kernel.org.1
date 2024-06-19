Return-Path: <netdev+bounces-104770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A7190E499
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 09:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263971C21E8C
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 07:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263C9770E2;
	Wed, 19 Jun 2024 07:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9EdHgtf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1CE7580D
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 07:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718782456; cv=none; b=ZxsGaP9wh/M/OwPxyoqZ6euaWdqXKu771WApZJCGyUqSIc/c3D4byqF0G4AncCF9kdn/gb+RvnWwgFTpvpxx8i71PfxM6p8+nohwQ0lYWWpT6yPGiCxCty60cUDNyS+kr017UhIy7ZHv1+r79+jBzTVsNJ+M302l8xCJ+iYwBBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718782456; c=relaxed/simple;
	bh=aAYoPYq2/LXJ8Qdiypn5PMJ06BGpAlZnwtZcfOesUA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNUCFDO8Pkq+ztF50164PdIk8Az+TeS7NtLvq5RRMUE8TUBvpFU3IjaEZEfUW/0KePYLg60vCslVeKg+6B/HXDKazPjUFrL0ae1hm4tNSsFBxlmZkzE13fJGlyZi7BIFLK8PCO/ql9Xixy/I6U3sRYT7rn/CP8WdRQUWWWltg5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9EdHgtf; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57c68682d1aso7176075a12.3
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 00:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718782452; x=1719387252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VujAwVAnRTBrez1D2GlXWj5edxsqa12ztAWa1HbmkM8=;
        b=f9EdHgtfzPthutoy0gTRiM/avSE0rZ9mm185hlsiQefdq4RB2nURuOJoHmR9wt8GoG
         V7QI4Bps0RGXoIDCHU2qIt+X9g6OE0uzJwEOY+oUVdbe1u3iUoqheSNn6/CLal7DpRrD
         J8jm5VmiL2qqrwr7+6GazjhJdonRDLB2JxX4/Wc+3zYNgYTGwX4UrH25Qvs7FMa7vSP+
         zgbrbyCtslJZfAdk82R0YSlHfHDZzbWGQd9kO7MADn2zW/SnwATU+0oI7bIvmenSpzRM
         768QwhmxoWV5SD52DGuiwCw4I2/vajjHucNo3CAcxN4wBznLdj0BKU6j85UUtluLQiha
         IWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718782452; x=1719387252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VujAwVAnRTBrez1D2GlXWj5edxsqa12ztAWa1HbmkM8=;
        b=n5Sfx7ox0/uYddhMYno0cc1+mK2P7yfgbRol29FE0m5mI4vskw8z94Rxe+AuU5NRnN
         6mkwKQ7RcMf2qZGLXGN/HzqqZlddqU5dhScZBakKlO6Cov0liCXJXRj/TessS9YGG7Q8
         XKKyMDpCb+TkXOjTKtEQDSXt0NUuxcE46b/nnGCoPhy7/GQwJasYmpbsqoC6m4qQoMpj
         WDd0d92jAJjAJbce0/ZJ2wa/HhkqjsBKfbJSyQt5nLmXLsUU96DOX4nJ9s6wOf9AD5e/
         JruSglyDnbzX3D/4Dx6dzZmy6RBqyI/6hqqVY1U1HP1HHC/vIYsPi9B+5yv7uE6jrhRf
         lO7g==
X-Forwarded-Encrypted: i=1; AJvYcCVLonMDSUYjEXgzTJey4u0lfWAykOCQ9spyZ6yGnHyP5k/LtQt7mFlJqV9zGHv/+9cIhtO35P2kvIcvMVQyfAqPgfWRZO71
X-Gm-Message-State: AOJu0YzWGv4rkw/DNnTn7CZXQ5v/9dRYa7GHwXf1EcqekfCpCEVkztcu
	eqIA+sp7kQo6h+bnsmafXDOniFadTb60EB7CsLMchJG5vqiNBQtJJY986WiE89pTyPry7zUw+Qe
	jtu33lHofM9nKXsA7BEZk2sLygdU=
X-Google-Smtp-Source: AGHT+IFa4/IeBP4lddu/8oSabgeZ3pcRXAJ5IPOpaY59ZtgRr7Y7RhBXWVlguqJod9ARogyJCphpluJjFDIGUFZeAMc=
X-Received: by 2002:a05:6402:1818:b0:57d:1673:5e0b with SMTP id
 4fb4d7f45d1cf-57d16735e26mr79380a12.22.1718782452088; Wed, 19 Jun 2024
 00:34:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618041412.3184919-1-ap420073@gmail.com> <4bd3afe4-55c8-4a05-ade9-f9bd54f3211a@amd.com>
In-Reply-To: <4bd3afe4-55c8-4a05-ade9-f9bd54f3211a@amd.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 19 Jun 2024 16:34:00 +0900
Message-ID: <CAMArcTXMMy8p1QiPho7ckAvMLL+DH5oO3nTnFGbOAK8XMBqr2g@mail.gmail.com>
Subject: Re: [PATCH net] ionic: fix kernel panic due to multi-buffer handling
To: "Nelson, Shannon" <shannon.nelson@amd.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, brett.creeley@amd.com, drivers@pensando.io, 
	netdev@vger.kernel.org, jacob.e.keller@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 2:40=E2=80=AFAM Nelson, Shannon <shannon.nelson@amd=
.com> wrote:

Hi Nelson, Shannon,
Thank you for the review!


>
> On 6/17/2024 9:14 PM, Taehee Yoo wrote:
> >
> > Currently, the ionic_run_xdp() doesn't handle multi-buffer packets
> > properly for XDP_TX and XDP_REDIRECT.
> > When a jumbo frame is received, the ionic_run_xdp() first makes xdp
> > frame with all necessary pages in the rx descriptor.
> > And if the action is either XDP_TX or XDP_REDIRECT, it should unmap
> > dma-mapping and reset page pointer to NULL for all pages, not only the
> > first page.
> > But it doesn't for SG pages. So, SG pages unexpectedly will be reused.
> > It eventually causes kernel panic.
> >
> > Oops: general protection fault, probably for non-canonical address 0x50=
4f4e4dbebc64ff: 0000 [#1] PREEMPT SMP NOPTI
> > CPU: 3 PID: 0 Comm: swapper/3 Not tainted 6.10.0-rc3+ #25
> > RIP: 0010:xdp_return_frame+0x42/0x90
> > Code: 01 75 12 5b 4c 89 e6 5d 31 c9 41 5c 31 d2 41 5d e9 73 fd ff ff 44=
 8b 6b 20 0f b7 43 0a 49 81 ed 68 01 00 00 49 29 c5 49 01 fd <41> 80 7d0
> > RSP: 0018:ffff99d00122ce08 EFLAGS: 00010202
> > RAX: 0000000000005453 RBX: ffff8d325f904000 RCX: 0000000000000001
> > RDX: 00000000670e1000 RSI: 000000011f90d000 RDI: 504f4e4d4c4b4a49
> > RBP: ffff99d003907740 R08: 0000000000000000 R09: 0000000000000000
> > R10: 000000011f90d000 R11: 0000000000000000 R12: ffff8d325f904010
> > R13: 504f4e4dbebc64fd R14: ffff8d3242b070c8 R15: ffff99d0039077c0
> > FS:  0000000000000000(0000) GS:ffff8d399f780000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f41f6c85e38 CR3: 000000037ac30000 CR4: 00000000007506f0
> > PKRU: 55555554
> > Call Trace:
> >   <IRQ>
> >   ? die_addr+0x33/0x90
> >   ? exc_general_protection+0x251/0x2f0
> >   ? asm_exc_general_protection+0x22/0x30
> >   ? xdp_return_frame+0x42/0x90
> >   ionic_tx_clean+0x211/0x280 [ionic 15881354510e6a9c655c59c54812b319ed2=
cd015]
> >   ionic_tx_cq_service+0xd3/0x210 [ionic 15881354510e6a9c655c59c54812b31=
9ed2cd015]
> >   ionic_txrx_napi+0x41/0x1b0 [ionic 15881354510e6a9c655c59c54812b319ed2=
cd015]
> >   __napi_poll.constprop.0+0x29/0x1b0
> >   net_rx_action+0x2c4/0x350
> >   handle_softirqs+0xf4/0x320
> >   irq_exit_rcu+0x78/0xa0
> >   common_interrupt+0x77/0x90
> >
> > Fixes: 5377805dc1c0 ("ionic: implement xdp frags support")
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > ---
> >
> > In the XDP_DROP and XDP_ABORTED path, the ionic_rx_page_free() is calle=
d
> > to free page and unmap dma-mapping.
> > It resets only the first page pointer to NULL.
> > DROP/ABORTED path looks like it also has the same problem, but it's not=
.
> > Because all pages in the XDP_DROP/ABORTED path are not used anywhere it
> > can be reused without any free and unmap.
> > So, it's okay to remove the function in the xdp path.
> >
> > I will send a separated patch for removing ionic_rx_page_free() in the
> > xdp path.
> >
> >   .../net/ethernet/pensando/ionic/ionic_txrx.c  | 26 +++++++++++++++---=
-
> >   1 file changed, 21 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers=
/net/ethernet/pensando/ionic/ionic_txrx.c
> > index 2427610f4306..792e530e3281 100644
> > --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> > +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> > @@ -487,14 +487,13 @@ static bool ionic_run_xdp(struct ionic_rx_stats *=
stats,
> >                            struct ionic_buf_info *buf_info,
> >                            int len)
> >   {
> > +       int remain_len, frag_len, i, err =3D 0;
> > +       struct skb_shared_info *sinfo;
> >          u32 xdp_action =3D XDP_ABORTED;
> >          struct xdp_buff xdp_buf;
> >          struct ionic_queue *txq;
> >          struct netdev_queue *nq;
> >          struct xdp_frame *xdpf;
> > -       int remain_len;
> > -       int frag_len;
> > -       int err =3D 0;
>
> There's no need to change these 3 declarations.

Okay, I will add a new declaration 'i', not change these declarations.

>
> >
> >          xdp_init_buff(&xdp_buf, IONIC_PAGE_SIZE, rxq->xdp_rxq_info);
> >          frag_len =3D min_t(u16, len, IONIC_XDP_MAX_LINEAR_MTU + VLAN_E=
TH_HLEN);
> > @@ -513,7 +512,6 @@ static bool ionic_run_xdp(struct ionic_rx_stats *st=
ats,
> >           */
> >          remain_len =3D len - frag_len;
> >          if (remain_len) {
> > -               struct skb_shared_info *sinfo;
> >                  struct ionic_buf_info *bi;
> >                  skb_frag_t *frag;
> >
> > @@ -576,7 +574,6 @@ static bool ionic_run_xdp(struct ionic_rx_stats *st=
ats,
> >
> >                  dma_unmap_page(rxq->dev, buf_info->dma_addr,
> >                                 IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
> > -
>
> You can leave the whitespace alone

Thanks, I will remove it :)

>
> >                  err =3D ionic_xdp_post_frame(txq, xdpf, XDP_TX,
> >                                             buf_info->page,
> >                                             buf_info->page_offset,
> > @@ -587,12 +584,22 @@ static bool ionic_run_xdp(struct ionic_rx_stats *=
stats,
> >                          goto out_xdp_abort;
> >                  }
> >                  buf_info->page =3D NULL;
> > +               if (xdp_frame_has_frags(xdpf)) {
>
> You could use xdp_buff_has_frags(&xdp_buf) instead, or just drop this
> check and let nr_frags value handle it in the for-loop test, as long as
> you init sinfo->nr_frags =3D 0 at the start.

Right, xdp_buff_has_frags() is not needed here indeed.
I will remove it, Thanks!

>
>
> > +                       for (i =3D 0; i < sinfo->nr_frags; i++) {
> > +                               buf_info++;
> > +                               dma_unmap_page(rxq->dev, buf_info->dma_=
addr,
> > +                                              IONIC_PAGE_SIZE, DMA_FRO=
M_DEVICE);
> > +                               buf_info->page =3D NULL;
> > +                       }
> > +               }
> > +
> >                  stats->xdp_tx++;
> >
> >                  /* the Tx completion will free the buffers */
> >                  break;
> >
> >          case XDP_REDIRECT:
> > +               xdpf =3D xdp_convert_buff_to_frame(&xdp_buf);
> >                  /* unmap the pages before handing them to a different =
device */
> >                  dma_unmap_page(rxq->dev, buf_info->dma_addr,
> >                                 IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
> > @@ -603,6 +610,15 @@ static bool ionic_run_xdp(struct ionic_rx_stats *s=
tats,
> >                          goto out_xdp_abort;
> >                  }
> >                  buf_info->page =3D NULL;
> > +               if (xdp_frame_has_frags(xdpf)) {
>
> If you use xdp_buff_has_frags() then you would not have to waste time
> with xdp_convert_buff_to_frame().  Or, again, if you init nr_flags at
> the start then you could skip the test altogether and let the for-loop
> test deal with it.
>
> > +                       for (i =3D 0; i < sinfo->nr_frags; i++) {
> > +                               buf_info++;
> > +                               dma_unmap_page(rxq->dev, buf_info->dma_=
addr,
> > +                                              IONIC_PAGE_SIZE, DMA_FRO=
M_DEVICE);
> > +                               buf_info->page =3D NULL;
> > +                       }
> > +               }
> > +
>
> Since this is repeated code, maybe build a little function, something lik=
e
>
> static void ionic_xdp_rx_put_frags(struct ionic_queue *q,
>                                    struct ionic_buf_info *buf_info,
>                                    int nfrags)
> {
>         int i;
>
>         for (i =3D 0; i < nfrags; i++) {
>                 buf_info++;
>                 dma_unmap_page(rxq->dev, buf_info->dma_addr,
>                                IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
>                 buf_info->page =3D NULL;
>         }
> }
>
> and call this with
>         ionic_xdp_rx_put_frags(rxq, buf_info, sinfo->nr_frags);

It looks great, I will apply your suggestion.
I will send a v2 patch with the above change :)

>
>
> Meanwhile, before removing ionic_rx_page_free(), be sure to check that
> ionic_rx_fill() notices that there are useful pages already there that
> can be reused and doesn't end up leaking pages.
>
> We have some draft patches for converting this all to page_pool, which I
> think takes care of this and some other messy bits.  We've been side
> tracked internally, but really need to get back to those.
>

Oh, I also planned to send a patch for converting page_pool.
And at that patch, ionic_rx_page_free() was going to be removed.
But you're already preparing to send a patch for converting to page_pool,
so I will not send my page_pool patch. And I will test your page_pool patch=
.
I agree with the page_pool approach because I checked the
improvement performance and it makes the code a little bit simpler.
Thanks a lot for sharing your plan :)

> Thanks,
> sln
>
> >                  rxq->xdp_flush =3D true;
> >                  stats->xdp_redirect++;
> >                  break;
> > --
> > 2.34.1
> >

Thanks a lot!
Taehee Yoo

