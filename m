Return-Path: <netdev+bounces-88562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B20C38A7B3C
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 06:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E591F22A9C
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 04:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1A14176B;
	Wed, 17 Apr 2024 04:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2Ic7MTD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6341F4084D
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 04:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713326910; cv=none; b=G6gsQGs4WiKPJo0MzntWepOW/M4pzAsULCBtsuNldu8h8UsCawAdjILwuGavdDcf/Wb7TDpHBN4y442eWuE69sXpuEjpmcm+yQBJQQyeKYEkCQc7TQE7BHRE88bxT4Sk+ln9tKDkntQeAmlg1rxz30uqy1JwjKdgulqTlGt+AFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713326910; c=relaxed/simple;
	bh=OSZbP8t7JxsF7oamFZ3WoyyaLtC7M+/PhWUBy6Puft8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MF7KIh+qvvUoofMucloJHSCtbFo3PsIa+sn8ybrF4pkRZso/BgGx9L+HRJKHDsbeecoiO2k2oLGuBCdb+gz8N85lyUCPTmFn33O7M5g7fyrdJL2C17Paf+5yqqG/GOT2ELz4rsmX0JEeiBIxZU+nYOGYbQzB3Pede9xem4UEvIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c2Ic7MTD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713326906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXNt6634kJyHSD+vhWjWck2Nc0a6oil9Gaf6VpGX4EU=;
	b=c2Ic7MTDI3Jfpw9z/Uan0oN+Twqyi3+V0aWPeslqyNLNmvdHYK2HTcp/LNwxVDPqQwc5eH
	caY9gNRewxnu+mNM4rpAyXhdY34r3afY4XbJACXVMq6G8dEqwsjtM6XASaw852pR5hRhEB
	GQ6AC1SPzytC+tBhDkZLenX9nGfAqmE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468--fTMPCG8Na2fcIAoFJWusQ-1; Wed, 17 Apr 2024 00:08:23 -0400
X-MC-Unique: -fTMPCG8Na2fcIAoFJWusQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2a5457a8543so4568860a91.0
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 21:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713326902; x=1713931702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXNt6634kJyHSD+vhWjWck2Nc0a6oil9Gaf6VpGX4EU=;
        b=d/2TjJbKSVPVei6GzjI2ABcKsEGOK2jxYHxNriYHP+IOJF6X+1AoWxXt8b8sQgf8zn
         Y65yJwjtCDkAGaSS8Z19DXH1zNW94ftgJDUg43WCXFxUlGlrhVkcXjATBuywE5WWnSKZ
         I1gfXwijbAfhLGpzl1niEmDyqg7xVLu3GB7gElBGlvpcoT8LZ73nKJcLb0S8TlIZdfZT
         Mfb9lTIsrgf+6V4nxEOE3/5An5XpVN0zd1vABhuuPnGNKE+XlW0WmdfaGdFb6dBGL59g
         TBdsaxvtHDOY43BOfAvGEd74QufSguCFwFoYau73dR/VeL255HgTG50tLYlUELmy0alR
         WXUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGm1QGVROITkSIMfgvMktluL5XGurHQcIbA/IZMbmQp6RdZg2MuL2Iqm3aawECdaf1J9UfexqPhoPTZeKdtkATWlgPGlWg
X-Gm-Message-State: AOJu0YyLnBQOOpahCLLSQMGwPNDyZu9baPAkjG1lVgWY3X5cQZYAMWzM
	WC8zTUyBv1af0KSoe9MohCcHhB75N4T8AAYSCHvdnv7b2rVuN9q7DB2rhDXr6Nzcd4yfCrfIQwU
	Q8a8siC4CfpMsXymOYfhYQTIaiLUcI2nEh0/zOdW+OgIFsYf5kvBQrBOltzkRPiOR6o2fruGKwH
	/aTYxB9irAJ8iYFvBC87kEVVriJcFf
