Return-Path: <netdev+bounces-90722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B40568AFD65
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 02:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6411F23694
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 00:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65134405;
	Wed, 24 Apr 2024 00:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKfrCL1m"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133ED23CE
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 00:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713919418; cv=none; b=TB6esKOuf6onPfNtHVWdCu/PpmZ/HZFSwtsdPBU+A4XDb3bKQM+4yX83VxCpqMyzQM1Io0tnSRxQYb7JQ80bM+vXrYkPlX0ZUGHMUoqjZM23C6xn0n4FkVbuOylFvgnJgiYu9H5gwHRfAVz6vaL6tlA2azS+usYPZymzE2i149c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713919418; c=relaxed/simple;
	bh=nemwSq7LpjO98ubPkr4hoeo2ceohiKQurSIarYjontc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ajkqg3BYBZHXKVWWfOOT6tyVXlxbnbDqgDQ+09z/oc0XX0TJf9V01Ut0FfCRIWYrNNT3NEkcwZgYKjA1eqffZAHTru7qDxqrBzNgthFk03bqEMYEuBOAKnuGa4OvmGOcOGBD4vE4Ja6eTKWBZ12YeOc2QzAv68LWOcKdXpTkTs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BKfrCL1m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713919415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nzqG4WxGO8CPSMgAY6cNKqF4exy1rnrpzJXQbq04bRE=;
	b=BKfrCL1m35VAEEoczMn1VPq96+fKhOD5mYxZSwF2i2l4N4noyUsFMSPTHk8aDqt4M1ZmN9
	pr0EtW4lOx+qJYR5/nIFfWwLgQc3aQFsIgRwMfoFvyWtA5+CoLgGeXxbX5zR9Cr2mC6hw3
	Mk/sID7d1+arHEWWK/r6sTT1RuH3CXE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-ZNPHTbUUPB6RS9delqVfYA-1; Tue, 23 Apr 2024 20:43:34 -0400
X-MC-Unique: ZNPHTbUUPB6RS9delqVfYA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ae83527c22so1732761a91.3
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 17:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713919413; x=1714524213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzqG4WxGO8CPSMgAY6cNKqF4exy1rnrpzJXQbq04bRE=;
        b=YpNokbMrGjT+LRb2cdhEN/RF75lgwsb+Ru90y9Z9qEDMjBl6WYcb5MyNwFXMmbiIy2
         nhemzEvauCaoSth4vtmswhnzjaz3WGdGIaYyiflN8xTu0ZT+z4MR1/NCiiGOAeTM4lT2
         jmv3YFuyjhg8zfDPCQU+1xXKkj/I00UG5lzt2k6gJzNoMX8/yZ6xzseKWN4V8VhvomPj
         y8627Mv+HjLZaECtA81c6oCUaGsYWnpiEmRNBIOjKrNmv6iEW4McjH6kP8wsgshK1bEf
         wCUSKLdgYmkAyXbKYIYn04LZaGQMRIp0THNVgvMCZFeNspuiRV4HJw1Fw42fVgqWiGAY
         4xHA==
X-Forwarded-Encrypted: i=1; AJvYcCXQSjVd5BcEQXOQf8e+TMWFDVFPLnTQgiJ8O5YDgjbHwGdhXvfYS5vq4EoK6HgRNjABTlCRnlKDvTEMykgeYTuKJuWo1VAP
X-Gm-Message-State: AOJu0Yx+LgVax8+5mp+tAiTIirfW9mXdVWfb+6yiYkqMqoQO2ckfFBag
	8DlHbI1YCDGLQCZs8FfNsDeQin6EZ3gBGTpKkHF5n3reNnSEKOYGMMxLQBEU7Zv9JPjfRjh1gPR
	EenBMMc1Zw9/0672wI5K4/QMFkmIBgK0PHJaw4049CK6zV3FIEjF0WGRBNMTwyfJp+AzG995TBS
	/SLI8K+ct9EgzhB9hhUqcIwnFERQN/
X-Received: by 2002:a17:90b:4d88:b0:2a5:c3a7:39d9 with SMTP id oj8-20020a17090b4d8800b002a5c3a739d9mr866372pjb.45.1713919413111;
        Tue, 23 Apr 2024 17:43:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELSjXcvgOSQ+r2N0VSH03fv7YreOaB0eLmYEslhQzyiNcbnU6M94t1VCxSgJ4CJQjI4OBsDUmoN58B6iq4a/U=
X-Received: by 2002:a17:90b:4d88:b0:2a5:c3a7:39d9 with SMTP id
 oj8-20020a17090b4d8800b002a5c3a739d9mr866362pjb.45.1713919412688; Tue, 23 Apr
 2024 17:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422072408.126821-1-xuanzhuo@linux.alibaba.com>
 <20240422072408.126821-5-xuanzhuo@linux.alibaba.com> <CACGkMEuEYwR_QE-hhnD0KYujD6MVEArz3FPyjsfmJ-jk_02hZw@mail.gmail.com>
 <1713875473.8690095-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1713875473.8690095-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Apr 2024 08:43:21 +0800
