Return-Path: <netdev+bounces-87804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EEB8A4B16
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 11:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D6D1C20AD8
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 09:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A0D3BBDC;
	Mon, 15 Apr 2024 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Xddm7o/0"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EE33BBEF
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 09:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171853; cv=none; b=SMgX7kPT8/DDxC60ZosTZ2cGAWqPccmtyJ9BE85yfQYCaeUldeswVJiRGPfCJcErSd5d+UWONMtPyQS1QEVK/bV/EsRZyaz68dlHHPp8lWXHpE4YWQgkhO2QPRTuuXU7CPh5HfTUSTV9/qpYR9EwKn4dY3MkTltCoqEdkb1SAKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171853; c=relaxed/simple;
	bh=jT9LZfnrN8nLPqnBQK6ARUQrA9GBtpxBkkDI86vCzL0=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=R70V3fLZOn0SVWNPm+n8tvOsItwMwOVZEnhEnmoauRb8nZ1qznxnWTqB5L8OprNeH83nx0l5eGcPr4rU94ECKadY0+214znSiSkUaCE1GdGetQZBqXndwJLN2D508CDwVcI7iCrzY3ghTTcihnlnYpsMbbHukgoCj365WyctB0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Xddm7o/0; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713171842; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=AhlbYFD1sPkQZ9S5dn9vUMXD+P3D1YHxhvN7dYvazJQ=;
	b=Xddm7o/0KJPQ0ykcJV3WL8ObLTSLscgM/RZHzFzRLYMDNdKAyeGWUt9UvpR5bifEr8CIXA85hnNHWomKNHTWmFHhnmNqtd7L8BXz6vFdRKjfN+HK1IHtzCL2mzB1zKJ/Q/gRD2Jj0O/t1TjoMVGdXo1EByE0F6Rm73OZyfnvlYI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W4ZaxCS_1713171841;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4ZaxCS_1713171841)
          by smtp.aliyun-inc.com;
          Mon, 15 Apr 2024 17:04:01 +0800
Message-ID: <1713171554.2423792-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 3/6] virtio_net: replace private by pp struct inside page
Date: Mon, 15 Apr 2024 16:59:14 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org,
 Jesper Dangaard Brouer <hawk@kernel.org>
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com>
 <20240411025127.51945-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEsC7AEi2SOmqNOo6KJDpx92raGWYwYzxZ_MVhmnco_LYQ@mail.gmail.com>
 <1712900153.3715405-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvKC6JpsznW57GgxFBMhmMSk4eCZPvESpew9j5qfp9=RA@mail.gmail.com>
 <1713146919.8867755-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvmaH9NE-5VDBPpZOpAAg4bX39Lf0-iGiYzxdV5JuZWww@mail.gmail.com>
 <1713170201.06163-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEvsXN+7HpeirxzR2qek_znHp8GtjiT+8hmt3tHHM9Zbgg@mail.gmail.com>
In-Reply-To: <CACGkMEvsXN+7HpeirxzR2qek_znHp8GtjiT+8hmt3tHHM9Zbgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 15 Apr 2024 16:56:45 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Apr 15, 2024 at 4:50=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Mon, 15 Apr 2024 14:43:24 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Mon, Apr 15, 2024 at 10:35=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.al=
ibaba.com> wrote:
> > > >
> > > > On Fri, 12 Apr 2024 13:49:12 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Fri, Apr 12, 2024 at 1:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux=
.alibaba.com> wrote:
> > > > > >
> > > > > > On Fri, 12 Apr 2024 12:47:55 +0800, Jason Wang <jasowang@redhat=
.com> wrote:
> > > > > > > On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@=
linux.alibaba.com> wrote:
> > > > > > > >
> > > > > > > > Now, we chain the pages of big mode by the page's private v=
ariable.
> > > > > > > > But a subsequent patch aims to make the big mode to support
> > > > > > > > premapped mode. This requires additional space to store the=
 dma addr.
> > > > > > > >
> > > > > > > > Within the sub-struct that contains the 'private', there is=
 no suitable
