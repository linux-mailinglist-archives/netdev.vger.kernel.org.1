Return-Path: <netdev+bounces-89520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 879EF8AA8F4
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 09:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9C85B21690
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 07:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE773E49C;
	Fri, 19 Apr 2024 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wHR5/nXU"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC003E485
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 07:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713510953; cv=none; b=dFheXEehMLHO13vMEGRDvezcsKYgJW1DcTCCO4Gkt0KvnS2koENpg/2trDrJ6nfB0lI/1AolVGdicl/F4thDcQmvISQ+0BamQIOEHIN1EfrGt3f49B9mqfR5X9Hgd0sTHnwWAU/Bx6Mue8oF1ladldiYpJMKBe8qb2YCQ167FjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713510953; c=relaxed/simple;
	bh=0qIhPmtQ934vDMNZIqw1JSXQBhVDDTN5SgruQ6SELns=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=C2rMZOHs2LyvblfnJ9V5I8EM8pmyZZENq+v/UcYFXJFKPI1Zg+t5F59s5t3rJ3jSxRqFlyIPWTA3txtBkFjhQkXaRnHu8VSByRDgce57203SERwGqojW2C5ePULdQKpvKR0y/hqztKHplGWMGjghEwhSjIgfY24F+FVSVBtMD2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wHR5/nXU; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713510948; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=UCDmf20Cih3kKrwUAIn8HTjy/hEIigc64u7/WKr64vU=;
	b=wHR5/nXUrxvNafXYKuy/gge+Us8VpNTUi+fQ/Gst9SiRWFgaxoSV9OU7g+HMUVeiZwkoWvOrY53upMNzOSmHrrcWoWwjq1+v8UidwQJG8N8v2CmjWgJj7lWKIvFgd0ZqtsKLNLap7wb04x9xbitOrlkN9eQqaJjEHkNfWkr56JA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W4rVZE5_1713510945;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4rVZE5_1713510945)
          by smtp.aliyun-inc.com;
          Fri, 19 Apr 2024 15:15:46 +0800
Message-ID: <1713510661.7868748-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 3/6] virtio_net: replace private by pp struct inside page
Date: Fri, 19 Apr 2024 15:11:01 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org,
 "Linux-MM" <linux-mm@kvack.org>,
 Matthew Wilcox <willy@infradead.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mel Gorman <mgorman@techsingularity.net>,
 Jason Wang <jasowang@redhat.com>
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
 <1713317444.7698638-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvjwXpF_mLR3H8ZW9PUE+3spcxKMQV1VvUARb0-Lt7NKQ@mail.gmail.com>
 <1713342055.436048-1-xuanzhuo@linux.alibaba.com>
 <ad98cb14-cc1b-4a01-aacc-8fb53445049e@kernel.org>
In-Reply-To: <ad98cb14-cc1b-4a01-aacc-8fb53445049e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 18 Apr 2024 22:19:33 +0200, Jesper Dangaard Brouer <hawk@kernel.org=
> wrote:
>
>
> On 17/04/2024 10.20, Xuan Zhuo wrote:
> > On Wed, 17 Apr 2024 12:08:10 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> >> On Wed, Apr 17, 2024 at 9:38=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> >>>
> >>> On Tue, 16 Apr 2024 11:24:53 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> >>>> On Mon, Apr 15, 2024 at 5:04=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.al=
ibaba.com> wrote:
> >>>>>
> >>>>> On Mon, 15 Apr 2024 16:56:45 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> >>>>>> On Mon, Apr 15, 2024 at 4:50=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.=
alibaba.com> wrote:
> >>>>>>>
> >>>>>>> On Mon, 15 Apr 2024 14:43:24 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> >>>>>>>> On Mon, Apr 15, 2024 at 10:35=E2=80=AFAM Xuan Zhuo <xuanzhuo@lin=
ux.alibaba.com> wrote:
> >>>>>>>>>
> >>>>>>>>> On Fri, 12 Apr 2024 13:49:12 +0800, Jason Wang <jasowang@redhat=
.com> wrote:
> >>>>>>>>>> On Fri, Apr 12, 2024 at 1:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@li=
nux.alibaba.com> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> On Fri, 12 Apr 2024 12:47:55 +0800, Jason Wang <jasowang@redh=
at.com> wrote:
> >>>>>>>>>>>> On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo=
@linux.alibaba.com> wrote:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Now, we chain the pages of big mode by the page's private v=
ariable.
> >>>>>>>>>>>>> But a subsequent patch aims to make the big mode to support
> >>>>>>>>>>>>> premapped mode. This requires additional space to store the=
 dma addr.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Within the sub-struct that contains the 'private', there is=
 no suitable
