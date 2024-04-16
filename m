Return-Path: <netdev+bounces-88160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE318A61AB
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 05:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 366D0286F26
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 03:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474F617550;
	Tue, 16 Apr 2024 03:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MuL5aw9D"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CB612E4A
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 03:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237911; cv=none; b=KsSjr2t4C2jnuAwZSbmS553BLCHzTnQkRMSMXIqM0Znt+WvEQBsZweLS/4Lv6hcU8gckBpSsXzaRswnV904w9SBoEc/H/udX5OK0vlKW5nLASyni9xvVp36fA9dGlwDe33rqyd08l/DQkeDfrUuncJHV0afx2BlRgJn9+mp9iGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237911; c=relaxed/simple;
	bh=8A16QGxujOJrY281LR2KvSv1guy3RtJH4ac+mbjvWKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/tRizLqeOyewOAfYKu7adbWgK1y4Pgmmb+eFoVT4KKdbEGAbJ3RrOnWiXUjFV8JCAN+1hShN15+rfelNZ0gDuwZ0PxYjHjaLOVxoBhs6dzIrwCfyiQY2ZYfl8zkmB4aC3OCd5SLSz8mSfsId0guw1Df+lbBzlfLsWkYMlVdJlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MuL5aw9D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713237908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YJ+r3P68HduV7lu+or8I4rKJxU4Dajws3HoDSEZrVNc=;
	b=MuL5aw9DE8L0v5GB8xXk9yPtvxT3w+o5jIglNnMRPlP41GsyYYv50CM7aPmHc8hxV6TFvl
	ZlcbTm7CV7b+m7M2o61n90ZZroTjPRV8SAiELep9OCoEka0fBuOuNkGFhFzUYc26AmPe9A
	dLQz+taBcBSpim/Yt3wXhiIOwL7N0YE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-wkJA-F_BPaOqxtw7thzbpw-1; Mon, 15 Apr 2024 23:25:06 -0400
X-MC-Unique: wkJA-F_BPaOqxtw7thzbpw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a2d197ac0aso3702090a91.2
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 20:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713237905; x=1713842705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJ+r3P68HduV7lu+or8I4rKJxU4Dajws3HoDSEZrVNc=;
        b=tDqqHRWWpG6IpS5f6kImiBDt9jJ3WX6TSDK68RJblpGbXH3KforK1h0I/khYFFZcyX
         sZhzEEjwJl01nXQmFGBQpt3PUbNMsxhw3kzZghef1x6LRUiljXBn70LVKrzF+cSLPT41
         IV1+17f8e7xzFMOCWqKYUYQCbj9TuT0O/3N7ElFmLptCckrGW2cy08Mn6/hRGV247l5Q
         FhvwX6hZm6qx8nKjiI+sbOHzekE+cb6WHfa33hfIzcp+yxf4ukd9NtxlkbNzadRMTtbe
         bOk2HPVu5AI1dgdXyBSy60vI0/yv8hizcftZ4Bn+OXP6Y9c1c0jOmuW7V0/6IKzSZF81
         lVMg==
X-Forwarded-Encrypted: i=1; AJvYcCXwUfJbwJVw5UF5GJJJrztVK32m69fSoBoVsunxS7UPAc2qQTudx/eYx9ympkj1NWLvhUuDWaQWW8T35RhEwEzbpCyFz+67
X-Gm-Message-State: AOJu0YwNd7O5O8wqTXLgXlSzuI1PcfqFmA4pnrkBzZ3JjigTy7lunb8r
	PlxG6vb3x1du/rYH8sIwrbfrV6sfpoLlrT4Kwruc44rDa4SlUPpD6NFNq9LaBEHSLJ+OKgCGSY0
	gMWTGSKxnZB9gEjivHddHmqLwhzGNIRyim64dw+G5btjz5bTstqkw3Hf3VX8QGM/IT/SexsM8Fx
	BSqK5vAk9JArCiSuIS3pGMV1RQE/ZN+TXlGXR8T+495A==
X-Received: by 2002:a17:90b:1b46:b0:2a4:a35f:b88e with SMTP id nv6-20020a17090b1b4600b002a4a35fb88emr10235847pjb.36.1713237904843;
        Mon, 15 Apr 2024 20:25:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4QCZ4fuG8nSE0xtm4W6KI2ygohDFJYn+01NY8mzbDnhBa55eOHwvHt+UJZhm6jmyFZ9p26njjfAfMZTIlViM=
