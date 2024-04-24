Return-Path: <netdev+bounces-90758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1DD8AFEF3
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 04:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05DB1286D92
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 02:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3347AE5D;
	Wed, 24 Apr 2024 02:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ho/Qu4ii"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F0728DDA
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 02:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713927475; cv=none; b=mWQWCrOej/TmkjZpw2Iyu3M38lzZRuMJzNjCXZRVnKmXwXATkG/yKMElYtjMW25SzbJXUs7pgBsca9Y6SBXhVYGaxV9NDmPighRViR0dH7dVvqdOfuW6bpIyz/JX9aDCfKf/dNgBpTUCr3Uj5eZcRpvTfcbGFUSjGFOL1EjHaFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713927475; c=relaxed/simple;
	bh=iMqoP95JU/1wqD5/O2cc2CTmbA1UeX6HIfXrS+icMEA=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=rPzF1fS0sUD7BEzQN/nH4fneRBtMYzn5Gj6I0VbA4MGnfcctIvhViGtcI3sERgja7xYQrKReUoa9GDDY0iUNzpFW42w9Htb2DsTT31H86KV8lMjH1OdBIFpzKsYYxXoNTJ5XbRqxSpKt79GitBVGcC50ZOJeRHkrcDA6dfzq5cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ho/Qu4ii; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713927471; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=QxYkZrAZCDiRpWcilVyNi8F3kgCj7awEYp3q0jtsNAg=;
	b=Ho/Qu4ii4+zrjF/OWvOKq1QCQAeMgd8R8/Va7o5Mm1f11RXoC6TmDc+ePvqu+YZPin6MlCbnAfNU/HNdUVVs3wkgvuZSaiVU1R6+DQ0Al0jdgIoggQKGWkIfJRzHz39PSjVMbTQ9TT8Vp0M4CxoUZIVi9aaTSv3G2AQ6vcLWsas=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W5AjNdu_1713927468;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5AjNdu_1713927468)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 10:57:50 +0800
Message-ID: <1713927254.7707088-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v2 4/7] virtio_net: big mode support premapped
Date: Wed, 24 Apr 2024 10:54:14 +0800
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
In-Reply-To: <CACGkMEvtvtauHk5TXM4Yo3X7Fi99Rjnu43OeZiX4zZU+M_akaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 24 Apr 2024 10:45:49 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Apr 24, 2024 at 10:42=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> >
> > On Wed, 24 Apr 2024 10:34:56 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Wed, Apr 24, 2024 at 9:10=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > On Wed, 24 Apr 2024 08:43:21 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Tue, Apr 23, 2024 at 8:38=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux=
.alibaba.com> wrote:
> > > > > >
> > > > > > On Tue, 23 Apr 2024 12:36:42 +0800, Jason Wang <jasowang@redhat=
.com> wrote:
> > > > > > > On Mon, Apr 22, 2024 at 3:24=E2=80=AFPM Xuan Zhuo <xuanzhuo@l=
inux.alibaba.com> wrote:
> > > > > > > >
> > > > > > > > In big mode, pre-mapping DMA is beneficial because if the p=
ages are not
> > > > > > > > used, we can reuse them without needing to unmap and remap.
> > > > > > > >
> > > > > > > > We require space to store the DMA address. I use the page.d=
ma_addr to
> > > > > > > > store the DMA address from the pp structure inside the page.
> > > > > > > >
> > > > > > > > Every page retrieved from get_a_page() is mapped, and its D=
MA address is
> > > > > > > > stored in page.dma_addr. When a page is returned to the cha=
in, we check
> > > > > > > > the DMA status; if it is not mapped (potentially having bee=
n unmapped),
> > > > > > > > we remap it before returning it to the chain.
> > > > > > > >
> > > > > > > > Based on the following points, we do not use page pool to m=
anage these
> > > > > > > > pages:
> > > > > > > >
> > > > > > > > 1. virtio-net uses the DMA APIs wrapped by virtio core. The=
refore,
> > > > > > > >    we can only prevent the page pool from performing DMA op=
erations, and
> > > > > > > >    let the driver perform DMA operations on the allocated p=
ages.
> > > > > > > > 2. But when the page pool releases the page, we have no cha=
nce to
> > > > > > > >    execute dma unmap.
> > > > > > > > 3. A solution to #2 is to execute dma unmap every time befo=
re putting
> > > > > > > >    the page back to the page pool. (This is actually a wast=
e, we don't
> > > > > > > >    execute unmap so frequently.)
> > > > > > > > 4. But there is another problem, we still need to use page.=
dma_addr to
> > > > > > > >    save the dma address. Using page.dma_addr while using pa=
ge pool is
> > > > > > > >    unsafe behavior.
> > > > > > > >
> > > > > > > > More:
> > > > > > > >     https://lore.kernel.org/all/CACGkMEu=3DAok9z2imB_c5qVuu=
jSh=3Dvjj1kx12fy9N7hqyi+M5Ow@mail.gmail.com/
> > > > > > > >
> > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > ---
> > > > > > > >  drivers/net/virtio_net.c | 123 +++++++++++++++++++++++++++=
+++++++-----
> > > > > > > >  1 file changed, 108 insertions(+), 15 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_=
net.c
> > > > > > > > index 2c7a67ad4789..d4f5e65b247e 100644
> > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > @@ -439,6 +439,81 @@ skb_vnet_common_hdr(struct sk_buff *sk=
b)
> > > > > > > >         return (struct virtio_net_common_hdr *)skb->cb;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t=
 addr, u32 len)
