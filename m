Return-Path: <netdev+bounces-88967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E969D8A91E0
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 06:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10B6282AFB
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 04:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867F7548E9;
	Thu, 18 Apr 2024 04:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHxeTTxC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5080854773
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 04:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713413727; cv=none; b=kgNhBgppystTU/XESGYyIgVcINQeHsKpzd7zXDg7gT9BdbCyb6L6ZNq0nfN41R8a0lnaSsLBxMWQ4xtzltRNXaAdVmvm1iNYgAVikEBPnptCrTtEH0XQ2cWHDIOsvii58oTjVfN3D83121uvSsm9yNgj+yqRVuyVxnPh4PKqcjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713413727; c=relaxed/simple;
	bh=BzJPOZ8Gc24VB44AxytHG8AqxpAOpHyv6kYI7e0toq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k377ERcQVZn4K9Iwj527llADo3eg3sP6Yz7RPCCI5vF9/Jss/XGnYN4CunnDRYhKpXraK/Q4ITEw742or+RruRKPaC02PThyU7oyscdzH8QRBWxM/m2EeqQUzu8LNI3ihJde+Zzrrl7olrc4mV40M4e3QRlqOhodw83JMAxovjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IHxeTTxC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713413724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7d6QfYuYCTBh4c1O8qPFg919EK1uJUbhVxqwoPYbcmA=;
	b=IHxeTTxCSUpzRkIhR9IFoBkzBdcLkcOu9rGbSewc6jURYeAw5VEFu8cOLA49gDZqUK2VXz
	0vy+vfkzIS0H91sSineVBe86cP/Ij23eaxIPw12kJJjgGPbpV/oRrWL2hDOrUEh+o5utMP
	2bxsbh1IwcadOjT/Vr9BSfsDWiJGR3c=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-QdI0sNdvNSO9kfPLWISvMQ-1; Thu, 18 Apr 2024 00:15:22 -0400
X-MC-Unique: QdI0sNdvNSO9kfPLWISvMQ-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6ed0e1f8faeso1473108b3a.1
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 21:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713413721; x=1714018521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7d6QfYuYCTBh4c1O8qPFg919EK1uJUbhVxqwoPYbcmA=;
        b=JzsnFotzij1XphogePZGzVvWL2OS4sOVCexdmdHHxxWbFCqNrmTKV6zyFusa7dhXJz
         rgquXJ3HIThPB1SeyppJ4U3dY4+FYNY0WhuL8eJmkN9nUVa+LysXr/Irkwg+EhufqcmY
         ZbATtgSeTfrIVlG5SuVcXSH/yca42gABKJLMcndmeb+aq4ojwYsAWB1QJFKP2lmoBbpL
         ewvTj/vzJ8+5Wi28w0NLwZyZC6RGMVTdkvqQK61fZOBL7Sgfe/LPmqoBrNTPs1MgbMEF
         LWl4La9LshrupcAXOsMFIzbAyoG9auAbDiYheGYHB3G1KrEC9KZROhIPVBVYGw8jsW6b
         niCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEWd2fMWlDunMUBJv7Fml58gjmjhWOl+6nZmPq7gZxzi6YZKe1mDE3jWQMD9qZlY/iwunXgYm+lptaxxnCcvck+bVrFw0b
X-Gm-Message-State: AOJu0YyAvhU6i2jSg9ELHmd7KG0Twukt6/WasiGRWb9RtAnmB+ichOTk
	M+zpjRTVaHijSbcUoAgc7ZVbrzWaDBbqCQV/dSEawTquUpMlpwnAzLscLVF1lGrem0pGWqVPcxf
	2qyH5FRbXrQd3PHHh29R3ZzmQzW6K4Qe90PB4IyAZ1n/xut6cy/sZcc56DywjhrBewYt4JvZTrd
	f+R0xmqm3XEFEeVzQk8JFZuerOQfMC
