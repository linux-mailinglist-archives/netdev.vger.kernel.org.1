Return-Path: <netdev+bounces-141044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78FB9B93C9
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 15:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663762815B9
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 14:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A70D1A76BB;
	Fri,  1 Nov 2024 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KLWsPbq8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CC01A256C
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 14:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730472812; cv=none; b=NGEx10kHoRr8OgaEufQEaQNLUZUszPkiRAtDPRujIUt1T7KAt4e+QiDdSHifY88p+FEWU+rqXueElSIA9VEdc6IjltRurKy+EduMAm+S2aSNCLu0Go+izHi9I+4cuX0lpoLyh4VI4Dc9RWBqOWq1kC7+fOqTh3cRgy1XRzIUt+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730472812; c=relaxed/simple;
	bh=8VpiWkj2bXlb3RKQsiBmwYDCNq7xcM1ZmvaOcFwfmZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=liqUr11IESZmUPOpJf3YdjwOqcPVyRimbnyALMYEAaX0cXPRljjalupBdHV9ZAC7fAL3SOqXEoszdIO8UkhV81rr2+z/3oiGafwff0jCs5e9XEHLyc9Zh7q2OvRpiAx/txfr79rG3BK2yVnHKaZ3HAuMpWAp1z/puTbLef35slc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KLWsPbq8; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460b295b9eeso146601cf.1
        for <netdev@vger.kernel.org>; Fri, 01 Nov 2024 07:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730472808; x=1731077608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fp1Cxr7t3sVWpzMTa8FyJkAqrjKUib1SdShmF6hyV/M=;
        b=KLWsPbq88jPyQYP40h6bQkKg8Gb8ohlbGuytr+Uhh9sRNwl2ytcF1z2QEYPxsZ4jVl
         3ZK0al2H1/D9DA9xaMMbLOROLqGL1qdaNVoSSKbkkh3jvUiDnYHryV0tDOeAx9Pkj9Mh
         HTOUfH9EwQO7Y6qfSKNkYacEPwNQFBykgveVBnkJff6bAepptJkvNy9lNzoaOFgHd84p
         65VBEVy4XLkgZ3MLCypAZGsTCr2BjJsaqxsyrRQuxOUvnw1MSlxfZ8rWX8WdzWTBg62O
         YToAhh/U5PC8yeeN03BovRhHB+O+Z2WuxWjivzxc1ZRxfrATlJXRKgWMKhSWbwgGHxpl
         ye9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730472808; x=1731077608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fp1Cxr7t3sVWpzMTa8FyJkAqrjKUib1SdShmF6hyV/M=;
        b=E7XxdhSbSqTwj0868ahSxJCFHVJQruyZ7+m81CLEsubDJ4tiM0blGs+n0SZCF2QQo8
         MnA46yz/9IXVgkWh4P8n2n87b2+XAURH2SCDRtFJY7vtSvKSpb29XJTApa6AB85ajdL2
         XTSg1zhPUSWARQ2I6bQqrn1hGG6h0XLk3BL93QevEgHlQgdSS6cwM/20IDg3he92krAp
         R+YulCL77lu65gPbXkw8dFNg0dL9ZIb2s0vCe2TIjyTPH0Nv8gXRENgUcgcDNB7LHuap
         CY/qh6OEUTsISiBN9WMZ13ASJAaCNVoy4bQp2nu3yvlM8proxuDvty6Mx8eieKjgoh/z
         LCNg==
X-Forwarded-Encrypted: i=1; AJvYcCWqi8VMt4Wkdt4ZIoFqnOh8Rfq5LM6tuqxqLdE1SNs9khtAnqXUv5AVwVkyHBdbukoYZx1LUBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7iFhMif6gssLrKxTrSpBzgCV6p+SI3/7uuywIgAoBq76w/Ccu
	9ehhQd/HrFUnVEqbsrBiNNcX61zhL5PVCJliApy50i8vQINNHiZQ8/cc1XRoq3bd/PR1+yVUIpv
	AlP5RuO7yzXIRv7p/sq3pjovTxxp2SryVb8ci
X-Gm-Gg: ASbGnctQzS6mNBL/BhGfi6FKUn/70MVyRDkGeEg4YfuAmwfick+vFWkGboVIXKwcgey
	+Sbrd067KSilbYqeCJorMR4GjL2Pu10I=
