Return-Path: <netdev+bounces-90756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D068AFE91
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 04:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8E21C2190F
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 02:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E903B83A10;
	Wed, 24 Apr 2024 02:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hOKx1lZ/"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130E183A19
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 02:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713926512; cv=none; b=dDTNab+qQl6z1Ygn/ID6UWzOrpZf4h1znRSx+vC8llkvkgXNGkqVComGdj2uv9MIZKiZSRg4wuoOTkJA6nhSc6qIkzL/AfDddNBUdVAhB+z5OrvPUgLBfHuUgt/lD78YEhKMxDMVOY84A9utk5TDfJvx2vhgINb7ayky7U5VGOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713926512; c=relaxed/simple;
	bh=buTiMV2ftYlqE79E0LoBGYdK2Bh3yp3XWW5qg4wrkiI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=NRM4LtwvtTgaZY2+b9U3H/PRSJGWfOlpbZQR91Qdrs49HB4xNeFW9u2188McFzRNp93H+nbur0dwfWlGZGkE/w8GIEpJtSJ0lQK/HKUFAvZHuEwqciylfF1rs4DE5WxhTSClfxjZ1/VvLLAO9iQwZ3Sj9lR/229z+nPL/EDscR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hOKx1lZ/; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713926507; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=TEVqWVDSoS3QAyhMSLk4j1xzN2LSXFSWa8yzE48gNCE=;
	b=hOKx1lZ/7/SNKnw1og1ON68qz9JOmxfiqZ9NSY/dw45GXFL6fbjtNa7xhImkVVR9Wdj7i0VfQZyFN/CBzT1ag9VM07CxLD3QbTNQmPBZq2A6Uejl7KnLnQAGf75hZc9PyiISN+7lCzd+ivV/RoDbBPylF/+v92qn62rBz1oFlWE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W5AbrlT_1713926505;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5AbrlT_1713926505)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 10:41:46 +0800
Message-ID: <1713926353.64557-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v2 4/7] virtio_net: big mode support premapped
Date: Wed, 24 Apr 2024 10:39:13 +0800
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
 <1713919985.3490202-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEu21VCPnuNM-MURnq40LKxysOJD0aJhPQE4Dbt2qT5rEg@mail.gmail.com>
In-Reply-To: <CACGkMEu21VCPnuNM-MURnq40LKxysOJD0aJhPQE4Dbt2qT5rEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 24 Apr 2024 10:34:56 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Apr 24, 2024 at 9:10=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Wed, 24 Apr 2024 08:43:21 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Tue, Apr 23, 2024 at 8:38=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > On Tue, 23 Apr 2024 12:36:42 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Mon, Apr 22, 2024 at 3:24=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux=
.alibaba.com> wrote:
> > > > > >
> > > > > > In big mode, pre-mapping DMA is beneficial because if the pages=
 are not
