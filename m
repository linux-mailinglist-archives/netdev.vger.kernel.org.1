Return-Path: <netdev+bounces-199084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C95ADEE2F
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 15:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DADF4A2011
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420002E9ECB;
	Wed, 18 Jun 2025 13:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eb3mtq7e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5091227E1C3
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 13:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750254189; cv=none; b=Rxtd2LDUGQURGP9rZ/ZgJC/wDsmKktUfeQPKnKaZaAYnNjCEdDO7B+f7qIasLbDzYBi1qdK7XY87Rqu8FShJOnL0N7wIIcpT0V1kSGxPc6vPKiVlqB55LZLIavYDwlF3T6PgxhFR82JqWrG4hck+LKBmGoR6dFmHkgM3dtv6Uys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750254189; c=relaxed/simple;
	bh=lPZFQ1SbLNDn4ql0bNMO1Y3UOqUYirOhb7bM8OXtknM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZP/jblApk3K5uLLiFfBM96i1T3WUB8cfqS7qsm8DPpAfMnLkMmF8RvxgGoIHEBKBgolenMASnUZ7R5Xr1eElhMiB57wVtFj6CtZlJdpXPFcDSp3FaRTs9/hLxIp8RgNiXJhxKgE9wXzd31q6vibtNIm/iLD0uHm7XfYI+niJtP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eb3mtq7e; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso13511740a12.2
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 06:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750254185; x=1750858985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=161UH8PN1dLl3cBIWKy4zaw4h8NX3WLyAHggvUoqd2Y=;
        b=eb3mtq7eW33KwNO4ilSnAf/+5GR5Mi0ZHY6D38ZU4vsPbANpROmb/2WAbgUov9G7gv
         MZvF+fpAFulvMcT+pgFi7KjKIRTKnRP3BZHEkNjJHHvVJpaeKv2f4dxcVkRtMVqTbwy4
         /v7nyYBNUVop68Zq0XvNQSqgi/ojOL0Jp5TcouiOEcTC96eNkcRT0VcVUtx5ZrA+pGiZ
         +NYnanS/y0sS5QaMh4nhfVq2otP0Z5kr49gSplt+ZuNZ7yF3+fGRTFlQ4VeyOl1jpXmB
         hR4sa7ocLsxHdPyIbASz/mYTFFaSc7TfqZvH6bk5JR+PsBcK3PP4DJSVDf4TIRRZ/GjD
         TBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750254185; x=1750858985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=161UH8PN1dLl3cBIWKy4zaw4h8NX3WLyAHggvUoqd2Y=;
        b=lwaIGrzm7n7zmx++CpTY4+f+SQcvPI86u9I9/+8GGqDzuVrrA0WnWhEdOiPm9lzqWD
         Dlj4FsqxeR7MI63iwcqmCfo8wIhyS5NbWm39R15KfFZV3RyJLco6t8EmbmL26rPYA4WY
         74Wp/cqb7Am+wc9FJrsmpJiNpaiE/tTVtIqDKZdlZt8h2L1vlcKk2e9zAq5vxFw9UTcY
         uSPQkJ/vFltGdRvq4xYLN6ShltaR2HQtDdCy5kb6ObEfTdrXMK5HQXLcmODmTVqe+YT4
         jw7De8q6W14RNdGhkwVSYf+20sZAeM4fKKYrOQei6f4ereBQAk9a8DUfAkzkLuyUHehX
         EGgw==
X-Forwarded-Encrypted: i=1; AJvYcCVWXO53F3Wr9WWCdxaqPQxPQfhT+BVMoxpWILsP3Ygd/5IHak7Zgq3pIUgkj38Lk6uEvFbnwjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcGgXUdWJNR9tTs41Ghdz+hQYS+yjhscMOSMqMdyDbsweGD8Mk
	EXFCAGKln6gJSRbeVI6dqeuIhgS1LG0uPo641vrpKOK9YUpA9wy2vFp4yrkm6ySiFF4Wr1TkHxu
	/syCt3VnxB7m6tb8EJMPxjzjqfueOztM=
