Return-Path: <netdev+bounces-89423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B10E68AA3F7
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 22:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26D7A1F22831
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 20:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98225184127;
	Thu, 18 Apr 2024 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZFd8whs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE056A00E;
	Thu, 18 Apr 2024 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713471578; cv=none; b=TG1ivPbLOaS7ipdNVGDq7ijJy0uMTshxrI50Y14KlEAFb+6qt+TrBlakmUDnlxaJ+xDcFyp2hOEXsupPFGSP91urwQuhbXQruvAaY8XZZh314k1R38WBs//ncrIVhdwIw6yrW7KjsV00AXj6C8EYe8U508rz09GXCAD0A3N/Xf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713471578; c=relaxed/simple;
	bh=GG7Q42d4SWcX+x6h5SvZbRjfruU7g6fkWJO6/WrdsSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BWrdSvIpWRHagwt7mHY7cRPDI196bygqJyCHd7APW/WvIe9BQd99ZnuDShgdgtyAnfmEZWcVOFtHXENCkaSs5xWvY350uTZHEqMMHEiYVsem67R2N1hVSbUXExR2EPztiT+8I6zOcUwfqzTEXT4E8oduIPEy8lJE9gHnbdT2qTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZFd8whs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BAEC113CC;
	Thu, 18 Apr 2024 20:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713471578;
	bh=GG7Q42d4SWcX+x6h5SvZbRjfruU7g6fkWJO6/WrdsSI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aZFd8whsAsjxT38Mj4Om4qBW8tijFEjj5lt4khVQ11XxBV+9sMVTbZfDylBVqpm6l
	 LM1BuKH5qFJuTXVqy6XmR4sdyepARwLOY7KsAY0tHrFy01Td8LViQM/4K+ivTjaZmS
	 CEBfxEn8oXVo8CcD5iwDO2lfgEpSLcIabgDfTq5GjE2Vo10SujsdSXr5t3BWo0/P6W
	 UmNoH+Nu4DDgpAMoXJNZGYLwRpCc//0eRDPMDzrPcrO0Ip70EIHUUQfAHjMt9B+LH4
	 E1xNT2Tar53WplVLSYd9+UughKOK9AWrCDar8UM3+CrdSSgFuYlTQStoA5K/EjpJa5
	 cVxR0XklPn0Fw==
