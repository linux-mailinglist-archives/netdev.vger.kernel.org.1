Return-Path: <netdev+bounces-178903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F3EA79813
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 00:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07753B269B
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 22:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CACE1F4CBB;
	Wed,  2 Apr 2025 22:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DazS+ENm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830E51E5B6B
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 22:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743631915; cv=none; b=KTqLNffv7UPIkPUxFAxcb5jxxgKqnJH2pNKq2Zg1zXvMv7btkC93yavt5O8ZWzdaCTL4eOI0MopvBtSopp1VPoNPJa6shuNYcknKBXGHYSts6c1AoQN/s1LUQdAN4bOnoQhWyo2hgvgXTZ4VAjoohV3TkfTq4/eIyD9udIOWr0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743631915; c=relaxed/simple;
	bh=VB0owIokYWZ0/j+0rsx5AW2v1pNli4OLyt5auGY0lkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=khNSDAvpP6ujXNLqVG5of2etP+s8ZVzzYDKWRtmZhruzFxk8oLp2L0n36z7mNrURq0HBkrLL4fYPOtFPwmw481NRHEIu1nyI3ZPvoDhyxWneKEt8PjRfZ8/3pRTxh1S4qfKxjo3miwZzEYiKB3mH6vDNYGf4Mzqz6GE7dRM0G2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DazS+ENm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2242ac37caeso232295ad.1
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 15:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743631913; x=1744236713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6l6/JeWAvoEDfdSM8sBQ3O2CIWbs2YpItFz9SIHba3w=;
        b=DazS+ENmqe5jqfVz5ThjhDWD5Uuqjv2jUJwh5kDcu4S0ZJoVVTIt878I50ixYE2IgT
         ZYoLF4tQ5IbtmsfRCBzNYuw37bfR1+DtOQyjP9pZ/nqMpOhj2Lyl9oNNH5M2tuLOeZal
         0MS+49q2eQMZ1FI6il6pfgMhrJ46bXn0cvsfpA+LZDoBlkbPtNmbR/7mUlxr/a350y2d
         JZcNoo0l8DPRCTaxjCUR1a5xFm4/Map/IFEm+9atPLgnO60AqEFBfOzkUs5bL4TkJywa
         XWvTRaX+LtEmt1I987jSQXKKqEGmrw+z6vPX05cNndBvQGPTRf2w0Q1644D2xvPJPWuf
         rC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743631913; x=1744236713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6l6/JeWAvoEDfdSM8sBQ3O2CIWbs2YpItFz9SIHba3w=;
        b=GE8URitLOee58A1+5zS71kI1vldq4gXRdh/8Lwh2ftV64Posdmxeu4hPR6+BbBRCu3
         Z0woNfzbz+9ObiQCXKvdsqnstb9padQ2M1igslZDE7fYdR1D9mj6mnDv/G4YPKycRaaG
         iFIIsGwg4HUyeCxHaD/tmbeAc//lKd/Kvw58yqV6tJHJWyGOOuem4As44UkGLn/6WH1J
         142I3/p+AGO7cH1ZY4CObnJTWkP4YiP4OPxa7yYtywFiJ6e4ukP/Cn8g7GhIEig++Txu
         El01+FeUjBTWY0EUl/1YyMIYqglbEwxHBmzyxlC2ga6BxmoGrzAj3jfd5+tdusRBKw4Q
         iffw==
X-Forwarded-Encrypted: i=1; AJvYcCXkzEa9C+yiKpyZxcLIiHzIx8QvBAeaR07tvYLkRLWEWHI9okEQkKVNcm69mB9WvRlvp2VjPvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6VMYvK/KlVhOPSXuUhZTdrXMYHBdUDoTmPeog+QLvkBqTBgmg
	+Go0OIYG0/eP9t4mUexFfGtxcCnGFnImmFkCAf9t/2hx4hlwBY8LkmzTSqV1UAnT7UFZ6u2BjoD
	VGuhhOMZ3dAQHevkydPsSxoynpC71i5CMOTmz
X-Gm-Gg: ASbGncsniN1at2k5shaCaQhA9buVF1y/oTCFBA/xdP7T4U6c0AOtMAAABFsID45Xrzd
	nwKDAb+nzJx73SAiWDkN0oP+GN2gdqfFhl23DxAd+57ZWJw74va3ElBtV1as6StrS6c7ob3cTVw
	goFrbUcsvSluINbLlBjq0T2W580x1VRODhO764j3j7+iO6y/AYtRq3mJ0h
X-Google-Smtp-Source: AGHT+IEp9ehUtZi7N61341ceSKGTU0L9RRHzlHo6f5O9j762mqfHncbBB2T0MAMce8PrpM5u5Y1PqNqBgmL8VmnZ0Us=
X-Received: by 2002:a17:902:7295:b0:217:8612:b690 with SMTP id
 d9443c01a7336-229775030b2mr881125ad.8.1743631912412; Wed, 02 Apr 2025
 15:11:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331114729.594603-1-ap420073@gmail.com> <20250331114729.594603-3-ap420073@gmail.com>
 <20250331115045.032d2eb7@kernel.org>
In-Reply-To: <20250331115045.032d2eb7@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 2 Apr 2025 15:11:39 -0700
X-Gm-Features: AQ5f1JoP0oJxJ3R4gF5-HUe6EtWA4OqEbOUHlOsHiymMZXUo6uYJ-v3esNVwzsM
Message-ID: <CAHS8izNwpoH7qQbRqS3gpZaouVsR-8j5ju_ZRU6UmjO1ugbFWw@mail.gmail.com>
Subject: Re: [RFC net-next 2/2] eth: bnxt: add support rx side device memory TCP
To: Jakub Kicinski <kuba@kernel.org>
Cc: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	ilias.apalodimas@linaro.org, dw@davidwei.uk, netdev@vger.kernel.org, 
	kuniyu@amazon.com, sdf@fomichev.me, aleksander.lobakin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 11:50=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 31 Mar 2025 11:47:29 +0000 Taehee Yoo wrote:
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
>

Another option for your consideration (I don't know if it's better):

static inline u8 *bnxt_data(netmem_ref netmem, unsigned int offset)
{
    void * addr =3D netmem_addr(netmem);
    if (!addr) return addr;
    return addr + offset;
}

That way you can combine the structs, but all users of the return
value of bnxt_data need to NULL check it.

This would more naturally extend to possible future readable net_iovs.

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
>

Very noob question, but is XDP/netmem interactions completely
impossible for some reason? I was thinking XDP progs that only
touch/need the header may work with unreadable netmem, and if we ever
add readable net_iovs then those maybe can be exposed to XDP, no? Or
am I completely off the rails here?

--
Thanks,
Mina