X-Gm-Gg: ASbGncuZOViGQwMcgtJcSuOMd4D6aNMTnJOE4SZXkYIYoI7W5m7YyEkzuZuJgiponuA
	sG9ec0eAgKxT8u5FQzwKuxuca47YTpy/qpfx+nvgDa8ubnfIlz9WxWEmY9/XPiYqPz8akNv+hIC
	vcuVV7WA7b4vKfQWRbk0xb43ROCN9xoN6LUFcQ1Ew0A9UW
X-Google-Smtp-Source: AGHT+IGOgUqOLS/Wq0ykIWiASQmncShf6kjBdYHmSLFvF3czCL7KdBdLBxBUSeV5r9HhxGH0dhIkYnMiUflXi9xKhXk=
X-Received: by 2002:a05:6402:13d4:b0:602:cfab:ea9a with SMTP id
 4fb4d7f45d1cf-608d09e38b2mr16050281a12.27.1750254185282; Wed, 18 Jun 2025
 06:43:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617094540.819832-1-ap420073@gmail.com> <aFHPw5pjyA9yIepf@mini-arch>
In-Reply-To: <aFHPw5pjyA9yIepf@mini-arch>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 18 Jun 2025 22:42:52 +0900
X-Gm-Features: AX0GCFtpMO5BsPFdvqMioNGJakxt2Xf0k2lF5g67dWfDpIiuH0FPjs5cvW29esk
Message-ID: <CAMArcTUWueMBxTJpStiPbUtSSMKBjScySzSaiMkbL+ovoHJkiQ@mail.gmail.com>
Subject: Re: [PATCH net-next] eth: bnxt: add netmem TX support
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, almasrymina@google.com, 
	sdf@fomichev.me, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 5:27=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>

Hi Stanislav,
Thanks a lot for your review!

