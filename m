Return-Path: <netdev+bounces-143663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1429C3896
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 07:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB9B01F210E8
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 06:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13C283A14;
	Mon, 11 Nov 2024 06:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+kTrjOc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B774517F7
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 06:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731307697; cv=none; b=pfd5r4ANQTH5aKmrQdF1RK++1b6JBbWDSm6wZvTIy90kijHSdhplz6MQHoMduQtHeaysHFlJawyr42EFAyRDtdCVVMS0+K0WU5VdZAWVwxc8tfCQIcboXFhuLRSELGVHeRockuOut6TdZCKrPsJFK1R5veJDV2ELjKjVYtRyDRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731307697; c=relaxed/simple;
	bh=mD9FQUC6yrhFTBSyGyH39I+oBtYENIyH9rf4qItBVvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWsvRMnvu3fzu/3GjHgGcNpdGxiNK4o4vadQdIX1XZHPGffVBJro8nN3boLmdCz8TgZ2M6520DwKDYQUI9FmRK0zBGzdxQLKuMTIUkPIGdtPnFFMdtQWvVKp+HTYhe7DvtU/qeeEidRJvJP9YKqCwRXtXPqujXytfYkhsgeHbFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+kTrjOc; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5ceca7df7f0so5417390a12.1
        for <netdev@vger.kernel.org>; Sun, 10 Nov 2024 22:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731307694; x=1731912494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5RoQG2Ztw7UBUWa5Fo+rZ6l51YflyAJMtfFp5IQJII=;
        b=i+kTrjOcfdKIK3kxxK3h8lA5Yi9Dp7kKl2mmQHFIJ7AT70XvALRzYCAJb6d45JHhal
         a6m03omRq91paBtRTfIN6hswzJt53OBxMtMr0X4Zm+53CYBcfVvghqowD3QVDavyFOqn
         TQ2H3lA6S/SKiWzQHe5yWPSC0tZbexTDKouxvjkW+r/5f6AIZo1dAyV9LHMEIbNmMd9a
         ppZ+IyQGIrNsqhAjpYKFZH+Lnu9jhxYvfSA2FiPv5XE1zTSS91fPYy+r4VDtwjMf7bb3
         WLWRDahr85/unzLDlCLJKr+9QMpAppKG9cG0hWYa2KuDIwgrjWd57WT1PTDmzVJ3q3E+
         q80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731307694; x=1731912494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5RoQG2Ztw7UBUWa5Fo+rZ6l51YflyAJMtfFp5IQJII=;
        b=JaSxnPfqXU7VeYnLQMQ1G06jM6viYaDMRUW1KHusa442H2bkUoh1LvGnX34ReS/vD7
         dRxEoYhDqsH5R/Y1MaHQsDw6hxIiamrRXmaSVhG+s1vsHz+ele+Ziret9/s7k790DitZ
         Pbh+QpS/e2rSwspvpQPDKCDRAE7yN8QADFOGzZikeADY2YHzFWB3AxXcOez7s3CZnxSC
         B2qsELzHrwDnIWWuUdEohnTrKqAdnfv2s+6ENiSRO8+JnAXoItHih/s5N9ztCQUCty7E
         AxIWkaloCjH8NEYv3YW5nK3Ilj4hfC3iSEQRjw97fi9dFPoaJfWRztb1a/m8PwLRw95q
         maOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM1ejoVUj+6khzt5y3RhiePRcNDDeUltQyj5egmo8xQOykziDu5/1lYBh7aiaFh1JDOM3vXmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH/NB5yWFnPpJhggaMdEBIC20JNfOIsLRoQGA5UOwiaz8oYp/U
	hkJm3YhhhMNpHwr1iXKepXMpalBiwdjmykahpxka9W28j4xP+OxxfRtqNvkdPwaLu/+HfLLNOKg
	4w15iDBAJkaiXR+FBlhkYIrwV2no=
X-Google-Smtp-Source: AGHT+IFlTurkPtGNh5wOT6pz7iOsDBfqFlD01IGbTl8G5mtBakJME5YJpFkNE1HeuEU0D9BuWY+sTKtCoqSPm43zvks=
X-Received: by 2002:a05:6402:234a:b0:5ce:fc32:3536 with SMTP id
 4fb4d7f45d1cf-5cf0a272570mr9931306a12.0.1731307693659; Sun, 10 Nov 2024
 22:48:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109035119.3391864-1-kuba@kernel.org>
