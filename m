Return-Path: <netdev+bounces-90751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4543E8AFE84
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 04:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1883280EBB
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 02:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849C2824B7;
	Wed, 24 Apr 2024 02:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIzS2N6E"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52E67F490
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 02:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713926144; cv=none; b=HnE60c4HNxLXTTW9k/mXCD6y57WXYVW2eyFLuCnxDNjLVYYTze4642320U1AJNAh1NJMrWcIEzllUuDNPqpEGrXoPLoa290pZFndyyJQSkpWMC1PKYfFfUV5uykSr/fXYTWzaGpNcK2iKnfl+NGvIRDqedL20f4e0wJ38pBdZoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713926144; c=relaxed/simple;
	bh=zZ0Ywm56Lv6WkdRn58KFXUjz9hWY0kA8SgeGosh3w7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRWd+1WH22XlTnn8YiRaTHZNr/6C4N9H/PW7aacO+5t3RPQeCPdAZ9qezVJUx6Vcm4HDDUrUJrLVVv9UrpN/p3GgcSK1a+p59OEFzeWVLag0RDu3T3nJw20x43I8QpNezdLqfTJLj1IHO01GIYsjVSEmFgvqaW50PuMTgOaonnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NIzS2N6E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713926141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KKWIuq9J98QGPGSzJTadWoIW5NB1MRHkv05eIeDWUeg=;
	b=NIzS2N6EUWGRBvABnGJoaadF18Sb9glwbjcMkGidsrOAcmdw3o9087xQW15LUMR0hnKUb2
	h1Yik/FE9vlm9d+i9vpRAeStIbWXgXM0JsPvQEyGp2Pm8cxrVzIValKvadAJ/2jY0K2IdX
	PGBXrdr8hwHLQzv5Lvv8QpgOWLl7VzA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-NMxxZ8XkPkCf9THxgHzRbQ-1; Tue, 23 Apr 2024 22:35:09 -0400
X-MC-Unique: NMxxZ8XkPkCf9THxgHzRbQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a4f128896aso354000a91.1
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 19:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713926108; x=1714530908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKWIuq9J98QGPGSzJTadWoIW5NB1MRHkv05eIeDWUeg=;
        b=luy3Yu5lSipDJLP17+wSjJY3z3hYeJ24OyBp9t1hqzqsVuCn/Okx3vNIZyTMqx3OoM
         ljjaBq2iZzs1eNbZ10sIPMLnAhUTJ4ZowO8EaEFUTmspmJPL8AafjPIgWcXZ6Di23MoB
         Ozo2NWGjTTpLem6t0XmAptqRVRrKLEQEmoWVM9pwx1YYfQtMc6hetWLho9U8rnX/3UCJ
         FKu3B1jjmrPJ1J+TaclkQuHiDFjI850xwAzpzJfx+nbCmUo1lcp7IDGeTgwZGkunyCPp
         8ZccWWoeG9gBDEKNHslhRtyIGqYvT6RhPJyv5kL9pjp0YPLWVwehQMqUPdwr/HZn8xrE
         vaXA==
X-Forwarded-Encrypted: i=1; AJvYcCWXsCwHMqyXvrIEFGKmS1gTBZwCrZmGTUcl3Ue2dfe3QDo49Fa8Wd94qEdBzaaHyEzy1K3UEDlNxavvKBCCX26k7O21JofH
X-Gm-Message-State: AOJu0Yx3DjQKjAveT635NedXoJgxpDS/qi2tAhfvymCWyaYV0kHgi7Q+
	A3RePnykc0PFh+P5Y4TMDCRZXiyLWsY9I0YqfGJyBX65bUnxNivMW1QoBFu3k60XZ3F7vFoJJuq
	qRrbjBY4/zIiBO5JlDUlYDRMblj+8lpLNm9gi0W8LjjHUxRlLi9/18lDg7QnRoLBO4IVOHcbOvm
	3+p59YEAyi+CHTm6M21+b8FwoGuvav
X-Received: by 2002:a17:90b:1113:b0:2a2:c40a:1a5 with SMTP id gi19-20020a17090b111300b002a2c40a01a5mr1644002pjb.12.1713926108555;
        Tue, 23 Apr 2024 19:35:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHajBxxnIeA96UWuNI8iJbBd/wfCXMxprkyNuEbdkUrOfh+gj+7+p87nh+uS+CszhLRidRNEoLVatmX8l4ON0o=
