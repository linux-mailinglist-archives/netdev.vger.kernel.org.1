Return-Path: <netdev+bounces-132959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA9F993DC0
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 05:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34261F23F43
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 03:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ED5537E9;
	Tue,  8 Oct 2024 03:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoUcgDxr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727E41DFD1;
	Tue,  8 Oct 2024 03:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728359912; cv=none; b=iol04bH6dNf5BPXJ1qFTYVJcKa8kuuodF5oviltK63JVU1HQ4yzEDrBZFv055trzVnbbBcOv+4puWHyKb/vZUpyHwUmFkaJHR0/bpBnCXkT1LVaIgOFo8JpjqaTbgshyS0sRb0T+JzOEle8uhQikmFFBops+6vMycyE1mw+3ZhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728359912; c=relaxed/simple;
	bh=kZ7lyw3NfFLXTNWZSoalJBG4ZPZrSHc4wUlVQXcNfNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNPNKm3qShstvzvLyb0q+BPuR3YVhk2OeNh4mlLxL3BuJOLuju/jhlnnxUDkwTjl/bw2pJqIz+hhoaV6Ug1f5Kl1wdOBxoazJ9SVab6pSe5I3HpmWOtOlvADslp0oU05MpVHn+ZAQdLsHDTqam4fupA4kPh28UZ84WOI6LwqIdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoUcgDxr; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99415adecaso409683166b.0;
        Mon, 07 Oct 2024 20:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728359909; x=1728964709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+RVjAYVj8NYynJbDTcqOuPC4SqfBudPN8CXWeDzlwk=;
        b=KoUcgDxrsVSgcXcGVdfXMX9bBdzIUrGfjWYXxWyoKzqOCpRDwuwyKu4UquXMX7JoCL
         K4jPyqAdPb8P6pcK0gq8GnArJOIl5VoT6t75Qr08XQ3f1H4FmrKt2OwAz1zUD9KHYOXJ
         ow7w44Dnlw438FAm6FzrW/mZL0ppRDpLL71NkTG6IaswwtibAys/Y4STk6QLR/HU7hJo
         kHMcDcValJpQEe0Z12w+R7eRj1NoPuyWkb8WfBMWTSSh13mcJb5hZLjk1wDQ5xpzXE2d
         4YKF3zg1Pfln7PnPefStmViBhqCH0tz+VchTBK/BjFXVFJkHQkpKDUPN4I6K3Bb3bpS5
         yyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728359909; x=1728964709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+RVjAYVj8NYynJbDTcqOuPC4SqfBudPN8CXWeDzlwk=;
        b=J6gjk5o8Eqs+7h1CP30E8zK6EwzpXodsb3BuxT7BCdxSeF1Xrye0dEFSsrh2bCmSpM
         gDG3GrBi9oSESpTpraR+D6VujdL5OxOM3rj3yx7VdbWGTMUFBIs0KASbaNLpuSUckBcp
         C4Ac5nA6jl70bR78IPRa1PJKGWq+eYTpb0s0/1Gzh1PRbcBUd+AoKK1EFn2xk7dPqgeb
         HV2n0DSYbnAERyurD28zVWjMRq9CzxpSJGyvlaOJfgKLc0L6MPoEGIajYr/pStZtZ+jj
         4cvlOQW9IdoHHugIu+CWII8ZyXLVPjlot74qTIbOsaxZz1mF+ksKl/VeO3uLPozX7pq+
         zBYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4oiLpZd1NraGAbUVh32x+OpzTaQaK1vR3wKEl8O3GTEtBoXOtUzTEl30vGNCctv4CKC8QIAuiRJ0=@vger.kernel.org, AJvYcCWMrHlvTwLqpkiho+c0oLZqkd93bR3bA2KTYWD3ozzqIc4ZDW8b0c1s02LqRDFuZ+zM5i60FMzb@vger.kernel.org
X-Gm-Message-State: AOJu0YzCdOwZwIWEi1r0KaFaw+hZl+SnQnvjVV3V2UBa53CWtZmbWsF6
	dCyIwx0AeKsVStJsjYcdpH11xeh/LDPHJWHzYVoT4VxWDNo8Ewj/hPJIeLVHlIUgTJtAbtxUVEb
	8Vil1r+Kh8zMQbMnO1r556RvI8TU=
