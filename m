Return-Path: <netdev+bounces-87800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E30F18A4AD2
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 10:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203EA1C212AE
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 08:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EDE3A29A;
	Mon, 15 Apr 2024 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sS7M+x35"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324533BBC1
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170995; cv=none; b=bU4hrrCHtOUSIrI9XHBBDl+xMjCH/HZM1ouxS32J46gCpSblu08sOTlK8SCEM0Lk7x7tjCcsUJwte9PHMh8zM6/5gKcB50Yc2hIcx2eKTqpaxVc4KRZkBEr7gyynR7jo3QnqvZDin9kkuN4nTgI8gWAD2S7BcB6VrxUc97A7I+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170995; c=relaxed/simple;
	bh=lLt5r88o8LAtphS3/PGZVZ6F3+WFfNtfQ3Y6Y+3qncM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=DE1ZuhC8aKRYvo5MTK+zJMa8tWC9NKcB0Amt339MBH9WpAyHJJu3hkF56N7IwJ3CswjwBbl01BXRyOXV+/ziWA48YOCEdpO/uUiTtWSpjK4RpT7X1Omtp6SWp4e89kMfIuM6Sz2ihpBH+sxGRayJZXaocv4y3cgwgPvYtOYq//g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sS7M+x35; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713170989; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=uMkhS7BsxeL4oglM0pwFdRZ0sutgkDQPGrAjxBhZbGc=;
	b=sS7M+x35Wtu4vNlGK3S2lGxxHduRo5I8g15Nz6ON75SsTKo2Rt4mAjdvOuCvf1LTlMPCkXoybhOVGmR1gOY8rQvJK76NlK1vRSH8K9aelCERhdbT/a3NUDxtFJP5E86qTKXTOx6ozoJKb+1yOaw1dyk2PB5B5gIlMjwWygIwjt0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W4YrqFd_1713170988;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4YrqFd_1713170988)
          by smtp.aliyun-inc.com;
          Mon, 15 Apr 2024 16:49:49 +0800
Message-ID: <1713170201.06163-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 3/6] virtio_net: replace private by pp struct inside page
Date: Mon, 15 Apr 2024 16:36:41 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com>
 <20240411025127.51945-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEsC7AEi2SOmqNOo6KJDpx92raGWYwYzxZ_MVhmnco_LYQ@mail.gmail.com>
 <1712900153.3715405-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvKC6JpsznW57GgxFBMhmMSk4eCZPvESpew9j5qfp9=RA@mail.gmail.com>
 <1713146919.8867755-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvmaH9NE-5VDBPpZOpAAg4bX39Lf0-iGiYzxdV5JuZWww@mail.gmail.com>
In-Reply-To: <CACGkMEvmaH9NE-5VDBPpZOpAAg4bX39Lf0-iGiYzxdV5JuZWww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 15 Apr 2024 14:43:24 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Apr 15, 2024 at 10:35=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> >
> > On Fri, 12 Apr 2024 13:49:12 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Fri, Apr 12, 2024 at 1:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > On Fri, 12 Apr 2024 12:47:55 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linu=
x.alibaba.com> wrote:
> > > > > >
> > > > > > Now, we chain the pages of big mode by the page's private varia=
ble.
> > > > > > But a subsequent patch aims to make the big mode to support
> > > > > > premapped mode. This requires additional space to store the dma=
 addr.
> > > > > >
> > > > > > Within the sub-struct that contains the 'private', there is no =
suitable
> > > > > > variable for storing the DMA addr.
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
> > > > > > But within the page pool struct, we have a variable called
> > > > > > dma_addr that is appropriate for storing dma addr.
> > > > > > And that struct is used by netstack. That works to our advantag=
e.
> > > > > >
> > > > > >                 struct {        /* page_pool used by netstack */
> > > > > >                         /**
> > > > > >                          * @pp_magic: magic value to avoid recy=
cling non
> > > > > >                          * page_pool allocated pages.
> > > > > >                          */
> > > > > >                         unsigned long pp_magic;
> > > > > >                         struct page_pool *pp;
> > > > > >                         unsigned long _pp_mapping_pad;
> > > > > >                         unsigned long dma_addr;
> > > > > >                         atomic_long_t pp_ref_count;
> > > > > >                 };
> > > > > >
> > > > > > On the other side, we should use variables from the same sub-st=
ruct.
> > > > > > So this patch replaces the "private" with "pp".
> > > > > >
> > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > ---
> > > > >
> > > > > Instead of doing a customized version of page pool, can we simply
> > > > > switch to use page pool for big mode instead? Then we don't need =
to
> > > > > bother the dma stuffs.
> > > >
> > > >
> > > > The page pool needs to do the dma by the DMA APIs.
> > > > So we can not use the page pool directly.
> > >
> > > I found this:
> > >
> > > define PP_FLAG_DMA_MAP         BIT(0) /* Should page_pool do the DMA
> > >                                         * map/unmap
> > >
> > > It seems to work here?
> >
> >
> > I have studied the page pool mechanism and believe that we cannot use it
> > directly. We can make the page pool to bypass the DMA operations.
> > This allows us to handle DMA within virtio-net for pages allocated from=
 the page
> > pool. Furthermore, we can utilize page pool helpers to associate the DM=
A address
> > to the page.
> >
> > However, the critical issue pertains to unmapping. Ideally, we want to =
return
> > the mapped pages to the page pool and reuse them. In doing so, we can o=
mit the
> > unmapping and remapping steps.
> >
> > Currently, there's a caveat: when the page pool cache is full, it disco=
nnects
> > and releases the pages. When the pool hits its capacity, pages are reli=
nquished
> > without a chance for unmapping.
>
> Technically, when ptr_ring is full there could be a fallback, but then
> it requires expensive synchronization between producer and consumer.
> For virtio-net, it might not be a problem because add/get has been
> synchronized. (It might be relaxed in the future, actually we've
> already seen a requirement in the past for virito-blk).

The point is that the page will be released by page pool directly,
we will have no change to unmap that, if we work with page pool.

>
> > If we were to unmap pages each time before
> > returning them to the pool, we would negate the benefits of bypassing t=
he
> > mapping and unmapping process altogether.
>
> Yes, but the problem in this approach is that it creates a corner
> exception where dma_addr is used outside the page pool.

YES. This is a corner exception. We need to introduce this case to the page
pool.

So for introducing the page-pool to virtio-net(not only for big mode),
we may need to push the page-pool to support dma by drivers.

Back to this patch set, I think we should keep the virtio-net to manage
the pages.

What do you think?

Thanks

>
> Maybe for big mode it doesn't matter too much if there's no
> performance improvement.
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

