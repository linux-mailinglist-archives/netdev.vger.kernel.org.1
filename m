Return-Path: <netdev+bounces-175351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED597A6554D
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 16:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2FD164EAE
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 15:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5856A143748;
	Mon, 17 Mar 2025 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TGahoi2D"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93FE15666D
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742224612; cv=none; b=gXnKDkXxYGIVQ9DMmBTqJcq7sEgN40xl++uPaZyrGJLyXL6v2BIT71sgEoYPY+koOwJCuHZx7PlTmjiTJh/Nn3M4Q89TbY053hJo4mpRMhc/6dunwAKYeuDlfXUJTVxH8naesAUmISjwXVmDikQ9zPs8vZ/c4GvZz7sc73hnJoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742224612; c=relaxed/simple;
	bh=04tKKufKa20R9b387LUCyZ+68oviqMpABoU5vNN4Wzg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RrJ3BAQOEQ7QRM2kAGuibZCQt1UoJ5rMRYHczspoxMQZOaKoXOhpyjZPMD1nQb8SA+MMa1mg0i/gDq9hwXKYvcHxfoKBrupjhESyW6Avbo9VaxcE9UM5xE8zICu9LxMi+I3TqtU1N17yUKxDG3WdydiJ8ppeOvV9bhU82YsLCZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TGahoi2D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742224608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CzRZI32PvG1jM7oaHs4LUm1pa2tu5/yx3DzI4q+HHBg=;
	b=TGahoi2DAXBWMxyFbkeVOVUnKvvDoh0GUFSuCprjd0dKL15mf8xM7YOVj00ewXgoeCop0G
	XWAjkpEtqSDUiDC0dvyVo3me6hq1lfx81nRtjda9znfqSo+yw+EcnC2h6U2VKreW6SnksH
	zkxeKrEQ0X5VMjngIwOR7lx1tUpcAjs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-5o48pqhFPrCGWvT1sazyUg-1; Mon, 17 Mar 2025 11:16:47 -0400
X-MC-Unique: 5o48pqhFPrCGWvT1sazyUg-1
X-Mimecast-MFC-AGG-ID: 5o48pqhFPrCGWvT1sazyUg_1742224606
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-30c4168ffd8so19706031fa.3
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 08:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742224606; x=1742829406;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzRZI32PvG1jM7oaHs4LUm1pa2tu5/yx3DzI4q+HHBg=;
        b=gGOQ+14/IIHzaQth1J8JBCuTHg7zZrFsVeCXd4pyH0m+qmyLEwX278dwEKK9p0oc3/
         fIOnKY2IMoG6ydFdJa/lLRZni+7Ia1SuqwikyDJQ+ho6bL15FNtIQqpZEiraS8Y9aXmH
         QnB/i9RM8LsgpNjWxA/cxtYOurFzuZ6mlgQkZPtdwpv1dCh+lNCq0WE1FMg+oMQv5+S+
         V91B+tUv+UHt2mBCDQkh0/gTKMhdSxwk5qouyLwbCNuSNL+sDkFVj4bZu6Tmm/tJD6HO
         EeO9s6xeSZuyLFtHtLHoDmTmvFdjZd/FfdJbO7dy3bPyoo+wNjcLllvAC2Aykp6Yv/eB
         8e/w==
X-Gm-Message-State: AOJu0Yw9akYxUZssu7cJ0Kes9B1WlzzDoNotnzlNmcXdDrRzuyh0kjqq
	/dh2tjmy0PcgldaTiu00Oz2C1LbaOV26BYrqsPdTsordpbolcYI3ur4Y4tBJq6J3M9PXaTxojA3
	ybcMLDlzFkJ+ULCWLzhZE333R1vPfy7WGE1FozeT5ZUKf9Xcm/yPInw==