> On 06/17, Taehee Yoo wrote:
> > Use netmem_dma_*() helpers and declare netmem_tx to support netmem TX.
> > By this change, all bnxt devices will support the netmem TX.
> >
> > bnxt_start_xmit() uses memcpy() if a packet is too small. However,
> > netmem packets are unreadable, so memcpy() is not allowed.
> > It should check whether an skb is readable, and if an SKB is unreadable=
,
> > it is processed by the normal transmission logic.
> >
> > netmem TX can be tested with ncdevmem.c
> >
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > ---
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 28 ++++++++++++++---------
> >  1 file changed, 17 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.c
> > index 869580b6f70d..4de9dc123a18 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -477,6 +477,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *=
skb, struct net_device *dev)
> >       struct bnxt_tx_ring_info *txr;
> >       struct bnxt_sw_tx_bd *tx_buf;
> >       __le32 lflags =3D 0;
> > +     skb_frag_t *frag;
> >
> >       i =3D skb_get_queue_mapping(skb);
> >       if (unlikely(i >=3D bp->tx_nr_rings)) {
> > @@ -563,7 +564,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *=
skb, struct net_device *dev)
> >               lflags |=3D cpu_to_le32(TX_BD_FLAGS_NO_CRC);
> >
> >       if (free_size =3D=3D bp->tx_ring_size && length <=3D bp->tx_push_=
thresh &&
> > -         !lflags) {
> > +         skb_frags_readable(skb) && !lflags) {
> >               struct tx_push_buffer *tx_push_buf =3D txr->tx_push;
> >               struct tx_push_bd *tx_push =3D &tx_push_buf->push_bd;
> >               struct tx_bd_ext *tx_push1 =3D &tx_push->txbd2;
> > @@ -598,9 +599,9 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *=
skb, struct net_device *dev)
> >               skb_copy_from_linear_data(skb, pdata, len);
> >               pdata +=3D len;
> >               for (j =3D 0; j < last_frag; j++) {
> > -                     skb_frag_t *frag =3D &skb_shinfo(skb)->frags[j];
> >                       void *fptr;
> >
> > +                     frag =3D &skb_shinfo(skb)->frags[j];
> >                       fptr =3D skb_frag_address_safe(frag);
> >                       if (!fptr)
> >                               goto normal_tx;
> > @@ -708,8 +709,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *=
skb, struct net_device *dev)
> >                       cpu_to_le32(cfa_action << TX_BD_CFA_ACTION_SHIFT)=
;
> >       txbd0 =3D txbd;
> >       for (i =3D 0; i < last_frag; i++) {
> > -             skb_frag_t *frag =3D &skb_shinfo(skb)->frags[i];
> > -
> > +             frag =3D &skb_shinfo(skb)->frags[i];
> >               prod =3D NEXT_TX(prod);
> >               txbd =3D &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(pro=
d)];
> >
> > @@ -721,7 +721,8 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *=
skb, struct net_device *dev)
> >                       goto tx_dma_error;
> >
> >               tx_buf =3D &txr->tx_buf_ring[RING_TX(bp, prod)];
> > -             dma_unmap_addr_set(tx_buf, mapping, mapping);
> > +             netmem_dma_unmap_addr_set(skb_frag_netmem(frag), tx_buf,
> > +                                       mapping, mapping);
> >
> >               txbd->tx_bd_haddr =3D cpu_to_le64(mapping);
> >
> > @@ -778,9 +779,11 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff =
*skb, struct net_device *dev)
> >       for (i =3D 0; i < last_frag; i++) {
> >               prod =3D NEXT_TX(prod);
> >               tx_buf =3D &txr->tx_buf_ring[RING_TX(bp, prod)];
> > -             dma_unmap_page(&pdev->dev, dma_unmap_addr(tx_buf, mapping=
),
> > -                            skb_frag_size(&skb_shinfo(skb)->frags[i]),
> > -                            DMA_TO_DEVICE);
> > +             frag =3D &skb_shinfo(skb)->frags[i];
> > +             netmem_dma_unmap_page_attrs(&pdev->dev,
> > +                                         dma_unmap_addr(tx_buf, mappin=
g),
> > +                                         skb_frag_size(frag),
> > +                                         DMA_TO_DEVICE, 0);
> >       }
> >
> >  tx_free:
> > @@ -3422,9 +3425,11 @@ static void bnxt_free_one_tx_ring_skbs(struct bn=
xt *bp,
> >                       skb_frag_t *frag =3D &skb_shinfo(skb)->frags[j];
> >
> >                       tx_buf =3D &txr->tx_buf_ring[ring_idx];
> > -                     dma_unmap_page(&pdev->dev,
> > -                                    dma_unmap_addr(tx_buf, mapping),
> > -                                    skb_frag_size(frag), DMA_TO_DEVICE=
);
> > +                     netmem_dma_unmap_page_attrs(&pdev->dev,
> > +                                                 dma_unmap_addr(tx_buf=
,
> > +                                                                mappin=
g),
> > +                                                 skb_frag_size(frag),
> > +                                                 DMA_TO_DEVICE, 0);
> >               }
> >               dev_kfree_skb(skb);
> >       }
> > @@ -16713,6 +16718,7 @@ static int bnxt_init_one(struct pci_dev *pdev, =
const struct pci_device_id *ent)
> >       if (BNXT_SUPPORTS_QUEUE_API(bp))
> >               dev->queue_mgmt_ops =3D &bnxt_queue_mgmt_ops;
> >       dev->request_ops_lock =3D true;
> > +     dev->netmem_tx =3D true;
> >
> >       rc =3D register_netdev(dev);
> >       if (rc)
>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
>
> Similar to what I had internally for testing. One thing to think about
> here might be to put that netmem_tx=3Dtrue under BNXT_SUPPORTS_QUEUE_API
> conditional. This way both rx/tx will either be supported or not. But
> since there is probably no real FW requirement for TX, should be good
> as is.

I agree with you.
Since netmem TX doesn't require any specific hardware or firmware
features, it should be safe to enable this for all bnxt devices.

Thanks a lot!
Taehee Yoo