X-Received: by 2002:a17:90a:db8e:b0:2a2:9001:94bf with SMTP id h14-20020a17090adb8e00b002a2900194bfmr13479930pjv.14.1713326902595;
        Tue, 16 Apr 2024 21:08:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwPKMIZIy9WwCaF1wkpJmVpuo2h7nJ8pymU2pNWcdX4Etic1jPvfODSztEHGtZgARLji8HC1O5m5LRfQ9KKVc=
X-Received: by 2002:a17:90a:db8e:b0:2a2:9001:94bf with SMTP id
 h14-20020a17090adb8e00b002a2900194bfmr13479915pjv.14.1713326902181; Tue, 16
 Apr 2024 21:08:22 -0700 (PDT)
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
 <1713171554.2423792-1-xuanzhuo@linux.alibaba.com> <CACGkMEuK0VkqtNfZ1BUw+SW=gdasEegTMfufS-47NV4bCh3Seg@mail.gmail.com>
 <1713317444.7698638-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1713317444.7698638-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 Apr 2024 12:08:10 +0800
Message-ID: <CACGkMEvjwXpF_mLR3H8ZW9PUE+3spcxKMQV1VvUARb0-Lt7NKQ@mail.gmail.com>
Subject: Re: [PATCH vhost 3/6] virtio_net: replace private by pp struct inside page
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 9:38=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Tue, 16 Apr 2024 11:24:53 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Mon, Apr 15, 2024 at 5:04=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Mon, 15 Apr 2024 16:56:45 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Mon, Apr 15, 2024 at 4:50=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > On Mon, 15 Apr 2024 14:43:24 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > On Mon, Apr 15, 2024 at 10:35=E2=80=AFAM Xuan Zhuo <xuanzhuo@li=
nux.alibaba.com> wrote:
> > > > > > >
> > > > > > > On Fri, 12 Apr 2024 13:49:12 +0800, Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > > > > On Fri, Apr 12, 2024 at 1:39=E2=80=AFPM Xuan Zhuo <xuanzhuo=
@linux.alibaba.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, 12 Apr 2024 12:47:55 +0800, Jason Wang <jasowang@=
redhat.com> wrote:
> > > > > > > > > > On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xua=
nzhuo@linux.alibaba.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Now, we chain the pages of big mode by the page's pri=
vate variable.
> > > > > > > > > > > But a subsequent patch aims to make the big mode to s=
upport
> > > > > > > > > > > premapped mode. This requires additional space to sto=
re the dma addr.
> > > > > > > > > > >
> > > > > > > > > > > Within the sub-struct that contains the 'private', th=
ere is no suitable
> > > > > > > > > > > variable for storing the DMA addr.
> > > > > > > > > > >
> > > > > > > > > > >                 struct {        /* Page cache and ano=
nymous pages */
> > > > > > > > > > >                         /**
> > > > > > > > > > >                          * @lru: Pageout list, eg. ac=
tive_list protected by
> > > > > > > > > > >                          * lruvec->lru_lock.  Sometim=
es used as a generic list
> > > > > > > > > > >                          * by the page owner.
> > > > > > > > > > >                          */
> > > > > > > > > > >                         union {
> > > > > > > > > > >                                 struct list_head lru;
> > > > > > > > > > >
> > > > > > > > > > >                                 /* Or, for the Unevic=
table "LRU list" slot */
> > > > > > > > > > >                                 struct {
> > > > > > > > > > >                                         /* Always eve=
n, to negate PageTail */
> > > > > > > > > > >                                         void *__fille=
r;
> > > > > > > > > > >                                         /* Count page=
's or folio's mlocks */
> > > > > > > > > > >                                         unsigned int =
mlock_count;
> > > > > > > > > > >                                 };
> > > > > > > > > > >
> > > > > > > > > > >                                 /* Or, free page */
> > > > > > > > > > >                                 struct list_head budd=
y_list;
> > > > > > > > > > >                                 struct list_head pcp_=
list;
> > > > > > > > > > >                         };
> > > > > > > > > > >                         /* See page-flags.h for PAGE_=
MAPPING_FLAGS */
> > > > > > > > > > >                         struct address_space *mapping=
;
> > > > > > > > > > >                         union {
> > > > > > > > > > >                                 pgoff_t index;       =
   /* Our offset within mapping. */
> > > > > > > > > > >                                 unsigned long share; =
   /* share count for fsdax */
> > > > > > > > > > >                         };
> > > > > > > > > > >                         /**
> > > > > > > > > > >                          * @private: Mapping-private =
opaque data.
> > > > > > > > > > >                          * Usually used for buffer_he=
ads if PagePrivate.
> > > > > > > > > > >                          * Used for swp_entry_t if Pa=
geSwapCache.
> > > > > > > > > > >                          * Indicates order in the bud=
dy system if PageBuddy.
> > > > > > > > > > >                          */
> > > > > > > > > > >                         unsigned long private;
> > > > > > > > > > >                 };
> > > > > > > > > > >
> > > > > > > > > > > But within the page pool struct, we have a variable c=
alled
> > > > > > > > > > > dma_addr that is appropriate for storing dma addr.
> > > > > > > > > > > And that struct is used by netstack. That works to ou=
r advantage.
> > > > > > > > > > >
> > > > > > > > > > >                 struct {        /* page_pool used by =
netstack */
> > > > > > > > > > >                         /**
> > > > > > > > > > >                          * @pp_magic: magic value to =
avoid recycling non
> > > > > > > > > > >                          * page_pool allocated pages.
> > > > > > > > > > >                          */
> > > > > > > > > > >                         unsigned long pp_magic;
> > > > > > > > > > >                         struct page_pool *pp;
> > > > > > > > > > >                         unsigned long _pp_mapping_pad=
;
> > > > > > > > > > >                         unsigned long dma_addr;
> > > > > > > > > > >                         atomic_long_t pp_ref_count;
> > > > > > > > > > >                 };
> > > > > > > > > > >
> > > > > > > > > > > On the other side, we should use variables from the s=
ame sub-struct.
> > > > > > > > > > > So this patch replaces the "private" with "pp".
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > > > > ---
> > > > > > > > > >
> > > > > > > > > > Instead of doing a customized version of page pool, can=
 we simply
