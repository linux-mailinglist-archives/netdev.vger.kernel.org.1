Return-Path: <netdev+bounces-143848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8099C47D9
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 22:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A25C2831F0
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 21:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D574E1B4F07;
	Mon, 11 Nov 2024 21:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="L/fNHN4j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15B01AC423
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 21:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731359750; cv=none; b=kQVTSiu+vpQlcq/zhEpA/T9ClIAWJKT8tD2LN8uMVMam5ER5PTuj8UdzwGqCYFYqW86aVO3QhwiHDsyz15Kr9ypmGF7jMMX4YuCwyBf6PC8wDdTRxwgH3zbzKzjHq7vII91fZYfh3gKQAaYd3KEGUeRBNV6DxmcFX87yVNBqSHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731359750; c=relaxed/simple;
	bh=7Geq36YsKhhXDuqe06bh01tGK+9X5KImpp8oZwoI3lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTwyMrPzIvxyrOd/SKdybg4XxmLefl93Y3bAo2MvVLdx3OuCE2DDEPJLIZNfL66yrQnOA18CZ6xCCAMqWPgHp70FxPzxKbv0Ab+1Hie2bbTywa9wVoUndAgAILo+IOEPc8FPVxk7xjBCxJL0wwLNXF/KmhUiBg5DVHVc1EyRYGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=L/fNHN4j; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-720b2d8bcd3so3948196b3a.2
        for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 13:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1731359748; x=1731964548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YkGDjOxII7VQufd5sh1pDQsReY42/ldouaEkNzTrm88=;
        b=L/fNHN4jQzAado/fXCJj3vIy0/Zpvb6GtBV44NsVsRq3RU6re6VIxXrGqDAZeMaiwm
         txIc0ve+vpqo7x14Bk4RJFZVsX32FbMMOu5yk2F6JC6DpUimST6VWAVj9UOJ2z6NMEAS
         lMlwhHTfRz0B2zt+R5EU2j2yGq3wWn5qLosYqdm5SoGYf317Eyntggbpe+N/3dvsudXc
         1AdtGu0h9XStvU5mpr9+3JsghOqvz9Kt073V8hZtKjrD8ReuqudfJNKEYyVlIwNydw2b
         khNkz8ueJn8F9e/uV56xXgy7vrgGQ6lX3J2he6csVam1U7ZM/fZjHqB9VbTWdFnlfVYU
         FO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731359748; x=1731964548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YkGDjOxII7VQufd5sh1pDQsReY42/ldouaEkNzTrm88=;
        b=CRgU0VgOfhPEAO9yhKcSqv+OyKSXqYZXvFQ5i8BYEZvfx3caU2SIKVtI9VsyZ/nE/h
         aETIAn/APWnj/2TIh6ymDBcWloDm56zIdIvqQMqm721EX0A1krM2x6+OW4n37VTUUF90
         B2krZjvb7FKMGT24TNZRmPZUW3XWznzcen9Gg9lwCw3fpvueDGRnzRmb+rzltnLmRGJ0
         QXDdQa1gU1vc8zQa4gSNqH0MJRUy0SAc97xZYh72teEH3HW2egg0VljaIJ4HEJQngRQP
         t6voGcMUlbhdoCzc+NjzK+KoUvFwhErRezF9m8hn8UvsE3ibgX0Ya/PUmtd1flveDK63
         0BHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuqLKf7ZRSTbCWU2CBobLeVzKDTrP7hnvvhIxc85ldSPCXfpEA6bZHh6ll5LAbehG5xhiAyvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhupMnj5wyUcVimGNpW/mtAFFsBkUxoCfYP9gWpIRz3A/Sqpj5
	U35XB/uFVLvP0lWwiH+cm2ZwFGRI4fx6DESako2ZIhwGd+Hm28oO8dEFDG8cT/0=
X-Google-Smtp-Source: AGHT+IFRv5tVXpM6sXTltj1b7AIDm9Lu1QWWWZW4vV6EEnpmJgsomMTmX7jf69Sb7Fer+jRS36t6rg==
X-Received: by 2002:a05:6a00:929a:b0:71e:6489:d18 with SMTP id d2e1a72fcca58-72413368ee6mr18316423b3a.22.1731359748119;
        Mon, 11 Nov 2024 13:15:48 -0800 (PST)
Received: from ?IPV6:2a00:79e1:abc:cf05:1cf2:8e0f:c0eb:3606? ([2a00:79e1:abc:cf05:1cf2:8e0f:c0eb:3606])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a6c542sm9895443b3a.189.2024.11.11.13.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 13:15:47 -0800 (PST)
Message-ID: <9ed60db4-234c-4565-93d6-4dac6b4e4e15@davidwei.uk>
Date: Mon, 11 Nov 2024 13:15:46 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/15] io_uring/zcrx: implement zerocopy receive pp
 memory provider
To: Mina Almasry <almasrymina@google.com>,
 Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Pedro Tammela <pctammela@mojatatu.com>