In-Reply-To: <20241109035119.3391864-1-kuba@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Mon, 11 Nov 2024 15:48:02 +0900
Message-ID: <CAMArcTW4RHWvNa-82O9D-NoqWALVuki0TpHeAn_NeT99C6+=7w@mail.gmail.com>
Subject: Re: [PATCH net-next] eth: bnxt: use page pool for head frags
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, michael.chan@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 12:51=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Testing small size RPCs (300B-400B) on a large AMD system suggests
> that page pool recycling is very useful even for just the head frags.
> With this patch (and copy break disabled) I see a 30% performance
> improvement (82Gbps -> 106Gbps).
>
> Convert bnxt from normal page frags to page pool frags for head buffers.
>
> On systems with small page size we can use the same pool as for TPA
> pages. On systems with large pages the frag allocation logic of the
> page pool is already used to split a large page into TPA chunks.
> TPA chunks are much larger than heads (8k or 64k, AFAICT vs 1kB)
> and we always allocate the same sized chunks. Mixing allocation
> of TPA and head pages would lead to sub-optimal memory use.
> Plus Taehee's work on zero-copy / devmem will need to differentiate
> between TPA and non-TPA page pool, anyway. Conditionally allocate
> a new page pool for heads.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Taehee, I hope you don't mind me posting this before your v5 is ready.
> Very much looking forward to the APIs you're adding, we need to be able
> to increase the HDS threshold for bnxt when not used for zero-copy...

Hi Jakub,
Thank you so much for considering my work!
I'm waiting for Mina's patch because the v5 patch needs to change
dma_sync_single_for_cpu to page_pool_dma_sync_for_cpu.
So there is no problem!
However, I may send v5 patch before Mina's patch and then send a
separate patch for applying page_pool_dma_sync_for_cpu for bnxt_en
after Mina's patch.

Thanks a lot!
Taehee Yoo

