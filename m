Return-Path: <netdev+bounces-99333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6419A8D4853
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 11:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180DC1F2223E
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 09:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4115157E98;
	Thu, 30 May 2024 09:21:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D8914B084;
	Thu, 30 May 2024 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717060916; cv=none; b=KWDzdVpdjNzxhiS18C8fZwWa+il0s7xYkE7C7Yxg4vfVIjXmmgUOOcFq7k5z/0GpDu80kkkq8rEC3ZaPY/EnGA4Y4qqRmL+uRJTY7EY5vrXTTbt4b5ekQBoNThDwbNItyY8OYd5MY6v7W5pHN2bxf8wFErqEf0I+0CLPgTcuuUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717060916; c=relaxed/simple;
	bh=psGWNJRYqjINEBH134RHwYSmwoGU/QPKPJFc4GGeHgI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=c+fHpI50z9vgO4FFEa4PBLr1hz/KffCYymsyuGaQYzzYha4sl26L3TOMcZHOqjLl8fPiURg5cXH2MCAvf0v5zvrHFkIO5UoN1fOD8DWyyvgoOZA2J9xpxyn3D61Fk5NdWqSiyCGIGcxccLfWhKXReaLlwHodp8AhBAIEIimsDlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Vqgcx5YB5zmX11;
	Thu, 30 May 2024 17:17:21 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id C675318007F;
	Thu, 30 May 2024 17:21:45 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 30 May
 2024 17:21:45 +0800
Subject: Re: [PATCH net-next v5 10/13] mm: page_frag: introduce
 prepare/probe/commit API
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Alexander Duyck
	<alexander.duyck@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>
References: <20240528125604.63048-1-linyunsheng@huawei.com>
 <20240528125604.63048-11-linyunsheng@huawei.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <ea2be92c-88cc-79fe-f21f-9c80f2b02ca0@huawei.com>
Date: Thu, 30 May 2024 17:21:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240528125604.63048-11-linyunsheng@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/5/28 20:56, Yunsheng Lin wrote:

> +#define page_frag_alloc_probe(nc, offset, fragsz, va)			\
> +({									\
> +	struct page *__page = NULL;					\
> +									\
> +	VM_BUG_ON(!*(fragsz));						\

The above above marco seems to need to include mmdebug.h explicitly
to avoid compile error for x86 system.


> +	if (likely((nc)->remaining >= *(fragsz)))			\
> +		__page = virt_to_page(__page_frag_alloc_probe(nc,	\
> +							      offset,	\
> +							      fragsz,	\
> +							      va));	\
> +									\
> +	__page;								\
> +})