X-Received: by 2002:a17:90b:1113:b0:2a2:c40a:1a5 with SMTP id
 gi19-20020a17090b111300b002a2c40a01a5mr1643977pjb.12.1713926108128; Tue, 23
 Apr 2024 19:35:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422072408.126821-1-xuanzhuo@linux.alibaba.com>
 <20240422072408.126821-5-xuanzhuo@linux.alibaba.com> <CACGkMEuEYwR_QE-hhnD0KYujD6MVEArz3FPyjsfmJ-jk_02hZw@mail.gmail.com>
 <1713875473.8690095-1-xuanzhuo@linux.alibaba.com> <CACGkMEs=6Xfc1hELudF=+xvoJN+npQw11BqP0jjCxmUy2jaikg@mail.gmail.com>
 <1713919985.3490202-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1713919985.3490202-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Apr 2024 10:34:56 +0800
Message-ID: <CACGkMEu21VCPnuNM-MURnq40LKxysOJD0aJhPQE4Dbt2qT5rEg@mail.gmail.com>
Subject: Re: [PATCH vhost v2 4/7] virtio_net: big mode support premapped
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 9:10=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 24 Apr 2024 08:43:21 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Apr 23, 2024 at 8:38=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Tue, 23 Apr 2024 12:36:42 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Mon, Apr 22, 2024 at 3:24=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > In big mode, pre-mapping DMA is beneficial because if the pages a=
re not
> > > > > used, we can reuse them without needing to unmap and remap.
> > > > >
> > > > > We require space to store the DMA address. I use the page.dma_add=
r to
> > > > > store the DMA address from the pp structure inside the page.
> > > > >
> > > > > Every page retrieved from get_a_page() is mapped, and its DMA add=
ress is
> > > > > stored in page.dma_addr. When a page is returned to the chain, we=
 check
> > > > > the DMA status; if it is not mapped (potentially having been unma=
pped),
> > > > > we remap it before returning it to the chain.
> > > > >
> > > > > Based on the following points, we do not use page pool to manage =
these
> > > > > pages:
> > > > >
> > > > > 1. virtio-net uses the DMA APIs wrapped by virtio core. Therefore=
,
> > > > >    we can only prevent the page pool from performing DMA operatio=
ns, and
> > > > >    let the driver perform DMA operations on the allocated pages.
> > > > > 2. But when the page pool releases the page, we have no chance to
> > > > >    execute dma unmap.
> > > > > 3. A solution to #2 is to execute dma unmap every time before put=
ting
> > > > >    the page back to the page pool. (This is actually a waste, we =
don't
> > > > >    execute unmap so frequently.)
> > > > > 4. But there is another problem, we still need to use page.dma_ad=
dr to
> > > > >    save the dma address. Using page.dma_addr while using page poo=
l is
> > > > >    unsafe behavior.
> > > > >
> > > > > More:
> > > > >     https://lore.kernel.org/all/CACGkMEu=3DAok9z2imB_c5qVuujSh=3D=
vjj1kx12fy9N7hqyi+M5Ow@mail.gmail.com/
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 123 +++++++++++++++++++++++++++++++++=
+-----
> > > > >  1 file changed, 108 insertions(+), 15 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 2c7a67ad4789..d4f5e65b247e 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -439,6 +439,81 @@ skb_vnet_common_hdr(struct sk_buff *skb)
> > > > >         return (struct virtio_net_common_hdr *)skb->cb;
> > > > >  }
> > > > >
> > > > > +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr,=
 u32 len)
