Return-Path: <netdev+bounces-178774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331F2A78DE5
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 14:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9BF3AA292
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 12:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAE52356DF;
	Wed,  2 Apr 2025 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+iGUcFN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B9223371D
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743595767; cv=none; b=U0gQRUBf0heNK5wrTQs61fah3gd9RWbJzu47QyHq/0jeSAggqU6EyVO8Lu+bdTf5ym42owuG2YsPnQoKLSMCzJRx4m2rPasgXZioGg2jO/YNRZRL/0X+WTqmCf07GV25ATC+191FdcCrodM3SOG1O1zRl6k2P9lMRrdkLa/YI+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743595767; c=relaxed/simple;
	bh=YFS3kPiQ8zANxx4A13I9fHz6kamZ3U0hMtxRi6dnWXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ik00jkxM1Ue48zcM4GzY/uq9Xjhy13OZP1MpWp6nw19l/U+/1fPTi3fG0xZAk+bQN1gz/RivuoGDWwNowGgeqm3yaTRJaqLx3B6QBiQRFkzxYmNsKVABQlQit4exV9/fiYuLHdNZW8eosOuMlNp5mjf+tNuRLC+1F8NZhnw0+8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+iGUcFN; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9eb1eso1526503a12.0
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 05:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743595764; x=1744200564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buyw39l33d4if3yuYSFe7/FnbmVmAQ5ttC4t+mfdX1k=;
        b=U+iGUcFNWXpyqnQWxYHoO8bAlVZR2kcUpysaOqbg6wFnitJrLfd2fnx8L8eZ2oND8j
         9KpQtAJH27bhT4WpVr233ck/B3znP+du7G9gHhnlHwhjYCHLLR/Z6IwjnDTzveJponU2
         d7DrSQc8nPTsrzK6TkOf+m7/JmJQMz1OBdS654zmtgbtFBGkSCd2Offwp0doG94TkBav
         eXLs0NByJxFXvonzbCliiOZKzfAR8IM+9QoD7cNEnfeN4c6Ll67N+/H7TkGTBMPMVbgz
         cuE9n7xQHNSz3KK1zVw3g5MjSzf4PwPHxxiUn1GMHN17PM3W1ofWrs7TyPUljWRxJu9F
         M4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743595764; x=1744200564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buyw39l33d4if3yuYSFe7/FnbmVmAQ5ttC4t+mfdX1k=;
        b=awjLKrBLddmD+JnAQqhzxBYbh4csxTiPT+9+uQBVp3P+ergyKnxvXqTPs2mHkkb3My
         G7OVKtF2fCA/2c7lZ3fgoID/SUhia2ox+2Fs8P4OYvvioSeUU8S9rymQF3UsQ47be/8V
         V6CtaaRX+9StB3B1l78W9uFbg8sfoUiBrz8Y23nCuSKnHpOvWOor2NuLe60P5LjEQ5h5
         Wd42RUw+Ln6CqcZMhiGYG6yT4frETk4JeYhtRPeqH84u1LxxjOW0POVIFhFEH6PqfUQe
         SSugX8Ev7puQPhlogXRrPHHyiAbsvLzqS/pzWhglv0QUG0LfFc29OC6brLPzyauxabsm
         6EIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8SbBiB4bSvwHR/cd4hFO19HfFXcTme8lAa5SmuPO+A4nJcjN4LjjagLHu9dWHWCqxjyCOsVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvkH1pInJ+4n4rzuyRyYWR4JYuUeemCnJrI1Qu+M1xtfP9rxH/
	WUNfedB8b4WJgU5wef4u3F+X12TS9bnK0pUD64GGEk+PklhGIf1EvNWP0fJN3bj5P/MGaSa59FZ
	D7UzwRWh5mLDccVSQ7r2S+pPGRL/pD6P8vQo=
X-Gm-Gg: ASbGnculR6o8Z+DtaYQxiiV/Jxf7PGzDWwYnRmAx6p0cJEnPvbCCzzrUNi7IRD3JnA2
	4n+DwgRseXCUhJruiFVCU+paX1k+d867Y11iJHAY839Gp1rkCcAg6YQIlQwSOBb3WJKidh5yAn5
	3A3tjTMCd0FVML4cAOKIC/suQ87U8=
