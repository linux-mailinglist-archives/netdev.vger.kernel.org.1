Return-Path: <netdev+bounces-89059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3984C8A951A
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 10:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4227D1C20FC9
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 08:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D70158203;
	Thu, 18 Apr 2024 08:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kRhQex/u"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13FF1E489
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713429341; cv=none; b=j7n/mXBdJobodc7lS5tMeYMnw2PKErt+f0z6OHpgiaDnPbQ3Mqo4f4lItzS/Ya67bgaFsQXTsPIPuu5KwSeb+pphfSD6AOwrrRkjnyYH4HwJnCPbw5qJvhOYg3lGFwmllSvZKkfqM8+xTiuLbge4ofShuVt5c4CarSd+cASESQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713429341; c=relaxed/simple;
	bh=V/k0WEIDu72YYkkPSJmFjukR7Uw2O969ito/jnM6UEI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=C0I5sLfekQnhxFlq+tR2a+HmromTDgxGuIEFUmjVkhT1vtRz9stlbxy/EsPwfsk4ya+m5aP4JNdADQKIySSK0K3Bl1l5IFzFdbEz2kx+82hQZKPsPPyZ+VU1a/2yYOvrkWxGbncOSu+LxUymYl9u16NH44ZKd5ssRstqToV+nBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kRhQex/u; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713429331; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=M6IfKZ+ZxLHy43sVUvdticf/NrPtCVNvw4V8f4+qNkE=;
	b=kRhQex/u0HQBzAb0oP25K0+J5fFqPrB/51ySBDqH3nuspjb5TPJSkFevRKy1UVhpQsV3irJL4O1h1CdTekX3vRk2BEy2eIo812Bg6k6z34Ax0hSe7m4QBlvclL0Nuh+OLSPCbp1ZyiRqbF2PbWqMbgORLfinN18qXWfmMsgNj8A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W4ny0fe_1713429329;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4ny0fe_1713429329)
          by smtp.aliyun-inc.com;
          Thu, 18 Apr 2024 16:35:30 +0800
Message-ID: <1713428960.80807-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 4/6] virtio_net: big mode support premapped
Date: Thu, 18 Apr 2024 16:29:20 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com>
 <20240411025127.51945-5-xuanzhuo@linux.alibaba.com>
 <CACGkMEvhejnVM=x2+PxnKXcyC4W4nAbhkt4-reWb-7=fYQ6qKw@mail.gmail.com>
