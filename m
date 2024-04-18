Return-Path: <netdev+bounces-89002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E519E8A9300
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 08:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DE53B21463
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 06:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628F66A356;
	Thu, 18 Apr 2024 06:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W43Vs6Ae"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5046A342
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 06:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713421523; cv=none; b=dRbHMs5wohm7/7tMU9d6pkyBbrI3F6iXv62NlPSphbbjyir9EQ+plY7KFMqQh5irkDT7gsB6TbyqYb/3zuxIpLx6FnogswYAnLShpd1RwBTJv4BxJF4ga9pZCgcOzjFMOVaC2vT4dSRaLt/9j3zypCjIqJl/fm6mgCAOd47OevI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713421523; c=relaxed/simple;
	bh=UKWj5axAEawkuNxMBF95CKkNwUgDdVYpKVVLfCLEx6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEJ0QsUMadj5XYRNm3hkKDYvF3EsfL8/n1F/JiyepNV7lgdsXORW9cZRGsDj7KlKx157knzP7G7TG7TCfskhrX5h7tVTdts6CJInx2gnxde6mRUSSSmdL1RRjvPinIA7g8/InIOAD4rVBZZ5fiI0OUoC82Vi2mNGXtk5cRb6nyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W43Vs6Ae; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713421520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3SewWpF/SnFjI1xDazp8UbxUkc9dZuIWJXH1Mfd0vcM=;
	b=W43Vs6AeLdxqIgcKfey8lXeS3GIdNW/zVddfIEm00EPmNg6GG8/g9BjyuIVhzD7OhLPZFv
	Bd8kTgWqJJ/w8w0gsG5FQZsFWwYCOxgmR+0LfkAf78gQJ4SnAp31Dg9G3bvXcAGhoyqDNj
	CIGWnlo/LsTiuv47xWyEnBmnw+jsd/s=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-UBC4uyPrNQG9VqPEGVN0aQ-1; Thu, 18 Apr 2024 02:25:19 -0400
X-MC-Unique: UBC4uyPrNQG9VqPEGVN0aQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a2d197ac0aso724622a91.2
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 23:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713421518; x=1714026318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SewWpF/SnFjI1xDazp8UbxUkc9dZuIWJXH1Mfd0vcM=;
        b=stk0s2IjK2bIS7S4n0JW+kCkJa5dynZzxt+cXAoAfHZVv7o2QjeKPnUe1lIKphY1DH
         Qmbsd0oBde7jIQIz/gNSvCMBN5CNA0X963cftYweoMNgQsr6w2Vvftwk/s51b/iwQFpw
         AL4uq9rAeA/lNjkitfNjpCchvyxz+097CGJN4gGdPfgjVzwMk7eC4pe91ToOxwxG8+kR
         gjbujxBoy5Bf0RCTVUN3IedsvLs845SqfkrVWo9H/kWRURaMDSr1o1GgAsVJ6TI7HMbt
         yiwd90FQweldlZTyKgzeaB+++VsIHkgzf+AMNAZFkNRuyyz8qt27OkDrXcm+u85bw4aA
         vJVw==
X-Forwarded-Encrypted: i=1; AJvYcCUc5EA1Ad9lzLlBBuseoyxzvAvdBCLRs8rQ0tgm5Hi4LE2Zlm1ajH3cIv82iPQgWvN7YhQEAZlHiHmNNZ1fziqTiUlkpIpE
X-Gm-Message-State: AOJu0YxbxJiEVaAsRIYntgEzwCGwUZVYiziFZp1XCJG2puYgx35Yqy6C
	3NbdUCNyYi/eJ4KbP4p2lCqSxxacInb9DhzEX0Xa7mhN0v38I/dKb3jbnCH3tOR/ghlwh6gwJmm
	WUCJA+Zo5WbgYAjq8NdJO6M2qDnpLvBgrHX6B2A9PZ3G8wnm9xVkBgU65/ANakbdb7TZG8HrWp5
	ACEBmmOFQMS7aZ09+ADiNnVAP1s1D7
X-Received: by 2002:a17:90a:8d0c:b0:29b:10bc:acaf with SMTP id c12-20020a17090a8d0c00b0029b10bcacafmr1519698pjo.30.1713421518280;
        Wed, 17 Apr 2024 23:25:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUb1tcxd28l7s/aI3fVkyVxkazCojziYlrnaEMX7FRuh7EZ+9SOYhexwt/qB4pr9kAHcQeChLkze7x+RxN75M=
X-Received: by 2002:a17:90a:8d0c:b0:29b:10bc:acaf with SMTP id
 c12-20020a17090a8d0c00b0029b10bcacafmr1519693pjo.30.1713421517981; Wed, 17
 Apr 2024 23:25:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com> <20240411025127.51945-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240411025127.51945-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Apr 2024 14:25:06 +0800