References: <20241029230521.2385749-1-dw@davidwei.uk>
 <20241029230521.2385749-12-dw@davidwei.uk>
 <CAHS8izNbNCAmecRDCL_rRjMU0Spnqo_BY5pyG1EhF2rZFx+y0A@mail.gmail.com>
 <af9a249a-1577-40fd-b1ba-be3737e86b18@gmail.com>
 <CAHS8izPEmbepTYsjjsxX_Dt-0Lz1HviuCyPM857-0q4GPdn4Rg@mail.gmail.com>
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CAHS8izPEmbepTYsjjsxX_Dt-0Lz1HviuCyPM857-0q4GPdn4Rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-11-04 11:54, Mina Almasry wrote:
> On Fri, Nov 1, 2024 at 2:09 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 11/1/24 20:06, Mina Almasry wrote:
>> ...
>>>> +__maybe_unused
>>>> +static const struct memory_provider_ops io_uring_pp_zc_ops;
>>>> +
>>>> +static inline struct io_zcrx_area *io_zcrx_iov_to_area(const struct net_iov *niov)
>>>> +{
>>>> +       struct net_iov_area *owner = net_iov_owner(niov);
>>>> +
>>>> +       return container_of(owner, struct io_zcrx_area, nia);
>>>> +}
>>>> +
>>>
>>> We discussed this before I disappeared on vacation but I'm not too
>>> convinced to be honest, sorry.
>>>
>>> It's invalid to call io_zcrx_iov_to_area on a devmem niov and vice
>>> versa, right? So current and future code has to be very careful to
>>
>> Yes
>>
>>> call the right helpers on the right niovs.
>>>
>>> At the very least there needs to be a comment above all these
>>> container_of helpers:
>>>
>>> /* caller must have verified that this niov is devmem/io_zcrx */.
>>>
>>> However I feel like even a comment is extremely error prone. These
>>> container_of's are inside of the call stack of some helpers. I would
>>> say we need a check. If we're concerned about performance, the check
>>> can be behind DEBUG_NET_WARN_ON(), although even that is a bit iffy,
>>> but could be fine. Doing this without a check seems too risky to me.
>>
>> No, it doesn't need a check nor it needs a comment. The very
>> essence of virtual function tables is that they're coupled
>> together with objects for which those function make sense and
>> called only for those objects. The only way to get here with
>> invalid net_iovs is to take one page pool and feed it with
>> net_iovs from other another page pool that won't be sane in
>> the first place.
>>
> 
> That could happen. In fact the whole devmem tcp paths are very
> carefully written to handle that
> 
> net_iovs are allocated from the page_pool, put in skbs, and then sit
> in the sk receive queue. In pathological cases (user is
> re/misconfiguring flow steering) we can have 1 sk receive queue that
> has a mix of page skbs, devmem skbs, and io_uring skbs, and other
> skbs.
> 
> Code that is processing the skbs in the receive queue has no idea
> whether what kind of skb it is. That's why that code needs to check
> whether the skb has readable frags, and that's why in this very series
> you needed to add a check in tcp_recvmsg_dmabuf to make sure that its
> a dmabuf skb, and you need to add a check to io_zcrx_recv_frag that
> the frag inside it is io_uring niov. The code would be wrong without
> it.

The checks are already there in e.g. io_zcrx_recv_frag() to prevent
io_zcrx_iov_to_area() from being called on a devmem niov.

io_zcrx_copy_chunk() does not need a check because it is guaranteed to
only call io_zcrx_iov_to_area() on an io_uring niov. Copying happens in
two cases:

1. Not a niov
2. If offset is in the linearized part of an skb

Both cases do not apply to devmem so it is safe even in the case of an
skb rcvbuf with a mixture of non-niov, devmem niov and io_uring niov.

> 
> All I'm trying to say is that it's very error prone to rely on folks
> writing and reviewing code to check that whenever dmabuf/io_rcrx/etc
> handling is done, somewhere in the call stack a type verification
> check has been made, and a DEBUG_NET_WARN could help avoid some subtle
> memory corruption bugs.

This is a fair ask. I'll address it in the next iteration.

