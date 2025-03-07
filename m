Return-Path: <netdev+bounces-172954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5C8A56A1B
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 15:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9757017655A
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 14:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B271F21B199;
	Fri,  7 Mar 2025 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfnaHWqT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ACA1A8F68
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356931; cv=none; b=ftoGWx6D47H11t3FpGc49iWYwkEVYFtLdD9R0XuO0sudNPakQBHg3sWvKCpL6rPQuwzXG+LqKcj/f5hd1ONo8SGWO4XccabI8DPbjBYDQgbtLJbbDC2EUGyWaGF9cC/5sSK5lXziz52HpRP9hUHAd0x3A2/CiQgcrowAKBe3CrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356931; c=relaxed/simple;
	bh=ORlXqKH59TAvqyZ696RW4rdKfXnYfX3Dj6nxXbH2qsY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qkqI5jSXBhr4AcjcOrsAnW1rWmznueNyEYLidRccC1hd9TvJBMLVBvwtQ8qI3MTjte47/pASwpfSdRCGrBjwuEztgR4/pJHEUGrHPwYDmYH8MtUkzP3Jxni60hkfzB4id6Naxd10cFJLNOss1ygrywPqo86PnASe8ZSvxc+0qtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cfnaHWqT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741356928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3O3AnmpQI3jBSfzVaFR0gisRYPo1AftdSa2GSlKHZsw=;
	b=cfnaHWqTYy/EwlluAIJkTzfOyvI3cxT9/zynGveLQJGUofxU0lmNzsasATVtFllCB45uVc
	nfLatL3fCRG6wW+HbfrdvphwD4Sq90Q5Ts0FRXQlOr4crE23URb1xmkooUXNQROQLJ5yZ8
	36Wtj6FIMk6zPud0cM4jC6p+3HLzqsY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-XzQUT2XdMtu83AuHjHAChA-1; Fri, 07 Mar 2025 09:15:27 -0500
X-MC-Unique: XzQUT2XdMtu83AuHjHAChA-1
X-Mimecast-MFC-AGG-ID: XzQUT2XdMtu83AuHjHAChA_1741356926
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5493a71ae78so1240070e87.0
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 06:15:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741356926; x=1741961726;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3O3AnmpQI3jBSfzVaFR0gisRYPo1AftdSa2GSlKHZsw=;
        b=gixwz1q3n8x+Pxm4Yc81jBAqmBCRcgmdDDY3DnK1521ubac4c75Hw+7G21apuII1PT
         pjk/HksQak2wtQVWSSNj7Hs6GDxGxsI6+/uazreQfecrsDcY8N6WglTuKr1eQS0T0t68
         38tT8ussie9igIDwIVNCQnEcpXM3tZJRwOT17oaIgL9ZS9pKJ4OHYcWgNNFe3VBau5pL
         zyjxkoGKQQ/mu5dXUTYOOnIx0lCrBgG1qfFg+bNkco8b0YdWAQw2FXCFPY0qn/VTrsjv
         fUUlV39ZTZNMx2y5ZYSeE0CyAhrG96WYYEhFsv/KYNlAAY3Yt7mfpnyM7k7EBIWJfhCd
         EgQg==
X-Forwarded-Encrypted: i=1; AJvYcCXeH8pMmysU9HJSi4kBBxCanoEl0iOyNmis+yqGUagNbOpT0754Hqm/BNF50POaITNx5FEIf/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzofWj1I27l7Q8SGZtdQIjslm5/vDdZP11qAHOjlMIP9tcIOzmt
	Uvcadby6X87tun2kalNEhhTdLkS3SQByxLv90Iq3Nq8+tpljZKPUa1Kl5FQ6NuW+FVN5nC+3Id4
	16sWKVqzWL8f204KZI+8uK6Z49qTv2BJ9bOKU3oGwruj1Ehuko8GcSA==
X-Gm-Gg: ASbGncutF3AYeQp0zwfhjavAKhfztnLGhUNmqMAdNBcOkjOrdD1xDHqo4eqGEbLNLnE
	BlbksWNBjzw5wfcN0B5xRx0642j2KzagH5KifuVdCuUmIjBm28Nl/yU+D3zxB4IZjt7eBvRKp1R
	1pd93N9GzV/hZPI1ZK94h5JxrNccb45/bBSrg5JoXIpKGsJ7WGroHr3ekcmapwMI7dCv1fWiGIo
	xiOq7zbWorbb5ksIHYtsWTh9W4PeNrmFtLgFrfdxOZjivANG4HyY+xaXZsnlvaHZjLnE2VagcMU
	nZh2u2R2IrvK
