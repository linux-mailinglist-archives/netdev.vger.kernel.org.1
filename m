Return-Path: <netdev+bounces-106624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E5D917074
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 20:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7AE2B2636E
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 18:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6458817CA07;
	Tue, 25 Jun 2024 18:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIxIF85Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215BF17C230
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 18:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341013; cv=none; b=Lh7vsuZGHG20P5UuWY5wGWyup/acpYTMBPvgXywttBMkDAplKk61u32otJPch5T0/9+INjYu1K8e2AtdALA7xXcJ7G5L7O4HcUTB9cIMCw0hrjo4hgmOgLvHI4F+rBrjLrIwNq6fDtI2IBdClcpJLoO6Ej75bTdcGB1HHv0xE6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341013; c=relaxed/simple;
	bh=OhxPkKOcaIa4bcOTY2qtJPMlvdLdxGUYJ6RBK8chD0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EtfYeqkeCJgK2ZpHv2kBOO0BDMlxXE00qSKK8xr+6+BCaPdgXyoDFsUC6e4sHsRVQcZttlg+PeXVfjX5XakLbh/RHA6afgnnSwSDWjp3Cg5C7bg+pef24B2+Qvu0EHGZX35PblUseRE4+mhlM2tJl1rJG5UxoIjpCe2tzOyF44c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIxIF85Q; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c84df0e2f4so2210530a91.1
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 11:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719341010; x=1719945810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5T7MXsK9tWEspA19n1VArZjTlTRHs5uDHKLCDquWEEI=;
        b=hIxIF85QHm6MMJ1rAh5V21RhFZd6KRLF900Tpij73ZyCR8uDA6mt0JoyFYhR7Zc3Ed
         p8DRsnqERL4qgx699qLgbsr+in1C1bwBGzVrS8iR8N7cIQ7KgDZrDz3BuAmAP7mLT8wN
         NjS/FbJAWy9AccESl0y9043QtiNYodnEn76AK701fF1EbL7lJsA+9S7QslFHluJg2MEW
         UyD1zOBcPbLO9P1e/+PMZ0nPiHH5dgmWX7Ez5Si2loYLy5RMb+dehwrlntAEi+q3Ft5u
         A3en/RAsftBKvSZbn2KF7teQoJ2HruMrwvTtE/IyVGY9+KYfsLa7FNYky/Wv3Nmvkd+Y
         LYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719341010; x=1719945810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5T7MXsK9tWEspA19n1VArZjTlTRHs5uDHKLCDquWEEI=;
        b=oJsBPUAdU1ZnAGCwOxE1FEYBjapDHy1nNAfJZpfy9J/6fGob2LsxrfhD/C97fImI59
         1ojVdaCSC9fD/eLiKRB/shjNoDFnWZltLmiLosaCQjLRelguJnwMPJm+OA418F1IPoam
         6N8sS5WdMmVz0mzIJjRHMt2zU/6L92FQY/T+tQksXdUQjJ+c4fAJJks+23jGSjDLGPNm
         KNyIfaEYTvUgwoKAAEzP8zIVe5CDQoz28tHN0uj6JvgwcKVCkzTE+VqqVbcGAgl3BiC2
         oOx/qiFN7/A+CweLE55TBEQLUl8sunwbdyAk/Fpc7Ajm6tZ7+KKotrxSMheEKxEsDcYm
         Ayqw==
X-Gm-Message-State: AOJu0YyUYEiFK3xNWKcmBXhGQ2AYvEdDBPWwWmu1XqFjVe2/mbtyEb8L
	iksyJwj5jC5NLDNUA3Sf2qYvm4RNrK/wQu9VbNoZsoePdzlr8zUj8ryxUXxG1fL2cltIHKItFwM
	W47Mg/8IzMt7IAlEVu2nViLftP4Q=
X-Google-Smtp-Source: AGHT+IE+uOHn1oCm8ecKl9Ksvuv+sjpb0AOulnnL6Rugd5Xe83fncXMMc03MsU3eXH5w1ll2HuFcghgcMfCMjiUpJ2E=
X-Received: by 2002:a17:90a:e643:b0:2c4:e033:5187 with SMTP id
 98e67ed59e1d1-2c8a23c8bd0mr5978545a91.24.1719341010041; Tue, 25 Jun 2024
 11:43:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625165658.34598-1-shannon.nelson@amd.com>
 <CAMArcTUG9C--vX2xPoi4C73vJ5uDy5=FeU3r=eUnxmvwQQHQTQ@mail.gmail.com> <25fd96cc-10ce-4ef5-b668-b54d130a0996@amd.com>
