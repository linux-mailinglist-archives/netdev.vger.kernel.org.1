Return-Path: <netdev+bounces-90778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081C48B013B
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 07:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 719C2B2237D
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 05:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42B3156867;
	Wed, 24 Apr 2024 05:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jZCOv6CX"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C8843AB4
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 05:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713937448; cv=none; b=CwWzp8M7Tvpi7HZzjbjBJPlJkJ6qYtmDBW4kmgL+sll8MrezCjwJnQRlMqZFEqAkGCGtu/W+okk7qOeUtlCKA7lUlrWfj0TH9MGiN8MzSGPwp9hf/ybKqsCkUbjRavpRZOhVp0/25SEjkEUXPZrueKlw1VFxvIWNa++dda3wgiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713937448; c=relaxed/simple;
	bh=1vWNqygLADydrdIxLJ9ikqTvzsoSpz6bxQNMkZLDV0I=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=APkWUv3g4r1eVwAEaqRUW6t8cJ+PRjyVZrziE7ZatNFMjMQA27Kav9kzydm2w2rX3RUxlnYSV3bT4lbVi3lE349bGxwsspmlpefMcsTojzXguxaSfBz+N8Fpm4ClX2n+fA448SjTHRcK2gH+W75/9JB997prU6h+YPYRLk1GBhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jZCOv6CX; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713937441; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=HnVF3WvUX8wjRug43QDj6IL+8ejLqr7wchEvJst78mw=;
	b=jZCOv6CXi6S4KLnVu75rEJx7ZXCd18sLfi4aQBNd6jzpReOjDyZ+S0nhtYEQXOj+vSbmEookkilC53ygWQXIBbSivMFLT7kNb68xAG0kUooyYszjQjaQiK5wCiHnr6NHymw4XMhnMq25WD7Hx1qSKBsbijGsIutGiU4QUUtAiMU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W5BGozN_1713937439;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5BGozN_1713937439)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 13:44:00 +0800
Message-ID: <1713937418.3984292-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v2 4/7] virtio_net: big mode support premapped
Date: Wed, 24 Apr 2024 13:43:38 +0800
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
 <1713926353.64557-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEvtvtauHk5TXM4Yo3X7Fi99Rjnu43OeZiX4zZU+M_akaw@mail.gmail.com>
 <1713927254.7707088-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEuyeJ9mMgYnnB42=hw6umNuo=agn7VBqBqYPd7GN=+39Q@mail.gmail.com>
In-Reply-To: <CACGkMEuyeJ9mMgYnnB42=hw6umNuo=agn7VBqBqYPd7GN=+39Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 24 Apr 2024 11:50:44 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Apr 24, 2024 at 10:58=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> >
> > On Wed, 24 Apr 2024 10:45:49 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Wed, Apr 24, 2024 at 10:42=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.al=
ibaba.com> wrote:
> > > >
> > > > On Wed, 24 Apr 2024 10:34:56 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Wed, Apr 24, 2024 at 9:10=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux=
.alibaba.com> wrote:
> > > > > >
> > > > > > On Wed, 24 Apr 2024 08:43:21 +0800, Jason Wang <jasowang@redhat=
.com> wrote:
> > > > > > > On Tue, Apr 23, 2024 at 8:38=E2=80=AFPM Xuan Zhuo <xuanzhuo@l=
inux.alibaba.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, 23 Apr 2024 12:36:42 +0800, Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > > > > On Mon, Apr 22, 2024 at 3:24=E2=80=AFPM Xuan Zhuo <xuanzh=
uo@linux.alibaba.com> wrote:
> > > > > > > > > >
> > > > > > > > > > In big mode, pre-mapping DMA is beneficial because if t=
he pages are not
> > > > > > > > > > used, we can reuse them without needing to unmap and re=
map.
> > > > > > > > > >
> > > > > > > > > > We require space to store the DMA address. I use the pa=
ge.dma_addr to
> > > > > > > > > > store the DMA address from the pp structure inside the =
page.
> > > > > > > > > >
> > > > > > > > > > Every page retrieved from get_a_page() is mapped, and i=
ts DMA address is
> > > > > > > > > > stored in page.dma_addr. When a page is returned to the=
 chain, we check
> > > > > > > > > > the DMA status; if it is not mapped (potentially having=
 been unmapped),
> > > > > > > > > > we remap it before returning it to the chain.
> > > > > > > > > >
> > > > > > > > > > Based on the following points, we do not use page pool =
to manage these
> > > > > > > > > > pages:
> > > > > > > > > >
> > > > > > > > > > 1. virtio-net uses the DMA APIs wrapped by virtio core.=
 Therefore,
