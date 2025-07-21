Return-Path: <netdev+bounces-208727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 137CEB0CE7F
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 01:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C36DB1AA4899
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 23:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA862459D5;
	Mon, 21 Jul 2025 23:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcLp+FX+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA7D1ADC7E
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 23:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753142333; cv=none; b=OPRR1RyWf0VzjvqnT29kwg670G7Kl8TGD5lTZK4Hb3XNZENL80EgwYUemH5PJzXUqHCx97xA8IGYqmQB2sGK9ECkdOIB2BL6cDXf9s2E72O/E9ASw7ZtdNI9SpOPzlaoDRUbz1wmzcUTaFV4jDaAKd/+FdyvU6AYmMVHMjJXsSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753142333; c=relaxed/simple;
	bh=WIUJNaJw9IJIEdoeHe6Axd3qxRH75kVUt3ZwqY19B7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=icL20G52douHIuhVzfNYDGh8RY3ZXG69IsRUetdJAY9guoht9yuyymNjfBa29Wyg03tSoIpC+IYCUE8aMS3xhedRHnvilOPL0xrhH7E8KczZVlYlGV2BwKSILMkd9VLATmfqbZL6hqA0WtO/sG7UczNQRrD3lj8Mb3IVLKoaFX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcLp+FX+; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3df2ddd39c6so21830315ab.0
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 16:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753142331; x=1753747131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vb88zTSkJVzGkK0HgzolodHOPwbe0vyrCNy+2AUlew0=;
        b=YcLp+FX+JPmuOOUkyXSflCGyZnQHkGMIv3MynI/kpcvpI9V7QzUwoRO5hOpBh2fuya
         Vg/JgbKmHoXBV8A8ioQWXmDO42BqNeO/vUWX93m4D8lqxByEcNHo9Fib6WA/AcR5Ip/0
         lk7V+cf78QVI7VFh5wrOAXlrg/i+T1m1fVVkXjuYgmCWDm0SCXzfMp6EBzqMYEv4ClW6
         Xb7HlgVebjj0/6w/r3kl3QIEwsn51RPP8uP08b+NNL1hmC/HApLSIAeuP8Fzs78xMjtw
         k5d+coLWHSz0EkE7z4Dc/UDBLgG83t0HzVDlB04iQjlSAl8rj5Wcbd58taX1l8uZpeTI
         6jjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753142331; x=1753747131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vb88zTSkJVzGkK0HgzolodHOPwbe0vyrCNy+2AUlew0=;
        b=JG0PNqSMabF/bgUBfOMbwnh7F3ZAB1bMRjyDIH8yeOPk2bAUM2Kk1BnN+XicHSjH7x
         bVcb4UC7A3itu9FqUz8c+v5EOVtPzVbtf1Tr2VV+x+mMHJEW33MhCTX7QKg+RTj4IZ84
         zGNuU8ulY98RcXpAGFe4ckCIQUnlUmfaAMr1hLC8wvuKatyZRj42ow+UKA8G8UEtpbr2
         04PeD1YiRqOWSuY8jNpWN7CqhMe76//QyB52RA+PTXwplYxE2wd8dnFjWvJX5A+tnCVo
         PwvjyyfDJ4nqLf0tipR8DCnHEnvFYFl1DJX8jVF3Z9Gv8QU4J6kADMtQ2AIJUWDhUJZV
         ldxg==
X-Gm-Message-State: AOJu0YymHA9yVhIcnCP98jTQkO8WarZf8m2uIa7pjbpeCaqxGrXngCpd
	xCQ7qjGUhZfFT02J//sPilV3q5lmsiqeBL4Uyk0GSXUOQ6o5xtVc6qNHRllg4oWEQiBlbD74HOZ
	ofIrIiU0xcYZB4dxs9BRlvs72mS70vcg=
X-Gm-Gg: ASbGncswwrvh2ix+Kj7Bqqj43bPeRKNIuLhWzZSa8jcR6PyxIH+b/sCsUbkW0O7c1ch
	zNZq1d5GWF7v/UU8P3Q/v/9r7fmBeufNm67yS/P7HLtDHrCdeMehPNKDfmxpliEIGjsznehVC+k
	EDaLmfYzuct9Dt/TvcMvCCtw7U6HXN2kDFZ1PCLCK+n/NA1xk5QfJZI8xTob5j4s1KGHRX5F7LL
	Xl5KQ==
