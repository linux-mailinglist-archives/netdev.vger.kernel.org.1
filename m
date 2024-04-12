Return-Path: <netdev+bounces-87263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362DD8A261B
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 08:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680E41C238C9
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 06:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0CB24A03;
	Fri, 12 Apr 2024 06:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="L6O17afr"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19FB3C6A4
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 06:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712901802; cv=none; b=o5O4MBsvHzCIEC5bRThNsXPXOE83ovXFob/aYfi8zHL4/UanzkaCwXpxD089iJjM/o6FInXhCSJhGtyLahCsqFjU9XjJMZ80IVePEgOyv7pJglhgcxnA1x3+VYRlMUfGknq5NPi5W3jl1CwlIf+SU0W7i6aDV36Qi4Pmdu0GYVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712901802; c=relaxed/simple;
	bh=z6QcHzE7h6wFf6b1Z+TzloXNQh60TXep+3g1tzvJ3io=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=GMNbdp6LlzHEj0ZBu8FySdHrHKjvuxtiYpKwsPnoOtvuhyd3lJycqCTwgTdI1B+u8mz+mmEeesm1L32xNQx85vrNTux+3R6lVQzABml4RELTdUpa3D0iF6J1wNdE9WQuKwEA2X/PZw9oDviXfNU6r/OnNgNi3zrvViIWz43moQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=L6O17afr; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712901796; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=SKN5uyIY4XejNu7YqRv//+bRntXAg0ww/QbASd8Jh3I=;
	b=L6O17afrJQCYfbZGTcCHc/bzkxvddCKS5Qag3lLofSi1qglKbq/4Sfju4qThLKFMbH7XEnbkUwY11POqmS81wTgjsUsOgxaWdw8ZkuiihKn4/O/NW0IDatsIt+NGW8j1udFjACDpevIIdYCUEM7g5UHYXEHwsKBEKWQ0d9O4sdw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W4NHXsH_1712901794;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4NHXsH_1712901794)
          by smtp.aliyun-inc.com;
          Fri, 12 Apr 2024 14:03:15 +0800
Message-ID: <1712901766.7811587-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 3/6] virtio_net: replace private by pp struct inside page
Date: Fri, 12 Apr 2024 14:02:46 +0800
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

You are right. I missed this. I will try.

Thanks.


>
> It seems to work here?
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

