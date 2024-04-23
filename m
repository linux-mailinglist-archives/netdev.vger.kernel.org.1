Return-Path: <netdev+bounces-90349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87878ADD34
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 07:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9409B22A5C
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 05:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E0020DD2;
	Tue, 23 Apr 2024 05:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iEJ0gaNE"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7493A63C8
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 05:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713851286; cv=none; b=CW0wBri2qPYpURuNxIygV1B5uhIh/ZvHJU+Fb4NKy3jWdOCIvt5fZQV8IkuAp1RxF4LN8gWp4Cdo+HL9zt6h07dzaSo4B35pTBw9SSfP6PRphFVRXh6qwaAvaiSJfkvzqE/5qXMV8jW/9HM3VHtw71hw4ESifW4OqvlrcnTF7jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713851286; c=relaxed/simple;
	bh=ev8X/18Ecb+sz0DOl6ifvds5rlCeW5uGZn3WDcmtBuA=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=HESNhi5Pk8Wzt4xqtgiASWJNxWSWn4UXGIidPuiXs5qBVQbiFZu4B+TRsjsqe1uKvbCBAH17aN5RDqrKr3yXlbJHHR+JLtl4LDhqM6WpUQ+hZCzwgYpjDNxC8SnzCER6+7sx1FMlYVMh2h2uP/1BIgYJFvfmj/fq41nbeySBbRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iEJ0gaNE; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713851275; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=9T8+X9V6C7conzkUFeYvyiHt10I144MHOTOHwzEQEy8=;
	b=iEJ0gaNEyyEUD3lTTf3118e/NuNDUWSMIkMMGN2yQsqfyWMHnUUKn9YwcPEYtBsnVJq/TEDfOfWuWt3OivF6zAWa17UpJxchFj5s4bCRfKj5VP8UWE27w4somhcMbB7banxc5iMMMlT4+zjyHrEq+oND6TVK1bq8In7SozO6KMA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W57roUW_1713851273;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W57roUW_1713851273)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 13:47:54 +0800
Message-ID: <1713851247.7967803-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v2 4/7] virtio_net: big mode support premapped
Date: Tue, 23 Apr 2024 13:47:27 +0800
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

Let me try.

Thanks.

>
> Thanks
>