X-Received: by 2002:a05:6512:3e08:b0:549:8c0c:f059 with SMTP id 2adb3069b0e04-549903f7501mr1328607e87.10.1741356925932;
        Fri, 07 Mar 2025 06:15:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3xCZIBKOSDK+lcZFrDyk8zQiKyadlLEz2VUX4gZrVM2Ry982AQyl3kHsVBYxqC5TNxfqK0A==
X-Received: by 2002:a05:6512:3e08:b0:549:8c0c:f059 with SMTP id 2adb3069b0e04-549903f7501mr1328584e87.10.1741356925465;
        Fri, 07 Mar 2025 06:15:25 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae58e4fsm500345e87.82.2025.03.07.06.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 06:15:24 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C544C18B8B34; Fri, 07 Mar 2025 15:15:22 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
Cc: zhangkun09@huawei.com, liuyonglong@huawei.com, fanghaiqing@huawei.com,
 Yunsheng Lin <linyunsheng@huawei.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Gaurav Batra <gbatra@linux.ibm.com>, Matthew
 Rosato <mjrosato@linux.ibm.com>, IOMMU <iommu@lists.linux.dev>, MM
 <linux-mm@kvack.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v11 0/4] fix the DMA API misuse problem for
 page_pool
In-Reply-To: <20250307092356.638242-1-linyunsheng@huawei.com>
References: <20250307092356.638242-1-linyunsheng@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 07 Mar 2025 15:15:22 +0100
Message-ID: <87v7slvsed.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yunsheng Lin <linyunsheng@huawei.com> writes:

> This patchset fix the dma API misuse problem as below:
> Networking driver with page_pool support may hand over page
> still with dma mapping to network stack and try to reuse that
> page after network stack is done with it and passes it back
> to page_pool to avoid the penalty of dma mapping/unmapping.
> With all the caching in the network stack, some pages may be
> held in the network stack without returning to the page_pool
> soon enough, and with VF disable causing the driver unbound,
> the page_pool does not stop the driver from doing it's
> unbounding work, instead page_pool uses workqueue to check
> if there is some pages coming back from the network stack
> periodically, if there is any, it will do the dma unmmapping
> related cleanup work.
>
> As mentioned in [1], attempting DMA unmaps after the driver
> has already unbound may leak resources or at worst corrupt
> memory. Fundamentally, the page pool code cannot allow DMA
> mappings to outlive the driver they belong to.
>
> By using the 'struct page_pool_item' referenced by page->pp_item,
> page_pool is not only able to keep track of the inflight page to
> do dma unmmaping if some pages are still handled in networking
> stack when page_pool_destroy() is called, and networking stack is
> also able to find the page_pool owning the page when returning
> pages back into page_pool:
> 1. When a page is added to the page_pool, an item is deleted from
>    pool->hold_items and set the 'pp_netmem' pointing to that page
>    and set item->state and item->pp_netmem accordingly in order to
>    keep track of that page, refill from pool->release_items when
>    pool->hold_items is empty or use the item from pool->slow_items
>    when fast items run out.
> 2. When a page is released from the page_pool, it is able to tell
>    which page_pool this page belongs to by masking off the lower
>    bits of the pointer to page_pool_item *item, as the 'struct
>    page_pool_item_block' is stored in the top of a struct page.
>    And after clearing the pp_item->state', the item for the
>    released page is added back to pool->release_items so that it
>    can be reused for new pages or just free it when it is from the
>    pool->slow_items.
> 3. When page_pool_destroy() is called, item->state is used to tell
>    if a specific item is being used/dma mapped or not by scanning
>    all the item blocks in pool->item_blocks, then item->netmem can
>    be used to do the dma unmmaping if the corresponding inflight
>    page is dma mapped.

You are making this incredibly complicated. You've basically implemented
a whole new slab allocator for those page_pool_item objects, and you're
tracking every page handed out by the page pool instead of just the ones
that are DMA-mapped. None of this is needed.

I took a stab at implementing the xarray-based tracking first suggested
by Mina[0]:

https://git.kernel.org/toke/c/e87e0edf9520

And, well, it's 50 lines of extra code, none of which are in the fast
path.

Jesper has kindly helped with testing that it works for normal packet
processing, but I haven't yet verified that it resolves the original
crash. Will post the patch to the list once I have verified this (help
welcome!).

-Toke

[0] https://lore.kernel.org/all/CAHS8izPg7B5DwKfSuzz-iOop_YRbk3Sd6Y4rX7KBG9DcVJcyWg@mail.gmail.com/