> > > > > +{
> > > > > +       sg->dma_address =3D addr;
> > > > > +       sg->length =3D len;
> > > > > +}
> > > > > +
> > > > > +/* For pages submitted to the ring, we need to record its dma fo=
r unmap.
> > > > > + * Here, we use the page.dma_addr and page.pp_magic to store the=
 dma
> > > > > + * address.
> > > > > + */
> > > > > +static void page_chain_set_dma(struct page *p, dma_addr_t addr)
> > > > > +{
> > > > > +       if (sizeof(dma_addr_t) > sizeof(unsigned long)) {
> > > >
> > > > Need a macro like PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA.
> > > >
> > > > > +               p->dma_addr =3D lower_32_bits(addr);
> > > > > +               p->pp_magic =3D upper_32_bits(addr);
> > > >
> > > > And this uses three fields on page_pool which I'm not sure the othe=
r
> > > > maintainers are happy with. For example, re-using pp_maing might be
> > > > dangerous. See c07aea3ef4d40 ("mm: add a signature in struct page")=
.
> > > >
> > > > I think a more safe way is to reuse page pool, for example introduc=
ing
> > > > a new flag with dma callbacks?
> > >
> > > If we use page pool, how can we chain the pages allocated for a packe=
t?
> >
> > I'm not sure I get this, it is chained via the descriptor flag.
>
>
> In the big mode, we will commit many pages to the virtio core by
> virtqueue_add_inbuf().
>
> By virtqueue_get_buf_ctx(), we got the data. That is the first page.
> Other pages are chained by the "private".
>
> If we use the page pool, how can we chain the pages.
> After virtqueue_add_inbuf(), we need to get the pages to fill the skb.

Right, technically it could be solved by providing helpers in the
virtio core, but considering it's an optimization for big mode which
is not popular, it's not worth to bother.

>
>
>
> >
> > >
> > > Yon know the "private" can not be used.
> > >
> > >
> > > If the pp struct inside the page is not safe, how about:
> > >
> > >                 struct {        /* Page cache and anonymous pages */
> > >                         /**
> > >                          * @lru: Pageout list, eg. active_list protec=
ted by
> > >                          * lruvec->lru_lock.  Sometimes used as a gen=
eric list
> > >                          * by the page owner.
> > >                          */
> > >                         union {
> > >                                 struct list_head lru;
> > >
> > >                                 /* Or, for the Unevictable "LRU list"=
 slot */
> > >                                 struct {
> > >                                         /* Always even, to negate Pag=
eTail */
> > >                                         void *__filler;
> > >                                         /* Count page's or folio's ml=
ocks */
> > >                                         unsigned int mlock_count;
> > >                                 };
> > >
> > >                                 /* Or, free page */
> > >                                 struct list_head buddy_list;
> > >                                 struct list_head pcp_list;
> > >                         };
> > >                         /* See page-flags.h for PAGE_MAPPING_FLAGS */
> > >                         struct address_space *mapping;
> > >                         union {
> > >                                 pgoff_t index;          /* Our offset=
 within mapping. */
> > >                                 unsigned long share;    /* share coun=
t for fsdax */
> > >                         };
> > >                         /**
> > >                          * @private: Mapping-private opaque data.
> > >                          * Usually used for buffer_heads if PagePriva=
te.
> > >                          * Used for swp_entry_t if PageSwapCache.
> > >                          * Indicates order in the buddy system if Pag=
eBuddy.
> > >                          */
> > >                         unsigned long private;
> > >                 };
> > >
> > > Or, we can map the private space of the page as a new structure.
> >
> > It could be a way. But such allocation might be huge if we are using
> > indirect descriptors or I may miss something.
>
> No. we only need to store the "chain next" and the dma as this patch set =
did.
> The size of the private space inside the page is  20(32bit)/40(64bit) byt=
es.
> That is enough for us.
>
> If you worry about the change of the pp structure, we can use the "privat=
e" as
> origin and use the "struct list_head lru" to store the dma.

This looks even worse, as it uses fields belonging to the different
structures in the union.

>
> The min size of "struct list_head lru" is 8 bytes, that is enough for the
> dma_addr_t.
>
> We can do this more simper:
>
> static void page_chain_set_dma(struct page *p, dma_addr_t dma)
> {
>         BUILD_BUG_ON(sizeof(p->lru)) < sizeof(dma));
>
>         dma_addr_t *addr;
>
>         addr =3D &page->lru;
>
>         *addr =3D dma;
> }

So we had this in the kernel code.

       /*
         * Five words (20/40 bytes) are available in this union.
         * WARNING: bit 0 of the first word is used for PageTail(). That
         * means the other users of this union MUST NOT use the bit to
         * avoid collision and false-positive PageTail().
         */

And by looking at the discussion that introduces the pp_magic, reusing
fields seems to be tricky as we may end up with side effects of
aliasing fields in page structure. Technically, we can invent new
structures in the union, but it might not be worth it to bother.

So I think we can leave the fallback code and revisit this issue in the fut=
ure.

Thanks

>
> Thanks.
>
>
>
> >
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > > Thanks
> > > >
> > >
> >
>


