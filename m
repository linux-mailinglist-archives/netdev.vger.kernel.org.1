Return-Path: <netdev+bounces-88969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B24D08A91EB
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 06:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5DBC1C2089B
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 04:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDF6548E9;
	Thu, 18 Apr 2024 04:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBou+Qi+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88A52E62C
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 04:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713413783; cv=none; b=l4Em25uXa0XR64BilJh4CIUs5tKz97hZhUUSZ94Ckot90EaqvvdoSKaWX1bvnpsdo9FgpSSpS0NDxf4yE4txEeqiD33ect5xXec1IZhUkp+fSv29GxtUq9pDJfyzilsYcKZCAg4l7Oos8bRSuyJisCZ3jrJIqhV8mkc6qZ7u5F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713413783; c=relaxed/simple;
	bh=2YhwdNRNZNs9XyUDqnrrh6zZCwJE+H3ldMUnkyS9NTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRVW8Tpw1OrUiC7XEZFzn1L+m7cntAjCgUorkse7JhgyZn8ftX2+iJVLIKknL4MYt/V26dfFL5Z/kzpee+rQANIDvjRrw5pS58m1Y0SdYVNrLoNYawBugwBPqlnwwFlxZnSErSdTnnY9S5+fO3ChpANs+d3XGpcu3bmvWrbfNL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eBou+Qi+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713413780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6lEffdrRV6/tLup7x3UX64J02/Q7ZdCB9CaclhiztUk=;
	b=eBou+Qi+AXkEO7EkVlxTGrYmJ0GxeKoevjLGmyr7ZGwddHW6o+QxKI+kEvzO+Dkp3W5T3y
	+LamdcHCjX+rWF+QMsCAk9uwv+r8INf4ksMcEg+RAsOARDtAMR9wYVC5YvdY4s9TJkLPFv
	1/oNZ+IBgH/XU7G9d/t0wu661xPd/rs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-boL3hwV0N7GCEnOgWbxFig-1; Thu, 18 Apr 2024 00:16:18 -0400
X-MC-Unique: boL3hwV0N7GCEnOgWbxFig-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a537ab9d7eso624221a91.1
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 21:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713413777; x=1714018577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lEffdrRV6/tLup7x3UX64J02/Q7ZdCB9CaclhiztUk=;
        b=j01p3nK6QHi8d/H82VxV0W/6/p32rhcaCpR8rFJ6pyNviEILNNIPooT07qdqR0LuUI
         FRJbUnwmsgnD9fzmbEOfqISzl+rmsjcgbWR3hyjHC4nSwSbP/xbv+6uRr16Y8Yta4pwt
         fSRJS1D48VjyYC2K+VtOUkRDoMvjus2gC05DPvrdTTCmlR2vJhjEGg5WL1YkGMHwvv0B
         Qdu90pbR9YZDExgrR9SZeIAxkGy0CPFwccMXz+VJI3yAwfB2/gkhqZaVHImIspObLsGm
         pnxX/IulGvZo2UTPS9tliqraLs1i44H0NWVMNRw5btEtEHvouKnPWtTZ7YDOC9XOMPMl
         ishA==
X-Forwarded-Encrypted: i=1; AJvYcCVa1n+K0VK0vmdo0A4wLgso/ltN/iXIG82B1GKiPpg2sXGe8CQG79uay6fhSWCNiSD0u5AiCIQE9a3PyeFiucUyUOeBg/mU
X-Gm-Message-State: AOJu0YxgYlc+HkECIEEzMK9iJwnw7Irjg/oV5TDbJEJAf6c9b7+4JPXh
	hh6y7kfJQfl2bA8YyApQYbDXFWwRjZLedwUnIV91mGXTGRXw5+BdUyGNi9QEuLAZEvoufESLtMi
	4tAM9YNuR+5CT4npJxcMSanUrJwoTnsm2kt7yaF7Gy3tcpxqr7rHYjdnuk7JcGOcZGxymFNhaG6
	Y5DhYoourqkq6iyd9kVOfqIEhA4g8u
X-Received: by 2002:a17:90a:88d:b0:2aa:c2ba:3758 with SMTP id v13-20020a17090a088d00b002aac2ba3758mr1373110pjc.42.1713413777460;
        Wed, 17 Apr 2024 21:16:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELyX/NaQKUr3Fu2kI9FNuUMRaZMwfode+lj76UabCr2UNAfyZg/xQ0SMj1pnz114phl9nYID/2lHE/d9jAvTY=