X-Received: by 2002:a17:90b:1b46:b0:2a4:a35f:b88e with SMTP id
 nv6-20020a17090b1b4600b002a4a35fb88emr10235834pjb.36.1713237904445; Mon, 15
 Apr 2024 20:25:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com>
 <20240411025127.51945-4-xuanzhuo@linux.alibaba.com> <CACGkMEsC7AEi2SOmqNOo6KJDpx92raGWYwYzxZ_MVhmnco_LYQ@mail.gmail.com>
 <1712900153.3715405-1-xuanzhuo@linux.alibaba.com> <CACGkMEvKC6JpsznW57GgxFBMhmMSk4eCZPvESpew9j5qfp9=RA@mail.gmail.com>
 <1713146919.8867755-1-xuanzhuo@linux.alibaba.com> <CACGkMEvmaH9NE-5VDBPpZOpAAg4bX39Lf0-iGiYzxdV5JuZWww@mail.gmail.com>
 <1713170201.06163-2-xuanzhuo@linux.alibaba.com> <CACGkMEvsXN+7HpeirxzR2qek_znHp8GtjiT+8hmt3tHHM9Zbgg@mail.gmail.com>
 <1713171554.2423792-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1713171554.2423792-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Apr 2024 11:24:53 +0800
Message-ID: <CACGkMEuK0VkqtNfZ1BUw+SW=gdasEegTMfufS-47NV4bCh3Seg@mail.gmail.com>
Subject: Re: [PATCH vhost 3/6] virtio_net: replace private by pp struct inside page
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 5:04=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Mon, 15 Apr 2024 16:56:45 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Mon, Apr 15, 2024 at 4:50=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Mon, 15 Apr 2024 14:43:24 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Mon, Apr 15, 2024 at 10:35=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.=
alibaba.com> wrote:
> > > > >
> > > > > On Fri, 12 Apr 2024 13:49:12 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > On Fri, Apr 12, 2024 at 1:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@lin=
ux.alibaba.com> wrote:
> > > > > > >
> > > > > > > On Fri, 12 Apr 2024 12:47:55 +0800, Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > > > > On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhu=
o@linux.alibaba.com> wrote:
> > > > > > > > >
> > > > > > > > > Now, we chain the pages of big mode by the page's private=
 variable.
> > > > > > > > > But a subsequent patch aims to make the big mode to suppo=
rt
> > > > > > > > > premapped mode. This requires additional space to store t=
he dma addr.
> > > > > > > > >
> > > > > > > > > Within the sub-struct that contains the 'private', there =
is no suitable
> > > > > > > > > variable for storing the DMA addr.
> > > > > > > > >
> > > > > > > > >                 struct {        /* Page cache and anonymo=
us pages */
> > > > > > > > >                         /**
> > > > > > > > >                          * @lru: Pageout list, eg. active=
_list protected by
> > > > > > > > >                          * lruvec->lru_lock.  Sometimes u=
sed as a generic list
> > > > > > > > >                          * by the page owner.
> > > > > > > > >                          */
> > > > > > > > >                         union {
> > > > > > > > >                                 struct list_head lru;
> > > > > > > > >
> > > > > > > > >                                 /* Or, for the Unevictabl=
e "LRU list" slot */
> > > > > > > > >                                 struct {
> > > > > > > > >                                         /* Always even, t=
o negate PageTail */
> > > > > > > > >                                         void *__filler;
> > > > > > > > >                                         /* Count page's o=
r folio's mlocks */
> > > > > > > > >                                         unsigned int mloc=
k_count;
> > > > > > > > >                                 };
> > > > > > > > >
> > > > > > > > >                                 /* Or, free page */
> > > > > > > > >                                 struct list_head buddy_li=
st;
> > > > > > > > >                                 struct list_head pcp_list=
;
> > > > > > > > >                         };
> > > > > > > > >                         /* See page-flags.h for PAGE_MAPP=
ING_FLAGS */
> > > > > > > > >                         struct address_space *mapping;
> > > > > > > > >                         union {
> > > > > > > > >                                 pgoff_t index;          /=
* Our offset within mapping. */
> > > > > > > > >                                 unsigned long share;    /=
* share count for fsdax */
> > > > > > > > >                         };
> > > > > > > > >                         /**
> > > > > > > > >                          * @private: Mapping-private opaq=
ue data.
> > > > > > > > >                          * Usually used for buffer_heads =
if PagePrivate.
> > > > > > > > >                          * Used for swp_entry_t if PageSw=
apCache.
> > > > > > > > >                          * Indicates order in the buddy s=
ystem if PageBuddy.
> > > > > > > > >                          */
> > > > > > > > >                         unsigned long private;
> > > > > > > > >                 };
> > > > > > > > >
> > > > > > > > > But within the page pool struct, we have a variable calle=
d
> > > > > > > > > dma_addr that is appropriate for storing dma addr.
> > > > > > > > > And that struct is used by netstack. That works to our ad=
vantage.
> > > > > > > > >
> > > > > > > > >                 struct {        /* page_pool used by nets=
tack */
> > > > > > > > >                         /**
> > > > > > > > >                          * @pp_magic: magic value to avoi=
d recycling non
> > > > > > > > >                          * page_pool allocated pages.
> > > > > > > > >                          */
> > > > > > > > >                         unsigned long pp_magic;
> > > > > > > > >                         struct page_pool *pp;
> > > > > > > > >                         unsigned long _pp_mapping_pad;
> > > > > > > > >                         unsigned long dma_addr;
> > > > > > > > >                         atomic_long_t pp_ref_count;
> > > > > > > > >                 };
> > > > > > > > >
> > > > > > > > > On the other side, we should use variables from the same =
sub-struct.
> > > > > > > > > So this patch replaces the "private" with "pp".
> > > > > > > > >
> > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > > ---
> > > > > > > >
> > > > > > > > Instead of doing a customized version of page pool, can we =
simply
> > > > > > > > switch to use page pool for big mode instead? Then we don't=
 need to