> > > > > > > > > >    we can only prevent the page pool from performing DM=
A operations, and
> > > > > > > > > >    let the driver perform DMA operations on the allocat=
ed pages.
> > > > > > > > > > 2. But when the page pool releases the page, we have no=
 chance to
> > > > > > > > > >    execute dma unmap.
> > > > > > > > > > 3. A solution to #2 is to execute dma unmap every time =
before putting
> > > > > > > > > >    the page back to the page pool. (This is actually a =
waste, we don't
> > > > > > > > > >    execute unmap so frequently.)
> > > > > > > > > > 4. But there is another problem, we still need to use p=
age.dma_addr to
> > > > > > > > > >    save the dma address. Using page.dma_addr while usin=
g page pool is
> > > > > > > > > >    unsafe behavior.
> > > > > > > > > >
> > > > > > > > > > More:
> > > > > > > > > >     https://lore.kernel.org/all/CACGkMEu=3DAok9z2imB_c5=
qVuujSh=3Dvjj1kx12fy9N7hqyi+M5Ow@mail.gmail.com/
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > > > ---
> > > > > > > > > >  drivers/net/virtio_net.c | 123 +++++++++++++++++++++++=
+++++++++++-----
> > > > > > > > > >  1 file changed, 108 insertions(+), 15 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/vir=
tio_net.c
> > > > > > > > > > index 2c7a67ad4789..d4f5e65b247e 100644
> > > > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > > > @@ -439,6 +439,81 @@ skb_vnet_common_hdr(struct sk_buff=
 *skb)
