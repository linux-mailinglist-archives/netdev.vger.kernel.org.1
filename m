Return-Path: <netdev+bounces-131742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D29ED98F666
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 20:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F411283376
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEC91ABECA;
	Thu,  3 Oct 2024 18:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FJuT5/KS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640521AB536
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 18:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981001; cv=none; b=cOR71PO7DAs6cYQUa14m9GUHTsZDmaRDAu2AFRc9oJ51IQdaMk7Xy8bTqVjw/AiNXl5SYFdQOoEgRnYKIQ2aWYTWO2stn6SPKdjpQoicElQHjqptJGdFCNhsuE+he9HGDalNdk7PJ3m1cxKqoLXLSRLgtZqRz/zYXY8/tjzzSz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981001; c=relaxed/simple;
	bh=3L24L6+ZuXcZ8hcFqrLkkbX5aYYARMNLYtr1FWQdpKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dC0q4DdZNejHCrYN0W6fzaa5XWrMypeYKbxWPytZhx7rGvYeM15qXbXd8bLhiXiDhIOzMuCnBpK0cY/bInLSnDitRzl23q+D7DYzoMiTpOUBeGcPDPQPelgTJ6WEkvA3otktEwXcxJNstBd927My1w5I5TcqQQspBxoUEEKxDaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FJuT5/KS; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4581cec6079so45001cf.0
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 11:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727980998; x=1728585798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0pw9afjfB3doXM9fIwqfJP+VD6uybUCDNEFx839aVE=;
        b=FJuT5/KS/LHBFujpduUOgAf2bThKPxQcbCrtJv6aCkSC/aT0OQrxmN72TrtTQbZAkJ
         7zMf3P62h6pl+uwXBJc5eU3GLY6AijeolU8GymbXcg92GWqO0RrKqdeAsqhg4YWIvui+
         iOin6rpObHa9avYA5yAy543x43NwS26fNoY476cxDcvRsfcWZuqiEhN3QSK4G0R0Yp4+
         Euf4KPcLPdjywy2EkXQWHj1M4NVvsjKupKiIOdkJg3c/LpR0VusDFNPLKrM0IoGtGKAU
         Elifde34N82CbUKV7Uy82HbCnl3KkHJdyDH0NeeVJHFa6gkkxrjbpg6fte8Tud/7KGEl
         Um5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727980998; x=1728585798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0pw9afjfB3doXM9fIwqfJP+VD6uybUCDNEFx839aVE=;
        b=V4FQLiwuCk26Cy7yj/mwW0bz+dhH+8v0pu5xXPmtDLZNcA+hE6z1bpJ0fIVqpC03cX
         4eye5rTtECW6m3d2APeWq9C7Cy5YDTnlWiFiQgLVcFM99DetWavaGZjLlwjTLbaLmvEs
         Xd7oTm8ZASXKI1pe8+u2ZOqDDH+M+sV0ROb5ppYBGfb7wON3n+G67s56iX0gjklJ3RS/
         5I3QWJyY25pbVBq6lQZBre3E+44MlVTBUxVD0AEY/UMOEbV6d6P9FNsApN3e9hk5SVeH
         OAoGoClkE1fjUpTBK4rQqWcT5FVO705lMN+ba6pUZn/a2bGiZVBP/Zbua7Q5czo3D/fe
         6Wjg==
X-Forwarded-Encrypted: i=1; AJvYcCXf5w32KHbMe9br1+OKvzZIKjPOxJCOxjdg9y37BZ2keqncAJwcUF+Dj2Qa74qZ2RlZi/cM/pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPXVu0ntBfbMu7SC1I4/ePz3H3CXp2AX7aQzKXtCYwGIESM0Ct
	3j+4meUw6x/FD2tNbd6uyEer3N0cvmGTmdofU16FNYRuHpnGCmbJBRgBIbJcDoAsjLkwlzqqFXv
	2DPebNdqufylgrL1IltsKWCktr4A9pfmxTfMP
X-Google-Smtp-Source: AGHT+IET4RNNpUy7BTlmy2mFZqTHT/2ogqahdje2fjnkLVMoB969mYqQy/EY//zv4hFew+ynFGsyBnoAL3JyfrTPUYo=
X-Received: by 2002:ac8:6390:0:b0:456:7740:c874 with SMTP id
 d75a77b69052e-45d9bbc0d7fmr114321cf.1.1727980997817; Thu, 03 Oct 2024
 11:43:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003160620.1521626-1-ap420073@gmail.com> <20241003160620.1521626-8-ap420073@gmail.com>
