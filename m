Return-Path: <netdev+bounces-118699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 929CD952828
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 05:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E601286F94
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 03:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9ED2231C;
	Thu, 15 Aug 2024 03:10:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EC62C182;
	Thu, 15 Aug 2024 03:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723691455; cv=none; b=cE8Sb23uFZ6Qd6yayFsefBOyLF3nNyqBuDS5BRg/gCUdfx25HZas2SxGH8YbR1hCcDdodbbu0kxzQ7evuYfv6tX3/H8QCv3uPcG8+1Kc07yjDVi1Isp6Xa+m7/je1JJgQgdiwzyNkD1KDNcThSoIBS5wLRE2HUjTemvrq6sUimE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723691455; c=relaxed/simple;
	bh=tK+nz4AIb/ZASImI4NIaDpVVASdlmoPWEZXYhi1XNJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LMYRRBXI21YLJo5sjXHuzaR8h3eG+N7cJb7kFXbfK5cJvTLSbZyyHXrhao9M0SXSsc3EMXI3oQggyM8UlP+9ktvV66sODORsCGLVccdKZg33E0RO9pZLwM0PgLSZQ1jg8GaD6j2uMKkDnfdL6wC8tmgJg9oF5qT+fHQAO0E8XBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wkqks15GZz2CmNF;
	Thu, 15 Aug 2024 11:05:57 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D10814040F;
	Thu, 15 Aug 2024 11:10:50 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 15 Aug 2024 11:10:49 +0800
Message-ID: <a036abc3-76a0-450c-afea-2db3c10f0ed5@huawei.com>
Date: Thu, 15 Aug 2024 11:10:49 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 07/14] mm: page_frag: reuse existing space
 for 'size' and 'pfmemalloc'
To: Alexander H Duyck <alexander.duyck@gmail.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240808123714.462740-1-linyunsheng@huawei.com>
 <20240808123714.462740-8-linyunsheng@huawei.com>
 <0002cde37fcead62813006ab9516c5b2fdbf113a.camel@gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <0002cde37fcead62813006ab9516c5b2fdbf113a.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/8/15 0:13, Alexander H Duyck wrote:
> On Thu, 2024-08-08 at 20:37 +0800, Yunsheng Lin wrote:
>> Currently there is one 'struct page_frag' for every 'struct
>> sock' and 'struct task_struct', we are about to replace the
>> 'struct page_frag' with 'struct page_frag_cache' for them.
>> Before begin the replacing, we need to ensure the size of
>> 'struct page_frag_cache' is not bigger than the size of
>> 'struct page_frag', as there may be tens of thousands of
>> 'struct sock' and 'struct task_struct' instances in the
>> system.
>>
>> By or'ing the page order & pfmemalloc with lower bits of
>> 'va' instead of using 'u16' or 'u32' for page size and 'u8'
>> for pfmemalloc, we are able to avoid 3 or 5 bytes space waste.
>> And page address & pfmemalloc & order is unchanged for the
>> same page in the same 'page_frag_cache' instance, it makes
>> sense to fit them together.
>>
>> After this patch, the size of 'struct page_frag_cache' should be
>> the same as the size of 'struct page_frag'.
>>
>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> ---
>>  include/linux/mm_types_task.h   | 16 +++++-----
>>  include/linux/page_frag_cache.h | 52 +++++++++++++++++++++++++++++++--
>>  mm/page_frag_cache.c            | 49 +++++++++++++++++--------------
>>  3 files changed, 85 insertions(+), 32 deletions(-)
>>
>> diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
>> index b1c54b2b9308..f2610112a642 100644
>> --- a/include/linux/mm_types_task.h
>> +++ b/include/linux/mm_types_task.h
>> @@ -50,18 +50,18 @@ struct page_frag {
>>  #define PAGE_FRAG_CACHE_MAX_SIZE	__ALIGN_MASK(32768, ~PAGE_MASK)
>>  #define PAGE_FRAG_CACHE_MAX_ORDER	get_order(PAGE_FRAG_CACHE_MAX_SIZE)
>>  struct page_frag_cache {
>> -	void *va;
>> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>> +	/* encoded_va consists of the virtual address, pfmemalloc bit and order
>> +	 * of a page.
>> +	 */
>> +	unsigned long encoded_va;
>> +
> 
> Rather than calling this an "encoded_va" we might want to call this an
> "encoded_page" as that would be closer to what we are actually working
> with. We are just using the virtual address as the page pointer instead
> of the page struct itself since we need quicker access to the virtual
> address than we do the page struct.

Calling it "encoded_page" seems confusing enough when calling virt_to_page()
with "encoded_page" when virt_to_page() is expecting a 'va', no?

> 