X-Google-Smtp-Source: AGHT+IEoUmMvaWy/1Nqdv0OlucZPblpk1TgADDOlGzD2THHwy3zMs3bhuGR3Fc9tRZdGXeaybc6ffUAIzhSg7wZngOo=
X-Received: by 2002:a05:6e02:216f:b0:3e2:ac27:6ba with SMTP id
 e9e14a558f8ab-3e2ac2707eamr134002075ab.19.1753142330936; Mon, 21 Jul 2025
 16:58:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717152839.973004-1-jeroendb@google.com> <20250717152839.973004-5-jeroendb@google.com>
 <CAL+tcoBu0ZQzLA0MvwAzsYYpz=Z=xR7LiLmFwJUXcHFDvFZVPg@mail.gmail.com>
In-Reply-To: <CAL+tcoBu0ZQzLA0MvwAzsYYpz=Z=xR7LiLmFwJUXcHFDvFZVPg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 22 Jul 2025 07:58:14 +0800
X-Gm-Features: Ac12FXzwm6PGG-padryxzLNrVc1SMBslNAfZl6WOGUGJ9y-JCeNmcTjZIVNGG-w
Message-ID: <CAL+tcoACfOd=TL4xpg114O+feBf1=dd2r5v_WT+6MB8QUDmJ+Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/5] gve: implement DQO TX datapath for AF_XDP zero-copy
To: Jeroen de Borst <jeroendb@google.com>
Cc: netdev@vger.kernel.org, hramamurthy@google.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, willemb@google.com, pabeni@redhat.com, 
	Joshua Washington <joshwash@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 7:37=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Hi Jeroen,
