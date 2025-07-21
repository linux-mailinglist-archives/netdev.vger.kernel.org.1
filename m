Return-Path: <netdev+bounces-208716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F858B0CE4C
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 01:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D477A1AA08E4
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 23:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1CC1EF1D;
	Mon, 21 Jul 2025 23:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X24l26NH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067AE1607A4
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 23:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753141111; cv=none; b=GDkQJwaSl1mf8unjGmvPNKAMa/y6JpWKuVb7okAz3H00ROpPOsb0R696QD+KZhLNIUW02VcKZ1QYo8kjQHz8IxxNkJsuu+S+BUu++z30P57IGoj56X9TbyxRWjEgstUqP82UoPtfvIpkFx/pT/2Z9b0PDhqWaS8nWRqiVyeYCYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753141111; c=relaxed/simple;
	bh=3ab3M0DVyHZ7ddSTICJrCR4NymjyFq4/6xT7Dyzmya0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V21BsNvFJ7PFYdiIWxQhlemdc4GxNg7bVC33XrQHAmqqTFVTN8lMEPre/O93ZvRzslPj/dp74zsvHk5kt0hEu66J/Hz32smvVQ93Sn1L9lUOvrtdP2VL9LNyUQvkhWnKqdcdbQ4QQTNfD+7MmgALW/Qbm9iIh1BylN8qDoTArG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X24l26NH; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3e2a60aeb26so18737815ab.1
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 16:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753141109; x=1753745909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JT6YoHghmCB+Hx16i7/LKIxflOlUkpaE8fOzaVw+dA=;
        b=X24l26NHCnsk9hLhyvBHGdb9dWWMGQaWiwSyq55Ab69b7IaO6O8P0T2sozJmZwOM/j
         mV8aAuYvnAj5z6TsHs3rwi2Vp2Xo/uXt4yO15SLXqX6IqpnVZ6/ZGhKHi5cBlHwdPCe2
         eUAyL3ZuKL6FZDgBWn97Mc4CTGxjHppZbo7rKQJJ3+zbxIovKzPu5Z9Ysnt8LHGsICSD
         CJS+r0U+Q4ZB34DtuPSCgyCEmszMD3KxhAvQNBnh8scnHGK5I2kT0urXVXs7lMKcdKwB
         AtIDJqJ3cKfV1kfLci1TYj3Dr8MsxrIRsE7xqC4FRpulVb5c0UQTSrJ5jkhew6O5TZtm
         q8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753141109; x=1753745909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JT6YoHghmCB+Hx16i7/LKIxflOlUkpaE8fOzaVw+dA=;
        b=QGtEHSkpTiDBftejxeqzHoDtz4Kbosi52VkRVAMWFasQp/nUDhwW4erjlF/JRsoyjU
         675ud8rwOWm8nEjWWw3obAlrxN+oyl68FhbwSDP8y5f9Yx7OXjBJB3dWppqvq3StrzZf
         cgnhixxKEDpPjVq2sopdqZ1aV89+UkG3q7CZijQhfpLca1RBQoXJADTcehK6s74CXHDD
         khKIVvHsiVm2kT3iLt4vS84sF8Ew7kY3q1xJ1ovVE+BvUmpMo1ISeWOZsugeeI9aUi+A
         X+8FXWcQzIKygJE/eL1FZTLWX6ygN/V+702Z9XrhAdXYZ+7eAIQKGLZUKpH+Hg73O37f
         48YQ==
X-Gm-Message-State: AOJu0YzqcGVNu7vt9B5cR9XparbqjQYLSJwimuzL1b3Z2sjkuEEPTnkx
	dMA8+hwHN1f5cbSq3hlbryODddIBK2dteG2S5wKUPGerHvAexTQArdQxva+bKfiJWiMv1L4+Kep
	D1UQM64HyiHzXn0vWTlL+CTNUlNiv9OhxiOh20AVLHg==
X-Gm-Gg: ASbGncsZL5Ax5cts2HQTJy6KJWttdRo4EKFLLkMwDL0bEHoye1Kx28ZpSuDAmc+1lgK
	2zdK7WTdCRMhOcrYAMIQdaq7OrW/KHiGtnbJfWpqAkOUglB6g7Ga7ees6l2CVSWQvzdd2iz/765
	QmQwT67tM5eYBvVx06zat6vibobZdjUDIM5JLvRrSk+V2MYHEuZcv1YwUwi+xWsg4ylsFkeAz63
	EORFA==