X-Google-Smtp-Source: AGHT+IFwuz8EpEC4E5y1y+rN0nHEx108oiqEbnLwwdvoPteq76Y/oLxODIDHIlXevfb1mwUgTas+MwA84SjzkHkiyaM=
X-Received: by 2002:a17:907:7f94:b0:a8d:4e69:4030 with SMTP id
 a640c23a62f3a-a99678e1bbcmr176806066b.19.1728359908537; Mon, 07 Oct 2024
 20:58:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003160620.1521626-1-ap420073@gmail.com> <20241003160620.1521626-8-ap420073@gmail.com>
 <35c505ee-b44d-4817-ab68-c4f1f768b242@davidwei.uk> <CAMArcTUwyJdBHaSJ-N06qDOBdds1BErNg64ghrOshLQdh3_4Xw@mail.gmail.com>
In-Reply-To: <CAMArcTUwyJdBHaSJ-N06qDOBdds1BErNg64ghrOshLQdh3_4Xw@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Tue, 8 Oct 2024 12:58:16 +0900
Message-ID: <CAMArcTU9qYRmy83TvU5dLcN-X3Z298XCgh4AoHsNNy=Zi70YRg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 7/7] bnxt_en: add support for device memory tcp
To: David Wei <dw@davidwei.uk>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, almasrymina@google.com, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, donald.hunter@gmail.com, corbet@lwn.net, 
	michael.chan@broadcom.com, kory.maincent@bootlin.com, andrew@lunn.ch, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, paul.greenwalt@intel.com, rrameshbabu@nvidia.com, 
	idosch@nvidia.com, asml.silence@gmail.com, kaiyuanz@google.com, 
	willemb@google.com, aleksander.lobakin@intel.com, sridhar.samudrala@intel.com, 
	bcreeley@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 12:54=E2=80=AFPM Taehee Yoo <ap420073@gmail.com> wro=
te:
>
> On Tue, Oct 8, 2024 at 11:45=E2=80=AFAM David Wei <dw@davidwei.uk> wrote:
> >
>
> Hi David,
> Thanks a lot for your review!
>
> > On 2024-10-03 09:06, Taehee Yoo wrote:
> > > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/=
ethernet/broadcom/bnxt/bnxt.c
> > > index 872b15842b11..64e07d247f97 100644
> > > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > @@ -55,6 +55,7 @@
> > >  #include <net/page_pool/helpers.h>
> > >  #include <linux/align.h>
> > >  #include <net/netdev_queues.h>
> > > +#include <net/netdev_rx_queue.h>
> > >
> > >  #include "bnxt_hsi.h"
> > >  #include "bnxt.h"
> > > @@ -863,6 +864,22 @@ static void bnxt_tx_int(struct bnxt *bp, struct =
bnxt_napi *bnapi, int budget)
> > >               bnapi->events &=3D ~BNXT_TX_CMP_EVENT;
> > >  }
> > >
> > > +static netmem_ref __bnxt_alloc_rx_netmem(struct bnxt *bp, dma_addr_t=
 *mapping,
> > > +                                      struct bnxt_rx_ring_info *rxr,
> > > +                                      unsigned int *offset,
> > > +                                      gfp_t gfp)
> >
> > gfp is unused
>
> I will remove unnecessary gfp parameter in v4.

Oh sorry,
I will use gfp parameter, not remove it.

>
> >
> > > +{
> > > +     netmem_ref netmem;
> > > +
> > > +     netmem =3D page_pool_alloc_netmem(rxr->page_pool, GFP_ATOMIC);
> > > +     if (!netmem)
> > > +             return 0;
> > > +     *offset =3D 0;
> > > +
> > > +     *mapping =3D page_pool_get_dma_addr_netmem(netmem) + *offset;
> >
> > offset is always 0
>
> Okay, I will remove this too in v4.
>
> >
> > > +     return netmem;
> > > +}
> > > +
> > >  static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t=
 *mapping,