X-Received: by 2002:a05:6a00:190a:b0:6ea:f3fb:26fe with SMTP id y10-20020a056a00190a00b006eaf3fb26femr1789780pfi.12.1713413720955;
        Wed, 17 Apr 2024 21:15:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyKmiSwK78X1PVfbpvE1isGpq4UHhjuvEyZwB650DXkgos4UIR6LmEsGJ2VtZPGepAvwaTO90KhOyJ9hTS/jo=
X-Received: by 2002:a05:6a00:190a:b0:6ea:f3fb:26fe with SMTP id
 y10-20020a056a00190a00b006eaf3fb26femr1789748pfi.12.1713413720490; Wed, 17
 Apr 2024 21:15:20 -0700 (PDT)
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
 <1713342055.436048-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1713342055.436048-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Apr 2024 12:15:09 +0800
Message-ID: <CACGkMEubSGs7WNwXBM49uDQTjPNeeFnoFHxidkAv8ixi1MPjww@mail.gmail.com>
Subject: Re: [PATCH vhost 3/6] virtio_net: replace private by pp struct inside page
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 4:45=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 17 Apr 2024 12:08:10 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Wed, Apr 17, 2024 at 9:38=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Tue, 16 Apr 2024 11:24:53 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Mon, Apr 15, 2024 at 5:04=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > On Mon, 15 Apr 2024 16:56:45 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > On Mon, Apr 15, 2024 at 4:50=E2=80=AFPM Xuan Zhuo <xuanzhuo@lin=
ux.alibaba.com> wrote:
> > > > > > >
> > > > > > > On Mon, 15 Apr 2024 14:43:24 +0800, Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > > > > On Mon, Apr 15, 2024 at 10:35=E2=80=AFAM Xuan Zhuo <xuanzhu=
o@linux.alibaba.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, 12 Apr 2024 13:49:12 +0800, Jason Wang <jasowang@=
redhat.com> wrote:
> > > > > > > > > > On Fri, Apr 12, 2024 at 1:39=E2=80=AFPM Xuan Zhuo <xuan=
zhuo@linux.alibaba.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Fri, 12 Apr 2024 12:47:55 +0800, Jason Wang <jasow=
ang@redhat.com> wrote:
> > > > > > > > > > > > On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo =
<xuanzhuo@linux.alibaba.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > Now, we chain the pages of big mode by the page's=
 private variable.
> > > > > > > > > > > > > But a subsequent patch aims to make the big mode =
to support
> > > > > > > > > > > > > premapped mode. This requires additional space to=
 store the dma addr.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Within the sub-struct that contains the 'private'=