> 
>> That would be an equivalent of:
>>
>> struct file *f1 = ...;
>> struct file *f2 = ...;
>>
>> f1->f_op->read(f2, ...);
>>
>> Maybe it looks strange for you in C, but it's same as putting
>> comments that a virtual function that it should be called only
>> for objects of that class:
>>
>> struct A {
>>         virtual void foo() = 0;
>> };
>> struct B: public A {
>>         void foo() override {
>>                 // we should only be called with objects of type
>>                 // struct B (or anything inheriting it), check that
>>                 if (!reinterpret_cast<struct B*>(this))
>>                         throw;
>>                 ...
>>         }
>> }
>>
>>
> 
> I'm not really sure I followed here. We do not get any type of
> compiler or type safety from this code because the dma-buf niovs and
> io_uring niovs are the same net_iov type.
> 
> We can get type safety by defining new types for dmabuf_net_iov and
> io_uring_net_iov, then provide helpers:
> 
> dmabuf_net_iov *net_iov_to_dmabuf();
> io_uring_net_iov *net_iov_to_io_uring();
> 
> The helpers can check the niov is of the right type once and do a
> cast,  then the object with the specific type can be passed to all
> future heplers without additional checks. This is one way to do it I
> guess.
> 
>>>>   static int io_allocate_rbuf_ring(struct io_zcrx_ifq *ifq,
>>>>                                   struct io_uring_zcrx_ifq_reg *reg)
>>>>   {
>>>> @@ -99,6 +114,9 @@ static int io_zcrx_create_area(struct io_ring_ctx *ctx,
>>>>                  goto err;
>>>>
>>>>          for (i = 0; i < nr_pages; i++) {
>>>> +               struct net_iov *niov = &area->nia.niovs[i];
>>>> +
>>>> +               niov->owner = &area->nia;
>>>>                  area->freelist[i] = i;
>>>>          }
>>>>
>>>> @@ -230,3 +248,200 @@ void io_shutdown_zcrx_ifqs(struct io_ring_ctx *ctx)
>>>>   {
>>>>          lockdep_assert_held(&ctx->uring_lock);
>>>>   }
>>>> +
>>>> +static bool io_zcrx_niov_put(struct net_iov *niov, int nr)
>>>> +{
>>>> +       return atomic_long_sub_and_test(nr, &niov->pp_ref_count);
>>>> +}
>>>> +
>>>> +static bool io_zcrx_put_niov_uref(struct net_iov *niov)
>>>> +{
>>>> +       if (atomic_long_read(&niov->pp_ref_count) < IO_ZC_RX_UREF)
>>>> +               return false;
>>>> +
>>>> +       return io_zcrx_niov_put(niov, IO_ZC_RX_UREF);
>>>> +}
>>>> +
>>>
>>> Sorry, I have to push back a bit against this. The refcounting of
>>> netmem is already complicated. the paged netmem has 2 refcounts and
>>> care needs to be taken when acquiring and dropping refcounts. net_iov
>>> inherited the pp_ref_count but not the paged refcount, and again need
>>> some special handling. skb_frag_unref takes very special care checking
>>
>> Which is why it's using net_iovs.
>>
>>> pp->recycle, is_pp_netmem, and others to figure out the correct
>>
>> pp->recycle has nothing to do with the series. We don't add
>> it in any special way, and if it's broken it's broken even
>> for non-proivder buffers.
>>
>>> refcount to put based on the type of the netmem and skb flag.
>>
>> Just same as with the ->[un]readable flag, which is not
>> functionally needed, and if it's screwed many things can
>> go very wrong.
>>
>>> This code ignores all these generic code
>>> skb_frag_unref/napi_pp_put_page/etc paths and uses raw access to
>>
>> I don't see the point, they are not used because they're not
>> needed. Instead of checking whether it came from a page pool
>> and whether it's net_iov or not, in the path io_uring returns
>> it we already apriori know that they're from a specific page
>> pool, net_iov and from the current provider.
>>
>> Same for optimisations provided by those helpers, they are
>> useful when you're transferring buffers from one context to
>> another, e.g. task recieve path -> napi / page_pool. In this
>> case they're already fetched in the right context without any
>> need to additionally jumping through the hoops. If anything,
>> it'd be odd to jump out of a window to climb a rope on the
>> other side of the building when you could've just walked 5
>> meters to the other room.
>>
> 
> For me, "they are not used because they're not needed." is not enough
> justification to ignore the generic code paths that support generic
> use cases and add your own freeing path and recycling that needs to
> work adjacent to generic paths for posterity. You need to provide
> concrete reasons why the current code paths don't work for you and
> can't be made to work for you.

We are already using io_uring specific code, though. The entire feature
requires the use of io_uring, and sockets that are set up for it can
only be (properly) consumed via io_uring specific functions. The return
path is no different.

Consuming via standard syscalls is still functionally correct. In that
case, the skbs when freed will go back to the page pool via the generic
paths e.g. napi_pp_put_page(). But in the intended fast path, returning
via the io_uring specific refill ring, there is no reason why we must
use the generic return functions.

> 
> Is it very complicated to napi_pp_put_page() niovs as the user puts
> them in the refill queue without adding a new syscall? If so, is it
> possible to do a niov equivalent of page_pool_put_page_bulk() of the
> refill queue while/as you process the RX path?
> 
> If you've tested the generic code paths to be performance deficient
> and your recycling is indeed better, you could improve the page_pool
> to pull netmems when it needs to like you're doing here, but in a
> generic way that applies to the page allocator and other providers.
> Not a one-off implementation that only applies to your provider.
> 
> If you're absolutely set on ignoring the currently supported reffing
> and implementing your own reffing and recycling for your use case,
> sure, that could work, but please don't overload the
> niov->pp_ref_count reserved for the generic use cases for this. Add
> io_zcrx_area->io_uring_ref or something and do whatever you want with
> it. Since it's not sharing the pp_ref_count with the generic code
> paths I don't see them conflicting in the future.

Why insist on this? Both page/niov and devmem/io_uring niov are mutually
exclusive. There is no strong technical reason to not re-use
pp_ref_count.

> 
> --
> Thanks,
> Mina