In-Reply-To: <20241003160620.1521626-8-ap420073@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 3 Oct 2024 11:43:02 -0700
Message-ID: <CAHS8izO-7pPk7xyY4JdyaY4hZpd7zerbjhGanRvaTk+OOsvY0A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 7/7] bnxt_en: add support for device memory tcp
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	donald.hunter@gmail.com, corbet@lwn.net, michael.chan@broadcom.com, 
	kory.maincent@bootlin.com, andrew@lunn.ch, maxime.chevallier@bootlin.com, 
	danieller@nvidia.com, hengqi@linux.alibaba.com, ecree.xilinx@gmail.com, 
	przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com, 
	paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com, 
	aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com, 
	bcreeley@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 9:07=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wrot=
e:
>
> Currently, bnxt_en driver satisfies the requirements of Device memory
> TCP, which is tcp-data-split.
> So, it implements Device memory TCP for bnxt_en driver.
>
> From now on, the aggregation ring handles netmem_ref instead of page
> regardless of the on/off of netmem.
> So, for the aggregation ring, memory will be handled with the netmem
> page_pool API instead of generic page_pool API.
>
> If Devmem is enabled, netmem_ref is used as-is and if Devmem is not
> enabled, netmem_ref will be converted to page and that is used.
>
> Driver recognizes whether the devmem is set or unset based on the
> mp_params.mp_priv is not NULL.
> Only if devmem is set, it passes PP_FLAG_ALLOW_UNREADABLE_NETMEM.
>
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>
> v3:
>  - Patch added
>
>  drivers/net/ethernet/broadcom/Kconfig     |  1 +
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 98 +++++++++++++++--------
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h |  2 +-
>  3 files changed, 66 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet=
/broadcom/Kconfig
> index 75ca3ddda1f5..f37ff12d4746 100644
> --- a/drivers/net/ethernet/broadcom/Kconfig
> +++ b/drivers/net/ethernet/broadcom/Kconfig
> @@ -211,6 +211,7 @@ config BNXT
>         select FW_LOADER
>         select LIBCRC32C
>         select NET_DEVLINK
> +       select NET_DEVMEM
>         select PAGE_POOL
>         select DIMLIB
>         select AUXILIARY_BUS
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 872b15842b11..64e07d247f97 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -55,6 +55,7 @@
>  #include <net/page_pool/helpers.h>
>  #include <linux/align.h>
>  #include <net/netdev_queues.h>
> +#include <net/netdev_rx_queue.h>
>
>  #include "bnxt_hsi.h"
>  #include "bnxt.h"
> @@ -863,6 +864,22 @@ static void bnxt_tx_int(struct bnxt *bp, struct bnxt=
_napi *bnapi, int budget)
>                 bnapi->events &=3D ~BNXT_TX_CMP_EVENT;
>  }
>
> +static netmem_ref __bnxt_alloc_rx_netmem(struct bnxt *bp, dma_addr_t *ma=
pping,
> +                                        struct bnxt_rx_ring_info *rxr,
> +                                        unsigned int *offset,
> +                                        gfp_t gfp)
> +{
> +       netmem_ref netmem;
> +
> +       netmem =3D page_pool_alloc_netmem(rxr->page_pool, GFP_ATOMIC);
> +       if (!netmem)
> +               return 0;
> +       *offset =3D 0;
> +
> +       *mapping =3D page_pool_get_dma_addr_netmem(netmem) + *offset;
> +       return netmem;
> +}
> +
>  static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *ma=
pping,
>                                          struct bnxt_rx_ring_info *rxr,
>                                          unsigned int *offset,
> @@ -972,21 +989,21 @@ static inline u16 bnxt_find_next_agg_idx(struct bnx=
t_rx_ring_info *rxr, u16 idx)
>         return next;
>  }
>
> -static inline int bnxt_alloc_rx_page(struct bnxt *bp,
> -                                    struct bnxt_rx_ring_info *rxr,
> -                                    u16 prod, gfp_t gfp)
> +static inline int bnxt_alloc_rx_netmem(struct bnxt *bp,
> +                                      struct bnxt_rx_ring_info *rxr,
> +                                      u16 prod, gfp_t gfp)
>  {
>         struct rx_bd *rxbd =3D
>                 &rxr->rx_agg_desc_ring[RX_AGG_RING(bp, prod)][RX_IDX(prod=
)];
>         struct bnxt_sw_rx_agg_bd *rx_agg_buf;
> -       struct page *page;
> +       netmem_ref netmem;
>         dma_addr_t mapping;
>         u16 sw_prod =3D rxr->rx_sw_agg_prod;
>         unsigned int offset =3D 0;
>
> -       page =3D __bnxt_alloc_rx_page(bp, &mapping, rxr, &offset, gfp);
> +       netmem =3D __bnxt_alloc_rx_netmem(bp, &mapping, rxr, &offset, gfp=
);

Does __bnxt_alloc_rx_page become dead code after this change? Or is it
still used for something?

>
> -       if (!page)
> +       if (!netmem)
>                 return -ENOMEM;
>
>         if (unlikely(test_bit(sw_prod, rxr->rx_agg_bmap)))
> @@ -996,7 +1013,7 @@ static inline int bnxt_alloc_rx_page(struct bnxt *bp=
,
>         rx_agg_buf =3D &rxr->rx_agg_ring[sw_prod];
>         rxr->rx_sw_agg_prod =3D RING_RX_AGG(bp, NEXT_RX_AGG(sw_prod));
>
> -       rx_agg_buf->page =3D page;
> +       rx_agg_buf->netmem =3D netmem;
>         rx_agg_buf->offset =3D offset;
>         rx_agg_buf->mapping =3D mapping;
>         rxbd->rx_bd_haddr =3D cpu_to_le64(mapping);
> @@ -1044,7 +1061,7 @@ static void bnxt_reuse_rx_agg_bufs(struct bnxt_cp_r=
ing_info *cpr, u16 idx,
>                 struct rx_agg_cmp *agg;
>                 struct bnxt_sw_rx_agg_bd *cons_rx_buf, *prod_rx_buf;
>                 struct rx_bd *prod_bd;
> -               struct page *page;
> +               netmem_ref netmem;
>
>                 if (p5_tpa)
>                         agg =3D bnxt_get_tpa_agg_p5(bp, rxr, idx, start +=
 i);
> @@ -1061,11 +1078,11 @@ static void bnxt_reuse_rx_agg_bufs(struct bnxt_cp=
_ring_info *cpr, u16 idx,
>                 cons_rx_buf =3D &rxr->rx_agg_ring[cons];
>
>                 /* It is possible for sw_prod to be equal to cons, so
> -                * set cons_rx_buf->page to NULL first.
> +                * set cons_rx_buf->netmem to 0 first.
>                  */
> -               page =3D cons_rx_buf->page;
> -               cons_rx_buf->page =3D NULL;
> -               prod_rx_buf->page =3D page;
> +               netmem =3D cons_rx_buf->netmem;
> +               cons_rx_buf->netmem =3D 0;
> +               prod_rx_buf->netmem =3D netmem;
>                 prod_rx_buf->offset =3D cons_rx_buf->offset;
>
>                 prod_rx_buf->mapping =3D cons_rx_buf->mapping;
> @@ -1192,6 +1209,7 @@ static struct sk_buff *bnxt_rx_skb(struct bnxt *bp,
>
>  static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
>                                struct bnxt_cp_ring_info *cpr,
> +                              struct sk_buff *skb,
>                                struct skb_shared_info *shinfo,
>                                u16 idx, u32 agg_bufs, bool tpa,
>                                struct xdp_buff *xdp)
> @@ -1211,7 +1229,7 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
>                 u16 cons, frag_len;
>                 struct rx_agg_cmp *agg;
>                 struct bnxt_sw_rx_agg_bd *cons_rx_buf;
> -               struct page *page;
> +               netmem_ref netmem;
>                 dma_addr_t mapping;
>
>                 if (p5_tpa)
> @@ -1223,9 +1241,15 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
>                             RX_AGG_CMP_LEN) >> RX_AGG_CMP_LEN_SHIFT;
>
>                 cons_rx_buf =3D &rxr->rx_agg_ring[cons];
> -               skb_frag_fill_page_desc(frag, cons_rx_buf->page,
> -                                       cons_rx_buf->offset, frag_len);
> -               shinfo->nr_frags =3D i + 1;
> +               if (skb) {
> +                       skb_add_rx_frag_netmem(skb, i, cons_rx_buf->netme=
m,
> +                                              cons_rx_buf->offset, frag_=
len,
> +                                              BNXT_RX_PAGE_SIZE);
> +               } else {
> +                       skb_frag_fill_page_desc(frag, netmem_to_page(cons=
_rx_buf->netmem),
> +                                               cons_rx_buf->offset, frag=
_len);

Our intention with the whole netmem design is that drivers should
never have to call netmem_to_page(). I.e. the driver should use netmem
unaware of whether it's page or non-page underneath, to minimize
complexity driver needs to handle.

This netmem_to_page() call can be removed by using
skb_frag_fill_netmem_desc() instead of the page variant. But, more
improtantly, why did the code change here? The code before calls
skb_frag_fill_page_desc, but the new code sometimes will
skb_frag_fill_netmem_desc() and sometimes will skb_add_rx_frag_netmem.
I'm not sure why that logic changed.

> +                       shinfo->nr_frags =3D i + 1;
> +               }
>                 __clear_bit(cons, rxr->rx_agg_bmap);
>
>                 /* It is possible for bnxt_alloc_rx_page() to allocate
> @@ -1233,15 +1257,15 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
>                  * need to clear the cons entry now.
>                  */
>                 mapping =3D cons_rx_buf->mapping;
> -               page =3D cons_rx_buf->page;
> -               cons_rx_buf->page =3D NULL;
> +               netmem =3D cons_rx_buf->netmem;
> +               cons_rx_buf->netmem =3D 0;
>
> -               if (xdp && page_is_pfmemalloc(page))
> +               if (xdp && page_is_pfmemalloc(netmem_to_page(netmem)))

Similarly, add netmem_is_pfmemalloc to netmem.h, instead of doing a
netmem_to_page() call here I think.

>                         xdp_buff_set_frag_pfmemalloc(xdp);
>
> -               if (bnxt_alloc_rx_page(bp, rxr, prod, GFP_ATOMIC) !=3D 0)=
 {
> +               if (bnxt_alloc_rx_netmem(bp, rxr, prod, GFP_ATOMIC) !=3D =
0) {
>                         --shinfo->nr_frags;
> -                       cons_rx_buf->page =3D page;
> +                       cons_rx_buf->netmem =3D netmem;
>
>                         /* Update prod since possibly some pages have bee=
n
>                          * allocated already.
> @@ -1269,7 +1293,7 @@ static struct sk_buff *bnxt_rx_agg_pages_skb(struct=
 bnxt *bp,
>         struct skb_shared_info *shinfo =3D skb_shinfo(skb);
>         u32 total_frag_len =3D 0;
>
> -       total_frag_len =3D __bnxt_rx_agg_pages(bp, cpr, shinfo, idx,
> +       total_frag_len =3D __bnxt_rx_agg_pages(bp, cpr, skb, shinfo, idx,
>                                              agg_bufs, tpa, NULL);
>         if (!total_frag_len) {
>                 skb_mark_for_recycle(skb);
> @@ -1277,9 +1301,6 @@ static struct sk_buff *bnxt_rx_agg_pages_skb(struct=
 bnxt *bp,
>                 return NULL;
>         }
>
> -       skb->data_len +=3D total_frag_len;
> -       skb->len +=3D total_frag_len;
> -       skb->truesize +=3D BNXT_RX_PAGE_SIZE * agg_bufs;
>         return skb;
>  }
>
> @@ -1294,7 +1315,7 @@ static u32 bnxt_rx_agg_pages_xdp(struct bnxt *bp,
>         if (!xdp_buff_has_frags(xdp))
>                 shinfo->nr_frags =3D 0;
>
> -       total_frag_len =3D __bnxt_rx_agg_pages(bp, cpr, shinfo,
> +       total_frag_len =3D __bnxt_rx_agg_pages(bp, cpr, NULL, shinfo,
>                                              idx, agg_bufs, tpa, xdp);
>         if (total_frag_len) {
>                 xdp_buff_set_frags_flag(xdp);
> @@ -3342,15 +3363,15 @@ static void bnxt_free_one_rx_agg_ring(struct bnxt=
 *bp, struct bnxt_rx_ring_info
>
>         for (i =3D 0; i < max_idx; i++) {
>                 struct bnxt_sw_rx_agg_bd *rx_agg_buf =3D &rxr->rx_agg_rin=
g[i];
> -               struct page *page =3D rx_agg_buf->page;
> +               netmem_ref netmem =3D rx_agg_buf->netmem;
>
> -               if (!page)
> +               if (!netmem)
>                         continue;
>
> -               rx_agg_buf->page =3D NULL;
> +               rx_agg_buf->netmem =3D 0;
>                 __clear_bit(i, rxr->rx_agg_bmap);
>
> -               page_pool_recycle_direct(rxr->page_pool, page);
> +               page_pool_put_full_netmem(rxr->page_pool, netmem, true);
>         }
>  }
>
> @@ -3608,9 +3629,11 @@ static void bnxt_free_rx_rings(struct bnxt *bp)
>
>  static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
>                                    struct bnxt_rx_ring_info *rxr,
> +                                  int queue_idx,
>                                    int numa_node)
>  {
>         struct page_pool_params pp =3D { 0 };
> +       struct netdev_rx_queue *rxq;
>
>         pp.pool_size =3D bp->rx_agg_ring_size;
>         if (BNXT_RX_PAGE_MODE(bp))
> @@ -3621,8 +3644,15 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp=
,
>         pp.dev =3D &bp->pdev->dev;
>         pp.dma_dir =3D bp->rx_dir;
>         pp.max_len =3D PAGE_SIZE;
> -       pp.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
> +       pp.order =3D 0;
> +
> +       rxq =3D __netif_get_rx_queue(bp->dev, queue_idx);
> +       if (rxq->mp_params.mp_priv)
> +               pp.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_ALLOW_UNREADABLE_N=
ETMEM;

This is not the intended use of PP_FLAG_ALLOW_UNREADABLE_NETMEM.

The driver should set PP_FLAG_ALLOW_UNREADABLE_NETMEM when it's able
to handle unreadable netmem, it should not worry about whether
rxq->mp_params.mp_priv is set or not.

You should set PP_FLAG_ALLOW_UNREADABLE_NETMEM when HDS is enabled.
Let core figure out if mp_params.mp_priv is enabled. All the driver
needs to report is whether it's configured to be able to handle
unreadable netmem (which practically means HDS is enabled).

> +       else
> +               pp.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
>
> +       pp.queue_idx =3D queue_idx;
>         rxr->page_pool =3D page_pool_create(&pp);
>         if (IS_ERR(rxr->page_pool)) {
>                 int err =3D PTR_ERR(rxr->page_pool);
> @@ -3655,7 +3685,7 @@ static int bnxt_alloc_rx_rings(struct bnxt *bp)
>                 cpu_node =3D cpu_to_node(cpu);
>                 netdev_dbg(bp->dev, "Allocating page pool for rx_ring[%d]=
 on numa_node: %d\n",
>                            i, cpu_node);
> -               rc =3D bnxt_alloc_rx_page_pool(bp, rxr, cpu_node);
> +               rc =3D bnxt_alloc_rx_page_pool(bp, rxr, i, cpu_node);
>                 if (rc)
>                         return rc;
>
> @@ -4154,7 +4184,7 @@ static void bnxt_alloc_one_rx_ring_page(struct bnxt=
 *bp,
>
>         prod =3D rxr->rx_agg_prod;
>         for (i =3D 0; i < bp->rx_agg_ring_size; i++) {
> -               if (bnxt_alloc_rx_page(bp, rxr, prod, GFP_KERNEL)) {
> +               if (bnxt_alloc_rx_netmem(bp, rxr, prod, GFP_KERNEL)) {
>                         netdev_warn(bp->dev, "init'ed rx ring %d with %d/=
%d pages only\n",
>                                     ring_nr, i, bp->rx_ring_size);
>                         break;
> @@ -15063,7 +15093,7 @@ static int bnxt_queue_mem_alloc(struct net_device=
 *dev, void *qmem, int idx)
>         clone->rx_sw_agg_prod =3D 0;
>         clone->rx_next_cons =3D 0;
>
> -       rc =3D bnxt_alloc_rx_page_pool(bp, clone, rxr->page_pool->p.nid);
> +       rc =3D bnxt_alloc_rx_page_pool(bp, clone, idx, rxr->page_pool->p.=
nid);
>         if (rc)
>                 return rc;
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.h
> index 48f390519c35..3cf57a3c7664 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -895,7 +895,7 @@ struct bnxt_sw_rx_bd {
>  };
>
>  struct bnxt_sw_rx_agg_bd {
> -       struct page             *page;
> +       netmem_ref              netmem;
>         unsigned int            offset;
>         dma_addr_t              mapping;
>  };
> --
> 2.34.1
>


--=20
Thanks,
Mina