X-Google-Smtp-Source: AGHT+IESAXkYeeARhM3Nd+MFW4bkL2kMVRjWwQzV9UalCj14DKQ2+ZQQVZgs7SAsgA8s8Nc/y8QVqK2V2zsp7RbW2dU=
X-Received: by 2002:a05:6e02:168a:b0:3e2:9db8:b10c with SMTP id
 e9e14a558f8ab-3e29db8b2demr196069225ab.18.1753141108713; Mon, 21 Jul 2025
 16:38:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717152839.973004-1-jeroendb@google.com> <20250717152839.973004-5-jeroendb@google.com>
In-Reply-To: <20250717152839.973004-5-jeroendb@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 22 Jul 2025 07:37:51 +0800
X-Gm-Features: Ac12FXzSUAXWIHZdTGOzdSOYkJokq_zNCsT0nxaXY3DsHBXhmACXT6WEjcXEDoM
Message-ID: <CAL+tcoBu0ZQzLA0MvwAzsYYpz=Z=xR7LiLmFwJUXcHFDvFZVPg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/5] gve: implement DQO TX datapath for AF_XDP zero-copy
To: Jeroen de Borst <jeroendb@google.com>
Cc: netdev@vger.kernel.org, hramamurthy@google.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, willemb@google.com, pabeni@redhat.com, 
	Joshua Washington <joshwash@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeroen,