> > > > > > used, we can reuse them without needing to unmap and remap.
> > > > > >
> > > > > > We require space to store the DMA address. I use the page.dma_a=
ddr to
> > > > > > store the DMA address from the pp structure inside the page.
> > > > > >
> > > > > > Every page retrieved from get_a_page() is mapped, and its DMA a=
ddress is
> > > > > > stored in page.dma_addr. When a page is returned to the chain, =
we check
> > > > > > the DMA status; if it is not mapped (potentially having been un=
mapped),
> > > > > > we remap it before returning it to the chain.
> > > > > >
> > > > > > Based on the following points, we do not use page pool to manag=
e these
> > > > > > pages:
> > > > > >
> > > > > > 1. virtio-net uses the DMA APIs wrapped by virtio core. Therefo=
re,
> > > > > >    we can only prevent the page pool from performing DMA operat=
ions, and
> > > > > >    let the driver perform DMA operations on the allocated pages.
> > > > > > 2. But when the page pool releases the page, we have no chance =
to
> > > > > >    execute dma unmap.
> > > > > > 3. A solution to #2 is to execute dma unmap every time before p=
utting
> > > > > >    the page back to the page pool. (This is actually a waste, w=
e don't
> > > > > >    execute unmap so frequently.)
> > > > > > 4. But there is another problem, we still need to use page.dma_=
addr to
> > > > > >    save the dma address. Using page.dma_addr while using page p=
ool is
> > > > > >    unsafe behavior.
> > > > > >
> > > > > > More:
> > > > > >     https://lore.kernel.org/all/CACGkMEu=3DAok9z2imB_c5qVuujSh=
=3Dvjj1kx12fy9N7hqyi+M5Ow@mail.gmail.com/
> > > > > >
> > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > ---
> > > > > >  drivers/net/virtio_net.c | 123 +++++++++++++++++++++++++++++++=
+++-----
> > > > > >  1 file changed, 108 insertions(+), 15 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > index 2c7a67ad4789..d4f5e65b247e 100644
> > > > > > --- a/drivers/net/virtio_net.c
> > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > @@ -439,6 +439,81 @@ skb_vnet_common_hdr(struct sk_buff *skb)
> > > > > >         return (struct virtio_net_common_hdr *)skb->cb;
> > > > > >  }
> > > > > >
> > > > > > +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t add=
r, u32 len)
> > > > > > +{
> > > > > > +       sg->dma_address =3D addr;
> > > > > > +       sg->length =3D len;
> > > > > > +}
> > > > > > +
> > > > > > +/* For pages submitted to the ring, we need to record its dma =
for unmap.
> > > > > > + * Here, we use the page.dma_addr and page.pp_magic to store t=
he dma
> > > > > > + * address.
> > > > > > + */
> > > > > > +static void page_chain_set_dma(struct page *p, dma_addr_t addr)
> > > > > > +{
> > > > > > +       if (sizeof(dma_addr_t) > sizeof(unsigned long)) {
> > > > >
> > > > > Need a macro like PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA.
> > > > >
> > > > > > +               p->dma_addr =3D lower_32_bits(addr);
> > > > > > +               p->pp_magic =3D upper_32_bits(addr);
> > > > >
> > > > > And this uses three fields on page_pool which I'm not sure the ot=
her
> > > > > maintainers are happy with. For example, re-using pp_maing might =
be
> > > > > dangerous. See c07aea3ef4d40 ("mm: add a signature in struct page=
").
> > > > >
> > > > > I think a more safe way is to reuse page pool, for example introd=
ucing
> > > > > a new flag with dma callbacks?
> > > >
> > > > If we use page pool, how can we chain the pages allocated for a pac=
ket?
> > >
> > > I'm not sure I get this, it is chained via the descriptor flag.
> >
> >
> > In the big mode, we will commit many pages to the virtio core by
> > virtqueue_add_inbuf().
> >
> > By virtqueue_get_buf_ctx(), we got the data. That is the first page.
> > Other pages are chained by the "private".
> >
> > If we use the page pool, how can we chain the pages.
> > After virtqueue_add_inbuf(), we need to get the pages to fill the skb.
>
> Right, technically it could be solved by providing helpers in the
> virtio core, but considering it's an optimization for big mode which
> is not popular, it's not worth to bother.
>
> >
> >
> >
> > >
> > > >
> > > > Yon know the "private" can not be used.
> > > >
> > > >
> > > > If the pp struct inside the page is not safe, how about:
> > > >
> > > >                 struct {        /* Page cache and anonymous pages */
> > > >                         /**
> > > >                          * @lru: Pageout list, eg. active_list prot=
ected by
> > > >                          * lruvec->lru_lock.  Sometimes used as a g=
eneric list
> > > >                          * by the page owner.
> > > >                          */
> > > >                         union {
> > > >                                 struct list_head lru;
> > > >
> > > >                                 /* Or, for the Unevictable "LRU lis=
t" slot */
> > > >                                 struct {
> > > >                                         /* Always even, to negate P=
ageTail */
> > > >                                         void *__filler;
> > > >                                         /* Count page's or folio's =
mlocks */
> > > >                                         unsigned int mlock_count;
> > > >                                 };
> > > >
> > > >                                 /* Or, free page */
> > > >                                 struct list_head buddy_list;
> > > >                                 struct list_head pcp_list;
> > > >                         };
> > > >                         /* See page-flags.h for PAGE_MAPPING_FLAGS =
*/
> > > >                         struct address_space *mapping;
> > > >                         union {
> > > >                                 pgoff_t index;          /* Our offs=
et within mapping. */
> > > >                                 unsigned long share;    /* share co=
unt for fsdax */
> > > >                         };
> > > >                         /**
> > > >                          * @private: Mapping-private opaque data.
> > > >                          * Usually used for buffer_heads if PagePri=
vate.
> > > >                          * Used for swp_entry_t if PageSwapCache.
> > > >                          * Indicates order in the buddy system if P=
ageBuddy.
> > > >                          */
> > > >                         unsigned long private;
> > > >                 };
> > > >
> > > > Or, we can map the private space of the page as a new structure.
> > >
> > > It could be a way. But such allocation might be huge if we are using
> > > indirect descriptors or I may miss something.
> >
> > No. we only need to store the "chain next" and the dma as this patch se=
t did.
> > The size of the private space inside the page is  20(32bit)/40(64bit) b=
ytes.
> > That is enough for us.
> >
> > If you worry about the change of the pp structure, we can use the "priv=
ate" as
> > origin and use the "struct list_head lru" to store the dma.
>
> This looks even worse, as it uses fields belonging to the different
> structures in the union.

I mean we do not use the elems from the pp structure inside the page,
if we worry the change of the pp structure.

I mean use the "private" and "lru", these in the same structure.

I think this is a good way.

Thanks.

>
> >
> > The min size of "struct list_head lru" is 8 bytes, that is enough for t=
he
> > dma_addr_t.
> >
> > We can do this more simper:
> >
> > static void page_chain_set_dma(struct page *p, dma_addr_t dma)
> > {
> >         BUILD_BUG_ON(sizeof(p->lru)) < sizeof(dma));
> >
> >         dma_addr_t *addr;
> >
> >         addr =3D &page->lru;
> >
> >         *addr =3D dma;
> > }
>
> So we had this in the kernel code.
>
>        /*
>          * Five words (20/40 bytes) are available in this union.
>          * WARNING: bit 0 of the first word is used for PageTail(). That
>          * means the other users of this union MUST NOT use the bit to
>          * avoid collision and false-positive PageTail().
>          */
>
> And by looking at the discussion that introduces the pp_magic, reusing
> fields seems to be tricky as we may end up with side effects of
> aliasing fields in page structure. Technically, we can invent new
> structures in the union, but it might not be worth it to bother.
>
> So I think we can leave the fallback code and revisit this issue in the f=
uture.
>
> Thanks
>
> >
> > Thanks.
> >
> >
> >
> > >
> > > Thanks
> > >
> > > >
> > > > Thanks.
> > > >
> > > >
> > > > >
> > > > > Thanks
> > > > >
> > > >
> > >
> >
>