X-Google-Smtp-Source: AGHT+IGGwjDaUFMu6bmt3CmcczePRDVRId5F9XbsbgbJuJPxfdlEiY9A848Z2r6HKS9aOjmFR2vV0lFSluk5vAYVbkA=
X-Received: by 2002:a05:6402:440f:b0:5e4:d52b:78a2 with SMTP id
 4fb4d7f45d1cf-5f06037318amr1580929a12.15.1743595763434; Wed, 02 Apr 2025
 05:09:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331114729.594603-1-ap420073@gmail.com> <20250331114729.594603-3-ap420073@gmail.com>
 <20250331115045.032d2eb7@kernel.org>
In-Reply-To: <20250331115045.032d2eb7@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 2 Apr 2025 21:09:11 +0900
X-Gm-Features: AQ5f1Jry6Y_wUMNfh-BMXY4RSa4GKV67lTYAFNqqvNjQDOdN_cNmyqhVNw1yY8E
Message-ID: <CAMArcTX1Q3Nx=GNiHHom=_P3A-jwT1gjpjh_yegj9CWkXbqvdg@mail.gmail.com>
Subject: Re: [RFC net-next 2/2] eth: bnxt: add support rx side device memory TCP
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, ilias.apalodimas@linaro.org, dw@davidwei.uk, 
	netdev@vger.kernel.org, kuniyu@amazon.com, sdf@fomichev.me, 
	aleksander.lobakin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 3:50=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>

Hi Jakub,
Thank you so much for the review!