> > > > > > > > > > switch to use page pool for big mode instead? Then we d=
on't need to
> > > > > > > > > > bother the dma stuffs.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > The page pool needs to do the dma by the DMA APIs.
> > > > > > > > > So we can not use the page pool directly.
> > > > > > > >
> > > > > > > > I found this:
> > > > > > > >
> > > > > > > > define PP_FLAG_DMA_MAP         BIT(0) /* Should page_pool d=
o the DMA
> > > > > > > >                                         * map/unmap
> > > > > > > >
> > > > > > > > It seems to work here?
> > > > > > >
> > > > > > >
> > > > > > > I have studied the page pool mechanism and believe that we ca=
nnot use it
> > > > > > > directly. We can make the page pool to bypass the DMA operati=
ons.
> > > > > > > This allows us to handle DMA within virtio-net for pages allo=
cated from the page
> > > > > > > pool. Furthermore, we can utilize page pool helpers to associ=
ate the DMA address
> > > > > > > to the page.
> > > > > > >
> > > > > > > However, the critical issue pertains to unmapping. Ideally, w=
e want to return
> > > > > > > the mapped pages to the page pool and reuse them. In doing so=
, we can omit the
> > > > > > > unmapping and remapping steps.
> > > > > > >
> > > > > > > Currently, there's a caveat: when the page pool cache is full=
, it disconnects
> > > > > > > and releases the pages. When the pool hits its capacity, page=
s are relinquished
> > > > > > > without a chance for unmapping.
> > > > > >
> > > > > > Technically, when ptr_ring is full there could be a fallback, b=
ut then
> > > > > > it requires expensive synchronization between producer and cons=
umer.
> > > > > > For virtio-net, it might not be a problem because add/get has b=
een
> > > > > > synchronized. (It might be relaxed in the future, actually we'v=
e
> > > > > > already seen a requirement in the past for virito-blk).
> > > > >
> > > > > The point is that the page will be released by page pool directly=
,
> > > > > we will have no change to unmap that, if we work with page pool.
> > > >
> > > > I mean if we have a fallback, there would be no need to release the=
se
> > > > pages but put them into a link list.
> > >
> > >
> > > What fallback?
> >
> > https://lore.kernel.org/netdev/1519607771-20613-1-git-send-email-mst@re=
dhat.com/
> >
> > >
> > > If we put the pages to the link list, why we use the page pool?
> >
> > The size of the cache and ptr_ring needs to be fixed.
> >
> > Again, as explained above, it needs more benchmarks and looks like a
> > separate topic.
> >
> > >
> > >
> > > >
> > > > >
> > > > > >
> > > > > > > If we were to unmap pages each time before
> > > > > > > returning them to the pool, we would negate the benefits of b=
ypassing the
> > > > > > > mapping and unmapping process altogether.
> > > > > >
> > > > > > Yes, but the problem in this approach is that it creates a corn=
er
> > > > > > exception where dma_addr is used outside the page pool.
> > > > >
> > > > > YES. This is a corner exception. We need to introduce this case t=
o the page
> > > > > pool.
> > > > >
> > > > > So for introducing the page-pool to virtio-net(not only for big m=
ode),
> > > > > we may need to push the page-pool to support dma by drivers.
> > > >
> > > > Adding Jesper for some comments.
> > > >
> > > > >
> > > > > Back to this patch set, I think we should keep the virtio-net to =
manage
> > > > > the pages.
> > > > >
> > > > > What do you think?
> > > >
> > > > I might be wrong, but I think if we need to either
> > > >
> > > > 1) seek a way to manage the pages by yourself but not touching page
> > > > pool metadata (or Jesper is fine with this)
> > >
> > > Do you mean working with page pool or not?
> > >
> >
> > I meant if Jesper is fine with reusing page pool metadata like this pat=
ch.
> >
> > > If we manage the pages by self(no page pool), we do not care the meta=
data is for
> > > page pool or not. We just use the space of pages like the "private".
> >
> > That's also fine.
> >
> > >
> > >
> > > > 2) optimize the unmap for page pool
> > > >
> > > > or even
> > > >
> > > > 3) just do dma_unmap before returning the page back to the page poo=
l,
> > > > we don't get all the benefits of page pool but we end up with simpl=
e
> > > > codes (no fallback for premapping).
> > >
> > > I am ok for this.
> >
> > Right, we just need to make sure there's no performance regression,
> > then it would be fine.
> >
> > I see for example mana did this as well.
>
> I think we should not use page pool directly now,
> because the mana does not need a space to store the dma address.
> We need to store the dma address for unmapping.
>
> If we use page pool without PP_FLAG_DMA_MAP, then store the dma address b=
y
> page.dma_addr, I think that is not safe.

Jesper, could you comment on this?

>
> I think the way of this patch set is fine.

So it reuses page pool structure in the page structure for another use case=
.

> We just use the
> space of the page whatever it is page pool or not to store
> the link and dma address.

Probably because we've already "abused" page->private. I would leave
it for other maintainers to decide.

Thanks

>
> Thanks.
>
> >
> > Thanks
> >
> > >
> > >
> > > Thanks.
> > >
> > > >
> > > > Thanks
> > > >
> > > >
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > > Maybe for big mode it doesn't matter too much if there's no
> > > > > > performance improvement.
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > > Thanks.
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Thanks.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Thanks
> > > > > > > > > >
> > > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
> >
>