X-Gm-Gg: ASbGncuNBMf7p/LURXko6dg85aR3wNBP3LoNIDoSGIs4GMCvqUR5cKQBktH0V3ThDOI
	qjubYVhzWhO9UmGUQw8d8oXe0HRFnd+e7Vj4845G1q4vnqHJDU4S2/soKaV3vxGcdkMNHEBpwRb
	P//bUdsMURAz+neowTQ+DJdBVj8hYqmJq9qKkxjLOeECaCRYxvi4KkxlY4GgE+AIFGo8ixcLJjl
	BdetsOJFnQhc3rxmbBC8BxE4x38FNE7HTJiKb0ROZjNJss0zjoHV6WhUg8QB5ydGDYZma/6aW44
	bWA9VQrEhdOI
X-Received: by 2002:a2e:740a:0:b0:30b:eb08:53e3 with SMTP id 38308e7fff4ca-30c4a8743d9mr64207601fa.17.1742224605623;
        Mon, 17 Mar 2025 08:16:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSi8cQyOlG/W3LR4YI+3jPWVFa3/mQXBuzJDNH22ZWPZDVglcHs63ffS5X17IwRGbk4plwDg==
X-Received: by 2002:a2e:740a:0:b0:30b:eb08:53e3 with SMTP id 38308e7fff4ca-30c4a8743d9mr64207081fa.17.1742224605112;
        Mon, 17 Mar 2025 08:16:45 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f116a4asm15789761fa.58.2025.03.17.08.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 08:16:44 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id DBB6318FAED8; Mon, 17 Mar 2025 16:16:42 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <yunshenglin0825@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Mina Almasry <almasrymina@google.com>,
 Yonglong Liu <liuyonglong@huawei.com>, Yunsheng Lin
 <linyunsheng@huawei.com>, Pavel Begunkov <asml.silence@gmail.com>, Matthew
 Wilcox <willy@infradead.org>, Robin Murphy <robin.murphy@arm.com>, IOMMU
 <iommu@lists.linux.dev>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>, Yuying Ma
 <yuma@redhat.com>
Subject: Re: [PATCH net-next 3/3] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <db813035-fb38-4fc3-b91e-d1416959db13@gmail.com>
References: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com>
 <20250314-page-pool-track-dma-v1-3-c212e57a74c2@redhat.com>
 <db813035-fb38-4fc3-b91e-d1416959db13@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 17 Mar 2025 16:16:42 +0100
Message-ID: <87jz8nhelh.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yunsheng Lin <yunshenglin0825@gmail.com> writes:

