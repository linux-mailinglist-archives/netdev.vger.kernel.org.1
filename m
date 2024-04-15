Return-Path: <netdev+bounces-87757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB828A4708
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 04:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F2128163A
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 02:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD91A14F6C;
	Mon, 15 Apr 2024 02:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uY4Jy9It"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A293C3C
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 02:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713148523; cv=none; b=s82HrgppIkPTFbmF5ewWInjtXg17hzd/l9BR5WTQP3DH//wNuuE5UeNSaAV0kOjjUaUpl9LdUR9coIII0WEBMbIljO6GJ+opld3MhZGAMF+BOQCwcZg5d13rV7zw206sQQIwV5FrvfAiwt9052NC6SSXy6OwO0gGf16Jcsdzpl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713148523; c=relaxed/simple;
	bh=CKEmjckkZ/5OhNODqPdHhtpmMdOSoGaB7CZyvoXPMA8=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=T23SCuGVskK2SkfTzJ1f1wEUt1zbE1gixgVOolj/Hj8HaKWQ1K1uNIGD6MueatOTQMSClZhBomB+aYT9kjdzPw27ZYXQuXmuegUOLGzCgC87jTvTr0KohbvlqAlTI4rMWl9DLNT5/urI/oxQZQaDW1suFluWvnySUDFW4Di2E/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uY4Jy9It; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713148518; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=LeyJmU6jakFyaJE2bOU0OfusitmyQM73vIi7eL5BGlo=;
	b=uY4Jy9ItnH4KPgXaTRmyo6M4YwQ1abgIdQX/9qOD08AhtUws4FZxjFn5rtulWpzqMPVBtSdtykjkkh3gFunDxUdR3bMWqpCQ+UdT6SsVn208rP/0W2kJV68FB6Gr2NVR5g5m5rUSCZxzaahUYXL+TDQG7s3Z+9WQ+GMzL5I9azQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W4TtE.-_1713148517;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4TtE.-_1713148517)
          by smtp.aliyun-inc.com;
          Mon, 15 Apr 2024 10:35:18 +0800
Message-ID: <1713146919.8867755-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 3/6] virtio_net: replace private by pp struct inside page
Date: Mon, 15 Apr 2024 10:08:39 +0800
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
In-Reply-To: <CACGkMEvKC6JpsznW57GgxFBMhmMSk4eCZPvESpew9j5qfp9=RA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 12 Apr 2024 13:49:12 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Fri, Apr 12, 2024 at 1:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Fri, 12 Apr 2024 12:47:55 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.al=
ibaba.com> wrote:
> > > >
> > > > Now, we chain the pages of big mode by the page's private variable.
> > > > But a subsequent patch aims to make the big mode to support
> > > > premapped mode. This requires additional space to store the dma add=
r.
> > > >
> > > > Within the sub-struct that contains the 'private', there is no suit=
able
> > > > variable for storing the DMA addr.
> > > >
> > > >                 struct {        /* Page cache and anonymous pages */
> > > >                         /**
> > > >                          * @lru: Pageout list, eg. active_list prot=
ected by
> > > >                          * lruvec->lru_lock.  Sometimes used as a g=
eneric list
> > > >                          * by the page owner.
> > > >                          */
> > > >                         union {
> > > >                                 struct list_head lru;
> > > >
> > > >                                 /* Or, for the Unevictable "LRU lis=
t" slot */
> > > >                                 struct {
> > > >                                         /* Always even, to negate P=
ageTail */
> > > >                                         void *__filler;
> > > >                                         /* Count page's or folio's =
mlocks */
> > > >                                         unsigned int mlock_count;
> > > >                                 };
> > > >
> > > >                                 /* Or, free page */
> > > >                                 struct list_head buddy_list;
> > > >                                 struct list_head pcp_list;
> > > >                         };
> > > >                         /* See page-flags.h for PAGE_MAPPING_FLAGS =
*/
> > > >                         struct address_space *mapping;
> > > >                         union {
> > > >                                 pgoff_t index;          /* Our offs=
et within mapping. */
> > > >                                 unsigned long share;    /* share co=
unt for fsdax */
> > > >                         };
> > > >                         /**
> > > >                          * @private: Mapping-private opaque data.
> > > >                          * Usually used for buffer_heads if PagePri=
vate.
> > > >                          * Used for swp_entry_t if PageSwapCache.
> > > >                          * Indicates order in the buddy system if P=
ageBuddy.
> > > >                          */
> > > >                         unsigned long private;
> > > >                 };
> > > >
> > > > But within the page pool struct, we have a variable called
> > > > dma_addr that is appropriate for storing dma addr.
> > > > And that struct is used by netstack. That works to our advantage.
> > > >
> > > >                 struct {        /* page_pool used by netstack */
> > > >                         /**
> > > >                          * @pp_magic: magic value to avoid recyclin=
g non
> > > >                          * page_pool allocated pages.
> > > >                          */
> > > >                         unsigned long pp_magic;
> > > >                         struct page_pool *pp;
> > > >                         unsigned long _pp_mapping_pad;
> > > >                         unsigned long dma_addr;
> > > >                         atomic_long_t pp_ref_count;
> > > >                 };
> > > >
> > > > On the other side, we should use variables from the same sub-struct.
> > > > So this patch replaces the "private" with "pp".
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > >
> > > Instead of doing a customized version of page pool, can we simply
> > > switch to use page pool for big mode instead? Then we don't need to
> > > bother the dma stuffs.
> >
> >
> > The page pool needs to do the dma by the DMA APIs.
> > So we can not use the page pool directly.
>
> I found this:
>
> define PP_FLAG_DMA_MAP         BIT(0) /* Should page_pool do the DMA
>                                         * map/unmap
>
> It seems to work here?


I have studied the page pool mechanism and believe that we cannot use it
directly. We can make the page pool to bypass the DMA operations.
This allows us to handle DMA within virtio-net for pages allocated from the=
 page
pool. Furthermore, we can utilize page pool helpers to associate the DMA ad=
dress
to the page.

However, the critical issue pertains to unmapping. Ideally, we want to retu=
rn
the mapped pages to the page pool and reuse them. In doing so, we can omit =
the
unmapping and remapping steps.

Currently, there's a caveat: when the page pool cache is full, it disconnec=
ts
and releases the pages. When the pool hits its capacity, pages are relinqui=
shed
without a chance for unmapping. If we were to unmap pages each time before
returning them to the pool, we would negate the benefits of bypassing the
mapping and unmapping process altogether.

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

