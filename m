Return-Path: <netdev+bounces-130175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9686D988E2F
	for <lists+netdev@lfdr.de>; Sat, 28 Sep 2024 09:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6C211C210C5
	for <lists+netdev@lfdr.de>; Sat, 28 Sep 2024 07:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B936C19DF98;
	Sat, 28 Sep 2024 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rr4n3Frj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0804719B3C3
	for <netdev@vger.kernel.org>; Sat, 28 Sep 2024 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727508904; cv=none; b=EpXshhjni/C/nUFZ5wnEMxx6UeY5EMVhViWassXSakA5NNajwDpo8Bo4KWRXcdED8c5ezGPxHBeUuMDja5iTzM+BGaYPb7AGSN0/KUB7JsEns8x5hpXvq0QDk1dQA5aFq6B3nax7w0ANx2OLp57HYRqleZVUSYm/tTBYrNdrC5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727508904; c=relaxed/simple;
	bh=CZ3GJJVCrrzGvR7fAA0nSrjc16wiFeyBC54h9NaWyFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLddICI+n2N+1DFGcK3DVvT2JpRrSjDXXG3+JPMTcBj08RFUUSbfW5/IVgkYq3Gc0mYjqxCvo+9J8kBk7IB9stmxHXE1Kz1NebtW4v63d6YL/7dQA2WBwEyh8J/igA0FUtwUIXt592jcocu7JAxz4yP4x5cgHKX1B8MhIcW9ZFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rr4n3Frj; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-718e6299191so1583034b3a.2
        for <netdev@vger.kernel.org>; Sat, 28 Sep 2024 00:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727508902; x=1728113702; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CZ3GJJVCrrzGvR7fAA0nSrjc16wiFeyBC54h9NaWyFQ=;
        b=Rr4n3FrjBXa/YK0y+EroBjKWFgj+F/wBmowdytXw/fZ7YqbOsnLun6SCUPD2V22HkA
         e13BiWWLHYpXWxUCVcF6ETXMvl9X1MLDO1QX5K3z7ahxGUSxVPdHX3iOngO+PAUeoCen
         uMziTfSBcqyDd1eGLxUdTWRWb0SKgJDFpcYCBcnhjDpo4HwuYMRycLw3snncwvpWDHvA
         bwOifX3c8i/Txiwpx4ZJAZvtuaRUy1n36HF2GH874IT4XVD15diQ3OThrX9HIOVMICuP
         uOdXhpAxbOsj3qKp7zSij1AGAWqRrqIUNtICimQlSwazMmDeH1lymoZcPcs4Xzt16Y3J
         Dtvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727508902; x=1728113702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZ3GJJVCrrzGvR7fAA0nSrjc16wiFeyBC54h9NaWyFQ=;
        b=k9fx2npegKXCjWpHWu24S9X/CZvfpbUVai2jQAwvTXzh4ZjwHbl4Z1hN2qZfE435+8
         Iav1aUUzeBb/UbcQpQVbAdsAgdXvjtSWha3rF8QnFzLMY7jKJaElc/rVJoIrx/xqGIlG
         3VDJnZlI0ObOk7joUkpsZH4zE0cmNqx7eUjZalFwMVAG40HyHNft3Fc704rM04/tHkqy
         vr+i3c63KCPGvOabU8f9H6fF0og2eMgdtk4Lq4fzzo/d5lj+fM9J1YtZXbSjduoB33XL
         LJ2Sgj5urCC2KYxZ2QdsIDpxyVnHvBbczQ+gpLq0FGT8/R0+XhvYOhXg1l3UHbQua8us
         3dUg==
X-Forwarded-Encrypted: i=1; AJvYcCV0fm7VZGXTfvbgtuxHrDg6D0uGAGUEcVvuCw5nN06fpPFaaN8/KWu5X3TO84MO7b7JqVSy1rE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIJmIQDy4mPzB8nk3Wz1iJilSMEYIXGSIvCrW6fn9nQP3migY0
	JUnkaL2fj2UoVvKGt4rFqXstFMzVuLTkr0bVKot1rvNVLy+AVdlScaOBiYrt3EdeFV7Z0NMtaoR
	COwZuSVIuN05L+2OmcCVZPfYnrrpMM8fwgTeEoA==