>
> CC: michael.chan@broadcom.com
> CC: ap420073@gmail.com
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 98 ++++++++++++-----------
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 +
>  2 files changed, 51 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 98f589e1cbe4..bbb6abd27fed 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -864,6 +864,11 @@ static void bnxt_tx_int(struct bnxt *bp, struct bnxt=
_napi *bnapi, int budget)
>                 bnapi->events &=3D ~BNXT_TX_CMP_EVENT;
>  }
>
> +static bool bnxt_separate_head_pool(void)
> +{
> +       return PAGE_SIZE > BNXT_RX_PAGE_SIZE;
> +}
> +
>  static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *ma=
pping,
>                                          struct bnxt_rx_ring_info *rxr,
>                                          unsigned int *offset,
> @@ -886,27 +891,19 @@ static struct page *__bnxt_alloc_rx_page(struct bnx=
t *bp, dma_addr_t *mapping,
>  }
>
>  static inline u8 *__bnxt_alloc_rx_frag(struct bnxt *bp, dma_addr_t *mapp=
ing,
> +                                      struct bnxt_rx_ring_info *rxr,
>                                        gfp_t gfp)
>  {
> -       u8 *data;
> -       struct pci_dev *pdev =3D bp->pdev;
> +       unsigned int offset;
> +       struct page *page;
>
> -       if (gfp =3D=3D GFP_ATOMIC)
> -               data =3D napi_alloc_frag(bp->rx_buf_size);
> -       else
> -               data =3D netdev_alloc_frag(bp->rx_buf_size);
> -       if (!data)
> +       page =3D page_pool_alloc_frag(rxr->head_pool, &offset,
> +                                   bp->rx_buf_size, gfp);
> +       if (!page)
>                 return NULL;
>
> -       *mapping =3D dma_map_single_attrs(&pdev->dev, data + bp->rx_dma_o=
ffset,
> -                                       bp->rx_buf_use_size, bp->rx_dir,
> -                                       DMA_ATTR_WEAK_ORDERING);
> -
> -       if (dma_mapping_error(&pdev->dev, *mapping)) {
> -               skb_free_frag(data);
> -               data =3D NULL;
> -       }
> -       return data;
> +       *mapping =3D page_pool_get_dma_addr(page) + bp->rx_dma_offset + o=
ffset;
> +       return page_address(page) + offset;
>  }
>
>  int bnxt_alloc_rx_data(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
> @@ -928,7 +925,7 @@ int bnxt_alloc_rx_data(struct bnxt *bp, struct bnxt_r=
x_ring_info *rxr,
>                 rx_buf->data =3D page;
>                 rx_buf->data_ptr =3D page_address(page) + offset + bp->rx=
_offset;
>         } else {
> -               u8 *data =3D __bnxt_alloc_rx_frag(bp, &mapping, gfp);
> +               u8 *data =3D __bnxt_alloc_rx_frag(bp, &mapping, rxr, gfp)=
;
>
>                 if (!data)
>                         return -ENOMEM;
> @@ -1179,13 +1176,14 @@ static struct sk_buff *bnxt_rx_skb(struct bnxt *b=
p,
>         }
>
>         skb =3D napi_build_skb(data, bp->rx_buf_size);
> -       dma_unmap_single_attrs(&bp->pdev->dev, dma_addr, bp->rx_buf_use_s=
ize,
> -                              bp->rx_dir, DMA_ATTR_WEAK_ORDERING);
> +       dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, bp->rx_buf_use_=
size,
> +                               bp->rx_dir);
>         if (!skb) {
> -               skb_free_frag(data);
> +               page_pool_free_va(rxr->head_pool, data, true);
>                 return NULL;
>         }
>
> +       skb_mark_for_recycle(skb);
>         skb_reserve(skb, bp->rx_offset);
>         skb_put(skb, offset_and_len & 0xffff);
>         return skb;
> @@ -1840,7 +1838,8 @@ static inline struct sk_buff *bnxt_tpa_end(struct b=
nxt *bp,
>                 u8 *new_data;
>                 dma_addr_t new_mapping;
>
> -               new_data =3D __bnxt_alloc_rx_frag(bp, &new_mapping, GFP_A=
TOMIC);
> +               new_data =3D __bnxt_alloc_rx_frag(bp, &new_mapping, rxr,
> +                                               GFP_ATOMIC);
>                 if (!new_data) {
>                         bnxt_abort_tpa(cpr, idx, agg_bufs);
>                         cpr->sw_stats->rx.rx_oom_discards +=3D 1;
> @@ -1852,16 +1851,16 @@ static inline struct sk_buff *bnxt_tpa_end(struct=
 bnxt *bp,
>                 tpa_info->mapping =3D new_mapping;
>
>                 skb =3D napi_build_skb(data, bp->rx_buf_size);
> -               dma_unmap_single_attrs(&bp->pdev->dev, mapping,
> -                                      bp->rx_buf_use_size, bp->rx_dir,
> -                                      DMA_ATTR_WEAK_ORDERING);
> +               dma_sync_single_for_cpu(&bp->pdev->dev, mapping,
> +                                       bp->rx_buf_use_size, bp->rx_dir);
>
>                 if (!skb) {
> -                       skb_free_frag(data);
> +                       page_pool_free_va(rxr->head_pool, data, true);
>                         bnxt_abort_tpa(cpr, idx, agg_bufs);
>                         cpr->sw_stats->rx.rx_oom_discards +=3D 1;
>                         return NULL;
>                 }
> +               skb_mark_for_recycle(skb);
>                 skb_reserve(skb, bp->rx_offset);
>                 skb_put(skb, len);
>         }
> @@ -3308,28 +3307,22 @@ static void bnxt_free_tx_skbs(struct bnxt *bp)
>
>  static void bnxt_free_one_rx_ring(struct bnxt *bp, struct bnxt_rx_ring_i=
nfo *rxr)
>  {
> -       struct pci_dev *pdev =3D bp->pdev;
>         int i, max_idx;
>
>         max_idx =3D bp->rx_nr_pages * RX_DESC_CNT;
>
>         for (i =3D 0; i < max_idx; i++) {
>                 struct bnxt_sw_rx_bd *rx_buf =3D &rxr->rx_buf_ring[i];
> -               dma_addr_t mapping =3D rx_buf->mapping;
>                 void *data =3D rx_buf->data;
>
>                 if (!data)
>                         continue;
>
>                 rx_buf->data =3D NULL;
> -               if (BNXT_RX_PAGE_MODE(bp)) {
> +               if (BNXT_RX_PAGE_MODE(bp))
>                         page_pool_recycle_direct(rxr->page_pool, data);
> -               } else {
> -                       dma_unmap_single_attrs(&pdev->dev, mapping,
> -                                              bp->rx_buf_use_size, bp->r=
x_dir,
> -                                              DMA_ATTR_WEAK_ORDERING);
> -                       skb_free_frag(data);
> -               }
> +               else
> +                       page_pool_free_va(rxr->head_pool, data, true);
>         }
>  }
>
> @@ -3356,7 +3349,6 @@ static void bnxt_free_one_rx_agg_ring(struct bnxt *=
bp, struct bnxt_rx_ring_info
>  static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp, int ring_nr)
>  {
>         struct bnxt_rx_ring_info *rxr =3D &bp->rx_ring[ring_nr];
> -       struct pci_dev *pdev =3D bp->pdev;
>         struct bnxt_tpa_idx_map *map;
>         int i;
>
> @@ -3370,13 +3362,8 @@ static void bnxt_free_one_rx_ring_skbs(struct bnxt=
 *bp, int ring_nr)
>                 if (!data)
>                         continue;
>
> -               dma_unmap_single_attrs(&pdev->dev, tpa_info->mapping,
> -                                      bp->rx_buf_use_size, bp->rx_dir,
> -                                      DMA_ATTR_WEAK_ORDERING);
> -
>                 tpa_info->data =3D NULL;
> -
> -               skb_free_frag(data);
> +               page_pool_free_va(rxr->head_pool, data, false);
>         }
>
>  skip_rx_tpa_free:
> @@ -3592,7 +3579,9 @@ static void bnxt_free_rx_rings(struct bnxt *bp)
>                         xdp_rxq_info_unreg(&rxr->xdp_rxq);
>
>                 page_pool_destroy(rxr->page_pool);
> -               rxr->page_pool =3D NULL;
> +               if (rxr->page_pool !=3D rxr->head_pool)
> +                       page_pool_destroy(rxr->head_pool);
> +               rxr->page_pool =3D rxr->head_pool =3D NULL;
>
>                 kfree(rxr->rx_agg_bmap);
>                 rxr->rx_agg_bmap =3D NULL;
> @@ -3610,6 +3599,7 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
>                                    int numa_node)
>  {
>         struct page_pool_params pp =3D { 0 };
> +       struct page_pool *pool;
>
>         pp.pool_size =3D bp->rx_agg_ring_size;
>         if (BNXT_RX_PAGE_MODE(bp))
> @@ -3622,14 +3612,25 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *b=
p,
>         pp.max_len =3D PAGE_SIZE;
>         pp.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
>
> -       rxr->page_pool =3D page_pool_create(&pp);
> -       if (IS_ERR(rxr->page_pool)) {
> -               int err =3D PTR_ERR(rxr->page_pool);
> +       pool =3D page_pool_create(&pp);
> +       if (IS_ERR(pool))
> +               return PTR_ERR(pool);
> +       rxr->page_pool =3D pool;
>
> -               rxr->page_pool =3D NULL;
> -               return err;
> +       if (bnxt_separate_head_pool()) {
> +               pp.pool_size =3D max(bp->rx_ring_size, 1024);
> +               pool =3D page_pool_create(&pp);
> +               if (IS_ERR(pool))
> +                       goto err_destroy_pp;
>         }
> +       rxr->head_pool =3D pool;
> +
>         return 0;
> +
> +err_destroy_pp:
> +       page_pool_destroy(rxr->page_pool);
> +       rxr->page_pool =3D NULL;
> +       return PTR_ERR(pool);
>  }
>
>  static int bnxt_alloc_rx_rings(struct bnxt *bp)
> @@ -4180,7 +4181,8 @@ static int bnxt_alloc_one_rx_ring(struct bnxt *bp, =
int ring_nr)
>                 u8 *data;
>
>                 for (i =3D 0; i < bp->max_tpa; i++) {
> -                       data =3D __bnxt_alloc_rx_frag(bp, &mapping, GFP_K=
ERNEL);
> +                       data =3D __bnxt_alloc_rx_frag(bp, &mapping, rxr,
> +                                                   GFP_KERNEL);
>                         if (!data)
>                                 return -ENOMEM;
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.h
> index 69231e85140b..649955fa3e37 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -1105,6 +1105,7 @@ struct bnxt_rx_ring_info {
>         struct bnxt_ring_struct rx_agg_ring_struct;
>         struct xdp_rxq_info     xdp_rxq;
>         struct page_pool        *page_pool;
> +       struct page_pool        *head_pool;
>  };
>
>  struct bnxt_rx_sw_stats {
> --
> 2.47.0
>

