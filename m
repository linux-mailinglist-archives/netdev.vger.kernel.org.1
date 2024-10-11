Return-Path: <netdev+bounces-134568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E7B99A2DD
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 13:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CAA31F218FE
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 11:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE9E21643B;
	Fri, 11 Oct 2024 11:40:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDBF216432;
	Fri, 11 Oct 2024 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728646814; cv=none; b=P1ufVhOGQ7Zjmfvy9C3bz5RaRUJ/+++OeW4lWzQp+ONZNuWDEhtzvZPdYDZkLbf/rYVOJiSFVaphRLMP7TgsXj6Jy3x844QZwux0BI99/4HbwOCB+w1wMphbJHnkZbHZlSRTvOxdfG5tDPoryEuAkbppaezu4TqwXA9OtdBjjgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728646814; c=relaxed/simple;
	bh=s8/2U9op63i3oPecT4Ua5VDipHkA8uDY3cJ4C4yXsIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LkqagL9Ma3t6FyxGwcI6DMqjjnu0JXicU7mWjKzi5IA9nj/VeOeIS9DLkkrUV+VpphyN9mxzXaEPREbhldThSHnlidtRhfXZ1q23eam8+Tq9JKvkqBvodlakQ1q4SRN2G+f4sCgvjfGmpnxCwX8793cpLen+gslcP8uqhsus+9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XQ4R63z3JzCtBj;
	Fri, 11 Oct 2024 19:39:30 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 863AD1400D8;
	Fri, 11 Oct 2024 19:40:09 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 11 Oct 2024 19:40:09 +0800
Message-ID: <7c4b8aae-dcbd-4d45-b7b0-82609cf8a442@huawei.com>
Date: Fri, 11 Oct 2024 19:40:09 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 06/14] mm: page_frag: reuse existing space
 for 'size' and 'pfmemalloc'
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20241008112049.2279307-1-linyunsheng@huawei.com>
 <20241008112049.2279307-7-linyunsheng@huawei.com>
 <CAKgT0UdgoyE0BzZoyXzxWYtAakJGWKORSZ25LbO1-=Q_Stiq9w@mail.gmail.com>
 <8bc47d27-b8ea-4573-937a-0056bdd8ea2c@huawei.com>
 <CAKgT0Uf0g9_P6fUBzueZ-rwq1RCu5TjruZGT+kXjsQi-=jqStQ@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0Uf0g9_P6fUBzueZ-rwq1RCu5TjruZGT+kXjsQi-=jqStQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/10 22:33, Alexander Duyck wrote:

...

> 
> For the decodes yes. I was referring to page_frag_encode_page.
> Basically the output from that isn't anything page frag, it is your
> encoded page type so you could probably just call it
> encoded_page_encode, or encoded_page_create or something like that.

It is kind of confusing as there is some mix of encode/encoded/decode
here, but let's be more specific if it is something like below:

static unsigned long encoded_page_create(struct page *page, unsigned int order,
					 bool pfmemalloc)
{
	BUILD_BUG_ON(PAGE_FRAG_CACHE_MAX_ORDER > PAGE_FRAG_CACHE_ORDER_MASK);
	BUILD_BUG_ON(PAGE_FRAG_CACHE_PFMEMALLOC_BIT >= PAGE_SIZE);

	return (unsigned long)page_address(page) |
		(order & PAGE_FRAG_CACHE_ORDER_MASK) |
		((unsigned long)pfmemalloc * PAGE_FRAG_CACHE_PFMEMALLOC_BIT);
}

static inline bool encoded_page_decode_pfmemalloc(unsigned long encoded_page)
{
	return !!(encoded_page & PAGE_FRAG_CACHE_PFMEMALLOC_BIT);
}

static unsigned long encoded_page_decode_order(unsigned long encoded_page)
{
	return encoded_page & PAGE_FRAG_CACHE_ORDER_MASK;
}

static void *encoded_page_decode_virt(unsigned long encoded_page)
{
	return (void *)(encoded_page & PAGE_MASK);
}

static struct page *encoded_page_decode_page(unsigned long encoded_page)
{
	return virt_to_page((void *)encoded_page);
}

