Return-Path: <netdev+bounces-181121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FE8A83B7C
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C893BE3E9
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E594F1D90AD;
	Thu, 10 Apr 2025 07:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIGxFT0z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807893D81
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 07:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744270554; cv=none; b=pa/hzkeUUgo+EjPqI/wK0Jvdqs4YzjmyKt3mEJdMxie/4DaLRiyT2OVocsitzdWa6Ej9wxzWf0ZB3KcIqFfMoVYuH4iW9/DHIOQ248CaOicWFFdotqqXOXsT9h1GbGeI1IhWIKzyNuwRxVx+wknmz92ewkwbdTNh9+1EE5yGfs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744270554; c=relaxed/simple;
	bh=/jn53OYwGDZCUO5PAfQ+W86I5H52Y3oBxF4bMDOXOr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ElwIIT/7/ksqcpyuEzJ6AHGtjNNLjTaTjLhApsdHuw/k//PJBoR45JwdCBg8r0nV43osJIoOnHYZxUz7GYPLuSjzQUDDJKBJbcQwkOnDc1TfaUjNo0f1MQfx+a4OBfrFoDHMzOLS/Fuq5ESqHZZ1prmARPOnnh0X4auyLqjasWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIGxFT0z; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9eb12so759960a12.1
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 00:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744270551; x=1744875351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hA10jHCsZJsZMBjLNCp5zInf+th69jQcTcF5Vhc1Dg8=;
        b=SIGxFT0z2nV1Rp+nSX8U0d0KsyKm2TNISiA849m9PcnFWHUD/6aW+ch3wAk4kDMQ28
         EUZfc6jL/ewZHuI8F3/dFmPJFqAKj7OKkteHBh5vKJnxQknEag/xXgKD62mJotUQ09yu
         oXO9wk7MGROK5E3UGFZfYITZ+tuK4XwI39ekoDvSP6Iv3pmTklReAktbRE2oiGfgiRJc
         hXhr5LK2EFykdPC+DAul1uDyIioaipXj3AGTZmBA4L9yQYlqaB9S+PqHIJwVFxEzcS8R
         Hk1Uc7eXFJfyy2UnL93xibBcDP2TVRsRK8j7N3qSxhv63lNvBseNFZ/pXgav7hsTYmIr
         U3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744270551; x=1744875351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hA10jHCsZJsZMBjLNCp5zInf+th69jQcTcF5Vhc1Dg8=;
        b=YJ9pyfBmTtissyDfye53Y+YDnhNYZ2GRQBojIVAEmMVt72BdRojtH0x6SnpZ3ChOKM
         BiS1MF6QuACuCDINuwpZwB1gQSgICABMpmiMX7W5QWrW/32gG17OJkHVUM+PCd68H7IQ
         fqFhWZy1/ILMc6iriG81k62GAiQWAOtqTSPd+/B/Y6fJCE8xQoRHhHkWWeQ/lQd1oSEQ
         JwxfxYJES6imOB3xDKc+GQYWNkdpsncXH+UzZyogSte3F4inNrX7Yx89+Memxr5YHSj/
         AuJfxE0ho9E49hBBKtKtx/ZdLmkyFmbRlPyjtFb8cMYaf1A+N7eyVznrbHgHHqBaH4Dm
         WJSg==
X-Forwarded-Encrypted: i=1; AJvYcCWqSWLUo9PTlBLZaZgYju2dWmAYqp1y+7qpN1qeR5WgJL6u7bFsRr/j6BiO9udILKwifK9zPLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsSY0rnIUAeXfb6CbxbxChiRzzlJof8PcRe3ev5LaJzMe1nRkx
	6bHsAUhkyXkWryxfiCmvV20EHXAckEx2da67lczkSr0VQ9zFz3VfVt1w6MKZOKtX1dCQ00PLCW/
	pWCoIG1wZwrQ5+wv1WDduuYZNX/o=
