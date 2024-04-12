Return-Path: <netdev+bounces-87261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634108A25D4
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 07:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DAE61C22B76
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 05:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F99018E1A;
	Fri, 12 Apr 2024 05:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="n/jrWEfo"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D986EDDA5
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 05:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712900349; cv=none; b=rElQfbXDsbcfnNgH6wwCcPD9rVZgWdeCcnvyBInX5R6+BXV+0D3hyNB/3IrmPKEPI8FI9J+vozm/3iHahf4q+DsCQxUe8Eyirx7jVZa03GFdnKNelsKUCXQ3o+3ghZcse2NrA8YH727WqarUSPPDIwqTAwcrzBFfabz3KnM5T4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712900349; c=relaxed/simple;
	bh=sHysvnVMxlqsL4kzrdtdl23rm4dkCKjBVzEkCM7uiqg=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=B7cYQ6B72E/Cc+UBuPr0M4txu5iiJSq+mgVHmMvSqpLtJGkw0SptBLkhguPiBRngzpvyieCYiq0wcw726PRqIQuoMiEukbDnGRXyglgOIFo3z4rq2nQ20pp2bRoqTtP2WGaiVv3+cJDy7DXqTaEo5v4zAY0yD3XwoANyQyyFd2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=n/jrWEfo; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712900344; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=bvFOQnV+LKlRw05I3Ndd3EmaIDJ4aEn27omjImefSRc=;
	b=n/jrWEfoeXLeaMXdKX6lYuX6p8EovDV/FLufmiWzbhMBHROVFxW63xbHxS2xVUUiaq/vXgeCAODPWSs0+/s6kScU5jrODrg51n+XcBr+TpDdw70Syv7R7VemjEUoZ2Y03rh2gRimiNuNDoCXRNlaxE62+pKgbe2LryQWp5qjrpc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W4NB4CD_1712900343;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4NB4CD_1712900343)
          by smtp.aliyun-inc.com;
          Fri, 12 Apr 2024 13:39:04 +0800
Message-ID: <1712900153.3715405-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 3/6] virtio_net: replace private by pp struct inside page
Date: Fri, 12 Apr 2024 13:35:53 +0800
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
In-Reply-To: <CACGkMEsC7AEi2SOmqNOo6KJDpx92raGWYwYzxZ_MVhmnco_LYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 12 Apr 2024 12:47:55 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> >
> > Now, we chain the pages of big mode by the page's private variable.
> > But a subsequent patch aims to make the big mode to support
> > premapped mode. This requires additional space to store the dma addr.
> >
> > Within the sub-struct that contains the 'private', there is no suitable
> > variable for storing the DMA addr.
> >
> >                 struct {        /* Page cache and anonymous pages */
> >                         /**
> >                          * @lru: Pageout list, eg. active_list protecte=
d by
> >                          * lruvec->lru_lock.  Sometimes used as a gener=
ic list
> >                          * by the page owner.
> >                          */
> >                         union {
> >                                 struct list_head lru;
> >
> >                                 /* Or, for the Unevictable "LRU list" s=
lot */
> >                                 struct {
> >                                         /* Always even, to negate PageT=
ail */
> >                                         void *__filler;
> >                                         /* Count page's or folio's mloc=
ks */
> >                                         unsigned int mlock_count;
> >                                 };
> >
> >                                 /* Or, free page */
> >                                 struct list_head buddy_list;
> >                                 struct list_head pcp_list;
> >                         };
> >                         /* See page-flags.h for PAGE_MAPPING_FLAGS */
> >                         struct address_space *mapping;
> >                         union {
> >                                 pgoff_t index;          /* Our offset w=
ithin mapping. */
> >                                 unsigned long share;    /* share count =
for fsdax */
> >                         };
> >                         /**
> >                          * @private: Mapping-private opaque data.
> >                          * Usually used for buffer_heads if PagePrivate.
> >                          * Used for swp_entry_t if PageSwapCache.
> >                          * Indicates order in the buddy system if PageB=
uddy.
> >                          */
> >                         unsigned long private;
> >                 };
> >
> > But within the page pool struct, we have a variable called
> > dma_addr that is appropriate for storing dma addr.
> > And that struct is used by netstack. That works to our advantage.
> >
> >                 struct {        /* page_pool used by netstack */
> >                         /**
> >                          * @pp_magic: magic value to avoid recycling non
> >                          * page_pool allocated pages.
> >                          */
> >                         unsigned long pp_magic;
> >                         struct page_pool *pp;
> >                         unsigned long _pp_mapping_pad;
> >                         unsigned long dma_addr;
> >                         atomic_long_t pp_ref_count;
> >                 };
> >
> > On the other side, we should use variables from the same sub-struct.
> > So this patch replaces the "private" with "pp".
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
>
> Instead of doing a customized version of page pool, can we simply
> switch to use page pool for big mode instead? Then we don't need to
> bother the dma stuffs.


The page pool needs to do the dma by the DMA APIs.
So we can not use the page pool directly.

Thanks.


>
> Thanks
>