, there is no suitable
> > > > > > > > > > > > > variable for storing the DMA addr.
> > > > > > > > > > > > >
> > > > > > > > > > > > >                 struct {        /* Page cache and=
 anonymous pages */
> > > > > > > > > > > > >                         /**
> > > > > > > > > > > > >                          * @lru: Pageout list, eg=
. active_list protected by
> > > > > > > > > > > > >                          * lruvec->lru_lock.  Som=
etimes used as a generic list
> > > > > > > > > > > > >                          * by the page owner.
> > > > > > > > > > > > >                          */
> > > > > > > > > > > > >                         union {
> > > > > > > > > > > > >                                 struct list_head =
lru;
> > > > > > > > > > > > >
> > > > > > > > > > > > >                                 /* Or, for the Un=
evictable "LRU list" slot */
> > > > > > > > > > > > >                                 struct {
> > > > > > > > > > > > >                                         /* Always=
 even, to negate PageTail */
> > > > > > > > > > > > >                                         void *__f=
iller;
> > > > > > > > > > > > >                                         /* Count =
page's or folio's mlocks */
> > > > > > > > > > > > >                                         unsigned =
int mlock_count;
> > > > > > > > > > > > >                                 };
> > > > > > > > > > > > >
> > > > > > > > > > > > >                                 /* Or, free page =
*/
> > > > > > > > > > > > >                                 struct list_head =
buddy_list;
> > > > > > > > > > > > >                                 struct list_head =
pcp_list;
> > > > > > > > > > > > >                         };
> > > > > > > > > > > > >                         /* See page-flags.h for P=
AGE_MAPPING_FLAGS */
> > > > > > > > > > > > >                         struct address_space *map=
ping;
> > > > > > > > > > > > >                         union {
> > > > > > > > > > > > >                                 pgoff_t index;   =
       /* Our offset within mapping. */
> > > > > > > > > > > > >                                 unsigned long sha=
re;    /* share count for fsdax */
> > > > > > > > > > > > >                         };
> > > > > > > > > > > > >                         /**
> > > > > > > > > > > > >                          * @private: Mapping-priv=
ate opaque data.
> > > > > > > > > > > > >                          * Usually used for buffe=
r_heads if PagePrivate.
> > > > > > > > > > > > >                          * Used for swp_entry_t i=
f PageSwapCache.
> > > > > > > > > > > > >                          * Indicates order in the=
 buddy system if PageBuddy.
> > > > > > > > > > > > >                          */
> > > > > > > > > > > > >                         unsigned long private;
> > > > > > > > > > > > >                 };
> > > > > > > > > > > > >
> > > > > > > > > > > > > But within the page pool struct, we have a variab=
le called
> > > > > > > > > > > > > dma_addr that is appropriate for storing dma addr=
.
> > > > > > > > > > > > > And that struct is used by netstack. That works t=
o our advantage.
> > > > > > > > > > > > >
> > > > > > > > > > > > >                 struct {        /* page_pool used=
 by netstack */
> > > > > > > > > > > > >                         /**
> > > > > > > > > > > > >                          * @pp_magic: magic value=
 to avoid recycling non
> > > > > > > > > > > > >                          * page_pool allocated pa=
ges.
> > > > > > > > > > > > >                          */
> > > > > > > > > > > > >                         unsigned long pp_magic;
> > > > > > > > > > > > >                         struct page_pool *pp;
> > > > > > > > > > > > >                         unsigned long _pp_mapping=
_pad;
> > > > > > > > > > > > >                         unsigned long dma_addr;
> > > > > > > > > > > > >                         atomic_long_t pp_ref_coun=
t;
> > > > > > > > > > > > >                 };
> > > > > > > > > > > > >
> > > > > > > > > > > > > On the other side, we should use variables from t=
he same sub-struct.
> > > > > > > > > > > > > So this patch replaces the "private" with "pp".
> > > > > > > > > > > > >
> > > > > > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.=
com>
> > > > > > > > > > > > > ---
> > > > > > > > > > > >
> > > > > > > > > > > > Instead of doing a customized version of page pool,=
 can we simply