> On 3/14/2025 6:10 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>
> ...
>
>>=20
>> To avoid having to walk the entire xarray on unmap to find the page
>> reference, we stash the ID assigned by xa_alloc() into the page
>> structure itself, using the upper bits of the pp_magic field. This
>> requires a couple of defines to avoid conflicting with the
>> POINTER_POISON_DELTA define, but this is all evaluated at compile-time,
>> so does not affect run-time performance. The bitmap calculations in this
>> patch gives the following number of bits for different architectures:
>>=20
>> - 24 bits on 32-bit architectures
>> - 21 bits on PPC64 (because of the definition of ILLEGAL_POINTER_VALUE)
>> - 32 bits on other 64-bit architectures
>
>  From commit c07aea3ef4d4 ("mm: add a signature in struct page"):
> "The page->signature field is aliased to page->lru.next and
> page->compound_head, but it can't be set by mistake because the
> signature value is a bad pointer, and can't trigger a false positive
> in PageTail() because the last bit is 0."
>
> And commit 8a5e5e02fc83 ("include/linux/poison.h: fix LIST_POISON{1,2}=20
> offset"):
> "Poison pointer values should be small enough to find a room in
> non-mmap'able/hardly-mmap'able space."
>
> So the question seems to be:
> 1. Is stashing the ID causing page->pp_magic to be in the mmap'able/
>     easier-mmap'able space? If yes, how can we make sure this will not
>     cause any security problem?
> 2. Is the masking the page->pp_magic causing a valid pionter for
>     page->lru.next or page->compound_head to be treated as a vaild
>     PP_SIGNATURE? which might cause page_pool to recycle a page not
>     allocated via page_pool.

Right, so my reasoning for why the defines in this patch works for this
is as follows: in both cases we need to make sure that the ID stashed in
that field never looks like a valid kernel pointer. For 64-bit arches
(where CONFIG_ILLEGAL_POINTER_VALUE), we make sure of this by never
writing to any bits that overlap with the illegal value (so that the
PP_SIGNATURE written to the field keeps it as an illegal pointer value).
For 32-bit arches, we make sure of this by making sure the top-most bit
is always 0 (the -1 in the define for _PP_DMA_INDEX_BITS) in the patch,
which puts it outside the range used for kernel pointers (AFAICT).

>> Since all the tracking is performed on DMA map/unmap, no additional code
>> is needed in the fast path, meaning the performance overhead of this
>> tracking is negligible. A micro-benchmark shows that the total overhead
>> of using xarray for this purpose is about 400 ns (39 cycles(tsc) 395.218
>> ns; sum for both map and unmap[1]). Since this cost is only paid on DMA
>> map and unmap, it seems like an acceptable cost to fix the late unmap
>
> For most use cases when PP_FLAG_DMA_MAP is set and IOMMU is off, the
> DMA map and unmap operation is almost negligible as said below, so the
> cost is about 200% performance degradation, which doesn't seems like an
> acceptable cost.

I disagree. This only impacts the slow path, as long as pages are
recycled there is no additional cost. While your patch series has
demonstrated that it is *possible* to reduce the cost even in the slow
path, I don't think the complexity cost of this is worth it.

[...]

>> The extra memory needed to track the pages is neatly encapsulated inside
>> xarray, which uses the 'struct xa_node' structure to track items. This
>> structure is 576 bytes long, with slots for 64 items, meaning that a
>> full node occurs only 9 bytes of overhead per slot it tracks (in
>> practice, it probably won't be this efficient, but in any case it should
>
> Is there any debug infrastructure to know if it is not this efficient?
> as there may be 576 byte overhead for a page for the worst case.

There's an XA_DEBUG define which enables some dump functions, but I
don't think there's any API to inspect the memory usage. I guess you
could attach a BPF program and walk the structure, or something?

>> +			/* Make sure all concurrent returns that may see the old
>> +			 * value of dma_sync (and thus perform a sync) have
>> +			 * finished before doing the unmapping below. Skip the
>> +			 * wait if the device doesn't actually need syncing, or
>> +			 * if there are no outstanding mapped pages.
>> +			 */
>> +			if (dma_dev_need_sync(pool->p.dev) &&
>> +			    !xa_empty(&pool->dma_mapped))
>> +				synchronize_net();
>
> I guess the above synchronize_net() is assuming that the above dma sync
> API is always called in the softirq context, as it seems there is no
> rcu read lock added in this patch to be paired with that.

Yup, that was my assumption.

> Doesn't page_pool_put_page() might be called in non-softirq context when
> allow_direct is false and in_softirq() returns false?

I am not sure if this happens in practice in any of the delayed return
paths we are worried about for this patch. If it does we could apply
something like the diff below (on top of this patch). I can respin with
this if needed, but I'll wait a bit and give others a chance to chime in.

-Toke



@@ -465,9 +465,13 @@ page_pool_dma_sync_for_device(const struct page_pool *=
pool,
 			      netmem_ref netmem,
 			      u32 dma_sync_size)
 {
-	if ((READ_ONCE(pool->dma_sync) & PP_DMA_SYNC_DEV) &&
-	    dma_dev_need_sync(pool->p.dev))
-		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
+	if (dma_dev_need_sync(pool->p.dev)) {
+		rcu_read_lock();
+		if (READ_ONCE(pool->dma_sync) & PP_DMA_SYNC_DEV)
+			__page_pool_dma_sync_for_device(pool, netmem,
+							dma_sync_size);
+		rcu_read_unlock();
+	}
 }
=20
 static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem, g=
fp_t gfp)