In-Reply-To: <25fd96cc-10ce-4ef5-b668-b54d130a0996@amd.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 26 Jun 2024 03:43:16 +0900
Message-ID: <CAMArcTULn54gfzVHyBDz=DZsYeAQmzCf0C-4CJi2-3Zr__tvxg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] ionic: convert Rx queue buffers to use page_pool
To: "Nelson, Shannon" <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, pabeni@redhat.com, brett.creeley@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 3:28=E2=80=AFAM Nelson, Shannon <shannon.nelson@amd=
.com> wrote:
>
> On 6/25/2024 11:12 AM, Taehee Yoo wrote:
> >
> > On Wed, Jun 26, 2024 at 1:57=E2=80=AFAM Shannon Nelson <shannon.nelson@=
amd.com> wrote:
> >>
> >
> > Hi Shannon,Thanks a lot for this work!
> >> Our home-grown buffer management needs to go away and we need
> >> to be playing nicely with the page_pool infrastructure.  This
> >> converts the Rx traffic queues to use page_pool.
> >>
> >> RFC: This is still being tweaked and tested, but has passed some
> >>       basic testing for both normal and jumbo frames going through
> >>       normal paths as well as XDP PASS, DROP, ABORTED, TX, and
> >>       REDIRECT paths.  It has not been under any performance test
> >>       runs, but a quicky iperf3 test shows similar numbers.
> >>
> >>       This patch seems far enough along that a look-over by some
> >>       page_pool experienced reviewers would be appreciated.
> >>
> >>       Thanks!
> >>       sln
> >>
> >> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> >> ---
> >>   drivers/net/ethernet/pensando/Kconfig         |   1 +
> >>   .../net/ethernet/pensando/ionic/ionic_dev.h   |   2 +-
> >>   .../net/ethernet/pensando/ionic/ionic_lif.c   |  43 ++-
> >>   .../net/ethernet/pensando/ionic/ionic_txrx.c  | 318 ++++++++--------=
--
> >>   4 files changed, 189 insertions(+), 175 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/pensando/Kconfig b/drivers/net/ether=
net/pensando/Kconfig
> >> index 3f7519e435b8..01fe76786f77 100644
> >> --- a/drivers/net/ethernet/pensando/Kconfig
> >> +++ b/drivers/net/ethernet/pensando/Kconfig
> >> @@ -23,6 +23,7 @@ config IONIC
> >>          depends on PTP_1588_CLOCK_OPTIONAL
> >>          select NET_DEVLINK
> >>          select DIMLIB
> >> +       select PAGE_POOL
> >>          help
> >>            This enables the support for the Pensando family of Etherne=
t
> >>            adapters.  More specific information on this driver can be
> >> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers=
/net/ethernet/pensando/ionic/ionic_dev.h
> >> index 92f16b6c5662..45ad2bf1e1e7 100644
> >> --- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
> >> +++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
> >> @@ -177,7 +177,6 @@ struct ionic_dev {
> >>          struct ionic_devinfo dev_info;
> >>   };
> >>
> >> -struct ionic_queue;
> >>   struct ionic_qcq;
> >>
> >>   #define IONIC_MAX_BUF_LEN                      ((u16)-1)
> >> @@ -262,6 +261,7 @@ struct ionic_queue {
> >>          };
> >>          struct xdp_rxq_info *xdp_rxq_info;
> >>          struct ionic_queue *partner;
> >> +       struct page_pool *page_pool;
> >>          dma_addr_t base_pa;
> >>          dma_addr_t cmb_base_pa;
> >>          dma_addr_t sg_base_pa;
> >> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers=
/net/ethernet/pensando/ionic/ionic_lif.c
> >> index 38ce35462737..e1cd5982bb2e 100644
> >> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> >> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> >> @@ -13,6 +13,7 @@
> >>   #include <linux/cpumask.h>
> >>   #include <linux/crash_dump.h>
> >>   #include <linux/vmalloc.h>
> >> +#include <net/page_pool/helpers.h>
> >>
> >>   #include "ionic.h"
> >>   #include "ionic_bus.h"
> >> @@ -440,6 +441,8 @@ static void ionic_qcq_free(struct ionic_lif *lif, =
struct ionic_qcq *qcq)
> >>          ionic_xdp_unregister_rxq_info(&qcq->q);
> >>          ionic_qcq_intr_free(lif, qcq);
> >>
> >> +       page_pool_destroy(qcq->q.page_pool);
> >> +       qcq->q.page_pool =3D NULL;
> >>          vfree(qcq->q.info);
> >>          qcq->q.info =3D NULL;
> >>   }
> >> @@ -579,6 +582,36 @@ static int ionic_qcq_alloc(struct ionic_lif *lif,=
 unsigned int type,
> >>                  goto err_out_free_qcq;
> >>          }
> >>
> >> +       if (type =3D=3D IONIC_QTYPE_RXQ) {
> >> +               struct page_pool_params pp_params =3D {
> >> +                       .flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_=
DEV,
> >> +                       .order =3D 0,
> >> +                       .pool_size =3D num_descs,
> >> +                       .nid =3D NUMA_NO_NODE,
> >> +                       .dev =3D lif->ionic->dev,
> >> +                       .napi =3D &new->napi,
> >> +                       .dma_dir =3D DMA_FROM_DEVICE,
> >> +                       .max_len =3D PAGE_SIZE,
> >> +                       .offset =3D 0,
> >> +                       .netdev =3D lif->netdev,
> >> +               };
> >> +               struct bpf_prog *xdp_prog;
> >> +
> >> +               xdp_prog =3D READ_ONCE(lif->xdp_prog);
> >> +               if (xdp_prog) {
> >> +                       pp_params.dma_dir =3D DMA_BIDIRECTIONAL;
> >> +                       pp_params.offset =3D XDP_PACKET_HEADROOM;
> >> +               }
> >> +
> >> +               new->q.page_pool =3D page_pool_create(&pp_params);
> >> +               if (IS_ERR(new->q.page_pool)) {
> >> +                       netdev_err(lif->netdev, "Cannot create page_po=
ol\n");
> >> +                       err =3D PTR_ERR(new->q.page_pool);
> >> +                       new->q.page_pool =3D NULL;
> >> +                       goto err_out_free_q_info;
> >> +               }
> >> +       }
> >> +
> >>          new->q.type =3D type;
> >>          new->q.max_sg_elems =3D lif->qtype_info[type].max_sg_elems;
> >>
> >> @@ -586,12 +619,12 @@ static int ionic_qcq_alloc(struct ionic_lif *lif=
, unsigned int type,
> >>                             desc_size, sg_desc_size, pid);
> >>          if (err) {
> >>                  netdev_err(lif->netdev, "Cannot initialize queue\n");
> >> -               goto err_out_free_q_info;
> >> +               goto err_out_free_page_pool;
> >>          }
> >>
> >>          err =3D ionic_alloc_qcq_interrupt(lif, new);
> >>          if (err)
> >> -               goto err_out_free_q_info;
> >> +               goto err_out_free_page_pool;
> >>
> >>          err =3D ionic_cq_init(lif, &new->cq, &new->intr, num_descs, c=
q_desc_size);
> >>          if (err) {
> >> @@ -712,6 +745,8 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, =
unsigned int type,
> >>                  devm_free_irq(dev, new->intr.vector, &new->napi);
> >>                  ionic_intr_free(lif->ionic, new->intr.index);
> >>          }
> >> +err_out_free_page_pool:
> >> +       page_pool_destroy(new->q.page_pool);
> >>   err_out_free_q_info:
> >>          vfree(new->q.info);
> >>   err_out_free_qcq:
> >> @@ -2681,7 +2716,8 @@ static int ionic_xdp_register_rxq_info(struct io=
nic_queue *q, unsigned int napi_
> >>                  goto err_out;
> >>          }
> >>
> >> -       err =3D xdp_rxq_info_reg_mem_model(rxq_info, MEM_TYPE_PAGE_ORD=
ER0, NULL);
> >> +       err =3D xdp_rxq_info_reg_mem_model(rxq_info, MEM_TYPE_PAGE_POO=
L,
> >> +                                        q->page_pool);
> >>          if (err) {
> >>                  dev_err(q->dev, "Queue %d xdp_rxq_info_reg_mem_model =
failed, err %d\n",
> >>                          q->index, err);
> >> @@ -2878,6 +2914,7 @@ static void ionic_swap_queues(struct ionic_qcq *=
a, struct ionic_qcq *b)
> >>          swap(a->q.base,       b->q.base);
> >>          swap(a->q.base_pa,    b->q.base_pa);
> >>          swap(a->q.info,       b->q.info);
> >> +       swap(a->q.page_pool,  b->q.page_pool);
> >>          swap(a->q.xdp_rxq_info, b->q.xdp_rxq_info);
> >>          swap(a->q.partner,    b->q.partner);
> >>          swap(a->q_base,       b->q_base);
> >> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/driver=
s/net/ethernet/pensando/ionic/ionic_txrx.c
> >> index 5bf13a5d411c..ffef3d66e0df 100644
> >> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> >> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> >> @@ -6,6 +6,7 @@
> >>   #include <linux/if_vlan.h>
> >>   #include <net/ip6_checksum.h>
> >>   #include <net/netdev_queues.h>
> >> +#include <net/page_pool/helpers.h>
> >>
> >>   #include "ionic.h"
> >>   #include "ionic_lif.h"
> >> @@ -117,86 +118,19 @@ static void *ionic_rx_buf_va(struct ionic_buf_in=
fo *buf_info)
> >>
> >>   static dma_addr_t ionic_rx_buf_pa(struct ionic_buf_info *buf_info)
> >>   {
> >> -       return buf_info->dma_addr + buf_info->page_offset;
> >> +       return page_pool_get_dma_addr(buf_info->page) + buf_info->page=
_offset;
> >>   }
> >>
> >> -static unsigned int ionic_rx_buf_size(struct ionic_buf_info *buf_info=
)
> >> +static void ionic_rx_put_buf(struct ionic_queue *q,
> >> +                            struct ionic_buf_info *buf_info)
> >>   {
> >> -       return min_t(u32, IONIC_MAX_BUF_LEN, IONIC_PAGE_SIZE - buf_inf=
o->page_offset);
> >> -}
> >> -
> >> -static int ionic_rx_page_alloc(struct ionic_queue *q,
> >> -                              struct ionic_buf_info *buf_info)
> >> -{
> >> -       struct device *dev =3D q->dev;
> >> -       dma_addr_t dma_addr;
> >> -       struct page *page;
> >> -
> >> -       page =3D alloc_pages(IONIC_PAGE_GFP_MASK, 0);
> >> -       if (unlikely(!page)) {
> >> -               net_err_ratelimited("%s: %s page alloc failed\n",
> >> -                                   dev_name(dev), q->name);
> >> -               q_to_rx_stats(q)->alloc_err++;
> >> -               return -ENOMEM;
> >> -       }
> >> -
> >> -       dma_addr =3D dma_map_page(dev, page, 0,
> >> -                               IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
> >> -       if (unlikely(dma_mapping_error(dev, dma_addr))) {
> >> -               __free_pages(page, 0);
> >> -               net_err_ratelimited("%s: %s dma map failed\n",
> >> -                                   dev_name(dev), q->name);
> >> -               q_to_rx_stats(q)->dma_map_err++;
> >> -               return -EIO;
> >> -       }
> >> -
> >> -       buf_info->dma_addr =3D dma_addr;
> >> -       buf_info->page =3D page;
> >> -       buf_info->page_offset =3D 0;
> >> -
> >> -       return 0;
> >> -}
> >> -
> >> -static void ionic_rx_page_free(struct ionic_queue *q,
> >> -                              struct ionic_buf_info *buf_info)
> >> -{
> >> -       struct device *dev =3D q->dev;
> >> -
> >> -       if (unlikely(!buf_info)) {
> >> -               net_err_ratelimited("%s: %s invalid buf_info in free\n=
",
> >> -                                   dev_name(dev), q->name);
> >> -               return;
> >> -       }
> >> -
> >>          if (!buf_info->page)
> >>                  return;
> >>
> >> -       dma_unmap_page(dev, buf_info->dma_addr, IONIC_PAGE_SIZE, DMA_F=
ROM_DEVICE);
> >> -       __free_pages(buf_info->page, 0);
> >> +       page_pool_put_full_page(q->page_pool, buf_info->page, false);
> >>          buf_info->page =3D NULL;
> >> -}
> >> -
> >> -static bool ionic_rx_buf_recycle(struct ionic_queue *q,
> >> -                                struct ionic_buf_info *buf_info, u32 =
len)
> >> -{
> >> -       u32 size;
> >> -
> >> -       /* don't re-use pages allocated in low-mem condition */
> >> -       if (page_is_pfmemalloc(buf_info->page))
> >> -               return false;
> >> -
> >> -       /* don't re-use buffers from non-local numa nodes */
> >> -       if (page_to_nid(buf_info->page) !=3D numa_mem_id())
> >> -               return false;
> >> -
> >> -       size =3D ALIGN(len, q->xdp_rxq_info ? IONIC_PAGE_SIZE : IONIC_=
PAGE_SPLIT_SZ);
> >> -       buf_info->page_offset +=3D size;
> >> -       if (buf_info->page_offset >=3D IONIC_PAGE_SIZE)
> >> -               return false;
> >> -
> >> -       get_page(buf_info->page);
> >> -
> >> -       return true;
> >> +       buf_info->len =3D 0;
> >> +       buf_info->page_offset =3D 0;
> >>   }
> >>
> >>   static void ionic_rx_add_skb_frag(struct ionic_queue *q,
> >> @@ -207,18 +141,19 @@ static void ionic_rx_add_skb_frag(struct ionic_q=
ueue *q,
> >>   {
> >>          if (!synced)
> >>                  dma_sync_single_range_for_cpu(q->dev, ionic_rx_buf_pa=
(buf_info),
> >> -                                             off, len, DMA_FROM_DEVIC=
E);
> >> +                                             off, len,
> >> +                                             page_pool_get_dma_dir(q-=
>page_pool));
> >>
> >>          skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
> >>                          buf_info->page, buf_info->page_offset + off,
> >> -                       len,
> >> -                       IONIC_PAGE_SIZE);
> >> +                       len, buf_info->len);
> >>
> >> -       if (!ionic_rx_buf_recycle(q, buf_info, len)) {
> >> -               dma_unmap_page(q->dev, buf_info->dma_addr,
> >> -                              IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
> >> -               buf_info->page =3D NULL;
> >> -       }
> >> +       /* napi_gro_frags() will release/recycle the
> >> +        * page_pool buffers from the frags list
> >> +        */
> >> +       buf_info->page =3D NULL;
> >> +       buf_info->len =3D 0;
> >> +       buf_info->page_offset =3D 0;
> >>   }
> >>
> >>   static struct sk_buff *ionic_rx_build_skb(struct ionic_queue *q,
> >> @@ -243,12 +178,13 @@ static struct sk_buff *ionic_rx_build_skb(struct=
 ionic_queue *q,
> >>                  q_to_rx_stats(q)->alloc_err++;
> >>                  return NULL;
> >>          }
> >> +       skb_mark_for_recycle(skb);
> >>
> >>          if (headroom)
> >>                  frag_len =3D min_t(u16, len,
> >>                                   IONIC_XDP_MAX_LINEAR_MTU + VLAN_ETH_=
HLEN);
> >>          else
> >> -               frag_len =3D min_t(u16, len, ionic_rx_buf_size(buf_inf=
o));
> >> +               frag_len =3D min_t(u16, len, IONIC_PAGE_SIZE);
> >>
> >>          if (unlikely(!buf_info->page))
> >>                  goto err_bad_buf_page;
> >> @@ -259,7 +195,7 @@ static struct sk_buff *ionic_rx_build_skb(struct i=
onic_queue *q,
> >>          for (i =3D 0; i < num_sg_elems; i++, buf_info++) {
> >>                  if (unlikely(!buf_info->page))
> >>                          goto err_bad_buf_page;
> >> -               frag_len =3D min_t(u16, len, ionic_rx_buf_size(buf_inf=
o));
> >> +               frag_len =3D min_t(u16, len, buf_info->len);
> >>                  ionic_rx_add_skb_frag(q, skb, buf_info, 0, frag_len, =
synced);
> >>                  len -=3D frag_len;
> >>          }
> >> @@ -276,11 +212,14 @@ static struct sk_buff *ionic_rx_copybreak(struct=
 net_device *netdev,
> >>                                            struct ionic_rx_desc_info *=
desc_info,
> >>                                            unsigned int headroom,
> >>                                            unsigned int len,
> >> +                                         unsigned int num_sg_elems,
> >>                                            bool synced)
> >>   {
> >>          struct ionic_buf_info *buf_info;
> >> +       enum dma_data_direction dma_dir;
> >>          struct device *dev =3D q->dev;
> >>          struct sk_buff *skb;
> >> +       int i;
> >>
> >>          buf_info =3D &desc_info->bufs[0];
> >>
> >> @@ -291,54 +230,58 @@ static struct sk_buff *ionic_rx_copybreak(struct=
 net_device *netdev,
> >>                  q_to_rx_stats(q)->alloc_err++;
> >>                  return NULL;
> >>          }
> >> +       skb_mark_for_recycle(skb);
> >>
> >> -       if (unlikely(!buf_info->page)) {
> >> -               dev_kfree_skb(skb);
> >> -               return NULL;
> >> -       }
> >> -
> >> +       dma_dir =3D page_pool_get_dma_dir(q->page_pool);
> >>          if (!synced)
> >>                  dma_sync_single_range_for_cpu(dev, ionic_rx_buf_pa(bu=
f_info),
> >> -                                             headroom, len, DMA_FROM_=
DEVICE);
> >> +                                             headroom, len, dma_dir);
> >>          skb_copy_to_linear_data(skb, ionic_rx_buf_va(buf_info) + head=
room, len);
> >> -       dma_sync_single_range_for_device(dev, ionic_rx_buf_pa(buf_info=
),
> >> -                                        headroom, len, DMA_FROM_DEVIC=
E);
> >>
> >>          skb_put(skb, len);
> >>          skb->protocol =3D eth_type_trans(skb, netdev);
> >>
> >> +       /* recycle the Rx buffer now that we're done with it */
> >> +       ionic_rx_put_buf(q, buf_info);
> >> +       buf_info++;
> >> +       for (i =3D 0; i < num_sg_elems; i++, buf_info++)
> >> +               ionic_rx_put_buf(q, buf_info);
> >> +
> >>          return skb;
> >>   }
> >>
> >> +static void ionic_xdp_rx_put_bufs(struct ionic_queue *q,
> >> +                                 struct ionic_buf_info *buf_info,
> >> +                                 int nbufs)
> >> +{
> >> +       int i;
> >> +
> >> +       for (i =3D 0; i < nbufs; i++) {
> >> +               buf_info->page =3D NULL;
> >> +               buf_info++;
> >> +       }
> >> +}
> >> +
> >>   static void ionic_xdp_tx_desc_clean(struct ionic_queue *q,
> >>                                      struct ionic_tx_desc_info *desc_i=
nfo)
> >>   {
> >> -       unsigned int nbufs =3D desc_info->nbufs;
> >> -       struct ionic_buf_info *buf_info;
> >> -       struct device *dev =3D q->dev;
> >> -       int i;
> >> +       struct xdp_frame_bulk bq;
> >>
> >> -       if (!nbufs)
> >> +       if (!desc_info->nbufs)
> >>                  return;
> >>
> >> -       buf_info =3D desc_info->bufs;
> >> -       dma_unmap_single(dev, buf_info->dma_addr,
> >> -                        buf_info->len, DMA_TO_DEVICE);
> >> -       if (desc_info->act =3D=3D XDP_TX)
> >> -               __free_pages(buf_info->page, 0);
> >> -       buf_info->page =3D NULL;
> >> +       xdp_frame_bulk_init(&bq);
> >> +       rcu_read_lock(); /* need for xdp_return_frame_bulk */
> >>
> >> -       buf_info++;
> >> -       for (i =3D 1; i < nbufs + 1 && buf_info->page; i++, buf_info++=
) {
> >> -               dma_unmap_page(dev, buf_info->dma_addr,
> >> -                              buf_info->len, DMA_TO_DEVICE);
> >> -               if (desc_info->act =3D=3D XDP_TX)
> >> -                       __free_pages(buf_info->page, 0);
> >> -               buf_info->page =3D NULL;
> >> +       if (desc_info->act =3D=3D XDP_TX) {
> >> +               xdp_return_frame_rx_napi(desc_info->xdpf);
> >> +       } else if (desc_info->act =3D=3D XDP_REDIRECT) {
> >> +               ionic_tx_desc_unmap_bufs(q, desc_info);
> >> +               xdp_return_frame_bulk(desc_info->xdpf, &bq);
> >>          }
> >>
> >> -       if (desc_info->act =3D=3D XDP_REDIRECT)
> >> -               xdp_return_frame(desc_info->xdpf);
> >> +       xdp_flush_frame_bulk(&bq);
> >> +       rcu_read_unlock();
> >>
> >>          desc_info->nbufs =3D 0;
> >>          desc_info->xdpf =3D NULL;
> >> @@ -362,9 +305,15 @@ static int ionic_xdp_post_frame(struct ionic_queu=
e *q, struct xdp_frame *frame,
> >>          buf_info =3D desc_info->bufs;
> >>          stats =3D q_to_tx_stats(q);
> >>
> >> -       dma_addr =3D ionic_tx_map_single(q, frame->data, len);
> >> -       if (!dma_addr)
> >> -               return -EIO;
> >> +       if (act =3D=3D XDP_TX) {
> >> +               dma_addr =3D page_pool_get_dma_addr(page) + off;
> >> +               dma_sync_single_for_device(q->dev, dma_addr, len, DMA_=
TO_DEVICE);
> >> +       } else /* XDP_REDIRECT */ {
> >> +               dma_addr =3D ionic_tx_map_single(q, frame->data, len);
> >> +               if (dma_mapping_error(q->dev, dma_addr))
> >> +                       return -EIO;
> >> +       }
> >> +
> >>          buf_info->dma_addr =3D dma_addr;
> >>          buf_info->len =3D len;
> >>          buf_info->page =3D page;
> >> @@ -386,10 +335,19 @@ static int ionic_xdp_post_frame(struct ionic_que=
ue *q, struct xdp_frame *frame,
> >>                  frag =3D sinfo->frags;
> >>                  elem =3D ionic_tx_sg_elems(q);
> >>                  for (i =3D 0; i < sinfo->nr_frags; i++, frag++, bi++)=
 {
> >> -                       dma_addr =3D ionic_tx_map_frag(q, frag, 0, skb=
_frag_size(frag));
> >> -                       if (!dma_addr) {
> >> -                               ionic_tx_desc_unmap_bufs(q, desc_info)=
;
> >> -                               return -EIO;
> >> +                       if (act =3D=3D XDP_TX) {
> >> +                               dma_addr =3D page_pool_get_dma_addr(sk=
b_frag_page(frag));
> >> +                               dma_addr +=3D skb_frag_off(frag);
> >> +                               dma_sync_single_for_device(q->dev, dma=
_addr,
> >> +                                                          skb_frag_si=
ze(frag),
> >> +                                                          DMA_TO_DEVI=
CE);
> >> +                       } else {
> >> +                               dma_addr =3D ionic_tx_map_frag(q, frag=
, 0,
> >> +                                                            skb_frag_=
size(frag));
> >> +                               if (dma_mapping_error(q->dev, dma_addr=
)) {
> >> +                                       ionic_tx_desc_unmap_bufs(q, de=
sc_info);
> >> +                                       return -EIO;
> >> +                               }
> >>                          }
> >>                          bi->dma_addr =3D dma_addr;
> >>                          bi->len =3D skb_frag_size(frag);
> >> @@ -493,6 +451,7 @@ static bool ionic_run_xdp(struct ionic_rx_stats *s=
tats,
> >>          struct netdev_queue *nq;
> >>          struct xdp_frame *xdpf;
> >>          int remain_len;
> >> +       int nbufs =3D 1;
> >>          int frag_len;
> >>          int err =3D 0;
> >>
> >> @@ -526,13 +485,13 @@ static bool ionic_run_xdp(struct ionic_rx_stats =
*stats,
> >>                  do {
> >>                          if (unlikely(sinfo->nr_frags >=3D MAX_SKB_FRA=
GS)) {
> >>                                  err =3D -ENOSPC;
> >> -                               goto out_xdp_abort;
> >> +                               break;
> >>                          }
> >>
> >>                          frag =3D &sinfo->frags[sinfo->nr_frags];
> >>                          sinfo->nr_frags++;
> >>                          bi++;
> >> -                       frag_len =3D min_t(u16, remain_len, ionic_rx_b=
uf_size(bi));
> >> +                       frag_len =3D min_t(u16, remain_len, bi->len);
> >>                          dma_sync_single_range_for_cpu(rxq->dev, ionic=
_rx_buf_pa(bi),
> >>                                                        0, frag_len, DM=
A_FROM_DEVICE);
> >>                          skb_frag_fill_page_desc(frag, bi->page, 0, fr=
ag_len);
> >> @@ -542,6 +501,7 @@ static bool ionic_run_xdp(struct ionic_rx_stats *s=
tats,
> >>                          if (page_is_pfmemalloc(bi->page))
> >>                                  xdp_buff_set_frag_pfmemalloc(&xdp_buf=
);
> >>                  } while (remain_len > 0);
> >> +               nbufs +=3D sinfo->nr_frags;
> >>          }
> >>
> >>          xdp_action =3D bpf_prog_run_xdp(xdp_prog, &xdp_buf);
> >> @@ -552,14 +512,15 @@ static bool ionic_run_xdp(struct ionic_rx_stats =
*stats,
> >>                  return false;  /* false =3D we didn't consume the pac=
ket */
> >>
> >>          case XDP_DROP:
> >> -               ionic_rx_page_free(rxq, buf_info);
> >>                  stats->xdp_drop++;
> >>                  break;
> >>
> >>          case XDP_TX:
> >>                  xdpf =3D xdp_convert_buff_to_frame(&xdp_buf);
> >> -               if (!xdpf)
> >> -                       goto out_xdp_abort;
> >> +               if (!xdpf) {
> >> +                       err =3D -ENOSPC;
> >> +                       break;
> >> +               }
> >>
> >>                  txq =3D rxq->partner;
> >>                  nq =3D netdev_get_tx_queue(netdev, txq->index);
> >> @@ -571,12 +532,10 @@ static bool ionic_run_xdp(struct ionic_rx_stats =
*stats,
> >>                                            ionic_q_space_avail(txq),
> >>                                            1, 1)) {
> >>                          __netif_tx_unlock(nq);
> >> -                       goto out_xdp_abort;
> >> +                       err =3D -EIO;
> >> +                       break;
> >>                  }
> >>
> >> -               dma_unmap_page(rxq->dev, buf_info->dma_addr,
> >> -                              IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
> >> -
> >>                  err =3D ionic_xdp_post_frame(txq, xdpf, XDP_TX,
> >>                                             buf_info->page,
> >>                                             buf_info->page_offset,
> >> @@ -584,40 +543,35 @@ static bool ionic_run_xdp(struct ionic_rx_stats =
*stats,
> >>                  __netif_tx_unlock(nq);
> >>                  if (unlikely(err)) {
> >>                          netdev_dbg(netdev, "tx ionic_xdp_post_frame e=
rr %d\n", err);
> >> -                       goto out_xdp_abort;
> >> +                       break;
> >>                  }
> >> -               buf_info->page =3D NULL;
> >> +               ionic_xdp_rx_put_bufs(rxq, buf_info, nbufs);
> >>                  stats->xdp_tx++;
> >>
> >> -               /* the Tx completion will free the buffers */
> >>                  break;
> >>
> >>          case XDP_REDIRECT:
> >> -               /* unmap the pages before handing them to a different =
device */
> >> -               dma_unmap_page(rxq->dev, buf_info->dma_addr,
> >> -                              IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
> >> -
> >>                  err =3D xdp_do_redirect(netdev, &xdp_buf, xdp_prog);
> >>                  if (unlikely(err)) {
> >>                          netdev_dbg(netdev, "xdp_do_redirect err %d\n"=
, err);
> >> -                       goto out_xdp_abort;
> >> +                       break;
> >>                  }
> >> -               buf_info->page =3D NULL;
> >> +
> >>                  rxq->xdp_flush =3D true;
> >> +               ionic_xdp_rx_put_bufs(rxq, buf_info, nbufs);
> >>                  stats->xdp_redirect++;
> >>                  break;
> >>
> >>          case XDP_ABORTED:
> >>          default:
> >> -               goto out_xdp_abort;
> >> +               err =3D -EIO;
> >> +               break;
> >>          }
> >>
> >> -       return true;
> >> -
> >> -out_xdp_abort:
> >> -       trace_xdp_exception(netdev, xdp_prog, xdp_action);
> >> -       ionic_rx_page_free(rxq, buf_info);
> >> -       stats->xdp_aborted++;
> >> +       if (err) {
> >> +               trace_xdp_exception(netdev, xdp_prog, xdp_action);
> >> +               stats->xdp_aborted++;
> >> +       }
> >>
> >>          return true;
> >>   }
> >> @@ -639,6 +593,15 @@ static void ionic_rx_clean(struct ionic_queue *q,
> >>          stats =3D q_to_rx_stats(q);
> >>
> >>          if (comp->status) {
> >> +               struct ionic_rxq_desc *desc =3D &q->rxq[q->head_idx];
> >> +
> >> +               /* Most likely status=3D=3D2 and the pkt received was =
bigger
> >> +                * than the buffer available: comp->len will show the
> >> +                * pkt size received that didn't fit the advertised de=
sc.len
> >> +                */
> >> +               dev_dbg(q->dev, "q%d drop comp->status %d comp->len %d=
 desc.len %d\n",
> >> +                       q->index, comp->status, comp->len, desc->len);
> >> +
> >>                  stats->dropped++;
> >>                  return;
> >>          }
> >> @@ -658,7 +621,8 @@ static void ionic_rx_clean(struct ionic_queue *q,
> >>          use_copybreak =3D len <=3D q->lif->rx_copybreak;
> >>          if (use_copybreak)
> >>                  skb =3D ionic_rx_copybreak(netdev, q, desc_info,
> >> -                                        headroom, len, synced);
> >> +                                        headroom, len,
> >> +                                        comp->num_sg_elems, synced);
> >>          else
> >>                  skb =3D ionic_rx_build_skb(q, desc_info, headroom, le=
n,
> >>                                           comp->num_sg_elems, synced);
> >> @@ -798,32 +762,38 @@ void ionic_rx_fill(struct ionic_queue *q)
> >>
> >>          for (i =3D n_fill; i; i--) {
> >>                  unsigned int headroom;
> >> -               unsigned int buf_len;
> >>
> >>                  nfrags =3D 0;
> >>                  remain_len =3D len;
> >>                  desc =3D &q->rxq[q->head_idx];
> >>                  desc_info =3D &q->rx_info[q->head_idx];
> >>                  buf_info =3D &desc_info->bufs[0];
> >> -
> >> -               if (!buf_info->page) { /* alloc a new buffer? */
> >> -                       if (unlikely(ionic_rx_page_alloc(q, buf_info))=
) {
> >> -                               desc->addr =3D 0;
> >> -                               desc->len =3D 0;
> >> -                               return;
> >> -                       }
> >> -               }
> >> +               ionic_rx_put_buf(q, buf_info);
> >>
> >>                  /* fill main descriptor - buf[0]
> >>                   * XDP uses space in the first buffer, so account for
> >>                   * head room, tail room, and ip header in the first f=
rag size.
> >>                   */
> >>                  headroom =3D q->xdp_rxq_info ? XDP_PACKET_HEADROOM : =
0;
> >> -               if (q->xdp_rxq_info)
> >> -                       buf_len =3D IONIC_XDP_MAX_LINEAR_MTU + VLAN_ET=
H_HLEN;
> >> -               else
> >> -                       buf_len =3D ionic_rx_buf_size(buf_info);
> >> -               frag_len =3D min_t(u16, len, buf_len);
> >> +               if (q->xdp_rxq_info) {
> >> +                       /* Always alloc the full size buffer, but only=
 need
> >> +                        * the actual frag_len in the descriptor
> >> +                        */
> >> +                       buf_info->len =3D IONIC_XDP_MAX_LINEAR_MTU + V=
LAN_ETH_HLEN;
> >> +                       frag_len =3D min_t(u16, len, buf_info->len);
> >> +               } else {
> >> +                       /* Start with max buffer size, then use
> >> +                        * the frag size for the actual size to alloc
> >> +                        */
> >> +                       frag_len =3D min_t(u16, len, IONIC_PAGE_SIZE);
> >> +                       buf_info->len =3D frag_len;
> >> +               }
> >> +
> >> +               buf_info->page =3D page_pool_alloc(q->page_pool,
> >> +                                                &buf_info->page_offse=
t,
> >> +                                                &buf_info->len, GFP_A=
TOMIC);
> >> +               if (unlikely(!buf_info->page))
> >> +                       return;
> >>
> >>                  desc->addr =3D cpu_to_le64(ionic_rx_buf_pa(buf_info) =
+ headroom);
> >>                  desc->len =3D cpu_to_le16(frag_len);
> >> @@ -833,20 +803,31 @@ void ionic_rx_fill(struct ionic_queue *q)
> >>
> >>                  /* fill sg descriptors - buf[1..n] */
> >>                  sg_elem =3D q->rxq_sgl[q->head_idx].elems;
> >> -               for (j =3D 0; remain_len > 0 && j < q->max_sg_elems; j=
++, sg_elem++) {
> >> -                       if (!buf_info->page) { /* alloc a new sg buffe=
r? */
> >> -                               if (unlikely(ionic_rx_page_alloc(q, bu=
f_info))) {
> >> -                                       sg_elem->addr =3D 0;
> >> -                                       sg_elem->len =3D 0;
> >> +               for (j =3D 0; remain_len > 0 && j < q->max_sg_elems; j=
++) {
> >> +                       frag_len =3D min_t(u16, remain_len, IONIC_PAGE=
_SIZE);
> >> +
> >> +                       /* Recycle any "wrong" sized buffers */
> >> +                       if (unlikely(buf_info->page && buf_info->len !=
=3D frag_len))
> >> +                               ionic_rx_put_buf(q, buf_info);
> >> +
> >> +                       /* Get new buffer if needed */
> >> +                       if (!buf_info->page) {
> >> +                               buf_info->len =3D frag_len;
> >> +                               buf_info->page =3D page_pool_alloc(q->=
page_pool,
> >> +                                                                &buf_=
info->page_offset,
> >> +                                                                &buf_=
info->len, GFP_ATOMIC);
> >> +                               if (unlikely(!buf_info->page)) {
> >> +                                       buf_info->len =3D 0;
> >>                                          return;
> >>                                  }
> >>                          }
> >>
> >>                          sg_elem->addr =3D cpu_to_le64(ionic_rx_buf_pa=
(buf_info));
> >> -                       frag_len =3D min_t(u16, remain_len, ionic_rx_b=
uf_size(buf_info));
> >>                          sg_elem->len =3D cpu_to_le16(frag_len);
> >> +
> >>                          remain_len -=3D frag_len;
> >>                          buf_info++;
> >> +                       sg_elem++;
> >>                          nfrags++;
> >>                  }
> >>
> >> @@ -873,17 +854,12 @@ void ionic_rx_fill(struct ionic_queue *q)
> >>   void ionic_rx_empty(struct ionic_queue *q)
> >>   {
> >>          struct ionic_rx_desc_info *desc_info;
> >> -       struct ionic_buf_info *buf_info;
> >>          unsigned int i, j;
> >>
> >>          for (i =3D 0; i < q->num_descs; i++) {
> >>                  desc_info =3D &q->rx_info[i];
> >> -               for (j =3D 0; j < ARRAY_SIZE(desc_info->bufs); j++) {
> >> -                       buf_info =3D &desc_info->bufs[j];
> >> -                       if (buf_info->page)
> >> -                               ionic_rx_page_free(q, buf_info);
> >> -               }
> >> -
> >> +               for (j =3D 0; j < ARRAY_SIZE(desc_info->bufs); j++)
> >> +                       ionic_rx_put_buf(q, &desc_info->bufs[j]);
> >>                  desc_info->nbufs =3D 0;
> >>          }
> >>
> >> --
> >> 2.17.1
> >>
> >>
> >
> > I tested this patch with my test environment.
>
> Well, that was quicker than I expected... :-)

:-)

>
>
> >
> > 1. XDP_TX doesn't work.
> > XDP_TX doesn't work both non-jumbo and jumbo frame.
> > I can see the "hw_tx_dropped" stats counter is increased.
>
> Interesting - works for me in both cases.  I wonder what is different.
> Does your test XDP program swap/edit the SRC and DST mac addresses?

Yes, my XDP program changes SRC and DST mac address.

>
>
> >
> > 2. kernel panic while module unload.
> > While packets are forwarding, kernel panic occurs when ionic module is =
unloaded.
>
> [...]
>
> >
> > 3. Failed to set channel configuration.
> > "ethtool -L eth0 combined 1" command fails if xdp is set and prints
> > the following messages.
> > [ 26.268801] ionic 0000:0a:00.0 enp10s0np0: Changing queue count from 4=
 to 1
> > [ 26.375416] ionic 0000:0a:00.0: Queue 1 xdp_rxq_info_reg_mem_model
> > failed, err -22
> > [ 26.383658] ionic 0000:0a:00.0: failed to register RX queue 1 info
> > for XDP, err -22
> > [ 26.391973] ionic 0000:0a:00.0 enp10s0np0: Failed to start queues: -22
> >
> > Then it prints the following messages when module is unloaded.
> > [ 174.317791] WARNING: CPU: 0 PID: 1310 at net/core/page_pool.c:1030
> > page_pool_destroy+0x174/0x190
>
> [...]
>
> Thanks, I'll take a look at these later this week.
>
> Any comments on what you tried that DID work?

I don't have any comment about it so far :)
I may comment after reading this code.

Thanks a lot!
Taehee Yoo

>
> sln
>
> >
> > Thanks a lot!
> > Taehee Yoo

