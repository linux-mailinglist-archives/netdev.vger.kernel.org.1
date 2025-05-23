Return-Path: <netdev+bounces-192977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3046FAC1EB5
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 10:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F07A20C3F
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 08:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184EA22B8B5;
	Fri, 23 May 2025 08:31:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB58191F6D;
	Fri, 23 May 2025 08:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747989064; cv=none; b=Sx2VbjReZqaY7S6WZlCdM34+60OkHmDvuQPSHHCWE1I/IV8epfllwKwltdhbjj/3gl06T95EQmZQ2QOM/ibZoYGAcTFUmulZXFPImrg01YSV2v3wZS2pJ3N/H9GA2eJESBep+znQnNNiXvVLrfaqPpDtjoYISL8aqGmvSjehRFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747989064; c=relaxed/simple;
	bh=HwcHkeTFlphyZe8YNEznQsIXTAxDZK5JAJkX/iCE598=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g03Jmi4lddqxEZhOkHce0lWwherdfQfHB42pQGPbuH2YLuyG3B0JcpgiYY4pX9Oc+TDvyUJH2Kep+GszWmGrB5LoqE/i2SXoju0Qobt6D1Uqb7rbIf7vHYt0I/O23dRqKHIxjBL7Ik1j1In+HhF/uwO9l9S7mH+ot3dkLvzQd68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4b3dd71P1gz1f1f1;
	Fri, 23 May 2025 16:30:03 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id B9DCA1A0188;
	Fri, 23 May 2025 16:30:58 +0800 (CST)
Received: from [10.67.112.40] (10.67.112.40) by dggpemf200006.china.huawei.com
 (7.185.36.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 May
 2025 16:30:57 +0800
Message-ID: <a5cc7765-0de2-47ca-99c4-a48aaf6384d2@huawei.com>
Date: Fri, 23 May 2025 16:30:46 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] page_pool: Fix use-after-free in
 page_pool_recycle_in_ring
To: Dong Chenchen <dongchenchen2@huawei.com>, <hawk@kernel.org>,
	<ilias.apalodimas@linaro.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<almasrymina@google.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhangchangzhong@huawei.com>,
	<syzbot+204a4382fcb3311f3858@syzkaller.appspotmail.com>
References: <20250523064524.3035067-1-dongchenchen2@huawei.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20250523064524.3035067-1-dongchenchen2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/5/23 14:45, Dong Chenchen wrote:

>  
>  static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem)
>  {
> +	bool in_softirq;
>  	int ret;
int -> bool?

>  	/* BH protection not needed if current is softirq */
> -	if (in_softirq())
> -		ret = ptr_ring_produce(&pool->ring, (__force void *)netmem);
> -	else
> -		ret = ptr_ring_produce_bh(&pool->ring, (__force void *)netmem);
> -
> -	if (!ret) {
> +	in_softirq = page_pool_producer_lock(pool);
> +	ret = !__ptr_ring_produce(&pool->ring, (__force void *)netmem);
> +	if (ret)
>  		recycle_stat_inc(pool, ring);
> -		return true;
> -	}
> +	page_pool_producer_unlock(pool, in_softirq);
>  
> -	return false;
> +	return ret;
>  }
>  
>  /* Only allow direct recycling in special circumstances, into the
> @@ -1091,10 +1088,14 @@ static void page_pool_scrub(struct page_pool *pool)
>  
>  static int page_pool_release(struct page_pool *pool)
>  {
> +	bool in_softirq;
>  	int inflight;
>  
>  	page_pool_scrub(pool);
>  	inflight = page_pool_inflight(pool, true);
> +	/* Acquire producer lock to make sure producers have exited. */
> +	in_softirq = page_pool_producer_lock(pool);
> +	page_pool_producer_unlock(pool, in_softirq);

Is a compiler barrier needed to ensure compiler doesn't optimize away
the above code?

>  	if (!inflight)
>  		__page_pool_destroy(pool);
>  