> >>>>>>>>>>>>> variable for storing the DMA addr.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>                  struct {        /* Page cache and anonymou=
s pages */
> >>>>>>>>>>>>>                          /**
> >>>>>>>>>>>>>                           * @lru: Pageout list, eg. active_=
list protected by
> >>>>>>>>>>>>>                           * lruvec->lru_lock.  Sometimes us=
ed as a generic list
> >>>>>>>>>>>>>                           * by the page owner.
> >>>>>>>>>>>>>                           */
> >>>>>>>>>>>>>                          union {
> >>>>>>>>>>>>>                                  struct list_head lru;
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>                                  /* Or, for the Unevictable=
 "LRU list" slot */
> >>>>>>>>>>>>>                                  struct {
> >>>>>>>>>>>>>                                          /* Always even, to=
 negate PageTail */
> >>>>>>>>>>>>>                                          void *__filler;
> >>>>>>>>>>>>>                                          /* Count page's or=
 folio's mlocks */
> >>>>>>>>>>>>>                                          unsigned int mlock=
_count;
> >>>>>>>>>>>>>                                  };
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>                                  /* Or, free page */
> >>>>>>>>>>>>>                                  struct list_head buddy_lis=
t;
> >>>>>>>>>>>>>                                  struct list_head pcp_list;
> >>>>>>>>>>>>>                          };
> >>>>>>>>>>>>>                          /* See page-flags.h for PAGE_MAPPI=
NG_FLAGS */
> >>>>>>>>>>>>>                          struct address_space *mapping;
> >>>>>>>>>>>>>                          union {
> >>>>>>>>>>>>>                                  pgoff_t index;          /*=
 Our offset within mapping. */
> >>>>>>>>>>>>>                                  unsigned long share;    /*=
 share count for fsdax */
> >>>>>>>>>>>>>                          };
> >>>>>>>>>>>>>                          /**
> >>>>>>>>>>>>>                           * @private: Mapping-private opaqu=
e data.
> >>>>>>>>>>>>>                           * Usually used for buffer_heads i=
f PagePrivate.
> >>>>>>>>>>>>>                           * Used for swp_entry_t if PageSwa=
pCache.
> >>>>>>>>>>>>>                           * Indicates order in the buddy sy=
stem if PageBuddy.
> >>>>>>>>>>>>>                           */
> >>>>>>>>>>>>>                          unsigned long private;
> >>>>>>>>>>>>>                  };
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> But within the page pool struct, we have a variable called
> >>>>>>>>>>>>> dma_addr that is appropriate for storing dma addr.
> >>>>>>>>>>>>> And that struct is used by netstack. That works to our adva=
ntage.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>                  struct {        /* page_pool used by netst=
ack */
> >>>>>>>>>>>>>                          /**
> >>>>>>>>>>>>>                           * @pp_magic: magic value to avoid=
 recycling non
> >>>>>>>>>>>>>                           * page_pool allocated pages.
> >>>>>>>>>>>>>                           */
> >>>>>>>>>>>>>                          unsigned long pp_magic;
> >>>>>>>>>>>>>                          struct page_pool *pp;
> >>>>>>>>>>>>>                          unsigned long _pp_mapping_pad;
> >>>>>>>>>>>>>                          unsigned long dma_addr;
> >>>>>>>>>>>>>                          atomic_long_t pp_ref_count;
> >>>>>>>>>>>>>                  };
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> On the other side, we should use variables from the same su=
b-struct.
> >>>>>>>>>>>>> So this patch replaces the "private" with "pp".
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >>>>>>>>>>>>> ---
> >>>>>>>>>>>>
> >>>>>>>>>>>> Instead of doing a customized version of page pool, can we s=
imply
> >>>>>>>>>>>> switch to use page pool for big mode instead? Then we don't =
need to
> >>>>>>>>>>>> bother the dma stuffs.
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> The page pool needs to do the dma by the DMA APIs.
> >>>>>>>>>>> So we can not use the page pool directly.
> >>>>>>>>>>
> >>>>>>>>>> I found this:
> >>>>>>>>>>
> >>>>>>>>>> define PP_FLAG_DMA_MAP         BIT(0) /* Should page_pool do t=
he DMA
> >>>>>>>>>>                                          * map/unmap
> >>>>>>>>>>
> >>>>>>>>>> It seems to work here?
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> I have studied the page pool mechanism and believe that we cann=
ot use it
> >>>>>>>>> directly. We can make the page pool to bypass the DMA operation=
s.
> >>>>>>>>> This allows us to handle DMA within virtio-net for pages alloca=
ted from the page
> >>>>>>>>> pool. Furthermore, we can utilize page pool helpers to associat=
e the DMA address
> >>>>>>>>> to the page.
> >>>>>>>>>
> >>>>>>>>> However, the critical issue pertains to unmapping. Ideally, we =
want to return
> >>>>>>>>> the mapped pages to the page pool and reuse them. In doing so, =
we can omit the
> >>>>>>>>> unmapping and remapping steps.
> >>>>>>>>>
> >>>>>>>>> Currently, there's a caveat: when the page pool cache is full, =
it disconnects
> >>>>>>>>> and releases the pages. When the pool hits its capacity, pages =
are relinquished
> >>>>>>>>> without a chance for unmapping.
>
> Could Jakub's memory provider for PP help your use-case?
>
> See: [1]
> https://lore.kernel.org/all/20240403002053.2376017-3-almasrymina@google.c=
om/
> Or: [2]
> https://lore.kernel.org/netdev/f8270765-a27b-6ccf-33ea-cda097168d79@redha=
t.com/T/


It can not. That make the pp can get page by the callbacks.

Here we talk about the map/unmap.

The virtio-net has the different DMA APIs.

	dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *ptr=
, size_t size,
						  enum dma_data_direction dir, unsigned long attrs);
	void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t ad=
dr,
					      size_t size, enum dma_data_direction dir,
					      unsigned long attrs);
	dma_addr_t virtqueue_dma_map_page_attrs(struct virtqueue *_vq, struct page=
 *page,
						size_t offset, size_t size,
						enum dma_data_direction dir,
						unsigned long attrs);
	void virtqueue_dma_unmap_page_attrs(struct virtqueue *_vq, dma_addr_t addr,
					    size_t size, enum dma_data_direction dir,
					    unsigned long attrs);
	int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr);

	bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr);
	void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq, dma_ad=
dr_t addr,
						     unsigned long offset, size_t size,
						     enum dma_data_direction dir);
	void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq, dma=
_addr_t addr,
							unsigned long offset, size_t size,
							enum dma_data_direction dir);


Thanks.

>
>
> [...]
> >>>>>>
> >>>>>> Adding Jesper for some comments.
> >>>>>>
> >>>>>>>
> >>>>>>> Back to this patch set, I think we should keep the virtio-net to =
manage
> >>>>>>> the pages.
> >>>>>>>
>
> For context the patch:
>   [3]
> https://lore.kernel.org/all/20240411025127.51945-4-xuanzhuo@linux.alibaba=
.com/
>
> >>>>>>> What do you think?
> >>>>>>
> >>>>>> I might be wrong, but I think if we need to either
> >>>>>>
> >>>>>> 1) seek a way to manage the pages by yourself but not touching page
> >>>>>> pool metadata (or Jesper is fine with this)
> >>>>>
> >>>>> Do you mean working with page pool or not?
> >>>>>
> >>>>
> >>>> I meant if Jesper is fine with reusing page pool metadata like this =
patch.
> >>>>
> >>>>> If we manage the pages by self(no page pool), we do not care the me=
tadata is for
> >>>>> page pool or not. We just use the space of pages like the "private".
> >>>>
> >>>> That's also fine.
> >>>>
>
> I'm not sure it is "fine" to, explicitly choosing not to use page pool,
> and then (ab)use `struct page` member (pp) that intended for page_pool
> for other stuff. (In this case create a linked list of pages).
>
>   +#define page_chain_next(p)	((struct page *)((p)->pp))
>   +#define page_chain_add(p, n)	((p)->pp =3D (void *)n)
>
> I'm not sure that I (as PP maintainer) can make this call actually, as I
> think this area belong with the MM "page" maintainers (Cc MM-list +
> people) to judge.
>
> Just invention new ways to use struct page fields without adding your
> use-case to struct page, will make it harder for MM people to maintain
> (e.g. make future change).
>
> --Jesper
>
>