>
> On Thu, Jul 17, 2025 at 11:29=E2=80=AFPM Jeroen de Borst <jeroendb@google=
.com> wrote:
> >
> > From: Joshua Washington <joshwash@google.com>
> >
> > In the descriptor clean path, a number of changes need to be made to
> > accommodate out of order completions and double completions.
> >
> > The XSK stack can only handle completions being processed in order, as =
a
> > single counter is incremented in xsk_tx_completed to sigify how many XS=
K
> > descriptors have been completed. Because completions can come back out
> > of order in DQ, a separate queue of XSK descriptors must be maintained.
> > This queue keeps the pending packets in the order that they were writte=
n
> > so that the descriptors can be counted in xsk_tx_completed in the same
> > order.
> >
> > For double completions, a new pending packet state and type are
> > introduced. The new type, GVE_TX_PENDING_PACKET_DQO_XSK, plays an
> > anlogous role to pre-existing _SKB and _XDP_FRAME pending packet types
> > for XSK descriptors. The new state, GVE_PACKET_STATE_XSK_COMPLETE,
> > represents packets for which no more completions are expected. This
> > includes packets which have received a packet completion or reinjection
> > completion, as well as packets whose reinjection completion timer have
> > timed out. At this point, such packets can be counted as part of
> > xsk_tx_completed() and freed.
> >
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
> > Signed-off-by: Joshua Washington <joshwash@google.com>
> > Signed-off-by: Jeroen de Borst <jeroendb@google.com>
> > ---
> >  drivers/net/ethernet/google/gve/gve.h        |  19 ++-
> >  drivers/net/ethernet/google/gve/gve_dqo.h    |   1 +
> >  drivers/net/ethernet/google/gve/gve_main.c   |   6 +
> >  drivers/net/ethernet/google/gve/gve_tx_dqo.c | 148 +++++++++++++++++++
> >  4 files changed, 171 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethern=
et/google/gve/gve.h
> > index 9925c08e595e..ff7dc06e7fa4 100644
> > --- a/drivers/net/ethernet/google/gve/gve.h
> > +++ b/drivers/net/ethernet/google/gve/gve.h
> > @@ -399,11 +399,17 @@ enum gve_packet_state {
> >         GVE_PACKET_STATE_PENDING_REINJECT_COMPL,
> >         /* No valid completion received within the specified timeout. *=
/
> >         GVE_PACKET_STATE_TIMED_OUT_COMPL,
> > +       /* XSK pending packet has received a packet/reinjection complet=
ion, or
> > +        * has timed out. At this point, the pending packet can be coun=
ted by
> > +        * xsk_tx_complete and freed.
> > +        */
> > +       GVE_PACKET_STATE_XSK_COMPLETE,
> >  };
> >
> >  enum gve_tx_pending_packet_dqo_type {
> >         GVE_TX_PENDING_PACKET_DQO_SKB,
> > -       GVE_TX_PENDING_PACKET_DQO_XDP_FRAME
> > +       GVE_TX_PENDING_PACKET_DQO_XDP_FRAME,
> > +       GVE_TX_PENDING_PACKET_DQO_XSK,
> >  };
> >
> >  struct gve_tx_pending_packet_dqo {
> > @@ -440,10 +446,10 @@ struct gve_tx_pending_packet_dqo {
> >         /* Identifies the current state of the packet as defined in
> >          * `enum gve_packet_state`.
> >          */
> > -       u8 state : 2;
> > +       u8 state : 3;
> >
> >         /* gve_tx_pending_packet_dqo_type */
> > -       u8 type : 1;
> > +       u8 type : 2;
> >
> >         /* If packet is an outstanding miss completion, then the packet=
 is
> >          * freed if the corresponding re-injection completion is not re=
ceived
> > @@ -512,6 +518,8 @@ struct gve_tx_ring {
> >                                 /* Cached value of `dqo_compl.free_tx_q=
pl_buf_cnt` */
> >                                 u32 free_tx_qpl_buf_cnt;
> >                         };
> > +
> > +                       atomic_t xsk_reorder_queue_tail;
> >                 } dqo_tx;
> >         };
> >
> > @@ -545,6 +553,9 @@ struct gve_tx_ring {
> >                         /* Last TX ring index fetched by HW */
> >                         atomic_t hw_tx_head;
> >
> > +                       u16 xsk_reorder_queue_head;
> > +                       u16 xsk_reorder_queue_tail;
> > +
> >                         /* List to track pending packets which received=
 a miss
> >                          * completion but not a corresponding reinjecti=
on.
> >                          */
> > @@ -598,6 +609,8 @@ struct gve_tx_ring {
> >                         struct gve_tx_pending_packet_dqo *pending_packe=
ts;
> >                         s16 num_pending_packets;
> >
> > +                       u16 *xsk_reorder_queue;
> > +
> >                         u32 complq_mask; /* complq size is complq_mask =
+ 1 */
> >
> >                         /* QPL fields */
> > diff --git a/drivers/net/ethernet/google/gve/gve_dqo.h b/drivers/net/et=
hernet/google/gve/gve_dqo.h
> > index bb278727f4d9..6eb442096e02 100644
> > --- a/drivers/net/ethernet/google/gve/gve_dqo.h
> > +++ b/drivers/net/ethernet/google/gve/gve_dqo.h
> > @@ -38,6 +38,7 @@ netdev_features_t gve_features_check_dqo(struct sk_bu=
ff *skb,
> >                                          netdev_features_t features);
> >  bool gve_tx_poll_dqo(struct gve_notify_block *block, bool do_clean);
> >  bool gve_xdp_poll_dqo(struct gve_notify_block *block);
> > +bool gve_xsk_tx_poll_dqo(struct gve_notify_block *block, int budget);
> >  int gve_rx_poll_dqo(struct gve_notify_block *block, int budget);
> >  int gve_tx_alloc_rings_dqo(struct gve_priv *priv,
> >                            struct gve_tx_alloc_rings_cfg *cfg);
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index d5953f5d1895..c6ccc0bb40c9 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > @@ -427,6 +427,12 @@ int gve_napi_poll_dqo(struct napi_struct *napi, in=
t budget)
> >
> >         if (block->rx) {
> >                 work_done =3D gve_rx_poll_dqo(block, budget);
> > +
> > +               /* Poll XSK TX as part of RX NAPI. Setup re-poll based =
on if
> > +                * either datapath has more work to do.
> > +                */
> > +               if (priv->xdp_prog)
> > +                       reschedule |=3D gve_xsk_tx_poll_dqo(block, budg=
et);
> >                 reschedule |=3D work_done =3D=3D budget;
> >         }
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net=
/ethernet/google/gve/gve_tx_dqo.c
> > index ce5370b741ec..6f1d515673d2 100644
> > --- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> > +++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/tcp.h>
> >  #include <linux/slab.h>
> >  #include <linux/skbuff.h>
> > +#include <net/xdp_sock_drv.h>
> >
> >  /* Returns true if tx_bufs are available. */
> >  static bool gve_has_free_tx_qpl_bufs(struct gve_tx_ring *tx, int count=
)
> > @@ -241,6 +242,9 @@ static void gve_tx_free_ring_dqo(struct gve_priv *p=
riv, struct gve_tx_ring *tx,
> >                 tx->dqo.tx_ring =3D NULL;
> >         }
> >
> > +       kvfree(tx->dqo.xsk_reorder_queue);
> > +       tx->dqo.xsk_reorder_queue =3D NULL;
> > +
> >         kvfree(tx->dqo.pending_packets);
> >         tx->dqo.pending_packets =3D NULL;
> >
> > @@ -345,6 +349,17 @@ static int gve_tx_alloc_ring_dqo(struct gve_priv *=
priv,
> >
> >         tx->dqo.pending_packets[tx->dqo.num_pending_packets - 1].next =
=3D -1;
> >         atomic_set_release(&tx->dqo_compl.free_pending_packets, -1);
> > +
> > +       /* Only alloc xsk pool for XDP queues */
> > +       if (idx >=3D cfg->qcfg->num_queues && cfg->num_xdp_rings) {
> > +               tx->dqo.xsk_reorder_queue =3D
> > +                       kvcalloc(tx->dqo.complq_mask + 1,
> > +                                sizeof(tx->dqo.xsk_reorder_queue[0]),
> > +                                GFP_KERNEL);
> > +               if (!tx->dqo.xsk_reorder_queue)
> > +                       goto err;
> > +       }
> > +
> >         tx->dqo_compl.miss_completions.head =3D -1;
> >         tx->dqo_compl.miss_completions.tail =3D -1;
> >         tx->dqo_compl.timed_out_completions.head =3D -1;
> > @@ -992,6 +1007,38 @@ static int gve_try_tx_skb(struct gve_priv *priv, =
struct gve_tx_ring *tx,
> >         return 0;
> >  }
> >
> > +static void gve_xsk_reorder_queue_push_dqo(struct gve_tx_ring *tx,
> > +                                          u16 completion_tag)
> > +{
> > +       u32 tail =3D atomic_read(&tx->dqo_tx.xsk_reorder_queue_tail);
> > +
> > +       tx->dqo.xsk_reorder_queue[tail] =3D completion_tag;
> > +       tail =3D (tail + 1) & tx->dqo.complq_mask;
> > +       atomic_set_release(&tx->dqo_tx.xsk_reorder_queue_tail, tail);
> > +}
> > +
> > +static struct gve_tx_pending_packet_dqo *
> > +gve_xsk_reorder_queue_head(struct gve_tx_ring *tx)
> > +{
> > +       u32 head =3D tx->dqo_compl.xsk_reorder_queue_head;
> > +
> > +       if (head =3D=3D tx->dqo_compl.xsk_reorder_queue_tail) {
> > +               tx->dqo_compl.xsk_reorder_queue_tail =3D
> > +                       atomic_read_acquire(&tx->dqo_tx.xsk_reorder_que=
ue_tail);
> > +
> > +               if (head =3D=3D tx->dqo_compl.xsk_reorder_queue_tail)
> > +                       return NULL;
> > +       }
> > +
> > +       return &tx->dqo.pending_packets[tx->dqo.xsk_reorder_queue[head]=
];
> > +}
> > +
> > +static void gve_xsk_reorder_queue_pop_dqo(struct gve_tx_ring *tx)
> > +{
> > +       tx->dqo_compl.xsk_reorder_queue_head++;
> > +       tx->dqo_compl.xsk_reorder_queue_head &=3D tx->dqo.complq_mask;
> > +}
> > +
> >  /* Transmit a given skb and ring the doorbell. */
> >  netdev_tx_t gve_tx_dqo(struct sk_buff *skb, struct net_device *dev)
> >  {
> > @@ -1015,6 +1062,62 @@ netdev_tx_t gve_tx_dqo(struct sk_buff *skb, stru=
ct net_device *dev)
> >         return NETDEV_TX_OK;
> >  }
> >
> > +static bool gve_xsk_tx_dqo(struct gve_priv *priv, struct gve_tx_ring *=
tx,
> > +                          int budget)
> > +{
> > +       struct xsk_buff_pool *pool =3D tx->xsk_pool;
> > +       struct xdp_desc desc;
> > +       bool repoll =3D false;
> > +       int sent =3D 0;
> > +
> > +       spin_lock(&tx->dqo_tx.xdp_lock);
> > +       for (; sent < budget; sent++) {
> > +               struct gve_tx_pending_packet_dqo *pkt;
> > +               s16 completion_tag;
> > +               dma_addr_t addr;
> > +               u32 desc_idx;
> > +
> > +               if (unlikely(!gve_has_avail_slots_tx_dqo(tx, 1, 1))) {
> > +                       repoll =3D true;
> > +                       break;
>
> If the whole 'for' loop breaks here, the sent should not be increased
> by one, right?

Oops, I was wrong here because 'sent' starts at zero and will be
counted later. So the sent++ is always necessary even when it might
break sometimes.

Thanks,
Jason

