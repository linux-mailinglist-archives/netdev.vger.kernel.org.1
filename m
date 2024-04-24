Return-Path: <netdev+bounces-90728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2D18AFD96
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 03:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7137282DD6
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 01:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD99538A;
	Wed, 24 Apr 2024 01:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VP78RmlD"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196F9568A
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 01:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713920992; cv=none; b=DsKpYC+lzdQ9wRbhD0p+ym93wxt0+p4ScvjypHbFQdn7ca9aBTy9cwjc4P5kLQ8iVATemV/WS/HgNSdjxbyKCJE6Jiz9wrpTfcxnU3LERDrfnrcHvkhcOLpFa2qqvI5WgiauDVqakcd96Q+cHLR6hUgyibGl5xkDLKigQzZ/Rlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713920992; c=relaxed/simple;
	bh=i4VC88NMsw0kRrws/BpaVN2NQ2hM2dWJeu/nn+ZOy0s=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=nI+y2sRn3u73lrlmEcH5EDzo0PIIfDXMVLa+3mZYA7+3In+0uoRUTOkYdklx0ffjGW4pvzVSXgapLzMbP4ThvXgb46Q2WSCzaQiJ+/nju53nrJDwxQOX+njHEh2X1N6ZbWQpS24V6IN/x2JeDt/U8FagyVo/McUVCvoPyejL5Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VP78RmlD; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713920986; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=GCZOyXnsBavAtLpXf1Crt3mG5AmPXtFHZ00VZxSsq5M=;
	b=VP78RmlDm1mSdip/8LEYIS7n8/zVOii0aG3wzajl9aa650noWphGCGuB7+yeuF5d6GPBUuNO4Qk9+u5NghppFUWKCH8FZBOq7H/f8EZaSaNSCKjNVOd0s/K/s2OwEaEHmkNH8eHYf0hLVlljLZ1Ae4zB0XJeeGFfwx9k9dkmv/o=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W5ARj6O_1713920984;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5ARj6O_1713920984)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 09:09:46 +0800
Message-ID: <1713919985.3490202-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v2 4/7] virtio_net: big mode support premapped
Date: Wed, 24 Apr 2024 08:53:05 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20240422072408.126821-1-xuanzhuo@linux.alibaba.com>
 <20240422072408.126821-5-xuanzhuo@linux.alibaba.com>
 <CACGkMEuEYwR_QE-hhnD0KYujD6MVEArz3FPyjsfmJ-jk_02hZw@mail.gmail.com>
 <1713875473.8690095-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEs=6Xfc1hELudF=+xvoJN+npQw11BqP0jjCxmUy2jaikg@mail.gmail.com>
In-Reply-To: <CACGkMEs=6Xfc1hELudF=+xvoJN+npQw11BqP0jjCxmUy2jaikg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 24 Apr 2024 08:43:21 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Apr 23, 2024 at 8:38=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Tue, 23 Apr 2024 12:36:42 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Mon, Apr 22, 2024 at 3:24=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > In big mode, pre-mapping DMA is beneficial because if the pages are=
 not
> > > > used, we can reuse them without needing to unmap and remap.
> > > >
> > > > We require space to store the DMA address. I use the page.dma_addr =
to
> > > > store the DMA address from the pp structure inside the page.
> > > >
> > > > Every page retrieved from get_a_page() is mapped, and its DMA addre=
ss is
> > > > stored in page.dma_addr. When a page is returned to the chain, we c=
heck
> > > > the DMA status; if it is not mapped (potentially having been unmapp=
ed),
> > > > we remap it before returning it to the chain.
> > > >
> > > > Based on the following points, we do not use page pool to manage th=
ese
> > > > pages:
> > > >
> > > > 1. virtio-net uses the DMA APIs wrapped by virtio core. Therefore,
> > > >    we can only prevent the page pool from performing DMA operations=
, and
> > > >    let the driver perform DMA operations on the allocated pages.
> > > > 2. But when the page pool releases the page, we have no chance to
> > > >    execute dma unmap.
> > > > 3. A solution to #2 is to execute dma unmap every time before putti=
ng
> > > >    the page back to the page pool. (This is actually a waste, we do=
n't
> > > >    execute unmap so frequently.)
> > > > 4. But there is another problem, we still need to use page.dma_addr=
 to