On Thu, Jul 17, 2025 at 11:29=E2=80=AFPM Jeroen de Borst <jeroendb@google.c=
om> wrote:
>
> From: Joshua Washington <joshwash@google.com>
>
> In the descriptor clean path, a number of changes need to be made to
> accommodate out of order completions and double completions.
>
> The XSK stack can only handle completions being processed in order, as a
> single counter is incremented in xsk_tx_completed to sigify how many XSK
> descriptors have been completed. Because completions can come back out
> of order in DQ, a separate queue of XSK descriptors must be maintained.
> This queue keeps the pending packets in the order that they were written
> so that the descriptors can be counted in xsk_tx_completed in the same
> order.
>
> For double completions, a new pending packet state and type are
> introduced. The new type, GVE_TX_PENDING_PACKET_DQO_XSK, plays an
> anlogous role to pre-existing _SKB and _XDP_FRAME pending packet types
> for XSK descriptors. The new state, GVE_PACKET_STATE_XSK_COMPLETE,
> represents packets for which no more completions are expected. This
> includes packets which have received a packet completion or reinjection
> completion, as well as packets whose reinjection completion timer have
> timed out. At this point, such packets can be counted as part of
> xsk_tx_completed() and freed.
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Signed-off-by: Joshua Washington <joshwash@google.com>
> Signed-off-by: Jeroen de Borst <jeroendb@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve.h        |  19 ++-
>  drivers/net/ethernet/google/gve/gve_dqo.h    |   1 +
>  drivers/net/ethernet/google/gve/gve_main.c   |   6 +
>  drivers/net/ethernet/google/gve/gve_tx_dqo.c | 148 +++++++++++++++++++
>  4 files changed, 171 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet=
/google/gve/gve.h
> index 9925c08e595e..ff7dc06e7fa4 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -399,11 +399,17 @@ enum gve_packet_state {
>         GVE_PACKET_STATE_PENDING_REINJECT_COMPL,
>         /* No valid completion received within the specified timeout. */
>         GVE_PACKET_STATE_TIMED_OUT_COMPL,
> +       /* XSK pending packet has received a packet/reinjection completio=
n, or
> +        * has timed out. At this point, the pending packet can be counte=
d by
> +        * xsk_tx_complete and freed.
> +        */
> +       GVE_PACKET_STATE_XSK_COMPLETE,
>  };
>
>  enum gve_tx_pending_packet_dqo_type {
>         GVE_TX_PENDING_PACKET_DQO_SKB,
> -       GVE_TX_PENDING_PACKET_DQO_XDP_FRAME
> +       GVE_TX_PENDING_PACKET_DQO_XDP_FRAME,
> +       GVE_TX_PENDING_PACKET_DQO_XSK,
>  };
>
>  struct gve_tx_pending_packet_dqo {
> @@ -440,10 +446,10 @@ struct gve_tx_pending_packet_dqo {
>         /* Identifies the current state of the packet as defined in
>          * `enum gve_packet_state`.
>          */
> -       u8 state : 2;
> +       u8 state : 3;
>
>         /* gve_tx_pending_packet_dqo_type */
> -       u8 type : 1;
> +       u8 type : 2;
>
>         /* If packet is an outstanding miss completion, then the packet i=
s
>          * freed if the corresponding re-injection completion is not rece=
ived
> @@ -512,6 +518,8 @@ struct gve_tx_ring {
>                                 /* Cached value of `dqo_compl.free_tx_qpl=
_buf_cnt` */
>                                 u32 free_tx_qpl_buf_cnt;
>                         };
> +
> +                       atomic_t xsk_reorder_queue_tail;
>                 } dqo_tx;
>         };
>
> @@ -545,6 +553,9 @@ struct gve_tx_ring {
>                         /* Last TX ring index fetched by HW */
>                         atomic_t hw_tx_head;
>
> +                       u16 xsk_reorder_queue_head;
> +                       u16 xsk_reorder_queue_tail;
> +
>                         /* List to track pending packets which received a=
 miss
>                          * completion but not a corresponding reinjection=
.
>                          */
> @@ -598,6 +609,8 @@ struct gve_tx_ring {
>                         struct gve_tx_pending_packet_dqo *pending_packets=
;
>                         s16 num_pending_packets;
>
> +                       u16 *xsk_reorder_queue;
> +
>                         u32 complq_mask; /* complq size is complq_mask + =
1 */
>
>                         /* QPL fields */
> diff --git a/drivers/net/ethernet/google/gve/gve_dqo.h b/drivers/net/ethe=
rnet/google/gve/gve_dqo.h
> index bb278727f4d9..6eb442096e02 100644
> --- a/drivers/net/ethernet/google/gve/gve_dqo.h
> +++ b/drivers/net/ethernet/google/gve/gve_dqo.h
> @@ -38,6 +38,7 @@ netdev_features_t gve_features_check_dqo(struct sk_buff=
 *skb,
>                                          netdev_features_t features);
>  bool gve_tx_poll_dqo(struct gve_notify_block *block, bool do_clean);
>  bool gve_xdp_poll_dqo(struct gve_notify_block *block);
> +bool gve_xsk_tx_poll_dqo(struct gve_notify_block *block, int budget);
>  int gve_rx_poll_dqo(struct gve_notify_block *block, int budget);
>  int gve_tx_alloc_rings_dqo(struct gve_priv *priv,
>                            struct gve_tx_alloc_rings_cfg *cfg);
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index d5953f5d1895..c6ccc0bb40c9 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -427,6 +427,12 @@ int gve_napi_poll_dqo(struct napi_struct *napi, int =
budget)
>
>         if (block->rx) {
>                 work_done =3D gve_rx_poll_dqo(block, budget);
> +
> +               /* Poll XSK TX as part of RX NAPI. Setup re-poll based on=
 if
> +                * either datapath has more work to do.
> +                */
> +               if (priv->xdp_prog)
> +                       reschedule |=3D gve_xsk_tx_poll_dqo(block, budget=
);
>                 reschedule |=3D work_done =3D=3D budget;
>         }
>
> diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/e=
thernet/google/gve/gve_tx_dqo.c
> index ce5370b741ec..6f1d515673d2 100644
> --- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> @@ -13,6 +13,7 @@
>  #include <linux/tcp.h>
>  #include <linux/slab.h>
>  #include <linux/skbuff.h>
> +#include <net/xdp_sock_drv.h>
>
>  /* Returns true if tx_bufs are available. */
>  static bool gve_has_free_tx_qpl_bufs(struct gve_tx_ring *tx, int count)
> @@ -241,6 +242,9 @@ static void gve_tx_free_ring_dqo(struct gve_priv *pri=
v, struct gve_tx_ring *tx,
>                 tx->dqo.tx_ring =3D NULL;
>         }
>
> +       kvfree(tx->dqo.xsk_reorder_queue);
> +       tx->dqo.xsk_reorder_queue =3D NULL;
> +
>         kvfree(tx->dqo.pending_packets);
>         tx->dqo.pending_packets =3D NULL;
>
> @@ -345,6 +349,17 @@ static int gve_tx_alloc_ring_dqo(struct gve_priv *pr=
iv,
>
>         tx->dqo.pending_packets[tx->dqo.num_pending_packets - 1].next =3D=
 -1;
>         atomic_set_release(&tx->dqo_compl.free_pending_packets, -1);
> +
> +       /* Only alloc xsk pool for XDP queues */
> +       if (idx >=3D cfg->qcfg->num_queues && cfg->num_xdp_rings) {
> +               tx->dqo.xsk_reorder_queue =3D
> +                       kvcalloc(tx->dqo.complq_mask + 1,
> +                                sizeof(tx->dqo.xsk_reorder_queue[0]),
> +                                GFP_KERNEL);
> +               if (!tx->dqo.xsk_reorder_queue)
> +                       goto err;
> +       }
> +
>         tx->dqo_compl.miss_completions.head =3D -1;
>         tx->dqo_compl.miss_completions.tail =3D -1;
>         tx->dqo_compl.timed_out_completions.head =3D -1;
> @@ -992,6 +1007,38 @@ static int gve_try_tx_skb(struct gve_priv *priv, st=
ruct gve_tx_ring *tx,
>         return 0;
>  }
>
> +static void gve_xsk_reorder_queue_push_dqo(struct gve_tx_ring *tx,
> +                                          u16 completion_tag)
> +{
> +       u32 tail =3D atomic_read(&tx->dqo_tx.xsk_reorder_queue_tail);
> +
> +       tx->dqo.xsk_reorder_queue[tail] =3D completion_tag;
> +       tail =3D (tail + 1) & tx->dqo.complq_mask;
> +       atomic_set_release(&tx->dqo_tx.xsk_reorder_queue_tail, tail);
> +}
> +
> +static struct gve_tx_pending_packet_dqo *
> +gve_xsk_reorder_queue_head(struct gve_tx_ring *tx)
> +{
> +       u32 head =3D tx->dqo_compl.xsk_reorder_queue_head;
> +
> +       if (head =3D=3D tx->dqo_compl.xsk_reorder_queue_tail) {
> +               tx->dqo_compl.xsk_reorder_queue_tail =3D
> +                       atomic_read_acquire(&tx->dqo_tx.xsk_reorder_queue=
_tail);
> +
> +               if (head =3D=3D tx->dqo_compl.xsk_reorder_queue_tail)
> +                       return NULL;
> +       }
> +
> +       return &tx->dqo.pending_packets[tx->dqo.xsk_reorder_queue[head]];
> +}
> +
> +static void gve_xsk_reorder_queue_pop_dqo(struct gve_tx_ring *tx)
> +{
> +       tx->dqo_compl.xsk_reorder_queue_head++;
> +       tx->dqo_compl.xsk_reorder_queue_head &=3D tx->dqo.complq_mask;
> +}
> +
>  /* Transmit a given skb and ring the doorbell. */
>  netdev_tx_t gve_tx_dqo(struct sk_buff *skb, struct net_device *dev)
>  {
> @@ -1015,6 +1062,62 @@ netdev_tx_t gve_tx_dqo(struct sk_buff *skb, struct=
 net_device *dev)
>         return NETDEV_TX_OK;
>  }
>
> +static bool gve_xsk_tx_dqo(struct gve_priv *priv, struct gve_tx_ring *tx=
,
> +                          int budget)
> +{
> +       struct xsk_buff_pool *pool =3D tx->xsk_pool;
> +       struct xdp_desc desc;
> +       bool repoll =3D false;
> +       int sent =3D 0;
> +
> +       spin_lock(&tx->dqo_tx.xdp_lock);
> +       for (; sent < budget; sent++) {
> +               struct gve_tx_pending_packet_dqo *pkt;
> +               s16 completion_tag;
> +               dma_addr_t addr;
> +               u32 desc_idx;
> +
> +               if (unlikely(!gve_has_avail_slots_tx_dqo(tx, 1, 1))) {
> +                       repoll =3D true;
> +                       break;

If the whole 'for' loop breaks here, the sent should not be increased
by one, right?

> +               }
> +
> +               if (!xsk_tx_peek_desc(pool, &desc))
> +                       break;

The same logic here.

I would use a while() or do..while() loop like how i40e_clean_tx_irq()
manipulates the budget.

> +
> +               pkt =3D gve_alloc_pending_packet(tx);

I checked gve_alloc_pending_packet() and noticed there is one slight
chance to return NULL? If so, it will trigger a NULL dereference
issue.

Thanks,
Jason

> +               pkt->type =3D GVE_TX_PENDING_PACKET_DQO_XSK;
> +               pkt->num_bufs =3D 0;
> +               completion_tag =3D pkt - tx->dqo.pending_packets;
> +
> +               addr =3D xsk_buff_raw_get_dma(pool, desc.addr);
> +               xsk_buff_raw_dma_sync_for_device(pool, addr, desc.len);
> +
> +               desc_idx =3D tx->dqo_tx.tail;
> +               gve_tx_fill_pkt_desc_dqo(tx, &desc_idx,
> +                                        true, desc.len,
> +                                        addr, completion_tag, true,
> +                                        false);
> +               ++pkt->num_bufs;
> +               gve_tx_update_tail(tx, desc_idx);
> +               tx->dqo_tx.posted_packet_desc_cnt +=3D pkt->num_bufs;
> +               gve_xsk_reorder_queue_push_dqo(tx, completion_tag);
> +       }
> +
> +       if (sent) {
> +               gve_tx_put_doorbell_dqo(priv, tx->q_resources, tx->dqo_tx=
.tail);
> +               xsk_tx_release(pool);
> +       }
> +
> +       spin_unlock(&tx->dqo_tx.xdp_lock);
> +
> +       u64_stats_update_begin(&tx->statss);
> +       tx->xdp_xsk_sent +=3D sent;
> +       u64_stats_update_end(&tx->statss);
> +
> +       return (sent =3D=3D budget) || repoll;
> +}
> +
>  static void add_to_list(struct gve_tx_ring *tx, struct gve_index_list *l=
ist,
>                         struct gve_tx_pending_packet_dqo *pending_packet)
>  {
> @@ -1152,6 +1255,9 @@ static void gve_handle_packet_completion(struct gve=
_priv *priv,
>                 pending_packet->xdpf =3D NULL;
>                 gve_free_pending_packet(tx, pending_packet);
>                 break;
> +       case GVE_TX_PENDING_PACKET_DQO_XSK:
> +               pending_packet->state =3D GVE_PACKET_STATE_XSK_COMPLETE;
> +               break;
>         default:
>                 WARN_ON_ONCE(1);
>         }
> @@ -1251,8 +1357,34 @@ static void remove_timed_out_completions(struct gv=
e_priv *priv,
>
>                 remove_from_list(tx, &tx->dqo_compl.timed_out_completions=
,
>                                  pending_packet);
> +
> +               /* Need to count XSK packets in xsk_tx_completed. */
> +               if (pending_packet->type =3D=3D GVE_TX_PENDING_PACKET_DQO=
_XSK)
> +                       pending_packet->state =3D GVE_PACKET_STATE_XSK_CO=
MPLETE;
> +               else
> +                       gve_free_pending_packet(tx, pending_packet);
> +       }
> +}
> +
> +static void gve_tx_process_xsk_completions(struct gve_tx_ring *tx)
> +{
> +       u32 num_xsks =3D 0;
> +
> +       while (true) {
> +               struct gve_tx_pending_packet_dqo *pending_packet =3D
> +                       gve_xsk_reorder_queue_head(tx);
> +
> +               if (!pending_packet ||
> +                   pending_packet->state !=3D GVE_PACKET_STATE_XSK_COMPL=
ETE)
> +                       break;
> +
> +               num_xsks++;
> +               gve_xsk_reorder_queue_pop_dqo(tx);
>                 gve_free_pending_packet(tx, pending_packet);
>         }
> +
> +       if (num_xsks)
> +               xsk_tx_completed(tx->xsk_pool, num_xsks);
>  }
>
>  int gve_clean_tx_done_dqo(struct gve_priv *priv, struct gve_tx_ring *tx,
> @@ -1333,6 +1465,9 @@ int gve_clean_tx_done_dqo(struct gve_priv *priv, st=
ruct gve_tx_ring *tx,
>         remove_miss_completions(priv, tx);
>         remove_timed_out_completions(priv, tx);
>
> +       if (tx->xsk_pool)
> +               gve_tx_process_xsk_completions(tx);
> +
>         u64_stats_update_begin(&tx->statss);
>         tx->bytes_done +=3D pkt_compl_bytes + reinject_compl_bytes;
>         tx->pkt_done +=3D pkt_compl_pkts + reinject_compl_pkts;
> @@ -1365,6 +1500,19 @@ bool gve_tx_poll_dqo(struct gve_notify_block *bloc=
k, bool do_clean)
>         return compl_desc->generation !=3D tx->dqo_compl.cur_gen_bit;
>  }
>
> +bool gve_xsk_tx_poll_dqo(struct gve_notify_block *rx_block, int budget)
> +{
> +       struct gve_rx_ring *rx =3D rx_block->rx;
> +       struct gve_priv *priv =3D rx->gve;
> +       struct gve_tx_ring *tx;
> +
> +       tx =3D &priv->tx[gve_xdp_tx_queue_id(priv, rx->q_num)];
> +       if (tx->xsk_pool)
> +               return gve_xsk_tx_dqo(priv, tx, budget);
> +
> +       return 0;
> +}
> +
>  bool gve_xdp_poll_dqo(struct gve_notify_block *block)
>  {
>         struct gve_tx_compl_desc *compl_desc;
> --
> 2.50.0.727.gbf7dc18ff4-goog
>
>

