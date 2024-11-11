Return-Path: <netdev+bounces-143686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA76B9C3A01
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 09:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69B84280BFE
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 08:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B238158520;
	Mon, 11 Nov 2024 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FP8jA4+y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96F43A8F7;
	Mon, 11 Nov 2024 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731315014; cv=none; b=a/2K4pqA8dEhpU+3hNUlzoBBu6eJW7+PO+RZ88R7QqtAsXWt7Xe7DqY9heFEgGmvbxa+0M9K69g5yQY5139XtZYfxIfCLXCzBu4n40AMXTaAm3MZUuJ/RyiTmBBrNObFbSFum23sgSdKdJDs5yGEbTvwEJRI0tNpa0l4KrXrDlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731315014; c=relaxed/simple;
	bh=M/73E4A6b/14kU5MnuEE6QF37MX/1yxDO8LoxCxt7uI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brwEdR+OvAsR7vWDDQwe8EjSA5Nbc8tZDuk4bMLf4zeHsM1DhWJIIN3zWJqyznKOSKYaPEbD6TbA59SbTDKCV3mgCBpshvtgPA78Qqtbttm8IUTOJjHSl687mX5ES9v4LcEEwyOT3E06tvyAgJP6FNpxbtiEFCw1Fj/o9FJbQnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FP8jA4+y; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ea7c9227bfso42246407b3.2;
        Mon, 11 Nov 2024 00:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731315012; x=1731919812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D//mS1R7Tjzn/d893FmNDYoNK5LBWkF5qFytEqC9ppY=;
        b=FP8jA4+yOF455sAU3ubfEX9kslkICf9hi4wYuW8ZdOe7yrSONLm47rypF/X4Bcf2hS
         J0Kd22g9mFPTY8yjLGxWgvaHnb6WxR/YMehd3YsIjCAVsS+DO554BPAC5TbfZonz1zFw
         S45PvpQW5tLqervMonQ/wUX7C6QCOK++BBbjAp2IiUBtJhwCDZV2GfhiB57iVlYkrR33
         2axe5frsghqGZKKum8xDuf/fnvMXBqS3EineBU13e7dQv1L0Mhmku5aJ+erHMP3WACdw
         vvGhIhoxiDp9p/IoGNtnYcxG3neARtjDG5flv7GV0KK2lPoKIG8uT6aAI8gzVSoKOf0n
         2tXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731315012; x=1731919812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D//mS1R7Tjzn/d893FmNDYoNK5LBWkF5qFytEqC9ppY=;
        b=phIb1Xbi2FoqRBADtE/zIerK145noRW/W0FZxZdOspI2Nb5xlIXbYP2S0zdCLfcSp0
         IvGT8uc/Iu0l13W9X2L6D/zvx+7gmlH+3kUFENHly61EUkubMzNClBnVyYRVQJGy/dON
         SxJ4lOce+2KFLmLsSN9y2jI1jdmfV8/cTcdbSk1jr0iDMPx7DMfOxll5B/G6q46E+SVY
         Fn4HjvT+cMVpP80zWA4/1aHU8USvjlkJeVeiDHZfkJD8YnaJ6tLNOU2tzJRWAdzNfmDQ
         WAlcZKjZJVaFxL1tkkxvQdxtkAmJ+Kb+Joz5fxhGZUwQJDUAFeNbSR23bd+aCQTmDtEA
         KF1g==
X-Forwarded-Encrypted: i=1; AJvYcCVXpH69aG3/Yo+1RLzJi3E6wbm2BKYr9DZFvJljx2G+GE9VKcYaj0W50oo+aRJRoHmlhm3jR9Pr32mZzJ0=@vger.kernel.org, AJvYcCX/2t4tqpvO4wHCs2AjKEOtx9ViYEcs0ESXN+/Qxc/WOyTCN2pak5z10s8STB9hMxw/QW0+Rgzc@vger.kernel.org
X-Gm-Message-State: AOJu0YyGJ1UvmVpEyApHvp473wGDG1SulOw6ATvKIR4Y0oru75gMENxK
	w+C3GCx+JMsuzMElZTwG0GhBY+eCvOxNXGNlkrsbubXaDIeWkUK5I9hZx8AndrfTNC+RE36JA+b
	30MBiOF0XQ/rLe1TRxrUPI6QYmjA=
X-Google-Smtp-Source: AGHT+IFkL1fH47P2yVqFyyMaqEcgDgZumtv8gAh0ZW82Tx6agGQDMCaIC+Wsh10fIz60/zXX8wwdjTLnTBIzQRWW95Q=
X-Received: by 2002:a05:690c:92:b0:6ea:90b6:ab49 with SMTP id
 00721157ae682-6eaddd86de5mr114832577b3.5.1731315011714; Mon, 11 Nov 2024
 00:50:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108045708.1205994-1-bbhushan2@marvell.com>
 <20241108045708.1205994-2-bbhushan2@marvell.com> <20241110142303.GA50588@unreal>
 <CAAeCc_nPP7FU7KUZoW+9AVPdaqTpVopEKQGVpzHgXkBUzfa1xQ@mail.gmail.com> <20241111071556.GB71181@unreal>