> On Mon, 31 Mar 2025 11:47:29 +0000 Taehee Yoo wrote:
> > Currently, bnxt_en driver satisfies the requirements of the Device
> > memory TCP, which is HDS.
> > So, it implements rx-side Device memory TCP for bnxt_en driver.
> > It requires only converting the page API to netmem API.
> > `struct page` for rx-size are changed to `netmem_ref netmem` and
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
>
> > @@ -1352,15 +1367,15 @@ static struct sk_buff *bnxt_copy_data(struct bn=
xt_napi *bnapi,
> >       if (!skb)
> >               return NULL;
> >
> > -     page_pool_dma_sync_for_cpu(rxr->head_pool, page,
> > -                                offset + bp->rx_dma_offset,
> > -                                bp->rx_copybreak);
> > +     page_pool_dma_sync_netmem_for_cpu(rxr->head_pool, netmem,
> > +                                       offset + bp->rx_dma_offset,
> > +                                       bp->rx_copybreak);
> >
> >       memcpy(skb->data - NET_IP_ALIGN,
> > -            bnxt_data_ptr(bp, page, offset) - NET_IP_ALIGN,
> > +            bnxt_data_ptr(bp, netmem, offset) - NET_IP_ALIGN,
> >              len + NET_IP_ALIGN);
> >
> > -     page_pool_dma_sync_for_device(rxr->head_pool, page_to_netmem(page=
),
> > +     page_pool_dma_sync_for_device(rxr->head_pool, netmem,
> >                                     bp->rx_dma_offset, bp->rx_copybreak=
);
> >       skb_put(skb, len);
> >
>
> Do we check if rx copybreak is enabled before allowing ZC to be enabled?
> We can't copybreak with unreadable memory.

For the bnxt driver, only the first page's data is copied by rx-copybreak.
agg buffers are not affected by rx-copybreak.
So I think it's okay.
I tested rx-copybreak+devmem TCP, and it works well.
0 ~ 1024 rx-copybreak and from very small MTU to large MTU.

>
> > @@ -15912,7 +15941,7 @@ static int bnxt_queue_start(struct net_device *=
dev, void *qmem, int idx)
> >                       goto err_reset;
> >       }
> >
> > -     napi_enable(&bnapi->napi);
> > +     napi_enable_locked(&bnapi->napi);
> >       bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
> >
> >       for (i =3D 0; i < bp->nr_vnics; i++) {
> > @@ -15964,7 +15993,7 @@ static int bnxt_queue_stop(struct net_device *d=
ev, void *qmem, int idx)
> >       bnxt_hwrm_rx_ring_free(bp, rxr, false);
> >       bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
> >       page_pool_disable_direct_recycling(rxr->page_pool);
> > -     if (bnxt_separate_head_pool())
> > +     if (bnxt_separate_head_pool(rxr))
> >               page_pool_disable_direct_recycling(rxr->head_pool);
> >
> >       if (bp->flags & BNXT_FLAG_SHARED_RINGS)
> > @@ -15974,7 +16003,7 @@ static int bnxt_queue_stop(struct net_device *d=
ev, void *qmem, int idx)
> >        * completion is handled in NAPI to guarantee no more DMA on that=
 ring
> >        * after seeing the completion.
> >        */
> > -     napi_disable(&bnapi->napi);
> > +     napi_disable_locked(&bnapi->napi);
>
> This is a fix right? The IRQ code already calls the queue reset without
> rtnl_lock. Let's split it up and submit for net.
>

Oh yes, it's a fix indeed.
I will send a patch to fix this.
Thanks a lot!

> > @@ -2863,15 +2865,15 @@ static inline bool bnxt_sriov_cfg(struct bnxt *=
bp)
> >  #endif
> >  }
> >
> > -static inline u8 *bnxt_data_ptr(struct bnxt *bp, struct page *page,
> > +static inline u8 *bnxt_data_ptr(struct bnxt *bp, netmem_ref netmem,
> >                               unsigned int offset)
> >  {
> > -     return page_address(page) + offset + bp->rx_offset;
> > +     return netmem_address(netmem) + offset + bp->rx_offset;
> >  }
> >
> > -static inline u8 *bnxt_data(struct page *page, unsigned int offset)
> > +static inline u8 *bnxt_data(netmem_ref netmem, unsigned int offset)
> >  {
> > -     return page_address(page) + offset;
> > +     return netmem_address(netmem) + offset;
> >  }
>
> This is not great, seems like the unification of normal vs agg bd struct
> backfires here. unreadable netmem can only be populated in agg bds
> right? So why don't we keep the structs separate and avoid the need
> to convert from netmem back to a VA?

Okay, I will drop the 1/2 patch, and I will convert only agg ring
to netmem. So a normal ring will still handle
VA instead of page.
If there are refactorable changes in this driver,
I will send that separately.

>
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h b/drivers/ne=
t/ethernet/broadcom/bnxt/bnxt_xdp.h
> > index 9592d04e0661..85b6df6a9e7f 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
> > @@ -18,7 +18,7 @@ struct bnxt_sw_tx_bd *bnxt_xmit_bd(struct bnxt *bp,
> >                                  struct xdp_buff *xdp);
> >  void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int bud=
get);
> >  bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 c=
ons,
> > -              struct xdp_buff *xdp, struct page *page, u8 **data_ptr,
> > +              struct xdp_buff *xdp, netmem_ref netmem, u8 **data_ptr,
> >                unsigned int *len, u8 *event);
> >  int bnxt_xdp(struct net_device *dev, struct netdev_bpf *xdp);
> >  int bnxt_xdp_xmit(struct net_device *dev, int num_frames,
> > @@ -27,7 +27,7 @@ int bnxt_xdp_xmit(struct net_device *dev, int num_fra=
mes,
> >  bool bnxt_xdp_attached(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)=
;
> >
> >  void bnxt_xdp_buff_init(struct bnxt *bp, struct bnxt_rx_ring_info *rxr=
,
> > -                     u16 cons, struct page *page, unsigned int len,
> > +                     u16 cons, netmem_ref netmem, unsigned int len,
> >                       struct xdp_buff *xdp);
>
> We also shouldn't pass netmem to XDP init, it's strange conceptually.
> If we reach XDP it has to be a non-net_iov page.

A normal page_pool will not be converted to netmem in the next version.
So, XDP will still handle a page.

Thanks a lot!
Taehee Yoo