> > > > > > > > > > > > switch to use page pool for big mode instead? Then =
we don't need to
> > > > > > > > > > > > bother the dma stuffs.
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > The page pool needs to do the dma by the DMA APIs.
> > > > > > > > > > > So we can not use the page pool directly.
> > > > > > > > > >
> > > > > > > > > > I found this:
> > > > > > > > > >
> > > > > > > > > > define PP_FLAG_DMA_MAP         BIT(0) /* Should page_po=
ol do the DMA
> > > > > > > > > >                                         * map/unmap
> > > > > > > > > >
> > > > > > > > > > It seems to work here?
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > I have studied the page pool mechanism and believe that w=
e cannot use it
> > > > > > > > > directly. We can make the page pool to bypass the DMA ope=
rations.
> > > > > > > > > This allows us to handle DMA within virtio-net for pages =
allocated from the page
> > > > > > > > > pool. Furthermore, we can utilize page pool helpers to as=
sociate the DMA address
> > > > > > > > > to the page.
> > > > > > > > >
> > > > > > > > > However, the critical issue pertains to unmapping. Ideall=
y, we want to return
> > > > > > > > > the mapped pages to the page pool and reuse them. In doin=
g so, we can omit the
> > > > > > > > > unmapping and remapping steps.
> > > > > > > > >
> > > > > > > > > Currently, there's a caveat: when the page pool cache is =
full, it disconnects
> > > > > > > > > and releases the pages. When the pool hits its capacity, =
pages are relinquished
> > > > > > > > > without a chance for unmapping.
> > > > > > > >
> > > > > > > > Technically, when ptr_ring is full there could be a fallbac=
k, but then
> > > > > > > > it requires expensive synchronization between producer and =
consumer.
> > > > > > > > For virtio-net, it might not be a problem because add/get h=
as been
> > > > > > > > synchronized. (It might be relaxed in the future, actually =
we've
> > > > > > > > already seen a requirement in the past for virito-blk).
> > > > > > >
> > > > > > > The point is that the page will be released by page pool dire=
ctly,
> > > > > > > we will have no change to unmap that, if we work with page po=
ol.
> > > > > >
> > > > > > I mean if we have a fallback, there would be no need to release=
 these
> > > > > > pages but put them into a link list.
> > > > >
> > > > >
> > > > > What fallback?
> > > >
> > > > https://lore.kernel.org/netdev/1519607771-20613-1-git-send-email-ms=
t@redhat.com/
> > > >
> > > > >
> > > > > If we put the pages to the link list, why we use the page pool?
> > > >
> > > > The size of the cache and ptr_ring needs to be fixed.
> > > >
> > > > Again, as explained above, it needs more benchmarks and looks like =
a
> > > > separate topic.
> > > >
> > > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > > If we were to unmap pages each time before
> > > > > > > > > returning them to the pool, we would negate the benefits =
of bypassing the
> > > > > > > > > mapping and unmapping process altogether.
> > > > > > > >
> > > > > > > > Yes, but the problem in this approach is that it creates a =
corner
> > > > > > > > exception where dma_addr is used outside the page pool.
> > > > > > >
> > > > > > > YES. This is a corner exception. We need to introduce this ca=
se to the page
> > > > > > > pool.
> > > > > > >
> > > > > > > So for introducing the page-pool to virtio-net(not only for b=
ig mode),
> > > > > > > we may need to push the page-pool to support dma by drivers.
> > > > > >
> > > > > > Adding Jesper for some comments.
> > > > > >
> > > > > > >
> > > > > > > Back to this patch set, I think we should keep the virtio-net=
 to manage
> > > > > > > the pages.
> > > > > > >
> > > > > > > What do you think?
> > > > > >
> > > > > > I might be wrong, but I think if we need to either
> > > > > >
> > > > > > 1) seek a way to manage the pages by yourself but not touching =
page
> > > > > > pool metadata (or Jesper is fine with this)
> > > > >
> > > > > Do you mean working with page pool or not?
> > > > >
> > > >
> > > > I meant if Jesper is fine with reusing page pool metadata like this=
 patch.
> > > >
> > > > > If we manage the pages by self(no page pool), we do not care the =
metadata is for
> > > > > page pool or not. We just use the space of pages like the "privat=
e".
> > > >
> > > > That's also fine.
> > > >
> > > > >
> > > > >
> > > > > > 2) optimize the unmap for page pool
> > > > > >
> > > > > > or even
> > > > > >
> > > > > > 3) just do dma_unmap before returning the page back to the page=
 pool,
> > > > > > we don't get all the benefits of page pool but we end up with s=
imple
> > > > > > codes (no fallback for premapping).
> > > > >
> > > > > I am ok for this.
> > > >
> > > > Right, we just need to make sure there's no performance regression,
> > > > then it would be fine.
> > > >
> > > > I see for example mana did this as well.
> > >
> > > I think we should not use page pool directly now,
> > > because the mana does not need a space to store the dma address.
> > > We need to store the dma address for unmapping.
> > >
> > > If we use page pool without PP_FLAG_DMA_MAP, then store the dma addre=
ss by
> > > page.dma_addr, I think that is not safe.
> >
> > Jesper, could you comment on this?
> >
> > >
> > > I think the way of this patch set is fine.
> >
> > So it reuses page pool structure in the page structure for another use =
case.
> >
> > > We just use the
> > > space of the page whatever it is page pool or not to store
> > > the link and dma address.
> >
> > Probably because we've already "abused" page->private. I would leave
> > it for other maintainers to decide.
>
> If we do not want to use the elements of the page directly,
> the page pool is a good way.
>

Rethink this, I think that the approach of this series should be fine.
It should be sufficient for virtio-net to guarantee that those pages
are not used by the page pool.

I will continue the review.

Thanks