> > > >    save the dma address. Using page.dma_addr while using page pool =
is
> > > >    unsafe behavior.
> > > >
> > > > More:
> > > >     https://lore.kernel.org/all/CACGkMEu=3DAok9z2imB_c5qVuujSh=3Dvj=
j1kx12fy9N7hqyi+M5Ow@mail.gmail.com/
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >  drivers/net/virtio_net.c | 123 ++++++++++++++++++++++++++++++++++-=
----
> > > >  1 file changed, 108 insertions(+), 15 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 2c7a67ad4789..d4f5e65b247e 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -439,6 +439,81 @@ skb_vnet_common_hdr(struct sk_buff *skb)
> > > >         return (struct virtio_net_common_hdr *)skb->cb;
> > > >  }
> > > >
> > > > +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u=
32 len)
> > > > +{
> > > > +       sg->dma_address =3D addr;
> > > > +       sg->length =3D len;
> > > > +}
> > > > +
> > > > +/* For pages submitted to the ring, we need to record its dma for =
unmap.
> > > > + * Here, we use the page.dma_addr and page.pp_magic to store the d=
ma
> > > > + * address.
> > > > + */
> > > > +static void page_chain_set_dma(struct page *p, dma_addr_t addr)
> > > > +{
> > > > +       if (sizeof(dma_addr_t) > sizeof(unsigned long)) {
> > >
> > > Need a macro like PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA.
> > >
> > > > +               p->dma_addr =3D lower_32_bits(addr);
> > > > +               p->pp_magic =3D upper_32_bits(addr);
> > >
> > > And this uses three fields on page_pool which I'm not sure the other
> > > maintainers are happy with. For example, re-using pp_maing might be
> > > dangerous. See c07aea3ef4d40 ("mm: add a signature in struct page").
> > >
> > > I think a more safe way is to reuse page pool, for example introducing
> > > a new flag with dma callbacks?
> >
> > If we use page pool, how can we chain the pages allocated for a packet?
>
> I'm not sure I get this, it is chained via the descriptor flag.


In the big mode, we will commit many pages to the virtio core by
virtqueue_add_inbuf().

By virtqueue_get_buf_ctx(), we got the data. That is the first page.
Other pages are chained by the "private".

If we use the page pool, how can we chain the pages.
After virtqueue_add_inbuf(), we need to get the pages to fill the skb.



>
> >
> > Yon know the "private" can not be used.
> >
> >
> > If the pp struct inside the page is not safe, how about:
> >
> >                 struct {        /* Page cache and anonymous pages */
> >                         /**
> >                          * @lru: Pageout list, eg. active_list protecte=
d by
> >                          * lruvec->lru_lock.  Sometimes used as a gener=
ic list
> >                          * by the page owner.
> >                          */
> >                         union {
> >                                 struct list_head lru;
> >
> >                                 /* Or, for the Unevictable "LRU list" s=
lot */
> >                                 struct {
> >                                         /* Always even, to negate PageT=
ail */
> >                                         void *__filler;
> >                                         /* Count page's or folio's mloc=
ks */
> >                                         unsigned int mlock_count;
> >                                 };
> >
> >                                 /* Or, free page */
> >                                 struct list_head buddy_list;
> >                                 struct list_head pcp_list;
> >                         };
> >                         /* See page-flags.h for PAGE_MAPPING_FLAGS */
> >                         struct address_space *mapping;
> >                         union {
> >                                 pgoff_t index;          /* Our offset w=
ithin mapping. */
> >                                 unsigned long share;    /* share count =
for fsdax */
> >                         };
> >                         /**
> >                          * @private: Mapping-private opaque data.
> >                          * Usually used for buffer_heads if PagePrivate.
> >                          * Used for swp_entry_t if PageSwapCache.
> >                          * Indicates order in the buddy system if PageB=
uddy.
> >                          */
> >                         unsigned long private;
> >                 };
> >
> > Or, we can map the private space of the page as a new structure.
>
> It could be a way. But such allocation might be huge if we are using
> indirect descriptors or I may miss something.

No. we only need to store the "chain next" and the dma as this patch set di=
d.
The size of the private space inside the page is  20(32bit)/40(64bit) bytes.
That is enough for us.

If you worry about the change of the pp structure, we can use the "private"=
 as
origin and use the "struct list_head lru" to store the dma.

The min size of "struct list_head lru" is 8 bytes, that is enough for the
dma_addr_t.

We can do this more simper:

static void page_chain_set_dma(struct page *p, dma_addr_t dma)
{
	BUILD_BUG_ON(sizeof(p->lru)) < sizeof(dma));

	dma_addr_t *addr;

	addr =3D &page->lru;

	*addr =3D dma;
}

Thanks.



>
> Thanks
>
> >
> > Thanks.
> >
> >
> > >
> > > Thanks
> > >
> >
>

