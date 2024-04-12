Return-Path: <netdev+bounces-87262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F118A25EA
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 07:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC551F22699
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 05:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7841BF24;
	Fri, 12 Apr 2024 05:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EFx1CTp1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6751BC53
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 05:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712900969; cv=none; b=lAWFJxZkVXzm7s9RwAuGUs0kWillcPYvGGylEXRbOr4gPuMQgMXDBId3RvD5ASQurJaYkvtvOriehuMMNYw4n8L+6wdTdzk1QVmOdoZ8G4CmkNlOBHRGpaPmzvL5gk1LQtL17Jq/2IdyzH1xi38Ah6KKjk9zoTphVW43YwUiMLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712900969; c=relaxed/simple;
	bh=MxGmMWmSVSkaCPjlFYjuNejuLduyr3Of8opSkW9n3Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tggE2JWcFS9j7yYA9GK6+ZRnZARhwMqQeWAPsdeGojyCtKTTcmyodHShVq7JD+swBa1XXkvoyrr8hglJS8nsFwiZzFpOnv69mYnYYDUUVk4mt2kvcOq55+PGD/+auaUmB4lYqSM/M3IAJQvCapf0zN3R9zBqfzoQH9gGKa1gxjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EFx1CTp1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712900967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42h6EUBNEa5RNiLHCZYTOwlWF2yMg6+N/yR4RjFq5UE=;
	b=EFx1CTp14WnKQUEl2yutZE+S/CcXyTbws21GhWQsUa7tCOS95SWI3TrdgpYIEPTdwMX2nC
	NswequFcPoT0H3NYKtPK6f3AAO+VXjW5PWiHn1/GJBJJXX0rLdo6zOJhdkihJsQ8MdUgVz
	GhMCqhWuFdCpBR5y8wm/vmeHmNi8Lwg=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-H26MVRW9MYadlM1MHM-qQw-1; Fri, 12 Apr 2024 01:49:25 -0400
X-MC-Unique: H26MVRW9MYadlM1MHM-qQw-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6ed25ed4a5fso626574b3a.1
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 22:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712900964; x=1713505764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42h6EUBNEa5RNiLHCZYTOwlWF2yMg6+N/yR4RjFq5UE=;
        b=GFh/21+ySk9etcTqzzOsICgAdKr0FLWz0HwOvce8/jLxiM6vIHgxp46l2hAsf75GMS
         BpbsKOdK6Yu4qnrpaWi6Rvfz4FdZ/pztM1ayODCLIYbnLkuq/ZAeD9YpvjeRyAwvL494
         FlhtFNBhQUxW/w4gEw2lhNdsfoxVwZKvlQHuWGJ4OMVTE1jDFBGyktjczY8C2iJMN9kx
         L3t8lj2lDQaUvsGeDDe7iI7fHkKcIhW2M478NYgSmSh/WcAzQILLhlY7HX16n7dOhOfb
         8S4zGeqK+T+vfbqEDRIni9JCI14D8uZwHj1PnXD7/DHuFmeUT/+hruN84KdaxWOXIuR2
         B6PA==
X-Forwarded-Encrypted: i=1; AJvYcCUhtFXGuqkgrmWMyrqdAKmnkQc/uDGYSzA9cRRTKaC1LeP0byYlMybB3YG1csYPrbEFZDjaiJ+ZuE7DcvNhvg66Qq+Sk35a
X-Gm-Message-State: AOJu0YzUDGiGJ+Tptt6C7vsdzp+fFqJZiHISvnSABU4Rv249TSKByZ9R
	vQmzciHRtCYhLP5HewrS2ZvdDRAYFyUyUARjoxyb8Ev4nrs8Y1fDE86pk5W72s679ZttLcGcnfD
	HkkT9XJaQ2xTl8R7lHVwCEmjHJS2sJVfsk71YturUBWVkU0QAFlvMm3lVJNTNitkRrbwLOy9cvI
	On+CSc8kvAqXJ0aZOsNL2JZNTMdU4Y
X-Received: by 2002:a05:6a20:550a:b0:1a9:4343:765f with SMTP id ko10-20020a056a20550a00b001a94343765fmr1995402pzb.23.1712900964287;
        Thu, 11 Apr 2024 22:49:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUpDzMeQrzX/DTOLr+fvUdhwDir5bUUkQ7frRcm8uC2c0oNJ/e89gkZZIOS80zxLcxMhnO3Ff/B2Fjh8VNiKI=
X-Received: by 2002:a05:6a20:550a:b0:1a9:4343:765f with SMTP id
 ko10-20020a056a20550a00b001a94343765fmr1995389pzb.23.1712900963995; Thu, 11
 Apr 2024 22:49:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com>
 <20240411025127.51945-4-xuanzhuo@linux.alibaba.com> <CACGkMEsC7AEi2SOmqNOo6KJDpx92raGWYwYzxZ_MVhmnco_LYQ@mail.gmail.com>
 <1712900153.3715405-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1712900153.3715405-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 12 Apr 2024 13:49:12 +0800
Message-ID: <CACGkMEvKC6JpsznW57GgxFBMhmMSk4eCZPvESpew9j5qfp9=RA@mail.gmail.com>
Subject: Re: [PATCH vhost 3/6] virtio_net: replace private by pp struct inside page
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 1:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Fri, 12 Apr 2024 12:47:55 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> > >
> > > Now, we chain the pages of big mode by the page's private variable.
> > > But a subsequent patch aims to make the big mode to support
> > > premapped mode. This requires additional space to store the dma addr.
> > >
> > > Within the sub-struct that contains the 'private', there is no suitab=
le
> > > variable for storing the DMA addr.
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
> > > But within the page pool struct, we have a variable called
> > > dma_addr that is appropriate for storing dma addr.
> > > And that struct is used by netstack. That works to our advantage.
> > >
> > >                 struct {        /* page_pool used by netstack */
> > >                         /**
> > >                          * @pp_magic: magic value to avoid recycling =
non
> > >                          * page_pool allocated pages.
> > >                          */
> > >                         unsigned long pp_magic;
> > >                         struct page_pool *pp;
> > >                         unsigned long _pp_mapping_pad;
> > >                         unsigned long dma_addr;
> > >                         atomic_long_t pp_ref_count;
> > >                 };
> > >
> > > On the other side, we should use variables from the same sub-struct.
> > > So this patch replaces the "private" with "pp".
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> >
> > Instead of doing a customized version of page pool, can we simply
> > switch to use page pool for big mode instead? Then we don't need to
> > bother the dma stuffs.
>
>
> The page pool needs to do the dma by the DMA APIs.
> So we can not use the page pool directly.

I found this:

define PP_FLAG_DMA_MAP         BIT(0) /* Should page_pool do the DMA
                                        * map/unmap

It seems to work here?

Thanks

>
> Thanks.
>
>
> >
> > Thanks
> >
>