> > > > > > > > > >         return (struct virtio_net_common_hdr *)skb->cb;
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > +static void sg_fill_dma(struct scatterlist *sg, dma_ad=
dr_t addr, u32 len)
> > > > > > > > > > +{
> > > > > > > > > > +       sg->dma_address =3D addr;
> > > > > > > > > > +       sg->length =3D len;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +/* For pages submitted to the ring, we need to record =
its dma for unmap.
> > > > > > > > > > + * Here, we use the page.dma_addr and page.pp_magic to=
 store the dma
> > > > > > > > > > + * address.
> > > > > > > > > > + */
> > > > > > > > > > +static void page_chain_set_dma(struct page *p, dma_add=
r_t addr)
> > > > > > > > > > +{
> > > > > > > > > > +       if (sizeof(dma_addr_t) > sizeof(unsigned long))=
 {
> > > > > > > > >
> > > > > > > > > Need a macro like PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA.
> > > > > > > > >
> > > > > > > > > > +               p->dma_addr =3D lower_32_bits(addr);
> > > > > > > > > > +               p->pp_magic =3D upper_32_bits(addr);
> > > > > > > > >
> > > > > > > > > And this uses three fields on page_pool which I'm not sur=
e the other
> > > > > > > > > maintainers are happy with. For example, re-using pp_main=
g might be
> > > > > > > > > dangerous. See c07aea3ef4d40 ("mm: add a signature in str=
uct page").
> > > > > > > > >
> > > > > > > > > I think a more safe way is to reuse page pool, for exampl=
e introducing
> > > > > > > > > a new flag with dma callbacks?
> > > > > > > >
> > > > > > > > If we use page pool, how can we chain the pages allocated f=
or a packet?
> > > > > > >
> > > > > > > I'm not sure I get this, it is chained via the descriptor fla=
g.
> > > > > >
> > > > > >
> > > > > > In the big mode, we will commit many pages to the virtio core by
> > > > > > virtqueue_add_inbuf().
> > > > > >
> > > > > > By virtqueue_get_buf_ctx(), we got the data. That is the first =
page.
> > > > > > Other pages are chained by the "private".
> > > > > >
> > > > > > If we use the page pool, how can we chain the pages.
> > > > > > After virtqueue_add_inbuf(), we need to get the pages to fill t=
he skb.
> > > > >
> > > > > Right, technically it could be solved by providing helpers in the
> > > > > virtio core, but considering it's an optimization for big mode wh=
ich
> > > > > is not popular, it's not worth to bother.
> > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > Yon know the "private" can not be used.
> > > > > > > >
> > > > > > > >
> > > > > > > > If the pp struct inside the page is not safe, how about:
> > > > > > > >
> > > > > > > >                 struct {        /* Page cache and anonymous=
 pages */
> > > > > > > >                         /**
> > > > > > > >                          * @lru: Pageout list, eg. active_l=
ist protected by
> > > > > > > >                          * lruvec->lru_lock.  Sometimes use=
d as a generic list
> > > > > > > >                          * by the page owner.
> > > > > > > >                          */
> > > > > > > >                         union {
> > > > > > > >                                 struct list_head lru;
> > > > > > > >
> > > > > > > >                                 /* Or, for the Unevictable =
"LRU list" slot */
> > > > > > > >                                 struct {
> > > > > > > >                                         /* Always even, to =
negate PageTail */
> > > > > > > >                                         void *__filler;
> > > > > > > >                                         /* Count page's or =
folio's mlocks */
> > > > > > > >                                         unsigned int mlock_=
count;
> > > > > > > >                                 };
> > > > > > > >
> > > > > > > >                                 /* Or, free page */
> > > > > > > >                                 struct list_head buddy_list;
> > > > > > > >                                 struct list_head pcp_list;
> > > > > > > >                         };
> > > > > > > >                         /* See page-flags.h for PAGE_MAPPIN=
G_FLAGS */
> > > > > > > >                         struct address_space *mapping;
> > > > > > > >                         union {
> > > > > > > >                                 pgoff_t index;          /* =
Our offset within mapping. */
> > > > > > > >                                 unsigned long share;    /* =
share count for fsdax */
> > > > > > > >                         };
> > > > > > > >                         /**
> > > > > > > >                          * @private: Mapping-private opaque=
 data.
> > > > > > > >                          * Usually used for buffer_heads if=
 PagePrivate.
> > > > > > > >                          * Used for swp_entry_t if PageSwap=
Cache.
> > > > > > > >                          * Indicates order in the buddy sys=
tem if PageBuddy.
> > > > > > > >                          */
> > > > > > > >                         unsigned long private;
> > > > > > > >                 };
> > > > > > > >
> > > > > > > > Or, we can map the private space of the page as a new struc=
ture.
> > > > > > >
> > > > > > > It could be a way. But such allocation might be huge if we ar=
e using
> > > > > > > indirect descriptors or I may miss something.
> > > > > >
> > > > > > No. we only need to store the "chain next" and the dma as this =
patch set did.
> > > > > > The size of the private space inside the page is  20(32bit)/40(=
64bit) bytes.
> > > > > > That is enough for us.
> > > > > >
> > > > > > If you worry about the change of the pp structure, we can use t=
he "private" as
> > > > > > origin and use the "struct list_head lru" to store the dma.
> > > > >
> > > > > This looks even worse, as it uses fields belonging to the differe=
nt
> > > > > structures in the union.
> > > >
> > > > I mean we do not use the elems from the pp structure inside the pag=
e,
> > > > if we worry the change of the pp structure.
> > > >
> > > > I mean use the "private" and "lru", these in the same structure.
> > > >
> > > > I think this is a good way.
> > > >
> > > > Thanks.
> > >
> > > See this:
> > >
> > > https://lore.kernel.org/netdev/20210411114307.5087f958@carbon/
> >
> >
> > I think that is because that the page pool will share the page with
> > the skbs.  I'm not entirely sure.
> >
> > In our case, virtio-net fully owns the page. After the page is referenc=
ed by skb,
> > virtio-net no longer references the page. I don't think there is any pr=
oblem
> > here.
>
> Well, in the rx path, though the page is allocated by the virtio-net,
> unlike the page pool, those pages are not freed by virtio-net. So it
> may leave things in the page structure which is problematic. I don't
> think we can introduce a virtio-net specific hook for kfree_skb() in
> this case. That's why I think leveraging the page pool is better.
>
> For reusing page pool. Maybe we can reuse __pp_mapping_pad for
> virtio-net specific use cases like chaining, and clear it in
> page_pool_clear_pp_info(). And we need to make sure we don't break
> things like TCP RX zerocopy since mapping is aliasied with
> __pp_mapping_pad at a first glance.
>
> >
> > The key is that who owns the page, who can use the page private space (=
20/40 bytes).
> >
> > Is that?
>
> I'm not saying we can't investigate in this direction. But it needs
> more comments from mm guys and we need to evaluate the price we pay
> for that.
>
> The motivation is to drop the fallback code when pre mapping is not
> supported to improve the maintainability of the code and ease the
> AF_XDP support for virtio-net. But it turns out to be not easy.
>
> Considering the rx fallback code we need to maintain is not too huge,
> maybe we can leave it as is, for example forbid AF_XDP in big modes.

I see.

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