> > > > > > > > bother the dma stuffs.
> > > > > > >
> > > > > > >
> > > > > > > The page pool needs to do the dma by the DMA APIs.
> > > > > > > So we can not use the page pool directly.
> > > > > >
> > > > > > I found this:
> > > > > >
> > > > > > define PP_FLAG_DMA_MAP         BIT(0) /* Should page_pool do th=
e DMA
> > > > > >                                         * map/unmap
> > > > > >
> > > > > > It seems to work here?
> > > > >
> > > > >
> > > > > I have studied the page pool mechanism and believe that we cannot=
 use it
> > > > > directly. We can make the page pool to bypass the DMA operations.
> > > > > This allows us to handle DMA within virtio-net for pages allocate=
d from the page
> > > > > pool. Furthermore, we can utilize page pool helpers to associate =
the DMA address
> > > > > to the page.
> > > > >
> > > > > However, the critical issue pertains to unmapping. Ideally, we wa=
nt to return
> > > > > the mapped pages to the page pool and reuse them. In doing so, we=
 can omit the
> > > > > unmapping and remapping steps.
> > > > >
> > > > > Currently, there's a caveat: when the page pool cache is full, it=
 disconnects
> > > > > and releases the pages. When the pool hits its capacity, pages ar=
e relinquished
> > > > > without a chance for unmapping.
> > > >
> > > > Technically, when ptr_ring is full there could be a fallback, but t=
hen
> > > > it requires expensive synchronization between producer and consumer=
.
> > > > For virtio-net, it might not be a problem because add/get has been
> > > > synchronized. (It might be relaxed in the future, actually we've
> > > > already seen a requirement in the past for virito-blk).
> > >
> > > The point is that the page will be released by page pool directly,
> > > we will have no change to unmap that, if we work with page pool.
> >
> > I mean if we have a fallback, there would be no need to release these
> > pages but put them into a link list.
>
>
> What fallback?

https://lore.kernel.org/netdev/1519607771-20613-1-git-send-email-mst@redhat=
.com/

>
> If we put the pages to the link list, why we use the page pool?

The size of the cache and ptr_ring needs to be fixed.

Again, as explained above, it needs more benchmarks and looks like a
separate topic.

>
>
> >
> > >
> > > >
> > > > > If we were to unmap pages each time before
> > > > > returning them to the pool, we would negate the benefits of bypas=
sing the
> > > > > mapping and unmapping process altogether.
> > > >
> > > > Yes, but the problem in this approach is that it creates a corner
> > > > exception where dma_addr is used outside the page pool.
> > >
> > > YES. This is a corner exception. We need to introduce this case to th=
e page
> > > pool.
> > >
> > > So for introducing the page-pool to virtio-net(not only for big mode)=
,
> > > we may need to push the page-pool to support dma by drivers.
> >
> > Adding Jesper for some comments.
> >
> > >
> > > Back to this patch set, I think we should keep the virtio-net to mana=
ge
> > > the pages.
> > >
> > > What do you think?
> >
> > I might be wrong, but I think if we need to either
> >
> > 1) seek a way to manage the pages by yourself but not touching page
> > pool metadata (or Jesper is fine with this)
>
> Do you mean working with page pool or not?
>

I meant if Jesper is fine with reusing page pool metadata like this patch.

> If we manage the pages by self(no page pool), we do not care the metadata=
 is for
> page pool or not. We just use the space of pages like the "private".

That's also fine.

>
>
> > 2) optimize the unmap for page pool
> >
> > or even
> >
> > 3) just do dma_unmap before returning the page back to the page pool,
> > we don't get all the benefits of page pool but we end up with simple
> > codes (no fallback for premapping).
>
> I am ok for this.

Right, we just need to make sure there's no performance regression,
then it would be fine.

I see for example mana did this as well.

Thanks

>
>
> Thanks.
>
> >
> > Thanks
> >
> >
> > >
> > > Thanks
> > >
> > > >
> > > > Maybe for big mode it doesn't matter too much if there's no
> > > > performance improvement.
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > Thanks.
> > > > >
> > > > >
> > > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > > Thanks.
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>