Message-ID: <CACGkMEvhejnVM=x2+PxnKXcyC4W4nAbhkt4-reWb-7=fYQ6qKw@mail.gmail.com>
Subject: Re: [PATCH vhost 4/6] virtio_net: big mode support premapped
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
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
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 98 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 81 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4446fb54de6d..7ea7e9bcd5d7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -50,6 +50,7 @@ module_param(napi_tx, bool, 0644);
>
>  #define page_chain_next(p)     ((struct page *)((p)->pp))
>  #define page_chain_add(p, n)   ((p)->pp =3D (void *)n)
> +#define page_dma_addr(p)       ((p)->dma_addr)
>
>  /* RX packet size EWMA. The average packet size is used to determine the=
 packet
>   * buffer size when refilling RX rings. As the entire RX ring may be ref=
illed
> @@ -434,6 +435,46 @@ skb_vnet_common_hdr(struct sk_buff *skb)
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
> +static void page_chain_unmap(struct receive_queue *rq, struct page *p)
> +{
> +       virtqueue_dma_unmap_page_attrs(rq->vq, page_dma_addr(p), PAGE_SIZ=
E,
> +                                      DMA_FROM_DEVICE, 0);
> +
> +       page_dma_addr(p) =3D DMA_MAPPING_ERROR;
> +}
> +
> +static int page_chain_map(struct receive_queue *rq, struct page *p)
> +{
> +       dma_addr_t addr;
> +
> +       addr =3D virtqueue_dma_map_page_attrs(rq->vq, p, 0, PAGE_SIZE, DM=
A_FROM_DEVICE, 0);
> +       if (virtqueue_dma_mapping_error(rq->vq, addr))
> +               return -ENOMEM;
> +
> +       page_dma_addr(p) =3D addr;
> +       return 0;
> +}
> +
> +static void page_chain_release(struct receive_queue *rq)
> +{
> +       struct page *p, *n;
> +
> +       for (p =3D rq->pages; p; p =3D n) {
> +               n =3D page_chain_next(p);
> +
> +               page_chain_unmap(rq, p);
> +               __free_pages(p, 0);
> +       }
> +
> +       rq->pages =3D NULL;
> +}
> +
>  /*
>   * put the whole most recent used list in the beginning for reuse
>   */
> @@ -441,6 +482,13 @@ static void give_pages(struct receive_queue *rq, str=
uct page *page)
>  {
>         struct page *end;
>
> +       if (page_dma_addr(page) =3D=3D DMA_MAPPING_ERROR) {

This looks strange, the map should be done during allocation. Under
which condition could we hit this?

> +               if (page_chain_map(rq, page)) {
> +                       __free_pages(page, 0);
> +                       return;
> +               }
> +       }
> +
>         /* Find end of list, sew whole thing into vi->rq.pages. */
>         for (end =3D page; page_chain_next(end); end =3D page_chain_next(=
end));
>
> @@ -456,8 +504,15 @@ static struct page *get_a_page(struct receive_queue =
*rq, gfp_t gfp_mask)
>                 rq->pages =3D page_chain_next(p);
>                 /* clear chain here, it is used to chain pages */
>                 page_chain_add(p, NULL);
> -       } else
> +       } else {
>                 p =3D alloc_page(gfp_mask);
> +
> +               if (page_chain_map(rq, p)) {
> +                       __free_pages(p, 0);
> +                       return NULL;
> +               }
> +       }
> +
>         return p;
>  }
>
> @@ -613,8 +668,6 @@ static struct sk_buff *page_to_skb(struct virtnet_inf=
o *vi,
>                         return NULL;
>
>                 page =3D page_chain_next(page);
> -               if (page)
> -                       give_pages(rq, page);
>                 goto ok;
>         }
>
> @@ -640,6 +693,7 @@ static struct sk_buff *page_to_skb(struct virtnet_inf=
o *vi,
>                         skb_add_rx_frag(skb, 0, page, offset, len, truesi=
ze);
>                 else
>                         page_to_free =3D page;
> +               page =3D NULL;
>                 goto ok;
>         }
>
> @@ -657,6 +711,11 @@ static struct sk_buff *page_to_skb(struct virtnet_in=
fo *vi,
>         BUG_ON(offset >=3D PAGE_SIZE);
>         while (len) {
>                 unsigned int frag_size =3D min((unsigned)PAGE_SIZE - offs=
et, len);
> +
> +               /* unmap the page before using it. */
> +               if (!offset)
> +                       page_chain_unmap(rq, page);
> +

This sounds strange, do we need a virtqueue_sync_for_cpu() helper here?

>                 skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, off=
set,
>                                 frag_size, truesize);
>                 len -=3D frag_size;
> @@ -664,15 +723,15 @@ static struct sk_buff *page_to_skb(struct virtnet_i=
nfo *vi,
>                 offset =3D 0;
>         }
>
> -       if (page)
> -               give_pages(rq, page);
> -
>  ok:
>         hdr =3D skb_vnet_common_hdr(skb);
>         memcpy(hdr, hdr_p, hdr_len);
>         if (page_to_free)
>                 put_page(page_to_free);
>
> +       if (page)
> +               give_pages(rq, page);
> +
>         return skb;
>  }
>
> @@ -823,7 +882,8 @@ static void virtnet_rq_unmap_free_buf(struct virtqueu=
e *vq, void *buf)
>
>         rq =3D &vi->rq[i];
>
> -       if (rq->do_dma)
> +       /* Skip the unmap for big mode. */
> +       if (!vi->big_packets || vi->mergeable_rx_bufs)
>                 virtnet_rq_unmap(rq, buf, 0);
>
>         virtnet_rq_free_buf(vi, rq, buf);
> @@ -1346,8 +1406,12 @@ static struct sk_buff *receive_big(struct net_devi=
ce *dev,
>                                    struct virtnet_rq_stats *stats)
>  {
>         struct page *page =3D buf;
> -       struct sk_buff *skb =3D
> -               page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
> +       struct sk_buff *skb;
> +
> +       /* Unmap first page. The follow code may read this page. */
> +       page_chain_unmap(rq, page);

And probably here as well.

Thanks