X-Received: by 2002:a17:90a:88d:b0:2aa:c2ba:3758 with SMTP id
 v13-20020a17090a088d00b002aac2ba3758mr1373094pjc.42.1713413777098; Wed, 17
 Apr 2024 21:16:17 -0700 (PDT)
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
 <1713317444.7698638-1-xuanzhuo@linux.alibaba.com> <CACGkMEvjwXpF_mLR3H8ZW9PUE+3spcxKMQV1VvUARb0-Lt7NKQ@mail.gmail.com>
 <1713342055.436048-1-xuanzhuo@linux.alibaba.com> <CACGkMEubSGs7WNwXBM49uDQTjPNeeFnoFHxidkAv8ixi1MPjww@mail.gmail.com>
In-Reply-To: <CACGkMEubSGs7WNwXBM49uDQTjPNeeFnoFHxidkAv8ixi1MPjww@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Apr 2024 12:16:06 +0800
Message-ID: <CACGkMEu=Aok9z2imB_c5qVuujSh=vjj1kx12fy9N7hqyi+M5Ow@mail.gmail.com>
Subject: Re: [PATCH vhost 3/6] virtio_net: replace private by pp struct inside page
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 12:15=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Wed, Apr 17, 2024 at 4:45=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Wed, 17 Apr 2024 12:08:10 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Wed, Apr 17, 2024 at 9:38=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > On Tue, 16 Apr 2024 11:24:53 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Mon, Apr 15, 2024 at 5:04=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux=
.alibaba.com> wrote:
> > > > > >
> > > > > > On Mon, 15 Apr 2024 16:56:45 +0800, Jason Wang <jasowang@redhat=
.com> wrote:
> > > > > > > On Mon, Apr 15, 2024 at 4:50=E2=80=AFPM Xuan Zhuo <xuanzhuo@l=
inux.alibaba.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, 15 Apr 2024 14:43:24 +0800, Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > > > > On Mon, Apr 15, 2024 at 10:35=E2=80=AFAM Xuan Zhuo <xuanz=
huo@linux.alibaba.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, 12 Apr 2024 13:49:12 +0800, Jason Wang <jasowan=
g@redhat.com> wrote:
> > > > > > > > > > > On Fri, Apr 12, 2024 at 1:39=E2=80=AFPM Xuan Zhuo <xu=
anzhuo@linux.alibaba.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Fri, 12 Apr 2024 12:47:55 +0800, Jason Wang <jas=
owang@redhat.com> wrote:
> > > > > > > > > > > > > On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhu=
o <xuanzhuo@linux.alibaba.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Now, we chain the pages of big mode by the page=
's private variable.
> > > > > > > > > > > > > > But a subsequent patch aims to make the big mod=
e to support
> > > > > > > > > > > > > > premapped mode. This requires additional space =
to store the dma addr.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Within the sub-struct that contains the 'privat=
e', there is no suitable
> > > > > > > > > > > > > > variable for storing the DMA addr.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >                 struct {        /* Page cache a=
nd anonymous pages */
> > > > > > > > > > > > > >                         /**
> > > > > > > > > > > > > >                          * @lru: Pageout list, =
eg. active_list protected by
> > > > > > > > > > > > > >                          * lruvec->lru_lock.  S=
ometimes used as a generic list
> > > > > > > > > > > > > >                          * by the page owner.
> > > > > > > > > > > > > >                          */
> > > > > > > > > > > > > >                         union {
> > > > > > > > > > > > > >                                 struct list_hea=
d lru;
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >                                 /* Or, for the =
Unevictable "LRU list" slot */
> > > > > > > > > > > > > >                                 struct {
> > > > > > > > > > > > > >                                         /* Alwa=
ys even, to negate PageTail */
> > > > > > > > > > > > > >                                         void *_=
_filler;
> > > > > > > > > > > > > >                                         /* Coun=
t page's or folio's mlocks */
> > > > > > > > > > > > > >                                         unsigne=
d int mlock_count;
> > > > > > > > > > > > > >                                 };
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >                                 /* Or, free pag=
e */
> > > > > > > > > > > > > >                                 struct list_hea=
d buddy_list;
> > > > > > > > > > > > > >                                 struct list_hea=
d pcp_list;
> > > > > > > > > > > > > >                         };
> > > > > > > > > > > > > >                         /* See page-flags.h for=
 PAGE_MAPPING_FLAGS */
> > > > > > > > > > > > > >                         struct address_space *m=
apping;
> > > > > > > > > > > > > >                         union {
> > > > > > > > > > > > > >                                 pgoff_t index; =
         /* Our offset within mapping. */
> > > > > > > > > > > > > >                                 unsigned long s=
hare;    /* share count for fsdax */
> > > > > > > > > > > > > >                         };
> > > > > > > > > > > > > >                         /**
> > > > > > > > > > > > > >                          * @private: Mapping-pr=
ivate opaque data.
> > > > > > > > > > > > > >                          * Usually used for buf=
fer_heads if PagePrivate.
> > > > > > > > > > > > > >                          * Used for swp_entry_t=
 if PageSwapCache.
> > > > > > > > > > > > > >                          * Indicates order in t=
he buddy system if PageBuddy.
> > > > > > > > > > > > > >                          */
> > > > > > > > > > > > > >                         unsigned long private;
> > > > > > > > > > > > > >                 };
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > But within the page pool struct, we have a vari=
able called
> > > > > > > > > > > > > > dma_addr that is appropriate for storing dma ad=
dr.
> > > > > > > > > > > > > > And that struct is used by netstack. That works=
 to our advantage.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >                 struct {        /* page_pool us=
ed by netstack */
> > > > > > > > > > > > > >                         /**
> > > > > > > > > > > > > >                          * @pp_magic: magic val=
ue to avoid recycling non
> > > > > > > > > > > > > >                          * page_pool allocated =
pages.
> > > > > > > > > > > > > >                          */
> > > > > > > > > > > > > >                         unsigned long pp_magic;
> > > > > > > > > > > > > >                         struct page_pool *pp;
> > > > > > > > > > > > > >                         unsigned long _pp_mappi=
ng_pad;
> > > > > > > > > > > > > >                         unsigned long dma_addr;
> > > > > > > > > > > > > >                         atomic_long_t pp_ref_co=
unt;
> > > > > > > > > > > > > >                 };
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On the other side, we should use variables from=
 the same sub-struct.