X-Gm-Gg: ASbGncvcmIbQgGEXQfFqtfNwdO8L7hsoiFVXf0uf0L6ZQBES/oH7826MeCmpBexXIzZ
	/XUGBq176x+mheVV//970Lo6nMiB6u5+Q16pbT7oRVrxZV0KUC3ev7hs8NWDihVLgcOuqT2KAIP
	aKkRvclC45Q44aEVCQIz0tHKSn
X-Google-Smtp-Source: AGHT+IEVLF1ubBF2T1mka/oDvVJaK2An24pD56as+N2xcYY1TGts9TpbJUSVLVEZGgGx1VyWRZb/fcm+hriBV0Npg4I=
X-Received: by 2002:a05:6402:274d:b0:5ec:9545:74bd with SMTP id
 4fb4d7f45d1cf-5f32930f2dbmr1499575a12.27.1744270550246; Thu, 10 Apr 2025
 00:35:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408043545.2179381-1-ap420073@gmail.com> <CAHS8izN+x7vQ_Fs-YGGKawjWttuiJ8bLtcXE1-Jp90_+4rcx5g@mail.gmail.com>
In-Reply-To: <CAHS8izN+x7vQ_Fs-YGGKawjWttuiJ8bLtcXE1-Jp90_+4rcx5g@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 10 Apr 2025 16:35:38 +0900
X-Gm-Features: ATxdqUGwDq7r50czWZMu9ec-P7mJuatRf2wc1kDdfTtDatbkiRnIgK0b5PVkyGk
Message-ID: <CAMArcTXqC+OjO_kEhP_+N5y6N9ayyfi3AF-bE2kD98mRAySGcA@mail.gmail.com>
Subject: Re: [PATCH net-next] eth: bnxt: add support rx side device memory TCP
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, netdev@vger.kernel.org, dw@davidwei.uk, 
	kuniyu@amazon.com, sdf@fomichev.me, ahmed.zaki@intel.com, 
	aleksander.lobakin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 1:49=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>

Hi Mina,
Thanks a lot for your review!