In-Reply-To: <CACGkMEvhejnVM=x2+PxnKXcyC4W4nAbhkt4-reWb-7=fYQ6qKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 18 Apr 2024 14:25:06 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> >
> > In big mode, pre-mapping DMA is beneficial because if the pages are not
> > used, we can reuse them without needing to unmap and remap.
> >
> > We require space to store the DMA address. I use the page.dma_addr to
> > store the DMA address from the pp structure inside the page.
> >
> > Every page retrieved from get_a_page() is mapped, and its DMA address is
> > stored in page.dma_addr. When a page is returned to the chain, we check
> > the DMA status; if it is not mapped (potentially having been unmapped),
> > we remap it before returning it to the chain.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 98 +++++++++++++++++++++++++++++++++-------
> >  1 file changed, 81 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 4446fb54de6d..7ea7e9bcd5d7 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -50,6 +50,7 @@ module_param(napi_tx, bool, 0644);
> >
> >  #define page_chain_next(p)     ((struct page *)((p)->pp))
> >  #define page_chain_add(p, n)   ((p)->pp =3D (void *)n)
> > +#define page_dma_addr(p)       ((p)->dma_addr)
> >
> >  /* RX packet size EWMA. The average packet size is used to determine t=
he packet
> >   * buffer size when refilling RX rings. As the entire RX ring may be r=
efilled
> > @@ -434,6 +435,46 @@ skb_vnet_common_hdr(struct sk_buff *skb)
> >         return (struct virtio_net_common_hdr *)skb->cb;
> >  }
> >
> > +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 l=
en)
> > +{
> > +       sg->dma_address =3D addr;
> > +       sg->length =3D len;
> > +}
> > +
> > +static void page_chain_unmap(struct receive_queue *rq, struct page *p)
> > +{
> > +       virtqueue_dma_unmap_page_attrs(rq->vq, page_dma_addr(p), PAGE_S=
IZE,
> > +                                      DMA_FROM_DEVICE, 0);
> > +
> > +       page_dma_addr(p) =3D DMA_MAPPING_ERROR;
> > +}
> > +
> > +static int page_chain_map(struct receive_queue *rq, struct page *p)
> > +{
> > +       dma_addr_t addr;
> > +
> > +       addr =3D virtqueue_dma_map_page_attrs(rq->vq, p, 0, PAGE_SIZE, =
DMA_FROM_DEVICE, 0);
> > +       if (virtqueue_dma_mapping_error(rq->vq, addr))
> > +               return -ENOMEM;
> > +
> > +       page_dma_addr(p) =3D addr;
> > +       return 0;
> > +}
> > +
> > +static void page_chain_release(struct receive_queue *rq)
> > +{
> > +       struct page *p, *n;
> > +
> > +       for (p =3D rq->pages; p; p =3D n) {
> > +               n =3D page_chain_next(p);
> > +
> > +               page_chain_unmap(rq, p);
> > +               __free_pages(p, 0);
> > +       }
> > +
> > +       rq->pages =3D NULL;
> > +}
> > +
> >  /*
> >   * put the whole most recent used list in the beginning for reuse
> >   */
> > @@ -441,6 +482,13 @@ static void give_pages(struct receive_queue *rq, s=
truct page *page)
> >  {
> >         struct page *end;
> >
> > +       if (page_dma_addr(page) =3D=3D DMA_MAPPING_ERROR) {
>
> This looks strange, the map should be done during allocation. Under
> which condition could we hit this?

This first page is umapped before we call page_to_skb().
The page can be put back to the link in case of failure.


>
> > +               if (page_chain_map(rq, page)) {
> > +                       __free_pages(page, 0);
> > +                       return;
> > +               }
> > +       }
> > +
> >         /* Find end of list, sew whole thing into vi->rq.pages. */
> >         for (end =3D page; page_chain_next(end); end =3D page_chain_nex=
t(end));
> >
> > @@ -456,8 +504,15 @@ static struct page *get_a_page(struct receive_queu=
e *rq, gfp_t gfp_mask)
> >                 rq->pages =3D page_chain_next(p);
> >                 /* clear chain here, it is used to chain pages */
> >                 page_chain_add(p, NULL);
> > -       } else
> > +       } else {
> >                 p =3D alloc_page(gfp_mask);
> > +
> > +               if (page_chain_map(rq, p)) {
> > +                       __free_pages(p, 0);
> > +                       return NULL;
> > +               }
> > +       }
> > +
> >         return p;
> >  }
> >
> > @@ -613,8 +668,6 @@ static struct sk_buff *page_to_skb(struct virtnet_i=
nfo *vi,
> >                         return NULL;
> >
> >                 page =3D page_chain_next(page);
> > -               if (page)
> > -                       give_pages(rq, page);
> >                 goto ok;
> >         }
> >
> > @@ -640,6 +693,7 @@ static struct sk_buff *page_to_skb(struct virtnet_i=
nfo *vi,
> >                         skb_add_rx_frag(skb, 0, page, offset, len, true=
size);
> >                 else
> >                         page_to_free =3D page;
> > +               page =3D NULL;
> >                 goto ok;
> >         }
> >
> > @@ -657,6 +711,11 @@ static struct sk_buff *page_to_skb(struct virtnet_=
info *vi,
> >         BUG_ON(offset >=3D PAGE_SIZE);
> >         while (len) {
> >                 unsigned int frag_size =3D min((unsigned)PAGE_SIZE - of=
fset, len);
> > +
> > +               /* unmap the page before using it. */
> > +               if (!offset)
> > +                       page_chain_unmap(rq, page);
> > +
>
> This sounds strange, do we need a virtqueue_sync_for_cpu() helper here?

I think we do not need that. Because the umap api does it.
We do not work with DMA_SKIP_SYNC;

Thanks.


>
> >                 skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, o=
ffset,
> >                                 frag_size, truesize);
> >                 len -=3D frag_size;
> > @@ -664,15 +723,15 @@ static struct sk_buff *page_to_skb(struct virtnet=
_info *vi,
> >                 offset =3D 0;
> >         }
> >
> > -       if (page)
> > -               give_pages(rq, page);
> > -
> >  ok:
> >         hdr =3D skb_vnet_common_hdr(skb);
> >         memcpy(hdr, hdr_p, hdr_len);
> >         if (page_to_free)
> >                 put_page(page_to_free);
> >
> > +       if (page)
> > +               give_pages(rq, page);
> > +
> >         return skb;
> >  }
> >
> > @@ -823,7 +882,8 @@ static void virtnet_rq_unmap_free_buf(struct virtqu=
eue *vq, void *buf)
> >
> >         rq =3D &vi->rq[i];
> >
> > -       if (rq->do_dma)
> > +       /* Skip the unmap for big mode. */
> > +       if (!vi->big_packets || vi->mergeable_rx_bufs)
> >                 virtnet_rq_unmap(rq, buf, 0);
> >
> >         virtnet_rq_free_buf(vi, rq, buf);
> > @@ -1346,8 +1406,12 @@ static struct sk_buff *receive_big(struct net_de=
vice *dev,
> >                                    struct virtnet_rq_stats *stats)
> >  {
> >         struct page *page =3D buf;
> > -       struct sk_buff *skb =3D
> > -               page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
> > +       struct sk_buff *skb;
> > +
> > +       /* Unmap first page. The follow code may read this page. */
> > +       page_chain_unmap(rq, page);
>
> And probably here as well.
>
> Thanks
>

