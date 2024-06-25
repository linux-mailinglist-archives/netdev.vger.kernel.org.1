Return-Path: <netdev+bounces-106618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94988916FF0
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 20:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E551C221C5
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 18:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9588E178CFD;
	Tue, 25 Jun 2024 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnHecXzM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4E317B437
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719339161; cv=none; b=WUBT86Hk8lcmTqoIIIn1hwiZsww3Sg6xi+XqOTZZCkuVvEmYwHwxje5FmBf3QFI00jbuFjkXfOc7fQXyKegypmPCEHl48lvGHzu+PobBM8vXiHFPv5yg4aopRgmnIsAam6HzzgeGlAHaGb+LYHiR1fX9O3kIa5Ns/z2X+Qom7Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719339161; c=relaxed/simple;
	bh=TcQhdMMNxmaVF+y0TQhrwjo+imNPo1qlUWDtXhgT3/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bY9EVnq6/LjczZ/Tx2VKj6Ln/6YYvOU82aAYlXOqznwoVBpi944gtvmrQBhtXA+5A32aVL7sgoAiRQ1BYMsKJ8Q+mQI8yoIjToGiaFzqGvyUmdcgu1EhsRd8eXI5MpmRfLYiqL/GdluuIJe7TPEW6An4KwoG2Ijfv4B/Gj9d/kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnHecXzM; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6c4926bf9baso4799050a12.2
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 11:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719339158; x=1719943958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yh4FP60AkPjjqaGt2OdtxzGOfOkp8dnEiSUjlpkNwAw=;
        b=bnHecXzMeLILI5RoCBeZPfUvt84ex8kcZZ2MIOgVUY9RAd0f8+z/S2qwSsZgV3rO7I
         wddTHaMvN+WCp3x0cyV93AacuT5FkvjSCEVUnT4A64KB2Zidu5tgSDghi4JdG3DOQmu2
         MX6WqvBUdprI70Yeer9Sop52wGeNJRSnR9lVyQZf+9l3J+PLXpkln958g6py6xkZNK+7
         FrJUwl8xzr14aq3PQSS5KsQxoBEiolsSS6A3wXRq+Gr3H8gfsarBwqX+QWkMxHadK33B
         Pny6m8QLffkHt+DvKr5W8C2V1t2c1ViQVdsv5VDLKnhbulvTR4oP+BjFqac34o0cPGW1
         4aLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719339158; x=1719943958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yh4FP60AkPjjqaGt2OdtxzGOfOkp8dnEiSUjlpkNwAw=;
        b=ihIu9Vhv6R0H5vo5ll1mubJoEu6dd63x7E+5a8mIi3zD5sBpnMPolRRQtBg8DX6f2w
         LOus/AV/05zS5MAFp9X/nVOCYZKxA98/zoQxCiOz3wXybVweS711/zTBOdCZEUBIntNJ
         Hxr65TENCxnlE8eJ7ZfdJ59SdwHjdgXlDf10pRK4uZ3K2WBPbIKpIqbUGx0KTKHkW0nf
         cprSipkWq+OcPZppu+FNAlD5riah5Otuz3VuAFEdhbXT8IjjKuTkeYvc1IKV5Ed6ovbc
         cznURJSyOSDFHozvKi6sva2FXRST57TL6uJw6pHL05cJMWzRR64pWl4PCfbe1ORKrg+c
         Z8pQ==
X-Gm-Message-State: AOJu0Yx/36rMH7iMJVP22N5B2P3CfiCAcchH2lQtfy6i8x4vTuLMI4Xd
	nt+ekiwKbqZb3d3CqwNlYnubFf8vtuIcA2MM5MCfFyqoOJLV6YWjRxOL9KTZiumvttLh4EFDzNj
	ImN3ksc5NbloaRTByLXzsUtljwXQ=
X-Google-Smtp-Source: AGHT+IEORFlsU006ixpeOu2n1yx+0gB+iS4V+VP5v9DGe2u1xdm00fhBTJtV1LEe4vQx5lDmLusPPlu/LpyOYFKoyZo=
X-Received: by 2002:a17:90a:b012:b0:2c8:5bd3:551a with SMTP id
 98e67ed59e1d1-2c85bd35694mr7809273a91.35.1719339158069; Tue, 25 Jun 2024
 11:12:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625165658.34598-1-shannon.nelson@amd.com>
In-Reply-To: <20240625165658.34598-1-shannon.nelson@amd.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 26 Jun 2024 03:12:24 +0900
Message-ID: <CAMArcTUG9C--vX2xPoi4C73vJ5uDy5=FeU3r=eUnxmvwQQHQTQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] ionic: convert Rx queue buffers to use page_pool
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, pabeni@redhat.com, brett.creeley@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 1:57=E2=80=AFAM Shannon Nelson <shannon.nelson@amd.=
com> wrote:
>

