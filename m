Return-Path: <netdev+bounces-111746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 170A89326FD
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 14:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F6B8B2138D
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 12:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DD119AD46;
	Tue, 16 Jul 2024 12:58:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC74197A7D;
	Tue, 16 Jul 2024 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721134692; cv=none; b=qT5+AqoU6NKa6YQN2OZdLAocQ5HBl8lSVcOhe7TxYwCHve0meLR1lVl8hheCwkg5ZMptmfurNcGM0/sIcvhMmynvGaQ+Sf44Zg30eaBlNSdIKj+WamGULRzT1tGxLuI8a3F8CJRGplayBut9HH4hvNTzQjqF1zpQh8iIblZP9kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721134692; c=relaxed/simple;
	bh=kz0CicEUTeN4A8dfwF0ec3vvlKnAWa8ICTwjgHDQoiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SeLvSmvxNwiofynXZzWnby150La24MMcZXKp1qMTHYZ53MtibEILGPkm0r3SqJTYaPLLPQsbHfYBYanBeyg1PTG/5V6+XMPqqY0hV0qi7+PZsq1QnPXERn3wk05CA9rndR4BnkKsY0GjXberWy2AJsgPgv4mXAMBzP/Zmto1dis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WNfCB0gg4zQlZY;
	Tue, 16 Jul 2024 20:53:58 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 97B7F1403D1;
	Tue, 16 Jul 2024 20:58:00 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Jul 2024 20:58:00 +0800
Message-ID: <5a3b39b7-c183-4c73-bd9b-184db8b24f6a@huawei.com>
Date: Tue, 16 Jul 2024 20:58:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 06/13] mm: page_frag: reuse existing space for
 'size' and 'pfmemalloc'
To: Alexander Duyck <alexander.duyck@gmail.com>, Yunsheng Lin
	<yunshenglin0825@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240625135216.47007-1-linyunsheng@huawei.com>
 <20240625135216.47007-7-linyunsheng@huawei.com>
 <12a8b9ddbcb2da8431f77c5ec952ccfb2a77b7ec.camel@gmail.com>
 <808be796-6333-c116-6ecb-95a39f7ad76e@huawei.com>
 <a026c32218cabc7b6dc579ced1306aefd7029b10.camel@gmail.com>
 <f4ff5a42-9371-bc54-8523-b11d8511c39a@huawei.com>
 <96b04ebb7f46d73482d5f71213bd800c8195f00d.camel@gmail.com>
 <5daed410-063b-4d86-b544-d1a85bd86375@huawei.com>
 <CAKgT0UdJPcnfOJ=-1ZzXbiFiA=8a0z_oVBgQC-itKB1HWBU+yA@mail.gmail.com>
 <df38c0fb-64a9-48da-95d7-d6729cc6cf34@huawei.com>
 <CAKgT0UdSjmJoaQvTOz3STjBi2PazQ=piWY5wqFsYFBFLcPrLjQ@mail.gmail.com>
 <29e8ac53-f7da-4896-8121-2abc25ec2c95@gmail.com>
 <CAKgT0Udmr8q8V7x6ZqHQVxFbCnwB-6Ttybx_PP_3Xr9X-DgjKA@mail.gmail.com>
 <12ff13d9-1f3d-4c1b-a972-2efb6f247e31@gmail.com>
 <CAKgT0Uea-BrGRy-gfjdLWxp=0aQKQZa3dZW4euq5oGr1pTQVAA@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0Uea-BrGRy-gfjdLWxp=0aQKQZa3dZW4euq5oGr1pTQVAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/7/16 1:55, Alexander Duyck wrote:
> On Sat, Jul 13, 2024 at 9:52 PM Yunsheng Lin <yunshenglin0825@gmail.com> wrote:

...

>>
>> If the option 1 is not what you have in mind, it would be better to be
>> more specific about what you have in mind.
> 
> Option 1 was more or less what I had in mind.
> 
>> If the option 1 is what you have in mind, it seems both option 1 and
>> option 2 have the same semantics as my understanding, right? The
>> question here seems to be what is your perfer option and why?
>>
>> I implemented both of them, and the option 1 seems to have a
>> bigger generated asm size as below:
>> ./scripts/bloat-o-meter vmlinux_non_neg vmlinux
>> add/remove: 0/0 grow/shrink: 1/0 up/down: 37/0 (37)
>> Function                                     old     new   delta
>> __page_frag_alloc_va_align                   414     451     +37
> 
> My big complaint is that it seems option 2 is harder for people to
> understand and more likely to not be done correctly. In some cases if
> the performance difference is negligible it is better to go with the
> more maintainable solution.

Option 1 assuming nc->remaining as a negative value does not seems to
make it a more maintainable solution than option 2. How about something
like below if using a negative value to enable some optimization like LEA
does not have a noticeable performance difference?

struct page_frag_cache {
        /* encoded_va consists of the virtual address, pfmemalloc bit and order
         * of a page.
         */
        unsigned long encoded_va;

#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <= 32)
        __u16 remaining;
        __u16 pagecnt_bias;
#else
        __u32 remaining;
        __u32 pagecnt_bias;
#endif
};

void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
                                 unsigned int fragsz, gfp_t gfp_mask,
                                 unsigned int align_mask)
{
        unsigned int size = page_frag_cache_page_size(nc->encoded_va);
        unsigned int remaining;

        remaining = nc->remaining & align_mask;
        if (unlikely(remaining < fragsz)) {
                if (unlikely(fragsz > PAGE_SIZE)) {
                        /*
                         * The caller is trying to allocate a fragment
                         * with fragsz > PAGE_SIZE but the cache isn't big
                         * enough to satisfy the request, this may
                         * happen in low memory conditions.
                         * We don't release the cache page because
                         * it could make memory pressure worse
                         * so we simply return NULL here.
                         */
                        return NULL;
                }

                if (!__page_frag_cache_refill(nc, gfp_mask))
                        return NULL;

                size = page_frag_cache_page_size(nc->encoded_va);
                remaining = size;
        }

        nc->pagecnt_bias--;
        nc->remaining = remaining - fragsz;

        return encoded_page_address(nc->encoded_va) + (size - remaining);
}


