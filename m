Return-Path: <netdev+bounces-88608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D52C8A7E85
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 10:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FF39B217DE
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 08:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE216CDA8;
	Wed, 17 Apr 2024 08:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EMy0QAdP"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B07D7D07E
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343422; cv=none; b=LYXH8+l6C4bQnoyDKSYJBO+EyiCLDzmh/Lqh7Osifzf0OqkMPSQij6QEZRmmkmuH0FGgzuoDLEzukBn2r8VRM/vFKut42hDsPWkgK1k2i4hWYS1Xa1aVIKwM+g6SiP/U0zGRZs0kEGxcmVZZExh4UjUKMn9pOVsfGRShRLLSj0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343422; c=relaxed/simple;
	bh=SOXPVTmdIjLElqi0N/V3VvsZR5YPltP9iAFDZBVYaKw=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=uFw0reG3Z+wdhPyUkmW+7U5c6f6ukI+J6JgJXK6L6FqAMcOsZqm+j7sEqlKFiEvKZnvZOaMF3aTB9vDMW34AJ2Z+jVfuk8cyCAbSacm09l29uHSTlSPBHMDL+eId75dy78ZGN8SpJ1czNuPsomMx0AqiLuyQJpVAwB0w6z/S3Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EMy0QAdP; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713343418; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=y85km5+HMurzqVXhju9N5x2VHlJebnvhG955a1BKfUk=;
	b=EMy0QAdP8qKyMUjLiQ+ua9RkFmeoSF5d/EHX5lKDQHbUJDIuleRewgRvBx0Z5w8Z2nTvUxIOaS+3LDypveegBDYgTUWXpkB7viqFQpIH7Jcyo7EJsO80FQIIfcBwlH3p6jzzYLgH+ELmGR6VVaXaou5NCjgvXfYyFWZy4F47P3k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W4kxH6M_1713343416;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4kxH6M_1713343416)
          by smtp.aliyun-inc.com;
          Wed, 17 Apr 2024 16:43:37 +0800
Message-ID: <1713342055.436048-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 3/6] virtio_net: replace private by pp struct inside page
Date: Wed, 17 Apr 2024 16:20:55 +0800
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
 <1713171554.2423792-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuK0VkqtNfZ1BUw+SW=gdasEegTMfufS-47NV4bCh3Seg@mail.gmail.com>
 <1713317444.7698638-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvjwXpF_mLR3H8ZW9PUE+3spcxKMQV1VvUARb0-Lt7NKQ@mail.gmail.com>
In-Reply-To: <CACGkMEvjwXpF_mLR3H8ZW9PUE+3spcxKMQV1VvUARb0-Lt7NKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 17 Apr 2024 12:08:10 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Apr 17, 2024 at 9:38=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Tue, 16 Apr 2024 11:24:53 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Mon, Apr 15, 2024 at 5:04=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > On Mon, 15 Apr 2024 16:56:45 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Mon, Apr 15, 2024 at 4:50=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux=
.alibaba.com> wrote:
> > > > > >
> > > > > > On Mon, 15 Apr 2024 14:43:24 +0800, Jason Wang <jasowang@redhat=
.com> wrote:
> > > > > > > On Mon, Apr 15, 2024 at 10:35=E2=80=AFAM Xuan Zhuo <xuanzhuo@=
linux.alibaba.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, 12 Apr 2024 13:49:12 +0800, Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > > > > On Fri, Apr 12, 2024 at 1:39=E2=80=AFPM Xuan Zhuo <xuanzh=
uo@linux.alibaba.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, 12 Apr 2024 12:47:55 +0800, Jason Wang <jasowan=
g@redhat.com> wrote:
> > > > > > > > > > > On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <x=
uanzhuo@linux.alibaba.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Now, we chain the pages of big mode by the page's p=
rivate variable.
> > > > > > > > > > > > But a subsequent patch aims to make the big mode to=
 support
