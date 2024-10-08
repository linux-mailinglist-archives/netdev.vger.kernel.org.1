Return-Path: <netdev+bounces-132958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D92993DB6
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 05:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED46A1C23BE3
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 03:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5801A4F8A0;
	Tue,  8 Oct 2024 03:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahwbmD9u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873E81DA5F;
	Tue,  8 Oct 2024 03:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728359682; cv=none; b=UONVu0lIcMQsbWTvfZx1kzCtIoM+UHHCXpSSa8M/03JvveoHR61wepe1pOON08iiREXqKLe1Y9L2UG5EScoU6vNb1bNRxI9gERm2iQFnLi0PT2HzqSjZ7pOHwc90/IkB+T0ZQpoYfLD3T3sGd680k7+TS/6yMf6GiAIPiTFGesE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728359682; c=relaxed/simple;
	bh=+y27MQOeRoemQMFs06/1HhYcJ9um66V2IShSBG94Rwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCroirMwEAelQmb3Vmd8RvZfXAMwMYzKfjtlvizLMA6NvCJEXcGfbMrYadSSehmbvaL6ajljlBkk3rk9OS18NTakyKjY0dAEWZQqEWD9HPA0jSVRkVdL0smk/Dt4O4x4DYp0U2TBobEq2WMT8iJqeKb031+aOemVF2y0Xj1FKhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahwbmD9u; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c88370ad7bso6056093a12.3;
        Mon, 07 Oct 2024 20:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728359679; x=1728964479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvMrUh9G3zcSjyAbW+8kOKwRWjYaPA7+LkspQbSrfKg=;
        b=ahwbmD9uyCHsPxHAAwB+zjQvN0LOgI/Rrbx8vtpvd7AquGC26o78Mp6//bKO7zuHtX
         gUBIEgFiY8EwfVTdG++lF2X5mO0oo/t6bnWJRVaTEPaDwGTeZlWVtKZOuQkeYiDeoF0z
         stev5EpEkeJuoLqy/Ew1RJKMufD1lQNshLhi6xZn5ujwRPcVR+l6E7yRDk+QAbCJqW7T
         JfdSofitDmWg77E+YeuwfNUYuOwZOk3PPuX6tl/spwHCDavuHCxy2vsAnlaah6QeC7EK
         0jtM0/TmrEMMMnQLtDYXqodF6RFDrdVGvUVX/BKW1DSqVJJnbqJgqUM0dEc/KSVfhfJ5
         66YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728359679; x=1728964479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JvMrUh9G3zcSjyAbW+8kOKwRWjYaPA7+LkspQbSrfKg=;
        b=HW0l+g0tFs2Ts4XLKXUUr8JxeAmLJHT7Ev47WoC4Fw4+kfKm5PCWHETGF+BuEX1/lC
         nV+0Wf2NOd6W4bE+D8dhL41tgxd8Dp+DTmKSzhcpL9z84ktFhhotfQ4te2KF/5Pw2EIi
         qB53pjpzrGxepb8M/8EJOacSZZQzanFFMl/T7IVse8RvZ0aL/RFQmw4c5HAqH7TxE4xp
         Y/pGFU7n7GX+9DbHbYkbkm6lDAg32HVpggpv1aPpCUBMotz02V77CGxGD8sc2lRk0NCs
         UYHtCdWLugaWoxSRdBPNghQZ4AJHxY6i7nRuuxNjMv10rihdFhzjUEo/a2zVhuahNXgY
         BzvA==
X-Forwarded-Encrypted: i=1; AJvYcCU4vPGmr3MtzU9fKj4RZZS0/JCCXJRIgPSk0jGDalc3Kci+ZglT2BDlb9XiZkCtNpSskM+3Js63@vger.kernel.org, AJvYcCUa+zuqt+prxRGtE6ffpDPrdPA1+Zu8OgnWwbhKCUQdf57kgaiu3oZQc9z0fElBiNuHNhFomUrdKMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcpXTKOKx0Gk2gtX8P0mKCjfqwPvmUbXqBtr6oxcG8pBkSoHGU
	TYa5hjKSomUrvTxxmPqZamVYJuVQAOhxZtsxa93fDND8g52atR9kG4GpVbFEiAoqGK799rsCuF9
	ByZq5kFErRzp8Or96K9ua8nLYjyo=
X-Google-Smtp-Source: AGHT+IHHKnOTzZZFatLYfSiR295S01qvvUk2s2mwqSZS1+VbBzS3iS2//ooCiVMGm11MhkM0WjnyX33p6YIbfTzHmKw=
X-Received: by 2002:a05:6402:3549:b0:5c8:a01e:a06d with SMTP id
 4fb4d7f45d1cf-5c8d2eb2cf6mr11645136a12.30.1728359678580; Mon, 07 Oct 2024
 20:54:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003160620.1521626-1-ap420073@gmail.com> <20241003160620.1521626-8-ap420073@gmail.com>
 <35c505ee-b44d-4817-ab68-c4f1f768b242@davidwei.uk>
In-Reply-To: <35c505ee-b44d-4817-ab68-c4f1f768b242@davidwei.uk>
From: Taehee Yoo <ap420073@gmail.com>
Date: Tue, 8 Oct 2024 12:54:26 +0900
Message-ID: <CAMArcTUwyJdBHaSJ-N06qDOBdds1BErNg64ghrOshLQdh3_4Xw@mail.gmail.com>
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

On Tue, Oct 8, 2024 at 11:45=E2=80=AFAM David Wei <dw@davidwei.uk> wrote:
>

Hi David,
Thanks a lot for your review!