X-Google-Smtp-Source: AGHT+IG0Y4fOdL/Sv5/YktkaJAG08tBdGPKN7g+Y/QxGO59pUkbLcP78ksWBcrPn7M7hfDDYvQgbE+6XCg3O4myUzcM=
X-Received: by 2002:ac8:53c2:0:b0:462:ad94:3555 with SMTP id
 d75a77b69052e-462ad94369dmr5206001cf.25.1730472807667; Fri, 01 Nov 2024
 07:53:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022162359.2713094-1-ap420073@gmail.com> <20241022162359.2713094-9-ap420073@gmail.com>
In-Reply-To: <20241022162359.2713094-9-ap420073@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 1 Nov 2024 07:53:15 -0700
Message-ID: <CAHS8izN-PXYC0GspMFPqeACqDTTRK_B8guuXc6+KAXRFaSPG6Q@mail.gmail.com>
Subject: Re: [PATCH net-next v4 8/8] bnxt_en: add support for device memory tcp
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, donald.hunter@gmail.com, corbet@lwn.net, 
	michael.chan@broadcom.com, andrew+netdev@lunn.ch, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
	asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, kory.maincent@bootlin.com, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org, 
	jdamato@fastly.com, aleksander.lobakin@intel.com, kaiyuanz@google.com, 
	willemb@google.com, daniel.zahka@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 9:25=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wro=
te:
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

Looks like in the latest version, you pass
PP_FLAG_ALLOW_UNREADABLE_NETMEM unconditionally, so this line is
obsolete.

However, I think you should only pass PP_FLAG_ALLOW_UNREADABLE_NETMEM
if hds_thresh=3D=3D0 and tcp-data-split=3D=3D1, because otherwise the drive=
r
is not configured well enough to handle unreadable netmem, right? I
know that we added checks in the devmem binding to detect hds_thresh
and tcp-data-split, but we should keep another layer of protection in
the driver. The driver should not set PP_FLAG_ALLOW_UNREADABLE_NETMEM
unless it's configured to be able to handle unreadable netmem.