Message-ID: <CACGkMEs=6Xfc1hELudF=+xvoJN+npQw11BqP0jjCxmUy2jaikg@mail.gmail.com>
Subject: Re: [PATCH vhost v2 4/7] virtio_net: big mode support premapped
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 8:38=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Tue, 23 Apr 2024 12:36:42 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Mon, Apr 22, 2024 at 3:24=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > In big mode, pre-mapping DMA is beneficial because if the pages are n=
ot
> > > used, we can reuse them without needing to unmap and remap.
> > >
> > > We require space to store the DMA address. I use the page.dma_addr to
> > > store the DMA address from the pp structure inside the page.
> > >
> > > Every page retrieved from get_a_page() is mapped, and its DMA address=
 is
> > > stored in page.dma_addr. When a page is returned to the chain, we che=
ck
> > > the DMA status; if it is not mapped (potentially having been unmapped=
),
> > > we remap it before returning it to the chain.
> > >
> > > Based on the following points, we do not use page pool to manage thes=
e
> > > pages:
> > >
> > > 1. virtio-net uses the DMA APIs wrapped by virtio core. Therefore,
> > >    we can only prevent the page pool from performing DMA operations, =
and
> > >    let the driver perform DMA operations on the allocated pages.
> > > 2. But when the page pool releases the page, we have no chance to
> > >    execute dma unmap.
> > > 3. A solution to #2 is to execute dma unmap every time before putting
> > >    the page back to the page pool. (This is actually a waste, we don'=
t
> > >    execute unmap so frequently.)
> > > 4. But there is another problem, we still need to use page.dma_addr t=
o
> > >    save the dma address. Using page.dma_addr while using page pool is
> > >    unsafe behavior.
> > >
> > > More:
> > >     https://lore.kernel.org/all/CACGkMEu=3DAok9z2imB_c5qVuujSh=3Dvjj1=
kx12fy9N7hqyi+M5Ow@mail.gmail.com/
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 123 ++++++++++++++++++++++++++++++++++---=
--
> > >  1 file changed, 108 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 2c7a67ad4789..d4f5e65b247e 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -439,6 +439,81 @@ skb_vnet_common_hdr(struct sk_buff *skb)
> > >         return (struct virtio_net_common_hdr *)skb->cb;
> > >  }
> > >
> > > +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32=
 len)
> > > +{
> > > +       sg->dma_address =3D addr;
> > > +       sg->length =3D len;
> > > +}
> > > +
> > > +/* For pages submitted to the ring, we need to record its dma for un=
map.
> > > + * Here, we use the page.dma_addr and page.pp_magic to store the dma
> > > + * address.
> > > + */
> > > +static void page_chain_set_dma(struct page *p, dma_addr_t addr)
> > > +{
> > > +       if (sizeof(dma_addr_t) > sizeof(unsigned long)) {
> >
> > Need a macro like PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA.
> >
> > > +               p->dma_addr =3D lower_32_bits(addr);
> > > +               p->pp_magic =3D upper_32_bits(addr);
> >
> > And this uses three fields on page_pool which I'm not sure the other
> > maintainers are happy with. For example, re-using pp_maing might be
> > dangerous. See c07aea3ef4d40 ("mm: add a signature in struct page").
> >
> > I think a more safe way is to reuse page pool, for example introducing
> > a new flag with dma callbacks?
>
> If we use page pool, how can we chain the pages allocated for a packet?

I'm not sure I get this, it is chained via the descriptor flag.

>
> Yon know the "private" can not be used.
>
>
> If the pp struct inside the page is not safe, how about:
>
>                 struct {        /* Page cache and anonymous pages */
>                         /**
>                          * @lru: Pageout list, eg. active_list protected =
by
>                          * lruvec->lru_lock.  Sometimes used as a generic=
 list
>                          * by the page owner.
>                          */
>                         union {
>                                 struct list_head lru;
>
>                                 /* Or, for the Unevictable "LRU list" slo=
t */
>                                 struct {
>                                         /* Always even, to negate PageTai=
l */
>                                         void *__filler;
>                                         /* Count page's or folio's mlocks=
 */
>                                         unsigned int mlock_count;
>                                 };
>
>                                 /* Or, free page */
>                                 struct list_head buddy_list;
>                                 struct list_head pcp_list;
>                         };
>                         /* See page-flags.h for PAGE_MAPPING_FLAGS */
>                         struct address_space *mapping;
>                         union {
>                                 pgoff_t index;          /* Our offset wit=
hin mapping. */
>                                 unsigned long share;    /* share count fo=
r fsdax */
>                         };
>                         /**
>                          * @private: Mapping-private opaque data.
>                          * Usually used for buffer_heads if PagePrivate.
>                          * Used for swp_entry_t if PageSwapCache.
>                          * Indicates order in the buddy system if PageBud=
dy.
>                          */
>                         unsigned long private;
>                 };
>
> Or, we can map the private space of the page as a new structure.

It could be a way. But such allocation might be huge if we are using
indirect descriptors or I may miss something.

Thanks

>
> Thanks.
>
>
> >
> > Thanks
> >
>


