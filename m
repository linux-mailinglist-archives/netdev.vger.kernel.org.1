Return-Path: <netdev+bounces-90531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0748AE66D
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 14:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4BB028553D
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FC412FB23;
	Tue, 23 Apr 2024 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mJvLaQiw"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A129312E1EF
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 12:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875926; cv=none; b=bWJsq94zU/n6q6sla4Mu3LOaX8egwKhb/9o02MS084hvoiPRXNBskBQo+t8FLNkFlLLl0yFKL9x4FGsvDA09ha1H/C5qY2rDSLNhKWHcTq9IHNGNbFXxVeXK7nN+tZ0+u2E6tBaej072hgy27aml1rldxrXgeH2C8/RuNrmthMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875926; c=relaxed/simple;
	bh=VEivHfRBE5PagdBkYDmej9luvUWSDrVWwBvEwkxb/J4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=p0vUz613VpqCz105qCt7DZGaFKL01LMZ5I8P41UfNSmu9tcI8aa76Xd4/GPOtlIiIJkN2PaeEgcRNMtbfQyHLxRd6qOnK6skjpKN7FNWK/stgcNa0Fx53uJkcR4OBjPc62XDdN4KgWpcFuNPR0U6RH/+1fP1QLqB9iy6p/NfeUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mJvLaQiw; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713875919; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=IMcT9AbhGnJybY+mmUrN8SjqJH5jnYogREWe+tzfovQ=;
	b=mJvLaQiw0B67cWBeIRObCAmlyCIUFJ7lupFAP+PgZry3FcdUNcpEoT1JQRh+L0ucNmg0lduvaPAkkdLwT9b00Wof+PhAZ0Fr3qOh8yws2oBMk7gRDfGy8WMcSCndnSYWXnyec9YghGgI5pt4hWwPmZEAOfmHya6QQ6Yr2uAALKI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W59BIl._1713875917;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W59BIl._1713875917)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 20:38:38 +0800
Message-ID: <1713875473.8690095-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v2 4/7] virtio_net: big mode support premapped
Date: Tue, 23 Apr 2024 20:31:13 +0800
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
In-Reply-To: <CACGkMEuEYwR_QE-hhnD0KYujD6MVEArz3FPyjsfmJ-jk_02hZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 23 Apr 2024 12:36:42 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Apr 22, 2024 at 3:24=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
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
> > Based on the following points, we do not use page pool to manage these
> > pages:
> >
> > 1. virtio-net uses the DMA APIs wrapped by virtio core. Therefore,
> >    we can only prevent the page pool from performing DMA operations, and
> >    let the driver perform DMA operations on the allocated pages.
> > 2. But when the page pool releases the page, we have no chance to
> >    execute dma unmap.
> > 3. A solution to #2 is to execute dma unmap every time before putting
> >    the page back to the page pool. (This is actually a waste, we don't
> >    execute unmap so frequently.)
> > 4. But there is another problem, we still need to use page.dma_addr to
> >    save the dma address. Using page.dma_addr while using page pool is
> >    unsafe behavior.
> >
> > More:
> >     https://lore.kernel.org/all/CACGkMEu=3DAok9z2imB_c5qVuujSh=3Dvjj1kx=
12fy9N7hqyi+M5Ow@mail.gmail.com/
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 123 ++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 108 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 2c7a67ad4789..d4f5e65b247e 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -439,6 +439,81 @@ skb_vnet_common_hdr(struct sk_buff *skb)
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
> > +/* For pages submitted to the ring, we need to record its dma for unma=
p.
> > + * Here, we use the page.dma_addr and page.pp_magic to store the dma
> > + * address.
> > + */
> > +static void page_chain_set_dma(struct page *p, dma_addr_t addr)
> > +{
> > +       if (sizeof(dma_addr_t) > sizeof(unsigned long)) {
>
> Need a macro like PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA.
>
> > +               p->dma_addr =3D lower_32_bits(addr);
> > +               p->pp_magic =3D upper_32_bits(addr);
>
> And this uses three fields on page_pool which I'm not sure the other
> maintainers are happy with. For example, re-using pp_maing might be
> dangerous. See c07aea3ef4d40 ("mm: add a signature in struct page").
>
> I think a more safe way is to reuse page pool, for example introducing
> a new flag with dma callbacks?

If we use page pool, how can we chain the pages allocated for a packet?

Yon know the "private" can not be used.


If the pp struct inside the page is not safe, how about:

		struct {	/* Page cache and anonymous pages */
			/**
			 * @lru: Pageout list, eg. active_list protected by
			 * lruvec->lru_lock.  Sometimes used as a generic list
			 * by the page owner.
			 */
			union {
				struct list_head lru;

				/* Or, for the Unevictable "LRU list" slot */
				struct {
					/* Always even, to negate PageTail */
					void *__filler;
					/* Count page's or folio's mlocks */
					unsigned int mlock_count;
				};

				/* Or, free page */
				struct list_head buddy_list;
				struct list_head pcp_list;
			};
			/* See page-flags.h for PAGE_MAPPING_FLAGS */
			struct address_space *mapping;
			union {
				pgoff_t index;		/* Our offset within mapping. */
				unsigned long share;	/* share count for fsdax */
			};
			/**
			 * @private: Mapping-private opaque data.
			 * Usually used for buffer_heads if PagePrivate.
			 * Used for swp_entry_t if PageSwapCache.
			 * Indicates order in the buddy system if PageBuddy.
			 */
			unsigned long private;
		};

Or, we can map the private space of the page as a new structure.

Thanks.


>
> Thanks
>

