Return-Path: <netdev+bounces-139837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 832689B45D9
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 10:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B54F1F21AA2
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 09:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23351203708;
	Tue, 29 Oct 2024 09:40:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82CE7DA82;
	Tue, 29 Oct 2024 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730194805; cv=none; b=SjuVt11eFfzWIyV4/WRiez1IuG9+6mUW8z9kAJKCBgzKZYgMKRM2xm2AXnZpE8ne9OujJk4SprEEybaHHe5fLSEIirU9fkfc8RFlQuM1VRY2dsiG2deHFq//X7Q30Y91aBJG0wc+qf637vqiek4o2iDodKuNrlw5RW+69Dz5ZQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730194805; c=relaxed/simple;
	bh=64GcQ2hYxd29h7Z4cbBbpVIa+hnqlUlUrU7Xbn1LDzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=taKpYntMtHxiZo4djxDvBty4jb97EKkCJ1bCPjHoSS2atNnK8Ey4e56e26pcHg5++Oi44c+VMUaLPvWIOdM6O8KkaPZ7imVipeNriABDEfXUGKqUqOkplwm1CEU4nU743KYLn1ISHYfB/YNOB4z2qy48efKOecerX7j5Ovwewpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Xd4tg2wx9zpXb0;
	Tue, 29 Oct 2024 17:38:03 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 314DC180064;
	Tue, 29 Oct 2024 17:39:59 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Oct 2024 17:39:58 +0800
Message-ID: <f934af41-2902-429f-9b1b-2c469075fc23@huawei.com>
Date: Tue, 29 Oct 2024 17:39:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 04/10] mm: page_frag: introduce
 page_frag_alloc_abort() related API
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, Jonathan Corbet
	<corbet@lwn.net>, <linux-doc@vger.kernel.org>
References: <20241028115850.3409893-1-linyunsheng@huawei.com>
 <20241028115850.3409893-5-linyunsheng@huawei.com>
 <CAKgT0UfouCZpX04yzvCrB_UBmy47p+=xm5qViYowerR9dPcCbg@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0UfouCZpX04yzvCrB_UBmy47p+=xm5qViYowerR9dPcCbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/29 1:53, Alexander Duyck wrote:
> On Mon, Oct 28, 2024 at 5:05 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> For some case as tun_build_skb() without the needing of
>> using complicated prepare & commit API, add the abort API to
>> abort the operation of page_frag_alloc_*() related API for
>> error handling knowing that no one else is taking extra
>> reference to the just allocated fragment, and add abort_ref
>> API to only abort the reference counting of the allocated
>> fragment if it is already referenced by someone else.
>>

...

>> +
>> +/**
>> + * page_frag_alloc_abort_ref - Abort the reference of allocated fragment.
>> + * @nc: page_frag cache to which the page fragment is aborted back
>> + * @va: virtual address of page fragment to be aborted
>> + * @fragsz: size of the page fragment to be aborted
>> + *
>> + * It is expected to be called from the same context as the allocation API.
>> + * Mostly used for error handling cases to abort the reference of allocated
>> + * fragment if the fragment has been referenced for other usages, to aovid the
>> + * atomic operation of page_frag_free() API.
>> + */
>> +void page_frag_alloc_abort_ref(struct page_frag_cache *nc, void *va,
>> +                              unsigned int fragsz)
>> +{
>> +       VM_BUG_ON(va + fragsz !=
>> +                 encoded_page_decode_virt(nc->encoded_page) + nc->offset);
>> +
>> +       nc->pagecnt_bias++;
>> +}
>> +EXPORT_SYMBOL(page_frag_alloc_abort_ref);
> 
> It isn't clear to me why you split this over two functions. It seems
> like you could just update the offset in this lower function rather
> than do it in the upper one since you are passing all the arguments
> here anyway.

For the usecase in tun_build_skb(), There seems to be XDP_REDIRECT and
XDP_TX case that the allocated fragment has been referenced for other
usages even when xdp_do_redirect() or tun_xdp_tx() return error, so that
caller can call page_frag_alloc_abort_ref() to abort its reference
of the allocated fragment, but not abort the whole fragment for later
reuse.

As the doc mentioned above page_frag_alloc_abort_ref(), it is mainly to
avoid the atomic operation of page_frag_free() API when the caller has the
allocation context and has the all the arguments page_frag_alloc_abort_ref()
needs even though it might be a unlikely case if page_frag_alloc_abort() API
is already provided.

