Return-Path: <netdev+bounces-90345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523C58ADCDD
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 06:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08123282AF7
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 04:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219CE1B813;
	Tue, 23 Apr 2024 04:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b53X//X+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2A24C8F
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 04:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713847020; cv=none; b=moxZzdo8747hrQu4afvDAfUL0cd9svXNwbVKTxts4rW4Ho5gYLPePqBWUID4YzLcCzNR/u2PI/dfgdAFvksg9CTbjl16QYhp2FB4Ff0ldUS8owmOP3jGhoJljBhwv5zfeSUpapsI/Gz1U8tg/c7pm9gG3pflz/e3CVQ1Gw0paZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713847020; c=relaxed/simple;
	bh=+iZlYXOeD/Ut+lJkmf8h3kSY1GbFH3rqzFZ/vwiemX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HtqKDBJyIjnvvajP6EhGBLDRqHHsjhGyY5unNP0vDZevrBqzmHkeEhFoXjnwrwyqOuzY5YC+eGpglq2a9Z60oUexsBrt01aCkrQdSN11U3NFCUuUTK3L0Ji9U/1sfxYvAjYXI17hh40ZLEG7+fPxsTphOICDvmrEp+zl5Sffn2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b53X//X+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713847017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bwqzyFkRSIXV6vZIQMV3GPT47dRGvdW618w0sy3FvzY=;
	b=b53X//X+su7SLksp3JZZ1XiLMDf6ADXGri5MuY3rwcbI0tVvr0pDQN3a5SzlKtdqvJUIe6
	/Dw5cPZpH3Me2j8MZvzGLFbClMKb6iThe6547FaOAansdjv9PsDMotbuvmNQ7AMh0tRgNr
	0nBqQTmQvyLS8WnmUn/7dIG69rknD+g=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-XKSsl-lDPXGWVjQG_PjIbA-1; Tue, 23 Apr 2024 00:36:55 -0400
X-MC-Unique: XKSsl-lDPXGWVjQG_PjIbA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2a5e1e7bab9so6753282a91.2
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 21:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713847014; x=1714451814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bwqzyFkRSIXV6vZIQMV3GPT47dRGvdW618w0sy3FvzY=;
        b=tIiXcgQCDYg7F7tYrzdetwfaiO0mEu7WyF31SjeOjX4dYE1cTQfSUtGYqAV71FYzvo
         cTxdXq/+6JIBzMLqj/f3s9GU99mDgoqG4xwXOdwHoHM+mdhMfegFYRV2H/muabphxo7c
         +SeLj0ViKpVVJcc7s9vNioy9rLH+DxVP10inULJn31wrkUgB6vjbgEoDttcDjvQwu7XB
         LS4b9YvQPcUr6S98OdByAOgocPVK2/0myENpAIpYecErSa67kv+7hloPHykxdWqrclEU
         CysOguK/qsQU2uoYGIaVYbzH9ijERcyQnj2RB8UeCrP9qmfXSUtP8vjdLoDPZiWHFYZF
         bD1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqI4KOCpmYFqm3PSoJGwoQ/DZKoKE43kY+71S7fjEWW/ZT7PQ/eV3zOp85HN7Ksiry9RzUYhmisIm3wx1g2nC83cYYHOAN
X-Gm-Message-State: AOJu0YwzGrY8jdtaJ51pKI79kiHG+VcCexcQTJTGisueWWUW/b4Zktvp
	rX1Lv3XRq5IWSwGYe5Az6bndvveZhBls4X1TIN9RYGt5DPBbSJVYdwLh+Q5KtelR0vvFEvSbFPP
	PbVhUY4SeVGr6oq9MU0mM9qWxPgshqKgzi6LWoazN6Yv4y+Mgoa39MuuLsk4YRYqbFuvIfXjq94
	5qANMo4PIA8mzMV+cvmMZIr3FBKwaO9Lqon1wpwrkC2g==
X-Received: by 2002:a17:90a:3481:b0:2a4:9836:aa2c with SMTP id p1-20020a17090a348100b002a49836aa2cmr10058601pjb.28.1713847014177;
        Mon, 22 Apr 2024 21:36:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrAZJcVezWbUZHEt7CfRrKZKIhuuguh4q+qQ6ZoI2Anzglyck0tLmwE5rBicGTZR1dSv+IfUKVMvo4h5pPvdg=
X-Received: by 2002:a17:90a:3481:b0:2a4:9836:aa2c with SMTP id
 p1-20020a17090a348100b002a49836aa2cmr10058592pjb.28.1713847013884; Mon, 22
 Apr 2024 21:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422072408.126821-1-xuanzhuo@linux.alibaba.com> <20240422072408.126821-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240422072408.126821-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 Apr 2024 12:36:42 +0800
Message-ID: <CACGkMEuEYwR_QE-hhnD0KYujD6MVEArz3FPyjsfmJ-jk_02hZw@mail.gmail.com>
Subject: Re: [PATCH vhost v2 4/7] virtio_net: big mode support premapped
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 3:24=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> In big mode, pre-mapping DMA is beneficial because if the pages are not
> used, we can reuse them without needing to unmap and remap.
>
> We require space to store the DMA address. I use the page.dma_addr to
> store the DMA address from the pp structure inside the page.
>
> Every page retrieved from get_a_page() is mapped, and its DMA address is
> stored in page.dma_addr. When a page is returned to the chain, we check
> the DMA status; if it is not mapped (potentially having been unmapped),
> we remap it before returning it to the chain.
>
> Based on the following points, we do not use page pool to manage these
> pages:
>
> 1. virtio-net uses the DMA APIs wrapped by virtio core. Therefore,
>    we can only prevent the page pool from performing DMA operations, and
>    let the driver perform DMA operations on the allocated pages.
> 2. But when the page pool releases the page, we have no chance to
>    execute dma unmap.
> 3. A solution to #2 is to execute dma unmap every time before putting
>    the page back to the page pool. (This is actually a waste, we don't
>    execute unmap so frequently.)
> 4. But there is another problem, we still need to use page.dma_addr to
>    save the dma address. Using page.dma_addr while using page pool is
>    unsafe behavior.
>
> More:
>     https://lore.kernel.org/all/CACGkMEu=3DAok9z2imB_c5qVuujSh=3Dvjj1kx12=
fy9N7hqyi+M5Ow@mail.gmail.com/
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 123 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 108 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 2c7a67ad4789..d4f5e65b247e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -439,6 +439,81 @@ skb_vnet_common_hdr(struct sk_buff *skb)
>         return (struct virtio_net_common_hdr *)skb->cb;
>  }
>
> +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len=
)
> +{
> +       sg->dma_address =3D addr;
> +       sg->length =3D len;
> +}
> +
> +/* For pages submitted to the ring, we need to record its dma for unmap.
> + * Here, we use the page.dma_addr and page.pp_magic to store the dma
> + * address.
> + */
> +static void page_chain_set_dma(struct page *p, dma_addr_t addr)
> +{
> +       if (sizeof(dma_addr_t) > sizeof(unsigned long)) {

Need a macro like PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA.

> +               p->dma_addr =3D lower_32_bits(addr);
> +               p->pp_magic =3D upper_32_bits(addr);

And this uses three fields on page_pool which I'm not sure the other
maintainers are happy with. For example, re-using pp_maing might be
dangerous. See c07aea3ef4d40 ("mm: add a signature in struct page").

I think a more safe way is to reuse page pool, for example introducing
a new flag with dma callbacks?

Thanks