> > > > > > > > > > > > premapped mode. This requires additional space to s=
tore the dma addr.
> > > > > > > > > > > >
> > > > > > > > > > > > Within the sub-struct that contains the 'private', =
there is no suitable
> > > > > > > > > > > > variable for storing the DMA addr.
> > > > > > > > > > > >
> > > > > > > > > > > >                 struct {        /* Page cache and a=
nonymous pages */
> > > > > > > > > > > >                         /**
> > > > > > > > > > > >                          * @lru: Pageout list, eg. =
active_list protected by
> > > > > > > > > > > >                          * lruvec->lru_lock.  Somet=
imes used as a generic list
> > > > > > > > > > > >                          * by the page owner.
> > > > > > > > > > > >                          */
> > > > > > > > > > > >                         union {
> > > > > > > > > > > >                                 struct list_head lr=
u;
> > > > > > > > > > > >
> > > > > > > > > > > >                                 /* Or, for the Unev=
ictable "LRU list" slot */
> > > > > > > > > > > >                                 struct {
> > > > > > > > > > > >                                         /* Always e=
ven, to negate PageTail */
> > > > > > > > > > > >                                         void *__fil=
ler;
> > > > > > > > > > > >                                         /* Count pa=
ge's or folio's mlocks */
> > > > > > > > > > > >                                         unsigned in=
t mlock_count;
> > > > > > > > > > > >                                 };
> > > > > > > > > > > >
> > > > > > > > > > > >                                 /* Or, free page */
> > > > > > > > > > > >                                 struct list_head bu=
ddy_list;
> > > > > > > > > > > >                                 struct list_head pc=
p_list;
> > > > > > > > > > > >                         };
> > > > > > > > > > > >                         /* See page-flags.h for PAG=
E_MAPPING_FLAGS */
> > > > > > > > > > > >                         struct address_space *mappi=
ng;
> > > > > > > > > > > >                         union {
> > > > > > > > > > > >                                 pgoff_t index;     =
     /* Our offset within mapping. */
> > > > > > > > > > > >                                 unsigned long share=
;    /* share count for fsdax */
> > > > > > > > > > > >                         };
> > > > > > > > > > > >                         /**
> > > > > > > > > > > >                          * @private: Mapping-privat=
e opaque data.
> > > > > > > > > > > >                          * Usually used for buffer_=
heads if PagePrivate.
> > > > > > > > > > > >                          * Used for swp_entry_t if =
PageSwapCache.
> > > > > > > > > > > >                          * Indicates order in the b=
uddy system if PageBuddy.
> > > > > > > > > > > >                          */
> > > > > > > > > > > >                         unsigned long private;
> > > > > > > > > > > >                 };
> > > > > > > > > > > >
> > > > > > > > > > > > But within the page pool struct, we have a variable=
 called
> > > > > > > > > > > > dma_addr that is appropriate for storing dma addr.
> > > > > > > > > > > > And that struct is used by netstack. That works to =
our advantage.
> > > > > > > > > > > >
> > > > > > > > > > > >                 struct {        /* page_pool used b=
y netstack */
> > > > > > > > > > > >                         /**
> > > > > > > > > > > >                          * @pp_magic: magic value t=
o avoid recycling non
> > > > > > > > > > > >                          * page_pool allocated page=
s.
> > > > > > > > > > > >                          */
> > > > > > > > > > > >                         unsigned long pp_magic;
> > > > > > > > > > > >                         struct page_pool *pp;
> > > > > > > > > > > >                         unsigned long _pp_mapping_p=
ad;
> > > > > > > > > > > >                         unsigned long dma_addr;
> > > > > > > > > > > >                         atomic_long_t pp_ref_count;
> > > > > > > > > > > >                 };
> > > > > > > > > > > >
> > > > > > > > > > > > On the other side, we should use variables from the=
 same sub-struct.
> > > > > > > > > > > > So this patch replaces the "private" with "pp".
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m>
> > > > > > > > > > > > ---
> > > > > > > > > > >
> > > > > > > > > > > Instead of doing a customized version of page pool, c=
an we simply
> > > > > > > > > > > switch to use page pool for big mode instead? Then we=
 don't need to