X-Google-Smtp-Source: AGHT+IE8STUqnUdbp16wn+jWytnLJo7GbATydnL1PXc5q5xA5jCeVCG+33+GkdczeH+HdjoM/t8GaXFW5O+RCkxcmVg=
X-Received: by 2002:a05:6a00:8c2:b0:714:2482:ab3c with SMTP id
 d2e1a72fcca58-71b25f40b4cmr9950991b3a.7.1727508902091; Sat, 28 Sep 2024
 00:35:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925075707.3970187-1-linyunsheng@huawei.com>
 <20240925075707.3970187-3-linyunsheng@huawei.com> <CAHS8izOxugzWJDTc-4CWqaKABTj=J4OHs=Lcb=SE9r8gX0J+yg@mail.gmail.com>
 <842c8cc6-f716-437a-bc98-70bc26d6fd38@huawei.com> <CAC_iWjLgNOtsbhqrhvvEz2C3S668qB8KatL_W+tPHMSkDrNS=w@mail.gmail.com>
 <0ef315df-e8e9-41e8-9ba8-dcb69492c616@huawei.com> <CAC_iWjKeajwn3otjdEekE6VDLHGEvqmnQRwpN5R3yHj8UpEiDw@mail.gmail.com>
 <934d601f-be43-4e04-b126-dc86890a4bfa@huawei.com>
In-Reply-To: <934d601f-be43-4e04-b126-dc86890a4bfa@huawei.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 28 Sep 2024 10:34:25 +0300
Message-ID: <CAC_iWjL7m4ZL2W2OZM5F22dLvZhxU6fyCXV_xjyGf+W7UP43EQ@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] page_pool: fix IOMMU crash when driver has
 already unbound
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Mina Almasry <almasrymina@google.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, liuyonglong@huawei.com, fanghaiqing@huawei.com, 
	zhangkun09@huawei.com, Robin Murphy <robin.murphy@arm.com>, 
	Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, 
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, Eric Dumazet <edumazet@google.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Andrew Morton <akpm@linux-foundation.org>, imx@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Hi Yunsheng,

Overall this is a patch in the right direction. I want to get feedback
from others since Jakub and Jesper seemed to prefer the stalling idea.

On Fri, 27 Sept 2024 at 14:29, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> On 2024/9/27 17:58, Ilias Apalodimas wrote:
>
> ...
>
> >>
> >>> importantly, though, why does struct page need to know about this?
> >>> Can't we have the same information in page pool?
> >>> When the driver allocates pages it does via page_pool_dev_alloc_XXXXX
> >>> or something similar. Cant we do what you suggest here ? IOW when we
> >>> allocate a page we put it in a list, and when that page returns to
> >>> page_pool (and it's mapped) we remove it.
> >>
> >> Yes, that is the basic idea, but the important part is how to do that
> >> with less performance impact.
> >
> > Yes, but do you think that keeping that list of allocated pages in
> > struct page_pool will end up being more costly somehow compared to
> > struct page?
>
> I am not sure if I understand your above question here.
> I am supposing the question is about what's the cost between using
> single/doubly linked list for the inflight pages or using a array
> for the inflight pages like this patch does using pool->items?

Yes, that wasn't very clear indeed, apologies for any confusion. I was
trying to ask on a linked list that only lives in struct page_pool.
But I now realize this was a bad idea since the lookup would be way
slower.

> If I understand question correctly, the single/doubly linked list
> is more costly than array as the page_pool case as my understanding.
>
> For single linked list, it doesn't allow deleting a specific entry but
> only support deleting the first entry and all the entries. It does support
> lockless operation using llist, but have limitation as below:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/include/linux/llist.h#L13
>
> For doubly linked list, it needs two pointer to support deleting a specific
> entry and it does not support lockless operation.

I didn't look at the patch too carefully at first. Looking a bit
closer now, the array is indeed better, since the lookup is faster.
You just need the stored index in struct page to find the page we need
to unmap. Do you remember if we can reduce the atomic pp_ref_count to
32bits? If so we can reuse that space for the index. Looking at it
requires a bit more work in netmem, but that's mostly swapping all the
atomic64 calls to atomic ones.

>
> For pool->items, as the alloc side is protected by NAPI context, and the
> free side use item->pp_idx to ensure there is only one producer for each
> item, which means for each item in pool->items, there is only one consumer
> and one producer, which seems much like the case when the page is not
> recyclable in __page_pool_put_page, we don't need a lock protection when
> calling page_pool_return_page(), the 'struct page' is also one consumer
> and one producer as the pool->items[item->pp_idx] does:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/net/core/page_pool.c#L645
>
> We only need a lock protection when page_pool_destroy() is called to
> check if there is inflight page to be unmapped as a consumer, and the
> __page_pool_put_page() may also called to unmapped the inflight page as
> another consumer,

Thanks for the explanation. On the locking side, page_pool_destroy is
called once from the driver and then it's either the workqueue for
inflight packets or an SKB that got freed and tried to recycle right?
But do we still need to do all the unmapping etc from the delayed
work? Since the new function will unmap all packets in
page_pool_destroy, we can just skip unmapping when the delayed work
runs

Thanks
/Ilias





> there is why the 'destroy_lock' is added for protection
> when pool->destroy_cnt > 0.
>
> >
> > Thanks
> > /Ilias