Message-ID: <ad98cb14-cc1b-4a01-aacc-8fb53445049e@kernel.org>
Date: Thu, 18 Apr 2024 22:19:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vhost 3/6] virtio_net: replace private by pp struct inside
 page
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
 Matthew Wilcox <willy@infradead.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mel Gorman <mgorman@techsingularity.net>
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
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <1713342055.436048-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17/04/2024 10.20, Xuan Zhuo wrote:
> On Wed, 17 Apr 2024 12:08:10 +0800, Jason Wang <jasowang@redhat.com> wrote:
>> On Wed, Apr 17, 2024 at 9:38 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>>>
>>> On Tue, 16 Apr 2024 11:24:53 +0800, Jason Wang <jasowang@redhat.com> wrote:
>>>> On Mon, Apr 15, 2024 at 5:04 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>>>>>
>>>>> On Mon, 15 Apr 2024 16:56:45 +0800, Jason Wang <jasowang@redhat.com> wrote:
>>>>>> On Mon, Apr 15, 2024 at 4:50 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>>>>>>>
>>>>>>> On Mon, 15 Apr 2024 14:43:24 +0800, Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>> On Mon, Apr 15, 2024 at 10:35 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>>>>>>>>>
>>>>>>>>> On Fri, 12 Apr 2024 13:49:12 +0800, Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>> On Fri, Apr 12, 2024 at 1:39 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> On Fri, 12 Apr 2024 12:47:55 +0800, Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>>>> On Thu, Apr 11, 2024 at 10:51 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> Now, we chain the pages of big mode by the page's private variable.
>>>>>>>>>>>>> But a subsequent patch aims to make the big mode to support
>>>>>>>>>>>>> premapped mode. This requires additional space to store the dma addr.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Within the sub-struct that contains the 'private', there is no suitable
>>>>>>>>>>>>> variable for storing the DMA addr.
>>>>>>>>>>>>>
>>>>>>>>>>>>>                  struct {        /* Page cache and anonymous pages */
>>>>>>>>>>>>>                          /**
>>>>>>>>>>>>>                           * @lru: Pageout list, eg. active_list protected by
>>>>>>>>>>>>>                           * lruvec->lru_lock.  Sometimes used as a generic list
>>>>>>>>>>>>>                           * by the page owner.
>>>>>>>>>>>>>                           */
>>>>>>>>>>>>>                          union {
>>>>>>>>>>>>>                                  struct list_head lru;
>>>>>>>>>>>>>
>>>>>>>>>>>>>                                  /* Or, for the Unevictable "LRU list" slot */
>>>>>>>>>>>>>                                  struct {
>>>>>>>>>>>>>                                          /* Always even, to negate PageTail */
>>>>>>>>>>>>>                                          void *__filler;
>>>>>>>>>>>>>                                          /* Count page's or folio's mlocks */
>>>>>>>>>>>>>                                          unsigned int mlock_count;
>>>>>>>>>>>>>                                  };
>>>>>>>>>>>>>
>>>>>>>>>>>>>                                  /* Or, free page */
>>>>>>>>>>>>>                                  struct list_head buddy_list;
>>>>>>>>>>>>>                                  struct list_head pcp_list;
>>>>>>>>>>>>>                          };
>>>>>>>>>>>>>                          /* See page-flags.h for PAGE_MAPPING_FLAGS */
>>>>>>>>>>>>>                          struct address_space *mapping;
>>>>>>>>>>>>>                          union {
>>>>>>>>>>>>>                                  pgoff_t index;          /* Our offset within mapping. */
>>>>>>>>>>>>>                                  unsigned long share;    /* share count for fsdax */
>>>>>>>>>>>>>                          };
>>>>>>>>>>>>>                          /**
>>>>>>>>>>>>>                           * @private: Mapping-private opaque data.
>>>>>>>>>>>>>                           * Usually used for buffer_heads if PagePrivate.
>>>>>>>>>>>>>                           * Used for swp_entry_t if PageSwapCache.
>>>>>>>>>>>>>                           * Indicates order in the buddy system if PageBuddy.
>>>>>>>>>>>>>                           */
>>>>>>>>>>>>>                          unsigned long private;
>>>>>>>>>>>>>                  };
>>>>>>>>>>>>>
>>>>>>>>>>>>> But within the page pool struct, we have a variable called
>>>>>>>>>>>>> dma_addr that is appropriate for storing dma addr.
>>>>>>>>>>>>> And that struct is used by netstack. That works to our advantage.
>>>>>>>>>>>>>
>>>>>>>>>>>>>                  struct {        /* page_pool used by netstack */
>>>>>>>>>>>>>                          /**
>>>>>>>>>>>>>                           * @pp_magic: magic value to avoid recycling non
>>>>>>>>>>>>>                           * page_pool allocated pages.
>>>>>>>>>>>>>                           */
>>>>>>>>>>>>>                          unsigned long pp_magic;
>>>>>>>>>>>>>                          struct page_pool *pp;
>>>>>>>>>>>>>                          unsigned long _pp_mapping_pad;
>>>>>>>>>>>>>                          unsigned long dma_addr;
>>>>>>>>>>>>>                          atomic_long_t pp_ref_count;
>>>>>>>>>>>>>                  };
>>>>>>>>>>>>>
>>>>>>>>>>>>> On the other side, we should use variables from the same sub-struct.
>>>>>>>>>>>>> So this patch replaces the "private" with "pp".
>>>>>>>>>>>>>
>>>>>>>>>>>>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>
>>>>>>>>>>>> Instead of doing a customized version of page pool, can we simply
>>>>>>>>>>>> switch to use page pool for big mode instead? Then we don't need to
>>>>>>>>>>>> bother the dma stuffs.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> The page pool needs to do the dma by the DMA APIs.
>>>>>>>>>>> So we can not use the page pool directly.
>>>>>>>>>>
>>>>>>>>>> I found this:
>>>>>>>>>>
>>>>>>>>>> define PP_FLAG_DMA_MAP         BIT(0) /* Should page_pool do the DMA
>>>>>>>>>>                                          * map/unmap
>>>>>>>>>>
>>>>>>>>>> It seems to work here?
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I have studied the page pool mechanism and believe that we cannot use it
>>>>>>>>> directly. We can make the page pool to bypass the DMA operations.
>>>>>>>>> This allows us to handle DMA within virtio-net for pages allocated from the page
>>>>>>>>> pool. Furthermore, we can utilize page pool helpers to associate the DMA address
>>>>>>>>> to the page.
>>>>>>>>>
>>>>>>>>> However, the critical issue pertains to unmapping. Ideally, we want to return
>>>>>>>>> the mapped pages to the page pool and reuse them. In doing so, we can omit the
>>>>>>>>> unmapping and remapping steps.
>>>>>>>>>
>>>>>>>>> Currently, there's a caveat: when the page pool cache is full, it disconnects
>>>>>>>>> and releases the pages. When the pool hits its capacity, pages are relinquished
>>>>>>>>> without a chance for unmapping.

Could Jakub's memory provider for PP help your use-case?

See: [1] 
https://lore.kernel.org/all/20240403002053.2376017-3-almasrymina@google.com/
Or: [2]
https://lore.kernel.org/netdev/f8270765-a27b-6ccf-33ea-cda097168d79@redhat.com/T/


[...]
>>>>>>
>>>>>> Adding Jesper for some comments.
>>>>>>
>>>>>>>
>>>>>>> Back to this patch set, I think we should keep the virtio-net to manage
>>>>>>> the pages.
>>>>>>>

For context the patch:
  [3] 
https://lore.kernel.org/all/20240411025127.51945-4-xuanzhuo@linux.alibaba.com/

>>>>>>> What do you think?
>>>>>>
>>>>>> I might be wrong, but I think if we need to either
>>>>>>
>>>>>> 1) seek a way to manage the pages by yourself but not touching page
>>>>>> pool metadata (or Jesper is fine with this)
>>>>>
>>>>> Do you mean working with page pool or not?
>>>>>
>>>>
>>>> I meant if Jesper is fine with reusing page pool metadata like this patch.
>>>>
>>>>> If we manage the pages by self(no page pool), we do not care the metadata is for
>>>>> page pool or not. We just use the space of pages like the "private".
>>>>
>>>> That's also fine.
>>>>

I'm not sure it is "fine" to, explicitly choosing not to use page pool,
and then (ab)use `struct page` member (pp) that intended for page_pool
for other stuff. (In this case create a linked list of pages).

  +#define page_chain_next(p)	((struct page *)((p)->pp))
  +#define page_chain_add(p, n)	((p)->pp = (void *)n)

I'm not sure that I (as PP maintainer) can make this call actually, as I
think this area belong with the MM "page" maintainers (Cc MM-list +
people) to judge.

Just invention new ways to use struct page fields without adding your
use-case to struct page, will make it harder for MM people to maintain
(e.g. make future change).

--Jesper