> > > > > > > > > > > bother the dma stuffs.
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > The page pool needs to do the dma by the DMA APIs.
> > > > > > > > > > So we can not use the page pool directly.
> > > > > > > > >
> > > > > > > > > I found this:
> > > > > > > > >
> > > > > > > > > define PP_FLAG_DMA_MAP         BIT(0) /* Should page_pool=
 do the DMA
> > > > > > > > >                                         * map/unmap
> > > > > > > > >
> > > > > > > > > It seems to work here?
> > > > > > > >
> > > > > > > >
> > > > > > > > I have studied the page pool mechanism and believe that we =
cannot use it
> > > > > > > > directly. We can make the page pool to bypass the DMA opera=
tions.
> > > > > > > > This allows us to handle DMA within virtio-net for pages al=
located from the page
> > > > > > > > pool. Furthermore, we can utilize page pool helpers to asso=
ciate the DMA address
> > > > > > > > to the page.
> > > > > > > >
> > > > > > > > However, the critical issue pertains to unmapping. Ideally,=
 we want to return
> > > > > > > > the mapped pages to the page pool and reuse them. In doing =
so, we can omit the
> > > > > > > > unmapping and remapping steps.
> > > > > > > >
> > > > > > > > Currently, there's a caveat: when the page pool cache is fu=
ll, it disconnects
> > > > > > > > and releases the pages. When the pool hits its capacity, pa=
ges are relinquished
> > > > > > > > without a chance for unmapping.
> > > > > > >
> > > > > > > Technically, when ptr_ring is full there could be a fallback,=
 but then
> > > > > > > it requires expensive synchronization between producer and co=
nsumer.
> > > > > > > For virtio-net, it might not be a problem because add/get has=
 been
> > > > > > > synchronized. (It might be relaxed in the future, actually we=
've
> > > > > > > already seen a requirement in the past for virito-blk).
> > > > > >
> > > > > > The point is that the page will be released by page pool direct=
ly,
> > > > > > we will have no change to unmap that, if we work with page pool.
> > > > >
> > > > > I mean if we have a fallback, there would be no need to release t=
hese
> > > > > pages but put them into a link list.
> > > >
> > > >
> > > > What fallback?
> > >
> > > https://lore.kernel.org/netdev/1519607771-20613-1-git-send-email-mst@=
redhat.com/
> > >
> > > >
> > > > If we put the pages to the link list, why we use the page pool?
> > >
> > > The size of the cache and ptr_ring needs to be fixed.
> > >
> > > Again, as explained above, it needs more benchmarks and looks like a
> > > separate topic.
> > >
> > > >
> > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > > If we were to unmap pages each time before
> > > > > > > > returning them to the pool, we would negate the benefits of=
 bypassing the
> > > > > > > > mapping and unmapping process altogether.
> > > > > > >
> > > > > > > Yes, but the problem in this approach is that it creates a co=
rner
> > > > > > > exception where dma_addr is used outside the page pool.
> > > > > >
> > > > > > YES. This is a corner exception. We need to introduce this case=
 to the page
> > > > > > pool.
> > > > > >
> > > > > > So for introducing the page-pool to virtio-net(not only for big=
 mode),
> > > > > > we may need to push the page-pool to support dma by drivers.
> > > > >
> > > > > Adding Jesper for some comments.
> > > > >
> > > > > >
> > > > > > Back to this patch set, I think we should keep the virtio-net t=
o manage
> > > > > > the pages.
> > > > > >
> > > > > > What do you think?
> > > > >
> > > > > I might be wrong, but I think if we need to either
> > > > >
> > > > > 1) seek a way to manage the pages by yourself but not touching pa=
ge
> > > > > pool metadata (or Jesper is fine with this)
> > > >
> > > > Do you mean working with page pool or not?
> > > >
> > >
> > > I meant if Jesper is fine with reusing page pool metadata like this p=
atch.
> > >
> > > > If we manage the pages by self(no page pool), we do not care the me=
tadata is for
> > > > page pool or not. We just use the space of pages like the "private".
> > >
> > > That's also fine.
> > >
> > > >
> > > >
> > > > > 2) optimize the unmap for page pool
> > > > >
> > > > > or even
> > > > >
> > > > > 3) just do dma_unmap before returning the page back to the page p=
ool,
> > > > > we don't get all the benefits of page pool but we end up with sim=
ple
> > > > > codes (no fallback for premapping).
> > > >
> > > > I am ok for this.
> > >
> > > Right, we just need to make sure there's no performance regression,
> > > then it would be fine.
> > >
> > > I see for example mana did this as well.
> >
> > I think we should not use page pool directly now,
> > because the mana does not need a space to store the dma address.
> > We need to store the dma address for unmapping.
> >
> > If we use page pool without PP_FLAG_DMA_MAP, then store the dma address=
 by
> > page.dma_addr, I think that is not safe.
>
> Jesper, could you comment on this?
>
> >
> > I think the way of this patch set is fine.
>
> So it reuses page pool structure in the page structure for another use ca=
se.
>
> > We just use the
> > space of the page whatever it is page pool or not to store
> > the link and dma address.
>
> Probably because we've already "abused" page->private. I would leave
> it for other maintainers to decide.

If we do not want to use the elements of the page directly,
the page pool is a good way.

But we must make the page pool to work without PP_FLAG_DMA_MAP, because the
virtio-net must use the DMA APIs wrapped by virtio core.

And we still need to store the dma address, because virtio-net
can not access the descs directly.

@Jesper can we setup the page pool without PP_FLAG_DMA_MAP,
and call page_pool_set_dma_addr() from the virtio-net driver?

Thanks.



>
> Thanks
>
> >
> > Thanks.
> >
> > >
> > > Thanks
> > >
> > > >
> > > >
> > > > Thanks.
> > > >
> > > > >
> > > > > Thanks
> > > > >
> > > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > > Maybe for big mode it doesn't matter too much if there's no
> > > > > > > performance improvement.
> > > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > > > >
> > > > > > > > Thanks.
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Thanks
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Thanks.
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Thanks
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> > >
> >
>

