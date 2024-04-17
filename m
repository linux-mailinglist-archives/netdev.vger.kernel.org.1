Return-Path: <netdev+bounces-88546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9168A7A30
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 03:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06CDF1C21535
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 01:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC31A47;
	Wed, 17 Apr 2024 01:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ivbR6+sw"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780A51869
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 01:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713317904; cv=none; b=mvHt52M/JaifMMi72zgzDu0TWXE9jdRof6Ab35V9WmZZJ7X/tZKGIIYKx0Xw0/V2/V5716X+WhMrHjawYJlaw4d1tNOnYY1yRmwKr12Grx0xOqOR1Vdmn/bmj+PxZYYitEOhAW58rR2haTA9qNSMuH4aweswT+URE6COouVHLe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713317904; c=relaxed/simple;
	bh=XYy9Isa2OXSpnKXZDFZKqsRCePlaEiKfXC7tWS6hd/Y=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=qw0XlMHdaf3p62ouJTLammDi1Ktu0HuswEO6Um0uzMeCfDAiRKG6FGMui7pJLCg/yx2UBseAS6hrvsRtw01iTMOw8b3a0ieB5iPHMRyA+ir4C3DwGwVkLdWUKavRt8537kaGi0LWCwg7qgiETViOTFYfZ58caX+66e4XctO6X7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ivbR6+sw; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713317893; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=Dfa5/XsymM+1VO3owCoMsUlalGUZM+/pcMm5UpkBLjE=;
	b=ivbR6+swo5o0vyBuSnu/P+tuPJiq49ITwZU7S7U2OPi06fwCHwiUvfCi3xsz6dFqOMs6exBkxm++VfyWzVgO/K4YWjp7+Vun45UgxYpPknHhCu50aImsZ45wZb+MvqSAV08Zm3SIBu0RjCM8xALiNU0GhBsUzda7xSgWp7OYJNw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W4jORDl_1713317891;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4jORDl_1713317891)
          by smtp.aliyun-inc.com;
          Wed, 17 Apr 2024 09:38:12 +0800
Message-ID: <1713317444.7698638-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 3/6] virtio_net: replace private by pp struct inside page
Date: Wed, 17 Apr 2024 09:30:44 +0800
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
In-Reply-To: <CACGkMEuK0VkqtNfZ1BUw+SW=gdasEegTMfufS-47NV4bCh3Seg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 16 Apr 2024 11:24:53 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Apr 15, 2024 at 5:04=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Mon, 15 Apr 2024 16:56:45 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Mon, Apr 15, 2024 at 4:50=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > On Mon, 15 Apr 2024 14:43:24 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Mon, Apr 15, 2024 at 10:35=E2=80=AFAM Xuan Zhuo <xuanzhuo@linu=
x.alibaba.com> wrote:
> > > > > >
> > > > > > On Fri, 12 Apr 2024 13:49:12 +0800, Jason Wang <jasowang@redhat=
.com> wrote:
> > > > > > > On Fri, Apr 12, 2024 at 1:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@l=
inux.alibaba.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, 12 Apr 2024 12:47:55 +0800, Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > > > > On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanz=
huo@linux.alibaba.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Now, we chain the pages of big mode by the page's priva=
te variable.
> > > > > > > > > > But a subsequent patch aims to make the big mode to sup=
port
> > > > > > > > > > premapped mode. This requires additional space to store=
 the dma addr.