> On Mon, Apr 7, 2025 at 9:36=E2=80=AFPM Taehee Yoo <ap420073@gmail.com> wr=
ote:
> >
> > Currently, bnxt_en driver satisfies the requirements of the Device
> > memory TCP, which is HDS.
> > So, it implements rx-side Device memory TCP for bnxt_en driver.
> > It requires only converting the page API to netmem API.
> > `struct page` of agg rings are changed to `netmem_ref netmem` and
> > corresponding functions are changed to a variant of netmem API.
> >
> > It also passes PP_FLAG_ALLOW_UNREADABLE_NETMEM flag to a parameter of
> > page_pool.
> > The netmem will be activated only when a user requests devmem TCP.
> >
> > When netmem is activated, received data is unreadable and netmem is
> > disabled, received data is readable.
> > But drivers don't need to handle both cases because netmem core API wil=
l
> > handle it properly.
> > So, using proper netmem API is enough for drivers.
> >
> > Device memory TCP can be tested with
> > tools/testing/selftests/drivers/net/hw/ncdevmem.
> > This is tested with BCM57504-N425G and firmware version 232.0.155.8/pkg
> > 232.1.132.8.
> >
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > ---
> >
> > RFC -> PATCH v1:
> >  - Drop ring buffer descriptor refactoring patch.
> >  - Do not convert to netmem API for normal ring(non-agg ring).
> >  - Remove changes of napi_{enable | disable}() to
> >    napi_{enable | disable}_locked().
> >  - Relocate a need_head_pool in struct bnxt_rx_ring_info due to
> >    an alignment hole.
> >  - Remove *offset parameter of __bnxt_alloc_rx_netmem().
> >    *offset is always set to 0 in this function. it's unnecessary.
> >  - Get skb_shared_info outside of loop in __bnxt_rx_agg_netmems().
> >  - Drop Tested-by tag due to changes of this patch.
> >
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 201 +++++++++++++---------
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.h |   3 +-
> >  include/linux/netdevice.h                 |   1 +
> >  include/net/page_pool/helpers.h           |   6 +
> >  net/core/dev.c                            |   6 +
> >  5 files changed, 137 insertions(+), 80 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.c
> > index 28ee12186c37..eb36646d2f8b 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -893,9 +893,9 @@ static void bnxt_tx_int(struct bnxt *bp, struct bnx=
t_napi *bnapi, int budget)
> >                 bnapi->events &=3D ~BNXT_TX_CMP_EVENT;
> >  }
> >
> > -static bool bnxt_separate_head_pool(void)
> > +static bool bnxt_separate_head_pool(struct bnxt_rx_ring_info *rxr)
> >  {
> > -       return PAGE_SIZE > BNXT_RX_PAGE_SIZE;
> > +       return rxr->need_head_pool || PAGE_SIZE > BNXT_RX_PAGE_SIZE;
> >  }
> >
> >  static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *=
mapping,
> > @@ -919,6 +919,20 @@ static struct page *__bnxt_alloc_rx_page(struct bn=
xt *bp, dma_addr_t *mapping,
> >         return page;
> >  }
> >
> > +static netmem_ref __bnxt_alloc_rx_netmem(struct bnxt *bp, dma_addr_t *=
mapping,
> > +                                        struct bnxt_rx_ring_info *rxr,
> > +                                        gfp_t gfp)
> > +{
> > +       netmem_ref netmem;
> > +
> > +       netmem =3D page_pool_alloc_netmems(rxr->page_pool, gfp);
> > +       if (!netmem)
> > +               return 0;
> > +
> > +       *mapping =3D page_pool_get_dma_addr_netmem(netmem);
> > +       return netmem;
> > +}
> > +
> >  static inline u8 *__bnxt_alloc_rx_frag(struct bnxt *bp, dma_addr_t *ma=
pping,
> >                                        struct bnxt_rx_ring_info *rxr,
> >                                        gfp_t gfp)
> > @@ -999,21 +1013,20 @@ static inline u16 bnxt_find_next_agg_idx(struct =
bnxt_rx_ring_info *rxr, u16 idx)
> >         return next;
> >  }
> >
> > -static inline int bnxt_alloc_rx_page(struct bnxt *bp,
> > -                                    struct bnxt_rx_ring_info *rxr,
> > -                                    u16 prod, gfp_t gfp)
> > +static inline int bnxt_alloc_rx_netmem(struct bnxt *bp,
> > +                                      struct bnxt_rx_ring_info *rxr,
> > +                                      u16 prod, gfp_t gfp)
> >  {
> >         struct rx_bd *rxbd =3D
> >                 &rxr->rx_agg_desc_ring[RX_AGG_RING(bp, prod)][RX_IDX(pr=
od)];
> >         struct bnxt_sw_rx_agg_bd *rx_agg_buf;
> > -       struct page *page;
> > -       dma_addr_t mapping;
> >         u16 sw_prod =3D rxr->rx_sw_agg_prod;
> >         unsigned int offset =3D 0;
> > +       dma_addr_t mapping;
> > +       netmem_ref netmem;
> >
> > -       page =3D __bnxt_alloc_rx_page(bp, &mapping, rxr, &offset, gfp);
> > -
> > -       if (!page)
> > +       netmem =3D __bnxt_alloc_rx_netmem(bp, &mapping, rxr, gfp);
> > +       if (!netmem)
> >                 return -ENOMEM;
> >
> >         if (unlikely(test_bit(sw_prod, rxr->rx_agg_bmap)))
> > @@ -1023,7 +1036,7 @@ static inline int bnxt_alloc_rx_page(struct bnxt =
*bp,
> >         rx_agg_buf =3D &rxr->rx_agg_ring[sw_prod];
> >         rxr->rx_sw_agg_prod =3D RING_RX_AGG(bp, NEXT_RX_AGG(sw_prod));
> >
> > -       rx_agg_buf->page =3D page;
> > +       rx_agg_buf->netmem =3D netmem;
> >         rx_agg_buf->offset =3D offset;
> >         rx_agg_buf->mapping =3D mapping;
> >         rxbd->rx_bd_haddr =3D cpu_to_le64(mapping);
> > @@ -1067,11 +1080,11 @@ static void bnxt_reuse_rx_agg_bufs(struct bnxt_=
cp_ring_info *cpr, u16 idx,
> >                 p5_tpa =3D true;
> >
> >         for (i =3D 0; i < agg_bufs; i++) {
> > -               u16 cons;
> > -               struct rx_agg_cmp *agg;
> >                 struct bnxt_sw_rx_agg_bd *cons_rx_buf, *prod_rx_buf;
> > +               struct rx_agg_cmp *agg;
> >                 struct rx_bd *prod_bd;
> > -               struct page *page;
> > +               netmem_ref netmem;
> > +               u16 cons;
> >
> >                 if (p5_tpa)
> >                         agg =3D bnxt_get_tpa_agg_p5(bp, rxr, idx, start=
 + i);
> > @@ -1088,11 +1101,11 @@ static void bnxt_reuse_rx_agg_bufs(struct bnxt_=
cp_ring_info *cpr, u16 idx,
> >                 cons_rx_buf =3D &rxr->rx_agg_ring[cons];
> >
> >                 /* It is possible for sw_prod to be equal to cons, so
> > -                * set cons_rx_buf->page to NULL first.
> > +                * set cons_rx_buf->netmem to 0 first.
> >                  */
> > -               page =3D cons_rx_buf->page;
> > -               cons_rx_buf->page =3D NULL;
> > -               prod_rx_buf->page =3D page;
> > +               netmem =3D cons_rx_buf->netmem;
> > +               cons_rx_buf->netmem =3D 0;
> > +               prod_rx_buf->netmem =3D netmem;
> >                 prod_rx_buf->offset =3D cons_rx_buf->offset;
> >
> >                 prod_rx_buf->mapping =3D cons_rx_buf->mapping;
> > @@ -1218,29 +1231,36 @@ static struct sk_buff *bnxt_rx_skb(struct bnxt =
*bp,
> >         return skb;
> >  }
> >
> > -static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
> > -                              struct bnxt_cp_ring_info *cpr,
> > -                              struct skb_shared_info *shinfo,
> > -                              u16 idx, u32 agg_bufs, bool tpa,
> > -                              struct xdp_buff *xdp)
> > +static u32 __bnxt_rx_agg_netmems(struct bnxt *bp,
> > +                                struct bnxt_cp_ring_info *cpr,
> > +                                u16 idx, u32 agg_bufs, bool tpa,
> > +                                struct sk_buff *skb,
> > +                                struct xdp_buff *xdp)
> >  {
> >         struct bnxt_napi *bnapi =3D cpr->bnapi;
> > -       struct pci_dev *pdev =3D bp->pdev;
> > -       struct bnxt_rx_ring_info *rxr =3D bnapi->rx_ring;
> > -       u16 prod =3D rxr->rx_agg_prod;
> > +       struct skb_shared_info *shinfo;
> > +       struct bnxt_rx_ring_info *rxr;
> >         u32 i, total_frag_len =3D 0;
> >         bool p5_tpa =3D false;
> > +       u16 prod;
> > +
> > +       rxr =3D bnapi->rx_ring;
> > +       prod =3D rxr->rx_agg_prod;
> >
> >         if ((bp->flags & BNXT_FLAG_CHIP_P5_PLUS) && tpa)
> >                 p5_tpa =3D true;
> >
> > +       if (skb)
> > +               shinfo =3D skb_shinfo(skb);
> > +       else
> > +               shinfo =3D xdp_get_shared_info_from_buff(xdp);
> > +
> >         for (i =3D 0; i < agg_bufs; i++) {
> > -               skb_frag_t *frag =3D &shinfo->frags[i];
> > -               u16 cons, frag_len;
> > -               struct rx_agg_cmp *agg;
> >                 struct bnxt_sw_rx_agg_bd *cons_rx_buf;
> > -               struct page *page;
> > +               struct rx_agg_cmp *agg;
> > +               u16 cons, frag_len;
> >                 dma_addr_t mapping;
> > +               netmem_ref netmem;
> >
> >                 if (p5_tpa)
> >                         agg =3D bnxt_get_tpa_agg_p5(bp, rxr, idx, i);
> > @@ -1251,27 +1271,42 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
> >                             RX_AGG_CMP_LEN) >> RX_AGG_CMP_LEN_SHIFT;
> >
> >                 cons_rx_buf =3D &rxr->rx_agg_ring[cons];
> > -               skb_frag_fill_page_desc(frag, cons_rx_buf->page,
> > -                                       cons_rx_buf->offset, frag_len);
> > -               shinfo->nr_frags =3D i + 1;
> > +               if (skb) {
> > +                       skb_add_rx_frag_netmem(skb, i, cons_rx_buf->net=
mem,
> > +                                              cons_rx_buf->offset,
> > +                                              frag_len, BNXT_RX_PAGE_S=
IZE);
> > +               } else {
> > +                       skb_frag_t *frag =3D &shinfo->frags[i];
> > +
> > +                       skb_frag_fill_netmem_desc(frag, cons_rx_buf->ne=
tmem,
> > +                                                 cons_rx_buf->offset,
> > +                                                 frag_len);
> > +                       shinfo->nr_frags =3D i + 1;
> > +               }
> >                 __clear_bit(cons, rxr->rx_agg_bmap);
> >
> > -               /* It is possible for bnxt_alloc_rx_page() to allocate
> > +               /* It is possible for bnxt_alloc_rx_netmem() to allocat=
e
> >                  * a sw_prod index that equals the cons index, so we
> >                  * need to clear the cons entry now.
> >                  */
> >                 mapping =3D cons_rx_buf->mapping;
> > -               page =3D cons_rx_buf->page;
> > -               cons_rx_buf->page =3D NULL;
> > +               netmem =3D cons_rx_buf->netmem;
> > +               cons_rx_buf->netmem =3D 0;
> >
> > -               if (xdp && page_is_pfmemalloc(page))
> > +               if (xdp && netmem_is_pfmemalloc(netmem))
> >                         xdp_buff_set_frag_pfmemalloc(xdp);
> >
> > -               if (bnxt_alloc_rx_page(bp, rxr, prod, GFP_ATOMIC) !=3D =
0) {
> > +               if (bnxt_alloc_rx_netmem(bp, rxr, prod, GFP_ATOMIC) !=
=3D 0) {
> > +                       if (skb) {
> > +                               skb->len -=3D frag_len;
> > +                               skb->data_len -=3D frag_len;
> > +                               skb->truesize -=3D BNXT_RX_PAGE_SIZE;
> > +                       }
> > +
> >                         --shinfo->nr_frags;
> > -                       cons_rx_buf->page =3D page;
> > +                       cons_rx_buf->netmem =3D netmem;
> >
> > -                       /* Update prod since possibly some pages have b=
een
> > +                       /* Update prod since possibly some netmems have=
 been
> >                          * allocated already.
> >                          */
> >                         rxr->rx_agg_prod =3D prod;
> > @@ -1279,8 +1314,8 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
> >                         return 0;
> >                 }
> >
> > -               dma_sync_single_for_cpu(&pdev->dev, mapping, BNXT_RX_PA=
GE_SIZE,
> > -                                       bp->rx_dir);
> > +               page_pool_dma_sync_netmem_for_cpu(rxr->page_pool, netme=
m, 0,
> > +                                                 BNXT_RX_PAGE_SIZE);
> >
> >                 total_frag_len +=3D frag_len;
> >                 prod =3D NEXT_RX_AGG(prod);
> > @@ -1289,32 +1324,28 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
> >         return total_frag_len;
> >  }
> >
> > -static struct sk_buff *bnxt_rx_agg_pages_skb(struct bnxt *bp,
> > -                                            struct bnxt_cp_ring_info *=
cpr,
> > -                                            struct sk_buff *skb, u16 i=
dx,
> > -                                            u32 agg_bufs, bool tpa)
> > +static struct sk_buff *bnxt_rx_agg_netmems_skb(struct bnxt *bp,
> > +                                              struct bnxt_cp_ring_info=
 *cpr,
> > +                                              struct sk_buff *skb, u16=
 idx,
> > +                                              u32 agg_bufs, bool tpa)
> >  {
> > -       struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> >         u32 total_frag_len =3D 0;
> >
> > -       total_frag_len =3D __bnxt_rx_agg_pages(bp, cpr, shinfo, idx,
> > -                                            agg_bufs, tpa, NULL);
> > +       total_frag_len =3D __bnxt_rx_agg_netmems(bp, cpr, idx, agg_bufs=
, tpa,
> > +                                              skb, NULL);
> >         if (!total_frag_len) {
> >                 skb_mark_for_recycle(skb);
> >                 dev_kfree_skb(skb);
> >                 return NULL;
> >         }
> >
> > -       skb->data_len +=3D total_frag_len;
> > -       skb->len +=3D total_frag_len;
> > -       skb->truesize +=3D BNXT_RX_PAGE_SIZE * agg_bufs;
> >         return skb;
> >  }
> >
> > -static u32 bnxt_rx_agg_pages_xdp(struct bnxt *bp,
> > -                                struct bnxt_cp_ring_info *cpr,
> > -                                struct xdp_buff *xdp, u16 idx,
> > -                                u32 agg_bufs, bool tpa)
> > +static u32 bnxt_rx_agg_netmems_xdp(struct bnxt *bp,
> > +                                  struct bnxt_cp_ring_info *cpr,
> > +                                  struct xdp_buff *xdp, u16 idx,
> > +                                  u32 agg_bufs, bool tpa)
> >  {
> >         struct skb_shared_info *shinfo =3D xdp_get_shared_info_from_buf=
f(xdp);
> >         u32 total_frag_len =3D 0;
> > @@ -1322,8 +1353,8 @@ static u32 bnxt_rx_agg_pages_xdp(struct bnxt *bp,
> >         if (!xdp_buff_has_frags(xdp))
> >                 shinfo->nr_frags =3D 0;
> >
> > -       total_frag_len =3D __bnxt_rx_agg_pages(bp, cpr, shinfo,
> > -                                            idx, agg_bufs, tpa, xdp);
> > +       total_frag_len =3D __bnxt_rx_agg_netmems(bp, cpr, idx, agg_bufs=
, tpa,
> > +                                              NULL, xdp);
> >         if (total_frag_len) {
> >                 xdp_buff_set_frags_flag(xdp);
> >                 shinfo->nr_frags =3D agg_bufs;
> > @@ -1895,7 +1926,8 @@ static inline struct sk_buff *bnxt_tpa_end(struct=
 bnxt *bp,
> >         }
> >
> >         if (agg_bufs) {
> > -               skb =3D bnxt_rx_agg_pages_skb(bp, cpr, skb, idx, agg_bu=
fs, true);
> > +               skb =3D bnxt_rx_agg_netmems_skb(bp, cpr, skb, idx, agg_=
bufs,
> > +                                             true);
> >                 if (!skb) {
> >                         /* Page reuse already handled by bnxt_rx_pages(=
). */
> >                         cpr->sw_stats->rx.rx_oom_discards +=3D 1;
> > @@ -2175,9 +2207,10 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct b=
nxt_cp_ring_info *cpr,
> >         if (bnxt_xdp_attached(bp, rxr)) {
> >                 bnxt_xdp_buff_init(bp, rxr, cons, data_ptr, len, &xdp);
> >                 if (agg_bufs) {
> > -                       u32 frag_len =3D bnxt_rx_agg_pages_xdp(bp, cpr,=
 &xdp,
> > -                                                            cp_cons, a=
gg_bufs,
> > -                                                            false);
> > +                       u32 frag_len =3D bnxt_rx_agg_netmems_xdp(bp, cp=
r, &xdp,
> > +                                                              cp_cons,
> > +                                                              agg_bufs=
,
> > +                                                              false);
> >                         if (!frag_len)
> >                                 goto oom_next_rx;
> >
> > @@ -2229,7 +2262,8 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bn=
xt_cp_ring_info *cpr,
> >
> >         if (agg_bufs) {
> >                 if (!xdp_active) {
> > -                       skb =3D bnxt_rx_agg_pages_skb(bp, cpr, skb, cp_=
cons, agg_bufs, false);
> > +                       skb =3D bnxt_rx_agg_netmems_skb(bp, cpr, skb, c=
p_cons,
> > +                                                     agg_bufs, false);
> >                         if (!skb)
> >                                 goto oom_next_rx;
> >                 } else {
> > @@ -3445,15 +3479,15 @@ static void bnxt_free_one_rx_agg_ring(struct bn=
xt *bp, struct bnxt_rx_ring_info
> >
> >         for (i =3D 0; i < max_idx; i++) {
> >                 struct bnxt_sw_rx_agg_bd *rx_agg_buf =3D &rxr->rx_agg_r=
ing[i];
> > -               struct page *page =3D rx_agg_buf->page;
> > +               netmem_ref netmem =3D rx_agg_buf->netmem;
> >
> > -               if (!page)
> > +               if (!netmem)
> >                         continue;
> >
> > -               rx_agg_buf->page =3D NULL;
> > +               rx_agg_buf->netmem =3D 0;
> >                 __clear_bit(i, rxr->rx_agg_bmap);
> >
> > -               page_pool_recycle_direct(rxr->page_pool, page);
> > +               page_pool_recycle_direct_netmem(rxr->page_pool, netmem)=
;
> >         }
> >  }
> >
> > @@ -3746,7 +3780,7 @@ static void bnxt_free_rx_rings(struct bnxt *bp)
> >                         xdp_rxq_info_unreg(&rxr->xdp_rxq);
> >
> >                 page_pool_destroy(rxr->page_pool);
> > -               if (bnxt_separate_head_pool())
> > +               if (bnxt_separate_head_pool(rxr))
> >                         page_pool_destroy(rxr->head_pool);
> >                 rxr->page_pool =3D rxr->head_pool =3D NULL;
> >
> > @@ -3777,15 +3811,20 @@ static int bnxt_alloc_rx_page_pool(struct bnxt =
*bp,
> >         pp.dev =3D &bp->pdev->dev;
> >         pp.dma_dir =3D bp->rx_dir;
> >         pp.max_len =3D PAGE_SIZE;
> > -       pp.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
> > +       pp.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV |
> > +                  PP_FLAG_ALLOW_UNREADABLE_NETMEM;
>
> FWIW I had expected drivers to only set
> PP_FLAG_ALLOW_UNREADABLE_NETMEM if the driver is capable of handling
> unreadable netmem in this configuration, i.e. header split is turned
> on and headersplit threshold is 0, and I think we're planning to do
> that for GVE.
>
> I know that there is a core check on binding for this, but in my
> experience some of these settings may get reset on driver resets? And
> core could miss a check here and there. Checking here on page_pool
> create seems like a straightforward way to prevent some bugs. although
> it could be seen as a defensive check.

So, you mean that netmem is already set and then by some things like a
driver resetting, a configuration would be changed and then driver
re-enters initialization logic.
If so, the configuration requirement for devmem TCP would not be
satisfied. I'm not sure, but I think this scenario may be a bug.
The core should receive that signal from devices and handle it properly.

As you mentioned, mp_ops->init() would be a better place if this check
is required. This is called by page_pool_create().

>
> But this is fine too, no strong feelings here:
>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Thanks a lot!
Taehee Yoo