> On 2024-10-03 09:06, Taehee Yoo wrote:
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.c
> > index 872b15842b11..64e07d247f97 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -55,6 +55,7 @@
> >  #include <net/page_pool/helpers.h>
> >  #include <linux/align.h>
> >  #include <net/netdev_queues.h>
> > +#include <net/netdev_rx_queue.h>
> >
> >  #include "bnxt_hsi.h"
> >  #include "bnxt.h"
> > @@ -863,6 +864,22 @@ static void bnxt_tx_int(struct bnxt *bp, struct bn=
xt_napi *bnapi, int budget)
> >               bnapi->events &=3D ~BNXT_TX_CMP_EVENT;
> >  }
> >
> > +static netmem_ref __bnxt_alloc_rx_netmem(struct bnxt *bp, dma_addr_t *=
mapping,
> > +                                      struct bnxt_rx_ring_info *rxr,
> > +                                      unsigned int *offset,
> > +                                      gfp_t gfp)
>
> gfp is unused

I will remove unnecessary gfp parameter in v4.

>
> > +{
> > +     netmem_ref netmem;
> > +
> > +     netmem =3D page_pool_alloc_netmem(rxr->page_pool, GFP_ATOMIC);
> > +     if (!netmem)
> > +             return 0;
> > +     *offset =3D 0;
> > +
> > +     *mapping =3D page_pool_get_dma_addr_netmem(netmem) + *offset;
>
> offset is always 0

Okay, I will remove this too in v4.

>
> > +     return netmem;
> > +}
> > +
> >  static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *=
mapping,
> >                                        struct bnxt_rx_ring_info *rxr,
> >                                        unsigned int *offset,
>
> [...]
>
> > @@ -1192,6 +1209,7 @@ static struct sk_buff *bnxt_rx_skb(struct bnxt *b=
p,
> >
> >  static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
> >                              struct bnxt_cp_ring_info *cpr,
> > +                            struct sk_buff *skb,
> >                              struct skb_shared_info *shinfo,
> >                              u16 idx, u32 agg_bufs, bool tpa,
> >                              struct xdp_buff *xdp)
> > @@ -1211,7 +1229,7 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
> >               u16 cons, frag_len;
> >               struct rx_agg_cmp *agg;
> >               struct bnxt_sw_rx_agg_bd *cons_rx_buf;
> > -             struct page *page;
> > +             netmem_ref netmem;
> >               dma_addr_t mapping;
> >
> >               if (p5_tpa)
> > @@ -1223,9 +1241,15 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
> >                           RX_AGG_CMP_LEN) >> RX_AGG_CMP_LEN_SHIFT;
> >
> >               cons_rx_buf =3D &rxr->rx_agg_ring[cons];
> > -             skb_frag_fill_page_desc(frag, cons_rx_buf->page,
> > -                                     cons_rx_buf->offset, frag_len);
> > -             shinfo->nr_frags =3D i + 1;
> > +             if (skb) {
> > +                     skb_add_rx_frag_netmem(skb, i, cons_rx_buf->netme=
m,
> > +                                            cons_rx_buf->offset, frag_=
len,
> > +                                            BNXT_RX_PAGE_SIZE);
> > +             } else {
> > +                     skb_frag_fill_page_desc(frag, netmem_to_page(cons=
_rx_buf->netmem),
> > +                                             cons_rx_buf->offset, frag=
_len);
> > +                     shinfo->nr_frags =3D i + 1;
> > +             }
>
> I feel like this function needs a refactor at some point to split out
> the skb and xdp paths.

Okay, I will add __bnxt_rx_agg_netmem() in v4 patch.

>
> >               __clear_bit(cons, rxr->rx_agg_bmap);
> >
> >               /* It is possible for bnxt_alloc_rx_page() to allocate
>
> [...]
>
> > @@ -3608,9 +3629,11 @@ static void bnxt_free_rx_rings(struct bnxt *bp)
> >
> >  static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
> >                                  struct bnxt_rx_ring_info *rxr,
> > +                                int queue_idx,
>
> To save a parameter, the index is available already in rxr->bnapi->index

Okay, I also remove the queue_idx parameter in v4.

>
> >                                  int numa_node)
> >  {
> >       struct page_pool_params pp =3D { 0 };
> > +     struct netdev_rx_queue *rxq;
> >
> >       pp.pool_size =3D bp->rx_agg_ring_size;
> >       if (BNXT_RX_PAGE_MODE(bp))
> > @@ -3621,8 +3644,15 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *=
bp,
> >       pp.dev =3D &bp->pdev->dev;
> >       pp.dma_dir =3D bp->rx_dir;
> >       pp.max_len =3D PAGE_SIZE;
> > -     pp.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
> > +     pp.order =3D 0;
> > +
> > +     rxq =3D __netif_get_rx_queue(bp->dev, queue_idx);
> > +     if (rxq->mp_params.mp_priv)
> > +             pp.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_ALLOW_UNREADABLE_N=
ETMEM;
> > +     else
> > +             pp.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
> >
> > +     pp.queue_idx =3D queue_idx;
> >       rxr->page_pool =3D page_pool_create(&pp);
> >       if (IS_ERR(rxr->page_pool)) {
> >               int err =3D PTR_ERR(rxr->page_pool);
> > @@ -3655,7 +3685,7 @@ static int bnxt_alloc_rx_rings(struct bnxt *bp)
> >               cpu_node =3D cpu_to_node(cpu);
> >               netdev_dbg(bp->dev, "Allocating page pool for rx_ring[%d]=
 on numa_node: %d\n",
> >                          i, cpu_node);
> > -             rc =3D bnxt_alloc_rx_page_pool(bp, rxr, cpu_node);
> > +             rc =3D bnxt_alloc_rx_page_pool(bp, rxr, i, cpu_node);
> >               if (rc)
> >                       return rc;
> >

Thanks a lot for catching things,
I will send v4 if there is no problem after some tests.

Thanks!
Taehee Yoo