> > > > > > > > > >
> > > > > > > > > > Within the sub-struct that contains the 'private', ther=
e is no suitable
> > > > > > > > > > variable for storing the DMA addr.
> > > > > > > > > >
> > > > > > > > > >                 struct {        /* Page cache and anony=
mous pages */
> > > > > > > > > >                         /**
> > > > > > > > > >                          * @lru: Pageout list, eg. acti=
ve_list protected by
> > > > > > > > > >                          * lruvec->lru_lock.  Sometimes=
 used as a generic list
> > > > > > > > > >                          * by the page owner.
> > > > > > > > > >                          */
> > > > > > > > > >                         union {
> > > > > > > > > >                                 struct list_head lru;
> > > > > > > > > >
> > > > > > > > > >                                 /* Or, for the Unevicta=
ble "LRU list" slot */
> > > > > > > > > >                                 struct {
> > > > > > > > > >                                         /* Always even,=
 to negate PageTail */
> > > > > > > > > >                                         void *__filler;
> > > > > > > > > >                                         /* Count page's=
 or folio's mlocks */
> > > > > > > > > >                                         unsigned int ml=
ock_count;
> > > > > > > > > >                                 };
> > > > > > > > > >
> > > > > > > > > >                                 /* Or, free page */
> > > > > > > > > >                                 struct list_head buddy_=
list;
> > > > > > > > > >                                 struct list_head pcp_li=
st;
> > > > > > > > > >                         };
> > > > > > > > > >                         /* See page-flags.h for PAGE_MA=
PPING_FLAGS */
> > > > > > > > > >                         struct address_space *mapping;
> > > > > > > > > >                         union {
> > > > > > > > > >                                 pgoff_t index;         =
 /* Our offset within mapping. */
> > > > > > > > > >                                 unsigned long share;   =
 /* share count for fsdax */
> > > > > > > > > >                         };
> > > > > > > > > >                         /**
> > > > > > > > > >                          * @private: Mapping-private op=
aque data.
> > > > > > > > > >                          * Usually used for buffer_head=
s if PagePrivate.
> > > > > > > > > >                          * Used for swp_entry_t if Page=
SwapCache.
> > > > > > > > > >                          * Indicates order in the buddy=
 system if PageBuddy.
> > > > > > > > > >                          */
> > > > > > > > > >                         unsigned long private;
> > > > > > > > > >                 };
> > > > > > > > > >
> > > > > > > > > > But within the page pool struct, we have a variable cal=
led
> > > > > > > > > > dma_addr that is appropriate for storing dma addr.
> > > > > > > > > > And that struct is used by netstack. That works to our =
advantage.
> > > > > > > > > >
> > > > > > > > > >                 struct {        /* page_pool used by ne=
tstack */
> > > > > > > > > >                         /**
> > > > > > > > > >                          * @pp_magic: magic value to av=
oid recycling non
> > > > > > > > > >                          * page_pool allocated pages.
> > > > > > > > > >                          */
> > > > > > > > > >                         unsigned long pp_magic;
> > > > > > > > > >                         struct page_pool *pp;
> > > > > > > > > >                         unsigned long _pp_mapping_pad;
> > > > > > > > > >                         unsigned long dma_addr;
> > > > > > > > > >                         atomic_long_t pp_ref_count;
> > > > > > > > > >                 };
> > > > > > > > > >
> > > > > > > > > > On the other side, we should use variables from the sam=
e sub-struct.
> > > > > > > > > > So this patch replaces the "private" with "pp".
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > > > ---
> > > > > > > > >
> > > > > > > > > Instead of doing a customized version of page pool, can w=
e simply
> > > > > > > > > switch to use page pool for big mode instead? Then we don=
't need to
> > > > > > > > > bother the dma stuffs.
> > > > > > > >
> > > > > > > >
> > > > > > > > The page pool needs to do the dma by the DMA APIs.
> > > > > > > > So we can not use the page pool directly.
> > > > > > >
> > > > > > > I found this:
> > > > > > >
> > > > > > > define PP_FLAG_DMA_MAP         BIT(0) /* Should page_pool do =
the DMA
> > > > > > >                                         * map/unmap
> > > > > > >
> > > > > > > It seems to work here?
> > > > > >
> > > > > >
> > > > > > I have studied the page pool mechanism and believe that we cann=
ot use it
> > > > > > directly. We can make the page pool to bypass the DMA operation=
s.
> > > > > > This allows us to handle DMA within virtio-net for pages alloca=
ted from the page
> > > > > > pool. Furthermore, we can utilize page pool helpers to associat=
e the DMA address
> > > > > > to the page.
> > > > > >
> > > > > > However, the critical issue pertains to unmapping. Ideally, we =
want to return
> > > > > > the mapped pages to the page pool and reuse them. In doing so, =
we can omit the
> > > > > > unmapping and remapping steps.
> > > > > >
> > > > > > Currently, there's a caveat: when the page pool cache is full, =
it disconnects
> > > > > > and releases the pages. When the pool hits its capacity, pages =
are relinquished
> > > > > > without a chance for unmapping.
> > > > >
> > > > > Technically, when ptr_ring is full there could be a fallback, but=
 then
> > > > > it requires expensive synchronization between producer and consum=
er.
> > > > > For virtio-net, it might not be a problem because add/get has been
> > > > > synchronized. (It might be relaxed in the future, actually we've
> > > > > already seen a requirement in the past for virito-blk).
> > > >
> > > > The point is that the page will be released by page pool directly,
> > > > we will have no change to unmap that, if we work with page pool.
> > >
> > > I mean if we have a fallback, there would be no need to release these
> > > pages but put them into a link list.
> >
> >
> > What fallback?
>
> https://lore.kernel.org/netdev/1519607771-20613-1-git-send-email-mst@redh=
at.com/
>
> >
> > If we put the pages to the link list, why we use the page pool?
>
> The size of the cache and ptr_ring needs to be fixed.
>
> Again, as explained above, it needs more benchmarks and looks like a
> separate topic.
>
> >
> >
> > >
> > > >
> > > > >
> > > > > > If we were to unmap pages each time before
> > > > > > returning them to the pool, we would negate the benefits of byp=
assing the
> > > > > > mapping and unmapping process altogether.
> > > > >
> > > > > Yes, but the problem in this approach is that it creates a corner
> > > > > exception where dma_addr is used outside the page pool.
> > > >
> > > > YES. This is a corner exception. We need to introduce this case to =
the page
> > > > pool.
> > > >
> > > > So for introducing the page-pool to virtio-net(not only for big mod=
e),
> > > > we may need to push the page-pool to support dma by drivers.
> > >
> > > Adding Jesper for some comments.
> > >
> > > >
> > > > Back to this patch set, I think we should keep the virtio-net to ma=
nage
> > > > the pages.
> > > >
> > > > What do you think?
> > >
> > > I might be wrong, but I think if we need to either
> > >
> > > 1) seek a way to manage the pages by yourself but not touching page
> > > pool metadata (or Jesper is fine with this)
> >
> > Do you mean working with page pool or not?
> >
>
> I meant if Jesper is fine with reusing page pool metadata like this patch.
>
> > If we manage the pages by self(no page pool), we do not care the metada=
ta is for
> > page pool or not. We just use the space of pages like the "private".
>
> That's also fine.
>
> >
> >
> > > 2) optimize the unmap for page pool
> > >
> > > or even
> > >
> > > 3) just do dma_unmap before returning the page back to the page pool,
> > > we don't get all the benefits of page pool but we end up with simple
> > > codes (no fallback for premapping).
> >
> > I am ok for this.
>
> Right, we just need to make sure there's no performance regression,
> then it would be fine.
>
> I see for example mana did this as well.

I think we should not use page pool directly now,
because the mana does not need a space to store the dma address.
We need to store the dma address for unmapping.

If we use page pool without PP_FLAG_DMA_MAP, then store the dma address by
page.dma_addr, I think that is not safe.

I think the way of this patch set is fine. We just use the
space of the page whatever it is page pool or not to store
the link and dma address.

Thanks.

>
> Thanks
>
> >
> >
> > Thanks.
> >
> > >
> > > Thanks
> > >
> > >
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > Maybe for big mode it doesn't matter too much if there's no
> > > > > performance improvement.
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > > > >
> > > > > > > > Thanks.
> > > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Thanks
> > > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>
>