In-Reply-To: <20241111071556.GB71181@unreal>
From: Bharat Bhushan <bharatb.linux@gmail.com>
Date: Mon, 11 Nov 2024 14:20:00 +0530
Message-ID: <CAAeCc_kiao9mT+=RwWWyB6_CwNeURjP8cDyFaaK3Jg-xREdC8Q@mail.gmail.com>
Subject: Re: [net-next PATCH v9 1/8] octeontx2-pf: map skb data as device writeable
To: Leon Romanovsky <leon@kernel.org>
Cc: Bharat Bhushan <bbhushan2@marvell.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com, 
	sbhatta@marvell.com, hkelam@marvell.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jerinj@marvell.com, 
	lcherian@marvell.com, ndabilpuram@marvell.com, sd@queasysnail.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 12:46=E2=80=AFPM Leon Romanovsky <leon@kernel.org> =
wrote:
>
> On Mon, Nov 11, 2024 at 10:31:02AM +0530, Bharat Bhushan wrote:
> > On Sun, Nov 10, 2024 at 7:53=E2=80=AFPM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > >
> > > On Fri, Nov 08, 2024 at 10:27:01AM +0530, Bharat Bhushan wrote:
> > > > Crypto hardware need write permission for in-place encrypt
> > > > or decrypt operation on skb-data to support IPsec crypto
> > > > offload. That patch uses skb_unshare to make skb data writeable
> > > > for ipsec crypto offload and map skb fragment memory as
> > > > device read-write.
> > > >
> > > > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > > > ---
> > > > v7->v8:
> > > >  - spell correction (s/sdk/skb) in description
> > > >
> > > > v6->v7:
> > > >  - skb data was mapped as device writeable but it was not ensured
> > > >    that skb is writeable. This version calls skb_unshare() to make
> > > >    skb data writeable.
> > > >
> > > >  .../ethernet/marvell/octeontx2/nic/otx2_txrx.c | 18 ++++++++++++++=
++--
> > > >  1 file changed, 16 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c=
 b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > > > index 7aaf32e9aa95..49b6b091ba41 100644
> > > > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > > > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > > > @@ -11,6 +11,7 @@
> > > >  #include <linux/bpf.h>
> > > >  #include <linux/bpf_trace.h>
> > > >  #include <net/ip6_checksum.h>
> > > > +#include <net/xfrm.h>
> > > >
> > > >  #include "otx2_reg.h"
> > > >  #include "otx2_common.h"
> > > > @@ -83,10 +84,17 @@ static unsigned int frag_num(unsigned int i)
> > > >  static dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
> > > >                                       struct sk_buff *skb, int seg,=
 int *len)
> > > >  {
> > > > +     enum dma_data_direction dir =3D DMA_TO_DEVICE;
> > > >       const skb_frag_t *frag;
> > > >       struct page *page;
> > > >       int offset;
> > > >
> > > > +     /* Crypto hardware need write permission for ipsec crypto off=
load */
> > > > +     if (unlikely(xfrm_offload(skb))) {
> > > > +             dir =3D DMA_BIDIRECTIONAL;
> > > > +             skb =3D skb_unshare(skb, GFP_ATOMIC);
> > > > +     }
> > > > +
> > > >       /* First segment is always skb->data */
> > > >       if (!seg) {
> > > >               page =3D virt_to_page(skb->data);
> > > > @@ -98,16 +106,22 @@ static dma_addr_t otx2_dma_map_skb_frag(struct=
 otx2_nic *pfvf,
> > > >               offset =3D skb_frag_off(frag);
> > > >               *len =3D skb_frag_size(frag);
> > > >       }
> > > > -     return otx2_dma_map_page(pfvf, page, offset, *len, DMA_TO_DEV=
ICE);
> > > > +     return otx2_dma_map_page(pfvf, page, offset, *len, dir);
> > >
> > > Did I read correctly and you perform DMA mapping on every SKB in data=
 path?
> > > How bad does it perform if you enable IOMMU?
> >
> > Yes Leon, currently DMA mapping is done with each SKB, That's true
> > even with non-ipsec cases.
> > Performance is not good with IOMMU enabled. Given the context of this
> > series, it just extends the same for ipsec use cases.
>
> I know and I don't ask to change anything, just really curious how
> costly this implementation is when IOMMU enabled.

It costs around ~60% for the iperf.

Thanks
-Bharat

>
> Thanks
>
> >
> > Thanks
> > -Bharat
> >
> > >
> > > Thanks
> > >
> > > >  }
> > > >
> > > >  static void otx2_dma_unmap_skb_frags(struct otx2_nic *pfvf, struct=
 sg_list *sg)
> > > >  {
> > > > +     enum dma_data_direction dir =3D DMA_TO_DEVICE;
> > > > +     struct sk_buff *skb =3D NULL;
> > > >       int seg;
> > > >
> > > > +     skb =3D (struct sk_buff *)sg->skb;
> > > > +     if (unlikely(xfrm_offload(skb)))
> > > > +             dir =3D DMA_BIDIRECTIONAL;
> > > > +
> > > >       for (seg =3D 0; seg < sg->num_segs; seg++) {
> > > >               otx2_dma_unmap_page(pfvf, sg->dma_addr[seg],
> > > > -                                 sg->size[seg], DMA_TO_DEVICE);
> > > > +                                 sg->size[seg], dir);
> > > >       }
> > > >       sg->num_segs =3D 0;
> > > >  }
> > > > --
> > > > 2.34.1
> > > >
> > > >
> > >