> > > > > > > > +{
> > > > > > > > +       sg->dma_address =3D addr;
> > > > > > > > +       sg->length =3D len;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +/* For pages submitted to the ring, we need to record its =
dma for unmap.
> > > > > > > > + * Here, we use the page.dma_addr and page.pp_magic to sto=
re the dma
> > > > > > > > + * address.
> > > > > > > > + */
> > > > > > > > +static void page_chain_set_dma(struct page *p, dma_addr_t =
addr)
> > > > > > > > +{
> > > > > > > > +       if (sizeof(dma_addr_t) > sizeof(unsigned long)) {
> > > > > > >
> > > > > > > Need a macro like PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA.
> > > > > > >
> > > > > > > > +               p->dma_addr =3D lower_32_bits(addr);
> > > > > > > > +               p->pp_magic =3D upper_32_bits(addr);
> > > > > > >
> > > > > > > And this uses three fields on page_pool which I'm not sure th=
e other
> > > > > > > maintainers are happy with. For example, re-using pp_maing mi=
ght be
> > > > > > > dangerous. See c07aea3ef4d40 ("mm: add a signature in struct =
page").
> > > > > > >
> > > > > > > I think a more safe way is to reuse page pool, for example in=
troducing
> > > > > > > a new flag with dma callbacks?
> > > > > >
> > > > > > If we use page pool, how can we chain the pages allocated for a=
 packet?
> > > > >
> > > > > I'm not sure I get this, it is chained via the descriptor flag.
> > > >
> > > >
> > > > In the big mode, we will commit many pages to the virtio core by
> > > > virtqueue_add_inbuf().
> > > >
> > > > By virtqueue_get_buf_ctx(), we got the data. That is the first page.
> > > > Other pages are chained by the "private".
> > > >
> > > > If we use the page pool, how can we chain the pages.
> > > > After virtqueue_add_inbuf(), we need to get the pages to fill the s=
kb.
> > >
> > > Right, technically it could be solved by providing helpers in the
> > > virtio core, but considering it's an optimization for big mode which
> > > is not popular, it's not worth to bother.
> > >
> > > >
> > > >
> > > >
> > > > >
> > > > > >
> > > > > > Yon know the "private" can not be used.
> > > > > >
> > > > > >
> > > > > > If the pp struct inside the page is not safe, how about:
> > > > > >
> > > > > >                 struct {        /* Page cache and anonymous pag=
es */
> > > > > >                         /**
> > > > > >                          * @lru: Pageout list, eg. active_list =
protected by
> > > > > >                          * lruvec->lru_lock.  Sometimes used as=
 a generic list
> > > > > >                          * by the page owner.
> > > > > >                          */
> > > > > >                         union {
> > > > > >                                 struct list_head lru;
> > > > > >
> > > > > >                                 /* Or, for the Unevictable "LRU=
 list" slot */
> > > > > >                                 struct {
> > > > > >                                         /* Always even, to nega=
te PageTail */
> > > > > >                                         void *__filler;
> > > > > >                                         /* Count page's or foli=
o's mlocks */
> > > > > >                                         unsigned int mlock_coun=
t;
> > > > > >                                 };
> > > > > >
> > > > > >                                 /* Or, free page */
> > > > > >                                 struct list_head buddy_list;
> > > > > >                                 struct list_head pcp_list;
> > > > > >                         };
> > > > > >                         /* See page-flags.h for PAGE_MAPPING_FL=
AGS */
> > > > > >                         struct address_space *mapping;
> > > > > >                         union {
> > > > > >                                 pgoff_t index;          /* Our =
offset within mapping. */
> > > > > >                                 unsigned long share;    /* shar=
e count for fsdax */
> > > > > >                         };
> > > > > >                         /**
> > > > > >                          * @private: Mapping-private opaque dat=
a.
> > > > > >                          * Usually used for buffer_heads if Pag=
ePrivate.
> > > > > >                          * Used for swp_entry_t if PageSwapCach=
e.
> > > > > >                          * Indicates order in the buddy system =
if PageBuddy.
> > > > > >                          */
> > > > > >                         unsigned long private;
> > > > > >                 };
> > > > > >
> > > > > > Or, we can map the private space of the page as a new structure.
> > > > >
> > > > > It could be a way. But such allocation might be huge if we are us=
ing
> > > > > indirect descriptors or I may miss something.
> > > >
> > > > No. we only need to store the "chain next" and the dma as this patc=
h set did.
> > > > The size of the private space inside the page is  20(32bit)/40(64bi=
t) bytes.
> > > > That is enough for us.
> > > >
> > > > If you worry about the change of the pp structure, we can use the "=
private" as
> > > > origin and use the "struct list_head lru" to store the dma.
> > >
> > > This looks even worse, as it uses fields belonging to the different
> > > structures in the union.
> >
> > I mean we do not use the elems from the pp structure inside the page,
> > if we worry the change of the pp structure.
> >
> > I mean use the "private" and "lru", these in the same structure.
> >
> > I think this is a good way.
> >
> > Thanks.
>
> See this:
>
> https://lore.kernel.org/netdev/20210411114307.5087f958@carbon/


I think that is because that the page pool will share the page with
the skbs.  I'm not entirely sure.

In our case, virtio-net fully owns the page. After the page is referenced b=
y skb,
virtio-net no longer references the page. I don't think there is any problem
here.

The key is that who owns the page, who can use the page private space (20/4=
0 bytes).

Is that?

Thanks.


>
> Thanks
>