> > > > > > > > > > > > > > So this patch replaces the "private" with "pp".
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibab=
a.com>
> > > > > > > > > > > > > > ---
> > > > > > > > > > > > >
> > > > > > > > > > > > > Instead of doing a customized version of page poo=
l, can we simply
> > > > > > > > > > > > > switch to use page pool for big mode instead? The=
n we don't need to
> > > > > > > > > > > > > bother the dma stuffs.
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > The page pool needs to do the dma by the DMA APIs.
> > > > > > > > > > > > So we can not use the page pool directly.
> > > > > > > > > > >
> > > > > > > > > > > I found this:
> > > > > > > > > > >
> > > > > > > > > > > define PP_FLAG_DMA_MAP         BIT(0) /* Should page_=
pool do the DMA
> > > > > > > > > > >                                         * map/unmap
> > > > > > > > > > >
> > > > > > > > > > > It seems to work here?
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > I have studied the page pool mechanism and believe that=
 we cannot use it
> > > > > > > > > > directly. We can make the page pool to bypass the DMA o=
perations.
> > > > > > > > > > This allows us to handle DMA within virtio-net for page=
s allocated from the page
> > > > > > > > > > pool. Furthermore, we can utilize page pool helpers to =
associate the DMA address
> > > > > > > > > > to the page.
> > > > > > > > > >
> > > > > > > > > > However, the critical issue pertains to unmapping. Idea=
lly, we want to return
> > > > > > > > > > the mapped pages to the page pool and reuse them. In do=
ing so, we can omit the
> > > > > > > > > > unmapping and remapping steps.
> > > > > > > > > >
> > > > > > > > > > Currently, there's a caveat: when the page pool cache i=
s full, it disconnects
> > > > > > > > > > and releases the pages. When the pool hits its capacity=
, pages are relinquished
> > > > > > > > > > without a chance for unmapping.
> > > > > > > > >
> > > > > > > > > Technically, when ptr_ring is full there could be a fallb=
ack, but then
> > > > > > > > > it requires expensive synchronization between producer an=
d consumer.
> > > > > > > > > For virtio-net, it might not be a problem because add/get=
 has been
> > > > > > > > > synchronized. (It might be relaxed in the future, actuall=
y we've
> > > > > > > > > already seen a requirement in the past for virito-blk).
> > > > > > > >
> > > > > > > > The point is that the page will be released by page pool di=
rectly,
> > > > > > > > we will have no change to unmap that, if we work with page =
pool.
> > > > > > >
> > > > > > > I mean if we have a fallback, there would be no need to relea=
se these
> > > > > > > pages but put them into a link list.
> > > > > >
> > > > > >
> > > > > > What fallback?
> > > > >
> > > > > https://lore.kernel.org/netdev/1519607771-20613-1-git-send-email-=
mst@redhat.com/
> > > > >
> > > > > >
> > > > > > If we put the pages to the link list, why we use the page pool?
> > > > >
> > > > > The size of the cache and ptr_ring needs to be fixed.
> > > > >
> > > > > Again, as explained above, it needs more benchmarks and looks lik=
e a
> > > > > separate topic.
> > > > >
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > If we were to unmap pages each time before
> > > > > > > > > > returning them to the pool, we would negate the benefit=
s of bypassing the
> > > > > > > > > > mapping and unmapping process altogether.
> > > > > > > > >
> > > > > > > > > Yes, but the problem in this approach is that it creates =
a corner
> > > > > > > > > exception where dma_addr is used outside the page pool.
> > > > > > > >
> > > > > > > > YES. This is a corner exception. We need to introduce this =
case to the page
> > > > > > > > pool.
> > > > > > > >
> > > > > > > > So for introducing the page-pool to virtio-net(not only for=
 big mode),
> > > > > > > > we may need to push the page-pool to support dma by drivers=
.
> > > > > > >
> > > > > > > Adding Jesper for some comments.
> > > > > > >
> > > > > > > >
> > > > > > > > Back to this patch set, I think we should keep the virtio-n=
et to manage
> > > > > > > > the pages.
> > > > > > > >
> > > > > > > > What do you think?
> > > > > > >
> > > > > > > I might be wrong, but I think if we need to either
> > > > > > >
> > > > > > > 1) seek a way to manage the pages by yourself but not touchin=
g page
> > > > > > > pool metadata (or Jesper is fine with this)
> > > > > >
> > > > > > Do you mean working with page pool or not?
> > > > > >
> > > > >
> > > > > I meant if Jesper is fine with reusing page pool metadata like th=
is patch.
> > > > >
> > > > > > If we manage the pages by self(no page pool), we do not care th=
e metadata is for
> > > > > > page pool or not. We just use the space of pages like the "priv=
ate".
> > > > >
> > > > > That's also fine.
> > > > >
> > > > > >
> > > > > >
> > > > > > > 2) optimize the unmap for page pool
> > > > > > >
> > > > > > > or even
> > > > > > >
> > > > > > > 3) just do dma_unmap before returning the page back to the pa=
ge pool,
> > > > > > > we don't get all the benefits of page pool but we end up with=
 simple
> > > > > > > codes (no fallback for premapping).
> > > > > >
> > > > > > I am ok for this.
> > > > >
> > > > > Right, we just need to make sure there's no performance regressio=
n,
> > > > > then it would be fine.
> > > > >
> > > > > I see for example mana did this as well.
> > > >
> > > > I think we should not use page pool directly now,
> > > > because the mana does not need a space to store the dma address.
> > > > We need to store the dma address for unmapping.
> > > >
> > > > If we use page pool without PP_FLAG_DMA_MAP, then store the dma add=
ress by
> > > > page.dma_addr, I think that is not safe.
> > >
> > > Jesper, could you comment on this?
> > >
> > > >
> > > > I think the way of this patch set is fine.
> > >
> > > So it reuses page pool structure in the page structure for another us=
e case.
> > >
> > > > We just use the
> > > > space of the page whatever it is page pool or not to store
> > > > the link and dma address.
> > >
> > > Probably because we've already "abused" page->private. I would leave
> > > it for other maintainers to decide.
> >
> > If we do not want to use the elements of the page directly,
> > the page pool is a good way.
> >
>
> Rethink this, I think that the approach of this series should be fine.
> It should be sufficient for virtio-net to guarantee that those pages
> are not used by the page pool.
>
> I will continue the review.

Btw, it would be better to describe those design considerations in the
changelog (e.g why we don't use page pool etc).

Thanks

>
> Thanks