>
> Tested-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>
> v4:
>  - Do not select NET_DEVMEM in Kconfig.
>  - Pass PP_FLAG_ALLOW_UNREADABLE_NETMEM flag unconditionally.
>  - Add __bnxt_rx_agg_pages_xdp().
>  - Use gfp flag in __bnxt_alloc_rx_netmem().
>  - Do not add *offset in the __bnxt_alloc_rx_netmem().
>  - Do not pass queue_idx to bnxt_alloc_rx_page_pool().
>  - Add Test tag from Stanislav.
>  - Add page_pool_recycle_direct_netmem() helper.
>
> v3:
>  - Patch added.
>
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 182 ++++++++++++++++------
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h |   2 +-
>  include/net/page_pool/helpers.h           |   6 +
>  3 files changed, 142 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 7d9da483b867..7924b1da0413 100644
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
> +       netmem =3D page_pool_alloc_netmem(rxr->page_pool, gfp);
> +       if (!netmem)
> +               return 0;
> +       *offset =3D 0;
> +
> +       *mapping =3D page_pool_get_dma_addr_netmem(netmem);
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
> -       dma_addr_t mapping;
>         u16 sw_prod =3D rxr->rx_sw_agg_prod;
>         unsigned int offset =3D 0;
> +       dma_addr_t mapping;
> +       netmem_ref netmem;
>
> -       page =3D __bnxt_alloc_rx_page(bp, &mapping, rxr, &offset, gfp);
> +       netmem =3D __bnxt_alloc_rx_netmem(bp, &mapping, rxr, &offset, gfp=
);
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
> @@ -1190,29 +1207,104 @@ static struct sk_buff *bnxt_rx_skb(struct bnxt *=
bp,
>         return skb;
>  }
>
> -static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
> -                              struct bnxt_cp_ring_info *cpr,
> -                              struct skb_shared_info *shinfo,
> -                              u16 idx, u32 agg_bufs, bool tpa,
> -                              struct xdp_buff *xdp)
> +static bool __bnxt_rx_agg_pages_skb(struct bnxt *bp,
> +                                   struct bnxt_cp_ring_info *cpr,
> +                                   struct sk_buff *skb,
> +                                   u16 idx, u32 agg_bufs, bool tpa)
>  {

To be honest I could not immediately understand why
__bnxt_rx_agg_pages needed to be split into __bnxt_rx_agg_pages_skb
and __bnxt_rx_agg_pages_xdp.

Fundamentally speaking we wanted the netmem transition to be as smooth
and low-churn as possible for drivers. The only big changes in this
patch are the split between skb and xdp. That points to a problem in
the design of netmem maybe.

For xdp, core makes sure that if xdp is enabled on the device, then
the netmem is always pages (never unreadable). So I think netmem
should be able to handle xdp as well as skb. Can you give more details
on why the split?

>         struct bnxt_napi *bnapi =3D cpr->bnapi;
>         struct pci_dev *pdev =3D bp->pdev;
> -       struct bnxt_rx_ring_info *rxr =3D bnapi->rx_ring;
> -       u16 prod =3D rxr->rx_agg_prod;
> +       struct bnxt_rx_ring_info *rxr;
>         u32 i, total_frag_len =3D 0;
>         bool p5_tpa =3D false;
> +       u16 prod;
> +
> +       rxr =3D bnapi->rx_ring;
> +       prod =3D rxr->rx_agg_prod;
>
>         if ((bp->flags & BNXT_FLAG_CHIP_P5_PLUS) && tpa)
>                 p5_tpa =3D true;
>
>         for (i =3D 0; i < agg_bufs; i++) {
> -               skb_frag_t *frag =3D &shinfo->frags[i];
> -               u16 cons, frag_len;
> +               struct bnxt_sw_rx_agg_bd *cons_rx_buf;
>                 struct rx_agg_cmp *agg;
> +               u16 cons, frag_len;
> +               dma_addr_t mapping;
> +               netmem_ref netmem;
> +
> +               if (p5_tpa)
> +                       agg =3D bnxt_get_tpa_agg_p5(bp, rxr, idx, i);
> +               else
> +                       agg =3D bnxt_get_agg(bp, cpr, idx, i);
> +               cons =3D agg->rx_agg_cmp_opaque;
> +               frag_len =3D (le32_to_cpu(agg->rx_agg_cmp_len_flags_type)=
 &
> +                           RX_AGG_CMP_LEN) >> RX_AGG_CMP_LEN_SHIFT;
> +
> +               cons_rx_buf =3D &rxr->rx_agg_ring[cons];
> +               skb_add_rx_frag_netmem(skb, i, cons_rx_buf->netmem,
> +                                      cons_rx_buf->offset, frag_len,
> +                                      BNXT_RX_PAGE_SIZE);
> +               __clear_bit(cons, rxr->rx_agg_bmap);
> +
> +               /* It is possible for bnxt_alloc_rx_netmem() to allocate
> +                * a sw_prod index that equals the cons index, so we
> +                * need to clear the cons entry now.
> +                */
> +               mapping =3D cons_rx_buf->mapping;
> +               netmem =3D cons_rx_buf->netmem;
> +               cons_rx_buf->netmem =3D 0;
> +
> +               if (bnxt_alloc_rx_netmem(bp, rxr, prod, GFP_ATOMIC) !=3D =
0) {
> +                       skb->len -=3D frag_len;
> +                       skb->data_len -=3D frag_len;
> +                       skb->truesize -=3D BNXT_RX_PAGE_SIZE;
> +                       --skb_shinfo(skb)->nr_frags;
> +                       cons_rx_buf->netmem =3D netmem;
> +
> +                       /* Update prod since possibly some pages have bee=
n
> +                        * allocated already.
> +                        */
> +                       rxr->rx_agg_prod =3D prod;
> +                       bnxt_reuse_rx_agg_bufs(cpr, idx, i, agg_bufs - i,=
 tpa);
> +                       return 0;
> +               }
> +
> +               dma_sync_single_for_cpu(&pdev->dev, mapping, BNXT_RX_PAGE=
_SIZE,
> +                                       bp->rx_dir);
> +

You should probably use page_pool_dma_sync_for_cpu. I'm merging a
change to make that function skip dma-syncing for net_iov:

https://lore.kernel.org/netdev/20241029204541.1301203-5-almasrymina@google.=
com/

Which is necessary following Jason Gunthorpe's guidance.

> +               total_frag_len +=3D frag_len;
> +               prod =3D NEXT_RX_AGG(prod);
> +       }
> +       rxr->rx_agg_prod =3D prod;
> +       return total_frag_len;
> +}
> +
> +static u32 __bnxt_rx_agg_pages_xdp(struct bnxt *bp,
> +                                  struct bnxt_cp_ring_info *cpr,
> +                                  struct skb_shared_info *shinfo,
> +                                  u16 idx, u32 agg_bufs, bool tpa,
> +                                  struct xdp_buff *xdp)
> +{
> +       struct bnxt_napi *bnapi =3D cpr->bnapi;
> +       struct pci_dev *pdev =3D bp->pdev;
> +       struct bnxt_rx_ring_info *rxr;
> +       u32 i, total_frag_len =3D 0;
> +       bool p5_tpa =3D false;
> +       u16 prod;
> +
> +       rxr =3D bnapi->rx_ring;
> +       prod =3D rxr->rx_agg_prod;
> +
> +       if ((bp->flags & BNXT_FLAG_CHIP_P5_PLUS) && tpa)
> +               p5_tpa =3D true;
> +
> +       for (i =3D 0; i < agg_bufs; i++) {
>                 struct bnxt_sw_rx_agg_bd *cons_rx_buf;
> -               struct page *page;
> +               skb_frag_t *frag =3D &shinfo->frags[i];
> +               struct rx_agg_cmp *agg;
> +               u16 cons, frag_len;
>                 dma_addr_t mapping;
> +               netmem_ref netmem;
>
>                 if (p5_tpa)
>                         agg =3D bnxt_get_tpa_agg_p5(bp, rxr, idx, i);
> @@ -1223,9 +1315,10 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
>                             RX_AGG_CMP_LEN) >> RX_AGG_CMP_LEN_SHIFT;
>
>                 cons_rx_buf =3D &rxr->rx_agg_ring[cons];
> -               skb_frag_fill_page_desc(frag, cons_rx_buf->page,
> -                                       cons_rx_buf->offset, frag_len);
> +               skb_frag_fill_netmem_desc(frag, cons_rx_buf->netmem,
> +                                         cons_rx_buf->offset, frag_len);
>                 shinfo->nr_frags =3D i + 1;
> +
>                 __clear_bit(cons, rxr->rx_agg_bmap);
>
>                 /* It is possible for bnxt_alloc_rx_page() to allocate
> @@ -1233,15 +1326,15 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
>                  * need to clear the cons entry now.
>                  */
>                 mapping =3D cons_rx_buf->mapping;
> -               page =3D cons_rx_buf->page;
> -               cons_rx_buf->page =3D NULL;
> +               netmem =3D cons_rx_buf->netmem;
> +               cons_rx_buf->netmem =3D 0;
>
> -               if (xdp && page_is_pfmemalloc(page))
> +               if (netmem_is_pfmemalloc(netmem))
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
> @@ -1266,20 +1359,12 @@ static struct sk_buff *bnxt_rx_agg_pages_skb(stru=
ct bnxt *bp,
>                                              struct sk_buff *skb, u16 idx=
,
>                                              u32 agg_bufs, bool tpa)
>  {
> -       struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> -       u32 total_frag_len =3D 0;
> -
> -       total_frag_len =3D __bnxt_rx_agg_pages(bp, cpr, shinfo, idx,
> -                                            agg_bufs, tpa, NULL);
> -       if (!total_frag_len) {
> +       if (!__bnxt_rx_agg_pages_skb(bp, cpr, skb, idx, agg_bufs, tpa)) {
>                 skb_mark_for_recycle(skb);
>                 dev_kfree_skb(skb);
>                 return NULL;
>         }
>
> -       skb->data_len +=3D total_frag_len;
> -       skb->len +=3D total_frag_len;
> -       skb->truesize +=3D BNXT_RX_PAGE_SIZE * agg_bufs;
>         return skb;
>  }
>
> @@ -1294,8 +1379,8 @@ static u32 bnxt_rx_agg_pages_xdp(struct bnxt *bp,
>         if (!xdp_buff_has_frags(xdp))
>                 shinfo->nr_frags =3D 0;
>
> -       total_frag_len =3D __bnxt_rx_agg_pages(bp, cpr, shinfo,
> -                                            idx, agg_bufs, tpa, xdp);
> +       total_frag_len =3D __bnxt_rx_agg_pages_xdp(bp, cpr, shinfo,
> +                                                idx, agg_bufs, tpa, xdp)=
;
>         if (total_frag_len) {
>                 xdp_buff_set_frags_flag(xdp);
>                 shinfo->nr_frags =3D agg_bufs;
> @@ -3341,15 +3426,15 @@ static void bnxt_free_one_rx_agg_ring(struct bnxt=
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
> +               page_pool_recycle_direct_netmem(rxr->page_pool, netmem);
>         }
>  }
>
> @@ -3620,7 +3705,10 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp=
,
>         pp.dev =3D &bp->pdev->dev;
>         pp.dma_dir =3D bp->rx_dir;
>         pp.max_len =3D PAGE_SIZE;
> -       pp.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
> +       pp.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV |
> +                  PP_FLAG_ALLOW_UNREADABLE_NETMEM;

PP_FLAG_ALLOW_UNREADABLE_NETMEM should only be set when the driver can
handle unreadable netmem. I.e. when hds_thresh=3D=3D0 and
tcp-data-split=3D=3D1.


--=20
Thanks,
Mina