> > >                                        struct bnxt_rx_ring_info *rxr,
> > >                                        unsigned int *offset,
> >
> > [...]
> >
> > > @@ -1192,6 +1209,7 @@ static struct sk_buff *bnxt_rx_skb(struct bnxt =
*bp,
> > >
> > >  static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
> > >                              struct bnxt_cp_ring_info *cpr,
> > > +                            struct sk_buff *skb,
> > >                              struct skb_shared_info *shinfo,
> > >                              u16 idx, u32 agg_bufs, bool tpa,
> > >                              struct xdp_buff *xdp)
> > > @@ -1211,7 +1229,7 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
> > >               u16 cons, frag_len;
> > >               struct rx_agg_cmp *agg;
> > >               struct bnxt_sw_rx_agg_bd *cons_rx_buf;
> > > -             struct page *page;
> > > +             netmem_ref netmem;
> > >               dma_addr_t mapping;
> > >
> > >               if (p5_tpa)
> > > @@ -1223,9 +1241,15 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp=
,
> > >                           RX_AGG_CMP_LEN) >> RX_AGG_CMP_LEN_SHIFT;
> > >
> > >               cons_rx_buf =3D &rxr->rx_agg_ring[cons];
> > > -             skb_frag_fill_page_desc(frag, cons_rx_buf->page,
> > > -                                     cons_rx_buf->offset, frag_len);
> > > -             shinfo->nr_frags =3D i + 1;
> > > +             if (skb) {
> > > +                     skb_add_rx_frag_netmem(skb, i, cons_rx_buf->net=
mem,
> > > +                                            cons_rx_buf->offset, fra=
g_len,
> > > +                                            BNXT_RX_PAGE_SIZE);
> > > +             } else {
> > > +                     skb_frag_fill_page_desc(frag, netmem_to_page(co=
ns_rx_buf->netmem),
> > > +                                             cons_rx_buf->offset, fr=
ag_len);
> > > +                     shinfo->nr_frags =3D i + 1;
> > > +             }
> >
> > I feel like this function needs a refactor at some point to split out
> > the skb and xdp paths.
>
> Okay, I will add __bnxt_rx_agg_netmem() in v4 patch.
>
> >
> > >               __clear_bit(cons, rxr->rx_agg_bmap);
> > >
> > >               /* It is possible for bnxt_alloc_rx_page() to allocate
> >
> > [...]
> >
> > > @@ -3608,9 +3629,11 @@ static void bnxt_free_rx_rings(struct bnxt *bp=
)
> > >
> > >  static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
> > >                                  struct bnxt_rx_ring_info *rxr,
> > > +                                int queue_idx,
> >
> > To save a parameter, the index is available already in rxr->bnapi->inde=
x
>
> Okay, I also remove the queue_idx parameter in v4.
>
> >
> > >                                  int numa_node)
> > >  {
> > >       struct page_pool_params pp =3D { 0 };
> > > +     struct netdev_rx_queue *rxq;
> > >
> > >       pp.pool_size =3D bp->rx_agg_ring_size;
> > >       if (BNXT_RX_PAGE_MODE(bp))
> > > @@ -3621,8 +3644,15 @@ static int bnxt_alloc_rx_page_pool(struct bnxt=
 *bp,
> > >       pp.dev =3D &bp->pdev->dev;
> > >       pp.dma_dir =3D bp->rx_dir;
> > >       pp.max_len =3D PAGE_SIZE;
> > > -     pp.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
> > > +     pp.order =3D 0;
> > > +
> > > +     rxq =3D __netif_get_rx_queue(bp->dev, queue_idx);
> > > +     if (rxq->mp_params.mp_priv)
> > > +             pp.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_ALLOW_UNREADABLE=
_NETMEM;
> > > +     else
> > > +             pp.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
> > >
> > > +     pp.queue_idx =3D queue_idx;
> > >       rxr->page_pool =3D page_pool_create(&pp);
> > >       if (IS_ERR(rxr->page_pool)) {
> > >               int err =3D PTR_ERR(rxr->page_pool);
> > > @@ -3655,7 +3685,7 @@ static int bnxt_alloc_rx_rings(struct bnxt *bp)
> > >               cpu_node =3D cpu_to_node(cpu);
> > >               netdev_dbg(bp->dev, "Allocating page pool for rx_ring[%=
d] on numa_node: %d\n",
> > >                          i, cpu_node);
> > > -             rc =3D bnxt_alloc_rx_page_pool(bp, rxr, cpu_node);
> > > +             rc =3D bnxt_alloc_rx_page_pool(bp, rxr, i, cpu_node);
> > >               if (rc)
> > >                       return rc;
> > >
>
> Thanks a lot for catching things,
> I will send v4 if there is no problem after some tests.
>
> Thanks!
> Taehee Yoo