Hi Shannon,Thanks a lot for this work!
> Our home-grown buffer management needs to go away and we need
> to be playing nicely with the page_pool infrastructure.  This
> converts the Rx traffic queues to use page_pool.
>
> RFC: This is still being tweaked and tested, but has passed some
>      basic testing for both normal and jumbo frames going through
>      normal paths as well as XDP PASS, DROP, ABORTED, TX, and
>      REDIRECT paths.  It has not been under any performance test
>      runs, but a quicky iperf3 test shows similar numbers.
>
>      This patch seems far enough along that a look-over by some
>      page_pool experienced reviewers would be appreciated.
>
>      Thanks!
>      sln
>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
>  drivers/net/ethernet/pensando/Kconfig         |   1 +
>  .../net/ethernet/pensando/ionic/ionic_dev.h   |   2 +-
>  .../net/ethernet/pensando/ionic/ionic_lif.c   |  43 ++-
>  .../net/ethernet/pensando/ionic/ionic_txrx.c  | 318 ++++++++----------
>  4 files changed, 189 insertions(+), 175 deletions(-)
>
> diff --git a/drivers/net/ethernet/pensando/Kconfig b/drivers/net/ethernet=
/pensando/Kconfig
> index 3f7519e435b8..01fe76786f77 100644
> --- a/drivers/net/ethernet/pensando/Kconfig
> +++ b/drivers/net/ethernet/pensando/Kconfig
> @@ -23,6 +23,7 @@ config IONIC
>         depends on PTP_1588_CLOCK_OPTIONAL
>         select NET_DEVLINK
>         select DIMLIB
> +       select PAGE_POOL
>         help
>           This enables the support for the Pensando family of Ethernet
>           adapters.  More specific information on this driver can be
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/ne=
t/ethernet/pensando/ionic/ionic_dev.h
> index 92f16b6c5662..45ad2bf1e1e7 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
> @@ -177,7 +177,6 @@ struct ionic_dev {
>         struct ionic_devinfo dev_info;
>  };
>
> -struct ionic_queue;
>  struct ionic_qcq;
>
>  #define IONIC_MAX_BUF_LEN                      ((u16)-1)
> @@ -262,6 +261,7 @@ struct ionic_queue {
>         };
>         struct xdp_rxq_info *xdp_rxq_info;
>         struct ionic_queue *partner;
> +       struct page_pool *page_pool;
>         dma_addr_t base_pa;
>         dma_addr_t cmb_base_pa;
>         dma_addr_t sg_base_pa;
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/ne=
t/ethernet/pensando/ionic/ionic_lif.c
> index 38ce35462737..e1cd5982bb2e 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> @@ -13,6 +13,7 @@
>  #include <linux/cpumask.h>
>  #include <linux/crash_dump.h>
>  #include <linux/vmalloc.h>
> +#include <net/page_pool/helpers.h>
>
>  #include "ionic.h"
>  #include "ionic_bus.h"
> @@ -440,6 +441,8 @@ static void ionic_qcq_free(struct ionic_lif *lif, str=
uct ionic_qcq *qcq)
>         ionic_xdp_unregister_rxq_info(&qcq->q);
>         ionic_qcq_intr_free(lif, qcq);
>
> +       page_pool_destroy(qcq->q.page_pool);
> +       qcq->q.page_pool =3D NULL;
>         vfree(qcq->q.info);
>         qcq->q.info =3D NULL;
>  }
> @@ -579,6 +582,36 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, un=
signed int type,
>                 goto err_out_free_qcq;
>         }
>
> +       if (type =3D=3D IONIC_QTYPE_RXQ) {
> +               struct page_pool_params pp_params =3D {
> +                       .flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV=
,
> +                       .order =3D 0,
> +                       .pool_size =3D num_descs,
> +                       .nid =3D NUMA_NO_NODE,
> +                       .dev =3D lif->ionic->dev,
> +                       .napi =3D &new->napi,
> +                       .dma_dir =3D DMA_FROM_DEVICE,
> +                       .max_len =3D PAGE_SIZE,
> +                       .offset =3D 0,
> +                       .netdev =3D lif->netdev,
> +               };
> +               struct bpf_prog *xdp_prog;
> +
> +               xdp_prog =3D READ_ONCE(lif->xdp_prog);
> +               if (xdp_prog) {
> +                       pp_params.dma_dir =3D DMA_BIDIRECTIONAL;
> +                       pp_params.offset =3D XDP_PACKET_HEADROOM;
> +               }
> +
> +               new->q.page_pool =3D page_pool_create(&pp_params);
> +               if (IS_ERR(new->q.page_pool)) {
> +                       netdev_err(lif->netdev, "Cannot create page_pool\=
n");
> +                       err =3D PTR_ERR(new->q.page_pool);
> +                       new->q.page_pool =3D NULL;
> +                       goto err_out_free_q_info;
> +               }
> +       }
> +
>         new->q.type =3D type;
>         new->q.max_sg_elems =3D lif->qtype_info[type].max_sg_elems;
>
> @@ -586,12 +619,12 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, u=
nsigned int type,
>                            desc_size, sg_desc_size, pid);
>         if (err) {
>                 netdev_err(lif->netdev, "Cannot initialize queue\n");
> -               goto err_out_free_q_info;
> +               goto err_out_free_page_pool;
>         }
>
>         err =3D ionic_alloc_qcq_interrupt(lif, new);
>         if (err)
> -               goto err_out_free_q_info;
> +               goto err_out_free_page_pool;
>
>         err =3D ionic_cq_init(lif, &new->cq, &new->intr, num_descs, cq_de=
sc_size);
>         if (err) {
> @@ -712,6 +745,8 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, uns=
igned int type,
>                 devm_free_irq(dev, new->intr.vector, &new->napi);
>                 ionic_intr_free(lif->ionic, new->intr.index);
>         }
> +err_out_free_page_pool:
> +       page_pool_destroy(new->q.page_pool);
>  err_out_free_q_info:
>         vfree(new->q.info);
>  err_out_free_qcq:
> @@ -2681,7 +2716,8 @@ static int ionic_xdp_register_rxq_info(struct ionic=
_queue *q, unsigned int napi_
>                 goto err_out;
>         }
>
> -       err =3D xdp_rxq_info_reg_mem_model(rxq_info, MEM_TYPE_PAGE_ORDER0=
, NULL);
> +       err =3D xdp_rxq_info_reg_mem_model(rxq_info, MEM_TYPE_PAGE_POOL,
> +                                        q->page_pool);
>         if (err) {
>                 dev_err(q->dev, "Queue %d xdp_rxq_info_reg_mem_model fail=
ed, err %d\n",
>                         q->index, err);
> @@ -2878,6 +2914,7 @@ static void ionic_swap_queues(struct ionic_qcq *a, =
struct ionic_qcq *b)
>         swap(a->q.base,       b->q.base);
>         swap(a->q.base_pa,    b->q.base_pa);
>         swap(a->q.info,       b->q.info);
> +       swap(a->q.page_pool,  b->q.page_pool);
>         swap(a->q.xdp_rxq_info, b->q.xdp_rxq_info);
>         swap(a->q.partner,    b->q.partner);
>         swap(a->q_base,       b->q_base);
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/n=
et/ethernet/pensando/ionic/ionic_txrx.c
> index 5bf13a5d411c..ffef3d66e0df 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> @@ -6,6 +6,7 @@
>  #include <linux/if_vlan.h>
>  #include <net/ip6_checksum.h>
>  #include <net/netdev_queues.h>
> +#include <net/page_pool/helpers.h>
>
>  #include "ionic.h"
>  #include "ionic_lif.h"
> @@ -117,86 +118,19 @@ static void *ionic_rx_buf_va(struct ionic_buf_info =
*buf_info)
>
>  static dma_addr_t ionic_rx_buf_pa(struct ionic_buf_info *buf_info)
>  {
> -       return buf_info->dma_addr + buf_info->page_offset;
> +       return page_pool_get_dma_addr(buf_info->page) + buf_info->page_of=
fset;
>  }
>
> -static unsigned int ionic_rx_buf_size(struct ionic_buf_info *buf_info)
> +static void ionic_rx_put_buf(struct ionic_queue *q,
> +                            struct ionic_buf_info *buf_info)
>  {
> -       return min_t(u32, IONIC_MAX_BUF_LEN, IONIC_PAGE_SIZE - buf_info->=
page_offset);
> -}
> -
> -static int ionic_rx_page_alloc(struct ionic_queue *q,
> -                              struct ionic_buf_info *buf_info)
> -{
> -       struct device *dev =3D q->dev;
> -       dma_addr_t dma_addr;
> -       struct page *page;
> -
> -       page =3D alloc_pages(IONIC_PAGE_GFP_MASK, 0);
> -       if (unlikely(!page)) {
> -               net_err_ratelimited("%s: %s page alloc failed\n",
> -                                   dev_name(dev), q->name);
> -               q_to_rx_stats(q)->alloc_err++;
> -               return -ENOMEM;
> -       }
> -
> -       dma_addr =3D dma_map_page(dev, page, 0,
> -                               IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
> -       if (unlikely(dma_mapping_error(dev, dma_addr))) {
> -               __free_pages(page, 0);
> -               net_err_ratelimited("%s: %s dma map failed\n",
> -                                   dev_name(dev), q->name);
> -               q_to_rx_stats(q)->dma_map_err++;
> -               return -EIO;
> -       }
> -
> -       buf_info->dma_addr =3D dma_addr;
> -       buf_info->page =3D page;
> -       buf_info->page_offset =3D 0;
> -
> -       return 0;
> -}
> -
> -static void ionic_rx_page_free(struct ionic_queue *q,
> -                              struct ionic_buf_info *buf_info)
> -{
> -       struct device *dev =3D q->dev;
> -
> -       if (unlikely(!buf_info)) {
> -               net_err_ratelimited("%s: %s invalid buf_info in free\n",
> -                                   dev_name(dev), q->name);
> -               return;
> -       }
> -
>         if (!buf_info->page)
>                 return;
>
> -       dma_unmap_page(dev, buf_info->dma_addr, IONIC_PAGE_SIZE, DMA_FROM=
_DEVICE);
> -       __free_pages(buf_info->page, 0);
> +       page_pool_put_full_page(q->page_pool, buf_info->page, false);
>         buf_info->page =3D NULL;
> -}
> -
> -static bool ionic_rx_buf_recycle(struct ionic_queue *q,
> -                                struct ionic_buf_info *buf_info, u32 len=
)
> -{
> -       u32 size;
> -
> -       /* don't re-use pages allocated in low-mem condition */
> -       if (page_is_pfmemalloc(buf_info->page))
> -               return false;
> -
> -       /* don't re-use buffers from non-local numa nodes */
> -       if (page_to_nid(buf_info->page) !=3D numa_mem_id())
> -               return false;
> -
> -       size =3D ALIGN(len, q->xdp_rxq_info ? IONIC_PAGE_SIZE : IONIC_PAG=
E_SPLIT_SZ);
> -       buf_info->page_offset +=3D size;
> -       if (buf_info->page_offset >=3D IONIC_PAGE_SIZE)
> -               return false;
> -
> -       get_page(buf_info->page);
> -
> -       return true;
> +       buf_info->len =3D 0;
> +       buf_info->page_offset =3D 0;
>  }
>
>  static void ionic_rx_add_skb_frag(struct ionic_queue *q,
> @@ -207,18 +141,19 @@ static void ionic_rx_add_skb_frag(struct ionic_queu=
e *q,
>  {
>         if (!synced)
>                 dma_sync_single_range_for_cpu(q->dev, ionic_rx_buf_pa(buf=
_info),
> -                                             off, len, DMA_FROM_DEVICE);
> +                                             off, len,
> +                                             page_pool_get_dma_dir(q->pa=
ge_pool));
>
>         skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
>                         buf_info->page, buf_info->page_offset + off,
> -                       len,
> -                       IONIC_PAGE_SIZE);
> +                       len, buf_info->len);
>
> -       if (!ionic_rx_buf_recycle(q, buf_info, len)) {
> -               dma_unmap_page(q->dev, buf_info->dma_addr,
> -                              IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
> -               buf_info->page =3D NULL;
> -       }
> +       /* napi_gro_frags() will release/recycle the
> +        * page_pool buffers from the frags list
> +        */
> +       buf_info->page =3D NULL;
> +       buf_info->len =3D 0;
> +       buf_info->page_offset =3D 0;
>  }
>
>  static struct sk_buff *ionic_rx_build_skb(struct ionic_queue *q,
> @@ -243,12 +178,13 @@ static struct sk_buff *ionic_rx_build_skb(struct io=
nic_queue *q,
>                 q_to_rx_stats(q)->alloc_err++;
>                 return NULL;
>         }
> +       skb_mark_for_recycle(skb);
>
>         if (headroom)
>                 frag_len =3D min_t(u16, len,
>                                  IONIC_XDP_MAX_LINEAR_MTU + VLAN_ETH_HLEN=
);
>         else
> -               frag_len =3D min_t(u16, len, ionic_rx_buf_size(buf_info))=
;
> +               frag_len =3D min_t(u16, len, IONIC_PAGE_SIZE);
>
>         if (unlikely(!buf_info->page))
>                 goto err_bad_buf_page;
> @@ -259,7 +195,7 @@ static struct sk_buff *ionic_rx_build_skb(struct ioni=
c_queue *q,
>         for (i =3D 0; i < num_sg_elems; i++, buf_info++) {
>                 if (unlikely(!buf_info->page))
>                         goto err_bad_buf_page;
> -               frag_len =3D min_t(u16, len, ionic_rx_buf_size(buf_info))=
;
> +               frag_len =3D min_t(u16, len, buf_info->len);
>                 ionic_rx_add_skb_frag(q, skb, buf_info, 0, frag_len, sync=
ed);
>                 len -=3D frag_len;
>         }
> @@ -276,11 +212,14 @@ static struct sk_buff *ionic_rx_copybreak(struct ne=
t_device *netdev,
>                                           struct ionic_rx_desc_info *desc=
_info,
>                                           unsigned int headroom,
>                                           unsigned int len,
> +                                         unsigned int num_sg_elems,
>                                           bool synced)
>  {
>         struct ionic_buf_info *buf_info;
> +       enum dma_data_direction dma_dir;
>         struct device *dev =3D q->dev;
>         struct sk_buff *skb;
> +       int i;
>
>         buf_info =3D &desc_info->bufs[0];
>
> @@ -291,54 +230,58 @@ static struct sk_buff *ionic_rx_copybreak(struct ne=
t_device *netdev,
>                 q_to_rx_stats(q)->alloc_err++;
>                 return NULL;
>         }
> +       skb_mark_for_recycle(skb);
>
> -       if (unlikely(!buf_info->page)) {
> -               dev_kfree_skb(skb);
> -               return NULL;
> -       }
> -
> +       dma_dir =3D page_pool_get_dma_dir(q->page_pool);
>         if (!synced)
>                 dma_sync_single_range_for_cpu(dev, ionic_rx_buf_pa(buf_in=
fo),
> -                                             headroom, len, DMA_FROM_DEV=
ICE);
> +                                             headroom, len, dma_dir);
>         skb_copy_to_linear_data(skb, ionic_rx_buf_va(buf_info) + headroom=
, len);
> -       dma_sync_single_range_for_device(dev, ionic_rx_buf_pa(buf_info),
> -                                        headroom, len, DMA_FROM_DEVICE);
>
>         skb_put(skb, len);
>         skb->protocol =3D eth_type_trans(skb, netdev);
>
> +       /* recycle the Rx buffer now that we're done with it */
> +       ionic_rx_put_buf(q, buf_info);
> +       buf_info++;
> +       for (i =3D 0; i < num_sg_elems; i++, buf_info++)
> +               ionic_rx_put_buf(q, buf_info);
> +
>         return skb;
>  }
>
> +static void ionic_xdp_rx_put_bufs(struct ionic_queue *q,
> +                                 struct ionic_buf_info *buf_info,
> +                                 int nbufs)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < nbufs; i++) {
> +               buf_info->page =3D NULL;
> +               buf_info++;
> +       }
> +}
> +
>  static void ionic_xdp_tx_desc_clean(struct ionic_queue *q,
>                                     struct ionic_tx_desc_info *desc_info)
>  {
> -       unsigned int nbufs =3D desc_info->nbufs;
> -       struct ionic_buf_info *buf_info;
> -       struct device *dev =3D q->dev;
> -       int i;
> +       struct xdp_frame_bulk bq;
>
> -       if (!nbufs)
> +       if (!desc_info->nbufs)
>                 return;
>
> -       buf_info =3D desc_info->bufs;
> -       dma_unmap_single(dev, buf_info->dma_addr,
> -                        buf_info->len, DMA_TO_DEVICE);
> -       if (desc_info->act =3D=3D XDP_TX)
> -               __free_pages(buf_info->page, 0);
> -       buf_info->page =3D NULL;
> +       xdp_frame_bulk_init(&bq);
> +       rcu_read_lock(); /* need for xdp_return_frame_bulk */
>
> -       buf_info++;
> -       for (i =3D 1; i < nbufs + 1 && buf_info->page; i++, buf_info++) {
> -               dma_unmap_page(dev, buf_info->dma_addr,
> -                              buf_info->len, DMA_TO_DEVICE);
> -               if (desc_info->act =3D=3D XDP_TX)
> -                       __free_pages(buf_info->page, 0);
> -               buf_info->page =3D NULL;
> +       if (desc_info->act =3D=3D XDP_TX) {
> +               xdp_return_frame_rx_napi(desc_info->xdpf);
> +       } else if (desc_info->act =3D=3D XDP_REDIRECT) {
> +               ionic_tx_desc_unmap_bufs(q, desc_info);
> +               xdp_return_frame_bulk(desc_info->xdpf, &bq);
>         }
>
> -       if (desc_info->act =3D=3D XDP_REDIRECT)
> -               xdp_return_frame(desc_info->xdpf);
> +       xdp_flush_frame_bulk(&bq);
> +       rcu_read_unlock();
>
>         desc_info->nbufs =3D 0;
>         desc_info->xdpf =3D NULL;
> @@ -362,9 +305,15 @@ static int ionic_xdp_post_frame(struct ionic_queue *=
q, struct xdp_frame *frame,
>         buf_info =3D desc_info->bufs;
>         stats =3D q_to_tx_stats(q);
>
> -       dma_addr =3D ionic_tx_map_single(q, frame->data, len);
> -       if (!dma_addr)
> -               return -EIO;
> +       if (act =3D=3D XDP_TX) {
> +               dma_addr =3D page_pool_get_dma_addr(page) + off;
> +               dma_sync_single_for_device(q->dev, dma_addr, len, DMA_TO_=
DEVICE);
> +       } else /* XDP_REDIRECT */ {
> +               dma_addr =3D ionic_tx_map_single(q, frame->data, len);
> +               if (dma_mapping_error(q->dev, dma_addr))
> +                       return -EIO;
> +       }
> +
>         buf_info->dma_addr =3D dma_addr;
>         buf_info->len =3D len;
>         buf_info->page =3D page;
> @@ -386,10 +335,19 @@ static int ionic_xdp_post_frame(struct ionic_queue =
*q, struct xdp_frame *frame,
>                 frag =3D sinfo->frags;
>                 elem =3D ionic_tx_sg_elems(q);
>                 for (i =3D 0; i < sinfo->nr_frags; i++, frag++, bi++) {
> -                       dma_addr =3D ionic_tx_map_frag(q, frag, 0, skb_fr=
ag_size(frag));
> -                       if (!dma_addr) {
> -                               ionic_tx_desc_unmap_bufs(q, desc_info);
> -                               return -EIO;
> +                       if (act =3D=3D XDP_TX) {
> +                               dma_addr =3D page_pool_get_dma_addr(skb_f=
rag_page(frag));
> +                               dma_addr +=3D skb_frag_off(frag);
> +                               dma_sync_single_for_device(q->dev, dma_ad=
dr,
> +                                                          skb_frag_size(=
frag),
> +                                                          DMA_TO_DEVICE)=
;
> +                       } else {
> +                               dma_addr =3D ionic_tx_map_frag(q, frag, 0=
,
> +                                                            skb_frag_siz=
e(frag));
> +                               if (dma_mapping_error(q->dev, dma_addr)) =
{
> +                                       ionic_tx_desc_unmap_bufs(q, desc_=
info);
> +                                       return -EIO;
> +                               }
>                         }
>                         bi->dma_addr =3D dma_addr;
>                         bi->len =3D skb_frag_size(frag);
> @@ -493,6 +451,7 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stat=
s,
>         struct netdev_queue *nq;
>         struct xdp_frame *xdpf;
>         int remain_len;
> +       int nbufs =3D 1;
>         int frag_len;
>         int err =3D 0;
>
> @@ -526,13 +485,13 @@ static bool ionic_run_xdp(struct ionic_rx_stats *st=
ats,
>                 do {
>                         if (unlikely(sinfo->nr_frags >=3D MAX_SKB_FRAGS))=
 {
>                                 err =3D -ENOSPC;
> -                               goto out_xdp_abort;
> +                               break;
>                         }
>
>                         frag =3D &sinfo->frags[sinfo->nr_frags];
>                         sinfo->nr_frags++;
>                         bi++;
> -                       frag_len =3D min_t(u16, remain_len, ionic_rx_buf_=
size(bi));
> +                       frag_len =3D min_t(u16, remain_len, bi->len);
>                         dma_sync_single_range_for_cpu(rxq->dev, ionic_rx_=
buf_pa(bi),
>                                                       0, frag_len, DMA_FR=
OM_DEVICE);
>                         skb_frag_fill_page_desc(frag, bi->page, 0, frag_l=
en);
> @@ -542,6 +501,7 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stat=
s,
>                         if (page_is_pfmemalloc(bi->page))
>                                 xdp_buff_set_frag_pfmemalloc(&xdp_buf);
>                 } while (remain_len > 0);
> +               nbufs +=3D sinfo->nr_frags;
>         }
>
>         xdp_action =3D bpf_prog_run_xdp(xdp_prog, &xdp_buf);
> @@ -552,14 +512,15 @@ static bool ionic_run_xdp(struct ionic_rx_stats *st=
ats,
>                 return false;  /* false =3D we didn't consume the packet =
*/
>
>         case XDP_DROP:
> -               ionic_rx_page_free(rxq, buf_info);
>                 stats->xdp_drop++;
>                 break;
>
>         case XDP_TX:
>                 xdpf =3D xdp_convert_buff_to_frame(&xdp_buf);
> -               if (!xdpf)
> -                       goto out_xdp_abort;
> +               if (!xdpf) {
> +                       err =3D -ENOSPC;
> +                       break;
> +               }
>
>                 txq =3D rxq->partner;
>                 nq =3D netdev_get_tx_queue(netdev, txq->index);
> @@ -571,12 +532,10 @@ static bool ionic_run_xdp(struct ionic_rx_stats *st=
ats,
>                                           ionic_q_space_avail(txq),
>                                           1, 1)) {
>                         __netif_tx_unlock(nq);
> -                       goto out_xdp_abort;
> +                       err =3D -EIO;
> +                       break;
>                 }
>
> -               dma_unmap_page(rxq->dev, buf_info->dma_addr,
> -                              IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
> -
>                 err =3D ionic_xdp_post_frame(txq, xdpf, XDP_TX,
>                                            buf_info->page,
>                                            buf_info->page_offset,
> @@ -584,40 +543,35 @@ static bool ionic_run_xdp(struct ionic_rx_stats *st=
ats,
>                 __netif_tx_unlock(nq);
>                 if (unlikely(err)) {
>                         netdev_dbg(netdev, "tx ionic_xdp_post_frame err %=
d\n", err);
> -                       goto out_xdp_abort;
> +                       break;
>                 }
> -               buf_info->page =3D NULL;
> +               ionic_xdp_rx_put_bufs(rxq, buf_info, nbufs);
>                 stats->xdp_tx++;
>
> -               /* the Tx completion will free the buffers */
>                 break;
>
>         case XDP_REDIRECT:
> -               /* unmap the pages before handing them to a different dev=
ice */
> -               dma_unmap_page(rxq->dev, buf_info->dma_addr,
> -                              IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
> -
>                 err =3D xdp_do_redirect(netdev, &xdp_buf, xdp_prog);
>                 if (unlikely(err)) {
>                         netdev_dbg(netdev, "xdp_do_redirect err %d\n", er=
r);
> -                       goto out_xdp_abort;
> +                       break;
>                 }
> -               buf_info->page =3D NULL;
> +
>                 rxq->xdp_flush =3D true;
> +               ionic_xdp_rx_put_bufs(rxq, buf_info, nbufs);
>                 stats->xdp_redirect++;
>                 break;
>
>         case XDP_ABORTED:
>         default:
> -               goto out_xdp_abort;
> +               err =3D -EIO;
> +               break;
>         }
>
> -       return true;
> -
> -out_xdp_abort:
> -       trace_xdp_exception(netdev, xdp_prog, xdp_action);
> -       ionic_rx_page_free(rxq, buf_info);
> -       stats->xdp_aborted++;
> +       if (err) {
> +               trace_xdp_exception(netdev, xdp_prog, xdp_action);
> +               stats->xdp_aborted++;
> +       }
>
>         return true;
>  }
> @@ -639,6 +593,15 @@ static void ionic_rx_clean(struct ionic_queue *q,
>         stats =3D q_to_rx_stats(q);
>
>         if (comp->status) {
> +               struct ionic_rxq_desc *desc =3D &q->rxq[q->head_idx];
> +
> +               /* Most likely status=3D=3D2 and the pkt received was big=
ger
> +                * than the buffer available: comp->len will show the
> +                * pkt size received that didn't fit the advertised desc.=
len
> +                */
> +               dev_dbg(q->dev, "q%d drop comp->status %d comp->len %d de=
sc.len %d\n",
> +                       q->index, comp->status, comp->len, desc->len);
> +
>                 stats->dropped++;
>                 return;
>         }
> @@ -658,7 +621,8 @@ static void ionic_rx_clean(struct ionic_queue *q,
>         use_copybreak =3D len <=3D q->lif->rx_copybreak;
>         if (use_copybreak)
>                 skb =3D ionic_rx_copybreak(netdev, q, desc_info,
> -                                        headroom, len, synced);
> +                                        headroom, len,
> +                                        comp->num_sg_elems, synced);
>         else
>                 skb =3D ionic_rx_build_skb(q, desc_info, headroom, len,
>                                          comp->num_sg_elems, synced);
> @@ -798,32 +762,38 @@ void ionic_rx_fill(struct ionic_queue *q)
>
>         for (i =3D n_fill; i; i--) {
>                 unsigned int headroom;
> -               unsigned int buf_len;
>
>                 nfrags =3D 0;
>                 remain_len =3D len;
>                 desc =3D &q->rxq[q->head_idx];
>                 desc_info =3D &q->rx_info[q->head_idx];
>                 buf_info =3D &desc_info->bufs[0];
> -
> -               if (!buf_info->page) { /* alloc a new buffer? */
> -                       if (unlikely(ionic_rx_page_alloc(q, buf_info))) {
> -                               desc->addr =3D 0;
> -                               desc->len =3D 0;
> -                               return;
> -                       }
> -               }
> +               ionic_rx_put_buf(q, buf_info);
>
>                 /* fill main descriptor - buf[0]
>                  * XDP uses space in the first buffer, so account for
>                  * head room, tail room, and ip header in the first frag =
size.
>                  */
>                 headroom =3D q->xdp_rxq_info ? XDP_PACKET_HEADROOM : 0;
> -               if (q->xdp_rxq_info)
> -                       buf_len =3D IONIC_XDP_MAX_LINEAR_MTU + VLAN_ETH_H=
LEN;
> -               else
> -                       buf_len =3D ionic_rx_buf_size(buf_info);
> -               frag_len =3D min_t(u16, len, buf_len);
> +               if (q->xdp_rxq_info) {
> +                       /* Always alloc the full size buffer, but only ne=
ed
> +                        * the actual frag_len in the descriptor
> +                        */
> +                       buf_info->len =3D IONIC_XDP_MAX_LINEAR_MTU + VLAN=
_ETH_HLEN;
> +                       frag_len =3D min_t(u16, len, buf_info->len);
> +               } else {
> +                       /* Start with max buffer size, then use
> +                        * the frag size for the actual size to alloc
> +                        */
> +                       frag_len =3D min_t(u16, len, IONIC_PAGE_SIZE);
> +                       buf_info->len =3D frag_len;
> +               }
> +
> +               buf_info->page =3D page_pool_alloc(q->page_pool,
> +                                                &buf_info->page_offset,
> +                                                &buf_info->len, GFP_ATOM=
IC);
> +               if (unlikely(!buf_info->page))
> +                       return;
>
>                 desc->addr =3D cpu_to_le64(ionic_rx_buf_pa(buf_info) + he=
adroom);
>                 desc->len =3D cpu_to_le16(frag_len);
> @@ -833,20 +803,31 @@ void ionic_rx_fill(struct ionic_queue *q)
>
>                 /* fill sg descriptors - buf[1..n] */
>                 sg_elem =3D q->rxq_sgl[q->head_idx].elems;
> -               for (j =3D 0; remain_len > 0 && j < q->max_sg_elems; j++,=
 sg_elem++) {
> -                       if (!buf_info->page) { /* alloc a new sg buffer? =
*/
> -                               if (unlikely(ionic_rx_page_alloc(q, buf_i=
nfo))) {
> -                                       sg_elem->addr =3D 0;
> -                                       sg_elem->len =3D 0;
> +               for (j =3D 0; remain_len > 0 && j < q->max_sg_elems; j++)=
 {
> +                       frag_len =3D min_t(u16, remain_len, IONIC_PAGE_SI=
ZE);
> +
> +                       /* Recycle any "wrong" sized buffers */
> +                       if (unlikely(buf_info->page && buf_info->len !=3D=
 frag_len))
> +                               ionic_rx_put_buf(q, buf_info);
> +
> +                       /* Get new buffer if needed */
> +                       if (!buf_info->page) {
> +                               buf_info->len =3D frag_len;
> +                               buf_info->page =3D page_pool_alloc(q->pag=
e_pool,
> +                                                                &buf_inf=
o->page_offset,
> +                                                                &buf_inf=
o->len, GFP_ATOMIC);
> +                               if (unlikely(!buf_info->page)) {
> +                                       buf_info->len =3D 0;
>                                         return;
>                                 }
>                         }
>
>                         sg_elem->addr =3D cpu_to_le64(ionic_rx_buf_pa(buf=
_info));
> -                       frag_len =3D min_t(u16, remain_len, ionic_rx_buf_=
size(buf_info));
>                         sg_elem->len =3D cpu_to_le16(frag_len);
> +
>                         remain_len -=3D frag_len;
>                         buf_info++;
> +                       sg_elem++;
>                         nfrags++;
>                 }
>
> @@ -873,17 +854,12 @@ void ionic_rx_fill(struct ionic_queue *q)
>  void ionic_rx_empty(struct ionic_queue *q)
>  {
>         struct ionic_rx_desc_info *desc_info;
> -       struct ionic_buf_info *buf_info;
>         unsigned int i, j;
>
>         for (i =3D 0; i < q->num_descs; i++) {
>                 desc_info =3D &q->rx_info[i];
> -               for (j =3D 0; j < ARRAY_SIZE(desc_info->bufs); j++) {
> -                       buf_info =3D &desc_info->bufs[j];
> -                       if (buf_info->page)
> -                               ionic_rx_page_free(q, buf_info);
> -               }
> -
> +               for (j =3D 0; j < ARRAY_SIZE(desc_info->bufs); j++)
> +                       ionic_rx_put_buf(q, &desc_info->bufs[j]);
>                 desc_info->nbufs =3D 0;
>         }
>
> --
> 2.17.1
>
>

I tested this patch with my test environment.

1. XDP_TX doesn't work.
XDP_TX doesn't work both non-jumbo and jumbo frame.
I can see the "hw_tx_dropped" stats counter is increased.

2. kernel panic while module unload.
While packets are forwarding, kernel panic occurs when ionic module is unlo=
aded.
Splat looks like:
[ 491.778972][ T2037] BUG: kernel NULL pointer dereference, address:
0000000000000038
[ 491.786611][ T2037] #PF: supervisor read access in kernel mode
[ 491.792417][ T2037] #PF: error_code(0x0000) - not-present page
[ 491.798228][ T2037] PGD 0 P4D 0
[ 491.801449][ T2037] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[ 491.807003][ T2037] CPU: 0 PID: 2037 Comm: modprobe Not tainted
6.10.0-rc4+ #26 8ee6f1935b98ee80fc8efc898f5c361a654c4c
[ 491.817818][ T2037] Hardware name: ASUS System Product Name/PRIME
Z690-P D4, BIOS 0603 11/01/2021
[ 491.826651][ T2037] RIP: 0010:__xdp_return+0x1a3/0x2a0
[ 491.831770][ T2037] Code: a8 40 0f 84 70 ff ff ff 48 8b 47 48 48 8d
70 ff a8 01 48 0f 44 f7 e9 5d ff ff ff 65 48 8b 08
[ 491.851137][ T2037] RSP: 0018:ffffaa0a0367fb58 EFLAGS: 00010202
[ 491.857034][ T2037] RAX: 0000000000000000 RBX: ffffaa0a03891460 RCX:
0000000000000000
[ 491.864830][ T2037] RDX: 0000000000000001 RSI: fffff3b5c47ca280 RDI:
fffff3b5c47ca280
[ 491.872627][ T2037] RBP: ffff8890c9b9d928 R08: 00000000000027e0 R09:
0000000000000001
[ 491.880423][ T2037] R10: 0000000000000001 R11: 0000000000000001 R12:
0000000000000000
[ 491.888222][ T2037] R13: ffff8890ea339c28 R14: dead000000000122 R15:
dead000000000100
[ 491.896016][ T2037] FS: 00007f88a3560080(0000)
GS:ffff88981f600000(0000) knlGS:0000000000000000
[ 491.904764][ T2037] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 491.911178][ T2037] CR2: 0000000000000038 CR3: 0000000121f08000 CR4:
00000000007506f0
[ 491.918976][ T2037] PKRU: 55555554
[ 491.922367][ T2037] Call Trace:
[ 491.925503][ T2037] <TASK>
[ 491.928291][ T2037] ? __die+0x20/0x70
[ 491.932028][ T2037] ? page_fault_oops+0x15a/0x460
[ 491.936803][ T2037] ? exc_page_fault+0x6e/0x180
[ 491.941405][ T2037] ? asm_exc_page_fault+0x22/0x30
[ 491.946265][ T2037] ? __xdp_return+0x1a3/0x2a0
[ 491.950782][ T2037] ionic_xdp_tx_desc_clean+0xa3/0xd0 [ionic
9c1054c179a7af78fbb02f44dc67920b196ecffd]
[ 491.960150][ T2037] ? __wait_for_common+0x16e/0x1a0
[ 491.965096][ T2037] ? ionic_adminq_wait+0x91/0x2d0 [ionic
9c1054c179a7af78fbb02f44dc67920b196ecffd]
[ 491.974187][ T2037] ionic_tx_clean+0x56/0x180 [ionic
9c1054c179a7af78fbb02f44dc67920b196ecffd]
[ 491.982847][ T2037] ionic_tx_empty+0x43/0xe0 [ionic
9c1054c179a7af78fbb02f44dc67920b196ecffd]
[ 491.991420][ T2037] ionic_txrx_deinit+0x5a/0x150 [ionic
9c1054c179a7af78fbb02f44dc67920b196ecffd]
[ 492.000339][ T2037] ionic_stop+0x50/0x70 [ionic
9c1054c179a7af78fbb02f44dc67920b196ecffd]
[ 492.008566][ T2037] __dev_close_many+0xa7/0x120
[ 492.013169][ T2037] dev_close_many+0x95/0x160
[ 492.017597][ T2037] unregister_netdevice_many_notify+0x171/0x7f0
[ 492.023666][ T2037] ? trace_hardirqs_off+0x26/0x80
[ 492.028528][ T2037] ? try_to_grab_pending+0x105/0x1e0
[ 492.033647][ T2037] unregister_netdevice_queue+0xa2/0xe0
[ 492.039024][ T2037] unregister_netdev+0x18/0x20
[ 492.043627][ T2037] ionic_lif_unregister+0x68/0x70 [ionic
9c1054c179a7af78fbb02f44dc67920b196ecffd]
[ 492.052718][ T2037] ionic_remove+0x52/0xe0 [ionic
9c1054c179a7af78fbb02f44dc67920b196ecffd]

3. Failed to set channel configuration.
"ethtool -L eth0 combined 1" command fails if xdp is set and prints
the following messages.
[ 26.268801] ionic 0000:0a:00.0 enp10s0np0: Changing queue count from 4 to =
1
[ 26.375416] ionic 0000:0a:00.0: Queue 1 xdp_rxq_info_reg_mem_model
failed, err -22
[ 26.383658] ionic 0000:0a:00.0: failed to register RX queue 1 info
for XDP, err -22
[ 26.391973] ionic 0000:0a:00.0 enp10s0np0: Failed to start queues: -22

Then it prints the following messages when module is unloaded.
[ 174.317791] WARNING: CPU: 0 PID: 1310 at net/core/page_pool.c:1030
page_pool_destroy+0x174/0x190
[ 174.317797] Modules linked in: 8021q garp mrp veth xt_nat xt_tcpudp
xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf
_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
xfrm_user xt_addrtype nft_compat nf_tables br_netfilter bri
dge stp llc af_packet qrtr overlay x86_pkg_temp_thermal
crct10dif_pclmul crc32_generic crc32_pclmul crc32c_intel polyval_
clmulni polyval_generic ghash_clmulni_intel sha512_ssse3 amdgpu
sha256_ssse3 sha1_ssse3 wmi_bmof xts cfg80211 cts amdxcp
i2c_algo_bit drm_ttm_helper ttm drm_exec gpu_sched aesni_intel
crypto_simd drm_suballoc_helper drm_buddy cryptd drm_displ
ay_helper drm_kms_helper bnxt_en syscopyarea sysfillrect sysimgblt
ionic(-) fb_sys_fops video hwmon fb ptp wmi msr drm dr
m_panel_orientation_quirks backlight nfnetlink bpf_preload ip_tables x_tabl=
es
[ 174.317823] CPU: 0 PID: 1310 Comm: modprobe Not tainted 6.10.0-rc4+
#26 8ee6f1935b98ee80fc8efc898f5c361a654c450c
[ 174.317825] Hardware name: ASUS System Product Name/PRIME Z690-P D4,
BIOS 0603 11/01/2021
[ 174.317826] RIP: 0010:page_pool_destroy+0x174/0x190
[ 174.317827] Code: cc cc cc 48 c7 46 28 01 00 00 00 48 89 df e8 c3 ec
ff ff e9 55 ff ff ff be 03 00 00 00 5b e9 e3 45 c
2 ff 0f 0b e9 ee fe ff ff <0f> 0b e9 db fe ff ff 0f 0b e9 35 ff ff ff
66 66 2e 0f 1f 84 00 00
[ 174.317828] RSP: 0018:ffff94e142fdfc48 EFLAGS: 00010246
[ 174.317829] RAX: ffff8add89cab268 RBX: ffff8add89caf800 RCX: 000000000005=
e540
[ 174.317830] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8add89ca=
fe0c
[ 174.317831] RBP: 0000000000000000 R08: 0000000000000000 R09: ffff8add8013=
a700
[ 174.317832] R10: 0000000000000001 R11: 0000000000000001 R12: ffff8addb761=
0a20
[ 174.317832] R13: ffff94e142fdfd48 R14: dead000000000122 R15: dead00000000=
0100
[ 174.317833] FS: 00007f2d9b9e0080(0000) GS:ffff8ae4df600000(0000)
knlGS:0000000000000000
[ 174.317834] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [
174.317834] CR2: 00005574d929fbc0 CR3: 0000000109d9e000 CR4:
00000000007506f0
[ 174.317835] PKRU: 55555554
[ 174.317836] Call Trace:
[ 174.317837] <TASK>
[ 174.317839] ? __warn+0x7f/0x120
[ 174.317841] ? page_pool_destroy+0x174/0x190
[ 174.317842] ? report_bug+0x18a/0x1a0
[ 174.317844] ? handle_bug+0x3c/0x70
[ 174.317846] ? exc_invalid_op+0x14/0x70
[ 174.317848] ? asm_exc_invalid_op+0x16/0x20
[ 174.317851] ? page_pool_destroy+0x174/0x190
[ 174.317852] ionic_qcq_free+0x119/0x150 [ionic
9c1054c179a7af78fbb02f44dc67920b196ecffd]
[ 174.317860] ionic_txrx_free+0x98/0x150 [ionic
9c1054c179a7af78fbb02f44dc67920b196ecffd]
[ 174.317866] ionic_stop+0x58/0x70 [ionic
9c1054c179a7af78fbb02f44dc67920b196ecffd]
[ 174.317879] __dev_close_many+0xa7/0x120
[ 174.317882] dev_close_many+0x95/0x160
[ 174.317884] unregister_netdevice_many_notify+0x171/0x7f0

Thanks a lot!
Taehee Yoo