> > > > > > > > variable for storing the DMA addr.
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
> > > > > > > > But within the page pool struct, we have a variable called
> > > > > > > > dma_addr that is appropriate for storing dma addr.
> > > > > > > > And that struct is used by netstack. That works to our adva=
ntage.
> > > > > > > >
> > > > > > > >                 struct {        /* page_pool used by netsta=
ck */
> > > > > > > >                         /**
> > > > > > > >                          * @pp_magic: magic value to avoid =
recycling non
> > > > > > > >                          * page_pool allocated pages.
> > > > > > > >                          */
> > > > > > > >                         unsigned long pp_magic;
> > > > > > > >                         struct page_pool *pp;
> > > > > > > >                         unsigned long _pp_mapping_pad;
> > > > > > > >                         unsigned long dma_addr;
> > > > > > > >                         atomic_long_t pp_ref_count;
> > > > > > > >                 };
> > > > > > > >
> > > > > > > > On the other side, we should use variables from the same su=
b-struct.
> > > > > > > > So this patch replaces the "private" with "pp".
> > > > > > > >
> > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > ---
> > > > > > >
> > > > > > > Instead of doing a customized version of page pool, can we si=
mply
> > > > > > > switch to use page pool for big mode instead? Then we don't n=
eed to
> > > > > > > bother the dma stuffs.
> > > > > >
> > > > > >
> > > > > > The page pool needs to do the dma by the DMA APIs.
> > > > > > So we can not use the page pool directly.
> > > > >
> > > > > I found this:
> > > > >
> > > > > define PP_FLAG_DMA_MAP         BIT(0) /* Should page_pool do the =
DMA
> > > > >                                         * map/unmap
> > > > >
> > > > > It seems to work here?
> > > >
> > > >
> > > > I have studied the page pool mechanism and believe that we cannot u=
se it
> > > > directly. We can make the page pool to bypass the DMA operations.
> > > > This allows us to handle DMA within virtio-net for pages allocated =
from the page
> > > > pool. Furthermore, we can utilize page pool helpers to associate th=
e DMA address
> > > > to the page.
> > > >
> > > > However, the critical issue pertains to unmapping. Ideally, we want=
 to return
> > > > the mapped pages to the page pool and reuse them. In doing so, we c=
an omit the
> > > > unmapping and remapping steps.
> > > >
> > > > Currently, there's a caveat: when the page pool cache is full, it d=
isconnects
> > > > and releases the pages. When the pool hits its capacity, pages are =
relinquished
> > > > without a chance for unmapping.
> > >
> > > Technically, when ptr_ring is full there could be a fallback, but then
> > > it requires expensive synchronization between producer and consumer.
> > > For virtio-net, it might not be a problem because add/get has been
> > > synchronized. (It might be relaxed in the future, actually we've
> > > already seen a requirement in the past for virito-blk).
> >
> > The point is that the page will be released by page pool directly,
> > we will have no change to unmap that, if we work with page pool.
>
> I mean if we have a fallback, there would be no need to release these
> pages but put them into a link list.


What fallback?

If we put the pages to the link list, why we use the page pool?


>
> >
> > >
> > > > If we were to unmap pages each time before
> > > > returning them to the pool, we would negate the benefits of bypassi=
ng the
> > > > mapping and unmapping process altogether.
> > >
> > > Yes, but the problem in this approach is that it creates a corner
> > > exception where dma_addr is used outside the page pool.
> >
> > YES. This is a corner exception. We need to introduce this case to the =
page
> > pool.
> >
> > So for introducing the page-pool to virtio-net(not only for big mode),
> > we may need to push the page-pool to support dma by drivers.
>
> Adding Jesper for some comments.
>
> >
> > Back to this patch set, I think we should keep the virtio-net to manage
> > the pages.
> >
> > What do you think?
>
> I might be wrong, but I think if we need to either
>
> 1) seek a way to manage the pages by yourself but not touching page
> pool metadata (or Jesper is fine with this)

Do you mean working with page pool or not?

If we manage the pages by self(no page pool), we do not care the metadata i=
s for
page pool or not. We just use the space of pages like the "private".


> 2) optimize the unmap for page pool
>
> or even
>
> 3) just do dma_unmap before returning the page back to the page pool,
> we don't get all the benefits of page pool but we end up with simple
> codes (no fallback for premapping).

I am ok for this.


Thanks.

>
> Thanks
>
>
> >
> > Thanks
> >
> > >
> > > Maybe for big mode it doesn't matter too much if there's no
> > > performance improvement.
> > >
> > > Thanks
> > >
> > > >
> > > > Thanks.
> > > >
> > > >
> > > >
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>

